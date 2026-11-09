#!/usr/bin/env bash
# render.sh — convert resume_<JD-ID>.md to .html, .docx, .pdf
#
# Strategy: degrade gracefully. Always emit .md (it's the source). Try pandoc
# for .docx and .html. Without pandoc, build the .html with python3 instead
# (python-markdown if installed, else a built-in converter for the resume
# subset of markdown), so a PDF is still possible. Try Chrome / Chromium
# headless for .pdf, fall back to pandoc's pdf-engine if available, otherwise
# skip .pdf and tell the user.
#
# Usage:
#   render.sh <input.md> [output-dir] [css-path]
#
# If output-dir is omitted, files go alongside the input.
# If css-path is omitted, uses ../assets/resume.css from this script's location.

set -uo pipefail

INPUT="${1:-}"
if [[ -z "$INPUT" || ! -f "$INPUT" ]]; then
    echo "Usage: render.sh <input.md> [output-dir] [css-path]" >&2
    echo "Error: input markdown file required and must exist" >&2
    exit 1
fi

OUTPUT_DIR="${2:-$(dirname "$INPUT")}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CSS_PATH="${3:-$SCRIPT_DIR/../assets/resume.css}"

STEM="$(basename "$INPUT" .md)"
HTML_OUT="$OUTPUT_DIR/$STEM.html"
DOCX_OUT="$OUTPUT_DIR/$STEM.docx"
PDF_OUT="$OUTPUT_DIR/$STEM.pdf"

mkdir -p "$OUTPUT_DIR"

# Track what we emitted for the final report
declare -a EMITTED=("$INPUT")
declare -a SKIPPED=()

# --- HTML fallback when pandoc is missing ---
# Uses python-markdown if installed, otherwise a minimal built-in converter
# covering what resumes use: headings, bullet lists, paragraphs, **bold**,
# *italic*, `code` and [links](url). CSS is embedded so the file is portable.
render_html_without_pandoc() {
    python3 - "$INPUT" "$CSS_PATH" "$HTML_OUT" <<'PY'
import html
import re
import sys
from pathlib import Path

src, css_path, out = sys.argv[1:4]
text = Path(src).read_text(encoding="utf-8")
css = Path(css_path).read_text(encoding="utf-8") if Path(css_path).is_file() else ""


def inline(s):
    s = html.escape(s, quote=False)
    s = re.sub(r"`([^`]+)`", r"<code>\1</code>", s)
    s = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", s)
    s = re.sub(r"(?<![*\w])\*(?!\s)(.+?)(?<!\s)\*(?![*\w])", r"<em>\1</em>", s)
    s = re.sub(r"\[([^\]]+)\]\(([^)\s]+)\)", r'<a href="\2">\1</a>', s)
    return s


def convert(md):
    out_lines, para, in_list = [], [], False

    def flush_para():
        if para:
            out_lines.append("<p>" + inline(" ".join(para)) + "</p>")
            para.clear()

    def close_list():
        nonlocal in_list
        if in_list:
            out_lines.append("</ul>")
            in_list = False

    for raw in md.splitlines():
        line = raw.rstrip()
        heading = re.match(r"^(#{1,6})\s+(.*)$", line)
        item = re.match(r"^\s*[-*+]\s+(.*)$", line)
        if not line.strip():
            flush_para()
            close_list()
        elif heading:
            flush_para()
            close_list()
            level = len(heading.group(1))
            out_lines.append(f"<h{level}>{inline(heading.group(2))}</h{level}>")
        elif item:
            flush_para()
            if not in_list:
                out_lines.append("<ul>")
                in_list = True
            out_lines.append("<li>" + inline(item.group(1)) + "</li>")
        elif in_list and raw.startswith((" ", "\t")):
            # Continuation of the previous list item
            out_lines[-1] = out_lines[-1][: -len("</li>")] + " " + inline(line.strip()) + "</li>"
        else:
            close_list()
            para.append(line.strip())
    flush_para()
    close_list()
    return "\n".join(out_lines)


try:
    import markdown  # optional: python-markdown

    body = markdown.markdown(text)
except ImportError:
    body = convert(text)

title_match = re.search(r"^#\s+(.+)$", text, re.MULTILINE)
title = html.escape(title_match.group(1).strip()) if title_match else "Resume"
Path(out).write_text(
    "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"utf-8\">\n"
    f"<title>{title}</title>\n<style>\n{css}\n</style>\n</head>\n<body>\n{body}\n</body>\n</html>\n",
    encoding="utf-8",
)
PY
}

# --- Step 1: pandoc-based outputs (.html, .docx) ---
if command -v pandoc >/dev/null 2>&1; then
    # HTML with embedded CSS for portability
    if [[ -f "$CSS_PATH" ]]; then
        pandoc "$INPUT" \
            --standalone \
            --css="$CSS_PATH" \
            --embed-resources \
            -o "$HTML_OUT" 2>/dev/null \
            && EMITTED+=("$HTML_OUT") \
            || SKIPPED+=("$HTML_OUT (pandoc html failed)")
    else
        pandoc "$INPUT" --standalone -o "$HTML_OUT" 2>/dev/null \
            && EMITTED+=("$HTML_OUT") \
            || SKIPPED+=("$HTML_OUT (pandoc html failed)")
    fi

    # DOCX
    pandoc "$INPUT" -o "$DOCX_OUT" 2>/dev/null \
        && EMITTED+=("$DOCX_OUT") \
        || SKIPPED+=("$DOCX_OUT (pandoc docx failed)")
else
    SKIPPED+=("$DOCX_OUT (pandoc not installed)")
    if command -v python3 >/dev/null 2>&1; then
        render_html_without_pandoc \
            && EMITTED+=("$HTML_OUT") \
            || SKIPPED+=("$HTML_OUT (python3 html fallback failed)")
    else
        SKIPPED+=("$HTML_OUT (neither pandoc nor python3 installed)")
    fi
fi

# --- Step 2: PDF — prefer Chrome headless from HTML ---
if [[ -f "$HTML_OUT" ]]; then
    CHROME=""
    for candidate in \
        "google-chrome" \
        "google-chrome-stable" \
        "chromium" \
        "chromium-browser" \
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
        "/Applications/Chromium.app/Contents/MacOS/Chromium"; do
        if command -v "$candidate" >/dev/null 2>&1 || [[ -x "$candidate" ]]; then
            CHROME="$candidate"
            break
        fi
    done

    if [[ -n "$CHROME" ]]; then
        "$CHROME" \
            --headless \
            --disable-gpu \
            --no-sandbox \
            --print-to-pdf="$PDF_OUT" \
            --print-to-pdf-no-header \
            "file://$(realpath "$HTML_OUT")" 2>/dev/null \
            && EMITTED+=("$PDF_OUT") \
            || SKIPPED+=("$PDF_OUT (Chrome headless failed)")
    elif command -v pandoc >/dev/null 2>&1 && pandoc --list-output-formats 2>/dev/null | grep -q pdf; then
        # Fallback: pandoc's pdf-engine (requires LaTeX or wkhtmltopdf)
        pandoc "$INPUT" -o "$PDF_OUT" 2>/dev/null \
            && EMITTED+=("$PDF_OUT") \
            || SKIPPED+=("$PDF_OUT (pandoc pdf-engine failed — install Chrome or wkhtmltopdf)")
    else
        SKIPPED+=("$PDF_OUT (no Chrome/Chromium and no pandoc pdf-engine)")
    fi
else
    SKIPPED+=("$PDF_OUT (no .html to convert from)")
fi

# --- Report ---
echo "=== Render report for $STEM ==="
echo ""
echo "Emitted:"
for f in "${EMITTED[@]}"; do
    if [[ -f "$f" ]]; then
        size=$(wc -c < "$f" | tr -d ' ')
        echo "  ✓ $f ($size bytes)"
    fi
done

if [[ ${#SKIPPED[@]} -gt 0 ]]; then
    echo ""
    echo "Skipped:"
    for s in "${SKIPPED[@]}"; do
        echo "  ✗ $s"
    done
    echo ""
    echo "Hint:"
    if ! command -v pandoc >/dev/null 2>&1; then
        echo "  - Install pandoc: 'brew install pandoc' (Mac) or 'apt install pandoc' (Linux)"
    fi
    if [[ ! -f "$PDF_OUT" ]] && [[ -f "$HTML_OUT" ]]; then
        echo "  - For PDF without Chrome: open the .html in any browser and use Print → Save as PDF"
    fi
fi

# --- Page count estimate (if we have a PDF) ---
if [[ -f "$PDF_OUT" ]]; then
    if command -v pdfinfo >/dev/null 2>&1; then
        PAGES=$(pdfinfo "$PDF_OUT" 2>/dev/null | awk '/^Pages:/ {print $2}')
        if [[ -n "$PAGES" ]]; then
            echo ""
            echo "PDF page count: $PAGES"
        fi
    fi
fi

# Exit non-zero only if we couldn't emit even the markdown (we always can, since
# the input is the .md). So always 0 — the report tells the caller what's missing.
exit 0

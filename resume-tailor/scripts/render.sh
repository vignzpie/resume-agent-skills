#!/usr/bin/env bash
# render.sh — convert resume_<JD-ID>.md to .html, .docx, .pdf
#
# Strategy: degrade gracefully. Always emit .md (it's the source). Try pandoc
# for .docx and .html. Try Chrome / Chromium headless for .pdf, fall back to
# pandoc's pdf-engine if available, otherwise skip .pdf and tell the user.
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
    SKIPPED+=("$HTML_OUT (pandoc not installed)")
    SKIPPED+=("$DOCX_OUT (pandoc not installed)")
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

# ATS Detection & Optimization

ATS = Applicant Tracking System. Most JDs are funneled through one. Different ATSes parse resumes differently, prefer different formats, and reward different conventions. Detecting which one a JD uses is cheap and high-leverage.

## How to detect

In rough priority order:

### 1. Requisition ID prefix

The fastest signal. Common patterns:

| Pattern | ATS family | Notes |
|---|---|---|
| `R\d{4,6}` (e.g., R13927) | **Workday** (most common) | DOCX preferred; respects standard headings; weak on tables |
| `JR\d{4,6}` | **Workday** variant | Same as above |
| `\d{6,}` (raw 6+ digit job ID) | **Workday** or **Taleo** | Default to DOCX |
| `Job-\d+` or `Req-\d+` | **Greenhouse** or **Lever** | Both are forgiving on format |
| `WD\d+` | **Workday** | Explicit |
| `2024-\d+`, `25-\d+` | Often **internal / homegrown ATS** | Treat as Workday-equivalent |

### 2. Application URL

If the JD links to an apply URL, the domain is a giveaway:

- `*.myworkdayjobs.com` → Workday
- `boards.greenhouse.io` → Greenhouse
- `jobs.lever.co` → Lever
- `*.icims.com` → iCIMS
- `*.successfactors.com` → SAP SuccessFactors
- `*.taleo.net` → Taleo
- `careers.smartrecruiters.com` → SmartRecruiters
- `apply.workable.com` → Workable

### 3. Posting language

Some phrasings are characteristic:

- "Apply through Workday" / "Workday system" → Workday
- "Click 'I'm interested'" → Greenhouse-style
- "Upload your resume and complete the application" with multi-step form → Workday or Taleo

If none of the above hint at an ATS, default to assuming Workday — it's the most common and the most format-sensitive, so optimizing for it is the safest fallback.

## Per-ATS conventions

### Workday (most format-sensitive)

- **Format:** Strongly prefers `.docx`. PDFs are accepted but parsed less reliably.
- **Headings:** Use standard ones — "Experience" or "Work Experience", "Education", "Skills". Workday's parser keys on these.
- **Dates:** "Jan 2020 – Present" works best. Avoid "1/20 - now" or other compressed forms.
- **Tables:** Avoid in body sections. Workday flattens tables in unpredictable ways. Use simple bulleted lists.
- **Columns:** Single column. Two-column resumes mangle on Workday upload.
- **Bullets:** Use real bullet characters (•) or hyphens, not custom Unicode glyphs.
- **Job titles:** Match the JD's title language closely if defensible — Workday matches strings, not concepts.

### Greenhouse / Lever (forgiving)

- **Format:** Both .docx and .pdf parse reliably. PDF is fine.
- **Headings:** Standard ones still preferred but less critical.
- **Tables:** Generally OK in moderation.
- **Two-column:** Lever specifically tolerates two-column reasonably well; Greenhouse is hit-or-miss.

### Taleo (older, picky)

- **Format:** `.docx` strongly preferred. Plain text upload sometimes available — use it if offered.
- **Headings:** Old-school. Use "Professional Experience", "Education", "Technical Skills".
- **Special characters:** Avoid em dashes (—), curly quotes ("…"), anything non-ASCII. Replace with hyphens and straight quotes.
- **Tables, columns, headers/footers:** all unsafe. Keep it boring.

### iCIMS

- **Format:** `.docx` and `.pdf` both parse, .docx slightly preferred.
- **Field-by-field re-entry:** iCIMS often makes the user retype experience into form fields after upload. The resume parsing is for pre-fill — being parser-friendly saves the user time.

### SmartRecruiters / Workable / homegrown systems

- **Format:** Either works.
- **Treat as forgiving by default.** Optimize for human readability.

## Universal ATS rules (apply regardless of detected family)

These are conventions that increase parser reliability across all ATSes:

1. **Single column.** Two-column resumes look great in PDF but tokenize unpredictably for parsers.
2. **Standard headings.** "Experience", "Education", "Skills" — not "Where I've Been" or "What I Know".
3. **Consistent date format.** Pick one ("Jan 2020 – Mar 2023") and use it everywhere.
4. **No headers/footers.** Some parsers ignore them; some include them in the body. Not worth the risk.
5. **No images, no icons in body.** A photo at the top is fine in some geographies — most ATS parsers ignore it. Icons inline with body text break parsing.
6. **No text in shapes / text boxes / SmartArt.** Some parsers can't extract from these.
7. **Real bullet characters or hyphens** — not custom glyphs from icon fonts.
8. **Hyperlinks should also have visible text.** A link that says "click here" is invisible to ATS parsing; a link that says "github.com/username" works whether the link survives or not.
9. **Avoid headers in the document header region** — put the name and contact in the body, not in the .docx header.

## Keyword-density check (Phase 5 of the tailoring workflow)

The most common ATS-related miss is **word-order mismatch**. Examples:

- JD: "AWS Lambda" / Resume: "Lambda on AWS" — keyword miss for parsers that match phrases.
- JD: "machine learning" / Resume: "ML" — depends on parser; some normalize, some don't.
- JD: "RESTful APIs" / Resume: "REST APIs" — usually parses, but worth aligning.
- JD: "CI/CD" / Resume: "CI / CD" or "CICD" — variants exist; match the JD's exact form.

The Phase 5 check should:

1. List the JD's must-have keywords with their exact form (preserving case where the JD uses it).
2. For each, search the resume case-insensitively for the exact phrase.
3. Misses get patched by adjusting the closest existing bullet to use the JD's exact form.
4. Don't add bullets *just* to plant keywords — adjust phrasing in existing bullets so the keyword surfaces naturally.

## When ATS detection conflicts with human readability

The user is going to look at the resume too — and so will recruiters, hiring managers, and interviewers. Some ATS-friendly conventions hurt human readability if applied dogmatically (e.g., aggressively flat formatting can look bare).

The order of priority:

1. **Defensibility** — anything in the resume must be true and the user must be comfortable defending it.
2. **ATS parsability** — get past the screen.
3. **Recruiter scanability** — first 6-30 seconds.
4. **Hiring manager / interviewer interest** — they read more deeply.
5. **Visual polish** — looks good in PDF preview.

If a Workday-friendly format is also human-friendly, ship it. If they conflict, ship the ATS-friendly version for upload and offer a slightly more polished PDF for emailing — that's why the skill emits both formats.

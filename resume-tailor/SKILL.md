---
name: resume-tailor
description: Tailor a resume to a specific job description using the user's career_profile.md as the source of truth. Use this skill whenever the user wants to apply for a job, customize their resume, "make my resume fit this JD", "tailor for this role", "ATS-optimize", or asks for a resume targeting a specific company / requisition / posting. Also use when the user shares a job description (pasted, file, or URL) and asks what to do with it. Produces a markdown draft, runs an ATS keyword pass, renders to .docx and .pdf where possible, and offers to commit the result to git. Requires career_profile.md to exist — if it doesn't, hand off to career-profile-builder first.
---

# Resume Tailor

Take a job description and a career profile, produce a tailored resume in markdown, .docx, and .pdf. The whole workflow is roughly 15 minutes for a user who already has a profile. The skill orchestrates: JD analysis → gap scorecard → minimal targeted discovery → draft → ATS pass → render → optional git commit.

## Why this skill exists separately from career-profile-builder

The profile interview is exhausting and only happens occasionally. The tailoring workflow is fast and happens dozens of times. Different cadences, different mental models. Mashing them together means recurring users get re-asked profile questions every time, which is the worst-of-both-worlds.

This skill assumes the profile already exists. If it doesn't, the skill stops and points the user at `career-profile-builder` — it does not try to do a profile interview from inside a tailoring session.

## Output contract

For each tailoring session, the skill produces (in the user's chosen working directory):

1. `resume_<JD-ID>.md` — the canonical source-of-truth for this tailored version
2. `resume_<JD-ID>.docx` — pandoc-rendered, ATS-friendly (the recruiter / ATS upload format)
3. `resume_<JD-ID>.pdf` — for emailing to humans (the "looks good in preview" format)
4. `resume_<JD-ID>.html` — the intermediate (kept around because it's free and useful)

All four files share a stem so they're easy to diff, version, and find. `<JD-ID>` is the user-supplied or auto-detected requisition ID (e.g., `R13927`). If no ID is available, fall back to `<role-slug>_<YYYY-MM-DD>` — e.g., `senior-platform-eng_2026-04-28`.

If pandoc is missing, the skill emits `.md` and `.html` only and tells the user what they're missing. See "Rendering" below.

## Required inputs

- A **career profile** file — typically `career_profile.md` in the current directory. The skill reads this first and refuses to proceed without it (see "Profile preflight" below).
- A **job description** — pasted into chat, supplied as a file path, or a URL the user wants fetched.
- (Optional) An **output directory** — defaults to the current working directory.
- (Optional) A **page-count target** — defaults to 2.

## Profile preflight (do this first, every session)

Before doing anything else:

1. Look for `career_profile.md` in the user's working directory (or the path they specified).
2. If found, read it fully into context. The Sections 17-19 (Achievements Bank, Known Gaps, Pre-built Framings) are non-optional reading — they govern what the tailor can and cannot claim.
3. If not found, stop. Tell the user:
   > I need a career profile to tailor against. The `career-profile-builder` skill walks you through building one — it takes 30-45 minutes the first time, and after that resumes are 15 minutes each. Want to start that now?
4. If found but very thin (no Section 5 deep-dives, empty Achievements Bank), tell the user:
   > I found `career_profile.md` but it looks light — there's not much in the Achievements Bank or experience deep-dive. I can still tailor, but the result will be generic. Want to expand the profile first, or push through with what we have?

## The tailoring workflow

### Phase 1 — JD ingestion (~1 min)

Read the JD. Extract:

- **Requisition ID** (look for `R\d+`, `JR\d+`, `\d{6,}`, or "Job ID" / "Req #" labels). If found, use as `<JD-ID>`.
- **Role title** and **seniority signal** (intern / junior / senior / staff / principal / director).
- **Geography** (city / country / remote-OK).
- **Must-have requirements** (usually under "Qualifications", "Requirements", "Must have").
- **Nice-to-haves** (under "Preferred", "Bonus", "Plus").
- **Keywords by frequency** — a flat list of technical terms / domain terms / methodologies, with rough frequency.
- **ATS family hint** — see `references/ats-detection.md`. R-prefix often means Workday → DOCX preferred. Greenhouse and Lever are forgiving on format.
- **Compensation / visa / clearance** signals if present (these don't go in the resume but matter for fit calibration).

Show the user a 4-6 line summary of what you extracted and ask "does this match what you're applying for?" before proceeding. Cheap insurance against parsing errors.

### Phase 2 — Gap scorecard (~1 min)

Build a side-by-side: JD requirements (left) vs. profile evidence (right). For each must-have, mark:

- ✅ **Strong evidence** — there's an explicit project, metric, or achievement in the profile that matches.
- 🟡 **Adjacent evidence** — the profile shows something close but not exact (e.g., JD wants Kubernetes, profile shows Docker Swarm).
- ❌ **No evidence** — nothing in the profile speaks to this requirement.

Show the scorecard to the user. This is the moment to catch:
- Profile sections that need a deep-dive (🟡 entries that the user *does* know about but never wrote down)
- True gaps that the user shouldn't pretend to have (❌ entries — these may belong in the cover letter as "I'm interested in learning" rather than the resume)

### Phase 3 — Targeted discovery (~5 min, only if needed)

For each 🟡 entry that has follow-up potential, ask 1-2 focused questions. Cap total questions at 5 across the session. The point is to fill gaps without re-doing the whole profile interview.

Examples of good targeted questions:
- "JD asks for Kafka experience. Your profile mentions 'event-driven architecture at Krogo' — was Kafka involved? At what scale?"
- "The role wants OAuth/OIDC depth. You have JWKS in the profile — was that part of an OIDC flow, or homegrown?"

After getting answers, **append them to the profile** in the appropriate section (don't write them only into the resume). This means next time you tailor, the profile is richer. This is a key compounding-value loop.

### Phase 4 — Draft (~2 min)

Write `resume_<JD-ID>.md`. The structure is:

```
# <Name>
<Headline tailored to the JD's role title — pull from Section 17 framings if available>
<Location · Email · Phone · LinkedIn · GitHub>

## Summary
<3-4 sentence summary that plants the JD's top 3 keywords naturally>

## Skills
<Categorized list. Front-load JD must-haves. Group by category, not by alphabet.>

## Experience
### <Most recent role title> @ <Company> (<Dates>)
- <3-5 bullets, JD-keyword-front-loaded, achievement-focused, quantified where the profile has numbers>

### <Next role…>
- <…>

<Older roles compress to 1-2 bullets each, or one line if very old.>

## Education
<As in profile — usually one line per degree>

## Certifications (if relevant to JD)
<…>

## (Optional sections, keyed on relevance to JD)
- Projects (if early-career or career-switcher)
- Publications / Talks (if research / senior IC)
- Open source (if engineering / dev-tools)
- Languages (only for geographies where it matters — drop for US/global)
```

**Drafting rules** (these are the invariants that make tailored resumes good):

- **Plant JD keywords in summary, skills, and the first bullet of the most recent role.** Most ATS systems weight position; keywords on page 1 above the fold matter most.
- **Use the user's voice from Section 17** — don't normalize bullets into corporate-speak the user wouldn't recognize.
- **Respect Section 19 framings VERBATIM** — these are the user's approved phrasings for sensitive topics. Do not paraphrase. Do not "improve" them.
- **Respect Section 18 gaps** — never claim something the gap section flags. Adjacent framings are fine ("aligned with X" instead of "certified in X"); fabrication is not.
- **Quantify only with numbers from the profile.** If a number isn't there, don't invent one. Qualitative phrasing ("meaningfully reduced incident rate") beats fake precision.
- **Match the JD's language for shared concepts.** If the JD says "platform engineering" and the profile says "infrastructure platform", use "platform engineering" in the resume — semantic match for ATS, recruiter recognition, and the user can defend it because the profile shows it's the same thing.
- **Cut older roles aggressively at senior levels.** A 15-year veteran's first job out of school is a one-liner.

For more detail on bullet-writing patterns, see `references/bullet-patterns.md`.

### Phase 5 — ATS pass (~1 min)

After the draft, run a keyword-density check:

1. Take the JD's must-have list from Phase 1.
2. For each must-have, search the resume for exact-phrase match (case-insensitive). Word order matters — "AWS Lambda" is not the same as "Lambda on AWS" to most ATS parsers.
3. Flag any misses. Patch by adjusting wording in the closest existing bullet (don't add new bullets just to plant keywords).
4. Re-run the check. Most resumes converge in one patch round.

For more on ATS specifics (Workday, Greenhouse, Lever, Taleo, etc.), see `references/ats-detection.md`.

### Phase 6 — Render (~1-2 min)

Convert the markdown to .html, .docx, and .pdf. The strategy degrades gracefully based on what's installed:

```
[markdown source]
       │
       ├── always: write resume_<JD-ID>.md
       │
       ├── if pandoc: pandoc → resume_<JD-ID>.docx
       │              pandoc + resume.css → resume_<JD-ID>.html
       │
       │   if Chrome / Chromium: html → resume_<JD-ID>.pdf (headless print)
       │   else if pandoc has --pdf-engine: pandoc → resume_<JD-ID>.pdf
       │   else: skip pdf, tell user
       │
       └── if no pandoc: python3 → resume_<JD-ID>.html with embedded CSS
                          (then Chrome → .pdf as above)
                          tell user: "install pandoc for .docx"
```

The render details (exact pandoc invocations, CSS file, Chrome headless flags) are in `scripts/render.sh`. Use that script — don't reinvent.

After rendering, **report the page count** of the .pdf (or .html if no pdf). If it's over the user's target (default 2), enter the compression loop.

### Phase 7 — Compression loop (only if over target)

Don't auto-cut. Suggest cuts in priority order, ask the user before each:

1. **Drop Languages section** — usually safe for US / global roles, keep for India / EU / multi-lingual orgs.
2. **Compress oldest job(s) to one line** — title + company + dates + one-line summary.
3. **Drop Education extras** (GPA, coursework, thesis) for users with 5+ years experience.
4. **Tighten skill list** — drop categories the JD doesn't ask about.
5. **Trim second-tier bullets** in older roles — keep the strongest one, drop the rest.
6. **Tighten typography** — adjust margins / line-height in the CSS. Buys ~30% page count without losing content. (Show the user the before/after; don't apply silently.)

After each round, re-render and report the new page count.

### Phase 8 — Versioning & git (~1 min)

Once the user is happy with the rendered output, ask about persistence:

> Want me to commit this version? I can:
> 1. Just save it (overwrite next time you tailor for the same JD)
> 2. Version it: `resume_<JD-ID>_<YYYYMMDD-HHMM>.md`
> 3. Commit to git with a message like "Tailored resume for <JD-ID>"

Default suggestion: **prompt for git, suggest a filename of `<role-slug>_<YYYY-MM-DD>` if no JD-ID is available, fall back to timestamp if both are absent.**

If the user says yes to git but the directory isn't a git repo, ask if they want to `git init` it. If it is a repo, just commit (don't push — let the user decide when to push).

### Phase 9 — Handoff (~1 min)

Tell the user explicitly:
- **The .docx is ATS-ready** — upload this to Workday / Greenhouse / etc.
- **The .pdf is recruiter-ready** — attach this to emails or recruiter follow-ups.
- **Open the .docx in Word for final visual polish** — the user's eye for layout will beat pandoc's auto-output. The skill does the content; the user owns the polish.

If the user mentions any final tweaks they want to make in Word, capture those as deltas and offer to round-trip through `pandoc -t markdown` if they want to compare what they changed vs. what the skill emitted.

## Multi-JD batching

If the user provides multiple JDs in one session ("tailor for these 3 roles"), do Phase 1-2 across all of them in a single comparison pass first — this surfaces the *common* must-haves (keywords to plant in every version) and the *role-specific* must-haves (the differentiators). Then do Phases 3-9 per JD.

The user gets one set of files per JD: `resume_<JD-ID-1>.{md,docx,pdf}`, `resume_<JD-ID-2>.{md,docx,pdf}`, etc.

## Invariants

These rules are non-negotiable across all tailoring sessions:

- **NEVER fabricate a metric, technology, or fact.** If the profile doesn't have it, don't write it.
- **NEVER override a Section 19 framing** from the profile. Those are the user's approved words for sensitive topics.
- **NEVER skip the ATS pass.** Word-order misses are the most common loss in tailored resumes — catching them is the highest-leverage step.
- **ALWAYS save outputs alongside the JD** when a JD file path was given. If the user pointed at `~/jobs/proofpoint/R13927.txt`, the outputs go to `~/jobs/proofpoint/`.
- **ALWAYS report page count** after rendering. If over target, suggest cuts before the user has to ask.
- **ALWAYS preserve the markdown source.** It's the diff-friendly version. Even if the user asks for "just the .docx", emit the .md.

## Common failure modes and how to handle them

**The profile is missing or thin.** Stop. Hand off to career-profile-builder. Don't try to fake it.

**The JD is vague (e.g., "looking for a great engineer").** Ask the user one clarifying question — what specifically about *this* role? — and use their answer to pick framing. If they don't know either, default to the user's strongest profile section.

**Pandoc isn't installed.** Don't fail. Emit `.md` and `.html` with embedded CSS. Tell the user what's missing and how to fix it (e.g., `brew install pandoc` on Mac).

**Resume is 4 pages on first render.** Don't panic-cut. Run Phase 7 with the user — content cuts are the user's call.

**JD has unrealistic requirements.** Don't try to match every line. Match the must-haves; drop the nice-to-haves the user genuinely doesn't have. The cover letter (a separate skill if available) is where stretch interest goes.

**User's existing Word version is better than yours.** Common at the polish stage. Round-trip the user's `.docx` through pandoc to see what they changed, learn from it, and don't re-emit the same problems on the next tailor.

## When to delegate vs. do it yourself

- **DOCX/PDF actual file mutation** — use Anthropic's `docx` and `pdf` skills if available; they ship with scripts/ that handle the file format details. Otherwise the bundled `scripts/render.sh` is the fallback.
- **Anything else (JD parsing, gap analysis, drafting, ATS check, compression suggestions)** — do it yourself, in this skill. The orchestration is light enough that delegating to other skills adds latency without adding value.

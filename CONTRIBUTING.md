# Contributing

Thanks for your interest. These skills are deliberately small and opinionated, so contributions land best when they extend the surface area without changing the core philosophy:

- **The profile is the asset.** Resumes are derivatives. Anything that strengthens the profile compounds; anything that bypasses it is a step backward.
- **Honesty over keyword-stuffing.** The skills explicitly refuse to fabricate. If a contribution makes it easier to over-claim, it doesn't fit.
- **Branch by experience and track.** Generic resume advice is everywhere; this project's value is in calibrated questioning.

## Where contributions are most welcome

### 1. New track question banks

The current branching-questions reference covers: engineering, EM, PM, design, DS/ML, marketing, sales, ops/PgM/CS, and academia. Tracks that would help:

- Healthcare (clinical, research, admin)
- Legal (in-house, firm, judicial)
- Finance (IB, PE, public-markets, FP&A)
- Education (K-12, higher-ed, ed-tech)
- Skilled trades and field roles
- Public sector
- Creative (writing, film, music — these have unusual artifact conventions)

The format is in [`career-profile-builder/references/branching-questions.md`](career-profile-builder/references/branching-questions.md). Each track gets:

- 4-5 question categories (scope, depth, impact, ownership — or the track's equivalents)
- Experience-level callouts (junior → senior → exec)
- Verb / vocabulary notes specific to the track

### 2. ATS-detection improvements

`resume-tailor/references/ats-detection.md` covers Workday, Greenhouse, Lever, Taleo, iCIMS, SmartRecruiters, Workable. Gaps:

- Non-US ATSes (NaukriRMS in India, JobAdder in AU/UK, Personio in DE, Recruitee in EU)
- Industry-specific systems (epic-style hospital systems, government USAJobs, university-faculty systems)
- Detection heuristics from JD text patterns, not just URLs

### 3. Render-pipeline alternatives

The current render script is pandoc + Chrome headless. Alternative engines worth supporting (as fallbacks, not replacements):

- WeasyPrint (Python, often available where pandoc isn't)
- wkhtmltopdf (legacy but widely installed)
- Native macOS `cupsfilter` for Mac-only setups
- LibreOffice headless for users who already have it

PRs welcome that extend `scripts/render.sh` with additional fallback paths. Keep the existing degradation order; add at the bottom.

### 4. Test cases

Real-world test cases — anonymized — are gold. The format that's most useful:

```
examples/<short-name>/
├── jd.txt              # The job description
├── profile.md          # The career profile (anonymize specifics)
├── resume.md           # What the skill produced
└── notes.md            # What was good, what was wrong, what would you change
```

A handful of these covering different tracks and seniority levels makes the skill verifiably better over time.

### 5. Bug reports for failure modes

If the skill produces a bad output, file an issue. Useful issues include:

- The JD (or a sanitized version)
- The relevant section of your `career_profile.md` (anonymize PII)
- The resume that came out
- What was wrong about it
- What you'd expect instead

We do NOT need credentials, real names, or real employers — anonymize freely.

## Code-style notes

- **No new dependencies in `scripts/render.sh`** unless they're widely available and gracefully optional.
- **No external API calls** from inside the skills. Everything happens in the user's Claude session and on their disk. (Optional connectors that the user opts into are fine — but they go through the standard Claude MCP / connector mechanism, not custom HTTP from inside a script.)
- **SKILL.md files stay under ~600 lines.** If a skill is getting too long, split content into a `references/` file and add a pointer.
- **Markdown only in references.** No JS, no HTML, no executable code in reference files. They get loaded into the model's context — keep them grep-able and diff-able.

## Pull request checklist

- [ ] Skills still validate (run `python -m scripts.quick_validate <skill-path>` from the skill-creator scripts if you have them, or just check that frontmatter has `name` and `description`)
- [ ] No new external network calls
- [ ] Reference files under 500 lines each (split if larger)
- [ ] If you added a track, the experience-level callouts are present
- [ ] If you added an ATS, the detection heuristics are explained
- [ ] README's keyword list and topics list updated if relevant
- [ ] CHANGELOG.md entry added under "Unreleased"

## Issues vs. discussions vs. PRs

- **Issue** — a bug, a missing feature, a concrete proposal
- **Discussion** — open-ended ideas, "should we…" questions, strategy
- **PR** — code or content change you want merged

Don't open a PR for a major change without a discussion or issue first — saves rework.

## Code of conduct

Be kind, be specific, assume good faith. If you wouldn't say it to a colleague at a whiteboard, don't say it in a PR comment.

## License

By contributing, you agree your work is licensed under the [MIT License](LICENSE).

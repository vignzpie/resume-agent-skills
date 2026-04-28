# Provenance

These skills come out of a specific real session: a 4-hour resume-tailoring exercise for a senior cloud-security engineering role in April 2026. The session was not designed as research — it was someone trying to apply for a job. The patterns that worked were captured in a session recap immediately afterward and codified here.

## What the original session looked like

```
Phase A — Triage 5 JDs (~10 min)
Phase B — Resume v1 (~20 min)
Phase C — Discovery deep-dive #1: secrets/auth (~15 min)
Phase D — Discovery deep-dive #2: team/scope context (~10 min)
Phase E — Discovery deep-dive #3: compliance, cloud, headcount (~10 min)
Phase F — Source-of-truth literature dump (~15 min)  ← career_profile.md born here
Phase G — Reminder side-quest (~5 min, off-topic)
Phase H — Skill discovery & install (~25 min)
Phase I — Document rendering (~15 min)
Phase J — ATS optimization (~25 min)
Phase K — User takeover + iteration (~80 min in Word)

Total: ~4 hours
```

The session ended with a 2-page tailored resume the user shipped, plus an unexpected by-product: a 19-section `career_profile.md` that was generalizable to other roles.

## What we kept

The patterns that survived from session → skill design:

| Session pattern | Where it lives in the skills |
|---|---|
| Three rounds of discovery | `career-profile-builder` Pass 2 (achievement deep-dive), and `resume-tailor` Phase 3 (targeted discovery, only for gaps) |
| 19-section profile structure | `career-profile-builder/references/profile-template.md` |
| Achievements Bank as raw material | Section 17 of profile; bullet-patterns reference shows how it flows into resume bullets |
| Known Gaps as a safety rail | Section 18 of profile; `resume-tailor` invariants enforce respect for it |
| Pre-built Framings (verbatim) | Section 19 of profile; `resume-tailor` uses these unmodified |
| pandoc + Chrome headless rendering | `resume-tailor/scripts/render.sh` |
| ATS keyword-density check (with word-order matching) | `resume-tailor` Phase 5 + `references/ats-detection.md` |
| Page-count compression as user-driven, not auto-cut | `resume-tailor` Phase 7 — suggests cuts in priority order, asks before each |
| Naming convention `resume_<JD-ID>.md` | `resume-tailor` output contract |
| User-finishes-in-Word handoff | `resume-tailor` Phase 9 — explicit guidance |

## What we discarded or simplified

| Original choice | What we changed |
|---|---|
| Installed 7 community skills + 2 Anthropic skills (9 total) | Two skills only. The orchestration was light enough that fragmenting it across 7 dependencies added latency without adding clarity. |
| Used a research subagent to find existing skills | Skipped — by the time you have these two skills, you don't need the others for the core flow. |
| Memory file at `~/.claude/projects/...` pointing to the profile | Skipped — the skill assumes the profile is in the working directory. Memory is a Claude Code-specific feature; the skills are designed to work without it. |
| `/schedule` skill for reminder side-quest | Out of scope — that was a side-quest, not part of the resume flow. |
| Manual flattening of community skill repo layouts | Not needed since we don't depend on community skills. |

## What we added that wasn't in the session

| Addition | Why |
|---|---|
| Branching by experience level (5 buckets) | Session was for one experienced engineer; new grads, mid-career, and execs need different question banks. |
| Branching by track (10 tracks) | Session was for a SWE; design, PM, DS, marketing, sales, ops, academia have different vocabularies. |
| Graceful degradation in render.sh | Session assumed pandoc and Chrome were installed; not all users will have them. |
| ATS-family detection | Session noted "R-prefix → likely Workday" as a tip; we made it a Phase 1 step. |
| Versioning prompt (overwrite / suffix / git) | Session overwrote silently and lost v1 framings; we ask now. |
| Mandatory profile preflight | Session built the profile organically; the skill design makes profile-first explicit and refuses to tailor without one. |

## The one-line summary

Two skills that turn a directory of raw job descriptions into a tailored, ATS-optimized 2-page resume *and*, more importantly, into a permanent profile that makes the next role take 15 minutes instead of 4 hours.

## Honest limitations

These skills are opinionated. They don't try to do everything:

- **No interview coaching, no negotiation help, no salary research** — those are different workflows on the same source-of-truth, and would warrant separate skills.
- **No portfolio site / personal-brand work** — same.
- **No applicant-tracking analytics** — Jobscan and Rezi do this well; we don't compete there.
- **No design-heavy templates** — these skills produce ATS-friendly resumes, which means single-column, standard-heading, no-images output. Designers who want a visual portfolio resume should use a tool built for that.

The skills are most useful for people who are doing job applications semi-frequently and want compounding value across applications. For someone applying once every five years, this might be more setup than the job-search is worth.

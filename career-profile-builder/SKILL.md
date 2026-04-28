---
name: career-profile-builder
description: Build a comprehensive career profile (career_profile.md) through a structured interview that adapts to the user's experience level and career track. Use this skill whenever the user wants to "build a resume from scratch", "start fresh", "create my professional profile", "I don't have a resume yet", or when the resume-tailor skill needs a profile and none exists. Also use when the user wants to refresh, expand, or update their existing career_profile.md after a job change, promotion, new project, or new skill. The output is a reusable source-of-truth that the resume-tailor skill consumes for every future job application — so it should be thorough and honest, not surface-level.
---

# Career Profile Builder

A career profile is a long-form, honest, comprehensive document about a person's professional life. It is not a resume. A resume is a tailored, 1-2 page output for one specific job. The profile is the superset that makes every future resume cheap to produce.

## Why this skill exists

Most resume tools ask three flat questions and produce a generic resume. The reason resumes feel generic is the discovery is shallow. The user's best material — the JWKS verification work, the "we ran 242 services across two platforms" number, the "we went from 14 to 4 engineers and shipped more" inflection — never gets surfaced because nobody asks the right follow-up question.

This skill exists to do the deep interview once, write it down once, and let every future tailored resume draw from it.

## Output contract

The skill produces ONE primary artifact: `career_profile.md`, in a directory the user picks (default: current working directory).

The file has this structure. Sections that don't apply can be empty or omitted, but keep the numbering stable so future tools can find sections:

```
1.  Identity (name, location, contact, links — LinkedIn / GitHub / portfolio)
2.  Headline & target roles (1-3 target role titles, IC vs. mgmt track, geography)
3.  Summary (3-5 sentence narrative the user agrees with)
4.  Experience snapshot (a one-line per role table for quick scanning)
5.  Experience deep-dive (per role: scope, stack, projects, metrics, what shipped)
6.  Education
7.  Certifications
8.  Technical skills (grouped — languages, frameworks, infra, tooling, domain)
9.  Domain expertise (security, ML, payments, etc. — the substantive areas)
10. Leadership & people (team sizes, mentorship, hiring, cross-team)
11. Open source / public artifacts (talks, papers, OSS, patents, blog)
12. Languages spoken (human languages — relevant for some geographies)
13. Awards & recognition
14. Volunteer / community
15. Interests (only if the user wants them — many seniors omit this)
16. Visa / work authorization status (only if relevant to target geography)
17. Achievements bank (a flat list of "things worth bragging about" — the
    raw material that gets quoted in tailored resume bullets)
18. Known gaps (things the user is uncertain about claiming, or doesn't have
    — e.g., "PCI work was regex-based, not formally certified")
19. Pre-built framings (sentences the user has approved for sensitive topics
    — e.g., "frame my compliance work as 'aligned with PCI-DSS intent', never
    as 'PCI-DSS certified'")
```

Sections 17-19 are what make this profile durable. An achievements bank lets the tailor pick the right bullet for each JD without re-asking. Known gaps and pre-built framings prevent embarrassment in interviews and prevent the tailor from over-claiming.

## The interview flow

The interview is structured but not a rigid script. Think of it as four passes that go from breadth to depth.

### Pass 0 — Triage (~2 minutes)

Before any deep questions, calibrate. Ask the user, conversationally, in roughly this order:

1. Years of professional experience? (rough bucket: <1, 1-4, 5-9, 10-15, 15+)
2. Current role title and target role title (or "exploring")
3. Geography: where you are now, where you're applying
4. IC track, management track, or hybrid?
5. Do you have an existing resume to import, or starting blank?
6. Career switcher? If yes, from what to what?

These answers select the **track** that drives the rest of the interview. See `references/branching-questions.md` for the full track-by-track question banks. The triage answers are what you use to pick the track — don't try to read them again later.

If an existing resume is provided (pasted, uploaded, or referenced as a file), parse it first and use it to **pre-fill** sections so you don't ask the user things they already wrote down. Then the interview is about filling gaps and going deeper, not about collecting basic facts.

### Pass 1 — Skeleton (~10 minutes)

Build the scaffolding fast. Walk reverse-chronologically through jobs. For each role, collect only:
- Company, title, dates, location
- Team size and your position in it
- Tech stack
- One sentence on what the team did

Don't go deep yet — this pass exists so the user can see the shape forming and you can see which roles are likely to need deep-dives. Save this as Sections 1-4 plus a thin Section 5.

### Pass 2 — Achievement deep-dive (~15-25 minutes)

This is where most of the value comes from. For each meaningful role (typically the most recent 2-3, plus any earlier role with a standout project), do branching follow-ups. The branching is keyed on track; see `references/branching-questions.md` for the question bank.

The general shape across all tracks:
- "What's the thing you built / led / shipped that you're most proud of in this role? Walk me through it."
- Probe for **scope** (users, services, revenue, headcount, geography)
- Probe for **technical depth** appropriate to the track (architecture decisions for engineers; experiments and lift for PMs; campaigns and CAC for marketing)
- Probe for **cross-functional work** (other teams, stakeholders, customers)
- Probe for **mentorship / influence** (especially for senior tracks)
- Probe for **before vs. after metrics** ("what was true before you started? what was true when you left?")

Two things matter here that don't matter in other passes:

**Honesty calibration.** When a user says something like "we did PCI compliance," follow up: "did you formally certify it, or did you just hit the relevant controls? How comfortable are you defending that claim in an interview?" Capture both the claim AND the comfort level. The comfort level becomes a Section 18 entry or a Section 19 framing.

**Quantification, not invention.** If the user doesn't know a number, don't invent one. Ask: "do you have an estimate? a range? what's a number you'd be comfortable saying out loud?" If they genuinely don't know, leave it qualitative — "reduced incident rate meaningfully" beats a fabricated "47% reduction" that crumbles in an interview.

### Pass 3 — Coverage sweep & framings (~5-10 minutes)

After the deep-dive, do one quick sweep for sections that are still thin:
- Education, certifications, languages spoken
- Public artifacts: talks, papers, OSS, patents, published writing
- Awards
- Visa / work auth (only if target geography requires it)

Then explicitly ask the two profile-defining questions:

1. **"Anything you do well but feel uncomfortable claiming on a resume?"** — these become Section 18 entries.
2. **"Anything you've talked yourself into a good framing for?"** — these become Section 19 entries. Capture the user's exact words.

## Adapting to experience level

The interview's **emphasis** changes by experience level even when the structure is constant. Treat these as guidance for what to push on, not as a rigid script:

- **Student / new grad (<1 yr):** projects, internships, coursework that's actually relevant, hackathons, leadership in clubs. GPA only if strong (>3.5/4 or >8.0/10). The Experience deep-dive is light; the Education and Achievements Bank carry more weight. Functional/skills-first format will likely be best.

- **Early career (1-4 yrs):** real projects with metrics, technologies actually used in production (not just listed on a tutorial), scope of ownership. Push hard on "what did you decide vs. what did someone tell you to do" — early-career resumes often hide ownership behind passive voice.

- **Mid career (5-9 yrs):** cross-team work, technology choices made and the reasoning, business impact, mentorship of juniors, complexity of systems owned. This is where most users will land.

- **Senior (10-15 yrs):** architecture decisions at meaningful scale, org-wide influence, hiring and mentoring at scale, strategic wins. Older roles compress to one line — push the user to identify which 2-3 roles deserve full deep-dives and which collapse.

- **Staff / Principal / Exec (15+):** org design, cross-org initiatives, P&L or platform-level outcomes, public artifacts (talks, patents, OSS, publications). Three pages is often appropriate; lead with an impact summary. Compression of older roles is mandatory.

For the full set of branching questions per track and per level, read `references/branching-questions.md` BEFORE starting Pass 2. The reference file is organized by track family (engineering, product, design, marketing, sales, ops, academia, other) with experience-level callouts inside each.

## Adapting to track

Year-count is one axis; track is the other. The branching questions are organized by track because a senior PM and a senior SWE have completely different bullet vocabularies. The triage step picks the track. If the user is hybrid (e.g., engineering manager), ask them which track's vocabulary their target role uses and lead with that, then layer in the other.

If the user's track isn't listed in the branching-questions reference, fall back to the generic deep-dive prompts and let the user's domain language guide the follow-ups. Don't pretend you know an industry you don't.

## Invariants

These rules apply across all interviews and all tracks. They exist because they came up as problems in real sessions.

- **NEVER invent metrics or facts.** If the user doesn't know, write down what they DO know and flag the rest as a gap in Section 18.
- **NEVER override the user's framing once captured in Section 19.** If the user said "frame this as 'aligned with' not 'certified'", subsequent tailored resumes must respect that.
- **NEVER conflate collaboration with ownership.** If the user worked *with* the cloud team, write "partnered with cloud-governance team on X" — not "owned cloud governance".
- **ALWAYS ask before assuming a number.** "You mentioned 200ish services — should I write 200, 200+, or do you want to check?"
- **ALWAYS save the profile as `career_profile.md`** in the directory the user picked, and confirm the path back to them when done.
- **ALWAYS write the profile in the user's voice.** Don't normalize their phrasing into corporate-speak — the profile is internal. Polish happens at tailoring time.

## Confirmation pattern

After Pass 1, show the user the skeleton and ask "does this look right before we go deeper?" Don't power through to Pass 2 silently. The user catches naming, dates, and team-size errors most cheaply at this point.

After Pass 3, show the full profile structure (just section headers and one-line summaries) and ask "anything missing or wrong before I save?"

## When the user already has a profile

If `career_profile.md` already exists in the target directory, don't blow it away. Read it, then ask the user what they want to do:
- Add a new role / project / cert
- Refresh a specific section
- Full re-interview (rare — usually they want a targeted update)

Make the targeted change, re-write only the affected sections, leave the rest alone.

## Handing off to resume-tailor

When the profile is done and saved, tell the user explicitly:

> Profile saved to `<path>/career_profile.md`. From here on, when you want to apply for a role, use the `resume-tailor` skill — it'll read this profile and a job description and produce a tailored resume. You'll only need to come back here if your career changes (new role, new project, new cert) or you find a section that needs more depth.

Do not invoke the resume-tailor skill in the same session unless the user explicitly asks — the profile interview is exhausting enough.

# Architecture

How the two skills work together, and why the work is split this way.

## Two skills, not one, not seven

The most common alternative architectures are:

1. **One mega-skill** that does everything — easy to invoke, hard to maintain, blurs the cold-start vs. recurring distinction.
2. **Many atomic skills** — JD analyzer, bullet writer, quantifier, ATS optimizer, cover-letter generator, render pipeline. Easy to maintain individually, but the user has to know which to invoke when, and the orchestration becomes a problem they have to solve.
3. **Orchestrator + atomic skills** — a thin top-level skill that delegates to many sub-skills. Clean architecture, but every sub-skill is independently maintained, and the latency of cross-skill handoffs adds up.

We chose **two skills** because the work has exactly two cadences:

| Cadence | Frequency | Time | Mental model |
|---|---|---|---|
| Profile building | Once, then occasional updates | 30-45 min | Long-form interview, exhausting |
| Resume tailoring | Every job application | ~15 min | Fast, mostly assembly |

Mashing them together means recurring users get re-asked profile questions every time. Splitting further (into JD analyzer + bullet writer + ATS optimizer + …) adds orchestration overhead without adding cadence-level distinctions.

## Data flow

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│   ┌──────────────────────────┐                          │
│   │ career-profile-builder   │  Run once + occasional   │
│   │                          │  refreshes               │
│   │ Triage → Skeleton →      │                          │
│   │ Deep-dive → Coverage     │                          │
│   └────────────┬─────────────┘                          │
│                │                                        │
│                ▼                                        │
│   ┌──────────────────────────┐                          │
│   │ career_profile.md        │  ← The asset.            │
│   │ (19 sections)            │     Compounds over time. │
│   └────────────┬─────────────┘                          │
│                │                                        │
│                ▼                                        │
│   ┌──────────────────────────┐                          │
│   │ resume-tailor            │  Run per job application │
│   │                          │                          │
│   │ JD ingest → Gap          │                          │
│   │ scorecard → Targeted     │                          │
│   │ discovery → Draft →      │                          │
│   │ ATS pass → Render →      │                          │
│   │ Compress → Version       │                          │
│   └────────────┬─────────────┘                          │
│                │                                        │
│                ▼                                        │
│   ┌──────────────────────────┐                          │
│   │ resume_<JD-ID>.{md,docx, │  ← The deliverable.      │
│   │ pdf,html}                │     Disposable.          │
│   └──────────────────────────┘                          │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

A key design decision: **`resume-tailor` writes back to `career_profile.md`.** When Phase 3 (Targeted Discovery) surfaces something the user knew but never wrote down, that answer is appended to the profile in the appropriate section. This makes the profile richer with each tailoring session — by the third or fourth JD, "tailoring" is mostly assembly because the profile already has the material.

## Module map

```
career-profile-builder/
├── SKILL.md                          ─┐
│   - Workflow (4 passes)              │
│   - Output contract (19 sections)    │  Always loaded when skill triggers
│   - Invariants                       │
│   - Adapting to experience / track  ─┘
│
└── references/
    ├── branching-questions.md        ─┐
    │   - Universal opener             │
    │   - 10 tracks × 4-5 categories   │  Loaded on demand during Pass 2
    │   - Per-experience-level callouts│
    │
    └── profile-template.md           ─┐
        - Canonical 19-section format  │  Loaded when emitting the file
        - Field-level guidance        ─┘

resume-tailor/
├── SKILL.md                          ─┐
│   - 9-phase workflow                 │
│   - Output contract                  │  Always loaded when skill triggers
│   - Profile preflight                │
│   - Invariants                      ─┘
│
├── references/
│   ├── ats-detection.md              ─┐
│   │   - Per-ATS conventions          │
│   │   - Detection heuristics         │  Loaded during Phase 1 (JD ingest)
│   │   - Universal ATS rules         ─┘
│   │
│   └── bullet-patterns.md            ─┐
│       - 3 bullet shapes              │
│       - Verb selection by track      │  Loaded during Phase 4 (Draft)
│       - Quantification rules        ─┘
│
├── assets/
│   └── resume.css                    ── Used by render.sh
│
└── scripts/
    └── render.sh                     ── Invoked during Phase 6 (Render)
```

## Why this layout

**Progressive disclosure.** SKILL.md files are always in context when the skill triggers (~500 lines each). Reference files are loaded only when needed (~200-400 lines each). Scripts execute without loading their full source into context. The model only carries what it needs at each step.

**Reference files are markdown only.** No code, no executable content in references. They're meant to be grep-able, diff-able, contributable. Anyone can add a new track to `branching-questions.md` without touching code.

**Scripts are self-contained.** `render.sh` does its own dependency detection, fallback logic, and reporting. It's a single file that works whether pandoc, Chrome, and pdfinfo are installed or not.

## Invariants enforced by the architecture

Some properties are guaranteed by the structure, not just by the SKILL.md prose:

- **Profile mandatory before tailoring** — `resume-tailor` SKILL.md includes a profile preflight that refuses to proceed without `career_profile.md`. There's no skip path.
- **No cross-skill state** — neither skill assumes anything about the other beyond the file format. You could swap `career-profile-builder` for a different profile builder, and `resume-tailor` would still work as long as the output matches the 19-section structure.
- **No external network calls** — both skills are pure markdown + a single bash script that uses local tools (pandoc, Chrome). No telemetry, no remote APIs, no leak surface.

## Extension points

If you wanted to add a third skill that reads from the same `career_profile.md`:

```
your-new-skill/
├── SKILL.md           # Workflow specific to your skill
└── references/
    └── ...            # Your skill's specific knowledge
```

It would consume `career_profile.md` the same way `resume-tailor` does. Examples that fit this pattern:

- **`cover-letter-tailor`** — same JD + profile inputs, different output format
- **`linkedin-rewriter`** — same profile input, longer-form output
- **`interview-prep`** — same JD + profile, generates likely questions and STAR-format prep
- **`networking-message-writer`** — same profile, generates outreach drafts

All of them benefit from the profile asset; none of them need to know about each other or about `resume-tailor`. That's the win of using a shared file format as the integration point instead of cross-skill direct calls.

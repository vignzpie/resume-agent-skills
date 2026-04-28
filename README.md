# Resume Skills for Claude

> **Not another resume builder.** Most resume tools rewrite the same surface every time you apply for a job. This one builds a deep career profile once — your achievements, scope, framings, and gaps — then tailors fast resumes from it for every future job. The profile is the asset. Resumes are disposable derivatives.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-blue)](https://agentskills.io)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-ready-orange)](https://docs.claude.com/en/docs/claude-code/overview)

Two installable skills for Claude (Claude Code, Claude.ai, or any agent that supports the Agent Skills standard):

- **`career-profile-builder`** — runs a structured 30–45 minute interview that adapts to your experience level (intern → principal) and career track (engineering, PM, design, DS/ML, marketing, sales, ops, academia). Output: `career_profile.md`, a 19-section honest source-of-truth.
- **`resume-tailor`** — reads your `career_profile.md` plus a job description, runs JD analysis → gap scoring → targeted discovery → drafting → ATS optimization → rendering. Output: `resume_<JD-ID>.{md,docx,pdf,html}` in roughly 15 minutes.

## Why this is different

Every commercial resume tool I tried (LiveCareer, Enhancv, Rezi, Jobscan, Resume-Now) does one of two things: form-fill from shallow questions, or ATS-optimize an existing resume. Both miss the actual problem.

**The actual problem is discovery.** When a senior engineer applies to a security-platform role, the resume bullet that gets the interview is "built JWKS-based public-key verification across 242 services" — not "experienced in cloud security." The first one only exists if someone asked the right follow-up question. Standard tools never ask.

This skill set splits the work the way it should be split:

| | Profile builder | Resume tailor |
|---|---|---|
| **Cadence** | Once, then occasional updates | Every job application |
| **Time** | 30–45 min cold start | ~15 min per JD |
| **Output** | One reusable `career_profile.md` | Tailored `resume_<JD-ID>.docx/.pdf` |
| **Asks deep questions?** | Yes — branched by experience + track | No — only for gaps the JD surfaces |
| **Honesty rails** | Captures known gaps + approved framings | Respects them, never overrides |

The compounding effect: each tailoring session writes its targeted-discovery answers back to the profile. The profile gets richer over time. By the third or fourth JD, "tailoring" is mostly assembly.

## Quick install

```bash
# Clone the repo
git clone https://github.com/vignzpie/resume-skills-for-claude.git
cd resume-skills-for-claude

# Drop into your Claude skills directory
cp -r career-profile-builder ~/.claude/skills/
cp -r resume-tailor ~/.claude/skills/
```

Then in Claude Code or Claude.ai:

```
You: Help me build my resume from scratch.
→ career-profile-builder triggers, runs the interview, saves career_profile.md

You: Tailor my resume for this job: <paste JD or path to JD file>
→ resume-tailor triggers, reads the profile, produces the tailored resume
```

## What the workflow looks like

### First run (cold start)

```
You ──── "Help me build my resume from scratch."
    │
    ▼
career-profile-builder
    │
    ├── Pass 0: Triage (~2 min)
    │      Years of experience, target role, geography, IC vs. mgr,
    │      existing resume? career switcher?
    │
    ├── Pass 1: Skeleton (~10 min)
    │      Reverse-chrono job history. One line per role.
    │
    ├── Pass 2: Achievement deep-dive (~15–25 min)
    │      Branching questions per track. The high-yield phase.
    │      "What did you decide that someone else might have decided differently?"
    │
    ├── Pass 3: Coverage sweep (~5–10 min)
    │      Education, certs, public artifacts.
    │      "Anything you do well but feel uncomfortable claiming?" → known gaps
    │      "Anything you've talked yourself into a good framing for?" → approved framings
    │
    ▼
career_profile.md saved (19 sections, ~15-25 KB typical)
```

### Recurring use

```
You ──── "Tailor for this JD" + paste / file path / URL
    │
    ▼
resume-tailor (reads career_profile.md first; refuses if missing)
    │
    ├── Phase 1: JD ingest — req-ID, role, must-haves, ATS family
    ├── Phase 2: Gap scorecard — ✅ / 🟡 / ❌ per requirement
    ├── Phase 3: Targeted discovery — only for 🟡 and ❌, max 5 questions
    │             (answers get written BACK to career_profile.md)
    ├── Phase 4: Draft — keywords planted in summary + skills + first bullet
    ├── Phase 5: ATS pass — exact-phrase match, word-order check
    ├── Phase 6: Render — md → html → docx → pdf, gracefully degrades
    ├── Phase 7: Compression — if over 2 pages, suggest cuts in priority order
    ├── Phase 8: Versioning — prompt for git commit / version-suffix / overwrite
    │
    ▼
resume_<JD-ID>.{md, docx, pdf, html} saved alongside the JD
```

## What's in the box

```
career-profile-builder/
├── SKILL.md                       # Workflow, invariants, output contract
└── references/
    ├── branching-questions.md     # Track-by-track interview question bank
    └── profile-template.md        # Canonical 19-section structure

resume-tailor/
├── SKILL.md                       # 9-phase workflow + invariants
├── assets/
│   └── resume.css                 # 2-page-friendly print stylesheet
├── references/
│   ├── ats-detection.md           # Workday, Greenhouse, Lever, Taleo, etc.
│   └── bullet-patterns.md         # Bullet shapes, verb selection, quantification
└── scripts/
    └── render.sh                  # md → html/docx/pdf with graceful degradation
```

## Optional dependencies

The skills work standalone, but install these for the full output set:

| Tool | What it unlocks | Install |
|---|---|---|
| `pandoc` | `.docx` rendering | `brew install pandoc` (Mac) / `apt install pandoc` (Linux) |
| Chrome / Chromium | `.pdf` via headless print | usually already on your machine |
| `pdfinfo` | automatic page-count reporting | `brew install poppler` / `apt install poppler-utils` |
| `git` | optional commit step | usually already on your machine |

The skill detects what's available and tells you what's missing. Without pandoc, you still get `.md` and `.html` (with embedded CSS). Without Chrome, you can open the `.html` and Print → Save as PDF in any browser.

## The 19-section profile

`career_profile.md` is the durable artifact. The structure (in brief):

1. Identity · 2. Headline & target roles · 3. Summary · 4. Experience snapshot · 5. Experience deep-dive · 6. Education · 7. Certifications · 8. Technical skills · 9. Domain expertise · 10. Leadership & people · 11. Public artifacts · 12. Languages spoken · 13. Awards · 14. Volunteer · 15. Interests · 16. Visa / work auth · 17. **Achievements bank** · 18. **Known gaps** · 19. **Pre-built framings**

Sections 17–19 are the engine:

- **Achievements bank** — flat list of "things worth bragging about" in your voice. The tailor pulls bullets from here.
- **Known gaps** — things you don't have or are uncertain about claiming. Prevents over-claiming. (e.g., "PCI work was regex/keyword-based, not formally certified.")
- **Pre-built framings** — your approved phrasings for sensitive topics. The tailor uses these verbatim. (e.g., "aligned with PCI-DSS intent" — not "PCI-DSS certified.")

These are what make subsequent tailoring fast and honest.

## Compatibility

These skills follow the [Agent Skills standard](https://agentskills.io), so they work with:

- **Claude Code** (primary target — drop into `~/.claude/skills/`)
- **Claude.ai** (upload via Settings → Capabilities → Skills)
- **Claude API** (use the [Skills API](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview))
- Other Agent-Skills–compatible tools (Codex, Cursor, Gemini CLI via conversion)

## Roadmap

These two skills cover the core resume workflow. Adjacent skills that read from the same `career_profile.md` are natural extensions:

- [ ] `cover-letter-tailor` — same profile + JD pair, different output
- [ ] `linkedin-rewriter` — long-form profile content from the same source
- [ ] `interview-prep` — pulls likely questions from JD + profile gaps
- [ ] `multi-jd-batch` — tailor against N JDs in one pass, surface common keywords

If you'd like to contribute one, see [CONTRIBUTING.md](CONTRIBUTING.md).

## FAQ

**Q: Do I have to use both skills?**
Yes — the resume-tailor refuses to run without a `career_profile.md`. The profile is what makes the tailor good. If you want one-off resume help without building a profile, this isn't the right tool.

**Q: Where does my profile live?**
Wherever you tell it to. By default, alongside the JD you're tailoring for. If you want a centralized profile across many job folders, put it somewhere stable and point the tailor at it.

**Q: Does it send my data anywhere?**
No. Everything happens in your Claude session and on your local disk. The `git` step is optional and only commits to a repo you've configured.

**Q: Will it lie or invent metrics to make me look better?**
No. The skills are explicitly built to refuse fabrication. If a number isn't in the profile, the tailor uses qualitative phrasing instead. Section 18 (Known Gaps) is the safety rail; Section 19 (Pre-built Framings) is the user's voice.

**Q: How is this different from Jobscan / Rezi / Enhancv?**
Those tools optimize an existing resume against a JD. They don't do deep discovery. This one runs the discovery interview that those tools assume already happened.

**Q: I'm a new grad / career switcher / academic. Does it work for me?**
Yes — the interview branches by track and experience level. New grads get a different set of questions than 15-year veterans, and the same is true for tracks (engineering vs. PM vs. design vs. academia). See [`career-profile-builder/references/branching-questions.md`](career-profile-builder/references/branching-questions.md) for the full question bank.

## Provenance

Built from a 4-hour real session tailoring a resume for a Proofpoint cloud-security role (R13927). The patterns that worked in that session — three rounds of discovery, the 19-section profile structure, the honest framing rules, the ATS keyword-density check, the pandoc + Chrome rendering pipeline — are codified here. The patterns that didn't work, also captured (see [`docs/PROVENANCE.md`](docs/PROVENANCE.md) for the original session recap).

## Contributing

Contributions welcome. See [CONTRIBUTING.md](CONTRIBUTING.md). Especially welcome:

- New track question banks (we cover engineering / EM / PM / design / DS / marketing / sales / ops / academia today; healthcare, legal, finance, education are gaps)
- Better ATS-detection heuristics (especially for non-US ATSes)
- Render-pipeline improvements (especially WeasyPrint or other pdf-engine options)
- Test cases — especially "this is what my profile looked like, this is the JD, this is the resume that came out, here's what was wrong"

## License

[MIT](LICENSE) — use, fork, ship. Attribution appreciated but not required.

---

**Keywords:** claude-skills, claude-code, resume-builder, ats-optimizer, career-profile, agent-skills, resume-tailor, job-application, career-development, ai-resume, jd-analysis, applicant-tracking-system, pandoc, workday-resume

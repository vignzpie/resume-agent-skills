# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Agent Skills spec fields in both `SKILL.md` frontmatters: `license`, `compatibility` (states what each skill needs, e.g. that `resume-tailor` is built for Claude Code-style agents with local file access) and `metadata` (author, version).
- A **Gotchas** section in both skills, drawn from a real tailoring session: profile location, never saving personal data into a code repo, checking render tools up front, PDF fallbacks, JD boilerplate, ATS misses without evidence, the user's own vocabulary, and resume variants.
- `evals/evals.json` for both skills in the [Agent Skills eval format](https://agentskills.io/skill-creation/evaluating-skills), with fictional fixtures under `evals/files/`.
- CI runs the official `skills-ref validate` (pinned) and checks that the eval files parse.

### Fixed

- `render.sh`: without pandoc it no longer stops at `.md`. It now builds the `.html` with python3 (python-markdown if installed, else a built-in converter for the resume subset of markdown, CSS embedded), so Chrome/Chromium can still produce the `.pdf`. Previously, a machine with Chrome but no pandoc got nothing printable, despite what `resume-tailor/SKILL.md` described.

## [0.1.0] - 2026-04-28

### Added

- Initial release of two skills:
  - `career-profile-builder` — structured interview that adapts to experience level (5 buckets) and career track (engineering, EM, PM, design, DS/ML, marketing, sales, ops, academia, other). Outputs a 19-section `career_profile.md`.
  - `resume-tailor` — 9-phase workflow: JD ingest → gap scorecard → targeted discovery → drafting → ATS optimization → rendering → compression → versioning → handoff. Reads `career_profile.md` as source-of-truth.
- `references/branching-questions.md` — track-by-track interview question bank.
- `references/profile-template.md` — canonical 19-section profile structure.
- `references/ats-detection.md` — ATS-family detection (Workday, Greenhouse, Lever, Taleo, iCIMS, SmartRecruiters, Workable) and per-family conventions.
- `references/bullet-patterns.md` — bullet shapes (Action→System→Outcome, Problem→Decision→Result, Scope→Body→Recognition), verb selection, quantification rules.
- `assets/resume.css` — 2-page-friendly print stylesheet with optional `.tight` mode.
- `scripts/render.sh` — markdown → html → docx → pdf pipeline with graceful degradation across pandoc, Chrome, and pdf-engine fallbacks.

### Notes

- Skills are zero-dependency markdown by default; `pandoc`, Chrome/Chromium, `pdfinfo`, and `git` are optional. Skills detect what's installed and tell the user what's missing.
- Built from the patterns observed in a real 4-hour resume-tailoring session (April 2026). See `docs/PROVENANCE.md` for the source recap.

[Unreleased]: https://github.com/vignzpie/resume-agent-skills/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/vignzpie/resume-agent-skills/releases/tag/v0.1.0

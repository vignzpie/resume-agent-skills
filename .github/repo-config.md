# GitHub Repo Configuration

These are the settings to apply manually in the GitHub repo's "About" panel and "Settings" page after pushing the initial commit. They drive discoverability on GitHub search and on Google.

## Repo name

Recommended: **`resume-agent-skills`**

Why this name:
- Includes the primary keyword (`resume-skills`) for the use case
- Specifies the platform (`for-claude`) for users searching specifically for Claude skills
- Hyphen-separated, lowercase — GitHub's recommended convention
- ~30 chars — fits in any UI

Alternative: `claude-resume-skills` if you want `claude-` as the leading prefix to match repos like `claude-seo`, `claude-cookbooks`. Either works; the first is more descriptive of what the repo *does*.

## About description

Set this in the "About" panel (gear icon at the top right of the repo).

Recommended (under 150 chars):

> 📄 Two agent skills that build a deep career profile once, then tailor ATS-ready resumes from it for every job application. Profile compounds.

Why this works:
- Lead with an emoji (📄) — proven to increase click-through on GitHub search results
- Primary keywords in first 50 chars: "Claude skills", "career profile", "ATS-ready resumes"
- Differentiator stated: "profile compounds" — distinguishes from form-fill resume tools
- Under 150 chars — full description shows in search results and social embeds

Alternative phrasings if you want to test:
- "📄 Build a deep career profile once, tailor ATS-ready resumes from it forever. Two agent skills that compound across job applications."
- "🎯 Resume tailoring done right: build a 19-section career profile once, generate ATS-optimized resumes for any JD in 15 minutes. Agent skills."

## Topics (tags)

Add these in the "About" panel via "manage topics" — up to 20. Topics are exact-match for GitHub search, so use the canonical hyphen-separated forms.

**Tier 1 (must have, highest discoverability):**

- `claude-skills`
- `claude-code`
- `agent-skills`
- `resume-builder`
- `ats-optimizer`

**Tier 2 (high relevance, broad search):**

- `career-profile`
- `resume-tailor`
- `job-application`
- `ai-resume`
- `applicant-tracking-system`

**Tier 3 (specific use cases / formats):**

- `pandoc`
- `workday`
- `markdown-resume`
- `resume-template`
- `career-development`

**Tier 4 (nice-to-have if topic-budget allows):**

- `claude-ai`
- `anthropic`
- `agentskills-io`
- `skill-creator`
- `resume-writing`

## Website URL

If you set up a project page later (GitHub Pages, a docs site, or just link to the README), put the URL here. For now, leave blank — the README is the landing page.

## Repository settings

Apply these in **Settings** for security and convention compliance:

- **Default branch:** `main`
- **Features:**
  - ✅ Issues
  - ✅ Discussions (lets people ask questions without filing bugs)
  - ✅ Projects (optional — if you want a public roadmap board)
  - ❌ Wiki (the docs/ directory replaces this)
  - ✅ Sponsorships (optional)
- **Pull requests:**
  - ✅ Allow squash merging
  - ✅ Allow rebase merging
  - ❌ Allow merge commits (keeps history linear)
  - ✅ Always suggest updating pull request branches
  - ✅ Automatically delete head branches
- **Security:**
  - ✅ Dependency graph
  - ✅ Dependabot alerts
  - ✅ Dependabot security updates
  - ✅ Code scanning (GitHub Actions sets this up automatically)

## Releases

After the initial push, create the v0.1.0 release:

```bash
git tag -a v0.1.0 -m "Initial release: career-profile-builder + resume-tailor"
git push origin v0.1.0
```

Then on GitHub:
1. Go to Releases → "Draft a new release"
2. Tag: `v0.1.0`
3. Title: `v0.1.0 — Initial release`
4. Description: copy the v0.1.0 section from `CHANGELOG.md`
5. Attach the `.skill` zip files (built locally with the `package_skill.py` script from skill-creator) so users can download a single-file install

## Submitting to awesome-* lists

Once the repo is up and has a few stars, submit it to community lists:

- **`travisvn/awesome-claude-skills`** — file an issue or PR adding your repo to the list
- **`anthropics/skills`** discussion — community-contributed skills are sometimes featured
- **`agentskills.io`** — the standards site that aggregates skill repos

Don't submit until you've used the skills yourself for a few real applications and ironed out the rough edges. Quality bar matters for these lists.

## Promotion (optional, low-pressure)

If you want to drive initial traffic:

- **DEV.to / Medium post** — "I built two Claude skills that turned 4-hour resume-tailoring sessions into 15-minute ones." Link the repo. Real story is more compelling than feature lists.
- **r/ClaudeAI on Reddit** — community is small but engaged; honest "here's something I built and why" posts do well.
- **HackerNews Show HN** — only if you can be present to answer questions for the first 4-6 hours after posting.
- **LinkedIn post** — your network is most likely to actually use this; mention the workflow shift, not the tooling.

The repo doesn't need any of these to be useful. It just needs to be findable when someone searches "claude resume skill" on GitHub.

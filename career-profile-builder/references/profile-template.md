# Career Profile Template

This is the canonical structure for `career_profile.md`. Use it verbatim as the section skeleton when writing a new profile. Sections are numbered; preserve the numbers so future tools (especially `resume-tailor`) can navigate predictably.

Sections that genuinely don't apply can be left empty with a one-line note like `_(not applicable — no formal certifications)_` rather than deleted, so the structure stays stable.

---

```markdown
# Career Profile — <Name>

_Last updated: <YYYY-MM-DD>. This is a long-form, honest source-of-truth — not a resume. Resumes are tailored outputs derived from this file._

## 1. Identity

- **Name:**
- **Location:** <city, country — and willingness to relocate if relevant>
- **Email:**
- **Phone:** <only if comfortable putting this in a tracked file>
- **LinkedIn:**
- **GitHub / portfolio:**
- **Other links:** <personal site, Twitter/X, Bluesky, Substack, etc.>

## 2. Headline & target roles

- **Current headline (one line):**
- **Target role title(s):** <up to 3 — used by resume-tailor to choose framing>
- **Track:** <IC / Manager / Hybrid>
- **Target geography:** <where roles will be applied to — affects formatting conventions>
- **Career switcher?** <if yes, from-to>

## 3. Summary

<3-5 sentence narrative the user agrees with. This is the "elevator pitch" version. The tailor will rewrite this per JD but starts from this baseline.>

## 4. Experience snapshot

| Role | Company | Dates | Location | Team size |
|---|---|---|---|---|
| <Title> | <Company> | <Start – End> | <City> | <N> |
| <Title> | <Company> | <Start – End> | <City> | <N> |

## 5. Experience deep-dive

### <Most recent role title> @ <Company> (<Start – End>)

- **Team:** <team name, what it does, size, your position in it>
- **Stack:** <languages, frameworks, infra, key tools>
- **Scope:** <users / services / requests / data volume / revenue — whatever's most legible for the role>
- **Key projects:**
  - **<Project name>** — <one paragraph, in user's voice. What it was, what was decided, what shipped, what changed.>
  - **<Project name>** — <…>
- **Metrics / outcomes:** <bulleted, only what the user is comfortable defending>
- **Cross-functional:** <other teams, stakeholders, customers>
- **Mentorship / leadership:** <who, how many, what changed for them>

### <Previous role…>

<…same shape…>

<Older roles can be progressively shorter — a one-paragraph blurb is fine for a 10-year-old role.>

## 6. Education

| Degree | Institution | Year | Notes |
|---|---|---|---|
| <Degree> | <Institution> | <Year> | <GPA if strong, honors, thesis title> |

## 7. Certifications

| Certification | Issuer | Year | Expires |
|---|---|---|---|

## 8. Technical skills

Group by category. Don't list everything you've ever touched — list things you'd be comfortable being asked about in an interview.

- **Languages:**
- **Frameworks / libraries:**
- **Infrastructure / cloud:**
- **Data / databases:**
- **Tooling / DevOps:**
- **Domain-specific:**

## 9. Domain expertise

<Areas where the user has substantive depth — not skills, but domains. e.g., "cloud security", "payments fraud", "embedded systems", "K-12 ed-tech". One paragraph each.>

## 10. Leadership & people

- **Largest team led / mentored:**
- **Hiring history:** <interviews conducted, hires closed>
- **Direct reports / dotted-line reports over career:**
- **Notable mentorship / coaching:**

## 11. Public artifacts

- **Talks:** <conference, title, year, link>
- **Publications / writing:** <paper / article / blog post, venue, year>
- **Open source:** <project, role, link>
- **Patents:** <title, status>

## 12. Languages spoken

| Language | Proficiency |
|---|---|

_(For US/global resumes this section is often dropped from the tailored output. Keep it here in the profile regardless.)_

## 13. Awards & recognition

## 14. Volunteer / community

## 15. Interests

_(Optional — many seniors omit this from resumes. Capture here if it might come up in interviews.)_

## 16. Visa / work authorization

<Only if relevant to target geography. Note current status and any relevant constraints.>

## 17. Achievements bank

A flat list of "things worth bragging about", phrased the way the user phrased them. The tailor pulls from this bank when constructing JD-specific bullets. Each entry should be self-contained — readable without context.

- <Achievement, in user's voice. Include the metric and the scope if known.>
- <…>
- <…>

## 18. Known gaps

Things the user is uncertain about claiming, or doesn't have. Capture them honestly here so the tailor doesn't accidentally over-claim.

- <e.g., "PCI work was regex/keyword based, not formally certified — we hit the controls but never went through audit">
- <e.g., "AWS IAM is owned by the cloud-governance team — I work *with* them but don't directly own policy">
- <…>

## 19. Pre-built framings

Sentences and phrasings the user has approved for sensitive or nuanced topics. The tailor must use these verbatim (or close to it) when the topic comes up.

- **Topic:** <e.g., compliance>
  **Approved framing:** <e.g., "aligned with PCI-DSS intent" — not "PCI-DSS certified">
  **Why:** <e.g., we hit the controls but did not go through formal audit>

- **Topic:** <e.g., cloud governance>
  **Approved framing:** <e.g., "partnered with cloud-governance team on IAM policy" — not "owned cloud IAM">
  **Why:** <e.g., shared ownership; user contributes but is not the policy owner>
```

---

## Notes on filling this in

- **Section 17 is the engine.** A profile with 30 entries in the achievements bank produces vastly better tailored resumes than one with 5. Push the user to add to it whenever a story comes up that isn't already in the bank.
- **Section 18 is the safety rail.** Whenever the user says "I'm not sure if I should claim X", capture both the thing AND the hesitation.
- **Section 19 is the user's voice.** Don't paraphrase — capture the user's exact words. Tailored resumes will use these phrasings verbatim.
- **Dates:** prefer "Mon YYYY – Mon YYYY" or "Mon YYYY – Present". Avoid year-only when possible because the tailor uses month resolution to compute total experience.

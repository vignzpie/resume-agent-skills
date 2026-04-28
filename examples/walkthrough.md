# Example: First-Time User Walkthrough

A sanitized walkthrough of what a cold-start session looks like. The example user is a 6-year backend engineer applying to a senior platform role.

## Session start

```
You ──── Help me build my resume from scratch.

Claude ── [career-profile-builder triggers]

         Before we go deep, let me triage your situation so I ask
         the right questions:

         1. Roughly how many years of professional experience?
         2. Current role title and target role title?
         3. Where are you, and where are you applying?
         4. IC track, management track, or hybrid?
         5. Do you have an existing resume, or starting blank?
         6. Career switcher? If yes, from what to what?
```

## Triage answers

```
You ──── 6 years. I'm a senior backend engineer at a fintech.
         Target is senior platform engineer at a larger
         infrastructure-y company. Bangalore, applying mostly to
         remote-or-Bangalore. IC track. I have a resume from 2 years
         ago that's stale. Not a career switcher.
```

## Pass 1: Skeleton

```
Claude ── Got it. Let me walk through your job history fast — I just
         need the scaffolding now, then we'll go deep.

         Most recent role first:
         - Company, title, dates, location
         - Team size and your position
         - Tech stack (just a list)
         - One sentence on what the team does

You ──── Senior Backend Engineer at FintechCo, Mar 2022 – present.
         Bangalore. Team is 8 engineers. Stack is Go, Python, Postgres,
         Kafka, AWS. We own the payments orchestration layer — routes
         transactions across 6 payment processors based on cost,
         success rate, and risk signals.

Claude ── Before that?

[...continues for each role...]

Claude ── Quick check before we go deeper. Here's the scaffolding:

         | Role | Company | Dates | Team |
         |------|---------|-------|------|
         | Sr. Backend Eng | FintechCo | Mar 2022 – Present | 8 |
         | Backend Eng | FintechCo | Jul 2020 – Feb 2022 | 4 |
         | Backend Eng | StartupCo | Aug 2018 – Jun 2020 | 12 |

         Anything wrong before we go to the deep-dive?

You ──── Looks right.
```

## Pass 2: Achievement deep-dive

```
Claude ── For your current role at FintechCo — what's the thing you
         built or led there that you're most proud of? Walk me through
         it like you'd tell a friend.

You ──── So we had this problem where transactions would fail and we'd
         retry on the same processor and they'd fail again. I built a
         smart-retry system that picks a different processor based on
         the failure type and current success rates. Reduced failed-
         retry rate by like 35%.

Claude ── Nice. A few follow-ups:
         - Was 35% measured against a control or before-after? How
           confident are you in the number?
         - What was the technical core of the routing decision —
           rules-based, ML, scoring?
         - Was anyone else on this with you, or you led it?
         - How much money does that 35% reduction translate to,
           roughly?

You ──── Before-after, looking at 30 days each side. Number is solid.
         It's a scoring system — I built a scorer that combines real-
         time success rates (last 5 min sliding window), historical
         success rates per failure type, and processor cost. Picks the
         highest-score processor that hasn't been tried. I led it solo
         but reviewed the design with two seniors. As for money —
         we process about $2B/year so even small lift is meaningful,
         but I don't have a clean number for "saved transactions
         specifically."

Claude ── Got it. So I'd write that as something like:

         "Designed and shipped a multi-factor processor-routing scorer
         (real-time success rates over 5-min sliding window, per-failure-
         type historical rates, cost) for payment retries; cut failed-
         retry rate 35% (before/after, 30-day windows) on a $2B/yr
         transaction stream."

         Sound right? Anything you'd want me to soften or sharpen?

You ──── Yeah that's good. I'd say "led" instead of "designed and
         shipped" — felt more like leading than building solo since I
         did design review.

[...interview continues with 4-5 more deep-dives across the three roles...]
```

## Pass 3: Coverage and framings

```
Claude ── Last quick sweep. Education, certs, public artifacts:

         - Degree(s)?
         - Any certifications?
         - Talks, papers, OSS, blog posts, patents?

You ──── B.Tech CS from a Tier 2 college, 2018. No certs. Did one
         talk at a local Go meetup last year — about the retry system
         actually. No OSS, no blog.

Claude ── One last pair of questions, and these are important —
         they'll shape every future tailored resume:

         1. Anything you do well at work but feel uncomfortable
            claiming on a resume?

You ──── Hmm. So I do a lot of incident response — I'm one of the
         people they call when payments are misbehaving. I'm not
         formally an SRE and I don't own the on-call rotation, but
         I end up debugging a lot of prod stuff. I always feel weird
         saying I "own reliability."

Claude ── That's a perfect Section 18 entry. I'll capture:

         "Heavy incident-response involvement on the payments domain,
         but not formally an SRE and doesn't own the on-call rotation
         — frame as 'partnered with SRE on incident response' rather
         than 'owned reliability'."

         2. Anything you've talked yourself into a good framing for?

You ──── Yeah, the cost-savings framing. I don't want to claim "saved
         the company $X" because I don't have a clean number. So I've
         been saying things like "improved success metrics on a $2B/yr
         transaction stream" — the scope is true, the number is real,
         and I'm not claiming I personally saved $X.

Claude ── Captured as a Section 19 framing:

         **Topic:** cost / financial impact of the retry work
         **Approved framing:** "improved success metrics on a $2B/yr
         transaction stream"
         **Why:** scope is verifiable; user is uncomfortable making
         a direct savings claim without a clean attribution.
```

## Saving the profile

```
Claude ── Profile is ready. It has 19 sections, your achievements
         bank has 8 entries, 2 known gaps, and 1 pre-built framing.

         I'll save it to ./career_profile.md.

         From here on, when you want to apply for a role, use the
         resume-tailor skill — it'll read this profile and a job
         description and produce a tailored resume in about 15
         minutes. You'll only need to come back here if your career
         changes (new role, new project, new cert) or you find a
         section that needs more depth.

         Saved. Anything else?
```

---

## What the recurring use looks like

A week later, the user comes back with a JD:

```
You ──── Tailor my resume for this job:
         <pastes a senior platform engineer JD from PaymentsCo,
          requisition R44512>

Claude ── [resume-tailor triggers]
         [reads career_profile.md]

         Reading the JD — I extracted:
         - Title: Senior Platform Engineer
         - Req ID: R44512 (looks like Workday — DOCX preferred)
         - Location: Remote, India eligible
         - Must-haves: Go, microservices, payment systems, on-call
         - Nice-to-haves: Kafka, Postgres, observability tooling

         Does that match what you're applying for?

You ──── Yes.

Claude ── Gap scorecard:

         | JD must-have | Your evidence |
         |--------------|---------------|
         | Go | ✅ 3 yrs at FintechCo, talk on Go retry system |
         | Microservices | ✅ Payments orchestration, 6 services |
         | Payment systems | ✅ $2B/yr stream |
         | On-call | 🟡 Heavy IR involvement, not formal SRE — Section 18 |
         | Kafka | ✅ Section 8 |
         | Postgres | ✅ Section 8 |
         | Observability tooling | 🟡 Mentioned implicitly — let me ask |

         One quick question: for observability — what tooling do you
         actually use day-to-day? Datadog, Grafana, Prometheus,
         something else? And how deep — dashboards consumer, or have
         you built dashboards/alerts?

You ──── Datadog, mostly. I've built dashboards and alerts for the
         retry system. Not super deep on the metrics side beyond that.

Claude ── [appends "Datadog dashboards + alerts for retry system" to
          Section 5 of career_profile.md]

         Drafting now. Targeting 2 pages.

         [emits resume_R44512.md]

         ATS pass — found one word-order miss: JD says "payment
         systems" twice; your draft had "payments systems" once. Fixed.

         Rendering... pandoc found, Chrome found, pdfinfo found.

         [runs render.sh]

         === Render report ===
         ✓ resume_R44512.md (3,847 bytes)
         ✓ resume_R44512.html (8,221 bytes)
         ✓ resume_R44512.docx (12,484 bytes)
         ✓ resume_R44512.pdf (45,221 bytes)
         PDF page count: 2

         Two pages — on target. Anything you want to tweak before
         we wrap?

You ──── Looks good.

Claude ── Want me to commit this? Three options:
         1. Just save (current behavior)
         2. Suffix the filename: resume_R44512_2026-05-05.md
         3. Git commit with message "Tailored resume for R44512 (PaymentsCo)"

You ──── Option 3.

Claude ── [git add resume_R44512.* && git commit]

         Committed. Quick handoff:
         - resume_R44512.docx is ATS-ready — upload this to PaymentsCo's
           Workday system.
         - resume_R44512.pdf is for emailing. If you have a recruiter
           contact, send the PDF.
         - Open the .docx in Word for visual polish before submitting —
           pandoc gets you 95% there but your eye on the layout is the
           last 5%.

         Total elapsed time: ~12 minutes.
```

---

## Notes on this example

The numbers in this example (35% retry reduction, $2B/yr stream, 12 min elapsed) are illustrative. Real sessions vary. Key things to note about how the skill behaves:

1. **The interview captures the user's uncertainty** — "I always feel weird saying I 'own reliability'" became a Section 18 entry that prevents future tailored resumes from claiming SRE ownership.
2. **Numbers are user-supplied, never invented** — the user said "35% before/after on 30-day windows" and that's exactly what made it into the bullet.
3. **The targeted discovery wrote back to the profile** — the Datadog observability tooling answer didn't just go into the resume; it went into Section 5 of `career_profile.md` so future tailoring sessions don't re-ask.
4. **The framing for cost is the user's, not the skill's** — Section 19 captures the user's exact phrasing ("improved success metrics on a $2B/yr transaction stream") and the tailor uses it verbatim.
5. **Page-count compression wasn't needed** because the profile was reasonably sized and the JD wasn't keyword-dense. If it had run long, Phase 7 would have suggested cuts in priority order, asking before each.

The compounding value: the second time this user tailors a resume, the profile already has the Datadog observability detail, the retry-system numbers, the on-call framing. Tailoring becomes ~10 minutes. By the fifth role, it's ~7 minutes — most of the time is just JD analysis.

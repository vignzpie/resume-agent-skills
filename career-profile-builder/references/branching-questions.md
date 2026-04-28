# Branching Questions Reference

This file is the question bank for Pass 2 (Achievement deep-dive) of the career profile interview. It is organized by **track family** because the vocabulary of a strong achievement is different in each track. Within each track, callouts mark which probes get more weight at different experience levels.

## How to use this file

1. After Pass 0 (Triage), pick the track that matches the user. If the user is hybrid (e.g., eng manager, PM/UX), pick the one whose vocabulary their target role uses and layer in the other later.
2. For each meaningful role in the user's history, run the deep-dive section for that track.
3. The questions are ordered by what tends to surface the most differentiated material. Don't ask all of them — read the user's first answer and pick the follow-ups that look productive.
4. Stop probing when the user is repeating themselves or visibly running out. Three to five strong follow-ups per role is plenty.

---

## Universal opener (use across tracks)

For each role, start here, then branch into the track-specific bank:

- "What's the one thing you built / led / shipped in this role that you're most proud of? Walk me through it like you'd tell a friend."
- "What was true about the team / system / business when you started, and what was true when you left?"
- "What did you decide that someone else might have decided differently?" — this surfaces ownership.
- "What's the achievement from this role you'd most want me to put on your resume? And what wouldn't you want me to mention?"

The fourth question is unusually high-yield. It surfaces both wins and discomfort points (which become Section 18 / 19 in the profile).

---

## Track: Software Engineering

Strong engineering achievements have four parts: scope (size of the system), depth (technical decisions made), impact (what changed for users or the business), and ownership (what was yours vs. the team's). Probe all four.

**Scope probes:**
- How many services / users / requests-per-second / data volume were you working with?
- How many engineers on the team? How many on the project specifically?
- Was this greenfield, brownfield, or rescue?

**Depth probes:**
- What was the most interesting technical decision you made? What were the alternatives, and why this one?
- Anything you built that survived a 10x scale-up (or that broke at 10x and you fixed it)?
- Any production incident you owned the fix for? (Postmortem-style stories are gold.)
- Any cross-language / cross-platform / cross-cloud work?

**Security / platform engineers specifically — push harder on these:**
- Auth / authz: JWKS, mTLS, OAuth flows, RBAC, ABAC, session management?
- Secrets handling: rotation, KMS integration, runtime override, scoping?
- Compliance touchpoints: PCI, SOC 2, HIPAA, GDPR, FedRAMP, ISO 27001? (and how — formally certified vs. controls-aligned vs. aware)
- Observability: tracing, logging, metrics, audit logging, log redaction?
- Supply chain: dependency scanning, SBOM, signed builds, Dependabot/Snyk/Sonar cadence?
- IaC: Terraform / Pulumi / CDK ownership, blast radius, review process?

**Impact probes:**
- Did this make something faster, cheaper, more reliable, more secure? By how much?
- Did anything get measurably easier for other engineers because of this work? (DX wins)
- Did anything customer-visible change?

**Ownership probes:**
- Did you propose this work, or was it assigned?
- Who reviewed your design? Did anyone push back hard? How did that resolve?
- If a junior engineer joined the project today, what would you tell them you did?

### Engineering — by experience level

- **<1 yr / new grad:** weight projects and internships heavily. Acceptable to lean on coursework if it's substantive (capstone, thesis, OSS contribution). Don't push on "team scope" — push on "what did you build, end to end, that worked."
- **1-4 yrs:** push hard on "what did you decide" — this level often hides decisions behind passive voice.
- **5-9 yrs:** push on cross-team work, technology choices, mentorship of juniors, complexity owned end-to-end.
- **10-15 yrs:** architecture across multiple teams, hiring, technology bets that paid off (and ones that didn't — the latter is often where the best stories live).
- **15+ yrs:** org-level technical influence, public artifacts, technology choices that defined the company's direction. Older roles compress to one line.

---

## Track: Engineering Management

EM achievements live at the intersection of people, delivery, and technical credibility. All three are required — pure people stories without technical context read weak; pure delivery stories without people work read like an IC.

**People probes:**
- Team size? Direct reports vs. dotted-line vs. influence?
- Hiring: did you grow the team? How many hires? Closing rate?
- Did anyone you managed get promoted? Leave? What did you do for both?
- Performance management — did you handle a difficult case? (Don't ask for names; ask for the shape.)
- Reorgs: did you propose, design, or execute one?

**Delivery probes:**
- What did the team ship in your tenure that wouldn't have shipped without you?
- Any program / cross-team initiative you ran?
- On-call health: did it improve? Did you change the rotation, the runbooks, the alerting?
- Any "we were behind, you got us back on track" story?

**Technical credibility probes:**
- Did you do code review? Architecture review? RFC review?
- Any technical decision you overrode (or were overridden on) — what was the reasoning?
- How do you stay technical enough to be useful?

### EM — by experience level

- **First-time EM (1-2 yrs as manager):** focus on transition stories, first hires, first hard conversations.
- **Experienced EM (3-7 yrs):** team scaling, multi-team coordination, manager-of-managers transition.
- **Director / Sr. Director (8+ yrs):** org design, leadership-team membership, exec-level communication, P&L or budget responsibility, hiring directors.

---

## Track: Product Management

Strong PM achievements have three parts: the problem (what was broken / unmet), the bet (what you decided to do and why), and the outcome (what changed). Probe all three. PMs frequently have great problem framing but skip the "why this and not that" — push on it.

**Problem probes:**
- How did you discover this problem? (Data, user research, support tickets, exec ask?)
- Who else thought it was a problem? Who didn't, and why?
- What was the cost of not solving it?

**Bet probes:**
- What did you ship, and why this and not the obvious alternative?
- What did you say no to in order to ship this?
- How did you scope it? MVP? V1? Iterations?

**Outcome probes:**
- What metric moved? Top-of-funnel, conversion, retention, revenue, NPS, support volume?
- How big was the lift? (Push for absolute numbers AND relative — both matter to different audiences.)
- Anything surprising? Anything that didn't work that you tried?

**Cross-functional probes (matter a LOT for PM):**
- How big was the eng team you partnered with?
- Did you work directly with design? Research? Sales? Support? Legal?
- Any exec sponsor? Any exec pushback you handled?

### PM — by experience level

- **Associate PM / 0-2 yrs:** weight scope of features owned, learning velocity, mentor relationships. Don't push on strategy yet.
- **PM (3-5 yrs):** push on bets and outcomes. The "no" answers (what you didn't ship) are differentiators.
- **Senior PM (5-8 yrs):** push on cross-team work, exec communication, multi-quarter planning.
- **Group PM / Principal (8+ yrs):** push on portfolio bets, team-of-PMs leadership, strategy work that shaped the org.

---

## Track: Design (Product / UX / Visual)

Design achievements are uniquely hard to put in resume bullets because the artifact is visual. Push for context: what was true, what changed, what the user-visible outcome was.

**Process probes:**
- What was the design problem, in one sentence?
- What was your research input? (Interviews, usability tests, analytics, support tickets.)
- How many iterations? How did you decide between them?
- Who reviewed? Who pushed back?

**Craft probes:**
- What's the design system situation — did you use one, build one, contribute to one?
- Any accessibility work you led? (a11y is high-leverage on resumes.)
- Cross-platform: web + mobile + tablet? Any platform you optimized specifically?

**Outcome probes:**
- Did engagement / conversion / NPS / support volume change?
- Did the design ship? (Honest answer matters — designers often have great unshipped work; capture it but flag it.)
- Did anyone copy it? Any external recognition?

### Design — by experience level

- **Junior (0-3 yrs):** portfolio depth, mentorship received, range across project types.
- **Mid (3-7 yrs):** ownership of features end-to-end, design system contributions, cross-disciplinary work.
- **Senior / Lead (7-12 yrs):** team mentorship, design strategy, design ops, hiring.
- **Principal / Director (12+ yrs):** org-level design influence, visual or product direction setting, public artifacts (talks, articles).

---

## Track: Data Science / ML / Analytics

DS achievements have a "model" axis and a "decision" axis. Both matter, but at senior levels the decision axis dominates. Probe both.

**Problem framing probes:**
- What business question were you answering?
- Could it have been answered without ML? (If yes — push on why ML.)
- What was the cost of being wrong?

**Technical probes:**
- Data: where did it come from? How clean? How much wrangling?
- Model: what did you try? What stuck? Why?
- Eval: how did you measure success? Offline metrics, A/B test, holdout?
- Production: did this ship? Latency? Model size? Retraining cadence?

**Decision / impact probes:**
- What changed because of this work — a product, a process, a forecast, an exec decision?
- Did you write up the result? Present it? To whom?
- Did anyone change behavior because of your finding?

### DS — by experience level

- **Early (0-3 yrs):** weight projects and Kaggle/competition work for new grads; weight first production model and stakeholder relationships for early-career.
- **Mid (3-7 yrs):** end-to-end ownership of model + deployment + iteration. Push on what shipped, not just what was modeled.
- **Senior (7-12 yrs):** mentorship, eval rigor, decisions that affected company direction.
- **Principal / Lead (12+ yrs):** team building, research direction, public artifacts (papers, talks).

---

## Track: Marketing

Marketing splits into demand-gen, brand, content, growth, and product marketing — each with different vocabulary. In Pass 0, ask which sub-track. The probes below assume a generic frame; sharpen them based on the answer.

**Channel probes:**
- Which channels did you own — paid, organic, content, email, partnerships, events, PR?
- Budget you controlled?
- Team you ran (in-house + agency)?

**Campaign probes:**
- Walk me through your highest-impact campaign. Audience, message, channel, result?
- Anything that didn't work that taught you something?

**Metric probes:**
- CAC, LTV, payback, MQL→SQL conversion, pipeline contribution, CTR, retention?
- Brand metrics: awareness lift, search volume, share of voice?

**Cross-functional probes:**
- Did you work directly with sales? Product? PR? Legal?
- Any launch you owned end-to-end?

### Marketing — by experience level

- **Coordinator / Specialist (0-3 yrs):** weight specific campaign ownership, tooling depth, learning velocity.
- **Manager (3-7 yrs):** weight channel P&L, team mentorship, campaign portfolio.
- **Director (7-12 yrs):** weight cross-channel strategy, hiring, executive communication.
- **VP / CMO (12+ yrs):** weight org design, board-level reporting, brand and demand together.

---

## Track: Sales

Sales achievements are uniquely numerical — quotas, percentages, deal sizes — and uniquely cyclical (a great year doesn't mean every year). Push for the multi-year shape.

**Quota probes:**
- What was your number? Did you hit it? By how much, and how often?
- How is the quota set? (Top-down, bottom-up, gamed.)
- Average deal size? Sales cycle length?

**Pipeline probes:**
- How did you build pipeline — outbound, inbound, partnership?
- Largest deal you closed? Most strategic?
- Any deal you lost that taught you something?

**Process probes:**
- What's your sales motion? Land-and-expand, transactional, enterprise?
- Any process you improved (CRM hygiene, qualification, handoff to CS)?

### Sales — by experience level

- **SDR / BDR (0-2 yrs):** weight activity metrics that translate to opportunity creation.
- **AE (2-7 yrs):** weight quota attainment over multiple quarters, deal sophistication.
- **Manager / Director (7-12 yrs):** weight team quota, hiring, ramp time, territory design.
- **VP / CRO (12+ yrs):** weight org-level revenue responsibility, board-level reporting, GTM strategy.

---

## Track: Operations / Program Management / Customer Success

These three differ in vocabulary but share the achievement shape: a process or relationship was X, you made it Y, the business cared because Z.

**Scope probes:**
- What process or relationship was yours?
- Volume: how many tickets, customers, programs, dollars, vendors?
- Stakeholders: who up, who down, who across?

**Change probes:**
- What was broken or sub-optimal when you started?
- What did you change — process, tool, team, contract?
- How did you measure that the change worked?

**People probes (especially for CS):**
- NRR, GRR, churn, expansion?
- Any exec relationships you owned? Any save you led?

---

## Track: Academia / Research

Academic CVs have very different conventions from industry resumes — but the user may be transitioning. Ask in Pass 0 if the target is academic, industry, or both. The branching changes.

**Research probes:**
- What's the through-line of your research? One sentence.
- Most-cited paper? Most personally important paper?
- Funding history?
- Collaborations across institutions?

**Teaching probes (if applicable):**
- Courses developed? Course-load each year? Class sizes?
- Student outcomes?

**Service probes:**
- Reviewing, editing, committee work?
- External-facing service (industry advisory, government, public)?

**For academic→industry transitions specifically:**
- What's the industry-translatable skill bundle here? (e.g., "I do X using Y; in industry that maps to Z.")
- Any industry collaborations or internships?

---

## Track: Other / Custom

If the user's track isn't on this list, fall back to the universal opener and let their domain language guide the follow-ups. Don't fake industry knowledge. Useful generic probes:

- "Walk me through the most representative project / case / engagement of this role."
- "What was the situation, what did you do, what was the result?" (classic STAR)
- "What's a number — any number — that shows the scale of what you owned?"
- "Who else was involved? What was your specific role?"
- "What did this make possible that wasn't possible before?"

After three or four such roles, you'll have enough vocabulary to ask sharper follow-ups.

---

## Notes for the interviewer

- **Don't ask all the questions.** Pick five strong ones per role. The bank is for adapting, not for marching through.
- **Read the user's energy.** If they're cooking on a story, let them. If they're flat, switch tracks or move on.
- **Capture in the user's voice.** Write down what they actually say, not your normalized version. Polish happens at tailoring time.
- **When the user says "I'm not sure if this counts" — that's a flag.** It usually does count, AND it usually has a Section 18 caveat. Capture both.

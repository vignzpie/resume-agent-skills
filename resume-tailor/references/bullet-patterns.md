# Bullet-Writing Patterns

How to turn raw profile material (Section 17 achievements, Section 5 deep-dives) into resume bullets that work.

## The shape of a strong bullet

Most strong resume bullets fit one of these three patterns:

### Pattern 1: Action → System → Outcome

```
<Strong verb> <what you built / changed> <for what scope>, <measurable outcome>.
```

**Examples:**
- _Built JWKS-based public-key verification across 242 services, eliminating shared-secret rotation overhead and cutting auth-related incidents by ~40%._
- _Designed a regex-and-keyword field-level log redaction service with separate decryption path, enabling SOC 2-aligned audit logs without slowing the hot path._
- _Led migration of 15 services from Java 11 / Spring Boot 2 to Java 17 / Spring Boot 3.5, completed in 4 months with zero customer-visible incidents._

### Pattern 2: Problem → Decision → Result

For senior IC and EM bullets where the *decision* is the achievement:

```
<Faced situation>. <Decided X over Y because Z>. <Result>.
```

**Examples:**
- _Inherited a 14-engineer Thanos team scaled down to 4; restructured ownership to focus on highest-leverage projects (ROS, Healthcheck) and retired three lower-impact services, restoring on-call sustainability._
- _Chose JWKS public-key verification over shared-secret HMAC for inter-service auth despite higher initial complexity, eliminating rotation-coordination incidents that had been costing ~2 eng-weeks per quarter._

### Pattern 3: Scope → Body → Recognition

For team-level work where outcomes are cross-cutting:

```
<Scope of ownership>. <What was done>. <How that mattered to the org>.
```

**Examples:**
- _Mentored 5 indirect reports across two teams; two were promoted within 18 months, one moved into a tech lead role on a sister team._
- _Owned auth platform for Krogo (227 services) and Kaleido (15 services); provided the 2FA integration that unblocked Kaleido's GA launch._

## Verb selection

Strong verbs replace a lot of weak adjectives. A few patterns:

| Track | Strong verbs |
|---|---|
| Eng (build) | Built, designed, shipped, architected, implemented, refactored, hardened, instrumented, automated |
| Eng (lead) | Led, owned, mentored, hired, restructured, coordinated, drove, unblocked |
| PM | Launched, prioritized, scoped, validated, killed (a project), researched, defined |
| Design | Designed, prototyped, researched, iterated, audited (a11y), shipped |
| Sales | Closed, prospected, expanded, retained, negotiated, ramped |
| Marketing | Launched, scaled, optimized, tested, ran (campaign), grew |
| DS / ML | Modeled, validated, deployed, instrumented, A/B-tested, productionized |

Avoid: "responsible for", "helped", "worked on", "involved in", "assisted". These hide ownership. The user did something — name what.

## The first-bullet rule

The **first bullet of the most recent role** is the highest-impact line on the resume. Everything else should be good; this one must be perfect.

Properties of a great first bullet:
- Plants 2-3 must-have JD keywords naturally
- Has a number
- Is something the user can talk about for 10+ minutes in an interview
- Is in the user's voice, not generic-resume voice

If a candidate has only 30 seconds, that bullet should be enough to sell them.

## Bullets to avoid

| Bad | Why it's bad | Fix |
|---|---|---|
| _Responsible for backend services_ | "Responsible for" hides ownership; "backend services" is generic | _Built and owned 12 backend services in Go and Python, serving ~5K req/s in production_ |
| _Improved performance_ | No number, no scope, no method | _Cut p99 latency on auth path from 180ms to 45ms by replacing JSON unmarshaling with code-generated parsers_ |
| _Worked on team migration to Kubernetes_ | "Worked on" is passive; no role | _Led 8-engineer migration of 30 services from EC2 to EKS, completed in 6 months with no customer-visible downtime_ |
| _Used Python, Java, Go, K8s, AWS, Docker, Kafka, Redis_ | Tech-list bullet — belongs in Skills, not Experience | (Move to Skills section. Keep Experience bullets about what was *done*.) |

## Quantification

Numbers in bullets work when they're real. Numbers that come up most often (and are usually defensible):

- **Throughput / scale:** requests/sec, messages/day, events/hour, users, customers, transactions
- **Money:** revenue, ARR, savings, budget owned, deal sizes
- **Time:** latency reductions (p50, p99), cycle-time, time-to-recovery, ramp-time
- **People:** team size, reports, hires, mentees
- **Reliability:** uptime, SLOs, incident rate, MTTR
- **Range:** "from X to Y over Z" — multi-quarter or year-over-year deltas

If the profile doesn't have a number for a claim, do not invent one. Either:
1. Ask the user for an estimate (and capture it back into the profile)
2. Use a qualitative phrasing ("meaningfully reduced", "the team's largest deployment to date")
3. Drop the claim if neither works

## Working from the Achievements Bank

Section 17 of the profile is the raw material. Most entries can become bullets with light editing:

**Profile entry:**
> Built JWKS-issued public-key verification for inter-service auth across all 242 services on Krogo + Kaleido. Eliminated shared-secret rotation overhead. Started before there was a security team — designed it with the cloud-governance partners.

**Resume bullet for a security-platform role:**
> Built JWKS-based public-key verification across 242 services on Krogo and Kaleido platforms, partnering with cloud-governance to retire shared-secret rotation overhead.

Note what changed: the framing tightened ("cloud-governance partners" → "partnering with cloud-governance" — preserves Section 19 framing that the user collaborates rather than owns). The number stays. The achievement stays. The bullet is shorter and more JD-keyword-front-loaded.

## Length

Most bullets should fit on 1-2 lines in the rendered output. Three lines is acceptable for a particularly meaty achievement on a recent role. Four lines is almost always too much — break into two bullets or cut detail.

The goal is scanability. A recruiter spends 6-30 seconds on the first pass.

## Headline / summary patterns

The summary at the top of the resume is a 3-4 sentence pitch. Strong summaries:

1. State the role and seniority signal (matching the JD's vocabulary)
2. Plant 2-3 of the JD's top keywords
3. End with a "what I'm looking for" line that mirrors the JD's framing

**Example, generic platform engineer:**
> Senior platform engineer with 12 years building secure, scalable backend systems. Recent work focuses on cloud-native auth (JWKS, mTLS, OAuth) and field-level data protection across 200+ microservices. Looking to deepen security ownership at a product company where the platform is the product.

Compare to a generic version that wouldn't have worked:
> Experienced engineer with strong technical and leadership skills, looking for an exciting opportunity at a great company.

The first one is unmistakably about a specific person. The second could describe anyone.

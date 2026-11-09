# Career Profile: Asha Rao

> Fictional profile for evals. Not a real person.

## 1. Identity
- Name: Asha Rao · Pune, India · asha.rao@example.com · github.com/asharao-example

## 2. Headline & target roles
- Senior Backend Engineer → Staff Backend Engineer (IC). Pune or remote.

## 3. Summary
Backend engineer, 8 years, payments and platform work. Go since 2021, Python before that.

## 4. Experience snapshot
| Company | Title | Dates |
|---|---|---|
| PayLoop | Senior Backend Engineer | Mar 2021 – Present |
| Kitebyte | Software Engineer | Jun 2017 – Feb 2021 |

## 5. Experience deep-dive
### PayLoop: Senior Backend Engineer (Mar 2021 – Present)
- Built the Go payment-routing service: ~3,000 requests/sec at peak, 14 downstream banks.
- Moved inter-service calls from REST to gRPC for the routing path; p99 latency 180ms → 70ms (measured with load tests).
- Led a 3-engineer squad; mentored 2 engineers to promotion.
- Root-caused a duplicate-charge incident to a retry without an idempotency key; added idempotency keys across the payment APIs.
- Worked WITH the security team on PCI-DSS scope reduction (tokenization). She did not own the audit.

### Kitebyte: Software Engineer (Jun 2017 – Feb 2021)
- Django REST APIs for a logistics SaaS; built the shipment-tracking webhook system.

## 6. Education
- B.Tech Computer Science, 2017

## 8. Technical skills
Go, Python, gRPC, REST, PostgreSQL, Redis, Kafka, Kubernetes, Prometheus, OpenTelemetry

## 17. Achievements bank
- Payment routing in Go at ~3,000 rps across 14 banks
- REST → gRPC on the routing path: p99 180ms → 70ms
- Idempotency keys after root-causing duplicate charges
- Mentored 2 engineers to promotion

## 18. Known gaps
- Has NOT used Rust or Java professionally.
- Kafka: consumer-side only; never ran or tuned a cluster.
- No public talks or open-source contributions.

## 19. Pre-built framings
- PCI: "partnered with security on PCI-DSS scope reduction". Never "led PCI compliance" or "PCI certified".

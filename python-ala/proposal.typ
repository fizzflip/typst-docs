#set document(title: "IT Project Proposal: MedConnect", author: "Project Engineering Group")
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  // header: align(right)[#text(
  //   fill: luma(100),
  //   size: 8pt,
  //   weight: "medium",
  // )[CONFIDENTIAL | IT INFRASTRUCTURE MODERNIZATION]],
  footer: [
    #set text(size: 8pt, fill: luma(150))
    #grid(
      columns: (1fr, 1fr),
      [--------------------------], align(right)[Page #context counter(page).display()],
    )
  ],
)

// Font setup: Prioritize professional sans-serif for a modern technical feel
#set text(
  font: ("Inter", "Liberation Sans", "DejaVu Sans"),
  size: 10pt,
  weight: "light",
  fill: rgb("#263238"),
)

#show heading: it => [
  #set text(fill: rgb("#0d47a1"), weight: "bold")
  #v(1.5em, weak: true)
  #it
  #v(0.8em, weak: true)
]

#set par(justify: true, leading: 0.75em)

// Styled container for key summaries
#let callout(title: none, body) = rect(
  width: 100%,
  fill: rgb("#f1f7fd"),
  stroke: (left: 2.5pt + rgb("#0d47a1")),
  inset: 18pt,
  radius: (right: 4pt),
  [
    #if title != none [
      #text(weight: "bold", fill: rgb("#0d47a1"), size: 11pt)[#title] \
      #v(0.5em)
    ]
    #body
  ],
)

// --- TITLE SECTION ---
#v(2em)
#align(center)[
  #text(size: 26pt, weight: "bold", fill: rgb("#0d47a1"))[MedConnect] \
  #v(0.4em)
  #text(size: 13pt, weight: "medium", fill: rgb("#607d8b"))[Next-Gen Patient Flow & Triage Optimization] \
  #v(1.5em)
  #line(length: 60%, stroke: 0.5pt + luma(200))
  #v(2em)
]

#callout(title: "Abstract")[
  MedConnect is a comprehensive digital solution designed to eliminate the operational friction inherent in traditional clinical scheduling. By integrating *algorithmic triage* with *autonomous patient scheduling*, the system transforms medical centers from reactive administrative environments into streamlined, patient-centric facilities. This proposal details the technical architecture, strategic "cause," and implementation roadmap for this critical infrastructure upgrade.
]

#v(2em)

= 1. Reason
The "Cause" behind MedConnect is the urgent need to align clinical capacity with the demands of modern healthcare accessibility.

Current outpatient centers suffer from a "triple-burden":
- *Operational Decay:* Manual scheduling leads to a 15-20% inefficiency in provider calendar utilization.
- *Clinical Risk:* Non-clinical staff performing implicit triage via phone increases the probability of delayed care for urgent cases.
- *Retention Deficit:* Administrative burnout caused by repetitive, low-value phone management leads to high staff turnover.

= 2. The MedConnect Ecosystem
MedConnect operates as a unified platform bridging the gap between patient needs and provider availability.

== 2.1 Key Operational Pillars
#grid(
  columns: (1fr, 1fr),
  gutter: 15pt,
  [
    *Dynamic Triage Engine* \
    Utilizes clinical decision-tree algorithms to assess symptom urgency in real-time. Patients are automatically categorized, ensuring critical cases receive immediate priority slots while routine check-ups are distributed efficiently across available hours.
  ],
  [
    *Self-Service Portal* \
    A secure, 24/7 interface that empowers patients to manage appointments without receptionist intervention. This transition is projected to reduce inbound scheduling call volume by over 45%.
  ],
)
#pagebreak()
== 2.2 Technical Foundation
The system is built for scalability and data integrity:
- *Core:* Python-based Flask API for high-performance request handling.
- *Intelligence:* Custom logic trees for symptom-based scheduling optimization.
- *Infrastructure:* Secure SQLite/PostgreSQL architecture with AES-256 encryption.
- *Notification:* Real-time SMS and Email synchronization for appointment retention.

= 3. Implementation Blueprint
The project will be executed over a 16-week period using an iterative SDLC to ensure stakeholder alignment at every phase.

#v(0.5em)
#table(
  columns: (1.2fr, 3fr),
  inset: 12pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if x == 0 { rgb("#f8f9fa") },
  [*Timeline*], [*Phased Deliverables*],
  [Weeks 1 - 4], [*Discovery & Logic Mapping:* Finalizing triage decision trees and workflow requirements.],
  [Weeks 5 - 10], [*Development Sprint:* Core backend logic, database modeling, and patient portal UI construction.],
  [Weeks 11 - 14], [*Beta Integration:* End-to-end testing, security audits, and staff training sessions.],
  [Weeks 15 - 16], [*Deployment & Review:* Live rollout followed by a 14-day performance optimization period.],
)

= 4. Objectives & KPIs
Success will be measured against rigorous operational benchmarks:
- *Volume Reduction:* 40% decrease in manual scheduling calls within 90 days.
- *Accuracy:* 100% elimination of double-booking errors.
- *Patient Throughput:* 15% increase in total patient capacity through optimized calendar density.

#v(1fr)

#callout[
  #text(weight: "bold", fill: rgb("#0d47a1"))[Commitment to Excellence:] \
  MedConnect represents more than a software update; it is an investment in the sustainability of the clinic’s operational future. By optimizing the "Digital Front Door," we ensure that providers can focus on medicine rather than administration.
]

#set document(
  title: "IT Project Plan: MedConnect Scope & Objectives",
  author: "Project Engineering Group",
)
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  // header: align(right)[
  // #text(fill: luma(120), size: 8pt, weight: "medium")[ASSIGNMENT 2 | PROJECT SCOPE & OBJECTIVES]
  // ],
  footer: [
    #set text(size: 8pt, fill: luma(150))
    #grid(
      columns: (1fr, 1fr),
      [Sandeep Prasad - 240905050085], align(right)[Page #context counter(page).display()],
    )
  ],
)

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

#let plan-block(title: none, body) = rect(
  width: 100%,
  fill: rgb("#f8f9fa"),
  stroke: (left: 3pt + rgb("#0d47a1")),
  inset: 15pt,
  radius: (right: 4pt),
  [
    #if title != none [
      #text(weight: "bold", fill: rgb("#0d47a1"))[#title] \
      #v(0.5em)
    ]
    #body
  ],
)

// --- TITLE ---
#v(2em)
#align(center)[
  #text(
    size: 22pt,
    weight: "bold",
    fill: rgb("#0d47a1"),
  )[MedConnect: Project Scope & Planning] \
  #v(0.5em)
  #text(
    size: 11pt,
    weight: "regular",
    fill: rgb("#546e7a"),
  )[Systematic Definition of Objectives, Deliverables, and Resources] \
  #v(1.5em)
  #line(length: 40%, stroke: 0.5pt + luma(200))
  #v(2em)
]

= 1. Project Scope & Deliverable Matrix
The scope of *MedConnect* is precisely defined to focus on the "Digital Front Door" of clinical operations. To ensure clarity, the following matrix outlines specific functional requirements and their associated acceptance criteria.

#table(
  columns: (1fr, 1.8fr, 1.5fr),
  inset: 7pt,
  fill: (x, y) => if y == 0 { rgb("#ECEFF1") },
  [*Feature*], [*Functional Requirement*], [*Acceptance Criteria*],
  [Symp. Triage], [Digital questionnaire with logic-tree execution.], [100% logic alignment with clinical SME trees.],

  [Self-Schedule], [Native calendar binding with real-time slots.], [Sync latency < 2s for all availability updates.],

  [Notifications], [Automated SMS/Email confirmations & alerts.], [Delivery success rate >= 98% in pilot phase.],

  [Secure Vault], [Encryption-at-rest for all patient PII data.], [Passes HIPAA-compliant vulnerability scan.],
)

== 1.2 Boundary Conditions (Exclusions)
To prevent "Scope Creep," the following are explicitly *Out-of-Scope*:
- *Internal EMR Replacement:* We act as a middleware, not a primary medical record repository.
- *Financial Gateways:* Billing and insurance claims are handled by existing third-party systems.

= 2. Strategic Objectives (SMART)
The project aims for operational excellence through quantifiable mission goals.

- *O1 (Operational):* Deploy a functional prototype within 16 weeks, automating 90% of routine bookings.
- *O2 (Efficiency):* Target a 75% reduction in patient interaction time for basic scheduling (from 8m to \<2m).
- *O3 (Safety):* 100% of "Urgent" flagged cases must generate a high-priority administrative alert within 60s.
- *O4 (Scale):* Data architecture must support a peak load of 50 concurrent triage sessions without latency degradation.
#pagebreak()
= 3. Constraints & Critical Assumptions
Successful delivery is contingent on managing the following environmental factors.

- *Constraints:* Must comply with regional health data regulations (HIPAA/GDPR); fixed budget of \$45k.
- *Assumptions:* Clinical SMEs are available 4 hours/week for logic validation; Existing clinic API handles read-access for physician schedules.

= 4. Stakeholder Analysis Matrix
Mapping the influence and interest of the project’s key participants.

#table(
  columns: (1fr, 1fr, 2fr),
  inset: 7pt,
  fill: (x, y) => if y == 0 { rgb("#ECEFF1") },
  [*Stakeholder*], [*Power/Interest*], [*Engagement Strategy*],
  [Clinic Board], [High / High], [Monthly steering committee and ROI reports.],
  [SME Doctors], [High / Medium], [Weekly logic-tree validation workshops.],
  [Reception Staff], [Medium / High], [Bi-weekly training and feedback loops.],
  [Patients], [Low / High], [UX beta testing and accessibility surveys.],
)


= 5. Resource Allocation & Financial Plan
The project requires a specialized team and a strategic allocation of the capital budget.

== 5.1 Project Personnel
- *Project Lead (1x):* SDLC management, stakeholder liaison, and timeline integrity.
- *Dev Team (2x):* Python/Flask backend specialists and UI/UX front-end development.
- *Clinical Consultant (1x):* Verification of medical logic-trees and safety triggers.

== 5.2 Comprehensive Budget Breakdown
#table(
  columns: (2fr, 1fr, 2fr),
  inset: 10pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if x == 0 { rgb("#F8F9FA") } else if y == 0 {
    rgb("#ECEFF1")
  },
  [*Expenditure Category*], [*Cost (Est)*], [*Allocation Detail*],
  [Personnel / Talent], [\$32,000], [Developer stipends and PM leadership fees.],

  [Infra & Hosting], [\$4,500], [AWS Instances, Database hosting, and SSL.],
  [Security & Compliance], [\$6,000], [Third-party pen-testing and HIPAA audit tool.],

  [Contingency / Misc], [\$2,500], [Emergency buffer (5% of total budget).],
  [*Total Project Budget*], [*\$45,000*], [*Total Capital Requirement*],
)

= 6. Key Milestones & Completion Timing
#v(1em)
#table(
  columns: (1fr, 2fr, 1.5fr),
  inset: 10pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if x == 0 { rgb("#eceff1") },
  [*Milestone*], [*Key Deliverables*], [*Expected Date*],
  [M1: Scoping], [Requirement Lock & UX Blueprint], [Week 3],
  [M2: Alpha], [Triage Engine Core & DB Finalization], [Week 8],
  [M3: Beta], [Staff UAT & Logic-Tree Validation], [Week 12],
  [M4: Launch], [System Deployment & Handover], [Week 16],
)

#v(2em)
#plan-block(title: "Project Commitment")[
  By defining these boundaries and objectives, the MedConnect team ensures a high-quality delivery that avoids "Scope Creep" while maximizing clinical value. The focus remains on stability, security, and user accessibility.
]

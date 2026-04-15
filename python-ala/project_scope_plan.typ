#set document(title: "IT Project Plan: MedConnect Scope & Objectives", author: "Project Engineering Group")
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  // header: align(right)[#text(fill: luma(100), size: 8pt, weight: "medium")[ASSIGNMENT 2 | PROJECT SCOPE & OBJECTIVES]],
  footer: [
    #set text(size: 8pt, fill: luma(150))
    #grid(
      columns: (1fr, 1fr),
      [-------------------------], align(right)[Page #context counter(page).display()],
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
  #text(size: 22pt, weight: "bold", fill: rgb("#0d47a1"))[MedConnect: Project Scope & Planning] \
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

= 1. Project Scope Definition
The scope of *MedConnect* is focused on the "Digital Front Door" of clinical operations—specifically the interface between patient symptoms and physician time.

== 1.1 In-Scope Deliverables
- *Patient Triage Interface:* A symptom-input system utilizing clinical decision-tree logic.
- *Autonomous Scheduling Engine:* Real-time calendar synchronization with physician availability.
- *Administrative Dashboard:* Management view for clinic staff to oversee triage results and handle overrides.
- *Automated Notification System:* SMS/Email triggers for appointment confirmations and reminders.
- *Secured Database Schema:* HIPAA-compliant (standardized) storage for PII and scheduling logs.

== 1.2 Out-of-Scope (Exclusions)
- *Billing & Insurance Processing:* Integration with financial gateways or insurance verification.
- *Telehealth Video Conferencing:* Built-in video calling modules (referral to external services).
- *Comprehensive EHR:* Replacement of internal medical record systems (MedConnect acts as a middleware).

= 2. Project Objectives (SMART)
The success of MedConnect is predicated on achieving the following specific, measurable goals:

+ *Primary Objective:* Deploy a fully functional triage and scheduling prototype within a 16-week timeline that handles 100% of digital bookings without manual intervention.
+ *Efficiency Goal:* Reduce the time required for a patient to secure an appointment from an average of 8 minutes (phone) to under 2 minutes (portal).
+ *Accuracy Goal:* Achieve a *Zero Double-Booking* incident rate through atomic database transactions.
+ *Clinical Safety:* Ensure 100% of high-urgency symptoms (as defined by the logic tree) are flagged for immediate administrative review within 60 seconds of submission.
#pagebreak()
= 3. Resource Requirements
The project necessitates a lean but highly specialized team and a strategic allocation of technical resources.

== 3.1 Personnel
- *1 x Project Manager (PM):* Overseeing SDLC, stakeholder alignment, and risk mitigation.
- *2 x Backend Developers (Python/Flask):* Focused on triage algorithms and API security.
- *1 x Frontend Developer (UI/UX):* Creating the patient-facing responsive interface.
- *1 x Clinical Consultant (Subject Matter Expert):* Verifying the accuracy of triage logic trees.

== 3.2 Technical & Financial Resources
- *Infrastructure:* Cloud-based hosting (AWS/Azure) for staging and production environments.
- *Software Tools:* GitHub for version control, Jira for task tracking, and Figma for design.
- *Budget Allocation:* Estimated total of \$45,000 for initial development, licensing, and 12-month maintenance.

= 4. Timing & Milestones
High-level timing for the 16-week iterative development cycle.

#v(1em)
#table(
  columns: (1fr, 2fr, 1.5fr),
  inset: 10pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if x == 0 { rgb("#eceff1") },
  [*Milestone*], [*Key Activities*], [*Expected Date*],
  [M1: Scoping], [Requirement Lock & UX Design], [Week 3],
  [M2: Alpha], [Triage Engine & DB Integration], [Week 8],
  [M4: Beta], [UAT with Clinic Staff & Patients], [Week 12],
  [M5: Launch], [Full System Deployment], [Week 16],
)

#v(2em)

#plan-block(title: "Project Commitment")[
  By defining these boundaries and objectives, the MedConnect team ensures a high-quality delivery that avoids "Scope Creep" while maximizing clinical value. The focus remains on stability, security, and user accessibility.
]

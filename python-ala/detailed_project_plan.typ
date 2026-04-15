#set document(title: "IT Project Plan: MedConnect Detailed Blueprint", author: "Project Engineering Group")
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  // header: align(right)[#text(fill: luma(100), size: 8pt, weight: "medium")[ASSIGNMENT 3 | DETAILED PROJECT BLUEPRINT]],
  footer: [
    #set text(size: 8pt, fill: luma(150))
    #grid(
      columns: (1fr, 1fr),
      [-----------------------], align(right)[Page #context counter(page).display()],
    )
  ],
)

#set text(
  font: ("Inter", "Liberation Sans", "DejaVu Sans"),
  size: 9.5pt,
  weight: "light",
  fill: rgb("#263238"),
)

#show heading: it => [
  #set text(fill: rgb("#0d47a1"), weight: "bold")
  #v(1.2em, weak: true)
  #it
  #v(0.6em, weak: true)
]

#set par(justify: true, leading: 0.6em)

// --- TITLE ---
#v(1em)
#align(center)[
  #text(size: 20pt, weight: "bold", fill: rgb("#0d47a1"))[MedConnect Project Blueprint] \
  #v(0.3em)
  #text(
    size: 10pt,
    weight: "medium",
    fill: rgb("#546e7a"),
  )[Assignment 3: Integrated Task Management & Communication Strategy] \
  #v(1em)
  #line(length: 30%, stroke: 0.5pt + luma(200))
]

= 1. Granular Work Breakdown Structure (WBS)
The execution of *MedConnect* is partitioned into four major phases, with specific sub-tasks assigned to ensure operational transparency.

#table(
  columns: (0.6fr, 2.5fr, 1fr),
  inset: 6pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if x == 0 { rgb("#f1f7fd") } else if y == 0 { rgb("#0d47a1") },
  [*ID*], [#text(fill: white)[*Phase / Task Description*]], [#text(fill: white)[*Owner*]],
  [*P1*], [*Discovery & Logic Definition*], [*PM*],
  [1.1], [-- Conduct clinical stakeholder discovery workshops.], [PM / SME],
  [1.2], [-- Map decision-tree logic for urgent vs routine triage.], [SME],
  [1.3], [-- Finalize UI/UX wireframes for patient onboarding portal.], [FE Designer],
  [*P2*], [*Core Development Sprint*], [*Dev Team*],
  [2.1], [-- Provision secure cloud infrastructure (PostgreSQL/Redis).], [BE Dev],
  [2.2], [-- Engineer the Flask-based Triage Intelligence API.], [BE Dev],
  [2.3], [-- Build responsive frontend booking interface components.], [FE Dev],
  [*P3*], [*Security & Validation Phase*], [*QA / Dev*],
  [3.1], [-- Perform automated security hardening and pen-testing.], [BE Dev],
  [3.2], [-- Execute UAT cycles with clinic administrative staff.], [PM / SME],
  [*P4*], [*Deployment & Closure*], [*DevOps*],
  [4.1], [-- Execute final production deployment and DNS sync.], [DevOps],
  [4.2], [-- Deliver staff training modules and technical handbook.], [PM],
)

= 2. Project Timeline & Blueprint
The following Gantt chart visualizes the overlaps and critical dependencies required to meet the Week-16 launch.

#v(1em)
#let gantt-bar(start, end, fill-color, stroke-color, label) = {
  grid(
    columns: (1fr * start, 1fr * (end - start), 1fr * (16 - end)),
    [],
    rect(width: 100%, height: 1.2em, fill: fill-color, stroke: 0.5pt + stroke-color, radius: 2pt)[
      #set align(center + horizon)
      #text(size: 6.5pt, fill: stroke-color.darken(30%))[#label]
    ],
    [],
  )
}

#box(width: 100%, stroke: 0.5pt + luma(200), inset: 8pt, radius: 4pt)[
  #grid(columns: (1.2fr, 0.8fr, ..(1fr,) * 16), gutter: 2pt, [], [], ..range(1, 17).map(i => text(size: 6pt, fill: luma(150))[W#i]))
  #v(0.3em)
  #let task-row(phase, id, start, end, color) = grid(columns: (1.2fr, 0.8fr, 16fr), gutter: 2pt, text(size: 7.5pt)[#phase], text(size: 7.5pt)[#id], gantt-bar(start, end, color.lighten(80%), color, ""))
  #task-row("Discovery", "1.1-1.3", 0, 4, rgb("#0d47a1"))
  #task-row("App Dev", "2.1-2.3", 4, 11, rgb("#2e7d32"))
  #task-row("Testing", "3.1-3.2", 10, 14, rgb("#f57c00"))
  #task-row("Launch", "4.1-4.2", 14, 16, rgb("#d32f2f"))
]

#v(1em)

= 3. Project Risk Register & Mitigation
We have identified high-impact risks with proactive strategies to ensure clinical and technical stability.

#table(
  columns: (1fr, 0.8fr, 0.8fr, 2fr),
  inset: 7pt,
  fill: (x, y) => if y == 0 { rgb("#ECEFF1") },
  [*Risk Event*], [*Prob.*], [*Impact*], [*Mitigation Strategy*],
  [Triage Logic Error], [Low], [Critical], [Mandatory double-sign-off by clinical SMEs for all trees.],
  [Security Breach], [Medium], [Critical], [Implementation of Zero-Trust and AES-256 vault protocols.],
  [Resource Churn], [Low], [High], [Maintain detailed technical shadowing and documentation.],
  [Staff Resistance], [Medium], [Medium], [Incentivize feedback early via the Beta UAT phase.],
)

= 4. Roles & Responsibilities (RACI Matrix)
#table(
  columns: (2fr, 0.8fr, 0.8fr, 0.8fr, 0.8fr),
  inset: 6pt,
  align: center,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#ECEFF1") },
  [*Key Deliverable*], [*PM*], [*Dev BE*], [*Dev FE*], [*SME*],
  [Requirement Spec], [A/R], [C], [I], [R],
  [Logic Intelligence API], [I], [R/A], [I], [C],
  [Patient Portal UI], [C], [I], [R/A], [I],
  [System Security Audit], [A], [R], [C], [I],
  [Final UAT Report], [R/A], [C], [C], [R],
)

= 5. Quality Assurance & Testing Plan
MedConnect follows a "Safety-First" QA methodology.
- *Unit Testing:* Automated Python/PyTest suites for all logic-tree execution paths.
- *Security Audit:* OWASP Top 10 vulnerability assessment prior to deployment.
- *Clinical UAT:* 3-stage validation: Alpha (Dev walkthrough), Beta (Admin use), and Final (Parallel run).

= 6. Integrated Communication Plan
#table(
  columns: (1fr, 1.5fr, 1fr, 1.5fr),
  inset: 7pt,
  fill: (x, y) => if y == 0 { rgb("#ECEFF1") },
  [*Component*], [*Target Stakeholders*], [*Freq*], [*Channel / Deliverable*],
  [Stand-ups], [Dev Team / Project Lead], [Daily], [Slack Collaboration Channel.],
  [Board Progress], [Clinic Administrators], [Weekly], [Automated PDF Status Report.],
  [Logic Review], [Clinical SME / Devs], [Weekly], [Technical workshop (Teams/Zoom).],
  [Release Notes], [Entire Staff Ecosystem], [Phase-End], [Briefing Memo & Roadmap update.],
)

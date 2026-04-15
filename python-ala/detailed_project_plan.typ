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

= 1. Work Breakdown Structure (WBS)
The project is decomposed into granular tasks across four primary execution phases.

#table(
  columns: (0.8fr, 3fr, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if x == 0 { rgb("#f1f7fd") } else if y == 0 { rgb("#0d47a1") },
  [*ID*], [#text(fill: white)[*Task Description*]], [#text(fill: white)[*Owner*]],
  [1.1], [Stakeholder interviews and requirement validation], [PM],
  [1.2], [UI/UX Wireframing and Patient Journey mapping], [FE Designer],
  [2.1], [Database schema implementation (SQLite/SQLAlchemy)], [BE Dev],
  [2.2], [Clinical triage logic tree development in Python], [BE Dev / SME],
  [2.3], [Frontend Portal integration with Flask API], [FE Dev],
  [3.1], [Integrated Security Audit & Penetration Testing], [QA / Dev],
  [3.2], [User Acceptance Testing (UAT) with Clinic Staff], [PM / SME],
  [4.1], [Final Cloud Deployment and DNS configuration], [DevOps],
)

= 2. Project Timeline (Blueprint Visualization)
The following Gantt chart illustrates the 16-week timeline, highlighting phase overlaps and critical milestones.

#let gantt-bar(start, end, fill-color, stroke-color, label) = {
  grid(
    columns: (1fr * start, 1fr * (end - start), 1fr * (16 - end)),
    [],
    rect(width: 100%, height: 1.25em, fill: fill-color, stroke: 0.5pt + stroke-color, radius: 2pt)[
      #set align(center + horizon)
      #text(size: 7pt, fill: stroke-color.darken(30%))[#label]
    ],
    [],
  )
}

#box(width: 100%, stroke: 0.5pt + luma(200), inset: 10pt, radius: 4pt)[
  // Header: Months
  #grid(
    columns: (1.5fr, 1fr, 4fr, 4fr, 4fr, 4fr),
    gutter: 2pt,
    [*Phase*], [*ID*], [*Month 1*], [*Month 2*], [*Month 3*], [*Month 4*],
  )
  #v(0.5em)
  #line(length: 100%, stroke: 0.2pt + luma(200))
  #v(0.5em)

  // Header: Weeks
  #grid(
    columns: (1.5fr, 1fr, ..(1fr,) * 16),
    gutter: 2pt,
    [], [], ..range(1, 17).map(i => text(size: 6pt, fill: luma(150))[W#i]),
  )
  #v(0.5em)

  // Tasks
  #let task-row(phase, id, start, end, color) = grid(
    columns: (1.5fr, 1fr, 16fr),
    gutter: 2pt,
    text(size: 8pt)[#phase], text(size: 8pt)[#id], gantt-bar(start, end, color.lighten(80%), color, ""),
  )

  #task-row("Discovery", "1.1", 0, 3, rgb("#0d47a1"))
  #task-row("", "1.2", 2, 5, rgb("#0d47a1"))
  #v(0.3em)
  #task-row("Dev", "2.1", 4, 9, rgb("#2e7d32"))
  #task-row("", "2.2", 5, 10, rgb("#2e7d32"))
  #task-row("", "2.3", 7, 11, rgb("#2e7d32"))
  #v(0.3em)
  #task-row("Testing", "3.1", 10, 13, rgb("#f57c00"))
  #task-row("", "3.2", 12, 14, rgb("#f57c00"))
  #v(0.3em)
  #task-row("Launch", "4.1", 14, 16, rgb("#d32f2f"))
]

= 3. Roles and Responsibilities (RACI Matrix)
#table(
  columns: (2fr, 1fr, 1fr, 1fr, 1fr),
  inset: 6pt,
  align: center,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#ECEFF1") },
  [*Deliverable*], [*PM*], [*Dev BE*], [*Dev FE*], [*SME*],
  [Project Charter], [A/R], [C], [I], [C],
  [Triage Logic Engine], [I], [R/A], [I], [C],
  [User Interface], [C], [I], [R/A], [I],
  [Test Reports], [A], [C], [C], [R],
  [Security Hardening], [I], [R/A], [C], [I],
)
#text(size: 8pt, style: "italic")[R: Responsible, A: Accountable, C: Consulted, I: Informed]

= 4. Communication Plan
#table(
  columns: (1fr, 1.5fr, 1fr, 1.5fr),
  inset: 7pt,
  fill: (x, y) => if y == 0 { rgb("#ECEFF1") },
  [*Meeting/Report*], [*Stakeholders*], [*Freq.*], [*Channel*],
  [Daily Stand-up], [Internal Dev Team], [Daily], [Slack / Teams],
  [Status Report], [Clinic Admin], [Weekly], [Email / PDF],
  [Sprint Review], [Project Steering Group], [Monthly], [Video Conf.],
  [Incident Alert], [DevOps / PM], [As Needed], [Automated SMS],
)

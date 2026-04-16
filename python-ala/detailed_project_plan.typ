#import "@preview/timeliney:0.4.0"
#set document(
  title: "IT Project Plan: MedConnect Detailed Blueprint",
  author: "Project Engineering Group",
)
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  // header: aligs
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
  #text(
    size: 20pt,
    weight: "bold",
    fill: rgb("#0d47a1"),
  )[MedConnect Project Blueprint] \
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
  fill: (x, y) => if x == 0 { rgb("#f1f7fd") } else if y == 0 {
    rgb("#0d47a1")
  },
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

#pagebreak()

= 2. Project Timeline
The following technical blueprint illustrates the 16-week execution cycle, detailing individual task dependencies and phased integration.

#v(1em)

#block(
  width: 100%,
  stroke: 0.5pt + luma(200),
  radius: 4pt,
  inset: 10pt,
)[
  #timeliney.timeline(
    show-grid: true,
    {
      import timeliney: *
      headerline(
        group(([*Month 1*], 4)),
        group(([*Month 2*], 4)),
        group(([*Month 3*], 4)),
        group(([*Month 4*], 4)),
      )
      headerline(
        ..range(1, 17).map(i => group((text(7pt)[W#i], 1))),
      )

      taskgroup(title: [*P1: Discovery & Logic*], {
        task("Stakeholder Discovery", (0, 3), style: (stroke: 10pt + rgb("#1976d2").lighten(80%)))
        task("Logic Tree Mapping", (2, 6), style: (stroke: 10pt + rgb("#1565c0").lighten(80%)))
        task("UI/UX Design", (4, 8), style: (stroke: 10pt + rgb("#0d47a1").lighten(80%)))
      })

      taskgroup(title: [*P2: Core Development*], {
        task("Cloud Infrastructure", (7, 10), style: (stroke: 10pt + rgb("#2e7d32").lighten(80%)))
        task("Intelligence API Dev", (8, 13), style: (stroke: 10pt + rgb("#388e3c").lighten(80%)))
        task("Portal Integration", (10, 14), style: (stroke: 10pt + rgb("#43a047").lighten(80%)))
      })

      taskgroup(title: [*P3: Security & Validation*], {
        task("Security Hardening", (13, 15), style: (stroke: 10pt + rgb("#ef6c00").lighten(80%)))
        task("User Acceptance Test", (14, 16), style: (stroke: 10pt + rgb("#f57c00").lighten(80%)))
      })

      taskgroup(title: [*P4: Deployment & Closure*], {
        task("Production Rollout", (15, 16), style: (stroke: 10pt + rgb("#c62828").lighten(80%)))
        task("Project Handover", (15, 16.1), style: (stroke: 10pt + rgb("#d32f2f").lighten(80%)))
      })

      milestone(at: 3, style: (stroke: (dash: "dashed")), [M1])
      milestone(at: 8, style: (stroke: (dash: "dashed")), [M2])
      milestone(at: 12, style: (stroke: (dash: "dashed")), [M3])
      milestone(at: 16, style: (stroke: (dash: "dashed")), [M4])
    },
  )
]

#v(1em)

= 3. Project Risk Register & Mitigation
We have identified high-impact risks with proactive strategies to ensure clinical and technical stability.

#table(
  columns: (1fr, 0.8fr, 0.8fr, 2fr),
  inset: 7pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if x == 0 { rgb("#f1f7fd") },
  [*Risk Event*],
  [#text(fill: white)[*Prob.*]],
  [#text(fill: white)[*Impact*]],
  [#text(fill: white)[*Mitigation Strategy*]],

  [Triage Logic Error], [Low], [Critical], [Mandatory double-sign-off by clinical SMEs for all trees.],
  [Security Breach], [Medium], [Critical], [Implementation of Zero-Trust and AES-256 vault protocols.],
  [Resource Churn], [Low], [High], [Maintain detailed technical shadowing and documentation.],
  [Staff Resistance], [Medium], [Medium], [Incentivize feedback early via the Beta UAT phase.],
)
#pagebreak()
= 4. Roles & Responsibilities (RACI Matrix)
#table(
  columns: (2fr, 0.8fr, 0.8fr, 0.8fr, 0.8fr),
  inset: 6pt,
  align: center,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if x == 0 { rgb("#f1f7fd") },
  [*Key Deliverable*],
  [#text(fill: white)[*PM*]],
  [#text(fill: white)[*Dev BE*]],
  [#text(fill: white)[*Dev FE*]],
  [#text(fill: white)[*SME*]],

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
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if x == 0 { rgb("#f1f7fd") },
  [*Component*],
  [#text(fill: white)[*Target Stakeholders*]],
  [#text(fill: white)[*Freq*]],
  [#text(fill: white)[*Channel / Deliverable*]],

  [Stand-ups], [Dev Team / Project Lead], [Daily], [Slack Collaboration Channel.],
  [Board Progress], [Clinic Administrators], [Weekly], [Automated PDF Status Report.],
  [Logic Review], [Clinical SME / Devs], [Weekly], [Technical workshop (Teams/Zoom).],
  [Release Notes], [Entire Staff Ecosystem], [Phase-End], [Briefing Memo & Roadmap update.],
)

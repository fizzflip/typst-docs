#set document(
  title: "Cyber Law Gap Analysis: A Global Perspective",
  author: "[STUDENT NAME]",
)
#set text(
  font: ("Libertinus Serif", "Georgia", "Times New Roman", "serif"),
  size: 11pt,
  lang: "en",
)
#let heading-font = "DeepMind Sans"
#let ui-font = "Inter"

// --- Cyber-Modernist Design System ---
#let primary-color = rgb("#0f172a") // Deep Midnight
#let accent-color = rgb("#22d3ee") // Sharp Cyan
#let secondary-color = rgb("#f1f5f9") // Light Slate
#let border-color = rgb("#cbd5e1")
#let text-muted = rgb("#64748b")
#let warning-red = rgb("#ef4444")
#let success-green = rgb("#10b981")

// --- Resuable Components ---

// Callout for "Gap Identification"
#let gap-box(title: "GAP IDENTIFIED", body) = block(
  width: 100%,
  fill: rgb("#fff1f2"), // Very light red
  stroke: (left: 4pt + warning-red),
  inset: 16pt,
  radius: 4pt,
  [
    #text(10pt, weight: "bold", fill: warning-red)[#upper(title)]
    #v(0.4em)
    #text(10.5pt, fill: primary-color.lighten(10%))[#body]
  ],
)

// Callout for "Proposed Change"
#let change-box(title: "PROPOSED AMENDMENT", body) = block(
  width: 100%,
  fill: rgb("#f0fdf4"), // Very light green
  stroke: (left: 4pt + success-green),
  inset: 16pt,
  radius: 4pt,
  [
    #text(10pt, weight: "bold", fill: success-green)[#upper(title)]
    #v(0.4em)
    #text(10.5pt, fill: primary-color.lighten(10%))[#body]
  ],
)

// Standard callout
#let callout(title: "", body, color: primary-color) = block(
  width: 100%,
  fill: secondary-color,
  stroke: (left: 4pt + color),
  inset: 16pt,
  radius: 4pt,
  [
    #if title != "" {
      text(10pt, weight: "bold", fill: primary-color)[#upper(title)]
      v(0.4em)
    }
    #text(10.5pt, fill: primary-color.lighten(10%))[#body]
  ],
)

// --- Page Setup ---
#set page(
  paper: "a4",
  margin: (x: 1in, y: 1in),
  header: context {
    if counter(page).get().first() > 1 {
      box(
        width: 100%,
        stroke: (bottom: 0.5pt + border-color),
        inset: (bottom: 8pt),
        [
          #text(
            8pt,
            fill: text-muted,
          )[Cyber Law and Ethics | *Gap Analysis Report*]
          #h(1fr)
          #text(8pt, fill: text-muted)[April 2026]
        ],
      )
    }
  },
  footer: context {
    let page-number = counter(page).get().first()
    align(center)[
      #text(9pt, weight: "bold", fill: primary-color)[#page-number]
    ]
  },
)

#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.1 ")

// Custom heading styling
#show heading: it => {
  let color = if it.level == 1 { primary-color } else {
    primary-color.lighten(20%)
  }
  set text(font: heading-font, weight: "bold", fill: color)
  block(below: 1em, above: 1.5em)[
    #if it.level == 1 {
      text(size: 18pt)[#upper(it.body)]
    } else if it.level == 2 {
      text(size: 14pt)[#it.body]
    } else {
      text(size: 12pt)[#it.body]
    }
  ]
}

// --- Cover Page ---
#set page(margin: (x: 0in, y: 0in))
#grid(
  columns: (1.2fr, 2.8fr),
  rows: 100%,
  // Sidebar
  rect(
    fill: primary-color,
    width: 100%,
    height: 100%,
  ),
  // Main Content
  pad(x: 40pt, y: 60pt)[
    #v(4em)
    #text(
      12pt,
      tracking: 2pt,
      weight: "bold",
      font: heading-font,
      fill: accent-color,
    )[CYBER LAW & ETHICS] \
    #v(1em)
    #par(leading: 1em)[
      #text(40pt, font: heading-font, weight: "bold", fill: primary-color)[
        Global \ Cyber  Law:\ Gap  Analysis, \ Proposed \ Solutions
      ]
    ]

    #v(2em)
    #line(length: 20%, stroke: 2pt + accent-color)
    #v(2em)

    #text(14pt, fill: text-muted, font: "DeepMind Sans")[
      A strategic identification of legal voids \ in emerging technology governance \
      and proposed legislative frameworks \ for the 2025-2030 digital epoch.
    ]

    #v(1fr)

    #grid(
      columns: (1fr, 1fr),
      align(left)[
        #text(weight: "bold", fill: primary-color)[PREPARED BY] \
        #v(0.5em)
        #text(size: 10pt, fill: text-muted)[
          Name: *[STUDENT NAME]* \
          Roll No: *[ROLL NUMBER]* \
          Section: *[SECTION]*
        ]
      ],
      align(left)[
        #text(weight: "bold", fill: primary-color)[SUBMITTED TO] \
        #v(0.5em)
        #text(
          size: 10pt,
          fill: text-muted,
        )[Cyber Law and Ethics \ Faculty of Engineering \ GMIU Web Portal Submission]
      ],
    )
  ],
)

// --- Main Content Begins ---
#set page(margin: (x: 1in, y: 1in))
#pagebreak()

#outline(depth: 3, indent: auto)
#pagebreak()

= Executive Summary

As the digital landscape evolves with unprecedented velocity, national legal frameworks are struggling to maintain parity with technological advancements. The "Cyber Law Gap" refers to the growing discrepancy between the capabilities of emerging technologies—such as Generative AI, Quantum Computing, and Decentralized Finance—and the regulatory structures designed to govern them.

This report identifies three critical gaps in the current global cyber law matrix: *Regulatory Fragmentation*, *Algorithmic Accountability Voids*, and *Enforcement Paralysis* in borderless cybercrime. Through a comparative analysis of laws from India (DPDP Act 2023), the European Union (AI Act), and China (Data Security Law), this document proposes a transition from reactive, "patchwork" legislation to proactive, "Secure-by-Design" legal standards. The following recommendations advocate for harmonized international extradition protocols and tiered compliance mandates to ensure cyber equity across the global supply chain.

#v(2em)
#align(center)[
  #line(length: 80%, stroke: 0.5pt + border-color)
]
#v(1em)

= Comparative Landscape: \ Diversity of Approach

Before identifying specific gaps, it is essential to understand the divergent philosophies currently shaping the global cyber landscape.

#v(1em)
#figure(
  caption: [Comparison of Major Cyber Law Philosophies (2024-2025)],
  table(
    columns: (1fr, 1.5fr, 1.5fr),
    fill: (x, y) => if y == 0 { primary-color } else if calc.odd(y) {
      secondary-color.lighten(30%)
    } else { white },
    stroke: none,
    inset: (x: 10pt, y: 12pt),
    align: (left, left, left),

    [#text(fill: white, weight: "bold", size: 9pt)[JURISDICTION]],
    [#text(fill: white, weight: "bold", size: 9pt)[PRIMARY FOCUS]],
    [#text(fill: white, weight: "bold", size: 9pt)[KEY LEGISLATION]],

    [*India*],
    [Digital Sovereignty and Secure Public Infrastructure (DPI).],
    [DPDP Act (2023), IT Act (2000).],

    [*European Union*],
    [Fundamental Rights & Consumer Protection (Risk-based).],
    [GDPR, EU AI Act, DORA, NIS2.],

    [*China*],
    [National Security & Centralized Data Control.],
    [Data Security Law, PIPL, Cybersecurity Law.],

    [*United States*],
    [Market-led Resilience & Sectoral Privacy.],
    [CIRCIA (Critical Infrastructure), CCPA (State level).],
  ),
)

#pagebreak()

= Critical Gap: The 'Technological Lag'

The most pervasive gap in modern cyber law is the temporal delay between innovation and codification.

\

== Gap 1: Algorithmic Accountability and AI Governance

While the EU AI Act represents a pioneering effort, most global jurisdictions lack clear definitions for "liability" in autonomous systems.

#gap-box[
  *Liability in Autonomous Damages:* Current tort laws are ill-equipped to handle situations where an AI agent causes financial or physical harm without clear human negligence. There is no legal "personhood" for AI, leading to a "Responsibility Gap" where victims cannot seek redress.
]

#change-box[
  *Legislative Amendment:* Implement a "Strict Liability" framework for developers of high-risk AI systems, coupled with mandatory professional indemnity insurance, ensuring that the manufacturer—not the end-user—is primarily liable for foundational model failures.
]

\

== Gap 2: The Jurisdictional 'Safe Haven' Problem

Cybercriminals often operate from jurisdictions that do not recognize "digital crimes" in the same capacity as western nations, or where extradition treaties are non-existent.

#gap-box[
  *Extradition Deficit:* The borderless nature of the internet allows malicious actors to launch attacks from "legal grey zones" where local authorities lack the motivation or mandates to cooperate with international agencies like INTERPOL.
]

#change-box[
  *Proposed Change:* Development of a *Global Cyber-Crime Treaty* (similar to the Budapest Convention but with broader non-western inclusion) that standardizes "Dual Criminality" definitions and fast-tracks digital evidence sharing.
]

#pagebreak()

== Gap 3: Data Sovereignty vs. Interoperability

While nations like India and China emphasize data localization to protect national interests, this creates a significant conflict with the borderless nature of SaaS and cloud providers.

#gap-box[
  *The 'Balkanization' of Data:* Localization mandates often conflict with the General Data Protection Regulation (GDPR) or the APEC Cross-Border Privacy Rules (CBPR). This results in "Compliance Paralysis" for small enterprises that cannot afford to build isolated data centers in every operating jurisdiction.
]

#change-box[
  *Strategic Recommendation:* Development of "Federated Data Architectures" within cyber law. Laws should permit the movement of data across borders provided that the destination country maintains a "Digital Adequacy" status, rather than requiring physical servers on-shore.
]

#pagebreak()

= Recommendations: A Blueprint for 2025-2030

To bridge the identified gaps, legal frameworks must transition from static, reactive rules to dynamic, technology-agnostic principles.

== Recommendation 1: Implementation of 'Regulatory Sandboxes'
Governments should legalize "Regulatory Sandboxes" for AI and Fintech startups. This allows innovators to test products in a controlled environment under the supervision of regulators, identifying legal risks before a full market rollout.
- *Advantage:* Reduces the "Technological Lag" by allowing regulators to learn alongside innovators.

== Recommendation 2: Tiered SME Compliance Frameworks
Current cyber laws (like the DPDP Act or GDPR) apply similar burdens to a small startup as they do to a global conglomerate.
- *Proposed Change:* A tiered system where compliance requirements (and potential fines) are scaled based on the organization's data volume and revenue, preventing "Cyber Inequity."

== Recommendation 3: Universal 'Secure-by-Design' Mandates
Move the legal burden of security from the consumer to the manufacturer.
- *Proposed Change:* New legislation should mandate that all IoT and software products must meet minimum security baselines (e.g., no default passwords, mandatory encryption) before they can be legally sold in the marketplace.

#v(2em)
#align(center)[
  #line(length: 80%, stroke: 0.5pt + border-color)
]
#v(1em)


= Conclusion

The "Cyber Law Gap" is not merely a technical oversight but a fundamental challenge to the global digital economy. As we approach 2030, the reliance on fragmented, nationalistic, and reactive laws will only embolden malicious actors and stifle innovation.

The transition toward a *Harmonized Global Cyber Framework*—one that prioritizes algorithmic accountability, fast-tracks international cooperation, and protects the most vulnerable links in the supply chain—is no longer optional. For students and practitioners of Cyber Law and Ethics, the task is to advocate for a legal system that is as resilient, borderless, and adaptive as the technologies it seeks to govern.


#pagebreak()

= Appendix: Glossary of Terms

#grid(
  columns: (1.2fr, 6fr),
  gutter: 1.5em,
  [#text(weight: "bold", fill: primary-color)[Balkanization]],
  [The fragmentation of the internet into smaller, isolated national networks due to localization laws.],

  [#text(weight: "bold", fill: primary-color)[Dual \ Criminality]],
  [The principle that a crime must be a crime in both countries involved for extradition to occur.],

  [#text(weight: "bold", fill: primary-color)[iCET]],
  [Initiative on Critical and Emerging Technology; a bilateral framework between US and India.],

  [#text(weight: "bold", fill: primary-color)[PIPL]],
  [Personal Information Protection Law (China's equivalent of GDPR).],

  [#text(weight: "bold", fill: primary-color)[Regulatory Sandbox]],
  [A framework provided by regulators to allow small-scale, live testing of innovations in a controlled environment.],

  [#text(weight: "bold", fill: primary-color)[SME]],
  [Small and Medium-sized Enterprises; often the most vulnerable to high compliance costs.],
)


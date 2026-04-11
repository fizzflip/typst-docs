#set document(title: "Cyber Policy Comparison: India vs USA", author: "Student")
#set text(font: ("Libertinus Serif", "Linux Libertine", "Times New Roman", "serif"), size: 11pt, lang: "en")
#set page(
  paper: "a4",
  margin: (x: 1in, y: 1.25in),
  header: context {
    if counter(page).get().first() > 1 {
      align(right)[
        #text(8pt, fill: luma(120))[Cyber Law and Ethics | GMIU Assignment]
      ]
    }
  },
  footer: context {
    let page-number = counter(page).get().first()
    align(center)[
      #text(8pt, fill: luma(120))[- #page-number -]
    ]
  },
)

#set par(justify: true, leading: 0.65em)

// Custom heading styling
#show heading.where(level: 1): it => block(
  above: 1.5em,
  below: 1em,
)[
  #set text(font: "Arial", size: 16pt, weight: "bold", fill: rgb("#1a365d"))
  #it.body
]

// Custom title block
#align(center)[
  #v(2em)
  #box(
    width: 100%,
    stroke: (bottom: 2pt + rgb("#1a365d")),
    inset: (bottom: 1em),
    [
      #text(
        24pt,
        font: "Arial",
        weight: "bold",
        fill: rgb("#1a365d"),
      )[Comparative Cyber Policy Analysis] \
      #v(0.5em)
      #text(14pt, fill: luma(100))[India vs. United States of America]
    ],
  )
  #v(1em)
  #grid(
    columns: (1fr, 1fr),
    align(left)[
      *Subject:* Cyber Law and Ethics \
      *Institution:* GMIU 
    ],
    align(right)[
      *Date:* #datetime.today().display() \
      *Assignment:* Comparative Table
    ],
  )
  #v(2em)
]

= Introduction

The cybersecurity policies of India and the United States reflect their unique legal systems, digital landscapes, and strategic priorities. While both nations share a commitment to an open, secure, and resilient cyberspace and collaborate closely on cyber defense, their domestic approaches differ significantly. The United States employs a decentralized, sector-specific strategy heavily reliant on public-private partnerships, whereas India utilizes a more centralized, government-led approach to secure its rapidly expanding digital infrastructure.

#v(1em)

= Comparative Policy Analysis

#figure(
  caption: [Comparison of Cyber Strategies and Policies: India vs. United States],
  kind: table,
  table(
    columns: (1fr, 2.5fr, 2.5fr),
    fill: (x, y) => if y == 0 { rgb("#1a365d") } else if calc.odd(y) { rgb("#f8fafc") } else { white },
    stroke: rgb("#e2e8f0"),
    inset: 12pt,
    
    [#text(fill: white)[*Feature*]], 
    [#text(fill: white)[*India*]], 
    [#text(fill: white)[*United States*]],
    
    [*Legal Basis*], 
    [Primarily relies on the Information Technology (IT) Act, 2000 (with amendments) and the newly enacted Digital Personal Data Protection (DPDP) Act, 2023.], 
    [A complex landscape built on a combination of federal laws, state laws, and sector-specific regulations (e.g., HIPAA, GLBA). No single overarching cybersecurity act.],
    
    [*Overall Approach*], 
    [Centralized and government-led. Strategy and institutional mandates drive cybersecurity measures to create a secure digital ecosystem.], 
    [Decentralized, multi-stakeholder, and market-driven. Emphasizes public-private partnerships rather than top-down mandates.],
    
    [*Critical Infrastructure*], 
    [Strong focus on central protection via national agencies like the National Critical Information Infrastructure Protection Centre (NCIIPC) and CERT-In.], 
    [Emphasis on sector-specific regulation. Agencies like CISA collaborate with private industry stakeholders to share threat intelligence and standards.],
    
    [*Strategic Goal*], 
    [Capacity building, massive skill development, and creating a trusted, resilient digital society to empower its rapidly growing economy.], 
    [Hardening federal networks, disrupting adversaries, and shifting liability to tech providers to drive security through market accountability.],
    
    [*Data Privacy*], 
    [Historically part of the IT Act, now shifting to integrated frameworks via the DPDP Act, which firmly regulates the processing of personal digital data.], 
    [A patchwork of state laws (like the CCPA in California) and sector regulations. Strongly relies on corporate accountability and liability.],
    
    [*Standards & Compliance*], 
    [Often aligns practices with international standards but heavily relies on indigenous frameworks formulated by MeitY and DSCI.], 
    [Highly reliant on voluntary and mandatory standards formulated by the National Institute of Standards and Technology (NIST) and CISA frameworks.]
  ),
)

#v(1em)

= Conclusion

Despite structural differences—India's centralized capacity-building focus versus the US's decentralized, market-driven mechanisms—both countries maintain a strong strategic partnership in cyberspace. They actively align on global norms advocating for a rules-based cyberspace order and engage in threat intelligence sharing to fortify joint resilience against globally evolving cyber threats.

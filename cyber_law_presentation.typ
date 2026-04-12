// ══════════════════════════════════════════════════════════════════════════════
//  CYBER LAWS, CYBERCRIME & ETHICAL DILEMMAS — A Case Study Analysis
//  Touying Metropolis Theme · 16:9 · Cyber-Modernist Palette
// ══════════════════════════════════════════════════════════════════════════════

#import "@preview/touying:0.7.1": *
#import themes.metropolis: *

// ── Color Palette (Cyber-Modernist) ──────────────────────────────────────────
#let midnight = rgb("#0f172a")
#let deep-slate = rgb("#1e293b")
#let cyan-acc = rgb("#22d3ee")
#let slate-text = rgb("#94a3b8")
#let light-bg = rgb("#f1f5f9")
#let warn-red = rgb("#ef4444")
#let amber = rgb("#f59e0b")
#let emerald = rgb("#10b981")

// ── Theme Configuration ─────────────────────────────────────────────────────
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Cyber Laws, Cybercrime \ & Ethical Dilemmas],
    subtitle: [A Comprehensive Case Study Analysis],
    author: [Sandeep Prasad],
    // institution: [GMIU — Department of Computer Science & Engineering],
    date: [April 2026],
  ),
  config-colors(
    primary: midnight,
    primary-light: midnight.lighten(75%),
    secondary: deep-slate,
    neutral-lightest: white,
    neutral-dark: deep-slate,
    neutral-darkest: midnight,
  ),
  // Header: show section title (Level 1)
  header: self => utils.display-current-heading(level: 1),
  // Footer: only slide numbers on the right
  footer: none,
  footer-right: context utils.slide-counter.display() + " / " + utils.last-slide-number,
  footer-progress: true,
)

// ── Typography ──────────────────────────────────────────────────────────────
#set text(
  font: ("Inter", "Libertinus Serif"),
  size: 18pt,
  lang: "en",
)
#set strong(delta: 100)

// ── Reusable components ─────────────────────────────────────────────────────

// Case-study card
#let case-card(title: "", year: "", section: "", body) = block(
  width: 100%,
  fill: light-bg,
  stroke: (left: 4pt + cyan-acc),
  inset: 16pt,
  radius: (top-right: 6pt, bottom-right: 6pt),
)[
  #text(weight: "bold", size: 14pt, fill: midnight)[#title]
  #h(1fr)
  #text(size: 11pt, fill: slate-text)[#year  ·  #section]
  #v(6pt)
  #text(size: 15pt)[#body]
]

// Highlight box
#let highlight-box(color: cyan-acc, body) = block(
  width: 100%,
  fill: color.lighten(90%),
  stroke: (left: 3pt + color),
  inset: 14pt,
  radius: 4pt,
)[#body]

// Verdict / judgment badge
#let verdict(body) = box(
  fill: emerald.lighten(85%),
  stroke: 1pt + emerald,
  inset: (x: 10pt, y: 6pt),
  radius: 20pt,
)[#text(size: 12pt, weight: "bold", fill: emerald.darken(20%))[✓ #body]]

// Ethical dilemma badge
#let ethical(body) = box(
  fill: amber.lighten(85%),
  stroke: 1pt + amber,
  inset: (x: 10pt, y: 6pt),
  radius: 20pt,
)[#text(size: 12pt, weight: "bold", fill: amber.darken(20%))[⚖ #body]]

// Danger badge
#let danger(body) = box(
  fill: warn-red.lighten(85%),
  stroke: 1pt + warn-red,
  inset: (x: 10pt, y: 6pt),
  radius: 20pt,
)[#text(size: 12pt, weight: "bold", fill: warn-red.darken(20%))[⚠ #body]]

// Provision tag
#let provision(body) = box(
  fill: midnight.lighten(90%),
  stroke: 0.5pt + midnight.lighten(60%),
  inset: (x: 8pt, y: 4pt),
  radius: 12pt,
)[#text(size: 11pt, fill: midnight)[§ #body]]

// ═══════════════════════════════════════════════════════════════
//  TITLE & OUTLINE
// ═══════════════════════════════════════════════════════════════

#title-slide(
  extra: [
    #v(1em)
    #text(size: 13pt, fill: slate-text)[
      240905050085  ·  X21 (CSE) \
      Cyber Law and Ethics -- ALA-II
    ]
  ],
)

// ═══════════════════════════════════════════════════════════════
//  PART I — INTRODUCTION & LEGAL FRAMEWORK
// ═══════════════════════════════════════════════════════════════

= Introduction

== What is Cyber Law?

#slide[
  *Cyber Law* is the legal framework governing activities in cyberspace -- encompassing computer hardware, software, the internet, and digital communications.

  #v(10pt)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    highlight-box(color: cyan-acc)[
      #text(weight: "bold")[Governance] \
      Legal recognition of electronic records, digital signatures, and e-commerce transactions
    ],
    highlight-box(color: emerald)[
      #text(weight: "bold")[Protection] \
      Safeguarding individuals and organizations from cybercrime, identity theft, and data breaches
    ],
    highlight-box(color: amber)[
      #text(weight: "bold")[Ethics] \
      Establishing moral standards for technology use, privacy, and digital citizenship
    ],
  )
]

== Key Legislation — India

#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    block(
      fill: light-bg,
      inset: 16pt,
      radius: 6pt,
      width: 100%,
    )[
      #text(weight: "bold", size: 16pt, fill: midnight)[Information Technology Act, 2000] \
      #v(6pt)
      - Legal recognition for e-transactions #provision[Section 4]
      - Digital signature framework #provision[Section 5]
      - Cyber offences & penalties #provision[Sections 43–45, 65–74]
      - Amended in *2008* to add Sections 66A–66F
      - Intermediary guidelines #provision[Section 79]
    ],
    block(
      fill: light-bg,
      inset: 16pt,
      radius: 6pt,
      width: 100%,
    )[
      #text(weight: "bold", size: 16pt, fill: midnight)[DPDP Act, 2023] \
      #v(6pt)
      - Digital Personal Data Protection
      - Consent-based data processing
      - Rights of the *Data Principal*
      - Obligations on *Data Fiduciaries*
      - Data Protection Board of India
      - Cross-border data transfer rules
    ],
  )

  #v(8pt)
  #align(center)[
    #text(
      size: 13pt,
      fill: slate-text,
    )[Other relevant statutes: Indian Penal Code (IPC) / Bharatiya Nyaya Sanhita (BNS) · Indian Evidence Act · Copyright Act]
  ]
]

== Scope of This Presentation

#slide(config: config-page(header: none))[
  This presentation examines *three interconnected pillars* of Cyber Law and Ethics:

  #v(12pt)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 16pt,
    block(
      fill: midnight,
      inset: 20pt,
      radius: 8pt,
      width: 100%,
    )[
      #text(fill: cyan-acc, weight: "bold", size: 22pt)[I] \
      #text(fill: white, weight: "bold")[Landmark Case Laws] \
      #v(6pt)
      #text(fill: slate-text, size: 14pt)[
        Supreme Court judgments that shaped India's digital rights landscape
      ]
    ],
    block(
      fill: midnight,
      inset: 20pt,
      radius: 8pt,
      width: 100%,
    )[
      #text(fill: cyan-acc, weight: "bold", size: 22pt)[II] \
      #text(fill: white, weight: "bold")[Cybercrime Incidents] \
      #v(6pt)
      #text(fill: slate-text, size: 14pt)[
        Real-world attacks from \ e-commerce fraud to \ nation-scale ransomware
      ]
    ],
    block(
      fill: midnight,
      inset: 20pt,
      radius: 8pt,
      width: 100%,
    )[
      #text(fill: cyan-acc, weight: "bold", size: 22pt)[III] \
      #text(fill: white, weight: "bold")[Ethical Dilemmas] \
      #v(6pt)
      #text(fill: slate-text, size: 14pt)[
        Tensions between privacy, security, free speech, and innovation
      ]
    ],
  )
]

// ═══════════════════════════════════════════════════════════════
//  PART II — LANDMARK CYBER LAW CASE STUDIES
// ═══════════════════════════════════════════════════════════════

= Landmark Case Studies

== Shreya Singhal v. Union of India (2015)

#slide[
  #case-card(
    title: "Shreya Singhal v. Union of India",
    year: "2015",
    section: "Section 66A, IT Act",
  )[
    Two women arrested in Mumbai for a Facebook post questioning a city-wide shutdown. The case challenged the *constitutionality of Section 66A* of the IT Act.
  ]
  #ethical[Free Speech vs. Online Safety]
  #v(10pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 12pt,
    [
      *Section 66A provided:* \
      - Punishment for sending "grossly offensive" messages
      - Up to *3 years imprisonment* for "annoying" online content
      - Extremely *vague* and *overbroad* language
      - Used to stifle political dissent and satire
    ],
    [
      *Constitutional Challenge:* \
      - Violated *Article 19(1)(a)* -- Freedom of Speech & Expression
      - Failed the *"Reasonable Restriction"* test under Article 19(2)
      - Created a *chilling effect* on free expression online
      - No procedural safeguards against misuse
    ],
  )
]

#slide[
  === Supreme Court Verdict

  #v(8pt)
  #verdict[Section 66A struck down as UNCONSTITUTIONAL]

  #v(12pt)

  *Key observations by the Court:*
  - Terms like _"grossly offensive"_ and _"annoying"_ are inherently subjective and fail the test of *definiteness*
  - The section was _not severable_ — the entire provision was void
  - Distinguished between *"discussion"*, *"advocacy"*, and *"incitement"* — only the last can be restricted
  - Section 69A (government blocking of websites) was upheld as it has *procedural safeguards*

  // #v(12pt)

  #highlight-box(color: cyan-acc)[
    #text(
      size: 14pt,
    )[*Impact:* This landmark decision established that the internet is a *medium of free expression* protected by the Constitution. It remains one of the most cited digital rights judgments globally.]
  ]

]

== K.S. Puttaswamy v. Union of India (2017)

#slide[
  #case-card(
    title: "Justice K.S. Puttaswamy (Retd.) v. Union of India",
    year: "2017",
    section: "Article 21, Constitution of India",
  )[
    Retired Justice Puttaswamy challenged the *Aadhaar project*, arguing that mandatory biometric collection violated the right to privacy. The 9-judge constitutional bench delivered a *unanimous verdict*.
  ]
  #ethical[National Security vs. Civil Liberties]
  #ethical[Individual Privacy vs. State Surveillance] \
  #v(10pt)

  *Background:*
  - The Government of India launched *Aadhaar* -- a 12-digit unique identity number tied to biometric data (fingerprints, iris scans) for 1.3 billion citizens
  - The state argued: _"Indians have no fundamental right to privacy"_ (citing M.P. Sharma, 1954 and Kharak Singh, 1962)
  - The question: *Is the Right to Privacy a Fundamental Right under Part III of the Constitution?*
]

#slide[
  === The Landmark 9-Judge Verdict

  #v(8pt)

  #verdict[Right to Privacy is a Fundamental Right under Article 21]

  #v(12pt)

  *The Court held unanimously:*
  - Privacy is an *"intrinsic part of life and personal liberty"* under Article 21
  - Overruled *M.P. Sharma v. Satish Chandra (1954)* and *Kharak Singh v. State of UP (1962)*
  - Privacy includes: *Bodily autonomy*, *Informational privacy*, *Decisional privacy*
  - Any invasion must satisfy the test of: *Legality + Legitimate Aim + Proportionality*

  #v(12pt)

  // #grid(
  //   columns: (1fr, 1fr),
  //   gutter: 12pt,

  // )

  #v(8pt)
  #text(size: 14pt, fill: slate-text)[
    *Significance:* This verdict forms the constitutional foundation for the DPDP Act, 2023 and every future data protection regulation in India.
  ]
]

== State of Tamil Nadu v. Suhas Katti (2004)

#slide[
  #case-card(
    title: "State of Tamil Nadu v. Suhas Katti",
    year: "2004",
    section: "Sections 67 IT Act · 509 IPC",
  )[
    India's *first successful cyberstalking conviction*. The accused created fake profiles of a woman on Yahoo and posted her phone number on obscene online groups, leading to harassing calls.
  ]
  #ethical[Internet Anonymity vs. Victim Protection]
  #v(10pt)

  *Facts of the Case:*
  - The accused was a known acquaintance who had been rejected
  - Created *fake Yahoo profiles* in the victim's name
  - Posted her personal details on *obscene online groups*
  - Victim received hundreds of harassing and obscene phone calls
  - FIR filed at the *Chennai Cyber Crime Cell*

  #v(37pt)

  #verdict[Convicted under Section 67, IT Act & Section 509, IPC]

  #text(size: 14pt, fill: slate-text)[
    *Significance:* Set the *precedent* for prosecuting online harassment. Proved that existing laws could be applied to cyberspace even in 2004.
  ]
]

== Avnish Bajaj v. State (Bazee.com Case, 2005)

#slide[
  #case-card(
    title: "Avnish Bajaj v. State — The Bazee.com Case",
    year: "2005",
    section: "Section 67 IT Act · Intermediary Liability",
  )[
    The CEO of Bazee.com (now eBay India) was arrested after a user listed an obscene *DPS MMS clip* for sale on the platform. The case raised critical questions about *intermediary liability*.
  ]
  #ethical[Platform Responsibility vs. Censorship]
  #v(10pt)

  *Key Legal Issues:*
  - Should the *platform owner* be held liable for *user-generated content*?
  - Bazee.com was a marketplace, it did not create or upload the content
  - CEO Avnish Bajaj was personally arrested under Section 67, IT Act

  #v(100pt)

  *Court's Analysis:*
  - Delhi High Court held that *intermediaries cannot be automatically liable* for third-party content
  - This case *directly influenced* the 2008 IT Act Amendment introducing *Section 79* -- the "Safe Harbour" provision
  - Section 79 protects intermediaries if they exercise *due diligence* and act upon receiving actual knowledge

  #v(8pt)

]

== Ritu Kohli Case (2001)

#slide[
  #case-card(
    title: "Ritu Kohli v. State — India's First Cyber Harassment Case",
    year: "2001",
    section: "Section 509 IPC",
  )[
    India's *first registered case of cyber harassment*. A man impersonated Ritu Kohli on online chat rooms, shared her phone number, and invited strangers for obscene conversations -- leading to harassing calls at her home.
  ]
  #ethical[Legislative Gap vs. Victim's Right to Justice]
  #v(10pt)

  *Key Points:*
  - No specific cyber law existed at the time for online impersonation
  - The case was prosecuted under *Section 509 IPC* (word, gesture, or act intended to insult the modesty of a woman)
  - Highlighted the *urgent need* for specific cyber legislation addressing online identity theft and impersonation
  - *Section 66C* (Identity Theft) and *Section 66D* (Cheating by Personation) were later added in the *2008 Amendment*

    #highlight-box(color: amber)[
      #text(
        size: 14pt,
      )[This case became a *catalyst* for the 2008 IT Act Amendment, proving that first-generation cyber laws were insufficient.]
    ]

]

== Syed Asifuddin v. State of AP (2005)

#slide[
  #case-card(
    title: "Syed Asifuddin & Ors. v. State of Andhra Pradesh",
    year: "2005",
    section: "Sections 65, 66 IT Act",
  )[
    Employees of a telecom company *tampered with Electronic Serial Numbers (ESN)* of mobile phones to re-program stolen handsets with new identities.]
  #verdict[Convicted under Sections 65 & 66, IT Act]\
  #provision[Section 65 -- Source Code Tampering]

  *Facts & Judgment:*
  - The accused manipulated the *ESN* (a unique identifier embedded in mobile firmware) -- this constitutes *"source code"* under Section 65 of the IT Act
  - The AP High Court held that ESNs qualify as *"computer source code"* as defined under the IT Act
  - *First judicial interpretation* of what constitutes "source code" in Indian cyber law
  - Conviction under *Section 65* (tampering with computer source documents) and *Section 66* (computer-related offences)
]

// ═══════════════════════════════════════════════════════════════
//  PART III — CYBERCRIME INCIDENTS
// ═══════════════════════════════════════════════════════════════

= Cybercrime Incidents

== Sony.Sambandh.com Fraud (2002)

#slide[
  #case-card(
    title: "Sony India - Sambandh.com Credit Card Fraud",
    year: "2002",
    section: "IT Act 2000 · IPC",
  )[
    One of *India's first e-commerce fraud convictions*. An individual used a *stolen credit card* number to purchase a Sony colour television via the website Sony.Sambandh.com.
  ]

  #verdict[Convicted — first e-commerce fraud conviction in India]
  #v(10pt)

  *How the Crime Unfolded:*
  - The accused obtained a US-based credit card number through unauthorized means
  - Ordered a Sony television for delivery to a residential address in India
  - Sony's logistics partner delivered the product
  - The actual cardholder (US-based) reported the fraudulent transaction
  - Traced back through *delivery records and IP logs*

  #v(8pt)

  #highlight-box(color: amber)[
    #text(
      size: 14pt,
    )[*Lesson:* Demonstrated the need for robust *payment verification systems* and *KYC protocols* in e-commerce.]
  ]
]

== Pune Citibank MphasiS Call Center Fraud (2005)

#slide[
  #case-card(
    title: "Pune Citibank MphasiS BPO Fraud",
    year: "2005",
    section: "Sections 43, 66 IT Act · IPC 420",
  )[
    Ex-employees of MphasiS BPO (a Citibank call center in Pune) *siphoned \$350,000* from US-based Citibank customer accounts using stolen PINs and credentials obtained during work shifts.
  ]
  #danger[Insider Threat — BPO Sector Vulnerability] \ #ethical[Corporate Outsourcing vs. Customer Data Safety]
  #v(10pt)

  *Attack Vector - The Insider Threat:*
  - Call center agents had access to customer account details as part of their duties
  - Agents *copied PINs and passwords* during live calls
  - Funds were transferred to fraudulent accounts in Indian banks
  - *₹1.5 crore* stolen across multiple accounts
  - Detected when US customers reported unauthorized debits

  #v(8pt)

]

#slide[
  === Aftermath & Legal Impact

  #v(8pt)

  *Conviction & Sentencing:*
  - All accused convicted under *Sections 43 and 66* of the IT Act and *Section 420 IPC* (cheating)
  - One of the first cases where the *IT Act was applied alongside the IPC* for financial cybercrime

  #v(10pt)

  *Industry-Wide Impact:*
  - Led to *NASSCOM's Data Security Council of India (DSCI)* being established
  - BPO companies mandated to implement:
    - *No personal devices* on the floor
    - *Screen recording* and audit trails
    - *Background verification* standards
    - Restricted USB ports and email access
  - Triggered *global client confidence crisis* in India's outsourcing industry

  #v(8pt)
  #highlight-box(color: warn-red)[
    #text(
      size: 14pt,
    )[*Key Takeaway:* \ The greatest cybersecurity threat often comes from *within*. \ Technology alone cannot prevent breaches -- organizational culture and access controls are critical.]
  ]
]

== WannaCry Ransomware Attack (2017)

#slide[
  #case-card(
    title: "WannaCry — Global Ransomware Pandemic",
    year: "May 2017",
    section: "Section 66 IT Act · Section 66F (Cyber Terrorism)",
  )[
    WannaCry infected *230,000+ computers across 150 countries* in a single weekend, exploiting a Windows SMB vulnerability (*EternalBlue*) leaked from the US National Security Agency (NSA).
  ]
  #ethical[Government Cyber Weapons vs. Civilian Safety]

  #v(10pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 12pt,
    [
      *Technical Details:*
      - Exploited *MS17-010* (EternalBlue) vulnerability
      - Self-propagating *worm*
      - Encrypted all user files with *AES-256*
      - Demanded *\$300 - \$600 in Bitcoin* per machine
      - Kill switch accidentally discovered by MalwareTech
    ],
    [
      *Impact on India:*
      - *West Bengal* power distribution systems affected
      - *Andhra Pradesh* police systems locked down
      - *CERT-In* issued emergency advisories
      - Multiple banking terminals went offline
      - Estimated *\$4 billion global damage*
    ],
  )
]

#slide[
  === Lessons from WannaCry

  #v(8pt)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    block(
      fill: warn-red.lighten(92%),
      stroke: (top: 3pt + warn-red),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
    )[
      #text(weight: "bold", fill: warn-red.darken(10%))[Vulnerability] \
      #v(4pt)
      #text(size: 14pt)[
        Organizations running *unpatched OS* (Windows XP) were the primary victims. Patch management is non-negotiable.
      ]
    ],
    block(
      fill: amber.lighten(92%),
      stroke: (top: 3pt + amber),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
    )[
      #text(weight: "bold", fill: amber.darken(10%))[State Actors] \
      #v(4pt)
      #text(size: 14pt)[
        The exploit was *developed by the NSA* and leaked by the Shadow Brokers group. \ State-developed cyber weapons can escape and harm civilians.
      ]
    ],
    block(
      fill: emerald.lighten(92%),
      stroke: (top: 3pt + emerald),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
    )[
      #text(weight: "bold", fill: emerald.darken(10%))[Legal Gaps] \
      #v(4pt)
      #text(size: 14pt)[
        Attribution to *North Korea (Lazarus Group)* was made, but *no legal action* was possible due to jurisdictional barriers.
      ]
    ],
  )
]

== AIIMS Ransomware Attack (2022)

#slide[
  #case-card(
    title: "AIIMS Delhi — Critical Healthcare Ransomware",
    year: "November 2022",
    section: "Sections 66, 66F IT Act · CERT-In Mandate",
  )[
    Servers at India's premier medical institution *All India Institute of Medical Sciences (AIIMS), Delhi* were hit by a major ransomware attack, crippling *digital hospital operations for over two weeks*.
  ]
  #danger[Critical Infrastructure at Risk]\
  #ethical[Healthcare Data Security vs. Budget Constraints]
  #v(8pt)

  *Impact Assessment:*
  - *5 servers* compromised, *1.3 TB of data* encrypted
  - Patient records of *3 - 4 crore patients* (including VVIPs, politicians, and bureaucrats) at risk
  - Hospital reverted to *manual paper-based operations* for 15+ days
  - OPD, IPD, billing, lab reports -- all digital services paralyzed
  - *Rs 200 crore ransom* reportedly demanded in cryptocurrency
]

== Cosmos Bank Cyber Heist (2018)

#slide[
  #case-card(
    title: "Cosmos Cooperative Bank — Multi-Vector Cyber Heist",
    year: "August 2018",
    section: "IT Act · IPC 420 · Banking Regulations",
  )[
    Hackers stole *₹94.42 crore (\~\$13.5 million)* from Pune-based Cosmos Cooperative Bank through a sophisticated attack spanning *28 countries in 3 days*.
  ]

  #danger[Banking Infrastructure Breach] \
  #verdict[Arrests made — traced to North Korean Lazarus Group links]

  // #v(10pt)

  *Attack Methodology:*
  - Malware injected into the bank's *ATM switch server* (the system that authorizes ATM transactions)
  - Created a *proxy switching system* that bypassed authorization checks
  - *14,849 fraudulent ATM transactions* executed across 28 countries in 2 hours using cloned cards
  - Simultaneously, *SWIFT transfers* of ₹13.92 crore were sent to a Hong Kong-based entity
  - Total loss: *₹94.42 crore*
]

== SolarWinds Supply Chain Attack (2020)

#slide[
  #case-card(
    title: "SolarWinds — The \"SUNBURST\" Supply Chain Attack",
    year: "December 2020",
    section: "Global · IT Act Section 70 (Critical Infrastructure)",
  )[
    Russian state-sponsored hackers (APT29 / Cozy Bear) compromised SolarWinds' *Orion software update*, gaining access to *18,000+ organizations* including the US Treasury, DHS, and Microsoft.
  ]
  #ethical[National Security vs. Global Software Dependencies]
  #v(10pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 12pt,
    [
      *The Attack:*
      - Backdoor ("SUNBURST") inserted into a *legitimate software update*
      - Updates were digitally signed — appeared trustworthy
      - Attackers had *stealth access for 9+ months*
      - Affected government agencies, Fortune 500 firms
    ],
    [
      *Why It Matters:*
      - Proved that *"trusted" supply chains* can be weaponized
      - Digital signatures do not guarantee safety
      - India's reliance on foreign software for critical infrastructure raises similar risks
      - *Section 70* of India's IT Act deals with "Protected Systems" but lacks supply-chain audit mandates
    ],
  )
]

== Pegasus Spyware Controversy (2021)

#slide[
  #case-card(
    title: "Pegasus Project — State-Sponsored Surveillance",
    year: "2019–2021",
    section: "IT Act · Article 21 (Right to Privacy)",
  )[
    NSO Group's *Pegasus spyware* was found on phones of *Indian journalists, opposition leaders, activists, and lawyers* -- raising questions about state-sanctioned surveillance and the limits of lawful interception.
  ]

  #ethical[Press Freedom vs. National Security]
  #ethical[Lawful Interception vs. Mass Surveillance]
  // #v(10pt)

  *Key Facts:*
  - Pegasus is a *zero-click spyware* -- no user interaction needed for infection
  - Can access *messages, calls, camera, microphone, passwords* -- effectively a full device takeover
  - *Citizen Lab (Toronto)* and *Amnesty International* confirmed infections on Indian phones
  - Indian government *neither confirmed nor denied* use
  - Supreme Court constituted a *technical committee* headed by Justice R.V. Raveendran to investigate

]

// ═══════════════════════════════════════════════════════════════
//  PART IV — ETHICAL DILEMMAS
// ═══════════════════════════════════════════════════════════════

= Ethical Dilemmas

== Cambridge Analytica — Data & Democracy

#slide[
  #case-card(
    title: "Facebook–Cambridge Analytica Scandal",
    year: "2018",
    section: "Data Protection · GDPR · Privacy",
  )[
    Personal data of *87 million Facebook users* was harvested without consent through a personality quiz app -- then used for *psychographic voter profiling* during the 2016 US Election and Brexit.
  ]

  #ethical[Data-Driven Innovation vs. Democratic Integrity]

  *How It Worked:*
  - Dr. Aleksandr Kogan built *"This Is Your Digital Life"* -- a personality quiz
  - ~270,000 users took the quiz and unknowingly consented to share *their friends' data*
  - Facebook's API at the time allowed apps to access *friends' profiles* without their consent
  - Cambridge Analytica built *psychographic profiles* to micro-target voters with tailored political ads
  - Data was used to build *"persuasion architectures"* exploiting individual psychological vulnerabilities
]

#slide[
  === The Ethical Breakdown

  #v(8pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    block(
      fill: warn-red.lighten(92%),
      stroke: (left: 4pt + warn-red),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
    )[
      #text(weight: "bold", size: 16pt, fill: warn-red.darken(10%))[Violations] \
      #v(6pt)
      - *Informed Consent:* Users consented to a quiz, not mass data extraction
      - *Data Minimization:* Friends' data was collected far beyond any stated purpose
      - *Transparency:* Facebook knew about the breach since 2015 but did not disclose until 2018
      - *Autonomy:* Voters were manipulated without awareness
    ],
    block(
      fill: emerald.lighten(92%),
      stroke: (left: 4pt + emerald),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
    )[
      #text(weight: "bold", size: 16pt, fill: emerald.darken(10%))[Consequences] \
      #v(6pt)
      - Facebook fined *\$5 billion* by the US FTC
      - GDPR enforcement *accelerated* across Europe
      - Cambridge Analytica *shut down*
      - Catalyzed India's *DPDP Act* development
      - Global shift to *"Privacy by Design"*
    ],
  )
]

== Aadhaar: Identity, Privacy & Surveillance

#slide[
  #case-card(
    title: "The Aadhaar Dilemma — World's Largest Biometric Database",
    year: "2009–Present",
    section: "Aadhaar Act 2016 · Article 21 · DPDP Act",
  )[
    Aadhaar assigns a *12-digit unique ID* to 1.3+ billion residents based on *biometric data* (fingerprints + iris scans). It is simultaneously praised as *transformative governance* and criticized as *mass surveillance infrastructure*.
  ]
  #ethical[Social Welfare Efficiency vs. Surveillance State Risk]
  #pagebreak()
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    block(
      fill: emerald.lighten(92%),
      stroke: (left: 3pt + emerald),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
    )[
      #text(weight: "bold", fill: emerald.darken(10%))[FOR — Governance Benefits] \
      #v(4pt)
      - *Direct Benefit Transfer (DBT)*: Saved ₹2.25 lakh crore by eliminating middlemen
      - Enables *financial inclusion* for the unbanked
      - *Unique ID* prevents ghost beneficiaries in welfare schemes
      - Digital KYC simplifies banking and telecom
    ],
    block(
      fill: warn-red.lighten(92%),
      stroke: (left: 3pt + warn-red),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
    )[
      #text(weight: "bold", fill: warn-red.darken(10%))[AGAINST — Privacy Concerns] \
      #v(4pt)
      - *Biometric data is irrevocable* -- you can't change fingerprints
      - Creates a *"single point of surveillance"*
      - UIDAI data breaches reported (Tribune exposé, 2018)
      - *Function creep* -- Aadhaar linked to PAN, bank, phone, ration, education
    ],
  )
]

== AI, Deepfakes & Synthetic Media

#slide[
  #case-card(
    title: "The Deepfake Crisis — When Seeing Isn't Believing",
    year: "2023–Present",
    section: "IT Act · Section 66D · Proposed AI Regulation",
  )[
    AI-generated deepfakes have evolved from research curiosities to *weaponized tools* for fraud, disinformation, and non-consensual content. India reported a *230% surge* in deepfake-related offences in 2023–24.
  ]
  #danger[No dedicated deepfake law in India]  #ethical[Free Expression & Satire vs. Fabricated Reality] \

  *Threat Landscape:*
  - *Political deepfakes:* Synthetic videos of leaders making fabricated statements during elections
  - *Financial fraud:* Deepfake video calls impersonating CEOs to authorize wire transfers (₹40L+ cases reported in India)
  - *Non-consensual intimate imagery:* AI tools generating explicit content using a victim's face -- disproportionately targeting women
  - *Evidence tampering:* Deepfakes can undermine the *evidentiary value of video evidence* in courts
]

#slide[
  === Current Legal Position & The Gap

  #v(8pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      *Existing (Imperfect) Coverage:*
      - #provision[Section 66D] Cheating by Personation using Computer Resource
      - #provision[Section 66E] Privacy Violation and Publishing of Private Images
      - #provision[Section 67 / 67A / 67B] Obscene / Sexually Explicit Material
      - IPC/BNS provisions on defamation and fraud
      - IT Rules 2021 — Intermediary obligations to remove deepfakes
    ],
    [
      *What's Missing:*
      - No *dedicated deepfake legislation*
      - No mandatory *content authentication* or watermarking standard
      - No clear *liability framework* for AI model developers
      - No *technological mandate* for platforms to detect and label synthetic media
      - Jurisdictional challenges — generators may be outside India
    ],
  )

  #highlight-box(color: amber)[
    #text(
      size: 14pt,
    )[*The Ethical Core:* Who is responsible when AI creates harmful content — the *developer* of the AI model, the *user* who prompted it, or the *platform* that hosted it? Current law has no clear answer.]
  ]
]

== The Right to Be Forgotten

#slide[
  #case-card(
    title: "Right to Be Forgotten — Digital Erasure",
    year: "Evolving",
    section: "DPDP Act Section 13 · GDPR Art. 17 · Article 21",
  )[
    Can individuals demand that search engines and platforms *permanently delete* information about them? India is still developing its position on this critical digital right.
  ]
  #ethical[Historical Record vs. Personal Rehabilitation]
  #ethical[Individual Dignity vs. Public's Right to Information]
  #v(10pt)

  *Indian Judicial Developments:*
  - *Jorawer Singh Mundy v. Union of India (2021)*: Delhi HC directed removal of a US court judgment from search results, recognizing RTBF as part of the *Right to Privacy*
  - *Zulfiqar Ahman Khan v. Quintillion Business Media (2019)*: Karnataka HC acknowledged RTBF in the context of outdated defamatory articles
  - *DPDP Act, 2023*: Section 13 grants Data Principals the *right to erasure* of personal data once purpose is fulfilled
]

== Ethical Hacking & Bug Bounties

#slide[
  #case-card(
    title: "White-Hat Hacking — Hero or Criminal?",
    year: "Ongoing",
    section: "Sections 43, 65, 66 IT Act · Responsible Disclosure",
  )[
    India's IT Act *does not distinguish* between malicious hacking and good-faith security research. An ethical hacker who discovers a vulnerability and reports it can technically be *prosecuted under the same sections as a criminal hacker*.
  ]

  #ethical[Security Research vs. Unauthorized Access]

  #v(10pt)

  *The Dilemma:*
  - *Section 43*: Unauthorized access to a computer — No intent requirement
  - *Section 66*: Computer-related offences — Criminal penalties for unauthorized access
  - Unlike the US (*CFAA Safe Harbour*) or EU (*NIS2 framework*), India has *no legal protection* for responsible disclosure

  #v(10pt)
  #pagebreak()
  *Notable Incidents:*
  - Indian security researchers have faced *legal threats* from companies after reporting bugs
  - *Aadhaar data leaks* were reported by researchers who themselves faced intimidation
  - Many researchers now *avoid testing Indian platforms* due to legal risk
]

// ═══════════════════════════════════════════════════════════════
//  PART V — SYNTHESIS & CONCLUSION
// ═══════════════════════════════════════════════════════════════

= Analysis & Conclusions

== Comparative Matrix

#slide(config: config-page(header: none))[
  #text(size: 14pt)[
    #table(
      columns: (2fr, 2fr, 2fr, 2fr),
      align: left,
      stroke: 0.5pt + midnight.lighten(70%),
      inset: 8pt,
      fill: (x, y) => if y == 0 { midnight } else if calc.rem(y, 2) == 0 { light-bg } else { white },
      table.header(
        text(fill: white, weight: "bold")[Case / Incident],
        text(fill: white, weight: "bold")[Legal Provisions],
        text(fill: white, weight: "bold")[Ethical Theme],
        text(fill: white, weight: "bold")[Outcome / Impact],
      ),
      [Shreya Singhal], [Section 66A], [Free Speech vs. Safety], [66A struck down],
      [Puttaswamy], [Article 21], [Privacy vs. Surveillance], [Privacy = Fundamental Right],
      [Suhas Katti], [67 IT Act + 509 IPC], [Anonymity vs. Protection], [First cyber conviction],
      [Bazee.com], [Section 67, 79], [Platform Liability], [Safe Harbour introduced],
      [WannaCry], [Section 66F], [State Weapons vs. Civilian Safety], [Patch management critical],
      [AIIMS Attack], [Section 66, 66F], [Healthcare Data Security], [2-week system failure],
      [Cambridge Analytica], [GDPR / DPDP], [Data vs. Democracy], [\$5B fine, DPDP catalyst],
      [Pegasus], [Article 21, IT Act], [Surveillance vs. Press Freedom], [SC Committee formed],
    )
  ]
]

== Recurring Legal Themes

#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    block(
      fill: light-bg,
      inset: 18pt,
      radius: 8pt,
      width: 100%,
    )[
      #text(weight: "bold", size: 17pt, fill: midnight)[Legislative Gaps] \
      #v(8pt)
      - IT Act 2000 is *over two decades old* — written before smartphones, cloud computing, and AI
      - No dedicated laws for *deepfakes, AI liability, cryptocurrency fraud, or IoT security*
      - Section 66A struck down but *no replacement* for online speech regulation
      - *Bug bounty / responsible disclosure* has no legal protection
      - Cross-border enforcement remains a "jurisdictional nightmare"
    ],
    block(
      fill: light-bg,
      inset: 18pt,
      radius: 8pt,
      width: 100%,
    )[
      #text(weight: "bold", size: 17pt, fill: midnight)[Evolving Jurisprudence] \
      #v(8pt)
      - Courts are *progressively expanding digital rights* (Puttaswamy, Shreya Singhal)
      - Shift from *"technology-specific"* to *"technology-neutral"* legal reasoning
      - *Intermediary liability* clarified through Bazee.com → Section 79
      - DPDP Act 2023 positions India closer to *global standards* (GDPR)
      - *Data Principal* rights recognized as fundamental
    ],
  )
]

== Key Takeaways

#slide(config: config-page(header: none))[
  #v(8pt)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 14pt,
    block(
      fill: midnight,
      inset: 18pt,
      radius: 8pt,
      width: 100%,
      stack(
        dir: ttb,
        spacing: 8pt,
        text(fill: cyan-acc, weight: "bold", size: 40pt)[01],
        text(fill: white, weight: "bold", size: 15pt)[Law Follows Technology],
        text(
          fill: slate-text,
          size: 13pt,
        )[Every major case study shows that legislation reacted to incidents rather than anticipated them. Proactive, tech-neutral regulation is essential.],
      ),
    ),
    block(
      fill: midnight,
      inset: 18pt,
      radius: 8pt,
      width: 100%,
      stack(
        dir: ttb,
        spacing: 8pt,
        text(fill: cyan-acc, weight: "bold", size: 40pt)[02],
        text(fill: white, weight: "bold", size: 15pt)[Ethics > Compliance],
        text(
          fill: slate-text,
          size: 13pt,
        )[Cambridge Analytica was technically "legal" under 2016 rules. Ethical culture must exceed the minimum legal bar. "Just because it's possible doesn't mean it's right."],
      ),
    ),
    block(
      fill: midnight,
      inset: 18pt,
      radius: 8pt,
      width: 100%,
      stack(
        dir: ttb,
        spacing: 8pt,
        text(fill: cyan-acc, weight: "bold", size: 40pt)[03],
        text(fill: white, weight: "bold", size: 15pt)[Privacy Is Foundational],
        text(
          fill: slate-text,
          size: 13pt,
        )[From Puttaswamy to Aadhaar to Pegasus — informational privacy is a non-negotiable fundamental right that underpins all other digital freedoms.],
      ),
    ),
  )
]

#slide(config: config-page(header: none))[
  #v(8pt)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 14pt,
    block(
      fill: midnight,
      inset: 18pt,
      radius: 8pt,
      width: 100%,
      stack(
        dir: ttb,
        spacing: 8pt,
        text(fill: cyan-acc, weight: "bold", size: 40pt)[04],
        text(fill: white, weight: "bold", size: 15pt)[Defense in Depth],
        text(
          fill: slate-text,
          size: 13pt,
        )[WannaCry, AIIMS, and Cosmos Bank prove that technical, organizational, and legal safeguards must work in concert. No single layer is sufficient.],
      ),
    ),
    block(
      fill: midnight,
      inset: 18pt,
      radius: 8pt,
      width: 100%,
      stack(
        dir: ttb,
        spacing: 8pt,
        text(fill: cyan-acc, weight: "bold", size: 40pt)[05],
        text(fill: white, weight: "bold", size: 15pt)[Global Collaboration],
        text(
          fill: slate-text,
          size: 13pt,
        )[Cybercrime is borderless. International cooperation, mutual legal assistance treaties (MLATs), and harmonized frameworks are necessary for effective enforcement.],
      ),
    ),
    block(
      fill: midnight,
      inset: 18pt,
      radius: 8pt,
      width: 100%,
      stack(
        dir: ttb,
        spacing: 8pt,
        text(fill: cyan-acc, weight: "bold", size: 40pt)[06],
        text(fill: white, weight: "bold", size: 15pt)[Human Factor],
        text(
          fill: slate-text,
          size: 13pt,
        )[The MphasiS case, social engineering, and phishing attacks demonstrate that people remain the weakest link. Ethics training and security culture are indispensable.],
      ),
    ),
  )
]

== Recommendations

#slide(config: config-page(header: none))[
  #text(weight: "bold", size: 18pt, fill: midnight)[Policy & Legislative Recommendations]
  #v(10pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      *For the Legislature:*
      + Draft a *comprehensive Cyber Security Act* replacing the outdated IT Act (\~2000)
      + Enact *dedicated deepfake & AI legislation* with clear liability chains
      + Create *legal safe harbour for ethical hackers* and responsible disclosure
      + Establish a *specialized Cyber Court system* for faster adjudication
      + Mandate *cybersecurity audits* for critical infrastructure (healthcare, banking, power)
    ],
    [
      *For Organizations:*
      + Implement *Privacy by Design* — not as an afterthought
      + Conduct regular *data protection impact assessments (DPIA)*
      + Institute *mandatory cybersecurity training* for all employees
      + Establish *bug bounty programs* with clear legal protections
      + Adopt *zero-trust architecture* and principle of least privilege
    ],
  )

  #v(10pt)
  #highlight-box(color: cyan-acc)[
    #text(size: 14pt)[
      *For Individuals:* \ \ Practice *digital hygiene* : \ - Strong passwords \ - MFA \ - Minimal data sharing \ - Updated devices \ - Critical evaluation of online content. \ \ *An informed digital citizen is the strongest defense.*
    ]
  ]
]

== References & Statutes

#slide(config: config-page(header: none))[
  #text(size: 13pt)[
    *Statutes:*
    - Information Technology Act, 2000 (as amended 2008)
    - Digital Personal Data Protection (DPDP) Act, 2023
    - Indian Penal Code (IPC), 1860 / Bharatiya Nyaya Sanhita (BNS), 2023
    - Indian Evidence Act, 1872 - Sections 65A, 65B (Electronic Evidence)
    - Aadhaar (Targeted Delivery of Financial and Other Subsidies, Benefits and Services) Act, 2016
    - General Data Protection Regulation (GDPR), EU, 2018

    *Landmark Judgments:*
    - _Shreya Singhal v. Union of India_, AIR 2015 SC 1523
    - _Justice K.S. Puttaswamy (Retd.) v. Union of India_, (2017) 10 SCC 1
    - _State of Tamil Nadu v. Suhas Katti_, CC No. 4680 / 2004 (Chennai)
    - _Avnish Bajaj v. State (NCT of Delhi)_, (2005) 3 CompLJ 364 (Del)
    - _Syed Asifuddin v. State of AP_, 2005 CriLJ 4314 (AP HC)
    - _Jorawer Singh Mundy v. Union of India_, W.P.(C) 3918/2021 (Delhi HC)

    *Reports & Sources:*
    - CERT-In Annual Reports (2017–2024)
    - NASSCOM–DSCI Cybersecurity Reports
    - Citizen Lab - Pegasus Investigation Reports (2021)
    - Amnesty International - Forensic Methodology Report (2021)
  ]
]

// ═══════════════════════════════════════════════════════════════
//  CLOSING SLIDE
// ═══════════════════════════════════════════════════════════════

#slide(config: config-page(header: none))[
  #align(center + horizon)[
    #block(
      inset: 40pt,
    )[
      #text(size: 36pt, weight: "bold", fill: midnight)[Thank You!] \
      #v(12pt)
      #text(size: 16pt, fill: slate-text)[
        Sandeep Prasad · 240905050085 · X21 (CSE) \
        Cyber Law and Ethics -- ALA-II \
        GMIU -- Department of Computer Science & Engineering
      ]
      #v(20pt)
      #line(length: 20%, stroke: 2pt + cyan-acc)
      #v(10pt)
      #text(size: 14pt, style: "italic", fill: slate-text)[
        "The law must be stable, but it must not stand still." \
        — Roscoe Pound
      ]
    ]
  ]
]

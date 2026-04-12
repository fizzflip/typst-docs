#set document(title: "Cyber Ethics Policy", author: "Ethics & Compliance Board")
#set text(font: ("Libertinus Serif", "Arial"), size: 11pt, lang: "en")
#set page(
  paper: "a4",
  margin: (x: 1.5in, y: 1.5in),
  header: context {
    if counter(page).get().first() > 1 {
      align(right)[
        #text(8pt, fill: luma(120))[Totally Not Evil Corp | Cyber Ethics Policy]
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
#set heading(numbering: "1.1 ")
#show heading: it => {
  set text(font: "Arial", weight: "bold", fill: rgb("#1a365d"))
  block(below: 0.5em, above: 1em)[
    #if it.level == 1 {
      set text(size: 18pt)
      it
    } else if it.level == 2 {
      set text(size: 14pt)
      it
    } else {
      set text(size: 12pt)
      it
    }
  ]
}

// Custom title block
#align(center)[
  #v(4em)
  #box(
    width: 100%,
    stroke: (bottom: 2pt + rgb("#1a365d")),
    inset: (bottom: 1em),
    [
      #text(
        28pt,
        font: "Arial",
        weight: "bold",
        fill: rgb("#1a365d"),
      )[Cyber Ethics Policy] \
      #v(0.5em)
      #text(14pt, fill: luma(100))[Totally Not Evil Corporation]
    ],
  )
  #v(2em)
  #grid(
    columns: (1fr, 1fr),
    align(left)[
      *Prepared By:* \
      Information Security & \
      Human Resources Departments \
      *Classification*: Internal
    ],
    align(right)[
      *Date:* #datetime.today().display() \
      *Status:* Active \
      *Version:* 3.0 \ ("final" revision) \
    ],
  )
  #v(4em)
]

#block(
  fill: rgb("#f8fafc"),
  stroke: rgb("#e2e8f0"),
  inset: 16pt,
  radius: 8pt,
  [
    *Policy Abstract:* \
    This document constitutes the comprehensive Cyber Ethics Policy for Totally Not Evil Corporation. As digital transformation accelerates, maintaining an ethical and secure operational framework is legally and morally imperative. This policy establishes stringent, actionable guidelines across four critical domains: *Data Privacy*, regulating the handling and protection of sensitive information; *Acceptable Use*, dictating the responsible utilization of corporate IT resources; *Intellectual Property*, ensuring the ethical generation and preservation of proprietary assets; and *Employee Behavior Online*, governing professional conduct across all digital platforms. Adherence to these mandates is a condition of employment and vital for maintaining organizational integrity.
  ],
)

#pagebreak()
#outline(depth: 2, indent: auto)
#pagebreak()

= Introduction and Scope

Totally Not Evil Corporation is fundamentally committed to establishing, maintaining, and continually refining a secure, ethically grounded, and highly productive technological environment. As digital infrastructure becomes the primary conduit through which modern business operations are executed, this Comprehensive Cyber Ethics Policy serves as the foundational normative document outlining the expected standards of technological engagement.

The policy applies unconditionally to all employees, contractors, consultants, and third-party affiliates who utilize hardware, software, network resources, or digital communication platforms owned, leased, or managed by Totally Not Evil Corporation. It serves to protect our users, secure our assets, and maintain our legal compliance within a rapidly evolving digital landscape.

#v(1em)

= Data Privacy

The ethical stewardship of data is the cornerstone of our cybersecurity posture. Totally Not Evil Corporation handles vast quantities of sensitive operational and customer data. The protection of this information from unauthorized access, arbitrary disclosure, and malicious misuse is of paramount strategic and ethical importance.

== Data Classification and Least Privilege
All corporate data must be systematically classified upon codification and handled according to its assessed sensitivity level (Public, Internal, Confidential, or Restricted).
1. *Need-to-Know Access:* Employees are granted access exclusively to the specific systems, data repositories, and administrative privileges that are demonstrably necessary for the execution of their professional duties.
2. *Data Minimization:* Employees have an ethical obligation to collect and retain only the minimum data necessary for explicit business functions. Indefinite data hoarding constitutes a violation of privacy principles.

== Regulatory Compliance and PII Protection
Employees handling Personally Identifiable Information (PII) belonging to customers, partners, or fellow staff members must strictly comply with comprehensive regional and international data protection regulations (including, but not limited to, the GDPR and CCPA).
- All restricted and confidential PII must be encrypted both at rest and in transit across networks using mathematically secure, pre-approved cryptographic protocols (e.g., AES-256).
- Unauthorized extraction, uncontrolled cloud synchronization, or external sharing of PII is strictly prohibited and constitutes a severe breach of this policy.

#pagebreak()

= Acceptable Use

Totally Not Evil Corporation invests heavily in robust IT resources—encompassing computational devices, internal networks, and specialized software suites—engineered strictly to facilitate legitimate business operations. Employees are expected to utilize these resources in a manner that constitutes ethical organizational utility.

== Authorized Operations and Device Management
Users are actively encouraged to leverage corporate computing systems to foster innovation and drive daily operational efficiencies. Incidental personal use of corporate devices is permitted provided it is highly limited, does not consume disproportionate network bandwidth, and does not compromise the functional integrity of shared resources.

== Categorically Prohibited Activities
To maintain operational integrity and legal immunity, the following activities are strictly prohibited on all corporate networks and hardware:
- Accessing, downloading, or distributing illicit, explicit, politically extreme, or legally prohibited materials.
- Engaging in illegal cyber activities, including unauthorized penetration testing, network packet sniffing without explicit authorization, or the circumvention of established authentication protocols.
- Employing undocumented, unapproved software ("Shadow IT"). Bypassing the IT procurement process to install unvetted applications exposes the entire organization to unquantifiable security risks and constitutes an ethical breach of trust.
- Intentional monopolization of network resources, such as continuous high-definition media streaming or unauthorized cryptocurrency mining.

#v(1em)

= Intellectual Property

The creation, curation, and preservation of Intellectual Property (IP) guarantee Totally Not Evil Corporation's continued competitive advantage. Operating ethically within the cyber domain requires rigorous respect for the IP rights of both our organization and external entities.

== Corporate Ownership and Authorship
In accordance with standard employment law practices, any software codebase, technical documentation, architectural design, or distinct digital content created by an employee during their tenure—or facilitated through the utilization of company-provided hardware—remains the undisputed, exclusive intellectual property of Totally Not Evil Corporation.

== External IP Compliance and Open Source Ethics
Plagiarism and digital theft are categorically unethical. Employees must respect the IP rights cultivated by third parties:
- *Software Piracy:* There is an absolute prohibition against deploying, storing, or benefiting from unlicensed or pirated commercial software.
- *Open-Source Integration:* When incorporating Open-Source Software (OSS), employees must initiate strict code reviews to ensure total licensing compliance. Developers must understand and respect the legal disparities between permissive licenses (e.g., MIT) and copyleft licenses (e.g., GPL), ensuring proprietary code is not inadvertently compromised.
- *Attribution:* The organization mandates the rigorous citation of external sources, algorithms, and design paradigms to combat intellectual dishonesty.

#v(1em)

= Employee Behavior Online

Employees functionally serve as direct representatives of Totally Not Evil Corporation, projecting its ethical character within the immediate workplace ecosystem and across the expansive digital sphere. Professionalism and decorum are mandatory at all times.

== Internal Communication and Psychological Safety
All forms of internal corporate communications—encompassing formal emails, instant messaging channels, and collaborative documents—must inherently remain professional and contextually appropriate.
- *Constructive Discourse:* The deployment of discriminatory, harassing, or hostile language is strictly forbidden. The ethical utilization of digital communication requires preserving the dignity and psychological safety of the recipient.
- *Active Reporting:* Retaliatory actions against whistleblowers via digital platforms will elicit the most severe disciplinary consequences. Employees maintain a reciprocal ethical responsibility to report instances of digital harassment or cyberbullying.

== Social Media Conduct and Brand Sovereignty
While Totally Not Evil Corporation respects the privacy of an employee's personal social media presence, individuals must remain cognizant that public digital footprints can reflect upon the organizational brand.
- Employees are strictly prohibited from prematurely disclosing internal corporate discussions, unreleased product architectures, or confidential organizational strategies on any social platform.
- Personnel must not formally or casually represent themselves as authorized spokespersons operating on behalf of the organization without explicit clearance from the Public Relations department.
- When publicly expressing controversial personal or industry-related opinions, employees must utilize a clear, unambiguous disclaimer establishing that the views are solely their own.

= Enforcement and Auditing

To ensure continued adherence to this Cyber Ethics Policy, the IT Security and Human Resources teams deploy comprehensive auditing mechanisms, including transparent network traffic monitoring and access log review.

Documented violations of this policy are subject to formal disciplinary action. Sanctions will be administered proportionally to the severity and intent of the offense. Interventions may range from mandatory retraining and written reprimands to the suspension of network privileges. In instances of egregious, malicious, or criminal violation, Totally Not Evil Corporation will enact immediate termination of employment and cooperate fully with relevant law enforcement authorities.

#v(2em)
#align(center)[
  *END OF CYBER ETHICS POLICY*
]

#let meta = json("../../../../misc/metadata.json")

#let m(it) = box(
  fill: rgb("#1b1b1f"),
  inset: (x: 4pt, y: 0pt),
  outset: (y: 2.5pt),
  radius: 3pt,
  stroke: 0.2pt + rgb("#555"),
  text(fill: rgb("#ffffff"), font: "DejaVu Sans Mono", size: 8.5pt, it),
)

#let info-card(title, content, border-color: rgb("#38bdf8")) = block(
  width: 100%,
  fill: rgb("#181822"),
  stroke: (left: 3pt + border-color, rest: 0.4pt + rgb("#282838")),
  radius: (right: 4pt),
  inset: (x: 10pt, y: 7pt),
  [
    #text(weight: "bold", fill: border-color, size: 9.3pt)[#title] \
    #v(2.5pt)
    #set text(size: 8.8pt, fill: rgb("#cbd5e1"))
    #content
  ],
)

#set page(
  paper: "a4",
  fill: rgb("#141414"), // Dark academic background
  margin: (x: 2.5cm, y: 2.5cm),
  header: none,
  footer: context {
    if here().page() > 2 {
      set text(size: 9pt, fill: gray.lighten(30%))
      [Software Engineering -- BETCE15322]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    }
  },
)

#set text(
  fill: rgb("#f0f0f0"), // Light readable academic text
  font: ("Magnisa Sans", "Times New Roman"),
  size: 11pt,
)

#set par(
  justify: true,
  leading: 0.7em,
  spacing: 1.2em,
)

// Configure heading numbering for Table of Contents, but strip numbers from rendered page headings
#set heading(numbering: "1.1.")

#show heading.where(level: 1): it => block(
  inset: (top: 0.8em, bottom: 0.3em),
  text(size: 1.35em, weight: "bold", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.6em, bottom: 0.2em),
  text(size: 1.15em, weight: "bold", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 3): it => block(
  inset: (top: 0.4em, bottom: 0.15em),
  text(size: 1.02em, weight: "bold", fill: rgb("#38bdf8"), it.body),
)

// Academic Table Styling with comfortable padding & repeated headers
#let custom-table(columns, ..data) = {
  let pos = data.pos()
  let cols = if type(columns) == array { columns.len() } else { columns }
  let header = pos.slice(0, cols)
  let rest = pos.slice(cols)
  table(
    columns: columns,
    fill: (col, row) => if row == 0 { rgb("#1e293b") } else if calc.even(row) { rgb("#18181b") } else {
      rgb("#131316")
    },
    stroke: 0.35pt + rgb("#334155"),
    inset: (x: 5.5pt, y: 4.5pt),
    align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
    table.header(..header),
    ..rest
  )
}

// =============================================================================
// PAGE 1: COVER PAGE
// =============================================================================

#align(right)[
  #text(size: 48pt, weight: 900, font: "Magnisa Sans")[#meta.name]

  #v(-2.5em)
  #box[
    #set text(size: 18pt, font: "Arcon")
    #grid(
      columns: (auto, auto),
      align: (right, left),
      inset: (x: 0.6em, y: 0.2em),
      stroke: (x, y) => if x == 0 { (right: .5pt + rgb("#ffffff")) } else {
        none
      },
      [Software Engineering], [SUB],
      [#meta.roll_no], [#meta.ern],
      [#meta.section], [#meta.cla],
      [II], [#meta.ala],
    )
  ]
]

#v(1fr)
#align(left)[
  #set text(
    size: 44pt,
    font: "Mexcellent",
  )
  #set par(leading: 0.2em)
  PROJECT SIZING \
  WITH COCOMO MODEL
]

#pagebreak()

// =============================================================================
// PAGE 2: TABLE OF CONTENTS
// =============================================================================

#v(2em)
#align(center)[
  #text(size: 2em, weight: "bold", fill: rgb("#ffffff"))[Table of Contents]
]
#v(1.5em)

#{
  show outline.entry.where(level: 1): it => block(
    inset: (top: 0.5em, bottom: 0.15em),
    text(weight: "bold", size: 10pt, fill: rgb("#ffffff"), it),
  )
  show outline.entry.where(level: 2): it => block(
    inset: (top: 0.15em, bottom: 0.1em),
    text(weight: "regular", size: 9pt, fill: rgb("#cbd5e1"), it),
  )
  outline(
    title: none,
    depth: 2,
    indent: 1.2em,
  )
}

#pagebreak()

// =============================================================================
// PAGE 3: SECTION 1: SYSTEM DEFINITION & PROBLEM SCOPE (Numbered 1 / 11)
// =============================================================================
#counter(page).update(1)

= System Definition

== The Software Estimation Problem
In software engineering, accurate effort and schedule estimation is one of the primary prerequisites for successful system delivery. Historical project data indicates that over $65\%$ of engineering project overruns originate not from algorithmic deficiencies, but from compressed delivery targets, improper resource loading, and the misapplication of manpower described by *Brooks' Law* -- that adding personnel to an already late project exacerbates delivery delay.

Early in the software lifecycle, teams face the *Cone of Uncertainty*, where initial estimates can diverge widely from final results. To provide an empirical, repeatable estimation methodology, Dr. Barry Boehm formulated the *Constructive Cost Model (COCOMO)* in 1981 based on the analysis of dozens of historical production software projects. COCOMO relates system sizing (expressed in Thousands of Lines of Code, or KLOC) to required engineering effort, calendar duration, and team staffing through non-linear empirical functions.

== Project Overview
The *National Electronic Toll Collection (NETC)* represents a distributed, real-time transaction processing platform operating across national highway toll plazas (the FASTag infrastructure). The platform connects physically distributed toll booths with centralized inter-bank clearing switches to enable vehicle transit without manual cash transactions.

=== Operational Lifecycle
1. *Vehicle Arrival & Sensor Detection:* An approaching vehicle passes optical classification sensors installed in the toll lane, which classify the physical vehicle profile (car, light commercial vehicle, multi-axle truck, bus).
2. *RFID Interrogation:* An overhead EPC Gen-2 RFID transceiver interrogates the passive tag affixed to the vehicle windshield, extracting its unique tag identifier over the RF interface within milliseconds.
3. *Authentication & Validation:* The plaza controller validates the tag digital signature against a local Hardware Security Module (HSM) and dispatches a verification query to the central transaction switch.
4. *Banking Clearing & Barrier Actuation:* The transaction switch queries the acquiring bank wallet. Upon balance verification, a clearance signal triggers the lane boom barrier to lift, permitting the vehicle to transit without stopping.
5. *Offline Resilience:* In the event of telecommunication or backhaul network interruption, the plaza controller continues autonomous lane processing using a local write-ahead log buffer, deferring inter-bank settlement until connection recovery.

#v(0.8em)
#info-card(
  [Architectural Principle: Offline Resiliency with Fault Isolation],
  [Electronic toll collection architectures decouple high-frequency physical lane sensor polling from centralized financial clearing. By isolating edge actuation from variable WAN network latency, local toll plazas sustain continuous vehicular throughput during telecommunication outages.],
)

#pagebreak()

// =============================================================================
// PAGE 4: SECTION 2: SRS & MODULAR SIZING BREAKDOWN (Numbered 2 / 11)
// =============================================================================

= System Specifications

== Software Requirements Specification (SRS)
Accurate software cost modeling requires establishing a clear boundary between functional capabilities and operational quality constraints. The core specifications for the Electronic Toll Collection platform are established below:

#custom-table(
  (0.8fr, 1.4fr, 2.6fr, 0.7fr),
  [*ID*],
  [*Requirement Name*],
  [*Technical Specification & Acceptance Criteria*],
  [*Priority*],
  [FR-01],
  [Lane Sensor Interfacing],
  [Interface EPC Gen-2 RFID readers, optical vehicle classification sensors, and barrier solenoids.],
  [Critical],
  [FR-02],
  [Cryptographic Validation],
  [Execute mutual tag authentication and digital signature verification via HSM in $< 25"ms"$.],
  [Critical],
  [FR-03],
  [Offline Buffer Management],
  [Maintain local database buffer sustaining autonomous lane operations for up to 72 hours.],
  [High],
  [FR-04],
  [ISO Message Switching],
  [Parse, validate, and route ISO 8583 financial messages to member banks sustaining 8,000 TPS.],
  [Critical],
  [FR-05],
  [Net Settlement Reconciliation],
  [Execute automated end-of-day multi-bank net settlement and dispute adjustments.],
  [High],
  [NFR-01],
  [Lane Response Latency],
  [Total end-to-end tag scan to barrier lift turnaround time must not exceed $100"ms"$.],
  [Critical],
  [NFR-02],
  [System Availability],
  [Central transaction switch must maintain $99.999\%$ uptime with multi-region failover.],
  [High],
  [NFR-03],
  [Audit & Non-Repudiation],
  [Immutable double-entry transaction ledgers ensuring complete financial non-repudiation.],
  [High],
)

== Modular Sizing Breakdown
Using Function Point Analysis (FPA) and historical metric baselines from distributed financial switching systems, the overall platform is sized at *76.0 KLOC* partitioned across six decoupled subsystems:

#custom-table(
  (0.7fr, 1.8fr, 1.9fr, 0.9fr, 0.8fr),
  [*Module*],
  [*Subsystem Designation*],
  [*Engineering Scope & Implementation Stack*],
  [*Size (KLOC)*],
  [*Share (%)*],
  [M1],
  [Plaza Edge Controller],
  [C/C++ native lane daemon; RS-485 sensors, barrier solenoids],
  [15.5],
  [20.4%],
  [M2],
  [Transaction Switch],
  [Go / gRPC lockless priority queue routing engine],
  [16.0],
  [21.1%],
  [M3],
  [Cryptographic HSM Client],
  [Rust PKCS\#11 wrapper; AES-128/3DES mutual tag authentication],
  [9.5],
  [12.5%],
  [M4],
  [Offline Buffer Manager],
  [Embedded C++ RocksDB store-and-forward sync (72-hr autonomy)],
  [11.0],
  [14.5%],
  [M5],
  [Reconciliation Engine],
  [Java / Kafka Streams multi-bank net settlement pipeline],
  [13.5],
  [17.8%],
  [M6],
  [Member Bank Gateway],
  [Go mTLS 1.3 webhook dispatcher & NPCI proxy],
  [10.5],
  [13.7%],
  [*Total*],
  [*Integrated Platform*],
  [*Enterprise-Grade Distributed Tolling Switch*],
  [*76.0*],
  [*100.0%*],
)

#v(0.6em)
#info-card(
  [Sizing Principle: Decoupled Service Boundaries],
  [Delivered lines of code represent verifiable source statements excluding whitespace and comments. Partitioning the codebase into six bounded contexts reduces subsystem coupling and allows team parallelism during the core implementation phase.],
)

// =============================================================================
// SECTION 3: SYSTEM ARCHITECTURE & SUBSYSTEM INTERACTIONS
// =============================================================================
#pagebreak()
= System Architecture

== Architectural Topology
The Electronic Toll Collection platform employs a three-tier hybrid topology designed to isolate local real-time lane actuation from variable WAN network latency.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/system_architecture.svg", width: 94%),
    caption: [Tiered System Architecture: \ Plaza Edge (M1, M4) $arrow.r$ Central Switch (M2, M3) $arrow.r$ Banking Settlement (M5, M6).],
  )
]
#v(0.3em)

== Subsystem Interface & Protocol Specifications
Interaction between tiers is governed by strict communication contracts optimized for throughput, security, and network partition resilience:

#custom-table(
  (1.1fr, 1.1fr, 1.2fr, 2.6fr),
  [*Source*],
  [*Target*],
  [*Protocol / Format*],
  [*Performance SLA & Functional Contract*],
  [Edge Controller (M1)],
  [Central Switch (M2)],
  [gRPC / Protobuf over WAN],
  [Lane clearance request; sub-50ms round-trip budget; fallback to M4 on timeout.],
  [Central Switch (M2)],
  [Crypto HSM (M3)],
  [PKCS\#11 native IPC],
  [Mutual authentication of EPC Gen-2 tag keys in $< 15"ms"$ local latency.],
  [Edge Controller (M1)],
  [Offline Buffer (M4)],
  [RocksDB WAL (Local C++)],
  [Zero-latency local append log; ensures zero vehicular stall during WAN outage.],
  [Offline Buffer (M4)],
  [Central Switch (M2)],
  [Batched gRPC Stream],
  [Automatic reconciliation stream executed upon WAN telecommunication recovery.],
  [Central Switch (M2)],
  [Reconciliation (M5)],
  [Kafka Streaming Event Bus],
  [High-throughput asynchronous ledger posting sustaining up to 12,000 EPS.],
  [Reconciliation (M5)],
  [Bank Gateway (M6)],
  [mTLS 1.3 / ISO 8583],
  [NPCI compliance clearing batch dispatch to acquiring and issuing bank hosts.],
)

// =============================================================================
// SECTION 4: COCOMO PROJECT MODE CLASSIFICATION
// =============================================================================

= Mode Classification

== Barry Boehm's Three Development Modes
Barry Boehm categorized software projects into three distinct development modes, each characterized by team familiarity, operational constraints, and system novelty:

1. *Organic Mode:* Represents small, relatively simple software projects developed by small teams with good in-house experience in familiar environments. Requirements are flexible and unconstrained (e.g., standard internal inventory tracking or administrative payroll systems).
2. *Semi-Detached Mode:* Represents projects of intermediate size and complexity where team members possess mixed experience. Some requirements are rigid while others are flexible. The system often interfaces with diverse hardware or external networks (e.g., database management engines, financial switches, or transaction routers).
3. *Embedded Mode:* Represents projects developed under tight operational and hardware constraints. Software is coupled directly to custom physical hardware or strict regulatory mandates where errors can be catastrophic (e.g., flight guidance avionics, nuclear power control, or medical pacemaker firmware).

== Classification Assessment for the Platform
To classify the system objectively, the platform is evaluated across Barry Boehm's five primary classification axes:

#custom-table(
  (1.2fr, 1.1fr, 2.7fr),
  [*Classification Axis*],
  [*System Parameter*],
  [*Operational Assessment for the Platform*],
  [1. Project Sizing],
  [76.0 KLOC],
  [Exceeds organic bounds ($< 50" KLOC"$); corresponds to medium-large distributed platform.],
  [2. System Novelty],
  [Intermediate / Hybrid],
  [Merges mature banking protocols (ISO 8583) with specialized high-speed RFID edge telemetry.],
  [3. Operating Constraints],
  [Stringent Latency],
  [Sub-100ms hardware response budgets; robust network fault tolerance with local offline fallback.],
  [4. Team Experience],
  [Mixed Experience],
  [Backend systems developers skilled in Go/Linux; intermediate familiarity with toll plaza hardware.],
  [5. Requirement Rigidity],
  [Financial / Regulatory],
  [Strict banking compliance specifications; edge lane actuation allows moderate internal flexibility.],
)

== Classification Decision & Mode Justification
Based on this multi-criteria analysis, the platform is classified as *Semi-Detached Mode*:
- *Why Organic was Rejected:* Organic mode assumes relaxed deadlines, minimal hardware constraints, and standard business logic. The sub-100ms barrier actuation SLAs and multi-bank settlement rules eliminate Organic mode as a viable classification.
- *Why Embedded was Rejected:* In a purely Embedded project, the entire system is tightly integrated with custom, unchangeable hardware where software changes are prohibitively costly. In the toll processing architecture, the central transaction switch and banking gateways run in scalable cloud containers using standard Linux tools, making an Embedded classification an overestimation of actual project constraints.
- *Conclusion:* Semi-Detached mode accurately reflects the operational balance between rigid edge hardware constraints and flexible cloud-based software microservices.

// =============================================================================
// SECTION 5: BASIC COCOMO DERIVATIONS
// =============================================================================

= Baseline Estimates

== Basic COCOMO Mathematical Formulations
In the Basic COCOMO model, effort and schedule are expressed as non-linear power functions of software size (in KLOC):
$ E = a_b times (K L O C)^(b_b) quad "[Person-Months (PM)]" $
$ T_"dev" = c_b times (E)^(d_b) quad "[Calendar Months]" $
$ S S = frac(E, T_"dev") quad "[Average Team Size / Engineers]" $
$ P = frac(K L O C, E) quad "[Productivity in KLOC / Person-Month]" $

== Closed-Form Sizing Derivations
For Semi-Detached mode, Boehm's empirical parameters are $a_b = 3.0, b_b = 1.12, c_b = 2.5, d_b = 0.35$. Sizing is $S = 76.0" KLOC"$:

1. *Effort Calculation ($E$):*
  $ E = 3.0 times (76.0)^(1.12) $
  $ (76.0)^(1.12) = e^(1.12 times ln(76.0)) = e^(1.12 times 4.3307) = e^(4.8504) = 127.794 $
  $ E = 3.0 times 127.794 = bold(383.38) " Person-Months (PM)" $

2. *Development Time Calculation ($T_"dev"$):*
  $ T_"dev" = 2.5 times (383.38)^(0.35) $
  $ (383.38)^(0.35) = e^(0.35 times ln(383.38)) = e^(0.35 times 5.9490) = e^(2.0822) = 8.0217 $
  $ T_"dev" = 2.5 times 8.0217 = bold(20.05) " Calendar Months" $

3. *Average Staffing ($S S$) & Productivity ($P$):*
  $ S S = frac(383.38 " PM", 20.05 " Months") = bold(19.12) approx bold(19) " Full-Time Engineers" $
  $ P = frac(76.0 " KLOC", 383.38 " PM") = bold(0.1982) " KLOC/PM" quad (198 " Delivered Source Lines / PM") $

#v(0.6em)
#info-card(
  [Estimation Rule: Exponent b and Diseconomies of Scale],
  [The exponent $b_b = 1.12 > 1.0$ dictates that development effort grows faster than linear code size. This non-linear growth models the communication and coordination penalty of larger teams. Doubling code size from 38 KLOC to 76 KLOC increases effort by a factor of $2^(1.12) = 2.17$, demonstrating why monolithic software platforms incur rising integration penalties.],
)

== Cross-Mode Comparative Sensitivity Analysis
Evaluating the identical $76.0" KLOC"$ baseline across all three development modes illustrates the mathematical sensitivity of the model:

#custom-table(
  (1.2fr, 0.8fr, 0.8fr, 1.0fr, 1.0fr, 1.2fr),
  [*Development Mode*],
  [*$a_b$*],
  [*$b_b$*],
  [*Effort ($E$)*],
  [*Time ($T_"dev"$)*],
  [*Average Staffing ($S S$)*],
  [Organic],
  [2.40],
  [1.05],
  [226.50 PM],
  [19.61 Mos],
  [11.55 Eng (~12 Eng)],
  [*Semi-Detached (Target)*],
  [*3.00*],
  [*1.12*],
  [*383.38 PM*],
  [*20.05 Mos*],
  [*19.12 Eng (~19 Eng)*],
  [Embedded],
  [3.60],
  [1.20],
  [650.55 PM],
  [19.79 Mos],
  [32.87 Eng (~33 Eng)],
)

#v(0.2em)
#align(center)[
  #figure(
    image("assets/cost_scaling_sensitivity.svg", width: 94%),
    caption: [Non-Linear Effort Scaling Trajectory comparing Organic, Semi-Detached, and Embedded Modes for 0 to 100 KLOC.],
  )
]
#v(0.2em)

#info-card(
  [Complexity Scaling: Non-Linear Communication Overhead],
  [The exponent $b_b$ reflects the diseconomies of scale inherent in software development. As code size and system coupling grow, the number of internal communication and integration paths increases proportionally to $n(n-1)/2$. Moving from Organic ($b=1.05$) to Semi-Detached ($b=1.12$) increases effort by $69.3\%$, while Embedded ($b=1.20$) nearly triples required effort ($187.2\%$ increase) for the exact same lines of code.],
)

// =============================================================================
// SECTION 6: INTERMEDIATE COCOMO
// =============================================================================
#pagebreak()
= Effort Calibration

== Limitations of Basic COCOMO
Basic COCOMO assumes that software size in KLOC is the sole determinant of effort. In real engineering environments, this is rarely true. A team of junior developers building mission-critical financial software with outdated tools requires substantially more effort than senior engineers using automated testing and modern frameworks.

To capture these nuances, Barry Boehm formulated *Intermediate COCOMO*, which introduces an *Effort Adjustment Factor (EAF)* calculated as the product of 15 cost drivers across four categories.

== Evaluation of the 15 Cost Drivers for the Platform

#custom-table(
  (.7fr, 0.45fr, 0.6fr, 0.4fr, 2.4fr),
  [*Attribute Group*],
  [*Driver*],
  [*Rating*],
  [*$E M_i$*],
  [*Engineering Justification & Operating Context*],
  [Product \ Attributes],
  [RELY],
  [Very High],
  [1.40],
  [Financial settlement non-repudiation; \ lane failures stall highway corridors.],
  [],
  [DATA],
  [High],
  [1.08],
  [Massive database size; \ high-frequency vehicular telemetry and blacklist tables.],
  [],
  [CPLX],
  [High],
  [1.15],
  [Concurrent ISO 8583 message switching, \ HSM crypto, and store-and-forward.],
  [Platform \ Attributes],
  [TIME],
  [High],
  [1.11],
  [Strict sub-100ms lane barrier release; \ utilizes up to 70% CPU time capacity.],
  [],
  [STOR],
  [Nominal],
  [1.00],
  [Cloud storage unconstrained; \ edge nodes budgeted within 2GB RAM.],
  [],
  [VIRT],
  [Low],
  [0.87],
  [Stable underlying platform: \ hardened Linux OS and container runtime.],
  [],
  [TURN],
  [Nominal],
  [1.00],
  [Automated CI/CD container build and TAT.],
  [Personnel \ Attributes],
  [ACAP],
  [High],
  [0.86],
  [Experienced distributed system and \ financial protocol software architects.],
  [],
  [AEXP],
  [Nominal],
  [1.00],
  [Team has mixed prior familiarity with \ specialized EPC Gen-2 toll RFID.],
  [],
  [PCAP],
  [High],
  [0.86],
  [Senior systems developers proficient in \ Go, C++, and asynchronous runtimes.],
  [],
  [VEXP],
  [Nominal],
  [1.00],
  [Standard operational experience with \  Linux distributions and Docker.],
  [],
  [LEXP],
  [Nominal],
  [1.00],
  [Extensive development experience in C, Go, and SQL.],
  [Project \ Attributes],
  [MODP],
  [High],
  [0.91],
  [Systematic modern practices: \ microservices, automated unit tests, and TDD.],
  [],
  [TOOL],
  [High],
  [0.91],
  [State-of-the-art tooling: \ distributed tracing, eBPF profiling, and CI/CD.],
  [],
  [SCED],
  [Nominal],
  [1.00],
  [Standard development schedule \ without artificial milestone compression.],
)

#v(0.2em)
#align(center)[
  #figure(
    image("assets/cost_drivers_tornado.svg", width: 94%),
    caption: [Cost Driver Sensitivity Tornado: Effort Multiplier Deviations from Nominal (1.00) netting EAF = 1.028.],
  )
]
#v(0.2em)

== Calculation of EAF & Calibrated Intermediate Results
$
  E A F = product_(i=1)^(15) E M_i = 1.40 times 1.08 times 1.15 times 1.11 times 0.87 times 0.86^2 times 0.91^2 = bold(1.028)
$

Applying the Effort Adjustment Factor to Semi-Detached Intermediate COCOMO ($a_i = 3.0, b_i = 1.12$):
$ E_"adj" = a_i times (K L O C)^(b_i) times E A F = 383.38 times 1.028 = bold(394.11) " PM" $
$ T_("dev, adj") = 2.5 times (394.11)^(0.35) = bold(20.27) " Calendar Months" $
$ S S_"adj" = frac(394.11 " PM", 20.27 " Months") = bold(19.44) approx bold(20) " Full-Time Engineers" $
$ P_"adj" = frac(76.0 " KLOC", 394.11 " PM") = bold(0.1928) " KLOC/PM" quad (193 " Delivered Lines / PM") $

#v(0.4em)
#info-card(
  [Engineering Insight: Human Capital Neutralization of Operational Risk],
  [In mission-critical fintech software, stringent reliability ($R E L Y = 1.40$) and latency constraints ($T I M E = 1.11$) exert strong upward pressure on development effort. However, assembling high-capability engineering personnel ($A C A P = 0.86, P C A P = 0.86$) and mandating modern developer tooling ($T O O L = 0.91, M O D P = 0.91$) counterbalances this risk, holding the net adjustment penalty to just $+2.8\%$.],
)

// =============================================================================
// SECTION 7: ESTIMATION WORKFLOW & DECISION METHODOLOGY
// =============================================================================

= Estimation Methodology

== The Five-Stage Estimation Process
To transition from initial system requirements to actionable financial and resource plans, software engineering leadership follows a structured five-stage estimation workflow:
1. *Stage 1: Functional Sizing:* The engineering problem is decomposed into cohesive modules (M1 to M6). Lines of code are estimated using function point mapping and historical comparisons.
2. *Stage 2: Mode Selection:* The system operational characteristics and constraints are evaluated against Boehm's criteria to select Organic, Semi-Detached, or Embedded mode.
3. *Stage 3: Cost Driver Assessment:* The 15 environmental factors are rated to compute the Effort Adjustment Factor ($E A F$).
4. *Stage 4: Mathematical Execution:* Sizing inputs and calibrated parameters are executed through non-linear equations to yield baseline Effort, Duration, and Staffing.
5. *Stage 5: Phased Loading & Financial Budgeting:* Gross person-months are mapped onto SDLC milestones and multiplied by loaded regional labor rates to establish the project capital budget.

#v(0.4em)
#align(center)[
  #figure(
    image("assets/cocomo_methodology.svg", width: 92%),
    caption: [COCOMO Sizing Pipeline: Sizing $arrow.r$ Mode Matrix $arrow.r$ 15 Cost Drivers $arrow.r$ Mathematical Engine $arrow.r$ Project Budget.],
  )
]
#v(0.4em)

== Key Insights from the Estimation Pipeline
- *Reliability Premium:* In financial tolling software, high reliability ($R E L Y = 1.40$) and latency constraints ($T I M E = 1.11$) create an upward effort pressure of nearly $55\%$.
- *Developer Competence as a Counterbalance:* This upward pressure is successfully mitigated by utilizing senior personnel ($A C A P = 0.86, P C A P = 0.86$) and modern engineering tooling ($M O D P = 0.91, T O O L = 0.91$), bringing the net adjustment factor down to a balanced $E A F = 1.028$ ($+2.8\%$).
- *Contingency Reserves:* Empirical models provide a realistic target, but software engineering management standardly allocates a $15\%$--$20\%$ reserve buffer to accommodate late-stage specification changes from external banking partners.

// =============================================================================
// SECTION 8: PHASE SCHEDULE & STAFFING PROFILE
// =============================================================================

= Project Schedule

== Lifecycle Phase Effort Distribution
Gross effort ($394.11" PM"$) and schedule ($20.27" Months"$) cannot be applied uniformly across the project timeline. Instead, they are distributed across classic Software Development Life Cycle (SDLC) phases following Boehm's Semi-Detached empirical ratios:

#custom-table(
  (1.5fr, 0.8fr, 0.9fr, 0.8fr, 0.9fr, 1.4fr),
  [*Lifecycle Development Phase*],
  [*Effort %*],
  [*Effort (PM)*],
  [*Schedule %*],
  [*Duration*],
  [*Average Staffing*],
  [System Requirements & Architecture],
  [16.0%],
  [63.06 PM],
  [20.0%],
  [4.05 Mos],
  [15.57 Eng (\~16 Eng)],
  [Detailed \ Architectural Design],
  [24.0%],
  [94.59 PM],
  [24.0%],
  [4.86 Mos],
  [19.46 Eng (\~20 Eng)],
  [Coding & Unit Testing (Implementation)],
  [38.0%],
  [149.76 PM],
  [36.0%],
  [7.30 Mos],
  [20.52 Eng (\~21 Eng)],
  [Integration & \ Verification Testing],
  [22.0%],
  [86.70 PM],
  [20.0%],
  [4.05 Mos],
  [21.41 Eng (\~22 Eng)],
  [*Total Project Lifecycle*],
  [*100.0%*],
  [*394.11 PM*],
  [*100.0%*],
  [*20.27 Mos*],
  [*19.44 Eng (\~20 Eng)*],
)

#v(0.3em)
#align(center)[
  #figure(
    image("assets/phase_distribution_schedule.svg", width: 90%),
    caption: [Phase Schedule Gantt & Rayleigh Manpower Loading Curve showing Staff Ramp-up to Peak 22.4 Engineers.],
  )
]
#v(0.3em)

== Analysis of Rayleigh Curve Dynamics
A common trap in software engineering is the *flat staffing fallacy* -- assuming that if an estimate calls for 20 engineers, all 20 should be assigned on Day 1.

In reality, software staffing follows the *Norden-Rayleigh distribution*:
- *Ramp-up (Months 1--4):* Early requirements and architecture phases require high-level design decisions where large headcounts create communication gridlock. Staffing begins with a focused core of $15$ senior architects.
- *Peak Execution (Months 9--14):* Manpower peaks at $22.4$ engineers during core module coding and unit testing when work can be parallelized across decoupled microservice boundaries.
- *Ramp-down & Integration (Months 16--20):* As code is frozen, team size tapers to avoid violating Brooks' Law during critical integration testing.

// #pagebreak()

// =============================================================================
// SECTION 9: COST ESTIMATION & GOVERNANCE
// =============================================================================

= Cost Budgeting

== Capital Expenditure Breakdown
To translate calculated engineering person-months into an operational project budget, a fully burdened monthly labor rate of ₹1,75,000 per person-month is applied. This rate accounts for gross salary, health benefits, workstation infrastructure, development tooling, and shared administrative facilities:

#custom-table(
  (1.3fr, 1.15fr, 1.1fr, 2.2fr),
  [*Budgetary \ Component*],
  [*Unit Basis / Rate*],
  [*Calculated Cost*],
  [*Operational Description*],
  [Engineering \ Labor Cost],
  [₹1,75,000 / PM],
  [₹6,89,69,250],
  [Direct compensation for $394.11" PM"$ across 20 full-time engineers.],
  [Hardware \ & Sensor Labs],
  [Lump sum],
  [₹38,00,000],
  [Physical RFID readers, optical AVC sensors, barrier solenoids, and HSMs.],
  [Cloud \ Infrastructure & Bus],
  [₹2,20,000 / PM],
  [₹44,59,400],
  [Multi-region Kubernetes clusters, Kafka streaming bus, and vault staging.],
  [Security, Audit & Certs],
  [Lump sum],
  [₹27,75,680],
  [NPCI compliance certification, CERT-In security audits, and pen-testing.],
  [*Total Capital \ Expenditure*],
  [*--*],
  [*₹8,00,04,330*],
  [*Comprehensive Project Budget (₹8.00 Crores)*],
)

== Operational Strategy
1. *Agile Sprint Mapping:* Macro-level person-month estimates translate directly into two-week development sprints. Over the $20.27$-month ($approx 88$ weeks) timeline, the team executes $44$ two-week development sprints. Delivering $76.0" KLOC"$ translates to an average sprint velocity of approximately $860$ verified lines of code per sprint.
2. *Staffing Stability & Brooks' Law:* Adding personnel to a software project during late-stage integration increases coordination overhead exponentially ($n(n-1)/2$). Engineering governance mandates maintaining team stability during the final four months.
3. *Sizing Verification:* Sizing accuracy serves as the foundation of all cost modeling. Sizing must be continuously calibrated throughout design reviews as specifications mature.
4. *Summary:* Parametric cost estimation provides an empirical foundation for engineering planning, establishing defensible schedules and budgets while highlighting project risk factors.

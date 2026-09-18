
#let m(it) = box(
  fill: rgb("#fff7ed"),
  inset: (x: 3.5pt, y: 0pt),
  outset: (y: 2pt),
  radius: 3pt,
  stroke: 0.4pt + rgb("#fdba74"),
  text(fill: rgb("#9a3412"), font: "DejaVu Sans Mono", size: 8.5pt, it),
)

#let info-card(title, content, border-color: rgb("#ea580c")) = block(
  width: 100%,
  fill: rgb("#fff7ed"),
  stroke: (left: 3.5pt + border-color, rest: 0.5pt + rgb("#fed7aa")),
  radius: (right: 4pt),
  inset: (x: 9pt, y: 5.5pt),
  [
    #text(weight: "bold", fill: border-color, size: 9pt)[#title] \
    #v(2pt)
    #set text(size: 8.5pt, fill: rgb("#334155"))
    #content
  ],
)

#set page(
  paper: "a4",
  fill: rgb("#ffffff"), // Pure white background
  margin: (x: 2.1cm, top: 2.2cm, bottom: 2cm),
  header: none, // Header removed from all pages
  footer: context {
    if here().page() > 1 {
      line(length: 100%, stroke: 0.5pt + rgb("#e2e8f0"))
      v(-0.2em)
      set text(size: 8.5pt, fill: rgb("#64748b"))
      [UML Blueprint: Visualizing System Design]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    }
  },
)

#set text(
  fill: rgb("#18181b"), // Charcoal high-contrast text
  font: ("Inter", "Liberation Sans", "Noto Sans"),
  size: 9.8pt,
)

#set par(
  justify: true,
  leading: 0.56em,
  spacing: 0.78em,
)

#show heading: it => block(
  inset: (top: 0.35em, bottom: 0.15em),
  text(size: 1.18em, weight: "bold", fill: rgb("#0f172a"), it.body),
)

#show heading.where(level: 1): it => block(
  inset: (top: 0.4em, bottom: 0.2em),
  [
    #text(size: 1.24em, weight: "bold", fill: rgb("#ea580c"), it.body)
    #v(2pt)
    #line(length: 100%, stroke: 0.75pt + rgb("#fdba74"))
  ],
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.32em, bottom: 0.14em),
  text(size: 1.02em, weight: "bold", fill: rgb("#1e293b"), it.body),
)

#show heading.where(level: 3): it => block(
  inset: (top: 0.22em, bottom: 0.1em),
  text(size: 0.92em, weight: "bold", fill: rgb("#c2410c"), it.body),
)

// Academic Table Styling
#show table.cell.where(y: 0): set text(fill: rgb("#ffffff"), weight: "bold")
#let custom-table(columns, ..data) = table(
  columns: columns,
  fill: (col, row) => if row == 0 { rgb("#ea580c") } else if calc.even(row) { rgb("#f8fafc") } else { rgb("#ffffff") },
  stroke: 0.4pt + rgb("#e2e8f0"),
  inset: (x: 4.5pt, y: 3.5pt),
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  ..data
)

// =============================================================================
// PAGE 1: COVER PAGE
// =============================================================================

#v(2.5cm)

#align(left)[
  #v(3em)
  #text(
    size: 28pt,
    weight: "bold",
    fill: rgb("#0f172a"),
  )[
    UML Blueprint &\
    System Architecture
  ]
  #line(length: 100%, stroke: 1.2pt + rgb("#ea580c"))

]

#v(1fr)


#v(4pt)
#text(size: 18pt, weight: "bold", fill: rgb("#0f172a"))[
  #set align(right)
  Jayesh Kumar]
// #v(4pt)
#text(size: 13pt, fill: rgb("#475569"))[
  #set align(right)
  240905050047 - X1\
  BETCE15502 - ALA - I\
  Software Engineering
]


#pagebreak()

// =============================================================================
// PAGE 2: PROBLEM DEFINITION, REQUIREMENTS & ACTORS (Numbered 1 / 5)
// =============================================================================
#counter(page).update(1)

= System Definition: NexusPlay Multiplayer Platform

== Problem Overview
Competitive online multiplayer platforms operate within demanding distributed environments requiring real-time synchronization, low-latency match placement, and strict competitive integrity. Modern multiplayer titles face critical operational hurdles including skill-calibrated matchmaking under $50"ms"$ ping thresholds, dynamic lobby state convergence, anti-cheat memory verification, and atomic inventory transactions.

*NexusPlay* is architected as a cloud-native platform that addresses these requirements through decoupled microservices for skill-calibrated matchmaking, party lobbies, persistent inventory storage, and active anti-cheat telemetry verification.

== Detailed System Requirements (SRS)

#custom-table(
  (0.8fr, 1.3fr, 2.7fr, 0.7fr),
  [*ID*],
  [*Requirement Name*],
  [*Technical Specification & Operational Criteria*],
  [*Priority*],
  [FR-01],
  [Ranked Matchmaking],
  [System shall group players within $+- 75$ MMR points and $< 50"ms"$ network ping in $< 30$ seconds.],
  [Critical],
  [FR-02],
  [Party Coordination],
  [Players can form 2--5 member lobbies, invite registered friends, transfer leader role, and ready up.],
  [High],
  [FR-03],
  [Anti-Cheat Verification],
  [Client daemon streams encrypted memory hash deltas every 5 seconds; anomalies trigger automated flags.],
  [Critical],
  [FR-04],
  [Inventory Transactions],
  [Players purchase digital currency and equip cosmetic skins with atomic distributed database locks.],
  [High],
  [NFR-01],
  [Tick-Rate & Latency],
  [Dedicated game servers sustain 128-tick simulation rates; matchmaking API response latency $"P99" < 150"ms"$.],
  [High],
  [NFR-02],
  [Scalability & Uptime],
  [Platform sustains 500,000 concurrent connected players with 99.99% service availability.],
  [Critical],
)

== Actors & Core Operational Processes

#custom-table(
  (1.1fr, 1.0fr, 2.7fr),
  [*Actor Name*],
  [*Classification*],
  [*Operational Responsibility in NexusPlay*],
  [Player],
  [Primary Human],
  [Queues for competitive matches, coordinates party lobbies, and purchases/equips cosmetic skins.],
  [Matchmaker Engine],
  [Backend Service],
  [Calculates MMR ratings, clusters party sizes, and provisions dedicated regional game servers.],
  [Anti-Cheat Daemon],
  [Security Agent],
  [Kernel/user daemon monitoring binary checksums, memory hooks, and streaming telemetry.],
  [Game Moderator],
  [Admin Human],
  [Audits flagged suspicious match replays and issues disciplinary hardware or account suspensions.],
  [Payment Gateway],
  [External Service],
  [Third-party financial clearinghouse processing credit cards, PayPal, and digital wallet checkouts.],
)

#v(0.2em)
#info-card(
  [Architectural Design Constraint: 128-Tick Determinism & Latency SLA],
  [Match allocations enforce a strict $"P99" < 150"ms"$ threshold for edge handshakes. Game simulation instances execute dedicated 128-tick loops ($7.81"ms"$ frame window), ensuring state delta synchronization is completed prior to rendering passes on connected client engines.],
)

#pagebreak()

// =============================================================================
// PAGE 3: UML USE CASE DIAGRAM (Numbered 2 / 5)
// =============================================================================

= UML Diagram 1: Use Case Diagram

== Architectural Principles & Boundary Analysis
The *Use Case Diagram* formalizes system functional boundaries and external actor interactions:
- *System Boundary:* Distinguishes internal services (matchmaker, lobby daemon, store) from external actors (`Player`, `Anti-Cheat Daemon`, `Payment Gateway`, `Moderator`).
- *`<<include>>` Dependencies:* Mandatory subordinate behaviors: `Queue for Ranked Match` unconditionally mandates `Calibrate MMR & Ping` and `Authenticate Token`.
- *`<<extend>>` Dependencies:* Conditional execution branches: `Stream Client Telemetry` conditionally triggers `Flag Cheating Anomaly` only upon detecting memory signature discrepancies.

\

#v(0.1em)
#align(center)[
  #figure(
    image("assets/orange/use_case_diagram.svg", width: 75%),
    caption: [NexusPlay UML Use Case Diagram showing Actors, \ System Boundary, and Stereotype Dependencies.],
  )
]\

#v(0.1em)
=== Key Use Case Specification: Queue for Ranked Match (UC-01)

#custom-table(
  (1.1fr, 2.9fr),
  [*Attribute*],
  [*Specification Details*],
  [Use Case ID & Name],
  [UC-01: Queue for Ranked Match],
  [Primary Actor],
  [Player (Lobby Leader)],
  [Secondary Actors],
  [Matchmaker Engine, Anti-Cheat Daemon],
  [Preconditions],
  [Player is authenticated, anti-cheat handshake is verified, and all party members are marked 'Ready'.],
  [Main Success Flow],
  [
    1. Lobby leader selects Ranked Competitive mode and clicks `Find Match`. \
    2. System verifies party member eligibility and anti-cheat daemon handshake status (`<<include>>`). \
    3. Matchmaker pools players, calibrates aggregate party MMR, and queries nearest low-latency server cluster. \
    4. Match is found; system prompts all 10 players to accept match within 20 seconds. \
    5. All players accept; dedicated game server slot is allocated and players connect to the match.
  ],
  [Alternative Flow],
  [2a. Anti-cheat detects tampered `.dll` -> Queue aborted, account immediately flagged for review.],
)

#pagebreak()

// =============================================================================
// PAGE 4: UML SEQUENCE DIAGRAM (Numbered 3 / 5)
// =============================================================================

= UML Diagram 2: Sequence Diagram

== Dynamic Behavioral Modeling: Ranked Matchmaking Flow
While structural models describe static relationships, the *UML Sequence Diagram* illustrates the dynamic chronological exchange of messages between distributed platform participants realizing *UC-01 (Queue for Ranked Match)*:
- *Lifelines & Roles:* Five core system entities collaborate across the transaction boundary: `Player (Lobby Leader)`, `:PartyLobby` state coordinator, `:MatchmakerEngine` clustering cluster, `:AntiCheatDaemon` integrity sentinel, and the provisioned `:GameServer`.
- *Synchronous Invocations & Returns:* Solid arrows denote blocking API calls (`submitTicket`, `allocateServerSlot`); dashed lines with open arrowheads denote asynchronous completion signals and return values.
- *Concurrent Security Verification:* Telemetry validation executes in parallel with ticket ingestion, guaranteeing that compromised clients are evicted before dedicated server allocation.

#v(0.1em)
#align(center)[
  #figure(
    image("assets/orange/sequence_diagram.svg", width: 68%),
    caption: [NexusPlay UML Sequence Diagram illustrating \ the dynamic runtime flow for UC-01 Ranked Matchmaking.],
  )
]
\

#v(0.1em)
=== Chronological Message Specification & Protocol Lifecycle

#custom-table(
  (0.6fr, 1.3fr, 1.4fr, 1.7fr),
  [*Seq*],
  [*Message Signature*],
  [*Source -> Destination*],
  [*Semantic Behavior & Failure Handling*],
  [1--2],
  [`queueMatch(mode)`],
  [Player -> PartyLobby],
  [Leader triggers queue; lobby verifies all members are marked `Ready`.],
  [3--4],
  [`submitTicket()`],
  [Lobby -> Matchmaker],
  [Aggregates party MMR and initiates security token verification.],
  [5--6],
  [`integrityVerified()`],
  [Anti-Cheat -> Matchmaker],
  [Validates memory checksum delta; flags anomalies immediately.],
  [7--8],
  [`allocateServerSlot()`],
  [Matchmaker -> GameServer],
  [Provisions regional 128-tick instance; returns IP, port, and session auth key.],
  [9--11],
  [`notifyMatchFound()`],
  [System -> Player Clients],
  [Dispatches match confirmation and establishes direct client-to-host UDP socket.],
)

#pagebreak()

// =============================================================================
// PAGE 5: UML CLASS DIAGRAM (Numbered 4 / 5)
// =============================================================================

= UML Diagram 3: Class Diagram

== Domain Model & Object-Oriented Architecture
The *UML Class Diagram* defines the static domain structure, encapsulation levels, and OOP relationships:
- *Inheritance (Generalization Tree):* Abstract `Account` base class encapsulates `#accountId`, `#username`, and `#email`, specialized into concrete `Player` (with `-mmrRating`, `-competitiveTier`) and `GameModerator`.
- *Composition (Filled Diamond):* `Player` composes `InventoryItem` ($1$ to $0..*$); items cease to exist if an account is permanently purged.
- *Multiplicities & Association:* $1..*$ `Player`s associate with $0..1$ `PartyLobby`; $2..*$ lobbies join $1$ `MatchSession`. `MatchSession` produces $0..*$ `AntiCheatReport`s audited by `GameModerator`.
\

#v(0.1em)
#align(center)[
  #figure(
    image("assets/orange/class_diagram.svg", width: 62%),
    caption: [NexusPlay UML Class Diagram depicting \ Object Hierarchy, Unified Inheritance, Composition, and Multiplicities.],
  )
]
\

#v(0.1em)
=== Class Specification & Responsibilities Table

#custom-table(
  (1.1fr, 1.1fr, 2.6fr),
  [*Class Name*],
  [*Relationship*],
  [*Key Responsibilities, Attributes & Operations*],
  [`Account` (Abs)],
  [Base Entity],
  [Encapsulates identity (`#accountId`, `#username`, `#email`). Defines `+authenticate()` and `+updateSettings()`.],
  [`Player`],
  [Inherits `Account`],
  [Manages player state (`-mmrRating`, `-tier`, `-wallet`). Methods: `+queueMatch()`, `+equipSkin()`, `+inviteToParty()`.],
  [`GameModerator`],
  [Inherits `Account`],
  [Staff member responsible for fair play. Methods: `+inspectReplay(matchId)`, `+issueBan(pId, reason)`.],
  [`PartyLobby`],
  [Assoc `Player` ($1..*$)],
  [Transient pre-game room (`-lobbyId`, `-leaderId`, `-maxSize`). Methods: `+addMember()`, `+setReady()`, `+disband()`.],
  [`MatchSession`],
  [Assoc `Lobby` ($2..*$)],
  [Live dedicated server match (`-matchId`, `-serverIp`, `-tickRate`). Methods: `+allocateHost()`, `+recordStats()`.],
  [`InventoryItem`],
  [Comp `Player` ($0..*$)],
  [Cosmetic skins and collectibles (`-itemId`, `-itemName`, `-rarity`). Methods: `+equipItem()`, `+transferOwner()`.],
  [`AntiCheatReport`],
  [Triggered by Match],
  [Security incident log (`-reportId`, `-cheatType`, `-confidenceScore`). Methods: `+triggerShadowBan()`, `+exportEvidence()`.],
)

#pagebreak()

// =============================================================================
// PAGE 6: PRINCIPLES & CONCLUSION (Numbered 5 / 5)
// =============================================================================

= Software Engineering Principles

In architecting the NexusPlay multiplayer platform, core object-oriented and software engineering principles were systematically incorporated:

- *Single Responsibility Principle (SRP):* Each subsystem and class encapsulates a distinct, highly cohesive responsibility. The `MatchSession` class exclusively coordinates dedicated server instances and tick-rate updates, while security anomaly evaluations are decoupled into `AntiCheatReport`.
- *Open/Closed Principle (OCP):* The polymorphic `Account` hierarchy is closed for modification but open for extension. Specialized platform roles such as *TournamentAdmin*, *SpectatorCaster*, or *JuniorReferee* can be added by extending `Account` without altering existing authentication or player session logic.
- *Liskov Substitution Principle (LSP):* Derived types (`Player`, `GameModerator`) seamlessly substitute for `Account` in system-level authentication handshakes and security credential checks without violating base class preconditions or invariants.
- *Interface Segregation & Loose Coupling:* By mediating actor interactions through formal contracts (`<<include>>` for authentication and calibration, `<<extend>>` for anomaly reporting), modifications to payment gateways or third-party OAuth providers do not disrupt active in-game server tick loops.
- *Encapsulation & Data Integrity:* Strict visibility modifiers (`-` private, `#` protected, `+` public) prevent unauthorized state manipulation. Critical player attributes such as `walletBalance` and `mmrRating` can only be updated through atomic server-validated operations.
\
= Conclusion

In this Active Learning Activity (*ALA-1: UML Blueprint: Visualizing System Design*), the real-world domain of competitive multiplayer gaming was analyzed and modeled using formal Software Engineering methodologies:

- *Requirements Engineering:* Detailed functional and non-functional requirements were established, addressing low-latency matchmaking, party synchronization, and telemetry verification.
- *Actor & Process Identification:* Operational roles and workflows were methodically mapped across human players, background daemons, and backend services.
- *Visual Architectural Modeling:* Three industrial-grade UML diagrams were designed and compiled to OMG UML 2.5 standards:
  - The *UML Use Case Diagram* delineated system boundaries, actor associations, and stereotype dependencies (`<<include>>` and `<<extend>>`) with clean zero-crossing routing.
  - The *UML Sequence Diagram* captured dynamic chronological message passing, concurrent security audits, and dedicated host provisioning for the matchmaking lifecycle.
  - The *UML Class Diagram* captured static domain architecture, a unified generalization tree, composition lifecycles, and explicit multiplicity constraints.

The resulting architectural blueprint provides a coherent, unambiguous design model that verifies system feasibility prior to production implementation, fulfilling all academic criteria for the activity.

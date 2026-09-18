#let meta = json("../../../../misc/metadata.json")

#let m(it) = box(
  fill: rgb("#1b1b1f"),
  inset: (x: 4pt, y: 0pt),
  outset: (y: 3pt),
  radius: 3pt,
  stroke: 0.2pt + rgb("#555"),
  text(fill: rgb("#ffffff"), font: "DejaVu Sans Mono", size: 8.5pt, it),
)

#let info-card(title, content, border-color: rgb("#38bdf8")) = block(
  width: 100%,
  fill: rgb("#181822"),
  stroke: (left: 3pt + border-color, rest: 0.4pt + rgb("#282838")),
  radius: (right: 4pt),
  inset: (x: 10pt, y: 6.5pt),
  [
    #text(weight: "bold", fill: border-color, size: 9.5pt)[#title] \
    #v(2pt)
    #set text(size: 9pt, fill: rgb("#cbd5e1"))
    #content
  ],
)

#set page(
  paper: "a4",
  fill: rgb("#141414"), // Dark academic background
  margin: (x: 2.2cm, top: 2.2cm, bottom: 2.2cm),
  header: none, // Top header completely removed from all pages
  footer: context {
    if here().page() > 1 {
      // line(length: 100%, stroke: 0.4pt + rgb("#334155"))
      // v(-0.2em)
      set text(size: 8.5pt, fill: gray.lighten(30%))
      [Software Engineering -- BETCE15322]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    }
  },
)

#set text(
  fill: rgb("#f0f0f0"), // Light text
  font: ("Magnisa Sans", "Times New Roman"),
  size: 9.8pt,
)

#set par(
  justify: true,
  leading: 0.56em,
  spacing: 0.8em,
)

#show heading: it => block(
  inset: (top: 0.45em, bottom: 0.18em),
  text(size: 1.2em, weight: "bold", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.32em, bottom: 0.12em),
  text(size: 1.0em, weight: "bold", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 3): it => block(
  inset: (top: 0.2em, bottom: 0.08em),
  text(size: 0.9em, weight: "bold", fill: rgb("#38bdf8"), it.body),
)

// Academic Table Styling
#let custom-table(columns, ..data) = table(
  columns: columns,
  fill: (col, row) => if row == 0 { rgb("#1e293b") } else if calc.even(row) { rgb("#18181b") } else { rgb("#131316") },
  stroke: 0.4pt + rgb("#334155"),
  inset: 4.2pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  ..data
)

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
      [I], [#meta.ala],
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
  UML \
  BLUEPRINT: \
  CONTENT DISCOVERY
]

// #v(0.4em)
// #text(size: 13pt, fill: rgb("#38bdf8"), weight: "bold")[Alternative Learning Activity - 1 | BETCE15502] \
// #text(size: 9.5pt, fill: rgb("#94a3b8"))[Visualizing System Architecture & Domain Modeling for Real-Time Content Discovery & Recommendation Engines]

#pagebreak()

// =============================================================================
// PAGE 2: PROBLEM DEFINITION, REQUIREMENTS & ACTORS (Numbered 1 / 5)
// =============================================================================
#counter(page).update(1)

= System Definition

== Problem Overview
Modern digital publishing and social streaming platforms operate within massive data velocity environments requiring instantaneous semantic indexing, hyper-personalized ranking, and sub-second feedback convergence. Content discovery systems face critical architectural challenges including multimodal embedding extraction, real-time candidate generation over millions of candidate items under $15"ms"$ vector traversal budgets, deep multi-task CTR/dwell-time ranking, and cold-start exploration bandits.

*PulseFeed* is architected as an industrial cloud-native content discovery platform that decouples multimodal ingestion, approximate nearest neighbor (ANN) vector retrieval, deep machine-learned ranking, and real-time streaming telemetry ingestion.

== Detailed System Requirements (SRS)

#custom-table(
  (0.8fr, 1.3fr, 2.7fr, 0.7fr),
  [*ID*],
  [*Requirement Name*],
  [*Technical Specification & Operational Criteria*],
  [*Priority*],
  [FR-01],
  [Multimodal Ingestion],
  [System ingests articles and videos, generating 512-d dense embeddings within $< 250"ms"$.],
  [High],
  [FR-02],
  [Candidate Retrieval],
  [Queries HNSW vector index using user context embedding to retrieve top-500 candidates in $< 15"ms"$.],
  [Critical],
  [FR-03],
  [Two-Stage Deep Ranking],
  [Multi-task neural model scores candidate pool on pCTR/dwell and applies diversity filtering ($< 35"ms"$).],
  [Critical],
  [FR-04],
  [Telemetry Streaming],
  [Client daemon dispatches viewport dwell and impression events to Kafka/Flink bus in $< 100"ms"$.],
  [High],
  [NFR-01],
  [Latency SLA & Scale],
  [P99 end-to-end feed generation response latency $< 60"ms"$ sustaining 100,000 requests per second.],
  [Critical],
  [NFR-02],
  [High Availability],
  [Vector cluster and serving layers maintain 99.99% availability with multi-region active redundancy.],
  [High],
)

== Actors & Core Operational Processes

#custom-table(
  (1.1fr, 1.0fr, 2.7fr),
  [*Actor Name*],
  [*Classification*],
  [*Operational Responsibility in PulseFeed*],
  [User / Consumer],
  [Primary Human],
  [Requests personalized feeds, executes semantic searches, and emits implicit viewport dwell signals.],
  [Content Creator],
  [Secondary Human],
  [Publishes multimedia articles and video streams, providing metadata tags and publication assets.],
  [Vector Index Engine],
  [Backend Service],
  [Maintains distributed HNSW indices; executes approximate nearest neighbor similarity searches.],
  [Deep ML Ranker],
  [ML Service],
  [Evaluates multi-task deep neural nets (MT-DNN) for click and engagement probability scoring.],
  [Safety Classifier],
  [Security Agent],
  [Automated computer vision and NLP model filtering copyright, toxic, and policy-violating media.],
  [Telemetry Pipeline],
  [Streaming Agent],
  [Distributed Kafka/Flink pipeline aggregating real-time impressions and gradient feature updates.],
  [Content Moderator],
  [Admin Human],
  [Audits quarantined content items, evaluates user reports, and confirms policy enforcement actions.],
)

// #info-card(
//   [Architectural Design Constraint: Multi-Stage Recommendation Latency & Vector Index SLA],
//   [Feed generation enforces a strict P99 latency threshold of $< 60"ms"$. The retrieval pipeline allocates $<= 15"ms"$ for HNSW candidate retrieval (coarse top-500 pool) and $<= 35"ms"$ for multi-task neural scoring and MMR entropy re-ranking, leaving a $10"ms"$ buffer for gateway serialization and edge transit.]
// )

#pagebreak()

// =============================================================================
// PAGE 3: UML USE CASE DIAGRAM (Numbered 2 / 5)
// =============================================================================

= UML Diagram I: Use Case Diagram

== Architectural Principles & Boundary Analysis
The *UML Use Case Diagram* formalizes system functional boundaries and external actor interactions:
- *System Boundary:* Distinguishes internal ingestion and ranking services from external participants (`User`, `Creator`, `Vector Index`, `ML Ranker`, `Safety Classifier`, `Telemetry Pipeline`, `Moderator`).
- *`<<include>>` Dependencies:* Mandatory subordinate behaviors: `Explore Personalized Feed` unconditionally mandates `Retrieve Candidate Pool` and `Score & Rank Candidates`. `Publish Content` unconditionally mandates `Screen Safety`.
- *`<<extend>>` Dependencies:* Conditional execution branches: `Trigger Cold-Start Boost` extends `Score & Rank Candidates` for sparse histories; `Quarantine Violation` extends `Screen Safety` upon policy breach.
\
#v(-0.1em)
#align(center)[
  #figure(
    image("assets/use_case_diagram.svg", width: 95%),
    caption: [PulseFeed UML Use Case Diagram showing System Boundary, Actors, Include Pipelines, and Extension Branches.],
  )
]
\

#v(-0.2em)
=== Key Use Case Specification: Explore Personalized Feed (UC-01)

#custom-table(
  (1.1fr, 2.9fr),
  [*Attribute*],
  [*Specification Details*],
  [Use Case ID & Name],
  [UC-01: Explore Personalized Feed],
  [Primary Actor],
  [User / Consumer],
  [Secondary Actors],
  [Vector Index Engine, Deep ML Ranker, Telemetry Pipeline],
  [Preconditions],
  [User client authenticated; contextual session vector or default exploration embedding loaded.],
  [Main Success Flow],
  [
    1. Client dispatches feed request with session context (device, location, client version) to Feed Gateway. \
    2. Feed Gateway resolves user interest vector and queries Vector Index Engine (`<<include>>`). \
    3. Vector Index Engine executes HNSW ANN traversal, returning top-500 candidate IDs within 12ms. \
    4. Deep ML Ranker evaluates multi-task neural scores (pCTR, dwell), applies diversity filter, and yields top-20 items. \
    5. Feed Gateway packages feed JSON to client ($< 60"ms"$); client streams viewport dwell telemetry asynchronously.
  ],
  [Alternative Flow],
  [4a. Sparse user history -> System triggers Exploration Boost (`<<extend>>`) injecting curated trending clusters.],
)

#pagebreak()

// =============================================================================
// PAGE 4: UML SEQUENCE DIAGRAM (Numbered 3 / 5)
// =============================================================================

= UML Diagram II: Sequence Diagram

== Dynamic Behavioral Modeling: Real-Time Personalized Feed Generation Flow
While structural models describe static relationships, the *UML Sequence Diagram* captures the dynamic chronological message exchange across distributed services executing *UC-01 (Explore Personalized Feed)*:
- *Lifelines & Roles:* Five core system entities collaborate across the serving path: `UserClient`, `:FeedGateway` orchestration layer, `:CandidateRetriever` vector index service, `:MLRankingEngine` deep scoring model, and the background `:TelemetryStreamer`.
- *Synchronous Invocations & Returns:* Solid arrows with filled arrowheads represent blocking service calls (e.g., `fetchCandidatePool`, `rankCandidates`), while dashed lines denote asynchronous return payloads.
- *Asynchronous Telemetry Ingestion:* Client-side telemetry dispatches asynchronously after rendering, decoupling UI interactions from heavy streaming event bus writes.
\
#v(-0.1em)
#align(center)[
  #figure(
    image("assets/sequence_diagram.svg", width: 95%),
    caption: [PulseFeed UML Sequence Diagram illustrating the dynamic runtime flow for UC-01 Feed Generation.],
  )
]
\
#v(-0.2em)
=== Chronological Message Specification & Protocol Lifecycle

#custom-table(
  (0.5fr, 1.4fr, 1.4fr, 1.7fr),
  [*Seq*],
  [*Message Signature*],
  [*Source -> Destination*],
  [*Semantic Behavior & Performance SLA*],
  [1--2],
  [#text(size: 8.2pt)[`requestFeed(ctx)`]],
  [UserClient -> FeedGateway],
  [Client initiates feed query; Gateway resolves real-time user context vector.],
  [3--5],
  [#text(size: 8.2pt)[`fetchCandidates(topK)`]],
  [Gateway -> CandidateRetriever],
  [HNSW vector search over millions of items; returns candidate IDs in $< 15"ms"$.],
  [6--8],
  [#text(size: 8.2pt)[`rankCandidates(pool)`]],
  [Gateway -> MLRankingEngine],
  [MT-DNN evaluates pCTR and dwell-time; entropy filter enforces topic diversity.],
  [9--10],
  [#text(size: 8.2pt)[`feedResponse(top20)`]],
  [MLRankingEngine -> UserClient],
  [Gateway aggregates metadata and returns JSON feed payload to client within $< 60"ms"$.],
  [11--12],
  [#text(size: 8.2pt)[`streamTelemetry()`]],
  [UserClient -> TelemetryStreamer],
  [Client streams viewport dwell times asynchronously; Kafka bus buffers event stream.],
)

#pagebreak()

// =============================================================================
// PAGE 5: UML CLASS DIAGRAM (Numbered 4 / 5)
// =============================================================================

= UML Diagram III: Class Diagram

== Domain Model & Object-Oriented Architecture
The *UML Class Diagram* defines the static domain structure, encapsulation levels, and OOP relationships:
- *Inheritance (Generalization Tree):* Abstract `ContentItem` base class encapsulates `#contentId`, `#creatorId`, `#title`, `#category`, and `#baseEngagementScore`, specialized into `ArticleContent` and `VideoContent`.
- *Composition (Filled Diamond):* `UserProfile` composes `InteractionSignal` ($1$ to $0..*$); signals represent atomic user engagement records whose lifecycle is strictly bound to the parent user entity.
- *Multiplicities & Association:* `ContentItem` maintains a $1 <-> 1$ association with `VectorEmbedding`; `UserProfile` associates with $0..*$ `FeedSession`s; `FeedSession` aggregates $1..*$ scored candidates.
\
#v(-0.1em)
#align(center)[
  #figure(
    image("assets/class_diagram.svg", width: 73%),
    caption: [PulseFeed UML Class Diagram depicting Object Hierarchy, Generalization, Composition, and Multiplicities.],
  )
]
\
#v(-0.2em)
=== Class Specification & Responsibilities Table

#custom-table(
  (1.1fr, 1.1fr, 2.6fr),
  [*Class Name*],
  [*Relationship*],
  [*Key Responsibilities, Attributes & Operations*],
  [`ContentItem` (Abs)],
  [Base Entity],
  [Encapsulates content identity (`#contentId`, `#creatorId`, `#title`, `#category`). Defines `+getFeatures()`, `+calculateFreshnessDecay()`.],
  [`ArticleContent`],
  [Inherits `ContentItem`],
  [Text-based publications (`-markdownBody`, `-wordCount`, `-readingTimeMinutes`). Methods: `+extractKeyEntities()`, `+calculateReadability()`.],
  [`VideoContent`],
  [Inherits `ContentItem`],
  [Video streams (`-videoUrl`, `-durationSeconds`, `-resolution`, `-frameRate`). Methods: `+getFrameSampleRate()`, `+extractAudioTranscript()`.],
  [`VectorEmbedding`],
  [Assoc `ContentItem` (1:1)],
  [512-dimensional dense embedding (`-embeddingId`, `-dimensions`, `-vectorValues`). Methods: `+cosineSimilarity()`, `+dotProduct()`.],
  [`UserProfile`],
  [Domain Entity],
  [User state and preferences (`-userId`, `-username`, `-isColdStart`, `-contextVector`). Methods: `+updateInterests()`, `+decayLongTermWeights()`.],
  [`InteractionSignal`],
  [Comp `UserProfile` ($0..*$) ],
  [Telemetry event (`-signalId`, `-signalType`, `-dwellTimeMs`, `-recordedAt`). Methods: `+getImplicitWeight()`, `+isPositiveSignal()`.],
  [`FeedSession`],
  [Assoc `User` / Agg `Item`],
  [Delivery session (`-sessionId`, `-userId`, `-retrievalLatencyMs`, `-rankingLatencyMs`). Methods: `+appendRankedItem()`, `+calculateSessionP99()`.],
)

#pagebreak()

// =============================================================================
// PAGE 6: PRINCIPLES & CONCLUSION (Numbered 5 / 5)
// =============================================================================

= Principles Used

In architecting the PulseFeed content discovery platform, core object-oriented and software engineering principles were systematically incorporated:

1. *Single Responsibility Principle (SRP):* Each subsystem and class encapsulates a distinct, highly cohesive responsibility. The `CandidateRetriever` exclusively handles high-recall ANN vector queries, the `MLRankingEngine` isolates fine-grained multi-task scoring and diversity optimization, and telemetry ingestion is segregated into `InteractionSignal`.
2. *Open/Closed Principle (OCP):* The polymorphic `ContentItem` hierarchy is closed for modification but open for extension. New media modalities such as *PodcastAudioContent*, *InteractiveStoryItem*, or *LiveStreamItem* can be added by extending `ContentItem` without altering existing vector indexing or ranking engine interfaces.
3. *Liskov Substitution Principle (LSP):* Specialized subclasses (`ArticleContent`, `VideoContent`) seamlessly substitute for `ContentItem` in candidate generation pipelines and scoring evaluators without violating base class preconditions, invariants, or scoring contracts.
4. *Interface Segregation & Loose Coupling:* By mediating subsystem interactions through clean service interfaces (`ICandidateRetriever`, `IRankingEngine`, `ITelemetrySink`), updates to underlying vector index algorithms (e.g., migrating from HNSW to ScaNN) do not impact feed gateway routing or client applications.
5. *Encapsulation & Data Integrity:* Visibility modifiers (`-` private, `#` protected, `+` public) safeguard critical domain state. Dense embedding arrays and user profile weights can only be updated through validated mathematical transformations, protecting the system against state corruption.

#let meta-data = (
  name: "<name>",
  roll_no: "xxxxxxxxxxxx",
  subject: "Software Engineering",
  sub_code: "BETCE15502",
  section: "<class>",
  semester: "Semester V",
  department: "Department of Computer Engineering",
  institute: "Gyanmanjari Innovative University",
  academic_year: "2026 - 2027",
)


// Document Styling
#set page(
  paper: "a4",
  margin: (x: 2.54cm, y: 2.54cm),
  header: context {
    if here().page() > 2 {
      set text(size: 9pt, font: ("Times New Roman", "Liberation Serif"))
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#meta-data.institute], [#meta-data.subject (#meta-data.sub_code)],
      )
      v(-0.4em)
      line(length: 100%, stroke: 0.5pt + luma(120))
    }
  },
  footer: context {
    if here().page() > 1 {
      set text(size: 9pt, font: ("Times New Roman", "Liberation Serif"))
      line(length: 100%, stroke: 0.5pt + luma(180))
      v(-0.2em)
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [Enrollment No: #meta-data.roll_no], [Page #counter(page).display("1")],
      )
    }
  },
)

#set text(
  font: ("Times New Roman", "Serif"),
  size: 11pt,
)

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.05em,
)

#show heading: it => block(
  inset: (top: 1em, bottom: 0.5em),
  text(weight: "bold", it),
)

#show heading.where(level: 1): it => block(
  width: 100%,
  inset: (bottom: 6pt, top: 1.5em),
  text(size: 16pt, weight: "bold", it.body),
)

// UI Component Helpers
#let badge(body, fill: none, stroke-color: none, text-color: none) = [
  #text(weight: "bold", body)
]

#let info-card(title, content, bride-color: none) = [
  #v(1em)
  #block(
    width: 100%,
    inset: (left: 10pt, top: 5pt, bottom: 5pt),
    stroke: (left: 2pt + luma(100)),
    [
      #text(weight: "bold", title) \
      #v(3pt)
      #content
    ],
  )
  #v(1em)
]

#let practical-header(num, title, unit, hrs) = [
  #v(1.5em)
  #heading(level: 1, [Practical #num])
  #v(0.5em)
  #text(size: 14pt, weight: "bold", title)
  #v(0.5em)
  #text(style: "italic", [Unit: #unit | Hours: #hrs])
  #v(1em)
]

#let custom-table(columns, ..data) = table(
  columns: columns,
  stroke: 0.5pt + luma(0),
  inset: 7pt,
  align: left + horizon,
  ..data
)


// =============================================================================
// COVER PAGE
// =============================================================================

#align(center)[
  #v(3em)
  #text(size: 14pt, weight: "bold")[DEPARTMENT OF COMPUTER ENGINEERING]

  #v(4em)
  #text(size: 24pt, weight: "bold")[SOFTWARE ENGINEERING] \
  #v(1em)
  #text(size: 16pt, weight: "semibold")[LABORATORY MANUAL]
  #v(35em)
  #align(center)[
    #text(size: 14pt, weight: "bold")[STUDENT PROFILE]
    #v(1em)

    #grid(
      columns: (auto, auto),
      row-gutter: 12pt,
      column-gutter: 20pt,
      align: (right, left),
      [Student Name:], [#text(weight: "bold")[#meta-data.name]],
      [Enrollment No:], [#text()[#meta-data.roll_no]],
      [Semester / Division:], [#text()[#meta-data.semester / #meta-data.section]],
      [Department:], [#text()[#meta-data.department]],
      [Subject:], [#text()[#meta-data.subject (#meta-data.sub_code)]],
    )
  ]
]

#pagebreak()


// =============================================================================
// PRACTICAL INDEX TABLE
// =============================================================================

= Laboratory Curriculum & Practical Index

#v(0.5em)

#custom-table(
  (0.4fr, 2.8fr, 0.6fr, 0.6fr),
  [*Sr.*],
  [*Practical Description*],
  [*Unit*],
  [*Hours*],
  [1],
  [Study the complete Software Development Life Cycle (SDLC) and analyze various activities conducted as a part of various phases.],
  [1],
  [2],
  [2],
  [Develop requirements specification for a given problem (IEEE Std 830 Format).],
  [4],
  [4],
  [3],
  [Develop UML Use case diagram for a problem.],
  [5],
  [2],
  [4],
  [Develop UML Activity and Swim Lane diagram for a problem.],
  [5],
  [2],
  [5],
  [Develop UML Class diagram for a problem.],
  [5],
  [2],
  [6],
  [Develop UML Sequence diagram for a problem.],
  [5],
  [2],
  [7],
  [Develop UML Data Flow diagram (DFD Level 0 & Level 1) for a problem.],
  [5],
  [2],
  [8],
  [Develop UML ER diagram for a problem.],
  [5],
  [2],
  [9],
  [Estimation of Test Coverage and structural complexity (McCabe's Cyclomatic Complexity).],
  [6],
  [2],
  [10],
  [Design and develop test suites for a given software module by applying various testing techniques.],
  [6],
  [2],
  [11],
  [Test the login, Registration (Sign Up), Sign-in functionality of an OAuth module.],
  [6],
  [2],
  [12],
  [Use the Blisk tool to test the layout and responsiveness of your website or personal project.],
  [6],
  [2],
  [13],
  [Generate a bug report of any given definition (IEEE 829 Standard).],
  [6],
  [4],
  [--],
  [*Total Laboratory Workload*],
  [*--*],
  [*30 Hrs*],
)

#v(1em)

#info-card(
  "Case Study: Enterprise Ride-Sharing Platform",
  "To maintain engineering rigor and contextual coherence across all design, structural, behavioral, architectural, and testing practicals, this manual consistently applies the realistic domain model of 'SwiftRide', a distributed ride-sharing portal supporting multi-vendor catalogs, active ride requests, OAuth 2.0 / OpenID Connect authentication, payment gateways, and warehouse logistics.",
  bride-color: rgb("#0284c7"),
)

#pagebreak()


// =============================================================================
// PRACTICAL 1: SDLC PHASES AND ACTIVITIES
// =============================================================================

#practical-header(
  "01",
  "Study of Software Development Life Cycle (SDLC) & Phase Activities",
  "1",
  "2",
)

== Aim
To study the complete Software Development Life Cycle (SDLC), analyze key engineering activities conducted in each phase, evaluate deliverables, and compare foundational SDLC process models.

== Theoretical Foundation
The Software Development Life Cycle (SDLC) is a structured framework that guides engineering teams through the systematic planning, design, creation, verification, and maintenance of high-quality software systems. Following an established SDLC minimizes risk, enhances software predictability, optimizes resource allocation, and ensures compliance with stakeholder requirements.

=== Core SDLC Phases & Phase-Wise Activities

1. *Requirement Gathering & Analysis:* Identification of business goals, stakeholder elicitation, domain analysis, and formalization into a Software Requirements Specification (SRS).
2. *Feasibility Study & Project Planning:* Evaluation of technical, operational, economic, schedule, and legal feasibility (TELOS framework). Creation of Gantt charts, risk registers, and resource allocation plans.
3. *System & Architectural Design:* Definition of high-level software architecture (HLD), low-level component designs (LLD), database schemas, UML behavioral/structural diagrams, and interface definitions.
4. *Implementation & Coding:* Translating design specifications into clean, modular, and maintainable source code using standard coding conventions, version control systems, and automated unit testing.
5. *Testing & Quality Assurance:* Execution of verification and validation activities including integration testing, system testing, security scanning, performance profiling, and acceptance testing.
6. *Deployment & Release:* Packaging, containerization (e.g., Docker/Kubernetes), automated CI/CD pipeline execution, environment configuration, staging verification, and production release.
7. *Operations & Maintenance:* Continuous monitoring, logging, corrective bug patches, adaptive environment upgrades, perfective performance refactoring, and preventive maintenance.

#v(0.5em)

#figure(
  image("assets/sdlc_phases_lifecycle.svg", width: 95%),
  caption: [Systematic SDLC Lifecycle Workflow, Phase Transitions, and Key Deliverables.],
)

#v(0.5em)

=== SDLC Process Models Comparison

#custom-table(
  (1fr, 1.2fr, 1.2fr, 1.2fr),
  [*SDLC Model*],
  [*Key Strengths*],
  [*Limitations / Weaknesses*],
  [*Ideal Project Domain*],
  [*Waterfall*],
  [Simple, linear, rigid stage gates; clear milestones.],
  [Inflexible to requirement shifts; testing occurs late.],
  [Stable, well-understood defense/aerospace projects.],
  [*V-Model*],
  [Verification paired with early validation at each stage.],
  [Rigid linear structure; expensive to accommodate changes.],
  [Safety-critical medical, automotive, and avionics systems.],
  [*Iterative / Incremental*],
  [Delivers working increments early; iterative refinement.],
  [Requires strong architecture planning upfront.],
  [Large enterprise applications with phased releases.],
  [*Spiral Model*],
  [Heavy risk assessment and prototyping per loop.],
  [High management overhead; requires risk assessment expertise.],
  [High-risk, mission-critical, large-budget projects.],
  [*Agile (Scrum / Kanban)*],
  [High rider collaboration, adaptive sprints, rapid feedback.],
  [Less focus on comprehensive documentation; scope creep risk.],
  [Dynamic consumer web/mobile SaaS platforms (e.g., SwiftRide).],
)

== Conclusion
The study systematically analyzed all seven core phases of the SDLC. The trade-offs among Waterfall, V-Model, Spiral, and Agile methodologies demonstrate that selecting the optimal process model depends directly on requirement volatility, safety criticality, project timeline, and team velocity.

#pagebreak()


// =============================================================================
// PRACTICAL 2: REQUIREMENTS SPECIFICATION (SRS)
// =============================================================================

#practical-header(
  "02",
  "Development of Software Requirements Specification (SRS)",
  "4",
  "4",
)

== Aim
To develop a formal Software Requirements Specification (SRS) for the *SwiftRide Enterprise Ride-Sharing Platform* conforming to the international *IEEE Std 830-1998* standard.

== Problem Statement
The client requires a modern, highly available digital ride-sharing web platform ("SwiftRide") allowing registered riders to request rides with different vehicle types, maintain persistent active ride requests, execute secure fare payments, and track driver locations live, while providing administrative oversight over fleets and drivers.

== IEEE 830 Architecture & Requirements Decomposition

#v(0.4em)

#figure(
  image("assets/srs_hierarchy_breakdown.svg", width: 95%),
  caption: [Hierarchical Requirements Decomposition Model for SwiftRide according to IEEE Std 830.],
)

#v(0.4em)

=== Functional Requirements (FR) Specification

#custom-table(
  (0.8fr, 1.4fr, 2.2fr),
  [*Req ID*],
  [*Function Name*],
  [*Technical Requirement Description*],
  [*FR-01*],
  [User Authentication],
  [The system shall support OAuth 2.0 / OpenID Connect SSO and traditional email/password registration with Argon2id password hashing and mandatory email OTP verification.],
  [*FR-02*],
  [Driver Matching & ETA],
  [The system shall provide geospatial indexing and driver filtering by vehicle type, ETA, and driver ratings with sub-100ms query latency.],
  [*FR-03*],
  [Ride Booking & Session State],
  [The system shall maintain active ride request state across browser sessions for authenticated users with atomic driver assignment lock upon booking.],
  [*FR-04*],
  [Payment Gateway Integration],
  [The system shall support PCI-DSS compliant credit/debit card processing, UPI intents, and webhook receipt confirmation.],
  [*FR-05*],
  [Trip & Tracking Pipeline],
  [The system shall generate digitally signed invoices (PDF) and emit real-time webhook updates to mapping and routing APIs.],
  [*FR-06*],
  [Admin Fleet Management],
  [The system shall allow authorized administrators to create, update, deactivate Vehicles, and dynamically update active driver statuses.],
)

=== Non-Functional Requirements (NFR) Specification

1. *Performance & Latency (NFR-01):* 95% of driver search and page render requests shall return within $t <= 200 "ms"$ under nominal concurrency of 10,000 active users.
2. *Security & Data Privacy (NFR-02):* All transport data must be encrypted with TLS 1.3. User passwords and tokens must be encrypted at rest using AES-256 and Argon2id. Compliance with GDPR and Indian DPDP regulations is mandatory.
3. *High Availability & Fault Tolerance (NFR-03):* The system shall achieve an uptime of $>= 99.95\%$ with automated multi-zone failover and maximum Mean Time to Recovery ($"MTTR" <= 5 "minutes"$).
4. *Scalability (NFR-04):* Horizontal container autoscaling must dynamically handle traffic surges up to 50,000 requests per second during peak festive sale events.

== Conclusion
A complete, structured SRS document was formulated according to IEEE Std 830-1998 guidelines. Clear separation of functional, non-functional, and interface requirements establishes an unambiguous contract between engineering stakeholders and clients.

#pagebreak()


// =============================================================================
// PRACTICAL 3: UML USE CASE DIAGRAM
// =============================================================================

#practical-header(
  "03",
  "Development of UML Use Case Diagram",
  "5",
  "2",
)

== Aim
To capture the functional requirements and external actor interactions of the *SwiftRide Ride-Sharing Platform* using UML Use Case modeling techniques.

== Theoretical Principles
UML Use Case diagrams specify the system boundary, external actors (human users or secondary automated systems), and use cases (discrete units of meaningful work). Key relationships include:
- *Association:* Solid lines indicating bidirectional communication between an actor and a use case.
- *`<<include>>`:* Mandatory subordinate behavior where the base use case explicitly invokes the included use case.
- *`<<extend>>`:* Optional or conditional behavior executed only when specific extension points/guard conditions are satisfied.

#v(0.4em)

#figure(
  image("assets/use_case_diagram.svg", width: 95%),
  caption: [UML Use Case Diagram showing Actors, System Boundary, and Stereotype Relationships.],
)

#v(0.4em)

=== Detailed Use Case Specification Table: Place Ride

#custom-table(
  (1.2fr, 2.8fr),
  [*Attribute*],
  [*Specification Details*],
  [*Use Case Name*],
  [Confirm & Book Ride (UC-04)],
  [*Primary Actor*],
  [Registered Rider],
  [*Secondary Actors*],
  [Payment Gateway, Dispatch Service, Notification Daemon],
  [*Preconditions*],
  [Rider is authenticated; rider has selected a valid pickup and drop-off location.],
  [*Main Success Scenario*],
  [
    1. Rider navigates to booking and confirms pickup/drop-off locations. \ 2. System calculates base fare, taxes, surge fee, and applies active promotions. \ 3. System invokes `Process Payment` (`<<include>>`). \ 4. Rider completes 3D-Secure authentication (`<<include>>`). \ 5. Gateway emits success webhook; System creates immutable Ride entity. \ 6. Ride receipt dispatched via email.
  ],
  [*Alternate Flows*],
  [3a. Rider enters promo code -> Invokes `Apply Promo Code` (`<<extend>>`). \ 4a. Card declined -> System alerts rider, retains ride parameters, and prompts alternative payment.],
  [*Postconditions*],
  [Inventory stock decremented; ride state set to `CONFIRMED`; transaction log recorded.],
)

== Conclusion
The UML Use Case diagram accurately mapped system functional scope, external actor boundaries, and core business relationships (`<<include>>` for mandatory payment/OTP workflows and `<<extend>>` for promotional fare logic).

#pagebreak()


// =============================================================================
// PRACTICAL 4: UML ACTIVITY & SWIMLANE DIAGRAM
// =============================================================================

#practical-header(
  "04",
  "Development of UML Activity & Swimlane Diagram",
  "5",
  "2",
)

== Aim
To model the dynamic operational workflow, decision logic, and concurrent processes of the *Ride Fulfillment Pipeline* using a 4-partition UML Activity and Swimlane diagram.

== Theoretical Principles
Activity diagrams represent procedural control flow, business logic, branching decisions, and concurrent execution. *Swimlanes (Partitions)* partition activity nodes based on organizational or architectural responsibility (e.g., UI layer, Backend services, 3rd-party Gateways, Driver systems).
- *Decision / Merge Nodes:* Diamond symbols evaluating Boolean conditions.
- *Fork & Join Bars:* Solid horizontal/vertical bars modeling parallel asynchronous threads and their eventual synchronization.

#v(0.4em)

#figure(
  image("assets/activity_swimlane_diagram.svg", width: 95%),
  caption: [UML Activity & Swimlane Diagram with 4 Architectural Partitions, Decision Diamonds, and Fork/Join Concurrency.],
)

#v(0.4em)

=== Operational Workflow Breakdown

1. *Rider Partition:* Initiates ride request from fare review; receives feedback for no-drivers-available alerts or payment failures.
2. *Ride Processing Service:* Performs driver availability validation. If drivers available, executes an atomic driver assignment lock and dispatches authorization requests to the Payment Gateway.
3. *Payment Gateway Partition:* Authenticates payment tokens with the banking network. Upon successful debit, signals back to the Ride Service.
4. *Concurrent Fork Processing:*
  - *Thread A (Ride Service):* Generates cryptographic invoice PDF and triggers SMTP mailer.
  - *Thread B (Driver Partition):* Receives automated packing slip, picks Vehicles from warehouse bins, packages items, and attaches shipping labels.
5. *Join Synchronization:* Both threads converge at the Join Bar before the ride status transitions to `ON_TRIP`.

== Conclusion
The 4-partition UML Swimlane diagram effectively captured operational control flow, error fallback paths (no-drivers-available and payment declined), and parallel background tasks using Fork/Join constructs.

#pagebreak()


// =============================================================================
// PRACTICAL 5: UML CLASS DIAGRAM
// =============================================================================

#practical-header(
  "05",
  "Development of UML Class Diagram",
  "5",
  "2",
)

== Aim
To model the static object-oriented domain architecture of the *SwiftRide Platform* using UML Class diagram notation.

== Theoretical Principles
A UML Class Diagram depicts domain classes, attributes with visibility indicators (`+` public, `-` private, `#` protected), operations with typed signatures, and object relationships:
- *Inheritance / Generalization:* Open hollow triangle indicating subclassing.
- *Composition (Black Diamond):* Strong lifecycle dependency (the part ceases to exist if the whole is destroyed).
- *Aggregation (White Diamond):* Weak reference association where parts have independent lifecycles.
- *Multiplicities:* Explicit cardinality constraints ($1$, $0..1$, $1..*$, $0..*$).

#v(0.4em)

#figure(
  image("assets/class_diagram.svg", width: 95%),
  caption: [UML Class Diagram showing Domain Entities, Generalization, Composition, and Multiplicities.],
)

#v(0.4em)

=== Class Specifications & OOP Architecture

#custom-table(
  (1fr, 1fr, 2fr),
  [*Class Name*],
  [*Relationship*],
  [*Key Responsibility & Methods*],
  [`User` (Abstract)],
  [Base Class],
  [Encapsulates `#userId`, `#email`, `#passwordHash`; defines `login()` and `logout()`.],
  [`Rider`],
  [Inherits `User`],
  [Manages saved locations, loyalty points; `bookRide()`, `confirmRide()`.],
  [`Administrator`],
  [Inherits `User`],
  [Manages administrative privileges; `addVehicle()`, `updateStock()`.],
  [`RideSession`],
  [Assoc `Rider`],
  [Manages active rider session items; `addStop()`, `cancelRide()`.],
  [`RideStop`],
  [Comp `RideSession`],
  [Represents route waypoints and segment distance calculations.],
  [`Ride`],
  [Assoc `Rider`],
  [Immutable transaction record; composes `RideSegment` ($1..*$), associates `Payment` ($1$).],
  [`Vehicle`],
  [Agg in `RideSegment`],
  [Vehicle entity with base fare, current location, and vehicle type association.],
  [`Payment` (Abstract)],
  [Assoc `Ride`],
  [Base payment contract; extended by `CreditCardPayment` and `UPIPayment`.],
)

== Conclusion
The static domain structure of SwiftRide was designed using strict object-oriented UML conventions, maintaining encapsulation, clean polymorphism, and accurate lifecycle composition rules.

#pagebreak()


// =============================================================================
// PRACTICAL 6: UML SEQUENCE DIAGRAM
// =============================================================================

#practical-header(
  "06",
  "Development of UML Sequence Diagram",
  "5",
  "2",
)

== Aim
To design a dynamic behavioral model representing chronological message exchanges and object interactions for the *Booking and Payment Workflow* using UML Sequence Diagrams.

== Theoretical Principles
Sequence diagrams capture time-rideed message flows between system lifelines:
- *Lifeline:* Vertical dashed line representing an object instance over time.
- *Activation Box:* Vertical rectangle indicating active execution of a method.
- *Synchronous Call:* Solid line with filled arrow head (`->`).
- *Return Message:* Dashed line with open arrow head (`-->`).
- *Combined Fragments (`alt`):* Enclosed interaction frame modeling conditional branching (e.g., success vs. payment failure).

#v(0.4em)

#figure(
  image("assets/sequence_diagram.svg", width: 95%),
  caption: [UML Sequence Diagram featuring 6 Lifelines, Method Invocations, and Combined 'alt' Branching Fragment.],
)

#v(0.4em)

=== Chronological Message Trace Analysis

1. `Rider` executes `bookRide(session)` on `RiderAppUI`.
2. `RiderAppUI` calls synchronous API endpoint `confirmRide(session, payMethod)` on `RideService`.
3. `RideService` queries `DispatchService.assignDriver(location)` to prevent concurrent overselling.
4. `DispatchService` replies with temporary `driverAssignment: 'DRV-980'`.
5. `RideService` invokes `authorizeAndCharge(amt, card)` on external `PaymentGateway`.
6. *Combined Fragment `alt`:*
  - *Condition `[SUCCESS]` (Nominal Flow):* Payment gateway confirms debit; `RideService` triggers `sendEmailReceipt()` on `NotificationService` and returns `rideSuccess(rideId)` to the user.
  - *Condition `[FAILED]` (Exception Flow):* Payment gateway returns decline reason; `RideService` executes rollback `releaseDriver(assignmentId)` on `DispatchService` and displays error banner on the UI.

== Conclusion
The sequence diagram provided a dynamic representation of asynchronous and synchronous messaging, lifeline lifecycles, and transaction compensation rollback upon gateway exceptions.

#pagebreak()


// =============================================================================
// PRACTICAL 7: DATA FLOW DIAGRAM (DFD LEVEL 0 & LEVEL 1)
// =============================================================================

#practical-header(
  "07",
  "Development of Data Flow Diagrams (DFD Level 0 & Level 1)",
  "5",
  "2",
)

== Aim
To model data flow, transformational processes, external boundaries, and persistent data stores using Level-0 (Context Diagram) and Level-1 DFD diagrams.

== Theoretical Principles
Data Flow Diagrams (DFDs) map the functional pipeline through which data enters, gets processed, stored, and retrieved without detailing internal software algorithmic control logic.
- *External Entity (Terminator):* Source or sink of information outside system boundary.
- *Process:* Bubble or circle that transforms incoming data flows into outgoing data flows.
- *Data Store:* Open-ended parallel lines representing persistent databases or file stores.
- *Data Flow:* Labeled directed vector indicating information movement.

#v(0.4em)

#figure(
  image("assets/dfd_level0_level1.svg", width: 95%),
  caption: [Hierarchical Data Flow Diagrams: Level 0 Context Overview and Level 1 Functional Process Decomposition.],
)

#v(0.4em)

=== DFD Level 1 Data Dictionary

#custom-table(
  (1.2fr, 1fr, 1.8fr),
  [*Data Flow Identifier*],
  [*Source / Target*],
  [*Data Structure Payload Content*],
  [`user_credentials`],
  [Rider $->$ 1.0],
  [`{ email: string, password_hash: string, auth_type: 'SSO'|'PWD' }`],
  [`driver_search`],
  [Rider $->$ 2.0],
  [`{ search_term: string, vehicle_type: string, max_eta, max_surge }`],
  [`ride_payload`],
  [Rider $->$ 3.0],
  [`{ user_id: UUID, stops: [{lat, lng}], drop_address: string }`],
  [`payment_intent`],
  [3.0 $->$ 4.0],
  [`{ ride_id: UUID, amount: decimal, currency: 'INR', method: string }`],
  [`fleet_delta`],
  [Admin $->$ 5.0],
  [`{ vehicle_id: UUID, license_plate: string, status: string }`],
  [`D1: User Store`],
  [1.0 Store],
  [Persistent user credentials, RBAC profiles, active session tokens.],
  [`D3: Ride Store`],
  [3.0 Store],
  [Historical ride snapshots, transaction references, segment distance charges.],
)

== Conclusion
Level-0 and Level-1 DFD models established the data transformations and persistent storage flows across all core subsystems, verifying data conservation across boundaries.

#pagebreak()


// =============================================================================
// PRACTICAL 8: UML ENTITY-RELATIONSHIP (ER) DIAGRAM
// =============================================================================

#practical-header(
  "08",
  "Development of Entity-Relationship (ER) Relational Schema",
  "5",
  "2",
)

== Aim
To design a conceptual and logical Entity-Relationship (ER) database schema modeling domain entities, primary/foreign keys, and relational cardinalities for the SwiftRide platform.

== Theoretical Principles
Entity-Relationship modeling organizes persistent relational data structures. Entities are defined with typed attributes, explicit Primary Keys ($"PK"$), Foreign Keys ($"FK"$), and Cardinality ratios ($1:1$, $1:N$, $M:N$). Complex $M:N$ relationships are resolved into associative tables (e.g., `RIDE_SEGMENT` resolving the $M:N$ between `RIDES` and `VEHICLE`).

#v(0.4em)

#figure(
  image("assets/er_diagram.svg", width: 95%),
  caption: [Entity-Relationship Relational Database Schema with Primary/Foreign Keys and Cardinality Mappings.],
)

#v(0.4em)

=== Relational Schema Normalization Mapping

```sql
-- 1. Base User Table (1NF / 2NF / 3NF Compliant)
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('CUSTOMER', 'ADMIN')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Rides Entity (Resolves 1:N from Rider)
CREATE TABLE rides (
    ride_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    rider_id UUID NOT NULL REFERENCES users(user_id) ON DELETE RESTRICT,
    ride_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    total_fare DECIMAL(10, 2) NOT NULL CHECK (total_fare >= 0),
    ride_status VARCHAR(30) NOT NULL DEFAULT 'PENDING'
);

-- 3. Ride Items Associative Table (Resolves M:N Ride-Vehicle Relationship)
CREATE TABLE ride_segments (
    segment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ride_id UUID NOT NULL REFERENCES rides(ride_id) ON DELETE CASCADE,
    vehicle_id UUID NOT NULL REFERENCES vehicles(vehicle_id) ON DELETE RESTRICT,
    distance_km INT NOT NULL CHECK (distance_km > 0),
    fare_per_km DECIMAL(10, 2) NOT NULL CHECK (fare_per_km >= 0)
);
```

== Conclusion
The ER schema was structured to 3rd Normal Form (3NF), eliminating transitive and partial dependencies, enforcing referential integrity via foreign key constraints, and optimizing associative entities.

#pagebreak()


// =============================================================================
// PRACTICAL 9: TEST COVERAGE & STRUCTURAL COMPLEXITY
// =============================================================================

#practical-header(
  "09",
  "Estimation of Test Coverage & McCabe's Cyclomatic Complexity",
  "6",
  "2",
)

== Aim
To construct the Control Flow Graph (CFG) for a core business module, compute McCabe's Cyclomatic Complexity $V(G)$, derive the linearly independent Basis Path Set, and estimate structural test coverage.

== Target Source Code Module: `calculateFare`

```python
def calculateFare(userType: str, distanceKm: float, hasPromo: bool) -> float:
    # Statement 1 (Node 1: Predicate 1)
    surgeMultiplier = 0.0
    if userType == "PREMIUM":
        # Statement 2 (Node 2)
        surgeMultiplier = 0.20
    # Statement 3 (Node 3: Predicate 2)
    if distanceKm > 1000.0:
        # Statement 4 (Node 4)
        surgeMultiplier += 0.05
    # Statement 5 (Node 5: Predicate 3)
    if hasPromo:
        # Statement 6 (Node 6)
        surgeMultiplier += 0.10
    # Statement 7 (Node 7: Confluence)
    netTotal = distanceKm * (1.0 - surgeMultiplier)
    # Statement 8 (Node 8: Exit)
    return netFare
```

#v(0.4em)

#figure(
  image("assets/cfg_cyclomatic_complexity.svg", width: 95%),
  caption: [Control Flow Graph (CFG) with Nodes, Branch Edges, Predicate Decision Points, and Bounded Regions.],
)

#v(0.4em)

=== Mathematical Complexity Formulations

1. *Formula 1 (Edges & Nodes):*
  $ V(G) = E - N + 2P $
  Given $E = 10$ directed edges, $N = 8$ statement nodes, and $P = 1$ connected graph component:
  $ V(G) = 10 - 8 + 2(1) = 4 $

2. *Formula 2 (Predicate Decision Nodes):*
  $ V(G) = P_n + 1 $
  Given $P_n = 3$ binary decision nodes (Nodes 1, 3, and 5):
  $ V(G) = 3 + 1 = 4 $

3. *Formula 3 (Enclosed Bounded Regions):*
  $ V(G) = R_1 + R_2 + R_3 + R_4 = 4 $

=== Basis Path Testing Suite (100% Structural Coverage)

#custom-table(
  (0.8fr, 1.6fr, 1.6fr),
  [*Path ID*],
  [*Node Sequence Traversal*],
  [*Test Case Input Vector $(u, c, h)$*],
  [*Path 1*],
  [$1 -> 3 -> 5 -> 7 -> 8$],
  [`("REGULAR", 500.0, False)` $->$ Fare Multiplier = 0%],
  [*Path 2*],
  [$1 -> 2 -> 3 -> 5 -> 7 -> 8$],
  [`("PREMIUM", 500.0, False)` $->$ Fare Multiplier = 20%],
  [*Path 3*],
  [$1 -> 3 -> 4 -> 5 -> 7 -> 8$],
  [`("REGULAR", 1500.0, False)` $->$ Fare Multiplier = 5%],
  [*Path 4*],
  [$1 -> 3 -> 5 -> 6 -> 7 -> 8$],
  [`("REGULAR", 500.0, True)` $->$ Fare Multiplier = 10%],
)

== Conclusion
McCabe's Cyclomatic Complexity was calculated as $V(G) = 4$. Executing the four linearly independent basis paths guarantees 100% statement and 100% branch/decision structural test coverage.

#pagebreak()


// =============================================================================
// PRACTICAL 10: TEST SUITE DESIGN TECHNIQUES
// =============================================================================

#practical-header(
  "10",
  "Design & Development of Test Suites via Testing Techniques",
  "6",
  "2",
)

== Aim
To design, implement, and execute comprehensive test suites for a user registration and ride validation module using *Equivalence Class Partitioning (ECP)*, *Boundary Value Analysis (BVA)*, and *Decision Table Testing*.

== Testing Methodologies Overview

#v(0.4em)

#figure(
  image("assets/test_design_matrix.svg", width: 95%),
  caption: [Black-Box Input Partitioning (ECP/BVA) and White-Box Structural Coverage Hierarchy.],
)

#v(0.4em)

=== Module Under Test Specification
*Input:* `userAge` (Allowed valid integer: $[18, 65]$), `passwordLength` (Allowed valid range: $[8, 32]$).

=== Boundary Value Analysis (BVA) Test Matrix

#custom-table(
  (0.7fr, 1.2fr, 1.2fr, 0.9fr),
  [*TC ID*],
  [*Test Input Parameter*],
  [*Expected Output / Behavior*],
  [*Status*],
  [*TC-B01*],
  [`userAge = 17` (Min - 1)],
  [Validation Error: 'Age below minimum threshold (18)'],
  [PASS],
  [*TC-B02*],
  [`userAge = 18` (Min boundary)],
  [Success: Accepted as valid adult age],
  [PASS],
  [*TC-B03*],
  [`userAge = 19` (Min + 1)],
  [Success: Accepted as valid age],
  [PASS],
  [*TC-B04*],
  [`userAge = 40` (Nominal value)],
  [Success: Accepted as valid age],
  [PASS],
  [*TC-B05*],
  [`userAge = 64` (Max - 1)],
  [Success: Accepted as valid age],
  [PASS],
  [*TC-B06*],
  [`userAge = 65` (Max boundary)],
  [Success: Accepted as valid retirement age limit],
  [PASS],
  [*TC-B07*],
  [`userAge = 66` (Max + 1)],
  [Validation Error: 'Age exceeds allowed upper limit (65)'],
  [PASS],
)

=== Decision Table Testing (Coupon & Discount Validation)

#custom-table(
  (1.4fr, 0.6fr, 0.6fr, 0.6fr, 0.6fr),
  [*Conditions / Rules*],
  [*R1*],
  [*R2*],
  [*R3*],
  [*R4*],
  [User is Authenticated?],
  [False],
  [True],
  [True],
  [True],
  [Ride Total $> \$100$?],
  [N/A],
  [False],
  [True],
  [True],
  [Promo Code is Valid?],
  [N/A],
  [True],
  [False],
  [True],
  [*Action: Waive Toll Fees*],
  [No],
  [No],
  [Yes],
  [Yes],
  [*Action: Apply 15% Promo*],
  [No],
  [No],
  [No],
  [Yes],
)

== Conclusion
Applying ECP eliminated redundant test execution while BVA detected boundary off-by-one errors. Decision table testing systematically covered all Boolean combinations of compound business conditions.

#pagebreak()


// =============================================================================
// PRACTICAL 11: OAUTH 2.0 MODULE TESTING
// =============================================================================

#practical-header(
  "11",
  "Testing OAuth 2.0 / OIDC Authentication Module",
  "6",
  "2",
)

== Aim
To execute systematic functional, security, and integration testing on the OAuth 2.0 / OpenID Connect (OIDC) Single Sign-On (SSO) module using Authorization Code Grant with PKCE.

== Theoretical Architecture & Security Checkpoints

#v(0.4em)

#figure(
  image("assets/oauth_flow_verification.svg", width: 95%),
  caption: [OAuth 2.0 Authorization Code Flow with PKCE, Token Exchange, and Security Verification Checkpoints.],
)

#v(0.4em)

=== Security Test Suite for OAuth 2.0 Module

#custom-table(
  (0.8fr, 1.4fr, 1.8fr),
  [*Test Case ID*],
  [*Security Vector Tested*],
  [*Verification Condition & Expected Outcome*],
  [*OAUTH-01*],
  [PKCE Verification],
  [Client submits invalid `code_verifier` during `/token` exchange; Auth Server must return `400 Bad Request: invalid_grant`.],
  [*OAUTH-02*],
  [Anti-CSRF `state` Parameter],
  [Callback request received with mismatched or empty `state` token; Application must reject callback and abort session creation.],
  [*OAUTH-03*],
  [JWT RS256 Signature Verification],
  [Access token signature tampered with; Resource server returns `401 Unauthorized: signature verification failed`.],
  [*OAUTH-04*],
  [Token Expiry (`exp` claim)],
  [Expired JWT submitted; System rejects access and triggers background token refresh via `refresh_token`.],
  [*OAUTH-05*],
  [Redirect URI Injection Defense],
  [Attacker requests authorization with unregistered `redirect_uri`; Provider must reject without emitting auth code.],
)

== Conclusion
The OAuth 2.0 module was validated against standard security vulnerabilities (CSRF token replay, authorization code interception, and JWT tampering), confirming robust compliance with RFC 7636 and OpenID Core specifications.

#pagebreak()


// =============================================================================
// PRACTICAL 12: BLISK RESPONSIVE TESTING
// =============================================================================

#practical-header(
  "12",
  "Multi-Device Responsive Web Testing with Blisk",
  "6",
  "2",
)

== Aim
To evaluate multi-device responsive layout consistency, CSS media query breakpoints, and touch/scroll synchronization for the SwiftRide portal using the *Blisk Cross-Device Browser Testing Tool*.

== Blisk Architecture & Testing Methodology

#v(0.4em)

#figure(
  image("assets/blisk_responsive_testing.svg", width: 95%),
  caption: [Blisk Dual-Viewport Testing Workspace: Synchronized Mobile/Desktop Rendering and Breakpoint Analysis.],
)

#v(0.4em)

=== Responsive Device Testing Matrix

#custom-table(
  (1.2fr, 1fr, 1fr, 0.8fr),
  [*Device Emulated*],
  [*Viewport Dim.*],
  [*Key UI Transformation Verified*],
  [*Result*],
  [*iPhone 15 Pro*],
  [390 x 844 px],
  [Single-column grid, burger navigation drawer, touch targets $>= 48 "px"$.],
  [PASS],
  [*Samsung Galaxy S23*],
  [360 x 780 px],
  [Viewport meta scaling active, typography adapts without horizontal overflow.],
  [PASS],
  [*iPad Air (Portrait)*],
  [820 x 1180 px],
  [2-column grid layout, visible top quick-links, fluid image containers.],
  [PASS],
  [*MacBook Pro 14"*],
  [1512 x 982 px],
  [full-screen live map interface, persistent vehicle selection drawer.],
  [PASS],
  [*Desktop 4K Display*],
  [2560 x 1440 px],
  [Max-width container bounding at 1440px with balanced negative margins.],
  [PASS],
)

=== CSS Breakpoint Implementation Tested

```css
/* Core Responsive Breakpoints Verified in Blisk */
@media (max-width: 576px) {
  .vehicle-list { grid-template-columns: 1fr; }
  .desktop-nav { display: none; }
  .hamburger-menu { display: block; }
}
@media (min-width: 577px) and (max-width: 992px) {
  .vehicle-list { grid-template-columns: repeat(2, 1fr); }
}
@media (min-width: 993px) {
  .vehicle-list { grid-template-columns: repeat(3, 1fr); }
}
```

== Conclusion
Blisk dual-viewport emulation confirmed that responsive CSS media queries correctly reorganized layout components, maintained minimum touch-target dimensions, and prevented horizontal overflow across mobile, tablet, and desktop viewports.

#pagebreak()


// =============================================================================
// PRACTICAL 13: BUG REPORTING & DEFECT LIFECYCLE
// =============================================================================

#practical-header(
  "13",
  "Generation of Formal Bug Report (IEEE 829 Standard)",
  "6",
  "4",
)

== Aim
To analyze the Defect Lifecycle, establish triage classifications, and generate formal industry-standard Bug Reports conforming to the *IEEE 829 Standard for Software Test Documentation*.

== Defect Management Lifecycle & Triage Workflow

#v(0.4em)

#figure(
  image("assets/bug_lifecycle_states.svg", width: 95%),
  caption: [Defect Reporting & Resolution State Machine with Retest Loops and Severity/Priority Matrix.],
)

#v(0.4em)

=== Formal Bug Report 01: Critical Payment Timeout Defect

#custom-table(
  (1.2fr, 2.8fr),
  [*Defect ID*],
  [*BUG-SN-2026-0842*],
  [*Defect Title*],
  [Duplicate Card Charge on Payment Gateway HTTP 504 Gateway Timeout],
  [*Severity / Priority*],
  [*SEV-1: CRITICAL* #h(5pt) *PRI-1: IMMEDIATE*],
  [*Module / Environment*],
  [Ride Fare Payment Service / Vehicleion Staging v2.4.1 (Linux x86_64, Node v20)],
  [*Reported By / Date*],
  [Sandeep Prasad (QA Lead) / 2026-08-31],
  [*Assigned Developer*],
  [Lead Backend Engineer (Payments Team)],
  [*Preconditions*],
  [Authenticated rider with valid pickup/drop-off; high simulated network latency ($> 30 "s"$).],
  [*Steps to Reproduce*],
  [
    1. Select 'Premium SUV' and proceed to Book Ride. \ 2. Enter valid Credit Card test credentials. \ 3. Click 'Pay Now' and simulate network packet drop/latency on gateway API. \ 4. Client timeout triggers automatic browser retry after 30 seconds.
  ],
  [*Expected Result*],
  [Idempotency key prevents duplicate transaction; rider is charged exactly once.],
  [*Actual Result*],
  [First transaction completes at bank; timeout triggers retry which debits rider account a second time. Duplicate invoice emitted.],
  [*Root Cause Analysis*],
  [Missing `Idempotency-Key` HTTP header on outgoing payment gateway REST requests.],
  [*Suggested Fix*],
  [Inject UUIDv4 idempotency key per booking attempt; enforce 60-second atomic redis lock.],
)

=== Formal Bug Report 02: Responsive UI Layout Break

#custom-table(
  (1.2fr, 2.8fr),
  [*Defect ID*],
  [*BUG-SN-2026-0843*],
  [*Defect Title*],
  [Ride Summary Modal Truncation on Mobile Safari Viewport (375px)],
  [*Severity / Priority*],
  [*SEV-3: MINOR* #h(5pt) *PRI-3: LOW*],
  [*Environment*],
  [Mobile Safari iOS 17.5 / iPhone 13 (375 x 812 px)],
  [*Steps to Reproduce*],
  [1. Open booking screen on viewport width <= 375px. \ 2. Observe promo code input field and 'Apply' button.],
  [*Actual Result*],
  ['Apply' button wraps awkwardly below input, overlapping total amount label.],
  [*Expected Result*],
  [Flexbox container wraps gracefully or scales input width to 100% on small screens.],
)

== Conclusion
The defect lifecycle state machine was demonstrated from discovery through triage, remediation, re-testing, and closure. Standardized IEEE 829 defect reporting ensures actionable reproducibility and rapid root cause isolation.

#pagebreak()


// =============================================================================
// REFERENCES & BIBLIOGRAPHY
// =============================================================================

= References & Technical Standards

1. *IEEE Std 830-1998:* _IEEE Recommended Practice for Software Requirements Specifications_, IEEE Computer Society.
2. *IEEE Std 829-2008:* _IEEE Standard for Software and System Test Documentation_, IEEE Computer Society.
3. *Pressman, R. S., & Maxim, B. R. (2020):* _Software Engineering: A Practitioner's Approach_ (9th ed.), McGraw-Hill Education.
4. *Sommerville, I. (2016):* _Software Engineering_ (10th ed.), Pearson Education.
5. *McCabe, T. J. (1976):* "A Complexity Measure", _IEEE Transactions on Software Engineering_, Vol. SE-2, No. 4, pp. 308-320.
6. *Hardt, D. (2012):* _The OAuth 2.0 Authorization Framework_, RFC 6749, Internet Engineering Task Force (IETF).
7. *Object Management Group (OMG):* _Unified Modeling Language (OMG UML) Specification_, Version 2.5.1.

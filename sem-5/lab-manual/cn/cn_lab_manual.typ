#let meta-data = (
  name: "Jayesh Kumar",
  roll_no: "240905050047",
  degree: "B Tech CSE",
  subject: "Computer Networks",
  sub_code: "BETCE15501",
  section: "X1",
  semester: "Semester V",
  department: "Department of Computer Engineering",
  institute: "Gyanmanjari Innovative University",
  academic_year: "2026 - 2027",
)

// Document Styling
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.8cm, left: 1.85cm, right: 1.85cm),
  background: place(top + left, dx: 1.5cm, dy: 1.5cm)[
    #rect(
      width: 21cm - 3.0cm,
      height: 29.7cm - 3.0cm,
      stroke: 0.75pt + black,
    )
  ],
  header: context {
    if here().page() > 2 {
      v(0.3cm)
      set text(size: 10pt, font: ("Liberation Serif", "Times New Roman"))
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#meta-data.institute], [#meta-data.degree],
      )
    }
  },
  footer: context {
    if here().page() > 2 {
      set text(size: 10pt, font: ("Liberation Serif", "Times New Roman"))
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#meta-data.roll_no], [#meta-data.subject],
      )
      v(0.8cm)
    }
  },
)

#set text(
  font: ("Liberation Serif", "Times New Roman"),
  size: 11pt,
)

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.05em,
)

#show heading: it => block(
  inset: (top: 0.9em, bottom: 0.4em),
  text(weight: "bold", it),
)

#show heading.where(level: 1): it => block(
  width: 100%,
  inset: (bottom: 6pt, top: 1.2em),
  text(size: 15pt, weight: "bold", it.body),
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.8em, bottom: 0.3em),
  text(size: 12.5pt, weight: "bold", it.body),
)

#show heading.where(level: 3): it => block(
  inset: (top: 0.6em, bottom: 0.25em),
  text(size: 11pt, weight: "bold", it.body),
)

// Code block styling
#show raw.where(block: true): it => block(
  fill: rgb("#f8fafc"),
  inset: 9pt,
  radius: 4pt,
  width: 100%,
  stroke: 0.5pt + rgb("#cbd5e1"),
  text(font: ("JetBrainsMono NF", "DejaVu Sans Mono", "Liberation Mono"), size: 9pt, it),
)

#show raw.where(block: false): it => box(
  fill: rgb("#f1f5f9"),
  inset: (x: 4pt, y: 1pt),
  radius: 3pt,
  stroke: 0.3pt + rgb("#cbd5e1"),
  text(font: ("JetBrainsMono NF", "DejaVu Sans Mono", "Liberation Mono"), size: 9pt, it),
)

// UI Component Helpers
#let practical-header(num, title, unit: "-", hrs: "2") = [
  #let p-num = if type(num) == str and num.starts-with("0") { num.slice(1) } else { str(num) }
  #v(0.2em)
  #text(size: 13pt, weight: "bold")[Practical #p-num] \
  #v(0.2em)
  #text(size: 11pt)[#title]
  #v(0.4em)
  #line(length: 100%, stroke: 0.5pt + luma(220))
  #v(0.5em)
]

#let custom-table(columns, ..data) = table(
  columns: columns,
  stroke: 0.5pt + luma(120),
  fill: (col, row) => if row == 0 { rgb("#f1f5f9") } else { none },
  inset: 6pt,
  align: left + horizon,
  ..data
)


// =============================================================================
// COVER PAGE
// =============================================================================

#align(center)[
  #v(2.5em)
  #text(size: 16pt, weight: "bold")[#meta-data.institute] \
  #v(0.5em)
  #text(size: 13pt, weight: "semibold")[#meta-data.department]

  #v(4.5em)
  #text(size: 24pt, weight: "bold")[#upper(meta-data.subject)] \
  #v(1em)
  #text(size: 15pt, weight: "semibold")[LABORATORY MANUAL] \

  #v(35em)

  #align(center)[

    #grid(
      columns: (auto, auto),
      row-gutter: 11pt,
      column-gutter: 24pt,
      align: (right, left),
      [Student Name:], [#text(weight: "bold")[#meta-data.name]],
      [Enrollment No:], [#text()[#meta-data.roll_no]],
      [Semester / Division:], [#text()[#meta-data.semester / #meta-data.section]],
      [Department:], [#text()[#meta-data.department]],
      [Subject Name:], [#text()[#meta-data.subject]],
      [Subject Code:], [#text()[#meta-data.sub_code]],
    )
  ]
]
#pagebreak()


// =============================================================================
// PRACTICAL INDEX TABLE
// =============================================================================

= Index

#v(0.5em)

#custom-table(
  (.2fr, 3.2fr),
  [*Sr.*],
  [*Practical*],
  [1],
  [Implement different LAN topologies using Network Simulator.],
  [2],
  [Study about OSI model and TCP/IP model.],
  [3],
  [Study of different types of network cables and practically implement the cross-wired cable and straight through cable using clamping tool.],
  [4],
  [Study and Test Various Network devices available at Department/Institute (Repeater, Hub, Switch, Bridge, Router and Gateway).],
  [5],
  [Study about TCP and UDP Protocols.],
  [6],
  [Study of basic network commands and network configuration commands.],
  [7],
  [Determine whether following IPv4 addresses are valid or invalid, identify Class, Network ID, Host ID, or state invalidation reason.],
  [8],
  [Explore Wireshark network packet analyzer and interface anatomy.],
  [9],
  [Capturing network traffic using Wireshark.],
  [10],
  [Analyze basic protocols like ARP, HTTP, DNS and SMTP using Wireshark.],
)

#pagebreak()


// =============================================================================
// PRACTICAL 1: LAN TOPOLOGIES
// =============================================================================

#practical-header("01", "Implement Different LAN Topologies Using Network Simulator")

== Aim
To implement and study different Local Area Network (LAN) topologies using a Network Simulator (Cisco Packet Tracer).

== Knowledge Required
Fundamental understanding of network nodes, transmission media, and physical/logical network topologies.

== Software Required
- Cisco Packet Tracer

== Theoretical Foundation
*Network Topology* refers to the topological arrangement of various elements (links, nodes, peripherals) in a computer communication network. It defines how devices are interconnected physically (physical topology) and how data flows through the medium (logical topology).

The selection of network topology directly impacts communication performance, deployment cost, fault tolerance, scalability, and ease of maintenance.

=== Primary Network Topologies

1. *Bus Topology*
  - *Architecture:* All nodes and network peripherals are attached to a single continuous transmission medium (central cable called the backbone/bus). When terminated at exactly two distinct ends, it is known as a _Linear Bus Topology_.
  - *Data Transmission:* When a node transmits, the signal propagates across the entire wire. All stations receive the broadcast, but only the node whose MAC/IP matches the destination accepts the payload; other stations discard it. Only one station transmits at a time.
  - *Signal Reflection & Terminators:* When a signal reaches the physical end of an unterminated bus, reflection occurs (signal ringing), causing collision and disruption. *Terminators* (typically 50-ohm resistors) are attached at both ends to absorb electrical energy.
  - *Features:* Single communication channel, unidirectional or bidirectional broadcast, minimal cabling requirement.
  - *Advantages:* Highly cost-effective, easy to deploy for small-scale local setups, minimal initial infrastructure.
  - *Disadvantages:* Central cable breakage paralyzes the entire network; difficult fault localization; heavy traffic causes severe packet collisions and performance degradation.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/topologies/bus.png", width: 55%),
    caption: [Bus Topology Architecture with Terminators and Central Backbone Cable.],
  )
]
#v(0.3em)

2. *Star Topology*
  - *Architecture:* Every peripheral and host device is connected to a dedicated point-to-point physical link terminating at a central multiport controller (a Network Hub or Switch).
  - *Operating Mechanism:* The central hub/switch manages and routes all incoming traffic. In a switch-based star network, frames are directed exclusively to the destination port using MAC table lookup, eliminating unnecessary broadcast overhead.
  - *Features:* Dedicated link per node, central traffic relay point, compatible with UTP, STP, Coaxial, and Optical Fiber.
  - *Advantages:* Superior performance under load; easy to add or remove nodes without disrupting the rest of the network; isolated node failure does not affect other connected hosts; straightforward troubleshooting.
  - *Disadvantages:* Complete dependency on the central switch/hub (single point of failure); increased overall cable consumption compared to bus topology.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/topologies/star.png", width: 50%),
    caption: [Star Topology Layout with Central Interconnecting Switch/Hub.],
  )
]
#v(0.3em)

3. *Ring Topology*
  - *Architecture:* Each host is connected to exactly two adjacent neighbor nodes in a closed circular loop. Data circulates sequentially bit-by-bit from node to node in a designated direction.
  - *Token Passing Protocol:* Communication is governed by a special bit-pattern called a *Token*. A station captures the free token, appends destination address and data payload, and injects it into the ring. Each node receives, examines, and regenerates the signal. The receiving node copies the frame and tags an acknowledgment flag, and the originating node drains the frame from the ring.
  - *Dual Ring Variant:* Utilizes two concentric rings carrying traffic in opposite directions (e.g., FDDI). If the primary ring breaks, the secondary ring wraps around to preserve full connectivity.
  - *Features:* Deterministic medium access, sequential token passing, equal access opportunity for all nodes.
  - *Advantages:* Immune to collisions under heavy traffic; easily expanded over large distances with repeater regeneration.
  - *Disadvantages:* Single-point link failure disrupts the whole single ring; complex troubleshooting; adding or removing nodes disturbs active network operations.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/topologies/ring.png", width: 50%),
    caption: [Ring Topology Interconnection with Circular Data Propagation.],
  )
]
#v(0.3em)

4. *Tree Topology*
  - *Architecture:* Also known as _Hierarchical Topology_, this structure extends the star topology by arranging nodes in a parent-child branching hierarchy originating from a central root node. It requires at least three distinct hierarchical tiers.
  - *Operating Mechanism:* Secondary hubs/switches branch out from the primary root switch, connecting departmental or workgroup star clusters.
  - *Features:* Hierarchical tree branching, modular workgroup isolation, ideal for large enterprise/campus networks.
  - *Advantages:* Highly scalable; supports easy expansion of departmental sub-networks; localized fault isolation within branches.
  - *Disadvantages:* High cabling complexity and installation expenditure; if the root backbone switch fails, all descendant subtrees lose inter-branch connectivity.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/topologies/tree.png", width: 55%),
    caption: [Hierarchical Tree Topology with Root and Branching Distribution Switches.],
  )
]
#v(0.3em)

5. *Mesh Topology*
  - *Architecture:* Every device is interconnected with point-to-point dedicated links.
  - *Channel Formula:* For a network comprising $N$ host devices, a *Full Mesh* requires:
    $ "Total Physical Channels" = (N (N - 1)) / 2 $
    Each node requires $(N - 1)$ dedicated physical input/output (I/O) ports.
  - *Mesh Variants:*
    - *Full Mesh:* Every single node is directly linked to every other node in the network.
    - *Partial Mesh:* Highly critical nodes maintain full point-to-point links, while peripheral nodes connect to only two or three devices.
  - *Features:* Maximum path redundancy, multiple concurrent routes, extreme fault tolerance.
  - *Advantages:* Unmatched reliability; link failure does not impede communication as traffic dynamically reroutes; excellent security and privacy on dedicated lines.
  - *Disadvantages:* Prohibitive cabling cost; intensive hardware port requirements; difficult installation and physical cable management.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/topologies/mesh.png", width: 52%),
    caption: [Full Mesh Topology Architecture with Direct Redundant Interconnections.],
  )
]
#v(0.3em)

6. *Hybrid Topology*
  - *Architecture:* A combination of two or more distinct standard topologies (e.g., Star-Ring, Star-Bus, or Ring-Tree).
  - *Features:* Flexible integration of heterogeneous networks according to specific departmental demands.
  - *Advantages:* Highly adaptable, scalable, robust, and allows customized layout for diverse organizational units.
  - *Disadvantages:* Complex architectural design, sophisticated multi-protocol bridging equipment required, costly installation.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/topologies/hybrid.png", width: 55%),
    caption: [Hybrid Topology Integrating Star and Bus Network Segments.],
  )
]
#v(0.5em)

=== Comparative Analysis of Network Topologies

#custom-table(
  (1.1fr, 1.2fr, 1.2fr, 1.1fr, 1.4fr),
  [*Topology*],
  [*Cabling Cost*],
  [*Fault Tolerance*],
  [*Scalability*],
  [*Primary Application*],
  [*Bus*],
  [Very Low],
  [Very Poor],
  [Low],
  [Small lab / Legacy systems],
  [*Star*],
  [Moderate],
  [High (per node)],
  [Excellent],
  [Modern Enterprise LANs],
  [*Ring*],
  [Moderate],
  [Low (Single Ring)],
  [Moderate],
  [Token Ring, FDDI, MANs],
  [*Tree*],
  [High],
  [Moderate],
  [Very High],
  [Campus & Enterprise Backbones],
  [*Mesh*],
  [Extremely High],
  [Maximum],
  [Difficult],
  [Mission-critical Core WANs],
  [*Hybrid*],
  [High],
  [High],
  [Very High],
  [Multi-department Organizations],
)

== Conclusion
All six foundational network topologies were systematically analyzed and modeled. Star and Tree topologies offer optimal trade-offs between performance, scalability, and ease of management for modern LANs, whereas Full Mesh topology is reserved for mission-critical routing cores requiring zero downtime.

#pagebreak()


// =============================================================================
// PRACTICAL 2: OSI & TCP/IP MODELS
// =============================================================================

#practical-header("02", "Study of OSI Model and TCP/IP Model")

== Aim
To study the layered architectures of the *Open Systems Interconnection (OSI)* 7-layer reference model and the *TCP/IP* 4-layer Internet protocol suite, analyzing layer-wise functionalities, encapsulation, and comparative differences.

== Theoretical Foundation
Network communication relies on standardized layered architectures to divide complex end-to-end data transfer tasks into distinct, modular, and interoperable functional layers.

=== The OSI 7-Layer Reference Model
Developed by the International Organization for Standardization (ISO), the OSI model defines a conceptual 7-layer framework:

#v(0.4em)
#align(center)[
  #figure(
    image("assets/osi_tcpip/osi_layers.png", width: 55%),
    caption: [The 7-Layer Open Systems Interconnection (OSI) Reference Architecture.],
  )
]
#v(0.4em)

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 14pt,
  [
    ==== 7. Application Layer
    - Directly interfaces with user applications and network services.
    - Manages protocols for data manipulation, web transfer, email, and name lookup.
    - *Protocols:* HTTP, HTTPS, SMTP, FTP, DNS, Telnet, SNMP.
  ],
  [
    #align(center)[#image("assets/osi_tcpip/layer_app.png", width: 85%)]
  ],
)

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 14pt,
  [
    ==== 6. Presentation Layer
    - Prepares data into standardized syntaxes for the Application Layer.
    - *Translation:* Character encoding conversion (e.g., ASCII, EBCDIC, Unicode).
    - *Encryption/Decryption:* Cryptographic security (SSL/TLS).
    - *Compression:* Payload size reduction.
  ],
  [
    #align(center)[#image("assets/osi_tcpip/layer_pres.png", width: 85%)]
  ],
)

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 14pt,
  [
    ==== 5. Session Layer
    - Establishes, manages, synchronizes, and terminates dialog sessions between hosts.
    - Inserts synchronization *checkpoints* into data streams to allow recovery from mid-transmission interruptions without restarting from scratch.
  ],
  [
    #align(center)[#image("assets/osi_tcpip/layer_sess.png", width: 85%)]
  ],
)

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 14pt,
  [
    ==== 4. Transport Layer
    - Ensures end-to-end process-to-process delivery of messages.
    - *Segmentation & Reassembly:* Slices data into manageable segments with sequence numbers.
    - *Flow & Error Control:* Adjusts transfer rates and executes retransmission upon checksum failure.
    - *Protocols:* TCP (reliable, connection-oriented) and UDP (fast, connectionless).
  ],
  [
    #align(center)[#image("assets/osi_tcpip/layer_trans.png", width: 85%)]
  ],
)

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 14pt,
  [
    ==== 3. Network Layer
    - Responsible for host-to-host packet delivery across heterogeneous networks.
    - *Logical Addressing:* IP address assignment.
    - *Routing:* Path determination using algorithms (OSPF, BGP, RIP).
    - *Protocols:* IPv4, IPv6, ICMP, IGMP, IPsec.
  ],
  [
    #align(center)[#image("assets/osi_tcpip/layer_net.png", width: 85%)]
  ],
)

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 14pt,
  [
    ==== 2. Data Link Layer
    - Ensures node-to-node error-free frame delivery over the physical link.
    - *Framing:* Encapsulates network packets with header (MAC addresses) and trailer (CRC/FCS).
    - *Media Access Control (MAC):* Manages shared channel access (CSMA/CD).
  ],
  [
    #align(center)[#image("assets/osi_tcpip/layer_datalink.png", width: 85%)]
  ],
)

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 14pt,
  [
    ==== 1. Physical Layer
    - Transmits raw, unstructured bit streams ($1$s and $0$s) across the physical transmission medium.
    - Defines electrical, optical, radio, connector pinouts, bit rates, and voltage modulation specifications.
    - *Equipment:* Cables (UTP, Fiber), Hubs, Repeaters, NICs.
  ],
  [
    #align(center)[#image("assets/osi_tcpip/layer_phys.png", width: 85%)]
  ],
)

#v(0.6em)

=== The TCP/IP 4-Layer Protocol Suite
Designed by DARPA, the TCP/IP model serves as the operational architecture of the global Internet:

#v(0.4em)
#align(center)[
  #figure(
    image("assets/osi_tcpip/tcpip_layers.png", width: 55%),
    caption: [TCP/IP 4-Layer Architectural Hierarchy.],
  )
]
#v(0.4em)

1. *Application Layer:* Combines OSI Layers 5, 6, and 7. Houses application protocols (HTTP, SMTP, DNS, SSH, FTP).
2. *Transport Layer:* Corresponds directly to OSI Layer 4. Manages host-to-host delivery via TCP (reliable transmission) or UDP (low-latency datagrams).
3. *Internet Layer:* Corresponds to OSI Layer 3. Handles packet routing and logical IP addressing (IP, ICMP, ARP).
4. *Network Access Layer (Link Layer):* Combines OSI Layers 1 and 2. Manages physical network hardware, MAC framing, and physical bit transport (Ethernet, 802.11 Wi-Fi, device drivers).

#v(0.5em)

=== Comparative Evaluation: OSI Model vs. TCP/IP Model

#custom-table(
  (1.2fr, 1.9fr, 1.9fr),
  [*Feature / Property*],
  [*OSI Reference Model*],
  [*TCP/IP Protocol Suite*],
  [*Number of Layers*],
  [7 distinct abstract layers],
  [4 functional operational layers],
  [*Development History*],
  [Theoretical standard developed by ISO],
  [Practical suite developed by DoD / DARPA],
  [*Approach*],
  [Top-down generic architectural reference],
  [Bottom-up protocol-driven implementation],
  [*Layer Consolidation*],
  [Separate Session, Presentation, Application],
  [Single unified Application Layer],
  [*Network Layer Service*],
  [Supports connectionless & connection-oriented],
  [Strictly connectionless (IP)],
  [*Protocol Independence*],
  [Strict separation of protocols & interfaces],
  [Protocols tightly fit the layered stack],
  [*Practical Usage*],
  [Primary model for teaching & diagnostics],
  [The operational standard of the Internet],
)

== Conclusion
The OSI model provides an invaluable conceptual and diagnostic framework for isolating network issues, while the TCP/IP suite represents the robust, streamlined standard governing global Internet data transmission.

#pagebreak()
// =============================================================================
// PRACTICAL 3: NETWORK CABLES & CLAMPING TOOL
// =============================================================================

#practical-header("03", "Study of Network Cables & Cable Clamping (Crimping)")

== Aim
To study different types of network communication cables and practically implement, fabricate, terminate, and verify *Straight-Through* and *Cross-Wired (Crossover)* Ethernet patch cables using an RJ-45 clamping tool and digital LAN continuity tester.

== Apparatus & Hardware Tools
To perform Ethernet cable fabrication, termination, and verification, the following hardware components and tools are utilized:

- *Unshielded Twisted Pair (UTP) Cable:* Category 5e / Category 6 four-pair (8-conductor) solid/stranded copper cable.
- *RJ-45 Modular Connectors (8P8C):* High-impact clear polycarbonate modular plugs with eight gold-plated phosphor bronze contact blades.
- *Professional Modular Crimping Tool:* Ratchet-type crimper equipped with dedicated 8P8C crimping cavity, integrated cable jacket stripper, and flat wire cutting blades.
- *Digital LAN Cable Continuity Tester:* Microprocessor-controlled Master and Remote diagnostic units with 1-to-8 LED status indicators.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/cabling/step_apparatus_tools.jpg", width: 75%),
    caption: [Hardware Apparatus and Tools Required for UTP Cable Termination and Testing.],
  )
]
#v(0.3em)

== Theoretical Foundation

=== Network Communication Cable Categories
Network transmission media form the physical foundation (OSI Layer 1) of all data communication networks:

1. *Twisted Pair Cable:* Consists of color-coded insulated copper conductors twisted together in pairs. Twisting causes external electromagnetic interference (EMI) and radio frequency interference (RFI) to induce equal and opposite voltages across the pair, cancelling noise via differential signaling.
  - *UTP (Unshielded Twisted Pair):* Standard, highly flexible, cost-effective; dominant media for 100BASE-TX (Fast Ethernet) and 1000BASE-T (Gigabit Ethernet) deployments.
  - *STP (Shielded Twisted Pair):* Wraps pairs in foil (F/UTP) or braided metallic shielding (S/FTP) for extreme noise immunity in industrial environments.
2. *Coaxial Cable:* Features a central solid copper core surrounded by a dielectric insulator, metallic braided shield, and protective outer PVC jacket. Historically used in 10BASE2 (Thinnet) and 10BASE5 (Thicknet) bus networks.
3. *Optical Fiber Cable:* Transmits digital information as modulated light pulses through ultra-pure silica glass or plastic cores. Characterized by extreme bandwidth, zero EMI susceptibility, and long-distance reach without repeaters.

=== RJ-45 Connector Architecture & Pin Orientation
An 8P8C (Eight Position, Eight Contact) modular plug houses eight parallel guide channels. When holding the connector with the *gold contact pins facing upward / toward you* and the *plastic locking tab facing downward / away from you*, the pins are numbered sequentially from *Pin 1 on the far left* to *Pin 8 on the far right*.

=== Color Coding Standards (EIA/TIA 568A & EIA/TIA 568B)
The Telecommunications Industry Association defines two standardized pinout configurations for 8-conductor UTP cabling:

#custom-table(
  (0.6fr, 1.7fr, 1.7fr, 1.4fr),
  [*Pin No.*],
  [*T-568A Standard Wiring*],
  [*T-568B Standard Wiring*],
  [*Signal Function (10/100Base-T)*],
  [Pin 1],
  [White / Green],
  [White / Orange],
  [Transmit Data + ($"TX+"$)],
  [Pin 2],
  [Green],
  [Orange],
  [Transmit Data - ($"TX-"$)],
  [Pin 3],
  [White / Orange],
  [White / Green],
  [Receive Data + ($"RX+"$)],
  [Pin 4],
  [Blue],
  [Blue],
  [Unused / PoE Voltage],
  [Pin 5],
  [White / Blue],
  [White / Blue],
  [Unused / PoE Voltage],
  [Pin 6],
  [Orange],
  [Green],
  [Receive Data - ($"RX-"$)],
  [Pin 7],
  [White / Brown],
  [White / Brown],
  [Unused / PoE Ground],
  [Pin 8],
  [Brown],
  [Brown],
  [Unused / PoE Ground],
)

#v(0.4em)
#align(center)[
  #figure(
    image("assets/cabling/t568a_t568b_diagram.svg", width: 95%),
    caption: [EIA/TIA T-568A and T-568B Color Coding Schemes and RJ-45 Pinout Alignment.],
  )
]
#v(0.4em)

=== Cable Wiring Topologies

- *Straight-Through Cable:*
  - *Wiring Configuration:* Both ends of the cable are terminated to the *exact same wiring standard* (typically End \#1: T-568B and End \#2: T-568B).
  - *Device Application:* Connects *dissimilar network devices* operating at different OSI layers (e.g., Computer to Network Switch, Switch to Router).

- *Cross-Over Cable:*
  - *Wiring Configuration:* One end is wired to *T-568A* and the opposite end is wired to *T-568B*. This transposes Transmit ($"TX"$) pins 1 & 2 on End \#1 to Receive ($"RX"$) pins 3 & 6 on End \#2.
  - *Device Application:* Connects *similar network devices* operating at the same OSI layer without an intermediate switch (e.g., Computer to Computer, Switch to Switch, Router to Computer).

#v(0.3em)
#align(center)[
  #figure(
    image("assets/cabling/straight_vs_cross_wiring.svg", width: 95%),
    caption: [Straight-Through vs Cross-Over Pinout Transposition and Continuity Mapping.],
  )
]
#v(0.4em)

=== Step-by-Step Practical Cable Fabrication Procedure

1. *Step 1: Cable Jacket Stripping* \
  Insert the UTP cable into the stripping cavity of the modular crimping tool. Rotate the tool $360 degree$ once around the cable to score the outer PVC jacket approximately $1.5$ to $2$ inches ($3.5 - 5"cm"$) from the end. Carefully remove the stripped jacket section without nicking any inner copper wire insulation.

2. *Step 2: Exposing & Separating Twisted Pairs* \
  Firmly hold the base of the jacket to prevent untwisting inside the sheath. Separate the four color-coded twisted pairs (Orange, Green, Blue, Brown) into a fan shape.

3. *Step 3: Untwisting Conductors* \
  Untwist all four pairs completely down to the jacket boundary. Straighten each individual conductor to remove bends and kinks.

4. *Step 4: Aligning Wires to T-568B Standard* \
  Arrange the eight colored wires into the exact parallel sequence according to T-568B:
  *1:* White/Orange, *2:* Orange, *3:* White/Green, *4:* Blue, *5:* White/Blue, *6:* Green, *7:* White/Brown, *8:* Brown. Press the wires tightly flat between thumb and index finger into a neat ribbon.

5. *Step 5: Trimming & Inserting into RJ-45 Modular Plug* \
  Using the cutting blade of the crimping tool, make a clean perpendicular cut straight across the wire ribbon, leaving approximately $0.5$ inches ($1.2"cm"$) of exposed wire from the jacket edge. Hold the RJ-45 connector with the plastic locking clip facing *downward*. Carefully slide the ribbon into the guide channels until all eight conductors reach the front wall.

6. *Step 6: Visual Inspection of Conductor Seating* \
  Inspect through the clear polycarbonate plug body to verify that all eight wires remain in proper color sequence, reach the front contact wall under the gold pins, and the outer cable jacket extends at least $0.25$ inches inside past the internal retention clamp.

7. *Step 7: Compressing & Crimping Connector* \
  Insert the modular plug into the 8P cavity of the crimping tool. Squeeze the handles firmly with both hands until the internal ratchet completes its stroke and releases. The tool drives the gold contact pins through the wire insulation and crimps the jacket strain-relief clamp.

8. *Step 8: Terminating Second Cable End* \
  Repeat Steps 1 through 7 on the opposite cable end. For a *Straight-Through Cable*, terminate End \#2 to *T-568B*. For a *Cross-Over Cable*, terminate End \#2 to *T-568A*.

9. *Step 9: Continuity Testing on Digital LAN Cable Tester* \
  Plug both ends of the finished cable into the Master and Remote units of the digital LAN continuity tester:
  - *Straight-Through Cable Test:* LEDs 1 through 8 light up sequentially in identical $1-1, 2-2, 3-3, ..., 8-8$ order on both units.
  - *Cross-Over Cable Test:* LEDs light up crossed ($1 arrow 3, 2 arrow 6, 3 arrow 1, 4 arrow 4, 5 arrow 5, 6 arrow 2, 7 arrow 7, 8 arrow 8$), verifying correct pair swapping.

#v(0.3em)
#align(center)[
  #text(weight: "bold", size: 10.5pt)[Fabrication & Verification Sequence: Steps 1 to 9 (Including Continuity Testing)]
  #v(0.25em)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 6pt,
    [
      #figure(
        image("assets/cabling/real_step1_stripper.jpg", width: 100%),
        caption: [1. Outer Jacket Stripping],
      )
    ],
    [
      #figure(
        image("assets/cabling/real_step2_pairs.jpg", width: 100%),
        caption: [2. Exposing 4 Twisted Pairs],
      )
    ],
    [
      #figure(
        image("assets/cabling/real_step3_untwist.jpg", width: 100%),
        caption: [3. Untwisting Conductors],
      )
    ],

    [
      #figure(
        image("assets/cabling/real_step4_align.jpg", width: 100%),
        caption: [4. T-568B Ribbon Alignment],
      )
    ],
    [
      #figure(
        image("assets/cabling/real_step5_trim.jpg", width: 100%),
        caption: [5. Perpendicular Wire Trimming],
      )
    ],
    [
      #figure(
        image("assets/cabling/real_step6_insert.jpg", width: 100%),
        caption: [6. Seating in RJ-45 Plug],
      )
    ],

    [
      #figure(
        image("assets/cabling/real_step7_crimp.jpg", width: 100%),
        caption: [7. Modular Tool Crimping],
      )
    ],
    [
      #figure(
        image("assets/cabling/real_step8_finished.jpg", width: 100%),
        caption: [8. Finished Crimped Plug],
      )
    ],
    [
      #figure(
        image("assets/cabling/real_step9_tester.jpg", width: 100%),
        caption: [9. LAN Continuity Testing],
      )
    ],
  )
]
#v(0.3em)

== Conclusion
Both Straight-Through and Cross-Over Ethernet patch cables were successfully fabricated, terminated, and verified. Pin continuity and correct pinout mappings were confirmed using the digital LAN cable tester according to EIA/TIA 568A and 568B industry specifications.

#pagebreak()


// =============================================================================
// PRACTICAL 4: NETWORK DEVICES
// =============================================================================

#practical-header("04", "Study and Test Various Network Devices")

== Aim
To study, identify, and evaluate various intermediate networking devices available in the Department/Institute (Repeater, Hub, Switch, Bridge, Router, and Gateway).

== Theoretical Foundation

#grid(
  columns: (1fr, 1fr),
  column-gutter: 14pt,
  row-gutter: 12pt,
  [
    === 1. Repeater
    - *Purpose:* Regenerates and amplifies electrical/optical signals degraded by attenuation over long physical distances.
    - *OSI Layer:* Layer 1 (Physical Layer).
    - *Functionality:* Re-conditions incoming weak bit signals to original amplitude and shape before retransmission.
    - *Limitation:* Blindly amplifies all signals, including noise and collisions; does not perform any frame/packet filtering.
  ],
  [
    === 2. Hub
    - *Purpose:* Basic multiport central connecting point in a star topology network.
    - *OSI Layer:* Layer 1 (Physical Layer).
    - *Functionality:* Multiport repeater; broadcasts any incoming frame received on one port out to *all other ports*.
    - *Limitation:* Single shared collision domain and single broadcast domain; high bandwidth wastage and collision probability.
  ],

  [
    === 3. Switch
    - *Purpose:* Intelligent multiport bridging device connecting multiple hosts on a LAN.
    - *OSI Layer:* Layer 2 (Data Link Layer); Layer 3 (Multilayer Switch).
    - *Functionality:* Maintains an internal *MAC Address Table* (CAM table) to forward frames *unicast* directly to the intended destination port.
    - *Advantage:* Dedicated collision domain per port, full-duplex operation, high throughput, and enhanced security.
  ],
  [
    === 4. Bridge
    - *Purpose:* Connects and filters traffic between two separate LAN segments using identical protocols.
    - *OSI Layer:* Layer 2 (Data Link Layer).
    - *Functionality:* Inspects destination MAC addresses; forwards frames across segments only when the destination resides on the remote segment.
    - *Advantage:* Divides a large collision domain into smaller, manageable segments.
  ],

  [
    === 5. Router
    - *Purpose:* Interconnects distinct, heterogeneous logical networks (e.g., local LANs to WAN / Internet).
    - *OSI Layer:* Layer 3 (Network Layer).
    - *Functionality:* Inspects destination IP addresses and determines the optimal path using dynamic routing tables and algorithms (OSPF, BGP).
    - *Additional Roles:* Performs NAT, DHCP serving, packet filtering (firewall), and breaks broadcast domains.
  ],
  [
    === 6. Gateway
    - *Purpose:* Acts as a protocol converter/translator enabling communication between disparate networks using incompatible protocol suites.
    - *OSI Layer:* All OSI layers (specifically Layer 7 Application Layer).
    - *Functionality:* Converts packet formatting, data encoding, and protocol semantics (e.g., email-to-fax, IPv4-to-IPv6, industrial SCADA-to-TCP/IP).
  ],
)

#v(0.6em)

=== Network Device Architectural Comparison

#custom-table(
  (1fr, 1fr, 1.1fr, 1.1fr, 1.4fr),
  [*Device*],
  [*OSI Layer*],
  [*Data Unit*],
  [*Addressing*],
  [*Collision Domain Separation*],
  [*Repeater*],
  [Layer 1 (Physical)],
  [Bits],
  [None],
  [Single shared domain],
  [*Hub*],
  [Layer 1 (Physical)],
  [Bits],
  [None],
  [Single shared domain],
  [*Bridge*],
  [Layer 2 (Data Link)],
  [Frames],
  [MAC Address],
  [Divides into 2+ domains],
  [*Switch*],
  [Layer 2 / Layer 3],
  [Frames / Packets],
  [MAC / IP Address],
  [Dedicated domain per port],
  [*Router*],
  [Layer 3 (Network)],
  [Packets],
  [IP Address],
  [Dedicated per port (+ breaks broadcast)],
  [*Gateway*],
  [All Layers (1--7)],
  [Application Data],
  [Multi-protocol / IP],
  [Completely isolates domains],
)

== Conclusion
The operational distinctions and layer-wise roles of Repeaters, Hubs, Bridges, Switches, Routers, and Gateways were analyzed. Modern enterprise networks predominantly deploy Layer 2/3 Managed Switches at the access/distribution layers and high-performance Routers and Firewalls at the core gateway boundary.

#pagebreak()


// =============================================================================
// PRACTICAL 5: TCP AND UDP PROTOCOLS
// =============================================================================

#practical-header("05", "Study of TCP and UDP Transport Layer Protocols")

== Aim
To study, analyze, and compare the two fundamental Transport Layer protocols of the Internet suite: *Transmission Control Protocol (TCP)* and *User Datagram Protocol (UDP)*.

== Theoretical Foundation

=== Transmission Control Protocol (TCP)
TCP is a connection-oriented, reliable transport protocol that guarantees accurate, in-order, and error-free delivery of byte streams between communicating network processes.
Before transmitting data, TCP establishes a virtual connection between client and server via a 3-way handshake:
1. *SYN:* Client transmits a TCP packet with the `SYN` flag set and an initial sequence number ($"ISN"_C$).
2. *SYN-ACK:* Server acknowledges by returning a packet with `SYN` and `ACK` flags set ($"ACK" = "ISN"_C + 1$) and its own sequence number ($"ISN"_S$).
3. *ACK:* Client transmits an `ACK` packet ($"ACK" = "ISN"_S + 1$). The connection is now active.
\
- *Key Mechanics:*
  - *Sequence & Acknowledgment Numbers:* Every byte is numbered, enabling reordering of out-of-order packets.
  - *Retransmission (ARQ):* Lost or corrupted packets detected by timeout or duplicate ACKs are retransmitted.
  - *Flow & Congestion Control:* Utilizes sliding windows and algorithms (Slow Start, Congestion Avoidance) to prevent receiver/network overload.
- *Primary Uses:* HTTP/HTTPS (Web browsing), SMTP/IMAP (Email), FTP/SFTP (File transfer), SSH.

=== User Datagram Protocol (UDP)
UDP is a lightweight, connectionless transport protocol that transmits independent packets called *datagrams* with minimal protocol overhead.

- *Key Characteristics:*
  - *Connectionless:* No handshake or connection teardown phase.
  - *No Delivery Guarantee:* Datagrams may arrive out-of-order, be duplicated, or be dropped without acknowledgment.
  - *Minimal Overhead:* 8-byte fixed header (compared to 20--60 byte TCP header), resulting in minimal latency.
- *Primary Uses:* Real-time multimedia streaming (VoIP, Video conferencing), DNS queries, DHCP, SNMP, Online Gaming.

#pagebreak()
=== Comprehensive Comparison: TCP vs. UDP

#custom-table(
  (1.2fr, 1.9fr, 1.9fr),
  [*Evaluation Metric*],
  [*Transmission Control Protocol (TCP)*],
  [*User Datagram Protocol (UDP)*],
  [*Connection Mode*],
  [Connection-oriented (Requires 3-way handshake)],
  [Connectionless (Direct datagram transmission)],
  [*Reliability*],
  [Guaranteed delivery with ACK & retransmission],
  [Best-effort; no guarantee or retransmission],
  [*Ordering*],
  [Strict in-order packet reconstruction],
  [No sequencing; packets may arrive unordered],
  [*Header Size*],
  [20 to 60 bytes (Variable, option fields)],
  [8 bytes fixed header],
  [*Transmission Speed*],
  [Slower due to handshake and ACK overhead],
  [Extremely fast with minimal latency],
  [*Flow / Congestion Control*],
  [Full sliding window & congestion avoidance],
  [None (application layer must handle if needed)],
  [*Communication Type*],
  [Strictly Unicast (Point-to-Point)],
  [Supports Unicast, Multicast, and Broadcast],
  [*Use Cases*],
  [Web (HTTP/HTTPS), Email (SMTP), File Transfer (FTP)],
  [DNS, VoIP, Live Streaming, Gaming, DHCP],
)

== Conclusion
TCP delivers guaranteed reliability at the expense of transmission latency and protocol overhead, making it mandatory for transactional and document transfers. UDP prioritizes raw throughput and low latency, making it the protocol of choice for time-sensitive, real-time media and lightweight query-response systems.

#pagebreak()


// =============================================================================
// PRACTICAL 6: NETWORK COMMANDS
// =============================================================================

#practical-header("06", "Study of Basic Network and Configuration Commands")

== Aim
To study, execute, and analyze foundational network diagnostic commands and network configuration management commands in a CLI environment.

== Diagnostic Network Commands

#grid(
  columns: 1fr,
  column-gutter: 12pt,
  row-gutter: 10pt,
  [
    === 1. `ping`
    Sends ICMP Echo Request packets to verify end-to-end IP reachability, round-trip time (RTT), and packet loss.
    ```bash
    ping google.com
    ```
    #align(center)[#image("assets/commands/cmd_ping.png", width: 95%)]
  ],
  [
    === 2. `ipconfig`
    Displays active network adapter configurations, including IPv4 address, Subnet Mask, and Default Gateway.
    ```bash
    ipconfig /all
    ```
    #align(center)[#image("assets/commands/cmd_ipconfig.png", width: 95%)]
  ],

  [
    === 3. `netstat`
    Displays active network connections, listening TCP/UDP ports, routing tables, and interface statistics.
    ```bash
    netstat -an
    ```
    #align(center)[#image("assets/commands/cmd_netstat.png", width: 95%)]
  ],
  [
    === 4. `tracert` (Traceroute)
    Traces the intermediate router hops packets traverse to reach a target destination by incrementing ICMP/IP TTL.
    ```bash
    tracert google.com
    ```
    #align(center)[#image("assets/commands/cmd_tracert.png", width: 95%)]
  ],

  [
    === 5. `nslookup`
    Queries Domain Name System (DNS) servers to resolve hostnames to IP addresses and query DNS resource records.
    ```bash
    nslookup google.com
    ```
    #align(center)[#image("assets/commands/cmd_nslookup.png", width: 95%)]
  ],
  [
    === 6. `arp`
    Displays and modifies the local Address Resolution Protocol (ARP) cache mapping IP addresses to physical MAC addresses.
    ```bash
    arp -a
    ```
    #align(center)[#image("assets/commands/cmd_arp.png", width: 95%)]
  ],

  [
    === 7. `hostname`
    Prints the netBIOS and DNS computer host name of the local system.
    ```bash
    hostname
    ```
    #align(center)[#image("assets/commands/cmd_hostname.png", width: 95%)]
  ],
  [
    === 8. `whois`
    Retrieves ownership, registrar, creation, and expiration details of a registered domain name.
    ```bash
    whois google.com
    ```
  ],

  [
    === 9. `netsh` (Network Shell)
    CLI scripting utility to inspect and configure network adapters and firewall rules.
    ```bash
    netsh interface show interface
    ```
    #align(center)[#image("assets/commands/cmd_netsh.png", width: 95%)]
  ],
  [
    === 10. `curl` / `wget`
    CLI utilities to transfer data from web servers via HTTP, HTTPS, and FTP for endpoint testing.
    ```bash
    curl google.com
    ```
    #align(center)[#image("assets/commands/cmd_curl.png", width: 95%)]

  ],
)

#v(0.5em)

=== Network Configuration Commands

1. *Assigning a Static IP Address via `netsh`:*
```cmd
netsh interface ip set address name="Ethernet" static 192.168.1.100 255.255.255.0 192.168.1.1
```

1. *Inspecting Routing Tables via `route print`:*
```cmd
route print
```
#align(center)[
  #figure(
    image("assets/commands/cmd_route_print.png", width: 75%),
    caption: [IPv4 Routing Table Displayed via `route print`.],
  )
]

1. *Adding a Static Route via `route add`:*
```cmd
route add 192.168.2.0 mask 255.255.255.0 192.168.1.1
```

1. *Flushing DNS Resolver Cache via `ipconfig /flushdns`:*
```cmd
ipconfig /flushdns
```
#align(center)[
  #figure(
    image("assets/commands/cmd_flushdns.png", width: 75%),
    caption: [Successful Execution of DNS Cache Flush Command.],
  )
]

== Conclusion
All primary network diagnostic (`ping`, `ipconfig`, `netstat`, `tracert`, `nslookup`, `arp`, `hostname`) and configuration (`netsh`, `route`, `flushdns`) commands were successfully studied, executed, and verified against live network interfaces.

#pagebreak()


// =============================================================================
// PRACTICAL 7: IPV4 ADDRESS VALIDATION
// =============================================================================

#practical-header("07", "IPv4 Address Classification and Validity Analysis")

== Aim
To determine whether given IPv4 addresses are *valid* or *invalid*. For valid addresses, identify the *Class*, *Network ID*, and *Host ID*. For invalid addresses, state the precise technical reason for invalidation.

Given Test Addresses:
1. `1.4.5.5`
2. `75.45.301.14`
3. `111.56.045.78`
4. `192.226.12.11`
5. `130.45.151.154`
6. `11100010.23.14.67`

== Theoretical Foundation
An *IPv4 Address* is a 32-bit logical address structured as four 8-bit octets separated by decimal dots ($A.B.C.D$).

=== Rules for Valid IPv4 Addresses
1. Must contain exactly four octets separated by periods (`.`).
2. Each octet value in decimal must lie strictly within the range $[0, 255]$ ($2^8 = 256$ values).
3. Octets must be represented in base-10 decimal notation.

=== Classful Addressing Architecture

#custom-table(
  (0.8fr, 1fr, 1.2fr, 1.2fr, 1.4fr),
  [*Class*],
  [*1st Octet Range*],
  [*Network Portion*],
  [*Host Portion*],
  [*Default Subnet Mask*],
  [*Class A*],
  [$1 - 126$],
  [1st Octet ($8$ bits)],
  [Octets 2, 3, 4 ($24$ bits)],
  [`255.0.0.0` (/8)],
  [*Class B*],
  [$128 - 191$],
  [Octets 1, 2 ($16$ bits)],
  [Octets 3, 4 ($16$ bits)],
  [`255.255.0.0` (/16)],
  [*Class C*],
  [$192 - 223$],
  [Octets 1, 2, 3 \ ($24$ bits)],
  [Octet 4 ($8$ bits)],
  [`255.255.255.0` (/24)],
  [*Class D*],
  [$224 - 239$],
  [Multicast Group ID],
  [Multicast \ Address Space],
  [N/A (Multicast)],
  [*Class E*],
  [$240 - 255$],
  [Experimental Space],
  [Reserved / Research],
  [N/A (Experimental)],
)

\

=== Detailed Analysis of Assigned Addresses

1. *`1.4.5.5`*
  - *Validation:* All four octets are within $[0, 255]$.
  - *Class:* First octet is $1 in [1, 126] arrow$ *Class A*.
  - *Network ID:* `1.0.0.0` (First octet: `1`).
  - *Host ID:* `0.4.5.5` (Remaining octets: `4.5.5`).

2. *`75.45.301.14`*
  - *Validation:* *Invalid*.
  - *Reason:* The third octet value $301 > 255$, violating the 8-bit octet maximum constraint ($[0, 255]$).

3. *`111.56.045.78`*
  - *Validation:* *Valid* (Leading zero in `045` evaluates to decimal integer $45 in [0, 255]$).
  - *Class:* First octet is $111 in [1, 126] arrow$ *Class A*.
  - *Network ID:* `111.0.0.0` (First octet: `111`).
  - *Host ID:* `0.56.45.78` (Remaining octets: `56.45.78`).

4. *`192.226.12.11`*
  - *Validation:* All four octets lie within $[0, 255]$.
  - *Class:* First octet is $192 in [192, 223] arrow$ *Class C*.
  - *Network ID:* `192.226.12.0` (First 3 octets: `192.226.12`).
  - *Host ID:* `0.0.0.11` (Fourth octet: `11`).

5. *`130.45.151.154`*
  - *Validation:* All four octets lie within $[0, 255]$.
  - *Class:* First octet is $130 in [128, 191] arrow$ *Class B*.
  - *Network ID:* `130.45.0.0` (First 2 octets: `130.45`).
  - *Host ID:* `0.0.151.154` (Octets 3 and 4: `151.154`).

6. *`11100010.23.14.67`*
  - *Validation:* *Invalid*.
  - *Reason:* First octet `11100010` is formatted in 8-bit binary instead of standard dotted-decimal format (which would be $226$). Standard IPv4 string parsing rejects raw binary octets.

#v(0.5em)

=== Summary Evaluation Table

#custom-table(
  (1.4fr, 0.9fr, 0.7fr, 1.2fr, 1.1fr, 1.4fr),
  [*IPv4 Address*],
  [*Status*],
  [*Class*],
  [*Network ID*],
  [*Host ID*],
  [*Reason*],
  [`1.4.5.5`],
  [Valid],
  [A],
  [`1.0.0.0`],
  [`0.4.5.5`],
  [Standard Class A \ Valid IP],
  [`75.45.301.14`],
  [Invalid],
  [--],
  [--],
  [--],
  [Octet 3 ($301 > 255$) \ Out of Range],
  [`111.56.045.78`],
  [Valid],
  [A],
  [`111.0.0.0`],
  [`0.56.45.78`],
  [Valid Class A \ (`045` = 45)],
  [`192.226.12.11`],
  [Valid],
  [C],
  [`192.226.12.0`],
  [`0.0.0.11`],
  [Standard Class C \ Valid IP],
  [`130.45.151.154`],
  [Valid],
  [B],
  [`130.45.0.0`],
  [`0.0.151.154`],
  [Standard Class B \ Valid IP],
  [`11100010.` \ `23.14.67`],
  [Invalid],
  [--],
  [--],
  [--],
  [Octet 1 in \ binary notation],
)

== Conclusion
All test IPv4 addresses were rigorously verified. Valid addresses were accurately decomposed into Class, Network ID, and Host ID boundaries, and invalid addresses were classified with exact mathematical and syntax justifications.

#pagebreak()


// =============================================================================
// PRACTICAL 8: EXPLORE WIRESHARK
// =============================================================================

#practical-header("08", "Exploration of Wireshark Protocol Analyzer")

== Aim
To explore the *Wireshark* network packet analyzer, understand its operational architecture, capture capabilities, and analyze its graphical interface panes.

== Software & Prerequisites
- Wireshark Network Protocol Analyzer (v4.0+)
- Active Network Interface (Wi-Fi / Ethernet adapter)

== Theoretical Foundation
*Wireshark* is an open-source packet analyzer used for network troubleshooting, analysis, software and communications protocol development, and education. It captures packet data traversing network interfaces in real time and decodes protocols from Layer 2 up to Layer 7.

=== Operational Architecture
- *Capture Engine (libpcap / Npcap):* Intercepts raw link-layer frames from the Network Interface Card (NIC).
- *Promiscuous Mode:* Configures the NIC to pass all received traffic to the CPU, not just frames destined for the host's own MAC address.
- *Port Mirroring (SPAN):* On switched networks, switch port mirroring replicates frames from target ports to the analyzer's capture port.

=== Wireshark Interface Anatomy

==== 1. Interface Selection Welcome Screen
Displays all available physical and virtual network interfaces (Wi-Fi, Ethernet, Loopback) along with real-time sparkline activity graphs.

#align(center)[
  #figure(
    image("assets/wireshark/wireshark_welcome.png", width: 82%),
    caption: [Wireshark Welcome Screen & Interface Selection (Fig 1).],
  )
]

#v(0.5em)

#align(center)[
  #figure(
    image("assets/wireshark/wireshark_capture.png", width: 85%),
    caption: [Wireshark 3-Pane Packet Inspection Workspace (Fig 2).],
  )
]

#v(0.4em)

=== The Three Core Inspection Panes
1. *Packet List Pane (Top):*
  - Displays a summary table of all captured packets: Packet Number, Timestamp, Source IP/MAC, Destination IP/MAC, Protocol name, Length, and Summary Info.
  - Rows are color-coded based on protocol rules (e.g., green for HTTP, light blue for DNS, dark blue for DNS query, red for TCP resets/errors).
2. *Packet Details Pane (Middle):*
  - Hierarchical collapsible tree showing full protocol dissection layer-by-layer: Frame (Layer 1), Ethernet II (Layer 2), IPv4/IPv6 (Layer 3), TCP/UDP (Layer 4), and Application Payload (Layer 7).
3. *Packet Bytes Pane (Bottom):*
  - Displays raw packet contents in simultaneous Hexadecimal dump (left) and ASCII character mapping (right). Selecting a field in the Details pane automatically highlights the corresponding byte offset in this pane.

== Conclusion
The core interface, packet capture engine, promiscuous capture modes, and 3-pane dissection architecture of Wireshark were thoroughly explored, establishing the prerequisite foundation for live protocol capture.

#pagebreak()


// =============================================================================
// PRACTICAL 9: CAPTURING TRAFFIC WITH WIRESHARK
// =============================================================================

#practical-header("09", "Capturing Network Traffic Using Wireshark")

== Aim
To capture live network traffic across active interfaces using Wireshark, apply real-time display filters, and analyze captured communication streams.

== Theoretical Foundation
Capturing live network traffic is essential for:
- Diagnosing network latency, dropped packets, and transmission errors.
- Detecting unauthorized access, port scans, and malware beaconing.
- Debugging custom network client-server software implementations.
- Verifying cryptographic encryption status (e.g., plaintext HTTP vs. encrypted TLS).

=== Step-by-Step Packet Capture Methodology

1. *Interface Selection & Initialization:*
  - Launch Wireshark. Identify the active interface exhibiting live traffic waveforms (e.g., *Wi-Fi*).
  - Double-click the interface or click the blue *Start Capturing Packets* shark-fin icon.

2. *Live Traffic Generation:*
  - Open a browser or terminal to generate traffic (e.g., accessing a web page or executing `ping`/`nslookup`).

3. *Applying Display Filters:*
  - Wireshark utilizes a rich filter expression syntax in the top Filter Bar:
    - `ip.addr == 192.168.1.1` -- Isolates traffic involving a specific host IP.
    - `tcp.port == 80 || tcp.port == 443` -- Filters web traffic.
    - `dns || arp` -- Displays only name resolution and address resolution frames.
    - `http.request.method == "GET"` -- Filters HTTP GET requests.

4. *Analyzing & Following Streams:*
  - Right-click any TCP packet and select *Follow $arrow$ TCP Stream* to view the reconstructed bidirectional application conversation in plain text.

5. *Stopping and Exporting Captures:*
  - Click the red *Stop Capture* button.
  - Export captured frames to standard `.pcapng` or `.pcap` formats via *File $arrow$ Save As*.

== Conclusion
Live network traffic was successfully captured, filtered, and saved. Display filters enabled swift isolation of specific protocol exchanges from noisy background broadcasts.

#pagebreak()


// =============================================================================
// PRACTICAL 10: PROTOCOL ANALYSIS WITH WIRESHARK
// =============================================================================

#practical-header("10", "Protocol Analysis (ARP, HTTP, DNS, SMTP) Using Wireshark")

== Aim
To capture and analyze packet headers and communication mechanisms for fundamental networking protocols: *Address Resolution Protocol (ARP)*, *Domain Name System (DNS)*, *Hypertext Transfer Protocol (HTTP)*, and *Simple Mail Transfer Protocol (SMTP)* using Wireshark.

== Theoretical & Packet Dissection Analysis

=== 1. Address Resolution Protocol (ARP) Analysis
ARP operates between Layers 2 and 3 to resolve a known logical 32-bit IPv4 address into a 48-bit physical MAC address.

- *ARP Request:* Broadcast frame ($"FF:FF:FF:FF:FF:FF"$) asking: _"Who has IP 192.168.1.1? Tell 192.168.1.50"_.
- *ARP Reply:* Unicast response from target: _"192.168.1.1 is at MAC 00:1A:2B:3C:4D:5E"_.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/wireshark/wireshark_arp.png", width: 85%),
    caption: [Wireshark Dissection of ARP Broadcast Request and Target Reply.],
  )
]
#v(0.3em)

=== 2. Hypertext Transfer Protocol (HTTP) Analysis
HTTP is an unencrypted Application Layer protocol operating over TCP (port 80).

- *HTTP GET Request:* Client transmits request headers (`Host`, `User-Agent`, `Accept-Encoding`).
- *HTTP Response:* Server returns status code (`200 OK`, `404 Not Found`) along with `Content-Type`, `Content-Length`, and payload.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/wireshark/wireshark_http.png", width: 85%),
    caption: [Wireshark Dissection of HTTP GET Request and Server Response.],
  )
]
#v(0.3em)

=== 3. Domain Name System (DNS) Analysis
DNS translates human-readable domain names into IP addresses, typically using UDP port 53.

- *DNS Standard Query:* Client sends UDP datagram querying Type A record for `google.com`.
- *DNS Standard Query Response:* Server returns DNS answers containing resolved A/AAAA IP records.

#v(0.3em)
#align(center)[
  #figure(
    image("assets/wireshark/wireshark_dns.png", width: 85%),
    caption: [Wireshark Dissection of DNS Query and Resolved Answer Records.],
  )
]
#v(0.3em)

=== 4. Simple Mail Transfer Protocol (SMTP) Analysis
SMTP transfers electronic mail across TCP port 25 or 587. It executes command-response handshakes: `HELO`/`EHLO` (greeting), `MAIL FROM:` (sender), `RCPT TO:` (recipient), `DATA` (message body), and `QUIT`.

#pagebreak()
=== Summary Matrix of Analyzed Application & Network Protocols

#custom-table(
  (1fr, 1.1fr, 1.1fr, 0.9fr, 1.9fr),
  [*Protocol*],
  [*OSI Layer*],
  [*Underlying Transport*],
  [*Port / Type*],
  [*Primary Operation / Purpose*],
  [*ARP*],
  [Layer 2 / 3],
  [Ethernet Frame],
  [Type `0x0806`],
  [Resolves IP address to physical MAC address],
  [*DNS*],
  [Layer 7 (App)],
  [UDP (or TCP)],
  [Port 53],
  [Translates domain names to IP addresses],
  [*HTTP*],
  [Layer 7 (App)],
  [TCP],
  [Port 80],
  [Transfers hypertext web documents and assets],
  [*SMTP*],
  [Layer 7 (App)],
  [TCP],
  [Port 25 / 587],
  [Transfers electronic mail between mail servers],
)

== Conclusion
All four core protocols (ARP, DNS, HTTP, and SMTP) were captured and analyzed using Wireshark. The packet inspections confirmed the exact theoretical operation of address resolution, name translation, client-server web transactions, and email transfer.

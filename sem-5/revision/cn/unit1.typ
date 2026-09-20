// unit1.typ: Unit 1 - Introduction to Networking and Communication Systems
#import "theme.typ": *

#unit-header(
  "1",
  "Introduction to Networking and Communication Systems",
  "Network architectures, edge/core decomposition, delay and loss modeling, layered service models, and historical milestones.",
  checklist: (
    "Network Edge vs. Network Core",
    "Switching: Circuit, Message, Packet",
    "Major Topologies & Link Formulas",
    "Delay Components & Traffic Intensity",
    "Packet Loss & Bottleneck Throughput",
    "OSI 7-Layer Architecture & Encapsulation",
    "OSI vs. TCP/IP Comparative Analysis",
    "Protocol Triad & Historical Milestones"
  )
)

= 1.1 Understanding Network Fundamentals & Topologies

A #key-term[computer network] is an interconnection of autonomous computing devices (hosts, servers, embedded systems) linked by transmission media to share resources and exchange data. Network layout can be characterized *physically* (cabling geometry and node placement) and *logically* (the trajectory data signals follow).

#figure-card("images/image1.jpg", [Technical diagram illustrating the five fundamental network topologies: Bus, Star, Ring, Mesh, and Tree.])

== Comparative Analysis of Major Network Topologies

- #key-term[Bus Topology:] All devices tap into a single shared coaxial or twisted-pair transmission medium called the *backbone*. Signals propagate in both directions; terminating resistors absorb signals at line ends to prevent boundary reflections. While economical and simple to deploy, a break in the backbone halts all communication. As station count grows, collision probability and CSMA backoff degrade throughput.
- #key-term[Star Topology:] Every end station connects via point-to-point links to a central multiport device (hub or switch). The central switch provides port isolation: a cut link affects only that single station. The central switch remains a single point of failure and requires substantial aggregate cabling.
- #key-term[Ring Topology:] Stations form a closed circular loop where each node connects directly to its two immediate neighbors. Data circulates unidirectionally using *token passing* deterministic access, preventing packet collisions. However, an unbypassed node failure severs the entire ring unless configured as a counter-rotating dual ring (e.g., FDDI).
- #key-term[Mesh Topology:] In a *Full Mesh*, every node maintains an independent dedicated physical link to every other node. For a network of $n$ nodes:

#formula-box("Full Mesh Physical Links Formula", $ "Number of Duplex Links" = frac(n(n - 1), 2), quad "Ports per Device" = n - 1 $)

Mesh topologies deliver unmatched fault tolerance, line isolation, and security. However, high cabling costs make full mesh practical only for core router backbones. Enterprise access networks employ *Partial Mesh*, interconnecting only critical switches redundantly.
- #key-term[Tree Topology:] A hierarchical star-bus hybrid. Workstation clusters attach to local switches, which cascade into distribution and core aggregation switches. This structure enables hierarchical addressing, fault isolation, and straightforward expansion across multi-building enterprise campuses.

= 1.2 The Network Edge & Network Core

The global Internet is architecturally decomposed into two foundational domains: the distributed perimeter (*Network Edge*) and the high-speed switching fabric (*Network Core*).

#figure-card("images/image7.jpg", [Architectural partition: Network Edge (hosts, mobile devices, access networks) vs. Network Core (interconnected mesh of switches and routers).])

== Architectural Functions of Edge and Core

- #key-term[Network Edge:] Comprises all end systems (hosts), including workstations, mobile smartphones, compute clusters, and IoT devices. End systems execute application-layer software (web servers, video streamers, peer-to-peer clients). End systems attach to the infrastructure via *Access Networks*:
  - *Fiber-to-the-Home (FTTH):* Optical line terminals (OLT) feeding split optical distribution networks (PON) offering gigabit symmetrical bandwidth.
  - *Cable & DSL:* Hybrid Fiber-Coaxial (HFC) using DOCSIS standard frequency bands or legacy copper twisted-pair with asymmetric downstream/upstream allocations.
  - *Cellular Wireless (4G LTE / 5G):* Radio access networks (RAN) communicating with Base Transceiver Stations (gNodeB) connected to a mobile packet core.
  - *Enterprise Wi-Fi & Ethernet:* IEEE 802.11 wireless access points multiplexed into IEEE 802.3 Gigabit Ethernet switches.
- #key-term[Network Core:] The interconnected mesh of packet-switching routers and optical links spanning Internet Service Providers (ISPs), Internet Exchange Points (IXPs), and Tier-1 transit backbones. The core performs two essential functions:
  1. *Routing (Control Plane):* Distributed routing protocols (OSPF, BGP) computing optimal end-to-end paths across global networks.
  2. *Forwarding (Data Plane):* Local, hardware-accelerated transfer of an incoming datagram from an ingress physical port to the appropriate egress port based on forwarding tables.

#callout-box(title: "The End-to-End Architectural Principle")[
  The network core remains strictly *application-agnostic*. Intermediate core routers inspect only Layer 3 headers to route packets, pushing intelligence, state maintenance, connection handshakes, and encryption exclusively to the network edge.
]

= 1.3 Switching Mechanisms: Circuit, Message, and Packet

Moving data across an intermediate mesh requires switching mechanisms to route bits between non-adjacent nodes.

#figure-card("images/image14.jpg", [Comparative pathways and data transfer mechanics across Circuit, Message, and Packet Switching paradigms.], width: 62%)

== Comparative Evaluation of Switching Technologies

#table(
  columns: (1.2fr, 1.4fr, 1.4fr, 1.4fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (left, left, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Parameter],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Circuit Switching],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Message Switching],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Packet Switching],
  ),
  [*Dedicated Path*], [Pre-established physical circuit], [No dedicated path], [No dedicated path],
  [*Resource Reservation*], [Deterministic (FDM/TDM)], [None (buffer storage on disk)], [Dynamic on-demand allocation],
  [*Transfer Unit*], [Continuous bit stream], [Entire message (arbitrary size)], [Small, bounded packets],
  [*Store-and-Forward*], [No (instantaneous transit)], [Yes (entire message stored)], [Yes (packet-by-packet pipelined)],
  [*Traffic Efficiency*], [Poor for bursty data (wasted)], [Moderate (high link efficiency)], [Maximum (statistical multiplexing)],
  [*Interactive Use*], [Optimal for real-time voice], [Unusable (massive latency)], [Optimal for mixed data and media],
)

- #key-term[Circuit Switching:] Operates in three distinct phases: *Call Setup* $arrow$ *Data Transfer* $arrow$ *Circuit Teardown*. Once established, reserved bandwidth guarantees constant transmission rate and zero queuing jitter. However, channel capacity remains blocked during silent periods.
- #key-term[Message Switching:] Precursor to packet switching where intermediate nodes receive an entire unstructured message, store it to disk or memory, and forward it when the output link is idle. Bounded intermediate storage limitations and massive cumulative delays make it unsuitable for interactive applications.
- #key-term[Packet Switching:] Divides messages into bounded units (*packets* of length $L$ bits). Senders pipeline packets across multiple links concurrently.
  - *Datagram Packet Switching:* Each packet is routed independently using full destination IP addressing; packets may follow disparate paths and arrive out of order.
  - *Virtual Circuit Packet Switching:* A logical path is signaled and recorded in router connection tables; all packets bear a short Virtual Circuit Identifier (VCI) and follow identical paths in sequence.

= 1.4 Analyzing Delay, Loss, and Throughput in Packet-Switched Networks

When packets traverse a sequence of communication links and routers, they encounter cumulative transmission impediments.

#figure-card("images/image9.jpg", [Breakdown of packet latency components: Processing, Queuing, Transmission, and Propagation Delays.])

== Total Nodal Delay Decomposition

The total nodal delay experienced by a packet at a single router hop is:

#formula-box("Total Nodal Delay", $ d_("nodal") = d_("proc") + d_("queue") + d_("trans") + d_("prop") $)

1. #key-term[Nodal Processing Delay ($d_("proc")$):] The time elapsed inspecting packet bit-level integrity (evaluating checksums) and indexing forwarding tables to determine the output interface. In specialized ASICs, $d_("proc") < 10 mu text("s")$.
2. #key-term[Queuing Delay ($d_("queue")$):] The duration a packet waits in an output link's buffer queue before transmission. Queuing delay varies per packet depending on network traffic intensity. If traffic arrives at rate $a$ packets/sec with length $L$ bits onto a link of capacity $R$ bps:

#formula-box("Traffic Intensity & Queuing Behavior", $ I = frac(L dot a, R) cases(
  I approx 0 quad &==> d_("queue") approx 0,
  I arrow.tr 1 quad &==> d_("queue") arrow.tr infinity,
  I > 1 quad &==> "Queue overflows; packet loss occurs"
) $)

3. #key-term[Transmission Delay ($d_("trans")$):] The physical time required to serialize all $L$ bits of a packet onto the transmission link operating at rate $R$:

#formula-box("Transmission Delay Formula", $ d_("trans") = frac(L, R) = frac("Packet Length " (L) " in bits", "Link Bandwidth " (R) " in bps") $)

4. #key-term[Propagation Delay ($d_("prop")$):] The transit time for an electromagnetic signal to traverse the physical distance $d$ across the medium at propagation speed $s$ ($approx 2 times 10^8 text(" m/s")$ in copper and fiber):

#formula-box("Propagation Delay Formula", $ d_("prop") = frac(d, s) = frac("Physical Distance " (d), "Signal Propagation Speed " (s)) $)

== Packet Loss Dynamics and Throughput

- #key-term[Packet Loss:] Router buffers have finite memory capacity. When a packet arrives at an output queue that is completely full ($I > 1$ over an interval), the router drops the packet (*buffer overflow*). Dropped packets must be detected and retransmitted by reliable transport layers (TCP) or discarded entirely by real-time streams (UDP).
- #key-term[Throughput:] The effective rate (bits/sec) at which data is successfully transferred from source to destination.
  - *Instantaneous Throughput:* The rate at any specific instant in time.
  - *Average Throughput:* Total transferred data volume divided by total time taken.
  - *Bottleneck Link:* In a multi-hop transmission path with link capacities $R_1, R_2, dots, R_k$, the end-to-end throughput is constrained by the minimum link capacity along the chain:

#formula-box("Bottleneck Link Throughput", $ "Throughput"_(text("end-to-end")) <= min(R_1, R_2, dots, R_k) $)

= 1.5 Protocol Layers & Network Service Models

Complex networking systems rely on modular, hierarchical layer stacks. Each layer offers defined services to the layer above while consuming services from the layer below.

#figure-card("images/image6.jpg", [The 7-Layer OSI Reference Architecture showing layer numbering, functional roles, and protocol data units.], width: 50%)

== The 7-Layer OSI Reference Model

1. #key-term[Physical Layer (Layer 1):] Transmits raw unformatted bit streams across physical media. Defines electrical voltage thresholds, pinouts, cable specifications (Cat6, single-mode fiber), modulation schemas (QAM, PAM4), and bit timing.
2. #key-term[Data Link Layer (Layer 2):] Facilitates node-to-node frame transit across a single physical link. Manages framing, physical addressing (48-bit MAC addresses), error detection (CRC), and media access arbitration:
   - *LLC (Logical Link Control):* Multiplexes multiple network layer protocols over shared physical links.
   - *MAC (Media Access Control):* Arbitrates shared medium channel access (CSMA/CD, CSMA/CA).
3. #key-term[Network Layer (Layer 3):] Manages multi-hop logical packet routing across disparate networks. Governs logical addressing (IPv4/IPv6), routing table compilation (OSPF, BGP), and packet fragmentation.
4. #key-term[Transport Layer (Layer 4):] Delivers transparent end-to-end process-to-process communication. Provides application socket multiplexing (port numbers), sequence tracking, flow control, and error recovery (TCP, UDP).
5. #key-term[Session Layer (Layer 5):] Coordinates dialogues between remote application endpoints. Establishes, synchronizes, and checkpoints sessions so disrupted transfers resume without restarting.
6. #key-term[Presentation Layer (Layer 6):] Translates data syntax and semantics between disparate machine representations. Governs data encoding (ASCII, Unicode), serialization, compression, and cryptographic security (TLS/SSL).
7. #key-term[Application Layer (Layer 7):] Provides high-level network interface primitives directly to user applications (HTTP, SMTP, DNS, SSH, FTP).

== OSI vs. TCP/IP Architecture Comparison

#figure-card("images/image11.jpg", [Architectural mapping comparing the theoretical 7-layer OSI model to the 4-layer practical TCP/IP suite.], width: 60%)

#table(
  columns: (1fr, 1.3fr, 1.3fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Dimension],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[OSI Model],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[TCP/IP Model],
  ),
  [*Layer Granularity*], [7 strict, distinct layers], [4 pragmatic, consolidated layers],
  [*Design Philosophy*], [Developed as a theoretical standard before protocols existed], [Protocols developed first; model codified to describe reality],
  [*Application Scope*], [Splits Session, Presentation, Application], [Collapses all into a single Application layer],
  [*Network Service*], [Supports both Connection-Oriented and Connectionless], [Strictly Connectionless (IP datagram service)],
  [*Transport Service*], [Strictly Connection-Oriented], [Offers both Connection-Oriented (TCP) and Datagram (UDP)],
  [*Protocol Coupling*], [Strict decoupling: Service, Interface, Protocol], [Loosely coupled; protocols define their own interfaces],
  [*Industry Adoption*], [Universal conceptual/educational standard], [Universal operational implementation standard of the Internet],
)

= 1.6 Network Protocols & Historical Evolution

A #key-term[network protocol] is a formal specification governing the syntax, semantics, and timing of data exchanged between peer entities.

#figure-card("images/image13.jpg", [The tripartite foundation of network protocol specifications: Syntax, Semantics, and Timing.])

== The Tripartite Elements of a Protocol

1. #key-term[Syntax:] The data format, coding structure, and bit field layouts. Dictates exact offsets, field lengths, and packet delimiters (e.g., the first 4 bits define the IP version number).
2. #key-term[Semantics:] The operational meaning of each field, flag, and control bit sequence. Dictates the specific actions required upon receiving a command (e.g., an active `SYN` control bit signals connection initiation).
3. #key-term[Timing:] Defines sequencing and speed synchronization. Controls transmission intervals, timeout deadlines, acknowledgment deadlines, and flow control throttling.

== Historical Milestones in Computer Network Development

- #key-term[1969 — ARPANET Launch:] Advanced Research Projects Agency (DoD) deploys the first operational 4-node packet-switching network linking UCLA, Stanford Research Institute, UC Santa Barbara, and University of Utah using Interface Message Processors (IMPs) and 50 kbps lines.
- #key-term[1972 — ALOHAnet & Network Email:] Norman Abramson develops ALOHAnet at the University of Hawaii, pioneering wireless random access. Ray Tomlinson writes the first networked email program, introducing the `@` symbol.
- #key-term[1974 — TCP Architecture Formalized:] Vinton Cerf and Robert Kahn publish *"A Protocol for Packet Network Intercommunication"*, outlining the core principles of TCP/IP, encapsulation, and internetworking gateway routers.
- #key-term[January 1, 1983 — The Flag Day Transition:] ARPANET officially decommissions the original Network Control Protocol (NCP) and transitions all nodes simultaneously to TCP/IP. In the same year, Paul Mockapetris invents the hierarchical Domain Name System (DNS).
- #key-term[1989–1991 — Birth of the World Wide Web:] Tim Berners-Lee invents HTML, HTTP, URLs, and the first web browser at CERN, sparking exponential global Internet growth.
- #key-term[1993–1995 — Commercialization & Modern Backbones:] The National Science Foundation decommissions NSFNET in 1995, privatizing Internet backbones. CIDR (RFC 1519) is deployed to stave off routing table collapse, and work begins on IPv6.

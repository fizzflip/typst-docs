// unit4.typ: Unit 4 - Network Routing and Addressing Layer
#import "theme.typ": *

#unit-header(
  "4",
  "Network Routing and Addressing Layer",
  "Data plane forwarding vs. control plane routing, router switching fabrics, IPv4/IPv6 addressing, subnetting and CIDR, Dijkstra and Bellman-Ford algorithms, and broadcast/multicast.",
  checklist: (
    "Data Plane (Forwarding) vs. Control Plane (Routing)",
    "Router Architecture & Head-of-Line (HOL) Blocking",
    "Classful IP Addressing Boundaries & Limitations",
    "Subnetting Math, Subnet Masks & CIDR Prefixing",
    "IPv4 vs. IPv6 Architecture & Network Address Translation (NAT)",
    "Link-State Routing: Dijkstra's Algorithm",
    "Distance-Vector Routing: Bellman-Ford & Count-to-Infinity",
    "Hierarchical Routing (OSPF, BGP) & Multicast (IGMP, RPF)"
  )
)

#extra-pill
= 4.1 Forwarding, Routing, & Service Models

The Network Layer functions through two distinct planes of operation:

- #key-term[Data Plane (Forwarding):] The local, per-router action of transferring a packet from its input link interface to the appropriate output link interface. Forwarding is executed in microsecond/nanosecond timescales using specialized hardware lookup engines (TCAMs).
- #key-term[Control Plane (Routing):] The network-wide logic coordinating how packets are routed along end-to-end paths from source to destination across multiple routers. Executes on software timescales (seconds) via distributed routing algorithms (OSPF, BGP) or centralized *Software-Defined Networking (SDN)* controllers.

== Network Service Models

The Internet Network Layer adheres to the #key-term[Best-Effort Service Model]:
- No timing or latency guarantees.
- No minimum bandwidth guarantees.
- No guarantee against packet loss, reordering, or duplication.
Alternative historical models (e.g., ATM Constant Bit Rate CBR) attempted end-to-end delay and bandwidth guarantees, but incurred immense state complexity in core switches. The Internet's simplicity pushed intelligence to edge hosts, enabling global scalability.

#extra-pill
= 4.2 Router Architecture & Forwarding Fabrics

A high-speed router consists of four primary internal components:
1. #key-term[Input Ports:] Terminate physical transmission lines, perform data link decapsulation, and execute *Longest Prefix Match* lookup in forwarding tables to determine the destination output port.
2. #key-term[Switching Fabric:] Interconnects input ports to output ports. Three primary architectures:
   - *Memory:* Packets copied to system memory; constrained by bus bandwidth.
   - *Bus:* Input port transfers packet over a shared internal bus directly to output port; limited by bus speed.
   - *Crossbar (Interconnection Network):* An $N times N$ matrix of switching crosspoints allowing up to $N$ packets to be switched in parallel simultaneously, provided they are directed to different output ports.
3. #key-term[Output Ports:] Stores packets arriving from the switching fabric in queues, and transmits them onto the outgoing physical medium using packet schedulers (FIFO, Priority, Weighted Fair Queuing).
4. #key-term[Routing Processor:] General-purpose CPU running control plane tasks (routing protocols, network management, interface configuration).

#callout-box(title: "Head-of-Line (HOL) Blocking in Router Input Queues")[
  When two packets at the heads of two different input queues compete for the *same* output port, one packet is blocked. The packet queued immediately *behind* the blocked packet must wait, even if its own destination output port is completely idle and clear. This phenomenon is known as *Head-of-Line (HOL) Blocking*, capping theoretical crossbar throughput at $approx 58.6%$ unless Virtual Output Queuing (VOQ) is used.
]

= 4.3 Classful IP Addressing & Structural Limitations

The foundational 32-bit IPv4 address space ($2^(32) approx 4.29 times 10^9$ addresses) was historically partitioned into five distinct classes governed by leading bit patterns.

#figure-card("images/image2.jpg", [Classful IPv4 architecture breaking down Classes A, B, C, D, and E bit boundaries, masks, and network/host splits.], width: 48%)

== The Five Historical IP Classes

- #key-term[Class A (`0.0.0.0` to `127.255.255.255`):]
  - Leading bit: `0`. Network bits: 8; Host bits: 24.
  - Default subnet mask: `255.0.0.0` (`/8`).
  - Accommodates 126 networks with up to $2^(24) - 2 = 16,777,214$ assignable host addresses per network. Reserved for massive multinational entities.
- #key-term[Class B (`128.0.0.0` to `191.255.255.255`):]
  - Leading bits: `10`. Network bits: 16; Host bits: 16.
  - Default subnet mask: `255.255.0.0` (`/16`).
  - Supports 16,384 networks with up to $2^(16) - 2 = 65,534$ host addresses per network. Intended for large universities and regional telecom providers.
- #key-term[Class C (`192.0.0.0` to `223.255.255.255`):]
  - Leading bits: `110`. Network bits: 24; Host bits: 8.
  - Default subnet mask: `255.255.255.0` (`/24`).
  - Supports $2,097,152$ networks with only $2^(8) - 2 = 254$ assignable hosts each. Designed for small local networks.
- #key-term[Class D (`224.0.0.0` to `239.255.255.255`):]
  - Leading bits: `1110`.
  - Reserved exclusively for *Multicast* traffic targeting dynamic host groups.
- #key-term[Class E (`240.0.0.0` to `255.255.255.255`):]
  - Leading bits: `1111`.
  - Reserved by IANA for experimental, scientific, and future protocol testing.

#callout-box(title: "The Rapid Exhaustion & Inefficiency of Classful Allocation")[
  Classful addressing suffered severe internal address fragmentation. An organization requiring 500 addresses had to be assigned a Class B network (65,534 addresses), wasting over 65,000 unusable IP addresses. This inflexibility threatened complete exhaustion of IPv4 addresses by the mid-1990s.
]

= 4.4 Subnetting, Subnet Masks, and CIDR

#figure-card("images/image3.jpg", [Subnetting architectural division: borrowing host bits to construct structured sub-network IDs.])

== Subnetting Principles & Host Calculations

Subnetting divides a large physical IP network into smaller, logically isolated sub-networks (*subnets*) by manipulating the subnet mask to "borrow" contiguous bits from the host portion of an address:

#formula-box("Subnetting Capacity Formulas", $
  text("Number of Subnets Created") &= 2^s quad &(s = text("borrowed subnet bits")) \
  text("Usable Hosts per Subnet") &= 2^h - 2 quad &(h = text("remaining host bits"))
$)

*(Note: Two host addresses are strictly reserved: the all-zeros host address represents the Subnet Wire ID, and the all-ones host address represents the Subnet Directed Broadcast).*

== Classless Inter-Domain Routing (CIDR - RFC 1519)

In 1993, the IETF ratified *CIDR*, abolishing rigid Class A/B/C boundaries. Under CIDR:
- Addresses are written in prefix slash notation: `a.b.c.d/x`, where `/x` specifies the exact number of contiguous leading bits defining the network prefix.
- Routers match incoming packets using *Longest Prefix Match (LPM)*: when a packet matches multiple routing table entries, the router forwards it along the interface with the longest matching prefix (most specific subnet).
- Enables *Route Aggregation (Summarization)*: thousands of individual subnets are advertised globally as a single aggregate prefix (e.g., sixteen `/24` subnets summarized into a single `/20`), preventing the collapse of global BGP routing tables.

= 4.5 IPv4 vs. IPv6 & Network Address Translation (NAT)

#figure-card("images/image15.jpg", [Header architectures, field simplifications, and address formatting comparisons between IPv4 and IPv6.])

== Structural Comparison: IPv4 vs. IPv6

#table(
  columns: (1fr, 1.3fr, 1.3fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Feature],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[IPv4],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[IPv6],
  ),
  [*Address Length*], [32 bits (4 bytes)], [128 bits (16 bytes)],
  [*Total Address Space*], [$2^(32) approx 4.29 times 10^9$ addresses], [$2^(128) approx 3.4 times 10^(38)$ addresses],
  [*Address Notation*], [Dotted-decimal: `192.168.1.1`], [Hexadecimal colon: `2001:0db8::8a2e:0370:7334`],
  [*Base Header Size*], [Variable: 20 to 60 bytes (Options field)], [Fixed: *40 bytes* (fast ASIC processing)],
  [*Extension Headers*], [Appended inside variable header], [Chained via `Next Header` field],
  [*Checksum Calculation*], [Computed at every router hop (slow)], [Eliminated entirely (handled at Layers 2 & 4)],
  [*Fragmentation*], [Performed by intermediate routers & hosts], [Performed *only* by source sender (Path MTU)],
  [*Configuration*], [Manual or DHCP stateful server], [Stateless Address Autoconfiguration (SLAAC)],
  [*Quality of Service*], [Type of Service (ToS) / DiffServ], [Dedicated 20-bit *Flow Label* for real-time QoS],
)

== Network Address Translation (NAT - RFC 3022)

NAT preserves IPv4 addresses by enabling an entire local private network to communicate with the global Internet using a single public IP address:
- #key-term[Private Address Spaces (RFC 1918):] `10.0.0.0/8`, `172.16.0.0/12`, and `192.168.0.0/16`.
- #key-term[NAPT (Port Address Translation):] The NAT gateway router intercepts outgoing datagrams, replaces the private source IP and port with its own public IP and an assigned ephemeral port, and records the mapping in a *NAT Translation Table*. Incoming return packets are reverse-mapped to the original internal host.

#extra-pill
= 4.6 Routing Algorithms: Link-State vs. Distance-Vector

Routing algorithms compute least-cost paths through a network modeled as a graph $G = (V, E)$.

== Link-State (LS) Routing: Dijkstra’s Shortest Path Algorithm

In Link-State routing (e.g., OSPF), every router possesses complete global topology information by flooding link-state advertisements (LSAs). Each router independently executes *Dijkstra's Algorithm*:

#algorithm-box("Dijkstra's Shortest Path Algorithm", [
```
Initialization:
  N' = {u}                        // Set of nodes whose least cost is definitively known
  for all nodes v:
    if v is a neighbor of u:
      D(v) = c(u, v)              // Initial direct link cost
    else:
      D(v) = infinity

Loop:
  find w not in N' such that D(w) is a minimum
  add w to N'
  for all neighbors v of w not in N':
    D(v) = min(D(v), D(w) + c(w, v))
until all nodes are in N'
```
])

- *Computational Complexity:* $O(N^2)$ with basic arrays, reducible to $O(|E| + |V| log |V|)$ with min-heap priority queues.
- *Oscillations:* Can suffer route flapping when link costs depend dynamically on real-time traffic volume.

== Distance-Vector (DV) Routing: Bellman-Ford Algorithm

Distance-Vector routing (e.g., RIP) is decentralized and iterative. Routers exchange routing tables only with immediate physical neighbors. Path costs obey the *Bellman-Ford Equation*:

#formula-box("Bellman-Ford Equation", $ d_x(y) = min_v { c(x, v) + d_v(y) } $)

where $c(x, v)$ is the direct link cost to neighbor $v$, and $d_v(y)$ is neighbor $v$'s advertised distance to destination $y$.
- #key-term[The Count-to-Infinity Problem:] Good news (link cost reductions) propagates rapidly ($O(1)$ iterations). However, bad news (link failures) propagates slowly, creating routing loops where two routers bounce packets back and forth, incrementing metric costs to infinity.
- #key-term[Mitigation Techniques:] *Split Horizon* (never advertise a route back to the neighbor from which it was learned) and *Poison Reverse* (advertise a route as $infinity$ to the neighbor through which that route passes).

== Hierarchical Routing: Intra-AS vs. Inter-AS (BGP)

The Internet scales by grouping routers into *Autonomous Systems (AS)*:
- #key-term[Intra-AS Routing (Interior Gateway Protocols - IGPs):] Operates within an organization's network. Emphasizes pure performance and shortest path. Examples: *OSPF* (Open Shortest Path First - Link-State) and *RIP* (Distance-Vector).
- #key-term[Inter-AS Routing (Border Gateway Protocol - BGP):] Coordinates routing between distinct autonomous systems. Operates on *Path Vector* logic, factoring in business contracts, political peering policies, and transit agreements rather than raw physical link speed.

#pagebreak()
#extra-pill
= 4.7 Broadcasting and Multicasting in Routing

- #key-term[Broadcasting:] Delivering a packet to *every* node on a network.
  - *Flooding:* Router forwards an incoming broadcast packet to all outgoing interfaces. Can cause catastrophic broadcast storms without duplicate tracking.
  - *Reverse Path Forwarding (RPF):* A router forwards a broadcast packet only if it arrived on the interface that is on the router's own shortest unicast path back to the sender; otherwise, the packet is silently dropped.
  - *Spanning Tree Broadcast:* Constructs an acyclic minimum spanning tree; packets propagate along tree branches with zero duplicate loops.
- #key-term[Multicasting:] Delivering a packet to an arbitrary subset of destination nodes.
  - *IGMP (Internet Group Management Protocol):* Enables hosts to inform their local router of group membership.
  - *Multicast Routing (PIM-SM / PIM-DM):* Routers construct source-based or rendezvous-point shared trees to forward traffic strictly along links leading to active group members.

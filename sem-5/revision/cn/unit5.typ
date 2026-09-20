// unit5.typ: Unit 5 - Data Link and Access Layer
#import "theme.typ": *

#unit-header(
  "5",
  "Data Link and Access Layer",
  "Node-to-node framing, error detection and correction (CRC, Hamming), multiple access arbitration (ALOHA, CSMA/CD), MAC/ARP resolution, Ethernet architecture, learning switches, and 802.1Q VLANs.",
  checklist: (
    "Link Layer Services & Network Interface Cards (NIC)",
    "Error Detection: Parity, Checksums, and CRC Polynomial Division",
    "Error Correction: Hamming Distance & Hamming Code",
    "Multiple Access Protocols: ALOHA, CSMA/CD, and CSMA/CA",
    "48-Bit MAC Addressing vs. Logical IP Addressing",
    "Address Resolution Protocol (ARP) Request/Reply Lifecycle",
    "IEEE 802.3 Ethernet Standards & Minimum Frame Constraints",
    "Self-Learning Switches vs. Hubs & Collision Domains",
    "IEEE 802.1Q VLAN Tagging & Inter-VLAN Routing"
  )
)

#extra-pill
= 5.1 Overview of Link Layer Functions & Architecture

Operating at Layer 2, the Link Layer transfers discrete protocol data units (*frames*) between directly adjacent nodes connected across a physical transmission link.

== Core Link Layer Services

1. #key-term[Framing:] Encapsulates Layer 3 IP datagrams into Layer 2 frames by appending a header (containing source and destination physical hardware addresses) and a trailer (containing error-checking bits).
2. #key-term[Link Access & MAC Addressing:] Governs medium access control (MAC) when multiple stations share a broadcast channel (e.g., Wi-Fi or traditional coaxial cables).
3. #key-term[Reliable Delivery:] Guarantees error-free transit across link boundaries via hop-by-hop acknowledgments and retransmissions. Often implemented on high-error wireless links (802.11), but bypassed on low-error fiber/twisted-pair links to eliminate redundant protocol overhead.
4. #key-term[Flow Control:] Prevents a fast sending network card from overflowing the receive buffer of an adjacent receiving card.
5. #key-term[Error Detection & Correction:] Detects and corrects bit errors introduced by electromagnetic interference, signal attenuation, or thermal noise on physical wires.

#callout-box(title: "Hardware Implementation of the Link Layer")[
  Unlike the Application and Transport layers (which execute in host operating system kernel software), the Link Layer is implemented primarily in hardware within a *Network Interface Card (NIC)* or network adapter chip. The NIC contains the MAC controller, physical layer transceivers, and dedicated buffer memory.
]

#extra-pill
= 5.2 Data Integrity: Error Detection & Correction

== Parity Checks

- #key-term[Single-Bit Parity:] Appends one extra parity bit so the total number of 1s is always even (Even Parity) or odd (Odd Parity). Detects all odd numbers of bit errors ($1, 3, 5, dots$), but completely fails to detect even numbers of errors (e.g., 2 flipped bits).
- #key-term[Two-Dimensional Parity:] Arranges data bits into a two-dimensional matrix of $r$ rows and $c$ columns, computing parity across each individual row and each individual column. Detects and *corrects* any single bit error by identifying the intersecting row and column of the parity mismatch.

== Cyclic Redundancy Check (CRC / Polynomial Codes)

CRC is a mathematically rigorous error-detection technique widely deployed in Ethernet, Wi-Fi, and storage controllers. Bit sequences are treated as polynomials with coefficients in the Galois Field $text("GF")(2)$ (arithmetic performed modulo 2 without carries or borrows; equivalent to bitwise XOR):

#algorithm-box("Cyclic Redundancy Check (CRC) Polynomial Division", [
```
Let data bits D = 101001 (k bits), Generator G = 1101 (r + 1 bits, degree r = 3)
1. Append r zeros to D: D * 2^r = 101001000
2. Perform modulo-2 division of (D * 2^r) by G using XOR:

        110101
      --------
1101 | 101001000
       1101
       ----
        1110
        1101
        ----
         0111
         0000
         ----
          1110
          1101
          ----
           0110
           0000
           ----
            1100
            1101
            ----
             001  <-- Remainder R (r = 3 bits)

3. Transmitted Frame T = (D * 2^r) XOR R = 101001001
Receiver divides T by G: if remainder == 0, frame is uncorrupted.
```
])

- Standard generator polynomials (e.g., *CRC-32*: $x^(32) + x^(26) + x^(23) + dots + 1$) detect all single and double bit errors, all odd numbers of bit errors, and all burst errors of length $<= 32$ bits with $99.9999999%$ probability.

== Error Correction: Hamming Code & Distance

- #key-term[Hamming Distance ($d$):] The number of bit positions in which two binary codewords differ.
  - To *detect* $e$ bit errors, the minimum Hamming distance of the code must satisfy: $d_("min") >= e + 1$.
  - To *correct* $e$ bit errors, the minimum Hamming distance must satisfy: $d_("min") >= 2e + 1$.
- #key-term[Hamming Error-Correcting Code:] Interleaves $r$ parity bits into an $m$-bit data word at bit positions that are powers of 2 ($1, 2, 4, 8, dots$). The number of required parity bits satisfies:

#formula-box("Hamming Redundancy Condition", $ 2^r >= m + r + 1 $)

Each parity bit calculates even parity over specific bit subsets determined by their binary index representations. At the receiver, re-evaluating parities generates an integer syndrome that directly points to the exact bit position of any flipped bit, enabling instantaneous hardware correction.

#extra-pill
= 5.3 Multiple Access Protocols (MAC)

When multiple stations share a common broadcast channel, signals can collide, corrupting data. MAC protocols arbitrate access.

== Channel Partitioning Protocols

- #key-term[TDM (Time Division Multiplexing):] Time is partitioned into frames, each divided into $N$ fixed slots. Each node is assigned one slot per frame. Eliminates collisions completely, but wastes bandwidth if a node has no data to transmit ($1/N$ maximum throughput per node).
- #key-term[FDM (Frequency Division Multiplexing):] Channel spectrum is split into $N$ sub-frequency bands. Suffer from static capacity wastage during idle periods.
- #key-term[CDMA (Code Division Multiple Access):] Assigns a unique orthogonal mathematical code (*chip sequence*) to each station. Stations transmit concurrently over the identical frequency band; receivers apply inner-product vector decoding to extract the desired transmission cleanly out of interference.

== Random Access Protocols & Collision Resolution

- #key-term[Pure ALOHA:] Stations transmit whenever they have data ready. If a collision occurs, stations wait a random backoff time before retransmitting:

#formula-box("Pure ALOHA Throughput", $ S = G dot e^(-2G) quad ==> quad S_("max") = frac(1, 2e) approx 18.4% quad (text("at ") G = 0.5) $)

- #key-term[Slotted ALOHA:] Time is divided into discrete synchronized slots equal to packet transmission time ($L/R$). Nodes can transmit only at the beginning of a slot:

#formula-box("Slotted ALOHA Throughput", $ S = G dot e^(-G) quad ==> quad S_("max") = frac(1, e) approx 36.8% quad (text("at ") G = 1.0) $)

- #key-term[Carrier Sense Multiple Access (CSMA):] "Listen before speaking." A station senses the channel prior to transmission. If the channel is sensed busy, the station defers transmission:
  - *1-Persistent CSMA:* Transmits immediately as soon as the channel becomes idle.
  - *Non-Persistent CSMA:* Waits an independent random time interval before re-sensing the channel.
  - *p-Persistent CSMA:* When idle, transmits with probability $p$; defers with probability $1 - p$.
- #key-term[CSMA/CD (Collision Detection - IEEE 802.3 Ethernet):] "Listen while speaking." If two stations transmit simultaneously due to propagation delay, both detect the collision, immediately abort transmission, emit a *32-bit Jam Signal* to notify all stations, and execute *Binary Exponential Backoff*:

#formula-box("Binary Exponential Backoff", $ "After " k text(" collisions, choose random integer ") r in {0, 1, 2, dots, 2^k - 1} quad (k = min(n, 10)) $)

The node waits $r times 51.2 mu text("s")$ (the slot time in 10 Mbps Ethernet) before re-attempting carrier sense.
- #key-term[CSMA/CA (Collision Avoidance - IEEE 802.11 Wi-Fi):] Wireless hardware cannot detect collisions while transmitting because local transmit power drowns out incoming signals. Wi-Fi avoids collisions using Inter-Frame Spaces (DIFS/SIFS), random backoff timers, and explicit *RTS/CTS (Request to Send / Clear to Send)* reservation handshakes to solve the *Hidden Terminal Problem*.

#extra-pill
= 5.4 Network Addressing: MAC vs. IP & The ARP Protocol

== MAC Addresses vs. Logical IP Addresses

#table(
  columns: (1fr, 1.4fr, 1.4fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Dimension],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[MAC Address (Layer 2)],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[IP Address (Layer 3)],
  ),
  [*Structure*], [48 bits (6 bytes), flat structure], [32 bits (IPv4) or 128 bits (IPv6), hierarchical],
  [*Representation*], [Hexadecimal: `00:1A:2B:3C:4D:5E`], [Dotted-decimal (`192.168.1.1`) or hex colon],
  [*Assignment*], [Permanently burned into NIC hardware (BIA) by IEEE vendor], [Dynamically assigned by network administrator / DHCP],
  [*Portability*], [Portable: address remains identical wherever device moves], [Non-portable: changes when host connects to a new subnet],
  [*Scope*], [Direct physical link / local broadcast domain], [Global end-to-end internetwork routing],
)

== Address Resolution Protocol (ARP - RFC 826)

ARP dynamically translates known Layer 3 IP addresses into Layer 2 hardware MAC addresses on the local subnet:
1. #key-term[ARP Request (Broadcast):] Host A wishes to send a datagram to IP `192.168.1.50` on the same subnet, but does not know its MAC address. Host A broadcasts an ARP request frame to the universal Layer 2 broadcast MAC address: `FF:FF:FF:FF:FF:FF`.
2. #key-term[ARP Reply (Unicast):] All stations on the local subnet receive and inspect the frame. The target host matching `192.168.1.50` responds with a unicast ARP reply containing its physical MAC address directly to Host A.
3. #key-term[ARP Cache Table:] Both hosts record the mapping `(IP Address -> MAC Address, TTL)` in local volatile ARP cache tables (typical TTL: 10–20 minutes) to eliminate redundant broadcast lookups.

#extra-pill
= 5.5 IEEE 802.3 Ethernet Architecture & Frame Standards

Ethernet has been the dominant wired LAN technology for over four decades, evolving from 10 Mbps coaxial bus configurations to 400 Gbps switched optical architectures.

== Standard IEEE 802.3 Ethernet Frame Structure

#table(
  columns: (1fr, 0.6fr, 1.2fr, 1.2fr, 0.8fr, 2fr, 0.8fr),
  fill: (x, y) => if y == 0 { crimson-main } else { warm-bg },
  stroke: 0.5pt + warm-border,
  align: center,
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Preamble],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[SFD],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Dest MAC],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Source MAC],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Type],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Payload (Data + Pad)],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[FCS],
  ),
  [7 Bytes], [1 Byte], [6 Bytes], [6 Bytes], [2 Bytes], [46 to 1500 Bytes], [4 Bytes],
)

- #key-term[Preamble (7 Bytes):] Alternating bit pattern `10101010` used by receiver physical circuitry to lock clock phase and synchronize bit timing.
- #key-term[Start Frame Delimiter - SFD (1 Byte):] Pattern `10101011`; the concluding double-1s signal the start of destination addressing.
- #key-term[Type / Length (2 Bytes):] Values $>= 1536$ (`0x0600`) designate encapsulated higher-layer protocols (`0x0800` for IPv4, `0x86DD` for IPv6, `0x0806` for ARP).
- #key-term[Payload (46 to 1500 Bytes):] Contains the Layer 3 datagram. The maximum payload is the *Maximum Transmission Unit (MTU = 1500 bytes)*.
- #key-term[Frame Check Sequence - FCS (4 Bytes):] 32-bit CRC enabling the receiver to detect bit corruption.

#callout-box(title: "The Physics Behind the Minimum 64-Byte Ethernet Frame Constraint")[
  In legacy half-duplex CSMA/CD Ethernet, a transmitting station must remain transmitting long enough to detect a collision returning from the most distant node across the maximum allowed cable diameter ($2 times text("Propagation Delay") = text("Slot Time") = 51.2 mu text("s")$). At 10 Mbps:
  $ text("Minimum Frame Length") = 10 times 10^6 text(" bps") times 51.2 times 10^(-6) text(" s") = 512 text(" bits") = 64 text(" bytes") $
  Subtracting 18 bytes of header and trailer leaves a minimum payload of *46 bytes*. Datagrams smaller than 46 bytes are automatically padded with zeros.
]

#extra-pill
= 5.6 Ethernet Switching & Self-Learning Mechanisms

Modern Ethernet LANs operate exclusively via switched, full-duplex, point-to-point links, eliminating collisions entirely.

== Hubs vs. Bridges vs. Layer 2 Switches vs. Routers

#table(
  columns: (1fr, 0.9fr, 1.4fr, 1.4fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (center, center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Device],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Layer],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Collision Domain Scope],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Broadcast Domain Scope],
  ),
  [*Hub / Repeater*], [Layer 1], [Single collision domain across all ports], [Single broadcast domain across all ports],
  [*Bridge*], [Layer 2], [Isolates 2 collision domains (software)], [Single broadcast domain],
  [*Layer 2 Switch*], [Layer 2], [*Dedicated collision domain per port*], [Single broadcast domain across all ports],
  [*Layer 3 Router*], [Layer 3], [Dedicated collision domain per interface], [*Isolates and terminates broadcast domains*],
)

== Switch Filtering and Self-Learning Algorithm

A Layer 2 switch maintains a dynamic *Switch Forwarding Table* mapping MAC addresses to outgoing physical switch ports:
1. When a frame arrives on interface $x$ with source MAC $A$ and destination MAC $B$, the switch automatically records or refreshes the entry `(MAC A -> Port x, Current Time)` in its forwarding table.
2. The switch indexes its table for destination MAC $B$:
   - *If entry for B exists on interface x:* The frame is silently dropped (*filtering*), as destination $B$ resides on the same segment.
   - *If entry for B exists on interface y ($y != x$):* The switch forwards the frame exclusively onto port $y$ (*selective forwarding*).
   - *If no entry for B exists (unknown destination):* The switch forwards copies of the frame onto *all* outgoing ports except port $x$ (*flooding*).

#extra-pill
= 5.7 Virtual LANs (VLANs) & IEEE 802.1Q Tagging

In standard switched networks, all connected ports belong to a single common broadcast domain. If a rogue device generates broadcast storms or ARP spoofing attacks, all users are impacted.

== Motivation for VLAN Segmentation

A #key-term[Virtual Local Area Network (VLAN)] logically partitions a single physical switch infrastructure into multiple distinct broadcast domains. Devices in different VLANs cannot communicate at Layer 2, even if plugged into adjacent physical ports on the same switch:
- #key-term[Traffic Isolation & Security:] Sensitive financial or executive nodes are isolated from general student or guest Wi-Fi networks.
- #key-term[Broadcast Containment:] ARP and broadcast frames remain bounded within their originating VLAN.
- #key-term[Flexible Management:] Users are grouped by project or department rather than physical building locations.

== IEEE 802.1Q Frame Tagging & Trunk Links

When multiple VLANs span across interconnected switches, inter-switch links operate as *Trunk Ports*. The sending switch inserts a *4-byte IEEE 802.1Q Tag* into the standard Ethernet frame between the Source MAC and Type fields:

#table(
  columns: (1fr, 0.8fr, 0.4fr, 1.8fr),
  fill: (x, y) => if y == 0 { crimson-main } else { warm-bg },
  stroke: 0.5pt + warm-border,
  align: center,
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[TPID (Tag Protocol ID)],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[PCP (Priority)],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[DEI],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[VID (VLAN Identifier)],
  ),
  [`0x8100` (16 Bits)], [3 Bits (CoS QoS)], [1 Bit], [*12 Bits* (VLAN IDs: $1 text(" to ") 4094$)],
)

== Inter-VLAN Routing

Because VLANs represent separate broadcast subnets, traffic moving between disparate VLANs *must* pass through a Layer 3 routing engine:
- *Router-on-a-Stick:* A single physical trunk cable connects the switch to an external router interface configured with virtual logical sub-interfaces (e.g., `eth0.10`, `eth0.20`), routing traffic between VLANs.
- *Layer 3 Multi-Layer Switch:* Employs high-speed internal Switch Virtual Interfaces (SVIs) to route packets between VLANs directly inside switch hardware at wire-speed without leaving the backplane.

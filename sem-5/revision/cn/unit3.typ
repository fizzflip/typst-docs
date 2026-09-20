// unit3.typ: Unit 3 - Transport Protocol Layer
#import "theme.typ": *

#unit-header(
  "3",
  "Transport Protocol Layer",
  "Process-to-process multiplexing, UDP datagram service, principles of reliable data transfer (RDT), TCP state machines, flow control, and congestion mitigation.",
  checklist: (
    "Process Multiplexing & Port De-multiplexing",
    "Well-Known Port Numbers & Protocol Registry",
    "Channel Multiplexing (FDM, TDM, WDM)",
    "Connectionless Transport: UDP Header & Checksum",
    "Connection-Oriented vs. Connectionless Paradigms",
    "RDT Evolution: Stop-and-Wait, Go-Back-N, Selective Repeat",
    "TCP Segment Architecture & Handshake State Machine",
    "Adaptive RTT Estimation & Timeout Calculations",
    "TCP Sliding Window Flow Control vs. Congestion Control (AIMD)"
  )
)

= 3.1 Transport Services & Port Multiplexing

The Transport Layer operates at Layer 4 to deliver *logical process-to-process communication* between application processes running on distinct hosts.

#figure-card("images/image16.jpg", [Process-to-process multiplexing and demultiplexing mechanisms at the Transport Layer using socket port bindings.])

== Multiplexing and Demultiplexing Mechanics

- #key-term[Multiplexing (at Sender):] Gathering data chunks from multiple application sockets, encapsulating each chunk with transport headers containing port numbers, and passing the resulting segments down to the Network Layer.
- #key-term[Demultiplexing (at Receiver):] Inspecting the port fields in incoming transport segments to direct payloads to the exact matching socket endpoint:
  - *Connectionless Demux (UDP):* Sockets are identified strictly by a *2-tuple*: `(Destination IP, Destination Port)`. Two UDP segments originating from different source IP addresses or source ports destined for the same destination IP and port are delivered to the identical socket.
  - *Connection-Oriented Demux (TCP):* Sockets are uniquely identified by a *4-tuple*: `(Source IP, Source Port, Destination IP, Destination Port)`. An arriving TCP segment is matched against all four fields to reach its dedicated connection socket.

== Port Numbers & Standard Registries

#figure-card("images/image17.jpg", [Infographic chart summarizing core well-known transport layer ports and standard Internet protocols.], width: 42%)

Port numbers are 16-bit unsigned integers ($0 text(" to ") 65535$) categorized by IANA into three operational tiers:
- #key-term[Well-Known Ports (0 – 1023):] Assigned to standard, privileged system infrastructure services.
- #key-term[Registered Ports (1024 – 49151):] Allocated by IANA to specific vendor server applications (e.g., MySQL port 3306).
- #key-term[Dynamic / Private / Ephemeral Ports (49152 – 65535):] Allocated dynamically by client operating systems for temporary outbound connection sockets.

#table(
  columns: (1.1fr, 0.8fr, 1.4fr, 2.7fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (left, center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Protocol],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Port],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Transport],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Standard Functional Description],
  ),
  [*FTP (Data)*], [`20`], [TCP], [File Transfer Protocol channel dedicated to transmitting file payloads.],
  [*FTP (Control)*], [`21`], [TCP], [Carries administrative commands, credentials, and server status codes.],
  [*SSH*], [`22`], [TCP], [Secure Shell for encrypted remote terminal sessions, SFTP, and port forwarding.],
  [*Telnet*], [`23`], [TCP], [Legacy unencrypted plaintext remote terminal access (insecure; deprecated).],
  [*SMTP*], [`25`], [TCP], [Simple Mail Transfer Protocol for inter-server mail relaying.],
  [*DNS*], [`53`], [UDP & TCP], [Domain Name System: UDP for queries ($<= 512$ bytes); TCP for zone transfers.],
  [*DHCP*], [`67/68`], [UDP], [Dynamic Host Configuration Protocol: 67 (server), 68 (client).],
  [*HTTP*], [`80`], [TCP], [Hypertext Transfer Protocol for standard unencrypted World Wide Web traffic.],
  [*POP3*], [`110`], [TCP], [Post Office Protocol v3 for client mail download and inbox retrieval.],
  [*IMAP*], [`143`], [TCP], [Internet Message Access Protocol for synchronized multi-device email folders.],
  [*HTTPS*], [`443`], [TCP / UDP], [HTTP over TLS/SSL encryption; also HTTP/3 (QUIC over UDP port 443).],
)

== Physical and Channel Multiplexing Techniques

#figure-card("images/image5.jpg", [Cellular and satellite communication channels: Forward (Downlink) vs. Backward (Uplink), alongside FDM, TDM, and WDM.])

- #key-term[Directional Channel Partitioning:]
  - *Forward Channel (Downlink):* Downstream transmission path directing traffic from core base stations to mobile user terminals. Because user consumption is asymmetrical, forward links receive dominant bandwidth.
  - *Backward Channel (Uplink):* Return path conveying client control requests, upstream voice, and data to the network infrastructure.
- #key-term[Multiplexing Methods:]
  - *Frequency Division Multiplexing (FDM):* Channel spectrum is partitioned into distinct, non-overlapping frequency bands separated by guard bands.
  - *Time Division Multiplexing (TDM):* Users share the full spectrum band by taking turns across discrete recurring time slots.
  - *Wavelength Division Multiplexing (WDM):* Optical counterpart to FDM in fiber optics. Multiple laser beams on distinct optical wavelengths (colors of light) propagate concurrently down a single fiber strand.

#extra-pill
= 3.2 Connectionless Transport: UDP (RFC 768)

The #key-term[User Datagram Protocol (UDP)] is a minimalist, lightweight transport protocol that adds almost nothing to IP beyond process multiplexing and basic error checking.

== Structural Advantages of UDP

1. #key-term[No Connection Establishment Delay:] UDP transmits data immediately without waiting for a 3-way handshake round-trip (critical for DNS and HTTP/3 QUIC).
2. #key-term[No Connection State Maintenance:] Servers do not track sequence numbers, acknowledgment numbers, or buffer state, allowing a single server to handle tens of thousands of active UDP clients.
3. #key-term[Minimal Packet Header Overhead:] UDP headers consume only *8 bytes* (compared to TCP's 20–60 bytes), conserving transmission bandwidth.
4. #key-term[Unregulated Send Rate:] UDP lacks congestion control. Applications can push data into the network at a constant rate without throttling down during packet loss (vital for real-time voice and video).

== UDP Segment Architecture & The 16-Bit Checksum

#table(
  columns: (1fr, 1fr),
  fill: (x, y) => if y == 0 { crimson-main } else { warm-bg },
  stroke: 0.5pt + warm-border,
  align: center,
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[16-Bit Source Port],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[16-Bit Destination Port],
  ),
  [16-Bit Segment Length (Bytes)], [16-Bit Internet Checksum],
  table.cell(colspan: 2, fill: white)[Application Data (Payload)],
)

#callout-box(title: "UDP Checksum Computation Algorithm")[
  The sender treats the pseudo-header (Source IP, Destination IP, Protocol = 17, UDP Length), the 8-byte UDP header, and the data payload as a sequence of 16-bit integers. All 16-bit words are summed using *1's complement arithmetic* (any overflow bit wrapped around to the lowest bit). The 1's complement of this sum is placed in the Checksum field. The receiver sums the exact same fields including the checksum: if no bit errors occurred, the final sum equals `0xFFFF` (`1111111111111111`).
]

= 3.3 Connection-Oriented vs. Connectionless Paradigms

#figure-card("images/image12.jpg", [Protocol sequence flow: Connection-Oriented 3-way handshake vs. Connectionless datagram transmission.])

#table(
  columns: (1fr, 1.4fr, 1.4fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Characteristic],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Connection-Oriented (TCP)],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Connectionless (UDP)],
  ),
  [*Connection State*], [Formal 3-way handshake (`SYN` $arrow$ `SYN-ACK` $arrow$ `ACK`)], [None; datagrams transmitted instantaneously],
  [*Reliability*], [Guaranteed: cumulative ACKs, timers, retransmissions], [Best-effort: unacknowledged, packets may drop],
  [*Ordering*], [Strictly preserved via 32-bit sequence numbers], [Not guaranteed; packets may arrive out-of-order],
  [*Flow Control*], [Yes: sliding window constrained by receiver buffer (`rwnd`)], [None: sender pushes data at arbitrary rate],
  [*Congestion Control*], [Yes: adaptive window algorithms (AIMD, Reno, Tahoe)], [None: does not throttle during network saturation],
  [*Header Size*], [20 to 60 bytes], [Fixed 8 bytes],
  [*Common Use Cases*], [Web (HTTP/S), Email (SMTP), Remote Shell (SSH), Files (FTP)], [DNS, VoIP, Live Video Streaming, Online Gaming, NTP],
)

= 3.4 Principles of Reliable Data Transfer (RDT)

Because underlying IP networks are inherently unreliable (packets may be corrupted, duplicated, delayed, or dropped), the transport layer must synthesize a reliable channel abstraction.

#figure-card("images/image8.jpg", [Reliable Data Transfer (RDT) protocol mechanisms: checksums, sequence tracking, feedback ACKs/NAKs, and timer timeouts.])

== Step-by-Step Evolution of RDT Mechanisms

1. #key-term[RDT 1.0 (Completely Reliable Channel):] Assumes perfect underlying links. Sender pushes data; receiver extracts data. No state or feedback required.
2. #key-term[RDT 2.0 (Channel with Bit Errors):] Introduces *Error Detection* (checksums) and *Receiver Feedback*:
   - *Positive Acknowledgment (ACK):* Informs the sender that a packet arrived uncorrupted.
   - *Negative Acknowledgment (NAK):* Signals that a packet suffered bit corruption, triggering retransmission (*Stop-and-Wait*).
3. #key-term[RDT 2.1 (Handling Corrupted ACKs/NAKs):] What if an ACK or NAK itself is corrupted? The sender cannot know whether to retransmit. RDT 2.1 introduces *Sequence Numbers* (0 and 1). If an ACK is corrupted, the sender retransmits; the receiver inspects the sequence number to discard duplicate packets.
4. #key-term[RDT 2.2 (NAK-Free Protocol):] Eliminates NAKs entirely. The receiver instead transmits duplicate ACKs for the last correctly received packet. An ACK for packet 0 received when waiting for ACK 1 serves as an implicit NAK.
5. #key-term[RDT 3.0 (Channels with Errors and Packet Loss):] Packets or ACKs may disappear entirely. RDT 3.0 adds a *Countdown Timer*. If an ACK is not received within a timeout duration, the sender retransmits the packet.

== Pipelined Reliable Protocols: Go-Back-N vs. Selective Repeat

Stop-and-wait yields abysmal link utilization on high-latency links ($U_("sender") = (L/R) / [text("RTT") + L/R]$). Modern transport protocols pipeline up to $N$ unacknowledged packets concurrently:

#table(
  columns: (1fr, 1.4fr, 1.4fr),
  fill: (x, y) => if y == 0 { crimson-main } else if calc.even(y) { warm-bg } else { white },
  stroke: 0.5pt + warm-border,
  align: (center, left, left),
  table.header(
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Dimension],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Go-Back-N (GBN)],
    text(font: ("Inter", "Liberation Sans"), weight: "bold", fill: white)[Selective Repeat (SR)],
  ),
  [*Window Size*], [Sender window of size $N$; Receiver window size = 1], [Sender window size = $N$; Receiver window size = $N$],
  [*Acknowledgment*], [*Cumulative ACK:* `ACK(n)` acknowledges all packets up to and including $n$], [*Individual ACK:* `ACK(n)` acknowledges only packet $n$],
  [*Timers*], [Single timer for oldest unacknowledged packet (`send_base`)], [Dedicated independent timer for every in-flight packet],
  [*Out-of-Order Packets*], [Discarded by receiver; receiver re-ACKs highest in-order packet], [Buffered in receiver memory until gaps are filled],
  [*Timeout Action*], [Retransmits *all* $N$ packets from `send_base` upward], [Retransmits *only* the single specific timed-out packet],
  [*Window Constraint*], [Window size $N < 2^k$ (where $k$ is sequence bit length)], [Window size $N <= 2^(k-1)$ to prevent sequence ambiguity],
)

#extra-pill
= 3.5 Fundamentals of TCP Connections & State Machines

TCP (RFC 793, 5681) provides a connection-oriented, reliable, in-order, byte-stream abstraction.

== TCP Segment Header Architecture

A standard TCP header is 20 bytes long (extensible to 60 bytes via options):
- #key-term[Sequence Number (32 bits):] The byte-stream number of the first data byte in this segment.
- #key-term[Acknowledgment Number (32 bits):] The next byte number the receiver is expecting (*cumulative ACK*).
- #key-term[Data Offset (4 bits):] Header length in 32-bit words (e.g., $5 times 4 = 20$ bytes).
- #key-term[Control Flags (6 bits):]
  - `SYN` (Synchronize sequence numbers during connection establishment).
  - `ACK` (Indicates the Acknowledgment Number field is valid).
  - `FIN` (Sender has finished sending data; initiates teardown).
  - `RST` (Reset connection due to abnormal condition or port mismatch).
  - `PSH` (Push data immediately to application without buffer wait).
  - `URG` (Urgent pointer field contains high-priority data offset).
- #key-term[Receive Window - `rwnd` (16 bits):] Buffer space currently available at receiver for flow control.
- #key-term[Checksum (16 bits):] 1's complement sum covering TCP header, data, and IP pseudo-header.

== Connection Establishment and Teardown

```
    CLIENT                                                  SERVER
      |                     [1] SYN (seq = x)                 |  (LISTEN)
      | ----------------------------------------------------> |
      |                                                       |  (SYN_RCVD)
      |                [2] SYN-ACK (seq = y, ack = x + 1)     |
      | <---------------------------------------------------- |
(ESTABLISHED)                                                 |
      |                     [3] ACK (ack = y + 1)             |
      | ----------------------------------------------------> |  (ESTABLISHED)
```

- #key-term[Three-Way Handshake:] Client sends `SYN(seq=x)`. Server allocates state and buffers, replying with `SYN-ACK(seq=y, ack=x+1)`. Client completes setup with `ACK(ack=y+1)`, carrying data if desired.
- #key-term[Four-Way Teardown:] Either end initiates closure by sending `FIN`. The peer replies with `ACK` and later its own `FIN`. The initiating client transitions to `TIME_WAIT` state for *2 MSL (Maximum Segment Lifetime, typically 60–120s)* to guarantee the final `ACK` is reliably received and drain stale segments from the network.

== Adaptive RTT Estimation & Timeout Calculations

TCP estimates Round-Trip Time dynamically using an Exponential Weighted Moving Average (EWMA):

#formula-box("TCP Adaptive Timeout Formulas", $
  text("EstimatedRTT") &= (1 - alpha) times text("EstimatedRTT") + alpha times text("SampleRTT") quad (alpha = 0.125) \
  text("DevRTT") &= (1 - beta) times text("DevRTT") + beta times |text("SampleRTT") - text("EstimatedRTT")| quad (beta = 0.25) \
  text("TimeoutInterval") &= text("EstimatedRTT") + 4 times text("DevRTT")
$)

#extra-pill
= 3.6 TCP Flow Control vs. Congestion Control

== Flow Control (Protecting the Receiver)

Flow control is a speed-matching service preventing a high-speed sender from overflowing a slow receiver's application buffer:
- The receiver advertises its spare buffer capacity in every ACK via the `Receive Window (rwnd)` header:

#formula-box("Flow Control Window Calculation", $ text("rwnd") = text("RcvBuffer") - [text("LastByteRcvd") - text("LastByteRead")] $)

- The sender guarantees that in-flight unacknowledged data never exceeds this bound: $[text("LastByteSent") - text("LastByteAcked")] <= text("rwnd")$.

== Congestion Control (Protecting the Network Fabric)

While flow control protects the receiver endpoint, congestion control prevents senders from saturating intermediate router buffers across the network core. Senders regulate rate using a variable *Congestion Window (`cwnd`)*:

#formula-box("TCP Transmission Rate Constraint", $ "In-Flight Data" <= min(text("cwnd"), text("rwnd")) $)

== TCP Congestion Control State Machine (AIMD)

1. #key-term[Slow Start:] Sender initializes $text("cwnd") = 1 text(" MSS")$. For every ACK received, $text("cwnd")$ increases by 1 MSS. Thus, $text("cwnd")$ doubles every RTT (exponential growth) until reaching the slow start threshold (`ssthresh`).
2. #key-term[Congestion Avoidance:] When $text("cwnd") >= text("ssthresh")$, exponential growth stops. $text("cwnd")$ increases linearly by $1 text(" MSS") / text("cwnd")$ per ACK, resulting in an increase of exactly *1 MSS per RTT* (*Additive Increase*).
3. #key-term[Handling Loss Events:]
   - *Loss via Timeout (Severe Congestion):* Sockets reset $text("ssthresh") = text("cwnd") / 2$ and plummet $text("cwnd") = 1 text(" MSS")$, restarting in Slow Start.
   - *Loss via 3 Duplicate ACKs (Mild Congestion):* Signals that later packets reached the receiver.
     - *TCP Tahoe:* Resets $text("cwnd") = 1 text(" MSS")$ unconditionally.
     - *TCP Reno:* Fast Retransmits missing packet, sets $text("ssthresh") = text("cwnd") / 2$, and enters *Fast Recovery* with $text("cwnd") = text("ssthresh") + 3 text(" MSS")$, continuing linear increase without dropping to 1 MSS (*Multiplicative Decrease*).

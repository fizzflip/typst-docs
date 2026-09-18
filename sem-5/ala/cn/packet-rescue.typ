#let meta = json("../../../misc/metadata.json")

#set page(
  paper: "a4",
  fill: rgb("#141414"), // Dark background
  margin: (x: 2.4cm, y: 2.4cm),
  footer: context {
    if here().page() > 2 {
      set text(size: 8.5pt, fill: rgb("#71717a"))
      [Computer Networks (BETCE15315) -- ALA II]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    }
  },
)

#set text(
  fill: rgb("#e4e4e7"), // High-contrast clean neutral text
  font: ("Magnisa Sans", "Times New Roman"),
  size: 10.5pt,
)

#set par(
  justify: true,
  leading: 0.68em,
  spacing: 1.05em,
)

#show heading: it => block(
  inset: (top: 1.1em, bottom: 0.4em),
  text(size: 1.35em, weight: "bold", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.85em, bottom: 0.3em),
  text(size: 1.15em, weight: "bold", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 3): it => block(
  inset: (top: 0.6em, bottom: 0.25em),
  text(size: 1.0em, weight: "bold", fill: rgb("#d4d4d8"), it.body),
)

// Clean Code Block Styling
#show raw.where(block: true): it => block(
  fill: rgb("#18181b"),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: 0.5pt + rgb("#27272a"),
  breakable: false,
  text(fill: rgb("#f4f4f5"), font: "DejaVu Sans Mono", size: 8.8pt, it),
)

#show raw.where(block: false): it => box(
  fill: rgb("#27272a"),
  inset: (x: 3.5pt, y: 0pt),
  outset: (y: 2pt),
  radius: 3pt,
  stroke: 0.4pt + rgb("#3f3f46"),
  text(fill: rgb("#fafafa"), font: "DejaVu Sans Mono", size: 9pt, it),
)

// Academic Figure Caption Styling
#show figure.caption: it => [
  #v(4pt)
  #set text(size: 8.5pt, style: "italic", fill: rgb("#a1a1aa"))
  #it
]

// Professional Note Box
#let note-box(title, body, border-color: rgb("#38bdf8")) = block(
  fill: rgb("#18181b"),
  inset: 10pt,
  radius: 4pt,
  stroke: (left: 3pt + border-color, rest: 0.5pt + rgb("#27272a")),
  width: 100%,
  [
    #text(weight: "bold", fill: rgb("#ffffff"), size: 9.5pt, title) \
    #v(0.25em)
    #text(size: 9.2pt, fill: rgb("#d4d4d8"), body)
  ],
)

// --- PAGE 1: COVER ---
#align(right)[
  #text(size: 44pt, weight: 900, font: "Magnisa Sans")[#meta.name]

  #v(-2.2em)
  #box[
    #set text(size: 18pt, font: "Arcon")
    #grid(
      columns: (auto, auto),
      align: (right, left),
      inset: (x: 0.6em, y: 0.2em),
      stroke: (x, y) => if x == 0 { (right: .5pt + rgb("#ffffff")) } else {
        none
      },
      [Computer Networks], [SUB],
      [#meta.roll_no], [#meta.ern],
      [#meta.section], [#meta.cla],
      [II], [#meta.ala],
    )
  ]
]

#v(1fr)
#align(left)[
  #set text(
    size: 40pt,
    font: "Mexcellent",
  )
  #set par(leading: 0.2em)
  PACKET \ RESCUE: \ vLAN CONFIG
]

#pagebreak()

// --- PAGE 2: TABLE OF CONTENTS ---
#v(1.5em)
#align(center)[
  #text(size: 2em, weight: "bold", fill: rgb("#ffffff"))[Table of Contents]
]
#v(1.2em)
#outline(title: none, indent: auto)

#pagebreak()

// --- PAGE 3: MAIN CONTENT ---
#counter(page).update(1)

= 1. Introduction

Modern enterprise networks partition hosts into Virtual Local Area Networks (VLANs) to enforce security perimeters, conserve bandwidth by dividing broadcast domains, and simplify administration. However, because VLANs operate as mutually isolated Layer 2 broadcast domains, end stations in separate VLANs cannot communicate directly at Layer 2. A Layer 3 device (a router or multilayer switch) is required to route IP packets between these domains.

This report documents the end-to-end design, implementation, and troubleshooting of an Inter-VLAN network using the Router-on-a-Stick (ROAS) architecture in Cisco Packet Tracer.

We establish the base working environment, intentionally introduce a realistic Layer 3 misconfiguration on a host gateway, apply a systematic OSI-model diagnostic workflow to isolate the root cause, rectify the issue, and provide comprehensive verification.



= 2. Objective

The core engineering objectives addressed in this simulation are:
1. *Topology Construction*: Assembling a physical and logical topology consisting of a Cisco 1941 router, a Cisco Catalyst 2960-24TT switch, and two client workstations.
2. *Layer 2 VLAN Segmentation*: Configuring port-based VLANs (`VLAN 10` for Sales and `VLAN 20` for Engineering) on switch access ports to enforce broadcast domain isolation.
3. *IEEE 802.1Q Trunking*: Provisioning an 802.1Q trunk link on switch port `GigabitEthernet0/1` connected to router physical interface `GigabitEthernet0/0` to multiplex tagged traffic over a single physical cable.
4. *Router-on-a-Stick Sub-interfaces*: Instantiating logical sub-interfaces `G0/0.10` and `G0/0.20` on the router, configuring dot1Q encapsulation, and assigning respective default gateway IP addresses.
5. *Fault Injection & Isolation*: Simulating a silent host default gateway misconfiguration, observing symptoms, and using ICMP (`ping`), route tracing (`tracert`), and interface audits (`ipconfig`) to isolate the failure.
6. *Remediation & Final Verification*: Applying targeted remediation and verifying full bidirectional inter-VLAN reachability.
#pagebreak()
= 3. Network Topology Diagram

The topology employs a central Layer 2 switch connected upstream to a router via an 802.1Q trunk, and downstream to two workstations via dedicated access links. The two departmental subnets are arranged with symmetrical, mirrored boundaries to ensure clean cable routing and visual clarity.

\

#figure(
  image("images/topology-diagram.svg", width: 98%),
  caption: [Cisco Packet Tracer Logical Workspace Topology showing Router-on-a-Stick, Catalyst Switch, \ and Mirrored Departmental VLAN Bounding Boxes.],
)
\
== 3.1 Network Devices and Roles

- *Router R1 (Cisco 1941 Integrated Services Router)*: Operates as the inter-VLAN router. Instead of using separate physical interfaces for each VLAN, `R1` uses a single physical interface (`GigabitEthernet0/0`) divided into virtual sub-interfaces `G0/0.10` and `G0/0.20`. Each sub-interface terminates the default gateway for its respective subnet and handles 802.1Q frame tagging and untagging.
- *Switch S1 (Cisco Catalyst 2960-24TT)*: Provides Layer 2 switching and segmentation. Ports `FastEthernet0/1` and `FastEthernet0/2` operate in access mode, assigned to VLAN 10 and VLAN 20. Port `GigabitEthernet0/1` is configured as an 802.1Q trunk port connected to `R1:G0/0`.
- *PC-A (Sales Workstation)*: Static IP `192.168.10.2/24`, connected to `S1:Fa0/1`. Default gateway is `192.168.10.1`.
- *PC-B (Engineering Workstation)*: Static IP `192.168.20.2/24`, connected to `S1:Fa0/2`. Default gateway is `192.168.20.1`.

#pagebreak()

= 4. IP Addressing Table

The private IPv4 address space `192.168.0.0/16` is subnetted into two discrete `/24` subnets. The first usable host address (`.1`) is assigned to the router sub-interface, and the second usable host address (`.2`) is assigned to the client workstation.

#align(center)[
  #table(
    columns: (1.1fr, 1.2fr, 1.5fr, 1.5fr, 1.5fr, 1.2fr),
    fill: (x, y) => if y == 0 { rgb("#1e293b") } else if calc.even(y) { rgb("#18181b") } else { rgb("#141414") },
    stroke: 0.5pt + rgb("#3f3f46"),
    align: (center + horizon),
    table.header([*Device*], [*Interface*], [*IP Address*], [*Subnet Mask*], [*Default Gateway*], [*VLAN Assignment*]),
    [R1], [G0/0.10], [`192.168.10.1`], [`255.255.255.0`], [N/A (Gateway)], [VLAN 10],
    [R1], [G0/0.20], [`192.168.20.1`], [`255.255.255.0`], [N/A (Gateway)], [VLAN 20],
    [S1], [G0/1], [802.1Q Trunk], [N/A], [N/A], [VLANs 1, 10, 20],
    [PC-A], [FastEthernet0], [`192.168.10.2`], [`255.255.255.0`], [`192.168.10.1`], [VLAN 10 (Access)],
    [PC-B], [FastEthernet0], [`192.168.20.2`], [`255.255.255.0`], [`192.168.20.1`], [VLAN 20 (Access)],
  )
]
#align(center)[#text(
  size: 8.5pt,
  style: "italic",
  fill: rgb("#a1a1aa"),
)[Table 1: Network IP Addressing, Subnetting, and Interface Allocation Scheme.]]

== 4.1 Subnet Architecture & Broadcast Domain Isolation

Applying a subnet mask of `255.255.255.0` (`/24`) provides 254 valid host addresses per subnet:
- *VLAN 10 Subnet*: `192.168.10.0/24` (Network: `192.168.10.0`, Usable: `192.168.10.1` -- `192.168.10.254`, Broadcast: `192.168.10.255`).
- *VLAN 20 Subnet*: `192.168.20.0/24` (Network: `192.168.20.0`, Usable: `192.168.20.1` -- `192.168.20.254`, Broadcast: `192.168.20.255`).

Because Layer 2 switches limit broadcast frames strictly to the originating VLAN, an ARP request transmitted by `PC-A` for any IP address outside `192.168.10.0/24` will never reach `PC-B`. Consequently, any inter-VLAN traffic must be routed through `R1`.

= 5. Implementation & Configuration Steps

Building and provisioning this simulated infrastructure required four sequential steps: physical cabling, switch configuration, router sub-interface provisioning, and client host configuration.

== 5.1 Physical Cabling

1. Connect `PC-A` FastEthernet port to switch port `Fa0/1` using a straight-through copper cable.
2. Connect `PC-B` FastEthernet port to switch port `Fa0/2` using a straight-through copper cable.
3. Connect switch port `GigabitEthernet0/1` to router port `GigabitEthernet0/0` using a straight-through copper cable.
4. Verify physical link status: link lights transition to solid green once Spanning Tree Protocol (STP) convergence finishes.
#pagebreak()
== 5.2 Switch (S1) Configuration

On switch `S1`, VLANs 10 and 20 are created in the database. Access ports are assigned to their respective VLANs, and the uplink port `GigabitEthernet0/1` is placed into 802.1Q trunk mode.

#figure(
  image("images/switch-config-cli.svg", width: 95%),
  caption: [Cisco Catalyst 2960 CLI Console Session showing VLAN and Trunk Port Provisioning.],
)
\
#note-box(
  "Core Switch IOS Configuration Commands",
  [
    - `vlan 10` / `vlan 20`: Creates the Layer 2 broadcast domains in the switch database.
    - `switchport mode access`: Configures the interface as an untagged access port.
    - `switchport access vlan <id>`: Binds the access port to the designated VLAN.
    - `switchport mode trunk`: Sets the uplink port `Gig0/1` to multiplex tagged 802.1Q frames.
    - `show interfaces trunk`: Verifies that `Gig0/1` is actively trunking with 802.1Q encapsulation.
  ],
  border-color: rgb("#4ade80"),
)

== 5.3 Router (R1) Configuration

On router `R1`, the base physical interface `GigabitEthernet0/0` is brought up without an IP address. Sub-interfaces `G0/0.10` and `G0/0.20` are instantiated. The `encapsulation dot1Q <vlan-id>` command instructs the router to tag and untag frames for that VLAN ID.

#figure(
  image("images/router-config-cli.svg", width: 95%),
  caption: [Cisco 1941 Router CLI Console Session showing Sub-interface Creation and Gateway Assignment.],
)
\
#note-box(
  "Core Router IOS Configuration Commands",
  [
    - `interface GigabitEthernet0/0` + `no shutdown`: Activates the physical carrier link.
    - `interface GigabitEthernet0/0.10`: Instantiates a virtual sub-interface dedicated to VLAN 10.
    - `encapsulation dot1Q 10`: Binds the sub-interface to IEEE 802.1Q VLAN tag 10.
    - `ip address 192.168.10.1 255.255.255.0`: Assigns the default gateway IP for the VLAN 10 subnet.
    - `encapsulation dot1Q 20` + `ip address 192.168.20.1 255.255.255.0`: Establishes the gateway for VLAN 20.
  ],
  border-color: rgb("#38bdf8"),
)

== 5.4 End-Host Static IP Configuration

With the network fabric active, static IP addressing is applied to both client workstations through the Packet Tracer Desktop `IP Configuration` applet:
- *PC-A*: IP Address: `192.168.10.2`, Subnet Mask: `255.255.255.0`, Default Gateway: `192.168.10.1`.
- *PC-B*: IP Address: `192.168.20.2`, Subnet Mask: `255.255.255.0`, Default Gateway: `192.168.20.1`.

#pagebreak()

= 6. Troubleshooting Scenario

Troubleshooting network anomalies requires a disciplined, structured methodology. In this section, an intentional configuration fault is introduced, diagnosed via standard utilities, and resolved.

== 6.1 The Injected Fault (The Break)

To simulate a common operational error encountered in enterprise environments, the default gateway of `PC-B` is intentionally set to an incorrect, non-existent IP address:

#note-box(
  "Injected Configuration Error",
  [
    - *Affected Device*: `PC-B` (Engineering Workstation)
    - *Original Default Gateway*: `192.168.20.1` (R1 Sub-interface `G0/0.20`)
    - *Injected Faulty Gateway*: `192.168.20.99` (Non-existent IP address on VLAN 20)
    - *Observed Symptom*: Cross-VLAN pings from `PC-A` to `PC-B` fail completely (`Request timed out`).
  ],
  border-color: rgb("#ef4444"),
)
\
#figure(
  image("images/pc-b-fault-ipconfig.svg", width: 95%),
  caption: [Packet Tracer PC-B IP Configuration Dialog displaying the Injected Faulty Default Gateway (192.168.20.99).],
)
#pagebreak()
== 6.2 Symptoms & Diagnostic Isolation

When an operator on `PC-A` attempts to communicate with `PC-B` using ICMP Echo Requests (`ping 192.168.20.2`), all four packets time out:

\

#figure(
  image("images/troubleshooting-failed-ping.svg", width: 95%),
  caption: [Diagnostic Capture: PC-A Command Prompt showing Ping Timeouts and PC-B IP Configuration Audit.],
)
\
To isolate the failure point, we executed a bottom-up OSI troubleshooting workflow:

#align(center)[
  #table(
    columns: (1.2fr, 1.8fr, 1.8fr, 1.2fr),
    fill: (x, y) => if y == 0 { rgb("#1e293b") } else if calc.even(y) { rgb("#18181b") } else { rgb("#141414") },
    stroke: 0.5pt + rgb("#3f3f46"),
    align: (center + horizon),
    table.header([*OSI Layer*], [*Diagnostic Check*], [*Observed Result*], [*Layer Health*]),
    [Layer 1 (Physical)], [Link status LEDs], [Solid green across all ports], [PASS],
    [Layer 2 (Data Link)], [`S1# show interfaces trunk`], [`Gig0/1` trunking, 802.1Q on], [PASS],
    [Layer 2 (Data Link)], [`S1# show vlan brief`], [`Fa0/1` in VLAN 10, `Fa0/2` in VLAN 20], [PASS],
    [Layer 3 (PC-A to GW)], [`ping 192.168.10.1`], [0% packet loss, `<1ms` latency], [PASS],
    [Layer 3 (PC-A to PC-B)], [`ping 192.168.20.2`], [100% loss (Request timed out)], [FAIL],
    [Layer 3 (PC-B Audit)], [`ipconfig` on `PC-B`], [Gateway: `192.168.20.99` (Invalid)], [ROOT CAUSE],
  )
]
#align(center)[#text(
  size: 8.5pt,
  style: "italic",
  fill: rgb("#a1a1aa"),
)[Table 2: Layered Diagnostic Matrix Isolating the Route Break.]]
#pagebreak()
== 6.3 Technical Root-Cause Mechanics: Asymmetric Return Path Failure

A common misconception in network troubleshooting is assuming that if a ping times out, the forward packet failed to reach the destination. In this scenario, packet tracing reveals an *asymmetric return path failure*:

1. `PC-A` (`192.168.10.2`) sends an ICMP Echo Request to `192.168.20.2`. Because the destination is off-subnet, `PC-A` sends the frame to its default gateway `192.168.10.1` (`R1`).
2. Switch `S1` receives the frame on port `Fa0/1` (VLAN 10), forwards it out trunk port `Gig0/1` with an 802.1Q tag (`VID=10`).
3. Router `R1` receives the tagged frame on sub-interface `G0/0.10`, strips the tag, consults its routing table, and determines that `192.168.20.0/24` is directly connected to `G0/0.20`.
4. `R1` prepends an 802.1Q tag (`VID=20`) and transmits the frame back down the trunk to `S1`. `S1` untags the frame and delivers it to `PC-B` on port `Fa0/2`.
5. *The Break Occurs on Return*: `PC-B` successfully *receives* the ICMP Echo Request. To send an ICMP Echo Reply back to `192.168.10.2`, `PC-B` checks its local routing table. Since `192.168.10.2` is on a different subnet, `PC-B` must forward the reply to its default gateway.
6. `PC-B` looks up its configured gateway: `192.168.20.99`. It checks its local ARP cache for `192.168.20.99`. Because no device has that IP, `PC-B` broadcasts an ARP Request: *"Who has 192.168.20.99? Tell 192.168.20.2"*.
7. Because IP `192.168.20.99` does not exist on the network, no ARP Reply is ever received. After exhausting ARP retransmissions, `PC-B` silently discards the ICMP Echo Reply.
8. `PC-A`'s ping timer expires, producing the symptom *"Request timed out"*.

== 6.4 The Solution & Remediation

To restore service, `PC-B`'s default gateway was corrected to point to the active router sub-interface gateway IP: `192.168.20.1`.

\

#figure(
  image("images/pc-b-resolved-ipconfig.svg", width: 95%),
  caption: [Packet Tracer PC-B IP Configuration Dialog with Corrected Default Gateway (192.168.20.1).],
)

#pagebreak()

= 7. Final Verification

With the default gateway repaired, end-to-end connectivity was comprehensively retested using ICMP ping and route tracing utilities.

== 7.1 ICMP Ping & Route Tracing Verification

From `PC-A`, two verification tests were conducted:
1. `tracert 192.168.20.2`: Verified the exact routing path. Hop 1 hits router gateway `192.168.10.1`, and Hop 2 reaches destination `192.168.20.2`.
2. `ping 192.168.20.2`: Verified round-trip packet transmission with 4 out of 4 successful replies (0% packet loss) and average latency of `<1ms`.
\
#figure(
  image("images/verification-ping-tracert.svg", width: 95%),
  caption: [Final End-to-End Verification on PC-A showing Successful Tracert (2 Hops) and Ping (0% Loss).],
)

#pagebreak()

== 7.2 Router State Verification

On router `R1`, the routing table and interface status confirm both sub-interfaces are functioning normally in an `up/up` operational state:

```bash
R1# show ip route
Codes: C - connected, S - static, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area

Gateway of last resort is not set

C    192.168.10.0/24 is directly connected, GigabitEthernet0/0.10
C    192.168.20.0/24 is directly connected, GigabitEthernet0/0.20

R1# show ip interface brief
Interface              IP-Address      OK? Method Status                Protocol
GigabitEthernet0/0     unassigned      YES manual up                    up
GigabitEthernet0/0.10  192.168.10.1    YES manual up                    up
GigabitEthernet0/0.20  192.168.20.1    YES manual up                    up
```

#v(0.5em)

= 8. Conclusion

This simulation lab demonstrated the complete lifecycle of network engineering: topology modeling, Layer 2 and Layer 3 provisioning, structured fault isolation, and verification.

In this exercise we covered:
1. *Efficiency of Router-on-a-Stick*: Rather than consuming multiple expensive physical router interfaces for every VLAN, the 802.1Q encapsulation protocol enables a single physical gigabit link to carry hundreds of virtual routed interfaces, significantly reducing hardware expenditure.
2. *Asymmetric Routing Vulnerability*: In IP networking, communication is fundamentally two-way. A host with an invalid default gateway can still receive inbound packets from other subnets, but it is completely incapable of returning responses. Understanding ARP resolution behavior is vital for diagnosing one-way communication failures.
3. *Systematic OSI Troubleshooting*: Jumping directly to reconfiguring router interfaces or replacing hardware wastes valuable time. By methodically verifying Layer 1 (link lights), Layer 2 (VLAN database and 802.1Q trunk status), and Layer 3 (host IP configuration and ARP), the root cause was accurately isolated within minutes without disrupting healthy network segments.

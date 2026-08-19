#import "@preview/cetz:0.3.3"
#let meta = json("../../../misc/metadata.json")

#let m(it) = box(
  fill: rgb("#1b1b1f"),
  inset: (x: 4pt, y: 0pt),
  outset: (y: 3pt),
  radius: 3pt,
  stroke: 0.2pt + rgb("#555"),
  text(fill: rgb("#ffffff"), font: "DejaVu Sans Mono", size: 9.5pt, it),
)

#set page(
  paper: "a4",
  fill: rgb("#141414"), // Dark background
  margin: (x: 2.5cm, y: 2.5cm),
  footer: context {
    if here().page() > 2 {
      set text(size: 9pt, fill: gray.lighten(30%))
      [Network Topologies Analysis -- CN]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    }
  },
)

#set text(
  fill: rgb("#f0f0f0"), // Light text
  font: ("Magnisa Sans", "Times New Roman"),
  size: 10.5pt,
)

#set par(
  justify: true,
  leading: 0.6em,
  spacing: 1.0em,
)

#show heading: it => block(
  inset: (top: 0.8em, bottom: 0.3em),
  text(size: 1.35em, weight: "bold", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.6em, bottom: 0.25em),
  text(size: 1.15em, weight: "bold", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 3): it => block(
  inset: (top: 0.4em, bottom: 0.2em),
  text(size: 1.0em, weight: "bold", fill: rgb("#38bdf8"), it.body),
)

// Custom code block styling
#show raw.where(block: true): it => block(
  fill: rgb("#1b1b1f"),
  inset: 8pt,
  radius: 6pt,
  width: 100%,
  stroke: 0.5pt + rgb("#333"),
  text(fill: rgb("#e0e0e0"), font: "DejaVu Sans Mono", size: 9pt, it),
)

// UI Badges & Cards
#let badge(body, fill: rgb("#1b1b1f"), text-color: rgb("#38bdf8")) = [
  #box(
    fill: fill,
    inset: (x: 7pt, y: 3pt),
    radius: 10pt,
    baseline: 0%,
    stroke: 0.4pt + text-color,
    text(fill: text-color, size: 7.5pt, weight: "bold", font: "DejaVu Sans Mono", body),
  )
]

#let metric-card(label, value, detail, color: rgb("#38bdf8")) = [
  #box(
    fill: rgb("#1b1b1f"),
    inset: 8pt,
    radius: 5pt,
    stroke: (left: 3.5pt + color, rest: 0.5pt + rgb("#333")),
    width: 100%,
    [
      #text(size: 7.5pt, weight: "bold", fill: color, hyphenate: false, upper(label)) \
      #v(1pt)
      #text(size: 12pt, weight: "bold", fill: rgb("#ffffff"), value) \
      #v(1pt)
      #text(size: 7.5pt, fill: rgb("#94a3b8"), hyphenate: false, detail)
    ],
  )
]

#let formula-box(title, formula, explanation) = [
  #box(
    fill: rgb("#1b1b1f"),
    inset: 8pt,
    radius: 5pt,
    stroke: (left: 3.5pt + rgb("#38bdf8"), rest: 0.5pt + rgb("#333")),
    width: 100%,
    [
      #text(weight: "bold", fill: rgb("#38bdf8"), size: 9pt, title)
      #v(0.15em)
      #align(center)[#math.equation(block: true, formula)]
      #v(0.1em)
      #text(size: 8.2pt, fill: rgb("#cbd5e1"), explanation)
    ],
  )
]

// --- PAGE 1: COVER ---
#align(right)[
  #text(size: 48pt, weight: 900, font: "Magnisa Sans")[#meta.name]

  #v(-2.5em)
  #box[
    #set text(size: 19pt, font: "Arcon")
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
      [I], [#meta.ala],
    )
  ]
]

#v(1fr)
#align(left)[
  #set text(
    size: 48pt,
    font: "Mexcellent",
  )
  #set par(leading: 0.2em)
  NETWORK \
  TOPOLOGIES \
  ANALYSIS
]

#pagebreak()

// --- PAGE 2: TABLE OF CONTENTS ---
#v(1.5em)
#align(center)[
  #text(size: 2em, weight: "bold")[Table of Contents]
]
#v(1em)
#outline(title: none, indent: auto)

#pagebreak()

// --- PAGE 3: MAIN CONTENT ---
#counter(page).update(1)

= Introduction to Network Topologies

A *Network Topology* defines how computers, switches, and routers link in a network. It sets physical wire paths. It shapes how data frames travel between active devices.

In network design, we evaluate two viewpoints:
- *Physical Topology*: The physical layout of cables, ports, and devices across a site.
- *Logical Topology*: The path data signals follow across wires as frames travel between hosts.

== Fundamental Graph Terminology

We model a network as a graph $G = (V, E)$ using five key terms:
1. *Node ($V$)*: A physical device like a computer, switch, or router.
2. *Link ($E$)*: The copper wire or fiber line that links two nodes.
3. *Node Degree ($d(v)$)*: The count of active links on a node. Central switches have high degree. Host PCs have a degree of 1.
4. *Network Diameter ($D$)*: The longest path in hops between two devices. Short diameter keeps packet delay low.
5. *Single Point of Failure (SPOF)*: A critical line or switch whose cut halts all traffic.

#v(0.6em)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 7pt,
  metric-card("Nodes (V)", "N Devices", "Computers, switches & routers", color: rgb("#38bdf8")),
  metric-card("Links (E)", "L(N) Cables", "Active copper or fiber lines", color: rgb("#2dd4bf")),
  metric-card("Network Diameter", "Max Hops", "Longest shortest path in network", color: rgb("#f59e0b")),
  metric-card("Fault Tolerance", "k Links", "Links cut before network splits", color: rgb("#ef4444")),
)


#v(0.6em)

= The Five Core Network Topologies

== 1. Bus Topology

In a *Bus Topology*, all computers link to one main cable. Old setups use thin coax cable with BNC taps. Both ends need $50 thin Omega$ resistors to stop signal bounce.

#v(0.2em)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // Drop lines
    line((-3.2, 0), (-3.2, -1.0), stroke: 1.2pt + rgb("#94a3b8"))
    line((-1.6, 0), (-1.6, 1.0), stroke: 1.2pt + rgb("#94a3b8"))
    line((1.6, 0), (1.6, -1.0), stroke: 1.2pt + rgb("#94a3b8"))
    line((3.2, 0), (3.2, 1.0), stroke: 1.2pt + rgb("#94a3b8"))

    // Backbone cable
    line((-4.5, 0), (4.5, 0), stroke: 3.2pt + rgb("#38bdf8"))

    // Terminators
    rect((-4.8, -0.22), (-4.5, 0.22), fill: rgb("#ef4444"), radius: 2pt)
    rect((4.5, -0.22), (4.8, 0.22), fill: rgb("#ef4444"), radius: 2pt)
    content((-4.65, -0.5), text(size: 7.5pt, weight: "bold", fill: rgb("#ef4444"), [50 Ω]))
    content((4.65, -0.5), text(size: 7.5pt, weight: "bold", fill: rgb("#ef4444"), [50 Ω]))

    // BNC T-Taps
    circle((-3.2, 0), radius: 0.09, fill: rgb("#f59e0b"), stroke: 1pt + rgb("#d97706"))
    circle((-1.6, 0), radius: 0.09, fill: rgb("#f59e0b"), stroke: 1pt + rgb("#d97706"))
    circle((1.6, 0), radius: 0.09, fill: rgb("#f59e0b"), stroke: 1pt + rgb("#d97706"))
    circle((3.2, 0), radius: 0.09, fill: rgb("#f59e0b"), stroke: 1pt + rgb("#d97706"))

    // Host boxes
    rect((-3.9, -1.6), (-2.5, -1.0), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#38bdf8"))
    content((-3.2, -1.3), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host A]))

    rect((-2.3, 1.0), (-0.9, 1.6), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#38bdf8"))
    content((-1.6, 1.3), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host B]))

    rect((0.9, -1.6), (2.3, -1.0), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#38bdf8"))
    content((1.6, -1.3), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host C]))

    rect((2.5, 1.0), (3.9, 1.6), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#38bdf8"))
    content((3.2, 1.3), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host D]))
  })
  #v(1pt)
  #text(
    size: 8pt,
    style: "italic",
    fill: rgb("#94a3b8"),
  )[Figure 1: Shared Coaxial Bus Topology with Drop Lines and 50 Ω Terminators.]
]

#v(0.2em)

- *How Data Moves*: A host sends data as signals down the main line. Every node hears the frame. Only the target host reads it.
- *Collisions & CSMA/CD*: All nodes share one line. Transmitting together causes a collision. Devices use *CSMA/CD*. They check the line first. They send a jam signal on collision. They wait a brief random backoff time before retrying.
- *Advantages*: It uses minimal wire ($L = N - 1$). Setup is simple, cheap, and fast for test rooms.
- *Disadvantages*: The main line is a single point of failure. One cut stops all traffic. Heavy traffic causes collisions that slow the whole line.

#v(0.6em)

== 2. Star Topology

In a *Star Topology*, each host links directly to a central switch. Every host gets a dedicated point-to-point cable.

#v(0.2em)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // Dedicated Point-to-Point Links
    line((0, 0.5), (0, 1.5), stroke: 1.4pt + rgb("#38bdf8"))
    line((-1.0, 0.3), (-1.6, 0.65), stroke: 1.4pt + rgb("#38bdf8"))
    line((-0.6, -0.5), (-1.1, -1.5), stroke: 1.4pt + rgb("#38bdf8"))
    line((0.6, -0.5), (1.1, -1.5), stroke: 1.4pt + rgb("#38bdf8"))
    line((1.0, 0.3), (1.6, 0.65), stroke: 1.4pt + rgb("#38bdf8"))

    // Central L2 Switch Box
    rect((-1.1, -0.5), (1.1, 0.5), fill: rgb("#1e293b"), radius: 4pt, stroke: 1.5pt + rgb("#60a5fa"))
    content((0, 0), text(size: 8.5pt, weight: "bold", fill: rgb("#ffffff"), [L2 Switch]))

    // Host Boxes
    rect((-0.6, 1.5), (0.6, 2.0), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#4ade80"))
    content((0, 1.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host 1]))

    rect((-2.8, 0.5), (-1.6, 1.0), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#4ade80"))
    content((-2.2, 0.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host 2]))

    rect((-1.9, -2.0), (-0.7, -1.5), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#4ade80"))
    content((-1.3, -1.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host 3]))

    rect((0.7, -2.0), (1.9, -1.5), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#4ade80"))
    content((1.3, -1.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host 4]))

    rect((1.6, 0.5), (2.8, 1.0), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#4ade80"))
    content((2.2, 0.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Host 5]))
  })
  #v(1pt)
  #text(
    size: 8pt,
    style: "italic",
    fill: rgb("#94a3b8"),
  )[Figure 2: Switched Star Topology featuring Dedicated Duplex Cables per Host.]
]

#v(0.2em)

- *How Data Moves*: The switch uses a *CAM table* to map host MAC addresses to ports. When Host 1 sends a frame to Host 4, the switch sends it straight to Port 4.
- *Advantages*: It isolates faults well. A broken cable affects only one host. Full-duplex lines stop collisions. Adding new nodes is quick and easy.
- *Disadvantages*: If the central switch fails, all data flow stops. Running $L = N$ cables to one rack uses more wire than a bus.

#v(0.6em)

== 3. Ring Topology

In a *Ring Topology*, each node links to two neighbors in a closed loop. Data frames travel in one fixed direction from host to host.

#v(0.2em)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // Ring Links
    line((0.6, 1.8), (1.4, 0.85), stroke: 1.6pt + rgb("#2dd4bf"))
    line((2.0, 0.5), (1.5, -1.5), stroke: 1.6pt + rgb("#2dd4bf"))
    line((0.7, -1.8), (-0.7, -1.8), stroke: 1.6pt + rgb("#2dd4bf"))
    line((-1.5, -1.5), (-2.0, 0.5), stroke: 1.6pt + rgb("#2dd4bf"))
    line((-1.4, 0.85), (-0.6, 1.8), stroke: 1.6pt + rgb("#2dd4bf"))

    // Token Arrow
    line((0.6, 2.1), (1.5, 1.1), stroke: 1.2pt + rgb("#2dd4bf"), mark: (end: ">", size: 0.12))
    content((1.9, 1.8), text(size: 7.5pt, weight: "bold", fill: rgb("#2dd4bf"), [Token Flow]))

    // Nodes
    rect((-0.6, 1.5), (0.6, 2.0), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#2dd4bf"))
    content((0, 1.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Node 1]))

    rect((-2.6, 0.5), (-1.4, 1.0), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#2dd4bf"))
    content((-2.0, 0.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Node 2]))

    rect((-1.9, -2.0), (-0.7, -1.5), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#2dd4bf"))
    content((-1.3, -1.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Node 3]))

    rect((0.7, -2.0), (1.9, -1.5), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#2dd4bf"))
    content((1.3, -1.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Node 4]))

    rect((1.4, 0.5), (2.6, 1.0), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#2dd4bf"))
    content((2.0, 0.75), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Node 5]))
  })
  #v(1pt)
  #text(
    size: 8pt,
    style: "italic",
    fill: rgb("#94a3b8"),
  )[Figure 3: Token Ring Topology showing Unidirectional Token Flow.]
]

#v(0.2em)

- *How Data Moves (Token Passing)*: A small control token circles the ring. Only the host holding the token sends data. The host attaches its frame to the token. It sends it around the loop. It releases a free token when the frame returns.
- *Dual-Ring Self-Healing (FDDI)*: High-speed FDDI fiber rings use two loops. Neighbor hosts wrap traffic onto the second ring if the main line breaks.
- *Advantages*: It gives equal access to all nodes. It limits worst-case wait time ($T_"wait, max"$). It prevents collisions.
- *Disadvantages*: In a single ring, one cut cable breaks the full loop. Delay grows as more nodes join the ring ($O(N)$ hops).

// #v(0.6em)
#pagebreak()

== 4. Full Mesh Topology

In a *Full Mesh Topology*, every computer connects directly to all other nodes. There are no shared lines. There are no central switches.

#v(0.2em)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // Links
    line((-0.7, 1.6), (-1.4, 0.9), stroke: 0.8pt + rgb("#64748b"))
    line((-0.3, 1.6), (-1.0, -1.4), stroke: 0.8pt + rgb("#64748b"))
    line((0.3, 1.6), (1.0, -1.4), stroke: 0.8pt + rgb("#64748b"))
    line((0.7, 1.6), (1.4, 0.9), stroke: 0.8pt + rgb("#64748b"))
    line((-2.0, 0.4), (-1.6, -1.4), stroke: 0.8pt + rgb("#64748b"))
    line((-1.4, 0.5), (0.6, -1.5), stroke: 0.8pt + rgb("#64748b"))
    line((-1.4, 0.7), (1.4, 0.7), stroke: 0.8pt + rgb("#64748b"))
    line((-0.6, -1.7), (0.6, -1.7), stroke: 0.8pt + rgb("#64748b"))
    line((-0.6, -1.5), (1.4, 0.5), stroke: 0.8pt + rgb("#64748b"))
    line((1.6, -1.4), (2.0, 0.4), stroke: 0.8pt + rgb("#64748b"))

    // Routers
    rect((-0.7, 1.6), (0.7, 2.1), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.4pt + rgb("#f87171"))
    content((0, 1.85), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Router A]))

    rect((-2.7, 0.4), (-1.4, 0.9), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.4pt + rgb("#f87171"))
    content((-2.05, 0.65), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Router B]))

    rect((-1.9, -1.9), (-0.6, -1.4), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.4pt + rgb("#f87171"))
    content((-1.25, -1.65), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Router C]))

    rect((0.6, -1.9), (1.9, -1.4), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.4pt + rgb("#f87171"))
    content((1.25, -1.65), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Router D]))

    rect((1.4, 0.4), (2.7, 0.9), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.4pt + rgb("#f87171"))
    content((2.05, 0.65), text(size: 8pt, weight: "bold", fill: rgb("#ffffff"), [Router E]))
  })
  #v(1pt)
  #text(size: 8pt, style: "italic", fill: rgb("#94a3b8"))[Figure 4: Complete Graph ($K_5$) Full Mesh Topology.]
]

#v(0.2em)

- *How Data Moves*: Each node sends frames straight to its target over a private line. The path is always 1 hop.
- *Link Formula*: For $N$ nodes, total link count is:
  $ L = (N(N - 1)) / 2 $
  Each node needs $N - 1$ active ports.
- *Advantages*: It offers maximum fault tolerance ($k = N - 1$). It eliminates line contention. Traffic reroutes instantly if a line breaks.
- *Disadvantages*: It requires many cables ($O(N^2)$ growth). It is expensive and complex outside core ISP backbones and cloud server hubs.

#v(0.6em)

== 5. Hybrid Topology

A *Hybrid Topology* combines two or more basic topologies. It links department star switches across a high-speed fiber backbone.

#v(0.2em)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // Core Backbone Line
    line((-3.8, 0), (3.8, 0), stroke: 2.8pt + rgb("#a855f7"))
    content((0, 0.25), text(size: 8pt, weight: "bold", fill: rgb("#c084fc"), [Core Fiber Backbone Bus]))

    // Subnet 1 (Engineering)
    line((-2.2, 0), (-2.2, -0.9), stroke: 1.2pt + rgb("#94a3b8"))
    rect((-3.0, -1.35), (-1.4, -0.9), fill: rgb("#1b1b1f"), radius: 3pt, stroke: 1.2pt + rgb("#60a5fa"))
    content((-2.2, -1.12), text(size: 7.5pt, weight: "bold", fill: rgb("#ffffff"), [Eng Switch]))
    line((-2.2, -1.35), (-2.9, -1.95), stroke: 1pt + rgb("#60a5fa"))
    line((-2.2, -1.35), (-1.5, -1.95), stroke: 1pt + rgb("#60a5fa"))
    circle((-2.9, -2.15), radius: 0.22, fill: rgb("#1b1b1f"), stroke: 1pt + rgb("#60a5fa"))
    circle((-1.5, -2.15), radius: 0.22, fill: rgb("#1b1b1f"), stroke: 1pt + rgb("#60a5fa"))
    content((-2.9, -2.15), text(size: 7pt, weight: "bold", fill: rgb("#ffffff"), [H1]))
    content((-1.5, -2.15), text(size: 7pt, weight: "bold", fill: rgb("#ffffff"), [H2]))

    // Subnet 2 (Finance)
    line((2.2, 0), (2.2, -0.9), stroke: 1.2pt + rgb("#94a3b8"))
    rect((1.4, -1.35), (3.0, -0.9), fill: rgb("#1b1b1f"), radius: 3pt, stroke: 1.2pt + rgb("#4ade80"))
    content((2.2, -1.12), text(size: 7.5pt, weight: "bold", fill: rgb("#ffffff"), [Fin Switch]))
    line((2.2, -1.35), (1.5, -1.95), stroke: 1pt + rgb("#4ade80"))
    line((2.2, -1.35), (2.9, -1.95), stroke: 1pt + rgb("#4ade80"))
    circle((1.5, -2.15), radius: 0.22, fill: rgb("#1b1b1f"), stroke: 1pt + rgb("#4ade80"))
    circle((2.9, -2.15), radius: 0.22, fill: rgb("#1b1b1f"), stroke: 1pt + rgb("#4ade80"))
    content((1.5, -2.15), text(size: 7pt, weight: "bold", fill: rgb("#ffffff"), [H3]))
    content((2.9, -2.15), text(size: 7pt, weight: "bold", fill: rgb("#ffffff"), [H4]))
  })
  #v(1pt)
  #text(
    size: 8pt,
    style: "italic",
    fill: rgb("#94a3b8"),
  )[Figure 5: Enterprise Hybrid Network combining Departmental Stars with a Fiber Backbone Bus.]
]

#v(0.2em)

- *How Data Moves*: Local traffic stays inside department switches. Frames for other sites travel over fiber uplink lines across the main backbone.
- *VLAN Segmentation (IEEE 802.1Q)*: Switches use Virtual LANs (VLANs) to split broadcast traffic. This keeps finance data safe from general engineering files.
- *Advantages*: It is flexible and modular. Network teams can add new star clusters without stopping site traffic.
- *Disadvantages*: It requires managed switches, Layer-3 routers, and careful setup to manage VLAN boundaries and avoid routing loops.

#v(0.8em)

= Performance and Fault Tolerance

== 1. Cable Count Growth: Linear vs. Quadratic

How many cables do you need as a local network expands from 5 to 500 computers across a site?

#formula-box(
  "Link Formulas for N Nodes",
  $ L_"Bus" = N - 1, quad L_"Star" = N, quad L_"Ring" = N, quad L_"Mesh" = (N(N-1))/2 $,
  "Bus, Star, and Ring grow linearly with O(N) links, while Full Mesh grows quadratically with O(N²) lines.",
)

#v(0.3em)

#set table(inset: 0.5em, stroke: 0.5pt + gray)
#align(center)[
  #table(
    columns: (1.2fr, 1fr, 1fr, 1fr, 1fr, 1.2fr),
    fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else if calc.odd(y) { rgb("#19191d") } else { rgb("#141414") },
    [*Node Scale ($N$)*], [*Bus ($N-1$)*], [*Star ($N$)*], [*Ring ($N$)*], [*Full Mesh*], [*Mesh vs. Star*],
    [5 Nodes], [4], [5], [5], [10], [2.0 $times$ more],
    [10 Nodes], [9], [10], [10], [45], [4.5 $times$ more],
    [25 Nodes], [24], [25], [25], [300], [12.0 $times$ more],
    [50 Nodes], [49], [50], [50], [1,225], [24.5 $times$ more],
    [100 Nodes], [99], [100], [100], [4,950], [49.5 $times$ more],
    [500 Nodes], [499], [500], [500], [124,750], [249.5 $times$ more],
  )
]

#v(0.4em)

== 2. Fault Tolerance Comparison (What Happens When a Cable Breaks?)

#set table(inset: 0.5em, stroke: 0.5pt + gray)
#align(center)[
  #table(
    columns: (1.2fr, 1fr, 1.4fr, 2.0fr, 1.2fr),
    fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else if calc.odd(y) { rgb("#19191d") } else { rgb("#141414") },
    [*Topology*], [*Link Cuts ($k$)*], [*Single Point of Failure*], [*Effect of 1 Broken Cable*], [*Network Impact*],
    [Bus], [$k = 1$], [Main Backbone Cable], [Reflections destroy signals; entire bus halts], [100% Outage],
    [Star], [$k = 1$], [Central Switch], [Only the disconnected device goes offline], [Isolated to 1 host],
    [Single Ring], [$k = 1$], [Any Ring Cable], [Token loop is broken; entire ring halts], [100% Outage],
    [Dual Ring], [$k = 2$], [Both Ring Cables], [Secondary ring wraps around the break], [0% Disruption],
    [Full Mesh], [$k = N - 1$], [None], [Traffic instantly reroutes over alternate links], [0% Disruption],
    [Hybrid],
    [$k = 1$ (Backbone)],
    [Core Backbone Link],
    [Isolates subnets, but local stars keep running],
    [Localized outage],
  )
]

#pagebreak()

= Comparison Matrix

#set table(inset: 0.45em, stroke: 0.5pt + gray)
#align(center)[
  #table(
    columns: (1fr, 0.8fr, 0.7fr, 0.9fr, 1.1fr, 1.0fr, 1fr, 1.5fr),
    fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else if calc.odd(y) { rgb("#19191d") } else { rgb("#141414") },
    [*Topology*],
    [*Links*],
    [*Diameter*],
    [*SPOF Risk*],
    [*Fault Isolation*],
    [*Collisions*],
    [*Cable Cost*],
    [*Primary Real-World Use*],

    [#text(weight: "bold")[Bus]],
    [\ $N - 1$],
    [\ $N - 1$],
    [#badge("HIGH", fill: rgb("#7f1d1d"), text-color: rgb("#fca5a5"))],
    [\ Poor],
    [Yes \ (CSMA/CD)],
    [#badge("LOWEST", fill: rgb("#14532d"), text-color: rgb("#86efac"))],
    [Legacy lab networks, simple sensor buses.],

    [#text(weight: "bold")[Star]],
    [\ $N$],
    [$1$ \ (Switch)],
    [#badge("MEDIUM", fill: rgb("#713f12"), text-color: rgb("#fde047"))],
    [\ Excellent],
    [None (Full Duplex)],
    [#badge("MEDIUM", fill: rgb("#713f12"), text-color: rgb("#fde047"))],
    [Standard modern office LANs, Wi-Fi homes.],

    [#text(weight: "bold")[Ring]],
    [\ $N$],
    [\ $floor(N/2)$],
    [#badge("HIGH", fill: rgb("#7c2d12"), text-color: rgb("#fdba74"))],
    [Moderate (Dual Ring)],
    [None \ (Token Passing)],
    [#badge("MEDIUM", fill: rgb("#713f12"), text-color: rgb("#fde047"))],
    [Metropolitan fiber backbones (FDDI/SONET).],

    [#text(weight: "bold")[Full Mesh]],
    [ \ $(N(N-1))/2$],
    [\ $1$],
    [#badge("NONE", fill: rgb("#14532d"), text-color: rgb("#86efac"))],
    [\ Maximum],
    [None \ (Dedicated)],
    [#badge("HIGHEST", fill: rgb("#7f1d1d"), text-color: rgb("#fca5a5"))],
    [Core ISP router backbones, cloud datacenters.],

    [#text(weight: "bold")[Hybrid]],
    [\ Varies],
    [\ $2 - 4$],
    [#badge("LOW", fill: rgb("#14532d"), text-color: rgb("#86efac"))],
    [\ High],
    [None (Switched)],
    [#badge("MEDIUM", fill: rgb("#713f12"), text-color: rgb("#fde047"))],
    [Multi-building university campuses & enterprises.],
  )
]

#v(0.8em)

= Conclusion

== 1. Decision Flowchart for Network Design

#v(0.3em)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // Decision 1
    rect((-2.4, 1.8), (2.4, 2.5), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#38bdf8"))
    content((0, 2.15), text(size: 8.5pt, weight: "bold", fill: rgb("#ffffff"), [Is Zero Downtime Critical?]))

    line((0, 1.8), (0, 1.1), stroke: 1pt + rgb("#94a3b8"), mark: (end: ">"))
    content((0.3, 1.45), text(size: 7.5pt, fill: rgb("#f87171"), [NO]))

    line((2.4, 2.15), (3.6, 2.15), stroke: 1pt + rgb("#4ade80"), mark: (end: ">"))
    content((3.0, 2.3), text(size: 7.5pt, fill: rgb("#4ade80"), [YES]))
    rect((3.7, 1.8), (5.6, 2.5), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#4ade80"))
    content((4.65, 2.15), text(size: 8pt, weight: "bold", fill: rgb("#4ade80"), [Mesh Topology]))

    // Decision 2
    rect((-2.4, 0.4), (2.4, 1.1), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#38bdf8"))
    content((0, 0.75), text(size: 8.5pt, weight: "bold", fill: rgb("#ffffff"), [Multi-Building Campus?]))

    line((0, 0.4), (0, -0.3), stroke: 1pt + rgb("#94a3b8"), mark: (end: ">"))
    content((0.3, 0.05), text(size: 7.5pt, fill: rgb("#dc2626"), [NO]))

    line((2.4, 0.75), (3.6, 0.75), stroke: 1pt + rgb("#16a34a"), mark: (end: ">"))
    content((3.0, 0.9), text(size: 7.5pt, fill: rgb("#16a34a"), [YES]))
    rect((3.7, 0.4), (5.6, 1.1), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#4ade80"))
    content((4.65, 0.75), text(size: 8pt, weight: "bold", fill: rgb("#4ade80"), [Hybrid Topology]))

    // Node 3 (Star)
    rect((-2.4, -1.0), (2.4, -0.3), fill: rgb("#1b1b1f"), radius: 4pt, stroke: 1.2pt + rgb("#4ade80"))
    content((0, -0.65), text(size: 8.5pt, weight: "bold", fill: rgb("#4ade80"), [Switched Star Topology]))
  })
  #v(2pt)
  #text(
    size: 8.5pt,
    style: "italic",
    fill: rgb("#94a3b8"),
  )[Figure 6: Decision Tree for Choosing Network Topologies Based on Budget and Uptime Needs.]
]

#v(0.4em)

== 2. Engineering Selection Rules of Thumb

1. *Use Star for Standard LANs*: It is the best choice for home and office rooms because one bad drop wire will never bring down any other computer on the floor.
2. *Use Mesh for Core High-Uptime Systems*: When zero downtime is critical in ISP core routers and cloud server hubs, mesh links give instant rerouting despite high cable costs.
3. *Use Hybrid for Multi-Building Campuses*: Linking local star switches to a fast fiber backbone provides the best blend of modular growth, ease of management, and low cost.

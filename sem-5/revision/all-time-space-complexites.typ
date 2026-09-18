#set page(
  paper: "a4",
  flipped: true,
  margin: (x: 0.8cm, top: 0.55cm, bottom: 0.5cm),
  footer: context {
    grid(
      columns: (1fr, 1fr),
      align(left)[#text(
        size: 6.6pt,
        fill: rgb("#64748b"),
      )[Semester 5 - ADA Revision Cheatsheet]],
      align(right)[#text(
        size: 6.6pt,
        fill: rgb("#64748b"),
      )[Space column = *auxiliary* space (extra memory beyond the input)]],
    )
  },
)

#set text(
  font: ("Aptos", "Arial", "Liberation Sans", "DejaVu Sans"),
  size: 7.2pt,
  fill: rgb("#0f172a"),
  hyphenate: false,
)
#set par(leading: 0.5em)

// --- BADGE AND PILL HELPERS ---
#let pill(bg, fg, body) = box(
  fill: bg,
  radius: 2.5pt,
  inset: (x: 3pt, y: 1.5pt),
  outset: 0pt,
  baseline: 0%,
  [#text(fill: fg, weight: "bold", size: 6.6pt)[#body]],
)

#let b-const(body) = pill(rgb("#dcfce7"), rgb("#15803d"), body) // Green: O(1), O(log n)
#let b-linear(body) = pill(rgb("#e0f2fe"), rgb("#0369a1"), body) // Blue: O(n), O(n+k)
#let b-nlogn(body) = pill(rgb("#fef3c7"), rgb("#b45309"), body) // Amber: O(n log n)
#let b-poly(body) = pill(rgb("#ffedd5"), rgb("#c2410c"), body) // Orange: O(n^2), O(n^3)
#let b-exp(body) = pill(rgb("#fee2e2"), rgb("#b91c1c"), body) // Red: O(2^n), O(n!)
#let b-space(body) = pill(rgb("#f1f5f9"), rgb("#475569"), body) // Neutral slate

// --- CARD CONTAINER ---
#let card(title, tag, accent-color, bg-color, border-color, body) = block(
  width: 100%,
  stroke: 0.8pt + border-color,
  radius: 4pt,
  clip: true,
  fill: white,
  [
    #block(
      width: 100%,
      fill: bg-color,
      inset: (x: 6pt, y: 3.2pt),
      stroke: (bottom: 0.8pt + border-color),
      [
        #grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          [
            #text(weight: "bold", size: 7.6pt, fill: accent-color)[#title]
          ],
          [
            #if tag != none [
              #box(
                fill: accent-color,
                radius: 2pt,
                inset: (x: 4pt, y: 1.2pt),
                [#text(size: 5.8pt, fill: white, weight: "bold")[#tag]],
              )
            ]
          ],
        )
      ],
    )
    #pad(x: 2.5pt, y: 2.5pt, body)
  ],
)

// --- COMPLEXITY TABLE HELPER ---
#let alg(name) = text(weight: "semibold", size: 6.8pt)[#name]

#let comp-table(rows) = table(
  columns: (1.62fr, 1fr, 1fr, 1fr, 0.92fr),
  stroke: none,
  fill: (col, row) => if row == 0 { rgb("#f1f5f9") } else if calc.odd(row) { rgb("#ffffff") } else {
    rgb("#f8fafc")
  },
  align: (col, row) => if col == 0 { left + horizon } else { center + horizon },
  inset: (x: 2pt, y: 2.1pt),
  table.header(
    text(weight: "bold", size: 6.4pt, fill: rgb("#334155"))[Algorithm],
    text(weight: "bold", size: 6.4pt, fill: rgb("#334155"))[Best],
    text(weight: "bold", size: 6.4pt, fill: rgb("#334155"))[Average],
    text(weight: "bold", size: 6.4pt, fill: rgb("#334155"))[Worst],
    text(weight: "bold", size: 6.4pt, fill: rgb("#334155"))[Aux. Space],
  ),
  table.hline(stroke: 0.7pt + rgb("#cbd5e1")),
  ..rows,
)

// --- GROWTH CURVE PLOT (drawn natively, no packages) ---
#let growth-plot(w, h) = {
  let nmax = 12.0
  let ymax = 46.0
  // (colour, f(n), label, anchor-n, anchor-value, dx, dy)
  let series = (
    (rgb("#b91c1c"), n => calc.pow(2.0, n), [$O(2^n)$], 3.9, 15.0, -21pt, -3pt),
    (rgb("#c2410c"), n => n * n, [$O(n^2)$], 5.4, 29.0, 3pt, -3pt),
    (rgb("#b45309"), n => n * calc.log(n + 1.0, base: 2.0), [$O(n log n)$], 10.4, 36.0, -29pt, -2pt),
    (rgb("#0369a1"), n => n, [$O(n)$], 12.0, 12.0, -20pt, -8pt),
    (rgb("#0891b2"), n => calc.log(n + 1.0, base: 2.0), [$O(log n)$], 12.0, 3.7, -25pt, -8.5pt),
    (rgb("#15803d"), n => 1.0, [$O(1)$], 1.2, 1.0, 0pt, -8pt),
  )
  let px(n) = w * (n / nmax)
  let py(v) = h - h * (calc.min(v, ymax) / ymax)

  box(width: w, height: h, {
    place(rect(width: w, height: h, fill: rgb("#fcfdff"), stroke: 0.5pt + rgb("#e2e8f0"), radius: 2pt))
    for f in (0.25, 0.5, 0.75) {
      place(dy: h * f, line(length: w, stroke: 0.35pt + rgb("#eef2f7")))
    }
    for (col, f, label, an, av, ldx, ldy) in series {
      let steps = 110
      let prev = none
      for i in range(0, steps + 1) {
        let n = nmax * i / steps
        let v = f(n)
        let pt = (px(n), py(v))
        if prev != none and v <= ymax {
          place(
            dx: prev.at(0),
            dy: prev.at(1),
            line(end: (pt.at(0) - prev.at(0), pt.at(1) - prev.at(1)), stroke: 1.1pt + col),
          )
        }
        prev = pt
      }
      place(
        dx: px(an) + ldx,
        dy: calc.max(py(av) + ldy, 0.5pt),
        text(size: 5.6pt, weight: "bold", fill: col)[#label],
      )
    }
  })
}

// --- TOP BANNER ---
#block(
  width: 100%,
  fill: rgb("#0f172a"),
  radius: 4pt,
  inset: (x: 10pt, y: 5pt),
  [
    #grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      [
        #text(weight: "extrabold", size: 11pt, fill: white)[Analysis & Design of Algorithms (ADA)]
        // #h(8pt)
        // #text(
        //   weight: "medium",
        //   size: 8pt,
        //   fill: rgb("#94a3b8"),
        // )[• Semester 5 Master Complexity Cheatsheet (Units 2 – 5)]
      ],
      [
        #grid(
          columns: (auto, auto, auto, auto, auto),
          gutter: 4pt,
          b-const[● Excellent: $O(1)$, $O(log n)$],
          b-linear[● Good: $O(n)$],
          b-nlogn[● Fair: $O(n log n)$],
          b-poly[● Bad: $O(n^2)$, $O(n^3)$],
          b-exp[● Worst: $O(2^n)$, $O(n!)$],
        )
      ],
    )
  ],
)

#v(3pt)

// --- BIG-O GROWTH SCALE BAR ---
#block(
  width: 100%,
  fill: rgb("#f8fafc"),
  stroke: 0.7pt + rgb("#e2e8f0"),
  radius: 3.5pt,
  inset: (x: 8pt, y: 3pt),
  [
    #align(center)[
      #text(weight: "bold", size: 6.8pt, fill: rgb("#475569"))[BIG-O GROWTH SCALE:]
      #h(5pt)
      #b-const[$O(1)$] #text(size: 6.5pt)[$<$]
      #b-const[$O(log n)$] #text(size: 6.5pt)[$<$]
      #b-linear[$O(n)$] #text(size: 6.5pt)[$<$]
      #b-nlogn[$O(n log n)$] #text(size: 6.5pt)[$<$]
      #b-poly[$O(n^(4/3))$] #text(size: 6.5pt)[$<$]
      #b-poly[$O(n^2)$] #text(size: 6.5pt)[$<$]
      #b-poly[$O(n^(2.81))$] #text(size: 6.5pt)[$<$]
      #b-poly[$O(n^3)$] #text(size: 6.5pt)[$<$]
      #b-exp[$O(2^n)$] #text(size: 6.5pt)[$<$]
      #b-exp[$O(n!)$]
      #h(12pt)
      #text(
        size: 6.4pt,
        fill: rgb("#64748b"),
      )[Iterative BS: $O(1)$ space | Recursive BS: $O(log n)$ | QuickSort stack: $O(log n)$ avg, $O(n)$ worst]
    ]
  ],
)

#v(3.5pt)

// --- MAIN 3-COLUMN BODY ---
#grid(
  columns: (1.02fr, 1.02fr, 1.02fr),
  gutter: 6.5pt,
  [
    // COLUMN 1: UNIT 2
    #card(
      [1. Searching, Sorting & Graph Traversal],
      [UNIT 2],
      rgb("#1d4ed8"),
      rgb("#eff6ff"),
      rgb("#bfdbfe"),
      [
        #comp-table((
          alg[Linear Search],
          b-const[$O(1)$],
          b-linear[$O(n)$],
          b-linear[$O(n)$],
          b-space[$O(1)$],
          alg[Binary Search],
          b-const[$O(1)$],
          b-const[$O(log n)$],
          b-const[$O(log n)$],
          b-space[$O(1)$],
          alg[Bubble Sort],
          b-linear[$O(n)$],
          b-poly[$O(n^2)$],
          b-poly[$O(n^2)$],
          b-space[$O(1)$],
          alg[Selection Sort],
          b-poly[$O(n^2)$],
          b-poly[$O(n^2)$],
          b-poly[$O(n^2)$],
          b-space[$O(1)$],
          alg[Insertion Sort],
          b-linear[$O(n)$],
          b-poly[$O(n^2)$],
          b-poly[$O(n^2)$],
          b-space[$O(1)$],
          alg[Heap Sort],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-space[$O(1)$],
          alg[Shell Sort],
          b-nlogn[$O(n log n)$],
          b-poly[$O(n^(4/3))$],
          b-poly[$O(n^2)$],
          b-space[$O(1)$],
          alg[Bucket Sort],
          b-linear[$O(n+k)$],
          b-linear[$O(n+k)$],
          b-poly[$O(n^2)$],
          b-space[$O(n+k)$],
          alg[Radix Sort],
          b-linear[$O(n k)$],
          b-linear[$O(n k)$],
          b-linear[$O(n k)$],
          b-space[$O(n+k)$],
          alg[Counting Sort],
          b-linear[$O(n+k)$],
          b-linear[$O(n+k)$],
          b-linear[$O(n+k)$],
          b-space[$O(k)$],
          alg[DFS Traversal],
          b-linear[$O(V+E)$],
          b-linear[$O(V+E)$],
          b-linear[$O(V+E)$],
          b-space[$O(V)$],
          alg[BFS Traversal],
          b-linear[$O(V+E)$],
          b-linear[$O(V+E)$],
          b-linear[$O(V+E)$],
          b-space[$O(V)$],
          alg[Topological Sort],
          b-linear[$O(V+E)$],
          b-linear[$O(V+E)$],
          b-linear[$O(V+E)$],
          b-space[$O(V)$],
        ))
      ],
    )

    #v(3.5pt)

    // GROWTH VISUALISER + FEASIBILITY BUDGET
    #card(
      [Growth Curves & Practical Input Limits],
      [VISUAL],
      rgb("#334155"),
      rgb("#f8fafc"),
      rgb("#cbd5e1"),
      [
        #pad(x: 3.5pt, y: 1pt, [
          #grid(
            columns: (1fr, auto),
            gutter: 5pt,
            align: (left + horizon, left + horizon),
            growth-plot(133pt, 74pt),
            [
              #text(size: 5.9pt, weight: "bold", fill: rgb("#334155"))[Largest $n$ solvable\ in \~1 second]
              #v(1.5pt)
              #table(
                columns: (auto, auto),
                stroke: none,
                inset: (x: 2pt, y: 1.05pt),
                align: (left + horizon, right + horizon),
                b-exp[$O(n!)$], text(size: 6.2pt)[$n <= 11$],
                b-exp[$O(2^n)$], text(size: 6.2pt)[$n <= 25$],
                b-poly[$O(n^3)$], text(size: 6.2pt)[$n <= 500$],
                b-poly[$O(n^2)$], text(size: 6.2pt)[$n <= 10^4$],
                b-nlogn[$O(n log n)$], text(size: 6.2pt)[$n <= 10^6$],
                b-linear[$O(n)$], text(size: 6.2pt)[$n <= 10^8$],
                b-const[$O(log n)$], text(size: 6.2pt)[huge],
              )
            ],
          )
          #v(1.5pt)
          #text(
            size: 5.9pt,
            fill: rgb("#64748b"),
          )[Horizontal axis = input size $n$, vertical axis = work done. Budget assumes \~$10^8$ operations per second; constants still matter for small $n$ (Insertion Sort beats Merge Sort below \~$n = 20$).]
        ])
      ],
    )
  ],
  [
    // COLUMN 2: UNIT 3 + UNIT 5
    #card(
      [2. Divide & Conquer and Greedy Algorithms],
      [UNIT 3],
      rgb("#047857"),
      rgb("#ecfdf5"),
      rgb("#a7f3d0"),
      [
        #comp-table((
          alg[Max-Min (D&C)],
          b-linear[$O(n)$],
          b-linear[$O(n)$],
          b-linear[$O(n)$],
          b-space[$O(log n)$],
          alg[Merge Sort],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-space[$O(n)$],
          alg[Quick Sort],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-poly[$O(n^2)$],
          b-space[$O(log n)$],
          alg[Strassen Matrix],
          b-poly[$O(n^(2.81))$],
          b-poly[$O(n^(2.81))$],
          b-poly[$O(n^(2.81))$],
          b-space[$O(n^2)$],
          alg[Coin Change (Grdy)],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-space[$O(1)$],
          alg[Activity Selection],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-space[$O(1)$],
          alg[Fractional Knapsack],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-space[$O(1)$],
          alg[Job Sequencing],
          b-nlogn[$O(n log n)$],
          b-poly[$O(n^2)$],
          b-poly[$O(n^2)$],
          b-space[$O(n)$],
          alg[Huffman Coding],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-nlogn[$O(n log n)$],
          b-space[$O(n)$],
          alg[Kruskal's MST],
          b-nlogn[$O(E log E)$],
          b-nlogn[$O(E log E)$],
          b-nlogn[$O(E log E)$],
          b-space[$O(V)$],
          alg[Prim's MST (Heap)],
          b-nlogn[$O(E log V)$],
          b-nlogn[$O(E log V)$],
          b-nlogn[$O(E log V)$],
          b-space[$O(V)$],
          alg[Dijkstra (Heap)],
          b-nlogn[$O(E log V)$],
          b-nlogn[$O(E log V)$],
          b-nlogn[$O(E log V)$],
          b-space[$O(V)$],
        ))
      ],
    )

    #v(3.5pt)

    // UNIT 5: STRING MATCHING
    #card(
      [4. String Matching Algorithms],
      [UNIT 5],
      rgb("#be123c"),
      rgb("#fff1f2"),
      rgb("#fecdd3"),
      [
        #comp-table((
          alg[Naive Matching],
          b-linear[$O(n)$],
          b-linear[$O(n+m)$],
          b-poly[$O(n dot m)$],
          b-space[$O(1)$],
          alg[Rabin-Karp],
          b-linear[$O(n+m)$],
          b-linear[$O(n+m)$],
          b-poly[$O(n dot m)$],
          b-space[$O(1)$],
          alg[KMP],
          b-linear[$O(n+m)$],
          b-linear[$O(n+m)$],
          b-linear[$O(n+m)$],
          b-space[$O(m)$],
          alg[Finite Automata],
          b-linear[$O(n + m |Sigma|)$],
          b-linear[$O(n + m |Sigma|)$],
          b-linear[$O(n + m |Sigma|)$],
          b-space[$O(m |Sigma|)$],
        ))
        #pad(x: 3.5pt, y: 1.5pt, text(size: 6.1pt, fill: rgb("#475569"))[
          *$n$* = text length, *$m$* = pattern length, #text(weight: "bold")[$|Sigma|$] = alphabet size. KMP's prefix table gives the worst-case guarantee; Rabin-Karp degrades only when hashes collide.
        ])
      ],
    )
  ],
  [
    // COLUMN 3: UNIT 4 (DP & BACKTRACKING)
    #card(
      [3. Dynamic Programming & Backtracking],
      [UNIT 4],
      rgb("#6d28d9"),
      rgb("#f5f3ff"),
      rgb("#ddd6fe"),
      [
        #comp-table((
          alg[Fibonacci (Naive)],
          b-exp[$O(2^n)$],
          b-exp[$O(2^n)$],
          b-exp[$O(2^n)$],
          b-space[$O(n)$],
          alg[Fibonacci (DP)],
          b-linear[$O(n)$],
          b-linear[$O(n)$],
          b-linear[$O(n)$],
          b-space[$O(1)$],
          alg[Binomial Coeff.],
          b-poly[$O(n dot k)$],
          b-poly[$O(n dot k)$],
          b-poly[$O(n dot k)$],
          b-space[$O(n dot k)$],
          alg[Making Change],
          b-poly[$O(n dot W)$],
          b-poly[$O(n dot W)$],
          b-poly[$O(n dot W)$],
          b-space[$O(W)$],
          alg[0/1 Knapsack (DP)],
          b-poly[$O(n dot W)$],
          b-poly[$O(n dot W)$],
          b-poly[$O(n dot W)$],
          b-space[$O(n dot W)$],
          alg[Assembly Line Sch.],
          b-linear[$O(n)$],
          b-linear[$O(n)$],
          b-linear[$O(n)$],
          b-space[$O(n)$],
          alg[Matrix Chain Mult.],
          b-poly[$O(n^3)$],
          b-poly[$O(n^3)$],
          b-poly[$O(n^3)$],
          b-space[$O(n^2)$],
          alg[LCS],
          b-poly[$O(m dot n)$],
          b-poly[$O(m dot n)$],
          b-poly[$O(m dot n)$],
          b-space[$O(m dot n)$],
          alg[Bellman-Ford],
          b-poly[$O(V dot E)$],
          b-poly[$O(V dot E)$],
          b-poly[$O(V dot E)$],
          b-space[$O(V)$],
          alg[Floyd-Warshall],
          b-poly[$O(V^3)$],
          b-poly[$O(V^3)$],
          b-poly[$O(V^3)$],
          b-space[$O(V^2)$],
          alg[N-Queens],
          b-const[$O(1)$],
          b-exp[$O(N!)$],
          b-exp[$O(N!)$],
          b-space[$O(N)$],
          alg[Sum of Subsets],
          b-exp[$O(2^n)$],
          b-exp[$O(2^n)$],
          b-exp[$O(2^n)$],
          b-space[$O(n)$],
          alg[Graph Colouring],
          b-exp[$O(m^n dot n)$],
          b-exp[$O(m^n dot n)$],
          b-exp[$O(m^n dot n)$],
          b-space[$O(n)$],
          alg[Knapsack (B.Track)],
          b-exp[$O(2^n)$],
          b-exp[$O(2^n)$],
          b-exp[$O(2^n)$],
          b-space[$O(n)$],
          alg[TSP (Branch & Bound)],
          b-exp[$O(n!)$],
          b-exp[$O(n!)$],
          b-exp[$O(n!)$],
          b-space[$O(n^2)$],
          alg[Minimax],
          b-exp[$O(b^m)$],
          b-exp[$O(b^m)$],
          b-exp[$O(b^m)$],
          b-space[$O(b dot m)$],
        ))
      ],
    )

    #v(3.5pt)

    // DP & BACKTRACKING FORMULATION CALLOUT
    #block(
      width: 100%,
      stroke: 0.8pt + rgb("#ddd6fe"),
      radius: 4pt,
      clip: true,
      fill: white,
      [
        #block(
          width: 100%,
          fill: rgb("#f5f3ff"),
          inset: (x: 6pt, y: 2.5pt),
          stroke: (bottom: 0.8pt + rgb("#ddd6fe")),
          [#text(weight: "bold", size: 7.2pt, fill: rgb("#6d28d9"))[DP & Backtracking State-Space Insights]],
        )
        #pad(x: 6pt, y: 3pt, [
          #text(size: 6.3pt)[
            • *0/1 Knapsack DP*: $V[i, w] = max(V[i-1, w], V[i-1, w - w_i] + v_i)$. Pseudo-polynomial: $O(n W)$ is exponential in the *bit length* of $W$.\
            • *Matrix Chain*: $m[i, j] = min_(i <= k < j) (m[i, k] + m[k+1, j] + p_(i-1) p_k p_j)$. $O(n^3)$ time, $O(n^2)$ space.\
            • *TSP (Branch & Bound)*: reduced cost matrix prunes non-promising paths; Held-Karp DP cuts $O(n!)$ down to $O(n^2 2^n)$.\
            • *Backtracking vs B&B*: both explore the same state space -- pruning only improves the *practical* runtime, never the worst-case bound.
          ]
        ])
      ],
    )
  ],
)

#v(4pt)

// --- BOTTOM SECTION: 3 DEEP-DIVE PANELS ---
#let panel(title, accent, bg, border, body) = block(
  width: 100%,
  stroke: 0.8pt + border,
  radius: 4pt,
  clip: true,
  fill: white,
  [
    #block(
      width: 100%,
      fill: bg,
      inset: (x: 6pt, y: 3.2pt),
      stroke: (bottom: 0.8pt + border),
      [#text(weight: "bold", size: 7.4pt, fill: accent)[#title]],
    )
    #pad(x: 6pt, y: 3.5pt, body)
  ],
)

#grid(
  columns: (1fr, 1.13fr, 1.17fr),
  gutter: 6.5pt,
  panel(
    [Sorting Classification & Bounds],
    rgb("#334155"),
    rgb("#f8fafc"),
    rgb("#cbd5e1"),
    text(size: 6.4pt)[
      • *Stability*: a stable sort preserves the relative order of equal keys.\
      #h(4pt) -- *Stable*: Bubble, Insertion, Merge, Counting, Radix, Bucket.\
      #h(4pt) -- *Unstable*: Selection, Quick, Heap, Shell.\
      • *Auxiliary space*: in-place sorts use $O(1)$ extra memory.\
      #h(4pt) -- *In-place*: Bubble, Selection, Insertion, Heap, Shell.\
      #h(4pt) -- *Out-of-place*: Merge ($O(n)$), Quick ($O(log n)$ stack).\
      • *Comparison lower bound*: every comparison-based sort needs $Omega(n log n)$ worst-case comparisons (decision-tree height $>= log_2 (n!)$).\
      • *Linear-time sorts*: non-comparison sorts (Counting, Radix, Bucket) reach $O(n+k)$ only by exploiting bounded key values.\
      • *Notation*: $O$ = upper bound, $Omega$ = lower bound, $Theta$ = tight bound (both).\
      • *Choosing a sort*: nearly sorted → Insertion; tight memory → Heap; stability required → Merge; small integer keys → Counting / Radix.
    ],
  ),
  panel(
    [Algorithm Design Paradigms -- Strategy Guide],
    rgb("#334155"),
    rgb("#f8fafc"),
    rgb("#cbd5e1"),
    text(size: 6.4pt)[
      • *Divide & Conquer*: split into *disjoint* subproblems, solve recursively, combine. Merge Sort, Quick Sort, Strassen, Binary Search.\
      • *Greedy*: take the local optimum at each step. Valid only with the *greedy-choice property* + *optimal substructure*. Kruskal, Prim, Dijkstra, Huffman, Fractional Knapsack.\
      • *Dynamic Programming*: for *overlapping subproblems* + *optimal substructure*; store results (memoisation / tabulation) to avoid recomputation. 0/1 Knapsack, LCS, Floyd-Warshall.\
      • *Backtracking*: depth-first state-space search with bounding functions that prune unpromising subtrees early. N-Queens, Sum of Subsets, Graph Colouring.\
      • *Branch & Bound*: breadth-/best-first search using lower and upper bounds to prune *optimisation* search spaces. TSP, 0/1 Knapsack.\
      • *Quick test*: subproblems disjoint → D&C; overlapping → DP; one irrevocable choice → Greedy; need all feasible solutions → Backtracking.
    ],
  ),
  panel(
    [Master Theorem & Classic Recurrences],
    rgb("#0f766e"),
    rgb("#f0fdfa"),
    rgb("#99f6e4"),
    text(size: 6.4pt)[
      *Master recurrence*: $T(n) = a T(n/b) + f(n)$, where $a >= 1$, $b > 1$, $f(n) = Theta(n^d)$:\
      • *Case 1* ($d < log_b a$): $T(n) = Theta(n^(log_b a))$ -- leaves dominate.\
      • *Case 2* ($d = log_b a$): $T(n) = Theta(n^d log n)$ -- equal work per level.\
      • *Case 3* ($d > log_b a$): $T(n) = Theta(f(n))$ if $a f(n\/b) <= c f(n)$ -- root dominates.\
      *Classic recurrences*:\
      • Binary Search: $T(n) = T(n\/2) + O(1) ==> Theta(log n)$\
      • Merge Sort: $T(n) = 2T(n\/2) + O(n) ==> Theta(n log n)$\
      • Strassen: $T(n) = 7T(n\/2) + O(n^2) ==> Theta(n^(log_2 7)) approx Theta(n^2.81)$\
      • Tower of Hanoi: $T(n) = 2T(n-1) + O(1) ==> Theta(2^n)$\
      *Legend*: $n$ input size | $k$ key range | $V, E$ vertices, edges | $W$ knapsack capacity | $m$ pattern length | $b$ branching factor | $|Sigma|$ alphabet size.
    ],
  ),
)

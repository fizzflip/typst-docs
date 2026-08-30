#import "@preview/mmdr:0.2.1": mermaid
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
  margin: (x: 2.2cm, y: 2.2cm),
  footer: context {
    if here().page() > 2 {
      set text(size: 9pt, fill: gray.lighten(30%))
      [Sorting Algorithm Analysis -- ADA]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    }
  },
)

#set text(
  fill: rgb("#f0f0f0"), // Light text
  font: ("Magnisa Sans", "Times New Roman"),
  size: 11pt,
)

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.1em,
)

#show heading: it => block(
  inset: (top: 0.7em, bottom: 0.35em),
  text(size: 1.4em, weight: "regular", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.5em, bottom: 0.3em),
  text(size: 1.2em, weight: "regular", fill: rgb("#ffffff"), it.body),
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
      [Analysis and Design of Algorithms], [SUB],
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
  SORTING \
  ALGORITHMS \
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

// --- PAGE 3: INTRODUCTION ---
#counter(page).update(1)

= Introduction

Sorting is a fundamental problem in computer science, serving as the cornerstone for search algorithms, database indexing, data processing pipelines, and system optimization. Understanding the runtime efficiency and spatial characteristics of sorting techniques requires both theoretical analysis of time complexities ($O(n^2)$, $O(n log n)$) and empirical observation of execution dynamics.

To bridge theoretical algorithm analysis with practical behavior, interactive web-based visualizers provide intuitive, real-time insight into element swaps, comparisons, array partitions, and recursive decomposition.

== Visualizers
This report utilizes modern interactive visualization platforms to analyze algorithm dynamics:

1. *vck.app Visualizer (vck.app/visualizer)*:
  - *Key Features*: Clean high-contrast step-by-step element rendering with real-time comparison counters, active element swap animations, and adjustable execution speed.
  - *Analytical Value*: Ideal for observing granular array operations during Bubble Sort pass passes and Lomuto partition scans.

2. *SortPedia (sortpedia.com/visualizer)*:
  - *Key Features*: Comprehensive sorting encyclopedia featuring side-by-side interactive visualizers, detailed algorithm complexity summaries, pseudocode execution highlights, and input generator controls.
  - *Analytical Value*: Connects step-by-step element transitions directly to asymptotic bounds ($O(n^2)$ vs $O(n log n)$) and auxiliary space usage.

3. *SortSim (sortsim.dev)*:
  - *Key Features*: High-performance canvas-based sorting simulator supporting multi-algorithm benchmarking across custom array distributions (*Random*, *Nearly Sorted*, *Reversed*, *Few Unique*).

#v(0.5em)
#align(center)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    figure(
      box(
        fill: rgb("#1b1b1f"),
        inset: 4pt,
        radius: 4pt,
        stroke: 0.5pt + rgb("#444"),
        image("assets/vck_visualizer_main.png", width: 100%),
      ),
      caption: [vck.app Visualizer Interface],
    ),
    figure(
      box(
        fill: rgb("#1b1b1f"),
        inset: 4pt,
        radius: 4pt,
        stroke: 0.5pt + rgb("#444"),
        image("assets/sortpedia_visualizer_main.png", width: 100%),
      ),
      caption: [SortPedia Visualizer Interface],
    ),
  )
]

#v(1em)
#align(center)[
  #box(
    fill: rgb("#1b1b1f"),
    inset: 7pt,
    radius: 5pt,
    stroke: 0.5pt + rgb("#444"),
    width: 98%,
  )[
    #align(left)[
      #text(weight: "bold", fill: rgb("#38bdf8"))[Metrics:]
      - *Active Comparison Count ($C$)*: Incremented whenever two elements are evaluated ($a_i > a_j$).
      - *Element Swap / Move Count ($S$)*: Incremented during value exchanges or auxiliary copies.
      - *Recursion Depth ($D$)*: Maximum call-stack frame depth for recursive algorithms.
      - *Array Accesses ($A$)*: Total read/write operations performed on the array.
    ]
  ]
]

#pagebreak()

= I. Algorithm Analysis

== 1. Bubble Sort

=== Mechanism
Bubble Sort repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order. Pass $i$ guarantees that the $i$-th largest element "bubbles up" to its final position at the end of the array.

=== Variants
- *Standard Unoptimized Bubble Sort*: Runs $n-1$ full passes regardless of whether the array becomes sorted early. Always executes $(n(n-1))/2$ comparisons.
- *Optimized Flagged Bubble Sort*: Tracks swaps with a boolean `swapped` flag per pass. Terminates immediately if a full pass completes without any swaps, achieving $O(n)$ best-case time on nearly sorted arrays.
- *Cocktail Shaker Sort (Bidirectional Bubble Sort)*: Alternates passes from left-to-right and right-to-left, placing both max and min elements per cycle. Solves the "turtle" problem where small values near the end move slowly to the front.

=== Visualizer State
On array #m[\[38, 27, 43, 3, 9, 82, 10\]], active comparisons in red and locked sorted elements in green:
#v(.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,

  image("assets/bubble-sort-1.png", width: 100%), image("assets/bubble-sort-2.png", width: 100%),
  image("assets/bubble-sort-3.png", width: 100%), image("assets/bubble-sort-4.png", width: 100%),
)


#pagebreak()

=== Complexity
- *Comparisons ($C$)*: Total comparisons across $n-1$ passes:
  $ C(n) = sum_(i=1)^(n-1) (n - i) = (n(n - 1)) / 2 = Theta(n^2) $
- *Swaps ($S$)*:
  - *Best Case*: $S = 0 = O(1)$ (Already sorted array).
  - *Worst Case*: $S = (n(n - 1)) / 2 = Theta(n^2)$ (Reverse sorted array).
  - *Average Case*: $S = (n(n - 1)) / 4 = Theta(n^2)$ (In expectation, half of all adjacent pairs are inverted).
- *Time Complexity*:
  - *Best Case*: $O(n)$ with early termination flag (`swapped == false`).
  - *Average and Worst Case*: $Theta(n^2)$ time.
- *Space Complexity*: $O(1)$ auxiliary space (in-place algorithm).
- *Stability*: *Stable* -- Adjacent swaps are performed only when `arr[j] > arr[j + 1]`. Equal elements are never swapped, preserving their relative initial order.

=== Implementation
```cpp
// Optimized Bubble Sort with Early Termination Flag
void bubbleSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n - 1; i++) {
        bool swapped = false;
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
                swapped = true;
            }
        }
        if (!swapped) break; // Array is sorted early
    }
}
```

#pagebreak()

== 2. QuickSort

=== Mechanism
QuickSort operates on the *Divide-and-Conquer* paradigm. Unlike Merge Sort, which divides the array unconditionally at the midpoint and performs work during the merge phase, QuickSort performs its core partitioning work up front:

1. *Divide*: Select a *pivot* element $p = A["pivot"]$ from the sub-array $A["low".."high"]$. Rearrange (partition) $A["low".."high"]$ into two sub-arrays $A["low"..pi-1]$ and $A[pi+1.."high"]$ such that every element in the left sub-array is less than or equal to $p$, and every element in the right sub-array is greater than or equal to $p$. The pivot is placed at index $pi$.
2. *Conquer*: Recursively sort the sub-arrays $A["low"..pi-1]$ and $A[pi+1.."high"]$.
3. *Combine*: Trivial -- because elements are partitioned in-place, no explicit combining operation is required once sub-arrays are sorted.

=== Partitioning
The choice of partitioning scheme and pivot selection strategy heavily influences efficiency and vulnerability to degenerate cases:

- *Lomuto Partition Scheme*: Employs a single scanning pointer $j$ from `low` to `high - 1` and a boundary pointer $i$ initialized to `low - 1`. When $A[j] < p$, pointer $i$ is incremented and $A[i]$ is swapped with $A[j]$. While easy to implement, Lomuto performs up to $O(n)$ swaps per pass and degrades on array inputs with many duplicate elements.
- *Hoare Partition Scheme*: Employs two opposing pointers scanning inward from `low` and `high`. It performs approximately $1/3$ as many swaps on average compared to Lomuto and handles duplicate values more robustly.
- *Pivot Selection Techniques*:
  - *Naive Selection*: Picking fixed elements (e.g. `arr[high]` or `arr[low]`). Extremely vulnerable to $O(n^2)$ worst-case time complexity on pre-sorted or reverse-sorted data.
  - *Randomized Pivot*: Selecting a uniform random pivot index $r in ["low", "high"]$ guarantees expected $O(n log n)$ runtime irrespective of initial input distribution.
  - *Median-of-Three*: Selecting $"median"(A["low"], A["mid"], A["high"])$ mitigates worst-case partitioning on sorted datasets.

=== Visualizer State
In vck.app and SortPedia, selecting the rightmost element as pivot (Lomuto Partitioning Scheme) establishes dynamic pointers:
- *Pivot ($p$)*: Element at index `high` (marked in Green).
- *Boundary ($i$)*: Tracks the end of elements $\le p$ (marked in Blue). Initialized to `low - 1`.
- *Scanner ($j$)*: Iterates from `low` to `high - 1` comparing #m[arr[j] < pivot] (marked in Red / Amber when swapping).

// #pagebreak()
Below is the step-by-step trace of partitioning array #m[\[38, 27, 43, 3, 9, 82, 10\]] with pivot $p = 10$:

#align(center)[
  #box(
    fill: rgb("#1b1b1f"),
    inset: 6pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#333"),
    width: 98%,
  )[
    #text(weight: "bold", fill: rgb("#38bdf8"), size: 8.5pt)[Step 1: Initial State (p = 10, i = -1, j = 0)]
    #v(0.15em)
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1.2fr),
      align: center,
      stroke: 0.3pt + rgb("#555"),
      fill: (x, y) => if x == 6 { rgb("#16a34a") } else if x == 0 { rgb("#e11d48") } else { rgb("#262626") },
      [*38 (j)*], [*27*], [*43*], [*3*], [*9*], [*82*], [*10 (p)*],
      [38 > 10], [Wait], [Wait], [Wait], [Wait], [Wait], [Pivot],
    )
  ]
]

// #v(0.2em)
#align(center)[
  #box(
    fill: rgb("#1b1b1f"),
    inset: 6pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#333"),
    width: 98%,
  )[
    #text(
      weight: "bold",
      fill: rgb("#38bdf8"),
      size: 8.5pt,
    )[Step 2: Scanner Finds 3 < 10 (j = 3, Increment i -> 0, Swap 38 and 3)]
    #v(0.15em)
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1.2fr),
      align: center,
      stroke: 0.3pt + rgb("#555"),
      fill: (x, y) => if x == 6 { rgb("#16a34a") } else if x == 0 or x == 3 { rgb("#0284c7") } else { rgb("#262626") },
      [*3 (i)*], [*27*], [*43*], [*38 (j)*], [*9*], [*82*], [*10 (p)*],
      [Swapped], [OK], [OK], [Moved], [Wait], [Wait], [Pivot],
    )
  ]
]

// #v(0.2em)
#align(center)[
  #box(
    fill: rgb("#1b1b1f"),
    inset: 6pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#333"),
    width: 98%,
  )[
    #text(
      weight: "bold",
      fill: rgb("#38bdf8"),
      size: 8.5pt,
    )[Step 3: Scanner Finds 9 < 10 (j = 4, Increment i -> 1, Swap 27 and 9)]
    #v(0.15em)
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1.2fr),
      align: center,
      stroke: 0.3pt + rgb("#555"),
      fill: (x, y) => if x == 6 { rgb("#16a34a") } else if x == 0 or x == 1 { rgb("#0284c7") } else { rgb("#262626") },
      [*3*], [*9 (i)*], [*43*], [*38*], [*27 (j)*], [*82*], [*10 (p)*],
      [$\le p$], [Swapped], [OK], [OK], [Moved], [Wait], [Pivot],
    )
  ]
]

// #v(0.2em)
#align(center)[
  #box(
    fill: rgb("#1b1b1f"),
    inset: 6pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#333"),
    width: 98%,
  )[
    #text(weight: "bold", fill: rgb("#16a34a"), size: 8.5pt)[Final Partition State: Swap Pivot 10 with A[i+1 = 2] (43)]
    #v(0.15em)
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1.2fr),
      align: center,
      stroke: 0.3pt + rgb("#555"),
      fill: (x, y) => if x == 2 { rgb("#16a34a") } else if x < 2 { rgb("#0284c7") } else { rgb("#262626") },
      [*3*], [*9*], [*10 (Placed)*], [*38*], [*27*], [*82*], [*43*],
      [Left Sub], [Left Sub], [Pivot Index 2], [Right Sub], [Right Sub], [Right Sub], [Right Sub],
    )
  ]
]
#v(.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,

  image("assets/quick-sort-1.png", width: 100%), image("assets/quick-sort-2.png", width: 100%),
  image("assets/quick-sort-4.png", width: 100%), image("assets/quick-sort-3.png", width: 100%),
)


=== Complexity
- *Best Case*: $Theta(n log n)$ -- Occurs when pivot splits array into equal halves.
  $ T(n) = 2 T(n/2) + Theta(n) => T(n) = Theta(n log n) $
- *Average Case*: $Theta(n log n)$ -- Random pivot choices achieve near-optimal $O(n log n)$ partitioning on average.
- *Worst Case*: $Theta(n^2)$ -- Occurs when chosen pivot is consistently minimum or maximum element:
  $ T(n) = T(n-1) + T(0) + Theta(n) => T(n) = sum_(k=1)^n k = (n(n+1)) / 2 = Theta(n^2) $

#pagebreak()

- *Space Complexity*:
  - *Average Call-Stack Depth*: $O(log n)$ recursion stack.
  - *Worst-Case Stack Depth*: $O(n)$ without tail call optimization; reduced to $O(log n)$ auxiliary space by sorting smaller sub-arrays first.
- *Stability*: *Unstable* (long-distance swaps across pivot can reorder duplicate elements).

=== Implementation
```cpp
// Lomuto Partitioning Scheme
int partition(vector<int>& arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
        if (arr[j] < pivot) {
            i++;
            swap(arr[i], arr[j]);
        }
    }
    swap(arr[i + 1], arr[high]);
    return i + 1;
}

// Tail-Call Optimized QuickSort (Guarantees O(log n) stack space)
void quickSort(vector<int>& arr, int low, int high) {
    while (low < high) {
        int pi = partition(arr, low, high);
        if (pi - low < high - pi) {
            quickSort(arr, low, pi - 1);
            low = pi + 1;
        } else {
            quickSort(arr, pi + 1, high);
            high = pi - 1;
        }
    }
}
```

#pagebreak()

== 3. Merge Sort

=== Mechanism
Merge Sort is an $O(n log n)$ comparison-based, out-of-place sorting algorithm built on the Divide-and-Conquer paradigm:

1. *Divide*: Calculate the midpoint $m = l + floor((r - l)/2)$ and split array $A[l..r]$ into two sub-arrays $A[l..m]$ of size $floor(n/2)$ and $A[m+1..r]$ of size $ceil(n/2)$.
2. *Conquer*: Recursively invoke Merge Sort on $A[l..m]$ and $A[m+1..r]$. The recursion halts when sub-array length is $<= 1$ (which is inherently sorted).
3. *Combine*: Systematically merge the two sorted sub-arrays $A[l..m]$ and $A[m+1..r]$ into a single contiguous sorted array using an auxiliary temporary buffer.

=== Variants
- *Standard Out-of-Place Merge Sort*: Allocates an auxiliary buffer of size $O(n)$ to copy sub-arrays during merging. Guarantees strict $Theta(n log n)$ performance across all input data distributions.
- *Bottom-Up (Iterative) Merge Sort*: Replaces function recursion with an iterative loop that merges adjacent sub-arrays of doubling sizes ($1, 2, 4, 8, dots$). This eliminates recursion call-stack space overhead.
- *Natural Merge Sort*: Identifies pre-sorted contiguous sub-sequences ("runs") already present in the input sequence and merges them. Reduces runtime to $O(n)$ on partially sorted data.

=== Visualizer State
Visualizing Merge Sort on SortPedia highlights the distinct *Divide* phase (downward recursion tree) and *Combine* phase (upward merge pass):

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,

  image("assets/merge-sort-1.png", width: 100%), image("assets/merge-sort-2.png", width: 100%),
  image("assets/merge-sort-3.png", width: 100%), image("assets/merge-sort-4.png", width: 100%),
)

=== Complexity
- *Time Complexity (Best, Average, Worst)*: $Theta(n log n)$ -- Unconditional $O(n)$ merge operations performed across $log_2 n$ tree levels. Recurrence relation:
  $ T(n) = 2 T(n/2) + Theta(n) => T(n) = Theta(n log n) quad "(via Master Theorem)" $
- *Space Complexity*: $O(n)$ auxiliary array buffer space + $O(log n)$ recursion stack depth.
- *Stability*: *Stable* -- During the merge step, when $L[i] <= R[j]$, the element from the left sub-array $L[i]$ is copied first, guaranteeing that equal keys retain their original relative order.

=== Implementation
```cpp
void merge(vector<int>& arr, int l, int m, int r) {
    vector<int> L(arr.begin() + l, arr.begin() + m + 1);
    vector<int> R(arr.begin() + m + 1, arr.begin() + r + 1);
    int i = 0, j = 0, k = l;
    while (i < L.size() && j < R.size()) {
        arr[k++] = (L[i] <= R[j]) ? L[i++] : R[j++];
    }
    while (i < L.size()) arr[k++] = L[i++];
    while (j < R.size()) arr[k++] = R[j++];
}

void mergeSort(vector<int>& arr, int l, int r) {
    if (l >= r) return;
    int m = l + (r - l) / 2;
    mergeSort(arr, l, m);
    mergeSort(arr, m + 1, r);
    merge(arr, l, m, r);
}
```

#pagebreak()

= II. Empirical Metrics

Observations collected across SortSim, SortPedia, and vck.app for input size $N = 50$ elements under different data distributions yield clear operational patterns:

#v(0.6em)
#align(center)[
  #text(weight: "bold", size: 1.05em)[Table 1: Operation Counter Comparisons ($N = 50$)]
  #v(0.3em)
  #set table(inset: 0.55em, stroke: 0.5pt + gray)
  #table(
    columns: (1.3fr, 1.2fr, 1fr, 1.2fr, 1.2fr),
    fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else { none },
    [*Algorithm*], [*Initial State*], [*Comparisons ($C$)*], [*Swaps ($S$)*], [*Observed Runtime*],
    [Bubble Sort (Unopt)], [Random], [1,225], [630], [Slow ($O(N^2)$)],
    [Bubble Sort (Opt)], [Nearly Sorted], [49], [3], [Instant ($O(N)$)],
    [Bubble Sort (Unopt)], [Reversed], [1,225], [1,225], [Worst ($O(N^2)$)],
    [QuickSort (Naive)], [Random], [285], [92], [Fast ($O(N log N)$)],
    [QuickSort (Naive)], [Reversed], [1,225], [1,225], [Degraded ($O(N^2)$)],
    [Merge Sort], [Random], [236], [284], [Fast ($O(N log N)$)],
    [Merge Sort], [Reversed], [212], [284], [Fast ($O(N log N)$)],
    [Merge Sort], [Nearly Sorted], [180], [284], [Fast ($O(N log N)$)],
  )
]

#v(0.6em)
== Input Distributions

1. *Random Distribution*:
  - QuickSort and Merge Sort complete in under 300 comparisons.
  - Bubble Sort exhibits dense quadratic red highlight patterns across all indices.

2. *Nearly Sorted Distribution*:
  - Optimized Bubble Sort terminates after Pass 1 ($C = N-1$), demonstrating strong *adaptivity*.
  - Merge Sort maintains its standard $O(N log N)$ split and merge passes.

3. *Reversed Distribution*:
  - Naive QuickSort degenerates into quadratic runtime due to unbalanced partitions ($N-1$ elements in one side).
  - Merge Sort performance remains entirely immune to initial element ordering.

#pagebreak()

= III. Complexity Comparison

=== Performance Matrix
The theoretical performance profiles of the three algorithms reflect fundamental trade-offs between computational work, space requirements, and hardware interaction:

#v(0.4em)
#set table(inset: 0.5em, stroke: 0.5pt + gray)
#align(center)[
  #table(
    columns: (1.1fr, 1.1fr, 0.9fr, 1fr, 1fr, 1fr, 0.8fr, 0.8fr),
    fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else if calc.odd(y) { rgb("#19191d") } else { rgb("#141414") },
    [*Algorithm*], [*Paradigm*], [*Best*], [*Average*], [*Worst*], [*Aux Space*], [*Stable?*], [*Adaptive?*],
    [Bubble Sort], [Exchange], [$O(n)$], [$O(n^2)$], [$O(n^2)$], [$O(1)$], [Yes], [Yes],
    [QuickSort], [Partitioning], [$O(n log n)$], [$O(n log n)$], [$O(n^2)$], [$O(log n)$], [No], [No],
    [Merge Sort], [Merging], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$], [$O(n)$], [Yes], [No],
  )
]

=== Trade-offs

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  box(
    fill: rgb("#1b1b1f"),
    inset: 8pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#333"),
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#38bdf8"))[1. Cache Locality]
    - *QuickSort*: Demonstrates superior spatial locality. Sequential element access during partition scans maximizes CPU L1/L2 cache hit ratios.
    - *Merge Sort*: High cache overhead. Allocating and copying to auxiliary buffer $O(n)$ causes frequent cache line invalidation.
    - *Bubble Sort*: Sequential adjacent reads, but excessive $O(n^2)$ write operations incur heavy bus traffic and memory write stalls.
  ],
  box(
    fill: rgb("#1b1b1f"),
    inset: 8pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#333"),
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#f43f5e"))[2. Memory Constraints]
    - *Bubble Sort*: Strictly $O(1)$ auxiliary space, operating purely in-place.
    - *QuickSort*: $O(log n)$ stack depth on average (with tail-call optimization sorting smaller partitions first).
    - *Merge Sort*: Requires $O(n)$ external heap allocation. On massive datasets ($N > 10^7$), auxiliary memory footprint can trigger out-of-memory limits.
  ],
)

#v(0.4em)
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  box(
    fill: rgb("#1b1b1f"),
    inset: 8pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#333"),
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#16a34a"))[3. Stability]
    - *Stability Definition*: Preserves the relative order of duplicate elements ($a_i = a_j$).
    - *Stable (Bubble and Merge Sort)*: Essential when sorting multi-attribute data (e.g., sorting transactions first by timestamp, then by customer ID).
    - *Unstable (QuickSort)*: Long-distance swaps across the pivot element disrupt identical key positions.
  ],
  box(
    fill: rgb("#1b1b1f"),
    inset: 8pt,
    radius: 4pt,
    stroke: 0.5pt + rgb("#333"),
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#a855f7"))[4. Hybrid Algorithms]
    - *Timsort*: Used in Python `sorted()` and Java `Arrays.sort(Object[])`. Combines Merge Sort and Insertion Sort to achieve $O(n log n)$ stable sorting with $O(n)$ adaptivity on pre-sorted data.
    - *Introsort*: Used in C++ `std::sort`. Starts with QuickSort, switches to HeapSort if recursion depth exceeds $2 log n$, and uses Insertion Sort for small arrays ($N < 16$).
  ],
)

#pagebreak()

= IV. Algorithm Selection

Choosing the optimal sorting algorithm for real-world software systems requires evaluating dataset characteristics, system hardware limits, and domain-specific correctness constraints. No single sorting algorithm dominates across all operational conditions.

== Criteria

1. *Dataset Scale ($N$)*:
  - For small datasets ($N < 20$), low constant factors in $O(n^2)$ algorithms (Insertion Sort or Bubble Sort) outperform $O(n log n)$ overhead.
  - For large datasets ($N > 10^4$), $O(n log n)$ scaling (QuickSort or Merge Sort) is mandatory.

2. *Memory Footprint Budget*:
  - Strict in-place requirement ($O(1)$ RAM limit, e.g. embedded firmware) rules out Merge Sort ($O(n)$ space). HeapSort or QuickSort must be selected.

3. *Stability Constraint*:
  - Sorting multi-attribute records (e.g. database rows sorted by Timestamp then User ID) requires stable algorithms (Merge Sort or Timsort).

4. *Input Entropy*:
  - If input data is frequently nearly sorted, adaptive algorithms (Optimized Bubble Sort or Timsort) execute in $O(n)$ linear time.

\

#v(0.3em)
#align(center)[
  #text(weight: "bold", size: 1em)[Table 2: Scenario-Based Selection Guide]
  #v(0.2em)
  #set table(inset: 0.5em, stroke: 0.5pt + gray)
  #table(
    columns: (1.3fr, 1.2fr, 1.2fr, 1.3fr),
    fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else { none },
    [*Operational Scenario*], [*Primary Constraint*], [*Recommended Algorithm*], [*Engineering Rationale*],
    [General System Library],
    [High average \ throughput],
    [Introsort / QuickSort],
    [Optimal CPU cache hit ratio and low constant factor],

    [Database Query Engine],
    [Stable multi-column sort],
    [Timsort / Merge Sort],
    [Guarantees \ stable key ordering and \ $O(n log n)$ bound],

    [Embedded Microcontroller],
    [Strict $O(1)$ RAM limit],
    [HeapSort /\ In-place QuickSort],
    [Zero auxiliary \ heap allocation required],

    [Small Sub-array Partition],
    [Low call-stack depth],
    [Insertion /\ Bubble Sort],
    [Eliminates recursive \ function call overhead],

    [Parallel /\ Distributed Systems],
    [Independent \ partition merging],
    [Parallel Merge Sort],
    [Sub-arrays divide cleanly across worker threads],
  )
]

#v(0.4em)
== Decision Tree

#v(0.3em)
#align(center)[
  #mermaid(
    "graph TD;
    Start([Select Algorithm]) --> Q1{Size N < 20?}
    Q1 -- Yes --> Insertion[Insertion Sort]
    Q1 -- No --> Q2{Mem O(1)?}
    Q2 -- Yes --> Heap[HeapSort]
    Q2 -- No --> Q3{Stable Needed?}
    Q3 -- Yes --> Merge[MergeSort]
    Q3 -- No --> Quick[QuickSort]
    style Insertion fill:#0284c7,stroke:#fff,color:#fff
    style Merge fill:#16a34a,stroke:#fff,color:#fff
    style Quick fill:#e11d48,stroke:#fff,color:#fff
    style Heap fill:#8b5cf6,stroke:#fff,color:#fff
  ",
    theme: (background: "#141414"),
  )
]

#pagebreak()

= V. Conclusion

Through interactive web visualizers such as vck.app, SortPedia, and SortSim, the dynamic behavior of Bubble Sort, QuickSort, and Merge Sort was empirically observed, analyzed, and synthesized alongside theoretical asymptotic bounds:

== Synthesis

1. *Bubble Sort (Exchange Paradigm)*:
  - Serves strong pedagogical value for introducing element comparison and swapping mechanics.
  - Computationally inefficient for production datasets ($O(n^2)$), but exhibits remarkable linear adaptivity ($O(n)$ comparisons, $O(1)$ swaps) on nearly sorted inputs when equipped with early exit detection.

2. *QuickSort (Partitioning Paradigm)*:
  - Delivers the highest practical execution speed ($O(n log n)$ average time) due to superior CPU L1/L2 cache locality and minimal constant factors.
  - Requires defensive engineering (randomized pivot selection, median-of-three, or Introsort fallbacks) to prevent worst-case $O(n^2)$ call-stack degradation on pre-sorted inputs.

3. *Merge Sort (Divide-and-Conquer Paradigm)*:
  - Provides guaranteed worst-case $O(n log n)$ performance and stable element ordering across all initial data distributions.
  - Incurs an $O(n)$ auxiliary memory space cost, making it ideal for linked data structures and external disk-based sorting, but less suitable for memory-constrained embedded systems.

== Key Takeaways

Modern commercial runtime engines rarely rely on pure textbook algorithms. Instead, production software utilizes *hybrid adaptive algorithms*:
- *Timsort* (Python, Java, Android) leverages Merge Sort's stability alongside Insertion Sort's small-array efficiency.
- *Introsort* (C++ Standard Template Library) combines QuickSort's speed, HeapSort's $O(n log n)$ worst-case safety guarantee, and Insertion Sort's low overhead.

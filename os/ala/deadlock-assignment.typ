#import "@preview/mmdr:0.2.1": mermaid
#let meta = json("../../misc/metadata.json")

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
      [Deadlock Analysis & Resolution -- #meta.subject]
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
  leading: 0.7em,
  spacing: 1.2em,
)

#show heading: it => block(
  inset: (top: 1em, bottom: 0.5em),
  text(size: 1.4em, weight: "regular", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.5em, bottom: 0.3em),
  text(size: 1.2em, weight: "regular", fill: rgb("#ffffff"), it.body),
)

// Custom code block styling
#show raw.where(block: true): it => block(
  fill: rgb("#1b1b1f"),
  inset: 12pt,
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
      [#meta.subject], [#meta.sub_code],
      [#meta.roll_no], [#meta.ern],
      [#meta.section], [#meta.cla],
      [II], [#meta.ala],
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
  DEADLOCK \
  ANALYSIS & \
  RESOLUTION
]

#pagebreak()

// --- PAGE 2: TABLE OF CONTENTS ---
#v(2em)
#align(center)[
  #text(size: 2em, weight: "bold")[Table of Contents]
]
#v(1em)
#outline(title: none, indent: auto)

#pagebreak()

// --- PAGE 3: INTRODUCTION ---
#counter(page).update(1)
= Introduction
A deadlock is a specific state in multi-threaded software systems where two or more threads are permanently blocked, each waiting for a resource held by another. In modern operating systems, deadlocks can lead to terminal system freezes, requiring manual intervention or hard resets.

== The Coffman Conditions
For a deadlock to occur, the following four conditions must be present simultaneously:
1. *Mutual Exclusion*: Resources cannot be shared; only one thread can hold a resource at a time.
2. *Hold and Wait*: Threads already holding resources can request new ones.
3. *No Preemption*: A resource cannot be forcibly taken from a thread.
4. *Circular Wait*: A closed chain of threads exists where each thread is waiting for a resource held by the next.

= I. Technical Analysis: The "Before" State
We analyze a multi-threaded C application using the #m[pthread] library. The application exhibits a classical "Circular Wait" scenario.

== 1. Resource Allocation Graph (RAG)
#v(1em)
#align(center)[
  #mermaid(
    "graph LR;
    T1((Thread 1)) --> RB[Resource B];
    RB --> T2((Thread 2));
    T2 --> RA[Resource A];
    RA --> T1;
    style RA fill:#222,stroke:#fff,color:#fff;
    style RB fill:#222,stroke:#fff,color:#fff;
    style T1 fill:#1b1b1f,stroke:#fff,color:#fff;
    style T2 fill:#1b1b1f,stroke:#fff,color:#fff;
  ",
    theme: (background: "#141414"),
  )
]
#v(1em)

== 2. Problematic Logic (`deadlock_victim.c`)
In the code below, Thread 1 acquires $A arrow.r B$, while Thread 2 acquires $B arrow.r A$.

```c
void* thread_one(void* arg) {
    pthread_mutex_lock(&resource_A);
    sleep(1); // Artificial delay
    pthread_mutex_lock(&resource_B); // Deadlock HANG here
}

void* thread_two(void* arg) {
    pthread_mutex_lock(&resource_B);
    sleep(1); // Artificial delay
    pthread_mutex_lock(&resource_A); // Deadlock HANG here
}
```

#pagebreak()

= II. Comparative Analysis of Resolution Strategies
Deadlocks can be managed through three primary philosophies:

== 1. Deadlock Prevention
Prevention works by negating one of the four Coffman conditions.
- *Strategy*: Resource Acquisition Ordering (Resource Hierarchy).
- *Mechanism*: Assign a unique priority to each resource and ensure threads always acquire them in increasing order.
- *Outcome*: Circular Wait becomes mathematically impossible.

== 2. Deadlock Avoidance (Banker's Algorithm)
Avoidance uses dynamic state tracking to ensure that granting a resource request won't leave the system in an "Unsafe State."

=== Worked Example (Banker's Algorithm)
Assume we have 3 threads ($P_0, P_1, P_2$) and 3 resource types ($A, B, C$).
Total Resources: $(10, 5, 7)$.

#v(1em)
#set table(inset: 0.6em, stroke: 0.5pt + gray)
#table(
  columns: (auto, 1fr, 1fr, 1fr),
  fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else { none },
  [*Thread*], [*Allocation*], [*Max*], [*Need (Max - Alloc)*],
  [$P_0$], [(0,1,0)], [(7,5,3)], [(7,4,3)],
  [$P_1$], [(2,0,0)], [(3,2,2)], [(1,2,2)],
  [$P_2$], [(3,0,2)], [(9,0,2)], [(6,0,0)],
)
#v(1em)
*Verification*: If Available resources are $(3, 3, 2)$, $P_1$ can finish, releasing its resources, followed by $P_2$, and finally $P_0$. This sequence $(P_1, P_2, P_0)$ is a *Safe Sequence*.

== 3. Deadlock Detection & Recovery
This methodology allows deadlocks to occur but runs a background task (e.g., Cycle Detection in a Wait-For-Graph) to identify them.
- *Recovery*: Kill one or more involved threads or roll back to a persistent checkpoint.

#pagebreak()

= III. Master Strategy Comparison
#v(1em)
#table(
  columns: (1.2fr, 1fr, 1.2fr, 1.3fr),
  fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else { none },
  [*Feature*], [*Prevention*], [*Avoidance*], [*Detection*],
  [Resource Costs], [Very Low], [Moderate (Tracking)], [High (Preemption)],
  [Runtime Complexity], [Static], [Dynamic (O(n²))], [Periodic Checks],
  [Implementation], [Code Design], [Resource Manager], [Kernel Task],
  [Best Use Case],
  [Application Code],
  [Safety-Critical Systems],
  [General Purpose OS],
)

#v(1em)
= IV. Implementation: The "After" State
We implemented *Resource Ordering* to resolve the identified deadlock.

== 1. The Strategy
Both threads were modified to acquire locks in the order: #m[Resource A] then #m[Resource B]. This breaks the circular wait by forcing the second thread to wait for the first lock to be released before ever attempting to claim a secondary resource.

== 2. Final Implementation Snippet
```c
void* thread_two_resolved(void* arg) {
    // RESOLUTION: Changed order from B->A to A->B
    pthread_mutex_lock(&resource_A); // Wait for A first
    printf("Thread 2: Locked Resource A.\n");
    sleep(1);
    pthread_mutex_lock(&resource_B); // Claim B
    // ... logic ...
    pthread_mutex_unlock(&resource_B);
    pthread_mutex_unlock(&resource_A);
}
```

= V. Conclusion
The transition from a circular-wait architecture to an ordered-resource hierarchy eliminated the deadlock risk without the computational overhead of dynamic avoidance algorithms. This demonstrates that robust multi-threaded design is the most efficient prevention strategy for application-level concurrency.

#set page(
  paper: "a4",
  fill: rgb("#141414"), // Dark background
  margin: (x: 2cm, y: 2.5cm),
)

#set text(
  fill: rgb("#f0f0f0"), // Light text
  font: ("Magnisa Sans", "Times New Roman"),
  size: 11pt,
)

// #set par(
//   justify: true,
//   leading: 0.7em,
//   spacing: 1.2em,
// )

// #set list(indent: 1em)
// #set enum(indent: 1em)

// #show heading: it => block(
//   text(size: 1.4em, weight: "regular", fill: rgb("#ffffff"), it.body),
// )
// #show heading.where(level: 2): it => block(
//   text(size: 1.2em, weight: "regular", fill: rgb("#ffffff"), it.body),
// )

// --- PAGE 1: COVER ---
#align(right)[
  // #v(1cm)
  #text(size: 48pt, weight: 900, font: "Magnisa Sans")[Sandeep Prasad]

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
      [Operating System], [SUB],
      [240905050085], [ERN],
      [X], [CLA],
      [I], [ALA],
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
  PROCESS \
  SCHEDULING \
  SIMULATOR
]

#pagebreak()

// --- PAGE 2: INTRODUCTION ---
= Introduction
Process scheduling is a core function of the operating system's process manager. It governs the allocation of CPU time by determining when to remove a running process and which process to execute next based on a specific strategy.

#v(0.5em)
= Core Types of Schedulers
Operating systems typically use three levels of schedulers to manage tasks efficiently:

- *Long-Term Scheduler (Job Scheduler)*: Decides which programs are admitted into the system from the job pool (disk) to the main memory (RAM). It controls the "degree of multiprogramming".
- *Short-Term Scheduler (CPU Scheduler)*: The most frequent scheduler; it selects a process from the ready queue in memory and allocates CPU time to it. It makes decisions every few milliseconds.
- *Medium-Term Scheduler*: Manages swapping processes between RAM and the disk. It removes processes from memory temporarily to free up space or reduce system load.

#v(0.5em)
= Scheduling Categories
Scheduling strategies generally fall into two main classes:

+ *Preemptive*: The OS can forcibly interrupt a running process to give the CPU to another task (e.g., if a higher-priority task arrives). Examples include *Round Robin* and *Shortest Remaining Time First*.
+ *Non-Preemptive (Cooperative)*: Once a process starts, it keeps the CPU until it either completes its task or voluntarily yields control (like waiting for I/O). Examples include *First-Come, First-Served (FCFS)*.

#v(0.5em)
= Key Performance Metrics
Schedulers are designed to balance several competing goals:

- *CPU Utilization*: Keeping the CPU as busy as possible.
- *Throughput*: Maximizing the number of processes completed per unit of time.
- *Turnaround Time*: Minimizing the total time from process submission to completion.
- *Wait Time*: Minimizing the time a process spends waiting in the ready queue.
- *Response Time*: Minimizing the time between a request and the first response, which is critical for interactive systems.

#pagebreak()

// --- PAGE 3: FCFS ---
= Scheduling Algorithms
#v(0.5em)
== I. First Come, First Serve (FCFS)

- Executes processes in arrival order.
- Simple and predictable, but can cause the convoy effect where short processes wait behind long ones.

#v(2em)
#align(center)[
  #rect(
    width: 100%,
    height: 32%,
    fill: rgb("#111115"),
    stroke: 1pt + rgb("#333"),
  )[
    #align(center + horizon)[#text(
      fill: gray,
    )[(Image Placeholder: FCFS Dataset A Results)]]
  ]
  #v(1em)
  #rect(
    width: 100%,
    height: 32%,
    fill: rgb("#111115"),
    stroke: 1pt + rgb("#333"),
  )[
    #align(center + horizon)[#text(
      fill: gray,
    )[(Image Placeholder: FCFS Dataset B Results)]]
  ]
]

#pagebreak()

// --- PAGE 4: SJF ---
== II. Shortest Job First (SJF)

- Selects the process with the smallest execution time.
- While it minimizes average waiting time, it can lead to "starvation," where long-running processes never get to run because shorter ones keep arriving.

#v(2em)
#align(center)[
  #rect(
    width: 100%,
    height: 32%,
    fill: rgb("#111115"),
    stroke: 1pt + rgb("#333"),
  )[
    #align(center + horizon)[#text(
      fill: gray,
    )[(Image Placeholder: SJF Dataset A Results)]]
  ]
  #v(1em)
  #rect(
    width: 100%,
    height: 32%,
    fill: rgb("#111115"),
    stroke: 1pt + rgb("#333"),
  )[
    #align(center + horizon)[#text(
      fill: gray,
    )[(Image Placeholder: SJF Dataset B Results)]]
  ]
]

#pagebreak()

// --- PAGE 5: PRIORITY ---
== III. Priority Scheduling

- Each process is assigned a priority level (e.g., critical system tasks vs. background apps).
- The CPU always picks the highest-priority task.
- To prevent low-priority tasks from being ignored forever (starvation), systems use aging to gradually increase their priority as they wait.

#v(2em)
#align(center)[
  #rect(
    width: 100%,
    height: 32%,
    fill: rgb("#111115"),
    stroke: 1pt + rgb("#333"),
  )[
    #align(center + horizon)[#text(
      fill: gray,
    )[(Image Placeholder: Priority Dataset A Results)]]
  ]
  #v(1em)
  #rect(
    width: 100%,
    height: 32%,
    fill: rgb("#111115"),
    stroke: 1pt + rgb("#333"),
  )[
    #align(center + horizon)[#text(
      fill: gray,
    )[(Image Placeholder: Priority Dataset B Results)]]
  ]
]

#pagebreak()

// --- PAGE 6: ROUND ROBIN ---
== IV. Round Robin (RR)

- Each process is given a small, fixed time slot called a time quantum.
- If the process isn't finished when the time is up, it is moved to the back of the queue.
- This is the standard for multitasking and time-sharing systems.

#v(2em)
#align(center)[
  #rect(
    width: 100%,
    height: 32%,
    fill: rgb("#111115"),
    stroke: 1pt + rgb("#333"),
  )[
    #align(center + horizon)[#text(
      fill: gray,
    )[(Image Placeholder: Round Robin Dataset A Results)]]
  ]
  #v(1em)
  #rect(
    width: 100%,
    height: 32%,
    fill: rgb("#111115"),
    stroke: 1pt + rgb("#333"),
  )[
    #align(center + horizon)[#text(
      fill: gray,
    )[(Image Placeholder: Round Robin Dataset B Results)]]
  ]
]

#pagebreak()

// --- PAGE 7: ANALYSIS ---
#set table(inset: 0.29em, stroke: none)

= Analysis

#v(1em)
== Dataset - A

#v(0.5em)
#table(
  columns: (auto, auto, auto, auto),
  table.hline(stroke: 0.5pt + white),
  [Process ID \ (PID)],
  [Arrival Time \ (AT)],
  [Burst Time \ (BT)],
  [Priority \ (PR)],
  table.hline(stroke: 0.5pt + white),
  [P1], [1], [12], [1],
  [P2], [7], [7], [5],
  [P3], [10], [2], [4],
  [P4], [4], [4], [5],
  [P5], [3], [3], [4],
  table.hline(stroke: 0.5pt + white),
)

#v(1em)
#table(
  columns: (auto, auto, auto, auto, auto),
  table.hline(stroke: 0.5pt + white),
  [Algorithm],
  [Avg Turnaround \ Time (ms)],
  [Avg Waiting \ Time (ms)],
  [CPU \ Utilization],
  [Context \ Switches],
  table.hline(stroke: 0.5pt + white),
  [FCFS], [16.01], [10.41], [97%], [4],
  [SJF (Non-Preemptive)], [14.41], [8.81], [97%], [4],
  [Priority (Non-Preemptive)], [14.61], [9.01], [97%], [4],
  [Round Robin (TQ=5)], [15.61], [10.01], [100%], [7],
  table.hline(stroke: 0.5pt + white),
)

#v(2em)
== Dataset - B

#v(0.5em)
#table(
  columns: (auto, auto, auto, auto),
  table.hline(stroke: 0.5pt + white),
  [Process ID \ (PID)],
  [Arrival Time \ (AT)],
  [Burst Time \ (BT)],
  [Priority \ (PR)],
  table.hline(stroke: 0.5pt + white),
  [P1], [3], [7], [2],
  [P2], [1], [1], [1],
  [P3], [10], [7], [5],
  [P4], [3], [4], [5],
  [P5], [6], [3], [2],
  table.hline(stroke: 0.5pt + white),
)

#v(1em)
#table(
  columns: (auto, auto, auto, auto, auto),
  table.hline(stroke: 0.5pt + white),
  [Algorithm],
  [Avg Turnaround \ Time  (ms)],
  [Avg Waiting \ Time  (ms)],
  [CPU \ Utilization],
  [Context  \ Switches],
  table.hline(stroke: 0.5pt + white),
  [FCFS], [8.81], [4.41], [92%], [4],
  [SJF (Non-Preemptive)], [7.41], [3.01], [92%], [4],
  [Priority (Non-Preemptive)], [8.61], [4.21], [92%], [4],
  [Round Robin (TQ=5)], [9.41], [5.01], [96%], [5],
  table.hline(stroke: 0.5pt + white),
)

#v(2em)
== Dataset - AB (Average of A and B)

#v(0.5em)
#table(
  columns: (auto, auto, auto, auto, auto),
  table.hline(stroke: 0.5pt + white),
  [Algorithm],
  [Overall Avg \ Turnaround Time],
  [Overall Avg \ Waiting Time],
  [Overall Avg  \ CPU  Utilization],
  [Avg Context \ Switches],
  table.hline(stroke: 0.5pt + white),
  [SJF (Non-Preemptive)], [10.91 ms], [5.91 ms], [94.5%], [4.0],
  [Priority (Non-Preemptive)], [11.61 ms], [6.61 ms], [94.5%], [4.0],
  [FCFS], [12.41 ms], [7.41 ms], [94.5%], [4.0],
  [Round Robin \ (TQ=5)], [12.51 ms], [7.51 ms], [98.0%], [6.0],
  table.hline(stroke: 0.5pt + white),
)

#pagebreak()

// --- PAGE 8: SUMMARY ---
= Summary

#v(1em)
#table(
  columns: (.5fr, 3fr),
  table.hline(stroke: 0.5pt + white),
  [Algorithm ], [Performance Analysis & Observations],
  table.hline(stroke: 0.5pt + white),
  [Shortest Job \ First (SJF)],
  [*Most Efficient:* Achieved the lowest average waiting time (5.91 ms) and turnaround time (10.91 ms) across all tests. This aligns with the theoretical optimality of SJF, as it systematically executes the shortest bursts first, moving processes through the system rapidly.],
  table.hline(stroke: 0.5pt + rgb("#555555")),
  [First-Come- \ First-Serve \ (FCFS)],
  [*Convoy Effect:* Yielded significantly higher waiting times, particularly in Dataset 1 where a long process (P1 with a burst of 12) arrived first. This forces all subsequent shorter processes to wait, driving up the average turnaround time.],
  table.hline(stroke: 0.5pt + rgb("#555555")),
  [Priority \ Scheduling],
  [*Balanced but Arbitrary:* Performance fell squarely in the middle. Because its efficiency relies entirely on user-defined priority integers rather than job length, its waiting and turnaround times are highly dependent on whether high-priority jobs happen to have short or long burst times.],
  table.hline(stroke: 0.5pt + rgb("#555555")),
  [Round Robin \ (RR)],
  [*High Overhead:* While excellent for response time and fairness, RR consistently produced the highest number of context switches (avg 6.0). In a real OS environment with a non-zero CS overhead, this would introduce minor latency, though it avoids the convoy effect seen in FCFS.],
  table.hline(stroke: 0.5pt + white),
)

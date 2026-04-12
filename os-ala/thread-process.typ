#let meta = json("metadata.json")

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
      [#meta.name -- #meta.subject]
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

// Custom code block styling (BLOCK)
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
      [#meta.batch], [#meta.ala],
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
  CREATION \
  USING PYTHON
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
In the domain of high-performance computing, maximizing hardware efficiency requires leveraging multiple CPU cores simultaneously. While Python is renowned for its simplicity, developers often encounter a significant bottleneck: the *Global Interpreter Lock (GIL)*. The GIL ensures that only one native thread can execute Python bytecodes at a time, making multithreading ineffective for CPU-bound tasks.

To achieve true parallelism, Python utilizes the #m[multiprocessing] module. By creating entirely separate processes—each with its own Python interpreter and memory space—developers can bypass the GIL and utilize the full power of multi-core processors.

#v(1em)
= Types of Process Creation
Python offers several methodologies for spawning and managing new processes, ranging from manual object management to high-level abstractions for massive datasets.

== I. The #m[multiprocessing.Process] Class
This is the most standard method for creating a distinct background process. It involves instantiating a #m[Process] object and passing a target function to it. This approach allows for direct control over individual child processes.

```python
import multiprocessing
import time
import os

def compute_heavy_task(name):
    print(f"Task '{name}' starting in Process ID: {os.getpid()}")
    time.sleep(2) # Simulate CPU intensive work
    print(f"Task '{name}' finished.")

if __name__ == '__main__':
    # 1. Instantiate the Process
    p1 = multiprocessing.Process(target=compute_heavy_task, args=("Data-Cruncher",))

    # 2. Trigger execution
    p1.start()

    # 3. Synchronize with main program
    p1.join()
```

== II. Subclassing #m[multiprocessing.Process]
For complex operations that require internal state encapsulation or persistent resources, developers can inherit from the base class and override the #m[run()] method.

```python
class WorkerProcess(multiprocessing.Process):
    def __init__(self, task_name):
        super().__init__()
        self.task_name = task_name

    def run(self):
        # Logic executes in the isolated process memory
        print(f"Executing {self.task_name} in PID {os.getpid()}")
```

#pagebreak()

= Modern Scalability: #m[ProcessPoolExecutor]
When processing large datasets (e.g., batch image processing or large-scale mathematical simulations), managing individual #m[Process] objects manually becomes inefficient.

The #m[concurrent.futures.ProcessPoolExecutor] class provides a high-level interface for asynchronously executing calls using a pool of processes. It automatically handles the distribution of tasks across available CPU cores, abstracting away the lifecycle management of starting and joining processes.

```python
import concurrent.futures
import math

def calculate_factorial(number):
    return math.factorial(number)

if __name__ == '__main__':
    numbers_to_process = [5000, 6000, 7000, 8000]

    # Instantiate the process pool (defaults to CPU core count)
    with concurrent.futures.ProcessPoolExecutor() as executor:
        # map() handles task distribution automatically
        results = executor.map(calculate_factorial, numbers_to_process)

        for result in results:
            print(f"Result length: {len(str(result))} digits")
```

= Inter-Process Communication (IPC)
Because processes operate in isolated memory spaces, they cannot use global variables to share state. Python provides specialized IPC structures to bridge this gap safely:

- *Queues (#m[multiprocessing.Queue])* : A thread and process-safe FIFO data structure, ideal for passing messages between multiple producer and consumer processes.
- *Pipes (#m[multiprocessing.Pipe])* : Establishes a semi-duplex or full-duplex communication channel between two specific endpoints.
- *Shared Memory*: Uses #m[Value] and #m[Array] to allocate blocks of memory that multiple processes can manipulate directly, requiring careful synchronization through #m[multiprocessing.Lock].

#pagebreak()

= Summary: Threading vs. Multiprocessing

#v(1em)
#set table(inset: 0.8em, stroke: 0.5pt + white)
#table(
  columns: (1fr, 1.5fr, 1.5fr),
  fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else { none },
  [ *Feature* ], [ *Threading* ], [ *Multiprocessing* ],
  [ GIL Restriction ], [ Bound by the GIL ], [ Bypasses the GIL ],
  [ Memory ], [ Shared memory space ], [ Separate memory space ],
  [ Overhead ], [ Low (Fast switching) ], [ High (OS resource cost) ],
  [ Best Used For ], [ I/O-bound tasks ], [ CPU-bound tasks ],
)

#v(2em)
= Conclusion
Mastering Python's process creation is essential for bypassing the Global Interpreter Lock and unlocking true hardware parallelism. While spawning processes carries higher resource overhead than threads—due to the duplication of the interpreter and memory space—the performance gains for CPU-intensive applications are indispensable for modern system engineering and data science.

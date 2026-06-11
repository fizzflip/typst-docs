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
      [Process Creation -- #meta.subject]
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
      [III], [#meta.ala],
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
  CREATION \
  OF THREADS \
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

// --- PAGE 3: INTRODUCTION & THREADING ---
#counter(page).update(1)
= Introduction
In the domain of modern software engineering, concurrency is the foundation of responsive and high-performance applications. In this report, our primary objective is to demonstrate the methodologies for the creation of threads and processes within the Python ecosystem.

We distinguish between two primary forms of concurrency:
- *Lightweight Threads*: Utilizing the #m[threading] module for I/O-bound tasks.
- *Heavyweight Processes*: Utilizing the #m[multiprocessing] module to achieve true parallelism for CPU-bound tasks, bypassing the #m[Global Interpreter Lock (GIL)].

== Glossary of Concurrency Concepts
To ensure a rigorous understanding, we define the following core terminology:
- *Race Condition*: A flaw where the system's timing or sequence of events affects the program's correctness.
- *Atomic Operation*: An operation that appears to be instantaneous to the rest of the system; it cannot be interrupted.
- *Mutex (Mutual Exclusion)*: A synchronization primitive that prevents multiple threads from accessing a shared resource simultaneously.
- *Deadlock*: A state where two or more threads are blocked forever, each waiting for the other to release a resource.

= I. Thread Creation (`threading`)
Threads are the smallest unit of execution within a process. They share the same memory space, making them highly efficient for tasks that spend time waiting for external resources.

== 1. The Target Function Pattern
The most straightforward way to spawn a thread is by passing a target function to the #m[threading.Thread] constructor.

```python
import threading
import time

def worker_task(id):
    print(f"Thread {id} is starting...")
    time.sleep(1)
    print(f"Thread {id} has completed.")

if __name__ == '__main__':
    t1 = threading.Thread(target=worker_task, args=(1,))
    t1.start()
    t1.join()
```

#v(0.5em)
== 2. Subclassing `threading.Thread`
To encapsulate complex behavior or internal state, we can inherit from the base thread class and override the #m[run()] method.

```python
class CustomThread(threading.Thread):
    def __init__(self, msg):
        super().__init__()
        self.msg = msg

    def run(self):
        print(f"Custom Thread active: {self.msg}")

if __name__ == '__main__':
    ct = CustomThread("System Monitor Active")
    ct.start()
    ct.join()
```

== 3. Thread Pools (`ThreadPoolExecutor`)
For executing many tasks efficiently, we utilize the #m[concurrent.futures.ThreadPoolExecutor]. It manages a pool of threads, reusing them for multiple tasks to reduce overhead.

```python
from concurrent.futures import ThreadPoolExecutor

if __name__ == '__main__':
    with ThreadPoolExecutor(max_workers=3) as pool:
        urls = ["site1.com", "site2.com", "site3.com"]
        pool.map(print, urls)
```

== 4. A Note on Thread Safety
Because threads share memory, we must be extremely cautious when modifying global variables. In Python, while the #m[GIL] prevents race conditions at the bytecode level for simple operations, complex state transitions still require manual synchronization to maintain data integrity.

#pagebreak()

= II. Parallelism via Multi-Processing
While threads are efficient, Python's GIL prevents them from running on multiple CPU cores simultaneously. To achieve true hardware parallelism, we utilize the #m[multiprocessing] module.

== 1. The `multiprocessing.Process` Model
Processes are independent instances of the Python interpreter with isolated memory. This separation allows us to bypass the GIL and utilize every available CPU core.

```python
import multiprocessing
import os

def cpu_intensive(n):
    print(f"Running PID {os.getpid()} for task {n}")

if __name__ == '__main__':
    p = multiprocessing.Process(target=cpu_intensive, args=("Parallel-Core",))
    p.start()
    p.join()
```

== 2. Efficiency with `ProcessPoolExecutor`
Similar to thread pools, process pools allow us to distribute massive computation tasks across all CPU cores with minimal code complexity.

```python
from concurrent.futures import ProcessPoolExecutor
import math

if __name__ == '__main__':
    data = [5000, 10000, 15000]
    with ProcessPoolExecutor() as executor:
        results = executor.map(math.factorial, data)
```

#pagebreak()

= III. Advanced Foundations and Start Methods
When we scale processes, we must understand how they are initialized at the OS level to ensure cross-platform safety.

- *Fork*: Clones the parent process’s memory space. It is the default on Unix/Linux systems but can be unstable if used with existing threads.
- *Spawn*: Starts a fresh interpreter process. It is the default on Windows and macOS, requiring all arguments to be serializable (picklable).
- *The Main Guard*: We must use #m[if __name__ == "__main__":] to prevent infinite recursion when using the #m[spawn] method.

#v(1em)
= IV. Synchronization and IPC
Effective concurrency requires that we safely coordinate data between threads or processes.

#v(0.5em)
== 1. Synchronization Primitives
- *Locks*: We use #m[threading.Lock] or #m[multiprocessing.Lock] to ensure that only one thread/process can access a critical resource at a time.
- *Semaphores*: Controls access to a resource pool with a fixed capacity.
- *Condition Variables*: Allows threads to wait for a specific state change or signal before proceeding, which is more efficient than busy-waiting.

== 2. Inter-Process Communication (IPC)
- *Queues (#m[multiprocessing.Queue])* : A robust FIFO data structure for safe message passing between isolated processes.
- *Pipes (#m[multiprocessing.Pipe])* : Establishes a direct, high-speed communication channel between two specific endpoints.
- *Managers*: In more complex scenarios, we utilize #m[multiprocessing.Manager] to share advanced objects like dictionaries or lists across process boundaries via a proxy server.

#v(1em)
= V. Process Lifecycle and Daemons
- *Daemon Processes*: Flagging a process with #m[p.daemon = True] ensures it terminates as soon as the parent finishes. This is critical for background workers.
- *Termination*: Use #m[p.terminate()] for a graceful shutdown signal. Always call #m[p.join()] after termination to avoid "zombie" processes consuming OS PIDs.

#pagebreak()

= VI. Performance and Comparison Analysis
When choosing the correct concurrency model, we must consider our tasks and the overhead involved.

#v(1em)
#set table(inset: 0.8em, stroke: 0.5pt + white)
#table(
  columns: (1fr, 1.5fr, 1.5fr),
  fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else { none },
  [ *Feature* ], [ *Threading* ], [ *Multi-Processing* ],
  [ GIL Restriction ], [ Limited to 1 CPU Core ], [ Bypasses the GIL ],
  [ Memory ], [ Shared memory space ], [ Isolated memory space ],
  [ Best Used For ], [ I/O-bound tasks ], [ CPU-bound tasks ],
  [ Resource Cost ], [ Low (Lightweight) ], [ High (Heavyweight) ],
)

#v(1em)
== Case Study: Architecture Selection Tree
To assist in system design, we use the following decision tree:
1. *Is the task spending most of its time waiting for I/O?*
  - *Yes*: Use #m[threading] or #m[asyncio] to maximize responsiveness.
2. *Is the task computationally heavy (e.g., NumPy/Math)?*
  - *Yes*: Use #m[multiprocessing] to distribute the load across multiple CPU cores.
3. *Does the task require frequent sharing of complex Python objects?*
  - *Yes*: Use #m[threading] (shared memory) or #m[multiprocessing.Manager] (proxy objects).

#v(1em)
= VII. Best Practices
To ensure robust execution in Python, we adhere to the following principles:
- *Always use the Main Guard*: Mandatory for cross-platform reliability, especially on Windows.
- *Minimize Shared State*: The most stable concurrent systems are those that pass messages rather than sharing and locking memory.
- *Use Context Managers*: Always use the #m[with] statement with Executors and Managers to ensure resources are cleaned up even if errors occur.


= VIII. Conclusion
By mastering the creation of threads and processes, we unlock the full potential of multi-core architectures, transforming Python from a single-threaded interpreter into a powerful engine for concurrent system engineering and data science.

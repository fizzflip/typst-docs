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

// --- PAGE 3: INTRODUCTION & FOUNDATIONS ---
#counter(page).update(1)
= Introduction
In the domain of high-performance computing, maximizing hardware efficiency requires leveraging multiple CPU cores simultaneously. While Python is renowned for its simplicity, developers often encounter a significant bottleneck: the #m[Global Interpreter Lock (GIL)]. The GIL ensures that only one native thread can execute Python bytecodes at a time, making multithreading ineffective for CPU-bound tasks.

To achieve true parallelism, Python utilizes the #m[multiprocessing] module. By creating entirely separate processes—each with its own Python interpreter and memory space—developers can bypass the GIL and utilize the full power of multi-core processors.

== Technical Objectives
In this report, our primary objective is to demonstrate the various methodologies for process creation and management within the Python ecosystem. By the end of this study, we will understand:
- The fundamental differences between the #m[fork] and #m[spawn] start methods.
- Patterns for direct process control and subclassing.
- Scalability patterns using process pools.
- Advanced inter-process communication and shared memory architectures.

#v(0.5em)
= Foundations: Start Methods
The way Python spawns a process depends on the operating system and the chosen start method.

- *Fork*: The Unix/Linux default. It clones the parent process via copy-on-write memory. While fast, it is inherently unstable when used in multi-threaded applications due to potential deadlock conditions in children.
- *Spawn*: The Windows and macOS default. It launches a completely fresh interpreter. It is robust but slower, and the child must re-import the main script.
- *Forkserver*: A security-focused hybrid that forks from a clean, single-threaded template process.

== The `if __name__ == "__main__":` Requirement
Because methods like #m[spawn] require re-importing the script, code sitting at the top level would execute recursively in child processes. The "main guard" prevents this infinite recursion, ensuring the entry point only runs in the original process.

#pagebreak()

= Types of Process Creation
We can utilize several methodologies for spawning and managing new processes, ranging from manual object management to high-level abstractions for massive datasets.

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

    p1.start() # Trigger execution
    p1.join()  # Synchronize with main program
```

== II. Subclassing `multiprocessing.Process`
For complex operations that require internal state encapsulation or persistent resources (like database connections), developers can inherit from the base class and override the #m[run()] method.

```python
class WorkerProcess(multiprocessing.Process):
    def __init__(self, task_name):
        super().__init__()
        self.task_name = task_name

    def run(self):
        # Logic executes in the isolated process memory
        print(f"Executing {self.task_name} in PID {os.getpid()}")

if __name__ == '__main__':
    worker = WorkerProcess("Custom-Worker")
    worker.start()
    worker.join()
```

#pagebreak()

= Synchronization Primitives
When multiple processes attempt to access the same resource (like a shared file or hardware device), synchronization is necessary to prevent data corruption and race conditions.

- *Locks (#m[multiprocessing.Lock])* : Ensures that only one process can execute a protected block of code at a time. Essential for atomic operations.
- *Semaphores*: Controls access to a resource pool with a fixed capacity.
- *Events*: A flag used to signal state changes between asynchronous processes.

```python
from multiprocessing import Process, Lock

def safe_print(l, i):
    l.acquire()
    try:
        print(f"Process {i} is printing safely.")
    finally:
        l.release()

if __name__ == '__main__':
    lock = Lock()
    for num in range(4):
        Process(target=safe_print, args=(lock, num)).start()
```

#v(1em)
= Modern Scalability: #m[ProcessPoolExecutor]
Managing individual #m[Process] objects manually becomes inefficient when dealing with hundreds of independent tasks. The #m[concurrent.futures.ProcessPoolExecutor] class provides a higher-level abstraction.

```python
import concurrent.futures
import math

def calculate_factorial(number):
    return math.factorial(number)

if __name__ == '__main__':
    numbers_to_process = [5000, 6000, 7000, 8000]
    with concurrent.futures.ProcessPoolExecutor() as executor:
        results = executor.map(calculate_factorial, numbers_to_process)
        for result in results:
            print(f"Result length: {len(str(result))} digits")
```

#pagebreak()

= Advanced Inter-Process Communication (IPC)
Because processes operate in isolated memory spaces, they cannot use global variables to share state. Python provides specialized IPC structures to bridge this gap safely.

== I. Message Passing: Queues and Pipes
- *Queues (#m[multiprocessing.Queue])* : A process-safe FIFO data structure. It is the most robust way to share work between producers and consumers.
- *Pipes (#m[multiprocessing.Pipe])* : Establishes a direct, high-speed communication channel between two specific endpoints.

== II. Shared Memory and Proxy Managers
While transition models like Pipes and Queues pass data between processes, sometimes you need to share a unified data structure like a dictionary or list.
- *Shared Memory*: Uses #m[Value] and #m[Array] to map physical memory regions. This is ideal for large numerical datasets (like NumPy arrays) where performance is a bottleneck.
- *Managers (#m[multiprocessing.Manager])*: Launches a server process that manages shared objects. It handles complex Python types like lists and dictionaries, although with higher IPC overhead.

```python
from multiprocessing import Process, Manager

def update_shared_dict(d, key, value):
    d[key] = value

if __name__ == '__main__':
    with Manager() as manager:
        shared_dict = manager.dict()
        p = Process(target=update_shared_dict, args=(shared_dict, "status", "ready"))
        p.start()
        p.join()
        print(f"Shared Status: {shared_dict['status']}")
```

#v(1em)
= Process Lifecycle and Termination
- *Daemon Processes*: Flagging a process with #m[p.daemon = True] ensures it terminates as soon as the parent finishes. This is critical for background workers that shouldn't outlive the main application.
- *Termination*: Use #m[p.terminate()] for a graceful shutdown signal or #m[p.kill()] for an immediate OS interrupt. Always call #m[p.join()] after termination to avoid "zombies."

#pagebreak()

= Performance and Comparison Analysis
When choosing the correct tool, we must consider the data complexity and performance requirements of the specific application.

#v(1em)
#set table(inset: 0.8em, stroke: 0.5pt + white)
#table(
  columns: (1fr, 1.5fr, 1.5fr),
  fill: (x, y) => if y == 0 { rgb("#1b1b1f") } else { none },
  [ *Feature* ], [ *Manager* ], [ *Shared Memory* ],
  [ Data Complexity ], [ Supports all Python Objects ], [ Only Simple C-Types ],
  [ Performance ], [ Slower (Serializing/IPC) ], [ Extremely Fast (Direct) ],
  [ Overhead ], [ Higher (Proxy Server) ], [ Highly Efficient ],
  [ Thread Safety ], [ Internal Locking ], [ Manual Locking Required ],
)

#v(2em)
= Best Practices and Conclusion
To ensure robust, parallel execution in Python, we should adhere to the following principles:
- *Always use the Main Guard*: Mandatory for cross-platform reliability.
- *Prefer Pools for Scale*: Distributing a single function over massive data is best handled by #m[ProcessPoolExecutor].
- *Minimize IPC*: Passing large objects between processes is expensive; share only simple data or use shared memory.

By mastering Python's process ecosystem, we can unlock true hardware parallelism, bypassing the GIL to create scalable, high-performance applications in data science and system engineering.

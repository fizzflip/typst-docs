#import "common.typ": *

<practical-8>
#practical_title("8")

#section("Aim")[
  To write a shell script to monitor disk usage and generate an alert if any partition exceeds 80% usage.
]

#section("Name")[
  Disk Space Monitoring and Alert Script
]

#section("Theory")[
  System administrators regularly monitor disk space to prevent system crashes. The `df` (disk free) command reports file system disk space usage. By piping the output of `df` into text processing tools like `awk`, a script can isolate the percentage usage of each partition, perform numerical comparisons against a threshold (like 80%), and trigger automated alerts. \
  *Algorithm:*
  - Define the maximum allowable disk usage threshold (80).
  - Execute the `df -h` command to retrieve disk usage statistics in a human-readable format.
  - Pipe the output to `awk` to process it line by line.
  - Skip the first line (the header).
  - Extract the usage percentage (5th column) and convert it to a numeric value.
  - If the usage is greater than or equal to the threshold, print an alert specifying the partition name (1st column) and its current usage.
]

#section("Code")[
  #code_box(width: 90%, [
    #raw(read("../scripts/practical-8.sh"), lang: "bash")
  ])
]

#pagebreak()

#section("Output")[
  #output_box(width: 80%, [
    #prompt ./disk_monitor.sh \
    Monitoring disk usage (Alert threshold: >= 80%)... \
    --------------------------------------------------------- \
    CRITICAL ALERT: Partition /dev/sda1 is at 85% usage! \
    CRITICAL ALERT: Partition /dev/sdb2 is at 81% usage! \
    \
    #prompt (Example when all partitions are under threshold) \
    #prompt ./disk_monitor.sh \
    Monitoring disk usage (Alert threshold: >= 80%)... \
    --------------------------------------------------------- \
    #prompt
  ])
]

#section("Conclusion")[
  The shell script successfully monitors system disk usage by processing `df` command output through `awk`, identifying and alerting the user only when partitions reach or exceed the defined critical threshold.

]

#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 8]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to monitor disk usage and generate an alert if any partition exceeds 80% usage.

#text(size: 14pt, weight: "bold")[Name:] \
Disk Space Monitoring and Alert Script

#text(size: 14pt, weight: "bold")[Theory:] \
System administrators regularly monitor disk space to prevent system crashes. The `df` (disk free) command reports file system disk space usage. By piping the output of `df` into text processing tools like `awk`, a script can isolate the percentage usage of each partition, perform numerical comparisons against a threshold (like 80%), and trigger automated alerts. \
*Algorithm:*
- Define the maximum allowable disk usage threshold (80).
- Execute the `df -h` command to retrieve disk usage statistics in a human-readable format.
- Pipe the output to `awk` to process it line by line.
- Skip the first line (the header).
- Extract the usage percentage (5th column) and convert it to a numeric value.
- If the usage is greater than or equal to the threshold, print an alert specifying the partition name (1st column) and its current usage.

#text(size: 14pt, weight: "bold")[Code:] \
#align(center)[
  #rect(width: 85%, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      ```bash
      #!/bin/bash
      
      THRESHOLD=80
      
      # [Boilerplate] Print startup message
      echo "Monitoring disk usage (Alert threshold: >= $THRESHOLD%)..."
      echo "---------------------------------------------------------"
      
      # Core Logic: One-liner using df and awk for maximum conciseness
      # NR>1: Skips the header row
      # $5+0: Implicitly converts the percentage string (e.g., "82%")
      # to a number (82)
      # -v t=$THRESHOLD: Passes the bash variable into awk
      
      df -h | awk -v t="$THRESHOLD" 'NR>1 && $5+0 >= t {
          print "CRITICAL ALERT: Partition "$1" is at "$5" usage!"
      }'
      ```
    ]
  ]
]

#text(size: 14pt, weight: "bold")[OUTPUT:] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ ./disk_monitor.sh \
        Monitoring disk usage (Alert threshold: >= 80%)... \
        --------------------------------------------------------- \
        CRITICAL ALERT: Partition /dev/sda1 is at 85% usage! \
        CRITICAL ALERT: Partition /dev/sdb2 is at 81% usage! \
        \
        \$ (Example when all partitions are under threshold) \
        \$ ./disk_monitor.sh \
        Monitoring disk usage (Alert threshold: >= 80%)... \
        --------------------------------------------------------- \
        \$
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully monitors system disk usage by processing `df` command output through `awk`, identifying and alerting the user only when partitions reach or exceed the defined critical threshold.


#pagebreak()

#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 12]]

#text(size: 14pt, weight: "bold")[Aim:] \
To study and practice Linux commands used for user and permissions management, networking, system monitoring, and general utilities.

#text(size: 14pt, weight: "bold")[Name:] \
Study of System, User, and Network Commands

#text(size: 14pt, weight: "bold")[Theory:] \
System administration and daily operations in Linux require a deep understanding of user privileges, network connectivity, and system resources. This suite of commands provides the necessary tools to secure files, diagnose network issues, monitor system health, and utilize general shell features efficiently.

#text(size: 14pt, weight: "bold")[COMMAND SUMMARY:]

#table(
  columns: (15%, 45%, 40%),
  inset: 7pt,
  align: horizon,
  fill: (x, y) => if y == 0 { silver },
  [*Command*], [*Description*], [*Example Usage*],
  [`who`], [Lists users currently logged into the system.], [`who`],
  [`whoami`], [Prints the effective username of the current user.], [`whoami`],
  [`chmod`], [Changes access permissions (Read/Write/Execute).], [`chmod 755 script.sh`],
  [`chown`], [Changes file/directory owner and group.], [`sudo chown user:grp file`],
)

#table(
  columns: (15%, 45%, 40%),
  inset: 7pt,
  align: horizon,
  fill: (x, y) => if y == 0 { silver },
  [*Command*], [*Description*], [*Example Usage*],
  [`ping`], [Tests reachability of a host via ICMP packets.], [`ping -c 4 google.com`],
  [`ifconfig`], [Legacy tool to view/configure network interfaces.], [`ifconfig`],
  [`ip a`], [Modern tool to show network device addresses.], [`ip a`],
)

#table(
  columns: (15%, 45%, 40%),
  inset: 7pt,
  align: horizon,
  fill: (x, y) => if y == 0 { silver },
  [*Command*], [*Description*], [*Example Usage*],
  [`uptime`], [Shows how long system is up and load average.], [`uptime`],
  [`free`], [Displays amount of free and used memory (`-h`).], [`free -h`],
  [`uname`], [Prints system information and kernel version.], [`uname -a`],
)

#table(
  columns: (15%, 45%, 40%),
  inset: 7pt,
  align: horizon,
  fill: (x, y) => if y == 0 { silver },
  [*Command*], [*Description*], [*Example Usage*],
  [`echo`], [Prints text or variable values to the screen.], [`echo $USER`],
  [`date`], [Displays or sets the system date and time.], [`date "+%D"`],
  [`history`], [Shows the list of previously executed commands.], [`history`],
  [`man`], [Opens the manual/reference for a command.], [`man chmod`],
  [`alias`], [Creates a shortcut for a longer command.], [`alias ll="ls -la"`],
)

#text(size: 14pt, weight: "bold")[OUTPUT (Sample Execution):] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ whoami \
        student \
        \
        \$ uptime \
        //  \ 20:15:01 up 2 days,  4:32,  1 user,  load average: 0.08, 0.03, 0.01 \
        \
        \$ free -h \
        total        used        free      shared  buff/cache   available \
        Mem:          7.7Gi       1.2Gi       4.5Gi       156Mi       2.0Gi       6.2Gi \
        \
        \$ ping -c 1 127.0.0.1 \
        64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.032 ms \
        \
        --- 127.0.0.1 ping statistics --- \
        1 packets transmitted, 1 received, 0% packet loss, time 0ms
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
This experiment provided hands-on experience with administrative and diagnostic Linux commands. These tools are essential for managing user environments, monitoring system resources, and troubleshooting network connectivity.

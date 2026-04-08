#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 11]]

#text(size: 14pt, weight: "bold")[Aim:] \
To study and practice standard Linux commands used for file and directory management, file manipulation, and process management.

#text(size: 14pt, weight: "bold")[Name:] \
Study of Basic Linux Commands

#text(size: 14pt, weight: "bold")[Theory:] \
An Operating System provides a command-line interface (CLI) to interact with the system kernel. In Linux, the shell interprets these commands to perform system-level tasks. Understanding these commands is fundamental for navigating the file system, manipulating data, and controlling running processes.

#text(size: 14pt, weight: "bold")[COMMAND SUMMARY:]

#table(
  columns: (15%, 45%, 40%),
  inset: 7pt,
  align: horizon,
  fill: (x, y) => if y == 0 { silver },
  [*Command*], [*Description*], [*Example Usage*],
  [`pwd`], [Displays the absolute path of the current directory.], [`pwd`],
  [`ls`], [Lists contents of a directory. Options: `-l` (long), `-a` (all).], [`ls -la`],
  [`cd`], [Changes the current working directory.], [`cd ..` or `cd ~`],
  [`mkdir`], [Creates a new, empty directory. `-p` creates parents.], [`mkdir -p new/dir`],
  [`rmdir`], [Deletes a directory (must be empty).], [`rmdir old_docs`],
  [`touch`], [Updates timestamps or creates a new empty file.], [`touch notes.txt`],
  [`mv`], [Moves or renames files and directories.], [`mv old.txt new.txt`],
)

#table(
  columns: (15%, 45%, 40%),
  inset: 7pt,
  align: horizon,
  fill: (x, y) => if y == 0 { silver },
  [*Command*], [*Description*], [*Example Usage*],
  [`cat`], [Displays file content or concatenates files.], [`cat file1 file2`],
  [`cut`], [Extracts specific sections/columns from lines.], [`cut -d',' -f1 data.csv`],
  [`sort`], [Sorts lines alphabetically or numerically (`-n`).], [`sort -r names.txt`],
  [`wc`], [Counts lines (`-l`), words (`-w`), and bytes.], [`wc -l report.txt`],
)

#table(
  columns: (15%, 45%, 40%),
  inset: 7pt,
  align: horizon,
  fill: (x, y) => if y == 0 { silver },
  [*Command*], [*Description*], [*Example Usage*],
  [`ps`], [Displays snapshot of current processes.], [`ps aux`],
  [`kill`], [Sends a signal (like SIGKILL `-9`) to a PID.], [`kill -9 1234`],
)

#text(size: 14pt, weight: "bold")[OUTPUT (Sample Execution):] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ pwd \
        /home/user/lab \
        \
        \$ mkdir test_dir && cd test_dir \
        \$ touch file1.txt file2.txt \
        \$ ls \
        file1.txt  file2.txt \
        \
        // \$ ps | head -n 3 \
        //   PID TTY          TIME CMD \
        //  1245 pts/0    00:00:00 bash \
        //  3021 pts/0    00:00:00 ps
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
Through this study, the fundamental Linux commands for system interaction were explored. Proficiency in these commands allows for efficient management of the file system and system resources directly through the shell.

#pagebreak()

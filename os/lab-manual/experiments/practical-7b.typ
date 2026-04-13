#import "common.typ": *

<practical-7b>
#practical_title("7B")

#section("Aim")[
  To write a menu-driven shell script to copy, remove, and move a file in Linux.
]

#section("Name")[
  Menu-Driven File Manager
]

#section("Theory")[
  Interactive shell scripts can serve as wrappers for standard Unix commands to make them more user-friendly. This script utilizes an infinite `while` loop combined with a `case` statement to continuously present a menu. Based on the selection, it executes the corresponding file operation commands: `cp` (copy), `rm` (remove), or `mv` (move).
]

#pagebreak()

#section("Code")[
  #code_box(width: 100%, [
    #raw(read("../scripts/practical-7b.sh"), lang: "bash")
  ])
]

#pagebreak()

#section("Output")[
  #output_box(width: 80%, [
    #prompt ./file_manager.sh \
    \
    --- File Operations --- \
    1. Copy a file \
    2. Remove a file \
    3. Move a file \
    4. Exit \
    Enter your choice (1-4): 1 \
    Enter source file: data.txt \
    Enter destination: data_backup.txt \
    Success: File copied. \
    \
    --- File Operations --- \
    1. Copy a file \
    2. Remove a file \
    3. Move a file \
    4. Exit \
    Enter your choice (1-4): 4 \
    \
    #prompt
  ])
]
#v(1em)

#section("Conclusion")[
  The shell script successfully creates a user-friendly, interactive file manager using an infinite loop and a `case` statement to execute standard Unix file operations.
]

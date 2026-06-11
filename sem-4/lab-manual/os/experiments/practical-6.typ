#import "common.typ": *

<practical-6>
#practical_title("6")

#section("Aim")[
  To write a shell script to count the number of regular files, directories, and symbolic links in a specified directory.
]

#section("Name")[
  Directory Contents Counter
]

#section("Theory")[
  In Unix-like operating systems, various file types exist. Shell scripts can differentiate between them using conditional file test operators: `-L` checks for a symbolic link, `-f` checks for a regular file, and `-d` checks for a directory. It is important to test for symbolic links first, as a link pointing to a file or directory will also evaluate as true for `-f` or `-d`.
]

#section("Code")[
  #code_box(width: 85%, [
    #raw(read("../scripts/practical-6.sh"), lang: "bash")
  ])
]

#pagebreak()

#section("Output")[
  #output_box(width: 80%, [
    #prompt ./dir_counter.sh \
    Enter directory path: /invalid_path \
    Error: '/invalid_path' is not a valid directory. \
    \
    #prompt ./dir_counter.sh \
    Enter directory path: /var/log \
    Statistics for /var/log: \
    --------------------------- \
    Regular Files  : 42 \
    Directories    : 12 \
    Symbolic Links : 3
  ])
]
#v(1em)

#section("Conclusion")[
  The shell script successfully counts and categorizes the contents of a user-specified directory into regular files, subdirectories, and symbolic links by combining an iterative loop with sequential file test operators.

]

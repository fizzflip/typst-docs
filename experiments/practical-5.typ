#import "common.typ": *

<practical-5>
#practical_title("5")

#section("Aim")[
To write a shell script that prints the names of all subdirectories present in the current directory.
]

#section("Name")[
Subdirectory Lister
]

#section("Theory")[
In Linux/UNIX systems, directories are treated as a special type of file. To filter and display only directories, a script can iterate through all items in a given path and use the file test operator `-d` to check if each item is a directory. Alternatively, shell globbing (like `*/`) can be used to match directories directly. \
*Algorithm:*
- Display a header message indicating the current directory.
- Start a loop to iterate through all items (`*`) in the current directory.
- For each item, use the conditional test `-d` to check if it is a directory.
- If the condition is true, print the name of the directory.
]

#section("Code")[
  #code_box(width: 80%, [
      ```bash
      #!/bin/bash
      
      # [Boilerplate] Print header
      echo "Subdirectories in current directory ($(pwd)):"
      echo "-------------------------------------------"
      
      # Core Logic: Loop through all items and check if they are directories
      for item in *; do
          if [ -d "$item" ]; then
              echo "$item"
          fi
      done
      ```
  ])
]

#section("Output")[
  #output_box(width: 80%, [
        \$ ls -l \
        drwxr-xr-x 2 user user 4096 Oct 24 10:00 backups \
        -rw-r--r-- 1 user user  150 Oct 24 10:05 data.txt \
        drwxr-xr-x 4 user user 4096 Oct 24 09:30 projects \
        -rwxr-xr-x 1 user user  320 Oct 24 10:15 subdir_lister.sh \
        \
        \$ ./subdir_lister.sh \
        Subdirectories in current directory (/home/user/workspace): \
        ------------------------------------------- \
        backups \
        projects
  ])
]

#section("Conclusion")[
The shell script successfully lists all subdirectories within the current working directory by iterating over its contents and utilizing the `-d` test operator to accurately filter out standard files.
]

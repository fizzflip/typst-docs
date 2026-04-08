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
In Unix-like operating systems, various file types exist. Shell scripts can differentiate between them using conditional file test operators: `-L` checks for a symbolic link, `-f` checks for a regular file, and `-d` checks for a directory. It is important to test for symbolic links first, as a link pointing to a file or directory will also evaluate as true for `-f` or `-d`. \
*Algorithm:*
- Accept a directory path from the user.
- Validate if the given path exists and is a directory.
- Initialize counters for files, directories, and links to zero.
- Iterate through the contents of the directory using a loop.
- Use file test operators to categorize each item and increment the appropriate counter.
- Display the final tallies.
]

#section("Code")[
  #code_box(width: 80%, [
      ```bash
      #!/bin/bash
      
      # Prompt user and validate input
      read -p "Enter directory path: " target_dir
      
      if [ ! -d "$target_dir" ]; then
          echo "Error: '$target_dir' is not a valid directory."
          exit 1
      fi
      
      # Initialize counters
      f_count=0
      d_count=0
      l_count=0
      
      # Core Logic: Iterate and classify
      for item in "$target_dir"/*; do
          # Skip if directory is empty (prevents '*' from being treated as a file)
          [ -e "$item" ] || [ -L "$item" ] || continue
      
          # Note: Check for links FIRST, as links to files also pass the -f test
          if [ -L "$item" ]; then
              ((l_count++))
          elif [ -f "$item" ]; then
              ((f_count++))
          elif [ -d "$item" ]; then
              ((d_count++))
          fi
      done
      
      # Print the results
      echo "Statistics for $target_dir:"
      echo "---------------------------"
      echo "Regular Files  : $f_count"
      echo "Directories    : $d_count"
      echo "Symbolic Links : $l_count"
      ```
  ])
]

#section("Output")[
  #output_box(width: 80%, [
        \$ ./dir_counter.sh \
        Enter directory path: /invalid_path \
        Error: '/invalid_path' is not a valid directory. \
        \
        \$ ./dir_counter.sh \
        Enter directory path: /var/log \
        Statistics for /var/log: \
        --------------------------- \
        Regular Files  : 42 \
        Directories    : 12 \
        Symbolic Links : 3
  ])
]

#section("Conclusion")[
The shell script successfully counts and categorizes the contents of a user-specified directory into regular files, subdirectories, and symbolic links by combining an iterative loop with sequential file test operators.

]

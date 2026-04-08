#import "common.typ": *

<practical-7a>
#practical_title("7A")

#section("Aim")[
To write a shell script to reverse the contents of a file.
]

#section("Name")[
File Content Reverser
]

#section("Theory")[
In Linux, reversing a file typically means reversing the order of its lines (printing from the last line to the first). The `tac` command (which is `cat` spelled backward) is a built-in utility specifically designed for this purpose. If reversing the actual characters on each line is required instead, the `rev` command is used. \
*Algorithm:*
- Prompt the user to enter the name of the file.
- Verify that the file exists and is a regular file.
- If it exists, use the `tac` command to read and print the file's lines in reverse order.
- If it does not exist, display an error message.
]

#section("Code")[
  #code_box(width: 80%, [
      ```bash
      #!/bin/bash
      
      # Prompt user for filename
      read -p "Enter the filename to reverse: " file
      
      # Check if file exists to prevent errors
      if [ ! -f "$file" ]; then
          echo "Error: File '$file' does not exist."
          exit 1
      fi
      
      # Print header
      echo "--- Reversed Contents ---"
      
      # Core Logic: Use 'tac' to reverse lines
      # (Note: use 'rev "$file"' to reverse characters instead)
      tac "$file"
      ```
  ])
]

#section("Output")[
  #output_box(width: 80%, [
        \$ cat sample.txt \
        First Line \
        Second Line \
        Third Line \
        \
        \$ ./reverser.sh \
        Enter the filename to reverse: invalid_file.txt \
        Error: File 'invalid_file.txt' does not exist. \
        \
        \$ ./reverser.sh \
        Enter the filename to reverse: sample.txt \
        --- Reversed Contents --- \
        Third Line \
        Second Line \
        First Line
  ])
]

#section("Conclusion")[
The shell script successfully reverses the contents of a specified file by utilizing the `tac` utility to print its lines in reverse order, while also implementing standard file existence validation.
]

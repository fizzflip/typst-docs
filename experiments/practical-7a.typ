#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 7A]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to reverse the contents of a file.

#text(size: 14pt, weight: "bold")[Name:] \
File Content Reverser

#text(size: 14pt, weight: "bold")[Theory:] \
In Linux, reversing a file typically means reversing the order of its lines (printing from the last line to the first). The `tac` command (which is `cat` spelled backward) is a built-in utility specifically designed for this purpose. If reversing the actual characters on each line is required instead, the `rev` command is used. \
*Algorithm:*
- Prompt the user to enter the name of the file.
- Verify that the file exists and is a regular file.
- If it exists, use the `tac` command to read and print the file's lines in reverse order.
- If it does not exist, display an error message.

#text(size: 14pt, weight: "bold")[Code:] \
#align(center)[
  #rect(width: 80%, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      ```bash
      #!/bin/bash
      
      # [Boilerplate] Prompt user for filename
      read -p "Enter the filename to reverse: " file
      
      # Check if file exists to prevent errors
      if [ ! -f "$file" ]; then
          echo "Error: File '$file' does not exist."
          exit 1
      fi
      
      # [Boilerplate] Print header
      echo "--- Reversed Contents ---"
      
      # Core Logic: Use 'tac' to reverse lines
      # (Note: use 'rev "$file"' to reverse characters instead)
      tac "$file"
      ```
    ]
  ]
]

#text(size: 14pt, weight: "bold")[OUTPUT:] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
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
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully reverses the contents of a specified file by utilizing the `tac` utility to print its lines in reverse order, while also implementing standard file existence validation.

#pagebreak()

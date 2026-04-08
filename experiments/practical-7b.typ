#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 7B]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a menu-driven shell script to copy, remove, and move a file in Linux.

#text(size: 14pt, weight: "bold")[Name:] \
Menu-Driven File Manager

#text(size: 14pt, weight: "bold")[Theory:] \
Interactive shell scripts can serve as wrappers for standard Unix commands to make them more user-friendly. This script utilizes an infinite `while` loop combined with a `case` statement to continuously present a menu. Based on the selection, it executes the corresponding file operation commands: `cp` (copy), `rm` (remove), or `mv` (move). \
*Algorithm:*
- Start an infinite loop to display the menu.
- Display options: 1) Copy, 2) Remove, 3) Move, 4) Exit.
- Read the user's choice.
- Using a `case` statement:
  - For option 1, read source and destination paths, then execute `cp`.
  - For option 2, read the target file path, then execute `rm`.
  - For option 3, read source and destination paths, then execute `mv`.
  - For option 4, exit the script.
- Repeat until the user selects the exit option.

#text(size: 14pt, weight: "bold")[Code:] \
#align(center)[
  #rect(width: 80%, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      ```bash
      #!/bin/bash
      
      # Core Logic: Infinite loop to keep the menu active until exit
      while true; do
          # [Boilerplate] Display menu options
          echo -e "\n--- File Operations ---"
          echo "1. Copy a file"
          echo "2. Remove a file"
          echo "3. Move a file"
          echo "4. Exit"
          read -p "Enter your choice (1-4): " choice
      
          # Switch case to handle operations
          case $choice in
              1)
                  read -p "Enter source file: " src
                  read -p "Enter destination: " dest
                  cp "$src" "$dest" && echo "Success: File copied."
                  ;;
              2)
                  read -p "Enter file to remove: " file
                  rm "$file" && echo "Success: File removed."
                  ;;
              3)
                  read -p "Enter source file: " src
                  read -p "Enter destination: " dest
                  mv "$src" "$dest" && echo "Success: File moved."
                  ;;
              4)
                  exit 0 # Exit the script successfully
                  ;;
              *)
                  echo "Invalid choice. Please select 1-4." # [Boilerplate] Error handling
                  ;;
          esac
      done
      ```
    ]
  ]
]

#text(size: 14pt, weight: "bold")[OUTPUT:] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ ./file_manager.sh \
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
        \$
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully creates a user-friendly, interactive file manager using an infinite loop and a `case` statement to execute standard Unix file operations.

#pagebreak()

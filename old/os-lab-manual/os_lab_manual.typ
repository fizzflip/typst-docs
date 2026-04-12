// ============================================================
// EXPERIMENT A
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - A]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to check whether an entered string or a number is a palindrome.
#text(size: 14pt, weight: "bold")[Name:] \
String and Number Palindrome Checker
#text(size: 14pt, weight: "bold")[Theory:] \
A palindrome is a sequence of characters or digits that reads the same forward and backward (e.g., "radar" or "12321"). In shell scripting, checking for a palindrome involves reversing the given input and performing a string comparison against the original value.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Read the input string or number from the user. \
2. Reverse the input (using the built-in `rev` command for efficiency). \
3. Compare the original input with the reversed output. \
4. If they are equal, print that it is a palindrome; otherwise, print that it is not.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully checks whether a string or number is a palindrome by reversing the input using the `rev` command and comparing it with the original.

#pagebreak()

// ============================================================
// EXPERIMENT B
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - B]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script that generates the first n Fibonacci numbers.
#text(size: 14pt, weight: "bold")[Name:] \
Fibonacci Sequence Generator
#text(size: 14pt, weight: "bold")[Theory:] \
The Fibonacci sequence is a series of numbers where the next number is found by adding up the two numbers before it. Generating this computationally requires maintaining two variables that represent the previous two terms, printing the current term, and iteratively updating the variables.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Read the desired number of terms (n) from the user. \
2. Initialize the first two terms: `a = 1` and `b = 1`. \
3. Start a loop that runs n times. \
4. In each iteration, print the current value of `a`. \
5. Calculate the next term (`next = a + b`). \
6. Update the variables (`a = b` and `b = next`).
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully generates the first n Fibonacci numbers by iteratively computing and printing each term using two running variables.

#pagebreak()

// ============================================================
// EXPERIMENT C
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - C]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to find the smallest and largest among three given numbers.
#text(size: 14pt, weight: "bold")[Name:] \
Minimum and Maximum of Three Numbers
#text(size: 14pt, weight: "bold")[Theory:] \
Finding the minimum and maximum involves sequentially comparing variables. In Bash, conditional statements (`if`) combined with arithmetic comparison operators (such as `-lt` for less than and `-gt` for greater than) are used to evaluate the relative sizes of the inputs.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Read three numbers (a, b, and c) from the user. \
2. Assume the first number `a` is both the smallest (`min`) and largest (`max`). \
3. Compare the second number `b` with `min` and `max`, updating them if necessary. \
4. Compare the third number `c` with `min` and `max`, updating them if necessary. \
5. Print the final `min` and `max` values.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully finds the smallest and largest of three numbers by sequentially comparing each value against running `min` and `max` variables.

#pagebreak()

// ============================================================
// EXPERIMENT D
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - D]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script that extracts and displays the digits located at odd positions (1st, 3rd, and 5th) in a given 6-digit number.
#text(size: 14pt, weight: "bold")[Name:] \
Odd Position Digits Extractor
#text(size: 14pt, weight: "bold")[Theory:] \
String manipulation in Bash allows for extracting specific characters using parameter expansion. The syntax `${string:position:length}` extracts a substring of a specified length starting from a specific zero-based index. Therefore, the 1st, 3rd, and 5th positions correspond to indices 0, 2, and 4.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Read a 6-digit number from the user. \
2. Extract the character at index 0 (1st position). \
3. Extract the character at index 2 (3rd position). \
4. Extract the character at index 4 (5th position). \
5. Print the extracted digits.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully extracts and displays digits at odd positions from a 6-digit number using Bash parameter expansion with zero-based indexing.

#pagebreak()

// ============================================================
// EXPERIMENT E
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - E]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to create a menu-driven calculator using the `case` statement.
#text(size: 14pt, weight: "bold")[Name:] \
Menu-Driven Calculator
#text(size: 14pt, weight: "bold")[Theory:] \
A menu-driven script presents a list of options to the user and executes specific commands based on their selection. The `case` statement in shell scripting is an efficient multi-way branching control structure, making it ideal for mapping user inputs (like choosing an arithmetic operation) to their corresponding executable blocks without using messy, deeply nested `if-elif` statements.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Prompt the user to enter two numbers. \
2. Display a menu of arithmetic operations (Addition, Subtraction, Multiplication, Division). \
3. Read the user's choice. \
4. Use a `case` statement to match the choice and perform the respective arithmetic operation. \
5. Store and display the result.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully implements a menu-driven calculator using the `case` statement, performing addition, subtraction, multiplication, and integer division based on the user's selection.

#pagebreak()

// ============================================================
// EXPERIMENT F
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - F]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script that prints the names of all subdirectories present in the current directory.
#text(size: 14pt, weight: "bold")[Name:] \
Subdirectory Lister
#text(size: 14pt, weight: "bold")[Theory:] \
In Linux/UNIX systems, directories are treated as a special type of file. To filter and display only directories, a script can iterate through all items in a given path and use the file test operator `-d` to check if each item is a directory. Alternatively, shell globbing (like `*/`) can be used to match directories directly.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Display a header message indicating the current directory. \
2. Start a loop to iterate through all items (`*`) in the current directory. \
3. For each item, use the conditional test `-d` to check if it is a directory. \
4. If the condition is true, print the name of the directory.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully lists all subdirectories in the current directory by iterating through directory contents and filtering with the `-d` file test operator.

#pagebreak()

// ============================================================
// EXPERIMENT G
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - G]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to count the number of regular files, directories, and symbolic links in a specified directory.
#text(size: 14pt, weight: "bold")[Name:] \
Directory Contents Counter
#text(size: 14pt, weight: "bold")[Theory:] \
In Unix-like operating systems, various file types exist. Shell scripts can differentiate between them using conditional file test operators: `-L` checks for a symbolic link, `-f` checks for a regular file, and `-d` checks for a directory. It is important to test for symbolic links first, as a link pointing to a file or directory will also evaluate as true for `-f` or `-d`.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Accept a directory path from the user. \
2. Validate if the given path exists and is a directory. \
3. Initialize counters for files, directories, and links to zero. \
4. Iterate through the contents of the directory using a loop. \
5. Use file test operators to categorize each item and increment the appropriate counter. \
6. Display the final tallies.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully counts and reports the number of regular files, directories, and symbolic links in a given directory by using Bash file test operators with correct precedence.

#pagebreak()

// ============================================================
// EXPERIMENT H
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - H]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to reverse the contents of a file.
#text(size: 14pt, weight: "bold")[Name:] \
File Content Reverser
#text(size: 14pt, weight: "bold")[Theory:] \
In Linux, reversing a file typically means reversing the order of its lines (printing from the last line to the first). The `tac` command (which is `cat` spelled backward) is a built-in utility specifically designed for this purpose. If reversing the actual characters on each line is required instead, the `rev` command is used.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Prompt the user to enter the name of the file. \
2. Verify that the file exists and is a regular file. \
3. If it exists, use the `tac` command to read and print the file's lines in reverse order. \
4. If it does not exist, display an error message.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully reverses the line order of a file's contents using the `tac` command, with proper validation to handle non-existent files gracefully.

#pagebreak()

// ============================================================
// EXPERIMENT I
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - I]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a menu-driven shell script to copy, remove, and move a file in Linux.
#text(size: 14pt, weight: "bold")[Name:] \
Menu-Driven File Manager
#text(size: 14pt, weight: "bold")[Theory:] \
Interactive shell scripts can serve as wrappers for standard Unix commands to make them more user-friendly. This script utilizes an infinite `while` loop combined with a `case` statement to continuously present a menu. Based on the selection, it executes the corresponding file operation commands: `cp` (copy), `rm` (remove), or `mv` (move).
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Start an infinite loop to display the menu. \
2. Display options: 1) Copy, 2) Remove, 3) Move, 4) Exit. \
3. Read the user's choice. \
4. Using a `case` statement: \
  - For option 1, read source and destination paths, then execute `cp`. \
  - For option 2, read the target file path, then execute `rm`. \
  - For option 3, read source and destination paths, then execute `mv`. \
  - For option 4, exit the script. \
5. Repeat until the user selects the exit option.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully implements a menu-driven file manager using an infinite `while` loop and `case` statement, allowing the user to copy, remove, or move files interactively until they choose to exit.

#pagebreak()

// ============================================================
// EXPERIMENT J
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - J]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to monitor disk usage and generate an alert if any partition exceeds 80% usage.
#text(size: 14pt, weight: "bold")[Name:] \
Disk Space Monitoring and Alert Script
#text(size: 14pt, weight: "bold")[Theory:] \
System administrators regularly monitor disk space to prevent system crashes. The `df` (disk free) command reports file system disk space usage. By piping the output of `df` into text processing tools like `awk`, a script can isolate the percentage usage of each partition, perform numerical comparisons against a threshold (like 80%), and trigger automated alerts.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Define the maximum allowable disk usage threshold (80). \
2. Execute the `df -h` command to retrieve disk usage statistics in a human-readable format. \
3. Pipe the output to `awk` to process it line by line. \
4. Skip the first line (the header). \
5. Extract the usage percentage (5th column) and convert it to a numeric value. \
6. If the usage is greater than or equal to the threshold, print an alert specifying the partition name (1st column) and its current usage.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully monitors disk partitions using `df` and `awk`, printing a critical alert for any partition whose usage meets or exceeds the defined 80% threshold.

#pagebreak()

// ============================================================
// EXPERIMENT K
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - K]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script that translates capital letters to small letters and small letters to capital letters using the `awk` command.
#text(size: 14pt, weight: "bold")[Name:] \
Case Inversion using AWK
#text(size: 14pt, weight: "bold")[Theory:] \
While the `tr` command is normally the go-to tool for character swapping in shell scripts, the `awk` text-processing language can also achieve this programmatically. It does so by isolating each character, matching it against regular expressions (`/[A-Z]/` or `/[a-z]/`), and dynamically applying the built-in string functions `tolower()` and `toupper()`.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Read an input string from the user. \
2. Pipe the string into `awk`. \
3. Within `awk`, initiate a loop that runs for the `length` of the string. \
4. Extract each character one by one using the `substr()` function. \
5. Check the character's case. If uppercase, convert to lowercase. If lowercase, convert to uppercase. \
6. Concatenate the converted characters and print the final result.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the bash script image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Bash Script Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully inverts the case of every letter in an input string using `awk`, converting uppercase characters to lowercase and lowercase to uppercase, while leaving non-alphabetic characters unchanged.

#pagebreak()

// ============================================================
// EXPERIMENT L
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - L]]
#text(size: 14pt, weight: "bold")[Aim:] \
To write a C program to create a new process using the `fork()` system call and compile it using the GCC compiler.
#text(size: 14pt, weight: "bold")[Name:] \
Process Creation using `fork()`
#text(size: 14pt, weight: "bold")[Theory:] \
In UNIX/Linux operating systems, a new process is created using the `fork()` system call. The newly created process is called the child process, which is an almost exact duplicate of the calling process (the parent). `fork()` returns a process ID (PID): it returns `0` to the child process, a positive integer (the child's PID) to the parent, and a negative value if process creation fails.
#text(size: 14pt, weight: "bold")[Algorithm:] \
1. Include the necessary standard libraries (`<stdio.h>`, `<unistd.h>`, `<sys/types.h>`). \
2. Declare a variable of type `pid_t` to store the process ID. \
3. Call the `fork()` function and assign its return value to the variable. \
4. Use an `if-else` block to evaluate the return value: \
  - If the value is less than 0, print an error message (Fork failed). \
  - If the value equals 0, print a message identifying as the child process, displaying its PID (`getpid()`) and its parent's PID (`getppid()`). \
  - If the value is greater than 0, print a message identifying as the parent process, displaying its own PID and the newly created child's PID. \
5. Exit the program.
#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the C program image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[C Program Code Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The C program successfully demonstrates process creation using the `fork()` system call. Both the parent and child processes execute concurrently, each identifying themselves through their respective PIDs, compiled and run using the GCC compiler.

#pagebreak()

// ============================================================
// EXPERIMENT M
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - M]]
#text(size: 14pt, weight: "bold")[Aim:] \
To study and practice standard Linux commands used for file and directory management, file manipulation, and process management.
#text(size: 14pt, weight: "bold")[Name:] \
Study of Basic Linux Commands
#text(size: 14pt, weight: "bold")[Theory:] \
An Operating System provides a command-line interface (CLI) to interact with the system kernel. In Linux, the shell interprets these commands to perform system-level tasks. Understanding these commands is fundamental for navigating the file system, manipulating data, and controlling running processes.

*Part 1: File and Directory Management* \
These commands are used to navigate the file system hierarchy, create, remove, and manage files and directories.

- *`pwd` (Print Working Directory):* Displays the absolute path of the current directory you are working in. Syntax: `pwd`. Example: `pwd` (Output: `/home/user/Documents`)

- *`ls` (List):* Lists the contents (files and directories) present in the current or specified directory. Syntax: `ls [options] [directory]`. Examples: `ls` (Lists standard contents), `ls -l` (Lists in long format, showing permissions, owner, size, and modified date), `ls -a` (Lists all files, including hidden files starting with a dot `.`)

- *`cd` (Change Directory):* Changes the current working directory to a specified path. Syntax: `cd [directory_path]`. Examples: `cd /etc` (Navigates to the `/etc` directory), `cd ..` (Moves up one level to the parent directory), `cd ~` (Navigates to the current user's home directory)

- *`mkdir` (Make Directory):* Creates a new, empty directory. Syntax: `mkdir [options] directory_name`. Examples: `mkdir project` (Creates a directory named "project"), `mkdir -p path/to/dir` (Creates parent directories as needed if they don't exist)

- *`rmdir` (Remove Directory):* Deletes a directory, but only if it is completely empty. Syntax: `rmdir directory_name`. Example: `rmdir old_project`

- *`touch`:* Primarily used to update the access and modification times of a file. If the file does not exist, it creates a new, empty file. Syntax: `touch filename`. Example: `touch newfile.txt`

- *`mv` (Move/Rename):* Moves files or directories from one location to another. It is also used to rename a file if the destination is in the same directory but has a different name. Syntax: `mv source destination`. Examples: `mv file.txt /home/user/Documents/` (Moves the file), `mv old_name.txt new_name.txt` (Renames the file)

*Part 2: File Viewing and Manipulation* \
These commands are used to read file contents, extract specific data, organize it, and gather statistics.

- *`cat` (Concatenate):* Reads data from files and outputs their contents to the terminal. It can also be used to concatenate multiple files. Syntax: `cat [options] [file...]`. Examples: `cat notes.txt` (Displays the contents of notes.txt), `cat file1.txt file2.txt > combined.txt` (Concatenates file1 and file2 into combined.txt)

- *`cut`:* Extracts specific sections (like columns or fields) from each line of a file or piped data. Syntax: `cut [options] [file]`. Examples: `cut -d',' -f1 data.csv` (Extracts the 1st field of a CSV file, using a comma as the delimiter), `cut -c1-5 text.txt` (Extracts the first 5 characters of each line)

- *`sort`:* Sorts the lines of a text file numerically or alphabetically. Syntax: `sort [options] [file]`. Examples: `sort names.txt` (Sorts names alphabetically from A-Z), `sort -r names.txt` (Sorts in reverse order Z-A), `sort -n numbers.txt` (Sorts the file numerically)

- *`wc` (Word Count):* Prints the number of lines, words, and bytes/characters in a file. Syntax: `wc [options] [file]`. Examples: `wc report.txt` (Outputs lines, words, and bytes), `wc -l report.txt` (Outputs only the number of lines), `wc -w report.txt` (Outputs only the number of words)

*Part 3: Process Management* \
These commands are used to monitor active programs (processes) and send them signals to change their state or terminate them.

- *`ps` (Process Status):* Provides a snapshot of the currently running processes and their Process IDs (PIDs). Syntax: `ps [options]`. Examples: `ps` (Shows processes for the current shell), `ps -ef` (Shows a detailed, full-format listing of all processes on the system), `ps aux` (Shows all processes running by all users with CPU/Memory usage stats)

- *`kill`:* Sends a specific signal to a process, usually to terminate it. You must know the Process ID (PID) to use this command. Syntax: `kill [signal] PID`. Examples: `kill 1234` (Sends the default SIGTERM signal to gently ask PID 1234 to terminate), `kill -9 1234` (Sends the SIGKILL signal to force PID 1234 to terminate immediately without cleanup)

#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the terminal demonstration image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Command Demonstration Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The study of basic Linux commands covering file and directory management, file viewing and manipulation, and process management provides a foundational understanding of the Linux CLI necessary for effective system administration and OS lab work.

#pagebreak()

// ============================================================
// EXPERIMENT N
// ============================================================
#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - N]]
#text(size: 14pt, weight: "bold")[Aim:] \
To study and practice Linux commands used for user and permissions management, networking, system monitoring, and general utilities.
#text(size: 14pt, weight: "bold")[Name:] \
Study of System, User, and Network Commands
#text(size: 14pt, weight: "bold")[Theory:] \
System administration and daily operations in Linux require a deep understanding of user privileges, network connectivity, and system resources. This suite of commands provides the necessary tools to secure files, diagnose network issues, monitor system health, and utilize general shell features efficiently.

*Part 1: User and Permissions Management* \
Linux is a multi-user environment. These commands control who is logged in and who has access to specific files.

- *`who`:* Displays a list of users who are currently logged into the system. Syntax: `who [options]`. Example: `who` (Outputs the username, terminal line, and login time)

- *`whoami`:* Prints the effective username of the current user. Useful when you have switched users (e.g., using `su` or `sudo`). Syntax: `whoami`. Example: `whoami` (Output: `root` or `student`)

- *`chmod` (Change Mode):* Changes the access permissions (read, write, execute) of files and directories. It can use symbolic mode (like `+x` for execute) or numeric/octal mode (like `755`). Syntax: `chmod [permissions] file_name`. Examples: `chmod +x script.sh` (Makes the script executable for everyone), `chmod 755 app.py` (Grants read/write/execute to owner, and read/execute to group and others)

- *`chown` (Change Owner):* Changes the user and/or group ownership of a given file or directory. Usually requires root/sudo privileges. Syntax: `chown [owner]:[group] file_name`. Examples: `sudo chown student file.txt` (Changes the owner to 'student'), `sudo chown student:developers project/` (Changes the owner to 'student' and group to 'developers')

*Part 2: Networking* \
These commands are used to test network connections and view interface configurations.

- *`ping`:* Tests the reachability of a host on an Internet Protocol (IP) network by sending ICMP Echo Request packets and waiting for replies. Press `Ctrl+C` to stop it in Linux. Syntax: `ping [hostname_or_IP]`. Examples: `ping google.com` (Pings Google's servers continuously), `ping -c 4 192.168.1.1` (Sends exactly 4 ping requests and stops)

- *`ifconfig` / `ip` (Linux equivalents to `ipconfig`):* Displays the current network interface configuration, including IP addresses, MAC addresses, and subnet masks. `ifconfig` is the older tool; `ip` is the modern standard. Syntax: `ifconfig` OR `ip a`. Examples: `ifconfig` (Displays all active network interfaces), `ip a` (Shows addresses for all network devices)

*Part 3: System Monitoring* \
These commands provide snapshots of system health, hardware architecture, and resource consumption.

- *`uptime`:* Tells you how long the system has been running, how many users are currently logged on, and the system load averages for the past 1, 5, and 15 minutes. Syntax: `uptime`. Example: `uptime`

- *`free`:* Displays the total amount of free and used physical and swap memory in the system, as well as the buffers and caches used by the kernel. Syntax: `free [options]`. Examples: `free` (Displays memory in kilobytes), `free -h` (Displays memory in human-readable format, e.g., MB or GB)

- *`uname` (Unix Name):* Prints basic information about the operating system name and system hardware. Syntax: `uname [options]`. Examples: `uname` (Output: `Linux`), `uname -a` (Prints all system information, including kernel version and architecture)

*Part 4: General Utilities* \
These are everyday shell commands used for terminal management, scripting, and getting help.

- *`echo`:* Prints text or the value of variables to the terminal screen. Heavily used in shell scripts. Syntax: `echo [string/variable]`. Examples: `echo "Hello World"` (Prints the text), `echo $PATH` (Prints the value of the PATH environment variable)

- *`date`:* Displays or sets the system date and time. Syntax: `date [options] [+format]`. Examples: `date` (Displays current date and time), `date "+%Y-%m-%d"` (Displays the date in YYYY-MM-DD format)

- *`history`:* Displays the list of previously executed commands in the current user's terminal session. Syntax: `history`. Example: `history` (You can re-run a command from the list by typing `!number`, e.g., `!42`)

- *`man` (Manual):* Opens the system reference manual for a specific command, detailing its usage, options, and syntax. Syntax: `man command_name`. Example: `man ls` (Opens the manual page for the `ls` command. Press 'q' to quit)

- *`clear`:* Clears the terminal screen of all previous output, giving you a clean slate. Syntax: `clear`. Example: `clear` (Alternatively, use the keyboard shortcut `Ctrl+L`)

- *`alias`:* Allows you to create a shortcut name for a longer command or a command with frequently used options. Syntax: `alias name="command"`. Examples: `alias` (Lists all currently defined aliases), `alias ll="ls -la"` (Creates a shortcut so typing `ll` executes `ls -la`)

#text(size: 14pt, weight: "bold")[CODE:] \
// Placeholder for the terminal demonstration image
#align(center)[
  #rect(
    width: 80%,
    height: 180pt,
    fill: rgb("f4f0ef"),
    stroke: 1pt + luma(200),
  )[
    #align(center + horizon)[Command Demonstration Image Placeholder]
  ]
]
#text(size: 14pt, weight: "bold")[OUTPUT:] \
// Placeholder for the terminal output image
#align(center)[
  #rect(width: 80%, height: 180pt, fill: rgb("300a24"), stroke: 1pt + black)[
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]
#text(size: 14pt, weight: "bold")[Conclusion:] \
The study of system, user, and network commands covers essential Linux administration tools spanning user and permissions management, network diagnostics, system health monitoring, and general-purpose shell utilities, forming a comprehensive toolkit for effective OS lab practice.

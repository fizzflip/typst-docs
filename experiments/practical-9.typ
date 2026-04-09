#import "common.typ": *

<practical-9>
#practical_title("9")

#section("Aim")[
  To write a shell script that translates capital letters to small letters and small letters to capital letters using the awk command.
]

#section("Name")[
  Case Inversion using AWK
]

#section("Theory")[
  While the `tr` command is normally the go-to tool for character swapping in shell scripts, the `awk` text-processing language can also achieve this programmatically. It does so by isolating each character, matching it against regular expressions (`/[A-Z]/` or `/[a-z]/`), and dynamically applying the built-in string functions `tolower()` and `toupper()`. \
  *Algorithm:*
  - Read an input string from the user.
  - Pipe the string into `awk`.
  - Within `awk`, initiate a loop that runs for the length of the string.
  - Extract each character one by one using the `substr()` function.
  - Check the character's case. If uppercase, convert to lowercase. If lowercase, convert to uppercase.
  - Concatenate the converted characters and print the final result.
]

#section("Code")[
  #code_box(width: 80%, [
    ```bash
    #!/bin/bash

    # Prompt user for input
    read -p "Enter a string to toggle case: " input
    echo -n "Converted string: "

    # Core Logic: awk script to iterate through characters and swap cases
    echo "$input" | awk '{
        out = ""
        for (i=1; i<=length($0); i++) {
            c = substr($0, i, 1)
            if (c ~ /[A-Z]/) {
                out = out tolower(c)
            } else if (c ~ /[a-z]/) {
                out = out toupper(c)
            } else {
                out = out c # Keep numbers and special characters as is
            }
        }
        print out
    }'
    ```
  ])
]

#pagebreak()

#section("Output")[
  #output_box(width: 80%, [
    \$ ./case_toggle.sh \
    Enter a string to toggle case: Hello World! \
    Converted string: hELLO wORLD! \
    \
    \$ ./case_toggle.sh \
    Enter a string to toggle case: BASH script 123 \
    Converted string: bash SCRIPT 123
  ])
]

#section("Conclusion")[
  The shell script successfully performs case inversion on a given string by using `awk` to iterate through individual characters and apply conditional transformations based on regular expression matching.
]

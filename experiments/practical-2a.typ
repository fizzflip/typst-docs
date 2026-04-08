#import "common.typ": *

#practical_title("2A")

#section("Aim")[
To write a shell script to check whether an entered string or a number is a palindrome.
]

#section("Name")[
String and Number Palindrome Checker
]

#section("Theory")[
A palindrome is a sequence of characters or digits that reads the same forward and backward (e.g., "radar" or "12321"). In shell scripting, checking for a palindrome involves reversing the given input and performing a string comparison against the original value. \
*Algorithm:*
- Read the input string or number from the user.
- Reverse the input (using the built-in `rev` command for efficiency).
- Compare the original input with the reversed output.
- If they are equal, print that it is a palindrome; otherwise, print that it is not.
]

#section("Code")[
  #code_box(width: 80%, [
      ```bash
      #!/bin/bash
      
      # [Boilerplate] Prompt user for input
      read -p "Enter a string or number: " input
      
      # Reverse the input
      reversed=$(echo "$input" | rev)
      
      # Core Logic: Compare strings
      if [ "$input" == "$reversed" ]; then
          echo "Result: '$input' is a Palindrome."
      else
          echo "Result: '$input' is NOT a Palindrome."
      fi
      ```
  ])
]

#section("Output")[
  #output_box(width: 80%, [
        \$ ./palindrome_checker.sh \
        Enter a string or number: radar \
        Result: 'radar' is a Palindrome. \
        \
        \$ ./palindrome_checker.sh \
        Enter a string or number: 12345 \
        Result: '12345' is NOT a Palindrome.
  ])
]

#section("Conclusion")[
The shell script successfully determines whether an entered string or number is a palindrome by effectively reversing it and performing a string comparison.
]

#pagebreak()

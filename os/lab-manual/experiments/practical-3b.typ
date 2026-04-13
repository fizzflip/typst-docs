#import "common.typ": *

<practical-3b>
#practical_title("3B")

#section("Aim")[
  To write a shell script that extracts and displays the digits located at odd positions (1st, 3rd, and 5th) in a given 6-digit number.
]

#section("Name")[
  Odd Position Digits Extractor
]

#section("Theory")[
  String manipulation in Bash allows for extracting specific characters using parameter expansion. The syntax `${string:position:length}` extracts a substring of a specified length starting from a specific zero-based index. Therefore, the 1st, 3rd, and 5th positions correspond to indices 0, 2, and 4. \
  *Algorithm:*
  - Read a 6-digit number from the user.
  - Extract the character at index 0 (1st position).
  - Extract the character at index 2 (3rd position).
  - Extract the character at index 4 (5th position).
  - Print the extracted digits.
]

#pagebreak()

#section("Code")[
  #code_box(width: 80%, [
    #raw(read("../scripts/practical-3b.sh"), lang: "bash")
  ])
]
#v(1em)

#section("Output")[
  #output_box(width: 80%, [
    #prompt ./odd_digits.sh \
    Enter a 6-digit number: 123456 \
    Digits at odd positions (1st, 3rd, 5th): 1, 3, 5 \
    \
    #prompt ./odd_digits.sh \
    Enter a 6-digit number: 987654 \
    Digits at odd positions (1st, 3rd, 5th): 9, 7, 5
  ])
]
#v(1em)

#section("Conclusion")[
  The shell script successfully extracts and prints the digits at the 1st, 3rd, and 5th positions from a 6-digit number by utilizing Bash's built-in string parameter expansion capabilities.

]

#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 3B]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script that extracts and displays the digits located at odd positions (1st, 3rd, and 5th) in a given 6-digit number.

#text(size: 14pt, weight: "bold")[Name:] \
Odd Position Digits Extractor

#text(size: 14pt, weight: "bold")[Theory:] \
String manipulation in Bash allows for extracting specific characters using parameter expansion. The syntax `${string:position:length}` extracts a substring of a specified length starting from a specific zero-based index. Therefore, the 1st, 3rd, and 5th positions correspond to indices 0, 2, and 4. \
*Algorithm:*
- Read a 6-digit number from the user.
- Extract the character at index 0 (1st position).
- Extract the character at index 2 (3rd position).
- Extract the character at index 4 (5th position).
- Print the extracted digits.

#text(size: 14pt, weight: "bold")[Code:] \
#align(center)[
  #rect(width: 80%, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      ```bash
      #!/bin/bash
      
      # [Boilerplate] Prompt user for input
      read -p "Enter a 6-digit number: " num
      
      # Core Logic: Use parameter expansion to extract characters by index (0-based)
      pos1=${num:0:1}
      pos3=${num:2:1}
      pos5=${num:4:1}
      
      # [Boilerplate] Print the results
      echo "Digits at odd positions (1st, 3rd, 5th): $pos1, $pos3, $pos5"
      ```
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Output:] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ ./odd_digits.sh \
        Enter a 6-digit number: 123456 \
        Digits at odd positions (1st, 3rd, 5th): 1, 3, 5 \
        \
        \$ ./odd_digits.sh \
        Enter a 6-digit number: 987654 \
        Digits at odd positions (1st, 3rd, 5th): 9, 7, 5
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully extracts and prints the digits at the 1st, 3rd, and 5th positions from a 6-digit number by utilizing Bash's built-in string parameter expansion capabilities.


#pagebreak()

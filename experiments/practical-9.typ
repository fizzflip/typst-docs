#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 9]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script that translates capital letters to small letters and small letters to capital letters using the awk command.

#text(size: 14pt, weight: "bold")[Name:] \
Case Inversion using AWK

#text(size: 14pt, weight: "bold")[Theory:] \
While the `tr` command is normally the go-to tool for character swapping in shell scripts, the `awk` text-processing language can also achieve this programmatically. It does so by isolating each character, matching it against regular expressions (`/[A-Z]/` or `/[a-z]/`), and dynamically applying the built-in string functions `tolower()` and `toupper()`. \
*Algorithm:*
- Read an input string from the user.
- Pipe the string into `awk`.
- Within `awk`, initiate a loop that runs for the length of the string.
- Extract each character one by one using the `substr()` function.
- Check the character's case. If uppercase, convert to lowercase. If lowercase, convert to uppercase.
- Concatenate the converted characters and print the final result.

#text(size: 14pt, weight: "bold")[Code:] \
#align(center)[
  #rect(width: 80%, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      ```bash
      #!/bin/bash
      
      # [Boilerplate] Prompt user for input
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
    ]
  ]
]

#text(size: 14pt, weight: "bold")[OUTPUT:] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ ./case_toggle.sh \
        Enter a string to toggle case: Hello World! \
        Converted string: hELLO wORLD! \
        \
        \$ ./case_toggle.sh \
        Enter a string to toggle case: BASH script 123 \
        Converted string: bash SCRIPT 123
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully performs case inversion on a given string by using `awk` to iterate through individual characters and apply conditional transformations based on regular expression matching.

#pagebreak()

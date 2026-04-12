#set page(
  header: align(
    right,
  )[Name: Rahul Sharma | Enrollment No: 123456 | Subject: Operating System],
  footer: align(center)[#context counter(page).display()],
)
#set text(font: "Times New Roman", size: 12pt)
#set par(justify: true, leading: 1.5em)

#align(center)[
  #text(size: 20pt, weight: "bold")[GYANMANJARI INNOVATIVE UNIVERSITY]

  #v(1em)
  #text(size: 18pt, weight: "bold")[OS PRACTICAL FILE FORMATE]

  #v(1em)
  // Placeholder for the GMIU Logo
  #rect(width: 50%, height: 150pt, stroke: 1pt + black)[Logo Image Placeholder]
  #v(1em)
]

NAME: \
ENROLLMENT: \
CLASS: \
BATCH: \
BRANCH: \
FACULTY: Prof. Rahul P. Jani (RPJ)

#pagebreak()

#align(center)[#text(size: 18pt, weight: "bold")[INSTRUCTIONS]]

#text(
  size: 14pt,
  weight: "bold",
)[Operating System Practical File – Instructions]

#text(size: 14pt, weight: "bold")[Formatting]
- Font: Times New RomanPractical Heading : 20 or 18
- Heading: 14 (Bold), Content: 12
- Line spacing: 1.5
- Alignment: Justified

#text(size: 14pt, weight: "bold")[Header and Footer]
- Header: Name, Enrollment Number, Subject
- Footer: Page Number
- Example:
- Name: Rahul Sharma | Enrollment No: 123456 | Subject: Operating System

#text(size: 14pt, weight: "bold")[File Structure]
- Cover Page: College name, subject, student details, date
- Index Page: Experiment name and page number

#text(size: 14pt, weight: "bold")[Experiment Forma]
- Title
- Aim
- Theory (short)
- Algorithm (if required)
- Program

#text(size: 14pt, weight: "bold")[Notes]
- Maintain same format
- Write neatly
- Avoid cutting or overwriting
- Use simple English

#pagebreak()

#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 1]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script that checks whether a given number is a palindrome or not.

#text(size: 14pt, weight: "bold")[Name:] \
Palindrome Number Check using Bash Script

#text(size: 14pt, weight: "bold")[Theory:] \
A palindrome number is a number that remains the same when its digits are reversed. \
For example: 121, 1331 are palindromes, while 123 is not. \
In this practical:
- We take a number as input from the user.
- Use the rev command to reverse the number.
- Compare the original number with the reversed number.
- If both are the same, it is a palindrome; otherwise, it is not.

#text(size: 14pt, weight: "bold")[CODE :] \
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
    #align(left)[
      #text(fill: white)[Terminal Output Image Placeholder]
    ]
    #align(center + horizon)[#text(
      fill: white,
    )[Terminal Output Image Placeholder]]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully checks whether a number is a palindrome by reversing it and comparing it with the original input.


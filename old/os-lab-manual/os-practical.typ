#set page(paper: "a4")
#set text(font: "Times New Roman", size: 12pt)
#set par(justify: true, leading: 0.5em)

// PAGE 1
#align(center)[
  #v(2em)
  NAME: [cite: 1] \
  #v(1em)
  #text(
    size: 18pt,
    weight: "bold",
  )[GYANMANJARI INNOVATIVE UNIVERSITY [cite: 2]] \
  #v(0.5em)
  #text(size: 16pt, weight: "bold")[OS PRACTICAL FILE FORMATE [cite: 3]] \
  #v(2em)
  #align(left)[
    ENROLLMENT: [cite: 4] \
    CLASS: [cite: 5] \
    BATCH: [cite: 6] \
    BRANCH: [cite: 7] \
  ]
  #v(3em)
  दिव्यम् ददामि ते चक्षुः [cite: 8] \
  #v(2em)
  FACULTY: Prof. Rahul P. Jani (RPJ) [cite: 9] \
  GMIU [cite: 10]
]

#pagebreak()

// PAGE 2
#text(size: 14pt, weight: "bold")[INSTRUCTIONS [cite: 11]] \
#text(
  size: 14pt,
  weight: "bold",
)[Operating System Practical File - Instructions [cite: 12]] \
#v(1em)

*1. Formatting* [cite: 13] \
: [cite: 14] \
Font: Times New Roman [cite: 15] \
Practical Heading: 20 or 18 [cite: 16] \
Heading: 14 (Bold), Content: 12 \
Line spacing: 1.5 [cite: 17] \
Alignment: Justified [cite: 18] \
#v(1em)

*Header and Footer* [cite: 19] \
Header: Name, Enrollment Number, Subject [cite: 20] \
Footer: Page Number [cite: 21] \
Example: [cite: 22] \
Name: Rahul Sharma | Enrollment No: 123456 | Subject: Operating System [cite: 23] \
#v(1em)

*3. File Structure* [cite: 24] \
Cover Page: College name, subject, student details, date [cite: 25] \
Index Page: Experiment name and page number [cite: 26] \
#v(1em)

*4. Experiment Forma* [cite: 27] \
Title [cite: 28] \
Aim [cite: 29] \
Theory (short) [cite: 30] \
Algorithm (if required) [cite: 31] \
Program [cite: 32] \
#v(1em)

*6. Notes* [cite: 33] \
Maintain same format [cite: 34] \
Write neatly [cite: 35] \
Avoid cutting or overwriting [cite: 36] \
Use simple English [cite: 37] \

#pagebreak()

// PAGE 3
#text(size: 18pt, weight: "bold")[PRACTICAL - 1 [cite: 38]] \
#v(1em)

*Aim:* [cite: 39] \
To write a shell script that checks whether a given number is a palindrome or not. [cite: 40] \
#v(1em)

*Name:* [cite: 41] \
Palindrome Number Check using Bash Script [cite: 42] \
#v(1em)

*Theory:* [cite: 43] \
A palindrome number is a number that remains the same when its digits are reversed. [cite: 44] \
For example: 121, 1331 are palindromes, while 123 is not. [cite: 45] \
In this practical: [cite: 46] \
We take a number as input from the user. [cite: 47] \
Use the rev command to reverse the number. [cite: 48] \
Compare the original number with the reversed number. If both are the same, it is a palindrome; [cite: 49] \
otherwise, it is not. [cite: 50] \
#v(1em)

*CODE:* [cite: 51] \
```bash
#!/bin/bash [cite: 52]
echo "Enter a NUMBER : [cite: 53]
read s [cite: 54]
11 [cite: 55]
condition=\$(echo "\$s" | rev) [cite: 56]
if [ "\$s" = "\$condition" ]
 then [cite: 57]
echo "YESSS: it is [cite: 58]
else [cite: 59]
echo "NOPE" [cite: 60]
fi [cite: 61]
```
#pagebreak()

// PAGE 4
// Simulated terminal output image block for visual layout
// #align(center)[
//   rect(width: 90%, height: 180pt, fill: rgb("300a24"), radius: 5pt)[
// align(left + top)[
// pad(10pt)[
// text(fill: white, font: "Courier", size: 10pt)[
// File Edit View Search Terminal Help

// #text(fill: rgb("8ae234"))[mark@linux-desktop:~]$
// ]
// ]
// ]
// ]
// ]
#v(1em)


OUTPUT:

// File Edit View Search Terminal Help mark@linux-desktop:~$

// mark@linux-desktop:~

#v(1em)


Conclusion:

The shell script successfully checks whether a number is a palindrome by reversing it and comparing it with the original input.

#v(2em)

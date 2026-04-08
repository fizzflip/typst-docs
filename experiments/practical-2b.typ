#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 2B]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script that generates the first $n$ Fibonacci numbers.

#text(size: 14pt, weight: "bold")[Name:] \
Fibonacci Sequence Generator

#text(size: 14pt, weight: "bold")[Theory:] \
The Fibonacci sequence is a series of numbers where the next number is found by adding up the two numbers before it. Generating this computationally requires maintaining two variables that represent the previous two terms, printing the current term, and iteratively updating the variables. \
*Algorithm:*
- Read the desired number of terms ($n$) from the user.
- Initialize the first two terms: `a = 1` and `b = 1`.
- Start a loop that runs $n$ times.
- In each iteration, print the current value of `a`.
- Calculate the next term (`next = a + b`).
- Update the variables (`a = b` and `b = next`).

#text(size: 14pt, weight: "bold")[Code:] \
#align(center)[
  #rect(width: 80%, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      ```bash
      #!/bin/bash
      
      read -p "Enter the number of terms (n): " n
      
      # Initialize first two terms
      a=1
      b=1
      
      echo -n "Fibonacci Series: "
      
      # Core Logic: Loop n times to calculate and print
      for (( i=0; i<n; i++ ))
      do
          echo -n "$a "
          next=$((a + b))
          a=$b
          b=$next
      done
      ```
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Output:] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ ./fibonacci_generator.sh \
        Enter the number of terms (n): 7 \
        Fibonacci Series: 1 1 2 3 5 8 13 \
        \
        \$ ./fibonacci_generator.sh \
        Enter the number of terms (n): 10 \
        Fibonacci Series: 1 1 2 3 5 8 13 21 34 55
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully generates the Fibonacci sequence up to the user-specified number of terms using an iterative loop and variable reassignment.

#pagebreak()

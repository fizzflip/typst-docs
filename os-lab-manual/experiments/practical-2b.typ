#import "common.typ": *

<practical-2b>
#practical_title("2B")

#section("Aim")[
  To write a shell script that generates the first $n$ Fibonacci numbers.
]

#section("Name")[
  Fibonacci Sequence Generator
]

#section("Theory")[
  The Fibonacci sequence is a series of numbers where the next number is found by adding up the two numbers before it. Generating this computationally requires maintaining two variables that represent the previous two terms, printing the current term, and iteratively updating the variables.
]

#section("Code")[
  #code_box(width: 80%, [
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
  ])
]

#section("Output")[
  #output_box(width: 80%, [
    #prompt ./fibonacci_generator.sh \
    Enter the number of terms (n): 7 \
    Fibonacci Series: 1 1 2 3 5 8 13 \
    \
    #prompt ./fibonacci_generator.sh \
    Enter the number of terms (n): 10 \
    Fibonacci Series: 1 1 2 3 5 8 13 21 34 55
  ])
]

#section("Conclusion")[
  The shell script successfully generates the Fibonacci sequence up to the user-specified number of terms using an iterative loop and variable reassignment.
]

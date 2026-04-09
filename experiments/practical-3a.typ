#import "common.typ": *

<practical-3a>
#practical_title("3A")

#section("Aim")[
  To write a shell script to find the smallest and largest among three given numbers.
]

#section("Name")[
  Minimum and Maximum of Three Numbers
]

#section("Theory")[
  Finding the minimum and maximum involves sequentially comparing variables. In Bash, conditional statements (`if`) combined with arithmetic comparison operators (such as `-lt` for less than and `-gt` for greater than) are used to evaluate the relative sizes of the inputs. \
  *Algorithm:*
  - Read three numbers (`a`, `b`, and `c`) from the user.
  - Assume the first number `a` is both the smallest (`min`) and largest (`max`).
  - Compare the second number `b` with `min` and `max`, updating them if necessary.
  - Compare the third number `c` with `min` and `max`, updating them if necessary.
  - Print the final `min` and `max` values.
]

#section("Code")[
  #code_box(width: 80%, [
    ```bash
    #!/bin/bash

    # Prompt user for input
    read -p "Enter three numbers separated by spaces: " a b c

    # Core Logic: Initialize min and max to the first number
    min=$a
    max=$a

    # Compare with the second number
    if [ $b -lt $min ]; then min=$b; fi
    if [ $b -gt $max ]; then max=$b; fi

    # Compare with the third number
    if [ $c -lt $min ]; then min=$c; fi
    if [ $c -gt $max ]; then max=$c; fi

    # Print the results
    echo "Smallest number: $min"
    echo "Largest number:  $max"
    ```
  ])
]

#pagebreak()

#section("Output")[
  #output_box(width: 80%, [
    \$ ./min_max.sh \
    Enter three numbers separated by spaces: 10 25 5 \
    Smallest number: 5 \
    Largest number:  25 \
    \
    \$ ./min_max.sh \
    Enter three numbers separated by spaces: -3 0 7 \
    Smallest number: -3 \
    Largest number:  7
  ])
]

#section("Conclusion")[
  The shell script successfully finds the minimum and maximum of three given numbers by utilizing sequential conditional comparisons.
]

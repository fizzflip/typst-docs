#import "common.typ": *

<practical-4>
#practical_title("4")

#section("Aim")[
  To write a shell script to create a menu-driven calculator using the case statement.
]

#section("Name")[
  Menu-Driven Calculator
]

#section("Theory")[
  A menu-driven script presents a list of options to the user and executes specific commands based on their selection. The `case` statement in shell scripting is an efficient multi-way branching control structure, making it ideal for mapping user inputs (like choosing an arithmetic operation) to their corresponding executable blocks without using messy, deeply nested if-elif statements. \
  *Algorithm:*
  - Prompt the user to enter two numbers.
  - Display a menu of arithmetic operations (Addition, Subtraction, Multiplication, Division).
  - Read the user's choice.
  - Use a `case` statement to match the choice and perform the respective arithmetic operation.
  - Store and display the result.
]

#section("Code")[
  #code_box(width: 80%, [
    #raw(read("../scripts/practical-4.sh"), lang: "bash")
  ])
]

#pagebreak()

#section("Output")[
  #output_box(width: 80%, [
    #prompt ./calculator.sh \
    Enter first number: 12 \
    Enter second number: 4 \
    \
    Options: 1) Add 2) Subtract 3) Multiply 4) Divide \
    Enter your choice (1-4): 3 \
    Result: 48 \
    \
    #prompt ./calculator.sh \
    Enter first number: 10 \
    Enter second number: 3 \
    \
    Options: 1) Add 2) Subtract 3) Multiply 4) Divide \
    Enter your choice (1-4): 4 \
    Result: 3
  ])
]

#section("Conclusion")[
  The shell script successfully implements a menu-driven calculator, utilizing the `case` statement to efficiently route user input to the correct arithmetic operation and display the computed result.
]

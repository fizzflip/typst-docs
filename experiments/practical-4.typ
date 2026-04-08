#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 4]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a shell script to create a menu-driven calculator using the case statement.

#text(size: 14pt, weight: "bold")[Name:] \
Menu-Driven Calculator

#text(size: 14pt, weight: "bold")[Theory:] \
A menu-driven script presents a list of options to the user and executes specific commands based on their selection. The `case` statement in shell scripting is an efficient multi-way branching control structure, making it ideal for mapping user inputs (like choosing an arithmetic operation) to their corresponding executable blocks without using messy, deeply nested if-elif statements. \
*Algorithm:*
- Prompt the user to enter two numbers.
- Display a menu of arithmetic operations (Addition, Subtraction, Multiplication, Division).
- Read the user's choice.
- Use a `case` statement to match the choice and perform the respective arithmetic operation.
- Store and display the result.

#text(size: 14pt, weight: "bold")[Code:] \
#align(center)[
  #rect(width: 80%, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      ```bash
      #!/bin/bash
      
      # [Boilerplate] Prompt for two input numbers
      read -p "Enter first number: " a
      read -p "Enter second number: " b
      
      # [Boilerplate] Display options and read choice
      echo -e "\nOptions: 1) Add 2) Subtract 3) Multiply 4) Divide"
      read -p "Enter your choice (1-4): " ch
      
      # Core Logic: Switch case for arithmetic operations
      case $ch in
          1) res=$((a + b)) ;;
          2) res=$((a - b)) ;;
          3) res=$((a * b)) ;;
          4) res=$((a / b)) ;; # Note: Performs integer division
          *) echo "Invalid choice"; exit 1 ;; # [Boilerplate] Error handling
      esac
      
      # [Boilerplate] Print output
      echo "Result: $res"
      ```
    ]
  ]
]

#text(size: 14pt, weight: "bold")[OUTPUT:] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ ./calculator.sh \
        Enter first number: 12 \
        Enter second number: 4 \
        \
        Options: 1) Add 2) Subtract 3) Multiply 4) Divide \
        Enter your choice (1-4): 3 \
        Result: 48 \
        \
        \$ ./calculator.sh \
        Enter first number: 10 \
        Enter second number: 3 \
        \
        Options: 1) Add 2) Subtract 3) Multiply 4) Divide \
        Enter your choice (1-4): 4 \
        Result: 3
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The shell script successfully implements a menu-driven calculator, utilizing the `case` statement to efficiently route user input to the correct arithmetic operation and display the computed result.

#pagebreak()

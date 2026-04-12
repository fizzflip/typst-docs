#!/bin/bash

# Prompt for two input numbers
read -p "Enter first number: " a
read -p "Enter second number: " b

# Display options and read choice
echo -e "\nOptions: 1) Add 2) Subtract 3) Multiply 4) Divide"
read -p "Enter your choice (1-4): " ch

# Core Logic: Switch case for arithmetic operations
case $ch in
    1) res=$((a + b)) ;;
    2) res=$((a - b)) ;;
    3) res=$((a * b)) ;;
    4) res=$((a / b)) ;; # Note: Performs integer division
    *) echo "Invalid choice"; exit 1 ;; # Error handling
esac

# Print output
echo "Result: $res"

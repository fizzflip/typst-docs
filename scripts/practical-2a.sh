#!/bin/bash

# Prompt user for input
read -p "Enter a string or number: " input

# Reverse the input
reversed=$(echo "$input" | rev)

# Core Logic: Compare strings
if [ "$input" == "$reversed" ]; then
    echo "Result: '$input' is a Palindrome."
else
    echo "Result: '$input' is NOT a Palindrome."
fi

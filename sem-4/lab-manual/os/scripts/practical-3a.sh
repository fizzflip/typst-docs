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

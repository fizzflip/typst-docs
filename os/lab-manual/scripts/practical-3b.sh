#!/bin/bash

# Prompt user for input
read -p "Enter a 6-digit number: " num

# Core Logic: Use parameter expansion to extract characters by index (0-based)
pos1=${num:0:1}
pos3=${num:2:1}
pos5=${num:4:1}

# Print the results
echo "Digits at odd positions (1st, 3rd, 5th): $pos1, $pos3, $pos5"

#!/bin/bash
read -p "Enter the number of terms (n): " n
a=1
b=1
echo -n "Fibonacci Series: "
# Core Logic: Loop n times to calculate and print
for (( i=0; i<n; i++ )); do
    echo -n "$a "
    next=$((a + b))
    a=$b
    b=$next
done

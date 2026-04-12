#!/bin/bash

# Prompt user for input
read -p "Enter a string to toggle case: " input
echo -n "Converted string: "

# Core Logic: awk script to iterate through characters and swap cases
echo "$input" | awk '{
    out = ""
    for (i=1; i<=length($0); i++) {
        c = substr($0, i, 1)
        if (c ~ /[A-Z]/) {
            out = out tolower(c)
        } else if (c ~ /[a-z]/) {
            out = out toupper(c)
        } else {
            out = out c # Keep numbers and special characters as is
        }
    }
    print out
}'

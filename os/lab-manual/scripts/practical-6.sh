#!/bin/bash

# Prompt user and validate input
read -p "Enter directory path: " target_dir
if [ ! -d "$target_dir" ]; then
    echo "Error: '$target_dir' is not a valid directory."
    exit 1
fi
# Initialize counters
f_count=0
d_count=0
l_count=0
# Core Logic: Iterate and classify
for item in "$target_dir"/*; do
    # Skip if directory is empty 
    [ -e "$item" ] || [ -L "$item" ] || continue
    if [ -L "$item" ]; then
        ((l_count++))
    elif [ -f "$item" ]; then
        ((f_count++))
    elif [ -d "$item" ]; then
        ((d_count++))
    fi
done
echo "Statistics for $target_dir:"
echo "---------------------------"
echo "Regular Files  : $f_count"
echo "Directories    : $d_count"
echo "Symbolic Links : $l_count"
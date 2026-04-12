#!/bin/bash

# Prompt user for filename
read -p "Enter the filename to reverse: " file

# Check if file exists to prevent errors
if [ ! -f "$file" ]; then
    echo "Error: File '$file' does not exist."
    exit 1
fi

# Print header
echo "--- Reversed Contents ---"

# Core Logic: Use 'tac' to reverse lines
# (Note: use 'rev "$file"' to reverse characters instead)
tac "$file"

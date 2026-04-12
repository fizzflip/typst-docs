#!/bin/bash
# Print header
echo "Subdirectories in current directory ($(pwd)):"
echo "-------------------------------------------"
# Core Logic: Loop through all items and check if they are directories
for item in *; do
    if [ -d "$item" ]; then
        echo "$item"
    fi
done

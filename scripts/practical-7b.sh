#!/bin/bash

# Core Logic: Infinite loop to keep the menu active until exit
while true; do
    # Display menu options
    echo -e "\n--- File Operations ---"
    echo "1. Copy a file"
    echo "2. Remove a file"
    echo "3. Move a file"
    echo "4. Exit"
    read -p "Enter your choice (1-4): " choice

    # Switch case to handle operations
    case $choice in
        1)
            read -p "Enter source file: " src
            read -p "Enter destination: " dest
            cp "$src" "$dest" && echo "Success: File copied."
            ;;
        2)
            read -p "Enter file to remove: " file
            rm "$file" && echo "Success: File removed."
            ;;
        3)
            read -p "Enter source file: " src
            read -p "Enter destination: " dest
            mv "$src" "$dest" && echo "Success: File moved."
            ;;
        4)
            exit 0 # Exit the script successfully
            ;;
        *)
            echo "Invalid choice. Please select 1-4." # Error handling
            ;;
    esac
done

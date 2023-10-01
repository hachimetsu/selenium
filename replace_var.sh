#!/bin/bash

chromedriver=$(sudo find /home/gitpod/.cache/ -type d -name "*chrome*" -o -type f -name "*chrome*" 2>/dev/null | grep -Ei "*/chromedriver/")

# Function to perform replacement
perform_replace() {
    local word_to_replace="$1"
    local with_to_replace="$2"
    vim -b -c ":%s/$word_to_replace/$with_to_replace/g" -c ":wq" "$chromedriver"
    echo "Replaced '$word_to_replace' with '$with_to_replace' in $chromedriver"
}

# Function to check for the word
perform_check() {
    local word_to_check="$1"

    # Flag to track if any occurrences were found
    found_occurrences=false

    # check if the word exists
    if grep -q "$word_to_check" "$chromedriver"; then
        echo "Found '$word_to_check' in $chromedriver"
        found_occurrences=true
    fi

    # Display message if no occurrences were found
    if [ "$found_occurrences" = false ]; then
        echo "No occurrences of '$word_to_check' found."
    fi
}

while true; do
    echo "Menu:"
    echo "1. Check"
    echo "2. Replace"
    echo "0. Quit"
    echo "c. clear"
    read -p "Enter your choice: " choice

    # Clear input buffer
    while read -t 0; do
        read
    done

    case $choice in
        1)
            read -p "Word to check: " word_to_check
            perform_check "$word_to_check"
            ;;
        2)
            read -p "Word to replace: " word_to_replace
            read -p "Replace with: " with_to_replace
            perform_replace "$word_to_replace" "$with_to_replace"
            ;;
        0)
            echo "Quitting"
            exit 0
            ;;
        c)
            clear
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done

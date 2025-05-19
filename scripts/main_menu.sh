#!/bin/bash

# Main menu for Recipe Recommendation App

#keep showing the menu until the user chooses to exit
while true; do
    echo ""
    echo "Welcome to the Recipe Recommendation App!"
    echo "1. Get recipes based on available ingredients"
    echo "2. Calculate calories of a recipe"
    echo "3. Get instructions for a recipe"
    echo "4. Add a new recipe"
    echo "5. Exit"
    echo -n "Enter your choice (1-5): "
    read choice

    #based on the user"s input, run the corresponding script
    case $choice in
        1) ./find.sh ;;
        2) ./calculate_calories1.sh ;;
        3) ./getInstr.sh ;;
        4) ./add_recipe.sh ;;
        5) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid choice. Please enter a number from 1 to 5." ;;
    esac
done


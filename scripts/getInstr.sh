#!/bin/bash

echo -n "Enter part or full recipe name: "
read recipe

# Search for the recipe and store 5 lines (name + 4 lines after) in the variable 'match'
match=$(grep -i -A 4 "name:.*$recipe" recipes.txt)

# Check if the match is not empty (i.e., the recipe was found)
if [ -n "$match" ]; then
    # Print only the name and instructions lines from the match
    echo "$match" | grep -i -E "^name:|^instructions:"
else
    # If match is empty, show message
    echo "Recipe '$recipe' is not found."
fi

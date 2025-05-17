#!/bin/bash

data_file="data/recipes.txt"

if [ ! -f "$data_file" ]; then
    echo " Error: Database file not found at $data_file"
    exit 1
fi

echo "Enter the ingredients you have (comma-separated):"
read input_ingredients

IFS=',' read -ra user_ingredients <<< "$input_ingredients"

matchhed_recipes=()

recipes=$(awk -v RS= '' '{ print $0 }' "$data_file")

while IFS= read -r recipe; do
    match=true
    for ingredient in "${user_ingredients[@]}"; do
      cleaned=$(echo "$ingredient" | xargs | tr '[:upper:]' '[:lower:]')
      if ! echo "$recipe" | grep -i "ingredients:" | grep -qi "$cleand"; then
        match=false
        break
      fi
    
    done
    
    if [ "$match" = true ]; then
      matched_recipes+=("$recipe")
    fi
done <<< "$recipes"

if [ ${#matched_recipes[@]} -eq 0 ]; then
    echo " no matching recipes found."
else
    echo -e "\n Searching for recipes...\n"

    for recipe in "${matched_recipes[@]}"; do

      echo "$recipe"
      echo "-----------------------------------"
    done
fi

#!/bin/bash

echo "Enter the ingredients you have (comma-separated):"
read input_ingredients

IFS=',' read -ra user_ingredients <<< "$input_ingredients"

query="SELECT name, ingredients FROM recipes WHERE 1=1"

for ingredient in "${user_ingredients[@]}"; do
    cleaned=$(echo "$ingredient" | xargs | tr '[:upper:]' '[:lower:]')
    query="$query AND LOWER(ingredients) LIKE '%$cleand%'"
done

db_path="data/recipes.db"

if [ ! -f "$db_path" ]; then
    echo " Error: Database file not found at $db_path"
    exit 1
fi


echo -e "\n Searching for recipes...\n"

results=$(sqlite3 -separator "|" "$db_path" "$query")

if [ -z "$results" ]; then
    echo "No matching recipes found."
else
    echo "$results" | while IFS='|' read -r name ingredients
    do
      echo "Recipe: $name"
      echo "Ingredients: $ingredients"
      echo ""
    done
fi

#!/bin/bash

DB_PATH="recipes.db"

echo -n "Enter recipe name: "
read name

sqlite3 -separator "|" "$DB_PATH" "SELECT name, instructions FROM recipes WHERE name LIKE '%$name%';" | while IFS='|' read -r recipe_name instruction; do
  echo -e "\nRecipe: $recipe_name"
  echo "Instructions: $instruction"
done


#!/bin/bash

DATA_FILE="../data/recipes.txt"

#Get the last used ID from the file
if [ -s "$DATA_FILE" ]; then
last_id=$(grep '^id:' "$DATA_FILE" | tail -n 1 | cut -d ':' -f2 | tr -d ' ')
else
last_id=0
fi

#Generate a new ID by adding 1 to the last ID
new_id=$((last_id + 1))

#Ask the user for recipe details 
echo "Enter recipe name:"
read name

echo "Enter ingredients (comma-separated):"
read ingredients

echo "Enter calories:"
read calories

echo "Enter instructions:"
read instructions

#Append the new recipe to the data file
echo "" >> "$DATA_FILE"
echo "id: $new_id" >> "$DATA_FILE"
echo "name: $name" >> "$DATA_FILE"
echo "ingredients: $ingredients" >> "$DATA_FILE"
echo "calories: $calories" >> "$DATA_FILE"
echo "instructions: $instructions" >> "$DATA_FILE"

#Show success message with the new ID
echo " Recipe added successfully with ID $new_id!"


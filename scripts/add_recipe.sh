#!/bin/bash

echo "Enter recipe name:"
read name
echo "Enter ingredients (comma-separated):"
read ingredients
echo "Enter calories:"
read calories
echo "Enter instructions:"
read instructions

#we add it to the data.txt file
echo "Name: $name" >> ../data/recipes.txt
echo "Ingredients: $ingredients" >> ../data/recipes.txt
echo "Calories: $calories" >> ../data/recipes.txt
echo "Instructions: $instructions" >> ../data/recipes.txt
echo "-----------------------------" >> ../data/recipes.txt

echo "Recipe added successfully!

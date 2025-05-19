#!/bin/bash

echo -n "Enter part or full recipe name: "
read recipe

# Go through the recipes and print name + instructions for the matching ones
grep -i -A 4 "name:.*$recipe" recipes.txt | grep -i -E "^name:|^instructions:"

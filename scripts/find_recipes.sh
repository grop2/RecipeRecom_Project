#!/bin/bash

echo "Enter the ingredients you have (comma-separated):"
read input_ingredients

IFS=',' read -ra user_ingredients <<< "$input_ingredients"

file_path="../data/recipes.txt"

if [ ! -f "$file_path" ]; then
    echo "⚠️ Error: File not found at $file_path"
    exit 1
fi

echo -e "\n🔍 Searching for recipes...\n"

# اقرأ كل وصفة واحتفظ باللي تطابق كل المكونات
awk -v ingredients="$input_ingredients" '
BEGIN {
    split(ingredients, inputArr, ",")
    recipe = ""
    match_all = 0
}
/^Name:/ {
    recipe = $0
    match_all = 1
}
/^Ingredients:/ {
    ing_line = tolower($0)
    for (i in inputArr) {
        gsub(/^ +| +$/, "", inputArr[i])  # إزالة الفراغات
        if (index(ing_line, tolower(inputArr[i])) == 0) {
            match_all = 0
            break
        }
    }
    if (match_all == 1) {
        print recipe
        print $0 "\n"
    }
}
' "$file_path"


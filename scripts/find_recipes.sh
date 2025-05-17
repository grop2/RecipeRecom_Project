#!/bin/bash

data_file="../data/recipes.txt"

# تأكد من وجود الملف
if [ ! -f "$data_file" ]; then
    echo "⚠️ Error: Data file not found at $data_file"
    exit 1
fi

# طلب المكونات من المستخدم
echo "Enter the ingredients you have (comma-separated):"
read input_ingredients

IFS=',' read -ra user_ingredients <<< "$input_ingredients"

# تهيئة متغير لتخزين النتائج
matched_recipes=()

# قراءة الملف كامل ككتلة نصية، كل وصفة مفصولة بسطر فارغ
recipes=$(awk -v RS= '' '{ print $0 }' "$data_file")

# لكل وصفة، نتحقق هل تحتوي كل المكونات المدخلة من المستخدم
while IFS= read -r recipe; do
    match=true
    for ingredient in "${user_ingredients[@]}"; do
        cleaned=$(echo "$ingredient" | xargs | tr '[:upper:]' '[:lower:]')
        if ! echo "$recipe" | grep -i "Ingredients:" | grep -qi "$cleaned"; then
            match=false
            break
        fi
    done

    if [ "$match" = true ]; then
        matched_recipes+=("$recipe")
    fi
done <<< "$recipes"

# عرض النتائج
if [ ${#matched_recipes[@]} -eq 0 ]; then
    echo "❌ No matching recipes found."
else
    echo -e "\n🔍 Matching Recipes:\n"
    for recipe in "${matched_recipes[@]}"; do
        echo "$recipe"
        echo "------------------------------"
    done
fi

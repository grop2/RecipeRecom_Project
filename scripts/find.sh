#!/bin/bash

echo "Enter the ingredients you have: (comma-separated):"
read input_ingredients

# نحول المكونات لمصفوفة وننظفها من الفراغات
IFS=',' read -ra ingredients <<< "$input_ingredients"
for i in "${!ingredients[@]}"; do
    ingredients[$i]=$(echo "${ingredients[$i]}" | xargs | tr '[:upper:]' '[:lower:]')
done

file_path="recipes.txt"
if [ ! -f "$file_path" ]; then
    echo "⚠️ Error: File not found at $file_path"
    exit 1
fi

echo -e "\n🔍 Searching for recipes...\n"

# نحفظ الوصفة مؤقتاً هنا
recipe=""

matched=0

while IFS= read -r line || [ -n "$line" ]; do
    # إذا لقينا سطر فاضي، يعني انتهت وصفة -> نحللها
    if [[ -z "$line" ]]; then
        # نبحث في مكونات الوصفة
        ing_line=$(echo "$recipe" | grep -i "^Ingredients:" | tr '[:upper:]' '[:lower:]')
        found_all=1
        for item in "${ingredients[@]}"; do
            if [[ "$ing_line" != *"$item"* ]]; then
                found_all=0
                break
            fi
        done

        if [[ $found_all -eq 1 ]]; then
            echo -e "$recipe\n"
            matched=1
        fi
        recipe=""
    else
        recipe+="$line"$'\n'
    fi
done < "$file_path"

# معالجة آخر وصفة لو الملف ما انتهى بسطر فارغ
if [[ -n "$recipe" ]]; then
    ing_line=$(echo "$recipe" | grep -i "^Ingredients:" | tr '[:upper:]' '[:lower:]')
    found_all=1
    for item in "${ingredients[@]}"; do
        if [[ "$ing_line" != *"$item"* ]]; then
            found_all=0
            break
        fi
    done

    if [[ $found_all -eq 1 ]]; then
        echo -e "$recipe\n"
        matched=1
    fi
fi

if [[ $matched -eq 0 ]]; then
    echo "❌ No matching recipes found."
fi

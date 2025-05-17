#!/bin/bash

data_file="../scripts/calories.txt"

if [ ! -f "$data_file" ]; then
    echo "⚠️ Error: Calorie data file not found at $data_file"
    exit 1
fi

echo ""
echo "--- Calorie Calculator (with Calorie DB) ---"
read -p "How many ingredients in your recipe? " count

total=0

for ((i=1; i<=count; i++))
do
    echo ""
    echo "Ingredient #$i"
    read -p "Enter name of ingredient: " name
    read -p "Enter amount of $name: " amount
    read -p "Enter unit (g, ml, piece): " unit 
    cal_per_100=$(awk -F',' -v item="$(echo "$name" | tr '[:upper:]' '[:lower:]')" '
        BEGIN { found=0 }
        {
            gsub(/^ +| +$/, "", $1);
            if (tolower($1) == item) {
                print $2;
                found=1;
                exit;
            }
        }
        END { if (!found) exit 1 }
    ' "$data_file")

    if [ $? -ne 0 ]; then
        echo "⚠️ Calories info for '$name' not found. Skipping..."
        continue
    fi

    cal_per_unit=$(echo "scale=4; $cal_per_100 / 100" | bc)
    ingredient_cal=$(echo "$amount * $cal_per_unit" | bc)

    total=$(echo "$total + $ingredient_cal" | bc)

    printf "> %s: %s %s × %.2f cal/%s = %.2f kcal\n" "$name" "$amount" "$unit" "$cal_per_unit" "$unit" "$ingredient_cal"
done

echo ""
echo "✅ Estimated total calories for this recipe: $total kcal"

#!/bin/bash

echo ""
echo "--- Calorie Calculator (Bash Version) ---"
read -p "How many ingredients in your recipe? " count

total=0

for ((i=1; i<=count; i++))
do
    echo ""
    echo "Ingredient #$i"
    read -p "Enter name of ingredient: " name
    read -p "Enter amount of $name: " amount
    read -p "Enter unit (g, ml, piece): " unit

    if [[ "$unit" == "ml" ]]; then
        read -p "Enter calories per 100 ml for $name: " cal_100
        cal_per_unit=$(echo "scale=4; $cal_100 / 100" | bc)
    else
        read -p "Enter calories per $unit for $name: " cal_per_unit
    fi

    ingredient_cal=$(echo "$amount * $cal_per_unit" | bc)
    total=$(echo "$total + $ingredient_cal" | bc)

    printf "> %s: %s %s × %.2f cal/%s = %.2f kcal\n" "$name" "$amount" "$unit" "$cal_per_unit" "$unit" "$ingredient_cal"
done

echo ""
echo "✅ Estimated total calories for this recipe: $total kcal"

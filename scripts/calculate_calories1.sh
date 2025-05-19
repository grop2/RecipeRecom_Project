#!/bin/bash  # Specifies that the script should be run using the Bash shell

echo ""
<<<<<<< HEAD
echo "--- Calorie Calculator  ---"  # Print a title for the script
=======
echo "--- Calorie Calculator (Bash Version) ---"  # Print a title for the script
>>>>>>> 8e11eda7d47ea7f348169c0d431367c863047d86
read -p "How many ingredients in your recipe? " count  # Ask user for number of ingredients

total=0  # Initialize a variable to keep track of total calories

# Loop through each ingredient based on user input
for ((i=1; i<=count; i++))
do
    echo ""
    echo "Ingredient #$i"  # Display the current ingredient number
    read -p "Enter name of ingredient: " name  # Ask for the name of the ingredient
    read -p "Enter amount of $name: " amount  # Ask for the amount used
    read -p "Enter unit (g, ml, piece): " unit  # Ask for the unit type

    # If the unit is milliliters, calculate calories per 1 ml from calories per 100 ml
    if [[ "$unit" == "ml" ]]; then
        read -p "Enter calories per 100 ml for $name: " cal_100  # Get cal per 100 ml
        cal_per_unit=$(echo "scale=4; $cal_100 / 100" | bc)  # Calculate per 1 ml using bc (basic calculator)
    else
        # For all other units, ask directly for calories per unit
        read -p "Enter calories per $unit for $name: " cal_per_unit
    fi

    # Calculate total calories for the current ingredient
    ingredient_cal=$(echo "$amount * $cal_per_unit" | bc)

    # Add it to the overall total
    total=$(echo "$total + $ingredient_cal" | bc)

    # Print a summary for this ingredient
    printf "> %s: %s %s × %.2f cal/%s = %.2f kcal\n" "$name" "$amount" "$unit" "$cal_per_unit" "$unit" "$ingredient_cal"
done

echo ""
echo "✅ Estimated total calories for this recipe: $total kcal"  # Print the final total

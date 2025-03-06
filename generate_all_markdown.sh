#!/bin/bash

# Script to generate markdown tables for all data files in the local directory

# Create output directory if it doesn't exist
mkdir -p markdown_tables

# Function to generate markdown table for plants and pots
generate_plant_pot_table() {
  local input_file=$1
  local output_file=$2
  local list_name=$3
  local item_type=$4

  echo "# $item_type List" > "$output_file"
  echo "" >> "$output_file"
  echo "| ID | Name | Image | Price | Currency | Level Unlock | Type Attribute | Effect |" >> "$output_file"
  echo "|---|---|---|---|---|---|---|---|" >> "$output_file"

  # Extract data from Dart file and format as markdown
  grep -A 15 "ItemData(" "$input_file" | while read -r line; do
    if [[ $line == *"id: '"* ]]; then
      id=$(echo $line | sed "s/.*id: '\([^']*\)'.*/\1/")
    elif [[ $line == *"name: '"* ]]; then
      name=$(echo $line | sed "s/.*name: '\([^']*\)'.*/\1/" | sed "s/\.tr//")
    elif [[ $line == *"image: '"* || $line == *"image: Assets"* ]]; then
      if [[ $line == *"image: '"* ]]; then
        image=$(echo $line | sed "s/.*image: '\([^']*\)'.*/\1/")
      else
        # For Assets references, just use a placeholder
        image="[Asset Reference]"
      fi
    elif [[ $line == *"priceStore: "* ]]; then
      price=$(echo $line | sed "s/.*priceStore: \([0-9]*\).*/\1/")
    elif [[ $line == *"currencyUnit: '"* ]]; then
      currency=$(echo $line | sed "s/.*currencyUnit: '\([^']*\)'.*/\1/")
    elif [[ $line == *"levelUnlock: "* ]]; then
      level=$(echo $line | sed "s/.*levelUnlock: \([0-9]*\).*/\1/")
    elif [[ $line == *"effect: "* && $line != *"itemTypeAttribute"* ]]; then
      effect=$(echo $line | sed "s/.*effect: '\([^']*\)'.*/\1/" | sed "s/\.tr//")
      # Handle special cases for effect
      if [[ $line != *"effect: '"* ]]; then
        effect=$(echo $line | sed "s/.*effect: \([^,]*\).*/\1/" | sed "s/\.tr//")
      fi
    elif [[ $line == *"itemTypeAttribute: "* ]]; then
      attribute=$(echo $line | sed "s/.*itemTypeAttribute: ItemTypeAttribute\.\([^,]*\).*/\1/")
      
      # Write the complete row to the markdown file
      echo "| $id | $name | ![$name]($image) | $price | $currency | $level | $attribute | $effect |" >> "$output_file"
      
      # Reset variables for next item
      id=""
      name=""
      image=""
      price=""
      currency=""
      level=""
      effect=""
      attribute=""
    fi
  done

  echo "Markdown table generated in $output_file"
}

# Function to generate markdown table for other items (bags, effects, weather, items)
generate_other_table() {
  local input_file=$1
  local output_file=$2
  local list_name=$3
  local item_type=$4

  echo "# $item_type List" > "$output_file"
  echo "" >> "$output_file"
  echo "| ID | Name | Image | Description | Type | Effect |" >> "$output_file"
  echo "|---|---|---|---|---|---|" >> "$output_file"

  # Process the file line by line to extract complete items
  local id=""
  local name=""
  local image=""
  local description=""
  local type=""
  local effect=""
  
  while IFS= read -r line; do
    if [[ $line == *"ItemData("* ]]; then
      # Start of a new item, reset variables
      id=""
      name=""
      image=""
      description=""
      type=""
      effect=""
    elif [[ $line == *"id: '"* ]]; then
      id=$(echo $line | sed "s/.*id: '\([^']*\)'.*/\1/")
    elif [[ $line == *"name: '"* ]]; then
      name=$(echo $line | sed "s/.*name: '\([^']*\)'.*/\1/" | sed "s/\.tr//")
    elif [[ $line == *"image: '"* || $line == *"image: Assets"* ]]; then
      if [[ $line == *"image: '"* ]]; then
        image=$(echo $line | sed "s/.*image: '\([^']*\)'.*/\1/")
      else
        # For Assets references, just use a placeholder
        image="[Asset Reference]"
      fi
    elif [[ $line == *"description: '"* ]]; then
      description=$(echo $line | sed "s/.*description: '\([^']*\)'.*/\1/" | sed "s/\.tr//")
    elif [[ $line == *"type: '"* ]]; then
      type=$(echo $line | sed "s/.*type: '\([^']*\)'.*/\1/")
    elif [[ $line == *"effect: "* ]]; then
      effect=$(echo $line | sed "s/.*effect: '\([^']*\)'.*/\1/" | sed "s/\.tr//")
      # Handle special cases for effect
      if [[ $line != *"effect: '"* ]]; then
        effect=$(echo $line | sed "s/.*effect: \([^,]*\).*/\1/" | sed "s/\.tr//")
      fi
    elif [[ $line == *"),"* && -n "$id" ]]; then
      # End of an item, write to file if we have an ID
      echo "| $id | $name | ![$name]($image) | $description | $type | $effect |" >> "$output_file"
    fi
  done < "$input_file"

  echo "Markdown table generated in $output_file"
}

# Generate markdown tables for plants and pots
generate_plant_pot_table "./lib/data/local/list_plants.dart" "markdown_tables/plants_table.md" "listPlantsData" "Plants"
generate_plant_pot_table "./lib/data/local/list_pots.dart" "markdown_tables/pots_table.md" "listPotsData" "Pots"

# Generate markdown tables for other items
generate_other_table "./lib/data/local/list_items.dart" "markdown_tables/items_table.md" "listItemsData" "Items"
generate_other_table "./lib/data/local/list_effect.dart" "markdown_tables/effects_table.md" "listEffectData" "Effects"
generate_other_table "./lib/data/local/list_weather.dart" "markdown_tables/weather_table.md" "listWeatherLandscapeData" "Weather Landscapes"
generate_other_table "./lib/data/local/list_bag.dart" "markdown_tables/bags_table.md" "listBagsData" "Bags"

echo "All markdown tables generated in the markdown_tables directory"
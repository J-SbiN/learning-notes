#!/bin/bash

config_file="$HOME/.aws/config"
section_name="${1}"
key_name="${2}"

# Check if the config file exists
if [ ! -f "$config_file" ]; then
    echo "AWS config file not found: $config_file"
    exit 1
fi

# Parse the config file
while IFS= read -r line; do
    # Remove leading/trailing whitespaces
    line=$(echo "$line" | awk '{$1=$1};1')

    # Check if the current line matches the desired section
    if [[ $line == "$section_name" ]]; then
        found_section=true
        continue
    fi

    # If the desired section has been found, search for the desired key
    if [ "$found_section" = true ] && [[ $line == *=* ]]; then
        key=$(echo "$line" | cut -d= -f1)
        value=$(echo "$line" | cut -d= -f2-)
        
        # Check if the current key matches the desired key
        if [ "$key" = "$key_name" ]; then
            echo "Value: $value"
            exit 0
        fi
    fi

    # If the end of the section is reached, exit the loop
    if [[ $line == \[*\] ]]; then
        found_section=false
    fi

done < "$config_file"

echo "Value not found for key: $key_name in section: $section_name"
exit 1

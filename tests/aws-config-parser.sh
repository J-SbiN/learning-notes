#!/bin/bash


config_file="$HOME/.aws/config"

# Check if the config file exists
if [ ! -f "$config_file" ]; then
    echo "AWS config file not found: $config_file"
    exit 1
fi

# Parse the config file
while IFS= read -r line; do
    # Remove leading/trailing whitespaces
    line=$(echo "$line" | awk '{$1=$1};1')

    # Skip empty lines and comments
    if [ -z "$line" ] || [[ $line == \#* ]]; then
        continue
    fi

    # Parse the sections
    if [[ $line == \[*\] ]]; then
        section=$(echo "$line" | sed 's/[][]//g')
        echo "Section: $section"
        continue
    fi

    # Parse the key-value pairs
    if [[ $line == *=* ]]; then
        key=$(echo "$line" | cut -d= -f1)
        value=$(echo "$line" | cut -d= -f2-)
        echo "Key: $key, Value: $value"
        continue
    fi

    echo "Unable to parse line: $line"
done < "$config_file"


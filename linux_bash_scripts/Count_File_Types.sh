#!/bin/bash

# If no directory is provided, use the current one
DIR=${1:-.}

# Check if the directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: $DIR is not a valid directory."
    exit 1
fi

echo "Counting files by extension in: $DIR"
echo "------------------------------------"

# Find all files (not directories) and extract their extensions
# Then sort them and count unique occurrences
find "$DIR" -type f | sed -n 's/.*\.//p' | sort | uniq -c | sort -nr

echo "------------------------------------"
echo "Done."

#!/bin/bash

# Function to add two numbers
add_numbers() {

  num1="$1"
  num2="$2"

  # Check if inputs are valid integers using regex
  if ! [[ "$num1" =~ ^-?[0-9]+$ ]] || ! [[ "$num2" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Both inputs must be integers." >&2
    return 1
  fi

  sum=$((num1 + num2))
  echo "$sum"
}

# Main script

num1="$1"
num2="$2"

result=$(add_numbers "$num1" "$num2")

if [ $? -eq 0 ]; then # Check if the function succeeded
  echo "The sum of $num1 and $num2 is: $result"
else
  # Error message already printed by the function
  exit 1
fi

exit 0 # Exit with success

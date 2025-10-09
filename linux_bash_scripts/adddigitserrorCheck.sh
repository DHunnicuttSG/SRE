#!/bin/bash
add_digits() {
  # Check if a number was provided as an argument
  if [ -z "$1" ]; then
    echo "Error: Please provide a number as an argument." >&2 # Output error to stderr
    return 1 # Return a non-zero exit code to indicate an error
  fi

  num="$1"

  #Check if the input is a valid integer
  if ! [[ "$num" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Input must be an integer." >&2
    return 1
  fi

  result=0
  abs_num=$(echo "$num" )

  while [[ "$abs_num" -gt 0 ]]; do
    digit=$((abs_num % 10))
    abs_num=$((abs_num / 10))
    result=$((result + digit))
  done

  echo "$result"
}

# Main part of the script

# Check if any arguments were passed
if [ $# -eq 0 ]; then
    echo "Usage: $0 <number>" >&2
    exit 1
fi

number="$1"
sum=$(add_digits "$number")

# Check if the function returned an error
if [ $? -eq 0 ]; then # $? is the exit code of the last command
  echo "The sum of the digits of $number is: $sum"
else
  # Error message has already been printed by the function
  exit 1 # Exit with an error code
fi

exit 0 # Exit with success

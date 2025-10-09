#!/bin/bash

check_password() {
  password="$1"

  if [ -z "$password" ]; then
    echo "Error: Password cannot be empty." >&2
    return 1
  fi

  if [[ ${#password} -lt 8 ]]; then
    echo "Error: Password must be at least 8 characters long." >&2
    return 1
  fi

  if ! [[ "$password" =~ [a-z] ]]; then
    echo "Error: Password must contain at least one lowercase letter." >&2
    return 1
  fi

  if ! [[ "$password" =~ [A-Z] ]]; then
    echo "Error: Password must contain at least one uppercase letter." >&2
    return 1
  fi

  if ! [[ "$password" =~ [0-9] ]]; then
    echo "Error: Password must contain at least one number." >&2
    return 1
  fi

  echo "Password meets the requirements."
  return 0
}

# Main script

if [ $# -ne 1 ]; then
  echo "Usage: $0 <password>" >&2
  exit 1
fi

password="$1"

if check_password "$password"; then
  exit 0 # Success
else
  exit 1 # Failure (error message already printed by function)
fi
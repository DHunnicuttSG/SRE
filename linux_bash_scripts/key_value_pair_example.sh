#!/bin/bash
# =============================================
# Script Name: kv_example.sh
# Description: Demonstrates key-value pairs
# =============================================

# Declare an associative array (requires Bash 4+)
declare -A user

# Add key-value pairs
user[name]="Alice"
user[role]="Developer"
user[email]="alice@example.com"

# Access values by key
echo "User Information:"
echo "-----------------"
echo "Name : ${user[name]}"
echo "Role : ${user[role]}"
echo "Email: ${user[email]}"

# Add more data dynamically
user[department]="Engineering"
user[location]="New York"

# Iterate over all keys
echo
echo "All key-value pairs:"
echo "--------------------"
for key in "${!user[@]}"; do
    echo "$key -> ${user[$key]}"
done

# Example of using key/value in logic
echo
if [ "${user[role]}" == "Developer" ]; then
    echo "✅ ${user[name]} is part of the Dev team!"
fi

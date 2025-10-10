#!/bin/bash

read -p "Enter path to FIX log file: " LOG_FILE

if [[ ! -f "$LOG_FILE" ]]; then
  echo "File not found: $LOG_FILE"
  exit 1
fi

get_exec_type() {
  if [[ "$1" == "0" ]]; then echo "New"
  elif [[ "$1" == "1" ]]; then echo "Partial Fill"
  elif [[ "$1" == "2" ]]; then echo "Fill"
  elif [[ "$1" == "3" ]]; then echo "Done for Day"
  elif [[ "$1" == "4" ]]; then echo "Canceled"
  elif [[ "$1" == "5" ]]; then echo "Replaced"
  elif [[ "$1" == "6" ]]; then echo "Pending Cancel"
  elif [[ "$1" == "8" ]]; then echo "Rejected"
  elif [[ "$1" == "A" ]]; then echo "Pending New"
  else echo "Other ($1)"
  fi
}

get_side() {
  if [[ "$1" == "1" ]]; then echo "Buy"
  elif [[ "$1" == "2" ]]; then echo "Sell"
  else echo "Other ($1)"
  fi
}

exec_types=()
sides=()
quantities=()

while IFS= read -r line; do
  exec_type=$(echo "$line" | grep -oP '150=\K[^;]*')
  side=$(echo "$line" | grep -oP '54=\K[^;]*')
  qty=$(echo "$line" | grep -oP '38=\K[^;]*')

  exec_types+=("$(get_exec_type "$exec_type")")
  sides+=("$(get_side "$side")")
  quantities+=("$qty")
done < "$LOG_FILE"

echo "=== FIX LOG REPORT ==="
echo ""

echo "1. Execution Type Counts:"
printf '%s\n' "${exec_types[@]}" | sort | uniq -c | sort -nr
echo ""

echo "2. Side Counts:"
printf '%s\n' "${sides[@]}" | sort | uniq -c | sort -nr
echo ""

echo "3. Total Quantity:"
printf '%s\n' "${quantities[@]}" | awk '{sum+=$1} END {print sum}'
echo ""

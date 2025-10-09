  #!/bin/bash
  echo ""

  num="$1"

  result=0
  abs_num=$num

  while [[ "$abs_num" -gt 0 ]]; do
    digit=$((abs_num % 10))
    abs_num=$((abs_num / 10))
    result=$((result + digit))
  done

  echo "The sum of the digits of $1 is: $result"
  echo ""

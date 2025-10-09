#!/bin/bash
for i in {1..5}; do # From 1 to 5
  echo "Number: $i"
done

echo "*****"

for i in {1..10..2}; do # From 1 to 10, stepping by 2
  echo "Number: $i"
done

echo "*****"

for i in $(seq 1 5); do # From 1 to 5
  echo "Number: $i"
done

echo "*****"

for i in $(seq 0 0.5 2); do # From 0 to 2, stepping by 0.5 (floating point)
  echo "Number: $i"
done
#!/bin/bash
#This is an array
names[0]="Dopey"
names[1]="Doc"
names[2]="Sleepy"
names[3]="Sneezy"
names[4]="Bashful"
names[5]="Grumpy"
names[6]="Happy"

echo "1: ${names[0]}"
echo "2: ${names[1]}"
echo "3: ${names[2]}"
echo "4: ${names[3]}"
echo "5: ${names[4]}"
echo "6: ${names[5]}"
echo "7: ${names[6]}"

echo "All names: ${names[*]}"

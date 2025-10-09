#!/bin/bash

clear

p1=$1
p2=$2

if [ $p1 -eq $p2 ]
then
        echo "$p1 is equal to $p2"
else
        echo "$p1 is NOT equal to $p2"
fi

if [ $p1 -ne $p2 ]
then
        echo "$p1 is not equal to $p2"
else
        echo "$p1 is equal to $p2"
fi

if [ $p1 -ge $p2 ]
then
        echo "$p1 is greater than or equal to $p2"
else
        echo "$p1 is NOT greater than or equal to $p2"
fi

if [ $p1 -le $p2 ]
then
        echo "$p1 is less than or equal to $p2"
else
        echo "$p1 is NOT less than or equal to $p2"
fi

if [ $p1 -gt $p2 ]
then
        echo "$p1 is greater than $p2"
else
        echo "$p1 is NOT greater than to $p2"
fi

if [ $p1 -lt $p2 ]
then
        echo "$p1 is less than to $p2"
else
        echo "$p1 is NOT less then $p2"
fi

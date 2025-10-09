#!/bin/bash

file=$1

if [ -w $file ]
then
        echo "File has write access"
else
        echo "File does not have write access"
fi

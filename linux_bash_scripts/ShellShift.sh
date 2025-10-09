#!/bin/bash
if [ -z "$1" ]
        then
        echo "No argument supplied"
        exit 1
fi

while getopts ":abc" option;
do
        case $option in
                a)
                        echo received -a
                        ;;
                b)
                        echo received -b
                        ;;
                c)
                        echo received -c
                        ;;
                *)
                        echo "invalid option $OPTARG"
                        ;;
        esac
done

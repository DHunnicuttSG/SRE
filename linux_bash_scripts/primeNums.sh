#!/bin/bash

start=$1
finish=$2

    count=0;
        count2=0;
        for (( i=$start; i<=$finish; i++ )) do
            count=0;
            for (( j=2; j<=i/2; j++ )) do
                if (( i % j == 0 ))
                then
                    ((count++));
                    break;
                fi
            done

            if (( count == 0 )) 
            then
                ((count2++));
                echo "$i";  #Prime number
            fi
        done
        
        echo "There are $count2 prime numbers between $start and $finish"
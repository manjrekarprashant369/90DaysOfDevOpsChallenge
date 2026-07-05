#!/bin/bash

read -p "Enter a number to start countdown: " count

while [ "$count" -ge 0 ]
do 
	echo "$count"
	((count--))
done
echo "Done!"

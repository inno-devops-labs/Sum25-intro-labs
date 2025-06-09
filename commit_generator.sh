#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <number_of_iterations>"
    exit 1
fi

if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Parameter must be a positive integer"
    exit 1
fi


touch random.txt

for ((i=1; i<=$1; i++)); do
    random_str=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 5 | head -n 1)

    echo "$random_str" >> random.txt

    git add random.txt
    git commit -m "Add [$random_str] random.txt"

    echo "Added and committed: $random_str"
done

git push



echo "Done! $1 random strings added, committed, and pushed."
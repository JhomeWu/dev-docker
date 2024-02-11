#!/bin/bash

# This script is can update .env.example with the current values from .env
# Replace all values in .env env value with empty string

# Clear the file .env.example
> .env.example

# Global variable to store the next line to run
nextLineDefault=''
# Read the .env file line by line
cat .env | while read -r line ; do

    # init output variable
    output=$line

    # If this is not comment line, handle it
    if [[ $line != "#"* ]]; then
        # If the line has value like FOO=BAR will cut the value FOO=
        if [[ $line == *"="* ]]; then
            output=$(echo $line | cut -d '=' -f 1)'='
        fi
    fi

    # Output to the .env.example file
    echo "$output$nextLineDefault" >> .env.example

    # If has default value comment '# Default=value #', will store 'value' for next line
    if [[ $line == *"Default="* ]]; then
        nextLineDefault=$(echo $line | cut -d '=' -f 2 | cut -d '#' -f 1)
    else
        # clear the next line default value
        nextLineDefault=''
    fi
done

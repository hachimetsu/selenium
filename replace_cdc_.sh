#!/bin/bash

# Find files and directories with "chromedriver" in their name
find_result=$(sudo find /home/gitpod/.cache/ -type d -name "*chrome*" -o -type f -name "*chrome*" 2>/dev/null | grep -Ei "*/chromedriver/")

# Loop through the results and replace "cdc_" with "dog_" using Vim
for path in $find_result; do
    vim -b -c ":%s/cdc_/dog_/g" -c ":wq" "$path"
    echo "Replaced 'cdc_' with 'xxx_' in $path"
done

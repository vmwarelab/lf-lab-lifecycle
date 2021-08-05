#!/bin/bash

provider=observability
filename=roles.txt
declare -a listArr
listArr=(`cat "$filename"`)
len=${#listArr[@]}

for (( i = 0 ; i < $len ; i++))
do
    echo "Delete issued on: ${listArr[$i]} "
    tmc iam role delete ${listArr[$i]}
done
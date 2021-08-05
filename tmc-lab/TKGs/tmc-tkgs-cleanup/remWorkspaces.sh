#!/bin/bash

provider=observability
filename=workspaces.txt
declare -a listArr
listArr=(`cat "$filename"`)
len=${#listArr[@]}

for (( i = 0 ; i < $len ; i++))
do
    echo "Delete issued on: ${listArr[$i]} "
    tmc workspace delete ${listArr[$i]}
done
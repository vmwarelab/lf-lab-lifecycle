#!/bin/bash

provider=observability
filename=backupLoc.txt
declare -a listArr
listArr=(`cat "$filename"`)
len=${#listArr[@]}

for (( i = 0 ; i < $len ; i++))
do
    echo "Delete issued on: ${listArr[$i]} "
    
    tmc dataprotection provider backuplocation delete ${listArr[$i]} 
done
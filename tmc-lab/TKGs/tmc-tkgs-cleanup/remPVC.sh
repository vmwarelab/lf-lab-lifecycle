#!/bin/bash

provider=observability
filename=observePVC.txt
declare -a listArr
listArr=(`cat "$filename"`)
len=${#listArr[@]}

for (( i = 0 ; i < $len ; i++))
do
    echo "Delete issued on: ${listArr[$i]} "
    
    kubectl delete pvc -n $provider ${listArr[$i]} 
done
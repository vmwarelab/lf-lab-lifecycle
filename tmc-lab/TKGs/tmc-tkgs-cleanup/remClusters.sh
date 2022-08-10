#!/bin/bash

### Command line input options ###
read -p " 1 for TKGs - 2 for AWS:" template

if [ $template -eq 1 ]; then

    provider="observability"
    filename="tkgs-clusters.txt"
    endpoint="tkgs"

        echo "Deleteing all TKGs Clusters using prodvider $provider in delete file $filename"

    tmc system context use $endpoint

    declare -a listArr
    listArr=(`cat "$filename"`)
    len=${#listArr[@]};

elif [ $template -eq 2 ]; then 

    provider="aws"
    filename="aws-clusters.txt"
    endpoint="aws"

        echo "Deleteing all TKGs Clusters using prodvider $provider in delete file $filename"

    tmc system context use $endpoint

    declare -a listArr
    listArr=(`cat "$filename"`)
    len=${#listArr[@]};

else 

    echo "You chose NOTHING choose again"

fi


for (( i = 0 ; i < $len ; i++))
do
    echo "Delete issued on: ${listArr[$i]} "
    tmc cluster delete ${listArr[$i]} -p $provider
done
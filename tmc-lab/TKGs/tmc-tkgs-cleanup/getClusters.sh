#!/bin/bash
# Author: Ben Todd
# Use: Output list of clusters for deletion
# 
# 
# 

### Command line input options ###
read -p " 1 for TKGs - 2 for AWS:" template


if [ $template -eq 1 ]; then

    echo "You chose TKGs"
   #Cleanup Up Old Inout File
    rm ./tkgs-clusters.txt
    #Set TMC System Context for TKGs lab - Note: a TMC Login must be run to create a context named tkgs
    tmc system context use tkgs

    #Get List if Clusters for provider "obervability" - Output to tkgs-clusters.txt
    tmc cluster list -o json -p observability | jq ".clusters[].fullName.name" | sed 's/"//g' > tkgs-clusters.txt
    code tkgs-clusters.txt


elif [ $template -eq 2 ]; then 

    echo "You chose AWS"
   #Cleanup Up Old Inout File
    rm ./aws-clusters.txt

    #Set TMC System Context for AWS lab - Note: a TMC Login must be run to create a context named aws
    tmc system context use aws

    #Get List if Clusters for provider "aws" - Output to tkgawss-clusters.txt
    tmc cluster list -o json -p aws | jq ".clusters[].fullName.name" | sed 's/"//g' > aws-clusters.txt
    sed -i '/tmc-cluster-01/d' aws-clusters.txt
    code aws-clusters.txt


else 

    echo "You chose NOTHING choose again"

fi



# if [ $template -eg 1 ]; then

#     echo "You chose TKGs"

# #    #Cleanup Up Old Inout File
# #     rm ./tkgs-clusters.txt
    
# #     #Set TMC System Context for TKGs lab - Note: a TMC Login must be run to create a context named tkgs
# #     tmc system context use tkgs

# #     #Get List if Clusters for provider "obervability" - Output to tkgs-clusters.txt
# #     tmc cluster list -o json -p observability | jq ".clusters[].fullName.name" | sed 's/"//g' > tkgs-clusters.txt
# #     code tkgs-clusters.txt

# elif [$template -q 2]; then

#     echo "You chose AWS"


# #    #Cleanup Up Old Inout File
# #     rm ./aws-clusters.txt

# #     #Set TMC System Context for AWS lab - Note: a TMC Login must be run to create a context named aws
# #     tmc system context use aws

# #     #Get List if Clusters for provider "aws" - Output to tkgawss-clusters.txt
# #     tmc cluster list -o json -p aws | jq ".clusters[].fullName.name" | sed 's/"//g' > aws-clusters.txt
# #     sed -i '/tmc-cluster-01/d' aws-clusters.txt
# #     code aws-clusters.txt

# else


# fi
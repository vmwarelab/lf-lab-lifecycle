#!/bin/bash

rm ./clusterGrps.txt

tmc clustergroup list -o json | jq '.clusterGroups[] | select(.fullName.name!="default") | select(.fullName.name!="elastic") | .fullName.name' | sed 's/"//g' > clusterGrps.txt
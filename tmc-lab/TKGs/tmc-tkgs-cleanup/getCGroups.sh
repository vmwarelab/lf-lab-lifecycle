#!/bin/bash

rm ./clusterGrps.txt

tmc clustergroup list -o json | jq ".clusterGroups[].fullName.name" | sed 's/"//g' > clusterGrps.txt
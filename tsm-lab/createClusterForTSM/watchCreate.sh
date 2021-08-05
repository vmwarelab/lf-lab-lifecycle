#!/bin/bash
# 
#
#
#


#vars
clusterStatus=$(tmc cluster get tsm-tkgs-be-01 -p livefire -o json | jq ".status.phase" |sed 's/"//g')

while 
    $clusterStatus==CREATING

do
    echo "Cluster Status Is $clusterStatus":

    done
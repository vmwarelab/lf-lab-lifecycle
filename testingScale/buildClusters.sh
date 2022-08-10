#!/bin/bash
# Author: Ben Todd
# Use: Build a Bunch of clusters for testing scale out
# 
# 
# 
#Set WCP IP
runDate=$(date +%Y%m%d%H%M%N)
WCPIP=172.30.0.18

mkdir $runDate




# ### Command line input options ###
read -p "How Many Clusters You Want?: " clusterCount
read -p "Where to start Numerically?: " startCount
read -p "Which Namespace Should I Place These Clusters In: " wcpNS

# # Log Into vsphere using kubectl vsphere plugin
# kubectl vsphere login --server $WCPIP --vsphere-username toddb@lab.livefire.dev --insecure-skip-tls-verify
# kubectx $wcpNS

createYaml(){

    
    cp base-cluster.yaml $1-cluster.yaml;
    sed -i 's/<changenamespace>/'$wcpNS'/g' $1-cluster.yaml;
    sed -i 's/<clusterCount>/scaletest-'$2'-'$1'/g' $1-cluster.yaml;
    sed -i 's/<nodesize>/best-effort-'$1'/g' $1-cluster.yaml
    sed -i 's/<nodecount>/'$3'/g' $1-cluster.yaml
    mv $1-cluster.yaml ./$runDate/$1-cluster-$2.yaml;

}

createCluster(){

kubectl apply -f ./$1/;


}




for (( i = 1 ; i <= $clusterCount ; i++))
do
    
    clusterNum=$(($i + $startCount))

    createYaml "xsmall" $clusterNum 1
    createYaml "large" $clusterNum 3

done

createCluster $runDate
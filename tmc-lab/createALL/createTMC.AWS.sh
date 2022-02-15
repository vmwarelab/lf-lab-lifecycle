#!/bin/bash
# This scripts creates cluster the tmc cli
#It targets AWS or TKGs at the moment for deployments
# The Each Cluster is named miuser-xx-<purpose>
# i.e miuser-01-upgrade miuser-01-scale
# 
#

function createAWS() {
#echo "$deployName, $management, $provisioner, $account, $sshKeyName, $regionAWS, $poolName, $k8sVersion, $nodeType, $workerCount"
tmc cluster create -n $deployName -m $management -p $provisioner -c $account -s $sshKeyName -r $regionAWS --node-pool-name $poolName --version $k8sVersion -y $nodeType -q $workerCount
}

function createTKGs() {
tmc cluster create -t tkgs -n $deployName -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type $nodeType --instance-type $nodeType -q $workerCount
}

###Variable in common
clusterNameBase="miuser"
workerCount="1"
clusterGroupName="default"

### Variables for TKGs


clusterGroupName="default"
k8sVersion=""



### Variables 
clusterCount=30  #Set 'clusterCount' to number of clusters to build.
num=01  #Set 'num' to starting/first cluster number, include padded 0s.  eg: 00013
numA=a
numB=b 
### Command line input options ###
read -p "1 for AWS, 2 for TKGs:  " targetP
read -p "How many students?: " clusterCount
read -p "Starting cluster number?: " num
 
### Do not change these variables ###
max=$(((10#$num)+clusterCount-1))
 
 
###
### Script Body
###
 
set -e
 
### Make sure Tanzu Mission Control CLI is installed
type tmc > /dev/null 2>&1 tmc
if [ $? -eq 1 ]; then
        echo "It does not look like you have Tanzu Mission Control CLI installed. This script requires 'tmc' to automate Tanzu Mission Control functionality."
        exit 1
fi
 
### Loop to create group of TMC clusters
for clusterNum in $(seq -w $num $max)
do
echo $clusterNum       
   
   if [ $targetP -eq "1" ]; then

        echo "AWS GOING HOT!"
        ### Variables for AWS ###
        account="aws"
        accountName="aws"
        regionAWS="us-west-2"
        sshKeyName="controlcenter"
        poolName="workersunite"
        management="aws-hosted"
        provisioner="aws"
        nodeType="m5.large"
        k8sVersion="1.19.15-1-amazon2"
               

        #Call Function to deploy Cluster(s)
        deployName="$clusterNameBase"-"$clusterNum"-upgrade 
        createAWS $deployName $management $provisioner $account $sshKeyName $regionAWS $poolName $k8sVersion $nodeType $workerCount
        echo "$clusterUNameA is provisioning..."

        #Call Function to deploy Cluster(s)
        deployName="$clusterNameBase"-"$clusterNum"-scale        
        createAWS $deployName $management $provisioner $account $sshKeyName $regionAWS $poolName $k8sVersion $nodeType $workerCount


    elif [ $targetP -eq "2" ]; then

        echo "TKGs GOING HOT!"
        provisioner="observability"
        management="wcp-livefire-lab"
        nodeType="best-effort-xsmall"
        k8sVersion="v1.18.15+vmware.1-tkg.1.600e412"
        
        #Call Function to deploy Cluster(s) 
        deployName="$clusterNameBase"-"$clusterNum"-upgrade 
        nodeType="best-effort-xsmall"      
        createTKGs $deployName $management $provisioner $account $sshKeyName $regionAWS $poolName $k8sVersion $nodeType $workerCount

        #Call Function to deploy Cluster(s) 
        deployName="$clusterNameBase"-"$clusterNum"-scale 
        nodeType="best-effort-xsmall"
        createTKGs $deployName $management $provisioner $k8sVersion $workerCount
 
    else 
            echo "No target found for $targetP" 
            exit 1

    fi
     

done
###
### Script End
###

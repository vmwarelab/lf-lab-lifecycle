#!/bin/bash
# This scripts creates 2 sets of clusters using the tmc cli
# The Each set is named csuser-0Xa or b
# i.e. csuser-01a and csuser-01b
# 
#

function createAWS() {
# echo "$deployName, $management, $provisioner, $account, $sshKeyName, $regionAWS, $poolName, $k8sVersion, $nodeType, $workerCount"
tmc cluster create -n $deployName -m $management -p $provisioner -c $account -s $sshKeyName -r $regionAWS --node-pool-name $poolName --version $k8sVersion -y $nodeType -q $workerCount
}


### AWS Specific Variables ###
account="aws"
provisioner="aws"
accountName="aws"
regionAWS="us-west-2"
sshKeyName="controlcenter"
poolName="workersunite"
management="aws-hosted"
nodeType="m5.large"
k8sVersion="1.19.15-1-amazon2"
workerCount=1

### General variables ###
clusterNameBase="miuser"
clusterGroupName="default"
clusterCount=30  #Set 'clusterCount' to number of clusters to build.
num=01  #Set 'num' to starting/first cluster number, include padded 0s.  eg: 00013
numA=a
numB=b 
### Command line input options ###
read -p "How many students?" clusterCount
read -p "Starting cluster number?" num
 
### Do not change these variables ###
max=$(((10#$num)+clusterCount-1))
 
 
###
### Script Body
###
 
set -e
 
### Make sure Tanzu Mission Control CLI is installed
#type tmc > /dev/null 2>&1tmc 
#if [ $? -eq 1 ]; then
#        echo "It does not look like you have Tanzu Mission Control CLI installed. This script requires 'tmc' to automate Tanzu Mission Control functionality."
#        exit 1
#fi
echo 
### Loop to create group of TMC clusters
for clusterNum in $(seq -w $num $max)
do


        deployName="$clusterNameBase"-"$clusterNum"-upgrade
        createAWS $deployName $management $provisioner $account $sshKeyName $regionAWS $poolName $k8sVersion $nodeType $workerCount
        echo "$clusterUNameA is provisioning..."

        deployName="$clusterNameBase"-"$clusterNum"-scale
        createAWS $deployName $management $provisioner $account $sshKeyName $regionAWS $poolName $k8sVersion $nodeType $workerCount     
        echo "$clusterUNameB is provisioning..."

        date > clusterCreateTime.txt


        #clusterNameUpgradeA="$clusterNameBase"-"$clusterNum"-upgrade
        #tmc cluster create -t tkgs -n $clusterNameUpgradeA -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xsmall --instance-type best-effort-xsmall -q 1
        #echo "$clusterNameUpgradeA is provisioning..."

        #clusterNameUpGradeB="$clusterNameBase"-"$clusterNum"-scale
        #tmc cluster create -t tkgs -n $clusterNameUpGradeB -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xsmall --instance-type best-effort-xsmall -q 1
        #echo "$clusterNameUpGradeB is provisioning..."

        #clusterNameUseA="$clusterNameBase"-"$clusterNum"-deploya
        #tmc cluster create -t tkgs -n $clusterNameUseA -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-large --instance-type best-effort-small -q 3
        #echo "$clusterNameUseA is provisioning..."

        #clusterNameUseB="$clusterNameBase"-"$clusterNum"-deployb
        #tmc cluster create -t tkgs -n $clusterNameUseB -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-large --instance-type best-effort-small -q 3
        #echo "$clusterNameUseB is provisioning..."
done
 




###
### Script End
###

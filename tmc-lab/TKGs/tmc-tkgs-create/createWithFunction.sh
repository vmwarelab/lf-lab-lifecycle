#!/bin/bash
# This scripts creates 2 sets of clusters using the tmc cli
# The Each set is named csuser-0Xa or b
# i.e. csuser-01a and csuser-01b
# 
#

### Hard coded variables ###
clusterNameBase="miuser"
provisioner="observability"
management="wcp-livefire-lab"
#clusterNameBase="realylongnameherenow"
clusterGroupName="default"
k8sVersion="v1.18.15+vmware.1-tkg.1.600e412"
clusterCount=30  #Set 'clusterCount' to number of clusters to build.
num=01  #Set 'num' to starting/first cluster number, include padded 0s.  eg: 00013
numA=a
numB=b 



function createTMC() {


tmc cluster create -t tkgs -n $clusterName -g $clusterGroupName /
--allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes /
--version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner /
--worker-instance-type best-effort-xsmall --instance-type best-effort-xsmall -q $wncount
        
        
echo "$clusterName is provisioning..."

}


### Command line input options ###
read -p "How many students? (30) " clusterCount
read -p "Starting cluster number? (01) " num
 
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
 
### Loop to create group of TMC clusters
for clusterNum in $(seq -w $num $max)
do
        clusterNameUpgradeA="$clusterNameBase"-"$clusterNum"-ua
        tmc cluster create -t tkgs -n $clusterNameUpgradeA -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xsmall --instance-type best-effort-xsmall -q 1
        echo "$clusterNameUpgradeA is provisioning..."

        clusterNameUpGradeB="$clusterNameBase"-"$clusterNum"-ub
        tmc cluster create -t tkgs -n $clusterNameUpGradeB -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xsmall --instance-type best-effort-xsmall -q 1
        echo "$clusterNameUpGradeB is provisioning..."

        clusterNameUseA="$clusterNameBase"-"$clusterNum"-depa
        tmc cluster create -t tkgs -n $clusterNameUseA -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xlarge --instance-type best-effort-small -q 3
        echo "$clusterNameUseA is provisioning..."

        clusterNameUseB="$clusterNameBase"-"$clusterNum"-depb
        tmc cluster create -t tkgs -n $clusterNameUseB -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xlarge --instance-type best-effort-small -q 3
        echo "$clusterNameUseB is provisioning..."
done
 




###
### Script End
###

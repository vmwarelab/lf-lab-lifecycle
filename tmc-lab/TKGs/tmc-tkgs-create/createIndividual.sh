#!/bin/bash
# This scripts creates missing TMC clusters
# 
# 
#
 
### Hard coded variables ###
clusterNameBase="miuser"
provisioner="observability"
management="wcp-livefire-lab"
k8sVersion="v1.19.7+vmware.1-tkg.1.fc82c41"
clusterGroupName="default"
###
### Script Body
###
 
set -e
 
## Which Cluster Are we building

echo -n "Which cluster and number to deploy? (depb, depb, scale or upgrade then number; example 'scale 02') "
read whichCluster num

### Make sure Tanzu Mission Control CLI is installed
type tmc > /dev/null 2>&1
if [ $? -eq 1 ]; then
        echo "It does not look like you have Tanzu Mission Control CLI installed. This script requires 'tmc' to automate Tanzu Mission Control functionality."
        exit 1
fi
 

case $whichCluster in 

    scale)
        clusterName="$clusterNameBase-$num-$whichCluster"
        tmc cluster create -t tkgs -n $clusterName -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xsmall --instance-type best-effort-xsmall -q 1
        echo "$clusterName is provisioning...";;
    
    upgrade)
        clusterName="$clusterNameBase-$num-$whichCluster"
        tmc cluster create -t tkgs -n $clusterName -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xsmall --instance-type best-effort-xsmall -q 1
        echo "$clusterName is provisioning...";;

    depa)
        clusterName="$clusterNameBase-$num-$whichCluster"
        tmc cluster create -t tkgs -n $clusterName -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --instance-type best-effort-tsm-cp --high-availability --worker-instance-type best-effort-tsmfe  -q 7
        echo "$clusterName is provisioning...";;
    depb)     

        clusterName="$clusterNameBase-$num-$whichCluster"
        tmc cluster create -t tkgs -n $clusterName -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --instance-type best-effort-tsm-cp --high-availability  --worker-instance-type best-effort-tsmbe  -q 14
        echo "$clusterName is provisioning...";;
    *)
        echo "Only 'front' or 'back' are acceptable: $whichCluster doesn't work try again";;
 esac
###
### Script End
###
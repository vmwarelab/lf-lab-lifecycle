#!/bin/bash
# This scripts creates two clusters using the tmc cli for the TSM lab
# 
# 
#
 
### Hard coded variables ###
clusterNameBase="tsm-tkgs"
provisioner="tsm-lab"
management="wcp-livefire-lab"
clusterGroupName="tsm-lab-cg"
k8sVersion="v1.19.7+vmware.1-tkg.1.fc82c41"
frontEnd=fe-02
backEnd=be-02
feWorkerCount=14
beWorkerCount=7
###
### Script Body
###
 
set -e
 
## Which Cluster Are we building

echo -n "Which cluster to deploy? (front or back) "
read whichCluster

### Make sure Tanzu Mission Control CLI is installed
type tmc > /dev/null 2>&1
if [ $? -eq 1 ]; then
        echo "It does not look like you have Tanzu Mission Control CLI installed. This script requires 'tmc' to automate Tanzu Mission Control functionality."
        exit 1
fi
 

case $whichCluster in 

    front)
        clusterNameA="$clusterNameBase-$frontEnd"
        tmc cluster create -t tkgs -n $clusterNameA -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --instance-type best-effort-tsm-cp --high-availability --worker-instance-type best-effort-tsmfe  -q 7
        echo "$clusterNameA is provisioning...";;
    back)     

        clusterNameB="$clusterNameBase-$backEnd"
        tmc cluster create -t tkgs -n $clusterNameB -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --instance-type best-effort-tsm-cp --high-availability  --worker-instance-type best-effort-tsmbe  -q 14
        echo "$clusterNameB is provisioning...";;
    *)
        echo "Only 'front' or 'back' are acceptable: $whichCluster doesn't work try again";;
 esac
###
### Script End
###

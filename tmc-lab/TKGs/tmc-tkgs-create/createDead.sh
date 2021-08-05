#!/bin/bash




### Hard coded variables ###
provisioner="observability"
management="wcp-livefire-lab"
clusterGroupName="default"
k8sVersion="v1.18.15+vmware.1-tkg.1.600e412" 
#filename=deadList.txt
filename=unhealthy.txt
declare -a listArr
listArr=(`cat "$filename"`)
len=${#listArr[@]}

for (( i = 0 ; i < $len ; i++))
do

    clusterNameA="${listArr[$i]}"
    tmc cluster create -t tkgs -n $clusterNameA -g $clusterGroupName --allowed-storage-classes vsphere-with-kubernetes --storage-class vsphere-with-kubernetes --default-storage-class vsphere-with-kubernetes --version $k8sVersion --management-cluster-name $management --provisioner-name $provisioner --worker-instance-type best-effort-xlarge --instance-type best-effort-small -q 1
    echo "$clusterNameA is provisioning..."

done
#!/bin/bash
# This scripts gets the kubeconfig for two clusters using the tmc cli for the TSM lab
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
#kubePath=/tmp
getPath=/mnt/attendee-share/tanzu/tsm-lab-files
placePath=/run/user/1139803268/gvfs/smb-share:server=hzn-fs-01.livefire.lab,share=attendee-share/tanzu/tsm-lab-files
###
### Script Body
###
 
set -e
 
## Which Cluster Are we building

echo -n "Which kubeconfig to get? (front, back, or clean) "
read whichCluster

### Make sure Tanzu Mission Control CLI is installed
type tmc > /dev/null 2>&1
if [ $? -eq 1 ]; then
        echo "It does not look like you have Tanzu Mission Control CLI installed. This script requires 'tmc' to automate Tanzu Mission Control functionality."
        exit 1
fi
 

case $whichCluster in 

    clean)
        clusterNameA="$clusterNameBase-$frontEnd"
        clusterNameB="$clusterNameBase-$backEnd"
        ls $placePath/
        rm $placePath/kubeconfig-$clusterNameA.yml
        ls $placePath/
        rm $placePath/kubeconfig-$clusterNameB.yml
        ls $placePath/
        ;;

    front)
        clusterNameA="$clusterNameBase-$frontEnd"
        #rm ~/Downloads/kubeconfig-$clusterNameA.yml
        remkube $clusterNameA
        tmc cluster auth kubeconfig get $clusterNameA -m $management -p $provisioner > $placePath/kubeconfig-$clusterNameA.yml
        echo "Got $clusterNameA kubeconfig"
        echo "Path to file is " $getPath/kubeconfig-$clusterNameA.yml
        mergekube $getPath/kubeconfig-$clusterNameA.yml
        echo "MERGED";;

    back)     

        clusterNameB="$clusterNameBase-$backEnd"
        #rm ~/Downloads/kubeconfig-$clusterNameB.yml
        remkube $clusterNameB
        tmc cluster auth kubeconfig get $clusterNameB -m $management -p $provisioner > $placePath/kubeconfig-$clusterNameB.yml
        echo "Got $clusterNameB kubeconfig"
        mergekube $getPath/kubeconfig-$clusterNameB.yml 
        echo "MERGED";;
    *)
        echo "Only 'front' or 'back' are acceptable: $whichCluster doesn't work try again";;
 esac
###
### Script End
###
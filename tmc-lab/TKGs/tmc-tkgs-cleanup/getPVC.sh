#!/bin/bash

#Set WCP IP
WCPIP=172.30.0.18

rm ./observePVC.txt

kubectl vsphere login --server $WCPIP --vsphere-username toddb@lab.livefire.dev --insecure-skip-tls-verify
kubectx $WCPIP
kubectl get pvc -o json -n observability | jq ".items[].metadata.name" | sed 's/"//g' > observePVC.txt
code observePVC.txt
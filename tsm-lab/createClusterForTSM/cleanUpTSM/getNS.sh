#!/bin/bash

rm ./nslist.txt
rm ./nslist.tmp

kubectl get ns -o json |jq '.items[] | .metadata.name' | sed 's/"//g' > nslist.tmp 

sed -n '/gatekeeper-system/!p' nslist.tmp > nslist.tmp

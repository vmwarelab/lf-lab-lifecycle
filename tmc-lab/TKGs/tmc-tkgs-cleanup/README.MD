Get "clean" list of clusters to delete exported to a txt file.

```
tmc cluster list -o json -p observability | jq ".clusters[].fullName.name" | sed 's/"//g' > clusters.txt
```

Get "clean" list of Cluster Groups to delete exported to txt file - BE VERY CAREFUL AND CLEAN THE TXT FIL BEFORE YOU remove

```
tmc clustergroup list -o json | jq ".clusterGroups[].fullName.name" | sed 's/"//g' > clusterGrps.txt
```


```
tmc workspace list -o json | jq ".workspaces[].fullName.name" | sed 's/"//g' > workspaces.txt
```

Get List of roles - BE VERY CAREFUL DO NOT DELETE roles you do not want to delete

'''
tmc iam role list > roles.txt
'''


Get a list of any PVCs left behind

```
k get pvc -o json -n observability | jq ".items[].metadata.name" | sed 's/"//g' > observePVC.txt

```

Data Protection Target location Cleanup

```
tmc dataprotection provider backuplocation list -o json | jq ".backupLocations[].fullName.name" | sed 's/"//g' > backupLoc.txt

```
then do delete for each in the list 

example

```
tmc dataprotection provider backuplocation delete mrottlander-tl
```

Check in the UI, hit refresh if needed to confirm 



TESTING
```
tmc clustergroup list -o json | jq ".clusterGroups[].fullName.name | select (.clusterGroups[].meta.labels.class=bespin)" > text.txt
```
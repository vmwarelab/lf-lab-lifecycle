To create the miuser clusters.

Run

```
./createAWS.sh
``

For a basic class answer "30" and "01"

Then watch cluster creations for aprox an hour, after an huor or so there may be some clusters stuck in "CREATING"


To Clean Up NON READY cluster for redeploy 

Run
```
tmc cluster list -o json -p observability | jq '.clusters[] | select(.status.phase=="CREATING")  | .fullName.name' |sed 's/"//g' > deadList.txt
```

This gives a list of TMC Clusters stuck in CREATING phase, and dumps that list to deadList.txt, which is the input for the next script

Run


```
./remDead.sh
```

OR If there are some with UNHEALTHY health status Run

'''
tmc cluster list -o json -p observability | jq '.clusters[] | select(.status.health!="HEALTHY")  | .fullName.name' |sed 's/"//g' > unhealthy.txt
'''

then modify to accept unhealthy.txt and run "remDead.sh" 



This should delete all the zombie clusters

watch and make sure all have been deleted then run

```
./createDead.sh
```

This will use the same deadList.txt file to create the failedc clusters

Rinse and repeat until the desired number of clusters have been created in TMC for the upcoming lab

CHECK FOr good list
'''
tmc cluster list -o json -p observability | jq '.clusters[] | select(.status.phase=="READY")  | .fullName.name' |sed 's/"//g' > goodList.txt
'''
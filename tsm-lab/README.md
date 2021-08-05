# Lab Create And Cleanup

# tsm-lab-prep
To Prep For the TSM Multicluster Lab edit as needed then run run createCluster.sh

wait for the clusters to be ready and healthy

Then run 

tmc cluster nodepool update default-nodepool  --controlplane-node-count 3 --cluster-name tsm-tkgs-fe-01


Then


```
tmc cluster integration create --dry-run -f tsmIntBE01.yaml
tmc cluster integration create --dry-run -f tsmIntFE01.yaml
```

Check the output to make sure all is well

Then run

```
tmc cluster integration create -f tsmIntBE01.yaml
tmc cluster integration create -f tsmIntFE01.yaml
```



To Create a Cluster

```
tmc cluster create -t tkgs -n <name>-01 -g <clusterGroupName> --allowed-storage-classes vsphere-with-kubernetes --version $k8sVersion --storage-class vsphere-with-kubernetes --management-cluster-name livefire-cs-sv01 --provisioner-name capacity-test --worker-instance-type best-effort-xlarge --instance-type best-effort-small -q 1
```

To Get the Cluster kubeconfig

```
tmc cluster auth kubeconfig get <yourname>-class-02 -m livefire-cs-sv01 -p observability > ~/Downloads/kubeconfig-<yourname>-class-02.yml

```
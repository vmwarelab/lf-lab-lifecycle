Import-Module VMware.WorkloadManagement

$vSphereWithTanzuParams = @{
    TanzuvCenterServer = "tanzu-vcsa-1.tshirts.inc";
    TanzuvCenterServerUsername = "mailto:administrator@vsphere.local";
    TanzuvCenterServerPassword = "VMware1!";
    ClusterName = "Workload-Cluster";
    TanzuContentLibrary = "TKG-Content-Library";
    ControlPlaneSize = "TINY";
    MgmtNetworkStartIP = "172.17.33.190";
    MgmtNetworkSubnet = "255.255.255.0";
    MgmtNetworkGateway = "172.17.33.1";
    MgmtNetworkDNS = @("172.17.31.2");
    MgmtNetworkDNSDomain = "tshirts.inc";
    MgmtNetworkNTP = @("5.199.135.170");
    WorkloadNetworkStartIP = "172.17.32.160";
    WorkloadNetworkIPCount = 8;
    WorkloadNetworkSubnet = "255.255.255.0";
    WorkloadNetworkGateway = "172.17.32.1";
    WorkloadNetworkDNS = @("172.17.31.2");
    WorkloadNetworkServiceCIDR = "10.96.0.0/24";
    StoragePolicyName = "tanzu-gold-storage-policy";
    NSXALBIPAddress = "172.17.33.9";
    NSXALBPort = "443";
    NSXALBCertName = "nsx-alb"
    NSXALBUsername = "admin";
    NSXALBPassword = "VMware1!";
}
New-WorkloadManagement3 @vSphereWithTanzuParams
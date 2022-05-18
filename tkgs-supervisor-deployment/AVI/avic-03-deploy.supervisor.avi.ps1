Import-Module VMware.WorkloadManagement

$vSphereWithTanzuParams = @{
    TanzuvCenterServer = "vcsa-tkg.lab.livefire.dev";
    TanzuvCenterServerUsername = "userID";
    TanzuvCenterServerPassword = "password1";
    ClusterName = "TKGS";
    TanzuContentLibrary = "WCP Content Library";
    ControlPlaneSize = "large";
    MgmtNetwork = "tkgs-mgmt";
    MgmtNetworkStartIP = "192.168.20.10";
    MgmtNetworkSubnet = "255.255.255.0";
    MgmtNetworkGateway = "192.168.20.253";
    MgmtNetworkDNS = @("172.25.0.10","172.25.0.11");
    MgmtNetworkDNSDomain = "livefire.lab";
    MgmtNetworkNTP = @("172.25.0.10","172.25.0.11");
    WorkloadNetwork = "tkgs-workload";
    WorkloadNetworkStartIP = "100.100.0.10";
    WorkloadNetworkIPCount = 2500;
    WorkloadNetworkSubnet = "255.255.240.0";
    WorkloadNetworkGateway = "100.100.0.1";
    WorkloadNetworkDNS = @("172.25.0.10","172.25.0.11");
    WorkloadNetworkServiceCIDR = "10.96.0.0/22";
    StoragePolicyName = "vsphere-with-kubernetes";
    NSXALBIPAddress = "avic-03.lab.livefire.dev";
    #NSXALBIPAddress = "172.16.1.70";
    NSXALBPort = "443";
    NSXALBCertName = "Public-Wildcard-lab-livefire-dev"
    #NSXALBCertName = "nsx-alb"
    NSXALBUsername = "admin";
    NSXALBPassword = "WyhpTKcUsVsBPbo2a!oP";
}


New-WorkloadManagement3 @vSphereWithTanzuParams
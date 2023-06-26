# ContainerLab

See [ContainerLab_Main](/docs/containerlab/ContainerLab_Main.md) for steps to build a virtual lab using n9000v and ContainerLab.

![ContainerLab Topology](./images/ContainerLab_Topology.png)


#### To deploy the lab
```bash
containerlab deploy --topo topo.yml
```

#### To inspect the running lab
```bash
containerlab inspect --topo topo.yml
```

#### To destroy the lab
```bash
containerlab destroy --topo topo.yml
```

### Host VM configuration

Hosts connect to the leafs on trunk port Ethernet1/64 in vlan 2300 (vrf Clients) and vlan 2301 (vrf Servers).

Use host-config.sh in this directory to add the appropriate vlan configuration for these host VMs.


### test_web.bash

This script connects to each host container and runs curl to access the web page for all other hosts, thus testing connectivity across sites and within/between VRFs.

Example output for the working case.  We've modified the default NGINX webpage for each host to include the hostname (e.g. host_1411) and VRF (e.g. Clients).

```bash
root@cvd-3:/home/arobel/repos/clab-deploy/MSD/cvd-3# ./test_web.bash 
CVD_3_MSD clab-nxos-host_1411
WBITT Network MultiTool (with NGINX) - host_1411 - Clients - 192.168.2.201 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_1412 - Servers - 192.168.2.202 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2411 - Clients - 192.168.2.203 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2412 - Servers - 192.168.2.204 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
CVD_3_MSD clab-nxos-host_1412
WBITT Network MultiTool (with NGINX) - host_1411 - Clients - 192.168.2.201 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_1412 - Servers - 192.168.2.202 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2411 - Clients - 192.168.2.203 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2412 - Servers - 192.168.2.204 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
CVD_3_MSD clab-nxos-host_2411
WBITT Network MultiTool (with NGINX) - host_1411 - Clients - 192.168.2.201 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_1412 - Servers - 192.168.2.202 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2411 - Clients - 192.168.2.203 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2412 - Servers - 192.168.2.204 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
CVD_3_MSD clab-nxos-host_2412
WBITT Network MultiTool (with NGINX) - host_1411 - Clients - 192.168.2.201 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_1412 - Servers - 192.168.2.202 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2411 - Clients - 192.168.2.203 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2412 - Servers - 192.168.2.204 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
root@cvd-3:/home/arobel/repos/clab-deploy/MSD/cvd-3# 
```


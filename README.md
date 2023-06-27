# NDFC-EVPN

## About

This repository contains two things:

1. A ContainerLab topology file and base configurations for Cisco Nexus n9000v to create an EVPN Multi-site lab.
2. An Ansible playbook and related assets which use Cisco's Nexus Dashboard Fabric Controller (NDFC) to provision the ContainerLab lab into an EVPN Multi-Site environment using NDFC's Centralized_To_Route_Server DCI option.

Read the following two links to bring up this lab.

- [ContainerLab Bringup Step-by-Step Bringup](/docs/containerlab/ContainerLab_Main.md)
- [Virtual Nexus Dashboard Fabric Controller Bringup Step-by-Step Bringup](/docs/NDFC/NDFC_Main.md)
- [Ansible Playbook Step-by-Step](/docs/ansible/EVPN_Main.md)

### Lab Environment

- 2x VXLAN/EVPN Fabric  (Easy_Fabric)
- 1x DCI Fabric (External_Fabric)
- 1x MSD Multi-site Domain Fabric (MSD_Fabric)

![Topology](/docs/images/NDFC_Topology.png)

### MSD Fabric Characteristics

- Centralized_To_Route_Server DCI option

### DCI Fabric Characteristics

- 1x core_router (centralized route-server)

### VXLAN/EVPN Fabric Characteristics

- 2x border_gateway
- 2x spine
- 2x leaf
- 2x host (one host connected to each leaf on Ethernet1/64)

## System Requirements

This repo was tested in the following environment.

- Cisco UCS C245 M6SX server with 512GB RAM, 2x 3000mHz AMD EPYC 7313 16-Core Processors, Cisco 12G SAS HBA controller, and Toshiba SSD drives.
- Ubuntu 22.04.2 LTS
- Virtual Machine Manager, 4.0.0
- Virtual single-node Nexus Dashboard (ND) 2.3(2d) running under KVM
- Nexus Dashboard Fabric Controller 12.1(2e) hosted on virtual ND

When the lab is fully launched, and NDFC has discovered and configured all 13 n9000v, memory utilization was approximately 193GB and open files were about 89,000:

```bash
root@cvd-3:~# free -m
               total        used        free      shared  buff/cache   available
Mem:          515839      192317      144207          28      179314      320153
Swap:           8191           0        8191
root@cvd-3:~# lsof -w | wc -l
88696
root@cvd-3:~# 
```

This included Xtigervnc displaying an Xfce desktop.  Virtual Machine Manager and three open terminals were displayed on the Xfce desktop.

We accessed the NDFC GUI with Chrome running on a separate server. Chrome opens a ton of files (as determined with ``lsof | wc -l``) and we were hitting a limit for open files when running Chrome locally.  There are ways to increase the open file limit (``ulimit -n``) if this becomes an issue for you.

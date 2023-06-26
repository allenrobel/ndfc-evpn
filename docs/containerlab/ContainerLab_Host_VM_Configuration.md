# ContainerLab - Host VM Configuration

[Back](/docs/containerlab/ContainerLab_Main.md)

Hosts connect to the leafs on trunk port Ethernet1/64 in vlan 2300 (vrf Clients) and vlan 2301 (vrf Servers).

Use ``/ndfc-evpn/ContainerLab/host-config.sh`` to add the appropriate vlan configuration for these host VMs.

```bash
cd ${HOME}/repos/ndfc-evpn/ContainerLab
./host-config.sh
```

![ContainerLab Topology](/docs/containerlab/images/ContainerLab_Topology.png)

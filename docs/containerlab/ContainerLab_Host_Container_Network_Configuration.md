# ContainerLab - Host Container Configuration

[Back](/docs/containerlab/ContainerLab_Main.md)

Hosts connect to the leafs on trunk port Ethernet1/64 in vlan 2300 (vrf Clients) and vlan 2301 (vrf Servers).

Use ``/ndfc-evpn/ContainerLab/host-config.bash`` to add the appropriate vlan configuration for these host VMs.

```bash
cd ${HOME}/repos/ndfc-evpn/ContainerLab
./host-config.bash
```

![ContainerLab Topology](/docs/images/ContainerLab_Topology.png)

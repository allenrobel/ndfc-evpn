# ContainerLab - Base n9000v Configurations

[Back](/docs/containerlab/ContainerLab_Main.md)

Base configurations for n9000v are provided in ./ndfc-evpn/ContainerLab/*.cfg

When ContainerLab is started from within this directory, it loads these configurations as the initial running-config for the n9000v instances.

```bash
cd ${HOME}/repos/ndfc-evpn/ContainerLab
containerlab deploy --topo topo.yml
```

Since n9000v runs as a containerized VM, there was one challenge in getting this to work with NDFC, as shown in the image below. 

![NDFC Discovery Issue](/docs/images/ndfc-discovery.jpg)

NDFC expects that the discovery address (seed-ip in NDFC) is the mgmt0 address of the n9000v switch.  However, by default, the IP address assigned by ContainerLab to mgmt0 is 10.0.0.15/24 (the same IP address is used for all n9000v instances). ContainerLab provisions the ``mgmt-ipv4`` and ``mgmt-ipv6`` addresses using Docker.  NAT is used to access each containerized n9000v, where the "outside" address is the ``mgmt-ipv4`` address (e.g. 192.168.2.131 for leaf_1311) and the "inside" address is 10.0.0.15/24.  When NDFC "discovers" an n9000v, it sees the 10.0.0.15/24 address and declares it unreachable (since it does not have a route to 10.0.0.15 and, even if it did, this address is the same on all n9000v).  To work around this, the base configs for n9000v in this directory change the mgmt0 addresses such that 10.0.0.15/24 is a secondary ip address and 192.168.2.x/24 is the primary address.  In addition, two static routes are added: 1. default route (via 10.0.0.2, which is the "inside" gateway) and 2. a route to the NDFC controller (192.168.2.2) and br-oob gateway (192.168.2.1), both also via 10.0.0.2.  For leaf_1311, this looks like:

```bash
vrf context management
  ip route 0.0.0.0/0 10.0.0.2
  ip route 192.168.2.1/32 10.0.0.2
  ip route 192.168.2.2/32 10.0.0.2
interface mgmt0
  ip address 192.168.2.131/24
  no ip redirects
  ip address 10.0.0.15/24 secondary
  no shutdown
```

This **mostly** solves NDFC's reachability issue, but there one case where this still can be an issue.  When manually discovering containerized n9000v using the NDFC GUI, if you set the seed IP to be, say, the address of leaf_1311 (192.168.2.131), and set max-hops to 2 or 3, NDFC uses CDP to discover the n9000v switches within this 2 or 3 hop radius (using ``show cdp neighbor detail``).  ``show cdp neighbor detail`` returns BOTH the primary and secondary mgmt0 addresses (without differentiating between them), shown below:

```bash
leaf_1311# show cdp neighbor detail  | json-pretty | begin v4mgmtaddr | head lines 4
                "v4mgmtaddr": [
                    "192.168.2.151",
                    "10.0.0.15"
                ],
leaf_1311# 
```

NDFC chooses one of these addresses and, if it chooses by chance the 10.0.0.15 address, then it will declare the n9000v to be unreachable.

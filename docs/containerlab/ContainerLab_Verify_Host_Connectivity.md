# ContainerLab - Verify Host Connectivity

[Back](/docs/containerlab/ContainerLab_Main.md)

## test_web.bash

``/ndfc-evpn/ContainerLab/test_web.bash`` connects to each host container and runs curl to access the web page for all other hosts, thus testing connectivity across sites and within/between VRFs.

## Example output for the working case.

NOTE: We modified the default NGINX webpage for each host to include the hostname (e.g. host_1411) and VRF (e.g. Clients).  These edits are part of the ``quantumonion/netool:latest`` image (see ``/ndfc-evpn/ContainerLab/topo.yml``). If you decide to use the ``wbitt/network-multitool:alpine-extra`` instead, the output will not include these additional items.

```bash
root@cvd-3:/home/arobel/repos/ndfc-evpn/ContainerLab/test_web.bash# ./test_web.bash 
ndfc-evpn clab-nxos-host_1411
WBITT Network MultiTool (with NGINX) - host_1411 - Clients - 192.168.2.201 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_1412 - Servers - 192.168.2.202 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2411 - Clients - 192.168.2.203 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2412 - Servers - 192.168.2.204 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
ndfc-evpn clab-nxos-host_1412
WBITT Network MultiTool (with NGINX) - host_1411 - Clients - 192.168.2.201 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_1412 - Servers - 192.168.2.202 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2411 - Clients - 192.168.2.203 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2412 - Servers - 192.168.2.204 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
ndfc-evpn clab-nxos-host_2411
WBITT Network MultiTool (with NGINX) - host_1411 - Clients - 192.168.2.201 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_1412 - Servers - 192.168.2.202 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2411 - Clients - 192.168.2.203 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2412 - Servers - 192.168.2.204 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
ndfc-evpn clab-nxos-host_2412
WBITT Network MultiTool (with NGINX) - host_1411 - Clients - 192.168.2.201 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_1412 - Servers - 192.168.2.202 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2411 - Clients - 192.168.2.203 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
WBITT Network MultiTool (with NGINX) - host_2412 - Servers - 192.168.2.204 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
root@cvd-3:/home/arobel/repos/ndfc-evpn/ContainerLab/test_web.bash#
```


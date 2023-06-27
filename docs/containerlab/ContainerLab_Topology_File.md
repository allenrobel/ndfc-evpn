# ContainerLab Topology File

[Back](/docs/containerlab/ContainerLab_Main.md)

topo.yml launches the n9000v containerized VMs and hosts, and provisions the inter-switch links and endpoints.

You will want to edit the HTTPS_PROXY and NO_PROXY environment vars for the linux hosts in this file.  You may also want to use the [wbitt/network-multitool:alpine-extra](https://github.com/wbitt/Network-MultiTool) container instead of mine (quantumonion/nettool:latest).

The only difference between these is I changed the default NGINX web page to display the VRF in which the host resides.

```yaml
topology:
  kinds:
    vr-n9kv:
      image: quantumonion/n9kv:10.3.1
    linux:
      #image: wbitt/network-multitool:alpine-extra
      image: quantumonion/netool:latest
      env:
        HTTPS_PROXY: http://proxy.esl.cisco.com:80
        NO_PROXY: cisco.com,arobel.com,localhost,172.31.165.33
```

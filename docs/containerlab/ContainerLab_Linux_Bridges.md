# ContainerLab - Linux Bridges

[Back](/docs/containerlab/ContainerLab_Main.md)


### Add linux bridges for the n9000v management network.

![Bridge br-oob](/docs/images/br-oob.png)

The below adds a temporary bridge for our management network. This will not survive a server reboot.  If you want the bridge to be available after a server reboot, there's plenty of documentation out there for adding these permanently.

```bash
sudo brctl addbr br-oob
sudo ifconfig br-oob up
sudo ip address add 192.168.2.1/24 dev br-oob
```

### If you're using [NDFC under KVM](/docs/NDFC/nd_ndfc_provisioning.md), NDFC expects a data network, in addition to the above management network.

![Bridge br-vnd](/docs/images/br-vnd.png)

```bash
sudo brctl addbr br-vnd
sudo ifconfig br-vnd up
sudo ip address add 192.168.3.1/24 dev br-vnd
```

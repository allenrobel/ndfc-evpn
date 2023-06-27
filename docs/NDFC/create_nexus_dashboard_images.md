# Create Nexus Dashboard Images

[Back](/docs/NDFC/NDFC_Main.md)

1. Download the Nexus Dashboard qcow image.

[Nexus Dashboard VM Image for Linux KVM](https://software.cisco.com/download/home/286327743/type/286328258/release/2.3(2d))

2. Create the node1-disk1 image from an ND qcow image

We'll assume you've saved the Nexus Dashboard qcow image to the following location, and that you are using the same location for the resulting two images that we are going to create.

Modify to match your actual location.

```bash
${HOME}/nd/nd-dk9.2.3.2d.qcow2
```

```bash
cd ${HOME}/nd
qemu-img create -f qcow2 -F qcow2 -b nd-dk9.2.3.2d.qcow2 nd-node1-disk1.qcow2
```

3. Create the node1-disk2 image in the same location

```bash
cd ${HOME}/nd
qemu-img create -f qcow2 nd-node1-disk2.qcow2 500G
```

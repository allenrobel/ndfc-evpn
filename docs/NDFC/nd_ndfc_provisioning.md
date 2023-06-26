# ND and NDFC provisioning

If you want to run ND+NDFC on the same host as your ContainerLab deployment, below is a cheat sheet.

1. You'll need qemu-utils for the qemu-img utility

```bash
sudo apt install qemu-utils
```

2. Create the node1-disk1 image from an ND qcow image

```bash
qemu-img create -f qcow2 -F qcow2 -b /home/arobel/iso/nd/nd-dk9.2.3.2d.qcow2 ./nd-node1-disk1.qcow2
```

3. Create the node1-disk2 image

```bash
qemu-img create -f qcow2 nd-node1-disk2.qcow2 500G
```

4. You'll need [virt-manager](https://ubuntu.com/server/docs/virtualization-virt-tools) for the next steps.

```bash
sudo apt install virt-manager
```

Change the two ``--disk`` arguments to point to the images you created above.  Minimum recommended RAM for ND+NDFC is 64000.  We've increased this to 96000 below based on our experience with this multi-site topology. 

```bash
virt-install --name nd \
    --vcpus 16 --ram 96000 --osinfo linux2020 \
    --disk path=/home/arobel/nd/nd-node1-disk1.qcow2 \
    --disk path=/home/arobel/nd/nd-node1-disk2.qcow2 \
    --network bridge:br-oob,model=virtio,address.type=pci,address.domain=0,address.bus=0,address.slot=3 \
    --network bridge:br-vnd,model=virtio,address.type=pci,address.domain=0,address.bus=0,address.slot=4 \
    --noautoconsole --import
```

NOTE if Virtual Machine Manager gives a permissions error on starting up the ND VM, try the following; substituting your username for ``arobel`` below.

```bash
sudo usermod -G kvm "arobel"
sudo usermod -G libvirtd "arobel"
ls -ld /dev/kvm
crw-rw---- 1 root kvm 10, 232 Jun 20 23:52 /dev/kvm  << These are correct permissions
```

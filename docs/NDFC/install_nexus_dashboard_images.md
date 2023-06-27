# Install Nexus Dashboard Images

[Back](/docs/NDFC/NDFC_Main.md)

## Use virt-install to install the images previously created with qemu-img

Change the two ``--disk path=`` arguments below to point to the images you previously created.

The minimum recommended RAM for Nexus Dashboard is 64000 (64GB).  We've increased this to 96000 (96GB) based on our experience with the EVPN multi-site topology we are building in this repo.

```bash
cd ${HOME}/nd
virt-install --name nd \
    --vcpus 16 --ram 96000 --osinfo linux2020 \
    --disk path=${HOME}/nd/nd-node1-disk1.qcow2 \
    --disk path=${HOME}/nd/nd-node1-disk2.qcow2 \
    --network bridge:br-oob,model=virtio,address.type=pci,address.domain=0,address.bus=0,address.slot=3 \
    --network bridge:br-vnd,model=virtio,address.type=pci,address.domain=0,address.bus=0,address.slot=4 \
    --noautoconsole --import
```

## Open Virtual Machine Manager

If Virtual Machine Manager is not already open, open it.  Below is an example using Xfce desktop.  Your desktop environment is likely different.

![Launch Virtual Machine Manager](/docs/images/launch_virtual_machine_manager.png)

## Start Nexus Dashboard

![Start Nexus Dashboard](/docs/images/virtual_machine_manager.png)

Click the green Start Arrow.

NOTE if Virtual Machine Manager gives a permissions error on starting up the ND VM, try the following; substituting your username for ``username`` below.

```bash
sudo usermod -G kvm "username"
sudo usermod -G libvirtd "username"
ls -ld /dev/kvm
crw-rw---- 1 root kvm 10, 232 Jun 20 23:52 /dev/kvm  << These are correct permissions
```

## Nexus Dashboard Initial configuration

When ND has started, click the Open button.  This will open a terminal where you will enter the management network information.

It will take some time for ND to boot so be patient.  You'll see a blinking cursor on a blank screen initially.

![Nexus Dashboard Initial Boot](/docs/images/nd_initial_boot.png)

When ND boots, you'll be asked to press any key to start the initial configuration.

![Nexus Dashboard Press Any Key](/docs/images/nd_press_any_key.png)

Enter the information requested.  If you are using the same addressing as this repository, you'll enter this as shown below.

![Nexus Dashboard Enter, Review, and Confirm Configuration](/docs/images/nd_review_and_confirm_config.png)

After confirming the configuration, it will take another minute or so for Nexus Dashboard to make its UI available.

![Nexus Dashboard Enter, Review, and Confirm Configuration](/docs/images/nd_wait_for_ui_online.png)

Once it's available, you'll point your browser at the provided URL to complete configuration.

![Nexus Dashboard Enter, Review, and Confirm Configuration](/docs/images/nd_system_ui_online.png)

# ContainerLab - Deploying, Inspecting, and Destroying the Lab

[Back](/docs/containerlab/ContainerLab_Main.md)

#### To deploy the lab
```bash
cd ${HOME}/repos/ndfc-evpn/ContainerLab
sudo containerlab deploy --topo topo.yml
```

NOTE: There is a caveat when deploying the lab.  Intermittently, the virtual console port ContainerLab uses to issue ``copy running-config startup-config`` closes before ContainerLab has a chance to save the n9000 configuration.  If you bring up the lab and then run the Ansible playbook to configure the VXLAN/EVPN topology, NDFC will reboot the n9000v after discovering them.  If ContainerLab has not saved the running-config to startup-config, the n9000v boot string will be empty and the n9000v will end up at the loader prompt.  Thus, it's a good idea to check that the boot string on all n9000v is set prior to running the Ansible script.

#### To inspect the running lab
```bash
cd ${HOME}/repos/ndfc-evpn/ContainerLab
sudo containerlab inspect --topo topo.yml
```

#### To destroy the lab
```bash
cd ${HOME}/repos/ndfc-evpn/ContainerLab
sudo containerlab destroy --topo topo.yml
```

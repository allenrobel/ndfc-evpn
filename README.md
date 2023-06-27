# NDFC-EVPN

## About

This repository contains two things:

1. A ContainerLab topology file and base configurations for Cisco Nexus n9000v to create an EVPN Multi-site lab.
2. An Ansible playbook and related assets which use Cisco's Nexus Dashboard Fabric Controller (NDFC) to provision the ContainerLab lab into an EVPN Multi-Site environment using NDFC's Centralized_To_Route_Server DCI option.

[ContainerLab Bringup Step-by-Step Bringup](/docs/containerlab/ContainerLab_Main.md)
[Ansible Playbook Step-by-Step](/docs/ansible/EVPN_Main.md)

The environment consists of:

- 2x VXLAN/EVPN Fabric  (Easy_Fabric)
- 1x DCI Fabric (External_Fabric)
- 1x MSD Multi-site Domain Fabric (MSD_Fabric)

![Topology](/docs/images/NDFC_Topology.png)

### MSD Fabric Characteristics
- Centralized_To_Route_Server DCI option

### DCI Fabric Characteristics
- 1x core_router (functional role: centralized route-server)

### VXLAN/EVPN Fabric Characteristics
- 2x border_gateway
- 2x spine
- 2x leaf
- 2x host (one host connected to each leaf on Ethernet1/64)

## Repository Contents

1. EVPN.yml - The Ansible playbook which configures the Nexus switches
2. inventory/* - Edit inventory/hosts and inventory/group_vars/ndfc per steps 3 and 4 below.
3. ansible.cfg - Required for NDFC.  See step 2 below.
4. ContainerLab/* - Topology file and n9000v base configurations for creating an EVPN Multi-site lab.

## System Requirements

This repo was tested in the following environment.

- Cisco UCS C245 M6SX server with 512GB RAM, 2x 3000mHz AMD EPYC 7313 16-Core Processors, Cisco 12G SAS HBA controller, and Toshiba SSD drives.
- Ubuntu 22.04.2 LTS
- Virtual Machine Manager, 4.0.0
- Virtual single-node Nexus Dashboard 2.3(2d) running under KVM
- Nexus Dashboard Fabric Controller 12.1(2e)

When the lab is fully launched, and NDFC has discovered and configured all 13 n9000v, memory utilization was approximately 193GB and open files were about 89,000:

```bash
root@cvd-3:~# free -m
               total        used        free      shared  buff/cache   available
Mem:          515839      192317      144207          28      179314      320153
Swap:           8191           0        8191
root@cvd-3:~# lsof -w | wc -l
88696
root@cvd-3:~# 
```

This included Xtigervnc displaying an Xfce desktop with Virtual Machine Manager, and three open terminals running.

We accessed NDFC GUI with Chrome running on a separate server, since Chrome opens many files (as determined with ``lsof | wc -l``) and we were hitting a limit for open files when running Chrome locally.  There are ways to increase the open file limit (``ulimit -n``) if this becomes an issue for you.

## Installation and Usage

The steps below outline usage of the Ansible playbook EVPN.yml and, optionally, building a lab using ContainerLab.

### 1. Install the cisco.dcnm Ansible Collection 

The Ansible playbook in this repo requires that the cisco.dcnm Collection be installed.

```bash
ansible-galaxy collection install cisco.dcnm
```

## 2. Ansible Custom Configuration

NDFC requires increasing the default timeout for persistent connections from Ansible's default of 30 seconds to >= 1000 seconds.  We have provided an ansible.cfg file with the requisite changes in this repo's top-level directory.  If you would rather edit your existing ansible.cfg file (wherever it is), the changes are shown below.

```bash
[persistent_connection]
command_timeout=1800
connect_timeout=1800
```

### 3. Modify ./inventory/group_vars/ndfc

./inventory/group_vars/ndfc contains the following:

- Usernames and passwords for NDFC and NX-OS devices
- NX-OS switch discovery addresses and role definitions
- Fabrics, VRFs, and Networks configurations for VXLAN/EVPN
- Various Ansible settings for NDFC

#### Edit ``ansible_password`` (password for NDFC controller) and ``device_password`` (password for NX-OS switches)

Add ``ansible_password`` and ``device_password`` in encrypted format (or non-encrypted, if you don't care about security).  These are the passwords you use to login to your DCNM/NDFC Controller, and NX-OS switches, respectively.

To add encrypted passwords for the NDFC controller and NX-OS devices, issue the following from this repo's top-level directory.  The lines containing ``echo`` are to ensure carraige returns are added after each line that ``ansible-vault`` adds.

```bash
ansible-vault encrypt_string 'mySuperSecretNdfcPassword' --name 'ansible_password' >> ./inventory/group_vars/ndfc
echo "\n" >> ./inventory/group_vars/ndfc
ansible-vault encrypt_string 'mySuperSecretNxosPassword' --name 'device_password' >> ./inventory/group_vars/ndfc
echo "\n" >> ./inventory/group_vars/ndfc
```

ansible-vault will prompt you for a vault password each time it's invoked, which you'll use to decrypt these passwords (using ``ansible-playbook --ask-vault-pass``) when running the example playbooks.

Example:

```bash
% ansible-vault encrypt_string 'mySuperSecretNdfcPassword' --name 'ansible_password' >> ./inventory/group_vars/ndfc
New Vault password: 
Confirm New Vault password: 
echo "\n" >> ./inventory/group_vars/ndfc
% cat ./inventory/group_vars/ndfc
ansible_password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          35313565343034623966323832303764633165386439663133323832383336366362663431366565
          6238373030393562363831616266336464353963393566300a316564663135323263653165393330
          33353935396462663531323437336366653937326234313866623535313431366534363938633834
          6563336634653963320a376364323430316134623430636265383561663631343763646465626365
          36666366333438373537343033393939653830663061623362613439376161626439

%

```

If you don't care about security, you can add a non-encrypted password by editing the file directly.
The following are example unencrypted passwords for the NDFC controller and NX-OS devices added to this file:

```bash
ansible_password: mySuperSecretNdfcPassword
device_password: mySuperSecretNxosPassword
```

#### Edit ``ansible_user``

Change ``ansible_user`` in the same file to the username associated with the above password that you're using on DCNM/NDFC.
Change ``device_username`` in the same file to the username used to login to your NX-OS switches.

Example:

```bash
ansible_user: voldomort
device_username: admin
```

#### If using physical NX-OS switches, edit the discovery IP addresses for your switches

See the following section:

```yaml
devices:
    leaf_11:
etc...
```

If you plan to use ContainerLab to provision your lab, see the ContainerLab directory in this repo for the base switch configurations. These match the discovery IP addresses in group_vars/ndfc.


### 4. Update ``./inventory/hosts/hosts`` with the IP address of your ND/NDFC Controller

```bash
% cat ./inventory/hosts/hosts 
---
ndfc:
  hosts:
    ndfc1:
      ansible_host: 192.168.2.2
```


### 5. Run the playbook

#### If you encrypted your NDFC password:

```bash
cd /top/level/directory/for/this/repo
ansible-playbook EVPN.yml -i inventory --ask-vault-pass 
```

When prompted, enter the password you used in response to the ansible-vault command in step 1 above.

#### Or, if you didn't encrypt the NDFC password:

```bash
cd /top/level/directory/for/this/repo
ansible-playbook EVPN.yml -i inventory
```

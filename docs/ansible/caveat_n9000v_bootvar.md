# Caveat! n9000v bootvar

Intermittently, the ContainerLab virtual console port closes before ContainerLab has a chance to write ``copy running-config startup-config`` to the n9000v.

This results in the n9000v booting the the ``loader>`` when it's next reloaded.

Since NDFC reboots the n9000v during its discovery phase, you may end up with one or more n9000v sitting at the ``loader>`` prompt.

To avoid this, always check all n9000v before running the EVPN.yml playbook (or before manually discovering the n9000v in NDFC if you don't use the playbook).

If you DO end up with one or more n9000v at the ``loader>`` prompt, connect to the console and boot the nxos image manually, per the example below.

```bash
# Get the hostname or IP of the n9000v
cd ${HOME}/repos/ndfc-evpn/ContainerLab
arobel@cvd-3:~/repos/ndfc-evpn/ContainerLab$ sudo containerlab inspect --topo topo.yml 
[sudo] password for arobel: 
INFO[0000] Parsing & checking topology file: topo.yml   
+----+----------------------+--------------+----------------------------+---------+---------+------------------+------------------------+
| #  |         Name         | Container ID |           Image            |  Kind   |  State  |   IPv4 Address   |      IPv6 Address      |
+----+----------------------+--------------+----------------------------+---------+---------+------------------+------------------------+
|  1 | clab-nxos-bgw_1111   | f99ef064e576 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.161/24 | 2001:192:168:2::161/80 |
|  2 | clab-nxos-bgw_1112   | 70aad4146559 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.162/24 | 2001:192:168:2::162/80 |
|  3 | clab-nxos-bgw_2111   | 5135cc1c731c | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.163/24 | 2001:192:168:2::163/80 |
|  4 | clab-nxos-bgw_2112   | 47bcb89a5b76 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.164/24 | 2001:192:168:2::164/80 |
|  5 | clab-nxos-dci_111    | f476256df04f | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.171/24 | 2001:192:168:2::171/80 |
|  6 | clab-nxos-host_1411  | 62cf5e9fc098 | quantumonion/netool:latest | linux   | running | 192.168.2.201/24 | 2001:192:168:2::201/80 |
|  7 | clab-nxos-host_1412  | b7b57179d7ed | quantumonion/netool:latest | linux   | running | 192.168.2.202/24 | 2001:192:168:2::202/80 |
|  8 | clab-nxos-host_2411  | 9f4b14bb0bce | quantumonion/netool:latest | linux   | running | 192.168.2.203/24 | 2001:192:168:2::203/80 |
|  9 | clab-nxos-host_2412  | bfdfc3415f34 | quantumonion/netool:latest | linux   | running | 192.168.2.204/24 | 2001:192:168:2::204/80 |
| 10 | clab-nxos-leaf_1311  | 5b4f952c5504 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.131/24 | 2001:192:168:2::131/80 |
| 11 | clab-nxos-leaf_1312  | 9c383abdebb3 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.132/24 | 2001:192:168:2::132/80 |
| 12 | clab-nxos-leaf_2311  | c0ba0311ec54 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.133/24 | 2001:192:168:2::133/80 |
| 13 | clab-nxos-leaf_2312  | b82b99d9a1a3 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.134/24 | 2001:192:168:2::134/80 |
| 14 | clab-nxos-spine_1211 | 14d2756157b4 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.151/24 | 2001:192:168:2::151/80 |
| 15 | clab-nxos-spine_1212 | 2f48edee2ffc | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.152/24 | 2001:192:168:2::152/80 |
| 16 | clab-nxos-spine_2211 | 1d5aa75084b9 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.153/24 | 2001:192:168:2::153/80 |
| 17 | clab-nxos-spine_2212 | 9ad3a3837702 | quantumonion/n9kv:10.3.1   | vr-n9kv | running | 192.168.2.154/24 | 2001:192:168:2::154/80 |
+----+----------------------+--------------+----------------------------+---------+---------+------------------+------------------------+
arobel@cvd-3:~/repos/ndfc-evpn/ContainerLab$

# Connect to the console (example)
arobel@cvd-3:~/repos/ndfc-evpn/ContainerLab$ telnet clab-nxos-bgw_1111 5000
Trying 2001:192:168:2::161...
Trying 192.168.2.161...
Connected to clab-nxos-bgw_1111.
Escape character is '^]'.

loader> boot bootflash:/nxos64-cs.10.3.1.F.bin
```

When the n9000v is booted, login and manually issue ``copy running-config startup-config`` to set the boot variables.

```bash
bgw_1111 login: admin
Password: 

Cisco NX-OS Software
Copyright (c) 2002-2022, Cisco Systems, Inc. All rights reserved.
Nexus 9000v software ("Nexus 9000v Software") and related documentation,
files or other reference materials ("Documentation") are
the proprietary property and confidential information of Cisco
Systems, Inc. ("Cisco") and are protected, without limitation,
pursuant to United States and International copyright and trademark
laws in the applicable jurisdiction which provide civil and criminal
penalties for copying or distribution without Cisco's authorization.

Any use or disclosure, in whole or in part, of the Nexus 9000v Software
or Documentation to any third party for any purposes is expressly
prohibited except as otherwise authorized by Cisco in writing.
The copyrights to certain works contained herein are owned by other
third parties and are used and distributed under license. Some parts
of this software may be covered under the GNU Public License or the
GNU Lesser General Public License. A copy of each such license is
available at
http://www.gnu.org/licenses/gpl.html and
http://www.gnu.org/licenses/lgpl.html
***************************************************************************
*  Nexus 9000v is strictly limited to use for evaluation, demonstration   *
*  and NX-OS education. Any use or disclosure, in whole or in part of     *
*  the Nexus 9000v Software or Documentation to any third party for any   *
*  purposes is expressly prohibited except as otherwise authorized by     *
*  Cisco in writing.                                                      *
***************************************************************************
bgw_1111# copy running-config startup-config 
[########################################] 100%
Copy complete, now saving to disk (please wait)...
Copy complete.
bgw_1111#
```

Verify that the boot variables are set.

```bash
bgw_1111# show boot 
Current Boot Variables:
sup-1
NXOS variable = bootflash:/nxos64-cs.10.3.1.F.bin
Boot POAP Disabled

Boot Variables on next reload:
sup-1
NXOS variable = bootflash:/nxos64-cs.10.3.1.F.bin
Boot POAP Disabled
bgw_1111# 
```

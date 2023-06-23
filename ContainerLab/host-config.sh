#!/bin/sh
sudo docker exec -d clab-nxos-host_1411 ip link set eth1 up
sudo docker exec -d clab-nxos-host_1411 ip link add link eth1 name Vlan2300 type vlan id 2300
sudo docker exec -d clab-nxos-host_1411 ip addr add 192.168.10.201/24 brd 192.168.10.255 dev Vlan2300
sudo docker exec -d clab-nxos-host_1411 ip link set dev Vlan2300 up
sudo docker exec -d clab-nxos-host_1411 ip route add 192.168.11.0/24 via 192.168.10.1

sudo docker exec -d clab-nxos-host_1412 ip link set eth1 up
sudo docker exec -d clab-nxos-host_1412 ip link add link eth1 name Vlan2300 type vlan id 2300
sudo docker exec -d clab-nxos-host_1412 ip addr add 192.168.10.202/24 brd 192.168.10.255 dev Vlan2300
sudo docker exec -d clab-nxos-host_1412 ip link set dev Vlan2300 up
sudo docker exec -d clab-nxos-host_1412 ip route add 192.168.11.0/24 via 192.168.10.1

sudo docker exec -d clab-nxos-host_2411 ip link set eth1 up
sudo docker exec -d clab-nxos-host_2411 ip link add link eth1 name Vlan2301 type vlan id 2301
sudo docker exec -d clab-nxos-host_2411 ip addr add 192.168.11.203/24 brd 192.168.11.255 dev Vlan2301
sudo docker exec -d clab-nxos-host_2411 ip link set dev Vlan2301 up
sudo docker exec -d clab-nxos-host_2411 ip route add 192.168.10.0/24 via 192.168.11.1

sudo docker exec -d clab-nxos-host_2412 ip link set eth1 up
sudo docker exec -d clab-nxos-host_2412 ip link add link eth1 name Vlan2301 type vlan id 2301
sudo docker exec -d clab-nxos-host_2412 ip addr add 192.168.11.204/24 brd 192.168.11.255 dev Vlan2301
sudo docker exec -d clab-nxos-host_2412 ip link set dev Vlan2301 up
sudo docker exec -d clab-nxos-host_2412 ip route add 192.168.10.0/24 via 192.168.11.1


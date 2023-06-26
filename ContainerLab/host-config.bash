#!/usr/bin/bash
# Configure host container interfaces and routes.
# Host containers are each connected to n9000v leafs, via the leaf's
# Ethernet1/64 interface.  Ethernet1/64 is configured as a trunk with
# allowed-vlan 2300 (VRF Clients) or 2301 (VRF Servers).  This script
# configures the host container eth1 interface with a dot1q configuration
# to match the respective leaf interface config.

VLAN_CLIENTS=2300
VLAN_CLIENTS_GATEWAY="192.168.10.1"
VLAN_CLIENTS_ROUTE="192.168.10.0/24"
VLAN_CLIENTS_BROADCAST="192.168.10.255"

VLAN_SERVERS=2301
VLAN_SERVERS_GATEWAY="192.168.11.1"
VLAN_SERVERS_ROUTE="192.168.11.0/24"
VLAN_SERVERS_BROADCAST="192.168.11.255"

VLAN=${VLAN_CLIENTS}
ROUTE=${VLAN_SERVERS_ROUTE}
GATEWAY=${VLAN_CLIENTS_GATEWAY}
BROADCAST=${VLAN_CLIENTS_BROADCAST}

HOST=clab-nxos-host_1411
IP="192.168.10.201/24"
echo $HOST Vlan${VLAN} configuration START
sudo docker exec -d $HOST ip link set eth1 up
sudo docker exec -d $HOST ip link add link eth1 name Vlan${VLAN} type vlan id ${VLAN}
sudo docker exec -d $HOST ip addr add ${IP} brd ${BROADCAST} dev Vlan${VLAN}
sudo docker exec -d $HOST ip link set dev Vlan${VLAN} up
sudo docker exec -d $HOST ip route add ${ROUTE} via ${GATEWAY}
echo $HOST Vlan${VLAN} configuration DONE


HOST=clab-nxos-host_1412
IP="192.168.10.202/24"
echo $HOST Vlan${VLAN} configuration START
sudo docker exec -d $HOST ip link set eth1 up
sudo docker exec -d $HOST ip link add link eth1 name Vlan${VLAN} type vlan id ${VLAN}
sudo docker exec -d $HOST ip addr add ${IP} brd ${BROADCAST} dev Vlan${VLAN}
sudo docker exec -d $HOST ip link set dev Vlan${VLAN} up
sudo docker exec -d $HOST ip route add ${ROUTE} via ${GATEWAY}
echo $HOST Vlan${VLAN} configuration DONE

VLAN=${VLAN_SERVERS}
ROUTE=${VLAN_CLIENTS_ROUTE}
GATEWAY=${VLAN_SERVERS_GATEWAY}
BROADCAST=${VLAN_SERVERS_BROADCAST}

HOST=clab-nxos-host_2411
IP="192.168.11.203/24"
echo $HOST Vlan${VLAN} configuration START
sudo docker exec -d $HOST ip link set eth1 up
sudo docker exec -d $HOST ip link add link eth1 name Vlan${VLAN} type vlan id ${VLAN}
sudo docker exec -d $HOST ip addr add ${IP} brd ${BROADCAST} dev Vlan${VLAN}
sudo docker exec -d $HOST ip link set dev Vlan${VLAN} up
sudo docker exec -d $HOST ip route add ${ROUTE} via ${GATEWAY}
echo $HOST Vlan${VLAN} configuration DONE

HOST=clab-nxos-host_2412
IP="192.168.11.204/24"
echo $HOST Vlan${VLAN} configuration START
sudo docker exec -d $HOST ip link set eth1 up
sudo docker exec -d $HOST ip link add link eth1 name Vlan${VLAN} type vlan id ${VLAN}
sudo docker exec -d $HOST ip addr add ${IP} brd ${BROADCAST} dev Vlan${VLAN}
sudo docker exec -d $HOST ip link set dev Vlan${VLAN} up
sudo docker exec -d $HOST ip route add ${ROUTE} via ${GATEWAY}
echo $HOST Vlan${VLAN} configuration DONE

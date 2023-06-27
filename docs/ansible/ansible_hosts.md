# Ansible hosts

[Back](/docs/ansible/EVPN_Main.md)

``/ndfc-evpn/inventory/hosts/hosts`` is configured with the IP address of the virtualized ND/NDFC Controller.  If you are using a different NDFC instance, modify this file with the controller's address.

```bash
% cat ./inventory/hosts/hosts 
---
ndfc:
  hosts:
    ndfc1:
      ansible_host: 192.168.2.2
```

# Run the Playbook

[Back](/docs/ansible/EVPN_Main.md)

## If you encrypted your NDFC password

```bash
cd ${HOME}/repos/ndfc-evpn
ansible-playbook EVPN.yml -i inventory --ask-vault-pass 
```

When prompted, enter the password you used in response to the [ansible-vault command](/docs/ansible/ansible_group_vars.md).

## If you didn't encrypt your NDFC password

```bash
cd ${HOME}/repos/ndfc-evpn
ansible-playbook EVPN.yml -i inventory
```

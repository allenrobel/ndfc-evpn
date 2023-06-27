# Run the Playbook

#### If you encrypted your NDFC password:

```bash
cd ${HOME}/repos/ndfc-evpn
ansible-playbook EVPN.yml -i inventory --ask-vault-pass 
```

When prompted, enter the password you used in response to the ansible-vault command in step 1 above.

#### Or, if you didn't encrypt the NDFC password:

```bash
cd ${HOME}/repos/ndfc-evpn
ansible-playbook EVPN.yml -i inventory
```

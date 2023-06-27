# Ansible ``group_vars``


``/ndfc-evpn/inventory/group_vars/ndfc`` contains the following:

- Usernames and passwords for NDFC and NX-OS devices
- NX-OS switch discovery addresses and role definitions
- Fabrics, VRFs, and Networks configurations for VXLAN/EVPN
- Various Ansible settings for NDFC

## Passwords

Edit ``ansible_password`` (password for NDFC controller) and ``device_password`` (password for Nexus n9000v switches)

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

If you are using ContainerLab to provision your lab, see ``ndfc-evpn/ContainerLab/*.cfg`` for the base switch configurations. These match the discovery IP addresses in ``/ndfc-evpn/inventory/group_vars/ndfc``.




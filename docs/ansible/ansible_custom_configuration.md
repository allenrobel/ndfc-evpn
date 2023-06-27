# Ansible Custom Configuration

NDFC requires increasing the default timeout for persistent connections from Ansible's default of 30 seconds to >= 1000 seconds.  We have provided an ansible.cfg file with the requisite changes in this repo's top-level directory.  If you would rather edit your existing ansible.cfg file (wherever it is), the changes are shown below.

```bash
[persistent_connection]
command_timeout=1800
connect_timeout=1800
```

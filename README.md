# Introduction 
This project defines scripts for provisioning edge machines using ansible. Ansible works by connecting to target machines via SSH, installs required software and makes necessary configurations

# IMPORTANT
This module uses active user's private/public key pair, thus the the image cannot be pushed to the cloud. To solve that ansible container should have separate private/public key pair

# Playbooks

| Playbook | Description |
| ------------- |-------------|
| **01_users.yml** | Create necessary groups (admins, developers), users and pushes their public keys to target machine |
| **02_hardening.yml** | Harden the server OS and SSH service |
| **03_nvidia.yml** | Install nvidia drivers |
| **04_iotedge.yml** | Install IoT Edge dependencies |
| **05_fail2ban.yml** | Install fail2ban tool |

# Initial steps

To be able to run playbooks user needs to build *em-provisioning* container locally and run it.
1. ```scripts/build_container.sh```
2. Username needs to be placed into `includes/user_config/ssh/username` file so that ansible could use it for its playbooks
3. ```scripts/run_container.sh```

# Adding new users

New users needs be added to:
1. Username and its groups to `includes/users.yml` file.
2. User's public key needs to be places into `includes/keyfiles` folder

# Provisioning barebones
1. Add new barebone `includes/user_config/ssh/config` file as **Host** block

2. Add new barebone into `hosts` file **[edgemachines]** section.

3. Create users by running script below. Password needs to be entered twice. First time for SSH login, second for becoming superuser.
```
ansible-playbook 01_users.yml --extra-vars "@includes/default-user.json" -Kk --extra-vars "variable_hosts=hostname"
```
4. Install nvidia drivers
```
ansible-playbook 02_nvidia.yml --extra-vars "variable_hosts=hostname"
```
5. Install iotedge dependencies 
```
ansible-playbook 03_iotedge.yml --extra-vars "variable_hosts=hostname"
```
6. Harden target OS and SSH service
```
ansible-playbook 04_hardening.yml --extra-vars "variable_hosts=hostname"
```
7. Install fail2ban
```
ansible-playbook 05_fail2ban.yml --extra-vars "variable_hosts=hostname"
```
8. Mount second partition, NFS drive and other mounts if needed
```
ansible-playbook 06_mounts.yml --extra-vars "variable_hosts=hostname"
```
9. Install etcd cluster for all edge machines
```
ansible-playbook 07_etcd.yml --extra-vars
```

# Working with single barebone

Playbook(s) can be run for single barebone by overriding `variable_hosts` variable by adding extra variables:
```
--extra-vars "variable_hosts=hostname"
```

By omitting this variable ansible playbooks will be run for all hosts

# Authors
Justinas Bedzinkas - IBM (bedzinsk@lt.ibm.com)



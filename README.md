# Introduction 
This project defines scripts for provisioning edge machines using ansible. Ansible works by connecting to target machines via SSH, installs required software and makes necessary configurations

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
2. ```scripts/run_container.sh```

# Adding new users

New users needs be added to:
1. Username and its groups to `includes/users.yml` file.
2. User's public key needs to be places into `includes/keyfiles` folder
3. Username needs to be placed into `includes/user_config/ssh/username` file so that ansible could use it for its playbooks

# Provisioning barebone
1. Add new barebone `includes/user_config/ssh/config` file as **Host** block

2. Add new barebone into `hosts` file **[edgemachines]** section.

3. Create users by running script below. Password needs to be entered twice. First time for SSH login, second for becoming superuser.
```
ansible-playbook 01_users.yml --extra-vars "@includes/default-user.json" -Kk
```
4. Install nvidia drivers
```
ansible-playbook 02_nvidia.yml
```
5. Install iotedge dependencies
```
ansible-playbook 03_iotedge.yml
```
6. Install fail2ban
```
ansible-playbook 04_fail2ban.yml
```
7. Harden target OS and SSH service
```
ansible-playbook 05_hardening.yml
```

# Authors
Justinas Bedzinkas - IBM (bedzinsk@lt.ibm.com)



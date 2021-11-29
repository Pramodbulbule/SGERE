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
| **06_mounts.yml** | Mount NFS and second partition under /mnt |
| **07_etcd.yml** | Install etcd server |
| **08_laser.yml** | Mount DXF folder |
| **09_azure-mounts.yml** | Mount azure storage containers (models, cad, groundtruth, cameraparams, retrain) |
| **10_hosts.yml** | Update hosts files to contain edge machines hostnames |
| **11_window_manager.yml** | Install XFCE windows manager and VNC server |
| **12_pip3.yml** | Install pip |
| **13_ntpd.yml** | Install and configure ntpd server |

# Initial steps

To be able to run playbooks user needs to build *em-provisioning* container locally and run it.
1. ```scripts/build_container.sh```
2. Username needs to be placed into `includes/user_config/ssh/username` file so that ansible could use it for its playbooks
3. ```scripts/run_container.sh```
4. Update ```includes/default-user.json``` to contain superuser name

# Adding new users

New users needs be added to:
1. Username and its groups to `includes/users.yml` file.
2. User's public key needs to be places into `includes/keyfiles` folder

# Provisioning barebones
1. Add new barebone `includes/user_config/ssh/config` file as **Host** block

2. Add new barebone into `hosts` file **[edgemachines]** section.

3. Create users by running script below. Password needs to be entered twice. First time for SSH login, second for becoming superuser.
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 01_users.yml --extra-vars "@includes/default-user.json" -Kk --extra-vars "variable_hosts=hostname"
```
4. Install nvidia drivers
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 02_nvidia.yml --extra-vars "variable_hosts=hostname"
```
5. Install iotedge dependencies 
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 03_iotedge.yml --extra-vars "variable_hosts=hostname"
```
6. Harden target OS and SSH service
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 04_hardening.yml --extra-vars "variable_hosts=hostname"
```
7. Install fail2ban
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 05_fail2ban.yml --extra-vars "variable_hosts=hostname"
```
8. Mount second partition, NFS drive and other mounts if needed
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 06_mounts.yml --extra-vars "variable_hosts=hostname"
```
9. Install etcd cluster for all edge machines
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> -i inventory/<env>/<location>/<etcd-inventory-file> 07_etcd.yml
```
10. Add route to laser terminal and mount necessary shares
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 08_laser.yml --extra-vars "variable_hosts=hostname"
```
11. Add azure blob storage mounts
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 09_azure-mounts.yml --extra-vars "variable_hosts=hostname"
```
12. Add edge machines hostnames into /etc/hosts
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 10_hosts.yml --extra-vars "variable_hosts=hostname"
```
13. Install XFCE and TightVNC server
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 11_window_manager.yml --extra-vars "variable_hosts=hostname"
```
14. Install pip
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 12_pip3.yml --extra-vars "variable_hosts=hostname"
```
13. Install and configure ntpd server
```
ansible-playbook -i inventory/<env>/<location>/<inventory-file> 13_ntpd.yml --extra-vars "variable_hosts=hostname"
```

# Working with single barebone

Playbook(s) can be run for single barebone by overriding `variable_hosts` variable by adding extra variables:
```
--extra-vars "variable_hosts=hostname"
```

By omitting this variable ansible playbooks will be run for all hosts

# Authors
Justinas Bedzinkas - IBM (bedzinsk@lt.ibm.com)
Sushma Kasim Prakash - SGRE (sushma.kasim@siemensgamesa.com)



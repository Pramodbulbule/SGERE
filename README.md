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
| **08_laser.yml** | Add route to laser network, mount DXF folder |
| **09_azure-mounts.yml** | Mount azure storage containers (models, cad, groundtruth, cameraparams, retrain) |
| **10_inference_server.yml** | Install NVIDIA's Triton Inference server as a service |
| **11_hosts.yml** | Update hosts files to contain edge machines hostnames |
| **12_window_manager.yml** | Install XFCE windows manager and VNC server |

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
ansible-playbook 07_etcd.yml
```
10. Add route to laser terminal and mount necessary shares
```
ansible-playbook 08_laser.yml --extra-vars "variable_hosts=hostname"
```
11. Add azure blob storage mounts
```
ansible-playbook 09_azure-mounts.yml --extra-vars "variable_hosts=hostname"
```
12. Install NVIDIA's Triton Inference server as a service
```
ansible-playbook 10_inference_server.yml --extra-vars "variable_hosts=hostname"
```
13. Add edge machines hostnames into /etc/hosts
```
ansible-playbook 11_hosts.yml --extra-vars "variable_hosts=hostname"
```
14. Install XFCE and TightVNC server
```
ansible-playbook 12_window_manager.yml --extra-vars "variable_hosts=hostname"
```

# Open Issues (IMPORTANT)

All configurational changes are preserved after rebooting the system except for route to Prosoft network. After edge machine is rebooted this command needs to be run manually:
```
sudo ip route replace 192.168.209.0/24 via 192.168.8.80 metric 1
```

Switch to netplan network configuration (https://galaxy.ansible.com/mrlesmithjr/netplan) by introducing a separate playbook.

# Working with single barebone

Playbook(s) can be run for single barebone by overriding `variable_hosts` variable by adding extra variables:
```
--extra-vars "variable_hosts=hostname"
```

By omitting this variable ansible playbooks will be run for all hosts

# Authors
Justinas Bedzinkas - IBM (bedzinsk@lt.ibm.com)



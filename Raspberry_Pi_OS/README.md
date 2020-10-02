# Raspberry Pi OS

Here we are providing the playbooks to setup a device running Raspberry Pi OS.
This includes the following:
  - log2ram to extend SD card life
  - Basic tooling (curl, vim, htop, neofetch, netcat)
  - `raspi-config` settings
  - Docker and Docker-Compose intallation
  
Either run the ansible playbooks seperatly or run them all with th e`rpi-all.yml` playbook

**TIP:** You can use the the convenience script in `Utilities/Distribute_SSH_Keys/` to automatically distribute the SSH public key to remote devices.

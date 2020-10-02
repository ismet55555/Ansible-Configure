# Automatic SSH Public Key Distributor

This script automates the distribution of your public SSH key. Once the public SSH key is on the remote system, you don't have to use a manual password to enter that remote system.

## Requirements:
  1. Have sshpass installed (sudo apt install sshpass)
  2. Have a private-public key pair created. If not, use ssh-keygen
  3. Enter the target hosts into the `remote_hosts.txt`
     This file is a list of remote IP addresses or DNS names
     This file should be in the same directory as this bash script
  4. The remote hosts listed in the "remote_hosts.txt" file is up and running
     with the ssh service installed and running.

## To Run This Script:
  1. If needed, give execution rights to this script 
      - `sudo chmod +x distribute_ssh_keys.sh`
  2. Execute the script
      - `./distribute_ssh_keys.sh`

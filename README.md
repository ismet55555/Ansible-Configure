# Ansible System Setup 5000XL
Ansible playbooks and utility scripts to setup different systems.


# Running an Ansible Playbooks
You will find the ansible playbooks in `.yml` files. The following command will run an ansible playbook. This executed using the terminal.

`ansible-playbook <PATH/NAME>.yml`

Examples:
- `ansible-playbook Raspberry_Pi_OS/rpi-all.yml`
- `ansible-playbook Raspberry_Pi_OS/docker.yml --limit cluster-pi-group`
- `ansible-playbook Raspberry_Pi_OS/rpi-config.yml --limit cluster-pi-1`

Some Useful Options:
- `-K` - Ask for privellage escalation (aka sudo)

For more `ansible-playbook` options, checkout the amazing documentation:
https://docs.ansible.com/ansible/2.7/cli/ansible-playbook.html








# Generate Key Pair and Distribute to Remote Devices

To not have to enter a password every time you SSH into a device, you can create a key pair and send the public key to the remote device you are SSH-ing into.

In fact, you probably need to do this for ansible to smoothly operate. 


## Create a Private-Public Key-Pair (if needed)
1. Install OpenSSH locally (if needed)
   - `sudo apt-get install openssh-server` (if needed)
2. Generate the SSH private-public key-pair
    - `ssh-keygen`
    - Enter some name for the key-pair
    - Don't need the password unless you are hosting TOP SECRET space tesla alien information
    - The key-pair will be saved locally in the `~/.ssh` directory



## Distribute the Public Key the Cool Kids Automatic and Scalable Way
This way is much better if you are working with many remote hosts/devices.

1. Go to the `Utilities/Distribute_SSH_Keys` directory
2. In `remote_host_list.txt`, add the remote host/device IP addresses to the list
3. Specify the following in `distribute_ssh_key.sh`
  ```bash
      SSH_PUBLIC_KEY_LOCATION="/home/USERNAME/.ssh/public-key.pub"
      REMOTE_HOST_USERNAME="<YOUR REMOTE HOSTS USERNAME HERE"
      REMOTE_HOST_PASSWORD="<YOUR REMOTE HOSTS PASSWORD HERE"
  ```
4. Give the `distribute_ssh_key.sh` script exectutable permissions
   - This is only done once
   - `sudo chmod +x distribute_ssh_key.sh`

5. Execute the script
   - `./distribute_ssh_key.sh`




## Distribute the Public Key the Reliable Manual Way

This way is probably good enough for one or two remote hosts.

1. Copy the SSH public key to the remote host/device
   - `ssh-copy-id -i <PATH/NAME OF PUBLIC KEY> <HOST IP or DNS NAME>`
   - Example: 
     - `ssh-copy-id -i /home/my-username/.ssh/my-cool-key 192.168.0.50`
2. Check the SSH Connection (Should not have to enter password)
   - `ssh -i <PATH/NAME OF PRIVATE KEY> <REMOTE USERNAME>@<HOST IP or DNS Name>`
   - Example:
     - `ssh -i /home/my-username/.ssh/my-cool-key pi@192.168.0.50`

**SEMI-PRO TIP:** If you are using the keyname `id_rsa` you will not need the `-i` flag with the path to the key

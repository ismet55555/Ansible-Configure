#!/bin/bash

###############################################################################
#               Automatic SSH Public Key Distributor 5000-XL
###############################################################################
#
# This script automates the distribution of your public SSH key
# Once the public SSH key is on the remote system, you don't have to 
# use a manual password to enter that remote system.
#
# Requirements:
#   1. Have sshpass installed (sudo apt install sshpass)
#   2. Have a private-public key pair created. If not, use ssh-keygen
#   3. Enter the target hosts into the "remote_hosts.txt"
#      This file is a list of remote IP addresses or DNS names
#      This file should be in the same directory as this bash script
#   4. The remote hosts listed in the "remote_hosts.txt" file is up and running
#      with the ssh service installed and running.
#
#
# To run this script:
#   1. If needed, give execution rights to this script 
#          sudo chmod +x distribute_ssh_keys.sh
#   2. Execute the script
#          ./distribute_ssh_keys.sh
#
###############################################################################

# Specify the location of the public key
SSH_PUBLIC_KEY_LOCATION="/home/ismet/.ssh/pi-key.pub"

# Specify the remote user and credentials
REMOTE_HOST_USERNAME="pi"
REMOTE_HOST_PASSWORD="clusterpi"

# Specify the remote SSH port (Typically always 22)
REMOTE_SSH_PORT=22

###############################################################################

# Stop and exit if this script fails
set -e

# Review and User Confirmation
echo
echo "Distributing the following public key:"
echo "   $SSH_PUBLIC_KEY_LOCATION"
echo
echo "To the following hosts (remote_host_list.txt):"
for remote_host_ip in `cat remote_host_list.txt`; do
    echo "    - $remote_host_ip"
done

echo
while true; do
    read -p "Do you want to continue and deploy the public key? (Enter y/n)  " yn
    case $yn in
        [Yy]* ) break;;   # Continue with script
        [Nn]* ) exit 1;;  # Return with a failure exit code
        * ) echo "Please answer 'y' or 'n'";;
    esac
done

# Set variables to count failed and successful deployments
successful=0
failed=0
total=0

successful_hosts=()
failed_hosts=()

SSH_ACCESS=0

# Loop through and distribute the public key to each host/device
for remote_host_ip in `cat remote_host_list.txt`; do
    echo
    echo "=================== DEPLOYING KEY TO: $REMOTE_HOST_USERNAME@$remote_host_ip:$REMOTE_SSH_PORT ========================="
    echo
    # Counting the total hosts
    total=$((total + 1))

    # Probe if remote host already has automatic SSH access
    ssh -q -o "BatchMode=yes" $REMOTE_HOST_USERNAME@$remote_host_ip  "echo 2>&1" && SSH_ACCESS=1 || SSH_ACCESS=0

    if [ $SSH_ACCESS == 1 ]
    then
        echo "[$(date)] WARNING: This host already has automatic SSH access using private key: `$SSH_PUBLIC_KEY_LOCATION`."
        successful=$((successful + 1))
        successful_hosts+=("$remote_host_ip")
    else
        echo "[$(date)] Deploying public key to host '$remote_host_ip' ..."
        if sshpass -p $REMOTE_HOST_PASSWORD ssh-copy-id -o StrictHostKeyChecking=no -f -i $SSH_PUBLIC_KEY_LOCATION $REMOTE_HOST_USERNAME@$remote_host_ip -p $REMOTE_SSH_PORT
        then
            echo "Success: I found IP address in file."
            successful=$((successful + 1))
            successful_hosts+=("$remote_host_ip")
        else
            echo "[$(date)] ERROR: Failed to deploy public key to '$remote_host_ip'!" >&2
            failed=$((failed + 1))
            failed_hosts+=("$remote_host_ip")
        fi
    fi
done

# Join the string arrays with a comma (,)
successful_hosts=$(printf ", %s" "${successful_hosts[@]}")~
successful_hosts=${successful_hosts:1}

failed_hosts=$(printf ", %s" "${failed_hosts[@]}")
failed_hosts=${failed_hosts:1}


echo
echo
echo "=============================== SUMMARY ======================================="
echo "Successfull Hosts ($successful/$total): $successful_hosts"
echo "Failed Hosts:     ($failed/$total): $failed_hosts"
echo "==============================================================================="

echo
echo "DONE"
echo

# Exit with no return code (success)
exit 0
#!/bin/bash

CURRENT_DATETIME=$(date)
echo "[$CURRENT_DATETIME] : INFO     : Checking for interent connection"
echo "[$CURRENT_DATETIME] : INFO     : Pinging Google's 8.8.8.8 server ..."
while :
do
	CURRENT_DATETIME=$(date)
	if ping -q -c 1 -W 1 8.8.8.8 > /dev/null
	then
		break
	fi
	echo "[$CURRENT_DATETIME] : CRITICAL : No internet connection found. Checking again 2 seconds ..."
	sleep 2
done
echo "[$CURRENT_DATETIME] : INFO     : Active interent connection detected"

HOSTNAME=$(hostname -I)
echo "[$CURRENT_DATETIME] : INFO     :     Local IP:  $HOSTNAME"
PUBLIC_IP=$(curl -s ifconfig.me)
echo "[$CURRENT_DATETIME] : INFO     :     Public IP: $PUBLIC_IP"

echo


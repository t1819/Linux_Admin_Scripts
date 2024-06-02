#!/bin/bash

# Array of host IP addresses
HOSTS=(
    "Server1_IP"
    "Server2_IP"
)

# Number of ping attempts
COUNT=4

# Loop through each host in the HOSTS array
for myHost in "${HOSTS[@]}"; do
    
    # Ping the host and capture the count of received packets
    count=$(ping -c $COUNT $myHost | grep 'received' | awk -F ',' '{print $2}' | awk '{print $1}')
    
    # Check if the received packet count is zero
    if [ "$count" -eq 0 ]; then
        # If 0 packets received, the host is considered down
        echo "Host: $myHost is down (ping failed) at $(date)" | mail -s "Alert: $myHost IP is not working" example@email.com
    fi
done

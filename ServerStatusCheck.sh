#!/bin/bash

#Server status check using ping command

HOSTS=(
"Server 1 IP"
"Server 2 IP"
)
COUNT=4
for myHost in "${HOSTS[@]}"
do
	count=$(ping -c $COUNT $myHost | grep 'received' | awk -F ','  '{ print $2 }'  |  awk  -F ' '  '{ print $1 }')
	if [ $count -eq 0 ]; then
	# 100% failed
		echo "Host : $myHost is down (ping failed) at $(date)" | mail -s "Alert: $myHost ip is not working"  example@email.com
	fi
done


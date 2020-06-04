#!/bin/bash 

# Requirement: 
#	nagios configured.
# Top server consuming process send to the administrator at the time of server load.
# Please file bugs at github!
# https://github.com/t1819/scripting

ServerIP="IP"
email="Email Address"

service_status=`/usr/lib64/nagios/plugins/check_nrpe -H $ServerIP -c check_load | cut -d '-' -f1`

if [ "$service_status" == "OK " ]
	then
	        echo "Service is running ok"
	fi
if [ "$service_status" == "WARNING " ]
	then
	            /usr/lib64/nagios/plugins/check_nrpe -H $ServerIP -c processes_snapshot> /tmp/demo_`date +%d%m%Y`
	             cat /tmp/demo_`date +%d%m%Y` | mail -s "WARNING- $ServerIP Server running process logs  `date +%d%m%Y_%H`"  $email
	fi
if [ "$service_status" == "CRITICAL " ]
	then
	         /usr/lib64/nagios/plugins/check_nrpe -H $ServerIP -c processes_snapshot> /tmp/demo_`date +%d%m%Y`
	        cat /tmp/demo_`date +%d%m%Y` | mail -s "CRITICLE- $ServerIP Server running process logs `date +%d%m%Y_%H`" $email
	fi

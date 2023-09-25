#!/bin/bash

logs=$(/bin/ls /var/log/)

echo "Logs a serem removidos!"
echo -ne "======================= \n "

for log in $logs
do
	if [[ -f "/var/log/$log" ]]
	then
		if [[ $log =~ [0-9]$ ]]
		then
			echo $log
		#	rm -rf "/var/log/test/$log."*
		fi
		rm -rf "/var/log/$log."*
	fi 
done

#rm -rf "/var/log/$logs."*

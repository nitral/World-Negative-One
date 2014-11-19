#!/bin/bash

clear

echo "Call of Duty 4 Servers Scanner Script started at - $(date)"
echo "------------------------------------------------------------------------------"

while :
do
	echo "Call of Duty 4 Servers Scanner Pass started at - $(date +'%T')"
	
	# If Kernel is Linux, Use ulimit to Increase Allowed Open File Handles Limit to 11224.
	if [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]
	then
		echo "Linux Kernel: Setting Open Files Limit at 11224"
		if sudo sh -c "ulimit -n 11224 && exec java CODServerQueryDemo > ../../tmp/cod_server_list.txt"
		then
			echo "Call of Duty 4 Servers Scanned at - $(date +'%T')"
			echo "IP Addresses of Live Servers dumped."
		else
			echo "Call of Duty 4 Servers Scanner Failed at - $(date +'%T')"
			echo "IP Addresses of Live Servers Could Not Be Dumped."
		fi
	else
		if java CODServerQueryDemo > ../../tmp/cod_server_list.txt
		then
			echo "Call of Duty 4 Servers Scanned at - $(date +'%T')"
			echo "IP Addresses of Live Servers dumped."
		else
			echo "Call of Duty 4 Servers Scanner Failed at - $(date +'%T')"
			echo "IP Addresses of Live Servers Could Not Be Dumped."
		fi
	fi
	
	echo ""
	
	# Prepare COD Severs List File
	echo "				             CALL OF DUTY 4 SERVERS' LIST" > ../../system/scripts/cod_files/cod.txt
	echo "                                                                    Last Updated at - $(date +'%d/%m/%Y %k:%M:%S')" >> ../../system/scripts/cod_files/cod.txt
	echo "" >> ../../system/scripts/cod_files/cod.txt
	echo "Server Name               l                IP                l       Players/Max       l            Map            l         Game Type         l      Password      l" >> ../../system/scripts/cod_files/cod.txt
	if echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> ../../system/scripts/cod_files/cod.txt
	then
	echo "Servers List File Prepared."
	else
	echo "Servers List File Could Not Be Pepared!"
	fi
	
	echo ""
	
	# Append Servers List
	if cat ../../tmp/cod_server_list.txt >> ../../system/scripts/cod_files/cod.txt
	then
	echo "IP Addresses of Live Servers copied."
	else
	echo "IP Addresses of Live Servers Could Not Be Copied!"
	fi

	echo ""
	
	echo "Call of Duty 4 Server Scanner Pass completed at - $(date)"
	
	echo "------------------------------------------------------------------------------"
done

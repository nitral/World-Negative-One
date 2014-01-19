#!/bin/bash

clear

echo "Source Engine Server Scanner Script started at - $(date)"
echo "------------------------------------------------------------------------------"

while :
do
	echo "Source Engine Server Scanner Pass started at - $(date +'%T')"
	
	if java SourceEngineQueryDemo
	then
	echo "Source Engine Servers Scanned at - $(date +'%T')"
	else
	echo "Source Engine Servers Scanner Failed!"
	fi
	
	echo ""
	
	# Prepare Counter Strike 1.6 Severs List File
	echo "				             COUNTER STRIKE 1.6 SERVERS' LIST" > ../../system/scripts/cs_files/cs.txt
	echo "                                                                         Last Updated at - $(date +'%d/%m/%Y %k:%M:%S')" >> ../../system/scripts/cs_files/cs.txt
	echo "" >> ../../system/scripts/cs_files/cs.txt
	echo "Server Name               l                IP                l   Players(Bots)/Max   l            Map            l       Password       l" >> ../../system/scripts/cs_files/cs.txt
	if echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------" >> ../../system/scripts/cs_files/cs.txt
	then
	echo "Counter Strike 1.6 Server List File Prepared."
	else
	echo "Counter Strike 1.6 Server List File Could Not Be Prepared."
	fi
	
	# Prepare Counter Strike : Global Offensive Severs List File
	echo "		        COUNTER STRIKE : Global Offensive SERVERS' LIST" > ../../system/scripts/csgo_files/csgo.txt
	echo "                                                      Last Updated at - $(date +'%d/%m/%Y %k:%M:%S')" >> ../../system/scripts/csgo_files/csgo.txt
	echo "" >> ../../system/scripts/csgo_files/csgo.txt
	echo "Server Name               l                IP                l           Map            l" >> ../../system/scripts/csgo_files/csgo.txt
	if echo "---------------------------------------------------------------------------------------------------" >> ../../system/scripts/csgo_files/csgo.txt
	then
	echo "Counter Strike : Global Offensive Server List File Prepared."
	else
	echo "Counter Strike : Global Offensive Server List File Could Not Be Prepared."
	fi
	
	# Prepare DOTA Severs List File
	echo "		                                   DOTA SERVERS' LIST" > ../../system/scripts/dota_files/dota.txt
	echo "                                                           Last Updated at - $(date +'%d/%m/%Y %k:%M:%S')" >> ../../system/scripts/dota_files/dota.txt
	echo "" >> ../../system/scripts/dota_files/dota.txt
	echo "Server Name               l                IP                l" >> ../../system/scripts/dota_files/dota.txt
	if echo "----------------------------------------------------------------------" >> ../../system/scripts/dota_files/dota.txt
	then
	echo "DOTA Server List File Prepared."
	else
	echo "DOTA Server List File Could Not Be Prepared."
	fi
	
	echo ""
	
	# Append Servers List
	if cat ../../tmp/cs_server_list.txt >> ../../system/scripts/cs_files/cs.txt
	then
	echo "Counter Strike 1.6 Servers List Appended."
	else
	echo "Counter Strike 1.6 Servers List Could Not Be Appended"
	fi
	
	if cat ../../tmp/csgo_server_list.txt >> ../../system/scripts/csgo_files/csgo.txt
	then
	echo "Counter Strike : Global Offensive Servers List Appended."
	else
	echo "Counter Strike : Global Offensive Servers List Could Not Be Appended."
	fi
	
	if cat ../../tmp/dota_server_list.txt >> ../../system/scripts/dota_files/dota.txt
	then
	echo "DOTA Servers List Appended."
	else
	echo "DOTA Servers List Could Not Be Appended."
	fi
	
	echo ""
	
	echo "Source Engine Servers Scanner Pass completed at - $(date)"
	
	echo ""
	
	# Cleaning Up
	if echo -n "" > ../../tmp/cs_server_list.txt
	then
	echo "Counter Strike 1.6 Servers' Temporary File Cleaned Up!"
	else
	echo "Counter Strike 1.6 Servers' Temporary File Could Not Be Cleaned Up!"
	fi
	
	if echo -n "" > ../../tmp/csgo_server_list.txt
	then
	echo "Counter Strike : Global Offensive Servers' Temporary File Cleaned Up!"
	else
	echo "Counter Strike : Global Offensive Servers' Temporary File Could Not Be Cleaned Up!"
	fi
	
	if echo -n "" > ../../tmp/dota_server_list.txt
	then
	echo "DOTA Servers' Temporary File Cleaned Up!"
	else
	echo "DOTA Servers' Temporary File Could Not Be Cleaned Up!"
	fi

	echo "------------------------------------------------------------------------------"
done
#!/bin/bash

clear

echo "Source Engine Server Scanner Script started at - $(date)"
echo "------------------------------------------------------------------------------"

while :
do
	echo "Source Engine Server Scanner Pass started at - $(date +'%T')"
	
	# If Kernel is Linux, Use ulimit to Increase Allowed Open File Handles Limit to 11224.
	if [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]
	then
		echo "Linux Kernel: Setting Open Files Limit at 11224"
		if sudo sh -c "ulimit -n 11224 && exec java SourceEngineQueryDemo"
		then
			echo "Source Engine Servers Scanned at - $(date +'%T')"
		else
			echo "Source Engine Servers Scanner Failed!"
		fi
	else
		if java SourceEngineQueryDemo
		then
			echo "Source Engine Servers Scanned at - $(date +'%T')"
		else
			echo "Source Engine Servers Scanner Failed!"
		fi
	fi

	echo "------------------------------------------------------------------------------"
done

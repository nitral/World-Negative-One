#!/bin/bash

if ! cd ..
then
echo "[$(date)]  User $1 : directory could not be changed to usr." >> "log/folderSizeCheck.log"
fi

echo "[$(date)]  User $1 entered hub's SSH Server." >> "log/UserAccess.log"

while (true) do
	# Get Folder Size of user
	if ! folderSize=$(du -s home/$1 | awk '{print $1}')
	then
	echo "[$(date)]  User $1 : Could not get the  folder size." >> "log/folderSizeCheck.log"
	fi
	
	# Get Allowed User Folder Size
	if ! allowedSize=$( sed -n 1p etc/$1.cfg | cut -d '=' -f 2 )
	then
	echo "[$(date)]  User $1 : could not read the allowed size." >> "log/folderSizeCheck.log"
	fi

	# Test is limit is exceeded and take action
	if test "$folderSize" -gt "$allowedSize"
	then
	# remove last made file
		
		if ! file="$(ls -t home/$1 | head -n 1)"
		then
		echo "[$(date)]  User $1 : could not find the latest file." >> "log/folderSizeCheck.log"
		fi
		
		if ! rm -rf "home/$1/$file"
		then
		echo "[$(date)]  User $1 : could not delete the latest file." >> "log/folderSizeCheck.log"
		fi
		errorFile="home/$1/LIMIT_EXCEEDED_$(date +%s).txt"		
		if ! cp "./etc/errorLog/errorDisplay.txt" "$errorFile"
		then
		echo "[$(date)]  User $1 : could not copy errorDisplay file." >> "log/folderSizeCheck.log"
		fi
		
		echo "Username : $1" >>"$errorFile"	
		echo "LOG ID : exceedsize$(date +%s)$1" >>"$errorFile"
		echo "Folder size : $folderSize KB" >>"$errorFile"	
		echo "Maximum Allowed Size : $allowedSize KB" >>"$errorFile"	
		echo "File Deleted : $file " >>"$errorFile"	
		echo "Date :  $(date +"%A, %d/%m/%y")" >>"$errorFile"	
		echo "Time :  $(date +%r)" >>"$errorFile"	
		echo "For further queries, contact the administrator providing the above details" >>"$errorFile"
	
		exceedLog="log/exceedLog.log"
		echo "Username : $1" >>"$exceedLog"	
		echo "LOG ID : exceedsize$(date +%s)$1" >>"$exceedLog"
		echo "Folder size : $folderSize KB" >>"$exceedLog"	
		echo "Maximum Allowed Size : $allowedSize KB" >>"$exceedLog"	
		echo "File Deleted : $file " >>"$exceedLog"	
		echo "Date :  $(date +"%A, %d/%m/%y")" >>"$exceedLog"	
		echo "Time :  $(date +%r)" >>"$exceedLog"	
		echo "For further queries, contact the admiistrator providing the above details" >>"$exceedLog"
		echo "--------------------------------------------------------------------------------------------------------------------">>"$exceedLog"
	
	fi
	# Wait for 1s for second verification pass.
	sleep 1s
done
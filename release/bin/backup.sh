#!/bin/bash

clear

for sleepCounter in 5 4 3 2 1
do
	echo "                       -----World Negative One-----"
	echo "----------------------------- BACKUP PROCESS -----------------------------"
	echo ""
	echo "Starting Backup Process in $sleepCounter seconds."
	
	sleep 1s
	
	clear
done

clear

echo "                       -----World Negative One-----"
echo "----------------------------- BACKUP PROCESS -----------------------------"
echo ""
echo "                       -----World Negative One-----" >> ./../backup/backup_log.txt
echo "----------------------------- BACKUP PROCESS -----------------------------" >> ./../backup/backup_log.txt
echo "Backup process started at - $(date)"
echo "Backup process started at - $(date)" >> ./../backup/backup_log.txt
echo ""

cd ../tmp

if mkdir "W -1 [$(date +'%d-%m-%Y %k-%M')]"
then
echo "[$(date)] Temporary Backup directory has been made"
echo "[$(date)] Temporary Backup directory has been made" >> ./../backup/backup_log.txt
else 
echo "[$(date)] Temporary Backup Directory could not be made"
echo "[$(date)] Temporary Backup Directory could not be made" >> ./../backup/backup_log.txt
fi

if cd "W -1 [$(date +'%d-%m-%Y %k-%M')]"
then
echo "[$(date)] Temporary Backup directory path changing has been done"
echo "[$(date)] Temporary Backup directory path changing has been done" >> ./../../backup/backup_log.txt
else 
echo "[$(date)] Temporary Backup Directory path could not be changed"
echo "[$(date)] Temporary Backup Directory path could not be changed" >> ./../backup/backup_log.txt
fi

if cp -r "./../../bin" "./"
then
echo "[$(date)] Bin folder has been copied to a temporary folder"
echo "[$(date)] Bin folder was copied successfully to temporary folder"  >> ./../../backup/backup_log.txt
else 
echo "[$(date)] Bin folder has not been copied"
echo "[$(date)] Bin folder has not been copied" >> ./../../backup/backup_log.txt
fi


if cp -r "./../../system" "./"
then
echo "[$(date)] System folder has been copied to a temporary folder"
echo "[$(date)] System folder was copied successfully to temporary folder"  >> ./../../backup/backup_log.txt
else 
echo "[$(date)] System folder has not been copied"
echo "[$(date)] System folder has not been copied" >> ./../../backup/backup_log.txt
fi

if cp -r "./../../www" "./"
then
echo "[$(date)] www folder has been copied to a temporary folder"
echo "[$(date)] www folder was copied successfully to temporary folder"  >> ./../../backup/backup_log.txt
else 
echo "[$(date)] www folder has not been copied"
echo "[$(date)] www folder has not been copied" >> ./../../backup/backup_log.txt
fi

if tar -cf "./../home_backup.tar" --exclude="./../../usr/home" "./../../usr"
then
echo "[$(date)] home_backup.tar created"
echo "[$(date)] home_backup.tar created" >>  ./../../backup/backup_log.txt
else 
echo "[$(date)] home_backup.tar not created"
echo "[$(date)] home_backup.tar not created" >>  ./../../backup/backup_log.txt
fi 

if tar -xf  "./../home_backup.tar" 
then
echo "[$(date)] usr folder excluding home has been copied to a temporary folder"
echo "[$(date)] usr folder excluding home was copied successfully to temporary folder"  >> ./../../backup/backup_log.txt
else 
echo "[$(date)] usr folder excluding home has not been copied"
echo "[$(date)] usr folder excluding home has not been copied" >> ./../../backup/backup_log.txt
fi

echo "[$(date)] Copying home now..."
echo "[$(date)] Copying home now..." >> ./../../backup/backup_log.txt
if (ls "./../../usr/home" > "./../home_list.txt" )
then 
echo "[$(date)] folder list created in tmp"
echo "[$(date)] folder list created in tmp" >> ./../../backup/backup_log.txt
else
echo "[$(date)] folder list not created in tmp"
echo "[$(date)] folder list not created in tmp" >> ./../../backup/backup_log.txt
fi

if cd usr
then
echo "[$(date)] moved to usr"
echo "[$(date)] moved to usr" >> ./../../../backup/backup_log.txt
else
echo "[$(date)] could not move to usr"
echo "[$(date)] could not move to usr" >> ./../../../backup/backup_log.txt
fi

if mkdir home 
then 
echo "[$(date)] home created."
echo "[$(date)] home created." >> ./../../../backup/backup_log.txt
else
echo "[$(date)] home could not be made"
echo "[$(date)] home could not be made" >> ./../../../backup/backup_log.txt
fi

if cd "home"
then
echo "[$(date)] moved to home"
echo "[$(date)] moved to home" >> ./../../../../backup/backup_log.txt
else
echo "[$(date)] could not move to home"
echo "[$(date)] could not move to home" >> ./../../../../backup/backup_log.txt
fi

if cat "./../../../home_list.txt" | xargs mkdir
then
echo "[$(date)] usr home directories made in home"
echo "[$(date)] usr home directories made in home" >> ./../../../../backup/backup_log.txt
echo "[$(date)] home copied successfully"
else
echo "[$(date)] usr home diectories could not be created"
echo "[$(date)] usr home diectories could not be created" >> ./../../../../backup/backup_log.txt
fi

if cd ../../..
then
echo "[$(date)] Moving to temp"
echo "[$(date)] Moving to temp" >> ./../backup/backup_log.txt
else
echo "[$(date)] Could not move to temp"
echo "[$(date)] Could not move to temp" >> ./../backup/backup_log.txt
fi

if tar cf tmp_backup.tar "W -1 [$(date +'%d-%m-%Y %k-%M')]"
then
echo "[$(date)] Backup Archived"
echo "[$(date)] Backup Archived"  >> ./../backup/backup_log.txt
else 
echo "[$(date)] Backup not Archived"
echo "[$(date)] Backup not Archived" >> ./../backup/backup_log.txt
fi

if mv tmp_backup.tar ../backup/"W -1 [$(date +'%d-%m-%Y %k-%M')]".tar
then
echo "[$(date)] Backup File Moved"
echo "[$(date)] Backup File Moved"  >> ./../backup/backup_log.txt
else 
echo "[$(date)] Backup File Moved"
echo "[$(date)] Backup File Moved" >> ./../backup/backup_log.txt
fi

if rm -rf "W -1 [$(date +'%d-%m-%Y %k-%M')]"
then
echo "[$(date)] Temporary Backup Folder Removed"
echo "[$(date)] Temporary Backup Folder Removed"  >> ./../backup/backup_log.txt
else 
echo "[$(date)] Temporary Backup Folder could not be removed"
echo "[$(date)] Temporary Backup Folder could not be removed" >> ./../backup/backup_log.txt
fi

if rm -f "home_backup.tar" 
then
echo "[$(date)] home_backup.tar file Removed"
echo "[$(date)] home_backup.tar file Removed"  >> ./../backup/backup_log.txt
else 
echo "[$(date)] home_backup.tar file could not be removed"
echo "[$(date)] home_backup.tar file could not be removed" >> ./../backup/backup_log.txt
fi

if rm -f "home_list.txt"
then
echo "[$(date)] home_list.txt file Removed"
echo "[$(date)] home_list.txt file Removed"  >> ./../backup/backup_log.txt
else 
echo "[$(date)] home_list.txt file could not removed"
echo "[$(date)] home_list.txt file could not removed" >> ./../backup/backup_log.txt
fi

echo ""
echo "Backup process finished at - $(date)"
echo "Backup process finished at - $(date)" >> ./../backup/backup_log.txt

echo "-----------------------------------------------------" >> ./../backup/backup_log.txt

read -n 1 -s

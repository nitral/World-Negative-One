#!/bin/bash

clear

OLDIFS=$IFS
IFS=","

{
read itemA itemB itemC itemD itemE itemF itemG itemH itemI itemJ itemK itemL itemM itemN itemO itemP itemQ itemR itemS itemT itemU itemV itemW itemX itemY itemZ itemAA itemAB itemAC itemAD itemAE itemAF itemAG itemAH itemAI itemAJ itemAK itemAL itemAM itemAN itemAO 
printf " $itemM\n$itemN \n $itemO \n $itemP \n $itemQ \n $itemR \n $itemS \n $itemT \n $itemU \n $itemV \n $itemZ \n $itemX \n $itemY \n " > ./../../system/scripts/mess_files/lunch.txt
     
} < MessMenuDatabase.txt

IFS=$OLDIFS
read -n 1 -s
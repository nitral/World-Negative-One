#!/bin/bash

clear

OLDIFS=$IFS
IFS=","

{
read itemA itemB itemC itemD itemE itemF itemG itemH itemI itemJ itemK itemL itemM itemN itemO itemP itemQ itemR itemS itemT itemU itemV itemW itemX itemY itemZ itemAA itemAB itemAC itemAD itemAE itemAF itemAG itemAH itemAI itemAJ itemAK itemAL itemAM itemAN itemAO 

printf " $itemC \n $itemD \n $itemE \n  $itemF \n $itemG \n $itemH \n $itemI \n $itemJ \n $itemK \n " > ./../../system/scripts/mess_files/breakfast.txt

       
} < MessMenuDatabase.txt

IFS=$OLDIFS
read -n 1 -s
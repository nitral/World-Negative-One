#!/bin/bash

clear

OLDIFS=$IFS
IFS=","

{
read itemA itemB itemC itemD itemE itemF itemG itemH itemI itemJ itemK itemL itemM itemN itemO itemP itemQ itemR itemS itemT itemU itemV itemW itemX itemY itemZ itemAA itemAB itemAC itemAD itemAE itemAF itemAG itemAH itemAI itemAJ itemAK itemAL itemAM itemAN itemAO 
printf "$itemAC\n$itemAD\n$itemAE\n$itemAF\n$itemAG\n$itemAH\n$itemAI\n$itemAK\n$itemAL\n$itemAJ\n$itemAM\n$itemAN" > ./../../system/scripts/mess_files/dinner.txt

       
} < MessMenuDatabase.txt

IFS=$OLDIFS
read -n 1 -s
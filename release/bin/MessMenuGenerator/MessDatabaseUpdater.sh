#! /bin/bash
{
tail -n +2 "MessMenuDatabase.txt"
} >> ./../../tmp/Temp_File_MessMenuUpdater.txt
cp ./../../tmp/Temp_File_MessMenuUpdater.txt MessMenuDatabase.txt
tail -n +2 "./../../tmp/Temp_File_MessMenuUpdater.txt" > ./../../tmp/Temp_File_MessMenuUpdater.txt
read -n 1 -s

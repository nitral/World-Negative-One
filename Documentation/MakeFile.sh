   echo "----------------MakeFile Starting------------------\n"
inputDir=AsciiDoc
outputDir=..  
tempListOfFiles=tempIndexOfFiles.txt
if cd $inputDir
  then
    echo "[$(date)]::directory successfully changed to Asciidoc\n"
  else
    echo "[$(date)]::ERROR:'Unable to change directory to Asciidoc'\n"
fi
if ls *.asciidoc|sed 's/\.asciidoc//g' > $outputDir/$tempListOfFiles
  then
    echo "[$(date)]::File $tempListOfFiles created successfully\n"
  else
    echo "[$(date)]::ERROR:File $tempListOfFiles was not created\n"
fi
if cd $outputDir
  then
    echo "[$(date)]::Directory changed to World-Negative-One/Documentation\n"
  else
    echo "[$(date)]::ERROR:Could not changed the directory to World-negative-One/Documnetation\n"
fi
for i in `cat $tempListOfFiles`
do
   if asciidoc -o ./$i.html -b html $inputDir/$i.asciidoc
   then
     echo "[$(date)]::$i.html created successfully\n"
   else
     echo "[$(date)]::File $i.html was not created\n"
   fi
done
if rm $tempListOfFiles
  then
    echo "[$(date)]::$tempListOfFiles was deleted successfully\n"
  else
    echo "[$(date)]::ERROR:'$tempListOfFiles' was not deleted"
fi
echo "Process ends X---------------------X\n"
read tmp



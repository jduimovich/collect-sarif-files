# merges src into dest, sarif scans
# this utility is to workaround the single src update needed for Github security scans.

export SRC=$1
export DST=$2 

if [ "$SRC" = "" ]
then
   echo "Missing source sarif destination name" 
   exit 1
else
   echo "Source file is $SRC"
fi
if [ "$DST" = "" ]
then 
   echo "Missing dest sarif name" 
   exit 1
else
   echo "Dest file is $SRC"
fi 

export N=$(jq  ".runs[0].results[0].locations[0].physicalLocation.artifactLocation.uri" $SRC)
N="${N%\"}"
N="${N#\"}"
N=$(echo $N | tr  "/" "-") 
N=$(echo $N | sed "s/yaml/sarif/g")

echo "Merging $SRC into $DST" 
echo "Placing a copy of $SRC into $N"
cp $SRC $N  
if [ -f "$DST" ]; then
    echo "$DST exists, merging $N into it."
    node merge.js $DST $N  
else
    echo "$DST does not exist, setting bootstrap."
    cp $SRC $DST 
fi

 



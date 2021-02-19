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
   echo "Dest file is $DST"
fi 

export SCANNED=$(jq  ".runs[0].results[0].locations[0].physicalLocation.artifactLocation.uri" $SRC)
SCANNED="${SCANNED%\"}"
SCANNED="${SCANNED#\"}"
SCANNED=$(echo $SCANNED | tr  "/" "-") 
COPY_NAME=$(echo $SCANNED | sed "s/yaml/sarif/g")

echo "File scanned is $SCANNED" 
echo "File backup is $COPY_NAME" 
echo "Merging $SRC into $DST"  
cp $SRC $COPY_NAME
if [ -f "$DST" ]; then
    echo "$DST exists, merging $SRC into it."
    node merge.js $DST $SRC
else
    echo "$DST does not exist, setting bootstrap."
    cp $SRC $DST 
fi

 



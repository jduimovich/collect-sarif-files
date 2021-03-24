# merges src into dest, sarif scans
# this utility is to workaround the single src update needed for Github security scans.
# src is the first file
# dest is the second file to merge and will be used as the destination filename

echo $PWD 

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
mv $SRC $COPY_NAME
if [ -f "$DST" ]; then
    echo "$DST exists, merging $COPY_NAME into it."
    node /collect-sarif-files/merge.js  $DST $COPY_NAME
else
    echo "$DST does not exist, setting bootstrap."
    cp $COPY_NAME $DST 
fi 

 



#!/bin/bash
echo " "
echo "This script decompresses zlib packed content from you extracted Android backup!"
echo " "

if [ -e "$1" ]
then
FTYPE=$(file "$1"|sed -e 's/^.*: //' -e 's/ .*$//')
	if [ "${FTYPE^^}" == "ZLIB" ]
	then
		echo "Extracting content from $1..."
		##THE BACKUP FILE IS A GZIPPED FILE, MISSING THE HEADER, SO WE ADD IT
		##AND THEN DECOMPRESS
		printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" |cat - "$1"|gzip -dc > "$1_ext" 2>/dev/null
		echo " "
		echo "Extraction completed! The resulting content can be found"
		echo "in $1_ext."
	else
		echo "Format $FTYPE not supported!"
	fi
else
	if [[ ! -z "$1" ]]
	then
		echo "File $1 not found!"
	else
		echo "Usage: bash extfile.sh filetoextract"
	fi
fi

echo " "

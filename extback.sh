#!/bin/bash
echo " "
echo "This script extracts your Android logical backup taken with ADB."
echo " "

if [ -e "$1" ]
then
        #if [ ! -e "$1"Â ]
        #then
        #       echo "File $1 not found!"
        #else
                if [ -d "$1_extracted" ]
                then
                        echo "Looks like you might have already extracted this backup to:"
                        echo "  $1_extracted"
                        echo "Move or rename the old extracted folder first!"
                else
                        echo "Extracting $1..."
                        mkdir "$1_extracted"
                        cd "$1_extracted"
                        cp ../"$1" .
                        ##THE BACKUP FILE IS A TAR FILE, MISSING THE HEADER, SO WE ADD IT,
                        ##SKIP THE ANDROID'S HEADER AND PIPE TO TAR FOR EXTRACTION
                        ( printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; tail -c +25 "$1" )|tar xvfz - 2>/dev/null
                        echo " "
                        echo "Extraction completed! The resulting content can be found"
                        echo "in $1_extracted folder."
                        rm "$1"
                fi
else
        if [[ ! -z "$1" ]]
        then
                echo "File $1 not found!"
        else
                echo "Usage: bash extback.sh filetoextract"
        fi
fi

echo " "

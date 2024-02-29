#!/bin/bash

if [[ ! $(pip3 show ab-decrypt 2>/dev/null) ]]
then
	echo "Missing ab-decrypt! Install it by issuing: pip3 install ab-decrypt"
	exit
fi

counter=0

echo "-----------------------------------------------------------------------"
if [[ -f "${1}" ]]
then
	if [[ -f "${2}" ]]
	then
		if [[ ! -z "${3}" ]]
		then
			for pwd in $(cat "${2}")
			do
				export AB_DECRYPT_PASSWORD="${pwd}"
				mapfile -t results < <(ab-decrypt "${1}" "${3}" 2>&1)
				if [[ "${#results}" == "0" ]]
				then
					echo
					echo "Found the password for decryption: $pwd"
					echo "  Decrypted: ${1} "
					echo "  To:        ${3}"
					echo "-----------------------------------------------------------------------"
					exit
				fi

				if [[ "${results[((${#results[@]}-1))]}" == 'ValueError: Bad password!' ]]
				then
					((counter++))
					echo  -en "\rTried password count: $counter"
				fi
			done
			echo
			echo "Failed to find the decrypt password!"
		else
			echo "The destination filename for the decrypted file is missing!"
		fi
	elif [[ -z "${2}" ]]
	then
		echo "You forgot to define the list of passwords!"
	else
		echo "The file for passwords was not found: ${2}"
	fi
elif [[ -z "${1}" ]]
then
	echo "Usage: bash ad-decrypt-brute.sh backupfile.adb passwordlist.txt decrypted_backup.adb"
else
	echo "The Android backup file to decrypt was not found: ${1}"
fi

echo "-----------------------------------------------------------------------"

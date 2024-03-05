#!/bin/bash
if [[ ! $(pip3 show ab-decrypt 2>/dev/null) ]]
then
	echo "Missing ab-decrypt! Install it by issuing: pip3 install ab-decrypt"
	exit
fi

counter=0
max_threads=$(($(ulimit -u)/20))

if [[ -z "${4}" ]]
then
	threads=0
else
	threads="${4}"
fi

if [ -n "${threads}" ] && [ "${threads}" -eq "${threads}" ] 2> /dev/null
then
	if [ "${threads}" -lt "${max_threads}" ]
	then
		echo "Using ${threads} \"threads\" for processing"
	else
		echo "Too many threads (>${max_threads}! Defaulting to 10"
		threads=10
	fi
else
	echo "${threads} is not a number!"
	echo "Usage: bash ad-decrypt-brute.sh backupfile.adb passwordlist.txt decrypted_backup.adb number_of_threads"
	exit
fi

decrypt_attempt()
{
	paswd="${1}"
	enc_file="${2}"
	dec_file="${3}"
	export AB_DECRYPT_PASSWORD="${paswd}"
	mapfile -t results < <(ab-decrypt "${enc_file}" "${dec_file}" 2>&1)
	if [[ "${#results}" == "0" ]]
	then
		echo
		echo "Found the password for decryption: $paswd"
		echo "  Decrypted: ${enc_file} "
		echo "  To:        ${dec_file}"
		echo "-----------------------------------------------------------------------"
		exit
	fi
}

echo "-----------------------------------------------------------------------"
if [[ -f "${1}" ]]
then
	encrypted_file="${1}"
	if [[ -f "${2}" ]]
	then
		passwords_list="${2}"
		if [[ ! -z "${3}" ]]
		then
			decrypted_file="${3}"
			threads_amount="${4}"
			for paswd in $(cat "${passwords_list}")
			do
				#Make sure to stay inside the boundaries
				((i=i%threads)); ((i++==0)) && wait
				decrypt_attempt "${paswd}" "${encrypted_file}" "${decrypted_file}" &
				((counter++))
				echo  -en "\rTried password count: $counter"
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
	echo "Usage: bash ad-decrypt-brute.sh backupfile.adb passwordlist.txt decrypted_backup.adb number_of_threads"
else
	echo "The Android backup file to decrypt was not found: ${1}"
fi

echo "-----------------------------------------------------------------------"

#!/bin/bash
echo
echo -e "\e[93mA quick script to disable a known screen lock password from an android device."
echo
echo -e "\e[97mUsage:\e[93m 	bash unlocker.sh lock_code"
echo "	Able to remove following locktypes: password, pin, pattern"
echo "	code: numeric if pin or pattern, alphanumeric and special characters, if password"
echo "	The minimum length of each is 4"
echo
echo "A pattern code is defined by selecting all the numbers in the order of your pattern."
echo -e "\e[97m		1 - 2 - 3"
echo "		| X | X |"
echo "		4 - 5 - 6"
echo "		| X | X |"
echo "		7 - 8 - 9"
echo -e "\e[93mSo if your pattern is swiped from 1 -> 3 -> 7 -> 9, you enter 1235789 as your code.\e[39m"
echo
PASW="$1"
DEVICE=$(adb devices|grep -o ^.*$'\t'|sed 's/\t//')
if [[ "$DEVICE" ]]
then
	echo
        echo -e "\e[92mDevice \e[93m$DEVICE \e[39mfound!"
	echo
	if [[ $(adb shell locksettings verify 2>/dev/null) ]]
	then
		echo -e "\e[92mThe device has no lock code, it's already unlocked!\e[39m"
	elif [[ $(echo "$PASW"|grep -Eo ".{4,}") ]]
	then
		if [[ $(adb shell locksettings verify --old "$PASW"|grep -o "^Lock") ]]
		then
			adb shell locksettings clear --old "$PASW" 2>&1>/dev/null
			echo -e "\e[92mScreen lock code cleared successfully!\e[39m"
		else
			echo -e "\e[91mIncorrect lock code!\e[39m"
		fi
	else
		echo -e "\e[91mThe provided lock code doesn't meen the minimum required length of 4!\e[39m"
	fi
	echo
fi

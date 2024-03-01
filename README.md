# android_forensics
My random scripts to help with Android forensics

<b>ab-brute-decrypt.sh</b>:<br>
Try bruteforcing encrypted ADB backup against a wordlist, not really multi-threadded but multi-process driven if needed:
bash ad-brute-decrypt.sh encrypted_backupfile.adb wordlist.txt decrypted_backupfile.adb number_of_threads


<b>checker.sh</b>:<br>
Checker gathers all kinds of information from the device and also creates the logical ADB backup. Still pretty much a test.


<b>extback.sh</b>:<br>
This script extracts your Android logical backup taken with ADB.


<b>extfile.sh</b>:<br>
This script decompresses zlib packed content from you extracted Android backup.


<b>lockremove.sh</b>:<br>
A quick script to remove a known password/pin/patter screen lock of an android device. 
ONLY FOR KNOWN PASSWORDS! THIS DOES NOT ENABLE YOU TO REMOVE THE SCREEN LOCK IF YOU DON'T ALREADY KNOW THE PASSWORD!


<b>zlibber.py</b>:<br>
Decompress zlib packed files, like 000000_sms_backup. Usage: python3 zlibber.py 000000_sms_backup

# android_forensics
My random scripts to help with Android forensics

<b>ab-brute-decrypt.sh</b>:<br>
Try bruteforcing encrypted ADB backup against a wordlist.

<b>checker.sh</b>:<br>
Checker gathers all kinds of information from the device and also creates the logical ADB backup. Still pretty much a test.

<b>extback.sh</b>:<br>
This script extracts your Android logical backup taken with ADB.


<b>extfile.sh</b>:<br>
This script decompresses zlib packed content from you extracted Android backup.


<b>lockremove.sh</b>:<br>
A quick script to remove a known password/pin/patter screen lock of an android device. 
ONLY FOR KNOWN PASSWORDS! THIS DOES NOT ENABLE YOU TO REMOVE THE SCREEN LOCK IF YOU DON'T ALREADY KNOW THE PASSWORD!

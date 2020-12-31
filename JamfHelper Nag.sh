#!/bin/bash
#Cody Sweeny
#12/30/2020
#Jamf Helper Nag - Useful for OS Updates via policy.

UserDir="/Users/User/Public"
RESULT=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
-windowType "utility" \
-lockHUD \
-title "macOS Catalina Update" \
-heading "We need to do some updates" \
-description "Your Mac is in need of a mandatory update. Please select update now to update and restart your Mac" \
-icon "$UserDir/brandingimage.png" \
-iconSize 120 \
-button1 "Update Now" \
-defaultButton 1 \
-button2 "Cancel" \
-alignCountdown "right"`


if [ $RESULT == 0 ]; then
    echo "Update was pressed!"
    sleep 5
ThankYou=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
-windowType "utility" \
-lockHUD \
-title "Thank you" \
-heading "Updating your computer" \
-description "Your Mac will restart shortly" \
-icon "$UserDir/brandingimage.png" \
-iconSize 120 \
-button1 "Okay" \
-defaultButton 1 \
-alignCountdown "right"`
sudo jamf policy -trigger InstallCached
elif [ $RESULT == 2 ]; then
    # do button2 stuff
    echo "Cancel was pressed!"

fi
exit 0

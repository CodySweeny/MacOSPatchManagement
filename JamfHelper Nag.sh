#!/bin/bash
#Cody Sweeny
#12/31/2020
#Jamf Helper Nag - Useful for OS Updates via policy.


#Use this variable in Jamf to say true or false. Self Service mode true, bypasses deferral countdown.
SelfServiceMode="$4"

#Checks for PKG Files.
ls /Library/Application\ Support/JAMF/Waiting\ Room/ | grep ".pkg" > /dev/null
if [ "$?" == "0" ]; then
echo "PKG files exists."
else
	if [ $SelfServiceMode == "True" ]; then
		AvailableUpdates=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
		-windowType "utility" \
		-lockHUD \
		-title "No Updates Available" \
		-heading "macOS Update" \
		-description "No updates are currently available for your machine. Check back later" \
		-icon "/Users/User/Public/brandingimage.png" \
		-iconSize 120 \
		-button1 "Okay" \
		-defaultButton 1 \
		-alignCountdown "right"`
		echo "SelfServiceMode was set to true, prompting user that no updates are available."
		exit 1
	else
		echo "No updates available. Self Service mode is set to false"
	fi
fi





if [ $SelfServiceMode == "True" ]; then
SelfServiceTrue=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
-windowType "utility" \
-lockHUD \
-title "macOS Update Required" \
-heading "We need to do some updates" \
-description "An update to macOS has been downloaded to your machine and will be applied after a rebooot. Please save all open work and selct Update Now when you are ready to restart your Mac." \
-icon "/Users/User/Public/brandingimage.png" \
-iconSize 120 \
-button1 "Update Now" \
-defaultButton 1 \
-button2 "Cancel" \
-alignCountdown "right"`
	if [ $SelfServiceTrue == 0 ]; then
	    echo "Update was pressed!"
	    sleep 3
		ThankYou=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
		-windowType "utility" \
		-lockHUD \
		-title "Thank you" \
		-heading "macOS Update Intiated" \
		-description "Your Mac will automatically restart in just a moment" \
		-icon "/Users/User/Public/brandingimage.png" \
		-iconSize 120 \
		-button1 "Okay" \
		-defaultButton 1 \
		-alignCountdown "right"`
		#sudo jamf policy -trigger InstallCached
			elif [ $SelfServiceTrue == 2 ]; then
			    echo "Cancel was pressed!"
			fi
else

##Deferral Plist Location
deferralPlist="/library/Preferences/com.Defer.deferralCount.plist"

## This is the default number of deferrals we want to start with. Adjust this value as needed
defaultDeferrals="$5"

## Here we check for the existence of the plist. If it's there, capture how many deferrals remain
if [ -e "$deferralPlist" ]; then
    deferralsRemaining=$(defaults read "$deferralPlist" deferralsLeft)
else
    ## If no plist is present, use our default amount to start with
    deferralsRemaining="$defaultDeferrals"
fi


if [ "$deferralsRemaining" -gt 0 ]; then
RESULT=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
-windowType "utility" \
-lockHUD \
-title "macOS Update Required" \
-heading "We need to do some updates" \
-description "An update to macOS has been downloaded to your machine and will be applied after a rebooot. Please save all open work and selct Update Now when you are ready to restart your Mac." \
-icon "/Users/User/Public/brandingimage.png" \
-iconSize 120 \
-button1 "Update Now" \
-defaultButton 1 \
-button2 "Defer" \
-alignCountdown "right"`

	if [ $RESULT == 0 ]; then
	    echo "Update was pressed!"
	    sleep 3
	ThankYou=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
	-windowType "utility" \
	-lockHUD \
	-title "Thank you" \
	-heading "macOS Update Intiated" \
	-description "Your Mac will automatically restart in just a moment" \
	-icon "/Users/User/Public/brandingimage.png" \
	-iconSize 120 \
	-button1 "Okay" \
	-defaultButton 1 \
	-alignCountdown "right"`
	#sudo jamf policy -trigger InstallCached
	elif [ $RESULT == 2 ]; then
	    # do button2 stuff
	    echo "Defer was pressed!"
	            newDeferralsLeft=$((deferralsRemaining-1))
	        defaults write "$deferralPlist" deferralsLeft -int $newDeferralsLeft
	DeferMessage=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
	-windowType "utility" \
	-lockHUD \
	-title "macOS Update" \
	-heading "Next reminder is in two days" \
	-description "You have $deferralsRemaining deferrals remaining" \
	-icon "/Users/User/Public/brandingimage.png" \
	-iconSize 120 \
	-button1 "Okay" \
	-defaultButton 1 \
	-alignCountdown "right"`
	fi
else
		NoDefer=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
	-windowType "utility" \
	-lockHUD \
	-title "macOS Update Required" \
	-heading "Deferral limit has been reached" \
	-description "An update to macOS has been downloaded to your machine and will be applied after a reboot. Please save all open work and select Update Now when you are ready to restart your Mac." \
	-icon "/Users/User/Public/brandingimage.png" \
	-iconSize 120 \
	-button1 "Update Now" \
	-defaultButton 1 \
	-alignCountdown "right"`
		if [ $NoDefer == 0 ]; then
	    echo "Update was pressed!"
	    sleep 3
	    #sudo jamf policy -trigger InstallCached
		fi

	ThankYou=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
	-windowType "utility" \
	-lockHUD \
	-title "Thank you" \
	-heading "macOS Update Intiated" \
	-description "Your Mac will automatically restart in just a moment" \
	-icon "/Users/User/Public/brandingimage.png" \
	-iconSize 120 \
	-button1 "Okay" \
	-defaultButton 1 \
	-alignCountdown "right"`
	fi
fi
exit 0

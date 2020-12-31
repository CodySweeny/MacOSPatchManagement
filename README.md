CONTENTS OF THIS FILE
---------------------

 * Introduction
 * Requirements
 * Configuration
 * Troubleshooting
 * FAQ
 
 <H1>Introduction</H1>
Most Jamf admins would agree that there is some frustration surround utilizing Jamf's patch management for MacOS updates. This is an alternative that leverages a similar concept in a cleaner way without any additional utilities or downloads.
 
<H1>Requirements</h1>
1. Jamf Pro Instance
2. A Mac or Mac VM for testing
3. A location on the Mac to save company branding.

<H1>Configuration</H1>
You will need at minimum, 1 smart group, 2 policies and any packages from Apple that you would like to deploy.

<h3>Packages</h3>
Upload any package to your Jamf Pro instance. This same methodology can also be useful for required applications. I also upload a basic branding package that contains a company logo.

<H3>Smart Groups</H3>
Create a smart group with the target operating system build number. 

<H3>Policies</H3>
We will need 3 policies. The first will archive or cache the package, the second will alert the user via JamfHelper, and the third will install.

<h4>Cache Package</h4>
The naming of the policies can be whatever you would prefer. Keep it logical and making sense.

<h4>JamfHelper Nag</h4>
This policy will contain the script that will prompt the user for updates.

<h4>Install Cached Package</h4>
Installation of all cached packages.

<h4>Logical Approaches to Policy Creation</h4>
  1. The first policy should be set to cache. Ideally this will be ran when the user first turns on their Mac. This is scoped to the target update group.<br>
  2. JamfHelper can be used in a variety of different ways. The options are endless and admitedly my approach is rudimentary at the moment. <br>
  3. I am working on a better approach to scoping with this methodology so that multiple nag policies would not have to be created. Possibly a smart group containing all approved updates. Once the machine falls out of that group, it will no longer receive the MWF (Monday, Wednesday, Friday) nag to update until the next update is approved and in which case the machine would fall back in that group. Work in progress. 
  
<h1>Troubleshooting</H1>
This section is coming soon.


<H1>FAQ</H1>
-What is Jamf?<br>
https://www.jamf.com/

-What is jamfHelper?<br>
https://www.modtitan.com/2016/10/demystifying-jamfhelper.html

-Can this integrate with any other MDM solution?<br>
Not at this time. This project utilizes a tool called jamfHelper to notify the end user. The same concept could function within Intune, Munki or any other MDM but you'll need a way to inform the user.

Who gets the credit for this?<br>
Not me! That's for sure! I have yet to find an implementation guide on this suject so I figured I would write my own. The idea originally comes froma JNUC 2020 session by William Smith called Planning your Patch Management Strategy. I would encourage anyone interested in the subject to watch the video. I have yet to find a decent guide on this idea and so I decided to write my own (also as a way of storing the scripts used and because I'm a forgetful person at heart).

Please check out this video: https://youtu.be/RRoIHHiY9pQ<br>
TalkingMoose Github: https://github.com/talkingmoose<br>
JNUC2020: https://www.jamf.com/events/jamf-nation-user-conference/2020/sessions/

CONTENTS OF THIS FILE
---------------------

 * Introduction
 * Requirements
 * Configuration
 * Troubleshooting
 * FAQ
 
 <H1>Introduction</H1>
 Jamf's patch management solution is wildly lacking in the area of maintaining Mac OS supplemental updates. As Jamfhelper is engaged in the native patch management, it can be utilized in a far better way by utilizing policies and smart groups to achieve your update cycle. 
 
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
  1. The first policy should be set to cache. Ideally this will be ran when the user first turns on their Mac. This is scoped to the target update group.
  2. JamfHelper can be used in a variety of different ways. The options are endless and admitedly my approach is rudimentary at the moment. 
  3. I am working on a better approach to scoping with this methodology so that multiple nag policies would not have to be created. Possibly a smart group containing all approved updates. Once the machine falls out of that group, it will no longer receive the MWF (Monday, Wednesday, Friday) nag to update until the next update is approved and in which case the machine would fall back in that group. Work in progress. 
  
<h1>Troubleshooting</H1>
**Work in Progress**
Doublecheck your scoping and sytax of JamfHelper script.

FAQ
-What is Jamf?
https://www.jamf.com/

-What is jamfHelper?
https://www.modtitan.com/2016/10/demystifying-jamfhelper.html

-Can this integrate with any other MDM solution?
Not at this time. This project utilizes a tool called jamfHelper to notify the end user. The same concept could function within Intune, Munki or any other MDM but you'll need a way to inform the user.

Who gets the credit for this?
Not me! That's for sure! I have yet to find an implementation guide on this suject so I figured I would write my own. The idea originally comes froma JNUC 2020 session by William Smith called Planning your Patch Management Strategy.

Please check out this video: https://youtu.be/RRoIHHiY9pQ
TalkingMoose Github: https://github.com/talkingmoose

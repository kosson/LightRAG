---
title: "Customizing Android Tablets for a Shared Environment"
source: "https://journal.code4lib.org/articles/9482"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-04-17
created: 2025-01-10
description: "The Valley Library at Oregon State University Libraries & Press supports access to technology by lending laptops and e-readers. As a newcomer to tablet lending, The Valley Library chose to implement its service using Google Nexus tablets and an open source custom firmware solution, CyanogenMod, a free, community-built Android distribution. They created a custom build [...]"
tags:
  - "clippings"
---
# Customizing Android Tablets for a Shared Environment
Jane Nichols, Ryan Ordway

The Valley Library at Oregon State University Libraries & Press supports access to technology by lending laptops and e-readers. As a newcomer to tablet lending, The Valley Library chose to implement its service using Google Nexus tablets and an open source custom firmware solution, CyanogenMod, a free, community-built Android distribution. They created a custom build of CyanogenMod featuring wireless updates, website shortcuts, and the ability to quickly and easily wipe devices between patron uses. This article shares code that simplifies Android tablet maintenance and addresses Android application licensing issues for shared devices.

## Introduction

Many academic libraries offer students and faculty access to popular and current technology by lending laptops, e-readers and tablets. The Valley Library at Oregon State University Libraries & Press supports this type of access by lending laptops and e-readers. However, The Valley Library is a newcomer to tablet lending. While the literature on tablet lending in higher education focuses almost exclusively on iPad lending programs ([Anderson and Weatherbee 2012](https://journal.code4lib.org/articles/#Anderson); [Buzzard and Teetor 2011](https://journal.code4lib.org/articles/#Buzzard); [Capdarest-Arest 2013](https://journal.code4lib.org/articles/#Capdarest); [Massis 2013](https://journal.code4lib.org/articles/#Massis); [Obst 2010](https://journal.code4lib.org/articles/#Obst); [Thompson 2011](https://journal.code4lib.org/articles/#Thomson)), we chose Google’s Nexus 7 tablets primarily due to the significant cost savings (at least $100 less than any Apple iPad); we later added Nexus 10 tablets to the service. The dearth of literature on Android device lending programs in academic libraries meant developing some processes from the ground up. This article fills a gap in the tablet lending literature by addressing the lending of Nexus 7/Nexus 10 Android tablets, by sharing code to simplify their maintenance, and by discussing how we resolved licensing hurdles encountered with Android applications (apps) on shared devices.

## Coding for Lending

A significant benefit to choosing the Nexus tablet is its open source Android operating system because we can customize various aspects of the operating system to meet lending needs. We chose CyanogenMod ([http://www.cyanogenmod.org/](http://www.cyanogenmod.org/)) (CM) as the replacement Android-based operating system for the Nexus tablets. CM is a community-supported modification (mod) of the freely available Android Open Source Project code ([https://source.android.com/](https://source.android.com/)). The most important consideration for us was CM’s solution for two issues related to resetting the tablets between patrons. Using CM lets us reset the tablets without losing any build customizations; it also allows resetting without having to connect tablets to a computer hosting the stock Android backup and restore software (a requirement of the factory Android operating system). In addition, with CM we can deploy a wireless update system simplifying individual device updates so Circulation, rather than IT staff, can easily install them. Each of these solutions is addressed in more detail below.

### Tablet reset

We decided early on to give patrons full privileges to download and install apps and other personal information such as photos onto the Nexus tablets. This would give patrons the most authentic user experience, but it also meant that between circulations the tablets would need to be reset in order to preserve patron privacy and clear all patron data such as credit card information for app or in-app purchases and login details stored in the main device memory. The reset would also need to clear any changes that patrons had made such as downloaded apps, reorganized home screen icons, and photos taken and stored on the tablet’s SD memory card.

The default factory reset process for the Nexus tablets required tethering each tablet to a computer on which the backup and restore software was downloaded. This placed limits on how many tablets Circulation staff could restore at the same time due to limited USB port availability. Testing revealed that the factory backup and restore process did not restore system preferences like current language or Wi-Fi settings, requiring manual reconfiguration from Circulation or IT staff; it also did not remove any other user data like Google or social media account information. Furthermore, the factory restore did not clear personal data (e.g. photos) from the tablet’s SD memory card; clearing this memory required separate steps from the factory reset. Finally, the backup and restore process restored the tablets to factory settings, which was not ideal. The build we envisioned would include custom website shortcut icons such as OSU Libraries, Library2Go (Oregon’s statewide public library implementation of Overdrive’s e-book service), and an online patron survey along with additional apps not included in the factory build. Using CM we could “bake” these customizations into the operating system, creating a unique Valley Library build which is not lost when tablets are reset.

To simplify the full reset we modified the device recovery program to wipe data from both the main and SD storage and to restore the custom build. Using Android’s Device Administration API we coded a new custom app called TabletNuke to trigger and complete the full reset process from the tablet itself. We added this custom app to The Valley Library build just like other third party apps. The full TabletNuke code is available on GitHub ([https://github.com/osulp/TabletNuke](https://github.com/osulp/TabletNuke)), and the specific section of the app code that triggers the factory reset is provided below.

| 1  2  3  4  5  6  7  8  9  10  11 | `case` `R.id.button_reset_device:`  `if` `(!isActive) {`  `Toast.makeText(``this``, ``"Reset failed, please enable DeviceAdmin."``, Toast.LENGTH_LONG).show();`  `Log.d(TAG, ``"Tried to reset without toggling admin policy"``);`  `return``;`  `}`  `Toast.makeText(``this``, ``"Factory resetting device..."``, Toast.LENGTH_LONG).show();`  `Log.d(TAG, ``"resetting device now - system will be restored to factory settings"``);`  `devicePolicyManager.wipeData(ACTIVATION_REQUEST);`  `break``;` |
| --- | --- |

Circulation staff begin the simple reset process by using a home screen icon named Wipe Data to access the TabletNuke app. Upon enabling the Device Admin setting, they are able to complete the reset process by pressing the big, red button shown in Figure 1. Because the Wipe Data icon is visible on the home screen, it is possible patrons will reset the tablets. While we do not expect that many will launch TabletNuke (via the Wipe Data icon), we make no attempt to restrict access since patrons would only erase their own personal data.

![](https://journal.code4lib.org/media/issue24/nichols/redbutton.png)

**Figure 1.** TabletNuke’s big red reset button

### Tablet build updates

We make ongoing changes to the tablet build as needed or requested. To avoid removing each tablet from circulation to upgrade to the newest build, we developed a way to wirelessly push build updates to each device. This was accomplished by utilizing GetCM ([http://get.cm](http://get.cm/)) which stores CM update packages and provides a web interface for interacting with them. We customized GetCM to run locally on a library server and modified the CMUpdater app that is integrated into CM to query our local instance of GetCM. Now when Circulation staff open the tablet Settings and look for updates, the most recent version of our custom build is served up by the local instance of GetCM. The patch below modifies the URL that the CMUpdater app uses to find the local GetCM instance.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14 | `project packages/apps/CMUpdater/`  `diff --git a/res/values/config.xml b/res/values/config.xml`  `index fbb3a43..39edde9 ``100644`  `--- a/res/values/config.xml`  `+++ b/res/values/config.xml`  `@@ -``8``,``7` `+``8``,``7` `@@`  `-->`  `<resources xmlns:xliff=``"urn:oasis:names:tc:xliff:document:1.2"``>`  `<!-- CMUpdate Config Strings -->`  `-    <string name=``"conf_update_server_url_def"` `translatable=``"false"``>http:`  `+    <string name=``"conf_update_server_url_def"` `translatable=``"false"``>http:`  `<string name=``"conf_changelog_url"` `translatable=``"false"``>http:`  `<bool name=``"alternateIsInternal"``>``false``</bool>`  `</resources>` |
| --- | --- |

### The Valley Library Custom Build

Along with the stock apps for both productivity and entertainment on the Nexus tablet, The Valley Library customized build includes website shortcut icons on the tablet home screen and additional pre-installed apps. Other academic libraries with tablet lending programs have also enhanced their stock build by adding apps and website shortcut icons ([Capdarest-Arest 2013](https://journal.code4lib.org/articles/#Capdarest); [Massis 2013](https://journal.code4lib.org/articles/#Massis); [Obst 2010](https://journal.code4lib.org/articles/#Obst); [Thompson 2011](https://journal.code4lib.org/articles/#Thomson)). The decision to add website shortcut icons for destinations like the library website, a library-created tablet guide, the local public library e-book service, and a short patron survey was straightforward as they give quick access to library services.

Choosing which apps to pre-install was a more complex decision. The factory build already provided basic functionality for reading e-books, playing videos, and browsing the web. As the tablets were intended to give patrons (e.g. students) a way to experiment with, learn about, and try out tablet technology, we rationalized that part of that learning experience was personalizing the technology by investigating and downloading apps that met specific needs. Others share this perspective ([Capdarest-Arest 2013](https://journal.code4lib.org/articles/#Capdarest); [Massis 2013](https://journal.code4lib.org/articles/#Massis); [Thompson 2011](https://journal.code4lib.org/articles/#Thomson)), and we moved forward with the optimistic perception that patrons would feel comfortable personalizing the devices, just as they do with their personal mobile technology. Even though some patrons added apps to meet their specific needs, our optimism may have been a bit misplaced based on consistent requests to pre-install a variety of apps.

Even though we modified the custom build multiple times to add requested apps, there are reasons to limit the number of pre-loaded apps. Reasons center on device and server storage space as well as our evolving understanding of app licensing and app store terms of service. The storage issue was easy to resolve, but the licensing was not, as discussed later.

One concern about storage was the amount of server resources needed to create the tablet build. The growing number of library-selected apps in the build required that we move the build system to a new server with more RAM and update the build scripts to allow them to use up to 8GB of RAM instead of 2GB. The build system cryptographically signs all of the apps included in the build at once, which requires increasing amounts of RAM as the number of apps increases.

Another issue has been the amount of storage space available on the tablets, in particular in the `/system` partition. Because the same build is loaded onto both the Nexus 7 and 10, storage space on the smaller tablet is the limiting factor. Currently only 12% of the Nexus 7 `/system` partition is free for new app storage, necessitating a very selective approach for adding any new apps. We may soon also need to re-evaluate the suite of currently available pre-loaded apps \[[1](https://journal.code4lib.org/articles/#note1)\].

## Navigating Licensing

Tablets, and the apps created for them, were designed for individual consumer use rather than for the shared environment that libraries offer. As we explored which apps to include in the build and whether to get the apps from Nexus’ partner app store, Google Play, or a third party provider like Amazon AppStore, SlideMe or CyanogenMod, we discovered that Terms of Service (TOS) agreements differ among app providers regarding app use for sharing services. We learned that when using digital content on Google Play, the TOS prohibit the use of Google ‘products’, which include apps, as part of a sharing or lending service ([Google 2013](https://journal.code4lib.org/articles/#Google)). It should be noted that the TOS does not extend to the Android operating system itself. This Google Play TOS restriction prevented us from including their apps, like Gmail and Google Drive, in our custom build. Instead, we used third party apps which had no TOS lending restriction. However, over the year patron feedback showed that users did not use generic apps like Email (email client) and Browser (Android web browser), which provide functionality equivalent to Google’s apps. They wanted Google products like Gmail and Google Drive pre-installed. Such patron requests meant looking at possible ways to obtain Google apps without going against Google Play’s TOS.

Historically Google apps were part of CM. However, this changed after Google sent CM a cease and desist letter in 2009, forcing them to stop bundling the apps ([Kondik 2013](https://journal.code4lib.org/articles/#Kondik)). Google followed up with a blog post clarifying that while the Android operating system source code is open source, the apps it has developed for use on the Android platform are not open source, and, therefore, not included in the Android source code repository ([Morrill 2009](https://journal.code4lib.org/articles/#Morrill)).

In fall 2013 we began extracting the Google apps “gapps” packages from the factory build (they are included for device recovery purposes) and folding them into the custom build. Because we are not pulling apps from the Google Play Store, distributing the apps for download, or posting our build images for download by others, we feel we have successfully navigated Google Play licensing restrictions, essentially taking the licensing issue out of the picture, while still making Google apps available for our users.

## Lending Details

We launched the tablet lending service with thirteen Google Nexus 7 tablets. The Nexus 7’s initially circulated for one week. In response to patron interest, fourteen Nexus 10s with keyboards were purchased to circulate in fall 2013. The Nexus 7 loan length was changed to six hours, and the Nexus 10 was set to one week. Our thinking was that patrons would use the Nexus 7 for short bursts of activity and to fill time in their schedule whereas the Nexus 10s with keyboards would be used for more purposeful, productivity-related activities.

The tablets have had reasonable use. The Nexus 7s averaged 7.8 circulations per week during the first 6 months; this increased to just over 15 circulations per week after the loan length was changed. The Nexus 10s circulate 9 times per week on average. See Table 1 for circulation totals and loan periods.

**Table 1:** Loan Lengths and Circulations

|  | Nexus 7 | Nexus 7 | Nexus 10 |
| --- | --- | --- | --- |
| Time Period | 2/2013-8/2013 | 9/1/2013-3/7/2014 | 9/1/2013-3/7/2014 |
| Loan Period | 1 Week Circ | 6 Hour Circ | 1 Week Circ |
| Number of Circs | 235 | 413 | 249 |

## Evaluating Tablet Lending

As we hoped, students used the tablets for academic purposes. For example, student feedback revealed that they did their course readings (59%), research or an assignment for a course (58%), or worked on written assignments (28%). In addition to academics, students checked email for classes, campus activity or work and unsurprisingly, used them for entertainment purposes (37%), such as playing games or watching videos.

Feedback also showed that when students tried to read articles in PDF they ran into problems. The tablets have a PDF reader, Aldiko, but students seemed to not recognize that this can be used to display their course readings rendered in PDF; they may not know how to launch Aldiko, or they may simply prefer to use the more familiar Adobe Acrobat Reader. To address this issue we decided to install the Acrobat Reader app. As we could not download this app from Google Play due to the licensing restriction noted earlier, we contacted Adobe directly for permission to use the Acrobat Reader app in our tablet build. This permission was granted upon the completion of a distribution agreement and the Reader will be added to a forthcoming updated build.

## Discussion

By offering Nexus 7 and Nexus 10 tablets for checkout, we expanded device offerings beyond laptops and e-readers, equipped patrons with technology they might not otherwise have had access to, and contributed to patron skill development. Evaluation data show that students use tablets for both entertainment and academic needs and that they would like tablets to be pre-loaded with apps needed to accomplish productivity tasks. Because of the device storage space limitations noted earlier, libraries will want to consider how much space to devote to pre-loaded apps and how much to leave for patron downloads.

Libraries interested in this approach to Android tablet lending will want to weigh the amount and type of programming support needed. Programming included time to develop the custom build while learning; the programmer spent approximately 10% of his time on this project over three months creating the build, and continues to spend about 5% of his time updating the build. He already knew Linux and used that knowledge to customize CM. It should also be noted that using an open source model fits with The Valley Library’s preference for supporting and implementing open source solutions.

Another approach to look at is using mobile device management software like Cisco’s free Meraki system manager. We tried Meraki with our tablets but learned they would have to be re-registered after each reset, an impractical step. We are planning a meeting with Meraki to further explore how it could address our needs.

Even with our custom solutions in place, it is good to remember that tablets were created for individual consumers. As Goodwin, quoting Hasic, says, “When you get frustrated with how the iPads work in a shared environment, remember that you are shoe horning a device that’s designed for a single user into a shared” setting ([Hasic, 2011, p. 8 as quoted in Goodwin 2012](https://journal.code4lib.org/articles/#Goodwin)). Fortunately the CM version of the Android OS enabled us to “shoe horn” the Nexus tablet into a successful lending program.

## Conclusion

This initial foray into tablet lending has, on the whole, been positive. It is a well-used service that helped us fill a technology gap and gives the OSU community an opportunity to build their skills with tablets. By adding the Nexus tablets to our suite of devices, our patrons have access to a wider range of contemporary technology. Libraries looking for an affordable way to lend tablets may take advantage of and build off of the provided code to implement a similar service.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] [http://guides.library.oregonstate.edu/content.php?pid=478508&sid=3919989](http://guides.library.oregonstate.edu/content.php?pid=478508&sid=3919989)

## References

Anderson S, Weatherbee S. 2012. Growing a technology equipment service in an academic library. Comput Lib \[Internet\]. \[cited 2013 Dec 10\]; 32(6):6-8. Available from: [http://www.infotoday.com/cilmag/jul12/Anderson-Weatherbee–Growing-a-Technology-Equipment-Service-in-an-Academic-Library.shtml](http://www.infotoday.com/cilmag/jul12/Anderson-Weatherbee--Growing-a-Technology-Equipment-Service-in-an-Academic-Library.shtml) [**Back**](https://journal.code4lib.org/articles/#Andersoncite)

Buzzard P, Teetor T. 2011. Best practices for a university laptop lending program. Code4Lib \[Internet\]. \[cited 2014 Mar 14\]; (15). Available from: [http://journal.code4lib.org/articles/5876](https://journal.code4lib.org/articles/5876)

Capdarest-Arest, NA. 2013. Implementing a tablet circulation program on a shoestring. JAMA \[Internet\]. \[cited 2013 Dec 16\]; 101(3):220-224. Available from: [http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3738084/pdf/mlab-101-03-220.pdf](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3738084/pdf/mlab-101-03-220.pdf)

Goodwin K. 2012. Use of tablet technology in the classroom \[Internet\]. \[cited 2014 Jan 28\]. Strathfield NSW, Australia: State of New South Wales, Department of Education and Communities. Available from: [http://www.tale.edu.au/tale/live/teachers/shared/next\_practice/iPad\_Evaluation\_Sydney\_Region.pdf](http://www.tale.edu.au/tale/live/teachers/shared/next_practice/iPad_Evaluation_Sydney_Region.pdf) [**Back**](https://journal.code4lib.org/articles/#Goodwincite)

Google Play Terms of Service \[Internet\]. \[updated 2013 Nov 20\]. Mountain View (CA): Google, Inc. \[cited 2013 Nov 20\]. Available from: [https://play.google.com/intl/en-US\_us/about/play-terms.html](https://play.google.com/intl/en-US_us/about/play-terms.html) [**Back**](https://journal.code4lib.org/articles/#Googlecite)

Kondik, S. 2013 Sep 18. A New Chapter \[Blog post\]. CyanogenMod: Blog \[Internet\]. \[cited 2014 Feb 8\]. Available from: [http://www.cyanogenmod.org/blog/a\_new\_chapter](http://www.cyanogenmod.org/blog/a_new_chapter) [**Back**](https://journal.code4lib.org/articles/#Kondikcite)

Massis BE. 2013. From iPads to fishing rods: checking out library materials. New Lib World \[Internet\]. \[cited 2013 Nov 7\]; 114(1/2):80-83. Available from: [http://www.emeraldinsight.com/journals.htm?issn=0307-4803&volume=114&issue=1/2&articleid=17073238&show=html](http://www.emeraldinsight.com/journals.htm?issn=0307-4803&volume=114&issue=1/2&articleid=17073238&show=html) doi:[10.1108/03074801311291983](http://dx.doi.org/10.1108/03074801311291983)

Morrill D. 2009 Sep 25. A Note on Google Apps for Android \[Blog post\]. Android Developers Blog \[Internet\]. \[cited 2014 Feb 8\]. Available from: [http://android-developers.blogspot.com/2009/09/note-on-google-apps-for-android.html](http://android-developers.blogspot.com/2009/09/note-on-google-apps-for-android.html) [**Back**](https://journal.code4lib.org/articles/#Morrillcite)

Obst O. 2010. iPad lending project: first results. J Eur Assoc Health Inf Lib \[Internet\]. \[cited 2013 Nov 7\]; 6(4):39-41. Available from: [http://jeahil.wordpress.com/2010/10/14/ipad-lending-project-first-results/](http://jeahil.wordpress.com/2010/10/14/ipad-lending-project-first-results/)

Thompson SQ. 2011. Setting up a library iPad program: Guidelines for success. Coll Res Lib News \[Internet\]. \[cited 2013 Jun 14\]; 72(4):212-236. Available from: [http://crln.acrl.org/content/72/4/212.short](http://crln.acrl.org/content/72/4/212.short)

## About the Authors

Jane Nichols is Collection Development Librarian at O.S.U. Libraries and Press.

Uta Hussong-Christian is Instruction and Science Librarian at O.S.U. Libraries and Press.

Ryan Ordway is Unix Systems Administrator at O.S.U. Libraries and Press.
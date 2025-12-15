---
title: "SPECIAL REPORT: Creating Conference Video"
source: "https://journal.code4lib.org/articles/555"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-12-15
created: 2025-01-10
description: "Capturing video at a conference is easy. Doing it so the product is useful is another matter. Many subtle problems come into play so that video and audio obtained can be used to create a final product. This article discusses what the author learned in the two years of shooting and editing video for Code4Lib [...]"
tags:
  - "clippings"
---
# SPECIAL REPORT: Creating Conference Video
Noel F. Peden

Capturing video at a conference is easy. Doing it so the product is useful is another matter. Many subtle problems come into play so that video and audio obtained can be used to create a final product. This article discusses what the author learned in the two years of shooting and editing video for Code4Lib conference.

## Introduction

Capturing video at a conference is easy. Doing it so the product is useful is another matter. Many subtle problems come into play so that video and audio obtained can be used to create a final product. In this paper I discuss the things learned in the two years of shooting and editing video for the Code4Lib conference.

## History

In 2006, the first year we did video we captured the talks and the projection screen with no previous planning. The keynote speaker, Karen Schneider, had brought a video camera to record her own speech. Dan Scott had brought a camera as well. In typical Code4Lib fashion, the video taping spontaneously continued after the keynote for the remainder of the conference, through volunteers. For a last minute save, this worked pretty well. Several problems surfaced, both during and after the conference:

- **Insufficient tapes**: We were not prepared with enough tapes, so all of the video had to be imported onto a laptop at the end of each day. Since we were not prepared with software, we resorted to Windows Movie Maker and the WMV format. This had later implications.
- **One camera**: With only one camera, we lost content while switching tapes if the speaker was not willing to wait. Timing these switches is fairly easy, but it is easy to forget, especially if you are listening to the talks.
- **No microphone**: We were not tied into the PA system, so the audio was weak (particularly for soft speakers). The video camera mic was omnidirectional, so typing and other conversations were in the background, or worse.
- **No slides**: The camera was usually focused on the speaker, but if the projection screen was essential, the camera was focused on it. Inevitably, some key slides were missed, and there were some weak transitions. Since the projection screen was only occasionally visible, there was no way to embed actual slides during editing.
- **WMV format**: Due to the WMV capture format, I used Windows Movie Maker for editing. This worked well enough as we had no fancy editing to do, other than adjusting final audio levels and adding titles and credits. Output was limited to WMV or avi, however. So, for a final output of mp4, the movie was output in avi and converted to mp4 using QuickTime Pro. This was done manually, and took quite some time. Scripting could have been done, as I later found out.
- **Posting**: Ryan Eby did most of the work posting the mp4 files to Google video and linking it into code4lib.org. A year later, I ran all avi files through Adobe Premier Elements to create MPEG2 versions, which I then uploaded to archive.org.

For the second year of the conference, I really wanted a picture-in-picture arrangement, where the presenter desktop fills the screen and the presenter appears in the lower right corner. After searching for software, I decided upon WireCast 3, which allowed captures from multiple sources to disk, and live compositing for picture-in-picture and other transitions. With Jeremy Frumkin’s help, Oregon State University paid for the WireCast license. Since WireCast stored video on disc we would not need to remember to change tapes. WireCast supported a remote desktop capture over the network; desktops could be captured for clear pictures of slides or demos on both Windows and Mac machines. Using two cameras, we could still capture the desktop for those with Linux. Finally, we could tie into the PA system for direct audio as well.

This plan required quite a bit of equipment, however. For this time around we used:

- **PowerMac tower, monitor, keyboard, mouse, UPS, power strip, cables** (since two cameras meant two firewire ports, a desktop machine was required)
- **Two video cameras, two tripods, firewire cables, lots of tapes** (MiniDV, my own, and many contributed by Dan Scott)
- **Errata: 20+foot audio cable, Ethernet hub & cables, dongles, two extra laptops, Mac & Windows, a nice big Rubbermaid tote**

I drove all this equipment to Portland in February, stored it in my room at night, and set it up each morning. The hotel provided a table for me near the front, which I placed so cameras on either side could be pointed at the speaker and projection screen. The hotel tech also provided me a mono input from their PA system. Here are the problems that arose:

- **Network and Desktop Capture**: The network was completely unreliable for connecting remote desktops. In fact, of all attempts, it worked only once. Hotel networks have not been up to our demanding use of bandwidth as a group. I would not ever plan on this again. Even if the network was reliable, it was not reasonable to expect every presenter to install this software, particularly for short 5 minute presentations.
- **Set up time**: I got locked out of my room on the first morning. Allow for plenty of setup time. Preferably do a test run the day before, not the morning of the event.
- **Recording audio for questions**: I was not prepared to record questions. I relied at first on the camera microphones, then on a mic on a stand which people would seldom come to, and then on a portable mic carried by Ed Corrado. It is nearly impossible to record audio for questions without a portable mic, and someone to carry it around. However, if a camera is recording, it will have some audio as well, and this can be coaxed with some computational amplification and noise removal into passable audio.
- **Software**: WireCast had some quirks:
- **Audio**: The program would not remember audio settings. Each time I started the program I had to change audio to the mic input, and turn off the camera audio on each camera input. This resulted in the loss of several minutes of audio for our main keynote when WireCast crashed and, upon restart, I did not realize the audio was not being captured.
- **Cameras**: WireCast did not do well with a camera’s entering sleep mode. Occasionally it would crash, which led to a reset of audio settings. A few times this left us without any video or audio. Most cameras have a recording or capture mode that does not enter sleep. One camera we used had to be set to be photo mode where it acted like a web cam. Record mode will usually go to sleep if the camera is paused for any extended period of time.
- **Transitions**: In WireCast, multiple camera views could be configured to zoom in on certain areas and position themselves in areas of the screen. I tried to use this to zoom into detailed slides to make things readable. It was not really possible to tell when a speaker was going to change slides, however. Usually I ended up zooming in the transition to the next slide. In editing, nearly all of these attempts turned into problems and had to be fixed. The only consistent transition was bringing the speaker to full view during questions.

- **Editing**: When editing finally came around, several more things became apparent:
- **File format**: WireCast output in a QuickTime format. This ostensibly should have been easy to load into iMovie or the like. It turned out no version of iMovie I could find, even on a new machine, could load the captured video. I ended up buying a license to Adobe Premier Elements and doing all video editing on a PC. Though it was occasionally unstable, this worked well and I was very pleased with the program. The process of finding something that would work took a large amount of time.
- **Tape backup**: Not having a backup recording on tape was a real drawback. Partway through the conference I realized this and I started recording when I could. This saved our bacon on a few recordings that crashed. It would have been helpful for the ten minutes of lost audio from our main keynote.
- **Transitions**: As mentioned above, most live transitions did not come at expected times with unrehearsed talks. When recreating slides by inserting their static images in the video, these transitions only created trouble spots that had to be finessed. For example, suppose the slide has not changed for a long time, and you transition to the speaker so they fill the screen. The speaker moves on to the next slide, and before you can catch it, they move on again. You have no recording of the missed slide. Now you are faced with inserting the slide and transitioning the speaker video out and in around it.
- **Audio volume**: Any steps to improve audio will help. However, nothing will change speakers moving back and forth, or turning away to the screen. As a result, one has to go through each video from beginning to end to make audio levels consistent and clear.
- **Audio channels**: Due to the nature of the hotel PA system, we had audio only on the left channel of a stereo recording. With any passable video editor this can be fixed, but it adds one more item that must be remembered for every video, and so it will be forgotten at least a few times.
- **Lightning talk information**: Lightning talks are informal 5 minute talks given in bunches of 10 to 20. They are informally organized during the conference. Many of the presenters are not used to presenting. It is best to do the simplest recording possible here, with no attempt at transitions, and to record to tape as well. It is of utmost necessity that someone record titles, presenters, and content while these presentations are happening. It is almost impossible to find the information later.

- **Uploading**: Google video turned out to be more trouble than it was worth. After uploading several gigabytes worth of video, none of it appeared, with no explanation for the failures. I could not tell if it failed due to the format, the encoding, the size, or some other issue. In the end we chose a QuickTime format that was smaller, and Ryan Eby battled with the uploads until they were recognized. Format is not an easy issue, as there are so many.

## Lessons Learned

Looking forward, these are my recommendations for the third year:

- **Divide and conquer**: Do not have one person do this. Ryan Eby helped with posting in both 2006  and 2007, but I easily spent over 120 hours capturing, solving problems, and editing. Editing will always be the lion’s share. However, things could be divided as follows:
- **Capture**: One person uses WireCast and does all the capture during the conference.
- **Editing**: One person receives all the raw footage on a hard drive and does all the editing.
- **Uploading**: One or more persons uploads these files to archive.org and/or google video, entering all the metadata.
- **Code4Lib.org**: One person links all files into the Code4Lib.org website.

- **Use three cameras**: Since a recording camera usually goes to sleep a short while after it reaches the end of a tape, and a sleeping camera crashes WireCast, use a third camera to record to tape (a second person could do this.) Use two cameras for WireCast; one to capture the projection screen, and one to capture the presenter. The tape recordings provide the means to recover material that is lost or unusable through capture.
- **Transitions**: Only do one transition for all presentations. Start with the slides and the presenter in the lower right, and end with the presenter only for questions, if there are any. Anything else should be done during the editing phase where tape footage and slides can be used.
- **Wireless mic for questions**: Plan from the beginning for one person to walk around with a wireless mic. People will still start talking without it, but as long as one video camera is recording, its omni directional mic will provide something.
- **Release agreements**: Have these ready so presenters can fill them out before or after they speak. We completely forgot this the second year. Thankfully the people involved with Code4Lib are quite nice, and will tell us to take down any of their material they don’t want posted.
- **Obtain slides during the conference by any means, including begging**: Although it takes more time to overlay slides into the video, the end product is incomparable. But it is difficult to chase these down afterwards. What can be obtained during the conference should be saved. Announce the need at the beginning of the conference, and assign and name one person to save the files. Presenters can give the files to them before or after their presentation. They should probably have a few flash drives handy.
- **Be prepared to record lightning talk information**: Information on informal talks is very hard to reconstruct later. You can’t get it all from the video.
- **Editing software**: Good editing software will cover a multitude of mistakes. Adobe Premier Elements worked very well for me, after I learned its tricks. It has many of the features of Premier Pro, without being too complicated.
- **Export format**: We found a smaller format, such as QuickTime, worked best for Google Video. Archive.org suggests MPEG2 format with MP3 audio. Premier elements supports this format, though mono MP3 audio must be specified. These are large files, being roughly 1Gb for a 20 minute presentation. Archive.org accepted and converted these just fine.
- **Uploading**: I found the Google Video Uploader buggy. Hopefully it will be better next year. On Archive.org, do not use the Creative Commons Publisher Tool for the large MPEG2 files. Use the direct ftp route for files over 100Mb. When the CC tool fails, which happened fairly often, it leaves you with a metadata mess to clean up. The ftp route separates the ftp upload from the metadata creation.

## Conclusion

First, plan ahead. Be sure you know what the hotel provides, and what equipment you need to bring. Always provide enough time for set up, and test ahead so you are not in a last minute rush. For a successful output (and a sane editor), quality raw footage is a requirement. While capture software will provide much of that footage, raw camera recordings and slide files are indispensable. With some planning, division of labor, and the right software and equipment, the conference can be preserved and enjoyed by many. Both those who are not able to attend and those who did will revisit the content, in some cases many times.

Since the conference this year, many have expressed thanks at the work done. I do not have exact numbers, but even videos that have merely been placed on archive.org, and not linked anywhere else, have been downloaded 20 to 50 times. If the information you are recording is important to preserve and make available to others who could not attend, the effort is worth it.

## Resources:

- Adobe Elements Premier: [http://www.adobe.com/products/premiereel/](http://www.adobe.com/products/premiereel/)
- Vara Software WireCast: [http://varasoftware.com/products/wirecast/](http://varasoftware.com/products/wirecast/)
- Code4Lib Conference Videos on archive.org: [http://www.archive.org/search.php?query=code4lib](http://www.archive.org/search.php?query=code4lib)

## About the Author

Noel Peden , has worked at Pierce Library at EOU for several years, creating web applications and managing data. He graduated with a Physics degree in 1997 from EOU.

Author email: noel@peden.biz

Author url: [http://www.peden.biz](http://www.peden.biz/)
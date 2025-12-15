---
title: "Review of DigitalSignage.com"
source: "https://journal.code4lib.org/articles/9407"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-04-17
created: 2025-01-10
description: "Digital signage has been used in the commercial sector for decades. As display and networking technologies become more advanced and less expensive, it is surprisingly easy to implement a digital signage program at a minimal cost. In the fall of 2011, the University of Florida (UF), Health Sciences Center Library (HSCL) initiated the use of [...]"
tags:
  - "clippings"
---
# Review of DigitalSignage.com
Clifford Richmond, Matthew Daley

Digital signage has been used in the commercial sector for decades. As display and networking technologies become more advanced and less expensive, it is surprisingly easy to implement a digital signage program at a minimal cost. In the fall of 2011, the University of Florida (UF), Health Sciences Center Library (HSCL) initiated the use of digital signage inside and outside its Gainesville, Florida facility. This article details UF HSCL’s use and evaluation of DigitalSignage.com signage software to organize and display its digital content.

## Introduction

Digital signage has been used in the commercial sector for decades for the purposes of entertainment, advertising products and services, and displaying information such as menus, flights and messages. As display and networking technologies become more advanced and less expensive, the ability to experiment with digital signage is now easier than ever. The University of Florida, Health Sciences Center Libraries has been using DigitalSignage.com signage software for over two years in its Gainesville, Florida facility. This article examines some of the processes involved in using DigitalSignage.com signage software to create a digital signage campaign, and examines the software’s strengths and weaknesses.

## Project Goals

There were many goals in mind when the Health Science Center Library (HSCL) decided to test the use of digital signage in its Gainesville, Florida facility. Digital signage was anticipated to be a more efficient and effective alternative to the conventional practice of taping or tacking hard copy material to walls and bulletin boards. By reducing hard copies as a means of communicating library information and services to local patrons, the library hoped to reduce wear and tear on walls, increase the aesthetic appeal of library space and reduce paper costs and the paper waste stream. By virtue of the digital nature of the content, where movement from source to display takes place via a computer network, the library anticipated a reduction in the time required to create, post, review and remove content.

## Criteria and Considerations

Budget: Although a budget cap was not established for this project, cost was by far the single biggest consideration in determining digital signage software and hardware options. It was determined from the outset that the library would use existing hardware.

Networking: For the purposes of updating, patching and network accessibility, it was preferred that any workstations involved in digital signage be able to function when joined to the UF Active Directory (AD) [\[1\]](https://journal.code4lib.org/articles/#note1) domain.

Content Flexibility: The HSCL desired the ability to display various types of still, motion and sound content.

## Existing Digital Signage at UF

The HSCL investigative efforts concentrated on speed of initial implementation rather than an exhaustive evaluation of current efforts at the university. Of the five digital signage implementations researched, the HSCL focused on the two programs that were located in the Health Science Center (HSC). The HSCL believed that these two projects would provide a close representation of the specific vetting process and timelines to expect. Of the two projects currently in place in the HSC, one involved an initial cost of $15,000 and the other one used free software (DigitalSignage.com) and existing equipment.

## Digital Signage Solution

In addition to the fact that the software is free, the number of content types that can be displayed and the flexibility of control over the visual layout were the reasons DigitalSignage.com software was chosen for this project.

In order to start using the software, the user must create a free account at www.digitalsignage.com. After creation of an account, the user may use web versions of the software or download desktop versions. The HSCL chose to use the desktop versions, Signage Studio and Signage Player. Content is first organized using the Signage Studio Adobe AIR application. Then signage player devices are configured to play an existing campaign of content using the Signage Player Adobe AIR application. Adobe AIR is required to be installed on any computer that is used to organize content and on any device that will coordinate the display of content. The free edition uses a cloud-based [\[2\]](https://journal.code4lib.org/articles/#note2) approach to content storage, with a limit of 1 GB of storage per account. However, it is not a requirement that content be uploaded to the cloud in order to be displayed on the signage players.

In order to organize digital presentations, www.digitalsignage.com defines the following terms and concepts:

**Resource:** A fundamental unit of digital content, such as a .png, .jpg, .mov, or .ppt file.

**Components:** Prebuilt flash-based widgets that allow the inclusion of such items as text and media RSS feeds, video, webpages, stock tickers, clocks, video capture inputs and charts in a timeline. The user can typically modify both the data source, as well as the visual elements of these widgets using different skins [\[3\]](https://journal.code4lib.org/articles/#note3).

**Screens (Outputs):** Screens are created to characterize the content and layout that a specific signage player will display. A digital signage campaign may use more than one screen.

**Screen Divisions:** The subdivision of a logical digital display screen into different areas. These areas may represent subdivisions in both X (horizontal) and Y (vertical) space, or Z space (representing multiple layers).

**Channels:** The term and concept used to represent, in the timeline, what content is associated with each screen subdivision.

**Timeline:** A chronological configuration of components, scenes and resources. The Media RSS Feed timeline appears in the top portion of Figure 3. As time increases from left to right, the content indicated plays in the different channels.

**Sequencer:** The timing mechanism used to display content whereby timelines play in an infinite loop.

**Scheduler:** The timing mechanism used to display content whereby timelines are set to play at specific dates or times.

**Scenes:** Scenes are saved user instances of one or more widget components. The same scene can be used in multiple timelines and multiple campaigns.

**Campaign:** A single configuration that includes a collection of timelines, resources, screen divisions, components or scenes. Each signage player device is associated with only one campaign at a time.

## Signage Studio

The general workflow in Signage Studio is:

Upload content (resource) > Create a Campaign targeting a screen (output) > Create a timeline

Figure 1 shows the information supplied to the campaign creation wizard to create the VPHA campaign. The VPHA campaign targets the screen output named “VPHA Monitor,” with a resolution of 1920×1080. The default “Sequence” mode will be used so that timelines will loop after completion. Only the campaign and output information are required for this step.

![Figure 1: VPHA Campaign and Screen Settings](https://journal.code4lib.org/media/issue24/richmond/1.png)

**Figure 1.**  
VPHA Campaign and Screen Settings

Next, using the timeline wizard, the user must supply a name, duration and screen layout to be used. Figure 2 shows the timeline details supplied for The Media RSS Feed timeline.

![Figure 2: Media RSS Feed Timeline Settings](https://journal.code4lib.org/media/issue24/richmond/2.png)

**Figure 2.**  
Media RSS Feed Timeline Settings

The (previously created) screen division template divides the 1920 x 1080 screen into five (5) areas. These areas were designed to display the day, time, date, a multimedia RSS feed and a separate text RSS feed. The newly created timeline is aware that the designated screen layout provides for five different channels of content. Examination of Figure 3 reveals that the five content channels (outlined in red) will play in the correspondingly named screen divisions (indicated by the arrows) and will play for five minutes and then repeat.

![Figure 3: Screen Divisions, Channels and Content Relationship in the Media RSS Feed Timeline](https://journal.code4lib.org/media/issue24/richmond/3.png)

**Figure 3.**  
Screen Divisions, Channels and Content Relationship in the Media RSS Feed Timeline

## Signage Player

In order to play the Media RSS Feed Timeline, the Signage Player AIR application must be installed on a device with a display. The HSCL uses large screen displays connected to workstations running Windows 7. During the installation, the user assigns a name to the signage player device and designates the screen (output) and content campaign to run, as indicated in Figure 4. After clicking the “Next >>” button, the user can start running the campaign by clicking the “Start” button (Figure 5).

![Figure 4: The Signage Player Name, Content Campaign and Screen (Output) Must Be Designated](https://journal.code4lib.org/media/issue24/richmond/4.png)

**Figure 4.**  
The Signage Player Name, Content Campaign and Screen (Output) Must Be Designated

![Figure 5: The User Clicks the Start Button to Run the Designated Campaign Content](https://journal.code4lib.org/media/issue24/richmond/5.png)

**Figure 5.** The User Clicks the Start Button to Run the Designated Campaign Content

During the Signage Player installation, the file “signagecontroller.exe” is copied to the startup folder for all users. Upon subsequent logins, the Signage Player software will automatically start and begin downloading content to a local cache directory. An Internet connection is required for the initial caching of content to the local signage player hard drive from the cloud. After the current campaign’s content has been cached, an Internet connection is only necessary when content organization has changed, or if the content includes web pages from the Internet. After content has been modified in Signage Studio, the signage player software can be restarted from within Signage Studio.

## Hardware Configuration

The hardware used for digital signage configuration inside the library is detailed below. The specific equipment used is included for informational purposes, and is not an endorsement of a particular model or manufacturer. The displays located outside the library could not be directly connected to a computer, therefore, the video and audio signals were transmitted over Cat5 network cable.

### Hardware Configuration Inside The Library

**Computer:**

- Dell OptiPlex 990, Windows 7 32-bit
- Software: Signage Player, Adobe AIR, PowerPoint viewer, VLC Player
- RAM: 4 GB
- CPU: Intel® Core ™ i7-2600 CPU @ 3.40 GHz/3.40 GHz
- Graphics Card: ATI Radeon HD 3400 Series
- Video Port: Dell Display Port
- NIC: Intel® 82579LM Gigabit Network Connection
- Sound Card: Onboard Realtek ALC269 High Definition (HD) Audio Device
- External Speakers: Logicitech 2.1 (Stereo with separate Subwoofer)

**Display:**

- Make/Model: Samsung (LED) Model UN55ES6900
- Viewable Area: 55”
- Resolution: 1920 x 1080p through PC Input or HDMI
- Video Input: DVI, VGA and HDMI inputs are available
- Audio Input: 3.5 mm stereo TRS Connector
- Speakers: Built-in stereo

**Video Signal:** Computer Display Port-to-DVI adapter > DVI-to-HDMI Cable > HDMI input of Monitor

## Workstation and Active Directory Modifications

In order to allow the workstations to recover from a reboot and start playing content without any human interaction, the following modifications were necessary:

1- An AD user account was created for the purpose of logging into the signage player workstations.  
2- The “Interactive logon: Do not require CTRL+ALT+DEL” policy was “Enabled” using a Group Policy Object (GPO). This setting is located under:  
Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options.  
3- Automatic login (AutoAdminLogin) was enabled in the registry, and the above user account credentials supplied. These settings are shown in Figure 6. In Windows 7, these registry settings are located under: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogin

![Figure 6](https://journal.code4lib.org/media/issue24/richmond/6.png)

**Figure 6.**  
Automatic login (AutoAdminLogin) Registry Settings

4- In order to automatically start the Signage Player software when (only) the above user logs in, the “signagecontroller.exe” file was moved from the “all users” startup directory to the above user’s startup folder. In Windows 7, a user’s startup folder is located at: C:\\Users\\Username\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\Startup

## The Results

Figure 7 shows the Media RSS Feed timeline of the VPHA campaign.

![Figure 7](https://journal.code4lib.org/media/issue24/richmond/7.png)

**Figure 7.**  
Media RSS Feed Timeline As Appears On Signage Monitor

Figure 8 shows a Weather Timeline which uses a custom skinned weather component (widget). The screen layout consists of a full-screen background layer (clouds) with the weather widget in the foreground.

![Figure 8](https://journal.code4lib.org/media/issue24/richmond/8.png)

**Figure 8.**  
Weather Timeline as Appears on Monitor

Figure 9 is a still photo of a full-screen .mp4 animation produced in Adobe After Effects. Signage Studio was instructed to use an external player (VLC Player) located on the signage player computer to play the file, which was also located on the local signage player computer’s hard drive.

![Figure 9](https://journal.code4lib.org/media/issue24/richmond/10.png)

**Figure 9.**  
Still Image of Harry Potter Exhibit After Effects Animation

## Conclusions

DigitalSignage.com Pros: The software is free. With the ability to use external players, there is no limit to the type of content one can display. The free edition grants access to hundreds of shared resources, samples and scenes. There are (software) signage players available that allow content display on Android, Windows and Mac devices, iPads, and from inside a browser. A nearly infinite number of X, Y and Z screen layout configurations is possible. The software supports a logical screen resolution of 4096 x 4096, so one computer with a multi-video display port can coordinate content on several display devices. Conversely, one could combine several physical displays to create a video wall. Technical help response by email, telephone and online chat has been immediate. The web site has many instructional videos for learning the various aspects of the software, and the videos are clear and concise.

DigitalSignage.com Cons: The free version does not support the assignment of roles and permissions, which would allow for segmentation of duties in an enterprise environment. The free version does not provide access to the API [\[4\]](https://journal.code4lib.org/articles/#note4) and SDK [\[5\]](https://journal.code4lib.org/articles/#note5). Consequently, one cannot activate an emergency notification timeline (for example) based on a trigger event outside the software.

Overall Assessment: The HSCL is very satisfied with the DigitalSignage.com software. All project goals have been realized. The elimination of a hard-copy phase for campaigns has reduced the use of paper, toner, spray adhesive and foam board, reduced the wear on printers and reduced the staff time required to print, cut, mount and transport poster-sized displays. The time required to upload content, insert it into a timeline and deliver to the signage player displays routinely takes five minutes. The information to square-feet of display area has been greatly increased. The number of individual pieces of content posted on each of the three (current) displays varies over time, but at this writing thirty-eight (38) different timelines are in rotation, each comprised of one or more pieces of content. The library has also received positive feedback from students, faculty and staff.

## Reference and Notes

[\[1\]](https://journal.code4lib.org/articles/#ref1). Although Active Directory is a term used to refer specifically to the type of directory service used by Microsoft Corporation, the term is widely used by IT professionals to refer more generally to a/the Microsoft networking framework.

[\[2\]](https://journal.code4lib.org/articles/#ref2). ‘Cloud based’ is the practice of storing regularly used computer data on multiple servers that can be accessed through the Internet.  
Merriam-Webster.com. Cloud Computing \[Internet\]. Merriam-Webster.com; \[2014 Feb , cited 2014 Feb 05\]. Available from: http://www.merriam-webster.com/dictionary/cloud%20computing

[\[3\]](https://journal.code4lib.org/articles/#ref3). In computing, a skin is a custom graphical appearance achieved by the use of a graphical user interface that can be applied to specific software and websites to suit the purpose, topic, or tastes of different users.

Wikipedia contributors. Skin (computing) \[Internet\]. Wikipedia, The Free Encyclopedia; \[2013 Nov 12, cited 2014 Feb 05\]. Available from: http://en.wikipedia.org/wiki/Skin\_(computing)

[\[4\]](https://journal.code4lib.org/articles/#ref4). Revealing the Application Programming Interface (API) of a program allows others to create code that can make use of the internal workings of the software program.

[\[5\]](https://journal.code4lib.org/articles/#ref5). A Software Development Kit (SDK) provides additional tools, in addition to APIs, that allow development for a platform.

## About the Authors

Clifford Richmond is the IT Director for the Health Sciences Center Libraries at the University of Florida. His interests include 3-D modeling, visualization, simulation, training and PowerShell scripting.

Matthew Daley is the webmaster and graphic designer for the University Of Florida Health Science Center Libraries. He enjoys exploring the design tropes of different decades and is a fan of Outsider Art, Kosmische Musik, Dub, Capoeira and Tottenham Hotspur Football Club.
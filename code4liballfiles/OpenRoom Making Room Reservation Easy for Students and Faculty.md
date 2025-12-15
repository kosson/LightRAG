---
title: "OpenRoom: Making Room Reservation Easy for Students and Faculty"
source: "https://journal.code4lib.org/articles/2941"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-06-22
created: 2025-01-10
description: "Scheduling and booking space is a problem facing many academic and public libraries. Systems staff at the Ball State University Libraries addressed this problem by developing a user friendly room management system, OpenRoom. The new room management application was developed using an open source model with easy installation and management in mind and is now [...]"
tags:
  - "clippings"
---
# OpenRoom: Making Room Reservation Easy for Students and Faculty
Bradley D. Faust, Arthur W. Hafner, Robert L. Seaton

Scheduling and booking space is a problem facing many academic and public libraries. Systems staff at the Ball State University Libraries addressed this problem by developing a user friendly room management system, OpenRoom. The new room management application was developed using an open source model with easy installation and management in mind and is now publicly available.

## Introduction

Over the past several years, the Ball State University Libraries has changed its image from serving the campus community as a repository of knowledge to a destination for research, learning, and friends. This was accomplished by facilities renovation and new space configuration, organizational development, and the infusion of technology in almost all aspects of the Libraries’ operation. This new environment has resulted in the Libraries becoming the most popular learning space on campus. The size of Bracken Library’s usable space over its five floors is equivalent to 6.6 football fields and includes stacks, information technology, and individual study spaces. Bracken Library also includes over twenty group study and meeting spaces that students, faculty, and even local community members can reserve and use for group project meetings, class study sessions, presentation review, and many other purposes. Our challenge was to make it easier and more convenient for students and faculty to request and plan use of these group spaces.

## Jumping through Hoops to Reserve a Room

For many years, the University Libraries used a paper calendar, telephone calls, forms, and in-person requests to reserve and manage Bracken Library’s group study rooms. The master paper calendar was located at the Periodical Reserves Microform service counter. A student had to call that service desk or stop by and complete a room request form to get a reservation on the calendar. Then library users had to remember what room at what time and on which day they arranged their meeting reservation. Of course, this was the best method available to control and manage use of these meeting spaces when first implemented in 1976. This legacy approach for scheduling, however, was inconvenient for users when planning and reserving space, checking on a room’s availability, or confirming reservations. The rigid process was time-bound because Bracken Library had to be open to book a room and place-bound because the user had to visit or call a specific service point. Email requests were also used for space requests but suffered some of the same process hurdles. As the popularity and hours for Bracken Library increased in the latter half of the decade, we knew a web application could improve the service level and reduce staff time required for managing reservations for the group study rooms.

## Buying vs Building – Why did we Build it?

In July 2007, we conducted an environmental scan to learn what web-based scheduling applications were available. We found that many already existed, and they ranged from very high-end, complex, expensive enterprise solutions to single room/single user desktop systems. To help explain why we decided to build our own, let’s look at some of the original functional requirements our staff handed us.

- Empower any Ball State community member to initiate an online request to use a group study room in Bracken Library.
- Adhere to the University Libraries’ room use guidelines on size, use purpose, requestor’s credentials, use frequency, and length of reservation.
- Limit room reservations to hours when Bracken Library is open and rooms are accessible.
- Communicate by email with a user when a request is generated.
- Minimize the amount of work a user is required to do when completing the request form.
- Guide users to spaces that are appropriate in size and technology for their meetings.
- Use Windows Server and IIS technologies.
- Represent the entire suite of group study rooms in a single web interface.

As we scanned the environment, we had a difficult time finding any scheduling software that met most of our needs. Instead, we found systems that cost too much, were too simple, were too complex, ran on unsupported platforms, or used unsupported technologies. For these reasons, we decided to build the application we needed to manage our group study rooms.

## Room Scheduler Version 1.0 – Transfer of Control to the User

In January 2008, the University Libraries released the *Online Group Study Room Reservation System (Room Scheduler 1.0).* The web application immediately became popular with students, faculty, and others for reserving spaces in Bracken Library. A link prominently displayed on the Libraries’ Homepage ([http://www.bsu.edu/library](http://www.bsu.edu/library)) and on the Student Virtual Library webpage ([http://www.bsu.edu/library/svl/](http://www.bsu.edu/library/svl/)) provided easy access to Room Scheduler 1.0. University community members with Ball State University Computer Usernames could authenticate, check room availability, book a room, and go on their way. After reserving a room, the application sent the requestor an email confirmation that included essential information about the event, such as time, date, room number, and purpose. From the room scheduler’s landing page ([http://www.bsu.edu/libraries/studyrooms](http://www.bsu.edu/libraries/studyrooms)) a user unfamiliar with Bracken Library spaces could preview a photo of each room, learn capacity information, and find out other physical details such as the availability of a whiteboard, flat panel monitor, or projector screen. (Figure 1)

[![](https://journal.code4lib.org/media/issue10/faust/figure1.jpg)](https://journal.code4lib.org/media/issue10/faust/figure1.jpg)

**Figure 1.** Room Scheduler Version 1.0 landing page \[[View full size image](https://journal.code4lib.org/media/issue10/faust/figure1.jpg)\]

During spring session 2008, word about the Room Scheduler web application spread and the University Libraries received several inquiries about using the system to manage spaces in other units on campus, as well as at other universities and colleges. Since the application worked well, others were interested in duplicating its functionality at their location. However, although the Room Scheduler worked well for Bracken Library spaces, it was integrated tightly with the systems technology on the University Libraries’ departmental web server and could not be ported easily to other environments.

## From Room Scheduler 1.0 to OpenRoom to Meet Our Needs and Yours

During the first year the Room Scheduler application was online, we developed a list of features that we wanted to add to it, including enhancements to improve the user experience and administrative tools for system managers. Based on external interest in using the Room Scheduler in other environments, we also wanted to add portability to the application.

For these reasons, we decided to pursue a second round of development to build a more powerful, sleeker, focused, open source version of the system. On the surface, the Room Scheduler application was elegant and easy to use. Under its hood, however, it was not coded for easy sharing or functional expansion.

To start, the application needed a more user-friendly administration module in order to be viable as an open source tool. In Room Scheduler, many of the controls, settings, variables, and web links needed to be changed in the code, requiring a developer to drill down into the system to make adjustments. We wanted to improve the application with a staff interface to make configuration changes easier. Customization of the room reservation form was also difficult because it required PHP code changes.

Because database connection information was also hardcoded throughout the application, we needed to centralize it in a single configuration file. We viewed this as essential to make the application portable, more secure, and easier for other developers to install and customize for their environment.

An unintended performance issue also developed as the schedule filled up. The time necessary to display the room availability page listing all rooms took longer and longer to generate. It was common for a user to wait 10-15 seconds for the page to display. We needed this page load rate to be more like 1-2 seconds.

In addition, the Room Scheduler application’s authentication module used Windows authentication on our local server, relying on folder permissions that had to be set manually. Because this is risky and requires a server system administrator to make changes, we wanted the new version to feature a user account management module.

A final obstacle to sharing this application was the interface design. In our first version, the Ball State University Libraries’ web page branding was integrated tightly into the system. This resulted in code that could not be changed easily to allow another unit on campus or institution to easily insert their brand into the application interface. This shortcoming itself was a showstopper for sharing the application with interested external parties.

In April 2009, we began to look seriously at how to address these and other issues. During the following months, we developed what is now known as OpenRoom 1.0.

## OpenRoom 1.0 Functional Specifications

In January 2010, the University Libraries introduced OpenRoom 1.0 to replace the Room Scheduler system. The OpenRoom 1.0 software includes many improvements and upgrades:

- The user interface (UI) was updated to focus solely and simply on the room reservation functionality and to be more aesthetically pleasing. Hard-coded references to Ball State University Libraries’ branding were removed. (Figure 2)
- The day view page in OpenRoom that shows availability of all rooms loads quickly in all instances so that page load time is only 2-3 seconds. (Figure 3)
- As the mouse moves over a room/time cell, the details about that room are displayed in a rollover on the left side of the screen. This description follows the user up and down the display when scrolling so that one can always view details about the spaces. (Figure 4)
- The room reservation form was improved by using a pop-up window to enter event details. (Figure 5)
- A new administrative module enables managers to easily make system parameter changes and local customizations, like adding a room or changing room availability information, without having a developer dig into the code. (Figure 6)
- Administrators also enjoy enhanced reporting options to review and analyze room usage patterns. (Figure 6)
- An application level ‘reminder message’ can be added by administrators and the message will appear at the top of every page in the system. (Figure 6)
- Administrators have the flexibility to create multiple reservations at once.

[![](https://journal.code4lib.org/media/issue10/faust/figure2.jpg)](https://journal.code4lib.org/media/issue10/faust/figure2.jpg)

**Figure 2.** Generic login page for OpenRoom with no hard-coded institutional branding \[[View full size image](https://journal.code4lib.org/media/issue10/faust/figure2.jpg)\]

[![](https://journal.code4lib.org/media/issue10/faust/figure3.jpg)](https://journal.code4lib.org/media/issue10/faust/figure3.jpg)

**Figure 3.** OpenRoom day view page showing availability of all rooms \[[View full size image](https://journal.code4lib.org/media/issue10/faust/figure3.jpg)\]

[![](https://journal.code4lib.org/media/issue10/faust/figure4.jpg)](https://journal.code4lib.org/media/issue10/faust/figure4.jpg)

**Figure 4.** Details about each room are displayed in a dynamic rollover

[![](https://journal.code4lib.org/media/issue10/faust/figure5.jpg)](https://journal.code4lib.org/media/issue10/faust/figure5.jpg)

**Figure 5.** Room reservation form opens in a pop-up window

[![](https://journal.code4lib.org/media/issue10/faust/figure6.jpg)](https://journal.code4lib.org/media/issue10/faust/figure6.jpg)

**Figure 6.** A new administrative module provides features for application managers \[[View full size image](https://journal.code4lib.org/media/issue10/faust/figure6.jpg)\]

For interested parties, an operational demo version of OpenRoom 1.0 is available at [https://www.bsu.edu/libraries/openroomdemo/](https://www.bsu.edu/libraries/openroomdemo/) with username/password: admin/bracken99.

## OpenRoom 1.0 Technical Specifications

OpenRoom 1.0 requires a web server (IIS or Apache), PHP version 5 or higher, and MySQL version 5 or higher. In addition, to use the SSL or LDAP optional features, an SSL Certificate and a Directory Server, such as Microsoft Active Directory, is required. The user authentication mode must be determined at installation, and it cannot be changed later.

A modular programming structure was used to make application updates and program add-ons easier to develop and implement. Any number of new modules can be added  anywhere on the page, providing other developers more control over their own OpenRoom installation. A theme control file manages the system design and the interaction and layout of the modules. Each module operates independently of the others. The best comparison is to the WordPress or Blogspot theme control. Examples of modules include the calendar day navigation element, the room request form, and the room legend. These modules can also be easily removed. If, for example, for some reason you do not need the room detail window (Figure 4) to display, that module can be removed.

At installation, a single control file holds a number of the system variables that are used to customize the user experience and system settings. These data points are added to the system database and then managed using the administrator module after setup. The installation process for the OpenRoom web application is documented at [http://www.bsu.edu/libraries/openroom/InstallationGuide.pdf](http://www.bsu.edu/libraries/openroom/InstallationGuide.pdf). Installation and setup is similar to the process used to setup an application like WordPress.

The most difficult part of the migration from the Room Scheduler application to the OpenRoom application was restructuring the way the data was stored in and retrieved from the database and then making that data useful and available  to outside sources via XML. This involved a complete overhaul of the database structure. For better portability, the authentication methods in the system were standardized and new internal credential system and access control methods were developed.

## OpenRoom Licensing Decision

From the outset of development of OpenRoom 1.0, we kept in mind that the system needed to be portable and that we wanted to share it with other units on campus as well as other colleges, universities, and organizations. We anticipated it being open source software since we had requests from both on- and off-campus constituents to use the application. On campus today, a second instance of the system is used by students and faculty to reserve dance and theater rehearsal space in the College of Fine Arts.

As we investigated open source software licenses, we discovered that there are 2 major categories of open source/free software licenses: GPL compatible and GPL incompatible. Within each of these categories, there are more than twenty individual license options from which to choose. A recent *IEEE Software* journal article noted that the Open Source Initiative certifies fifty different licenses \[[1](https://journal.code4lib.org/articles/#note1)\].

We discovered some institutions had released locally developed software under the GNU General Public License (GPL). GPL protects the developer, allows others to download and customize the program for non-commercial use, and allows us to customize the program for our purposes on our schedule \[[2](https://journal.code4lib.org/articles/#note2)\]. We determined that the MRBS meeting room booking system (one of the free resource booking systems we evaluated) is available under GPL.  We reviewed how it is made available on Source Forge, and really like that scenario as a model. For these reasons, we have decided to share OpenRoom, including source code, with a GNU GPL license.

OpenRoom is currently available from the Ball State University Libraries web site as a ZIP file at [http://www.bsu.edu/libraries/getopenroom/](http://www.bsu.edu/libraries/getopenroom/).

## Conclusion

The Ball State University Libraries have found that OpenRoom 1.0 is a great resource for students and faculty to find and reserve the popular group study and meeting spaces that are available in Bracken Library. Since its release at the beginning of January 2010, OpenRoom has processed more than 8,500 room use requests. Like its predecessor, it empowers students and faculty with the flexibility to plan meetings, request space, and notify colleagues from any Internet enabled computer, anytime. Compared to phone calls, paper forms, random email, and service point visits, this convenient access to valuable study and meeting spaces for students and faculty helps make the University Libraries a destination for research, learning, and friends. The application also performs many repetitive tasks that staff and student assistants had done manually in the past, freeing their time to perform other more important duties.

The Ball State University Libraries’ Library Information Technology Services unit exists to provide the hardware and software solutions needed for the University Libraries to operate and serve the academic community efficiently and successfully. Sometimes building a solution is the best course of action to accomplish this mission. The popularity of the OpenRoom system with staff managing other spaces on campus demonstrates the value outside the Libraries for the work we have done. We will definitely consider application sharing and an open source solution on future projects.

## References

\[[1](https://journal.code4lib.org/articles/#note1text)\] Engelfriet, A. (2010). Choosing an Open Source License. *IEEE Software*, *27**(1)*, 48-9. Retrieved April 8, 2010, from Applied Science & Tech Index database. DOI: [10.1109/MS.2010.5](http://dx.doi.org/10.1109/MS.2010.5).  
[(COinS)](https://journal.code4lib.org/coins)  

\[[2](https://journal.code4lib.org/articles/#note2text)\] Arch, X. (2010). Under the Hood – Buy, Build or Borrow. *Against the Grain, 22(2).* 13-14.  
[(COinS)](https://journal.code4lib.org/coins)  

Bradley D. Faust is Assistant Dean for Library Information Technology Services at Ball State University. He has served as CIO in the University Libraries since 1992. Email: [BFaust@bsu.edu](https://journal.code4lib.org/articles/)

Arthur W. Hafner, Ph.D. is Dean of University Libraries at Ball State University. Previously the Dean of University Libraries at Seton Hall University, Dr. Hafner has been at Ball State University since 2002. Email: [AHafner@bsu.edu](https://journal.code4lib.org/articles/)

Robert L. Seaton is Web Development Analyst in the University Libraries at Ball State University. Robert has served in this position since 2006. [RLSeaton@bsu.edu](https://journal.code4lib.org/articles/)
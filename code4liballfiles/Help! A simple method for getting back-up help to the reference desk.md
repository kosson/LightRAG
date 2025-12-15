---
title: "Help! A simple method for getting back-up help to the reference desk"
source: "https://journal.code4lib.org/articles/45"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-03-24
created: 2025-01-10
description: "Using the \"net send\" command, native to Windows XP, librarians at the University of California, Riverside created a \"help button\" for the reference desk. The simple script file sends a message to librarians' workstations in their offices and logs the date and time of use. This paper describes that program."
tags:
  - "#reference/desk"
---
# Help! A simple method for getting back-up help to the reference desk
Ken Furuta, Michele Potter

Using the “net send” command, native to Windows XP, librarians at the University of California, Riverside created a “help button” for the reference desk. The simple script file sends a message to librarians’ workstations in their offices and logs the date and time of use. This paper describes that program.

## Introduction

Reference librarians are occasionally caught in the middle of time-consuming reference questions as the line of patrons needing service lengthens. Leaving the current patron to call around for other librarians, or running around trying to grab one at random may take too much time and frustrate everyone.

At the University of California, Riverside (UCR) Libraries, we faced this problem more and more as workload increases made double staffing less and less feasible. We needed a way to contact all of the librarians at the same time in a method similar to a PA message at a department store (i.e. “Back-up librarians to the reference desk.”)

Looking for solutions in the library literature, we didn’t find anything to help us solve this problem. While there are papers on staffing policies and others on using statistics \[1\], none addressed the nuts and bolts of calling for back-up help efficiently. A search through the archive of a reference librarian listserv (LIBREF-L) showed some questions on policies for backups, but no methods for calling it. What we decided to try, after some brainstorming, turned out to be completely free and has been working beautifully for a few years now.

We are using the “net send” command, native to Windows XP, to broadcast the message “Need help at the reference desk” to the workstations in all of the librarians’ offices. The message and the recipients are contained in a short batch file on the desktop. The procedure requires only the click of a button to create a stampede of librarians heading for the reference desk. In our experience backups arrive within 45 seconds. If a stampede does arrive, it becomes a pleasant opportunity to stretch and briefly visit. If a stampede is not desirable, there may be some other possible refinements. For example, if librarian workspaces are close together, one librarian may offer to go.

## How it works

The command “net send” was created for communication from system administrators to users by transmitting one-way messages to another machine on the network.

The command’s syntax is:

net send \[name\] message

In the syntax, “\[name\]” is the name of the user or computer to which you would like to send the message, and “message” is the message you would like to send.

To test the command or to send a single message to a single user, one can:

1. Click on the start menu
2. Click on Run
3. Type cmd
4. Type net send \[name\] message

This would work very well for inviting a colleague to lunch, but is hardly feasible for the reference desk, especially when the line is lengthening.

However, as with all DOS commands, one can create a batch file in order to execute a collection of commands all at once. In our case it looks something like this:

net send librarian1 Need help at the reference desk!

net send librarian2 Need help at the reference desk!

etcâ€¦

The batch file can be created in a text editor, such as notepad, and saved as a “.bat” file, e.g., “help.bat”.

The message to the user looks like this and includes an audible alert:

![Sample alert message from the net send command](https://journal.code4lib.org/media/issue2/furuta/Help_alert.jpg)

A shortcut to the batch file was placed on the desktop of all of the reference machines and works as a virtual help button. It is even possible to add coding to the file to keep track of when the button is used (see appendix).

Saving the batch file to a common, or shared, drive, instead of on each hard drive of every reference librarian’s PC, greatly simplifies maintenance. The file can be updated once and changes go into effect immediately.

## Trouble shooting

There are a few technical issues that may need to be resolved before the program will work smoothly. Some are relatively minor while others may require you to work with your systems department to resolve.

1. Net send is a DOS command, and as such it resides on your hard drive. If you see that the default drive for your command line interface is different (e.g., Z:\\>), you may need to add “c:” to the beginning of the batch file.
2. If you are not sure of the user/computer names of your reference librarians, you can type “net view” in the command line interface to see a list of names (see below).![Sample results for new view command](https://journal.code4lib.org/media/issue2/furuta/netview.jpg)
3. The batch file progresses in order from user (or computer) name to user name. If one of the users is not logged in or if the computer is off, it takes a while for the timeout to get back to the originating computer. Other users may not get the message for a few seconds to a minute. In order to partly resolve this issue, you can rearrange the list of recipients in order of the likelihood that they have logged in.
4. Another issue is the format of the user names. When our network was upgraded to SP2, the format of the user name changed from just the name to including the prefix “/domain:” (i.e. “net send /domain:librarian1 Help is needed at the reference desk!”).
5. The Windows messenger service can be turned off on individual office workstations through the control panel. In this case the message will not appear on that machine. If you have the ability to see and alter your profile, this can be done in the Administrative tools/services window. It is listed as “messenger”. In Windows XP SP2, messenger is set to “disabled” as the default. It will need to be reset to “started.” If you cannot or do not want to mess with your settings, check with your systems department.
6. It is also possible that the ability to receive net send messages can be turned off on a network because outsiders may also try to send net send messages (spam) to your computer. However, a network firewall can likely block these messages coming from the outside. This is an issue you should discuss with your systems department

## Alternative Method

There has been some discussion at the UCR Libraries about using MSN Messenger (formerly Window Messenger) or some other instant messaging program to call for help. In our case, MSN Messenger is already installed on our computers. MSN Messenger allows users to communicate and share files with others who are logged on at the same time. This may be a good alternative if you or your systems department is reluctant to enable Microsoft Messenger.

However, we could not create a “canned” help message or list of recipients beforehand in MSN Messenger. Thus the librarian at our desk would have to type a help message and designate the recipients when a backup is needed resulting in extra time calling for backup.

## Other operating systems

The Windows Vista operating system does not support the net send command. Instead, Vista users can use the “msg” command. The msg command is also available in XP, but is slightly more complicated to use. The syntax is “msg /server:\[computer name\] message”. It is worth noting that msg does not require the messenger service to be running on the target machines.

It may even be possible to send messages between PCs and Macs in mixed shops. However, we are unable to test this since UCR is a PC only shop.

## Conclusion

Using a help button based on the native “net send” capabilities of most Windows operating systems works well to send help requests to librarians’ offices when lines begin to form. The method may be most useful in departments where reference librarians’ offices are spread out, because the program sends a message to the various recipients no matter where they are located.

## Note

1. For example see Deborah Rinderknecht, “New norms for reference desk staffing adequacy: a comparative study,” College & Research Libraries 53 (1992): 429-36.

## Appendix:

**Help.bat file**

```bat
REM  Script created by Michele Potter.  Kenneth Furuta added the log file.
net send librarian1 Need help at the reference desk!
net send librarian2 Need help at the reference desk!
REM  etc...

REM Code for the log file
REM  Use the text parsing mode of the 'for' command and the /T (Display only)
REM  switch on the date and time commands.
REM  "for in do" loops require 2 percent signs before variables, "%%variable_name"
for /F 'tokens=1-4 delims=/ ' %%i in ('date /t') do (
   set DayOfWeek=%%i
   set Month=%%j
   set Day=%%k
   set Year=%%l
)
REM  Only save the hour and minute.
for /F 'tokens=1-2 delims=:' %%i in ('time /t') do (
   set Hour=%%i
   set Minute=%%j
)

REM  Create a comma delimited file.  (Note the comma between the variables).
REM  Enclose variable names with percent signs.
REM  ">>" redirects the output from the screen to writing to a file.
REM  Double angled brackets, ">>" appending it to the end of the file.
echo %DayOfWeek%,%Month%/%Day%/%Year%,%Hour%:%Minute% 1>> Help_Button_Log.csv

REM  Optional - clean up variables (setting them to {nothing} deletes them)
set DayOfWeek=
set Year=
set Month=
set Day=
set Hour=
set Minute=
```

Kenneth Furuta and Michele Potter are both at the University of California, Riverside University Libraries. Kenneth is the Reference/Information Technology librarian in the Rivera Library (email: kfuruta@ucr.edu). Michele is the Engineering Librarian in the Science Library (email: michelep@ucr.edu). The authors acknowledge Vicki Bloom’s (Head, Rivera Reference Department) contributions on this project.
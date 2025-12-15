---
title: "Collecting Virtual Reference Statistics with an IM Chat-Bot"
source: "https://journal.code4lib.org/articles/85"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-06-23
created: 2025-01-10
description: "A perennial problem in libraries is capturing accurate statistics. This article addresses this problem with the creative use of Web 2.0 tools: Meebo and AOL Instant Messenger. It describes the development and implementation of an instant messaging \"stat-bot\" that prompts staff to record virtual reference statistics via IM. Step-by-step guidelines and the Perl script are [...]"
tags:
  - "clippings"
---
# Collecting Virtual Reference Statistics with an IM Chat-Bot
Mason R.K. Hall

A perennial problem in libraries is capturing accurate statistics. This article addresses this problem with the creative use of Web 2.0 tools: Meebo and AOL Instant Messenger. It describes the development and implementation of an instant messaging “stat-bot” that prompts staff to record virtual reference statistics via IM. Step-by-step guidelines and the Perl script are provided.

## Introduction

Over the past several years, virtual reference has become a popular and valuable point of contact between patrons and libraries. With new web-based technologies like Meebo \[[1](https://journal.code4lib.org/articles/#note1)\], librarians can now be available for virtual reference anywhere they have Internet access.

Because of this anywhere-access factor, keeping track of statistics from multiple employees located in multiple places is a problem. E-mail and manual statistics collection and compilation are successful only if the employee remembers to compile and send them after each session. Unfortunately, our employees (myself included) often forget to perform this crucial step after virtual reference. At our institution, virtual reference is usually performed as a secondary task (usually in addition to the employees’ primary duties), and can be easily forgotten about if no questions are received for a length of time.

How could we prompt employees to record virtual reference statistics? After weighing our options, we agreed that the best solution to this problem would be to create a system that actively pulled statistics from the employee each hour. The system would have the ability to query staff members for statistics, and receive the information as an instant message.

Creating the “statbot” removed the problem of statistics collection from both the supervisors and the employees and has provided a consistent and accurate stream of quantitative data from our virtual reference system \[[2](https://journal.code4lib.org/articles/#note2)\].

This article will explain how to set up and use the statbot in your own library using the [provided perl script](https://journal.code4lib.org/media/issue3/hall/statbot.pl).

## Requirements

For this project you’ll need command line access to a Linux server with perl >= 5.8.5, and the ability to add a cron entry \[[3](https://journal.code4lib.org/articles/#note3)\].

For this particular script, we’ll be using AOL’s instant messaging network for sending and receiving statistics messages. This means whoever is manning your virtual reference service will need to be logged onto AOL IM. Many libraries now use Meebo to connect to multiple services at once \[[4](https://journal.code4lib.org/articles/#note4)\]. This allows many users on many different chat systems to access that library’s virtual reference. For this project (and for virtual reference in general) I recommend using Meebo.

## Setup

**1\. Create Statbot Account**

First, you’ll need to create your statbot account in AOL instant messaging. AOL provides a special account for bots, which you can sign up for here: [http://dev.aol.com/aim/bot](http://dev.aol.com/aim/bots).

> a. Click on the “Bot My Screenname” link under “What do I need to get started?”
> 
> b. On the right side of the screen, under “Screen Name or E-mail” click on the “Get an account” link.
> 
> c. Fill in all the appropriate information. I recommend documenting the Security Question in case the password is ever forgotten. The screenname can be anything, but should be something your employees can readily associate with the statbot e.g. *FSUstatbot, MyLibStatbot, etc.*
> 
> d. Once submitted, you’ll be asked to agree to AOL’s terms of service. You must agree to continue.

Important: You’ll need to add this screenname to your Virtual Reference’s AOL “buddy list” so that the statbot can talk to employees using it. AOL doesn’t allow bots to initiate conversations without the bot being on that user’s buddylist.

**2\. Put Statbot Script on Server**

Create or choose a directory on your server and place the statbot.pl script inside of it.

From inside the directory, create a folder for the statlog by issuing the following command:

“touch statlog.txt”

**3\. Customize Statbot Script**

Open the statbot.pl script in your favorite text editor. You’ll need to modify a couple of lines to customize your instance. Make sure to only change the information within the single quotes.

*my $screenname = â€˜statbotScreenname’;*

Change this to the screenname you just created for the statbot in step 1.

*my $password = ‘statbotPassword’;*

Change this to the password you created for the statbot in step 1.

my $vrScreenname = ‘*VirtualReferenceAOLScreennam*e’;

Change this to your library’s Virtual Reference (VR) AOL screenname.

*my $timeToQuery = ’52’;*

Change this to the minute on the hour you would like the statbot to query VR for stats. If your VR staff changes at the end of each hour, it should ask right before the shift change (like the example).

*my $finishHour = ’22’;*

Change this to the hour (in 24 hour time) that you would like the statbot to finish for the day and send its report. As is, statbot would compile and send all statistics, then shut-down at 10:00 p.m.

*my $statcollector = ‘sombodys@email.edu’;*

Change this to the email address you would like the end-of-day statistics report sent to each night.

*my $statcollectorsmtp = ‘mail.smtp.edu’;*

Change this to your local smtp server address.

*my $statlogloc = ‘/var/www/statbot’;*

Change this to the directory on the server you have placed statbot inside of in step 2.

**4\. Setup Schedule for Statbot**

You’ll want to set these variables to correspond to the times you would like the statbot to come online and go offline each day. Use 24 hour time. If you don’t want statbot to come online that day use â€˜99′ for both the On and Off times.

my $MonOn = ’12’ ; my $MonOff = ’20’ ;

my $TueOn = ’12’ ; my $TueOff = ’20’ ;

my $WedOn = ’12’ ; my $WedOff = ’20’ ;

my $ThuOn = ’99’ ; my $ThuOff = ’99’ ;

my $FriOn = ’12’ ; my $FriOff = ’18’ ;

my $SatOn = ’99’ ; my $SatOff = ’99’ ;

my $SunOn = ’12’ ; my $SunOff = ’17’ ;

This code was originally created for a virtual reference service that operated a limited number of hours each day. If your institution uses 24 hour VR service, set the on time as â€˜0′ and the off time as â€˜24.’ \[[5](https://journal.code4lib.org/articles/#note5)\]

**5\. Add a Crontab Entry**

The crontab is typically located in the /etc directory, but may vary depending on your setup. You should be able to find it by issuing a “whereis crontab” command at the command line.

This is the recommended crontab entry. Make sure to change the path to your statbot script and the path to perl if different from the default.

30 0 \* \* \* root /usr/bin/perl /path/to/your/statbot.pl

**6\. Install Needed Perl Modules**

The script requires two perl modules. To install these, issue the following commands at the command line:

perl -MCPAN -e shell

install Net::OSCAR

*(answer â€˜Y’es to any required dependencies)*

Install Mail::Sender

*(answer â€˜Y’es to any required dependencies)*

## How it Works

Once all the steps above are done, you should have a fully-functioning statistics-capturing IM bot. While the script itself will be run once per day by the crontab, the bot will only show up online during the times you scheduled in step 4. Each hour, the statbot will then send an IM to the staff member who is on virtual reference, asking for the number of questions they have fielded that hour. The user then has 5 minutes to respond and relay their statistics to the statbot, who will then record those statistics in a daily flat file (text file).

In the case that the employee does not respond, or is not logged into the library’s virtual reference screenname, the statbot will send an email to the supervisor stating the shift which failed to report. The statbot will also record this error in the text file.

![](https://journal.code4lib.org/media/issue3/hall/statbot_image.jpg)

At the end of the day, the script will shut itself down and calculate the total and average number of questions for the day, and send all of those statistics as an email attachment to the stat collector (defined in *$statcollector* above).

**Example of flat file output:**

```
12am 0

1am 0

2am 0

3am 0

4am 0

5am 0

6am 0

7am 0

8am 0

9am 0 NL

10am 0 NR

11am 1

12pm 1

1pm 1

2pm 0

3pm 1

4pm 1

5pm 0

6pm 2

7pm 1

8pm 0

9pm 1

10pm 0 NR

11pm 0

Total 9

Average 0.375
```

There are two error codes which may be found next to some entries:

NL: The staff member was not logged into virtual reference at this time.

NR: The staff member did not respond to the statbot when asked for hourly stats.

There are two other options that are available while the statbot is online:

**Check stats for the day**

If you would like to see the total number of questions for the day (up to the current hour) instant message the statbot with â€˜adminstats’ (no quotes).

**Shut down statbot**

If the statbot is malfunctioning, you can shut it down prematurely by sending an instant message that reads â€˜gotobednow’ (no quotes).

## Conclusion

The statbot code has made recording statistics for virtual reference a simpler process. The granularity of hourly reports has made informed staffing changes possible, and we can now present what we believe are more accurate statistics for yearly reports (like the Association of Research Libraries Report). Previous collection methods tended to be far less immediate for the employees involved. Because statistics were collected monthly from employees, “estimates” of the outcomes of the previous four weeks of VR sessions were often provided instead of exact statistics.

The statbot script presents a unique framework for future statistical projects. Expanding this system could result in a larger statistics collection process which could pull many different statistics from many different areas in the library. This “automatic” stat collection is not limited to quantitative data either–all types of information could be collected, sorted, analyzed and finally filtered to the necessary entities.

## Code

[See Attachment](https://journal.code4lib.org/media/issue3/hall/statbot.pl)

## Notes

\[1\] See [www.meebo.com](http://www.meebo.com/). An online chat application that provides one interface for many different instant messaging services.

\[2\] Chat-bots have been in use since the early 1990’s, and have varying uses and levels of complexity: [http://en.wikipedia.org/wiki/Chat\_bot](http://en.wikipedia.org/wiki/Chat_bot). “Stat-bot” is a very simple form of this technology, designed for the singular purpose of collecting statistics.

\[3\] If you’re not familiar with cron or how to set up a cron entry, see [http://www.unixgeeks.org/security/newbie/unix/cron-1.html](http://www.unixgeeks.org/security/newbie/unix/cron-1.html) for a fairly straightforward overview and introduction

\[4\] Meebo currently supports AIM, yahoo!, google talk, msn, ICQ, and Jabber

\[5\] You may ask why statbot isn’t just on constantly. When initially testing the script, there were some minor security worries, which were allayed by only having statbot online when virtual reference was online. These “security issues” are now moot, but we find that this setup still provides the least maintenance. If the statbot or the AOL network dies unexpectedly, it will be restarted the next day with the crontab, regardless.

## About the Author

Mason R.K. Hall is the Electronic Resource Integration Management Librarian at Florida State University. He currently holds the record for the longest job title in his library. His email address is mrhall@fsu.edu.
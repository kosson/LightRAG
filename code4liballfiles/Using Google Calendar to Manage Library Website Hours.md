---
title: "Using Google Calendar to Manage Library Website Hours"
source: "https://journal.code4lib.org/articles/46"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-03-24
created: 2025-01-10
description: "The management and display of hours of operation on a library website can be needlessly complicated. One relatively simple solution is to manage the library hours in Google Calendar, and then use the Google API to extract this data for use on the public website. This article outlines how the Ithaca College Library used Google [...]"
tags:
  - "#Google/Calendar"
---
# Using Google Calendar to Manage Library Website Hours
Andrew Darby

The management and display of hours of operation on a library website can be needlessly complicated. One relatively simple solution is to manage the library hours in Google Calendar, and then use the Google API to extract this data for use on the public website. This article outlines how the Ithaca College Library used Google Calendar, PHP and MySQL to manage and report against our library's operational hours. Example code is included.

## Introduction

The hours of operation are perhaps not the sexiest aspect of a library website, but they are nonetheless a “killer app,” providing a small, crucial bit of information for your users. Library hours tend to be quite dynamic, varying from day to day, semester to semester, and year to year. From the user’s perspective, this changeability means it’s the sort of information you will want to quickly look up before lacing your shoes, or planning some last minute research. From the web developer’s point of view, dealing with this changeability just makes your work more difficult. Developing a back end to manage your website hours–or better, to allow someone else to manage the hours–becomes complicated quickly.

After working on such a management tool for a while, and getting caught up in the complexities of dealing with the competing academic and Gregorian calendars, I decided to outsource the most complicated part of the process–handling the addition and removal of dates–to Google Calendar, and then use the GData API to power my pages. A related problem was the management of the Reference Desk calendar. It was in an Excel file on a shared network folder, but we started using Google Calendar for this, too. As a result, using the Google API, we have access to information such as the current librarian on the desk (in order to show their picture) and upcoming reference desk shifts for a given librarian. \[[1](https://journal.code4lib.org/articles/#note1 "ref1")\]

What follows is an explanation of how to get your library hours running using Google, PHP and MySQL. \[[2](https://journal.code4lib.org/articles/#note2 "ref2")\] There is a list of [resources](https://journal.code4lib.org/articles/#resources) at the end, as well as downloadable [code](https://journal.code4lib.org/articles/#code) for the back-end and front-end pages.

[![](https://journal.code4lib.org/media/issue2/darby/ithaca_hours_small.png)](https://journal.code4lib.org/media/issue2/darby/ithaca_hours.png)  
**Figure 1: Library Hours Page** \[[View full-size image](https://journal.code4lib.org/media/issue2/darby/ithaca_hours.png)\]

## Requirements

The one absolute requirement to set up an hours management system using Google Calendar is a Google account, but for the process I’m going to outline, you’ll also need PHP >= 5.1.4 in order to use the time-saving Zend GData library, and a database to store your library hours. \[[3](https://journal.code4lib.org/articles/#note3 "ref3")\]

## Setting Up Google Calendar

You may or may not be familiar with Google Calendar already, but as you will be interacting with the Calendar API, you need to make sure the information you enter into the calendar can be retrieved again. Essentially, you (or someone) will need to enter the dates for every day of the semester or term. This sounds quite time-consuming, but since you can set events–in this case, the hours of operation for a given day–as repeating, it can be done quite quickly. Using Google Calendar is outside of the purpose of this article, but let me share two tips which might save you some time:

1. If you choose the “Repeats Weekly” option when adding an event (see Figure 2, below), you get a nice set of tick boxes for each day of the week, and you can set a ending date. I found this the easiest way to handle a repeating event.
2. If the library is closed on a given day, you might add an event with hours like 7:30 – 8:00 am, and then use the word “Closed” in the title. The “hours.php” script searches for the word “Closed” in the title field, and if found, sets a closed flag in the database. The problem is that if you leave a day blank, the feed from Google does not include that date, so you need something in every day.

This example does not use the data from the What, Where or Description fields of Google Calendar, but keep in mind that all of these should be accessible through the API if you wanted to use them.

[![](https://journal.code4lib.org/media/issue2/darby/calendar_event_small.png)](https://journal.code4lib.org/media/issue2/darby/calendar_event.png)  
**Figure 2: Calendar — Select Weekly** \[[View full-size image](https://journal.code4lib.org/media/issue2/darby/calendar_event.png)\]

## Setting up the Database in MySQL

You will need to create the table `libhours` in one of your MySQL databases. The following SQL may be used to generate `libhours`.

| 1  2  3  4  5  6  7  8 | `CREATE` `TABLE` `libhours (`  `libhours_id ``INTEGER` `UNSIGNED ``NOT` `NULL` `AUTO_INCREMENT ``PRIMARY` `KEY``,`  `ymd ``varchar``(10) ``default` `NULL``,     # (YYYY-MM-DD) One entry ``for` `each ``day`  `dow ``varchar``(10) ``default` `NULL``,     # ``Day` `of` `the Week`  `opening ``varchar``(10) ``default` `NULL``, # Opening ``time`  `closing ``varchar``(10) ``default` `NULL``, # Closing ``time`  `is_closed ``integer``(1) ``default` `0    # 0 (``open``) ``or` `1 (closed)`  `);` |
| --- | --- |

## Interacting with the Google API

The Google API Developer’s Guide ([*Resources*](https://journal.code4lib.org/articles/#resources), below) provides tutorials for Python, PHP, .NET, Java and Javascript. As noted, you will be using PHP. The PHP page supplies detailed instructions, which seem to be updated with some regularity, but here are my own slightly less detailed instructions to get you up and running quickly.

### 1\. Download the Zend Google Data Client Library

While it is possible to interact with the Google API directly, using this library makes everything much simpler. Go to the Client Library download page ([*Resources*](https://journal.code4lib.org/articles/#resources), below), download, unzip, and place in your PHP includes folder. Or, put it in any folder and make sure to use the PHP [set\_include\_path](http://us2.php.net/set_include_path) to point to this other location.

### 2\. Edit the Configuration File

The file config.php ([*Code*](https://journal.code4lib.org/articles/#code), below) contains some configuration variables you will need to set, as well as a basic function to connect to MySQL. Open config.php in a text editor and enter your Gmail credentials (for the Calendar you wish to connect to), your MySQL database name, your MySQL username and password, your hostname (if it’s not *localhost*), and the path to get to your Zend GData Library (if it’s not in your system-defined PHP includes folder, or you haven’t added an entry to php.ini). You can also set the number of months into the future that the script should check.

### 3\. Create Connection/Update File

Assuming you have at least one item in your Google calendar, the MySQL table `libhours`, and the Zend client library, you can now create a page, gdata\_connect.php ([*Code*](https://journal.code4lib.org/articles/#code), below), to connect to Google Calendar, return your Calendar data, and update your database. When you make a change to your Google Calendar, you will need to run this file again to update. If your hours get modified frequently, you could run this page with a Cron job; in the more likely case that the hours get set once a semester or term, and perhaps tweaked a couple of times thereafter, you could manually run the page after changes are made. This page:

- Calls config.php to get database connection and configuration information.
- Includes the Zend/loader.php file and loads the Zend classes.
- Sets Google Calendar authentication. This example uses the ClientAuth authentication type, but there are two other options: AuthSub and MagicCookie. ClientAuth is considered the least secure–because you include your username and password directly in the file–but it is also the simplest. \[[4](https://journal.code4lib.org/articles/#note4 "ref4")\]
- Loops month by month, each time adding the information for each day to a SQL query. (I ran into issues sending, say, a six month range, so to be safe it is set to fetch one month at a time.) Inside the loop, the function `outputCalendarByDateRange` is called.
- Connects to the database.
- Deletes all entries in the database for the date the script is run on into the future, and then uses the SQL generated in the loop to INSERT the new values into the database. All entries before the day the script is run are retained.

In the function `outputCalendarByDateRange`, which is based on the “Retrieving events for a specified date range” example in the PHP Developer’s Guide \[[5](https://journal.code4lib.org/articles/#note5 "ref5")\], we use `Zend_Gdata_Calendar_EventQuery` to get back information from our calendar in the form of an Atom feed. \[[6](https://journal.code4lib.org/articles/#note6 "ref6")\] A number of properties can be set here, but none need to be modified right now. They are mostly self-explanatory:

- setUser will set the user whose calendar you are connecting to. “Default” is only available for “private” feeds, and, as you might expect, will display the default calendar based on the login credentials.
- setVisibility has two options: public and private. Public feeds may be accessed by anyone, while private feeds are … private. \[[7](https://journal.code4lib.org/articles/#note7 "ref7")\]
- setProjection gives you some options for what data you want the feed to contain. A list of options may be found in the API Reference Guide. \[[8](https://journal.code4lib.org/articles/#note8 "ref8")\]
- setOrderby allows you to either order by “starttime” or “lastmodified.” setStartMin and setStartMax are set in the loop that calls this function. Note that dates are returned as RFC 3339 formatted strings, i.e., 2008-01-26T10:00:00.000-05:00.

### 4\. Run gdata\_connect.php

Visit gdata\_connect.php with your browser, and it will run the above script. It should populate your `libhours` table with the correct data. Note that you seem to need to log out of Gmail/Google Calendar after you make an update (and before this file is run), or else you will not get the most recent changes.

### 5\. Create a Public HTML Page

You will now need to provide a front-end to show your library hours on your website. Since your hours are in a database, you have some flexibility in how you can display them. You could display today’s hours on the home page, and then link to a fuller calendar on its own page (which is what we do). The included hours.php ([*Code*](https://journal.code4lib.org/articles/#code), below) is a script for a page to display the hours in a monthly calendar, using the data generated by gdata\_connect.php. \[[9](https://journal.code4lib.org/articles/#note9 "ref9")\]

## Conclusion

With any luck, you now have a working Library Hours application. If you wanted to show a picture of the reference librarian on duty, use the same procedure, but with live queries to Google Calendar. \[[10](https://journal.code4lib.org/articles/#note10 "ref10")\] There is a great deal more one can do with the Google Calendar API. You can create, update and delete events in a calendar; find out who is subscribed to a calendar; retrieve “secondary” calendars (which might be useful if you need to manage multiple sets of library hours, although I have not explored this); create entirely new calendars; and so on. There is even the (very simple) option to embed a Google Calendar directly in your page, if you’re willing to hand over the look and feel to Google.

## Resources

The following resources are helpful for getting a handle on using the Google API and PHP. Note that Google is regularly adding features and documentation to their pages, so information and URLs might change.

- [Google Calendar](http://calendar.google.com/)
- [Google Calendar API](http://code.google.com/apis/calendar/overview.html)
- [PHP Developer’s Guide (for Google Calendar)](http://code.google.com/apis/calendar/developers_guide_php.html)
- [Zend Gdata Client Library Download](http://framework.zend.com/download/gdata)
- [Zend API Guide](http://framework.zend.com/apidoc/core)
- [Zend Programmer’s Reference Guide (Ch 14, Zend\_Gdata)](http://framework.zend.com/manual/en/zend.gdata.html)

## Code

There are three files available. [Download zip](https://journal.code4lib.org/media/issue2/darby/darby_files.zip) (6.5 K)

- [config.php](https://journal.code4lib.org/media/issue2/darby/config.phps) — Set a couple of configuration variables here.
- [gdata\_connect.php](https://journal.code4lib.org/media/issue2/darby/gdata_connect.phps) — The file to connect to a Google Calendar, extract the next X months of data, and insert into a database.
- [hours.php](https://journal.code4lib.org/media/issue2/darby/hours.phps) — The file to display the library’s hours in a month-by-month format.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1 "note1")\] Faculty and students often pop by looking for a specific librarian, and I thought these might be useful bits of information. Plus, it’s cool. Live examples of these pages are available: [Ithaca College Library Hours](http://www.ithacalibrary.com/info/hours.php) and [Ithaca College Reference Desk Hours](http://www.ithacalibrary.com/info/ref_hours.php).

\[[2](https://journal.code4lib.org/articles/#ref2 "note2")\] Of course, you could use other scripting languages. The API Developer's Guide has tutorials for Python, .NET, Java and JavaScript in addition to PHP.

\[[3](https://journal.code4lib.org/articles/#ref3 "note3")\] Each query sent to the Google Calendar API can take a couple of seconds, depending on network connectivity, so some form of caching of results is desirable for a page like the library hours, which is both reasonably static across a semester/term, and relatively high traffic. I like the flexibility of having the information in a database, but you could also print out a set of static pages for upcoming months, cache live queries at an appropriate interval, or just query anew each time a user hits the page.

On our Reference Hours page, we do use real-time queries to display a picture of the librarian on the desk at the moment. This is because: a) this is a low-traffic page, b) the lookup is done asynchronously, so there is no delay for the main contents of the page to load, and c) the information changes quite regularly and unpredictably (humans are like that).

\[[4](https://journal.code4lib.org/articles/#ref4 "note4")\] See [http://framework.zend.com/manual/en/zend.gdata.calendar.html #zend.gdata.calendar.connecting](http://framework.zend.com/manual/en/zend.gdata.calendar.html#zend.gdata.calendar.connecting) for examples of each.

\[[5](https://journal.code4lib.org/articles/#ref5 "note5")\] See [http://code.google.com/apis/calendar/developers\_guide\_php.html #RetrievingDateRange](http://code.google.com/apis/calendar/developers_guide_php.html#RetrievingDateRange).

\[[6](https://journal.code4lib.org/articles/#ref6 "note6")\] Looking at the feed directly is not so helpful, because each repeating item will appear as a single entry in the feed, with a description (inside the `<content>` tags) that looks something like this:

```
<content type="text">
Recurring Event
First start: 2007-11-06 08:00:00 EST
Duration: 64800
Where: In the library
Event Status: confirmed
Event Description: This is a repeating event
</content>
```

There is a `singleevents` parameter which might make this more readable, however. See [http://code.google.com/support/bin/answer.py?answer=55834&topic=10360](http://code.google.com/support/bin/answer.py?answer=55834&topic=10360).

\[[7](https://journal.code4lib.org/articles/#ref7 "note7")\] A feed’s visibility is set within a specific Google Calendar’s “Calendar Settings” area: Click the Settings link on the upper right of your Google Calendar page, select the Calendar tab, and then click the link with the name of your calendar on it–which will magically create a new “Calendar Details” tab, where you can scroll down and find Public and Private Addresses.

\[[8](https://journal.code4lib.org/articles/#ref8 "note8")\] See [http://code.google.com/apis/calendar/reference.html#Projection](http://code.google.com/apis/calendar/reference.html#Projection).

\[[9](https://journal.code4lib.org/articles/#ref9 "note9")\] This builds upon a script found at [http://www.plus2net.com/php\_tutorial/php\_calendar.php](http://www.plus2net.com/php_tutorial/php_calendar.php) — the first Google hit at the time I was first working on this.

\[[10](https://journal.code4lib.org/articles/#ref10 "note10")\] The reference librarians at Ithaca College keep a Google Calendar of the reference desk staffing, and make sure to always use the person’s initials in the title field, i.e. “AD on desk.” The Reference Hours page queries the Google Calendar (through an Ajax request, so the rest of the page loads first) for only that hour’s entry, and then matches the initials (AD) to the correct picture, and displays it.

[Andrew Darby](http://www.ithacalibrary.com/info/staff/adarby) is the Web Services Librarian at Ithaca College in Ithaca, NY. He maintains [SubjectsPlus](http://www.ithacalibrary.com/subsplus/), a free and open-source subject guide management tool.
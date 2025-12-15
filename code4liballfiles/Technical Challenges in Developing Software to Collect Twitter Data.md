---
title: "Technical Challenges in Developing Software to Collect Twitter Data"
source: "https://journal.code4lib.org/articles/10097"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-10-21
created: 2025-01-10
description: "Over the past two years, George Washington University Libraries developed Social Feed Manager (SFM), a Python and Django-based application for collecting social media data from Twitter. Expanding the project from a research prototype to a more widely useful application has presented a number of technical challenges, including changes in the Twitter API, supervision of simultaneous [...]"
tags:
  - "clippings"
---
# Technical Challenges in Developing Software to Collect Twitter Data
Daniel Chudnov, Daniel Kerchner, Ankushi Sharma, Laura Wrubel

Over the past two years, George Washington University Libraries developed Social Feed Manager (SFM), a Python and Django-based application for collecting social media data from Twitter. Expanding the project from a research prototype to a more widely useful application has presented a number of technical challenges, including changes in the Twitter API, supervision of simultaneous streaming processes, management, storage, and organization of collected data, meeting researcher needs for groups or sets of data, and improving documentation to facilitate other institutions’ installation and use of SFM. This article will describe how the Social Feed Manager project addressed these issues, use of supervisord to manage processes, and other technical decisions made in the course of this project through late summer 2014. This article is targeted towards librarians and archivists who are interested in building collections around web archives and social media data, and have a particular interest in the technical work involved in applying software to the problem of building a sustainable collection management program around these sources.

## Introduction

Over the past two years, the George Washington University Libraries developed Social Feed Manager, a Python and Django-based application for collecting social media data from Twitter. \[[1](https://journal.code4lib.org/articles/#note1)\] The project began as a research prototype to support researchers on the GWU campus studying Twitter, replacing manual and time-consuming processes to collect and reformat data with an automated approach. Over the past year, supported by an Institute of Museum and Library Services Sparks! Ignition grant, the Libraries have refined and expanded the tool’s capacity and portability to make it useful for other institutions.  In doing so, the development team has encountered a number of technical challenges.  This paper will describe how the team handled changes in the Twitter API; meeting researcher needs for groups or sets of data; management, storage, and organization of collected data; using supervisord to manage simultaneous streaming processes; improving documentation to facilitate other institutions’ installation and use of SFM; and upcoming work on the SFM application and the integration of social media data into archival collections, descriptive standards, and policies.

## The changing Twitter API

In early 2013 Twitter changed its API in several important ways \[[2](https://journal.code4lib.org/articles/#note2)\]:

- previously, some API queries had been allowed without authentication; now all requests require authentication
- access to the easy-to-consume syndication feed format for user timelines is no longer available
- new API request rate limits were implemented across all API calls

This combination of changes might seem reasonable to a software developer. For the most part, the same information is available from the API after these changes, and adapting tools to abide by the new API was just a small matter of code.  However, to some researchers not experienced with software development, these changes made a once free-flowing source of research data much more difficult to access.

On the GW campus, for example, a faculty researcher in the School of Media and Public Affairs (SMPA) had previously studied the use of Twitter by major media outlets \[[3](https://journal.code4lib.org/articles/#note3)\].  The researcher’s workflow used prior to the API changes was to:

- identify approximately three dozen Twitter accounts of interest
- subscribe to the RSS feeds for each using Google Reader \[[4](https://journal.code4lib.org/articles/#note4)\]
- copy-and-paste individual tweets from Google Reader into spreadsheets

Although this painstaking process was suboptimal and not one the researchers wished to repeat, they were indeed able to complete their investigation with the Twitter API v1.  However, the Twitter API v1.1 deprecated the previously available RSS feeds, and the new API shifted the security model so that all calls to the API required authentication, removing the ability to anonymously request query data.

The Libraries first began working with researchers in 2012, developing methods to automate the data collection process for the researcher.  This work resulted in a script that took a list of Twitter handles as input, processed their RSS feeds, and converted the results into a CSV file for later use with Excel, Stata, or other applications familiar to social science researchers.  Upon learning of the upcoming API changes, the development team switched to using a database-backed list of handles and the easy-to-use Tweepy \[[5](https://journal.code4lib.org/articles/#note5)\] Python library for access to the Twitter API.  Among many Python libraries evaluated, Tweepy had excellent coverage of the old API and an active development branch for the new API well before Twitter disabled the old API.

The development team tested this work with a second SMPA researcher studying congressional use of social media.  The tests consisted of feeding a list of hundreds of U.S. Congress member Twitter accounts to the application prototype.  The application immediately ran into the new Twitter API rate limits.  Every Twitter API call has its own “window” of an allowable number of requests within a specific time interval; a volume of requests that exceeds this allowable number within that time interval will return Rate Limit Exceeded errors from the Twitter API.  The “GET statuses/user\_timeline” API \[[6](https://journal.code4lib.org/articles/#note6)\] call, for example, allows up to 180 requests per 15 minutes per user and up to 300 requests per 15 minutes per authorized application.  Because of this, we spread out calls to the API over time.  To make 535 calls to statuses/user\_timeline, for example, we would need to spread those calls over at least a 45-minute period, or a minimum of three rate-limit windows.

Fortunately, the Twitter API embeds rate limit information in its HTTP response headers:

- x-rate-limit-remaining: how many calls remain in the current window
- x-rate-limit-reset: when the current window resets

In SFM’s set\_wait\_time function we calculate a wait time between calls to spread requests across the remaining time in the current window, buffered by a few seconds to account for network delays and to keep our code’s use of the API gentle.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19 | `def` `set_wait_time(last_response):`  `wait_time ``=` `0`  `try``:`  `remaining ``=` `int``(last_response.getheader(``'x-rate-limit-remaining'``))`  `reset ``=` `int``(last_response.getheader(``'x-rate-limit-reset'``))`  `except``:`  `remaining ``=` `reset_seconds ``=` `1`  `if` `remaining ``=``=` `0``:`  `return` `reset_seconds ``+` `WAIT_BUFFER_SECONDS`  `else``:`  `wait_time ``=` `(reset_seconds ``/` `remaining) ``+` `WAIT_BUFFER_SECONDS`  `while` `wait_time < WAIT_BUFFER_SECONDS:`  `wait_time ``+``=` `WAIT_BUFFER_SECONDS`  `return` `wait_time` |
| --- | --- |

The development team soon learned the importance of using this function all the time; for any process that makes multiple calls to a rate-limited API like Twitter’s, skipping a step like adding a wait time between requests almost guarantees rapid exhaustion of available calls within a window.  Because of this, every function in SFM that might make repeated calls to the API uses set\_wait\_time to spread calls over time.  A side benefit of spreading out calls means that any process run will determine a wait buffer for itself based on the rate limit information in the API response, so when multiple processes are run in parallel, each will slow itself down accordingly, making it less likely that one process will starve other processes of calls within a rate limit window.

## Exporting and reformatting data for researchers

In response to requests from campus researchers, Social Feed Manager supports a number of different methods of exporting and working with the captured data.  The simplest use case is a CSV or Excel extract from raw JSON tweet data for a single Twitter user account.  Because this use case is so common, we have added CSV and Excel export links as features of the researcher UI.  Every captured Twitter account has its own page in SFM for browsing basic statistics and summaries of their captured tweets.  A campus user who has authenticated to SFM through Twitter’s authentication system can use links on that page to export the data as CSV or as Excel.  SFM responds to the link with a streamed file in an HTTP response that includes headers that should trigger a browser to open Microsoft Excel on most PCs.  Each row in the export file contains a subset of the values contained in each tweet; the subset was selected based on researcher feedback and is documented in a data dictionary. \[[7](https://journal.code4lib.org/articles/#note7)\]

In response to additional researcher requests, SFM allows two variations on the export.  Multiple Twitter accounts may be grouped into sets — for example, members of the US Congress, or individual journalists from the Washington Post, or GWU student groups — for which a single CSV or Excel extract can be generated.  However, these files can grow too large to efficiently stream via the browser, so we developed a command line function for this purpose, implemented as a Django management command.  It allows a system administrator to generate a CSV or Excel export for a given user or a named set of users, and it also allows a date range to be specified to limit the extract.  For example, some GWU researchers have wanted a one-week sampling of tweets from a set of users; the command line function, “export\_csv” \[[8](https://journal.code4lib.org/articles/#note8)\], allows us to respond to those requests quickly.

## Managing millions of tweets

SFM also provides the capability to continuously collect live tweets using the Twitter streaming API’s “statuses/filter” \[[9](https://journal.code4lib.org/articles/#note9)\] and “samplestream” commands \[[10](https://journal.code4lib.org/articles/#note10)\].  Because this can quickly amass tweets, SFM writes these tweets to files rather than storing them in the database, and CSV and Excel are no longer feasible or useful export formats.

For a Computer Science researcher, we extracted tweets that contained certain keywords for a period of several hours.  This generated millions of tweets, so rather than accumulating a small number of multi-gigabyte files, we developed a rolling file handler that starts new files at configurable intervals (defaulting to every 15 minutes).  These smaller files, with names including timestamps to differentiate them, can grow to over a dozen megabytes in size each, even when compressed, so handling storage and transfer of them requires thoughtful planning, like with any digital collection of a similar size. To arrange the files on disk, we use another command line function called “organizedata” to split the files out into a year/month/day/hour hierarchy of folders \[[11](https://journal.code4lib.org/articles/#note11)\].

When we went to transfer this data to the researcher, the data comprised multiple terabytes in this instance.  To facilitate the transfer, we took a simple path of bundling up the hierarchy of compressed files of raw tweets in JSON into a BagIt bag \[[12](https://journal.code4lib.org/articles/#note12)\], with checksums for every individual file, packaged into a single file using the Linux “tar” command. Aside from using a USB drive over sneakernet — which would have worked — we found it a modest challenge to transfer this somewhat large dataset to the researcher using a network. None of the obvious cloud-hosted file sharing platforms supported file sizes over a few terabytes, and a simple web page or bittorrent file wouldn’t help because we only wanted to deliver the file to one person. We settled for a different simple solution, using the Linux “split” command to cut the large tar file up into a handful of byte size-limited pieces, alongside additional checksums for each, and uploaded the set to cloud storage. We then shared access information, credentials, and basic instructions for file reassembly with the researcher, who found the result easy to receive and implement. It is possible that we will find this to be a common use case as we engage more often in sharing of large datasets. Some recipients will not be comfortable following a README file with sample Linux commands to run and we will need to define a smoother path for sharing large files discreetly. For now, however, this has worked well.

## Managing simultaneous streaming processes

Capturing a filtered stream of tweets from the Twitter API has important considerations: a single authorized Twitter user account may only hold one filter open at a time; a stream can generate a lot of data quickly; and streams may be interrupted. Possible interruptions include network issues, a second simultaneous stream, or other system issues like upgrades and restarts. For this reason, streams need to be regularly monitored to ensure uptime. We sought a technical approach that allowed multiple streams to be managed in parallel using different authentication parameters, with a simple strategy for separating generated files and with a long-term monitoring solution in place that enabled automated starting, stopping, and restarting of streaming as appropriate.

The development team considered writing a daemon manager suited to our particular needs, but reconsidered given the scope and scale of the project. We also considered using operating system-level tools for managing Linux initscripts, but found that to be less than ideal for two reasons: we wanted an operating SFM user such as a librarian or archivist to be able to create, start, and stop stream filters through the SFM UI, and as a userspace application we did not want the SFM process to have privileges sufficient to write, edit, delete, and restart system-level files and processes. In between these two extremes, we found a working solution in supervisord \[[14](https://journal.code4lib.org/articles/#note14)\], a process manager for users and applications, written in Python.

Use of supervisord is not required for gathering sets of individual user timelines from Twitter or even running a single filter stream. Because of this, installing and configuring supervisord is optional for all SFM users. Configuring, managing, and troubleshooting a Linux process manager arguably requires the support of a staff person with experience administering Linux systems, or at least willing to learn, because there are many things that can go wrong. Using supervisord requires careful configuration of system scripts, users, and permissions, along with its own application-level configuration with scripts, users, and permissions.  Even so, with careful attention to the documentation \[[15](https://journal.code4lib.org/articles/#note15)\] many SFM users should be able to get up and running with supervisord and to use it to capture multiple parallel streams.

When correctly configured, the supervisord-managed approach works well. A non-technical staff member using SFM can log in to SFM’s administration UI, add a new TwitterFilter \[[16](https://journal.code4lib.org/articles/#note16)\], and SFM will generate a supervisord configuration file for the filterstream command with the correct user information for authorization. Supervisord will start a process immediately, storing streamed tweet data in a directory set aside for this TwitterFilter using the SFM database id of the TwitterFilter in the name of the configuration file and the name of the directory (e.g. “twitterfilter-12”) to contain captured tweet files. That same staff member can also deactivate, reactivate, or delete TwitterFilters just as easily through the UI, triggering backend calls to supervisord to stop, restart, or remove processes and their configuration. These backend calls to supervisord are remote procedure calls made using the Python XML-RPC implementation \[[17](https://journal.code4lib.org/articles/#note17)\].  We expect that this feature will be particularly useful for rapidly responding to researchers’ requests to capture an ongoing flow of tweets in real-time.

A potential benefit of having supervisord in place is to manage additional process types. We plan to add features to post-process media content such as images, videos, and web pages, as well as add other social media platforms, and anticipate that a supervisord-managed process will be a good fit for one or more of these new tasks.

## **Supporting other users and building community**

In addition to making the app available via GitHub, we have worked to make it more readily usable by other cultural heritage organizations. At several points in the past year (e.g. a December 2013 grant-funded meeting with developers and librarians, a March 2014 code4lib preconference workshop, and in one-on-one support for potential users) we were able to  assist others installing the app and observe pitfalls in the installation process. These interactions have allowed us to identify problems that users may encounter in setting up the app and motivated us to expand and iteratively improve the documentation. Other ways we have sought feedback on SFM have included structured interviews with current and potential users and interactions on our sfm-dev Google group \[[18](https://journal.code4lib.org/articles/#note18)\].

We also recognized that documentation serves a purpose in developing buy-in and understanding for SFM; collecting Twitter data is a new activity for most cultural heritage organizations. The documentation enumerates the app’s possible uses and describes both staffing and technical considerations in embarking on collecting Twitter data.

We used the readthedocs.org as a platform for documentation: it is widely used, has a clean interface, and integrates with the code itself.  Docs are formatted in reStructured Text (reST) \[[19](https://journal.code4lib.org/articles/#note19)\] and stored in the git repository itself in a docs directory. Anyone may fork the repository and submit pull requests suggesting improvements to any of the docs, just as one would submit pull requests with changes to the code.

## **Next steps**

Over the next three years, supported by a grant from the National Historic Publications and Records Commission, \[[20](https://journal.code4lib.org/articles/#note20)\] we will continue our work on SFM with overall goals of improving our service to the GWU community and in building collections in GW Libraries.  In particular, we intend to add support for more platforms in addition to Twitter, including at least Flickr and Tumblr, and others as demand requires and time allows. In addition, we plan to consider the integration of social media data into archival collections, including the full workflow of selection, transfer, accessioning, processing, describing, and enabling access. Along this path we expect to evaluate opportunities for integration with existing descriptive standards and foundational strategies, as well as developing new policies as required.

As part of this work we are looking to expand the notion of what we can collect from just one user or set of users’ tweets to a more robust notion of “correspondence”, including replies, mentions, comments, and other interactions present on different platforms. We seek to add the ability to capture more media types such as images, videos, and web pages referenced in tweets. At the same time, we will consider system strategies for accomplishing these tasks across platforms, integrating collected media with existing special collections, descriptive metadata environments, and media gathered via web archiving. Throughout this work we will continue to manage issues and milestones for SFM using the GitHub repository, and we will update documentation with each new release. We welcome feedback via comments, tickets, or pull requests in the github repository, or via email to the development list \[[21](https://journal.code4lib.org/articles/#note21)\].

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\]  Social Feed Manager is a free and open source software application, available at [https://github.com/gwu-libraries/social-feed-manager/](https://github.com/gwu-libraries/social-feed-manager) with documentation at  [http://social-feed-manager.readthedocs.org/](http://social-feed-manager.readthedocs.org/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] “Changes coming in Version 1.1 of the Twitter API”, [https://blog.twitter.com/2012/changes-coming-to-twitter-api](https://blog.twitter.com/2012/changes-coming-to-twitter-api)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Jesse Holcomb, Kimberly Gross and Amy Mitchell. 2011. “How Mainstream Media Outlets Use Twitter.”  Report from Project for Excellence in Journalism. [http://www.journalism.org/2011/11/14/how-mainstream-media-outlets-use-twitter/](http://www.journalism.org/2011/11/14/how-mainstream-media-outlets-use-twitter/)

\[[4](https://journal.code4lib.org/articles/#ref4)\] Google Reader ([https://www.google.com/reader/](https://www.google.com/reader/)) was an RSS/Atom feed aggregator which was discontinued as of July 1, 2013.  Although alternatives exist, the once-ubiquitous “feed reader” model popular for many years has now waned.

\[[5](https://journal.code4lib.org/articles/#ref5)\] [http://www.tweepy.org/](http://www.tweepy.org/)

\[[6](https://journal.code4lib.org/articles/#ref6)\] [https://dev.twitter.com/docs/api/1.1/get/statuses/user\_timeline](https://dev.twitter.com/docs/api/1.1/get/statuses/user_timeline)

\[[7](https://journal.code4lib.org/articles/#ref7)\] [http://social-feed-manager.readthedocs.org/en/m5\_002/data\_dictionary.html](http://social-feed-manager.readthedocs.org/en/m5_002/data_dictionary.html)

\[[8](https://journal.code4lib.org/articles/#ref8)\] [http://social-feed-manager.readthedocs.org/en/m5\_002/mgmt\_commands.html#export-csv](http://social-feed-manager.readthedocs.org/en/m5_002/mgmt_commands.html#export-csv)

\[[9](https://journal.code4lib.org/articles/#ref9)\] [https://dev.twitter.com/docs/api/1.1/post/statuses/filter](https://dev.twitter.com/docs/api/1.1/post/statuses/filter)

\[[10](https://journal.code4lib.org/articles/#ref10)\] [https://dev.twitter.com/streaming/reference/get/statuses/sample](https://dev.twitter.com/streaming/reference/get/statuses/sample)

\[[11](https://journal.code4lib.org/articles/#ref11)\] [http://social-feed-manager.readthedocs.org/en/m5\_002/mgmt\_commands.html#organizedata](http://social-feed-manager.readthedocs.org/en/m5_002/mgmt_commands.html#organizedata)

\[[12](https://journal.code4lib.org/articles/#ref12)\] [http://en.wikipedia.org/wiki/BagIt](http://en.wikipedia.org/wiki/BagIt)

\[[13](https://journal.code4lib.org/articles/#ref13)\] [http://social-feed-manager.readthedocs.org/en/m5\_002/mgmt\_commands.html#filterstream](http://social-feed-manager.readthedocs.org/en/m5_002/mgmt_commands.html#filterstream)

\[[14](https://journal.code4lib.org/articles/#ref14)\] [http://supervisord.org/](http://supervisord.org/)

\[[15](https://journal.code4lib.org/articles/#ref15)\] [http://social-feed-manager.readthedocs.org/en/m5\_002/supervisor\_and\_streams.html](http://social-feed-manager.readthedocs.org/en/m5_002/supervisor_and_streams.html)

\[[16](https://journal.code4lib.org/articles/#ref16)\] In SFM, a TwitterFilter contains the query predicates with which to call the Twitter “statuses/filter” API \[[10](https://journal.code4lib.org/articles/#note10)\]\]; these predicates may include keywords, geospatial regions, and/or usernames.

\[[17](https://journal.code4lib.org/articles/#ref17)\] [https://docs.python.org/2/library/xmlrpclib.html](https://docs.python.org/2/library/xmlrpclib.html)

\[[18](https://journal.code4lib.org/articles/#ref18)\] [https://groups.google.com/forum/#!forum/sfm-dev](https://groups.google.com/forum/#!forum/sfm-dev)

\[[19](https://journal.code4lib.org/articles/#ref19)\] [http://docutils.sourceforge.net/rst.html](http://docutils.sourceforge.net/rst.html)

\[[20](https://journal.code4lib.org/articles/#ref20)\] NHPRC award number NAR14-DI-50017-14: “Building Social Media Collections: Tools and Policy Recommendations for Collection Development and Management”

\[[21](https://journal.code4lib.org/articles/#ref21)\] [https://groups.google.com/forum/#!forum/sfm-dev](https://groups.google.com/forum/#!forum/sfm-dev)

## **Acknowledgements**

This project was made possible in part by the Institute of Museum and Library Services Sparks! Ignition grant LG-46-13-0257.

## **About the Authors**

Daniel Chudnov is Director, Scholarly Technology at the George Washington University Libraries, where he supervises library staff working in software and systems development and operations. He holds degrees from the University of Michigan, and is pursuing an additional master’s degree in Business Analytics at George Washington University.

Daniel Kerchner is a Senior Software Developer on the Social Feed Manager project as well as other digital initiatives and open source projects.  He is a certified Project Management Professional and holds degrees from Cornell University and the University of Virginia.

Ankushi Sharma is a Masters student in the Department of Computer Science at the George Washington University. She is a software developer on the Social Feed Manager project, and was recently awarded a scholarship from the Anita Borg Institute to attend the Grace Hopper Celebration of Women in Computing.

Laura Wrubel is the E-Resources Content Manager at the George Washington University Libraries and is responsible for access to library e-resources. She holds an MLS from the University of Maryland.
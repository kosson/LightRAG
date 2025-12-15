---
title: "Reaching Users Through Facebook:  A Guide to Implementing Facebook Athenaeum"
source: "https://journal.code4lib.org/articles/490"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-12-15
created: 2025-01-10
description: "Facebook Athenaeum is an open source application that integrates library resources directly into the Facebook website. Facebook is one of the single most-visited websites in the world, and its popularity among college-aged students provides a unique opportunity for libraries to redefine how they interact with students. This article walks you through the deployment of Facebook [...]"
tags:
  - "clippings"
---
# Reaching Users Through Facebook:  A Guide to Implementing Facebook Athenaeum
Wayne Graham

Facebook Athenaeum is an open source application that integrates library resources directly into the Facebook website. Facebook is one of the single most-visited websites in the world, and its popularity among college-aged students provides a unique opportunity for libraries to redefine how they interact with students. This article walks you through the deployment of Facebook Athenaeum, and discusses some of the usage trends and pitfalls of deploying applications using the Facebook API.

## Introduction

In 2007, Facebook was positioning itself to overtake MySpace as the number one social website. Until this point, Facebook had only been available to higher-education institutions, but they were in the process of opening the site up to all users and rolling out an API to allow developers to create “useful” applications. Seeing an opportunity to provide our own “useful” social application, we set out to integrate an existing tool developed by Tom MacWright, a student at William and Mary, with our library’s RSS feeds and catalog/website search.

MacWright developed a nifty little application that allows users to click on a map of the library and generate an IM status link (or anything else that accepted a hyperlink) so your friends could see where you were located  ([http://swem.wm.edu/services/swemsignal/](http://swem.wm.edu/services/swemsignal/)). Swem Signal was used by quite a few students, and we even got the code donated to the library to run on our servers. After the Facebook API launched, we thought Swem Signal would be a really cool social feature to integrate into a library Facebook application. The real impetus, however, was to expose our search tools to users who may spend more time socializing than studying.

![Facebook Athaneum page](https://journal.code4lib.org/media/issue5/graham/fb_search_small.png)

**Figure 1:** Facebook Athaneum main page \[[view larger](https://journal.code4lib.org/media/issue5/graham/fb_search.png)\]

## How Do Facebook Applications Work?

Facebook applications are a little different from other online applications in that they live on two different servers. You host the application on your own server, which is responsible for the business logic of your application, and Facebook’s servers work with the user’s profile. When a user interacts with your application, Facebook interprets the request and passes it to your server. Your pages are constructed with FBML (Facebook Markup Language), a superset of HTML, to pass back to the Facebook server farm. Facebook interprets the FBML response from your server and generates the resulting page the user sees.

![Facebook Athaneum page](https://journal.code4lib.org/media/issue5/graham/processing.png)

**Figure 2:** Facebook page processing

## Server Set Up

So, what do you need to get going? Facebook Athenaeum uses the [PHP Facebook client libraries](http://wiki.developers.facebook.com/index.php/Client_Libraries) for interacting with Facebook profiles; a database server (for storing Cartesian coordinates); [Smarty](http://www.smarty.net/) for creating the display; and the [PEAR DB](http://pear.php.net/package/DB) modules \[[1](https://journal.code4lib.org/articles/#note1)\] and [XML\_RSS](http://pear.php.net/package/XML_RSS) packages for interacting with the database backend and reading any RSS feeds you may have. Floor maps of your building are really handy and they can be in whatever image format is most convenient for you. The official libraries provided by Facebook are in PHP and Java, but there are unofficial libraries for most popular web and application programming languages, so if you are using a different web platform, you can very quickly migrate the code to your local environment. You can find links to all the client libraries on the [Facebook Developer Wiki](http://wiki.developers.facebook.com/index.php/Client_Libraries). Additionally, there are convenient, unofficial, Facebook library implementations in PEAR (pear install Services\_Facebook) and RubyForge (gem install rfacebook).

I have made some assumptions in these instructions, first that you’re running a \*nix system, that you have permissions to install software on the server, and you have PHP, PEAR, and wget installed. This is not to say you cannot run this on the Windows server, but you will need to manually install the dependencies. I will do my best to note the software you will need and where to get further instructions when needed.

### Setting up Smarty and PEAR Modules

To make things go a little easier, we wrote a Bash script for \*nix users that will download Smarty, extract it, and put it in the PHP include path and then update PEAR and install the DB and XML\_RSS packages with their required dependencies. This script is included in the Facebook Athenaeum source code.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27 | `#! /bin/bash`  `` PHPDIR=`pear config-get php_dir` ``  `SMARTY_VER=``"Smarty-2.6.20"`  `SMARTYDIR=``"$PHPDIR/Smarty"`  `if` `[ ! -d $SMARTYDIR ]`  `then`  `echo ``"Downloading Smarty..."`  `wget http:`  `echo ``"Extracting Smarty"`  `tar -zxf $SMARTY_VER.tar.gz`  `echo ``"Moving Smarty to $SMARTYDIR"`  `mkdir $SMARTYDIR`  `mv $SMARTY_VER/libs/* $SMARTYDIR`  `echo ``"Cleaning up..."`  `rm $SMARTY_VER.tar.gz`  `rm -rf $SMARTY_VER`  `fi`  `## Install PEAR packages`  `echo ``"Updating PEAR packages"`  `pear upgrade pear`  `pear install --onlyreqdeps DB`  `pear install --onlyreqdeps XML_RSS` |
| --- | --- |

This script was updated in November of 2008. You may need to check to make sure you are getting the latest version by visiting the Smarty website ([http://www.smarty.net/download.php](http://www.smarty.net/download.php)). If the version changes, just change the SMARTY\_VER line to the correct version and then run the script.

Note: If you are running Windows, you will need to manually install Smarty and the PEAR modules. To install Smarty, refer to [http://news.php.net/php.smarty.dev/2703](http://news.php.net/php.smarty.dev/2703) for detailed instructions. Assuming you have correctly installed PEAR on Windows (there is a convenient MSI installer), you will also need to run the pear lines from the above script (e.g. pear install –onlyreqdeps DB XML\_RSS).

### Get the Source Code

Now that you have retrieved the dependencies, it is just a matter of setting up your web environment. You can do this by simply setting up a folder in your web directory (e.g. /var/www/facebook) or creating an alias in your Apache configuration. Download the files from the Google Code site ([http://code.google.com/p/facebook-athenaeum/downloads/list](http://code.google.com/p/facebook-athenaeum/downloads/list)) and unpack them into the location you want the files. If you are comfortable with working with the development code, you can just check out the trunk.

Note: If you’re on a \*nix web server, you will need to change the permissions on the cache and compile directories to give write access to the web server.

| 1  2  3  4 | `chown nobody:nobody /path/to/facebook-athenaeum/cache`  `chown nobody:nobody /path/to/facebook-athenaeum/compile`  `chmod 775 /path/to/facebook-athenaeum/cache`  `chmod 775 /path/to/facebook-athenaeum/cache` |
| --- | --- |

## MySQL Setup

Facebook Athenaeum includes scripts for creating a MySQL database, but since the code uses the PEAR DB library it should work with any database system that PEAR DB supports. You will just need to write the SQL to create the locations table. To aid with this, I wrote a basic SQL-99 compliant SQL script for those wanting to use an alternative relational database management system.

| 1  2  3  4  5  6  7  8 | `CREATE` `TABLE` `locations(`  `uid ``INT` `NOT` `NULL``,`  `x ``INT``,`  `y ``INT``,`  `floor ``INT``,`  `updated DATETIME ``NOT` `NULL``,`  `PRIMARY` `KEY``(uid)`  `)` |
| --- | --- |

As you can see, there is not much to the table: it just stores some very basic information about what image was used and the Cartesian coordinates set by the user. We did write a helper script for those running MySQL on \*nix (mysql\_helper.sh) to make this as easy as possible. You can also just create the database and table through whatever convenient tool you have available. Whatever method you decide to use, just be sure to note your settings for the configuration file.

Note: If you do write a table definition for an alternative database system, be sure to make a patch and submit it to the project ([http://code.google.com/p/facebook-athenaeum/issues/list](http://code.google.com/p/facebook-athenaeum/issues/list)).

## Facebook Setup

Now that the necessary server libraries and source code are in place, you need to tell Facebook about your application. This, unfortunately, is a multi-step process. You first need to add the Facebook Developer application to your account (accessible at [http://www.facebook.com/developers/](http://www.facebook.com/developers/)). Once installed, click on the “+Set Up New Application” button to start the process.

![Submit to Facebook image](https://journal.code4lib.org/media/issue5/graham/fb_new_app.png)

**Figure 3:** Set Up New Application detail

You will be prompted to give your application a name. Just remember, you can’t have the word “face” anywhere in the name (not even something like “surface”). After you read the terms for the Facebook Platform ([http://www.facebook.com/developers/tos.php](http://www.facebook.com/developers/tos.php)), expand the Optional Fields.

![Facebook options page image](https://journal.code4lib.org/media/issue5/graham/fb_option_small.png)

**Figure 4:** Facebook Optional Fields detail \[[view larger](https://journal.code4lib.org/media/issue5/graham/fb_option.png)\]

At this point, you just need to set the Callback URL (the URL of the application you have set up on your server, e.g. http://library.myuniversity.edu/facebook) and the Canvas Page URL (the Facebook URL for the application, e.g. YourLibraryAthenaeum). If you make a mistake or change your mind, you can always go in and change these fields later from the Develop Application in Facebook.

Once you have finished the wizard, you will be directed to the Application manager for the Facebook application you just created. On this screen, you will need to note the API Key and Secret for the configuration file on your server.

## Application Setup

With all the preliminaries out of the way, it is time to finish setting up your instance of Facebook Athenaeum. In the configurations folder on your web server, there is a file named config.inc.php that you need to edit. Just add your Facebook API Key, Secret, Callback URL and Canvas URL.

Next, edit the DSN settings for your host. You will need to provide the host, user, password, and database for PEAR DB to make the connection. Again, this should work for database systems other than MySQL, but you will need to reference the PEAR DB ([http://pear.php.net/package/DB/docs/latest/DB/DB.html](http://pear.php.net/package/DB/docs/latest/DB/DB.html)) documentation to make sure the required values are passed to the constructor.

The next section lets you set up the application customizations. You can name the application whatever you would like, and if you have an RSS feed, you can add that into the feed\_url variable. In our configuration, we use this to show the current news feed for our library. The app\_dir is also pretty straightforward–it is just the absolute path to where your application lives on the server.

Now comes the part that can give some headaches. We use a Google mini appliance at our library. The Google mini is a great appliance and has the ability to produce search results in XML format. \[[2](https://journal.code4lib.org/articles/#note2)\] This allows us to use a Facebook Ajax call to pull the search results into the Facebook application rather than kick them out to another server. For our database and catalog searches, we actually use a query evaluator to funnel the search into the correct server. You may find yourself needing to refactor this code a bit, but it should be a pretty quick process. And to answer your question, yes, we do plan to make this easier in the future. The rest of the configuration file should be relatively self-explanatory, but I will key you in on one last item.

Facebook Athenaeum also integrates with Google Analytics ([http://analytics.google.com](http://analytics.google.com/)) by using the GOOGLE\_ANALYTICS\_KEY. The statistics Facebook offers are pretty light and Google Analytics will give you “better” usage statistics.  You just need the key, which looks like “UA-nnnnnnn-n”. You cannot directly copy from the Analytics page as Google wants you to copy the entire code block. You can either write the key down, or paste the contents of the code block in a text editor and then copy just the key.

## The Map

Fortunately for us, we had a set of floor plans from our recent building renovation.

![Facebook options page image](https://journal.code4lib.org/media/issue5/graham/fb_set_location_small.png)

**Figure 5:** Facebook page with Friend Locator, including floor plan \[[view larger](https://journal.code4lib.org/media/issue5/graham/fb_set_location.png)\]

If you’re lucky, you too already have a set of nice floor plans to use for your Facebook application. If not, this becomes a slightly bigger project, but basically you need to generate an image format that is easily read by browsers (e.g. gif, png, jpeg, etc.). For ease-of-coding/lazy reasons, we named the images 0-3 of our different floors so they will map easily map to the array. Each floor gets a label and a message. The message is just the text that gets displayed when the user wants the application on their profile page.

If all went well, everything is configured now and ready for testing. To add the application to your profile, visit your application’s Canvas page (e.g. http://apps.facebook.com/YOUR\_APP\_NAME). You will be prompted to give several permissions to the application from your profile. Once you Click on “Allow,” you can start using the application.

## Publishing

When you have worked out any issues you may encounter and have finished adding any additional functionality you may need (and please post any patches to the project page at [http://code.google.com/p/facebook-athenaeum/issues/list](http://code.google.com/p/facebook-athenaeum/issues/list)), you are ready to publish the application in Facebook and start letting “friends” know how to use it. Publishing an application in Facebook’s Application Directory ([http://www.facebook.com/apps/](http://www.facebook.com/apps/)), requires five people to first add the application to their profile. Hopefully you have some Facebook friends who will help you out. To actually submit the application for listings approval, log on to Facebook and go to Developer Application (should be on the right-hand side of the screen). Go into your application, where you will find a tiny link under Directory Status to submit it to the product directory.

![Submit to Facebook image](https://journal.code4lib.org/media/issue5/graham/submit_to_facebook.png)

**Figure 6:** Submit to Facebook screen detail

Finish filling out the form and click Save. It can take some time (usually two to three business days) for the approval process to go through because someone actually looks at every application before it gets listed. Once added to the directory, Facebook users will then be able to discover your application through the search interface.

### Final Housekeeping

You also will want to develop the content on your application’s About page. This is the page that people can use to become “fans” and allow you to interact with your users (at least those who choose to interact on the page). You can get to the About page from the Developer application. Just go into your application and click on Edit About Page.

![About Page image](https://journal.code4lib.org/media/issue5/graham/about_small.png)

**Figure 7:** Facebook Atheneum About Page \[[view larger](https://journal.code4lib.org/media/issue5/graham/about.png)\]

Edit the appropriate sections you want to have appear. This is a convenient page to subsequently interact with your users (or at least the ones that become Fans of the application).

## Getting Help

There are two Google groups set up in case you run into a problem with Facebook Athenaeum. The groups are listed off the main project page ([http://code.google.com/p/facebook-athenaeum/](http://code.google.com/p/facebook-athenaeum/)). If you need some help in tweaking the application, you can also consult the Facebook Developer wiki ([http://wiki.developers.facebook.com/index.php/Main\_Page](http://wiki.developers.facebook.com/index.php/Main_Page)).

## Conclusion

### Road Map

What does the future hold for Facebook Athenaeum? Well, one of the features we want to work on is integrating with VuFind ([http://www.vufind.org](http://www.vufind.org/)) to pull search results from VuFind into the Facebook application. As VuFind grows to enable libraries to index and search more diverse content types (it currently supports indexing MARC content), all of this will also be directly available through Facebook. The other big item on the roadmap is to migrate the database storage from a relational database system to Facebook’s Data Store API. This will allow you to keep most of the user interactions directly on Facebook’s cloud, decreasing the number of resources this application consumes.

### Usage

Swem Library has  been running its SwemTools application for over a year now. We currently have 481 users who have installed the application, with about 40 monthly users (a little less than 10% usage).  Doing a little poking around, there seem to be a large percentage of Facebook applications that hover around this threshold. We realized when evaluating our application usage that we experienced a phenomenon where there are a lot of initial additions immediately after publicity of the application, and then a sharp drop off in usage.

When we set out to develop this project, I will candidly say we did not exactly know what to expect–we were really just testing out this new platform and wrote what we thought would be cool and tried to make it useful. As we progressed, we started to think more about what criteria we might use to evaluate the effectiveness of this project. We realized we are really trying to reach an audience that is more comfortable interacting on Facebook than the online catalog; a group that perhaps is not always effectively reached by traditional library outreach. What we have found is that there has been sustained, long-term usage of the application, with little if any prodding from us. The fact that these users are coming and using the application shows that there is at least a perceived usefulness in the application from users.

So, should your library have a presence in Facebook? I am perhaps biased, but I think the site provides a unique opportunity for libraries to redefine how they interact with students and how libaries can facilitate the interaction between students. I’ll be quite honest though, when the Facebook site first launched and I created my account, I really did not see what the point was, and I know I am not the only one who had this reaction. What brought me around was seeing just how many students actually use the site on a daily basis. Being able to interact with these students on a platform they are comfortable with seemed like a natural extension of what the library has traditionally done in developing its web content and outreach activities. We have further found that when we advertise an event on Facebook, we get far more participation than we do through posters, news feeds, and other outlets.

## Additional Resources

- Dia ([http://projects.gnome.org/dia/](http://projects.gnome.org/dia/))
- Facebook Athenaeum ([http://code.google.com/p/facebook-athenaeum](http://code.google.com/p/facebook-athenaeum))
- Facebook Client Libraries ([http://wiki.developers.facebook.com/index.php/Client\_Libraries](http://wiki.developers.facebook.com/index.php/Client_Libraries))
- Google Analytics ([http://analytics.google.com](http://analytics.google.com/))
- Gimp ([http://www.gimp.org/](http://www.gimp.org/))
- PEAR DB ([http://pear.php.net/package/DB](http://pear.php.net/package/DB))
- PEAR XML\_RSS ([http://pear.php.net/package/XML\_RSS](http://pear.php.net/package/XML_RSS))
- MySQL ([http://www.mysql.com/](http://www.mysql.com/))
- Smarty ([http://www.smarty.net/](http://www.smarty.net/))
- Subversion ([http://subversion.tigris.org/](http://))

## Notes

[\[1\]](https://journal.code4lib.org/articles/#note1) The PEAR DB Package has been deprecated. Instead of migrating the code to the MDB2 library, we plan to move the backend to use the Facebook Data API.

[\[2\]](https://journal.code4lib.org/articles/#note2) For a more in-depth analysis of leveraging the Google Mini, see: Edwin Burgess and Edward Metz, “Applying Google Mini search appliance for document discoverability.” *Online* 32, no. 4 (July 2008): 25-27. [(COinS)](https://journal.code4lib.org/coins)

## About the Author

Wayne Graham is the Coordinator of Emerging Technology at the Earl Gregg Swem Library at the College of William and Mary. He is the author of *Facebook API Developer’s Guide* (APress, 2008) and contributes code to the [Vufind](http://www.vufind.org/) and [Solrmarc](http://code.google.com/p/solrmarc) projects. Wayne occasionally blogs at [http://www.liquidfoot.com](http://www.liquidfoot.com/), and you can always shoot him a note on [Facebook](http://www.facebook.com/profile.php?id=7608007).
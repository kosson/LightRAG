---
title: "Using a Raspberry Pi as a Versatile and Inexpensive Display Device"
source: "https://journal.code4lib.org/articles/8644"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-07-18
created: 2025-01-10
description: "This article covers the process by which a library took some unused equipment and added a cheap computing device to produce very inexpensive but effective electronic signage. Hardware and software issues as well as a step-by-step guide through the process are included."
tags:
  - "clippings"
---
# Using a Raspberry Pi as a Versatile and Inexpensive Display Device
Edward Iglesias, Arianna Schlegel

This article covers the process by which a library took some unused equipment and added a cheap computing device to produce very inexpensive but effective electronic signage. Hardware and software issues as well as a step-by-step guide through the process are included.

Libraries are always short of money but rich in talent. As more recent graduates are not afraid to code–and perhaps even modify existing hardware–possibilities open. Such was the case when the Burritt Library needed a display device and did not want to pay a large amount of money for a commercial solution. We looked at a few of the options available but decided to roll our own solution using a cheap computing device called the Raspberry Pi.

The Raspberry Pi is a $35 computer running a stripped down version of Linux. It is very bare bones and does not come with a keyboard, power supply or display device. Fortunately we had all of these things lying around in the form of an old monitor, keyboard and mouse. A 5 volt power supply was scavenged from an old cell phone and in the end all we had to purchase was the Pi itself, an HDMI cable for the monitor and an SD card for the operating system.

[![Figure 0. Pi vs. Pen](https://journal.code4lib.org/media/issue21/iglesias/figure0.jpg)](https://journal.code4lib.org/media/issue21/iglesias/figure0.jpg)

**Figure 0.** Pi vs. Pen

Setting up the operating system (OS) is straightforward for anyone who has ever burned a Linux distribution onto a CD. You will need a card reader. Using the built in dd tool it was a simple matter to burn the OS onto the card.

Using the Raspberry Pi and some custom PHP on a website, we came up with a solution that cost approximately $50.00 plus time. As a comparison, a typical commercial solution starts at around $900.00 for something like this which is set up at our local coffee house.

[![Figure 1. Coffeehouse Display](https://journal.code4lib.org/media/issue21/iglesias/figure1.jpg)](https://journal.code4lib.org/media/issue21/iglesias/figure1.jpg)

**Figure 1.** Coffeehouse Display

## The Problem

In the spring of 2012 the Burritt Library started checking out Kindle readers for ebooks. This was only a pilot project with 5 readers but proved wildly successful. As a result students were often asking whether there were any Kindles available. For some reason they did not think to check the online catalog first. The Circulation Department needed a way to display how many Kindles were available for checkout.

[![Figure 2. Caption](https://journal.code4lib.org/media/issue21/iglesias/figure2.jpg)](https://journal.code4lib.org/media/issue21/iglesias/figure2.jpg)

**Figure 2.** Initial Raspberry Pi Setup

## The Solution

The newly released Raspberry Pi. This is a small $35 – $40 computer that can be loaded with a special distribution of the Linux OS (in this case Raspian) and can be used as a normal computer or hooked up to a breadboard (a physical board for prototyping electronic projects) for use with physical sensors. Since the distribution already came with a browser the idea emerged that by placing the computer hooked up to a monitor in a location at Circulation the browser could be set to a web page that auto-updates. Additionally, since the computer could be set to automatically log in and launch the browser in kiosk mode at startup there would be no need for a mouse or keyboard.

[![Figure 3. Kindle Counter Display](https://journal.code4lib.org/media/issue21/iglesias/figure3.jpg)](https://journal.code4lib.org/media/issue21/iglesias/figure3.jpg)

**Figure 3.** Kindle Counter Display

## The Process

The project was divided between the two authors with Iglesias taking care of the physical hardware and formatting of the Pi while Schlegel took care of the PHP scripting that would scrape the catalog to display the item status.

### Raspberry Pi Customization

In order for the display to be as low maintenance as possible, several settings had to be adjusted.

- The login sequence had to be changed so that no login was required.
- The boot sequence had to be changed so that upon startup the X environment (the graphical environment in Linux that lets you run browsers and other software) was started.
- The default browser for Raspian, Midori, had to be invoked on startup and set to go to a particular site and stay there in full screen or kiosk mode.
- The energy saving sequence that blanked out the screen after a set period of time had to be disabled.

At the time we worked on this project it was a long process to set up the Pi so that it would start up and log into the graphical interface without a password. Recent distributions of Raspian have simplified this process. The Raspberry Pi configurator launches the first time you boot up and can be summoned at any time by opening a terminal window and typing in

This allows you to simply select an option that boots the Pi into the graphical interface under the section “boot\_behaviour”. After this a very small script must be written that will invoke the browser and point it at the desired website. Just open an editor at the command line and create a file called start.sh in your home directory such as

In this file you need only two lines. The first tells the script where to call the command from and the second invokes midori in “Fullscreen” mode and goes to the URL you define.

| 1  2 | `#!/usr/bin/sh`  `midori -e Fullscreen -a www.library.ccsu.edu``/kindlecounter` `&` |
| --- | --- |

After this make your script executable

| 1 | `sudo` `chmod` `+x ``/home/pi/start``.sh` |
| --- | --- |

and add your script to your LXDE autostart file

| 1 | `sudo` `nano ``/etc/xdg/lxsession/LXDE/autostart` |
| --- | --- |

Be sure to use sudo before trying to edit this file. At the bottom of the file add the line

Finally there was the problem of the screen not blanking out. The solution was found on a discussion on StackExchange which involved the installation of the x11 server utilities. These are a group of tools which let you control among other things when a screen goes blank. To install these tools go to the command line and type in

| 1 | `apt-get ``install` `x11-xserver-utils` |
| --- | --- |

Then it is simply a matter of editing the autostart file with

| 1 | `sudo` `nano ``/etc/xdg/lxsession/LXDE/autostart` |
| --- | --- |

Next, uncomment the @xscreensaver line in the following code block:

| 1  2  3  4  5  6  7 | `@lxpanel --profile LXDE`  `@pcmanfm --desktop --profile LXDE`  `@xset s off`  `@xset -dpms`  `@xset s noblank`  `@sh ``/home/pi/start``.sh` |
| --- | --- |

More details can be found at [http://raspberrypi.stackexchange.com/questions/752/how-do-i-prevent-the-screen-from-going-blank](http://raspberrypi.stackexchange.com/questions/752/how-do-i-prevent-the-screen-from-going-blank).

At this point the Pi should be able to be unplugged and replugged and automatically launch the browser with the specified target webpage.

### Software

The software part of this project is pretty painless and quick. Additionally, it can be extrapolated to so many other uses! We are already considering setting up boards to display library announcements, notices, etc.

[![Figure 4. The original Kindle Counter Screen](https://journal.code4lib.org/media/issue21/iglesias/figure4.jpg)](https://journal.code4lib.org/media/issue21/iglesias/figure4.jpg)

**Figure 4.** The original Kindle Counter Screen

For now, however, we have just what we call the “Kindle Counter.” To see a working example of the page, please visit: [http://library.ccsu.edu/kindlecounter](http://library.ccsu.edu/kindlecounter). (This soon will be changing to accommodate a split-screen view which incorporates a “laptop counter,” as well, but the basic work is all the same. The original page will be saved and perpetually available at: [http://library.ccsu.edu/kindlecounter/justkindle.php](http://library.ccsu.edu/kindlecounter/justkindle.php).)

To begin, we had to figure out how we wanted to read the information from the page. The library’s Kindle holdings are listed at [http://www.consuls.org/record=b3315628~S16](http://www.consuls.org/record=b3315628~S16), so we needed some way of scraping that page to read the current status of each item. The page updates immediately upon item processing, so we knew we could get current information from there, without having to figure out some way of getting access to our ILS and trying to read the status from the database. (A reminder: Do use your catalog’s persistent link functionality for this project!)

We opted to use PHP for screen scraping, following the instructions at [http://www.dmxzone.com/go/4402/page-scraping/](http://www.dmxzone.com/go/4402/page-scraping/). We relied heavily on this page as a jumping off point, ensuring we could successfully execute a scrape with the sample code before making the transition to our own site.

We needed the code to indicate how many Pis were available for checkout, so we decided that the best option would be to sum up the number of times that the two phrases which indicated availability – “Available” and “Recently Returned” – occurred on the page:

| 1  2 | `$numavail` `= substr_count(``$file``, ``"AVAILABLE"``);`  `$numrr` `= substr_count(``$file``, ``"Recently Returned"``);` |
| --- | --- |

Originally, of course, we were simply displaying formatted text. But we wanted something that looked better – so we decided to create images of each number and store them on the web server. This was easy for us, because we currently only have 4 Kindles – it might become quite time-intensive if you are looking at dozens or hundreds of items. We originally tried using Google Fonts, but found that automatic page refreshes caused the page to flicker too much. Switching to images which resided on our web server resolved that issue. It was a simple matter of an if/else statement to check the current number of Kindles available, then choose which image to display:

| 1  2  3  4  5  6 | `$maxkindles` `= 4;`  `if` `(``$totnumavail` `<= ``$maxkindles``) {`  `print` `'<img alt="" src="img/kindle" . $totnumavail . ".jpg"  />'``;`  `} ``else` `{`  `print` `'<img alt="" src="img/kindle0.jpg" />'``;`  `}` |
| --- | --- |

And lastly, because we wanted the Kindle Counter to be entirely autonomous, we had to make the page refresh itself – and do so regularly, so that we had a real-time display for anyone interested in whether there were any Kindles available. We opted to go with this refresh:

| 1  2  3  4 | `<``head``>`  `<``meta` `http-equiv``=``"refresh"` `content``=``"5"` `>`  `</``head``>` |
| --- | --- |

and chose to set it to refresh every 5 seconds. This was enough that the update seemed almost immediate (we were told our circulation staff enjoyed scanning the Kindles in and out to watch the number change when the Counter was first set up at our desk!) but wasn’t too flickery (it does occasionally flash, but it doesn’t seem to be a problem).

## Conclusion

Ths project provided numerous opportunities for the staff working on it as well as the library. By pushing ourselves to learn to make a solution rather than buy one the staff was able to acquire and use new skills that will doubtless prove useful in the future. Additionally the cost and customizability would not have been possible otherwise. As we move forward with plans to create a makerspace in the library this has become a first step towards creating a maker culture in the library. Finally the screen has proven wildly successful and we have had requests for more of these digital signs for other purposes in the library. Now when the old argument comes up over whether it is better to develop a solution in-house or buy one, the answer is not always obviously to outsource.

## About the Authors

Edward Iglesias was born in Laredo, Texas and lived there much of his life. The environmental bias caused by living in a bilingual, bicultural society has permanently affected his outlook on life. As a result he is drawn to subjects that don’t easily fit description or are a blend of many things. His latest book *Robots in Academic Libraries* is a good example as the field of library automation and technology is always in flux. After leaving Laredo, Mr. Iglesias taught English at various colleges in Houston before deciding to venture into the world of libraries by getting his MLIS at the University of Texas. From there he quickly settled into academic libraries and has worked in the field ever since. Currently Mr. Iglesias is researching the role of maker spaces in libraries as a way for libraries to continue to be relevant and provide communities of creation for their users.

Arianna Schlegel earned her Bachelor’s degree in Computer Science. After several years in the software world, she decided she wanted her career to go in another direction entirely, and pursued her Masters in Library Science. With these two wildly different but equally beloved fields, she began her work as a Digital Projects Librarian at Central Connecticut State University (New Britain, CT) in 2010. Currently she splits her time between her geek-librarian job at Central and her Reference & Instruction position at Capital Community College in Hartford, CT. In her spare time, she knits obsessively, reads everything she can get her hands on, and dabbles in technological pursuits.
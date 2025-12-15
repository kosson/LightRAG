---
title: "RSS Feed 2.0: The Crux of a Social Media Strategy"
source: "https://journal.code4lib.org/articles/11299"
author:
  - "[[The Code4Lib Journal]]"
published: 2016-01-28
created: 2025-01-10
description: "This article explains how the University of Nebraska Kearney Calvin T. Ryan Library improved their social media strategy by using an RSS 2.0 feed to update and sync social media tools and create a slideshow on the library's home page. An example of how to code a well-formed RSS 2.0 feed with XML is given, [...]"
tags:
  - "clippings"
---
# RSS Feed 2.0: The Crux of a Social Media Strategy
Michael Sutherland

This article explains how the University of Nebraska Kearney Calvin T. Ryan Library improved their social media strategy by using an RSS 2.0 feed to update and sync social media tools and create a slideshow on the library’s home page. An example of how to code a well-formed RSS 2.0 feed with XML is given, in addition to PHP, HTML, and JQuery utilized to automate the library home page slideshow.

According to a recent ACRL conference paper, it is clear that a lot of academic libraries are using social media. In the conference paper, “Making Social Media Meaningful: Connecting Mission and Policies” Johnson and Burclaff indicate that 94% of academic libraries have a social media presence, primarily on Facebook, Twitter, and YouTube (Johnson et al. 2013). What is not clear is how libraries are coordinating content across those social media channels. Using social media can be time consuming and maintaining the libraries’ various social media channels a chore. Not only does it take time to learn a specific tool such as Facebook: an individual could spend their entire day monitoring, updating, contributing content, and posting responses to each tool. In order to sync content, and coordinate those channels, libraries can turn to enterprise solutions, such as Gremln, Salesforce Marketing Cloud, or Hootsuite; however, a simpler approach is to utilize an RSS (*Really Simply Syndication* or *Rich Site Summary*) feed to disseminate content to various social media channels.

At the University of Nebraska Kearney Calvin T. Ryan Library, we started using a WordPress blog for news and events in the library that grew to include items of potential interest to the campus community connected to the library. Categories were created to describe posts in more detail, structure content and link related posts, such as “Library Info” or “E-resources”. Items the library wanted to highlight on the home page of the library web site were placed in a selective category titled “Home Page”. An RSS feed was created from the category by simply adding the word “feed” in front of the URL like this

`https://inbriefonline.wordpress.com/category/home page/feed/`

The feed was then run through Feedburner in order to optimize the way the feed was presented to subscribers. Blog posts from the home page were cross-posted on social media channels by following the feed in Facebook and Twitter.

This method worked well for a while, but over time, introduced several problems. First, how do you handle retweets, other institutions’ blog posts, or news stories not created by library staff that might be of potential interest to library users? It is awkward to repost those items through the blog, such as an article the library dean wanted posted from *The Chronicle of Higher Education*. In this case, what meaningful content can be contributed about a subject that someone else has already thoroughly addressed? Secondly, the RSS feed did not immediately update through Feedburner. On several occasions, Feedburner and WordPress had to be forcefully and manually updated and resynced. Not only was this not ideal, it was a problem because our feed populates a slideshow on the library home page and front door kiosk; thus the library home page and kiosk were not updating dynamically as intended. Further, the Calvin T. Ryan Library did not have a defined social networking strategy, so posting from WordPress to Facebook and Twitter appeared to lack personality.

To solve these issues, the Web Services Librarian chose to build a basic RSS 2.0 feed on the library web (LAMP) server to replace the WordPress feed and bypass Feedburner. Maintaining the feed is the responsibility of the Web Services Librarian who manually makes all updates to the feed, while different librarians continue to make entries in WordPress. Updates to the feed are not scheduled nor even made daily, but more organically driven by library events, service changes, or by interest pieces pertinent to the library. Only those items that the library wanted highlighted on the homepage by the Web Services Librarian, in collaboration with colleagues and the Dean, were put into the feed. Now links can be directly made to items instead of run through the blog. When items become dated, usually after two weeks, or past the event advertised, they are removed from the feed. Simultaneously, Facebook was taken over by the Project Archivist, while Twitter was maintained by the Web Services Librarian. Those librarians made an effort to follow related institutions and people and make posts so that items from the feed are interspersed with other posts; this helped to make those social media channels more dynamic while giving them some personality. At any given time, the feed contains at most four items.

Creating an RSS feed is simple. For those familiar with HTML, creating an RSS feed should not be a problem. All that is needed to create one is a text editor and some server space. We used vi on our server to create the feed. Developers can also utilize software such as Dreamweaver to create RSS feeds, but if an institution does not have a license for that software, individuals can easily create an RSS feed utilizing Notepad or any other free text editor. The server can be anywhere and the needed disk space is miniscule. If the server space is off-site, developers will need the ability to FTP the XML file as well.

RSS is an XML format essentially made up of three parts. The first part is the top level XML declaration.

```xml
<?xml version=”1.0” encoding=”utf-8”?>
```

Although the encoding is optional, it is recommended. The next line is the RSS declaration that identifies the document as an RSS 2.0 document.

```xml
<rss version="2.0">
```

The last part is the `<channel>` element used to describe the RSS feed and contains the other elements in the RSS feed. The  `<channel>` element has three required parts – `<title>`, `<link>`, and `<description>`.

```xml
<title>Calvin T. Ryan Library RSS 2.0</title>
<link>http://library.unk.edu/rss.xml</link>
<description>News and Information from the Calvin T. Ryan Library at the University of Nebraska Kearney</description>
```

The `<channel>` element may have one or more elements. Similarly, each `<item>` element contains three required parts – `<title>`, `<link>`, and `<description>`.

```xml
<title>On Display at the Library</title>
<link>https://inbriefonline.wordpress.com/2015/07/09/mona-freda-spaulding/</link>
<description>Several sketches and painting created by Spaulding between 1940 and 1960 make up a collection currently on display at the Calvin T. Ryan Library courtesy of the Museum of Nebraska Art.</description>
```

All elements in XML must have closing tags; thus the last two pieces are closing `</channel>` and `</rss>` tags. The following is a complete example of an RSS 2.0 feed.

```xml
<?xml version="1.0" encoding="utf-8"?>
 <rss version="2.0">
 <channel>
  <title>Calvin T. Ryan Library RSS 2.0</title>
  <link>http://library.unk.edu/rss.xml</link>
  <description>News and Information from the Calvin T. Ryan Library at the University of Nebraska Kearney</description>
  <item>
   <title>On Display at the Library</title>
   <link>https://inbriefonline.wordpress.com/2015/07/09/mona-freda-spaulding/</link>
   <description>Several sketches and paintings created by Freda Spaulding between 1940 and 1960 make up a collection of art currently on display at the Calvin T. Ryan Library courtesy of the Museum of Nebraska Art.</description>
   <guid>https://inbriefonline.wordpress.com/2015/07/09/mona-freda-spaulding/</guid>
   <pubDate>Thu, 09 Jul 2015 16:32:30 GMT</pubDate>
  </item>
 </channel>
 </rss>
```

When coding the RSS feed is complete, it should be saved as an .xml file. If not already on a server, ftp it to a server and check for validation in order to ensure it is a well formed RSS feed. A number of free validation services exist including the [W3C Feed Validation Service](https://validator.w3.org/feed/), [RSS Advisory Board](http://www.rssboard.org/rss-validator/), or [FEED Validator](http://feedvalidator.org/). This is an important step to insure that the RSS feed conforms to existing RSS specifications and standards. Feeds that are well formed will show up better in social media channels such as Twitter and Facebook. Numerous tutorials, videos and instructions for creating RSS feeds are available on the web. For novice users the W3C Schools *Introduction to RSS* [http://www.w3schools.com/webservices/rss\_intro.asp](http://www.w3schools.com/webservices/rss_intro.asp) is a good guide. Advanced users will appreciate RSS 2.0 at Harvard Law – [http://cyber.law.harvard.edu/rss/rss.html](http://cyber.law.harvard.edu/rss/rss.html) – which gives more information about the RSS 2.0 specification including optional tags. Only the `<title>`, `<link>`, and `<description>` tags are required. Other tags, such as the `<pubDate>` can be beneficial depending on need. The `<pubDate>`, for instance, used for indicating the date and time when an item should be published, is also useful for ensuring items in the feed do not linger and become dated.

A lot of information can be found about turning your Facebook or Twitter into an RSS Feed, but not how to follow a RSS feed. Unfortunately, following RSS feeds in Twitter and Facebook is not a straightforward task. When an item is created in the RSS feed, automating the process of updating separate social media channels will save time. Third party tools, such as Twitterfeed, IFTTT, and Dlvr.it are perfect for this kind of automation. We chose Dlvr.it because it is free, contains a lot of functionality, and supports both Facebook and Twitter. For example, Dlvr.it has filter options that allow users to filter on items other than content. Statistics on popular posts, clicks on posts, etc., are provided as well as support for integration with Google Analytics. Users can schedule posts to update social media on certain times and days and can even embed a Dlvr.it widget on the library web site that will show visitors popular posts. However, Dlvr.it is not as intuitive to set up as creating a trigger in IFTTT, depending on how you have set up your library Facebook instance. The Calvin T. Ryan Library Facebook is set up as a page and not with a specific library account. Individuals assigned to edit or administer Facebook have to use their personal Facebook instance. As a result, Dlvr.it will want to administer all of an individual’s pages, which may not be preferable to some, although Dlvr.it will only send updates to the page it is assigned to.

![](http://journal.code4lib.org/media/issue31/sutherland/CTRDlvrIt.jpg)  
**Figure 1.** Dlvr.it administration view.

In addition to posting on Facebook and Twitter, the RSS feed updates a slideshow on the library home page. Thanks to PHP code from Jason Clark at Montana State University, the RSS feed is parsed into an HTML list.

```php
<?php
    //request items from RSS 2.0 feed
    $rawFeed = 'http://library.unk.edu/rss.xml';
    //load feed as array object to be parsed and traversed
    $xml = simplexml_load_file($rawFeed);
    //determine number of items to display and set limit
    $number = count($xml->channel->item);
    if ($number >= 4) { $number = 4; }
    //loop through xml data and print as html
    if (!empty($xml->channel->item)) {
         foreach ($xml->channel as $feed) {
         //loop through items for display; number of items determined by $number variable above
           for ($i=0; $i<$number; $i++) {
             echo '<li><a href="'.$feed->item[$i]->link.'"><img alt="'.html_entity_decode(substr($feed->item[$i]->title, 0, 85)).'" src="./meta/img/ctr'.($i+1).'.jpg" /></a>';
             echo '<div class="slideshow-caption"><p>'.html_entity_decode(substr($feed->item[$i]->title, 0, 85)).'&nbsp;&nbsp;<a href="'.$feed->item[$i]->link.'">Read more</a></p></div></li>'."\n";
            }
          }
     } else {
             echo '<li><a href="http://inbriefonline.wordpress.com/"><img alt="Calvin T. Ryan Libary ExteriorJ" src="./meta/img/LibraryBuilding.jpg"></a>';
             echo '<div class="slideshow-caption"><p>Please visit the library\'s offical blog - <a id="inbrief" href="http://inbriefonline.wordpress.com/">In Brief Online</a></p></div></li>'."\n";
                 } 
?>
```

The above code essentially produces the following HTML

```html
<noscript><div id="slideshow-wrap"></div></noscript>
    <ul id="slideshow">
       <li><a href="link here"><img alt="" src=" image source " /></a>
           <div class="slideshow-caption"><p> text for caption <a href=" repeat link ">Read more</a></p></div>
       </li>
       <li><a href="link here"><img alt="" src=" image source " /></a>
           <div class="slideshow-caption"><p> text for caption <a href=" repeat link ">Read more</a></p></div>
       </li>
       <li><a href="link here"><img alt="" src=" image source " /></a>
           <div class="slideshow-caption"><p> text for caption <a href=" repeat link ">Read more</a></p></div>
       </li>
    </ul>
```

A JQuery script available at GitHub – [https://github.com/SutherlandMJ/JQuery-Slideshow](https://github.com/SutherlandMJ/JQuery-Slideshow) – coupled with an image, produces the slideshow effect on the home page.

![](http://journal.code4lib.org/media/issue31/sutherland/CTRslideshow.jpg)  
**Figure 2.** Library web site slide show.

The goal of this project is to publish once, disseminate widely, and provide more flexibility in doing so. The custom RSS feed has solved the issues of running everything through our WordPress blog, reduced the amount of time devoted to social media, while at the same time keeping our home page and social media channels updated and in sync. Updates occur in real-time as the feed is saved. For our library and web services this is a viable solution. For larger libraries with committees or groups that manage social media, this could be a piece of a larger strategy for managing and contributing to social media channels. Using the method described, only those with access to the web server have the ability to update the RSS feed. If it is possible, future development would allow multiple contributors to update the feed and allow for better scheduling other than through Dlvr.it. Another consideration to get more traffic to our site and more widely disseminate the feed is to publish it in feed directories, such as RSSFeeds.org, many of which are free. A listing of RSS directories can be found at DMOZ.org.

## References

Johnson, C., & Burclaff, N. 2013. Making Social Media Meaningful: Connecting Missions and Policies. In Imagine, Innovate, Inspire. Indianapolis, IN: American Library Association. p. 399-405.

## About the Author

Michael is currently the Web Architect and Manager for the University Libraries at Virginia Polytechnic Institute and State University and former Web Services Librarian at the University of Nebraska Kearney Calvin T. Ryan Library. He has been a web developer in academic libraries for over seven years.
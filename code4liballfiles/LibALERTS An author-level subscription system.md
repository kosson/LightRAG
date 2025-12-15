---
title: "LibALERTS: An author-level subscription system"
source: "https://journal.code4lib.org/articles/7363"
author:
  - "[[The Code4Lib Journal]]"
published: 2012-10-03
created: 2025-01-10
description: "Patron requests for the ability to subscribe to their favorite authors so they could receive notifications when new titles are released, presented an opportunity for Westlake Porter Public Library to learn, to build, and to engage with patrons on the development of a new service. The library’s libALERTS service, which launched in June 2012, was [...]"
tags:
  - "clippings"
---
# LibALERTS: An author-level subscription system
Matt Weaver

Patron requests for the ability to subscribe to their favorite authors so they could receive notifications when new titles are released, presented an opportunity for Westlake Porter Public Library to learn, to build, and to engage with patrons on the development of a new service. The library’s libALERTS service, which launched in June 2012, was the culmination of a process that involved the development of a Drupal-based website augmented with a hand-coded preprocess interface that addressed critical concerns for the effectiveness of the service.

## Introduction: A “Roll Your Own” approach

This paper discusses the development process and launch of [Westlake Porter Public Library’s libALERTS](http://www.westlakelibrary.org/libalerts) service, an author-subscription service.

In 2011, a couple of patrons at Westlake Porter Public Library had asked about such a service. Apparently one of our vendors, Dear Reader, had been working on subject-level notifications. I am strident in my beliefs that libraries need to solve as many of these problems on our own as we can, so I investigated what was possible. During the process, I did find one vendor, engagedpatrons.org, which provides an alert service at a reasonable price. Westlake Porter Public Library, as a Sirsi customer, used to have the “Tell me when” functionality in the OPAC that would send notifications to patrons when new items came out based on their past checkouts. Since the list could not be refined to eliminate categories that patrons did not want notifications for, and some other issues, our systems administrator turned off the service, an action that was hardly noticed by our customers.

Having been given the freedom to explore what was possible with the resources at my disposal, the savings of a few hundred dollars per year in fees to a vendor might not be seen as worth the investment of time and effort; but the experience that the library has in launching and sustaining a service on its own, from the coding experience, to the practice of involving the patrons who will use the service in its development are powerful motivators. Also, such a service would provide test data that we could use to better understand our patrons’ reading choices. Excited at the possibility of further in-house development of readers’ advisory solutions, I decided to proceed with a Drupal-based solution after initial testing proved the viability of the project.

The development process took around a year, with the project getting put on the back burner for months at a time. If ongoing efforts to improve the technology, normalize code and bring the modules into a neat package are successful, libALERTS could be shared easily with other libraries.

## Minimum Viable Product

The goal for the initial development was to understand what tools I could find, and what skills I needed to learn, in order to get a pilot project up and running. This minimum viable product \[[1](https://journal.code4lib.org/articles/#note1)\] would be used for initial testing to determine whether an actual service could be developed. If the basic service functioned in initial testing, a fuller version would be developed for a testing program using a group of patrons.

### Accepting constraints: A development team of 1, a budget of 0

Normally it would be customary to seek input from patrons about the value of such a service; but the most important question for me was whether it was possible. I had no budget for the project. If, in the process of seeking patron interest in such a project, we engendered an expectation that it would be forthcoming, that could be problematic.

In order to provide such a service, I would need publishing data. Running reports from the ILS could prove time consuming on an ongoing basis. Also, due to budget cuts in recent years, all departments have been running lean. If possible, I wanted to do everything I could to make the service fit in our operations as neatly as possible, so I asked the library’s cataloger and the Acquisitions Specialist about the procedures for ordering. The latter explained that she downloads shell MARC records from publishers that are loaded into the ILS after an order is completed, and then those MARC records were simply deleted from her computer. The cataloger arranged for her to download the MARC files into a shared folder using a desktop shortcut, and instead of deleting the files, she would leave them there for me to process for libALERTS. She also offered to add suffixes to file names to indicate what Dewey category, format, and age group the files were for. This process didn’t change her download process at all. Based on the expectation that the service would appeal to fans of prolific, mainstream authors, the library’s systems administrator ran a set of reports of bestselling titles in MARC format, which I uploaded in order to populate the site with a good representation of popular authors. Also, for a time, I uploaded a large number of MARC records without considering whether patrons would want to subscribe the authors in those records in order to receive the notifications when their new titles were published.. A maintenance task in the future will be to delete content/authors who have been in the system for a certain amount of time and have no subscriptions attached to them.

## Drupal

The library’s public website and intranet are built on the popular content management system [Drupal](http://drupal.org/) (version 6) in multi-site setups, and both sites feature subsites. libALERTS functions as a subsite of the main website I explored available modules and quickly found that I could piece together suites of contributed modules into a mechanism for patrons to subscribe to authors and receive email notifications when new content by those authors was added to the site.

libALERTS are content types built with the powerful Content Creation Kit (CCK) module, and feature custom fields for a book’s ISBN, which is applied as a variable in a template to complete an img element’s src attribute that displays Syndetics cover art for each title (See Example 1). I created a custom template to “theme”—drupalspeak for changing the layout—the libALERT content type.

[![](https://journal.code4lib.org/media/issue18/Weaver/samplenode.png)](https://journal.code4lib.org/media/issue18/Weaver/samplenode.png)

**Figure 1.** node-libalert.tpl.php and sample node.

### Critical Modules

- Notifications — provides subscription and notification functionality. The Taxonomy Notifications module, which is part of the Notifications group of modules, allows users to subscribe to taxonomy terms, which is how I stored author names.
- SMS Email Gateway/SMS Framework — enables the transmission of text messages using email gateways. SMS Email Gateway used to be part of the SMS Framework but is now its own project.\[[2](https://journal.code4lib.org/articles/#note2)\] However, the SMS Framework module is better supported and is still under development.
- MARC module — allows Drupal nodes to be created by importing MARC record data.

Upon finding another suite of modules that would provide the ability to send text messages, and discovering that the Ohio Public Library Information Network provides libraries with SMS capability for free, I was eager to include text messages as a possible mode for alert delivery.

To get text messaging to work, however, required hacking the SMS Email Gateway module. Initially, this was for diagnostic purposes, in hopes it would give me insight to a fix for the module. Essentially, I hacked the module to force the gateway address for the carrier. This hack appears in a thread that I started on the Drupal forum \[[3](https://journal.code4lib.org/articles/#note3)\]:

In sms\_email\_gateway.module, Line 194, I changed

| 1  2  3 | `<?php`  `$to` `= ``$number` `.``'@'``. ``$options``&#91;``'carrier'``&#93;;`  `?>` |
| --- | --- |

to

| 1  2  3 | `<?php`  `$to` `= ``$number` `.``'@'``. ``'sms.yourcarrier.com'``;`  `?>` |
| --- | --- |

I have not tested the patches in the thread noted above, nor explored the latest version of the SMS Framework to see if it will handle text messaging. This hack remains a part of the service, but redressing this is a goal of future improvements to the site.

## Simulating taxonomy search

Drupal’s search system does not search taxonomy terms. Given that these authors’ names are stored as a taxonomy terms, I needed a mechanism for search. The best that I could do was to use a setting in the Views module. I exposed the taxonomy term filter, in effect creating a search box. Then, I set “exposed form in block” to “Yes” creating the search block.

[![](https://journal.code4lib.org/media/issue18/Weaver/searchview.png)](https://journal.code4lib.org/media/issue18/Weaver/searchview.png)

**Figure 2.** Exposed taxonomy term filter..

## Proof of concept: staff testing

Staff testing began with an initial group of subjects from the library’s Technology Team, which I lead. I had them sign up, add authors and subscribe to them. Those with cell phones who were willing to receive texts as part of the testing process were enlisted. I found as many types of cell phones and smart phone operating systems as possible. After this initial testing of the core alert-transmission system, I expanded staff testing to any employee willing to participate.

Testing focused on the basic functionality of the site: subscribing to authors, and transmission of alerts triggered by the uploading of data from MARC records into Drupal nodes. Core functionality, for both email and text message recipients, proved successful.

## Post proof of concept: the survey

The library was planning to run a series of short surveys in the near future: out of fear of survey fatigue, I was permitted to run a short survey on the website and as a handout, for up to two weeks. The survey aimed to capture interest among readers in such a service and which authors respondents would like to subscribe to. While the number of recipients was only 50, interest in the service was very high (see below). The authors that recipients would subscribe to read like a bestsellers standing order. Not every reader follows authors so closely, but if a core of voracious readers would be satisfied with this service, libALERTS would certainly hit that sweet spot of mainstream fiction.

Forty out of fifty survey recipients added a total of 234 authors for an average of 5.85 per respondent. But several respondents also added phrases like “plus many more,” or “hundreds of others” in their list of authors.

| Questions | Responses |
| --- | --- |
| How likely would you be to use this service? | \| Somewhat likely \| 6 \| \| --- \| --- \| \| Very likely \| 8 \| \| Would definitely use it \| 36 \| |
| How many books do you read a year? | \| 3 or fewer books per year \| 1 \| \| --- \| --- \| \| 4 to 6 books per year \| 1 \| \| 7-9 books per year \| 2 \| \| 10-12 books per year \| 2 \| \| more than 12 books per year \| 43 \| |
| Who are your favorite authors? | \| Left Blank \| 10 \| \| --- \| --- \| \| User entered value \| 40 \| \| **Average submission length in words (excluding blanks)** \| **13.68** \| |

**Table 1.** Survey Responses.

Dealing with the data both from the staff testing phase and the survey revealed some major issues that I would have to address before turning this into a real service.

## A Pre-process interface

After the concept of the site had been proven, the initial development process revealed a couple of major concerns that had to be addressed for the actual service to work.

First, for an alert to be triggered, the author name that appears in a MARC record must match the author name in the libALERTS site exactly. If a patron would fail to receive an alert because of a dropped middle initial, then the service fails. The MARC records that we receive from publishers can include variations in a name form, or misspellings. Also, authors may have very similar names: David A. Adler and David D. Adler both write children’s books, but are different authors. I found nothing in Drupal that would allow comparison of MARC records to the contents of the database.

The second concern was the size of the site. libALERTS was never intended to duplicate all content in the catalog, but all MARC records that the library receives from publishers would have to be processed in order to catch every possible subscription. Surplus content would make it harder for users to find desired authors. So, I only wanted to upload MARC records for authors to whom at least one patron had subscribed. As libALERTS is designed to be as automated as possible, I needed to solve these problems programmatically.

### File\_MARC

The preprocess interface reads and writes MARC records using the [File\_MARC library](http://pear.php.net/package/File_MARC/), which is installed via the PEAR Package Manager as part of a server’s PHP installation. This library can be used with Drupal’s [MARC module](http://drupal.org/project/marc), which is discussed later in detail.

### Selectively adding content

Because libALERTS has the means for users to add authors not included in the site, and the site was pre-populated with hundreds of authors, I decided that the MARC records should be analyzed so that only records with authors for which a subscription was attached should be included. The example below shows author values gathered by a SQL query of the database and placed in an array.

Another array is created from authors in the MARC record, and each item in that array is compared against the array of existing authors:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32 | `$subauth` `= mysql_query(``"SELECT DISTINCT tid, name FROM term_data INNER JOIN notifications_fields ON notifications_fields.value = term_data.tid where notifications_fields.field = 'tid';"``);`  `$newbooks` `= ``new` `File_MARC(‘[path to directory]' . ``$filename``);`  `while` `(``$record` `= ``$newbooks``->next()) {`  `$objkey``++;   `  `$newauthors` `= ``$record``->getFields(``'100'``);`  `if` `(``$newauthors``) {`  `foreach` `(``$newauthors` `as` `$field``) {`  `$author` `= ``substr``(``$field``,9);`  `mysql_data_seek(``$subauth``,0);`  `while``(``$rows` `= mysql_fetch_array(``$subauth``, MYSQL_ASSOC)){`  `$pairs``[] = implode(``'\|'``,``$rows``);`  `foreach``(``$pairs` `as` `$pair``){`  `$final` `= ``explode``(``'\|'``,``$pair``);`  `}`  `if``(in_array(``$author``,``$rows``)){`  `$newrecords``[] = ``$objarray``[``$objkey``];`  `echo` `'<span style="color:red;font-size:20px;border: dashed 5px red;">Match found for '` `. ``$author` `. ``'</span>'``;`  `echo` `'</div>'``;`  `} ` |
| --- | --- | --- | --- |

## The Levenshtein distance

The process of comparing two strings– the author names as they appear in the MARC record, and the existing name in the libALERTS database– involved querying the author names in the MARC records and creating an array of author names in the database to which a site member had subscribed. In php, the levenshtein function calculates the “the minimal number of characters you have to replace, insert or delete to transform” the first string into the second string. This measurement is the Levenshtein distance, or the edit distance. \[[4](https://journal.code4lib.org/articles/#note4)\]

In the following example, author names from MARC records for which there is not an exact match in the database are compared against the database with the levenshtein function to see if there is anything close. The code below successfully detects name forms in MARC records that are off by as few as one character when compared to the form of the name in the database.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34 | `$shortest` `= -1;`  `$lev` `= levenshtein(``$author``, ``$row``);`  `if` `(``$lev` `== 0) {`  `$closest` `= ``$row``;`  `$shortest` `= 0;`  `$newrecords``[] = ``$objarray``[``$objkey``];`  `break``;`  `}`  `if` `(``$lev` `<= ``$shortest` `\|\| ``$shortest` `< 0) {`  `$closest`  `= ``$row``;`  `$shortest` `= ``$lev``;`  `}`  `if` `(``$shortest` `> 0 && ``$shortest` `< 5) {`  `echo` `'<fieldset>'``;`  `echo` `'<p>Name as it appears in MARC record: <strong>'` `. ``$author` `. ``'</strong></p>'``;`  `echo` `'<p>'``;`  `echo` `'245 field from MARC record: <strong>'` `. ``substr``(``$record``->getField(``'245'``), 0) . ``'</strong>'``;`  `echo` `'</p>'``;`  `echo` `'No match in the libalerts database, but <strong>'` `. ``$author` `. ``'</strong> is close to: <a onClick="return popup(this,\'notes\')" title="Click to check the author in the catalog" href="[http://catalog.westlakelibrary.org/uhtbin/cgisirsi/x/0/0/5?search_type=browse&srchfield1=AU](http://catalog.westlakelibrary.org/uhtbin/cgisirsi/x/0/0/5?search_type=browse&srchfield1=AU)^AUTHOR^AUTHORS^Author Processing^author&searchdata1='` `. ``str_replace``(``','``,``' '``,``$final``&#91;1&#93;) . ``'">'` `. ``$closest` `. ``'</a><br />'``;` |
| --- | --- | --- | --- |

Potential intended authors from within libALERTS are presented and the code below shows a javascript function that changes the value of the author name in the MARC record from the publisher to the version of the author name that exists in the site’s database.

| 1  2  3  4  5  6  7  8  9  10  11  12 | `function` `setAuthor(el) {`  `var` `author = el.innerHTML,`  `id = el.id.replace(/^closest_/, ``""``);`  `if` `(console) {`  `console.log(author);`  `}`  `document.forms[``"myform"``].elements[``"auth_"``+id].value = author;`  `return` `false;`  `}`  `echo` `"Click name to add <span style='background:gray;border:outset 3px black;' id='closest_{$fieldkey}' onClick='setAuthor(this)'>{$closest}</span>"``;` |
| --- | --- |

For the development of the full libALERTS service, another consideration was age groups. If possible, I would like to separate authors by the age group they write for, but without pegging a writer who writes across age groups into one category. Even though the records that the library’s Acquisitions Specialist downloaded were shell records, they contained enough information to sort authors into adult, teen and juvenile categories via Drupal’s taxonomy system. I created hierarchical taxonomies using the fixed values of the 947f and 947h fields, which WPPL uses for local holding information. I placed these values within hierarchical taxonomies beneath top-level terms of adult, kids and teen, which were used to create author-browse pages for each. For instance, “AMYS”, a local holding value for our Adult Mystery collection, is a child of the “Adult” term. However, capturing this information required another hack of a contributed module.

The Drupal MARC module was created based on a local institution which uses the 852 field in MARC records for local holding information. The MARC records that we download from publishers use the 947 field, which was not able to be captured by this module. I had to add the 947f and 947h fields to the marcbib and marcnode modules, which are part of the MARC module package.

## Testing: a focus group from the wild

For live testing I had six patron volunteers (a pair of staff members joined in as well). Testing consisted of having participants find and subscribe to a specific author (although most subscribed to many others, too). When I saw that everyone had subscribed, I would create a libalert and email them to tell them that it had been sent. In all cases, alerts were received; no patrons opted to receive messages via text messaging.

One test subject became incredibly engaged, sharing her experience in detail, even catching typos in my “how it works” page.

Of the six, four completed all tests and a final survey. Either in direct email communication or in the survey, my test group revealed usability issues, and other problems that I cleared up before launch.

## Limitations

Due to the popularity of ebooks, I wanted to include Overdrive data. We do not receive MARC records in a timely manner; sometimes it is weeks or months after the titles are available. While Overdrive is promising new MARC services\[[5](https://journal.code4lib.org/articles/#note5)\], the one that appears to be sufficient has a cost associated with it. Yet reports generated within Overdrive’s Content Reserve module often include insufficient metadata to use in the libALERTS processes. As of 7/30/12, Overdrive has launched its Developer Portal, which includes a metadata AP\[[6](https://journal.code4lib.org/articles/#note6)\] that may allow me to include ebooks and digital audiobooks.

## The public’s response

At the time of writing, the library has promoted the service with signs, small bookmarks placed in books by popular authors, and a press release; but the edition of the library newsletter Notes that features libALERTS had not gone out. The press release was not picked up by the largest paper in the area, but it did appear on that publishing company’s websites which combine local content from The Plain Dealer and the smaller Sun News, which did pick up the story. Tutorials and an introductory video have been shared on YouTube, Twitter and FaceBook. Response has been steady but slow, gaining a new user or two a day. New users who have received alerts are returning to add more author subscriptions.

Current users are receiving their alerts and returning to add more subscriptions. The average is around 10 subscriptions per user, with one user having subscribed to nearly 75 authors. Some people have created accounts but added no subscriptions. Through Drupal, I contact these users to direct them to tutorials or invite them to contact me directly for help. Slowly, those users add a subscription or two.

## Mobile issues

I felt it was important to have a mobile site for libALERTS so that patrons who received alerts as text messages would have a dedicated interface that would allow them to place holds. Also, patrons could easily add a subscription wherever they are learning about new books/authors that they might like to follow, but the mobile interface in a multisite setup posed problems.

Ultimately, I used the [themekey module](http://drupal.org/project/themekey_properties) for theme switching. The [themekey properties module](http://drupal.org/project/themekey_properties) allows theme switching to be triggered on operating system or browser type. This method does not allow for tablet users to choose the desktop version of the website, which is a usability issue.

[![](https://journal.code4lib.org/media/issue18/Weaver/LibAmobile.png)](https://journal.code4lib.org/media/issue18/Weaver/LibAmobile.png)

**Figure 3.**Mobile view.

[![](https://journal.code4lib.org/media/issue18/Weaver/LibAmobile2.png)](https://journal.code4lib.org/media/issue18/Weaver/LibAmobile2.png)

**Figure 4.**Theme switching rule.

## Future improvements

Finished products are for decadent minds.  
–Isaac Asimov

### Normalized structure, No more hacks

The current system, while functioning as designed, can be improved. One problem is that some of the modules that the site relies on have not been written for Drupal 7. So I am exploring alternatives that will be likely to ensure the future growth of this system. These alternatives can clear up hacks of two modules that I had to put into place in order to get the functionality that I wanted. These two hacks are, personally, major maintenance nuisances, which is reason enough for solving them. They also pose a major obstacle to sharing the site with other libraries.

Moving forward, I will have to ditch the MARC module altogether. It does not include fields for MARC 700 fields, the 508 and 511 fields, etc. As the MARC module was created with a local institution’s usage in mind\[[7](https://journal.code4lib.org/articles/#note7)\], and only reflects books, it is not sufficient for movies or music, which I plan to add.

A better option will be to output XML records and import them via Drupal’s Feeds and Feeds XPath Parser modules. Using the File\_MARC library, to effect this change, I will have to change two lines in my pre-processed interface code from:

```
$newrecord->toRaw());
```

to

```
$newrecord->toXML());
```

The sms\_email\_gateway hack will be harder to deal with. At this point, continued development of the SMS framework module may be the best solution to having text messaging in the system.

If text messages prove popular, there are limitations on the gateway provided by the Ohio Public Library Information Network: each user can only receive 5 texts per month. For the site’s heavy subscribers of mass fiction, they could easily hit that limit; as I plan to add the ability to subscribe to actors/directors of movies in the next phase of the site’s development, that limit could be insufficient for a large number of users. I might have to see if the library can come up with money so that we can access a commercial gateway for text messaging

While there is a downside of not having it integrated into the ILS, I’ve never found any ILS, even the newer sexier versions, to be great sources for readers’ advisory help. Readers’ advisory is the direction I intend to take the site. Drupal offers modules for rating content, and I can allow people to write reviews simply by enabling comments on the libALERT content type. I will work with active users to see what they want from the site.

### Sharing

Drupal Features: I am trying to see if the alert functionality in the current site can be performed by the [Rules module](http://drupal.org/project/rules) and associated modules. Rules is compatible with the Features module. If the core functionality of my libALERTS site can get saved as Features, it will be much easier to share it with other libraries.

Another approach, especially if a large number of libraries would be interested in this, would be to create a distribution\[[8](https://journal.code4lib.org/articles/#note8)\], which is a specialized Drupal package, complete with all of the necessary modules, themes, libraries, etc., for a given site.

### Sirsi Web Services

I am planning to take training in Sirsi Web Services(SWS). At the very least, using SWS and the ILS authentication module\[[9](https://journal.code4lib.org/articles/#note9)\], I would be able to add user authentication based on the ILS user library card number and PIN.

## Pros and Cons of Roll-Your-Own

While I am not anti-vendor, in my work I am driven by a belief that I am not doing my job if I don’t try to solve problems myself. This opinion scales, when considering my industry.  
The benefits of roll-your-own for the library include

### Control

Control over the system, which means as long as we keep the server running, the service will be there. Because we control access to the system, we can learn from it and build on the existing service. We can make improvements based on our local usage: this responsiveness is something of great value that is lost when dealing with vendors. The library can engage with the community of users. I collaborated with a small test group of patrons, but plan to open future development to active users. In a small way, this is building community, which I believe is essential to the future of libraries.

Control also means taking responsibility for patron privacy. If there is a data breach, for instance, we can’t grouse about the vendor. This is not a “con” of roll-your-own, by the way; it is a reality, one that is in line with our traditional library values, and that–in my opinion–is quickly forgotten when signing with vendors. The stress that accompanies control is substantial: this is my baby, and I have no vendor to blame if something fails. But accountability should never be considered a “con.”

### Cost

By using open source software, there are no licensing costs. The investment of time in this development will be paid off over time. We are not paying for access to a text messaging gateway at this time. If the current free gateway proves insufficient for actual usage, I will explore other options, including commercial gateways.  
If future development involves Sirsi Web Services, the library already has the required subscriptions in place: libALERTS will not add to those costs.

### Collaboration

Within the library, this project has been a collaboration. The Acquisitions Specialist who has helped with the workflow for the MARC records has taken an active interest in the site, and has been sharing more information that she finds relevant to the service.

Because we built this system on open source software, I can share it with other libraries. An opportunity for this level of collaboration is an exciting prospect.

## The disadvantages of roll-your-own

### Cost

There is cost advantage to roll your own, but, if all you want is the functionality described above, there are vendors who will provide it. That cost may be less than the staff cost of building the service from scratch. However, by sharing this project in the means described earlier the investment of staff time will be reduced.

### Time

A major problem with going roll-your-own for most projects is: where do you find the time to do it? The development process for libALERTS was interrupted frequently. As the only person doing web work at the library, if my skills were needed elsewhere, libALERTS got put on the back burner. Because of my involvement with ebooks, libALERTS development completely stopped from October 2011 until March 2012.  
Any particular diversion from the development team’s project can kill momentum, interest and support.

### Stress

libALERTS is “my baby.” Throughout development, testing and especially at launch, the specter of “did I think of everything” was constant and weighed heavily, and has led to some rather obsessive thinking.

### Insufficient skills

I am self-taught in all technological aspects of my job. Perhaps there are solutions to problems that I faced that are outside my skill level. As a broader discussion for any project, it may be difficult, expensive and, and time-intensive to add necessary skills to bring any project to fruition.

## Conclusion

libALERTS began with requests from patrons. The work needed to understand the motives behind those requests, and how to satisfy them, not only was an invaluable learning process, but also resulted in a viable product. The roll-your-own approach to its development presented many problems whose solutions will serve me and my institution in future development efforts.  
I believe that libraries should hire vendors to do things we cannot do; but we should try to do things ourselves first. We talk the talk of promoting our institutions as places of personal transformation through lifelong learning. When it comes to developing new services to meet expressed demands within the community, we need to walk the walk, partnering with our patrons to transform our own institutions.

## About the author:

Matt Weaver is the Web Librarian at Westlake Porter Public Library (Westlake, OH). His email address is matt.weaver@westlakelibrary.org. You can connect with him at facebook.com/mattrweaver and twitter.com/mattrweaver.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\]. [http://en.wikipedia.org/wiki/Minimum\_viable\_product](http://en.wikipedia.org/wiki/Minimum_viable_product)

\[[2](https://journal.code4lib.org/articles/#ref2)\]. [http://drupal.org/project/sms\_email\_gateway](http://drupal.org/project/sms_email_gateway)

\[[3](https://journal.code4lib.org/articles/#ref3)\]. For a full discussion of the issue and some possible patches/solutions: [http://drupal.org/node/1222038](http://drupal.org/node/1222038)

\[[4](https://journal.code4lib.org/articles/#ref4)\]. [http://php.net/manual/en/function.levenshtein.php](http://php.net/manual/en/function.levenshtein.php)

\[[5](https://journal.code4lib.org/articles/#ref5)\]. [http://overdriveblogs.com/library/2012/06/21/marc-records-options-expand-with-ebibliofile/](http://overdriveblogs.com/library/2012/06/21/marc-records-options-expand-with-ebibliofile/)

\[[6](https://journal.code4lib.org/articles/#ref6)\].[https://developer.overdrive.com/](https://developer.overdrive.com/)

\[[7](https://journal.code4lib.org/articles/#ref7)\]. Email communication: “All the school oriented automation systems that I work with keep holding code info in the 852 field.” Send by Andy Austin to Matt Weaver on 10/31/11.

\[[8](https://journal.code4lib.org/articles/#ref8)\]. [http://drupal.org/documentation/build/distributions](http://drupal.org/documentation/build/distributions)

\[[9](https://journal.code4lib.org/articles/#ref9)\]. [http://drupalib.interoperating.info/ilsauthen](http://drupalib.interoperating.info/ilsauthen)
---
title: "Creating a Library Database Search using Drupal"
source: "https://journal.code4lib.org/articles/2920"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-06-22
created: 2025-01-10
description: "When Florida Gulf Coast University Library was faced with having to replace its database locator, they needed to find a low-cost, non-staff intensive replacement for their 350 plus databases search tool. This article details the development of a library database locator, based on the methods described in Leo Klein’s “Creating a Library Database Page using [...]"
tags:
  - "clippings"
---
# Creating a Library Database Search using Drupal
Danielle Rosenthal, Mario Bernardo

When Florida Gulf Coast University Library was faced with having to replace its database locator, they needed to find a low-cost, non-staff intensive replacement for their 350 plus databases search tool. This article details the development of a library database locator, based on the methods described in Leo Klein’s “Creating a Library Database Page using Drupal” online presentation. The article describes how the library used Drupal along with several modules, such as CCK, Views, and FCKeditor. It also discusses various Drupal search modules that were evaluated during the process.

## Introduction

The Florida Gulf Coast University Library is a mid-sized academic library serving a four-year public institution. We opened our doors and virtual presence in 1997 with roughly six database subscriptions, since then the collection has grown to over 350. The library also provides access to over 30,000 e-journals, maintains a 115-seat open computer lab, a 10-seat reference lab, and employs twenty staff members and twelve librarians. The interface for accessing databases has changed only a couple of times, with the last iteration in use for over eleven years. When the library was informed that the database locator service was being discontinued, we had to come up with a replacement in a relatively short time. With a small technology staff and  no funds set aside for this project, our solution had to be fairly easy to implement and, ideally, free. Our search brought us to explore open source, something we yet hadn’t used.

[![Database Page, 1997](https://journal.code4lib.org/wp-content/uploads/2010/06/image001-300x288.png "Database Page, 1997")](https://journal.code4lib.org/wp-content/uploads/2010/06/image001.png)

Figure 1. Database Page, 1997

While we initially implemented a “DBL Taskforce” consisting of various library faculty and staff to complete this project, ultimately it was just the Assistant Director of Library Computing and Technology Systems (CTS) and the Web Librarian who were able to implement the solution. We have no programmers on staff. While the library can and does seek help from university technology on occasion, for the most part CTS operates independently from the rest of the university’s IT.

The database locator that Florida Gulf Coast University Library relied on was a tool created by and hosted at the Florida Center for Library Automation ([FCLA](http://fclaweb.fcla.edu/)).  FCLA is a consortia library technology center which:

“…provides state-of-the-art, cost-effective information technology to assist the libraries of the public universities of Florida in their support of teaching, learning, research and public service. More specifically, implement and centrally support high quality computer systems that help the libraries acquire, manage and provide access to information resources…”.\[[1](https://journal.code4lib.org/articles/#note1)\]

The shared database locator was used by all State University System (SUS) libraries at one point in time. The SUS libraries can purchase and license databases through the FCLA consortia if they wish and the FGCU library licenses many of our databases though FCLA, but not all.

[![Database Locator pre-Drupal instance](https://journal.code4lib.org/wp-content/uploads/2010/06/image003-239x300.png "Database Locator pre-Drupal instance")](https://journal.code4lib.org/wp-content/uploads/2010/06/image003.png)

Figure 2. Database Locator pre-Drupal instance

In September 2007, the FGCU library was notified that FCLA needed to free up the hardware and software licenses residing on the server hosting the database locator service.  We had to quickly find an alternative solution because we were the last university still using the outdated database locator software and there were no plans to keep it running for one university. All the SUS libraries had created new alternatives themselves or had outsourced the work. While FCLA was willing to help with a replacement DBL, we weren’t sure what we really wanted. The need to find a new DBL solution presented an opportunity to create something new, as well as deal with known issues, in hopes of creating a more usable system.  Incorporation of additional features or fixes of known issues was secondary. In short the new DBL must:

1. Be searchable by title as well as keyword:  the outdated system was also only searchable by title, which worked well for experienced users; however our web usability study illustrated the need for a more context-driven interface. During the web study, students unfamiliar with the DBL were observed typing keywords in the search box instead of titles. \[[2](https://journal.code4lib.org/articles/#note2)\]
2. Contain an alphabetical subject list: all 350+ databases must fit into an appropriate subject category or multiple categories for users who don’t know which database to use. Users need to be able to browse a list of art databases or biology databases, etc.
3. Contain an a-z list: for users who don’t know the correct spelling of a particular database or for users who prefer to click instead of typing in a database name.
4. Be reliable and fast: database use at FGCU is very high and stability is a high priority. The locator page is consistently in the top 3 most accessed pages on the web site. Users want to get into their database of choice quickly, without long search times.
5. Be easy to update: records need to be easy to add, delete, or edit with preferably no lengthy re-indexing time. Our old system re-indexed every 12 hours.

## **Getting Started**

We started by creating a “DBL Taskforce.” The taskforce consisted of the Assistant Director of CTS, the CTS staff, the web librarian, Head of Technical Services, our cataloging and metadata librarian, and the e-Resource librarian. Our initial work consisted of researching and contacting the other SUS libraries and comparable institutions to see what they were using. We found, however, that many of them had programmers on staff or the funds to outsource the service. We had no programmers on staff and no funds available to outsource the service. A couple of institutions could not tell us how to re-create their systems because they did not know themselves. Multiple authors and programmers had worked on their systems over the years, many of whom had since left.   Budget considerations, in particular, led us to consider open source solutions.

## The development process

Our initial step was to examine the most common open-source CMS products available. We then installed test instances on local hardware and begin evaluating how they would fit the needs of the DBL objectives already drafted.  Among the CMS’s installed and tested were Joomla, Drupal, and WordPress.

While looking at Drupal, we discovered a 20-minute [online presentation](http://chicagolibrarian.com/node/262) by another librarian, Leo Klein, who used Drupal to create a searchable system.\[[3](https://journal.code4lib.org/articles/#note3)\] Drupal, as described on [Drupal.org](http://www.drupal.org/), is “[open-source software](http://en.wikipedia.org/wiki/Open-source_software) distributed under the [GPL](http://www.gnu.org/copyleft/gpl.html) (“GNU General Public License”) and is maintained and developed by a [community](http://drupal.org/node/35172) of thousands of users and developers.” From the presentation we saw how we could leverage the basic framework demonstrated and customize it to fit our needs.  We chose our existing Microsoft IIS server platforms rather than the more common Windows Apache MSQL PHP (WAMP) or the Linux based alternative (LAMP) often used to host Drupal. This choice was based on several factors: availability, established support, familiarity, and necessity to bring the product quickly to production.

After deciding on the platform, we downloaded and installed Drupal version 5.7. It should be noted that we chose Drupal version 5.7 over version 6 (the latest version available at the time) because the MARC import module ([http://drupal.org/project/marc](http://drupal.org/project/marc)) was not available in version 6. We then proceeded to import our data and investigate and install various modules.  One of the most challenging aspects of this project turned out to be the preparation and importing of our existing 300+ database records. The records were stored in the older system housed at FCLA called Citation Server, in a customized MARC record format. The MARC records had multiple fields with repetitive information, often with odd graphic symbols used as field fillers and delimiters. The unusual formatting of the records prevented them from being cleanly imported into Drupal. It turned out to be easier to perform a partial import of some elements of our dataset, specifically the titles and description because those fields were clean. We then cut and pasted or manually entered the remaining data into the Drupal content forms.  We can assume, as demonstrated with the clean import of the title and description fields, that the data import feature works well and other libraries may not encounter problems unless they are importing data from legacy systems such as the old Citation Server.  Once the data is in the native Drupal environment, it is easy to enter and update record data, but getting it there was not as easy as we were hoping.  In hindsight, we should have scrapped version 5.7 and installed version 6.0 since we weren’t using the MARC module anyway.

When creating web pages using Drupal you must pick a theme or use the default. Themes allow you to customize the look and feel of your pages and/or site. Different themes have different functions and not all themes can be used with all versions. There are many themes ([http://drupal.org/project/Themes](http://drupal.org/project/Themes)) to pick from and they are easily applied. We chose a basic Garland default no frills theme and customized it with our University’s CSS, header, and footer.

Drupal organizes content by using *content types* and comes with only three standard types:  *blog*, *page,* and *story.* We needed to add a module that would enable us to create another content type. Modules in Drupal are plugins that extend its core functionality and are available at the Drupal site. When you install or activate a module, the new functionality is automatically integrated into Drupal, appearing as new menu items, tabs, or fields ready for you to use. Leo Klein’s presentation demonstrated how to use the [Content Construction Kit](http://drupal.org/project/cck) (CCK) to create content types. CCK allows you to add fields to an existing Drupal content type and/or create new content types. We created a custom content type called eResource. The eResource content type needed fields that would be searchable and display all the information related to each database.  For consistency, the fields we chose were the same as our old system: Title, URL, Description, Coverage Dates, and Alternate Title.

[![The CCK module allows the creation of new "content types"](https://journal.code4lib.org/wp-content/uploads/2010/06/image007-268x300.png "The CCK module allows the creation of new "content types"")](https://journal.code4lib.org/wp-content/uploads/2010/06/image007.png)

Figure 3. The CCK module allows the creation of new "content types"

We then enabled the optional core module taxonomy. Taxonomy allows you to classify content into categories and subcategories, multiple lists of categories for classification (controlled vocabularies) and offers the possibility of creating thesauri (controlled vocabularies that indicate the relationship of terms), taxonomies (controlled vocabularies where relationships are indicated hierarchically), and free vocabularies where terms, or tags, are defined during content creation. We created a vocabulary called “Subject” and added a list of terms. The terms are the names of each of our subjects (Art, Biology, etc.).

[![Taxonomy screen: where categories are created and edited](https://journal.code4lib.org/wp-content/uploads/2010/06/image011-300x245.png "Taxonomy screen: where categories are created and edited")](https://journal.code4lib.org/wp-content/uploads/2010/06/image011.png)

Figure 4. Taxonomy screen: where categories are created and edited

We then used the [Views](http://drupal.org/project/views) module to display the front page list of subjects in alphabetical order since Drupal’s default view is not alphabetical. We also had to create a view for the a-z list of databases by title. The combination of CCK and Views also enabled us to create a flexible and varied eResource content format to accommodate multiple descriptions and multiple URLs per resource if necessary, as well as the assignment of multiple subject heading categories to each resource.

There are many search modules available for Drupal and we tried quite a few before settling on Drupal’s own built-in search module.  Some of the search modules we tested included: [DynoSearcho](http://drupal.org/project/dynosearcho), [Faceted Search](http://drupal.org/project/faceted_search), [Fuzzy Search](http://drupal.org/project/fuzzysearch), [Live Search](http://drupal.org/project/livesearch), [Trip Search](http://drupal.org/project/trip_search), and a few others. Many of these search modules were excellent for specific types of searches and content, but because our Drupal DBL consists primarily of database names and descriptions, a customized search feature was not necessary. The built-in search module in Drupal consistently achieved the best results display for our purposes.  We did enhance the built-in search module by activating the optional core feature called “search config” which allowed us to configure the display of the advanced search form. Also, one of the release patches we installed improved partial word searching and provided better context delivery. We also tried the [Field Indexer](http://drupal.org/project/field_indexer) module, which provides a configuration page where the site administrator may select which fields to index. We decided not to use this module because we wanted all of our fields to be indexed for search. Lastly, [Porter-Stemmer](http://drupal.org/project/porterstemmer) was installed in an effort to improve search results for some librarians that were used to typing in shortened titles or acronyms. For example, typing in “pro” for “proquest”. Since this module uses a stemming algorithm to reduce each word in the search index to its basic root or stem it is supposed to retrieve more relevant search results. However, we found that it generated too many results and that the database they were looking for, Proquest, was getting lost in the result list. With the partial word patch applied, entering “proq” works just fine. Acronyms that did not appear in the title or descriptions were added to the Alt title field so that they could be indexed and searchable – the ALT title search had already been a feature of our previous DBL; for example, “ACS” for American Chemical Society.

We also installed the [FCKeditor](http://drupal.org/project/fckeditor) module, which is a visual HTML editor. It works by allowing Drupal to replace text area fields with a WYSIWYG editor. With the FCKeditor, formatting your text is simple, whether you know HTML or not.  We also used the [Autologout](http://drupal.org/project/autologout) and [Poormanscron](http://drupal.org/project/poormanscron) modules. The Autologout module does what its name implies. It allows the site administrator to set the time that will automatically logout users after a certain amount of inactivity. Poormanscron module is used to run basic cron jobs using normal browser page requests (as opposed to having to set up a crontab)*,* which are self-maintenance tasks like removing expired session information, and updating indexes and tables.

## Progress

Around the time the alpha Drupal instance was created, we were notified that the old DBL was no longer in jeopardy which resulted in the project being put on hold and the DBL taskforce being disbanded.  We continued working on the Drupal solution, however, because we knew we were onto something.  If we could get it to work as envisioned, then at least we would have a backup system in the short term, as well as a long-term opportunity to promote a more up-to-date context-based search system.

As it turned out, a few months after we completed this project, we learned that the FCLA DBL tool was *really* going away this time. That same week, FCLA had a very serious hardware-driven outage and the existing FCLA hosted DBL crashed, something that rarely (if ever) happened. Fortunately, our own Drupal DBL solution was ready and just needed to be made live. So we presented the option to the Head of Collections and Technical Services and were given the go ahead to make the Drupal DBL live. The data was still fairly up-to-date because not many records had changed since the last import. We came to the realization that, in all those years, there was no backup to the DBL system in place.  If it weren’t for the Drupal-based DBL, we would not have had copies of the data anywhere. FCLA probably had a copy, but they had other priorities, like bringing the extensive Florida SUS systems back online.   Having a local solution gave us the ability to bring an important library service back on line quickly.

[![New database page using Drupal, 2010](https://journal.code4lib.org/wp-content/uploads/2010/06/image005-300x205.png "New database page using Drupal, 2010")](https://journal.code4lib.org/wp-content/uploads/2010/06/image005.png)

Figure 5. New database page using Drupal, 2010

## Looking at our original objectives:

**Objective 1:** be searchable by title as well as keyword

Using the search box that comes with Drupal Search to search by database title was working just fine. It was the partial word search that was giving us some relevancy problems. We found a partial word search patch on the Drupal site and it was applied to the Drupal Search module. Applying the patch produces better context results to title and keyword searches.  Other patches and the application of the *search-config* were also applied to customize search box labels to be more descriptive and similar to previous DBL interface.

**Objective 2:** contain a subject list

We met this objective by creating categories as our subjects:  Biology, Health Professions, Art, etc.  and then assigning  the databases to the appropriate categories. Databases can be assigned to multiple categories, which is essential since so many databases cover more than one subject. From a maintenance point of view we don’t edit this list very often. When a new database gets added to Drupal it is entered manually and then assigned to a category or categories.

**Objective 3:** contain an a-z list

It is easy to create an A-Z list in Drupal using Views.

**Objective 4:** be reliable & fast

This solution has turned out to be reliable. We have had no failures or slow performance since the day we went beta.

**Objective 5:** easy to update – records need to be easy to add, delete, or edit with preferably no lengthy re-indexing time.

Drupal is very fast and easy to update. Data updates are performed through to the Drupal server by logging into Administration, choosing the database to edit, making the necessary changes, and hitting “publish”.  Re-indexing is configured to occur within minutes.  We backup the Drupal instance, but also created a simple flat html file that consists of the database name and the connection link. The HTML file resides on our staging web server, and we keep another copy on a share drive. Both get updated manually whenever the Drupal DBL records are changed in any way. In order to upgrade to a newer version of Drupal, we need to determine whether all our current modules and configurations are supported in the new Drupal version.  We are currently evaluating and anticipate upgrading sometime in 2010.

## For consideration

If you can live with not knowing *exactly* how items are ranked by Drupal’s search feature, then use the core Drupal Search.  While records display appropriately, some items appear farther down the list than would be expected. We would like to know how to get certain records to display higher or lower in the results list, but the mechanism of this is still a bit of a mystery.  Challenges include learning how to tweak descriptions so they appear higher on the results list or finding a different or customizable search module.  This is a weakness of all the search modules we tried. There appears to be no good way to completely control the granularity of relevancy results or to produce search results based on a mixture of hybrid factors, such as a combination of relevancy and preset manual index indicators.  This is one of the reasons we are very curious to experiment with Drupal 6 and the beta of version 7 to determine if search results can be better managed.

## Notes

1. Florida Center for Library Automation. (2009). [http://fclaweb.fcla.edu/](http://fclaweb.fcla.edu/)
2. Rosenthal, D. (2009). FGCU library website usability study. Unpublished manuscript. [http://library.fgcu.edu/webanalysis/reports/usabilitystudyreport.pdf](http://library.fgcu.edu/webanalysis/reports/usabilitystudyreport.pdf)
3. Klein, L. (05/15/2010). Screencast: Creating a library database page with Drupal. [http://chicagolibrarian.com/node/262](http://chicagolibrarian.com/node/262)

## About the Authors

Danielle Rosenthal is the Library Web Development and Science Liaison Librarian and Mario Bernardo is the Assitant Director of Library Computing and Technology Systems at the Florida Gulf Coast University.
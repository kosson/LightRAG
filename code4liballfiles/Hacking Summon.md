---
title: "Hacking Summon"
source: "https://journal.code4lib.org/articles/3655"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-09-22
created: 2025-01-10
description: "When the Oregon State University Libraries selected Serials Solutions' Summon as its discovery tool, the implementation team realized that they had an opportunity to implement a set of \"hacks\" that would improve the overall user experience. This article will explore the space between Summon's out-of-the-box user interface and full developer API, providing practical advice on [...]"
tags:
  - "clippings"
---
# Hacking Summon
Michael B. Klein

When the Oregon State University Libraries selected Serials Solutions’ Summon as its discovery tool, the implementation team realized that they had an opportunity to implement a set of “hacks” that would improve the overall user experience. This article will explore the space between Summon’s out-of-the-box user interface and full developer API, providing practical advice on tweaking configuration information and catalog exports to take full advantage of Summon’s indexing and faceting features. The article then describes the creation of OSUL’s home-grown open source availability service which replaced and enhanced the availability information that Summon would normally pull directly from the catalog.

## History

In late 2009, the Oregon State University Libraries (OSUL) Discovery Service Task Force selected Summon from Serials Solutions to serve as its next generation discovery interface. \[[1](https://journal.code4lib.org/articles/#note1)\] Implementation took place between January and March 2010. As the implementation progressed, the OSUL Summon Implementation Team discovered several aspects of the interface they wanted to customize. Instead of requesting changes from the vendor, OSUL developed a number of “hacks” – elegant solutions that worked within the framework of Summon’s existing functionality – to accomplish its desired goals.

## What is Summon?

Serials Solutions’ Summon unified discovery service promises to deliver “instant access to the breadth of authoritative content that’s the hallmark of great libraries – digital and print, audio and video, single articles to entire e-journals, and every format in between.” \[[2](https://journal.code4lib.org/articles/#note2)\] Since its introduction in early 2009, the installed base has expanded to “95 Summon customers – mostly 4-year academic institutions,” \[[3](https://journal.code4lib.org/articles/#note3)\] serving a potential population of hundreds of thousands of library patrons.

## Yes, but what is Summon?

From the perspective of an institutional implementation team, it’s helpful to look at Summon as a combination of three separate components.

### Summon is an Index

The heart of Summon is its index. The index is based on the Apache Solr search platform, which in turn is a frontend to the Lucene indexing engine. \[[4](https://journal.code4lib.org/articles/#note4)\] Summon’s index consists of e-book and article metadata from participating publishers, catalog records from implementing institutions, and other information harvested from institutional repositories and other digital collections via the Open Archives Initiative Protocol for Metadata Harvesting (OAI-PMH). As of this writing, Serials Solutions claims to have over 500,000,000 items indexed from over 94,000 journal and periodical titles. \[[5](https://journal.code4lib.org/articles/#note5)\] By combining information in the index with Serials Solutions’ knowledge of subscribers’ electronic holdings, Summon is able to determine which items are part of a given institution’s print collections, which are available online as full text, which are available as online citations, and which would require inter-library or other extra-institutional requests to access.

### Summon is an API

The Summon Application Programming Interface is a REST-based web service that exposes Summon’s discovery functionality. Calls to the API can be used to query the index, refine existing searches, retrieve database recommendations based on a specific set of search terms, request item availability information from the local catalog, and even discover the fields and facets exposed by the index. With virtually all of Summon’s functionality exposed through the API, it is possible to integrate Summon with existing web sites, content management systems, courseware, or even to create a complete discovery interface from the ground up. An API tutorial is beyond the scope of this article, but since the hacks discussed below will affect results retrieved via the API as well as results that appear in the default user interface, it’s important to understand its place in the Summon ecosystem.

### Summon is a Web Application

The most visible part of Summon, and the part most users’ experiences are filtered through, is the web application that Serials Solutions has built on top of the API. The application provides a rich user interface with a clean search results layout, dynamic control of facets, and a “saved record” folder. Since the application is hosted by the vendor, libraries are limited as to the customizations they can make to the user interface.

The rest of this article will focus on leveraging the architecture of the Summon web application in order to gain greater control over how certain results are displayed. It’s worth noting that the hacks described don’t intercept, change, rewrite, or redirect a single line of code within the Summon application itself. Instead, they involve changing the data Summon sees. As a result, the reader may choose to see this less as “Hacking Summon” and more as “Taking Control of Closed-Source Vendor Applications Through Creative Data Munging.”

For convenience, from this point forward, the default web application and its user interface will be referred to as “Summon.” Any references to the index or the API will be made explicitly by name.

## Hacking Location Codes

One of the first pieces of information Serials Solutions asks for when setting up a new Summon instance is a mapping from the library location codes used in the MARC records to displayable location names. The easy and obvious thing to do is to export that list from the ILS and send it along. When OSU Libraries did just that, the result was a list of almost 110 codes, some of which represented a relatively small number of items. While the level of specificity represented by each code is helpful in locating the item, it’s much less helpful to have a list of values that long in a single facet. When narrowing a search by location, the patron is more likely concerned with what building the items are in, not which stacks on which floor.

OSU Libraries’ solution was to ask Serials Solutions to re-index all of their catalog content, using a consolidated list of location codes. The 58 variations of “Valley Library” (including “Valley Docs,” “Valley Docs Oversize,” “Valley Maps,” “Valley Maps Oversize,” etc.) were reduced to just three values: “Valley Library,” “Valley Archives,” and “Valley Special Collections.” The 15 “Guin/HMSC” variants were combined under “Guin Library, Hatfield Marine Science Center.” This smaller list of locations leads to more efficient discovery of resources, while the specific location string – which is still displayed with the individual item record – aids in retrieval.

[![Figure 1](https://journal.code4lib.org/media/issue11/klein/fig1_sm.png)](https://journal.code4lib.org/media/issue11/klein/fig1.png "Click to display full-size image") **Figure 1.** Library Location Facet and Item Location Display.

## Hacking MARC Records

Summon’s ability to discover items in a library’s physical collection depends on importing the institution’s MARC records into the Summon index. During the implementation phase, a complete export of all MARC records in the ILS is sent to Serials Solutions, where the fields are mapped to the appropriate fields in Summon’s index, and the entire corpus is indexed. It is up to the library to provide updates via FTP at whatever interval they choose. OSU Libraries provides updates once per day.

The fact that updates are sent as MARC files provides an opportunity to hack those records on the way out. For example, OSU Libraries has a large number of government documents shelved by SuDoc number rather than Library of Congress call number. Summon displays whichever number is present, or both if the record contains both. This proved to be confusing for users who would make note of the LC call number, only to find that it didn’t lead them anywhere once they arrived in the right section. The solution: strip the LC call number (fields 050 and 090) from any record that had a Gov. Docs location code and a SuDoc (field 086). \[[6](https://journal.code4lib.org/articles/#note6)\]

## Hacking Availability Information

Summon’s ability to display real-time availability information for items in the local collection depends on a series of interactions between the web application, the Summon API’s availability service, and (typically) the institution’s OPAC. A typical request/response cycle looks something like this:

1. The client submits a search form to the Summon application.
2. The server queries the index via the Summon API.
3. The server returns results to the client as HTML.
4. The client sends an AJAX request to the Summon Availability API requesting real-time availabilities for physical items.
5. While waiting for a response, the client displays the results, allowing the user to start evaluating them or further refine the search.
6. The Summon Availability API acquires availability information from the library’s OPAC. To do so, it must retrieve the HTML page for each item one at a time, scrape the availability and location information out of the page, and assemble the data into a response.
7. Availability data is returned to the client as JSON, parsed, and displayed at the appropriate location(s) within the page.

For print monographs, this approach works well. But for items with links in 856 fields, journals available both in print and electronically, or items like serials or government documents consisting of a large number of dated volumes, the Summon view can actually be less informative than the native OPAC view. For example, the default screen-scraper view of OSU Libraries’ Library Journal holdings looks like this:

[![Figure 2](https://journal.code4lib.org/media/issue11/klein/fig2_sm.png)](https://journal.code4lib.org/media/issue11/klein/fig2.png "Click to display full-size image") **Figure 2.** Default Availability Display.

Several volumes of print holdings are displayed and listed as available, but there’s no indication of the true extent of the print collection, how many other volumes are available, or whether the journal is available online in any way.

To provide greater control over the display of availability information, OSUL developed a fast, lightweight item availability service that sits between the Summon Availability API and the OPAC. Summon now sends one or more requests to the OSUL Availability Service, which in turn scrapes the OPAC for the required information, and returns an XML response. Using the new, mediated service allows OSUL’s Summon instance to provide a more useful view of holdings and availability:

[![Figure 3](https://journal.code4lib.org/media/issue11/klein/fig3_sm.png)](https://journal.code4lib.org/media/issue11/klein/fig3.png "Click to display full-size image") **Figure 3.** Item Record with Enhanced Availability Information.

Serial holdings are summarized, the full extent of the collection is visible, and online access options are prominently displayed with live links.

There are a number of other advantages to this approach:

- The OSUL Availability Service can look up multiple items in a single request, allowing for fewer round-trip requests between the Summon server and the OPAC.
- Since the OSUL Availability Service and the OPAC are on the same local network, the Internet bandwidth and latency delays involved in a given availability request are greatly reduced.
- If the OPAC template changes, any changes necessary to support Summon can be made quickly in house, without requiring any action on the part of the vendor.
- Other applications can benefit from real-time, client-friendly item availability information with very little effort.

The OSUL Availability Service uses a response format based on the Summon Availability API response format. \[[7](https://journal.code4lib.org/articles/#note7)\] The decision to use Summon’s response format was made not because of any specific technical requirement – Serials Solutions was prepared to work with any well-formed XML response – but because it was well-suited to the purpose. The decision provided one side benefit as well – by using a local proxy server on the development workstation, the developer was able to re-route calls bound for the Summon Availability API to the development instance of the local availability service. Since the wire protocols are functionally identical, this allowed for real-time, in-browser testing of the availability service’s output without disrupting service to patrons.

### Examples

A simple availability request/response between Summon and OSUL’s Availability Service looks like this:

```
GET /availability?s.id=b20600380&s.id=b2584345x&s.id=b25012393&s.id=b23795438&s.id=b23896188
Accept: application/xml
```

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34 | `<?``xml` `version``=``"1.0"``?>`  `totalRequestTime``=``"0"` `version``=``"0.1.8"` `scraperClass``=``"OasisScraper"``>`  `<``availabilityItems``>`  `<``availabilities` `bib``=``"b2060038"` `expires``=``"2010-08-27T10:15:08-07:00"` `id``=``"b20600380"``>`  `<``availability` `displayString``=``"AVAILABLE, Valley, QA76.6 .H857 2000"`  `statusMessage``=``"AVAILABLE"` `callNumber``=``"QA76.6 .H857 2000"`  `locationString``=``"Valley"` `status``=``"available"``/>`  `<``availability` `displayString``=``"AVAILABLE, COCC Second Floor, QA76.6 .H857 2000"`  `statusMessage``=``"AVAILABLE"` `callNumber``=``"QA76.6 .H857 2000"`  `locationString``=``"COCC Second Floor"` `status``=``"available"``/>`  `</``availabilities``>`  `<``availabilities` `bib``=``"b2584345"` `expires``=``"2010-08-27T10:12:24-07:00"` `id``=``"b2584345x"``>`  `<``availability` `displayString``=``"AVAILABLE, Valley, QA76.64 .P47 2010"`  `statusMessage``=``"AVAILABLE"` `callNumber``=``"QA76.64 .P47 2010"`  `locationString``=``"Valley"` `status``=``"available"``/>`  `</``availabilities``>`  `<``availabilities` `bib``=``"b2501239"` `expires``=``"2010-08-27T10:15:08-07:00"` `id``=``"b25012393"``>`  `<``availability` `displayString``=``"AVAILABLE, Valley, G70.212 .S54 2008"`  `statusMessage``=``"AVAILABLE"` `callNumber``=``"G70.212 .S54 2008"`  `locationString``=``"Valley"` `status``=``"available"``/>`  `</``availabilities``>`  `<``availabilities` `bib``=``"b2379543"` `expires``=``"2010-08-27T10:12:24-07:00"` `id``=``"b23795438"``>`  `<``availability` `displayString``=``"AVAILABLE, Valley, QA63 .W55 2005"`  `statusMessage``=``"AVAILABLE"` `callNumber``=``"QA63 .W55 2005"`  `locationString``=``"Valley"` `status``=``"available"``/>`  `</``availabilities``>`  `<``availabilities` `bib``=``"b2389618"` `expires``=``"2010-08-27T10:12:24-07:00"` `id``=``"b23896188"``>`  `<``availability` `displayString``=``"AVAILABLE, Valley, QA76.76.D47 R53 2005"`  `statusMessage``=``"AVAILABLE"` `callNumber``=``"QA76.76.D47 R53 2005"`  `locationString``=``"Valley"` `status``=``"available"``/>`  `</``availabilities``>`  `</``availabilityItems``>`  `</``response``>` |
| --- | --- |

The Library Journal example depicted in [Figure 3](https://journal.code4lib.org/articles/#fig3), with entity-encoded embedded HTML links \[[8](https://journal.code4lib.org/articles/#note8)\], is a bit more complex:

Like Summon’s availability API, OSUL’s Availability Service provides response data in XML (application/xml), JSON (application/json), or streaming, newline-delimited JSON (application/json-stream) based on the Accept: header provided by the client. For example:

```
GET /availability?s.id=b1903187
Accept: application/json
```

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45 | `{`  `"totalRequestTime"``: 1,`  `"version"``: ``"0.1.8"``,`  `"scraperClass"``: ``"OasisScraper"`  `"availabilityItems"``: [`  `{`  `"expires"``: ``"Tue Aug 31 14:30:14 -0700 2010"``,`  `"bib"``: ``"b1903187"``,`  `"id"``: ``"b1903187"``,`  `"availabilities"``: [`  `{`  `"statusMessage"``: ``"AVAILABLE (Apr. 01, 2001-)"``,`  `"date_start"``: ``"2001-04-01"``,`  `"status"``: ``"available"``,`  `"link_title"``: ``"LexisNexis:Academic"`  `},`  `{`  `"statusMessage"``: ``"AVAILABLE (May 01, 1976-)"``,`  `"date_start"``: ``"1976-05-01"``,`  `"status"``: ``"available"``,`  `"link_title"``: ``"Business Source Premier"`  `},`  `{`  `"statusMessage"``: ``"LIBRARY OWNS v.101 no.9 (May 1976)-"``,`  `"displayString"``: ``"LIBRARY OWNS v.101 no.9 (May 1976)- / Valley Z671 .L7"``,`  `"locationString"``: ``"Valley Z671 .L7"``,`  `"status"``: ``"available"`  `},`  `{`  `"statusMessage"``: ``"LIBRARY OWNS v.125, no.1(Jan. 2000)-present on paper."``,`  `"displayString"``: ``"LIBRARY OWNS v.125, no.1(Jan. 2000)-present on paper. / COCC Periodicals"``,`  `"locationString"``: ``"COCC Periodicals"``,`  `"status"``: ``"available"`  `}`  `],`  `}`  `],`  `}` |
| --- | --- |

The availability service scrapes all holdings and availability information out of the HTML view of OSU’s III Millennium OPAC in real-time. \[[9](https://journal.code4lib.org/articles/#note9)\] Holdings are prioritized in the following order: (1) Full-text online resources; (2) Summary holdings (if present); (3) Individual holdings (if no summary present); (4) Summary online resources (such as TOCs, abstracts, and archival finding aids).

### Code

OSU Libraries’ Availability Service is written in Ruby using the Sinatra web micro-framework. \[[10](https://journal.code4lib.org/articles/#note10)\] The source code is available under an MIT license at [http://github.com/mbklein/availability-server](http://github.com/mbklein/availability-server).

## Conclusion

Summon has a vast index, as well as a comprehensive API that encourages active development. Most institutions, however, will likely focus their deployment strategy on the vendor’s existing web application. By learning to finesse the data that Summon indexes, and writing software that lives in the gaps between Summon’s index and the library’s OPAC, customers can customize the user experience and presentation of results in a way that works best for their patrons.

More importantly, there’s nothing Summon-specific about any of the techniques presented in this article; any application that relies on customer-provided data can be hacked to a certain degree. While Summon’s AJAX architecture provides a convenient insertion point for custom live availability data, the other two hacks involve simple manipulations of exported MARC records. The trick to hacking closed-source applications lies in learning how to hack the data they consume.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Chadwell Faye, et al. 2009. Discovery Services Task Force Recommendation to University Librarian \[Internet\]. ScholarsArchive at Oregon State University; \[cited 2010 Sept 10\]. Available from: [http://hdl.handle.net/1957/13817](http://hdl.handle.net/1957/13817)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Summon \[Internet\]. Serials Solutions; \[cited 2010 Sept 10\]. Available from: [http://www.serialssolutions.com/summon/](http://www.serialssolutions.com/summon/)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Nagy, Andrew. Personal communication, 2010 July 23.

\[[4](https://journal.code4lib.org/articles/#ref4)\] Welcome to Solr \[Internet\]. Apache Software Foundation; \[cited 2010 Sept 10\]. Available from: [http://lucene.apache.org/solr/](http://lucene.apache.org/solr/)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Summon Content & Coverage \[Internet\]. Serials Solutions; \[cited 2010 Sept 10\]. Available from: [http://www.serialssolutions.com/summon-content-and-coverage/](http://www.serialssolutions.com/summon-content-and-coverage/)

\[[6](https://journal.code4lib.org/articles/#ref6)\] The downside to this approach is that the LC call number is no longer indexed, so the affected items can no longer be found by searching on the LC call number. While it’s true that the same effect could have been accomplished without this compromise by asking Serials Solutions to change the display options for certain location codes, the OSUL implementation team decided the tradeoff was worth it to keep control over these kinds of display issues in house.

\[[7](https://journal.code4lib.org/articles/#ref7)\] Availability API \[Internet\]. Serials Solutions; \[cited 2010 Sept 10\]. Available from: [http://api.summon.serialssolutions.com/help/api/availability](http://api.summon.serialssolutions.com/help/api/availability)

\[[8](https://journal.code4lib.org/articles/#ref8)\] Embedding HTML in the displayString and locationString attributes isn’t ideal, as it limits the portability of the data to non-HTML systems, but it’s the only way to get Summon to pass those links through to the client. As a compromise, the raw link title, status, location, and date range information are passed through in other attributes.

\[[9](https://journal.code4lib.org/articles/#ref9)\] Actually, for performance reasons, results are cached – 5 minutes for circulating materials, and 30 minutes for non-circulating and electronic holdings.

\[[10](https://journal.code4lib.org/articles/#ref10)\] Sinatra \[Internet\]; \[cited 2010 Sept 10\]. Available from: [http://www.sinatrarb.com/](http://www.sinatrarb.com/)

Michael B. Klein is the Digital Applications Librarian at Oregon State University. His previous experience includes a stint as the Digital Initiatives Technology Librarian for the Boston Public Library, where he worked on digitization workflow and digital repository projects, and several years as a contract software developer for the U.S. Census Bureau. He enjoys elegant programming solutions almost as much as he loves clever hacks. Most days, he can be found in the #code4lib IRC channel on Freenode trying to teach the old channel bot new tricks.
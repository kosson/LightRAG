---
title: "Building a Location-aware Mobile Search Application with Z39.50 and HTML5"
source: "https://journal.code4lib.org/articles/2947"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-06-22
created: 2025-01-10
description: "This paper presents MyTPL (http://www.mytpl.ca), a proof-of-concept web application intended to demonstrate that, with a little imagination, any library with a Z39.50 catalogue interface and a web server with some common open-source tools can readily provide their own location-aware mobile search application. The complete source code for MyTPL is provided under the GNU GPLv3 license, [...]"
tags:
  - "clippings"
---
# Building a Location-aware Mobile Search Application with Z39.50 and HTML5
MJ Suhonos

This paper presents MyTPL ([http://www.mytpl.ca](http://www.mytpl.ca/)), a proof-of-concept web application intended to demonstrate that, with a little imagination, any library with a Z39.50 catalogue interface and a web server with some common open-source tools can readily provide their own location-aware mobile search application. The complete source code for MyTPL is provided under the GNU GPLv3 license, and is freely available at: [http://github.com/mjsuhonos/mytpl](http://github.com/mjsuhonos/mytpl/)

## Introduction

The Toronto Public library (TPL) has 100 branches \[[1](https://journal.code4lib.org/articles/#note1)\] spread relatively evenly over nearly 450 square kilometres (Figure 1).  With over 11 million items in this highly distributed collection, a common question among users is “where is the nearest copy of an item to where I’m currently standing?”   Given the proliferation of location-aware mobile devices, such as GPS-enabled smartphones, and the ubiquity of urban wireless Internet access, the solution to this type of known-item query should be readily available to the library or any motivated programmer with some technical savvy and access to open data and technology.

[![Map of TPL Branches](https://journal.code4lib.org/media/issue10/suhonos/figure1_small.png)](https://journal.code4lib.org/media/issue10/suhonos/figure1.png)

**Figure 1.** Map of TPL branches

In December 2009, I decided to undertake this challenge with the goals of determining: a) whether it was technically possible to construct a tool-chain which could address this specific kind of query; b) what organizational or technical obstacles might exist in implementing such a tool-chain; and c) how reproducible such an approach would be for other libraries in North America and even internationally.

The result of this project is a lightweight mobile web application, called MyTPL ([http://www.mytpl.ca/](http://www.mytpl.ca/)), which queries the Z39.50 interface of TPL’s SirsiDynix Symphony ILS based on user-provided search terms, and returns a list of matching items in the library’s collection.  When an item is selected, MyTPL displays a detailed list of branches which possess a copy of the item, a current holding status, and – if the device’s GPS hardware is enabled – links to display a map with directions from the user’s current location.

This project was specifically done without any privileged knowledge or access otherwise unavailable to a member of the general public.  Although I am an employee of TPL, MyTPL is not officially acknowledged or endorsed by the Toronto Public Library.

## Mobile Applications for Libraries

The growth of smartphone use in recent years has led to a surge in popularity of mobile applications for countless uses, including providing access to library holdings and services. Griggs, Bridges, and Rempel discuss, in a previous Code4Lib Journal article, the unique features provided by mobile devices (including location awareness), as well as the limitations of existing hardware and usability issues imposed by the small form factor \[[2](https://journal.code4lib.org/articles/#note2)\].  Perhaps more importantly, there is an active discussion at commonplace.net concerning strategies and best practices for developing mobile tools, including debate around when to deploy them as platform-specific applications, versus mobile-tailored web applications \[[3](https://journal.code4lib.org/articles/#note3)\].

To date, the trend has strongly been toward developing iPhone-specific applications, most likely due to the device’s dominance in the mobile market over the past several years.  Some of the applications in the iPhone App Store include WorldCat Mobile from OCLC \[[4](https://journal.code4lib.org/articles/#note4)\] (Figure 2), Local Books from LibraryThing \[[5](https://journal.code4lib.org/articles/#note5)\], and institution-specific applications like SPL Mobile from the Seattle Public Library \[[6](https://journal.code4lib.org/articles/#note6)\].  These applications, however, are limited to a small number of Apple-made devices: the iPhone, the iPod Touch, and the iPad.  With the introduction of the Apple iPad SDK in January 2010, even development for devices based on this platform has begun to fragment.  Additionally, given the long-standing and ever-present critique of Apple’s review policies for iPhone applications \[[7](https://journal.code4lib.org/articles/#note7)\], the greater flexibility and lower risk for multi-platform – or at least web-based – mobile applications seems to provide a more promising way forward.

[![WorldCat Mobile App UI for search, list, and detail pages](https://journal.code4lib.org/media/issue10/suhonos/figure2_small.png)](https://journal.code4lib.org/media/issue10/suhonos/figure2.png)

**Figure 2.** WorldCat Mobile App UI for search, list, and detail pages

While some institutions are developing simplified versions of web interfaces as a means of providing basic cross-platform support for their services, these implementations tend to be inconsistent in user experience and interface design.  Worse, they can border on the useless –  LibraryThing Mobile \[[8](https://journal.code4lib.org/articles/#note8)\], for example, begins with an uninformative “user name” entry box on the login screen and provides an extremely basic display in the detail view (Figure 3).  Similarly, Mississippi State University’s mobile online catalog \[[9](https://journal.code4lib.org/articles/#note9)\] uses a customized version of the SirsiDynix iBistro web application, based on the outdated Common Gateway Interface (CGI), and is difficult to navigate and performs poorly as a result.

[![LibraryThing Mobile UI for list and detail pages](https://journal.code4lib.org/media/issue10/suhonos/figure3_small.png)](https://journal.code4lib.org/media/issue10/suhonos/figure3.png)

**Figure 3.** LibraryThing Mobile UI for list and detail pages

Many cross-platform implementations are done through the services of third-party development vendors such as Boopsie, who claim “if you can create a spreadsheet, you can create a mobile application; one that works across any phone with a data plan” \[[10](https://journal.code4lib.org/articles/#note10)\].  Certainly the promise of low-cost, universally-compatible mobile applications is appealing, but one of the major trade-offs of such an approach is it necessarily limits hardware functionality to the smallest subset available on all devices.  The WorldCat Mobile App, for example, cannot access the iPhone’s GPS hardware, significantly impairing the user experience. In January 2010, LibraryThing announced Library Anywhere, a paid service promising “a mobile catalog for any library” and “Mobile web and apps for iPhone, Blackberry and Android” \[[11](https://journal.code4lib.org/articles/#note11)\]. ALA TechSource provided pricing and technical details for Library Anywhere in March 2010, along with an expected release in April \[[12](https://journal.code4lib.org/articles/#note12)\], but as of June 2010, it has not been formally released.

## Problem Domain and Approach Taken

While there is an important need for libraries to clearly understand which services users desire in a mobile application on any platform \[[13](https://journal.code4lib.org/articles/#note13)\], the service provided by the MyTPL project was intentionally chosen to be basic: it was specifically restricted to known-item searches.  From a technical perspective, the overall objective was to translate a set of search terms into a set of geographic coordinates corresponding to a physical copy of an item.

Given the considerations and restrictions of developing an iPhone-specific application outlined above, the technical requirements for the application were:

1. Develop MyTPL as a web-based application targeting the WebKit browser engine \[[14](https://journal.code4lib.org/articles/#note14)\], which is used in the iPhone’s browser, Mobile Safari.
2. Reduce barriers for replicating the application in other libraries by using open-source tools and open standards whenever available.

In order to provide a user experience consistent with native iPhone applications, I searched for a UI framework based on the iPhone interface guidelines and found two prominent frameworks: Universal iPhone UI Kit (UIUIKit) \[[15](https://journal.code4lib.org/articles/#note15)\] and iPhone User Interface Framework (iUI) \[[16](https://journal.code4lib.org/articles/#note16)\].  Based solely on the Google Code activity rating of “high” – indicating development on the framework was relatively current – I chose to implement the iUI framework.

The next issue was determining what access, if any, was available to TPL’s catalogue records.  While a number of libraries have provided deposits of their complete catalogue in repositories such as the Internet Archive \[[17](https://journal.code4lib.org/articles/#note17)\], such records are static (i.e. not reflective of real-time holdings data), do not necessarily contain branch information, and most importantly, TPL had not made any such submission. Like a majority of libraries, however, TPL operates a Z39.50 server to cooperatively share access to their catalogue records with other libraries in real-time \[[18](https://journal.code4lib.org/articles/#note18)\].  Moreover, public access to the Z39.50 interface is not restricted in any way.  Based on some rudimentary experimentation and using some sample PHP code from a library colleague \[[19](https://journal.code4lib.org/articles/#note19)\], I was able to establish a set of parameters which allow simple Z39.50 queries to return MARCXML from TPL’s catalogue, including branch holdings information.  While not every library ILS will encode real-time holdings information in the MARCXML records provided via its Z39.50 interface, there is still enough information to make the application useful, e.g. for single-location libraries.

The bulk of the remaining effort was to design a framework which would integrate the iUI interface with the Z39.50 query back-end in a lightweight and logical manner.  Owing to my familiarity with the LAMP (Linux, Apache, MySQL, PHP) web platform, I created a small Linux virtual machine (VM) on an Apple Mac Mini to begin MyTPL development.  Lastly, thanks to the open-source YAZ toolkit from Index Data, the PHP/YAZ extension \[[20](https://journal.code4lib.org/articles/#note20)\] was easily integrated.  PHP/YAZ is a client library for connecting to and querying Z39.50/SRU/SRW servers directly from PHP, and is readily available on many Linux distributions.

## System Design and Architecture

The design of MyTPL is a classic three-tier client-server architecture (Figure 4).  The data tier exists behind TPL’s SirsiDynix Z39.50 interface – in essence, treating it like a precursor to today’s modern web services.  Due to the variant nature of Z39.50 implementations between ILS vendors, the data tier acts much like a “black box” in terms of being largely opaque to how it functions, for example, how retrieved search results are ordered.

[![MyTPL system architecture](https://journal.code4lib.org/media/issue10/suhonos/figure4_small.png)](https://journal.code4lib.org/media/issue10/suhonos/figure4.png)

**Figure 4.** MyTPL system architecture

The application tier resides on the web server, with application logic written in PHP and making use of a number of common extensions: DOM/XML, XSLT, and PHP/YAZ.  In essence, the application is a linear transformation pipeline, with three functions:

1. Search (Home/landing page): pass query terms from an HTML form to the Z39.50 server
2. List (Search results page): display summary metadata from Z39.50 MARCXML response
3. Detail (Detailed view page): display detailed metadata from above, as well as from external web services (e.g. cover artwork from Open Library), and geocoded links if GPS is enabled

Screenshots of each of these three functions can be seen in Figure 5.

[![MyTPL UI for search, list, and detail pages](https://journal.code4lib.org/media/issue10/suhonos/figure5_small.png)](https://journal.code4lib.org/media/issue10/suhonos/figure5.png)

**Figure 5.** MyTPL UI for search, list, and detail pages

The data transformation pipeline within the PHP application serves to convert binary MARC21 delivered via Z39.50 from the data tier to a simpler and more presentable HTML format appropriate for presenting to users (Figure 6).  The conversion from MARC21 to MARCXML (and any encoding from MARC-8 to UTF-8) is handled transparently by the PHP/YAZ library.  Next, the real-time branch holdings information is extracted from MARC field 926, and the record is transformed into MODS XML using XSLT provided by the Library of Congress \[[21](https://journal.code4lib.org/articles/#note21)\].  The major reason for this transformation is to simplify the metadata being displayed, e.g. removing ISBD punctuation, re-mapping ISO-639 codes to language names, general string scrubbing, etc.  Finally, some XPath-based selection is performed using Document Object Model (DOM) on the MODS record to populate variables for displaying in HTML, both for the compact search results list, as well as the detailed view page.

[![MyTPL transformation pipeline](https://journal.code4lib.org/media/issue10/suhonos/figure6_small.png)](https://journal.code4lib.org/media/issue10/suhonos/figure6.png)

**Figure 6.** MyTPL transformation pipeline

The presentation tier consists of the iUI framework using CSS and JavaScript on the mobile device.  Access to the device’s GPS or other location-gathering hardware is done with JavaScript via the W3C Geolocation API \[[22](https://journal.code4lib.org/articles/#note22)\] as provided with the HTML5 specification.  The user is presented with a dialogue box to provide their latitude and longitude when the MyTPL home page is loaded.  If the user declines, or if GPS hardware is not available, the application still functions normally, and item holdings are presented in alphabetical order.  If the user allows MyTPL to determine their position, then holdings are presented in order of geographic distance, closest being first, with an approximate distance shown in kilometers.

The fourth function of MyTPL, displaying directions between the user’s current location and a selected branch, is handed off to Google Maps and displayed either in a new browser window or by a native application on the mobile device (Figure 7).  On the iPhone platform this is done using a standard Google Maps URL containing the latitude and longitude of start and end points, which allows the Maps application to handle logic and presentation around directions, travel time estimates, etc.  The main drawback, however, is that it requires the user to leave the MyTPL application entirely, and they must switch applications if they wish to begin their search anew.

[![iPhone (Google) Maps application showing directions](https://journal.code4lib.org/media/issue10/suhonos/figure7_small.png)](https://journal.code4lib.org/media/issue10/suhonos/figure7.png)

**Figure 7.** iPhone (Google) Maps application showing directions

## Discussion and Future Directions

When developing for a mobile platform, particularly for wireless Internet access, performance considerations are paramount to delivering an effective user experience.  MyTPL makes heavy use of simple caching at every point in the transformation pipeline to optimize response times as much as possible.  This is an especially important consideration given the legacy nature and typically slow response of the Z39.50 protocol.  In addition, cover art is retrieved asynchronously from a number of open web APIs, such as LibraryThing, Open Library, Google Books, and Movie Poster DB.  By returning, and subsequently caching, the first image available, page requests are kept lightweight and minimal.  Thus, MyTPL performance will actually benefit from additional use, as more metadata and images are stored locally over time.

Based on limited informal user feedback, cover art availability is far from ideal – in many cases, it can even be completely erroneous, depending on the source – but is extremely useful in providing visual cues for identifying and selecting a user’s desired item.  In many ways, it acts as a surrogate for richer metadata, allowing a minimal number of elements to be used: title, author, format, language, year, and number of copies.  A full MODS description is available on the detailed view page, and content summaries or abstracts are provided for certain items where available.  In this particular area, there remains much room for improvement; for example, a sample integration with last.fm could provide high-quality music album descriptions with very little effort.  One can only imagine what kind of catalogue enhancement would be possible by retrieving additional metadata for movies or music from other openly-available web services.

One particularly serendipitous aspect of MyTPL discovered early on was that branch holdings information was, in fact, provided in real-time.  Although a static mapping had to be developed between branch names embedded in MARC data and geographic coordinates of the branch locations, this functionality gives MyTPL the bulk of its usefulness.  While many library ILSes will not encode branch holdings information in MARCXML records provided via their Z39.50 interface, in practice there is often information within the MARC data that can be used to similarly identify points that can be used for item location.  Perhaps more promising would be investigating the use of the Z39.50 OPAC record format \[[23](https://journal.code4lib.org/articles/#note23)\], which is designed specifically for exposing real-time holdings information.

Also serendipitous was the discovery much later that geolocation fully works with location-aware desktop browsers, such as Firefox 3 on Mac OSX 10.6 using the Core Location framework.  MyTPL was also later verified to work equally well on the Browser application on mobile devices using the Android operating system, which also uses the WebKit browser engine.  Although the UI is specifically designed for a mobile handheld display, it is not unreasonable to assume the application will continue to work equally well on a variety of W3C-compliant browsers and platforms, both desktop and mobile.

Additionally, while the W3C Geolocation API ensures a degree of cross-platform compatibility among browsers, it also allows the possibility of keeping all location information – considered potentially sensitive by some – entirely on the client.  While MyTPL does not take the approach to perform distance calculations on the server, it would not be technically challenging to modify the application to do so.  There are several additional alternatives for determining location, including IP address, Wi-Fi connection (such as SkyHook Wireless \[[24](https://journal.code4lib.org/articles/#note24)\] as used by Core Location), and of course, the user self-disclosing a postal code or address.

## Conclusion

*“Everything should be made as simple as possible, and no simpler.”* – Albert Einstein

MyTPL takes a ”less is more” approach to mobile library application design.  By their dynamic nature, online search tools lend themselves well to web-based applications.  While platform-specific mobile applications can provide a richer and more tightly-integrated interaction, judicious use of modern web standards can still deliver a satisfying user experience.  Also key to building a successful mobile search application is delivering information in as rapid and minimal a way as possible.  When complexity cannot be avoided, it should be hidden from the user; instead, the user interface should provide a familiar and consistent style and layout.

Perhaps the greatest strength of MyTPL as an application is that it is built entirely on open-source software and technology, freely available to anyone wishing to implement it.  Moreover, because the Z39.50 interface is common among most libraries, MyTPL should be readily deployable with an absolute minimum of effort and configuration.  To date, it has already been tested with three Canadian academic libraries, and while the TPL-specific location mapping generally does not function, the rest of the application performs as expected.  Thus, MyTPL provides a simple yet robust foundation for a large number of libraries to begin developing their own location-aware mobile catalogue search.

Like the tools it is built upon, MyTPL is available openly and freely, in a spirit of sharing and mutual experimentation.  The complete source code is provided under the terms of the GNU GPLv3 license \[[25](https://journal.code4lib.org/articles/#note25)\], which provides the ability to relicense software based on MyTPL under the GNU Affero GPL v3 license \[[26](https://journal.code4lib.org/articles/#note26)\].  The GNU Affero clause requires servers running the code to continue to make it available in whole, including any modifications that have been made.  In this way, improvements to MyTPL may be guaranteed to be perpetually available to the international library community.

A common tenet of effective software, especially among the open source community, is to build tools that “scratch your own itch.”  MyTPL is one example of this philosophy put into practice.  By focusing on solving the user’s specific problem using the tools available at hand – not necessarily the most complex, or the most cutting-edge, but rather an efficient combination of old and new – libraries can conceive of new ways to deliver modern services, while at the same time, leveraging those established technologies which would otherwise be relegated solely to their original purpose.

## References

[1](https://journal.code4lib.org/articles/#ref1). Hours & Locations \[Internet\]. Toronto Public Library; \[cited 2010 Jun 08\]. Available from: [http://beta.torontopubliclibrary.ca/branches-and-hours.jsp](http://beta.torontopubliclibrary.ca/branches-and-hours.jsp)

[2](https://journal.code4lib.org/articles/#ref2). Griggs K, Bridges L, Rempel H. 2009. Library/mobile: Tips on Designing and Developing Mobile Web Sites. Code4Lib Journal \[Internet\]. \[cited 2010 Jun 08\]; Issue 8. Available from: [http://journal.code4lib.org/articles/2055](https://journal.code4lib.org/articles/2055)

[3](https://journal.code4lib.org/articles/#ref3). Mobile App or Mobile Web? \[Internet\]. Commonplace.net; \[cited 2010 Jun 08\]. Available from: [http://commonplace.net/2010/02/mobile-app-or-mobile-web/](http://commonplace.net/2010/02/mobile-app-or-mobile-web/)

[4](https://journal.code4lib.org/articles/#ref4). WorldCat Mobile \[Internet\]. iTunes Preview; \[cited 2010 Jun 08\]. Available from: [http://itunes.apple.com/us/app/worldcat-mobile/id309643302](http://itunes.apple.com/us/app/worldcat-mobile/id309643302)

[5](https://journal.code4lib.org/articles/#ref5). Local Books \[Internet\]. iTunes Preview; \[cited 2010 Jun 08\]. Available from: [http://itunes.apple.com/us/app/local-books/id335363746](http://itunes.apple.com/us/app/local-books/id335363746)

[6](https://journal.code4lib.org/articles/#ref6). SPL Mobile \[Internet\]. iTunes Preview; \[cited 2010 Jun 08\]. Available from: [http://itunes.apple.com/us/app/spl-mobile/id364019201](http://itunes.apple.com/us/app/spl-mobile/id364019201)

[7](https://journal.code4lib.org/articles/#ref7). Chen B. 2010. A Call for Transparency in Apple’s App Store. Wired \[Internet\]; \[cited 2010 Jun 08\]. Available from: [http://www.wired.com/gadgetlab/2010/04/app-store-transparency/](http://www.wired.com/gadgetlab/2010/04/app-store-transparency/)

[8](https://journal.code4lib.org/articles/#ref8). LibraryThing Mobile \[Internet\]. Librarything.com; \[cited 2010 Jun 08\]. Available from: [http://www.librarything.com/m/](http://www.librarything.com/m/)

[9](https://journal.code4lib.org/articles/#ref9). Mobile Online Catalog \[Internet\]. Mississippi State University; \[cited 2010 Jun 08\]. Available from: [http://library.msstate.edu/m/](http://library.msstate.edu/m/)

[10](https://journal.code4lib.org/articles/#ref10).  Spalding T. 2010. Library Anywhere, a mobile catalog for everyone. The Thingology Blog \[Internet\]; \[cited 2010 Jun 18\]. Available from: [http://www.librarything.com/blogs/thingology/2010/01/library-anywhere-a-mobile-catalog-for-everyone/](http://www.librarything.com/blogs/thingology/2010/01/library-anywhere-a-mobile-catalog-for-everyone/)

[11](https://journal.code4lib.org/articles/#ref11).  Breeding M. 2010. LibraryThing Delivers Mobile Access to Library Catalogs. ALA TechSource \[Internet\]; \[cited 2010 Jun 18\]. Available from: [http://www.alatechsource.org/blog/2010/03/librarything-delivers-mobile-access-to-library-catalogs.html](http://www.alatechsource.org/blog/2010/03/librarything-delivers-mobile-access-to-library-catalogs.html)

[12](https://journal.code4lib.org/articles/#ref12). Boopsie \[Internet\]. Boopsie.com; \[cited 2010 Jun 08\]. Available from: [http://www.boopsie.com](http://www.boopsie.com/)

[13](https://journal.code4lib.org/articles/#ref13). Rochkind J. 2010. Mobile Trendiness. Bibliographic Wilderness \[Internet\]; \[cited 2010 Jun 08\]. Available from: [http://bibwild.wordpress.com/2010/04/08/mobile-trendiness/](http://bibwild.wordpress.com/2010/04/08/mobile-trendiness/)

[14](https://journal.code4lib.org/articles/#ref14).  The WebKit Open Source Project \[Internet\]; \[cited 2010 Jun 08\]. Available from: [http://webkit.org/](http://webkit.org/)

[15](https://journal.code4lib.org/articles/#ref15).  Universal iPhone UI Kit (UIUIKit) \[Internet\]; \[cited 2010 Jun 08\]. Available from: [http://code.google.com/p/iphone-universal/](http://code.google.com/p/iphone-universal/)

[16](https://journal.code4lib.org/articles/#ref16).  iPhone User Interface Framework (iUI) \[Internet\]; \[cited 2010 Jun 08\]. Available from: [http://code.google.com/p/iui/](http://code.google.com/p/iui/)

[17](https://journal.code4lib.org/articles/#ref17).  Open Library Data \[Internet\]. Internet Archive; \[cited 2010 Jun 08\]. Available from: [http://www.archive.org/details/ol\_data](http://www.archive.org/details/ol_data)

[18](https://journal.code4lib.org/articles/#ref18).  Catalogue Help \[Internet\]. Toronto Public Library; \[cited 2010 Jun 08\]. Available from:  [http://www.torontopubliclibrary.ca/hel\_tro\_index.jsp#z3950](http://www.torontopubliclibrary.ca/hel_tro_index.jsp#z3950)

[19](https://journal.code4lib.org/articles/#ref19).  Jordan M. 2007. PHP/YAZ Z39.50 Client. Interoperating.info \[Internet\]; \[cited 2010 Jun 08\]. Available from:  [http://interoperating.info/mark/node/71](http://interoperating.info/mark/node/71)

[20](https://journal.code4lib.org/articles/#ref20).  PHP/YAZ \[Internet\]; Index Data; \[cited 2010 Jun 08\]. Available from: [http://www.indexdata.com/phpyaz](http://www.indexdata.com/phpyaz)

[21](https://journal.code4lib.org/articles/#ref21).  Conversions: Metadata Object Description Schema: MODS \[Internet\]; Library of Congress; \[cited 2010 Jun 08\]. Available from: [http://www.loc.gov/standards/mods/mods-conversions.html](http://www.loc.gov/standards/mods/mods-conversions.html)

[22](https://journal.code4lib.org/articles/#ref22).  Geolocation API Specification \[Internet\]; W3C; \[cited 2010 Jun 08\]. Available from: [http://www.w3.org/TR/geolocation-API/](http://www.w3.org/TR/geolocation-API/)

[23](https://journal.code4lib.org/articles/#ref23).  Consolidated ASN.1 Z39 RecordSyntax-opac \[Internet\]; Library of Congress; \[cited 2010 Jun 08\]. Available from: [http://www.loc.gov/z3950/agency/asn1.html#RecordSyntax-opac](http://www.loc.gov/z3950/agency/asn1.html#RecordSyntax-opac)

[24](https://journal.code4lib.org/articles/#ref24).  SkyHook Wireless: How It Works \[Internet\]; Skyhook Wireless; \[cited 2010 Jun 08\]. Available from: [http://www.skyhookwireless.com/howitworks/](http://www.skyhookwireless.com/howitworks/)

[25](https://journal.code4lib.org/articles/#ref25).  The GNU General Public License \[Internet\]; Free Software Foundation; \[cited 2010 Jun 08\]. Available from: [http://www.gnu.org/licenses/gpl.html](http://www.gnu.org/licenses/gpl.html)

[26](https://journal.code4lib.org/articles/#ref26).  The GNU Affero General Public License \[Internet\]; Free Software Foundation; \[cited 2010 Jun 08\]. Available from: [http://www.gnu.org/licenses/agpl-3.0.html](http://www.gnu.org/licenses/agpl-3.0.html)

## Source Code

[http://github.com/mjsuhonos/mytpl/](http://github.com/mjsuhonos/mytpl/)

MJ Suhonos is the Metadata Specialist at Toronto Public Library ([http://tpl.ca](http://tpl.ca/)).  While he provides TPL with guidance on best practices for creating, managing, and sharing metadata with the broader Internet community, he is unable to completely eschew his programming background and spends his free time hacking library metadata whenever possible.
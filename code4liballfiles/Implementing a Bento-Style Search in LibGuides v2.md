---
title: "Implementing a Bento-Style Search in LibGuides v2"
source: "https://journal.code4lib.org/articles/10709"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-07-15
created: 2025-01-10
description: "The National University of Singapore Libraries converted their LibGuides v2 instance into a research portal and incorporated a “bento box” search interface—that is, an interface where results from multiple systems or categories are compartmentalized by system or category, like a Japanese “bento”-style lunch box—on a trial basis. Our experience shows that building and maintaining a [...]"
tags:
  - "clippings"
---
# Implementing a Bento-Style Search in LibGuides v2
Aaron Tay, Feng Yikang

The National University of Singapore Libraries converted their LibGuides v2 instance into a research portal and incorporated a “bento box” search interface—that is, an interface where results from multiple systems or categories are compartmentalized by system or category, like a Japanese “bento”-style lunch box—on a trial basis. Our experience shows that building and maintaining a bento box search in LibGuides requires fewer resources than a fully homegrown solution would require. This makes it an attractive platform for building a bento-style search both for libraries who have limited technical resources and libraries who might want to experiment with this kind of search before fully committing. This paper shares the design, implementation and some early usage patterns of our bento search.

## Introduction

Like many university libraries, the National University of Singapore (NUS) Libraries provides online guides, which are created to increase exposure and use of library resources. They are starting points for research, with links to scholarly journals and specialized sources relating to topics and subjects.

NUS Libraries has offered guides since 2007 and, in 2010, subscribed to SpringShare’s content management system, [LibGuides](http://springshare.com/libguides/). [NUS Libraries’ LibGuides instance](http://libguides.nus.edu.sg/) contains guides for subjects, modules, library instruction, research tools and more, with content contributed by librarians. From 2011 to 2014, as the total number of guides increased from 140 to 240, the annual total user sessions for NUS Libraries’ LibGuides doubled from 82,737 (2011) to 171,397 (2014).

## LibGuides as Research Portal

In 2013, we began preparing for a migration to version 2 of LibGuides. As part of our migration, we decided to improve the system.

The idea was to design a LibGuides homepage that served as an alternative home for research-oriented users. One of the use cases we considered was new post-graduates and faculty who want to find out the breadth of services the library offers. For example, they may want to find out if the library offers research support services such as Geographic Information Systems (GIS), Open Access, bibliometrics, etc. While we could add links to such services on the main library portal page, we felt that it would add too much clutter for such niche services that the typical undergraduate would not be interested in.

Hence, we designed a complete facelift for the LibGuides home page that would encourage browsing for such research-based services (Figure 1).

[![Figure 1](https://journal.code4lib.org/media/issue29/tay/Figure1.png)](https://journal.code4lib.org/media/issue29/tay/Figure1.png)**Figure 1:** NUS Libraries’ revamped LibGuides v2 home page

## Bento Search for Research Resources and Services

What about searching? How do we provide a search mechanism that covers the entire range of resources for researchers we offer, going beyond the list of articles and books displayed in a typical Web-scale discovery system (e.g., Summon, EBSCO Discovery Service, Primo, WorldCat Discovery Service)?

On his blog, Lorcan Dempsey (2013) discusses that existing web-scale discovery systems support “full-collection discovery,” allowing libraries to expose a large majority of their collections via one search box. However, he says he has noticed a trend toward a broader search beyond even that. Using the term “full-*library* discovery”, he feels that libraries should expose not just their collections, but also library webpages, guides, FAQs, and even staff expertise as search results.

One of the ways to offer full library discovery is with the “bento-style” design.\[[1](https://journal.code4lib.org/articles/#note1)\] Among the first to implement this idea was North Carolina State University (NCSU) Libraries (Figure 2) in their 2010 redesign of their QuickSearch system (Lown et al., 2013). Since then, many academic libraries have implemented bento-style searches; a partial list includes Stanford, Columbia, Dartmouth, Princeton and University of Michigan.

[![Figure 2](https://journal.code4lib.org/media/issue29/tay/Figure2.png)](https://journal.code4lib.org/media/issue29/tay/Figure2.png)**Figure 2:** NCSU Libraries’ current (2015) bento-style search interface

It occurred to us that we could easily set up a bento-style implementation using LibGuides v2. A great feature of this product is its customizability. The “customize search page template” feature (Figure 3) gave us an avenue to code our own bento layout by using just JavaScript, CSS and APIs.

[![Figure 3](https://journal.code4lib.org/media/issue29/tay/Figure3.png)](https://journal.code4lib.org/media/issue29/tay/Figure3.png)**Figure 3:** LibGuides v2 “Customize Search Page Templates” feature

## Design

A simple and clean experimental bento layout was chosen to test the concept while keeping costs low (Figure 4). We used four fixed boxes: the main box on the top-left is “Our Guides”, and it is supplemented by “Library Catalogue”, “FAQs” and “Articles” boxes. There is a dynamic box, “Our Suggestions,” which draws from Summon’s “Best bets” feature that allows librarians to create customized content that displays based on search keywords.

[![Figure 4](https://journal.code4lib.org/media/issue29/tay/Figure4.png)](https://journal.code4lib.org/media/issue29/tay/Figure4.png)**Figure 4:** LibGuides v2 “Customize Search Page Templates” feature

To provide the user varied yet succinct results for full-library discovery, the content types of each box are unique and complementary. Each bento box returns results from a different source (Figure 5), utilizing only SpringShare’s native LibAnswers API for FAQs and Summon’s API to pull in results for articles, catalogue results and suggestions.

[![Figure 5](https://journal.code4lib.org/media/issue29/tay/Figure5.png)](https://journal.code4lib.org/media/issue29/tay/Figure5.png)**Figure 5:** Overview of source of each results box

The “Library Catalogue”, “Articles” and “FAQs” boxes have a “see more” button at the top and bottom of results (Figure 6). In one click, the button opens the appropriate Summon search in a new window within its full interface, with the facets menu, advanced search features, etc.

[![Figure 6](https://journal.code4lib.org/media/issue29/tay/Figure6.png)](https://journal.code4lib.org/media/issue29/tay/Figure6.png)**Figure 6:** Clicking the “see more” button opens the full Summon search interface

Initially, we present users with an overview of results from different systems in the bento layout. Using the “see more” buttons, users can get full results in an interface with higher information granularity in just one click (Figure 7).

[![Figure 7](https://journal.code4lib.org/media/issue29/tay/Figure7.png)](https://journal.code4lib.org/media/issue29/tay/Figure7.png)**Figure 7:** From overview to in-depth in one click

Finally, the bento box search itself is triggered either via the search form at our [main Libguides landing page](http://libguides.nus.edu.sg/) or via any of the smaller search forms at the top-right of individual guides pages.

## Implementation

Our bento search interface is implemented using HTML, JavaScript and CSS, using LibGuides v2’s built-in Bootstrap framework. HTML defines the structural logic of the bento boxes and content. CSS and Bootstrap provide the styling aspects and mobile-responsive presentation. The logic to process users’ interactions is coded using JavaScript. The code for all three components (HTML, CSS and JavaScript) is situated as a LibGuides v2 search page custom template, accessible via the “Look & Feel” section of the LibGuides admin menu. The full code can be found in the Appendix.

### HTML Page Structure

Below is the HTML code structure for the search results page (Figure 8). For clarity, the fine details have been removed and will be discussed separately in later sections.

[![Figure 8](https://journal.code4lib.org/media/issue29/tay/Figure8.png)](https://journal.code4lib.org/media/issue29/tay/Figure8.png)**Figure 8:** Overall HTML code structure

### CSS and Bootstrap Presentation

The presentation aspect is implemented via CSS and the Bootstrap framework. CSS styles are assigned to HTML classes found in the <div> tags. We incorporated the default styles of LibGuides for a unified look throughout our guides.

The Bootstrap framework (Otto & Thornton, n.d.) is used to configure how the bento results display on mobile devices. The Bootstrap style classes shown in Figure 8 are highlighted in black. The layout is configured to display 3 main columns on screens at least 992 pixels wide. On smaller screens, the bento boxes dynamically shift to one single vertical column.

### JavaScript Logic

The search results page is a PHP file that accepts a URL parameter “q” for the search query. This file is accessed from our LibGuides server at http://libguides.nus.edu.sg/srch.php?q=search+query+here. Search results for each box are dynamically loaded based on the provided search terms (in this case, “search+query+here”). JavaScript code written into the template (inline with the HTML) provides this functionality.

The main logic for the bento-style search is as follows:

1. Extract query keywords from URL, store in searchQuery variable.
2. Load results into bento boxes:
1. `searchFAQ(searchQuery)`
2. `searchLibraryCatalogue(searchQuery)`
3. `searchArticles(searchQuery)`
4. `initSeeMoreButton(...)`
5. `getSuggestions(searchQuery, ...)`

For the “Our Guides” box, because these results come from LibGuides itself, the token {{search\_results}} in Figure 8 indicates the location where LibGuides places them automatically. For the other boxes, custom JavaScript and APIs are used to load results according to the algorithm just described. The details are below.

#### Step 1

First, JavaScript functions extract the search query parameter (“q”) from the URL and store it in the variable `searchQuery`. The subsequent steps 2a, 2b, 2c, 2d, 2e will use `searchQuery` to pull external content via the Summon and LibAnswers APIs (Figure 9).

[![Figure 9](https://journal.code4lib.org/media/issue29/tay/Figure9.png)](https://journal.code4lib.org/media/issue29/tay/Figure9.png)**Figure 9:** Interaction between the bento JavaScript and API

#### Step 2a

A JQuery `getscript()` function loads a JavaScript file from LibAnswers’ server using a GET HTTP request. This script then loads the LibAnswers results directly into the FAQ bento box: `<div id="boxFAQContent">`.

#### Step 2b

The function `searchLibraryCatalogue` uses the Summon API to pull library catalogue and articles results from holdings in Summon (Figure 10). As a private Summon ID and API key are needed for Summon API calls, it is a good idea to place this information on a secure server to be retrieved and used via a proxy PHP file. We are grateful to LibX for sharing their proxy PHP files (Bailey & Back, n.d.), which we adopted with modifications. \[[2](https://journal.code4lib.org/articles/#note2)\] See the Appendix for our server-side PHP files.

| 1  2  3  4  5  6  7  8  9  10 | `function` `searchLibraryCatalogue(searchQuery) {`  `searchSummon(searchQuery, ``"addFacetValueFilters(SourceType, Library Catalog)+setPageSize(10)"``, ``"boxLibraryCatalogueContent"``, `  `}`  `function` `searchSummon (searchQuery, searchCommand, boxName, `  `$.getJSON(``"[http://.../proxy.php?s.q=](http://.../proxy.php?s.q=)"` `+ encodeURIComponent(searchQuery) + ``"&s.cmd="` `+ searchCommand + ``"&callback=?"``, ``function` `(data) {`  `}`  `}` |
| --- | --- |

**Figure 10:** Code structure of `searchLibraryCatalogue`

As shown in Figure 10, the function `searchLibraryCatalogue` first passes the search query, relevant search commands (see Table 1) and ID of the box to a `searchSummon` function. `searchSummon` in turn calls `getJSON`, a jQuery AJAX function that loads JSON-encoded data from a server using a GET HTTP request. The first `getJSON` call sends a request to the proxy PHP file with URL parameters containing the `searchQuery` variable and search commands. Subsequently, on the server-side, the proxy PHP file reads the URL query string, adds HTTP request headers and an authentication digest generated from our Summon secret key, and sends the appropriate requests to the Summon server via HTTP GET methods (see Serials Solutions (n.d.) for details of the Summon API). The list of results is returned to `getJSON` in JSON format, and an anonymous callback function processes the data, pulling out the thumbnail, title, author, content type, publication year, and location for each item and loading the results into the library catalogue box: `<div id="boxLibraryCatalogueContent">`.

**Table 1:** Parameters for the URL query string sent to the Summon API by  
`searchLibraryCatalogue`

| Parameter | Description |
| --- | --- |
| s.q | Search query terms. This is encoded into Uniform Resource Identifier component (see Mozilla Developer Network (n.d.)). |
| s.cmd | Commands that inform the Search API on the action being performed (see Serials Solutions (n.d.)).For the library catalogue results box, the commands used are `addFacetValueFilters(SourceType, Library Catalog)` and `setPageSize(10)`.  - `addFacetValueFilters(SourceType, Library Catalog)`: Limits results to those coming from the library catalog. - `setPageSize(10)`: Sets the page size to return 10 results per page. |

#### Step 2c

The function `searchArticles` is similar to `searchLibraryCatalogue` from Step 2b. Both use the Summon API to pull results from Summon. The difference, however, is that `searchArticles` limits to article content types, such as dissertations, conference proceedings, journal articles, magazine articles, music scores, newsletters and standards.

**Table 2:** Parameters for the URL query string sent to the Summon API by `searchArticles`

| Parameter | Description |
| --- | --- |
| s.q | Search query terms. |
| s.cmd | Commands that inform the Search API on the action being performed (see Serials Solutions \[date unknown\]).For the article results box, the commands used are `addFacetValueGroupFilter(ContentType,or,Dissertation,Conference Proceeding,Journal Article,Magazine Article,Music Score,Newsletter,Standard)` and `setPageSize(10)`.  - `addFacetValueGroupFilter(ContentType,or,Dissertation,Conference Proceeding,Journal Article,Magazine Article,Music Score,Newsletter,Standard)`:   Filters content types to return only the following: dissertation, conference proceeding, journal article, magazine article, music score, newsletter or standard. - `setPageSize(10)`: Sets the page size to return 10 results per page. |

#### Step 2d

A series of `initSeeMoreButtons` functions are called to initialize buttons and links labelled “see more” (as shown in Figure 6). These simply set up each button’s dynamic behaviour and define the URL that will submit the user’s query to each native system.

#### Step 2e

The function `getSuggestions` uses the Summon API to retrieve results from Summon, in a similar way to `searchArticles` and `searchLibraryCatalogue`. For the given search query, if there are best bets, database recommendations or spelling suggestions, the “Suggestions” box will be visible with the respective content displayed. Otherwise, the entire box will be hidden.

## Usage Patterns

Custom event tracking for query and box clicks was implemented for the bento boxes. This was done by inserting Google Analytics event tracking code into each of the bento boxes as well as the “see more” buttons and links. For the library catalogue and articles boxes, event tracking code could be programmatically added to each result link returned from the Summon API.

We launched our bento box interface in January 2015 and began collecting stats via Google Analytics in March 2015. Figure 11, below, summarizes the number of clicks on each bento box for the period of March 1st, 2015 to May 6th, 2015.

[![Figure 11](https://journal.code4lib.org/media/issue29/tay/Figure11.png)](https://journal.code4lib.org/media/issue29/tay/Figure11.png)**Figure 11:** Number of clicks per bento box, March 1st to May 6th, 2015.

The usefulness of the multiple sources brought into the bento style search interface can be inferred from the fact that no single box of results predominates (Table 3). We also noticed that many of the searches and clicks are for research support services discussed in our guides (such as EndNote and bibliometrics). This gives us some evidence for the idea that the new LibGuides homepage is indeed functioning as an alternative research home, with multiple complementary sources being well-used.

**Table 3:** Number of clicks for each bento box

| Box | Clicks, including “See More” |
| --- | --- |
| Guides | 592 (30%) |
| Library Catalogue | 613 (31%) |
| Articles | 640 (33%) |
| FAQs | 117 (6%) |
| Total | 1,962 |

“Our suggestions” did not receive any clicks partly because there were few searches that triggered any suggestions. Moreover, the suggestions drawn from Summon’s best bets were designed mainly for use for users of Summon and would recommend guides, FAQs or links that were already covered by the other bento boxes.

Lown and others’ 2013 study of NCSU’s bento search usage provides somewhat similar results (45% on catalogue, 35% on articles), though a direct comparison isn’t quite possible because NCSU employs more numerous and granular boxes.

## Conclusion and Future Development

LibGuides v2 has provided us with a low-cost and effective platform to implement a bento prototype that allows us to present users with more resources at one time compared to a typical discovery service, which matches our goal to use LibGuides as an alternative home for research-oriented users. Our initial evaluation of the bento implementation has revealed moderate success, based on the fact that people do seem to use the results from each box about equally.

Beyond this experimentation, we are keen to study the adoption of a bento-style design for our main library portal to support “full-library discovery.” Our portal will be undergoing an upgrade in the next couple of years, and this gives us some time to study the integration of a bento-style search. The current small-scale implementation for LibGuides has provided us with first-hand information about the cost, benefits and gaps. As our library portal sees much higher traffic (nearly two million visits per year), we need to study the relative effectiveness of the bento layout for various user groups. We could also refine the variety of boxes to present our library services better—one possibility would be a box that exposes resource librarians based on search term (see University of Michigan Library (n.d.)). In the design process, we will likely encounter the challenge of presenting just the right amount of information—how should we maximize the exposure of our collection and services, in the most appropriate precedence, while preventing cognitive overload? Our next step is to design applicable usability studies to address such considerations. Following that, we would then develop a prototype grounded on evidence-based design, and use it to solicit ideas and considerations from colleagues who are stakeholders of the library portal “real estate.”

Hopefully, through sharing our experiences from usability studies, we can contribute towards a better understanding of bento-box implementations for the broader library community. Over time, collective shared experiences could shape the development of a “bento design pattern” for library resource discovery. Well-articulated, general, reusable solutions could be useful for effective widespread application by libraries. A design pattern would entail the identification of usage contexts (library portal, guides, etc.), and, for each, thoroughly-studied suggestions for the most important box content types, the optimum number of boxes, as well as the precedence and dimensions of boxes.

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] For more information about bento-style design, see, for example, a 2012 blog post and position paper by Jonathan Rochkind, which discusses many of the practical considerations behind choosing to use such an interface: [https://bibwild.wordpress.com/2012/10/02/article-search-improvement-strategy/](https://bibwild.wordpress.com/2012/10/02/article-search-improvement-strategy/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] The LibX Summon proxy code makes heavy use of a Summon PHP code library created by Serials Solutions. The most recent version of this library can be found in the Summon documentation center: [http://api.summon.serialssolutions.com/help/api/code](http://api.summon.serialssolutions.com/help/api/code). Note that we have made some modifications to this for use in our own code.

## References

Bailey, A., & Back, G. (n.d.) *Summon Service for LibX*. [http://libx.lib.vt.edu/services/summon/](http://libx.lib.vt.edu/services/summon/)

Dempsey, L. (2013). *Full Library Discovery*.  
[http://orweblog.oclc.org/archives/002214.html](http://orweblog.oclc.org/archives/002214.html)

Lown, C., Sierra, T., & Boyer, J. (2013). How users search the library from a single search box. *College & Research Libraries* 74(3): 227-241.

Mozilla Developer Network. (n.d.) *encodeURIComponent() – JavaScript | MDN*. [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/encodeURIComponent](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent)

Otto, M, & Thornton, J. (n.d.) *Grid template for Bootstrap*. [http://getbootstrap.com/examples/grid/](http://getbootstrap.com/examples/grid/)

Rochkind, J. (2012). *Article Search Improvement Strategy*. [https://bibwild.wordpress.com/2012/10/02/article-search-improvement-strategy/](https://bibwild.wordpress.com/2012/10/02/article-search-improvement-strategy/)

Serials Solutions. (n.d.) *API Documentation Center*. [http://api.summon.serialssolutions.com/](http://api.summon.serialssolutions.com/)

University of Michigan Library. (n.d.) Homepage. [http://www.lib.umich.edu/](http://www.lib.umich.edu/)

## Appendix: Code

Code for this project is divided into client-side and server-side code.

- [Client side (download zip file)](https://journal.code4lib.org/media/issue29/tay/code/client_side.zip).
- **libguides\_template.html**: Contains the HTML and CSS that goes into your LibGuides v2 template. References the two included JavaScript files.
- **bentoLogic.js and bentoLogic\_Execution.js**: Contains most of the JavaScript functions discussed in this article plus the code that executes searches.
- [Server side (download zip file)](https://journal.code4lib.org/media/issue29/tay/code/server_side.zip). Note that these files should be placed in the same directory on your server, unless you modify the `require_once` statements in the code. [PEAR](http://pear.php.net/) is also required.
- **proxy.php**: PHP code for the Summon API proxy, as discussed in the article. This file refereces key.php and SerialsSolutions\_Summon\_PEAR.php.
- **key.php**: Stores private Summon API ID and key and is referenced by proxy.php. Edit this file to include your Summon API key and ID.
- **SerialsSolutions\_Summon\_PEAR.php, Base.php, Query.php, and Exception.php**: Contains Serials Solutions’ PEAR implementation of their Summon Search API interface. We have made minor modifications to Query.php. (See [Github for the original source](https://github.com/summon/Summon.php/tree/master/SerialsSolutions/Summon).)

## About the Authors

Aaron Tay is library analytics manager at the Singapore Management University. He blogs about librarianship at [http://musingsaboutlibrarianship.blogspot.sg/](http://musingsaboutlibrarianship.blogspot.sg/) and tweets @aarontay.

Feng Yikang is an assistant librarian at the National University of Singapore. His interests are geographic information systems (GIS), digital humanities and discovery.
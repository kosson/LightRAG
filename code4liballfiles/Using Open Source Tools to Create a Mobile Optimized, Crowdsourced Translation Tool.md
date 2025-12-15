---
title: "Using Open Source Tools to Create a Mobile Optimized,  Crowdsourced Translation Tool"
source: "https://journal.code4lib.org/articles/9496"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-04-17
created: 2025-01-10
description: "In late 2012, OSU Libraries and Press partnered with Maria’s Libraries, an NGO in Rural Kenya, to provide users the ability to crowdsource translations of folk tales and existing children's books into a variety of African languages, sub-languages, and dialects. Together, these two organizations have been creating a mobile optimized platform using open source libraries [...]"
tags:
  - "clippings"
---
# Using Open Source Tools to Create a Mobile Optimized,  Crowdsourced Translation Tool
Evviva Weinraub Lajoie, Trey Terrell, Susan McEvoy, Eva Kaplan, Ariel Schwartz, Esther Ajambo

In late 2012, OSU Libraries and Press partnered with Maria’s Libraries, an NGO in Rural Kenya, to provide users the ability to crowdsource translations of folk tales and existing children’s books into a variety of African languages, sub-languages, and dialects. Together, these two organizations have been creating a mobile optimized platform using open source libraries such as Wink Toolkit (a library which provides mobile-friendly interaction from a website) and Globalize3 to allow for multiple translations of database entries in a Ruby on Rails application. Research regarding successes of similar tools has been utilized in providing a consistent user interface. The OSU Libraries & Press team delivered a proof-of-concept tool that has the opportunity to promote technology exploration, improve early childhood literacy, change the way we approach foreign language learning, and to provide opportunities for cost-effective, multi-language publishing.

## Introduction

Over the last 10 years, Oregon State University Libraries & Press (OSULP) has launched a number of open source programs, including LibraryFind and Library à la Carte. In early 2009, OSULP began developing mobile tools and became one of the first libraries with a mobile site optimized for both smartphones and feature phones.

OSULP has focused on mobile website development to avoid developing for a specific platform or device. As a land-grant institution, we felt optimizing for mobile was a better solution because it promised fewer mobile device compatibility issues. We feel this approach promises optimal openness and availability of our resources.

Maria’s Libraries is a Non-Governmental Organization (NGO) based in New York and working in rural Kenya, which, in conjunction with Kenya National Library Services and a network of community groups, has been testing demand-driven approaches to literacy engagement and exploring leapfrogging technologies through a network of libraries in resource-poor settings. Maria’s Libraries’ work includes building a modern, fully-equipped library in Busia, Kenya. They test applications with users from a network of libraries called Kitabu Kenya, where they are working to bring together local level information needs and innovative practices from around the world to develop cutting edge information services through libraries ([Maria’s Libraries \[Updated 2014\]](https://journal.code4lib.org/articles/#MariaLibraries)).

In 2012, at the American Library Association (ALA) Annual Meeting in Anaheim, Weinraub Lajoie gave a presentation outlining the work OSULP was doing in exploring alternative publishing paradigms. At the conclusion of the presentation, Kaplan, a Maria’s Libraries Co-Director, approached Weinraub Lajoie with an idea for a collaboration that would harness OSULP expertise in mobile technologies and publishing. Kaplan proposed that OSULP create a mobile website platform that would use crowdsourcing techniques to enable Maria’s Libraries’ user base to translate folk tales and existing children’s books into a variety of languages and dialects.

## What Are We Looking to Accomplish

The isolation of even neighboring villages in rural Kenya contributes to linguistic drift, such that groups that speak the same root language often use different words to describe the same item, making it difficult and cost prohibitive to print texts in local languages. There have been repeated attempts to make publishing physical books in local languages feasible, but with over forty local languages in Kenya alone there is no business model that provides a cost-effective solution ([Dekutsey, 1995](https://journal.code4lib.org/articles/#Dekutsey)). By moving to an electronic format, and creating a translation tool like this, we are hoping to build a cost-effective mechanism for local language publishing with both educational and cultural preservation objectives in mind.

Most of the projects the OSULP team participates in are either based on large Open Source communities like Hydra, one-off projects for our press, or projects we work on directly with a faculty member. Working with Maria’s Libraries was different in that we were building a new tool, with untested technologies, in support of users well outside of OSU. This particular project, however, fell into a few key areas outlined in our strategic plan. In OSULP’s strategic goal three, strategy 3, we are tasked to “Develop knowledge creation and dissemination opportunities.” Our mission statement asks us to “…build gateways to unique resources…” and our vision statement inspires us to serve “as a model of innovation for academic libraries and university presses” ([OSULP Strategic Plan 2012 -2017\[Updated 2012\]](https://journal.code4lib.org/articles/#OSULP)).

## Requirements

As part of our partnership agreement we were tasked with creating a mobile-optimized, crowd-sourced translation platform. This proof-of-concept would allow any user who created a username and password the ability to translate pieces of text into their local dialect and to vote for which translations were best. Because we needed the tool to work for groups who spoke different dialects of the same language, we had to allow for the ability to accept multiple sub-dialects of a single language as well as identify the most accurate translation of new dialectic versions.

Because our partners at Maria’s Libraries had provided tablet computers to the libraries in Busia, building the tool optimized for use on a mobile device was a primary goal. There is ample evidence that due to infrastructure issues, people are skipping over desktops and moving directly to mobile technologies ([Bridges, Rempel & Griggs, 2010](https://journal.code4lib.org/articles/#Bridges)). We have seen this kind of leap before throughout the developing world.

The original requirements document received from our partners included everything they hoped a completed project would do, including a workflow to recommend new root languages and the addition of interactive and cultural content in audio, video, and image format. For the first iteration the requirements were pruned to basic functionality: a system to vote on and view the results of translations from multiple users along with the ability to use it without an active network.

## Content, or What are We Translating?

Libraries and educators are well aware of the benefits of early childhood education on lifelong learning. Children with early exposure to books and reading are far more likely to succeed in school than those who do not ([Snow, et al. 1998](https://journal.code4lib.org/articles/#Snow)). Rural Kenya finds this effect compounded because the language spoken at home is not always represented in classroom teaching or in available storybooks. Children are therefore taught to read later in life and are often taught to read in a language they do not yet speak. For example, in Busia, children will initially be taught in their local language of Swahili until the equivalent of the third grade, at which point they will be taught in English. This abrupt shift and lack of preparation has significant life-long effects on literacy and educational outcomes ([Kaplan, et al. 2012](https://journal.code4lib.org/articles/#Kaplan)).

The children who will gain the most from these books are aged 2 – 5, though older children with previous reading exposure will also benefit. These children have not yet started school, and are unlikely to have seen a book or a computer before. There are likely no books in their local language, and any available books in Swahili are not geared toward their age group.

From the technical perspective, having a small number of words and an obvious delineation between ideas makes the children’s stories ideal for a mobile environment. Additionally, since the Mama Mtoto (Mother-Child) Story Time Program, which uses mother-child story time to introduce books and a love of reading to young mothers and their children, had already translated texts into local languages, it gave us existing content to work with.

## In-House Resources

OSULP’s development team consists of 2.5 FTE and 4 student employees residing within the Emerging Technologies & Services (ETS) department. In 2013, ETS voted on the implementation of an Open Source Development Policy, which was approved unanimously by library administration. The policy outlines the reasons why we feel that participation in open source development is at the core of our work as an academic and a land grant library. New projects are created in GitHub and are covered under a GPL license by default. This particular project was developed in a local instance of GitLab, open only to our staff. We chose to develop this project within GitLab, a self-hosted private solution, instead of GitHub because we are currently seeking outside funding, and want to keep our options open in regard to future development and fundraising. We expect that we’ll eventually release the code freely on GitHub once we’ve explored all possible fundraising options.

For the initial proof-of-concept, two programmers were tasked with spending 50% of their time over a two-month period for development. After its unveiling, one of our staff members spent 50% of their time over an additional month making the interface a bit more user friendly.

## Creating a Mobile Website

OSU Libraries & Press has made a commitment to create mobile websites rather than native applications. We’ve taken this stance largely because of difficulties maintaining native applications across the wide variety of mobile devices that are currently in use. However, this decision presented a few challenges for a project like this.

### Offline Features

One of the features requested was to be able to use the application without an active network connection. While HTML5 has a variety of options for offline functionality available, they’re currently limited – primarily by space. For instance, HTML5’s `localStorage` allows you to store data associated with a key and access it offline. However, in many browsers that storage is limited to 5 MB, which doesn’t allow for a lot of local edits. Other offline storage options in browsers often allow for greater storage (WebSQL), but not all browsers implement them. Fortunately, static assets are simple to store offline – HTML5 has a cache manifest file which can define which assets should be cached. An example of the cache manifest can be seen below:

![](https://journal.code4lib.org/media/issue24/lajoie/MLcache.png)

**Figure 1.** Cache manifest

Enabling the cache is as simple as adding <html manifest=”maria.appcache”> to the very top of the HTML. It’s important to note that cached assets will not be refreshed for clients unless the cache manifest file is updated.

### Screen Limitations

Designing for mobile devices greatly restricts the available real estate for things like descriptive strings. The solution is often to use immediately recognizable icons, which, while not using much space, offer a simple way to access functions. However, in this particular application there are a variety of actions which don’t have a globally understood icon, such as “begin translating this.” Further, representations we chose might not have the same meaning for the audience in Africa we’re trying to reach. This consideration led to choices such as an open padlock for logging in and a pencil icon for “begin translating.” While these may not always be obvious, they should be easy to remember. We have done our best to select appropriate icons, but further user testing will have to be done to determine their effectiveness.

### Device Access

Unfortunately creating a mobile website rather than a native application means that developers are unable to access much of the device’s internal functionality. For instance, at one point there was a request to be able to attach photos to a book’s translation to offer greater insight into the culture behind that passage. Unfortunately, at the time there was no cross-compatible way to allow for attaching images from a device’s internal storage or to access its camera. However, the APIs to access this information are quickly improving. For instance, iOS 6 and above now allows basic file inputs to attach files from internal storage.

## What it Takes to Crowdsource

Three major points were identified as requirements of a crowdsourced system:

- A simple interface to navigate, read translations, and add dialects
- The ability to quickly navigate and vote upon “sections” of a translation.
- A system that takes the highest voted sections and combines them for a complete translated text.

### Voting on Sections

A crowdsourced document is only as good as the opinions of its crowd. However, those opinions need to be facilitated by offering relevant content and its appropriate context to vote on. Therefore, we identified the need for both the separation of a document into sections (“pages”) and each section into sub-sections (“sentences.”) In this case, fortunately, we had clear breakpoints for both requirements. Each page of the children’s stories’ traditional printed book consisted of relatively few sentences and had a clear idea presented along with a picture. Therefore, we defined each section as a page of the original book, whose total translation would be voted on, and each sub-section as a sentence on that page which could be individually translated.

### A Simple Interface

Building the mobile interface utilized existing expertise within OSULP as well as research into common solutions for interactivity. We felt that as the success of the system relied upon participation it was our responsibility to make the process as seamless as possible. In the end we came up with the following workflow:

As the user enters the site they are offered a choice of languages to select.

![](https://journal.code4lib.org/media/issue24/lajoie/MLstartpage.png)

**Figure 2.** Language selection screen

Upon selecting a language, the user is presented a carousel of book covers to choose from. Each of these books has been marked for translation in the requested language, but may or may not have been completely translated. This carousel was implemented using Wink Toolkit’s Carousel plugin.

![](https://journal.code4lib.org/media/issue24/lajoie/MLbookselect.png)

**Figure 3.** Book selection screen

The current page of the book is indicated by a blue dot on the right hand side of the document. Swiping up or down allows navigation between pages.

![](https://journal.code4lib.org/media/issue24/lajoie/MLpageread.png)

**Figure 4.** Page view

If the user finds that the translation of the page they are reading is inaccurate they may swipe to the left or right to switch to a different translation of the text. Translations are ordered per page by number of votes, making the next translation the next most likely to be correct. When logged in the user can see a star on each page translation – selecting the star applies their vote to that user’s page. The highest voted page becomes the default view when selecting that book for a translation.

![](https://journal.code4lib.org/media/issue24/lajoie/MLaltpageread.png)

**Figure 5.** Alternative translation view

Should the user find that there’s no adequate translation, the user may log in, click the edit button, and click individual sentences to translate, while still being able to view the original translation for comparison. From there they can save their translation and it becomes available for others to vote on.

![](https://journal.code4lib.org/media/issue24/lajoie/MLpageedit.png)

**Figure 6.** Page edit view

### Using Votes to Build a Book

The strength of the system lies in the trust of its users to only vote up those pages with the most accurate translations. A new visitor will see only those pages that have the most votes. Should they decide the translation is inaccurate they can navigate to other translations and vote for those; the pages they’ve voted on will become the default for them the next time they visit, assuming they’ve logged in. This provides an incentive for users to vote: they create the best experience for themselves while simultaneously improving the experience for others.

## Technology

The application was written within the Ruby on Rails framework, primarily because of existing experience within OSULP as well as due to the availability of a variety of plugins (“gems”) to speed development. Below are the technical requirements for the project, and the solutions we implemented to meet those goals.

1. Implement a registration system
1. Devise ([https://github.com/plataformatec/devise](https://github.com/plataformatec/devise)) offers a standard and feature-laden solution for registration and authentication in Ruby on Rails applications.
2. Allow multiple users to provide multiple translations of a single sentence and easily recall them within the application.
1. The Globalize3 gem ([https://github.com/globalize/globalize](https://github.com/globalize/globalize)) provided the ability to assign and recall translations of a database object based on the user’s chosen locale. Using this in combination with user-specific locales (e.g., en-dickens or sw-antoinette) we could simply interact with models in a translation-aware way.

![](https://journal.code4lib.org/media/issue24/lajoie/MLaltlangcode.png)

**Figure 7.** Changing local translation

5. Display carousels and other navigation methods common to mobile applications
1. Wink Toolkit ([http://www.winktoolkit.org/](http://www.winktoolkit.org/)) provided us a small, easy to use, and customizable library that allowed for smooth animations in both the mobile and desktop environments. Their carousel and slider plugins in particular proved to be the most efficient amongst the potential solutions we found. Other alternatives, such as jQuery Mobile, Twitter Bootstrap, and Sencha Touch, either proved to be too complicated, have too much overhead, or resulted in jittery transitions.

## What’s Missing?

So far only the first phase of development has been completed for this project, which leaves a few crucial elements to be finished.

### Administration

There’s no way for an administrator to import stories, including both text and images, through the interface. Further, there is no automatic separation of books into portions of translatable text with related images – in the current iteration it is done largely through a manual process.

There is also no way for administrators to override the will of the crowd, leaving it open to multiple accounts poisoning the data.

### Further Crowdsourcing

Users are unable to recommend new languages and dialects for a book to be translated into. In the final iteration there would be the ability to vote on potential languages and make public those that have been suitably translated.

### Offline Functionality

The offline functionality of the application needs to better enable the use of the site from remote locations. Currently it largely depends on the system’s local cache – the use of HTML5 `localStorage` as well as offline manifests could greatly improve its functionality when a user attempts to use the application without an active network.

## Conclusion

Initially, our intention in creating this platform was based solely around the idea of helping literacy in Africa, but we’ve come to realize that the tool itself could have impact well outside the originally intended role. Language studies programs, and individuals working with dead or dying languages were excited about the tool and how they might be able to integrate it with their teaching. We are very excited about the possibilities of the usefulness of the platform as a way of publishing books in lesser-known languages or in regions where dialectic publishing is cost prohibitive. It’s our hope that, if we get further funding to expand on the tool, we can release it through GitHub and others can take what we have started and fork it to meet their needs.

## References

Maria’s Libraries About \[Internet\]. \[updated 2014\]. Brooklyn (NY): Maria’s Libraries, About; \[cited 2014 Feb 4\]. Available from: [http://mariaslibraries.org/about/](http://mariaslibraries.org/about/) [**Back**](https://journal.code4lib.org/articles/#MariaLibrariescite)

Dekutsey, Woeli, 1995. The Story of APNET, Harare: African Publishers Network, commissioned by UNESCO. [**Back**](https://journal.code4lib.org/articles/#Dekutseycite)

Bridges, Laurie. Hannah Gascho Rempel, Kimberly Griggs. 2010 Making the case for a fully mobile library web site: from floor maps to the catalog. Reference Services Review \[Internet\]. \[cited 2014 Feb 4\]; 38(2): 309 – 320. Available from: [http://hdl.handle.net/1957/16437](http://hdl.handle.net/1957/16437) [**Back**](https://journal.code4lib.org/articles/#Bridgescite)

Oregon State University Libraries & Press \[Internet\]. \[updated 2012\]. Corvallis (OR): Oregon State University Libraries & Press, Strategic Plan; \[cited 2014 Feb 4\]. Available from: [http://osulibrary.oregonstate.edu/flipbook/strategicplan/](http://osulibrary.oregonstate.edu/flipbook/strategicplan/) [**Back**](https://journal.code4lib.org/articles/#OSULPcite)

Snow, C. E., Burns, M., & Griffin, P. 1998. Preventing Reading Difficulties in Young Children. Washington (D.C): National Academy Press, p. 4. [**Back**](https://journal.code4lib.org/articles/#Snowcite)

Kaplan, Eva, Schwartz, Ariel. 2012. Mama Mtoto Story Time-Use Cases. Brooklyn (NY); Maria’s Libraries Report. [**Back**](https://journal.code4lib.org/articles/#Kaplancite)

## Acknowledgements

We’d like to thank Suzanne Dikker, Maria Wafula, Richard Atuti, Jimmy Cater, and many community members in Busia, Elangata Wuas, Garissa, and Lamu, especially their librarians. Further, partners at Africa Soma, particularly Caroline Archambault and Jennie Glassco, provided critical inputs to this project. All community work related to the Mama Mtoto Story Time Project was made possible by support from Beyond Access, Global Giving, and many private individuals.

## About the Authors

Evviva Weinraub Lajoie is the Director of Emerging Technologies & Services at Oregon State University Libraries & Press where she works on digital publishing, mobile, and open source tools development.

Trey Terrell is an Analyst Programmer in the Emerging Technologies & Services department at OSULP. He works on research and programming for web-based projects.

Susan McEvoy is an Analyst Programmer in the Emerging Technologies & Services department at OSULP. She does development and design and is responsible for guidance of web-based projects.

Eva Kaplan is the director and co-founder of Maria’s Libraries. She has worked in the field of international development for over seven years and is the managing editor of the Journal of Globalization and Development.

Ariel Schwartz is the director and co-founder of Maria’s Libraries. She is pursuing her doctorate, as well as a portfolio in Applied Statistical Modeling, at the University of Texas at Austin. Her interdisciplinary research sits at the intersection of Development studies, Information Science, and Organizational Science.

Esther Ajambo has been the head librarian at the Busia Community Library for over four years, managing all day-to-day operations of the library including all literacy and information programs implemented at the Busia Community Library.
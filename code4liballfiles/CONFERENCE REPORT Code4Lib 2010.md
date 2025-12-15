---
title: "CONFERENCE REPORT: Code4Lib 2010"
source: "https://journal.code4lib.org/articles/2717"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-03-23
created: 2025-01-10
description: "Conference reports from the 5th Code4Lib Conference, held in Asheville, NC, from February 22 to 25, 2010. The Code4Lib conference is a collective volunteer effort of the Code4Lib community of library technologists. Included are three brief reports on the conference from the recipients of conference scholarships."
tags:
  - "clippings"
---
# CONFERENCE REPORT: Code4Lib 2010

Conference reports from the 5th Code4Lib Conference, held in Asheville, NC, from February 22 to 25, 2010. The Code4Lib conference is a collective volunteer effort of the Code4Lib community of library technologists. Included are three brief reports on the conference from the recipients of conference scholarships.

By Birong Ho, Banurekha Lakshminarayanan, and Vanessa Meireles

The [5th Code4Lib Conference](http://code4lib.org/conference/2010/) was held in Asheville, NC, from February 22 to 25, 2010. As in years past, the Code4Lib community was able to offer scholarships focused on gender diversity and minority representation, this year sponsored by Oregon State University and Brown University. Following are conference reports from the scholarship recipients.

For more notes, many informal, by other Code4Lib community members, find content on the internet tagged “c4l10″ or “#c4l10″, a label attendees were encouraged to use to aid collocation. For example:

[http://delicious.com/tag/c4l10](http://delicious.com/tag/c4l10)  
[![Seating Arrangements](https://journal.code4lib.org/media/issue9/meireles/pacman.jpg)](http://www.flickr.com/photos/ranti/4399489013/)  
**Photo 1** The conference T-shirt: code4lib pacman, [tagged c4l10 on flickr](http://www.flickr.com/photos/tags/c4l10/) Photo credit: Ranti Junus

## From Birong Ho: Solr power

My favorite theme in Code4Lib 2010 was [Solr](http://lucene.apache.org/solr/). I found these sessions extremely helpful, especially since I am directly involved in implementing [VuFind](http://vufind.org/) as the primary interface for our OPAC here at Western Michigan University. [\[1\]](https://journal.code4lib.org/articles/#note1)

Solr is an open source enterprise search server based on the Lucene search library, with XML/HTTP and JSON APIs, hit highlighting, faceted search, caching, replication, and a web administration interface.

At the pre-conference, there were Solr white belt and black belt sessions. In [Solr black belt](http://www.slideshare.net/erikhatcher/solr-black-belt-preconference), Eric Hatcher, from [Lucid Imagination](http://www.lucidimagination.com/), gave detailed explanations of the features of Solr version 1.4. Basic searching for both the standard Lucene query parser and the DisMax query parser were explained. Eric also introduced Solr fundamentals such as caching, replication, faceting, and distributed search. In general DisMaxQParser is good for situations when you want to pass raw input strings from novice users directly to Solr. By default, query params use LuceneQParser, but you can use prefix notation to override that. He gave a detailed explanation of DisMaxQParser about what parameters control which fields are searched, how significant each field is, how many words must match, and how to allow for additional options to artificially influence the score. Advanced features such as Solr APIs, deployment architecture, and the Solr index were also explained. Processes such as the indexing of different documents (e.g. XML, CSV) were demonstrated. He then went over the following tools, which can be configured in schema.xml: Analyzers (process text before tokenizing), Tokenizers (control how your text is tokenized), and TokenFilters (mutate and manipulate the stream of tokens). Finally, searching performance was discussed. For more information on Solr, see the bibliography below.

The conference itself had numerous talks on Solr-related topics and projects, including 3 Blacklight-related talks and a breakout session, a talk on call number browse, and 3 sessions on advanced search.

### Blacklight

Solr 1.4 is the backbone of the [Blacklight](http://projectblacklight.org/) project, which uses Solr, rather than a traditional Relational Database Management System (e.g. Oracle or MySQL), as the index.

1. [UW Forward](http://forward.library.wisconsin.edu/) (lightning talk): Blacklight is the framework behind this project at the University of Wisconsin Libraries System. The challenges they have include multiple campuses and deduping MARC data to be included in the master Solr index.
2. [Hydra](http://www.fedora-commons.org/confluence/display/hydra/The+Hydra+Project) (lightning talk): Blacklight + ActiveFedora + Rails at Stanford University brings a Ruby on Rails front-end to a Fedora-based repository.
3. [Media, Blacklight, and Viewers Like You](http://code4lib.org/conference/2010/beer): Chris Beer from WGBH Interactive Media Archives talked about their Open Vault project. In the Open Vault project, Blacklight and Solr are the major frameworks used. Media material is the major component in their Solr index.

### Call number browse

1. [How to Implement A Virtual Bookshelf With Solr](http://code4lib.org/conference/2010/dushay_keck2): Naomi Dushay and Jessie Keck of Stanford implemented an interface for the browsing of call numbers. They applied a lexical sort on call numbers, found them very messy to deal with, but still managed to produce a sorted list with 8 million entries.

### Advanced search

Complicated searching algorithms implemented in advanced searching menus were explored in various manners during the conference. They included:

1. [Catalog Auto-suggest using Solr](http://docs.google.com/present/view?id=dcz7k2rb_59xzgz36fg) (lightning talk): Jill Sexton from the University of North Carolina talked about using already extracted authority data to create a Solr index. This module uses author, title and subject authority files to auto-suggest search terms for users when they input the string in the search box. “Do you mean” is used instead of “Did you mean.”
2. [Kill the search button](http://developer.statsbiblioteket.dk/kill/code4lib.html): Michael Nielsen and Jørn Thøgersen presented their project from afar. They make the search experience easier for users by updating search results at keypress. JQuery is used for their front-end, backed by a Solr index with eight million MARC records.
3. [A Better Advanced Search](http://code4lib.org/conference/2010/dushay_keck): Naomi Dushay, from Stanford University, shared her definition of advanced search and explained its Solr 1.4 implementation. She also explained the challenges, which include multi-select facets in the advanced search, the integration with the current User Interface, and actionable facets in the search results.

Conference formats included 20 minute sessions and 5 minute [lightning talks](http://code4lib.org/conference/2010/lightning). All speakers came well prepared, and even the speakers at the lightning talks were well-organized, many with PowerPoints. The host universities put enormous efforts into this conference including moving people to and from the airport. And it was a well-received conference by all attendees. I will definitely go again next year and will recommend this conference to system librarians, software developers and server administrators.

### Notes

I gave a lightning talk about Western Michigan University’s VuFind.

### Further Reading on Solr

[LucidWorks for Solr Certified Distribution Reference Guide](http://www.lucidimagination.com/Downloads/LucidWorks-for-Solr/Reference-Guide) published by Lucid Imagination.

Smiley, D., & Pugh, E. (2009). *Solr 1.4 Enterprise Search Server*. Packt Publishing. [COinS](https://journal.code4lib.org/coins)

## From Banurekha Lakshminarayanan

As a software programmer who has worked mostly in retail and automotive companies, I had limited knowledge and exposure to the revolutionary things that can be accomplished in library systems. With one month of experience at the Hesburgh Library in University of Notre Dame, I headed to the Code4Lib conference not knowing what to expect, but looking forward to learning and interacting with my peers from across the country.

### Pre-Conference & Conference Talks

I liked the way pre-conferences were arranged. They were mostly workshops and we could choose the one that we were interested in. I liked getting hands-on knowledge of digital repository technologies such as Solr, [Fedora](http://www.fedora-commons.org/) and Blacklight. I attended the Blacklight workshop and got some guidance on how to get started with it. In my opinion it would have been more useful if this workshop had dedicated more time towards the installation and basic configuration of Blacklight, since many of us were from diverse fields and new to this technology.

Another feature that was nice about the conference was the way presentations were organized. Every effort was taken so that everyone could participate.

I also liked the presentation by Bess Sadler, “[Vampires vs. Werewolves: Ending the War Between Developers and Sysadmins with Puppet](http://code4lib.org/conference/2010/sadler).” Bess discussed the most common issues that every developer and system administrator face in day-to-day life and also discussed some solutions to resolve them, and made us all chuckle during the process.

### Breakouts & Lightning Talks

The conference facilitated an amazing amount of participation/contribution with its [breakout sessions](http://code4lib.org/conference/2010/breakouts) and [lightning talks](http://code4lib.org/conference/2010/lightning). The breakout sessions allowed attendees to informally discuss current projects, issues, and recommendations. The lightning talks covered a variety of topics (applications, specifications, protocols, etc.) and introduced me to new ideas, resources and projects for further investigation.

I found “[Hydra](http://www.fedora-commons.org/confluence/display/hydra/The+Hydra+Project): Blacklight + ActiveFedora + Rails” very useful since we at Notre Dame are trying to build a digital repository using the same architecture. The Hydra development team is trying to build a pretty nice framework for digital repositories for the entire community, and I am very excited about exploring this application.

I liked the way lightning and breakout sessions were arranged, and the lightning talks were very diverse. Some of them were extended into breakout sessions as well. I felt the breakout sessions helped me to get better acquainted with people who were trying to achieve similar goals in the library.

A few of the lightning sessions were difficult to follow, as they were presented in a rapid manner. I understood that this was the nature of such sessions, but thought that if the time for each session was increased and the total number of sessions decreased, it would have helped us to better understand the topics.

### Ask Anything

Finally, I believe the [Ask Anything](http://code4lib.org/conference/2010/chudnov) session deserves its own praise. The idea was to ask a roomful of people for help, advice, references, etc. on any topic, and I think it worked very well. This session proved the vibrancy and strength of Code4Lib: largely unstructured, social, and focused on mutual aid. I will spare you any comparisons to Rainbow Gatherings, but I’ll say this much: I’m proud to be part of Code4Lib, and I’d like to encourage anyone who is interested in library technology to attend this conference.

This is one of the best conferences I have attended. I saw people who were willing to help each other and willing to contribute a lot to the community. I gained a lot of knowledge and I look forward to my next Code4Lib conference.

## From Vanessa Meireles

As a software engineer with many years of IT industry experience, the Code4Lib 2010 Conference was a very different and educational experience for me. This experience began with the **preconference**, where I attended the **Web Services and Widgets session**. It was a very informative session with great innovative ideas for providing more services to users, as well as demonstrating how some traditional ILS systems limitations have been addressed. These are common frustrations to library programmers and system librarians. That day continued with the “Newbie dinner” where my coworker and I met some other conference attendees; I think this was a great idea and opportunity. I do think that the organization of finding our restaurant group was chaotic and that eight people is too large of a group for everyone to talk and get to know the other individuals during dinner. A smaller group of people, either five or six, would be easier to interact with and seat at restaurants.

I enjoyed all sessions during the conference. I found Karen A. Coombs’ session concerning the “[7 Ways to Enhance Library Interfaces with OCLC Web Services](http://code4lib.org/conference/2010/coombs)” very straightforward, easy to follow and extremely helpful. Her seven possible ways to improve the local OPAC are great. I also found both sessions on Thursday concerning “[…Developing a Mobile Catalog](http://code4lib.org/conference/2010/griggs)” and “[Mobile Web App Design](http://code4lib.org/conference/2010/doran)” very thorough, well researched, informative and with many tangible examples.

An important aspect that I did find refreshing was the collaborative spirit and use of open source software and platforms wherever possible, as well as an overall willingness to share ideas, experiences and to listen to other ideas and challenges our peers are facing. This conference was a great networking experience, a chance to meet colleagues from other universities and see some of the cutting-edge projects they are working on. I was able to gather all this information through the conference topics, the lightning talks, break-out sessions and side conversations in the [IRC chat channel](http://code4lib.org/irc/). At times it was very distracting to follow the IRC chat channel and the presentations simultaneously. The IRC chat channel consisted of informal side conversations and inside jokes as well as occasional data relevant to the presenter’s topic.

Code4Lib is very community oriented. The community votes months ahead of time to choose presentations on the topics they want to hear discussed. I liked the sequential presentation arrangement for the conference. It ensured main conference topics did not occur simultaneously and, therefore, I didn’t feel that I missed out on anything or was rushed from one room to another.

[![Seating Arrangements](https://journal.code4lib.org/media/issue9/meireles/seating-arrangements.jpg)](http://www.flickr.com/photos/47860563@N05/4389115750/in/photostream/)

**Photo 2** Our seating arrangement where everyone sits together for the main conference topics. This seating arrangement is perfect in fostering a community feeling. Photo credit: Thomas McMillan Grant Bennett

The [lightning talks](http://code4lib.org/conference/2010/lightning) allowed for a wide coverage of topics in a short period of time, which enabled conference attendees to be exposed to more topics. Sometimes these lightning talks had enough interest to create breakout sessions. These [breakout sessions](http://code4lib.org/conference/2010/breakouts) are informal topic-centered discussions held in different rooms. Coming from a more structured computer science industry approach, I found these to be similar to brainstorming meetings and some breakout sessions had lively heated debates. For example, one such debate concerned metadata and vocabularies. Discussion touched on whether there is universal benefit in incorporating locally produced metadata terminology into existing and new controlled vocabularies or whether locally produced metadata is irrelevant to register because it is specific to local scenarios.

[![Coffee Break](https://journal.code4lib.org/media/issue9/meireles/break.jpg)](https://journal.code4lib.org/media/issue9/meireles/break.jpg)

**Photo 3** The hotel lobby where we had nice afternoon cookie and caffeine breaks, essential for all technical people, and another opportunity to mingle and network. Photo credit: Vanessa Meireles

I feel that the Code4Lib 2010 Conference was a great learning experience and that I was able to bring back many new and innovative ideas, along with solutions for the projects our library is working on. It was also a wonderful networking experience. Personally, I think the conference might not be beneficial to non-technical individuals who have very limited to no programming experience and who are inexperienced with library technologies. I would also not recommend the conference to technical software engineers whose job roles do not deal with libraries directly or encompass similar needs to the library industry, since the conference is very industry-specific. I was very pleased with the level of in-depth technical talks and the relevance to the library industry and my current job role, hence I think the conference name of code4lib suits it perfectly.

## About the Authors

Birong A. Ho, recipient of a 2010 Code4Lib Gender Diversity Scholarship, is a Systems Librarian at Western Michigan University Libraries. Birong’s library experience includes work in cataloging, metadata, data conversion, and science reference. She has an MS in Electronics and Computer Control Systems from Wayne State University, an MLIS and an MA in English from the University of Wisconsin-Madison, and a BA in Western Languages and Literature from National Chengchi University in Taipei, Taiwan.

Banu Lakshminarayanan, recipient of a 2010 Code4Lib Minority Scholarship, is a Java/Web developer with over five years of experience. She is new to library technology and recently joined Hesburgh Library in the University of Notre Dame. She holds a Bachelor of Engineering in Computers from Madurai Kamaraj University, India.

Vanessa Meireles, recipient of a 2010 Code4Lib Gender Diversity Scholarship, joined the University of Miami Libraries in February 2009 as their main programmer. Before working in libraries, she spent 14 years in the IT industry, including 6 years at IBM. Vanessa holds a BS in Compuer Science from the Florida Atlantic University and is pursuing a Masters of Science in Management, Technology & Economics from the Swiss Federal Institute of Technology in Zurich.
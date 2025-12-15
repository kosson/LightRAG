---
title: "Comparing the LibraryThing, OCLC, and Open Library ISBN APIs"
source: "https://journal.code4lib.org/articles/8715"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-07-18
created: 2025-01-10
description: "LibraryThing, OCLC, and the Open Library project all provide ISBN services that take an ISBN and return information about related works for that ISBN. This article compares the license terms, quality of the data returned, documentation available, and details of the APIs for the three products. The article focuses on ease of use for developers, [...]"
tags:
  - "clippings"
---
# Comparing the LibraryThing, OCLC, and Open Library ISBN APIs
David Fiander

LibraryThing, OCLC, and the Open Library project all provide ISBN services that take an ISBN and return information about related works for that ISBN. This article compares the license terms, quality of the data returned, documentation available, and details of the APIs for the three products. The article focuses on ease of use for developers, restrictions on types of use (and assumptions about types of use built into the license or terms of use), and cost of the services.

## Introduction

OCLC, LibraryThing, and the Open Library all provide web services for finding basic information about books based on their ISBNs, but the services all have different APIs, provide different types of information, and have different license terms which may restrict the ways that they may be used.

This work arose from a research project involving comparing the private collections of faculty on campus to the holdings of the university library, to determine what the service gap was between what faculty required for their research and what the library was providing. In order to reduce the amount of manual labour involved in the comparison, we collected ISBNs from the faculty’s books (for those books that had ISBNs) and want to compare those ISBNs to the library’s collection. However, the fact that even the “same” book might have multiple ISBNs associated with it (e.g., cloth vs paper bindings, or British vs American publishers) complicates this comparison. So we wanted to use a service like OCLC’s xISBN service to determine the set of “related” ISBNs and check those against the library’s collection, if the ISBN gathered from the faculty collection was not in the collection directly. Looking for the best way to do this turned into an exploration of the balance between usability of the API, the services’ terms of use, and the quality and amount of the bibliographic data available from each of the services.

The question of what editions of books are “related” to each other is a complicated one. For all the examples in this paper, I am using the 15th edition of the *Chicago Manual of Style* as my starting point. At one level, all the different editions of the Chicago Manual are related, since they are all the Chicago Manual, but they are also all different books, and it is not necessarily the case that one edition can be substituted for another (for example, the 13th edition contains information about the typesetting process that is omitted from later editions, and the 15th edition includes extensive revision to citation style related to citing online journals an other works). For the purposes of this study, what matters is consistency in the treatment of editions: either all editions of the Manual should be treated as “the same”, or they should all be distinct.

## Basics of the APIs

### LibraryThing

LibraryThing ([http://librarything.com](http://librarything.com/)) is a social platform for book lovers that allows them to catalog their personal libraries. According to LibraryThing’s “[Zeitgeist](https://www.librarything.com/zeitgeist)” page, it has over 1.5 million members, and has cataloged over 7.5 million unique items.

LibraryThing provides seven APIs, each of which serves a distinct function and has separate license terms and conditions of use (LibraryThing, 2012). LibraryThing is not a general purpose bibliographic database; most of the APIs that it provides are designed to provide information about an individual member’s personal collection, rather than from the full LibraryThing catalog. I will be focusing on the “ThingISBN” API in this article.

The ThingISBN API takes a given ISBN and returns an XML-formatted set of “related ISBNs”, which are the ISBNs of other formats or editions of the book that has the given ISBN. The output is identical to that of the original OCLC test xISBN service (described below). It provides only ISBN information, and there is no way to get other bibliographic data from LibraryThing in general, although it is possible to find out information about the books in an individual user’s personal collection.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `<?``xml` `version``=``"1.0"` `encoding``=``"utf-8"``?>`  `<``idlist``>`  `<``isbn``>0226104036</``isbn``>`  `<``isbn``>0226103897</``isbn``>`  `<``isbn``>0226103900</``isbn``>`  `<``isbn``>0226104206</``isbn``>`  `<``isbn``>0226104044</``isbn``>`  `<``isbn``>0226770087</``isbn``>`  `<``isbn``>0226104052</``isbn``>`  `<``isbn``>0226104176</``isbn``>`  `<``isbn``>9562913961</``isbn``>`  `<``isbn``>1434102831</``isbn``>`  `</``idlist``>` |
| --- | --- |

The ThingISBN API will accept ISBNs either with or without dashes in them (0-226-10403-6 and 0226104036 are both acceptable), but the ISBNs returned will never have dashes. It also accepts both ISBN-10 and ISBN-13, but the list returned always consists of ISBN-10s (once there are books that have ISBN-13s that cannot be converted back to ISBN-10s, this will obviously have to change). If the identifier passed to the API is not a valid ISBN, or is not in the LibraryThing database, then it is flagged as an “UnknownId”.

### OCLC

OCLC launched its xISBN service as research project in January of 2004 (OCLC Research, 2004). At that time it was a very basic service that took an ISBN and returned an XML-formatted list of “related” ISBNs. This is the model on which LibraryThing’s “ThingISBN” service was based. In 2007, the research project service was downgraded and the production service was launched (Hellman, 2007). The production service provides not just the list of related ISBNs, but also options for retrieving other bibliographic data about each of the items returned. The API allows the user to request just those fields that they require. The data may be returned formatted as CSV, text (i.e. tab delimited), XML, XHTML, JSON, Python, PHP, or Ruby. The default format returned is XML (OCLC, n.d.).

The API will accept ISBNs with or without dashes. The ISBNs returned will be in the same format as in the request. Similarly, the length of the ISBNs returned will match that in the request: a request for an ISBN-10 will return a list of ISBN-10s; a request for an ISBN-13, a list of ISBN-13s. If the identifier passed to the API is not a valid ISBN, then the “stat” attribute in the response (as shown above) will have the value “invalidId”; if the ISBN is valid but not in the OCLC database, then the “stat” attribute will have the value “unknownId”.

While the OCLC xISBN API will return basic bibliographic information about the item identified by the given ISBN, OCLC also provides a separate, more complete, “OCLC Search API”, which is governed by a separate license agreement and requires a separate registration process before it can be used.

The complete metadata available through the xISBN interface is

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27 | `{`  `"stat":"ok",`  `"list":[{`  `"publisher":"University of Chicago Press",`  `"form":["BA",`  `"DA"],`  `"lccn":["2003001860",`  `"20031860",`  `"92037475"],`  `"lang":"eng",`  `"city":"Chicago",`  `"author":"[John Grossman]",`  `"ed":"15th ed.",`  `"year":"2003",`  `"isbn":["0226104036"],`  `"title":"The Chicago manual of style.",`  `"oclcnum":["183927955", "186032987", "254766064", "255224549",`  `"265518898", "270770568", "300224813", "316300181",`  `"441827088", "465067945", "51553085", "636071725",`  `"642131460", "696100286", "716977182", "731426594",`  `"731438337", "732317662", "733751229", "748774915",`  `"760775753", "779265103", "781185293", "781436125",`  `"782550638", "783145177", "787879695", "789898520"`  `]`  `}]`  `}` |
| --- | --- |

### Open Library

The Open Library API was designed as the primary programming interface to the Open Library’s catalogue of bibliographic data, including related works. Because the API is primarily a catalog API, it takes two steps to find the complete set of related ISBNs:

1. Find out the bibliographic information about the given ISBN (that is, we are doing a “known item” search of the catalogue based on the ISBN). This search returns the ISBNs of other formats of the specific edition (such as cloth, paper, or electronic), plus the Open Library “work identifier” for the over-arching “work” that encompasses the item we began with. This API can return all of the bibliographic data known about the item identified by the ISBN, but in this case, I am only asking for the work identifier.
2. Use the work identifier discovered in step 1 to retrieve the list of ISBNs linked to the work, including all the various editions.

The Open Library query API, used above, is very rich, with several options for specifying the item for which one is searching, and the type of data that should be returned, but it seems that it only returns data in JSON format. The Open Library also has a simple RESTful API that allows one to get information about a known item based on its Open Library identifier, whether that’s a “book”, “work”, or even “author”. This interface does provide support for returning data in JSON, RDF, and YAML. The query API provides far more information about an item than the RESTful API does. For example, the full set of information available from the query API for the work “OL1597922W” is

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73 | `[`  `{`  `"identifiers": {`  `"librarything": ["7335"],`  `"goodreads": ["103362", "4657649", "332548"]`  `},`  `"subtitle": "The essential guide for writers, editors, and publishers",`  `"weight": "3.3 pounds",`  `"covers": [6868096, 140171, 140169],`  `"lc_classifications": ["Z253 .U69 2003"],`  `"latest_revision": 11,`  `"uri_descriptions": [`  `"Publisher description",`  `"Contributor biographical information",`  `"Table of contents"`  `],`  `"languages": [{"key": "/languages/eng"}],`  `"genres": ["Style manuals."],`  `"source_records": [`  `"marc:marc_records_scriblio_net/part14.dat:135267575:1040",`  `"marc:marc_cca/b10621386.out:42100111:1631",`  `"marc:CollingswoodLibraryMarcDump10-27-2008/Collingswood.out:59082004:2424",`  `"marc:marc_ithaca_college/ic_marc.mrc:195612531:1390",`  `"marc:marc_ithaca_college/ic_marc.mrc:195613921:1390"`  `],`  `"title": "The Chicago manual of style",`  `"edition_name": "15th ed.",`  `"subjects": [`  `"Printing -- Style manuals",`  `"Authorship -- Style manuals"`  `],`  `"publish_country": "ilu",`  `"type": {"key": "/type/edition"},`  `"uris": [`  `],`  `"physical_dimensions": "9.5 x 6.4 x 2.4 inches",`  `"revision": 11,`  `"publishers": ["University of Chicago Press"],`  `"description": {`  `"type": "/type/text",`  `"value": "Includes bibliographical references and index."`  `},`  `"physical_format": "Harbcover",`  `"last_modified": {`  `"type": "/type/datetime",`  `"value": "2011-07-29T04:01:51.327875"`  `},`  `"key": "/books/OL3672021M",`  `"publish_places": ["Chicago, USA"],`  `"lccn": ["2003001860"],`  `"pagination": "xvii, 956 p.",`  `"classifications": {},`  `"created": {`  `"type": "/type/datetime",`  `"value": "2008-04-01T03:28:50.625462"`  `},`  `"url": [`  `],`  `"notes": "Includes bibliographical references (p. [863]-879) and index.",`  `"number_of_pages": 956,`  `"dewey_decimal_class": ["808/.027/0973"],`  `"isbn_10": ["0226104036", "0226104052", "0226104044"],`  `"publish_date": "2003",`  `"copyright_date": "2003",`  `"works": [{"key": "/works/OL15979229W"}]`  `}`  `]` |
| --- | --- |

but the information provided by the work itself, at the URL [http://openlibrary.org/works/OL15979229W.json](http://openlibrary.org/works/OL15979229W.json), is merely

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21 | `{`  `"title": "The Chicago manual of style.",`  `"created": {`  `"type": "/type/datetime",`  `"value": "2011-07-29T04:01:15.259393"`  `},`  `"last_modified": {`  `"type": "/type/datetime",`  `"value": "2011-07-29T04:01:15.259393"`  `},`  `"latest_revision": 1,`  `"key": "/works/OL15979229W",`  `"authors": [`  `{`  `"type": {"key": "/type/author_role"},`  `"author": {"key": "/authors/OL3236644A"}`  `}`  `],`  `"type": {"key": "/type/work"},`  `"revision": 1`  `}` |
| --- | --- |

## Data Quality

The idea that different editions of a book are merely manifestations of a Platonic “work” that encompasses all the editions is a core part of the Functional Requirements for Bibliographic Records (FRBR), and is essential for my research. The APIs give us a simple way to determine the quality of the bibliographic data held by each of the services, relative to this idea of clustering editions. As a simple test of the quality of the data provided by each of the services, I explored what related works they each provided for the hardcover 15th edition of the *Chicago Manual of Style*, ISBN 0-226-10403-6, (chosen primarily because it’s convenient to me, common, and many libraries will hold several editions).

### LibraryThing

Because LibraryThing’s data is created by individuals cataloging their own collections, the coverage is somewhat idiosyncratic. For example, LibraryThing only records one copy of the IEEE POSIX 1994 standard, while WorldCat documents over sixty libraries that own it. On the other hand, LibraryThing has a record for the chapbook “Oracle Gretel” by Julia Rios, but WorldCat has no record of the book at all. LibraryThing actively encourages its community to perform a form of crowdsourced authority control that ensures that authors whose names are recorded in a variety of ways, or who write under pseudonyms, are correctly linked together, and that related works are gathered together. This latter project makes LibraryThing’s data a good fit for my research project.

LibraryThing returns the following ISBNs as all being related to the 15th edition of the Chicago Manual:

- 1434102831 (1st ed, reproduction)
- 9562913961 (9th ed)
- 0226770087 (12th ed)
- 0226103900 (13th ed)
- 0226103897 (14th ed, cloth)
- 0226104044 (15th ed, CD-ROM only)
- 0226104176 (15th ed, Windows CD-ROM)
- 0226104036 (15th ed, cloth)
- 0226104052 (15th ed, cloth+CD-ROM)
- 0226104206 (16th ed, cloth)

### OCLC

When searching OCLC for the initial ISBN, 0226104036, it reports that there are no other related ISBNs. Searching OCLC separately for each of the ISBNs returned by LibraryThing, OCLC reports that, in general, there are no related ISBNs for any of them, except for two cases:

1. The ISBN 9562913961, for the 9th edition, and the ISBN 9568209492 are related. According to WorldCat, the second ISBN is for the book *Kiwala va a la selva*, published in Chile by Editorial Amanuta.
2. The ISBN 0226103900, for the 13th edition, and the ISBN 0226104206, for the 16th edition, are related.

The first case is probably a data entry error by an OCLC member library; the second case is just odd. Why are these two editions related, but none of the other ones?

### Open Library

Open Library supports two levels of work relations: the different editions of the given title, such as cloth, paper, or electronic, as well the broader related works, which includes different editions, and translations. For this case, it returns the following ISBNs as being different formats of the 15th edition:

- 0226104036
- 0226104052 (cloth+CD-ROM)
- 0226104044 (CD-ROM only)

Like OCLC, it does not return other editions of the manual as related works to the 15th edition.  
Once again, starting with the LibraryThing dataset of related ISBNs, Open Library reports that the ISBN 1434102831 (the reproduction of the 1st edition) is unknown, and that all other editions are unique and unrelated to each other.

## Documentation

The LibraryThing API documentation consists of one or two paragraphs for each API, but this is reasonable, given that the APIs in question are all very simple with few options.

The OCLC API documentation is much richer, although the examples are somewhat monotonous, with all examples, except for one demonstrating the JSON callback format, using the XML format.

The Open Library API is the richest one available, with several different interfaces, each having a variety of options related to the format and type of data being returned, but it is the API with the weakest documentation. This lack of documentation for Open Library means that developers must spend a great deal of time experimenting and exploring to find out what is available and exactly how it works.

## Licensing

### LibraryThing

The LibraryThing license dictates that it may only be used for non-commercial purposes, that an application can only access the API once per second, and that if a user is going to access the API more than 1,000 times in a day, that the user must contact LibraryThing for approval.

Every API that LibraryThing provides has a slightly different license, although they all conform to the basic outline above. The more problematic restrictions are those on the APIs that provide access to information about the items in an individual LibraryThing user’s collection. The licenses for these APIs, the JSON Books and JSON Works APIs, state that the application using the API “Must be run as JavaScript on user’s browser, not fetched by a server; cannot be stored, except for browser caching” (LibraryThing, 2012).

### OCLC

The OCLC xISBN API is part of its family of “Affiliate Services”, and is regulated by the Terms and Conditions for those services (OCLC, 2009). According to those terms and conditions, users of the xISBN API may only use it in applications to accomplish acceptable “Purposes”, which are defined as,

> G. “Purposes” means managing and enabling access to: (i) library services, library materials, library resources and information related thereto; and/or (ii) services, materials, resources or information of interest to library patrons.

As well, section 3 of the Terms and Conditions gives a list of ways that we are not permitted to use the API, including “(iv) use of bots, spiders, or other automated information-gathering devices or programming routines to “mine” or harvest material amounts of Data.” While prohibiting most of the activities listed in section 3 is perfectly reasonable, the conditions listed in clause (iv) are troubling, since for many researchers, including me, the point of the API is to develop an “automated information-gathering device\[sic\]”, and often to mine or “harvest” data. One can only wonder how much data OCLC might consider to be “a material amount”.

OCLC also provides a list of “Frequently asked questions on rights and responsibilities,” which partially addresses questions related to research at an institution by non-library faculty:

> **6\. May an OCLC member make available or transfer extracted WorldCat data that represents or enriches the records for the member’s own holdings to an individual scholar for the purposes of supporting the scholar’s personal academic or scientific research or study?**
> 
> Yes. Please note, however, that the policy asks that in making extracted WorldCat data available or transferring it, members consider such actions and subsequent uses of the transferred WorldCat data (including copying, displaying, publishing, modifying, reformatting and/or creating works or services from) in the context of OCLC member community norms, OCLC’s public purpose and this policy’s intent.

But again, OCLC is assuming that access to their data will be mediated by the library, thus implicitly denying faculty researchers the option of building their own tools for data extraction and analysis.

The definition of acceptable purposes and the restrictions on the activities that may be performed by developers combine to make many types of bibliographic research, and potential research areas in the newly growing field of Digital Humanities of borderline acceptability.

The xISBN service is free for non-commercial use, without registering, for up to 1,000 requests per day. OCLC cataloguing members are granted free access after registering for a subscription. Other users (commercial use at any level, or non-OCLC cataloguing members making more than 1,000 requests in a day) may subscribe to the service (OCLC, 2007).

The [libX browser plugin](http://libx.org/) uses the xISBN service to provide its “related titles” catalogue search feature, interpreting these terms to apply to the user running the plugin, rather than to the developer writing the plugin. That is, when I use the libX plugin, I am the one using the xISBN service for non-commercial personal research, not the libX developers.

### Open Library

It’s difficult to find a license agreement on the Open Library website. The main page for the API documentation says, “Please note that this API should not be used for bulk downloads” (Open Library, 2013), but then goes on to say that the site makes data dumps available on a regular basis, and that those dumps should be used if a copy of the entire data set is required. There is a licensing page; the entire content of that page is:

> The Internet Archive does not assert any new copyright or other proprietary rights over any of the material in the Open Library database. There may be existing rights issues on some contributions and in some jurisdictions. When it comes to community projects, the legal issues are, frankly, very confusing, but we are attempting to make a database that can be openly used for a wide variety of purposes. We appreciate all that have contributed. (Open Library, 2010)

The footer of every page on the Open Library website says that users are subject to the Internet Archives terms of use. Those terms of use say that access is granted for “scholarship and research purposes only”, and that users certify that their use will be “noncommercial and will be limited to noninfringing or fair use under copyright law” (Internet Archive, 2001).

## Conclusions

The web APIs available for basic ISBN searching are all reasonably comparable in terms of functionality, with LibraryThing being the most minimal, and the Open Library being the richest, but the API by itself is almost the least important aspect of the selection process. Each API is associated with a unique bibliographic database that has its own quirks and flaws, and is of a certain size, and the use of each API is governed by specific license terms that may rule out the use of the API, regardless of the suitability of the interface and the data.

LibraryThing has a strong database, that is constantly growing, and is being maintained by a large, active, user community, but the API returns almost too little data, and the terms under which one may use the API, especially the limits on the number of times it may be called daily and the speed with which one may call it, severely limit its use for extensive research projects, even if it is suitable for the type of bibliographic search functionality for which the libX browser plugin uses it.

The Open Library has the most liberal license, and the most flexible API, but the dataset is small, inconsistent, error-prone, and no longer being maintained.

OCLC’s API fits into a good middle ground in terms of the metadata available via the API, and it has the largest bibliographic database available, but the terms and conditions placed on the use of the API bar certain users, and certain uses, from taking advantage of it. While the database is large and, for the most part, free of errors, it is not very consistent in its identification of related works.

Because my library is an OCLC cataloging member, many of the books that I will be examining may be very specialized or obscure, and I will be processing potentially tens of thousands of ISBNs, I opted to use the OCLC API, even though I don’t need the support for the additional bibliographic data. The ideal situation would be the OCLC database, with LibraryThing’s level of quality and linking between related works, and the Open Library’s terms and conditions. Unfortunately, the real world dictates that developers for every project will have to assess for themselves which system is most suitable for their work.

## References

Hellman, Eric. 2007. “OCLC xISBN Service Is Moving.” Code4Lib Archives \[cited 2013 Jul 11\]; Feb 12. Available from [https://listserv.nd.edu/cgi-bin/wa?A2=ind0702&L=CODE4LIB&P=R14329&1=CODE4LIB&9=A&J=on&K=3&d=No+Match%3BMatch%3BMatches&z=4](https://listserv.nd.edu/cgi-bin/wa?A2=ind0702&L=CODE4LIB&P=R14329&1=CODE4LIB&9=A&J=on&K=3&d=No+Match%3BMatch%3BMatches&z=4)

Internet Archive. 2001. “Internet Archive Terms of Use.” Internet Archive \[cited 2013 Jul 11\]; March 10. Available from [http://archive.org/about/terms.php](http://archive.org/about/terms.php).

LibraryThing. 2012. “LibraryThing APIs.” LibraryThing \[cited 2013 April 30\]; December 3. Available from: [https://www.librarything.com/wiki/index.php/LibraryThing\_APIs](https://www.librarything.com/wiki/index.php/LibraryThing_APIs).

OCLC. n.d. “WorldCat Web Service: xISBN \[OCLC – WorldCat Affiliate Tools\]: API.” OCLC WorldCat \[cited 2013 April 30\]. Available from: [http://xisbn.worldcat.org/xisbnadmin/doc/api.htm](http://xisbn.worldcat.org/xisbnadmin/doc/api.htm).

OCLC. 2007. “WorldCat Web Service: xISBN \[OCLC – WorldCat Affiliate Tools\]: Home.” OCLC WorldCat \[cited 2013 April 30\]. Available from: [http://xisbn.worldcat.org/xisbnadmin/index.htm](http://xisbn.worldcat.org/xisbnadmin/index.htm).

OCLC. 2009. “OCLC Affiliate Services Terms and Conditions.” WorldCat \[cited 2013 July 11\]; April 3. Available from: [http://www.worldcat.org/ldap/terms.jsp](http://www.worldcat.org/ldap/terms.jsp).

OCLC. n.d. “WorldCat Rights and Responsibilities for the OCLC Cooperative—frequently asked questions” \[cited 2013 July 11\]. Available from: [https://www.oclc.org/en-CA/worldcat/community/record-use/policy/questions.html](https://www.oclc.org/en-CA/worldcat/community/record-use/policy/questions.html)

OCLC Research. 2004. “Experimental Service Accepts an ISBN, Returns Set of ISBNs Associated with Same FRBR Work; Bookmarklet Then Uses to Query Library Holdings.” OCLC Research \[cited 2013 July 11\]; January 26. Available from: [http://www.oclc.org/research/news/2004/01-26.html](http://www.oclc.org/research/news/2004/01-26.html).

Open Library. 2010. “Developers / Licensing.” Open Library \[cited 2013 July 11\]; March 10. Available from: [http://openlibrary.org/developers/licensing](http://openlibrary.org/developers/licensing).

Open Library. 2013. “Open Library RESTful API (Open Library).” Open Library \[cited 2013 July 11\]; February 28. Available from: [http://openlibrary.org/dev/docs/restful\_api](http://openlibrary.org/dev/docs/restful_api).

## About the Author

David Fiander is the Web Services librarian at the University of Western Ontario where he is responsible for overseeing development of the Western Libraries website. He has been actively involved in open source development in libraries for over a decade, including developing for the Evergreen ILS project. Before becoming a librarian, David was a software developer, focusing on networking protocols and standards-based software portability.
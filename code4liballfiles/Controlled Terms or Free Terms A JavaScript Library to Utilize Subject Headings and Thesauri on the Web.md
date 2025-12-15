---
title: "Controlled Terms or Free Terms? A JavaScript Library to Utilize Subject Headings and Thesauri on the Web"
source: "https://journal.code4lib.org/articles/5994"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-10-31
created: 2025-01-10
description: "There are two types of keywords used as metadata: controlled terms and free terms. Free terms have the advantage that metadata creators can freely select keywords, but there also exists a disadvantage that the information retrieval recall ratio might be reduced. The recall ratio can be improved by using controlled terms. But creating and maintaining [...]"
tags:
  - "clippings"
---
# Controlled Terms or Free Terms? A JavaScript Library to Utilize Subject Headings and Thesauri on the Web
Shun Nagaya, Yutaka Hayashi, Shuhei Otani, Keizo Itabashi

There are two types of keywords used as metadata: controlled terms and free terms. Free terms have the advantage that metadata creators can freely select keywords, but there also exists a disadvantage that the information retrieval recall ratio might be reduced. The recall ratio can be improved by using controlled terms. But creating and maintaining controlled vocabularies has an enormous cost. In addition, many existing controlled vocabularies are published in formats less suitable for programming. We introduce a JavaScript library called “covo.js” that enables us to make use of controlled vocabularies as metadata for the organization of web pages.

## Introduction

Metadata is a powerful tool for organizing information resources, and its importance has increased on the Web. In particular, a method of information organization called “social tagging” has spread rapidly on sites like delicious, YouTube, and Twitter. Users of these Web services freely create and manage metadata called “tags” that enable clustering and improved searching of information resources. These metadata are called “free terms”. Free term tagging is very simple and easy to use for the Internet user; but there is also a disadvantage in that the information retrieval recall ratio can be reduced. The recall ratio can be improved by using “controlled terms.” If controlled tags, or terms, were used in Web services, the recall ratio would improve.

However, there is an enormous cost and it takes special knowledge to create, maintain and apply controlled vocabularies. Many existing controlled vocabularies are published in formats less suitable for programming, such as paper, PDF, and HTML documents. Machine readable controlled vocabularies could improve the recall ratio and open up access to valuable resources, and we are starting to see examples of Web-based controlled vocabularies appearing. Thus, we propose to use controlled terms as tags in Web services, social tagging services and information retrieval services. For this purpose, we developed a JavaScript library called [covo.js](https://github.com/haseharu/covojs "covo.js") that allows Web service users to input controlled terms. In this article, we will introduce covo.js and the ways to use controlled vocabularies of various formats in client-side JavaScript libraries.

## covo.js

covo.js is a JavaScript library that makes it easy to use controlled terms as a tool for information organization. The features of covo.js are controlled vocabularies in drop-down lists that are selectable by inputting a trigger word [\[1\]](https://journal.code4lib.org/articles/#note1), an incremental search from controlled terms, and some customizable function configurations, as shown in Figure 1. In the present version of covo.js (as of September 2011), we do not yet make use of the hierarchical structures of controlled vocabularies.

![How to input Controlled Terms](https://journal.code4lib.org/wp-content/uploads/2011/10/covo-figure1-1024x486.png "How to input Controlled Terms")

Figure 1: How To Input Controlled Terms

![](https://www.youtube.com/watch?v=bzAYID4sg6Q)

Covo.js supports ten controlled vocabularies that fall into three categories, or patterns, that are listed in parentheses and will be discussed below:

- Web NDL Authorities (BETA) (1)
- Faceted Application of Subject Terminology (2)
- Form and Genre Terms for Fiction and Drama (2)
- Library of Congress Annotated Card Program Subject Headings (2)
- Library of Congress Subject Headings (2)
- Medical Subject Headings (2)
- TGM I, Subject Terms: Thesaurus for Graphic Materials (2)
- TGM II, Genre and Physical Characteristic Terms: Thesaurus for Graphic Materials (2)
- INIS Multilingual Thesaurus (3)
- Wikipedia Thesaurus (3)

## Getting started with covo.js

Including the covo.js library on your Web service makes it easy to utilize thesauri and subject headings. covo.js can be introduced into social tagging or information retrieval services. To try them out you will need to download covo.js and some necessary components, put them on your server, and write some configuration code. Covo.js requires a few components to be installed: [jQuery UI](http://jqueryui.com/) and the [jQuery Autocomplete plugin](http://jqueryui.com/demos/autocomplete/). If you want to customize covo.js, please refer to the [online documentation](http://covojs.tumblr.com/post/10589794643/documents).

Add covo.js to the HTML `<head>` element:

| 1 | `<``script` `src``=``"covo.js"` `type``=``"text/javascript"``></``script``>` |
| --- | --- |

And create the covo.js widget in your `<body>` element:

| 1  2  3  4 | `<``div` `class``=``"ui-widget"``>`  `<``label` `for``=``"covo"``>Let's covo.js ! : </``label``>`  `<``input` `id``=``"covo"` `/>`  `</``div``>` |
| --- | --- |

## Why did we choose JavaScript?

This library is coded with JavaScript. These are two reasons why we choose JavaScript rather than server-side scripts like Perl, PHP, or Python.

The first reason is that covo.js runs on the client side and does not depend on the server-side environment. However, some behaviors of JavaScript depend on the client environment. This is called the cross-browser issue, and we selected the jQuery UI to solve this problem.

The second reason is that Web service users can embed covo.js in Web browsers using Greasemonkey or Firefox add-ons. Currently, we can use covo.js only if a Web service provider has set it up on the server. There are planned future enhancements of covo.js that will allow users to choose whether they use it or not.

### Basic Structure of covo.js

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `$(``function``() {`  `$(``"#covo"``).autocomplete({`  `source: ``function``(request, response) {`  `$.ajax({`  `url: http:`  `dataType: "jsonp",`  `success: ``function``(data , dataType) {`  `response($.map(data, ``function``(item) {`  `return` `item.keyword;`  `})`  `})`  `})`  `}`  `})`  `});` |
| --- | --- |

When a JavaScript library cannot access thesauri and subject headings, we need to use server-side programs or Web services.

## How to use thesauri and subject headings on the Web

One can add other controlled vocabularies and extend covo.js. The problem with extending covo.js is how to use controlled vocabularies in JavaScript libraries. Through the development of covo.js, we found the following four patterns for using Web-based controlled vocabularies.

- Pattern 1: Web API with [JSONP](http://en.wikipedia.org/wiki/JSONP)
- Pattern 2: Web API without JSONP
- Pattern 3: Without Web API
- Pattern 4: Not on the Web

In this chapter, we explain data-handling methods for various controlled vocabularies on the Web. Figure 2 provides an overview of the organization of this chapter.

![Types of Controlled Vocabulary Services](https://journal.code4lib.org/wp-content/uploads/2011/10/covo-figure2-1024x519.png "Types of Controlled Vocabulary Services")

## Pattern 1: Web API with JSONP

Recently, many Web services have begun supporting Web API, and some of them return values in JSONP (JavaScript Object Notation with Padding) that are directly loadable by JavaScript. Thus, if the Web API provides JSONP data, they can be used in client-side JavaScript. This pattern turns out to be the simplest among the four to support.

In this section we introduce the case of [Web NDL Authorities (BETA)](http://id.ndl.go.jp/auth/ndla/Web) as an example. Web NDL Authorities (BETA) has been produced by the National Diet Library of Japan and enables us to use all of NDL’s authority files: personal names, family names, corporate names, geographic names, etc. It accepts [SPARQL](http://en.wikipedia.org/wiki/SPARQL/), one of the RDF query languages, and returns authority data in JSONP format.

### Sample SPARQL query

### Endpoint of Web NDL Authorities(BETA)

```
http://id.ndl.go.jp/auth/ndla?query={{SPARQL}}&output=json&callback=ndl
```

### Sample Response

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23 | `ndl({`  `"head"``: {`  `"vars"``: [`  `"x"``,`  `"label"`  `]`  `},`  `"results"``: {`  `"bindings"``: [`  `{`  `"x"``: {`  `"type"``: ``"uri"``,`  `},`  `"label"``: {`  `"type"``: ``"literal"``,`  `"value"``: ``"edible books"`  `}`  `}`  `]`  `}`  `})` |
| --- | --- |

## Pattern 2: Web API without JSONP

When Web services provide Web APIs that do not support JSONP, the Web API cannot be accessed directly from JavaScript. This is due to the same origin policy of Web browsers, which prohibits cross-domain requests [\[2\]](https://journal.code4lib.org/articles/#note2). The simplest technique for this pattern is to make a “proxy” on the same server as covo.js that converts other data formats to JSON. In this section, we introduce the case of [Terminology Services](http://tspilot.oclc.org/resources/) provided by OCLC. This service supports seven vocabulary resources, and it is equipped with the [SRU](http://www.loc.gov/standards/sru/) interface. This interface covers multiple representations including HTML, MARC XML, SKOS, and Zthes. Thus, we have to prepare a server-side program to convert XML or HTML into JSONP. The following is a converter program.

### Sample converter PHP program

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `<?php`  `$query` `= ``strip_tags``(``$_GET``&#91;``"q"``&#93;);`  `$subject` `= ``strip_tags``(``$_GET``&#91;``"subject"``&#93;);`  `$callback` `= ``strip_tags``(``$_GET``&#91;``"callback"``&#93;);`  `$url` `= ``'[http://tspilot.oclc.org/](http://tspilot.oclc.org/)'``. ``$subject` `. ``'/?query=oclcts.terms+any+%22'``. ``$query` `. ``'%22&version=1.1&operation=searchRetrieve&recordSchema=info%3Asrw%2Fschema%2F1%2Fmarcxml-v1.1&maximumRecords=10&startRecord=1&recordPacking=xml&sortKeys='``;`  `$source` `= ``file_get_contents``(``$url``);`  `$xml` `= ``new` `SimpleXMLElement(``$source``);`  `$source` `= ``$xml``->xpath(``'//ns2:datafield[@tag="150"]/ns2:subfield[@code="a"]'``);`  `echo` `$callback` `.``"(["``;`  `foreach``(``$source` `as` `$value``){`  `echo` `'{"keyword":"'``. ``$value` `.``'"},'``;`  `}`  `echo` `"])"``;`  `?>` |
| --- | --- |

## Pattern 3: Without Web API

When Web services are not equipped with Web API, we need to harvest and scrape HTML with certain Web services or server-side programs. This section explains the two cases of the [INIS Multilingual Thesaurus](https://nkp.iaea.org/INISMLThesaurus/) and the [Wikipedia Thesaurus](http://dev.sigwp.org/WikipediaThesaurusV3/). The key difference between these two services is that the INIS Multilingual Thesaurus consists of static Web pages, while the result pages of the Wikipedia Thesaurus can vary dynamically based on the user’s query.

The INIS Multilingual Thesaurus is a set of subject vocabularies on nuclear science and technology published online in HTML and PDF formats. Now, we need not only to prepare a proxy, as explained above, but also to scrape data from such Web pages. Here, our approach is to use another Web service, [ScraperWiki](http://scraperwiki.com/). We simply write some PHP code on “Screen Scraper,” the online editor of ScraperWiki, and then it scrapes only the necessary data from the Web pages and returns them in JSONP.

### Sample PHP proxy program

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 | `<?php`  `require` `'scraperwiki/simple_html_dom.php'``;`  `$html` `= ``new` `simple_html_dom();`  `$html` `=`  `foreach``(``$html``->find(``'body h2'``) ``as` `$data1``){`  `$targetUrl` `= ``$data1``->find(``'a'``,0)->href;`  `$htmlTree` `= ``new` `simple_html_dom();`  `$htmlTree` `= file_get_html(``$targetUrl``);`  `foreach``(``$htmlTree``->find(``'body a'``) ``as` `$data2``){`  `$keyword` `= ``$data2``->find(``'p'``,0)->plaintext;`  `$record` `= ``array``(``'keyword'` `=> ``$keyword``);`  `scraperwiki::save(``array``(``'keyword'``), ``$record``); `  `}`  `}`  `?>` |
| --- | --- |

Wikipedia Thesaurus is a product of [Special Interest Group on Wikipedia Mining](http://wikipedia-lab.org/en/index.php/Main_Page). For this service, one needs to query the database with a HTTP GET request, get the search results in HTML, and scrape them using regular expressions.

The following is a sample proxy script for Wikipedia Thesaurus.

### A URL to GET

```
http://dev.sigwp.org/WikipediaThesaurusV3/Search.aspx?k=nuclear&t=0&l=English
```

### Part of the Response

| 1 | `<``a` `id``=``"dSearchResults_ctl00_AttributeList_ctl01_hRelatedTerm"` `href``=``"Search.aspx?k=Plutonium&t=0&l=English"``>Plutonium</``a``>` |
| --- | --- |

### Sample PHP proxy program

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22 | `<?php`  `$query` `= ``strip_tags``(``$_GET``&#91;``"q"``&#93;);`  `$lang` `= ``strip_tags``(``$_GET``&#91;``"la"``&#93;);`  `$callback` `= ``strip_tags``(``$_GET``&#91;``"callback"``&#93;);`  `if` `(``strlen``(``$query``) == mb_strlen(``$query``, ``'UTF8'``)) {`  `$lang` `= ``"English"``;`  `} ``else` `{`  `$lang` `= ``"Japanese"``;`  `}`  `$source` `= ``file_get_contents``(``$url``);`  `preg_match_all(``'/<a id=\"dSearchResults_ctl&#91;0-9&#93;&#91;0-9&#93;_hTitle.*<\/a>/'``, ``$source``, ``$result``, PREG_SET_ORDER);`  `echo` `$callback` `.``"(["``;`  `foreach``(``$result` `as` `$value``){`  `$value` `= preg_replace(``'/<a.*">\|<\/a>/'``,``''``,``$value``);`  `echo` `'{"keyword":"'``. ``$value``[0] .``'"},'``;`  `}`  `echo` `"])"``;`  `?>` |
| --- | --- | --- |

## Pattern 4: Not on the Web

When controlled vocabularies are not provided in any machine-readable formats, they are challenging to use. Unfortunately, we have not yet met this challenge. If the controlled vocabularies you are interested in are only available offline, you might ask the suppliers to publish their resources online (and implement Web API for their services if possible). The final possibility is digitizing them yourself using a document scanner and OCR technology.

For all these patterns, we are required to pay attention to the copyright law on using controlled vocabulary services.

## Conclusion and Future Work

covo.js provides support for user input of controlled vocabularies. The number of controlled vocabularies has gradually increased. Not all Web services support access via a Web API. However, with some JavaScript or server-side code, controlled vocabularies without Web API can be made available to covo.js. The methods to accomplish this are divided into four patterns, as indicated in this article.

Furthermore, two problems should be solved to improve the functionality of covo.js. First, controlled vocabularies have rich structures of links among terms, such as BT (broader terms), RT (related terms), or UF (used for) links, but covo.js does not make good use of this. In the present version of covo.js, each keyword can only be displayed in a linear mode.

Second, up to now, our proposed library has only used controlled vocabularies on the Web. It is true that controlled terms can improve the information retrieval recall ratio, but free terms are widely used in actual services, such as metadata used in social tagging or search engine queries (or indexes). Thus, in the future we will include such free terms as well as controlled terms. For this purpose, it is necessary to use a mechanism to implement free terms as a controlled vocabulary.

## Notes

[\[1\]](https://journal.code4lib.org/articles/#ref1) The “trigger word” can be customized; it has been set to “-“(hyphen) in this article.

[\[2\]](https://journal.code4lib.org/articles/#ref2) In this article we do not deal with solutions to the same origin policy other than using JSONP. However, we want to note one of them here, Cross Origin Resource Sharing (CORS: http://www.w3.org/TR/cors/). Web browsers that implement XMLHttpRequest (XHR) Level 2 allow cross-domain requests from any client if the Web servers are configured to include \`Access-Control-Allow-Origin: \*\` in the headers of the HTTP responses. Many modern browsers, including Internet Explorer 8+, have been supporting XHR Level 2.

## About the Authors

Shun Nagaya (haseharu@gmail.com) is a librarian at the Japan Atomic Energy Agency. He edits JAEA Reports and JAEA R&D Review and manages the grants for paper submission and conference presentations. He holds a Bachelor’s degree in Engineering from the University of Electro-Communications and a Master’s degree in Library and Information Science from University of Tsukuba.

Yutaka Hayashi (hayashiyutaka@gmail.com) is a research librarian at the National Diet Library, Japan, and is engaged in writing blogs and articles for libraries and library science on the Current Awareness Portal (http://current.ndl.go.jp/). He has a Master’s degree in Mathematics from Nagoya University. He formerly worked at Kyoto University until March 2011.

Shuhei Otani (otani0083@gmail.com) is a reference librarian at the University of Ryukyus and is in charge of information literacy. He has a Bachelor’s degree in Korean history from Kyushu University. Nagaya, Hayashi, and Otani are library geeks and formed a group called “li:d tech” in January 2011.

Keizo Itabashi is a deputy director of the Intellectual Resources Department of the Japan Atomic Energy Agency.
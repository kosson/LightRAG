---
title: "The Integrated Library System’s APIs, an Open-source Web 2.0 Catalog, and University Computing Live Happily Ever After"
source: "https://journal.code4lib.org/articles/4165"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-12-21
created: 2025-01-10
description: "It is widely accepted that students prefer a library catalog that offers the features that they find using Google or Amazon. One of these features would be dynamically delivered services. This article describes the obstacles faced trying to integrate traditional integrated library system (ILS) architecture with an open source Web 2.0 search interface, and outlines [...]"
tags:
  - "clippings"
---
# The Integrated Library System’s APIs, an Open-source Web 2.0 Catalog, and University Computing Live Happily Ever After
Birong Ho

It is widely accepted that students prefer a library catalog that offers the features that they find using Google or Amazon. One of these features would be dynamically delivered services. This article describes the obstacles faced trying to integrate traditional integrated library system (ILS) architecture with an open source Web 2.0 search interface, and outlines the path to a solution for delivering user services such as the hold and recall functions.

## I. Background for the Western Michigan University (WMU) Web 2.0 Catalog

Western Michigan University (WMU) implemented VuFind (hereafter referred as WMU New Catalog) as the primary OPAC interface for its Voyager system in September 2009. VuFind was originally developed by Villanova University in 2008. It is offered for no cost under the GPL open source license. VuFind 1.0 release was made available in July, 2010. VuFind includes many Web 2.0 catalog features such as user tagging, comments, and reviews, as well as “more like this” and “did you mean.”

Despite the fact that WMU’s license for Voyager does not allow the library to write directly to Voyager’s underlying database tables, which makes interaction between the ILS and VuFind or any other stand-alone discovery layer difficult or impossible, WMU chose to implement VuFind. VuFind now has a community of libraries that have implemented and improved the catalog. A partial list of libraries from around the world that have implemented VuFind can be found at: [http://vufind.org/wiki/installation\_status](http://vufind.org/wiki/installation_status).

VuFind runs on top of Apache Solr. Solr is an open source enterprise search platform from the Apache Lucene project. Its major features include powerful full-text search, hit highlighting, faceted search, dynamic clustering, database integration, and rich document (e.g., Word, PDF) handling. Solr offers amazing performance and scalability to allow for VuFind to respond to searching queries in milliseconds time. Solr is different from a relational database management system such as Oracle which consists of many different index tables. Solr consists of a single large table that is optimized for fast lookup. WMU’s New Catalog utilizes Solr’s basic search functionality, and further extends Solr to meet the needs of users. Extended features implemented include searching location and format facets, and relaxing the standard Porter stemmer included with Apache Solr.

## II. Usability Issues to Overcome

Librarians at WMU believe that students today prefer a library OPAC (Online Public Access Catalog) that delivers search results ranked by relevance, faceting, “more like this” and “did you mean,” etc. A traditional library OPAC does not meet these expectations. Due to the license restrictions mentioned above, WMU could not directly write user transactions such as recall/holds and account activities directly into Voyager’s underlying Oracle tables. Instead, it was necessary to redirect these functions to Voyager’s Classic WebVoyage interface. (Classic WebVoyage is the original OPAC interface with Voyager Integrated Library System (ILS) which was first owned by Endeavor Information Systems and later was acquired by Ex Libris.) Redirecting users to the Classic WebVoyage interface for these functions caused confusion.

## III. The Solution

WebVoyage, the Voyager OPAC, has been completely redesigned for Voyager 7.0. The new interface made its debut in Voyager libraries in June, 2008. As part of Voyager 7.0, Ex Libris implemented WebVoyage Web Services. WMU embedded WebVoyage Web Services into VuFind’s Driver program. PHP function codes interact with the University’s Lightweight Directory Access Protocol (LDAP) authentication system. The two interactions are put together to resolve the problem. The solution of using Web Services to replace redirecting users to Classic WebVoyage was implemented in WMU New Catalog in January, 2010. Voyager offers its Web Services via the Apache Tomcat server. Apache Tomcat is an open source servlet container developed by the Apache Software Foundation (ASF). Tomcat implements the Java servlet and the JavaServer Pages (JSP) specifications from Sun Microsystems, and provides a “pure Java” HTTP web server environment for running Java code. Web Services are defined as follows in Wikipedia:

> A Web API is typically a defined set of HTTP request messages along with a definition of the structure of response messages, typically expressed in JSON or XML.
> 
> While “Web API” is sometimes considered a synonym for web service, the Web 2.0 applications typically have moved away from SOAP based web services towards more direct REST style communications. ([Wikipedia contributors 2010](https://journal.code4lib.org/articles/#reference1))

WebVoyage Web Services are provided via the Voyager X services Web Services (VXWS) services. There are VXWS and VWEBV services provided by Voyager’s Apache Tomcat. Regular Voyager’s WebVoyage (version 7.0) are served from the vwebv directory. A definition regarding the scope and functionality of Voyager’s Web Services was detailed in an Ex Libris’s press release:

> The set of Web services that was introduced previously has been enlarged to increase the openness of Voyager, facilitating its interoperability with other systems and enabling customers to develop code extensions that they can share with the Voyager community. All Web services are available in the Developer Zone of the EL Commons collaborative Web site. ([Continued Momentum for Voyager… 2009](https://journal.code4lib.org/articles/#reference2))

The Developer Zone of the CodeShare (previously known as EL Commons) website hosts programming-oriented information related to Ex Libris systems and serves as a channel of communication among community members: customer developers from the user community and Ex Libris developers.

These Voyager Web Services are sets of application programming interfaces (APIs) that enable the interaction between Voyager and other application programs. There are two types of open interfaces in Voyager’s Web Services: RESTful APIs and XML over HTTP. Both types of interface are provided via the VXWS services in Voyager. WMU uses XML over HTTP Web Service for the applications deployed at WMU described in this article. These Web Services are free of charge to licensed customers of Voyager.

According to [Duong](https://journal.code4lib.org/articles/#refrence3), the WebVoyage Web Services design is characterized by stateless, atomic transactions and consumer/provider (client/server) architecture \[[1](https://journal.code4lib.org/articles/#note1)\]. Each web service requires an OPAC instance to access the Oracle database. Ex Libris designed these Web Services for the following rationales: the interoperability between different systems, the integration between different applications, to enrich customer functionality, and to create a federation of resources and to facilitate faster time for software development cycle. Detailed Information regarding these services is outlined in the collaborative Web site: [http://www.exlibrisgroup.org/display/VoyagerOI/XML+Over+HTTP+Web+Services](http://www.exlibrisgroup.org/display/VoyagerOI/XML+Over+HTTP+Web+Services). Web Services include search services, media services, patron requests services, etc. Duong (2009) further identified the process of setting up the web services. The configuration file on Voyager server is vxws.ini. OPAC/CIRC server configuration in the server.xml was also verified. And further Apache Web Server, Tomcat, and Oracle database connection were validated, and that OPACSVR/CIRCSVR is operational. According to Ex Libris, the Voyager’s Web Services are heavily used by Ex Libris’s discovery tool Primo.

> Libraries that choose to integrate Voyager with the Primo® discovery and delivery solution by Ex Libris Group provide their users with a universal solution for the discovery and delivery of all material types—print, electronic, and digital—regardless of format and location. ([Voyager Integrated Library System 2010](https://journal.code4lib.org/articles/#reference4))

It was essential that WMU’s New Catalog include functionality that allowed end-users to place holds/recalls, renew items, use account services, add tags, and mark items as favoriates. It also includes options such as utilizing personal bibliographic software such as RefWorks, and Endnote. Functionality as such involves operations from both Voyager and VuFind. See Figure 1: Web API, and VuFind Connections and Figure 2: WMU’s VuFind connections to other local systems for VuFind’s interaction and inter-operation with Voyager and other local systems such as the University LDAP System.

[![Web API and VuFind connections flowchart](https://journal.code4lib.org/media/issue12/ho/fig1_sm.png)](https://journal.code4lib.org/media/issue12/ho/fig1.png)

Figure 1. Web API and VuFind connections.

[![WMU’s VuFind connections to other local systems flowchart](https://journal.code4lib.org/media/issue12/ho/fig2_sm.png)](https://journal.code4lib.org/media/issue12/ho/fig2.png)

Figure 2. WMU’s VuFind connections to other local systems.

The University Computing (Office of Information Technology) has strongly “suggested” that a single interface for authentication is to be used to ensure security and uniformity among various campus systems. LDAP is the single authentication interface implemented at WMU. In addition to the University’s suggested single interface requirement, it was also desired to simplify the different user IDs used among different library systems such as Interlibrary Loan (Illiad), Michigan Electronic Catalog (MelCat), etc. Please see Figure 3 for the various Library Accounts for WMU users.

[![Image showing various library accounts for WMU users](https://journal.code4lib.org/media/issue12/ho/fig3_sm.png)](https://journal.code4lib.org/media/issue12/ho/fig3.png)

Figure 3. Various library accounts for WMU users.

There is no software module or library in Voyager that works directly with a LDAP server. However, there is a standard module in VuFind which allowed WMU to use LDAP to authenticate users by using the University’s Bronco NetID (Bronco NetID is the name given to the University’s single sign-on LDAP system.) The decision to use LDAP with the New Catalog was thus made based on the above rationales. In order to interact with the University Computing’s LDAP server, it was necessary that a configuration file be set up in WMU’s New Library Catalog. For WMU’s New Catalog to complete the Voyager’s Web Services, the extra step of the interaction with Voyager’s Oracle tables to get patron’s last name and institution ID is also required.

Placing holds and recalls, renewing loans, looking up account details, and similar functions are important features that are heavily used by patrons at WMU. The implementation of these functions require some pertinent information to be retained from the users’ input and some additional information retrieved by querying Voyager’s Oracle database. Once this information is obtained, then the transactions will be constructed. As mentioned previously, due to the license restrictions, transactions such as renew cannot be written directly to Voyager’s Oracle tables by using PHP or other programming languages together with their SQL insert/update commands. However, Web Services provided by Voyager can be utilized to work with Oracle tables. As a result, PHP together with its http request is used to implement Voyager Web Services to achieve the above needs and functions.

The request process includes the following (see Figure 4):

1. The user places a request on a bib record/holding record.
2. The process will check to see if the user has logged in. If the user is not logged in, then the user will be directed to the login/authentication page.
3. If the user is logged in, the user will be directed to the page where other options such as pickup locations are presented.
4. AuthFactor Type I is used for authentication with Voyager Web Services. Before placing the request with Voyager Web Services, an Oracle OCI is placed to query Voyager about the user’s last name and institution ID. (See [Appendix A](https://journal.code4lib.org/articles/#appendixA) – PHP PDO’s interact with Voyager Oracle™ tables).
5. The hold request is placed via Voyager Web Services. See [Appendix B](https://journal.code4lib.org/articles/#appendixB) – Code Snippets for Renewing which Require Patron ID, Last Name, and Institution ID. See [Appendix C](https://journal.code4lib.org/articles/#appendixC) – Code Snippets for Hold/Recall.
6. After the request is placed, the user is redirected to the account page. The request is verified and listed there.

[![Image showing the request process](https://journal.code4lib.org/media/issue12/ho/fig4_sm.png)](https://journal.code4lib.org/media/issue12/ho/fig4.png)

Figure 4. Request Process.

The hold/recall PHP function is very straightforward. See [Appendix D](https://journal.code4lib.org/articles/#appendixD) – the Hold/Recall PHP Program in WMU New Catalog. A special thank you goes to Purdue University’s PHP programmer Matthew T. Riehle for sharing the original codes with the VuFind community. WMU heavily revised the original code created by Riehle to accommodate the local needs. Ex Libris provides technical seminars that librarians can attend that cover “using Voyager Web Services.” In these technical seminars, the Perl programming language is typically used for demonstration.

## IV. Conclusion

The implementations described in this article detailed the possibility of integrating applications from different parties. Such a project creates more opportunities to enrich functionality and ease of use for OPAC users. Providing users the options of placing a hold on items and selecting pickup locations provides unique opportunities for user services. This endeavor further reinforces the University Strategic plan to implement a single sign-on system. Doing so further helps to serve users on various campuses so they do not have to travel across campuses and thus their travel time is shortened. Users’ high volume of utilizing such user services will be anticipated in the coming semesters. Similar projects, yet to be developed by the library community, such as Code4Lib, are likely to further assist users and enrich their use of the library catalog.

## Appendix A: PHP PDO’s interact with Voyager Oracle™ tables

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19 | `public` `function` `patronLogin(``$barcode``, ``$lname``)`  `{`  `$sql` `= "SELECT PATRON.PATRON_ID, PATRON.INSTITUTION_ID, PATRON.LAST_NAME FROM .`  `$this``->dbName.PATRON WHERE PATRON.INSTITUTION_ID = ``'$barcode'``" ;`  `try` `{`  `$sqlStmt` `= ``$this``->db->prepare(``$sql``);`  `$sqlStmt``->execute();`  `$row` `= ``$sqlStmt``->fetch(PDO::FETCH_ASSOC);`  `if` `(isset(``$row``[``'PATRON_ID'``]) && (``$row``[``'PATRON_ID'``] != ``''``)) {`  `return` `array``(``'id'` `=> ``$row``[``'PATRON_ID'``],`  `'institution_id'` `=> ``$row``[``'INSTITUTION_ID'``],`  `'last_name'` `=> ``$row``[``'LAST_NAME'``]);`  `} ``else` `{`  `return` `null;`  `}`  `}``catch` `(PDOException ``$e``) {`  `return` `new` `PEAR_Error(``$e``->getMessage());`  `}`  `}` |
| --- | --- |

## Appendix B: Code Snippets for Renewing Which Require Patron ID Last Name and Institution Id.

Note: See Appendix A for how to get the patron’s ID and last name and institution ID and see document from Voyager’ CodeShare site for complete codes and vufind-tech listserv for complete codes.

The renew function should include

1. Paramterized the WS Consumer(i.e. pass itemid and patron information) , such as:
```
public
```
2. create a client of HTTP\_Request which will call RenewService:
3. xml message should include authFactor:
```
<
```
4. should include service names:
```
       
```

## Appendix C: Code Snippets for Hold/Recall.

Note: See document from Voyager’ CodeShare site for complete codes and vufind-tech listserv for complete codes.

1. the function should pass the following parameters: $bibid, $itemid, $patron, $pickuplocation.  
For example:
```
public
```
2. ser:parmater should include:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19 | `<``ser:parameters``>`  `<``ser:parameter` `key``=``"bibDbName"``>`  `<``ser:value``>Western Michigan University Libraries Westcat</``ser:value``>`  `</``ser:parameter``>`  `<``ser:parameter` `key``=``"bibDbCode"``>`  `<``ser:value``>WMICHDB</``ser:value``>`  `</``ser:parameter``>`  `<``ser:parameter` `key``=``"requestCode"``>`  `<``ser:value``>RECALL</``ser:``\value>`  `</``ser:parameter``>`  `<``ser:parameter` `key``=``"REQNNA"``>`  `<``ser:value``>90</``ser:value``>`  `</``ser:parameter``>`  `<``ser:parameter` `key``=``"CVAL"``>`  `<``ser:value``>thisCopy</``ser:value``>`  `</``ser:parameter``>`  `<``ser:parameter` `key``=``"requestSiteId"``>`  `<``ser:value``>1@1@WMICHDB20020730122958</``ser:value``>`  `</``ser:parameter``>` |
| --- | --- |

## Appendix D: Hold/Recall PHP Program in WMU New Catalog

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40 | `<?php`  `require_once` `'CatalogConnection.php'``;`  `require_once` `'Action.php'``;`  `require_once` `'services/MyResearch/lib/User.php'``;`  `require_once` `'services/MyResearch/lib/Resource.php'``;`  `require_once` `'services/MyResearch/MyResearch.php'``;`  `require_once` `'Record.php'``;`  `class` `Hold ``extends` `Record`  `{`  `function` `launch()`  `{`  `global` `$interface``;`  `global` `$configArray``;`  `global` `$user``;`  `if``(``$user``){`  `ob_start();`  `$catalog` `= ``new` `CatalogConnection(``$configArray``&#91;``'Catalog'``&#93;&#91;``'driver'``&#93;);`  `$patron` `= ``$catalog``->patronLogin(``$user``->username, ``$user``->password);`  `$interface``->setTemplate(``'hold.tpl'``);`  `$interface``->display(``'layout.tpl'``);`  `if``(isset(``$_POST``[``'hold'``])){`  `$catalog``->submitRecall(``$_GET``[``'id'``], ``$_REQUEST``[``'itemid'``], ``$patron``, ``$_REQUEST``[``'pickuplocation'``]);`  `header(``'Location: '` `. ``$configArray``[``'Site'``][``'url'``] . ``'/MyResearch/Holds'``);`  `ob_end_flush();`  `}`  `}`  `else``{`  `ob_start();`  `header(``"Location: "` `. ``$configArray``[``'Site'``][``'url'``] . ``"/MyResearch/Home?sendurl=[https://](https://)"`            `.``$_SERVER``[``"SERVER_NAME"``] .``$_SERVER``[``"REQUEST_URI"``]);`  `require_once` `'services/MyResearch/Login.php'``;`  `Login::launch();`  `exit``();`  `ob_flush();`  `}`  `}`  `}`  `?>` |
| --- | --- |

## Notes:Continued Momentum for Voyager with the Release of Version 7.1. 2009 Jun 25. \[place unknown\]: Library Technology Guides; \[cited 2010 Dec 4\]. Available from: [http://www.librarytechnology.org/ltg-displaytext.pl?RC=14041](http://www.librarytechnology.org/ltg-displaytext.pl?RC=14041)Duong, C. 2009 Mar 26. Focus Point of Open Platform, Voyager Web Services. at: Developers Meet Developers March 2009; \[cited 2010 Nov 17\]. Note: Some presentations from this meeting are available at: [http://www.exlibrisgroup.org/display/presentations/Developer+Meets+Developer+March+2009](http://www.exlibrisgroup.org/display/presentations/Developer+Meets+Developer+March+2009)Voyager Integrated Library System. c2010. \[place unknown\]: Ex Libris Limited; \[cited 2010 Dec 4\]. Available from: [http://www.exlibrisgroup.com/category/Voyager](http://www.exlibrisgroup.com/category/Voyager)Wikipedia contributors. Web API. Wikipedia, The Free Encyclopedia; 2010 Nov 16, 8:45 UTC \[cited 2010 Dec 4\]. Available from: [http://en.wikipedia.org/wiki/Web\_API](http://en.wikipedia.org/wiki/Web_API).
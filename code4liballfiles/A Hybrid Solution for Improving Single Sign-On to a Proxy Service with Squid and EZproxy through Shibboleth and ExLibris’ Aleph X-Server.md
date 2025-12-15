---
title: "A Hybrid Solution for Improving Single Sign-On to a Proxy Service with Squid and EZproxy through Shibboleth and ExLibris’ Aleph X-Server"
source: "https://journal.code4lib.org/articles/7470"
author:
  - "[[The Code4Lib Journal]]"
published: 2012-10-03
created: 2025-01-10
description: "This paper describes an implementation of a hybrid solution for improving the library's proxy service by integrating Shibboleth and ExLibris' Aleph’s X-server using a proxy server running both EZproxy and Squid applications. We will describe in detail the hybrid solution of a proxy service within the context of our institution and explain how this service [...]"
tags:
  - "clippings"
---
# A Hybrid Solution for Improving Single Sign-On to a Proxy Service with Squid and EZproxy through Shibboleth and ExLibris’ Aleph X-Server

Alexander Jerabek, Minh-Quang Nguyen

This paper describes an implementation of a hybrid solution for improving the library’s proxy service by integrating Shibboleth and ExLibris’ Aleph’s X-server using a proxy server running both EZproxy and Squid applications.

We will describe in detail the hybrid solution of a proxy service within the context of our institution and explain how this service improves the user experience. We will explain how we developed and implemented this solution with a minimum of development cost and describe some of the preliminary empirical research undertaken.

The main benefit of this solution is that instead of relying on e-resource vendors to become Shibboleth-compliant, we are able to prepare and deploy a Shibboleth-ready environment while granting our patrons reliable and stable access to e-resources via different types of connections. As of December 2011, the hybrid solution is running in production.

## Definitions

*Proxy service*, in this library context, is a service that monitors and facilitates access to e-resources. This service acts as an intermediary between an e-resources vendor and libraries who offer these resources to their users (see [http://en.wikipedia.org/wiki/Proxy](http://en.wikipedia.org/wiki/Proxy)).

*Proxy server* is a computer system that has proxy services.

*Squid* – open source software released under the GNU General Public License – is a proxy caching server for web clients. The Squid application allows authenticated users off-campus to access e-resources such as ProQuest, HeinOnline, and SpringerLink. Squid provides features such as: filter access to e-resources, validating user input, and reduce redundancy to limit access to sites’ traffic providers (See [http://wiki.squid-cache.org](http://wiki.squid-cache.org/), [http://en.wikipedia.org/wiki/Squid](http://en.wikipedia.org/wiki/Squid)). Squid requires that the browser is configured with a Proxy-Auto-Configuration (PAC) file that contains a list of domains that need to be proxied.

*EZproxy* is proprietary software that provides the same functionality as Squid but unlike Squid, EZproxy has a Shibboleth module (see [http://en.wikipedia.org/wiki/EZproxy](http://en.wikipedia.org/wiki/EZproxy)). EZProxy does not require any configuration of the browser (e.g. no need to add a PAC file) but it needs to add a prefix URL to the e-resource’s URL to be proxied. For example, where the original e-resource is `http://ieee.org`, its new link is `http://proxy.bibliotheques.uqam.ca/login?url=http://ieee.org`.

*Shibboleth* is a federated identity management system that uses an authentication method based on the Security Assertion Markup Language (SAML) standard. If different applications or Web services use the same authentication method via Shibboleth, they just need to logon once and other applications will benefit from this logon information (i.e. single sign-on) (See [http://shibboleth.net](http://shibboleth.net/) and [http://www.moodle.uqam.ca/docs/index.php/shibboleth](http://www.moodle.uqam.ca/docs/index.php/shibboleth)). The Shibboleth service is becoming more and more a standard and accepted authentication method for institutions and libraries (See [http://www.canarie.ca/en/caf/participants](http://www.canarie.ca/en/caf/participants)) that provide controlled access to e-resources, and vendors such as IEEE, ScienceDirect, and ProQuest have Shibboleth implementations as well. \[[1](https://journal.code4lib.org/articles/#note1)\]

In this article, we define the term *“shibboletized”* to mean an action taken that makes an application provide authentication via Shibboleth.

*Exlibris’ X-Server Aleph* is a restricted web service developed by ExLibris. This service accesses the Aleph system that manages confidential library patron data.

## Background

In 2003, the Information Technology Team (ITT) of the University of Quebec at Montreal’s (UQAM) Library Service implemented its first proxy server running with the Squid application. There are around 800 requests daily for access to e-resources that are controlled by a proxy. This number can increase to up to 1500 requests at peak sessions. In 2009, the Computers and Telecommunications Service Team of UQAM (SITEL – Service de l’Informatique et des Télécommunications) shibboletized its first application, the e-learning Moodle platform (See [http://moodle.uqam.ca](http://moodle.uqam.ca/)).

In 2010, ITT shibboletized its Primo Discovery Tool [http://virtuose.uqam.ca](http://virtuose.uqam.ca/) and subsequently the library’s website [http://bibliotheques.uqam.ca](http://bibliotheques.uqam.ca/).

In 2011, SITEL shibboletized the UQAM human resources’ website [http://www.rhu.uqam.ca](http://www.rhu.uqam.ca/). At the end of this year, ITT shibboletized the proxy service.

## Challenge

There is actually no way to use the Shibboleth service as a provider of access control with a Squid proxy application unless we develop a new Squid-Shibboleth application. This represents a substantial development cost for our service. So we needed to find a solution at a lower cost that would at the same time offer better service, improve user experience, and remain transparent. Squid has been in use for over eight years at UQAM. Both EZproxy and Squid have their own advantages, and we wanted to see if we could combine these. The advantage of Squid is its ease of use when it’s configured correctly. Moreover, there is no need to provide an explicit reference to the proxy in the URL for Squid. In other words, one can click on any URL on the Web and still get redirected to the proxy. On the other hand, EZproxy can trigger Shibboleth functionality; there is no need to configure the browser client. A disadvantage of EZproxy is that the URL needs to be rewritten to point to the EZproxy server.

After some consideration, we decided to keep Squid’s workflow on our server, add EZproxy to it, and allow both services to be used with Shibboleth. This decision brings us to a challenge whose technological implementation must satisfy certain constraints:

1. Preserving the habits of users, i.e. continue to use Squid’s workflow with a PAC file
2. Enabling Shibboleth within EZproxy.
3. Avoid the development of complex source code as much as possible.
4. Providing portability to facilitate the evolution of the product.
5. Be prepared to deploy our single sign on functionality when all vendor e-resources have been shibboletized.

The hybrid solution integrates all three applications — Shibboleth Service Provider, EZproxy and Squid — on the same server. Obviously, to make this solution work, we needed to make Squid and EZproxy communicate with each other. Important questions raised are:

- How to achieve this communication between Squid and EZproxy at a lower cost?
- How to activate Shibboleth within Squid without changing its source code?
- How to redirect the domain proxied from the PAC file to the EZproxy service instead of the Squid service without changing the habits of end users?

This communication between the two services aims to take the outgoing data of Squid, transform it to EZproxy’s format, and then provide it as input for EZproxy. Because EZproxy can invoke Shibboleth, if the Squid information can be redirected to EZproxy, the job will be almost done. The technical solution required will be to translate all those tasks into a computer program; in this case, we’re using php scripting.

Another challenge is that we have to add the EZproxy prefix link (i.e. `http://proxy.bibliotheques.uqam.ca:2048`) to all our Aleph bibliographic records that contain links to e-resources. We have presently some 98,598 records for e-resources. This is a precise global modification that must be made in a database containing over 1 million records. This addition will allow users who do not want to add the PAC file to continue to access e-resources through our Primo discovery tool, Virtuose [http://virtuose.uqam.ca](http://virtuose.uqam.ca/). This work was done in August 2012 at the time we were writing this article.

## Methodology

To achieve our solution, we have chosen for the system architecture of the proxy server a Linux Cent/OS with Squid, EZproxy, Shibboleth Service Provider (SP), Apache 2.2.3 and with PHP for the programming scripts. As for the security of our servers, we use an approved Wildcard SSL certificate.

There are three separate physical servers: (1) one Shibboleth Identity Provider (IDP), (2) one proxy server for Squid, EZproxy, Apache, and Shibboleth Service Provider (SP), and (3) one server for Exlibris’ Aleph X-Server service.

To create our computer program, we first have to collect the log data (e.g. some 300 URLs of suppliers) from Squid, EZproxy, Shibboleth, and Apache to build a corpus of data. It helps us to analyze different ways URLs are transmitted from Squid to EZproxy. We start by separately running Squid first, then EZproxy without Shibboleth, and finally EZproxy with Shibboleth. We examined the log data file of each service to retrieve the URL syntax through each proxy server. The result of the analysis of log data file indicates where to intercept the information for the reprocessing and redirecting from and to the appropriate service. Following this analysis, we compare the various features offered by EZproxy and Squid then, from these differences, write a scripting code that can exchange information between these two proxy server implementations.

After several empirical tests, we found that Apache error’s script can be used for the exchange information between these servers. We will see this detail in the following sections.

### Operation with Squid proxy service without Shibboleth

Prior to the implementation of the EZproxy/Squid combination described in this paper, the Information Technology Team (ITT) Library Service at UQAM provided the Squid software that is used principally to validate the identity of UQAM’s users. The user must first authenticate and be authorized before access is permitted to the requested e-resource. Authentication is against LDAP – Lightweight Directory Access Protocol – while the authorization is provided by Exlibris’ Aleph X-Server, a restricted web service that accesses the confidential library patron data stored in the Aleph system. One of the elements of this confidential information is the status of users (i.e undergraduate student, graduate, professor, employee, etc.) and their expiry date. For example, a visiting student may be able to use the library loan services but may not access restricted e-resources.

[![](https://journal.code4lib.org/wp-content/uploads/2012/09/p7470-figure1-300x194.png "p7470-figure1")](https://journal.code4lib.org/wp-content/uploads/2012/09/p7470-figure1.png)

**Figure 1.** Squid proxy workflow in production until December 2011.

Figure 1 describes a workflow of a URL request using the Squid proxy. To use the Squid, the URL request should be primarily declared in a PAC file. This file is added to the browser’s proxy settings. Here is a sample extract of the proxy auto-configuration file format:

| 1  2  3  4  5  6  7  8  9  10 | `function` `FindProxyForURL(url, host)`  `{`  `if` `(`  `dnsDomainIs(host, ``"ejournals.ebsco.com"``) \|\|`  `dnsDomainIs(host, ``"ejournals.library.ualberta.ca"``) \|\|`  `dnsDomainIs(host, ``"search.proquest.com"``)`  `return` `"PROXY 12.345.67.89:3128"``;`  `else`  `return` `"DIRECT"``;`  `}` |
| --- | --- | --- | --- | --- | --- |

The user enters a URL request (1) such as http://search.proquest.com. When the PAC file is turned on, the browser executes the FindProxyForURL() function (2) that will call the proxy server or go direct to e-resources. If the domain request is not in the PAC file, the browser goes directly to e-resources without authentication (3) (i.e. return “DIRECT”) and the e-resource is then displayed. Otherwise, the FindProxyForURL() function calls Squid proxy (i.e. return “PROXY 12.345.67.89:3128). The Squid proxy invokes LDAP (4) for authentication (5 and 5 ‘). The user is prompted to enter his ID and password (5”) which is validated against the Active Directory (6). After the return of authentication (6’), Squid calls the X-server (7) to validate the authorization of the user. It is at this point that his status and expiration date will be checked (e.g. a graduate can borrow materials but no longer has the right to access online resources). We also see in this last step that the Squid service, after confirming the authorization (7’’), is unable to alert the user if he or she is not authorized to access the resource (e.g. *you do not have the right to refer to this resource*). This is due to the Squid’s script running in the background on the proxy server. This is a significant functionality gap of Squid, whereas with EZproxy we can interact with the user by providing informative messages. Moreover, we can also customize the web pages and informational messages sent by EZproxy. We’ll see how this is possible in the next section.

### Operation of the proxy server with Squid/EZproxy and Shibboleth

In this hybrid solution, the PAC file has been modified so that the Squid output Data feeds into Apache (port 3128 in the previous model is replaced by port 80).

| 1  2  3  4  5  6  7  8  9  10 | `function` `FindProxyForURL(url, host)`  `{`  `if` `(`  `dnsDomainIs(host, ``"ejournals.ebsco.com"``) \|\|`  `dnsDomainIs(host, ``"ejournals.library.ualberta.ca"``) \|\|`  `dnsDomainIs(host, ``"search.proquest.com"``)`  `return` `"PROXY 12.345.67.89:80"``;`  `else`  `return` `"DIRECT"``;`  `}` |
| --- | --- | --- | --- | --- | --- |

With this modification, Squid and Apache should be operating on the same port 80 at the same server. In fact, it is impossible to bind two processes on the same port on the same server. We stop the Squid process, but still activate and maintain the forwarding to port 80 in the PAC file, and then run the Apache and EZproxy services. Even though the Squid service is stopped, the redirection of URLs to the proxy server is always assumed by the PAC file and in this way is a part of the Squid’s workflow showed in figure 1. To this workflow we will add the EZproxy and Shibboleth services to achieve the hybrid solution.

When an URL request arrives on port 80, Apache will interpret and replace with the hostname of the proxy server as shown in the example below:

Original request comes from the user’s browser: `http://search.proquest.com/results/1366AB0876F332B6D17/1/$5bquery`

After Apache interprets and replaces: `http://proxy.bibliotheques.uqam.ca/results/1366AB0876F332B6D17/1/$5bquery`

Apache replaced the *search.proquest.com* by *proxy.bibliotheques.uqam.ca*. This URL, however, does not exist on our proxy server. Therefore, Apache returns an error code 404 (i.e. not found). The key to the solution is here. We must modify Apache’s 404 scripting file to correctly rewrite the link that contains the call to EZproxy: `http://proxy.bibliotheques.uqam.ca/login?url=http://search.proquest.com/results/1366AB0876F332B6D17/1/$5bquery`

Once EZproxy is called, all this is easily configurable at the EZproxy level without having to implement complex developments. To create an EZproxy session, we used the ‘Ticket’ method from among the three existing EZproxy methods: external-cgi method, local method, and ticket method. The choice of the ticket method is justified by its simplicity to implement, without being any less secure, and by its flexibility in being able to integrate customized codes such as calls to the Aleph X-Server and to Shibboleth.

[![](https://journal.code4lib.org/wp-content/uploads/2012/09/p7470-figure2-300x182.png "p7470-figure2")](https://journal.code4lib.org/wp-content/uploads/2012/09/p7470-figure2.png)

**Figure 2.** At present (December 2011) new hybrid proxy solution has been implemented.

Figure 2 shows a new method for validating users. As in Figure 1, when the user enters a URL request (1), if the URL request is not in the PAC file, the browser will be forwarded directly to the e-resource without authentication (3) (i.e. return “DIRECT”). Otherwise, this URL request is redirected to Apache on port 80. Apache rewrites the query using the 404.html scripting file (3’) and sends it to EZproxy. The EZproxy service calls the Shibboleth service (4), which is on another server. After logging in (5, 5’and 5’’), the EZproxy receives a reply with the validation of the user (6, 6′). If the user is properly authenticated, EZproxy will call the X-Server (7) to determine the authorization. After this last step, the e-resource may be permitted or prohibited depending on the result of X-server reply (7’). Note that EZproxy can issue informative messages to the user when access is refused (e.g. *your account has expired, please contact our loan service*).

For adding the EZproxy prefix link, we launched a single process in Aleph to update all 98,598 records of e-resources that must be proxied and we run a daily process that updates all new e-resources.

## Conclusion

With this new solution, we achieved our goal of deploying a Shibboleth-ready environment while granting our patrons reliable and stable access to e-resources via different types of connections.

## Future work

Although we chose EZproxy because it allows integration with Shibboleth, interaction with the user via informative feedback messages, and its easily customized interface that requires little development effort, there are other ways to set up a proxy such as the Apache reverse proxy module. We also intend to run EZproxy on ports 80 and 443 instead of 2048 and 2443. We will test this possibility in future work.

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] See [http://www.ieee.org/publications\_standards/publications/subscriptions/clientservices/info/faq\_clientservices.html](http://www.ieee.org/publications_standards/publications/subscriptions/clientservices/info/faq_clientservices.html), [http://www.info.sciverse.com/sciencedirect/implementation/quicktips/faq/shibboleth\_access](http://www.info.sciverse.com/sciencedirect/implementation/quicktips/faq/shibboleth_access), [http://www.proquest.com/en-US/aboutus/pressroom/09/20090209.shtml](http://www.proquest.com/en-US/aboutus/pressroom/09/20090209.shtml), [https://spaces.ais.ucla.edu/download/attachments/28082219/ShibTF-final-reportrev9202010.pdf?version=1&modificationDate=1285016932320](https://spaces.ais.ucla.edu/download/attachments/28082219/ShibTF-final-reportrev9202010.pdf?version=1&modificationDate=1285016932320).

Alexander Jerabek is a librarian in the Information Technology Services at UQAM Libraries. He has over 15 years experience in libraries and library systems. He maintains and develops the Primo discovery tool, and is partially responsible for Aleph, SFX, and MetaLib.

Minh-Quang Nguyen, Ph. D is a computer analyst for Information Technology Team of UQAM’s Library Service. He obtained his Ph. D. in Cognitive Computing in 2008 at UQAM. Researcher in Cognitive Computing, his research is based, from theory to experiment, on a cognitive approach in the field of Spoken Human-Machine Interaction.

## Acknowledgement

We would like to express our gratitude to all those people who helped us complete this work. First of all, Mr. Pierre Roberge, the Director of the Information Technology Team of UQAM’s Library Service, who always encourages and supports us, and gave us all the time and material necessary to complete this work. Mr. Pierre Nault, our ITT systems librarian, provided us with crucial information about the Aleph system and we thank him for his brilliant idea for how to optimize the request to the Aleph X-Server. He also was responsible for injecting the EZproxy prefix link into Aleph database. Also, many thanks to the members of SITEL, especially, a thought in memory for Daniel Pouliot, computer analyst, who spent almost all of his time for helping us to implement Shibboleth; he was the Shibboleth Guru at UQAM. And Mme Stéphanie Lanthier, computer analyst, who has spent much of her precious time setting up and configuring our Shibboleth environment.
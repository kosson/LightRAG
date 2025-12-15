---
title: "Alternative Solutions for Off-Campus Authentication"
source: "https://journal.code4lib.org/articles/73"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-06-23
created: 2025-01-10
description: "The Ohio State University Libraries created scripts to overcome the local limitations of the proxy server and to offer resource connections at the point of need. All libraries struggle to provide seamless authentication for access to paid resources, such as research databases and electronic journals. In order to obtain access to this content, the libraries [...]"
tags:
  - "clippings"
---
# Alternative Solutions for Off-Campus Authentication
Rebekah Kilzer, Elizabeth L. Black, James Muir

The Ohio State University Libraries created scripts to overcome the local limitations of the proxy server and to offer resource connections at the point of need. All libraries struggle to provide seamless authentication for access to paid resources, such as research databases and electronic journals. In order to obtain access to this content, the libraries must sign contracts promising to limit access to these resources to their user community. The challenge then comes in balancing the patron’s need for easy access to these rich data sources from any computer and the vendors’ desire to protect their assets.

## Background

Since the increase in the need for distributed access to library resources, libraries have been struggling with methods to provide seamless, intuitive access for people who are not at the physical library. Users expect to be able to do their work from anywhere, including being able to access library resources such as paid databases. Some libraries offer remote access via Internet Protocol (IP) authentication, but that alone does not address the needs of the people who are out of the organization's IP range (Blansit, 2007). The Ohio State University Libraries, like many libraries, have addressed this need by using a proxy server to act as an intermediary between the user and the database. Webster (2002) offers a clear definition of a proxy server, pointing out that a proxy server makes it appear as though users are working from valid IP addresses associated with the University, instead of off-site.

The literature exposes a variety of issues involved with offering off-site/off-campus access to paid resources via a proxy server. Mikesell (2004) offered a discussion on some of the weaknesses of proxy servers, which is useful in framing the various options. In order to authenticate users through the proxy server, libraries often employ one of a few methods. One method is to require users to sign into the proxy server before beginning their search, which is The Ohio State University Libraries’ current method. Some libraries create an "off-campus users" portal through which all off-campus users are required to enter before using paid library resources (Hudock, 2003) but this does not address the important goal of offering tools to the users at the point of need (Ferguson & Bunge, 1997). Another method is to include the proxy string in the resource URL, so the user is prompted to sign in when they click on the resource URL. This approach offers the most seamless access at the point of need, but can be an obstacle when there are thousands of resources that need to be sorted out, and access levels assigned, as was the case at OSU. The Ohio State University Libraries subscribe to 450 databases and have purchased several thousand additional resources. Because OSU is a public university, there is a mandate to offer certain resources without requiring affiliation with the University, adding an additional layer of complexity. In addition, the size of the library catalog database would have made the updating of records a protracted and labor intensive exercise, even with the automated tools available for use.

## Solution

The IT team began brainstorming and tested a promising idea of adding code to the catalog to act on URLs only when they are selected. After several iterations to account for the inability to put PHP into the library catalog’s local customization code and the existence of multiple URLs on a single catalog page, the final successful scripts combined JavaScript and PHP. The JavaScript code was placed in both the catalog and the Web site templates. When a user clicks a URL, the JavaScript calls a PHP file, which checks the IP of the user against a campus IP list. If the IP is on-campus, the user is passed to the URL selected. If the user is off-campus, the PHP code checks the MARC 945 field in the catalog record for an exception code. If the exception code is present, the user is passed on; if the code is not present, the user is sent to EZProxy and forwarded to Shibboleth to authenticate. Shibboleth is the authentication and authorization framework used at The Ohio State University. It is a suite of open source, standards-based solutions that enable the exchange of information about users in a secure manner (Internet2, 2008).

The exception code was a necessary element to the political success of this idea. OSU is a public, land grant institution and the Libraries house many unique materials of interest to the community beyond the university. Therefore, it was essential that we have a method of keeping access to the finding aids and enhanced descriptions linked from the catalog records open to those who would not have the required credentials to authenticate. Exception codes were added to items in special collections, the institutional repository and government documents selected for their likelihood to be accessed by non-OSU users. Due to the unique challenges of identifying all government documents in the catalog, we did not attempt to retroactively add the exception code for all records but the code will be added to records for all government documents acquired in the future. We also added a feedback feature to the login page so users can report issues, including items that should be made exceptions.

If a user has JavaScript turned off, the URL still works, but the logic of the IP check cannot be run. Therefore, if off-campus, the user must login to the proxy first before clicking links to paid resources or will be presented with a vendor login page. We decided to leave the off-campus sign-on link in the Web site global navigation to accommodate these users and those who were comfortable with the previous method.

Offering access to users at the point of need is essential in today’s library services environment. Implementing the combination of JavaScript and PHP code to support this access, while still accommodating the Libraries’ standards, has proven to be a solid asset for the Libraries.

## Code

There are four files available. [Download zip](https://journal.code4lib.org/media/issue3/kilzer/code.zip) (5.36 K).

**NOTE:** These files were designed for use with an Innovative catalog and the  
library Web site, separately, but could be adapted for other library systems.

- [offcampuscheck.js](https://journal.code4lib.org/media/issue3/kilzer/offcampuscheck.js) — This file should be included in the catalog template; it is recommended that it be included in the footer. It refers to URLs appearing in the catalog record.
- [offcampuscheck.php](https://journal.code4lib.org/media/issue3/kilzer/offcampuscheck.phps) — This is the PHP script that runs the check in the catalog pages and is referenced from the JavaScript above.
- [generic\_offcampuscheck.js](https://journal.code4lib.org/media/issue3/kilzer/generic_offcampuscheck.js) — This file should be included in non-catalog Web pages.
- [footer\_code.php](https://journal.code4lib.org/media/issue3/kilzer/footer_code.phps) — Insert this code in the bottom of your pages (we added it to our global footer file).

## References

Blansit, B. D. (2007). Beyond password protection: methods for remote patron authentication. Journal of Electronic Resources in Medical Libraries. 4 (1/2), 185-194.  
[(COinS)](https://journal.code4lib.org/coins)

Ferguson, C. D., & Bunge, C. A. (1997). The Shape of Services to Come: Values-Based Reference Service for the Largely Digital Library. College and Research Libraries. 58 (3), 252-266.  
[(COinS)](https://journal.code4lib.org/coins)  

Internet2, "About Shibboleth." [http://shibboleth.internet2.edu/about.html](http://shibboleth.internet2.edu/about.html) (accessed May 13, 2008).

Mikesell, B. L. (2003). Anything, anytime, anywhere: proxy servers, Shibboleth, and the dream of the digital library. Journal of Library Administration. 41 (1/2), 315-326.  
[(COinS)](https://journal.code4lib.org/coins)  

Webster, P. (2002). Remote patron validation: posting a proxy server at the DIGITAL doorway. Computers in Libraries, 22 (8), 18-23.  
[(COinS)](https://journal.code4lib.org/coins)  

## Acknowledgments

The authors wish to acknowledge Jason Thompson, the member of the IT team who had the original idea and without whom this project would never have happened.

**Rebekah Kilzer** is Systems Librarian and Assistant Professor at The Ohio State University Libraries. She is involved in several projects to enhance the discovery and delivery of library resources to patrons. Her email is kilzer.2@osu.edu.

**Elizabeth L. “Beth” Black**, is an Assistant Professor and Systems Librarian for the OSU Libraries. She leads the system’s Web Implementation Team, and is responsible for the Libraries’ web site, web applications and the university’s digital repository, Knowledge Bank. She can be reached by email at black.367@osu.edu.

**James Muir** is a Systems Developer/Engineer for The Ohio State University Libraries. He is involved with creating and maintaining many web applications for OSU Libraries. He can be reached by email at muir.29@osu.edu
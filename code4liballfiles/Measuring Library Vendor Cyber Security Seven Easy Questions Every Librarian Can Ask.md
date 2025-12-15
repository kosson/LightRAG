---
title: "Measuring Library Vendor Cyber Security: Seven Easy Questions Every Librarian Can Ask"
source: "https://journal.code4lib.org/articles/11413"
author:
  - "[[The Code4Lib Journal]]"
published: 2016-04-25
created: 2025-01-10
description: "This article is based on an independent cyber security risk management audit for a public library system completed by the authors in early 2015 and based on a research paper by the same group at Clark University in 2014. We stress that while cyber security must include raising public knowledge in regard to cyber security [...]"
tags:
  - "clippings"
---
# Measuring Library Vendor Cyber Security: Seven Easy Questions Every Librarian Can Ask
Alex Caro, Chris Markman

This article is based on an independent cyber security risk management audit for a public library system completed by the authors in early 2015 and based on a research paper by the same group at Clark University in 2014. We stress that while cyber security must include raising public knowledge in regard to cyber security issues and resources, and libraries are indeed the perfect place to disseminate this knowledge, librarians are also in a unique position as the gatekeepers of information services provided to the public and should conduct internal audits to ensure our content partners and IT vendors take cyber security as seriously as the library and its staff.

One way to do this is through periodic reviews of existing vendor relationships. To this end, the authors created a simple grading rubric you can adopt or modify to help take this first step towards securing your library data. It is intended to be used by both technical and non-technical staff as a simple measurement of what vendor agreements currently exist and how they rank, while at the same time providing a roadmap for which security features or policy statements the library can or should require moving forward.

## Introduction

Modern library systems are unique public institutions in terms of their physical information technology infrastructure (databases/servers, computer labs, public wifi), mission statement (intellectual freedom, data privacy) and codes of ethics. This combination of goals, contrasted with the 2001 USA PATRIOT Act and more recent information regarding widespread government surveillance of Internet traffic, creates a unique set of cybersecurity risks for libraries who make these promises to patrons \[[1](https://journal.code4lib.org/articles/#note1)\]. Moreover, the widespread use of single-factor authentication and increasing budget cuts to libraries due to recent economic downturns has all the markers of a “perfect storm” scenario for cyber criminals.

In 2015, as part of the Master of Science in Information Technology program at Clark University, Chris Markman (MSLIS) and Alex Caro (MPA) tested their research findings in an earlier course at Clark University related to IT risk management through a voluntary security audit of a public library, creating a Cyber Security Risk Management (CSRM) program aimed to address these issues. An overview of some of our findings were presented at the 2015 New England Technical Services Librarians annual spring conference in the form of a lightning talk, but the full details of this report remain confidential due to our agreement with the library. The CSRM program created was by no means comprehensive, but preliminary research indicated many library systems would benefit from a more formalized IT risk management program.

## Part 1 – The LibSec Assessment Framework

If this seems like a daunting task, don’t worry! There is no reason to “reinvent the wheel” in regard to CSRM—there are many ready-made frameworks that exist, and they are easy to adapt to your organizational needs. Typically, an external auditor is hired to complete this work and (hopefully) provide a level of objectivity in their findings, however many libraries may find this extra step is cost prohibitive. Thus, we saw the need to create risk management assessment frameworks that are both easy for the public to understand and easy for librarians to use. Following the work of librarian Eric Hellman who, in a series of blog posts about top journal vendor privacy policies, revealed that many did not meet expectations, \[[2](https://journal.code4lib.org/articles/#note2)\] we “reverse engineered“ the grading criteria he created in the form of the following rubric, and weighted the score of each category based on their overall impact on patron cyber security. We call it LibSec. A detailed description of each criterion, and how to use this framework, is outlined in the following section.

It’s important to note that the point value in this system is intentionally “fuzzy” because we recognize that no two libraries are alike, in the sense that certain criteria are relative to the population of people that use your library. For example, an urban academic legal law library may rate the legibility of a given vendor’s terms of service completely differently than a rural public library. In this mode of cyber security risk management, it’s important to not only consider the professional opinion of librarians, but also how patrons will interpret the same information. There is also a wide range of vendors or other organizations the library works with that could be part of this overall process, and in some cases entire categories can be eliminated because they do not apply. To put it another way, your mileage may vary. It’s also important to note that during the first round of this LibSec assessment process, it may take some time to locate this information, and it would be helpful to document not only how you determined compliance in a certain area (and provide a record) but also where it was located so that future assessments can be completed on a shorter time scale.

| Criteria | Brief Description | Point Value |
| --- | --- | --- |
| 1\. Data Breach Policy | Is there a formal process in place to report data breaches if/when they occur? | +/- 1 point |
| 2\. Data Encryption | If patron data is stored by the vendor, is it encrypted? | +/- 1 point |
| 3\. Data Retention | Does the vendor purge patron search history records on a regular basis? | +/- 1 point |
| 4\. TOS “Ease of Use” | Can the average patron read and fully understand the vendor’s terms of use policy? | +/- 1 points |
| 5\. Patron Privacy | Does the vendor use Google Analytics or other tracking software to monitor users? | +/- 1 points |
| 6\. Secure Connections | Does the vendor’s website enforce secure connections only? (HTTPS or better?) | +/- 1 points |
| 7\. Advertising Networks | Does the vendor’s website participate in ad networks? | +/- 6 points |

**Grade Scale:**

| A | Greater than or equal to 11 points |
| --- | --- |
| B | Greater than or equal to 10 points |
| C | Greater than or equal to 9 points |
| D | Greater than or equal to 7 points |
| F | Less than or equal to 6 points |

### 1\. Data Breach Policy

This is an interesting moment in time for libraries in the USA, because while some states have adopted data breach policy requirements, there is no federal mandate. So for example: let’s say for a moment that the service provider your library uses to stream audio content experiences a *known* security breach and they have reason to believe customer information (including patron borrowing history) was compromised by a cybercriminal \[[3](https://journal.code4lib.org/articles/#note3)\]. If the vendor does not have a data breach policy, they have not made the commitment to inform users of their system when an event like this occurs, and you cannot make an informed decision about the overall performance of their security practices because they have not stated they will voluntarily disclose this information. Vendors in this category receive +1 point if they have a data breach policy in place and it meets the criteria of the library, 0 points if no data breach policy is available, and -1 points if the data breach policy does not meet the library’s criteria.

### 2\. Data Encryption

The scary part about IT security is that we know no one is invincible—even three letter government organizations with monumental budgets experience security breaches. It isn’t so much a question of *if* your systems will be attacked, but *when* and *how*. Done properly, data encryption is a very simple step towards ensuring that in the event of a security breach, your patron information is not an easy target. One could argue that data encryption is pointless if patron data is anonymized \[[4](https://journal.code4lib.org/articles/#note4)\] but what we need to consider is the fact that very often this type of information is used by cybercriminals in aggregate form to aid in future attacks. Data encryption is a very simple step to take and a nod towards some form of cyber security oversight by your vendor. Similar to the first criteria, vendors receive +1 point for data encryption, zero points if this information is unknown or unclear, and -1 if you can confirm they do not encrypt user data.

### 3\. Data Retention

Many integrated library systems purge search history or user data automatically, but what about the systems they interact with? The point of this category is to make no assumptions—have you asked what their data retention policy is? Do they have one at all? What’s an acceptable answer for your institution? Vendors receive a +1 if the retention policy is acceptable to the library, zero points if this information is unknown, and -1 point if the retention policy is deemed unacceptable.

### 4\. TOS “Ease of Use”

“Terms of Service” (TOS) statements are typically written by lawyers, and are not only extremely difficult to understand, but frustrating to read due to their length. An unfortunate side effect of this is that many users simply click past them, without reading the fine print \[[5](https://journal.code4lib.org/articles/#note5)\]. It’s important for libraries to encourage users to read TOS statements because this empowers people to make informed decisions about how and when they want their personal information used. Some many not care, some may care a great deal, and some may care a lot more if they fully understood what information they were agreeing to hand over and how it could be used. Vendors receive a +1 if their TOS is easy to read, zero points if a TOS cannot be found, and -1 point if the TOS is difficult to read.

### 5\. Patron Privacy

This category is specifically about “click-tracking”, or background systems like Google Analytics that work invisibly on websites or web resources to collect statistical information about what pages are visited, for how long, and how they were located. *Many* websites use these tools, and their utility within library systems is an ongoing debate as we balance the needs of reliable metrics with patron privacy \[[6](https://journal.code4lib.org/articles/#note6)\]. The simple truth is that the most secure option is to disable these tools completely, or severely limit their use (perhaps stated in the vendor’s data retention policy, or terms of use). Vendors receive +1 point if they respect browsing privacy, 0 points if this tracking is deemed within reason (for example, results do not include IP address), and -1 point if their use of tracking is not acceptable.

### 6\. Secure Connections

All of the categories thus far have dealt with data “at rest”—information stored on hard drives or other media. In this category we’re asking you to evaluate data “in transit”, or en route to other computers (either library owned, or patron owned). It is laughably easy for even novice cybercriminals to detect unencrypted data passing through a network, and there are free software tools that do all of the work in that regard \[[7](https://journal.code4lib.org/articles/#note7)\]. Although secure connections are not the “final” solution to data security because protocols like HTTPS can be decrypted at the firewall level \[[8](https://journal.code4lib.org/articles/#note8)\], much like category 2, it’s a simple step to take \[[9](https://journal.code4lib.org/articles/#note9)\]. Vendors receive +1 point for forcing secure connections on their networks, zero points if this information is unknown, and -1 point if their connections are unencrypted / unsecured.

### 7\. Advertising Networks

The scary part about a vendor’s participation in or use of advertising networks is that you now need to consider not only your 3<sup>rd</sup> party vendor’s security infrastructure and its relationship to your library CSRM, but also their advertiser’s infrastructure. Also consider the fact that many ad networks re-sell their information to other advertisers, an action which you have no control over because they signed agreements with your vendor, not directly with you, the library. That is why this final criterion outweighs 1-6: participation in ad networks renders everything else moot if your vendor is doing the right things and then handing off the same patron data to an advertiser network with no relationship to the library or specific agreements about data retention or encryption. Not only that, but in recent years, cyber security attacks have actually been launched by cybercriminals *through* existing ad networks \[[10](https://journal.code4lib.org/articles/#note10)\]. We encourage you to use your best judgment in this category, because all ad networks are not alike, but ideally they’re not something you should need to consider at all. For this reason you can award +6 points for non-use of advertising networks, zero points if it is unclear, and up to -6 points depending on how advertisements are used.

## Part 2 – How to Use LibSec

Please understand the worksheet discussed in this article by itself is only an assessment framework, and should be considered only a small part of your library’s overall CSRM program. Educating users and library staff about cyber security through programs like the [Library Freedom Project](https://libraryfreedomproject.org/) is another key component, but neither solution by itself can solve the entire issue of protecting user and library data.

The true power of an assessment framework like LibSec is not just about filling out the forms once and calling it a day, but filling it out, finding which areas are unclear (perhaps the first round will include many “zero” scores) and asking your vendor questions that have never been asked before. A month or a year later, after collecting more data, repeat the same process by writing down all of the vendors your library has a relationship with, completing these forms once again, and comparing this “report card” with last year (or the year before).

## Conclusion

Cyber security risk management for libraries, and public libraries in particular, has gained recent attention though initiatives like the Library Freedom Project and other patron-oriented outreach services. At the same time, internal security audits, either performed in-house or through third party security contractors, can ensure library systems do not unintentionally leak personally identifiable information, but they are expensive and time consuming when completed by external auditors. The LibSec rating system, as described in this article, is a free way to track your library’s progress toward better cyber security practices through a close analysis of your vendor relationships and the patron generated data they have access to or consume. It requires no specialized knowledge beyond asking your vendors the right set of questions, and evaluating their services within the context of your library.

## Sample Worksheet 1 – ILS Vendor

The following example vendor receives a "B" in this system. To get an A, they will need to either make their data breach policy public or clean up their TOS to be more user friendly.

| Criteria | Point Value | Rational |
| --- | --- | --- |
| Data Breach Policy | 0 | Not available / unknown at this time |
| Data Encryption | +1 | Data is encrypted |
| Data Retention | +1 | Search history is purged regularly |
| TOS “Ease of Use” | 0 | Neutral score. Somewhat difficult to read, and very long but easy to find. |
| Patron Privacy | +1 | Tracking is not used |
| Secure Connections | +1 | HTTPS enabled |
| Advertising Networks | +6 | Website does not use ads |
| **Total Points** | **10 (B)** |  |

## Sample Worksheet 2 – Social Media “Site X”

The following fictional example of a social media service receives an "F" under this rating system, a gentle reminder that libraries should consider how their use of social media adds or subtracts to patron cyber security. As a corrective measure, this could be seen as an opportunity to educate the general public about safe surfing on the net.

| Criteria | Point Value | Rational |
| --- | --- | --- |
| Data Breach Policy | +1 | Policy is public. |
| Data Encryption | +1 | Data is encrypted |
| Data Retention | \-1 | Search history is always active. |
| TOS “Ease of Use” | 0 | Neutral score. Somewhat difficult to read, and very long but easy to find. |
| Patron Privacy | 0 | Page views are tracked in aggregate but not directly linked to accounts, however associated third party apps or services used on the site may pose additional privacy risks. |
| Secure Connections | +1 | HTTPS enabled |
| Advertisings Networks | \-6 | All traffic heavily monitored. |
| **Total Points** | **\-4 (F)** |  |

## About the Authors

Alex Caro is a graduate student at the University of Sussex studying Science and Technology Policy. He previously attended Clark University in Worcester, Massachusetts and has worked on technology policy issues for the City of Cambridge and the MIT Washington Office. He tweets at [@alexcarooo](https://twitter.com/alexcarooo).

Chris Markman ([@akamarkman](https://twitter.com/akamarkman)) has been blogging about technology since 2008, first as a volunteer for the Participatory Culture Foundation and later as an MSLIS student at Simmons College and MSIT student at Clark University. Prior to joining the Academic Technology Services team at Clark University in 2014, he managed a film and music library in the Visual and Performing Arts department.

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] For a well researched overview of internet privacy efforts in the UK and US in relation to libraries in the “post-Snowden era” see Ian Clark’s 2016 article in the Journal of Radical Librarianship: [https://journal.radicallibrarianship.org/index.php/journal/article/view/12](https://journal.radicallibrarianship.org/index.php/journal/article/view/12)

\[[2](https://journal.code4lib.org/articles/#ref2)\] “16 of the top 20 Research Journals Let Ad Networks Spy on Their Readers” [http://go-to-hellman.blogspot.com/2015/03/16-of-top-20-research-journals-let-ad.html](http://go-to-hellman.blogspot.com/2015/03/16-of-top-20-research-journals-let-ad.html)

\[[3](https://journal.code4lib.org/articles/#ref3)\] We will refrain from the term “hacker”, which has multiple meanings. For the purpose of this article, please consider a “cybercriminal” to be a person intending to cause harm to the library.

\[[4](https://journal.code4lib.org/articles/#ref4)\] In the sense that it does not include personally identifiable information (PII) which could be used to aid identity theft or other cybercrimes.

\[[5](https://journal.code4lib.org/articles/#ref5)\] For an interesting take on this problem, check out the “Terms of Service; Didn’t Read” project [https://tosdr.org/](https://tosdr.org/)

\[[6](https://journal.code4lib.org/articles/#ref6)\] It’s important to note here that tracking codes can play a critical role in the web development process and can be used “for good”—we’re not suggesting they should never be used. Instead, ask *how* it is being used and evaluate the *context* before making your decision.

\[[7](https://journal.code4lib.org/articles/#ref7)\] Wireshark is just one example. There are literally thousands of tutorials online that explain how to use it. For a quick demo watch this 7 minute YouTube Video “HakTip – How to Capture Packets with Wireshark – Getting Started” [https://www.youtube.com/watch?v=6X5TwvGXHP0](https://www.youtube.com/watch?v=6X5TwvGXHP0)

\[[8](https://journal.code4lib.org/articles/#ref8)\] See [http://www.networkworld.com/article/2161439/network-security/ssl-decryption-may-be-needed-for-security-reasons–but-employees-are-likely-to–fre.html](http://www.networkworld.com/article/2161439/network-security/ssl-decryption-may-be-needed-for-security-reasons--but-employees-are-likely-to--fre.html) This is a common feature in most “next generation firewalls” [https://en.wikipedia.org/wiki/Next-Generation\_Firewall](https://en.wikipedia.org/wiki/Next-Generation_Firewall)

\[[9](https://journal.code4lib.org/articles/#ref9)\] Which promises to become even easier to set up, following the public beta of the “Let’s Encrypt” SSL certificate platform @ [https://letsencrypt.org/](https://letsencrypt.org/)

\[[10](https://journal.code4lib.org/articles/#ref10)\] Yahoo.com provides just one recent example, wherein attackers hijacked their ad network for a period of time and were able to spread “malware” to thousands of users: [http://thehill.com/policy/cybersecurity/250171-hackers-hijack-yahoos-ad-network-for-a-full-week](http://thehill.com/policy/cybersecurity/250171-hackers-hijack-yahoos-ad-network-for-a-full-week)
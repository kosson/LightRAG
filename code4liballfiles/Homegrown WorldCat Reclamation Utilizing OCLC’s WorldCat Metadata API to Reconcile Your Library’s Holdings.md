---
title: "Homegrown WorldCat Reclamation: Utilizing OCLC’s WorldCat Metadata API to Reconcile Your Library’s Holdings"
source: "https://journal.code4lib.org/articles/10328"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-01-21
created: 2025-01-10
description: "OCLC’s WorldCat Metadata API now allows libraries to set and delete their OCLC holdings without using Connexion or Batch Services. St. Olaf College Libraries had used up our “one free turn” at a reclamation several years ago. Unfortunately due to the normal inconsistencies that accumulate over time, as well as problems with holdings being set [...]"
tags:
  - "clippings"
---
# Homegrown WorldCat Reclamation: Utilizing OCLC’s WorldCat Metadata API to Reconcile Your Library’s Holdings
Sarah Johnston

OCLC’s WorldCat Metadata API now allows libraries to set and delete their OCLC holdings without using Connexion or Batch Services. St. Olaf College Libraries had used up our “one free turn” at a reclamation several years ago. Unfortunately due to the normal inconsistencies that accumulate over time, as well as problems with holdings being set for us by external entities, we had reached a point where we were once again in need of reconciling our holdings with OCLC’s. This time we wanted to accomplish the reclamation in a low-cost way that would also allow us to have more local control over the process. Using the WorldCat Search API and Metadata API in tandem, we first retrieved all OCLC numbers with holdings currently set and deleted these holdings with a fairly simple Perl script. We then pulled from our local catalog all the OCLC numbers for which we wanted holdings set and updated again using the Metadata API. The result, in the words of one of our catalogers, is that “For the first time since I got here, 15 years ago, I feel our holdings finally reflect what we really own.” In this article, I will discuss the issues to consider if you wish to do a similar project with your OCLC holdings, share the Perl scripts I wrote for processing, and reflect on the pros and cons of the process overall.

## Background

Maintaining holdings in OCLC over the course of 30 years is bound to lead to inconsistencies between a library’s catalog and the holdings represented in WorldCat. The problem is common enough that OCLC has long offered a service called [Reclamation](https://oclc.org/content/dam/support/batchload/documentation/using/bibbatchsolutions.pdf) (now grouped with similar services as Batchload). The basic process for doing a Reclamation project is:

1. Create a list for OCLC of all the OCLC numbers in your local catalog for which you wish to have holdings set.
2. OCLC runs this file against the WorldCat database and sets all matches with a current timestamp.
3. Reports are generated of (A) OCLC numbers from the local catalog that had no holdings match in WorldCat and (B) OCLC numbers for which your institution had WorldCat holdings set but no number was included in the file from the local catalog.
4. You tell OCLC whether you want to set holdings for report A and/or delete holdings for report B.

OCLC will do a reclamation project for free one time; subsequently you incur charges for going through this process.  A quote for a reclamation project can be requested through [OCLC’s Online Service Center.](http://www.oclc.org/en-US/servicecenter.html)

At St. Olaf College, we had attempted a reclamation project in 2009-2010. At that time, we ran into problems particularly with report A (although it impacted the report B). Because we didn’t subscribe to the [Bibliographic Record Notification service](http://www.oclc.org/support/services/bibliographic-notification/faq.en.html), we had many outdated OCLC numbers in our catalog (when an OCLC record is merged with another, the old number(s) is stored in the 019). We received an “xref” report but the actual processing didn’t update the holdings on these records. We were uncomfortable moving ahead with the project when so many of our records had no matches in WorldCat and there were so many potential deletes because of OCLC record merges.

Over the past two years, we noticed more and more interlibrary loan requests coming in for things we did not own. We were also having problems with some of our e-resource vendors setting holdings for us on collections we had not acquired. We knew it was time to tackle the Reclamation again, but we had used up our “free turn” and we wanted to have more control over the process. OCLC Web Services came to our rescue.

## OCLC Web Services

Before we dive into the specifics of our project, a few words about OCLC’s web services platform might be helpful to those that have not used it yet. Each API has different requirements for its use, as well as terms of use. The Metadata API is available to any institution with a Cataloging and FirstSearch subscription. The first step is to obtain a WSKey, which can be requested through the [OCLC Service Configuration](https://platform.worldcat.org/wskey/) interface. You can also request a key specifically for their sandbox, which is a great help in testing and viewing responses. The Metadata API also requires attribution to a WorldShare user (used in the authentication process as the principal ID). When you request access to the Metadata API, you will also receive this authorization in your email confirmation.

## Considerations Before You Start

If you plan to remove all your OCLC holdings before adding holdings (which is the process I will outline in this article), consider when the optimum time to do this might be, as it will affect patrons and library staff searching WorldCat during the project. We had hoped to do our project during the summer when, as an academic library, we have the lowest use of WorldCat. For reasons I discuss in more detail below, the project was pushed to September, but because of other timing constraints we chose to move forward while making sure the rest of the staff was well aware of the temporary impact on WorldCat.

There will also be an impact on interlibrary loan, particularly if you and your primary borrowers use ILLiad. We made sure our ILL staff knew that they should check our local catalog before sending ILL requests rather than relying on ILLiad (which in turn relies on WorldCat holdings).

Finally, it is important that anyone who adds holdings for your institution stop during the project lest their additions and deletions be overwritten. We kept a good record of the “gap” holdings: depending on your local system and practices, this may be as easy as running a query at the end of the project for all items added or deleted during the process, or as difficult as writing down every OCLC number for items added or deleted during the project.

## Deleting the Holdings

Because OCLC does not offer a way to query when a holding was set, it is necessary to delete all your holdings before starting the resetting process (otherwise you would have no way of finding the holdings that no longer matched records in your local system).  For the deletion phase of our project, we used two APIs: Metadata and Search. We wanted to delete all holdings except items that had an LHR (local holdings record).  We had about 7000 records with LHRs, all serials.  As a trial run, I created a Perl script to send an HTTP request (to the Metadata API) sequentially for all OCLC numbers, starting at 1. We quickly ran into two issues with this approach: it would take forever (months) to run through all billion + OCLC numbers, and it overloaded the logs on OCLC’s servers. We decided to pause the project at that point and rethink our approach. OCLC was very responsive to the project and worked to improve their logging capabilities. After about a month, we received word from OCLC that we could proceed with no limit on the number of HTTP requests sent per day.

As OCLC was working on this, I was considering other approaches. Prior to beginning the project, we had asked OCLC if it would be possible to get a file of all OCLC numbers on which our holdings were currently set. Unfortunately that wasn’t possible at the time.  Since we completed our project, OCLC has developed a way to create this data file using their Collection Manager product.  This is a new process for which OCLC is currently creating documentation, which should be available soon. Casting about for another way to get a smaller set of OCLC numbers to work from, rather than the enitre universe of OCLC numbers, I started playing with the OCLC Search API. This web service is designed for incorporating WorldCat results into a discovery service, but since it returns the OCLC number and allows you to limit by holdings symbol, I thought that with a broad enough search I might be able to use it to pull back the majority of our holdings, and from there we would be able to finish the delete processing in Connexion.

The [Search API](http://www.oclc.org/developer/develop/web-services/worldcat-search-api.en.html) returns 10,000 hits in 100 record increments. My script saved each XML file separately, then used XPath to locate and extract the OCLC numbers from each file into a text file. Once this was completed for the set of 10,000, the script began sending the numbers to the Metadata API, using the HTTP DELETE method. OCLC has excellent documentation on the [Metadata API](http://oclc.org/developer/develop/web-services/worldcat-metadata-api.en.html), and I won’t go into great detail here about how to set up the HTTP requests. My script should give you a good idea of how we utilized the API with Perl \[[https://github.com/SarahZum/reclamation.git](https://github.com/SarahZum/reclamation.git)\].

Note that OCLC has recently added a new authentication method to the Metadata API. I used the [WSKey HMAC Signature](http://www.oclc.org/developer/develop/authentication/hmac-signature.en.html).   You can now also use the [Access Token method](http://www.oclc.org/developer/develop/authentication/access-tokens.en.html).  The benefit of this method is that you don’t have to hash every request; the access token is set to expire after 20 minutes, although, if you are considering a similar project, OCLC will extend that expiration period for you on a temporary basis to increase efficiency even more. If you are interested in doing this, contact [devnet@oclc.org](https://journal.code4lib.org/articles/). Their only caveat is that you inform them when the project is complete so the WSKey can be reset to issue shorter lived tokens.

The delete processing took us about 1 week to complete for approximately half a million holdings.  This approach had its drawbacks:

- Because we were using the Search API for a purpose it was not designed for, we had to do some “creative” keyword searching to return records with our holdings. You cannot simply send a “limiter” search like OCLC holding symbol without including a non-limiter index search \[[http://www.oclc.org/developer/develop/web-services/worldcat-search-api/bibliographic-resource.en.html](http://www.oclc.org/developer/develop/web-services/worldcat-search-api/bibliographic-resource.en.html)\].
- The Search API returns the full record in MARCXML or Dublin Core.  We chose to save and process full MARCXML records in order to grab the OCLC number for each one, which was time and processor intensive.
- In the end it did prove impossible to return all our records this way. We had to do the final deletes in Connexion, using a combination of our holding symbol and material type (a combination not allowed in the Search API–see above).

In retrospect, I would have approached this part of the project as follows:

1. Exported all numbers in the 001 and 019 fields from our local system (we use III Millennium currently) into a text file.
2. Looped through that file sending each as a DELETE request to the Metadata API.
3. Used Connexion and/or the Search API (depending on how many records were left) to catch any remaining records with our holdings set.

The Metadata API handles old OCLC numbers well: it finds the current record and deletes your holdings, so including the old OCLC numbers in the 019 might be overkill, but in my opinion it might find some things where you have an incorrect number in the 001 (or wherever you store the current OCLC number on your local system) and save you some work later on.

[![Figure 1](https://journal.code4lib.org/media/issue27/johnson/figure1.png)](https://journal.code4lib.org/media/issue27/johnson/figure1.png)

**Figure 1.**Search results for our holdings symbol in FirstSearch when the delete processing was complete

## Restoring the Holdings

As thrilling as it is to see your OCLC holdings dwindle to almost zero, the time comes to start adding those holdings back to the WorldCat database. The key intellectual work at this stage is deciding which records in your local system should have holdings set. This is a perfect opportunity to consider discovery in WorldCat and anywhere else you may want to draw from WorldCat data. What items do you want library patrons to find? Just as importantly, are there things you *don’t* want patrons to know you have, particularly those patrons that would use WorldCat to view your collections? At my college, we were concerned that some of the items in our special collections that we did not wish to advertise (since we have very restricted access to them) had holdings set.  We have also decided not to set holdings on electronic resources, primarily because we wanted to be able to track those “mystery” holdings that were popping up from vendors for collections we had not purchased.

In the end, we used the following criteria in our local system:

- OCLC number in the 001
- Not suppressed (publicly viewable in our local catalog)
- Not electronic-only (available in a physical format)

We exported the OCLC numbers from all records that met this criteria. We then used the holdings\_add Perl script \[[https://github.com/SarahZum/reclamation.git](https://github.com/SarahZum/reclamation.git)\] to send an HTTP POST request to set the holdings for each number, looping through the text file until the process was complete. This processing went a bit more quickly than the delete process, finishing in just under 1 week.

## **Results**

In raw numbers, we had about 520,000 records with holdings set prior to beginning the project. Once the reloading process was complete, we had about 480,000 records with holdings set.  A not insubstantial difference! During both the delete and set phases of the project, I kept logs of each response. I have not had a chance to analyze the logs yet to see if they can tell me anything about the overall accuracy of our holdings pre- and post- project, but anecdotally we’ve noted some positive trends:

- We’ve had a few interlibrary loan requests come in for items that we couldn’t find in our local catalog, however they have all been attributable to a recently weeded item (we delete holdings in OCLC for weeded materials once per week) or the vagaries of serials in both our local catalog and our LHR statements in WorldCat. We have an ongoing project to clean up materials with LHRs so we hope to resolve some of this confusion soon.
- Since we decided not to add holdings for anything we hold solely electronically, we have also been able to monitor electronic resources and make sure that those “phantom” holdings are not popping up again.

We hope to repeat this process again next summer, using some of the improvements I’ve noted in the article above.  We’d like to do a more sophisticated analysis of the accuracy of the OCLC numbers in our records, perhaps using the [xID API](http://www.oclc.org/developer/develop/web-services/xid-api.en.html) to compare other identifiers in our records.

We feel much more secure in the links between WorldCat and our local catalog. This is a huge benefit to anyone searching the WorldCat database of course, but also important to interlibrary loan, collection development (we use OCLC’s Collection Analysis program), and the many future uses we’d like to make of resources like the new WorldCat Discovery API. 

*Many thanks to Anna Sylvester, Joe Abrams, and John Chapman at OCLC for their technical assistance with our project.*  *Also thanks to Karen Coombs and Shelley Hostetler for additional information about OCLC’s Web Services provided for this article.*

## References

WorldCat Search API: [http://www.oclc.org/developer/develop/web-services/worldcat-search-api.en.html](http://www.oclc.org/developer/develop/web-services/worldcat-search-api.en.html)

WorldCat Metadata API: [http://oclc.org/developer/develop/web-services/worldcat-metadata-api.en.html](http://oclc.org/developer/develop/web-services/worldcat-metadata-api.en.html)

## About the Author

Sarah Johnston is the Systems & Web Services Librarian at St. Olaf College in Northfield, MN.  She is currently chairing the group that will select the next library management system for St. Olaf and Carleton College.  She loves data cleanup, but only if it can be automated!   Her website is at [http://sarahjohnston.info/](http://sarahjohnston.info/) .
---
title: "Getting What We Paid for: a Script to Verify Full Access to E-Resources"
source: "https://journal.code4lib.org/articles/9684"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-07-21
created: 2025-01-10
description: "Libraries regularly pay for packages of e-resources containing hundreds to thousands of individual titles. Ideally, library patrons could access the full content of all titles in such packages. In reality, library staff and patrons inevitably stumble across inaccessible titles, but no library has the resources to manually verify full access to all titles, and basic [...]"
tags:
  - "clippings"
---
# Getting What We Paid for: a Script to Verify Full Access to E-Resources
Kristina M. Spurgin

Libraries regularly pay for packages of e-resources containing hundreds to thousands of individual titles. Ideally, library patrons could access the full content of all titles in such packages. In reality, library staff and patrons inevitably stumble across inaccessible titles, but no library has the resources to manually verify full access to all titles, and basic URL checkers cannot check for access. This article describes the E-Resource Access Checker—a script that automates the verification of full access. With the Access Checker, library staff can identify all inaccessible titles in a package and bring these problems to content providers’ attention to ensure we get what we pay for.

## Introduction

Libraries have historically exerted significant control over their print (and other tangible format) collections. Traditionally, libraries have had print workflows involving

- checking in the individual physical items purchased to ensure all ordered materials were received;
- cataloging each item to provide intellectual access to the material via the library catalog;
- physical processing (affixing spine labels, barcodes, security devices) to prepare the material for library use; \[[1](https://journal.code4lib.org/articles/#note1)\] and
- shelving each item somewhere in the library to provide physical access to the material.

Our workflows for processing electronic (e-) resources tend in part to mirror the ones we use for processing print, but the scales are vastly different. Most libraries that provide access to e-resources obtain many of them by purchasing or subscribing to e-resource packages. Each package may contain hundreds (and sometimes hundreds of thousands) of titles—the individual e-books, online journals, streaming media, online datasets, and other electronic resources we hope our patrons want. \[[2](https://journal.code4lib.org/articles/#note2)\] When purchasing or subscribing to e-resource packages, libraries cede much of their traditional control to content providers, mainly due to the size of e-resources packages and the growing need for libraries to do more with less.

To give a sense of the scale we are talking about, here is a snapshot of what we are dealing with at my library. As the E-Resources Cataloger at the University of North Carolina at Chapel Hill Libraries, \[[3](https://journal.code4lib.org/articles/#note3)\] I keep track of about 700 separate e-resources packages. \[[4](https://journal.code4lib.org/articles/#note4)\] These packages were represented by about 1,250,000 records in our catalog in our last yearly catalog record count-by-package, conducted in July, 2013. The smallest packages had only two associated records; the largest package had 312,464. In the first four months of 2014, I loaded 112 separate batches of catalog records for 36 different packages of e-books, e-journals, streaming media, and web resources—a total of 102,252 new catalog records added. This means my two-person section has been responsible for acquiring, checking, batch editing, and adding to our catalog over 25,000 MARC records per month on average this year.

Smaller libraries may have smaller numbers of e-resources to handle, but they will also likely have fewer people to work on e-resources management. Perhaps one person will be tasked with handling the purchasing, licensing, cataloging, and troubleshooting of e-resources on top of other job duties. In no library does anyone have the ability to manage e-resource packages at the individual title level. And yet, our patrons are looking for those specific titles relevant to their needs and interests.

### Workflows for processing electronic resources

Checking in the contents of an e-resource package entails verifying the receipt of every individual title included in the package based on a title list made available by the content provider. In the context of e-resources, “to receive” a title means that the content provider has given us—and our patrons—full access to the online content of that title: we can read the whole book, watch the entire film, etc. Unlike with print resources, we cannot manually check that we have “received” each of hundreds or thousands of titles included in a package. Usually we look at a few of the titles we know are part of a package to verify that the provider has activated our access to that package and then move on. We trust that the content provider is indeed giving us full access to all the titles we have paid for.

Providing intellectual access to the contents of e-resources packages still happens via the library catalog. \[[5](https://journal.code4lib.org/articles/#note5)\] We typically rely on content-providers or other 3rd party vendors to provide batch-files of catalog metadata for the individual contents of e-resource packages. Usually we deal with multiple batches of metadata for a given package as metadata are gradually created and/or new titles are added to a package. Unlike with print materials, we do not have the resources to compare each metadata record with the item it describes. We trust that we will eventually receive records for all of the titles included in a package and that we are not receiving records for titles our patrons won’t be able to access.

Shelving e-resources obviously does not happen literally, but we do rely on content providers to host the individual titles within packages so they are accessible to our patrons. The content providers maintain the shelves, as it were. We trust they will arrange the titles in some sensible manner and maintain consistent arrangement of those titles. Whatever link resolving and redirecting content providers implement, we trust that the URLs we are given in title lists and metadata records will continue to point our patrons to the full content of titles, much as call numbers point patrons to specific books on shelves.

### Finding e-resource access problems

The scale at which libraries routinely purchase e-resource packages and the very nature of electronic resources require that we shift much of the responsibility for processing resources onto content providers. This also largely precludes us from checking over the results as thoroughly as we do with print resources. For our own sanity, we often have to assume that content providers have processed things correctly and that the resources we’re paying for work. However, we know from experience that this is not always the case. Sometimes we stumble over problems ourselves; other times we find out about access problems from patrons. When a properly-authenticated patron reports that they have hit a paywall or other “You do not have access to this content” barrier within a resource we’ve paid for, it puts us in a reactive position. Content providers usually resolve known-and-reported access problems quickly, but we are still nagged by the suspicion that what we’re aware of is only the tip of the iceberg. Trust alone is clearly not a viable option: we need a way to verify that we actually have access to everything we’ve purchased.

This is why I’ve developed the E-Resource Access Checker script, a Ruby script that automates checking availability of full access to electronic resources. It allows us to take a more proactive approach to finding access problems at each stage of our e-resource workflow.

First, the Access Checker provides an automated method for verifying full access to titles within a package based on a title list containing the URL for each individual title. In this sense, it can be conceptualized as a tool for checking in the contents of e-resource packages. Note that it is called an “Access Checker” because it goes beyond simply checking URLs, which would not reveal access problems *per se*. This difference is described more fully below.

Second, it can help resolve some metadata problems. While it can’t find missing metadata records, it can identify individual records within a batch that link to resources lacking full access. It can also flag records containing invalid URLs or DOI-based URLs that fail to resolve.

Third, it can help find problems for resources that are already “on the shelf,” so to speak. The nature of e-resources means that access problems may arise at any time, even if we verify that we have full access to all titles in a package at the time of purchase. The content provider may have server trouble. Errors may be introduced in our proxy or IP configurations. Titles may be removed from packages, even if we have purchased “perpetual access,” and some providers are more proactive than others about notifying libraries about such withdrawals. If we have catalog records linking to titles in such situations, these titles are effectively missing from the shelves. Via a kind of virtual shelf-reading of a particular package’s contents, the Access Checker can help determine how widespread access problems are for that package. It can also help identify which existing catalog records may need to be suppressed from view or deleted from the catalog because the “volumes” are now missing.

## Verifying full access vs. verifying URLs

Having full access to an e-resource means you can use that resource in its entirety: e.g., you can read the whole book or watch the whole video. If you can only read table of contents and the first chapter of an e-book, you don’t have full access to that e-book. If the URL in a catalog record takes you to a DOI-resolution error or a “No item found” message within the content provider’s site, you effectively do not have access to that e-book unless you think to search the provider’s site for the title (and know how to do so).

Note that all of the problematic situations in the previous paragraph involve the patron being pointed to valid Web resources. For this reason, integrated library system-based or stand-alone URL checkers do not solve the problem addressed by the Access Checker. These URL checkers mainly report whether a URL points to a valid Web resource or not based on the HTTP status code the server returns (404, 502, etc). But e-resource content providers rarely (if ever) use HTTP status codes to indicate whether or not an e-resource is accessible. When they provide restricted-access messages about their e-resources, they generally send them with a 200 (OK) status, so traditional URL checkers fail to report them as problematic.

Furthermore, a URL checker might report that a URL redirects to another URL, but it won’t actually follow the redirect. With e-resources, we expect that most URLs from title lists or in MARC records will redirect to a different URL on the content provider’s platform, so telling us that a URL redirects is uninformative. We need to know what content is found at the end of the redirect chain.

In 2013, the Code4lib Journal published an article describing a tool called Normac, which includes an access checker that works on the same principles as the one described here. \[[6](https://journal.code4lib.org/articles/#note6)\] This was the first I had heard of any other solution for automated access verification, and I had developed the first versions of my Access Checker in late 2010. Normac’s access checker is part of a more complex tool to automate e-resource metadata batch processing, and requires users to configure their own access checking logic profiles. The Access Checker I’ve developed is a simpler solution that staff at any library can use to verify access to their e-resources (on the supported platforms) without any configuration. The downside to this is that users of this Access Checker who want to check access on platforms not currently supported need either a) to edit their version of the script locally; b) to contribute changes to the script via GitHub; or c) to ask me to add support for the desired platform (and wait for me to make that happen).

## How the E-Resource Access Checker works

On many e-resource platforms, the descriptive landing page for an e-resource to which a patron has full access includes a clear indication of its accessibility: a green check mark, for instance, or a text string such as “Access to this e-book is provided by…” or “Full text.” This access signifier is different on each content-provider platform—and even sometimes different for individual packages offered by the same content provider. The presence of the access signifier (or the string representing it in the HTML source) is what the Access Checker pays attention to.

However, verifying access isn’t always a binary decision, and it isn’t always as clear as affirming the presence of a positive indicator of full access. On some platforms, there is no positive access signifier; in these cases, the absence of an error or “You do not have access” message is *assumed* to indicate full access.

In some packages, we see multiple types of access problems. SpringerLink is a good example of this. Typical access problems on this platform fall into four categories:

- A URL points to the e-book title on SpringerLink, but access is restricted (only the table-of-contents and front matter are available).
- A URL points to a “not found” page within SpringerLink (which returns a 200 (OK) HTTP status code).
- A DOI-based URL does not resolve and points to “DOI Not Found” page.
- A DOI-based URL resolves to the e-book on a partner publisher’s site, where our successfully authenticated users are asked to purchase the book in order to view its contents.

Resolving each of these types of access problem requires different steps, so we need to know which category a given problem falls into.

The E-Resource Access Checker is a simple JRuby script \[[7](https://journal.code4lib.org/articles/#note7)\] that automates checking the access status of individual e-resource titles. You run it from the command line using the input and output files as parameters:

```
> jruby access_checker.rb urls_to_check.csv access_results.csv
```

The Access Checker takes input from a .csv file, which may contain any number of columns (title and record ID are commonly included). The last column must contain one URL associated with the title, \[[8](https://journal.code4lib.org/articles/#note8)\] and all the URLs in the file should be on the same content-provider platform. The title lists obtained from content providers are usually spreadsheets that are easily saved as .csv files for use as Access Checker input. Bibliographic data and URLs can also be extracted or exported from MARC records in a spreadsheet-like format easily convertible to .csv from MarcEdit and some integrated library systems.

When a user starts the script, she is presented with a list of platforms supported by the Access Checker and must type which platform she wants to check for access. The script checks the HTML source code that each URL points to for appropriate access-signifier string(s) for the specified platform. If a string matches, the corresponding access result is returned. If no match is found for any of that platform’s access signifiers, the script returns the result: “Check access manually.” Details on the access signifiers used for the platforms currently supported by the Access Checker are found in the table below.

While the Access Checker is running, the result for each URL is printed to the screen so the user can get a general sense of the progress and the severity of the access problems. The access result for each URL is also appended to the output .csv file. The output file is equivalent to the input file, with a new “access” column added to the end.

We have been using the Access Checker heavily at UNC Chapel Hill since late 2010. It has been used successfully by at least three other institutions. Access checking for EBSCOhost ebooks was added at the request of a colleague at one of these institutions just before UNC began purchasing titles on that platform.

| Platform | String to Match | Access Result Returned if Matched |
| --- | --- | --- |
| Apabi | `type="onlineread"` | Access probably ok |
| Alexander Street Press | `Page Not Found` | Page not found |
| Alexander Street Press | `error` | Error returned |
| Alexander Street Press | `Browse` | Full access |
| Duke University Press (Highwire) | `DOI Not Found` | DOI error |
| Duke University Press (Highwire) | `Log in to the e-Duke Books Scholarly Collection site` | No access |
| Duke University Press (Highwire) | `t-page-nav-arrows` | Full access |
| Ebrary | `Document Unavailable.` | No access |
| Ebrary | `Date Published` | Full access |
| EBSCOhost | `class="std-warning-text">No results` | No access |
| EBSCOhost | `eBook Full Text` | Full access |
| ScienceDirect | `<td class=nonSerialEntitlementIcon><span class="sprite_nsubIcon_sci_dir"` | Restricted access |
| ScienceDirect | `title="You are entitled to access the full text of this document"` | Full access |
| SAGE Knowledge | `Page Not Found` | No access – page not found |
| SAGE Knowledge | `Add to My Lists` | Probable full access |
| SAGE Research Methods | `Page Not Found` | No access – page not found |
| SAGE Research Methods | `Add to Methods List` | Probable full access |
| SpringerLink | `viewType="Denial"` | Restricted access |
| SpringerLink | `viewType="Full text download"` | Full access |
| SpringerLink | `DOI Not Found` | DOI error |
| SpringerLink | `Bookshop, Wageningen` | wageningenacademic.com |
| SerialsSolutions | `SS_NoJournalFoundMsg` | No access indicated |
| SerialsSolutions | `SS_Holding` | Access indicated |
| University Press Scholarship | `<div class="contentItem">` | Full access |
| Wiley Online Library | `DOI Not Found` | DOI error |
| Wiley Online Library | `You have full text access to this content` | Full access |

**Table 1:** Access-signifier strings checked for each platform.

## Decisions made and challenges faced in development

### Use of Celerity and JRuby

I began writing the Access Checker in Ruby while teaching myself the language, but I ran into many errors I didn’t know how to resolve when using its standard libraries to handle the URLs and the content they returned. Most content provider URLs redirect at least once before landing on the page a patron sees in her browser. Further, what the patron sees is often rendered after JavaScript or some other wizardry happens at load time. Some content provider sites are very slow to respond and would time out under the standard libraries. The Access Checker also needed to work with URLs containing proxy strings, which were problematic for the standard libraries.

My research turned up a JRuby library called Celerity that solved the above problems. “Celerity is a JRuby wrapper around HtmlUnit – a headless Java browser with JavaScript support. It provides a simple API for programmatic navigation through web applications.” \[[9](https://journal.code4lib.org/articles/#note9)\] Essentially, Celerity allows your program to “see” a web page as an end user would see that page in a browser, so it can test for the presence of elements in a final rendered Web page. Using Celerity, I could still write my script in Ruby; it only required I install and run the script in JRuby.

The major downside of using Celerity is it adds a lot of complexity to an otherwise extremely simple program. \[[10](https://journal.code4lib.org/articles/#note10)\] Sometimes the processes handled by Celerity fail in ways I haven’t been able to address in the Access Checker, partly because they don’t always fail again in quite the same way if tried again a minute later. Sometimes these failures cause the Access Checker to stop running. To mitigate this issue, the Access Checker writes the access result for each resource in the input file to the output file as it is checked. This way, if the script fails, you can just remove the already-checked resources from the input file and restart the script. If you give the same output file when calling the script, it will not be overwritten; the rest of the access results will be appended to it. This is also handy if you need to verify access to a large number of resources—you can break your input files down into smaller lists for checking \[[11](https://journal.code4lib.org/articles/#note11)\] but write all the results to one file.

### Creating a well-behaved script

From the beginning, I was concerned with creating a tool that could be used without drawing the attention or ire of our content providers. The Access Checker is fairly slow due to the way Celerity works. Each page is loaded into the virtual Java browser behind the scenes, one at a time, and checked for access. The Access Checker also adds a brief sleep time after checking each URL. This sleep time is currently hard-coded into the script and is the same for all platforms, but I have considered allowing it to be set interactively at run-time or configured per platform. The Access Checker’s behavior resembles that of a preternaturally focused person clicking through a list of links more than a typical link checker or Web robot.

Furthermore, for all but one platform, the Access Checker never touches the actual full content of the resource. Only the descriptive landing page for the e-resource is visited. The exception is Duke University Press Ebooks via their new Highwire platform. At the time I added access checking logic for this platform, I found no differences in the source code of the landing page for a resource to which we had full text access, and one we had no access to. The only way I could manually check for access was to click the “Read Now” button on the landing page and see if I was asked to log in (no access), or shown the first page of the book (full access). The Access Checker approximates this process by requesting page 25 of each title and seeing checking for access signifiers on the resulting page. I have requested of Duke University Press that they add a visual indicator of full text access to the e-book landing pages.

## Ideas for improving the Access Checker (or building a better one!)

The Access Checker was one of my first real coding projects, so I’ve been very pleased to make something that solves problems and meets needs at my institution and beyond. However, especially as one of my first projects, the tool can certainly be improved. I welcome suggestions, collaborators, and other people running with this “access checking” concept to create much nicer tools than I have the skills to build. Some of the possible improvements that loom largest in my mind follow.

Earlier I described the occasional and seemingly random errors thrown by Celerity that sometimes cause the Access Checker to fail. While the Access Checker is designed so that you don’t lose the results of any already-checked resources, this sort of failure lacks grace and doesn’t engender confidence in a user. The Access Checker’s responses to Celerity’s errors should be improved, and figuring out how to do this has been on my to-do list for a long time. Until I have time to improve my coding chops, it will likely remain on the list.

The Access Checker can be further improved by adding support for more platforms, which is quite simple to do. Once you have HTML source examples for (1) a resource with full access; (2) a resource with restricted or no access; and (3) any other category of known error occurring on a given platform whose status should be reported separately, you examine the HTML source to identify the access signifiers for each of those states. After that, adding the access checking logic to the script is trivial. Fortunately, the access checking logic is not institution-specific, so it’s easy to add support for platforms to which my institution does not have access, if you have HTML source examples.

Currently, the access-checking logic for each platform is hard coded in the body of the Access Checker script, which isn’t ideal practice. Further, many libraries purchase e-resources on just a handful of platforms. Presenting every user with a list of all supported platforms becomes unwieldy and unfriendly as the list of supported platforms grows. I have considered moving the logic for each platform into a separate platform configuration file. Users would download only the files for the platforms relevant to their institutions but wouldn’t have to figure out the access checking logic for themselves, which is one of the strengths of this script over Normac’s access checker.

Finally, the Access Checker must be run from the command line, which is highly intimidating to many of the technical services staff who would benefit most directly from using this tool. As much as I’d love to encourage everyone to embrace the power of the command line, Cynthia Ng’s presentation at the 2014 Code4Lib conference \[[12](https://journal.code4lib.org/articles/#note12)\] drove home the fact that the Access Checker isn’t easily accessible to its main target users. Creating and distributing a GUI-based access checker is quite a bit beyond my ken at this point, but anyone who could make that happen would be a hero to e-resources librarians.

## Conclusion

The Access Checker script I’ve described here has helped UNC Chapel Hill regain some semblance of control over our e-resources packages at very little additional cost. The script can take a long time to run, but the staff time needed to start it and process the results is minimal—we always include the content provider’s unique ID for each resource in our input file, so filtering the output results to produce a list of problems that can be sent to a content provider is trivial. And the results are well worth it. Although we have not kept systematic statistics on access problems identified using the Access Checker, here are a few examples to give a general idea of how we use the tool and what we’ve found.

First, only one of our large e-book packages necessitates running the Access Checker routinely: we frequently receive new MARC records for it, and we know the titles and MARC records in this package often demonstrate access issues. We’ve run the Access Checker on the entire collection retrospectively, and we run it on all URLs provided in new MARC records before we load them. Currently we have 38,447 MARC records in our catalog for this package, of which 1,482 (nearly 3.9%) are suppressed due to discovering via the Access Checker that access is restricted. These are reported to the content provider, and the records are eventually unsuppressed (if erroneously restricted access is restored) or deleted (if we received records for titles we didn’t purchase). There are also 33 MARC records in which we’ve provided a non-DOI URL due to issues with the DOI-based URLs provided in the package (e.g., DOI error or resolution to partner publisher page). We report DOI problems and revert the URLs in the records to the DOI format as issues are resolved.

Second, for other packages, we tend to use the Access Checker to identify the scope of access problems reported to us. For example, within one day, we received two user reports about issues with a platform that has 2,031 MARC records in the catalog. We ran the Access Checker on the URLs from all the records and discovered a total of nine access problems that we then reported to the content provider. Full access to the titles was quickly restored. Titles in this package are heavily used, so it was important to identify and rectify all access problems, even if there were relatively few.

Finally, the Access Checker is useful for verifying title lists from content providers, especially when the number of MARC records we receive for a package doesn’t match the number of titles in the package’s title list. For one package, we received a list of 786 titles but 792 MARC records. Using the Access Checker on URLs extracted from the MARC, we identified that access to 120 of the titles included on the title list was restricted but we had full access to six titles not included in the title list. We sent these discrepancies to the content provider, who corrected the title list. If a package contains significantly fewer titles than claimed by the title list provided at the time of purchase, there may be an opportunity to negotiate a refund or credit with the content provider.

As you can see, with the Access Checker at our disposal, we can have more confidence that the e-resources we license are actually accessible to our patrons. Although we do trust our content providers and we realize they are doing their best in good faith to ensure access to their resources, we also know that it’s impossible for them to be aware of every problem that crops up. This tool helps us proactively identify the problems that inevitably do occur so we can report them to content providers for resolution. In turn, this improves their products and service, possibly for all libraries buying the content. It also ensures that we are getting all that we are paying for with our e-resources packages.

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] The “shelf-ready” services offered by major vendors of print library materials increasingly obviate the individual cataloging and physical processing steps for libraries that can pay for such services; however, every print book a library receives must still be touched and placed somewhere within that library.  
\[[2](https://journal.code4lib.org/articles/#ref2)\] The issues and solutions discussed in this paper apply equally across e-resource formats. Where I revert to text-focused language, it is for brevity.  
\[[3](https://journal.code4lib.org/articles/#ref3)\] The following reflects my responsibility for all e-resources purchased by the Academic Affairs Library (ie. not by UNC’s Health Sciences or Law Libraries).  
\[[4](https://journal.code4lib.org/articles/#ref4)\] What counts as a separate e-resources package is by no means clear, and differences in interpretation here endlessly complicate the answers to seemingly obvious questions such as “How many e-book collections do we own?” In general, I count something as a separate package if (a) it was purchased separately (Business Expert Press 2011 Collection is separate from Business Expert Press 2013 Collection); (b) it is a segment of a purchased collection with a separate source of cataloging (the e-journals from AGU Digital Library are cataloged via SerialsSolutions, but the monographs from the same are cataloged via OCLC WorldCat Collection Set); or (c) it is a segment of a purchased collection for which cataloging is handled by another section or accounting unit.  
\[[5](https://journal.code4lib.org/articles/#ref5)\] We also increasingly employ non-catalog discovery tools such as ProQuest Summon or EBSCO EDS to provide intellectual access. This article will not discuss these directly, as I have not personally worked on access checking based on data exported from these tools, but this is certainly possible.  
\[[6](https://journal.code4lib.org/articles/#ref6)\] [http://journal.code4lib.org/articles/8375](https://journal.code4lib.org/articles/8375)  
\[[7](https://journal.code4lib.org/articles/#ref7)\] Initially named “Ebook Access Checker,” this script and instructions for its use are available via GitHub: [https://github.com/UNC-Libraries/Ebook-Access-Checker](https://github.com/UNC-Libraries/Ebook-Access-Checker)  
\[[8](https://journal.code4lib.org/articles/#ref8)\] There can be multiple URLs for a single title, particularly when the input file is derived from MARC records.  
\[[9](https://journal.code4lib.org/articles/#ref9)\] [https://rubygems.org/gems/celerity](https://rubygems.org/gems/celerity)  
\[[10](https://journal.code4lib.org/articles/#ref10)\] In addition, while this article was in revision, an explicit statement that Celerity is no longer being maintained was added to its GitHub homepage. This provides further encouragement to investigate other options for use in the Access Checker.  
\[[11](https://journal.code4lib.org/articles/#ref11)\] I normally cap my input files at 3000 titles. This is due to the time it takes to check that many titles for access rather than any performance concerns.  
\[[12](https://journal.code4lib.org/articles/#ref12)\] Ng, Cynthia. (2014) “We Are All Disabled! Universal Web Design Making Web Services Accessible for Everyone.” Presented at Code4Lib 2014. ([Slides](http://code4lib.org/files/ng-c4l14.pptx) | [Video stream](http://www.youtube.com/watch?v=zLHvLZCc-K4&feature=share&t=47m3s))

## About the Author

Kristina M. Spurgin has been the E-Resources Cataloger in the University Library at University of North Carolina at Chapel Hill since 2010. Soon after finding herself in this position, she taught herself some basic coding. She has been headily solving easy problems by throwing code at them ever since.
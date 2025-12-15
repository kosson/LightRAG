---
title: "Breathing Life into Archon: A Case Study in Working with an Unsupported System"
source: "https://journal.code4lib.org/articles/17509"
author:
  - "Krista L. Gray"
published: 2023-08-29
created: 2025-01-10
description: "Archival repositories at the University of Illinois Urbana-Champaign Library have relied on Archon to represent archival description and finding aids to researchers worldwide since its launch in 2006. Archon has been officially unsupported software, however, for more than half of this time span. This article will discuss strategies and approaches used to enhance and extend Archon’s functionality during this period of little to no support for maintaining the software. Whether in enhancing accessibility and visual aesthetics through custom theming, considering how to present data points in new ways to support additional functions, or making modifications so that the database would support UTF-8 encoding, a wide variety of opportunities proved possible for enhancing user experience despite the inherent limitations of working with an unsupported system. Working primarily from the skill set of an archivist with programming experience, rather than that of a software developer, the author also discusses some of the strengths emerging from this “on the ground” approach to developing enhancements to an archival access and collection management system."
tags:
  - "#archival/repositories"
  - "#Illinois/Urbana-Champaign/Library"
  - "#Archon"
  - "#Aeon"
---
# Breathing Life into Archon: A Case Study in Working with an Unsupported System

Krista L. Gray

Archival repositories at the University of Illinois Urbana-Champaign Library have relied on Archon to represent archival description and finding aids to researchers worldwide since its launch in 2006. Archon has been officially unsupported software, however, for more than half of this time span. This article will discuss strategies and approaches used to enhance and extend Archon’s functionality during this period of little to no support for maintaining the software. Whether in enhancing accessibility and visual aesthetics through custom theming, considering how to present data points in new ways to support additional functions, or making modifications so that the database would support UTF-8 encoding, a wide variety of opportunities proved possible for enhancing user experience despite the inherent limitations of working with an unsupported system. Working primarily from the skill set of an archivist with programming experience, rather than that of a software developer, the author also discusses some of the strengths emerging from this “on the ground” approach to developing enhancements to an archival access and collection management system.

## Introduction

This is a story about breathing life into an allegedly defunct open source platform, Archon, to respond to continuing and emerging archival management needs — despite the end of developer support. Since its launch in 2006, the University of Illinois Urbana-Champaign has relied on the Archon web application software to provide access to archival description, both for researchers and staff. However, following the release of ArchivesSpace in 2013, development on Archon has largely lapsed. What is described on GitHub as the “last planned release” occurred in 2014 to provide migration tools for ArchivesSpace. [^1] The latest release, funded by institutions in the Archon Stability Update project and completed by a vendor, occurred in 2017 and provided additional security enhancements, as many institutions continued to rely on Archon to manage access to their archival metadata. [^2]

When I came to the University of Illinois in early 2015, one of my first projects was to enhance the web presence for the Illinois History and Lincoln Collections (IHLC) unit. This work included learning more about the source code structure of Archon, especially in locating the display templates and theme files that could be modified without impacting any core functions. I was fortunate to be able to consult with Christopher (Chris) Prom, one of the creators of Archon, and began making changes to improve the appearance and functionality of Archon in line with how I saw it being used or not used for different tasks in the IHLC. One of the advantages of this approach of embedded archivist development work, so-to-speak, is being able to see the problems firsthand and to be able to think through how the problems could be solved by adding features through the existing coding structures.

Over the past eight and a half years, my work with Archon has expanded into creating, enhancing, and supporting more elaborate features for each of the units using Archon within the Special Collections Division at the University of Illinois Library, which encompasses four independent instances of Archon: Illinois History and Lincoln Collections (IHLC), Rare Book & Manuscript Library (RBML), University Archives (UA) which includes the Student Life and Culture Archives and the Sousa Center for American Music Archives, and American Library Association Archives (ALA). As IHLC is oftentimes the “middle ground” between the larger RBML and UA, this made my role well-placed to listen and understand the needs of each unit.

While some of these approaches and solutions may be particular to Archon or the University of Illinois, my hope is that others working with legacy or outdated systems can draw inspiration from this case study to determine what might be possible to enhance user experience and functionality now, rather than wait for the next, better system to become possible. One of my early supervisors in the archives field had the motto of “you’re making it better!” and that has been a theme of my work with Archon. I can’t fix everything that is holding Archon back, but I can make it better.

## Background

When Archon first launched in 2006, it was groundbreaking. University of Illinois archivists and project co-directors Chris Prom and Scott Schwartz presented Archon, an open-source web-based archival management system built on a MySQL or MSSQL database with a web-based public and admin user interface written in PHP, to a standing-room-only crowd at the Society of American Archivists Annual Meeting in August 2006. [^3] Designed to facilitate archival management and easy publication of archival descriptive records online, Archon increased open access to finding aids at archival repositories across the country, from large universities to small colleges as well as government and nonprofit organizations. Archivists could edit records within the web interface and immediately make those changes available to the public, who could either search or browse for descriptions of archival collections and finding aids in the database. By March 2008, about a year and half after its release, Archon had been installed hundreds of times and more than thirty repositories had released it into production. [^4] In December 2008, the University of Illinois Library received the Mellon Award for Technology Collaboration for “leadership and development work on Project Archon.” [^5]

By 2015 Archon was showing its age. Development resources in the US archives field had largely shifted to a new system, ArchivesSpace, which aimed to combine the strengths of Archon and Archivists’ Toolkit, the two primary archival information management software systems in the US at the time. [^6] Nearly ten years after its initial release, the default styling in Archon no longer matched users’ mental models of how a database would work, or how a modern website might look. For example, on the landing page the search box for the default theme is tucked up at the top corner, and the center of the page presents search tips rather than information about the repository or contents of the database.

![](https://journal.code4lib.org/media/issue57/Gray/figure1_archon-with-default-theme.png)  
**Figure 1.** How the main page of Archon appears when using the default theme

Moreover, at the University of Illinois, encoding errors arising from using MSSQL for the backend database (which at the time did not support UTF-8) led to collection descriptions inadvertently (and infuriatingly) populated with extraneous characters every time a collection with text that included double spaces, curved quotation marks, or any diacritics was saved to the database.

![](https://journal.code4lib.org/media/issue57/Gray/figure2_example-stray-characters.png)  
**Figure 2.** Excerpt of a collection description with double spaces generating stray characters (from the [August 2015 version of the control card for IHLC’s Busey-Yntema Collection](https://web.archive.org/web/20150824020620/http://www.library.illinois.edu/ihx/archon/index.php?p=collections/controlcard&id=877))

Archon also did not integrate with Aeon, software that the RBML had adopted in 2014 to manage requests and retrieval of materials for use by researchers in the reading room or by staff. Staff and researchers had to create request transactions for archival materials manually in Aeon, leading to significant data inconsistencies and a lot of extra work.

Closer to home at the IHLC, a supplementary Word document was employed to track which collection identifiers were already in use in the system (a document which, naturally, was not consistently updated). Furthermore, unprocessed collections with no descriptions were displaying publicly with no way for a user to interpret if there was an error in page rendering or if the collection was undescribed, and a new employee like myself had no way of learning about the collection descriptive information in the database as a whole (including which collections remained unpublished) without checking each collection one by one.

## Starting with styling

My first steps to enhance user experience with Archon were with styling; specifically through Archon’s theme and template files. Archon’s theme files include the CSS for the entire public interface, along with the code for generating the headers, footers, and standalone pages (including the main page). Templates include the code for generating database record views such as the “control card” (modeled on the old index cards) and the finding aid for archival collections. Both theme files and templates were designed to be customizable without touching the core code in Archon.

Styling can seem simple, but it can do a lot to breathe life into an outdated system — whether making the interface more beautiful, adding accessibility features, or making pages responsive. While it might seem superficial, updating the visual elements can enhance how staff and researchers experience the system, making it a more pleasant and informative interaction. [^7] Styling and modification of templates supports the creation of better visual connections to other institutional pages so that the transition feels less jarring to visitors. I have not attempted to keep up with every style change in the University of Illinois Library website, but creating a theme that blended elements of the Library website and the Digital Collections site (the library’s access repository for digital and digitized special collections content and other library resources) was a huge step toward a more integrated visual experience. Modifying the theme or template can also provide additional context, such as a physical address and contact information (both prominently missing from the default templates in Archon).

![](https://journal.code4lib.org/media/issue57/Gray/figure3_ihlc-archon-comparison.png)  
**Figure 3.** At left, IHLC’s Archon as it appeared in February 2015. At right, as it appears in 2023.

Beyond aesthetic considerations of styling, something as simple as converting a link that is easy to miss into a larger button can improve user experience greatly by providing them a clear course of action. In the case of Archon, adding code to the theme files also supported adding a large search box to the landing page that better meets current user expectations for interacting with databases.

![](https://journal.code4lib.org/media/issue57/Gray/figure4_ua-digitalobject-comparison.png)  
**Figure 4.** At left, UA’s digital object record display as of 2022 that relies on users to recognize the URL to click within the metadata. At right, how the digital object record appears in 2023 with the added “access files” button.

Simple changes, such as adding focus styling to support keyboard navigation and increasing text color contrast, can enhance accessibility. And while rebuilding the interface in a responsive framework like Bootstrap was beyond my skill set and time commitment, adding media queries for different screen sizes created a “good enough” solution for access on different devices. [^8]

## Reusing data in new ways

Working more with the templates also led to learning more about how the functions for retrieving data for display from the database worked. When faced with new challenges and workflow needs, this background supported developing ideas of how to get the data out of Archon without having to gather it manually page-by-page. One such challenge was how to gain an understanding of all the collections held at IHLC and how they were described (or not) in Archon. Archon lacked a native reporting function, so to fill this gap I wrote the code to generate data tables, building from the functions I had seen used in other pages and templates. Lacking the skills to create a CSV file to download, I generated an HTML table and then copied it into Excel to further analyze the data.

![](https://journal.code4lib.org/media/issue57/Gray/figure5_ihlc-table-all-coll.png)  
**Figure 5.** A portion of the custom page that generates a table with basic information for all collections in Archon for IHLC.

This approach has proved valuable time and time again over the years. Most recently, I wrote PHP code to generate a list of links to the EAD versions of collections or records series with science, technology, and medicine-related subject headings to create a page for our partner at the Consortium for the History of Science, Technology, and Medicine (CHSTM) to crawl and ingest into their access system. Using a list of relevant subject headings, the code iterates through an array of IDs to generate a table for library staff to review with the results for each science-related collection or record series. Code for a second page generates a simplified list of EAD links with no styling or duplicates for our partner at CHSTM to crawl for ingest. The appropriate theme directory holds the files for both pages as well as the index.php file to route to them.

PHP code excerpt showing iterating over an array of subject term IDs to generate the review table:

```php
foreach ($arrTermsCHSTM as $chstmTermID) {
  $objSubject = New Subject($chstmTermID);
  $objSubject->dbLoad();
  echo("<tr><td>");
  if ($objSubject->ID) {
    echo("<a href='index.php?p=subjects/subjects&id=".$objSubject->ID."' target='_blank'>".$objSubject->ID."</a>");
  }
  echo("</td><td>");
  if ($objSubject->Subject) {
    echo($objSubject->toString(LINK_NONE, true));
  }
  echo("</td><td>");
         
  if ($objSubject->ID) {
    $subjectResults = array();
    $subjectResults = $_ARCHON->searchCollections(NULL, SEARCH_ENABLED_COLLECTIONS, $objSubject->ID);
    echo(count($subjectResults));
    echo("</td><td>");
    foreach ($subjectResults as $subjResult) {
      array_push($arrResultsCHSTM, $subjResult->ID);
      echo("<a href='index.php?p=collections/ead&id={$subjResult->ID}&templateset=ead&disabletheme=1&output={$subjResult->ID}'>");
      echo($subjResult->Title);
      echo("</a><br />");
    }
  }
  echo("</td></tr>\n");
}
```

![](https://journal.code4lib.org/media/issue57/Gray/figure6_ua-chstm-table.png)  
**Figure 6.** Review table listing CHSTM-relevant collections by subject heading in UA’s Archon.

Understanding how to pull data from Archon has also enabled the development of a solution for the lack of integration between Archon and our special collections request management software, Aeon. One of the methods for submitting requests for materials through Aeon involves using a URL with parameters to generate a GET request and to autofill visible and hidden fields in the request form. By understanding how the control card template displays the contents of database fields to the user, I was able to write PHP code to auto-generate a link with the necessary parameters to autofill in the form.

PHP code excerpt showing retrieving metadata from the collection object:

```php
$requestTitle = ($objCollection->Title) 
  ? $objCollection->Title 
  : "";
$requestDates = ($objCollection->InclusiveDates) 
  ? ", " . $objCollection->InclusiveDates
  : "";
$requestTitle = urlencode($requestTitle . $requestDates);
$requestIdentifier = ($objCollection->Classification) 
  ? $objCollection->Classification->toString(LINK_NONE, true, false, true, false) 
    . "/"
    . $objCollection->getString('CollectionIdentifier')
  : $objCollection->getString('CollectionIdentifier');
```

PHP code showing the process of building a portion of the GET request link:

```php
$requestBaseLink = $_ARCHON->config->RequestURL; // defined in config file
 
// concatenate the field names (URL parameters) and metadata from the collection to form the request link
$requestLink = $requestBaseLink;
$requestLink .= "&ItemTitle=" . $requestTitle;
$requestLink .= "&CallNumber=" . $requestIdentifier;
```

This approach works best for collection-level metadata (it does not allow one to autofill a particular folder title with the request link, for instance). While a shortcoming in some ways, this approach is well-suited to IHLC and University Archives finding aids (where individual folder titles would be listed), as these are primarily separate PDF documents rather than encoded in the database itself.

## Responding to emerging needs

This increased facility with the Archon code base and how data could be reused has also helped with imagining how the database could meet emerging needs not foreseen at the time of its original creation.

In preparation for an upcoming move, by summer of 2021 the RBML, IHLC, and UA had all begun projects to barcode archival boxes so they could be uniquely identified when transferred to the new vault. In order to centralize this tracking information, I wanted to find a way to record the barcode assignments in Archon.

Archon already has a location table built into its database for tracking the locations of boxes (by location, range, section, and shelf) that lent itself well to consideration for this purpose. Not having the capacity to significantly rewrite the source code, I ultimately decided the best option would be to use the shelf field in the location table to record the barcode and move the shelf information (if it existed) for any barcoded box to the section field, combining the two data points there. While not ideal, this meant avoiding having to change any database tables, which was not within my existing skill set. I consulted with fellow archivists to check if any important functionality would be lost. I already knew that many of the University Archives locations did not use the shelf field at all, and for those that did, I confirmed that combining the data with the section information would still serve their needs and received permission to proceed.

I also wanted to think ahead to how we would update the locations for hundreds if not thousands of boxes after the initial move. Storing barcodes in Archon would allow the locations of boxes to be updated more quickly by using the barcodes to retrieve the matching line in the location table to update it through an import file.

This information could also be used to uniquely represent boxes in Aeon, which had the potential to make it easier for researchers to select the requested box and have it be auto-filled via a link. Staff could also employ it to aid in the offsite retrieval process from the library’s high density storage facility. I had previously adapted the request function to create separate links for each line of the location table in order to support the future adaption of Aeon by UA and ALA, both of which store boxes in multiple buildings. Drawing on this previous work, I adapted code to also provide users with the ability to request individual boxes and to send the corresponding barcode to Aeon along with the box information for the request. Staff could then use the barcode to retrieve the location information without having to look up the collection or record series and then having to skim through the list to find the location of the specific box.

![](https://journal.code4lib.org/media/issue57/Gray/figure7_ihlc-barcode-search-result.png)  
**Figure 7.** Search box and results page for retrieving location information by barcode (location redacted).

Implementing these new features involved several components: admin and public user interface changes, as well as an import script. Each of these built on Archon customization work completed earlier.

Within the admin interface I increased the input field width for the shelf field to hold a fourteen-digit barcode. This drew on work done years earlier when I had made a similar change to accommodate a 5-digit range value for IHLC locations.

As shown in figure 7, I also created a barcode-specific search box that allows staff to retrieve a box’s collection and location by scanning the barcode. This work drew on past experience creating a search box to retrieve collections by their identifier for IHLC. Archon’s built-in search is a general keyword search and did not serve our needs for precise retrieval in either use case.

The request function in the public interface drew on an approach initially developed to handle ALA and UA collections that were stored at different service locations. This version uses a pop-up modal box to display request links for individual lines of the location table so that the associated service location can be displayed and encoded properly when submitting an Aeon request. In its most recent iteration, the request modal box checks to see if the shelf field is populated with a barcode. If it is, the code will display the box information to the user and send it to Aeon. If not, the line in the location table is hidden and a generic “other” option is generated – a necessary adjustment since IHLC and RBML staff did not originally enter location table descriptions to be displayed publicly and only the descriptions of barcoded boxes can be assumed to be ready for display to the public.

![](https://journal.code4lib.org/media/issue57/Gray/figure8_request-modal.png)  
**Figure 8.** Example of a request modal box (with an example filter of “2”) for an IHLC collection with an embedded PDF finding aid, showing also the “other” option for unbarcoded boxes.

The import script drew on an earlier project to survey the archival collections in IHLC and record where they were located. The code includes logic that checks that the data appears to be correctly structured and catches errors. It also allows for variations based on whether the import file is adding location information for a given box or barcode for the first time or is merely updating it.

In order to create a means for staff to search and update by barcode without having to specify the collection or box number associated with that barcode, the code also establishes a new `getLocationEntryIDFromShelf($String)` function. I based this off the similar `get___IDFrom____($String)` functions, such as `getExtentUnitIDFromString($String)`. [^9] While this did not have a direct correlation from past work, it grew out of many, many readings of the source code to understand the functions underlying how something worked (or didn’t work) in Archon.

While hacking a database field for a different purpose and collapsing data from two fields into one is never ideal, leveraging my understanding of the inner workings of Archon, along with my on-the-ground experience managing an archival repository, allowed me to create a feature that extends the use of the barcoding project.

## Anticipating maintenance

As the complexity of the features that I developed grew, I adjusted my approach to make the source code easier to maintain and easier to roll out and reuse in multiple instances. Since this was essentially a side project, being able to make changes in a central location or to a file that could be copied whole rather than to code segments that had to be copied and pasted individually was a significant improvement to the workflow. Most importantly, the adaptability of the code supported the sustainability of Archon.

The first improvement came when I began defining variables in Archon’s config file rather than burying them in the template or theme files. By defining these variables in a central location in the top level directory for Archon, making edits or changes became much easier. For example, defining a variable in the config file for text to create an alert banner on IHLC’s Archon to notify users of unexpected closures from the header file in the theme made it easier to change this text quickly. Defining a series of variables for the strings and arrays needed to build a request link from the control card and finding aid templates made it easier to change both request links at once as well as to transfer code between different Archon instances. This approach also supported easily turning features on or off, such as the ability to offer expanded descriptive information about collections in the browse lists.

While this is helpful when working with template or theme files, it is especially valuable when modifying the core code to do something that changes Archon’s functionality. In late 2016, a contributor introduced a new feature (or bug, depending on your perspective) to use an inexact search rather than an exact search in Archon’s identifier search function. The inexact identifier search did not always return the searched-for identifier at the University of Illinois, so the change had to be manually reversed. To provide better control and clarity, I rewrote the PHP code to allow institutions to choose which type of identifier search they wanted from the config file rather than having to dig through the source code.

[PHP code excerpt](https://github.com/archonproject/archon/blob/db792aec904875915b589fb0ab189f49dfb17b8c/packages/collections/lib/core/archon.inc.php#L996) showing the use of a variable ($_ARCHON->config->SearchExactIdentifier) from the config file for the identifier search:

```php
if ($_ARCHON->config->SearchExactIdentifier) {
  $minLengthQuery = " OR CollectionIdentifier = ?";
  $minLengthVars = array(str_pad($CollectionIdentifier, CONFIG_COLLECTIONS_COLLECTION_IDENTIFIER_MINIMUM_LENGTH, "0", STR_PAD_LEFT));
} else {
  // replace = with Like
  $minLengthQuery = " OR CollectionIdentifier LIKE ?"; 
  // added wildcards with $CollectionIdentifier for partial search
  $minLengthVars = array(str_pad("%$CollectionIdentifier%", CONFIG_COLLECTIONS_COLLECTION_IDENTIFIER_MINIMUM_LENGTH, "0", STR_PAD_LEFT));
}
```

All the unit-specific variables being defined for the Aeon request link, however, soon created an unwieldy config file. In this case using an include statement to separate out those variables into a request-specific config file made the code easier to manage. Expanding the use of include statements to the implementation of the Aeon request link made the code easier to manage and modify as well.

Admittedly, the organic way the request link functionality has developed – from initially providing only basic collection-level information to now supplying information about the individual boxes, barcodes, and service locations – has made even this approach a bit unwieldy. The template directory now holds two main include files for the request link itself, requestprep.inc.php and requestlink.inc.php, but also requestlinkforboxes.inc.php, and three more relating to the location table displays (one for staff, one for the public, and one for a summary). However, it is much more manageable than it would be with everything buried in the existing template files. It also provides for more seamless updating across instances, as each unit’s control card template is unique, but the include files for the request link setup can be identical across units.

## Exploring new possibilities for solving old problems

In spring 2022, one of my fellow archivists at the library, Bethany Anderson, wanted to know how diacritics could be represented in Archon. As the project director for the Doris Duke Native Oral History Revitalization Project, she needed diacritics to accurately represent the names of many Native Tribes and Nations (for example, the Stó:lō Nation). However, the University of Illinois’ instance of Archon had been unable to properly save and display diacritics or even simple accents. This issue had yet to be fully diagnosed and resolved.

An email exchange with Chris Prom, Associate University Librarian for Digital Strategies, opened a new line of inquiry to this problem. My work years earlier investigating a related issue had focused on tracing the issue through the PHP source code, but Prom suggested looking at the underlying database’s character set. He recommended seeking support from Library IT to create a separate test MSSQL database for this work to be able to test and debug without concern of the impact on the live, public database.

This new line of inquiry soon revealed that the patterns of characters being garbled indicated an issue of double encoding into UTF-8 for the browser (for example, ñ would display as Ã±). I also learned that in 2019 MSSQL finally added support for UTF-8 encoding, and having the underlying database support UTF-8 encoded text began to seem like more of a possibility. \[[10\]](https://journal.code4lib.org/articles/#note10)

Working extensively with Jon Gorman from Library IT’s Infrastructure Management and Support (IMS) group for the database setup, modification, and conversion, I was able to test modifying the PHP source code to support additional characters, first in the original encoding in a test copy of an existing database and then with the full breadth of UTF-8 with the data migrated to a UTF-8 MSSQL database. The process did not go smoothly but drew on a lot of the experience and problem-solving skills I had built with Archon for the previous seven years.

In contrast to the features and solutions described earlier in this article, these issues could not be resolved through the PHP source code alone. After tracing through the source code for the display, I discovered that commenting out a line of code that was converting the string from ISO-8859-1 (Latin-1) to UTF-8 led to Archon displaying standard Latin diacritics and symbols without garbling them. Logically this didn’t make sense. Our database could not be using UTF-8 encoding (since it was a pre-2019 MSSQL database), but the function for the user interface display was clearly being passed text that had already been converted to UTF-8 and was garbling it by converting it a second time. Investigating the code, one theory that emerged was that freetds (which, as a non-developer, I had not realized was a part of the process until then) could be converting it as an intermediary between the MSSQL database and the PHP code. This understanding soon proved valuable. When I tried to connect Archon to use the migrated UTF-8 test MSSQL 2019 database, I got a blank white screen, which turned out to be due to having to set freetds to a higher version to work with MSSQL 2019.

Following the pattern outlined in the previous section, I coded the MSSQL and freetds modifications (which appeared multiple times in different files throughout the source code) so that they could be turned off and on via variables in the config file. My tests of copying UTF-8 characters from other languages and the Native Nations and Tribes names eventually worked and saved correctly. \[[11\]](https://journal.code4lib.org/articles/#note11) We rolled out the changes to the IHLC’s Archon in May 2023.

Migrating the three other instances of Archon revealed new complexities in how the code interacted with server settings as well as the impact of previous attempts to fix the double encoding issue. For instance, the earlier strategy of simply commenting out a line of code converting the string from ISO-8859-1 (Latin-1) to UTF-8 worked on the development server but not the production server for the three other Archon instances. On this production server it led to text fields with diacritics or double spaces failing to display (and therefore being overwritten with an empty string when saving).

Tracing through the code, I found the error arising from functions like htmlspecialcharacters and preg_replace returning null if the string passed to them is not in UTF-8. I added some code to catch this error and convert the string to UTF-8 if needed so that these functions would not delete data if the encoding was not in UTF-8 as expected.

Analyzing the text strings on each server as hexcodes, I was able to find that the PHP received text in UTF-8 on one server and in a different encoding (possibly Latin-1) on the other. This pointed to the freetds settings as the likely culprit. To resolve the issue, Gorman wrote a stanza to establish the appropriate freetds settings to support UTF-8 versions of Archon on this other server as well.

After resolving these issues, we successfully migrated both the RBML and ALA instances of Archon to UTF-8 versions and began adding in diacritics for names that had been inaccurately represented for years. In migrating the UA instance of Archon, we encountered one final issue. In the test copy of their database, with all the same code and server settings that had worked for RBML and ALA, sample text in the control card with diacritics would save correctly but display in the same garbled, double-encoded pattern from earlier.

![](https://journal.code4lib.org/media/issue57/Gray/figure9_ua-utf8-test-admin.png)  
**Figure 9.** The saved version of the sample text in the admin editor in the UA UTF-8 test database. \[[12\]](https://journal.code4lib.org/articles/#note12)

![](https://journal.code4lib.org/media/issue57/Gray/figure10_ua-utf8-test-public.png)  
**Figure 10.** The public display of the same text with the characters in the scope and content note (at right, labeled “Description”) displaying with the double encoding error pattern and the sample text in the abstract (at left) displaying correctly.

Given that the abstract displayed the sample text correctly but the scope and content note did not, this pointed to an issue in the display of that particular field in the control card template. Applying a different template set (the one in use for ALA’s instance of Archon) led to the text displaying correctly. Comparing the two templates revealed a modification to the UA template that added another layer of encoding the scope and content note into UTF-8, leading to the persistent double-encoding.

In the UA template they had:

```php
<?php echo (utf8_encode($objCollection->getString('Scope'))); ?>
```

As opposed to in the ALA template:

```php
<?php echo($objCollection->getString('Scope')); ?>
```

Once corrected, the UA instance worked as expected. This issue, while ultimately simple to resolve, also points to the challenging opacity of one-off changes in legacy codebases, and to the value of documentation. In this case, the source code did not even include any comments around this line about why this modification was added, or that it was an attempted fix for a specific issue. In working with legacy codebases, there is a balance between band aid-type solutions vs. more systemic investigations. However, a focus on increased transparency regardless provides value for sustainability as well as future directions.

Throughout this project, I drew heavily on what I had learned in navigating, reading, and modifying Archon’s source code over the previous seven and a half years. I am grateful to Jon Gorman for all his help in the areas where I did not have experience, and to Bethany Anderson and Chris Prom for bringing up the issue and pointing me in the right direction. While it was more involved than anticipated, after more than seven years of struggling with double spaces and having to tell my student employees that, no, we can’t spell names or words in other languages correctly, it was wonderful to finally have Archon support UTF-8.

![](https://journal.code4lib.org/media/issue57/Gray/figure11_doris-duke-excerpt.png)  
**Figure 11.** Excerpt of the control card description for the [Doris Duke Indian Oral History Program Archives, 1908-1995](https://archon.library.illinois.edu/archives/index.php?p=collections/controlcard&id=5459), showing the names of Native Nations and Tribes successfully displaying with diacritics.

## Conclusion: Is there really hope for Archon?

To some extent there is an elephant in the room. After all this, Archon is still running on a maximum of PHP 5.6 and cannot be updated further due to dependencies on a PEAR library that has not been updated since 2012, with the last stable release from 2007. Maintaining Archon into the future will eventually require dedicated development support for rewriting the entire interface and database communication layer, likely from the ground up. So, was all this a waste?

I would argue it’s not a waste. All this work has provided us with a more functional system that can accommodate changing needs and support emerging workflows. It has also provided proof-of-concept for certain features not originally included in Archon. And it has provided years of more accessible information about our holdings. While Archon’s limitations have held us back in some ways, being an archivist on the ground who could see new solutions and implement them has allowed us to make far better use of the system rather than staying in a continual holding pattern.

Beyond improving our current use of Archon, the investment in gaining in-depth understanding of Archon, its data model, and how it functions can be leveraged also toward the assessment of future systems, as well as eventual plans to transition into a new system. Developing new ideas and imagining how the current system could function more effectively lends itself well to envisioning what could and should be improved in a new system as well as to analyzing what else might be possible. Not only did this work breathe new life into Archon for the present, but it also positions us better in planning archival management systems for the future.

## Notes

[^1]: Chris Prom, “Release Archon 3.21-rev. 2,” ArchonProject/Archon on GitHub, released January 17, 2014, [https://github.com/archonproject/archon/releases/tag/v3.21.2](https://github.com/archonproject/archon/releases/tag/v3.21.2)

[^2]: Anne Salsich, Caitlin Nelson, and Nat Wilson, “Should I Stay or Should I Go: What to Do When Your Beloved Software is No Longer Supported? Update it Yourself!” (conference presentation slides, Library Technology Conference, 2017, [https://digitalcommons.macalester.edu/libtech_conf/2017/sessions/18/](https://digitalcommons.macalester.edu/libtech_conf/2017/sessions/18/)).

[^3]: Scott W. Schwartz, Christopher J. Prom, Christopher A. Rishel, Kyle Fox, “Archon: A Unified Information Storage and Retrieval System for Lone Archivists, Special Collections Librarians and Curators” *Partnership: the Canadian Journal of Library and Information Practice and Research* 2, no. 2 (2007): 2. While the early documentation emphasized that Archon could run on any web server, by 2013 Archon’s README file specifically recommended against using a Windows server and noted that Archon “was developed and tested on a LAMP (Linux, Apache, MySQL, PHP) server.” [https://github.com/archonproject/archon/blob/master/README.md](https://github.com/archonproject/archon/blob/master/README.md)

[^4]: Scott W. Schwartz, Christopher Prom, Kyle Fox, and Paul Sorensen, “Archon: Facilitating Global Access to Collections in Small Archives” (74th IFLA General Conference and Council, Quebec, Canada, August 2008), 3.

[^5]: “Two University Library Archivists Honored with 2008 Andrew Mellon Foundation Award,” University of Illinois Library, published December 16, 2008, accessed from the December 28, 2015 crawl of the page saved in the Internet Archive, available at [https://web.archive.org/web/20151228234745/http://www.library.illinois.edu/news/archon_award.html](https://web.archive.org/web/20151228234745/http:/www.library.illinois.edu/news/archon_award.html).

[^6]: Assessing whether ArchivesSpace has achieved this goal is out of scope of this article. While a number of former Archon institutions have migrated to ArchivesSpace, others have shared the perspective that “the result of that merger, ArchivesSpace, left many Archon users feeling excluded. The technical complexities of hosting a local instance, the exhaustive descriptive possibilities, and the steep learning curve all presented significant barriers to repositories accustomed to Archon’s ease of use.” Jeremy Brett, Colleen McFarland Rademaker, Doris Cardenas, Anne Thomason, and Nancy Webster, “Light from the North: Reviving the Spirit of Archon through AtoM” (presentation abstract, Midwest Archives Conference Annual Meeting, Detroit, MI, April 6, 2019, [https://www.iastatedigitalpress.com/macmeetings/article/id/294/](https://www.iastatedigitalpress.com/macmeetings/article/id/294/)).

[^7]: Research has suggested that higher website aesthetics positively influences the user’s opinion of the corporate body represented by the website as well. See Zhenhui (Jack) Jiang, Weiquan Wang, Bernard C.Y. Tan, and Jie Yu, “The Determinants and Impacts of Aesthetics in Users’ First Interaction with Websites” *Journal of Management Information Systems* 33, no. 1 (2016): 229–259. [doi:10.1080/07421222.2016.1172443](https://www.tandfonline.com/doi/abs/10.1080/07421222.2016.1172443?journalCode=mmis20). Aesthetics may also have an impact on usability, but research outcomes in this area of study vary. A 2019 meta-analysis of studies examining the impact of aesthetics on user performance found a small positive impact of aesthetics on performance. See Meinald T. Thielsch, Jana Scharfen, Ehsan Masoudi, and Meike Reuter, “Visual Aesthetics and Performance: A First Meta-Analysis,” in *Proceedings of Mensch und Computer 2019* (New York, NY: Association for Computing Machinery), 199–210. [https://doi.org/10.1145/3340764.3340794](https://dl.acm.org/doi/10.1145/3340764.3340794). In a work-in-progress presented in spring 2023, researchers in Germany argued that the aesthetic-usability effect may be strongly impacted by levels of “processing fluency,” an impact they summarize as “mind at ease makes usable and beautiful,” though this research measured only perceived usability (as well as perceived aesthetics and processing fluency) rather than performance. See Jan Preßler, Lukas Schmid, and Jörn Hurtienne, “Statistically Controlling for Processing Fluency Reduces the Aesthetic-Usability Effect” in *Extended Abstracts of the 2023 CHI Conference on Human Factors in Computing Systems* (New York, NY: Association for Computing Machinery), Article 261, 1–7. [https://doi.org/10.1145/3544549.3585739](https://doi.org/10.1145/3544549.3585739).

[^8]: There are many guidelines and recommendations available for improving accessibility and responsiveness of websites. “Designing for Web Accessibility” from the W3C Web Accessibility Initiative (WAI) is one possible place to start. [https://www.w3.org/WAI/tips/designing/](https://www.w3.org/WAI/tips/designing/)

[^9]: One shortcoming of this approach is that it assumes only one location entry is associated with a particular barcode and cases may exist where components from multiple collections are stored in the same box.

[^10]: Pedro Lopes, “Introducing UTF-8 support for SQL Server,” SQL Server Blog, Microsoft, July 2, 2019, [https://techcommunity.microsoft.com/t5/sql-server-blog/introducing-utf-8-support-for-sql-server/ba-p/734928](https://techcommunity.microsoft.com/t5/sql-server-blog/introducing-utf-8-support-for-sql-server/ba-p/734928).

[^11]: I am grateful for Frank da Cruz’s UTF-8 sampler for testing, available at [https://www.kermitproject.org/utf8.html](https://www.kermitproject.org/utf8.html).

[^12]: The sample text used came from Frank da Cruz’s UTF-8 sampler, referenced above.

## About the Author

Krista L. Gray is the Archives Program Officer for Illinois History and Lincoln Collections at the University of Illinois Urbana-Champaign Library.

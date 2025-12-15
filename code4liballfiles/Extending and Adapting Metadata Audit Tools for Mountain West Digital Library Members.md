---
title: "Extending and Adapting Metadata Audit Tools for Mountain West Digital Library Members"
source: "https://journal.code4lib.org/articles/13632"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-08-09
created: 2025-01-10
description: "As a DPLA regional service hub, Mountain West Digital Library harvests metadata from 16 member repositories representing over 70 partners throughout the Western US and hosts over 950,000 records in its portal. The collections harvested range in size from a handful of records to many thousands, presenting both quality control and efficiency issues. To assist [...]"
tags:
  - "clippings"
---
# Extending and Adapting Metadata Audit Tools for Mountain West Digital Library Members
Teresa K. Hebron

As a DPLA regional service hub, Mountain West Digital Library harvests metadata from 16 member repositories representing over 70 partners throughout the Western US and hosts over 950,000 records in its portal. The collections harvested range in size from a handful of records to many thousands, presenting both quality control and efficiency issues. To assist members in auditing records for metadata required by the MWDL Metadata Application Profile before harvesting, MWDL hosts a metadata auditing tool adapted from North Carolina Digital Heritage Center’s original DPLA OAI Aggregation Tools project, available on GitHub. The tool uses XSL tests of the OAI-PMH stream from a repository to check conformance of incoming data with the MWDL Metadata Application Profile. Use of the tool enables student workers and non-professionals to perform large-scale metadata auditing even if they have no prior knowledge of application profiles or metadata auditing workflows.

In the spring of 2018, we further adapted and extended this tool to audit collections coming from a new member, Oregon Digital. The OAI-PMH provision from Oregon Digital’s Samvera repository is configured differently than that of the CONTENTdm repositories used by existing MWDL members, requiring adaptation of the tool. We also extended the tool by adding the Dublin Core Facet Viewer, which gives the ability to view and analyze values used in both required and recommended fields by frequency.

Use of this tool enhances metadata completeness, correctness, and consistency. This article will discuss the technical challenges of project, offer code samples, and offer ideas for further updates.

## Background

Originally founded in 2001 as a collaboration by members of the Utah Academic Library Consortium (UALC), Mountain West Digital Library (MWDL) has grown to become a Digital Public Library of America (DPLA) regional service hub, harvesting digital collections metadata from 16 member repositories representing more than 70 partners in 6 western US states and hosting over 950,000 records in its portal. MWDL was one of DPLA’s six inaugural service hubs and, at the time of DPLA’s launch in 2013, the largest contributor of records. An in-depth history of MWDL can be found in Neatrour, et al., 2016.

This article will discuss my adaptation of an existing metadata auditing tool provided by MWDL for its staff and members to extend the tool’s capabilities and offer ideas for future enhancements. Focusing on MWDL’s Open Archives Initiative-Protocol for Metadata Harvesting-enabled (OAI-PMH) harvesting of digital collections and regional aggregation, this article is a case study for adapting similar tools for metadata auditing against different metadata profiles and standards.

MWDL audits incoming metadata to ensure conformance with the MWDL Metadata Application Profile (MAP). The MAP currently requires 8 Dublin Core fields: date, description, format, identifier, rights, subject, title, and type. Two further fields are mandatory-if-applicable: conversion specs and creator. Language and geospatial fields are recommended, but not required (Mountain West Digital Library Metadata Taskforce 2011). While the MAP provides instructions how to apply these metadata standards at the local level, the challenge of checking them for completeness and conformance before harvest at the regional level remains. Since the majority of MWDL records are in turn harvested by DPLA, this warrants double-checking the records at the point of regional aggregation. DPLA periodically audits ingests for missing or non-conforming required fields, which could necessitate a large-scale metadata remediation project before harvesting is possible.

These collections range widely in size from a single record to tens of thousands in a single collection. MWDL has a very small staff, consisting of two full-time librarians and several part-time student workers. To extend the ability of the staff to audit collections rapidly and accurately, MWDL launched an adaptation of the North Carolina Digital Heritage Center’s DPLA OAI Aggregation Tools project available on GitHub in late 2015 (McIntyre 2015). The NCDHC’s original version of this web-based tool offered three features to aid in metadata auditing by DPLA hubs: 1) displaying data mapped to simple Dublin Core fields (mapping checker), 2) displaying the frequency of terms in each of the simple Dublin Core fields (facet viewer), and 3) displaying records that are missing “required” fields (required data checker). NCDHC staff developed the tool “… to quickly assess (1) the presence of required, recommended and optional fields and (2) the baseline quality of different metadata collections” (Gregory and Williams 2014).

To use each of the features, the user inputs the OAI-PMH base URL of a repository, chooses a set to test, and the tool issues an OAI ListRecords command and draws a table with the results.

To demonstrate how useful this tool can be, consider the previous auditing workflow. Using OAI, the Metadata Librarian can examine the records in a particular set via a browser, checking them visually for conformance with the MAP.

For example, the OAI base URL for Utah State Archives’ CONTENTdm repository is:

```
http://images.archives.utah.gov/oai/oai.php
```

OAI-PMH uses a standard set of requests, called verbs, to request and provide data in a uniform way. A user can see the group of collections (or sets) available by using the ListSets verb:

```
http://images.archives.utah.gov/oai/oai.php?verb=ListSets
```

To see the records in a specific set, the user can use the ListRecords command (Tooele County (Utah) County Clerk Register of Deaths):

```
http://images.archives.utah.gov/oai/oai.php?verb=ListRecords&metadataPrefix=oai_qdc&set=p17010coll40
```

This collection only contains a single record, making it easy to check. But imagine checking a collection with ten thousand records! The aggregation tool issues the ListSets command, allows the user to choose a set from a drop-down, then issues the ListRecords command behind the scenes and provides a visual presentation of the entire set for auditing.

While this article will not provide an in-depth discussion of OAI-PMH, readers unfamiliar with the protocol may consult MWDL’s public overview of OAI with examples\[[1](https://journal.code4lib.org/articles/#note1)\] or other free OAI-PMH validators and test tools available on the web, such as the Open Archives Initiative Repository Explorer (aka “The Green Tool”)\[[2](https://journal.code4lib.org/articles/#note2)\] or the OAI-PMH Validator and Extractor Tool\[[3](https://journal.code4lib.org/articles/#note3)\].

Use of this tool provides several advantages over traditional metadata auditing workflows. First, as a tool publicly available on the web, it is accessible to MWDL members throughout the collection description process for iterative audits or reviews before they submit a collection for harvest. In using the OAI feed from a repository, the tool provides a “what you see is what you get” window into how collections metadata will be used by the MWDL portal aside from a few metadata transforms and enrichments (for example, adding institution or collection-identifying information fields). Further, non-professional staff can be easily trained to use the tool without needing in-depth knowledge about OAI syntax or learning tools like Oxygen, OpenRefine or R to perform audits. Introduction of the tool shifted the focus of MWDL metadata work from metadata auditing based on a small sampling of records in a particular collection’s OAI feed to precise, comprehensive auditing able to check all records in a collection before harvest.

The original MWDL adaptation of the tool offered the ability to display the mappings of all fields in a set and test a set for required fields in both simple Dublin Core (oai\_dc) and qualified Dublin Core (oai\_qdc) as provided by CONTENTdm. It did not provide the facet viewer that displays frequency of terms. The homepage of the first adaptation is shown in Figure 1:

[![A menu showing the Mapping Checker Simple Dublin Core, the Mapping Checker Qualified Dublin Core for CONTENTdm, the required data checker for simple Dublin Core, and the required data checker for Qualified Dublin Core for CONTENTdm](https://journal.code4lib.org/media/issue41/hebron/Figure1-sm.jpg "Screenshot of the DPLA OAI Aggregation Tools")](https://journal.code4lib.org/media/issue41/hebron/Figure1.jpg)  
**Figure 1.** First MWDL adaptation of metadata tool, launched in 2015

Since the original implementation of the tool, the profile of repositories used by MWDL members has shifted. The addition of Oregon Digital on Samvera (formerly Hydra), the move of one member to Islandora, and the launch of University of Utah’s Solphal repository (a homegrown solution built on Lucene Solr, Phalcon and nginx) necessitated updating and extending the tool to work with OAI-PMH feeds configured differently from those using CONTENTdm.

Further, the entire staff of MWDL has shifted since the tool was initially launched, leaving a large gap in institutional knowledge about original design decisions. When I began my position as the Digital Metadata Librarian at MWDL in January 2018, I saw this as a natural time to assess and evaluate existing tools and workflows.

## Needs Assessment

The foremost driver for adapting the audit tool at this time was the ingest of Oregon Digital’s collections into MWDL. Technical difficulties with harvesting and displaying data in the MWDL portal (using ExLibris Primo) and lack of MWDL staffing contributed to a long onboarding process for Oregon Digital, but by early 2018 these hurdles had been resolved and we were ready to do a large-scale harvest of collections. This necessitated auditing the collections in a more thorough, comprehensive way than had been previously done. Depending on the OAI provision of the source repository, other institutions hoping to adapt this tool will want to undertake similar steps as I did when adapting the tool for Samvera.

Comparing the view of records in the OAI feed from CONTENTdm against Samvera makes it apparent why adaptation was necessary. The following is an example of a single record from Weber State University’s CONTENTdm OAI stream for their Ben Lomond High School Scrapbooks collection (found using the OAI ListRecords command on this set, https://cdm.weber.edu/oai/oai.php?verb=ListRecords&metadataPrefix=oai\_qdc&set=BLHS):

The required Dublin Core fields are enclosed in tags formatted

```
<dc:ELEMENTNAME>
```

with Qualified Dublin Core fields formatted

```
<dcterms:ELEMENTNAME>
```

. This is consistent across CONTENTdm OAI feeds.

For comparison, here is an example of a single record from the Angelus Studio photographs collection in Oregon Digital’s repository (again found using the OAI ListRecords command, https://oregondigital.org/oai?verb=ListRecords&metadataPrefix=oai\_qdc&set=oregondigital:angelus-studio):

Here, all the required Dublin Core fields are enclosed in tags formatted

```
<dcterms:ELEMENTNAME>
```

. The previous MWDL version of the tool cannot parse this feed, resulting in false positives for all required fields. Figure 2 shows a test of the previous required data checker with a collection from Oregon Digital:

[![Required data checker for qualified Dublin Core for CONTENTdm for Oregon Digital is showing that all the required data is missing as is the recommended data](https://journal.code4lib.org/media/issue41/hebron/Figure2-sm.png "Screenshot of required data checker for qualified data finding some errors")](https://journal.code4lib.org/media/issue41/hebron/Figure2.jpg)  
**Figure 2.** Existing required Qualified Dublin Core data checker fails all records

## Updating and Extending the Tool

The first step of the project was to get and analyze the existing code. A serendipitous query about the tool from the American Theological Library Association in early March 2018 kicked off the process of getting the code downloaded to a University of Utah-hosted GitLab, which I then downloaded onto my local machine.

Having never worked with XSL before, I put myself through a crash course on it using the W3School’s XSLT Tutorial. I then used Atom (v1.24.0 x64) to view the existing project and began to analyze its structure. This is when I learned the facet viewer feature had been excluded from the previous MWDL adaptation of the tool. I left this feature until last in my work, as I wasn’t sure I wanted it to be included.

I chose to concentrate first on the required field checker feature, as this gets the most use by MWDL staff when auditing incoming collections. Each feature consists of a PHP page paired with an associated XSL file used to test the data; this pair for the required data checker in Qualified Dublin Core is shown in the red rectangles in Figure 3:

![A screenshot of the directories in which the files are structured. The screenshot highlights the pairing of XSL and PHP files in separate directories.](https://journal.code4lib.org/media/issue41/hebron/Figure3.jpg "Directory structure and paired files")  
**Figure 3.** XSL/PHP file pairs in required data checker

My first step was to clone the index\_oai\_qdc.php file to make a specific landing page for Oregon Digital, index\_oai\_qdc\_ore.php. I updated that file’s page title and headings to reflect this.

Then, I cloned the check\_req\_fields\_qdc.xsl file as check\_req\_fields\_qdc\_ore.xsl and began updating the XSL variable definitions to work with Oregon Digital’s feed:

| 1 | `<``xsl:variable` `name``=``"title"` `select``=``"normalize-space(.//dc:title[1])"``/>` |
| --- | --- |

to

| 1 | `<``xsl:variable` `name``=``"title"` `select``=``"normalize-space(.//dcterms:title[1])"``/>` |
| --- | --- |

I applied the same change for all the required fields, resulting in this set of XSL variable definitions:

| 1  2  3  4  5  6  7  8  9  10  11  12  13 | `<``xsl:for-each` `select``=``"//oai:record"``>`  `<``xsl:if` `test``=``"./oai:header[not(@status)]"``>`  `<``xsl:variable` `name``=``"title"` `select``=``"normalize-space(.//dcterms:title[1])"``/>`  `<``xsl:variable` `name``=``"description"` `select``=``"normalize-space(.//dcterms:description[1])"``/>`  `<``xsl:variable` `name``=``"subject"` `select``=``"normalize-space(.//dcterms:subject[1])"``/>`  `<``xsl:variable` `name``=``"date"` `select``=``"normalize-space(.//dcterms:date[1])"``/>`  `<``xsl:variable` `name``=``"type"` `select``=``"normalize-space(.//dcterms:type[1])"``/>`  `<``xsl:variable` `name``=``"format"` `select``=``"normalize-space(.//dcterms:format[1])"``/>`  `<``xsl:variable` `name``=``"rights"` `select``=``"normalize-space(.//dcterms:rights[1])"``/>`  `<``xsl:variable` `name``=``"creator"` `select``=``"normalize-space(.//dcterms:creator[1])"``/>`  `<``xsl:variable` `name``=``"contributor"` `select``=``"normalize-space(.//dcterms:contributor[1])"``/>`  `<``xsl:variable` `name``=``"spatial"` `select``=``"normalize-space(.//dcterms:spatial[1])"``/>`  `<``xsl:variable` `name``=``"id"` `select``=``"./oai:header/oai:identifier"``/>` |
| --- | --- |

I also added a variable for contributor after analyzing several collections from Oregon Digital and seeing that some collections use creator and others use contributor. Depending on fields required by various metadata profiles or guidelines, other institutions can similarly add or subtract required fields from the variable definitions.

I then analyzed the XSL if tests to make sure they were consistent with the variables. Because I added a variable for contributor, the tests had to be updated in two places:

| 1 | `<``xsl:if` `test``=``"not($title) or not($description) or not($subject) or not($date) or not($type) or not($format) or not($rights) or not($creator) or not($contributor) or not($spatial)"``>` |
| --- | --- |

The column of the table that flags recommended fields is drawn by these tests:

| 1  2  3  4  5  6  7  8 | `<``td``>`  `<``xsl:if` `test``=``"not($creator)"``>`  `<``p``>Creator</``p``>`  `</``xsl:if``>`  `<``xsl:if` `test``=``"not($spatial)"``>`  `<``p``>Spatial</``p``>`  `</``xsl:if``>`  `</``td``>` |
| --- | --- |

As Oregon Digital uses both creator and contributor, I wanted the table to flag a record only if neither was present. After searching Stack Overflow for possible solutions, I changed the above to:

| 1  2  3  4  5  6  7  8 | `<``td``>`  `<``xsl:if` `test``=``"(not($creator)) and (not($contributor))"``>`  `<``p``>Creator/Contributor</``p``>`  `</``xsl:if``>`  `<``xsl:if` `test``=``"not($spatial)"``>`  `<``p``>Spatial</``p``>`  `</``xsl:if``>`  `</``td``>` |
| --- | --- |

I then returned to my new landing page for the Oregon-specific required metadata checker, index\_oai\_qdc\_ore.php. I searched the document for ‘XSL’ to find and update the call for the XSL file to use my newly revised file (lines 6-7):

| 1  2  3  4  5  6  7  8  9  10  11  12 | `$xml` `= ``new` `DOMDocument;`  `if` `(@``$xml``->load(``$feedURL``) === false) {`  `echo` `"<p>Please enter a valid feed URL.</p>"``;`  `} ``else` `{`  `$xsl` `= ``new` `DOMDocument;`  `if` `(``$mp` `== ``'oai_qdc'``) {`  `$xslpath` `= ``'xsl/check_req_fields_qdc_ore.xsl'``;`  `} ``elseif` `(``$mp` `== ``'MODS'``) {`  `$xslpath` `= ``'xsl/check_req_fields_mods.xsl'``;`  `} ``else` `{`  `$xslpath` `= ``'xsl/check_req_fields_dc.xsl'``;`  `}` |
| --- | --- |

I moved on to the mapping checker next. It is structured very similarly to the required data checker, with pairs of PHP and XSL files. I cloned the index\_oai\_qdc.php and extract\_qdc.xsl files in the mapping\_checker folder and set about adapting them to work with Oregon Digital’s OAI feed. Figure 4 shows the base pair of Qualified Dublin Core files in red rectangles:

![A screenshot of the directories in which the files are structured. The screenshot highlights the pairing of XSL and PHP files in separate directories. This is similar to Figure 3, which highlighted different files.](https://journal.code4lib.org/media/issue41/hebron/Figure4.png "Directory structure and paired files")  
**Figure 4.** XSL/PHP file pairs in mapping checker

The mapping checker’s XSL (extract\_qdc.xsl) uses for-each elements to select Dublin Core elements from each record and build a table display of required vs. recommended data:

| 1  2  3  4  5 | `<``td``>`  `<``xsl:for-each` `select``=``"//dc:title"``>`  `<``div` `class``=``'value'``><``a` `target``=``"_blank"` `href``=``"{$oaibase}{$recordbase}{./ancestor::oai:record/oai:header/oai:identifier}"``><``xsl:value-of` `select``=``"."``/></``a``></``div``>`  `</``xsl:for-each``>`  `</``td``>` |
| --- | --- |

As with the required data checker, adapting these for-each elements for Oregon required updating the select statements:

| 1  2  3  4  5 | `<``td``>`  `<``xsl:for-each` `select``=``"//dcterms:title"``>`  `<``div` `class``=``'value'``><``a` `target``=``"_blank"` `href``=``"{$oaibase}{$recordbase}{./ancestor::oai:record/oai:header/oai:identifier}"``><``xsl:value-of` `select``=``"."``/></``a``></``div``>`  `</``xsl:for-each``>`  `</``td``>` |
| --- | --- |

Finally, I had a look at the facet checker. After inspecting it and reading the NCDHC’s documentation, I elected to add the facet checker because it was already coded, didn’t need adaptation, and provides a visual audit tool to help identify inconsistencies in collections. Figure 5 shows a view of subjects used in Utah State Archives’ Salt Lake City (Utah) Fire Department Photographs collection:

[![A screenshot of the DC facet viewer response page in which it shows the URL of the OAI PMH feed from which it has retrieved fields and is showing the field values and counts to indicate each subject is used 74 times](https://journal.code4lib.org/media/issue41/hebron/Figure5-sm.png "Screenshot of DC facet viewer showing the number of times a field appears and its value")](https://journal.code4lib.org/media/issue41/hebron/Figure5.png)  
**Figure 5.** Facet viewer demonstrated using subjects in Utah State Archives’ Salt Lake City (Utah) Fire Department Photographs collection

This demonstrates how the same subject headings have been used consistently across the records, but could also reveal variations in spelling or application that needed remediation.

When I updated the top-level index.php to include the newly coded features, I uncommented the Facet Viewer and moved it to the bottom of the list. The pages are called as list items in an unordered list.

Finally, I updated inc/byline.php; this file is called on each of the tool’s php pages to provide the footer. I added details to reflect the version changes and update the MWDL contact information.

## Technical challenges/Testing

Before making the tool live for member and staff use, I wanted to test it to make sure the updates were working correctly. A colleague suggested using MAMP, a free personal web server program (see sources). University of Utah Library IT support built a virtual machine for me with MAMP installed that was accessible through VMWare Fusion (version 8.5.8).

The testing process was fairly slow, primarily owing to some issues of copying the project file structure from my local machine to the correct root directory in the virtual machine as per MAMP documentation (/Applications/MAMP/htdocs). There seemed to be a glitch with both the menu-based copy-and-paste and drag-and-drop function that should have worked as per VMWare Fusion documentation (see references).

However, once the project had been copied to the virtual machine, I could test it and this resulted in a few rounds of iterative changes to improve aspects of the tool. For example, I realized I had failed to update the if variable for rights to look for “dcterms:rights”, resulting in false positives for missing rights statements in all Oregon records.

I then uploaded the project to the GitLab, created a merge request and notified University of Utah staff we were ready to make the tool live. At this time, we decided to move the tool to a newer server and update its URL from dpla-aggregation.sandbox.lib.utah.edu to mwdlmetadata.tools.lib.utah.edu, a more branded URL indicating its publisher and purpose.

Once the tool was live, further testing revealed a dependency that needed updating for the set-selector to work correctly. A colleague in the Utah Digital Infrastructure Development team helped troubleshoot and made this update, and the tool was fully functional.

## Further changes/extensions needed

After using the new version of the tool to audit collections, I developed a list of future enhancements and cosmetic issues that need further troubleshooting.

First, I realized the recommended field language is missing from the qualified Dublin Core required data checkers. This was true of the original adaptation, so by copying the files, my updated checkers inherited the same flaw.

Highlighting of table headers for recommended fields is also inconsistent in the mapping checker. The tool was originally built to display required fields in bright yellow and recommended fields in pale yellow. For example, I forgot to give the contributor column a CSS class in the mapping checker (extract\_qdc\_ore.xsl) when I added it, resulting in that column header not having any highlighting at all (line 3):

| 1  2  3  4 | `<``th` `class``=``"required"``>Identifier</``th``>`  `<``th` `class``=``"recommended"``>Creator</``th``>`  `<``th``>Contributor</``th``>`  `<``th` `class``=``"recommended"``>Spatial</``th``>` |
| --- | --- |

After using the tool on several collections, I also noticed that the Oregon required data checker draws the table cells for each record, even if nothing is flagged as missing. This is not the case for CONTENTdm collections; while it isn’t bothersome for small collections, it is cumbersome for ones with large numbers of records. At the time of this writing, I haven’t had a chance to troubleshoot why this is happening.

It might also be possible to code a single required data checker for all qualified Dublin Core feeds by using more sophisticated XSL-if statements and variable definitions. However, I have observed a marked performance issue with the Oregon required data checker that I suspect may be due to my combined creator/contributor test; this bears further testing to see if separating them out improves performance and if the tool could be streamlined.

I made a subsequent cosmetic update to reflect the current name of Oregon Digital’s repository (Samvera rather than Hydra) and updated index.php to indicate the Simple Dublin Core required metadata checker also works with University of Utah’s Solphal system as well as Islandora systems. I anticipate future updates following the forthcoming revision of the MWDL MAP in 2018.

## Conclusion

The project to update the metadata tool was ultimately successful, allowing MWDL staff to rapidly audit Oregon Digital’s incoming collections. Between March and April 2018, we harvested over 50 new collections ranging in size from less than 5 records to more than 20,000, and the bulk of the audit process took roughly 2 days. The work was performed by the Metadata Librarian and a part-time undergraduate student worker. Our student metadata assistant began in February 2018 and, with no prior knowledge of or experience auditing library metadata, was able to immediately add value by efficiently delivering feedback about metadata quality. Relying on student workers for first-pass auditing frees the Metadata Librarian for other tasks. Further applications of the tool could include doing internal quality control projects as well as preparing collections for either platform or metadata migrations.

The profile of repositories used by MWDL’s members continues to diversify; as of this writing, an additional two MWDL members are planning moves from CONTENTdm to Islandora, and I envision continual adaptations and refinements of the tool to meet changing member needs.

## Acknowledgements

Huge thanks to Anna Neatrour and Brian McBride at University of Utah for advice, technical assistance, and good humor. A special thanks to the North Carolina Digital Heritage Center for creating the tool and sharing their work, and to Sandra McIntyre for her work on the original MWDL adaptation of the tool.

## About the Author

Teresa K. Hebron is the Digital Metadata Librarian at Mountain West Digital Library, based at the University of Utah in Salt Lake City, UT.

## Footnotes

\[1\] [https://mwdl.org/getinvolved/oai\_queries.php](https://mwdl.org/getinvolved/oai_queries.php) \[[back](https://journal.code4lib.org/articles/#ref1)\]  
\[2\] [http://re.cs.uct.ac.za/](http://re.cs.uct.ac.za/) \[[back](https://journal.code4lib.org/articles/#ref2)\]  
\[3\] [http://validator.oaipmh.com](http://validator.oaipmh.com/) \[[back](https://journal.code4lib.org/articles/#ref3)\]

## References

DPLA OAI Aggregation Tools project Version 1.0 \[Internet\]. \[Updated 2016 May 25\]. North Carolina Heritage Center; \[cited 15 March 2018\]. Available from: [https://github.com/ncdhc/dpla-aggregation-tools](https://github.com/ncdhc/dpla-aggregation-tools)

Gregory L, Williams S. 2014. On Being a Hub: Some Details behind Providing Metadata for the Digital Public Library of America. D-Lib Magazine \[Internet\]. \[Cited May 23, 2018\]; 20:7/8. Available from: [http://www.dlib.org/dlib/july14/gregory/07gregory.html](http://www.dlib.org/dlib/july14/gregory/07gregory.html)

MAMP \[Internet\]. \[Updated 2018\]. appsolute; \[cited 2018 March 18\]. Available from: [https://www.mamp.info/en/](https://www.mamp.info/en/)

MAMP & MAMP Pro 4 Documentation \[Internet\]. \[Updated 2018 May 25\]. appsolute; \[cited 18 March 2018\]. Available from: [http://documentation.mamp.info/](http://documentation.mamp.info/)

McIntyre S. 2015. New Tools for Rapid Auditing of Your Collections \[Internet\]. \[Cited 2018 May 23\]. Available from: [http://mwdlnews.blogspot.com/2015/11/new-tools-for-rapid-auditing-of-your.html](http://mwdlnews.blogspot.com/2015/11/new-tools-for-rapid-auditing-of-your.html)

Mountain West Digital Library Dublin Core Application Profile Version 2.0 \[Internet\]. \[Updated 20 July 2011\]. Mountain West Digital Library Metadata Task Force; \[cited 2018 May 23\]. Available from: [https://mwdl.org/docs/MWDL\_DC\_Profile\_Version\_2.0.pdf](https://mwdl.org/docs/MWDL_DC_Profile_Version_2.0.pdf)

Moving and Copying Files between Virtual Machines and Your Mac \[Internet\]. \[Updated unknown\]. VMWare; \[cited 2018 March 25\]. Available from: [http://pubs.vmware.com/fusion-7/index.jsp?topic=%2Fcom.vmware.fusion.help.doc%2FGUID-3C0EA5DA-98DD-4835-9C84-354472B25303.html](http://pubs.vmware.com/fusion-7/index.jsp?topic=%2Fcom.vmware.fusion.help.doc%2FGUID-3C0EA5DA-98DD-4835-9C84-354472B25303.html)

Neatrour A, Cummings R, McIntyre S. 2016. Regional Aggregation and Discovery of Digital Collections: The Mountain West Digital Library. In: Varnum K, ed. Exploring Discovery: The Front Door to Your Library’s Licensed and Digitized Content. ALA Editions. Available from: [https://collections.lib.utah.edu/details?id=713372](https://collections.lib.utah.edu/details?id=713372)

Testing against one of several values in XSLT? \[Internet\]. \[Updated 2017 December 6\]. Stackoverflow.com; \[cited 2018 March 28\]. Available from: [https://stackoverflow.com/questions/47679280/testing-against-one-of-several-values-in-xslt](https://stackoverflow.com/questions/47679280/testing-against-one-of-several-values-in-xslt)

XSLT Tutorial \[Internet\]. \[Updated Unknown\]. W3Schools.com; \[cited 2018 March 20\]. Available from: [https://www.w3schools.com/xml/xsl\_intro.asp](https://www.w3schools.com/xml/xsl_intro.asp)
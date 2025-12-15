---
title: "Direct Database Access to OCLC Connexion’s Local Save File"
source: "https://journal.code4lib.org/articles/12821"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-10-18
created: 2025-01-10
description: "A feature of OCLC's Connexion cataloging client unknown to most librarians is the ability to directly work with the Microsoft Access database underlying the local save file. This article provides an overview of the metadata made available through this method, including fields that cannot be accessed through the regular Connexion interface, and discusses factors to [...]"
tags:
  - "clippings"
---
# Direct Database Access to OCLC Connexion’s Local Save File
Rebecca B. French

A feature of OCLC’s Connexion cataloging client unknown to most librarians is the ability to directly work with the Microsoft Access database underlying the local save file. This article provides an overview of the metadata made available through this method, including fields that cannot be accessed through the regular Connexion interface, and discusses factors to be considered when deciding whether to migrate the data to another database system instead of continuing to work with Access. Descriptions of three projects illustrate how this functionality has been applied to efficiently catalog a gift collection, find OCLC numbers for e-books, and create bibliographic records for Early English Books Online/Text Creation Partnership titles using data from multiple sources. With the option to rely only on common, off-the-shelf software, this method of directly accessing the local save file database offers a way to expand Connexion’s functionality for those unable or unwilling to work with OCLC APIs. Other benefits include the ability to import external data and to use SQL for more advanced querying. A number of limitations are also discussed, and their implications for metadata access and use are explored.

OCLC’s Connexion desktop client allows catalogers to search for, create, edit, and export bibliographic and authority records both individually and in batch through Connexion’s OML programming language. Although these functions meet the needs of most day-to-day cataloging work, Connexion’s interface makes it difficult or impossible to work with certain data in meaningful or efficient ways for larger projects. Direct database access to Connexion’s local save file offers an underutilized solution to many of these challenges while highlighting a need for simple, flexible, and scalable methods and tools for working with both existing and future metadata systems.

## The Local Save File Database

As its name implies, the local save file is stored on the individual user’s local disk, differentiating it from the online save file, whose contents are available to all users on the network. There are separate save files for bibliographic and authority records. This article focuses on the bibliographic local save file, but the same method can be used with the authority local save file. Connexion’s batch searching function processes a list of search strings, saving the records resulting from each search into the local file. Records can also be added to the local save file individually, without employing a batch search.

The Connexion client displays the contents of the local save file as a list of records with columns for various attributes (Table). For bibliographic records, these fields include title, creator/contributor, OCLC number, format, and holding status.

Table. Fields displayed in Connexion client local save file record list

| **Field** | **Description** |
| --- | --- |
| Save # |  |
| Contributor/Creator |  |
| Title |  |
| Control # | OCLC number |
| Date | Publication date of item |
| Call Number |  |
| Date/Time Added | When the record was added to the local save file |
| Held | “Held” if library holds; blank if not held |
| Code | Library’s holding code |
| Format | Format of material |
| Library | LC, NLM, PCC, etc. |
| Workflow | Workflow status; default is “In Process” |
| Source | Record source (OCLC, Workform, Imported) |
| Delete Holdings | Flagged for action |
| Export | Flagged for action |
| Label | Flagged for action |
| Produce | Flagged for action |
| Replace | Flagged for action |
| Update Holdings | Flagged for action |
| Validate | Flagged for action |
| Submit | Flagged for action |
| My Status | Status set by user |
| CatL | Language of cataloging |

While the holding status of an item in the user’s library is included in the results list display, the number of libraries that hold the item is only displayed upon opening an individual record. Viewing a list of all libraries with holdings set on a particular record requires opening an additional screen found through menu options in the single record view.

The inadequacy of only displaying holdings data one record at a time becomes clear when considering that the use of batch searching means that the user is dealing with a sufficient quantity of records such that individual processing is neither desirable nor effective. For example, librarians have expressed a need to be able to view the number of holding libraries for all items in a given list of OCLC numbers, which would facilitate weeding and other collection management projects \[[1](https://journal.code4lib.org/articles/#id1)\]\[[2](https://journal.code4lib.org/articles/#id2)\]\[[3](https://journal.code4lib.org/articles/#id3)\]. In addition, what is available through the client interface is just a display, and the holdings data is not actionable. That is, it is not possible to search on or sort a results list or save file by number of holdings, and because this metadata is not part of the MARC record it is not available through export.

Some of the data that is difficult to work with through the Connexion client interface is saved as part of the database underlying the local save file. By default, its location is C:\\Documents and Settings\\\[user name\]\\Application Data\\OCLC\\Connex\\Db \[[4](https://journal.code4lib.org/articles/#id4)\]. The file is a JET database with extension .db and can be opened using Microsoft Access, thus providing access to additional metadata that is not included in Connexion’s display. The database contains tables with metadata about the records in the local save file as well as information about the most recent batch search used to retrieve records.

The database comprises 15 tables. Three of these, tblBatchSearch, tblRecords, and tblSaveFile, contain data that is likely to be of interest to users (Fig. 1).

![Figure 1: Fields in tblSaveFile, tblBatchSearch, and tblRecords](https://journal.code4lib.org/media/issue38/french/figure1.png) **Figure 1**: Fields in tblSaveFile, tblBatchSearch, and tblRecords

tblSaveFile contains all of the data that is shown when viewing the contents of the local save file in Connexion. This includes the save file number, contributor/creator, title, OCLC number, holding status, format, language of cataloging, and whether the record has been flagged for batch actions like validate, replace, export, and update or delete holdings. tblSaveFile also contains additional fields that are not presented in the results list in Connexion, although they may be viewable elsewhere in the Connexion interface. For example, the Holdings Count field in tblSaveFile is not displayed as a column in Connexion’s save file results list and can only be viewed in the display of an individual record.

tblBatchSearch includes the search strings used, the total number of records returned for each search, and the OCLC number, save file number, and title for each record found. The contents of each record in the save file are stored in XML format in tblRecords.

## Benefits

The simplest application of directly opening the local save file database in Microsoft Access is exporting a database table, which can be done as a tab- or comma-delimited text file, Excel spreadsheet, or various other formats. Getting the holdings count for each item in a list of OCLC numbers can easily be achieved through exporting tblSaveFile. With the list of tables visible on the left side of the Access window, right click on tblSaveFile, choose “Export,” and select the desired file format (Fig. 2). Click “OK” in the next window to finish the export. Because this process takes only a few clicks, it is accessible even to those with no experience using Access or databases.

![Figure 2: Exporting tblSaveFile from Microsoft Access](https://journal.code4lib.org/media/issue38/french/figure2.png) **Figure 2**: Exporting tblSaveFile from Microsoft Access

Beyond simply exporting holdings counts or other metadata, this method for accessing the local save file provides additional, more powerful possibilities that take advantage of database relationships, the ability to add in external data, and querying capabilities using Access or SQL. Many of the tables include an ID field, which can be used as a primary or foreign key to establish relationships between the tables. When first opening the database in Access, the ID fields of tblBatchSearch and tblSaveFile are not explicitly linked, but I have had no problems running queries with that relationship not specifically established. External data can also be added as a separate table; however, a relationship will need to be set up between an existing table and the imported table in order for Access to accurately query that data. For example, a spreadsheet containing local bibliographic record numbers and batch search strings can be joined on the Search Key field in the tblBatchSearch table, allowing the local record numbers to be queried and displayed along with OCLC’s data. Queries provide a way to refine the result set and can be created using Microsoft Access’s Query Wizard or Query Design view, or using SQL. Results can be exported in a variety of common formats. When used together, these database functions provide greater flexibility in creating and customizing data output.

Making holdings data available for use and the querying capabilities of the database format are not the only benefits of this method. It should not be overlooked that it requires nothing more than OCLC’s Connexion client and Microsoft Access, a piece of software commonly available as part of the Microsoft Office productivity suite. Therefore, it is not likely to require the purchase of new software, a boon for cash-strapped institutions. While the most basic uses of this method, such as exporting data to a spreadsheet, require no special skill or training in Microsoft Access, those with more familiarity with either Access or SQL will be able to apply their skills to manipulate the available data in more complex ways. This method’s low barrier to entry combined with its accommodation of more advanced data manipulation techniques is a significant asset that contributes to its flexibility.

## Limitations

Despite these advantages, this method also has drawbacks which limit its usefulness in certain situations. The most significant of these limitations relate to the scalability and inflexibility of this approach. The database format in which the file is saved can only be opened by tools that can read Microsoft Access’s data format. For that reason, users will have to choose between continuing to use Access or migrating the data elsewhere. If moving to another database management system, all needed tables must be exported individually.

In the simplest use cases, such as exporting data from one of the database tables, there is no need to migrate data out of Access because no querying or manipulation is required. For those with additional skills in Access but little experience with other database management systems, doing further querying in Access is likewise warranted. On the other hand, those with more familiarity with another database system may find it more effective to migrate the data. Multiple save file databases can be combined into one while migrating, and the data could also be added to an existing database. Although Access can execute SQL queries, I have occasionally struggled with doing so due to not being familiar with some of the syntax Access uses. In these cases I was able to easily formulate the desired SQL queries in an SQLite database despite not being able to get them working in Access. In the Early English Books Online project described later, I chose to move to an SQLite database both for ease of querying and to combine multiple databases.

One advantage mentioned earlier is the availability of holdings count data; however, the specific holding libraries are not included as part of the database, so this is only a partial solution to certain holdings-related needs if knowing specific libraries is desired. Because the local save file is not updated in real time as changes are made to records in OCLC’s database, the information being manipulated in Access may not match the current status of the production database. This negates the value of looking up the list of holding libraries when needed, as the count and composition of that list may have changed since the records were added to the local save file.

Accessing and working with data from the local save file often necessitates rather lengthy and inflexible workflows. A single mistake often prevents all future steps from working correctly and requires repeating work if the mistake is not identified immediately. A specific example of this I encountered when cataloging the jazz LP collection (a project described in more detail below) occurred when I wanted to change the batch search strings to limit the results to English language of cataloging records. Because I was using the search strings to join external data with the local save file database, making that change would have required starting over from the beginning with a new batch search, reimporting the external data, reestablishing database relationships, and rerunning queries. In this case I chose to continue with the original searches but learned to take more time coming up with precise searches before getting further into a project.

Working with the local save file database means doing a search or searches (whether individually or in batch) in Connexion to add records to the local save file and then often doing additional querying within Access or another database management system. Using holdings data in a query, for example, means running an initial batch search in Connexion and then a second query to further select records with holdings count as an additional criterion. If holdings data was indexed and searchable in OCLC, these two queries could be combined into one. In other situations using more complex SQL or Access queries, running multiple queries may be unavoidable, but using holdings data is one area where this duplication could be avoided through modifications to OCLC’s current indexing.

Some of the inflexibilities of this approach also contribute to scalability problems. Application of this method is greatly limited by the size of the local save file, which can contain no more than 9,999 records \[[4](https://journal.code4lib.org/articles/#id4)\]. This may not be large enough for many projects, especially depending on the batch search strings used and the number of results returned per search. The Early English Books Online project described below required six save files in order to end up with a final set of approximately 25,000 records. This is a significant way in which this approach does not scale easily. It is possible to create additional local save files or run multiple batches to fill up the save file many times, but then all the subsequent steps of linking tables and running queries must be done for each database individually, as each local save file will be a separate .db file. A related issue is that the batch search data available in tblBatchSearch only includes the most recent batch search. If the first batch does not fill the local save file, running a second batch to append more records to the same file will remove the first batch’s search strings from the database, making them unavailable for querying. As the search strings are often the link between the save file contents and external data, this is rarely an acceptable solution. Many of these limitations are understandable given that the database was likely never intended to be accessed directly, but they highlight a number of important considerations for the design of future systems.

The following case studies illustrate ways in which the database functionality and availability of holdings count data enabled three diverse projects while also showing some ways of working with this method’s limitations.

## Cataloging a Gift Collection of Jazz LPs

Over 25 years ago, the James Madison University Music Library received a donation of approximately 3,500 jazz LPs, most of which were gifts from the local radio station. At that time, brief records consisting of a title, performer or composer, publisher name and number, and an accession-based call number were entered into the JMU Library Catalog for each item. The Music Library had closed stacks until very recently, so this brief metadata provided the only possibility for patrons to discover these items. In an effort to increase the visibility and use of this collection, I investigated ways to efficiently acquire more robust bibliographic records for these items.

Using the minimal metadata recorded in the existing brief records, a Music Library staff member created search strings for the items and entered them into a spreadsheet that also contained local bibliographic record numbers. Most of the searches were based on publisher and publisher number, as this was the most unique identifying information in the existing metadata. All search strings were also limited by material type (mt:lps). I ran a subset of the searches and then used pre-determined criteria to winnow the results in the Connexion local save file with the items in hand. Records were evaluated on the 245, 260, 300, 028, and fixed fields only. The selected bibliographic record was left in the local save file and all unwanted records were removed, leaving either one or no records for each search string. The entire local save file was exported in MARC format.

I then opened the local save file in Microsoft Access. The spreadsheet of search strings and bibliographic record numbers was imported into the database and linked to tblBatchSearch on the Search Key field. A query displaying the local record number and the OCLC number was created, and then MarcEdit’s Merge Records function was used to insert the local bibliographic numbers into the MARC records. I loaded the records into our Sierra ILS using a custom load table that matched on bibliographic record number, preserved the call number found in the brief record, and replaced all other existing metadata with the full incoming record.

One of the main advantages of starting with pre-selected batch searches is that it facilitated the process of selecting a matching record. Automating the searches saved time over performing each search individually, and I was then presented with a limited number of choices in the local save file to evaluate. Using the local save file database to match up OCLC numbers and local bibliographic record numbers minimizes human error, as does the use of a custom load table to prevent manually reinserting call numbers into the records. One drawback to this workflow is that the “best” OCLC record may be missed in the batch search, although I deemed it unlikely that the fullest record for an item would have missing or incorrect publisher or title information. However, the goal of this project was to improve the fullness of the available metadata, not to find a complete full-level record for each item. Given that aim, even a minimal or core level record was considered acceptable, as it provided more metadata than was currently in our catalog and thus increased the discoverability of this collection. We have used this method to catalog approximately 1,000 LPs so far and plan to compare usage statistics after the metadata has been enhanced for the entire collection.

## E-Book OCLC Numbers

Some e-books purchased by JMU Libraries come with vendor-supplied bibliographic records that lack OCLC numbers. In order to set holdings for these items, a matching OCLC record must be found and the OCLC number inserted into the vendor records. In order to eliminate the time-consuming process of searching for each title one-by-one in OCLC, I decided to use batch searching with searches derived from metadata in the records. Instead of manually selecting the best match from the results returned (as was done with the jazz LPs), I identified the number of holdings as a good indicator for the best match. The use of the PCC’s provider-neutral guidelines for e-resources \[[5](https://journal.code4lib.org/articles/#id5)\] makes it likely that many libraries will be setting holdings on the same record even if they provide access to the e-book through different platforms. In addition, many duplicate e-book records have only a few holdings. These duplicates are often less-than-full records added by batchload (ELvl M) and are therefore likely the result of inaccurate algorithmic matching rather than an intentionally created record for a distinct manifestation.

After performing batch searches for a set of e-books, looking through each record in the local save file for the record with the most holdings per title would have been time-consuming and tedious. Instead, opening the local save file as a database provided access to the holdings count in an actionable way. I created a query that selected the record with the highest number of holdings per search key and output the OCLC number of that record along with the vendor’s record number, which had been added to the database as external data. I used MarcEdit to convert the OCLC and vendor record numbers into stub MARC records and then merged them into the records in our ILS using a custom load table that matched on the record number and inserted the OCLC number.

After getting familiar with this workflow and which e-book collections required this treatment, I revised the process to add the OCLC numbers into the vendor records (matching on the vendor’s control number) before loading them into our ILS. Merging in the OCLC numbers with MarcEdit allowed for consolidation of this step with other pre-load editing done in MarcEdit, and it further simplified the workflow by eliminating the need for a custom load table.

## Early English Books Online/Text Creation Partnership Records

Early English Books Online (EEBO) is a corpus of digital images of early printed materials dating from 1473 to 1700 that is available as a subscription database through ProQuest \[[6](https://journal.code4lib.org/articles/#id6)\]. The Text Creation Partnership (TCP) has been transcribing the EEBO texts and encoding them in XML \[[7](https://journal.code4lib.org/articles/#id7)\]. The first phase of the EEBO-TCP partnership involved approximately 25,000 texts, and those XML-encoded versions were released into the public domain on January 1, 2015.

In an effort to add more public domain materials to our library catalog, I was tasked with investigating whether we could find or create bibliographic records for these titles with links to the XML full text. ProQuest sells MARC records for EEBO, but these records only contain URLs for the digitized images and not the TCP XML documents. Many records are also available in OCLC in both microform and electronic formats. However, these records also do not include the TCP texts. The Text Creation Partnership provides an SGML document containing various identification numbers for all of the Phase I titles, including their TCPid numbers and ProQuest’s image ID numbers that are used in the EEBO URLs. The URLs for the TCP landing pages can be derived from the TCPid. This made it possible to add the URLs for the XML documents based on the EEBO URLs that were in the available OCLC records. Because JMU subscribes to EEBO, we decided to keep the image URLs in our records along with the added TCP URLs.

The next step was to find an OCLC record for each EEBO title. I derived search strings from the EEBO ID numbers that also formed part of the URL, resulting in one search string per title. Due to the local save file’s 9,999-record limit, searches were run in batches of 4,900 because most searches returned one or two records. This resulted in six local save file databases. For some titles, both microform and electronic resource records were returned by the batch search. Other titles were found in only one format, and some titles had duplicate records within the same format. Because we wanted records to represent the digitized images and text, a record in electronic resource format was preferred. When no such record existed for a title, I modified a microform record to create an electronic resource record. I chose the following criteria for narrowing the search results to one record per title:

1\. If only one record is returned for a search, use that record regardless of format.

2\. If there is more than one result for a search and all records are for the microform format, select the record with the largest number of holdings.

3\. If there is more than one result for a search and not all records are for the microform format, select the electronic resource record with the most holdings.

In attempting to design queries for these three scenarios in Microsoft Access, I found myself not familiar enough with Access’s implementation of SQL and decided to move the data to an SQLite database (using the SQLite Manager add-on for Firefox \[[8](https://journal.code4lib.org/articles/id8)\]) to allow for more straightforward querying. Not all of the local save file database contents were needed, so I exported only the search string, total record count (the number of records returned for a search), ID (save file number), holdings count, OCLC number, and title data, consolidating it all into a single table. Moving to another database system also provided the opportunity to combine the six individual databases into one, increasing the efficiency of the rest of the project.

After migrating to the SQLite database, I first identified whether each record was a microform using the general material designation “microform” found in the title field, and then summed the number of microform records that had been returned for each search key (Script 1). A second query displayed the microform count together with the fields from the table (Script 2). With that information, I was able to run queries for each of the three scenarios described above (Scripts 3, 4, and 5, respectively) to select the records to be used and then export those records from Connexion.

**Script 1**

```
CREATE VIEW "microCountPerSearchKey" AS SELECT [Search Key], SUM(micro) AS microCount
FROM
(SELECT [Search Key], [Total Records], Title, CASE WHEN Title LIKE '%microform%' THEN '1' ELSE '0' END AS micro
FROM eebo) GROUP BY [Search Key]
```

**Script 2**

```
CREATE VIEW "eeboWithMicroCount" AS SELECT eebo.[Search Key], eebo.[Total Records], microCountPerSearchKey.microCount, eebo.ID, eebo.[Holdings Count], eebo.[OCLC Number], eebo.Title
FROM eebo JOIN microCountPerSearchKey
ON eebo.[Search Key] = microCountPerSearchKey.[Search Key]
```

**Script 3**

```
SELECT * FROM eeboWithMicroCount
WHERE [Total Records] = 1
```

**Script 4**

```
SELECT [Search Key], [Total Records], microCount, ID, MAX([Holdings Count]) AS MaxHoldingsCount, [OCLC Number], Title
FROM (SELECT * FROM eeboWithMicroCount WHERE [Total Records] != 1 AND [Total Records] = microCount)
GROUP BY [Search Key]
```

**Script 5**

```
SELECT [Search Key], [Total Records], microCount, ID, MAX([Holdings Count]) AS MaxHoldingsCount, [OCLC Number], Title
FROM (SELECT * FROM eeboWithMicroCount
WHERE [Total Records] != 1 AND [Total Records] != microCount AND Title NOT LIKE '%microform%')
GROUP BY [Search Key]
```

The final step was inserting the TCP URLs into the records. I turned the IDs in TCP’s SGML document into stub MARC records using MarcEdit. An 856 field with URL was derived from the TCPid, and the EEBO ID was placed in a 999 field and used as a match point for merging the TCP URLs into the main file of records. After some final cleanup, which included altering all format coding to reflect the electronic nature of these items, I loaded approximately 25,000 records with links to both the EEBO digitized images and XML-encoded full text into the JMU Library Catalog.

## Conclusion

Direct database access to OCLC Connexion’s local save file offers catalogers a way of working with OCLC metadata beyond the standard Connexion client interface. Although the WorldCat Search and Metadata APIs provide another way to interact with OCLC’s data, not all libraries have the available staff time or experience to work with them. Accessing the local save file database directly provides an additional option that is easier to use and that requires only common software. It is unique in being the only way to access holdings count data in an actionable manner, and the additional querying options provided by the database format are another beneficial expansion of Connexion’s functionality. Its limitations highlight a need not only for low-barrier methods of working with OCLC data but also for making more of that data available in flexible and scalable ways. The three case studies described here illustrate that such access can enable a variety of metadata projects and can be a useful addition to a metadata practitioner’s toolkit.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] McCormick E to OCLC-CAT mailing list. 2014 May 22. Getting holdings for a file of records? \[email\].

\[[2](https://journal.code4lib.org/articles/#ref2)\] McCallum R to OCLC-CAT mailing list. 2016 July 12. Re: other library’s holdings \[email\].

\[[3](https://journal.code4lib.org/articles/#ref3)\] McNally R to OCLC-CAT mailing list. 2016 July 21. Check OCLC holdings by batch \[email\].

\[[4](https://journal.code4lib.org/articles/#ref4)\] OCLC Connexion Client Guides: Basics: Manage Local Files. 2014. Dublin, OH: OCLC; \[accessed 2017 Aug 8\]. [https://www.oclc.org/content/dam/support/connexion/documentation/client/basics/localfiles/localfiles.pdf](https://www.oclc.org/content/dam/support/connexion/documentation/client/basics/localfiles/localfiles.pdf)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Provider-neutral e-resource MARC record guidelines. 2013. Washington, D.C.: Program for Cooperative Cataloging; \[accessed 2017 Aug 8\]. [https://www.loc.gov/aba/pcc/scs/documents/PCC-PN-guidelines.html](https://www.loc.gov/aba/pcc/scs/documents/PCC-PN-guidelines.html)

\[[6](https://journal.code4lib.org/articles/#ref6)\] About Early English Books Online. 2016. Ann Arbor: ProQuest; \[accessed 2017 Aug 8\]. [https://eebo.chadwyck.com/about/about.htm](https://eebo.chadwyck.com/about/about.htm)

\[[7](https://journal.code4lib.org/articles/#ref7)\] Text Creation Partnership. 2017. Ann Arbor: Text Creation Partnership; \[accessed 2017 Aug 8\]. [http://www.textcreationpartnership.org/](http://www.textcreationpartnership.org/)

\[[8](https://journal.code4lib.org/articles/#ref8)\] lazierthanthou. 2015. Sqlite-manager. \[accessed 2017 Aug 8\]. [http://lazierthanthou.github.io/sqlite-manager/](http://lazierthanthou.github.io/sqlite-manager/)

## About the Author

Biography: Rebecca B. French is Metadata Analyst Librarian at James Madison University.  
Email: [frenchrb@jmu.edu  
](https://journal.code4lib.org/articles/)URL: [http://orcid.org/0000-0002-3771-8601](http://orcid.org/0000-0002-3771-8601)
---
title: "Using XSLT’s SQL Extension with Encyclopedia Virginia"
source: "https://journal.code4lib.org/articles/6486"
author:
  - "[[The Code4Lib Journal]]"
published: 2012-02-03
created: 2025-01-10
description: "This paper explores how to integrate data across a hybrid relational database and XML-based management system. It examines specifically how XSLT's SQL extension can be used to communicate information between SQL tables and TEI-conformant XML documents to make data-centric content more manageable and flexible and thereby leverage the strengths of both systems. In what follows, [...]"
tags:
  - "clippings"
---
# Using XSLT’s SQL Extension with Encyclopedia Virginia
Matthew Gibson

This paper explores how to integrate data across a hybrid relational database and XML-based management system. It examines specifically how XSLT’s SQL extension can be used to communicate information between SQL tables and TEI-conformant XML documents to make data-centric content more manageable and flexible and thereby leverage the strengths of both systems. In what follows, one will learn about some of the methods, benefits, and shortcomings of XSLT’s SQL extension in the context of Encyclopedia Virginia, an open access publication of the Virginia Foundation for the Humanities that utilizes a suite of digital humanities and digital library XML vocabularies such as TEI and METS.

## Background and Context

### ­­­­­­­Some Questions

So why and when would one want to mix XSLT—arguably one of the most powerful languages for performing XML transformations—with SQL expressions, a language for talking to, managing, and extracting information from a relational database? Having cut my own XML teeth beginning in 1998 marking up and managing the markup of electronic texts at the University of Virginia Library, I embraced a poor assumption that mixing XML and relational databases didn’t make much sense. Why, I thought at the time, would you want to store richly structured information—information that, in some ways, was its own self-described and self-contained relational database—*inside* of a relational database management system? It just seemed redundant and not really keeping with the spirit of what XML was about: platform independent content that could be read and generally understood by humans and easily manipulated by machines.

My approach and view of XML during this time was less that it was an efficient and consistent way to transport data and more that it provided the rules by which I could describe complexly structured literary texts with accurate structural and semantically rich markup. I was an XML purist: disdainful of textual projects that did not employ XML applications in their production and reluctant to see and imagine the strengths and improved flexibility that mixing XML and XML tools with other environments and systems—such as a Relational Database Management System (RDBMS)—could yield for content and data.

### A Hybrid Publication System

In 2005, I started developing and building *Encyclopedia Virginia* (*EV*), a digitally-born, open access publication of the Virginia Foundation for the Humanities that explores the history and culture of the state of Virginia. Bringing to this project all of my XML biases and experiences, I decided that all encyclopedia entries—i.e. the textual essays—in *EV* would conform to the TEI (Text Encoding Initiative) P5 guidelines\[[1](https://journal.code4lib.org/articles/#note1)\] and that all media—still and moving images, and audio files—would be described using different metadata standards inside of a METS (Metadata Encoding and Transmission Standard) wrapper. Thus the content structure of an entry and that entry’s relationship to other entries and other objects (e.g. media, external URLs, etc.) would be defined and “preserved” in the deeper hierarchies of the XML to allow for the content’s portability to different platforms and contexts.

While much of the semantic and mixed content markup that XML affords might get lost, or might be more difficult to reconstruct from a pure RDBMS environment, there are other data and workflow requirements for *Encyclopedia Virginia* that make an XML/MySQL hybrid publication system a better solution than what a pure XML database option might provide. The strengths that an RDBMS provides for *EV* are:

- version control over every piece of content that goes into the encyclopedia;
- one-to-many relationship management of, for instance, one author and/or editor to many articles, one chronological event referenced by many articles, and one media object shared by many articles;
- and, most importantly, more efficient and scalable performance in looking up and retrieving data.

A very generalized view of *Encyclopedia Virginia*‘s publication workflow for an entry looks something like this:

1. XSLT transforms word processed and edited entry to TEI P5-compliant XML
2. PHP shreds TEI into appropriate MySQL tables (e.g. authors, editors, events, and geolocations) but retains the canonical and intact XML document for future editing and versioning

### A SQL Challenge for XSLT

Although all of *EV*‘s content is stored in and delivered from a LAMP (Linux, Apache, MySQL, and PHP) platform, the original TEI documents that are ingested into the MySQL tables are created and normalized with a series of XSL transformations before the PHP/MySQL processing takes place. Over time we have realized that in the TEI there are several structures that are better stored and managed through MySQL and that, instead of describing those in the XML, it is more efficient and consistent to point to unique keys in the database that represent that content.

One challenge, in particular, was how TEI might reference authors. Because *EV* publishes the affiliation of each author and because we want that information to be consistent across, say, multiple entries that a single author might write, marking up that text across multiple TEI documents can lead to variability. What is more, if a given author contributes a large number of articles and her affiliation needs to change, it is difficult to manage that change over multiple files. In the past, marking up an author across TEI documents might look something like this (Figures 1 & 2):

**Figure 1. TEI snippet: “Divorce in Early Virginia Indian Society”**

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14 | `<``teiHeader``>`  `<``fileDesc``>`  `<``titleStmt``>`  `<``title``>Divorce in Early Virginia Indian Society</``title``>`  `<``respStmt``>`  `<``resp``>Contributor</``resp``>`  `<``persName``>`  `<``forename``>John</``forename``>`  `<``surname``>Doe</``surname``>`  `<``affiliation``>professor of history at Collegiate University</``affiliation``>`  `</``persName``>`  `</``respStmt``>`  `</``TEI``>` |
| --- | --- |

**Figure 2. TEI snippet: “Pocahontas”**

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `<``teiHeader``>`  `<``fileDesc``>`  `<``titleStmt``>`  `<``title``>Pocahontas (d. 1617)</``title``>`  `<``respStmt``>`  `<``resp``>Contributor</``resp``>`  `<``persName``>`  `<``forename``>John</``forename``>`  `<``surname``>Doe</``surname``>`  `<``affiliation``>professor emeritus of history at Collegiate University and author of <``hi` `rend``=``"italic"``>Love and Death in the Virginia Colony</``hi``> (1990) and <``hi` `rend``=``"italic"``>Hard Times for Early Virginia Coloniasts</``hi``> (2005)`  `</``affiliation``>`  `</``persName``>`  `</``respStmt``>`  `</``TEI``>` |
| --- | --- |

Between these two entries by John Doe, the author’s affiliation has changed. While one could certainly reflect these changes consistently in the XML with a little searching, cutting and pasting, we decided it would be much easier and more modular to control the author’s relationship to his biography and to the entries he contributed by inputting and storing that information directly in the SQL database. Thus if we had to change any of the fields related to that author, such as his affiliation, we would do it once, and those changes would be reflected in all of the entries that he wrote. Thus each of the entry snippets above would, before being published, look like this (Figure 3):

**Figure 3. TEI snippet: “Pocahontas” with pointer to primary index in author table**

| 1  2  3  4  5  6  7  8  9 | `<``teiHeader``>`  `<``fileDesc``>`  `<``titleStmt``>`  `<``title``>Pocahontas (d. 1617)</``title``>`  `<``respStmt``>`  `<``resp``>Contributor</``resp``>`  `<``name` `key``=``"195"``/>`  `</``respStmt``>` |
| --- | --- |

where the result in the author table with primary index matching “195” contains the following (Figure 4):

**Figure 4. Result from SQL table of author with with a primary index of 195**

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `*************************** 1. row ***************************`  `contributor_id: 195`  `salutation: Dr.`  `first_name: John`  `last_name: Doe`  `middle_name: D.`  `bio: professor emeritus ``of` `history ``at` `Collegiate University ``and` `author`  `of` `<em>Love ``and` `Death ``in` `the Virginia Colony</em> (1990) ``and` `<em>Hard`  `Times ``for` `Early Virginia Coloniasts</em> (2005)` |
| --- | --- |

With the reference now made consistently across all entries written by John Doe, we can pick and choose which values we want to display and how we want to display them. However, the missing piece here was how we would get that reference to the author into the XML itself. If we still valued keeping the XML intact for future portability, we had to figure out a way to retain the relationship between the TEI file and the author’s key in the database. And the challenge, of course, was to get those keys into the XML in an automated way. Because we use XSLT to transform, test, and normalize all of our XML before we publish it, we looked at Saxon’s XSLT SQL extension as a logical solution to create this relationship.

## The Saxon SQL Extension

While Xalan—the Apache project’s XSLT processor—has an SQL extension library, because our production process uses features of XSLT 2.0 we turned to the Saxon processor’s SQL extension library. (NB: while you can run Saxon’s SQL extension with command-line parameters, all work below is done in the environment of oXygen’s XML Editor.)

### Prerequisites

To get the Saxon SQL extension up and running and talking to your database you need several things:

- The Java Database Connectivity (JDBC) driver for whatever database you are running—in our case it is [MySQL](https://www.mysql.com/products/connector/).
- The saxon-sql.jar (recent releases of oXygen come prebundled with this)
- A configuration file that allows oXygen to see the saxon-sql.jar for validation and processing.
- Appropriate credentials (i.e. username and password) to access the database with which you want to communicate and that your database server is configured to be accessed by remote machines.

### XSLT SQL elements

Saxon’s SQL extension defines five new XSL elements for interacting with a database that are all bound to the “sql” namespace: sql:connect, sql:query, sql:insert,

sql:column, and sql:close. I actually don’t recommend using sql:insert and sql:column very much since injecting XML data into what, typically, is the more controlled environment of a relational database introduces too much variability and presents possibilities to really cause some chaos.

The other three sql elements work as such:

**<sql:connect>** establishes, as you might have guessed, the connection to the database and the attributes that it takes (driver, database, user, and password) provide the information that will validate the connection.

**<sql:query>** does the real work for us here. It performs the query on the database and writes the results of the query to the result tree. While there are six attributes for sql:query, the main ones we use are:

- table—which defines the name of the table to be queried. This attribute is mandatory.
- column—defines the name of the column or columns to be retrieved. Using “\*” as the value of the column attribute selects all columns. This attribute is also mandatory.
- where—defines the conditions to be applied in a given selection. This is optional.

**<sql:close>** closes the sql connection.

### An XSLT Example: authors2sql.xsl

Given these elements—and the snippets from Figures 1 and 2 above as our source tree—let’s look at a sample of XSLT code that places these elements in context:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94 | `<?``xml` `version``=``"1.0"` `encoding``=``"UTF-8"``?>`  `exclude-result-prefixes``=``"xs"`  `<``xsl:output` `method``=``"xml"` `encoding``=``"UTF-8"` `indent``=``"yes"``/>`  `<``xsl:param` `name``=``"driver"` `select``=``"'org.gjt.mm.mysql.Driver'"``/>`  `<``xsl:param` `name``=``"database"` `select``=``"'jdbc:mysql://DATABASEURL/DATABASENAME'"``/>`  `<``xsl:param` `name``=``"user"` `select``=``"'USERNAME'"``/>`  `<``xsl:param` `name``=``"password"` `select``=``"'PASSWORD'"``/>`  `<``xsl:template` `match``=``"//tei:titleStmt/tei:respStmt"``>`  `<``xsl:message``>Connecting to database...</``xsl:message``>`  `<``sql:connect` `driver``=``"{$driver}"` `database``=``"{$database}"` `user``=``"{$user}"` `password``=``"{$password}"``>`  `<``xsl:fallback``>`  `<``xsl:message` `terminate``=``"yes"``>Connection to MySQL failed.</``xsl:message``>`  `</``xsl:fallback``>`  `</``sql:connect``>`  `</``xsl:variable``>`  `<``xsl:message``>Connected...</``xsl:message``>`  `<``xsl:variable` `name``=``"fname"` `select``=``"normalize-space(tei:persName/tei:forename)"``/>`  `<``xsl:variable` `name``=``"lname"` `select``=``"normalize-space(tei:persName/tei:surname)"``/>`  `<``xsl:variable` `name``=``"dbase_lname"``>`  `<``sql:query` `connection``=``"$connection"` `table``=``"contributors"` `where``=``"last_name='{$lname}' and first_name='{$fname}'"` `column``=``"last_name"``/>`  `</``xsl:variable``>`  `<``xsl:variable` `name``=``"dbase_fname"``>`  `<``sql:query` `connection``=``"$connection"` `table``=``"contributors"` `where``=``"last_name='{$lname}' and first_name='{$fname}'"` `column``=``"first_name"``/>`  `</``xsl:variable``>`  `<``xsl:variable` `name``=``"contrib-table"``>`  `<``sql:query` `connection``=``"$connection"` `table``=``"contributors"` `where``=``"last_name='{$lname}' and first_name='{$fname}'"`  `column``=``"*"``/>`  `</``xsl:variable``>`  `<``xsl:variable` `name``=``"contribid"``>`  `<``sql:query` `connection``=``"$connection"` `table``=``"contributors"` `where``=``"last_name='{$lname}' and first_name='{$fname}'"`  `column``=``"contributor_id"``/>`  `</``xsl:variable``>`  `<``xsl:message``>First name: <``xsl:copy-of` `select``=``"$fname"``/></``xsl:message``>`  `<``xsl:message``>Last name: <``xsl:copy-of` `select``=``"$lname"``/></``xsl:message``>`  `<``xsl:message``>Table: <``xsl:copy-of` `select``=``"$dbase_lname"``/></``xsl:message``>`  `<``xsl:message``>Contrib ID: <``xsl:copy-of` `select``=``"$contribid"``/></``xsl:message``>`  `<``xsl:choose``>`  `<``xsl:when` `test``=``"tei:name"``>`  `<``xsl:copy-of` `select``=``"."``/>`  `</``xsl:when``>`  `<``xsl:when` `test``=``"matches($contrib-table, $lname) and matches($contrib-table, $fname)"``>`  `<``xsl:value-of` `select``=``"tei:resp"``/>`  `</``resp``>`  `<``xsl:attribute` `name``=``"key"``>`  `<``xsl:copy-of` `select``=``"$contribid"``/>`  `</``xsl:attribute``>`  `</``name``>`  `</``respStmt``>`  `</``xsl:when``>`  `<``xsl:otherwise``>`  `</``xsl:otherwise``>`  `</``xsl:choose``>`  `<``sql:close` `connection``=``"$connection"``/>`  `</``xsl:template``>`  `</``xsl:stylesheet``>` |
| --- | --- |

## Summary

Despite these drawbacks, if a situation arises that requires information interchange between an XML-formatted document and a relational database, XSLT’s SQL extension can bridge these two platforms that describe information and information relationships in very different ways. What is more, when a project’s needs require leveraging the strengths of XML and a relational database—when managing and delivering information necessitates a hybrid solution between complex XML description and structure and a relating data efficiently—XSLT can remain a powerful tool in your suite of options for working with XML content.

\[[1](https://journal.code4lib.org/articles/#ref1)\] The P5 specification was in the process of being created during this period. The official release came about in 2007.

## About the Author

Matthew Gibson is Director of Digital Programs at the Virginia Foundation for the Humanities (VFH). He holds a Ph.D. in English from the University of Virginia. Prior to joining the VFH in 2005, Matthew served as Associate Director of the University of Virginia Library’s Electronic Text Center. At the VFH, he oversees Encyclopedia Virginia, a digital publication about Virginia history and culture; provides supervision and support for Documents Compass, a Mellon- and NHPRC-funded initiative to facilitate digitization and interoperability between documentary editions; and guides the short- and long-term planning for the organization’s digital efforts and scholarly communications. Matthew has a multitude of conference presentations and several publications to his credit, mostly in the field of digital library standards. For the past nine years he has taught week-long XML application building workshops as an independent consultant and for the Association of Research Libraries.  
URLs: [http://virginiahumanities.org](http://virginiahumanities.org/) and [http://encyclopediavirginia.org](http://encyclopediavirginia.org/).
---
title: "Using XML Schema with Embedded Schematron Rules for MODS Quality Control in a Digital Repository"
source: "https://journal.code4lib.org/articles/13546"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-08-09
created: 2025-01-10
description: "The Michigan State University Libraries Digital Repository relies primarily on MODS descriptive metadata to convey meaning to users and to improve discoverability and access to the libraries’ unique information resources. Because the repository relies on this metadata for so much of its functionality, it’s important that records are of consistently high quality. While creating a [...]"
tags:
  - "clippings"
---
# Using XML Schema with Embedded Schematron Rules for MODS Quality Control in a Digital Repository
Lisa Lorenzo

The Michigan State University Libraries Digital Repository relies primarily on MODS descriptive metadata to convey meaning to users and to improve discoverability and access to the libraries’ unique information resources. Because the repository relies on this metadata for so much of its functionality, it’s important that records are of consistently high quality. While creating a metadata guidelines document was an important step in assuring higher-quality metadata, the volume of MODS records made it impossible to evaluate metadata quality without some form of automated quality assessment. After considering several possible tools, an XML Schema with embedded Schematron rules was ultimately chosen for its customizability and capabilities. The two tools complement each other well: XML Schemas provide a concise method of dictating the structure of XML documents and Schematron adds more robust capabilities for writing detailed rules and checking the content of XML elements and attributes. By adding the use of this Schema to our metadata creation workflow, we’re able to catch and correct errors before metadata is entered into the repository.

## Introduction and context

Galleries, libraries, archives, and museums (GLAM) rely on high quality metadata to make their collections discoverable and understandable by their users. Metadata quality is also a crucial precursor to emerging tools and technologies for search and discovery, such as linked data and machine learning. A future where users can leverage linked data to discover resources with a common attribute across institutions (“How many university libraries have oral histories about World War II available online?”) requires consistent description. Emerging efforts to automate subject assignment for electronic resources relies on record sets with accurate subject analysis to serve as teaching sets for algorithms. Further, organizations such as the Digital Public Library of America (DPLA) also rely on high quality and consistent metadata in order to develop their aggregation platform.

Metadata standards and best practices abound, and a great deal of work has been done in the GLAM community to assess how well those standards, whether international, national, or institution-specific, are met. The Digital Library Federation (DLF) Metadata Assessment Working Group \[[1](https://journal.code4lib.org/articles/#n1)\] and the DPLA’s metadata analysis tools \[[2](https://journal.code4lib.org/articles/#n2)\] are but two examples. While more tools are becoming available for assessing metadata, it is still a challenge to choose metrics that are appropriate and meaningful to the particular institution and a method of assessment that is sustainable and integrable into existing workflows. What follows is a description of how the Michigan State University Libraries (MSUL) digital repository team approached this challenge and how it uses the chosen method, XML Schema and Schematron, to ensure metadata quality.

## MSUL Digital Repository

The MSUL Digital Repository is a freely available collection of digitized and born-digital content covering a variety of topics and media. The repository is built on Fedora with an Islandora front-end and uses MODS as its descriptive metadata. Indexing is done with Apache Solr.

Collections come to the repository from a variety of different locations, including MSU graduate students and faculty, library grant projects, and donations. Unsurprisingly, metadata is in a range of formats and of varying quality when it reaches the repository team. From there, the metadata librarians on the team convert the metadata into XML if necessary, enhance and correct information as needed, and create an XSLT to transform the source XML metadata into MODS records.

In order to normalize metadata over the entire collection, the repository team put together a set of metadata guidelines in 2016. The creation of this document was an important first step in a collection-wide metadata normalization effort that took place over the course of 2017 and guided metadata creation for new collections ingested into the repository. However, the guidelines alone weren’t enough to ensure consistent metadata quality in the entire collection. While XSLTs were updated to reflect the new guidelines, due to the volume of records in the digital repository, it was still impossible to ensure that every individual record conformed to the guidelines. Errors resulting from mistakes in source metadata, such as incorrect date formats or improperly formatted URIs, would often go unnoticed unless they caused a Solr error during indexing or happened to be seen when browsing repository content.

The repository team’s metadata librarians evaluated a few tools that might address these issues, namely OpenRefine \[[3](https://journal.code4lib.org/articles/#n3)\] and Metadata Breakers \[[4](https://journal.code4lib.org/articles/#n4)\]. OpenRefine, an open source tool for cleaning up messy data, is a powerful tool with many functionalities. It boasts subject and name reconciliation capabilities, support for regular expressions through General Refine Expression Language (GREL), and ability to edit large numbers of records at once. Its widespread use in the GLAM community was also attractive due to the large user base that could potentially be tapped for guidance. However, importing a hierarchical metadata scheme such as MODS into OpenRefine proved to be overly cumbersome. The Python-based Metadata Breakers set of tools was helpful for getting a sense of certain problems within the metadata. It worked well in areas such as showing field usage within a collection, but wasn’t designed for identifying problems in each individual record. This is an important functionality when working with, for instance, electronic theses and dissertations metadata. The original metadata for this collection comes from individual authors and can vary widely, and may require remediation of individual records. Additionally, the repository team’s metadata librarians’ relatively low comfort level with Python meant customizing this tool would require too much of a time investment for this project.

GLAM institutions often use XML Schemas as validation tools for XML-based metadata and definitions for metadata standards. While validation documents of course don’t offer the editing ability that OpenRefine does, their customizability and extensive capabilities, when extended with additional languages, made them an attractive solution for MSUL. Oxygen XML Editor \[[5](https://journal.code4lib.org/articles/#n5)\], the software used by the repository team for creating and transforming metadata, has a very simple process for running XML Schemas, making it easy to add one extra step to the existing metadata workflow. While learning a new language was time-consuming at first, the metadata librarians’ strong familiarity with XML, XPath, and XSLT helped a great deal, making the process of creating a custom XML Schema relatively intuitive. The next sections will provide an overview of what the MSUL repository team considers the most helpful features of XML Schema Definition (XSD) and Schematron.

## XML Schema Definition

XSD is a human- and machine-readable language maintained by the World Wide Web Consortium (W3C) for expressing constraints on XML documents.  An XML Schema specifies how and in what order data appears in an XML document. It can provide a list of allowed elements and attributes, specify how many times each can appear within the document and whether they are required or optional, and define the datatype of each element and attribute.

While these capabilities make XSD a flexible and powerful tool for validating XML documents, it fell short of expressing constraints on several XML features that were necessary for determining the quality of MODS records. For example, while XSD can declare that an element or attribute is required, it cannot express a more complex requirement like a dependency, such as “**<mods:url>** may contain either a **usage** or an **access** attribute, but not both.”  XSD also cannot express co-occurrence constraints, or rules about which elements may occur together. This means that a rule such as “if **<mods:name>** contains an **authority** attribute, then it must also contain an **authorityURI** attribute” cannot be defined in XSD.

In fact, XSD is not designed to satisfy every possible validation scenario. As stated in its purpose, “the language defined by this specification does not attempt to provide all the facilities that might be needed by any application. Some applications may require constraint capabilities not expressible in this language, and so may need to perform their own additional validations” (W3C 2004). To this end, XSD is easily extensible. Embedding rules from other validation languages, such as Schematron, is as simple as adding them to an **<xs:annotation>** element, as shown in the “Validating content with Schematron” section.

## Schematron

Schematron is a rules-based XML validation language and an open ISO standard \[[6](https://journal.code4lib.org/articles/#n6)\]. It uses XPath to locate nodes within XML documents and then displays a natural language error message written by the creator of the Schematron document. It is quite flexible and simple in structure, and there are a number of ways to accomplish any validation task.

While Schematron provides a concise way to test the content of elements and attributes, it is less straightforward than XSD for defining the structure of an XML document (Obasanjo 2004).

## Implementation

Given the strength of XSD in concisely defining the structure of an XML document and Schematron’s ability to handle conditional requirements and co-occurrence constraints, the team decided to create an XSD with embedded Schematron rules. The following section describes how each tool was used within the context of a MODS validation. Some examples are given throughout, and the entire schema can be found on GitHub \[[7](https://journal.code4lib.org/articles/#n7)\].

### Defining structure with XSD

XSD is an extremely complex validation language with many capabilities that are out of scope for this article. What follows is a very brief overview of the portions of the XSD language that have been most useful at MSUL.

XSD defines two categories of elements: simple types and complex types. Simple types include elements that contain only text, attributes, and restrictions (a list of allowed values for an element). Complex types include elements that contain other elements or attributes. The author of the schema defines the constraints on each individual complex type that may exist in a valid XML document. The **<xs:complexType>** element can contain an **<xs:choice>** element that gives a list of possible child elements for an element or an **<xs:sequence>** element that gives a list of child elements in the order in which they must occur in the XML document. Both **<xs:choice>** or **<xs:sequence>** will contain a list of references to elements that are defined elsewhere in the schema. Each **<xs:element>** can contain optional **maxOccurs** and **minOccurs** attributes which define the maximum and minimum number of times the element can occur. If not explicitly defined, the default value for **maxOccurs** is “unbounded” and for **minOccurs** is “1”.  Each **<xs:attribute>** element may contain a **use** attribute that defines whether the attribute is optional or required.

XSD further defines a list of data types that restrict the type of content allowed in XML elements or attributes. Some examples are **<xs:string>** which can contain characters, spaces, returns, and so on, **<xs:date>** which can contain a date in YYYY-MM-DD format, and **<xs:decimal>** which can contain numeric values. The W3C defines a complete list of XSD data types \[[8](https://journal.code4lib.org/articles/#n8)\].

In the following partial example from the MSUL digital repository MODS schema, the **<mods:name>** element is defined. It contains a sequence of three child elements, **<mods:namePart>** (which must occur at least once, but can occur any number of times), **<mods:titleInfo>** (which can occur one time or not at all), and **<mods:role>** (which also must occur at least once, but can occur any number of times). It also contains a required attribute, **type**, which has the type **xs:string**. Finally, it contains an optional **usage** attribute, which may only contain the **xs:string** value, “primary”.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 | `<``xs:element` `name``=``"name"``>`  `<``xs:complexType``>`  `<``xs:sequence``>`  `<``xs:element` `ref``=``"mods:namePart"` `minOccurs``=``"1"` `maxOccurs``=``"unbounded"``/>`  `<``xs:element` `ref``=``"mods:titleInfo"` `minOccurs``=``"0"` `maxOccurs``=``"1"``/>`  `<``xs:element` `ref``=``"mods:role"` `minOccurs``=``"1"` `maxOccurs``=``"unbounded"``/>`  `</``xs:sequence``>      `  `<``xs:attribute` `name``=``"type"` `use``=``"required"` `type``=``"xs:string"``/>`  `<``xs:attribute` `name``=``"usage"``>`  `<``xs:simpleType``>`  `<``xs:restriction` `base``=``"xs:string"``>`  `<``xs:enumeration` `value``=``"primary"``/>`  `</``xs:restriction``>`  `</``xs:simpleType``>`  `</``xs:attribute``>`  `<``xs:attributeGroup` `ref``=``"mods:authority-attributes-optional"``/>`  `</``xs:complexType``>`  `</``xs:element``>` |
| --- | --- |

### Validating content with Schematron

Six elements make up the basic structure of a Schematron document: **<schema>**, **<ns>**, **<pattern>**, **<rule>**, **<assert>**, and **<report>**. The **<schema>** element is the root of the document, and **<ns>** and **<pattern>** are its child elements. The **<ns>** element defines any namespaces used in the document. A **<pattern>** element contains one or more **<rule>** elements. The **<pattern>** element works like an if/then statement: only the first **<rule>** that matches a node in the XML being tested will execute (if rule 1 matches a node, execute its child elements, if not, try to match rule 2, and so on). The **<rule>** element contains a context attribute that specifies an XPath. This defines where in the XML document to search for the XPath statements in its child **<assert>** and **<rule>** elements. The **<assert>** element specifies an XPath in its **test** attribute and plain text within the element that will be displayed to the user if the **test** assertion is false. For example, if the **test** attribute contains a simple XPath, the presence of that node is what’s being tested. So, the following:

| 1  2  3 | `<``sch:rule` `context``=``"mods:mods"``>`  `<``sch:assert` `test``=``"mods:titleInfo"``>There is no title.</``sch:assert``>`  `</``sch:rule``>` |
| --- | --- |

checks for a **<mods:titleInfo>** element as a child of **<mods:mods>** in the XML document being validated. If the element is not present, the error message “There is no title” will display in the error report. Any valid XSLT functions and expressions may be used in a **test** attribute.

The **<report>** element functions in the same way as assert, but is its inverse. Where **<assert>** will return its error message if its test is false, **<report>** will return its statement if its test is true. For example:

| 1  2  3 | `<``sch:rule` `context``=``"mods:dateIssued"``>`  `<``sch:report` `test``=``"contains(text(),'u'"``>Date contains "u". Change to "x".</``sch:report``>`  `</``sch:rule``>` |
| --- | --- |

This rule checks **<mods:dateIssued>** for the “u” character, and if it is present gives the user the message “Date contains ‘u’. Change to ‘x’.”

Rules may also be written outside of a specific context, known as abstract rules. The advantage of abstract rules is that the author of the schema only needs to write them once and then may call them in any context, eliminating the need to rewrite the same rule multiple times. This partial example from the MSUL MODS Schema shows an abstract rule that tests whether an element contains a trailing period, and then calls that rule on the **<mods:namePart>** element with **<sch:extends>**:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `<``sch:pattern``>`  `<``sch:rule` `abstract``=``"true"` `id``=``"trailing-punct"``>`  `<``sch:assert` `test``=``"not(ends-with(.,'.'))"``>`  `Check <``sch:name``/> for trailing punctuation.`  `</``sch:assert``>`  `</``sch:rule``>`  `</``sch:pattern``>`  `<``sch:pattern``>`  `<``sch:rule` `context``=``"mods:namePart"``>`  `<``sch:extends` `rule``=``"trailing-punct"``/>`  `</``sch:rule``>`  `</``sch:pattern``>` |
| --- | --- |

One other important aspect of this example is the **<sch:name/>** element in the content of **<sch:assert>**. This will print the name of the context node in the error report if the assertion comes back as true. So, in this example when the rule is called on **<mods:namePart>**, the error would read “Check mods:namePart for trailing punctuation.”

Schematron can be used on its own or embedded into an XSD, as MSUL has done. Adding Schematron rules to an XSD is as simple as entering the rule within **<xs:annotation>** and **<xs:appinfo>** in the element declaration where the rule will take effect. The above example for **<mods:namePart>** would be called in an XSD like so:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 | `<``xs:element` `name``=``"namePart"``>`  `<``xs:annotation``>`  `<``xs:appinfo``>`  `<``sch:pattern``>`  `<``sch:rule` `abstract``=``"true"` `id``=``"trailing-punct"``>`  `<``sch:assert` `test``=``"not(ends-with(.,'.'))"``>`  `Check <``sch:name``/> for trailing punctuation.`  `</``sch:assert``>`  `</``sch:rule``>`  `</``sch:pattern``>`  `<``sch:pattern``>`  `<``sch:rule` `context``=``"mods:namePart"``>`  `<``sch:extends` `rule``=``"trailing-punct"``/>`  `</``sch:rule``>`  `</``sch:pattern``>`  `</``xs:appinfo``>`  `</``xs:annotation``>`  `</``xs:element``>` |
| --- | --- |

### Workflow

A variety of software, both open source \[[9](https://journal.code4lib.org/articles/#n9)\] and proprietary, is available for validating XML with XSD and Schematron. Since the MSUL digital repository team already uses Oxygen XML Editor to create and transform metadata, it made the most sense to validate metadata with this software as well. Running XSD validations with embedded Schematron rules in Oxygen is very simple \[[10](https://journal.code4lib.org/articles/#n10)\] and can be done by right clicking a file or a directory in the project pane and clicking “Validate with Schema.” From there, the user simply has to navigate to the correct XSD file and select the option to include embedded Schematron rules. Oxygen generates a list of errors and displays it in a new pane, or indicates that validation was successful. If the user ran the validation on multiple files, the list of errors is divided by file name.

For the MSUL digital repository, a metadata librarian will run the schema against every new collection before it’s ingested. After reviewing the list of errors, the reviewer will decide how to address them. Typically, if an error is widespread, it is solved by adjusting the XSLT that transformed the original source metadata into MODS. For instance, referring to an earlier example, if the validation found a series of records where unknown or uncertain dates were systematically entered with ‘u’ instead of ‘x’, a simple replace() function could be added to the XSLT and solve the issue each time it appears.  Isolated or minor errors, such as a missing author name, are usually fixed in the source metadata.

In order to address errors in legacy collections, the schema was run against all collections in the digital repository over the course of several months. The resulting error reports were used to improve the XSLT documents for each collection and create new metadata records, which were then ingested into the digital repository.  With the changes that were made, metadata records now conform with local standards, allowing more consistent display between collections. This also facilitated sharing repository metadata with the DPLA and the MSU Libraries’ discovery layer, ultimately making repository resources discoverable in more environments.

## Future Work

While XSD and Schematron are effective tools for validating document structure, validation of content contained in elements and attributes is mainly limited to structural checks. Spell checking and name and subject reconciliation are two areas in particular where the metadata quality control workflow could be improved. Future areas of work for the repository team include taking a closer look at tools such as OpenRefine and Metadata Breakers. For example, OpenRefine’s reconciliation tools may be useful in converting local subject headings to FAST headings, the preferred subject vocabulary for digital repository collections.

## Bibliography

Obasanjo D. 2004. Improving XML document validation with Schematron \[Internet\]. \[cited 2018 June 4\]. Available from:[https://msdn.microsoft.com/en-us/library/aa468554.aspx](https://msdn.microsoft.com/en-us/library/aa468554.aspx).

Piez W, Lapeyre D. 2008. Introduction to Schematron \[Internet\]. \[cited 2018 June 6\]. Available from: [http://www.mulberrytech.com/papers/schematron-Philly.pdf](http://www.mulberrytech.com/papers/schematron-Philly.pdf).

Robertsson E. 2010. Combining Schematron with other XML Schema languages \[Internet\]. \[cited 2018 June 4\]. Available from: [http://www.topologi.com/resources/schtrn\_xsd\_paper.html](http://www.topologi.com/resources/schtrn_xsd_paper.html).

W3C (World Wide Web Consortium). 2004. XML Schema part 1: structures second edition \[Internet\]. \[cited 2018 June 5\]. Available from: [https://www.w3.org/TR/xmlschema-1/#intro-purpose](https://www.w3.org/TR/xmlschema-1/#intro-purpose).

XSD – Quick Guide \[Internet\]. c2018. \[cited 2018 June 4\]. Available from: [https://www.tutorialspoint.com/xsd/xsd\_quick\_guide.htm](https://www.tutorialspoint.com/xsd/xsd_quick_guide.htm).

## Notes

\[[1](https://journal.code4lib.org/articles/#t1)\] For more information, see: [http://dlfmetadataassessment.github.io/](http://dlfmetadataassessment.github.io/)  
\[[2](https://journal.code4lib.org/articles/#t2)\] Available here: [http://openrefine.org](http://openrefine.org/)  
\[[3](https://journal.code4lib.org/articles/#t3)\] Available here: [https://github.com/dpla/Metadata-Analysis-Workshop](https://github.com/dpla/Metadata-Analysis-Workshop)  
\[[4](https://journal.code4lib.org/articles/#t4)\] Available here: [https://github.com/cmh2166/metadataQA](https://github.com/cmh2166/metadataQA)  
\[[5](https://journal.code4lib.org/articles/#t5)\] Available here: [https://www.oxygenxml.com](https://www.oxygenxml.com/)  
\[[6](https://journal.code4lib.org/articles/#t6)\] For more information, see: [http://schematron.com/2016/11/iso-schematron-2016-released/](http://schematron.com/2016/11/iso-schematron-2016-released/)  
\[[7](https://journal.code4lib.org/articles/#t7)\] Available here: [https://github.com/lmlorenzo/mods-schema](https://github.com/lmlorenzo/mods-schema)  
\[[8](https://journal.code4lib.org/articles/#t8)\] Available here: [https://www.w3schools.com/xml/schema\_dtypes\_string.asp](https://www.w3schools.com/xml/schema_dtypes_string.asp)  
\[[9](https://journal.code4lib.org/articles/#t9)\] One open source tool available for running XSD and Schematron validations is SchemAnon, available here: [https://github.com/TheLanguageArchive/SchemAnon](https://github.com/TheLanguageArchive/SchemAnon). This tool was not evaluated for this project.  
\[[10](https://journal.code4lib.org/articles/#t10)\] Video tutorial available here: [https://www.oxygenxml.com/demo/Schematron\_Validation.html](https://www.oxygenxml.com/demo/Schematron_Validation.html)

## About the Author

Lisa Lorenzo is a metadata librarian at Michigan State University Libraries working primarily with the library’s digital repository metadata. She is a member of an Agile development team working to improve and expand the MSUL digital repository and is responsible for transforming metadata from various sources and formats into standards-compliant MODS and Dublin Core to facilitate searching within the repository and metadata reuse in other systems, such as the Digital Public Library of America (DPLA). Lisa’s recent projects undertaken with her colleagues on the development team include normalizing MODS records across all collections in the repository, updating and implementing local metadata guidelines documentation, and dynamically generating JSON-LD metadata as part of an experimental search engine optimization initiative. She also has a quarter-time appointment as a reference librarian.
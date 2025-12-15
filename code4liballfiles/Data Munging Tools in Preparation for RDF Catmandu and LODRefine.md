---
title: "Data Munging Tools in Preparation for RDF: Catmandu and LODRefine"
source: "https://journal.code4lib.org/articles/11013"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-10-20
created: 2025-01-10
description: "Data munging, or the work of remediating, enhancing and transforming library datasets for new or improved uses, has become more important and staff-inclusive in many library technology discussions and projects. Many times we know how we want our data to look, as well as how we want our data to act in discovery interfaces or [...]"
tags:
  - "clippings"
---
# Data Munging Tools in Preparation for RDF: Catmandu and LODRefine
Christina Harlow

Data munging, or the work of remediating, enhancing and transforming library datasets for new or improved uses, has become more important and staff-inclusive in many library technology discussions and projects. Many times we know how we want our data to look, as well as how we want our data to act in discovery interfaces or when exposed, but we are uncertain how to make the data we have into the data we want. This article introduces and compares two library data munging tools that can help: LODRefine (OpenRefine with the DERI RDF Extension) and Catmandu.

The strengths and best practices of each tool are discussed in the context of metadata munging use cases for an institution’s metadata migration workflow. There is a focus on Linked Open Data modeling and transformation applications of each tool, in particular how metadataists, catalogers, and programmers can create metadata quality reports, enhance existing data with LOD sets, and transform that data to a RDF model. Integration of these tools with other systems and projects, the use of domain specific transformation languages, and the expansion of vocabulary reconciliation services are mentioned.

## Introduction

With the expansion of digital and physical library platforms, as well the increasing need to both migrate and work with metadata between these platforms, library data munging has increased in importance. Library data munging or wrangling—defined here as the work of remediating, enhancing, and transforming library datasets—creates a better understanding of the state of metadata and supports a more flexible and interoperable data ecosystem. Resting at the intersection of library metadata, data modeling, and scripting, data munging can require specific but varied skills. The need to wrangle data as well as the number of skills required for efficient and accurate data work has increased along with the growing number of institutions beginning to experiment with and migrate to Resource Description Framework (RDF) modeled data.\[[1](https://journal.code4lib.org/articles/#note1)\]\[[2](https://journal.code4lib.org/articles/#note2)\]

Described here are some tools that support a team with many different skillsets to perform library data munging and work with RDF data. Two such tools are discussed in this article: LODRefine and Catmandu. Both freely-available, open-source data tools help make data wrangling easier, although they solve different problems. Because of this and the nature of data work\[[3](https://journal.code4lib.org/articles/#note3)\], a person will probably use both of these tools for varying use cases. They are introduced here within the context of a data munging and migration workflow currently used at the University of Tennessee Knoxville (UTK) Libraries.

## Metadata Munging Workflow Context(s)

At UTK, we are migrating most of our MARC and non-MARC metadata and objects into new platforms. For digital collections, this involves going from a variety of platforms to either an instance of Islandora or to a yet to be determined, Fedora-based platform for a new institutional repository. For the MARC catalog, UTK moved recently from Aleph to Alma, involving the migration of some bibliographic records built for Aleph-specific local procedures (such as acquisitions stubs). Now we need to review the migrated data to remove some defunct data practices and review possibilities for enhancements.

To start this work, we first created UTK metadata documentation, including interoperable metadata application profiles (MAPs) for the various platforms. The following, primarily descriptive-focused metadata workflow provides an overview of the work done to update, remediate, and support data consistency. Part of this workflow includes generating reports that check and show the state of the original metadata, the changes made, and how these changes will improve discoverability. There was also the need to build a workflow that includes a wider number of internal stakeholders than has been involved before in metadata migration work – such as the content specialists that created the original metadata, catalogers who are re-skilling for working more with non-MARC and batch metadata, and digital library developers who want to pull new-to-them metadata schema into indexing engines and platforms. These workflow steps also address preparation for RDF by both reconciling data with authority datasets available as Linked Open Data as well as producing RDF descriptive metadata for experimentation and educational purposes. Catmandu and LODRefine have become an essential part of this workflow.

## LODRefine/OpenRefine

### Background

OpenRefine (formerly Google Refine) is a tool that has gained a lot of traction in library data work in the past few years. Built originally by David Huynh and Metaweb Technologies, it has gone through a number of changes until in 2012 it became OpenRefine, an entirely community-sourced project.\[[4](https://journal.code4lib.org/articles/#note4)\] One can read more about the tool, how to get involved, and any new developments on the OpenRefine GitHub repository, on the OpenRefine website, or from the OpenRefine Twitter account.\[[5](https://journal.code4lib.org/articles/#note5)\]\[[6](https://journal.code4lib.org/articles/#note6)\]\[[7](https://journal.code4lib.org/articles/#note7)\]

OpenRefine is described as “a power tool that allows you to load data, understand it, clean it up, reconcile it, and augment it…”.\[[8](https://journal.code4lib.org/articles/#note8)\] Built in Java with Jetty, OpenRefine runs locally, with editing occurring in a web-browser-based interface built with Javascript and jQuery, and all project data and associated work is stored locally and managed by Jetty. Along with the data munging abilities built into OpenRefine, there are also a growing number of community-sourced extensions that can be added.

Discussed here is the DERI RDF Extension developed by researchers at the Linked Data Research Centre, part of the former Digital Enterprise Research Institute (now the Insight Centre for Data Analytics) in Galway, Ireland.\[[9](https://journal.code4lib.org/articles/#note9)\]\[[10](https://journal.code4lib.org/articles/#note10)\] A fork of OpenRefine, called LODRefine, comes with these DERI RDF extensions and a few others included in the install.\[[11](https://journal.code4lib.org/articles/#note11)\] At the time of the writing of this article, LODRefine as well as the DERI RDF Extension are no longer being actively developed, however they are still widely used. LODRefine is primarily what is used in the examples given below.

### Getting Started with OpenRefine/LODRefine

There are a number of ways to install LODRefine. For the most recent version of OpenRefine, follow the instructions on the OpenRefine GitHub Wiki.\[[12](https://journal.code4lib.org/articles/#note12)\] The download for the DERI RDF Extension discussed here can be found on the DERI Refine site; follow the instructions on the wiki to install it as an extension in OpenRefine.\[[10](https://journal.code4lib.org/articles/#note10)\]\[[13](https://journal.code4lib.org/articles/#note13)\] Alternatively, LODRefine can be installed as a single unit from its GitHub repository.\[[11](https://journal.code4lib.org/articles/#note11)\] Since hosted versions of OpenRefine do not provide all the functionalities described below, each person at UTK works with LODRefine installed locally on their computer(s)

There is great documentation on the OpenRefine GitHub wiki and elsewhere on the web for getting started with the core features of OpenRefine/LODRefine.\[[14](https://journal.code4lib.org/articles/#note14)\]\[[15](https://journal.code4lib.org/articles/#note15)\] The real strength of OpenRefine/LODRefine is that it gives the user a graphical user interface (GUI) for data normalization, enhancement, and mapping to JSON, XML and RDF (and other). This allows users with less comfort working in a command line interface (CLI) or scripting to still be involved in the data munging workflow. Additionally, the OpenRefine/LODRefine GUI is built for browsing and visual review of metadata fields for data outliers and errors. LODRefine offers ways to perform data value clustering; batch edits using a domain-specific language called Google Refine Expression Language (GREL); remediation against external datasets available via API, RDF document, or SPARQL endpoint; and the ability to build an RDF export skeleton for exporting each record as a node in a RDF graph serialized as N-Triples or RDF/XML.

In the context of this workflow, a weakness of LODRefine is that the user must convert existing metadata to a tabular model for working in LODRefine, then back into the preferred data model and format for the new platform or datastore. There are also performance issues for working with larger and more complex datasets (based on experiences at UTK, this generally means ~50k MODS records as a maximum) in LODRefine or for local document reconciliation work. Additionally, working through similar mappings, review, or data transformations requires many steps in the GUI. This is where Catmandu supplements and builds out the data munging workflow from LODRefine.

## Catmandu

### Background

Catmandu is a data tool developed as part of the LibreCat project.\[[16](https://journal.code4lib.org/articles/#note16)\] The LibreCat project aims to create library data workflows that can be consistently applied to different datastores, data types, and platforms within libraries – in particular, the similar but platform-dependent data munging needs of institutional repositories, digital collections, and more traditional library data workflows. Catmandu, the core of the LibreCat project, is an open source, freely-available suite of library data wrangling modules currently supported and developed primarily by three European universities – the Universities of Lund, Gent and Bielefeld – and a team of developers.\[[16](https://journal.code4lib.org/articles/#note16)\]

Catmandu works via command line interface or in Perl scripting, both giving the user access to various Perl modules for working with library data. Catmandu works using an Extract-Transform-Load (or ETL, popular with many big data/data warehouse tools) workflow. This workflow is built to interact with items, the term for a basic unit of data in Catmandu, like so:

- **Extract:** A variety of Catmandu importer modules extract data from remote sources and either import the data into an application or store it locally.
- **Transform:** The user can then review, enhance, and transform that data using routines built off of the Catmandu-specific Fix language. The Fix language is a key component to Catmandu that was built to allow non-metadata specialists to perform data munging.
- **Load:** The data extracted and transformed using Fix routines can then be ingested into a datastore, whether indexing engine, database, or other.

Catmandu currently offers modules for pushing data to a datastore like MongoDB \[[17](https://journal.code4lib.org/articles/#note17)\] or an indexing engine like ElasticSearch \[[18](https://journal.code4lib.org/articles/#note18)\]; pulling data from or exposing data via OAI-PMH \[[19](https://journal.code4lib.org/articles/#note19)\] or via SRU \[[20](https://journal.code4lib.org/articles/#note20)\]; and pushing data into platforms such as DSpace \[[21](https://journal.code4lib.org/articles/#note21)\] or Fedora \[[22](https://journal.code4lib.org/articles/#note22)\]. For more information on working with Catmandu, the LibreCat Catmandu online handbook is recommended.\[[23](https://journal.code4lib.org/articles/#note23)\] Installation instructions for Catmandu are available there.\[[24](https://journal.code4lib.org/articles/#note24)\]

### Getting Started with Catmandu

Because Catmandu is a suite of Perl modules, the core installation is getting the Catmandu CPAN module, along with all dependencies, installed in the working environment.\[[25](https://journal.code4lib.org/articles/#note25)\] Alternatively, there is a virtual machine with Catmandu installed available for download from the LibreCat blog\[[26](https://journal.code4lib.org/articles/#note26)\], and there is a Docker image of a recent build of Catmandu available from the Docker Repositories Registry.\[[27](https://journal.code4lib.org/articles/#note27)\] The user may need to install additional modules beyond Catmandu for other data format- or platform-specific functionalities. For those not using a virtualization option, install the CPAN Task::Catmandu module, which comes with a set of recommended Catmandu modules included.

While Catmandu can be used in Perl scripts or via a command line interface (CLI), the following workflow takes advantage primarily of the latter. Working in the CLI, users can configure their local installation of Catmandu or specific Catmandu projects to have default datastores, formats, importers, exporters, or other options; this just requires saving a Catmandu configuration YAML file in the project’s directory.\[[28](https://journal.code4lib.org/articles/#note28)\] The developers of Catmandu created a very helpful cheat sheet for working with Catmandu in a CLI which can be used to review commands discussed below.\[[29](https://journal.code4lib.org/articles/#note29)\]

The strengths of Catmandu are pulling data from a variety of platforms or sources, relatively easy conversion of these datasets to different formats better suited for different parts of a munging workflow, easy report generation, and ability to use the Fix language, a Catmandu-specific data wrangling language, in ETL processes. The Fix language works with paths that refer to specific parts of a data record or item, uses specified functions to edit that data, and can use conditionals and/or binds to better specify when to apply edits. Fixes are meant to be used for easy data manipulation by non-programmers, and can be run in-line or via a saved fix file. The formal Fix language grammar is given in the Catmandu::Fix::Parser module, and the Fixes Cheat Sheet contains a condensed summary.\[[30](https://journal.code4lib.org/articles/#note30)\]\[[31](https://journal.code4lib.org/articles/#note31)\]

The Fix language is not used heavily at present in the following UTK data munging workflow, as most of the normalization, enhancement, and remediation work is done by content specialists and catalogers in LODRefine. This is because LODRefine offers a user-friendly GUI and more external data remediation options at present. A consideration for UTK in using Catmandu is that it requires knowledge of the CLI, bash, and/or Perl scripting basics; this creates a workflow involving people with many different technology comfort areas as well as vastly different original metadata sets. There is a goal to expand use of Catmandu and lessen the use of LODRefine as metadata sets are normalized and the enhancement work needing more manual/visual review is completed, while concurrently some of the cataloging staff reskills to become more comfortable with the CLI and using scripts.

## Data Wrangling Workflow

### Import/Pull Data

Some UTK (soon-to-be) legacy platforms either do not give the option for a full data dump/export or the platform-supported data export methods creates poor-quality data (i.e. invalid XML feeds).Thus, for non-MARC metadata, UTK uses standard OAI-PMH feeds (built with PKP Harvester) as the default option for extracting descriptive metadata. The OAI-PMH DC/XML descriptive metadata records are pulled and checked to make sure there is a consistent method for linking the record to other parts of the digital object, in most cases, the digital asset file stored on one of the digital collection servers. Most of the non-MARC datasets were created in ‘collections’ that have various meanings according to the platform and the project. What collections share, however, is that the metadata can follow different standards, interpretations, and guidelines according to a number of factors (some unknown). Much of the UTK metadata migration work addresses these inconsistencies and aligns all the descriptive metadata across platforms to a core UTK metadata application profile. In practice, this means the workflow described below for non-MARC work is applied to each collection individually instead of to full platform feeds.

MARC data is exported from the UTK Alma ILS using application-specific functionalities, then locally stored in smaller datasets of ~50,000 bibliographic records each (with the total number of bibliographic records currently around 2 million). There has been some experimentation with accessing the data via the Alma API, but this is limited by the API requirement of using Alma-specific record identifiers to export records (so the identifier lists to feed into the API would need to be built manually). Pushing back enhanced data to Alma via the API holds more promise.

There are a number of supported formats and methods for importing data into an application or store accessible to Catmandu. Depending on the work required, the user might wish to extract data from an external source and save it locally, which can use the convert or export commands, or import the data to a local development datastore or indexing engine. The following convert command pulls a simple DC/XML metadata set from the UTK OAI-PMH feed (using the Catmandu OAI module) and saves the data locally as \[OAI set name\].oai.dc.xml:

The next command pulls a MODS/XML metadata set from the UTK OAI-PMH feed for migrated MODS metadata and saves the data locally as \[OAI set name\].oai.mods.xml:

Note the use of convert with the OAI command to pull data from an OAI-PMH feed. Some OAI-specific flags, including url, metadataPrefix, and set, target the data wanted. The command then uses the handler flag to specify that Catmandu should use an oai\_dc parser for the DC set.\[[32](https://journal.code4lib.org/articles/#note32)\] There is also a specific handler for MARCXML, but other formats and schemas, such as MODS, must use either the generic struct (the default) or raw handlers to work with the XML as found.\[[33](https://journal.code4lib.org/articles/#note33)\] This causes issues currently in pulling OAI-PMH MODS/XML metadata (discussed further below, though support for MODS is being added at the time of the writing of this article). Finally, to XML ends the convert command, and tells Catmandu to change the data to XML instead of to its default of JSON.

The user could also pull that same data from the OAI-PMH feed, but convert to another format (like JSON), and store that locally instead:

The convert command can handle working with XML, RDF, YAML, MARC, MARC/XML, JSON, CSV, Excel, and other formats. When saving locally, it saves each record as a separate Catmandu item in the same output file – resulting in invalid XML that may require file-splitting before further work. This method is useful, however, for sending these records to an application or database, as well as for loading this data into an application such as LODRefine.

To import the OAI-PMH or other dataset into a store, use the import command. The example extracts and stores an OAI-PMH DC/XML set and an OAI-PMH MODS/XML set as JSON in an existing local MongoDB database for use in data reports and visualizations. The count command then queries that MongoDB database collection/bag and returns the number of objects stored.

| 1  2 | `$ catmandu count MongoDB --database_name viz_database --bag oaiDC`  `$ 231` |
| --- | --- |

| 1  2 | `$ catmandu count MongoDB --database_name viz_database --bag oaiMODS`  `$ 315` |
| --- | --- |

### Mapping and Review in Catmandu

Catmandu’s convert and import can be used for quick review of a dataset and its fields in the CLI, as well as transforming library datasets easily to other formats that work better with visualization tools or data applications like LODRefine. For the datasets retrieved in the previous section, typing in the following command will convert the JSON data to YAML shown in the CLI for easy review:

| 1 | `$ catmandu convert JSON to YAML < egy.oai.dc.json` |
| --- | --- |

[![Figure. Screenshot of YAML output for first record in above convert command](https://journal.code4lib.org/media/issue30/harlow/harlow_image_01.png "Screenshot of YAML output for first record in above convert command")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_01.png)  
**Figure 1.** Screenshot of YAML output for first record in above convert command

To have this conversion work with the XML data stored, it will need to be saved first as one well-formed (though not necessarily valid) XML document.

The YAML output can be good for a quick browse of metadata fields. Catmandu also allows the user focus on a particular field with simple in-line Fix routines. The following command will convert the JSON data to YAML and only return the “title” field in the CLI:

| 1  2 | `$ catmandu convert JSON \`  `--fix 'retain(title)' to YAML < egy.oai.dc.json` |
| --- | --- |

[![Figure. Screenshot of CLI output for above command asking for Title only](https://journal.code4lib.org/media/issue30/harlow/harlow_image_02.png "Screenshot of CLI output for above command asking for Title only")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_02.png)  
**Figure 2.** Screenshot of CLI output for above command asking for Title only

The user can also generate a CSV report. The following command generates a CSV file in the CLI from the JSON created, using the very simple, referenced Fix file (shown below) that removes extra whitespace (or trims) then joins fields that may have multiple values for the same field (for easier viewing in tabular format):

| 1  2 | `$ catmandu convert JSON \`  `--fix DCtoCSV.fix to CSV < egy.oai.dc.json > egy.oai.dc.csv` |
| --- | --- |

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 | `---`  `DCtoCSV.fix`  `---`  `do visitor()`  `trim(scalar)`  `end`  `join_field("_about", " \| ")`  `join_field("subject", " \| ")`  `join_field("relation", " \| ")`  `join_field("_setSpec", " \| ")`  `join_field("title", " \| ")`  `join_field("type", " \| ")`  `join_field("creator", " \| ")`  `join_field("rights", " \| ")`  `join_field("source", " \| ")`  `join_field("description", " \| ")`  `join_field("publisher", " \| ")`  `join_field("coverage", " \| ")`  `join_field("identifier", " \| ")`  `join_field("contributor", " \| ")` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Additionally, the following command and fix file will take the OAI-PMH DC/JSON and perform a preliminary mapping (saving the output as a new JSON file) of the data in preparation for loading into LODRefine:

| 1  2 | `$ catmandu convert JSON \`  `--fix DCtoOpenRefine.fix egy.oai.dc.json > egy.pre-OR.dc.csv` |
| --- | --- |

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39 | `---`  `DCtoLODRefine.fix`  `---`  `unless all_match('_status', 'deleted')`  `copy_field('_datestamp', 'record.recordCreationDate')`  `copy_field('_id', 'record.recordIdentifier')`  `copy_field('_identifier', 'record.identifier.$append')`  `copy_field('_setSpec', 'record.OAIcollection.$append')`  `join_field('_setSpec', ' \| ')`  `split_field('_setSpec', ' \| ')`  `copy_field('contributor', 'record.nameContributor.$append')`  `join_field('nameContributor', ' \| ')`  `copy_field('coverage', 'record.geographicSubject')`  `copy_field('creator', 'record.nameCreator.$append')`  `join_field('nameCreator', ' \| ')`  `split_field('nameCreator', ' \| ')`  `copy_field('description', 'record.abstract')`  `if any_match('identifier', '[http://](http://)\w+')`  `copy_field('identifier', 'record.objectInContextURL')`  `else`  `copy_field('identifier', 'record.identifier.$append')`  `end;`  `if all_match('publisher', 'University of Tennessee Libraries')`  `copy_field('publisher', 'record.recordSource')`  `else`  `copy_field('publisher', 'record.publisher')`  `end;`  `if all_match('relation', '^\d{2}//\d{2}//\d{2}$')`  `copy_field('relation', 'record.date')`  `else`  `copy_field('relation', 'record.relatedItem')`  `end;`  `copy_field('rights', 'record.accessCondition')`  `copy_field('source', 'record.relatedItemCitation')`  `copy_field('subject', 'record.subjectTopical')`  `copy_field('title', 'record.title')`  `copy_field('type', 'record.typeOfResource')`  `end;`  `retain('record')` |
| --- | --- | --- | --- | --- | --- | --- |

For working with the MODS datasets, the same methods as above can be used, with the Fix file being expanded for working with all the possible field names reviewed in the YAML file. However, MODS records pulled in by Catmandu from the OAI-PMH MODS/XML feed (using the raw handler) have encoding issues that need to be addressed before mapping. Reviewing the MODS/JSON output generated, note that some XML encoding remains in the JSON \_metadata field. This can be repaired by applying first the fix xml\_simple(\_metadata), which changes the xml in that field to simplified XML (as if applying the raw handler then rerunning the struct handler on the heavily nested portions). The user can then proceed with reviewing and mapping/fix routines for the MODS/JSON or MODS/YAML in ways detailed above. The following series of commands takes the MODS/JSON pulled in the previous section, converts the MODS/JSON to JSON again while applying the xml\_simple fix, then creates a YAML output in the CLI:

| 1  2  3  4 | `$ catmandu convert JSON \`  `--fix "xml_simple(_metadata)" \`  `< kefauver.oai.mods.json \`  `> kefauver_updated.oai.mods.json` |
| --- | --- |

| 1 | `$ catmandu convert JSON to YAML < kefauver_updated.oai.mods.json` |
| --- | --- |

Catmandu can work directly with various types of MARC data for transformation and review. The following command takes a set of binary MARC records and converts these to YAML, as done above with the DC/JSON files:

| 1 | `$ catmandu convert MARC to YAML < file_0.mrc ` |
| --- | --- |

[![Figure. Screenshot of in-line trargeting MARC](https://journal.code4lib.org/media/issue30/harlow/harlow_image_03.png "Screenshot of in-line targeting MARC")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_03.png)  
**Figure 3.** Screenshot of in-line targeting MARC

As with the DC/JSON sets, simple, in-line Fix language can be used to target specific fields in a MARC record, or a saved Fix file can be created to map MARC fields to another field name, then apply normalization work. The command below takes each identifier from the MARC records and prints it as YAML in the CLI:

| 1 | `$ catmandu convert --fix 'retain(_id)' MARC to YAML < file_0.mrc` |
| --- | --- |

The next command uses a fix routine (shown below) to generate a report used at UTK to display controlled access points and possible identifier (or $0 subfield) usage in MARC records as a CSV output. This Fix file also shows more of the capabilities for metadata normalization using Fix routines.

| 1 | `$ catmandu convert MARC --fix MARC2CSV.fix to YAML < file_0.mrc` |
| --- | --- |

[![Figure. Metadata normalization using Fix](https://journal.code4lib.org/media/issue30/harlow/harlow_image_04.png "Metadata normalization using Fix")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_04.png)  
**Figure 4.** Metadata normalization using Fix

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62 | `---`  `MARC2CSV.fix`  `---`  `marc_map("001", recordIdentifier)`  `marc_map("020a",isbn.$append)`  `join_field(isbn," \| ")`  `split_field(isbn, " \| ")`  `marc_map("245ab",title, join:" ")`  `# Subject Identifiers?`  `if marc_match('6**0', "\w+")`  `set_field("subjectRecon", "exists")`  `else`  `set_field("subjectRecon", "does not exist")`  `end`  `# Name Identifiers?`  `if marc_match('1**0','\w+')`  `set_field("nameRecon", "exists")`  `else`  `set_field("nameRecon", "does not exist")`  `end`  `# Primary Name`  `marc_map('100abcdegq024','primaryName.$append', join:" ")`  `sort_field('primaryName',-uniq=>1)`  `# Corporate Name`  `marc_map('110abcdegq024','corpName.$append', join:" ")`  `sort_field('corpName',-uniq=>1)`  `# Additional Names`  `marc_map('700abcdegq024','addlName.$append', join:" ")`  `sort_field('addlName',-uniq=>1)`  `# Additional Corporate Names`  `marc_map('710abcdegq024','addlCorpName.$append', join:" ")`  `sort_field('addlCorpName',-uniq=>1)`  `# Geographic Subjects`  `marc_map('651*','subjectGeographic.$append', join:"--")`  `replace_all('subjectGeographic.*','\.$','')`  `sort_field('subjectGeographic',-uniq=>1)`  `# Name Subjects`  `marc_map('600abcdefuvxyz02','subjectName.$append', join:" ")`  `marc_map('610abcdefuvxyz02', 'subjectName.$append', join:".")`  `sort_field('subjectName',-uniq=>1)`  `# Topical Subjects`  `marc_map('650abcdefuvxyz02','subjectTopical.$append', join:"--")`  `replace_all('subjectTopical.*','\.$','')`  `sort_field('subjectTopical',-uniq=>1)`  `# Genre Terms`  `marc_map('655abcdefuvxyz02','genre.$append', join:" ")`  `replace_all('genre.*','\.$','')`  `sort_field('genre',-uniq=>1)`  `remove_field('record')` |
| --- | --- | --- | --- |

## Mapping and Review in LODRefine

At this point, depending on the size and needs of a metadata set, it will be loaded into LODRefine for more involved remediation by the cataloging and metadata staff. When working with LODRefine, one can import data as CSV, Excel, XML including RDF/XML, JSON and Google sheets. Some imported data formats (especially XML and JSON containing nested elements) require further massaging once in LODRefine to make working with the data more efficient. At core, LODRefine is creating a tabular view of the original data. This change brings with it all the inherent issues involved with going from a hierarchical, graph or other model to a tabular model (and eventually back to the desired data model and format), though Catmandu helps with pre-transformation to LODRefine-friendlier data formats.

Once the LODRefine project is created, the user will edit the columns to fit the target metadata schema’s fields. All of the column functions are accessed via the arrow at the top of each column in LODRefine. To reorganize and delete all the columns in an OpenRefine project at once, click on the arrow on the first/All column, then choose Re-order/remove columns. This opens a box for reviewing all the columns in a project, removing those columns selected, and re-ordering those the user wishes to keep. The number of options one can apply in batch to all or a group of columns is fairly limited. Working with each column separately offers more options for renaming, removing, splitting, adding additional columns or performing some reconciliation work.

Before mapping the fields represented by columns to a new field/column name, the catalogers browse more closely a field’s values through faceting. By choosing a column, clicking on the top arrow, then selecting Facet > Text facet, a facet box will appear in the left-hand part of the LODRefine interface. That box facets and shows all of the text values that appear in the cells of that chosen column.

[![Figure. Screenshot of the Text Facet box for a selected column in LODRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_05.png "Screenshot of the Text Facet box for a selected column in LODRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_05.png)  
**Figure 5.** Screenshot of the Text Facet box for a selected column in LODRefine

The Text facets show just how a field was used in the original dataset, highlight typos or errors, perform some field-specific normalization work, and review to group certain values in subsets of records. For that last option, by clicking on a facet, the LODRefine project screen updates to show only the records containing that value in the selected column.

### Normalization

In LODRefine, there are many metadata normalization capabilities available by using faceting and Google Refine Expression Language (GREL). Using the Facet > Text facet function on a column, the LODRefine column facet values box allows a user to not just review, but also edit specific facet values. The edits will apply to all cells in that column that contained that facet value.

[![Figure. Screenshot of editing a text facet in OpenRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_06.png "Screenshot of editing a text facet in OpenRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_06.png)  
**Figure 6.** Screenshot of editing a text facet in OpenRefine

Additionally, the Cluster button in the top right corner of a text facet box provides a way to pull out groupings of similar data values for that column. Using the Cluster and Edit column interface in LODRefine, the user can decide to cluster facet values using different algorithms, as well as to merge the clustered values.

[![Figure. Screenshot of LODRefine's Cluster & Edit column interface](https://journal.code4lib.org/media/issue30/harlow/harlow_image_07.png "Screenshot of LODRefine's Cluster & Edit column interface")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_07.png)  
**Figure 7.** Screenshot of LODRefine’s Cluster & Edit column interface

For a specific column, the user can also facet values via numerical value, text length, or other options. There is additionally the ability to create a custom text facet, which allows the user to facet a column’s values according to a GREL expression.

[![Figure. Screenshot of creating a GREL expression for a custom text facet in LODRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_08.png "Screenshot of creating a GREL expression for a custom text facet in LODRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_08.png)  
**Figure 8.** Screenshot of creating a GREL expression for a custom text facet in LODRefine

[![Figure. Screenshot of a custom text facet applied to an LODRefine Project](https://journal.code4lib.org/media/issue30/harlow/harlow_image_09.png "Screenshot of a custom text facet applied to an LODRefine Project")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_09.png)  
**Figure 9.** Screenshot of a custom text facet applied to an LODRefine Project

GREL, which somewhat mirrors Javascript in form and function, is one of the better documented areas of OpenRefine.\[[34](https://journal.code4lib.org/articles/#note34)\] With GREL, the user can transform data values using simple conditional statements and regular expression matching, apply values from other columns, change encodings, and many other data normalization functionalities. The user can also run custom GREL operations on the cells within a chosen column by selecting Edit cells > Transform…. This will open a Custom text transform box where GREL can be entered, previewed, and applied against a column. Along with the OpenRefine site and the OpenRefine GitHub wiki, the recent book Using OpenRefine by Ruben Verborgh and Max De Wilde is a recommended introduction and explanation of the core functions of OpenRefine, including working with GREL.\[[35](https://journal.code4lib.org/articles/#note35)\] GREL, as an intermediary between working in an application and working with the CLI, has proven to be very accessible for cataloging staff previously uncomfortable with the idea of scripting.

[![Figure. Screenshot of the Custom Text Transform interface in LODRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_10.png "Screenshot of the Custom Text Transform interface in LODRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_10.png)  
**Figure 10.** Screenshot of the Custom Text Transform interface in LODRefine

For working with datasets that are too complicated or too big currently for LODRefine, like MARC catalog data dumps, normalization is performed using just Catmandu and Fix routines built off the examples given in the Review and Mapping section.

### Reconciliation in LODRefine

In LODRefine, data reconciliation means normalizing and enhancing local metadata by comparing it with external datasets exposed either through a RESTful API, RDF documents, or SPARQL endpoints. One can query external datasets within any basic OpenRefine interface by using the ‘Add column by fetching URL’ function. This uses the existing data to create a HTTP call to the external data service, then saves the full response in a new column. A more efficient and user-friendly reconciliation method is available by using the standard OpenRefine reconciliation service API structure, which builds a HTTP-based RESTful API handling JSON data between OpenRefine and external data sources.\[[36](https://journal.code4lib.org/articles/#note36)\] There are some existing, community-sourced reconciliation service templates and examples constructed primarily in Python and PHP, as well as shared reconciliation services for the community to use.\[[37](https://journal.code4lib.org/articles/#note37)\]\[[38](https://journal.code4lib.org/articles/#note38)\]\[[39](https://journal.code4lib.org/articles/#note39)\]

Many library-specific reconciliation services built off of the OpenRefine Standard Reconciliation Service API have been created and maintained. They include:

- a FAST Reconciliation service by Ted Lawless \[[40](https://journal.code4lib.org/articles/#note40)\],
- a VIAF Reconciliation service by Roderic D. M. Page \[[41](https://journal.code4lib.org/articles/#note41)\],
- another VIAF Reconciliation service by Jeff Chiu \[[42](https://journal.code4lib.org/articles/#note42)\], which is also hosted \[[43](https://journal.code4lib.org/articles/#note43)\],
- and a service integrating VIVO instances and OpenRefine \[[44](https://journal.code4lib.org/articles/#note44)\].
- Documentation on the OpenRefine wiki, although in need of updates, provides more information about these standard reconciliation services, as does a recent presentation by this article’s author.\[[36](https://journal.code4lib.org/articles/#note36)\]\[[45](https://journal.code4lib.org/articles/#note45)\]

To reconcile a column against an existing reconciliation service in LODRefine, the user goes to the top arrow of a column, then selects Reconcile > Start reconciling…

[![Figure. Screenshot of starting reconciling on a column in OpenRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_11.png "Screenshot of starting reconciling on a column in OpenRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_11.png)  
**Figure 11.** Screenshot of starting reconciling on a column in OpenRefine

Next, the Standard Reconciliation Service column box shows reconciliation services currently set up for the instance of LODRefine. To add a new service, click on Add Standard Service… in the bottom left corner. In the box that appears, the user then adds the URL for the service’s endpoint and clicks on Add Service.

[![Figure. Screenshot of the Add Standard Reconciliation Service box in OpenRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_12.png "Screenshot of the Add Standard Reconciliation Service box in OpenRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_12.png)  
**Figure 12.** Screenshot of the Add Standard Reconciliation Service box in OpenRefine

After adding a service and loading the service metadata, the new reconciliation service should appear in the left-hand options in LODRefine. Depending on the metadata and configurations for that particular service, different entity types to search against in the external data source may appear. There will be at least one type for reconciliation, along with a few other options like auto-matching high confidence reconciliation candidates or using data in other columns to better inform the reconciliation process. After reviewing the settings, the user then clicks on Start Reconciling to reconcile that column against the external data source.

[![Figure. Screenshot of reconciliation faceting](https://journal.code4lib.org/media/issue30/harlow/harlow_image_13.png "Screenshot of reconciliation faceting")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_13.png)  
**Figure 13.** Screenshot of reconciliation faceting

Once the service is done, the LODRefine interface left-hand area displays facet boxes for reconciliation match levels and options. The user can select or deselect facets to quickly review levels of matches for the cells in that column. Within each cell, the user chooses the best match from the top choices. While reviewing the matches for each cell, one can click on the possible reconciliation candidates to then open the relevant external data web page for that term, as well as decide to apply a reconciliation match to just to that one cell or to all cells with the same value.

[![Figure. Screenshot of reconciliation service matches and facets in LODRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_14.png "Screenshot of reconciliation service matches and facets in LODRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_14.png)  
**Figure 14.** Screenshot of reconciliation service matches and facets in LODRefine

The DERI RDF Extension offers the ability to reconcile data in LODRefine with a RDF document or a SPARQL endpoint. Using either LODRefine or an installation of OpenRefine with the DERI RDF extension included, the user then has access to the RDF extension via a button in the top right corner of the interface.

[![Figure. Screenshot of the LODRefine Extensions area, with the DERI RDF Extension in use](https://journal.code4lib.org/media/issue30/harlow/harlow_image_15.png "Screenshot of the LODRefine Extensions area, with the DERI RDF Extension in use")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_15.png)  
**Figure 15.** Screenshot of the LODRefine Extensions area, with the DERI RDF Extension in use

Using the RDF extension menu, the user clicks on Add reconciliation service > Based on SPARQL endpoint… or Based on RDF File…. This will open a dialog box for working with the relevant data source chosen, and requires the user to supply information about the SPARQL Endpoint or the RDF file.  
Setting up a SPARQL Endpoint requires a service name, the URL for the SPARQL endpoint, optionally a Graph URL for the vocabulary exposed via the SPARQL endpoint, a SPARQL server Type, then the Label properties that LODRefine will use to find the possible data matches between the local data and the external RDF data. A user can select from some common RDF label properties included by default, or add multiple other properties (such as http://www.loc.gov/mads/rdf/v1#authoritativeLabel for working with some of the Library of Congress LOD authorities using MADS/RDF). Adding multiple properties for matching can help improve accuracy (since the user can catch both preferred and alternative labels), but may also slow down performance.

[![Figure. Screenshot of the SPARQL-based reconciliation service interface in LODRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_16.png "Screenshot of the SPARQL-based reconciliation service interface in LODRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_16.png)  
**Figure 16.** Screenshot of the SPARQL-based reconciliation service interface in LODRefine

The RDF reconciliation service requires also a Name, along with either a URL to the RDF document or a document upload. The user then selects the file format and, as with the SPARQL service, adds the properties LODRefine should search to retrieve the labels to be matched against the local data (with the same option to add more).

[![Figure. Screenshot of the RDF document-based reconciliation service interface in LODRefine](https://journal.code4lib.org/media/issue30/harlow/harlow_image_17.png "Screenshot of the RDF document-based reconciliation service interface in LODRefine")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_17.png)  
**Figure 17.** Screenshot of the RDF document-based reconciliation service interface in LODRefine

The DERI RDF site, although no longer actively updated, has documentation on using the SPARQL reconciliation options for working with non-library-specific data sources.\[[46](https://journal.code4lib.org/articles/#note46)\] The Free Your Metadata team has also written a good overview for using the DERI RDF reconciliation service options with the SPARQL endpoint for the Library of Congress Subject Headings on a SPARQL server created by the site’s authors.\[[47](https://journal.code4lib.org/articles/#note47)\] They expand this work in their book, Linked Data for Libraries, Archives and Museums.\[[48](https://journal.code4lib.org/articles/#note48)\] For using the RDF document reconciliation option, a walk-through by this article’s author on reconciling against the Thesaurus of Graphic Material available as a RDF dataset downloaded from the Library of Congress Linked Data Service is available.\[[49](https://journal.code4lib.org/articles/#note49)\]

The UTK workflow described here mostly uses the standard reconciliation service options to work with Geonames, FAST, and VIAF. RDF data reconciliation is used for reconciling against local ontologies (such as UTK Form terms and the Database of the Smokies vocabulary, both stored as simple SKOS RDF documents) and smaller LOD sets (such as the Library of Congress Thesaurus of Graphic Materials). The SPARQL endpoint reconciliation option is used rarely, due to some limitations of the DERI RDF extension in working with current SPARQL endpoints of interest. As an example, there is currently no way to use the DERI RDF extension SPARQL reconciliation service with the Getty Vocabularies SPARQL endpoint- an issue discussed in the Getty LOD documentation and in the OpenRefine Google Group.\[[50](https://journal.code4lib.org/articles/#note50)\]\[[51](https://journal.code4lib.org/articles/#note51)\]

## Reconciliation in Catmandu

In Catmandu, there are some quickly expanding reconciliation options. The Catmandu getJSON module and lookup in the Fix language offer two simple but effective methods. As an example of the latter, the following command finds the DCMI type value in the OAI-PMH DC/JSON metadata set pulled above, looks it up in the DCtoMODStype.csv dictionary given below, then replaces the DCMI type value with the matched MODS type value. If a match isn’t found, it replaces the value with a default value of ‘other’.

| 1  2  3 | `$catmandu convert JSON \`  `--fix "lookup('type','DCtoMODStype.csv',-default=>'other')" \`  `< egy.oai.dc.json` |
| --- | --- |

| 1  2  3  4  5  6  7  8  9  10  11  12  13 | `---`  `DCtoMODStype.csv`  `---`  `key,value`  `Collection,mixed material`  `Dataset,"software, multimedia"`  `Event,other`  `Image,still image`  `Interactive Resource,"software, multimedia"`  `Service,other`  `Software,"software, multimedia"`  `Sound,sound recording`  `Text,text` |
| --- | --- |

Catmandu getJSON takes values in a local store, uses them to create a URL, and gets the JSON response from the web service to which the URL query points. This works similarly to the OpenRefine option of ‘add a column by fetching URLs…’, but is much faster.

Catmandu developers are also exploring ways to create and support richer reconciliation services. There is a GitHub issue currently open discussing this, as well as one method and script shared by a core developer of Catmandu for reconciling values in local datasets with Linked Data Fragments servers and/or SPARQL endpoints.\[[52](https://journal.code4lib.org/articles/#note52)\]\[[53](https://journal.code4lib.org/articles/#note53)\] Linked Data Fragments (LDF) is a project from Ghent University and iMinds (formerly the Institute of Broadband Technology or IBBT). The project wants to make LOD much more scalable and support the creation of LOD endpoints that are as lightweight as possible to make them more effective and sustainable.\[[54](https://journal.code4lib.org/articles/#note54)\] As part of their work, they have created open-source LDF servers and query client applications in a variety of languages/frameworks, enabling people to expand and better secure access to RDF data.

At present, a local instance of the LDF open source server application built with Node.js is set up on the UTK metadata librarian’s workstation with HDT (header, dictionary, triples) files, a compact form of RDF data that still allows querying, generated from the Library of Congress Name Authority File, the Library of Congress Subject Headings and the Getty Art and Architecture Thesaurus.\[[55](https://journal.code4lib.org/articles/#note55)\]\[[56](https://journal.code4lib.org/articles/#note56)\]\[[57](https://journal.code4lib.org/articles/#note57)\] This LDF server supports reconciliation using Catmandu for vocabularies that pose reconciliation problems in LODRefine (due to size and/or SPARQL endpoint compatibility issues). A developer and primary committer to the Catmandu project wrote a sample Perl script for reconciling MARC data with VIAF stored in an example LDF server.\[[58](https://journal.code4lib.org/articles/#note58)\] A script was built out by a non-developer at UTK to take the MARC data pulled in the previous sections of this article and query the local LDF endpoint, matching different vocabularies to different fields.\[[59](https://journal.code4lib.org/articles/#note59)\] When there is an exact match, the matched external value URI is appended to the MARC field in subfield $0, and the updated MARC (as binary USMARC by default) created. Adding repeating $2 fields for indicating the URI source, if it points to an authority or a real world object, or is an actionable URI is being explored, following work on this topic.\[[60](https://journal.code4lib.org/articles/#note60)\] Creating the updated MARC records works because of how the Catmandu iterator (used for working through larger datasets primarily, but here used to loop through one MARC record at a time) makes each MARC record into a set of Perl hashes, with the record then becoming an array of arrays. That allows the script to use the Perl push command to add the URI field to the end of a MARC field containing the reconciled value.

| 1  2  3  4  5  6 | `$ perl recon.pl almaJuly2015.mrc`  `$ 53,204 records processed`  `$ catmandu convert MARC \`  `--type USMARC \`  `to MARC \`  `--type MARCMaker < marc.mrc` |
| --- | --- |

[![Figure. Screenshot of recon.pl MARC output. Notice headings with more than one match or characters that need to be escaped for URLs don't get reconciled currently.](https://journal.code4lib.org/media/issue30/harlow/harlow_image_18.png "Screenshot of recon.pl MARC output. Notice headings with more than one match or characters that need to be escaped for URLs don't get reconciled currently.")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_18.png)  
**Figure 18.** Screenshot of recon.pl MARC output. Notice headings with more than one match or characters that need to be escaped for URLs don’t get reconciled currently.

## Transform and Export from LODRefine

Once normalized, reconciled, and enhanced, the data needs to get into the form required for ingest into various platforms. For datasets in LODRefine, clicking on the Export button in the top right corner gives the available format and encoding options for data export.

[![Figure. Screenshot of the LODRefine Export menu](https://journal.code4lib.org/media/issue30/harlow/harlow_image_19.png "Screenshot of the LODRefine Export menu")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_19.png)  
**Figure 19.** Screenshot of the LODRefine Export menu

Before discussing RDF options, there are other core export options worth reviewing. First, the Triple loader export option might seem of interest for RDF work, but this is no longer operational (as it was originally part of the now-obsolete Freebase extension). The Templating… option allows the user to create a JSON or XML data export template, with limitations occurring according to how rows and records are modeled in the OpenRefine project. However, it is an extremely useful option for those users who take the time to build a data-specific export template – see, for example, work done on exporting from OpenRefine to MODS/XML.\[[61](https://journal.code4lib.org/articles/#note61)\]

[![Figure. OpenRefine Templating Export Interface](https://journal.code4lib.org/media/issue30/harlow/harlow_image_20.png "OpenRefine Templating Export Interface")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_20.png)  
**Figure 20.** OpenRefine Templating Export Interface

At UTK, non-MARC metadata is currently exported as simple XML via the templating option to then be transformed to MODS/XML using an existing XSLT stylesheet. The MODS/XML records are named following the element that matches the names of the digital asset files names (highlighted during export review phase), moved to the same environment as asset files, and then ingested in Islandora. Catmandu is being explored here for easier export to the Fedora instance behind the UTK Digital Collections Islandora instance, but updated documentation and procedures for how and where to store the digital assets the metadata describes need to be completed first. \[[62](https://journal.code4lib.org/articles/#note62)\]

For RDF experimentation, LODRefine also has the ability to export to RDF/XML or Turtle serializations. For either export option, the user must first set up a RDF Skeleton, accessible through the DERI RDF Extension button in the top right corner of the OpenRefine interface.

[![Figure. Screenshot of the Edit RDF Skeleton option in the OpenRefine DERI RDF Extension Menu](https://journal.code4lib.org/media/issue30/harlow/harlow_image_21.png "Screenshot of the Edit RDF Skeleton option in the OpenRefine DERI RDF Extension Menu")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_21.png)  
**Figure 21.** Screenshot of the Edit RDF Skeleton option in the OpenRefine DERI RDF Extension Menu

Clicking on Edit RDF Skeleton…, brings up the RDF Schema Alignment box. There, the user can configure just how each column will be transformed into a node in the exported RDF document. The user can add prefixes to use with additional namespaces, which are then queried by LODRefine to offer type-ahead for properties and services. In the skeleton interface, one can also decide how the triples are generated from the project data and see a preview of the to-be-exported RDF document, among other functions. The DERI RDF website has a short but useful introduction to this RDF Export work.\[[63](https://journal.code4lib.org/articles/#note63)\]

[![Figure. Screenshot of OpenRefine DERI RDF Schema Alignment Interface](https://journal.code4lib.org/media/issue30/harlow/harlow_image_22.png "Screenshot of OpenRefine DERI RDF Schema Alignment Interface")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_22.png)  
**Figure 22.** Screenshot of OpenRefine DERI RDF Schema Alignment Interface

As UTK is migrating a lot of descriptive metadata from a number of schema and practices to MODS/XML, there is interest in how MODS/XML will be represented as MODS/RDF (or mapped to other, existing properties). While work on this continues \[[64](https://journal.code4lib.org/articles/#note64)\]\[[65](https://journal.code4lib.org/articles/#note65)\], the images below show two areas of exploration: 1. a RDF export skeleton for MODS/RDF (with blank nodes and namespace lookups in use) as currently defined by the Library of Congress MODS/RDF version 1 standard; then 2. the MODS/XML metadata as DCterms in RDF. This work has both given many internal stakeholders a better understanding of what the change to RDF will mean, as well as examples to work with in crafting community discussions. Note: for the type-ahead features to work with the MODS/RDF version 1 namespace, the user must click add prefix, click on the Advanced button, then upload the vocabulary terms from a file stored locally (for MODS/RDF version 1, this OWL document downloaded from the Library of Congress).\[[66](https://journal.code4lib.org/articles/#note66)\]

[![Figure. LODRefine RDF Skeleton with Namespace lookups, using MODSRDF v.1](https://journal.code4lib.org/media/issue30/harlow/harlow_image_23.png "LODRefine RDF Skeleton with Namespace lookups, using MODSRDF v.1")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_23.png)  
**Figure 23.** LODRefine RDF Skeleton with Namespace lookups, using MODSRDF v.1

[![Figure. LODRefine RDF Skeleton using DCterms](https://journal.code4lib.org/media/issue30/harlow/harlow_image_24.png "LODRefine RDF Skeleton using DCterms")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_24.png)  
**Figure 24.** LODRefine RDF Skeleton using DCterms

[![Figure. LODRefine RDF Skeleton Node Options](https://journal.code4lib.org/media/issue30/harlow/harlow_image_25.png "LODRefine RDF Skeleton Node Options")](https://journal.code4lib.org/media/issue30/harlow/harlow_image_25.png)  
**Figure 25.** LODRefine RDF Skeleton Node Options

LODRefine will then export the dataset following the constructed RDF skeleton as one file with multiple statements/graphs in whatever serialization was chosen.

## Transform and Export Using Catmandu

As mentioned previously, Catmandu can convert data to various RDF serializations while working with aREF (or Another RDF Encoding Form) in the Catmandu internal processing.\[[67](https://journal.code4lib.org/articles/#note67)\] Taking the MARC data worked with so far and converting to RDF requires a Fix routine. The following commands and fix routine will take MARC data having been reconciled using the script above, make the subject of all the triples generated for a record the record identifier (or the \_id value as created by Catmandu working with MARC), then map fields to objects of predicates from a variety of namespaces, very loosely guided by recent BIBFRAME discussions. As one example, the following Fix routine creates the start of a BIBFRAME Work description from the MARC file shown:

| 1  2  3  4  5 | `$ catmandu convert MARC \`  `--type USMARC \`  `--fix MARCtoRDF.fix \`  `to RDF \`  `--type ntriples < marc.mrc > marc_dcterms.rdf` |
| --- | --- |

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32 | `---`  `marc.mrc snippet (displayed as MARC --type MARCmaker):`  `---`  `=LDR  01684ajm  2200397u r4500`  `=001  994822350102311`  `=005  20150603214529.0`  `=007  sd\bsmenn\\\\\`  `=008  840611s1965xx\\\\\\\nn\\\\\\\\\\0\\ger\d`  `=028  00$aWER 60020$bWERGO`  `=035  \\$a(TU)000482235UTK01`  `=035  9\$a508073`  `=035  \\$a(OCoLC)10831384`  `=040  \\$aTKN$cTKN`  `=048  \\$aoa`  `=048  \\$aca`  `=049  \\$atknm`  `=090  \\$aM2021.P4$bA8`  `=100  1\$aPenderecki, Krzysztof,$d1933-$0(DLC)no98008167`  `=240  10$aFluorescences$0(DLC)nr91007103`  `=245  10$aFluorescences. Stabat Mater for drei a-cappella Chore$h[sound recording]`  `=260  \\$bWERGO$cWER 60020.$c1965.`  `=300  \\$aon side 2 of 1 disc.$b33 1/3 rpm. stereo.$c12 in.`  `=440  \0$aStudio-Reihe neuer Musik.`  `=501  \\$aWith his Psalmy Dawida.`  `=500  \\$aTape copy.`  `=511  0\$aWarschauer Philharmonisches Orchester (in the first work); Chor der Warschauer Philharmonie; Andrzej Markowski, conductor.`  `=650  \0$aOrchestral music.`  `=650  \0$aChoruses, Sacred (Mixed voices), Unaccompanied.$0(DLC)sh85095326`  `=650  \0$aStabat Mater dolorosa (Music)$0(DLC)sh85127183`  `=700  12$aPenderecki, Krzysztof,$d1933-$tStabat Mater.$0(DLC)no97072342`  `=700  1\$aMarkowski, Andrzej,$d1924-$4prf$(DLC)n83006447`  `=710  2\$aFilharmonia Narodowa (Warsaw, Poland)$4prf$0(DLC)n83194275` |
| --- | --- |

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50 | `---`  `MARCtoRDF.fix:`  `---`  `append('_id','/Work/')`  `add_field('a','bfld:Work')`  `if all_match('LDR/6','a')`  `end`  `if all_match('LDR/6','c')`  `end`  `if all_match('LDR/6','e')`  `end`  `if all_match('LDR/6','[ij]')`  `end`  `if all_match('LDR/6','m')`  `end`  `if all_match('LDR/6','r')`  `end`  `marc_map('008_/7-10','dc_date')`  `replace_all('dc_date','\D','0')`  `marc_map('008_/35-37','dct_language')`  `if all_match('dct_language','\W+')`  `set_field('dct_language','und')`  `end`  `marc_map('050ab','bfld:classifiedAs')`  `marc_map('6500','dct_subject.$append')`  `unless exists('dct_subject')`  `marc_map('650','dct_subject.$append',-join=> '--')`  `end`  `marc_map('245ab','bfld:hasPreferredTitle', -join=>" ")`  `replace_all('bfld:hasPreferredTitle', ' /$','')`  `marc_map('1000','rdau:P60447')`  `unless exists('rdau:P60447')`  `marc_map('100','rdau:P60447')`  `end`  `marc_map(700ad,'rdau:P60398.$append',-join=>" ")`  `marc_map('028','bfld:hasInstance.bfld:identifiedBy')`  `add_field('bfld:hasInstance.a','bfld:MusicPublisherNumber')`  `remove_field('record')` |
| --- | --- |

A similar process can be done for non-MARC records being processed by Catmandu, with the updated Fix routine for that data. As Catmandu::RDF is built off of RDF::NS (among other helpful Perl modules for RDF data), many of the more popular namespace prefixes are already defined— so above, dct\_ becomes

```
<http://purl.org/dc/terms/>
```

. Other namespaces and their prefixes, such as rdau: for the RDA (Resource, Description and Access) properties need to be defined either in a Perl script using RDF::NS or in the data store this RDF data is going to.\[[68](https://journal.code4lib.org/articles/#note68)\] While Catmandu can convert between RDF serializations (using the -type flag and with RDF/XML as the default), the core developers of Catmandu recommend using other tools for this work. Catmandu is better suited for transforming non-RDF data to RDF.

## Conclusions and Looking Ahead

There is a lot of utility in both Catmandu and LODRefine for data work, and these tools complement each other while offering a lot of functionalities yet to be explored for the UTK metadata workflows. As one example, Catmandu’s ability to query connected datastores and pull those values into metadata during an ETL process \[[69](https://journal.code4lib.org/articles/#note69)\] is of particular interest for working with the datastores behind platforms such as VIVO and Skosmos and using those datasets to both normalize and enhance metadata across platforms.\[[70](https://journal.code4lib.org/articles/#note70)\]\[[71](https://journal.code4lib.org/articles/#note71)\] The growth in use of domain-specific transformation languages, intended to make metadata transformation more accessible to non-developers and as seen with Catmandu’s Fix language, is also an area of continued exploration with tools such as Metafacture and the Digital Public Library of America’s Krikri.\[[72](https://journal.code4lib.org/articles/#note72)\]\[[73](https://journal.code4lib.org/articles/#note73)\]\[[74](https://journal.code4lib.org/articles/#note74)\] Another area of experimentation is how to continue using existing data tools such as MARCEdit and new tools such as D:Swarm (a middleware tool for data review and visualization) in a wider and more consistent metadata munging workflow.\[[75](https://journal.code4lib.org/articles/#note75)\]\[[76](https://journal.code4lib.org/articles/#note76)\]

Despite the noted areas requiring further exploration and the pitfalls discussed above, the biggest success of this workflow and the tools used so far is the better integration of the staff members involved with various parts of the metadata ecosystem. Instead of keeping MARC catalogers, content specialists, digital projects managers, digitization staff, and developers functionally isolated, the above workflow is a step towards more interoperability, consistency, and better communication of metadata munging practices, whether MARC or non-MARC. As that occurs, the metadata being migrated will become more consistent, staff will have a better understanding of RDF (or metadata more generally) discussions, and UTK’s collections discoverability will continue to improve.

## Acknowledgements

The author would like to thank the editors and readers for their comments and feedback. Special thanks to Patrick Hochstenbach (Digital Architect at the Ghent University Library) and Nick Ruest (Digital Assets Librarian at York University) for their review and suggestions that greatly improved this article.

## Notes and References

\[[1](https://journal.code4lib.org/articles/#ref1)\] More about Resource Description Framework (RDF): [http://www.w3.org/RDF/](http://www.w3.org/RDF/)  
\[[2](https://journal.code4lib.org/articles/#ref2)\] OCLC International Linked Data Surveys show the growth of libraries, archives and musuems working with RDF: [http://www.oclc.org/research/themes/data-science/linkeddata.html#linked-data-survey](http://www.oclc.org/research/themes/data-science/linkeddata.html#linked-data-survey)  
\[[3](https://journal.code4lib.org/articles/#ref3)\] “Like families, tidy datasets are all alike but every messy dataset is messy in its own way.” –Hadley Wickham, “Tidy Data”, Journal of Statistical Software. [http://vita.had.co.nz/papers/tidy-data.pdf](http://vita.had.co.nz/papers/tidy-data.pdf)  
\[[4](https://journal.code4lib.org/articles/#ref4)\] A short history of OpenRefine: [http://openrefine.org/2013/10/12/openrefine-history.html](http://openrefine.org/2013/10/12/openrefine-history.html)  
\[[5](https://journal.code4lib.org/articles/#ref5)\] OpenRefine GitHub Repository: [https://github.com/openrefine/openrefine](https://github.com/openrefine/openrefine)  
\[[6](https://journal.code4lib.org/articles/#ref6)\] OpenRefine Website: [http://openrefine.org/](http://openrefine.org/)  
\[[7](https://journal.code4lib.org/articles/#ref7)\] OpenRefine on Twitter: [http://www.twitter.com/openrefine](http://www.twitter.com/openrefine)  
\[[8](https://journal.code4lib.org/articles/#ref8)\] Quote taken from the OpenRefine GitHub Repository ReadMe file: [https://github.com/OpenRefine/OpenRefine/blob/master/README.md](https://github.com/OpenRefine/OpenRefine/blob/master/README.md)  
\[[9](https://journal.code4lib.org/articles/#ref9)\] DERI RDF Extension for OpenRefine GitHub Repository: [https://github.com/fadmaa/grefine-rdf-extension/downloads](https://github.com/fadmaa/grefine-rdf-extension/downloads)  
\[[10](https://journal.code4lib.org/articles/#ref10)\] DERI RDF Extension for OpenRefine Website: [http://refine.deri.ie/](http://refine.deri.ie/)  
\[[11](https://journal.code4lib.org/articles/#ref11)\] LODRefine GitHub Repository: [https://github.com/sparkica/LODRefine](https://github.com/sparkica/LODRefine)  
\[[12](https://journal.code4lib.org/articles/#ref12)\] OpenRefine GitHub Wiki Installation Instructions: [https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions](https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions)  
\[[13](https://journal.code4lib.org/articles/#ref13)\] OpenRefine GitHub Wiki Extension Installation Instructions: [https://github.com/OpenRefine/OpenRefine/wiki/Installing-Extensions](https://github.com/OpenRefine/OpenRefine/wiki/Installing-Extensions)  
\[[14](https://journal.code4lib.org/articles/#ref14)\] OpenRefine GitHub Repository Wiki Users’ Documentation: [https://github.com/OpenRefine/OpenRefine/wiki/Documentation-For-Users](https://github.com/OpenRefine/OpenRefine/wiki/Documentation-For-Users)  
\[[15](https://journal.code4lib.org/articles/#ref15)\] Introduction to OpenRefine written by Owen Stephens: [http://www.meanboyfriend.com/overdue\_ideas/2014/11/working-with-data-using-openrefine/](http://www.meanboyfriend.com/overdue_ideas/2014/11/working-with-data-using-openrefine/)  
\[[16](https://journal.code4lib.org/articles/#ref16)\] To learn more about or get involved in supporting Catmandu, visit the LibreCat GitHub organization site ([https://github.com/librecat](https://github.com/librecat)), the LibreCat website ([http://librecat.org/](http://librecat.org/)), or get in touch with one of the primary contacts listed on the LibreCat About page ([http://librecat.org/about.html](http://librecat.org/about.html)).  
\[[17](https://journal.code4lib.org/articles/#ref17)\] Catmandu::Store::MongoDB: [https://github.com/LibreCat/Catmandu-Store-MongoDB](https://github.com/LibreCat/Catmandu-Store-MongoDB)  
\[[18](https://journal.code4lib.org/articles/#ref18)\] Catmandu::Store::ElasticSearch: [https://github.com/LibreCat/Catmandu-Store-Elasticsearch](https://github.com/LibreCat/Catmandu-Store-Elasticsearch)  
\[[19](https://journal.code4lib.org/articles/#ref19)\] Catmandu::OAI: [https://github.com/LibreCat/Catmandu-OAI](https://github.com/LibreCat/Catmandu-OAI)  
\[[20](https://journal.code4lib.org/articles/#ref20)\] Catmandu::SRU: [https://github.com/LibreCat/Catmandu-SRU](https://github.com/LibreCat/Catmandu-SRU)  
\[[21](https://journal.code4lib.org/articles/#ref21)\] Catmandu::DSpace: [https://github.com/LibreCat/Catmandu-DSpace](https://github.com/LibreCat/Catmandu-DSpace)  
\[[22](https://journal.code4lib.org/articles/#ref22)\] Catmandu::FedoraCommons: [https://github.com/LibreCat/Catmandu-FedoraCommons](https://github.com/LibreCat/Catmandu-FedoraCommons)  
\[[23](https://journal.code4lib.org/articles/#ref23)\] The Catmandu Handbook: [http://librecat.org/Catmandu/](http://librecat.org/Catmandu/)  
\[[24](https://journal.code4lib.org/articles/#ref24)\] Catmandu Installation Instructions: [http://librecat.org/Catmandu/#installation](http://librecat.org/Catmandu/#installation)  
\[[25](https://journal.code4lib.org/articles/#ref25)\] Catmandu core CPAN Module: [https://metacpan.org/pod/Catmandu](https://metacpan.org/pod/Catmandu)  
\[[26](https://journal.code4lib.org/articles/#ref26)\] Catmandu virtual machine plus instructions for use: [https://librecatproject.wordpress.com/get-catmandu/](https://librecatproject.wordpress.com/get-catmandu/)  
\[[27](https://journal.code4lib.org/articles/#ref27)\] Catmandu Docker image: [https://registry.hub.docker.com/u/librecat/catmandu/](https://registry.hub.docker.com/u/librecat/catmandu/)  
\[[28](https://journal.code4lib.org/articles/#ref28)\] Local configuration options for Catmandu: [http://librecat.org/Catmandu/#configuration](http://librecat.org/Catmandu/#configuration)  
\[[29](https://journal.code4lib.org/articles/#ref29)\] The most recent version of the Catmandu Command Line Interface cheat sheet: [http://librecat.org/Catmandu/#command-line-client-cheat-sheet](http://librecat.org/Catmandu/#command-line-client-cheat-sheet)  
\[[30](https://journal.code4lib.org/articles/#ref30)\] Catmandu::Fix::Parser: [https://metacpan.org/pod/Catmandu::Fix::Parser](https://metacpan.org/pod/Catmandu::Fix::Parser)  
\[[31](https://journal.code4lib.org/articles/#ref31)\] Catmandu Fixes Cheat Sheet: [https://github.com/LibreCat/Catmandu/wiki/Fixes-Cheat-Sheet](https://github.com/LibreCat/Catmandu/wiki/Fixes-Cheat-Sheet)  
\[[32](https://journal.code4lib.org/articles/#ref32)\] Catmandu::Importer::OAI: [https://metacpan.org/pod/Catmandu::Importer::OAI](https://metacpan.org/pod/Catmandu::Importer::OAI)  
\[[33](https://journal.code4lib.org/articles/#ref33)\] More information on the Catmandu OAI Parsers available: [https://github.com/LibreCat/Catmandu-OAI/tree/master/lib/Catmandu/Importer/OAI/Parser](https://github.com/LibreCat/Catmandu-OAI/tree/master/lib/Catmandu/Importer/OAI/Parser) – though as of the first draft of this article, support for MODS has been added by the Catmandu core development team: [https://github.com/LibreCat/Catmandu-OAI/commit/7c94797504821a6a1fab8e4ab3e16dd0118c4480](https://github.com/LibreCat/Catmandu-OAI/commit/7c94797504821a6a1fab8e4ab3e16dd0118c4480)  
\[[34](https://journal.code4lib.org/articles/#ref34)\] Google Refine Expression Language (GREL) Functions: [https://github.com/OpenRefine/OpenRefine/wiki/GREL-Functions](https://github.com/OpenRefine/OpenRefine/wiki/GREL-Functions)  
\[[35](https://journal.code4lib.org/articles/#ref35)\] Using OpenRefine by Ruben Verborgh and Max De Wilde (2013, Packt Publishing)  
\[[36](https://journal.code4lib.org/articles/#ref36)\] Documentation on the OpenRefine Standard Reconciliation Service API (note that this documentation needs to be updated in parts): [https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation-Service-API](https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation-Service-API)  
\[[37](https://journal.code4lib.org/articles/#ref37)\] OpenRefine Reconciliation Service API Examples: [https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation-Service-API#examples](https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation-Service-API#examples)  
\[[38](https://journal.code4lib.org/articles/#ref38)\] Sample OpenRefine Reconciliation Service API built in Python/Flask: [https://github.com/mikejs/reconcile-demo](https://github.com/mikejs/reconcile-demo)  
\[[39](https://journal.code4lib.org/articles/#ref39)\] OpenRefine Reconciliation Service for VIAF built with PHP: [https://github.com/rdmpage/phyloinformatics/blob/master/services/reconciliation\_viaf.php](https://github.com/rdmpage/phyloinformatics/blob/master/services/reconciliation_viaf.php)  
\[[40](https://journal.code4lib.org/articles/#ref40)\] Ted Lawless’ FAST Reconciliation Service for OpenRefine: [https://github.com/lawlesst/fast-reconcile](https://github.com/lawlesst/fast-reconcile)  
\[[41](https://journal.code4lib.org/articles/#ref41)\] Blog post by Roderick D. M. Page on his VIAF Reconciliation Service for OpenRefine: [http://iphylo.blogspot.com/2013/04/reconciling-author-names-using-open.html](http://iphylo.blogspot.com/2013/04/reconciling-author-names-using-open.html)  
\[[42](https://journal.code4lib.org/articles/#ref42)\] Another VIAF Reconciliation Service for OpenRefine by Jeff Chiu: [https://github.com/codeforkjeff/refine\_viaf](https://github.com/codeforkjeff/refine_viaf)  
\[[43](https://journal.code4lib.org/articles/#ref43)\] The hosted version/endpoint for the VIAF Reconciliation Service referenced above: [http://refine.codefork.com/](http://refine.codefork.com/)  
\[[44](https://journal.code4lib.org/articles/#ref44)\] A VIVO Reconciliation Service for OpenRefine: [https://wiki.duraspace.org/display/VIVO/Extending+Google+Refine+for+VIVO](https://wiki.duraspace.org/display/VIVO/Extending+Google+Refine+for+VIVO)  
\[[45](https://journal.code4lib.org/articles/#ref45)\] A presentation by the author of this article on building OpenRefine Reconciliation Service APIs: [http://christinaharlow.com/openrefine-reconciliation-workshop-c4lmdc/](http://christinaharlow.com/openrefine-reconciliation-workshop-c4lmdc/)  
\[[46](https://journal.code4lib.org/articles/#ref46)\] DERI RDF Extension SPARQL Reconciliation Service Documentation: [http://refine.deri.ie/sparqlReconDocs](http://refine.deri.ie/sparqlReconDocs)  
\[[47](https://journal.code4lib.org/articles/#ref47)\] The Free Your Metadata Team’s explanation of reconciliation using LODRefine: [http://freeyourmetadata.org/reconciliation/](http://freeyourmetadata.org/reconciliation/)  
\[[48](https://journal.code4lib.org/articles/#ref48)\] The above authors’ book expanding the LODRefine Reconciliation work (among other topics): [http://book.freeyourmetadata.org/](http://book.freeyourmetadata.org/)  
\[[49](https://journal.code4lib.org/articles/#ref49)\] Walk-through of using the LODRefine RDF Document Reconciliation Service: [https://github.com/cmh2166/c4lMDCpres/blob/master/breakout\_workflows/deriRDFexample.md](https://github.com/cmh2166/c4lMDCpres/blob/master/breakout_workflows/deriRDFexample.md)  
\[[50](https://journal.code4lib.org/articles/#ref50)\] Getty LOD Documentation discussing limitations of working with LODRefine: [http://vocab.getty.edu/queries#OpenRefine\_Reconciliation\_Service](http://vocab.getty.edu/queries#OpenRefine_Reconciliation_Service)  
\[[51](https://journal.code4lib.org/articles/#ref51)\] OpenRefine Google Group post on trying to use LODRefine with Getty Sparql Endpoint: [https://groups.google.com/d/topic/openrefine/g7LjoFkbyMo/discussion](https://groups.google.com/d/topic/openrefine/g7LjoFkbyMo/discussion)  
\[[52](https://journal.code4lib.org/articles/#ref52)\] Catmandu::RDF GitHub Repository Issue on Reconciliation Services: [https://github.com/LibreCat/Catmandu-RDF/issues/23](https://github.com/LibreCat/Catmandu-RDF/issues/23)  
\[[53](https://journal.code4lib.org/articles/#ref53)\] LibreCat Project Blogpost on using Catmandu and Linked Data Fragments (LDF) Servers for Reconciliation work with VIAF: [https://librecatproject.wordpress.com/2015/06/03/matching-authors-against-viaf-identities/](https://librecatproject.wordpress.com/2015/06/03/matching-authors-against-viaf-identities/)  
\[[54](https://journal.code4lib.org/articles/#ref54)\] The Linked Data Fragments (LDF) Website: [http://linkeddatafragments.org/](http://linkeddatafragments.org/)  
\[[55](https://journal.code4lib.org/articles/#ref55)\] The LDF Server.js (built with Node.js) GitHub Repository: [https://github.com/LinkedDataFragments/Server.js](https://github.com/LinkedDataFragments/Server.js)  
\[[56](https://journal.code4lib.org/articles/#ref56)\] The RDF/HDT Website: [http://www.rdfhdt.org/](http://www.rdfhdt.org/)  
\[[57](https://journal.code4lib.org/articles/#ref57)\] Researchers involved with building a HDT-CPP library and tools used for generating and working with HDT files at UTK:  
Javier D. Fernández ,Miguel A. Martínez-Prieto, Claudio Gutiérrez, Axel Polleres and Mario Arias. “Binary RDF Representation for Publication and Exchange (HDT)” (2013), Web Semantics: Science, Services and Agents on the World Wide Web. [http://www.websemanticsjournal.org/index.php/ps/article/view/328](http://www.websemanticsjournal.org/index.php/ps/article/view/328).

Miguel A. Martínez-Prieto, Mario Arias and Javier D. Fernández. “Exchange and Consumption of Huge RDF Data” (2012), The Semantic Web: Research and Applications. pages 437-452.

\[[58](https://journal.code4lib.org/articles/#ref58)\] Patrick Hochstenbach’s Perl script for reconciling MARC data with VIAF in a development LDF server: [https://gist.github.com/phochste/c87c81c79d8b8a6a2179](https://gist.github.com/phochste/c87c81c79d8b8a6a2179)  
\[[59](https://journal.code4lib.org/articles/#ref59)\] This author’s draft Perl script for reconciling MARC data with LDF server containing LCNAF, LCSH, and Getty AAT vocabularies: [https://github.com/cmh2166/catmandu\_recon](https://github.com/cmh2166/catmandu_recon)  
\[[60](https://journal.code4lib.org/articles/#ref60)\] URIs in MARC: A Call for Best Practices by Steven Folsom: [https://docs.google.com/document/d/1fuHvF8bXH7hldY\_xJ7f\_xn2rP2Dj8o-Ca9jhHghIeUg/edit](https://docs.google.com/document/d/1fuHvF8bXH7hldY_xJ7f_xn2rP2Dj8o-Ca9jhHghIeUg/edit)  
\[[61](https://journal.code4lib.org/articles/#ref61)\] “Converting Spreadsheets into MODSXML using Open Refine” by Sara Allain: [https://www.utsc.utoronto.ca/digitalscholarship/content/blogs/converting-spreadsheets-modsxml-using-open-refine](https://www.utsc.utoronto.ca/digitalscholarship/content/blogs/converting-spreadsheets-modsxml-using-open-refine)  
\[[62](https://journal.code4lib.org/articles/#ref62)\] The Catmandu::FedoraCommons module: [http://search.cpan.org/dist/Catmandu-FedoraCommons/](http://search.cpan.org/dist/Catmandu-FedoraCommons/)  
\[[63](https://journal.code4lib.org/articles/#ref63)\] DERI RDF Extension Site’s Introduction to RDF Export: [http://refine.deri.ie/rdfExportDocs](http://refine.deri.ie/rdfExportDocs)  
\[[64](https://journal.code4lib.org/articles/#ref64)\] MODSRDF version 2: [https://github.com/blunalucero/MODS-RDF](https://github.com/blunalucero/MODS-RDF)  
\[[65](https://journal.code4lib.org/articles/#ref65)\] Hydra MODS and RDF Descriptive Metadata Subgroup: [https://wiki.duraspace.org/display/hydra/MODS+and+RDF+Descriptive+Metadata+Subgroup](https://wiki.duraspace.org/display/hydra/MODS+and+RDF+Descriptive+Metadata+Subgroup)  
\[[66](https://journal.code4lib.org/articles/#ref66)\] MODS/RDF version 1 OWL Document: [http://www.loc.gov/standards/mods/modsrdf/v1/modsrdf.owl](http://www.loc.gov/standards/mods/modsrdf/v1/modsrdf.owl)  
\[[67](https://journal.code4lib.org/articles/#ref67)\] Another RDF Encoding Form (aREF) website: [http://gbv.github.io/aREF/aREF.html](http://gbv.github.io/aREF/aREF.html)  
\[[68](https://journal.code4lib.org/articles/#ref68)\] RDF::NS (Namespaces) Perl module: [https://metacpan.org/pod/RDF::NS](https://metacpan.org/pod/RDF::NS)  
\[[69](https://journal.code4lib.org/articles/#ref69)\] See slides 59-60 of this RDF in Catmandu presentation to learn more about the weave\_by\_id and weave\_by\_query fix functions in Catmandu: [http://librecat.org/assets/20131113\_workshop\_slides.pdf](http://librecat.org/assets/20131113_workshop_slides.pdf)  
\[[70](https://journal.code4lib.org/articles/#ref70)\] About VIVO: [http://www.vivoweb.org/about](http://www.vivoweb.org/about)  
\[[71](https://journal.code4lib.org/articles/#ref71)\] About Skosmos: [http://skosmos.org/](http://skosmos.org/)  
\[[72](https://journal.code4lib.org/articles/#ref72)\] About Metafacture: [https://github.com/culturegraph/metafacture-core/wiki](https://github.com/culturegraph/metafacture-core/wiki)  
\[[73](https://journal.code4lib.org/articles/#ref73)\] Section 5.5 of this article by the DPLA Technology Team mentions in passing their interest in domain-specific languages for metadata aggregation, mapping and enhancement:

Matienzo, M., Rudersdorf, A.. The Digital Public Library of America Ingestion Ecosystem: Lessons Learned After One Year of Large-Scale Collaborative Metadata Aggregation. International Conference on Dublin Core and Metadata Applications, North America, Oct. 2014. Available at: [http://dcpapers.dublincore.org/pubs/article/view/3700/1923](http://dcpapers.dublincore.org/pubs/article/view/3700/1923)  
\[[74](https://journal.code4lib.org/articles/#ref74)\] About Krikri: [https://github.com/dpla/krikri](https://github.com/dpla/krikri) – For seeing the influence of Catmandu’s Fix language on this work, check out specifically their work on application-specific mapping language functionalities: [https://github.com/dpla/KriKri/blob/develop/lib/krikri/map\_crosswalk.rb](https://github.com/dpla/KriKri/blob/develop/lib/krikri/map_crosswalk.rb)  
[https://github.com/dpla/KriKri/blob/develop/lib/krikri/mapper.rb](https://github.com/dpla/KriKri/blob/develop/lib/krikri/mapper.rb)  
[https://github.com/dpla/KriKri/blob/develop/lib/krikri/mapping.rb](https://github.com/dpla/KriKri/blob/develop/lib/krikri/mapping.rb)  
[https://github.com/dpla/KriKri/blob/develop/lib/krikri/mapping\_dsl.rb](https://github.com/dpla/KriKri/blob/develop/lib/krikri/mapping_dsl.rb)  
\[[75](https://journal.code4lib.org/articles/#ref75)\] Current UTK E-Resources vendor MARC Records review using MARCEdit: [https://wiki.lib.utk.edu/display/CAT/MARCEdit+E-Resource+Batch+Preparation](https://wiki.lib.utk.edu/display/CAT/MARCEdit+E-Resource+Batch+Preparation)  
\[[76](https://journal.code4lib.org/articles/#ref76)\] About D:Swarm: [http://www.dswarm.org/en/datenmanagement/dswarm-hilfe/was-ist-dswarm/](http://www.dswarm.org/en/datenmanagement/dswarm-hilfe/was-ist-dswarm/)
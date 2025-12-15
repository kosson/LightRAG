---
title: "Bridging Technologies to Efficiently Arrange and Describe Digital Archives: the Bentley Historical Library’s ArchivesSpace-Archivematica-DSpace Workflow Integration Project"
source: "https://journal.code4lib.org/articles/12105"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-01-30
created: 2025-01-10
description: "In recent years, ArchivesSpace and Archivematica have emerged as two of the most exciting open source platforms for working with digital archives. The former manages accessions and collections and provides a framework for entering descriptive, administrative, rights, and other metadata. The latter ingests digital content and prepares information packages for long-term preservation and access. In [...]"
tags:
  - "clippings"
---
# Bridging Technologies to Efficiently Arrange and Describe Digital Archives: the Bentley Historical Library’s ArchivesSpace-Archivematica-DSpace Workflow Integration Project
Max Eckard, Dallas Pillen, Mike Shallcross

In recent years, ArchivesSpace and Archivematica have emerged as two of the most exciting open source platforms for working with digital archives. The former manages accessions and collections and provides a framework for entering descriptive, administrative, rights, and other metadata. The latter ingests digital content and prepares information packages for long-term preservation and access. In October 2016, the Bentley Historical Library wrapped up a two-year, $355,000 grant from the Andrew W. Mellon Foundation to partner with the University of Michigan Library on the integration of these two systems in an end-to-end workflow that will include the automated deposit of content into a DSpace repository. This article provides context of the project and offers an in-depth exploration of the project’s key development tasks, all of which were provided by Artefactual Systems, the developers of Archivematica (code available at https://github.com/artefactual-labs/appraisal-tab).

## Project Background

In April 2014, the University of Michigan’s Bentley Historical Library (“the Bentley”) received a $355,000 two-year grant from The Andrew W. Mellon Foundation to partner with the main University of Michigan Library to integrate functionality of ArchivesSpace, Archivematica, and DSpace in an end-to-end digital archives workflow. The Bentley has managed and preserved major collections of born-digital archives since the 1997 accession of a former university president’s personal computer. For many years the library tailored digital preservation strategies to specific collections and procedures were largely manual due to limited staff and technical skills. In 2009, the Bentley received a two-year grant from the Mellon Foundation, “Email Archiving at the University of Michigan,” that added additional storage infrastructure (including the use of Deep Blue, the University of Michigan’s DSpace repository) as well as two staff members to enhance and standardize digital preservation policies and procedures.\[[1](https://journal.code4lib.org/articles/#en1)\] This grant-funded work led Michael Shallcross to experiment with automating key digital preservation procedures and in 2011, the library implemented a local digital preservation tool, the AutomatedProcessor (AutoPro).\[[2](https://journal.code4lib.org/articles/#en2)\] Inspired by the Archivematica digital preservation system’s micro-service design and pipeline workflow, this resource automated key portions of the digital preservation workflow and helped standardize the creation of metadata and log files. AutoPro provided a single interface for more than twenty applications and guided users through a standardized workflow that included steps such as a virus scan, the identification of personally identifiable information, and migration of content to sustainable file formats. However, as a command line tool written in Windows CMD.EXE shell scripts, AutoPro was never intended to be a long-term solution given its limited error handling, poor user interface, and support issues (primarily installing and updating the CMD.EXE scripts and component utilities on multiple workstations). As acquisitions of digital archives continued to grow and the Bentley sought to involve more of its staff in working with such content, it was clear that a more robust and user-friendly solution was required.

In reviewing available open-source tools, the Bentley realized that ArchivesSpace and Archivematica had the potential to be integrated with the local DSpace repository in an end-to-end digital archives workflow. Each of these systems addressed important aspects of the Bentley’s approach to preserving and providing access to born-digital archives:

- ArchivesSpace (ASpace) is an open-source archival management software that combines the best features of Archon and Archivists’ Toolkit. This system permits institutions to track accessions, manage collections, and generate Encoded Archival Description (EAD) finding aids and MARCXML. Development of ASpace was funded by the Andrew W. Mellon Foundation (2011-2013) and LYRASIS now serves as its institutional home.\[[3](https://journal.code4lib.org/articles/#en3)\]
- Archivematica is a free and open-source digital preservation system developed by Artefactual Systems (British Columbia). Archivematica employs a micro-service design to “provide an integrated suite of software tools that allows users to process digital objects from ingest to access in compliance with the ISO-OAIS functional model” and furthermore employs METS and PREMIS to record and track descriptive, administrative, and rights metadata.\[[4](https://journal.code4lib.org/articles/#en4)\]
- DSpace is an open-source repository platform that “preserves and enables easy and open access to all types of digital content including text, images, moving images, mpegs and data sets.” Initially developed by MIT Libraries with partial support from a Mellon Foundation grant, DSpace has acquired a growing community of developers and is employed by the University of Michigan and approximately 1,400 other academic, nonprofit, and commercial organizations around the world.\[[5](https://journal.code4lib.org/articles/#en5)\]

By integrating functionality and sharing information among these platforms, the Bentley’s basic goals for the project were to:

- Facilitate the creation/reuse of descriptive and administrative metadata across preservation and management systems.
- Streamline the ingest and deposit of content in a preservation repository.
- Find solutions that meet the Bentley’s local needs, but which are also flexible and scalable for other institutions; modular, so that institutions may adopt some, none, or all of the development features; and based upon open standards so that other tools and/or repository platforms could be integrated.
- Share all code and documentation with the archives and digital preservation communities.

As staff at the Bentley and the University of Michigan Library worked with project developers from Artefactual Systems on user stories and a review of functional requirements, a list of significant development tasks emerged, which included:

- The introduction of functionality to appraise and review content from within Archivematica so that archivists can acquire a fuller understanding of the nature and scope of born-digital collections. Allowing archivists to perform this work in the Archivematica dashboard would obviate the need to navigate and record information from multiple external tools and systems and greatly facilitate the training of staff. The resulting ‘Appraisal and Arrangement’ tab in Archivematica was designed to allow users to characterize distributions of file formats within acquisitions, identify sensitive data, and preview content and also to apply tags for the purpose of recording information about restrictions, deaccessions, and/or the intellectual arrangement of materials.
- The integration of Archivematica and ArchivesSpace via the introduction of an ArchivesSpace ‘pane’ within the Appraisal and Arrangement tab. This feature utilizes the ArchivesSpace Application Programming Interface (API) to create and edit descriptive metadata for new or existing archival objects in ArchivesSpace; display resource records in a tree view, depicting the intellectual hierarchy of archival objects; and drag and drop digital content onto archival description to create ArchivesSpace digital object records and launch the ingest of Submission Information Packages (SIPs) in Archivematica.
- The integration of Archivematica and DSpace so that fully ingested content (a single Archival Information Package, or “AIP”) and associated descriptive metadata will be automatically uploaded as a unique item in DSpace. The persistent URL (a “handle”) will in turn be written back to ArchivesSpace so that it may serve as a link to the digital content via the ASpace public user interface or when archival description is exported to an Encoded Archival Description (EAD) finding aid. See below for a representation of this data flow:

![](https://journal.code4lib.org/media/issue35/shallcross/00.jpg) **Figure 1.** Dataflow between ArchivesSpace, Archivematica and DSpace mapped to Sequential Actions of the Digital Curation Centre (DCC) Curation Lifecycle Model.

The primary use case employed for the planning and development aspects of the project involved a large accession of digital archives from the office of former U.S. Senator Carl Levin, which amounted to 1.2 TB of data and some 217,135 files. This content was selected for its scale, diverse array of content, and variation in structure (from meticulously organized folders to loose aggregations of files), with the acknowledgement that it would inform and be applicable to other use cases. At the same time, the ArchivesSpace-Archivematica-DSpace Workflow Integration project is intended to be flexible enough to accommodate a wide variety of local practices and collections. Code for the Appraisal and Arrangement Tab will be integrated in version 1.6 of Archivematica (to be released in 2017) and is currently available at [https://github.com/artefactual-labs/appraisal-tab](https://github.com/artefactual-labs/appraisal-tab).

### In-Depth Review of Key Development Tasks/Project Features

#### Appraisal and Arrangement tab

Archivists begin by creating records for all accessions, regardless of format, in ArchivesSpace. Accession records are then associated with an existing ArchivesSpace resource record (i.e., finding aid) or, if necessary, an archivist may generate a new resource record based on accession record data.

Any digital content associated with the accession is then transferred into Archivematica’s backlog. During this process, Archivematica runs through a number of micro-services, assigning UUIDS to transfers and files, assigning checksums (or verifying them if present), unzipping zipped or otherwise packaged files, scanning for viruses, indexing, performing file format identification and validation, and extracting technical metadata. Transfers remain in the backlog with a minimum level of control until they are ready to be retrieved and processed at a later date.

The new Appraisal tab sits between the current Transfer and Ingest tabs in Archivematica, and provides a number of features that allow archivists to appraise and review content from within Archivematica so that archivists can acquire a fuller understanding of the nature and scope of born-digital collections. These features include the ability to characterize transfers, identify sensitive data, preview content, and tag content for restrictions and other purposes as well as create an intellectual arrangement for materials.

After performing a search (e.g., by accession number) for one or more transfers in the Archivematica backlog, archivists may select an entire transfer, a folder within a transfer, or individual files and perform a number of analyses on this content based on technical and other metadata extracted during Archivematica’s initial transfer micro-services. The “objects” analysis, for example, gives a report of file formats which archivists may view as a tabular report or as a visualization.

![](https://journal.code4lib.org/media/issue35/shallcross/01.png) **Figure 2.** Tabular report of file formats in a transfer folder

![](https://journal.code4lib.org/media/issue35/shallcross/02.png) **Figure 3.** Visualization of file formats in a transfer folder

Selecting a format or Format Policy Registry (FPR) group from either the tabular report or visualization applies a facet to the transfer selection and populates the transfer file list pane with files of that format. Archivists may preview individual files from this pane; file formats that are supported by the archivist’s browser (e.g., PDF and many image file formats) will be displayed in the Appraisal tab, while a copy of any file can be downloaded for viewing locally using the utility of the archivist’s choice.

![](https://journal.code4lib.org/media/issue35/shallcross/03.png) **Figure 4.** Previewing a PDF in the Archivematica dashboard

The “examine contents” analysis allows archivists to identify sensitive data by exploring bulk\_extractor log content for Personally Identifiable Information (PII) such as Social Security numbers and credit card numbers. When an individual file is selected, archivists get a tabular view of the content of a hit and its surrounding context. The identification of this type of data can be used to inform appraisal and processing decisions, e.g., after confirming that a hit is indeed an example of PII, an archivist may choose to separate this content or apply a particular access restriction. At this time, this functionality is only informative, as the user is not able to redact the PII from content.

![](https://journal.code4lib.org/media/issue35/shallcross/04.png) **Figure 5.** Identifying (valid but fake) Social Security Numbers using bulk\_extractor logs

Finally, archivists may apply ephemeral tags (i.e., they are not maintained as part of the AIP) to content in a number of places. Intended as a type of virtual Post-it note, possible use cases for tags include:

- Tagging everything an archivist plans to arrange to a particular series or sub-series (and later use tags to facet objects in the backlog to facilitate this arrangement).
- Tagging sensitive or restricted content as it is identified.
- Applying tags as a simple *aide-memoire* during processing.

![](https://journal.code4lib.org/media/issue35/shallcross/05.png) **Figure 6.** Tagging in the backlog pane and the file list pane, and viewing a “tags” analysis

#### Archivematica-ArchivesSpace integration

The integration of Archivematica and ArchivesSpace was designed to allow archivists to search for ArchivesSpace resource records, to edit or add to existing archival description, and to create ArchivesSpace digital object instances with which content from the Archivematica backlog can be associated from within the Archivematica Appraisal and Arrangement tab. This functionality, which uses the ArchivesSpace API, allows archivists to associate digital content with archival description without navigating between multiple systems and rekeying or copying and pasting metadata, achieving one of the key project goals of facilitating the creation/reuse of descriptive metadata.

Integration with an ArchivesSpace instance is configured in the ArchivesSpace DIP upload section of Archivematica’s Administration tab. Here, an Archivematica administrative user may enter the ArchivesSpace instance’s host URL, the backend port at which the ArchivesSpace API is running, and the username and password of an ArchivesSpace user with sufficient administrative privileges. In this example, we have created a user with the username “archivematica” in the local ArchivesSpace instance and, within that ArchivesSpace instance, given that user permissions to view, edit, and create ArchivesSpace resources and digital objects. No additional configuration files or changes to settings within ArchivesSpace are necessary to integrate Archivematica and ArchivesSpace.

![](https://journal.code4lib.org/media/issue35/shallcross/06.png) **Figure 7.** Configuring ArchivesSpace integration within Archivematica

Within the Appraisal tab’s ArchivesSpace pane, archivists may search for an existing ArchivesSpace resource by title or identifier and are presented with the full resource trees, including series, subseries, and additional levels of intellectual arrangement, for any matching collections:

![](https://journal.code4lib.org/media/issue35/shallcross/07.png) **Figure 8.** An ArchivesSpace resource record rendered in the Appraisal tab

By selecting a particular archival object within the resource tree, archivists may edit a minimal amount of existing metadata, including the archival object’s title, level of description, general note, and conditions governing access note:

![](https://journal.code4lib.org/media/issue35/shallcross/08.png) **Figure 9.** “Edit Metadata” template

Archivists may also create a new child archival object below the selected component and enter a slightly expanded set of metadata:

![](https://journal.code4lib.org/media/issue35/shallcross/09.png) **Figure 10.** New child record metadata template

The metadata fields that may be edited or created within the ArchivesSpace pane reflect both the minimum metadata fields required to create an ArchivesSpace archival object (level of description and a title or a date) in addition to a few select fields–the “General note” (mapped to “General” note in ArchivesSpace and the <odd> Other Descriptive Data tag in EAD) and the “Conditions governing access note,” for example–that Bentley archivists frequently use to describe digital content. More extensive metadata editing or creation, including the creation of additional notes or the reordering of archival objects within a resource tree, will be done directly in ArchivesSpace rather than in the Appraisal tab.

Once an ArchivesSpace archival object with which to associate digital content has been identified or created, an ArchivesSpace digital object instance can be associated with that archival object. Relevant content from Archivematica’s transfer backlog can then be associated with the digital object by dragging and dropping folders or individual files from the backlog pane onto the digital object. After all relevant content has been associated with a given digital object, archivists will finalize arrangement to initiate Archivematica’s Ingest workflow and the deposit of content to DSpace.

![](https://journal.code4lib.org/media/issue35/shallcross/12.png) **Figure 11.** The “Newsletters” folder from the Backlog pane dragged and dropped onto an ASpace digital object

#### Archivematica-DSpace integration

The integration of Archivematica and DSpace was designed to streamline the ingest and deposit of content into a preservation and access repository. Once processors have finalized appraisal and arrangement, Archivematica runs SIPs through several ingest micro-services, including normalization, and packages them into AIPs. AIPs are then automatically deposited into DSpace utilizing a number of new features that were developed as part of this project.

Archivists configure the DSpace integration within Archivematica’s Storage Service.\[[6](https://journal.code4lib.org/articles/#en6)\] A new “DSpace via SWORD v2” Archivematica “space” points to a particular instance of DSpace and an associated service document (which describes the “contract” between a particular user and a repository), a username and password and a DSpace “group” (a kind of entity that can be granted permissions in the authorization system) to be used for restricted metadata. New “locations” on that space (which inherit the same configurations) point Archivematica to particular DSpace collections using the collection’s Handle and a short description (such as the collection title)..

![](https://journal.code4lib.org/media/issue35/shallcross/10.png) **Figure 12.** Configuring a “space” for “DSpace via SWORD2 API” within Archivematica’s Storage Service

![](https://journal.code4lib.org/media/issue35/shallcross/11.png) **Figure 13.** Configuring a “location” for a DSpace collection within Archivematica’s Storage Service

During Archivematica’s final ingest microservice, “Store AIP,” archivists select (or preconfigure) the Archivematica location corresponding to the appropriate DSpace collection to which the AIP will be moved.

![](https://journal.code4lib.org/media/issue35/shallcross/13.png) **Figure 14.** Selecting a DSpace collection during Archivematica’s “Store AIP” micro-service

When the “Store AIP” process begins, Archivematica fetches key bits of descriptive metadata about the AIP from ArchivesSpace, such as:

- A display title that concatenates a component’s title and creation date(s).
- An abstract, mapped from the general note.
- The creator or author.

These bits of information (which are also included in the METS file of the AIP) are used to populate metadata fields on the DSpace item to facilitate searching and browsing within DSpace (and for Search Engine Optimization). Other bits of information, such as the date of publication and a copyright statement, are generated on-the-fly or hard-coded.

AIPs in Archivematica (which, by default, are packaged in accordance to the Library of Congress BagIt specification and whose data directory consists of the METS file for the AIP and three folders: logs, objects and thumbnails) are then repackaged into “objects” and “metadata” packages:

- The objects package contains the objects folder and includes original and normalized objects as well as some associated metadata and submission documentation.
- The metadata package contains everything else, e.g., the normalization log, malware scan log and the extraction log. It also includes, importantly, bulk\_extractor logs that indicate the precise location of the credit card numbers, social security numbers and other types of sensitive information.

In DSpace, items and their associated bitstreams inherit the permissions of the collections or communities to which they belong. For the Bentley, this means that unless otherwise stated, items and their bitstreams that are deposited using this method are openly accessible to anyone.

In most cases, this is desirable behavior for the objects package. When it is deposited, it will be open (i.e., belonging to the “Anonymous” group in DSpace)\[[8](https://journal.code4lib.org/articles/#en8)\]. However, in order to ensure that the sensitive data contained in the metadata package does not remain public, Archivematica applies the group configured earlier for restricted metadata in the DSpace space. In the Bentley’s case, this means that only DSpace users that belong to a “Bentley Archivists” group may access the bitstream.

![](https://journal.code4lib.org/media/issue35/shallcross/14.png) **Figure 15.** A DSpace item with open and restricted bitstreams

Data deposit is facilitated by the Simple Web-service Offering Repository Deposit (SWORD v2) protocol, an interoperability standard that allows digital repository servers to accept the deposit of content from clients via a standardized protocol.\[[7](https://journal.code4lib.org/articles/#en7)\] With it, an item is posted to a particular DSpace collection with minimal metadata and two bitstreams are posted to that item, one each for the objects and metadata packages.

While Archivematica goes on to use the DSpace API to update the permissions on the metadata bitstream (there are problems with the way that SWORD v2 handles permissions), using SWORD v2 for the initial deposit keeps this integration in line with the project’s goal that outcomes are flexible and modular. DSpace is only one of a number of SWORD-compliant repositories (others include arXiv, Dataverse, EPrints and Fedora); theoretically, an institution may replace DSpace with any of these other repository platforms. Keeping the deposit simple (e.g., with minimal metadata and a predictable structure and outcomes) also ensures that, even with the use of the DSpace API, this integration will work with other instances of DSpace, not just the University of Michigan’s highly customized implementation of DSpace, Deep Blue.

Finally, Archivematica completes the deposit by making use of the ArchivesSpace API to write the Handle of the DSpace item back to the File URI of the linked digital object in ArchivesSpace. This ensures that archivists can manage the locations of collection components, physical and digital, in ArchivesSpace.

### Conclusion

The ArchivesSpace-Archivematica-DSpace Workflow Integration Project concluded on October 31, 2016 with the successful completion of all development tasks and the code will be included in the release of Archivematica version 1.6. To use the new appraisal functionality, interested parties will simply need to install or upgrade Archivematica and the Archivematica Storage Service. To use the optional ArchivesSpace and/or DSpace integrations, archivists or system administrators will need to configure the integrations by pointing Archivematica at the appropriate instances of ArchivesSpace and/or DSpace (with users that have adequate authorizations) and enable SWORD v2 in DSpace as well as the REST API, which are disabled by default.

The Bentley is currently working with Artefactual Systems on some additional development work to fully integrate the new features into the University of Michigan’s local infrastructure and processes. While the project has resulted in fully functional deliverables that may be employed by members of the archives and digital preservation communities, the project team hopes that these outcomes evolve and improve as more institutions employ the Appraisal and Arrangement tab and adapt it to local needs or integrate new functionality. In recent professional meetings (including the 2016 Society of American Archivists annual meeting and the inaugural Archivematica Camp\[[9](https://journal.code4lib.org/articles/#en9)\]), peers have suggested a variety of exciting potential features and improvements, which include:

- Treemap visualizations of files and folders
- Integration of Tim Walsh’s Brunnehilde, “a Python-based reporting tool for born-digital files that builds on Richard Lehane’s Siegfried. Brunnhilde runs Siegfried against a specified directory, loads the results into a sqlite3 database, and queries the database to generate CSV reports to aid in triage, arrangement, and description of digital archives.”\[[10](https://journal.code4lib.org/articles/#en10)\]
- Introduction of additional analysis tools to work with indexed contents of digital files, such as Named Entity Recognition, topic modeling, natural language processing, network analysis visualizations, etc.

We look forward to working with other members of the archives and digital preservation communities on expanding the functionality and applications of this integration project.

Readers are encouraged to see the project blog ([http://archival-integration.blogspot.com/](http://archival-integration.blogspot.com/)) or to contact the Bentley’s grant team ([bhl-mellon-grant@umich.edu](https://journal.code4lib.org/articles/)) for more information or updates on the work with Archivematica and the new Appraisal and Arrangement tab.

### Notes

\[[1](https://journal.code4lib.org/articles/#n1)\] The Bentley Historical Library’s archival community in Deep Blue is available at [https://deepblue.lib.umich.edu/handle/2027.42/65133](https://deepblue.lib.umich.edu/handle/2027.42/65133).

\[[2](https://journal.code4lib.org/articles/#n2)\] For more information on AutoPro, please see this poster and short paper from the 2012 iPRES conference at [http://hdl.handle.net/2027.42/95923](http://hdl.handle.net/2027.42/95923).

\[[3](https://journal.code4lib.org/articles/#n3)\] For more information on ArchivesSpace, please see [http://archivesspace.org/](http://archivesspace.org/).

\[[4](https://journal.code4lib.org/articles/#n4)\] For more information on Archivematica, please see [https://www.archivematica.org](https://www.archivematica.org/).

\[[5](https://journal.code4lib.org/articles/#n5)\] For more information on DSpace, please see [http://www.dspace.org/](http://www.dspace.org/).

\[[6](https://journal.code4lib.org/articles/#n6)\] For more information on the Archivematica Storage Service, please see [https://www.archivematica.org/en/docs/storage-service-0.9/](https://www.archivematica.org/en/docs/storage-service-0.9/).

\[[7](https://journal.code4lib.org/articles/#n7)\] For more information on the SWORD protocol, please see [http://swordapp.org/sword-v2/](http://swordapp.org/sword-v2/).

\[[8](https://journal.code4lib.org/articles/#n8)\] Archivematica does not support the automated deposit of items to DSpace with objects packages that need access restrictions. Alternative, local workflows are being developed for this type of material.

\[[9](https://journal.code4lib.org/articles/#n9)\] For more information on the 2016 Archivematica Camp, please see [https://wiki.archivematica.org/Community/Camps/UMSI2016](https://wiki.archivematica.org/Community/Camps/UMSI2016).

\[[10](https://journal.code4lib.org/articles/#n10)\] For more information on Brunnehilde, please see [https://github.com/timothyryanwalsh/brunnhilde](https://github.com/timothyryanwalsh/brunnhilde).

### Author Biographies

Max Eckard ([eckardm@umich.edu](https://journal.code4lib.org/articles/)) is the Assistant Archivist for Digital Curation with the Bentley Historical Library at the University of Michigan. Prior to that, he was the Metadata and Digital Curation Librarian at Grand Valley State University. A graduate of the School of Library and Information Sciences at North Carolina Central University, he is passionate about digital curation, users and user experience, and service.

Dallas Pillen ([djpillen@umich.edu](https://journal.code4lib.org/articles/)) is the Assistant Archivist for Metadata and Digital Projects at the University of Michigan’s Bentley Historical Library, primarily involved with the Bentley’s ArchivesSpace-Archivematica-DSpace Workflow Integration project, its ArchivesSpace implementation, and its web archiving program.

Mike Shallcross ([shallcro@umich.edu](https://journal.code4lib.org/articles/)) is the Assistant Director for Curation at the Bentley Historical Library and an Adjunct Instructor at the University of Michigan School of Information. In addition to his extensive experience developing and implementing digital archives workflows, he oversees the Bentley’s digitization program, conservation unit, and processing operations for digital, analog, and physical materials.
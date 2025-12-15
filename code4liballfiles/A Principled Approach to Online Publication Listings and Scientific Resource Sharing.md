---
title: "A Principled Approach to Online Publication Listings and Scientific Resource Sharing"
source: "https://journal.code4lib.org/articles/2520"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-03-23
created: 2025-01-10
description: "The Max Planck Institute (MPI) for Psycholinguistics has developed a service to manage and present the scholarly output of their researchers. The PubMan database manages publication metadata and full-texts of publications published by their scholars. All relevant information regarding a researcher's work is brought together in this database, including supplementary materials and links to the [...]"
tags:
  - "clippings"
---
# A Principled Approach to Online Publication Listings and Scientific Resource Sharing
Jacquelijn Ringersma, Karin Kastens, Ulla Tschida, Jos van Berkum

The Max Planck Institute (MPI) for Psycholinguistics has developed a service to manage and present the scholarly output of their researchers. The PubMan database manages publication metadata and full-texts of publications published by their scholars. All relevant information regarding a researcher’s work is brought together in this database, including supplementary materials and links to the MPI database for primary research data. The PubMan metadata is harvested into the MPI website CMS (Plone). The system developed for the creation of the publication lists, allows the researcher to create a selection of the harvested data in a variety of formats.

## Introduction

Scholars report and document their work in the form of peer- or publisher-reviewed publications. This research output, listed on websites, has become one of the most important sources for information exchange. Individual scholars, research groups and entire institutes are interested in presenting all relevant data regarding their research output in an accessible and efficient manner.

In the context of a new website designed for the Max Planck Institute for Psycholinguistics (MPI-PL), we developed a principled solution to dynamically render all relevant data related to a publication into publication lists on different levels of the website. We addressed the need for open access as well as the requirement to make primary data and other supplementary information simultaneously available.

The publication metadata is harvested from an institutional repository, called PubMan. The data is then presented on publication lists, which can be customized according to the researcher’s or the institute’s preferences. These lists contain links to the full text resources which are stored in the institutional repository, links to supplementary data which are stored in the institute’s IMDI research data archive, and links to other resources.

In this paper, we will first describe the two databases involved, the PubMan publication repository and the MPI-PL primary data archive. We will then elaborate on the data exchange requirements for the website and the information flows in the institute. Finally, the mechanisms and functionality for the data exchange between the databases and website are explained and illustrated.

This paper might be of interest for librarians and information officers who are seeking a solution to help researchers present their research output elegantly bundled together.

## 1\. Publication repository and primary research data archive

Two databases play an essential role in our principled approach to online publication listings and scientific resource sharing: PubMan from the Max Planck Digital Library and the MPI-PL primary research data archive.

### 1.1 Institutional background

The German Max Planck Society (MPS) is a large, non-profit research organization, with 76 research institutes, conducting basic research in physical science, arts, and humanities \[[1](https://journal.code4lib.org/articles/#L-1)\]. The service unit Max Planck Digital Library (MPDL) was established in 2007, with the aim to provide information management services to the MPS researchers and the institute’s libraries \[[2](https://journal.code4lib.org/articles/#L-2)\]. One of the primary MPDL projects has been the development of an online publication management system (PubMan), which is based on eSciDoc \[[3](https://journal.code4lib.org/articles/#L-3)\], an eResearch infrastructure. PubMan stores, manages and delivers the MPS publication data, publications and corresponding supplementary materials.

The MPI-PL is one of the MPS institutes \[[4](https://journal.code4lib.org/articles/#L-4)\], with some 200 researchers in 9 research groups. The technical support unit (TG) has built up extensive knowledge of technical infrastructures and archive federations. The TG maintains a digital archive which stores primary research data collected by the researchers of the institute. The data is available in the online IMDI archive \[[5](https://journal.code4lib.org/articles/#L-5)\]. The scientific library of the institute has a collection of 30,000 books, 20,000 bound journal volumes, and provides online access to 30,000 scientific journals. The publication management of the institute and its individual researchers is supported by the library.

### 1.2 PubMan

PubMan supports scientists and institutes of the MPS in the sustainable management, re-use and digital curation of their publications. PubMan is based on a service-oriented architecture, the eSciDoc infrastructure \[[3](https://journal.code4lib.org/articles/#L-3)\], which uses Fedora as its underlying repository. Objects and their relations are stored in XML \[[S-1](https://journal.code4lib.org/articles/#S-1)\]; the software supports open formats and interfaces such as REST, SRU/SRW and OAI \[[9](https://journal.code4lib.org/articles/#L-9)\]. The publications are described with a metadata set, which is based on an extended Dublin Core Standard \[[6](https://journal.code4lib.org/articles/#L-6)\]. The metadata set is very rich and includes elements to specify the publication details (title, abstract, date(s), DOI, publication type), author details (name, affiliations), accessibility, source, and other relevant data. Interoperability is guaranteed with other publication metadata standards, like MODS \[[7](https://journal.code4lib.org/articles/#L-7)\].

In PubMan, various document types can be described, with their corresponding bibliographic metadata. To describe the content type of the referenced text documents and to enable concise search and retrieval, the uploaded or externally referenced documents are categorized as “Preprints”, “Postprints”, “Publisher PDF” or “Supplementary Material” \[[14](https://journal.code4lib.org/articles/#L-14)\]. The vocabulary used is based on the recommendations by the SHERPA project \[[15](https://journal.code4lib.org/articles/#L-15)\]. As soon as the object is released, the metadata is open for search. However, the access to the publications themselves can be set to Public, Private or can be made available only to defined user groups. Persistent identifiers (Handle System \[[8](https://journal.code4lib.org/articles/#L-8)\]) are being attributed to both the metadata object and the file(s) attached. The Handle System is a technology specification for assigning, managing, and resolving identifiers for digital objects and other resources on the Internet. Each object is assigned a (numerical) name, which is unique for that object. It allows users to bookmark the resources or create persistent links to the resources. Persons are managed with a unique ID in a separate service, the Control of Named Entities service, which allows the tracking of name variants and (historic) relations of a person to Organizational units. Organizational units themselves are managed as objects, with unique IDs, via the Object handler. This allows queries for specific organizational units, such as projects, departments or institutes.

Various functionalities have been developed for scientists to submit their publications, in order to make imports and submissions easy. References can be imported from external databases (e.g. arXiv) or local reference management software (e.g. EndNote); manual submissions can be done in a short, 3-step submission.

### 1.3 MPI-PL research data archive

The MPI-PL research data archive contains some 250,000 objects with a total size of around 40 Terabytes. The archive mostly holds linguistic data, bundled in ‘sessions’. A session may include video files, audio files as well as transcriptions or annotations (the resources). The resources all refer to the same linguistic event which is described by a compulsory metadata description, using the IMDI metadata set \[[5](https://journal.code4lib.org/articles/#L-5)\].

The archive is organized according to the IMDI catalogue principles, in that resource bundles pertaining to the same linguistic event are described with a set of metadata and organized in a tree structure of corpus nodes \[[5](https://journal.code4lib.org/articles/#L-5), [16](https://journal.code4lib.org/articles/#L-16), [17](https://journal.code4lib.org/articles/#L-17)\].  In the MPI archive for research data, we follow the principles of OAI by having the metadata files online available (open) for browsing and searching on the web \[[9](https://journal.code4lib.org/articles/#L-9)\]. An Access Management System (AMS) has been developed to regulate access to the resources. Using AMS the researcher can grant (or deny) access to individual users or groups of users, set ‘codes of conducts’ on the data to be signed by visitors, or can allow access to the data for everybody (open resources). Each object (metadata file or resource) in the archive has a persistent identifier.

## 2\. Website requirements

On the new MPI-PL website each researcher is assigned a set of folders and pages (the full set is named ‘person pages’) of which one folder is designed to display publication lists and one folder to display presentation lists. The same is true for research groups and projects: each of these organizational units is assigned a set of folders and pages (‘group pages’ and ‘project pages’ respectively), again two of which are designed to display publication lists and presentation lists. In the following sections of this paper we discuss the requirements and functionality designed for the publication lists. Because the requirements and functionality are the same for presentations lists as they are for publication lists, we will not be discussing the presentation lists in this paper.

For the website to be successful, it had to support the researcher’s normal workflow for managing publications.  This meant that the following requirements had to be fulfilled:

1. Researchers should only have to submit their publication data once and in a trusted repository;
2. The output from the databases had to be formatted according to currently defined standards in scientific publication listing. In our institute we use the rules of the Publication Manual of the American Psychological Association\[[13](https://journal.code4lib.org/articles/#L-13)\]. It had to be possible to supply more details, like abstracts, links to full texts and/or DOI’s without disturbing the initial APA styled publication list;
3. The difference between the primary data in the MPI-PL IMDI archive and the publication metadata in PubMan had to be invisible for the website visitor. Links to primary data and links to publication data belonging to one publication had to be listed together;
4. The labeling of ‘default’ publication types, like, e.g., journal article, book, book chapter, proceedings papers, etc., had to conform to the standards used in our institute.
5. The sorting of the publications on the page had to conform to standards used in a specific scientific domain. It had to be possible to sort by publication year (mostly used by psychologists) or by publication type (used by linguists).

The initial information flow from the databases into the website is given in Figure 1. The MPI website ([www.mpi.nl](http://www.mpi.nl/)) is right of the center in the blue box. In the information flow, the publication lists of the person, project and group pages are filled from the PubMan database. Data is entered into the PubMan database by scientists, the secretaries of the research groups, and the library staff. The latter also moderates the submissions, based on a quality assurance workflow.

[![](https://journal.code4lib.org/wp-content/uploads/2010/03/Figure1-300x225.jpg "Figure1 - Information Flow")](https://journal.code4lib.org/wp-content/uploads/2010/03/Figure1.jpg)

Figure1 - Information Flow

During the design phase of the website, it became clear that the PubMan database also required access to primary research data. However, PubMan is not designed to store larger amounts of primary data (e.g., video or audio files). The metadata set is specific for publications and the access management system is not (yet) refined enough to easily define access rights and user roles for individual users and groups of users outside the MPS community. We therefore had the PubMan metadata set extended by a field (locator) which is specifically designed to link to external research data. These data can originate from the MPI-PL data archive, or from other external resources. Thus, PubMan allows both the storage of supplementary material within the repository as well as referencing of externally located material.

The third database mentioned in Figure 1 is the MPI-PL people database. In this paper we do not further discuss this database, but its role is to feed the website with up to date information on the MPI-PL staff. The ‘person pages’ are created from this database.

Figure 1 shows that PubMan may also output to other platforms, such as the annual report or publication lists for research evaluations. These publication lists may also need to appear on the website.

We have described the general requirements for data submission, retrieval and interaction between the two databases. During the design phase of the website it also became clear that researchers have individual requirements and requests on the lay-out of their publication lists, such as whether or not to show certain publications on their web pages. We list below a few of these special requirements. During the project we have also learned that the number of variations on these special requirements can even be larger than the number of researchers in the institute:

1. Some researchers do not just want to display their publications lists either by year or by publication type, but by a combination of the two;
2. The default publication types which were defined by the research community during the initial design phase could not meet the needs of everyone, therefore we had to create the functionality for the creation of publication lists that are flexible, allowing researchers to define their own set of publication types;
3. With respect to multi-authored publications, one researcher might want it to be displayed on his web page, while the co-authors don’t;
4. On certain pages researchers only want to display a list of their very special (golden) publications, or publications that are theme specific.

## 3\. Website implementations

The website was implemented using the open source content management system (CMS) Plone. A Plone CMS is built in a Zope environment. Zope is an open source application server for building content management systems, intranets, portals, and custom applications. Zope is written in Python, a highly-productive, object-oriented scripting language \[[10](https://journal.code4lib.org/articles/#L-10), [11](https://journal.code4lib.org/articles/#L-11)\]. In Plone, a website consists of a file system containing style sheets (CSS), content type definitions (e.g. for folders, pages, news items) and database communication scripts. Each content type has a specific aim, structure and lay-out. Folders are simply containers which can hold other content types; pages can contain content, news items are pages with a special format with regard to textual and image content. Content types are defined in a Python module containing the content type class declaration. The Plone file system further contains images used in the default design of the website (e.g. banners) and the website configuration. The content of the website is stored in one data file (data.fs) in the content Zope object database (ZODB). The file system and ZODB are joined by the Zope server application creating a website. An external company (Zest Software, Hoogvliet) was hired to implement the Plone file system, special content types and scripts, and to set up the Zope application server.

Nightly, our website CMS harvests the metadata for the publications of the institute from the PubMan database through a REST interface \[[12](https://journal.code4lib.org/articles/#L-12)\]. A search query is sent to the PubMan server (see Figure 2).  The query consists of the following elements. First the PubMan Rest interface is specified, next the escidoc contexts in which the MPI-PL data are stored are specified, then the export format and outformat are listed. For the needs of the CMS of the MPI-PL, the output format ’snippet’ is selected, which provides the complete XML, including the bibliographic citation in the desired export format (APA). The full texts and supplementary material are not imported into the CMS; however, the persistent URLs to the resources are included in the metadata. An XML file containing the publication metadata is returned to the web server.

> http://pubman.mpdl.mpg.de/search/SearchAndExport?cqlQuery=escidoc.content-model.objid=escidoc:persistent4
> 
> AND escidoc.context.objid any “escidoc:54203 escidoc:61348 escidoc:57277″&exportFormat=APA&outputFormat=snippet&language=all&sortKeys=&sortOrder=ascending&startRecord=&maximumRecords=

Figure 2 – Website Query to PubMan Database

A special Plone content type ‘publication-data’ was created to store the data for each individual publication. The content type ‘publication-data’ has a set of attributes which can have a value: (1) the PubMan ID, (2) the APA citation of the publication, (3) the abstract, (4) the publication type, (5) publication key words and (6) local tags. For each publication, the information from the harvested XML file is stored in one ‘publication-data’ item. The name of each instance of a ‘publication-data’ is equal to the file ID in the PubMan database. The complete set of ‘publication-data’ items are stored in a ‘Publication’ folder in the Plone CMS. The folder is not visible within the navigation system or site set-up. Its main purpose is to store the ‘publication-data’ items. The process of import and conversion from the XML file to individual ‘publication-data’ items for each publication is controlled by a Python script on the server \[[S-2](https://journal.code4lib.org/articles/#S-2)\].

The next step is to show a selection of the harvested publications on the publication list of the researcher’s ‘person pages’ (or likewise on the project or group publication lists). For this we have created a special Plone content type, built out of a standard Plone ‘Collection’. A ‘Collection’ in Plone works like a query does in a database. In the ‘Collection,’ users can specify a set of criteria to search the website. In the regular content type ‘Collection’ these criteria contain items such as ‘type’ or ‘publishing data’. For the ‘publication list Collection’ in the website, the researcher performs a query on the hidden ‘Publication’ folder holding all the institute’s publications. The set of search criteria is based on the requirements for publication lists, namely: author name, organizational unit, publication year, publication type, etc. Researchers can create a list containing only their own publications, simply by selecting their name from the value list in the ‘author’ field. Once a researcher has set his criteria, all publications subsequently entered into PubMan and then harvested by the CMS that match these criteria will be automatically displayed on his publication list. Lists can be displayed either by ‘year’ or by ‘publication type’ (see Figure 3).

[![](https://journal.code4lib.org/wp-content/uploads/2010/03/Figure3-300x225.jpg "Figure 3 - Publication list (by type)")](https://journal.code4lib.org/wp-content/uploads/2010/03/Figure3.jpg)

Figure 3 - Publication list (by type)

On the publication pages, the references are formatted in APA citation style (see Figure 3), which displays the author names, publication year, title, source, and, if needed, a reference pointing to a DOI or URL where an online resource can be retrieved. A bibliographic reference does not give specifications on content, like an abstract. Nor does it always specify a link to a publisher DOI, a version of the full text, or a link to primary data that supports findings in the paper. For the researchers in the MPI-PL, it was essential that this kind of information would be available on their publications lists. When additional information is available in PubMan a ‘more >’ after the APA citation provides a link to a pop-up window. In this pop-up window, the APA citation is followed by the abstract and link(s) to the persistent PubMan URL of the full text if the researcher has set the full text as publicly available. If the full text allows only restricted access, a request form for the material is offered. In addition, links to supplementary material are either stored in PubMan or elsewhere are displayed (see Figure 4).

[![](https://journal.code4lib.org/wp-content/uploads/2010/03/Figure4-300x225.jpg "Figure 4 - Supplementary material link to MPI-PL IMDI archive")](https://journal.code4lib.org/wp-content/uploads/2010/03/Figure4.jpg)

Figure 4 - Supplementary material link to MPI-PL IMDI archive

In the system we developed, researchers are offered a default set of publication types. This set conforms to the standards used in our institute. These publication types are also used as headings for the publication lists by type. However, some of our researchers wished to deviate from this standard set and use publication types chosen by themselves. We made this possible through a mechanism that creates sub-folders in combination with a new metadata element. On our request the PubMan MPDL development team included in the administrative metadata for publications, an extra field called ‘local-tags’.

Local-tags are used to group publications, such as ‘my special publications,’ and also to collect certain publications which couldn’t be selected with the standard genre types, such as ‘book review’ or ‘invited talks’. Local-tags can also be used to exclude specific publications from being displayed even though they match the selection criteria.

For specific list displays, local-tags are used to display a certain group of publications under the desired heading, for instance, ‘book review’. Using the Plone subfolder system, lists can be headed and titled by the required publication type naming matching the search criteria from the local-tag. The end result, consisting of a set of sub-folders, has exactly the same look as the default list (as shown in Figure 3), but with adjusted headings.

Finally, the ‘local-tag’ element in the PubMan database is used to create publication lists for special purposes, such as annual reports, special internal publication lists or lists for evaluations. The library staff adds a ‘local-tag’ value to the metadata of those publications which need to be on (one of) these specific lists. The lists can then be generated using the same collection mechanism as the website lists. The collection can be stored in the CMS of the website and either be made public and linked in or have a restricted access for specific reviewers only.

## 4\. Conclusion

Researchers are assessed by their output which, in most cases, is publications. Therefore views on publications, aggregated by different criteria (e.g. persons, projects, topics, “hot” papers etc.) are of major importance. The presentation of these lists, both in format and layout, depends on the carrier media (online or print) and the audience, for which they have been compiled (researcher colleagues, advisory boards, funding boards, reviewers). Besides the provision of bibliographic citations, it is beneficial to provide access to the actual publication, and in most cases, the access to the corresponding supplementary material is of benefit to the audience.

However, the core task of researchers is to do research and write publications. The management of the research output should be easy, flexible, and time efficient. The functionality we developed involves the storage of the publication data in one single repository: the PubMan database. This database not only contains the bibliographic metadata of the publications, it also stores the full texts of the publications with the possibility to set access levels, thus providing an instrument for open access. It also provides links to the full texts through their native interfaces, like publisher repositories, and links to supplementary data stored in archives, for instance the MPI-PL primary data archive. This results in a complex item in PubMan that combines all relevant data on a publication.

The principled approach to publication listings is complex in information structure, but our researchers find it easy to use. Both PubMan and our website became functional in the spring of 2009. After some introductory sessions on the CMS, the data entry in PubMan and the PubMan-Website interface, the standard listings on the website are mostly created by the researchers themselves. For the creation of listings with special headings, or for output for other platforms, the library staff of the institute still intervenes. About 80% of our research staff, and 30% of our support staff, have PubMan-based publication listings on the website.

The system we have developed was designed especially for the Plone/Zope CMS. Since we are committed to the Open Source principle, the Python script, special content types and selection mechanisms can be re-used in any Plone/Zope based website and can be obtained from the MPI-PL information management unit or one of the authors of this paper. We cannot judge whether the script and functionality are also suitable for other CMSs; however, the principle behind it will be of interest to other information management units in research institutes. The functionality is not specific to the linguistic scientific domain in which the MPI-PL is active. By accident, we found out that the Python script which harvests the MPI-PL data from PubMan, also works for other scientific domains. During test phases we made a typographical error in the harvest query, which resulted in the harvest of the publication data of another Max Planck Institute (in the physics domain). The ‘publication-data’ that were stored in our CMS were correct and conform to the scientific requirements. In principle, this means that the functionality we have created has (at least) a user potential of 12,000 researchers of the MPS, but might also be of interest for other scientific libraries or information management units.

## Links

\[1\] Max Planck Society – [http://www.mpg.de](http://www.mpg.de/)

\[2\] Max Planck Digital Library – [http://www.mpdl.mpg.de/](http://www.mpdl.mpg.de/)

\[3\] eSciDoc – [http://www.escidoc.org](http://www.escidoc.org/)

\[4\] Max Planck Institute for Psycholinguistics – [http://www.mpi.nl](http://www.mpi.nl/)

\[5\] IMDI data archive – [http://corpus1.mpi.nl](http://corpus1.mpi.nl/)

\[6\] Dublin Core, Application Profile – [http://colab.mpdl.mpg.de/mediawiki/ESciDoc\_Application\_Profile\_Publication](http://colab.mpdl.mpg.de/mediawiki/ESciDoc_Application_Profile_Publication)

\[7\] MODS Metadata object description schema – [http://www.loc.gov/standards/mods/](http://www.loc.gov/standards/mods/)

\[8\] Handle System – [http://www.handle.net/](http://www.handle.net/)

\[9\] Open Archives Initiative (OAI) – [http://www.openarchives.org](http://www.openarchives.org/)

\[10\] Plone/Zope – [http://plone.org/](http://plone.org/)

\[11\] Python – [http://www.python.org/](http://www.python.org/)

\[12\] PubMan REST interface –  [http://pubman.mpdl.mpg.de/search/SearchAndExport\_rest\_sample.jsp](http://pubman.mpdl.mpg.de/search/SearchAndExport_rest_sample.jsp)

\[13\] American Psychological Association (2010) Publication manual of the American Psychological Association. 6th ed. Washington, DC: APA. [http://www.apa.org/](http://www.apa.org/)

\[14\] Metadata categories – [http://purl.org/escidoc/metadata/terms/0.1/content-category](http://purl.org/escidoc/metadata/terms/0.1/content-category)

\[15\] SHERPA project – [http://www.sherpa.ac.uk/romeoinfo.html](http://www.sherpa.ac.uk/romeoinfo.html)

\[16\] The IMDI metadata framework, its current application and future direction, by Daan Broeder, Peter Wittenburg  
International Journal of Metadata, Semantics and Ontologies (IJMSO), Vol. 1, No. 2, 2006

\[17\] Broeder, D., Brugman, H., & Senft, G. (2005). Documentation of languages and archiving of language data at the Max Planck Institute for Psycholinguistics in Nijmegen. Linguistische Berichte, no. 201, 89-103.

## Supplementary material

\[S-1\] [XML output](https://journal.code4lib.org/media/issue9/ringersma/APA_output-S-1.xml) of PubMan query for journal paper:  Van Berkum, J. J. A., Brown, C. M., Zwitserlood, P., Kooijman, V., & Hagoort, P. (2005).  Anticipating upcoming words in discourse: Evidence from ERPs and reading times. Journal of Experimental Psychology: Learning, Memory, and Cognition, 31(3), 443-467.

\[S-2\] Python script: ‘[pubman.py](https://journal.code4lib.org/media/issue9/ringersma/pubman.py)‘

## List of Figures

Figure 1: Information flow

Figure 2: Website query to the PubMan database

Figure 3: Publication list (by type)

Figure 4: Supplementary material link to MPI-PL IMDI archive

## About the Authors

Jacquelijn Ringersma (Jacquelijn dot Ringersma at mpi dot nl), Karin Kastens (Karin dot Kastens at mpi dot nl) and Jos van Berkum (Jos dot vanBerkum at mpi dot nl) work at the Max Planck Institute for Psycholinguistics in Nijmegen, the Netherlands and Ulla Tschida (tschida at mpdl dot mpg dot de) works at the Max Planck Digital Library in München, Germany.

The Max Planck Institute (MPI) for Psycholinguistics has developed a service to manage and present the scholarly output of their researchers. The PubMan database manages publication metadata and full-texts of publications published by their scholars. All relevant information regarding a researcher’s work is brought together in this database, including supplementary materials and links to the MPI data base for primary research data. The PubMan metadata is harvested into the MPI website CMS and allows selected data to be presented in a variety of formats.
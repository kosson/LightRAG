---
title: "Renewing UPEI’s Institutional Repository: New Features for an Islandora-based Environment"
source: "https://journal.code4lib.org/articles/8763"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-07-18
created: 2025-01-13
description: "In October of 2012, the University of Prince Edward Island (UPEI) launched an updated version of IslandScholar, UPEI’s Institutional repository. The repository, available from http://www.islandscholar.ca, is built on Islandora 6 (http://islandora.ca). The repository includes a number of new features, including: CSL integration for ingest, site display, and export of user-specific bibliographies; MADS-based Authority integration for [...]"
tags:
  - "clippings"
---
# Renewing UPEI’s Institutional Repository: New Features for an Islandora-based Environment
Donald Moses, Kirsta Stapelfeldt

In October of 2012, the University of Prince Edward Island (UPEI) launched an updated version of IslandScholar, UPEI’s Institutional repository. The repository, available from http://www.islandscholar.ca, is built on Islandora 6 (http://islandora.ca). The repository includes a number of new features, including: CSL integration for ingest, site display, and export of user-specific bibliographies; MADS-based Authority integration for Departments and Authors (with authorities created automatically using LDAP); batch ingest from Refworks (crosswalked to MODS for storage in the repository); embargo and statistics functions. Features from the first version of IslandScholar were also migrated to the new site, including Sherpa/Romeo integration (which provides just-in-time information about open access policies).

## The Evolution of UPEI’s IR

The provision of an Institutional Repository (IR) service has been a priority for the Robertson Library since 2008 with the release of University of Prince Edward Island’s *Strategic Research Plan 2008?2018*.  That document included as a strategic priority the development of, “a publicly accessible institutional repository which will contain citations for all research conducted at UPEI, as well as, in accord with copyright protocols, access to copies of our research documents, publications, and reports.” [\[1\]](https://journal.code4lib.org/articles/#note1) The first version of IslandScholar.ca was created shortly after and included the seeding of the repository with faculty citations harvested from RefWorks, tying-in authentication with UPEI’s LDAP service, the ability for faculty to add their own citations and attach the related publication, and integration with Sherpa/Romeo [\[2\]](https://journal.code4lib.org/articles/#note2), OpenURL and COinS [\[3\]](https://journal.code4lib.org/articles/#note3).

During February 2012 the University released a new policy entitled *Open Access & Dissemination of Research Output* [\[4\]](https://journal.code4lib.org/articles/#note4) which encourages:

1. scholars to deposit their scholarly research in IslandScholar,
2. scholars to publish in journals that allow scholars to retain copyright in their work,
3. scholars to consider open access and affordable / sustainable scholarly communication venues,
4. scholars to deposit other types of research output in IslandScholar (preprints, research data, etc.),
5. students to deposit their honours thesis, Master’s or PhD thesis on acceptance.

The policy specifies additional requirements such as ensuring that the content was harvestable and that deposited research data be linked to the final scholarly output.  To fulfill these needs and others, a set of requirements was drafted for an IslandScholar v2 and the new service was launched in October 2012. As with the first IslandScholar, the system was designed and is delivered using Islandora software, which was first developed by the Robertson Library.

## Summary of Changes

IslandScholar V2 received a design update with a new, responsive theme that enables the site to be accessed from most mobile devices. The data structure in the repository was modified to include additional objects and relationships, with the aim of improving the granularity and accuracy of the system’s ontology, and facilitating new metrics in the future. Other features include the ability for users to create and format citation lists, and access scholar-specific RSS feeds. The data in the repository is harvestable using OAI’s Protocol for Metadata Harvesting (PMH). An administrative user can now set the embargo date for content, and expect the embargo to be automatically lifted. Scholar deposit has also become simpler, and the project has recently begun writing code to expose alternative metrics, creating additional value for scholars seeking to understand the scope of their scholarly impact, IR administrators seeking to improve impact and guide researchers, and administrative groups.

## About the Islandora Architecture

Islandora is an open-source software framework designed to help institutions and organizations and their audiences collaboratively manage, and discover digital assets using a best-practices framework.  Islandora was originally developed by the University of Prince Edward Island’s Robertson Library, but is now implemented and contributed to by an ever-growing international community.

Islandora allows for digital assets to be stewarded following best practices for asset modelling by defining packages of data assets, derivatives, and XML-based administrative, technical, and descriptive metadata, with relationships to other data assets described in RDF. Not only is Islandora designed to serve best-practices for digital preservation, it also allows users to manage and discover assets, and for diverse user groups to create digital exhibitions, perform and collaborate on research, and enrich resources.

A number of open source applications form the structure of the Islandora framework which can be extended by integrating additional applications to meet new requirements. The front-end/interface for Islandora is provided by the popular Content Management System, Drupal [\[5\]](https://journal.code4lib.org/articles/#note5). Elements of Islandora are templated so that Drupal’s theming layer can be extended to Islandora elements (for example, displays and behaviors, search results displays, etc.). Drupal’s form API is also used to provide form building and editing for any XML-based metadata schema, workflows can also be orchestrated, numerous roles and permissions can be assigned, and Drupal permits integration with external identity stores using LDAP and Shibboleth.

The Islandora code layer provides integration with numerous third-party software as direct plug-ins (eg. ImageMagick [\[6\]](https://journal.code4lib.org/articles/#note6), FITS [\[7\]](https://journal.code4lib.org/articles/#note7), LAME [\[8\]](https://journal.code4lib.org/articles/#note8), Tesseract [\[9\]](https://journal.code4lib.org/articles/#note9), Internet Archive Bookreader [\[10\]](https://journal.code4lib.org/articles/#note10), Open Seadragon [\[11\]](https://journal.code4lib.org/articles/#note11), etc.), or through the Islandora micro services engine [\[12\]](https://journal.code4lib.org/articles/#note12). This software can be called upon to create derivatives and perform data transformations or extraction for data that is then stored in the digital object repository layer, built using FedoraCommons [\[13\]](https://journal.code4lib.org/articles/#note13) software.

Micro services in Islandora leverage the JMS Server that comes packaged with FedoraCommons. FedoraCommons repository models and stores data assets and provides the repository’s RDF triple store (Mulgara) as well as governing security policies (written in XACML [\[14\]](https://journal.code4lib.org/articles/#note14)) for access and management of objects. In Islandora 7 a new API, Tuque [\[15\]](https://journal.code4lib.org/articles/#note15), simplifies the process of interacting with and creating FedoraCommons data. FedoraCommons’ Generic Search Service (GSearch) processes the data and passes it to Solr where it is indexed by Lucene. Islandora includes a Solr Client Module [\[16\]](https://journal.code4lib.org/articles/#note16) that provides an administrative interface for configuring search, results, and facets.  For an overview of this framework, see the diagram below.

![](https://journal.code4lib.org/media/issue21/moses/image15.png)  
![](https://journal.code4lib.org/media/issue21/moses/image00.png)  
![](https://journal.code4lib.org/media/issue21/moses/image17.png)  
**Figure 1.** Overview of Islandora architecture.

Islandora releases  “solution packs” designed to serve particular populations or types of data. The Robertson Library’s approach to modeling data in Islandora provides essential feedback for the ongoing development of an Institutional Repository solution pack. To learn more about the Islandora project and plans for solution packs, visit the project’s website at [http://islandora.ca](http://islandora.ca/). The following describes the way that IslandScholar v2 leverages the Islandora architecture to provide a number of IR related services.

## Modelling Metadata and Relationships in IslandScholar

IslandScholar contains collections of digital objects that adhere to Fedora content models.  Within Fedora, content models define the composition of the digital objects (specifying what they contain — the “datastreams” —  and how they behave — the “methods”).  Currently the following types of objects are modeled in IslandScholar and the figure below illustrates their relationships:

1. citations (both faculty publications and student theses)
2. researchers
3. departments
4. grants

![](https://journal.code4lib.org/media/issue21/moses/image02.png)  
**Figure 2.** Digital objects in IslandScholar and their relationships. Grant information has recently been added.

## Citations

IslandScholar contains two content models related to citation-type metadata – faculty publications and student theses.  Each of these objects, publications and theses are composed of files (or “datastreams” in Fedora terminology). These files are described in Figure Three.

| Datastream ID | Description |
| --- | --- |
| RELS-EXT | Metadata in RDF xml format that describes the relationships this object has to other objects in the repository. |
| MODS<sup><a href="https://journal.code4lib.org/articles/#ftnt17" name="ftnt_ref17">[17]</a></sup> | Metadata that describes the citation object in MODS format. |
| DC | A transformed version of the MODS stored as Dublin Core – a required Fedora datastream. |
| OBJ | An optional datastream. This datastream is the document referenced by the citation and could be an original manuscript, a pre- or post-print, the published article, etc. |
| PDF | An optional datastream.  When an OBJ datastream is added to IslandScholar (Office type document or PDF), it is automatically normalized as a PDF/A file using Islandora’s micro-services framework. |
| ZIP | An optional datastream. A zip package of any supplemental material that might be associated with the citation. e.g., an excel spreadsheet, spss datafile, questionnaire, etc. that has been packaged in a zip file. |
| POLICY | An optional datastream. An XACML [\[18\]](https://journal.code4lib.org/articles/#note18) policy that governs access to the digital object or selected datastreams. For instance, for a citation object the citation data can be exposed, but the PDF that is part of the digital object may be embargoed, and so only those with appropriate rights can manage/view that particular datastream. |

**Figure 3.** The structure of a digital citation object.

The student thesis content model is similar in structure, but the MODS metadata is extended with the <extension> element so that ETD-MS [\[19\]](https://journal.code4lib.org/articles/#note19) metadata can be included. ETD-MS metadata is specific to electronic theses and dissertations and meets the metadata requirements for participation in Library and Archives Canada’s e-thesis harvesting program [\[20\]](https://journal.code4lib.org/articles/#note20).

## Researchers and Departments

Recognizing that many citations would have authors entered in a variety of ways, we chose to create authority records for the people and organizations represented in the data. We describe these entities using the Metadata Authority Description Schema (MADS), an XML schema that provides metadata about people and organizations (and other elements) [\[21\]](https://journal.code4lib.org/articles/#note21).  MADS is a complimentary schema to MODS and shares some of the same elements.  Having authority records for researchers allows us to associate citations with related researcher authority records – facilitating the creation of browse displays and search queries that return expected results. The figure below illustrates a researcher profile page for a faculty member and it is composed of data from the MADS datastream, the thumbnail datastream from the researcher record, and data from objects that are related to the researcher.

![](https://journal.code4lib.org/media/issue21/moses/image06.png)  
**Figure 4.** A Research Profile Page from IslandScholar [\[22\]](https://journal.code4lib.org/articles/#note22).

Researcher records can be created in a number of ways within the IslandScholar system: through an associated import from the University’s LDAP system, adding a user through Drupal’s Users module, or by using Islandora’s XML form/Ingest framework. Basic data about researchers is contained within the University’s LDAP system; with the Drupal LDAP Integration module [\[23\]](https://journal.code4lib.org/articles/#note23) enabled and configured, we are able to pull data directly from the campus LDAP server.

When logged in with the role of administrator, an Associate button is available for each citation. When selected it searches both the LDAP directory and existing researcher records in the repository, looking for likely name matches between the citation and researchers and displaying those records. This process highlights existing associations within LDAP and the repository and other possible associations. The results are then presented to the user (see Figure Five). Appropriate associations can then be selected and created by the administrator, and are written in RDF to the RELS-EXT datastream of the citation object.

![](https://journal.code4lib.org/media/issue21/moses/image01.png)  
**Figure 5.** Adding a Researcher record using an LDAP lookup.

Occasionally the researcher record will not be available via the campus LDAP. In this case, to manually add a Researcher record, an authorized user navigates to the collection containing the researcher records, selects Add, selects the Authority content model and proceeds to the data entry form. Figures Six and Seven show a user’s view of how this process unfolds.

![](https://journal.code4lib.org/media/issue21/moses/image09.png)  
**Figure 6.** Adding a Researcher record using Islandora

![](https://journal.code4lib.org/media/issue21/moses/image11.png)  
**Figure 7.** Sample XML Form view for a Researcher record.

## Grants

Grants have recently been added to the IslandScholar framework – part of a desire to flesh out the Researcher’s profile with additional data and a desire to associate citations with the grants that funded them.  Currently this is a manual process whereby we map a CSV export from UPEI’s Research Services to MODS. We are actively investigating the CASRAI Research Activity Profile [\[24\]](https://journal.code4lib.org/articles/#note24) as a better match for modelling this data in the future. Currently grants are associated with researchers and the data is displayed on Researcher Profile pages as a block.

## Integration of Citation Style Language

In the first version of IslandScholar, a pre-defined, generic citation display was created.  To provide options for citation formats for both display and export, one of the goals of this version of IslandScholar was to integrate the Citation Style Language as a method to reliably generate citations formatted in particular styles.  Citation Style Language (CSL) is “an open XML-based language to describe the formatting of citations and bibliographies.” [\[25\]](https://journal.code4lib.org/articles/#note25)   There is a large collection of community contributed styles [\[26\]](https://journal.code4lib.org/articles/#note26) available for download and these styles can be added to and used by IslandScholar. Figure Eight  (below) illustrates the styles already added to IslandScholar and the option for adding additional styles. A list of currently installed styles appears, and a user with the appropriate permissions can upload a new style, which then becomes available in the system.

![](https://journal.code4lib.org/media/issue21/moses/image13.png)  
**Figure 8.** Administering CSL Styles in IslandScholar

The IslandScholar administrator can set a default style for the entire system within the Scholar Administration panel (See Figure Nine).

![](https://journal.code4lib.org/media/issue21/moses/image03.png)  
**Figure 9.** Setting the default style for IslandScholara

A CSL editor [\[27\]](https://journal.code4lib.org/articles/#note27) has recently been released that can be used to author your own custom styles if one from the community does not fit your use case. For example, at UPEI some researchers would like to be able to output their citations in the format required by particular funders and a custom style could accommodate this request.

To generate formatted citations from the MODS metadata in IslandScholar,  developers on the project  first created php code [\[28\]](https://journal.code4lib.org/articles/#note28) to convert the MODS metadata stored in IslandScholar into the CSL JSON format. To accomplish this task the code parses the MODS and outputs it in a format that conforms to CSL – for example, a “Journal Article” (a local genre term in the MODS metadata) is transformed to “article-journal” in the corresponding JSON. Names and dates are also reformatted so that they match CSL requirements. For many other fields XPATH queries of the MODS are used to populate CSL variables. The resulting CSL JSON is then handed to the citeproc-js [\[29\]](https://journal.code4lib.org/articles/#note29) javascript module, the style is applied, and a formatted citation is the result.

## Importing and Exporting Citation Metadata

### Importing/Ingesting citations into the Institutional Repository

IslandScholar leverages a number of different technologies to provide users with a choice of formats to be used when adding citations into the repository.  The IslandScholar application currently supports the import of citations in RIS [\[30\]](https://journal.code4lib.org/articles/#note30), Endnote XML [\[31\]](https://journal.code4lib.org/articles/#note31), RefWorks XML, or MODS bibliographic formats. A RIS, EndNote XML, or RefWorks XML document can generate a single or multiple digital objects on ingest (One for each record within the RIS, EndNote XML, or RefWorks document uploaded to the repository). The Islandora 7 version of the Scholar solution-pack module (currently under development) provides additional support for single and batch ingest using unique identifiers such as digital object identifiers (DOIs) and PubMed IDs (PMIDs).

At the Robertson Library, the primary method used to manage and harvest citation metadata is RefWorks. Citations are harvested into Refworks and are then edited to include IslandScholar specific information (identifiers for scholars and departments). Once the citations have been enriched, they are then exported as RefWorks XML files.  Figure Ten illustrates the options for a user when ingesting a Refworks file of citations into the citation collection.

![](https://journal.code4lib.org/media/issue21/moses/image10.png)  
**Figure 10.** Citation Import Interface

During RefWorks XML import, IslandScholar reads the Reference Type <rt> element from the  RefWorks record, passes it through a matching XSLT and transforms the RefWorks XML to MODS. The relevant RefWorks XML is shown in Figure Eleven.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 | `<``reference``>`  `<``rt``>Journal Article</``rt``>`  `<``sr``>Electronic(1)</``sr``>`  `<``id``>11237</``id``>`  `<``a1``>Shiri,Ali</``a1``>`  `<``a1``>Revie,Crawford W.</``a1``>`  `<``t1``>Usability and user perceptions of a thesaurus-enhanced search interface</``t1``>`  `<``jf``>Journal of Documentation</``jf``>`  `<``yr``>2005</``yr``>`  `<``fd``>10</``fd``>`  `<``vo``>61</``vo``>`  `<``is``>5</``is``>`  `<``sp``>640</``sp``>`  `<``op``>656</``op``>`  `<``sn``>00220418</``sn``>`  `<``do``>10.1108/00220410510625840</``do``>`  `<``u1``>crevie</``u1``>`  `<``u2``>Health Management</``u2``>`  `<``ol``>Unknown(0)</``ol``>`  `</``reference``>` |
| --- | --- |

**Figure 11.** Sample RefWorks Record

The RefWorks record is parsed and since <rt> = Journal Article the record is passed through the refworks\_to\_mods\_journal.xsl [\[32\]](https://journal.code4lib.org/articles/#note32) transformation (there are other transformations for other genres). Figure Twelve shows the resulting MODS formatted record that is stored in IslandScholar.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54 | `<``titleInfo``>`  `<``title``>Usability and user perceptions of a thesaurus-enhanced search interface</``title``>`  `<``subTitle``/>`  `</``titleInfo``>`  `<``name` `type``=``"personal"``>`  `<``namePart` `type``=``"given"``>Ali</``namePart``>`  `<``namePart` `type``=``"family"``>Shiri</``namePart``>`  `<``role``>`  `<``roleTerm` `authority``=``"marcrelator"` `type``=``"text"``>Author</``roleTerm``>`  `</``role``>`  `</``name``>`  `<``name` `type``=``"personal"``>`  `<``namePart` `type``=``"given"``>Crawford W.</``namePart``>`  `<``namePart` `type``=``"family"``>Revie</``namePart``>`  `<``role``>`  `<``roleTerm` `authority``=``"marcrelator"` `type``=``"text"``>Author</``roleTerm``>`  `</``role``>`  `</``name``>`  `<``identifier` `type``=``"u1"``>crevie</``identifier``>`  `<``identifier` `type``=``"u2"``>Health Management</``identifier``>`  `<``typeOfResource``>text</``typeOfResource``>`  `<``genre``>Journal Article</``genre``>`  `<``identifier` `type``=``"refworks"``>11237</``identifier``>`  `<``relatedItem` `type``=``"host"``>`  `<``titleInfo``>`  `<``title``>Journal of Documentation</``title``>`  `<``subTitle``/>`  `<``partNumber``/>`  `</``titleInfo``>`  `<``originInfo``>`  `<``dateIssued` `keyDate``=``"yes"``>2005</``dateIssued``>`  `<``issuance``>continuing</``issuance``>`  `<``publisher``/>`  `</``originInfo``>`  `<``part``>`  `<``date``>2005</``date``>`  `<``detail` `type``=``"volume"``>`  `<``number``>61</``number``>`  `</``detail``>`  `<``detail` `type``=``"issue"``>`  `<``number``>5</``number``>`  `</``detail``>`  `<``extent` `unit``=``"page"``>`  `<``start``>640</``start``>`  `<``end``>656</``end``>`  `</``extent``>`  `</``part``>`  `<``identifier` `type``=``"issn"``>00220418</``identifier``>`  `<``identifier` `type``=``"isbn"``/>`  `</``relatedItem``>`  `<``identifier` `type``=``"doi"``>10.1108/00220410510625840</``identifier``>`  `</``mods``>` |
| --- | --- |

**Figure 12.** Sample Transformed MODS Record

For files in the RIS or Endnote format, IslandScholar utilizes bibutils [\[33\]](https://journal.code4lib.org/articles/#note33) to transform those formats to a standardized MODS metadata format.  Bibutils is a set of command line tools used to transform various bibliographic formats to MODS.

## Exporting / Sharing Data

### Bibliography

A new feature added to IslandScholar V2  is the ability to select citations and add them to a list. The resulting list can be managed, and bibliographies generated in user-specified styles can be exported in several file formats.  Users can add citations to a list from any search result page or from a researcher’s profile. Figure Thirteen illustrates a search result with two citations that have been added to a list.

![](https://journal.code4lib.org/media/issue21/moses/image08.png)  
**Figure 13.** Citations added to a list.

When users wish to view / export the select citations, they select the MY LIST option and choose the desired output citation format.  Several export options are available including HTML, RTF, PDF, and RIS. Figure Fourteen illustrates the options provided to a user.

![](https://journal.code4lib.org/media/issue21/moses/image12.png)  
**Figure 14.** Exporting Citations

In the case illustrated in Figure Fourteen, the option for HTML export has been selected. This means that an HTML export passes the citations through CSL and outputs the result to the screen (See Figure Fifteen)

![](https://journal.code4lib.org/media/issue21/moses/image04.png)  
**Figure 15.** HTML Export of Citations in the APA 6th Style

RTF and PDF exports are handled by bibutils and the selected styles are applied. Bibutils also generates the tagged RIS export [\[34\]](https://journal.code4lib.org/articles/#note34).

### OAI-PMH

Another goal (and a requirement for e-thesis harvesting) in IslandScholar V2 was the integration of The Open Archives Initiative – Protocol for Metadata Harvesting (OAI-PMH).  This was achieved by enabling and configuring the Islandora OAI module [\[35\]](https://journal.code4lib.org/articles/#note35), a module that exposes and transforms the MODS datastream of digital objects in Islandora to OAI harvesters. Once the OAI module has been configured, a harvester can be pointed to particular collections. OAI output is governed by the module and the MODS datastream is passed through different stylesheets to return the requested metadata. For example, a MODS to OAI-DC stylesheet is applied to return results from the researchers’ citation collection as OAI-DC. So, for example, an OAI request like [http://www.islandscholar.ca/oai2?verb=ListRecords&metadataPrefix=oai\_dc&set=ir\_citationCollection](http://www.islandscholar.ca/oai2?verb=ListRecords&metadataPrefix=oai_dc&set=ir_citationCollection) will provide results shown in Figure Sixteen.

![](https://journal.code4lib.org/media/issue21/moses/image19.png)  
**Figure 16.** Top of a response provided by IslandScholar V2 for an OAI-DC request.

To break down the OAI request the harvester has requested a list of records (verb=ListRecords) in the OAI DC metadata format (metadataPrefix=oai\_dc) for the records contained in the repository’s ir:citationCollection collection (set=ir\_citationCollecton). In order for our e-theses to be harvested, IslandScholar must make ETD-MS metadata available. To facilitate this, we configure the  OAI module to include a transformation [\[36\]](https://journal.code4lib.org/articles/#note36) of MODS to ETD-MS and expose the resulting metadata with the Islandora OAI module. For example, a request like [http://www.islandscholar.ca/oai2?verb=ListRecords&metadataPrefix=oai\_etdms&set=ir\_thesisCollection](http://www.islandscholar.ca/oai2?verb=ListRecords&metadataPrefix=oai_etdms&set=ir_thesisCollection) will provide results shown in Figure Seventeen.

![](https://journal.code4lib.org/media/issue21/moses/image05.png)  
**Figure 17.** Top of a response provided by IslandScholar V2 for an ETD-MS request.

In this case the harvester has requested records in the ETD-MS metadata format (metadataPrefix=oai\_etdms) from the repository’s ir:thesisCollection collection (set=ir\_thesisCollecton). Figures Fifteen and Sixteen illustrate the ways that separate metadata profiles can be exposed. The module that enables this function was developed generically and includes a variety of configuration options. See Figure Eighteen for a screenshot of one of the sections of the administration screen:

![](https://journal.code4lib.org/media/issue21/moses/image16.png)  
**Figure 18.** Configuring ETD-MS metadata for OAI harvesting.

### RSS

IslandScholar V2 also provides a feed of a researcher’s citations, updated when new publications are associated with the researcher. This has value for the researcher wishing to embed an RSS feed in a faculty profile page or make similar use of an up-to-date list of publications (often required for tenure decisions, etc.). In IslandScholar, a basic RSS feed for researchers is generated by passing a Solr query to an XSLT. This is a feature that we hope to more fully develop in future work. Figure Nineteen shows this sample XML feed [\[37\]](https://journal.code4lib.org/articles/#note37).

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26 | `<?``xml` `version``=``"1.0"` `encoding``=``"UTF-8"``?>`  `<``rss` `version``=``"2.0"``>`  `<``channel``>`  `<``title``>An IslandScholar Citation Feed</``title``>`  `<``description``> A scholar's citation feed. </``description``>`  `<``language``>en-us</``language``>`  `<``item``>`  `<``title``>Slow Library</``title``>`  `<``description``>Leggott, Mark; "Slow Library", , 2006, , </``description``>`  `<``pubDate``>2012-10-19T12:06:20.848Z</``pubDate``>`  `</``item``>`  `<``item``>`  `<``title``>Digital Dumpster? Preserving and Accessing Digital Records</``title``>`  `<``description``>Leggott, Mark; "Digital Dumpster? Preserving and Accessing Digital`  `Records", , 2005, , </``description``>`  `<``pubDate``>2012-10-19T12:06:30.322Z</``pubDate``>`  `</``item``>`  `</``channel``>`  `</``rss``>` |
| --- | --- |

**Figure 19.** Sample RSS feed output

A link to a researcher’s feed is available from their profile page.

## Managing Access to Content

One of the primary methods used to manage access to Islandora content is by the inclusion of a POLICY datastream in digital objects.  POLICY datastreams are written in XACML, an xml based language used to define access control policies [\[38\]](https://journal.code4lib.org/articles/#note38) in Fedora. When combined with Drupal’s existing user authentication and roles, fine grained access levels can be achieved at the collection, object, or datastream level.  Figure Twenty shows a snippet from a POLICY datastream of a citation object that illustrates the users (fedoraAdmin, mleggott) and roles (administrator, Robertson Library) that can edit this object.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29 | `<``Rule` `Effect``=``"Deny"` `RuleId``=``"denyapi-except-to-user"``>`  `<``Condition` `FunctionId``=``"urn:oasis:names:tc:xacml:1.0:function:not"``>`  `<``Apply` `FunctionId``=``"urn:oasis:names:tc:xacml:1.0:function:or"``>`  `<``Apply` `FunctionId``=``"urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of"``>`  `<``SubjectAttributeDesignator`  `AttributeId``=``"urn:fedora:names:fedora:2.1:subject:loginId"`  `<``Apply` `FunctionId``=``"urn:oasis:names:tc:xacml:1.0:function:string-bag"``>`  `>fedoraAdmin</``AttributeValue``>`  `>mleggott</``AttributeValue``>`  `</``Apply``>`  `</``Apply``>`  `<``Apply` `FunctionId``=``"urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of"``>`  `<``SubjectAttributeDesignator` `AttributeId``=``"fedoraRole"`  `<``Apply` `FunctionId``=``"urn:oasis:names:tc:xacml:1.0:function:string-bag"``>`  `>administrator</``AttributeValue``>`  `Library</``AttributeValue``>`  `</``Apply``>`  `</``Apply``>`  `</``Apply``>`  `</``Condition``>`  `</``Rule``>` |
| --- | --- |

**Figure 20.** XACML Snippet

While all attempts are made to ensure that content is accessible within the repository, there are some use cases when associated content needs to be embargoed.  The full text of student theses can be embargoed and there is a global XACML policy that applies to records that contain an embargo date. XACML policies can be difficult to write (and can potentially lock your object or the entire repository) and while not used in the current version of IslandScholar, a visual XACML editor [\[39\]](https://journal.code4lib.org/articles/#note39) is now part of the Islandora toolset. In the future version of IslandScholar, the XACML editor will be used to simplify the application and management of embargo policies in IslandScholar.

## Scholar deposit

As with the first iteration of IslandScholar, the Robertson Library made the choice to ‘seed’ the repository with the collected citations of scholars at UPEI and encourage researchers to contribute whichever version of the article is permitted by the publishing policy of the journal in which they published. To help scholars decide which version of their work can be legally submitted, IslandScholar V2 also maintained and updated the ability for researchers to review publisher copyright and self-archiving policies by integrating with the Sherpa/Romeo API. Researchers are also permitted in IslandScholar V2 to append any relevant associated research data to a citation by creating a .zip file of relevant materials and appending during the submission process. Figure Twenty-one illustrates the screen that is presented to a scholar appending documents to a citation.

![](https://journal.code4lib.org/media/issue21/moses/image20.png)  
**Figure 21.** Scholars identify the version and appropriate license.

Islandora’s microservices transform the uploaded file to a PDF/A for long-term preservation. The system supports any office-type format, eg. .doc, .docx, .odt, .xls, etc.. The resulting files are stored as part of the citation object.

## Metrics

IslandScholar V2 provides more advanced tools for measuring downloads of an article and page views, and has begun integrating altmetrics into the tool set. Figure Twenty-two shows how this appears for scholars. Scholars log into the system and can view all citations, with a column showing the last date the citation was viewed, as well as total number of times the article was viewed.

![](https://journal.code4lib.org/media/issue21/moses/image07.png)  
**Figure 22.** A Scholar can review the times a citation has been viewed.

Navigating directly to the record will show a user how many times an article has been downloaded, and when it was last downloaded (See Figure Twenty-three).

![](https://journal.code4lib.org/media/issue21/moses/image14.png)  
**Figure 23.** From the citation, users can see the number of times an article has been downloaded, and when it was last downloaded

As the publishing platform for scholarly data, and the ways scholars share and interact with research has evolved, altmetrics has emerged as an approach that aims to account for those activities outside of the traditional peer-reviewed journal stream. [\[40\]](https://journal.code4lib.org/articles/#note40) From the ciation view, IslandScholar V2 provides altmetrics to scholars and visitors to the system. While currently in the development stage, we are optimistic about the potential for this application to show just-in-time altmetrics alongside more traditional measures of popularity and impact (such as downloads and views). If an article in the system has a doi, pmid, or arxiv, a badge appears in the citation’s full record view. Scrolling over the badge shows a pop-up with altmetric statistics and a link to a more complete perspective on the impact of the article. This process is visible in Figure Twenty-four.

![](https://journal.code4lib.org/media/issue21/moses/image18.png)  
**Figure 23.** An Altmetrics badge reveals altmetrics to visitors

## Conclusion

UPEI is proud of the recent upgrade to IslandScholar and the number of new tools that have been integrated to address emerging best-standards practice and the needs of IR users. At the same time, the team is committed to ongoing iteration and development.  Embracing an open and community-centric approach, IslandScholar will continue to evolve to incorporate and develop new tools, and to take advantage of emerging tools. This work is also part of the ongoing development of Islandora and Islandora solution packs. Members of the community are warmly welcomed to visit and explore Islandscholar.ca and provide feedback to help guide development in the future.

## References and Notes

[\[1\]](https://journal.code4lib.org/articles/#ref1) Strategic Research Plan 2008?2018 – [http://research.upei.ca/files/research/v9%20Senate%2022Apr08.pdf](http://research.upei.ca/files/research/v9%20Senate%2022Apr08.pdf)

[\[2\]](https://journal.code4lib.org/articles/#ref2) Sherpa/Romeo – [http://www.sherpa.ac.uk/romeo/](http://www.sherpa.ac.uk/romeo/)

[\[3\]](https://journal.code4lib.org/articles/#ref3) COinS – [http://ocoins.info/](http://ocoins.info/)

[\[4\]](https://journal.code4lib.org/articles/#ref4) Open Access & Dissemination of Research Output –  [https://cab.upei.ca/sites/default/files/attachments/OpenAccessandDisseminationofResearchOutput.pdf](https://cab.upei.ca/sites/default/files/attachments/OpenAccessandDisseminationofResearchOutput.pdf)

[\[5\]](https://journal.code4lib.org/articles/#ref5) Drupal – [http://drupal.org](http://drupal.org/)

[\[6\]](https://journal.code4lib.org/articles/#ref6) ImageMagick – [http://www.imagemagick.org/](http://www.imagemagick.org/) – used in a variety of solution packs for image conversion

[\[7\]](https://journal.code4lib.org/articles/#ref7) FITS – [https://code.google.com/p/fits/](https://code.google.com/p/fits/) integrated into the Islandora framework with the Islandora FITS module – [https://github.com/Islandora/islandora\_fits](https://github.com/Islandora/islandora_fits)

[\[8\]](https://journal.code4lib.org/articles/#ref8) LAME – [http://lame.sourceforge.net/](http://lame.sourceforge.net/) integrated into the Islandora framework with the Audio Solution Pack – [https://github.com/Islandora/islandora\_solution\_pack\_audio](https://github.com/Islandora/islandora_solution_pack_audio)

[\[9\]](https://journal.code4lib.org/articles/#ref9) Tesseract – [https://code.google.com/p/tesseract-ocr/](https://code.google.com/p/tesseract-ocr/) integrated into the Islandora framework with the Islandora OCR module – [https://github.com/Islandora/islandora\_ocr](https://github.com/Islandora/islandora_ocr)

[\[10\]](https://journal.code4lib.org/articles/#ref10) Islandora Internet Archive Bookreader – [https://github.com/Islandora/islandora\_internet\_archive\_bookreader](https://github.com/Islandora/islandora_internet_archive_bookreader)

[\[11\]](https://journal.code4lib.org/articles/#ref11) Islandora Open Seadragon Viewer – [https://github.com/Islandora/islandora\_openseadragon](https://github.com/Islandora/islandora_openseadragon)

[\[12\]](https://journal.code4lib.org/articles/#ref12) There are at least two ‘flavours’ of micro services used in the Islandora context: Python based – [https://github.com/Islandora/islandora\_microservices](https://github.com/Islandora/islandora_microservices); and PHP based – [https://github.com/roblib/php\_listeners](https://github.com/roblib/php_listeners)

[\[13\]](https://journal.code4lib.org/articles/#ref13) Fedora Commons – [http://fedora-commons.org](http://fedora-commons.org/)

[\[14\]](https://journal.code4lib.org/articles/#ref14) Fedora XACML Policy Writing Guide – [https://wiki.duraspace.org/display/FEDORA34/Fedora+XACML+Policy+Writing+Guide](https://wiki.duraspace.org/display/FEDORA34/Fedora+XACML+Policy+Writing+Guide)

[\[15\]](https://journal.code4lib.org/articles/#ref15) Build, Access, Modify and Delete Fedora objects with the Tuque interface – [https://github.com/Islandora/islandora/wiki/Build,-Access,-Modify-and-Delete-Fedora-objects-with-the-Tuque-interface](https://github.com/Islandora/islandora/wiki/Build,-Access,-Modify-and-Delete-Fedora-objects-with-the-Tuque-interface)

[\[16\]](https://journal.code4lib.org/articles/#ref16) Islandora Solr Search module – [https://github.com/Islandora/islandora\_solr\_search](https://github.com/Islandora/islandora_solr_search)

[\[17\]](https://journal.code4lib.org/articles/#ref17) Metadata Object Description Schema (MODS) – [http://www.loc.gov/standards/mods/](http://www.loc.gov/standards/mods/)

[\[18\]](https://journal.code4lib.org/articles/#ref18) XACML (eXtensible Access Control Markup Language) is an XML-based policy language enforced by Fedora at both the repository-wide and object level. Read more about XACML and Fedora at [https://wiki.duraspace.org/display/FEDORA36/XACML+Policy+Enforcement](https://wiki.duraspace.org/display/FEDORA36/XACML+Policy+Enforcement). XACML is also discussed in more detail in a later section of this article.

[\[19\]](https://journal.code4lib.org/articles/#ref19) ETD-MS: an Interoperability Metadata Standard for Electronic Theses and Dissertations. [http://www.ndltd.org/standards/metadata/etd-ms-v1.00-rev2.html](http://www.ndltd.org/standards/metadata/etd-ms-v1.00-rev2.html)

[\[20\]](https://journal.code4lib.org/articles/#ref20) About Electronic Theses: Harvesting Program. [http://www.collectionscanada.gc.ca/thesescanada/027007-9200-e.html](http://www.collectionscanada.gc.ca/thesescanada/027007-9200-e.html)

[\[21\]](https://journal.code4lib.org/articles/#ref21) Metadata Authority Description Schema (MADS). [http://www.loc.gov/standards/mads/](http://www.loc.gov/standards/mads/)

[\[22\]](https://journal.code4lib.org/articles/#ref22) The Researcher Profile page for Mark Leggott. [http://www.islandscholar.ca/fedora/repository/ir:mleggott](http://www.islandscholar.ca/fedora/repository/ir:mleggott)

[\[23\]](https://journal.code4lib.org/articles/#ref23) LDAP Integration Module. [http://drupal.org/project/ldap\_integration](http://drupal.org/project/ldap_integration)

[\[24\]](https://journal.code4lib.org/articles/#ref24) CASRAI Research Activity Profile. [http://dictionary.casrai.org/research-activity-profile-draft](http://dictionary.casrai.org/research-activity-profile-draft)

[\[25\]](https://journal.code4lib.org/articles/#ref25) Citation Style Language. [http://citationstyles.org/](http://citationstyles.org/)

[\[26\]](https://journal.code4lib.org/articles/#ref26) Citation Styles. [https://github.com/citation-style-language/styles](https://github.com/citation-style-language/styles) and [http://citationstyles.org/”>](http://citationstyles.org/)

[\[27\]](https://journal.code4lib.org/articles/#ref27) CSL Style Editor. [http://editor.citationstyles.org/about/](http://editor.citationstyles.org/about/)

[\[28\]](https://journal.code4lib.org/articles/#ref28) IslandScholar – converter.php. [https://github.com/roblib/islandora\_scholar\_upei/blob/master/modules/citeproc/generators/converter.php](https://github.com/roblib/islandora_scholar_upei/blob/master/modules/citeproc/generators/converter.php)

[\[29\]](https://journal.code4lib.org/articles/#ref29) citeproc-js. [https://bitbucket.org/fbennett/citeproc-js/wiki/Home](https://bitbucket.org/fbennett/citeproc-js/wiki/Home)

[\[30\]](https://journal.code4lib.org/articles/#ref30) RIS File Format. [http://en.wikipedia.org/wiki/RIS\_%28file\_format%29](http://en.wikipedia.org/wiki/RIS_%28file_format%29)

[\[31\]](https://journal.code4lib.org/articles/#ref31) EndNote. [http://en.wikipedia.org/wiki/EndNote](http://en.wikipedia.org/wiki/EndNote)

[\[32\]](https://journal.code4lib.org/articles/#ref32) XSLT used to transform RefWorks journal citation to MODS [https://github.com/roblib/islandora\_scholar\_upei/blob/master/xsl/refworks\_to\_mods\_journal.xsl](https://github.com/roblib/islandora_scholar_upei/blob/master/xsl/refworks_to_mods_journal.xsl)

[\[33\]](https://journal.code4lib.org/articles/#ref33) [http://sourceforge.net/p/bibutils/home/Bibutils/](http://sourceforge.net/p/bibutils/home/Bibutils/)

[\[34\]](https://journal.code4lib.org/articles/#ref34) Islandora Bibliography Export.  [https://github.com/roblib/islandora\_scholar\_upei/blob/master/citation/bibliography/Export.inc](https://github.com/roblib/islandora_scholar_upei/blob/master/citation/bibliography/Export.inc)

[\[35\]](https://journal.code4lib.org/articles/#ref35) Islandora OAI Module. [https://github.com/Islandora/islandora\_oai](https://github.com/Islandora/islandora_oai)

[\[36\]](https://journal.code4lib.org/articles/#ref36) ETD-MS xslt: [https://github.com/Islandora/islandora\_oai/blob/7.x/transforms/mods\_to\_etdms.xsl](https://github.com/Islandora/islandora_oai/blob/7.x/transforms/mods_to_etdms.xsl)

[\[37\]](https://journal.code4lib.org/articles/#ref37) Sample RSS feed output: [http://www.islandscholar.ca/rss/mleggott](http://www.islandscholar.ca/rss/mleggott)

[\[38\]](https://journal.code4lib.org/articles/#ref38) [https://wiki.duraspace.org/display/FEDORA36/Fedora+XACML+Policy+Writing+Guide](https://wiki.duraspace.org/display/FEDORA36/Fedora+XACML+Policy+Writing+Guide)

[\[39\]](https://journal.code4lib.org/articles/#ref39) Islandora XACML Editor. [https://github.com/Islandora/islandora\_xacml\_editor](https://github.com/Islandora/islandora_xacml_editor)

[\[40\]](https://journal.code4lib.org/articles/#ref40) Learn more about Altmetrics at [http://altmetrics.org/manifesto/](http://altmetrics.org/manifesto/)

Donald Moses, MLIS, is the digital initiatives and systems librarian at the University of Prince Edward Island’s Robertson Library, participates in the Islandora community, and is a member of the management team that oversees the Virtual Research Environment (VRE), including IslandScholar, at UPEI.

Kirsta Stapelfeldt, MA, MLIS, is the manager of the Islandora project at the UPEI’s Robertson Library, and has helped develop the VRE framework at UPEI, and served as a subject matter expert on a variety of  
projects.

The authors would like to acknowledge the programmers that have developed the IslandScholar code: Paul Pound and Richard Wincewicz.
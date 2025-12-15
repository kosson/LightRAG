---
title: "Recommendations for the application of Schema.org to aggregated Cultural Heritage metadata to increase relevance and visibility to search engines: the case of Europeana"
source: "https://journal.code4lib.org/articles/12330"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-04-20
created: 2025-01-10
description: "Europeana provides access to more than 54 million cultural heritage objects through its portal Europeana Collections. It is crucial for Europeana to be recognized by search engines as a trusted authoritative repository of cultural heritage objects. Indeed, even though its portal is the main entry point, most Europeana users come to it via search engines. [...]"
tags:
  - "clippings"
---
# Recommendations for the application of Schema.org to aggregated Cultural Heritage metadata to increase relevance and visibility to search engines: the case of Europeana
Richard Wallis, Antoine Isaac, Valentine Charles, Hugo Manguinhas

Europeana provides access to more than 54 million cultural heritage objects through its portal Europeana Collections. It is crucial for Europeana to be recognized by search engines as a trusted authoritative repository of cultural heritage objects. Indeed, even though its portal is the main entry point, most Europeana users come to it via search engines.

Europeana Collections is fuelled by metadata describing cultural objects, represented in the Europeana Data Model (EDM). This paper presents the research and consequent recommendations for publishing Europeana metadata using the Schema.org vocabulary and best practices. Schema.org html embedded metadata to be consumed by search engines to power rich services (such as Google Knowledge Graph). Schema.org is an open and widely adopted initiative (used by over 12 million domains) backed by Google, Bing, Yahoo!, and Yandex, for sharing metadata across the web It underpins the emergence of new web techniques, such as so called Semantic SEO.

Our research addressed the representation of the embedded metadata as part of the Europeana HTML pages and sitemaps so that the re-use of this data can be optimized.

The practical objective of our work is to produce a Schema.org representation of Europeana resources described in EDM, being the richest as possible and tailored to Europeana’s realities and user needs as well the search engines and their users.

## Introduction

This article captures the core output of a project between the authors in which Richard Wallis, as an external consultant, was engaged to advise Europeana on the potential for, and ramifications of, introducing detailed Schema.org structured data into Europeana websites.

Europeana provides access to more than 54 million cultural heritage objects through its portal Europeana Collections\[[1](https://journal.code4lib.org/articles/#note1)\]. The portal is fueled by metadata describing digitized cultural objects from cultural institutions, which results from a long curation and aggregation process that leads to representing it into the Europeana Data Model\[[2](https://journal.code4lib.org/articles/#note2)\] (EDM). It is therefore crucial for Europeana to be recognized as a trusted repository of cultural heritage on the web and as an authoritative resource by search engines. Indeed, even if the portal is considered as the main entry point for searching for cultural heritage, most of the Europeana users come to it via search engines, especially Google.

The Schema.org vocabulary\[[3](https://journal.code4lib.org/articles/#note3)\] provides a way to embed metadata into web pages for direct consumption by search engines such as Google to power rich user services (such as the Google Knowledge Graph). Schema.org is an open initiative, backed by Google, Bing, Yahoo!, and Yandex that has established a widely adopted practice (used by over 12 million domains) and vocabulary for sharing metadata across the web. Its broad adoption underpins the emergence of new techniques, such as so-called Semantic SEO.

Europeana started to research the benefits of Schema.org for its services, primarily the ability of the Schema.org vocabulary to enable external organizations in general, and Search Engines in particular, to crawl and add that data into their Knowledge Graphs, thus enhancing the discoverability of cultural resources. Our research lead us to investigate, review, and propose ways forward for the utilization of the Schema.org vocabulary and associated technologies in Europeana data services.

We addressed first the representation of Europeana resources using the Schema.org vocabulary. This work resulted in a set of data mapping recommendations taking into account various concerns such as the representation of literals versus URIs. We also addressed the publication of the embedded Schema.org data as part of the Europeana dynamic html pages and sitemaps using JSON-LD serialization.

Our recommendations detail the practical techniques that need to be considered to optimize the sharing of this data via the Europeana websites and services. We propose several approaches to identify the effects of adding Schema.org to the sites and produce analytics on fine-grained visiting patterns, which can be relevant for both Europeana and its data providers.

For these different areas, recommendations are made that correspond to the current situation as well as a more ideal situation where data for concepts, persons and other associated entities will be available as part of Europeana data services. Even though these recommendations have yet to be implemented in Europeana, we think they can be useful to institutions interested in using Schema.org.

## 1\. Data semantics and structure

The practical objective of our work is to produce a Schema.org representation of Europeana resources described in EDM, being as rich as possible and tailored to Europeana’s realities and user needs as well as the search engines and their users.

Our mapping recommendations (*see [Appendix 1](https://journal.code4lib.org/articles/#appendix1)*) identify Schema.org types and properties and the source EDM term entities that could be used to derive data values, or suggest appropriate Schema.org types. For example schema:name would be used for data derived from dc:title.

Instead of elaborating on each individual mapping decision, the remainder of this section discusses the more general challenges, design decisions and recommendations for extending the coverage of available data.

At first view there are three major mapping challenges between EDM, as used by Europeana, and the more generic Schema.org vocabulary.

*Note: In the examples of this article the output format for Schema.org data is assumed to be JSON-LD\[[4](https://journal.code4lib.org/articles/#note4)\]. The reasoning for this choice is detailed in the JSON-LD output section in the JSON-LD output section below.*

### Challenge 1: Flatter Hierarchy

The first challenge is to map the EDM metadata structure to more generic (and flatter) Schema.org classes.

EDM metadata is organized as a set of resources describing a Cultural Heritage Object (i.e., `edm:ProvidedCHO` and `ore:Proxy` that represent different data sources for objects), one or more digital representations (i.e, `edm:WebResource`) and “contextual” resources (places, persons, concepts, timespans), in compliance with the one-to-one principle\[[5](https://journal.code4lib.org/articles/#note5)\]. These resources are grouped together by an `edm:Aggregation` into one bundle recording also some information on the aggregation process (e.g., the providers of the metadata). This package of data contains many internal relationships linking resources to each other.

The Schema.org approach is to define a `schema:CreativeWork` (equivalent to the CHO) plus links to access the resource. The inevitable result of mapping to Schema.org will be a flatter representation of the data. In both cases, however, there are still relationships with associated contextual entities (in the EDM sense, schema:Person, schema:Organization, schema:Place, etc. are contextual entities). Most of the ‘flattening effect’ would be apparent for proxies and aggregations.

![A diagram showing how ORE Aggregation EDM WebResource, EDM ProvidedCHO, and ORE Proxy relate to each other](https://journal.code4lib.org/media/issue36/wallis/EDMClassDiagram.jpg "A diagram showing the relationships between the four main classes of the EDM metadata structure")  
**Figure 1.** The four main classes of the EDM metadata structure and their relations.

### Challenge 2: Identifying the Type of Thing

The core entity in EDM is the `edm:ProvidedCHO`, broadly equivalent to the Schema.org class `schema:CreativeWork`, with the type of object being defined via properties such as `dc:type`. However, using Schema.org it is preferable wherever possible to identify the specific type of ‘thing’ (`schema:Thing` being the base class in Schema.org which all other inherit from) being described – `schema:Book`, `schema:Painting`, `schema:Sculpture`, `schema:ImageObject`, etc. Often this data is available within EDM, via properties such as `dc:type` and references to concepts from, e.g., the Getty Art and Architecture thesaurus\[[6](https://journal.code4lib.org/articles/#note6)\].

Web Resources represented as `schema:MediaObjects` also ideally should be identified by more specific subtypes of `schema:MediaObject` (`schema:ImageObject`, `schema:AudioObject`, `schema:VideoObject`). Again this will require mapping between MimeTypes, file extensions, etc. to ascertain the correct type.

These mapping rules, the basis for which are referenced in the Data Mapping Recommendations Appendix below, will need to be evolved and established over time.

### Challenge 3: (identified) Things vs Strings

**Record vs. Entity view**

EDM is a step towards a semantic approach to data modeling, but the Europeana data currently available provides a record oriented view. References to entities, and their data, are included in a single output, and not all entities (organizations, persons, concepts etc.) have separate URI identifiers. Ideally for Schema.org, output should be in an entity based form, where each entity is described as such with its own URI, and references to other entities (creator of an object, for example) provided only as a URI. This approach is guided by Linked Data principles.\[[7](https://journal.code4lib.org/articles/#note7)\]

Satisfying this need imposes both a data and a technical challenge. Firstly, the data for each entity should be available in a form resembling an RDF Concise Bounded Description (CBD)\[[8](https://journal.code4lib.org/articles/#note8)\], providing a graph based view of the data for an individual entity and its relationship(s) with other entities.In simple terms this restricts the properties output to those directly associated with the entity being described (Formed from the RDF triples having the entity’s URI as their subject). EDM object records, currently served by Europeana’s API which seeks to reflect the type of records usually produced and consumed in the cultural sector\[[9](https://journal.code4lib.org/articles/#note9)\], are a good base. However further refinement may be needed focusing on separate description of individual entities (person, place, creative work, etc) as against aggregating them into a single record.EDM Proxies, which are essentially “derived” resources, should receive specific attention while assembling the data to be published.

Secondly, the systems need to be able to resolve and display each entity based upon its URI, supplying the embedded Schema.org data for it. It is recognized that moving to fully entity based data output will be an evolutionary process for Europeana (especially in terms of web identifiers and web pages associated with resources). We recommend in the interim that standard RDF blank node techniques (cf. point on blank nodes below) be used to separate out the notional entities within the combined data payload.

**Expanding String Literals into Entities**

Wherever possible literals should be expanded to an entity description of the appropriate type. For example the following in JSON-LD:

Should be expanded to:

| 1  2  3  4 | `"creator"``: {`  `"@type"``: ``"Person"`  `"name"``: ``"J. M. Smith"`  `}` |
| --- | --- |

This will explicitly inform those consuming the data of related entity types. (See note below about blank nodes for preferred JSON-LD syntax)

**Entity Data, Blank Nodes, URIs**

In JSON-LD output (as in some other RDF syntaxes) there are three formatting options in a combined payload for describing entities, such as creator in the examples below, related to a resource.

1. **Implicit Blank Nodes (nested output)** – This is where the data for the associated entity is provided inline as part of the resource description data:
2. **Explicit Blank nodes** – A blank node reference to the associated entity is provided in the resource description with the entity description provided in the same data payload thus:
3. **Entity Reference** – A resolvable URI is provided for the associated entity. It is for a consuming application or service to access that URI to obtain the entity description:

The recommended ideal for this is option 3 – Entity Reference, but is achievable only when entity descriptions with resolvable URIs have been created.

Europeana is currently working on a “semantic Entity Collection” that acts as a centralised point of reference and access to data about contextual entities. This Entity Collection will provide resolvable URIs (at [http://data.europeana.eu](http://data.europeana.eu/)) for all the entities described in Europeana. In the meantime Pption 2 – Explicit Blank Nodes – is used. This will facilitate easier adoption for option 3 at a later date.

**“Duplicating” statement objects both as URIs and Labels**

When separate entity URIs are provided as values for properties such as `dc:creator`, the question arises as to whether the label associated with these entities should be represented next to the URI of the separate entity. This would provide “more readable” data, also accomodating machine clients who couldn’t ‘follow their nose’ from the creator URI to the creator name in the separate (Linked Data) description. As in the following:

This approach is not recommended as it can introduce maintenance problems, as changes to the (remotely accessible) Linked Data available for the entity being referenced may invalidate the name/label that has been reproduced locally.

**Mapping to external resources**

It is preferable wherever possible to map internal Europeana entities, and concept identifiers, to external equivalents. Identifying an object, organization, person, concept, etc. to be `schema:sameAs` a Wikidata or similar identifier. To a certain extent the ability to identify such references is constrained by the amount and quality of data contributed to Europeana by its partners. However, especially when processing (enriching) data to identify entities for persons, organizations, etc. this need should be given high consideration.

### 1.4 URI design decisions

**Choice of Identifying URIs**

The Identifying URI for a Europeana resource should be of the form:

This differs from the current URL form for web pages:

This approach separates the provision of canonical Europeana identifiers from the structure of current and future web site structure and implementation, which allows unambiguous knowledge to be published about each of them.

Note that requests for human-readable html representations of a resource with a `data` URI are already redirected by Europeana services to the appropriately addressed `www` addressed page.

**Data references between Web page and Resource**

In line with the above decision, it is recommended that consideration be given to outputting a representation of the relationship between a resource and the web page displaying it. For example:

Note: In this example the property `schema:mainEntityOfPage` is used to reference the page on which the resource is displayed. This is optional as it may be difficult to maintain, especially when a resource is displayed on more than one page, in themed portals etc.

### 1.5 Data coverage recommendations

**Annotations**

Europeana represents annotations (such as users’ tags, links to related objects) with an extension of EDM based on the recommendations from W3C Web Annotation Model\[[10](https://journal.code4lib.org/articles/#note10)\]. When processing entities for mapping to Schema.org information in these annotations may provide valuable information to be shared using Schema.org properties. For example annotations with a ‘motivation’ of `oa:commenting` could be mapped to `schema:comment`; `oa:tagging` to `schema:about` or possibly `schema:keywords`; `oa:linking` to `schema:sameAs` or `schema:exampleOfWork`, etc.

It was beyond the scope of the project to analyze the current, and potential future, coverage of annotations for comments and provenance etc. in Europeana data. It was recommended however that this coverage should be taken into account when building the mapping rules and processes.

This recommendation carries the caveat that the processing required to do this may impact performance for *[On-the-fly](https://journal.code4lib.org/articles/#onthefly)* data creation (as described in the following Technology section of this report) and therefore may have to be deferred until there are batch mode capabilities available.

**Description of Europeana and providers as organizations**

It is important in placing Europeana resources into context on the web that they are related to well Schema.org-described descriptions of associated entities such as for Europeana as an organization and its data providing partners as organizations. To this end, it is recommended to embed a rich Schema.org description of Europeana as an organization in the [http://europeana.eu page](http://europeana.eu/). Equivalent efforts should also be made for pages about each of the providing partners, when possible, and appropriate references to URIs of Europeana and providers should be made in the (object) data.

Note: in the longer term, to boost the ‘Schema.org reputation’ of the Europeana organization resource, snippets of mark-up “powered by Europeana” should have Schema.org mark-up in them, referring to http://europeana.eu.

## 3\. Technology

The purpose of defining Europeana resources using the Schema.org vocabulary is to enable external organizations in general, and Search Engines in particular, to consume the data into their Knowledge Graphs of resources on the web. Search engines consume such data from sites on the web as part of their standard web crawl processes. They parse the totality of the contents of crawled html pages identifying structured data, in Schema.org form, marked-up using either Microdata, RDFa, or JSON-LD syntax\[[11](https://journal.code4lib.org/articles/#note11)\].

The technical requirements are to provide this Schema.org data embedded within the html pages of Europeana websites without detrimentally impacting the primary purpose of those pages in supporting human interaction.

### 3.1 Separation of Interface Concerns

Over time, it is highly likely that the user interface design requirements of Europeana websites will need to change independently of the underlying data structures. This could be because of aesthetic changes or the introduction of themed views.

Equally as the Schema.org vocabulary and associated industry practices evolve, and the modeling and quality of data stored by Europeana evolves, there will be need to change the structured data embedded in a page without changing the visual representation.

A standard, and the recommended, approach to solve the separation of these needs is to ‘bolt-on’ the structured data to the page construction. This technique, as implemented by OCLC on WorldCat.org, involves inserting a section in the page source code, containing the structured data, that does not impact on its visual output.

### 3.2 JSON-LD Output

If Schema.org output is to be ‘bolted-on’ to page source, the recommended approach is to use JSON-LD format inserted into a html script tag:

This format provides the smallest payload, compared with RDFa and Microdata; JSON-LD is supported by many tools, and is already used in some Europeana API services.

### 3.3 JSON-LD usage

Significant consumers of Schema.org, especially those consuming JSON-LD do not share which tools they are using to parse the data. Therefore the implementation of data format within the JSON-LD should be as simple as possible and follow established guidelines (see the section on *Multilingual Strings* in [Appendix 1](https://journal.code4lib.org/articles/#appendix1)).

### 3.4 Dynamic Loading of JSON-LD

One technically attractive option for embedding JSON-LD is to enable the dynamic loading of the JSON-LD contents into the page. This is achieved by calling a script, potentially hosted on a different server to that serving the web page. This script either will contain the JSON-LD code or will use JavaScript code to insert it into the  of the document. For example:

It has been documented\[[12](https://journal.code4lib.org/articles/#note12)\] that Google indexing tools recognize such data.  
This approach is therefore recommended. Some experimentation would be required to ascertain the most appropriate implementation technique for Europeana.

**Performance**

The introduction of script tags and possible calls to external services could potentially negatively impact the in-browser performance of pages. Experimentation with the placement of script tags (probably near the end of the page) and the use of asynchronous calls should be undertaken to optimise display performance.

**Supporting API**

To support the dynamic loading of JSON-LD, it is recommended that a simple API be implemented on Europeana systems, as a stand-alone tool or as an extension of the current Europeana APIs. It will accept the URI identifier of a resource as a parameter and will return the code to embed JSON-LD into the page it is called from. The call to this API will be added to a `<script>` tag in each page, and the script will be called by browsers displaying the page.

The output format of this API should be generic in nature, not requiring specific html formats within the page. A recommended common technique is for data, being dynamically inserted into the page DOM, to be placed in the element.

**CORS Support**

It is in the nature of the API and JavaScript oriented proposals above that under some circumstances default browser security constraints may block calls to servers from which the page being displayed did not originate. To prevent this CORS\[[13](https://journal.code4lib.org/articles/#note13)\] support should be added to the http headers output by these services.

### 3.5 Generation of Schema.org Data

There are various options for creating Schema.org data, as described previously, from source EDM data.

**On-the-fly**

Potentially the simplest option is to create Schema.org as and when requested, the source data being read as EDM from storage and then being passed through a mapping/conversion process. Such a process would be invoked each time a resource is displayed.

The advantage of such an approach is that no extra data is stored to support Schema.org; also changes to mapping rules are instantly available. Disadvantages include system loading, and difficulty in supporting complex dependencies in data mapping.

**Batch creation**

An alternative is that the resource data is batch processed, to produce additional Schema.org data that is then stored alongside the EDM data. This has the advantage of not needing processing to extract data for display. However there are disadvantages around coping with mapping changes and re-indexing of databases.

**Data Creation Recommendation**

A combination of on-the-fly and batch creation is used over time. Initial implementation should use the on-the-fly approach providing a lightweight flexible approach. Standard web caching techniques may be applied to limit loading requirements of such a service. This would require some understanding of data changes to ensure freshness of cached data.

However future plans for Europeana systems should take into account potential benefits of evolving the current data store into a Europeana knowledge graph in which batch processes following complex relationships within the data could infer and add value to the overall data.

### 3.5 Sitemap

A major end objective is to get search engines to crawl and consume data from the pages describing Europeana resources.

To help them in that task, sitemaps\[[14](https://journal.code4lib.org/articles/#note14)\] need to be provided and well maintained for all pages that contain Schema.org data on the Europeana websites. It is important that these sitemaps are regularly updated to indicate new and updated pages. This needs to take into account pages that visually may not have changed, but have data output that has changed.

Note: as seen earlier, the URI for an object (`http://data.europeana.eu/...`) will differ from the URL of the page(s) that display information about that object (`http://www.europeana.eu/portal/...`). This introduces the potential for a data change to result in more than one URL being identified in the sitemap as being updated. As the `data.europeana.eu` URIs redirect to a default page for an entity, it may be sufficient to use those in the sitemap as a surrogate for the actual page. It is recommended that search engine webmaster tools are used to monitor and analyze crawler coverage over time.

Search engine crawlers tend to be most efficient when they can use sitemaps to gain a view of the real state of a site. Not indicating changed pages, or wrongly indicating that pages have changed, can result in a site not being fully crawled and data not being consumed.

NB: in accordance with the above recommendation “Description of Europeana and providers as organizations”, the sitemap should also include reference to `http://europeana.eu` and provider pages that Europeana could publish in the future.

## 4\. Analytics

The purpose of analytics in the context of Schema.org is to identify changes in the numbers and or visiting patterns of users to Europeana websites. By definition, to identify changes comparisons need to be made with current patterns.

Future pattern traffic predictions include assumptions that there may be an increase of visits directly to individual detail pages. The detailed Schema.org structured data embedded in the pages enabling search engines to more accurately target them as being representative of the resource they describe. It could be expected that this increase in traffic to individual detail pages would be balanced by a decrease in visits to general pages, such as the home and search pages of a site.

It is recommended that current traffic analysis be tuned to identify visits to such pages and the routes taken by users to reach these pages. Then comparison made to identify trends as Schema.org markup is introduced to the site.

Such, more detailed, analysis will help in analyzing increases or decreases in gross site traffic to identify the success, from a user point of view, of visits. One potential scenario that this could help diagnose would be an overall drop in traffic yet an increase in successful visits.

With the recommended introduction of JSON-LD data using html `<script>` tags, there is an opportunity to enable the added Schema.org terms to be used by Google Tag Manager\[[15](https://journal.code4lib.org/articles/#note15)\].

We recommend the use of Schema.org terms to provide Tag Manager enabled enhanced analytics in the future. This could facilitate detailed analytics based upon the type, subject, and/or format of resources, for example.\[[16](https://journal.code4lib.org/articles/#note16)\]

It is not recommended that this step is undertaken immediately. However it is recommended that a simple step is taken to enable its future use. Introducing an id property to the `<script>` tag is enough to enable its contents to be identified by Tag Manager.

| 1 | `<script id="schema" type ="application/ld+json">` |
| --- | --- |

## 5\. Summary

In brief this project has identified that it is possible to represent Europeana data resources using the Schema.org vocabulary. The following points will need to be addressed as part of the project to implement Schema.org output:

- Mapping recommendations – examples of which are in [Appendix 1](https://journal.code4lib.org/articles/#appendix1) below – form the basis to establish processing required to produce Schema.org output for Europeana.eu websites.
- There is a mismatch between the EDM ProvidedCHO core entity, with object types being defined using properties such as `dc:type` and the Schema.org model of defining `schema:CreativeWork` subtypes such as `schema:Book`, `schema:Painting`, `schema:VisualArtwork`, etc. This will require some processing to identify types as part of the mapping.
- Web Resources represented as `schema:MediaObjects` also ideally need to be identified by Schema.org types (`schema:ImageObject`, `schema:AudioObject`, `schema:VideoObject`). Again this will require mapping between MimeTypes, file extensions, etc., to ascertain the correct type.
- The recommended mappings and processing should be refined over time as experience is gained, Europeana entity definitions for context entities (concepts, places, etc.) are introduced, and vocabularies evolve.
- Output should be via JSON-LD embedded in html `<script>` tags in the resource detail pages.
- Dynamically loading JSON-LD, facilitated by a new Europeana API should be considered.
- Initial mapping processing should be carried out on-the-fly as pages are visited.
- Over time, as the data evolves, other entities are introduced, and mapping becomes more complex to add value and quality to the data, batch processing and subsequent storage of terms should be considered.
- Current analytics should be tuned to identify traffic to resource detail pages and the paths taken.
- Over time, after the introduction of Schema.org output, comparison of traffic patterns to detail pages should be compared with current patterns.
- In preparation for possible enhanced analytics using Google Tag Manager, an id property should be added to the JSON-LD `<script>` tag.

## About the Authors

Richard Wallis (richard.wallis@dataliberate.com) is an Independent Consultant, with a long history in Library and Semantic Web technology, at the forefront of promoting, explaining, and applying new and emerging Web, Semantic Web, and Linked Data technologies. He works with Google and others in the support, extension and application of the Schema.org vocabulary. Also chairing and participating in several W3C Community Groups focused on the development of the vocabulary in areas such as bibliographic & cultural heritage resources, tourism, and finance. This background informing his work with many clients helping them introduce Schema.org into their web presence and supporting infrastructure.

Antoine Isaac (antoine.isaac@europeana.eu) is R&D Manager at Europeana. He works and coordinates work on various aspects of the interoperability and quality of cultural collections on the web, focusing on Linked Data and Semantic Web technologies. He has served various W3C efforts, like SKOS, Library Linked Data, and Data on the Web Best Practices. He is also a guest researcher at the Web & Media group in the Free University Amsterdam.

Valentine Charles (valentine.charles@europeana.eu) is Data R&D coordinator at Europeana. She consults the Europeana Network on data practices and standards and communicates Europeana’s R&D activities to the broader cultural heritage sector. She also coordinates the further development and adoption of the Europeana Data Model (EDM). Valentine is also Co-Chair of the Dublin Core Metadata Initiative (DCMI) Technical Board and Community Specification Committee.

Hugo Manguinhas (hugo.manguinhas@europeana.eu) has recently taken on the role of Product Owner for APIs at Europeana, but was working before as the Technical Coordinator for Research & Development for the same institution. He advised and coordinated the scientific work on Europeana-related projects and participated in the development of Europeana’s Linked Open Data, Metadata Enrichment, Vocabulary services and alignment, Data Quality and Crowdsourcing Infrastructure.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] [http://europeana.eu/](http://europeana.eu/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] [http://pro.europeana.eu/edm-documentation](http://pro.europeana.eu/edm-documentation)

\[[3](https://journal.code4lib.org/articles/#ref3)\] [http://schema.org](http://schema.org/)

\[[4](https://journal.code4lib.org/articles/#ref4)\] [http://json-ld.org/](http://json-ld.org/)

\[[5](https://journal.code4lib.org/articles/#ref5)\] [http://wiki.dublincore.org/index.php/Glossary/One-to-One\_Principle](http://wiki.dublincore.org/index.php/Glossary/One-to-One_Principle)

\[[6](https://journal.code4lib.org/articles/#ref6)\] [http://www.getty.edu/research/tools/vocabularies/lod/](http://www.getty.edu/research/tools/vocabularies/lod/)

\[[7](https://journal.code4lib.org/articles/#ref7)\] [https://www.w3.org/DesignIssues/LinkedData.html](https://www.w3.org/DesignIssues/LinkedData.html)

\[[8](https://journal.code4lib.org/articles/#ref8)\] [https://www.w3.org/Submission/CBD/](https://www.w3.org/Submission/CBD/)

\[[9](https://journal.code4lib.org/articles/#ref9)\] [http://labs.europeana.eu/api/record-jsonld](http://labs.europeana.eu/api/record-jsonld)

\[[10](https://journal.code4lib.org/articles/#ref10)\] [https://www.w3.org/TR/annotation-model/](https://www.w3.org/TR/annotation-model/)

\[[11](https://journal.code4lib.org/articles/#ref11)\] [https://schema.org/docs/gs.html](https://schema.org/docs/gs.html)

\[[12](https://journal.code4lib.org/articles/#ref12)\] [http://www.centrical.com/test/google-json-ld-and-javascript-crawling-and-indexing-test.html](http://www.centrical.com/test/google-json-ld-and-javascript-crawling-and-indexing-test.html)

\[[13](https://journal.code4lib.org/articles/#ref13)\] Cross-Origin Resource Sharing (CORS) [http:/enable-cors.org/](http://enable-cors.org/), the server needs to add the following http header to its response: `Access-Control-Allow-Origin: *`

\[[14](https://journal.code4lib.org/articles/#ref14)\] [https://en.wikipedia.org/wiki/Site\_map](https://en.wikipedia.org/wiki/Site_map)

\[[15](https://journal.code4lib.org/articles/#ref15)\] [https://www.google.com/analytics/tag-manager/](https://www.google.com/analytics/tag-manager/)

\[[16](https://journal.code4lib.org/articles/#ref16)\] So that we can compare e.g. traffic towards books with traffic towards paintings. This could be useful to measure the efficiency of the mapping. Especially for advanced mappings, like the ones to specializations of CreativeWork, or the ones with links to specific collections, like pinboards.

\[[17](https://journal.code4lib.org/articles/#ref17)\] [http://www.europeana.eu/portal/record/2021618/internetserver\_Details\_kunst\_25027.html](http://www.europeana.eu/portal/record/2021618/internetserver_Details_kunst_25027.html)

\[[18](https://journal.code4lib.org/articles/#ref18)\] [http://www.europeana.eu/portal/record/09102/\_UEDIN\_214.html](http://www.europeana.eu/portal/record/09102/_UEDIN_214.html)

\[[19](https://journal.code4lib.org/articles/#ref19)\] [http://tools.ietf.org/html/bcp47](http://tools.ietf.org/html/bcp47)

\[[20](https://journal.code4lib.org/articles/#ref20)\] [https://en.wikipedia.org/wiki/ISO\_8601](https://en.wikipedia.org/wiki/ISO_8601)

\[[21](https://journal.code4lib.org/articles/#ref21)\] [http://schema.org/docs/gs.html#schemaorg\_expected](http://schema.org/docs/gs.html#schemaorg_expected)

\[[22](https://journal.code4lib.org/articles/#ref22)\] [http://schema.org/docs/gs.html#advanced\_enum](http://schema.org/docs/gs.html#advanced_enum)

\[[23](https://journal.code4lib.org/articles/#ref23)\] [https://github.com/schemaorg/schemaorg/issues/894](https://github.com/schemaorg/schemaorg/issues/894)

## Appendix 1 – Data Mapping Recommendations

Two approaches were taken in recommending mapping from current EDM based resources to Schema.org. The attached PDF [documents the recommendations thus far](https://journal.code4lib.org/media/issue36/wallis/MappingFromEDMtoSchema.pdf).

Firstly, resources are described directly in Schema.org drawing data from available EDM, but not being constrained by those structures.

Two example files, appended to this report, (`mona-lisa.jsonld` & `buccin.jsonld`) are supplied as examples. Source for these examples were drawn from their associated web pages: Mona Lisa\[[17](https://journal.code4lib.org/articles/#note17)\] & Buccin\[[18](https://journal.code4lib.org/articles/#note18)\] and their `debug=json` outputs.

Inspecting the `mona-lisa.jsonld` example:

*Note: the examples and recommendations supplied here can only provide guidance towards the process of building a mapping structure for terms to be described using Schema.org. It is inevitable with the significant range of resource types that some anomalies will occur when following a basic recommendation. These will need to be addressed by experience over time.*

### A1.1 CreativeWork Properties

**@id**  
This indicates the URI identifier of the resource itself as to be shared with the web, not a proxy or other internal identifier. This URI should resolve to a description of the resource (which is already the case for data.europeana.eu URIs).

**@type**  
It is assumed that all Europeana `ProvidedCHO` resources can be described as CreativeWorks. It is normal practice to provide multiple schema types when appropriate. Wherever possible a more accurate type should be provided. This introduces challenges in the mapping process as some of the information required to calculate the resource type are currently held in properties such as `dc:type` and `ebucore:hasMimeType`.

Some physical resources (such as the trombone in the Buccin example) can be defined as type `Schema Product`, which introduces properties such as `manufacturer` and `itemCondition` to further aid description.

**name**  
The name/title of the resource. (See notes below about multilingual strings)

**description**  
The description of the resource. (See notes below about multilingual strings)

**creator**  
In this example `"creator": ["_p:0","_p:1"]`, is indicating blank-node identifiers for two creators linking to Person entity descriptions later in the output. Eventually as Europeana entity descriptions become available, these should be replaced by fully resolvable URIs. See also discussion on `Person/Organization`.

**about**  
This often repeated property contains text and or URIs for related entities that the resource is related with. In this example it includes a reference to the name of the artwork that this represents, “Mona Lisa”, and the Identifier of the original creator `_:P1` (Leonardo da Vinci). Equally it could include references to places, types of object (e.g., in `dc:type` and `edm:hasType`), and other concepts.

Ideally, types references for `schema:about` would be filtered, avoiding especially the types that lead to assigning a specific `@type` value. Rules that do not select Book, Painting, etc., could be applied. Also types that are local would ideally be related to reference types, such as the Wikidata ones (for example a trombone would be: `Thing sameAs https://www.wikidata.org/wiki/Q8350`)

**artMedium/artform/artworkSurface**  
These are properties of `schema:VisualArtwork` indicating the physical type of artwork such as sculpture, painting, drawing, etc. In this example, `"grafiek"` was drawn from `dc:type`. Note: These properties are only available for a VisualArtwork Type. If used, the resource type should be defined as `schema:VisualArtwork` in addition to `schema:CreativeWork` etc.

Ideally the URI of an authoritative term, either Europeana supplied or external (such as Getty AAT, Wikidata, etc.) should be used here if available.

Note: given the high variability in the corresponding EDM fields, recognizing appropriate values for mapping to these properties will be quite difficult in an initial stage.

**height/width/depth**  
If this information is available it should be provided using a `schema:QuantitativeValue` description to indicate the value and (UN/CEFACT)  
unitCode. For example:

| 1  2  3  4  5 | `"height"``: {`  `"@type"``: ``"QuantitativeValue"``,`  `"value"``: ``"768"``,`  `"unitCode"``: ``"MMT"`  `},` |
| --- | --- |

Note: this is probably more for WebResources as values for these properties is expected to be hard to get from the `dcterms:extent` of the ProvidedCHO, which often includes all this information in one (language-specific) text value.

**license**  
This should be the URI of a license description that applies to the resource, preferably, as in the example, an authoritative URI. In accordance to Europeana’s focus on standardized rights statements, `schema:license` should be used only with `edm:rights`. Other, less constrained rights-related properties like dc:rights, of the ProvidedCHO being described, could be mapped to another description string.

Note: For a `CreativeWork`, or a subtype of it, license information may be derived from a `ProvidedCHO`, an `Aggregation`, or `WebResource`. Potentially there could be differences between the \[dc: or edm:\] rights statements on an individual, or one of the related, resources that are being used to populate the `CreativeWork`. Also some `dc:rights` statements may not be informative. In these cases it is recommended to identify at least the Creative Works that are in the Public Domain. In this case we could have a rule saying “map it from `edm:rights` when the value is Public Domain.”

**thumbnailUrl**  
Url of an openly viewable preview image.

**provider**  
Name or, preferably, URI of providing organization(s) or person(s).

**encoding/associatedMedia**  
Reference to the `MediaObject` representation of the `CreativeWork`. `schema:encoding` and `schema:associatedMedia` are synonyms for each other. It is recommended that `associatedMedia` is used as it has greater usage.

**potentialAction**  
This provides a description of ways that a user could potentially interact with the resource. For Europeana resources it is expected that this would be an instance of `ListenAction`, `ReadAction`, `ViewAction`, or `WatchAction` (depending on the value of `edm:type`). `ViewAction` should be the default if the detailed required action type cannot be ascertained from `edm:type`, for example.

In the example, the `ViewAction` has been given a name “View at Teylers Museum.” There is an expectation that a Search engine may use this to annotate a link they would offer to a user. This string would have to be created as part of a mapping process.

Note: The target value of an action, in Europeana’s case, should be the Europeana proxy URL for a partner’s web page. This will enable the tracking of traffic. However, potentially this could be seen by the search engine as internal linking, decreasing its importance in their indexing. Only traffic analysis over time will make these effects clear.

If the information is available, a `schema:Offer` could be provided as a `schema:expectsAcceptanceOf` value, describing costs/requirements needed to enable the action to be carried out.

### A1.2 Media

The buccin.jsonld example identifies some of the issues in relating media representations to resource descriptions.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19 | `{`  `"provider"``: [``"_:o0"``, ``"_:or1"``, ``"University of Edinburgh"``],`  `"audio"``: ``"_:MO0"``,`  `"image"``: ``"_:MO1"``,`  `"video"``: ``"_:MO2"``,`  `},`  `{`  `"@id"``: ``"_MO0"``,`  `"@type"``: ``"AudioObject"``,`  `"name"``: ``"Buccin trombone. Nominal pitch: B?"``,`  `"duration"``: ``"30334"``,`  `"bitrate"``: ``"128000"``,`  `"encodingFormat"``: ``"mp3"``,`  `"contentSize"``: ``"485349"``,`  `...`  `}` |
| --- | --- |

**audio/image/video**  
The basic approach is to provide the access URI for the media files, as properties of the resource description. However Europeana contains rich information about these media representations. It is recommended that these should be described using `schema:MediaObject` or appropriate subtypes. Note that using specialized properties (`schema:audio`, `schema:image`, `schema:video`) is only possible when a specific subtype of `MediaObject` has been recognized.

**MediaObject/AudioObject/ImageObject/VideoObject**  
Mapped by analyzing `MimeType`, file suffix, dc:format and or possibly `dc:type`, the appropriate type should be chosen. If exact type is not ascertainable `MediaObject` should be used.

**encodesCreativeWork**  
Relates back to the resource description.

**duration/bitrate/encodingFormat/contentSize/height/width**  
As much detailed technical information as possible should be included.

**name/provider/description**  
Although potentially a repeat of information in the main resource description this also needs to be included within the `MediaObject` description.

**license**  
License for media can differ from that of the `ProvidedCHO` so should be explicitly supplied for a media object.

### A1.3 Person/Organization

In all cases that reference persons or organizations – `creator`, `provider`, etc. – need to be defined as a `schema:Person` or `schema:Organization`. There is no Schema.org equivalent of `edm:Agent`. The specific type should be known when the resource derives from prior entification done by Europeana. If the type is unknown, they should be defined as a `schema:Thing`.

As future work the following hints may be also used: (i) use of person- or organization-specific attributes on the resource to be typed (ii) use of the resource to be typed as object in a statement where the property is expected to be used with persons or organizations in the Europeana context.

### A1.4 sameAs

Wherever possible `schema:sameAs` references should be provided between Europeana resources & entities, and external equivalents. This is particularly relevant for concept, person, organization, and place entities. Note that `schema:sameAs` has broader scope than `owl:sameAs`: it can cover `skos:exactMatch` or even `skos:closeMatch` (up to the data publisher’s preference):

### A1.5 Multilingual strings

Multilingual values for names, etc., should be provided as a language tagged array of strings as per the example:

Note: Do not mix language tagged strings with normal strings in a single array.

### A1.6 Text Values and data types – BCP 47 / ISO6801 etc.

Schema.org recommends BCP 47\[[19](https://journal.code4lib.org/articles/#note19)\] for language definitions; ISO 8601\[[20](https://journal.code4lib.org/articles/#note20)\] for Date / Time references; and expected Types for Schema Properties. Ideally these requirements should be adhered to wherever possible. However under the spirit of *any data is better than no data* and Schema.org guidance\[[21](https://journal.code4lib.org/articles/#note21)\], it is acceptable to include the representation available from EDM source data. This includes dates such as “Circa. 1850”, and text only representations for a resource where an entity representation can not be supplied. The same applies for similar recommendations for data types for properties in Schema.org. It’s up to the data consumer to do something with these recommendations. Not implementing them will mean missing opportunities, but it should not be too detrimental to item discovery.

### A1.7 Concept Entities

Within the Schema.org vocabulary there is Type for ‘Concept’. In principle a set of concepts, or authoritative values (subject headings) would be represented as Enumerations\[[22](https://journal.code4lib.org/articles/#note22)\] in Schema.org. These are reserved in the vocabulary for simple small sets of data such as for `schema:BookFormatType`.

It is recommended that when defining a Concept entity it is given a Schema.org Type of Thing. When defining concepts it is important to provide sameAs relationships to external authoritative sources for the same concept – Getty, Wikidata, LCSH, etc.

Note: There is currently a proposal\[[23](https://journal.code4lib.org/articles/#note23)\] to the Schema.org community to enable the description of concepts, described as a `schema:CategoryCode`. If that proposal is accepted Europeana should adopt that markup form.

## Appendix 2: Schema.org JSON-LD Example : Mona Lisa

## Appendix 3: Schema.org JSON-LD Example: Buccin

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99  100  101  102  103  104  105  106  107  108  109  110  111  112  113  114  115  116  117  118  119  120  121  122  123  124  125  126  127  128 | `<script type=``"application/ld+json"``>`  `{`  `"@graph"``:[`  `{`  `"@type"``: [``"CreativeWork"``,``"Product"``],`  `"name"``: ``"Buccin trombone. Nominal pitch: B?"``,`  `"description"``: ``"Technical description: Brass; ligature fitting on bell section at joint; stockings on main slides. Bell with one coil, angled to face forwards. Repair History: Main slide possibly not original (tenon of slide section of joint is tapered, bell section joint for cylindrical tenon)."``,`  `"dateCreated"``: ``"Circa 1840"``,`  `"about"``: [`  `],`  `"about"``: [`  `{`  `"@language"``: ``"de"``,`  `"@value"``: ``"Buccin"`  `},`  `{`  `"@language"``: ``"sv"``,`  `"@value"``: ``"Buccin"`  `},`  `{`  `"@language"``: ``"en"``,`  `"@value"``: ``"Buccin"`  `},`  `{`  `"@language"``: ``"it"``,`  `"@value"``: ``"Buccin-trombone"`  `},`  `{`  `"@language"``: ``"fr"``,`  `"@value"``: ``"Buccin"`  `},`  `{`  `"@language"``: ``"nl"``,`  `"@value"``: ``"Buccin"`  `},`  `],`  `"potentialAction"``: {`  `"@type"``: ``"ViewAction"``,`  `"name"``: ``"View at MIMO - Musical Instrument Museums Online"``,`  `},`  `"provider"``:  [``"_:o0"``,``"_:or1"``,``"University of Edinburgh"``],`  `"audio"``: ``"_:MO0"``,`  `"image"``: ``"_:MO1"``,`  `"video"``: ``"_:MO2"``,`  `},`  `{`  `"@id"``: ``"_MO0"``,`  `"@type"``: ``"AudioObject"``,`  `"name"``: ``"Buccin trombone. Nominal pitch: B?"``,`  `"about"``: [`  `],`  `"duration"``: ``"30334"``,`  `"bitrate"``: ``"128000"``,`  `"encodingFormat"``: ``"mp3"``,`  `"contentSize"``: ``"485349"``,`  `"provider"``: ``"_:or1"``,`  `},`  `{`  `"@id"``: ``"_:MO2"``,`  `"@type"``: ``"VideoObject"``,`  `"name"``: ``"Buccin trombone. Nominal pitch: B?"``,`  `"about"``: [`  `],`  `"duration"``: ``"40411"``,`  `"bitrate"``: ``"128000"``,`  `"height"``: ``"576"``,`  `"width"``: ``"720"``,`  `"encodingFormat"``: ``"mpg"``,`  `"contentSize"``: ``"19480576"``,`  `"provider"``: ``"_:or1"``,`  `},`  `{`  `"@id"``: ``"_:MO1"``,`  `"@type"``: ``"ImageObject"``,`  `"name"``: ``"Buccin trombone. Nominal pitch: B?"``,`  `"about"``: [`  `],`  `"encodingFormat"``: ``"jpg"``,`  `"provider"``: ``"_:or1"``,`  `},`  `{`  `"@id"``: ``"_:or0"``,`  `"@type"``: ``"LocalBusiness"``,`  `"name"``: ``"Europeana"``,`  `},`  `{`  `"@id"``: ``"_:or1"``,`  `"@type"``: ``"LocalBusiness"``,`  `"name"``: ``"MIMO - Musical Instrument Museums Online"``,`  `},`  `{`  `"@id"``: ``"_:or2"``,`  `"@type"``: ``"LocalBusiness"``,`  `"name"``: ``"University of Edinburgh"`  `}`  `]`  `}` |
| --- | --- |
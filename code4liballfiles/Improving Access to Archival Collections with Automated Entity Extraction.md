---
title: "Improving Access to Archival Collections with Automated Entity Extraction"
source: "https://journal.code4lib.org/articles/10726"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-07-15
created: 2025-01-10
description: "The complexity and diversity of archival resources make constructing rich metadata records time consuming and expensive, which in turn limits access to these valuable materials. However, significant automation of the metadata creation process would dramatically reduce the cost of providing access points, improve access to individual resources, and establish connections between resources that would otherwise [...]"
tags:
  - "clippings"
---
# Improving Access to Archival Collections with Automated Entity Extraction
Kyle Banerjee, Max Johnson

The complexity and diversity of archival resources make constructing rich metadata records time consuming and expensive, which in turn limits access to these valuable materials. However, significant automation of the metadata creation process would dramatically reduce the cost of providing access points, improve access to individual resources, and establish connections between resources that would otherwise remain unknown.

Using a case study at Oregon Health & Science University as a lens to examine the conceptual and technical challenges associated with automated extraction of access points, we discuss using publically accessible API’s to extract entities (i.e. people, places, concepts, etc.) from digital and digitized objects. We describe why Linked Open Data is not well suited for a use case such as ours. We conclude with recommendations about how this method can be used in archives as well as for other library applications.

## Introduction

Archival collections contain a wealth of knowledge in finding aids, oral histories, letters, and other materials. However, subject access to these resources is minimal, and it’s difficult for researchers to identify information relevant to their needs in these resources or in supplementary materials such as blog entries, reports, photos, exhibit text, and other materials created by archivists, special collections librarians, and their staff. Manual assignment of access points is too time consuming and expensive to be practical for large numbers of items or when staff are under time pressure — providing access points to a single oral history might take a skilled professional two to three hours.

In late 2014, staff at Oregon Health & Science University (OHSU) initiated an experiment to see if cloud-based entity extraction services could help with this problem. If the entities — such as people, places, and concepts — within archival resources could be identified automatically, then new access points could be created more efficiently. Valuable linkages could be created among items that might otherwise never be discovered, allowing researchers to search collections more quickly and comprehensively. We found that staff assisted with automated identification of entities (i.e. people, places, concepts, etc.) can provide access points to an oral history within a few minutes, demonstrating that such tools could help improve access to archival collections.

Our experiment focused on oral histories because this class of documents is finite and currently has minimal access at OHSU, but we also attempted to extract entities from other types of documents including Encoded Archival Description (EAD) finding aids, drug approval documents, and Web pages. We briefly examined a number of services including [Aylien](http://aylien.com/), [MeaningCloud](http://www.meaningcloud.com/products/topics-extraction/), [OpenCalais](http://www.opencalais.com/), [Semantria](https://semantria.com/), [TextRazor](https://www.textrazor.com/), and [Zemanta](http://www.zemanta.com/) before deciding that [AlchemyAPI](http://www.alchemyapi.com/) met our specific needs best.

## Choosing an API

Many of the text extraction services we explored were not compatible with our needs because they either appeared optimized for processing particular types of documents such as news ([Aylien](http://aylien.com/), [OpenCalais](http://www.opencalais.com/), [TextRazor](https://www.textrazor.com/)) or short communications like tweets ([dataTXT](https://dandelion.eu/products/datatxt), [Semantria](https://semantria.com/)), or they are designed to support particular services such as content based ads ([Zemanta](http://www.zemanta.com/)) or competitive intelligence ([MeaningCloud](http://www.meaningcloud.com/products/topics-extraction/)). We had no budget, so we tested API keys for free tiers of service. The restrictions associated with the accounts were usually documented clearly — typically a charge against a quota.

However, we sometimes received inconsistent results in repeated tests against the same document with some services. This behavior repeated itself too frequently to be attributable to changes in the service itself. Vendor documentation provided no explanation as to why this might happen, so we speculate it could possibly reflect the service returning whatever it can within a given amount of time. Despite the limitations we encountered, we felt the free accounts were permissive enough to allow us to determine the suitability of individual services for our needs.

While more than one of the services could have met our needs adequately, we selected AlchemyAPI because it performed better with some of the specific types of entities that interested us, less postprocessing of output was necessary, and our use case fit more easily within their free use tier.

## Issues with Entity Extraction

Simply extracting entities is of limited utility, even if this task can be performed at 100% accuracy because documents often mention entities that are unimportant. For example, every oral history in OHSU’s archives references OHSU. The vast majority of archival documents in our collection reference Oregon, and there are a number of other entities that commonly appear in documents and records. Within the context of OHSU collections, mentioning Oregon, OHSU, and major departments within OHSU is not significant so these entities should be used as access points only for documents that actually are about these things. Otherwise, the sheer number of entries makes it harder to find resources relevant to these entities.

Our project aims to identify access points to be presented as simple Web links that help people find related items. In other words, we want meaningful tags to add to metadata records. Surrogate (i.e. metadata) searches support different use cases than full text searches, so the key is to identify a small number of relevant entities that represent the “aboutness” of a resource rather than a large number of entities that are mentioned in a resource.

Identifying relevance is difficult within the context of entity extraction. Frequent mention of OHSU, the School of Nursing, bone cancer, or fluoxetine (the generic name for Prozac) in a document is not by itself a reliable indicator that an entity is relevant. Likewise, the fact that a term appears only once does not mean it is not highly important — to make textual content less redundant, people often reference things obliquely, incompletely (e.g. “Dr. Beals,” “School of Medicine,” etc.) or using terms representing various levels of abstraction. We found that extracting as much relevant information as possible, but not so much that working with the extracted information takes more time than it would for a human operator to manually scan materials and identify access points, was challenging.

Text extraction software relies on heuristics and pattern matching to determine which entities are present and what type of entities they are. This is a complex task because names for people, places, and things are often identical — consider how the entity “Washington” could be any one of many people, geographic or political entities, roads, bridges, buildings, etc. This task is further complicated in that information about different types of objects may be structured in ways that the heuristic algorithms may not anticipate.

Our entity extraction tests proved much more successful on unstructured documents than on structured and semistructured metadata such as EAD. We hoped AlchemyAPI or other services could extract relevant entries from extensive EAD documents as these frequently reference people, organizations, and other entities of interest. However, data in EAD and MARC records are structured according to library conventions — for example names are presented in inverted order, geographic and corporate entities are frequently qualified, and the information is generally presented in a terse manner. Such conventions led to a dramatic reduction in accuracy from tested entity extractors which assume documents are expressed in natural language.

For specialized applications such as archives, documents follow specific structures and most important entities are domain specific. However, the cloud-based services we tested cannot be trained with local data and documents. They consult predetermined knowledgebases and their algorithms are optimized for extracting information from news and social media. Nonetheless, these services can be used to extract terms from a representative corpus of documents which can then be curated so that specific access points could be targeted or rejected with the aid of scripts.

## A Simple Example

The three line script below illustrates how AlchemyAPI can extract entities from an oral history served as a PDF on the Web. All services we tested offered a simple REST based API that can be integrated into any process using the language of one’s choosing. In addition to being accessible via direct HTTP GET and POST calls, AlchemyAPI provides SDK’s for Python, PHP, Ruby, and Node.js as well as a particularly easy-to-use command line client. Depending on the parameters used in API calls, AlchemyAPI can return entities in a number of formats including json, RDF, delimited text, and XML. It can also return Linked Open Data (LOD) — i.e. information about the entities themselves as well as the data sources for that information. The following lines download a PDF from the Web, convert it to text, and extract entities which are described in XML using AlchemyAPI:

```
~$ wget 'http://digitalcommons.ohsu.edu/cgi/viewcontent.cgi?article=1000&context=hca-oralhist' -O temp.pdf
 ~$ pdftotext temp.pdf
 ~$ alchemycmd --mode entity -S text -F temp.txt -O xml
```

That returns the following output:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47 | `<?``xml` `version``=``"1.0"` `encoding``=``"UTF-8"``?>`  `<``results``>`  `<``status``>OK</``status``>`  `<``warningMessage``>truncated-oversized-text-content</``warningMessage``>`  `<``usage``>By accessing AlchemyAPI or using information generated by AlchemyAPI, you are agreeing to be bound by the AlchemyAPI Terms of Use: [http://www.alchemyapi.com/company/terms.html](http://www.alchemyapi.com/company/terms.html)</``usage``>`  `<``url``></``url``>`  `<``language``>english</``language``>`  `<``entities``>`  `<``entity``>`  `<``type``>Person</``type``>`  `<``relevance``>0.923889</``relevance``>`  `<``count``>72</``count``>`  `<``text``>Dr. Rodney K. Beals</``text``>`  `</``entity``>`  `<``entity``>`  `<``type``>Organization</``type``>`  `<``relevance``>0.460871</``relevance``>`  `<``count``>22</``count``>`  `<``text``>Medical School</``text``>`  `</``entity``>`  `<``entity``>`  `<``type``>StateOrCounty</``type``>`  `<``relevance``>0.417948</``relevance``>`  `<``count``>18</``count``>`  `<``text``>Oregon</``text``>`  `<``disambiguated``>`  `<``name``>Oregon</``name``>`  `<``subType``>Location</``subType``>`  `<``subType``>PoliticalDistrict</``subType``>`  `<``subType``>AdministrativeDivision</``subType``>`  `<``subType``>GovernmentalJurisdiction</``subType``>`  `<``subType``>USState</``subType``>`  `<``subType``>WineRegion</``subType``>`  `</``disambiguated``>`  `</``entity``>`  `...[most of output omitted]...`  `</``entities``>`  `</``results``>` |
| --- | --- |

If PDF to text conversion is unnecessary, a browser can be used to explore AlchemyAPI simply by pasting URL’s containing supported parameters, e.g.:

```
http://access.alchemyapi.com/calls/url/URLGetRankedNamedEntities?url=[url]&apikey=[secret]
```

## Working with API Output

All entity extractors return far more data than is useful — services that don’t truncate output due to parameters passed to the API or service limitations returned hundreds of entities for a single oral history, many of which were not useful for purposes of creating access points. In addition, most extractors also returned a great deal of information about many of the entities. For example, the phrase “Oregon Health & Science University” frequently appears in documents at Oregon Health & Science University. When AlchemyAPI sees that word, it returned:

AlchemyAPI recognizes that “Oregon” and “Oregon Health & Science University” are not the same thing and that “Oregon Health & Science University” and “OHSU” are the same thing. However, simple identification of this entity does not make it relevant, and the additional information returned by the API is not useful even if all of it is correct. Users must find navigation of linkages and external information intuitive for identification of these entities to be helpful.

The challenge with providing links to external information is that they must be aligned with the user’s workflow to be useful. Just as it is unhelpful to include numerous links in this article that break the reader’s flow of thought in the name of providing more information, it is not helpful to include links in metadata records which distract the user from having his or her information need satisfied. Users have different needs, but interfaces must be optimized to meet use cases appropriate for the service being provided to be predictable and useful. Including information simply because someone might conceivably have a use for it undermines the entire premise for organizing information.

Looking up terms in a knowledgebase frequently led to incorrect identifications. For example, when a document referenced a letter written by a person with a last name of “Beck,” AlchemyAPI identified the entry as a potential Composer, Musical Artist, Award Nominee, Award Winner, Broadcast Artist, Celebrity, Film Music Contributor, Guitarist, Lyricist, Musical Group Member, Recording Engineer, Record Producer, Songwriter, and TV Actor. It identified the website for “Beck” the musician and drew information from DBpedia, Freebase, and MusicBrainz. In fact, we found that linkages returned by services were outright detrimental because many people, places, organizations, and other entities have nonunique or ambiguous names.

In general, we found the Linked Open Data (LOD) returned by various services was reliable for common entities but was almost always incorrect for lesser known ones. For example, there are over 100,000 people with the last name of “Beck” in the United States \[[http://howmanyofme.com/](http://howmanyofme.com/)\]. LOD sources containing names may know of the famous musician in addition to other well-known people named “Beck.” However, they won’t know about obscure individuals with that name. Many individuals referenced in archival documents have common names and are not famous, so the LOD returned for them is inevitably erroneous. Even when the information returned for common entities is correct (Oregon, OHSU School of Medicine, Willamette Valley, etc.), there is little need for linkages to such entities which are better researched in other environments. For LOD to be useful in an archival context, the knowledgebase needs to reflect information in the archives being searched and to support archival research use cases. Given that the LOD sources cloud-based entity extractors utilize are optimized for general use cases such as parsing social media and news, they are best disabled for specialized needs such as archives.

Disabling disambiguation and LOD functionality in our queries via parameters in the API calls dramatically reduced the amount of spurious information. For example, doing so caused the “Beck” entity to be identified only as a person, which is both interesting and correct. AlchemyAPI detects hundreds of types of entities such as time expressions, shopping malls, body parts, comic book publishers, ski areas, quantities, radio programs, and concepts. By focusing on things we were specifically interested in such as people, organizations, drugs, and health conditions, we were able to reduce the information returned to a manageable level.

Removing the verbose XML display and unhelpful LOD data while limiting to those specific domains is trivial and can be accomplished several ways including the following:

```
~# wget 'http://digitalcommons.ohsu.edu/cgi/viewcontent.cgi?article=1000&context=hca-oralhist' -O temp.pdf
 ~# pdftotext temp.pdf
 ~# alchemycmd --mode entity -S text -F temp.txt | \
 > grep -E ‘,(Anatomy|HealthCondition|Organization|Person|Drug),'
```

This returns entities in relevance order in the form of:

```
 Dr. Rodney K. Beals,Person,0.923889
 Medical School,Organization,0.460871
 Jim Kronenberg,Person,0.384462
 Professor Emeritus Rodney K. Beals,Person,0.371191
 Dr. Dillehunt,Person,0.297205
 Division of Orthopedics,Organization,0.290363
 Frenchy Chuinard,Person,0.289277
 Shriners,Organization,0.28133
 Oregon Medical Association,Organization,0.257537
 OHSU,Organization,0.251646
 … [rest of output omitted] ...
```

As observed earlier, people, places, and things frequently share names so the same text was sometimes identified as different types of entities in the same document. For example, in one finding aid, the phrase A. D. Mackenzie Papers was separately identified as a “facility” (one occurrence) and as an “organization”(two occurrences). Elsewhere, in that same document, the phrase “Alexander Donald Mackenzie Papers” was identified as a person. In this particular case, AlchemyAPI correctly identified the presence of an entity three times, but was wrong all three times about what type of entity it was. Likewise, societies were consistently identified as facilities rather than organizations. We found this strange because the name “Society” appeared in them and there were no sources of linked data associated with these that would have fooled AlchemyAPI (e.g. Oregon State Medical Society, Yamhill County Medical Society, Portland City and County Medical Society). However, entity type identification was reliable enough that we found it worthwhile to ignore entities that did not have the right type despite the fact that doing so causes a small but significant quantity of desirable entities to be ignored. At some point in the future, we intend to generate lists of entities that are inherently interesting and then use post processing to transform them into the more accurate form.

In an archival context, AlchemyAPI can help staff identify significant terms and indicate their unique roles in documents and related archival materials. We found access points extracted from oral histories can help identify collections or materials that were previously unlinked. This increases the value of the oral histories as well as that of related archival materials across different records groups, administrative units and bodies — even if they are spread across institutions with divergent record creation practices, storage policies, and procedures.

One practical use of AlchemyAPI is to compare the list of terms it returns with current collection indices, subject headings, creator names, and institutional functions found within other archival materials and then manually create links between the entity output and the archival resource — these linkages can be presented in the form of traditional SEE ALSO, SEE AND statements. For example, we start with the output from above:

```
 Medical School,Organization,0.460871
 Jim Kronenberg,Person,0.384462
 Professor Emeritus Rodney K. Beals,Person,0.371191
 Dr. Dillehunt,Person,0.297205
 Division of Orthopedics,Organization,0.290363
 Frenchy Chuinard,Person,0.289277
 Shriners,Organization,0.28133
 Oregon Medical Association,Organization,0.257537
 OHSU,Organization,0.251646
```

And then we use a process we call “uniquity triangulation” to establish relationships which commonly occur across our collections. “Uniquity triangulation” could be considered a broad concept used to describe manually sifting through terms to gather and target specific sets of OHSU-specific terms that assist in elevating the document to a state of uniquity useful in aiding researchers with the decision of whether to dig deeper into any one document. This process could yield:

```
 Jim Kronenberg,Person
 Professor Emeritus Rodney K. Beals,Person
 Dr. Dillehunt,Person, SEE ALSO Richard B. Dillehunt Photograph Album (2004-001)
 Division of Orthopedics,Organization
 Frenchy Chuinard,Person
 Shriners,Organization
 Oregon Medical Association,Organization SEE ALSO Oregon Medical Association: Oral History Project (2004-005)
```

By limiting output to desired information sources and entity types, reducing the frequency of common terms within the context of our collections (e.g. “OHSU” is not a unique term in OHSU Oral Histories, for example), and focusing on terms that appear with a high enough frequency to suggest relevance, our “uniquity triangulation” process combines automated extraction with staff judgment to identify useful access points.

## Conclusions

Commercial cloud-based entity extractors appear to be optimized to analyze social media, news, and shorter documents to support general knowledge use cases. As such, we do not find them suitable for fully automated generation of semantic data for special collections descriptions even if we do think they are potentially a valuable tool that can help archival staff work more effectively.

For all API’s that we tested, we found the following to be true:

- Each API appears to be optimized for certain types of documents
- Performance was significantly better on unstructured text than on structured documents such as Encoded Archival Description (EAD) finding aids
- So many entities were extracted that filters must be applied for the output to be manageable
- Inherent ambiguities in the way concepts are expressed caused significant entity pollution, and this problem was amplified considerably when Linked Open Data (LOD) was enabled
- The general knowledge LOD sources consulted by the API’s created associations that were too numerous and erroneous to be useful

All of the services we tested are fast, and they extract potentially useful terms far quicker than a human manually scanning items. As such, they can greatly speed the process of cataloging materials such as oral histories, letters, articles, blogs, and theses. While the services we tested miss important entities and return spurious ones, they also quickly provide a list that a human operator can scan for purposes of selecting a few relevant tags. As such, the method drastically speeds up subject analysis and allows libraries to provide more complete metadata than they would otherwise be able to.

Output from cloud-based services can be combined using automated and manual means with information with other sources such as indices and authority lists to provide much richer linkages across a wide range of archival materials. Our process can logically be extended to associate unique identifiers such as DOI’s, ORCID ID’s, and create appropriate semantic linkages with entities occurring in a wide array of document types.

## References

AlchemyAPI \[Internet\]. \[cited 2015 Apr 7\]. Available from [http://www.alchemyapi.com](http://www.alchemyapi.com/)

Aylien \[Internet\]. \[cited 2015 Apr 7\]. Available from [http://aylien.com](http://aylien.com/)

dataTXT. \[Internet\]. \[cited 2015 Apr 7\]. Available from [https://dandelion.eu/products/datatxt](https://dandelion.eu/products/datatxt)

Howmanyofme.com. \[Internet\] \[cited 2015 Jun 8\]. Available from [http://howmanyofme.com](http://howmanyofme.com/)

MeaningCloud’s Topics Extraction API. \[Internet\]. \[cited 2015 Apr 7\]. Available from [http://www.meaningcloud.com/products/topics-extraction](http://www.meaningcloud.com/products/topics-extraction)

OpenCalais. \[Internet\]. \[cited 2015 Apr 7\]. Available from [http://www.opencalais.com](http://www.opencalais.com/)

Semantria. \[Internet\]. \[cited 2015 Apr 7\]. Available from [https://semantria.com](https://semantria.com/)

TextRazor. \[Internet\]. \[cited 2015 Apr 7\]. Available from [https://www.textrazor.com](https://www.textrazor.com/)

Zemanta. \[Internet\]. \[cited 2015 Apr 7\]. Available from [http://www.zemanta.com](http://www.zemanta.com/)

Kyle Banerjee ([banerjek@ohsu.edu](https://journal.code4lib.org/articles/)) is the Digital Collections and Metadata Librarian at Oregon Health & Science University.

Max Johnson ([johnsmax@ohsu.edu](https://journal.code4lib.org/articles/)) is the University Archivist at Oregon Health & Science University.
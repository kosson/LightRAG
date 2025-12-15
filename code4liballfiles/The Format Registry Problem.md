---
title: "The Format Registry Problem"
source: "https://journal.code4lib.org/articles/8029"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-01-15
created: 2025-01-10
description: "File format identification is an important issue in digital preservation. Several noteworthy attempts, including PRONOM, GDFR, and UDFR, have been made at creating a comprehensive repository of format information. The sheer amount of information to cover and the constant introduction of new formats and format versions has limited their success. Alternative approaches, such as Linked [...]"
tags:
  - "clippings"
---
# The Format Registry Problem
Gary McGath

File format identification is an important issue in digital preservation. Several noteworthy attempts, including PRONOM, GDFR, and UDFR, have been made at creating a comprehensive repository of format information. The sheer amount of information to cover and the constant introduction of new formats and format versions has limited their success. Alternative approaches, such as Linked Data and offering limited per-format information with identifiers that can be used elsewhere, may lead to greater success.

## Introduction

Digital documents come in thousands of formats, with tens of thousands of subvarieties. This makes the life of the digital preservationist difficult. Is a valid file one which can easily be opened and will stay that way in the reasonable future, or are special measures needed to ensure its readability? Exactly what software is needed to open it?

Just knowing the format’s generic name isn’t enough. If you have a “Microsoft Word” file, that doesn’t tell you whether it’s a version from the early eighties, a recent document in Microsoft’s proprietary format, or an Office Open XML document. The three have practically nothing in common but the name.

## Before Format Registries

In the earliest days of computers, each system had its own formats; you couldn’t even copy character codes from one computer to another. As they became more widespread and people started thinking of them as document processing systems rather than just huge calculators, formats started to become an issue. The computer magazines of the seventies were full of ads by startups offering software for all kinds of exciting purposes. These startups might not still be around the next month. Every application had its own document format, so preserving your work when you upgraded your S-100 machine meant making a printed copy.

As the number of incompatible operating systems declined, long-term retention of files became a possibility. This made it important to recognize a file’s format. The Unix file command relied (and still does) on a “magic number” approach to file identification, with the value of characteristic bytes indicating what format a file most likely is. Its database isn’t human-readable, but it could be considered one of the first attempts at a comprehensive format repository.

Libraries and archives have been particularly aware of the need to keep information about formats after the software which creates them goes out of use. An paper on the subject, “Risk Management of Digital Information: A File Format Investigation,”\[[1](https://journal.code4lib.org/articles/#note1)\] raised the issue in 2000:

> The most difficult aspect of this project was the acquisition of complete and reliable file format specifications. Throughout the project, format-specific information was difficult to acquire from a single source.

The authors go on to suggest:

> If we measured the risk associated with public domain archives on the Internet, we would assess all these sites as high-risk operations. Sites such as Wotsit’s represent the public service efforts of individuals. They lack any vision or plan to sustain the information. This limitation, combined with the unreliable nature of the information contained within these sites, make it unlikely that these sites will contribute meaningfully to digital preservation efforts. There is a pressing need to establish reliable, sustained repositories of file format specifications, documentation, and related software. We recommend the establishment of such depositories for format-specific materials related to migration as a preservation strategy.

The quest for format identification has led to a two-pronged strategy, with format registries and format identification software. The efforts to create software that recognizes a file’s format have produced some useful software, such as Unix’s file, the UK National Archives’ DROID, JHOVE and FITS from Harvard, JHOVE2 from the California Digital Library and others, ffident from a group of open source developers, and so on. These restrict the domain of the problem they address in one way or another. JHOVE looks at a small number of formats in considerable detail. DROID and file can identify a broad range of formats but look only at their characteristic patterns or “signatures.”

To be useful, registries need to provide a significant amount of information about many different formats, and this has proven to be a difficult task.

## PRONOM

The first large-scale attempt, and still the most successful, at “the establishment of such repositories” was PRONOM ([http://www.nationalarchives.gov.uk/PRONOM/](http://www.nationalarchives.gov.uk/PRONOM/ "http://www.nationalarchives.gov.uk/PRONOM/")), from the UK National Archives. Part of the above quotation appeared at the start of Jeffrey Darlington’s 2003 article explaining the project.\[[2](https://journal.code4lib.org/articles/#note2)\] By its own description, “PRONOM is an on-line information system about data file formats and their supporting software products. Originally developed to support the accession and long-term preservation of electronic records held by the National Archives, PRONOM is now being made available as a resource for anyone requiring access to this type of information.” DROID relies on the PRONOM database.

PRONOM has lots of useful information. If you search for the extension “tif”, you get Tagged Image File Format, as you’d expect, as well as nine specialized formats that are built on the TIFF standard. Click on “Tagged Image File Format” and you get several tabs worth of information.

[![](https://journal.code4lib.org/media/issue19/mcgath/mcgath_figure1_small.png "PRONOM Entry for Tagged Image File Format")](https://journal.code4lib.org/media/issue19/mcgath/mcgath_figure1.png)

**Figure 1.** PRONOM Entry for Tagged Image File Format.

Look deeper, though, and you’ll find the information is spotty. You can look up software by company; enter “Adobe” and you’ll get seven pages of information. However, the most recent version of Acrobat listed is 5.0, which dates from 2001. You can look for migration paths for “Tagged Image File Format” (you won’t find any if you look for “TIFF”). You get a few options for converting TIFF to PNG, leaving a vast number of possibilities unmentioned.

The task of keeping track of the ongoing development of file formats is a huge one, and it isn’t surprising that even a large organization such as the National Archives has trouble keeping up.

## GDFR

Since maintaining format information is such a huge task, an obvious remedy is to get multiple institutions in on the job. This led to the proposal for the Global Digital Format Registry ([http://www.gdfr.info/](http://www.gdfr.info/ "http://www.gdfr.info/")), intended as a “distributed and replicated registry of format information populated and vetted by experts and enthusiasts world-wide.”\[[3](https://journal.code4lib.org/articles/#note3)\] The Harvard University Library (HUL) received a grant from the Andrew W. Mellon Foundation for a two year project leading to the deployment of GDFR. The development work was done in conjunction with OCLC.

Work began with meetings sponsored by the DLF in 2003, which established an ad hoc group to work on a plan. In 2005 Stephen Abrams and Dale Flecker of HUL published a paper formally proposing GDFR.\[[4](https://journal.code4lib.org/articles/#note4)\]

> The most significant architectural aspect of the GDFR is its distributed nature. The aim of the project is not to build a single centralized registry, but rather to define a common network protocol by which multiple independent, but cooperating, registries can communicate with each other and synchronize their holdings of format representation information.

The design was complex in both its data model and its networking features, and the XML database was unwieldy to work with. Developers at Harvard and OCLC collaborated on the project, but personnel and communication issues led to problems. The project ended in 2008 or so without producing either usable software or a practical repository.

## UDFR

The failure of GDFR was followed by an effort to pick up the pieces and put together the best features of GDFR and PRONOM. This project was called the Unified Digital Format Registry (UDFR, [http://udfr.org/](http://udfr.org/ "http://udfr.org/")). The California Digital Library took the lead, with funding from the Library of Congress. The distributed architecture was dropped, but open contribution would be encouraged, with minimal barriers to participation.

The project had ongoing problems, as described in the UDFR Final Report.\[[5](https://journal.code4lib.org/articles/#note5)\] The schedule was extremely tight and there were project management issues. Nonetheless, it reached completion and there is a working site. The problem is that it’s a dead one as far as building information is concerned. The final report says that “the initial level of community involvement was quite high,” but this wasn’t sustained after the final deployment of the software. There was a general sense of exhaustion at the end, leaving no one to rally the community to continue updating it.

## Wikipedia?

If the problem is too big for any institution, what about the world’s best-known source of crowd-sourced information, Wikipedia? It has many articles on file formats. Much of the information there is in a semi-structured form, in “Infoboxes.” For example, look at the page on “JPEG” and you’ll find a box with items labelled “Filename extension,” “Internet media type,” “Type Code,” “Uniform Type Identifier,” “Magic number,” “Developed by,” “Type of format,” and “Standard(s).” And, of course, a picture of a cat.

Better yet, the information in these boxes is available for machine queries, using the Linked Data approach. The DBPedia project ([http://dbpedia.org/](http://dbpedia.org/ "http://dbpedia.org/")) makes the information from Wikipedia Infoboxes as RDF data accessible with the SPARQL query language.

The downside is that Wikipedia is directed at the general reader and mostly lacks the detailed technical information that’s needed for preservation efforts. It often has links to that kind of information, though, including specifications.

## “Just Solve the Problem”

As I’m writing this in November 2012, another kind of crowdsourcing effort is underway. The “Just solve the problem” project ([http://justsolve.archiveteam.org/wiki/](http://justsolve.archiveteam.org/wiki/ "http://justsolve.archiveteam.org/wiki/")) is bringing together the efforts of many contributors to gather format information. According to its Statement of Project:

> Over 30 days (and left to run afterwards), this Wiki will provide a central source for information on all manner of file formats, self-encapsulated information sets that suffer (over time) from falling into obscurity, losing documentation, and otherwise fading while still containing many works out in the world that might need recovery. By providing an institution-neutral, public-domain, easy to navigate site containing this information, the “problem” can be addressed both by users of the Wiki and the many, many related attempts to achieve this goal, all of which can pull this wiki’s information back under their roof.\[[6](https://journal.code4lib.org/articles/#note6)\]

The project has already put together a huge amount of information. It’s heavy on contributions relative to oversight, so the quality, completeness, and reliability vary, but in sheer breadth of information it could be a valuable resource. All contributions are declared public domain under a Creative Commons CC0 license, so they can be copied and reworked freely.

## Unification by Linked Data

DBPedia isn’t the only source of format information organized as RDF and delivered through SPARQL. UDFR and PRONOM have endpoints. This raises an interesting possibility. The idea of Linked Data is to unify diverse data sources on a machine-processable level, just as the World Wide Web does on a human-readable level. Could a single reader query multiple endpoints and provide useful aggregated information?

A proposal by Bill Roberts for the Open Planets Foundation suggests steps in this direction. It stresses the need for “a distributed approach that allows collaboration between different organisations”\[[7](https://journal.code4lib.org/articles/#note7)\] and suggests Linked Data as a component of this approach.

To try the experiment, I created a Java application that would use the Jena open source libraries to query different sources of Linked Data on formats. The sources used were DBPedia, PRONOM, and UDFR. The project is available on Github ([https://github.com/gmcgath/format-reg-browser](https://github.com/gmcgath/format-reg-browser "https://github.com/gmcgath/format-reg-browser")).

A quick review of the RDF essentials may be appropriate here. RDF data is stored in “triples,” which consists of a subject, a predicate, and an object. A subject is something: a concept, an object, a collection, etc. The predicate identifies some relationship that the subject could have to something else. The object identifies a “something else” for which the relationship holds. For instance, (“United States,” “Has state,” “New Hampshire”) could be an RDF triple identifying a geographical fact.

Predicates are the glue of RDF. For a particular information set, the set of predicates has to be known and restricted, so that the user knows what queries are possible. This is done by assigning specific names to predicates and grouping them in a namespace associated with a URI. In the triples, a prefix is associated with the URI to avoid being verbose. For example, UDFR has a predicate namespace associated with the URI . In a particular application, any prefix can stand for it, but well-known namespaces have commonly used prefixes, in this case “udfrs.”

The value of the subject of a triple is generally a URI identifying a resource. The object can be a data value like a string, or it can be a URI which identifies another resource, possibly at a different site. This is where the “linked” aspect of Linked Data comes from.

An RDF data set can have predicates from one or more namespaces. The aggregate of these is its “ontology.” There is no common ontology for file format information. UDFR and PRONOM each have their own. DBPedia has a number of specialized ontologies for particular topics, but so far none for file formats; it does have a certain amount of informal agreement. This meant that my experimental application had to create different queries for each registry.

The UDFR ontology is complex and often requires two-level queries. Fortunately, Richard May had already done some work in the area\[[8](https://journal.code4lib.org/articles/#note8)\], which was valuable in devising my own queries. DBPedia’s is relatively flat, not as rich but easier for a novice SPARQL coder to work with. Each has types of information that don’t have exact information in the other. DBPedia has “extension” for many formats; UDFR has “external signature,” which may or may not be the same thing. I assumed in my code that it is.

The application puts up a form that lets the user fill in some fields. These match as case-independent substrings of field values.

[![](https://journal.code4lib.org/media/issue19/mcgath/mcgath_figure2.png "Registry Browser Input Form")](https://journal.code4lib.org/media/issue19/mcgath/mcgath_figure2.png)

**Figure 2.** Registry Browser Input Form.

A search is done on the registries selected by the configuration file, and the results are grouped in a single window.

[![](https://journal.code4lib.org/media/issue19/mcgath/mcgath_figure3.png "Sample Results of a Registry Search")](https://journal.code4lib.org/media/issue19/mcgath/mcgath_figure3.png)

**Figure 3.** Sample Results of a Registry Search.

The application could easily be expanded in its search fields and the information it returns. Finding queries that are equivalent between repositories is more difficult, as is comparing the results. UDFR has a lot of different entries with the name “Tagged Image File Format,” which are differentiated by other fields. DBPedia has much less granularity in its information.

Could a tool of this type, sufficiently expanded, be a serious help in spanning multiple format registries? That isn’t clear as yet. The inconsistencies in DBPedia make it difficult to search and extract high-quality information. A deep understanding of UDFR’s complex ontology would be helpful in finding equivalents to other repositories.

## Conclusions

The format registry problem is an ongoing one. New formats develop and old ones change both officially and unofficially. No institution has been capable of amassing a complete registry of format information.

Linked Data may provide a way to integrate multiple sources of format information. Its potential is currently limited by the lack of a generally accepted ontology. If an institution with sufficient visibility devises an ontology which is simple enough, or has a simple enough subset, to be widely adopted, it could make these efforts more practical.

Andy Jackson has suggested a minimalist solution: “\[M\]y current thinking on the data model is that the format registry design should only be concerned with minting identifiers for formats, and collecting the minimal representation information require to support this. I think that if we can get this right, then we can use those identifiers to describe the other entities, like software tools and digital object characteristics, but without forcing them all into the same system.”\[[9](https://journal.code4lib.org/articles/#note9)\] In this view there could still be a central registry, but its role would be something like Bowker’s in issuing ISBNs.

No one is going to “just solve the problem” once and for all. Ongoing efforts by many different people working independently will be necessary to keep up with the growing variety of formats.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Gregory W. Lawrence, William R. Kehoe, Oya Y. Rieger, William H. Walters, Anne R. Kenney: “Risk Management of Digital Information: A File Format Investigation,” Council on Library and Information Resources, Washington, DC, June 2000. [http://www.clir.org/pubs/abstract//reports/pub93](http://www.clir.org/pubs/abstract//reports/pub93 "http://www.clir.org/pubs/abstract//reports/pub93")

\[[2](https://journal.code4lib.org/articles/#ref2)\] Jeffrey Darlington, “PRONOM—A Practical Online Compendium of File Formats,” RLG DigiNews, Volume 7, No. 5, October 15, 2003.

\[[3](https://journal.code4lib.org/articles/#ref3)\] “Global Digital Format Registry (GDFR) Information Site.” Available at [http://www.gdfr.info/](http://www.gdfr.info/ "http://www.gdfr.info/").

\[[4](https://journal.code4lib.org/articles/#ref4)\] Stephen Abrams, Dale Flecker, “A Proposal for a Global Digital Format Repository,” Harvard University Library, September 29, 2005.

\[[5](https://journal.code4lib.org/articles/#ref5)\] “Unified Digital Format Registry (UDFR) Final Report,” UC Curation Center, California Digital Library, July 2, 2012.

\[[6](https://journal.code4lib.org/articles/#ref6)\] Jason Scott, “Statement of Project,” Solve the File Format Problem, October 28, 2012. ([http://fileformats.archiveteam.org/wiki/Statement\_of\_Project](http://fileformats.archiveteam.org/wiki/Statement_of_Project "http://fileformats.archiveteam.org/wiki/Statement_of_Project"))

\[[7](https://journal.code4lib.org/articles/#ref7)\] Bill Roberts, “A New Registry for Digital Preservation,” Open Planets Foundation, September 2010. ([http://www.openplanetsfoundation.org/node/596](http://www.openplanetsfoundation.org/node/596 "http://www.openplanetsfoundation.org/node/596"))

\[[8](https://journal.code4lib.org/articles/#ref8)\] Richard May, “File Identification using Fido and the UDFR Registry,” Open Planets Foundation blog, September 10, 2012. ([http://www.openplanetsfoundation.org/blogs/2012-09-10-file-identification-using-fido-and-udfr-registry](http://www.openplanetsfoundation.org/blogs/2012-09-10-file-identification-using-fido-and-udfr-registry "http://www.openplanetsfoundation.org/blogs/2012-09-10-file-identification-using-fido-and-udfr-registry"))

\[[9](https://journal.code4lib.org/articles/#ref9)\] Andy Jackson, “Breaking Down the Format Registry,” Open Planets Foundation blog, December 8, 2012. ([http://www.openplanetsfoundation.org/blogs/2010-12-08-breaking-down-format-registry](http://www.openplanetsfoundation.org/blogs/2010-12-08-breaking-down-format-registry "http://www.openplanetsfoundation.org/blogs/2010-12-08-breaking-down-format-registry"))

Gary McGath \[Email: developer@mcgath.com\] is an independent professional software developer. Previously he was a Digital Library Software Engineer with the Harvard Library.
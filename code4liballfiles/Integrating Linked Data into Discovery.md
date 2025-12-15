---
title: "Integrating Linked Data into Discovery"
source: "https://journal.code4lib.org/articles/8526"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-07-18
created: 2025-01-10
description: "Although the Linked Data paradigm has evolved from a research idea to a practical approach for publishing structured data on the web, the performance gap between currently available RDF data stores and the somewhat older search technologies could not be closed. The combination of Linked Data with a search engine can help to improve ad-hoc [...]"
tags:
  - "clippings"
---
# Integrating Linked Data into Discovery
Götz Hatop

Although the Linked Data paradigm has evolved from a research idea to a practical approach for publishing structured data on the web, the performance gap between currently available RDF data stores and the somewhat older search technologies could not be closed. The combination of Linked Data with a search engine can help to improve ad-hoc retrieval. This article presents and documents the process of building a search index for the Solr search engine from bibliographic records published as linked open data.

## Introduction

Many bibliographic datasets are already published as Linked Data and it is now crucial to see how this data can fit into existing information management workflows.  The exercise is useful not only to see how novel improvements from Semantic Web development can influence data management in libraries, but also because library data is highly structured and may as well serve as an example to demonstrate the benefits of Semantic Web technologies and thus can help to bootstrap the Semantic Web.

In the library community, the VuFind Discovery System, published by Villanova \[[1](https://journal.code4lib.org/articles/#foot_note_1 "ref_note_1")\] is known to be a flexible open source resource discovery system. The software has developed an active user community, with a number of libraries currently utilizing it as their discovery platform. VuFind itself is built on top of the Solr search software, which is developed and distributed by the Apache Lucene project.

Building a search index for the VuFind Solr search engine from a corpus of Linked Data is an interesting task which can be accomplished through the use of a number of open source software components in conjunction with the development of some programs to embed the required functionality.  The result is a flexible system that works with the definition of SPARQL queries and a XSLT transformation to finally perform the indexing. This way, only standardized techniques from the Semantic Web stack are required to index a Linked Data source. The programs used to achieve the indexing are published Open Source and may be of interest to the Semantic Library community \[[2](https://journal.code4lib.org/articles/#foot_note_2 "ref_note_2")\].

## Libraries and Linked Data

Linked Data represents a major opportunity for libraries to integrate their information resources within the Semantic Web.  In addition, the Semantic Web stack itself provides a robust and highly standardized framework offering libraries the ability to provide better data management and data re-use. Another area where Linked Data may play an important role for libraries is the field of semantic publishing, the enrichment of scientific articles with machine readable RDF statements as described by Peroni and Shotton \[[3](https://journal.code4lib.org/articles/#foot_note_3 "ref_note_3")\].

Tim Berners-Lee first outlined the basic idea of linked data in 2006. In his seminal design note \[[4](https://journal.code4lib.org/articles/#foot_note_4 "ref_note_4")\] he described four principles to be followed for linked data:

- All items should be identified using URIs.
- All URIs should be dereferenceable, that is, using HTTP, URIs enable anyone (machine or human) to look up an item identified through the URI.
- Looking up a URI leads to more data, also known as the follow-your-nose principle.
- Links to URIs in other data sets should be included to enable further data discovery.

A more detailed analysis about how bibliographic data can be published as linked data is described in Bizer, et al’s., *How to publish Linked Data on the Web* \[[5](https://journal.code4lib.org/articles/#foot_note_5 "ref_note_5")\].

Linked Data published on the Web are usually represented using the Resource Description Framework (RDF). The framework provides a simple data model, but is a key component tailored towards information exchange within the Semantic Web. According to the W3C, “RDF provides interoperability between applications that exchange machine-understandable information on the Web”. Even if the Semantic Web as a whole may still be years away from reaching its goal of being society’s chief information platform, the RDF framework has already reached much attention and provides useful and accepted standards for data and information management.

At the time of this writing, the Data Hub \[[6](https://journal.code4lib.org/articles/#foot_note_6 "ref_note_6")\] contains more than 300 datasets published as Linked Open Data by many different organizations. Included in this set are more than 50 datasets obtained from libraries, most of them with an open data license and formatted according to the RDF framework.

However, although publishing RDF datasets as a dump file with an open data license is important, it is only one more step towards the vision of the “Web of Data”, which is just another name for the Semantic Web. With SPARQL, the W3C has introduced a RDF query language that supports querying of multiple RDF graphs. SPARQL is not only a query language for RDF, the standard specifies the execution of distributed queries over different SPARQL endpoints. SPARQL can therefore be called a federated query language. Also, the protocol defines how to send a query and the results of a query across the web. In this way, SPARQL makes it possible to publish RDF data through standard interfaces.  Some libraries and journal publishers already provide their metadata via SPARQL endpoints. However, the operation of a SPARQL service endpoint is not an easy task, and the number of public SPARQL endpoints is growing only moderately according to the statistics made available by Vandenbussche \[[7](https://journal.code4lib.org/articles/#foot_note_7 "ref_note_7")\].

In terms of the fast evolving technologies in the web age, the Semantic Web can already be called an old stack. For example, RDF was originally recommended by the W3C on the February 22, 1999. Greenberg \[[8](https://journal.code4lib.org/articles/#foot_note_8 "ref_note_8")\] points out many similarities between libraries and the Semantic Web: Both have been invented as a response to information abundance, their mission is grounded in service and information access, and libraries and the Semantic Web both benefit from national and international standards. Nevertheless, the technologies defined within the Semantic Web stack are not well established in libraries today, and the Semantic Web community is not fully aware of the skills, talent, and knowledge that catalogers have and which may be of help to advance the Semantic Web.

On the other hand, the Apache Solr \[[9](https://journal.code4lib.org/articles/#foot_note_9 "ref_note_9")\] search system has taken the library world by storm. From Hathi Trust to small collections, Solr has become the search engine of choice for libraries. It is therefore not surprising, that the VuFind discovery system uses Solr for its purpose, and is not built upon a RDF triple store. Fortunately, the software does not make strong assumptions about the underlying index structure and can coexist with non-MARC data as soon as these data are indexed conforming to the scheme provided by VuFind.

## Implementation Strategies

In general, web crawling of Linked Data can be a complex task, since RDF data may be distributed among several data access points administered by different organizations. That may require fail-over mechanisms as well as some kind of agreement if data providers have established a fair use policy.

Bibliographic datasets are often available as linked open data in the form of a RDF data dump file. In the library world, authority data and title records are often separated into distinct chunks of data. For the purpose of index building, all data relevant must be gathered together so that a Solr index record can be built.

Building a Solr index out of RDF data can be done in different ways:

- RDF data have a XML serialization and therefore can be transformed to a Solr document as needed by the index engine.
- Some triple stores use a full-text index internally. Since most of these indexes are based on Lucene, it is possible to use this index from the outside of the systems.
- The RDF data can be loaded into a triple store and then the programming API from the triple store can be used to access the data. This way makes it possible to also index some inferenced results.

While the first option is simple and straightforward, its main drawback is that only relative small datasets can be tackled. The resulting filesystem operations over large datasets become difficult to handle and harder to scale. The second option requires some investigation of the underlying software architecture and is bound to a specific triple store. Only the last option allows the use of standard APIs and has chances to scale up to large datasets and remain free of dependencies.  As a result, the third approach was chosen and a prototypical implementation in Java with the Jena framework \[[10](https://journal.code4lib.org/articles/#foot_note_10 "ref_note_10")\] developed.

After loading all data required for indexing into a Jena triple store, three steps can be identified for building a Solr search index. The software written in the context of this article supports these three steps:

- **record enumeration:** all resources that should be indexed need to be identified in this step.
- **resource dump:** a query that shows what the underlying triple store knows about a resource.
- **result transformation:** the mapping and filtering of the results such that data can be loaded into the index engine.

Whereas steps 1 and 2 work with SPARQL, the last step works with XSLT. The main advantage of this is that the definition of an indexing procedure depends only on well-defined Semantic Web technologies.

## Record Enumeration

The formulation of a SPARQL query to enumerate all resources that should be indexed is crucial to the success of the overall operation.

The following SPARQL query enumerates the complete data store and was used during the development of the index routines.

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
# general resource enumeration : every subject, but no blank nodes
select distinct ?subject
where {
   ?subject  ?p ?o .
   FILTER (!isBlank(?subject)) .
}
ORDER BY DESC(?subject)
```

The query will deliver all subjects available from a SPARQL service, but without blank nodes. However, in practice it is often necessary and easily possible to restrict the record enumeration by using date properties or some other known statements about the resources in question.

## Resource Dump

Data modeling with RDF is based on statements with subject, predicate and object. Therefore, the original document-orientated structure of the bibliographic data is destroyed. In this phase of indexing, all information available about a resource is queried from the store.

A common solution to the problem of querying a graph for all relevant information is described in the literature \[[11](https://journal.code4lib.org/articles/#foot_note_11 "ref_note_11")\] as “symmetric consise bounded description”, which informally is the extraction of a sub-graph with all nodes associated with the resource.

The SPARQL standard uses the DESCRIBE keyword for this purpose. Some, but not all triple stores currently used in practice do implement the SPARQL DESCRIBE part of the specification, but the implementation is often limited to simple consise bounded descriptions, that is in effect a description without those nodes, where the resource is the object.

To the best of our knowledge, symmetric consise bounded descriptions are not built into triple stores right now and have to be formulated as SPARQL construct-queries. Since the SPARQL query language does not support recursion, the required query can not be given in general, but depends on the specific data model. Typically, author information and partOf-relationships need to be considered here. A typical query may look like the one shown below.

```
PREFIX  dct: <http://purl.org/dc/terms/>
PREFIX  dcmitype: <http://purl.org/dc/dcmitype/>
PREFIX  dcq: <http://purl.org/dc/qualifier/1.0/>
PREFIX  gnd: <http://d-nb.info/gnd/>
PREFIX  foaf: <http://xmlns.com/foaf/0.1/>
PREFIX  fabio: <http://purl.org/spar/fabio/>
PREFIX  urn: <http://www.d-nb.de/standards/urn/>
PREFIX  shg: <http://localhost/view/>

## resource dump.
construct {
     ?p ?o <subject> .
    ?o ?x ?y .
} where {
     ?p ?o .
    optional {
       ?o ?x ?y
       FILTER (isBlank(?o) && !isBlank(?y))
    }
    optional {
        dct:isPartOf ?o .
       ?o ?x ?y .
    }
    optional {
        dct:creator ?o .
       ?o ?x ?y .
    }
}
```

In the query shown, the <subject> parameter is resolved step by step by the record enumeration of the previous step. The query is intended to filter out blank nodes and to fetch information that is hidden behind URI nodes like the author name and the information about records related by a partOf-Relationship.

The SPARQL standard is prepared for federated queries, and the Jena framework does implement the SERVICE keyword to support this behavior. Accordingly, this phase of the indexing process is the place, where the separation of authority and title data into distinct data sets can be treated.  The approach taken here, to first load all required data into a triple store, makes the overall setup relative simple.  However, an approach using federated SPARQL queries for resource dump could take the distributed nature of Linked Data into account. Buil-Aranda et.al. \[[12](https://journal.code4lib.org/articles/#foot_note_12 "ref_note_12")\]  formalize such a setup, and also provide some background information on the problem of federated query evaluation.

## Result Transformation

Since SPARQL query results can be returned in a standardized XML format, the process of transforming the result to the Solr index format used by VuFind can be done with a XSLT transformation. An example of a XSLT stylesheet to transform the RDF/XML response format to the Solr index scheme in question is contained within the sources of this project \[2\].

Data written in RDF may be considered to be on a higher level of abstraction than those in XML. For that reason, the translation from XML to RDF is often called lifting, while the opposite direction is called lowering. Apart from its syntactic ambiguities, processing RDF/XML via XSLT loses another feature of RDF, namely its interplay with ontological information. The “lowering” of the RDF/XML data in our use case is the mapping to the Solr index scheme used by VuFind.

This final processing step provides all the flexibility that is available with XSLT and benefits from the standardized XML formats that come with RDF. XSLT can be problematic with respect to performance, and input size is a determining factor. The processing described here deals largely with only small data blocks, but every record has to be transformed from its RDF/XML representation to the XML variant required by Solr before it can be loaded to the index. Although detailed performance studies have not been undertaken in this project, some very simple tests gave hints that performance is more likely to be determined by the Solr engine rather than XSLT, at least as long as the standard HTTP based Solr update processing is used.

## Proof of Concepts

To test the concepts in a more general setting, two datasets published by the DNB in 2012 were indexed. The datasets are published as two big sets of RDF data, known as GND (German Norm Data) and DNB (Deutsche Nationalbibliographie). Both data sets could be loaded into a Jena triple store and indexed with the developed programs within three weeks on a standard desktop PC. The problems found in the datasets tested are most often due to the existence of space characters in URIs, which is not allowed by specification. The long running indexing process could handle these problems through the use of careful Java exception handling and ignoring invalid records. The Jena framework was found to be flexible and easy to work with, and the adjustments could be made without the need to study the Jena code in greater detail.

In a somewhat simpler environment the developed indexing program is in production use since some month. Metadata from an institutional repository and from journals hosted with the Open Journal System are collected via their OAI interfaces, lifted to RDF and stored in a Jena TDB triple store. The indexing of about 5400 bibliographic records from the RDF data store to the Solr index engine can be done within a few minutes, and different mappings from rdf to the index scheme used by VuFind are tested out easily.

## Conclusion

The predicated nature of the Resource Description Framework has emerged as a widespread formalism for information and data exchange. This report describes a method of building a search index from Linked Data sources and shows that the combination of Semantic Web technologies and already established search technology is possible without profound changes to existing systems.

The approach taken here to solve the problem of indexing Linked Data works with a simplified setup by providing a single point of data access. Areas for future investigation include optimising data processing by adjusting the indexing algorithms to better utilize the federated nature of the underlying SPARQL services.

## References

\[[1](https://journal.code4lib.org/articles/#ref_note_1 "foot_note_1")\] Villanova University: VuFind. [http://vufind.org](http://vufind.org/) (2012-04-22).

\[[2](https://journal.code4lib.org/articles/#ref_note_2 "foot_note_2")\] Hatop, G.: The Shanghai Linked Data Indexer. 2013.  
[https://github.com/Cloud8/Shanghai](https://github.com/Cloud8/Shanghai) (2013-05-04).

\[[3](https://journal.code4lib.org/articles/#ref_note_3 "foot_note_3")\] Silvio Peroni and David Shotton: FaBiO and CiTO: Ontologies for describing bibliographic resources and citations. 2012-08-13. Web Semantics: Science, Services and Agents on the World Wide Web.

\[[4](https://journal.code4lib.org/articles/#ref_note_4 "foot_note_4")\] Berners-Lee, T.: Linked Data – Design Issues. 2006-07-27.  
[http://www.w3.org/DesignIssues/LinkedData.html](http://www.w3.org/DesignIssues/LinkedData.html) (2012-11-22).

\[[5](https://journal.code4lib.org/articles/#ref_note_5 "foot_note_5")\] Bizer, C., Cyganiak, R., Heath, T.: How to publish Linked Data on the Web. 2007.  
[http://www4.wiwiss.fu-berlin.de/bizer/pub/LinkedDataTutorial](http://www4.wiwiss.fu-berlin.de/bizer/pub/LinkedDataTutorial) (2012-12-01).

\[[6](https://journal.code4lib.org/articles/#ref_note_6 "foot_note_6")\] Open Knowledge Foundation: The Data Hub. 2013.  
[http://datahub.io/group/lld](http://datahub.io/group/lld) (2013-01-03).

\[[7](https://journal.code4lib.org/articles/#ref_note_7 "foot_note_7")\] Pierre-Yves Vandenbussche: Public SPARQL Endpoints Stats. 2013. [http://labs.mondeca.com/sparqlEndpointsStatus](http://labs.mondeca.com/sparqlEndpointsStatus) (2013-06-13)

\[[8](https://journal.code4lib.org/articles/#ref_note_8 "foot_note_8")\] Jane Greenberg: Advancing the Semantic Web via Library Functions. Chapter 11, Knitting the Semantic Web. Cataloging & Classification Quarterly 43(3-4). 2007.

\[[9](https://journal.code4lib.org/articles/#ref_note_9 "foot_note_9")\] Apache Software Foundation: Apache Solr. 2012.  
[http://lucene.apache.org/solr](http://lucene.apache.org/solr) (2012-08-30).

\[[10](https://journal.code4lib.org/articles/#ref_note_10 "foot_note_10")\] Apache Software Foundation: Apache Jena. 2012.  
[http://jena.Apache.org](http://jena.apache.org/) (2012-09-02).

\[[11](https://journal.code4lib.org/articles/#ref_note_11 "foot_note_11")\] Stickler, P.: CBD – Concise Bounded Description. 2005.  
[http://www.w3.org/Submission/CBD](http://www.w3.org/Submission/CBD) (2013-05-04).

\[[12](https://journal.code4lib.org/articles/#ref_note_12 "foot_note_12")\] C. Buil-Aranda et. al.: Federating queries in SPARQL 1.1: Syntax, semantics and evaluation. Web Semantics: Science, Services and Agents on the World Wide Web 18 (2013) 1–17

## About

Götz Hatop is an information scientist and works at the IT Department of the University Library of Marburg/Lahn.  He is interested in semantic web technologies and information architecture.
---
title: "Indexing Linked Bibliographic Data with JSON-LD, BibJSON and Elasticsearch"
source: "https://journal.code4lib.org/articles/7949"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-01-15
created: 2025-01-10
description: "Linked Data is a powerful tool for sharing bibliographic metadata. By combining the decentralization of the web with the use of globally defined metadata vocabularies, data from many sources can be treated as a single, aggregated graph. Supporting search across these distributed data sources within the same application, however, requires considerable work in vocabulary alignment [...]"
tags:
  - "clippings"
---
# Indexing Linked Bibliographic Data with JSON-LD, BibJSON and Elasticsearch
Thomas Johnson

Linked Data is a powerful tool for sharing bibliographic metadata. By combining the decentralization of the web with the use of globally defined metadata vocabularies, data from many sources can be treated as a single, aggregated graph. Supporting search across these distributed data sources within the same application, however, requires considerable work in vocabulary alignment and data transformation. Aggregate systems must convert data into a unified model which must (almost inevitably) be generic at the expense of the structure and granularity of the original data. This paper presents a novel solution for representing and indexing bibliographic resources that retains the data integrity and extensibility of Linked Data while supporting fast, customizable indexes in an application-friendly data format. The methodology makes use of JSON-LD to represent RDF graphs in JSON suitable for indexing with Elasticsearch. BibJSON is used as a common index format capable of handling a wide range of library resources. Since all three technologies (RDF/JSON-LD, BibJSON and Elasticsearch) share an emphasis on extensibility, it is possible to create an index of bibliographic data that is both generalized and flexible enough to handle Linked Data from multiple sources.

## Introduction

Linked Data is a powerful tool for “sharable, extensible, and easily re-usable” bibliographic metadata ([Baker, 2012](https://journal.code4lib.org/articles/#cite-Baker)). By combining the decentralization of the web with the use of globally defined metadata vocabularies, data from many sources can be treated as a single, aggregated graph. Working with this chaotic mass of data, however, can be daunting. Each major dump of bibliographic data comes with its own quirks in terms of vocabulary choice, scope, and data model.

Combining multiple heterogeneous data sources for use in the same application typically requires considerable work on data transformation. Even within the context of a single domain, there is little realistic possibility for a universal schema. Aggregate systems must convert data into a unified model which must (almost inevitably) be generic at the expense of the structure and granularity of the original data. One place where this is a clear problem is in search. We want Linked Data search engines to expose data from across the web, but with a degree of integration that insulates users from the specifics of the models. How can we bring data from distributed sources together onto a single search platform?

This paper presents a novel solution for bibliographic resources which retains the data integrity and extensibility of Linked Data while supporting fast, customizable indexes in an application-friendly data format. The methodology makes use of JSON-LD to represent RDF graphs in JSON suitable for indexing with Elasticsearch. BibJSON serves as a common index format capable of handling a wide range of library resources. Since all three technologies (RDF/JSON-LD, BibJSON and Elasticsearch) share an emphasis on extensibility, it’s possible to create an index \[[1](https://journal.code4lib.org/articles/#note1)\] of bibliographic data that is both generalized and flexible enough to handle Linked Data from multiple sources.

The method demonstrated here was developed at Oregon State University as a part of an ongoing project to build search services atop an RDF dataset for our theses and dissertations. Additional information about this project can be found in [Johnson and Boock](https://journal.code4lib.org/articles/#cite-Johnson) (2012).

## JSON-LD

JSON-LD aims to express Linked Data in otherwise normal looking JSON documents. By design, it is “as simple as possible, very terse, and human readable” ([Lanthaler and Gütl, 2012](https://journal.code4lib.org/articles/#cite-Lanthaler)). Though there had been previous attempts to express Linked Data in JSON (see [RDF JSON](http://docs.api.talis.com/platform-api/output-types/rdf-json) and [JRON](http://decentralyze.com/2010/06/04/from-json-to-rdf-in-six-easy-steps-with-jron/)), this specification emphasizes application and developer friendly JSON ([Lanthaler and Gütl, 2012](https://journal.code4lib.org/articles/#cite-Lanthaler)). It forgoes the rigid, unnatural structures seen in past serializations in favor of compact representations and supplementary documents which hold the details of the graph.

While the specification is a work in progress, JSON-LD largely succeeds. It makes it possible to introduce Linked Data principles and vocabularies into existing JSON data without changing the data structure or application code. By the same stroke, the simple, readable structure of its JSON makes it easy to use existing RDF graphs with typical JSON programming practices and with systems like Elasticsearch.

### Contexts and Framing

Working with JSON-LD requires some understanding of Linked Data—especially the practice of using Internationalized Resource Identifiers (IRIs) to refer to terms and concepts—and several concepts used to apply its principles in JSON. Chiefly, *contexts* and *frames*.

A *context* is a mapping between JSON properties and equivalent IRIs. Contexts are themselves expressed as JSON objects, using the “@context” keyword, which express equivalencies between IRIs and more readable JSON keys. Given an applicable context, a JSON-LD document can be compacted into a simple, usable form or expanded from “normal” JSON to its full Linked Data representation.

For example, a context might specify:

`"name": "http://xmlns.com/foaf/0.1/name"`

An expanded document would use the longer foaf:name IRI in its key-value pairs, while a compacted one would simply use “name”. A context document consists of a number of statements of this form, designating the relationship between JSON keys and RDF nodes.

The concept behind *framing* is somewhat more complex. Frames complete the mapping from a particular RDF *graph* to a corresponding JSON *tree*. This is important, since most graphs can be represented as many distinct trees (e.g. by selecting a different node as the root). Specifying a single structure allows a one-to-one relationship between the source RDF and the JSON-LD representation. The resulting JSON tree is predictable enough for applications to rely on. A frame can be helpfully thought of as a template for a generated JSON document.

The simplest framing documents might contain a single line telling the algorithm to treat the data as a representation of a number of books (contrasted with a number of authors, containing lists of their books):

`"@type": "book"`

Further key-value pairs can tell the framing algorithm to expect other data to appear within the root object and specify embedding behavior to ensure that child nodes are described fully each time they appear \[[2](https://journal.code4lib.org/articles/#note2)\].

The most useful way to learn these concepts and their various quirks is to try them out. The [JSON-LD Playground](http://json-ld.org/playground) is an easy way to do this. The examples there are instructive; more importantly, it allows you to interactively construct your own JSON-LD and view it in various stages of compression and normalization.

## BibJSON

Though JSON-LD represents a flexible way to convert RDF to JSON without degradation, a general purpose bibliographic index will need to share a common JSON format. Our target format needs to be simple and extensible; it must be able to accommodate the needs of various record types and models, and capable of representing commonly indexed fields in a predictable way.

[BibJSON](http://www.bibjson.org/) comes close to being ideal for our purposes. At its core, it is little more than a set of conventions for using [BibTeX](http://www.bibtex.org/) fields as JSON keys, made extensible by supporting arbitrary additional keys as needed. Those fields cover the most important metadata fields associated with bibliographic records; indeed, BibJSON’s primary existing use case is the creation of a distributed and portable collection of bibliographic data ([Jones, 2011](https://journal.code4lib.org/articles/#cite-Jones)). Though it won’t work as a universal format—it is distinctly *record*\-centric and won’t fit complex entity-relationship models, as we’ll see later—it does surprisingly well. In particular, it offers clarity surrounding most important search fields and will extend to fit JSON-LD, so long as some bibligraphic entity is used as the root node.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `{`  `"title"``: ``"Indexing Linked Bibliographic Data with JSON-LD, BibJSON & Elasticsearch"``,`  `"author"``:[`  `{``"name"``: ``"Thomas Johnson"``}`  `],`  `"type"``: ``"article"``,`  `"year"``: ``"2013"``,`  `"journal"``: {``"name"``: ``"Code4Lib Journal"``},`  `"issue"``: ``"19"``,`  `"identifier"``: [`  `{``"type"``:``"doi"``,`  `"id"``:``"10.1000/182"``,`  `]`  `}` |
| --- | --- |

**Figure 1.** An example BibJSON record.

A basic BibJSON record for this article is given in Figure 1. As a rule, simple data points that can be represented with a string (e.g. *title*) are given as key-value pairs. For more complex fields, BibJSON allows representation as an object or list of objects. This convention is explicitly invoked for several common fields \[[3](https://journal.code4lib.org/articles/#note3)\] and can be used for others where needed.

## A Simple Example

For a minimal demonstration of the entire process, consider the RDF in Figure 2. This expresses, using common vocabulary, a graph similar in scope and structure to the BibJSON above.

**Figure 2.** example.ttl — An example bibliographic ‘record’ in RDF.

The combined context and framing document in Figure 3 will support the conversion of this data into a JSON document similar to the initial BibJSON in Figure 1. The constructions “‘type’: ‘@type'” and “‘id’: ‘@id'” create aliases for JSON-LD keywords which would otherwise appear in our final document, making them more human readable and closer to the default BibJSON terms. Where BibJSON calls for a “list of objects”, the context specifies *@set* as the container to ensure compliance. The second part of the document (following the *@context* object) is the frame. It can be read as declaring that the “article” is the root node, and that the other objects should be embedded in its tree. Figure 4 shows the BibJSON-like results; the Python code used to generate the JSON-LD, and an un-framed example of the same graph are included as an appendix.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40 | `{`  `"@context"``: {`  `"type"``: ``"@type"``,`  `"id"``: ``"@id"``,`  `"author"``: {`  `"@container"``: ``"@set"`  `},`  `"link"``: {`  `"@container"``: ``"@set"`  `},`  `"doi"``: {`  `"@container"``: ``"@set"`  `},`  `},`  `"@type"``: ``"article"``,`  `"author"``: {`  `"@type"``: ``"Person"``,`  `"@embed"``: ``"true"`  `} ,`  `"journal"``: {`  `"@type"``:``"Journal"``,`  `"@embed"``: ``"true"`  `},`  `"link"``: {`  `"@type"``:``"id"``,`  `"@embed"``: ``"true"`  `}`  `}` |
| --- | --- |

**Figure 3.** example\_frame.jsonld — Context and framing document.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34 | `{`  `"@context"``: {`  `...`  `},`  `"@graph"``: [`  `{`  `"title"``: ``"Indexing Linked Bibliographic Data with JSON-LD, BibJSON & Elasticsearch"``, `  `"author"``: [`  `{`  `"foaf:lastname"``: ``"Johnson"``, `  `"type"``: ``"Person"``, `  `"name"``: ``"Thomas Johnson"``, `  `}`  `], `  `"type"``: ``"article"``, `  `"journal"``: {`  `}, `  `"type"``: ``"Journal"``, `  `"name"``: ``"Code4Lib Journal"``, `  `"id"``: ``"urn:issn:19405758"`  `}, `  `"link"``: [`  `], `  `"year"``: ``"2013"``, `  `"issue"``: ``"19"``, `  `"doi"``: ``"10.1000/182"`  `}`  `]`  `}` |
| --- | --- |

**Figure 4.** example.json — Framed JSON-LD.

Comparing the output with the initial BibJSON example reveals a few interesting differences. Firstly, unexpected fields (foaf:lastname, rdfs:seeAlso, and various IRIs) are handled gracefully and without data loss. This will continue to work even if the unexpected nodes give rise to complex graph structures. Unexpected data can simply be ignored by any software using the index, while remaining available on an ad-hoc basis and subject to Elasticsearch’s default analysis. It can also, of course, be converted back into the original RDF along with the rest of the data.

Secondly, there are some minor differences in the tree structure. The DOI in particular was represented in BibJSON by an “identifier” object with a type, url, and id. In our generated JSON-LD, it is simplified to a key-value pair. This is mainly due to the nature of the source data. BIBO’s *doi* property expects us to infer information that BibJSON makes explicit. JSON-LD doesn’t offer a mechanism for forcing simple data types into more complex structures, so there’s not a natural way to resolve this issue. Some attention will later be given to workarounds for eventualities like these. For now, it is enough to know that not all graphs can be represented with the same JSON tree structure; JSON-LD documents are, first and foremost, representations of RDF graphs.

## Indexing the Graph

Indexing items in Elasticsearch is as easy as sending an HTTP PUT request containing the appropriate JSON. The example data in Figure 4 could be indexed with a request like

`curl -XPUT http://localhost:9200/bibjson/articles/1 -d '{...}'`

where ‘…’ is replaced by the record itself (here, the contents of @graph in Figure 4). The URL parts ‘bibjson’ and ‘articles’ are, in order, the index name and the type of the document. By default, Elasticsearch creates new indexes automatically and creates a default mapping for new types. The final part of the URL (‘1’) will be Elasticsearch’s internal identifier; indexing with HTTP POST enables automatic id generation. The simplest method for indexing multiple records, therefore, is to iterate through the list in *@graph*, POSTing each record in turn. Once indexed, documents can be retrieved via HTTP GET and indexes can be searched via [Elasticsearch’s query API.](http://www.elasticsearch.org/guide/reference/query-dsl/)

Elasticsearch is intended to have “sensible defaults” for types with no explicitly defined search mappings ([Elasticsearch, n.d.](https://journal.code4lib.org/articles/#cite-Elasticsearch)). Mappings configure the searchability, tokenization and faceting of fields, as well as data types, boosting, and inclusion of fields in ‘\_all’ searches. The defaults are often sufficient and, when they aren’t, still manage to usefully handle unexpected data. Custom mappings can be applied on a per-index and per-type basis. \[[4](https://journal.code4lib.org/articles/#note4)\]

### Creating Aggregate Indexes

Adding data from a second source can be accomplished by creating a new context and frame, then adding the resulting JSON-LD in Elasticsearch. To the extent that the two datasets share BibJSON as a common format, no new configuration is needed. However, when adding data generated from more than one context, experience at Oregon State has suggested that using separate indexes is good practice. The context associated with a given index can be added alongside its data as type “context”, and searches configured to ignore these documents. Keeping the context alongside the data gives applications a convention for extracting semantics back out of the indexed documents.

Organizing indexes this way also allows different search mappings to be applied on a by-index basis, helping to address discrepancies between data sources. Queries can be easily run across both types and indexes and the segregation doesn’t affect the performance of searches.

### Support for (unlinked) BibJSON

In addition to supporting a wide variety of Linked Data models, this index could also accommodate original BibJSON data. To enhance its interoperability with JSON-LD indexes, a generic BibJSON context document could be applied.

## FRBR and Other Limitations

### Data Modeling

Perhaps the strongest limitation faced is the inconsistency between different data models. While our chosen common format prefers simple key-value pairs where possible, RDF data models often use more explicit and complex structure. A core example in the library domain is the entity-relationship model specified by FRBR ([IFLA, 1998](https://journal.code4lib.org/articles/#cite-IFLA)). Expressing FRBR’s multi-tiered approach to bibliographic data in JSON will lead to a fundamentally different data structure than the BibJSON used by the rest of the index. Any simplification for compatibility would be lossy, flattening the graph (and can’t be done using JSON-LD’s algorithms).

It’s worth noting that these conceptual incompatibilities originate with the data models themselves and are not an artifact of the index process. Datasets using differing models could still be expressed in JSON-LD and indexed in Elasticsearch, but querying them would require a substantial amount of work on the application side to adjust for their differences. Models with major incompatibilities in the index could instead be transformed into a compatible, BibJSON-friendly, graph prior to generating JSON-LD. If needed, Elasticsearch could still be used as a datastore for the original graph (in JSON-LD) in a separate index, not included in default searches. In this case, some internal convention would be needed to maintain an association between the indexed record and its original RDF.

For smaller model incompatibilities like the DOI issue encountered above, the best option may be to add duplicate data after the initial JSON-LD conversion. In the DOI example, we would add the “identifier” object alongside the existing “doi” term. So long as the data produced by the JSON-LD algorithm is untouched the result will be a more consistent (and still *linked*) dataset.

### Name Collisions in Contexts

A smaller, but significant, limitation is the potential for name collision in context documents. Since JSON-LD won’t allow multiple IRI’s to be mapped to the same JSON key (this would prevent re-expansion), terms can’t always be represented using BibJSON’s default key. The most common problem in our experience is due to the use of “name” as a key for both people (often expressed with foaf:name) and journals (dc:title). Mapping both terms to “name” in JSON-LD would destroy the distinction between the two. The solution here is simple, though it does require an additional step: find a term (e.g. rdfs:label) that applies to both needs and add a triple to the incoming RDF. Elasticsearch will index both the shared term (as “name”) and the original (with its full URI as the key).

### Follow Your Nose

One final weakness is that many RDF datasets will only contain a subset of the graph relevant to the creation of a full index. For example, a bibliographic dataset might hold comprehensive data about a book, but make reference to the author only by link to an external source—the ability to make use of related external data being a defining feature of Linked Data. JSON-LD generated from such a source would retain the author IRI used in the original, but may be missing data points as crucial as the author’s name. The solution, here as elsewhere, is to *follow your nose* \[[5](https://journal.code4lib.org/articles/#note5)\], dereferencing the IRIs to build a more complete graph.

## Summary

JSON-LD can serve as a useful tool for making Linked Data more accessible to applications. Using it in conjunction with BibJSON and Elasticsearch provides a low barrier method for indexing a wide variety of bibliographic data. Though the index has some limitations, it succeeds at joining heterogeneous Linked Data in a generic form without compromising the full graph structure and semantics of the original data source.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Note that this doesn’t yield “semantic search” in the usual sense of inference, fuzzy logics and concept mapping, but rather a traditional analyzed index. Because both semantics and graph structure are retained, clever use of the index might emulate semantic search features like concept-based facets.

\[[2](https://journal.code4lib.org/articles/#ref2)\] The behavior of ‘@embed’ is currently in flux. The treatment we rely on here has clear support in current discussion: [https://github.com/json-ld/json-ld.org/issues/119](https://github.com/json-ld/json-ld.org/issues/119).

\[[3](https://journal.code4lib.org/articles/#ref3)\] Author, editor, license, identifier, link, and journal.

\[[4](https://journal.code4lib.org/articles/#ref4)\] A good introduction to mapping is available in a pair of blog posts at [http://euphonious-intuition.com/2012/07/an-introduction-to-mapping-in-elasticsearch](http://euphonious-intuition.com/2012/07/an-introduction-to-mapping-in-elasticsearch) and [http://euphonious-intuition.com/2012/08/more-complicated-mapping-in-elasticsearch](http://euphonious-intuition.com/2012/08/more-complicated-mapping-in-elasticsearch).

\[[5](https://journal.code4lib.org/articles/#ref5)\] See [http://patterns.dataincubator.org/book/follow-your-nose.html](http://patterns.dataincubator.org/book/follow-your-nose.html).

## References

Baker, T., Bermès, E., Coyle, K., Dunsire, G., Isaac, A., Murray, P., …Zeng, M. (2011). Library Linked Data Incubator Group Final Report. Available [http://www.w3.org/2005/Incubator/lld/XGR-lld-20111025/](http://www.w3.org/2005/Incubator/lld/XGR-lld-20111025/)

IFLA Study Group on the Function Requirements for Bibliographic Records. (1998). Functional Requirements for Bibliographic Records Final Report. Available [http://archive.ifla.org/VII/s13/frbr/frbr\_current\_toc.htm](http://archive.ifla.org/VII/s13/frbr/frbr_current_toc.htm)

Johnson, T. and Boock, M. (2012). Linked Data Services for Theses and Dissertations, Proceedings of the 15th International Symposium on Electronic Theses and Dissertations, Lima, Peru. Available [http://hdl.handle.net/1957/32977](http://hdl.handle.net/1957/32977)

Lanthaler, M., Gütl, C. (2012). On Using JSON-LD to Create Evolvable RESTful Services, Proceedings of the Third International Workshop on RESTful Design. Available from: [http://dx.doi.org/10.1145/2307819.2307827](http://dx.doi.org/10.1145/2307819.2307827). [(COinS)](https://journal.code4lib.org/coins)

RDF JSON. \[Internet\]. Talis Systems. Available from: [http://docs.api.talis.com/platform-api/output-types/rdf-json](http://docs.api.talis.com/platform-api/output-types/rdf-json)

Hawke, S. From JSON to RDF in Six Easy Steps with JRON. \[Internet\]. \[Updated: June 4, 2010\]. Available from: [http://decentralyze.com/2010/06/04/from-json-to-rdf-in-six-easy-steps-with-jron/](http://decentralyze.com/2010/06/04/from-json-to-rdf-in-six-easy-steps-with-jron/)

MacGillivray, M. and Pitman, J. How to do BibJSON. \[Internet\]. Available from: [http://www.bibjson.org/](http://www.bibjson.org/)

Jones, R., MacGillivray, M., Murray-Rust, P., Pitman, J., Sefton, P., O’Steen, B., and Waites, W. (2011). Open Bibliography for Science, Technology, and Medicine, Journal of Cheminformatics, 3:47. [http://dx.doi.org/10.1186/1758-2946-3-47](http://dx.doi.org/10.1186/1758-2946-3-47)

Elasticsearch Guide: Mapping. \[Internet\]. Available from: [http://www.elasticsearch.org/guide/reference/mapping/](http://www.elasticsearch.org/guide/reference/mapping/)

## Appendix

| 1  2  3  4  5  6  7  8  9  10  11  12 | `import` `json, rdflib`  `from` `pyld ``import` `jsonld`  `g ``=` `rdflib.ConjunctiveGraph()`  `g.parse(example.ttl``', format='``n3')`  `expand ``=` `jsonld.from_rdf(g.serialize(``format``=``"nquads"``)) `  `framed ``=` `jsonld.frame(j, json.load(``open``(``'example_frame.jsonld'``, ``'r'``)))`  `print` `json.dumps(framed, indent``=``1``)` |
| --- | --- |

Python framing code.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40 | `{     `  `"@context"``: {`  `...`  `}, `  `"@graph"``: [`  `{`  `"name"``: ``"Thomas Johnson"``, `  `"@type"``: ``"Person"`  `}, `  `{`  `"title"``: ``"Indexing Linked Bibliographic Data with JSON-LD, BibJSON & Elasticsearch"``, `  `"journal"``: {`  `"@id"``: ``"urn:issn:19405758"`  `}, `  `"author"``: [`  `{`  `}`  `], `  `"link"``: {`  `}, `  `"year"``: ``"2013"``, `  `"doi"``: ``"10.1000/182"``, `  `"issue"``: ``"19"``, `  `"@type"``: ``"article"`  `}, `  `{`  `}, `  `"@id"``: ``"urn:issn:19405758"``, `  `"name"``: ``"Code4Lib Journal"``, `  `"@type"``: ``"Journal"`  `}`  `]`  `}` |
| --- | --- |

Un-framed (compacted) JSON-LD document.

## About the Author

Thomas Johnson is Digital Applications Librarian at Oregon State University Libraries, where he works on digital curation, scholarly publication, and related metadata and software issues.
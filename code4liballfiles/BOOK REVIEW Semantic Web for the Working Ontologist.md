---
title: "BOOK REVIEW: Semantic Web for the Working Ontologist"
source: "https://journal.code4lib.org/articles/1480"
author:
  - "[[The Code4Lib Journal]]"
published: 2009-03-31
created: 2025-01-10
description: "Written by two of the leading authorities on the semantic web, the \"Semantic Web for the Working Ontologist\" is a timely and thorough introduction to the topic. Covering RDF, RDFS, and OWL, the book takes a logical, trainerly approach, with practical and illuminating examples. Well worth a read."
tags:
  - "clippings"
---
# BOOK REVIEW: Semantic Web for the Working Ontologist
Written by two of the leading authorities on the semantic web, the “Semantic Web for the Working Ontologist” is a timely and thorough introduction to the topic. Covering RDF, RDFS, and OWL, the book takes a logical, trainerly approach, with practical and illuminating examples. Well worth a read.

Allemang, Dean, and James A. Hendler. 2008. *Semantic Web for the Working Ontologist: Modeling in RDF, RDFS and OWL*. Boston: Morgan Kaufmann Publishers. COinS

By [Tom Keays](http://purl.oclc.org/NET/tomkeays)

A couple of years ago, I started reading Shelley Powers’ book, “Practical RDF” \[[1](https://journal.code4lib.org/articles/#fn1)\]. Published by O’Reilly in 2003 while the RDF Core Working Group was still working on revisions to the W3C’s RDF specification \[[2](https://journal.code4lib.org/articles/#fn2)\], this was one of the first attempts to bring the six documents of that specification together in one place and try to give them an understandable context along with practical examples and code.

Alas, I bogged down about halfway through and never did more than skim the last part. The book had a cursory treatment of alternate RDF serialization notations, including N-triples and Notation 3 (N3), but most of the examples were written in XML. Bulky, tedious RDF/XML. I already had a pretty good understanding of how to formulate valid XML but, despite the author’s best efforts, I found the syntax of RDF in XML to be extremely opaque. I was never able to gain any sort of proficiency translating RDF Subject – Predicate – Object triples into XML and I never trusted my ability to construct any sort of proper RDF/XML statements from scratch. It didn’t help matters that Powers, not being exactly sure how the draft RDF specification was going to play out, included several complicated use cases involving RDF containers and collections that were never actually put into practice.

About a year ago, I started noticing that a number of new books were being written about the semantic web \[[3](https://journal.code4lib.org/articles/#fn3)\] and linked data \[[4](https://journal.code4lib.org/articles/#fn4)\] (as opposed to titling them as books about RDF). This signaled to me that a sea change had occurred in how the semantic web community was approaching the topic. I was also very aware that the then upcoming Code4Lib Conference \[[5](https://journal.code4lib.org/articles/#fn5)\] had announced no less than a daylong pre-conference workshop, two keynote talks, and several presentations all dealing with linked data.

From the various new books that were published in 2008, I decided to read Dean Allemang and Jim Hendler’s “Semantic Web for the Working Ontologist : Effective Modeling in RDFS and OWL” \[[6](https://journal.code4lib.org/articles/#fn6)\], published by Morgan Kaufmann, singling it out as one of the more practical (as opposed to theoretical) treatments of the subject. Both authors have academic backgrounds with excellent credentials in writing about, working with, and providing training in semantic web technologies. Jim Hendler \[[7](https://journal.code4lib.org/articles/#fn7)\] was co-author with Tim Berners-Lee of the seminal 2001 paper introducing the idea of the semantic web to the world \[[8](https://journal.code4lib.org/articles/#fn8)\] and was co-chair of the W3C’s Web Ontology (OWL) Working Group \[[9](https://journal.code4lib.org/articles/#fn9)\]. Dean Allemang \[[10](https://journal.code4lib.org/articles/#fn10)\] is the Chief Scientist at TopQuadrant, Inc., a consulting, training and semantic web products company. Allemang and Hendler co-developed TopQuadrant’s semantic web training series.

The “Semantic Web for the Working Ontologist,” is all about what you can build using RFD and why. By comparison, Powers’ “Practical RDF” book, as appropriate as it was for its time, was more about the parts and less about the structures. Examining the difference in approaches is like comparing two books on the technology of woodworking: one describing different kinds of nails, screws, and planks, and the other showing you how to build furniture.

The authors’ training experience shows through in the clear presentation of ideas and examples in this book. It is logically organized into 14 chapters, an FAQ appendix, and a subject index. Although not explicitly divided into broad sections, the sequence of the chapters seemed to me to fall into seven rough subdivisions of content.

The first 2 chapters start out gently, introducing general semantic web concepts including semantic modeling.

Chapters 3 through 5 then delve into the basic structures of RDF, including identities, URIs, and the common namespaces of RDF, RDFS, and OWL (along with several homebrewed namespace examples). All the examples in the book are framed in concise and clear N3 notation with some graph representations. N3, because of its compactness and simple rules, makes it much easier to see and understand the structure of RDF statements than is possible with XML (although Chapter 3 briefly describes XML and N-Triples as alternative serializations). The chapter also has an excellent example that, in showing how to translate more familiar data structures, such as a table of data, into RDF, provides much of the underpinnings needed for the rest of the book. This is the section where the reader really gets his feet wet and will probably make his decision to keep on reading or not. Chapters 4 and 5 build on Chapter 3, describing the idea of the RDF store, examples of RDF parsers and serializers for getting data in and out of stores, various forms of RDF query languages for retrieving information from stores, and application frameworks for putting it all together. Along the way, the concept of inferencing, so essential for RDF queries to work, is introduced and described through a series of examples.

Chapter 6 introduces RDF Schema Language (RDFS) and explores how the addition of this schema structure allows you to begin to talk about sets and relationships. By itself, RDF is nothing more than a framework for describing things in terms of Subjects, Predicates, and Objects. As such, there is very little that you can do with it that will get you much beyond describing nodes and graphs. RDFS, on the other hand, provides a vocabulary for describing RDF graphs, together with structures for defining relationships for members of graph nodes and a way to make more interesting queries against the data model. The examples in Chapter 6 help the reader begin to understand the real power and intentions of RDF.

OWL is a topic that can make even someone experienced with semantic web principles quickly glaze over. There’s nothing in OWL that can’t be also stated with RDFS, but using OWL gives the RDF ontologist a set of rules that simplify and clarify semantic web structures. In Chapter 7, the authors have chosen to ease the reader into the topic of ontologies by introducing selected OWL properties and classes in a subset of elements they’ve dubbed RDFS-Plus. They’ve found that this subset of OWL increases the power of RDFS without requiring a large conceptual leap for the user. RDFS-Plus is then used to provide a framework for introducing the reader to such notions as inverse properties, symmetric properties, transitivity, equivalence (both of classes and properties), and functional properties that allow merging of datasets. Chapter 8 takes the concepts introduced in Chapter 7 a bit further by exploring the real world applications of SKOS (Simple Knowledge Organization System), a syntax that can be used to construct taxonomies, thesauri, and controlled vocabularies, along with FOAF (Friend of a Friend), a simple framework for describing relationships between people and organizations. FOAF, incidentally, served as a central example at the Linked Data Pre-Conference session \[[11](https://journal.code4lib.org/articles/#fn11)\] at Code4Lib 2009.

Once the reader is comfortable with RDFS-Plus, Chapters 9 through 11 explore OWL more completely, covering the idea of restrictions in quite a lot of detail, before launching into a description of OWL as a way to do set-specific analyses of relationships, along with the ideas of cardinality, counting, existence, contradictions, and unsatisfiable classes. Chapter 11 describes instances of OWL “in the wild”, using the Federal Enterprise Architecture Reference Model (FEA-RM) and The National Cancer Institute (NCI) ontologies to extend the concepts previously introduced. The choice of these examples are not too surprising once you realize that the authors do a lot of training in the government sector.

Chapter 12 introduces suggested routines and procedures for constructing semantic models, including best practices and potential pitfalls of rule construction.

Chapters 13 and 14 wrap up the book, speculating on the future of the semantic web and summarizing and extending the ideas previously presented.

The book has a short appendix in the form of a FAQ that indexes important concepts described in the book, as well as a more traditional alphabetic index of terms and sections. In addition, there is a small companion web site that has code examples and a short errata list \[[12](https://journal.code4lib.org/articles/#fn12)\].

## Conclusion

The semantic web might not yet be widely regarded as a source of mainstream library data, but I sense that that day is coming. Dublin Core, FRBR, and RDA all have expressions in RDF. The Library of Congress is promising to give us back a sanctioned linked data version of LCSH and other sources of library authority data \[[13](https://journal.code4lib.org/articles/#fn13)\]. LIBRIS, the Swedish Union Catalogue, is an example of an OPAC that has planned for the future and displays bibliographic records as linked data \[[14](https://journal.code4lib.org/articles/#fn14)\].

Before reading this book, I managed to assemble a halting knowledge of RDF from various sources, sufficient enough that, together with some cribbed examples, I was able write a simple FOAF profile, but not much more. After reading “Semantic Web for the Working Ontologist,” I feel like I understand RDFS and OWL for the first time and, although far from expert, would be up to doing some real work. All in all, the “Semantic Web for the Working Ontologist” is a useful book. Although some of the concepts are a little dense and not always perfectly stated, it is definitely a fine introduction to the topic and a good way to gain some real knowledge and skills.

With a list price of $137, the publisher seems to be marketing the “Semantic Web for the Working Ontologist” as an academic textbook rather than a mass market computer science reference work. Fortunately, Amazon and other booksellers generally have new copies in the $45-$55 range and used books at $10 or so below that. This is a book that can be found in many academic libraries, so it ought to be fairly easy to examine a copy before deciding to buy it.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Powers, Shelley. 2003. *Practical RDF*. Cambridge: O’Reilly & Associates, Inc. OCLC: [51527158](http://www.worldcat.org/oclc/51527158). Open Library: [OL3318069M](http://openlibrary.org/b/OL3318069M/). COinS

\[[2](https://journal.code4lib.org/articles/#ref2)\] RDF/XML Syntax Specification (Revised). W3C Recommendation 10 February 2004. [http://www.w3.org/TR/rdf-syntax-grammar/](http://www.w3.org/TR/rdf-syntax-grammar/)

\[[3](https://journal.code4lib.org/articles/#ref3)\] W3C Semantic Web Activity. [http://www.w3.org/2001/sw](http://www.w3.org/2001/sw)

\[[4](https://journal.code4lib.org/articles/#ref4)\] Linked Data. Wikipedia. [http://en.wikipedia.org/wiki/Linked\_Data](http://en.wikipedia.org/wiki/Linked_Data)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Code4Lib Conference. 2009. Providence, RI. [http://www.code4lib.org/conference/2009/](http://www.code4lib.org/conference/2009/)

\[[6](https://journal.code4lib.org/articles/#ref6)\] Allemang, Dean, and James A. Hendler. 2008. *Semantic Web for the Working Ontologist: Modeling in RDF, RDFS and OWL*. Boston: Morgan Kaufmann Publishers. OCLC: [184925396](http://www.worldcat.org/oclc/184925396). Open Library: [OL16867827M](http://openlibrary.org/b/OL16867827M/). COinS

\[[7](https://journal.code4lib.org/articles/#ref7)\] James Hendler’s website. [http://www.cs.rpi.edu/~hendler/](http://www.cs.rpi.edu/~hendler/)

\[[8](https://journal.code4lib.org/articles/#ref8)\] Berners-Lee, Tim, James Hendler, and Ora Lassila. “The Semantic Web.” *Scientific American* 284, no. 5 (May 2001): 34-43. [http://www.sciam.com/article.cfm?id=the-semantic-web](http://www.sciam.com/article.cfm?id=the-semantic-web) COinS

\[[9](https://journal.code4lib.org/articles/#ref9)\] OWL Web Ontology Language Reference. W3C Recommendation 10 February 2004. [http://www.w3.org/TR/owl-ref/](http://www.w3.org/TR/owl-ref/)

\[[10](https://journal.code4lib.org/articles/#ref10)\] Dean Allemang’s blog. [http://dallemang.typepad.com/](http://dallemang.typepad.com/)

\[[11](https://journal.code4lib.org/articles/#ref11)\] Summers, Ed. Attendees list generated from linked FOAF profiles. Linked Data Pre-Conference. Code4Lib Conference. 2009. [http://www.inkdroid.org/c4l2009/attendees](http://www.inkdroid.org/c4l2009/attendees)

\[[12](https://journal.code4lib.org/articles/#ref12)\] *Semantic Web for the Working Ontologist* companion website. [http://workingontologist.org/](http://workingontologist.org/)

\[[13](https://journal.code4lib.org/articles/#ref13)\] ID.LOC.GOV Web Service. Library of Congress. [http://id.loc.gov/](http://id.loc.gov/)

\[[14](https://journal.code4lib.org/articles/#ref14)\] Lindström, Henrik and Martin Malmsten. “User-Centred Design and Agile Development: Rebuilding the Swedish National Union Catalogue.” *The Code4Lib Journal* iss. 5 (December 2008). [http://journal.code4lib.org/articles/561](https://journal.code4lib.org/articles/561)

[Tom Keays](http://purl.oclc.org/NET/tomkeays) is a science librarian at Syracuse University and a founding editor of the [*Code4Lib Journal*](https://journal.code4lib.org/).
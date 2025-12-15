---
title: "Response to PREMIS Events Through an Event-Sourced Lens"
source: "https://journal.code4lib.org/articles/18203"
author:
  - "Jack O’Sullivan"
  - "Sarah Romkey"
  - "Karin Bredenberg"
published: 2024-10-08
created: 2025-01-10
description: "The PREMIS Editorial Committee (EC) read Ross Spencer’s recent article “PREMIS Events Through an Event-sourced Lens” with interest. The article was a useful primer to the idea of event sourcing and in particular was an interesting introduction to a conversation about whether and how such a model could be applied to Digital Preservation systems. However, the article makes a number of specific assertions and suggestions about PREMIS, with which we on the PREMIS EC disagree. We believe these are founded on an incorrect or incomplete understanding of what PREMIS actually is, and as significantly, what it is not. The aim of this article is to address those specific points."
tags:
  - "clippings"
---
# Response to PREMIS Events Through an Event-Sourced Lens

Jack O’Sullivan, Sarah Romkey, Karin Bredenberg

## Introduction

The PREMIS Editorial Committee (EC) read Ross Spencer’s recent article “[PREMIS Events Through an Event-sourced Lens](https://journal.code4lib.org/articles/17264)” with interest. [^1]   The article was a useful primer to the idea of event sourcing and in particular was an interesting introduction to a conversation about whether and how such a model could be applied to Digital Preservation systems.

However, the article makes a number of specific assertions and suggestions about PREMIS, with which we on the PREMIS EC disagree. We believe these are founded on an incorrect or incomplete understanding of what PREMIS actually is, and as significantly, what it is not.

The aim of this article is to address those specific points.

## A Brief Introduction to PREMIS

### Data Model

PREMIS (PREservation Metadata: Implementation Strategies) is a data model describing “the information a repository uses to support the digital preservation process”. [^2] The data model is comprised of four top-level entities:

- Objects, the subjects of preservation;
- Events, the actions performed on the objects in the course of preservation;
- Rights, the bases under which a repository is permitted to perform preservation actions; and
- Agents, the people, organizations and/or software who perform preservation actions or confer Rights to the repository.

Each entity has a set of “semantic units” (properties) associated with it. Some of these semantic units are mandatory whilst some are optional. Some are intended to be single value property fields, whilst others have further substructure. Some can be repeated multiple times for the same entity whilst others are only expected to occur once. Some semantic units are expected to be populated with values from a controlled vocabulary.

The data model itself is defined in the Data Dictionary, which is the primary artifact maintained by the PREMIS EC.

PREMIS is technology and implementation agnostic. It defines the set of information that a repository is likely to need to know to support preservation activities. It does not mandate how that information should be stored, or how systems using PREMIS should be architectured.

Whilst the Data Model is technology independent, the PREMIS EC do maintain two additional resources to support implementation, an XML schema and an RDF OWL Ontology, both of which are technology specific encodings of the data model.

Similarly, for semantic units where the value is expected to be populated with values from a controlled vocabulary, this is a guideline, expressed as a “should” rather than a “must” requirement.

The PREMIS EC maintains a list of controlled vocabularies that are applicable to these semantic units, which have been developed through community collaboration over an extended period of time, and which we believe to be broadly applicable. Individual repositories may have other constraints and policies regarding these values, or different scopes of what they determine or require “preservation” to mean, and so the actual vocabularies used are an implementation specific decision.

### Conformance

Since PREMIS does not mandate any specific implementation details, it provides a means for implementers to assert the conformance of their specific implementation. This conformance statement provides three levels that implementers can assert. For simplicity, we are omitting the A and B sub-clauses at each level, which cover the scope of the PREMIS data that is conformant, rather than the manner in which it is conformant.

1. Level 1 (Mapping) – Implementers assert that the data model in use by their system can be mapped to the PREMIS data model, including assertions that all mandatory semantic units can be supplied or derived.
2. Level 2 (Export) – Implementers assert that their repository provides functionality or processes to export internally held metadata as valid PREMIS metadata.
3. Level 3 (Internal Implementation) – Implementers assert that their repository directly implements the PREMIS data model as the internal data model of the system.

Even at Level 3, this statement is agnostic as to the technology, details and strategy for implementation.

### What PREMIS is not

As stated above, PREMIS is deliberately intended to be agnostic of any particular implementation or technology. As a consequence, it is not the XML schema, the RDF OWL Ontology, or any of the controlled vocabularies, all of which the EC maintain as references and supporting materials for implementers.

## Specific Suggested PREMIS Changes

Given what we have said about PREMIS, we can now look in some detail at some of the specific suggestions and assertions made about PREMIS in the original paper.

### Nouns become actions in the past tense

The assertion that PREMIS events are often *“nounified”* seems to us to imply one (or both) of two things. The first is that the Event Types in the PREMIS maintained controlled vocabularies are nouns. The second is that systems that implement PREMIS tend to use nouns as event labels.

The first of these is undoubtedly true. This can be understood as the controlled vocabulary describing the types of preservation actions that preservation systems are likely to enact, rather than describing the performance of the act itself. The second of these is also, in our experience, true. We believe that this can be understood as a symptom of the fact that, as the author points out, preservation systems today do not tend to be architectured as event sourced systems, but instead as records of how things are, and how they came to be.

That being said, we don’t believe that it follows that the author’s assertion that *“titular PREMIS nouns become a barrier to engage with, use and extend without committee”* is also true. The Event Type controlled vocabulary is intended to cover as broad a range of use cases as possible, but is not intended to be prescriptive or proscriptive. Implementers are free to use their own vocabularies where they wish or need. The PREMIS Data Dictionary strongly suggests only that these vocabularies **should** be controlled so as to facilitate exchange of information and description.

### Less importance placed on the data dictionary

As discussed above, the Data Dictionary is the primary artifact of PREMIS. It **is** the definition of the data model, so it’s hard to see how less importance could be placed on it. Given what the author actually says under this heading, our reading is that the author actually means that less importance be placed on the set Event Types covered by the controlled vocabulary. As discussed, this is already a guideline for implementers, who can choose the degree of importance they attach to adhering to the list.

### Closer to a technical implementation

It is not clear to us that the author is actually suggesting any change here. We would like to reiterate however that PREMIS is explicitly and very deliberately implementation agnostic.

### PREMIS conformance restrictions around internal schemas are made more flexible

The author is really covering three distinct issues here, firstly around the potentially hierarchical nature of the Levels of Conformance, secondly as to whether the distinctions between the levels are still valid, and finally whether Level 3 is “reasonable” today.

#### Are the Levels Hierarchical?

The author asks, *“While described as levels, should they be viewed hierarchically”*, without seeming to posit a reply. Whilst it is not explicit what is meant by this, we can at least offer the beginnings of an answer.

Logically, the three levels do indeed build hierarchically. Level 1 states that the metadata that the repository stores or knows can be mapped to PREMIS. That is, for each PREMIS entity and semantic unit, the repository stores or knows an equivalent metadata value. Level 2 takes this a step further, stating that not only does the repository store or know that metadata, but that, on request, it can provide a user with that metadata using PREMIS terminology directly. Level 3 then further states that the repository actually stores that metadata using PREMIS terminology directly.

If you can assert Level 2 conformance, then by definition you must also meet the criteria for Level 1. Similarly, if you can assert Level 3.

It is theoretically possible that you could assert Level 3 by directly implementing PREMIS, but not be able to assert Level 2 because all export mechanisms transformed the metadata away from PREMIS (or there are no export mechanisms), but it seems so unlikely that any implementation would actually do this that for all practical purposes we can think of the levels as a hierarchy.

This is not to say that there is an implied hierarchy of merit in approach. It is not inherently “better” to have Level 3 conformance than Level 2, or to have Level 2 rather than Level 1. The levels simply represent different choices made by each implementer.

#### Are all three Levels still required?

The author asserts that:

> *The first level of conformance clearly makes interpretation of an internal schema next to PREMIS more difficult, and vice versa. One may remove this level of conformance completely. Conceptually, however, two and three, have the same outcome, functionally, they take different paths toward getting there. Can one approach realistically be viewed as better than the other?*

There are several threads to pick at in this statement. The first is contained within the first sentence. It is not “clear” to the EC that providing an option to allow implementers to map their internal schemas to a common standard makes anything more difficult. In practice, this means that implementers may have to include elements in their data models that they would not have included in the absence of PREMIS or a requirement or desire to attain conformance with PREMIS. It does not constrain their freedom to include other elements that are beyond the scope of PREMIS, or indeed to choose how to interpret the PREMIS model.

There follows an assertion that Level 1 could be removed completely, and that Levels 2 and 3 “have the same outcome”.

Like everything in PREMIS, the Levels of Conformance are subject to periodic review based on user and implementer feedback. That said, the EC believes that the current Levels and definitions are each useful and sufficiently distinct from each other that they are not in need of such drastic overhaul as suggested here.

For any system implementing with Level 1 or 2 conformance, the implication is that there is not a single unique 1:1 correspondence between the internal data model and PREMIS. In most cases that will mean that there is some ambiguity in exactly how the internal data model should be mapped, with multiple valid choices that could be made.

Conformance Level 2 imposes functional requirements that Level 1 does not. It requires

1. that a canonical mapping between the system’s own internal model and PREMIS be established; and
2. that this canonical mapping be formalized through explicit API contracts or functionality.

For providers of systems that are used by multiple institutions, Level 2 could be seen as restricting the freedom of those individual institutions to choose a mapping that best suits their needs. Further, the additional implication of the second part is that the repository has to commit to maintaining functionality.

We believe therefore that there are, and will always be repositories for whom Level 1 is a valid end state to aim to achieve, and that there will be others willing to, or being required to, take the additional steps required to reach Level 2.

To believe that Level 2 and Level 3 have the same outcome, is to consider export of PREMIS metadata as the only, or the main function of a digital preservation system. For Level 2, an implementer can choose to have data in the system that does not map to PREMIS at all, or to have a working model that differs substantially in form from PREMIS in order to facilitate other functionality, accepting that exporting to PREMIS is a transformation performed for a specific use case. This is a fundamentally different proposition from a system that directly implements PREMIS.

Level 3 essentially requires that an implementer is constrained by decisions made by an external body, i.e. the PREMIS EC, at least in regards to preservation metadata. This may be a drawback for Level 3 implementation, but there are also benefits in choosing to take an internationally defined and agreed data model and use that as the basis of your system. The benefits of not implementing an external data model are broadly around increased control and flexibility, however the trade-off to consider is the likely loss of easy interoperability and exchange with other systems.

The benefits and considerations of conforming to any level are outlined above; ultimately the systems designer can take all benefits and drawbacks into consideration and still be in alignment with PREMIS.

PREMIS can only provide this flexibility by continuing to define the current Levels of Conformance.

#### Is level three reasonable in today’s software development world?

Again here, the author posits a question, which actually raises multiple issues. Initially they state that *“PREMIS can be trivially demonstrated to record information that extends beyond that which is useful for preservation”*, citing access as one of those things. There are two responses to this, the first is to note that access has always been considered a part of Digital Preservation, to the point that one of the functional areas of the OAIS model is Access. The second is to reiterate the point made above, that PREMIS as a model specifies that you should know information about the objects being preserved, and the actions performed, without explicitly mandating which actions a repository should concern itself with.

The second issue is whether PREMIS is the most efficient format to be used as a model for digital preservation metadata. This is not really expanded on within this section, but does seem to be raised again within the conclusion. Here the author notes that there have been efforts to reduce the size of PREMIS metadata. Again, what we believe is at issue is not PREMIS as a data model per se, but specific technological implementations.

PREMIS in XML format can indeed be verbose; however this is not unique to PREMIS, one of the more common complaints of XML is its verbosity.

We can reduce the footprint of PREMIS metadata in XML by using compression tools, such as ZIP, GZIP, EXI encoding etc. Obviously this comes at the additional preservation risk of having an extra layer of technology in our solution, and at the expense of some CPU overhead for each read and write operation.

Alternatively, a different technological encoding altogether of the model could be used. The author notes that the RDF OWL Ontology is an alternative that might reduce size, but equally the PREMIS metadata could be expressed in JSON or YAML, or one of any number of data serialization schemes, which in their uncompressed forms would likely be smaller than XML. Indeed, the PREMIS metadata could be directly encoded in a database, which for a large collection could also reduce size.

The core point is that the PREMIS data model specifies the metadata that most repositories are likely to need to know in order to perform preservation; how efficiently this is stored is an issue for each implementation.

## Conclusion

The first version of the PREMIS data dictionary was published nearly 20 years ago, and in that time the practices of digital preservation have benefited from numerous advances in technology, while simultaneously being challenged by technical and societal factors. The aim of the PREMIS data dictionary continues to be to provide a technology and implementation agnostic way for digital preservationists to capture the necessary metadata for continued preservation and access to digital objects. We’d like to thank Ross Spencer for contributing his ideas to the community and hope that this response provides clarification or illumination for anyone interested in implementing PREMIS in their own systems or practices. We would also welcome the opportunity to continue a dialog around how an event sourced system could express the data it preserves in PREMIS form.

## References

 [^1]: Ross Spencer, “PREMIS Events Through an Event-sourced Lens,” *Code4Lib Journal*, no. 56 (April 2023). [https://journal.code4lib.org/articles/17264](https://journal.code4lib.org/articles/17264).  
 [^2]: PREMIS Editorial Committee. *Data Dictionary for Preservation Metadata: PREMIS version 3.0* (June 2015, Revised November 2015). [https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf](https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf).

Jack O’Sullivan, Sarah Romkey, and Karin Bredenberg (Chair) are members of the PREMIS Editorial Committee.

---
title: "Works, Expressions, Manifestations, Items: An Ontology"
source: "https://journal.code4lib.org/articles/16491"
author:
  - "Karen Coyle"
published: 2022-05-10
created: 2025-01-10
description: "The concepts first introduced in the FRBR document and known as “WEMI” have been employed in situations quite different from the library bibliographic catalog. This is evidence that a definition of similar classes that are more general than those developed for library usage would benefit metadata developers broadly. This article proposes a minimally constrained set of classes and relationships that could form the basis for a useful model of created works."
tags:
  - "#ontology"
  - "#FRBR"
  - "#FRBR-LRM/Model"
---
# Works, Expressions, Manifestations, Items: An Ontology
Karen Coyle

The concepts first introduced in the FRBR document and known as “WEMI” have been employed in situations quite different from the library bibliographic catalog. This is evidence that a definition of similar classes that are more general than those developed for library usage would benefit metadata developers broadly. This article proposes a minimally constrained set of classes and relationships that could form the basis for a useful model of created works.

## Introduction

A model for the bibliographic entries in library catalogs was developed in 1998 that included a view of creative endeavors having four levels of abstraction, from the most abstract, “work,” to the actual physical instance, “item.” This model, developed solely within and for the library community, has found adherents among metadata practitioners in other communities. These non-library communities present significantly different use cases both among themselves and against the library use case the model was designed to address. These provide evidence that a set of classes that expresses this model but that is not constrained by the library catalog use case would be useful. Each of the application-specific uses, including the one developed by libraries, would be an appropriate sub-class to a more general model describing the nature of created works.

This article first introduces the concepts in the library model. It then describes the uses outside of the library area. This is followed by a proposal for a definition of entities with *minimum semantic commitment* that can be used as superclasses for metadata definitions in any environment describing created works.

## The FRBR-LRM Model

In 1998, the cataloging division of the International Federation of Library Associations (IFLA) issued a document proposing a new conceptual model for the entries in library catalogs. ([IFLA 1998](https://journal.code4lib.org/articles/#note10), [IFLA 2009](https://journal.code4lib.org/articles/#note11)) This metadata model, known by its acronym FRBR (for Functional Requirements for Bibliographic Records), extrapolated entities and relationships from the metadata creation standards used for library catalogs. The model has three groups of entities, named solely as groups 1, 2, and 3. Group 2 consisted of persons and groups of persons who have some agency over the cataloged works (such as creators and publishers). Group 3 had the entities that represented topical aspects of the resource. Group 1 was the most innovative, as it separated the description of the created resource into four levels of abstraction: *work, expression, manifestation,* and *item* (WEMI). It is this latter set of entities that has found adherence beyond the library use case.

[![](https://journal.code4lib.org/media/issue53/coyle/image-01.png)](https://journal.code4lib.org/media/issue53/coyle/image-01.png)  
**Figure 1.** FRBR Group 1 (WEMI)

Although the study group that created the FRBR model was working exclusively on describing library data, their work revealed a missing concept in the description of created works far beyond the library context. The levels of abstraction from work to item has been seen to be useful for such diverse resources as dataset versions, legal documentation tracking, and fashion industry design flow. While these non-library parties are interested in making use of the WEMI entities, those entities reflect the library catalog environment and its particular business rules. This article proposes the development of an unconstrained created work ontology that benefits from FRBR’s innovation yet facilitates reuse and extension in situations differing from the original intended library use.

## The Library Use Case

Library metadata serves a variety of use cases within the institution. The most mundane is that of an inventory of the owned items. For library users the catalog is the means to discover and locate resources at the level of specificity that serves their need. The multi-level description in FRBR’s WEMI was derived from important bibliographic relationships that could be of interest to library users. For example, one creative *work* can exist in multiple editions, translations, or arrangements (*expression*); one *expression* may be published in many books or other media (*manifestation*); and the end point of a search can be obtaining an individual copy owned by the library (*item*). The FRBR model also followed general database criteria with a goal to eliminate any duplication of data elements across the entities. Because the library community shares metadata records for items they own in common, the model promises an efficiency for the community at large. ([Coyle, 2016 p. 76](https://journal.code4lib.org/articles/#note6))

FRBR has been superseded by a revised model called the Library Reference Model (LRM). ([Riva, 2017](https://journal.code4lib.org/articles/#note19)) This model provides some significant changes in design and naming but the basic concepts of WEMI remain. Note that most of the extra-library discussion continues to refer to the model with the acronym “FRBR” and some concepts introduced in the LRM are not yet widely discussed. The entities of WEMI are defined today in the Library Reference Model as:

- **Work:** *The intellectual or artistic content of a distinct creation*. ([Riva, 2017 p.21](https://journal.code4lib.org/articles/#note19))
- **Expression**: *A distinct combination of signs conveying intellectual or artistic content.*([Riva, 2017 p.23](https://journal.code4lib.org/articles/#note19))
- **Manifestation**: *A set of all carriers that are assumed to share the same characteristics as to intellectual or artistic content and aspects of physical form. That set is defined by both the overall content and the production plan for its carrier or carriers*. ([Riva, 2017 p.25](https://journal.code4lib.org/articles/#note19))
- **Item**: *An object or objects carrying signs intended to convey intellectual or artistic content.* ([Riva, 2017 p.27](https://journal.code4lib.org/articles/#note19))

Each entity has specific relationships with the near entities, and the inverse relationship is assumed ([Riva, 2017 p.65-66](https://journal.code4lib.org/articles/#note19)):

- Work *is realized by* Expression
- Expression *is embodied in* Manifestation
- Manifestation *is exemplified by* Item

In the library model, the relationships between the WEMI entities are disjoint from each other and are fixed in order. Being disjoint, the entities cannot share data elements if RDF reasoning will be applied. This is mainly a problem with sharing between metadata schemas that have distributed their data elements differently, such as the BIBFRAME three-level model and the Resource Description and Access (RDA) adherence to the four-level models of FRBR or LRM.([Baker, 2014](https://journal.code4lib.org/articles/#note1)) In the FRBR model all intervening entities are required: the only route from the manifestation to the work is through the link between manifestation and expression and between expression and work. ([Shotton, 2019](https://journal.code4lib.org/articles/#note20)) The relationships are therefore immutable and all “higher” entities must be present for a “lower” entity to be described.

## Part 2: Uses of WEMI Outside of Libraries

There is ample evidence that metadata designers outside of the library data silo are drawn to the concepts first introduced in the FRBR report of 1998, and in particular they are drawn to the WEMI entities. These entities provide a defined model of created “things” that acknowledges the abstract planes that we interact with separately from the physical embodiments. The examples that follow are a selection of uses of FRBR in non-library applications.

### FRBRcore at vocab.org

When FRBR was issued in 1998, there was no expression of the model in any information technology schema or code. This was in keeping with the declaration that FRBR was a conceptual model that was not being introduced as a bibliographic record schema. This left open, however, the need for systems development using the FRBR conceptual model.

In 2004, library systems developers Ian Davis and Richard Newman created [FRBR Core](https://vocab.org/frbr/core) ([Davis, 2005](https://journal.code4lib.org/articles/#note7)) (revised in 2006), an RDF vocabulary encompassing all of the FRBR entities and the FRBR-defined relationships between them (e.g. “*revisionOf*“, “*expressionOf*“, “*ownerOf*“). FRBR Core did not, however, follow precisely the description of FRBR as given in the 1998 document. It added a top-level class, *Endeavor*, to which the four entities of WEMI are sub-classed which was not included in the FRBR model. It also added a top-level class, *ResponsibleEntity*, for the two entities of the second group, which are *corporate body* and *person*. ([Dunsire, 2008](https://journal.code4lib.org/articles/#note8)) The FRBR document defined specific bibliographic relationships between entities, such as “successor” and “reproductionOf,” which were also included in FRBR Core.

FRBR Core follows the constraints on FRBR entity relationships in that it declares each of the entities other than *subject* to be disjoint of all of the other entities. It also maintained the linear relationships of the entities, defining them as RDF classes in which each entity has only the relationships that maintain the WEMI entities in a single order.

FRBR Core is “core” because it consists only of the FRBR entities and the relationships between them. It does not include properties for the attributes that FRBR defined for the entities, such as title of the work, or publisher of the manifestation. It therefore leaves room for other vocabulary developers to describe the entities through the attributes best suited to their use case.

FRBR Core is important to the story here because in the absence of a metadata schema definition of FRBR or the LRM, FRBR Core has been used in metadata vocabularies implementing their own FRBR-based metadata for non-library objects. FRBR Core was not, however, adopted by the IFLA working group as an approved expression of FRBR. This has created a fork in implementation between the community adhering to the IFLA model and those outside of the library standards environment.

### FaBiO: Semantic Publishing and Referencing

One of the uses of FRBR Core is in the [Semantic Publishing and Referencing (SPAR)](http://www.sparontologies.net/) ontologies. ([Peroni, 2018](https://journal.code4lib.org/articles/#note17)) These ontologies define metadata for the description of documents and the publication workflow in the scholarly publishing domain, and provide a rich vocabulary for  citations, references, and agents.

Within that suite of ontologies is the [FRBR-aligned Bibliographic Ontology](http://www.sparontologies.net/ontologies/fabio), FaBiO ([Peroni, 2012](https://journal.code4lib.org/articles/#note16)) ([Shotton, 2019](https://journal.code4lib.org/articles/#note20)). FaBiO defines sub-classes of the FRBR Core entities and gives them definitions with scholarly publishing semantics. For example, FaBiO Work is defined as:

> Fabio:work – A subclass of FRBR work, restricted to works that are published or potentially publishable, and that contain or are referred to by bibliographic references, or entities used to define bibliographic references. FaBiO works, and their expressions and manifestations, are primarily textual publications such as books, magazines, newspapers and journals, and items of their content. However, they also include datasets, computer algorithms, experimental protocols, formal specifications and vocabularies, legal records, governmental papers, technical and commercial reports and similar publications, and also bibliographies, reference lists, library catalogues and similar collections. For this reason, fabio:Work is not an equivalent class to frbr:ScholarlyWork. An example of a fabio:Work is your latest research paper.

The definition of the superclass to FaBiO *work* in FRBR Core is: “An abstract notion of an artistic or intellectual creation.”  The FaBiO classes are a reuse of the FRBR concepts with narrower semantics. ([Peroni, 2017](https://journal.code4lib.org/articles/#note18))

The classes of WEMI are further subclassed in FaBiO to describe the nature of the entity, such as:

- **Work subclasses**: Biography, Critical essay, Dataset
- **Expression subclasses**: Article, Conference poster, Instruction manual
- **Manifestation subclasses**: Analog manifestation, Digital manifestation
- **Item subclasses**: Analog item, Digital item

By declaring a particular entity to be of the class *fabio:Biography* using the facilities of RDF class relationships, one has also declared that entity to be a *fabio:Work* and a *frbrcore:Work* through the class relationships.

FaBiO also expands the model provided in FRBR Core by allowing additional relationships between the WEMI entities such as from work directly to item without passing through the intermediate entities of expression and manifestation.

[![](https://journal.code4lib.org/media/issue53/coyle/image-02.png)](https://journal.code4lib.org/media/issue53/coyle/image-02.png)  
**Figure 2.** FaBiO Class Relationships (http://purl.org/spar/fabio/)

### Functional Requirements for Information Resources (FRIR)

Members of the Open Government Data community have proposed a FRBR-based data model called FRIR (for Functional Requirements for Information Resources) for datasets. This also is based on the FRBR Core vocabulary. ([McCusker, 2012](https://journal.code4lib.org/articles/#note14)) In this model, the use of abstraction, expressed information, and physical sources is needed to allow members of the community to combine data from different sources and to determine at what level the sources represent the same information. The authors apply the four WEMI levels (which they refer to as the “four FRBR levels of abstraction”) to digital information resources. They consider exact copies of files (the same bitstream) to be *items* of the same *manifestation*. Different file formats with the same content, such as a CSV file and an Excel file, are different *manifestations* of the same *expression*. Different *expressions* contain the same informational content but the files may differ in having more or less content, yet they are *expressions* of the same *work* because they express the same basic data. Datasets that are derived from *expressions* but that do not contain the same information content are considered different *works*.

WEMI class designation for the datasets in the FRIR model can be determined computationally using algorithms that derive from the cryptographic digests of the datasets. As applied, these algorithms bring together files at the appropriate level of abstraction, logically building the WEMI relationships from previously unlinked files.

[![](https://journal.code4lib.org/media/issue53/coyle/image-03.png)](https://journal.code4lib.org/media/issue53/coyle/image-03.png)  
**Figure 3.** FRIR ([McCusker, 2012 p.4)](https://journal.code4lib.org/articles/#note14)

The FRIR uses the FRBR Core vocabulary but not in any bibliographic sense. It does make use of some of the relationship properties such as *successor, revision,* and *reproduction*. Although FRBR was developed for bibliographic works, and is specifically appropriate to published materials, FRIR shows that it is possible to interpret WEMI as representing relationships for very different kinds of information.

### Legal documentation

The use of WEMI for legal documentation arises from the need in that community to keep a strict account of versions of documents as they develop in the juridical and legislative processes, and to make these available in a consistent way across jurisdictions. ([Boer 2002](https://journal.code4lib.org/articles/#note3)) The first to propose the use of WEMI for legal documentation was Joao Alberto de Oliveira Lima, of the Brazilian Senate. ([Lima, 2006](https://journal.code4lib.org/articles/#note12)) He gives the example below which illustrates how the WEMI structure can be used with legal documentation. The work in this example has two expressions: the original text and the amended text. The original text is published as a manifestation in the federal record and on the related senate website on subsequent days. The amended text is published in the record of the legislature one day later.

| 1  2  3  4  5  6  7  8  9  10  11 | `- W1 – “Act n± 9 691, 07/22/1998 [creator = National Congress]”`  `- E1:1 – “Original Text”`  `- M1:1:1 – “Official Publication ``in` `the Federal Journal, 07/23/1998”`  `- I1:1:1:1 – Exemplar on Paper ``in` `the National Library`  `- I1:1:1:2 – Exemplar on Paper ``in` `the Library of the Federal Senate`  `- M1:1:2 – Publication ``in` `the Federal Senate web site, 07/24/1998”`  `- I1:1:2:1 – <http:`  `ListaTexto.action?id=127883>`  `- E1:2 – “Rectifying Text”`  `- M1:2:1 – “Official Publication ``in` `the Federal Journal, 07/24/1998”`  `- I1:2:1:1 – Exemplar on Paper ``in` `the National Library` |
| --- | --- |

**Figure 4.** WEMI relationships in legal documents

This example shows how WEMI can be used to provide a map of the history of document versions over time. ([Lima, 2008](https://journal.code4lib.org/articles/#note13)) Actual legislative workflows can take place over months or years and can iterate through committees and legislatures multiple times while the interested parties negotiate amendments. A WEMI analysis can be used to organize the version history of a single piece of legislation from first proposal to law.

Legal documents using WEMI in this way are formatted in XML. One such XML schema is MetaLex ([Boer, 2008](https://journal.code4lib.org/articles/#note4)), another is the [Akoma Ntoso schema](https://github.com/oasis-open/legaldocml-akomantoso/) ([Palmirani, 2008](https://journal.code4lib.org/articles/#note15)) ([Vitali, 2008](https://journal.code4lib.org/articles/#note21)) which is a standard under the [OASIS LegalDocML Technical Committee](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=legaldocml). In the Akoma Ntoso schema, WEMI metadata is embedded in the XML document itself, in a section called “Identification.” The identification section creates a standardized description of the document. The entities are defined with data element names beginning with “FRBR,” such as FRBRtitle, FRBRauthor.

The Akoma Ntoso schema defines elements that are not found in the original FRBR nor the LRM vocabularies; these support the XML structure of the Akoma Ntoso-coded document. For example, the identification section is linked to the legal document and its versions with the element *FRBRthis* (which identifies the document to which the element relates). There are some properties, such as *FRBRdate* and *FRBRuri*, that are common to each WEMI entity, while other properties, such as *FRBRcountry* and *FRBRfomat*, are defined only for the appropriate entities. Also note that in the XML schema nesting of entities obviates the need for specific relationship properties between the entities.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21 | `</``FRBRWork``>`  `<``FRBRExpression``>`  `<``FRBRthis` `value``=``"/akn/us/act/2011-11-29/112-61/eng@/!main"``/>`  `<``FRBRuri` `value``=``"/akn/us/act/2011-11-29/112-61/eng@"``/>`  `<``FRBRdate` `date``=``"2012-05-09"` `name``=``"Generation"``/>`  `<``FRBRauthor` `href``=``"#palmirani"` `as``=``"#editor"``/>`  `<``FRBRlanguage` `language``=``"eng"``/>`  `</``FRBRExpression``>`  `<``FRBRManifestation``>`  `<``FRBRthis` `value``=``"/akn/us/act/2011-11-29/112-61/eng@/!main.xml"``/>`  `<``FRBRuri` `value``=``"/akn/us/act/2011-11-29/112-61/eng@.akn"``/>`  `<``FRBRdate` `date``=``"2012-05-09"` `name``=``"Generation"``/>`  `<``FRBRauthor` `href``=``"#palmirani"` `as``=``"#editor"``/><``preservation`  `<``mods:note` `type``=``"source content type"``>deposited</``mods:note``>`  `<``mods:digitalOrigin``>born digital</``mods:digitalOrigin``>`  `<``mods:extent``>3 p.</``mods:extent``>`  `</``mods:physicalDescription``>`  `</``preservation``>`  `<``FRBRformat` `value``=``"xml"``/>`  `</``FRBRManifestation``>` |
| --- | --- |

**Figure 5.** Snippet of Akoma Ntoso code

The legal community’s use of WEMI points out a concept that was missing from the original FRBR but that has been added to the model in the LRM: the ability to treat time-based families of created works. The legal community has a need to include time as a central component of its analysis, and as such has turned to the use of time in the museum community’s model, FRBRoo, ([Bekiari, 2017](https://journal.code4lib.org/articles/#note2)) to satisfy this need. ([Lima, 2008](https://journal.code4lib.org/articles/#note13))

### Fast Fashion Design Industry

Two ontologists engaged by the “fast-fashion design industries” to develop a metadata model and who were familiar with FRBR found that they could apply concepts based on WEMI to the work-flow of the Imperial Design Company. There was the initial creative design effort (*work*) followed by a sketch of the design idea (*expression*), then a concrete manufactured product (*manifestation*) with individual sales units (*items*). ([Peroni, 2017](https://journal.code4lib.org/articles/#note18)) The [vocabulary](https://w3id.org/ido/items/1.0.2) makes use of an OWL2 DL implementation of the FRBR Core ([Ciccarese, 2018](https://journal.code4lib.org/articles/#note5)) to create a four-level description of the creation as defined in the fast fashion industry. In the place of *work, expression, manifestation* and *item*, the WEMI classes for this industry were: *style, item, stock-keeping unit* and *piece*. ([Peroni, 2017](https://journal.code4lib.org/articles/#note18))

## Part 3: A New Model

These implementations for the use of WEMI concepts for datasets, manufacturing, and non-library bibliographic data illustrate the utility of these concepts outside of the specific library cataloging context in which they originated.

### Why a new model is needed

Given that WEMI is defined in a standard issued by a professional body, it may not be clear why one should not simply use the entities as they have been defined there. The use cases above show that the specifics of the model designed for library catalog metadata vary significantly from the needs of other communities even though those communities would like to describe their created works with levels of abstraction analogous to WEMI. Although there is some room for interpretation in the library model, the library catalog’s business rules are built into the FRBR/LRM standards by design. For example, the library model includes the primary bibliographic attributes of each entity. Some of these are general in nature (“physical extent”) while others are specific to the descriptions produced for library catalogs (“script conversion”). The library use case also requires significant uniformity between metadata instances created separately in thousands of institutions of various types because libraries make use of commercial software packages that depend on adherence to the data standard. FRBR and the LRM thus can be seen as conceptual models for application profiles that facilitate the use of library community-specific software. It would be unlikely to find another community that has the same needs.

What follows is a proposal for a less constrained model and vocabulary for created works that responds to the demonstrated interest in a WEMI-like set of classes for descriptive metadata. The proposed model will not be bound by library cataloging practices nor constrained by those business rules.

Because the goal of this new model is to support a wide range of views and uses, this proposal implements a theory of ontology development known as *minimal ontological commitment*. ([Gruber, 1993](https://journal.code4lib.org/articles/#note9)) In this approach, base vocabulary terms should be defined with as little built-in semantics as possible, with semantics in this sense being the axiomatic semantics of RDF/OWL as well as meaningful semantics in the sense of human understanding. An ontology whose terms have high semantic definition, such as the library FRBR/LRM model, will provide fewer opportunities for re-use because usage must adhere to the defined semantics in the original ontology. Less semantic commitment in the base ontology means that desired semantics can be defined in specific implementations through the sub-classing of entities and definition of additional entities as needed. The only constraints on this model will be those that maintain necessary coherence between the entity definitions.

It is important to note here that minimum semantics also means that the various community-supported vocabularies that derive from these terms may not be interoperable between them when their community-specific constraints are applied. Like *owl:Thing*, the created work entities are intended primarily to provide a foundation for more specific terms that are derived from them.

### Proposal: A Minimally Defined WEMI Ontology

To begin, we need a new name for this model since the commonly used acronym, WEMI, may be too directly related to FRBR and the LRM. The new ontology is neither the expression of a functional requirement (FR) nor is it directly related to bibliographic records (BR). We also need to avoid confusion as people already refer to different models as “FRBR” and often refer to the WEMI entities as FRBR when they are only a part of that model. Unlike the library use case of modeling recorded knowledge, the proposed model is a model for all created works, that is, any agent-created “thing.” For the remainder of this document I will refer to the Created Work Ontology, or CWO, but other names have been suggested, such as OpenWEMI.

#### Modeling the Ontology

I propose that the CWO be initiated with the four entities first developed in FRBR group 1, as these have been shown to have utility, although a community may decide that there is a need for other entities that describe aspects of the creation. The entities could have the following definitions:

- **Work**: The essence of the created thing
- **Expression**: A sign or series of signs that signify the created thing
- **Manifestation**: The physical characteristics of a realization of the created thing
- **Item**: An instance of the created thing in time and space

Another way is to view the entities as occupying general facets or planes:

- **Work**: The idea or concept plane (“has concept/is concept”)
- **Expression**: The plane of signs or signifiers (“has signs/is signs”)
- **Manifestation**: The physical plane (“has physicality/is physical”)
- **Item**: The location plane (“has location/is located”)

I don’t recommend defining attributes for the entities at this level. It is inevitable that different communities will make different decisions in where they place specific metadata elements across the WEMI planes. Further experience with the model may surface universals for the entities, but it would be limiting to define attributes prematurely. As communities define their metadata with classes that are sub-classed to CWO, the properties that they create will serve to further explain the meaning of the created work in their environment.

#### The Relationships in CWO

WEMI is conceptually a technology stack with relationships between the members of the stack. Whether the stack is organized from item to work, or work to item is a matter of a point of view. However, it is similar to a technology stack in that the order of the elements of the stack is fixed, and that order determines the possible relationships between the entities. This statement about the order is true even though not all elements of the stack are required: entities must retain their position in the stack to be semantically valid. A metadata description of a created resource does not require the existence of the full WEMI stack, but it does require adherence to the logical order of the entities.

The formal rules for CWO therefore need to maintain the WEMI stack while allowing for flexibility. The relationships can be between any more abstract levels in the stack to those more concrete. This reads as:

- Work
- Is expressed in Expression / Expression expresses Work
- Is manifested in Manifestation / Manifestation manifests Work
- Is instantiated in Item / Item instantiates Work
- Expression
- Is manifested in Manifestation / Manifestation manifests Expression
- Is instantiated in Item / Item instantiates Expression
- Manifestation
- Is instantiated in Item / Item instantiates Manifestation

There are various reasons for not requiring the presence of every entity in the full stack for valid adherence to the model including the lack of omniscience on the part of metadata creators and the potential lack of completeness of a set of metadata at a given position in the data creation workflow. A person working on the description of an individual item may not know at the time whether it is one of a set of identical products that could be considered manifestations, nor may be in possession of the information about who created the work or even what the work represents. Thus, at a particular moment in time, one may be creating metadata for an item that is orphaned from the rest of the WEMI stack. Knowledge is a process of constant building on prior knowledge, and even with a full WEMI description one should be aware that new entries into the graph result in different knowledge about the creation. This is analogous to the Open World Assumption of RDF, which allows for the absence of information without negating the truthfulness of the information that is present.

The CWO can be used for more than metadata creation. As an open model with few restraints it can be used to create the variety of views that meet the needs of the users that a community wishes to serve. A view may not be the same as stored metadata but may be a selection from a larger dataset. A separate work and expression in one application could be a single view in another.

At this point it is also important to say that the definition of the entities does not entail that metadata making use of these concepts must describe each separately as structural elements of the metadata schema.These entities are not defined as disjoint, as they are in FRBR. Disjointness is a restriction that would limit the ways that the entities can be defined and whether they can share attributes. It also makes it difficult to combine metadata using different entity definitions, such as the difference between BIBFRAME’s work-instance-item and RDA’s work-expression-manifestation-item. To require all graphs to have a separation between entities would mean that the WEMI model could not be used in concert with non-WEMI metadata. ([Baker, 2014](https://journal.code4lib.org/articles/#note1)) Such a requirement would create a data silo for any communities using WEMI. Having flexibility, within the necessary ontological commitment, is compatible with the need to share some metadata across communities as well as to facilitate ongoing evolution of information resources.

There is also the possibility of creating other types of relationships between entities, such as work/work or expression/expression relationships. An interesting approach to this was taken by Ross Singer when he defined generic relationships for FRBR Core entities that could be used between any defined entities: *commonEndeavor, commonWork, commonExpression*, etc. These properties are in a dormant area of the [vocab.org](https://vocab.org/open/) namespace and perhaps should be reconsidered as part of the CWO effort.

#### CWO in OWL

Appended to this article is a first pass at an encoding of CWO in OWL. It is also available at [https://github.com/kcoyle/openWEMI](https://github.com/kcoyle/openWEMI). It is expected that this is just a demonstration of the concept, and that, if deemed useful, will be modified and housed at a more stable namespace.

## Conclusion

Perhaps inadvertently the library metadata community has developed a set of classes that resonate for metadata developers in a wide range of topic areas. This non-library use of the FRBR concepts has created a fork of the Group 1 classes of FRBR, primarily through the use of FRBRCore. These applications have, however, inherited some of the built-in constraints of FRBR that were intended for library catalog metadata, and which could lead to unexpected difficulties if inferencing is applied to their metadata. A set of less-constrained classes that are not specific to the library data model should mitigate this problem and also allow for more flexibility in the use of the WEMI concepts. If developers are able to sub-class their created work views to the CWO, we could see more communities embracing a multi-level view for their descriptive metadata.

## About the Author

Karen Coyle has been modeling metadata since 1980, and now interacts with Dublin Core and W3C in metadata standards development.

## Bibliography

[Baker T, Coyle K, Petiya S. 2014](https://journal.code4lib.org/articles/#ref10). Multi-entity models of resource description in the Semantic Web: A comparison of FRBR, RDA and BIBFRAME. Library Hi Tech 32(4): 562-582. [https://doi.org/10.1108/LHT-08-2014-0081](https://doi.org/10.1108/LHT-08-2014-0081).

[Bekiari C, Doerr M, Le Bœuf P, Riva P. 2017](https://journal.code4lib.org/articles/#ref25). FRBR object-oriented definition and mapping from FRBRER, FRAD and FRSAD. Version 3.0 International Working Group on FRBR and CIDOC CRM Harmonisation. September 2017. [https://www.cidoc-crm.org/frbroo/sites/default/files/FRBRoo\_V3.0.pdf](https://www.cidoc-crm.org/frbroo/sites/default/files/FRBRoo_V3.0.pdf).

[Boer A, Hoekstra R, Winkels R. 2002.](https://journal.code4lib.org/articles/#ref19) METALex: Legislation in XML. In: T. Bench-Capon, A. Daskalopulu and R.Winkels (eds.). Legal Knowledge and Information Systems. Jurix 2002: The Fifteenth Annual Conference. Amsterdam: IOS Press, 2002, p. 1-10.

[Boer A, Winkels R, Vitali F. 2008.](https://journal.code4lib.org/articles/#ref22) MetaLex XML and the Legal Knowledge Interchange Format. In: Casanovas P, Sartor G, Casellas N, Rubino R. (eds) Computable Models of the Law. Lecture Notes in Computer Science, vol 4884. Springer, Berlin, Heidelberg.

[Ciccarese P, Peroni S. 2018.](https://journal.code4lib.org/articles/#ref28) Essential FRBR in OWL2 DL. Version 1.0.1. [http://purl.org/spar/frbr](http://purl.org/spar/frbr). Accessed December 14, 2019.

[Coyle K. 2016.](https://journal.code4lib.org/articles/#ref3) FRBR, before and after: a look at our bibliographic models. Chicago : ALA Editions, an imprint of the American Library Association.

[Davis I, Newman, R. 2005](https://journal.code4lib.org/articles/#ref12) Expression of Core FRBR Concepts in RDF. [http://vocab.org/frbr/core.html](http://vocab.org/frbr/core.html). Accessed December 16, 2019.

[Dunsire G. 2008.](https://journal.code4lib.org/articles/#ref13) Declaring FRBR entities and relationships in RDF. [https://www.ifla.org/files/assets/cataloguing/frbrrg/namespace-report.pdf](https://www.ifla.org/files/assets/cataloguing/frbrrg/namespace-report.pdf). Accessed November 18, 2019.

[Gruber TR. 1993.](https://journal.code4lib.org/articles/#ref30) Toward Principles for the Design of Ontologies Used for Knowledge Sharing. In: International Journal Human-Computer Studies 43. p.907-928.

[International federation of library associations and institutions. 1998.](https://journal.code4lib.org/articles/#ref1) Functional requirements for bibliographic records: Final report. München: Saur.

[IFLA Study Group on the Functional Requirements for Bibliographic Records. 2009.](https://journal.code4lib.org/articles/#ref2) Functional Requirements for Bibliographic Records. Den Haag. [http://archive.ifla.org/VII/s13/frbr/frbr\_2008.pdf](http://archive.ifla.org/VII/s13/frbr/frbr_2008.pdf).

[Lima JAO. 2006.](https://journal.code4lib.org/articles/#ref20) An Adaptation of the FRBR Model to Legal Norms. In: Biagioli C, Francesconi E, Sartor G. (eds.) Proceedings of the V Legislative XML Workshop, 2006 European Press Academic Publishing, Italia 2007.

[Lima JAO, Palmirani M, Vitali F. 2008.](https://journal.code4lib.org/articles/#ref21) Moving in the Time: An Ontology for Identifying Legal Resources. In: Casanovas P., Sartor G., Casellas N., Rubino R. (eds) Computable Models of the Law. Lecture Notes in Computer Science, vol 4884. Springer, Berlin, Heidelberg.

[McCusker, JP, Lebo, T, Chang C, McGuinness, DL, da Silva, PP. 2012.](https://journal.code4lib.org/articles/#ref18) Parallel identities for managing open government data. IEEE Intelligent Systems, 27(3), 55. [http://tw.rpi.edu/media/2012/02/07/d641/EX\_ISSI-2011-09-0138.R1\_McCusker.pdf](http://tw.rpi.edu/media/2012/02/07/d641/EX_ISSI-2011-09-0138.R1_McCusker.pdf).

[Palmirani, M., et al. 2018.](https://journal.code4lib.org/articles/#ref23) Akoma Ntoso Version 1.0 Part 1: XML Vocabulary. 29 August 2018. OASIS Standard. [http://docs.oasis-open.org/legaldocml/akn-core/v1.0/akn-core-v1.0-part1-vocabulary.html](http://docs.oasis-open.org/legaldocml/akn-core/v1.0/akn-core-v1.0-part1-vocabulary.html).

[Peroni S, Shotton D. 2012.](https://journal.code4lib.org/articles/#ref15) FaBiO and CiTO: ontologies for describing bibliographic resources and citations. In Journal of Web Semantics, 17: 33-43. [https://doi.org/10.1016/j.websem.2012.08.001](https://doi.org/10.1016/j.websem.2012.08.001). Open Access at: [http://speroni.web.cs.unibo.it/publications/peroni-2012-fabio-cito-ontologies.pdf](http://speroni.web.cs.unibo.it/publications/peroni-2012-fabio-cito-ontologies.pdf).

[Peroni S, Shotton D. 2018.](https://journal.code4lib.org/articles/#ref14) The SPAR Ontologies. In: Vrande?i? D. et al. (eds) The Semantic Web – ISWC 2018. ISWC 2018. Lecture Notes in Computer Science, vol 11137. Springer.

[Peroni S, Vitali F. 2017.](https://journal.code4lib.org/articles/#ref17) Interfacing fast-fashion design industries with Semantic Web technologies. The case of Imperial Fashion. Journal of Web Semantics. 44:37-53. [https://doi.org/10.1016/j.websem.2017.06.001](https://doi.org/10.1016/j.websem.2017.06.00).

[Riva P, Le Boeuf P, Žumer M. 2017.](https://journal.code4lib.org/articles/#ref4) IFLA Library Reference Model: A Conceptual Model for Bibliographic Information. Den Haag, IFLA. [https://www.ifla.org/wp-content/uploads/2019/05/assets/cataloguing/frbr-lrm/ifla-lrm-august-2017\_rev201712.pdf](https://www.ifla.org/wp-content/uploads/2019/05/assets/cataloguing/frbr-lrm/ifla-lrm-august-2017_rev201712.pdf).

[Shotton, D, Peroni, S. 2019.](https://journal.code4lib.org/articles/#ref11) FaBiO, the FRBR-aligned Bibliographic Ontology. v 2.1 [https://sparontologies.github.io/fabio/current/fabio.html](https://sparontologies.github.io/fabio/current/fabio.html). Accessed December 26, 2019.

[Vitali, F, Palmirani, M, Lima, JAO.](https://journal.code4lib.org/articles/#ref24) “Moving in the Time: An Ontology for Identifying Legal Resources ” in: Casanovas P, Sartor G, Casellas N, Rubino R. (eds) Computable Models of the Law. Lecture Notes in Computer Science, vol 4884. Springer, Berlin, Heidelberg, 2008.

## Appendix: openWEMI.ttl

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92 | `@prefix rdf: <http:`  `@prefix rdfs: <http:`  `@prefix owl: <http:`  `@prefix skos: <http:`  `<http:`  `rdfs:label ``"openWEMI ontology"` `.`  `<http:`  `a owl:Class ;`  `rdfs:label ``"endeavour"``@en ;`  `skos:definition ``"The conceptual or intellectual aspect of a creation."``@en ;`  `rdfs:isDefinedBy <http:`  `<http:`  `a owl:Class ;`  `rdfs:label ``"work"``@en ;`  `skos:definition ``"An abstract notion of an artistic or intellectual creation."``@en ;`  `rdfs:isDefinedBy <http:`  `rdfs:subClassOf <http:`  `<http:`  `a owl:Class ;`  `rdfs:label ``"expression"``@en ;`  `skos:definition ``"An expression of a work in signs."``@en ;`  `rdfs:isDefinedBy <http:`  `rdfs:subClassOf <http:`  `<http:`  `a owl:Class ;`  `rdfs:label ``"manifestation"``@en ;`  `skos:definition ``"The physical embodiment of one or more expressions."``@en ;`  `rdfs:isDefinedBy <http:`  `rdfs:subClassOf <http:`  `<http:`  `a owl:Class ;`  `rdfs:label ``"item"``@en ;`  `skos:definition ``"An exemplar of a single manifestation."``@en ;`  `rdfs:isDefinedBy <http:`  `rdfs:subClassOf <http:`  `<http:`  `a owl:Class ;`  `rdfs:label ``"responsible entity"``@en ;`  `skos:definition ``"One responsible for the creation, production, distribution or maintenance of a created entity."``@en  .`  `<http:`  `a rdfs:Property ;`  `rdfs:label ``"related endeavor"``@en ;`  `skos:definition ``"Another endeavor that is related in some way to an endeavor."``@en ;`  `rdfs:isDefinedBy <http:`  `<http:`  `a owl:ObjectProperty ;`  `rdfs:label ``"expresses"``@en ;`  `skos:definition ``"An endeavor that expresses a work."``@en ;`  `rdfs:isDefinedBy <http:`  `rdfs:subPropertyOf <http:`  `rdfs:domain <http:`  `rdfs:range <http:`  `<http:`  `a owl:ObjectProperty ;`  `rdfs:label ``"expresses"``@en ;`  `skos:definition ``"An endeavor that manifests an expression or a work."``@en ;`  `rdfs:isDefinedBy <http:`  `rdfs:subPropertyOf <http:`  `rdfs:domain <http:`  `rdfs:range [`  `a owl:Class ;`  `owl:unionOf (`  `<http:`  `<http:`  `)`  `]  .`  `<http:`  `a owl:ObjectProperty ;`  `rdfs:label ``"expresses"``@en ;`  `skos:definition ``"An endeavor that instantiates a manifestation, an expression or a work."``@en ;`  `rdfs:isDefinedBy <http:`  `rdfs:subPropertyOf <http:`  `rdfs:domain <http:`  `rdfs:range [`  `a owl:Class ;`  `owl:unionOf (`  `<http:`  `<http:`  `<http:`  `)`  `]  .` |
| --- | --- |
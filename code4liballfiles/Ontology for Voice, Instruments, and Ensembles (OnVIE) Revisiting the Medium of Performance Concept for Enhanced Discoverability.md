---
title: "Ontology for Voice, Instruments, and Ensembles (OnVIE): Revisiting the Medium of Performance Concept for Enhanced Discoverability"
source: "https://journal.code4lib.org/articles/16608"
author:
  - "Kimmy Szeto"
published: 2022-08-29
created: 2025-01-10
description: "Medium of performance—instruments, voices, and devices—is a frequent starting point in library users’ search for music resources. However, content and encoding standards for library cataloging have not been developed in a way that enables clear and consistent recording of medium of performance information. Consequently, unless specially configured, library discovery systems do not display medium of performance or provide this access point. Despite efforts to address this issue in the past decade in RDA, MARC, and the linked data environment, medium of performance information continues to be imprecise, dispersed across multiple fields or properties, and implied in other data elements. This article proposes revised definitions for “part,” “medium,” “performer,” and “ensemble,” along with a linked data model, the Ontology for Voice, Instruments, and Ensembles (OnVIE), that captures precise and complete medium of performance data reflecting music compositional practices, performance practices, and publishing conventions. The result is an independent medium of performance framework for recording searchable and machine-actionable metadata that can be hooked on to established library metadata ontologies and is widely applicable to printed and recorded classical, popular, jazz, and folk music. The clarity, simplicity, and extensibility of this model enable machine parsing so that the data can be searched, filtered, sorted, and displayed in multiple, creative ways."
tags:
  - "#ontology"
  - "#OnVIE"
  - "#discoverability"
---
# Ontology for Voice, Instruments, and Ensembles (OnVIE): Revisiting the Medium of Performance Concept for Enhanced Discoverability
[Kimmy Szeto](https://orcid.org/0000-0002-2947-8652)

Medium of performance—instruments, voices, and devices—is a frequent starting point in library users’ search for music resources. However, content and encoding standards for library cataloging have not been developed in a way that enables clear and consistent recording of medium of performance information. Consequently, unless specially configured, library discovery systems do not display medium of performance or provide this access point. Despite efforts to address this issue in the past decade in RDA, MARC, and the linked data environment, medium of performance information continues to be imprecise, dispersed across multiple fields or properties, and implied in other data elements. This article proposes revised definitions for “part,” “medium,” “performer,” and “ensemble,” along with a linked data model, the Ontology for Voice, Instruments, and Ensembles (OnVIE), that captures precise and complete medium of performance data reflecting music compositional practices, performance practices, and publishing conventions. The result is an independent medium of performance framework for recording searchable and machine-actionable metadata that can be hooked on to established library metadata ontologies and is widely applicable to printed and recorded classical, popular, jazz, and folk music. The clarity, simplicity, and extensibility of this model enable machine parsing so that the data can be searched, filtered, sorted, and displayed in multiple, creative ways.

## Introduction

Medium of performance—the instruments, voices, and devices at the library users’ disposal—is a frequent starting point in their search for music resources, and an identifying element of musical works and expressions ([Ostrove, 2001](https://journal.code4lib.org/articles/#note1)). However, the limited availability and functionality of medium of performance as an access point has persisted from the physical card catalog, through the MARC era, into current developments of linked data ontologies.

Uniquely important to music resources, medium of performance refers to the tools involved in expressing a musical work. Historically, the term “medium” is not well defined in cataloging rules, and some instructions and practices are incompatible with linked data modeling practice today. Medium of performance has been recorded as supplemental information in the title area ([Coyle, 2011](https://journal.code4lib.org/articles/#note2)) and in the subject area ([Subject Analysis Committee, 2017](https://journal.code4lib.org/articles/#note3)), and did not receive much attention as an independent data element until the release of the current generation of library cataloging standard Resource Description and Access (RDA) in 2010. Inheriting the basic outline from earlier standards, RDA instructs catalogers to record a list of instruments, voices, and ensembles, followed by the number of parts and total number, and, when necessary, further identifying characteristics.

Cataloging practice continues to treat medium of performance as a single entity. The reality, however, is not as simple. Tracing a musical work from its composition to performance, subsumed in what is broadly termed “medium of performance” is a network of relationships involving the composer (musical parts), the publisher (published scores and parts), the instruments/voices (mediums), the performers, and the ensembles. From the library users’ standpoint, the single list of instruments/voices and numbers in the data does not always match the score and parts in the actual publication, and often does not provide enough information about the specific instruments, devices, and players required for planning a reading or a performance.

While these more complex relationships pose a challenge for the MARC format to encode, linked data models offer the capability. Linked data —a set of technologies and practices that foster publishing and connecting structured data on the web— have been increasingly embraced in the past decade by the library community as a means to provide open access to its richly curated bibliographic catalogs. Although some attempts have been made to refine the medium of performance element in linked data models, such as in the Performed Music Ontology (PMO), so far, no library linked data model has been built out beyond alignment with RDA/MARC format and conversion of existing data.

In the context of expanding the conception of the medium of performance element, this article lays out broadened definitions for “part,” “performer” and “ensemble” as described in [Szeto (2017)](https://journal.code4lib.org/articles/#note4), proposes a revised definition for the term “medium,” and, based on these revised definitions, presents a new data model, the Ontology for Voices, Instruments, and Ensembles (OnVIE). OnVIE gives medium of performance additional dimensions by simultaneously capturing and relating the composer’s intended performing forces, published parts, specific instruments, voices, and devices required/used, as well as specific performers. The clarity, simplicity, and extensibility of this model enable more nuanced machine parsing so that the data can be searched and displayed in multiple, creative ways.

## Modeling Medium of Performance

This paper will first discuss the development of OnVIE in the context of RDA, the current content standard, as encoded in MARC field 382. The next section will turn to the Performed Music Ontology, an extension for music resources specifically developed as an extension for BIBFRAME, the general linked data model being developed for library bibliographic data to replace MARC.

### Recent Cataloging Practice

Prior to the 2000s, the tripartite division of author, title, and subject of the card catalog resulted in cataloging rules and decades of practices that embedded medium of performance information in the uniform title when it is necessary to distinguish between identical titles and in subject heading form subdivisions ([Elmer, 1960](https://journal.code4lib.org/articles/#note5)). The MARC format did offer field 048 for medium of performance, but the fields held only codes and numbers for voices, instruments, and ensembles, which were not readily decipherable to catalogers and users alike. This coded field fell into disuse, and users mainly relied on a free text note and clues from the title and subject headings. The dispersal of structured data complicated display and indexing, resulting in a limited ability for users to search directly or filter medium of performance search results ([Subject Analysis Committee, 2017](https://journal.code4lib.org/articles/#note3)). This is particularly problematic for compilations, vocal music, folk music, jazz, and recorded popular music where medium of performance is generally not explicitly stated bibliographically ([Newcomer et al., 2013, section II.D](https://journal.code4lib.org/articles/#note6)).

These limitations led to coordinated efforts to raise the visibility of this data element. In 2007, the Library of Congress, collaborating with a range of stakeholders, initiated developments in three areas: a dedicated faceted vocabulary Library of Congress Medium of Performance Thesaurus (LCMPT) was launched in 2014 ([Library of Congress, 2014](https://journal.code4lib.org/articles/#note7)), a new MARC field 382 for an expanded encoding of medium of performance data based on RDA instructions was established in 2010 ([Library of Congress, 2020](https://journal.code4lib.org/articles/#note8)), and programmatic changes that extracted existing authority data from the uniform title to be placed into the 382 field took place on WorldCat ([Library of Congress, 2012](https://journal.code4lib.org/articles/#note9)). With these three areas in place, programmatic retrospective implementation of faceted vocabulary in both authority and bibliographic records continues to this day ([Mullin, 2018](https://journal.code4lib.org/articles/#note10); [Subject Analysis Committee, 2022](https://journal.code4lib.org/articles/#note11)).

Below is an excerpt from a MARC record on WorldCat ([OCLC number 989164116](https://journal.code4lib.org/articles/#note12)) that illustrates how medium of performance information is recorded in the uniform title (field 240) and the subject headings (field 650) and coded in fields 048 and 382. It might not be immediately apparent, from the way the uniform title and subject headings are constructed and structured, that this record is based on a musical score for solo harpsichord with piano accompaniment. (There is no string orchestra!) What might (or might not!) help library users is the note in field 500, a phrase typically used for this situation in music cataloging practice. Unfortunately, the note is not present in the actual WorldCat record, but was added here by the author to illustrate the difficulties posed to human readers and computer algorithms alike. The issue with clarity of semantics was identified and critiqued in Coyle ([2011](https://journal.code4lib.org/articles/#note2)), and the retrospective implementation of LCMPT and field 382 to address this issue was detailed in Mullin ([2018](https://journal.code4lib.org/articles/#note10)).

```
048 ##  $b kc01 $a ka01
240 10  $a Concertos, $m harpsichord, string orchestra, $n BWV 1052, $r D minor; $o arranged
382 01  $b harpsichord $n 1 $a piano $n 1 $s 2 $2 lcmpt
500 ##  $a Acc. arr. for piano. 
650 #0  $a Concertos (Harpsichord with string orchestra) $v Solo with piano.
```

### Data Modeling Considerations

While these efforts have enabled structured medium of performance data in bibliographic records using LCMPT as the controlled vocabulary, the implementation remains less than ideal. RDA inherited the broad outlines from earlier standards—”the instrument, instruments, voice, voices, etc. for which a musical work was originally conceived” ([RDA 6.15.1.1](https://journal.code4lib.org/articles/#note13)), and then “record each instrument…” ([RDA 6.15.1.4](https://journal.code4lib.org/articles/#note13)) or “record an/the appropriate term…” that groups instruments and voices by family or into an ensemble ([RDA 6.15.1.6 to 6.15.1.10](https://journal.code4lib.org/articles/#note13)). These terms, depending on their characteristics, are encoded in MARC 382 subfields $a, $d, $d, and $p. After each term, RDA instructs the cataloger to record the number of parts ([RDA 6.15.1.3](https://journal.code4lib.org/articles/#note13)). This number is then encoded in MARC 382 subfields $e, $n or $r, which are defined for the number of performers or ensembles. In addition, MARC 382 offers subfields $s and $t for the total numbers of performers and ensembles.

This practice creates some data subfields that are not unambiguous in some cases and not atomic in some others. In the course of resolving ambiguity and atomicity issues, two fundamental principles of linked data design for the semantic web, it became apparent that separate definitions for part, medium, performer, and ensemble could offer the overarching solution.

#### Ambiguity and Atomicity Issues

The RDA instruction to record the number of “parts” which is then encoded in the “number of performers” subfield $n in MARC field 382 creates a semantic ambiguity. The OnVIE model will treat part and performer as two separate concepts. Another conflation occurs in the usage of terms such as “percussion” and “continuo” as mediums, when these mediums are actually parts referring to a group of instruments. The OnVIE model will provide clarity by allowing the individual instruments to be linked to these parts.

Another ambiguous practice is conflating individual instruments/voices with ensembles, and encoding them in the same MARC subfields, even though ensembles are not themselves instruments or voices. However, it is not always clear what exactly forms an ensemble. Is the string quartet an ensemble of instruments? Is it a group of performers? Or is it a group of parts? In the OnVIE model, individual parts are used as the starting point, and a group of parts will form an ensemble. This way, all of the ensemble’s constituent parts will always be known, as will the mediums be linked to each part.

Separate instructions are given in RDA for music intended for one performer to a part as opposed to more than one performer to a part. The attributes of “solo” and “accompaniment” are also treated separately. However, these are not characteristics of the mediums, but are characteristics of the parts. (For example, the instrument violin itself cannot possess the quality of “solo” but a violin part can.) In OnVIE, the number of performers to a part, the solo status, and the accompaniment status will all be treated as refinements to the part, rather than as separate classes of entities.

More specifically, RDA instructs the cataloger to omit the accompanying keyboard instrument (such as a piano) in a classical song for solo voice ([RDA 6.15.1.11](https://journal.code4lib.org/articles/#note13)). While the piano is not an unreasonable assumption among musicians, such an arbitrary exception causes the discovery system to return incomplete results, which could complicate a library user’s search, especially for a vocalist looking for repertoire regardless of the accompaniment.

#### Special Issue: Number of Hands

RDA instructs the “number of hands,” if other than two, to be recorded ([RDA 6.15.1.5.1](https://journal.code4lib.org/articles/#note13)). This poses an impossibility in the encoding mechanism in MARC field 382. While the number of performers is encoded in subfield $n, there is nowhere to encode the number of instruments, or which hand is being used. While “piano, 4 hands,” where two pianists use all four hands on a single piano, is a fairly common genre, piano duets—two pianos and two pianists—is not uncommon either, especially in more recent repertoire with the two pianos tuned a quarter tone apart (for example, *Chiaroscuro for two pianos (one tuned down a 1/4 tone)* by John Corigliano ([published 2011](https://journal.code4lib.org/articles/#note14))). Yet these are encoded identically as “$a piano $n 2,” and library users will need to inspect the free text notes, the subject heading, or the title. Suppose a piece of music was composed for two pianos with two players, each using only the left hand, or, suppose another piece of music was composed for two pianos with two players, one using both hands, the other using only the left hand, the result is still the same: “$a piano $n 2.” Figure 1, adapted from Szeto ([2016, slide 22](https://journal.code4lib.org/articles/#note15)), further illustrates this issue with combinations of two pianos and six hands. Meanwhile, a piece of music composed for two pianos and one player (for example, *Trois hommages for 2 pianos (tuned a quarter tone apart) 2 hands* by Georg Friedrich Haas ([published 2009](https://journal.code4lib.org/articles/#note16))) would be encoded as “$a piano $n 1,” identical to solo piano music (one piano, one player).

![](https://journal.code4lib.org/media/issue54/szeto/figure1.png)

**Figure 1.** Combinations of pianos and hands that cannot be differentiated in RDA descriptions or encoded in MARC field 382.

At present, when these distinctions, or any other distinctions discussed above, cannot be expressed in the MARC 382 field, the cataloger is instructed to provide clarification in a free text note in subfield $v. In the OnVIE model, separate treatments for part and performer will remove this issue.

#### Additional RDA Medium of Performance Characteristics

RDA includes instructions for three more attributes: pitch and range of instruments, doubling, and alternative.

##### Pitch and Range

The “pitch” of the instrument here refers to musical instruments that are “transposed,” where playing with the same set of fingering and sound production techniques on the instrument yields a different set of pitches (for example, clarinet in B-flat). What RDA referred to as “range” refers to instruments that come in common sizes (for example, the saxophone family includes soprano, alto, tenor, and baritone). Pitch and range are recorded only when the cataloger considers them important for identification and access ([RDA 6.15.1.5.1](https://journal.code4lib.org/articles/#note13)) and appears in MARC field 382 as a free text note in subfield $v. The OnVIE model will include further refined properties for these, applied separately to parts and mediums.

##### Doubling

Instrumental doubling refers to a musical part that instructs a single performer to use more than one instrument. When recorded, the medium is encoded in MARC 382 subfield $d. This structure seems straightforward for a traditional orchestral doubling, such as a flute player who also plays the piccolo. This is not so straightforward for other parts that are less clearly defined, for example, an orchestral percussion part where multiple players share a set of percussion instruments, or where a timpani player occasionally joins other percussionists (timpani is recorded separately from percussion). Currently, the instruction is to record the term “percussion” alone. Neither RDA nor MARC offers a solution for this entanglement between performers, mediums, and parts. Separating them in the OnVIE model will remove this issue.

##### Alternative

RDA instructions for “alternative instruments” ([RDA 6.15.1.5.3](https://journal.code4lib.org/articles/#note13)) invite further refinement. In current practice, “alternative” is used for a range of situations where one or more mediums deviate from the original. While some composers expressly indicate that the identical part may be used on more than one instrument (for example, the “Flute or Violin” part in the jazz composition *Out of the Cool* by David Heath ([as published in 1986](https://journal.code4lib.org/articles/#note17))), in most cases, what are also considered alternatives range from slightly different (for example, clarinet music transcribed for the viola; see [Swanson, 2003, pp. 13-15](https://journal.code4lib.org/articles/#note18) for the process of compiling the repertoire list which could have been aided by a direct medium of performance search), to quite different (for example, a continuo part realized for piano), to drastically different (for example, orchestra music in operatic works arranged for piano with no change in the vocal parts). The OnVIE model will be able to precisely indicate the first case where the part is identical, and a hook is provided for future extensions that capture the various degrees of change. There are also situations where the alternative involves a role change in one or more parts (for example, the arrangements of the *Scherzo* movement in Robert Schumann’s second symphony (as published in Szeto, [2010a](https://journal.code4lib.org/articles/#note19) and [2010b](https://journal.code4lib.org/articles/#note20)) where the first violin part could be a solo part or an ensemble part; the arrangement of the overture to Leoš Janácek’s *From the House of the Dead* (as published in [Szeto, 2013](https://journal.code4lib.org/articles/#note21)), where the violin part changed to solo and the trumpet part could optionally be offstage). Currently, data cannot be simultaneously encoded as alternative (in $p) and as solo (in $b) in MARC field 382, whereas OnVIE imposes no restrictions on these refinements. Equally important is the consideration of whether the alternative is so different that the music should be considered a separate musical expression or an entirely new musical work. This is outside the scope of this article but was discussed in more detail in [Szeto (2017)](https://journal.code4lib.org/articles/#note4), and the data modeling is an active area of investigation under various keywords such as music information retrieval, arrangement, versions, and annotation ([Weiß et al., 2021](https://journal.code4lib.org/articles/#note22); [Lewis et al., 2022](https://journal.code4lib.org/articles/#note23)).

More specifically, the Library of Congress Policy Statements for [RDA 6.18.1.4](https://journal.code4lib.org/articles/#note13) instructs catalogers whether or not to consider alternatives or arrangements in a range of conditions, such as slight alterations to instrumentation in an orchestral piece, early music composed before 1800 performed on modern instruments, and a change from vocal to instrumental in the popular music idiom. While such practices to make an either/or judgment are essential for the classification and collocation of physical materials, the OnVIE model will remove much of these artificial criteria by simply allowing all parts and mediums to be recorded completely and precisely.

Another common situation is alternative voices (such as a song for soprano sung by a tenor, or for alto sung by a bass). This is an ambiguity issue where the voice part is the same but the property of the medium differs. In the OnVIE model, soprano/alto/tenor/bass can be indicated as refinements to the medium “voice.”

### BIBFRAME and the Performed Music Ontology

The Bibliographic Framework Initiative (BIBFRAME) is a Library of Congress initiative to develop a linked data alternative to MARC. The Library of Congress initially worked with the Music Library Association to model the medium of performance element but later abandoned the effort. Instead, the BIBFRAME model left “hooks” for a full model to be developed by a third party ([Szeto et al., 2016, p. 32](https://journal.code4lib.org/articles/#note24)).

In response, the Performed Music Ontology ([PMO, 2021](https://journal.code4lib.org/articles/#note25)) was developed as an extension of the BIBFRAME ontology with a focus on describing performed music. The medium of performance portion of the PMO model tracks closely with RDA and MARC practices. PMO begins with making the distinction between the declared medium, which is stated by the composer or in a reference source, and the performed medium, which was used in the actual performance and not necessarily the same as the declared medium. The PMO has separate properties for individual and ensemble mediums, a separate class for “part,” as well as properties to connect performers to their instruments, voices, and dramatic roles. However, PMO follows RDA instructions where solo, alternative, and doubling are separately addressed, while other attributes are recorded as literals (free text) in a single catch-all “part type” property. The OnVIE model will break away from the RDA/MARC structure, and will provide an extensible structure for characteristics to be encoded as linked data with clear semantics.

Unlike PMO where medium of performance classes depend on linking to the parent ontology at multiple points (*bf:NotatedMusic* for *pmo:DeclaredMedium*, *bf:Audio* for *pmo:PerformedMedium*, *bf:Contribution* for the *pmo:IndividualMOP* and *pmo:MusicPart*), the OnVIE model exists in a self-contained, independent space requiring only a single “hook” to the musical resource being described. The first contact on this hook is “Parts.” By beginning with this layer, the OnVIE model no longer requires differentiation between mediums that were notional or actual.

## A New Data Model for Medium of Performance

### Ontology for Voice, Instruments, and Ensembles

The primary motivation, and innovation, of the OnVIE model is capturing the relationship between part, medium, performer, and ensemble, which form the four main classes of the ontology. The first three main classes follow a loop: Part connects to Medium, Medium connects to Performer, and Performer loops back to Part. The class Ensemble forms a branch by grouping one or more Part entities. These relationships are shown in Figure 2.

![](https://journal.code4lib.org/media/issue54/szeto/figure2.png)

**Figure 2.** Class relationships in the Ontology for Voice, Instruments, and Ensembles.

All further refinements to the model fall within this framework. The list of refinements presented here consists of data that are currently recorded in cataloging practice, fixes to known issues, with many more properties that cover characteristics of specifical musical settings, parts, instruments, voices, devices, etc. OnVIE’s simple framework allows it to be readily extensible through additional refinements.

### Definitions

#### Part

Class: MusicPart  
Scope: a series of musical events, abstracted from a musical work/expression, generally independent from other such abstractions from the same musical work/expression, which holds a consistent association with one or more mediums and/or performers  
Note: A part is not equivalent to, but may be related to, a “printed part” (sheet music for an individual voice/instrument that does not contain notation for other voices/instruments of an ensemble), or a “voice” or “line” (individual melodies of polyphonic musical composition)  
Examples: “Violin” ; “Percussion” ; “Mezzo-Soprano” ; “Horns”

#### Medium

Class: MusicMedium  
Scope: a tool of sound production for a musical work/expression  
Note: Mediums include human voices, musical instruments, devices, and other means  
Examples: “violin” ; “marimba” ; “voice” ; “saxophone” ; terms in LCMPT and UNIMARC codes for individual voice, instruments, and devices

#### Performer

Class: MusicPerformer  
Scope: an agent responsible for expressing or actuating one or more parts  
Note: Performers include humans, machines, computers, and other entities  
Examples: “Violinist” ; “Percussionist” ; “Vocalist” ; “Saxophonist” ; entities referring to actual persons in vocabularies such as LCNAF and VIAF

#### Ensemble

Class: MusicEnsemble  
Scope: a group of parts in a musical work/expression  
Note: in this model, only part groupings are used, even for ensembles traditionally known for the personas or the instruments (for example, string quartet)  
Examples: “Orchestra” ; “Percussion quartet” ; “Children’s choir” ; “Jazz combo” ; ensemble terms in LCMPT and UNIMARC codes ; LCNAF, VIAF, or other vocabularies for names

### Classes and Properties

The OnVIE model is built with the library users’ starting point in mind: the instruments, voices, and devices (class MusicMedium). The connecting layer between the medium and the music resource is the concept of “part” (class MusicPart). The term “part” has been occasionally used in definitions and instructions, and occasionally conflated with voices, instruments, and performers, as discussed above. Here, a new definition has been developed for this layer, distinct from MusicMedium and MusicPerformer.

The OnVIE model begins with at least one MusicPart. A MusicPart can link to other MusicPart entities when alternatives or further subdivisions are present, or can link to printed published parts which could differ. Every MusicPart is required to have at least one MusicMedium, even if it is unmediated (such as a spectator). MusicPart can link to more than one entity in MusicMedium, such as in the case of instrumental doubling or a single percussion part calling for multiple instruments. For musical scores, it ends here. For performed music, including popular, folk, and jazz that exist only as sound recordings, performers (class MusicPerformer) are linked from MusicMedium, and each MusicPerformer loops back to one or more entities in MusicPart.

Ensembles are not considered mediums, but are a separate class (class MusicEnsemble), formed by an aggregate of individual parts. This departure from current cataloging practice prevents ensemble terms from being used as mediums, but rather encourages a complete accounting of mediums involved.

The four main properties of this model connect these classes. Refinements are provided to describe each in further detail. The list of refinement properties presented here was drawn from the current models as well as from the author’s own experience as an ensemble librarian, and is by no means exhaustive.

What is not included in this model are the numbers. Rather than requiring catalogers and metadata creators to supply the number of parts, performers, and ensembles, the granularity of the model enables linked data interpreter software to perform the counting. This method not only provides the flexibility to produce separate counts for parts, mediums, performers, and ensembles, it also removes the uncertainty and detailed analysis (or guesswork!) required to arrive at the number of performers needed for group-oriented parts such as percussion and continuo. By interpreting the refinements, machine counting can also provide the total, as well as further numerical breakdowns for soloists, accompanying performers, ensembles, and voice/vocal parts.

### The Ontology

**Table 1.** Classes.

| Class | Subclass of |
| --- | --- |
| MediumOfPerformance | Musical Works/Expressions |
| MusicMedium | MediumOfPerformance |
| MusicPart | MediumOfPerformance |
| MusicPerformer | MediumOfPerformance |
| MusicEnsemble | MediumOfPerformance |

**Table 2.** Properties.

| Property | Use with | Expected value |
| --- | --- | --- |
| hasMusicPart | MediumOfPerformance ; MusicPart | MusicPart |
| isMusicPartOf | MusicPart | MusicPart ; MediumOfPerformance |
|  |  |  |
| hasMusicMedium | MusicPart | MusicMedium |
| isMusicMediumOf | MusicMedium | MusicPart |
|  |  |  |
| hasMusicPerformer | MusicMedium | MusicPerformer |
| isMusicPerformerOf | MusicPerformer | MusicMedium |
|  |  |  |
| isResponsibleForMusicPart | MusicPerformer | MusicPart |
| isPerformedBy | MusicPart | MusicPerformer |

**Table 3.** Refinements.

| Property | Use with | Expected value | Notes | Examples |
| --- | --- | --- | --- | --- |
| rdfs:label | MediumOfPerformance ; MusicPart ; MusicMedium ; MusicEnsemble | literal |  |  |
| xml:lang | MediumOfPerformance ; MusicPart ; MusicMedium ; MusicEnsemble | URI | Language code of the term |  |
| source | MediumOfPerformance ; MusicPart ; MusicMedium ; MusicEnsemble | URI | Source of information |  |
| sourceType | MediumOfPerformance ; MusicPart ; MusicMedium ; MusicEnsemble | “transcribed” ; “recorded” ; “published” ; “inferred” ; “editorial” ; “programmatic update” ; etc. |  |  |
| sourceNote | MediumOfPerformance ; MusicPart ; MusicMedium ; MusicEnsemble | literal |  | “First page of music” |
|  |  |  |  |  |
| alternative | MediumOfPerformance ; MusicPart ; MusicMedium ; MusicEnsemble | “Is alternative” ; “Is not alternative” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| alternativeType | MediumOfPerformance ; MusicPart ; MusicMedium ; MusicEnsemble | URI | \* hook for the full consideration of types of musical alternation/arrangement/transcription/adaptation |  |
| alternativeNote | MediumOfPerformance ; MusicPart ; MusicMedium ; MusicEnsemble | literal |  | “identical” ; “arranged for viola” ; “transcribed for solo piano” \[concerto, jazz\] ; “piano reduction” \[orchestral accompaniment\] ; “adapted for the violin” \[folk music\] ; “combined percussion part for one player” |
|  |  |  |  |  |
| partNumber | MusicPart | whole number >=0 |  | “Violin 1” ; “Percussion 2” |
| playerToAPart | MusicPart | “Specified” ; “Multiple” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| playerToAPartNumber | MusicPart | whole number >=0 |  |  |
|  |  |  |  |  |
| solo | MusicPart ; MusicMedium ; MusicEnsemble | “Is solo” ; “Is not solo” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| accompaniment | MusicPart ; MusicMedium ; MusicEnsemble | “Is an accompaniment” ; “Is not an accompaniment” |  |  |
|  |  |  |  |  |
| optional | MusicPart ; MusicMedium | “Is optional” ; “Is not optional” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| ad lib | MusicPart ; MusicMedium | “Is ad lib” ; “Is not ad lib” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| offstage | MusicPart ; MusicMedium | “Is offstage” ; “Is not offstage” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| obligato | MusicPart ; MusicMedium | “Is an obligato part” ; “Is not an obligato part” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
|  |  |  |  |  |
| amplified | MusicPart ; MusicMedium | “Is amplified” ; “Is not amplified” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| prerecorded | MusicPart ; MusicMedium | “Is prerecorded” ; “Is not prerecorded” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
|  |  |  |  |  |
| periodInstrument | MusicPart ; MusicMedium | “Is a period instrument” ; “Is not a period instrument” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| periodInstrumentNote | MusicPart ; MusicMedium | URI or literal |  | “Baroque” \[flute\] |
| fingeringSystem | MusicPart ; MusicMedium | URI |  | “German” \[recorder\] |
|  |  |  |  |  |
| tuningSystem | MusicPart ; MusicMedium | URI |  | “Just intonation” ; “pythagorean” ; “equal temperament” |
| tuningReferencePitch | MusicPart ; MusicMedium | URI | The pitch name of the tuning reference pitch. | “A” |
| tuningReferenceFrequencyHz | MusicPart ; MusicMedium | number >=0 | The frequency of the tuning reference pitch in hertz. | “432” |
| scordatura | MusicPart ; MusicMedium | “Is tuned scordatura” ; “Is not tuned scordatura” ; “Performer’s choice” ; “Unspecified” ; “Unknown” | Tuning of a western string instrument which deviates from the standard tuning. |  |
| tuningNote | MusicPart ; MusicMedium | literal |  | “Piano is tuned quarter tone flat” ; “Drop D” \[guitar\] |
|  |  |  |  |  |
| handsNumber | MusicPart ; MusicMedium | whole number >=1 | Number of hands playing an instrument |  |
| handsSide | MusicPart ; MusicMedium ; MusicPerformer | “Left” ; “Right” ; “Performer’s choice” ; “Unspecified” ; “Unknown” | Which hand is being used for playing an instrument |  |
| handsNote | MusicPart ; MusicMedium ; MusicPerformer | literal |  | “piano (2), 3 hands” |
|  |  |  |  |  |
| doubleBassCExtension | MusicPart ; MusicMedium | “Requires a C Extention” ; “Does not requires a C Extension” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| fluteBFoot | MusicPart ; MusicMedium | “Requires a B Foot” ; “Does not require a B Foot” ; “Performer’s choice” ; “Unspecified” ; “Unknown” |  |  |
| instrumentMute | MusicPart ; MusicMedium | URI |  |  |
| instrumentMuteNote | MusicPart ; MusicMedium | literal |  |  |
| instrumentDimension | MusicPart ; MusicMedium | URI | \* hook for measurements of musical instruments |  |
| instrumentDimensionNote | MusicPart ; MusicMedium | literal |  | “26 inch” \[timpani\] |
| instrumentSize | MusicPart ; MusicMedium | URI | \* hook for instrument sizes |  |
| instrumentSizeNote | MusicPart ; MusicMedium | literal |  | “Three-quarter” \[guitar\] ; “Concert” \[ukelele\] |
|  |  |  |  |  |
| instrumentPitch | MusicPart ; MusicMedium | URI | Pitch of single-pitched musical instruments | “C4” \[crotale\] |
| instrumentTransposition | MusicPart ; MusicMedium | URI | Key of transposing instruments | “A” \[clarinet\] |
| instrumentTranspositionNote | MusicPart ; MusicMedium | literal |  | “Clarinet in A” |
| instrumentRangeNumber | MusicPart ; MusicMedium | whole number >=0 | Pitch range of a musical instrument in number of half steps | “60” \[marimba\] |
| instrumentRangeLowest | MusicPart ; MusicMedium | URI | Lowest pitch of a musical instrument | “C2” \[marimba\] |
| instrumentRangeHighest | MusicPart ; MusicMedium | URI | Highest pitch of a musical instrument | “C7” \[marimba\] |
| instrumentNote | MusicPart ; MusicMedium | literal |  | “5 octaves” \[marimba\] |
|  |  |  |  |  |
| voiceType | MusicPart ; MusicMedium | URI |  | “Mezzo soprano” ; “Contralto” |
| voiceWeight | MusicPart ; MusicMedium | URI |  | “Spinto” ; “Soubrette” |
| voiceTessitura | MusicPart ; MusicMedium | URI |  | “High” ; “Medium” ; “Low” |
| voicePitchLowest | MusicPart ; MusicMedium | URI | Lowest pitch required of the vocalist |  |
| voicePitchHighest | MusicPart ; MusicMedium | URI | Highest pitch required of the vocalist |  |
| voiceNote | MusicPart ; MusicMedium | literal |  |  |
|  |  |  |  |  |
| technicalRequirement | MusicPart ; MusicMedium | URI | \* hook for computer / recording carrier / playback device information |  |
| technicalRequirementNote | MusicPart ; MusicMedium | literal |  | “Requires an 8 track player” |

## Next Steps

With the OnVIE model laid out conceptually in this paper, the next steps would be to formalize the ontology with modeler software, and, with the help of the library community, integrate into library linked data editors and test a range of use cases to further fine tune semantics, data constraints, and documentation. In the course testing, standardized vocabularies can be developed for the many characterizations in the list of refinements, possibly in alignment with open platforms such as Wikidata. Some suggestions for these “hooks” can be found in the “Notes” column in Table 3. Finally, pathways to publishing and maintaining the ontology can be explored.

Further analysis can be made in relation to the UNIMARC encoding standard, as well as to library-adjacent ontologies such as DoReMus, developed for analysis and visualization of music data, the Music Ontology, which focuses on capturing production of musical events, and MusicBrainz, which is widely used for sound recordings. As none of these ontologies currently includes a model built out for medium of performance, developing a mechanism to hook OnVIE on to them would be a worthwhile investigation. Another potentially fruitful area of study would be to align MusicParts in OnVIE with other ontologies where the concept is also used, such as the “Observations” object in the “Musicological Objects” layer in Lewis et al. ([2022](https://journal.code4lib.org/articles/#note20)).

## Conclusion

Although linked data are designed to be machine-actionable, it is humans who ultimately employ the mediums with their voices, instruments, and other tools, to create music. It is also humans who are ultimately responsible for expressing and actuating each part of a musical work. This new Ontology for Voices, Instruments, and Ensembles, when hooked on to linked data bibliographic systems, will enable a medium of performance access point at a fine level of precision and completeness. Library users will be provided a more straightforward path not only toward identifying and selecting music resources, but also toward discovering additional insights into the evolution of performing forces in the history of music making, a whole new area of humanistic studies previously hidden in plain sight.

## Bibliography

[Corigliano, J. (2011)](https://journal.code4lib.org/articles/#ref14). Chiaroscuro: For two pianos (one tuned down a 1/4 tone) (ED 4435, HL 50490191). G. Schirmer.

[Coyle, K. (2011)](https://journal.code4lib.org/articles/#ref2). MARC as metadata: A start. Code4lib Journal, 14. [https://journal.code4lib.org/articles/5468](https://journal.code4lib.org/articles/5468).

[Elmer, M. (1960)](https://journal.code4lib.org/articles/#ref5). The music catalog as a reference tool. Library Trends, 8(4), 529-538. [https://www.ideals.illinois.edu/bitstream/handle/2142/5907/librarytrendsv8i4f\_opt.pdf](https://www.ideals.illinois.edu/bitstream/handle/2142/5907/librarytrendsv8i4f_opt.pdf).

[Haas, G. F. (2009)](https://journal.code4lib.org/articles/#ref16). Trois hommages: Für zwei Klaviere (im Vierteltonabstand gestimmt) zu zwei Händen (1982/84) (UE 34 693). Universal Edition.

[Heath, D. (1986)](https://journal.code4lib.org/articles/#ref17). Out of the cool: For flute (or violin) and piano (CH55693). Chester Music.

[Lewis, D., Shibata, E., Saccomano, M., Rosendahl, L., Kepper, J., Hankinson, A., Siegert, C., and Page, K. (2022)](https://journal.code4lib.org/articles/#ref23). A model for annotating musical versions and arrangements across multiple documents and media. In 9th International Conference on Digital Libraries for Musicology (DLfM2022) (pp. 10-18). Association for Computing Machinery. [https://doi.org/10.1145/3543882.3543891](https://doi.org/10.1145/3543882.3543891).

[Library of Congress. (2012)](https://journal.code4lib.org/articles/#ref9). Summary of programmatic changes to the LC/NACO Authority File: What LC-PCC RDA catalogers need to know. [https://www.loc.gov/aba/rda/pdf/lcnaf\_rdaphase.pdf](https://www.loc.gov/aba/rda/pdf/lcnaf_rdaphase.pdf).

[Library of Congress. (2014)](https://journal.code4lib.org/articles/#ref7). Library of Congress launches Medium of Performance Thesaurus for music. [https://www.loc.gov/catdir/cpso/medprf-list-launch.html](https://www.loc.gov/catdir/cpso/medprf-list-launch.html).

[Library of Congress. (2020)](https://journal.code4lib.org/articles/#ref8). Content designator history. In 382 – Medium of Performance. [https://www.loc.gov/marc/bibliographic/bd382.html](https://www.loc.gov/marc/bibliographic/bd382.html).

[Mullin, C. (2018)](https://journal.code4lib.org/articles/#ref10). An amicable divorce: Programmatic derivation of faceted data from Library of Congress Subject Headings for music. Cataloging & Classification Quarterly, 56(7), 607-627. [https://doi.org/10.1080/01639374.2018.1516709](https://doi.org/10.1080/01639374.2018.1516709).

[Newcomer, N. L., Belford, R., Kulczak, D., Szeto, K., Matthews, J., & Shaw, M. (2013)](https://journal.code4lib.org/articles/#ref6). Music discovery requirements: A guide to optimizing interfaces. Notes, 69(3), 494-524. [http://dx.doi.org/10.1353/not.2013.0017](http://dx.doi.org/10.1353/not.2013.0017).

[Online Computer Library Center. (2022, May 24)](https://journal.code4lib.org/articles/#ref12). OCLC 989164116. A publicly accessible version of this record as imported by University of California, Berkeley can be retrieved at [https://search.library.berkeley.edu/discovery/sourceRecord?vid=01UCS\_BER:UCB&docId=alma991033194509706532&recordOwner=01UCS\_NETWORK](https://search.library.berkeley.edu/discovery/sourceRecord?vid=01UCS_BER:UCB&docId=alma991033194509706532&recordOwner=01UCS_NETWORK).

[Ostrove, G. E. (2001)](https://journal.code4lib.org/articles/#ref1). Music subject cataloging and form/genre implementation at the Library of Congress. Cataloging & Classification Quarterly, 32(2), 91-106. [https://doi.org/10.1300/J104v32n02\_08](https://doi.org/10.1300/J104v32n02_08).

[Performed Music Ontology: Documentation (2021, May 6)](https://journal.code4lib.org/articles/#ref25). [https://github.com/LD4P/PerformedMusicOntology/tree/main/Documentation](https://github.com/LD4P/PerformedMusicOntology/tree/main/Documentation).

[RDA Toolkit. (2022)](https://journal.code4lib.org/articles/#ref13). American Library Association. [https://access.rdatoolkit.org/](https://access.rdatoolkit.org/).

[Subject Analysis Committee. (2017)](https://journal.code4lib.org/articles/#ref3). A Brave New (Faceted) World: Towards Full Implementation of Library of Congress Faceted Vocabularies. Association for Library Collections & Technical Services. [http://hdl.handle.net/11213/8146](http://hdl.handle.net/11213/8146).

[Subject Analysis Committee. (2022)](https://journal.code4lib.org/articles/#ref11). Retrospective Implementation of Library of Congress Faceted Vocabularies. Association for Library Collections & Technical Services. [http://hdl.handle.net/11213/17998](http://hdl.handle.net/11213/17998).

[Swanson, C. M. (2003)](https://journal.code4lib.org/articles/#ref18). Adding to the viola repertoire by arranging: A study on methods of arranging music for viola from clarinet, with an original arrangement of the Saint-Saens Clarinet Sonata in E-flat, Op. 167 (UMI number: 3107045) \[Doctoral dissertation, University of Arizona\]. ProQuest Information and Learning. [http://hdl.handle.net/10150/280389](http://hdl.handle.net/10150/280389).

[Szeto K. (2010a)](https://journal.code4lib.org/articles/#ref19). Concerto for violin and chamber ensemble arranged after Robert Schumann’s Scherzo from symphony no. 2. Alexander Street Press Classical Scores Library, Volume IV. [https://search.alexanderstreet.com/preview/work/bibliographic\_entity%7Cscore%7C3643958](https://search.alexanderstreet.com/preview/work/bibliographic_entity%7Cscore%7C3643958).

[Szeto K. (2010b)](https://journal.code4lib.org/articles/#ref20). Robert Schumann’s symphony no. 2 in C major arranged for chamber ensemble. Alexander Street Press Classical Scores Library, Volume IV. [https://search.alexanderstreet.com/preview/work/bibliographic\_entity%7Cscore%7C3643956](https://search.alexanderstreet.com/preview/work/bibliographic_entity%7Cscore%7C3643956).

[Szeto K. (2013)](https://journal.code4lib.org/articles/#ref21). Leoš Janácek: Ouvertüre zur Oper “Aus einem Totenhaus” für Solovioline und Ensemble (UE 36 249). Universal Edition.

[Szeto, K. (2016, October 15)](https://journal.code4lib.org/articles/#ref15). Untangling medium of performance for the linked data environment \[presentation\]. New York State-Ontario Chapter of the Music Library Association Fall Meeting, University of Toronto, Ontario, Canada. [https://academicworks.cuny.edu/bb\_pubs/1251/](https://academicworks.cuny.edu/bb_pubs/1251/).

[Szeto, K., Adams, A. D., Billet, K. E., Busselen, C., Kishimoto, K. S., LoPrete, A. A., McFall, L., Rondeau, S., Snyder, T. L., Soe Nyun, J. L., Vanden Dries, W. R., & Vermeij, H. (2016)](https://journal.code4lib.org/articles/#ref24). Report of the CMC BIBFRAME Task Force to the Board of the Music Library Association. [https://cmc.wp.musiclibraryassoc.org/wp-content/uploads/sites/5/2019/02/201602Task\_Force\_Report.pdf](https://cmc.wp.musiclibraryassoc.org/wp-content/uploads/sites/5/2019/02/201602Task_Force_Report.pdf).

[Szeto, K. (2017)](https://journal.code4lib.org/articles/#ref4). The mystery of the Schubert Song. Notes, 74(1), 9-23. [https://doi.org/10.1353/not.2017.0071](https://doi.org/10.1353/not.2017.0071).

[Weiß, C., Zalkow, F., Arifi-Müller, V., Müller, M., Koops, H. V., Volk, A., & Grohganz, H. G. (2021)](https://journal.code4lib.org/articles/#ref22). Schubert Winterreise Dataset: A Multimodal scenario for music analysis. Journal on Computing and Cultural Heritage, 14(2), 1-18. [https://doi.org/10.1145/3429743](https://doi.org/10.1145/3429743).

[Kimmy Szeto](https://journal.code4lib.org/articles/) is Associate Professor and Metadata Librarian at Baruch College, City University of New York, where he manages metadata for digital resources. His recent research focuses on the technical and conceptual tensions between cataloging practice and the linked data environment. Outside the library and academia, Kimmy can be heard as a chamber arranger of symphonic works and as a collaborative pianist in concert halls and theaters around New York City.
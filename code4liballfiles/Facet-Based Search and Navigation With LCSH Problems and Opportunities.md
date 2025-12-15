---
title: "Facet-Based Search and Navigation With LCSH: Problems and Opportunities"
source: "https://journal.code4lib.org/articles/23"
author:
  - "[[The Code4Lib Journal]]"
published: 2007-12-15
created: 2025-01-10
description: "Facet-based interfaces demonstrate some limitations of Library of Congress Subject Headings (LCSH), which were designed to deal with constraints that do not exist in the current computerized environment. This paper discusses some challenges for using LCSH for faceted browsing and navigation in library catalogs. Ideas are provided for improving results through system design, changes to [...]"
tags:
  - "#facet-based/search"
  - "#LCSH"
  - "#Library/of/Congress/Subject/Headings"
---
# Facet-Based Search and Navigation With LCSH: Problems and Opportunities
Kelley McGrath

Facet-based interfaces demonstrate some limitations of Library of Congress Subject Headings (LCSH), which were designed to deal with constraints that do not exist in the current computerized environment. This paper discusses some challenges for using LCSH for faceted browsing and navigation in library catalogs. Ideas are provided for improving results through system design, changes to LCSH practice, and LCSH structure.

## Introduction

Facet-based search and navigation interfaces are becoming increasingly popular on commercial websites, and several facet-based interfaces for library catalogs are now available. Many of these interfaces attempt to provide Web-style faceted interfaces to Library of Congress Subject Headings (LCSH) in order to provide options for browsing and for navigating large result sets.

LCSH was designed to deal with constraints that do not exist in the current computerized environment. In this paper, I examine the suitability of LCSH for presentation in an online facet-based interface. I look at some of the benefits and potential pitfalls of exposing current LCSH in this manner and ask what the implications of facet-based search are for LCSH.

Three types of solutions are proposed. Changes to:

- System design, which can be implemented with existing data
- LCSH practice or the rules for applying LCSH
- Structure of LCSH or data encoded in LCSH authority records

Ten problems are examined. By general type of problem, these are:

### Hierarchical, broader/narrower relationships

1. [Top-level categories](https://journal.code4lib.org/articles/#problem1) (system design, LCSH structure, LCSH practice)
2. [Hierarchy and specificity](https://journal.code4lib.org/articles/#problem2) (LCSH structure)  
The lack of a consistent and complete hierarchy and the large number of top-level terms prevent LCSH from generating useful top-level categories for browsing without selecting a search term. The use of specific terms without explicit relationships to broader terms prevents easy collocation of classes of items (all the dog breeds or all the communicable diseases) or navigation to different levels of detail.
3. [Geographic/space facet](https://journal.code4lib.org/articles/#problem3) (system design, LCSH structure)  
Lack of hierarchical relationships for places hinders effective browsing of the geographic facet because users cannot adjust the level of focus to fit a particular inquiry, i.e., they cannot easily choose a broad geographic area for a topic on which the library has few materials or a narrow area for a topic on which there are many.

### Access to cross-references

4. [Lead-in terms](https://journal.code4lib.org/articles/#problem4) (system design, LCSH structure)  
Lack of incorporation of cross-references in LCSH authority records into search results makes it more difficult for users to find the LCSH term for what they are looking for. Searches for terms in cross-references, such as WWII, do not pick up all the records with the related authorized LCSH term “World War, 1939-1945.”

### Forms of terms

5. [Single concepts, compound terms, factoring](https://journal.code4lib.org/articles/#problem5) (LCSH structure, system design)  
Use of terms, such as “Cookery, Japanese” or “Adult children of alcoholics, Writings of,” that incorporate more than one facet or aspect of a concept reduce the power and flexibility of faceting by preventing users from limiting by the individual aspects separately.

### Coextensivity

6. [Multi-work records](https://journal.code4lib.org/articles/#problem6) (LCSH structure, bibliographic record format)  
The inability to tell whether different LCSH strings on one bibliographic record represent different aspects of one topic or work, as opposed to separate topics or works leads to misleading results. If a user searches for waltzes and narrows the results by the subject heading “Violin and piano music,” he or she may get mismatched results, such as a CD that includes a minuet for violin and piano and a waltz for piano.

### Missing information in facets

7. [Implied facets](https://journal.code4lib.org/articles/#problem7) (LCSH practice)
8. [Time facet, also covers coextensivity and machine-readable coding](https://journal.code4lib.org/articles/#problem8) (LCSH structure, LCSH practice)  
Some facets are not included in LCSH strings because they were not necessary for identification or might lead to unhelpful splitting up of materials in a left-anchored browsing context. This is particularly true of chronological information. Users won't know that these facets are incompletely populated and will make wrong assumptions about the comprehensiveness of some searches.

### Semantic relationships between terms

9. [More specific categories of topical headings](https://journal.code4lib.org/articles/#problem9) (LCSH structure)  
More browsing options could be provided in faceted interfaces if subject headings were marked as belonging to certain groups or categories, such as types of terms (e.g., classes of persons) or terms that are inherently related to a certain discipline (e.g., legal topics).

### Syntactic relationships between terms

10. [Facets as building blocks](https://journal.code4lib.org/articles/#problem10) (LCSH structure, system design)  
Implementing a larger number of explicit facets to express relationships between terms in LCSH would allow us to more flexibly manipulate and re-use information in subject strings without losing meaning.

## Problems and Solutions

### 1\. Top-Level Categories and Browsing without Searching

#### Problem:

One of the nice features of current faceted interfaces for library catalogs is the ability to browse without first choosing a search term. In this context, it is important to ask what makes something a good set of top-level categories for browsing. The psychologist Eleanor Rosch ([1978](https://journal.code4lib.org/articles/#Rosch1978)) argues that people tend to think of things first of all as belonging to what she calls basic-level categories. That is, people are more like to initially categorize something at the level of “chair” than either “furniture” (superordinate) or “kitchen chair” (subordinate). There is probably some sort of similar “sweet spot” for initial browsing categories for library catalogs (although these might vary for public, academic, and specialized libraries) that would best agree with most users' intuitions.

LCSH or any large system of subject headings are too narrow to be useful as top level vocabulary for browsing unless they can be mapped to higher level categories. However, as Hemmasi ([1996](https://journal.code4lib.org/articles/#Hemmsasi1996)) pointed out, there are “more than 2000 top terms related to the discipline of music terms or headings that are not attached to any broader concept,” which makes it difficult to create a concise list of terms for browsing. There would be a substantial amount of work needed to create the top-level categories and syndetic structure that would make LCSH useful as a basis for this kind of browsing.

#### Possible solution (system design):

The easiest alternative is to use something other than LCSH to generate top-level categories. Options include classification schemes, such as the Library of Congress Classification (LCC) or the Dewey Decimal Classification (DDC), or BISAC (Book Industry Standards and Communications subject headings, available at [http://www.bisg.org/standards/bisac\_subject/index.html](http://www.bisg.org/standards/bisac_subject/index.html)), all of which could potentially be mapped to LCSH strings.

#### Possible solution (LCSH structure):

If the hierarchy of LCSH were made more comprehensive, all or most terms could be mapped to a small set of top-level categories.

#### Possible solution (LCSH practice):

In terms of improving top-level browsing access, there may be a place for broad-bucket headings for some types of materials, such as major literary forms. In NCSU's Endeca catalog, many searches result in a form facet like “$v Fiction” or “$v Poetry,” which is actually misleading because these headings are unlikely to be present on all the fiction or poetry, only those (mostly newer records) that happen to have some topical heading subdivided by the form subdivision “$v Fiction” or “$v Poetry.” Unfortunately, a naÃ¯ve user could easily believe that narrowing a result set by the drama form facet would bring up all the dramatic works.

In our catalog, we have retrospectively added these sorts of broad genre-form headings for some literary forms, including fiction, poetry, and drama, where they could be easily identified and as we have had time. Fiction is the easiest to identify. Print/text fiction records (MARC leader type “a”) include a fixed field called literary form in the MARC 008 that is coded “1” for fiction ([http://www.loc.gov/marc/bibliographic/ecbd008s.html#mrcb008b](http://www.loc.gov/marc/bibliographic/ecbd008s.html#mrcb008b)) so a fiction genre heading can programmatically be added to all these records. Although there are additional codes for other literary forms, these were added to MARC21 relatively recently from UKMARC and are less commonly found in most records created in the U.S. If you would like additional advice on possible methods of identifying literary works, feel free to contact me directly.

In a faceted interface, ideally these literary forms would be searchable in combination with other characteristics, such as original language, date of composition, or nationality or other attributes of the author. Unfortunately, this data is often not found in existing bibliographic or authority records. Some information about original language and nationality and time period of the author could be extracted from classification numbers and coded language information in bibliographic records once the examples of literary works are reliably distinguished from criticism.

### 2\. Hierarchy and Specificity versus Fragmentation

#### Problem:

Specificity of subject headings (i.e., a book about cats is entered under “Cats” and not “Mammals” or “Siamese cat”) is potentially a great strength of LCSH, but in our current browse lists it often leads to a frustrating amount of fragmentation. In practice, the appropriate level of specificity to help a user is not fixed, but is related to the size and depth of the collection being searched, as well as the user's search terms and needs. Many subject browse lists in libraries are too specific for the collection or search and thus lead to fragmentation because the items the user wants are scattered among many subject headings, which are not easy for the user to identify and include in a single search.

In our current system, it is hard to move up and down levels of specificity because the syndetic structure is incomplete, the type of relationship is not always recorded clearly, and our systems don't support this type of navigation. For example, a user might want to search for everything about communicable diseases (broad) in Kenya (narrow) or AIDS (narrow) in Africa (broad), but for either of those searches, it's hard to see how a user could do a search in a current catalog that wouldn't be labor-intensive and involve manually looking for a lot of narrower terms and potential combinations. For example, a user would have to ascertain and manually combine Kenya with all the types of communicable diseases (e.g. sexually-transmitted diseases) and all the specific diseases (e.g., AIDS, malaria, tuberculosis), in order to do a comprehensive search.

#### Possible solution (LCSH structure):

If LCSH's syndetic structure were made more complete and systematic, and relevant relationships were coded in the authority records, interfaces could be designed to “explode” search terms to automatically include narrower terms or to shift to the next broader level. This is commonly done in interfaces using more rigorously designed thesauri (e.g., Medical Subject Headings (MeSH)). This relieves the burden on the searcher who wants to do a comprehensive search to find relevant things put under very specific headings without undermining the ability of another searcher to do a very precise search.

Faceted interfaces, in combination with better syndetic structure may particularly help users easily move up and down the chain of specificity to find what they need by allowing them to manipulate facets independently. This would make it easy for users to adjust the specificity of different aspects or facets of their search (e.g., a broad topic in a narrow geographic area) in a way that isn't possible in a linear pre-coordinated list.

The Flamenco Search Interface Project (UC Berkeley School of Information, n.d.) demonstrates some of the possibilities of a hierarchical, faceted interface. This works better when the top level categories and hierarchies are likely to be clear and predictable for users, but since users can use search terms to focus on specific topics, they can effectively start anywhere in the hierarchy.

### 3\. Hierarchical Access to the Geographic/Space Facet

#### Problem:

It is difficult to search standard LCSH comprehensively for geographic areas because in many cases the form of the name of the area is given inconsistently. LCSH geographic terms are given in unabbreviated indirect order only when they are qualifying a base heading (e.g., “Mentally ill $z Illinois $z Chicago”). When a geographic term is used as the base heading, it is often qualified by the larger place (state or country) using the AACR2 abbreviation if there is one (e.g., “Chicago (Ill.) $x Description and travel”). It is also difficult to search for a geographic area and all of the geographic areas within it (e.g., works that cover the U.S. as a whole or any part of the U.S.) because the broader term is not given explicitly in the heading (i.e., subjects for a book about birds in Wisconsin would not include the word United States even though Wisconsin is in the U.S. and the authority record does not include a broader term that could be leveraged to determine that Wisconsin is in the U.S.).

#### Possible solution (systems design, LCSH structure):

The approach that FAST takes provides hierarchical access to the geographic facet and enables the user to easily broaden or narrow the scope of a search. The FAST geographic facet is consistently given in unabbreviated, indirect order (e.g., Illinois $z Chicago). Mapping the direct terms to the indirect terms and faceting all equivalent geographic terms in the same form increases precision and recall. It helps get all the mentally and terminally ill out of searches for “Illinois OR Ill” when looking for the state. FAST has also mapped the top-level terms in their indirect geographic headings to the MARC geographic area codes ([http://www.loc.gov/marc/geoareas](http://www.loc.gov/marc/geoareas)). These can be very useful for easily generating short searches that comprehensively search a whole continent or region. In the example of AIDS in Africa, the use of “f” in the geographic area code, combined with a few large regions defined as codes beginning with “f” (e.g., fb for Africa, Sub-Saharan, which is used directly in FAST rather than being entered as “Africa—Africa, Sub-Saharan; the latter, although redundant, might be better for faceting) would give comprehensive results that would be much more time consuming to duplicate by searching standard LCSH subject headings directly and looking for all the African countries individually. The indirect forms of geographic headings (field 781) and the mapping to hierarchical geographic area codes (field 043) that FAST does are largely encoded in current geographic name (151) authority records and could be leveraged by current systems.

### 4\. Lead-In Terms and Incorporating Cross-References

#### Problem:

Most current catalog interfaces do not effectively integrate cross-references for authorized subject terms into their keyword search interfaces. This makes it harder for users to find the LCSH terms that correspond to what they are looking for.

#### Possible solution (system design):

This is something that could be remedied in existing facet-based interfaces by incorporating cross-references from subject authority records in keyword searches and by displaying matching cross-references in the list of relevant subject facets in some way that is clear to users. If a user searches a term that is in an LCSH cross-reference, such as “Non-violence,” it should show up in the list of relevant topical subject facets using some convention that makes in clear what's going on. The Internet Movie Database ([http://www.imdb.com/](http://www.imdb.com/)) displays authorized terms resulting from a keyword search as hyperlinks, with succeeding non-hyperlinked lines giving cross-references in italics, such as “aka â€˜Larry Fishburne'” or “birth name â€˜Clinton Eastwood Jr.'” Perhaps the cross-reference term searched by the user could be listed in the subject facet in parentheses following the authorized term. The list of subject facets could then display something like “Nonviolence (Non-violence)” to communicate the connection between the term the user searched and the authorized subject term.

For example, if a user searches for “non-violence” in NCSU's Endeca catalog, there are 62 hits, 13 of which have the subject nonviolence as one word. Non-violence is a cross-reference on the authority record for nonviolence. If the search targeted subject cross-references as well as terms actually appearing in bibliographic records, the user's search results would incorporate everything with the keyword “non-violence” plus everything with the subject “nonviolence,” thus expanding the result list to include the additional 136 records that have the subject nonviolence, but didn't show up in the original search.

| Without searching subject cross-references                                                                              | With searching subject cross-references                                                                                                      |
| ----------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| 62 records                                                                                                              | 198 records                                                                                                                                  |
| Subject: Topic   - Nonviolence (13) - Gandhi, (10) - Politics and government (8) - History (7) - Passive resistance (7) | Subject: Topic   - Nonviolence \[Non-violence\] (149) - Gandhi, (??) - Politics and government (??) - History (??) - Passive resistance (??) |

Incorporating cross-references into searches in a facet-based environment might also be effective in helping with the problem mentioned on the Next Generation Catalogs for Libraries (NGC4Lib) email list in July 2007 about World War II in France and cross-references. If a user searches for “France World War II,” the system could look for each individual word as well as groups of words in both the authorized headings and cross-references in authority records and find the best matches (weighting things that occur in a phrase or occur together so “world war II” could point to “World War, 1939-1945” and “France” could pick up subdivisions with variations on “France” and “French” (e.g., “$x Aerial operations, French”). Cross-references for subject subdivisions generally do not work well in existing interfaces.

#### Problem:

Sometimes a broad topic (e.g., boxing in general) that a user may be interested in is entered under different subjects that emphasize particular aspects of that topic (e.g., “Boxers (Sports)” for a biography or “Boxing” for an instructional video). This also happens when the same meaning is represented by different terms (e.g., “Church history $y *Middle Ages*, 600-1500″ and “Architecture, *Medieval*) and there are some other variant combinations that are very similar in meaning, such as “Older people $x Psychology” and “Aging $x Psychological aspects,” that might be missed by users interested in both.

#### Possible solution (LCSH structure):

Connections between the values in various facets (e.g., the action and the class of persons) related to a given topic or other types of cross-references could be made. This would require that these relationships be identified and recorded in subject authority records in some way and would improve recall for general searches on many topics.

#### Problem:

Some topical subdivisions vary in form, but not in essential meaning, depending on the type of base heading that they follow. For example, “\$x Economic conditions” is used after places (651), but “$x Economic aspects” is used after topical base headings (650). In a faceted interface, these will appear to users as two different limiters.

#### Possible solution (system design or LCSH structure):

These pairs of subject subdivisions could be identified and merged for search and display purposes in a faceted interface.

### 5\. Form of Terms in LCSH: Single Concepts, Compound Terms, and Factoring

#### Problem:

Vickery ([1970](https://journal.code4lib.org/articles/#Vickery1970)) says that subclasses should be “derived from a parent class by application of a single characteristic from an array, and should as far as possible be mutually exclusive” (p. 39). In faceted thesauri (as opposed to notation-based classifications), these demands for step-by-step and clearly defined division are often in conflict with the desire to have phrases that make sense to users (e.g., “African American women poets” versus “African Americans” + “Women” + “Poets”). Svenonius ([2003](https://journal.code4lib.org/articles/#Svenonius2003)) notes that the issue of compound terms and single concepts in thesauri is often not simple and straightforward. Single concept does not necessarily equal single word. She asks if “information retrieval” is usefully considered as one concept or two. She also provides examples of typical situations in which it is recommended that compound terms, generally a modifier and noun, be retained.

The compound or complex nature of many individual topical terms in LCSH, such as “Cookery, Indic” and “Absurd (Philosophy) in literature” causes difficulties for the development of clean, consistent faceted interfaces because the component parts cannot be manipulated individually. The *Subject Cataloging Manual* ([SCM](https://journal.code4lib.org/articles/#SCM2007) H 180, point 15) lists a number of forms of headings, ranging from simple nouns (“Children”) to more problematic forms such as nouns with adjectives (“Gifted children”) or with prepositions (“Teachers of gifted children”).

#### Possible solution (LCSH structure):

Consistent use of broader terms, ideally with characteristics of division marked,  could help compensate for the lack of faceting of compound terms. However, LCSH  does not make machine-readable broader-narrower terms under all circumstances.  
For example, The *Subject Cataloging Manual* ([SCM](https://journal.code4lib.org/articles/#SCM2007) H 370) instructs catalogers to not create broader term references for “inverted headings qualified by names of languages, nationalities, ethnic groups, or terms that designate time periods, when the only appropriate BTs are the identical heading without the qualifier.” That means that “Art, Chinese” does not get a broader term of “Art.” Even where there is a broader term given in the authority record, there may be more than one characteristic of division used under that broader term and there is no machine-understandable way to differentiate between these. “Art, Chinese” is for all practical purposes a narrower term of art by nationality; “Art, Buddhist” is a narrower term by religious tradition; and “Art, Elizabethan” by a time period and/or style. There can also be a hierarchy of divisions of a certain type, e.g., “Sculpture” to “Metal sculpture” to “Bronze sculpture.” In a true faceted system, under art there would be a comprehensive list of types by nationality, by geographic region, by style, by time period, and so on.

#### Problem:

Compound headings, such as “African American women tennis players,” are often problematic when found on individual biographies. According to the Subject Cataloging Manual, such headings are supposed to be accompanied by a more general term. The instructions say to “assign headings that specify the sex or ethnic group of the class of persons, such as Women architects, African American lawyers, etc., if that is a significant aspect of the work. When assigning this heading, assign it *in addition to the unqualified heading for the class of persons*” ([SCM](https://journal.code4lib.org/articles/#SCM2007) H 1330). These instructions are often overlooked, leaving some biographies segregated out from the mass of American tennis players (at least in a browse list where “African American women tennis players” is not easily connected to “Tennis players $z United States”), and certainly from the broader yet term “Athletes $z United States.”

#### Possible solution (LCSH structure):

Factoring out the parts of a heading to their most specific parts (e.g., African Americans + women + tennis players), which could have broader and narrower terms for each individual bit, would be more flexible and would allow for any combination of terms desired.

When Yee ([2001](https://journal.code4lib.org/articles/#)) compared genre terms from LCSH and MIGFG (the Moving Image Genre-form Guide, [http://www.loc.gov/rr/mopic/migintro.html](http://www.loc.gov/rr/mopic/migintro.html)), which is a faceted list, she pointed out that a disadvantage of single concept facets in a controlled vocabulary is that they can result in artificial terms (e.g. “Gangster–Feature” in MIGFG versus LCSH's “Gangster films”) that don't resemble users' vocabulary. However, it is possible to map combinations of individual concepts to phrases that are more likely to be known to users. Alternatively, if the multi-concept headings are kept for display purposes, they could have explicitly coded broader terms, as well as explicitly coded characteristics of division (this would enable a user to get all the available types of art by nationality in a separate list, for example). In the long run, it would probably be better to create headings that are single-concept as much as possible and map them to relevant phrases when needed. This could be done by explicitly entering the phrases as cross-references for specific combinations of single-concept headings or, in many cases, through rules for order and singular/plural forms when combining certain types of terms, such as for classes of persons. There seem to be regular patterns to the phrase (or phrases) that are used for classes of persons (e.g., “African American women tennis players” not “Women African American tennis players” or “Tennis player African American women”) so rules could be developed for mapping combinations of single terms to sensible phrases if the types of single-concept terms were marked (e.g., classes of persons, ethnic groups, professions). Phrases that are not amenable to a rule-based approach could be established explicitly.

#### Possible solution (system design):

Tunkelang ([2006](https://journal.code4lib.org/articles/#Tunkelang2006)) suggests an alternative approach for helping match users' vocabulary to the system's vocabulary. His Dynamic Category Sets approach is intended to effectively display combinations of facets that meet a user's request. For example, a user query for “audio technology” could be mapped to both “media=audio, subject=technology” and “subject=audio technology, subject=history” (p. 2). This approach could also support stemming and cross-reference or synonym searching.

### 6\. Coextensivity, Particularly with Multi-Work Records

#### Problem:

Anderson and Hofmann ([2006](https://journal.code4lib.org/articles/#Anderson2006)) make the point that, although LCSH is supposed to provide subject analysis that is coextensive with the topic of the work, this is undermined by the use of more than one heading to approximate the coextensive subject. There are many situations where it is not possible to construct a single subject heading string that brings together all the aspects of a single topic for a single work. One of the examples given in H 180 of the *Subject Cataloging Manual* is the use of the combination of “Ruminants $x Metabolism” and “Lipids $x Metabolism” for the title *Lipid Metabolism in Ruminant Animals*.

The difficulty in determining whether multiple subject headings represent aspects of a single topic or two different topics is exacerbated when there are multiple works on one bibliographic record. For example, a DVD containing two episodes of the television program *The Long Search* might come up in a user's search for Buddhism in England in a faceted interface, even though it contains one episode about Buddhism in India and one about the Catholic Church in England. There is no way to tell in current records whether two subject headings represent different aspects of the same topic or two different topics covered in the same item.

The problem is particularly acute for musical sound recordings, which typically feature multiple pieces with no machine-interpretable relationship between the various types of metadata about a given piece (title, composer, performer(s), form or genre, instrumentation, date of composition, etc.). It is not uncommon for subject access for a given musical piece to be split between two subject headings in such a way that a computer cannot be taught to correlate instrumentation with genre, although users want to know this. It is hard to even make a good guess, since a given heading might be used in more than one combination. The following list of subject headings from one bibliographic record could theoretically include both a minuet for violin and piano and a minuet for solo piano.

- Waltzes.
- Violin and piano music.
- Minuets.
- Piano music.

#### Possible solutions (MARC practice and structure, LCSH structure):

Some sort of linking of the subject headings and/or relevant coded fields could help compensate for this problem. Effective ways of expressing hierarchy and relationships within individual bibliographic records are needed. McBride ([2000](https://journal.code4lib.org/articles/#McBride2000)) discusses the problem of relating the different aspects (or facets) of individual pieces on bibliographic records for musical sound recordings. He examines the potential of combining coded information in 04x fields with subject headings and other information using linking subfields ($8) to create the appropriate connections. He discusses the development and potential use of coded information in fields such as 045 (date of composition), 047 (form of composition), and 048 (instrumentation) for faceted access to music. He points out that despite potential improvements to these fields, they provide fundamentally inaccurate results if some way cannot be found of tying together the related fields. It is unclear how the underlying problem in existing data can be remedied without review by human beings with the expertise to encode the connections between the various bits of information. I think of this as the Humpty Dumpty problem—all the pieces might be there, but it's impossible to get them back together again. Some sort of hierarchical XML record seems likely to outperform a typical MARC record in ease of use, both for input and manipulation of hierarchy and relationships within records. Although the MARC linking subfield ($8) could be made to work for most of these connections, it fails in those cases where information about different works appears in a single field, such as 511 (performers) or 505 (contents note). Currently, neither interfaces to easily input these links nor user interfaces to get them back out are commonly available.

### 7\. Implied Facets

#### Problem:

Facets are sometimes not explicitly included in LCSH strings when they are thought to be redundant for human viewers or unnecessary in a traditional left-anchored subject browse list. An example of an implied facet is the omission of geographic subdivision by “$z Germany” under “National Socialism.” According to the authority record (sh 85090131), “National socialism” should not be followed by Germany. “National socialism” = Nazism in general and Nazism in Germany as a whole, while “National socialism $z Germany” is only supposed to be used when it's further subdivided by a more specific place e.g., “National socialism $z Germany $z Berlin”). When users search for Nazism in a faceted interface and then click the LCSH-based geographic facet “Germany” to limit to Nazism in Germany, they will not actually get all the works on Nazism in Germany, even though it may appear to the user that they should.

This conflict between the need for concise human-scannable strings versus the explicit notation required by computers is described by Slavic and Cordeiro ([2004](https://journal.code4lib.org/articles/#Slavic2004)) in their article on machine-based manipulation of faceted classification numbers. For an effective facet-based interface, explicit strings, even if longer or redundant for human viewers, lead to more effective, comprehensive results.

#### Possible solution (LCSH practice):

There is no systematic way to search for areas where there might be implied facets in LCSH, but as these are discovered, the instructions can be changed to make implicit facets explicit and old records could be updated.

### 8\. Time Facet: Often Omitted, Not Coextensive with the Work, and Not Coded for Machine-Based Parsing

#### Problems:

1. Chronological information is often omitted from LCSH subject strings. Because of this, the chronological designations that users see as options in faceted interfaces only represent a fraction of relevant materials. Chronological subdivision is not allowed where it has not been explicitly established except for the ability to mark time periods at the century level in most circumstances. Chronological subdivisions are omitted where they are implied by the main topic. For example, catalogers are instructed to use “Underground Railroad $x History” rather than “Underground Railroad $x History $y 19th century” ([SCM](https://journal.code4lib.org/articles/#SCM2007) H 620). SCM H 1592 points out that many events are not known by a specific proper name and therefore are not established independently under a specific heading that includes a time period. Instead, these events are put under general headings by category and place, e.g. “Dust storms $z Illinois $x History,” which do not support searching by time period.
2. Chronological information is often entered as words, which are not related to specific dates or date ranges that could be used for searching. SCM H 620 lists various ways of expressing chronological periods in LCSH, including periods named in words (“Iron age,” “Eighteenth century”), implied periods (“Post-communism”), headings with broad adjectival qualifiers (“Literature, Ancient”), events with dates (“Pan Am Flight 103 Bombing Incident, 1988”), and chronological subdivisions to be used after topical or geographical headings, with or without dates (“\$y 500-1400,” “$y Jurassic”). The first four types are coded in MARC 650 $a and are not easy to systematically distinguish from topical headings.
3. Chronological information is only entered in pre-selected ranges and is not coextensive with the coverage of the work. A book on an event in 1868 might be marked with nothing more specific than “$y 19th century.”
4. Chronological information is not marked in a way that exact dates or date ranges can be reliably identified or manipulated by a computer.

#### Possible solutions (LCSH practice, structure):

RSWK, the German subject headings system ([Frommeyer, 2004](https://journal.code4lib.org/articles/#Frommeyer2004)), encodes the exact time period covered by the document in the chronological facet, as does FAST in most cases ([Dean, 2003](https://journal.code4lib.org/articles/#Dean2003)). FAST uses the MARC 648 field to record this data and catalogers using regular LCSH could also start using this field. Exact date ranges allow for more precise chronological searching and can potentially be mapped to standard time periods. Chronological information in subject headings can be given both as date ranges and in words, some of which (e.g., Middle Ages) cannot be mapped to exact dates or for which the meaning may vary based on geographic area.

Frommeyer ([2004](https://journal.code4lib.org/articles/#Frommeyer2004)) makes recommendations for improving the way chronological information is recorded, both for explicit date ranges and for named (and sometimes vague) periods, such as the Middle Ages. She recommends storing exact time spans in bibliographic subject headings as numeric time spans that can be used with greater/lesser than and equal operators. She acknowledges that this would be difficult to do retrospectively with LCSH as the time span in the existing subject heading is often not coextensive with the period covered by the work, but points out that sometimes this information can be found in titles or other parts of the bibliographic record. She also recommends that time spans be included in authority records for named periods. These could then be inherited by the associated bibliographic records. Finally, she would like to see the creation of a “chronology authority file” that would support more sophisticated browsing and provide insight into various temporal relationships (for example, by providing views limited to certain geographic or subject areas). She envisions a display modeled on the sort of timeline interface commonly seen in digital encyclopedias. Petras et al. ([2005](https://journal.code4lib.org/articles/#Petras2005)) describe a project to map named time periods or events to their associated locations and dates or date ranges in the way that gazetteers map place names to latitude and longitude coordinates.  
Their test case is LCSH, although they limited themselves to the chronological  information easily identified by machine (i.e., $y subdivisions and not explicit  
or implicit chronological information in other fields, such as $a of topical subject headings or $d of personal name headings). They created an interface for searching and browsing by location, time, time period type (e.g., civil revolutions; these categories were manually entered) and to search for specific time periods and events. Faceted interfaces using LCSH would benefit from the inclusion of more chronological information in subject headings. Current selective use of chronological subdivisions is likely to mislead users into thinking they are getting more comprehensive search results than they actually are. With the appropriate interface, a switch to recording exact dates of chronological coverage would enable more precise, flexible, and comprehensive searching. Many works have specific date ranges or historical periods specified in their titles or in tables of contents or publisher's blurbs that could easily be added at the time of cataloging. Some works cover a vague contemporary period, which may be harder to decide how to encode. In addition to the limits on when time-related information may be included, chronological data is not added to LCSH in forms in which it is useful for machine manipulation.

Marking of beginning and ending dates would enable more manipulation of time-related data. Mapping of named time periods and events to date ranges would also improve access to chronological information.

### 9\. More Specific Categories of Topical Headings

#### Problem:

More browsing options could be provided in faceted interfaces if subject headings were marked as belonging to certain groups or categories. These categories could support more precise browsing in some situations. For example, if applicable headings were marked as classes of persons, it would be possible to allow users to browse a list of biographies arranged by class of person covered (e.g., artists, presidents, rock musicians). Another example of this type of categorization is the way that the U.S. Board on Geographic Names (http://geonames.usgs.gov) assigns specific geographic names to various feature categories, such as lakes, summits (mountains), and populated places. Headings could also be usefully grouped by broad subject area (e.g., topics that are inherently legal or economic in nature). Svenonius ([2000](https://journal.code4lib.org/articles/#Svenonius2000)) points out that “a major reason for classifying terms in a subject language is that the resulting categories can be used to formulate the syntax rules of the language” (p. 19). In terms of LCSH, this would permit automated validation of free-floating subdivisions that are only supposed to be used with certain types of main headings.

#### Possible solutions (LCSH structure):

There are a number of possible ways to attempt to identify headings in certain categories or belonging to certain topic areas. Several are described below, including patterns in the use of free-floating and pattern-based subdivisions in a large collection of bibliographic records, occurrence of certain words in headings, broader and narrower term relationships in authority records, and correspondence between subject headings and classification numbers in authority and bibliographic records.

##### Use of Free-Floating and Pattern-Based Subdivisions in Bibliographic Records

The *Subject Cataloging Manual* lists a number of “free-floating” topical and form/genre subdivisions. Free-floating means that these subdivisions are permitted to be used following base headings without the combination being explicitly established and given its own authority record. In addition to free-floating subdivisions, there are also so-called pattern headings, where one heading of a given category is designated as the one under which relevant subdivisions will be explicitly established. For example, subdivisions applicable to any religion (except Christianity) are explicitly established under “Buddhism.” A list of these categories can be found in the *Subject Cataloging Manual*.

The categories in the *Subject Cataloging Manual* are intended to define groups of topical headings in order to specify which topical and form subdivisions may be freely combined with them. For example, classes of persons, such as “Librarians,” can be followed by the subdivision “\$v Biography” or diseases, such as “Cancer,” can be followed by the subdivision “\$x Patients.” With the addition of the free-floating subdivision “\$x Patients,” the status of the string as a whole changes to class of persons and can only be further subdivided by subdivisions permitted under classes of persons. So “Cancer” is a disease and cannot be followed by “\$v Diaries,” but “Cancer \$x Patients” is a class of persons to which “$v Diaries” could be appended. It is also the case that sometimes specific types of patients, such as “Diabetics,” are editorially established, and a cross reference is made from the form using the free-floating subdivision (“Diabetes $x Patients”).

The category or categories of headings after which a free-floating heading can be used are encoded in the 073 field of subject subdivision (180 and 185) authority records. $a contains the section of the *Subject Cataloging Manual* that discusses that type of heading, such as “H 1100,” and $z contains “lcsh.” If more than one section applies, each section is given in a separate $a. The instructions for use are also given as notes in 680 $i in the form “Use as a topical subdivision under classes of persons.”

Knowing what individual subject headings fall into these categories could be useful for arranging and displaying these headings for user consumption. Not all subject headings fall into one of these categories, but once the headings that belong to currently defined categories have been identified, it might be possible to examine the remaining headings to see if they can be usefully grouped in some way. Unfortunately, there is nothing in individual topical subject heading authority records that says what category a given heading belongs to. A human being is expected to infer what subject headings belong to what categories on an individual basis. However, it is possible to identify the category into which many base subject headings fall by looking at patterns of associated topical and form subdivisions in bibliographic records.

The best free-floating subdivisions for this purpose are those that can be used with only one category of base headings. Some free-floating subdivisions are useable under all topical headings and thus have no discriminatory power for this purpose. Some free-floating subdivisions are difficult to use for this type of analysis because they are used under different categories of headings with different meanings. Free-floating subdivisions that are used under different categories of base headings with similar meanings cannot be used to unambiguously determine the category of the preceding base heading. However, it is possible that an analysis of the pattern of all the free-floating headings that are found to follow a given topical base heading could be used to extrapolate the category of the base heading. Any analysis of this sort would not reach a long tail of headings that have not been used in combination with a subdivision, but many common headings could be automatically determined and this might be enough to do something useful.

As a test of this theory, I searched for records in our catalog with three reasonably common subdivisions that occur only after classes of persons or ethnic groups (which are essentially a subset of classes of persons). These are “\$x Attitudes,” “\$v Diaries,” and “\$x Ethnic relations.” I pulled all the records containing one of these subdivisions in a 650 topical subject field from our catalog, de-duplicated the headings, and removed a few obvious errors. This left 816 unique headings. The results reveal some potential problems with this approach. There were a number of errors in tagging (e.g. “\$z Attitudes” as a geographical subdivision) and subdivisions used after base headings that don’t belong to an authorized category. A large number of misused subdivisions were based on a misinterpretation of the specific meaning of “$x Attitudes” in LCSH.

Including the ones that are possible, but questionable, for inclusion as classes of person as errors, there is around a 7% error rate. If a larger set of data was used and a threshold for number of occurrences of a heading with an appropriate subdivision were set, the rate of accuracy might be improved somewhat.

##### Looking for Specific Words in Subject Headings

Multi-word subject headings that include certain words (“women” or “artists”) that are not also used as adjectives and don’t include any prepositions (“Adult education of women” or “Artists and museums”), can often be assumed to fall into a certain category (classes of persons). So all headings that include the word “women,” but don’t include a preposition could provisionally be assigned to the category “classes of persons”

To test this approach, I extracted all the 650 $a subfields (base topical subject headings) that included the word “women” from our catalog. After removing duplicates and a few typographical errors, 795 unique headings remained. My assumption was that most of the headings that included prepositions would not be classes of persons and most of the headings that did not would represent classes of persons. I provisionally marked all the headings that included the following prepositions: “against,” “and,” “for,” “in,” “of,” “on,” “to,” and “with” as not classes of persons. This totaled 250 headings. I then scanned the headings for erroneously assigned headings. For headings without prepositions, there were only three that appeared not to be classes of persons. Two began with the phrase “Women-owned” and the other was “National Women Veterans Recognition Week.” Eliminating headings containing “owned” and “week,” as well as “day,” “month,” and “year,” from the list of probable classes of persons would resolve these problems. There were more problems with headings that included prepositions turning out to be classes of persons. There were seven “and” headings (“Women track and field athletes”), four “of” headings (“Women heads of state”), and three “with” headings (“Women with mental disabilities”).

However, the most problematic (and common) preposition was “in.” In particular, headings that include the phrase “women in X” can be hard to judge. There are a number of headings of the form “X in literature” or “X in motion pictures” that are intended to represent the portrayal of X in those forms and are not classes of persons. There are also some that might be construed as classes of persons, such as “Women in the advertising industry,” which, despite its broader term of “Advertising,” seems like it could refer to a class of persons. The note in the authority record (sh 85147608) states that “here are entered works discussing all aspects of women’s involvement in advertising. Works discussing the portrayal of women in advertising are entered under $a Women in advertising.” On the other hand, perhaps it is intended to refer to the activity of a class of persons. However, its use in the subject string “Women in the advertising industry $z United States $v Biography” in a Library of Congress-generated bibliographic record in our catalog suggests that it might be intended to be considered as a class of persons. It’s not clear to me what “Women in Buddhism” might mean (as distinct from “Buddhist women” or “Women $x Religious aspects $x Buddhism”). Ignoring the “in” headings, which probably need further clarification, this method miscategorized 14 out of 250 headings with prepositions (6%) and 3 out of 545 headings without prepositions (.5%).

This approach works less well with terms that are also used as adjectives is LCSH. It can’t distinguish between “African American poets” (a class of persons) and “African American art” (not a class of persons). However, a more limited version of this approach may still work. In many cases, if the category of the final term in the heading is known (e.g., “poets” or “art”) and there are no prepositions in the heading, the heading can be assumed to be in the same category as the final term.

##### Broader and Narrower Term Relationships

Broader and narrower relationships could theoretically be used to assign narrower terms to the same category as the corresponding broader term. However, for historical reasons, there are many types of broader-narrower relationships in LCSH and these are not all of the species-genus type. As Svenonius ([2000](https://journal.code4lib.org/articles/#Svenonius2000)) points out, the Library of Congress took the “quick-fix” approach and used an automated process to convert all of its historically inconsistent *see* and *see also* references to broader and narrower terms in one fell swoop, with only “a few â€˜Band-Aid’ reparations … to fix some of the more egregious structural deficiencies” (p. 22). Although broader and narrower terms may not be useful for automatic identification of narrower terms that belong to the same category as broader terms, it might be possible to use the existing broader and narrower relationships to confirm categorizations made by the above methods. It might also be a useful exercise to manually examine uncategorized narrower terms of broader terms identified by the above methods in order to identify areas where the syndetic structure could be made more consistent. If a manually-examined narrower term does belong to the same category as its broader term, it could be assigned to that category. If the narrower term does not belong to the same category, its place in the syndetic structure could be reevaluated.

##### Classification Numbers in Authority or Bibliographic Records and Broad Subject Areas

Another way to potentially divide up topical facets is by broad subject area, such as topics that are inherently legal or economic in nature. This might allow mapping of a specific subject to a broader area or areas that would be more useful entry vocabulary for browsing. This is somewhat complicated by the fact that subject headings are generally held to represent topics while classification numbers represent disciplines. However, many topics can be primarily associated with a specific broad subject area, even if they might often be discussed from the perspective of other disciplines.

It might be possible to identify relevant subject areas for many headings by mapping them to commonly associated classification numbers. Some subject heading and name authority records contain LC classification numbers or ranges in the 053 field (possibly qualified by perspective in $c) so these could be used if present. Some examples include.

| Chemistry:       | QD                                          |
| ---------------- | ------------------------------------------- |
| Lungs $x Cancer: | RC280.L8                                    |
| Dandelions:      | QK495.C74 $c Botany                         |
| Computers:       | QA75.5 $b QA76.95 $c Mathematics            |
|                  | TK7885 $b TK7895 $c Electrical engineering  |
| Death:           | BD443.8 $b BD445 $c Philosophy              |
|                  | GR455 $c Folklore                           |
|                  | GT3150 $b GT3390.5 $c Manners and customs   |
|                  | HQ1073 $b HQ1073.5 $c General               |
|                  | QH671 $c Cytology                           |
|                  | QP87 $c Physiology                          |
|                  | RA1063 $b RA1063.5 $c Medical jurisprudence |

Clearly “Lungs $x Cancer” has a closer correspondence to medicine than “Death” does to any given discipline.

Another possible approach is that taken by the Library of Congress’ Classification Web product ([http://classificationweb.net/](http://classificationweb.net/)). ClassWeb maps classification numbers in bibliographic records to the first subject heading used in a record when it is a 650 (topical) or 651 (geographic) heading. It does not work for mapping names and titles to classification numbers. Traditionally, this is the subject heading that is supposed to most closely correlate with the subject of the work and the classification number. At least in cases where a clear predominant mapping or cluster of mappings occurs, the related broad subject area or areas could be determined.

##### Using WordNet or Another Existing Set of Semantic Relationships

Another possible approach is that taken by Yee et al. ([2003](https://journal.code4lib.org/articles/#Yee2003)), who semi-automatically assigned words in free text to metadata categories using their higher-level category labels in WordNet ([http://wordnet.princeton.edu/](http://wordnet.princeton.edu/)).

##### Use of these Categories to Improve Consistency and Authority Control

Most of the LCSH heading strings that are not established editorially are constructed by attaching geographic or topical or form subdivisions to a base subject as described above. Currently OCLC’s control headings function ([http://www.oclc.org/support/documentation/connexion/browser/authorities/apply\_ac\_bib\_records/default.htm](http://www.oclc.org/support/documentation/connexion/browser/authorities/apply_ac_bib_records/default.htm)) does a fairly good job of knowing where a geographic subdivision should go in a given string because whether or not each element of a string can be geographically subdivided is coded in its authority record. The control headings function can also inform the cataloger that a heading cannot take a geographic subdivision at all.

As described above, free-floating and pattern subdivisions are often permitted only under certain types of base headings (e.g., classes of persons, religions). If the appropriate categories were coded in authority records and combined with a set of rules, a computer would be able to validate any possible combination of elements in an LCSH string. Although this approach might be more complicated up front, it seems likely to be much more useful and less of a monumental undertaking than trying to explicitly establish individual combinations, as the Library of Congress is currently attempting. It would be impractical to explicitly establish all the possible combinations and even if the practice were limited to commonly-occurring headings, it seems like a large-scale investment in something that may not be helpful to us if we want to move to a more faceted, and perhaps post-coordinate, system. Machine-based rules might also be more accurate-our local system is set up to require authority records for individual combinations, but these authority records are sometimes created based on their use in our database without being sufficiently vetted. This leads to the establishment of incorrectly-constructed headings or heading strings that should be mutually exclusive (e.g., at one time we had local authority records for both “Youth $x Alcohol use $z United States” and “Youth $z United States $x Alcohol use”)

### 10\. Facets as Building Blocks for a More Hospitable, Machine-Controllable Subject Vocabulary and Better Display of Relationships Between Terms (Syntactic Relationships)

#### Problem:

An insufficient number of facets to express relationships between terms in LCSH hinders our ability to manipulate and re-use information in subject strings. As Vickery ([1970](https://journal.code4lib.org/articles/#Vickery1970)) points out, assigning terms to specific facets provides meaningful relationships between terms. For machine-manipulation of faceted classification numbers, Slavic and Cordeiro ([2004](https://journal.code4lib.org/articles/#Slavic2004)) emphasize the “need to fully declare and encode each compositional element of a synthesized notation” (p. 5). Unfortunately, the syntax of LCSH covers only a limited number of types of relationships and these are often unclear. These are generally the same as the facets used in FAST, i.e., the topical main and subdivision terms (150 and 180), the genre-form main and subdivision terms (155, only beginning to be established, and 185), geographic terms (151), chronological subdivisions ($y, which is only established in conjunction with another term; stand-alone chronological terms, e.g., “Sixteenth century” or “Middle Ages,” are established as topical headings in 150 in LCSH), as well as personal (100), corporate (110), conference/meeting (111), and title (130) headings borrowed from the name authority file and established under the aegis of AACR2 rather than LCSH rules.

In many cases the relationship between the different subfields of subject heading strings is unclear. An example of this is the use of geographic subdivision after the heading “Prisoners of war.” The relevant authority record (sh 85106971) explicitly instructs catalogers that “when subdivided by place, the name of the place may designate either the current location of prisoners of war, or the place of origin. For prisoners of war of a particular nationality held in another country, two headings are assigned: $a 1\. Prisoners of war–\[country of nationality\]. 2. Prisoners of war–\[place where held\].” Therefore, “Prisoners of war $z China” can mean either Chinese prisoners of war or prisoners of war of any nationality being held in China.

This exemplifies two problems that lead to ambiguity in the meaning of geographic subdivisions in LCSH. One is that sometimes geographic subdivision is used to represent nationality instead of an actual place, and this isn’t always obvious to users. In many cases, nationality and place are so often the same that they are conflated, which makes for sticky situations when they are different. Normally, LCSH deems it redundant to bring out both place and nationality unless they are different. For “classes of persons” headings on biographies, usually either a geographic subdivision or a nationality qualifier is used, but not both. “Authors, French” seems to refer to nationality (and generally seems to be doubled when someone has relocated; biographies of Nabokov are mostly under both “Authors, American” and “Authors, Russian”), but based on the fact that Picasso’s biographies are put under “Artists $z France,” but not “Artists $z Spain,” France seems to mean place of activity rather than nationality.

The second example (Prisoners of war–\[place where held\]) could possibly confuse a country as a place with a country as a governmental body or an entity capable of acting as an agent. Although country names can be treated as corporate bodies in the name authority file where they are tagged 110 when they are the issuing official documents of a signatory of a treaty or otherwise responsible for certain types of reports or other works, there is usually no way to differentiate between a country as a place and the government of that country in a subject subdivision. This lack of clear and consistent expression of relationships among parts of subject heading strings hinders our ability to manipulate these strings and express these relationships in different ways.

Some relationships occur within an individual subject term (i.e., within a single subfield). Although the relationships (e.g., “War and literature,” “War in literature,” and the topical subdivision under individual wars “Literature and the war”) are grammatically marked for human consumption, they cannot be explicitly marked for machine manipulation. This is part of the problem of single concepts and compound terms described above.

#### Possible solution (LCSH structure, system design):

More explicit relationships and information about categories of headings would help retain the benefits of pre-coordinated subject headings (precision, context for browsing) while overcoming some of the limitations of our current implementation (cryptic syntax, inflexible citation order). More precise coding of syntactic relationships would increase our ability to make the meaning of subject strings clearer and the display of LCSH less cryptic.

For example, “$x History” as a subdivision generally means “history of” something. So what currently shows as “United States–History” could be displayed to users as “History of the United States” or “United States, History of” depending on context or need. Significant parts of the meaning of an LCSH string depend on citation order, but if these meanings were displayed more explicitly rather than just using “dash dash,” they would be clearer to users. For example, “United States $x Geography” could be displayed as “Geography of the United States” and “Geography $z United States,” could be displayed as “Geography (discipline) in the United States.” This distinction would be totally lost in a naÃ¯ve conversion to a post-coordinate system using current LCSH, but could be preserved in a faceted system. Many existing headings could be converted to clearer display forms using algorithms. The cases where this cannot be done in a rule-based fashion generally point to some inadequacy in our current syntax or encoding. For example, the fact that we don’t know whether “Detectives $z Egypt” means “Detectives from Egypt/Egyptian detectives” or “Detectives in Egypt” is a weakness of our current system.

The inflexibility of citation order in subject strings is only partially overcome by so-called rotating browse lists that provide entry points starting with each element of a heading string. Rotating browse list can also have significant drawbacks and lead to confusion or loss of precision. In our OPAC, the way the headings are rotated means that there is no way for a user to distinguish between or do an effective search for “History $x Philosophy” (philosophy of history) and “Philosophy $x History” (history of philosophy) despite the fact that these are two very different things. If more explicit information about the relationships between the elements of subject heading string could be displayed, more citation orders would become possible without conflating things together incorrectly.

## Conclusion

A number of changes to the structure of LCSH could create a vocabulary that better supports browsing and navigation in faceted interfaces. If we think of elements of LCSH as building blocks related to each other in a rule-based manner rather than hard-coded strings, if we created more consistent and complete relationships between terms and parts of terms, and if we had a method for marking in LCSH vocabulary the single concepts and the characteristics of division by which they have been analyzed, we might be able to build a more useful and flexible system of subject access. LCSH would also benefit from the creation of a more rigorous and consistent syndetic structure, more granular coding of exact chronological ranges, and mapping headings to topical categories (legal, economic) and functional groups (classes of persons, religions).

Some changes in practice could also be beneficial. These include explicit coding of all facets of subject headings, including those currently considered to be implicit and much chronological information, as well as the use of selected broad-bucket headings for browsing access.

Faceted interfaces to existing LCSH could be improved by incorporating cross-references from subject authority records and consolidating certain synonymous terms for display, such as many geographical headings (“Arkansas” and “Ark.”) and certain subject subdivisions (“$x Social conditions” and “$x Social aspects”). Some of the desirable features of FAST, such as hierarchical geographic information, can be mapped from existing LCSH headings. Some of the topical and functional categorization described above could probably be done without modifying LCSH and be synchronized with existing LCSH records.

## References

Anderson, J. D., & Hofmann, M. A. (2006). A Fully Faceted Syntax for Library of Congress Subject Headings. *Cataloging & Classification Quarterly*, *43*(1), 7-38. ([COinS](https://journal.code4lib.org/coins))

Dean, R. J. (2003). FAST: Development of Simplified Headings for Metadata. Paper presented at Authority Control: Definition and International Experiences Conference, Florence, Italy. Retrieved October 14, 2007, from [http://www.sba.unifi.it/ac/relazioni/dean\_eng.pdf](http://www.sba.unifi.it/ac/relazioni/dean_eng.pdf)

Frommeyer, J. (2004). Chronological Terms and Period Subdivisions in LCSH, RAMEAU, and RSWK: Development of an Integrative Model for Time Retrieval across Various Online Catalogs. *Library Resources & Technical Services*, *48*(3), 199-212.([COinS](https://journal.code4lib.org/coins))

Hemmasi, H. (1996). The Music Thesaurus: A Faceted Approach to LCSH. Paper presented at Authority Control in the 21st Century: An Invitational Conference, Dublin, OH. Retrieved from [http://digitalarchive.oclc.org/da/ViewObjectMain.jsp?fileid=0000003520:000000091791&reqid=354&frame=false](http://digitalarchive.oclc.org/da/ViewObjectMain.jsp?fileid=0000003520:000000091791&reqid=354&frame=false)

Library of Congress Cataloging Policy and Support Office (CPSO). (2007). *Subject Cataloging Manual: Subject Headings*. Retrieved October 13, 2007, from Cataloger’s Desktop. ([COinS](https://journal.code4lib.org/coins))

McBride, J. L. (2000). Faceted Subject Access for Music Through USMARC: A Case for Linked Fields. *Cataloging & Classification Quarterly*, *31*(1), 15-30.([COinS](https://journal.code4lib.org/coins))

Petras, V., Meiske, M., Larson, R., Zernecke, J., Carl, K., & Buckland, M. (2005). Leveraging Library of Congress Subject Headings to Improve Search for Events – A Time Period Directory. Retrieved from [http://metadata.sims.berkeley.edu/tpd/TPD-report.pdf](http://metadata.sims.berkeley.edu/tpd/TPD-report.pdf)

Rosch, E. (1978). Principles of Categorization. In E. Rosch & B. B. Lloyd (Eds.), *Cognition and Categorization*. Hillsdale, NJ: Lawrence Erlbaum Associates (pp. 27-48).([COinS](https://journal.code4lib.org/coins))

Slavic, A., & Cordeiro, M. I. (2004). Core Requirements for Automation of Analytico-Synthetic Classifications. *Proceedings International Society for Knowledge Organization Conference*. Retrieved from [http://dlist.sir.arizona.edu/651](http://dlist.sir.arizona.edu/651)

Svenonius, E. (1992). Proposal #2: The Expanded Use of Free-Floating Subdivisions in the Library of Congress Subject Headings System: Arguments in Favor In M. O. Conway (Ed.), *The Future of Subdivisions in the Library of Congress Subject Headings System: Report from the Subject Subdivision Conference Sponsored by the Library of Congress, May 9-12, 1991* (pp. 36-38). Washington, DC: Library of Congress Cataloging Distribution Service.

Svenonius, E. (2000). LCSH: Semantics, Syntax, and Specificity. *Cataloging & Classification Quarterly*, *29*(1/2), 17-30.([COinS](https://journal.code4lib.org/coins))

Svenonius, E. (2003). Design of Controlled Vocabularies. In M. Drake (Ed.), *Encyclopedia of Library and Information Science*. New York: Marcel Dekker (pp. 822-838).([COinS](https://journal.code4lib.org/coins))

Tunkelang, Daniel. (2006). Dynamic Category Sets: An Approach for Faceted Search. Paper presented at SIGIR ’06 Workshop on Faceted Search Conference, Seattle, WA. Retrieved October 14, 2007, from [http://www.cs.cmu.edu/~quixote/DynamicCategorySets.pdf](http://www.cs.cmu.edu/%7Equixote/DynamicCategorySets.pdf)

UC Berkeley School of Information. (n.d.). The Flamenco Search Interface Project. Retrieved October 13, 2007, from [http://flamenco.berkeley.edu](http://flamenco.berkeley.edu/)

Vickery, B. C. (1970). *Faceted Classification: A Guide to the Construction and Use of Special Schemes* (Reprinted with additional material). London, England: Aslib. ([COinS](https://journal.code4lib.org/coins))

Yee, K., Swearingen, K., Li, K., & Hearst, M. (2003). Faceted Metadata for Image Search and Browsing. *Proceedings of the ACM Conference on Computer-Human Interaction*, 401-408. ([COinS](https://journal.code4lib.org/coins))

Yee, M. M. (2001). Two Genre and Form Lists for Moving Image and Broadcast Materials: A Comparison. *Cataloging & Classification Quarterly*, *31*(3/4), 237-295. ([COinS](https://journal.code4lib.org/coins))

Kelley McGrath is Cataloging & Metadata Services Librarian (Audiovisual) at Ball State University and also serves as the chair of Online Audiovisual Catalogers (OLAC) Cataloging Policy Committee. She can be reached at kmcgrath at bsu dot edu.
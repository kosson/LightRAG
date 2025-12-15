---
title: "Identifying FRBR Work-Level Data in MARC Bibliographic Records for Manifestations of Moving Images"
source: "https://journal.code4lib.org/articles/775"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-12-15
created: 2025-01-10
description: "The library metadata community is dealing with the challenge of implementing the conceptual model, Functional Requirements for Bibliographic Records (FRBR). In response, the Online Audiovisual Catalogers (OLAC) created a task force to study the issues related to creating and using FRBR-based work-level records for moving images. This article presents one part of the task force's [...]"
tags:
  - "clippings"
---
# Identifying FRBR Work-Level Data in MARC Bibliographic Records for Manifestations of Moving Images
Kelley McGrath, Lynne Bisko

The library metadata community is dealing with the challenge of implementing the conceptual model, Functional Requirements for Bibliographic Records (FRBR). In response, the Online Audiovisual Catalogers (OLAC) created a task force to study the issues related to creating and using FRBR-based work-level records for moving images. This article presents one part of the task force’s work: it looks at the feasibility of creating provisional FRBR work-level records for moving images by extracting data from existing manifestation-level bibliographic records. Using a sample of 941 MARC records, a subgroup of the task force conducted a pilot project to look at five characteristics of moving image works. Here they discuss their methodology; analysis; selected results for two elements, original date (year) and director name; and conclude with some suggested changes to MARC coding and current cataloging policy.

## Introduction

In 1998, the International Federation of Library Associations and Institutions (IFLA) issued a report on the Functional Requirements for Bibliographic Records (FRBR) [\[1\]](https://journal.code4lib.org/articles/#note1) that presents a conceptual, entity-relationship model of the information represented in existing library catalog records for bibliographic objects, such as books or videos. The FRBR report discusses four bibliographic entities ranging from the most abstract to most concrete: work, expression, manifestation and item. These terms are defined as follows:

- Work: a distinct intellectual or artistic creation
- Expression: the intellectual or artistic realization of a work
- Manifestation: the physical embodiment of an expression of a work
- Item: a single exemplar of a manifestation

(FRBR Report, p. 13 [\[1\]](https://journal.code4lib.org/articles/#note1))

Current standard MARC bibliographic records [\[2\]](https://journal.code4lib.org/articles/#note2) generally describe a specific manifestation. However, they often include information about the expression or work mixed in with manifestation-level information. Current MARC authority records generally represent works or expressions, but tend to include only enough information to uniquely identify the work or expression rather than a more complete description.

Existing FRBR-inspired implementations consist mostly of what Jonathan Rochkind calls “grouping records into work sets” or “collocating records for the work” [\[3\]](https://journal.code4lib.org/articles/#note3) rather than a complete implementation of the FRBR model. Presentation of work sets is useful in that most users are probably primarily interested in finding works and then identifying specific expressions or manifestations that are accessible or desirable to them. However, work sets fail to realize the full potential of the FRBR model. If separate work records were created and maintained, more accurate information could be explicitly recorded rather than whatever happens to surface from automated clustering, such as that used by WorldCat Local. Creating and maintaining work-level records is also more likely to reap economic benefits as this information can be recorded and maintained in only one place rather than reproduced in multiple manifestation-level records.

In the case of moving images, explicit work-level records are likely to provide two main benefits:

1. Since film and video are often re-issued, there are economic and efficiency incentives for making it easy to re-use this data, especially as there is often extensive information common to all versions of a moving image.
2. Library catalogs currently do a poor job of providing consistent and useful access to much of the subset of information common to all versions of a given moving image (e.g., original language, country of production, date of original release or broadcast), despite the fact that users often express interest in this information [\[4\]](https://journal.code4lib.org/articles/#note4), [\[5\]](https://journal.code4lib.org/articles/#note5) and this type of information tends to be given prominently in reference sources for moving images.

Currently we do not have work-level records for moving images, except for a relatively small number of uniform title authority records, which usually contain only title information. However, information about moving image works is often embedded in our manifestation-level bibliographic records. If we wish to move to an environment where we are creating and sharing work-level records for moving images, it would be helpful if we could use automated means to extract data from existing bibliographic records to populate provisional work-level records. These provisional records could later be verified, corrected, and enhanced by human review.

In early 2008, the Cataloging Policy Committee (CAPC) of Online Audiovisual Catalogers (OLAC) created a task force to investigate and make recommendations on issues related to FRBR-based work-level records for moving image materials [\[6\]](https://journal.code4lib.org/articles/#note6). One part of the task force was charged with identifying places in MARC manifestation-level bibliographic records where work-level information may be encoded and examining a sample of MARC records to see how reliably this information might be extrapolated from data in existing records. We also examined whether there are better ways to embed this work-level information in MARC bibliographic records for easier automated extraction or updating.

We conducted a pilot project to look at five characteristics of moving image works. In this paper, we will discuss our methodology, analysis and selected results for two elements, original date (year) and director name, and conclude with some suggested changes to current cataloging policy. Some fields that we examined are omitted here as the lessons learned are the same or very similar to those derived from the fields we do discuss. A detailed, field-by-field report of our analysis will be available on the OLAC website [\[6\]](https://journal.code4lib.org/articles/#note6).

First, we will discuss one possible scenario for using the work-level data extracted by these methods.

## One Possible Scenario for Work-Level Records for Moving Images

Before discussing how we attempted to identify and extract work-level data from existing records, we would like to briefly discuss one possible scenario for using work-level records populated with extracted data.

One possible approach to moving image cataloging is to record the reusable data in one record (what we refer to here as a work-level record and discussed in the OLAC task force’s report, parts 1-2 [\[6\]](https://journal.code4lib.org/articles/#note6), as a work/primary expression record), the manifestation-specific data in machine-comprehensible form in another record, and to link the two (or for more traditional systems, to merge them in some form; if this data is machine-analyzable, the parts that don’t vary from the original could easily be suppressed).

Most of the time, it is unclear that explicit expression-level records offer any advantages. The exception is what might be called “named” expressions, e.g., director’s cut or unrated versions, which cannot be reduced to exhaustive, controlled vocabularies and may require cross-references that cannot be anticipated prior to the creation of additional manifestations. It would be more practical to record most characteristics that may vary at the expression-level (e.g., color, duration, language access) in machine-readable form in the manifestation-level record and program the computer interface to offer this information as navigation options. In particular, for moving images in which given expressions tend to be multifaceted, it probably is not time-saving to try to locate or create an expression-level record that reflects a specific combination of options.

Below we give an example of how this combination of work- and manifestation-level records could be presented to an end user. This is not intended to be a comprehensive example nor an ideal display, but merely to present a possible idea.

| Limiters (from manifestation-level records) | Work |
| --- | --- |
| Available at:  - Ball State University Libraries - Muncie Public Library  Format:  - DVD - Blu-ray - VHS  Spoken language:  - English - Spanish - French - Chinese  Subtitle/caption language:  - English - Spanish - Thai  Accessibility options:  - Audio-described - Captioned  Aspect:  - Fullscreen - Widescreen (1.37 : 1)  Color:  - Black and white - Colorized  Publisher/Distributor:  - Warner Home Video  Special features:  - Commentary track - Carrotblanca (cartoon starring Bugs Bunny) - Who holds tomorrow? (1955 television adaptation of Casablanca) - Casablanca (Screen Guild Players radio production) - Outtakes gallery | Title: Casablanca   Date: 1942  Director: Curtiz, Michael, 1888-1962.   Producer: Wallis, Hal B., 1899-1986.   Writers: Epstein, Julius J., 1909- ; Epstein, Philip G. ; Koch, Howard.   Production company: Warner Bros. Pictures   Cast: Bogart, Humphrey, 1899-1957 ; Bergman, Ingrid, 1915-1982  \[additional creators and contributors could be included\]  Summary: During World War II, Rick’s Café in Casablanca is a center for war refugees awaiting visas for America. Rick abandons his cynicism to help an old love escape the Nazis with her underground leader husband.   Genre: Drama ; Romance ; Adaptation   Setting: Casablanca, Morocco, Africa   Time period: World War II  Language: English   Country of production: United States   Run time: 102 min.   Color: Black and white   Sound: Mono.   Aspect ratio: 1.37 : 1  Awards: Academy Award (Best Picture ; Best Director ; Best Writing, Screenplay)  Based on: Everyone comes to Rick’s (play)   Authors of play: Burnett, Murray ; Alison, Joan |

If the data in the work-level display on the right were recorded in a separate record, mechanisms currently exist to extract most of the data on the left from related MARC bibliographic records, assuming full and accurate records. The notable exceptions are that there is no reliable way to extract aspect ratio or special features in the form given here. Missing or mistaken data will have some impact on implementation, but could be improved retrospectively.

Although it seems desirable to many to store data for bibliographic materials in a multi-record, FRBR-based structure, the transition by the diverse and under-funded library world to a new structure is likely to be difficult and to proceed at different paces in different institutions. Creation of work-based records that can be linked to and used both with existing manifestation records and future, leaner manifestation records created in a more robust model would provide one way of easing this transition.

## Methodology

### Overview

We identified a representative sample of work-level information for moving images and used our knowledge of cataloging rules and practices to identify all possible fields and subfields where this information might occur in MARC records. We then evaluated possible MARC data sources, based on how commonly they are used and how amenable they are to reliable automatic extraction, and selected the most promising for processing.

In order to test the usefulness of our selected data sources, we acquired from a variety of types of institutions a sample of MARC bibliographic records that describe a range of moving images, including features, television programs, and nonfiction films. We extracted from these MARC records the fields and subfields from which we wished to extract data, as well as those deemed useful for evaluating the accuracy of the extracted data. We wrote brief programs and queries to automatically extract the values of interest and then manually reviewed the results. The manual review was useful in that it allowed us to identify patterns of problems. This will enable us to improve future iterations of our program and also possibly to proactively identify records that are more likely to need manual intervention. The manual review also allowed us to make more accurate assessments of the relative usefulness and reliability of data from the various sources.

Our analysis has enabled us to suggest two types of improvements to enhance our ability to more effectively record and identify this type of data in the future. The first is to recommend the use of specific cataloging practices that are possible in the current infrastructure and that would support the machine-manipulable recording of data in which we are interested. The second is that, when we have identified areas where it is not possible to record useful data in machine-manipulable form, we can create proposals to expand the MARC format to support this type of data input.

### Location of Data in MARC Records

We selected the fields from which to extract data based on the estimated accuracy of the data for our purposes and our perception of how often these fields are used. We decided to limit our data sources to those that have a high probability of containing correct data in a form that can be extracted without manual review.

### Selection of Records for Sample Testing

We obtained a sample of 941 MARC records from six institutions, primarily via Z39.50. These included records from a public library, two medium-sized academic libraries, two large academic libraries and a film archive, all of whom do at least some local editing of their records. The records we selected included well-known feature films likely to have multiple releases, non-English language films in languages using both Roman and non-Roman alphabets, and a general keyword search (“sleep”) intended to retrieve a variety of records, including nonfiction, television shows and features.

### Processing and Review of Sample Records

Once we obtained the records, we used MarcEdit, a free Windows-based MARC editing tool [\[7\]](https://journal.code4lib.org/articles/#note7), to export the relevant data in tab-delimited form. MarcEdit lets users specify data for export at the field and subfield level. We exported the fields/subfields we wanted to extract data from, as well as any fields/subfields that we thought necessary to assess the results of automated processing. We imported the data into Microsoft Access and used queries and Visual Basic for Applications (VBA) to manipulate it. We used Access primarily because one of our group members was familiar with it and it seemed likely to suffice for our proof-of-concept project. We normalized the data by removing diacritics, most punctuation and some subfield coding. We retained punctuation that we intended to use, such as semi-colons in statements of responsibility. We used queries and text processing to extract the relevant data. This process is described in more detail in the individual review sections.

Following this, we reviewed our results manually to determine if the information had been correctly extracted and to identify any patterns of problems. At this point, we have only been able to examine whether or not the data was correctly extracted. In the future, we plan to assess at least a subset of our data against external sources for accuracy.

### Other Issues

We do not believe that we can accurately extract data from multi-work records (e.g., records for a set of all the James Bond movies or a collection of animated shorts). The various pieces of information that pertain to the individual works in a multi-work MARC record are not linked in any way, so it is impossible for a machine to identify, for example, which titles go with which dates or genres. It might be possible, once we have a set of provisional work-level records, to identify which works are contained in a given manifestation by matching information in the provisional work-level records to information in the manifestation records. This is an area that will require more manual intervention. We did attempt to see how accurately we can identify the multi-work records in our dataset by looking for the presence of things like non-collective titles and analytical titles. We were able to identify almost all of the multi-work records through the presence of information such as Contents Note (505) fields in the record, but we did have a fairly high level of false drops (31%). Based on manual review, 79% of our records represent single works and an additional 6% are records for a main work that mention subsidiary work(s) not likely to interfere with extraction of data about the main work.

We are not sure what the threshold should be for reasonable reliability of this information. It is clear that information derived from manifestation-level bibliographic records will be incomplete and at times incorrect so we will eventually have to decide on an acceptable level of accuracy. For works that have been issued in many versions, our results may be improved with clustering of manifestation-level records for the same work.

## Analysis of Individual Characteristics: Original Date

### Fields and Areas of the MARC Record Examined

We attempted to extract the original date from existing MARC bibliographic records for moving images via a number of methods, including:

1. **Date2 008 (Part of MARC 008 control field)**. When present in the record, this date is the most reliable method of determining the original date for moving image works. For many videos, “Type of date/Publication status” is coded “p” for “Date of distribution/release/issue and production/recording session when different,” the original motion picture date is given in Date2 and the publication date of the video is given in Date1.
2. **Date/Time and Place of an Event (033)**. This field includes a formatted date/time of creation, capture or broadcast associated with an event in the form yyyymmddhhmm+-hmm. It seems to be more commonly used by archives.
3. **Uniform Title (130)**. The original date is sometimes found here when needed to distinguish between two moving images with the same title.
4. **General Note (500)**. These notes were parsed to look for years in 18xx, 19xx, or 20xx format in combination with a limited set of keywords (e.g., broadcast, produced) that often indicate that the note refers to the original date of the work.

We also examined data from the Date/Time and Place of an Event Note (518) field, but the issues we encountered are similar to those for the General Note (500) field so we have not discussed it here. The original date may exist in other fields in the record, but we deemed the ones we examined to be the most likely sources for reliable information about the original date.

The most common place the original date may be found, other than those described above, is in Date1 of the 008 field. However, we did not include Date1 in our project because there is no automated means to distinguish between the following scenarios:

1. The date of publication of the video and the date of the work are the same so there is only one date to put in the fixed fields and it is in Date1
2. The date in Date1 is the date of publication of the video and there is no date in Date2 because:  
a. The cataloger forgot or chose not to do the research to determine the original date  
b. The cataloger is following newer policies in which changes or additions (e.g., subtitle tracks, making-of featurettes) to the content of the original moving image work make the DVD a new publication with a single date.

The publication date subfield of the Publication, Distribution, etc. (260$c) field has similar problems.

### Process

We created queries in Access to identify records with data in the fields/subfields we intended to examine. In some cases, data identification was fairly straightforward. For example, Date2 is part of the MARC 008 field (fixed-length data elements, general information) in which meaning is determined by the character’s position in the string. In the case of Date2, we identified a desirable date type in the 06 position in 008 and then extracted the date in positions 11-14. We recorded the extracted data in a separate Access field using field names such as MARC500 for the original General Note (500) field data and Date500 for the year(s) extracted from the General Note (500) field.

The process for the Date/Time and Place of an Event (033) field was similar to that for Date2 of the 008 except that when multiple dates existed we used subfield coding to identify individual date strings and then extracted each year separately.

In the case of the Uniform Title (130) field for moving images, the date is unfortunately not specified by a separate subfield code. We relied on a standard citation format (“Title (Motion picture/Television program : \[date\] : \[director’s last name\])”) that assumed a qualifier of “motion picture” or “television program” and the use of a colon before the date. As it turned out, most, but not all, moving image uniform titles include a qualifier and some included non-standard qualifiers, such as cartoon. We would have been better off removing the standard qualifiers and using the opening parenthesis to identify the location of the date.

Original dates are also often given in free-text form in the General Note (500) field. We used VBA to loop through each note field. Although records may contain multiple General Note (500) fields, we were able to evaluate each note separately because fields exported from MarcEdit are in tab-delimited form with a semi-colon separating each instance of a given field. We first used the instr function to determine if any of our keywords (e.g., produced, release) existed. We then looked for a year or years in 18xx, 19xx, or 20xx format and recorded all that we found. Before beginning this process, we also removed the letter c from in front of any five-character sequence that appeared to represent a year.

### Analysis

We examined our sample of 941 records from six sources. At this point we have only looked at whether we can extract dates that might be the original date. We have not assessed the extent to which these dates actually do represent the correct original date.

We found that 72% of the records had some date that potentially could be identified as the original date, while 28% did not contain any information that we could leverage. Some adjustments to our VBA extraction program would improve our results slightly. However, about one quarter of the records would still not contain information useful for automatic extrapolation of an original date, as these records include no identifiable dates in any of the fields we examined.

The two methods that worked best for extracting potential original dates were the 008 Date2 field (present in 41% of records) and the General Note (500) field (present in 39% of records). The other methods, Date/Time and Place of an Event (033) and Uniform Title (130), were each present in less than 10% of the records and these two fields were disproportionately represented in records from the film archive, which may indicate a difference between archival and standard library cataloging.

<table><tbody><tr><th colspan="7">Original Date Overview</th></tr><tr><td></td><td>008Date2</td><td>General Note (500)</td><td>Date/Time and Place of an Event (033)</td><td>Uniform Title (130)</td><td>Overall</td><td>Any Date</td></tr><tr><td>Blank field or no identifiable date in field</td><td>556</td><td>407</td><td>829</td><td>846</td><td>265</td><td>28%</td></tr><tr><td>Correctly-identified data</td><td>385</td><td>368</td><td>89</td><td>57</td><td>676</td><td>72%</td></tr><tr><td>Multiple dates</td><td>0</td><td>137</td><td>23</td><td>17</td><td>0</td><td></td></tr><tr><td>Missing keyword associated with presence of date (e.g., “produced”)</td><td>0</td><td>29</td><td>0</td><td>21</td><td>0</td><td></td></tr><tr><td>Minimum presence of data**</td><td>30%</td><td>0%</td><td>16%</td><td>0%</td><td>53%</td><td></td></tr><tr><td>Maximum presence of data**</td><td>81%</td><td>26%</td><td>70%</td><td>6%</td><td>91%</td><td></td></tr></tbody></table>

\*\* Minimum and maximum show variations in the availability of data by institution. That is, the number of records that contained useful data in 008Date2 ranged from 30% in the institution with the lowest use of this field to 81% in the institution with the highest use. These variations can reflect differences in the types of material collected, but also show the effects of local cataloging practices on the availability of data.

Some particular problems encountered in our data sample:

1. Some General Note (500) fields in our record set refer to the date associated with an external verification source, such as the publication year of the American Film Institute catalog or the date the cataloger checked the Internet Movie Database. Our program cannot distinguish between these dates and relevant dates and incorrectly uses the verification date as the original date. This could be resolved in many cases by having a hierarchy of date sources and preferring the more reliable fields.
2. Records in which General Note (500) fields contains multiple dates; one is the release date, but the earliest date refers to an event other than the release. For example, one record included the note “Based on the novel Dracula by Bram Stoker first published in London in 1897.”
3. Different or inconsistent dates in the Date/Time and Place of an Event (033) and Uniform Title (130) fields for the same video. For example, a record may contain a uniform title of “Simpsons (Television program : 1989),” qualified by the date the show began airing, as well as a Date/Time and Place of an Event (033) field of 19920507 that represents the date of a particular episode.
4. Incorrect cataloging practice for the 008 Date1 and Date2 fields, in which the dates were reversed so that the original date was in Date1 and the manifestation date was in Date2. Date1 is supposed to contain the publication date of the manifestation in hand and Date2 may contain the original release date under certain circumstances. So, this example is a non-standard use of MARC coding often employed to achieve a desired end in OPAC displays, i.e., sorting by original release rather than publication date. Or it could be that the cataloger did not know how to correctly code these fields.
5. Keywords that signal dates in General Note (500) fields that were not included in our original program, e.g., “filmed,” “copyright,” “recorded.”
6. In the Uniform Title (130) field, we also missed dates in titles that did not include the phrase “motion picture” or “television program,” but our program could be revised to pick up those dates.

### Recommendations

There should be a field in the MARC record that specifically contains the original date of a moving image work. It is probably sufficient to record the year, but may be useful to include an option for recording exact dates, particularly for episodes of television programs. Perhaps the formatted Date/Time and Place of an Event (033) field could be expanded to incorporate this use.

## Analysis of Individual Characteristics: Director

### Fields and Areas of the MARC Record Examined

Our goal was the correct identification of an Added Entry-Personal Name (700) field containing the authorized, standardized form of the director’s name. It is possible that the director’s name might occur in a Main Entry-Personal Name (100) field, but this is relatively rare and we did not account for this possibility in our sample. Director can also be traced in the Added Entry-Corporate Name (710) field. We found this type of added entry in the case of the director team The Brothers Quay in our sample. We attempted to extract the director’s name from existing MARC bibliographic records for moving images via a number of methods, including:

1. Statement of Responsibility, etc. (245$c). Many records contain a transcribed statement of responsibility that includes the director’s name and function, usually as they appear on the title frames. Moving images often list multiple functions in the statement of responsibility, with each distinct function separated by specific punctuation, i.e., space-semicolon-space. We used this prescribed punctuation to parse each function and attempt to match it with its associated authority-controlled name entry.
2. Added Entry-Personal Name (700) with Marc Relator Code ($4) subfield of drt. Some Added Entry-Personal Name (700) fields include a MARC relator code of “drt” in 700 $4 identifying that person as the director.

We also examined data in the Creation/Production Credits Note (508) field and the Relator Term (700$e) subfield. These results are not discussed here. The director’s name may exist in other places in the record, such as in Contents Note (505) fields in multi-work records, but we chose to focus on the most commonly-occurring instances.

### Process

We created queries to identify which records had data in each of the fields/subfields we intended to examine. In the case of the Added Entry-Personal Name (700) field that included a Relator Code ($4) subfield, the identification of the authorized form of the director’s name was simple. We just extracted the names that included the string “$4drt”.

For the free text Statement of Responsibility, etc. (245$c) subfield we split out each separate statement of function using the existing semi-colons. We identified each statement of function that included the letter sequence “direct” to pick up variations such as “director,” “directed, “direction,” etc. We did not attempt to account for non-English terms for director or directing in our test run nor did we attempt to distinguish other types of directors, such as directors of photography. Many libraries do not trace the other types of directors so there often is not a matching Added Entry-Personal Name (700) field in the record, which cuts down on the number of false drops. It is unlikely that we can achieve 100% accuracy discriminating between primary directors and other types of directors and directing functions in practice.

Within each statement of responsibility, we then identified the individual words. Since we had no way to automatically identify names as opposed to other types of information, we processed all words occurring in a given directing function statement. We attempted to match from the Statement of Responsibility, etc. (245$c) subfield either

1) two consecutive words or  
2) two words separated by a single word

with words occurring in an Added Entry-Personal Name (700) field. The latter helped with transcribed names with middle initials in the statement of responsibility, but not in the matching authorized form in the 700 field.

We looped through all Added Entry-Personal Name (700) fields in each record and looked for the presence of the two words identified in the Statement of Responsibility, etc. (245$c) in the Added Entry-Personal Name (700) field. For example, if the credits said “directed by Clint Eastwood,” we used the instr function to look independently for each pair of words (e.g., “directed by,” “directed Clint,” “by Clint,” etc.) , in all Added Entry-Personal Name (700) fields. The words did not have to occur consecutively or in any particular order in the Added Entry-Personal Name (700) field. On the whole, this method worked well, but did lead to a few false hits. These generally involved names with initials, which more sophisticated programming could eliminate. This does not work with one-word names, but those are relatively rare. If we did not use the two-word minimum, we would have had a lot more false matches.

### Analysis

As with the original date, we examined 941 records from six sources. We found that we could identify at least one Added Entry-Personal Name (700) field representing a director in 62% of the records. The vast majority of these (84%) were derived by matching the Statement of Responsibility, etc. (245$c) subfield with an Added Entry-Personal Name (700) field. Use of the Relator Code ($4) identified directors in about 15% of the records. The use of Relator Code ($4) subfields varied widely among institutions and ranged between 0-83% for a given institution. This reflects the impact of local cataloging practices on the usability of data for our purposes. Most of the directors identified by Relator Code ($4) were also identified by matching Added Entry-Personal Name (700) fields with Statement of Responsibility, etc. (245$c) subfields, but the use of relator codes has the advantage of eliminating the hard matching problems (e.g., accounting for foreign language terms for director and variations in spelling, transliteration and form of name).

On the other hand, a quarter of the records did not include identifiable director information in the fields we examined. Another 10% lacked an Added Entry-Personal Name (700) field that corresponded to the director(s) identified in the Statement of Responsibility, etc. (245$c) subfield. Less than 10% of the records with no director information included director in a Contents Note (505) field. The remainder either had no director information, used a different form (e.g., “a film by…”) or the cataloger omitted that information.

More sophisticated programming could improve the match rate on director information found in the Statement of Responsibility, etc. (245$c) subfield. For example, thirty names (3%) in the Statement of Responsibility, etc. (245$c) subfield failed to match because we did not look for non-English director functions such as “Regie” or “kantoku.” However, accounting for all variations would be time-consuming vis-à-vis the number of affected records. This problem is somewhat mitigated by the fact that not all libraries transcribe original language credits; many prefer to use English language credits from another source.

Some names failed to match because of variations in spelling or transliteration between the transcribed and authorized forms (e.g., “Pierre Schoendorffer” vs. “Schoendoerffer, Pierre” and “Andrei Tarkovsky” vs. “Tarkovskii, Andrei Arsenevich”). In some cases the name was traced under a different form entirely (e.g., “T. C. Frank” vs. “Laughlin, Tom”). Some match failures could be resolved by using both the official Added Entry-Personal Name (700) field form of name and the forms of name in the cross-references in the relevant authority record.

<table><tbody><tr><th colspan="5">Director Overview</th></tr><tr><td></td><td>Statement of Responsibility, etc. (245$c)</td><td>Added Entry-Personal Name with relator code (700$4)</td><td>Overall</td><td>Overall%</td></tr><tr><td>Blank field or no identifiable relevant information</td><td>492</td><td>797</td><td>237</td><td>25%</td></tr><tr><td>Correctly-identified data</td><td>310</td><td>144</td><td>584</td><td>62%</td></tr><tr><td>Problem with matching algorithm and initials; fixable with better programming</td><td>4</td><td>0</td><td>3</td><td>&lt;1%</td></tr><tr><td>Director is corporate body (710)</td><td>1</td><td>0</td><td>2</td><td>&lt;1%</td></tr><tr><td>No matching authorized name (700) for transcribed name</td><td>84</td><td>0</td><td>90</td><td>10%</td></tr><tr><td>Non-English term for director</td><td>30</td><td>0</td><td>9</td><td>1%</td></tr><tr><td>Difference in spelling or transliteration between transcribed and authorized forms of name</td><td>16</td><td>0</td><td>11</td><td>&lt;1%</td></tr><tr><td>Other difference between transcribed and authorized form of name (e.g., use of variant names or pseudonyms)</td><td>4</td><td>0</td><td>4</td><td>&lt;1%</td></tr><tr><td>Minimum presence of data**</td><td>44%</td><td>0%</td><td></td><td></td></tr><tr><td>Maximum presence of data**</td><td>69%</td><td>83%</td><td></td><td></td></tr></tbody></table>

\*\* Minimum and maximum show variations in the availability of data by institution. That is, the number of records that contained useable data in the Statement of Responsibility, etc. (245$c) subfield ranged from 44% in the institution with the lowest rate of success to 69% in this institution with the highest rate of success. These variations can reflect differences in the types of material collected, but also show the effects of local cataloging practices on the availability of data.

### Recommendations

Although the matching algorithm found authorized names in Added Entry-Personal Name (700) fields for most directors transcribed in corresponding Statement of Responsibility, etc. (245$c) subfields, a certain number of matches will inevitably be missed due to variations in form of name or non-English terms for director. Accuracy is still unlikely to reach 100%, even if we take into account authority record cross-references and include additional non-English director keywords. The automated extraction will produce “good enough” work-level records which provide a starting place for developing these records from existing metadata. The process of matching transcribed and authorized forms after the fact is inherently more complex than indicating during cataloging that this particular authorized form accurately identifies the director. The use of the MARC Relator Code ($4) subfield (or, alternatively, the MARC relator term subfield, $e) is more reliable and amenable to machine-based processing than even the most sophisticated matching algorithm and it is recommended that one of these options be used whenever possible. This is particularly useful for moving image records, which usually record a variety of functions.

## Conclusion

It would be desirable to be able to easily extract work-level information from existing MARC bibliographic records. It would also be useful, so long as current MARC bibliographic records are used, to be able to automatically insert previously verified work-level information into a new MARC bibliographic manifestation record or to update existing MARC manifestation records with corrected or expanded work-level information.

The logistical challenges associated with moving from our current environment to one utilizing related FRBR-based records are significant. The creation of work-level records that can be linked to existing manifestation-level records is a practical first step in this process that will also have worthwhile benefits for libraries and their users. It is also likely that institutions will follow different migration timetables to what RDA (Resource Description and Access, the upcoming new cataloging rules) calls a “relational/object-oriented database structure,” [\[8\]](https://journal.code4lib.org/articles/#note8) requiring a need for parallel implementations over a long time period.

If the MARC bibliographic format is updated to contain more machine-identifiable information about the work record, it is possible that these traditional manifestation-level bibliographic records could be updated with new information from collectively-maintained work records. Institutions using related work and expression and/or manifestation records would not need to repeat the redundant data and could rely on the shared collection of work-level records.

To do this, it is necessary to be able to easily and accurately identify the location of work-level data in the MARC bibliographic record. Our preliminary assessment of a sample of records suggests that varying amounts of work-level data can be extracted from existing MARC bibliographic records. About 20% of our sample consisted of multi-work records, from which we are unlikely to automatically extract work-level data due to the difficulties of matching disparate pieces of information with the correct work. We extracted potential work-level data for original date in 72% and for director in 62% of the records we examined. It is likely that we could improve our success rate by looking at patterns in clusters of records for the same work. Also, more sophisticated programming would help with better data extraction.

We have identified some cataloging practices that can be implemented in current MARC bibliographic records that will ensure that work-level data is available for machine processing, such as using relator codes or terms after the controlled form of names (e.g., MARC fields 100 and 700) whenever possible.

There are also ways in which the MARC bibliographic format could be modified to enable machine-readable encoding of data for elements that currently do not have such fields. For example, a field could be created in the MARC bibliographic record where the original date of a moving image work could be unambiguously recorded.

It is unlikely that complete, accurate work-level records could reliably be derived from existing MARC bibliographic records, but it is possible that “good-enough” provisional records could be created and then revised and manually upgraded. We think this approach bears further investigation and testing.

OLAC has produced a report providing a practical definition of a moving image work and a list of relevant data elements [\[6\]](https://journal.code4lib.org/articles/#note6). We are currently in the process of creating operational definitions and a list of information sources for five representative data elements, as well as completing the analysis of the location and potential extractability of these five elements from existing MARC bibliographic records. This paper is based on that analysis. If this work is deemed useful, we plan to expand it to include operational definitions, sources, and MARC-based analysis for additional data elements. We hope to eventually construct a publicly-available database of moving image work records based on and linked to existing MARC bibliographic records which will enable the creation, correction, maintenance and enhancement of work-level data at a collective level. This should also enable the development of an interface that allows users to search for work-level characteristics and to identify and obtain particular expressions or manifestations that they would like to use.

## Notes

\[1\] The original 1998 and current versions of the FRBR report are available at [http://www.ifla.org/VII/s13/frbr/](http://www.ifla.org/VII/s13/frbr/). Quotes are from the [PDF version of the current 2008 text](http://www.ifla.org/VII/s13/frbr/frbr_2008.pdf).

\[2\] Detailed information about the fields and subfields in the MARC Bibliographic Format is available at [http://www.loc.gov/marc/bibliographic/ecbdhome.html](http://www.loc.gov/marc/bibliographic/ecbdhome.html).

\[3\] Jonathan Rochkind. “‘FRBRization’ is not FRBRization.” Bibliographic Wilderness, [http://bibwild.wordpress.com/2008/07/31/frbrization-is-not-frbrization](http://bibwild.wordpress.com/2008/07/31/frbrization-is-not-frbrization), 31 July 2008.

\[4\] Jeannette Ho. “Faculty and Graduate Student Search Patterns and Perceptions of Videos in the Online Catalog,” *Cataloging & Classification Quarterly* 33.2 (2001): 69-88. [(COinS)](https://journal.code4lib.org/coins)

\[5\] Margaret Hume. “Searching for Media in the Online Catalog: A Qualitative Study of Media Users.” *MC Journal* 3.1 (1995): [http://wings.buffalo.edu/publications/mcjrnl/v3n1/hume.html](http://wings.buffalo.edu/publications/mcjrnl/v3n1/hume.html).

\[6\] The OLAC CAPC Moving Image Work-Level Records Task Force page with the task force’s reports is at [http://www.olacinc.org/capc/movingimagework.html](http://www.olacinc.org/capc/movingimagework.html).

\[7\] Information about MarcEdit is available at [http://oregonstate.edu/~reeset/marcedit/html/index.php](http://oregonstate.edu/%7Ereeset/marcedit/html/index.php).

\[8\] Tom Delsey. “RDA Database Implementation Scenarios,” [http://www.collectionscanada.gc.ca/jsc/docs/5editor2.pdf](http://www.collectionscanada.gc.ca/jsc/docs/5editor2.pdf), 14 January, 2007.

## About the Authors

Kelley McGrath is Cataloging & Metadata Services Librarian (Audiovisual) at Ball State University. Lynne Bisko is Non-Print Librarian at Elon University. They are members of the Online Audiovisual Catalogers (OLAC) Moving Image Work-Level Records Task Force. They can be reached at kmcgrath at bsu dot edu and lbisko at elon dot edu.
---
title: "What’s in a Name? On ‘Meaningfulness’ and Best Practices in Filenaming within the LAM Community"
source: "https://journal.code4lib.org/articles/13438"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-05-07
created: 2025-01-10
description: "Cultural institutions such as libraries, archives and museums (LAM) face many challenges with managing digital collections, particularly when it comes to organizing the individual files that make up each collection. While tools such as metadata and collection management systems support identification and arrangement for digital files, administrative control depends significantly on the mere filenaming in [...]"
tags:
  - "clippings"
---
# What’s in a Name? On ‘Meaningfulness’ and Best Practices in Filenaming within the LAM Community
Drew Krewer, Mary Wahl

Cultural institutions such as libraries, archives and museums (LAM) face many challenges with managing digital collections, particularly when it comes to organizing the individual files that make up each collection. While tools such as metadata and collection management systems support identification and arrangement for digital files, administrative control depends significantly on the mere filenaming in use beneath the surface. Anecdotal evidence has shown that many LAM institutions have specialized filenaming schemes in place for their digital collections. This paper includes a literature review of filenaming practices in the LAM community, followed by a description and analysis of survey data regarding filenaming practices in the LAM community. The purpose of the survey was to learn about filenaming conventions in use within LAM organizations who have filenaming policies in place. The data suggests that: similarities and differences exist in filenaming approaches between museums/galleries, archives/special collections, and academic institutions; it is preferred that filenaming be simultaneously meaningful to both humans and computers; and conventions that affect sortability are deemed more important than those that affect readability. The data also indicate several subtopics related to filenaming that would benefit from further study.

## Introduction

Anyone who has worked with born-digital archives or who has inherited hard drives would tell you that people organize and name files in vastly different ways. Some filenames appear standardized, such as those with uniformly formatted dates; others are more haphazard, such as those with long strings of meaningless numbers and punctuation. Often filenames rely on the memory of the file’s creator to interpret, such as those that include subjective descriptions. When it comes to LAM institutions, many have the added challenge of working with multiple versions of files. For instance, a single high resolution digital photograph master file may have a corresponding low resolution copy, a color corrected copy, a thumbnail, and perhaps several intermediary files. Librarians, archivists, digital asset managers and other related practitioners are faced with not only developing filenaming schemes for individual files, but with determining how their files make sense in context to other files, hierarchies, collections and perhaps even outside the institution.

As our technologically-driven cultures continue to rapidly increase their knowledge-production, records creators will be continually faced with the important decision of selecting and creating filenaming schemes within many varied contexts. This paper attempts to go beyond the commonly referenced [ISO Standard 9660](https://en.wikipedia.org/wiki/ISO_9660):1999 (Level 2) by assembling a collection of best practices that address logistical issues of filenaming within different organizational and workflow contexts. First, a literature review of filenaming practices in both the LAM and greater computing communities is provided. This is followed by a description and analysis of survey data regarding filenaming practices in the LAM community.

## Literature Review

While archival and library scholarship has touched on filenaming within the context of larger studies, few, if any, have focused heavily or primarily on the development of filenaming schemes. This literature review includes grey literature found online such as guidelines and project documentation created by LAM institutions; informal content on listserv archives from organizations such as Code4Lib and Society of American Archivists; and general computing documentation such as that found in Windows Dev Center.

First, by examining the literature, one can determine which filenaming conventions are most frequently mentioned. It is most useful to survey the recommendations based on their frequency of appearance, so they are grouped into three tiers below.

Most frequently mentioned:

- ISO 9660:1999 (Level 2): The elements of this standard are widely suggested (in full or altered slightly). This standard includes: a maximum of 207 characters in the filepath; use of lowercase a-z, 0-9, underscore (\_), and period; no spaces, do not begin or end with a period, must contain no more than one period; limit directory hierarchy to 8 levels, and directory names should not use periods.
- Brevity: Many emphasize keeping the filenames as short as possible.
- Standardized date: Many require that dates be standardized. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) seemed to be by far the most popular date standard, likely due to it providing the functionality of sorting by year, then by month, then by date. ISO 8601 includes date formats such as yyyy-mm-dd (e.g. 2018-03-24 for March 24, 2018).
- Version indicator: Many frequently stress the importance of version control, usually by the use of an appended indicator such as \_01, \_02; or qualifiers such as lo and hi for low and high resolution, etc.
- No special characters: It is often considered best practice to ensure that special characters (e.g. #, %, &) are not used. Issues can occur when filenames use characters that are reserved by operating systems.
- Underscores and hyphens: Though underscores are mentioned in ISO 9660, both hyphens and underscores are mentioned as ideal replacement for spaces.

Frequently mentioned:

- Meaningfulness: A moderate amount of informal literature suggests making filenames “meaningful.” This usually corresponds with aligning filenames with existing institutional knowledge such as keywords, call numbers, and accession numbers.
- [Leading zeros](https://en.wikipedia.org/wiki/Leading_zero): Many suggest adding leading zeros (e.g., 01, 001, 0001) to aid in appropriate sorting. The number of zeros used should complement the quantity of files being named.
- Unique: No two files should have the same name.

Occasionally mentioned:

- [Camel case](https://en.wikipedia.org/wiki/Camel_case): The use of camel case (e.g. gmailAccount, donorNumber) is occasionally mentioned to denote spacing. Some state that camel case is preferable to underscores/hyphens (University of Edinburgh 2015), while others suggest the appropriateness of both camel case as well as underscores and hyphens (Borer et al. 2009).
- Order of elements: Elements that construct the filename should appear in order from left to right in a way that allows users to most easily find and sort the digital assets. Care should be taken to understand how an institution retrieves information to determine this order.
- Scalability: Some literature mentions that filenaming guidelines should be extensible to include outlying materials and growing amounts of digital assets and information.
- Do not use values that could change: Using values that may change over time within a filename would create unnecessary retroactive work in the future.

Secondly, the literature review found four primary contexts in which filenaming documentation was established: digitization programs, born digital archives, business protocol, and data management services. Of the four, data management filenaming had slightly different conventions than the others. For instance, best practices recommend including information such as project or experiment names and testing conditions. Concerns with consistency across the lifespan of an experiment are also stressed (Stanford Libraries; University of Oregon Libraries).

Lastly, a primary point of contention around filenaming centers around what seems to be simultaneously both a theoretical and practical issue: whether or not unique identifiers should be “meaningful” or randomly assigned, and under what circumstances. This has been discussed as far back as 2007, for instance:

> The creation of persistent identifiers generally follows one of two conventions. The first school of thought is that the identifier should be randomly generated, embedding no semantic meaning. The second school of thought advocates that unique identifiers should carry some meaning that is understandable to those working intimately with the collection (Schreibman).

And in 2008:

> Meaningful file names work best for medium to small collections and make it easier to identify and manage the digital files. Meaningful file names don’t work as well for large collections because it is more difficult to create unique names for all items. It is also possible that the name’s meaning will be lost or change connotation over time (University of Colorado, Boulder Libraries).

The latter quote moves forward to concede that because non-descriptive filenames provide no identifying information, “the files are harder to manage outside of the database that contains the associated metadata.” It also concludes that collection characteristics and project specifications should dictate the decision to use a meaningful name vs. a non-descriptive name (University of Colorado, Boulder Libraries).

More recently, others seem to view “meaningfulness” as being a two-way street: “In the interest of preserving access to digital files, we choose file name components that are least likely to cause a problem in any environment. File names should provide context and be easily understood by humans and computers” (Frazer 2013). This positioning seems to argue that meaningful identifiers are more desirable than non-descriptive ones, as they are able to provide meaningful information to both humans and computers.

## Survey

The survey (see Appendix A) was designed to gather data regarding filenaming practices in use within libraries, archives and museums. The target audience included those working with digital collections in the LAM community. In particular, we sought to learn: 1) What filenaming conventions are in use within LAM organizations? 2) Do LAM organizations have filenaming policies in place? and 3) What is the significance of various filenaming concepts? For the purposes of the survey, a filenaming policy was defined as a set of specified rules or procedures for guiding the creation of filenames.

The online data collection tool Qualtrics was used to create and administer the survey, which consisted of 30 questions. The survey comprised primarily of multiple choice, “select all \[options\] that apply”, and open text questions. Several 5-point Likert scale questions and one forced ranking question were also included. The survey was divided into four main sections: 1) Background information regarding the role and the LAM organization in which the respondent works, as well as general filenaming practice in that organization, 2) Specific filenaming conventions in use and the context(s) in which they’re used, 3) The importance placed on various filenaming concepts, and 4) Additional comments from participants. Each question in the survey was voluntary and did not require a response in order to make a final submission.

The survey remained open for ten weeks, from February 3 through April 15, 2016. To invite participation, a description and link to the survey was shared to listservs and online newsletters whose readership emphasized the target audience. A total of 398 responses to the survey was collected.

## Survey Results and Commentary

### Background information

This section of the survey aimed to gather data regarding respondents’ LAM organization in which they work, as well as general filenaming practice in that organization.

Participants were first asked to select a description of the overall type of organization in which they work (n=371). See Table 1.

**Table 1:** Demographic breakdown of respondents

| **Respondents’ type of organization** | **Percentage of responses** |
| --- | --- |
| Academic Library | 44.2% |
| Archives/Special Collections | 25.6% |
| Other | 13.2% |
| Museum/Gallery | 12.1% |
| Public Library | 4.9% |

Participants were asked about their role in their institution. Over one-third of respondents (n=330) identified themselves as Librarians, followed by over one-quarter as Archivists. About 20% selected Other and supplied an open text explanation. Upon review of these responses, we identified a number of these to fall within another category, bringing the Other category down to 17% (and increasing several of the other categories). Remaining open text responses comprised primarily of Photographer, as well as some variation of the title Digital Assets Manager or Digital Curator. See Table 2.

**Table 2:** Professional role breakdown of respondents

| **Respondents’ role** | **Percentage of responses** |
| --- | --- |
| Librarian | 37.6% |
| Archivist | 29.4% |
| Other | 17.3% |
| IT professional | 6.1% |
| Project Manager | 6.1% |
| Assistant/technician | 3.6% |

Participants were also asked about the existence (or non-existence) of filenaming policies in place in their organizations (n=331). Participants who selected No or I don’t know were given no further questions and prompted to complete the survey by submitting their responses up to this point. Remaining respondents (n=313) were asked what kinds of policies existed and could choose more than one type. See Table 3.

**Table 3:** Filenaming policy types in use by respondents

| **Type of Filenaming Policy** | **Number of respondents** |
| --- | --- |
| One or more organization-wide policies | 28.4% |
| One or more department-wide policies | 37% |
| One or more filenaming policies per project/collection | 34.6% |

Remaining respondents (n=313) were also asked whether they felt that their filenaming policies adequately serves their needs. See Table 4.

**Table 4:** Breakdown of if current policies served respondents’ needs

| **Does Current Policy(ies) Serves Organization’s Needs?** | Percentage of respondents |
| --- | --- |
| Yes | 75.3% |
| No | 17.3% |
| I don’t know | 7.4% |

Participants who selected No were prompted to explain why their filenaming policies may not adequately serve their needs in an open text box. Fifty-one respondents provided explanations that ranged from current schemes not being extensible enough to a need for more training of staff members who are on the front lines of creating filenames. Several themes emerged from the responses. First, eight respondents mentioned the need for more buy-in within the institution to follow established guidelines. Some of these expressed that adoption was “casual” or that policies were followed as “suggestions”. One response mentioned that “compliance with naming rules is very difficult to impose or enforce without full knowledgeable support from senior management”. Another theme that appeared was the desire to have either an institution-wide policy that can be modified for smaller work units or projects, or a larger, profession-wide set of best practices. One response stated that they would prefer to have their filenaming schemes “standardized according to professional standards”. Lastly, five of the respondents expressed the challenge of having schemes in place for some collections but not others. Among these responses, filenaming policies were typically in place for digitized materials, but not others.

### Filenaming characteristics

This section of the survey aimed to gather data regarding filenaming conventions in use in the LAM community and the context(s) in which they are used.

#### Organizational approaches to naming digitized and born-digital files

Participants were asked to select what types of filenaming characteristics were being employed at their institutions according to material type. When we further drilled down to look at how specific types of institutions were responding to these questions, both similarities and differences were found in institutional approaches. Due to the low response rate of public libraries, the responses of academic libraries, archives/special collections, and museum/galleries will primarily be discussed.

**Table 5:** Types of filenaming characteristics employed – digitized material

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="8">Organization Type</td></tr><tr><td colspan="2">Academic Library</td><td colspan="2">Public Library</td><td colspan="2">Archives/Special Collections</td><td colspan="2">Museum/Gallery</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="13">For digitized material, please select the types of elements in use in your filenames</td><td>date a physical item was created</td><td>16</td><td>18.8%</td><td>1</td><td>20.0%</td><td>13</td><td>25.0%</td><td>4</td><td>10.8%</td></tr><tr><td>date a digital file was created</td><td>13</td><td>15.3%</td><td>1</td><td>20.0%</td><td>10</td><td>19.2%</td><td>8</td><td>21.6%</td></tr><tr><td>date a digital file was last modified</td><td>1</td><td>1.2%</td><td>0</td><td>0.0%</td><td>5</td><td>9.6%</td><td>0</td><td>0.0%</td></tr><tr><td>institution identifier (including any subunits of the institution)</td><td>30</td><td>35.3%</td><td>2</td><td>40.0%</td><td>23</td><td>44.2%</td><td>8</td><td>21.6%</td></tr><tr><td>collection identifier (i.e. call number, accession number)</td><td>71</td><td>83.5%</td><td>4</td><td>80.0%</td><td>43</td><td>82.7%</td><td>32</td><td>86.5%</td></tr><tr><td>item identifier</td><td>71</td><td>83.5%</td><td>5</td><td>100.0%</td><td>44</td><td>84.6%</td><td>24</td><td>64.9%</td></tr><tr><td>item subunit identifier (i.e. recto, verso, page 1, side A)</td><td>52</td><td>61.2%</td><td>4</td><td>80.0%</td><td>31</td><td>59.6%</td><td>23</td><td>62.2%</td></tr><tr><td>staff member identifier</td><td>2</td><td>2.4%</td><td>0</td><td>0.0%</td><td>3</td><td>5.8%</td><td>6</td><td>16.2%</td></tr><tr><td>physical location identifier</td><td>15</td><td>17.6%</td><td>1</td><td>20.0%</td><td>14</td><td>26.9%</td><td>2</td><td>5.4%</td></tr><tr><td>digital location identifier</td><td>6</td><td>7.1%</td><td>1</td><td>20.0%</td><td>9</td><td>17.3%</td><td>1</td><td>2.7%</td></tr><tr><td>an indication of the file’s purpose (i.e. preservation master, access copy, thumbnail)</td><td>20</td><td>23.5%</td><td>1</td><td>20.0%</td><td>16</td><td>30.8%</td><td>17</td><td>45.9%</td></tr><tr><td>an indication of the file’s quality (i.e. high resolution, lossy)</td><td>7</td><td>8.2%</td><td>3</td><td>60.0%</td><td>5</td><td>9.6%</td><td>6</td><td>16.2%</td></tr><tr><td>Other (please explain)</td><td>15</td><td>17.6%</td><td>0</td><td>0.0%</td><td>7</td><td>13.5%</td><td>7</td><td>18.9%</td></tr></tbody></table>

Institution identifiers for digitized materials seemed to be more prevalent in academic libraries and special collections/archives rather than in museums/galleries. This may be due to the fact that educational institutions may have numerous campuses or libraries, and these identifiers perhaps aid in distinguishing content across a larger institutional network. The most consistent filenaming characteristic in use seems to be the collection identifier, indicating that institutions are using identifiers to make meaningful links between digital and physical collections. Item identifiers also seem particularly common in academic libraries and archives/special collections, and museums tend to use these as well, but not as frequently as the other institutional types. Museums/galleries also seem to use indicators to distinguish various versions of a file—preservation masters vs. access copy vs. thumbnail, etc. This practice may be due to the fact that museums and art institutions frequently license out images for publication and other purposes—perhaps distinguishing versions of an image has use within a licensing workflow. See Table 5.

**Table 6:** Types of filenaming characteristics employed – born-digital material

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="8">Organization Type</td></tr><tr><td colspan="2">Academic Library</td><td colspan="2">Public Library</td><td colspan="2">Archives/Special Collections</td><td colspan="2">Museum/Gallery</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="11">For born-digital material, please select the types of elements in use in your filenames</td><td>date a digital file was created</td><td>16</td><td>32.0%</td><td>3</td><td>50.0%</td><td>18</td><td>45.0%</td><td>10</td><td>34.5%</td></tr><tr><td>date a digital file was last modified</td><td>2</td><td>4.0%</td><td>0</td><td>0.0%</td><td>7</td><td>17.5%</td><td>3</td><td>10.3%</td></tr><tr><td>institution identifier (including any subunits of the institution)</td><td>20</td><td>40.0%</td><td>1</td><td>16.7%</td><td>17</td><td>42.5%</td><td>6</td><td>20.7%</td></tr><tr><td>collection identifier (i.e. call number, accession number)</td><td>37</td><td>74.0%</td><td>3</td><td>50.0%</td><td>30</td><td>75.0%</td><td>20</td><td>69.0%</td></tr><tr><td>item identifier</td><td>41</td><td>82.0%</td><td>5</td><td>83.3%</td><td>29</td><td>72.5%</td><td>18</td><td>62.1%</td></tr><tr><td>item subunit identifier (i.e. recto, verso, page 1, side A)</td><td>17</td><td>34.0%</td><td>4</td><td>66.7%</td><td>16</td><td>40.0%</td><td>14</td><td>48.3%</td></tr><tr><td>staff member identifier</td><td>4</td><td>8.0%</td><td>1</td><td>16.7%</td><td>3</td><td>7.5%</td><td>5</td><td>17.2%</td></tr><tr><td>digital location identifier</td><td>3</td><td>6.0%</td><td>3</td><td>50.0%</td><td>5</td><td>12.5%</td><td>2</td><td>6.9%</td></tr><tr><td>an indication of the file’s purpose (i.e. preservation master, access copy, thumbnail)</td><td>9</td><td>18.0%</td><td>3</td><td>50.0%</td><td>13</td><td>32.5%</td><td>9</td><td>31.0%</td></tr><tr><td>an indication of the file’s quality (i.e. high resolution, lossy)</td><td>3</td><td>6.0%</td><td>2</td><td>33.3%</td><td>3</td><td>7.5%</td><td>2</td><td>6.9%</td></tr><tr><td>Other (please explain)</td><td>7</td><td>14.0%</td><td>0</td><td>0.0%</td><td>8</td><td>20.0%</td><td>6</td><td>20.7%</td></tr></tbody></table>

Upon review of the data in Table 6 and comparing it to Table 5, it appears there is a sharp increase (compared to digitized material) in filenaming characteristics including the date a digital file was created, though using a modification date in the filename seems to still not be a priority. Again, institutional identifiers seemed to be more prevalent in non-museum/gallery settings, and both collection and item identifiers are common practices for born-digital filenaming. The use of sub-unit identifiers (recto, verso, page 1, side A, etc.) does become less prevalent with born digital materials when compared to digitized materials, likely due to the significant characteristics of digital materials vs. physical materials. Due to the phrasing of the survey question, participants’ answers may refer to either born digital files given to the institution (and then renamed) and born digital files created by the institution (therefore named upon creation).

#### Organizational beliefs on the purpose and characteristics of filenaming

In addition to benchmarking how organizations name digitized and born-digital files, the survey sought to gauge foundational beliefs about filenaming that could influence an organization’s approach to creating filenaming convention(s).

The data in Table 7 supports the idea that filenames should be both human and machine-readable. The majority of institutions either agreed or strongly agreed that filenames should be meaningful to both humans and computers. No respondents strongly disagreed, and a few respondents were neutral in their opinion. This desire for meaningfulness in filenaming is also supported by the findings in Table 8, which indicates that most institutions either disagree or strongly disagree that filenames should be randomly generated by software or a system managing the files.

Questions in the survey also addressed whether the meaning of filenames should be understood both inside and outside the organization. Most respondents either agreed or strongly agreed that filenaming should primarily be meaningful to the person or organization managing the files (see Table 9). Between 19.6% and 27.6% of each type of organization were neutral in their opinion. It is interesting to note, however, that 11.8% of respondents working in an archives/special collections setting and 15.8% of respondents working in a museum/gallery setting disagreed that filenames should mainly serve to provide meaning to internal stakeholders. This might indicate that the filenames in use might be serving as an access point for the users of these specific institutions. In looking at all organizational attitudes toward whether filenames should be understandable to individuals outside of an organization, institutions seem particularly divided in opinion (see Table 10). This could indicate that decisions to make files externally meaningful are intimately linked to service models, workflows, access points, and other defining qualities of an institution’s operational approach.

**Table 7:** Levels of agreement regarding human vs. machine-readable

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="10">Organization Type</td></tr><tr><td colspan="2">Academic Library</td><td colspan="2">Public Library</td><td colspan="2">Archives/Special Collections</td><td colspan="2">Museum/Gallery</td><td colspan="2">Other (please explain)</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="5">Filenames should be BOTH meaningful to humans/organizations AND machine readable.</td><td>Strongly disagree</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td></tr><tr><td>Disagree</td><td>3</td><td>3.4%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>5</td><td>13.2%</td><td>2</td><td>6.9%</td></tr><tr><td>Neither Agree nor Disagree</td><td>13</td><td>14.9%</td><td>2</td><td>40.0%</td><td>6</td><td>11.8%</td><td>3</td><td>7.9%</td><td>1</td><td>3.4%</td></tr><tr><td>Agree</td><td>27</td><td>31.0%</td><td>2</td><td>40.0%</td><td>20</td><td>39.2%</td><td>12</td><td>31.6%</td><td>10</td><td>34.5%</td></tr><tr><td>Strongly Agree</td><td>44</td><td>50.6%</td><td>1</td><td>20.0%</td><td>25</td><td>49.0%</td><td>18</td><td>47.4%</td><td>16</td><td>55.2%</td></tr></tbody></table>

**Table 8:** Levels of agreement regarding name assignment

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="10">Organization Type</td></tr><tr><td colspan="2">Academic Library</td><td colspan="2">Public Library</td><td colspan="2">Archives/Special Collections</td><td colspan="2">Museum/Gallery</td><td colspan="2">Other (please explain)</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="5">Filenames should be randomly assigned by the software or system managing the files.</td><td>Strongly disagree</td><td>29</td><td>33.3%</td><td>1</td><td>20.0%</td><td>22</td><td>43.1%</td><td>16</td><td>42.1%</td><td>11</td><td>37.9%</td></tr><tr><td>Disagree</td><td>29</td><td>33.3%</td><td>3</td><td>60.0%</td><td>16</td><td>31.4%</td><td>9</td><td>23.7%</td><td>7</td><td>24.1%</td></tr><tr><td>Neither Agree nor Disagree</td><td>17</td><td>19.5%</td><td>0</td><td>0.0%</td><td>9</td><td>17.6%</td><td>9</td><td>23.7%</td><td>8</td><td>27.6%</td></tr><tr><td>Agree</td><td>9</td><td>10.3%</td><td>0</td><td>0.0%</td><td>3</td><td>5.9%</td><td>2</td><td>5.3%</td><td>2</td><td>6.9%</td></tr><tr><td>Strongly Agree</td><td>3</td><td>3.4%</td><td>1</td><td>20.0%</td><td>1</td><td>2.0%</td><td>2</td><td>5.3%</td><td>1</td><td>3.4%</td></tr></tbody></table>

**Table 9:** Levels of agreement regarding external understandability

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="10">Organization Type</td></tr><tr><td colspan="2">Academic Library</td><td colspan="2">Public Library</td><td colspan="2">Archives/Special Collections</td><td colspan="2">Museum/Gallery</td><td colspan="2">Other (please explain)</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="5">It is important for filenames to be understandable to individuals outside of my organization.</td><td>Strongly disagree</td><td>7</td><td>8.0%</td><td>0</td><td>0.0%</td><td>5</td><td>9.8%</td><td>4</td><td>10.5%</td><td>0</td><td>0.0%</td></tr><tr><td>Disagree</td><td>18</td><td>20.7%</td><td>1</td><td>20.0%</td><td>9</td><td>17.6%</td><td>8</td><td>21.1%</td><td>9</td><td>31.0%</td></tr><tr><td>Neither Agree nor Disagree</td><td>27</td><td>31.0%</td><td>2</td><td>40.0%</td><td>11</td><td>21.6%</td><td>14</td><td>36.8%</td><td>6</td><td>20.7%</td></tr><tr><td>Agree</td><td>28</td><td>32.2%</td><td>1</td><td>20.0%</td><td>17</td><td>33.3%</td><td>9</td><td>23.7%</td><td>6</td><td>20.7%</td></tr><tr><td>Strongly Agree</td><td>7</td><td>8.0%</td><td>1</td><td>20.0%</td><td>9</td><td>17.6%</td><td>3</td><td>7.9%</td><td>8</td><td>27.6%</td></tr></tbody></table>

**Table 10:** Levels of agreement regarding internal understandability

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="10">Organization Type</td></tr><tr><td colspan="2">Academic Library</td><td colspan="2">Public Library</td><td colspan="2">Archives/Special Collections</td><td colspan="2">Museum/Gallery</td><td colspan="2">Other (please explain)</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="5">Filenames should primarily be meaningful to the person or organization managing the files.</td><td>Strongly disagree</td><td>1</td><td>1.1%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>2</td><td>5.3%</td><td>1</td><td>3.4%</td></tr><tr><td>Disagree</td><td>8</td><td>9.2%</td><td>0</td><td>0.0%</td><td>6</td><td>11.8%</td><td>6</td><td>15.8%</td><td>2</td><td>6.9%</td></tr><tr><td>Neither Agree nor Disagree</td><td>20</td><td>23.0%</td><td>0</td><td>0.0%</td><td>10</td><td>19.6%</td><td>9</td><td>23.7%</td><td>8</td><td>27.6%</td></tr><tr><td>Agree</td><td>35</td><td>40.2%</td><td>4</td><td>80.0%</td><td>15</td><td>29.4%</td><td>10</td><td>26.3%</td><td>12</td><td>41.4%</td></tr><tr><td>Strongly Agree</td><td>23</td><td>26.4%</td><td>1</td><td>20.0%</td><td>20</td><td>39.2%</td><td>11</td><td>28.9%</td><td>6</td><td>20.7%</td></tr></tbody></table>

#### Job roles and importance of filenaming to workflows

The survey also sought to understand if individuals with particular job roles might have different perspectives on the importance of filenaming. Several statements were listed to gauge how filenaming supports and enhances both short- and long-term job functions. Some of these statements are listed below, along with an interpretation of the collected data.

##### Filenaming is important to the productivity of the unit producing the files.

Most respondents either agreed or strongly agreed with this statement (see Table 11). Over 70% of both project managers and individuals in a digital collections role strongly agreed. This data seem to recommend that if one is attempting to establish a filenaming convention for a digital services unit or other similar department, it would be wise to receive feedback from those intimately involved in file creation and management to determine how to create a filename that optimizes efficiency.

**Table 11:** Levels of agreement regarding filenaming and productivity

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="14">Which of the following best describes your role where you work? (select one)</td></tr><tr><td colspan="2">Librarian</td><td colspan="2">Archivist</td><td colspan="2">Project manager</td><td colspan="2">IT professional</td><td colspan="2">Assistant/Technician</td><td colspan="2">Other (please explain)</td><td colspan="2">Digital Collections Position</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="5">Filenaming is important to the productivity of the unit producing the files.</td><td>Strongly Disagree</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td></tr><tr><td>Disagree</td><td>1</td><td>1.5%</td><td>2</td><td>3.3%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>1</td><td>7.1%</td></tr><tr><td>Neither Agree nor Disagree</td><td>9</td><td>13.6%</td><td>10</td><td>16.7%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>4</td><td>18.2%</td><td>2</td><td>9.5%</td><td>1</td><td>7.1%</td></tr><tr><td>Agree</td><td>25</td><td>37.9%</td><td>32</td><td>53.3%</td><td>3</td><td>25.0%</td><td>4</td><td>50.0%</td><td>9</td><td>40.9%</td><td>7</td><td>33.3%</td><td>2</td><td>14.3%</td></tr><tr><td>Strongly Agree</td><td>31</td><td>47.0%</td><td>16</td><td>26.7%</td><td>9</td><td>75.0%</td><td>4</td><td>50.0%</td><td>9</td><td>40.9%</td><td>12</td><td>57.1%</td><td>10</td><td>71.4%</td></tr></tbody></table>

##### Filenaming is important to relating digital files to other related content (i.e. finding aids, MARC records, METS records).

A sizeable number of respondents neither agreed or disagreed with this statement, but a larger amount of respondents either agreed or strongly agreed (see Table 12). This indicates a wide range of practice; filenames may either not be used to relate files to descriptive information or they may be used to serve as an identifier that more broadly integrates the file into various operational functions within the institution.

**Table 12:** Levels of agreement regarding relatability between files

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="14">Which of the following best describes your role where you work? (select one)</td></tr><tr><td colspan="2">Librarian</td><td colspan="2">Archivist</td><td colspan="2">Project manager</td><td colspan="2">IT professional</td><td colspan="2">Assistant/Technician</td><td colspan="2">Other (please explain)</td><td colspan="2">Digital Collections Position</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="5">Filenaming is important to relating digital files to other related content (i.e. finding aids, MARC records, METS records).</td><td>Strongly Disagree</td><td>1</td><td>1.5%</td><td>1</td><td>1.7%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>1</td><td>4.5%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td></tr><tr><td>Disagree</td><td>6</td><td>9.1%</td><td>3</td><td>5.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>2</td><td>9.1%</td><td>2</td><td>9.5%</td><td>2</td><td>14.3%</td></tr><tr><td>Neither Agree nor Disagree</td><td>23</td><td>34.8%</td><td>19</td><td>31.7%</td><td>3</td><td>27.3%</td><td>3</td><td>37.5%</td><td>6</td><td>27.3%</td><td>6</td><td>28.6%</td><td>3</td><td>21.4%</td></tr><tr><td>Agree</td><td>25</td><td>37.9%</td><td>20</td><td>33.3%</td><td>5</td><td>45.5%</td><td>3</td><td>37.5%</td><td>9</td><td>40.9%</td><td>4</td><td>19.0%</td><td>5</td><td>35.7%</td></tr><tr><td>Strongly Agree</td><td>11</td><td>16.7%</td><td>17</td><td>28.3%</td><td>3</td><td>27.3%</td><td>2</td><td>25.0%</td><td>4</td><td>18.2%</td><td>9</td><td>42.9%</td><td>4</td><td>28.6%</td></tr></tbody></table>

##### Filenaming is important to the long-term management of digital files.

An overwhelming number of respondents either agreed or strongly agreed that filenaming is important to the long-term management of digital files (see Table 13). With such a strong response to this statement, it is clear to professionals in the field that a filenaming convention is essential to the long-term success of digital programs. As institutions establish programs that produce large quantities of files, it becomes very important to establish meaningful filenames as early as possible.

**Table 13:** Levels of agreement regarding long-term management of digital files

<table><colgroup><col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col> <col></colgroup><tbody><tr><td colspan="2" rowspan="3"></td><td colspan="14">Which of the following best describes your role where you work? (select one)</td></tr><tr><td colspan="2">Librarian</td><td colspan="2">Archivist</td><td colspan="2">Project manager</td><td colspan="2">IT professional</td><td colspan="2">Assistant/Technician</td><td colspan="2">Other (please explain)</td><td colspan="2">Digital Collections Position</td></tr><tr><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td><td>Count</td><td>Column N %</td></tr><tr><td rowspan="5">Filenaming is important to the long-term management of digital files.</td><td>Strongly Disagree</td><td>1</td><td>1.5%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td></tr><tr><td>Disagree</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td><td>1</td><td>4.5%</td><td>0</td><td>0.0%</td><td>1</td><td>7.1%</td></tr><tr><td>Neither Agree nor Disagree</td><td>1</td><td>1.5%</td><td>1</td><td>1.7%</td><td>2</td><td>16.7%</td><td>1</td><td>14.3%</td><td>1</td><td>4.5%</td><td>0</td><td>0.0%</td><td>0</td><td>0.0%</td></tr><tr><td>Agree</td><td>15</td><td>22.7%</td><td>16</td><td>26.7%</td><td>2</td><td>16.7%</td><td>3</td><td>42.9%</td><td>3</td><td>13.6%</td><td>5</td><td>23.8%</td><td>2</td><td>14.3%</td></tr><tr><td>Strongly Agree</td><td>49</td><td>74.2%</td><td>43</td><td>71.7%</td><td>8</td><td>66.7%</td><td>3</td><td>42.9%</td><td>17</td><td>77.3%</td><td>16</td><td>76.2%</td><td>11</td><td>78.6%</td></tr></tbody></table>

### Significance of filenaming

Survey participants were asked to rank seven filenaming conventions in order of importance, with 1=most important and 7=least important. Table 14 provides these conventions in order of most to least important based on mode, then mean (n=214).

**Table 14:** Ranking of Filenaming Conventions

| **Filenaming Convention** | **Mode** | **Mean** | **Standard deviation** |
| --- | --- | --- | --- |
| Removing and/or replacing punctuation | 1 | 2.71 | 1.48 |
| Formatting dates (YYYY-MM-DD, YYMMDD, etc.) | 1 | 3.56 | 1.96 |
| Removing and/or replacing spaces | 2 | 2.95 | 1.42 |
| Using leading zeros (0001, 0002, 0003, etc.) | 2 | 3.5 | 1.95 |
| Using only lowercase characters | 6 | 4.78 | 1.61 |
| Keeping filenames under a limited number of characters | 7 | 4.63 | 2.05 |
| Using CamelCase characters | 7 | 5.87 | 1.33 |

Removing and/or replacing punctuation was most often ranked as most important, followed by formatting dates, removing and/or replacing spaces, and using leading zeros. A gap is evident between these four conventions and the last three (using only lowercase characters, keeping filenames under a limited number of characters, and using CamelCase characters) indicating a clear divide between these two groups. Perhaps relevant here is that the first four conventions mostly affect sortability, while the last three conventions mostly affect readability. Interestingly, both groups include a convention that affects functionality: removing and/or replacing punctuation, and keeping filenames under a limited number of characters. If one is deemed most important, it is compelling to wonder why the other is not. Perhaps it is because institutions simply do not often have filenames that would surpass a limit on the number of characters.

Respondents were also asked about the importance of eight particular filenaming concepts. Responses (n=203) were recorded using a 5-point Likert scale with 1=”Strongly Disagree” and 5=”Strongly Agree”. Table 15 provides a breakdown, in order of highest to lowest mean.

**Table 15:** Importance of Various Filenaming Concepts

| **Filenaming is important to…** | **Mode** | **Mean** |
| --- | --- | --- |
| the long-term management of digital files | 5 | 4.66 |
| the digitization and/or reformatting of materials | 5 | 4.35 |
| the ingest processes of digital files | 5 | 4.31 |
| the productivity of the unit producing the file | 5 | 4.28 |
| relating digital files to their derivative files | 5 | 4.21 |
| relating digital files to their physical counterparts | 5 | 4.14 |
| the management of “use copy” digital files | 4 | 3.84 |
| relating digital files to other related content (i.e. finding aids, MARC records, METS records) | 4 | 3.74 |

Respondents most often chose Strongly Agree to filenaming being important to the long-term management of digital files, which also aligns with the data in Table 13. Each of the concepts fell within the Strongly Agree or Agree range, thus indicating that each of them are deemed rather closely in importance. It is somewhat noteworthy that the importance of using filenaming to relate to derivative files fell higher than relating to physical counterparts, which fell higher than relating to other related content (finding aids, etc.), though the range is narrow.

### Additional comments

This section invited survey participants to share additional comments regarding filenaming in the LAM community. Seventy-nine respondents provided comments. While most comments further iterated preferences for conventions already covered in the survey, two main themes emerged.

First, it was overwhelmingly apparent that respondents were simply eager to learn the specifics of how others in the LAM community are developing filenaming schemes. Comments included: “I have done a bit of research to see how others are creating filenames; I found some resources, but not as many as I had hoped,” “I always second guess if my practice aligns with what my colleagues are doing… I’d be very interested to see others responses and rationale for their schemas,” and, “I would love to find a set of relevant guides that I can easily adapt and disseminate.” This points to a need for an online, shared registry or repository of filenaming guidelines, or perhaps sets of guidelines from some of the prominent professional organizations in the LAM field. A repository would be particularly useful, as it could be applicable to both the LAM community and broader fields such as [personal archiving](https://en.wikipedia.org/wiki/Personal_archiving) which includes non-LAM and even non-technical individuals. Additionally, survey respondents were eager to share their own filenaming schemes, and about a dozen respondents shared details on their conventions used or links to their schemes online.

Second, the challenge of getting buy-in from others was shared by a number of respondents. Comments included: “While we have a file naming policy in place and have had one for a number of years, it is difficult to get all staff and librarians to fully comply” and “filenaming practices are difficult to enforce/get buy in for from people new to digital projects”. It would be enlightening to learn how prevalent this challenge is across the LAM community, and if there are institutions who have found solutions to communicating the value of implementing filenaming schemes. Perhaps this is an area for future study.

## Conclusion

Librarians, archivists, digital asset managers and related practitioners will no doubt be faced with a growing need to develop intricate filenaming schemes. Though the topic of meaningfulness is covered informally in the LAM community, and a few suggestions for and against such methods presented themselves in the survey data, several questions still remain. For instance, how would the use of both meaningful and non-meaningful identifiers within a digitization program affect productivity and workflow? Is it better to select one method for all assets, or to select the method on a case-by-case basis? And if selecting only one method, which method—meaningful or non-descriptive—should one choose? We hope that the data analysis above, combined with a consideration of one’s current conventions, may assist in constructing a more nuanced and established way of considering, selecting, and applying filenaming procedures and guidelines.

## References

Borer, E. T., Seabloom, E. W., Jones, M. B. and Schildhauer, M. (2009). Some Simple Guidelines for Effective Data Management. The Bulletin of the Ecological Society of America, 90: 205-214. doi:10.1890/0012-9623-90.2.205.

Frazer, Meghan. (2013). An Elevator Pitch for File Naming Conventions. ACRL TechConnect blog. Retrieved October 6, 2017 from [http://acrl.ala.org/techconnect/post/an-elevator-pitch-for-file-naming-conventions](http://acrl.ala.org/techconnect/post/an-elevator-pitch-for-file-naming-conventions)

Schreibman, Susan, ed. (2007). Best Practice Guidelines for Digital Collections at University of Maryland Libraries, 2nd ed. Retrieved October 6, 2017 from [http://cs.mty.itesm.mx/profesores/pverdines/TCS/p2/DigitalCollections.pdf](http://cs.mty.itesm.mx/profesores/pverdines/TCS/p2/DigitalCollections.pdf).

Stanford Libraries. (n.d.). Best practices for file naming. Retrieved October 6, 2017 from [http://library.stanford.edu/research/data-management-services/data-best-practices/best-practices-file-naming](http://library.stanford.edu/research/data-management-services/data-best-practices/best-practices-file-naming)

University of Colorado, Boulder Libraries. (2008). Guidelines on file naming conventions for digital collections. Retrieved July 11, 2014 from [http://ucblibraries.colorado.edu/systems/digitalinitiatives/docs/filenameguidelines.pdf](http://ucblibraries.colorado.edu/systems/digitalinitiatives/docs/filenameguidelines.pdf)

University of Edinburgh. (2015). Use capital letters to delimit words. Retrieved October 6, 2017 from [http://www.ed.ac.uk/records-management/records-management/staff-guidance/electronic-records/naming-conventions](http://www.ed.ac.uk/records-management/records-management/staff-guidance/electronic-records/naming-conventions)

University of Oregon Libraries. (n.d.). Data Management Best Practices: File Naming & Version Control. Retrieved October 6, 2017 from [https://library.uoregon.edu/research-data-management/best-practices](https://library.uoregon.edu/research-data-management/best-practices)

## About the Authors

*Drew Krewer* has worked with both digital and physical collections at a range of cultural heritage institutions, including the Getty Research Institute, the University of Arizona Poetry Center, and the University of Houston Libraries. He is currently an Analyst at the University of Arizona Foundation.

*Mary Wahl* is technical services librarian at Pasadena City College where she oversees cataloging and metadata. Her professional interests include metadata wrangling, digital preservation, media collections and personal digital archives.

Study on Filenaming Practices within the LAM Community

Section I: Background information

This section aims to gather data regarding the LAM organization in which you work, as well as current filenaming practice in that organization.

Which of the following best describes the overall type of organization in which you work? (select one)

- Academic Library
- Public Library
- Archives/Special Collections
- Museum/Gallery
- Other (please explain)

Please select the size of your academic institution from the choices below:

- Fewer than 500 students
- 500-1,999 students
- 2,000-4,999 students
- 5,000-9,999 students
- 10,000 students or more

How many individuals are employed at the library/archive/museum for which you work? This figure should include paid positions only.

Which of the following best describes your role where you work? (select one)

- Librarian
- Archivist
- Project manager
- IT professional
- Assistant/Technician
- Other (please explain)

Do you and/or your organization employ a filenaming policy, either organization-wide, department- wide, or on a per-project basis? For the purposes of this survey, a filenaming policy is defined as a set of specified rules or procedures for guiding the creation of filenames.

- Yes
- No
- I don’t know

Do you employ (select all that apply)

- One or more organization-wide filenaming policies
- One or more department-wide filenaming policies
- One or more filenaming policies per project/collection

Do you feel that your current filenaming policy(ies) adequately serves your needs?

- Yes
- No
- I don’t know

Please explain why you feel your current filenaming policy(ies) may not adequately serve your needs.

Section II: Filenaming characteristics

This section aims to gather data regarding filenaming conventions in use in the LAM community and the context(s) in which they’re used.

For which of the following types of digital collections do you employ filenaming policy(ies)? (select all that apply)

- Digitized material
- Born-digital material
- Business data (i.e. institutional records, digital marketing assets, etc.)
- Research data
- Other (please explain)

For digitized material, please select the types of elements in use in your filenames:

- date a physical item was created
- date a digital file was created
- date a digital file was last modified
- institution identifier (including any subunits of the institution)
- collection identifier (i.e. call number, accession number)
- item identifier
- item subunit identifier (i.e. recto, verso, page 1, side A)
- staff member identifier
- physical location identifier
- digital location identifier
- an indication of the file’s purpose (i.e. preservation master, access copy, thumbnail)
- an indication of the file’s quality (i.e. high resolution, lossy)
- Other (please explain)

For born-digital material, please select the types of elements in use in your filenames:

- date a digital file was created
- date a digital file was last modified
- institution identifier (including any subunits of the institution)
- collection identifier (i.e. call number, accession number)
- item identifier
- item subunit identifier (i.e. recto, verso, page 1, side A)
- staff member identifier
- digital location identifier
- an indication of the file’s purpose (i.e. preservation master, access copy, thumbnail)
- an indication of the file’s quality (i.e. high resolution, lossy)
- Other (please explain)

For business data, please select the types of elements in use in your filenames:

- date a physical item was created
- date a digital file was created
- date a digital file was last modified
- institution identifier (including any subunits of the institution)
- collection identifier (i.e. call number, accession number)
- item identifier
- item subunit identifier (i.e. recto, verso, page 1, side A)
- staff member identifier
- physical location identifier
- digital location identifier
- an indication of the file’s purpose (i.e. preservation master, access copy, thumbnail)
- an indication of the file’s quality (i.e. high resolution, lossy)
- Other (please explain)

For research data, please select the types of elements in use in your filenames:

- date a physical item was created
- date a digital file was created
- date a digital file was last modified
- institution identifier (including any subunits of the institution)
- collection identifier (i.e. call number, accession number)
- item identifier
- item subunit identifier (i.e. recto, verso, page 1, side A)
- staff member identifier
- physical location identifier
- digital location identifier
- an indication of the file’s purpose (i.e. preservation master, access copy, thumbnail)
- an indication of the file’s quality (i.e. high resolution, lossy)
- Other (please explain)

For the type of digital collection that you considered “Other,” please select the types of elements in use in your filenames:

- date a physical item was created
- date a digital file was created
- date a digital file was last modified
- institution identifier (including any subunits of the institution)
- collection identifier (i.e. call number, accession number)
- item identifier
- item subunit identifier (i.e. recto, verso, page 1, side A)
- staff member identifier
- physical location identifier
- digital location identifier
- an indication of the file’s purpose (i.e. preservation master, access copy, thumbnail)
- an indication of the file’s quality (i.e. high resolution, lossy)
- Other (please explain)

Please rank the following filenaming conventions in order of importance, with 1 being the most important:

- removing and/or replacing punctuation
- removing and/or replacing spaces
- using only lowercase characters
- using CamelCase characters
- formatting dates (YYYY-MM-DD, YYMMDD, etc.)
- using leading zeros (0001, 0002, 0003, etc.)
- keeping filenames under a limited number of characters

How important are the following filenaming concepts to you/your organization (using a scale of Not important; Slightly important; Moderately important; Important; Very important):

- relating a digital file to its physical original
- relating a digital file to its digital derivatives
- scalability of naming conventions
- sortability

To what extent do you agree or disagree with the following statements (using Strongly disagree; Disagree; Neither Agree nor Disagree; Agree; Strongly Agree):

- Filenames should primarily be meaningful to the person or organization managing the files.
- Filenames should primarily be machine readable.
- Filenames should be BOTH meaningful to humans/organizations AND machine readable.
- Filenames should be randomly assigned by the software or system managing the files.
- It is important for filenames to be understandable to individuals outside of my organization.

Who assigns filenames, either as a whole or in part? (select all that apply)

- Project manager for the collection
- Technician(s)
- Equipment (i.e. camera, scanner)
- Other (please explain)

Does your content management system influence your filenaming?

- Yes
- No
- Sometimes
- Not applicable

Please explain how your content management system influences your filenaming.

Under what circumstances does it influence your filenaming? When does it not influence your filenaming?

For digitized material, does physical format of the original influence your filenaming?

- Yes
- No
- Sometimes
- Not applicable

Please explain how the physical format of the original influences your filenaming.

What qualities of the physical formats influence your decisions?

Please explain when physical formats would influence your filenaming and when they would not influence your filenaming. What qualities of the physical formats guide these decisions?

For both digitized and born-digital material, does file format influence your filenaming?

- Yes
- No
- Sometimes
- Not applicable

Please explain how file format influences your filenaming for both digitized and born- digital materials.

When does file format influence your filenaming for both digitized and born-digital materials? When does file format NOT influence your filenaming?

Section III: Significance of Filenaming

This section aims to gauge the importance of various filenaming concepts in the LAM community.

To what extent do you agree or disagree with the following statements (using Strongly Disagree; Disagree; Neither Agree nor Disagree; Agree; Strongly Agree):

- Filenaming is important to the productivity of the unit producing the files.
- Filenaming is important to the digitization and/or reformatting of materials.
- Filenaming is important to the ingest processes of digital files.
- Filenaming is important to the long-term management of digital files.
- Filenaming is important to relating digital files to their physical counterparts.
- Filenaming is important to relating digital files to their derivative files.
- Filenaming is important to relating digital files to other related content (i.e. finding aids, MARC records, METS records).
- Filenaming is important to the management of “use copy” digital files.

Section IV: Additional comments

This section is to allow survey participants to share any additional comments regarding filenaming in the LAM community.

Please share any additional comments you may have regarding filenaming practice.
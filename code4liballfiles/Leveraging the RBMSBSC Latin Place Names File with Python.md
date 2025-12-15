---
title: "Leveraging the RBMS/BSC Latin Place Names File with Python"
source: "https://journal.code4lib.org/articles/15143"
author:
  - "[[The Code4Lib Journal]]"
published: 2020-05-11
created: 2025-01-10
description: "To answer the relatively straight-forward question “Which rare materials in my library catalog were published in Venice?” requires an advanced knowledge of geography, language, orthography, alphabet graphical changes, cataloging standards, transcription practices, and data analysis. The imprint statements of rare materials transcribe place names more faithfully as it appears on the piece itself, such as [...]"
tags:
  - "clippings"
---
# Leveraging the RBMS/BSC Latin Place Names File with Python
Kalan Knudson Davis

To answer the relatively straight-forward question “Which rare materials in my library catalog were published in Venice?” requires an advanced knowledge of geography, language, orthography, alphabet graphical changes, cataloging standards, transcription practices, and data analysis. The imprint statements of rare materials transcribe place names more faithfully as it appears on the piece itself, such as Venetus, or Venetiae, rather than a recognizable and contemporary form of place name, such as Venice, Italy. Rare materials catalogers recognize this geographic discoverability and selection issue and solve it with a standardized solution. To add consistency and normalization to imprint locations, rare materials catalogers utilize hierarchical place names to create a special imprint index. However, this normalized and contemporary form of place name is often missing from legacy bibliographic records. This article demonstrates using a traditional rare materials cataloging aid, the RBMS/BSC Latin Place Names File, with programming tools, Jupyter Notebook and Python, to retrospectively populate a special imprint index for 17th-century rare materials. This methodology enriched 1,487 MAchine Readable Cataloging (MARC) bibliographic records with hierarchical place names (MARC 752 fields) as part of a small pilot project. This article details a partially automated solution to this geographic discoverability and selection issue; however, a human component is still ultimately required to fully optimize the bibliographic data.

## Background

In 2018, the University of Minnesota (UMN) Libraries Cataloging and Metadata Group (CMG), an Alma governance group that creates and maintains system-wide cataloging and metadata policy and procedures, approved a new written policy for rare book cataloging. These rare book cataloging guidelines stipulated the use of hierarchical place names to aid discoverability for contemporary place names as well as more faithfully transcribed imprint locations, but there were hundreds of thousands of extant UMN Libraries bibliographic records for rare materials that did not have this hierarchical place name field populated. Indexing the hierarchical place name field was problematic as only a small subset of recently cataloged rare materials could utilize it.

A solution needed to extend much further than updating cataloging policy and reindexing fields in UMN’s Primo discovery layer. Redescribing all rare materials imprint statements to reflect current cataloging standards and transcription practice was out of scope due to other cataloging priorities and rare materials staffing limitations. A purely manual record-by-record method of adding contemporary place names retrospectively to rare materials records would be time consuming, error prone, and an impractical solution. I set out to develop an automated approach by testing and implementing a small pilot project.

## Geographic Selection Illustrated in MARC

The *Orbis Latinus* lists eleven variations for the place name Venice, Italy: Venetia, s. Marci civ., Portus Venetus, Venecia, Veneciae, Venetiae, Veneticis, Venetie insula, Venetorum civ., Venetus, and Venitia (Grässe 1971) \[[1](https://journal.code4lib.org/articles/#note1)\]. These entries for Venice are among the thousands of potential rare materials place names contained in the medieval geography reference. For many legacy rare materials, a contemporary form of place name, such as the search keyword Venice, Italy, appears nowhere on the bibliographic record.

To add consistency and discoverability to imprint locations, rare materials catalogers utilize the hierarchical place name, or the MARC 752 field, to create a special imprint index (Library of Congress 1999 \[updated 2019 November\] \[[2](https://journal.code4lib.org/articles/#note2)\]). The MARC 752 field has been redefined as recently as 2017 with several MARC Discussion Papers and Proposals regarding its use (Library of Congress 2004 \[[3](https://journal.code4lib.org/articles/#note3)\], Library of Congress 2004b \[[4](https://journal.code4lib.org/articles/#note4)\], and Library of Congress 2004c \[[5](https://journal.code4lib.org/articles/#note5)\]). This recently refined field in a mature bibliographic repertoire results in many legacy cataloging records that do not currently utilize the MARC 752 field to its fullest capacity.

Rare materials catalogers optimize the place of publication transcribed in the MARC 260/264 subfield $a for the identification of bibliographical variants in manifestations via a more faithful transcription (\[Library of Congress 1999b \[updated 2019 November\] \[[6](https://journal.code4lib.org/articles/#note6)\]). To further illustrate the geographic selection problem with MARC examples, consider the following transcribed place names for Venice, Italy.

```
260 \\ $a Venetiis : $b Ex typographia Remondiniana ..., $c MDCCLXIII [1763]

260 \\ $a Impressum Venetijs: $b Per Jacobu[m] Pentiu[m] de Leucho : $b Arte impensa vero Juncte de Junctis Florentini, $c anno D[omi]ni 1508 vltimo Octobris [31 Oct. 1508]

264 \1 $a In Venetia : $b Nella stamperia di Giouanni Salis, $c M. DC. XVI. [1616]
```

From those same bibliographic records illustrated above, rare materials catalogers optimize the following MARC 752 field for rare materials geographic selection tasks (Library of Congress 1999 \[updated 2019 November\] \[[7](https://journal.code4lib.org/articles/#note7)\]). Adding the MARC 752 makes these records discoverable by a contemporary and normalized place name.

```
752 \\ $a Italy $d Venice.
```

Although the fuller, more faithful transcriptions of rare materials allow users to clearly identify and distinguish among the variants of manifestations, the variety of transcription methods found in the imprint statements of bibliographic records and the orthographic and graphic changes throughout time can obscure geographic selection, which is remedied by the addition of normalized and contemporary hierarchical place names.

## Literature Review

### Rare Materials Descriptive Needs

The introduction to the Descriptive Cataloging for Rare Materials (Books) (DCRM(B)) emphasizes the rare materials’ need for “more faithful transcriptions and more accurate physical descriptions” and that this practice “facilitate\[s\] differentiation between manifestations and reveal\[s\] the presence of bibliographic variants among seemingly identical items” (Bibliographic Standards Committee 2011 \[[8](https://journal.code4lib.org/articles/#note8)\]). Rare materials have artifactual value; therefore, rare materials cataloging addresses them both as a text and as a physical object. The cataloging of rare materials requires “additional details of description in order to identify significant characteristics” (Bibliographic Standards Committee 2011 \[[9](https://journal.code4lib.org/articles/#note9)\]) and an accurate representation of the entity as it describes itself. In order to achieve these more faithful transcriptions, rare materials cataloging standards and transcription practices, much like graphical representation of language and orthography, have changed and evolved over time. Where needed, current rare materials cataloging standards deviate from other bibliographic standards to meet unique descriptive needs (Bibliographic Standards Committee 2011 \[[10](https://journal.code4lib.org/articles/#note10)\]).

For grammatically separable elements, DCRM(B), allows for the noted transposition of elements (Bibliographic Standards Committee 2011 \[[11](https://journal.code4lib.org/articles/#note11)\]), but the use of contractions or transcribed phrases such as *En Venetia* and *Impressum Venetiis* add an additional layer of imprint location complexity as well as indication of role. Transcribed place name abbreviations such as *Venet.* or *Lugduni Batauor.* are common.

The article “Transcription in Rare Books Cataloging” discusses the differences in cataloging and transcription practices between DCRM(B), International Standard Bibliographic Description (ISBD), and Resource Description Access’ (RDA) ‘take what you see’ principle for early printed books (Sjökvist 2006 \[[12](https://journal.code4lib.org/articles/#note12)\]). Sjökvist discusses transcription and normalization in the terms of fulfilling user tasks: identification and retrieval (i.e. selection), respectively. Although the article concentrates its arguments on title access rather than imprint locations, its conclusion of using two different MARC fields, each optimized to a different IFLA LRM user task, is similar to how rare materials catalogers currently handle imprint locations.

Leslie and Griffin in their 2013 discussion paper “Transcription of Early Letter Forms in Rare Materials Cataloging” note that “there is no clearly superior solution to the \[transcription\] problem; our task is finding the least painful solution” (Leslie and Griffin 2013 \[[13](https://journal.code4lib.org/articles/#note13)\]). The article discusses the evolution of letter forms; spelling conventions; and contractions, ligatures, and digraphs usage, both archaic and modern, while thoroughly addressing the 23-letter Roman alphabet’s journey to our modern 26-letter system. Leslie and Griffin evaluate several different transcription systems by ensuring user convenience, representation of the entity as it describes itself, accuracy of descriptions, principle of sufficiency and necessity, and the principle of standardization. Transcribed imprint statements illustrate the numerous difficulties presented to rare materials catalogers in graphical and orthographical usage, both modern and archaic, as the “gradual differentiation between u and v as representing different sounds, in particular u (and i) as vowels, and v (and j) as consonants” occurred over time (Leslie and Griffin 2013 \[[14](https://journal.code4lib.org/articles/#note14)\]). This leads to further place name spelling variations in the geographic selection puzzle as characters may have variations in transcription due to the cataloging rules and title page language. For example, transcribing *Basileæ* or *Basileae* depends on whether the title page is in English or French.

The article “RDA and Rare Books Cataloging” discusses imprint treatments between the MARC 260 and MARC 264 subfield $a, in particular where elements of the imprint statement are grammatically inseparable (Burns 2019 \[[15](https://journal.code4lib.org/articles/#note15)\]). Burns notes that “publication statements on rare books can present some of the most challenging transcription issues for RDA rules” (Burns 2019 \[[16](https://journal.code4lib.org/articles/#note16)\]). Indeed, RDA publication statements will surely bring many more transcribed place name variations and more transcription practices to bibliographical records.

### Place Names and Imprints in Rare Book Cataloging

*Orbis Latinus*, recently revised in 1971, has been the standard reference resource for Medieval geography since its original publication in 1861 (Grässe 1861 \[[17](https://journal.code4lib.org/articles/#note17)\]). Frederick Benedict edited a second edition in 1909 with special considerations for Medieval and modern Latinities (Grässe 1909 \[[18](https://journal.code4lib.org/articles/#note18)\]). R.C. Schmidt published a third edition in 1922 (Grässe 1922 \[[19](https://journal.code4lib.org/articles/#note19)\]). Helmut Plechl in cooperation with Günter Spitzbart helmed a fourth edition in 1971. This most recent publication has been expanded to over 579 pages (Grässe and Plechl 1971 \[[20](https://journal.code4lib.org/articles/#note20)\]). The first efforts to digitize the 1909 resource took place at Columbia University under Karen Green in 2000 (Bibliographic Standards Committee 2015 \[[21](https://journal.code4lib.org/articles/#note21)\]).

Another important place name resource, Peddie’s *Place Names in Imprints*, first published in 1932, often finds a home within the workstations of rare materials catalogers. The preface notes, “One of the difficulties of the cataloguer and the bibliographer has been to identify the place of printing or publication when disguised in Latin, or in some dialect form. This index is intended to help in the solution of this problem” (Peddie 1932 \[[22](https://journal.code4lib.org/articles/#note22)\]).

The *RBMS/BSC Latin Place Names (LPN) File* is a listing of Latin place names found in the imprints of materials printed before 1801 and their vernacular equivalents in Resource Description and Access (RDA) form. The file has been compiled from R.A. Peddie’s *Place Names in Imprints* and Grässe’s *Orbis Latinus*. Robert L. Maxwell created the *RBMS/BSC LPN File* in 1997 with the assistance of Karen Larson (Bibliographic Standards Committee 2015 \[[23](https://journal.code4lib.org/articles/#note23)\]). This online resource has been maintained since that time as a Rare Book Manuscript Section / Bibliographic Standards Committee cataloging aid.

The introductory section of RBMS/BSC Latin Place Names (LPN) File states, “This database was compiled from the imprint information in cataloging records of several Anglo-American research libraries. Because these records were created over a long period of time and under different standards and rules of transcription, the orthography of the place names with respect to I/J and U/V/W does not necessarily reflect what was found in the original \[materials\]” (Bibliographic Standards Committee 2015 \[[24](https://journal.code4lib.org/articles/#note24)\]). Out of necessity, the RBMS/BSC has standardized the file; therefore, rare materials imprint statements contain many more place name variations than are listed explicitly in the file. In the case of Venice, Italy, for example, one of the eleven place names listed in Grässe’s *Orbis Latinus*, *Venetiis*, has been transcribed in bibliographic records as *Venetijs*.

Recent developments in web encoding standards are another complexity inherent in leveraging the *RBMS/BSC LPN File*. HTML5 utilizes Unicode UTF-8 as, generally, does current bibliographic practice. However, the introduction to the *RBMS/BSC LPN File* also notes, “At the time that the Latin Place Names File was developed, it was only possible to enter ASCII characters in HTML files. This limited the availability of diacritical marks to the most common. Therefore, some RDA forms, especially those for Eastern European cities, are missing their diacritics” (Bibliographic Standards Committee 2015 \[[25](https://journal.code4lib.org/articles/#note25)\]). The twenty plus variations transcribed place names of Nuremberg, Munich, and Zurich (e.g.. *Nürnberg*, *München*, and *Zürych*) illustrate this.

### Use of Python in Cataloging Workflows

Frank’s article “Augmenting the Cataloger’s Bag of Tricks : Using MarcEdit, Python, and PyMARC for Batch-Processing MARC Records Generated From the Archivists’ Toolkit” provides an overview of the ongoing trend that “combines traditional cataloging standards and programming, in order \[for catalogers\] to efficiently manage their workflows” (Frank 2013 \[[26](https://journal.code4lib.org/articles/#note26)\]). Frank specifically mentions the PyMARC Python Library created by Gabriel Farrell, Mark Matienzo, and Ed Summers (PyMARC \[updated 2020 April\] \[[27](https://journal.code4lib.org/articles/#note27)\]) as a workflow adaptation, with the one-by-one record approach no longer being a sustainable practice.

In their “Leveraging Python to improve ebook metadata selection, ingest, and management,” Thompson and Traill discuss the use of the pandas Python module (pandas … , \[updated 2020 March\] \[[28](https://journal.code4lib.org/articles/#note28)\]) to create a dataframe to analyze and evaluate the quality of MARC records, as well as to write out Comma Separated Value (CSV) reports for output and further human remediation tasks (Thompson and Traill 2017 \[[29](https://journal.code4lib.org/articles/#note29)\]). Thompson and Traill’s use of dataframes not only to execute evaluation of MARC records, but also to implement workflows within those records themselves heavily influenced the development of the methodology and script described in this article.

### URIs in MARC

The “Task Group on Linked Data Best Practices Final Report” details recommendations for practical experimentation and guidance to catalogers for coding MARC subfields $0, $1, and $4 (Program for Cooperative Cataloging 2019 \[[30](https://journal.code4lib.org/articles/#note30)\]). The report also recommends an appropriate subfield order for the URI and non-URI MARC subfields. Of particular interest are the multiple options and recommendations regarding the MARC subfield $4: the use of option three “If a relationship URI or code is given, it is encouraged but not required to also provide the corresponding label ($e, $i, or $j depending on the field)” (Program for Cooperative Cataloging 2019 \[[31](https://journal.code4lib.org/articles/#note31)\]). The PCC Task Group’s Final Report, along with the MARC object table (Program for Cooperative Cataloging 2019b \[updated 2019 August 31\] \[[32](https://journal.code4lib.org/articles/#note32)\]) and the “PCC Task Group on URIs in MARC’s Formulating and Obtaining URIs: a Guide to Commonly Used Vocabularies and Reference Sources” (Program for Cooperative Cataloging 2019c \[[33](https://journal.code4lib.org/articles/#note33)\]), informed the choice, construction, and order of the URIs and enriched MARC 752 fields for this pilot project.

## Method

The script’s purpose is to check each record for existing MARC 260/264 subfield $a values and 008 MARC Country Code value against the dataframe version of the *RBMS/BSC Latin Place Names File*, supply normalized geographic data in the MARC 752 field when possible, and output the results into three separate spreadsheets for review.

### Turning the RBMS/BSC Latin Place Names File into a Pandas Dataframe

To create and test the Python scripts, I extracted the 1,487 MARC bibliographic records for 17th-century rare materials as a sample from the University of Minnesota Libraries’ Alma Library Services Platform. This dataset exemplified many of the characteristic orthographic, geographic, and graphical variations in the imprint locations of rare materials, while remaining a small subset of manageable size for a pilot project.

The MARC bibliographic record dataset contained 323 unique strings between the MARC 260/264 subfield $a. I added these unique strings, along with an additional 1,411 entries extracted from the *RBMS/BSC Latin Place Name File*, to a Comma Separated Value (CSV) file. Each row within the CSV file was also populated with the various values comprising the MARC 752 subfield components, including the country ($a), the first-order political jurisdiction (i.e. state or province) ($b), city ($d), relator term ($e), relator term URI ($4), and Real World Object URI ($1).

**Table 1.** An excerpt of the CSV input for the RBMS/BSC Latin Place Names File dataframe.

| Venetii | it | Italy$dVenice, | Italy | no value | Venice, |
| --- | --- | --- | --- | --- | --- |
| Venetiis | it | Italy$dVenice, | Italy | no value | Venice, |
| Venetio | it | Italy$dVenice, | Italy | no value | Venice, |
| Venetis | it | Italy$Venice, | Italy | no value | Venice, |
| Venetiuis | it | Italy$dVenice, | Italy | no value | Venice, |

The CSV file is an essential component of the Python script’s iterative process. Peddie, Grässe, and the Bibliographic Standards Committee did not design their geographic resources to account for every place name variation, phrase, scribal contraction, and abbreviation. The bibliographic records themselves account for every possible use case. The script user feeds additional locations and place name variations into the script for processing making for a flexible, locally customizable, and responsive design. The Python script feeds the CSV file into a pandas dataframe.

**Table 2.**The enriched *RBMS/BSC Latin Place Name File* is fed into pandas dataframe.

| 1  2  3  4 | `MasterChart ``=` `pd.read_csv(``'MasterChartcleaner.csv'``)`  `idx ``=` `pd.Index(MasterChart.Publication_Place)` |
| --- | --- |

### Evaluating MARC Records– the Good, the Bad, and the Okayish

MARC record evaluation and dataframe querying takes place before a record is sent on to one of the Python script’s three PyMARC writers. The evaluation process splits the original MARC file into one of three possible paths based on evaluation of the data contained within the records.

#### Option 1: 752s Are Already Present on MARC Record

Recently cataloged rare materials may already have a MARC 752 field populated with a hierarchical place name. In these cases, the script identifies these records and writes them to a separate file for manual review. The file reviewer may wish to further enrich the existing MARC 752 subfields with additional Real World Object URIs, if these are lacking.

**Table 3.**The script writes rare materials that already have a populated MARC 752 field to a file for review.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21 | `else``:`  `MMSID ``=` `[record[``'001'``]]`  `OCLCno ``=` `[record[``'035'``]]`  `ccfrom008 ``=` `countrycode`  `field260 ``=` `[record[``'260'``]] `  `field264 ``=` `[record[``'264'``]]`  `field752 ``=` `[record[``'752'``]]`  `dict` `=` `{``'Alma MMS ID'``: MMSID,`  `'OCLC number'``: OCLCno,`  `'Country Code'``: ccfrom008, `  `'260'``: field260, `  `'264'``: field264, `  `'752'``: field752}`  `okayishdf ``=` `pd.DataFrame(``dict``) `  `okayishdf.to_csv(``'ReportMARCalreadywith752s.csv'``, mode``=``'a'``, header``=``False``) `  `writerokayish.write(record)` |
| --- | --- |

#### Option 2: 752s Are Added to MARC Record

For MARC records containing only one MARC 260/264 subfield $a/$e value, the script queries the pandas dataframe to find a relevant match. The Python script assigns the MARC Country Code in the 008 field and the MARC 260/264 subfield $a to variables. The pandas dataframe is essentially filtered twice, matching both the 008 Country Code and MARC 260/264 subfield $a values.

**Table 4.**The enriched *RBMS/BSC Latin Place Name File* dataframe is filtered to match the bibliographic record’s 008 Country Code and MARC 262/264 subfield $a.

| 1  2  3  4  5  6 | `QueriedChart ``=` `MasterChart.query(``'CountryCode == @countrycode and Publication_Place == @clean264a'``, inplace ``=` `False``)`  `size ``=` `QueriedChart.size` |
| --- | --- |

At this stage, the script takes special care to assign the appropriate relator terms (subfield $e) and relator URIs (subfield $4) for MARC 264 fields according to the various indicator values. As noted in the DCRM(B), “the roles of publishers, printers, and booksellers were not clearly delimited in the hand-press period. Statements relating to printing frequently appear prominently on early printed materials, reflecting the tendency of printers to function as more than solely manufacturers” (Bibliographic Standards Committee 2011 \[[34](https://journal.code4lib.org/articles/#note34)\]). Therefore, defining relator terms for the MARC 260 field is not as straightforward, but follows current DCRM(B) practice: “If the publication bears only a statement relating to manufacture, or multiple such statements, generally assume the manufacturer(s) to also be functioning as publisher(s), distributor(s), etc.” (Bibliographic Standards Committee 2011 \[[35](https://journal.code4lib.org/articles/#note35)\]). Not every relator relationship can be programmatically accounted for. Although the script takes special care to evaluate the nature of the place name’s relationship to the manifestation, a rare materials cataloger may wish to evaluate and scan the supplied MARC 752 subfield $e and subfield $4 on retrospectively enriched records.

**Table 5.**The script assigns relator terms and URIs according to indicator values.

If a match within the *RBMS/BSC Latin Place Name File* dataframe exists, the script compiles the subfield components for the MARC 752 field and the script adds the field to the MARC record.

**Table 6.**The script adds the compiled MARC 752 field to the record.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23 | `if` `IndexChecker ``is` `True` `and` `size > ``0``:`  `Term3 ``=` `QueriedChart.index[``0``]`  `field752a ``=` `MasterChart.loc[Term3,``"752a"``]`  `field752b ``=` `MasterChart.loc[Term3,``"752b"``]`  `field752d ``=` `MasterChart.loc[Term3,``"752d"``]`  `field7521 ``=` `MasterChart.loc[Term3,``"Geonames_URI"``]`  `record.add_ordered_field(`  `Field(`  `tag ``=` `'752'``,`  `indicators ``=` `[``' '``,``' '``],`  `subfields ``=` `[`  `'a'``, field752a,`  `'b'``, field752b,`  `'d'``, field752d,`  `'e'``, field752e,`  `'4'``, field7524,`  `'1'``, field7521,`  `]))  ` |
| --- | --- |

The script writes all records with added 752 fields to a separate file for manual review.

**Table 7.**The script writes records with populated MARC 752 field to a file for review.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 | `MMSID ``=` `[record[``'001'``]]`  `OCLCno ``=` `[record[``'035'``]]`  `ccfrom008 ``=` `countrycode`  `field260 ``=` `[record[``'260'``]]`  `field264 ``=` `[record[``'264'``]]`  `field752 ``=` `[record[``'752'``]]`  `dict` `=` `{``'Alma MMS ID'``: MMSID,`  `'OCLC number'``: OCLCno, `  `'Country Code'``: ccfrom008, `  `'260'``: field260, `  `'264'``: field264, `  `'752'``: field752}`  `gooddf ``=` `pd.DataFrame(``dict``) `  `gooddf.to_csv(``'ReportMarcwith752s.csv'``, mode``=``'a'``, header``=``False``) `  `writergood.write(record)      ` |
| --- | --- |

#### Option 3: 752s Not Added to MARC Record

By design, the script does not add a MARC 752 field for some use cases. Briefly, I will describe some of these situations, characteristics, and script handling. They can be broadly categorized into the following five groups:

- The script identifies potential errors present in the MARC record.
- The script identifies an imprint location that could refer to several places and the cataloger will need to evaluate the record manually and in greater context.
- The script can not identify the imprint place.
- The script user needs to add additional imprint information to the CSV file.
- The MARC record lists two places of imprint.

Errors are commonplace in legacy MARC bibliographic records. Mismatches between the 008 MARC Country Code and place of imprint are possible where MARC Country Codes or geographic headings are obsolete and now require evaluation and maintenance. Geographic and typographic errors are also common.

**Table 8.**Excerpt of mismatches between 008 MARC Country Code and MARC 260/264 values.

| ne | \=260 \\\\$aHafniae :$bImpensis Salomonis Sartorii,$c1624. |
| --- | --- |
| ne | \=260 \\\\$aHafniae :$bLiteris Matthiae Godicchenii,$c1664. |
| ne | \=260 \\\\$aHafniae :$bSumptibus Petri Hauboldi, excudebat Petrus Hakius,$c1658. |
| ne | \=260 \\\\$aHafniae :$bTypis Matthiae Godiccheni sumptibus Petri Haubold,$c1666. |

The *RBMS/BSC LPN File* indicates several names that refer to one or more places and/or to fictitious places. When the script can’t resolve a match based on the 008 MARC County Code and the Latin place name, instead of adding a MARC 752 field, the script places the MARC record in the “752s Not Added to MARC Record” writer queue instead.

**Table 9.**Example from the *RBMS/BSC Latin Place Names File* dataframe requiring manual resolution.

| LPN Master File | Augustae \*   most frequently Augustae Vindelicorum but also Argentorati Augustae Treuirorum Londini   Tarracone Taurini and Tubingae | xx | manual input |
| --- | --- | --- | --- |

Unfortunately, not all bibliographic mysteries are solvable. Sometimes rare materials catalogers cannot determine an imprint location. The script does not add a MARC 752 field for items traditionally denoted as “S.L.”, abbreviation for sine loco, or more recently as “\[Place of publication not identified\].”

**Table 10.**Examples of \[Place of publication not identified\] as imprint locations.

| xx | \=260 \\\\$a\[Place of publication not identified\],$c1613. |
| --- | --- |
| xx | \=260 \\\\$a\[Place of publication not identified\] :$b\[publisher not identified\],$c1648. |
| xx | \=260 \\\\$a\[Place of publication not identified\],$c1680. |

Finally, where there is less than one or more than one of any combination of MARC 260 and MARC 264 and when there is more than one subfield $a/$e value, the record is kicked out for manual review. A match on a place name alone without also a match of a 008 MARC County Code could very easily lead to an erroneous result. A rare materials cataloger can assign only one 008 MARC Country Code per bibliographical record, which may or may not be the country code for all imprint locations listed on the rare material. The script alone can’t resolve these situations. A rare materials cataloger needs to resolve and verify, in further consultation with bibliographic utilities and with research on the typical locations of the publisher, manufacturer, etc. The script contains a simple logical True/False variable, which accounts for many of these edge cases and MARC record errors, and will write the record to the “752s Not Added to MARC Record” queue.

**Table 11.**The script sends the MARC record for manual resolution.

| 1  2  3 | `else``:`  `IndexChecker ``=` `False`  `message ``=` `"More than one 260 subfield a/e is present in record.  Resolve manually."` |
| --- | --- |

**Table 12.**The script sends a MARC record for manual resolution.

| 1  2  3  4  5 | `else``:`  `IndexChecker ``=` `False`  `message ``=` `"More than one 260/264 fields are present in record.  Resolve manually."` |
| --- | --- |

### CSV Review Files

As the script writes MARC records to the three writer queues, the Python script publishes additional pandas dataframes as CSV files. The dictionary contains important MARC record identifiers, such as the 001 and 035 control numbers, the 008 MARC Country Code, the entire 260/264 string, if assigned, the 752 string, and a status message. The script writes the CSV files for human consumption and at a glance can help further diagnose errors within the MARC records and/or verify various components of the MARC 752 fields (locations and relator terms, alike). Rare materials catalogers can evaluate the CSV files to ensure that the script assigned MARC 752 subfields appropriately. This is especially helpful for examining and resolving MARC records that have fictitious, incorrect, grammatically inseparable elements, and/or multiple imprint locations.

**Table 12.**An excerpt from a CSV file with MARC records requiring further review.

| gw | \=260 \\\\$aFrancofurti,$aLipsiae :$bProstant apud Nicolaum Scipionem,$c1685. |
| --- | --- |
| gw | \=260 \\\\$aHannover$aUnd Wolffenbüttel :$bH. Grentz,$c1690. |
| gw | \=260 \\\\$aHanover ;$aGvelpherit :$bSumptibus Gothofredi Freytagii,$c1696. |
| gw | \=260 \\\\$aArgentorati :$bTypis J. Caroli,$c1618. |

## Results

### MARC Records

Of the 1,487 MARC bibliographic records for 17th-century rare materials used as an initial dataset, only five MARC records were previously populated with the MARC 752 field. This constitutes less than one percent of all records in the dataset. As predicted, these items were recently acquired by the UMN’s collections and were cataloged within the last three years. These records illustrate option one as described above, where MARC 752 fields were already present on records. I manually reviewed the MARC 752 fields and enriched them with URIs.

From the original dataset, 1,410 MARC bibliographic records were automatically populated with the hierarchical place name field, due to a confirmed queried pandas dataframe for the 008 MARC Country Code and imprint location in the MARC 260/264 field subfield $a. This constitutes 94% of all records in the dataset and illustrates option two as described above.

After further review, I manually resolved 72 of the 1,487 MARC bibliographic records. This constitutes five percent of all records in the dataset. These records illustrate option three as described above, where the script did not add 752s to MARC records due to errors, multiple places of imprint, or other reasons. Out of the 72 records, I identified 32 records that contained errors. The most common error was a mismatch between the 008 MARC Country Code and MARC 260/264 subfield $a. This included simple geographic errors, such as Copenhagen (Denmark) being associated with the Netherlands, or Toulouse listed in Germany rather than France. It also included simple typographical errors, such as ne (for the Netherlands) being mistyped re (for Réunion). Another common error occurred when a publisher name was mistaken as a place of publication. Four records contained “Place of publication not identified” as an imprint location and I did not evaluate them further. I identified twenty records as correct and after minor tweaks to the pandas dataframe will process correctly in the future– these were mostly due to previously unaccounted for diacritics and special characters. Finally, I identified only sixteen records as having more than one MARC 260/264 subfield $a. One should be cautious in correcting potential errors and manually assigning MARC 752 fields keeping a vigilant eye out for false imprints, reproduction statements, fictitious imprints, or other edge use cases using human/cataloger judgment to fully optimize the data.

## Conclusion

I intended the 1,487 MARC records as a pilot project, with the intention to fully populate the special imprint index using the Python script for all UMN Libraries rare materials dated 1450 to 1800. As the pandas dataframe is constantly used, updated, and enriched, it will grow to account for as many imprint use cases as possible.

The Python script has the potential to be of great use to other libraries with rare materials collections who would like to retrospectively populate a special imprint index using the MARC 752 field. The code is available on GitHub for broader use and adaptation (Davis \[updated 2020 April\] \[[36](https://journal.code4lib.org/articles/#note36)\]).

The URI enriched imprint pandas dataframe contains many important pieces of the linked data puzzle and has broad implications for the history of the book. Enriching the MARC records with Geonames URIs enables exciting bibliographical associations with larger scale geospatial data. The data collected in the pandas dataframe could inform future developments for RBMS/BSC LPN File as linked open data. The tabular data could be used to export and populate future applications of OWL and RDF semantic relationships for imprint places.

## References

\[[8](https://journal.code4lib.org/articles/#ref8)\] \[[9](https://journal.code4lib.org/articles/#ref9)\] \[[10](https://journal.code4lib.org/articles/#ref10)\] \[[11](https://journal.code4lib.org/articles/#ref11)\] \[[34](https://journal.code4lib.org/articles/#ref34)\] \[[35](https://journal.code4lib.org/articles/#ref35)\] Bibliographic Standards Committee. 2011. Descriptive cataloging of rare materials (books). Rare Books and Manuscripts Section, Association of College and Research Libraries; in collaboration with the Policy and Standards Office of the Library of Congress. Washington, DC: Library of Congress, Cataloging Distribution Service \[cited 2019 December 9\]. Available from: [https://rbms.info/files/dcrm/dcrmb/DCRMB3.pdf](https://rbms.info/files/dcrm/dcrmb/DCRMB3.pdf)

\[[21](https://journal.code4lib.org/articles/#ref21)\] \[[23](https://journal.code4lib.org/articles/#ref23)\] \[[24](https://journal.code4lib.org/articles/#ref24)\] \[[25](https://journal.code4lib.org/articles/#ref25)\] Bibliographic Standards Committee. 2015. RBMS/BSC Latin Place Names File. Chicago, IL: American Library Association, Rare Book and Manuscript Section, Bibliographic Standards Committee \[cited 2019 December 11\]. Available from: [http://rbms.info/lpn/](http://rbms.info/lpn/)

\[[15](https://journal.code4lib.org/articles/#ref15)\] \[[16](https://journal.code4lib.org/articles/#ref16)\] Burns, M. 2019. RDA and Rare Books Cataloging, Part 2. Library Resources & Technical Services. \[cited 2019 December 12\]; 63(1): 4-28. Available from: [http://search.ebscohost.com.ezp2.lib.umn.edu/login.aspx?direct=true&AuthType=ip,uid&db=aph&AN=134098616&site=ehost-live](http://search.ebscohost.com.ezp2.lib.umn.edu/login.aspx?direct=true&AuthType=ip,uid&db=aph&AN=134098616&site=ehost-live)

\[[36](https://journal.code4lib.org/articles/#ref36)\] Davis, k. K. \[updated 2020 April\]. RBMS-BSC-LPN-File-Dataframe. Available from: [https://github.com/ladylazarus3/RBMS-BSC-LPN-File-Python-Dataframe](https://github.com/ladylazarus3/RBMS-BSC-LPN-File-Python-Dataframe)

\[[26](https://journal.code4lib.org/articles/#ref26)\] Frank, H. 2013. Augmenting the cataloger’s bag of tricks : using MarcEdit, Python, and PyMARC for batch-processing MARC Records generated from the archivists’ toolkit. Code4Lib Journal \[Internet\], Issue 20 \[cited 2019 December 11\]. Available from: [https://journal.code4lib.org/articles/8336](https://journal.code4lib.org/articles/8336)

\[[17](https://journal.code4lib.org/articles/#ref17)\] Grässe, JGT. 1861. Orbis latinus, oder, Verzeichniss der lateinischen Benennungen der bekanntesten Städte etc., Meere, Seen, Berge und Flüsse in allen Theilen der Erde. Dresden: G. Schönfeld Buchhandlung (C.A. Werner) \[cited 2019 December 9\].

\[[18](https://journal.code4lib.org/articles/#ref18)\] Grässe, JGT. 1909. Orbis latinus, oder, Verzeichnis der wichtigsten lateinischen Orts- und Ländernamen. New York: E. Steiger & Co \[cited 2019 December 11\].

\[[19](https://journal.code4lib.org/articles/#ref19)\] Grässe, JGT. 1922. Orbis latinus, oder, Verzeichnis der wichtigsten lateinischen Orts- und Ländernamen. Berlin: R.C. Schmidt \[cited 2019 December 11\].

\[[1](https://journal.code4lib.org/articles/#ref1)\] \[[20](https://journal.code4lib.org/articles/#ref20)\] Grässe, JGT and Plechl, H. 1971. Orbis Latinus, Lexikon lateinischer geographischer Namen. Braunschweig, Germany: Klinkhardt & Biermann \[cited 2019 December 9\].

\[[13](https://journal.code4lib.org/articles/#ref13)\] \[[14](https://journal.code4lib.org/articles/#ref14)\] Leslie, DJ and Griffin, B. 2013. Transcription of early letter forms in rare materials cataloging. A discussion paper prepared for the DCRM Working Conference \[cited 2019 December 11\]. Available from: [http://rbms.info/files/dcrm/dcrmb/wg2LeslieGriffin.pdf](http://rbms.info/files/dcrm/dcrmb/wg2LeslieGriffin.pdf)

\[[2](https://journal.code4lib.org/articles/#ref2)\] \[[7](https://journal.code4lib.org/articles/#ref7)\] Library of Congress. 1999 \[updated 2019 November\]. MARC 21 Format for Bibliographic Data, 752. Washington, DC: Library of Congress, Network Development and MARC Standards Office \[cited 2019 December 9\]. Available from: [https://www.loc.gov/marc/bibliographic/bd752.html](https://www.loc.gov/marc/bibliographic/bd752.html)

\[[6](https://journal.code4lib.org/articles/#ref6)\] Library of Congress. 1999b \[updated 2019 November\]. MARC 21 Format for Bibliographic Data, 260. Washington, DC: Library of Congress, Network Development and MARC Standards Office \[cited 2019 December 9\]. Available from: [https://www.loc.gov/marc/bibliographic/bd260.html](https://www.loc.gov/marc/bibliographic/bd260.html)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Library of Congress. 2004. MARC discussion paper 2004-DP02. Washington, DC: Library of Congress, Network Development and MARC Standards Office \[cited 2019 December 11\]. Available from: [https://www.loc.gov/marc/marbi/2004/2004-dp02.html](https://www.loc.gov/marc/marbi/2004/2004-dp02.html)

\[[4](https://journal.code4lib.org/articles/#ref4)\] Library of Congress. 2004b. MARC discussion paper 2016-DP21. Washington, DC: Library of Congress, Network Development and MARC Standards Office \[cited 2019 December 11\]. Available from: [https://www.loc.gov/marc/mac/2016/2016-dp21.html](https://www.loc.gov/marc/mac/2016/2016-dp21.html)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Library of Congress. 2004c. MARC proposal no. 2004-07. Washington, DC: Library of Congress, Network Development and MARC Standards Office \[cited 2019 December 11\]. Available from: [https://www.loc.gov/marc/marbi/2004/2004-07.html](https://www.loc.gov/marc/marbi/2004/2004-07.html)

\[[28](https://journal.code4lib.org/articles/#ref28)\] pandas: Python data analysis library \[updated 2020 March\]. Available from: [http://pandas.pydata.org](http://pandas.pydata.org/)

\[[22](https://journal.code4lib.org/articles/#ref22)\] Peddie, RA. 1932. Place names in imprints: an index to the latin and other forms used on title pages. London: Grafton & Co. \[cited 2019 December 12\].

\[[30](https://journal.code4lib.org/articles/#ref30)\] \[[31](https://journal.code4lib.org/articles/#ref31)\] Program for Cooperative Cataloging. 2019. Task Group on Linked Data Best Practices Final Report. Washington, DC: Program for Cooperative Cataloging, Library of Congress \[cited 2019 December 12\]. Available from: [https://www.loc.gov/aba/pcc/taskgroup/linked-data-best-practices-final-report.pdf](https://www.loc.gov/aba/pcc/taskgroup/linked-data-best-practices-final-report.pdf)

\[[32](https://journal.code4lib.org/articles/#ref32)\] Program for Cooperative Cataloging. 2019b \[updated 2019 August 31\]. MARC object table. Washington, DC: Program for Cooperative Cataloging, Library of Congress \[cited 2019 December 12\]. Available from: [https://docs.google.com/spreadsheets/d/1MEt87ymZJiWJRh\_pSATjPAEcXV\_30HW4c1sKbrzq8RA/edit#gid=55309217](https://docs.google.com/spreadsheets/d/1MEt87ymZJiWJRh_pSATjPAEcXV_30HW4c1sKbrzq8RA/edit#gid=55309217)

\[[33](https://journal.code4lib.org/articles/#ref33)\] Program for Cooperative Cataloging. 2019c. Task Group on URIs in MARC. Formulating and obtaining URIs: a guide to commonly used vocabularies and reference sources. Washington, DC: Program for Cooperative Cataloging, Library of Congress \[cited 2019 December 12\]. Available from: [https://www.loc.gov/aba/pcc/bibframe/TaskGroups/formulate\_obtain\_URI\_guide.pdf](https://www.loc.gov/aba/pcc/bibframe/TaskGroups/formulate_obtain_URI_guide.pdf)

\[[27](https://journal.code4lib.org/articles/#ref27)\] PyMARC \[updated 2020 April\]. Available from: https://gitlab.com/pymarc/pymarc

\[[12](https://journal.code4lib.org/articles/#ref12)\] Sjökvist, P. 2016. Transcription in Rare Books Cataloging. Cataloging & Classification Quarterly \[Internet\]. \[cited 2019 December 12\]; 54:5-6. Available from: [https://doi.org/10.1080/01639374.2016.1192079](https://doi.org/10.1080/01639374.2016.1192079)

\[[29](https://journal.code4lib.org/articles/#ref29)\] Thompson, K. and Traill, S. 2017. Leveraging Python to Improve Ebook Metadata Selection, Ingest, and Management. Code4Lib Journal \[Internet\], Issue 38 \[cited 2019 December 11\]. Available from: [https://journal.code4lib.org/articles/12828](https://journal.code4lib.org/articles/12828)

*kalan Knudson Davis* is the Special Collections Metadata Librarian at the University of Minnesota Libraries. She provides intellectual access for rare materials held in the Wangensteen Historical Library, the James Ford Bell Library, and the Andersen Horticultural Library where she performs specialized and rare book cataloging using a variety of descriptive standards including Resource Description Access (RDA) and the Descriptive Cataloging of Rare Materials (DCRM) manuals; provides subject access; and applies various classification schemas. Although classically-trained as an Anglo-American Cataloging Rules revision 2 (AACR2) cataloger, she aspires to become one of Jay Jordan’s Information Jedi. kalan actively feeds her keen interest in book history, codicology, paleography, bibliographical description, bookbindings, provenance, and other related disciplines, which in turn, informs her cataloging practice.
---
title: "Metadata Analysis at the Command-Line"
source: "https://journal.code4lib.org/articles/7818"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-01-15
created: 2025-01-10
description: "Over the past few years the University of North Texas Libraries' Digital Projects Unit (DPU) has developed a set of metadata analysis tools, processes, and methodologies aimed at helping to focus limited quality control resources on the areas of the collection where they might have the most benefit. The key to this work lies in [...]"
tags:
  - "clippings"
---
# Metadata Analysis at the Command-Line
Mark Phillips

Over the past few years the University of North Texas Libraries’ Digital Projects Unit (DPU) has developed a set of metadata analysis tools, processes, and methodologies aimed at helping to focus limited quality control resources on the areas of the collection where they might have the most benefit. The key to this work lies in its simplicity: records harvested from OAI-PMH-enabled digital repositories are transformed into a format that makes them easily parsable using traditional Unix/Linux-based command-line tools. This article describes the overall methodology, introduces two simple open-source tools developed to help with the aforementioned harvesting and breaking, and provides example commands to demonstrate some common metadata analysis requests. All software tools described in the article are available with an open-source license via the author’s GitHub account.

## Introduction

The UNT Libraries’ Digital Libraries Division is responsible for the creation and quality review of the majority of metadata records in the UNT Libraries’ Digital Collections. These collections contain items of similar format to other university library collections of comparable size. Items in the collections include digitized and born-digital photographs, letters, documents, maps, ledgers, technical reports, and theses and dissertations. The size and scope of these collections continue to grow at an increasing rate for the past three years measuring 83,000, 93,000, and 120,000 items added per year for the fiscal years 2010, 2011, and 2012. The continued growth in these collections means that there are a greater number of metadata records created by an increasing number of metadata creators, which in turn causes a wider variance in quality. The need to analyze and report statistics for these metadata records has lead the UNT Libraries to develop new tools and processes to ensure that high quality metadata records are used throughout its digital library collections.

This article describes an approach in use at the UNT Libraries for harvesting metadata records from an OAI-PMH repository and then transforming them into a simpler text format, which can easily be consumed by a number of standard command-line tools available freely on most Unix and Linux based systems. Metadata quality, as defined for this article, falls into three major areas.

Collection Level Analytics – How many of something are in the entire collection of metadata records? For example, how many unique creators are represented by the collection? Which creator is associated with the most items? What item in the collection has the most creator, subject or coverage instances? These analytics are helpful in communicating metrics about the collection to others.

Metadata Completeness – How well does the collection’s item-level metadata conform to various measures of completeness? What are required fields for a given subset of metadata, and how well do the collection’s metadata records adhere to these requirements? How does this collection of metadata meet both metadata creator and metadata consumer ideals of value?

Metadata Value Quality – Based on local requirements, how well do the values within a given metadata record match those of standard or defined metadata specifications? For example, if a collection of metadata records utilizes the Extended Date Time Format for the date values in the collection, how well does the metadata collection meet the requirement of that format? Which values need to be changed in order to meet more of the requirements?

The tools and methodology explained in this article provide a way of identifying these areas of metadata cleanup to focus our attention, and help answer the question, “If there is a limited amount of time to spend on metadata cleanup, what is the best use of this time?”

## Getting the data to the right tools

The command line in the Unix/Linux environment offers a number of tools which when used in different combinations provide a useful pipeline for manipulating data. The workflow described below makes use of many standard Unix/Linux tools:

- **sort** – sort each line of a text file
- **uniq** – report or omit repeated lines
- **wc** – count the number of words or lines
- **awk** – pattern-directed scanning and processing language
- **grep** – print lines matching a supplied pattern

These tools work by having the output (standard output or stdout) of one tool act as the input (standard input or stdin) of the next tool, and chaining these tools together by directing the output and input in a series of processes often referred to as a pipeline.

The tools generally operate on simple text formats. The most challenging aspect of working with these tools in a metadata analysis workflow is converting the metadata from a metadata repository into a format that can be easily consumed by the tools.

Many repositories have adopted the Open Archives Initiatives Protocol for Metadata Harvesting (OAI-PMH) \[[1](https://journal.code4lib.org/articles/#note1)\] as a way to share metadata with others. At this time there are over 1,850 repositories worldwide that make metadata available with this protocol. The methodology described in this article makes use of OAI-PMH as the way to retrieve records from a repository.

A concise view of the methodology used by the UNT Libraries is to provide a straightforward workflow for harvesting records with a simple OAI-PMH harvester into an xml file referred to as a “repository file,” then using another small tool to convert this repository into a text format that is easily consumed by common command-line tools.

Once metadata records have been collected the next step is to convert from the format presented by the OAI-PMH repository into a format that is usable by the previously mentioned command-line tools. An example of the difference in representation can be outlined in the following two examples:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39 | `<``record``>`  `<``header``>`  `<``identifier``>info:ark/67531/metadc97952</``identifier``>`  `<``datestamp``>2012-08-17T12:16:00Z</``datestamp``>`  `<``setSpec``>partner:UNTCAS</``setSpec``>`  `<``setSpec``>collection:UNTSW</``setSpec``>`  `<``setSpec``>access_rights:public</``setSpec``>`  `</``header``>`  `<``metadata``>`  `<``dc:title``>Fenología de Tayloria dubyi (Splachnaceae) en las turberas de la Reserva de Biosfera Cabo de Hornos</``dc:title``>`  `<``dc:title``>Phenology of Tayloria dubyi (Splachnaceae) in the peatlands of the Cape Horn Biosphere Reserve</``dc:title``>`  `<``dc:title``>Sub-Antarctic Biocultural Conservation Program</``dc:title``>`  `<``dc:creator``>Jofre, Jocelyn</``dc:creator``>`  `<``dc:creator``>Massardo, Francisca</``dc:creator``>`  `<``dc:creator``>Rozzi, Ricardo</``dc:creator``>`  `<``dc:creator``>Goffinet, Bernard</``dc:creator``>`  `<``dc:creator``>Marino, Paul</``dc:creator``>`  `<``dc:creator``>Raguso, Robert</``dc:creator``>`  `<``dc:creator``>Navarro, Nelso P.</``dc:creator``>`  `<``dc:subject``>bryophytes</``dc:subject``>`  `<``dc:subject``>Cape Horn Biosphere Reserve</``dc:subject``>`  `<``dc:subject``>phenology reproduction</``dc:subject``>`  `<``dc:subject``>Splachnaceae</``dc:subject``>`  `<``dc:subject``>sub-Antarctic Magellanic ecoregion</``dc:subject``>`  `<``dc:description``>This article discusses the phenology of Tayloria dubyi (Splachnaceae) in the peatlands of the Cape Horn Biosphere Reserve. The sub-Antarctic Magellanic ecoregion harbors a high diversity of bryophytes, greater than the species richness of vascular plants. Despite this fact, phenological studies on bryophytes are lacking for this ecoregion and Chile. Based on the study of the sporophytic phase of Tayloria dubyi, an endemic moss from the sub-Antarctic Magellanic ecoregion, the authors propose a methodology for phonological studies on austral bryophytes. The authors defined five phenophases, easily distinguishable with a hand-lens, which were monthly recorded during 2007 and 2008 in populations of T. dubyi at the Omora Ethnobotanical Park and Mejillones Bay on Navarino Island (55°S) in the Cape Horn Biosphere Reserve. The sporophytic (or reproductive) phase of T. dubyi presented a clear seasonality. After growing in November, in three months (December - February) of the austral reproductive season the sporophytes mature and release their spores; by March they are already senescent T. dubyi belongs to the Splachnaceae family for which entomochory (dispersal of spores by insects, specifically Diptera) has been detected in the Northern Hemisphere. The period of spores release in T. dubyi coincides with the months of highest activity of Diptera which are potential dispersers of spores; hence, entomochory could also take place in sub-Antarctic Magellanic ecoregion. In sum, the authors' work: (i) defines a methodology for phenological studies in austral bryophytes, (ii) it records a marked seasonality ion the sporophyte phase of T. dubyi, and (iii) it proposes to evaluate in future research the occurrence of entomochory in splachnaceae species growing in the sub-Antarctic peatlands and forest ecosystems in the Southern Hemisphere.</``dc:description``>`  `<``dc:publisher``>Sociedad de Biología de Chile</``dc:publisher``>`  `<``dc:date``>2010</``dc:date``>`  `<``dc:type``>Article</``dc:type``>`  `<``dc:format``>12 p.</``dc:format``>`  `<``dc:format``>Text</``dc:format``>`  `<``dc:identifier``>ark: ark:/67531/metadc97952</``dc:identifier``>`  `<``dc:source``>Revista Chilena de Historia Natural, 2010, Santiago: Sociedad de Biología de Chile, pp. 195-206</``dc:source``>`  `<``dc:language``>Spanish</``dc:language``>`  `<``dc:rights``>Public</``dc:rights``>`  `</``oai_dc:dc``>`  `</``metadata``>`  `</``record``>` |
| --- | --- |

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26 | `info:ark/67531/metadc97952  {[http://purl.org/dc/elements/1.1/](http://purl.org/dc/elements/1.1/)}title Fenología de Tayloria dubyi (Splachnaceae) en las turberas de la Reserva de Biosfera Cabo de Hornos`  `info:ark/67531/metadc97952  {[http://purl.org/dc/elements/1.1/](http://purl.org/dc/elements/1.1/)}title Phenology of Tayloria dubyi (Splachnaceae) in the peatlands of the Cape Horn Biosphere Reserve`  `info:ark/67531/metadc97952  {[http://purl.org/dc/elements/1.1/](http://purl.org/dc/elements/1.1/)}source    Revista Chilena de Historia Natural, 2010, Santiago: Sociedad de Biología de Chile, pp. 195-206`  `info:ark/67531/metadc97952  {[http://purl.org/dc/elements/1.1/](http://purl.org/dc/elements/1.1/)}description   This article discusses the phenology of Tayloria dubyi (Splachnaceae) in the peatlands of the Cape Horn Biosphere Reserve. The sub-Antarctic Magellanic ecoregion harbors a high diversity of bryophytes, greater than the species richness of vascular plants. Despite this fact, phenological studies on bryophytes are lacking for this ecoregion and Chile. Based on the study of the sporophytic phase of Tayloria dubyi, an endemic moss from the sub-Antarctic Magellanic ecoregion, the authors propose a methodology for phonological studies on austral bryophytes. The authors defined five phenophases, easily distinguishable with a hand-lens, which were monthly recorded during 2007 and 2008 in populations of T. dubyi at the Omora Ethnobotanical Park and Mejillones Bay on Navarino Island (55°S) in the Cape Horn Biosphere Reserve. The sporophytic (or reproductive) phase of T. dubyi presented a clear seasonality. After growing in November, in three months (December - February) of the austral reproductive season the sporophytes mature and release their spores; by March they are already senescent T. dubyi belongs to the Splachnaceae family for which entomochory (dispersal of spores by insects, specifically Diptera) has been detected in the Northern Hemisphere. The period of spores release in T. dubyi coincides with the months of highest activity of Diptera which are potential dispersers of spores; hence, entomochory could also take place in sub-Antarctic Magellanic ecoregion. In sum, the authors' work: (i) defines a methodology for phenological studies in austral bryophytes, (ii) it records a marked seasonality ion the sporophyte phase of T. dubyi, and (iii) it proposes to evaluate in future research the occurrence of entomochory in splachnaceae species growing in the sub-Antarctic peatlands and forest ecosystems in the Southern Hemisphere.` |
| --- | --- |

The first example displays a common oai\_dc record produced by an OAI-PMH repository. The second example shows the way that many of the command line tools expect to receive text: flattened and consistently delimited.

By utilizing OAI-PMH for this workflow, the concepts, methods, and tools are more portable and work with any repository that supports this protocol. This approach can therefore be more broadly applied than a workflow tightly integrated into an individual platform’s infrastructure.

The tools developed for this workflow are described below with examples of common metadata analysis operations following the tool description.

## Introduction to the tools

### OAI-PMH Harvester

The first tool is an OAI-PMH harvester written in Python and based significantly on the Two Page OAI Harvester from OCLC Research \[[2](https://journal.code4lib.org/articles/#note2)\]. The harvester, while simple, offers a set of options that cover many standard use cases for harvesting metadata records from an OAI-PMH repository. The harvester takes as input the URL for an OAI-PMH repository and the name of the output file for storing the results of the harvest. The output of the OAI-PMH response is stored as a single xml file enclosed in a set of <repository> tags.

The above command will harvest all records from the OAI-PMH repository available at the url [http://digital.library.unt.edu/explore/collections/UNTSW/oai/](http://digital.library.unt.edu/explore/collections/UNTSW/oai/) and save them as a file named untsw.dc.xml. The default metadata format of oai\_dc is requested from the repository and transmitted back to the harvester. For a full list of command line options see the help screen for the script:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `mphillips$ python pyoaiharvest.py -h`  `Usage: pyoaiharvest.py [options]`  `Options:`  `-h, --help            show this help message and exit`  `-l LINK, --link=LINK  URL of repository`  `-o FILENAME, --filename=FILENAME`  `write repository to file`  `-f FROMDATE, --from=FROMDATE`  `harvest records from this date yyyy-mm-dd`  `-u UNTIL, --until=UNTIL`  `harvest records until this date yyyy-mm-dd`  `-m MDPREFIX, --mdprefix=MDPREFIX`  `use the specified metadata format`  `-s SETNAME, --setName=SETNAME`  `harvest the specified set` |
| --- | --- |

The tool supports requesting a specific setSpec, a different metadata format, or limiting to a date range for updating collections of existing records.

### Repository Breakers

Once a set of metadata records have been harvested, the next step of processing metadata records is converting them into a text format that can act as input to common command line tools. The tool dc\_breaker.py is used for this function. This tool efficiently consumes the output format from the pyoaiharvester.py script as input and provides a set of options for converting this into formats easily used by other command-line tools.

The example above runs the tool without any options selected. This will generate an output that can be helpful for seeing the overall utilization of fields within a collection of metadata records. It shows the fifteen elements of the oai\_dc metadata scheme, as well as a visualization of the percentage of records in the repository file which have at least one value in this element. Next, the output presents a column showing the number of records in the repository that contain this field related to the total number of records in the collection and, finally, a percentage of utilization of this field in the collection.

Next, the tool provides a set of completeness scores, which give another type of overview of the collection. The first score is a percentage of completeness assuming that all fifteen of the oai\_dc elements are required, the second is a measure of completeness as a collection. This percentage takes into account the fields used within the collection and generates a percentage of completeness based on those fields being present. For example, if a collection of metadata records uses the fields title, creator, description, and data exclusively, only these fields are used in the calculation of collection completeness. Finally, the percentage of completeness is based on the recommendation by the Kernel Metadata and Electronic Resource Citations (ERCs) \[[3](https://journal.code4lib.org/articles/#note3)\] community, which state that the who, what, where, when of an item are required for adequate access and citation of an item. In this case who is mapped to creator, what is mapped to title, where is mapped to identifier and when is mapped to date. In addition to these completeness values there is an average of the three scores presented. These completeness measures are useful as an overview of collection level metadata and in showing improvement resulting from metadata cleanup activities.

Other sample uses of this tool are printing to standard output each value of a specific element either by itself or in the format of identifier <tab> value.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25 | `mphillips$ python dc_breaker.py -e creator untsw.dc.xml`  `Tummala, Dinesh`  `Li, Xinrong`  `Nguyen, Son`  `Akl, Robert G.`  `Garlick, Ryan`  `Akl, Robert G.`  `Li, Wenming`  `Kavi, Krishna`  `Akl, Robert G.`  `Alhabsi, Amer H.`  `Al-Rizzo, Hussain M.`  `Akl, Robert G.`  `Akl, Robert G.`  `Parvez, Asad`  `Nguyen, Son`  `Akl, Robert G.`  `Naraghi-Pour, Mort`  `Hegde, Manju`  `Haidar, Mohamad`  `Akl, Robert G.`  `Al-Rizzo, Hussain`  `Chan, Yupo`  `...` |
| --- | --- |

This example shows each instance of the creator element in the repository with one instance per line.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25 | `mphillips$ python dc_breaker.py -e creator -i untsw.dc.xml`  `info:ark/67531/metadc30827      Tummala, Dinesh`  `info:ark/67531/metadc30827      Li, Xinrong`  `info:ark/67531/metadc30820      Nguyen, Son`  `info:ark/67531/metadc30820      Akl, Robert G.`  `info:ark/67531/metadc30828      Garlick, Ryan`  `info:ark/67531/metadc30828      Akl, Robert G.`  `info:ark/67531/metadc30824      Li, Wenming`  `info:ark/67531/metadc30824      Kavi, Krishna`  `info:ark/67531/metadc30824      Akl, Robert G.`  `info:ark/67531/metadc30829      Alhabsi, Amer H.`  `info:ark/67531/metadc30829      Al-Rizzo, Hussain M.`  `info:ark/67531/metadc30829      Akl, Robert G.`  `info:ark/67531/metadc30826      Akl, Robert G.`  `info:ark/67531/metadc30826      Parvez, Asad`  `info:ark/67531/metadc30826      Nguyen, Son`  `info:ark/67531/metadc30823      Akl, Robert G.`  `info:ark/67531/metadc30823      Naraghi-Pour, Mort`  `info:ark/67531/metadc30823      Hegde, Manju`  `info:ark/67531/metadc30835      Haidar, Mohamad`  `info:ark/67531/metadc30835      Akl, Robert G.`  `info:ark/67531/metadc30835      Al-Rizzo, Hussain`  `info:ark/67531/metadc30835      Chan, Yupo`  `...` |
| --- | --- |

This is very similar to the previous example but it prepends the records identifier from the oai record identifier to the beginning of each line and separates the identifier from the value by a tab character.

When working with metadata record cleanup it is sometimes necessary to identify which records in a set do not have a value. This can be accomplished by adding the –p flag which displays if an instance of the specified element is present in the record.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 | `mphillips$ python dc_breaker.py -e creator -p untsw.dc.xml`  `info:ark/67531/metadc27055 True`  `info:ark/67531/metadc27052 True`  `info:ark/67531/metadc27051 True`  `info:ark/67531/metadc27057 True`  `info:ark/67531/metadc27050 True`  `info:ark/67531/metadc27058 True`  `info:ark/67531/metadc27054 True`  `info:ark/67531/metadc27059 True`  `info:ark/67531/metadc27056 True`  `info:ark/67531/metadc27053 True`  `info:ark/67531/metadc27175 True`  `info:ark/67531/metadc27172 True`  `info:ark/67531/metadc27171 True`  `info:ark/67531/metadc27177 True`  `info:ark/67531/metadc111250 False`  `...` |
| --- | --- |

This displays the identifier for the record followed by a True if the record has value for that element or False if the record does not have value for the specified element.

Finally an option to dump all data in the repository file into a tab-delimited format is available by using the flag –d.

## Metadata Analysis Examples

The examples below make use of records harvested from the UNT Scholarly Works and UNT Theses and Dissertation collection hosted by the UNT Digital Library \[[4](https://journal.code4lib.org/articles/#note4)\]. The OAI-PMH repository links are available at the following URLS:

UNT Scholarly Works – [http://digital.library.unt.edu/explore/collections/UNTSW/oai/](http://digital.library.unt.edu/explore/collections/UNTSW/oai/)

UNT Theses and Dissertations – [http://digital.library.unt.edu/explore/collections/UNTETD/oai/](http://digital.library.unt.edu/explore/collections/UNTETD/oai/)

These metadata collections are saved as untsw.dc.xml and untetd.dc.xml respectively for the purpose of these examples.

### Find Most Prolific Creators in a set of Records

| 1  2  3  4  5  6  7  8  9  10  11  12 | `mphillips$ python dc_breaker.py -e creator untsw.dc.xml \| sort \| uniq -c \| sort -n -r \| head`  `107 Mihalcea, Rada`  `93 Cundari, Thomas R.`  `90 Falsetta, Vincent`  `89 Phillips, Mark Edward`  `85 Spear, Shigeko`  `77 Moen, William E.`  `61 Marshall, James L., 1940-`  `59 Murray, Kathleen`  `58 Marshall, Virginia R.`  `57 Eve, Susan` |
| --- | --- | --- | --- | --- | --- |

This pipeline of commands will display back the ten most frequent creators. Here is what the pipeline is doing:

1. First the dc\_breaker script is used to extract creator elements from each record.
2. The output of all creators is sorted by the sort command.
3. The output of the sort command is then made unique by the unix uniq command which is given the flag to append the number of times that value is present.
4. The resulting set is sorted again this time by the count of each value from highest value to lowest using the –n and –r options.
5. Finally the first ten values are returned along with their counts.

### Find the number of unique creators in a dataset

| 1  2 | `mphillips$ python dc_breaker.py -e creator untsw.dc.xml \| sort \| uniq \| wc -l`  `1592` |
| --- | --- | --- | --- | --- |

This example extracts all of the creators in the repository, sorts the values, makes them unique and finally passes these to the wc (word count) utility with the –l option selected to count only lines. This returns the number of unique creators in a dataset, which can answer questions such as “How many creators have content in the UNT Scholarly Works Repository?”

### Find the number of subjects per record

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `mphillips$ python dc_breaker.py -e subject -i untsw.dc.xml \| cut -f 1 \| sort \| uniq -c \| sort -n -r `  `24 info:ark/67531/metadc111236`  `21 info:ark/67531/metadc29400`  `21 info:ark/67531/metadc111261`  `20 info:ark/67531/metadc111271`  `20 info:ark/67531/metadc111269`  `20 info:ark/67531/metadc111200`  `17 info:ark/67531/metadc29401`  `17 info:ark/67531/metadc29393`  `17 info:ark/67531/metadc111212`  `17 info:ark/67531/metadc111177`  `16 info:ark/67531/metadc29399`  `16 info:ark/67531/metadc111216`  `16 info:ark/67531/metadc111206`  `...` |
| --- | --- | --- | --- | --- | --- |

This example extracts all subjects in the repository with the identifier appended to the beginning of the line. This identifier is extracted from the line using the cut utility and then sorted, made unique and finally sorted again. The result is a list containing the number of subjects in a record followed by that records identifier. This output is useful when a collection has requirements pertaining to the number of subjects per record such as, “a minimum of three subjects per record, or no more than six subjects per record”.

### Find the average number of subjects per record

| 1  2  3 | `mphillips$ python dc_breaker.py -e subject -i untetd.dc.xml \| cut -f 1 \| sort \| uniq -c \| awk '{sum+=$1} END { print &quot;Average = &quot;,sum/NR}'`  `Average =  5.79016` |
| --- | --- | --- | --- | --- | --- |

This example builds on the previous by adding the use of the awk utility to calculate the average number of subjects per record in the repository. This information is especially useful in analyzing the overall subject usage patterns across various collections.

### Find the records without any Creators

| 1  2 | `mphillips$ python dc_breaker.py -e creator -p untsw.dc.xml \| grep False`  `info:ark/67531/metadc111250 False` |
| --- | --- | --- |

The output of this example is a record identifier followed by True or False based on the presence of the specified field, this time creator. After piping this output to grep and searching only for lines that have False in them, we can see which records do not have any creator values. If each record in a collection should have a creator element present, this output makes it easy to find records lacking this value.

### List creators sorted by creator value

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27 | `mphillips$ python dc_breaker.py -e creator untsw.dc.xml \| sort`  `AECO Economic and Community Development Class Fall, 2009`  `Aars, Christian`  `Abel, Mickey`  `Abel, Mickey`  `Acevedo, Mitzi`  `Adada, Rami`  `Adalar, Mehmet`  `Adams, Mark`  `Adams, Mark`  `...`  `Zhang, Cankui`  `Zhang, Jubo`  `Zhang, Xue`  `Zhang, Xue`  `Zhang, Xue`  `Zhang, Xue`  `Zhang, Xue`  `Zhao, Yong`  `Zhi, Miaochan`  `Zhou, Tie`  `Zhou, Tie`  `Zhou, Xin`  `Zhou, Xin`  `Zhou, Xin`  `Zhu, Yuntian` |
| --- | --- | --- |

This example demonstrates a common usage of the dc\_breaker tool in which all values of a field are printed to the screen and then sorted. It is useful for identifying slight misspellings between adjacent values. This is particularly helpful with the creator and contributor fields when trying to normalize names values that are similar, which should be replaced with an authoritative version.

### List creator values sorted by the number of times they occur

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 | `mphillips$ python dc_breaker.py -e creator untsw.dc.xml \| sort \| uniq -c`  `1 AECO Economic and Community Development Class Fall, 2009`  `1 Aars, Christian`  `2 Abel, Mickey`  `1 Acevedo, Mitzi`  `1 Adada, Rami`  `1 Adalar, Mehmet`  `2 Adams, Mark`  `1 Aerts, Andrea`  `...`  `2 Zeug, Nicole M.`  `1 Zhang, Cankui`  `1 Zhang, Jubo`  `5 Zhang, Xue`  `1 Zhao, Yong`  `1 Zhi, Miaochan`  `2 Zhou, Tie`  `3 Zhou, Xin`  `1 Zhu, Yuntian` |
| --- | --- | --- | --- |

This example adds the uniq tool to the pipeline from the previous example. The uniq tool with the –c (count) option takes a sorted list (supplied by the sort command) and sums the value instances before returning a row for each unique value preceded by the number of times it is present in the dataset. This shows the number of time each value occurs in the dataset, from which it is possible to derive the relative importance of one value over another.

| 1  2  3  4  5  6 | `mphillips$ python dc_breaker.py -e contributor untetd.dc.xml \| sort \| uniq -c`  `8 Mikler, Armin`  `48 Mikler, Armin R.`  `1 Mikler, Susie`  `1 Ramisetty-Mikler, Suhasini`  `1 Ramisetty-Mikler, Susie` |
| --- | --- | --- | --- |

This example shows that one value is most likely incorrect based on the fact that there are so many instances of the other version of the value (“Mikler, Armin”, 8), (“Mikler, Armin, R.”, 48).

### List field values sorted by anagram hashes

Another variation on the previous models is helpful in certain situations. When comparing names in a dataset you may come across versions of names that are inverted (Last, First) as well as natural order (First Last). When identifying possible metadata changes based on adjacency in a list, these values would not appear next to each other based on a normal sort order.

Mark Phillips  
Phillips, Mark

By feeding these values into a simple anagram hash function and then sorting the values based on the hash it is possible to get these values to group together and helpful to identify related problems.

aihkmlpsr Mark Phillips  
aihkmlpsr Phillips, Mark

| 1  2  3  4  5  6  7  8  9  10  11  12 | `import` `sys`  `import` `re`  `def` `anagram_string(string):`  `string ``=` `string.lower()`  `string ``=` `re.sub(``"[\W\d]"``, "", string)`  `return` `"".join(``set``(string))`  `for` `line ``in` `sys.stdin:`  `print` `"%s\t%s"` `%` `(anagram_string(line.strip()), line.strip())` |
| --- | --- |

| 1  2  3  4  5  6  7  8  9 | `mphillips$ python dc_breaker.py -e contributor untetd.dc.xml \| python example-018.txt \| sort \| uniq -c`  `1 abeihlsru  Hariss, Beulah`  `1 abeihlsru  Harris Beulah`  `1 abeihlsru  Harris, Beulah  A.`  `6 abeihlsru  Harriss, Beulah`  `1 abeihlsru  Harriss, Beulah  A.`  `1 abeihlsru  Harriss, Beulah A`  `58 abeihlsru  Harriss, Beulah A.` |
| --- | --- | --- | --- | --- |

### Field Validation

#### Standard Format – Extended Date Time Format (EDTF)

These tools can also be helpful in validating a given value in a record based on a list of known values, a standard format, or a well-known feature. The following examples demonstrate the usage of these tools for this purpose:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 | `mphillips$ python dc_breaker.py -e date untsw.dc.xml \| python valid_edtf.py -`  `1987~   True`  `1987~   True`  `1981~   True`  `1987~   True`  `1990~   True`  `1987~   True`  `1987~   True`  `1987~   True`  `1987~   True`  `1986~   True`  `2003    True`  `2002    True`  `2002    True`  `2003    True`  `2001    True`  `2003    True`  `2002    True`  `...` |
| --- | --- | --- |

A little background is required for this example. The UNT Libraries are moving toward the adoption of the Extended Date/Time Format (EDTF) \[[5](https://journal.code4lib.org/articles/#note5)\] for encoding date information in their digital library. In order to identify values that comply with this specification a simple validator was created that compares a given string against the EDTF draft specification. The output of this script is in the following format:

2012 True  
2001~ True  
2012-12 True  
2012-15 False  
2012/12/12 False

It is then possible to filter the output to just instances that are invalid and investigate those in the dataset as examples of values to change.

Does the creator field have a comma (Are names properly inverted)

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `mphillips$ python dc_breaker.py -e contributor untetd.dc.xml \| grep -v &quot;,&quot;`  `William. D. Deering`  `Jesus Rosales-Ruiz`  `Brian Richardson`  `Sue Bratton`  `May. Andrew`  `Nann Goplerud`  `Webb James F.`  `Blackburn S. A.`  `Harris Beulah`  `Harris B. B.`  `Silvey J. K. G.`  `Silvey J. K. G.`  `Sharp L. A.`  `[Silvey J. K. G.]` |
| --- | --- | --- |

In many digital library metadata settings names are notated in inverted fashion, separated by a comma. For example a name like “Mark Phillips” is notated as “Phillips, Mark” This example shows a quick way to identify values in a repository that are not formatted in this way. It prints the instances of creator names in the metadata records, which do not have commas. (This assumes that the presence of a comma is an indication of correct formatting.)

#### Longest title

Another use for this set of tools is to answer fairly obscure but important questions that arise in the library universe. One question that came up in the creation of the UNT Digital Library was, “what is the length of the longest titles we have in the system?” The user interface designer for the metadata display pages for records needed this. By using these tools it was relatively easy to find this answer.

| 1  2  3  4  5  6  7  8  9  10  11  12 | `mphillips$ python dc_breaker.py -e title untetd.dc.xml \| awk '{ print length($0) &quot; &quot; $0 }' \| sort -nr \| head`  `354 Greek texts and English translations of the Bible: a comparison and contrast of the Textus Receptus Greek New Testament of the sixteenth century and the Alexandrian text of Westcott and Hort (nineteenth century) and Aland and Metzger (twentieth century) concerning variant texts that pertain to the orthodox Christology of the Council of Nicea, A.D. 325.`  `353 A Comparative Study of the Habits, Attitudes, and Opinions in Regard to Cigarette Smoking on the Part of Three Hundred Freshman and Sophomore Women Students and Three Hundred Freshman and Sophomore Men Students Enrolled in Physical Education Activity Classes during the Spring Semester of the 1948-1949 Session at North Texas State College, Denton Texas`  `349 Synthesis and Characterization of Platinum(II)(2-(9-anthracenylylidene)-4,5-bis(diphenylphosphino)-4-cyclopenten-1,3-dione)(dichloride), Platinum(II)(2-(9-anthracenylylidene)-4,5-bis(diphenylphosphino)-4-cyclopenten-1,3-dione(maleonitriledithiolate), and Platinum(II)(4,5-bis(diphenylphosphino)-4-cyclopenten-1,3-dione)(4-Methyl-1,2-benzene dithiol)`  `336 A Performer's Analysis of Lili Boulanger's  Clairières dans le ciel: Song Cycle for High Voice and Piano; a Lecture Recital Together with the Role of Blanche in  Dialogues of the Carmelites  by F. Poulenc and Two Recitals of Selected Works by H. Purcell, F. Schubert, S. Prokofieff, E. Chausson, W. A. Mozart, R. Schumann and G. Fauré`  `332 Jules Massenet's Musical Prosody Focusing on His Eight Song Cycles And A Collection, Expressions Lyriques: A Lecture Recital, Together with Recitals of Selected Works of W. A. Mozart, F. Schubert, C. Debussy, R. Strauss, D. Argento, V. Bellini, J. Marx, W. Walton, C. Gounod, A. Scarlatti, G. Fauré, J. Rodrigo, H. Wolf, and Others`  `325 The 1986 National Endowment for the Arts Commission: An introspective analysis of two marimba works, Reflections on the Nature of Water by Jacob Druckman and Velocities by Joseph Schwantner, together with three recitals of selected works by Keiko Abe, Christopher Deane, Peter Klatzow, Wayne Siegel, Gitta Steiner and others.`  `302 The Influence of Selma Meerbaum-Eisinger's Death on Xaver Paul Thoma's Composition of  Ich bin in Sehnsucht Eingehüllt: Sieben Lieder für Sopran und Klavier,  A Lecture Recital Together with Three Recitals of  Selected Works of O. Messiaen, G.F. Handel, A. Scarlatti, J.S. Bach, W. Latham, and Others`  `282 Supplemental Studies for Mastering Extended Techniques in Three Late Twentieth-Century Works for Solo Trombone: Luciano Berio's  Sequenza V, Folke Rabe's  Basta and Mark Phillips'  T. Rex, Together with Three Recitals of Selected Works by Wagenseil, Grøndahl, Gotkovsky, and Others`  `276 Gradus ad Parnassum of Modern Flute Technique: An Explication of Musical Intention and Design in 30 Capricen für Flöte allein, Opus 107 by Sigfrid Karg-Elert, with Three Recitals of Selected Works by Schulhoff, Telemann, Berio, Bach, Rodrigo, Gieseking, Reinecke, and Others`  `276 A Study to Determine the Characteristics of Effective Application Letters for Teachers, with Particular Reference to College Positions, as Influenced by Reports from 65 College and University Presidents and an Analysis of 65 Sample Letters of Application for College Positions` |
| --- | --- | --- | --- | --- |

This example uses a combination of awk to append the number of characters in each title to the beginning of each line, numerically sort the lines in reverse order with sort, and finally use the head utility to print the top 10 lines of this new list.

## Conclusion

Harvesting metadata records from OAI-PMH repositories and then transforming these records into simple statements easily consumed by common command-line tools has significantly improved the workflow for identifying problems in metadata record collections and has allowed the UNT Libraries to utilize metadata enhancement resources in the most beneficial way possible. We have found that maintainers of metadata collections are eager to modify metadata records needing cleanup once identified using the methods described above. By using the methodology described in this article, the UNT Libraries is able to focus technology development resources on tools that can easily be integrated into this command-line environment. Currently in development are tools that help to further identify name collisions in creator, contributor, and publisher fields as well as validators for various fields and values present in the metadata used at the UNT Libraries.

## Obtaining code mentioned in this article

All code mentioned in this article is available freely at the author’s GitHub repository: [http://github.com/vphill/](http://github.com/vphill/).

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Open Archives Initiative – Protocol for Metadata Harvesting (OAI-PMH) [http://www.openarchives.org/pmh/](http://www.openarchives.org/pmh/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] 2PageOAI – [http://www.oclc.org/research/activities/oai2page.html](http://www.oclc.org/research/activities/oai2page.html)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Kernel Metadata and Electronic Resource Citations (ERCs) [http://dublincore.org/groups/kernel/spec/](http://dublincore.org/groups/kernel/spec/)

\[[4](https://journal.code4lib.org/articles/#ref4)\] UNT Digital Library – About the Technology [http://digital.library.unt.edu/about/digital-library/technology/](http://digital.library.unt.edu/about/digital-library/technology/)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Extended Date/Time Format (EDTF) [http://www.loc.gov/standards/datetime/](http://www.loc.gov/standards/datetime/)

Mark Phillips is Assistant Dean for Digital Libraries at the University of North Texas Libraries.
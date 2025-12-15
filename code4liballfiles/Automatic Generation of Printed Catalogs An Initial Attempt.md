---
title: "Automatic Generation of Printed Catalogs: An Initial Attempt"
source: "https://journal.code4lib.org/articles/3154"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-06-22
created: 2025-01-10
description: "Printed catalogs are useful in a variety of contexts. In special collections, they are often used as reference tools and to commemorate exhibits. They are useful in settings, such as in developing countries, where reliable access to the Internet—or even electricity—is not available. In addition, many private collectors like to have printed catalogs of their [...]"
tags:
  - "clippings"
---
# Automatic Generation of Printed Catalogs: An Initial Attempt
Jared Camins-Esakov

Printed catalogs are useful in a variety of contexts. In special collections, they are often used as reference tools and to commemorate exhibits. They are useful in settings, such as in developing countries, where reliable access to the Internet—or even electricity—is not available. In addition, many private collectors like to have printed catalogs of their collections. All the information needed for creating printed catalogs is readily available in the MARC bibliographic records used by most libraries, but there are no turnkey solutions available for the conversion from MARC to printed catalog. This article describes the development of a system, available on [github](http://github.com/jcamins/cataloggen/), that uses XSLT, Perl, and LaTeX to produce press-ready PDFs from MARCXML files. The article particularly focuses on the two XSLT stylesheets which comprise the core of the system, and do the “heavy lifting” of sorting and indexing the entries in the catalog. The author also highlights points where the data stored in MARC bibliographic records requires particular “massaging,” and suggests improvements for future attempts at automated printed catalog generation.

## Introduction

Since the advent of the OPAC, printed catalogs have become far less common than they once were. Printed catalogs still have value, however. In some cases, printed catalogs are useful because they provide access to bibliographic information in places where electronic access is impractical, such as Afghanistan, where I spent three months working as a librarian. Although we did not have a printed catalog at the university where I worked, one would have been helpful on days when we were without electricity. At the Kabul Education University, they had a single partial manuscript catalog of their holdings, which served their several thousand students far better than our OPAC served our several hundred. In addition to offering 100% uptime, students seemed to find it much easier to understand how to use the manuscript catalog.

In some cases, a printed catalog may be of particular value as a specialized bibliography suitable for browsing. This is particularly common in the world of rare books, where remarkably comprehensive collections are sometimes assembled. An example of this is Mary Ann O’Brian Malkin’s *Dancing by the Book* (New York: Privately Printed, 2003), a catalog of Malkin’s collection of books relating to the history of dance notations, now used by scholars interested the subject. \[[1](https://journal.code4lib.org/articles/#note1)\] Another good example would be Paul Needham’s *Twelve Centuries of Bookbinding: 400-1600* (New York: Pierpont Morgan Library, 1979), written to commemorate an exhibition at the Morgan library, and now a well-respected exemplar for the description of bindings.

In many cases, including the two just mentioned, printed catalogs that are well-respected as subject bibliographies were published at least partly to be keepsakes. Private collectors often produce printed catalogs as a monument to their accomplishments as collectors. They commonly do this shortly before selling the collection, so they have something to remind them of what they had. Both *Dancing by the Book* and the catalog discussed in this article could be considered keepsakes for private collectors. Keepsakes are also produced by many museums and special collections units in university libraries. Princeton University Special Collections, for example, publishes a catalog of every major exhibition they put on. \[[2](https://journal.code4lib.org/articles/#note2)\]

In early 2009, we were hired by a private collector to catalog his collection of ornithology books. We started the project expecting to prepare some sort of bibliographic database for his use on the computer. However, as the collector explained his desire for some sort of keepsake that would make it easy to check if he already owned a specific book, we realized that a printed catalog would probably be a better choice for him. Since he was more concerned with costs than with a perfectly typeset product, and we had computer programming experience, we decided to develop a system to automatically produce a press-ready PDF for a catalog that met the collector’s requirements:

- Title main entry (the collector felt this would be more useful than author main entry), with cross-references
- Indexes for authors, subjects, geographical subjects (the collector wanted a separate index that included only geographic headings for faster reference), and series
- Formatting reminiscent of catalog cards (i.e., ISBD punctuation)
- A unique catalog number for each book so he would not need to copy the entire citation if he ever wanted to take notes on a specific book

## System architecture

In the interest of having a finished product as soon as possible, we developed the system using whatever technology was easiest for each step. The result was a messy and heterogeneous (but effective) process that looks like this:

1. A data file in MARCXML format is run through an XSLT stylesheet for preprocessing, which generates guaranteed unique ID numbers for each record, and generates *see* references for titles in 246s.
2. The result is sanitized by a Perl script which converts MARC-8 composed characters into the appropriate LaTeX escapes, and corrects common misspellings.
3. This is then run through the main catalog generating XSLT stylesheet which produces the LaTeX file. This includes the index entries, which are commented out so that they are not picked up by LaTeX automatically.
4. LaTeX is run on the LaTeX file to initialize makeindex.
5. The index entries for the Name, Subject, Geographical, and Series indexes are extracted using standard \*nix utilities (grep and sed), and illegal characters are removed before each is written directly into the raw index file initialized by LaTeX.
6. Formatted indexes are generated using makeindex.
7. LaTeX is run twice more to incorporate the formatted indexes into the document and stabilize page number references in the table of contents (since the indexes are keyed to the entry numbers rather than page numbers, they are stabilized by step 3).
8. The resulting PDF file is run through ghostscript to generate a PDF compatible with the RIP processes used by print-on-demand services such as [lulu.com](http://www.lulu.com/).

## Implementing the preprocessor

The first, and possibly most thorny, problem we encountered in generating the catalog was dealing with title cross-references. The collector wanted to have access points for both the title proper (MARC field 245) and alternative titles (MARC field 246), but wanted only *see* references for alternative titles, so that each book was described only once in the catalog. This requirement presented two problems:

1. Based on our understanding of XSLT, using <xsl:apply-templates/> with <xsl:sort/> requires every tree being sorted to be at the same level in the source tree
2. Sorting main entries and *see* references at run-time, we could not guarantee that *see* references would point to the correct main entry, nor limit numbering only to main entries

A related problem came from the collector’s requirement that each record have an invariant catalog number associated with it. If we used <xsl:sort/> to sort both the main entries and the *see* references, the position() function would count *see* references as well as actual records, and using the preceding-sibling:: axis required far too much processing power for it to be a reasonable solution for catalogs of any significant length.

The solution we developed for these related issues is embodied in the 49-line preprocessor XSLT stylesheet. The preprocessor sorts the records by title main entry (MARC field 245), assigns a unique ordinal ID for each record, and generates a <see/> tag for each alternative title:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32 | `<``xsl:for-each` `select``=``"marc:record"``>`  `<``pre``> <``xsl:sort` `select``=``"lower-case(substring(marc:datafield&#91;@tag='245'&#93;/marc:subfield&#91;@code='a'&#93;,marc:datafield&#91;@tag='245'&#93;/@ind2 + 1))"` `order``=``"ascending"``/>`  `<``xsl:variable` `select``=``"position()"``/>`  `<``record``>`  `<``ref``><``xsl:value-of` `select``=``"$pos"``/></``ref``>`  `<``xsl:copy-of` `select``=``"./*"``/>`  `</``record``>`  `<``xsl:for-each` `select``=``"marc:datafield&#91;@tag='246'&#93;"``>`  `<``xsl:variable` `select``=``"marc:subfield&#91;@code='a'&#93;/text()"``/>`  `<``xsl:if` `test``=``"count(preceding-sibling::marc:datafield&#91;@tag='246'&#93;/marc:subfield&#91;@code='a' and text()=$subfield246a&#93;)=0 and not(contains($subfield246a,'&amp;')) and not(contains($subfield246a,'%26'))"``>`  `<``see``>`  `<``datafield` `tag``=``"245"` `ind1``=``"0"``>`  `<``xsl:choose``>`  `<``xsl:when` `test``=``"matches(marc:subfield&#91;@code='a'&#93;,'^A ')"``>`  `<``xsl:attribute``>2</``xsl:attribute``>`  `</``xsl:when``>`  `<``xsl:when` `test``=``"matches(marc:subfield&#91;@code='a'&#93;,'^The ')"``>`  `<``xsl:attribute``>4</``xsl:attribute``>`  `</``xsl:when``>`  `<``xsl:otherwise``><``xsl:attribute``>0</``xsl:attribute``></``xsl:otherwise``>`  `</``xsl:choose``>`  `<``xsl:for-each` `select``=``"marc:subfield"``>`  `<``xsl:copy-of` `select``=``"."``/>`  `</``xsl:for-each``>`  `</``datafield``>`  `<``title``><``xsl:copy-of` `select``=``"preceding-sibling::marc:datafield&#91;@tag='245'&#93;/*"``/></``title``>`  `<``ref``><``xsl:value-of` `select``=``"$pos"``/></``ref``>`  `</``see``>`  `</``xsl:if``>`  `</``xsl:for-each``>`  `</``xsl:for-each``>` |
| --- | --- |

By using this preprocessor, we were able to provide a sort key in field 245 for both records and *see* references for use in the main XSLT stylesheet, which is described in the next section.

## Implementing the catalog generator

Once we had developed the preprocessor stylesheet, writing the main catalog generator was fairly straightforward. We chose to adapt the MARC21slim2English.xsl stylesheet that the Library of Congress makes available on its website for our purposes. \[[3](https://journal.code4lib.org/articles/#note3)\] The bulk of the adaptation involved inserting the appropriate LaTeX markup around the output document, but there were a few specific parts of the catalog generator that presented problems. For example, although it is straightforward in hindsight, we had to account for non-filing characters when sorting the entries in the main loop:

| 1  2  3 | `<``xsl:apply-templates` `select``=``"marc:collection/marc:record \| marc:collection/marc:see"``>`  `<``xsl:sort` `select``=``"lower-case(substring(marc:datafield&#91;@tag='245'&#93;/marc:subfield&#91;@code='a'&#93;/text(),marc:datafield&#91;@tag='245'&#93;/@ind2 + 1))"` `order``=``"ascending"``/>`  `</``xsl:apply-templates``>` |
| --- | --- | --- |

The principle challenge in the main catalog generation routine was creating the indexes. Although we chose LaTeX for the powerful indexing functionality provided by makeindex, we quickly discovered that the automatic indexing routines in LaTeX would not meet our needs, since the index entries LaTeX generated used page numbers as locators, and we wanted to use catalog numbers as locators. The solution we came up with was to generate the entries for the .idx files we needed directly, and extract those entries from the output file for use with makeindex. The following code snippet shows the XSLT template that generated the index entries for general subjects (i.e., MARC fields 650 and 651):

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 | `<``xsl:template``>`  `<``xsl:if` `test``=``"@code='a' or @code='v' or @code='x' or @code='y' or @code='z' or @code='b' or @code='c' or @code='d' or @code='p'"``>`  `<``xsl:variable` `select``=``"preceding-sibling::marc:subfield&#91;position()=1&#93;/@code"``/>`  `<``xsl:if` `test``=``"$lastsubfield='a' or $lastsubfield='v' or $lastsubfield='x' or $lastsubfield='y' or $lastsubfield='z' or $lastsubfield='b' or $lastsubfield='c' or $lastsubfield='d' or $lastsubfield='p'"``>`  `<``xsl:text``>!</``xsl:text``>`  `</``xsl:if``>`  `<``xsl:value-of` `select``=``"replace(replace(replace(text(),'(&#91;\s.&#93;&#91;a-zA-Z&#93;)\.&#91;\s,;:&#93;*$','$1#'),'&#91;\s.,:;&#93;+$',''),'#','.')"``/>`  `</``xsl:if``>`  `</``xsl:template``>`  `<``xsl:template``>`  `<``xsl:param``/>`  `<``xsl:text``>%SUBJECT:\indexentry{</``xsl:text``>`  `<``xsl:for-each` `select``=``"marc:subfield"``>`  `<``xsl:call-template``/>`  `</``xsl:for-each``>`  `<``xsl:text``>}{</``xsl:text``><``xsl:value-of` `select``=``"$number"``/><``xsl:text``>}&amp;#10;</``xsl:text``>`  `</``xsl:template``>` |
| --- | --- |

Aside from those two challenges, however, the main stylesheet was not that difficult to develop. Most of the changes we made to the stylesheet in the course of development were cosmetic, relating more to the LaTeX preamble than to the actual generation of the catalog. The LaTeX markup (aside from the markup contained in the catalog entries themselves, of course) is segregated into two <xsl:text/> tags. The first contains the preamble (i.e., style definitions, and definitions of custom commands for producing the catalog) and the preliminary material. We ultimately found that the following definitions were needed in the preamble to create a PDF suitable for use with a print-on-demand service:

```
\documentclass[10pt]{book}
\usepackage{geometry}
\geometry{paperwidth=6in, paperheight=9in, textwidth=3.25in, textheight=7.3in, twoside, bottom=0.8in, left=1.25in}
\geometry{pdftex}
\usepackage[T5]{fontenc}
\usepackage{pslatex}
\usepackage{multind}
\usepackage{tipa}
\usepackage{sectsty}
\usepackage{graphicx}
\usepackage{tocvsec2}
\usepackage[compact]{titlesec}
\usepackage[pdftex]{hyperref}

\makeindex{names}
\makeindex{subject}
\makeindex{geo}
\makeindex{series}
```

The second contains the markup for generating the indexes:

```
\printindex{names}{Name index}
\printindex{subject}{Subject index}
\printindex{geo}{Geographical index}
\printindex{series}{Series index}
\end{document}
```

Our goal in formatting the catalog entries was to create a readable and attractive format reminiscent of a card from a traditional card catalog, while taking advantage of the additional space offered by pages. An example of the final result, which the collector was very happy with, can be seen here:

![](https://journal.code4lib.org/media/issue10/camins-esakov/examplerecord.png)  
**Figure 1. Example Record**

The name index (along with the subject and geographical indexes) used the default makeindex settings, resulting in a recognizably “LaTeX-y” index, as the following example shows:

![](https://journal.code4lib.org/media/issue10/camins-esakov/name_index.png)  
**Figure 2. Name Index Example**

The series index used a slightly modified style to make the volume numbers and catalog numbers easier to distinguish:

![](https://journal.code4lib.org/media/issue10/camins-esakov/series_index.png)  
**Figure 3. Series Index Example**

## Future improvements and directions

Overall, our experiment in generating a printed catalog automatically from MARC records was successful. After we finished, the collector had a press-ready PDF he could send off to a print-on-demand service, or read comfortably on his computer, and we had successfully prototyped and demonstrated a system for automatically generating printed catalogs from MARC records. Looking back on the project, however—success notwithstanding—what stands out are all the aspects that could have been done better.

In many ways, our major complaint with the system is that it is inelegant. The system is developed in a combination of XSLT, Perl, and LaTeX, with a healthy dose of Bourne Shell and standard \*nix utilities to tie the whole thing together. In an ideal world, of course, we would not have needed to use LaTeX (or Perl, or \*nix utilities) at all. A system that used XSL-FO for generating a PDF would reduce dependencies, simplify support for non-Latin scripts, and, perhaps most importantly, make it easier for non-LaTeX users to use the system (thanks to the ubiquity of XML, and particularly HTML, the syntax of XSL-FO seems, I think, less scary than the syntax of LaTeX). Unfortunately, our initial research indicated that index generation in XSL-FO would be very problematic, so—as we had a tight deadline—we had to shelve the idea of an entirely-XML stack.

Of the many inelegances, the most egregious is the use of the main XSLT stylesheet to generate the entire LaTeX document. In hindsight, a better way to do this would be to have a skeleton LaTeX document include the results of the stylesheet’s processing. By doing this, global formatting changes could be tested without rerunning the XSLT stylesheet. This would also simplify the production of multiple catalogs with identical content but differing preliminaries, fonts or page sizes (all issues that came up at one point or another in the process). Taking this idea to its logical end, the system should use LaTeX macros for all format-specific features. We were unable to meet this ideal with the positioning of the frames containing ISBNs, but aside from that, we used LaTeX macros for all other formatting within the individual records.

Another example of inelegance is the heavy use of the copy-and-paste development methodology in the main catalog generation stylesheet. A more elegant solution would make better use of XSLT parameters, and, for example, eliminate the almost-identical “index-\*” templates in favor of a single “index” template that used a parameter to select the appropriate index. As with most of the other problems, this is the result of our compressed timeline for development. Fortunately, this is a relatively simple change, and can (and probably will) be changed for the next time we need to generate a print catalog.

Aside from issues of elegance, there are a number of other particularly problematic areas in the catalog generation system. Support for non-Roman scripts is non-existent. There are two issues contributing to this. The first is the lack of character set support. In principle, lambda (the LaTeX component of omega, a Unicode-enabled version of TeX) could be used with UTF-8 encoded input, but we did not try this, and omega seems to have been more-or-less orphaned. Another project, LuaTeX, offers a Unicode-compliant version of LaTeX, but they anticipate remaining in beta for the next three years. For right-to-left scripts, there are additional issues, as LaTeX treats right-to-left scripts differently than it treats left-to-right scripts. The second issue is that, as it currently stands, the system does no parsing of $6 (linkage) subfields and 880 (alternate graphic representation) fields. Most MARC records that include the original non-Roman script also include romanized representations of non-Roman scripts. These records store the non-Roman script in an 880 field and link it to the standard MARC fields with romanized data (e.g., 245) using subfield $6. The catalog generation system does not parse this in any way, and would only display the romanized representations.

The series index could also be improved. At the moment, the series index is generated by using every single series entry (all 4XXs and all 8XXs) in each record. This results in numerous almost-identical entries. Unfortunately, since the use of traced versus non-traced headings is inconsistent in cataloging copy (standards have changed repeatedly), we were unable to find an alternative way to deal with series entries. This problem affects non-printed catalogs too, as seen in a 2009 discussion of series headings on Jonathan Rochkind’s blog. \[[4](https://journal.code4lib.org/articles/#note4)\] An algorithmic method for dealing with the peculiarities of series entries could be of use to a great many system designers, but, unfortunately, we are unable to suggest any such method.

Another flaw in the catalog generation system is that it cannot handle any organization other than title main entry. Ideally, a general catalog generation system would offer the option to choose between title main entry and author main entry, depending on the project. Fortunately, the implementation of this need not be complex. Basically, all that would be needed is to have the two stylesheets sort on 1XX fields instead of 245 fields. In order to ensure that works with a title main entry were sorted properly, the preprocessor would need to be changed to copy the title from the 245 to a 1XX field when there is no 1xx field, but this would also be quite simple (see the code snippet from the preprocessor stylesheet, above, for an example of copying 246 fields into 245 fields for *see* references). The main challenge here would be creating a title index, which would need special formatting. Should anyone be interested in tackling this problem, we hope that they will contribute their modifications back to the community.

Despite these technical complaints, our project was a success. Not only did we generate a printable catalog, we developed a system that can generate a printed catalog out of any MARCXML file we might want to throw at it. We also learned about some of the difficulties that one encounters when creating a printed catalog and, for the most part, overcame those difficulties. If our code is not the most brilliant code in the world (and we would be the first to acknowledge that it isn’t), it does work. We hope that anyone looking to create a printed catalog will be able to extend our system to do better than we could do in our initial attempt at generating a printed catalog.

We have made our source code available to the public under the GNU General Public License version 3 (GPLv3) in our GitHub repository at [http://github.com/jcamins/cataloggen/](http://github.com/jcamins/cataloggen/).

## About the Author

Jared Camins-Esakov is a freelance bibliographer and former computer programmer, currently employed by the American Numismatic Society. Jared can be reached at [jcamins@gmail.com](https://journal.code4lib.org/articles/) or via his website at [http://www.jaredcamins.com/](http://www.jaredcamins.com/)

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Personal communication with Terry Belanger, 4/3/2009

\[[2](https://journal.code4lib.org/articles/#ref2)\] For example, at the time of writing, a catalog of the current exhibition is available:  
*Liberty & the American Revolution: Selections from the Collection of Sid Lapidus ’59: an exhibition catalogue* (Princeton: Princeton University Library, 2009). [(COinS)](https://journal.code4lib.org/coins) [http://www.worldcat.org/oclc/378505880](http://www.worldcat.org/oclc/378505880)

\[[3](https://journal.code4lib.org/articles/#ref3)\] [http://www.loc.gov/standards/marcxml/xslt/](http://www.loc.gov/standards/marcxml/xslt/)

\[[4](https://journal.code4lib.org/articles/#ref4)\] [http://bibwild.wordpress.com/2009/09/24/a-reasonable-display-for-series-data-in-marc/](http://bibwild.wordpress.com/2009/09/24/a-reasonable-display-for-series-data-in-marc/)
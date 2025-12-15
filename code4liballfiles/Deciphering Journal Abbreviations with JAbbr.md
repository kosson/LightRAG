---
title: "Deciphering Journal Abbreviations with JAbbr"
source: "https://journal.code4lib.org/articles/1758"
author:
  - "[[The Code4Lib Journal]]"
published: 2009-06-26
created: 2025-01-10
description: "JAbbr is an online tool developed at Cornell University to help users decipher journal title abbreviations. This article discusses why these abbreviations are so problematic, and how traditional tools are often insufficient, and then describes the novel approach used by JAbbr. Given an abbreviation, JAbbr creates a regular expression for fuzzy matching, tests it against [...]"
tags:
  - "clippings"
---
# Deciphering Journal Abbreviations with JAbbr
Keith Jenkins

JAbbr is an online tool developed at Cornell University to help users decipher journal title abbreviations. This article discusses why these abbreviations are so problematic, and how traditional tools are often insufficient, and then describes the novel approach used by JAbbr. Given an abbreviation, JAbbr creates a regular expression for fuzzy matching, tests it against a list of serial titles extracted from the library catalog, and returns a list of possible matches to the user. JAbbr is available as a web site and as a web service.

## Background

At Cornell University’s Mann Library, there is a species of question that inevitably finds its way to the reference desk: the journal title abbreviation. In order to find a cited article, one must first find the journal in which it appeared. For any given journal, there are several ways that its title might have been abbreviated in footnotes, bibliographies, and hand-written notes. It is often trivial to expand these abbreviations back to the full journal title, especially when the journal is well known. For example, most people would recognize “Natl. Geog.” as the popular National Geographic, and medical researchers would immediately recognize JAMA as the Journal of the American Medical Association. But researchers who are not already familiar with a particular title — maybe it’s a journal outside of their specialty — can have a difficult time deciphering the odd jumble of letters that comprise an abbreviation.

It can be tempting to guess at unfamiliar journal titles. For example, one might suppose that “Proc. Am. Soc. Psych. Res.” expands to “Proceedings of the American Society of Psychological Research“. However it may take some time and frustration to discover that the actual title uses the word “psychical” rather than “psychological”. Foreign languages present additional challenges. For example, “Rev. Biol.” could be a reference to the Portuguese-language Revista de Biologia, the Spanish-language Revista Biología (published in Cuba), or the French-language Revue de Biologie (published in Romania).

After helping a patron decrypt a journal abbreviation, the next question a reference librarian typically hears is “Why couldn’t they have just spelled out the whole title?” Indeed — why didn’t they? Saving space seems to be the primary motive for abbreviating titles. A century ago, the publishers of large multi-volume print indexes such as The Agricultural Index were trying to use less paper. Later, online databases were trying to reduce data storage costs, and speed up searches. The abbreviation habit continues today.

A good description of what an abbreviation tries to achieve is provided by Frank Rogers and Thelma Charen:

> The ideal journal title abbreviation is first of all brief; then it is clear, unique, informative as to the language of the original, indicative as to scope of the publication, easily remembered and used, and universally applicable. The actual must often fall considerably short of the ideal; the various elements are at war with each other \[[1](https://journal.code4lib.org/articles/#fn1)\].

Despite the inherent difficulties, several attempts at standardization have been made, including the Z39.5 American Standard for Periodical Title Abbreviations \[[2](https://journal.code4lib.org/articles/#fn2)\]; the ISO 4 International Code for the Abbreviation of Titles of Periodicals \[[3](https://journal.code4lib.org/articles/#fn3)\]; and the ISO 833 International List of Periodical Title Word Abbreviations \[[4](https://journal.code4lib.org/articles/#fn4)\]. Such standardization certainly provides guidance to those doing the abbreviating, but it doesn’t necessarily help those trying to interpret the abbreviations. As Rogers and Charen note, an abbreviation should be self-explanatory, but “it need not, however, be in a form which can serve as a base for verbatim reconstruction of the title” \[[1](https://journal.code4lib.org/articles/#fn1)\]. Furthermore, these abbreviation standards are routinely ignored, especially in the cases of acronyms and hand-written notes. There is no shortage of publications that refer to themselves by the decidedly non-unique name “CQ”: Caribbean Quarterly, Communication Quarterly, Concrete Quarterly, Congressional Quarterly, *ad infinitum*. And I know of no scholar who consults the relevant ISO standards when hastily jotting down the citation of an newly-discovered article.

Over the years, various lists of journal title abbreviations have been compiled. Mary Kinney \[[5](https://journal.code4lib.org/articles/#fn5)\] has noted that such compilations are more common in the scientific and technical fields, in which titles are abbreviated more often than in the social sciences and humanities. Kinney goes on to list numerous sources for the identification of abbreviated titles, helpfully organized by subject. Many of these sources can also be found in the library catalog by searching for the subject subdivision, “abbreviations of titles”. For a collection of online sources, there is Gerry McKiernan’s All that JAS: Journal Abbreviation Sources \[[6](https://journal.code4lib.org/articles/#fn6)\], which links to over one hundred separate abbreviation lists, organized by discipline. Such tools are useful, but the idea of sequentially searching several different sources to find one abbreviation is not an appealing one.

## JAbbr

In late 2004, having repeatedly encountered the journal abbreviation problem at the reference desk, I started thinking about a different approach to the problem of deciphering journal abbreviations. What patrons really seemed to want was a webpage where they could simply type in their perplexing journal abbreviation, click a button, and get the full title.

How might something like this work? Given an abbreviation input by the user, a program could iterate through a list of journal titles, apply some sort of fuzzy matching, and return a relatively short list of possible matches, from which the patron could select the best match. This would take the patron to the full catalog record for the item, where publication dates and volume numbers could be used to verify the title. Being unaware at the time of anything with a similar name, I decided to call the program “JAbbr”, which is, of course, an abbreviation for “Journal Abbreviations”. Below is a screenshot of the JAbbr website \[[7](https://journal.code4lib.org/articles/#fn7)\]:

![Screenshot of JAbbr](https://journal.code4lib.org/media/issue7/jenkins/jabbr_screenshot.png "Screenshot of JAbbr")  
**Screenshot of JAbbr**

The first step was to find a list of every journal ever published anywhere. Since that was clearly impossible, I settled for extracting all the serials records in the Cornell University Library catalog. This amounted to nearly 300,000 MARC records representing not just journals, but also proceedings and other serials whose titles might often be abbreviated.

Title information can be found in many different fields of the MARC record, including the 210 field, which is defined as the “Abbreviated Title”. (While this field sounds quite promising, not all serials records contain this field. And even when it is present, it doesn’t necessarily include every possible abbreviated form of the title.) The current version of JAbbr uses titles extracted from the following MARC fields:

- 210 “Abbreviated title” (subfield a)
- 245 “Title statement” (subfields a, b, n, p)
- 246 “Varying form of title” (subfield a)
- 247 “Former title” (subfield a)

The data from these fields has been extracted, normalized, and reorganized into a tab-delimited file structure that is more efficient for pattern-matching. Each record is represented on a separate line containing the main title (from the MARC 245) followed by various alternate, normalized titles that come from any subfields 245a, 210a, 246a, or 247a that are present in the MARC record. Thus, the pattern is:

```
Main Title [TAB] normalized 245a [TAB] normalized 210a [TAB] normalized 246a [TAB] etc.
```

The normalization function performs the following steps:

1. remove diacritics
2. replace periods, commas, semi-colons, exclamation points, slashes, and underscores with spaces
3. remove other non-alphanumeric characters
4. collapse multiple spaces and trim whitespace from the beginning and end
5. convert to lowercase

Multiple records for the same journal (for print, online, etc.) are merged whenever their main titles are identical. Thus the 300,000 MARC records (~352 MB) were reduced to about 240,000 lines (~27 MB) in the tab-delimited text file. The number of alternate titles that appear on each line varies depending on the number of title fields present in the original MARC records, as shown in the following example:

```
Journal of applied behavior analysis [TAB] journal of applied behavior analysis [TAB] j appl behav anal [TAB] jaba
Journal of applied biobehavioral research [TAB] journal of applied biobehavioral research [TAB] j appl biobehav res
Journal of applied biochemistry [TAB] journal of applied biochemistry
```

JAbbr takes the user’s input string, transforms it into a complex regular expression, and then tests it against each line of this tab-delimited file. If the pattern matches, then the title is displayed to the user. If the match occurs in an alternate title but not in the main title, then the matching alternate title is also displayed.

It took some experimentation to develop good regular expressions. When testing the effect of various adjustments, I found that relaxing the strictness of the match too much could easily result in a flood of false hits, and an overly complex expression could make the matching process intolerably slow. Acronyms needed to be recognized, even where multiple words in the title have been dropped, such as when Foreign agricultural trade of the United States is abbreviated as FATUS. And, although most words get abbreviated by having letters dropped from their ends, JAbbr also needed to account for cases such as “Natl” and “Engr”, where the final letter is retained.

A simplified version of the matching function, written in PHP, appears below. (Code can be requested from the author via the JAbbr website \[[7](https://journal.code4lib.org/articles/#fn7)\].)

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26 | `function` `findTitles(``$q``) {`  `$x` `= normalize(``$q``);`  `# ACRONYM?`  `if` `(preg_match(``"#^\w+$#"``, ``$x``, ``$m``)) {`  `$acronym` `= ``chop``(preg_replace(``"#(\w)#"``, ``"\b$1\S*( \w*){0,2} ?"``, ``$x``));`  `}`  `else` `$acronym` `= ``""``;`  `# LOOK FOR TERMS ONLY AT BEGINNING OF WORDS`  `$x` `= preg_replace(``"#(\b\w+)\s#"``, ``"$1[^\\t]* "``, ``$x``);`  `# BUT ACCOMMODATE natl, engr, boln, etc.`  `$x` `= preg_replace(``"#(\b\w+)(\w)\b#"``, ``"$1\w*$2"``, ``$x``);`  `$matches` `= ``array``();`  `foreach` `(file(``"jabbrdata.txt"``) ``as` `$line``) {`  `if` `( preg_match(``"#\t({$x}[^\t\n]*)#i"``, ``$line``, ``$m``)`  `\|\| ``$acronym` `&amp;&amp; preg_match(``"#\t({$acronym}[^\t\n]*)#i"``, ``$line``, ``$m``) ) {`  `$title` `= preg_replace(``"#\t.*$#"``, ``''``, ``$line``);`  `$matches``[] = ``array``(``'title'``=>``$title``, ``'altTitle'``=>``$m``[1]);`  `}`  `}`  `return` `$matches``;`  `}` |
| --- | --- | --- | --- |

As an example, let us assume that that the user has typed “j ap beh”. The `findTitles()` function manipulates the input string `$q` and assigns to `$x` the following regular expression:

```
\bj[^\t]* a\w*p[^\t]* be\w*h
```

The `foreach` loop tries to match this expression against each tab-delimited title in each line of the data file, and stores any matches in the `$match` array. In this particular example, the results contain five possible matches, including the likely titles Journal of Applied Behavioral Science and Journal of Applied Behavior Analysis.

## Improving JAbbr’s performance

If the user query looks like it might be an acronym (i.e., it has no spaces) then an additional regular expression `$acronym` is generated and tested as well. For example, a search for “JACS” assigns to `$acronym` the following regular expression:

```
\bj\S*( \w*){0,2} ?\ba\S*( \w*){0,2} ?\bc\S*( \w*){0,2} ?\bs\S*( \w*){0,2} ?
```

This regular expression allows for up to two words (such as “of the”) to go missing between each word that is actually represented in the acronym. Thus we can find such titles as Journal of the American Chemical Society, Journal of the American College of Surgeons, Journal of the Australian Ceramic Society, etc.

Testing complex regular expressions against every line in a 27 MB file can take several seconds to run. While this is obviously much faster than manually checking multiple print or online sources, an even shorter response time was desired. In order to make JAbbr faster, the tab-delimited text file was split into separate files for each letter of the alphabet. In this way, a query that begins with the letter “A” would only have to churn through the subset of data for journals that begin with that letter, effectively cutting down the average search time to about 1/26th of the original. As a result, most searches now retrieve results in a fraction of a second.

For particularly cantankerous abbreviations, the current version of JAbbr also has a “deep search” option that will look through all the titles, regardless of the initial letter. The deep search also allows for fuzzier matches (doubling the number of non-abbreviated words in acronyms, for example).

The method of constructing regular expressions has changed slightly over time, as JAbbr-stumping examples have been discovered and reported by reference staff. As result, a few special exceptions have been made, such as “jrnl” or “jrl” as abbreviations for “journal”, and “bks” for “books”. In these cases, implementing a more general change in the regular expressions resulted in far too many false hits. So instead, these specific abbreviations are handled before the rest of the regular expression is constructed. As more exceptional cases are encountered, they too can be written into the code.

One recent enhancement was to boost exact matches to the top of the results list. For example, a search for “PNAS” exactly matches an alternate title that comes from the MARC 210 field (“Abbreviated Title”). Recognizing this exact match, JAbbr places Proceedings of the National Academy of Sciences of the United States of America first in the results list. Note that, sometimes, there can be more than one “exact” match, as in the case of CQ mentioned earlier.

## JAbbr Web Service

Since its beginnings in 2004, the JAbbr website has featured a match-as-you-type capability, displaying matches even while the user is still typing. Initially, this was accomplished with hand-coded Javascript XMLHttpRequests and a local text-based web service, but the Javascript code for the JAbbr website was recently rewritten to use the jQuery Javascript library \[[8](https://journal.code4lib.org/articles/#fn8)\], which has greatly simplified the matter of fetching results from the server and updating the page. The website now uses jQuery.getJSON() to fetch matches from the JSON \[[9](https://journal.code4lib.org/articles/#fn9)\] web service available at `http://supportingcast.mannlib.cornell.edu/jabbr/json`.

Although designed specifically for use within the JAbbr website, which links results into the Cornell library catalog, the JSON web service provides a generic response that may be of benefit to other developers. The web service accepts the following querystring parameters:

| parameter | required? | description |
| --- | --- | --- |
| q | yes | the abbreviation to be deciphered |
| max | no | maximum number of results (defaults to 20) |
| deep | no | set to 1 for a deep search (defaults to 0) |

As an example, the request:

```
http://supportingcast.mannlib.cornell.edu/jabbr/json?q=javma
```

… returns the following JSON object:

```
{
  "q": "javma",
  "max": 20,
  "deep": 0,
  "count": 4,
  "matches": [
    {
      "altTitle": "javma",
      "exact": 1,
      "title": "Journal of the American Veterinary Medical Association"
    },
    {
      "altTitle": "journal of the american holistic veterinary medical association",
      "title": "Journal"
    },
    {
      "title": "Journal of Anhui Vocational College of Metallurgy and Technology"
    },
    {
      "title": "Journal of the Arab Veterinary Medical Association"
    }
  ]
}
```

The values of the `q`, `deep`, and `max` members simply echo the parameters that were requested, and `count` reports how many matching titles were found. The value of `count` may be greater than `max`, but no more than `max` matches will be returned. The value of the `matches` member is an array of objects. Every object in this array will contain a `title`, and some objects may also include `altTitle` or `exact` members: the `altTitle` is only included when it was used to make the match, and the presence of the `exact` member indicates an exact match, as described above.

Because JAbbr uses the Cornell library catalog as the source of its titles, it can currently only find matches when the titles are held by Cornell. Although Cornell does have extensive serial holdings, this is clearly a limitation, and it would be useful to augment the list of titles. Possible sources include existing serial titles lists and other library catalogs. (Any interested parties are invited to contact the author.)

## Conclusion

Inevitably, JAbbr does return some false hits. In fact, it almost always does. However, the goal is not to provide a single result that is guaranteed to be correct. Rather, JAbbr aims to provide a short list of titles that can be quickly scanned to find the title that the abbreviation most likely represents. Thus, it is not intended to be used for programmatically converting a list of cited abbreviations, but is designed to assist a human user to interpret a single abbreviation. Human intervention is required.

In January 2006, we added a “Journal Title Abbreviation” option to the main search page of our Voyager-based library catalog. When a user selected this option, the search would be diverted to a customized version of JAbbr that was disguised to look like a regular catalog page. Clicking a title linked back into the local catalog, with Voyager session information intact. In June 2009, WorldCat Local became our library’s official public catalog, so the results on the JAbbr website now link to a serials search within WorldCat.

We have been using JAbbr in the libraries of Cornell University for several years now, and it has repeatedly proved its usefulness. Over the past three years, we have seen an annual average of over 25,000 JAbbr searches originating from the library catalog. And back at the reference desk of Mann Library, which focuses on the life sciences, JAbbr has been especially helpful for tracking down obscure foreign journals and conference proceedings in the biological and agricultural sciences that otherwise could not be found.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Rogers, Frank B., and Thelma Charen. “Abbreviations for Medical Journal Titles”. Bulletin of the Medical Library Association 1962 July; 50(3): 311-352. [http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=197853](http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=197853)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Z39.5-1963. American Standard for Periodical Title Abbreviations. Approved November 20, 1963 by the American Standards Association.

\[[3](https://journal.code4lib.org/articles/#ref3)\] ISO 4-1972. Documentation: International Code for the Abbreviation of Titles of Periodicals. Switzerland: International Organization for Standardization.

\[[4](https://journal.code4lib.org/articles/#ref4)\] ISO 833-1974. Documentation: International list of periodical title word abbreviations. Switzerland: International Organization for Standardization. (This standard has since been withdrawn.)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Kinney, Mary R. The Abbreviated Citation: a Bibliographical Problem. ACRL Monograph No. 28. Chicago: American Library Association, 1967.

\[[6](https://journal.code4lib.org/articles/#ref6)\] *All That JAS: Journal Abbreviation Sources.* [http://www.abbreviations.com/jas.asp](http://www.abbreviations.com/jas.asp)

\[[7](https://journal.code4lib.org/articles/#ref7)\] JAbbr: Decipher your journal abbreviations. [http://supportingcast.mannlib.cornell.edu/jabbr/](http://supportingcast.mannlib.cornell.edu/jabbr/)

\[[8](https://journal.code4lib.org/articles/#ref8)\] jQuery: the “Write Less, Do More” Javascript Library. [http://jquery.com/](http://jquery.com/)

\[[9](https://journal.code4lib.org/articles/#ref9)\] JSON (JavaScript Object Notation). [http://json.org/](http://json.org/)

## About the Author

[Keith Jenkins](https://journal.code4lib.org/articles/) is currently the GIS/Geospatial Applications Librarian at Cornell University’s Albert R. Mann Library. He previously held the position of Metadata Librarian at the time he originally developed JAbbr.
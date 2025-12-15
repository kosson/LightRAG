---
title: "Relevance and Phrase Searching in Summon: looking under the hood"
source: "https://journal.code4lib.org/articles/8352"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-07-18
created: 2025-01-13
description: "This article briefly examines the mechanisms behind seemingly counter-intuitive phrase search results in Serials Solutions’ discovery platform Summon. The authors use the platform’s search API to explain why users sometimes encounter greater numbers of results when typically they would expect fewer. The article explores the reasons behind the search results and the implications for library [...]"
tags:
  - "clippings"
---
# Relevance and Phrase Searching in Summon: looking under the hood
Thomas Hodge, James RW MacDonald

This article briefly examines the mechanisms behind seemingly counter-intuitive phrase search results in Serials Solutions’ discovery platform Summon. The authors use the platform’s search API to explain why users sometimes encounter greater numbers of results when typically they would expect fewer. The article explores the reasons behind the search results and the implications for library instruction.

## Introduction

If you’ve done much teaching you may have encountered one of those embarrassing moments when you attempt to demonstrate a concept and the demonstration produces unexpected results. When this happens the seasoned teacher may turn this failure into a learning opportunity. What went wrong? What might explain the unexpected results? When the answers seem to contradict the principle the teacher was trying to deliver, confusion rather than understanding may be the result. This paper examines the behavior of phrase searching in Summon and how that may place librarians in one of these awkward teaching moments.

The American University of Sharjah Library (AUS) logged a call with Serial Solution’s Help Desk in February 2013. AUS’ Information Literacy Librarians had reported that Summon searches containing phrases sometimes produced inexplicable results. For example:

> students bullying test scores – retrieved 676 results  
> students bullying “test scores” – retrieved 1,361 results \[[1](https://journal.code4lib.org/articles/#note1)\]

The librarians expected that quoting the term “test scores” would reduce rather than increase the number of results. This is an expectation borne from past experience with databases, which is reflected in the way we have taught Boolean searching to our students. The number of results in a search should decrease as the search becomes more specific. We can illustrate this with a familiar Venn diagram, where items containing the phrase “test scores” and the terms “students” and “bullying” are a subset of the items containing all four terms:

![Figure 1](https://journal.code4lib.org/media/issue21/hodges/figure1.png)**Figure 1.**

When a more explicit search returns a larger result set librarians face an interesting instructional problem. The results are unexpected and the librarian may be hard pressed to explain why. Many librarians teach their students that when they are using a phrase search properly they should notice a reduction in the number of search results. With Summon this no longer appears to be true in all cases.

Using Serial Solutions’ Search API to analyze search results, this brief paper explains why phrase searching in Summon sometimes produces more results than a search for the same terms on their own. The approach to phrase searching Serial Solutions employs has implications for library instruction and more broadly on how to manipulate and interpret the results produced by a Summon search.

## Serials Solutions’ Response

Shortly after the support call to Serial Solutions we received this answer:

> … looking for the exact phrase, (in double quotes) will emphasize that phrase over “test scores” and will yield better results than a search for the same words without double quotes.  
> Note that even without the double quotes, verbatim word matches score higher than their non-verbatim matches. Adding double quotes increases the emphasis on the verbatim matches, as well as treating those words as a phrase.\[[2](https://journal.code4lib.org/articles/#note2)\]

This response from the Help Desk was accurate and contained the answer we eventually arrived at. However, as it represents a change in how phrase searching has generally been taught, it simply did not make sense to the librarians examining the issue.

The Help Desk also referenced Answer 1068 from the Support Center which added some context:

> Exact matches on words within a phrase search (with double quotes) get a higher relevancy boost over the same words in non-phrase searches (without double quotes). \[New June 2012\] \[[3](https://journal.code4lib.org/articles/#note3)\]

A follow-up call on March 6 produced more explication:

> I took a look at the later results of your examples (past page forty with fifty results per page) and by that point there seems little difference in the results for either search. I suspect the number of results then differs due to how the full text searching relevance is weighted. So for instance, it is very likely that those four terms would be found within a book, with each word hundreds of pages apart. In that case the result may not be returned at all since it would likely not be relevant. However, it may be more likely that “academic achievement” and one of the other terms are found on the same page, so then there would be more results. \[[4](https://journal.code4lib.org/articles/#note4)\]

This gave us a more concrete example to think about. When looking at the full text of an item, the fact that all of the words appear somewhere in the text does not mean it is a relevant result. We have probably all searched a full-text index in an ebook database and seen numerous results that are not actually relevant. Serial Solutions seems to have introduced a feature into their search to not only rank results by relevance but to retrieve by relevance, preventing not-really-relevant items from making it into the results set.

We still needed a better understanding of the mechanism behind the results. During an email exchange on the summon-clients list (“Counter-intuitive result counts for keyword/phrase searches”, 28 Feb 2013), one participant noted that:

> With the advent of databases/services like Google (and even Summon), we have arrived, for better or worse, in an age where, try as we might, we really don’t know what’s going on. We still enjoy telling ourselves that we do, but we don’t. And it’s OK. \[[5](https://journal.code4lib.org/articles/#note5)\]

This is a very useful insight, especially considering the secrecy that vendors must exercise to protect the intellectual property in their relevancy algorithms. However, this should not keep us from utilizing the tools at our disposal to understand all we can about what is happening behind the scenes. At the very least Information Literacy Librarians need to be able to teach how Summon searching differs from searching in our WebOPAC and other databases, how to evaluate the results, and what the quotes around a phrase will actually do for the searcher.

## Analysis with the Summon Search API

Fortunately, Summon offers a useful Search API that lets us reproduce the results from the client and examine them more closely. To this end we modified the script we have been developing for the API to display the relevance score for each item, and to fetch the full item record and display it. Applying an example from the above referenced email thread in our Summon instance, we found:

sheep dip flies retrieved 138 results  
“sheep dip” flies retrieved 155 results

![Figure 2](https://journal.code4lib.org/media/issue21/hodges/figure2.png)**Figure 2.**

We noticed in the search without quotes that the first item had a relevancy of 7.3483596 \[figure 2\], while in the search with quotes the top item had a relevancy score of 14.517519 \[figure 3\]. This suggests that quotes do indeed increase relevancy scores which is further confirmed by the fact that the item from the quoted search with the top score, (“Firms withdraw sheep dip products”), appears in the search without quotes with a score of only 1.5343612.

![Figure 3](https://journal.code4lib.org/media/issue21/hodges/figure3.png)**Figure 3.**

Looking at the end of the results set retrieved by the phrase search (**“sheep dip” flies**), we identified items from our collection like the *Australian Oxford dictionary* with a score of 0.06656703 \[figure 4\], and *Ashford’s dictionary of industrial chemicals* with a score of 0.024393521. However, when we searched for: **sheep dip flies** and title: *Australian Oxford Dictionary* we retrieved no results. Manually examining the results from the search without quotes confirms that this title (*Australian Oxford Dictionary*) does not appear. Looking at the actual Summon record we can see that the terms were (unsurprisingly) not present in the metadata, indicating that the phrase search result was probably coming from the full text.

![Figure 4](https://journal.code4lib.org/media/issue21/hodges/figure4.png)**Figure 4.**

Items present at the end of a results set tended to be ones that could plausibly contain the search terms. They also tended to be from our local collection (a factor which also boosts the relevance score). It seems this combination is raising the relevance score of these items enough to cause their inclusion in the set, thereby increasing the total number of items. While items that don’t contain the words as a phrase fall out of the set, more items come in than fall out.

## Observations / Conclusions

Utilizing Summon’s API we have demonstrated a plausible explanation for counter-intuitive results in phrase searching. We hope these findings will aid librarians as they teach this concept. As the algorithms controlling relevancy increase in complexity, librarians should do all they can to understand how those algorithms affect search results. Our investigations have led to at least three observations:

- We are used to thinking of relevance scores as something applied to items in a search set after retrieval not to determine whether they should be included in a results set in the first place.
- Serials Solutions’ strategy of excluding items that technically match the search but are not actually very relevant is probably better for producing useful results, but it is also harder to explain to users.
- After examining the relevant sources and doing some testing, it seems that the quote operator in Summon is being used for at least three things:
- specifying a set of terms as a phrase
- increasing the relevance of whatever is inside the quotes (including a single word)
- indicating that the exact term(s) in quotes is what is desired, rather than other forms of the word

Taken together, what we have is a “this is really important to me” operator. We found this interesting, as one of the Information Literacy Librarians pointed out that this is exactly what their students seemed to think that quotes around terms did in a query. Anecdotally, they have observed students consistently putting single terms in quotes while searching. This behavior seems to indicate that students do not have the same understanding of phrase searching as librarians. Summon’s current use of the quote operator seems to favor the students’ concept. For example, we note that the search: (“sheep” flies) returns more results than simply (sheep flies).

It is easy to conclude that a product is broken when we encounter an issue like the one described here. We hope that the analysis of this case will encourage librarians to consider alternate explanations and methods of analyzing which hypothesis is correct, and to focus on the relevant questions. Here the issue is whether Serials Solutions’ approach to phrase searching is delivering better results. If it is, the fact that the number of results increases is simply a new reality that we must incorporate into our instruction strategies.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] This search and the others used as examples were conducted with the filter option “exclude newspapers” set to true. Phrase searches are less likely to produce the counter-intuitive effect of a larger results set without excluding newspapers. We believe this is a result of the large numbers of newspaper articles being searched.

\[[2](https://journal.code4lib.org/articles/#ref2)\] AUS Call to Serial Solutions Help Desk : “Summon Operators” (02/21/2013), retrieved from [http://support.serialssolutions.com/app/account/questions/detail/i\_id/283944](http://support.serialssolutions.com/app/account/questions/detail/i_id/283944) (requires Serials Solutions Support Center login)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Help Center Document – “Summon: Boolean, Phrase, Wildcard and Proximity Searching” (Answer ID: 1068, Date Created: 15 Mar 2010, Date Updated: 03 Jul 2012) retrieved from: [http://support.serialssolutions.com/app/answers/detail/a\_id/1068#phrase\_searching](http://support.serialssolutions.com/app/answers/detail/a_id/1068#phrase_searching) (requires Serials Solutions Support Center login)

\[[4](https://journal.code4lib.org/articles/#ref4)\] AUS Call to Serial Solutions Help Desk : “Note from our Information Literacy Librarian (03/06/2013), retrieved from [http://support.serialssolutions.com/app/account/questions/detail/i\_id/287442](http://support.serialssolutions.com/app/account/questions/detail/i_id/287442) (requires Serials Solutions Support Center login)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Email Thread – \[summonclients\] Counter-intuitive result counts for keyword/phrase searches (02/28/2013). retrieved from [http://mail.lists.summon.serialssolutions.com/sympa/arc/summonclients/2013-02/msg00062.html](http://mail.lists.summon.serialssolutions.com/sympa/arc/summonclients/2013-02/msg00062.html) (requires list login)

## About the Authors

Thomas Hodge (thodge@aus.edu) is the Assistant University Librarian for Technology and Technical Services at the American University of Sharjah (AUS) in the United Arab Emirates. Thomas has been with AUS since 2007.

James RW MacDonald (jmacdonald@aus.edu) is the Web Services Librarian at the American University of Sharjah (AUS) in the United Arab Emirates. He has been with AUS since 2012. James’ research interests currently focus on usability and the user experience in digital environments.
---
title: "Building Bridges with Logs: Collaborative Conversations about Discovery across Library Departments"
source: "https://journal.code4lib.org/articles/11355"
author:
  - "[[The Code4Lib Journal]]"
published: 2016-04-25
created: 2025-01-10
description: "This article describes the use of discovery system search logs as a vehicle for encouraging constructive conversations across departments in an academic library. The project focused on bringing together systems and teaching librarians to evaluate the results of anonymized patron searches in order to improve communication across departments, as well as to identify opportunities for [...]"
tags:
  - "clippings"
---
# Building Bridges with Logs: Collaborative Conversations about Discovery across Library Departments
Jimmy Ghaphery, Emily Owens, Donna Coghill, Laura Gariepy, Megan Hodge, Thomas McNulty, Erin White\[[1](https://journal.code4lib.org/articles/#note1)\]

This article describes the use of discovery system search logs as a vehicle for encouraging constructive conversations across departments in an academic library. The project focused on bringing together systems and teaching librarians to evaluate the results of anonymized patron searches in order to improve communication across departments, as well as to identify opportunities for improvement to the discovery system itself.

The efficacy of library discovery tools can be a contentious topic within libraries, and the dissimilar experiences and attentions of technical librarians who support the system, and teaching librarians who use the system daily with patrons, can hinder communication between these two essential groups. At VCU Libraries in the fall of 2013, confidence in our discovery system, Ex Libris’ Primo, was low, especially amongst our teaching librarians. Even after ironing out some stability issues, there were lingering questions about the quality of the search results. Seeking ways to pinpoint search relevancy issues and enhance communication between teaching librarians and IT, a team of systems and teaching librarians agreed to jointly assess and discuss a random sample of actual search queries from Primo. This paper describes that process, compares the initial perceptions of relevancy between each group of librarians, and reflects on the success of both improving communication across departments and the library discovery system itself.

## Selected Literature Review

The topic of librarian attitudes toward library discovery systems has been an area of recent research, and certainly one of frequent mention on listservs and at conferences. In exploring teaching librarian attitudes toward discovery systems, Allen (2015) states that “librarians need to be comfortable with a resource in order to teach and advocate for it.” On the other side of the public/technical divide, Gayhart (2013) notes that user­centered library­wide staff communication is critical for the success of technology departments and the products they support and calls for library IT departments to “move from the traditional image of the gatekeeper of services, to a more inclusive image of a partner in success”. In his editorial about library discovery, Demlow (2013) sums up one of the key barriers to librarian adoption: “In part, discovery systems induce discomfort for library professionals because the ways in which relevance is calculated are becoming more opaque” (p. 3).

There is also substantial library literature surrounding discovery systems. Two recent articles on selection of discovery systems provide literature reviews that include history, selection, and evaluation (Deodata 2015, Ellero 2013). Ellero’s work is also noted for the evaluation method including “actual reference questions” (p. 324) that resulted in the library’s decision to not implement a discovery system. Asher, Duke, and Wilson (2012) noted that their study comparing various discovery systems with Google Scholar and other library databases was new ground beyond the previous literature on selection and individual usability studies of various systems. Ciccone and Vickery (2015) use a very similar methodology to our study in randomly selecting user queries from search logs to compare two library discovery systems and Google Scholar. Interestingly (and consistent with our findings), Google Scholar outperformed the discovery systems for topical searches.

Logs from systems have long provided rich data for understanding user behavior and thus offering direction for system improvement. Jansen (2006) provides a strong review of search log analysis history with a detailed literature review across various disciplines including libraries. More recently, Park and Lee (2013) investigate institutional repository interfaces through log analysis, and in doing so also provide a substantive literature review. Traditionally, however, logs have been the turf of systems staff and systems administrators (in many cases due to valid privacy concerns). This project pulled together systems librarians and teaching librarians as partners in sharing attitudes toward a sample of anonymized logs, with the goal of improving cross departmental communication against the backdrop of improving the discovery service. In reaching across a potential technical, non­technical divide this work leverages transaction logs in a novel manner as a discussion starter toward those goals.

## Background

VCU Libraries first fielded a discovery solution (Ex Libris’ Primo, with Aleph as the underlying ILS) as a “beta” service to patrons in October of 2011. By January 2012, discovery search became the primary option presented to users on the library homepage. We made the conscious decision to present users with a blended search of local holdings and articles, and not to offer “tabbed” searching options such as “catalog only.” In October of 2012, VCU Libraries became the third institution in North America to move to production with Ex libris’ Alma unified management system. At that time we introduced a new Primo instance which was fed by Alma.

Following this period of rapid change, we experienced a string of Primo stability issues in the fall of 2013. These issues included system slowness, incompleteness of results, and temporary outages. Our teaching librarians felt the brunt of these problems when the system was used heavily during library instruction sessions. Even after those issues were resolved, there were significant doubts about Primo, particularly among teaching librarians. Further, we no longer had the option of a traditional local catalog search since Alma does not have a public catalog and we were still pursuing a blended, single­-search philosophy. All of these factors put additional pressure on the discovery service to perform optimally. Systems and teaching librarians decided to collaborate on an evaluation project with the goals of comparing perceptions of system quality, increasing communication between departments, and identifying particularly egregious problems.

## The Project

To get the sample of queries, we pulled a report of all the searches that came from the Primo search logs during our library’s statistical “typical week” in October 2013. The searches were decoupled from any identifying information such as IP address. From those 68,579 queries, we used a Python script to filter and randomly select 200 search queries, and format the list of queries as a hyperlinked web document for easy review.\[[2](https://journal.code4lib.org/articles/#note2)\]

The first batch of randomly selected searches from the logs included few limits. After initial testing and meeting we identified areas for improving the selection. In particular we found that the sample included results that had been secondarily filtered by the user (facets, next page, etc), and were thus not a good gauge for measuring immediate search relevancy. In our subsequent evaluation processes, we limited the search logs to initial searches only: both advanced and simple searches were included, but only un­faceted, first pages. Based on the time it took to rank each search, we also agreed that 100 searches was a sample sufficient for our qualitative purposes of sharing perspectives on Primo’s relevancy.

For the test run we had also developed and agreed upon a scale for determining what might constitute a “relevant” result. The test scale was:

1. Very Poor (no relevant items, misleading results, known item not findable)
2. Below Average (few relevant items, known item buried)
3. Average (some relevant items? known item on first page or accessible from reasonable use of facets)
4. Above Average (topic search returned mostly relevant results, known item on top 5 results)
5. Excellent (topic search returned very relevant results? known item search retrieved item in top 2 results)

In our initial meeting, group discussion about how to define relevancy proved useful in and of itself. For the subsequent evaluation, we agreed to use a less prescriptive rating scale (Figure 1). While the scale was certainly open to interpretation, the previous definitions and collegial development of the scale gave us a reasonable agreed upon framework for future efforts at determining the search performance. We certainly found that defining relevancy for different user populations, based only on an anonymized search, is difficult. However, many of the searches spoke for themselves in terms of what any higher education user might hope to retrieve. This was true especially for known item searches, as well as searches with very focused parameters. In addition, our discussion of the pilot phase led us to include a “flag for followup” option to help highlight specific searches for either additional discussion or potential reporting to the vendor. By the spring of 2014, we were ready for each librarian to independently review the search results for each query.

#### Figure 1. Survey instrument

Please indicate how strongly you agree with the following statement: Primo produced relevant results for this search:

1 = Strongly Disagree  
2 = Disagree  
3 = Neither Agree nor Disagree  
4 = Agree  
5 = Strongly Agree

Flag for follow­up: Yes/No  
Comments (optional)

### Results

After the librarians had completed ranking of the search terms, we held a meeting to discuss the searches. Prior to the meeting, average ranking scores were released to the group. Interestingly, scores were generally close for all librarians, with a little more pessimism from the systems librarians. This in and of itself served as an initial team building acknowledgment that there was common ground across both groups.

| Individuals | Average of Result Relevancy Round 1 | Average of Result Relevancy Round 2 |
| --- | --- | --- |
| Systems Librarian #1 | 3.27 | 3.68 |
| Systems Librarian #2 | 3.56 | 4.23 |
| Systems Librarian #3 | 3.54 | 3.81 |
| Systems Librarian #4 | 3.94 | 3.64 |
| Teaching Librarian #1 | 3.77 | 3.91 |
| Teaching Librarian #2 | 3.66 | 4.06 |
| Teaching Librarian #3 | 3.86 |  |
| Outreach Liaison Librarian |  | 3.33 |
| Digitization Librarian |  | 3.63 |
| Average | 3.66 | 3.79 |
| **Departments** |  |  |
| Systems | 3.57 | 3.84 |
| Teaching | 3.76 | 3.96 |
| New Librarians (Outreach + Digitization) |  | 3.48 |
| **Search** **Type** |  |  |
| Known Item | 3.90 | 4.24 |

The resulting conversations about the searches themselves were even more fruitful. On an actionable level, some searches were forwarded to Ex Libris as examples of where search relevancy could be better. It was especially useful to start with real users’ searches for both groups to understand the typical use of the system, outside of each librarians’ domain (systems or teaching). Much like a usability test, this process centered the conversation on the user by way of searches themselves. A number of trends were identified including known item versus topic searches, usage of advanced search, problematic punctuation, misspellings, and ambiguous searches.

A year later in the spring and summer of 2015, the same survey was completed again with the same search terms. There are inherent scientific problems with such repetition due to librarians remembering previous searches, librarians being influenced by past ranking or discussion, and the potential that the vendor could have fixed previously reported problems. Further, it is important to note that the systems department initiated other outreach within the library during this period including regular staff blog postings, an aggressive patching schedule for Primo to take advantage of new releases, and a monthly open staff meeting to discuss Web and Discovery issues. Nonetheless, the repetition of search rankings served as a good closure to the project. We were indeed curious to get a sense of how the search tool (or our attitudes) may have changed given the passage of time and a number of Primo upgrades which focused on search relevancy and known item retrieval. We decided to open the second round up to all library faculty in order to broaden the potential discussion. All four of the original systems librarians, two of the original three teaching librarians, and two new librarians (one outreach liaison librarian and one digitization librarian) completed the second round of testing.

For this round, summary results were not shared before discussion. Anticipating a larger group, one of the systems librarian pulled out a number of searches as a basis for suggested discussion. This set included queries that had garnered many comments or large variations in ratings between librarians. In general, librarians returning to the results a year later did not feel that previous rankings had a big impact on their scores. By and large, the perception was that performance of the discovery tool was better.

The average of all scores was slightly higher (3.79 in 2015 vs. 3.6 in 2014), and likewise both of the repeating group averages were higher in the second round (Teaching Librarians went from 3.7 to 3.96 and Systems Librarians from 3.53 to 3.84). The two new librarians to the project recorded the lowest average score (3.48). Acknowledging all of the validity flaws, the comparisons must be made with a very forgiving brush. Nonetheless, there does seem to be more agreement amongst the various librarians with results clustered close to each other in a consistent range of mid to upper 3’s.

In the second round we analyzed the data further and found that overall confidence in the quality of the results was significantly higher for searches that were identified as known item searches (4.24 as opposed to the overall average of 3.79). This was also consistent with qualitative impressions from the discussion sessions where a number of librarians in the repeating group remarked that results for known item searches seemed more relevant in the second round. A common theme in both sets of discussions was the comparison of topic relevance with results from Google Scholar. Even though it was not part of the agreed­ upon procedure, several librarians (both teaching and systems) reported trying the same searches not only in our implementation of Primo, but also other institutions’ discovery platforms, and Google Scholar. In all cases, the feeling was that Google Scholar outperformed vendor discovery systems for topic searches. This points to the challenges and expectations that discovery services must meet in satisfying known item and topic searches (and being able to tell the difference between the two).

## Qualitative Librarian Comments

When asked “What would you like to share in this article about the project?” the librarian participants added the following comments.

### Systems Department Head. Search Rounds 1 and 2.

I very much value the time from all of the participants and the productive conversations that resulted from the project. I am especially interested in how focused some of our discussions were that illuminated some of the unique challenges that library discovery services can have. While we did some benchmarking against Google and Google Scholar, I think that we all came away with a more nuanced appreciation for library discovery and increased respect for each other’s opinions.

### Teaching and Learning Department Head. Search Rounds 1 and 2.

This was about as ideal a collaborative improvement process as I could imagine. Not only did it result in improvements to our local implementation of Primo (and based on some of our feedback, perhaps improvement of the product at large), but it also created a sense of shared understanding and concern for how we might continue to work together to improve our enterprise systems. Prior to the project, I thought quite wrongly, as it turns out that our systems librarians and teaching librarians had very different perspectives on Primo’s overall performance. Despite their continual support and collegiality, I thought that the teaching librarians may have been a bit of a holy terror to our systems colleagues with our concerns about Primo. Turns out, we were on the same page. I suspect this is true more often than not, and I’m grateful for the the opportunity to have deepened our collaborative relationship.

### Integrated Systems Librarian. Search Rounds 1 and 2.

I was happy to be included in a project that was beneficial in many different areas. In systems we tend to only hear from our colleagues in other departments when there is something wrong. Working together on this project to not only find what we all thought could be improved in the system but also finding what was working well was refreshing. While everyone brought different perspectives to the table it was good to see that in the final analysis our opinions were very similar. It was also a positive outcome that we could provide real and meaningful feedback to our vendor in the hopes of improving the discovery product for everyone. I think this project helped reinforce the idea that we are all on the same team and though we approach the issues from different perspectives we share the same desired outcome ­ the best discovery service possible for our users.

### Teaching & Learning Librarian. Search Round 1.

Siloed as different departments often are in large libraries, this exercise was valuable not just because it offered a glimpse into patrons’ real­life searching habits, but because of the interdepartmental relationship building aspect. As a new librarian I’d only been employed by VCU Libraries for 6 months at the project’s start it was especially useful.

I can see this exercise being replicated for myriad purposes? I would be especially interested to see how patrons’ search behavior changes over time based on future improvements to our discovery service and teaching practices.

### Systems Librarian. Search Rounds 1 and 2.

It was extremely valuable to see how the system behaved in response to actual user queries. As a systems librarian, most of my experience evaluating discovery has been based on my own use and the reports of my librarian colleagues (which are usually prompted by problems). How librarians use the discovery system often differs from how our patrons use it, and because I don’t do instruction or reference, this exercise provided a much needed education in current patron search behavior. I was reminded of the value provided by certain discovery features, such as “did you mean” suggestions and misspelling corrections, as well as the frequency and effectiveness of different categories of query, beyond the narrow topic or known item searches: it was enlightening to see how the system responded to broad search terms (“sociology”), known items not in our collections, and copy­pasted citations alike.

### Web Systems Librarian. Rounds 1 and 2.

I’ve been interested in the dynamic between “traditional librarians” and IT since graduate school and have found this project exceedingly helpful in opening up lines of communication between two functional areas in our library, not only around these relevancy assessments but in general. The bigger benefit of this project was that everybody seemed to gain an understanding of our shared goals and priorities while grappling with software questions that sometimes not even the systems librarians could answer. The de­centering of IT as “all knowing” really helped here.

Though we systems folks are not incompetent, we often don’t have answers or solutions right away, or even know there are problems with systems we manage until we can see them through users’ eyes, and this insight is often being conveyed to us through teaching librarians.

We all gained valuable insight from seeing actual users’ queries and understanding how our system is used? that can inform our future work in systems and in teaching scenarios with library users.

### Teaching & Learning Librarian. Search Rounds 1 and 2.

Systems librarians and teaching librarians don’t often get to work together as directly as we did on this project. The obvious benefit of such a collaboration is the shared goal of analyzing and improving our searches in Primo. Though we came at the search results with differing knowledge bases, we found a useful middle ground and language that, in the end, resulted in an ideal collaborative project.

## Conclusion

While we by no means claim to have solved discovery, we are pleased to report a number of successful outcomes. Even with such a small random sample, we were able to identify a number of problematic searches to bring to our vendor’s attention. Likewise, this effort has encouraged ongoing local development of add­on JavaScript improvements to offer search suggestions. Culturally, the project itself helped us move beyond a systems and teaching librarian dialectic in addressing our discovery tool. The resulting discussions helped raise sensitivity across both groups toward the challenges of discovery by placing *genuine user* *queries* at the conversation’s center. As a group we left the project with a sense of progress and a desire to see our discovery tool further improve. Cultivating this type of collegiality, shared responsibility, and high expectations across the profession is key to future improvements across all of our systems and services. The use of anonymized logs as a focal point for discussion proved successful for us in both building partnerships across technical and non­technical departments and improving system usability.

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Coghill, Gariepy, Hodge, McNulty, and White listed in alphabetical order.

\[[2](https://journal.code4lib.org/articles/#ref2)\] A potential pitfall for discovery system log analysis is the introduction of auto­suggested searches. In essence, the search terms pulled in 2013 are somewhat special in that we had not yet introduced an auto­suggest feature. For future projects, we would need to manually check to try to determine if searches were influenced by autosuggest. Utility and use of autosuggest in general seems like a rewarding research area for the future.

## References

Allen ND. 2015. Utilizing discovery tools for classrooms: how do librarian attitudes on discovery impact tools they teach? Library Hi Tech News \[Internet\]. \[cited 13 Oct 2015\]?32(1):8­12. Available from: [http://dx.doi.org/10.1108/LHTN­09­2014­0078](http://dx.doi.org/10.1108/LHTN%C2%AD09%C2%AD2014%C2%AD0078)

Asher AA, Duke Ll, Wilson SS. 2013. Paths of discovery: comparing the search effectiveness of EBSCO Discovery Service, Summon, Google Scholar, and conventional library resources. Coll & Res Libraries. 74(5):464­488.

Carson P, Little G. 2014. Re­framing Librarians’ Identities and Assumptions around IT. J Library Adm. 40(3­4):405­407.

Ciccone K, Vickery J. 2015. Summon, EBSCO Discovery Service, and Google Scholar: a comparison of search performance using user queries. Evid Based Library and Inf Practice \[Internet\]. \[cited 13 Oct 2015\]?10(1):34­49. Available from: [http://ejournals.library.ualberta.ca/index.php/EBLIP/article/view/23845](http://ejournals.library.ualberta.ca/index.php/EBLIP/article/view/23845)

Dehmlow M. 2013. Editorial Board thoughts: services and user context in the era of webscale discovery. Inf Technology and Libraries. 32(2):1­3.

Deodato JJ. 2015. Evaluating web­scale discovery: a step by step guide. Inf Technology & Libraries. 34(2):19­75.

Ellero NN. 2013. An unexpected discovery: one library’s experience with web­scale discovery service (WSDS) evaluation and assessment. J Library Adm. 53(5/6):323­343.

Gayhart L. 2013. Out from behind the firewall: towards better library IT communications. Code4Lib J \[Internet\]. \[cited 13 Oct 2015\]?21:8 pages. Available from: [http://journal.code4lib.org/articles/8741](https://journal.code4lib.org/articles/8741)

Jansen BJ. 2006. Search log analysis: what it is, what’s been done, how to do it. Library & Information Science Research \[Internet\]. \[cited 13 Oct 2015\]?28(3):407­432. Available from: [http://faculty.ist.psu.edu/jjansen/academic/pubs/jansen\_search\_log\_analysis.pdf](http://faculty.ist.psu.edu/jjansen/academic/pubs/jansen_search_log_analysis.pdf)

Park M, Lee T. 2013. Understanding science and technology information users through transaction log analysis. Library Hi Tech \[Internet\]. \[cited 13 Oct 2015\]?31(1):123­140. Available from: [http://dx.doi.org/10.1108/07378831311303976](http://dx.doi.org/10.1108/07378831311303976)
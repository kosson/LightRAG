---
title: "Barriers to Initiation of Open Source Software Projects in Libraries"
source: "https://journal.code4lib.org/articles/10665"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-07-15
created: 2025-01-10
description: "Libraries share a number of core values with the Open Source Software (OSS) movement, suggesting there should be a natural tendency toward library participation in OSS projects. However Dale Askey’s 2008 Code4Lib column entitled “We Love Open Source Software. No, You Can’t Have Our Code,” claims that while libraries are strong proponents of OSS, they [...]"
tags:
  - "clippings"
---
# Barriers to Initiation of Open Source Software Projects in Libraries
Curtis Thacker, Charles Knutson

Libraries share a number of core values with the Open Source Software (OSS) movement, suggesting there should be a natural tendency toward library participation in OSS projects. However Dale Askey’s 2008 Code4Lib column entitled “We Love Open Source Software. No, You Can’t Have Our Code,” claims that while libraries are strong proponents of OSS, they are unlikely to actually contribute to OSS projects. He identifies, but does not empirically substantiate, six barriers that he believes contribute to this apparent inconsistency. In this study we empirically investigate not only Askey’s central claim but also the six barriers he proposes. In contrast to Askey’s assertion, we find that initiation of and contribution to OSS projects are, in fact, common practices in libraries. However, we also find that these practices are far from ubiquitous; as Askey suggests, many libraries do have opportunities to initiate OSS projects, but choose not to do so. Further, we find support for only four of Askey’s six OSS barriers. Thus, our results confirm many, but not all, of Askey’s assertions.

## Motivation

The mission statement of the American Library Association includes the charge to “ensure access to information for all.”\[[1](https://journal.code4lib.org/articles/#ref1)\] This charge comes without restriction, cost or qualification. Stated another way, libraries make information freely available to all, regardless of how that information is to be used. Similarly, open source software (OSS) “licenses must permit non-exclusive commercial exploitation of the licensed work, must make available the work’s source code, and must permit the creation of derivative works from the work itself” (Laurent 2004). The core values of libraries and the OSS movement are similar, suggesting that libraries should tend to favor the OSS model. In particular, they might feel a responsibility to share the code they have developed with other libraries in a spirit of openness and access for all.

That libraries are predisposed to OSS adoption and contribution is not a new idea. Pat Eyler, an open source developer for the Koha ILS project, said “That more librarians aren’t actively using and evangelizing free software is an indictment against us for not letting them in on our secret” (Eyler, 2003). Nicole Engard characterized the issue this way: “It has been suggested that libraries are almost ethically required to use, develop and support open source software” (Engard, 2010).

Richard Stallman, the pioneering free software evangelist, stated that “… universities shouldn’t be developing proprietary software. It is better if they develop none at all, because \[by doing so\] they are betraying their mission to contribute to human knowledge” (Anderson, 2008).

Despite the suggestion that libraries are ethically obligated to use and create OSS, it has been observed that libraries seem reluctant to share their code. In 2008 Dale Askey authored a column in this journal entitled “We Love Open Source Software. No, You Can’t Have Our Code.” He states that “Librarians are among the strongest proponents of open source software. Paradoxically, libraries are also among the least likely to actively contribute their code to open source projects” (Askey 2008). Askey identified a list of six issues he believes contribute to this dichotomy. In his own words:

> After pondering this issue for some time, I identified the following issues as the driving forces that undermine the sharing of open source software in libraries:
> 
> - perfectionism – unless the code is perfect, we don’t want anyone to see it
> - dependency – if we share this with you, you will never leave us alone
> - quirkiness – we’d gladly share, but we can’t since we’re so weird
> - redundancy – we think your project is neat, but we can do better
> - competitiveness – we want to be the acknowledged leader
> - misunderstanding – a fundamental inability to understand how an open source community works
> 
> Many of these issues operate in combination, but any one of them is sufficient to thwart the development and adoption of open source software in libraries.

In this paper, we report on our empirical investigation into Askey’s central claim. We examine the six barriers he proposes in light of our empirical results.

## Methods

The Association of Research Libraries (ARL) “is a nonprofit membership organization of 125 research libraries in North America. The Association operates as a forum for the exchange of ideas and as an agent for collective action.” Each year ARL distributes and publishes a small number of surveys, called SPEC Kits, that are proposed and designed by librarians and other interested parties.

In February 2014, ARL distributed a 32-question survey authored by Curtis Thacker, Charles Knutson, and Mark Dehmlow, to 125 member libraries. Seventy-seven libraries (61%) responded to the survey, the results of which were subsequently published as *SPEC Kit 340: Open Source Software* (Thacker et al. 2014) (hereafter referred to as “the SPEC survey”).

The purpose of the SPEC survey was to study ARL member libraries’ adoption and/or development of OSS for the primary functions carried out in libraries. We aimed to understand organizational factors that affect decisions to adopt OSS. With regard to development of OSS, we studied: 1) research libraries’ policies and practices on open sourcing their code; 2) the frequency of research library contributions to open source projects; 3) the reluctance of research libraries to make their code openly available; and 4) the most common benefits and challenges encountered when research libraries open source their code.

Questions were reviewed, evaluated and refined by empirical software engineering researchers from the SEQuOIA \[[2](https://journal.code4lib.org/articles/#ref2)\] Lab in the Brigham Young University Computer Science Department. This exercise enabled us to deepen our understanding of issues related to open source software development by applying the growing body of work in the area of empirical software engineering. The creation of the survey instrument followed best practices for empirical software engineering surveys (Kitchenham and Pfleeger 2008).

Questions were crafted to empirically test several of the issues laid out in Askey’s column. In particular, the following question provided respondents with an opportunity to identify reasons for not openly releasing software they had developed:

![](https://journal.code4lib.org/media/issue29/thacker/Thacker_1.png)

Example SPEC Kit question

The table below illustrates the relationship between the options presented in the question and the issues presented by Askey. The first column identifies each issue as presented in the survey, while the second column presents the issues as stated by Askey. Two of the issues offered by Askey were not tested because they fell outside the scope of the SPEC survey. Two other issues were added in an attempt to validate additional reasons for which an institution might choose not to open source their code. Of these two issues, the second one (“seeking to license or sell the system”) was inspired by a response\[[3](https://journal.code4lib.org/articles/#ref3)\] made to Askey’s column.

![Reasons for non-participation in OSS as presented in the survey](https://journal.code4lib.org/media/issue29/thacker/Thacker_2.png)  
Survey results were reviewed and statistically analyzed. Free response questions were encoded and qualitatively analyzed for themes and best practices. The executive summary of the SPEC survey includes an overview of statistical results that spans the entire survey (Thacker et al. 2014). A specific set of results relevant to this paper are presented and discussed in the sections below.ARL reviewed and administered the survey. Participants were given four weeks to respond and ARL sent two email reminders as the deadline approached. A spreadsheet of the complete response data was returned to the authors for analysis and preparation for publication.

## OSS Adoption

Askey’s initial premise is that libraries love OSS. He cites Dan Chudnov (Chudnov 2007) who asserts that infrastructure software and programming languages are widely adopted by libraries. Operating systems such a Linux, web servers such as Apache, and programming languages such a Ruby and Java are examples of OSS systems commonly adopted by libraries. These applications compete with commercial applications for market share and often hold the largest slice of the pie. Askey also pointed out that OSS adoption is ubiquitous for other common types of software applications such as web browsers (such as Mozilla) and mail clients (such as Thunderbird). Market share statistics for Linux\[[4](https://journal.code4lib.org/articles/#ref4)\], Apache\[[5](https://journal.code4lib.org/articles/#ref5)\] and Mozilla\[[6](https://journal.code4lib.org/articles/#ref1)\] substantiate these claims.

The SPEC survey found that 74 respondents (97%) had deployed open source software in their libraries, suggesting that, at least for ARL Libraries, adoption of OSS is essentially ubiquitous. This data strongly supports Askey’s claim that libraries love OSS. We also wanted to understand the specific types of OSS that are loved by libraries.

Askey asserts that libraries have “strongly embraced…object repositories such as DSpace and Fedora and content management systems such as Drupal.” SPEC survey respondents were invited to provide information about the type of software being used for various purposes. Respondents most frequently reported choosing OSS solutions for institutional repositories (52 total), blogging (51 total) and digital preservation (50 total). See the table below for more details on how respondents have adopted OSS within their institutions.

![OSS Adoption Results Table](https://journal.code4lib.org/media/issue29/thacker/Thacker_3.png)  
The SPEC survey revealed compelling evidence for the widespread adoption of library specific software, even beyond Askey’s claims.The SPEC survey confirmed Askey’s sense that DSpace and Fedora were “strongly embraced” by libraries. Sixty-six respondents reported the OSS projects they had adopted. We found that the most commonly adopted open source systems were DSpace (31 respondents, 47%\[[7](https://journal.code4lib.org/articles/#ref7)\]), Fedora (21 respondents, 32%), Open Journal System (19 respondents, 29%), Blacklight (14 respondents, 21%), Hydra (12 respondents, 18%), Vufind (8 respondents, 12%), ArchivesSpace (7 respondents, 11%) and Archivists’ Toolkit (6 respondents, 9%).

Respondents were further asked to describe three benefits and three challenges associated with adopting OSS. The most commonly reported benefit was the ability to customize the software (50 responses). Other common themes included low cost or time to implement (27 responses) and association with an active community (27 responses). The most common challenge was the need for highly skilled staff that could provide support for the OSS system (40 responses). Other commonly cited challenges included poor documentation (19 responses), a need for additional training or expertise (16 responses), and substandard development practices (12 responses).

## OSS Contribution

Askey shares his perception that libraries are reluctant to initiate and/or contribute to OSS projects, despite their nearly universal enthusiasm for adoption. Askey’s main claim is: “where we tend to fall flat is in the area of creating, maintaining, and sharing library-specific applications. There are certainly myriad exceptions to this statement, but I would suggest that however large and noteworthy, they remain the exceptions, and not the rule” (Askey 2008). While Askey’s statement mainly addresses initiation of OSS projects, maintaining library-specific applications could be interpreted as contribution to OSS projects.

Askey’s column focused primarily on contributions to OSS projects in the form of source code. Beyond software, OSS projects benefit from many types of contributions including, money, hosting, testing, etc. The table below shows the types of contributions that libraries have made to OSS projects.\[[8](https://journal.code4lib.org/articles/#ref8)\]

![OSS Contribution Response Summary](https://journal.code4lib.org/media/issue29/thacker/Thacker_4.png)  
The SPEC survey found that 56 respondents (78%) had contributed to one or more open source projects; of these, 50 respondents indicated which projects they had contributed to. The most common projects included DSpace (12 respondents, 24%\[[9](https://journal.code4lib.org/articles/#ref9)\]), Fedora (11 respondents, 22%), Hydra (9 respondents, 18%), Kuali (6 respondents, 12%), Blacklight (5 respondents, 10%) and ArchivesSpace (4 respondents, 8%). The SPEC survey found that respondents had contributed to an average of 2.6 OSS projects and a median of 1 OSS project. These findings support Askey’s claim that contribution to OSS by libraries is common, yet far from universal.

## OSS Initiation

Askey addressed initiation of OSS when he claimed that “where we tend to fall flat is in the area of creating, maintaining, and sharing library-specific applications. There are certainly myriad exceptions to this statement, but I would suggest that however large and noteworthy, they remain the exceptions, and not the rule” (Askey 2008).

Thirty-two (42%) respondents identified themselves as the original developer of an open source project. Respondents initiated an average of 1.4 OSS projects and a median of zero OSS projects. Thus we see that while a number of institutions have some experience initiating OSS projects, initiation is far from the norm. Our finding supports Askey’s claim.

Respondents were asked if any of their in-house software could have been, but had not yet been, released under an open source license. Fifty-three respondents (69%) answered in the affirmative. Additionally, the SPEC survey revealed libraries that always choose to share their sharable projects, and, conversely, there are libraries that could share but have thus far not chosen to share their code. The table below breaks down these responses in greater detail.

![Position on OSS Project Initiation](https://journal.code4lib.org/media/issue29/thacker/Thacker_5.png)

### Perfectionism

Respondents cited all of Askey’s barriers as reasons for not open sourcing a sharable system. We address each of these issues in the sections below.

Thirty-nine (74%) of those who chose not to open source their code cited “concerns that the code quality is not ready for public adoption.” The perception that the code quality is not acceptable, and therefore cannot be shared, is very common.

This particular question in the SPEC survey was only able to test perceptions of libraries. As pointed out by Askey, intrinsic to the open source philosophy is the idea that the community will improve upon an initial system. Linus’ Law, as described by Raymond (1999), describes OSS communities this way: “given enough eyeballs, all bugs are shallow”, or more formally: “Given a large enough beta-tester and co-developer base, almost every problem will be characterized quickly and the fix will be obvious to someone.” It follows from Linus’ Law that not sharing code due to quality issues is more a matter of pride than practicality.

### Dependency

“Nothing is more certain in the world than this: if you share software with someone, you will be asked to support it, even if you make it perfectly clear that you have no ability and no intention to do so” (Askey 2008). Forty-one respondents (77%) cited “staff time commitment required to support the community” as a reason for not open sourcing a product that could have otherwise been shared. The SPEC survey offers strong evidence that the perception of dependency is a common barrier among ARL members.

### Quirkiness

Quirkiness is defined by Askey as “the sense that one organization’s needs are so locally-tailored that \[it\] would make no sense to release the software to the broader library community.” Later in the same section he cites an example of quirkiness as dependence on “idiosyncratic local metadata scheme.” The SPEC survey addresses quirkiness in three ways. First, 30 respondents (57%) cited “dependence on internal systems” as a reason for not open sourcing a system that could have otherwise been open sourced. Second, 7 respondents (13%) stated “it didn’t occur to us” as a reason for not open sourcing their software. Third, the issue of quirkiness was directly addressed by respondents who entered free form responses describing reasons they chose not to open source a system. Responses included: “Highly customized to address local requirements”; “Narrow niche applications where a community is unlikely to develop”; and “Often these systems reflect local practices. We’ve not viewed them as useful beyond our local environment.” These data are evidence of quirkiness among ARL members and support Askey’s claims.

### Redundancy

Redundancy, as described by Askey, “is when there is perfectly acceptable software available and yet is rejected because it’s not quite what one would have done had they created the software.” We found that this issue relates more to adoption than initiation of OSS. As a consequence, we did not study this issue in detail.

### Competitiveness

Askey explains that libraries tend to implement their own systems (e.g., institutional repository, digital libraries, and web services) because they “want to be the acknowledged leader.” While one respondent of the SPEC survey indicated “a competitive desire to have the best system” as a reason for not open sourcing their software, no other respondent cited such motivation. As a result, while we find some support for Askey’s claim, competitiveness does not appear to be widespread.

### Misunderstanding

Askey describes misunderstanding as “a fundamental inability to understand how an open source community works.” We determined that  “misunderstanding” primarily suggested that respondents did not understand the benefits of involvement with an OSS community. This issue represents a catch-all of sorts that encompasses the other issues we’ve discussed. The breadth of “misunderstanding” prevented us from testing this issue in the same manner as the other issues presented above. Other questions in the survey do, however, offer insights into the benefits libraries currently enjoy as a result of adoption of and contribution to library-specific OSS projects. We highlight some of these insights below.

Respondents were asked to describe three benefits and three challenges associated with contribution to OSS. The benefit most commonly cited was engagement in the open source community (38 responses). Other common themes included control of product features and direction (25 responses), and recognition/reputation (14 responses). The most common challenge was allocating sufficient staff time to make meaningful contributions (24 responses). Other commonly cited challenges included writing generalized software for use by a larger community (7 responses) and securing the financial resources needed to support the open source project and community (7 responses).

Control of software emerged as a theme common to both adoption and contribution. Those adopting OSS products felt that access to source code gave them greater control, allowing them to change the software as needed, rather than being subject to the whims of a proprietary solution. Those libraries contributing to OSS projects felt that they gained greater opportunity to influence product direction, especially with respect to software features. In both cases, library information technology organizations perceived a sufficient benefit to their overall productivity to justify the expense of their involvement (as adopters, contributors, or both) in OSS systems.

When asked about reasons for open sourcing their project, SPEC survey respondents listed the following as being “important” or “very important”: a belief that open sourcing would lead to better software (30 respondents), a desire to contribute to an open source community (29 respondents), and shared effort in development and quality assurance of the project (27 respondents). The experiences shared by respondents who initiated an open source system support the idea that one way to inject quality into a system is to open source it. In contrast to Askey’s claim, there were many respondents who demonstrated an understanding of this benefit of open sourcing their code. Additionally, of the 54 respondents who have a system they chose not to release as open source, 24 (44%) have initiated at least one open source project. Further research is required to understand the motivation of these ARLs decision to share one system but not another.

Many respondents expressed a desire on the part of their developers to share with and participate in one or more OSS communities. Larger LIT organizations committed more resources to OSS projects than smaller LIT organizations, but we found no significant correlations suggesting a disproportionate level of commitment to OSS projects as a function of LIT staff size. The nearly universal adoption of OSS systems and the high level of contribution to OSS projects may suggest that adoption of and contribution to OSS projects has entered the mainstream for LIT organizations. Simply stated, LIT organizations that develop software have also generally contributed to one or more OSS projects.

## Additional Insights

In the final section of his column Askey makes several suggestions on what should be done to overcome the issues he discusses. We address a few of these suggestions in this section.

In 2008 Askey claimed that there was no standard way of distributing library specific code, suggesting that a single place should be agreed upon as the established method for sharing code. GitHub has emerged as the preferred method for many open source projects (including libraries) to share their code. GitHub accommodates large OSS projects such as Fedora, DSpace, Hydra and others as well as supporting what Askey calls OSS lite\[[10](https://journal.code4lib.org/articles/#ref10)\]. Forty-one SPEC survey respondents indicated that they use a public forge to manage and share their open source projects. Thirty-eight of these use GitHub for this purpose. While making use of an open source forge, such as GitHub, to share code is effective, it is unclear whether this tool has impacted the propensity of libraries to initiate an OSS project.

Askey states that “libraries that wish to use open source software need to understand the staffing commitment they are making by going that route. Open source software requires programmers, interface designers, and system administrators.” In our review of organizations that contribute to open source projects, software development staff ranged from one or two to as many as fourteen.  While organizations that contribute to large-scale, formal open source projects were clearly investing heavily in programming staff, it was also clear that a few organizations that didn’t have resources for large technology staffs could still contribute to projects with as few as one or two programmers.  The median number of staff reported as working on OSS projects was two, with an average of nearly four.

The results of the SPEC survey suggest that we view organizational behaviors surrounding the adoption of open source software separate from contribution to OSS projects. For example, while OSS adoption is viewed by respondents as a means of saving time and resources, OSS contribution is not similarly viewed. Rather, contribution to OSS projects is viewed as being advantageous for different reasons, namely engagement in an OSS community. For developers, the sense of social involvement in a community represented by an OSS project can be a positive source of professional satisfaction, ultimately leading to greater productivity and a return on investment for the LIT organization.

## Threats to Validity

Care must be taken when generalizing survey findings to a larger population. The SPEC survey was distributed to all 125 ARL member libraries. ARL libraries are often considered a model for best practices, but are not a representative set of research libraries or libraries in general. Further, the 77 respondents of the survey self-selected, introducing bias toward libraries that are interested or invested in OSS. Also, survey fatigue is a large concern. The SPEC survey was relatively long (32 questions), with some questions involving multiple parts and some requiring respondents to look up specific information in order to answer. Several instances were found where respondents didn’t answer questions completely, which can be seen in the tables above.

## Future Work

The SPEC survey revealed that there are libraries that always choose to share their sharable projects, and, conversely, there are libraries that could share their code but have never chosen to. Future work could include looking for correlations between a library’s software engineering, talent management and innovation policies and practices, and its propensity to initiate OSS projects.

In the years since the publication of Askey’s column two significant types of organizations have arisen within the library landscape, exerting considerable influence on open source software projects. Governing foundations, such as DuraSpace, Kuali, the Islandora Foundation, the Software Conservancy Foundation and ArchivesSpace, manage requirements and coordinate resources of member libraries. Supporting vendors, such as Bywaters and @mire, offer support and hosting services to OSS adopters. While outside the scope of the research we performed, the impact of such organizations is highly relevant to the issues posed by Askey and warrants further investigation.

## Conclusion

We found support for many of the issues presented in Askey’s column. The majority of SPEC survey respondents have adopted and/or contributed to at least one OSS project. Nearly half of respondents chose to initiate one or more OSS project. While most institutions have some experience with OSS, most have only made an initial foray into the space. As Askey suggests, many libraries do have opportunities to initiate OSS projects, but choose not to do so. We found strong evidence supporting the existence of “perfectionism,” “quirkiness,” “dependency” and “misunderstanding,” however, “competitiveness” was extremely rare. Thus, we find support for many, but not all of Askey’s assertions.

The emergence of GitHub as a preferred means of sharing code was highlighted as a development since Askey’s 2008 column. We would suggest that library information technology organizations participating in OSS projects typically understand that they must dedicate technical personnel and other resources in order to do so. Finally, we found that OSS comes with a number of financial trade-offs that need to be carefully examined when considering adoption, contribution and initiation of OSS projects.

## Acknowledgements

One of the authors (Curtis Thacker) spoke with Mr. Askey about his column and the work we were doing on this paper at the CNI Spring 2015 Membership Meeting in Seattle. We appreciated his encouragement and insights in addition to his thought-provoking column which contributed inspiration for both the SPEC survey and this paper.

## Authors

Curtis Thacker is Director of Discovery Systems in Brigham Young University’s (BYU) Harold B. Lee Library. He is also an M.S. candidate in the Department of Computer Science at Brigham Young University and member of the BYU “Software Engineering Quality: Observation, Insight, Analysis” (SEQuOIA) Lab. In addition to Bachelor’s Degrees in Computer Science and Applied Mathematics from Brigham Young University – Idaho. Curtis has 10 years industry experience and seven years library specific experience.

Dr. Charles Knutson is an Emeritus Professor of Computer Science at Brigham Young University, former Director of the BYU SEQuOIA (“Software Engineering Quality: Observation, Insight, Analysis”) Lab and former Director of the BYU Mobile Computing Lab. Dr. Knutson has 27 years of industry experience, including engineering and management positions at Hewlett-Packard and Novell, Inc. He was also Vice President of R&D at Counterpoint Systems Foundry, Inc. (now Sybase iAnywhere), the world’s leading provider of IrDA and Bluetooth protocol stacks for embedded systems. Dr. Knutson has more than 120 technical publications in areas including mobile computing, medical informatics, and software engineering. He holds a Ph.D. in computer science from Oregon State University, and B.S. and M.S. degrees in computer science from BYU.

## Notes

\[[1](https://journal.code4lib.org/articles/#cite1)\] See [http://www.ala.org/aboutala/missionpriorities](http://www.ala.org/aboutala/missionpriorities)  
\[[2](https://journal.code4lib.org/articles/#cite2)\] SEQuOIA = “Software Engineering Quality: Observation, Insight, Analysis”  
\[[3](https://journal.code4lib.org/articles/#cite3)\] See [http://journal.code4lib.org/articles/527#comment-1299](https://journal.code4lib.org/articles/527#comment-1299)  
\[[4](https://journal.code4lib.org/articles/#cite4)\] See operating system statistics at http://www.netmarketshare.com/  
\[[5](https://journal.code4lib.org/articles/#cite5)\] See http://news.netcraft.com/archives/2015/01/15/january-2015-web-server-survey.html  
\[[6](https://journal.code4lib.org/articles/#cite6)\] See http://gs.statcounter.com/#all-browser-ww-monthly-201502-201502-bar  
\[[7](https://journal.code4lib.org/articles/#cite7)\] Percentages are based on the 66 respondents who reported the OSS projects they had adopted.  
\[[8](https://journal.code4lib.org/articles/#cite8)\] All percentages are based on the 56 respondents who have contributed to one or more OSS project. All 56 of these respondents reported on the types of OSS contributions they made.  
\[[9](https://journal.code4lib.org/articles/#cite9)\] Percentages are based on the 50 respondents who indicated which projects they had contributed to.  
\[[10](https://journal.code4lib.org/articles/#cite10)\] Askey defines OSS Lite as “tiny programs written in various scripting languages that drive all the doodads and widgets on our Websites, or extend (or, in some cases, repair) the functionality of our commercial systems.”

## Bibliography

Anderson P. Richard Stallman On The Road Less Travelled \[Internet\]. Intelligent Content. Available from: [http://oss-watch.ac.uk/resources/stallman](http://oss-watch.ac.uk/resources/stallman)

Askey D. 2008. We Love Open Source Software. No, You Can’t Have Our Code. Code4Lib Journal(5).

Ayala CP, Cruzes DS, Hauge O, Conradi R. 2011. Five facts on the adoption of open source software. Software, IEEE 28(2):95-99.

Chudnov D. 2007. The Future of FLOSS in Libraries. Information Tomorrow: Reflections on Technology and the Future of Public and Academic Libraries. Medford, NJ: Information Today, Inc. p. 19-30.

Engard NC. 2010. Practical Open Source Software for Libraries. Elsevier. p. 29.

Eyler P. 2003. Koha: a Gift to Libraries from New Zealand. Linux Journal 2003(106):1.

Kitchenham BA, Pfleeger SL. 2008. Personal Opinion Surveys. Guide to Advanced Empirical Software Engineering. Springer. p. 63-92.

Laurent AMS. 2004. Understanding Open Source and Free Software Licensing. ” O’Reilly Media, Inc.”.

Raymond E. 1999. The Cathedral and the Bazaar. Knowledge, Technology & Policy 12(3):23-49.

Thacker JC, Knutson CD, Dehmlow M. 2014. Open Source Software. Association of Research Libraries
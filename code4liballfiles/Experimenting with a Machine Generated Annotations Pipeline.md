---
title: "Experimenting with a Machine Generated Annotations Pipeline"
source: "https://journal.code4lib.org/articles/15209"
author:
  - "[[The Code4Lib Journal]]"
published: 2020-05-11
created: 2025-01-10
description: "The UCLA Library reorganized its software developers into focused subteams with one, the Labs Team, dedicated to conducting experiments. In this article we describe our first attempt at conducting a software development experiment, in which we attempted to improve our digital library’s search results with metadata from cloud-based image tagging services. We explore the findings and discuss the lessons learned from our first attempt at running an experiment."
tags:
  - "clippings"
---
# Experimenting with a Machine Generated Annotations Pipeline
Joshua Gomez, Kristian Allen, Mark Matney, Tinuola Awopetu,  Sharon Shafer

The UCLA Library reorganized its software developers into focused subteams with one, the Labs Team, dedicated to conducting experiments. In this article we describe our first attempt at conducting a software development experiment, in which we attempted to improve our digital library’s search results with metadata from cloud-based image tagging services. We explore the findings and discuss the lessons learned from our first attempt at running an experiment.

## I. Introduction

### The Labs Team

In the Fall of 2018, the UCLA Library began an effort to modernize our software development processes by adopting a DevOps culture. See (Gomez, 2020) for a discussion of that process. To that end, a focused subteam was formed with the sole purpose of conducting experiments. This team was named “The Labs Team” and this paper describes our first attempt at running a software development experiment.

We expect that many, if not all, of the experiments that this team conducts will somehow be related to the application of artificial intelligence and machine learning (AI/ML) technologies to library resources and workflows. However, as developer time is a precious resource of its own, the experiments we choose to conduct should be of strategic value to the larger team and to the library. Thus, we will also attempt to devise experiments that can guide the wider software development team when making decisions about future development opportunities, architectural designs, and tool selections.

## II. Our First Experiment – MGAP

### Overview

Pre-trained machine learning models have become more widely available for commercial use over the past decade. Regarding models specifically for computer vision, many of the big players in the tech industry now offer services that automatically tag images with descriptive labels. We wanted to know whether it would be worthwhile to apply these tags to our collections in the new digital collections repository.

Once we stated this as our question, we were faced with another one: how would we measure improvement of metadata? We are a group of software developers, so we are familiar with user testing as a means of evaluating systems. We assert that if the users show increased satisfaction, then the system has been improved.

The machine learning models underlying these commercial tagging services are trained with large corpuses of generic images. While large training sets generally improve the accuracy of a model, the scope and quality of the training data also affects accuracy and appropriateness for different use cases. Thus, we suspected that the tags we would get would be too generic for scholarly research purposes but could potentially be useful to casual users looking for interesting images.

Question – Can commercial image tagging services improve the digital library’s metadata?

Assertion – We will evaluate improvement via user testing.

Hypothesis – The tags will be of no use to scholars conducting research on specific topics but will be more useful to casual users looking for interesting images.

### Strategic Motivations

In addition to answering the stated question, we had a few other motivations for conducting this experiment. These were all related to trying out tools and methods that could potentially be of use to the other development subteams, thus making this a strategic experiment.

Another outcome of the reorganization of the software development team was the creation of a User Experience Research & Design (UX) Team. This team developed a strategic plan (Gomez 2019) to improve our UX maturity over the next three years. This experiment offered the opportunity for us to gain more experience conducting usability tests and to try out an unmoderated user testing tool: usertesting.com.

Our new digital library makes use of IIIF \[[1](https://journal.code4lib.org/articles/#note1)\] protocols for image delivery. We designed the technical setup of this experiment in such a way as to make use of our new IIIF services and to experiment with using Web Annotations \[[2](https://journal.code4lib.org/articles/#note2)\], a sort of sister protocol to IIIF, to apply the tags to the images.

One of our higher level goals was to move towards evolutionary architectures, therefore we also designed the experiment in such a way as to use event-driven systems to coordinate the tasks of harvesting, tagging, annotating, and indexing.

## III. Setup

### Context

In early 2018, prior to the new leadership and reorganization of the software development team, the UCLA Library began development on a new digital library repository and public interface \[[3a](https://journal.code4lib.org/articles/#note3a)\] by adopting the open source Samvera platform. The following year, with the new leadership and reorganization came our commitment to move towards a more service-oriented architecture and to reduce the responsibilities of monoliths. As a first step, our Services subteam implemented a suite of services to support image transformation, presentation, and delivery, with the two latter services conforming to IIIF protocols. IIIF is a suite of API specifications that facilitate shared usage of image-based collections across multiple institutions.

At the time in which the MGAP experiment was conducted (Spring and Summer 2019) only three collections had been migrated to the new repository, which was still in alpha mode and would not be publicly released until December of 2019. These three collections were:

- The LA Daily News Negatives (LADNN) – 5,172 images \[[3b](https://journal.code4lib.org/articles/#note3b)\]
- The Will Connell Papers (Connell) – 502 images \[[3c](https://journal.code4lib.org/articles/#note3c)\]
- Walter E. Bennett Photographic Collection (Bennett) – 79 images \[[3d](https://journal.code4lib.org/articles/#note3d)\]

All three of these were journalistic photograph collections dating from the 1920’s to the 1960’s. Each of these were “simple” image collections, meaning that they did not contain paginated materials or other media formats. The simplicity of these collections was certainly an advantage in running the experiment. However, the small size of the data set would prove to be a limitation. These collections were already described by staff in the library’s Cataloging and Metadata unit.

### Tools

The following tools, platforms, and services were used in this experiment.

- Search interface & index – Blacklight & Solr \[[4](https://journal.code4lib.org/articles/#note4)\]
- IIIF image server – Cantaloupe \[[5](https://journal.code4lib.org/articles/#note5)\]
- Annotation server – Elucidate \[[6](https://journal.code4lib.org/articles/#note6)\]
- Application containerization – Docker \[[7](https://journal.code4lib.org/articles/#note7)\]
- Tasks and queue – Python (Celery) \[[8](https://journal.code4lib.org/articles/#note8)\] + RabbitMQ \[[9](https://journal.code4lib.org/articles/#note9)\]
- Image tagging – AWS Rekognition \[[10](https://journal.code4lib.org/articles/#note10)\], Clarafai \[[11](https://journal.code4lib.org/articles/#note11)\], Google Vision \[[12](https://journal.code4lib.org/articles/#note12)\], Microsoft Azure CV\* \[[13](https://journal.code4lib.org/articles/#note13)\]
- Unmoderated user testing – usertesting.com \[[14](https://journal.code4lib.org/articles/#note14)\]

\*Note: Midway through the experiment we reached the limit of Azure’s free tier, and therefore dropped its tags from the experiment.

### Architecture

The diagram below illustrates the architecture of the system and the flow of data within it. We began by taking the existing Solr index of the new repository and replicating it five times: three to be modified by individual tagging services, one to be modified by the combination of all of three tagging services, and one to be left untouched as a control. Each of these indexes also had its own copy of the digital library frontend (Blacklight). We wrapped these five instances of the digital library in Docker containers to make them easier to deploy and tear down on both local developer machines as well as in our cloud hosting environment (AWS).

Once the infrastructure was set up the essential process went as follows:

- The images were harvested from the image server and put into a job queue.
- As those jobs were executed, images were sent to each of the three image tagging services.
- The returned tags were transformed into annotations and posted to the annotation server.
- The tags/annotations were then used to update each image’s document in the Solr index.

Note: the modified indexes still contained the library’s existing metadata. This test was not a direct comparison between the library’s metadata and the tags. The purpose of the test was to determine if the tags could enhance the existing metadata, not to determine if they could replace it.

[![Figure 1. Architecture diagram](https://journal.code4lib.org/media/issue48/gomez-mgap/01.jpg "Figure 1. Architecture diagram")](https://journal.code4lib.org/media/issue48/gomez-mgap/01.jpg)

**Figure 1.** Architecture diagram

## IV. Preliminary Analysis

Prior to user testing we did some cursory analysis of the tags and found some interesting differences between the three services.

#### Tag Quantities

On average, Google Vision applied a smaller number of tags to each image and had a narrower range, whereas AWS Rekognition had a much wider range and a higher average. This reveals a potential difference in the confidence thresholds that determine whether to apply a given tag or not, with Google having a more conservative default setting (i.e. a higher threshold). The default threshold for AWS was 55%, whereas Google did not specify the threshold. Clarafai applied exactly 20 tags to every image, regardless of confidence level, which is the default if you do not specify a minimum value for the confidence threshold or a maximum number of concepts.

<table><thead><tr><th rowspan="2"></th><th colspan="3">Tag count per image (average)</th></tr><tr><th>Amazon</th><th>Clarafai</th><th>Google</th></tr></thead><tbody><tr><td>Bennett</td><td>18.6</td><td>20</td><td>4.8</td></tr><tr><td>Connell</td><td>12.8</td><td>20</td><td>2.8</td></tr><tr><td>LADNN</td><td>16.3</td><td>20</td><td>4.3</td></tr></tbody></table>

<table><thead><tr><th rowspan="2"></th><th colspan="6">Tag count per image (min &amp; max)</th></tr><tr><th colspan="2">Amazon</th><th colspan="2">Clarafai</th><th colspan="2">Google</th></tr></thead><tbody><tr><td>Bennett</td><td>5</td><td>34</td><td>20</td><td>20</td><td>2</td><td>9</td></tr><tr><td>Connell</td><td>2</td><td>36</td><td>20</td><td>20</td><td>1</td><td>14</td></tr><tr><td>LADNN</td><td>1</td><td>47</td><td>20</td><td>20</td><td>1</td><td>16</td></tr></tbody></table>

#### Tag Qualities

To get a sense of what kinds of tags were actually being applied, we took a look at the top 10 tags that each service applied to the LA Daily News Negatives collection. As illustrated in the charts below, the most common tags from each service were very generic terms. One might be inclined to infer our hypothesis (that the tags would only be useful to casual users and not to scholars) was on strong ground after seeing these generic terms. That would be a bad inference. It makes sense that the top 10 most common terms would be the most generic terms. What is striking, however, in these results is the precipitous decline in term frequency from Google compared to the other two. This is in line with the tag counts discussed above, which suggest that Google’s service is more conservative.

![Figure 2. 'LADNN' according to Amazon Rekognition: 10 most common tags](https://journal.code4lib.org/media/issue48/gomez-mgap/02.png "Figure 2. 'LADNN' according to Amazon Rekognition: 10 most common tags")

**Figure 2.** “LADNN” according to Amazon Rekognition: 10 most common tags

![Figure 3. 'LADNN' according to Clarifai: 10 most common tags](https://journal.code4lib.org/media/issue48/gomez-mgap/03.png "Figure 3. 'LADNN' according to Clarifai: 10 most common tags")

**Figure 3.** “LADNN” according to Clarifai: 10 most common tags

![Figure 4. 'LADNN' according to Google Vision: 10 most common tags](https://journal.code4lib.org/media/issue48/gomez-mgap/04.png "Figure 4. 'LADNN' according to Google Vision: 10 most common tags")

**Figure 4.** “LADNN” according to Google Vision: 10 most common tags

## V. Moderated User Testing

Once the images had all been tagged and the indexes updated, we conducted user tests to determine if the changes in search results proved to be of greater utility to the end users than the unmodified digital library’s search results.

### Methods

Our user testing began with in-person, think-aloud protocol tests moderated by members of the UX Team. We conducted these tests in early June, which unfortunately coincided with finals week. We were unable to recruit as many students as we had hoped for and were forced to rely mostly on library staff. In total, we conducted nine in-person tests.

In these tests, the user was presented with the control interface and one of the four modified interfaces. We did not want to overwhelm them by having each user look at all five instances. Due to the limited size and scope of the three collections, we created a series of three tests that initially introduced the users to the kinds of materials in the collection with search terms we provided, and then incrementally gave them more freedom to perform their own searches.

#### Test 1: Provided Search Terms

The participants were given exact terms (e.g. “sunglasses”, “theater”, “Chinatown”, “cat”) to enter into the search bars of both user interfaces. We asked them to rate the relevancy of both sets of search results independently (i.e. we did not ask them to compare or rank the two results).

#### Test 2: Provided Scenario

The participants were presented with a scenario in which they were costume designers working on a historical film set in 1940’s Los Angeles. They were asked to look for inspiring images by using their own search terms. Again, we asked them to rate the relevancy of both sets of search results independently.

#### Test 3: Free Form Search

At this point, we hoped the participants had gotten a feel for what kinds of materials were in the collections. We therefore asked them to perform searches of their own and asked them to rate relevancy of both sets of results independently.

### Results

In this round of testing, we encountered many limitations to the experiment. As mentioned above, the reliance on library staff could lead to skewed results as they are not representative of the typical user base and may be biased due to their training and expertise. More importantly, the image set was just not very large (less than 6000 images), and the images were limited to a narrow scope of three historical collections. The limited collection of resources made evaluation of the relevance of the search results very difficult. Most users, including the library staff, just didn’t know what to look for since they were not familiar with the collections. We tried to mitigate that problem by graduating from spoon-fed terms to free-form searches. The hope was that we would expose the users to what the collections were about in the first two tasks so that the free-form test would feel a little more natural to the participants. Whether we achieved that goal is debatable.

Perhaps the biggest problem was in the actual test itself. In our test we asked users to rate the relevance of each result set independently. Our goal was to compile the results and determine which service scored highest on average. Unfortunately, the ratings across the interfaces were not significantly different. A better approach may have been to just ask the users to compare the two sets of search results and tell us which they thought performed better.

Some other challenges we faced included recruiting, as mentioned above. But even when we found willing participants, scheduling was also an impediment. Finding time slots during which both a team member and a participant were both available proved quite challenging.

Based on these limitations, we decided to revise our methods and perform a second round of user testing, this time all online.

## VI. Unmoderated User Testing

### Methods

As mentioned above, we recognized several limitations of our first round of tests. We could not address them all, in particular we could not change the collections, as only three had been migrated into the new digital library platform. But there were two areas in which we could improve: the participant pool and a forced ranking of the search results instead of independent scoring.

This second round of testing was conducted entirely online using the SaaS testing platform usertesting.com, thanks to a free trial they offered us. This service provided three key benefits. First and foremost, they have a panel of 1.5 million users they pay to participate in usability tests. This meant no more recruiting woes for us. Second, the tests are completely unmoderated. We filled out a form with our test instructions and questions. The service then overlaid our site with those instructions and questions as the users progressed through the tests. This freed us from the other large burden of scheduling. Finally, the service recorded the participants’ screens and audio responses for us to analyze later.

We conducted 21 unmoderated sessions. The first was a dry-run that helped us refine the instructions and questions. We then conducted the remaining 20 sessions with five participants for each of the four modified indexes.

#### Tests 1, 2, and 3 Revised

We performed the same three tests as before: provided search terms, provided scenario, and free form search. The key difference was that instead of asking the users to rate the results independently, we asked them to compare the two search result sets (the control set and one modified set) and determine which was better. They also had options to state that neither set was better than the other or that neither set was relevant at all.

#### Test 4: Evaluate a Single Image’s Tags

We added one extra test in the second round. We asked the participants to look at the machine generated tags for a single image in all four modified interfaces. We then asked the participants to rate (on scales from 1 to 5) the accuracy and the usefulness of the tags for each set independently (i.e. not to rank or compare them). This was the only task in which the participants were exposed to all four sets of modified tags.

### Results

#### Test 1

The charts below illustrate the users’ preferences of the search results when asked to search for specific words (“sunglasses” and “theater”). In both cases the search result set from the control (i.e. the library’s existing metadata) was rated higher than or equal to the set modified with tags from AWS Rekognition by every user, whereas the sets modified with Google Vision were voted higher than the control sets by some users. The users determined that the sets modified with tags from Clarafai were neither better or worse, while the set combining tags from all three services was rated worse than the control in very similar proportions as AWS.

![Figure 5. Task 1a 'Sunglasses' Comparisions](https://journal.code4lib.org/media/issue48/gomez-mgap/05.png "Figure 5. Task 1a 'Sunglasses' Comparisions")

**Figure 5.** Task 1a – “Sunglasses” Comparisions

![Figure 6. Task 1b 'Theater' Comparisions](https://journal.code4lib.org/media/issue48/gomez-mgap/06.png "Figure 6. Task 1b 'Theater' Comparisions")

**Figure 6.** Task 1b – “Theater” Comparisions

#### Test 2

In the wardrobe designer scenario, we saw a slight variation of the results from Test 1. Once again, the results modified with tags from Google Vision received votes ranking it higher than the control set, and once again AWS received no votes. Clarafai received as many votes as Google Vision. Interestingly, the control received almost no votes (just one, when rated against AWS). The majority of users across all four groups found the result sets to be equal.

![Figure 7. Task 2 - Wardrobe Designer](https://journal.code4lib.org/media/issue48/gomez-mgap/07.png "Figure 7. Task 2 - Wardrobe Designer")

**Figure 7.** Task 2 – Wardrobe Designer

#### Test 3

When performing free-form searches, the users never rated the control better than the modified search results sets. Clarafai received a pair of votes, and Google Vision one, while AWS still did not receive a single vote. What is interesting here is the significant increase in the number of users who voted that neither the control or the modified sets were relevant.

![Figure 8. Task 3 - Free Form Search](https://journal.code4lib.org/media/issue48/gomez-mgap/08.png "Figure 8. Task 3 - Free Form Search")

**Figure 8.** Task 3 – Free Form Search

#### Test 4

In this test we asked the users to look at the tags from all four sets for the image below of Lyndon Johnson riding a horse. The tags from Google Vision received the highest average votes for both accuracy and usefulness. AWS received the lowest average for accuracy and Clarafai received the lowest votes for usefulness.

![Figure 9. Task 4 - JLB riding a horse](https://journal.code4lib.org/media/issue48/gomez-mgap/09.png "Figure 9. Task 4 - JLB riding a horse")

**Figure 9.** Task 4 – JLB riding a horse

![Figure 10. Photo: JLB riding a horse](https://journal.code4lib.org/media/issue48/gomez-mgap/10.jpg "Figure 10. Photo: JLB riding a horse")

**Figure 10.** Photo: JLB riding a horse

### Discussion

Across all four tests, Google Vision performed the best, while AWS Rekognition performed the worst, including the direct comparison in Test 4. This is likely a result of Google’s more conservative application of tags which we observed in the preliminary analysis. The tags from AWS may be more “noisy” and therefore less accurate and useful, leading to poorer search results as determined by end users. In most of the tests the combined set of tags performed nearly as poorly as AWS. Therefore, based on just the results presented here, if we decide to incorporate machine generated tags into our digital library’s metadata, it appears that we should use a single image tagging service and that Google Vision would be the best choice to provide that service.

However, it is not clear from these results that incorporating these extra tags would be worthwhile. Across tests 1 and 2, comparing the library’s existing metadata to the enhanced sets, there were many more votes for the control or for “equal” than there were for any of the tagged sets. This is fairly in line with our hypothesis that the tags would not be useful to scholars looking for something specific in the digital library. The second half of our hypothesis stated that the tags would be beneficial to casual users looking for interesting images. Therefore, we expected to see the tagged sets perform better in Test 3 (free-form search). However, the results show that the users found neither the control or the tagged result sets relevant. Thus, the machine generated tags do not appear to provide much benefit to casual users either.

Other factors to consider when deciding to incorporate machine generated tags include cost and level of effort. The prices for these services are all very reasonable — on the order of a few dollars per 1,000 images. We currently host around 3 million images across all of our legacy digital library platforms. As we migrate these collections to the new repository over the next year, the cost to tag them all would only cost a few thousand dollars. The level of effort to operationalize this process is more significant than the cost of the service, but is still not prohibitive.

Our event-handling infrastructure performed well for our needs and would likely be sufficient for the mass migration of content (i.e. no need for enterprise level streaming data solutions like Kafka or Airflow). But operationalizing this setup would incur a fair amount of developer time, especially as the knowledge would need to be transferred from the Labs Team to the Services team, which is responsible for building and maintaining our backend services. So, while the total cost of adoption is reasonably low, it still outweighs the meagre potential benefits. We therefore decided not to prioritize adoption of machine generated tags in our 3-year software development roadmap, though we will likely revisit this topic again in the future.

### Limitations

One limitation in our study was the variation in settings and scope across the CV models we used. We did not ensure that each service conformed to the same number of returned labels or, more importantly, to the same confidence threshold. Without this calibration, our findings are bound to be skewed in favor of the one that is most conservative by default, as the others will have more “noise.” Furthermore, the Google service applied labels only using object detection, which is concrete, whereas Clarafai and Amazon also apply more abstract labels for things like moods, concepts, and themes.

A significant limitation of this experiment was the framing of the question and the method of measurement. Relevance is a difficult attribute to measure. Without a precise definition, any determination of relevance will be subjective. Scholars in the field of information retrieval address this issue with the construction of a corpus for events like TREC (Text Retrieval Conference) \[[15](https://journal.code4lib.org/articles/#note15)\], in which the relevant results are known ahead of time, and the search index is evaluated on its ability to return all of those results and no others, with no recourse to end user judgement of the actual result sets.

We wanted to test the tags on our own collections, not on a generic, standard data set like TREC. But creating our own corpus was too high a barrier for our less formal experiment. To avoid that high barrier we chose instead to embrace the inherent subjectivity in determining relevance by employing usability testing as our method of measurement. This seemed appropriate as our goal was to determine if the tags would help our users, not to determine their technical accuracy and precision. Unfortunately, due to timing we were unable to conduct the usability tests on our actual users. We relied on staff for in-person testing and completely unaffiliated users for the unmoderated testing. Therefore, our results tell us nothing about our actual users. Regardless of the source of participants, our results still suffered from small numbers of both the users and the images available in the user interface. Even if all test results indicated our hypothesis was correct, the small sample sizes would prevent confirming the hypothesis with confidence. This is an inherent attribute of usability testing, which is by its nature a qualitative method.

## VII. Conclusion

### Lessons Learned

When conducting experiments, we have learned to make sure our question is not overly broad and that all the concepts are well defined. However, we should add that we do not intend to tighten our focus as narrowly as a true scientist might, as we intend our experiments to produce immediately actionable insights, not minute increments of factual knowledge.

We have also learned to make sure that the instrument of measurement is appropriate. Using a qualitative method to gather quantitative data is bound to be problematic in both execution and results.

### Goals Achieved and Bonus Findings

Despite the limitations and the negative results, the project was highly valuable for our team. We achieved all of our strategically motivated goals, including gaining experience with tools for Web Annotations, event-driven systems, and unmoderated user testing.

Perhaps the greatest benefit of the experiment was the discovery, during all those tests with users, of several usability issues with the actual interface. These discoveries were shared with the Applications Team, which was tasked with building out the new digital repository’s public interface, and they were all addressed before the December 2019 public release.

### Future Work

#### AI/ML

While we have decided not to apply machine generated tags to our image collections, we may try using similar AIL/ML tools on some of our video collections. As of October 2019, the UCLA Film and Television Archive is now under the wing of the UCLA Library. The archive is the second largest in the country, behind only the Library of Congress. The archive’s collections do not have the same level of descriptive metadata as the library digital image collections. In fact, many of the items have no descriptive metadata. Thus, machine generated tags would make a vast improvement on the discoverability of the materials. We will begin exploring these options in the Spring of 2020.

#### Usability Testing

As for unmoderated user testing, we intend to explore other service providers, such as Loop11 \[[16](https://journal.code4lib.org/articles/#note16)\], which offer similar features but with a “bring your own users” business model. This will put the burden of recruiting back on our shoulders, but it will still relieve us from the difficulty of scheduling, and the prices are significantly lower.

#### IIIF & Web Annotations

To support the large amount of video coming our way from the Film & Television Archive, the Services Team will begin upgrading our IIIF services to conform to the new version of the IIIF Presentation API to support time-based media.

We would like to continue working with Web Annotations and to enable our users to translate and transcribe materials, as well as to build their own virtual collections which they can annotate with notes and discussions. However, this is not currently on our 18-month development roadmap, which is likely to be dominated by a website redesign and CMS migration, as well as the library’s migration to a new ILS.

## Bibliography

Ford N, Parsons R, Kua P. 2017. Building Evolutionary Architectures: Support Constant Change. Sebastopol: O’Reilly Media.

Gomez J. 2020. Modernizing a Software Development Team \[Internet\]. \[Modified 2020-05-02\]. \[Cited 2020-05-02\]. Available from [https://misc.dev/posts/modernizing-a-dev-team/](https://misc.dev/posts/modernizing-a-dev-team/)

Gomez J, Awopetu T, Prigge A, Shafer S. 2019. UX Strategic Plan 2020 – 2022 \[Internet\]. Available from: [https://ucla.box.com/s/mldgoduuf33hsr3ysgrahzczrgni7kuo](https://ucla.box.com/s/mldgoduuf33hsr3ysgrahzczrgni7kuo)

Kim G, Debois P, Willis J, Humble J, Allspaw J. 2016. The DevOps Handbook : How to Create World-Class Agility, Reliability, and Security in Technology Organizations. Portland (OR): IT Revolution Press.

Rasmusson J. 2012. The Agile Samurai: How Agile Masters Deliver Great Software. Dallas (TX): The Pragmatic Bookshelf.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] [https://iiif.io](https://iiif.io/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] [https://www.w3.org/annotation/](https://www.w3.org/annotation/)

\[[3a](https://journal.code4lib.org/articles/#ref3a)\] [https://digital.library.ucla.edu/](https://digital.library.ucla.edu/)

\[[3b](https://journal.code4lib.org/articles/#ref3b)\] [https://digital.library.ucla.edu/catalog/8zn49200zz-89112](https://digital.library.ucla.edu/catalog/8zn49200zz-89112)

\[[3c](https://journal.code4lib.org/articles/#ref3c)\] [https://digital.library.ucla.edu/catalog/tpf2h200zz-89112](https://digital.library.ucla.edu/catalog/tpf2h200zz-89112)

\[[3d](https://journal.code4lib.org/articles/#ref3d)\] [https://digital.library.ucla.edu/catalog/m8f11000zz-89112](https://digital.library.ucla.edu/catalog/m8f11000zz-89112)

\[[4](https://journal.code4lib.org/articles/#ref4)\] [http://projectblacklight.org/](http://projectblacklight.org/)

\[[5](https://journal.code4lib.org/articles/#ref5)\] [https://cantaloupe-project.github.io/](https://cantaloupe-project.github.io/)

\[[6](https://journal.code4lib.org/articles/#ref6)\] [https://github.com/dlcs/elucidate-server](https://github.com/dlcs/elucidate-server)

\[[7](https://journal.code4lib.org/articles/#ref7)\] [https://www.docker.com/](https://www.docker.com/)

\[[8](https://journal.code4lib.org/articles/#ref8)\] [http://www.celeryproject.org/](http://www.celeryproject.org/)

\[[9](https://journal.code4lib.org/articles/#ref9)\] [https://www.rabbitmq.com/](https://www.rabbitmq.com/)

\[[10](https://journal.code4lib.org/articles/#ref10)\] [https://aws.amazon.com/rekognition/](https://aws.amazon.com/rekognition/)

\[[11](https://journal.code4lib.org/articles/#ref11)\] [https://www.clarifai.com/](https://www.clarifai.com/)

\[[12](https://journal.code4lib.org/articles/#ref12)\] [https://cloud.google.com/vision/](https://cloud.google.com/vision/)

\[[13](https://journal.code4lib.org/articles/#ref13)\] [https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/](https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/)

\[[14](https://journal.code4lib.org/articles/#ref14)\] [https://www.usertesting.com/](https://www.usertesting.com/)

\[[15](https://journal.code4lib.org/articles/#ref15)\] [https://trec.nist.gov/](https://trec.nist.gov/)

\[[16](https://journal.code4lib.org/articles/#ref16)\] [https://www.loop11.com/](https://www.loop11.com/)

## About the Authors

Joshua Gomez is the Head of Software Development and Library Systems at the UCLA Library

Kristian Allen is a Software Developer at the UCLA Library

Mark Matney is a Software Developer at the UCLA Library

Tinuola Awopetu is a UX Developer at the UCLA Library

Sharon Shafer is the Search & Assessment Librarian at the UCLA Library
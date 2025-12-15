---
title: "OPRM:  Challenges to Including Open Peer Review in Open Access Repositories"
source: "https://journal.code4lib.org/articles/12171"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-01-30
created: 2025-01-10
description: "The peer review system is the norm for many publications. It involves an editor and several experts in the field providing comments for a submitted article. The reviewer remains anonymous to the author, with only the editor knowing the reviewer´s identity. This model is now being challenged and open peer review (OPR) models are viewed [...]"
tags:
  - "clippings"
---
# OPRM:  Challenges to Including Open Peer Review in Open Access Repositories
Pandelis Perakakis, Agnes Ponsati, Isabel Bernal, Carles Sierra, Nardine Osman, Concha Mosquera-de-Arancibia, Emilio Lorenzo

The peer review system is the norm for many publications. It involves an editor and several experts in the field providing comments for a submitted article. The reviewer remains anonymous to the author, with only the editor knowing the reviewer´s identity. This model is now being challenged and open peer review (OPR) models are viewed as the new frontier of the review process. OPR is a term that encompasses diverse variations in the traditional review process. Examples of this are modifications in the way in which authors and reviewers are aware of each other’s identity (open identities), the visibility of the reviews carried out (open reviews) or the opening up of the review to the academic community (open participation). We present the project for the implementation of an Open Peer Review Module in two major Spanish repositories, DIGITAL.CSIC and e-IEO, together with some promising initial results and challenges in the take-up process. The OPR module, designed for integration with DSpace repositories, enables any scholar to provide a qualitative and quantitative evaluation of any research object hosted in these repositories.

## Background

The peer review system is the norm for many publications as it is an essential element in the avoidance of errors in scientific literature and therefore in the improvement in its quality. It involves an editor and several experts in the field providing comments for a submitted article. One of its characteristics is that the reviewer remains anonymous to the author, with only the editor knowing the reviewer´s identity.

This model is now being challenged and open peer review (OPR) models are viewed as necessary in improving some of the problems in the existing system. In the OPR model, openness and transparency are two aspects that are considered necessary to address the issue of biased or non-expert opinions, which is inherent in the anonymous peer review model, characterized by the anonymity of reviews and the unaccountability of reviewers.

While there are differences in the definition of the OPR concept, “open” here means that

- The public has free online access to the full text of the reviews,
- Reviews can be submitted by an unlimited number of peers over the lifetime of the content,
- The identity of authors and peers is disclosed during the entire peer review process.

The project to build an OPR module for open repositories is based on a series of premises:

- The need to incorporate quantitative assessment of the hosted research items that will facilitate the process of selecting the most relevant and distinguished content of a repository. Common currently available metrics, such as number of visits and downloads, do not necessarily reflect the quality of a research work
- The need to assess and review content (grey literature, research results in earlier stages, etc.) related to research but removed from the customary flows of scientific publication, as well as enabling post-publication peer-review
- The opportunity to connect the review model (linked to content ratings) to an author reputation model (Sabater-Mir and Sierra, 2005) with the aim of offering an incentive to researchers to undertake high-quality assessments. Importantly, our open peer review module includes an authors and reviewers reputation system based on the assessment of reviews themselves by other peer reviewers. This allows a sophisticated scaling of the importance of each review on the overall assessment of a research work, based on the reputation of the reviewer

To address these issues, we developed an Open Peer Review Module (OPRM) to be installed on existing open access repositories, DIGITAL.CSIC and e-IEO \[[1](https://journal.code4lib.org/articles/#note1)\], and offered as an overlay service. Any digital research work hosted in a compliant repository can then be evaluated by an unlimited number of peers who offer not only a qualitative assessment in the form of text, but also quantitative measures that are used to build the reputation of the research work and its authors.

Like many other innovations or emerging processes, and OPR should be described as such, the development of the module faced many challenges with regard to its inception, development, implementation, and adoption. These included complex decisions in the aspects relating to the opening of the model to researchers from other institutions and the consequent complexity in their identification, the transparency of the ratings issued, the configuration of the invitations model, attempting to strike a balance between the opening of the model and the restriction of the activity of trolls, the role of administrators of the repositories, etc.

Always important, the technical challenges involved introducing new workflows into functionally complex repositories designed to be minimally intrusive and to take maximum advantage of the already existing code of the DSpace software. The code developed \[[2](https://journal.code4lib.org/articles/#note2)\] is based on standard functionalities of DSpace, aligning it therefore with the software’s constant evolution.

Equally challenging was the translation of the reputation model to the calculation algorithms and corresponding data structures. The convergence of the algorithms (reputations are calculated cyclically and reiteratively) and its impact on the calculation times and, consequently, on the performance of repositories, required constant adjustments and measurement for its control.

Finally, of no less importance, the adoption of the new OPR paradigm by users is complex. We believe that the future frontiers of OPR will be centred on how to attract authors and reviewers while confidence is being built in the new reputation system, as well as the search for incentives that encourage researchers to undertake public and transparent reviews.

## Characteristics of the Reputation Model

The reputation assessment model is based on peers evaluating (quantitatively, in addition to qualitatively) each other’s research works as well as each other’s reviews. The latter allows for a sophisticated scaling of the importance of each review on the overall assessment of a research work, based on the reputation of the reviewer. We note that our model assumes that evaluations may be done on a number of dimensions (e.g. originality, technical soundness, predicted impact, etc.), however, an ‘overall quality’ dimension is used for computing the general reputation of the research work.

In brief, the model quantifies a reputation (Osman, Provetti, Riggi, and Sierra, 2014) for works (which can be any research object hosted by the repository), authors, reviewers, and reviews.

The **reputation of an article** is the weighted aggregation of the reviews it receives, where the weight depends on the reputation of the reviewer (discussed below). A single metric is provided for each evaluation dimension: overall quality, expected impact in the field, expected impact for society, etc.

A **scholar’s reputation** as an author is an aggregation of the reputation of their papers. Again, this reputation is computed for each dimension separately. Note that the impact of the reputation of a particular work in the general reputation of an author is inversely proportional to the number of authors of the work.

The **reputation of a reviewer** is essentially a weighted aggregation of the comments about his or her reviews by other reviewers who evaluated the same research works. The weight in this case is the reputation of reviewers who offer an opinion.

Finally, the **reputation of a review** is similar to the one for articles. It is a weighted aggregation of the ratings received in comments, where the weight is the reputation as reviewer of the researcher who wrote the comment.

The module allows an unlimited number of expert reviewers to provide an evaluation for any research work, either preprint or already published. Reviewers can either be invited through the system (for example following a request by an author or editor) or can volunteer to review any object of the repository. In both cases, reviewers receive the review request details by email and are asked to offer their review reports within a specified deadline. The review and reviewer credentials are submitted to the system administrator for inspection and verification. After this process is completed, the review is linked to the original research object and becomes openly accessible.

## Implementation Details

Compared to other design options, we should note that the development was selected on the basis of the existence of advanced author models in both repositories. These models, for the two repositories under consideration, are based on the authority-control functionality \[[3](https://journal.code4lib.org/articles/#note3)\] of DSpace. The e-IEO repository, with DSpace version 5 and XMLUI interface, incorporates an authors-extension \[[4](https://journal.code4lib.org/articles/#note4)\] based on code from Atmire. The repository DIGITAL.CISC, with DSpace version 4 and JSPUI interface, has DSpaceCRIS \[[5](https://journal.code4lib.org/articles/#note5)\] module installed.

In our view, basing the developments performed on one of the existing models in DSpace for extending author-related functionality, it is necessary to:

- Disambiguate and identify the authors of articles and reviews unequivocally so that it is possible to calculate the reputations of articles by taking into account the reputations of reviewers and authors,
- Show the reputations of authors and reviewers in their personal pages. This is necessary for credit and recognition.

The Open Peer Review Module is built around a number of components described below:

The **Invitations component** has been developed as an extension of the workflow and submission capabilities of DSpace. It allows the author to send review requests to selected peers. Alternatively, any user can request a token to make a review.

The submission-item-interface has been extended to specify the email addresses of the reviewer. The system sends a customized email including a token that grants the reviewer access to the research object and to the reviews’ subsystem, bypassing the login and authorization checking of DSpace

The **Reviews component**. This is also an extension of the workflow and submission capabilities of DSpace. The reviewer accesses the reviews’ subsystem acting with sufficient privileges granted by the token, and the evaluation forms are then presented to him/her, together with relevant terms and conditions regarding the whole review process.

The proposed forms can be configured using standard data types when applicable, although an additional schema has been added to accommodate a specific model’s metadata. When the review form is completed, a new object is created in the submission workflow. The submission workflow can assign the review object to the repository administrators, with a single Accept/Reject/Edit Metadata step or just deposit the review in a specific collection. The administrator can complete the submission process with any necessary metadata enrichment. Following this step, specific background tasks are attached to the process, via consumer events, to perform automatic validation of the metadata, linking reviews and reviewed objects, and calling the reputation submodules to calculate new numeric values (for authors and research objects) and automatically incorporating them into the reviewed object and into the review.

The **Comments component** complements the reviews component, allowing comments (also called annotations) to be attached to the reviews. Reviewers use it to comment or annotate other reviews of the same research object. Comments/Annotations are automatically deposited into a specific collection, which contains the Submit Group Anonymous Group. This allows annotations by those who do not have a user account (the same principle followed with reviews). Annotations are restricted in that they only can be made by those who have created a review on the item, or by any of the authors. The component could be limited, eventually, like the reviews component, to one or more email subdomains, in order to avoid uncontrolled use of the system.

The **DSpace Data model** has been extended to incorporate relevant metrics as well as the back-and-forth relationships between research objects and their reviews and judgments. Specific metadata schemas have been incorporated into both repositories, although an extension of the Qualified Dublin Core metadata scheme could be used, possibly leading to simpler implementations.

In order to process information about the reputation of the authors, and make this information persistent, the system uses extensions to the author´s metadata. It is important to note that the module can be used without these extensions, although in this case the consolidation and visualization of the reputation of authors and reviewers is not available.

The **Reputation engine** was developed as a separate plugin, allowing easy adaptation to other reputation algorithms and making feasible its implementation and functional adaptation to other repositories.

The reputation engine meets the following principles:

- The reputation of a research object is calculated by aggregating the weighted ratings by reviewers
- The reputation of research objects will then be used to calculate the reputation of individual authors
- The reputation of reviews will be calculated by aggregating the evaluations (called judgments) of other reviewers. They are subsequently used to calculate the reputation of individual reviewers.
- If a person plays more than one role (author, reviewer and/or single user) in the system, the module will estimate a global reputation for this person, combining her/his reputation as an author and reviewer

Together with the above components, a group of modifications to the repositories were made. These include item view and author’s pages customization with the aim of presenting the different reputation values of objects and agents involved; adjustments in the searching, indexing and filtering subsystems to enable the search for the new types of objects, reviews and comments; and adjustments in the filter system of OAI\_PMH to avoid exposing the reviews and comments in normal harvesting interfaces.

![](http://journal.code4lib.org/media/issue35/lorenzo/Fig1.png)  
**Figure 1.** Item´s view showing reputation values

## Project Data

The project was funded by the European Union, Grant ID 643410, in the context of the OpenAIRE Horizon 2020 initiatives \[[6](https://journal.code4lib.org/articles/#note6)\] that aim at promoting OPR and studying its effects in the context of digital infrastructures for open scholarship. Its management, coordination and implementation took place between June, 2015, and March, 2016, through the formation of a consortium of six partners, including:

- The Open Scholar CIC organisation, which acted as the project promotor and coordinator
- The institutional repository of the Spanish National Research Council ([DIGITAL.CSIC](https://digital.csic.es/))
- The repository of the Spanish Oceanographic Institute ([e-IEO](http://www.repositorio.ieo.es/e-ieo/))
- The Artificial Intelligence Research Institute of the Spanish National Research Council ([IIIA-CSIC](http://www.iiia.csic.es/es)) in Catalonia
- The Multidisciplinary Laboratory of Library and Computer Sciences ([SECABA](http://secaba.ugr.es/)) in Granada
- A DSpace Registered Service Provider ([Arvo Consultores](http://www.arvo.es/))

## Conclusions and Future Directions

Open Access repositories can play a far more significant role in scholarly communication by integrating an open and transparent evaluation system. This additional functionality can help to address many of the issues related to the peer review system, the current journal-based research reputation system.

The reputation model produces novel metrics that directly reflect the perceived quality of a research work by expert peers, as opposed to current available metrics in repositories that only indirectly account for quality through usage statistics. Likewise, the reputation model of the agents participating in the process (authors and reviewers) is an element that is different to other review models as it lays the foundations of new author assessment metrics, which also promote, as opposed to the non-disclosed peer model, transparent reviews.

Despite the short length of time in which this module has been operational, it may be seen that the integration of peer review into repositories promotes open scholarship by enabling a direct, transparent collaboration between authors and reviewers. A simple survey among the participating authors in both pilot projects has produced responses that are consistent with the general view of researchers about open peer-review (Callaway, 2016), with support and misgivings expressed with regard to the new processes.

Open peer review is regarded as a long-awaited repository service, whose primary use is for preprints and other unpublished works. However, it is viewed as limited in terms of its applicability for works that have been already evaluated and published. We would indicate that generally even those researchers who support this new repository service reported issues that can slow down the uptake of this feature. These include finding the time to select works to be reviewed, inviting peers, and commenting on the reviews received. Furthermore, it appears that inviting peers to an open evaluation may place authors and reviewers in an uncomfortable situation. We surmise that this aspect may be associated with the still small circle of experts available for invitation and the inevitable issues with regard to co-authorship and competition.  
Finally, researchers indicate that current systems of merit and professional evaluation do not take into consideration (and it is not anticipated that they will do so in the short term) authors’ performance (either as a reputation index or any other process indicator), which is regarded as a major obstacle to the paradigm deployment of open peer review.

Reviewers feel that the system implemented is a great idea that merits success as currently peer review is not credited in the CVs of researchers at all due to its anonymity. But, in keeping with the above paragraph, researchers will not have time to review and comment on the work of other peers as long as this activity remains beyond the scope of CVs and lacks strong support from the research institutions.

Naturally, authors and reviewers would like the model, which in its current implementation is limited in those who can review and those who can comment, to be endowed with a greater openness, saying that the service should promote spontaneous discussion between those who wish to send comments. They say that it is demanding, delicate and difficult to make public reviews of sufficient quality and to continue with the dialogue that the review and comments system may require. This leads reviewers to request that the works associated with the review process be introduced into the system that assesses research activity.

The two participating institutions, CSIC and IEO, have encountered difficulties in providing authors and reviewers with explanations (we acknowledge that it is hard to operate) about the invitations process together with the concepts that underpin the reputations and scoring model. Similarly, improvements have been suggested. These include the need to connect or link the objects to be reviewed to potential reviewers on the basis of similarities between the subject matter of the pre-print or article and the reviewers’ expertise. A large part of the system’s viability appears to involve making this connection between objects and reviewers in an automatic manner, striving not to exclusively base it on the peer-review invitation model. In terms of the functionality provided by the module, it should be noted that the improvement of the user interface is seen as a priority in order to make it more comprehensible and easy to handle and even to automate the invitation-review-comment process.

The two participating repositories already had advanced author functionalities incorporated (authorities models, researchers’ personal pages, etc.) and consequently they viewed the addition of the OPRM module as an extra step in the offer of advanced services to researchers and general users. Questions may be raised about the model’s viability or usefulness for repositories lacking this functional maturity.

Both the CSIC and the IEO feel that it is necessary to design an effective and attractive campaign that reaches out to the wider institutional community in order to consolidate the service as an active one for the repositories in the coming months. Without such a campaign, misgivings about the lack of linkage with institutional assessment exercises and a rewards system, limitations associated with an invitation-based module and misunderstandings about the OPRM reputation sub-module and what type of open peer review it supports are expected to be potential stumbling blocks.

In light of the above, the immediate directions for development of the Open Peer Review Module in the two participating repositories are oriented towards facilitating the creation of reviews by authors from connected scientific disciplines, connecting the invitations’ system with the repository subscription service, opening up the invitations system to enable reviews to be made by a wider audience, improving the user interface, explaining and refining the algorithms that calculate reputations, and improving the understanding of reputation ratings.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] CSIC repository, found at digital.csic.es and Spanish Oceanographic Institute repository, found at [http://www.repositorio.ieo.es/e-ieo/](http://www.repositorio.ieo.es/e-ieo/)  
\[[2](https://journal.code4lib.org/articles/#ref2)\] The code is currently publicly available. To download it or see the detailed module specification, visit the project wiki at [https://github.com/arvoConsultores/Open-Peer-Review-Module/wiki](https://github.com/arvoConsultores/Open-Peer-Review-Module/wiki)  
\[[3](https://journal.code4lib.org/articles/#ref3)\] The DSpace authority control system is documented in [https://wiki.duraspace.org/display/DSPACE/Authority+Control+of+Metadata+Values](https://wiki.duraspace.org/display/DSPACE/Authority+Control+of+Metadata+Values)  
\[[4](https://journal.code4lib.org/articles/#ref4)\] Documented in [https://wiki.duraspace.org/display/DSPACE/Author+Profiles+XMLUI](https://wiki.duraspace.org/display/DSPACE/Author+Profiles+XMLUI) and [https://github.com/DSpace/DSpace/pull/668](https://github.com/DSpace/DSpace/pull/668)  
\[[5](https://journal.code4lib.org/articles/#ref5)\] Originally developed by Cineca ([http://www.caspur.it/](http://www.caspur.it/)) is an open source extension of DSpace that includes CRIS functionality. Documented and available for download at [https://wiki.duraspace.org/display/DSPACECRIS/DSpace-CRIS+Home](https://wiki.duraspace.org/display/DSPACECRIS/DSpace-CRIS+Home)  
\[[6](https://journal.code4lib.org/articles/#ref6)\] [https://www.openaire.eu/h2020openaccess/](https://www.openaire.eu/h2020openaccess/)

## References

Sabater-Mir, J. and Sierra, C. (2005) Review on computational trust and reputation models. Artificial Intelligence Review, 24:33–60.

Osman, N., Provetti, A., Riggi, V., and Sierra, C. (2014) MORE: Merged Opinions Reputation Model. In Proceedings of the 12th European Workshop on Multi-agent Systems (EUMAS 2014). Springer.

Callaway, E. (2016) Open peer review finds more takers. Nature 539, 343. doi:10.1038/nature.2016.20969

## About the Authors

Pandelis Perakakis is Director of Open Scholar CIC, UK, and researcher at Mind, Brain and Behaviour Research Centre (CIMCYC), Universidad de Granada, Spain

Agnes Ponsati works at the Spanish National Research Council as Director of the Unit of Information Resources for Research, and manages the library and scientific Information resources as a supportive infrastructure for research, dealing with the Open Access policy and the Institutional Repository DIGITAL.CSIC.

Isabel Bernal manages DIGITAL.CSIC, institutional repository of the Spanish National Research Council.

Carles Sierra is chancellor of the Artificial Intelligence Research Institute, IIIA-CSIC, Campus UAB, Bellaterra, Catalonia, Spain.

Nardine Osman, is a reseacher at Artificial Intelligence Research Institute, IIIA-CSIC, Campus UAB, Bellaterra, Catalonia, Spain.

Concha Mosquera-de-Arancibia, is researcher and editor of the Spanish Oceanography Institute and coordinator of e-IEO repository.

Emilio Lorenzo, is Director at Arvo Consultores, a Spanish company of digital repositories solutions.
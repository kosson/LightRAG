---
title: "Building Strong User Experiences in LibGuides with Bootstrapr and Reviewr"
source: "https://journal.code4lib.org/articles/15182"
author:
  - "Randal Sean Harrison"
published: 2020-05-11
created: 2025-01-10
description: "With nearly fifty subject librarians creating LibGuides, the LibGuides Management Team at Notre Dame needed a way to both empower guide authors to take advantage of the powerful functionality afforded by the Bootstrap framework native to LibGuides, and to ensure new and extant library guides conformed to brand/identity standards and the best practices of user experience (UX) design. To accomplish this, we developed an online handbook to teach processes and enforce styles; a web app to create Twitter Bootstrap components for use in guides (Bootstrapr); and a web app to radically speed the review and remediation of guides, as well as better communicate our changes to guide authors (Reviewr). This article describes our use of these three applications to balance empowering guide authors against usefully constraining them to organizational standards for user experience. We offer all of these tools as FOSS under an MIT license so that others may freely adapt them for use in their own organization."
tags:
  - "clippings"
---
# Building Strong User Experiences in LibGuides with Bootstrapr and Reviewr
Randal Sean Harrison

With nearly fifty subject librarians creating LibGuides, the LibGuides Management Team at Notre Dame needed a way to both empower guide authors to take advantage of the powerful functionality afforded by the Bootstrap framework native to LibGuides, and to ensure new and extant library guides conformed to brand/identity standards and the best practices of user experience (UX) design. To accomplish this, we developed an online handbook to teach processes and enforce styles; a web app to create Twitter Bootstrap components for use in guides (Bootstrapr); and a web app to radically speed the review and remediation of guides, as well as better communicate our changes to guide authors (Reviewr). This article describes our use of these three applications to balance empowering guide authors against usefully constraining them to organizational standards for user experience. We offer all of these tools as FOSS under an MIT license so that others may freely adapt them for use in their own organization.

## Introduction

At Notre Dame’s Hesburgh Libraries, one of our subject librarians’ primary roles is to curate and serve research resources to patrons. Librarians had used the [Library-a-la-Carte](https://github.com/griggsk/Library-a-la-Carte) platform for this until it [reached end-of-life](https://libraryh3lp.blogspot.com/2013/06/library-la-carte-resurrected-open.html) in 2015. At that point, librarians at Notre Dame were making limited use of their Library-a-la-Carte guides during research consultations and information instruction, but found the usability of the platform made it difficult to update their guides with new resources frequently. An informal survey at that time found that most avoided updating their guides altogether. This typically resulted in librarians creating a single subject guide, structured as a too-exhaustive, single-page list, which was made to serve patrons regardless of situational or instructional needs.

The adoption of the [Springshare LibGuides 2.0 CMS](https://www.springshare.com/libguides/) (LibGuides) in 2015 was meant to improve librarians’ ability to serve patrons by offering a platform in which they found it easy to create and powerfully customize a variety of guides to suit a range of research and instructional needs, including *general*– and *specific subject* guides, *how-to* guides, *reference and general purpose* guides, *course* guides, and *internal* guides.

Soon after the launch of LibGuides at Notre Dame, I was hired and asked to chair the LibGuides Management Team (LMT) and lead the effort to port all extant guides from the Library-a-la-Carte platform to LibGuides. Before migration, the LMT’s work began with the creation of a digital [Guides Handbook](https://ndlib.github.io/libguides-handbook/), in which we outlined possible guide types, processes for guide creation, and library brand and identity standards. The handbook also offered guide authors a primer in best practices when [writing for the web](https://randal-sean-harrison.github.io/handbook/help-web-writing.html) and offered an abridged list of design principles from the [UX Myths website](https://uxmyths.com/). Once the guide was finalized, the LMT used it to lead internal training on authoring in LibGuides for all internal stakeholders.

One of LibGuides’ most useful features is that it enables Librarians to embed direct links to print and electronic resources hosted by the library and affiliates. \[[1](https://journal.code4lib.org/articles/#note1)\] LibGuides is also built on the [Twitter Bootstrap 3.x.x](https://getbootstrap.com/docs/3.3/) mobile-ready frontend framework—a set of HTML interface elements and CSS and Javascript libraries which offer an extensive set of device agnostic user interface elements. Basing the LibGuides frontend on Bootstrap, Springshare ensured that LibGuides authors also had access to these Bootstrap interface elements (e.g., *accordions*, *alerts*, *tables*, and *tabs and pills*, etc.) all of which work seamlessly when embedded directly in the LibGuides Rich Text/HTML Box object.

However, because most subject librarians at Notre Dame were not comfortable with writing or even editing the HTML or CSS needed for complex Bootstrap interface elements, they did not immediately take advantage of the [affordances](https://www.interaction-design.org/literature/topics/affordances) and [preattentive attributes](https://www.interaction-design.org/literature/article/preattentive-visual-properties-and-how-to-use-them-in-information-visualization) afforded by Bootstrap. To make it easier for librarians to use these Bootstrap elements, we included in the next iteration of the Guides Handbook approximately 15 digital tools to build the customized code for the Bootstrap interface elements we felt might be most useful to guide authors. These included *accordions*, *alerts*, *buttons*, *labels*, *blockquotes*, *code wells*, *columns*, *jumbotrons*, *responsive Google Docs, Sheets and Slides*, *custom icons*, *labels*, *lists and media lists*, *panels*, *responsive images and videos*, *tables*, and *tabs/pills*. In the following iteration of the Guides Handbook, these tools were removed, improved, and combined with approximately 10 more tools—including *carousels*, *checklists*, *forms*, *Font Awesome icons*, *Glyphicons*, *modals*, *popovers*, and even whole *pages*—to create the stand-alone [Bootstrapr](https://bootstrapr.io/) application.

As guide authors began to create a wider range of guides and experiment with using Bootstrapr to add powerful new interface elements, the conformity of guides to library brand and identity standards—which had existed strongly when we first worked closely with authors to port their guides from Library-a-la-Carte to LibGuides—began to suffer. The LMT recognized the need for a way to ensure both new and extant guides conformed to a basic set of standards. We settled on a minimum set of required metadata and used it to develop the [Reviewr](https://reviewr.tech/) application, which we used to remediate guides directly and communicate those changes to guide authors effectively and efficiently.

Below I will describe in greater detail the deployment of this three-part web solution which consisted of the Guides Handbook, and the Bootstrapr and Reviewr apps.

## Guides Handbook

Because the *Guides Handbook* contained not only style and structure requirements but eventually tools for creating added functionality in the form of Bootstrap interface elements, the LMT needed to provide access to the *Guides Handbook* at authors’ point of need. We tackled this in three ways.

First, we placed a permanent alert in the author’s Announcements box on the user’s home page. This announcement held a link to the *Guides Handbook*, as well as an image of the location of the button to access the handbook from within the guide creation page. (Figure 1)

![](https://journal.code4lib.org/media/issue48/harrison/Figure01.png)  
**Figure 1.** A permanent alert linking to the *Guides Handbook*.

The *Guides Handbook* offered a checklist for guide creation for each of the guide types. (Figure 2) Therefore, we also placed an alert on the guide creation page inside a box labeled “Instructions.” (Figure 3)

[![](https://journal.code4lib.org/media/issue48/harrison/Figure02.png)](https://journal.code4lib.org/media/issue48/harrison/Figure02-full.png)  
**Figure 2.** Checklist for guide creation.

![](https://journal.code4lib.org/media/issue48/harrison/Figure03.png)  
**Figure 3.** Guide creation page alert and link.

Finally, we used the [jQuery](https://jquery.com/) framework \[[2](https://journal.code4lib.org/articles/#note2)\] that Bootstrap is built upon to prepend a Guides Handbook link-button to the LibGuides Mini Command Bar \[[3](https://journal.code4lib.org/articles/#note3)\] on the guide editing page. (Figure 4)

![](https://journal.code4lib.org/media/issue48/harrison/Figure04.png)  
**Figure 4.** Link button on the LibGuides Mini Command Bar.

The jQuery required to prepend the button to the menu was embedded at the system level, under the Admin > Look & Feel > Custom JS/CSS menu \[[4](https://journal.code4lib.org/articles/#note4)\]. (Figure 5)

[![](https://journal.code4lib.org/media/issue48/harrison/Figure05.png)](https://journal.code4lib.org/media/issue48/harrison/Figure05-full.png)  
**Figure 5.** jQuery required to prepend the Handbook link to the Mini Command Bar.

By using all three ways of communicating with guide authors, a link to the Guides Handbook was made available at every point in the guide creation cycle. For maximum connectivity, a link to the Bootstrapr application was also prominently located in the main navigation of the Guides Handbook.

## Bootstrapr

The Bootstrapr app was developed to allow guide authors to leverage the improved user experience afforded by the Bootstrap framework to better structure and style their content. Many guide authors at Notre Dame typically work in the WYSIWYG editor rather than the Source Code window. Even librarians with elementary familiarity with HTML and CSS may find it daunting when presented with the level of nesting or the hierarchy of CSS classes required for sophisticated Bootstrap elements such as *accordions*. (Figure 6)

[![](https://journal.code4lib.org/media/issue48/harrison/Figure06.png)](https://journal.code4lib.org/media/issue48/harrison/Figure06-full.png)  
**Figure 6.** Example of a two-panel Bootstrap accordion component.

This results in something I informally refer to as the “coding gap,” by which I mean something analogous to the distance between the ability to understand and the ability to speak when learning a foreign language. Many students of a new language inhabit an arc wherein their ability to understand in the target language, which linguists term “comprehensible input,” at first outstrips their ability to produce in the target language, which linguists term “comprehensible output” (UNC Chapel Hill). This phenomenon is sometimes based on the rise of an “affective filter” which Chametzky describes as “the invisible psychological barrier that raises or lowers depending on a person’s stress level thereby potentially preventing or severely limiting interaction with the task at hand.” Even guide authors with some limited understanding of HTML or CSS, when presented with code structures complex enough to induce anxiety, may choose to abandon using or experimenting with them if they are required to complete or further customize their code.

Bootstrapr was designed to address the rise of the affective filter that exacerbates this coding gap by rebalancing authors’ comprehensible output (writing code) against their comprehensible input (reading code). It does this in several ways:

First, the interface to any Bootstrapr tool, e.g. *accordions*, is designed to move the user along a clear path to completion from left to right in five simple steps. (Table 1 and Figure 7)

**Table 1.** Ordered steps in process of building Bootstrap components.

| Step 1 | For each tool, authors are offered a unique set of non-jargon / human-readable options which they use to customize the interface element. |
| --- | --- |
| Step 2 | Authors then follow a critical path to completion downward to the Build button, which renders the code for the interface element in the code window at right. |
| Step 3 | Authors may then use the Prettify button in the code window to indent the code, radically improving its readability for authors. |
| Step 4 | The code window also uses the Google Sunburst theme to highlight the syntax such that the text nodes—the aspect of any Bootstrap element that most users need to adjust—are white. For the most part, all other “messy” and overly complex code is colored, and can safely be ignored by authors. After each change to the code in the code window, authors can click the Update Example button to see the changes reflected in the Example window. |
| Step 5 | Once authors have fully customized their element to their liking, they can click the Copy button to copy the code with a single click and paste it into any LibGuides rich text box. |

[![](https://journal.code4lib.org/media/issue48/harrison/Figure07.png)](https://journal.code4lib.org/media/issue48/harrison/Figure07-full.png)  
**Figure 7.** Ordered steps in process of building Bootstrap components showing user interface.

The Bootstapr tool thus allows guide authors to utilize a full range of Bootstrap user interface elements, ultimately contributing to a better user experience for patrons. If Bootstrapr represents a tool for expansion and experimentation for guide authors, the Reviewr app represents a tool for standardizing and norming organizational identity.

## Reviewr

The Reviewr app is a small app that aims to ensure that new and extant guides conform to proper metadata, brand, and identity standards. There is parity between the rubric in the Reviewr app and the guide-creation checklist found in the Guides Handbook. Authors are asked to run their own nascent guides through this checklist before submitting their guide to the LMT for approval to publish (Figure 2). However, because the LibGuides platform allows guide authors to create and publish guides at will, sometimes inadvertently bypassing the LMT quality assurance function altogether, and because, in any case, as changes are made to extant guides over time they tend to move out of compliance with brand and identity standards, the LMT instituted periodic screening of all guides.

The Reviewr app was built for this purpose. It allows the LMT and its student workers to rapidly remediate new and extant guides by making changes directly to authors’ guides. Making direct changes to authors’ guides obviates the problem of maintaining a complex system by which necessary changes are described to authors with the hope that they will find time to make these changes. In practice, this opens an entirely different and additional system of surveillance for guide compliance, whereby the LMT must continually badger guide authors to ensure authors are remediating their own guides. This entire additional machinery of tracking and reprimand is obviated by the approach taken with the Reviewr app.

Reviewr is structured simply as a rubric for recording changes made to LibGuides, including remediating subjects and tags, ensuring an omnipresent author profile, ensuring proper information architecture and templating, and requiring human-readable URLs at the guide- and page-level—all of which aims to ensure a richer user experience for patrons and to ensure that changes made to templates will propagate across the LibGuides platform. The Reviewr app also, and perhaps most importantly, allows guide remediators of the LMT to radically increase the speed and standardize the communication channel with which these direct changes are communicated to guide owners. The process is as follows. (Table 2 and Figure 8)

**Table 2.** Ordered steps in process of communication guide remediation.

| Step 1 | Select the guide author from a dropdown. The dropdown is populated from a JSON list. Our JSON file is static, but such data could be read from any API, e.g., a library personnel directory. Selecting the Custom Author option opens additional Guide Author Name and Custom Email Address fields. |
| --- | --- |
| Step 2 | Enter the guide name in the Guide Title field. |
| Step 3 | Toggle on the criterion for each type of change you’ve made to the guide. |
| Step 4 | To view the email text assigned to any criterion, click the information icon next to its brief descriptor. |
| Step 5 | To view where in the guide page to edit the criterion, select its numbered circle. |
| Step 6 | Optionally, add any additional comments. |
| Step 7 | Once all changes have been tracked in Reviewr, click the Email Author button to generate an detailed email to the author. |

[![](https://journal.code4lib.org/media/issue48/harrison/Figure08.png)](https://journal.code4lib.org/media/issue48/harrison/Figure08-full.png)  
**Figure 8.** Ordered steps in process of communication guide remediation showing user interface.

Reviewr then creates a fully formatted email addressed to the guide author. The email thoughtfully and carefully explains each of the changes you made to the author’s guide. Importantly, it also surrounds the description of the changes with scaffolding language such as politeness strategies and opening and closing salutations. (Figure 9) This is especially important when student workers are using Reviewr. Before creating Reviewr, we had found that when a student unknown to a guide author emailed them to tell them they had made changes to the author’s guide, typically without significant context, this introduced sizeable confusion in the process of remediating guides. Reviewr solved this problem in several ways. First, while the email it creates is sent from the student’s email account, the email itself is formally ‘authored’ by the LMT. The Reply To field returns any reply to the LMT listserv, and not to the student worker. Finally, the LMT listserv is cc’d whenever an email is sent to a guide author. This allows us to track the workflow of any student workers, and provides us with an archive of remediation of guides, and communication with guide authors, over time.

[![](https://journal.code4lib.org/media/issue48/harrison/Figure09.png)](https://journal.code4lib.org/media/issue48/harrison/Figure09-full.png)  
**Figure 9.** Example email output produced by Reviewr application.

With Reviewr, LibGuides can be rapidly remediated, keeping consistent focus on agreed upon standards, and obviating the problem of communicating clearly and consistently with authors. Reviewr simplifies this process to the point that it can be confidently assigned to student workers with a high expectation of success and a high rate of turnover for remediating guides. And the carefully chosen language educates authors on the changes made in politic and educative language.

## Conclusion

We find that this three-part suite of web applications has both empowered guide authors to take advantage of the powerful functionality afforded by the Bootstrap framework native to LibGuides, and yet ensured new and extant library guides conformed to brand / identity standards and the best practices of user experience (UX) design.

The Bootstrapr and Reviewr applications have been released under an open source MIT license, allowing for the adoption and adaptation of these apps by any organization which might find similar benefits. Specifically, an organization might choose to modify the parameters of the Reviewr app and/or the specific properties of any Bootstrapr tool to better align with their own brand and identity standards and guide requirements.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] The LibGuides CMS affords direct linking within any guide to books from the library’s catalog, and to databases to which we subscribe.  
\[[2](https://journal.code4lib.org/articles/#ref2)\] jQuery is a relatively light-footprint framework of Javascript and CSS libraries for  
\[[3](https://journal.code4lib.org/articles/#ref3)\]\[[4](https://journal.code4lib.org/articles/#ref4)\] For more information on prepending the button to the mini command bar, see my blog post “[Add a Link to an External LibGuides Handbook](https://randalseanharrison.com/posts/link-to-libguides-handbook.html).”

## References

UNC Chapel Hill. “Learning a Second Language.” [https://learningcenter.unc.edu/tips-and-tools/learning-a-second-language/](https://learningcenter.unc.edu/tips-and-tools/learning-a-second-language/)  
Barry Chametzky, P., 2017. Offsetting the Affective Filter. Grounded Theory Review: An International Journal, 16(1), pp.Grounded Theory Review: An International Journal, 01 June 2017, Vol.16(1). Accessed online [http://groundedtheoryreview.com/2017/06/21/offsetting-the-affective-filter/](http://groundedtheoryreview.com/2017/06/21/offsetting-the-affective-filter/)

*Randal Sean Harrison* is the Emerging Technologies Librarian at the Hesburgh Libraries, University of Notre Dame. There he assists patrons with the identification, evaluation, and use of emerging technologies, innovative online tools, and related services. A significant part of his work involves the creation of applications to help both librarians and patrons more efficiently and effectively navigate online information spaces. He is always eager to collaborate with other Librarians on ways to drive greater user experience in digital tools. You can find information on current projects and how to contact him at [randalseanharrison.com](http://randalseanharrison.com/).
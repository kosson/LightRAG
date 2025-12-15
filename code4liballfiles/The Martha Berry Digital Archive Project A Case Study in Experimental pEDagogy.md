---
title: "The Martha Berry Digital Archive Project: A Case Study in Experimental pEDagogy"
source: "https://journal.code4lib.org/articles/6823"
author:
  - "[[The Code4Lib Journal]]"
published: 2012-06-25
created: 2025-01-10
description: "Using the Martha Berry Digital Archive Project as an exploratory case study, this article discusses experimental methods in digital archive development, describing how and why a small project team is leveraging undergraduate student support, a participatory (crowdsourced) editing model, and free and open source software to digitize and disseminate a large documentary collection."
tags:
  - "clippings"
---
# The Martha Berry Digital Archive Project: A Case Study in Experimental pEDagogy
Stephanie A. Schlitz, Garrick S. Bodine

Using the Martha Berry Digital Archive Project as an exploratory case study, this article discusses experimental methods in digital archive development, describing how and why a small project team is leveraging undergraduate student support, a participatory (crowdsourced) editing model, and free and open source software to digitize and disseminate a large documentary collection.

## Introduction

Housed and maintained by the Berry College Archives at Berry College in Rome, Georgia, the Martha Berry Collection comprises over 160 file boxes, each containing somewhere between two and more than fifteen file folders. Spanning the years 1885 to 1941, the collection, which is primarily epistolary, is organized chronologically by year and therein folders are indexed alphabetically by author. Perhaps half of the documents were written by Berry College’s founder, Martha Berry, the remainder by a profoundly diverse set of correspondents, including school children, business leaders, philanthropists, literary figures, friends, politicians, heads of state, and educators.

As recently as spring 2011, the collection was extant exclusively in its original print format.  Document-level bibliographic descriptions and metadata did not exist, and the inherited collection-level index, which consisted of a word processor document containing a serial listing of each file box and its approximate contents, was unreliable. The collection’s bibliographic state precluded broad access, and, materially, the documents were at considerable risk of deterioration. Despite these challenges, stakeholders at all levels agreed the collection must be digitally preserved and disseminated.

The fact that the digitization process can be technically demanding, time-consuming, and expensive is not only invisible to many stakeholders and end-users, but also to some extent immaterial. If we want our collections disseminated, discoverable, and used, we have little choice but to embrace and leverage the digitization process, perhaps especially when significant impediments exist.

In the specific case of the Martha Berry Digital Archive (MBDA) project, restrictive budgets, limited staff, and a large number of unedited documents presented us with an opportunity to explore methodological innovations and to pioneer new methods of archival development that would support not only the Berry project but also creators and stewards of other collections who are confronted with similar resource challenges. We adopted an approach which designates experimentation and archival development as equivalent in importance to our project end goal, the digital archive itself. This case study describes three experimental, process-driven decisions we’ve made to advance development, including platform selection,  hiring and training undergraduates, and designing and developing a participatory (i.e. crowdsourced) editing model.\[[1](https://journal.code4lib.org/articles/#note1)\]

## Platform Selection

MBDA required selection of an infrastructure that would be user-friendly and non-intimidating to project faculty, staff and students. Project deliverables, which include preservation of the Martha Berry Collection and publication of MBDA, demanded selection of a mature, extensible, and well-maintained platform, a substrate we could customize and extend to serve as an archival hybrid comprising an accessible repository behind-the-scenes and a public-facing, interactive digital archive on the front-end.

*[![Archival Hybrid](https://journal.code4lib.org/wp-content/uploads/2012/05/ScreenCapDigArchDigObjRepImage.png "Archival Hybrid")](https://journal.code4lib.org/wp-content/uploads/2012/05/ScreenCapDigArchDigObjRepImage.png)*

MBDA's hybrid infrastructure requires the advantages of powerful, often complex, digital repositories (such as Fedora Commons) as well as those of common, easy-to-use web publishing platforms (such as WordPress or Drupal) in order to empower non-specialists to make contributions to the underlying repository

Our repository short list included [Fedora Commons](http://fedora-commons.org/), [Drupal](http://drupal.org/), and [Hydra](https://wiki.duraspace.org/display/hydra/The+Hydra+Project), but we ultimately selected Omeka, “a free, flexible, and open source web-publishing platform for the display of library, museum, archives, and scholarly collections and exhibitions”.\[[2](https://journal.code4lib.org/articles/#note2)\] Although in itself not a digital object repository, Omeka’s architecture and extensibility lend it to performing this role admirably. In contrast to robust but arguably less user-friendly digital object repository environments such as Fedora Commons, which does not currently have an extensively built out user interface and which does not have a public facing front-end, Omeka advertises [“five-minute setup,”](http://omeka.org/about/) facilitates web publication, is user-friendly, and comes with pre-configured publishing outputs and themes. The ability to harness existing Omeka plug-ins such as [Dropbox](http://omeka.org/codex/Plugins/Dropbox), [OAI-PMH Repository](http://omeka.org/codex/Plugins/OaiPmhRepository), and [Simple Vocab](http://omeka.org/codex/Plugins/SimpleVocab) further contributes to Omeka’s appeal.

Yet perhaps more important to our venture is the fact that Omeka has a relatively mature, open plug-in architecture and its layout is thoroughly themable. The Omeka project’s open-source nature makes it possible, without having to start from scratch, to build features for MBDA’s unique use cases that don’t currently exist in any of the archive and publishing systems we considered. Developing new functionality as a plug-in, as opposed to simply modifying or forking the Omeka codebase, allows us to program in parallel with Omeka’s future directions in a more predictable and less conflicting way, i.e. we can continue to take advantage of future improvements to Omeka’s core without contamination from our separate codebases, ensuring a relatively clear upgrade path for both the plug-in and the core Omeka system it runs on.

Omeka’s API is exposed to plug-in developers via numerous functions, hooks, and filters documented on the [Omeka website’s documentation wiki](http://omeka.org/codex/Documentation). While from a programming perspective the documentation of particular features varies in scope from extensive to absent, there is an active community of developers and users whose work and listserv discussions remain a point of reference for MBDA. And Omeka’s cooperative documentation model allows us to reciprocate by filling in the gaps in documentation we’ve had to bridge along the way.

## Imaging

### Student-driven imaging model

Berry College is a small liberal arts school with a student population of less than 2000. The school’s comprehensive work study program, which offers meaningful, real-world employment to every student who is willing to work, is a hallmark of the Berry experience and one of Martha Berry’s enduring legacies. Training and paying undergraduate students to image their school’s eponymous collection was not merely a practical and affordable solution, it was a strategic one. Our student-driven imaging model is designed to achieve MBDA-specific goals and to expand them by supporting collaborative, experiential-based learning and an opportunity for undergraduates to create links between their study in subjects such as literature and history and [their work](http://crowd-ed.org/augustus-o-bacon/) with primary source documents in the Martha Berry Collection.

### Workflow documentation

Imaging can be demanding, tedious work, and its critical importance to document preservation and to the digital archive lifecycle cannot be overemphasized. Because document scans are the backbone of MBDA, attention to detail, accuracy and vigilant documentation during the scanning process are paramount. Acknowledging the challenges inherent to imaging and seeking to ensure the success of our student participants, we created and vetted an imaging priority list which identifies a thematically coherent sub-set of the Martha Berry Collection to serve as a preliminary ‘core sample’ for development, test, and initial publication and we devoted several weeks to hands-on, document-level imaging workflow design.

Design and documentation of every step within the imaging workflow was essential, and, among other details, our model includes:

- limiting scanning shifts to 1 to 2 hours
- use of a priority guide to identify which box and folder to scan
- how to handle fragile, hundred-year old documents
- filenaming conventions which create a one-to-one correspondence between a digital object and its material exemplar
- how to save to the project’s remotely accessible file share
- documenting for other members of the scanning team where a shift started and stopped in document terms

The MBDA imaging guide is both meticulous and concise, including step-by-step instructions, a screen capture to illustrate nearly every step of computer-based functions, and beginning and end of process reminders. Students tested and critiqued the guide for ease of use (*could they follow the instructions on their own*?) and clarity (*were there any ambiguities*? *did they need additional visuals*?), and we edited accordingly. We also created ancillary materials including a spreadsheet for overall progress tracking and another for day-to-day documentation.

[![Page 2 of MBDA’s Imaging Guide](https://journal.code4lib.org/wp-content/uploads/2012/05/Page2MBDAImagingGuide-300x243.png "Page 2 of MBDA’s Imaging Guide")](https://journal.code4lib.org/wp-content/uploads/2012/05/Page2MBDAImagingGuide.png)

Page 2 of MBDA’s Imaging Guide

We monitor progress, quality, and accuracy, and a Berry College Library staff member provides general oversight. However, the Berry College undergraduate imaging team has, since June 2011, been managing the imaging process largely independently, has continued virtually error free, and has successfully trained new student participants.

### From imaging to digital archive

Document scans are processed and uploaded to the MBDA development site via a simple multi-step workflow. The workflow begins with a mogrification script which generates JPEG derivatives (compressed image files suitable for web-based archival usage) from the original TIFF-formatted images created by the scanning team (and retained by the Berry College Archives as official, uncompressed digital representations of documents). Once the images are mogrified, we FTP files from their storage location at Berry College to the development server at Bloomsburg University and change the file permissions to enable ingestion within the development site. Together, mogrification and FTP batch upload subvert the need for individualized/manual image manipulation or upload.

Next, in order to edit and publish a scanned document within MBDA, it must be converted to an *item* (*item*, in Omeka parlance, is analogous to the frequently used term *digital object*) and assigned a unique identifier (*item number*) and item-specific constituents (e.g. Dublin Core metadata, tags, associated binary or media files, etc.). We use the [Dropbox](http://omeka.org/codex/Plugins/Dropbox) plug-in to automate the conversion process so that once image derivative files are batch uploaded to the appropriate folder within the MBDA database, we can use a simple ‘check box’ interface to select hundreds of files for simultaneous, automated conversion. As files are converted, each is assigned the requisite item number and constituents, as well as any universal tags we ascribe.

Because documents in the Martha Berry Collection share several descriptive characteristics, we also modified the Dropbox plug-in so that as files are converted to items, some single-value, archive-wide metadata fields are auto-populated. For example, metadata for the [Dublin Core (DC)](http://dublincore.org/) element fields *language* (all the documents in the collection are in English), *identifier* (the identifier for MBDA items is based on their physical filing location within the collection, and the file name given to each scanned image is aligned with this location), *source* and *publisher* (both Berry College) is automatically entered as items are created.

In parallel with our student-driven imaging model, we designed a metadata editing scheme, developed detailed documentation, and hired and trained a small team of undergraduate students as digital editors. Once document scans are ingested within the digital archive, student editors can review documents, contribute DC metadata, and match orphaned documents with their parents to ensure that multiple pages of the same document are reunited in the virtual world. Students are able to reunite the pages of a document despite the fact that every document scan (most often in the case of MBDA documents, this is a single side of a single page) is mogrified and then batch uploaded as an individual document even if it represents but one page of a lengthier multi-page document. We also created a *flag for review* element (discussed below) so that if editors identify an important document, an image problem, a filenaming error, or other issue while they’re editing, they can easily flag it for administrative review.

## Experimental pEDagogy

Platform selection, dev site development \[[3](https://journal.code4lib.org/articles/#note3)\], and implementation of the imaging workflow served as the first steps toward liberating the Martha Berry Collection from its locus *in situ* and behind closed doors (a significant milestone where stakeholders are concerned) and laid the foundation for more serious and more adventurous design and development, including a participatory editing model and accompanying Omeka plug-in.

### Why participatory editing?

The Martha Berry Collection contains many, many thousands of documents. Although we had prioritized boxes for imaging, we were well aware that any box within the collection may prove as important as any other. The absence of comprehensive documentation to describe the collection meant that we couldn’t predict where the documentary gems may be hidden, and we recognized that our stage one project goals must include creating the kinds of exposure and interactivity that could also support document-level description. In short, we needed to leverage this preliminary stage to get the collection catalogued.

While some in the academic community remain skeptical about crowdsourcing, for over a decade, Crane has been making the case for the expansion of editing beyond academia, and projects like [Transcribe Bentham](http://www.ucl.ac.uk/transcribe-bentham/), [NASA’s Map Mars](http://beamartian.jpl.nasa.gov/maproom#/WhyMapMars), [Investigate your MP’s Expenses](http://mps-expenses.guardian.co.uk/), and most recently the [National Archives Citizen Archivist](http://www.archives.gov/citizen-archivist/transcribe/) project reveal the immense, sustained interest in finding ways to involve the larger community in activities which have traditionally been restricted to the domain of scholarship.\[[4](https://journal.code4lib.org/articles/#note4)\]\[[5](https://journal.code4lib.org/articles/#note5)\] From our perspective, not only did MBDA stand to gain from crowdsourcing, we considered our experimentation an opportunity to advance emerging participatory editing practices and to carve new inflections to expand their utility.

### Leveraging and extending Omeka

Consistent with the [Open Archives Initiative Protocol for Metadata Harvesting](http://www.openarchives.org/pmh/), Omeka supports the DC descriptive metadata standard by providing a pre-configured set of DC element fields for manual or auto-generated population. Using the [Simple Vocab](http://omeka.org/codex/Plugins/SimpleVocab) plug-in, we developed controlled vocabularies for seven DC elements, including:

1. Source: *Martha Berry Collection*
2. Publisher: *Berry College Memorial Library*
3. Rights: *Creative Commons, Attribution, Non-Commercial, No-Derivatives*
4. Format: *image-jpeg*
5. Language: *English*
6. Identifier: *MB75\_4\_1\_1*
7. Coverage: *Mount Berry, Georgia*

These element fields are automatically populated during initial object ingestion as described above. For collections where existing metadata is already available, Omeka does have an [OAI-PMH Harvester plug-in](http://omeka.org/add-ons/plugins/oai-pmh-harvester/), which could perform largely the same function.

A sub-set of DC elements, however, requires individualized document review and manual description, including:

1. Title
2. Description
3. Creator
4. Date
5. Type

To facilitate administrative oversight and document searching and to buttress later stage tasks for MBDA (which, as noted above, is a collection of letters to and from Martha Berry), we defined a new Omeka *Item Type*: *correspondence*, which contains the elements *script type* (e.g. *typewritten* or *handwritten*) and document *recipient* in addition to the existing Omeka *document*\-related metadata.

Our newly-developed plug-in, Crowd-Ed \[[6](https://journal.code4lib.org/articles/#note6)\], also adds a new element set to Omeka: *Crowdsourcing Metadata*. The *Crowdsourcing Metadata* element set includes new metadata features related to crowdsourcing, such as *enable crowdsourcing* (i.e. whether or not to enable crowdsourcing for a given item) and *flag for review* (i.e. community participants and project staff can flag an item for administrator review and identify either a specific or general reason for the flag).

Description of the DC elements *title*, *description*, *creator*, *date*, and *type* as well as *flag for review*, *recipient* and *script type* metadata are crucial yet minimally complex aspects of the editing process. Inviting students and community members to edit these, we determined, would aid in cataloging the collection, drive archival development, and provide meaningful editing tasks for participants. The Crowd-Ed plug-in thus enables students and community members to participate in editing these eight elements (as shown in the screen capture below), respects the controlled vocabulary set by site administrators (using the Simple Vocab plug-in), and provides site administrators the ability to choose which other Omeka elements are available for community editing.

[![Screen Capture of Current Version of Crowd-Ed Participatory Editing Interface ](https://journal.code4lib.org/wp-content/uploads/2012/05/CrowdEdInterfaceMay12-277x300.png "Screen Capture of Current Version of Crowd-Ed Participatory Editing Interface ")](https://journal.code4lib.org/wp-content/uploads/2012/05/CrowdEdInterfaceMay12.png)

Screen Capture of Working Prototype of the Crowd-Ed Participatory Editing Interface

### Developing the Crowd-Ed plug-In

In planning MBDA’s participatory editing model, we identified two main additions to the archive’s underlying Omeka infrastructure required for our use-cases: a plug-in to provide extensive crowdsourcing functionality, and a custom, grid-based theme to simplify layout design, especially as a basis for the crowdsourcing plug-in’s rather complex editing forms and layout requirements.

Like most repository and archival publishing applications, Omeka has been limited to an administrator-driven editing model. This means that once documents are uploaded or ingested into an Omeka instance, edits can be made to items and their constituents exclusively by administrators. In many archival use cases, this data separation model, which delivers item content unidirectionally to end-users, is ideal. But in a participatory editing use case, which relies on students and community members to populate a set of defined metadata categories, facilitated, bidirectional communication is essential. By mediating bidirectionally between the digital archive and its end-users, Crowd-Ed’s design model extends the archive’s utility to enable guided, community-based, participatory editing.

From a user perspective, Crowd-Ed simply presents editable forms that make it possible for authenticated site users to contribute information to the archive metadata for the crowdsourcing enabled items they encounter while browsing or searching the archive. When the Crowd-Ed plug-in is installed and enabled, users who are logged in are presented three paths to engage with the archive from the archive’s home page: *browsing* all of the published items in the archive, *searching* for particular items using metadata categories, or *participating* in the development of the archive.

*[![Screen Capture of (in-progress) MBDA Development Site Home Page (marthaberry.org)](https://journal.code4lib.org/wp-content/uploads/2012/05/MBDAHomePageScreenCap-300x210.jpg "Screen Capture of (in-progress) MBDA Development Site Home Page (marthaberry.org)")](https://journal.code4lib.org/wp-content/uploads/2012/05/MBDAHomePageScreenCap.jpg)*

Screen Capture of (in-progress) MBDA Development Site Home Page (marthaberry.org)

[![Screen Capture of Browse Items Display](https://journal.code4lib.org/wp-content/uploads/2012/05/ItemDisplayListMay12-233x300.png "Screen Capture of Browse Items Display")](https://journal.code4lib.org/wp-content/uploads/2012/05/ItemDisplayListMay12.png)

Screen Capture of Browse Items Display

[![Display of Individual Item](https://journal.code4lib.org/wp-content/uploads/2012/05/IndividualItemDisplayMay12-300x232.png "Display of Individual Item")](https://journal.code4lib.org/wp-content/uploads/2012/05/IndividualItemDisplayMay12.png)

Display of Individual Item

The Crowd-Ed plug-in creates links to an item’s crowdsourcing interface on each displayed item to allow an authenticated public user to contribute information at any time. If a user chooses to follow the *participate* path, further explanation is given regarding the purpose and intents of MBDA crowdsourcing, as well as instructions on how the user may participate in the most urgent or essential aspects of the project. Users who do not have logins are directed to the *create account* page where they must create a new account before participating in editing tasks.

Because the Crowd-Ed interface allows non-administrative users to add and edit information in the crowdsource-enabled fields, the MBDA project had to create custom validation routines (using Omeka’s built-in validation hooks where possible) to allow for security and content control.  We are currently developing audit trail and archiving functionality to complete the safety features and to ensure continuity should there be an issue with ‘crowd control.’

In order to provide this outer layer of functionality, Crowd-Ed takes advantage of another important aspect of Omeka’s extensibility: the fact that it’s built on the very powerful open-source *Zend* PHP framework and library. This means that any objects or methods available from the *Zend* framework are also available to Omeka plug-ins as native functionality. The functionality provided by the library enables us to record who changed what data from what value for which item at which time. It also provides site administrators with the ability easily to revert any changes made via the crowdsourcing plug-in.

### Flash mobs?

By scaling out the editing process to support community-contributed metadata, Crowd-Ed solves an important archival development problem. Even so, we acknowledge that engaging part-time, voluntary editors as remote partners in an archival project introduces unique challenges where accuracy and continuity are concerned. But for MBDA, crowdsourcing has never been synonymous with ceding control or relinquishing quality. By contrast, Crowd-Ed is being designed to guide contributors’ efforts and to prevent potential inconsistencies in keywording or encoding. We’ve defined editing categories that take advantage of non-specialist knowledge (e.g. identification of document author, recipient and date) and have restricted some participant choices via controlled vocabulary. And we are in the process of developing simple and interactive user access points and creating ‘How To’ tutorials.

We also recognize that although crowdsourcing isn’t new, it is relatively new within the archival editing community, and the jury is still out on the value of participatory editing as a method within digital editing projects. While healthy skepticism and astute design schemes are among our best defenses against the unruly flash mobs some critics of crowdsourcing fear, we think it would be a mistake to dismiss the method untested and in doing so to dismiss the possibility of significant advancement and valuable community engagement.

## Teaching Digital Editing = pEDagogy

Although the ‘crowd’ employing our crowdsourcing effort to date has been a small one, our five-student, part-time imaging team has scanned more than 15,000 documents in less than a year, and our three-student, part-time digital editing team has matched thousands of documents and edited hundreds more. Our students are learning about history, language, and politics (as well as their *alma mater*), and they are gaining valuable experience with a primary source collection and digital editing. Their contributions have been integral to development of MBDA, and the once moribund Martha Berry Collection is thriving. While the real test of our methodology won’t begin until we advance beyond the development stage and begin public participatory editing this fall, MBDA is already being discussed in college classrooms, explored by historians, and is serving as a pilot collection for innovations in OCR and transcription (up next on our to do list).

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Within the digital editing community, *participatory editing* is used as a *de facto* designation for the *crowdsourcing* of various editing tasks. This discussion uses *participatory editing* and *crowdsourcing* interchangeably to describe engaging students, community members, and the broader public in digital editing tasks.

\[[2](https://journal.code4lib.org/articles/#ref2)\] About. \[Internet\]. Omeka. \[cited 2012 April 5\]. Available from: [http://omeka.org/about/](http://omeka.org/about/)

\[[3](https://journal.code4lib.org/articles/#ref3)\] In the spirit of transparency, to facilitate testing, and to permit pre-publication use within several college classes, we elected to leave the dev site open for the duration of the development lifecycle, despite the challenges doing so creates.

\[[4](https://journal.code4lib.org/articles/#ref4)\] Crane, Gregory and Jeffrey A. Rydberg-Cox. New Technology and New roles: The need for Corpus Editors. In: *ACM 2000 Digital Libraries: Proceedings of the Fifth ACM Conference on Digital Libraries*; 2000 June 2-7; San Antonio, Texas. p. 252-253. Available from: [http://hdl.handle.net/10427/57002](http://hdl.handle.net/10427/57002)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Crane, Gregory. Give Us Editors! Re-inventing the Edition and Re-thinking the Humanities \[Internet\].  In: McGann, Jerome, editor. *Online Humanities Scholarship: The Shape of Things to Come*. Connexions Website. 8 May 2010. Available from: [http://cnx.org/content/col11199/1.1](http://cnx.org/content/col11199/1.1)

\[[6](https://journal.code4lib.org/articles/#ref6)\] Our first task was to architect and implement the Crowd-Ed plug-in. Having done so, we’re currently working on somewhat less difficult (at least from a technical stance) though no less important (functionally) issues such as interface styling, testing, and end-user help text and tutorials. We anticipate the beta release of the Crowd-Ed plug-in during summer 2012.

Stephanie A Schlitz, a Berry College alumna, is an Associate Professor of Linguistics at Bloomsburg University of Pennsylvania and Director of the Martha Berry Digital Archive Project. Her email address is [sschlitz@bloomu.edu](https://journal.code4lib.org/articles/).

Garrick S. Bodine is an IT Manager for a software development team at Pennsylvania State University-University Park and lead programmer for the Martha Berry Digital Archive Project.
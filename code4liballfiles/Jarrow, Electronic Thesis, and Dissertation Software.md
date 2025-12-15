---
title: "Jarrow, Electronic Thesis, and Dissertation Software"
source: "https://journal.code4lib.org/articles/7486"
author:
  - "[[The Code4Lib Journal]]"
published: 2012-10-03
created: 2025-01-10
description: "Collecting and disseminating theses and dissertations electronically is not a new concept. Tools and platforms have emerged to handle various components of the submission and distribution process. However, there is not a tool that handles the entirety of the process from the moment the student begins work on their thesis to the dissemination of the [...]"
tags:
  - "clippings"
---
# Jarrow, Electronic Thesis, and Dissertation Software
James R.W. MacDonald, Daniel Yule

Collecting and disseminating theses and dissertations electronically is not a new concept. Tools and platforms have emerged to handle various components of the submission and distribution process. However, there is not a tool that handles the entirety of the process from the moment the student begins work on their thesis to the dissemination of the final thesis. The authors have created such a tool which they have called Jarrow. After reviewing available open-source software for theses submission and open-source institutional repository software this paper discusses why and how Jarrow was created and how it works. Jarrow can be downloaded and the project followed at [http://code.library.unbc.ca](http://code.library.unbc.ca/).

## Introduction

This article examines the development of an Electronic Thesis and Dissertation (ETD) software module, Jarrow, built for Drupal \[[1](https://journal.code4lib.org/articles/#note1)\] and the selection of Islandora as the digital institutional repository software at the University of Northern British Columbia (UNBC). The article also provides an overview of available software, largely open-source, for managing theses submissions.

The University of Northern British Columbia (UNBC) is a small, research-intensive university. Over the last 4 years, graduate students at the school have produced an average of 77 masters level theses and three doctoral dissertations each year. The average thesis, about 115 pages, represents a significant amount of work not just from the student in researching and writing, but also from the student’s supervisor, committee and university support staff. Once a student submits their thesis for defense, a flurry of activities over several months takes the manuscript through a process of approvals, revisions, descriptions and finally publication and dissemination to the larger academic world.

Submitting a thesis as a print manuscript at UNBC requires as many as 15 paper forms that must be signed and approved by various individuals: the student’s supervisor, the dean of graduate programs, the registrar, the student’s committee, an external examiner and of course, the student. A date and time must be scheduled for the thesis defense and the university community must be notified of public defenses. Along the way there are dozens of emails between the various actors involved and therefore multiple opportunities for miscommunication and errors. The misspelt name of a committee member on one form or an improperly formatted title page can lead to a cumbersome and sometimes embarrassing correctional process. Submission in print is also costly. Graduate Programs at UNBC spends an estimated $3,500 (CAD) each year on shipping approval forms and theses. Thesis submission and dissemination is a process crying out for automation and electronic processing.

An institutional repository is the final resting place for completed ETDs. When theses are produced in print, that repository is generally the library’s print collection or the university’s archives. When theses or dissertations are produced electronically, a digital institutional repository is required. At UNBC Islandora is the software that has been chosen to support its future repository. ETDs, however, do not magically appear complete with metadata and organized in the repository. Some mechanism or process must organize, describe, and evaluate these items, regardless if they are print or digital.

## Project Planning

Following software industry best practices, the first phase of development was requirements gathering. Identifying software solutions that can meet the needs of a complicated and policy driven process like thesis submission requires an in-depth understanding of the current process and its evolution. The library managed the development of the ETD project but the business logic of ETD submissions is the responsibility of Graduate Programs. The library generally only becomes involved in theses submissions at the very end when the thesis is catalogued and made public. Producing graduate level work involves faculty, librarians, staff and, in the case of an electronic submission process, Information Technology Services. Therefore, identifying a system that will meet the needs and enhance the process requires input from all of these areas. Sharon Reeves of Library and Archives Canada (LAC) and the Networked Digital Library of Theses and Dissertations (NDLTD) provide a step-by-step guide to establishing an ETD submission program. They advocate cross-institutional representation in order to develop a balanced initiative ([Reeves 2010](https://journal.code4lib.org/articles/#cite-Reeves2010)). Therefore, a governing committee and two working teams were created to establish an institutional repository for UNBC and convert the print theses submission process to an electronic process.

## Governance

The steering team is responsible for the overall governance and direction of the project. The dean of Graduate Programs and the University Librarian co-chair this committee. Also on the steering committee are the institution’s Chief Information Officer and Vice President, Research along with the project manager, who chairs the implementation team and serves as a link between the three teams.

The implementation team is comprised of stakeholders from graduate studies, the library and IT. This team is responsible for the actual development of the institutional repository and conversion to an electronic thesis submission process. The team researches and implements best-practices and is responsible for communicating their decisions to the steering team for approval.

The advisory team is a small group (6) of interested faculty and research staff. This group meets at project milestones with members of the implementation team or steering committee to provide feedback on decisions made or yet to be made. Essentially, this team has worked as a standing focus group throughout the development of the project.

## Current Processes

The following flow chart illustrates the print submission process at UNBC as it was in 2012.

[![Image showing the complete submission process at UNBC](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure1_small.png)](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure1.png)  
**Figure 1.** The complete submission process at UNBC.

From this chart, one can begin to understand the complexity of thesis processing. The student, upon approval from their committee and supervisor, delivers the thesis to the graduate office. The graduate office reviews the submitted document for formatting errors and coordinates with the student in an iterative process on any required changes. An external examiner is selected for the thesis defense, the defense is scheduled, and a room is booked before the process of defense can begin. Once a defense is completed the graduate office reviews the thesis again and the student must read and agree to licenses allowing the university, ProQuest and the national library to distribute their work. After all of this a librarian catalogues the work and it is placed in a repository for both preservation and dissemination to the academic community and public. This brief synopsis neglects issues around publication embargoes, selecting a chair for the thesis defense, scheduling a practice defense and many other details.

A graduate office can process, depending on the size of the school, dozens to thousands of theses each year. In many institutions, electronic submission of theses is managed with paper forms and scanned documents. The thesis itself is often delivered to the graduate office over email. Presentations by Angela McCutcheon and Richard Pollenz and Lisa Piazza at the 2011 United States Electronic Thesis and Dissertations Association (USETDA) conference demonstrate the complexity of managing the ETD submission process ([McCutcheon 2011](https://journal.code4lib.org/articles/#cite-McCutcheon2011); [Pollenz and Piazza 2011](https://journal.code4lib.org/articles/#cite-Pollenz_Piazza2011)). Both of these presentations describe methods of organization including file structures, saved email templates, and the design of paper and online forms for managing ETDs.

The ETD submission and approval process is the perfect candidate for an automated or guided online software solution. Several institutions have designed and implemented dynamic form based websites that guide students and faculty through their process and maintain a greater degree of organization over ETD submissions for graduate office staff. For example, in her 2012 USETDA conference presentation Nathalia Bauer highlights how the University of Central Florida (UCF) created a dynamic and logic driven student website when Excel spreadsheets and elaborate file organizations proved insufficient to manage the ETD process ([Bauer 2012](https://journal.code4lib.org/articles/#cite-Bauer2012)). The UCF’s College of Graduate Studies developed this website after failing to find an existing software solution that was flexible enough to meet their needs.Like the University of Central Florida, UNBC also concluded that existing software solutions for managing ETD submissions are not sufficiently flexible to accommodate the processes at UNBC. Existing software ultimately fell short in two areas: 1) the underlying architecture was deprecated or insufficiently maintained, making the software unstable and difficult to work with or 2) the software did not manage the complete ETD submission process. UNBC was interested in a solution that would manage ETD submissions beginning with the first time the graduate office began working with a student. This is typically well before the defense of the thesis and includes the scheduling of the defense. Existing software solutions begin after the successful defense of a thesis at the earliest.

## Existing Software

There are at least 5 open-source software solutions for ETD submission management. They include: ETD-db, TAPIR, Valet, OpenETD and Vireo. The following chart lists open-source software for the management of ETDs and indicates the year of their first public release and their most recent update, giving an approximation of their lifespan.

[![Timeline of Open-Source ETD Software Developments](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure2_small.png)](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure2.png)  
**Figure 2.** Figure 2 demonstrates that although there have been many attempts to create ETD systems, most fail to gain much traction.

Figure 2 demonstrates that although there have been many attempts to create ETD systems, most fail to gain much traction. There are some years in which there were no viable open source options at all, with all of the existing software no longer being maintained (for example, from 2008-2010). This gap clearly motivated the creation of the more modern ETD systems (Vireo and OpenETD), but there is still no software that can handle the entirety of the submission process.

What follows is an overview of some of the past and present attempts at an ETD system along with why UNBC ultimately chose not to use them.

### ETD-db

Virginia Polytechnic Institute and State University (better known as Virginia Tech) was one of the first universities to adopt an electronic process for thesis submission, beginning in the nineties ([Institutions Requiring Electronic Thesis/Dissertation Submissions 2012](https://journal.code4lib.org/articles/#cite-Institutions_Requiring_ETD2012)). In partnership with the Networked Digital Library of Theses and Dissertations (NDLTD) they released the first open-source software designed to handle ETD submissions, ETD-db, in 1999. ETD-db combines a public user submission interface and web management with a searchable database of past-approved submissions. Essentially Virginia Tech’s software combines the submission tool with a small searchable institutional repository of theses. The software is available free of charge from Virginia Tech’s website. There is no formal software license applied to the module ([McMillan 2012](https://journal.code4lib.org/articles/#cite-McMillan2012)).

Unfortunately, ETD-db has not had a major release since 2004. While the software is still in use by Virginia Tech and others, it is dated. ETD-db in short “is a series of webpages and Perl scripts that interact with a MySQL database ([ETD-db: Home 2012](https://journal.code4lib.org/articles/#cite-ETD-db2012)).” This means that customization of the software can be difficult. Perl is a language that UNBC has little institutional expertise in. The application also relies on some older and deprecated code libraries. ETD-db was a seminal work in the ETD field but the underlying architecture requires a greater degree of technical expertise to maintain and customize than is desirable.

### TAPIR

The University of Edinburgh Library developed the Theses Alive Plug-in for Institutional Repositories or TAPIR in 2003 ([Jones 2004](https://journal.code4lib.org/articles/#cite-Jones2004)). It is available under a 3 clause “modified BSD license.” The software focuses heavily on collaboration tools designed to assist students and faculty with the editing and revision of theses. Today, collaboration tools for editing documents are widely available from Word’s track changes to Adobe Reader’s tools for PDF document markup. As such TAPIR’s innovative focus is less relevant.

TAPIR was written in Java and designed as an add-on to DSpace; however, it was created to work with DSpace 1.2. Parts of the DSpace code were modified with TAPIR to deliver some of its core functionality. These changes were not contributed back to the DSpace community. TAPIR is therefore bound to DSpace version 1.2 (five versions and eight years old). This alone makes TAPIR an unlikely candidate for adoption.

### Valet

Visionary Technology in Library Solutions or VTLS inc. developed an open-source ETD submission module named Valet and publicly released it in 2005 ([Rogers 2005](https://journal.code4lib.org/articles/#cite-Rogers2005)). Valet is available under a Mozilla Public License 1.1. Like ETD-db, Valet is a Perl based module but coupled with a Fedora digital repository. The product is best suited when deployed in conjunction with VTLS’ proprietary institutional repository, VITAL ([VALET for ETDs 2012](https://journal.code4lib.org/articles/#cite-VALET2012)). Valet appears not to have released any major update since its initial release in 2005, and has little documentation, making installation and use difficult.

During the summer of 2008, the Australian Research Repositories Online to the World (ARROW) Project, led by Monash University in Australia forked Valet when they created a Java version called Squire, which is also open source ([ARROW\_Contribution 2010](https://journal.code4lib.org/articles/#cite-ARROW2010)). Unfortunately, the Java version appears to have no documentation of any type and has not been updated in almost four years, essentially rendering it unusable.

### OpenETD

OpenETD was developed by Rutgers University in 2010 and is available under the GNU General Public License 3.0. This system is repository agnostic. In other words, the software exports theses and dissertations in a METS/XML compliant file for import into a repository of choice. This is a compelling feature for those not willing to be tied to particular institutional repository software. Built on Linux, MySQL and PHP this ETD solution utilizes better web application architecture than its predecessors. With a host of features such as email notifications, automatic margin and page number detection, and a simple user management this system is quite compelling; however, OpenETD focuses on the post-defense process. The software also offers very limited ability to customize forms or the logic around a submission process.

### Vireo

Vireo is a Java based DSpace plugin developed by Texas Digital Libraries, and is available under a 3 part “modified BSD license ([Vireo ETD Submission and Management 2012](https://journal.code4lib.org/articles/#cite-Vireo2012)).” Vireo was released in 2011 and is under active development. The software’s integration with DSpace, ease of use and ability to make simple system customizations has led to an active user community that is beginning to grow outside of the Texas area. Vireo offers many of the same features Open-ETD does, such as automatic email notifications and templates. Although Vireo handles more of the process than any other system, beginning immediately after defense and handling corrections in addition to basic ingesting, it does not handle any pre-defense procedures, such as scheduling or initial committee approval.

### ProQuest’s UMI Administrator

ProQuest has been in the business of theses and dissertation publishing since 1938. A large number of Academic institutions in North America publish theses and dissertations with ProQuest. As a result they have developed ETD software, UMI Administrator, and offer it free of charge to institutions wishing to publish with them. UMI Administrator is not, however, open source. ProQuest hosts and maintains the software and will customize its interface to reflect the branding of an institution. At the end of the submission process, ProQuest returns theses and dissertations electronically for ingest into local digital repositories. If an institution chooses to use UMI Administrator, their students are no longer required to pay ProQuest’s publishing fees. In cases where an institution pays these fees on behalf of the student the UMI Administrator is extremely compelling.

There are several shortcomings of the UMI Administrator that do not make it suitable for use at UNBC. First, the system only handles the post-defense submission process. Some thought was given to developing a system that would cover the pre-defense submission and then have students use UMI Administrator for the post-defense process. However, this would require students to create a separate account and re-enter all of the meta-data and other details in UMI Administrator. While this is not an insurmountable barrier, it does greatly reduce the simplicity of any chosen process. If ProQuest were to create an API that would allow the transfer of user and thesis data from an open-source system to UMI Administrator, future integration could be possible.

The second significant drawback to using UMI Administrator would be the reliance it creates on a third party for publishing an institution’s theses and dissertations. For many this may not be an issue. However, it is arguable that while ProQuest provides a valuable service, third party control and profiting from publicly funded research should be avoided.

## Selecting Institutional Repository Software

The software selected for storing and disseminating completed theses would have ramifications for nearly any solution to producing electronic theses or dissertations (ETDs). As a result, the project first had to identify appropriate repository software with an eye to automating a thesis submission process. There are many proprietary software solutions for institutional repositories. For example, OCLC’s ContentDM, and Berkley’s BePress offer compelling software platforms. However, regardless of the software chosen (proprietary or open-source) it was believed that the skills of a web-developer would be necessary for this and other projects. Because of financial limitations, UNBC could not both purchase and maintain proprietary software and hire a web-developer. UNBC chose to hire a web-developer. This decision, to hire a web developer, essentially limited the choice of repository software to an open-source solution.

There are many open-source software platforms that could act as an institutional repository (IR). However, the three most popular platforms used by many universities are: DSpace, EPrints and the up and coming platform, Islandora.

### DSpace

DSpace was developed as a joint project between MIT and Hewlett-Packard in 2002, but has since been spun off into its own company: DuraSpace. It is a Java-based product that ships with a built in repository based on either PostgreSQL or Oracle.. The product has wide distribution and is in use at several institutions within British Columbia, including Simon Fraser University and the University of British Columbia. DSpace is arguably the most widely used institutional repository software by universities, especially in North America.

DSpace can be challenging to configure and install, with a multi-stage build and install process, involving a fair amount of knowledge. However, once installed, maintaining and configuring the system is straightforward enough, and is backed by extensive documentation and an active support group. DSpace offers an interface that can be extensively customized using XML, and a standard organizational scheme (Communities are made up of collections are made up of sub-collections are made up of objects).

### EPrints

EPrints was developed at the University of Southampton in 2002. A Perl based IR solution, EPrints is easy to get up and running, and provides an excellent discovery and submission interface. However, configuring anything beyond the standard is quite challenging. The configuration files themselves are Perl scripts. There is decent documentation, but a good understanding of Perl is required to administer the system. EPrints also uses a custom built repository, but supports the standard Simple Web-service Offering Repository Deposit or SWORD interchange protocol, meaning that digital objects can be extracted and shared ([Lewis 2012](https://journal.code4lib.org/articles/#cite-Lewis2012)).

The EPrints community is very active, and support for configuring and maintaining EPrints repositories is readily available. There are, however, no known EPrints installs in Western Canada making it slightly less compelling than it could be for UNBC.

### Islandora

Islandora is a newcomer on the institutional repository software market. Developed at the University of Prince Edward Island in Canada and supported by an independent company, Discovery Garden, Islandora brings together two well-established open-source products: Drupal and Fedora. Because Islandora is built on top of Drupal, all of the necessary content management system (CMS) and application framework components are included. For example, any existing Drupal theme will automatically work with Islandora because it uses standard Drupal components. Furthermore, by leveraging such a well-established and sophisticated CMS like Drupal, Islandora makes it much easier to organize repository collections for public consumption in ways that may be much more challenging for DSpace or EPrints.

Fedora is a well-established open source database for organizing digital objects. Since the DuraSpace Foundation runs both DSpace and Fedora, some software designed for DSpace also works with Islandora. For example, DuraCloud, an off-site backup and preservation module for digital objects, can be used with Islandora. Furthermore, Discovery Garden has recently released a PHP toolkit named “tuque” which allows developers to ingest objects into a Fedora Repository independently of Islandora. This means that any module built with tuque could potentially export into a DSpace Institutional Repository, or conceivably an EPrints one as well, if the tuque library was expanded. The flexibility is a good fit with UNBC’s goal of allowing for change down the road.

Islandora itself is a particularly good fit for UNBC. As this project began, the university just completed an extensive selection process for a new CMS to manage its web presence. Drupal was the CMS chosen. Having institutional knowledge and expertise in Drupal bodes well for the sustainability of a new IR built on Islandora. Furthermore, the university had already invested in Islandora in partnership with the Prince George Public Library to house a digital collection of local newspapers. UNBC has a knowledgable user group to draw on, both internally and with the Prince George Public Library. Both EPrints and DSpace offered compelling and powerful options but in UNBC’s context, the answer is Islandora.

## Developing an Open Software Solution

By far the most important aspect of designing a new software package is picking a good name.  UNBC chose the name Jarrow for its ETD Module.  Jarrow is the name of a monastery in England that boasted an enormous library and was a beacon of enlightenment in the middle ages ([Yule 2012](https://journal.code4lib.org/articles/#cite-Yule2012)); a fitting name for a tool designed to assist with knowledge creation and dissemination.

Having thoroughly investigated existing options for ETD submission, UNBC determined that building its own Drupal module to integrate with Islandora was the only way to satisfy the requirement to handle the entirety of the submission process as well as deal with any varying processes in place. The process for submitting a doctoral dissertation is different from the process for a master’s thesis at UNBC. It is likely that many institutions have significant logical differences in submission workflows for type of a degree, department, or the school the degree is awarded from. An ETD submission module should be flexible enough to accommodate these differences.

In addition to being able to handle multiple workflows, the system must be able to integrate with institutional administration software, such as Banner, reducing the possibility for incorrect metadata entered by students.

Given that the module being built needed to be sufficiently flexible to handle UNBC’s multiple workflows, and is intended to be open source software, it was decided to create a module which any institution could adopt and use as their ETD submission system. In addition to providing a straightforward GUI for creating and managing custom workflows, the software builds on top of Drupal’s module system to allow for institutions to create their own modules to further extend the software’s functionality.

### System Architecture

The workflow management aspect of the software is central to the overall design, as all other features are designed to integrate with it.  The system works much like survey software. Those who have used Survey Monkey, Fluid Surveys or any number of other online survey applications will find Jarrow both familiar and easy to use.  It is comprised of three components, the **Data Model**, the **Form Editor** and the **Process Manager**.

The **Data Model** defines all meta-data and related information about a submission.  This includes everything from the title of the thesis to the date of defense.  If there is a piece of information relevant to a thesis submission, it must be defined in the data model.

[![A demonstration Data Model created for UNBC.  New elements are added by dragging them in from the right and dropping them on the data model in their desired location](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure3_small.png)](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure3.png)  
**Figure 3.** A demonstration Data Model created for UNBC. New elements are added by dragging them in from the right and dropping them on the data model in their desired location.

The **Form Editor** allows the creation of forms to collect the data defined in the data model.  There can be many forms associated with a single data model.

[![The Form Editor.](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure4small.png)](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure4.png)  
**Figure 4.** The Form Editor. This form is generated from the “Thesis Information” data element group visible in Figure 3. Form elements are created by dragging in data elements from the data model (as was done here) or by adding them manually.

The **Process Manager** provides a system for adding logic to the creation, editing, display and approval of forms.

[![The Process Manager.](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure5_small.png)](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure5.png)  
**Figure 5.** The Process Manager. Any forms created in the form editor can be added, along with digital objects to represent supplementary files. Here the pre-submission stage has three forms that must be filled out.

Once an administrator has configured the above, students, faculty and staff members can log into the system and see any submissions that are currently active and with which they are affiliated. For example, a supervisor with multiple graduate students would have access to each of their submissions.  Students can create a new submission, at which point either they or the system will select the type of process they will follow.

Users can edit the information in a form, which is automatically saved as soon as they enter it, although it is not submitted until they specifically choose to submit the form.  The system does not require a particular order for the users to fill out information, any user can fill out any form that they have access to at any time.  The order and number of forms displayed is completely controlled by the administrator through the process manager.

[![An image showing a submission.](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure6_small.png)](https://journal.code4lib.org/media/issue18/MacDonald_Yule/jarrow_figure6.png)  
**Figure 6.** A submission. The form shown in Figure 4 is displayed to the student as dictated by the process in Figure 5.

Once the student and all staff and faculty have completed a workflow by filling out and approving all required forms, the system will deposit the thesis, supplementary files, and meta-data collected along the way into the Institutional Repository, in UNBC’s case Islandora. Jarrow can be adapted to deposit completed theses in any Fedora based repository.  The entire process could take several weeks, as the student will first interact with the system when they begin to ask for approval for scheduling a defense, but Jarrow will guide them through the entirety of the process.

The flexibility of Jarrow was highlighted at the USETDA 2012 conference by the authors ([MacDonald and Yule 2012](https://journal.code4lib.org/articles/#cite-MacDonald_Yule2012)). That presentation complete with screen captures and screen casts is available at [http://code.library.unbc.ca](http://code.library.unbc.ca/).

### Other Features

In addition to the core workflow management system mentioned above, Jarrow has several other features designed to make ETD management easier:

| Date Scheduling | The ETD system provides an availability poll component that can be added to forms to allow for students, committee members and chairs to indicate the times they will be available for a defense. Graduate Programs staff can then choose a date that works for all members. |
| --- | --- |
| License Management | Institutions typically require students to agree to a non-exclusive license for their thesis or dissertation, but may want to allow students to also apply a Creative Commons License, or allow students to apply different licenses to the supplementary files associated with a thesis (such as granting or revoking performance rights for supplementary videos). The system provides the ability to manage all licenses an institution may want to use, and comes with the Creative Commons Licenses pre-installed (although they do not have to be used.) |
| Email Templates | Emails can be sent as part of the submission process, and the ETD system allows for editing email templates including information from a data model in an easy point and click manner. |
| Drupal Integration | Since the system is built as a Drupal module, it can take advantage of Drupal’s rich module ecosystem. Authentication (using LDAP, Cas or Shibboleth), extended profiles using Profile2, or rich text editors for editing email templates, licenses or other text fields through the WYSIWYG module are all available, as well as the extensive theming options provided by the Drupal community or through custom themes. |

The flexibility of the workflow component, Jarrow’s open source nature and Drupal’s modular nature allow for many more features to be added at any stage of the process, either by adding code to Jarrow itself or by writing modules that interact with its many integration points.

## Conclusion

UNBC ambitiously decided to build an ETD submission module from scratch in order to meet its need to handle the entirety of the submission process. By involving stakeholders from across campus, thoroughly investigating existing options and designing a very flexible system, UNBC has created an ETD system that any institution can easily customize to reflect their existing workflows from beginning to end.

The question remains whether Jarrow will become another ETD software relic. Significant development time has been committed to this project. The software will enter a pilot phase in the fall of 2012. The authors hope that the flexibility and openness of the system will encourage its adoption at other institutions and lead to its long-term sustainability. The project can be followed at [http://code.library.unbc.ca](http://code.library.unbc.ca/).

## References

ARROW\_Contribution – VALET – VTLS’ VALET for ETDs \[Internet\]: Google Project Hosting; c2010 \[cited 2012 08/01\]. Available from: [http://code.google.com/p/valet/wiki/ARROW\_Contribution](http://code.google.com/p/valet/wiki/ARROW_Contribution).

Bauer N. 2012. Building an ETD administrative system and student services website. In: proceedings of United States Electronic Thesis and Dissertation Association (USETDA) 2012 conference.; June 13, 2012 – June 15, 2012; Boston. Available from: [https://conferences.tdl.org/USETDA/USETDA2012/schedConf/presentations](https://conferences.tdl.org/USETDA/USETDA2012/schedConf/presentations).

ETD-db: Home \[Internet\]: Virginia Tech; c2012 \[cited 2012 08/01\]. Available from:  [http://scholar.lib.vt.edu/ETD-db/index.shtml](http://scholar.lib.vt.edu/ETD-db/index.shtml).

Institutions Requiring Electronic Thesis/Dissertation Submissions \[Internet\]: Networked Digital Library of Theses and Dissertations; c2012 \[cited 2012 08/01\]. Available from: [https://docs.google.com/spreadsheet/ccc?key=0AtSglIhGWCkpdHJvOUNSZUZyRC04UXRUa0w3UmgtYWc&hl=en\_US#gid=0](https://docs.google.com/spreadsheet/ccc?key=0AtSglIhGWCkpdHJvOUNSZUZyRC04UXRUa0w3UmgtYWc&hl=en_US#gid=0).

Jones R. 2004. Thesis Alive! At Edinburgh University Library \[Internet\]: Edinburgh University Library; c2004 \[cited 2012 08/01\]. Available from:  [http://www.thesesalive.ac.uk/dsp\_home.shtml](http://www.thesesalive.ac.uk/dsp_home.shtml).

Lewis S. 2012. A Brief History of SWORD \[Internet\]; c2012 \[cited 2012 08/01\]. Available from: [http://swordapp.org/about/a-brief-history/](http://swordapp.org/about/a-brief-history/).

MacDonald J. and Yule D. 2012. Developing a revolution in ETD workflow management: A software solution from thesis proposal to final dissemination and publication. In: proceedings of United States Electronic Thesis and Dissertation Association (USETDA) 2012 conference.; June 13, 2012 – June 15, 2012; Boston. Available from: [https://conferences.tdl.org/USETDA/USETDA2012/schedConf/presentations](https://conferences.tdl.org/USETDA/USETDA2012/schedConf/presentations).

McCutcheon A. 2011. How to create a highly functional ETD office. In: proceedings of United States Electronic Thesis and Dissertation Association (USETDA) 2011 conference.; May 18, 2011 – May 20, 2011; Orlando. Available from: [https://conferences.tdl.org/USETDA/USETDA2011/schedConf/presentations](https://conferences.tdl.org/USETDA/USETDA2011/schedConf/presentations).

McMillan G. 2012. ETD-db license. Email.

Pollenz R. S. and Piazza L. 2011. A model for management of the electronic thesis/dissertation (ETD) process that promotes efficiency and student success. In: proceedings of United States Electronic Thesis and Dissertation Association (USETDA) 2011 conference.; May 18, 2011 – May 20, 2011; Orlando. Available from: [https://conferences.tdl.org/USETDA/USETDA2011/schedConf/presentations](https://conferences.tdl.org/USETDA/USETDA2011/schedConf/presentations).

Reeves S. 2010. How to Set Up an ETD Submission Program \[Internet\]: Networked Digital Library of Theses and Dissertations; c2010 \[cited 2010 07/30\]. Available from: [http://www.ndltd.org/resources/how-to-set-up-an-etd-submission-program](http://www.ndltd.org/resources/how-to-set-up-an-etd-submission-program).

Rogers M. 2005. VTLS’s free valet service. Library Journal. 130(17): 22.

Vireo ETD Submission and Management \[Internet\]: Texas Digital Library; c2012 \[cited 2012 08/01\]. Available from:  [http://www.tdl.org/etds/](http://www.tdl.org/etds/).

VALET for ETDs \[Internet\]: VTLS Inc.; c2012 \[cited 2012 08/01\]. Available from: [http://www.vtls.com/products/valet](http://www.vtls.com/products/valet).

Yule, D. 2012. Jarrow, A History \[Internet\]: University Of Northern British Columbia; c2012 \[cited 2012 08/01\]. Available from:  [http://code.library.unbc.ca/jarrow-etd/jarrow-history/](http://code.library.unbc.ca/jarrow-etd/jarrow-history/).

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Jarrow is designed for Drupal 7, and should work with any sub-version (7.1-7.15) within that. When released, it will be compatible with whatever the latest version of Drupal 7 is at that time.

## About the Authors

James R.W. MacDonald was the Web Services Librarian at the Geoffrey R. Weller Library, University of Northern British Columbia at the time this article was written. He is now the Web Services Librarian at the American University of Sharjah in the United Arab Emirates. James’ research interests currently focus on usability and the user experience in digital environments.

Daniel Yule was a Web Developer for the Geoffrey R Weller Library at the University of Northern British Columbia. He has since moved on to pursue his Ph D in Computer Science at Dalhousie University, focusing on library technology.
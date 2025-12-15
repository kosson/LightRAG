---
title: "Customizing Open-Source Digital Collections: What We Need, What We Want, and What We Can Afford"
source: "https://journal.code4lib.org/articles/18063"
author:
  - "Emma C. Beck"
  - "Terri L. Holtze"
  - "Rachel I. Howard"
  - "Randy Kuehn"
published: 2024-10-08
created: 2025-01-10
description: "After 15 years of providing access to our digital collections through CONTENTdm, the University of Louisville Libraries changed direction, and migrated to Hyku, a self-hosted open-source digital repository. This article details the complexities of customizing an open-source repository, offering lessons on balancing sustainability via standardization with the costs of developing new code to accommodate desired features. The authors explore factors in deciding to create a Hyku instance and what we learned in the implementation process. Emphasizing the customizations applied, the article illustrates our unexpected detours and necessary considerations to get to “done.” This narrative serves as a resource for institutions considering similar transitions."
tags:
  - "clippings"
---
# Customizing Open-Source Digital Collections: What We Need, What We Want, and What We Can Afford

Emma C. Beck, Terri L. Holtze, Rachel I. Howard, Randy Kuehn

## System Selection

### Our proprietary past

In 2005, the University of Louisville Libraries selected CONTENTdm to host its digital collection of unique and rare primary source materials and used a Library Services Technology Act (LSTA) grant for funding. Limited technology resources meant that the institution needed a “plug and play” system with the possibility of customization. CONTENTdm seemed functional, and allowed self-hosting with support from OCLC, an established library vendor.

With the creation of two new positions in 2006, the Digital Initiatives Librarian and the Web Services Librarian, along with the assistance of a server administrator who managed the self-hosted server, we established our Digital Collections program using a distributed approach to creating scans and metadata. We added content from multiple libraries at the university plus a few non-library campus collections; upgraded to a license without limits on the number of collections and items; created interactive maps and custom queries; and added a development server to test upgrades and customizations along the way. By the time OCLC announced that it would no longer support self-hosted CONTENTdm instances after 2018, we had experienced increasing dissatisfaction with OCLC’s lackluster customer service, slow pace of software development, and recurring issues of server downtime with their other products. A move to a hosted instance would mean a loss of our customizations, an increase in costs, and a deeper dependence on an unreliable vendor. We thought we were outgrowing the “out of the box” approach to repository software and hoped that adopting open-source tools would better serve our needs and lower costs.

### System requirements

As we began the search for a new system, our Digital Collections consisted of approximately 100,000 digitized and born-digital works, including images, maps, newspapers, and videos, with some “compound objects” (a CONTENTdm term) comprising a parent item with two or more children (for example, a multi-page newspaper issue). The new system would need to accommodate such hierarchies. It would also need to provide a more user-friendly image viewer and be able to handle full text provided as either metadata or through optical character recognition (OCR). We also wanted a system that provided rights protection, controlled vocabulary, batch import/export, advanced search, facets, and reports. In addition to the built-in capabilities, we sought the ability to edit the look of the pages, including item records, headers and footers, and the ability to create additional informational pages. We preferred, but did not require, that the new system allow for the scalability and interoperability that would allow us to move our electronic theses and dissertations (ETDs) and oral histories into the same software stack, saving more money on vendor licenses and removing silos.

As well as the system requirements and functionality, we also needed to keep in mind our lean staffing. Digital Initiatives, which oversees Digital Collections and the Institutional Repository, has three full-time equivalent (FTE) employees, up from 2.5 at the outset of the migration. Web Services, responsible for multiple sites and systems, has just 1.7 FTEs, and the server administrator oversees Linux and Windows servers across five libraries. We needed a system that could be implemented and maintained with these staffing levels.

### Open-source solutions

Given our dissatisfaction with stagnant proprietary software, we found ourselves drawn to open-source software (OSS) as a compelling alternative. It held the promise of access to a community of users in an environment of knowledge sharing, innovation, and transparency. Its inherent flexibility would enable us to customize to suit our specific needs, empowering us to tailor the software to our requirements.
We had successfully adopted OSS for specific, limited uses prior to this exploration. For example, our archives catalog runs on ArchivesSpace, and the oral history audio files and transcriptions now live in a locally developed application employing the Oral History Metadata Synchronizer (OHMS) OSS. We use LOCKSS (Lots of Copies Keeps Stuff Safe) for digital preservation. Other applications posed implementation or maintenance challenges, often due to underdeveloped documentation and the absence of dedicated software support, but vended solutions had also lacked those resources.

In 2018, the two newest OSS systems in the digital asset management space were Islandora and Hydra/Sufia (now Hyrax, created and maintained by the Samvera Community). Both could handle audiovisual materials and texts, including scholarly publications such as ETDs. At the time, Islandora offered a hosted solution through Lyrasis, although that would limit design and customization options. Hydra users tended to be at institutions with teams of in-house developers. However, they were working on a more turnkey approach called “Hydra-in-a-Box” (now Hyku), which sounded like a good fit for institutions like ours who needed an entry-level OSS application. It was still in development, but the University of Houston had recently received a grant from the Institute of Museum and Library Services (IMLS) grant to build a Bridge2Hyku Toolkit which sounded like exactly what we needed to move forward with our migration. The toolkit wasn’t as far along as the software development, but we did not feel hurried. We thought we could keep the public CONTENTdm instance up (albeit without vendor support) while we took our time setting up the new system (which we thought would require our time but not any new expenses).

## Implementation

### Unboxing Hyku

When we began working with Hyku, we undertook basic customizations to incorporate our preferred work types and metadata schema, essential for ensuring a seamless data migration process. This initial phase involved extensive planning and proved time-consuming. The functionality enhancements benefited from the available Hyrax documentation, but we found ourselves needing to fill in the gaps. These initial customizations to improve functionality and usability provided the foundation for our initial instance of Hyku. This version operated without any significant issues and was put into production. However, only a fraction of our collection was represented. Importing the remainder of the collection required further system enhancements.

### Outsourcing development

We had not yet focused on more complex customizations of the Hyku OSS. Hyku did not include some necessary features, and the IMLS grant had not produced them as we had hoped. We also sought to improve the user experience. The most critical requirement for us, the NewspaperWorks Gem, was not part of the core code. We had previously completed a community transcription project with text transcribed and shared in page-level metadata. The system needed to be capable of housing this metadata and making it searchable. An entire issue of the newspaper should be treated as a parent, with each page (and its accompanying searchable metadata) treated as a child. A search for any term in the child should resolve to the parent record, so as not to lose context, but have a way within the viewer to navigate to the appropriate page (this was possible, albeit clunky, in CONTENTdm). Parent/child records made up the bulk of our collections and help would be needed to incorporate this functionality.

We realized that outsourcing development would be necessary to complete our migration. Incorporating the NewspaperWorks Gem continued to be our primary concern. Aside from that, our list of customizations needing to be outsourced started out small. However, due to the task complexity, the list grew significantly when broken down into individual steps. We worked closely with the software development company contracted to improve our instance of Hyku, including meeting monthly, and testing code changes. Troubleshooting issues occupied most of our sole in-house programmer’s time over the duration of the project. The Digital Initiatives team needed to restructure metadata to match the new code’s handling of compound objects, adding and populating a “parent” field to every parent and child and to import or reimport all metadata and associated files through the system’s Bulkrax tool – another time-consuming process.

Even with a team of contracted developers handling the code changes and moving the project forward, we underestimated the time and involvement necessary to complete this phase of the project. Additionally, while they did their own testing, it did not always represent how we used the system. For example, load time of a single newspaper issue on the developer’s test server appeared to be speedier than that same newspaper loaded on to our server with 100,000 items and heavy server traffic.

### Usability

We took advantage of the ability to customize the homepage and other page layouts. The custom homepage allowed us to highlight document types and themes like Louisville maps and materials about the university. Users could also use filters from the homepage to browse the collection rather than being required to complete a search before seeing the filters, as was the case in CONTENTdm. We were also able to customize the thumbnail images throughout the system to be larger to help users more quickly identify items they wanted to investigate. Once they did access an item record, the image could be zoomed in with exceptional clarity.

On the negative side, we found that compound objects loaded so slowly that they were essentially inaccessible. To make matters worse, there was no indication to tell users that the files were loading – only a blank space in the viewer where the items would eventually appear.

While importing our parent/child records, we contracted for a second round of development, focusing on additional customizations involving lower-priority features such as friendly URLs, more options for sorting search results, and the ability to limit the size of the files downloaded by users. This round was a bit more difficult to navigate, as we discovered the customizations interfered with one another. At the same time, Hyku’s core code was evolving faster than expected. We had to halt all planned local work on the system to avoid any further conflicts with the developers’ work. The project dragged on as we blew past our initial estimate for completion, which was not critical as long as the CONTENTdm site could continue to provide access. However, campus information technology professionals had become increasingly concerned about the security risks posed by the aging server and unsupported software and gave us a hard deadline for its end of life.

With the development contract ended and file importing nearing completion, we noticed that the navigation of full text within the image viewer no longer functioned, which, in conjunction with the image load time issues, critically affected the usability of the system. Furthermore, the code did not meet ADA standards.

### Accessibility

To begin with, Hyku lacked adequate development in terms of accessibility. However, it is particularly important. Firstly, it provides the best possible experience for all users. Secondly, for public institutions – as many of Hyku’s potential users are – accessibility is legally required under the Americans with Disabilities Act.

The Samvera community has discussed the accessibility issues in working group meetings, but open-source communities have complex and differing needs, and development still focuses on creating additional functionality within the system rather than on correcting known accessibility issues. Whether stemming from the programmers or the clients, many updates focus on improving functionality rather than improving accessibility even though the accessibility issues would be easier to fix.

We began testing for and correcting accessibility issues early in our project; however, this was not an efficient use of our time because further development overwrote large sections of the code and the work had to be repeated after the customizations and fixes from the outsourced development were implemented. Knowing that the accessibility issues existed, however, did help in planning what steps needed to be taken to eradicate the problems.

The main accessibility issues we noted include:

- Headings nested incorrectly and/or out of semantic order.
- Pages without unique titles.
- Settings on buttons and links need to show an outline on focus.
- Various spots where <div> was a child element of <u> which is semantically incorrect.
- License and rights links opened in new windows.
- Search form elements needed ids and labels.
- In the image viewer:

- Needed to remove “maximum-scale=1.0” in meta tag and set scalable as “Yes” so zoom functionality would work.
- No title attribute.

Throughout the customization process the in-house programmer and the web services librarian tracked changes to the code in a spreadsheet. This served multiple purposes: first, with multiple people working on the files it ensured communication about edits between collaborators; second, as different versions were implemented it allowed us to review the changes we had made and determine if they needed to be recreated in the newest version, and third, we shared the items in the spreadsheet that pertained to accessibility with the Samvera Metadata Interest Group (SMIG) and with our developer contractors in the hope that accessibility issues we had found would assist with future development.

## Evaluating open source

Our Hyku implementation took longer than anticipated, involved out-of-pocket costs to outside developers as well as extensive time on the part of the in-house team, and did not produce all of the desired results. When we finally launched our site in August 2023, full-text search and video streaming were not working within the image viewer, and image loading could be so slow that larger records were not useable, so we held off on adding yearbooks and a journal which had been available in CONTENTdm, angering users who relied on free online access to those resources.

Users did appreciate the improvements to the design, site navigation, and show pages. The University of Louisville project team participated in Samvera Community work groups and enjoyed the collaborative nature of this open-source community. We watched and listened as other desired improvements were developed for other projects, and eagerly anticipated the day when we could add them to our code. However, by trying to push the boundaries early on with new functionality, we now struggle to maintain the system with these customizations.

## Where do we go from here?

At the University of Louisville, our extensive customizations, though tracked in GitHub, have led to challenges as we try to upgrade our system. We are currently on Hyku 3 and the release we would like to be on, Hyku 6, is tentatively scheduled for this summer. To upgrade and take advantage of improvements made by others in the community, we need to separate our customizations from the core code, since some (not all) of our custom features have been refined and added to newer versions, but there is no simple way to do this. We are either stuck in our current system with its problematic features, or we could start from scratch. Some of the work we outsourced to external developers and already paid for would likely be lost. We would also have to re-import all our collections and reconfigure all the settings. As an early implementer, the work we did or contracted, and the bugs we helped find, assisted in the overall development of the system, but have left us in a tricky spot.

Operating without full functionality left us in a challenging place. Development slowdowns resulted in fewer upgrades, which could cause security problems. It became hard to delineate between necessary changes and the point of no return. Which customizations will create update issues? Would it be better for us to stay with the core code? At that point is there a difference in open-source software and proprietary except the ethos?

The system’s complexity forces institutions staffed like ours to outsource for maintenance and upgrades of the system, requiring funding for an unknown and unplannable amount of work on an ad hoc basis. These unexpected requests put stress on an already tight budget, leading us to wonder if other proprietary systems, with known costs, would be a better option. We have begun to explore the digital collection landscape and wonder about other possibilities that would not strain our budget or personnel.

Digital collection options are scarce. There are a few open-source options still in early development and a few proprietary systems currently being built out with a variety of capabilities and cost structures. So where does that leave us? Between a rock and a hard place. Could we hire a new developer or two, whose time is dedicated to OSS development? We wish, but with tight budgets, it’s difficult to get approval for a new employee line and our administration would rather pay for a temporary outsourcing expenditure than take on a continued annual expense. We are at the mercy of a stark budget for the coming year. These issues will plague us until we find a sustainable way forward.

## Resources

Bridge 2 Hyku – [https://bridge2hyku.github.io/](https://bridge2hyku.github.io/)

Digital Collections Relaunch – [https://uofllibraries.wordpress.com/2023/08/04/digital-collections-relaunch/](https://uofllibraries.wordpress.com/2023/08/04/digital-collections-relaunch/)

Guidance on Web Accessibility and the ADA – [https://www.ada.gov/resources/web-guidance/](https://www.ada.gov/resources/web-guidance/)

Hyku Documentation – [https://samvera.atlassian.net/wiki/spaces/hyku/overview](https://samvera.atlassian.net/wiki/spaces/hyku/overview)

Hyku Source Code – [https://github.com/samvera/hyku](https://github.com/samvera/hyku)

Hyrax Source Code – [https://github.com/samvera/hyrax](https://github.com/samvera/hyrax)

Samvera Documentation – [https://samvera.github.io/](https://samvera.github.io/)

Samvera Project – [https://samvera.org/](https://samvera.org/)

University of Louisville Digital Collections – [https://digital.library.louisville.edu/](https://digital.library.louisville.edu/)

[Emma C. Beck](https://journal.code4lib.org/articles/) is Metadata Librarian at the University of Louisville Libraries.

[Terri L. Holtze](https://journal.code4lib.org/articles/) is Web Services Librarian at the University of Louisville Libraries.

[Rachel I. Howard](https://journal.code4lib.org/articles/) is Digital Initiatives Librarian at the University of Louisville Libraries.

[Randy Kuehn](https://journal.code4lib.org/articles/) is Digital Technologies Systems Librarian at the University of Louisville Libraries.

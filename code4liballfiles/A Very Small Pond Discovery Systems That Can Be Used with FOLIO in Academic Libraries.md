---
title: "A Very Small Pond: Discovery Systems That Can Be Used with FOLIO in Academic Libraries"
source: "https://journal.code4lib.org/articles/17433"
author:
  - "Aaron Neslin"
  - "Jaime Taylor"
published: 2023-08-29
created: 2025-01-10
description: "FOLIO, an open source library services platform, does not have a front end patron interface for searching and using library materials. Any library installing FOLIO will need at least one other software to perform those functions. This article evaluates which systems, in a limited marketplace, are available for academic libraries to use with FOLIO."
tags:
  - "#discovery/systems"
  - "#FOLIO"
  - "#academic/library"
---
# A Very Small Pond: Discovery Systems That Can Be Used with FOLIO in Academic Libraries

Aaron Neslin, Jaime Taylor

FOLIO, an open source “next gen” integrated library system (ILS)/library services platform (LSP), does not have a front end patron interface for searching and using library materials. Any library installing FOLIO will need at least one other software to perform those functions. Currently, libraries are using EBSCO Discovery Service (EDS, both the “classic” UI and the “new” UI), Blacklight, VuFind, and possibly home grown systems. Other front end discovery systems exist, such as Primo, Summon, WorldCat Discovery, Vega, and Aspen, but no libraries could be identified that had paired these systems with FOLIO.

The aforementioned systems actually represent two different kinds of software, with vital differences. One group are the single search discovery layers, which ingest many kinds of metadata from many sources, including electronic resource subscriptions; this group is limited to [EDS](https://www.ebsco.com/products/ebsco-discovery-service), [Primo](https://exlibrisgroup.com/products/primo-discovery-service/), [Summon](https://exlibrisgroup.com/products/summon-library-discovery/), and [WorldCat Discovery](https://www.oclc.org/en/worldcat-discovery.html). They are all proprietary systems and include management of an aggregated index of electronic resource metadata.

The other group are OPAC-like front ends, which will only search and display catalog metadata and other local data sources, such as institutional repositories, loaded into their indexes. They do not have an integrated aggregated index of e-resources. These include [Blacklight](https://projectblacklight.org/), [VuFind](https://vufind.org/vufind/), and [Aspen](https://bywatersolutions.com/products/aspen-discovery), which are all open source systems, and [Locate](https://connect.ebsco.com/s/article/Locate-Quick-Start-Guide?language=en_US), [Vega](https://www.iii.com/products/vega/), [Soutron](https://www.soutron.com/products-usa/discovery-search-usa/), [Enterprise](https://www.sirsidynix.com/enterprise/), [Destiny](https://www.follettlearning.com/education-technology/library-management-system/destiny-discover), and [TDNet](https://www.tdnet.io/services/discovery), which are proprietary systems. Blacklight and VuFind are common in well-resourced libraries. VuFind and Aspen have some features that are beginning to incorporate electronic resource subscriptions into a single search experience (though those features are much less complex than in the algorithm-driven single search discovery layers); Blacklight could theoretically do so with some extra work on its index and other features; and EBSCO has plans to integrate Locate with EDS. Regardless, a library would still need to subscribe to one of the proprietary discovery layers’ aggregated index for those features to function. This may present a financial and workload barrier to libraries wishing to implement open source discovery layers, especially higher education libraries, which heavily subscribe to and use electronic resources.

## Single Search Discovery Layers

### EBSCO Discovery Service (EDS)

EBSCO Discovery Service, a proprietary system, was launched in 2010 as the front end for EBSCO’s electronic resources, and has been expanded to function as a single search interface that includes catalog records, institutional repositories, etc. EBSCO’s FOLIO hosting and support services allow for relatively easy integration between the two, on par with the relationships between a company’s proprietary ILS/LSP and OPAC (online public access catalog) or discovery layer. EDS is the only single search discovery layer currently being used with FOLIO.

Many academic libraries and consortia are using, or plan to use, EDS with FOLIO. These include the [Five College Consortium](https://www.fivecolleges.edu/about/libraries) [(Amherst College](https://www.amherst.edu/library/), [Hampshire College](https://www.hampshire.edu/library), [Mount Holyoke College](https://lits.mtholyoke.edu/), [Smith College](https://libraries.smith.edu/), and the [University of Massachusetts Amherst](https://www.library.umass.edu/), at which the authors work), [Michigan State University](https://eds.lib.msu.edu/), and [Missouri State University](https://libraries.missouristate.edu/). While other institutions, such as [University of Colorado Boulder](https://www.colorado.edu/libraries/), are or will be using the updated Discovery interface, these three institutions are using the “classic” version of Discovery.

All of these are small consortia of between three and five institutions, and their FOLIO instances are all hosted by EBSCO. Each has a single FOLIO instance, with multiple EBSCO Discovery front ends. The Five Colleges have five EDS instances, one per school. Michigan has two EDS instances for its three campuses. Missouri State has separate EDS instances for its four campuses and the state historical society. EBSCO runs daily OAI-PMH loads of catalog updates from the schools’ FOLIO instance to their EDS instances. These consortia all use EDS’s native “My Account” patron functionality for requests, loans, etc., with OpenAthens authentication to it.

The Five Colleges, Michigan, and Missouri have all reported significant issues with EDS since going live with it and FOLIO. Among these are lack of test environments, unreliable OAI-PMH catalog updates, confusing user experience and overzealous collection of patron data in My Account, lack of configurability, and what one librarian expressed as “You can discover things, but you can’t find things.” These difficulties seem to be systemic, rather than only found in one EDS installation or at one library, as each consortia describe very similar experiences. It has resulted in patrons feeling like their libraries are “…sending the impression that \[we\] don’t know what we’re doing or that we don’t care about the patrons’ needs and expectations.” [^1]

Some of these issues are being addressed by EBSCO. For example, in June 2023 they reduced the EDS My Account patron data retention period from 11 months to 35 days, and will be redesigning EDS’s GDPR compliance notification and data collection consent experience. However, many patrons may still be uncomfortable with realizing that a company outside of their library is collecting their library use data at all, especially if that library previously used home grown and locally hosted library systems. In EBSCO’s defense, their 35 day data retention period combined with the longstanding ability for users to view and delete their data (GDPR rights to access and erasure) within the EDS My Account interface provides library patrons with significantly more privacy and security than may be offered by other systems. Similar retention period information for Ex Libris or OCLC could not be located; Ex Libris states that Primo patron records can only be deleted by the library’s Primo administrator and OCLC has startlingly little product-specific information about GDPR compliance or other patron data privacy information available in their documentation. [^2] [^3]

The new EDS user interface is still under development, even as some libraries are already using it. Active development will continue for some time; hopefully EBSCO will address the issues that its existing customers have been experiencing with “classic” EDS. In the meantime, these three consortia have all expressed desire to investigate alternative or additional systems to ameliorate their EDS issues. [Michigan](https://catalog.lib.msu.edu/) has gotten the farthest into this effort, having launched an early iteration of VuFind in spring 2023. Other institutions, such as [Simmons University](https://www.simmons.edu/library), are already live with an EDS/VuFind/FOLIO ecosystem, where the two front ends serve different purposes instead of having a purely single search patron experience.

Voluntary Product Accessibility Statements (VPAT) for the classic and new EDS user interfaces can be found on EBSCO Connect. [^4] [^5] These documents indicate that both interfaces either support or partially support all Web Content Accessibility Guidelines (WCAG) 2.1 Level AA criteria. The interface itself supports these criteria, while content often only partially supports them due to the lack of control EBSCO has over other publishers’ content. According to EBSCO, they assure accessibility to EDS and their other products via:

- Completing annual accessibility audits conducted by a qualified third party
- Testing our platforms with both [JAWS](https://www.freedomscientific.com/products/software/jaws/) and [NVDA](https://www.nvaccess.org/)
- Conducting usability studies with visually- and physically-impaired users
- Working directly with institutions and their users to address their concerns
- Providing accessibility guides for products like EBSCOhost and EBSCO eBooks [^6]

### Primo

No FOLIO libraries using Primo could be located. According to Clarivate, Ex Libris’s parent company, Primo is no longer being sold to non-Alma customers. [^7] Therefore, Primo can not be used with FOLIO.

The barrier to using Primo with FOLIO is purely a business decision on Ex Libris and Clarivate’s part. [^8] There is no technical barrier to pairing the two systems. One of Primo’s strengths has always been its ability to ingest metadata from a variety of sources and in a variety of formats. FOLIO can export MARC metadata via OAI-PMH, which is one of Primo’s available data import methods. It is possible that a library could install the entire Alma/Primo ecosystem and also have a FOLIO instance that exports records to Primo, though that would probably not make financial or workflow sense in most cases.

### Summon

There are no FOLIO libraries using Ex Libris’s Summon. However, Marshall Breeding’s 2023 Library Technology Report states that Summon “can be used with Alma or other proprietary or open source ILS products.” [^9] Ex Libris confirms that they would be willing to attempt a FOLIO/Summon integration if the records exported from FOLIO met the ingest criteria for Summon, and that the Summon product manager is “always looking for development partners to do some testing and integration work.” [^10] [^11] Records, from any ILS/LSP, are ingested into Summon via FTP/SFTP, which is compatible with FOLIO’s processes. It may be difficult to make some Summon features work with FOLIO, for example real-time availability, which queries OPAC records (which FOLIO does not have, hence this report) instead of referring directly to the ILS/LSP. [^12] Summon uses the same Central Index as Primo.

According to Ex Libris, “Summon is continually designed and developed to meet Level AA of the W3C Web Content Accessibility Guidelines (WCAG 2.1) and Section 508 of the US Rehabilitation Act.” [^13] The VPAT for Summon is available on Ex Libris’s documentation site. [^14]

### WorldCat Discovery

No FOLIO libraries using WorldCat Discovery could be located, likely because its use is intertwined with other OCLC systems. WorldCat Discovery can only search and display bibliographic records from WorldCat (regardless of whether users are searching local records or all of WorldCat), and will not ingest bib records from other systems. Timely local item information, such as availability, location, number of copies, local notes, etc. can be pulled from FOLIO or other systems via z39.50 (*not* RESTful APIs) to display with WorldCat records in WorldCat Discovery. A local ILS/LSP would also sync its holdings with WorldCat via z39.50. These integrations are built on-demand by OCLC, and they expressed willingness to look into integrating with new systems. [^15]

As with Alma/Primo, this configuration negates some of the benefits of an open source system (e.g. cost, local control), as a library would still have to subscribe to OCLC’s suite of systems and services on top of devoting resources to FOLIO, and FOLIO would be duplicating bibliographic data held in OCLC’s systems. It is possible that this systems configuration could make sense for libraries that depend heavily on the entirety of WorldCat, their resource sharing groups, and interlibrary loan, but it would probably not be suitable for most academic libraries.

According to OCLC, they “are dedicated to improving the accessibility of our products, focusing on conforming to Level AA of the W3C Web Content Accessibility Guidelines.” [^16] The VPAT for WorldCat DIscovery (and their other products) seems not to be readily available on the web; instead, OCLC requires submission of a request form to access their VPATs and other accessibility reports. [^17]

## OPAC-Like Front Ends – Open Source Options

### Blacklight

While Blacklight does not have its own aggregated index and link resolver for electronic resource subscriptions, it can be connected to EDS or Alma/Primo/Summon via APIs. [^18] [^19] Therefore, libraries using it need to continue subscribing to one of these services and actively use it for electronic resource back end management. However, even with these integrations, Blacklight only searches and displays electronic resources separately from local catalogs. Most libraries (example: [Cornell](https://newcatalog.library.cornell.edu/)) seem to use Blacklight as the front end for a single data source, such as FOLIO, an institutional repository, or an archival description system, and may run several different Blacklight instances, one for each data source. A few institutions have several data sources in one instance of Blacklight, such as the [Philadelphia Area Archives at UPenn](https://findingaids.library.upenn.edu/), which presents EAD finding aids from many institutions in one Blacklight instance.

Blacklight’s development community is largely North American and, while diffuse, is quite robust, as it includes several large, well-resourced institutions. It is built with Ruby on Rails and uses a Solr index. There do not seem to be any commercial hosting and support services available, so a library would have to host Blacklight locally. Libraries using FOLIO with Blacklight have options for their FOLIO hosting (in part because there is no company offering a FOLIO/Blacklight hosting package). Cornell, for example, hosts FOLIO with EBSCO, while Stanford hosts locally.

Cornell has been using Blacklight as part of their Discovery framework for over a decade. [^20] While they host FOLIO with EBSCO, Cornell hosts Blacklight locally, as is necessary given the lack of vendor support for Blacklight. [^21] Their index is populated with bibliographic data from FOLIO using a REST endpoint and processed with a Java program they have created, before being pushed to Solr. Blacklight allows for, but may also require, a large amount of customization to meet institutional needs. Cornell employs one dedicated Blacklight developer, and there is support by many others who work in web development at the Cornell Libraries. Cornell has built their own “My Account” Ruby on Rails application to integrate with their Blacklight discovery layer and FOLIO. [^22] This application authenticates users using Cornell’s institutional Shibboleth. Using FOLIO API endpoints, it can pull a patron’s user information, as well as post requests and renewals.

Stanford, like Cornell, is using a self-hosted Blacklight discovery layer. However, they are also self-hosting FOLIO on a local Kubernetes cluster. Self-hosting gives them the ability to populate their Blacklight index using direct queries to the FOLIO database. Stanford takes a similar approach to Cornell to patron empowerment, by creating an additional Rails application that allows users to see loans, place requests, and renew items. Users are authenticated to their patron account using SSO. Stanford has a significant team working to support their discovery services and the FOLIO integration, with a team of six full-stack developers who have expertise in Solr, Rails and Python. There are two analysts and subject matter experts included in the work cycle as well. [^23]

While there is not much readily available information on Blacklight’s out of the box accessibility, it seems to be decent and improving, with a number of commits and issues dedicated to ARIA and WCAG 2.0 AA standards, and development now including some automated testing. [^24] Because many Blacklight adopters highly customize their installation, any given site may be more or less accessible than the baseline.

### VuFind

VuFind is more readily used to present several local data sources in one instance. Since, like Blacklight, there is no aggregated index, a library using VuFind will still need to subscribe to EDS or Primo/Summon. If a library subscribes to an aggregated index, VuFind can search it, though it searches that separately from the local collections, and at best results are displayed in separate tabs or columns of results for catalog holdings, databases, etc. In version 9.0 is a new feature called Blender, which begins to combine data sources and present them more like a single search environment. [^25] [^26] To use the Blender feature, libraries will still need to subscribe to an aggregated index; searches that pass from VuFind to that aggregated index will still be subject to the index’s proprietary search and ranking algorithm. Nevertheless, some libraries, like the aforementioned Simmon University, use VuFind only for searching and displaying catalog records and related patron account functionality (for example, requesting and renewing hard copy books), and maintain the aggregate index’s front end for their electronic resource subscriptions.

VuFind is primarily developed and maintained by Villanova University and, while it remains centralized there, has a global community of users and developers. Like FOLIO, it is an Open Library Foundation project. [^27] It is built with PHP and JavaScript, and uses a Solr index. Hosting and support is available from Index Data; support services are also available separately from hosting. Hosting and support is also newly available from Equinox Open Library Initiative. [^28]

Libraries are using both OAI-PMH and SFTP to send catalog record updates from FOLIO to VuFind. [Texas A&M](https://catalog.library.tamu.edu/), for example, locally hosts both VuFind and FOLIO and sends hourly incremental updates from FOLIO’s mod-oai-pmh, with full catalog reloads twice a year. [University of Chicago](https://catalog.lib.uchicago.edu/), on the other hand, which hosts VuFind locally and hosts FOLIO with Index Data, runs a daily SFTP transfer using code built by Index Data. And while the patron account features are “robust,” according to a Texas A&M librarian, libraries may choose to use or not use the native features. Texas A&M chose not to, as they already had a “My Library” patron account system that had been in use with their previous ILS and which they were able to integrate with VuFind when they went live with it and FOLIO. University of Chicago uses Vufind’s native patron account features, connected to their campus SSO environment. These two examples of features – catalog updates and patron accounts – display the flexibility of an open source system such as VuFind; libraries are able to use or not use various pieces of the software as it suits their changing needs and available resources.

Even with hosting options and vendor support, libraries find that they have to devote at least a little personpower to customizing VuFind. At University of Chicago, they have an in-house PHP developer and another person who works on UX; they have both written custom code for their own use and contributed back to the codebase. [^29] Texas A&M relates that they were able to get “to about 85%” and needed in-house development for the home stretch. [^30]

Beginning with version 7.0 in 2020, VuFind developers have been emphasizing the system’s accessibility. [^31] This development aims to “get as close to \[WCAG Level\] AAA compliant as possible” and also be in compliance with Germany’s BITV standards which are equivalent to WCAG Level AA; however, a formal VPAT for VuFind could not be found. The WCAG 2.1 Level AA compliant Equinox Theme was launched by Equinox Open Library Initiatives in April 2023,and as of June 2023, accessibility work is ongoing, as evidenced by continued discussion in the regular Community Calls. [^32] [^33]

Aside from the above mentioned institutions, examples of libraries using VuFind with FOLIO include:

- [Lafayette College](https://libcat.lafayette.edu/)
- [Skidmore College](https://lib.skidmore.edu/)
- [Wellesley College](https://libcat.wellesley.edu/search/)

### Aspen

ByWater Solutions manages the codebase for Aspen, which is descended from VuFind, and provides hosting and support services. Hosting and support is also available from Equinox Open Library Initiative. Aspen is mostly used by public libraries, though there are a few academic libraries using it, primarily community colleges. Though some FOLIO libraries have expressed interest in Aspen, there are no FOLIO libraries using Aspen yet (as of July 2023). ByWater says that, “although there is not currently an integration with \[FOLIO\], we would be happy to discuss building one with any interested libraries.” [^34] Since ByWater will also host FOLIO, a unified hosting service for FOLIO and Aspen would be possible, similar to the arrangement with EBSCO for FOLIO hosting and EDS, or Index Data for FOLIO and VuFind.

As with other open source discovery systems, Aspen does not have an aggregated index. Aspen can connect to EDS/EBSCOHost but not to the Primo/Summon Central Index. Results can be presented either as a combined catalog and EDS search with bento type results (where the user searches once and is presented results from different sources in different columns or blocks, which visually resembles a Japanese bento lunch box, instead of mixed in one results lists), or the catalog and EDS can be searched separately. Other data sources can be included via either APIs or sideloading, but at this point it is difficult to determine if these would be robust enough for the needs of a research institution.

According to ByWater, “Aspen Discovery is currently compliant with Web Content Accessibility Guidelines (WCAG) 2.1 AA.” [^35] Aspen does not have a VPAT or similar formal documentation outlining their level of compliance.

Examples of Aspen in academic libraries (non-FOLIO):

- [College of Aurora](https://aurora.catalog.aspencat.info/)
- [Yavapai College](https://ycp.catalog.yln.info/)
- [Sheridan College](https://sc.wyldcatalog.org/)

## OPAC-Like Front Ends – Proprietary Options

### Locate

Locate is EBSCO’s recently launched front end interface for FOLIO. [^36] It is unrelated to EDS and not dependent upon it. Unlike the above OPAC-like systems, it is proprietary software and not open source. It will only be available to customers that host FOLIO with EBSCO. It will only incorporate records from FOLIO inventory, and can not search and display other data sources. This means it can only provide data on eResources if MARC records for the resource have been created and added to FOLIO Inventory. Unlike EDS, Locate does not depend on a daily feed of records from OAI-PMH or file transfer. The Apache Kafka module within FOLIO provides constant streaming updates without delay. [^37] Locate also includes left anchored searching, a feature present in traditional OPACS, but less common in modern single-search discovery layers. Left anchored searching has been a powerful tool for music discovery in libraries. [^38]

EBSCO plans to integrate Locate with their other systems, including EDS. [Grand Valley State](https://gvsu.locate.ebsco.com/) and [Drew University](https://drew.locate.ebsco.com/) launched Locate instances in the spring of 2023. According to librarians at Grand Valley State, they chose to implement Locate to address some of the shortcomings of EDS. [^39]

Like EBSCO Discovery Service, Locate’s VPAT indicates that the system mostly meets WCAG 2.1 Level AA. [^40]

### Vega

Vega is a proprietary system created by Innovative Interfaces, Inc. (III), which, like Ex Libris, is a Clarivate subsidiary. It is largely used by public libraries, and can only be paired with Polaris or Sierra ILSs. Therefore, it cannot be used with FOLIO.

### Soutron

Soutron Discovery is a proprietary system from Soutron Global, whose primary market is the United Kingdom, with focus on special and corporate libraries. No libraries are currently using Soutron Discovery with FOLIO. However, Soutron says that “the product will work with any ILS“ via APIs, so it is theoretically possible. [^41]

### Enterprise

SirsiDynix’s Enterprise discovery system is ILS/LSP agnostic, so it can probably be paired with FOLIO, though no library has yet done so. It is largely used by public libraries, and therefore may not be appropriate for an academic library. Similar to VuFind and Aspen, it can present search results from EBSCO Discovery in a bento format via APIs.

### Destiny

Follett’s Destiny Discover is intended for school libraries, and is part of their Destiny suite. While it does some electronic subscription resource integration, it is not appropriate software for research libraries. It could not be determined from the sales materials whether or not Destiny Discover can be paired with FOLIO or if it is dependent on the rest of the Destiny suite.

### TDNet

TDNet Discovery has an aggregate index, content management capabilities, and a link resolver, making it similar to the Single Search discovery layers, but does not cover nearly the amount and diversity of content that those systems do. TDNet’s focus is on STEM (science, technology, engineering, mathematics) materials, which would not be sufficient for a multidisciplinary academic library (hence including it here in the OPAC-like section), and is “designed for corporate, bio-medical and special libraries.” [^42] It likely can be paired with FOLIO, though no library has yet done so.

## Conclusions

EDS is the only proprietary single search discovery layer currently being used by FOLIO libraries. None of the other three systems are being used in conjunction with FOLIO; of them, Ex Libris’s Summon is the most realistic option for FOLIO libraries, as it can almost certainly ingest MARC records from FOLIO and would not come packaged with redundant other software. OCLC’s WorldCat Discovery is available; FOLIO would not, though, be installed in place of, but rather *in addition to* other OCLC subscriptions, since WorldCat Discovery will not accept bibliographic records from other systems (though item information could be ingested from FOLIO via z39.50). Ex Libris’s Primo is unavailable as a discovery system, since Ex Libris is unwilling to sell new subscriptions without an Alma subscription. Therefore, if a library wishes to use a single search discovery layer that integrates electronic resource management, link resolving, searching, and use, that library must use EDS or Summon unless they are willing to pay for software that duplicates some of FOLIO’s functions, in which case WorldCat Discovery is also an option. According to EBSCO, moving to the new EDS UI could fix some of the issues that early adopter libraries have in EDS classic, but the authors are not confident that this is true.

Of the three open source OPAC-like front ends, Blacklight and VuFind are already being used with FOLIO, while Aspen is not. Blacklight has the least integration with electronic resources; it also requires a less common and therefore more expensive skillset and has no commercial hosting and service option. Both VuFind and Aspen can integrate electronic resources more readily and present a search experience that is closer to a single search; it is possible that similar aspects could be built into Blacklight. Blacklight and VuFind can integrate with either EBSCO’s or Ex Libris’s aggregated indexes, while Aspen will only connect to EBSCO’s. While otherwise very similar, VuFind and Aspen have important differences, especially in that VuFind already has FOLIO libraries using it, as well as a larger academic user and developer community. Development of VuFind’s Blender feature will provide the user experience that is closest to a single search, which is a major selling point of the proprietary discovery layers. Adopting Aspen, however, could be a groundbreaking project that contributes to widening the library software marketplace. If a library wishes to pursue a combined hosting and/or support service for FOLIO and an open source discovery layer, it can choose between IndexData for VuFind or Bywater for Aspen.

Proprietary OPAC-like discovery layers represent a style of library software that is verging on outdated; they also lack both the perks and drawbacks of open source systems. Of them, only Locate is currently being used with FOLIO; EBSCO designed it specifically to be an OPAC front end to pair with their FOLIO hosting service. Of the other five, most (except Vega) can probably be paired with FOLIO, though no libraries have done so yet. However, these systems are primarily designed for public (Enterprise), school (Destiny), and special libraries (Soutron, TDNet); they may work with FOLIO in those settings, but would likely not meet the needs of an academic library. Locate is therefore the best choice, but can only be obtained in tandem with EBSCO’s FOLIO hosting.

Finally, as with any major systems change, a library wishing to implement a new discovery system must thoroughly investigate the needs, desires, and expectations of its users, including users that are not currently making their needs known through existing feedback mechanisms. With this information, a library can make informed decisions and pursue solutions that truly address the needs of both patrons and staff, regardless of which systems are pursued. This inquiry should draw out both where patrons are dissatisfied and not having needs met by current systems, as well as where patrons *are* satisfied and needs *are* being met. Libraries will also need to be frank about the budget and personnel they have available for implementing and maintaining a discovery layer software. These three classes of software vary greatly in cost and required skills; the sticker price of proprietary software can be shocking, but open source software often ends up being more expensive than originally planned once infrastructure and staff hours are taken into account. Since the above described softwares have major differences, for both staff and patrons, a library should start a RFP process only once these needs and budgets have been well defined.

## Notes

[^1]: Conversation with Missouri State University Libraries staff. 21 November 2022.

[^2]: What You Need to Know About Addressing GDPR Data Subject Rights in Primo. 2022. Ex Libris Group. \[accessed 14 August 2023\]. [https://knowledge.exlibrisgroup.com/Cross-Product/Security/GDPR/01Addressing\_Data\_Subject\_Rights](https://knowledge.exlibrisgroup.com/Cross-Product/Security/GDPR/01Addressing_Data_Subject_Rights)

[^3]: It may be difficult to compare EBSCO’s GDPR and other data privacy compliance with that of Ex Libris or OCLC, as they are possibly defining that data differently, with Ex Libris and OCLC using stricter definitions that include less data under the purview of those laws. For example, OCLC allows libraries to add their own data privacy notice, rather than having their own, indicating that the library is responsible for patron data.

[^4]: EBSCO Information Services Accessibility Conformance Report International Edition. January 2023. EBSCO Information Services. \[accessed 13 July 2023\]. [https://connect.ebsco.com/s/file-download?param=/sfc/p/1H000000P2eP/a/5a000002gfcs/rb5miJTLCyPWFYkjUQr0zWjJtgIwMp4YJ8x.jlQRGXk](https://connect.ebsco.com/s/file-download?param=/sfc/p/1H000000P2eP/a/5a000002gfcs/rb5miJTLCyPWFYkjUQr0zWjJtgIwMp4YJ8x.jlQRGXk)

[^5]: EBSCO Accessibility Conformance Report International Edition. January 2023. EBSCO Information Services. \[accessed 13 July 2023\]. [https://connect.ebsco.com/s/file-download?param=/sfc/p/1H000000P2eP/a/5a000002gfcx/L3f\_x1iWfznZ7dvOJnNX1KRGgHm6xA.TQRKV59AlZBc](https://connect.ebsco.com/s/file-download?param=/sfc/p/1H000000P2eP/a/5a000002gfcx/L3f_x1iWfznZ7dvOJnNX1KRGgHm6xA.TQRKV59AlZBc)

[^6]: Accessibility. EBSCO Information Services. \[accessed 13 July 2023\]. [https://www.ebsco.com/technology/accessibility#:~:text=Questions%20about%20the%20accessibility%20of%20our%20products%3F](https://www.ebsco.com/technology/accessibility#:~:text=Questions%20about%20the%20accessibility%20of%20our%20products%3F)

[^7]: Email from Clarivate Sales. 19 July 2023.

[^8]: Reminder that Ex Libris is now owned by Clarivate. ProQuest bought Ex Libris from Golden Gate Capital in 2015. ProQuest, including Ex Libris, was in turn acquired by Clarivate in 2021. For an extensive genealogy, see Marshall Breeding’s mergers and acquisitions charts: [https://librarytechnology.org/mergers/](https://librarytechnology.org/mergers/)

[^9]: 2023 Library Systems Report. 1 May 2023. Marshall Breeding. American Libraries Magazine. \[accessed 13 July 2023\]. [https://americanlibrariesmagazine.org/2023/05/01/2023-library-systems-report/](https://americanlibrariesmagazine.org/2023/05/01/2023-library-systems-report/)

[^10]: Summon: Exporting Catalog Holdings – Uploading to Summon. 6 December 2016. Ex Libris Knowledge Center. \[accessed 13 July 2023\]. [https://knowledge.exlibrisgroup.com/Summon/Product\_Documentation/Configuring\_The\_Summon\_Service/Working\_with\_Local\_Collections\_in\_the\_Summon\_Service/Getting\_Local\_Collections\_Loaded\_into\_the\_Summon\_Index/Summon%3A\_Exporting\_Catalog\_Holdings\_-\_Uploading\_to\_Summon#Exporting\_Your\_Records](https://knowledge.exlibrisgroup.com/Summon/Product_Documentation/Configuring_The_Summon_Service/Working_with_Local_Collections_in_the_Summon_Service/Getting_Local_Collections_Loaded_into_the_Summon_Index/Summon%3A_Exporting_Catalog_Holdings_-_Uploading_to_Summon#Exporting_Your_Records)

[^11]: Email from Ex Libris. 9 June 2023.

[^12]: Summon: Real-Time Availability of Items in Library Catalog. 17 November 2022. Ex Libris Knowledge Center. \[accessed 13 July 2023\]. [https://knowledge.exlibrisgroup.com/Summon/Product\_Documentation/Searching\_in\_The\_Summon\_Service/Search\_Results/Summon%3A\_Real-Time\_Availability\_of\_Items\_in\_Library\_Catalog](https://knowledge.exlibrisgroup.com/Summon/Product_Documentation/Searching_in_The_Summon_Service/Search_Results/Summon%3A_Real-Time_Availability_of_Items_in_Library_Catalog)

[^13]: Summon Accessibility Statement. 14 February 2023. Ex Libris Knowledge Center. \[accessed 28 July 2023\] [https://knowledge.exlibrisgroup.com/Summon/Product\_Materials/Summon\_Accessibility\_Statement](https://knowledge.exlibrisgroup.com/Summon/Product_Materials/Summon_Accessibility_Statement)

[^14]: Clarivate: Summon Accessibility Conformance Report International Edition. February 2023. Ex Libris Knowledge Center. \[accessed 28 July 2023\] [https://pq-static-content.proquest.com/collateral/media2/documents/s](https://pq-static-content.proquest.com/collateral/media2/documents/summon_vpat.pdf)[ummon\_vpat.pdf](https://pq-static-content.proquest.com/collateral/media2/documents/summon_vpat.pdf)

[^15]: Conversation with OCLC sales rep. 22 June 2023.

[^16]: OCLC accessibility statement. 2023. OCLC.org. \[accessed 28 July 2023\] [https://policies.oclc.org/en/accessibility.html](https://policies.oclc.org/en/accessibility.html)

[^17]: To request OCLC’s VPATs, including for WorldCat Discovery:  [https://help.oclc.org/Librarian\_Toolbox/Troubleshooting/How\_do\_I\_request\_a\_VPAT\_for\_an\_OCLC\_product](https://help.oclc.org/Librarian_Toolbox/Troubleshooting/How_do_I_request_a_VPAT_for_an_OCLC_product)

[^18]: edsapi-ruby \[Blacklight-EDS API connection\]. 23 July 2022. EBSCO GitHub. \[accessed 28 July 2023\] [https://github.com/ebsco/edsapi-ruby](https://github.com/ebsco/edsapi-ruby)

[^19]: Integrating Blacklight with Alma and an Ex Libris Central Index. 18 December 2018. Ex Libris Developer Network. \[accessed 28 July 2023\] [https://developers.exlibrisgroup.com/blog/summon-index-and-the-alma-link-resolver/](https://developers.exlibrisgroup.com/blog/summon-index-and-the-alma-link-resolver/)

[^20]: How does the bento/single search work? 12 June 2014. CUL Discovery and Access blog. \[accessed 28 July 2023\] [https://blogs.cornell.edu/discoveryandaccess/2014/06/12/how-does-the-bento-single-search-work/](https://blogs.cornell.edu/discoveryandaccess/2014/06/12/how-does-the-bento-single-search-work/)

[^21]: Conversation with Debra Howell. 16 September 2022.

[^22]: cul-my-account. 21 March 2023. cul-it GitHub \[Cornell University\]. \[accessed 28 July 2023\] [https://github.com/cul-it/cul-my-account](https://github.com/cul-it/cul-my-account)

[^23]: Conversation with Sarah Seestone and Darsi Rueda. 23 June 2023.

[^24]: repo:projectblacklight/blacklight accessibility. GutHub. \[accessed 28 July 2023\] [https://github.com/projectblacklight/blacklight/search?q=accessibility&type=commits](https://github.com/projectblacklight/blacklight/search?q=accessibility&type=commits)

[^25]: Blended Search. 16 February 2023. VuFind. \[accessed 28 July 2023\] [https://vufind.org/wiki/configuration:blender](https://vufind.org/wiki/configuration:blender)

[^26]: Deep Dive into the Blender Search Backend. 14 September 2022. Ere Maijala. 2022 VuFind Summit. \[accessed 28 July 2023\] [https://www.youtube.com/watch?v=-CWgWnKCk\_0&list=PL5\_8\_wT3JpgGQ9an5Ya8GYdyKKdYpSUD8&index=6](https://www.youtube.com/watch?v=-CWgWnKCk_0&list=PL5_8_wT3JpgGQ9an5Ya8GYdyKKdYpSUD8&index=6)

[^27]: Projects. 2023. Open Library Foundation. \[accessed 28 July 2023\] [https://openlibraryfoundation.org/projects/](https://openlibraryfoundation.org/projects/)

[^28]: Products. 2023. Equinox Open Library Initiative. \[accessed 28 July 2023\] [https://www.equinoxoli.org/](https://www.equinoxoli.org/)

[^29]: Conversation with Tod Olson. 2 November 2022.

[^30]: Conversation with Paula Sullenger. 21 September 2022.

[^31]: Video Discussion: Theme Accessibility. 7 April 2020. VuFind. \[accessed 28 July 2023\] [https://vufind.org/wiki/videos:theme\_accessibility](https://vufind.org/wiki/videos:theme_accessibility)

[^32]: Equinox Announces Accessible VuFind Theme. 21 April 2023. Equinox Open Library Initiative. \[accessed 28 July 2023\] [https://www.equinoxoli.org/equinox-announces-accessible-vufind%E2%93%A1-theme/](https://www.equinoxoli.org/equinox-announces-accessible-vufind%E2%93%A1-theme/)

[^33]: [https://vufind.org/wiki/community:pmc\_meetings:minutes20230606](https://vufind.org/wiki/community:pmc_meetings:minutes20230606)

[^34]: Email from Jordan Fields, ByWater Solutions. 8 June 2023.

[^35]: Email from Jordan Fields, ByWater Solutions. 14 June 2023.

[^36]: EBSCO Locate \[Locate demo site\]. 2022. EBSCO. \[accessed 28 July 2023\] [https://demo.locate.ebsco.com/search](https://demo.locate.ebsco.com/search)

[^37]: Locate Frequently Asked Questions. 26 July 2023. EBSCO Connect. \[accessed 7 July 2023\] [https://connect.ebsco.com/s/article/Locate-Frequently-Asked-Questions-for-Administrators?language=en\_US](https://connect.ebsco.com/s/article/Locate-Frequently-Asked-Questions-for-Administrators?language=en_US)

[^38]: Music Discovery Requirements, version 2. August 2017. Music Discovery Requirements Update Task Force, Music Library Association. \[accessed 28 July 2023\] [https://cdn.ymaws.com/www.musiclibraryassoc.org/resource/resmgr/mdr/MusicDiscoveryRequirements2.pdf](https://cdn.ymaws.com/www.musiclibraryassoc.org/resource/resmgr/mdr/MusicDiscoveryRequirements2.pdf)

[^39]: Conversation with Grand Valley State University librarians. 14 July 2023.

[^40]: EBSCO Information Services Accessibility Conformance Report International Edition. May 2023. EBSCO Connect. \[accessed 28 July 2023\] [https://connect.ebsco.com/s/file-download?param=/sfc/p/1H000000P2eP/a/5a000000mKyX/EshWuEF2Zsn0faLF54NtnartoMIl4.jSlGIU0pxnkCM](https://connect.ebsco.com/s/file-download?param=/sfc/p/1H000000P2eP/a/5a000000mKyX/EshWuEF2Zsn0faLF54NtnartoMIl4.jSlGIU0pxnkCM)

[^41]: Email from Soutron sales rep. 15 December 2022.

[^42]: Discovery & Delivery. 2021. TDNet. \[accessed 28 July 2023\] [https://www.tdnet.io/services/discovery](https://www.tdnet.io/services/discovery)

## Thanks

We are very grateful to the library workers who shared information and their experiences with us. We are also grateful to the vendor reps who answered our questions, and to the other librarians who contacted their vendor reps on our behalf when we couldn’t get in touch with vendors ourselves. Of particular note are Ruth Kitchin Tillman, Noah Brubaker, Marian Carney, Debra Howell, Darsi Rueda, Sarah Seestone, Paula Sullenger, and Bill Kessler.

## About the Authors

Aaron Neslin ([aneslin@umass.edu](https://journal.code4lib.org/articles/)) is the FOLIO Coordinator at the Five College Consortium.

Jaime Taylor ([jaimetaylor@umass.edu](https://journal.code4lib.org/articles/)) is the Discovery & Resource Management Systems Coordinator at the University of Massachusetts Amherst, which is part of the Five College Consortium.

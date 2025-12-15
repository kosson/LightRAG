---
title: "Advancing ARKs in the Historical Ontology Space"
source: "https://journal.code4lib.org/articles/15608"
author:
  - "Mat Kelly"
  - "Christopher B. Rauch"
  - "Jane Greenberg"
  - "Sam Grabus"
  - "Joan Boone"
  - "John Kunze"
  - "Peter M. Logan"
published: 2021-02-10
created: 2025-01-10
description: "This paper presents the application of Archival Resource Keys (ARKs) for persistent identification and resolution of concepts in historical ontologies. Our use case is the 1910 Library of Congress Subject Headings (LCSH), which we have converted to the Simple Knowledge Organization System (SKOS) format and will use for representing a corpus of historical Encyclopedia Britannica [...]"
tags:
  - "#ARK"
  - "#ontology"
  - "#unique/identifier"
---
# Advancing ARKs in the Historical Ontology Space
Mat Kelly, Christopher B. Rauch, Jane Greenberg, Sam Grabus, Joan Boone, John Kunze, Peter M. Logan

This paper presents the application of Archival Resource Keys (ARKs) for persistent identification and resolution of concepts in historical ontologies. Our use case is the 1910 Library of Congress Subject Headings (LCSH), which we have converted to the Simple Knowledge Organization System (SKOS) format and will use for representing a corpus of historical Encyclopedia Britannica articles. We report on the steps taken to assign ARKs in support of the Nineteenth-Century Knowledge Project, where we are using the HIVE vocabulary tool to automatically assign subject metadata from both the 1910 LCSH and the contemporary LCSH faceted, topical vocabulary to enable the study of the evolution of knowledge.

## Introduction

The 19th-Century Knowledge Project is building an extensive, open, digital archival collection to support the study of knowledge and its transformation. The project uses both the contemporary Library of Congress Subject Headings and the 1910 LCSH for topical representation. The use of both ontologies provides more comprehensive access to the material and facilitates the study of knowledge over time [\[1\]](https://journal.code4lib.org/articles/#note1).

One of the most important early development decisions relating to the publication of the project was the application of ontologies with persistent identifiers (PIDs) for subject representation [\[2\]](https://journal.code4lib.org/articles/#note2). This was necessary even in the very first stages of the project because we planned to use identifiers as the functional reference for both users and in coding, templating, and implementation.

The challenge is that many ontologies do not have PIDs, particularly historical terminologies. Additionally, not all approaches for persistent identifiers are suited for ontologies. Many PIDs have heavy requirements and costs associated with their creation, formatting, and resolution. Handles and DOIs impose annual and/or per-identifier fees, and both require use of their centralized registration and resolution mechanisms. DOIs have strict metadata requirements that are hard to meet during development and pre-publication stages.We chose the ARK (Archival Resource Key) as our identifier scheme for historical ontologies because the requirements and costs are relatively low [\[3\]](https://journal.code4lib.org/articles/#note3). Any institution can create an unlimited number of ARKs without paying for the right to do so. Institutions can also assign ARKs to any research objects they wish. This can safely be done in the planning stages well before the object is created or published since planners can keep their ARKs as private as their plans, and resolution does not need to be enabled until the objects are unveiled for wider use [\[4\]](https://journal.code4lib.org/articles/#note4).

Archival Resource Keys (ARKs) have been used as persistent identifiers (PIDs) for vocabulary projects, such as the PeriodO, which has curated a canonical dataset of time periods [\[5\]](https://journal.code4lib.org/articles/#note5), and the YAMZ.net crowdsourced metadata dictionary [\[6\]](https://journal.code4lib.org/articles/#note6). These exemplary projects, however, do not investigate the suitability of ARKs for historical ontologies.

## ARKs and the 19th-Century Knowledge Project

This project began with the attempt to expand the utility of the 1910 vocabulary by building on an existing vocabulary server, Helping Interdisciplinary Vocabulary Engineering (HIVE) [\[7\]](https://journal.code4lib.org/articles/#note7), and assigning unique identifiers to both the ontology itself, and its terms. We recognized that to refer to terms uniquely would require a unique identifier. The problem that we encountered was twofold. First, the electronic structure of the repository we were trying to describe (individual entries across four historical editions of the *Encyclopedia Britannica*) was itself under development, and second, the full transformation of the 1910 LCSH to the SKOS format was a multi-step process, given historical conventions of terminology design and those that align more with computational approaches guiding today’s work.

The 19th-Century Knowledge Project uses historic editions of the Encyclopedia Britannica to build an open digital collection of the Encyclopedia’s contents. Automatic metadata generation is being used for assigning topical metadata. A set of 130,000 entries are being processed first through the Stanford Name Entity Recognizer [\[8\]](https://journal.code4lib.org/articles/#note8), followed by the application of SKOS enabled versions of both the 1910 LCSH vocabulary and the LCSH FAST topical vocabulary. Because multiple passes were required to prepare each encyclopedia entry with metadata for discovery and access, we needed a flexible PID that we could assign to terms at the beginning of a multi-step workflow during which the terms would evolve considerably. While we completed this work, we also wanted to resolve those PIDs for ourselves before going public with them. These requirements steered our choice of PID to the ARK scheme [\[9\]](https://journal.code4lib.org/articles/#note9), and the remainder of this article describes how we implemented ARKs for the 1910 LCSH, from minting, to resolution, to metadata.

## Minting ARKs

There is no prescribed way to create and maintain ARKs, and the method we chose is based on the popular open source NOID (Nice Opaque Identifiers) [\[10\]](https://journal.code4lib.org/articles/#note10) utility, which includes a command line script and a lower-level module that runs on Linux, Mac, and Windows systems. This utility provides an easy way to mint (generate) unique, opaque strings ending in a check digit that can be used to detect the most common transcription errors. The outputs of the NOID minting function are used during ARK creation. NOID also offers optional resolver and metadata management functions, but they are independent of minting – one can use the latter without the former or vice versa. We chose to use our own resolver and metadata database.

Uniqueness is a concern for any PID scheme. Relational databases make local uniqueness easy to ensure when database tables are first set up. That provides a failsafe behind the NOID minting function’s own assurance of uniqueness. Global uniqueness is then ensured by prepending a globally unique “prefix” to the locally minted string. In the usual ARK scenario that “prefix” is formed by appending a NAAN (Name Assigning Authority Number) to the “ark:/” label. A NAAN uniquely identifies a managed assignment workflow, typically that of a cultural heritage organization. Large organizations often have multiple workflows, for which they delegate assignment via a prefix formed by extending their NAAN with a short, unique string assigned to each separate workflow. That extended prefix is known as a “shoulder” [\[11\]](https://journal.code4lib.org/articles/#note11). Just like the NAAN-based prefix, the shoulder-based prefix is globally unique and so any ARK starting with such a prefix will be globally unique, provided the workflow keeps the assignments locally unique.

For all its virtues in the face of change, opacity takes a toll on usability. There are a few cases where slightly reducing opacity is considered safe and useful, and these are signaled by ARKs bearing one of four well-known “shared NAANs” that aren’t associated with any particular organization. Two of those NAANs are for test (99999) or example (12345) ARKs that aren’t “real” enough for link-checkers to bother with. The other two are for identifying things that are either vocabulary terms (99152) or “agents” (99166), both of which are considered immutable properties of such things. While 99152 doesn’t exactly scream “vocabulary term” to the average person, receiving software can usefully recognize these four NAAN and leverage the semantics without having to fetch any ARK metadata. Both a per-organization NAAN and a per-organization shoulder under one of the four shared NAANs are globally unique prefixes that must be requested [\[12\]](https://journal.code4lib.org/articles/#note12).

NOID is an open source Perl package available via CPAN (Comprehensive Perl Archive Network). After installing the CPAN package manager [\[13\]](https://journal.code4lib.org/articles/#note13), we installed the NOID package and its associated dependencies. For our Debian Linux environment, this required the installation of the Perl Berkeley Database wrapper (libberkeleydb-perl) [\[14\]](https://journal.code4lib.org/articles/#note14) to support the BerkeleyDB module dependency [\[15\]](https://journal.code4lib.org/articles/#note15).

We executed the following command to create the identifier database, which creates a directory called NOID and places the ARK minter database within.

| 1 | `$ noid dbcreate b4.reedeedk long 99152 cci.drexel.edu mrc/lcsh1910` |
| --- | --- |

The parameters of this command have the following significance [\[16\]](https://journal.code4lib.org/articles/#note16):

- b4 is the shoulder (prefix) for the LCSH1910 vocabulary and
- reedeedk is a template for the ark, in which
- r requests quasi-randomly generated identifiers,
- e requests an “extended digit”, one of { 0123456789bcdfghjkmnpqrstvwxz } (“betanumeric”, which is the set of alphanumeric characters minus vowels and the letter “l”),
- d requests a pure digit, one of { 0123456789 },
- k requests a check character to detect transcription errors,
- long is a declaration of the intended longevity of an identifier and establishes extra restrictions to ensure no identifier will be generated twice. Other options are short (for generating identifier strings that may be re-used) and medium,
- the 99152 is the NAAN associated with the minter, which requests that it generate strings prefixed with 99152/b4), and
- the final two arguments, cci.drexel.edu and mrc/lcsh1910, are the Name Mapping Authority and a string chosen by the person setting up the minter to identify the project that will be operating it, respectively; these effectively become minimal minter provenance metadata [\[17\]](https://journal.code4lib.org/articles/#note17).

Thus established, the minter database represents that initial “state” of the minter. That state changes after each minting operation so that the minter does not lose track of what it has minted already. Next, we issued the command to generate our first 30,000 ARK strings,

There are approximately 29,000 terms in the 1910 ontology, so this became our pool strings with which to create ARKs. Note that NOID distinguishes the act of minting an identifier (generating a candidate string) from the act of creating an identifier (associating that string with a thing). From the pool of strings “waiting” to be assigned, some will become identifiers and some will be discarded, which is by design. Moreover, among those that become identifiers, some might never be shared beyond the confines of the database, some might never be shared beyond immediate team members, and some might be published (whether deliberately or accidentally) widely on the Internet. The last of these steps — publication, not creation — is the least revocable and thus the most consequential. Therefore, we create ARKs in a less committed manner than we publish them.

When the minting process is complete, the minter state, stored as a Berkeley DB database in the NOID directory, reflects that 30,000 strings were minted. The database can be manipulated using any Berkeley DB client API (Perl, C, Python, Java, etc.) or the NOID utility, and additional ARKs can be generated against the database in the event they are needed. The database is filesystem-based (rather than server-based), so it does not require an external server and can be ported to any machine that has the appropriate libraries installed. The NOID directory itself can be renamed and moved aside so that a new list of ARKs can be generated according to different initial input parameters (shoulder and NAAN).

To expedite the assignment of ARKs to the related subject terms, rather than manipulating the minter database, we used a shortcut. When the mint command is given, the ARKs are also written to standard output. To capture them, we used the “tee” command [\[18\]](https://journal.code4lib.org/articles/#note18),

| 1 | `$ noid mint 30000 \| tee arks.txt ` |
| --- | --- | --- |

In the future, we also plan to integrate the functionality of the NOID utility or the associated library into our record creation procedure for vocabulary terms so that the ARKs are generated when the term entry is created.

![Figure 1: Minting ARKs using the NOID utility.](https://journal.code4lib.org/media/issue50/kelly/01.png "Figure 1: Minting ARKs using the NOID utility.")

**Figure 1.** Minting ARKs using the NOID utility.

## ARK Resolution

The global ARK resolver, N2T.net, contains redirection rules based on NAANs or on shoulders for institutions that publish their ARKs using n2t.net in the hostname. This mechanism relies on rules that recognize incoming ARK prefixes (NAANs or shoulders) and sends the ARKs to the target institutional resolvers associated with those prefixes. Institutions generally register a NAAN for this purpose, which we have obtained, but in our case, we saw an advantage to also registering a shoulder on a particular shared NAAN [\[19\]](https://journal.code4lib.org/articles/#note19), 99152, because it signals to specialists (e.g., software) that such ARKs are for “terms”. While this choice to disclose semantics makes for a less opaque identifier, it does not threaten longevity since the property of being a “term” is immutable and can be expected not to change.

In order to associate the 1910 ontology with our institutional server, we registered a shoulder “b4,” which we designated to indicate ontologies under our control. The “b4” string is short and opaque: short to help reduce overall identifier length and opaque to shore up overall longevity. This string also conforms to the primordinal (“first digit betanumeric”) shoulder convention, which calls for a sequence of one or more betanumeric characters ending in a digit. Advantages of primordinal shoulders include that there is an infinite number of them possible under any NAAN [\[20\]](https://journal.code4lib.org/articles/#note20), and the character repertoire restriction preserves error detection via the check digit. Persistence is served by limiting the potential for semantic degradation that will naturally occur as institutions are reorganized or commonly used names change.

When in the context of a URI, the ARK will be sent to the host through an HTTP (or similar protocol) request. If the ARK is received by the webserver at n2t.net [\[21\]](https://journal.code4lib.org/articles/#note21) it will redirect based on the b4 shoulder of the object name of the term to an authoritative server for b4. This might take the form [https://historical-ontologies.info/ark:/99152/b4cc2g3s](https://historical-ontologies.info/ark:/99152/b4cc2g3s) [\[22\]](https://journal.code4lib.org/articles/#note22).

To design our resolver, we used Nginx, Python-based Django, and Django’s REST frameworks with MySQL and ReactJS for the interface. The project is currently hosted on resources allocated from the Extreme Science and Engineering Discovery Environment (XSEDE) project. XSEDE allocates compute resources to (US-based) applicants in pursuit of reproducible science [\[23\]](https://journal.code4lib.org/articles/#note23).

The Nginx webserver at [https://historical-ontologies.info](https://historical-ontologies.info/) acts as a secure reverse proxy [\[24\]](https://journal.code4lib.org/articles/#note24). It receives the HTTP request and parses it according to the pattern described in the Nginx configuration file. This, in turn, calls the corresponding matching function in the React Node.js application running as a background using PM2 (Process Management Model) [\[25\]](https://journal.code4lib.org/articles/#note25)). A React component then passes the ARK id internally to the API endpoint exposed by the Django REST Framework to retrieve and display the associated record contents. In future work, the ARK will be checked here for transcription errors and validated against the existing database of ARKs created by the minting process. The NOID utility provides hooks so that it can be called on to do this work [\[26\]](https://journal.code4lib.org/articles/#note26). After all tests have passed, the part of the function that renders the view proceeds, and the term represented by the ARK and its associated metadata is returned according to the corresponding view template.

The term itself is displayed in the context of the ontology and resembles a typical term entry for an ontology.

![Figure 2. The term “Abbeys” displayed with associated ARK and links to HIVE data.](https://journal.code4lib.org/media/issue50/kelly/02.png "Figure 2. The term “Abbeys” displayed with associated ARK and links to HIVE data.")

**Figure 2.** The term “Abbeys” displayed with associated ARK and links to HIVE data.

## ARK Metadata and Transformation

Part of the usefulness of the ARK ecosystem is that it encourages stewardship of digital objects by encouraging metadata that speaks to institutional commitment as well as to object description. It is possible to add inflections to ARKs to query the metadata associated with it. (Under development are extensions that would allow inflection arguments to request metadata in arbitrary format [\[27\]](https://journal.code4lib.org/articles/#note27).) This metadata might be in any format or of any type but adding the ‘?info’ inflection is expected specifically to include an assertion of the organizational commitment to persistence. Our implementation generally follows the DCMI (Dublin Core Metadata Initiative) draft specification for Kernel Metadata [\[28\]](https://journal.code4lib.org/articles/#note28). For example, [http://historical-ontologies.info/ark:/99152/b4cc2g3s/?info](http://historical-ontologies.info/ark:/99152/b4cc2g3s/?info) might return the kernel metadata “about” statement along with the support statement related to commitment [\[29\]](https://journal.code4lib.org/articles/#note29).

erc:  
who: Nineteenth Century Knowledge Project  
what: Library of Congress Subject Heading Term: “Abbeys”  
when: 1910  
where: Library of Congress. Subject headings used in the dictionary catalogues of the Library of Congress, Vols. 1-5. Washington: G.P.O., Library Branch, 1910-1914.

erc-support:  
support-who: Metadata Research Center at Drexel University  
support-what: Permanent: Stable Content.  
support-when: 2020.12.03  
support-where: https://historical-ontologies.info/ark:/99152/b4cc2g3s/?commitment

**Figure 3.** Collection related kernel metadata returned using the ?info inflection

As depicted in Figure 3, using the ARK naming scheme permits the use of inflections to qualify a request to retrieve different forms of the data. In principle, content negotiation achieves the same end, but it requires software to use special protocol headers. Inflections make the entire request transparent when submitting a modified ARK to any web browser. By publishing an endpoint that will always return the latest version of the ontology and exposing the services it can provide, data can be returned in a variety of formats.

The current resolver we are constructing is intended to resolve ARKs based on the URI of a GET request. While the ARK specification standard does not preclude incorporating content negotiation into the services provided, we have not yet identified a use case specific to the LCSH1910 ontology for this retrieval method. The service at historical-ongologies.info is intended as an intermediary between an ARK resolver and the underlying vocabulary server, HIVE [\[30\]](https://journal.code4lib.org/articles/#note30). Further integration may occur, but this separation of concerns is intended to make the ARK resolver useful to additional projects.

We recognize there is room for expanding in this approach. For example, additional transformations might be performed on requests that can be made using variations on these inflections. Directives inferred from these inflections would pass through to the responsible data source (in this case, the HIVE vocabulary server) to return metadata in various formats or even include the retrieval of associated scanned records or representations of digital objects in various stages of processing from a third system. In this way the resolver would act as an aggregator of services related to each term entry.

## Conclusion

The preparation of a large corpus of text as represented by the 19th Century Knowledge Project’s electronic publication of historical volumes of the Encyclopedia Britannica is made more useful when described by appropriate metadata, including topical terms drawn from a standard ontology. Automatic metadata generation helps to address the daunting nature of this task. Additionally, standardized terminology enables collocation during information retrieval, aids a researcher in discovering relevant information, and provides insight into the topicality (aboutness) of a resource. Unique identifiers are as much a part of the software development process of a publication framework as they are of the ultimate publication of the underlying collection itself. Using the ARK persistent identifier allowed the early incorporation of unambiguous references to objects that enhanced the workflow of deriving metadata from multi-faceted sources. We have outlined the steps undertaken to assign these identifiers for our project in the hope that it may guide other researchers who wish to employ a similar process for assigning unique identifiers to terms.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] *Nineteenth-Century Knowledge Project.* [https://tu-plogan.github.io/](https://tu-plogan.github.io/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] For a general discussion, see Koster L. *Persistent identifiers for heritage objects.* The Code4Lib Journal. Issue 47, 2020 Feb 17 [https://journal.code4lib.org/articles/14978](https://journal.code4lib.org/articles/14978) and Kelly M, Greenberg J, Rauch CB, Grabus S, Boone JP, Kunze JA, Logan PM. *A Computational Approach to Historical Ontologies.* arXiv:2011.13114 \[cs\]. 2020 Nov 25. [http://arxiv.org/abs/2011.13114](http://arxiv.org/abs/2011.13114).

\[[3](https://journal.code4lib.org/articles/#ref3)\] Kunze J. *Ten persistent myths about persistent identifiers.* 2018 Aug 24. [https://escholarship.org/uc/item/73m910w8](https://escholarship.org/uc/item/73m910w8)

\[[4](https://journal.code4lib.org/articles/#ref4)\] *ARK Identifier FAQ- Arks in the Open.* [https://wiki.lyrasis.org/display/ARKs/ARK+Identifiers+FAQ](https://wiki.lyrasis.org/display/ARKs/ARK+Identifiers+FAQ)

\[[5](https://journal.code4lib.org/articles/#ref5)\] PeriodO – *Periods, Organized.* [https://perio.do/en/](https://perio.do/en/)

\[[6](https://journal.code4lib.org/articles/#ref6)\] The YAMZ metadictionary: [https://yamz.herokuapp.com/](https://yamz.herokuapp.com/)

\[[7](https://journal.code4lib.org/articles/#ref7)\] The current iteration of HIVE prior to the assignment of ARK persistent identifiers: [https://hive2.cci.drexel.edu/](https://hive2.cci.drexel.edu/)

\[[8](https://journal.code4lib.org/articles/#ref8)\] The Stanford Named Entity Recognizer (NER): [https://nlp.stanford.edu/software/CRF-NER.shtml](https://nlp.stanford.edu/software/CRF-NER.shtml)

\[[9](https://journal.code4lib.org/articles/#ref9)\] For a comprehensive overview Archival Resource Keys (ARKs), see the project wiki: [https://wiki.lyrasis.org/display/ARKs/ARKs+in+the+Open+Project](https://wiki.lyrasis.org/display/ARKs/ARKs%2Bin%2Bthe%2BOpen%2BProject)

\[[10](https://journal.code4lib.org/articles/#ref10)\] More detailed instructions on using the NOID module are available on its CPAN homepage: [https://metacpan.org/pod/distribution/Noid/noid](https://metacpan.org/pod/distribution/Noid/noid)

\[[11](https://journal.code4lib.org/articles/#ref11)\] *ARK Shoulder FAQ – ARKs in the Open.* [https://wiki.lyrasis.org/display/ARKs/ARK+Shoulders+FAQ](https://wiki.lyrasis.org/display/ARKs/ARK%2BShoulders%2BFAQ)

\[[12](https://journal.code4lib.org/articles/#ref12)\] NAAN request form: [https://n2t.net/e/naan\_request](https://n2t.net/e/naan_request)

\[[13](https://journal.code4lib.org/articles/#ref13)\] Installing CPAN Modules: [https://www.cpan.org/modules/INSTALL.html](https://www.cpan.org/modules/INSTALL.html)

\[[14](https://journal.code4lib.org/articles/#ref14)\] The Debian distribution of the libberkeleydb-perl package: [https://packages.debian.org/sid/libberkeleydb-perl](https://packages.debian.org/sid/libberkeleydb-perl)

\[[15](https://journal.code4lib.org/articles/#ref15)\] The dependency can also be satisfied by installing the BerkeleyDB Perl module: [https://metacpan.org/pod/BerkeleyDB](https://metacpan.org/pod/BerkeleyDB)

\[[16](https://journal.code4lib.org/articles/#ref16)\] A more complete explanation of how templates work in NOID: [https://metacpan.org/pod/distribution/Noid/noid#TEMPLATES](https://metacpan.org/pod/distribution/Noid/noid%23TEMPLATES)

\[[17](https://journal.code4lib.org/articles/#ref17)\] EZID: Identifier Concepts and Practices at the California Digital Library. [https://ezid.cdlib.org/learn/id\_concepts](https://ezid.cdlib.org/learn/id_concepts)

\[[18](https://journal.code4lib.org/articles/#ref18)\] Tee invocation: [https://www.gnu.org/software/coreutils/manual/html\_node/tee-invocation.html](https://www.gnu.org/software/coreutils/manual/html_node/tee-invocation.html)

\[[19](https://journal.code4lib.org/articles/#ref19)\] Information about shared NAANs and shoulders: [https://wiki.lyrasis.org/display/ARKs/ARK+Identifiers+FAQ#ARKIdentifiersFAQ-shoulders](https://wiki.lyrasis.org/display/ARKs/ARK%2BIdentifiers%2BFAQ%23ARKIdentifiersFAQ-shoulders)

\[[20](https://journal.code4lib.org/articles/#ref20)\] For example, ark:/99152/b41910/cc2g3s has the shoulder b4. In this case, each shoulder is a string of one or more letters ending in a digit (inclusive). There could be an unlimited number of additional shoulders added to the general NAAN including b4, bb4, bbc4, etc. following this convention.

\[[21](https://journal.code4lib.org/articles/#ref21)\] The registry for NAANs maintained by n2t.net: [https://n2t.net/e/pub/naan\_registry.txt](https://n2t.net/e/pub/naan_registry.txt)

\[[22](https://journal.code4lib.org/articles/#ref22)\] This URI points to a demonstration of how a resolver might integrate with the HIVE vocabulary server at [https://hive2.cci.drexel.edu/](https://hive2.cci.drexel.edu/)

\[[23](https://journal.code4lib.org/articles/#ref23)\] For US based researchers, it is possible to request compute resources from the NSF (National Science Foundation) funded XSEDE (Extreme Science and Engineering Discovery Environment): [https://www.xsede.org/ecosystem/resources](https://www.xsede.org/ecosystem/resources). See also: John Towns, Timothy Cockerill, Maytal Dahan, Ian Foster, Kelly Gaither, Andrew Grimshaw, Victor Hazlewood, Scott Lathrop, Dave Lifka, Gregory D. Peterson, Ralph Roskies, J. Ray Scott, Nancy Wilkins-Diehr, *XSEDE: Accelerating Scientific Discovery,* Computing in Science & Engineering, vol.16, no. 5, pp. 62-74, Sept.-Oct. 2014, doi:10.1109/MCSE.2014.80

\[[24](https://journal.code4lib.org/articles/#ref24)\] See NGINX Reverse Proxy. NGINX Documentation. [https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)

\[[25](https://journal.code4lib.org/articles/#ref25)\] *How to Setup PM2 and Run Node.js Applications.* Fit-DevOps. [https://fitdevops.in/how-to-setup-pm2-and-run-node-js-applications/](https://fitdevops.in/how-to-setup-pm2-and-run-node-js-applications/)

\[[26](https://journal.code4lib.org/articles/#ref26)\] NOID – nice opaque identifier generator commands – metacpan.org. *Name resolution and redirection interface.* [https://metacpan.org/pod/distribution/Noid/noid#NAME-RESOLUTION-AND-REDIRECTION-INTERFACE](https://metacpan.org/pod/distribution/Noid/noid%23NAME-RESOLUTION-AND-REDIRECTION-INTERFACE)

\[[27](https://journal.code4lib.org/articles/#ref27)\] Kunze J, Calvert S, DeBarry J, Hanlon M, Janée G, Sweat S. *Persistence statements: describing digital stickiness.* 2016 Nov 10. [https://escholarship.org/uc/item/2zm9x47c](https://escholarship.org/uc/item/2zm9x47c)

\[[28](https://journal.code4lib.org/articles/#ref28)\] Kernel metadata is a small prescriptive vocabulary designed to support highly uniform but minimal object descriptions for the purpose of orderly collection management. *DCMI Kernel Metadata Community: Kernel Metadata and Electronic Resource Citations (ERCs).* [https://dublincore.org/groups/kernel/spec/](https://dublincore.org/groups/kernel/spec/)

\[[29](https://journal.code4lib.org/articles/#ref29)\] Traditionally, ARKs had the single and double question mark (’??’) inflections to request a short or long (full) record. The ’?info’ inflection is designed to be easier to recognize, and a number of parameters are being considered by the ARKsInTheOpen Tech WG.

\[[30](https://journal.code4lib.org/articles/#ref30)\] *Helping Interdisciplinary Vocabulary (HIVE).* [https://hive2.cci.drexel.edu/](https://hive2.cci.drexel.edu/)

## About the Authors

Mat Kelly (mkelly@drexel.edu) is an Assistant Professor in the Department of Information Science at Drexel University’s College of Computing and Informatics. He holds a Ph.D. in Computer Science from Old Dominion University. His research focuses on digital preservation with a specialization in archiving and accessing private web content.

Christopher Rauch is currently a PhD student at Drexel University’s College of Computing and Informatics. He holds Master of Science degrees in Library and Information Science and Information Systems from Drexel and a JD from Rutgers Law School. He is a recent collaborator with the Metadata Research Center at Drexel and a former Army National Guard Signal Officer.

Jane Greenberg is the Alice B. Kroeger Professor and Director of the Metadata Research Center at the College of Computing & Informatics, Drexel University. Her research activities focus on metadata, knowledge organization/semantics, linked data, data science, and information economics. Her research has been funded by the NSF, NIH, IMLS, NEH, Microsoft Research, GlaxoSmithKline, Santander Bank, Library of Congress, as well as other agencies and organizations.

Sam Grabus is an Information Science PhD Candidate at Drexel University’s College of Computing & Informatics, where she received her MSLIS (2016). She is also a Research Assistant for Drexel’s Metadata Research Center, and Project Manager for the LEADING fellowship program. Her primary research is centered on knowledge organization systems, relevance, and automated subject representation for digital humanities resources.

Joan Boone (jpboone@email.unc.edu) is an Adjunct Instructor at the University of North Carolina at Chapel Hill and Drexel University. She holds an MS in Applied Science from the College of William and Mary, and an MS in Computer Science from the University of North Carolina at Chapel Hill. Prior to teaching, she spent most of her career as a senior software engineer at IBM where she worked in the software labs developing networking middleware and mobile applications.

John Kunze is an Identifier Systems Architect at the California Digital Library. With a background in computer science and mathematics, he wrote BSD Unix software that comes pre-installed with Mac and Linux systems. He created the ARK identifier scheme, the N2T.net scheme-agnostic resolver (which redirects over 600 kinds of “compact identifier”), and contributed heavily to Internet standards for URLs (RFC1736, RFC1625, RFC2056), archiving (BagIt – RFC8493), web archiving (WARC), and Dublin Core metadata (RFC2413, RFC2731).

Peter M. Logan leads the “Nineteenth-Century Knowledge Project,” an effort to identify how knowledge changes over time by analyzing historical editions of Encyclopedia Britannica. This project is funded by the national Endowment for the Humanities. He co-leads the “Online Diaries of ‘Michael Field,’” a TEI-XML edition of writing by two fin-de-siècle women poets. He is emeritus professor of English at Temple University and past Academic Director of the Digital Scholars Studio in Temple University Libraries. He was also instrumental in creating Temple Libraries’ new Cultural Analytics Certificate program.
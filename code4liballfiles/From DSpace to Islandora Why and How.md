---
title: "From DSpace to Islandora: Why and How"
source: "https://journal.code4lib.org/articles/17398"
author:
  - "Vlastimil Krejčíř"
  - "Alžbeta Strakošová"
  - "Jan Adler"
published: 2023-08-29
created: 2025-01-10
description: "The article summarizes the experience of switching from DSpace to Islandora. It briefly gives the historical background and reasons for switching to Islandora. It then compares the basic features of the two systems: installation, updates, operations, and customization options. Finally, it concludes practical lessons learned from the migration and provides examples of implemented digital libraries at Masaryk University."
tags:
  - "#DSpace"
  - "#Islandora"
  - "#migration"
  - "#practical/lesson"
  - "#digital/library"
  - "#Ansible"
---
# From DSpace to Islandora: Why and How

Vlastimil Krejčíř, Alžbeta Strakošová, Jan Adler

The article summarizes the experience of switching from DSpace to Islandora. It briefly gives the historical background and reasons for switching to Islandora. It then compares the basic features of the two systems: installation, updates, operations, and customization options. Finally, it concludes practical lessons learned from the migration and provides examples of implemented digital libraries at Masaryk University.

## Historical background

At the Institute of Computer Science, Masaryk University, we have been working on the topic of digital libraries and repositories for storing digital data for quite a long time. Around 2002, based on an idea of a digital library coming from key articles (Kahn and Wilensky, 1995), (Arms, 1995) and (Bush, 1945), we started to examine systems available at that time. We were looking for a new system for building digital libraries, mainly because we identified the potential need to store digital data among our university users. We carried out a basic analysis of Fedora, DSpace, Eprints, R.I.B., CDSware, and Greenstone. This choice was largely intuitive and did not include other existing systems. Out of this survey, DSpace appeared to be the best system for our needs, attracting our attention as an out-of-the-box compact solution built on the Java platform, ready for immediate deployment and allowing storage of documents of any type. The Fedora system turned out to be equally interesting; still, it only offered the function of a repository, without a user interface. Due to the available capacities of our developers at that time, Fedora did not appear to us as a suitable candidate.

We also considered the DSpace system as an institutional repository, but the university chose a solution within its own student information system. That is why we tried to deploy DSpace for specific data, for example, for storing digital photos. It turned out that the JavaServer Pages technology, which the DSpace GUI was based on, was not suitable for more extensive customizations. The situation changed significantly with the advent of the XMLUI (Manakin) interface, which brought about the separation of individual logical layers of the system, and thus the possibility of making extensive adjustments without the need to interfere with the DSpace code directly. At the same time, we started the project of building the Czech Digital Mathematics Library (DML-CZ) [^1] and subsequently the European Digital Mathematics Library (EuDML)[^2]. Based on our previous experience with DSpace, it was decided to deploy it as a platform for DML-CZ.

The functional requirements for DML-CZ were extensive and included complete support for processing digitized publications, including arranging scans of individual pages and their metadata descriptions. Already at this stage, we encountered a limitation with the capabilities of the DSpace system, which did not have any support for many activities related to scanning. Finally, it was decided to create a separate system for preparing data and metadata and to use DSpace only as a presentation platform for end users and machine data sharing. Therefore, a system called Metadata Editor (ME) (Bartosek et al., 2008) was created (Fig. 1). The data was then only imported into DSpace (including the adjustments needed for its correct display, Fig. 2) using the available DSpace Java API. At the same time, some modifications were made in DSpace to adjust the system to the requirements for the data model (journal -> year -> number -> article) and the specific mathematics subject classification. All these adjustments are described in detail in a paper (Krejcir, 2008). Subsequently, we implemented two more digital libraries for the Masaryk University faculties in a similar way.

![Figure 1. Metadata Editor (ME), editing an article.](https://journal.code4lib.org/media/issue57/Krejcir/fig1-500px.png)  
**Figure 1.** Metadata Editor (ME), editing an article.

The two-track solution had both advantages and disadvantages. The possibility of full control over ME was (and still is) a significant advantage from the point of view of the primary end user: a librarian/researcher preparing metadata and data, whose requirements in terms of functionality can be easily met. Feedback from the primary end users remains positive. However, from the developer’s point of view, building a system from scratch is laborious and expensive. ME was created in the Ruby programming language, version 1.8, which is currently an unsupported version and is not compatible with newer versions. Thus, upgrading would mean largely rewriting the system. Therefore, we were looking for a replacement for ME. DSpace itself as this replacement is not applicable, due to the concept of inserting digital objects, which must respect a defined workflow. This process is well configurable, including the UI, but when it is finished and the input object is published, this object cannot be returned back to the processing stage and can be edited via a simple form in the format of field and plain text value, without all workflow features like form checking, dropdowns, vocabularies etc.

![Figure 2. DSpace, DML-CZ, view of the article presented in Fig. 1.](https://journal.code4lib.org/media/issue57/Krejcir/fig2-500px.png)

**Figure 2.** DSpace, DML-CZ, view of the article presented in Fig. 1.

## DSpace vs. Islandora

Islandora, which we eventually opted for, has proven to be a possible substitute for both ME and DSpace. The rest of this article will present a general comparison of both systems in terms of their philosophy, architecture, and selected properties, summarize our experience with the transition from DSpace to Islandora, and evaluate both systems.

This comparison does not aim to be completely exhaustive; it is primarily based on our experience with both systems. All functionalities described apply, unless stated otherwise, to specific versions of the compared systems: Islandora 8 (2.x) and DSpace 6.3. In the case of DSpace, this is not the latest version 7, which we have no practical experience with, but we will try to draw attention to the improvements that version 7 brings.

### Installing and updating

A user switching from DSpace to Islandora will be confronted with a change in architecture. DSpace is a monolithic system, built almost exclusively on the Java programming language and related technologies and developed from scratch. The user downloads the package with a specific version of DSpace, unpacks it and uses the Apache Maven and Apache Ant tools to compile and install it. The only external components requiring a separate installation are the database system (default PostgreSQL or optional Oracle), the web server, and the servlet container (primarily Apache Tomcat).

The basic DSpace configuration, including, for example, the installation directory, domain name, and UI variant settings, is performed in a single configuration file before installation. The resulting DSpace installation is then compactly stored in one directory on the disk and ready for immediate use.

In the case of Islandora, the situation is more complicated. Islandora is not a single monolithic package, but a compilation of different systems that communicate with each other via APIs and defined interfaces. The individual components are implemented using various technologies. These are third-party components extended by Islandora developers. As a result, the installation of Islandora is not as straightforward and easy as with DSpace. The situation is also confused by the fact that at the turn of 2021 and 2022, Islandora moved to semantic versioning for its individual components: the historical division referring to the versions of Drupal (Islandora 7 and Islandora 8) was abandoned and replaced by the independent labelling of components, including Drupal modules ( Drupal is one of the key components of Islandora), the novice user may want to choose the latest version of Islandora (rather than the legacy version Islandora 7, which is still supported and widespread). At the moment, users are faced with a >decision regarding installation method, which can be done using the Ansible tool or using the Docker system (ISLE – ISLandora Enterprise – variant [^3]).

When using Ansible, it is possible to choose a local variant, where Islandora is installed in a created virtual machine, or a remote installation to a prepared Linux server. The applicable Ansible playbooks will then install all the necessary components directly into the system and perform their complete configuration. This is functional during the initial installation; however, the situation is significantly more complicated during the upgrade, as the result is a set of independent components distributed throughout the operating system. Everything needs to be aligned in such a way that these components communicate with each other without any problems. Islandora installed through Ansible is somewhat fragile, as a failure of some components can cause significant problems and requires a non-trivial intervention of an experienced technician with good knowledge of the system architecture. In the ISLE variant, the user is largely shielded from the above fragmentation, and Islandora is thus closer to a monolithic system similar to DSpace, which is mainly due to the philosophy of Docker technology. However, Islandora still remains an assembly of components that are distributed as mutually compatible and communicating Docker images.

This fragmented release of individual releases of components for the Ansible version (the Dockerized ISLE version is not affected so much) is the main disadvantage. In addition, both installation approaches are still under intensive development in GitHub, which is concerning for auxiliary installers. A user wishing to fix a specific version using Ansible must either rely on older releases, or fix specific git commits of the corresponding installers for Ansible. The absence of an unambiguous reference to one major fixed version, (which is something Dspace provides), complicates the situation, especially in the production environment. For this reason, ISLE is an easier installation path, thanks to Docker technology (ISLE has off-the-shelf versioning).

### Architecture and function

Both systems, DSpace and Islandora, are primarily used to store digital objects together with services for these objects that can be expected from a digital library: browsing the content, searching, indexing, etc. Both systems also allow the import and export of content and are supplied with a module to support the OAI-PMH protocol.

Therefore, the basic building block of both systems is a digital object. The digital object in the DSpace system is called Item, it contains metadata (primarily in the Dublin Core format) and data files (further divided according to their purpose of use into Bundles). In Islandora, essentially the same is available – the digital object is called the Repository Item, which corresponds to a Drupal node. Both systems define a basic set of metadata that can be expanded. The disadvantage of DSpace is that it primarily provides only flat metadata schemas in the form key:value. Islandora, not only in this case, draws on the possibilities of Drupal and enables creating more complex metadata as well. For instance, in DSpace, the name of the author is stored unstructured in one field in the form <surname>, <name>, whereas Islandora (it would be more accurate to say Drupal, as Islandora itself does not offer this directly) also allows for structured storage, i.e., internal database division into names and surnames. The possibilities of Drupal are very rich in the area of metadata, especially in terms of referring to other Drupal entities, which can be advantageously used in system customizations.

Both systems differ in their structures of the storage of digital objects. DSpace precisely defines the parent structure which the digital object must be inserted into: there must be at least one Community and one Collection in the system. Digital objects are stored in collections. Both communities and collections have a fairly strictly defined metadata schema (since DSpace 6, it is possible to use Dublin Core, but only internally; the support in GUI is missing). Communities can be nested freely and repository browsing options are derived from this structure. Islandora does not prescribe any similar structure; users must define it according to their own needs using the provided type “Collection.” In terms of metadata and full text search, both DSpace and Islandora use Apache Solr, and both provide metadata as well as full text indexing. There are also similar possibilities in terms of creating indexes, filters, etc. However, the definition of custom filters and the subsequent display of results in DSpace is slightly more complex, especially due to the more strictly defined user interface.

DSpace and Islandora differ in the workflow for inserting content. In DSpace, this workflow is very strictly defined. The user first creates a working digital object on top of which all operations take place: filling in metadata, uploading data files, checking formats, assigning licences, etc. The whole process can be configured (appearance and order of forms, including how they are processed, etc.). Then, the working object can go to the approval stage, where defined users can perform checks on the input metadata and data and return everything to be elaborated on and repaired with notes, or make the required modifications straight away. Throughout this phase, the digital object is not publicly visible. The final step is publication. The published object can be subsequently edited, but only using the default generated form with the Dublin Core key:value pairs. It is not possible to return it to the working object state and use configured customized forms. These restrictions can be partially circumvented through batch imports, but not in the UI.

By default, Islandora does not define a workflow, the digital object is created using a standardized form and it can be edited at any time and published immediately. It is possible to use a workflow system similar to DSpace using additional Drupal modules.

Both systems provide default authentication mechanisms. The difference is in terms of authorization, where DSpace has better mechanisms built in and the access to individual objects can be easily controlled for groups and users. Islandora leaves the authorization to Drupal, which also has built-in access control,most easily applied to types of objects in Drupal. Drupal does not address the authorization of individual nodes, although there are modules that can resolve authorization at the node level, like Drupal Groups, which is used by Islandora. There are also other third party modules that address authorization like [^4][^5].

DSpace uses a system of Handle persistent identifiers and a Handle server is part of the installation; their configuration is easy. By default, Islandora does not have any persistent identifier system, but it is possible to use the Drupal module [^6][^7], which ensures the Handle identifier generating functionality; however, users need to install and configure the Handle server themselves.

Both systems provide an OAI-PMH endpoint, exposing metadata in oai_dc by default. In addition, DSpace adds other formats (e.g. Qualified Dublin Core); other formats can be easily added. In Islandora, adding additional formats is not as easy as in DSpace; the user will not avoid programming. The mapping of fields on OAI DC is easy in DSpace, which is also enabled by the flat structure of the metadata schema. Default Islandora works fine with the OAI-PMH module, however, taking advantage of Drupal by using more complex metadata in custom content types (such as references, etc.) renders the capabilities of the OAI-PMH module insufficient. The module itself is difficult to modify. On the contrary, DSpace has special modules designed for OAI-PMH configurations and is stronger in this respect.

Both DSpace and Islandora are community-developed systems; thus, any support is in the ‘best effort’ mode. DSpace has significantly more users around the world and its community is much larger than the Islandora community. In both communities, many users are also very willing to help solve time-consuming problems. Islandora has a significantly larger presence on the American continent; thus, European users must respect the time difference when communicating with developers.

### Customization

Both systems can be customized with greater or lesser effort, as both are provided as open source, which means that it is possible to perform interventions up to the level of the program code and achieve almost anything. Both systems provide mechanisms that should facilitate the implementation of one’s own code. In general, programming is relatively expensive and makes it difficult to upgrade to higher versions of the system. More advantageous is the situation where all changes are made only through the system configuration, in which case the upgrade is significantly easier as customizations are only for the UI and not the core (backend) of both systems.

From the point of view of the philosophy of customization, DSpace and Islandora differ from each other. DSpace is much better suited for a specific use case (Institutional Repositories)and it not as versatile Islandora or its Drupal subsystem.

DSpace has a default overlay-type mechanism that enables easy overwriting of individual Java classes without having to interfere with the original code. Up to and including version 6, it was possible to use the XMLUI interface, which strictly separated the backend and frontend, thus, a number of UI customizations could be addressed only through XSL templates, which transformed the resulting page from an XML document generated by the Java code. The second interface provided by Dspace uses the JSP technology and is less suitable for more extensive customizations. Many customizations can be achieved through the system configuration, but due to the internal architecture of DSpace, the developer is faced with a number of obstacles that cannot be overcome without enormous effort. First of all, it is necessary to maintain the structure of communities and collections and use the two-stage workflow process when inserting content. More extensive customizations require knowledge of Java and XSL as well as the architecture of the entire system.

Where DSpace 6 provides an incomplete REST API, the DSpace 7 version has a complete REST API, and the user interface is based on the Angular technology. This naturally gives a lot of space for customization, but writing the program code, again, cannot be avoided.

Customizations in the Islandora system are completely based on the Drupal system, which is a framework whose primary purpose is to support customizations. From the point of view of the UI, Islandora comprises only a few independent modules in Drupal. Therefore, it is relatively easy to modify your system by adding additional modules. Due to the huge worldwide popularity of Drupal, there is almost always a good chance that the functionality that the user needs has already been designed by someone, and thus it is possible to just use a specific module and configure it. Good results can be achieved easily and without expensive programming. The reverse side of the coin is security: Drupal is a popular target of attackers and during its operation it is absolutely necessary to take care of its security. Drupal does not prevent the development of users’ own modules. All customizations in Drupal are relatively easy to transfer (by exporting the configuration to the YAML format) and relatively independent (especially in Islandora itself), which facilitates upgrades. Last but not least, it is possible to easily create new data types in Drupal, it is not necessary to rely only on the defined Repository item type. The users then have to look after some functions and configure them themselves, but they get a lot of freedom in modelling the resulting system properties. However, it is absolutely necessary to know Drupal and the overall philosophy of working with it. In the case of code interventions, knowledge of the PHP language is also essential.

DSpace primarily offers functions and customization options to the extent determined by its creators. Thus, its defined boundaries are narrower than those of Islandora, which fully uses the Drupal system and its full potential. These constraints narrow down the manoeuvring space, but they guarantee that the configuration change will be easier to upgrade between versions. Customizations carried out in Islandora extend into Drupal, but it is thanks to Drupal that the system can be expanded in a sustainable way.

## From DSpace to Islandora at Masaryk University

After the Islandora system was selected for building digital libraries at Masaryk University in 2019, it was decided that all instances built on DSpace should be migrated to Islandora, so that all partial databases were operated on a single platform. In 2020, we conducted a study of transferability of DML-CZ from the DSpace/ME pair to Islandora. Key ME and DSpace functionalities were identified and then prototyped in Islandora. It turned out that migration was possible and we were able to carry it out. At the Faculty of Arts, the Digitalia MUNI ARTS [^8]infrastructure was created (built on the individual installations of Islandora), where we migrated the Digital Library of the Faculty of Arts [^9] (Fig. 3) in 2021-2022 and Projectiles [^10] (Fig. 4) in 2021. Due to the large number of functionalities of the original system and the user requirements for new functionalities, this migration was not a trivial one. At the same time, the development of other digital libraries in Islandora was continuously underway. From a real-time perspective, migration took approximately 6 months of developer time (not including management, end-user/librarian consulting, and testing).

![Figure 3. Digital Library of Faculty of Arts, Masaryk University. Homepage in Islandora.](https://journal.code4lib.org/media/issue57/Krejcir/fig3-500px.png)  
**Figure 3.** Digital Library of Faculty of Arts, Masaryk University. Homepage in Islandora.

From a purely technical point of view, there is no fully automated way to migrate from DSpace to Islandora. The whole migration takes place in two planes: the transfer of data and metadata itself and the transfer of functionalities provided by the system on top of them. However, the data and metadata transfer phase can be partially automated. DSpace provides tools for exporting data and metadata, including in the CSV format, which the Drupal migration modules are well prepared for. The user creates the appropriate metadata schemas in Drupal, uses the migration tools of the system to define the CSV input document, and maps the CSV content to the created Drupal metadata schemas. The whole process is not fully automated and requires some transformation of the input metadata (for example, transferring the input “surname, name” to two separate fields, etc.), however, the resulting migration is then purely a machine matter. For the sake of completeness, it is necessary to add that we primarily transferred data and metadata from ME, and not from DSpace.

![Figure 4. Projectiles. Homepage.](https://journal.code4lib.org/media/issue57/Krejcir/fig4-500px.png)  
**Figure 4.** Projectiles. Homepage.

From the point of view of the implementation of functionalities, any automation is essentially excluded. In terms of architecture, Islandora and DSpace are different platforms using different programming languages (Java and PHP) and everything needs to be done manually. However, due to the same focus of both systems, the developer obtains a significant part of the functions out of the box (browsing, searching, displaying metadata, etc.). In the case of the Digital Library of the Faculty of Arts, the situation was more complicated due to the number of special functions and exceptions that had to be configured for the most part, and to a lesser extent programmed, in Islandora. The development of our own modules could not be avoided. Last but not least, some time was consumed by the implementation of a number of new functionalities, which originally could not be implemented in DSpace due to their considerable complexity (in terms of development), whereas nothing prevented their implementation in Islandora.

We characterize the entire migration as effective, especially because a number of customizations were resolved by using third-party modules. In DSpace, we would be able to achieve the same features, but we would have to develop a number of components ourselves and integrate them into the system, which would be more difficult than in Islandora/Drupal.

As an example of the differences between the system, one can consider the concept of “Views” (the ability to configure different views of the data itself). This general concept is available within DSpace, but in Drupal, its use is based only on a configuration that is relatively simple (“click-controlled”) and it can be used to produce the necessary output very quickly and efficiently, including export to various formats such as JSON, XML, and CSV. The Views concept is one of the key components in Drupal and it is very well developed and integrated with the Twig template system (which in itself is a robust tool).

Another, already mentioned, advantage of Islandora is the possibility to define your own very rich metadata schemas, which in turn also allows for a convenient way of inserting this metadata for the editor. (On the other hand, it has disadvantages when mapping metadata in the OAI-PMH module.)

Another example of a functionality that has made things easier for us is the free use of a hierarchical structure for data storage, which affects the browse feature. A developer has to follow a specific structure of so-called Communities and Collections (both of them must be present) in DSpace, while there is no such restriction in Islandora.

## Conclusion

Both systems, DSpace and Islandora are high quality systems with advantages and disadvantages. DSpace is primarily built as an institutional repository, which implements a specific functionality, and it implements it well. It assumes a predetermined use case and is tailor-made for this purpose. This also entails certain limitations, especially if the user wants to go beyond the scope offered by DSpace. Islandora, on the other hand, omits some DSpace functions (e.g., authorization), but with the help of Drupal, it serves as a better basis for making more extensive adjustments to the system and provides developers with more freedom.

The user who will have to choose between the DSpace and Islandora systems must first of all think carefully about the intended purpose of the system, to what extent the system meets their requirements, and then to what extent customization is required.. The same system can be achieved using both software products, however, in DSpace, customizations involve more programming and more complex integration. In contrast, Islandora, thanks to its close integration with the Drupal project, supports more customization directly and its flexibility and configuration options are better from the developer’s point of view.

For the needs of our team, namely building specialized, community-oriented digital libraries, Islandora has proven to be a more effective solution, albeit more demanding in terms of system administration. However, it should be stressed that both DSpace and Islandora continue to evolve and improve. DSpace, especially version 7, continues to move towards greater generality and opens up more to customizations, while Islandora also continues to add more specialized functionalities and features. Those interested in deploying these systems should therefore always consult the documentation of the current version of the respective system.

## Acknowledgement

The findings of the paper have been supported by the Ministry of Education, Youth and Sports of the Czech Republic, Project No. LM2018101 LINDAT/CLARIAH-CZ.

## Notes

[^1]: Czech Digital Mathematics Library. [https://dml.cz/](https://dml.cz/)

[^2]: European Digital Mathematics Library. [https://eudml.org/](https://eudml.org/)

[^3]: ISLE stands for “ISLandora Enterprise”

[^4]: [https://github.com/discoverygarden/embargo](https://github.com/discoverygarden/embargo)

[^5]: [https://github.com/discoverygarden/islandora_hierarchical_access](https://github.com/discoverygarden/islandora_hierarchical_access)

[^6]: [https://github.com/mjordan/persistent_identifiers](https://github.com/mjordan/persistent_identifiers)

[^7]: [https://github.com/discoverygarden/dgi_actions](https://github.com/discoverygarden/dgi_actions)

[^8]: Digitalia MUNI ARTS. [https://digitalia.phil.muni.cz/](https://digitalia.phil.muni.cz/)

[^9]: Digital Library of the Faculty of Arts, Masaryk University. [https://digilib.phil.muni.cz/](https://digilib.phil.muni.cz/)

[^10]: Projectiles. [https://projectiles.phil.muni.cz/](https://projectiles.phil.muni.cz/)

## Bibliography

Robert Kahn, Robert Wilensky. 1995. A Framework for Distributed Digital Objects Services. \[Internet\]. \[cited 2023 Apr 20\]. Available from: [http://www.cnri.reston.va.us/k-w.html](http://www.cnri.reston.va.us/k-w.html)

William Y. Arms. 1995. Key Concepts in the Architecture of the Digital Library. D-Lib magazine \[Internet\]. \[cited 2023 Apr 20\]. Available from: [http://www.dlib.org/dlib/July95/07arms.html](http://www.dlib.org/dlib/July95/07arms.html)

Vannevar Bush. As We May Think. 1945. Atlantic Monthly \[Internet\]. \[cited 2023 Apr 20\]. Available from [http://www.theatlantic.com/unbound/flashbks/computer/bushf.htm](http://www.theatlantic.com/unbound/flashbks/computer/bushf.htm)

Bartošek, M., Kovář, P., Šárfy, M. 2008. DML-CZ Metadata Editor: Content Creation System for Digital Libraries. In: Sojka P, editor. DML 2008 – Towards Digital Mathematics Library; 2008 Jul 27; Birmingham. UK. p. 139-151. [Zbl 1170.68482](http://www.zentralblatt-math.org/zmath/en/search/?q=an:1170.68482)

Krejčíř, V.: Building the Czech Digital Mathematics Library upon DSpace system. In: Sojka P, editor. DML 2008 – Towards Digital Mathematics Library; 2008 Jul 27; Birmingham. UK pp. 117-126. [Zbl 1170.68487](http://www.zentralblatt-math.org/zmath/en/search/?q=an:Zbl%201170.68487&format=complete)

**Krejčíř, Vlastimil** ([krejcir@ics.muni.cz,](https://journal.code4lib.org/articles/) [https://www.muni.cz/en/people/4189-vlastimil-krejcir](https://www.muni.cz/en/people/4189-vlastimil-krejcir)) works as an IT analyst at Institute of Computer Science, Masaryk University in Brno. He has been interested in systems for building digital libraries and repositories for almost 20 years and is one of the first adopters of DSpace in the Czech Republic. He has collaborated on a number of digital libraries: Czech Digital Mathematics Library (DML-CZ) including European Digital Mathematics Library (EuDML), two digital libraries for Masaryk university and a number of smaller ones within the LINDAT/Clariah project. He is currently developing and setting up a sustainable framework for building digital libraries on top of the Islandora system.

**Strakošová, Alžbeta** ([strakosova@phil.muni.cz,](https://journal.code4lib.org/articles/) [https://www.muni.cz/en/people/456453-alzbeta-strakosova](https://www.muni.cz/en/people/456453-alzbeta-strakosova)) is a student of Faculty of Informatics, Masaryk University in Brno. She works as an Islandora/Drupal software developer for the LINDAT/Clariah project.

**Adler, Jan** ([469190@mail.muni.cz,](https://journal.code4lib.org/articles/) [https://www.muni.cz/en/people/469190-jan-adler](https://www.muni.cz/en/people/469190-jan-adler)) is a student of Faculty of Informatics, Masaryk University in Brno. Hw works as an Islandora/Drupal software developer for the LINDAT/Clariah project.

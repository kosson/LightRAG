---
title: "Copyright and access restrictions–providing access to the digital collections of Leiden University Libraries with conditional access rights"
source: "https://journal.code4lib.org/articles/13588"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-08-09
created: 2025-01-10
description: "To provide access to the digitized collections without breaking any copyright laws, Leiden University Library built a copyright module for their Islandora-based repository. The project was not just about building a technical solution, but also addressed policy, metadata, and workflows. A fine-grained system of access rights was set up, distinguishing conditions based on metadata, IP [...]"
tags:
  - "clippings"
---
# Copyright and access restrictions–providing access to the digital collections of Leiden University Libraries with conditional access rights
Saskia van Bergen, Lucas van Schaik

To provide access to the digitized collections without breaking any copyright laws, Leiden University Library built a copyright module for their Islandora-based repository. The project was not just about building a technical solution, but also addressed policy, metadata, and workflows. A fine-grained system of access rights was set up, distinguishing conditions based on metadata, IP address, authentication and user role.

## Introduction

Leiden University has a long tradition of research and education dedicated to non-Western cultures, specifically Asian and Middle Eastern cultures. This focus was in large part driven by the historical ties between the Netherlands and the countries formerly under colonial rule. As a result Leiden University Libraries (UBL) owns a significant number of non-Western heritage collections.

In 2013 the Library of the Royal Tropical Institute (KIT) was closed and the part of the collection that dealt with the former Dutch colonies was transferred to Leiden University Libraries, a vast collection which included unique historical materials about the former colonies of the Netherlands. In 2014 Leiden’s collections on Southeast Asia, the Pacific and the Caribbean grew through the acquisition of the heritage collection of the Royal Netherlands Institute of Southeast Asian and Caribbean Studies (KITLV).

The many non-Western objects held by Leiden University Libraries can be of great value both to researchers worldwide and to the general public in the regions in which these objects originated. However, because of the costs of travel it is often difficult for them to consult these objects physically in the library’s reading room.

For this reason UBL decided to invest considerably in improving the digital access to these collections. As an important step in this process the library redesigned its repository infrastructure and replaced all commercial, home-built and (partly outdated) open source applications for ingest, storage and presentation with one open source, multi-functional environment based on Islandora. In the course of 2018, the new online interface for Leiden University Libraries Digital Collections will contain all digitized heritage collections of Leiden University Libraries. These include manuscripts, early printed books, maps, atlases, prints, drawings, and photographs; all together around 3 million scans and 50 TB.

The new infrastructure offers a service that is both manageable and trustworthy. It focuses on the long-term preservation of objects and their metadata. Researchers and students can easily view and download digital objects through the online interface, and specific groups of objects can be made available as a separate collection by creating a home page for each of them. The objects and metadata can be requested by external parties through standardized exchange protocols, APIs and persistent identifiers.

In recent years, European cultural heritage institutions have invested heavily in the digitization and online availability of their collections. In accordance with the intellectual property rights, permission from copyright holders is required for both reproduction and online dissemination. Copyright in the Netherlands is laid down in the Auteurswet (Dutch Copyright Act). The copyright is valid for up to 70 years after the creator’s death. This means that during this period creators (or their heirs) have the exclusive right to authorize and prohibit the use of their works.

Dutch heritage organizations have for a long time devoted little attention to the follow-up of copyright restrictions. This was based on the idea that they are non-commercial organizations and work for research and educational purposes. Thus not all legacy applications maintained by the UBL were equipped with sufficient functionality to comply with Dutch copyright law.

Over the past few years however, several heritage organizations have been brought before court for copyright infringement and as a result they have begun to respond to these requirements. The same goes for our library. Collections that had been made available online in the past had to be reconsidered, and if any copyright infringement had occurred, measures had to be taken. Fortunately, the Islandora infrastructure does enable us to make the availability of digital objects dependent on copyright regulations in a flexible way.

In this article we will focus on the implementation of a copyright module for Islandora. Altogether this project was not just about building a technical solution, but also considered policy, metadata, and workflows.

## Policies and Workflows

### Policy

Most collections at UBL were digitized for preservation purposes, mainly as part of the Dutch Metamorfoze programme. By digitizing them the originals can be protected from handling, while their content is still available to our users. At the start of the project many digital objects were made available even though they were under copyright protection.

With copyright compliance now a priority, this had to be corrected. We also needed to make it unambiguous on a general level what our users can and cannot do with our data. Are they allowed to download and reuse our metadata? And can they share, reuse and modify our JPEG files only, or the TIFF archival object as well? Because our library did not yet have a clear policy for the digital collections, this was the first step necessary for setting up the workflows. We decided that all data are made as openly available as possible, in as many places as possible. If copyright permits, users can download:

- JPG files of individual scans
- PDF files of complete works
- OCR in txt and xml formats (if available)
- MP3 files of audiovisual materials

Exceptions can be made for collections or items, depending on the requirements of copyright owners. Collections subject to copyright restrictions are made available on a dedicated terminal only accessible in the main building of the library.

## Metadata and copyright clearance

All items in our collections are catalogued in our main library management system Alma, including archival materials, prints, maps and photographs. Alma is the source for the metadata in our discovery system Primo and also for Islandora. For this reason, we have created a module that uses an OAI-PMH enabled source to synchronize the metadata to Islandora. Synchronization can be performed for an individual item (manage, synchronize) or for a batch. For the physical and digital objects we make two separate records, both with their own metadata and services: the metadata for the physical object contains a request button, while the digital object record contains a Handle persistent identifier leading users to the digitized content in Islandora.

Access to all copyright-protected works that were still digitally accessible had to be restricted. A major problem was that the metadata was not always of sufficient quality to determine whether an object was free of copyright (for example, a photographer’s date of death not recorded).

Over the past few years we have worked hard to improve this metadata. To be able to clear the copyrights, we had to retrieve the contact details of the copyright owners. In the Netherlands various agencies offer their assistance in this, including the Dutch Knowledge Center for Digital Heritage and Culture (DEN) and Kennisland.

If after careful research the right holders are not known or cannot be traced, one can register the work in the European database for orphaned works and make it publicly available. The National Office for Orphaned Works in The Hague offers assistance in determining whether a work can be registered as unidentified.

In practice copyright clearance is an intensive and costly process. For this reason, more and more Dutch organizations decide to save themselves the effort and switch to the services of a copyright collecting agency. However, the digital Asian collections were the main bottleneck for UBL. The clearing and registration of these collections is hampered by a variety of problems, such as language and spelling variations and difficulties in determining years of life and contact details of copyright owners. And although more and more copyright collecting agencies and companies are becoming active in Asia, the number still lags far behind that of Europe. This meant that – despite our efforts – parts of these collections can only be made available within the walls of the library.

## Rights Workflow

To be able to make our digital collections available without infringement of any law, we had to create separate workflows for each possible copyright situation. Each workflow starts with an analysis, the result is documented in the metadata and this leads to specific access actions. To analyze the status and potential risks of copyright infringement for our digital collections we made use of the licenses granted by both Creative Commons and RightsStatements, established by Europeana and DPLA. We distinguished four main categories:

- Works with copyright restrictions
- Works in the public domain
- Works for which the copyright is not evaluated (most Asian collections)
- Orphaned works

For works with an unknown author or creator, we decided that textual materials made or published before 1900 and maps published more than 70 years ago would be made available free of restrictions. The risk of legal action is very low for these materials. The next step was to create separate workflows for:

- collections which were not evaluated yet at the item level
- collections and items within copyright
- collections and items in the public domain

A separate workflow was created for collections which are in use internally by research groups of Leiden University and cannot be made available (yet) to other users, because of copyright and/or privacy issues.

For each collection the rights and the online availability were registered with one or more of the following permission scopes:

- Access with ULCN account services login, the single sign on environment for students, researchers and guests of Leiden University
- Access within the walls of the library building only, on dedicated desktop terminals
- Viewing and streaming rights only: for collections with possible copyright issues, but limited risks
- Access and download rights for everyone, anywhere, anytime

This could be one both on item and collection level. The process consists of two steps. First, the access rights for each digital object of a collection are recorded in Alma.

```
506 - Restrictions on Access Note (R)
$a Streaming access (Assign first indicator 1)
$a Download provided (Assign first indicator 0)

540 Terms of use and reproduction note (R)
$a Copyright not evaluated
$u  http://rightsstatements.org/vocab/CNE/1.0/

$a This resource is protected by copyright 
$u http://rightsstatements.org/vocab/InC/1.0/ 
```

**Figure 1.** Examples of copyright information coded in MARC21

This results in a MODS file in Islandora containing two separate fields for Access Condition :

**Figure 2.** Example of copyright information coded in MODS

To make it clear to users what the access rights for each object are texts, links and images are displayed both below the metadata and inside a download menu (Figure 3). The download menu lists all of the available datastreams and indicates whether they are available for download (see Figure 4). Items that are part of a compound object, like pages of a book and sheets of a map, can have their own access actions as well. If there is no data available (for example for a page in a book), the data of the compound object (the book itself) is used.

![](https://journal.code4lib.org/media/issue41/vanbergen//vanbergen_ill_1.jpg)

**Figure 3.** Example of public record display

![](https://journal.code4lib.org/media/issue41/vanbergen/vanbergen_ill_2.jpg)

**Figure 4.** Example context menu

## Islandora Conditional Access Rights Module

To handle the access rights and display the copyright statements, we built a module called Islandora conditional access rights, a Drupal module in PHP. The module pulls the access rights and the displayed copyright statements from the metadata of the object in Islandora, synchronized from Alma.

The module defines conditions and access actions it uses to determine user access. The conditions are evaluated when a user attempts to view an object. Based on the outcome of the conditions, certain access actions are performed. An access action is a single effect the user perceives when accessing the object; for example denying access to the object or displaying a download menu.

### Islandora Hooks

Islandora conditional access rights uses Islandora hooks to modify the access restrictions of objects and datastreams. Islandora hooks are an implementation of Drupal hooks which allows modules to change the behavior and data of other hook modules. Because Islandora itself is partly implemented as Drupal modules, it also defines its own hooks.

#### Object access hook

The Islandora object access hook is used to establish the access rights at the object level. If the “deny access to object” access action’s value is true for an object, access to this object is restricted. If the value is false or the value is absent, users have access to this object, unless another module prevents access. If the object subordinates to another object, such as a page in a book, and the child object does not have its own access action, the parent object is checked to determine access rights.

#### Datastream access hook

The Islandora datastream access hook is used to establish the access rights at the datastream level. There are two access actions that determine if the user has access:

- deny access to datastream  
If the datastream is present in this access action but not in the “allow access to datastream” access action, the access to the datastream is not allowed.
- allow access to datastream  
If the datastream is present in this access action but not in the “deny access to datastream” access action, the access to the datastream is allowed.

If the access rights are not handled by these two access actions (because the datastream is not defined or it is defined in both access actions), users have access to this datastream, unless another module restricts access. Just as is the case with the object access option, the parent is checked as well for compound objects.

### Conditional statements

Islandora conditional access rights uses the following information to determine access rights for an object:

- copyright statement contained in the metadata
- IP address of the user
- user authentication
- user role

Figure 5 shows the relationship between conditions and access actions. The configuration of the module allows any number of conditions and access actions for a single object. Green indicates the condition is met and the access action is taken.

![](https://journal.code4lib.org/media/issue41/vanbergen/vanbergen_ill_3.png)

**Figure 5.** Conditional relationship and access action model

A single condition can only be true or false; either the condition is met or not. If a condition is met, the related access action is performed.

The module defines six condition types to determine access actions.

#### Metadata condition type

This condition type compares a value in a specific metadata field to a given value. The metadata field is determined by the datastream ID and an XPath in the module.

In Islandora it is possible to have multiple metadata XML files per object, so the datastream ID identifies the XML file to use and the XPath identifies the metadata value to use for the access action.

The object’s metadata field is referenced by the metadata key field “restriction\_on\_access”, which is defined in the module’s configuration \[metadata:restriction\_on\_access\] and then used in the condition (metadata = restriction\_on\_access).

#### Location condition type

This is used to restrict access to terminals within the library building. This condition is met when the IP address of the machine of the user lies within a specific range or ranges. The IP address of the machine of the user is used when no reverse proxy is employed. When it is behind a reverse proxy the value of the X-Forwarded-For header field is used by the module. IPv6 is supported by the module.

#### Authorization level condition type

This condition is met when the user is authenticated and has a specific role in Islandora. This can be used to differentiate between the access rights of employees and end users.

### And, Or, and Not Conditions

Three conditions used by the module determine access actions by comparing other conditions. These either negate, conjunct, or disjunct those conditions.

#### Negating condition type

This condition is fulfilled when another condition is not met. This can be used with a location condition for users outside an IP range, or in case a metadata value is not found.

#### Conjunctive condition type

This condition is met when all related conditions are met. This can be used when the user has a specific role and is within a specific IP range.

#### Disjunctive condition

This condition is met when any of the related conditions are met. This can be used when the user has a specific role or is within a specific IP range.

### Access actions

Which access action is taken depends on which conditions are met. It is possible that multiple, possibly conflicting access actions are confirmed for one object. If this is the case, the order of the access actions in the configuration determines which access action is taken.

For example, when the condition “user is administrator” is met and there is an access action associated with this condition that allows access to the object, access is allowed. Subsequent access actions are ignored, because access was already allowed. This applies to each access action met for each object.

For example let’s assume the following configuration:

\[access:user\_is\_administrator\]  
deny\_viewing = FALSE

\[access:internal\]  
deny\_viewing = FALSE

\[access:external\]  
deny\_viewing = TRUE

For an administrator from inside the IP range, the following applies:

| **access condition** | **access action** | **result** |
| --- | --- | --- |
| user is administrator | allow access | condition met, action performed: access is allowed |
| intern | allow access | action is ignored, access was already allowed |
| extern | deny access | action is ignored, access was already allowed |

But for an anonymous user from inside the IP range, the following applies:

| **access condition** | **access action** | **result** |
| --- | --- | --- |
| user is administrator | allow access | condition not met, action not performed |
| internal | allow access | condition met, action performed: access is allowed |
| external | deny access | action is ignored, access was already allowed |

And for an anonymous user from outside the IP range, the following applies:

| **access condition** | **access action** | **result** |
| --- | --- | --- |
| user is administrator | allow access | condition not met, action not performed |
| internal | allow access | condition not met, action not performed |
| external | deny access | condition met, action performed: access is denied |

The following access actions are available:

- deny access to object: user receives an HTTP 403 forbidden page with explanation of access restrictions
- deny access to datastream: user can view object page, but requests to access datastreams are denied with HTTP 403 Forbidden page
- allow access to datastream: all datastreams are accessible to the user but not available for download. Can be specific, such as “deny access to all datastreams, except thumbnails” or “allow access to all datastreams, except archival objects.”
- provide download of datastream: download menu is visible to the user for all datastreams

We’ve provided an example of one possible configuration for the Islandora Condition Access Rights module:

#### Configuration file

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99  100  101  102  103  104  105  106  107  108  109  110  111  112 | `; ---------------`  `; Metadata values`  `; ---------------`  `[metadata:restriction_on_access]`  `datastream = MODS`  `xpath = ``"/mods:mods/mods:accessCondition[@type='restriction on access']"`  `[metadata:use_and_reproduction]`  `datastream = MODS`  `xpath = ``"/mods:mods/mods:accessCondition[@type='use and reproduction']"`  `[metadata:embargo_date]`  `datastream = MODS`  `xpath = ``"/mods:mods/mods:accessCondition[@type='embargo date']"`  `; ----------`  `; Conditions`  `; ----------`  `[condition:manager]`  `user_role[] = ``"administrator"`  `user_role[] = ``"editor"`  `[condition:intern]`  `ip_range[] = ``"192.0.2.0-192.0.2.24"`  `ip_range[] = ``"198.51.100.0-198.51.100.24"`  `[condition:extern]`  `condition[] = intern`  `operator = negate`  `[condition:fullaccess]`  `metadata = restriction_on_access`  `comparator = ``"lowercaseLetterMatch"`  `value = ``"full access"`  `[condition:withinlibrary]`  `metadata = restriction_on_access`  `comparator = ``"lowercaseLetterMatch"`  `value = ``"access within the library premises"`  `[condition:embargo]`  `metadata = embargo_date`  `comparator = ``"beforeDateISO8601"`  `value = ``"today"`  `[condition:cczero1.0]`  `metadata = use_and_reproduction`  `comparator = ``"equals"`  `[condition:rsinc1.0]`  `metadata = use_and_reproduction`  `comparator = ``"equals"`  `[condition:intern_withinlibrary]`  `condition[] = intern`  `condition[] = withinlibrary`  `operator = ``and`  `[condition:extern_withinlibrary]`  `condition[] = extern`  `condition[] = withinlibrary`  `operator = ``and`  `; --------------`  `; Access actions`  `; --------------`  `[access:manager]`  `deny_viewing = FALSE`  `deny_access_to_dsid[] = ``"NONE"`  `allow_access_to_dsid[] = ``"ALL"`  `provide_download_of_dsid[] = ``"ALL"`  `access_text = ``"Manager access."`  `[access:embargo]`  `deny_viewing = TRUE`  `deny_access_to_dsid[] = ``"ALL"`  `[access:fullaccess]`  `deny_access_to_dsid[] = ``"NONE"`  `allow_access_to_dsid[] = ``"ALL"`  `provide_download_of_dsid[] = ``"ALL"`  `access_text = ``"Full access."`  `[access:intern_withinlibrary]`  `deny_access_to_dsid[] = ``"OBJ"`  `allow_access_to_dsid[] = ``"NONE"`  `provide_download_of_dsid[] = ``"NONE"`  `access_text = ``"Access within the library premises."`  `[access:extern_withinlibrary]`  `deny_access_to_dsid[] = ``"ALL"`  `allow_access_to_dsid[] = ``"NONE"`  `provide_download_of_dsid[] = ``"NONE"`  `access_text = ``"Access within the library premises."`  `[access:cczero1.0]`  `access_usetext = ``"Use of this public-domain resource is unrestricted"`  `[access:rsinc1.0]`  `access_usetext = ``"This resource is protected by copyright"` |
| --- | --- |

**Figure 6.** Example configuration

In this configuration three metadata values, 10 conditions, and seven access actions are defined. Note that not all conditions have an access action, but every access action shares the same name of the condition that grants it.

Below are three example scenarios for one object and the resulting access rights when the configuration above is used.

Example object:

| 1  2  3  4  5  6 | `<?``xml` `version``=``"1.0"``?>`  `<``titleInfo``><``title``>Full access</``title``><``subTitle``></``subTitle``></``titleInfo``>`  `<``accessCondition` `type``=``"restriction on access"``>Access within the library premises.</``accessCondition``>`  `</``mods``>` |
| --- | --- |

Scenario:

- user is not in the library
- user is not logged in
- object is restricted to in library access

This user has access to the object but not to any of its datastreams. User sees “Access within library premises.” and “This resource is protected by copyright“ messages and cannot download any datastreams.

| **condition** | **result** | **access action** |
| --- | --- | --- |
| condition:manager | not met, user does not have right role | not performed, condition not met |
| condition:intern | not met, user is not within IP range | N/A |
| condition:extern | met, because intern was not met | N/A |
| condition:fullaccess | not met, because value is not in metadata | not performed, condition not met |
| condition:withinlibrary | met, because value is in metadata | N/A |
| condition:embargo | not met, because value is not in metadata | not performed, condition not met |
| condition:cczero1.0 | not met, because value is not in metadata | not performed, condition not met |
| condition:rsinc1.0 | met, because value is in metadata | performed |
| condition:intern\_withinlibrary | not met, because condition:intern is not met (condition:withinlibrary is met, but this is a conjunctive condition type, so both conditions must be met) | not performed, condition not met |
| condition:extern\_withinlibrary | met, because condition:extern and condition:withinlibrary are met | performed |

Scenario:

- user is in the library
- user is logged in
- object is restricted to in library access

The logged-in user in the library has access to the object and can view the datastreams (except for the OBJ datastream). The user sees the “Access within library premises.” and “This resource is protected by copyright“ messages and cannot download any datastreams.

| **condition** | **result** | **access action** |
| --- | --- | --- |
| condition:manager | not met, user does not have right role | not performed, condition not met |
| condition:intern | met, user is within IP range of the library | N/A |
| condition:extern | not met, because intern was met | N/A |
| condition:fullaccess | not met, because value is not in metadata | not performed, condition not met |
| condition:withinlibrary | met, because value is in metadata | N/A |
| condition:embargo | not met, because value is not in metadata | not performed, condition not met |
| condition:cczero1.0 | not met, because value is not in metadata | not performed, condition not met |
| condition:rsinc1.0 | met, because value is in metadata | performed |
| condition:intern\_withinlibrary | met, because condition:intern and condition:withinlibrary are met | performed |
| condition:extern\_withinlibrary | not met, because condition:extern is not met (condition:withinlibrary is met, but this is a conjunctive condition type, so both conditions must be met) | not performed, condition not met |

Scenario:

- user is in the library
- user is an administrator and logged in
- object is restricted to in library access

The logged-in admin user at the library has access to the object and can view all datastreams. The user sees the “Manager access” and “This resource is protected by copyright“ messages, but can download all datastreams.

| **condition** | **result** | **access action** |
| --- | --- | --- |
| condition:manager | met, user does have administrator role | performed, condition met |
| condition:intern | met, user is within IP range of the library | N/A |
| condition:extern | not met, because intern was met | N/A |
| condition:fullaccess | not met, because value is not in metadata | not performed, condition not met |
| condition:withinlibrary | met, because value is in metadata | N/A |
| condition:embargo | not met, because value is not in metadata | not performed, condition not met |
| condition:cczero1.0 | not met, because value is not in metadata | not performed, condition not met |
| condition:rsinc1.0 | met, because value is in metadata | performed, condition met. This access action has other actions then access:manager, so these will be performed. |
| condition:intern\_withinlibrary | met, because condition:intern and condition:withinlibrary are met | not performed, although the condition is met, the access actions from access:manager are already performed earlier and overrule these all access actions |
| condition:extern\_withinlibrary | not met, because condition:extern is not met (condition:withinlibrary is met, but this is a conjunctive condition type, so both conditions must be met) | not performed, condition not met |

[More example scenarios are available](https://journal.code4lib.org/media/issue41/vanbergen/van_bergen_schaik_code4lib_example_figure.pdf) for further explanation.

### Detail tools block

The Details tool Drupal block, included in the module, makes the download options visible for users. A Drupal block defines part of a web page. In Drupal a page consists of multiple blocks, each in its own region of the page. The access rights of the current object and the available datastreams determine the downloadable datastreams. Which datastreams are made available depends on the “Provide download of datastream” access action. Some datastreams, including the relational datastreams (these define the internal and external relations of the object) and the policy datastreams (used for XACML access rights) are never available for download.

### Caches

Determining the access rights of an object can be time consuming. To prevent the configuration of the module from being read with each request, the entire configuration is sent as an object. This is cached for at least a day. The metadata values that determine the access rights are cached per object as well. If the metadata of an object is changed, the metadata values cache of that object is flushed. This is done by comparing the last modification dates of the metadata with those in cache. This avoids that the cache will persist multiple hours or days, depending on the configuration of Islandora.

Both caches can be flushed in the usual (Drupal) manner. Caching is also done on page level, for the calculated access actions. This is only done during the load of a single page, but is needed because the access actions are used multiple times during a page load. Calculating them once and using them many times during a page load increases performance. However, they cannot be cached for longer than a single page load, because the access actions are dependent on the conditions of the page load: IP of the requester, the user role and/or the time.

## Islandora Versus Fedora Access

Islandora is an open source digital repository system based on Fedora Commons, Drupal and a host of additional applications. Both Islandora and Fedora Commons have their own systems to allow or restrict access to objects or datastreams. Islandora conditional access rights works only on the Islandora side and can be used alongside other access rights management systems built into Islandora and/or Fedora Commons.

Fedora Commons works with the eXtensible Access Control Markup Language (XACML) to restrict access privileges. XACML defines a “declarative fine-grained, attribute-based access control policy language, an architecture, and a processing model describing how to evaluate access requests according to the rules defined in policies”. XACML is partly implemented in Islandora, so it is possible to manage the rights on a higher level and there is no need to make a XACML document yourself.

An earlier version of Islandora conditional access rights included support for XACML, but the current implementation of Islandora XACML didn’t work with all of our requirements , such as IP range checking, time-based (embargo) and inherited (pages of a book). For this reason we decided not to use XACML support for the time being.

The downside of using only Islandora’s own access control mechanism instead of XACML is that access rights are only controlled on the Islandora level. This means that if direct access to Fedora Commons is allowed, the access rights are not maintained there. Because at Leiden University Libraries all access is via Islandora, this doesn’t cause any problems.

## Conclusion and further development

With the Islandora Conditional Access Rights module we have created a fine-grained system including all levels of access rights necessary for end users; from access on one terminal within the library to full access everywhere and anytime. This makes it possible to make all digitized items and collections available online. The main advantage to this system is that all metadata are maintained in our main cataloguing system, which also makes it possible for curators and other colleagues to adjust the metadata themselves if needed.

It is the library’s policy to manage all data within the same environment. For this reason, the next project will be the migration of our scholarly repository from DSpace to Islandora as well. Further development of the access rights module will then be needed, e.g. to provide access to collections with embargo restrictions.

## About the authors

Saskia van Bergen works as a project manager for Leiden University Libraries and is currently responsible for the implementation of Islandora and the migration of the digital collections.

Lucas van Schaik works as a developer/consultant for Leiden University Libraries and is the lead developer for the Islandora infrastructure of the library.
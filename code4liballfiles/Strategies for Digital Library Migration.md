---
title: "Strategies for Digital Library Migration"
source: "https://journal.code4lib.org/articles/17290"
author:
  - "Justin Littman"
  - "Mike Giarlo"
  - "Peter Mangiafico"
  - "Laura Wrubel"
  - "Naomi Dushay"
  - "Aaron Collier"
  - "Arcadia Falcone"
published: 2023-04-21
created: 2025-01-10
description: "A migration of the datastore and data model for Stanford Digital Repository’s digital object metadata was recently completed. This paper describes the motivations for this work and some of the strategies used to accomplish the migration. Strategies include: adopting a validatable data model, abstracting the datastore behind an API, separating concerns, testing metadata mappings against real digital objects, using reports to understand the data, templating unit tests, performing a rolling migration, and incorporating the migration into ongoing project work. These strategies may be useful to other repository or digital library application migrations."
tags:
  - "#digital/library"
  - "#migration"
  - "#datastore"
  - "#data/model"
  - "#digital/object/metadata"
---
# Strategies for Digital Library Migration

Justin Littman, Mike Giarlo, Peter Mangiafico, Laura Wrubel, Naomi Dushay, Aaron Collier, Arcadia Falcone

A migration of the datastore and data model for Stanford Digital Repository’s digital object metadata was recently completed. This paper describes the motivations for this work and some of the strategies used to accomplish the migration. Strategies include: adopting a validatable data model, abstracting the datastore behind an API, separating concerns, testing metadata mappings against real digital objects, using reports to understand the data, templating unit tests, performing a rolling migration, and incorporating the migration into ongoing project work. These strategies may be useful to other repository or digital library application migrations.

## Introduction

For the past 4 years, a team at Stanford University Libraries (SUL) has been working on and off towards migrating to a new datastore and data model for the Stanford Digital Repository’s (SDR) digital object metadata. [^1] The goal of this paper is to describe the motivations for this work and some of the strategies used to accomplish this migration. These strategies may be useful to other repository or digital library application migrations.

## About the Stanford Digital Repository

In support of research, teaching and learning, the Stanford Digital Repository is an ecosystem of applications, systems, and services that house the digital collections of Stanford University Libraries. Collections housed by SDR include:

- Google-scanned books
- Stanford dissertations and theses
- University Archives
- Allen Ginsberg papers
- Buckminster Fuller papers
- Parker Library
- Fugitive U.S. Agencies Web Archive

At the time of writing, SDR has almost 5 million digital objects composed of more than 530 million content files. [^2] SDR is extremely heterogeneous along several facets, including content types (e.g., books, images, web archives, GIS datasets) and file types (e.g., XML, TIFF, WARC, MP4).

### Repository Ecosystem & Data Flows

There are multiple avenues for users to deposit digital objects (metadata and content files) in SDR. These include, but are not limited to:

- A web based self-deposit interface for single item deposit by researchers (Stanford faculty, students, and staff)
- A web based self-deposit interface for theses and dissertations by Stanford graduate and undergraduate students
- A web based interface for administrative library staff that allows for bulk deposit
- API based deposit (currently internal library staff use only)
- Customized third-party software optimized for managing digitization of physical materials by Stanford University Libraries staff

SDR interacts with other digital library applications at SUL. In particular, it deposits digital objects into the Preservation System [^3] and publishes digital objects to the Access System. SDR also retrieves descriptive metadata from Symphony, SUL’s integrated library system. [^4] The preservation and access systems are not discussed here, though briefly:

- The preservation system provides redundant onsite and offsite backup, with validity and audit checks.
- The access system provides web based search, discovery, viewing (e.g., via [IIIF](https://iiif.io/)), and download.

Throughout this ecosystem, varying levels of discovery, access, and embargo restrictions can be set and are enforced.

### Metadata Management Store

SDR has been in operation since 2006. For at least the last 11 years [^5], it relied on Fedora 3 as a datastore for its digital object metadata. SDR’s digital object metadata includes description, identification, access / rights, structure, and other administrative metadata. The digital object’s content files are not stored in Fedora.

While Fedora 3 has been the SDR’s “workhorse” over the years, it suffers from a number of critical shortcomings:

- Fedora 3 is no longer supported and was last released in 2015.
- Fedora 3 relies on Java 8, which has been “end-of-life” since 2019.
- The basic units of metadata storage in Fedora 3 are XML files stored on disk (“datastreams” in Fedora parlance). These datastreams are not validated and schema-less, by design.
- Ruby libraries supporting Fedora 3 (ActiveFedora 8.x and Rubydora) are no longer under active development, going moribund in 2018, which constrained our ability to update to the latest versions of the programming language (Ruby) and web application framework (Rails) used throughout SDR.
- Fedora 3 does not support transactions, meaning that problems like network blips can result in digital objects with incomplete or otherwise broken metadata.
- Fedora 3 does not support constraints (e.g., uniqueness), allowing for problematic digital object metadata to be included in the repository.
- By itself, Fedora 3 does not support advanced querying of digital object metadata. In SDR, querying is provided by an instance of the Solr full text search service, which must be kept in sync with the underlying digital object metadata datastore.
- Fedora 3 is not designed for load balancing and thus becomes a single point of failure under heavy load, even if other parts of the system are load balanced to handle higher load. We have observed this behavior in SDR where Fedora often “falls over” under load.

In addition, the SDR application and data ecosystem suffered from critical shortcomings:

- SDR applications were tightly bound to Fedora, interacting directly with Fedora to update XML datastreams.
- Many SDR applications took advantage of the flexibility of Fedora’s datastreams to store application-specific metadata.
- Without the constraints of a schema / validation, the XML metadata was inconsistent due to:
- Each application directly manipulating XML.
- Users being empowered to manually edit XML datastreams in SDR’s management application as the endorsed way to make certain types of functional changes to objects.
- Abandoned metadata approaches and legacy applications left unremediated and divergent.
- Low prioritization of auditing and quality check tools for entire corpus of SDR XML

The totality of these shortcomings motivated the migration to a new metadata management store and a rich, validatable data model for SDR’s digital object metadata. [^6] In the rest of this paper, we will describe some of the strategies used to accomplish this migration. To this end, we will focus on the motivation and logic of these strategies, rather than the code or implementation details.

## Strategy #1: Adopt a Validatable Data Model

One of the crucial lessons from SDR is that the data model for the digital object metadata should be validatable, meaning that an instance of digital object metadata can be checked to ensure that it conforms to the data model. The primary means of making the data model validatable was to specify a schema. In addition to providing validatability, the schema serves as documentation for the data model.

We [^7] developed a home-grown data model for digital object metadata known as “Cocina”. Cocina digital object metadata is serialized as JSON and the schema is represented as an OpenAPI specification. [^8] OpenAPI was selected for the schema because:

1. It is widely adopted and has excellent tooling in multiple programming languages.
2. The same OpenAPI specification could be used as a specification for the API applications that “speak” Cocina.
3. OpenAPI provides a balance between ease of use and powerful validation.

Critical to integrating Cocina across our application was having a library to provide Ruby classes for Cocina. Thus, Cocina digital object metadata is manipulated in code as Ruby objects, not as JSON.

The Cocina classes are created by a code generator [^9] that we authored to transform a subset of OpenAPI into Ruby. As changes are made to the Cocina model, the OpenAPI specification is modified and new Cocina Ruby classes are generated.

The crux of this approach, however, is that when a new Cocina object is instantiated, it is automatically validated against the OpenAPI schema. [^10] Thus, digital object metadata is validated at the code level and at the API level. And, in both cases, the validation is performed using the same mechanism, viz., the OpenAPI specification.

There is a small subset of validations that cannot easily be represented in OpenAPI. For example, validating that the access rights at the object level are consistent with the access rights at the file level. For these, validation is performed in code that is also executed whenever a new Cocina object is instantiated. Together with the OpenAPI validation, this gives us high confidence in the consistency of Cocina digital objects. [^11]

It is worth noting that there is one part of the Cocina data model where this is not strictly true. The Cocina data model for descriptive metadata was architected by Arcadia Falcone (SDR’s metadata specialist) to allow for mapping to multiple metadata formats (e.g., MODS and DataCite). As such, it was structured to have a great deal more flexibility than other parts of the Cocina data model. While the basic structure of the descriptive model is validated via OpenAPI, additional semantic validation is defined elsewhere in the Ruby software library via a YAML file. [^12] This file enumerates lists of terms (e.g., valid note types) against which the values of selected properties may be checked at Cocina object creation time. These lists are more frequently changed than the model as a whole, so storing them separately allows the OpenAPI specification to remain more stable. In addition, the YAML file is used as the basis for documentation aimed at metadata creators who do not need the full model documentation.

## Strategy #2: Abstract the Datastore Behind an API

To address the tight binding between applications and the digital object metadata datastore (i.e., Fedora 3), the datastore has been abstracted behind an API. This API, known as DOR [^13] Services Application (DSA) allows applications to create, retrieve, and update Cocina digital objects, as well as a number of other repository functions such as initiating accessioning, managing versions, and recording events. Probably the greatest effort in the migration process has been to rewrite or refactor the existing applications to use Cocina objects instead of Fedora internally and to interact with DSA. This has been an iterative process, as we built out parts of the Cocina model and DSA functionality as needed for each SDR application being worked on (see Strategy #8).

Prior to migration, DSA internally performed a real-time two-way mapping between Cocina objects and Fedora objects [^14]. Thus, the basic activities of DSA prior to migration were:

When an application requested a Cocina object from DSA:

1. A Fedora object was retrieved from the Fedora datastore.
2. The Fedora object was mapped to a Cocina object.
3. The Cocina object was returned to the application.

When an application provided a Cocina object to be created:

1. A new Fedora object was instantiated.
2. The Fedora object was updated based on the Cocina object.
3. The Fedora object was saved to the Fedora datastore.

When an application provided a Cocina object to be updated:

1. An existing Fedora object was retrieved from the Fedora datastore.
2. The Fedora object was updated based on the Cocina object.
3. The Fedora object was saved to the Fedora datastore.

Given the complexity of the Fedora and Cocina data models and the substantial heterogeneity of the existing digital objects in SDR, this mapping code was of significant complexity; strategies for managing this are described below.

With all of our applications decoupled from Fedora, DSA became the sole application interacting directly with Fedora; at this point, DSA was itself tightly coupled with Fedora. One of the final phases of the migration was to encapsulate all Fedora interaction code *within* DSA to a dedicated service class known as the Cocina Object Store. All other services in DSA manipulated only Cocina objects; the mapping between Cocina objects and Fedora objects happened within the Cocina Object Store; this allowed a rolling migration as detailed in strategy #7.

## Strategy #3: Separate Concerns

One way of reducing complexity in the digital object data model and making the migration more manageable was to promote the separation of concerns, where services with distinct responsibilities were implemented in distinct applications. Also part of the separation of concerns was using distinct datastores for individual application specific services, rather than relying on storing metadata centrally in Fedora datastreams.

One such example is technical metadata. Previously, technical metadata was generated by JHOVE and stored as XML in its own Fedora datastream. This approach had a number of shortcomings [^15]:

1. Technical metadata was tightly bound to Fedora.
2. As the syntax of the technical metadata created by JHOVE changed over time, the metadata grew inconsistent.
3. There was no efficient way to query the technical metadata.

This approach was replaced by a dedicated technical metadata service. Implemented as a Rails application with an API, the Technical Metadata Service utilizes its own relational datastore for storing and querying technical metadata. It also obviated the need to include technical metadata (which itself is very complex and verbose) in the Cocina data model.

This approach was applied to various other services (e.g., events and workflow) that previously were tightly bound to Fedora in a single monolithic application.

Another benefit of this approach is that if and when these specific services or technologies change, this can be done in isolation as long as the API is maintained.

## Strategy #4: Test Mappings Against Real (Cached) Digital Objects

As mentioned previously, the two-way mapping between the Cocina data model and the Fedora data model was developed iteratively. Our initial approach was to rely on unit tests to ensure the accuracy of the mappings. Almost immediately, however, we encountered problems. Despite the unit tests and testing in a staging environment, each new release of mapping code brought a cavalcade of bugs, some breaking entire SDR applications, others affecting individual digital objects. [^16] A bug might be an actual unhandled software error or a mismapping.

While in part due to the complexity of the mapping, the core problem was the heterogeneity of our digital object metadata. (The reasons for this heterogeneity are articulated above.) In essence, we did not know all of the cases that the mapping had to handle or the unit tests had to cover. To address this, the approach that we took was to test each mapping change against a large set of actual digital object metadata (for a typical code change, the metadata for 100,000 digital objects).

Testing against a large set of actual digital object metadata had a significant barrier: Repeatedly retrieving digital object metadata from Fedora at this scale took too long and testing against actual digital object metadata meant impacting the production Fedora instance. To overcome this, a read-only cache was created where the datastreams for each digital object were stored in a zip file. The cache was kept updated by a process (called “cache-o-matic”) that queried Solr for recently changed digital objects and regenerated the cache files for those objects. The cache was much faster than using Fedora (in part because the cache used high speed storage) and had a smaller impact on production.

To verify a change, a developer would run “before” and “after” tests. This test would allow the developer to verify that a proposed mapping change would improve roundtrip mapping (or at least not make it any worse) and not introduce an unhandled software error. For each digital object in the test:

1. A Fedora object is instantiated from the cache.
2. The Fedora object is mapped to a Cocina object.
3. The Cocina object is run through object creation resulting in a new Fedora object.
4. The datastream in the original Fedora object are normalized and compared against the datastreams in the new Fedora object.
5. The new Fedora object is mapped to a new Cocina object.
6. The new Cocina object is compared against the original Cocina object.

The normalization in step 4 begs explanation. There are a number of reasons that normalization might be necessary, but in general it is to account for the heterogeneity of the data. For example, in early SDR, labels in the content metadata datastream were expressed as:

<attr type=”label”>My label</attr>

Later this changed to:

<label>My label</label>

The Fedora to Cocina mapping knew how to handle both cases. However, when mapping from Cocina to Fedora to generate content metadata, a label was always mapped to <label />. Thus, to allow comparing the original content metadata datastream and the new content metadata datastream, the <attr type=”label”> form had to be normalized to the <label /> form. [^17]

Extensive tooling was developed around round-trip testing. Key features included:

- Parallelizing testing for decreased testing times.
- Summary statistics for test runs.
- Logging of results for individual digital objects, including diffs of datastreams and Cocina JSON.

As migration progressed, roundtrip testing was also used to identify areas of the Fedora data model that were unmapped, aspects of the mapping or normalization that needed additional work (because roundtripping was unsuccessful), or digital object metadata that needed remediation. Roundtrip testing was run against increasingly larger samples of digital objects, up to and including all digital objects, and the results analyzed. Also, the summary statistics were tracked over time, allowing us to measure our progress.

Roundtrip testing proved very successful, minimizing the impact of mapping development on users and allowing us to measure the completeness of our mappings. These statistics were particularly helpful in communicating with stakeholders about the project’s progress.

## Strategy #5: Use Reports to Understand the Data

One by-product of having the cache of Fedora objects was allowing us to develop reporting tooling. This reporting made it very easy to answer questions about the digital objects which were crucial for the mapping development and the overall migration process. Examples of some of the questions answered include:

- Which objects are missing a MIME type for file content?
- Which objects are missing height and width for image content?
- What are all the values used for abstract types in descriptive metadata?
- Which objects use EDTF dates and what are those values?
- Which objects are missing a use statement from their access rights?

## Strategy #6: Template Unit Tests

The complexity of the mapping required a massive number of unit tests. Using a feature in the RSpec testing library called “shared examples,” mapping unit tests were structured so that a test consisted of providing a section of Cocina JSON and the corresponding XML for a Fedora datastream. [^18] When the unit test was run, numerous tests would be performed on each set of this input JSON/XML automatically, including:

- Mapping from Cocina to Fedora.
- Mapping from Fedora to Cocina.
- Mapping from the new Cocina back to Fedora, including handling normalization.
- Comparing the starting and ending Cocina
- Comparing the starting and ending Fedora

Boilerplate test code was significantly reduced, while increasing the completeness of testing.

This approach was particularly effective for descriptive metadata as it allowed Arcadia to write unit tests directly. Those unit tests would be commented out until the mapping was implemented by a developer. (This was much more effective than the earlier approach in which Arcadia maintained mapping examples separately which had to be kept in sync with the developer unit tests.)

## Strategy #7: Perform a Rolling Migration

One of the earliest business requirements that emerged from planning for the migration was the need to have no “flag days.” This meant that migration could not involve taking SDR offline; it had to be available to users at all times.

To meet this requirement, a rolling migration strategy was used. As described previously, all interaction with the datastore was abstracted behind the Cocina Object Store within DSA. Initially, that datastore was Fedora. As part of migration, Postgres was added as a datastore so that both datastores were in use at the same time. In Postgres, Cocina objects are stored as JSON in the Cocina data model (i.e., there is no need to map between data models). [^19]

During migration when retrieving a Cocina object from the Cocina Object Store:

- If the Cocina object was already saved to the Postgres datastore, it was retrieved from the Postgres datastore.
- Otherwise, a Fedora object was retrieved from the Fedora datastore and mapped to a Cocina object.

That is, retrieving from Postgres was preferred, with fallback to Fedora.

When creating a Cocina digital object with the Cocina Object Store:

- The Cocina object was saved to the Postgres datastore.
- The Cocina object was mapped to a Fedora object and saved to the Fedora datastore.

That is, the Cocina object was saved to both datastores.

When updating a Cocina digital object with the Cocina Object Store:

- The Cocina object was saved to the Postgres datastore (overwriting the existing Cocina object).
- The existing Fedora object was retrieved from the Fedora datastore, updated based on the Cocina object, and saved to the Fedora datastore.

That is, the Cocina object was updated to both datastores.

The other part of the migration process was a script that iterated over each of the digital objects stored in Fedora. If the digital object metadata did not already exist in Postgres, it mapped the Fedora digital object metadata to Cocina digital object metadata and saved it to Postgres. This ensured that even infrequently accessed digital objects were migrated. For increased performance, the script was parallelized.

When migration was completed, i.e., every Fedora object was saved as a Cocina object, the Fedora datastore was removed, along with the last of the Fedora-related code, all of the mapping code [^20], and the entire caching/reporting/testing framework. [^21] All digital object metadata is retrieved from and saved to the Postgres datastore.

This approach has a number of virtues:

- The migration could be performed over time without impact to users or downtime.
- If at any time during migration problems were encountered, the migration could be rolled back by deleting the Cocina digital object metadata from Postgres; the Cocina Object Store would default to retrieving them from Fedora.

## Strategy #8: Incorporate Migration Into Project Work

The prior strategies considered together required a significant dedication of labor and time, and much of this work was invisible to end-users, resulting in negligible user-facing impact. As the team devised migration strategies, none of our project work was going away and would need continuous attention throughout the migration; this was especially important for work supported by external funding which already had set, rigid timelines. It was clear to us that alongside the technical components of the migration, we needed a strategy to plan and resource migration work alongside, and within, our ongoing project work.

The team does not unilaterally, or in a vacuum, determine its portfolio priorities or work plans. Key to this strategy was ensuring a clear, shared understanding between the team and department leadership. A set of conversations led to a series of guiding principles for what we called “SDR Evolution,” a plan to continue chipping away at migration work over a multi-year period. These guiding principles included:

- Deliver user-facing value as SDR evolves, tying evolution work to user requirements.
- Evolve, rather than replace, SDR components (“No flag days!”).
- Inject seams into components to make SDR more API- and service-oriented.
- Focus on point improvements and not “changing the (SDR) world.”

With these guiding principles in hand, atop a platform of shared understanding between the team and its stakeholders, we set out to map our known portfolio gaps—the ones most likely to be prioritized for our upcoming work plan—to SDR migration needs.

As an example, we knew that replacing our self-deposit application was long-overdue work that our users deeply desired. [^22] We also knew that the self-deposit replacement work was an opportunity to make advancements to SDR migration by, e.g., placing an intermediate API between the deposit application and the underlying Fedora repository (Strategy #2), or moving related workflow definitions out of the repository and into the workflow service (Strategy #3).

The onus was on the team and its manager to negotiate with product owners about how many of these needs could be included in the scope of our work cycles. Fortunately, given leadership and stakeholders were already bullish on this strategy, product owners understood the value of including both their most beloved features along with migration work into our work plans. In the words of Tom Cramer, our department head: the focus of this work “is the evolution of SDR, updating key components methodically, leading to the long term replacement of the existing environment with a new system that is more modern, robust, and feature filled.”

The migration away from one repository back-end to another would have been hampered, at worst, and greatly delayed, at best, without an opportunistic strategy to use SDR-focused and SDR-adjacent work cycles to subsidize migration. This way, the team was able to make progress on SDR migration while new projects and new features continued to be prioritized.

## Conclusion

In May 2022, the migration process commenced. The only challenge during migration was that the logs on the Fedora server were filling up disk space faster than the logs were being rotated. To address this, the log disk space was expanded, but this required temporarily stopping Fedora and restarting it. In a final act of defiance Fedora refused to come back up. The team reached deep into its well of experience, mined ancient Slack logs, and consulted accrued wisdom of the ages (Google) to solve the problem. Ultimately, over 4 million objects were migrated in under a week, problematic objects were remediated, the migration was audited to ensure that every object in Fedora was in Postgres, and lastly, Fedora was removed.

While the overall digital repository migration did deliver some benefits for SDR users (increased performance and stability, rewrite or refresh of some long neglected applications), incredible patience has been required. The team looks forward to a future in which the potential of SDR is not tethered to the limitations of Fedora and we can work with SDR’s users to advance the scholarly mission of the university.

## Acknowledgements

The authors appreciate the contributions of current team members (Vivian Wong, Ed Summers, John Martin, Astrid Usong), former team members (Justin Coyne, Jeremy Nelson, Ben Albritton, Christina Harlow, Lynn McRae, and numerous others over the lifetime of SDR) and SUL colleagues (including but hardly limited to Andrew Berger, Amy Hodge, Cathy Aster, Hannah Frost, Tom Cramer).

## Notes

[^1]: Only part of the Infrastructure Team’s time is dedicated to SDR; we also support other applications such as the Sinopia Linked Data Editor, Know Systemic Racism, and the Digital Library of the Middle East.

[^2]: For storage efficiency, the files of the largest collection, Google Books (2.4 million digital objects) are stored in zipped files, where each zip includes an average of 800 files. In addition, SDR includes 46 terabytes of WARC files, each which contains many files. Thus, the actual number of files is significantly larger.

[^3]: For more on the Preservation System, see [https://journal.code4lib.org/articles/8482](https://journal.code4lib.org/articles/8482) and [https://2018.code4lib.org/talks/airing-our-dirty-laundry-digital-preservation-gaps-and-how-were-fixing-them](https://2018.code4lib.org/talks/airing-our-dirty-laundry-digital-preservation-gaps-and-how-were-fixing-them).

[^4]: For historical context on SDR, see [https://www.dlib.org/dlib/september10/cramer/09cramer.html](https://www.dlib.org/dlib/september10/cramer/09cramer.html). Note that the SDR nomenclature has evolved over time; this paper reflects the most current usage.

[^5]: The historical record is incomplete.

[^6]: The content files for the digital objects did not need to be migrated.

[^7]: And by “we”, we mean chiefly Christina Harlow, whose work as SDR Architect was crucial to development of the data model.

[^8]: [https://github.com/sul-dlss/cocina-models/blob/main/openapi.yml](https://github.com/sul-dlss/cocina-models/blob/main/openapi.yml) as YAML or rendered at [https://sul-dlss.github.io/cocina-models/](https://sul-dlss.github.io/cocina-models/).

[^9]: [https://github.com/sul-dlss/cocina-models](https://github.com/sul-dlss/cocina-models)

[^10]: Hereafter, an instance of a Cocina digital object that is instantiated as a Ruby class will be referred to as a “Cocina object.”

[^11]: Post-migration, we have continued to remediate data and add additional validations. For example, we recently added validation of dates.

[^12]: [https://github.com/sul-dlss/cocina-models/blob/main/description_types.yml](https://github.com/sul-dlss/cocina-models/blob/main/description_types.yml)

[^13]: DOR stands for “Digital Object Registry,” vestiges of old naming conventions in SDR.

[^14]: Just as a Cocina object is an instance of a Cocina digital object that is instantiated as a Ruby class, a Fedora object is an instance of a Fedora digital object that is instantiated as an ActiveFedora Ruby class. The Fedora object, in our usage in SDR, is essentially a wrapper around the XML-based metadata datastreams.

[^15]: Using JHOVE had a number of shortcomings for us; however, those will not be addressed in this paper.

[^16]: Crucial to identifying these bugs as they occurred was Honeybadger exception monitoring. Honeybadger is a third party exception reporting service. Honeybadger often allowed us to know about bugs before they were reported by users or to better identify the context for a bug reported by a user.

[^17]: With hindsight, it may have been possible to simplify the mapping code a bit by performing normalization before mapping (i.e., step 2).

[^18]: This description is simplified; the approach was actually much more flexible.

[^19]: Postgres was selected because of its ability to store and query JSON, it integrates well with Rails, and is well supported by the DLSS Operations Team.

[^20]: Actually, some of the mapping code will be retained to allow mapping to/from MODS, as it is a preferred format for descriptive metadata, and to the XML that is consumed by the Access System.

[^21]: The reporting code was bespoke to Fedora; new reports are accomplished with JSON queries into the Postgres datastore.

[^22]: This was one of the few exceptions in which we replaced an SDR application rather than evolve it.

## About the Authors

For the past 5 years, Justin Littman has been a software developer on the Infrastructure Team at Stanford Libraries’ Digital Library Systems and Services. Previously, he worked for George Washington University Libraries and the Library of Congress.

Mike Giarlo is a software engineer at Stanford Libraries, working on a team designing and developing software for long-term access to Stanford University’s research and cultural assets. His focus is on development and maintenance of the Stanford Digital Repository and collaboration with open source communities. He has held similar positions at Penn State University, the Library of Congress, Princeton University, the University of Washington, and Rutgers University.

Peter Mangiafico is a software engineer and product manager at Stanford University Libraries. He previously worked as an engineer, educator, teacher, manager, and research scientist in private companies, for NASA and for other universities.

Laura Wrubel is a software developer at Stanford Libraries and was formerly a software development librarian at George Washington University.

Naomi Dushay is a software developer at Stanford University Libraries for 15 years. She worked previously at Colorado State University Library, at Cornell University in the Digital Libraries Research Group, and at Cornell University Libraries.

For the past 6 years, Aaron Collier has been a software developer on the Infrastructure Team at Stanford Libraries’ Digital Library Systems and Services. Previously, he worked for California State University libraries as the Digital Repository Services Manager.

Arcadia Falcone is the Metadata Coordinator for the Stanford Digital Repository and heads the Stanford Libraries Metadata Design Unit. She was previously the Discovery Metadata Librarian at Yale University and has worked on metadata at the Harry Ransom Center, the Bancroft Library, and St. Mary’s College of California.

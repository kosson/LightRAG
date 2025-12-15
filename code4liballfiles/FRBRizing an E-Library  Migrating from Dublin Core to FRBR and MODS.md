---
title: "FRBRizing an E-Library : Migrating from Dublin Core to FRBR and MODS"
source: "https://journal.code4lib.org/articles/4357"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-12-21
created: 2025-01-10
description: "Western State College in Gunnison, Colorado developed an open-source eCataloger Framework, based on Dublin Core metadata, on Google's App Engine to manage and serve electronic resources to the library's patrons. Pressed to find new solutions for failing manual workflows for serials and government document resource management, the eCataloger Framework was extended to FRBR to automate [...]"
tags:
  - "clippings"
---
# FRBRizing an E-Library : Migrating from Dublin Core to FRBR and MODS
Jeremy Nelson, Alan Cleary

Western State College in Gunnison, Colorado developed an open-source eCataloger Framework, based on Dublin Core metadata, on Google’s App Engine to manage and serve electronic resources to the library’s patrons. Pressed to find new solutions for failing manual workflows for serials and government document resource management, the eCataloger Framework was extended to FRBR to automate and enhance serials management and government documents receiving. Based on successfully FRBRizing the eCataloger, Western State College converted their e-Library management from Dublin Core to FRBR and MODS. This paper examines the processes of each of these implementations using Python, AJAX, and jQuery, the details of the FRBR data model, including using FRBRoo, and the successful user interface supported by a FRBRized catalog.

## Introduction:

For a small academic library, the dual challenges of meeting patron demands for accessing information electronically coupled with static or shrinking budgets requires creative technology solutions. At the Leslie J. Savage Library at Western State College, we developed an E-Library, running on Google App Engine, to manage the presentation of purchased and free electronic resources. EBSCO’s Academic Search Premier, LexisNexis, JSTOR, and others, along with vetted research-oriented websites from government, corporations, and non-profits, are presented to our primary patrons, liberal arts undergraduate students and faculty.

The development of the eCataloger framework began with a class project through an ALA Electronic Collection online course which encouraged the curating and the development of a web interface to the library’s collection of purchased resources and vetted research websites. Almost concurrently with this class project, Google Corporation announced the release of a development Software Development Kit (SDK) for a new “cloud” application hosting environment called Google App Engine or GAE ([Google Inc.](https://journal.code4lib.org/articles/#note1))  Google App Engine does not use a traditional relational database but is built upon a Python interface to Google’s BigTable distributed storage systems for managing structured data at petabytes scale [(Chang, et al., 2010)](https://journal.code4lib.org/articles/#note2). Google App Engine also uses the open-source Django web framework [(Django Software Foundation, 2010)](https://journal.code4lib.org/articles/#note3) for its web interface. This presented an opportunity for the Savage library to develop and deploy an E-Library to our patrons without worrying about the logistical and budget requirements of hosting this application internally through the campus information technology department.

To represent a web-accessible resource, Dublin Core based data models were created as GAE native data classes with supporting data classes built using the controlled vocabularies of the Metadata Object Description Schema ([MODS](https://journal.code4lib.org/articles/#note4)) language from the Library of Congress. The first version of Western State College’s E-Library was released in the summer of 2008 and served 85 resources organized by title, subject, and genre facets.

With the successful deployment of the E-Library using the eCataloger application framework, we turned our attention to a couple of manual workflows in the library that used two legacy Microsoft Access databases for government publication processing and for tracking budget and usage for print serials. Both of these databases suffered from poor design, and usability was further limited because they were not accessible to front-line student workers at the library. Using eCataloger looked like a possible solution; however, the Dublin Core data classes were not semantically descriptive enough and lacked the type of relationship modeling to describe federal documents and print serials without extensive modifications. The current state of bibliographic research, the Functional Requirements of Bibliographic Records (FRBR), provided the necessary descriptive and modeling framework to create records for government publications and printed serials. Western State College deployed a serials management GAE application on February 2009 that contains 1,135 FRBR-based Works tracking 5,374 total individual Items. A federal and state government publications application deployed on April 2009 contains over 8,500 FRBR-based Works, Expressions, Manifestations, and Items and over 3,000 Federal and Colorado State shipping lists.

In January 2010, the design of the original E-Library for Western State College was starting to show its age and the library administration suggested that an update would be desired for the new year. Coupled with a new developer joining the eCataloger project, we decided to migrate the original E-Library classes and data to the latest eCataloger version along with an updated user interface using CSS and jQuery. The remainder of this paper will describe the original E-Library data classes and structure of the GAE application, the iterative development of the FRBR-based data models in developing two internal applications, and the challenges of migrating the original Dublin Core E-Library to eCataloger version 1.2.

## Dublin Core E-Library

The Dublin Core data classes supporting the GAE E-Library are just part of the Model-View-Controller structure of the Python-based Django web application framework. The basic design strategy for implementing the E-Library was to map some Dublin Core elements, like title, directly to a standalone data class (Titles) and to map other Dublin Core elements to properties of a larger data class, like Resource, in the application.  Additional properties were associated with Resource for management purposes that are not included in the Dublin Core specification. This version did not implement the full Dublin Core element set but just enough to support the requirements for the E-Library.

For the Dublin Core data model, all base entities were represented as individual instances in the Resources Google App Engine model. The information represents metadata “for simple and generic resources” ([DCMI Metadata Basics](https://journal.code4lib.org/articles/#note4)) and also includes additional properties used in the public display and in the management of these entities. Some of these Dublin core based properties such as creators, dates, uids (for *unique identifiers*), and editors, were placeholders but not actually used in the implementation of the E-Library. The subjects, publisher, and description properties were directly mapped to their corresponding Dublin Core definitions. Management properties, such as True/False Boolean properties like is\_subscription, were used to differentiate between paid subscription databases and freely available resources. The is\_trial Boolean property was used for trial period database subscriptions that were presented separately to the end user of the E-Library. The rating property provided a way to rank the resources so that a small sub-set could be highlighted as a “Popular Resources” facet in the patron web user interface.

In the initial design, a collections property was added as a way to host multiple E-Library’s on the same Google App Engine application instance. The ease of creating additional applications on Google App Engine allowed us to eliminate the collections management layer in the data model design for subsequent iterations of eCataloger. When an additional E-Library or other eCataloger application is needed, a new application instance is created on Google App Engine thereby shifting many of these collection management functions to the hosting framework.

The full Python code for the Resources model is presented below. The Resources class was derived from a BaseModel class (BaseModel was further derived from the Google App Engine Model class) that included common properties used through-out the data classes in the E-Library.

```
class Resources(BaseModel):
    titles = db.ListProperty(db.Key,default=None)
    creators = db.ListProperty(db.Key,default=None)
    editors = db.ListProperty(db.Key,default=None)
    uids = db.ListProperty(db.Key,default=None)
    subjects = db.ListProperty(db.Key,default=None)
    publisher = db.ReferenceProperty(Organizations)
    base_url = db.LinkProperty()
    description = db.TextProperty()
    genres = db.ListProperty(db.Key,default=None)
    collections = db.ListProperty(db.Key,default=None)
    rating = db.RatingProperty()
    dates = db.ListProperty(db.Key,default=None)
    languages = db.ListProperty(db.Key,default=None)
    website_check_frequency = db.StringProperty(required=False,
                                               choices=(["never",
                                               "daily",
                                               "weekly",
                                               "monthly",
                                               "quarterly",
                                               "yearly"]))
    is_subscription = db.BooleanProperty()
    is_trial = db.BooleanProperty()
```

Following the best practices suggested by the Dublin Core Metadata Initiatives ([DCMI Metadata Terms](https://journal.code4lib.org/articles/#note4)), a number of controlled vocabularies were used to restrict the range of data that would be accepted in the Genre data model class.  The Library of Congress’s MODS Genre element was used as the controlled vocabulary. Genres, while not present in the Dublin Core metadata, were incorporated as a property to further differentiate Resources. The first public web user interface presented a genre facet of the E-Library’s resources. In further refinements of the user interface, the design was simplified by removing the genre facet.

## FRBR Implementation in eCataloger

Following the successful deployment of the E-Library, attention turned to possibly using GAE to improve the operation of other areas within the responsibilities of the Electronic Resources, Serials, and Government Publications librarian. For a small academic library, the print serials costs consume a large portion of the library’s material budget so tracking usage of these materials is an important task for selection and retention decisions. The workflow for generating print serials usage statistics was an extremely manual process involving student workers and a poorly-designed Microsoft Access database.  A similar, highly manual workflow was also in place for processing federal and state publications when these materials entered the library that required multiple approval steps by staff and another manual input workflow into Microsoft Access.  Due to staff reductions and subsequent consolidation of job responsibilities, a single librarian with two or three part-time student workers were responsible for these workflows.

The amount of time these workflows consumed, the number of errors introduced in the manual data entry steps, and the increasing demands in other areas of the library on staff time meant that the current manual workflows were unsustainable.  By creating web applications for both workflows, the use of paper tracking and management of these essential library resources could be eliminated. Double or triple re-entry of the data into a database would be reduced to a single point-of-entry into a web datastore.  Using a web datastore allows for all of the data to be managed by a third party, an advantage of using cloud-based services, instead of the ad-hoc management of Microsoft Access databases on a shared network drive as had been the previous practice.  Finally, historical and current data could be merged on a web datastore for better and more comprehensive reports.

By necessity, the manual workflows for these serials and government publications did not track all of the information for individual items such as title, volume, and issue number. Including more identifiable item-level information would allow better and more granular reporting on the library’s resources.  This requirement is better met with web applications. While the Dublin Core metadata models can be easily re-purposed to track all this information for individual items, it lacked the type of relationship modeling of printed periodicals and government publications that would be necessary to replace these old workflows. For example, a serial has information associated both at an abstract collective level (title of the serial, ISSN number) and at the individual item level (volume, issue, barcode). The government publications needed to track individual items as well as its associations with one or more shipping lists. With Google App Engine as the hosting and application framework, research was done to see if a single data modeling strategy could be adopted that was flexible enough for meeting all of the requirements for replacing the current serials and government publications workflows.

Very soon, the conceptual models and underlying entity-relationship theory behind the FRBR effort ([FRBR Final report, 2009 pp. 9-10](https://journal.code4lib.org/articles/#note5)) became a leading candidate to use as the underlying datastore classes for these new web applications. FRBR explicitly attempts to model different levels of abstraction of bibliographic records that better fit both the serials application and government publication requirements. For the serials application, FRBR’s Work, Expression, and Manifestations provide the levels of abstraction separate from the individual Items needed in the application. In the case of the government publications, specific types of items, print, microfiche, and media, could also be modeled as FRBR entities. By using FRBR for the datastore classes, common CRUD (create, read, update, and delete) operations would be the same but with different user interface views and flow-control code for meeting the different requirements of the serials and government publications workflows. The library decided to first start with implementing the serials management web application with the intention that the same datastore models could be used for later development in other contexts like the government publications workflow.

## SerialsManager Web Application

As the first eCataloger application to implement FRBR as GAE datastore classes, the Serials Management application needed additional descriptive information to fully support an implementation-ready application. For example, the FRBR specification states that FRBR Works, Expressions, and Manifestations ([FRBR Final Report, 2009 pp. 33,36,40](https://journal.code4lib.org/articles/#note5)) have a title attribute with descriptions that closely match the Library of Congress MODS titleInfo element. By implementing the full MODS metadata elements as native GAE data model classes, these classes provided a rich enough base descriptive set to be used as FRBR Works, Expressions, Manifestations, and Items attributes without the need to create yet new classes to represent common metadata.

While the FRBR Specification does not explicitly define type 1 entity sub-classes, it is clear from their organization of entity attributes that they implicitly associate types of entities with certain attributes. For example their title for the Expression attribute 4.3.14 is ‘Expected Regularity of Issue (Serial)’ and in the description, the expression type is referenced as *serial* ([FRBR Final Report, 2009 p. 38](https://journal.code4lib.org/articles/#note5)). Implementing FRBR as an object hierarchy, we decided to create subclasses organized around these sets of attributes from base Work, Expression, and Manifestations classes. However, because two classes cannot have the same name in a module’s namespace, we could not use the same class name of Serial for both an Expression and Manifestation as mentioned in the FRBR Specification. To differ between a Serial Expression and a Serial Manifestation, a new Manifestation subclass of Periodical was used in the SerialsManager application.

As with the Dublin Core E-Library data classes’ additional properties, management properties like is\_current\_subscription, were added to the Expression class to meet management and reporting requirements of the application. Below are pseudo-Python code snippets showing the eCataloger MODS and FRBR classes with selected class properties and relationship linkage used in the serial management application.

```
class MODSmodels.titleInfo(BaseModel):
    type = db.StringProperty(required=True,
    choices=(['abbreviated',
              'translated',
              'alternative',
              'uniform']))
    displayLabel = db.StringProperty(required=True)
    subTitle = db.StringProperty()
    title = db.StringProperty()

class FRBRModels.Work(BaseModel):
    titles = db.ListProperty(db.Key,default=None)

class FRBRModels.Serial(Expression):
    frequency = db.StringProperty(required=True,
    choices=(['annual',
              'bimonthly',
              'semiweekly',
              '...']))
    is_current_subscription = db.BooleanProperty()
    issn = MODSProperties.identifierProperty()
    issuance = db.StringProperty(default='continuing')
    title = db.ReferenceProperty(MODSmodel.titleInfo,
    collection_name='expression_title')
    work = db.ReferenceProperty(Work,
    collection_name='realized_work')

class FRBRModels.Periodical(Manifestation):
    issue = MODSProperties.defaultProperty(default=None)
    expressions = db.ListProperty(db.Key,default=None)
    title = db.ReferenceProperty(MODSmodel.titleInfo,
    collection_name='manifest_title')
    volume = MODSProperty.defaultProperty(default=None)

class Item(BaseModel):
    barcode = MODSProperties.identifierProperty()
    manifestation = db.ReferenceProperty(Manifestation,
    collection_name='exemplified')
    usage = db.ListProperty(datetime.datetime,default=None)
```

A nice feature of using GAE data models is that creating associations between data store objects is not as restrictive as using tables and foreign keys in a traditional relational database. For example, the Item object’s manifestation property can reference a specific child class instance of the more general parent Manifestation class without the overhead of joining multiple tables in a foreign-key relationship as in a traditional database. GAE uses keys-values to create one-to-one, many-to-one, and many-to-many relationships which follows closely to the FRBR entity-relationship model.

Some unexpected benefits occurred when using FRBR as the organizing framework for data modeling in the serials management application. While the application was developed primarily to track usage of individual issues, by abstracting issue information from specific item data, we could now note damaged and replacement items and still track usage at the manifestation level for a better snapshot of the serials inventory. Missing items could now be better identified and tracked using the same application. The SerialsManager application also provided near real-time usage data, unlike the previous manual workflow that produced reports at semester intervals.

When the serials management application went live, student workers were able to enter an issue’s barcode or search for an issue and have the usage updated automatically using any web browser. Librarians and library administrators were able to run multiple types of reports from the same interface used by the students. To explore the additional functionality provided by Google App Engine, Django, and Python, a dynamic mashup was created that used OCLC and Gold Rush web services to augment the display for a single Work report. Gold Rush provided OpenURL linkage to any existing electronic full-text and abstract versions of the serial in the library’s databases while the OCLC web services provided OCLC identification and subject associations, all merged into a single view with the latest usage and items statistics for an individual Work.

## GovdocsManager Web Application

Building the second web application to replace the government documents manual workflow required some slight refactoring of the core FRBR and MODS classes in eCataloger. The Manifestation was first sub-classed to a FederalDocument child class that associated the manifestation with one or more shipping lists. The FederalDocument class was further sub-classed to support specific media like CDs, DVDs and microfiche. For application control and user interface convenience, an Endeavor class was added as a way to link a single Work-Expression-Manifestation-Item grouping for security and searching functions. This class’s name comes from the FRBR specification that briefly mentions grouping specific “products of intellectual or artistic endeavours”  ([FRBR Final Report, 2009 p. 13](https://journal.code4lib.org/articles/#note5)) into Work, Expression, Manifestation, and Item entities.  The following code snippet shows how the Endeavor groups a single Work, Expression, Manifestation, and Item along with a title into a single object.

```
class Endeavor(BaseModel):
    work = db.ReferenceProperty(Work,
    collection_name='endeavor_work')
    expression = db.ReferenceProperty(Expression,
    collection_name='endeavor_expression')
    manifestation = db.ReferenceProperty(Manifestation,
    collection_name='endeavor_manifestation')
    item = db.ReferenceProperty(Item,
    collection_name='endeavor_item')
    title = db.ReferenceProperty(MODSmodel.titleInfo,
    collection_name='endeavor_title')
```

The time savings and operational efficiencies of the government documents application over the manual workflow came about through additional eCataloger functionality at the application controller and user interface levels. Manual entry of many shipping lists was eliminated entirely by utilizing a United States Federal Depository service that hosts its entire shipping lists as electronic database files in dbf format on their servers, which is downloaded automatically by inputting the received shipping list number.  This single-step approach has produced lower error rates and significant time savings.  The government documents web application also allows for manual entry of items and shipping lists since the state depository library did not provide their shipping lists in any accessible electronic form.

## E-Library Migration to eCataloger 1.2 with FRBRoo

As the eCataloger framework matured through the release of two successful internal applications, implementation and design compromises that were initially made to facilitate deployment became more apparent. This, coupled with the library administration’s desire to update the now one-and-a-half year old E-Library’s user interface and to standardize all of the library’s web applications, presented an opportunity for a major refactoring of the eCataloger code base.

One of the compromises that had been made with the government publication application was the creation of ShippingList and its child classes. The ShippingList base and child classes were not FRBR entity classes but they did contain metadata and were a collection of FRBR FederalDocument FRBR entity classes. While this type of additional object-oriented class structure fit well with the FRBR classes, it felt arbitrary and FRBR should be able to represent the fact that such a Work that was also a collection of other Work objects. Fortunately, a draft definition of an object-oriented version of FRBR, called FRBRoo, had been released that is “a formal ontology intended to capture and represent the underlying semantics of bibliographic information and to facilitate the integration, mediation, and interchange of bibliographic and museum information.” ([FRBRoo, 2007 p. 10](https://journal.code4lib.org/articles/#note6)). FRBRoo provides an object hierarchy starting from base Work, Expression, and Manifestation classes with derived child classes that could replace the ad-hoc FRBR and supporting classes used in eCataloger. For example, the FRBRoo Work subclass, ContainerWork, would be a good parent for the eCataloger ShippingList class.

A full refactoring of the core eCataloger FRBR and MODS libraries using FRBRoo as an implementation guide resulted in a number of new additional classes and relationships.  Unit tests were added to eCataloger to ensure the new FRBRoo data classes would still support the existing serials and government documents applications while adding new E-Library classes.  Unit testing improves the robustness and extensibility of the entire eCataloger framework by creating stub FRBRoo instances to test for consistency and usefulness when implemented in the controller and view aspects of the eCataloger framework. Unit testing is also a formalized way of ensuring units of code perform in an expected manner and allows for better change management by assuring that any new changes to the data models would not break existing functionality as well as testing if any new changes could accomplish the expected design outcomes. Over 250 unit tests were created to test the data models representation and linking characteristics of the datastore and the new FRBRoo classes. If the modeling of these entities in our unit tests resulted in expected behavior, we would feel confident in adding the changes to eCataloger.

To migrate the data from the original E-Library hosted at [http://ecataloger.appspot.com/](http://ecataloger.appspot.com/) to a new instance of the Western’s E-Library hosted at [http://wscecataloger.appspot.com/](http://wscecataloger.appspot.com/), client-side Python scripts were developed to transform the Dublin Core original data instances into the latest version of the FRBRoo-based eCataloger data instances. A SQLite database was used as transitional data storage and to manage the linked nature of the data models in both the Dublin Core and FRBR models.

After the supporting classes were migrated to the eCataloger 1.2 data class entities with the resulting Google App Engine unique keys saved back to the SQLite database (please see [Appendix 1](https://journal.code4lib.org/articles/#appendix1) for a complete mapping), a Resource entity was deconstructed into the eCataloger FRBR Work, Expression, Manifestation, and Items classes or sub-classes. The actual Resources entity is represented in eCataloger 1.2 data models as an IndividualWork, SelfContainedExpression, RemoteAccessElectronicResource manifestation, an Item, and finally either of these two convenience collection endeavor classes: PurchasedElectronicResourceEndeavor or WebSiteEndeavor. The RemoteAccessElectronicResource class comes from an implicit sub-class in FRBR ([FRBR Final Draft, 2009 p. 40](https://journal.code4lib.org/articles/#note5)). For a complete mapping between the original Dublin Core E-Library Resource and the eCataloger FRBR and MODS data classes, please see [Appendix 2](https://journal.code4lib.org/articles/#appendix2).

## E-Library jQuery User Interface, AJAX, and Proxy Cache

An essential requirement of moving to version 1.2 of eCataloger for Western’s E-Library involved an update to the web user interface. The JavaScript and cascading style-sheet open-source framework jQuery was selected for building a more responsive and richer functional interface for the students, faculty, staff, and the local community of Western State College.

The new interface is driven primarily by jQuery base library functions and the jQuery User Interfaces plugins. Sizing is one of the jQuery functions used to fit the interface into the frame dynamically. Although somewhat of a hack, the Sizing function was selected as an alternative to moving towards a more complex vector-based interface. A second useful function is the jQuery dialog function that created quick notifications to the end user in the administration interface and was also very useful for debugging the application. Three jQuery plugins, cookie, highlight and treeview, add functionality to different interactive aspects of the application The cookie plugin is imported in multiple templates and used by other jQuery plugins. The highlight plugin is used in the public interface to highlight search terms found within search results. Finally, the treeview plugin proved to be the most versatile and is used in both the public and staff interfaces as a way to organize and present different free and purchased endeavors as seen here:

[![Figure 1: E-Library use of jQuery treeview plugin](https://journal.code4lib.org/media/issue12/nelson/Figure_1.png "Figure 1: E-Library use of jQuery treeview plugin")](https://journal.code4lib.org/media/issue12/nelson/Figure_1.png)

**Figure 1.** E-Library use of jQuery treeview plugin

The jQuery UI accordion, animated, tabbed, and vertical menu plugins are used within the staff interface. Both the accordion and the tab jQuery UI plugins organize the various tools and functions of the administration interface into a single web-page as seen below:

[![Figure 2: E-Library use of accordian plugin](https://journal.code4lib.org/media/issue12/nelson/Figure_2.png "Figure 2: E-Library use of accordian plugin")](https://journal.code4lib.org/media/issue12/nelson/Figure_2.png)

**Figure 2.** E-Library use of accordian plugin

The Quick Manage tab’s simplified user interface allows administrative users an easy way to create, edit, and remove PurchasedElectronicResourceEndeavor or WebSiteEndeavor objects in the E-Library. The Advanced Cataloger Tools displays a full treeview of all of the FRBR and MODS objects in the datastore and allows the user to create, edit, or remove any of these objects. The Set-up & Help tabs assist in configuring the E-Library and adding help topics for the public E-Library. The Reports tab provides usage information on Endeavor and help topics by users in the E-Library.

Here is a screen shot of the edit view for the LexisNexis IndividualWork instance. All data objects in eCataloger can be managed in the same interface:

[![Figure 3: Edit View for the LexisNexis IndividualWork Instance](https://journal.code4lib.org/media/issue12/nelson/Figure_3.png "Figure 3: Edit View for the LexisNexis IndividualWork Instance")](https://journal.code4lib.org/media/issue12/nelson/Figure_3.png)

**Figure 3.** Edit View for the LexisNexis IndividualWork Instance

Basic usage of these jQuery plugins is fairly simple with some JavaScript customization that allows for reliable and rapid development of the user interface. Unfortunately there were a few issues with cross-browser compatibility. Though jQuery works in browsers such as Firefox, Chrome, Opera, and Safari, Microsoft’s Internet Explorer was consistently problematic. Although the majority of the issues were fixed, a bug in the treeview persisted. The focus property found in the styling was being overridden by some preset in Internet Explorer causing a hidden gif used for the selection area to be highlighted. Despite attempts at numerous fixes applied to both the treeview and jQuery stylesheets the bug remained.

In the first version of the E-Library, all of the public interface’s facets were generated in a Django template and then stored as a string cache for faster serving to the end user. In eCataloger 1.2, we implemented dynamic loading of the different facet tree-views jQuery plugins using AJAX calls that run in the background until the trees are fully populated from the datastore. This shortens the overall load time for the application and provides a more responsive user interface.

Full-text searching of the titles, subjects, and descriptions of the resources is implemented using AJAX in the 1.2 version of eCataloger. Using the jQuery framework allows us to highlight the text the user searched in a single area within the user interface. Supporting the full-text searching in the datastore is done with Google App Engine’s searchable data-model on the server to create crude title, description, and subject associations with an endeavor. A rough weighting scheme for the results is also implemented on the server side through the use of native Python data structures that weights duplicate results higher for the end user’s search query.

Under the current design, the RemoteAccessElectronicResource’s proxy\_address property contains a URL for off-campus access to the resource through an authentication proxy service hosted by the library’s catalog vendor. This proxy address can differ from the RemoteAccessElectronicResourcer’s access address and eCataloger 1.2 serves the proxy address automatically to any patron attempting to access the E-Library from off-campus. In the eCataloger 1.2 management dashboard, the eCataloger administrator sets the IP range for the institution. When a resource is requested from a user IP that is outside that range, the proxy address is delivered to the patron instead of the access address associated with the FRBR RemoteAccessElectronicResource manifestation.

Since deploying the new E-Library, the application averages over 1,100 visits a week during the school.

## Conclusion and Future Directions

From its beginnings as a Dublin Core-based E-Library, the eCataloger framework has evolved into a rich native FRBR-based data and application framework running on Google’s cloud services. With FRBR becoming more established as a bibliographic standard for catalogers, the focus and debate on its usefulness has been on how well it meets patron needs and tasks. This paper provides another reason for using FRBR. The eCataloger project demonstrates the advantages and value of using FRBR as an operational tool for improving library workflows as well as fulfilling the more traditional conception of FRBR as an access tool to library resources in the latest version of E-Library.

While Google App Engine platform and application stack has been very useful in developing and deploying the E-Library and internal applications, there have been some scalability and processing limitations with Google’s free quota.  Some of these limitations have been addressed with later improvements to Google App Engine. However, for system librarians, library students, library software developers, and others interested in how a cloud computing environment can help them offer more services and resources to their patrons and staff, eCataloger running on Google App Engine offers a lot of functionality for very little financial cost.

The direction and development road-map of the eCataloger project has shifted because the librarian and project lead left Western State College for a new position at a different institution. The eCataloger framework, having already demonstrated its utility in the daily operations of small academic library, is now being used as an informatics research platform.

As a research tool, two eCataloger import modules were developed to investigate the challenges of importing external MODS XML and MARC files into native eCataloger FRBR data classes. Unit tests were built to test the import parser and it was a surprisingly easy task due to the use of MODS as the descriptive data schema in the design for the eCataloger data classes. To further test the interoperability of the eCataloger framework, a suite of unit tests were created to test a MARC binary record import into native eCataloger FRBR data classes, by-passing any need to do an XML-crosswalk between MARCXML and MODS XML records. While this first iteration of the MARC import module successfully imported a couple of sample MARC binary records into eCataloger data objects, more work and testing is needed.

The eCataloger project is looking to offer a complete open-source stack that leverages the current Python code-base but is not limited by the constraints of Google’s App Engine service. The Apache software project Hadoop offers an open-source implementation of Google’s BigTable infrastructure and is being investigated as a potential datastore for the next version of eCataloger. The distributed, entity-relationship nature of Hadoop would allow eCataloger to scale up from its current maximum of around twenty thousand entities under the free quota of GAE to a FRBR-based datastore managing hundreds of thousands to millions of FRBR entity objects. A full open-source stack would also allow eCataloger to leverage the work being done on open-source next generation catalog user interfaces like the Ruby-on-Rails Blacklight project as an eCataloger alternative user interface.  Future eCataloger applications could be run either as a Google App Engine application or as a self-hosted “cloud” application.

A more robust test of eCataloger’s scalability and usability would be to import an entire library’s collection of MARC records into eCataloger FRBR entities. Over the next year, the eCataloger project lead will begin work on the next iteration of the eCataloger with the intention of importing an entire academic library collection into a single datastore. Why do this? Because it is exciting to think of the potential operational efficiencies and improved user experience FRBRizing an entire library would bring using eCataloger on a complete open-source stack.

## Appendix 1 – Supporting Classes Migration Mapping

| **Original eCataloger Model** | **Mapping Strategy** | **eCataloger 1.2 Model** |
| --- | --- | --- |
| Countries | Manually associated the contained\_in property to a  pre-existing continent type hierarchicalGeographic entity | MODS hierarchicalGeographic entity with type equal to “country” |
| States | All of the states were only associated with a single hierarchicalGeographic entity for the United States. | MODS hierarchicalGeographic entity with type equal to “state” |
| Cities | Cities contained in the United States had both State and Country links, the contained\_in property was set to the hierarchicalGeographic entity for that State. For cities in other countries, the contained\_in property was set to the hierarchicalGeographic entity for that Country. | MODS hierarchicalGeographic entity with type equal to “city” |
| DCSubjects (*Dublin Core Subjects)* | Each DCSubjects entity created two 1.2 Entities, a MODS subject entity and a FRBR Concept entity, with the the subject entity created first and its key associated with a Concept entity for a 1:1 relationship. | MODS subject entity with authority set to “local”  FRBR Concept entity with identification\_status set to “provisional”, subject references MODS subject entity |
| Genres | Maps to MODS genre class, all Genres values initially taken from the controlled MARC genre terms vocabulary | MODS genre entity with authority set to “marcgt” |
| Organizations | Organization is directly mapped to a FRBR CorporateBody entity, the MODS hierarchicalGeographic entity for the City is referenced through the CorporateBody place property, the Organizations entity description is first created as a MODS note entity and then associated with the CorporateBody entity | MODS note entity with type equal to “description”  FRBR CorporateBody entity, identification\_status set to “provisional”, place refers to MODS hierarchicalGeographic entity, description refers to MODS note |
| Titles | All Titles were mapped 1:1 to MODS titleInfo entities, the titleInfo display\_form property was set to the raw value of the Titles while the titleInfo title property value was set to the all lower case of Titles value. | MODS titleInfo with type set to “uniform” |

## Appendix 2 – Resources to FRBR Entities Mapping

| **Resource property** | **Mapping strategy** | **eCataloger 1.2 Entities** |
| --- | --- | --- |
| base\_url | Create MODS url entity with value set to base\_url | MODS url entity  FRBR RemoteAccessElectronicResource entity access\_address property references MODS url entity |
| creators | Placeholder, no data in implementation, would map to Work creators property |  |
| dates | Placeholder, no data in implementation, could map to FRBR Work properties, FRBR Events, FRBR Expression, and FRBR Manifestation depending on the type of date |  |
| description | Create MODS note entity with type set to description | MODS note entity with type set to “description”  FRBR IndividualWork entity notes property includes MODS note entity  FRBR RemoteAccessElectronicResource entity notes property includes MODS note entity |
| editors | Placeholder, no data in implementation, would map to Work creators property with an FRBR Creator entity associated with a MODS role with “editor” type |  |
| genre | MODS genre entities created in previous step | MODS genre entities associated with the FRBR RemoteAccessElectronicResource entity genres property |
| is\_subscription | Manifestation property | FRBR RemoteAccessElectronicResource entity is\_subscription property |
| is\_trial | Manifestation property | FRBR RemoteAccessElectronicResource entity is\_trial property |
| publisher | FRBR CorporateBody entity already created in previous step | FRBR RemoteAccessElectronicResource entity publisher property references FRBR CorporateBody |
| rating | Maps to FRBR RemoteAccessElectronicResource   popularity property | FRBR RemoteAccessElectronicResource popularity property |
| subjects | MODS subject entities and FRBR Concept entities created in previous step | FRBR Concept entities associated with FRBR IndividualWork entity subjects property |
| titles | MODS titleInfo entity already created in previous step | MODS titleInfo entity part of FRBR IndividualWork entity titles property  MODS titleInfo entity referenced by FRBR SelfContainedExpression title property  MODS titleInfo entity referenced by FRBR RemoteAccessElectronicResource  manifestation title property  MODS titleInfo entity referenced by either FRBR PurchasedElectronicResourceEndeavor or FRBR WebSiteEndeavor title property |
| uids | Placeholder, no data in implementation, would map to MODS identifier entity with the type (issn, barcode, etc.) of the uid. MODS identifier entity would be associated with FRBR Expression, FRBR Manifestation, or FRBR Item classes or sub-classes depending on the type of uid |  |

## References

“AppScale Open Source Google App Engine.” *AppScale Open Source Google App Engine*. UC Santa Barbara RACELab, Dec 2009. Web. 7 Jun 2010. [http://appscale.cs.ucsb.edu/](http://appscale.cs.ucsb.edu/)

[Chang, Fay, Jeffrey Dean, and Sanjay Ghemawat, et al.](https://journal.code4lib.org/articles/#ref2) “Bigtable: A Distributed Storage System for Structured Data.” *OSDI’06: Seventh Symposium on Operating System Design and Implementation*. Seattle, WA, 2006. Web. 7 Jun 2010. doi:[10.1145/1365815.1365816](http://dx.doi.org/10.1145/1365815.1365816)

[“DCMI Metadata Basics.”](https://journal.code4lib.org/articles/#ref4)*Dublin Core Metadata Initiative*. Dublin Core Metadata Initiative Limited, 2010. Web. 7 Jun 2010. http://dublincore.org/metadata-basics/index.shtml

[“Django – The Web Framework for Perfectionists with Deadlines.”](https://journal.code4lib.org/articles/#ref3)*Django*. Django Software Foundation, 2010. Web. 7 Jun 2010. [http://www.djangoproject.com/](http://www.djangoproject.com/)

[“Google App Engine – Google Code.”](https://journal.code4lib.org/articles/#ref1) *Google Code*. Google Inc., 2010. Web. 7 Jun 2010. [http://code.google.com/appengine/](http://code.google.com/appengine/)

[“Functional Requirements For Bibliographic Records.”](https://journal.code4lib.org/articles/#ref5) *IFLA Website*. International Federation of Library Associations and Institutions, Feb 2009. Web. 7 Jun 2010. [http://www.ifla.org/en/publications/functional-requirements-for-bibliographic-records](http://www.ifla.org/en/publications/functional-requirements-for-bibliographic-records)

[“FRBR object-oriented definition and mapping to FRBR-ER.”](https://journal.code4lib.org/articles/#ref6) *CIDOC – CRM*. CIDOC CRM Special Interest Group, May 2007. Web. 7 Jun 2010. [http://cidoc.ics.forth.gr/docs/frbr\_oo/frbr\_docs/FRBR\_oo\_V0.8.1c.pdf](http://cidoc.ics.forth.gr/docs/frbr_oo/frbr_docs/FRBR_oo_V0.8.1c.pdf)

“jQuery : The Write Less, Do More, JavaScript Library.” *jQuery : Write Less, Do More*. The jQuery Project, 2010. Web. 7 Jun 2010. [http://jquery.com/](http://jquery.com/)

Lagoze, Carl, Herbert Van de Sompel, Michael Nelson, and Simeon Warner. “Open Archives Initiative Protocol for Metadata Harvesting.” *Open Archives Initiative*. Open Archives Initiative, 14 Jun 2002. Web. 7 Jun 2010. [http://www.openarchives.org/OAI/2.0/openarchivesprotocol.htm](http://www.openarchives.org/OAI/2.0/openarchivesprotocol.htm)

[*Metadata Object Description Schema: MODS (Library of Congress)*](https://journal.code4lib.org/articles/#ref3). Washington DC: Library of Congress, 2010. Web. 7 Jun 2010. [http://www.loc.gov/standards/mods/](http://www.loc.gov/standards/mods/).

Project Blacklight. Web. 2 Sept 2010. [http://projectblacklight.org](http://projectblacklight.org/)

Jeremy Nelson is the Metadata and Systems Librarian at Colorado College. Prior to working as a librarian at Western State College and other libraries, he was a programmer and project manager at three different software companies. He is a graduate of Knox College and the Graduate School of Library and Information Science at University of Illinois. Jeremy can be contacted at jeremy dot nelson at coloradocollege dot edu.

Alan Cleary is an undergraduate student pursing Computer Information Science and Mathematics at Western State College. His work primarily consists of web based applications and database management software. Alan can be contacted at the dot alancleary at gmail dot com.
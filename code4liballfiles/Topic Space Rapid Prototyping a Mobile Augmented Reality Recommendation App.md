---
title: "Topic Space: Rapid Prototyping a Mobile Augmented Reality Recommendation App"
source: "https://journal.code4lib.org/articles/10881"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-10-20
created: 2025-01-10
description: "With funding from an Institute of Museum and Library Services (IMLS) Sparks! Ignition Grant, researchers from the University of Illinois Library designed and tested a mobile recommender app with augmented reality features. By embedding open source optical character recognition software into a “Topic Space” module, the augmented reality app can recognize call numbers on a [...]"
tags:
  - "clippings"
---
# Topic Space: Rapid Prototyping a Mobile Augmented Reality Recommendation App
Jim Hahn, Ben Ryckman, Maria Lux

With funding from an Institute of Museum and Library Services (IMLS) Sparks! Ignition Grant, researchers from the University of Illinois Library designed and tested a mobile recommender app with augmented reality features. By embedding open source optical character recognition software into a “Topic Space” module, the augmented reality app can recognize call numbers on a book in the library and suggest relevant items that are not shelved nearby. Topic Space can also show users items that are normally shelved in the starting location but that are currently checked out. Using formative UX methods, grant staff shaped app interface and functionality through early user testing. This paper reports results of UX testing; a redesigned mobile interface, and provides considerations on the future development of personalized recommendation functionality.

## Introduction

Libraries have sought to leverage advances in mobile-networked technologies since users began to access the library homepage and licensed databases from the mobile browser. Several libraries extended their mobile development into the application development area\[[1](https://journal.code4lib.org/articles/#note1)\]. While app development can be resource intensive, the benefits for native mobile digital services can make great advances in services to library patrons.

New library services are possible through native mobile apps and those native affordances; the native hooks available include accessing hardware of the device like the camera for optical character recognition, as well as inferring location based on GPS, Wi-Fi, or other beacons. This makes possible an exciting UX research space since both aspects of digital and physical touch points are the basis for inquiry. One overarching concern within the Library UX field is how to integrate digital touch points with the physical experience and interactions among both.

### Research questions

Mobile augmented reality is a challenging UX area. Augmented reality (AR) requires overlaying digital content onto markers or tags in physical space. The challenges in creating augmented reality services for mobile include the small form factor for the phone and the interactivity of utilizing the camera or video feed for augmenting the space.

By using an iterative rapid prototyping methodology our mobile UX augmented reality research questions were investigated. Specifically, researchers sought to explore how users would interact with augmented reality tools designed to assist in the navigation of the physical space while undertaking authentic course-based assignments. Thus our research question grew out of the authentic need of students to find related material in the physical browsing area, especially since students are increasingly being asked to complete interdisciplinary assignments.

One of the defining features and departure points for this project was the underlying concern that students may overlook related items in the print book stacks if they only focus on one area — and that several areas may be relevant to their topics. Our focus was on undergraduate collections and in designing apps that support first-year students. Our research questions included:

- Inquiring if, based on the recommendations, students could tell us other subjects that may be of interest to their topic.
- From the results of the mobile app, could research participants tell us what books were not available — e.g. could they tell from the app what books were currently checked out.
- We inquired if seeing these recommendations led to a broader understanding of what their research topic was about.
- We wanted to know if such an app was useful; thus we inquired if the books that were recommended would be utilized in their research.
- We asked students to tell us if the app was a worthwhile tool for the library to develop.

The recommendation middleware leveraged both Library of Congress subject headings as well as historical circulation data as a basis for recommendations. Grant staff leveraged all historical checkout trends available in the library, beginning from 2003 through 2014. Historical checkout data helped to show users what others items have been popularly circulating. Since the broader UX field is coming to understand how best to make personalized recommendation services in library and educational settings, a benefit of this research is to demonstrate student preferences. We demonstrate results of one approach to location-based personalized recommendations, and make suggestions to future system designers in how best to leverage legacy circulation data within the on-site browsing experience. Contemporary library recommendation systems have not been sufficiently or closely integrated into the on-site browsing experience in library books stacks.

### Grant goals

With successful funding from an IMLS Sparks! Ignition Grant, researchers from the University of Illinois Library were able to prototype an augmented reality app utilizing optical character recognition software embedded into a native Android app as the “Topic Space” module. The funding source paid for hourly programmers sourced from the School of Computer Science at the University of Illinois who worked on the project for three semesters. Additional partnerships for the grant included collaboration with the Graduate School of Library and Information Science where researchers in HCI and rapid prototyping helped shape the formative evaluation component of this research and features for recommendations in the library book stacks.

Goals of the IMLS Grant included the following:

- Create shelf recognition software
- Develop directional wayfinding support that shows users how they are physically navigating an “idea space”
- Complete rapid iterative studies of mobile software with library patrons
- Identify technical infrastructure needed in order to make AR an ongoing part of technology in libraries
- Make available AR apps widely

At the end of the grant the augmented reality app functionality was accomplished, allowing a user to take a picture of a call number on a book in the Undergraduate Book Stacks, which then provides recommendations based on the subject area of the call number.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace01.png)  
**Figure 1.** The Topic Space software can recognize call numbers of an item when a student successfully takes a picture of the book in the Undergraduate Library. Optical Character Recognition (OCR) is processed on that call number and from this input the app is able to infer the shelf location of the user.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace02.png)  
**Figure 2.** Using the call number, the server-side web service runs queries, which are based off of the LC classification system. The app then downloads and displays the related media to the end-user.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace03.png)  
**Figure 3.** Students can also see books that are normally shelved here but that are currently checked out, (displayed in the app as: “Related Books- Unavailable @ UGL”) achieving one of the aims of Augmented Reality, which is to integrate digital information with objects in the physical world. The value of this service is increased access to collections that may normally go overlooked.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace04.png)  
**Figure 4.** These suggestions are also plotted on a map so that the user can be guided to the items in the building.

This paper progresses with a literature review putting this grant work into context with other UX mobile augmented reality projects, followed by a review of methodology relevant to the formative prototype evaluation. Following this are results of the study including interface revision and functionality redevelopment. The paper concludes with lessons learned, considerations of extensibility of this work in other library recommendation services including laying the foundations of personalized recommendations throughout the Library online catalog and web presence.

## Literature Review

Azuma (1997) defined augmented reality (AR) in the classic work on the topic in *Presence: Teleoperators and Virtual Environments* as allowing “the user to see the real world, with virtual objects superimposed upon or composited with the real world. Therefore, AR supplements reality, rather than completely replacing it. Ideally, it would appear to the user that the virtual and real objects coexisted in the same space.” At the time that Azuma wrote his paper (1997) app phones were not yet commonplace, so that augmented reality generally was considered in the context of peripherals such as head mounted displays. Only recently, in the past decade (the iPhone was launched in 2007) have mobile augmented reality services become a possible arena for development. In mobile augmented reality, for this paper’s purposes, we attempt to supplement the on-site browsing experience in the library book stacks, looking to augmented collocation features of library collections.

Collocation objectives in library science have been well researched and established as supporting serendipity while obtaining a known item (Svenonius, 2000, pp.21-22) and so this applied research project references and extends the collocation objectives in library collections and descriptions. A further extension considering the range of probable use cases for mobile augmented reality applications for library services has been theorized (Hahn, 2012) and experimented within course assignment sheets and syllabi (Hahn, 2014). The [ShelvAR app](https://www.youtube.com/watch?v=NgZVI630SsI&feature=youtu.be) is another significant addition to uses in book stack based AR technologies within library settings.

### UX in mobile augmented reality

In Bai & Blackwell’s (2012) *Analytic review of usability evaluation in ISMAR*, the authors examine a corpus of papers from the International Symposium of Mixed and Augmented Reality proceedings. The authors note that —“Many users are initially impressed by the unique user experience of AR. However they may also be surprised by its technological limitations such as rendering latency, intermittent tracking failure, registration error and perception issues they would not normally experience in a conventional interaction environment,” (Bai & Blackwell 2012, p457). The notion of rendering latency is reported later in our results section as we found similar themes when users attempted to identify the call number on books with OCR.

## Methodology

Grant staff utilized rapid prototyping methods (Jones & Richey, 2000) in designing augmented reality features. Staff sought to understand user preferences of augmented reality mobile interfaces that best support location-based recommendations early in the design process. Using early functional prototypes, researchers observed and interviewed students before a final design was completed (revised mobile interface shown in Results section). By forming interface app functionality early in the design phase we are able to iterate working prototypes into a viable and useful recommendation app.

For this study we loaded the Topic Spaces module onto a library owned Android development phone. Users did not have to download the app to their device to participate in the study. Tests for the Topic Space module took place in the Undergraduate Library at the University of Illinois. The collection includes a separate run for media (30,000 items), journals (400 subscriptions), and monographs (150,000). The monograph collection was the focus of this recommendation study.

With Institutional Review Board approval, researchers were able to approach anyone in the library in order to recruit them into the study. Researchers chose to approach those users who were actively looking for books in the library. While this recruitment methodology can be more time intensive, finding users who were actively searching for books can result in more precise findings for the anticipated use case for the app. In library assessment methodology, this recruitment technique is known as intercept testing (Jones & Sinclair, 2011, p24).

The consent form also stipulated that participants must be currently enrolled students to participate in the study. A total of five student participants provided feedback on the initial prototype interface. We chose this number based on the classic Usability Engineering work by Nielsen, where most usability pain points can be uncovered with a small test set of users (1993). Students received a $10 gift card for their participation. Each student interview and observation lasted no longer than thirty minutes.

The task included users taking a picture of a library call number with the Android development phone in a starting location and then following the recommendations. The phone would then provide two areas of recommendations for books along with specific recommendations for an item to look at which was not shelved nearby. We asked users if they felt the recommendations were relevant to their starting location and if they felt they would use these recommendations for research papers. For UX prompt, observation form, and debriefing interview questions, see Appendix.

## Results

We collected formative evaluations of what students liked about the app, what they found confusing, and if they felt the app would be worthwhile to develop. These data are presented as aggregate trends.

Unexpected results include the observation that students moved their starting locations to be nearest to books that they had previously read, since they wanted to use the app to find other related books that were similar to those they had enjoyed in the past.

In our debriefing interviews we learned that some students would make use of the recommendation features and other topic areas that the app suggested. Students increasingly expect their digital experiences to be similar to those of Google. For example, students expected that the app would display the location of the phone as it moves through the bookstacks; similar in nature to Google maps functionality. This type of indoor positioning is feasible to prototype using beacon technology\[[2](https://journal.code4lib.org/articles/#note2)\].

The biggest hurdle for students in utilizing this app was their expectations for the camera phone; students expected the OCR process to be instant. In practice, we found that the app takes a few seconds to focus and then send the string of captured text to the web server; the web server then takes an additional couple seconds to gather candidate recommendations. As a result, we moved toward more instant scanning with a barcode scan input, which is much faster and provides more reliable metadata to use to suggest items.

### Revised interface

Based on our observations and interviews we considered the following in our next iterations:

- Easier and more efficient input
- Streamlined result sets
- Supplemental book information
- Ability to easily request materials
- Easier to read mapping functionality

![](https://journal.code4lib.org/media/issue30/hahn/topicspace05.png)  
**Figure 5.** A revision to the first level of the app. In the revision, items get input into the recommendation system by way of barcode input. Scanning the item this way ensures quicker recommendation that students expect.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace06.png)  
**Figure 6.** Revised first level view. After scanning a barcode, we reduced some of the cognitive overload by showing recommended books and ranges in a more common list view design pattern. The list view is expandable to provide additional details. As an added benefit students are able to see the number of recommended items in a topic area so that they have a sense of the total number of recommendations before expanding the view.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace07.png)  
**Figure 7.** Revised detail view provides expansion support for exploring additional recommendation details.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace08.png)  
**Figure 8.** Revised Undergraduate Library map. This design provides streamlined recommendations so that only one relevant collection location in the Undergraduate Library is suggested per map view. This also helps reduce the cognitive load of wayfinding, since only one point (red dot) is plotted. The “Start Shelf” corresponds to a shelf range number in the physical library.

## Discussion

Outcomes of the grant include the availability of the [Topic Space module within Minrva app on the Android Play Store](https://play.google.com/store/apps/details?id=edu.illinois.ugl.minrva) and an experimental [Backbone.js based Topic Space web app](http://minrva-dev.library.illinois.edu/). Current implementation of the Topic Space module requires that users select the Undergraduate Library location. While other locations are planned, the module is being developed in this pilot location first before launching library-wide.

In order to complete grant tasks there were several unexpected useful technical developments. The technical developments include the designing of a Topic Space API, a web app component, and the move to barcode scanning. After the technical findings that follow, we note several next steps for recommendations across library platforms noting that the additional usefulness of the recommendation components for this tool are cross-channel, and extend outside of the mobile environment.

### Topic Space API

In order to generate the recommendations data required by the native Android application we created new server side middleware that would combine several data sources into the app. The app required data from the Vufind searches to gather candidate recommendations, data from the Voyager Oracle Reports server in order to rank candidate recommendations based on popularity (sum circulations), and a small SQLite table of the stack arrangement in the Undergraduate Library. Together these tools support suggesting items that were not near the student, but within the library. The service also helped to supplement OCR intelligence by way of a customized data table of the Library of Congress classifications, including classes and subclasses, to help map out distinct subject areas within our own library.

The functions, with comments referencing the recommendation process are coded as follows:

#### Server Side Recommendations Processing

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23 | `String startSearchTerms = getSearchTerms(context, search, scannedOrManual, classifications);`  `ArrayList bibIDs = bibID (startSearchTerms);`  `ArrayList topicSearch = topics (bibIDs);`  `ArrayList finalWebpages = finalWebpageList(topicSearch);`  `ArrayList filteredList = filterList(finalWebpages);`  `ArrayList bookInfoArray = bookArray(filteredList);`  `ArrayList booksList = bookList(bookInfoArray);`  `List books = finalResults(booksList, context);` |
| --- | --- |

#### Details of connecting to the custom SQLite LC Table.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32 | `String driverName = ``"org.sqlite.JDBC"``;`  `Class.forName(driverName);`  `String url = ``"jdbc:sqlite:"` `+ filePath;`  `conn = DriverManager.getConnection(url);`  `Statement stmt = conn.createStatement();`  `String qry = "SELECT * FROM ” + qryEnd;`  `rs = stmt.executeQuery(qry);` |
| --- | --- |

By developing a server-side API to power the suggestions, we were able to enlist the support of the Library’s Infrastructure Management and Support department who are currently patching security updates in the RedHat server running the APIs. As is common practice in the Software Developer Group in Library IT, we have also documented the web APIs in the library’s micro-services wiki, ensuring that others could build off of this work. The public link to the Topic Space API is available on the [Minrva Project website](http://minrvaproject.org/services_topicspace.php), under their “Minrva Services” section. The skills required to continue AR development include middleware development so that multiple data sources (ILS checkout data, Subject Headings, Map data) can be combined into a data object consumed by the mobile or web app.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace09.jpg)  
**Figure 9.** Modular Minrva APIs are exposed RESTfully and allow extensible applications to be developed for multiple platforms.

The extensibility of a RESTful API made it possible to re-use the middleware for a web-based recommendation service based on user location. The web-based version is enabled in the Undergraduate Library location. After searching for an item and viewing item details, a user can continue to find related items by tapping the “Topic Space” recommendation button in the detail view.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace10.png)  
**Figure 10.** The business logic in the tomcat web app has proven versatile enough to make iOS, Android, and web apps from one middleware solution.

### Topic Space web app

The [web app component](http://minrva-dev.library.illinois.edu/) will be incorporated within a kiosk in the Undergraduate Library. By accessing the app from the tablet kiosk in the Undergrad Library (e.g. selecting the Undergraduate Library location) users will have access to the same Topic Space suggestions as they would if they had taken a picture of the call number in the library bookstacks, thus continuing to support users access to collections they may not have been aware.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace11.png)  
**Figure 11.** An image of Topic Spaces Recommendation for the web. The display indicates recommendations for the title, “The Pizza Bible,” based on circulations and LC subjects of items in the Undergrad Library. See the [item detail page](http://minrva-dev.library.illinois.edu/#loc/uiu_undergrad/The%20Pizza%20Bible/uiu_7616776/Book) for the first level recommendation.

A key unexpected finding of this grant project was the ongoing personalized recommendations research to pursue, which we discovered by developing an API to power the native app. We have done some preliminary experimentation with ways to re-use the app data feeds in our library login. Our sustainability plan is to re-use, re-purpose, and extend the infrastructure from this project for improving access and discovery of collections library-wide.

For searching in targeted subject areas, contemporary catalog systems and discovery environments do not make it easy to drill into targeted subjects before you search — typically this must be done after the search, after the result set has already become overwhelming to filter. Utilizing a custom built catalog API we provide an example of ways to narrow, and drill into the preferred subject area in the first set of results.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace12.png)  
**Figure 12.** An example of topical filtering before a user begins her search.

When researchers began this grant one of the key motivating factors for developing augmented reality was the use of OCR. While we were funded to fully exploit the possibility of optical character recognition software, its use brought up more user challenges than it solved. In practice, as we matched up the user requirements of capturing the target item quickly and seamlessly, we found that barcode scanning could achieve this aim. Since we could not achieve user requirements after initial testing with character recognition alone we decided to chose seamlessness of scanning over the more technically challenging OCR approach. Further development of recommendations in the scanner module of the Minrva app may allow a more precise set of recommendations, since OCR is dependent on broad subject associations by LC letter or subject, and the scanner software package is designed to interface directly with the subject areas of a bibliographic identifier.

## Next Steps

Currently, Topic Space relies on the Library of Congress classes and subclasses to help generate “Topic Spaces.” In future versions of the Topic Space module, we would like to include the functionality for Dewey Call Numbers as well. After both classification systems are incorporated into the Topic Space module, we would then be able to map out the relational areas between Dewey Decimal classes and Library of Congress classes. This would allow the use of Topic Space in additional University of Illinois Libraries, incorporating cross-unit results between the library system’s 32 collection/service points.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace13.png)  
**Figure 13.** A proposal for cross-library recommendations and novel location-based recommendation approach for large multi-unit research libraries. Demo represents recommendations by location and popularity through Undergrad, Main Library Book Stacks, and the Music & Performing Arts Library.

### Personalized Recommender through Library Account

The grant work from developing Topic Space will continue by way of ongoing Library funding supporting student developers in the library. Part of this project’s sustainability plan will include keeping student developers active in development of “more like this” functionality within portions of the main library homepage. This will be investigated within the account login screen, where a user logs in to renew items or place requests. The single page web app could provide recommendations from the library homepage account login — since recommendations are powered by supplying an item’s unique bibliographic identifier and user accounts are populated with bibliographic identifiers of checked out items. The personalized recommendations can also be informed by items on the user’s favorite list and generated when an item in the account is renewed. A renewal of an item may be an indication of a topic that the user would like to know more about. Since the user may not be able to take advantage of collocation from her account login, the recommendation service may help support this important feature that is lost in the digital library experience.

Next steps after implementing personalized recommendations require further inquiry into how best to use the data generated by user clicks in the recommender. A truly powerful recommender could result if the data were mined and utilized in providing future recommendations for users. The basis for mining could be check out and requests of the recommendations provided to users. Since few libraries have implemented such recommender systems from the account login, we believe sustained research in this area and further study of user behavior will provide the UX community and system designers valuable models for bringing library systems in line with contemporary information systems employed by Amazon, Netflix, and Google.

![](https://journal.code4lib.org/media/issue30/hahn/topicspace14.jpg)  
**Figure 14.** Prototype of “more like this” services from within a user account. The recommendations utilize a modified Topic Space API that can suggest items that are related (by subject) and are popular (by circulation count).

## About the Authors

Jim Hahn is Orientation Services and Environments Librarian and Associate Professor at the University of Illinois Undergraduate Library. His research into technology-enhanced learning investigates the development of mobile software applications within library settings and provides unique insights into new students’ expectations and needs. He currently leads the [Technology Prototyping Service at the University of Illinois](http://sif.library.illinois.edu/).

Benjamin Ryckman, Lab Manager & Lead Android Developer, has worked with Jim and the Minrva Project Team since 2012 to develop mobile applications. He graduated with a BBA from Eastern Illinois University, and is self-taught in the Java programming language. Ben leads in the development and upkeep of the Minrva App (Android), regularly programs new APIs to provide data for upcoming Minrva modules or other University of Illinois Library applications, and helps coordinate and manage the software developers.

Maria Lux, Graphic Designer, has a BFA in graphic design and studio art from Iowa State University and recently earned her MFA at the University of Illinois. Maria sees graphic design as a method for making information accessible and usable, and working in the University of Illinois Library Technology Prototyping Service gives her the opportunity to contribute design approaches to a student-centered project such as Minrva. Maria is involved with user interface design and the creation of supplementary materials to help share Minrva with a wider audience.

## References

Azuma, R. (1997). “A Survey of Augmented Reality” *Presence: Teleoperators and Virtual Environments* 6, 4 355-385.

Bai & Blackwell (2012). “Analytic review of usability evaluation in ISMAR” *Interacting with Computers* 24, 6 450-460.

Hahn, J. (2012). “Mobile augmented reality applications for library services” *New Library World* 113, 9/10 429-438.

Hahn, J. (2014). “Undergraduate research support with optical character recognition apps” *Reference Services Review* 42, 2 336-350.

Jones, J.L., & Sinclair, B. (2011). “Assessment on the go: Surveying students with an iPad” *Journal of Library Innovation* 2, 2 22-35.

Jones, T. & Richey, R. (2000) “Rapid Prototyping methodology in action: a developmental study,” *Educational Technology Research and Development* 48, 2 63-80.

Nielsen, J. (1993). *Usability Engineering*, Academic Press, Boston, MA.

Svenonius, E. (2000). *The Intellectual Foundation of Information Organization*, MIT Press, Cambridge, MA.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] See for example [NCSU’s Wolfwalk](http://www.lib.ncsu.edu/reports/wolfwalk), and a variety of several other native apps on the [Library Success Wiki](http://www.libsuccess.org/M-Libraries#Mobile_applications) on “M-libraries.”

\[[2](https://journal.code4lib.org/articles/#ref2)\] See for example, off the shelf indoor location tools for mobile apps provided by [Estimote](http://estimote.com/).

## Appendix

### UX Prompt/Scenario Instructions

Prompt: You are assigned an interdisciplinary research topic requiring multiple sources. Your professor has asked you to find print sources for the paper. You can start from any subject location in the Undergrad Library Book Stacks.

**1\. Search for books on your chosen topic using the Topic Spaces app. To use the app select the Topic Space icon and then take a picture of call number on a book.**

From the result of the mobile app can you tell us what other subjects may be of interest to this topic?

From the results in the mobile app can you tell us what books are not available? Do any of the unavailable books look helpful for this area?

From the search results are you able to tell us more about what your topic is about?

**2\. Go to one of the sections of the library that was identified as relevant.**

Can you tell us if the books seem related to your first topic?

Based on your starting location would you use these books in your research paper?

By viewing books in this area, are you able to tell us more about what your topic is about?

**3\. Go to the second section of the library that was identified as relevant.**

Can you tell us if the books seem related to your first topic?

Based on your starting location would you use these books in your research paper?

By viewing books in this area, are you able to tell us more about what your topic is about?

### Interview Questions

How easy is the app to use? What would make it easier to use?  
What was hard to do with the app?  
What was confusing?  
What was surprising?  
What do you wish you could have done with the app while you were using it?  
How useful do you find the app? What would make it more useful?  
Would you recommend it to friends?  
What do you actually want from a library recommendation app? Is there something else that should be here that is not here?  
Is this app a worthwhile tool for the library to develop?

### Observation Form

\*Note starting call number: \_\_\_\_

How easy to use is the app?

What unexpected things occur?

How do students react when the app does not work as they expect?

How do students make use of the recommendation features?

Note any additional observations of student use of the app:
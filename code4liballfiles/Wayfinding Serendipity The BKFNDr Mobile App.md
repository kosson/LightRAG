---
title: "Wayfinding Serendipity: The BKFNDr Mobile App"
source: "https://journal.code4lib.org/articles/13811"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-11-08
created: 2025-01-10
description: "Librarians and staff at St. John’s University Libraries created BKFNDr, a beacon-enabled mobile wayfinding app designed to help students locate print materials on the shelves at two campus libraries. Concept development, technical development, evaluation and UX implications, and financial considerations are presented."
tags:
  - "clippings"
---
# Wayfinding Serendipity: The BKFNDr Mobile App
Valeda Dent, Kiichi Takeuchi, Ben Turner, Heather Ball, Caroline Fuchs, Ann Jusino, Shilpa Karnik

Librarians and staff at St. John’s University Libraries created BKFNDr, a beacon-enabled mobile wayfinding app designed to help students locate print materials on the shelves at two campus libraries. Concept development, technical development, evaluation and UX implications, and financial considerations are presented.

## Introduction

In 2017, members of the St. John’s University Libraries’ Web and Emerging Technologies group (WEmTech) embarked on a mobile wayfinding project using beacon technology, which would assist students in finding print materials on the library shelves. Inspired by the NavApp developed at the University of Oklahoma Libraries (Aruba Networks, 2015), the St. John’s University Libraries’ BKFNDr app provides a way for students to navigate the often-confusing library stacks and make their way to relevant materials at the shelf level. The goals of the project were two-fold: to assist students in becoming more familiar with the Libraries’ physical collections and layout; and to support the serendipity of browsing via mobile technology. This article details the project implementation at the Queens campus library.

Beacon technology has been around since 2013, when Apple introduced its iBeacon technology (Newman, 2014). Beacons can be found in retail, museum, hospital, airport, and other settings where wayfinding is important (Moody, 2015; Chawathe, 2008; Kajioka, 2014; Newman, 2014). Beacons are passive devices – they emit a signal that simply identifies where they are physically. The beacons are not aware of the devices that receive or process the signals they emit. Beacons do not collect data, are usually platform independent, and although beacons may be referred to as being part of the Internet of Things (IoT), they typically do not connect to the Internet without an additional layer of software that can interpret their signals. The beacons used for this project are Bluetooth Low Energy (or BLE) beacons. Beacons often work with Bluetooth technology which allows Bluetooth-enabled devices to pick up the signals emitted by beacons once activated. Mobile devices can also be used as beacons since they are typically Bluetooth-enabled. As devices pick up signals being emitted by the beacons, the devices can identify the distance from the beacon, or the distance between multiple beacons. In this way, devices become location aware or location sensitive (Newman, 2014).

The St. John’s University Libraries’ BKFNDr app required the placement of beacons on the library shelves of the circulating collection, and then mapping of each beacon to an exact location. These locations were defined by shelf ranges, thus allowing each beacon to be mapped to a specific shelf content area. The number of beacons on any given shelf is related to the signal range of the beacons, and the degree to which those signals can be kept from interfering with one another. Beacons placed too close to one another might give students multiple location readings for the same item, and beacons placed too far apart might not get students close enough to the materials they are looking for.

## Literature Review

There are a variety of technologies that enhance location awareness for users, including near field communication (NFC), global positioning systems (GPS), and quick response code technology. The literature suggests that beacon technology is far more accessible (Moody, 2015), mainly because all three of the aforementioned technology types require the user to initiate a pull for information as opposed to having information pushed to their devices.

Wayfinding and location-aware technologies are useful in a variety of settings, in part because of the potential for integration with local systems already in place and the application of analytics to enhance the user experience (Sturari et al., 2016). Hospitals and other healthcare settings are particularly interested in improving the user experience, and timely provision of updates as a patient moves through various destinations (such as check-in, radiology, ER, surgery) is one way to improve these experiences for both patient and family (Dutta & Palta, 2014).

The application of beacon technology in library and information settings is less common than in healthcare and retail, yet there is great potential for adoption in libraries. “The potential for beacons is limited only by the applications that are developed to work with them, so it will be fascinating to see how libraries use them in the future.” (Spina, 2015). Application developers also recognize the potential for wayfinding technologies to be used within library settings. Capira Technologies and BluuBeam are two examples of vendors who focus on library and information settings (Enis, 2014).

> Capira’s beacons will offer general notifications, and since CapiraMobile is already designed to communicate with a library’s ILS in order to support functions such as self checkout and patron record notifications, its beacons will also be able to send personalized messages to individual patrons when they are in range. (Enis, 2014).

Babu (2016) suggests that the 12 areas where beacons will become more prevalent are hotels/hospitality; retail; airports; schools/universities; hospitals/healthcare; banks; museums; zoos/theme parks; smart cities; events, and libraries. Babu (2016) also details the top use cases for beacon technology within libraries:

Shelf information  
Book circulation notifications  
Event updates  
Navigation support  
Booking study rooms (Babu, 2016)

Babu (2016) presents the example of the Bavarian State Library in Munich, which uses more than 200 beacons in 90 different locations to help with wayfinding in a large complex library building. Chia (2014) describes the development of a 3D wayfinding app at the Nanyang Polytechnic Library in Singapore, which uses the Conveno Wayfinding tool and leverages a cloud computing platform. The app directs users to specific items in the stacks as well as to rooms and collections. Similarly, librarians at the University of Urbana-Champaign developed a an app to help users navigate the print collections, using student testing and input to improve the app, which resulted in the addition of features like a search box that allows users to search by book title, and visual enhancements such as display of the book’s cover (Hahn & Morales, 2011). The Fayetteville Free Library in New York and New Jersey’s Somerset County Library System have both experimented with the use of beacons to enhance library user experiences (Enis, 2014).

Other location-aware library apps serve a marketing function by promoting services and collections to users. The Borough of Manhattan Community College (BMCC) Library initiated a beacon project that was designed to fill the spaces where librarians could not always be present. The library placed six beacons in locations such as the stacks, display areas, and other public areas where users might need to be alerted to the presence of services and key collections (Eng, 2015). The Orange County Library system began using Bluetooth-enabled beacons in 2014 to promote new video acquisitions and to highlight featured library collections. Mount Pleasant Public Library in New York State placed an ILS-Integrated beacon near its circulation desk which alerts users when their items are due, or when holds are available for pick-up (Dempsey, 2016). The navigation app at the University of Urbana-Champaign also made location-based recommendations to users (Hahn, 2011). At Delft University of Technology in Holland, librarians used 15 Bluetooth-enabled beacons to create a self-paced tour of the library, partnering with a Dutch start-up that developed apps for museum tours (Dempsey, 2016).

## Technical Development

### Beacon Selection

The product selected for the St. John’s University Libraries’ wayfinding project was the Radius Network beacon. This product was selected because of the affordable price ($10 per beacon if more than 100 are purchased), the variety of beacon hardware available (configured and without configuration), and the well-supported configuration apps.

### Cost

Funding for the project was provided by the Provost’s Initiative Fund, a special fund designed to get start-up projects off the ground with the intention of eventually making these new services or products permanently available for the University community. At the time of this writing, St. John’s University Libraries had spent approximately $12,865 USD on BKFNDr, including the beacons ($2920 for 280 beacons), app developer kits, and software development costs (approximately 153 hours @ $65/per hour). There were also indirect costs related to the initial stages of the project, namely, the amount of time that the WEmTech Group and the developer spent discussing and planning for the design of the app. The most significant cost was related to the collection maintenance and catalog work that had to be completed so that the location features of the app would accurately reflect materials on the shelves and the catalog. The University Libraries had not conducted a thorough shelf reading project in many years, thus this was a major initiative that included many hours of work. Approximately 46 students, 4 staff members and 3 faculty on the two campuses worked on the project beginning in the late spring of 2017. To date, student worker costs have amounted to about $43,000 for both the Queens and Staten Island Libraries. Libraries undertaking a similar project should ensure the accuracy of the catalog and shelf list prior to development. This will save time and money.

### App Design

The WEmTech Group at St. John’s University Libraries facilitated design of the app. The group discussed the following basic requirements during the development phase:

1. Catalog search capability (Fig. 1)
2. Interactive library map display (Fig. 2)
3. Graphically represented user location display
4. Graphically represented book location display

![Figure 1](https://journal.code4lib.org/media/issue42/dent/1.png)

**Figure 1.** Library catalog search screen ([enlarge](https://journal.code4lib.org/media/issue42/dent/1_large.png))

![Figure 2](https://journal.code4lib.org/media/issue42/dent/2.png)

**Figure 2.** Map screen layout ([enlarge](https://journal.code4lib.org/media/issue42/dent/2_large.png))

### Architecture

Figure 3 illustrates the data flow between the client and server for the BKFNDr app with the deployed beacons. The Libraries at St. John’s University use Koha, an open source Integrated Library System (ILS), and the catalog search is the first prompted input required of the user. Once the user enters search terms, results are returned by the catalog, and the user selects the item they want from the list (see Fig. 1). The next screen provides bookshelf-level location details facilitated by the detection of beacon signals (see Fig. 2). As the user moves within the space, the app continuously updates their location in relation to the item on the target bookshelf until they are in the right spot.

![Figure 3](https://journal.code4lib.org/media/issue42/dent/3.png)

**Figure 3.** Client and server architecture diagram

### Technology Stacks

In the initial development phase, a sample app was designed based on the iBeacon implementation guide from Apple (2014). This first test app was built to help determine the strength of the beacon signals. Programming was accomplished using Swift 3 (Apple, 2018a) and XCode (Apple, 2018b). In the production version, the Ionic Framework (Ionic, 2018) was used. Ionic is a free, open source, multi-platform software development kit that is used in the creation of mobile applications. This was an important consideration for the St John’s team since students function in both iOS and Android mobile environments. Two other important considerations in using the Ionic Framework were the previous experience of the project’s developer in using this resource and the availability of the iBeacon plugin within the Ionic ecosystem.

The latest Ionic technology layers are based on the Angular Framework (Angular, 2018), and most of components and business logic are implemented in TypeScript. The presentation layer was implemented using Ionic Components with SaSS. The Ionic Framework uses Webpack as the build system (Iconic, 2018), and the debugging environment is on the local web server. Unfortunately, when testing with the iBeacon application, the app has to be deployed on a physical device, and deployment is a time-consuming process. To overcome this slow debugging process, a timer-based function was created to emit dummy signals within the web browser, thus eliminating the need for the developer to use the device to test the app over and over again. The preparation of this simple beacon simulation code in early development phase was instrumental in terms of making the rest of development phases more efficient.

The server-side modules for the app are also critical to overall function. Initially, bookshelf and beacon location data were hardcoded within the app itself. Those datasets eventually needed to be published as a Representational State Transfer (RESTful) web service because of the dynamic quality of the app. The database size is expected to remain relatively small, with no more than an estimated few hundred items. St. John’s University Libraries already had in place a hosted Linux server running MySQL, and the data was imported into that same server. Backend services in PHP were implemented to publish the records and to make them searchable.

The project relied mostly upon open source technology, which significantly reduced the overall development cost.

### Mapping and Translating Datasets

At the beginning of the project, several options for facilitating the mapping features of the app were explored. These included ArcGIS, CAD Data, and a few third party indoor GIS solutions. In the end, standard web technology (HTML5 / CSS3) was selected to render the target marker. This choice kept development costs down.

The rendering of the actual bookshelf maps was informed by a process used at Wayne State Library to facilitate locating materials on the shelves (Gallagher, 2010). Librarians integrated map coordinates as an overlay on highlighted bookshelf areas featured on the Library’s floor map (Gallagher, 2010). In the case of St. John’s, the raw images were used to create the graphic designs.  
The mapping of the library bookshelves at St. John’s involved the acquisition of the original blueprints as a high-resolution image file. The database containing the bookshelf call number ranges was then constructed using MySQL. Once all the records were imported, an administrative module was created to support the mapping of each bookshelf on the administrator’s mobile device (Fig. 4). Using the administrative module, the target bookshelf name was selected from the dropdown menu at the top of the screen, the corresponding bookshelf location touched on the screen, and the new position saved.

![Figure 4](https://journal.code4lib.org/media/issue42/dent/4.png)

**Figure 4.** Administrative screen for beacon management ([enlarge](https://journal.code4lib.org/media/issue42/dent/4_large.png))

Since the screen size of mobile devices can vary greatly, and the app relies heavily on a graphic representation of bookshelves, it was important to display the relative coordinates (Fig. 4, top left corner) as a percentage rather than as an absolute pixel length.

### Location Algorithm

The concept of using mapping technology in a setting like St. John’s University Libraries required both an understanding of the way that mapping technology works in traditional navigation environments (such as roadways) and the challenges of using the same conceptual framework indoors. Using beacons to navigate users step by step is neither practical nor precise because of the variability in beacon deployment (Apple, 2014).

The BLE beacon used for this project informs the user of the signal strength via its Received Signal Strength Indicator (RSSI). This signal is strongest at 0 and decreases as it weakens. It is important to note that the RSSI is a measure of signal strength only: it is not a measure of the physical distance between the beacon and the device.

To orient the user in the library, a blue dot appears on the screen in relationship to the closest beacon; a red dot marks the shelf location of the item selected by the user (see Fig. 2). However, initial field tests showed the blue dot bouncing here and there, and not necessarily in relation to the user’s location. The problem was the stability of RSSI, causing a user with a handheld device standing between two beacons to receive conflicting information about the location of the nearest beacon. If the signal strength for one beacon is -35 dBm, and the closest beacon to that one has a signal strength of -50 dBm, the app directs the user to the first beacon since it has a stronger signal at that moment. If those signals change in relation to the handheld device being moved slightly in the next moment, the app may then direct the user to the second beacon even though the initial signal reading was accurate. To address the temporary spike in the signals, the development team at St. John’s created a timeline-based algorithm to control the variability of the signal strength. Essentially, the algorithm allowed for the weighted total of signals emitted within a certain timespan to be used as an indicator of the beacon likely to be closest to the user.

Once the algorithm was in place, attention was focused on beacon placement. Zou et al. (2016) found 6.5 m (about 21 feet) to be an effective range in terms of beacon signal coverage. Beacons were thus deployed at both ends of each library bookshelf, about 15.4 feet (or 4.7 m) apart, well within the range suggested by Zou et al. (2016).

## Deployment

### Configuration & Placement

The circulating and reference collections at the Queens Campus Library consist of four wings – a North and South wing – on the 3rd and 4th floors. These wings consist of shelves where the beacons were installed. As of the writing of this article, 20 beacons had been placed on top of bookshelves within the Library’s 3rd Floor North Wing (Fig. 7). Upon completion of the North Wing, another 200 beacons will be deployed in the remaining three wings at the Queens Campus Library. At the Staten Island Campus Library, a total of 60 beacons are in the process of being configured and installed.

The beacons are not visible from the ground and are relatively safe from theft or damage. Each beacon was set up initially with the lowest strength and frequency in order to conserve energy and allow operation for approximately 6 months before needing a battery change. To facilitate the precision of the positioning and mapping features, each beacon was identified by a Universally Unique Identifier (UUID), a Major Coordinate, and a Minor Coordinate. UUID is set by the manufacturer based on the ISO/IEC 11578:1996 Standard (ISO, 2018). Major and Minor are 16-bit identifiers which need to be set by the developer. Using this naming convention, a mapping schema was created to document the major and minor settings (Fig. 5).

| Bookshelf | Bookshelf Number | Front (0) / Back (1) |
| --- | --- | --- |
| Beacon | Major | Minor |

**Figure 5.** Mapping schema

In this schema, Bookshelf 3N05-F will have a beacon whose coordinates are 5 for the major and 0 for the minor. All bookshelves for this phase of the project have the same prefix of 3N which is the Library’s 3rd Floor, North Wing. The postfix, F, represents the front of bookshelf (Fig. 6). This configuration and designation also allowed library staff to locate a beacon if for some reason it got moved or lost. Lastly, a general PIN was assigned to all of the beacons to provide configuration security.

### User Experience, User Testing Results & Implications

Overall, the BKFNDr app adhered to the most basic principles of UX design for mobile applications: an uncluttered interface; minimization of cognitive load for the user; offloading of certain tasks (e.g. BKFNDr helps users fill in the title of the item they are looking for); and minimization of user input (Babich, 2018). Many elements beyond the control of the developer can impact mobile UX, thus user testing is critical.

Members of the WEmTech team performed preliminary field testing of BKFNDr on the 3rd Floor North wing of the Queens Campus Library and found that the app performed satisfactorily in directing them to shelves that contained specific titles. In a second round of field testing, WEmTech recruited four students, and one alumnus, for a total of five test users. One of these students was a library student worker. Participants were each given a different title of a book that resided on the 3rd Floor North wing and were instructed to use the app to find the item in the stacks. Participants used the “think aloud” protocol (Bastien, 2010) to allow greater insight into their thoughts and experiences as they attempted the task. A member of the WEmTech team accompanied and observed each participant. According to Nielsen (2012), testing with five users can reveal the majority of usability problems, whereas using more than five tends to produce duplicate results and diminishing returns on time and money invested. The app was not available in Google Play at the time of testing, so only iPhone users were included in the initial field tests. Once the app becomes available in Google Play, user testing will also be conducted with Android users.

In general, the app worked as expected, and all of the test users were successful in entering the book titles and eventually locating the book in the stacks. Three test users took advantage of the “autocomplete” feature of the app that saved them from typing the complete title into the search box. The app successfully identified the correct shelf for four of the five books, giving the test users a clear path to finding them. In one case, the app was slightly off, and directed the user to a stack next to the correct one.

User feedback was generally positive. One student mentioned that it would be helpful if the red dot marked the location of the book, rather than just the shelf, but still appreciated that the app expedited the process of finding a book in the stacks. Another test user who was entering her senior year admitted that although she had regularly used the library’s electronic resources, had only used the physical library on rare occasions, and that she would have had difficulty locating a book using the call number alone. Even the student who was initially directed to the wrong stack was able to use the call number provided by the app to direct her to the correct one.

A common problem encountered by test users was in orienting themselves in relation to physical space and the map displayed by BKFNDr. In three of the five tests, the user had to stop for a few moments to look around the 3rd Floor North wing and back at the map to situate themselves. In two of the five cases, this problem was compounded by a delay in the appearance of the blue dot (that identifies the location of the user). In all of the tests, the blue dot tended to lag slightly behind the location of the test user, which could be somewhat disorienting to an individual trying to get his bearings in the library. These are problems that the WEmTech will address in upcoming modifications of the BKFNDr app.

Another difficulty test users encountered was in attempting to read the shelf numbers found in the maps. (The shelf numbers are used primarily by library staff for shelf-maintenance functions but are potentially helpful for library users.) Three test users attempted to zoom in to the map to read the shelf numbers by spreading their fingers on the screen, but BKFNDr does not allow zooming. The members of WEmTech will need to consider removing the shelf numbers from the maps altogether, enlarging them to make them more easily legible, or enabling users to zoom in so that they can actually read them.

Evaluation of the BKFNDr app will align with the recommendations made by Neilsen (2018) whereby the initial discovery of usability challenges will be addressed until resolved. An iterative approach to testing is also in place so that as new features are added, the testing can focus on these features accordingly (Neilsen, 2018).

![Figure 6](https://journal.code4lib.org/media/issue42/dent/6.png)

**Figure 6.** Common bookshelf/beacon configuration

![Figure 7](https://journal.code4lib.org/media/issue42/dent/7.png)

**Figure 7.** Location of deployed beacons and call number ranges ([enlarge](https://journal.code4lib.org/media/issue42/dent/7_large.png))

### Next Steps & Future Direction

BKFNDr is currently available in the iTunes app store, and completion of the beacon installation at both the Queens and Staten Island Libraries is on target for September 2018. After the hardware installation is complete and the software is updated accordingly, additional user testing will be conducted. The app has not yet been promoted outside of the Libraries, but the WEmTech team has created a marketing campaign consisting of social media, print, and web-based strategies that will be launched once user testing and final updates conclude. The BKFNDr app has also been awarded a Campus Technology Impact Award for 2018 ([https://campustechnology.com/Articles/2018/08/07/A-Mobile-Guide-to-Library-Resources.aspx?Page=1](https://campustechnology.com/Articles/2018/08/07/A-Mobile-Guide-to-Library-Resources.aspx?Page=1)) in the Student Systems & Services category – this will help in the promotion of the app. The novelty of the BKFNDr app may be attractive to students, but novelty is fleeting – especially when it comes to mobile apps. To that end, WEmTech intends to promote the BKFNDr app as part of a larger suite of productivity apps designed to motivate students to use the Libraries. These apps include InQuery (a research support app, currently available in iTunes and Google Play stores) and the “St. John’s University Libraries” app – a general library app that allows users to search the catalog and check out books using their mobile devices. As highlighted by our user testing, there is room for improvement, most notably refinement of the location indicator, and better initial location orientation for the user (possibly by adding a compass or directional arrow on the screen). These challenges are being addressed for the next update of the mobile app.

## Conclusion

The BKFNDr app is one of the few applications that provides users the opportunity to find materials on library bookshelves using their mobile devices. The app supports students who know what they are looking for and want a quick way to locate the items on the shelves, as well as those who want to browse. Facilitating serendipity in an important outcome. Students who browse library collections and find materials that are useful are more likely to return. The simple design of the app (which consists of just two screens) hides a sophisticated configuration that makes use of one of the more accessible wayfinding technologies on the market – beacons.

## References

AngularJS — Superheroic JavaScript MVW Framework. \[accessed 2018 Apr 13\]. [https://angularjs.org/](https://angularjs.org/).

Apple, Inc. 2014. Getting Started with iBeacon. \[accessed 2014 Jun 2\]. [developer.apple.com/ibeacon](http://developer.apple.com/ibeacon).

Babich, N. A Comprehensive Guide to Mobile App Design. \[accessed 2018 Aug 7\]. [https://www.smashingmagazine.com/2018/02/comprehensive-guide-to-mobile-app-design/](https://www.smashingmagazine.com/2018/02/comprehensive-guide-to-mobile-app-design/).

Babu, Pavithra. 2016 Apr 7. Top 12 Industries that Beacons will Disrupt in 2016. blog.beaconstac.com. \[accessed 2018 Apr 13\]. [https://blog.beaconstac.com/2016/04/top-12-industries-that-beacons-will-disrupt-in-2016/](https://blog.beaconstac.com/2016/04/top-12-industries-that-beacons-will-disrupt-in-2016/).

Bastien, J.M.C. 2010. Usability testing: A review of some methodological and technical aspects of the method. International Journal of Medical Informatics 79(4): 18-23.

Borrego-Jaraba F, García GC, Ruiz IL, Gómez-Nieto MÁ. 2013. An NFC based context-aware solution for access to bibliographic sources in university environments. Journal of Ambient Intelligence and Smart Environments 5:105–118.

Bradley J, Henshaw N, McVoy L, French A, Gilbertson K, Becksford L, Givens E. 2016 Apr 25. Creation of a library tour application for mobile equipment using iBeacon technology. \[accessed 2018 Apr 13\]. [https://vtechworks.lib.vt.edu/handle/10919/71832](https://vtechworks.lib.vt.edu/handle/10919/71832).

Chawathe SS. 2008. Beacon Placement for Indoor Localization using Bluetooth. In: 2008 11th International IEEE Conference on Intelligent Transportation Systems. p. 980–985.

Chen G, Xin Y, Chen N-S. 2017. Informal learning in science museum: development and evaluation of a mobile exhibit label system with iBeacon technology. Education Tech Research Dev 65:719–741. doi:10.1007/s11423-016-9506-x.

Chia WY. 2014 Apr. Mobile 3D Library Map: an innovative wayfinding tool for library users on the move. Library Hi Tech News:9–10. doi:10.1108/LHTN-03-2014-0017.

Chu H-C, Hwang G-J, Tseng JCR. 2010. An innovative approach for developing and employing electronic libraries to support context?aware ubiquitous learning. The Electronic Library 28:873–890. doi:10.1108/02640471011093552.

Dempsey K. 2016. Bluetooth Beacons Are Starting to Shine in Libraries. Computers in Libraries 36:28–31.

Dutta A, Palta A. 2014. Location-awareness based data dissemination for smart hospitals. In: 2014 International Conference on Medical Imaging, m-Health and Emerging Communication Systems (MedCom). p. 72–75.

Enis M. 2014 Nov 18. “Beacon” Technology Deployed by Two Library App Makers. Library Journal. \[accessed 2018 Apr 13\]. [https://lj.libraryjournal.com/2014/11/marketing/beacon-technology-deployed-by-two-library-app-makers/](https://lj.libraryjournal.com/2014/11/marketing/beacon-technology-deployed-by-two-library-app-makers/).

Enis M. 2015. Technology: Library App Makers Deploy Beacon Tech. Library Journal 140:20–20.

Fast Facts | St. John’s University. \[accessed 2018 Apr 13\]. [https://www.stjohns.edu/about/administrative-offices/provost/institutional-research/fast-facts](https://www.stjohns.edu/about/administrative-offices/provost/institutional-research/fast-facts).

Gallagher P. 2010 Jun 22. Map it @ WSU: Development of a Library Mapping System for Large Academic Libraries. Library Scholarly Publications.  
Getting Started with iBeacon.pdf. \[accessed 2018c Apr 13\]. [https://developer.apple.com/ibeacon/Getting-Started-with-iBeacon.pdf](https://developer.apple.com/ibeacon/Getting-Started-with-iBeacon.pdf).

Hahn J. 2011. Location-based recommendation services in library book stacks. Reference Services Review; Bradford 39:654–674. doi:http://dx.doi.org/10.1108/00907321111186677.

Hahn J, Morales A. 2011. Rapid Prototyping a Collections-based Mobile Wayfinding Application. Journal of Academic Librarianship 37:416–422. doi:10.1016/j.acalib.2011.06.001.

Hahn J, Zitron L. 2011. How First-Year Students Navigate the Stacks: Implications for Improving Wayfinding. Reference & User Services Quarterly 51:28–35.

Hocking C. 2014. The Beacon Experiments: Low-Energy Bluetooth Devices in Action. Shine Solutions Group. \[accessed 2018 Apr 13\]. [https://shinesolutions.com/2014/02/17/the-beacon-experiments-low-energy-bluetooth-devices-in-action/](https://shinesolutions.com/2014/02/17/the-beacon-experiments-low-energy-bluetooth-devices-in-action/).

Ionic. Build Amazing Native Apps and Progressive Web Apps with Ionic Framework and Angular. Ionic Framework. \[accessed 2018 Apr 13\]. [https://ionicframework.com/](https://ionicframework.com/).

Kajioka S, Mori T, Uchiya T, Takumi I, Matsuo H. 2014. Experiment of indoor position presumption based on RSSI of Bluetooth LE beacon. In: 2014 IEEE 3rd Global Conference on Consumer Electronics (GCCE). p. 337–339.

Moody M. 2015. Analysis of Promising Beacon Technology for Consumers. Elon Journal of Undergraduate Research in Communications 6. \[accessed 2018 Apr 13\]. [http://www.inquiriesjournal.com/articles/1136/analysis-of-promising-beacon-technology-for-consumers](http://www.inquiriesjournal.com/articles/1136/analysis-of-promising-beacon-technology-for-consumers).

Nielsen, Jakob. Why You Need Only Test with 5 Users. Nielsen Norman Group. \[Accessed 2018 Aug 7\]. [https://www.nngroup.com/articles/why-you-only-need-to-test-with-5-users/](https://www.nngroup.com/articles/why-you-only-need-to-test-with-5-users/).

Nielsen, Jakob. How Many Test Users in a Usability Study? Nielsen Norman Group. \[accessed 2018 Aug 6\]. [https://www.nngroup.com/articles/how-many-test-users/](https://www.nngroup.com/articles/how-many-test-users/).

Newman N. 2014. Apple iBeacon technology briefing. Journal of Direct, Data and Digital Marketing Practice; Basingstoke 15:222–225. doi:http://dx.doi.org/10.1057/dddmp.2014.7.

Rodriguez-Sanchez M c., Martinez-Romo J. 2017. GAWA – Manager for accessibility Wayfinding apps. International Journal of Information Management 37:505–519. doi:10.1016/j.ijinfomgt.2017.05.011.

Spina C. 2015 May 21. Keeping Up With… Beacons. Association of College & Research Libraries (ACRL). \[accessed 2018 Apr 13\]. [http://www.ala.org/acrl/publications/keeping\_up\_with/beacons](http://www.ala.org/acrl/publications/keeping_up_with/beacons).

Sturari M, Liciotti D, Pierdicca R, Frontoni E, Mancini A, Contigiani M, Zingaretti P. 2016b. Robust and affordable retail customer profiling by vision and radio beacon sensor fusion. Pattern Recognition Letters 81:30–40. doi:10.1016/j.patrec.2016.02.010.

The University of Oklahoma Libraries Launches NavApp to Provide Mobile Indoor Navigation and Content for More Than One Million Visits Annually 2015 | Aruba Networks Newsroom. \[accessed 2018 Apr 13\]. [http://news.arubanetworks.com/press-release/university-oklahoma-libraries-launches-navapp-provide-mobile-indoor-navigation-and-con](http://news.arubanetworks.com/press-release/university-oklahoma-libraries-launches-navapp-provide-mobile-indoor-navigation-and-con).

Zou H, Jiang H, Luo Y, Zhu J, Lu X, Xie L. 2016. BlueDetect: An iBeacon-Enabled Scheme for Accurate and Energy-Efficient Indoor-Outdoor Detection and Seamless Location-Based Service. Sensors 16:268. doi:10.3390/s16020268.

## Acknowledgments

The authors wish to thank Anthony Todman, Alyse Hennig, and Judy Bland from the St. John’s University Libraries and Matt Cook, Emerging Technologies Librarian, University of Oklahoma Libraries for their support on this project.

## Author Biographies

Valeda Dent, Ph.D. is Dean and Professor, University Libraries at St. John’s University in New York. Dr. Dent has created online and mobile learning tools at Long Island University, Rutgers University, and Hunter College, and collaborated with Kiichi Takeuchi on the development of several library-based mobile apps including ResearchPlus™, InQuery, and BKFNDr.

Kiichi Takeuchi is a Senior Web Application Database Developer at Long Island University (LIU) in New York where he also serves as an Adjunct Professor. Takeuchi is also the Chief Technology Officer for ObjectGraph, a company that focuses on mobile and web application development. Takeuchi has created more than 140 mobile apps, including many that employ geospatial technology. Takeuchi works closely with academic libraries and has created numerous mobile library apps including Research Plus™ and InQuery – the only mobile apps designed for academic library environments around information literacy standards. Both apps are available in both iOS and Android stores.

Benjamin Turner is Associate Professor, University Libraries at St. John’s University in New York. He holds an M.L.I.S. from The University of British Columbia and an M.A. from Hunter College, CUNY. His research interests include information literacy, library assessment and user experience. Presently serves as Assessment Librarian for Instruction and Collections at St. John’s University Libraries. He has previously published in The Global Librarian(2013), and Information Technology and Libraries (2015).

Heather Ball is the Student Success Librarian and Assistant Professor at St. John’s University. She holds an MLS with dual certificate in Preservation and Archives, as well as an MLitt and Bachelor’s in Medieval Studies. She sits on University committees, and has been invited to present her research at several conferences this year. Her research interests include qualitative/quantitative data analysis, assessment measures, information literacy instruction, digitization and encoding of historical manuscripts, and twelfth-century Britain.

Caroline Fuchs is Associate Dean and Learning Design Librarian at St. John’s University. She holds an MLS, an M.A. in English and an M.A. in history. She is a Senior Fellow at the Vincentian Center for Church and Society, and is a member of the Web and Emerging Technologies team. She teaches courses in the Division of Library and Information Science, and serves on the Board of Directors for Association of College and Research Libraries.

Ann Jusino is an Associate Professor of the St. John’s University Libraries where she has served as the Systems Administrator for the Koha Integrated Library System since 2010. She is actively involved with many emerging technologies projects, including the development of the libraries’ mobile apps and website redesign. Jusino is a long-standing member of the WALDO Library Consortium, serving as Secretary of the WALDO Executive Board for the last 5 years.

Shilpa Karnik is the Associate Director of Emerging Technologies in St. John’s University Libraries in New York. She holds an M.L.S and a B.S. in Computer Science and Mathematics. A member of the Libraries’ Web and Emerging Technologies committee, Karnik plays a key role in exploring and leveraging emerging technologies in the mobile environment. She likes to be challenged with the complexity and dynamism of connections between users and technology based systems.
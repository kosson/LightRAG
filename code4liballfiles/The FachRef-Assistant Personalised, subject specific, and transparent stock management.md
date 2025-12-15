---
title: "The FachRef-Assistant: Personalised, subject specific, and transparent stock management"
source: "https://journal.code4lib.org/articles/12660"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-07-18
created: 2025-01-10
description: "We present in this paper a personalized web application for the weeding of printed resources: the FachRef-Assistant. It offers an extensive range of tools for evidence based stock management, based on the thorough analysis of usage statistics. Special attention is paid to the criteria individualization, transparency of the parameters used, and generic functions. Currently, it [...]"
tags:
  - "clippings"
---
# The FachRef-Assistant: Personalised, subject specific, and transparent stock management

Eike T. Spielberg, Frank Lützenkirchen

We present in this paper a personalized web application for the weeding of printed resources: the FachRef-Assistant. It offers an extensive range of tools for evidence based stock management, based on the thorough analysis of usage statistics. Special attention is paid to the criteria individualization, transparency of the parameters used, and generic functions. Currently, it is designed to work with the Aleph-System from ExLibris, but efforts were spent to keep the application as generic as possible. For example, all procedures specific to the local library system have been collected in one Java package. The inclusion of library specific properties such as collections and systematics has been designed to be highly generic as well by mapping the individual entries onto an in-memory database. Hence simple adaption of the package and the mappings would render the FachRef-Assistant compatible to other library systems.

The personalization of the application allows for the inclusion of subject specific usage properties as well as of variations between different collections within one subject area. The parameter sets used to analyse the stock and to prepare weeding and purchase proposal lists are included in the output XML-files to facilitate a high degree of transparency, objectivity and reproducibility.

## Introduction

Place gets rare. More and more libraries are confronted with this problem. In their desire to offer more and better equipped working space to students and scientists, they need to evaluate their stock and make room for high level desk space. Weeding is a magic key to achieve this goal (Martin et al. 2013). Due to their size, textbook collections are highly promising candidates for gaining space. At a large University as Essen-Duisburg with more than 40,000 students, some of the titles are 100 or even more than 200 items strong. But how to proceed and how to quickly identify those items which give rise to the most extensive gain in room while resulting in the smallest disturbance and problems possible for the users?

Only by a thorough evaluation of the usage in combination with the subject-specific judgement of the subject librarian on which titles are useful (even if 15 years old) and which are not, can this question be answered (Cottrell 2013; Raphael 2013). While the second part of the question is difficult to replace by automated routines, the first one can be. The main concern is basic data of sufficient quality. These data can be extracted from the library system (Aleph (ExLibris \[accessed 2017\]) from ExLibris (ExLibris \[accessed 2017\]) in our case). But even if the data are of sufficient quality and are evaluated by automated routines, an interpretation of the results is often difficult for table based information. A clear and understandable visualization allows the user to grab the necessary information quickly (Finch and Flenner 2016). Hence the representation of loans, requests, and stock plays a key role.

For several years, a tool called “Ausleihprotokoll” (loan protocol) has been used at the University Duisburg-Essen, written by one of the authors. This web application gives a general overview of the editions and the items present at the library and visualises the temporal evolution of loans and requests in a graphical chart. However, the temporal evolution of the stock was not included. Some time had to be spent to acquire this part of the information from tables and to compare it to the loans depicted in the chart. Two types of information representation (graphical and tabular) had to be combined, resulting in additional time for information collection and making the decision, if and how many items can be withdrawn. Even if it takes only a few seconds for scrolling and gathering the stock information, in the run of analysing hundreds of titles this can add up to a considerable amount of time. In addition, to apply automated analysis these data have to be harmonized, so that the routines can relate the loans to the actual stock at a given time.

A project at the University of Applied Sciences Cologne extracted the stock data from the item data and included them in the graphical representation. In addition, a first routine to analyse a single title had been developed (Eike Spielberg \[accessed 2017\]). In this paper, we show how this procedure can be extended to whole stock ranges and how personalized parameters are used to calculate subject-specific weeding proposals \[[1](https://journal.code4lib.org/articles/#ref1)\].

## Our Approach

### Usage statistics for one title

Before expanding to larger stock areas, we explain how the usage statistics for a single title are calculated. Given the shelfmark of a title, the corresponding editions are collected from the library system. For each edition, the available items are collected as well as the events (loans and request) for each item. As stated above, these have been displayed in the older version of our tool.

A subsequent step was added, calculating similar events from the item information: the date of inventory is used to define an accession event, the date of removing the item as a withdrawal event. We obtain three series of events, in which each series comprises of a start and an end event: loan/return, request/hold and accession/withdrawal. If we look at the temporal evolution of one of these series (for example the loans), a starting event (loan) increases the corresponding counter (number of items simultaneously loaned) while an end event (return) decreases the counter. The three series provide all data necessary for an in-depth analysis.

![Screenshot 1: The upper part of the loan protocol (Protokoll) for an item from a textbook collection. The query-form (“Abfrage”) is followed by the chart depicting the loans (red), the requests (green) and the stock (blue) for a single shelfmark (= edition, “Auflage”).](https://journal.code4lib.org/media/issue37/spielberg2/image2.png)  
**Screenshot 1.**  
The upper part of the loan protocol (Protokoll) for an item from a textbook collection. The query-form (“Abfrage”) is followed by the chart depicting the loans (red), the requests (green) and the stock (blue) for a single shelfmark (= edition, “Auflage”).

The inclusion of the stock data into the chart of loan/request data already provides a significantly easier and accurate overview over the principal usage characteristics (see Screenshot 1)\[[2](https://journal.code4lib.org/articles/#ref2)\]. From this diagram alone, the trends in usage, the relation of loan and stock items and the adequacy of the current stock is easily obtained. As the estimation of items for weeding is usually governed by rather clear and obvious guidelines – How many books have been maximally loaned at the same time, how many should we keep as reserve? – it can be calculated automatically. But how exactly can this be done?

### Relating usage and stock – the weeding potential

First, we need to define a time range to be looked at, for example, the last five years. In this time range the absolute maximum number of simultaneous loans is extracted and compared to the stock present today. The difference between these two numbers represents something, which might be called a “weeding potential”. It represents the number of unused items, resting on the shelf when the maximum number of items has been loaned. In a rather aggressive approach, all these items could be selected for withdrawal. However, one should take precautions for the case that items might get damaged or lost.

To account for this, every librarian would keep some items as a kind of security reserve. In the FachRef-Assistant a two-step approach is applied. Firstly, the weeding potential is corrected for a static reserve (for example three items or 20% of the stock). Secondly, a variable reserve is applied to account for the usage of items (items that are used more regularly have a higher probability to get damaged or lost). For this reason, the ratio between the mean and maximum relative loan is calculated in the given time range. The mean relative loan is calculated by summing up all days the items were loaned and dividing this value by the sum of days the items were in stock. The maximum relative loan is calculated as the maximum fraction of loaned items over items in stock within the time range. A high ratio of these two values indicates a high usage of the individual items, thus making a future replacement more likely.

![Analysis page showing statistical metrics (“Analyse”) and a chart depicting the loans of a single Edition with respect to different user groups (“Ausleihe nach Gruppen”). The table depicts the mean relative loan (“Mittlere Ausleihe”), the maximal relative loan (“Maximale Ausleihe”), the maximal number of items simultaneously loaned (“Maximale Ausleihe absolut”), the actual stock (“Aktueller Bestand”), the calculated weeding proposal (“Vorschlag zur Aussonderung”) and the shelfmarks of the items found (“Signaturen”). The time range for the analysis can be adjusted via the input field below (“Zeitraum ändern”). The chart depicts the distribution of the relative loan with respect to four library user groups: university staff (“Interne Ausleihen”), students (“Studentische Ausleihen”), people who are not member of the university (“Externe Ausleihen”) and other (“Andere Ausleihen”).](https://journal.code4lib.org/media/issue37/spielberg2/image4.png)  
**Screenshot 2.**  
Analysis page showing statistical metrics (“Analyse”) and a chart depicting the loans of a single Edition with respect to different user groups (“Ausleihe nach Gruppen”). The table depicts the mean relative loan (“Mittlere Ausleihe”), the maximal relative loan (“Maximale Ausleihe”), the maximal number of items simultaneously loaned (“Maximale Ausleihe absolut”), the actual stock (“Aktueller Bestand”), the calculated weeding proposal (“Vorschlag zur Aussonderung”) and the shelfmarks of the items found (“Signaturen”). The time range for the analysis can be adjusted via the input field below (“Zeitraum ändern”). The chart depicts the distribution of the relative loan with respect to four library user groups: university staff (“Interne Ausleihen”), students (“Studentische Ausleihen”), people who are not member of the university (“Externe Ausleihen”) and other (“Andere Ausleihen”).

The size of the variable reserve is calculated by multiplying a user-defined maximum reserve (e.g. 40 % or 10 items) with the ratio of the mean and maximum relative loan. Therefore, a higher ratio results in a larger reserve of items kept to avoid unnecessary costs.

Using only three parameters – time range, static reserve and variable reserve – weeding proposals can be calculated, which account for many effects in a way very similar to the decisions a librarian makes subconsciously. The results of such an analysis is displayed together with further information about the composition (user groups) in a separate analysis page, accessible from the loan protocol (see Screenshot 2).

However, the actual values of these parameters may vary strongly from subject to subject. For titles with high, but short-lived relevance (for example genetics or computer science), short time periods might be sufficient to estimate the use in the future. For other subjects such as humanities, the time range to be looked at needs to be much longer. In the case of natural sciences with a very rigid course of lectures, the general textbooks are often required every year at the same time. For lecture courses in German literature, the subject of a seminar might vary from time to time, giving rise to high loans in a series of titles during one semester and with longer periods of neglectable loans.

To account for these subject specific problems, the FachRef-Assistant allows the definition of profiles, a set of parameters used for individual stock ranges. Following this approach, the stock in humanities can be analysed with a much longer time range than the stock in chemistry or computer science. For the sake of clarity and to not overload the list of profiles, a personalization option is included, thus allowing each subject librarian to define their own set of parameters for their subjects.

### From one to many – the weeding and purchase recommendation lists

The analysis presented up to now can be performed only for a single title (but with several editions). For several years, lists were prepared at our library by querying the Aleph system for some criteria and then thoroughly testing each title. So we query the system with one program, prepare a list and manually test each title by querying the system again with another application. But wouldn’t it be much easier to avoid the intermediate list? To query the system, perform the described analysis right away, and prepare a list only of those titles which have a significant weeding potential?

To this end, we implemented a section-based analysis within the personalized part of our application. After login, users with the role subject librarian can switch to the profiles module. Here, an individual set of parameters can be defined for each subject area (see Screenshot 3). The definition page consists of three major parts: range parameters, loan analysis parameters, and request analysis parameters.

![Screenshot 3: Definition of profile for a certain subject. In the first block (“Angaben zum Bereich”) the subject, collections and media are defined. The second block (“Parameter zur Ausleihanalyse”) allows for the input of the parameters used to calculate the weeding potential. The last block (“Parameter zur Vormerk-Analyse”) offers parameters used to calculate purchase recommendations based on the requests put on the individual items.](https://journal.code4lib.org/media/issue37/spielberg2/image3.png)  
**Screenshot 3.**  
Definition of profile for a certain subject. In the first block (“Angaben zum Bereich”) the subject, collections and media are defined. The second block (“Parameter zur Ausleihanalyse”) allows for the input of the parameters used to calculate the weeding potential. The last block (“Parameter zur Vormerk-Analyse”) offers parameters used to calculate purchase recommendations based on the requests put on the individual items.

**Range parameters:** At the University Duisburg-Essen, we use a three letter code in the shelfmark as subject categorization. Each subject has a certain range (e.g. biology: VNA-VTZ). In a dropdown menu, the main subject categories can be selected, setting the ranges automatically. In addition, one can define certain ranges or lists of shelfmarks or combinations of both to restrict the analysis to a certain range. Afterwards, two fields allow for a restriction to certain collections or media.

**Loan analysis parameters:** In the next part, the time range and the two reserves mentioned above are defined as well as a minimum time range; media have to be in stock before they might be selected for weeding. For the display of lists, the minimum value of the weeding proposal can be defined as well. In addition, an optional email address can be entered, to which a bcc of a weeding decision is sent for additional archiving purposes (a copy of the final list is always stored as XML file on the server).

**Request analysis parameters:** The last part defines two parameters used to analyse the requests and to make recommendations for extending the stock. Again, a time range can be defined and a minimum number of days that people had to wait for their desired item. This choice of the number of days corresponds to the idea of ascertaining a certain service level (“Our user does not have to wait longer than 10 days to get his book”).

![Screenshot 4: List of Profiles (“Profile“) with parameter sets to analyse specific parts of the stock. The two green buttons in each row lead to the weeding (“Aussonderung”) and purchase proposal list (“Erwerbung”), the blue button with the star starts the analysis, the yellow allows changing the parameters of a profile and the red one deletes the corresponding profile.](https://journal.code4lib.org/media/issue37/spielberg2/image6.png)  
**Screenshot 4.**  
List of Profiles (“Profile“) with parameter sets to analyse specific parts of the stock. The two green buttons in each row lead to the weeding (“Aussonderung”) and purchase proposal list (“Erwerbung”), the blue button with the star starts the analysis, the yellow allows changing the parameters of a profile and the red one deletes the corresponding profile.

After a profile has been defined, the analysis can be started from the blue button in the profile overview page (see Screenshot 4). After completion, two lists can be accessed: a list of weeding proposals and one of purchase recommendation. An example of such a list is depicted in Screenshot 5. Using JavaScript, these lists can quickly be filtered, searched and ordered. The list includes the shelfmark (showing bibliographic details upon hover-over), the collection information, a link to the loan protocol (see above) the trend of the maximum loan over the last ten years, the actual stock, the absolute maximum loan and the weeding recommendation. It also contains a column for comments, which can be used later to give additional information to the give commentaries for the colleagues who perform the actual withdrawal.

![Screenshot 5: List of weeding proposals (“Aussonderungsvorschläge”). The columns depict the shelfmark (“Signatur”), the collection information (“Standort”), a link to the loan protocol (“Ausleihprotokoll”), the trend of the maximum loan over the last ten years (“Trend/Jahr”), the actual stock (“Bestand”), the absolute maximum loan (“Maximale Ausleihe”), a comment (“Kommentar”) and the weeding proposal (“Vorschlag”).](https://journal.code4lib.org/media/issue37/spielberg2/image5.png)  
**Screenshot 5.**  
List of weeding proposals (“Aussonderungsvorschläge”). The columns depict the shelfmark (“Signatur”), the collection information (“Standort”), a link to the loan protocol (“Ausleihprotokoll”), the trend of the maximum loan over the last ten years (“Trend/Jahr”), the actual stock (“Bestand”), the absolute maximum loan (“Maximale Ausleihe”), a comment (“Kommentar”) and the weeding proposal (“Vorschlag”).

The last column contains buttons to put these titles on a so-called blacklist. Titles that shall be protected from weeding (even if hardly used) can be put on this list in order to prevent any further analysis. This might be the case for special collections, for books written by university staff, media used in the library only and so on. The two buttons offer two ways to protect a title: the green one uses a standard entry with a time range set in the personal settings and the blue one allows the staff to set the time period manually and include comments.

After working through the list of proposals, saving preservable items to the blacklist and adjusting the numbers of items to be withdrawn, a click on the “Aussondern” (withdraw) button at the very bottom of the page generates an email in the user’s local mail program, which can be sent to the members of staff responsible for performing the withdrawal process itself. In this email the shelfmarks, the number of items to be withdrawn and the comments added are listed in plain text.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32 | `<``analysis` `key``=``"123456789"` `trend``=``"-0,350"` `shelfmark``=``"ABC123(2)"``>`  `<``mab``>`  `Weeding in Libraries ...`  `</``mab``>`  `<``meanRelativeLoan``> 0.349613 </``meanRelativeLoan``>`  `<``maxRelativeLoan``> 0.966667 </``maxRelativeLoan``>`  `<``maxLoansAbs``> 31 </``maxLoansAbs``>`  `<``lastStock``> 43 </``lastStock``>`  `<``proposedDeletion``> 12</``proposedDeletion``>`  `<``finalDeletion``>12</``finalDeletion``>`  `<``comment` `/>`  `<``totalDaysRequest``>0</``totalDaysRequest``>`  `<``numberRequests``>0</``numberRequests``>`  `<``maxNumberRequest``>0</``maxNumberRequest``>`  `<``proposedPurchase``>0</``proposedPurchase``>`  `</``analysis``>`  `...`  `<``stockControlProperties``>`  `<``stockControl``>43_1484895218825</``stockControl``>`  `<``collections``>E33 E43</``collections``>`  `<``materials``>BOOK</``materials``>`  `<``subjectID``>43</``subjectID``>`  `<``systemCode` `/>`  `<``minimumYears``>5</``minimumYears``>`  `<``yearsToAverage``>10</``yearsToAverage``>`  `<``groupedAnalysis``>false</``groupedAnalysis``>`  `<``staticBuffer``>0.0</``staticBuffer``>`  `<``variableBuffer``>0.0</``variableBuffer``>`  `<``threshold``>0</``threshold``>`  `<``yearsOfRequests``>2</``yearsOfRequests``>`  `<``minimumDaysOfRequest``>5</``minimumDaysOfRequest``>`  `</``stockControlProperties``>` |
| --- | --- |

**Listing 1.**  
Example – part of the resulting xml-file depicting an imaginary title (analysis-node) and the parameters used to analyse this book (stockcontrolproperties-node).

### Transparency and persistence – using XML-files.

With the generation of this email, the list is archived on the server as well. To be as transparent as possible and to allow for a future check-up of performed weeding, the lists are stored as blank XML-files in a separate archive-folder on the server used to run the application disk. Not only the items to be withdrawn (`finalDeletion`\-node) are included, but also the proposed number of items (`proposedDeletion`\-node) and the parameters set in the profile (`stockControlProperties`\-node, see XML 1).

This way, the calculated proposals stay linked to the parameters used to determine the proposed actions. Comparing the differences between the proposed number and the final number of items might be used to automatically optimize the chosen parameters. This way a kind of learning weeding agent can be thought of, using machine learning techniques to be as close as possible to the user generated weeding lists.

### Adoption by others – the use of generic mechanisms

Currently, the application works only with the ExLibris (ExLibris \[accessed 2017\]) integrated library system Aleph (ExLibris \[accessed 2017\]). In addition, for the use of the profiles a lot of library specific data have to be entered, such as collections, the classification used and so on. For these reasons, a transfer of the application to other libraries might look kind of difficult.

Therefore, from the very beginning, modules and methods were designed to be as generic as possible. For example, the list of shelfmarks is generated from an XML-file of the used classification and is stored within an in-memory database. In principle, this could easily be adopted to allow for the use of other systematics or to include other types of sources (for example comma-separated values). Only the import of the systematics needs to be changed; the internal use of these criteria depends only on the entries stored in the in-memory database and would therefore work also with other data. Similar arguments hold true for the use of collections. To manage these a web-frontend is included, allowing the user to define certain ranges. At this point, some options are still hard-coded to the XSL-files which render the web-frontend page, but this could be easily replaced by different mechanisms or just by editing the web-page.

The connection to the local database is done via a set of Java classes (so-called getters), all located within one package. By replacing the access information, the expressions and mechanisms within these very few classes, an adjustment to other systems could be easily achieved. We therefore believe, that adaptation of this application to other systems need several things to be done, but compared to the overall size of the project, this should be possible and relatively easy. We also started to restructure the application in order to build an independent microservice to access the library system. This approach shall result in a kind of abstract data provider layer. This layer can be adapted for each system without changing the rest of the application.

## Outlook and future work

The FachRef-Assistant has proven its value in our daily life at the University Library Duisburg-Essen. The “Ausleihprotokoll” is a common tool to evaluate the usage of single titles and the preparation of lists with the help of the FachRef-Assistant has been done in many cases. However, we still see a lot of work to be done. One of the main tasks for the immediate future is the adaptation to other library systems, especially to next-generation systems like Alma (ExLibris \[accessed 2017\]). Three major challenges exist:

- Adopt the getter-classes to other databases / APIs
- Include other classifications and collections
- Adopt the mechanisms defining the local settings to allow for an easier setup and transfer.

In addition, we would like to separate the application into a set of smaller modules in order to allow for a more agile development. This mainly includes the separation into RESTful backend services and a Web-Frontend. This would also make the localization much easier.

## Conclusions

We present in this paper the FachRef-Assistant, a personalized web application for the weeding of printed (and online) resources. It offers an extensive range of tools for evidence based stock management, based on the analysis of usage statistics. The personalization allows for the inclusion of subject specific usage properties as well as the variations between different collections within one subject area. The parameter sets used to analyse the stock and to prepare weeding and purchase proposal lists are included in the output XML-files to facilitate a high degree of transparency, objectivity and reproducibility. The application has been designed to work with the Aleph-System from ExLibris, but efforts were spent to keep the application as generic as possible.

Thus, the FachRef-Assistant supports the library staff by aggregation of objective criteria to achieve higher work efficiency, setting free additional financial and time resources that may be used for other tasks and challenges.

## Acknowledgement

The authors thank the University Library Duisburg-Essen for the support for the project. Special thanks goes to Jutta Kleinfeld, Nils Verheyen and Paul Rochowski for helpful discussions about technical details. For testing and extensive feedback, we would like to thank Christina Kläre, Rosemarie Kosche and Felix Schmidt.

## Technical Details

The web application is JAVA/XML based. The MyCoRe (MyCoRe-Community \[accessed 2017\]) framework was used to design the main servlet handling the requests. Connection to the library system is established using Oracle Java Database Connectivity (JDBC) (Oracle \[accessed 2017\]). Upon calling Java Web Servlets with specific URL-Parameters the data are collected and evaluated according to the user-specified parameters. The results are collected in an XML-document, which is rendered into an HTML-page via XSL-transformation (W3C \[accessed 2017\]). To allow user role specific views and option, authentication and authorization was performed using the Apache Shiro framework (The Apache Software Foundation \[accessed 2017\]). The general design of the web pages is Bootstrap based (@mdo and @fat \[accessed 2017\]), the charts are generated by the Highcharts-package (Highcharts \[accessed 2017\]) and D3.js (Bostock \[accessed 2017\]). The source code is available via GitHub ([https://github.com/ETspielberg/ub-statistics](https://github.com/ETspielberg/ub-statistics)), documentation (JavaDoc) under [https://etspielberg.github.io/ub-statistics/](https://etspielberg.github.io/ub-statistics/).

## About the authors

Eike T. Spielberg (ORCID: [0000-0002-3333-5814](http://orcid.org/0000-0002-3333-5814)) studied Chemistry at the Friedrich-Schiller-Unviersity in Jena and now works as subject librarian and scientific co-worker at the University Library Duisburg-Essen in Germany since 2015. He develops tools for automation of library workflows and for new services within the context of bibliometrics.

Frank Lützenkirchen (ORCID: [0000-0001-5065-6970](http://orcid.org/0000-0001-5065-6970)) studied Business Informatics at the University of Essen. He is active member and co-founder of the MyCore-community and head of the department “Digital Library” at the University Library Duisburg-Essen.

## Notes

[\[1\]](https://journal.code4lib.org/articles/#ref1) An extensive description (in German) of this application has also been submitted as Master thesis at the University of Applied Sciences Cologne and will soon be published on the local document repository ([https://epb.bibl.th-koeln.de/home](https://epb.bibl.th-koeln.de/home)). ETS acknowledges the support by his supervisors Dr. Peter Kostädt and Prof. Dr. Achim Oßwald.

[\[2\]](https://journal.code4lib.org/articles/#ref2) As the application was written at a German university the web pages depicted in the screenshots are all in German. A localization has not been performed yet. In captions and references throughout the text, the German expressions found in the screenshots are highlighted in quotation marks.

## References

@mdo, @fat. \[accessed 2017 Jan 28\]. Bootstrap: The world’s most popular mobile-first and responsive front-end framework. [http://getbootstrap.com/](http://getbootstrap.com/).

Bostock M. \[accessed 2017 Jan 28\]. D3.js: Data Driven Documents. [https://d3js.org/](https://d3js.org/).

Cottrell TL. 2013. Weeding worries, part 1: Books. Bottom Line. 26(3):98–102. doi:10.1108/BL-06-2013-0015.

Eike Spielberg. \[accessed 2017 May 17\]. Aussonderungsassistent für Fachreferenten an wissenschaftlichen Bibliotheken. MALIS Projekte-Blog. [http://malisprojekte.web.th-koeln.de/wordpress/aussonderungsassistent-fuer-fachreferenten-an-wissenschaftlichen-bibliotheken/](http://malisprojekte.web.th-koeln.de/wordpress/aussonderungsassistent-fuer-fachreferenten-an-wissenschaftlichen-bibliotheken/).

ExLibris. \[accessed 2017 Jan 28\]. Aleph Integrated Library System. [http://www.exlibrisgroup.com/de/category/Aleph](http://www.exlibrisgroup.com/de/category/Aleph).

ExLibris. \[accessed 2017 Jan 28\]. ExLibris Alma. [http://www.exlibrispublications.com/alma/](http://www.exlibrispublications.com/alma/).

ExLibris. \[accessed 2017 Jan 28\]. The bridge to knowledge. [http://www.exlibrisgroup.com/de](http://www.exlibrisgroup.com/de).

Finch JL, Flenner AR. 2016. Using Data Visualization to Examine an Academic Library Collection. College & Research Libraries. 77(6):765–778. en. doi:10.5860/crl.77.6.765.

Highcharts. \[accessed 2017 Jan 28\]. Interactive JavaScript charts for your webpage. \[place unknown\]: \[publisher unknown\]. [http://www.highcharts.com/](http://www.highcharts.com/).

Martin J, Kamada H, Feeney M. 2013. A Systematic Plan for Managing Physical Collections at the University of Arizona Libraries. Collection Management. 38(3):226–242. doi:10.1080/01462679.2013.797376.

MyCoRe-Community. \[accessed 2017 Jan 19\]. MyCoRe: Das Framework zur Präsentation und Verwaltung digitaler Inhalte. de. [http://mycore.de/](http://mycore.de/).

Oracle. \[accessed 2017 Jan 19\]. Database JDBC Developer’s Guide. [https://docs.oracle.com/cd/E11882\_01/java.112/e16548/toc.htm](https://docs.oracle.com/cd/E11882_01/java.112/e16548/toc.htm).

Raphael L. 2013. Killing Sir Walter Scott: A Philosophical Exploration of Weeding. \[accessed 2017 Jan 23\]. In the Library with the Lead Pipe. [http://www.inthelibrarywiththeleadpipe.org/2013/killing-sir-walter-scott-a-philosophical-exploration-of-weeding/](http://www.inthelibrarywiththeleadpipe.org/2013/killing-sir-walter-scott-a-philosophical-exploration-of-weeding/).

The Apache Software Foundation. \[accessed 2017 Jan 19\]. Apache Shiro: Simple. Java. Security. [https://shiro.apache.org/](https://shiro.apache.org/).

W3C. \[accessed 2017 May 22\]. XSL Transformation (XSLT). [https://www.w3.org/TR/xslt](https://www.w3.org/TR/xslt).
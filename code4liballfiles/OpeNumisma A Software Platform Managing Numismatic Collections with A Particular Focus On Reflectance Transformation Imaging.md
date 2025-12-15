---
title: "OpeNumisma: A Software Platform Managing Numismatic Collections with A Particular Focus On Reflectance Transformation Imaging"
source: "https://journal.code4lib.org/articles/12627"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-07-18
created: 2025-01-10
description: "This paper describes OpeNumisma; a reusable web-based platform focused on digital numismatic collections. The platform provides an innovative merge of digital imaging and data management systems that offer great new opportunities for research and the dissemination of numismatic knowledge online. A unique feature of the platform is the application of Reflectance Transformation Imaging (RTI), a [...]"
tags:
  - "clippings"
---
# OpeNumisma: A Software Platform Managing Numismatic Collections with A Particular Focus On Reflectance Transformation Imaging
Avgoustinos Avgousti, Andriana Nikolaidou, Ropertos Georgiou

This paper describes OpeNumisma; a reusable web-based platform focused on digital numismatic collections. The platform provides an innovative merge of digital imaging and data management systems that offer great new opportunities for research and the dissemination of numismatic knowledge online. A unique feature of the platform is the application of Reflectance Transformation Imaging (RTI), a computational photographic method that offers tremendous image analysis and possibilities for numismatic research. This computational photography technique allows the user to observe on browser minor details, unseen with the naked eye just by holding the computer mouse rather than the actual object. The first successful implementation of OpeNumisma has been the creation of a digital library for the medieval coins from the collection of the Bank of Cyprus Cultural Foundation.

## Introduction

As the implementation of software application grew in the creation of numismatic digital collections, the need for better supporting applications grew correspondingly with a better provision of the digital libraries’ requirements. For the study on a range of objects such as numismatics, with delicate materiality and rich historical background, an application that can digitally reflect their illustrious nature is necessary. In response to this growing need a web-based platform “OpeNumisma” is being developed by the Cyprus Institute. The platform supports an advanced imaging technology, Reflectance Transformation Imaging (RTI) \[[1](https://journal.code4lib.org/articles/#ref1)\] that offers powerful new methods of documenting and studying numismatic cultural heritage information. RTI is a computational photography technique that enables the virtual examination of objects in front of a computer monitor and assists for visual analysis, conservation and documentation. Reflectance Transformation Imaging is shown to capture more complete documentation than traditional photographic methods and broadens the scientific research of a coin.

We intend to demonstrate how the addition of OpeNumisma can bring a feasible step forward to general-purpose service system numismatic digital libraries and overview its current features and future additions. The significant system performance formation and software architecture is analyzed by giving a coherent view of components, where the architectural elements meet all of the technical and operational requirements of the software. The presentation of the platform is based on the first successful implementation of OpeNumisma in the online coinage collection of the Bank of Cyprus Cultural Foundation, showing how the software successfully managed to accomplish its significant system performance.

## Numismatic software’s applications

A tremendous amount of digital projects are available to the public that provides online access to coins collection from different cultural institutions \[[2](https://journal.code4lib.org/articles/#ref2)\]. Many of the numismatic collections that are available online today are using tailor-made software developed for their specific needs or open source software applications. Particular examples using tailor-made applications are the *Roman Provincial Coinage Online* \[[3](https://journal.code4lib.org/articles/#ref3)\] ,the *Sylloge Nummorum Graecorum* \[[4](https://journal.code4lib.org/articles/#ref4)\] and Vatican Library: Catalogues-Coins and Medals \[[5](https://journal.code4lib.org/articles/#ref5)\]. On the other hand, the custom coded software gives endless possibilities to a project to create anything it can “imagine” but at a significant time and cost, without any open collaboration and more diverse scope of development perspectives. *OCRE: Online Coins of the Roman Empire* \[[6](https://journal.code4lib.org/articles/#ref6)\] is using the open source of Numishare \[[7](https://journal.code4lib.org/articles/#ref7)\] along with *Coinage of the Roman Republic Online* \[[8](https://journal.code4lib.org/articles/#ref8)\] and *Dar al-Kutub Collection of the Egyptian National Library* \[[9](https://journal.code4lib.org/articles/#ref9)\].

## OpeNumisma Background and Development

Working on the creation of the medieval numismatic digital library of Bank of Cyprus Cultural Foundation, the main aim was to develop a web-based platform. This platform had to be usable particularly for digital numismatic collections, in order to improve the context of the library. Working on different advanced technologies that could enrich the medieval numismatic digital library of Bank of Cyprus Cultural Foundation we developed the platform “OpeNumisma”. A few of the advanced technologies that OpeNumisma provides are Reflectance Transformation Imaging, embedded interactive maps, bibliographical reference, metadata, taxonomical terms, advanced search, facets, images search, XML export and more. For the development of OpeNumisma we selected Drupal 7, an open source content management framework (CMF) with a large community of developers and users. At that time, in late 2013, Drupal 8 was not quite ready for the development of such a project. Drupal 8 is newer and most probably will be supported longer and possibly with more features than Drupal 7. We are looking forward to releasing OpeNumisma in a Drupal 8 version when the framework is more stable and ready for supporting the complexity of a project like OpeNumisma.

## Study of coins through Reflectance Transformation Imaging (RTI)

The examination of artwork’s surfaces under tangential light was one of the main study techniques in the past. The illumination technique, called raking light, casts a strong light at an oblique angle, almost parallel to the surface of the object, the light intensifies in order to reveal and highlight information clearly. The created light and shadows give a greater understanding of the relief of the object by emphasizing any surface irregularities and deformations such as cracks, distortions, and material condition. However, nowadays Reflectance Transformation Imaging (RTI) is a unique computational photography method for examination, conservation documentation, and identification for coins. The advanced computational photography technique simulates all possible light angles within a virtual hemisphere atop the surface of the coin for effective study and analysis (Figure 1). This powerful imaging technique proved to be extremely important for archaeologists, conservators, and historians for the examination of a variety of artifacts. These imaging techniques can “re-animate” and penetrate surfaces in a manner that conventional photography and digital methods of acquisition such as 3D laser scanning cannot fully convey but instead complement \[[10](https://journal.code4lib.org/articles/#ref10)\]. In addition, these methods feature creative and reliable ways for material examination reproducing reality with minor computation demands for the end-user and it aims to provide easily accessible and straightforward practical methodologies for experts in the archaeological field as well the museum and the web \[[11](https://journal.code4lib.org/articles/#ref11)\]. By moving a mouse or any other pointing device, the user can control the direction of the light, zoom in and out and observe minor details (Figure 2).

![Medieval coins from the Bank of Cyprus Cultural Foundation collection](https://journal.code4lib.org/media/issue37/avgousti/image2.png)  
**Figure 1.**  
Medieval coins from the Bank of Cyprus Cultural Foundation collection

![Medieval coins from the Bank of Cyprus Cultural Foundation collection](https://journal.code4lib.org/media/issue37/avgousti/image4.png)  
**Figure 2.**  
Medieval coins from the Bank of Cyprus Cultural Foundation collection http://numismatics-medieval.dioptra.cyi.ac.cy

## RTI Data Acquisition

A custom-build RTI dome that produces polynomial texture map (PTM) files consists of a hemispherical dome with a hole at the apex, and thirty-six halogen lights embedded at randomly fixed intervals around the dome and controlled by a pre-scripted programmable microcontroller (Figure 3). An artifact is placed at the base of the dome, while a camera is positioned looking downward, focusing through the hole at the top, on the aforementioned object. Thirty-six photographic images are sequentially taken, each with a single light shining on the artifact, thus creating thirty-six images with different light angles. Then, the PTM algorithm synthesizes the data from these images to create a single image that can be examined on a PTM viewer with a “virtual spotlight”. The viewer allows the user to move the light angle intuitively in real time so that the combination of light and shadow representing the relief features of the object’s surface can be freely altered. RTI also permits the enhancement of the subject’s surface shape, color and luminance attributes, which extracts detail out of the surface that cannot be otherwise derived. RTI viewers are open source\[[12](https://journal.code4lib.org/articles/#ref12)\], however, RTI datasets can be accessed just through desktop applications. Consequently, the requirement to create an open-source Drupal RTI web platform that encapsulates coins and can be assessed and visualized through web applications has been achieved through the development of the OpeNumisma platform.

![The RTI dome of The Cyprus Institute](https://journal.code4lib.org/media/issue37/avgousti/image5.png)  
**Figure 3.**  
The RTI dome of The Cyprus Institute

## Reflectance Transformation Imaging Custom Drupal 7.x Module

The functionality of RTI on the platform of OpeNumisma is developed on a Custom Drupal Module. The module is based on WebRTIViewer from the visual computing laboratory- ISTI-CNR \[http://vcg.isti.cnr.it/rti/webviewer.php\]. WebRTIViewer uses HTML5-WebGL, can display high-resolution RTI images (PTM and HSH), and is available under the GNU General Public License version 3. OpeNumisma is already preconfigured with the RTI Drupal module, however having in mind organizations that have an existing Drupal 7 installation and wish to have only the RTI functionality, the RTI module can be downloaded and installed separately with only a couple of clicks as all Drupal contributed modules (Figure 4). The RTI Drupal 7 module is already helping some organizations like *“The Cultural Informatics Research Group”* at the University of Brighton.

The module can be downloaded from GitHub: [https://github.com/avgoustinos/Drupal-7-webgl\_viewer](https://github.com/avgoustinos/Drupal-7-webgl_viewer) future plans are to have the module on Drupal.org

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25 | `function` `webgl_viewer_field_formatter_info() {`  `$formatters` `= ``array``();`  `$webgl_viewer_settings` `= webgl_viewer_settings_info(``'default_value'``);`  `$default_settings` `= ``array``();`  `foreach` `(``$webgl_viewer_settings` `as` `$key` `=> ``$setting``) {`  `if` `(isset(``$setting``[``'fieldset'``])) {`  `$default_settings``[``$setting``[``'fieldset'``]][``$key``] = ``$setting``[``'default_value'``];`  `}`  `else` `{`  `$default_settings``[``$key``] = ``$setting``[``'default_value'``];`  `}`  `}`  `$formatters``[``'webgl_viewer'``] = ``array``(`  `'label'` `=> t(``'Web Viewer'``),`  `'field types'` `=> ``array``(``'image'``, ``'file'``),`  `'settings'` `=> ``$default_settings``,`  `);`  `return` `$formatters``;`  `}` |
| --- | --- |

**Listing 1.** Code example from the custom RTI Drupal module

## OpeNumisma Data Modeling and Content Types

For the profile of each coin that can be added to any digital library, OpeNumisma created a default data modelling and content type design. In collaboration with numismatics experts, we developed a list of controlled vocabularies. For each coin addition there is a complex set of fields with metadata elements related to numismatics such as the *material* of the coin, the *description* of the obverse and reverse surface of the coin, the location and many more (Figure 5). For example, a coin was minted in a specific location. The name of the place along with its geographical location is listed in a vocabulary called *Mint*. By assigning the term *Mint* with the name of the place to the image or RTI, the content is classified according to geo-location minted. With this process OpeNumisma can be used to implement this concept and create a retrieval tool. Using the example above the user is able to view all coins minted in a specific location. Moreover, the information can be viewed in a different medium, such as an interactive map where you can drill down to a specific location. The set of fields for a coin covers most of the standard needs and requirements for numismatics collections, and the administrator of the platform can easily extend the functionality by adding new fields based on their specific data and metadata requirements. All taxonomical terms and related data can be exported in XML format.

![OpeNumisma Coin Content Type](https://journal.code4lib.org/media/issue37/avgousti/image3.png)  
**Figure 4.**  
OpeNumisma Coin Content Type

## Information retrieval

For easy retrieval of information, OpeNumisma comes by default with some preconfigured views that provide a listing of data and nodes. For the display of the coins collection in a digital library we used the module Drupal View (Figure 6) that displays all the coins in a single table list. Users can easily browse the collection and filter their search by using the fields on the top of the page. By clicking on the image of each coin, the user is redirected to the RTI Web Viewer and has the opportunity to use the RTI on the coin in a separate window. Another way to search the database is by the interactive maps that display content based on a geographical location (Figure 7). The interactive map helps the user to discover coins by their location and also by the date they were minted. Moreover, clustering and drill down capabilities of the map make it user-friendly when it comes to numerous geo-points. To enhance performance and readability of data-heavy maps, the system clusters geo-points and allows displaying a large amount of data in a preformatted way.

![The visual collection of medieval coins from the Cypriot Medieval Coins: History and Culture Library](https://journal.code4lib.org/media/issue37/avgousti/image1.png)  
**Figure 5.**  
The visual collection of medieval coins from the Cypriot Medieval Coins: History and Culture Library

![The visual interactive map from the Cypriot Medieval Coins: History and Culture Library](https://journal.code4lib.org/media/issue37/avgousti/image6.png)  
**Figure 6.**  
The visual interactive map from the Cypriot Medieval Coins: History and Culture Library

## Linked open data: Semantic web

The Semantic Web is a set of standards and best practices for sharing data over the web that make it more machine-friendly, which makes computers more intelligent. The web pages are structured data in a way that computers can understand. According to the W3C, “The Semantic Web provides a common framework that allows data to be shared and reused across application, enterprise, and community boundaries”. OpeNumisma is based on CIDOC Conceptual Reference Model (CIDOC-CRM) ontology, which is designed to facilitate the exchange of heterogeneous cultural heritage information among cultural heritage institutions \[[12](https://journal.code4lib.org/articles/#ref12)\]. CIDOC-CRM appeared to be the perfect match for OpeNumisma; a selection of standard OpeNumisma fields was easily mapped to the most relevant CIDOC fields. However, in order to adapt and extend CIDOC-CRM for numismatic collections more work needs to be done.

## Extensible Markup Language XML

The system is able to generate and export XML data files for all the data and metadata stored in the system. Currently, systems administrators can export data in XML format; some of the advantages of using XML-encoded documents for the long-term archive are that XML is an open and well-established notation. XML is both human and machine-readable (Listing 2). Text format and internationalized characters are supported. With these characteristics, we can facilitate data migration and data transparency.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33 | `<?``xml` `version``=``"1.0"` `encoding``=``"UTF-8"``?>`  `<``coins``>`  `<``coin``>`  `<``title``>AR Gros. John II, 1432-1458</``title``>`  `<``coin-Image``>/sites/default/files/1995-07-05-OB.png</``coin-Image``>`  `<``Mint``>Nicosia</``Mint``>`  `<``Material``>AR</``Material``>`  `<``Axis``>07:00</``Axis``>`  `<``Diameter``>25 mm</``Diameter``>`  `<``Description``>Cross of Jerusalem. </``Description``>`  `<``Weight``>4.18 gm</``Weight``>`  `<``Denomination``>Gros</``Denomination``>`  `<``Inscription``>IOAn REX.D</``Inscription``>`  `<``Bibliography``>CLC 3,70-73,pl.10.8-13.</``Bibliography``>`  `<``Location``>Latitude:35.185451000000 Longitude:33.382411000000</``Location``>`  `</``coin``>`  `<``coin``>`  `<``title``>Billon Sizin. Janus, 1398-1432</``title``>`  `<``coin-Image``>/sites/default/files/1995-02-03-OB.png</``coin-Image``>`  `<``Mint``>Nicosia</``Mint``>`  `<``Material``>Billon</``Material``>`  `<``Axis``>12:00</``Axis``>`  `<``Diameter``>19 mm</``Diameter``>`  `<``Description``>Cross of Jerusalem.</``Description``>`  `<``Weight``>1.57 gm</``Weight``>`  `<``Denomination``>Sizin</``Denomination``>`  `<``Inscription``>IAnVS ROI DEI IERU</``Inscription``>`  `<``Bibliography``>`  `*BMK1997, 92, no.40; *CLC3, 124-127, pl.27.2 (not correct weight).`  `</``Bibliography``>`  `<``Location``>Latitude:35.185451000000 Longitude:33.382411000000</``Location``>`  `</``coin``>`  `</``coins``>` |
| --- | --- |

**Listing 2.** Example of XML export file- Medieval Coins from the collection of the Bank of Cyprus Cultural Foundation, Cypriot Medieval Coins: History and Culture.

## Appearance

OpeNumisma offers a preconfigured functionality and a custom Drupal sub-theme with CSS and JavaScript files related to the display of each coin. The theme is responsive and flexible enough to adapt to any mobile devices, as well on desktop screen resolution.. OpeNumisma allows the user to choose and configure the look and feel of the platform, However, the RTI viewer is not responsive, an additional effort will need to be done in order to achieve this goal.

## Applicability

The first successful implementation of OpeNumisma was the creation of a digital library for the medieval coins from the collection of the Bank of Cyprus Cultural Foundation (Figure 7). *Cypriot Medieval Coins: History and Culture* is a novel digital library dedicated to the study, promotion, and dissemination of the history of Medieval Cypriot Coinage (12th-16th centuries). The project is the development of the ongoing collaboration between the Bank of Cyprus Cultural Foundation and the Cyprus Institute, which originally began in February 2012 with the pilot implementation of the advanced Reflectance Transformation Imaging (RTI) photography on a large part of the collection of the Museum of the History of Cypriot Coinage. The results of the above work have been the basis for the development of the digital platform for the documentation and dissemination of Medieval Coins from the Museum of the History of Cypriot Coinage. The digital platform offers an interactive exploration of the medieval collection with the innovative implementation of Reflectance Transformation Imaging, complemented with text descriptions, essays, links to other collections and repositories that provide context as well as alternative ways to study and access the material.

![Cypriot Medieval Coins: History and Culture http://numismatics-medieval.dioptra.cyi.ac.cy](https://journal.code4lib.org/media/issue37/avgousti/image7.png)  
**Figure 7.**  
Cypriot Medieval Coins: History and Culture [http://numismatics-medieval.dioptra.cyi.ac.cy](http://numismatics-medieval.dioptra.cyi.ac.cy/)

## Further development

Future development of OpeNumisma will be focussed on the implementation of Nomisma.org, which has been hosted by the American Numismatic Society since 2010. Nomisma.org is a trustable resource in numismatics that provides URIs to many numismatic concepts and terms. Moreover, the ontology was created to integrate the openly available databases. The ontology is limited to numismatics and provides an easily understandable way to describe numismatic datasets. Our main goal is to have OpeNumisma as a downloadable application package from our website by the end of 2017. Moreover, our plans are to have ON on GitHub and Drupal.org.

## Conclusion

The creation of OpeNumisma aims to significantly enhance the documentation and preservation of cultural heritage objects and to improve digital online collections with the use of the Reflectance Transformation Imaging. The innovative web-based platform can be extended in order to support more advanced functionalities as well as to exploit the ever-increasing technological opportunities to enhance the interactive experience between the user and online databases.

## About the Authors

**Avgoustinos Avgousti** is a Research Technical Specialist at The Cyprus Institute at the Science and Technology in Archaeology Research Center (STARC). He is the web Architect and lead developer of Dioptra: The Digital Library for Cypriot Culture. He received his Bachelor of Science (BSc) from St. Francis College in New York City in Information Technology/Computer Science and Master of Science (MSc) in Medical Informatics from the State University of New York Downstate Medical Center in New York City. He has more than 12 years of experience in Information Technology and 3 years of teaching Computer Science at a college level. Furthermore, he participated in a number of EU and national funded projects. Avgoustinos’ research activity has been focused in the last five years on Digital Humanities and Digital Cultural Heritage.

**Andriana Nikolaidou** joined the Science and Technology in Archaeology Research Center (STARC) of The Cyprus Institute in September 2015 as an Intern in Advanced Imaging for Art and Cultural Heritage. She contributes to the digital libraries of the Cyprus Institute as a research assistant. Andriana received a Bachelor’s Degree in Fine Arts with first-class honors from De Montfort University (UK) in 2013. Adriana is interested in the aspect of archeology, researching the theme of legend as it relates to cultural narratives by questioning the notions between visual and scientific perspectives. Her aim is to combine new and porous ways of digital technologies and specifically advanced imaging into digital art scenarios.

**Ropertos Georgiou** received an Associate degree of Applied Science in Electronics Engineering from TCI Institute in New York City, a BSc in Computer Engineering from the University of Technology in Budapest, Hungary and an MSc in Multimedia Applications and Virtual Environments from Sussex University, UK. Currently, he holds a position at the Cyprus Institute at the Science and Technology Research Centre (STARC) as a research New Media specialist. His research interests span through innovative methods of electronic and image-based acquisition, documentation, and visualization for the development and support of research infrastructures.

## Acknowledgments

- The Bank of Cyprus Cultural Foundation for funding OpeNumisma: [https://www.boccf.org](https://www.boccf.org/)
- The Cyprus Institute: [http://www.cyi.ac.cy](http://www.cyi.ac.cy/)
- Reflectance Transformation Imaging WebRTIViewer: [http://vcg.isti.cnr.it/rti/webviewer.php](http://vcg.isti.cnr.it/rti/webviewer.php)
- Imaging Cluster for Archaeology and Cultural Heritage: [http://imlab.cyi.ac.cy](http://imlab.cyi.ac.cy/)

## Notes

\[[1](https://journal.code4lib.org/articles/#note1)\] Cultural Heritage Imaging,Reflectance Transformation Imaging (RTI) \[Internet\]. Available from: [http://culturalheritageimaging.org/Technologies/RTI](http://culturalheritageimaging.org/Technologies/RTI)

\[[2](https://journal.code4lib.org/articles/#note2)\] The 2014 ARL SPEC Kit on Open Source Software notes that 53% of 66 academic and public libraries responding to its survey use a locally hosted and supported OSS solution for digital preservation. Thacker, J., Knutson, C., Dehmlow, M. (2014) SPEC Kit 340: Open Source Software. United States of America, Washington, D.C. : Association of Research Libraries. Chapter 1, pg. 12.

\[[3](https://journal.code4lib.org/articles/#note3)\] The Roman Provincial Coinage Online is developed by Oxford University. The present archive is grounded on ten collections and includes information on more than 13,000 coin types based on 46,725 specimens and with more than 9,000 images. Some of the functionalities of the system are that the user can search by city, inscription, mental, diameter and much more. The Roman Provincial Coinage Online \[Internet\]. \[updated 2017\] University of Oxford. Available from: [http://rpc.ashmus.ox.ac.uk/project](http://rpc.ashmus.ox.ac.uk/project)

\[[4](https://journal.code4lib.org/articles/#note4)\] The Sylloge Nummorum Graecorum is one of the larger Numismatic databases dedicated to Greek numismatics. More than 25,000 coins are available online, and the database can be searched by mint, material, ruler, period, denomination, coin descriptions and many others fields. All records include images of the coin and descriptive material.The Sylloge Nummorum Graecorum \[Internet\]. \[updated 2017\] The Fitzwilliam Museum: Department of Coins and Medals. Available from: [http://www.sylloge-nummorum-graecorum.org](http://www.sylloge-nummorum-graecorum.org/)

\[[5](https://journal.code4lib.org/articles/#note5)\] The Catalogue of the Vatican Library’s Numismatic Cabinet was created in 2001 and includes the collection of Parthian coins the collection of Imperial Roman coins is still underway. Vatican Library: Catalogues-Coins and Medals. For more information see: [http://opac.vatlib.it/iguana/www.main.cls?sUrl=homeMED&language=eng](http://opac.vatlib.it/iguana/www.main.cls?sUrl=homeMED&language=eng) \[Accessed 07/04/2017\]

\[[6](https://journal.code4lib.org/articles/#note6)\] Online Coins of the Roman Empire (OCRE), a joint project of the American Numismatic Society and the [Institute for the Study of the Ancient World at New York University](http://isaw.nyu.edu/), is a revolutionary new tool designed to help in the identification, cataloging, and research of the rich and varied coinage of the Roman Empire. The project records every published type of Roman Imperial Coinage from Augustus in 31 BC, until the death of Zeno in AD 491. OCRE: Online Coins of the Roman Empire. For more information see: [http://numismatics.org/ocre](http://numismatics.org/ocre) \[Accessed 15/01/2017\]

\[[7](https://journal.code4lib.org/articles/#note7)\] Numishare is an open source suite application developed and maintained by the American Numismatic Society for managing digital heritage artifacts, with a particular focus on coins and medals, built on open source applications: Solr, eXist XML data store, and others. Some of the functionalities of Numishare are browsable facets, handling images, search and more. For more information see: [https://github.com/ewg118/numishare](https://github.com/ewg118/numishare) \[Accessed 14/01/2017\]

\[[8](https://journal.code4lib.org/articles/#note8)\] Coinage of the Roman Republic Online (CRRO) aims to provide in effect an online version of Michael Crawford’s 1974 publication Roman Republican Coinage (RRC), which is still the primary typology used for the identification of Roman Republican coin types. Coinage of the Roman Republic Online For more information see: [http://numismatics.org/crro](http://numismatics.org/crro) \[Accessed 16/01/2017\]

\[[9](https://journal.code4lib.org/articles/#note9)\] Our catalog of 6,500 numismatic pieces – coins, glass weights, dies, medals, etc. – is the third major catalog of Islamic numismatic material held in the Egyptian National Library, formerly the Khedivial Library, Egypt’s most important library. Dar al-Kutub Collection of the Egyptian National Library. For more information see: [http://enl.numismatics.org](http://enl.numismatics.org/) \[Accessed 16/01/2017\]

\[[10](https://journal.code4lib.org/articles/#note10)\] Mudge, M. et al. 2010. Principles and Practices of Robust, Photography-based Digital Imaging Techniques for Museums. In: 1th International Symposium on Virtual Reality, Archaeology and Cultural Heritage VAST, edited by A. Artusi, M. Joly-Parvex, G. Lucet, A. Ribes, and D. Pitzalis, Paris. Available from: [https://www.si.edu/mci/EarlyPhotography/references/VAST2010.pdf](https://www.si.edu/mci/EarlyPhotography/references/VAST2010.pdf)

\[[11](https://journal.code4lib.org/articles/#note11)\] Malzbender, T., Gelb, D., and Wolters, H., 2001. “Polynomial texture maps.” In *SIGGRAPH ’01 Proc. of the 28th Annual Conference on Computing graphics and interactive techniques, (August 2001),* 519-528. Los Angeles, California

\[[12](https://journal.code4lib.org/articles/#note12)\] For more information see: [http://www.cidoc-crm.org](http://www.cidoc-crm.org/) \[Accessed 28/02/2017\]

## References

- Velios A. 2011. The John Latham Archive: An online implementation using Drupal. Art Documentation Volume 30, Number 2
- Wiltshire N.G. 2013. The use of SAHRIS as a state-sponsored digital heritage repository and management system in South Africa. CIPA Symposium 2-6 September DOI: 10.5194/isprsannals-II-5-W1-325-2013 Available from: [researchgate.net](https://www.researchgate.net/publication/307794242_THE_USE_OF_SAHRIS_AS_A_STATE_SPONSORED_DIGITAL_HERITAGE_REPOSITORY_AND_MANAGEMENT_SYSTEM_IN_SOUTH_AFRICA)
- Berry A, Byron A and De Bondt B. 2012. Using Drupal Using Drupal, 2nd Edition
- Kawana H. 2009. Towards Digital Archive Systems: Architecture and Design of Digital Museum Archive: The Eighth International Symposium on Operations Research and Its Applications (ISORA’09) Zhangjiajie, China, September 20–22, 2009 Copyright © 2009 ORSC & APORC, pp. 15–21
- H. Kawano. 2012. Digital Archive system using CMS and Gallery tools –implementation of Anthropological Museum.
- Wooster G.E. 2006. Recent Advances in Roman Numismatics: BA, The Pennsylvania State University.
- Muller Eva, Klosa Uwe Hansson Peter, Andersson, Stefan Siira Erik. Using XML for Long-term Preservation.
- Reflectance Transformation Imaging WebRTIViewer: [http://vcg.isti.cnr.it/rti/webviewer.php](http://vcg.isti.cnr.it/rti/webviewer.php)
- VanDyk J.,Tomlinson T, 2010. Pro Drupal 7 Development (Expert’s Voice in Open Source) 3rd ed. United States of America, New York: Apress. Chapter: 1. pg.
- Creating custom modules: [https://www.drupal.org/docs/7/creating-custom-modules](https://www.drupal.org/docs/7/creating-custom-modules)
- Earl, G.P., Martinez, K. and Malzbender, T. 2010. Archaeological Applications of Polynomial Texture Mapping: Analysis, Conservation, and Representation. In Journal of Archaeological Science, 37, pg 40-50.
- Dutr’e, P., Bekaert, P., and Bala, K. 2003. Advanced Global Illumination 2nd ed. United States of America, Natick: A K Peters/CRC Press
- Bakirtzis, N., Georgiou, R. 2014, Light on El Greco from a technological perspective: The Baptism of Christ and the View of Mount Sinai at the Historical Museum of Crete in Heraklion. In international conference proceedings “El Greco the Cretan years”, 21-23 June, Heraklion
- Earl, G.P., Martinez, K. and Malzbender, T. 2010. Archaeological Applications of Polynomial Texture Mapping: Analysis, Conservation, and Representation. In Journal of Archaeological Science, 37, pg 40-50.
- Cultural Heritage Imaging,Reflectance Transformation Imaging (RTI) \[Internet\]. Available from: [http://culturalheritageimaging.org/Technologies/RTI](http://culturalheritageimaging.org/Technologies/RTI)
- For more information see: [https://www.drupal.org/project/views](https://www.drupal.org/project/views) \[Accessed 28/01/2017\]
- Thompson K, Richard J. 2013. Moving Our Data to the Semantic Web: Leveraging a Content Management System to Create the Linked Open Library. Journal of Library Metadata, 13:290–309, 2013. DOI: 10.1080/19386389.2013.828551. Available from: [https://repository.si.edu/bitstream/handle/10088/22149/WJLM\_A\_828551.pdf](https://repository.si.edu/bitstream/handle/10088/22149/WJLM_A_828551.pdf)
- Gerth, P and DAI (2016) ARIADNE D14.2: Pilot deployment experiments. Version: 1st. Available from: [http://www.ariadne-infrastructure.eu/Resources/D14.2-Pilot-deployment-experiments](http://www.ariadne-infrastructure.eu/Resources/D14.2-Pilot-deployment-experiments) \[Accessed 14/03/2017\]
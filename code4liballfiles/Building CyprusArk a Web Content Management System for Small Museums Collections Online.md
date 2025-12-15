---
title: "Building CyprusArk a Web Content Management System for Small Museums Collections Online"
source: "https://journal.code4lib.org/articles/16722"
author:
  - "Avgoustinos Avgousti"
  - "Georgios Papaioannou"
  - "Feliz Ribeiro Gouveia"
published: 2022-08-29
created: 2025-01-10
description: "This article introduces CyprusArk, a work-in-progress solution to the problems that small museums in Cyprus have in providing online access to their collections. CyprusArk is an open-source web content management system for small museums’ online collections. Developed as part of Avgousti’s Ph.D. thesis, based on qualitative data collected from six small museums in Cyprus."
tags:
  - "#CyprusArk"
  - "#museum"
---
# Building CyprusArk a Web Content Management System for Small Museums Collections Online
Avgoustinos Avgousti, Georgios Papaioannou, Feliz Ribeiro Gouveia

This article introduces CyprusArk, a work-in-progress solution to the problems that small museums in Cyprus have in providing online access to their collections. CyprusArk is an open-source web content management system for small museums’ online collections. Developed as part of Avgousti’s Ph.D. thesis, based on qualitative data collected from six small museums in Cyprus.

## 1\. Introduction

Cultural heritage digitization and online accessibility offer an unprecedented opportunity to democratize museum collections. Museum collections online are usually presented via institutional websites, and they mirror the world’s culture and civilization. They form an increasing trend toward a world where information is digitally preserved, stored, accessed, and disseminated instantaneously through a global and concatenated digital network. However, while the Web has enabled cultural heritage organizations to democratize information to diverse audiences, many small museums do not enjoy the fruits of this digital revolution. The majority of small museums are underfunded, understaffed, and lack technology infrastructures (OECD, 2020).

As a result, many small museums cannot publish their collections online. Due to the problems above, digital versions of small museum collections are mainly inaccessible and hidden. Subsequently, humans have less access to information that can lead to new knowledge.

## 2\. Defining Scales

### 2.1 What is a Small Museum

Museums are defined as small based on their annual budget, number of staff, collections size and physical size of the museum. The American Association for State and Local History 2007 (AASLH) defines museums as small if they have a yearly budget of fewer than 250,000 dollars and limited staff with multiple responsibilities. Other factors such as the size of collections and the physical size of the museum could further categorize a museum as small.

Katz (1995) set the same budget and the staff number at five or less. Honeysett and Falkowski (2018) put the budget at 300,000 dollars and five or less employees. Miller (2008) notes that the average small museum has just two full-time employees and a budget of less than 90,000 dollars. Watson (2007) by contrast, defines small museums as ones that grew out of the community they serve.

For the purposes of this article, a small museum is one with more than one but less than five full-time employees, not including museum custodians. Categorizing a museum based on its budget is difficult and contentious since often museum staff are funded by another body, such as a municipality.

### 2.2 What is CyprusArk

CyprusArk ([GitHub](https://github.com/aavgoustinos/cyprusark)) is proposed as a solution to the challenges small museums in Cyprus face in providing online access to their collections. CyprusArk is an open-source web content management system for small museums’ online collections developed as part of Avgousti Ph.D thesis. It follows the KISS principle, “Keep it simple, stupid”. According to the KISS principle, most systems work best when they are simple rather than complex in maintenance (U.S. Navy, 1960). Designed primarily to meet the needs of Cyprus’s small museums, CyprusArk can be used by other small museums all over the world. CyprusArk was developed based on qualitative research of six small museums in Cyprus using semi-structured interviews.

CyprusArk has been created using an open-source stack consisting of the leading-edge [Django](https://www.djangoproject.com/), a high-level Python Web framework, [Postgres](https://www.postgresql.org/) database, Bootstrap, an open-source CSS framework, and running on virtualized [Docker](https://www.docker.com/) containers. Instances of CyprusArk can be hosted on any infrastructure selected by the museum. CyprusArk differs from other comparable systems, as described below, because it focuses on small museums and most specifically small museums in Cyprus.

## 3\. Related Works

The [Mukurtu](https://mukurtu.org/) content management system is an open-source platform dedicated to meeting the needs of diverse communities through the subsequent sharing of their digital cultural heritage online (Humanities for All). The platform was developed on the leading open source content management system Drupal, and its advert has assisted substantially in the field of extending the functionality of the content management system towards the critical issue of preserving and disseminating the knowledge derived from cultural heritage.

Another similar system is the [ViMuseu](https://vimuseo.com/) content management system, which constitutes a project dedicated to the needs of small Finnish museums and has been developed by the Department of Arts and Cultural Studies at the University of Jyväskylä in Finland in collaboration with the University’s museum. The ViMuseo CMS can be regarded as an online multimedia presentation tool mainly used for virtual exhibitions and projects. The ViMuseu content management system’s utility is related to digital-free institutions that wish to be more active on the Internet. This tool can be described as a web application content management system (Web CMS) co-developed by programmers and graphic designers.

Additionally, a similar project carried out by The Cyprus Institute (CyI) and the OpeNumisma content management system Avgousti et al. (2017). The OpenNumisma content management system can be perceived as a reusable web-based platform which consists of a merge of digital imaging and content that offers tremendous opportunities for research, as well as for the dissemination of knowledge and data. The platform’s development seeks to create a digital web framework concerning online numismatic collections. This kind of content management system has been implemented and used by small numismatic museums in Cyprus.

Daradimos et al. (2015) presented the significant problem of small museums that are considered unable to reach the public through the Web due to the cost of commercial software and the complexity of the development and customization of such software. In his article, he recommends a different approach, along with developing a general-purpose plugin (module) that will extend the functionality of the open-source Drupal CMS for small museum collections online. A similar idea was also proposed by (Avgousti, Papaioannou, and Gouveia, 2019), a collection of reusable Drupal modules aimed at small-scale museums and archival online collections.

The Getty Foundation Online Scholarly Catalog Initiative ([OSCI](https://www.getty.edu/foundation/initiatives/past/osci/index.html)) is helping museums make web-based publications available to the public with the use of technology and the internet (Marrow, 2017). The development of [ChicagoCodeX](https://github.com/IMAmuseum/ChicagoCodeX) can be regarded as the basis for this tool since this kind of toolkit leaves the margin for institutions to deploy a microsite’s digital collections. However, based on Marrow (2017), the parameters relative to the toolkit’s complexity combined with its augmented cost on account of its technical expert requirements can be regarded as certain of its disadvantages.

Accordingly, the [WissKI](https://wiss-ki.eu/) a content management system platform can be regarded as one other illustration that is aimed at the production of a virtual research environment for the digital humanities (Scholz, 2012). The platform is based on the open-source content management system Drupal and requires installing approximately thirty contributed plugins to implement the system. The default installation of the software, in same cases, may lead to difficulties with upgrading to new versions of the system because of its heavy dependence on many other modules (Velios, 2017).

In line with the above, the [Omeka](https://omeka.org/), a content management system developed specifically for scholars, librarians, archives, and museums, targets the creation of digital collections. It uses the Dublin Core for storing the metadata of the objects. Moreover, the [Omeka “S”](https://omeka.org/s/) is considered more oriented towards connecting digital cultural heritage collections through the consequential usage of Linked Open Data principles (Ontotext, n.a ). Hardesty (2014) mentioned that Omeka had been used in various memory institutions (Flynn, 2018). Although, compared to large and robust ecosystems available for other large content management systems such as [WordPress](https://wordpress.com/), [Joomla](https://www.joomla.org/) and [Drupal](https://www.drupal.org/) Dombrowski (2016) argues that Omeka can be described as a fairly moderate CMS with minor community support, plugins, developers, and users.

Lastly, the [GLAMkit](http://glamkit.com/) content management system, or web framework, is designed specifically for GLAM sector organizations (Galleries, Libraries, Archives and Museums) (Weakley et al., 2009). It has tools for managing and displaying collections online and complex events; it can be focused on small institutions with limited technical staff (Mansfield, 2017). GLAMkit is developed using the Django Framework and the [Wagtail](https://wagtail.org/) content management system focusing on common museum needs (Mansfield, 2020).

## 4\. CyprusArk Architecture

### 4.1 Content Model

In this section, we discuss the high-level development and design of the CyprusArk prototype, using the Django framework. Currently, the CyprusArk prototype has basic functionality. Keeping the design simple will help with future testing of the technology to explore how useful and applicable it is within the small museums’ domain. The CyprusArk [content model](http://www.clevegibbon.com/content-modeling/content-models/conceptual-content-model/) consists of four content types: Place (e.g., museum), Bundle (e.g., collection), Creative Work (e.g., Item), and a Maker (e.g., Person). CyprusArk content types draw inspiration from the Object ID, Dublin Core, and the Schema.org field recommendations, for modeling the information and creating the necessary content types.

![Figure 1. CyprusArk Conceptual Content Model](https://journal.code4lib.org/media/issue54/avgousti/fig01.png "Figure 1. CyprusArk Conceptual Content Model")

**Figure 1.** CyprusArk Conceptual Content Model

### 4.2 Place

The first content type is the place, which can be used to make a landing page using CyprusArk. The place content type includes fifteen fields that cover most of the information that describes a place (e.g. museum). We attempted to maintain the field titles as straightforward as possible to help structure these fields with rich semantic information for future development. The table below depicts the content type place along with its fields and expected attribute types, as well as a brief description of each field.

| Attribute/Field Name | Attribute Type | Description |
| --- | --- | --- |
| Name | Text | The name of the museum (e.g., Pierides Museum). |
| Classification | Drop Down List | Museums, etc. |
| Working Hours | Text | The time that the museum is open to the public. |
| Address | Text | The address of the place. |
| City | Text | The City where the place is located (e.g. Athens, Nicosia). |
| Country | Text | The country where the place is located (e.g. Cyprus, Greece). |
| Image | Image | A photo(s) of the place. |
| Phone | Integer | The telephone number of the place (e.g., 22 55667788). |
| Logo | Image | The logo of the place. |
| Description | Long Text | Short description of the place. |
| Same As | Link | An external link (e.g., Wiki Page, FB page). |
| Website | Link | An external link to the place website if it exists. |
| Order | Integer | The order in which the content will be displayed. |
| Online | Boolean Field | If selected, the content will be shown on the template front end, if not the content will live only on the backend. |
| Slug | Text | Is the URL that the place will get in CyprusArk. The slug field will be auto-generated by using the Place name field |

**Table 1.** Place Content-Type (e.g., Museum)

### 4.3 Bundle

The bundle content type is the second content type. The bundle content type describes a “museum collection(s)”. An example of the content bundle is: “Terracotta Collection from Salamis Cyprus”. A place is related to one or multiple bundles. For example, a museum is a place and the museum collection(s) are bundles of that place. The following image shows this type of relation.

![Figure 2. Bundle(s) Relationship to a Place](https://journal.code4lib.org/media/issue54/avgousti/fig02.jpg "Figure 2. Bundle(s) Relationship to a Place")

**Figure 2.** Bundle(s) Relationship to a Place

It consists of eight fields to cover most of the bundle (e.g. collection) information. The table below depicts the content type bundle along with its fields and expected attribute types, as well as a brief description of each field.

| Attribute/Field Name | Attribute Type | Description |
| --- | --- | --- |
| Name | Text | The name of the bundle (e.g. Portraits Collection). |
| Size | Integer | Auto-generated, based on the creative works related to the bundle. |
| Photo | ImageObject | An image representing this bundle. |
| Description | Long Text | A description of the bundle. What is it about? |
| Same As | URL | URL of a reference webpage. |
| Online | Boolean Field | If selected, the content will be shown on the template front end, otherwise the content will live only on the backend. |
| Slug | URL | The URL of the bundle. |
| Order | Integer | The order in which the content will be displayed. |

**Table 2.** Bundle Content-Type

### 4.4 Creative Work

The third content type is the creative work content type. The creative work content type can be used to create museum item(s) (e.g. Paintings, Sculptures). It consists of twenty two fields to cover most of the information that can be used to publish a creative work on the web. It is not necessary to use all those fields. The creative work content type is related to the place, and the bundle content types. The table below depicts the content type of creative work fields and expected attribute types, as well as a brief description of each field.

| Attribute/Field Name | Attribute Type | Description |
| --- | --- | --- |
| Art Form | Select List | The art form of a creative work (Painting, Drawing, Sculpture, Photograph). |
| Art Medium | Select List | The material used (Oil, Pastel, Pencil). |
| Art Work Surface | Select List | The supporting materials for the artwork (Canvas, Stone, Paper, Wood). |
| Additional Type | Url or Text | Any additional type (Icon, Coin) linked to an external vocabulary such as Getty AAT controlled vocabulary. |
| Title | Text | The object title by which it may be known and can be identified (e.g. Mona Lisa). |
| Date Created | Text | When the object was made (e.g. 1650). |
| Description | Long Text | Description of the object. |
| Image | Image | Object image(s). |
| Dimensions | Text or Number | The size and/or weight of the object. |
| Credit Line | Text | Example: Gift of J. Pierpont Morgan, 1917. |
| Accession Number | Text and or Number | Identification of the object (e.g. number 1254a124d). |
| SameAs | URL | URL to the same item (e.g. Wiki, DB media). |
| Culture | Text | The culture of the item (e.g. Cypriot, American, Arabic). [Example](https://en.wikipedia.org/wiki/Arab_culture) |
| Period | Text | The period of the item (e.g. Late Bronze Age). |
| Rights of Reproduction | Text | E.g. public domain. |
| Citation | Text | Citation or reference to scholarly articles, web page etc. |
| Slug | Text | The URL of the item that can become a URI. |
| Order | Integer | The order in which the content it will be displayed. |
| Bundle | Reference | The bundle (collection) in which the creative work belongs. |
| MakerType | Reference | The role of a maker of this creative work (e.g. Creator, Editor). Example a maker can be a creator in creative work one, at the same time can be the author in creative work two. |
| Maker | Reference | The maker content type. |
| Online | select boxes | Show on the front-end. |

**Table 3.** CreativeWork Content-Type

A place is related to a bundle(s), and a bundle is related to creative work(s). For example, a bundle is a collection of creative works that belongs to a place. The image below shows the relationship between the place, bundle, and creative work.

![Figure 3. Place, Bundle(s) and Creative Work(s) Relationship](https://journal.code4lib.org/media/issue54/avgousti/fig03.jpg "Figure 3. Place, Bundle(s) and Creative Work(s) Relationship")

**Figure 3.** Place, Bundle(s) and Creative Work(s) Relationship

### 4.5 Maker

The maker is the last content type. The maker content type consists of twelve fields to cover most information that can be used to describe a maker (person). A maker can be an object’s creator, artist, penciler, editor, publisher, etc. The maker content type is related or not related to the creative work content type. For example, creative work (Mona Lisa) is related to a maker that is the creator (Leonardo da Vinci ).

The image below shows the relationship between the creative work and the maker concerning the rest of the content model.

![Figure 4. Place, Bundle(s), Creative Work(s) and Maker(s) Relationship](https://journal.code4lib.org/media/issue54/avgousti/fig04.jpg "Figure 4. Place, Bundle(s), Creative Work(s) and Maker(s) Relationship")

**Figure 4.** Place, Bundle(s), Creative Work(s) and Maker(s) Relationship

| Attribute/Field Name | Attribute Type | Description |
| --- | --- | --- |
| First Name | Text | The name of the maker. |
| Last Name | Text | The last name of the maker. |
| Gender | Text | The gender of the maker. |
| Image | Image | A photo of the maker. |
| Date of Birth | Date | Date of birth of the maker. |
| Birth Place | Date | The place where the maker was born (e.g., Athens). |
| Date of Death | Date | If the maker is dead, the date of death. |
| Death Place | Date | If the maker is dead, the place of death (e.g. Nicosia). |
| Same As | External Link | An external link (e.g. wiki page). Example: https://dbpedia.org/page/Leonardo\_da\_Vinci |

**Table 4.** Maker Content-Type

## 5\. Collections Online Creation Process

In this section, we will describe the CyprusArk back-end used by a login user for content creation, and how content will appear to the front user. We used data from the [Pattichion Municipal Museum](https://www.limassol.org.cy/en/istoriko-arxeio-kentro-meleton) to demonstrate this exercise.

The first step is for a back-end user to log into CyprusArk, using the username and password provided by the administrator. When the user is logged in, it will be auto-redirected to the CyprusArk dashboard. All login users have specific permissions; they can Create, Retrieve, Update and Delete (CRUD) content. However, the administrator of CyprusArk can give custom permissions to individuals or groups of individuals (e.g. museum curators can only add content).

### 5.1 Adding a Place

The login user can Create, Retrieve, Update and Delete (CRUD) a place using the place content type web form. First, the user must fill out the web form consisting of the name, and subject (e.g. Pierides Museum). After filling out the fields, the place content will be created and appear on the CyprusArk admin dashboard. It is important to note that the user can add only a single place. The following table shows how the login user CRUD functionality.

The user can decide whether to have the place online or not. We added this functionality to give the user the option to have the content offline until it is fully completed and ready to be displayed online. The following image represents a content store in the system backend.

![Figure 5. Print Screen place backend](https://journal.code4lib.org/media/issue54/avgousti/fig05.png "Figure 5. Print Screen place backend")

**Figure 5.** Print Screen place backend  
([click to enlarge](https://journal.code4lib.org/media/issue54/avgousti/fig05.png))

When the online checkbox is selected, the content will appear on the front end.

### 5.2 Adding a Bundle

The second step is to create a bundle (e.g. collection(s)). In order to create a bundle, the user should complete some important fields such as the name, image description and so forth.

After filling out the fields, the bundle content will be created and appear on the CyprusArk admin dashboard. Further, the login user can select in which order the content will be displayed.

The following image represents three bundles,only two displayed on the front end. The following image represents bundles that are stored in the system.

![Figure 6. Print Screen](https://journal.code4lib.org/media/issue54/avgousti/fig06.png "Figure 6. Print Screen")

**Figure 6.** Print Screen  
([click to enlarge](https://journal.code4lib.org/media/issue54/avgousti/fig06.png))

When the online checkbox is selected, the content will appear on the front end. The following image shows how the place and the two bundles display on the HTML page.

![Figure 7. Print Screen Bundle(s) Front-End](https://journal.code4lib.org/media/issue54/avgousti/fig07.png "Figure 7. Print Screen Bundle(s) Front-End")

**Figure 7.** Print Screen Bundle(s) Front-End  
([click to enlarge](https://journal.code4lib.org/media/issue54/avgousti/fig07.png))

### 5.3 Adding a Creative Work

The next step is to create a creative work(s) (museum items), using the creative work content type web form, and assign the creative work to a bundle. The same creative work can belong to a single or multiple bundles.

![Figure 8. Print Screen Creative Work(s) Management Dashboard](https://journal.code4lib.org/media/issue54/avgousti/fig08.png "Figure 8. Print Screen Creative Work(s) Management Dashboard")

**Figure 8.** Print Screen Creative Work(s) Management Dashboard  
([click to enlarge](https://journal.code4lib.org/media/issue54/avgousti/fig08.png))

From this panel the login user can make direct changes to any creative work without visiting the detailed page of each item. Further, they can filter down the information using the right menu or the search bar on the top. If the online checkbox is selected, the creative work will be displayed on the HTML front end page. The creative work uses two HTML templates. The first template is a list of all creative works in relation to a bundle (collection of items) and the second template is a detailed page of each creative work. The end-user can manipulate and filter the information using the drop down menu on the top of the page.

![Figure 9. List of creative works that belong to a bundle](https://journal.code4lib.org/media/issue54/avgousti/fig09.png "Figure 9. List of creative works that belong to a bundle")

**Figure 9.** List of creative works that belong to a bundle  
([click to enlarge](https://journal.code4lib.org/media/issue54/avgousti/fig09.png))

At this point, a login user can create a maker (person) and relate a maker to creative work. If the item is not related to any maker simply the maker will not be displayed on the HTML page.

### 5.4 Adding a Maker (Pearson)

The maker is our last content type, and the same process is needed to CRUD a maker. The maker may be related to the creative work. If the creative work is related to a maker, the maker will show up on the screen. The same maker can have different roles on different creative works. For example, in creative work, one is the creator, and in creative work, two is the author.

![Figure 10. Detail View of Creative Works with a maker relation](https://journal.code4lib.org/media/issue54/avgousti/fig10.png "Figure 10. Detail View of Creative Works with a maker relation")

**Figure 10.** Detail View of Creative Works with a maker relation  
([click to enlarge](https://journal.code4lib.org/media/issue54/avgousti/fig10.png))

### 5.5 Adding Slides

The login user can also change the slider by adding customized images representing their own institution. Furthermore, they can link the slider image to a specific page, which could be internal or external. The user can add as many slides as they like and can change the slider order (what is first, second, etc. ).

![Figure 11. updated slider](https://journal.code4lib.org/media/issue54/avgousti/fig11.png "Figure 11. updated slider")

**Figure 11.** updated slider  
([click to enlarge](https://journal.code4lib.org/media/issue54/avgousti/fig11.png))

## 6\. Conclusion and Future Steps

In this article, we presented an overview of the CyprusArk high-fidelity prototype architecture, and we then moved to the in-depth details of this prototype. We discussed the content types and the related fields used and added to CyprusArk, presenting the content relationships in a detailed content model. Further, we continued with the actual presentation of CyprusArk. We explained how it works and the process of creating place, bundles, creative work, and makers, as well as presenting the back and front-end. Future steps will include the implementation of the semantic markup based on Schema.org vocabulary or ontology. Moreover, we plan to test the CyprusArk prototype and explore how useful and applicable it is within the small museums’ domain in Cyprus. Based on the results, we will add/change the functionality of CyprusArk to better fit small museums’ needs.

## References

AASLH. “What Is the Definition of a Small Museum? Survey Results,” 2007. [http://download.aaslh.org/small+museums/Small+Museum+Survey+Results.pdf](http://download.aaslh.org/small%2Bmuseums/Small%2BMuseum%2BSurvey%2BResults.pdf).

Avgousti, Avgoustinos, Georgios Papaioannou, and Feliz Ribeiro Gouveia. “Content Dissemination from Small-Scale Museum and Archival Collections: Community Reusable Semantic Metadata Content Models for Digital Humanities.” The Code4Lib Journal, no. 43 (February 14, 2019). [https://journal.code4lib.org/articles/14054](https://journal.code4lib.org/articles/14054).

Avgousti, Avgoustinos, Andriana Nikolaidou, and Ropertos Georgiou. “OpeNumisma: A Software Platform Managing Numismatic Collections with A Particular Focus On Reflectance Transformation Imaging.” The Code4Lib Journal, no. 37 (2017). [https://journal.code4lib.org/articles/12627](https://journal.code4lib.org/articles/12627).

Daradimos, Illias, Costas Vassilakis, and Akrivi Katifori. “A Drupal CMS Module for Managing Museum Collections,” 2015. [https://www.academia.edu/29947679/A\_Drupal\_CMS\_Module\_for\_Managing\_Museum\_Collectio](https://www.academia.edu/29947679/A_Drupal_CMS_Module_for_Managing_Museum_Collections)

Dombrowski, Quinn. Drupal for Humanists. Texas A&M University Press, 2016. [https://drupal.forhumanists.org/book](https://drupal.forhumanists.org/book).

Flynn, Bernadette. “Making Collections Accessible.” Federation of Australian Historical Societies Inc, 2018. [https://www.history.org.au/wp-content/uploads/2018/10/MakingCollectionsAccessible.pdf](https://www.history.org.au/wp-content/uploads/2018/10/MakingCollectionsAccessible.pdf).

Humanities for All. “Mukurtu CMS: An Indigenous Archive and Publishing Tool.” Accessed August 9, 2022. [https://humanitiesforall.org/projects/mukurtu-an-indigenous-archive-and-publishing-tool](https://humanitiesforall.org/projects/mukurtu-an-indigenous-archive-and-publishing-tool).

Shepard, Michael. “Review of Mukurtu Content Management System.” Language Documentation & Conservation, September 2014. [http://scholarspace.manoa.hawaii.edu/handle/10125/24610](http://scholarspace.manoa.hawaii.edu/handle/10125/24610).

Katz, Paul. “The Quandaries of the Small Museum.” The Journal of Museum Education 20, no. 1 (1995): 15–17. [https://www.jstor.org/stable/40479486](https://www.jstor.org/stable/40479486).

L. Hardesty, Juliet. “Exhibiting Library Collections Online: Omeka in Context.” New Library World 115, no. 3/4 (2014): 75–86. [https://doi.org/10.1108/NLW-01-2014-0013](https://doi.org/10.1108/NLW-01-2014-0013).

Mansfield, Tomothy. “Small Museum? Want More from Your Website?” The Interaction Consortium Pty Ltd, 2017. [https://interaction.net.au/articles/small-museum-want-more-from-your-website/](https://interaction.net.au/articles/small-museum-want-more-from-your-website/).

Mansfield, Tomothy. “GLAMkit Is Dead. Long Live Glamkit!” The Interaction Consortium, 2020. [https://interaction.net.au/articles/glamkit-dead-long-live-glamkit/](https://interaction.net.au/articles/glamkit-dead-long-live-glamkit/).

Marrow, Deborah. Museum Catalogues in the Digital Age (OSCI Final Report). The Getty Foundation, Los Angeles, 2017. [https://www.getty.edu/publications/osci-report/assets/downloads/osci-report.pdf](https://www.getty.edu/publications/osci-report/assets/downloads/osci-report.pdf).

Miller, Pamela Wilder. “What We Do Best: Quality Collections Care Practices in Small Museums in Utah.” Doctoral Thesis, Utah State University, 2008. [https://digitalcommons.usu.edu/cgi/viewcontent.cgi?article=1007&context=etd](https://digitalcommons.usu.edu/cgi/viewcontent.cgi?article=1007&context=etd).

OECD. “Culture Shock: COVID-19 and the Cultural and Creative Sectors,” 2020. [https://www.oecd.org/coronavirus/policy-responses/culture-shock-covid-19-and-the-cultural-and-creative-sectors-08da9e0e/](https://www.oecd.org/coronavirus/policy-responses/culture-shock-covid-19-and-the-cultural-and-creative-sectors-08da9e0e/).

Ontotext. “What Are Linked Data and Linked Open Data?” Accessed August 17, 2022. [https://www.ontotext.com/knowledgehub/fundamentals/linked-data-linked-open-data/.](https://www.ontotext.com/knowledgehub/fundamentals/linked-data-linked-open-data/)

Scholz, Martin, and Günther Görz. “WissKI: A Virtual Research Environment for Cultural Heritage.” In ECAI, 2012. [https://doi.org/10.3233/978-1-61499-098-7-1017](https://doi.org/10.3233/978-1-61499-098-7-1017).

Velios, Athanasios, and Aurelie Martin. “Off-the-Shelf CRM with Drupal: A Case Study of Documenting Decorated Papers.” International Journal on Digital Libraries 18, no. 4 (2017): 321–31. [https://doi.org/10.1007/s0](https://doi.org/10.1007/s00799-016-0191-5)0[799-016-0191-5](https://doi.org/10.1007/s00799-016-0191-5).

Watson, Sheila, ed. Museums and Their Communities. Leicester Readers in Museum Studies. London ; New York: Routledge, 2007.

Weakley, Alastair, Thomas Ashelford, Julien Phalip, and Greg Turmer. “Introducing GLAMkit – a Free, Open-Source Web Framework for the GLAM Sector,” 2009. [https://www.museumsandtheweb.com/mw2010/abstracts/prg\_335002451.html](https://www.museumsandtheweb.com/mw2010/abstracts/prg_335002451.html).

## About the Authors

**Avgoustinos Avgousti** (a.avgousti@cyi.ac.cy) Senior Research Technical Specialist in Digital Humanities and Cultural Heritage Informatics at The Cyprus Institute at the Science and Technology in Archaeology Research Center (STARC). And, a Ph.D. Candidate at Ionian University, School of Information Science & Informatics, Department of Archives, Library Science and Museology.

**Dr. Georgios Papaioannou** (gpapaioa@ionio.gr) Associate Professor at the Ionian University, Corfu, Greece. His research interests lie in museology, digital humanities, archaeology of the Eastern Mediterranean and the Arab World, cultural studies, and IT applications including heritage documetation, Big Data and mobile applications. He has lectured, excavated, and conducted museum and cultural heritage work internationally (Europe, Arab World). He is the General-Secretary of the Hellenic Society for Near Eastern Studies, Director of the Museology Research Lab at the Ionian University (Greece), member of the Pool of Experts of the European Museum Academy, and a member of ICOM.

**Dr. Feliz Ribeiro Gouveia** (fribeiro@ufp.edu.pt) Professor of Computer Engineering at the Faculty of Engineering of University Fernando Pessoa, Porto, Portugal. He has worked in research and technology transfer projects for industry, in the areas of knowledge management and object-oriented databases for major European companies. He participated in several research projects in cultural heritage and digital humanities and has acted as consultant for organizations implementing cultural collection management projects. He graduated in Electrotechnical Engineering from the University of Porto and holds a PhD in Computer Science from the Université de Technologie de Compiègne, France.
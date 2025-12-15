---
title: "Using PHP to Parse eBook Resources from Drupal 6 to Populate a Mobile Web Page"
source: "https://journal.code4lib.org/articles/7294"
author:
  - "[[The Code4Lib Journal]]"
published: 2012-10-03
created: 2025-01-10
description: "The Ursula C. Schwerin library needed to create a page for its mobile website devoted to subscribed eBooks. These resources, however, were only available through the main desktop website. These resources were organized using the Drupal 6 content management system with contributed and core modules. It was necessary to create a solution to retrieve the [...]"
tags:
  - "clippings"
---
# Using PHP to Parse eBook Resources from Drupal 6 to Populate a Mobile Web Page
Junior Tidal

The Ursula C. Schwerin library needed to create a page for its mobile website devoted to subscribed eBooks. These resources, however, were only available through the main desktop website. These resources were organized using the Drupal 6 content management system with contributed and core modules. It was necessary to create a solution to retrieve the eBook databases from the Drupal installation to a separate mobile site.

## Introduction

When launching our mobile website, the New York City College of Technology’s (CUNY) Ursula C. Schwerin Library needed to create a page devoted to our subscribed eBooks databases. These resources, however, were only available through our main website. It was then necessary to create a solution to retrieve the eBook databases from our Drupal-based desktop website and onto a separate mobile site. As a solution, we used the PHP Simple HTML DOM Parser. This free PHP framework allows administrators to parse, scrape, or extract, content from HTML pages.

## Drupal’s Core and Extended Modules

The eBook resources are stored within the Drupal content management system (CMS). Using the extended Drupal modules, Content Creation Kit (CCK) and Views, in conjunction with the core Taxonomy module, allowed the development of a dynamically generated eBooks resource page. This type of e-resource management was selected because of its flexibility and ease of use with library website administrators. Updating these resources only requires filling out a few form fields within the browser, and the parameters of Drupal’s Views module automatically organize and sort these resources for end-users’ consumption.

The technique to store this information stems from the work of Leo Klein. Klein has provided an online tutorial on the creation of a library database page using Drupal \[[1](https://journal.code4lib.org/articles/#note1)\]. Using the CCK we created a Drupal 6 custom content type, aptly titled eBooks, to store information on our electronic resources. This includes the title of the resource, URL, description, and subjects pertaining to that database.

The Taxonomy core module allows content types to be categorized with words and phrases, chosen by librarians. In this case, we assigned a category of “Type” for electronic resources, designating which ones were specifically eBooks. This taxonomy is used by the Views module to differentiate between resource types.

The Views module is used to display the page of eBook resources. Views pulls the taxonomy types “electronic resources” and “eBooks” to render the page for end-users. The page displays the attributes of each resource in alphabetical order. A pull-down menu is also available to display resources for specific subject types. The subject categories are also populated from the Taxonomy core module.

[![](https://journal.code4lib.org/media/issue18/Tidal/viewsconfig.png)](https://journal.code4lib.org/media/issue18/Tidal/viewsconfig.png)

**Figure 1.** Screenshot of the Views configuration for our desktop A to Z database page.

[![](https://journal.code4lib.org/media/issue18/Tidal/viewsdisplay.png)](https://journal.code4lib.org/media/issue18/Tidal/viewsdisplay.png)

**Figure 2.** How end users see our databases A to Z page, rendered by Views.

## Mobile Website

The library’s mobile website is based off of the jQuery Mobile framework (http://jquerymobile.com/). This framework was chosen because of its mass compatibility with a variety of mobile devices. At first, we developed a mobile site utilizing Drupal themes, mirroring the library’s desktop site. This was not an ideal situation. The Drupal theme that was used for mobile devices was overwhelming, providing all of the content of the desktop site in one huge menu. Additionally, this iteration of the site was not compatible with a number of mobile devices and phones. Some devices did not trigger the “switch” to alternate between the Drupal mobile theme and the desktop theme. As a result, we developed a mobile site that displays only selected information and links from the main desktop site. This includes the CUNY web OPAC, mobile friendly e-resources, contact information, and information such as library hours and directions.

Since many vendors are creating mobile versions of their resources, we felt it necessary to have a mobile specific page to collect them all. The Pew Research Center noted that Overdrive, a distributor of eBooks for libraries, saw a mobile device usage increase of 22% in 2011 \[[2](https://journal.code4lib.org/articles/#note2)\]. Noting this trend, we created a web page specifically for mobile electronic resources, eBooks, and iOS specific apps. In creating this, we found that a lot of information was being recreated on the mobile site. This could lead to potential problems, such as inconsistencies between the desktop and mobile sites, as well as the unnecessary maintenance of updating two separate sites with the same information.

The mobile framework is independent and separate from the library’s Drupal site. The two platforms do not share the same database, making it difficult to share content. In order to populate the page containing eBook resources, we needed to pull that content from the desktop site. This would alleviate redundant maintenance and ensure a consistency between the two sites. This is where the PHP Simple HTML DOM Parser comes into play.

[![](https://journal.code4lib.org/media/issue18/Tidal/mobiledisplay.png)](https://journal.code4lib.org/media/issue18/Tidal/mobiledisplay.png)

**Figure3.** jQuery Mobile Framework Displaying eBook Resources.

## PHP Simple HTML DOM Parser

The PHP Simple HTML DOM Parser , available at http://simplehtmldom.sourceforge.net/, is a utility which can be used to extract HTML contents and elements from a web page. Based on the parameters that are programmed into the PHP script, either HTML tags or the contents between tags may be extracted. Once this information is scraped, it can be arranged at the administrator’s discretion.

The parse library, a component of the PHP Simple HTML DOM Parser, contains a number of examples on how to code a PHP parse page. Using these as an example, and looking at how the Views module creates HTML pages, it took some trial and error to program a page that would parse our Drupal site. The process works like this: The program opens the live HTML page. It then identifies the specific div and span tags that indicate which elements are eBooks. Once these eBooks are found, the program “scrapes” and stores specific attributes being used. This includes the title, URL, and description. The final step is to display this stored content in jQuery Mobile-friendly HTML output.

Here is the source code of the scraper we wrote, using the PHP Simple HTML DOM Parser library:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36 | `<?php`  `include_once``(``'simple_html_dom.php'``); `  `function` `loadEbooks(){`  `$i` `= 0;`  `$j` `= 1;`  `foreach``(``$html``->find(``'span[class=field-content] a'``) ``as` `$eBook``) {`  `if``(``$i``%2==0){`  `$item``[``'title'``]     = ``$html``->find(``'span[class=field-content] a'``, ``$i``)->plaintext;`  `$item``[``'URL'``]    = ``$html``->find(``'span[class=field-content] a'``, ``$j``)->href;`  `$eBooks``[] = ``$item``;`  `}`  `$j``++;`  `$i``++;`  `}`  `$listBooks` `= ``'<ul data-role="listview" data-inset="true" data-filter="false" data-theme="b">'``;`  `for``(``$k` `= 0; ``$k` `< (``$i``/2); ``$k``++){`  `$listBooks` `.= ``'<li><a href="'``.``$eBooks``&#91;``$k``&#93;&#91;``'URL'``&#93;.``'">'``.``$eBooks``[``$k``][``'title'``].``'</a></li>'``;`  `}`  `$listBooks` `.= ``'</ul>'``;`  `echo` `$listBooks``; `  `}`  `?>` |
| --- | --- |

The following code is the process to collect the eBook resource information. Basically, it opens the HTML file and stores the title and URL of each resource into an array, aptly called $eBooks. The foreach loop cycles and finds anchor tags nested within span tags of class field-content. Notice that the iteration only stores information at every even numbered cycle. Iterations that ran through odd cycles collected extraneous and erroneous information. For example, it would output the title of a resource a second time, linked with a correct and incorrect URL. This is due to the two anchor tags that Views has produced (see below), with the first iteration of the loop harvesting the first anchor tag. The output of the double anchor tags is from the Views configuration. The field’s value of this specific View displays the title as a link:

Also, as part of the PHP Simple HTML DOM Parser, information scraped from a page can possess selected attributes. The title of the resource retrieves a plain text version of the HTML element, whereas the array container of the URL contains the information found in the href attribute of the anchor tag.

| 1  2  3  4  5  6  7  8 | `foreach``(``$html``->find(``'span[class=field-content] a'``) ``as` `$eBook``) {`  `if``(``$i``%2==0){`  `$item``[``'title'``]     = ``$html``->find(``'span[class=field-content] a'``, ``$i``)->plaintext;`  `$item``[``'URL'``]    = ``$html``->find(``'span[class=field-content] a'``, ``$j``)->href;`  `$eBooks``[] = ``$item``;`  `}`  `$j``++;`  `$i``++;` |
| --- | --- |

The following is sample source HTML code of the page that Views produces for our eBooks page. This is what the PHP script is “reading” from the live desktop version of the page.

| 1  2  3  4  5  6  7  8  9  10 | `<``div` `class``=``"view-content"``>`  `<``div` `class``=``"views-row views-row-1 views-row-odd views-row-first"``>`  `<``div` `class``=``"views-field-field-url-url"``>`  `</``div``>`  `<``div` `class``=``"views-field-field-description-value"``>`  `<``div` `class``=``"field-content"``>Primary sources covering the non-fiction published works of leading African Americans. Also includes interviews, journal articles, speeches, essays, pamphlets, letters and other fugitive material.`  `</``p``></``div``>` |
| --- | --- |

The code that displays the eBooks entries on the mobile site is found below. This code creates a list item specific for the jQuery mobile framework, utilizing its unique tag classes and attributes. It constructs a hyperlink to the eBook resource using the title as a link text out of the information found within the array container.

| 1  2  3  4  5  6 | `$listBooks` `= ``'<ul data-role="listview" data-inset="true" data-filter="false" data-theme="b">'``;`  `for``(``$k` `= 0; ``$k` `< (``$i``/2); ``$k``++){`  `$listBooks` `.= ``'<li><a href="'``.``$eBooks``&#91;``$k``&#93;&#91;``'URL'``&#93;.``'">'``.``$eBooks``[``$k``][``'title'``].``'</a></li>'``;`  `}` |
| --- | --- |

## Applicability

The technique to scrape and parse information from a HTML page has been long practiced. We believe that the compatibility of using a PHP scraper to collect information depends entirely on the framework in which the source material is presented. That is, if the resources to be read are displayed in a consistent layout, uniformly coded in HTML, and can be accessed through a standard, non-SSL or otherwise encrypted connection, then the script should be able to retrieve and re-display this information.

There is an obstacle in deploying this technique. It may become difficult if there are numerous tags in the source HTML that the script must navigate, so it’s advised that content should use the least number of HTML tags possible. Otherwise, it may be necessary to code a script that utilizes conditional statements to wade through the HTML file. In other words, if there are a limited number of classes or ids with simple naming conventions, then it would be easier to code a working script. Additionally, it is necessary to have access to the HTML source code to properly code a script. Having the names of the various div and span class names may not be enough information to create a parse script.

It may also be possible for this parse script to be used with other websites. Drupal 7 (or other content management systems) could be used as an HTML source to extract resource content. If resources are displayed using named span and div tags, then it should be possible to scrape the contents of that page. If the Views configuration within Drupal 7 is similar to the output of the Views configuration of Drupal 6, then this solution should be usable for these two different Drupal versions. This has not been tested, however, so the results may not be the same.

The jQuery Mobile framework also has parsing functionality built into its API. This may be used as an alternate solution to scrape external information for a mobile site. However, the author was unaware of the function in the framework. Additionally, there exists Drupal 7 modules that support the jQuery framework and scraping (jQuery Mobile module and Example Web Scraper, respectively), as well as a jQuery Mobile theme. However, these extensions are in alpha and beta development stages and may not be adequate for a live production site.

## Conclusion

This PHP parse solution exports the eBook resources from our library’s desktop site and displays it in a separate mobile site. This is extremely useful, as library administrators do not need to maintain two separate sites, reducing redundant maintenance. Parsing can also be used for other platforms, and other CMS-based sites. It should also be noted that the source information may not be restricted to just eBook resources, encouraging further use for a wide range of applications.

## Code

Before using this code, PHP Simple HTML DOM Parser must be installed on your server.

[eBookScraper](https://journal.code4lib.org/media/issue18/Tidal/code/eBookScraper.txt)

## Resources

PHP Simple HTML DOM Parser SourceForge Page – [http://simplehtmldom.sourceforge.net/](http://simplehtmldom.sourceforge.net/)

## Notes

[1](https://journal.code4lib.org/articles/#ref1). Klein, L. (05/15/2010). Screencast: Creating a library database page with Drupal. [http://chicagolibrarian.com/node/262](http://chicagolibrarian.com/node/262)

[2](https://journal.code4lib.org/articles/#ref2). Libraries, patrons, and e-books \[Internet\]. Updated June 22, 2012\]. Washington DC: Pew Internet and American Life Project; \[cited 2012 June 26\]. Available from [http://libraries.pewinternet.org/files/legacy-pdf/PIP\_Libraries\_and\_Ebook\_Patrons%206.22.12.pdf](http://libraries.pewinternet.org/files/legacy-pdf/PIP_Libraries_and_Ebook_Patrons%206.22.12.pdf)

## About the Author

Junior Tidal (jtidal@citytech.cuny.edu) is the Multimedia and Web Services Librarian and Assistant Professor for the Ursula C. Schwerin Library at the New York City College of Technology of the City University of New York. His research interests include usability, web metrics, and information architecture. Originally from Whitesburg, Kentucky, he has earned a MLS and a Master’s in Information Science from Indiana University.
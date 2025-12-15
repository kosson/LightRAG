---
title: "Rasmuson Library DVD Browser:  Fun with Screen Scraping and Drupal"
source: "https://journal.code4lib.org/articles/469"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-12-15
created: 2025-01-10
description: "The DVD Browser is a simple application that lets library patrons browse movie covers, titles, and reviews. It works by screen scraping the the Rasmuson Library catalog for DVD movies and dumps the data into a Drupal MySQL database. This paper describes the process of setting up the DVD Browser."
tags:
  - "clippings"
---
# Rasmuson Library DVD Browser:  Fun with Screen Scraping and Drupal
Ilana Kingsley, Mark Morlino

The DVD Browser is a simple application that lets library patrons browse movie covers, titles, and reviews. It works by screen scraping the the Rasmuson Library catalog for DVD movies and dumps the data into a Drupal MySQL database. This paper describes the process of setting up the DVD Browser.

## Introduction

The [Rasmuson Library DVD Movie Browser](http://uaflibrary.us/moviebrowser/) was developed because our library patrons were unhappy with the search function of our SIRSI/Dynix library catalog. Patrons told us they wanted to be able to browse movie covers and titles, and the library catalog did not meet their needs.

The DVD Browser is a simple application that screen scrapes the Rasmuson Library catalog for DVD movies and dumps the data into a Drupal MySQL database. \[[1](https://journal.code4lib.org/articles/#note1)\] Drupal is a content management system (CMS) which runs on MySQL/PHP. The DVD Browser application could have been built without Drupal, but since our Library Web site runs on Drupal and because Drupal has many useful features, such as RSS for new items, tagging, and user comments, we decided to store the data within the Drupal CMS.

Our first version of the DVD browser ran on Drupal 4.7 and used PHP to screen scrape the catalog. We found that the easiest way to port the DVD browser to Drupal 6.5 was to rewrite the entire script. The jump from 4.7 to 6.5 was big, and there were some significant changes within Drupal, specifically the change for custom templates to use the CCK module instead of the Flexinode module.  We found that the Flexinode to CCK converter did not work well, and decided to re-create the entire system. The script was rewritten in Perl.

This paper describes the process of setting up the DVD Browser.  The screen scraping script [provided](https://journal.code4lib.org/articles/#code) may be repurposed for your needs. If your library uses a different library catalog vendor, the concepts presented below should work with minor modifications to the code.

## What the Application Does

1. A Perl script screen scrapes the library catalog for new DVDs.
2. The script temporarily stores the data in a text file and gathers additional information about the movie, such as the movie cover and genre, from other Web sites.
3. The data is dumped into a Drupal MySQL database.
4. The end user is able to browse and search for DVDs.

## Requirements

- Perl
- MySQL
- Drupal 6.X
- Drupal Modules: CCK, FileField, ImageField, ImageAPI, Link
- PHP 5.2 (required for ImageAPI)
- GD (configured to support JPG) or **ImageMagick**

## Drupal Configuration

The Rasmuson Library DVD Browser uses Drupal 6.5 for its backend. Besides the core Drupal modules, which are automatically added when installing Drupal, we installed the following modules.

1. [CCK (Content Construction Kit) module](http://drupal.org/project/cck) and its child modules:
1. [FileField](http://drupal.org/project/filefield)
2. [ImageField](http://drupal.org/project/imagefield)
3. [Link](http://drupal.org/project/link)
4. [ImageAPI](http://drupal.org/project/imageapi)
2. [Views](http://drupal.org/project/views)

The DVD Browser requires configuration of five areas within Drupal. They are content types, taxonomy, views, blocks, and theme templates. Each section is described below.

### Content Type Creation

Drupal Content Types are used to represent a specific type of content and provide a content-input template so that content providers can add, edit, and delete data without knowing how to program or code. Drupal automatically installs two basic Content Types, Page and Story. In order to modify these existing Content Types or create your own, the CCK module must be installed.

We created a Content Type named “Movie,” which contains the following settings and fields:

<table><tbody><tr><th colspan="2">Initial Settings</th></tr><tr><th colspan="2">Identification</th></tr><tr><td><strong>Name:</strong> Movie</td><td>The human-readable name for this content type. The name is required and must be unique.</td></tr><tr><td><strong>Type</strong>: movie</td><td>The machine-readable name for this content type. The name is required and must be unique.</td></tr><tr><td><strong>Description</strong>: A DVD for the DVD browser.</td><td>The description is not required. It is used to help content providers select an appropriate template.</td></tr><tr><th colspan="2">Submission form settings</th></tr><tr><td><strong>Title field label</strong>: Title</td><td>The default name for this required field is Title.</td></tr><tr><td><strong>Body field label</strong>:</td><td>The default name for this field is Body; however, when creating a custom Content Type, it’s often best to omit this field by leaving it blank.</td></tr><tr><td></td><td></td></tr><tr><th colspan="2">Workflow settings</th></tr><tr><td><strong>Default options</strong>:<p><strong>*</strong> Published<br>Promoted to Front Page</p></td><td>The default options for Published and Promoted to Front Page are checked. We want to keep the Published option checked, so that when a new movie is added to the database it’s automatically published. We’ve deselected the Promoted to Front Page option; however, since we’re using the Views module to present data, checking or unchecking this option has no visible effect to the end-user.</td></tr></tbody></table>

<table><tbody><tr><th colspan="4">Fields</th></tr><tr><th>Label</th><th>Field Name</th><th>Type</th><th>Description</th></tr><tr><td>Taxonomy</td><td>Taxonomy module form</td><td></td><td></td></tr><tr><td>Menu settings</td><td>Menu module form</td><td></td><td></td></tr><tr><td>Title</td><td>Node module form</td><td></td><td>The main title of the DVD. Note, the <strong>Title </strong>field is required and is not stored in Drupal’s Content Type table (e.g, moviecontent_type_movie). It is stored in the node table.</td></tr><tr><td>Alternative Title</td><td>field_dvdb_alt_title</td><td>Text</td><td>If the title is not in English, then the English title of the movie, if known.</td></tr><tr><td>Sort Title</td><td>field_dvdb_sort_title</td><td>Text</td><td>The title of the movie without words like “A”, “The”, “Le”, “La.” This field is used for sorting the movies.</td></tr><tr><td>Record ID</td><td>field_dvdb_record_id</td><td>Text</td><td>The unique ID number associated with the item in the library catalog.</td></tr><tr><td>Call Number</td><td>field_dvdb_call_number</td><td>Text</td><td>The call number of the DVD.</td></tr><tr><td>Short Summary</td><td>field_dvdb_short_summary</td><td>Text</td><td>Information about the movie, taken from the screen scrape.</td></tr><tr><td>Long Summary</td><td>field_dvdb_long_summary</td><td>Text</td><td>Information about the movie, taken from the screen scrape.</td></tr><tr><td>IMDB Code</td><td>field_dvdb_imdb_code</td><td>Text</td><td>If applicable, the IMDB number for the movie.</td></tr><tr><td>RT Code</td><td>field_dvdb_rotten_tomatoes_code</td><td>Text</td><td>If applicable, the Rotten Tomatoes number for the movie.</td></tr><tr><td>Cover</td><td>field_dvdb_cover</td><td>Image</td><td>A thumbnail of the DVD cover.</td></tr></tbody></table>

**Note:** Items in **gray** were automatically created by Drupal. Items in black were fields that we created.

### Taxonomy Creation

The DVD Browser’s Perl script grabs the genre classification of a movie from the Internet Movie Database (IMDB) and dumps this information into the Drupal database. In order for the script to input data into the database, we needed to create a vocabulary using Drupal’s [Taxonomy](http://drupal.org/handbook/modules/taxonomy) module.

When setting up a Drupal Vocabulary, you can associate Content Types with a specific Vocabulary. We created a vocabulary named Genre and associated it with the Movie Content Type.

### View and Block Creation

The [Views](http://drupal.org/handbook/modules/views) module allows you to pull data from the Drupal database and output it in different ways. The DVD Browser uses Views to output movies to two sidebar [Blocks](http://drupal.org/node/17170), the Genre block, the Most Recent block,and the #-Z header block.

### Theme Templates

Much documentation has been written about [theming Drupal sites](http://drupal.org/theme-guide). Whether you use an out-of-the box theme (e.g., Garland), a third party theme (e.g., Newsflash), or create your own theme, you’ll probably need to customize the node.tpl.php template.

An out-of-the-box node.tpl.php template usually outputs the content of a node with the following statement:

| 1  2  3 | `<div ``class``=``"content"``>`  `<?php ``print` `$content``; ?>`  `</div>` |
| --- | --- |

The statement doesn’t include <div /> tags that can be used for formatting content with CSS (Cascading Style Sheets). For example, the following content is displayed using the Zen out-of-the box node template, node.tpl.php.

![image](https://journal.code4lib.org/media/issue5/kingsley/figure_1.png)

**Figure 1:** DVD listing: Zen Template

For the DVD browser, we used [Zen starter theme](http://drupal.org/project/zen) as the basis of our own theme. We modified node.tpl.php to use <div /> tags for most of the Drupal database fields. Below is a screen shot of the same movie, but using the modified file.

![image](https://journal.code4lib.org/media/issue5/kingsley/figure_2.png)

**Figure 2:** DVD listing: UAF Modified Zen theme

## The Screen Scrape

The DVD Browser gathers the Call Number, Title, Short Summary, and Long Summary by screen scraping the Rasmuson Library catalog. It then gathers additional information, the Long Summary, Genre, and DVD Cover from the [Internet Movie Database (IMDB)](http://www.imdb.com/), [Rotten Tomatoes](http://www.rottentomatoes.com/), and [FreeCovers.net](http://www.freecovers.net/). This section describes what the Perl script is looking for when gathering data from the catalog and other Web pages.

Initial population of the database takes several days due to the large number of videos owned by the library and because our catalog only displays ten items on a page. The Perl script calls the [catalog URL](http://goldmine.uaf.edu/uhtbin/cgisirsi.exe/x/UAFRAS/x/25?library=UAFRAS&class=ALPHANUM&searchdata=dvd-), processes ten items, and begins again, starting where it left off. Each time the script is called it scrapes the html source code the catalog for information about newly added DVDs and stores the information in a .txt file on the server, for example [DVD-22.txt](http://library.uaf.edu/dvdbexamples/DVD-22.txt).

The script looks at the source code for the case sensitive string **Details**.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19 | `<``tr``>`  `<``td` `class``=``"itemlisting2"` `rowspan``=``"2"` `width``=``"10%"``>`  `<``input` `value``=``"Details"` `name``=``"VIEW^1"` `id``=``"VIEW1"` `class``=``"itemdetails"` `type``=``"submit"``>`  `</``td``>`  `<``td` `class``=``"itemlisting2"``>`  `<``a` `href``=``"/uhtbin/cgisirsi.exe/RTbEt1KHPc/UAFRAS/204850051/20/DVD-22%20VIDEODISC/1/X1002522166/"``>`  `<``strong``>`  `DVD-22 VIDEODISC`  `</``strong``>`  `</``a``>`  `<``br``>Billy's Hollywood screen kiss [videorecording] / Trimark Pictures presents a Revolutionary Eye production ; co-producers, Meredith Scott Lynn and Irene Turner ; produced by David Moseley ; written and directed by Tommy O'Haver.`  `<``br``>&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;nbsp;O'Haver, Tommy.`  `</``td``>`  `<``td` `class``=``"defaultstyle"` `rowspan``=``"2"` `width``=``"100"` `align``=``"left"``>`  `<``img` `src``=``"/WebCat_Images/English/Special/Link/SPACER.gif"` `alt``=``""` `width``=``"100"` `border``=``"0"` `height``=``"1"``>`  `</``td``>`  `</``tr``>` |
| --- | --- |

It then looks for the call number, which occurs three lines after the word **Details.** In the screen shot above, the call number is DVD-22. The script searches for the Title, which occurs just before the case sensitive string **\[videorecording\]**. The text after **\[videorecording\] /** (in this example, “Trimark Pictures presents….”), will be stored in the Drupal database in the Short Summary field. To obtain the Long Summary, the script calls the specific movie (e.g., [http://goldmine.uaf.edu/uhtbin/cgisirsi.exe/x/UAFRAS/x/20/DVD-1/1/X1002522166](http://goldmine.uaf.edu/uhtbin/cgisirsi.exe/x/UAFRAS/x/20/DVD-1/1/X1002522166)) and looks for the case sensitive string **Summary:**.

After getting the Title and Summary from the library catalog, the script attempts to gather the Genre, Long Summary, and Cover from the Internet Movie Database (IMDB), the Summary and Cover from Rotten Tomatoes, and the Cover from FreeCovers.net.

In cases where the program is able to gather multiple summaries, or multiple images for a single DVD we establish an order of preference and only insert one summary or image into Drupal per movie but the extra ones are saved to files in case we want to use them later.

## Conclusion

Our library catalog runs on an Oracle database; however, due to vendor restrictions, instead of easily accessing and repurposing data stored in the Oracle database, we needed to find a work-around to create a useful DVD browsing tool for our patrons.

Feedback about the DVD Browser has been positive. It is a heavily used tool and our patrons find it much easier to use that the library catalog.

Future plans for the DVD Browser include turning on comments and ratings, so that our patrons can add user-generated content.

## Code

There are two files available. The dvd\_browser\_screen\_scraper.pl file continues to be under active development at UAF; future versions will use subroutines and error checking will be refined.

- [node.tpl.php](https://journal.code4lib.org/media/issue5/kingsley/node.tpl.phps) – Our modified template file used for formatting the display of nodes in the DVD Browser.
- [dvd\_browser\_screen\_scraper.pl](https://journal.code4lib.org/media/issue5/kingsley/dvd_browser_screen_scraper.pl.txt) – The Perl script used for screen scraping the library catalog and for gathering data from IMDB, Rotten Tomatoes, and freecovers.net.

## A Word on DVD Covers

The DVD browser stores thumbnail images of DVD covers on a locally hosted server. The Perl script gathers images from Freecovers.net, the Internet Movie database, or Rotten Tomatoes. If an image can not be found for a movie, a “No Image is Available” picture is displayed.

We believe that the use of thumbnail images is covered under the doctrine of fair use. Besek’s (2003) gives a layman’s overview of fair use. She discusses the four factors of fair use as outlined in the *Copyright Law of the United States of America, Section 107. Limitations on exclusive rights: Fair use*. These factors are:

1. “purpose and character of the use;”
2. “nature of the copyrighted work;”
3. “amount and substantiality of the portion used in relation to the copyrighted work as a whole;” and
4. “effect of the use upon the potential market for or value of the copyrighted work.”

Applying these factors to the DVD Browser, we believe that:

1. The “purpose and character of the use” is educational. We are an academic library that has built an Internet search application that helps our students search DVD movies owned by the library.
2. The “the nature of the copyrighted work” is creative. Creative works, compared with factual works, generally have a stronger case of copyright infringement. However, similar to the *Kelly v. Arriba Soft Corp.* case analysis by Donohue (2002), “works that have been previously published, lend themselves more readily to their fair use.” Movie art work is published in a variety of formats such as posters, DVD covers, animations, and commercials.
3. The “amount and significance of the portion used in relation to the copyrighted work as a whole” is insignificant. We are providing a low resolution copy of an image.
4. The “effect of the use upon the potential market for or value of the copyrighted work” is insignificant. As in the *Kelly v. Arriba Soft* case and the *Perfect 10 v. Google* case, the images are transformative in nature. The images are being used as a tool to help students select and search for information in an academic setting.

## Note

[\[1\]](https://journal.code4lib.org/articles/#note1) SIRSI/Dynix has a command line tool, as well as a reporting tool, that could have allowed us to export the MARC records from our catalog, however due to administrative reasons, this option was not available to us.

## References

Ayazi, Sara. “Search Engines Score Another Perfect 10: The Continued Misuse of Copyrighted Images on the Internet.” North Carolina Journal of Law and Technology 7.2(2006): 367. 2 Oct. 2008 < [http://jolt.unc.edu/abstracts/volume-7/ncjltech/p367](http://jolt.unc.edu/abstracts/volume-7/ncjltech/p367)\>.

Besek, June M. “Copyright: What Makes a Use “Fair”?” Educause Review 38.6 (2003): 12-13. 2 Oct. 2008 < [http://connect.educause.edu/Library/EDUCAUSE+Review/CopyrightWhatMakesaUseFai/40446](http://connect.educause.edu/Library/EDUCAUSE+Review/CopyrightWhatMakesaUseFai/40446)\>.

Donohue, Kelly. “Court Gives Thumbs-up for Use of Thumbnail Pictures Online.” Duke Law and Technology Review 0006 (2002). 2 Oct. 2008 <[http://www.law.duke.edu/journals/dltr/articles/2002dltr0006.html](http://www.law.duke.edu/journals/dltr/articles/2002dltr0006.html)\>.

U.S. Copyright Office. Copyright Law of the United States of America and Related Laws Contained in Title 17 of the United States Code. 2 Oct. 2008 <[http://www.copyright.gov/title17/92chap1.html#107](http://www.copyright.gov/title17/92chap1.html#107)\>.

## Acknowledgements

We’d like to thank Eugeniy Kalin for his programming efforts in creating the first version of the DVD Browser using Drupal 4.7. Thanks to Jim Hassel and David Basham for coming up with the idea for the DVD Browser and for the prototype coding.

## About the Authors

Ilana Kingsley, Web Librarian  
University of Alaska Fairbanks Rasmuson & BioSciences Libraries  
ilana.kingsley@uaf.edu

Mark Morlino, Systems Administrator/Programmer  
University of Alaska Fairbanks Rasmuson & BioSciences Libraries  
mrmorlino@alaska.edu
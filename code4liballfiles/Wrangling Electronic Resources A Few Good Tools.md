---
title: "Wrangling Electronic Resources: A Few Good Tools"
source: "https://journal.code4lib.org/articles/2634"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-03-23
created: 2025-01-10
description: "There are several freely available tools today that fill the needs of librarians tasked with maintaining electronic resources, that assist with tasks such as editing MARC records and maintaining web sites that contain links to electronic resources. This article gives a tour of a few tools the author has found invaluable as an Electronic Resources [...]"
tags:
  - "clippings"
---
# Wrangling Electronic Resources: A Few Good Tools
Brandy Klug

There are several freely available tools today that fill the needs of librarians tasked with maintaining electronic resources, that assist with tasks such as editing MARC records and maintaining web sites that contain links to electronic resources. This article gives a tour of a few tools the author has found invaluable as an Electronic Resources Librarian.

## Introduction

The position of electronic resources librarian is one that many libraries have added to their staff in the last decade. A librarian who accepts this position quickly discovers how varied the duties are, and how quickly they can change due to new technologies or staffing changes. The responsibilities of this position will vary depending on the library, but may include web design and maintenance, creating instructional or technical support materials, and maintaining electronic resources.

There are numerous free tools available to assist librarians working with electronic resources in various tasks and to help them get started on large projects fairly quickly and easily. This article examines two categories of tools, MARC editors and link checkers, that I have found helpful over the last few years when it comes to completing these tasks. The tools have the added benefit of being available at no cost.

## MarcEdit: A Tool for Editing MARC Records

One of the biggest challenges of working with electronic resources is editing MARC records. MarcEdit allows you to do bulk editing in a snap, and the interface is extremely intuitive and user-friendly. MarcEdit is developed by Terry Reese and is available for Microsoft Windows and other operating systems that can use the 2.0 version of the .NET framework. The MARCEDIT-L email list hosted by George Mason University at [http://listserv.gmu.edu/cgi-bin/wa?A0=marcedit-l](http://listserv.gmu.edu/cgi-bin/wa?A0=marcedit-l) is a valuable resource for solving tricky problems when using MarcEdit.

MarcEdit may be used to customize MARC records provided by vendors by adding an EZProxy prefix to the link in the 856 field. There are a few ways to do this using MarcEdit. Once the file is opened in MarcEdit, under *Tools* there is an option to *Edit Subfield Data*. To edit the subfield using a regular expression, enter the field (*856*), the subfield (*u*), *^b* for field data, the EZProxy information in the *replace with* line, select *use regular expression*, and click on *Replace Text*. Using a regular expression, a caret followed by the letter b will automatically append the proxy information to the beginning of the 856 $u subfield.

[![Figure 1: MarcEdit's Edit Subfield to insert EZProxy prefix screenshot](https://journal.code4lib.org/media/issue9/klug/marcedit_1_small.png)](https://journal.code4lib.org/media/issue9/klug/marcedit_1.png)

Figure 1: MarcEdit: Using Edit Subfield to insert EZProxy prefix

The basic *Replace* function located under *Edit* can also be used to complete this task. The electronic resource URL stem can be entered in the *Find What* field, and the URL stem with the EZProxy in front of it can be entered in the *Replace With* field. Clicking the *Replace All* option will make the change.

[![Figure 2: MarcEdit's Find and Replace screenshot](https://journal.code4lib.org/media/issue9/klug/marcedit_2_small.png)](https://journal.code4lib.org/media/issue9/klug/marcedit_2.png)

Figure 2: MarcEdit Find & Replace

MarcEdit may also be used to edit the call number field in electronic book records. Libraries may choose to add something like *\*(ONLINE)* instead of the letters *eb* which are usually included at the end of electronic book call numbers. Using MarcEdit, *\*(ONLINE)* can replace *eb* and be added to the end of the call number fields very easily. This can be done by clicking on Tools and Edit Subfield Data. To edit the call number subfields enter the field (*050*), the subfield (*b*), *eb* for field data, *\*(ONLINE)* in the *replace with* line, and click on *Replace Text*. For ILSs that generate call numbers based on 050, when the electronic book records are loaded and the holdings are created, *\*(ONLINE)* will be included at the end of the call numbers.

[![Figure 3: MarcEdit's Edit Subfield to change call number screenshot](https://journal.code4lib.org/media/issue9/klug/marcedit_3_small.png)](https://journal.code4lib.org/media/issue9/klug/marcedit_3.png)

Figure 3: MarcEdit: Using Edit Subfield to change call number

MarcEdit is also very useful for adding fields to records. Many libraries have added Directory of Open Access (DOAJ) journals and other free resources to their catalogs. A 500 field denoting free access, for example, can be easily added to these records. This can be done by clicking on *Tools* and *Add Field*. Enter the field (*500*), the field data (*\\\\$aFree access.*), and click on *Add Field*.

[![Figure 4: MarcEdit's Add/Delete Field Utility](https://journal.code4lib.org/media/issue9/klug/marcedit_4_small.png)](https://journal.code4lib.org/media/issue9/klug/marcedit_4.png)

Figure 4: MarcEdit: Add/Delete Field Utility

If there is a more complicated project where each MARC record may need to be examined individually, MarcEdit is still a huge time-saver. Rather than having to pull up the records one at a time in the cataloging module, you can run through the file in MarcEdit and make edits much faster.

MarcEdit is such a powerful editing tool that I haven’t found anything comparable. However, another tool that might work for making simple MARC edits in a pinch is Writer from OpenOffice.org. Writer is word processing software that is included as part of the OpenOffice.org suite of products, and a great tool to use to produce documentation. OpenOffice.org is available for a variety of platforms including Microsoft Windows, Macintosh OS/X, and Linux. Once the OpenOffice.org suite has been installed, open the MARC file in Writer. A simple find/replace can be done by clicking on *Edit*, and *Find & Replace*. If there were a group of MARC records with a 500 field that needed to be edited, for example, it would be possible to do a blanket find/replace using this tool. The file would then be saved as a text file and named with an .mrc extension.

## Tools for Checking Links

Many Electronic Resources Librarians will find themselves in the position of maintaining Web pages, lists, or databases containing links to various electronic resources. When maintaining these resources, it is essential to make sure that all web page links are functional. There are few things more frustrating to patrons than dead links. As we all know, online content is volatile. An electronic resource that is available today may not necessarily be available tomorrow. Xenu’s Link Sleuth (often shortened to Xenu) is software designed for Microsoft Windows that requires the user to download the application to their computer. Xenu is particularly helpful for checking links on library web resource pages. In order to check links on a particular page, open up Xenu, click on *File*, and select *Check URL*. Enter the URL of the page and check off the option to *Check External Links*. Click on more options to set the *Maximum Level* to *0*. Selecting *Maximum Level 0* means that Xenu will check all links on that page only. Higher levels will go deeper and check links on pages that your page links to, and so on. You can also select what to include on the report, such as broken links, redirected URLs, and orphaned files. When the process is complete, the report can be viewed as a webpage, or exported to a tab-separated file. The tab-separated file is a text file that can be pasted or imported into Excel or another spreadsheet application. Once the data is in Excel, it can be sorted by status and the URLs that may have moved or are no longer available can be checked.

Xenu can be particularly helpful for checking open access resources such as Directory of Open Access Journal (DOAJ) titles. Many libraries are choosing to add MARC records for open access resources to their online catalogs. Xenu can be used to check these links on a regular basis in order to make sure they are working properly. How you use Xenu to check links in the library catalog may depend on your ILS and whether or not you have hosted links. If you do not have hosted links, you can use a tool like Access to generate a list of titles and URLs to check. Our electronic journal links are hosted by a vendor. The link in the MARC record links to the e-journal A-Z list and not directly to the e-journal. To check hosted links using Xenu, first a spreadsheet of all electronic journal links needs to be generated from the vendor client center. This spreadsheet has a resource column that can be filtered in Excel, or similar spreadsheet application such as OpenOffice.org’s Calc, to get a list of DOAJ titles and links by selecting the *Sort & Filter* option and *Filter*. In the resource column click on the filter and deselect everything. Once everything is deselected, click on *Directory of Open Access Journals*. Copy and paste the filtered data into a new spreadsheet and save it. The column with the URLs can be copied and pasted into a text file. Open Xenu and select *File* and *Check URL List*. Browse to the text file and click Open. Xenu will begin checking links immediately.

[![Figure 5:  Xenu showing list of URLs to check](https://journal.code4lib.org/media/issue9/klug/xenu_1_small.png)](https://journal.code4lib.org/media/issue9/klug/xenu_1.png)

Figure 5: Xenu showing list of URLs to check

Once the check is complete, a tab delimited report can be exported from Xenu and saved. It can be imported into a new Excel spreadsheet or copied directly from the tab separated file.

[![Figure 6:  Xenu's Export to TAB screenshot](https://journal.code4lib.org/media/issue9/klug/xenu_2_small.png)](https://journal.code4lib.org/media/issue9/klug/xenu_2.png)

Figure 6: Xenu Export to TAB function

The exported information can now be pasted into the saved spreadsheet so the URL and status information from Xenu will match up with the URL and e-journal title in the Excel spreadsheet. The status column can then be sorted to pinpoint those URLs with potential access problems. When using Xenu, it is helpful to test a few different methods to find what works best. I found that reading the documentation created by Consortium of Academic and Research Libraries in Illinois (CARLI) was incredibly helpful when it came to finding what worked best for us. \[[1](https://journal.code4lib.org/articles/#note1)\]

Two other options for web page link checking are W3C Link Checker and Link Valet. You do not need to download any software to use these tools. To use W3C Link Checker, go directly to the W3C Link Checker web site and enter the URL. When link checking is complete, a report will be generated with a list of redirects and possible broken links. W3C Link Checker generates a very thorough report. It provides the line number where the link is found in the HTML code, the link status, and notes about the link status. The report cannot be downloaded, but it can be copied and pasted into a tool like Writer or Word.

To use Link Valet, go directly to the web site, enter the URL, and select *OK*. A full report provides a list of every link on the page on the left-hand side and color coded messages on the right that indicate whether or not the page is OK or has been moved either temporarily or permanently. This report cannot be downloaded, but as with W3C Link Checker it can be viewed as a web page or copied and pasted into Excel.

## Conclusion

The number of electronic resources available continues to grow and so does the need for librarians to find tools to manage them. With many library budgets being cut, it is important for librarians to seek out tools that are available at no cost. Most libraries employ only one electronic resources librarian, therefore this person must be proactive when it comes to seeking opportunities for collaboration with librarians in similar positions. There are several ways electronic resources librarians, or any library staff member working with electronic resources, can stay informed and up-to-date on free tools. Joining and monitoring e-mail discussion lists is essential and a great way to communicate with other librarians and find out about tools your colleagues are using to complete projects \[[2](https://journal.code4lib.org/articles/#note2)\]. Conferences, library publications, and blogs are also great ways to find out about free tools that will be invaluable when navigating through the exciting world of electronic resources.

## About the Author

The author currently works at Texas Woman’s University Library as an Electronic Resources Librarian. She received an MLS from Texas Woman’s University in 2005 and an M.S.Ed. from University of Nebraska-Kearney in 2007. The author may be reached via E-mail at bklug@mail.twu.edu.

## List of Tools

- Link Valet – [http://htmlhelp.com/tools/valet/](http://htmlhelp.com/tools/valet/)
- MarcEdit – [http://people.oregonstate.edu/~reeset/marcedit/html/index.php](http://people.oregonstate.edu/~reeset/marcedit/html/index.php)
- W3C Link Checker – [http://validator.w3.org/checklink](http://validator.w3.org/checklink)
- Writer (part of the Open Office Suite) – [http://www.openoffice.org/product/writer.html](http://www.openoffice.org/product/writer.html)
- Xenu’s Link Sleuth – [http://home.snafu.de/tilman/xenulink.html](http://home.snafu.de/tilman/xenulink.html)

## Reference/Notes

\[[1](https://journal.code4lib.org/articles/#note1text)\] Consortium of Academic and Research Libraries in Illinois. (2006). *URL checking with Xenu software*. Retrieved January 11, 2010, from [http://www.carli.illinois.edu/mem-prod/I-Share/cat/using\_Xenu.pdf](http://www.carli.illinois.edu/mem-prod/I-Share/cat/using_Xenu.pdf)

\[[2](https://journal.code4lib.org/articles/#note2text)\] Relevant mailing lists will vary by library, but the ones I have found very helpful would be our ILS listserv ([VOYAGER-L](http://el-una.org/mailing-lists/voyager-mailing-lists/#voy-l)), [AUTOCAT](http://listserv.syr.edu/archives/autocat.html), the [EZproxy Listserv](http://www.oclc.org/support/documentation/ezproxy/list.htm), the MarcEdit support in technical and instructional matters listserv ([MARCEDIT-L](http://listserv.gmu.edu/cgi-bin/wa?A0=marcedit-l)), RefWorks Administrators Listserv ([RWLIST](http://www.refworks.com/content/path_manage/faqs.asp#q1)), Medical Libraries Discussion List ([MEDLIB-L](http://www.mlanet.org/discussion/medlib_l_faq.html)), and the Serials in Libraries Discussion Forum ([SERIALST](http://www.uvm.edu/~bmaclenn/serialst.html)).
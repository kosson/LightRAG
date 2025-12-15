---
title: "‡biblios: An Open Source Cataloging Editor"
source: "https://journal.code4lib.org/articles/657"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-12-15
created: 2025-01-10
description: "‡biblios is an open source cataloging editor designed to allow libraries to perform copy and original cataloging in a web based environment. ‡biblios allows users to search for, edit, and save bibliographic records in the MARC21/MARCXML formats. It also allows users to send records directly to integrated library systems such as the Koha ILS. Where [...]"
tags:
  - "clippings"
---
# ‡biblios: An Open Source Cataloging Editor
Chris Catalfo

‡biblios is an open source cataloging editor designed to allow libraries to perform copy and original cataloging in a web based environment. ‡biblios allows users to search for, edit, and save bibliographic records in the MARC21/MARCXML formats. It also allows users to send records directly to integrated library systems such as the Koha ILS. Where most MARC editors are part of an integrated library system (and therefore require logging in), ‡biblios allows users to catalog with an open source standalone system available anywhere via a web browser. Unlike other cataloging editors, it offers an attractive user interface for searching, saving and editing cataloging records. This article describes the system architecture and design of ‡biblios.

## History

‡biblios was a project to develop a web based cataloging editor, suitable for use with the Koha ILS or with other ILSs, that I put forward to LibLime as a proposal for the 2007 Google Summer of Code. When it was accepted, I served as lead programmer for the project and Joshua Ferraro, CEO at LibLime, mentored the work as the system architect. At the end of the Summer of Code, we had a minimally functional web application able to search several Z39.50 targets and edit records in an integrated MARC editor.

The name, ‡biblios, pronounced “biblios,” has no special meaning, although it obviously invokes the idea of “books.” The double-dagger symbol is commonly used as a subfield delimiter in cataloging, and forms an ideal logo for ‡biblios because the symbol can be represented in both graphical and textual formats. Inspiration for this use of a symbol in a logo was drawn from the Ümlaut and \*Asterisk projects.

Since the Google Summer of Code, ‡biblios has continued to be developed at LibLime, Inc. In the past year of work, we have made a number of enhancements and changes. We switched from using a Perl CGI script to search Z39.50 targets to using the PazPar2 metasearch tool developed by IndexData. This has greatly improved the searching experience. It has also enabled us to show search facets, which PazPar2 provides as part of its webservice. Besides these changes, we also added the capability to define macros to run on records, using JavaScript to manipulate MARCXML records.

## Systems Architecture

The system architecture of ‡biblios consists of:

- a rich internet application using the ExtJS toolkit and Google Gears which provides the user interface
- a set of CGI scripts providing server side services, and
- the PazPar2 search middleware

The rich internet application provides the front end user interface and allows the user to search, select, and edit records. Google Gears is a web browser extension which allows web applications to store data in an SQLite database on the user’s computer. This allows ‡biblios to save records to the user’s computer. The CGI scripts provide back end functionality (such as exporting records), while PazPar2 allows searching multiple Z39.50 targets.

  
![Figure 1: System Architecture Diagram](https://journal.code4lib.org/media/issue5/catalfo/fig1_systems_architecture.png)  

**Figure 1: System Architecture**

### Front end

The front end is comprised of a single web page, developed using the ExtJS \[[1](https://journal.code4lib.org/articles/#note1)\] JavaScript toolkit. The user never navigates away from this single page while using ‡biblios; in this sense it is like a desktop application.

ExtJS provides a very rich set of widgets to use in constructing web applications. ‡biblios uses most of these widgets in its user interface, where each area utilizes an ExtJS Panel. These panels are frames on the screen which can contain other widgets such as grids or sub panels. There are several TreePanels for interacting with hierarchical data such as Z39.50 search targets or folders containing saved records. TreePanels can be loaded dynamically via AJAX (as they are when presenting search facets) or they can be loaded from the Google Gears database (as when displaying folders of saved records). There are a number of GridPanels for interacting with tabular data (such as search results or lists of search targets). The GridPanels provide for handling record selection via mouse clicks or arrowing down, as well as for sorting columns of data. Finally ‡biblios uses several dialog windows for actions such as uploading files.

The user interface is designed to emulate a web-based email client. The left-hand sidebar offers a selection of ‘resources’ (Z39.50 search targets, folders to save records into, and records to create). In the center panel there is generally a grid displaying either search results or records in a folder. When editing a record, the screen changes to show the marc editor.

[![Figure 2: biblios UI](https://journal.code4lib.org/media/issue5/catalfo/fig2_sm_biblios_ui.png)](https://journal.code4lib.org/media/issue5/catalfo/fig2_biblios_ui.png "Figure 2: biblios UI")  

**Figure 2: ‡biblios UI** \[[View full-size image](https://journal.code4lib.org/media/issue5/catalfo/fig2_biblios_ui.png)\]

‡biblios also uses ExtJS’s GridPanels for interacting with bibliographic records and other data stored in the Google Gears database, as well as to view search results. These provide a user interface for interacting with tabular data; they also provide for paging buttons, selecting of records, toolbars, and loading indicators. ExtJS grids can be configured to work with various data sources: simple JavaScript arrays of data, external data sources (with results returned by AJAX calls), or custom data sources. ‡biblios makes use of a custom data store developed for Google Gears to allow for viewing bibliographic records and “search” and “send” targets. It also feeds the Z39.50 search results returned by PazPar2 into an ExJS data store for viewing.

[![Figure 3: biblios ExtJS Widgets](https://journal.code4lib.org/media/issue5/catalfo/fig3_sm_extjs_widgets.png)](https://journal.code4lib.org/media/issue5/catalfo/fig3_extjs_widgets.html "Figure 3: biblios ExtJS Widgets")  

**Figure 3: ‡biblios ExtJS Widgets** \[[View full-size image](https://journal.code4lib.org/media/issue5/catalfo/fig3_extjs_widgets.html)\]

Each action performed in ‡biblios that needs server-side processing uses AJAX requests to send data from ‡biblios and to receive data from the server. In this way there is no need to wait for page reloads to complete actions.

[![Figure 4: biblios Data Flow](https://journal.code4lib.org/media/issue5/catalfo/fig4_sm_data_flow.png)](https://journal.code4lib.org/media/issue5/catalfo/fig4_data_flow.html "Figure 4: biblios Data Flow")  

**Figure 4: ‡biblios Data Flow** \[[View full-size image](https://journal.code4lib.org/media/issue5/catalfo/fig4_data_flow.html)\]

### Use of Google Gears

‡biblios makes use of the Google Gears \[[2](https://journal.code4lib.org/articles/#note2)\] browser plugin for storing of bibliographic records. Google Gears allows the browser to store data from web applications in an SQLite database available to the web application. Each site that makes use of the plugin may create a database and modify that database, but may not modify the databases of other sites. Google Gears was chosen as a means to allow users to view and manipulate records they have previously saved from search results or to view records they have created. When returning to ‡biblios, users are able to view these previously saved records.

Although saving records to the user’s computer (in the form of the embedded SQLite database) is handy, in the future this code may be separated out into a plugin for allowing offline access to records. At times it has proven difficult to manage data in users’ Gears databases because the database may contain stale data, such as configuration data, or the web application may be expecting more recent data. This would also allow browsers which aren’t supported by Google Gears to access the site.

### Use of PazPar2 search middleware

PazPar2 \[[3](https://journal.code4lib.org/articles/#note3)\] is a server developed by IndexData which allows searching multiple Z39.50 databases simultaneously and returning those results via a web service interface. ‡biblios uses Pazpar2 to perform searching of user-defined Z39.50 search targets.

In the original design for searching from ‡biblios using PazPar2, a JavaScript library provided by IndexData was used to communicate with PazPar2 from the web browser. This script makes it possible for the web browser to send requests directly to the PazPar2 server, via a proxy server such as Apache. Because web browsers are forbidden from making AJAX requests to domains or ports other than their own, it is necessary to use a proxy between the browser and the PazPar2 server. Recently ‡biblios has moved to using a Perl proxy script and associated Perl module (paz.pl and PazPar2.pm) to route requests between ‡biblios and PazPar2. This has greatly simplified the JavaScript code in the browser, as it no longer has to deal with maintaining a sessions with PazPar2.

By default, PazPar2 does not include full MARCXML records in the brief metadata it returns for each search result. For ‡biblios , the PazPar2 configuration files were modified so that ‡biblios receives the full record upon performing a search. This retrieval of the full record slightly slows down search performance, but it greatly speeds up previewing and saving records from the search results grid. This modification also allows users to save large batches of records from their search results into either their ‘save folders’ (Google Gears database) or to their computer.

### Use of CGI scripts

‡biblios uses several CGI scripts written in Perl to provide some functionality that is not easily implemented in the browser, or is better implemented on the server.

[![Figure 5: CGI Scripts Diagram](https://journal.code4lib.org/media/issue5/catalfo/fig5_sm_cgi_scripts.png)](https://journal.code4lib.org/media/issue5/catalfo/fig5_cgi_scripts.png "Figure 5: CGI Scripts Diagram")  

**Figure 5: CGI Scripts** \[[View full-size image](https://journal.code4lib.org/media/issue5/catalfo/fig5_cgi_scripts.png)\]

The following CGI scripts are used in ‡biblios :

1. **downloadMarc.pl:** downloads records from ‡biblios to user’s computer This script accepts a POST of MARCXML data. It then uses the Marc-Record suite of Perl modules \[[4](https://journal.code4lib.org/articles/#note4)\] to convert from MARCXML to a user-determined record format that is returned to the browser.
2. **download.pl:** generic handler for downloading temporarily saved records. Returns the name of a temporary file containing MARCXML records (produced by downloadMarc.pl or uploadMarc.pl) to the browser.
3. **exportdb.pl:** exports of Google Gears’ database data to user’s computer ‡biblios sends serialized JSON to this script and the script instructs the browser to download a temporary file containing that serialized JSON. This file may then be saved to the user’s computer and reimported into ‡biblios.
4. **paz.pl:** CGI proxy script for sending requests to PazPar2 search middleware This script acts as a proxy between ‡biblios and the PazPar2 server. It accepts requests from ‡biblios and routes them to a PazPar2 server. It restarts sessions with PazPar2 as required when running new searches.
5. **PazPar2.pm:** a Perl module, originally developed by Galen Charlton for the Koha ILS and subsequently modified to respond to more PazPar2 request types.
6. **uploaddb.pl:** script for uploading data to insert into Google Gears database. Return data uploaded by the user to ‡biblios for entering into Google Gears database.
7. **uploadMarc.pl:** handles uploading of files of MARCXML or MARC21 records into ‡biblios. Accepts a file of MARCXML or MARC21 records, converts them to MARCXML and returns this data to ‡biblios for entering in Google Gears database.
8. **XSLTransform.pl:** accepts a stylesheet and XML data to transform with that stylesheet. Uses the LibXML suite of Perl modules \[[5](https://journal.code4lib.org/articles/#note5)\] to perform the XSLT transformation. ‡biblios uses this to generate the MARC21 editor and generate previews of MARCXML records.
9. **kohaws.pl:** proxies web service requests from the ‡biblios koha plugin to an actual Koha installation. The Koha installation responds with an XML document and this script returns that document to ‡biblios for further processing or display.
10. **authoritiessruproxy.pl:** proxies SRU queries to an SRU server. Used for querying authority records when editing an authority-controlled field in the marc editor.

The choice of Perl as CGI scripting language for ‡biblios was pre-determined by its having started as a cataloging editor for the Perl-based Koha ILS. Perl also has robust support for MARC21 record handling. The CGI scripts require the following Perl modules:

- CGI
- LWP::UserAgent
- CGI::Carp
- MARC::Record
- MARC::Batch
- MARC::File::XML
- File::Temp
- File::Basename
- JSON
- CGI::Session
- Data::Dumper
- XML::LibXML
- XML::LibXSLT
- XML::Simple

## Communication with Integrated Library Systems

‡biblios has the ability to retrieve records from and save records to external Integrated Library Systems (ILS). As of this writing there exists a plugin for the Koha ILS \[[6](https://journal.code4lib.org/articles/#note6)\]. The plugin queries Koha for the most recent version of a record found in the search results. The user is able to edit this record and then send it to Koha. Koha saves the record to its internal database and returns the record (with possible additions of item record tags) to ‡biblios for further editing.

The plugin makes use of a simple web services API developed by Galen Charlton, Vice President of Development at LibLime, Inc. The API calls for the following methods, implemented in a RESTful way by the ILS:

- **authenticate:** authenticate the ‡biblios application to the Koha ILS
- **bibprofile:** retrieve a list of tags and subfields from Koha which must be present or which must have specified values (such as item location subfields)
- **retrieve:** given a biblionumber, retrieve the most recent version of this record from Koha’s internal database
- **save:** save a MARCXML record from the ‡biblios editor to Koha

The API is fully documented on the ‡biblios website \[[7](https://journal.code4lib.org/articles/#note7)\].

## Generation of MARCXML Editor

Since MARCXML is a simple XML format, ‡biblios generates an editor for MARCXML records using an XSLT stylesheet. The stylesheet generates input fields for each of the subfields, indicators and tag numbers in a record. It also generates a fixed fields editor for MARC21 records. This editor use an XML description of MARC21 fixed fields to gather data from the leader, 006, 007, and 008 fields and to generate HTML `<select>` elements for each of those. Once the basic HTML for the editor is generated, further JavaScript processing creates ExtJS combo box elements for certain parts of the record (language and country fixed fields elements and authority controlled fields).

[![Figure 6: biblios MARC Editor](https://journal.code4lib.org/media/issue5/catalfo/fig6_sm_biblios_marc_editor.png)](https://journal.code4lib.org/media/issue5/catalfo/fig6_biblios_marc_editor.png "Figure 6: biblios MARC Editor")  

**Figure 6: ‡biblios MARC Editor** \[[View full-size image](https://journal.code4lib.org/media/issue5/catalfo/fig6_biblios_marc_editor.png)\]

At several times over the last year, generating the editor using either XSLT or JavaScript has been explored. For a time ‡biblios relied on JavaScript, as there had been difficulties in getting Internet Explorer to to pull in multiple stylesheets into the browser’s XSLT transformer. The JavaScript generated worked fine for a while. Recently we have been experimenting with opening multiple records at a time (each in its own tab). Generating multiple editors with JavaScript took too much processing time, and so I have moved to a server side XSLT transformation: this gets around cross browser problems and is still fairly speedy.

## ‡biblios as an Open Source Project

Recently LibLime launched a website \[[8](https://journal.code4lib.org/articles/#note8)\] dedicated to ‡biblios as an open source project. With this website we hope to foster a community of users and developers around the project. At this website we have provided some documentation as well as downloads, mailing lists and access to a public Git repository (Git \[[9](https://journal.code4lib.org/articles/#note9)\] is a version control system) to allow contributions from interested developers.

Here are some other ideas for code contributions to ‡biblios:

- A nice “getting started” project would be to add record counts to ‡biblios’ save folders
- A “network storage” plugin to save records to an arbitrary network location
- A means of searching non-Z39.50 databases and integrating those results into ‡biblios’ search results grid
- Alternative types of MARCXML editors: for example an editor which allows use of the editing syntax supported by Terry Reese’s MarcEdit \[[10](https://journal.code4lib.org/articles/#note10)\]

To get involved in developing ‡biblios (either the core web application or plugins), visit the ‡biblios web site at [http://biblios.org/](http://biblios.org/) for more detailed developer documentation and sign up to the biblios-dev and biblios-users Google Groups.

## Future Directions

There are a number of features we would like to develop (or see developed) for ‡biblios. Chief among these are support for other metadata formats and plugins to communicate with ILSs besides Koha.

As of this writing, ‡biblios supports editing MARCXML records (and ‡biblios ‘ fixed fields editor supports only MARC21 fixed field elements). In the future ‡biblios should support editing other types of metadata used in libraries. Editing records is accomplished by means of a plugin-type architecture, so it is quite feasible to develop a plugin to edit MODS records, for example.

The web services API supported by ‡biblios is quite simple and therefore should present a low barrier to entry for other ILSs. I would like to put in place a plugin for the Evergreen ILS. Of course, if ILSs start supporting Jangle ([Singer 2008](https://journal.code4lib.org/articles/#singer2008)), communicating with them should become even easier as there will be a well defined API for performing the kinds of actions ‡biblios’ koha plugin performs now.

## Conclusion

‡biblios is a web based cataloging editor in the form of a rich Internet application. The system architecture consists of a desktop-like web browser based front end developed using ExtJS, the PazPar2 search middleware server and a series of CGI scripts providing server side functionality. ‡biblios communicates with PazPar2, as well as with remote ILSs through the use of AJAX requests.

‡biblios will be useful to libraries who perform copy cataloging and would like to use records available from Z39.50 servers. For performing original cataloging, ‡biblios can be supplemented with additional library-defined MARCXML templates. Since ‡biblios supports macros on MARCXML records, it may also be used for batch processing.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Ext JS. [http://extjs.com/](http://extjs.com/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Google Gears. [http://gears.google.com/?hl=en](http://gears.google.com/?hl=en)

\[[3](https://journal.code4lib.org/articles/#ref3)\] PazPar2. [http://www.indexdata.dk/pazpar2/](http://www.indexdata.dk/pazpar2/)

\[[4](https://journal.code4lib.org/articles/#ref4)\] MARC::Record CPAN Module. [http://search.cpan.org/~mikery/MARC-Record-2.0.0/lib/MARC/Record.pm](http://search.cpan.org/~mikery/MARC-Record-2.0.0/lib/MARC/Record.pm)

\[[5](https://journal.code4lib.org/articles/#ref5)\] LibXML CPAN Module. [http://search.cpan.org/~pajas/XML-LibXML-1.69/LibXML.pod](http://search.cpan.org/~pajas/XML-LibXML-1.69/LibXML.pod)

\[[6](https://journal.code4lib.org/articles/#ref6)\] Koha Open Source ILS. [http://www.koha.org/](http://www.koha.org/)

\[[7](https://journal.code4lib.org/articles/#ref7)\] ‡biblios ‘send’ web service API. [http://biblios.org/docs/biblios-send-api](http://biblios.org/docs/biblios-send-api)

\[[8](https://journal.code4lib.org/articles/#ref8)\] ‡biblios Open Source Cataloging. [http://biblios.org/](http://biblios.org/)

\[[9](https://journal.code4lib.org/articles/#ref9)\] Git – Fast Version Control System. [http://git.or.cz/](http://git.or.cz/)

\[[10](https://journal.code4lib.org/articles/#ref10)\] MarcEdit. [http://oregonstate.edu/~reeset/marcedit/html/](http://oregonstate.edu/~reeset/marcedit/html/)

## References

[Singer, Ross and James Farrugia](https://journal.code4lib.org/articles/#ref_singer2008) (2008) “Unveiling Jangle: Untangling Library Resources and Exposing them through the Atom Publishing Protocol.” **The Code4Lib Journal 4** [http://journal.code4lib.org/articles/109](https://journal.code4lib.org/articles/109)

## About the Author

[Chris Catalfo](https://journal.code4lib.org/articles/) is a developer at LibLime, working on the ‡biblios open source metadata editor.
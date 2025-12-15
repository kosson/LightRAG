---
title: "Case Study: Using Perl and CGI Scripts to Automate a Quality Control Workflow for Scanned Congressional Documents"
source: "https://journal.code4lib.org/articles/6731"
author:
  - "[[The Code4Lib Journal]]"
published: 2012-06-25
created: 2025-01-10
description: "The Law Library Digitization Project of the Rutgers University School of Law in Camden, New Jersey, developed a series of scripts in Perl and CGI that take advantage of the open-source module PerlMagick to automatically review the image quality of scanned government documents. By implementing these procedures, Rutgers was able to save staff working hours [...]"
tags:
  - "clippings"
---
# Case Study: Using Perl and CGI Scripts to Automate a Quality Control Workflow for Scanned Congressional Documents
Doreva Belfiore

The Law Library Digitization Project of the Rutgers University School of Law in Camden, New Jersey, developed a series of scripts in Perl and CGI that take advantage of the open-source module PerlMagick to automatically review the image quality of scanned government documents. By implementing these procedures, Rutgers was able to save staff working hours for document quality control by an estimated 25% percent from the previous manual-only workflow. These scripts can be adapted by novice Perl and CGI programmers to review and manipulate large numbers of text and image files using commands available in PerlMagick and ImageMagick.

## Project Background

In 1997, the Law Library of the Rutgers University Camden Campus began a project to provide open web access to digital legal materials from the State of New Jersey, other U.S. states, and the United States federal government. The Camden Library has been registered as a depository library of the Government Printing Office for many years. Through an agreement with the GPO, the Library is allowed to scan congressional documents to a set of mutually agreed upon standards (600 dpi minimum resolution, uncompressed TIFF image format, and full-text searching, among others) for digitization and presentation via the Rutgers Camden Digital Law Library website. The project began digitizing congressional hearings and committee prints dated from the mid 1970’s through 1999, and expects to continue and expand its scope in the coming years.

The author was involved in the initial phase of the project described in this article, and her code is enclosed in the appendix. After accepting a position at another university, she is no longer working directly with the project. The project code is now being managed by [John Joergensen](http://camlaw.rutgers.edu/bio/943/), Reference Librarian at Rutgers Camden Law Library.

## Legacy Processing

For digitization, each printed congressional document is cut at the binding with a guillotine-blade cutter. Every document is labeled with its corresponding Library of Congress control number. If no LCCN exists, an internal 8-digit document identifier is assigned. Multi-volume sets are divided into sections and labeled with either one or two trailing letters of the alphabet, i.e. 12345678a through 12345678az.

Panasonic KV-S2026C sheet-feed duplex scanners are used to scan individual pages and generate TIFF image files of each document page. Work-study students of the Law School are charged with scanning bundles of cut documents and saving the resulting TIFF images to a central network server.

Prior to this project, one full-time staff member from Technical Services and one part-time graduate student intern from a local library school were tasked with manually performing quality control on every scanned congressional document. The former quality control workflow included:

- Reviewing thumbnail images for every scanned page in the document,
- Confirming that the total number of scanned images corresponded with the number of pages in the print original,
- Manually re-scanning any mis-scanned pages, missing pages, or oversize fold-out maps and supplementary materials,
- Manually copying and pasting a MARC record from the library catalog into a text file for use during post-processing.

After checking, completed congressional documents are prepared for web presentation by a series of automated Perl scripts which were run by the Digital Librarian:

- Each scanned page is run through an OCR program to create a text file of its contents,
- TIFF images are converted to PDF files for an alternative web format.
- A single multi-page PDF is also created containing the entire document,
- An RDF file is created for OAI-harvesting and use on the Semantic Web,
- Each document is uploaded to a web server directory and indexed using Swish-E open-source indexing software.

Once processed, documents can be easily searched via the [Congressional Documents](http://lawlibrary.rutgers.edu/us-congressional-documents) page of the Library website.

## Problems

The Panasonic RTIV software can be adjusted to account for deskewing of the image, auto-cropping document edges, adjusting brightness levels and other minor corrections. However, despite regular cleaning and maintenance of the scanning equipment, problems occur which sometimes cause documents to fail a quality control check.

Dirt and wear on the scanner rollers can cause both horizontal and vertical lines on the scanned images. Wear on the roller can impede the paper flow through the scanner and cause blank pages with a large horizontal drag mark on the top of the pages. Failure to remove security tape (“tattle-tape”) or to cut off all of the binding glue during the guillotining process can cause pages to stick together, altering the final document page count. The presence of fold-out maps and supplementary materials can also skew the final page count.

[![](https://journal.code4lib.org/media/issue17/belfiore/belfiore_qa_figure1.png "click for high quality image view")](https://journal.code4lib.org/media/issue17/belfiore/belfiore_qa_figure1_full.png)

**Figure 1.** Example of a scanning error – dirt and wear on scanner rollers causing black horizontal lines

We estimate that approximately 12 hours of combined staff time per week was dedicated to manual quality control procedures. Even at that level of staffing, the number of scanned documents quickly exceeded the ability of the staff members to perform quality control, and the bottleneck created a large backlog of documents. This work grew out of a need to address such bottlenecks by developing procedures to automate as much of the quality control workflow as possible.

## Solution

ImageMagick is a free image manipulation program that can be run on various platforms (Windows, Macintosh, UNIX). PerlMagick is the corresponding Perl module for scripting. The Digital Library Project has previously used PerlMagick for automated image brightening (cf. [Belfiore, 2011](https://journal.code4lib.org/articles/#cite1)) and we hypothesized that its power for image evaluation could be harnessed for purposes of quality control. We developed a series of Perl and CGI scripts as follows:

First, we needed to ensure that documents were in a standard file and folder format for automatic processing. Occasionally, students misnamed files or folders during the scanning process. In addition, there have been cases where the RTIV scanning software settings have been inadvertently changed and documents were scanned as PDF’s instead of TIFF images. We created a Perl script that uses regular expressions to detect any misnamed documents or folders or to detect the presence of PDF files and move the document folders to a “PROBLEM” directory for manual remediation. See [Appendix Script 1](https://journal.code4lib.org/articles/#note1) for the entire Perl script.

Once the pre-check runs, we run a second Perl script, which performs various functions. It first scans the folder for multivolume documents and identifies them by their naming convention of LC control number plus one or two alphabetic characters. It moves any multivolume folder to a secondary staging folder for review. Because the MARC record for a multi-volume set records the number of volumes and the total number of pages, it cannot be used to estimate the total number of pages per volume. A staff member (or student) must still gather the pagination information, but we developed an easier way to accomplish the task. The person tasked with this activity can launch a CGI script from any web browser that will prompt him or her to enter the first and last pages of the document, along with the number of prefatory pages. This data is stored in a very small temporary text file that is read in lieu of the MARC record and used for pagination calculations. See [Appendix – Script 2](https://journal.code4lib.org/articles/#note2) for the entire CGI script.

Next, gdocpagecheckonly.pl checks if the congressional document folder already contains a valid MARC record in a catalog file in the form of “.cat”. If not, it automatically gathers a MARC record for the document from the library catalog via a WGET command. For each document, if the document is not a numbered volume of a multivolume set, it then opens the catalog file and parses the 300 physical description field of the MARC record to identify the correct number of pages in the document, and evaluates the document against the official page count. For multivolume sets, it reads the small test file created by the multivp.cgi script. In evaluating the number of pages, the script takes into account whether the number of pages of prefatory material is even or odd, in order to account for the extra blank sheet after an odd number of pages. Likewise, it takes into account whether the number of total pages is even or odd, in order to account for a final blank sheet after an odd number of body pages.

If, after the calculations, the total number of pages counted in the document folder matches the number on the MARC record exactly, the document folder is moved to a second staging folder for the final quality control check. If the document folder contains more image files than the MARC record states, the document is moved to a secondary staging folder for further checking. If the document folder contains fewer image files than is expected by the MARC record, the document folder is moved into the “PROBLEM” directory for manual checking by a staff member. See [Appendix Script 3](https://journal.code4lib.org/articles/#note3) for the entire godcpagecheckonly.pl script.

Because the documents sometimes contain extra blank pages at the end of the content, the quality control process must account for folders that contain trailing blanks in the pagination calculations. By segregating documents with more pages than specified in the MARC record, we can apply a third Perl script to determine whether extra pages are acceptable blanks or mis-scanned pages. The script, gdocblankcheck.pl, first uses ImageMagick to evaluate a small cross-section “slice” of a known reference image of a blank sheet and measures the total brightness of the file. The script then checks each document folder and repeats the same pagination check as in the previous script. For documents with an odd number of prefatory pages, the next even number page is checked via ImageMagick for the presence of a blank. When a similar “slice” of the file is checked, if the brightness level of the suspect scanned page matches that of the known reference blank within a small tolerance range, that page is marked as a good “known blank” and entered into a hash for future reference. The same procedure is conducted for a suspect even page after an odd number of total document pages.

But how does one account for extra blank pages that may occur at the end of a scanned document? The script has already calculated the total of number of pages that should be present and accounts for one possible blank file at the end of an odd-numbered final page. For an amount of N extra pages, the script loops through an ImageMagick check routine N times to see if those pages are indeed blank. Every time, it sets a variable flag to mark each pass. When the flag reaches the final number, if all of the pages are evaluated as “good blanks”, the script will allow that document to pass to the next phase of quality control checking. If, however, one of the N extra pages has a brightness value that is too dark and exceeds that of the reference sample (as in a page containing text), it is considered to be non-blank and fails the test. The folder will then be moved to the “PROBLEM” directory for manual evaluation by a staff member.

In the final step of our automated quality control procedure, any documents that have passed the previous checks are located in the final staging folder, which for purposes of clarity is named IMAGECHECK. The final script, gdocimagecheck.pl, begins by using ImageMagick to take the reference values of multiple types of sample documents: blank white pages, very clean scanned text pages, and pages containing dark black lines.

[![](https://journal.code4lib.org/media/issue17/belfiore/belfiore_qa_figure2.png "click for high quality image view")](https://journal.code4lib.org/media/issue17/belfiore/belfiore_qa_figure2_full.png)

**Figure 2.** Example of a clean scanned text file used as a reference sample for the gdocimagecheck.pl script

It continues with the exact same page counting steps as its predecessor. This step is redundant, but serves an important purpose. In this script, any blank pages found after an odd-numbered prefatory page, an odd-numbered final body page, or at the very end of the document are labeled as “good” or “known” blanks. These are stored in a Perl hash table %goodblanks for later lookup. The script then cycles through each document and evaluates each scanned page against the “clean” reference sample of a page of text. If the brightness level falls within a small range of tolerance, it is deemed to be good. If the level is too light, the page may be blank. The page number is then checked against the values stored in the %goodblanks hash table. If the blank page is known to be appropriate, the script allows it to pass and continues. If, however, the blank page is not known, it is marked as a “suspect” file. If the brightness level is too dark, the file is also labeled as “suspect”.

After the script cycles through all the files in a given document, if there are no “suspect” files, the document is cleared to be moved to a final “GOOD” staging directory for further processing for indexing and web presentation. If there are “suspect” files, the document is moved to the “SUSPECT” staging directory where the document can be manually evaluated by a staff member. See [Appendix – Script 5](https://journal.code4lib.org/articles/#note5) for the entire gdocimagecheck.pl Perl script.

## Complications and Lessons Learned

In the course of this project, we experienced some issues which necessitated our breaking this script into modular parts. We initially began with one master script which performed all the actions from downloading the MARC records to checking individual images. Because the Library fileserver, maintained by Library IT services, was running an older version of the Red Hat Linux operating system, we were not able to upgrade to the latest stable version of the ImageMagick software. We experienced high server CPU utilization rates when running any scripts containing ImageMagick, even during non-business hours, and had to stop the use of ImageMagick on that server.

Our solution was to break the script into parts and utilize workstations to run some of the scripts. We run the first two scripts, gdocprecheck.pl and gdocpagecheck.pl, on our production UNIX server. We then use an Ubuntu Linux box that connects to our server using an sshfs link to run the two scripts requiring ImageMagick, gdocblankcheck.pl and gdocimagecheck.pl. In Phase II of the project, described later in this article, planned server hardware and operating systems upgrades allowed us to eliminate redundancies, re-integrate the scripts and run them from one production server.

One benefit we found to modular script development is flexibility. Our project estimates that it takes the script about 3 seconds to check each file. For large documents, it may take over 15-20 minutes per document depending upon server memory and processor speed. Because these scripts are written in a modular fashion, each one can be run independently and multiple scripts could be run at once. This is helpful for a busy digitization project where multiple documents are being scanned and checked on a given day, so that the people scanning the documents are not impacted by the script processing.

Our scripts rely on correct AACR2 cataloging and ISBD punctuation in order to parse downloaded MARC records and to gather pagination information. It is important to note that for approximately 10% of documents, the gdocpagecheckonly.pl script cannot accurately parse the MARC record which will cause the document to fail the page check and be moved to the “PROBLEM” directory. There are various potential causes for this:

- The MARC record is inappropriately coded or is missing information.
- The MARC record is missing ISBD punctuation.
- The MARC record has been coded for a multivolume set but for some reason the document was not labeled as a multivolume part.
- The MARC record is in RDA format.
- The MARC record was not properly downloaded so the catalog file is missing or incomplete in some way.
- The MARC download portion of the script could not match the document to an LCCN number and therefore no catalog file was created.

In any of these cases, the documents are reviewed by a staff member and the MARC records can be re-downloaded or the catalog files re-created manually. In the future, script enhancements can be made that would make multiple passes at reading the 300 line of the MARC file to correct for missing information. The shift from AACR2 to RDA format for cataloging will necessitate future revisions. Our goal, as always, is to limit the time required for staff members to manually review the congressional documents.

Occasionally, a page with very little text will read as a blank file and will be labeled as “suspect”. Further testing and manipulation of the base gdocimagecheck.pl script could refine the size of the sampled “slice” of the page and adjust the brightness tolerance so that partial pages are labeled as “good”.

## Project Phase II

In the intervening months since the author took a position at another university, the Library obtained a server hardware and OS upgrade, such that the scripts are now able to run directly on a Linux server. The Digital Library has created a regular schedule for automated script processing and document triage. [John Joergensen](http://camlaw.rutgers.edu/bio/943/), of the Rutgers Camden Law Library, has streamlined the scripting of the original processing scripts to eliminate redundancies and improve functionality.

For Phase II of this project, the Digital Library is testing a CGI quality evaluation script similar to Amazon’s “Mechanical Turk” that can be used by non-experts (i.e. work-study students) to mark suspect scanned documents as “good” or “bad” and triage them appropriately. The script converts the original TIFF image of a suspect file to a JPG on the fly using ImageMagick and presents it to the user in context on a web page. The user can then view a suspect page along with the preceding and following page, and can navigate between pages like an online reader in order to make a decision about the suspect file. According to the viewer’s decision, the scanned document is automatically moved to a “GOOD” directory for further processing for web presentation, or to a “RESCAN” directory to be sent for rescanning by work-study students. This CGI script can be run from any internet browser and will greatly reduce the time required from Library staff members to review suspect documents.

## Future projects and other ideas

Currently, this set of scripts provides a level of basic processing that identifies potentially problematic documents. The gdocimagecheck.pl script can be extended to handle specific problem cases and triage them appropriately. For example, a finer grain of brightness tolerance or the use of ImageMagick’s image-matching function could be employed to specifically distinguish mis-scanned pages with roller drag-marks (see Figure 3) and automatically send the document to be rescanned. This is useful for scanned congressional documents because there are frequent instances of blank divider pages found in the middle of a document which are not erroneous, and it would be very useful for a quality control script to be able to distinguish acceptable blanks from scanner errors.

[![](https://journal.code4lib.org/media/issue17/belfiore/belfiore_qa_figure3.png "click for high quality image view")](https://journal.code4lib.org/media/issue17/belfiore/belfiore_qa_figure3_full.png)

**Figure 3.** Example of a scanned page with a “roller drag” mark instead of textual content

The author plans to continue to work with ImageMagick and PerlMagick to develop other scripts for digital image quality control that take advantage of the software’s power of image evaluation.

## Conclusions

By taking a fully manual process and automating image checking for large series of uniformly formatted text documents, Rutgers Camden Digital Law Library was able to save approximately 25% of staff time in quality control procedures. The implementation of CGI scripts to review specific “suspect” pages within scanned documents allows the Library to easily offload quality control work to non-expert users such as work-study students, which will further save person-hours from Technical Services and Digital Library staff. The Library’s future goal is to save 50% of total staff time dedicated to quality control for the Congressional Documents Digitization project.

While these scripts may not be appropriate for the quality control and revision of archival materials, manuscripts, or photographs, we feel that they are useful for textual documents that are generally uniformly formatted, such as government documents. As the ImageMagick and PerlMagick software are powerful and highly customizable, their use could be extended to manipulate and evaluate more complex documents and image types than are demonstrated by this project. This software and these scripts are very suitable for libraries and archives that have smaller budgets and limited information technology resources, as they can be edited and developed by staff with a beginning knowledge of Perl and CGI programming.

## References

Amazon.com \[Internet\]. (updated 2012). Amazon mechanical turk: artificial artificial intelligence; \[cited 2012 April 8\]. Available from [https://www.mturk.com/mturk/welcome](https://www.mturk.com/mturk/welcome).

[Belfiore, D. 2011](https://journal.code4lib.org/articles/#call1). Using ImageMagick to automatically increase legibility of scanned text documents. Code4Lib Journal \[Internet\]. \[cited 2012 April 08\]; 14:2011-07-25. Available from: [http://journal.code4lib.org/articles/5385](https://journal.code4lib.org/articles/5385).

Ciornii, Alexandr. \[Internet\]. (updated 2007?). Roman-1.23. CPAN; \[cited 2012 April 08\]. Available from: [http://search.cpan.org/~chorny/Roman/lib/Roman.pm](http://search.cpan.org/~chorny/Roman/lib/Roman.pm).

ImageMagick Studio LLC. \[Internet\]. (updated 2011). ImageMagick: convert, edit and compose images; \[cited 2012 April 08\]. Available from: [http://www.imagemagick.org/script/index.php](http://www.imagemagick.org/script/index.php).

ImageMagick Studio LLC. \[Internet\]. (updated 2011). PerlMagick API; \[cited 2012 April 08\]. Available from: [http://www.imagemagick.org/script/Perl-magick.php](http://www.imagemagick.org/script/Perl-magick.php).

Joergensen, J.P. 2002. The New Jersey courts publishing project of the  
Rutgers–Camden Law Library. Law Library Journal. \[cited 2012 April 08\];94(4):673-689.

Pozkanzer, Jef. \[Internet\]. (updated 2009 July 12). Tiftopnm; \[cited 2012 April 08\]. Available from: [http://netpbm.sourceforge.net/doc/tifftopnm.html](http://netpbm.sourceforge.net/doc/tifftopnm.html).

Thyssen, A. \[Internet\]. (updated 2011 March 15). Examples of ImageMagick usage; \[cited 2012 April 08\]. Available from: [http://www.imagemagick.org/Usage/](http://www.imagemagick.org/Usage/).

## Acknowledgements

The author wishes to thank John Joergensen of the Rutgers University Camden School of Law for his mentoring and guidance.

## Appendix

**N.B.** – the scripts below are original to the project except where enhancements are noted and credited. In certain cases, information regarding specific server addresses and paths has been omitted for security and should be adjusted for the specific needs of the institution. For more information about current scripts, please contact the Rutgers Camden Digital Law Library.

[\[back\]](https://journal.code4lib.org/articles/#ref1)  
[Script 1: normalization pre-check script – gdocprecheck.pl](https://journal.code4lib.org/media/issue17/belfiore/code/gdocprecheck.pl)

[\[back\]](https://journal.code4lib.org/articles/#ref2)  
Script 2: CGI scripts producing web forms to automate the pagination of multivolume government document sets

[Part A: First CGI script page to confirm document – multivp1.pl](https://journal.code4lib.org/media/issue17/belfiore/code/multivp1.pl)

[Part B: Second CGI script page to evaluate pagination – multivp2.pl](https://journal.code4lib.org/media/issue17/belfiore/code/multivp2.pl) **N.B.** – This file was edited by John Joergensen to reduce redundancy and improve functionality. The author wishes to thank Mr. Joergensen for his assistance with this script.

[\[back\]](https://journal.code4lib.org/articles/#ref3)  
[Script 3: Initial MARC record download and page check – gdocpagecheckonly.pl](https://journal.code4lib.org/media/issue17/belfiore/code/gdocpagecheckonly.pl)

[Script 4: ImageMagick script # 1 for checking for extra blank pages – gdocblankcheck.pl](https://journal.code4lib.org/media/issue17/belfiore/code/gdocblankcheck.pl) **N.B.** – this script is written to run under Ubuntu Linux with an established sshfs share called ./camlaw . Adjust this share name to your institution’s needs.

[\[back\]](https://journal.code4lib.org/articles/#ref5)  
[Script 5: Image checking program for quality control – gdocimagecheck.pl](https://journal.code4lib.org/media/issue17/belfiore/code/gdocimagecheck.pl)

## About the Author

Doreva Belfiore received her Masters of Library and Information Science in 2011 from the Drexel University iSchool in Philadelphia, PA. From 2009 to 2011 she worked as a Digital Library and Circulation intern at the Law Library of the Rutgers University School of Law in Camden, New Jersey. She currently works as a Bibliographic Assistant in the Digital Initiatives Department of Temple University Libraries in Philadelphia, Pennsylvania.
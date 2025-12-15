---
title: "Ref2RIS: Importing Word-Processed Bibliographies into Bibliographic Management Software"
source: "https://journal.code4lib.org/articles/6286"
author:
  - "[[The Code4Lib Journal]]"
published: 2012-02-03
created: 2025-01-10
description: "Many who would benefit the most from timesaving bibliographic managers hesitate to adopt the technology due to the difficulties in importing legacy bibliographies developed over years. Existing shortcuts rely on manual reformatting or on re-searching online databases for the records - often almost as laborious as retyping the references. Ref2RIS was developed to automate the [...]"
tags:
  - "clippings"
---
# Ref2RIS: Importing Word-Processed Bibliographies into Bibliographic Management Software
Deborah Fitchett

Many who would benefit the most from timesaving bibliographic managers hesitate to adopt the technology due to the difficulties in importing legacy bibliographies developed over years. Existing shortcuts rely on manual reformatting or on re-searching online databases for the records – often almost as laborious as retyping the references. Ref2RIS was developed to automate the task of converting a bibliography in specific citation styles from common word processing document formats into the widely used RIS format. It uses the Unix stream editor sed and the conversion options of Apple’s textutil. It can be invoked as a series of simple shell commands on any Linux terminal, or more simply as a drag-and-drop Applescript application on MacOS 10.4 or higher.

## Introduction

Bibliographic management software helps users download and organise large amounts of citation data and quickly format references and bibliographies that would take hours to write manually. Academic libraries commonly encourage students and academics to use such software – the University of Canterbury Library, for example, provides particular support for Endnote although some users instead use BibTeX, Zotero, or Mendeley among others.

Other users have manually maintained (sometimes for decades) bibliographies in a typed Word document, and are unwilling to make the shift to Endnote if it means individually retyping or downloading citations for hundreds of references.  They need a user-friendly tool to convert their existing bibliography from a word processing format into a format that can be imported to bibliographic management software.  This article will look at some tools that partially fill this need and introduce Ref2RIS, including sample scripts and output.

## Existing Tools

Various approaches have been taken to importing legacy bibliographies into dedicated bibliographic management software.

Instructions are available to remap data from Excel spreadsheets ([How can I transfer… \[2010\]](https://journal.code4lib.org/articles/#ref7)) or Access databases ([Gear 2002](https://journal.code4lib.org/articles/#ref5)).  While not novice-friendly, these processes are relatively quick and produce good results as the data comes pre-structured.  More complex is the process is to remap data from a text bibliography ([Garret 2008](https://journal.code4lib.org/articles/#ref4)): this requires manual reformatting of each citation to separate elements of the citation with tabs and multiple authors with slashes, and may not save much time over simply retyping the data.

Parsing the citations is a second approach, essentially automating the remapping process. The challenge is to identify whether a given text string is an author, article/chapter title, or journal/book title, or a given number refers to a year, issue, or page number, since citation styles vary wildly in how they order and delimit these fields.

Erik Hetzner’s method ([Hetzner 2008](https://journal.code4lib.org/articles/#ref6)) uses hidden Markov models to powerful effect, identifying fields within a citation regardless of citation style, but the software is more suitable for use in digital libraries than by casual users.  Two other useful parsing tools work regardless of citation style, using Conditional Random Fields, but these also suffer from the lack of a user-friendly interface. FreeCite ([FreeCite](https://journal.code4lib.org/articles/#ref3)) can work with either a single reference copy-and-pasted into a web interface or with multiple references through an API; in either case the XML output is not directly importable into bibliographic managers.  ParsCit ([Kan et al. 2004](https://journal.code4lib.org/articles/#ref8)) is available for Linux, MacOS and Windows and outputs to RIS format among others, but requires installation and knowledge of UNIX to use; its web interface is not reliably available for more than one reference at a time.

More user-friendly is MakeBib ([Takaki \[date unknown\]](https://journal.code4lib.org/articles/#ref14)), which converts to BiBTeX format.  Besides a downloadable perl script, MakeBib has a web interface which accepts copy-and-pasted text containing multiple references separated by blank lines.  The sample conversions work well, but it’s not clear which citation styles are supported – testing it with APA produced garbled results and results from Clinica Chimica Acta are cut off in the middle of the journal title.

A third approach is to automate the process of looking the citations up in one or more online databases and download the bibliographic data from there.  Lookup tools will usually include some parsing of citation data to facilitate this, but are less affected by variations in citation style as they need only identify key fields such as authors and titles. Similarly, typos in input or errors in parsing are less likely to scramble results – as long as a result can be found, the data downloaded is clean.

Two tools that look up references in multiple databases are Lemon8 ([Suhonos 2009](https://journal.code4lib.org/articles/#ref13)) and ParaCite ([\[2004\]](https://journal.code4lib.org/articles/#ref9)).  Lemon8 is an editing tool that converts from word processing formats into XML-based publishing layout formats, including citation editing facilities; it requires installation on a web server using Apache, and being intended for use in journal publishing it doesn’t allow export of citation data to a bibliographic manager.  ParaCite consists of a web form that accepts a single reference at a time and searches for the article in various databases from which the user would need to download citation data manually.

With other tools, APIs may limit the number of queries that can be made, which can be a problem for a large bibliography.  Two examples of such a limitation are the CrossRef Simple Text Query ([CrossRef \[updated 2010\]](https://journal.code4lib.org/articles/#ref2)), which retrieves a DOI for each reference searched, but requires registration and limits users to 1000 references per month; and Wizfolio, which searches PubMed and can be used to convert to RIS or BiBTeX ([Brekhus \[updated 2010\]](https://journal.code4lib.org/articles/#ref1)), but is limited to 50 references per month.

The most user-friendly lookup tool is HubMed Citation Finder which runs as a web form accepting copy-and-pasted text ([Transferring a Word bibliography…\[date unknown\]](https://journal.code4lib.org/articles/#ref16)) and converts to RIS and BiBTeX formats among others.  Some initial editing may be required to delimit records in the input, but the main limitation is that it searches only in PubMed, so is only suitable in some subject areas.  This is a general weakness with lookup tools:  even tools that search a large number of databases will perform poorly on bibliographies that contain significant amounts of older or local material, grey literature, or titles that remain unindexed for other reasons.

Outside of disciplines indexed by PubMed, then, there is a lack of text-based bibliography conversion tools suitable for students, academics, and library staff who are not expert computer users. Ref2RIS was developed to fill this need.

## Ref2RIS

Ref2RIS takes the citation parsing approach, allowing it to work with citations regardless of where they might be indexed.  It is fundamentally a series of find/replace commands, searching on patterns specific to a given citation style and replacing with the appropriate RIS tags ([RIS Format…\[updated 2011\]](https://journal.code4lib.org/articles/#ref11)) to create a new file that can be imported directly into most bibliographic managers.

The core functions are packaged as an AppleScript application, letting the user either drag-and-drop the bibliography or bibliographies to be converted onto the Ref2RIS icon or run Ref2RIS and be prompted to select the file(s) to convert.  After TestSystem() checks that all necessary components are available, the user is prompted to select the citation style which the bibliographies were written in, and ConvertBib() converts the bibliographies. Finally CleanUp() removes files created as intermediate stages of the conversion process, leaving only the original bibliography and the final RIS file.

### Ref2RIS AppleScript (version 1.2)

```
property theLocation : ""
property existsBib : 0
set existsBib to 0
property theConverted : "Nothing."

if existsBib is equal to 0 then
   set allSources to (choose file with prompt "Select the bibliographies to convert:" default location (path to documents folder) with multiple selections allowed)
   open allSources
end if

on open allSources
   TestSystem()
   set existsBib to 1
   set theConverted to "Nothing."
   set theSed to (choose file with prompt "Select the style to convert from (in ref2ris/ConversionFiles/):" default location (theLocation))
   repeat with theSource in allSources
      ConvertBib(theSource, theSed)
   end repeat
   display alert "Successfully converted:" message theConverted buttons {"Thank you!"} default button 1
end open

on TestSystem()
   try
      do shell script "echo no | sed s:no:yes:"
   on error
      display alert "Cannot continue" message "A key component (sed) is not installed in your system (/bin/sh)." as warning buttons {"Oh dear..."} default button 1 cancel button 1
   end try
   try
      do shell script "textutil -help"
   on error
      display alert "Cannot continue" message "A key component (textutil) is not installed in your system (/bin/sh)." as warning buttons {"Oh dear..."} default button 1 cancel button 1
   end try
   if theLocation is equal to "" then
      tell application "System Events" to set theLocation to (POSIX path of container of (path to me) & "/ConversionFiles/")
   end if
   try
      do shell script "/bin/ls " & quoted form of theLocation
   on error
      tell application "System Events" to set theLocation to (POSIX path of container of (path to me) & "/ConversionFiles/")
      try
         do shell script "/bin/ls " & quoted form of theLocation
      on error
         display alert "Ref2RIS can't find the folder ConversionFiles." message "Click Find to locate it, or download Ref2RIS again." as warning buttons {"Cancel", "Find"} default button 2 cancel button 1
         set theLocation to POSIX path of (choose folder with prompt "Select the folder ConversionFiles:")
      end try
   end try
   try
      do shell script "/bin/ls " & quoted form of theLocation & "markup.sed"
   on error
      display alert "Ref2RIS can't find markup.sed" message "Click Find to copy it into the folder ConversionFiles, or download it again." as warning buttons {"Cancel", "Find"} default button 2 cancel button 1
      set toMove to POSIX path of (choose file with prompt "Select the file markup.sed:")
      do shell script "cp " & quoted form of toMove & " " & quoted form of theLocation
   end try
end TestSystem

on ConvertBib(theSource, theSed)
   set theBibliography to quoted form of POSIX path of (theSource as text)
   set theStyle to quoted form of POSIX path of (theSed as text)
   set thePrepared to quoted form of theLocation & "prepared.rtf"
   set theMarkerUp to quoted form of theLocation & "markup.sed"
   set theMarkedUp to quoted form of theLocation & "markedup.rtf"
   set theInput to quoted form of theLocation & "markedup.txt"
   set theOutput to quoted form of (do shell script "echo " & theBibliography & " | sed s:\\.[^.]*$:\\.ris:")
   repeat 1 times
      set theBibName to name of (info for theSource)
      tell application "Finder" to set theExtension to (name extension of theSource)
      set goodFileTypes to {"txt", "html", "htm", "rtf", "doc", "docx", "wordml", "odt"}
      if (goodFileTypes does not contain theExtension) then
         display alert "Cannot convert " & theBibName message "Sorry, " & theBibName & " is not in a supported format." as warning buttons {"Cancel", "Continue with other files"} default button 2 cancel button 1 giving up after 30
         exit repeat
      end if
      try
         do shell script "textutil -convert rtf -encoding UTF-8 " & theBibliography & " -output " & thePrepared
         do shell script "sed -f " & theMarkerUp & " < " & thePrepared & " > " & theMarkedUp
         do shell script "textutil -convert txt -encoding UTF-8 " & theMarkedUp
         do shell script "LANG=C sed -f " & theStyle & " < " & theInput & " > " & theOutput
      on error errMsg number errNum
         CleanUp()
         display alert "Error converting " & theBibName message "Error number " & errNum & ": " & errMsg as warning buttons {"Cancel", "Continue with other files"} default button 2 cancel button 1 giving up after 30
         exit repeat
      end try
      CleanUp()
      if theConverted is equal to "Nothing." then
         set theConverted to (theBibName)
      else
         set theConverted to (theConverted & return & theBibName)
      end if
   end repeat
end ConvertBib

on CleanUp()
   try
      do shell script "rm " & quoted form of theLocation & "prepared.rtf"
      do shell script "rm " & quoted form of theLocation & "markedup.rtf"
      do shell script "rm " & quoted form of theLocation & "markedup.txt"
   end try
end CleanUp
```

The bulk of the process is done by the four shell commands executed in the ConvertBib() subroutine. These commands accomplish the reference conversion in 4 simple steps:

1. Convert the incoming file to RTF
2. Convert the RTF formatting markup to HTML
3. Convert the marked up file to TXT
4. Convert the TXT citations into tagged RIS format

#### 1\. Convert the incoming file to RTF

The first shell command deals with the fact that the user’s bibliography may be in any of a number of file formats.   For the final conversion the file will need to be in .txt format, but converting directly into txt would lose formatting needed to parse the citation – such as italics, bold, and underlines – as well as formatting used to add meaning in specific disciplines – such as italics for species names and superscripts and subscripts for chemical formulae.

To avoid this, Ref2RIS first makes use of Apple’s textutil utility (included since MacOS 10.4) ([textutil(1)…\[updated 2004\]](https://journal.code4lib.org/articles/#ref15)) to convert from txt, html, rtf, rtfd, doc, docx, wordml, odt, or webarchive into RTF format:

```
textutil -convert rtf -encoding UTF-8 inputFileName -output outputFileName
```

#### 2\. Convert the RTF formatting markup to HTML

The second shell command then executes a sed script (markup.sed) to standardise the bibliography by converting relevant RTF format tags into HTML-style tags, and smart quotes into plain quotes. Sed is a Unix stream editor ([Pement 2003](https://journal.code4lib.org/articles/#ref10)), which searches and replaces strings line by line through an inputted file.  Commands use regular expressions and take the basic form:

```
s/oldText/newText/
```

More complex commands are available: for example to search globally on a line, to delete lines, to find a string in the presence or absence of another string, or to create loops.  A sed script consists of a series of these commands and is invoked with the command:

```
sed -f scriptFileName < inputFileName > outputFileName
```

##### markup.sed (version 1.3)

```
# Italics
s/\\f[0-9]*\\i /\/g
s/\\f0\\i0 /\<\/i\>/g
s/{\\i \([^}]*\)}/\\1\<\/i\>/g
s/\\i /\/g
s/\\i0 /\<\/i\>/g

# Bold
s/\\f[0-9]*\\b /\/g
s/\\f0\\b0 /\<\/b\>/g
s/{\\b \([^}]*\)}/\\1\<\/b\>/g
s/\\b /\/g
s/\\b0 /\<\/b\>/g

# Underline
s/{\\ul \([^}]*\)}/\\1\<\/u\>/g
s/\\ul /\/g
s/\\ulnone /\<\/u\>/g

# Superscript
s/{\\super \([^}]*\)}/\\1\<\/sup\>/g
s/\\super \([^\]*\)\\nosupersub /\\1\<\/sup\>/g

# Subscript
s/{\\sub \([^}]*\)}/\\1\<\/sub\>/g
s/\\sub \([^\]*\)\\nosupersub /\\1\<\/sub\>/g

# Smartquotes etc
s/\\\'91/'/g
s/\\\'92/'/g
s/\\\'93/"/g
s/\\\'94/"/g
s/\\\'96/-/g
s/\\\'97/-/g
s/\\page/\\par/g
```

#### 3\. Convert the marked up file to TXT

The third shell command uses textutil again to convert to .txt format:

```
textutil -convert txt -encoding UTF-8  inputFileName
```

#### 4\. Convert the TXT citations in tagged RIS format

The fourth shell command uses whichever sed script the user has selected as appropriate (according to the citation style the bibliography was written in) to convert the marked up txt file into the final RIS file.  Unicode characters (such as with accented letters) in the bibliography can cause problems here, but this is easily prevented by setting the LANG environment variable to the C locale:

```
LANG=C sed -f ClinicaChimicaActa.sed < inputFileName > outputFileName
```

The ClinicaChimicaActa sed conversion script is included as an example below.

##### ClinicaChimicaActa.sed (version 1.3)

```
# Tidy up tags, punctuation, spurious spacing, blank lines, and urls
s/\<[^/>]*\>$//
s/^\<\/[^>]*\>//
s/\(\<[^/>]*\>\)\([^0-9A-Za-z<>]*\)/\2\1/g
s/\([^0-9A-Za-z\<\>]*\)\(\<\/[^\>]*\>\)/\2\1/g
s/\<\([^>]*\)\>\<\/\1\>//g
s/\( \)\([ ,.]*\)/\1/g
s/^[ 	]*//
s/[ 	]*$//
/^$/d
s/\([^/]\)www/\1http:\/\/www/g

# Deliminate records (adding a copy of the full record to the notes field)
s/[., 	]*$//
s/\(.*\)$/\1@@N1  - \1@@ER  - /

# Strip numbers from the start
s/^[[0-9]*][ 	]*//

# Deal with the format Author. Title1.
s/^\([^@.]*\)\. \([^@.?]*\?*\)\.* */@@A1  - \1@@T1  - \2@@T2  - /

# Deal with Journal Year;vol:sp-ep. format
s/@@T2  - \([^@;0-9]*\)\([0-9]*;\)/@@JF  - \1@@Y1  - \2/
s/\(@@Y1  - [^@;]*\); *\([^@:]*:\)/\1@@VL  - \2/
s/\(@@Y1  - [^@;]*\); *\([0-9]* *-\)/\1@@SP  - \2/
s/\(@@VL  - [^@:]*\): *\([0-9]* *-*\)/\1@@SP  - \2/
s/\(@@SP  - [^@-]*\) *- *\([0-9]*\)/\1@@EP  - \2/

# Deal with In: Editor A, editor. Title2.
s/@@T2  - In:* \([^@.]*\), editors*\. */@@A2  - \1@@T2  - /

# Deal with Title. City: Publisher, Year: sp-ep. format
s/\(@@T[12]  - [^@.]*\)\. /\1@@CY  - /
s/\(@@CY  - [^@:]*\): */\1@@PB  - /
s/\(@@PB  - [^@0-9]*\), */\1@@Y1  - /
s/\(@@Y1  - [^@:]*\): */\1@@SP  - /

# Deal with editions
s/\(@@T[12]  - [^@]*\), \([0-9a-z]*\) ed@@/\1@@VL  - \1@@/

# Keep italicised species names etc in T1
: sp_loop
s/\\([^<]*\)\<\/i\>\(.*@@T2\)/\\1\<\/species\>\2/
s/\\([^<]*\)\<\/i\>\(.*@@JF\)/\\1\<\/species\>\2/
t sp_loop

# Get rid of unnecessary html tags (bold, italics, underline)
s/\<\/*b\>//g
s/\<\/*i\>//g
s/\<\/*u\>//g
s/species\>/i\>/g

# Classify records
/@@JF/s/^/@@TY  - JOUR/
/@@TY/!s/^\(.* [Tt]hesis\)/@@TY  - THES\1/
/@@TY/!s/^\(.* [Dd]issertation\)/@@TY  - THES\1/
/@@TY/!s/^\(.* [Cc]onference\)/@@TY  - CONF\1/
/@@TY/!s/^\(.* [Cc]ongress\)/@@TY  - CONF\1/
/@@TY/!s/^\(.* [Ww]orkshop\)/@@TY  - CONF\1/
/@@TY/!s/^\(.* [Ss]eminar\)/@@TY  - CONF\1/
/@@TY/!s/^\(.*@@T2\)/@@TY  - CHAP\1/
/@@TY/!s/^/@@TY  - BOOK/

# Appropriately split information in the author field
s/\(@@[^@]*\), et al\([^@]*@@[^E]\)/\1\2/g

: au_loop
s/\(@@A[12]  - \)\([^@,]*\), /\1\2\1/g
t au_loop
s/\(@A[12]  - [^@]*\) \([A-Z]*@\)/\1, \2/g

# Finally replace placeholder with linebreak.
s/@@/\
/g
```

The user can import the resulting RIS file using the normal process in their bibliographic software.  To import into Endnote, for example, the user chooses File > Import and selects the file and the import option UTF8.  If the records contain formatting such as italicised species names or superscripts or subscripts in chemical formulae, these will display with HTML tags.  A “Convert HTML Tags” plug-in can be downloaded from the Endnote forums ([Rollins 2011](https://journal.code4lib.org/articles/#ref12)) to convert these to ordinary formatting.

Results then need to be checked for any errors caused either by the conversion process or by typos in the input.  The notes field of each record contains a copy of the original input for comparison.

### Sample output

Three examples of references to journal articles in Clinica Chimica Acta style, each followed by the RIS output, show Ref2RIS working at its best, and some of the limitations and glitches that users would still need to edit manually.

\[1\]         Bedford JJ, Harper JL, Leader JP, *et al*. Betaine is the principal counteracting osmolyte in tissues of the elephant fish, *Callorhincus millii* (Elasmobranchii, Holocephali). Comp. Biochem. Physiol. B 1998;119:521-526.

```
TY  - JOUR
A1  - Bedford, JJ
A1  - Harper, JL
A1  - Leader, JP
A1  - <i>et al</i>
T1  - Betaine is the principal counteracting osmolyte in tissues of the elephant fish, <i>Callorhincus millii</i> (Elasmobranchii, Holocephali)
JF  - Comp. Biochem. Physiol. B
Y1  - 1998
VL  - 119
SP  - 521
EP  - 526
N1  - [1]	Bedford JJ, Harper JL, Leader JP, et al. Betaine is the principal counteracting osmolyte in tissues of the elephant fish, Callorhincus millii (Elasmobranchii, Holocephali). Comp. Biochem. Physiol. B 1998;119:521-526
ER  -
```

Here the user will need to edit the author fields to add the names abbreviated by *et al*, and the journal field to expand the abbreviation.

\[2\]         Sizeland, PCB, Chambers ST, Lever M *et al*. Organic osmolytes in human and other mammalian kidneys. Kidney Int. 1993;43:448-453.

```
TY  - JOUR
A1  - Sizeland
A1  - PCB
A1  - Chambers, ST
A1  - Lever M <i>et al</i>
T1  - Organic osmolytes in human and other mammalian kidneys
JF  - Kidney Int.
Y1  - 1993
VL  - 43
SP  - 448
EP  - 453
N1  - [2]	Sizeland, PCB, Chambers ST, Lever M et al. Organic osmolytes in human and other mammalian kidneys. Kidney Int. 1993;43:448-453
ER  -
```

The extraneous comma after the first surname in the original reference, and the missing comma after the third author, both affect the output.

\[3\]         Chance DH, Kalas TA. A biological perspective on the use of tandem mass spectrometry  
for newborn screening and clinical testing. Clin. Biochem. 2005;38:296-309.

```
TY  - CHAP
A1  - Chance, DH
A1  - Kalas, TA
T1  - A biological perspective on the use of tandem mass spectrometry for
T2  -
N1  - [3]	Chance DH, Kalas TA. A biological perspective on the use of tandem mass spectrometry for
ER  - 

TY  - JOUR
A1  - newborn screening and clinical testing
T1  - Clin
JF  - Biochem.
Y1  - 2005
VL  - 38
SP  - 296
EP  - 309
N1  - newborn screening and clinical testing. Clin. Biochem. 2005;38:296-309
ER  -
```

Here an accidental newline in the middle of a reference – effectively invisible to a human editor – results in it being split into two malformed references.

Scrambled output can also result when a field (most common in titles) contains punctuation which the script reads as delimiting other fields or more generally when the script is written such that it matches a common pattern of citation formatting at the expense of a less common pattern.  Thus while Ref2RIS can do the bulk of the conversion work, the user will always need to inspect and manually edit the results.

## Conclusion and Future Directions

Ref2RIS can accept bibliographies saved as txt, html, rtf, rtfd, doc, docx, wordml, odt, or webarchive.  It accepts Unicode format, allowing for citations that include accented characters, and retains italics, superscripts, and subscripts in article titles.  It can easily deal with large bibliographies – one file containing 5964 references was processed in less than two minutes.  Most importantly, it is easy to use for people without expertise in programming or compiling code.

Although Ref2RIS was developed to help students and researchers import their own bibliographies into bibliographic managers, it can as readily be used to import bibliographies from published papers.  This opens up possibilities for bibliographic analysis; importing references into a bibliographic manager can greatly speed up sorting by author, date, source, or format compared to manual analysis of the raw citations.

Conversion scripts have been written for APA and Clinica Chimica Acta.  More citation styles can be supported by creating additional sed scripts.  However with the proliferation of highly diverse citation styles it would be more ideal to create a process that could parse any inputted citation style.  An initial attempt at the problem (see Generic.sed in Appendix 1) works for some styles and fails spectacularly for others.  Even identifying a year is difficult when it can commonly appear in first, second or last place or elsewhere in a given style, and when a given four-digit number might be a page, document, or issue number, or part of a title or even corporate author.  A simple series of find/replace commands is unlikely to ever be sufficient for this task. Even with the improved accuracy of citation style-specific conversions, the problems that can be introduced by typos and unexpected punctuation mean that output should always be reviewed by users manually.

While the current AppleScript version of Ref2RIS is easy to use, it can only be used on MacOS 10.4 or later.  It would also be desirable to package the core sed scripts into applications for Windows, Linux, earlier MacOS, and/or web environments.  However while versions of sed are available on most systems, textutil is not, so another solution for converting from diverse word processing formats into RTF and TXT would need to be found.

Other useful refinements could include:

- Supporting input from PDF
- Supporting conversion into BibTeX
- Additional code to convert in-text citations into a format recognised by the user’s bibliographic software

## Note

Ref2RIS is available from [http://deborahfitchett.com/toys/ref2ris/](http://deborahfitchett.com/toys/ref2ris/) under a GPL license.

Deborah Fitchett is a subject liaison librarian at the University of Canterbury EPS Library. She can be contacted at deborah.fitchett@canterbury.ac.nz

## References

\[[1](https://journal.code4lib.org/articles/#cite1)\] Brekhus R. Converting Bibliographies from Text to Endnote Using Wizfolio \[Internet\]. \[updated 2010 Mar 25\]. Columbia (MO): University of Missouri, MU Libraries; \[cited 2011 Nov 22\]. Available from: [http://libraryguides.missouri.edu/content.php?pid=89799&sid=671253](http://libraryguides.missouri.edu/content.php?pid=89799&sid=671253)

\[[2](https://journal.code4lib.org/articles/#cite2)\] CrossRef – Simple Text Query Form \[Internet\]. \[updated 2010 May 5\]. Oxford: CrossRef; \[cited 2011 Nov 29\]. Available from: [http://www.crossref.org/SimpleTextQuery/](http://www.crossref.org/SimpleTextQuery/)

\[[3](https://journal.code4lib.org/articles/#cite3)\] FreeCite – Open Source Citation Parser \[Internet\]. \[date unknown\]. Providence (RI): Brown University; \[cited 2011 Nov 22\]. Available from: [http://freecite.library.brown.edu/](http://freecite.library.brown.edu/)

\[[4](https://journal.code4lib.org/articles/#cite4)\] Garret P. 2008. Importing a bibliography in text format into EndNote \[Internet\]. \[Place of publication unknown\]: crevilles.org; \[cited 2011 Nov 17\]. Available from: [http://crevilles.org/mambo/textes/tutoriels/ImportEndNote\_eng.pdf](http://crevilles.org/mambo/textes/tutoriels/ImportEndNote_eng.pdf)

\[[5](https://journal.code4lib.org/articles/#cite5)\] Gear RW. 2002. Exporting EndNote Records to MS Access and Importing Endnote Records From Access Using Tab Delimited Files in Both Directions \[Internet\]. \[Place of publication unknown\]; \[cited 2011 Nov 17\]. Available from: [http://research.mbs.ac.uk/hsi/Portals/0/docs/AlanBoyd/Gear-EndNote-Access-Transfer.pdf](http://research.mbs.ac.uk/hsi/Portals/0/docs/AlanBoyd/Gear-EndNote-Access-Transfer.pdf)

\[[6](https://journal.code4lib.org/articles/#cite6)\] Hetzner E. 2008. A simple method for citation metadata extraction using hidden Markov models. Proceedings of the Joint Conference on Digital Libraries. Pittsburgh, PA.

\[[7](https://journal.code4lib.org/articles/#cite7)\] How can I transfer references into EndNote from an Excel spreadsheet? \[Internet\]. \[2010\]. Sydney: University of Technology Sydney; \[cited 2011 Nov 17\]. Available from: [http://www.lib.uts.edu.au/question/5952/how-can-i-transfer-references-endnote-excel-spreadsheet-or-access-database](http://www.lib.uts.edu.au/question/5952/how-can-i-transfer-references-endnote-excel-spreadsheet-or-access-database)

\[[8](https://journal.code4lib.org/articles/#cite8)\] Kan M-Y, Councill IG, Giles CL, Luong M-T, Ng YK, Nguyen TD, Do HNH. 2004. ParsCit: An open-source CRF Reference String and Logical Document Structure Parsing Package \[Internet\]. \[updated 2011 May 7\]. Singapore: National University of Singapore; \[cited 2011 Nov 29\]. Available from: [http://wing.comp.nus.edu.sg/parsCit/](http://wing.comp.nus.edu.sg/parsCit/)

\[[9](https://journal.code4lib.org/articles/#cite9)\] ParaCite \[Internet\]. \[2004\]. Southampton: University of Southampton; \[cited 2011 Nov 29\]. Available from: [http://paracite.eprints.org/](http://paracite.eprints.org/)

\[[10](https://journal.code4lib.org/articles/#cite10)\] Pement E. Frequently Asked Questions about sed, the stream editor: Basic sed \[Internet\]. \[updated 2003 Mar 10\]. \[Place of publication unknown\]; \[cited 2011 Nov 21\]. Available from: [http://sed.sourceforge.net/sedfaq2.html](http://sed.sourceforge.net/sedfaq2.html)

\[[11](https://journal.code4lib.org/articles/#cite11)\] RIS Format Specifications \[Internet\]. \[updated 2011 Oct 6\]. Carlsbad (CA): Reference Manager; \[cited 2011 Nov 21\]. Available from: [http://www.refman.com/support/risformat\_intro.asp](http://www.refman.com/support/risformat_intro.asp)

\[[12](https://journal.code4lib.org/articles/#cite12)\] Rollins J. 2011. Convert HTML Tags sample plug-in \[Internet\]. \[Place of publication unknown\]; \[cited 2011 Nov 21\]. Available from: [http://community.thomsonreuters.com/t5/EndNote-API/Convert-HTML-Tags-sample-plug-in/td-p/18467](http://community.thomsonreuters.com/t5/EndNote-API/Convert-HTML-Tags-sample-plug-in/td-p/18467)

\[[13](https://journal.code4lib.org/articles/#cite13)\] Suhonos MJ. 2009. Semi-automatic Citation Correction with Lemon8-XML. Code4Lib Journal \[Internet\]. \[cited 2012 Jan 16\]; 6. Available from: [http://journal.code4lib.org/articles/1011](https://journal.code4lib.org/articles/1011)

\[[14](https://journal.code4lib.org/articles/#cite14)\] Takaki M. Generate BiBTeX entry from plain text \[Internet\]. \[date unknown\]. \[Place of publication unknown\]; \[cited 2011 Nov 22\]. Available from: [http://www.snowelm.com/~t/doc/tips/makebib.en.html](http://www.snowelm.com/~t/doc/tips/makebib.en.html)

\[[15](https://journal.code4lib.org/articles/#cite15)\] textutil(1) Mac OS X Manual Page \[Internet\]. \[updated 2004 Sep 9\]. \[Place of publication unknown\]: Mac OS X Developer Library; \[cited 2011 Nov 21\]. Available from: [http://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man1/textutil.1.html](http://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man1/textutil.1.html)

\[[16](https://journal.code4lib.org/articles/#cite16)\] Transferring a Word bibliography to EndNote  \[Internet\]. \[date unknown\]. Brisbane: University of Queensland Library; \[cited 2011 Nov 22\]. Available from: [http://www.library.uq.edu.au/faqs/endnote/convert\_bibliography.html](http://www.library.uq.edu.au/faqs/endnote/convert_bibliography.html)

## Appendix

### Generic.sed (version 2.0)

```
# Tidy up tags, punctuation, spurious spacing, blank lines, and urls
s/\<[^/>]*\>$//
s/^\<\/[^>]*\>//
s/\(\<[^/>]*\>\)\([^0-9A-Za-z<>]*\)/\2\1/g
s/\([^0-9A-Za-z<>]*\)\(\<\/[^>]*\>\)/\2\1/g
s/\<\([^/>]*\)\>\([^a-zA-Z0-9<>]*\)\<\/\1\>/\2/g
s/\<\/\([^>]*\)\>\([^a-zA-Z0-9<>]*\)\<\1\>/\2/g
s/ *- */-/g
s/\( \)\([ ,]*\)/\1/g
s/^[ 	]*//
s/[ 	]*$//
s/[ 	][ 	]*/ /g
/^$/d
s/\([^/]\)www/\1http:\/\/www/g

# Deliminate records (adding a copy of the full record to the notes field)
s/\(.*\)$/@@XX  - \1@@N1  - \1@@ER  - /

# Strip numbers from start
s/@@XX  - \[0-9]*\<\/sup\>[ 	]*/@@XX  - /
s/@@XX  - [[( 	]*[0-9]*[]). 	]*/@@XX  - /

# Find info in square brackets
: info_loop
s/\[\([^]]*\)\]\(.*@@N1\)/@@XX  - \1@@XX  - \2/
t info_loop

# Find doi and webpages
s/[Dd][Oo][Ii]:\([^ <>"]*\)\(.*@@N1\)/@@DO  - \1@@XX  - \2/
s/\(https*:[^ <>"]*\)\(.*@@N1\)/@@UR  - \1@@XX  - \2/
s/\(ftp:[^ <>"]*\)\(.*@@N1\)/@@UR  - \1@@XX  - \2/

# Find labelled page, issue, and volume numbers
s/\(.*\)[^a-zA-Z]pp*[^a-zA-Z0-9]*\([0-9][-0-9]*\)\(.*@@N1\)/\1@@SP  - \2@@XX  - \3/
s/\(.*\)[^a-zA-Z][Nn]os*[^a-zA-Z0-9]*\([0-9][-0-9]*\)\(.*@@N1\)/\1@@IS  - \2@@XX  - \3/
s/\(.*\)[^a-zA-Z][Vv]ols*[^a-zA-Z0-9]*\([0-9][-0-9]*\)\(.*@@N1\)/\1@@VL  - \2@@XX  - \3/

# Start identifying records
/@@DO/s/^/@@TY  - ELEC/
/^@@XX  - .*[Tt]hesis/s/^/@@TY  - THES/
/^@@XX  - .*[Dd]issertation/s/^/@@TY  - THES/
/^@@XX  - .*Conference/s/^/@@TY  - CPAPER/
/^@@XX  - .*Workshop/s/^/@@TY  - CPAPER/
/^@@XX  - .*Congress/s/^/@@TY  - CPAPER/
/^@@XX  - .*Seminar/s/^/@@TY  - CPAPER/
/^@@XX  - .*Symposium/s/^/@@TY  - CPAPER/
/^@@XX  - .*Meeting/s/^/@@TY  - CPAPER/
/^@@XX  - .*Forum/s/^/@@TY  - CPAPER/
/^@@XX  - .*[Rr]eport/s/^/@@TY  - RPRT/
/^@@XX  - .*[Pp]atent/s/^/@@TY  - PAT/
/^@@XX  - .*@@UR/s/^/@@TY  - ELEC/
/@@TY/!s/^/@@TY  - GEN/

# Find identifiable titles
s/\(@@XX  - [^@"]*\)"\([^@"]*\)"\(.*@@N1\)/\1@@T1  - \2@@XX  - \3/
s/\(@@XX  - [^@<]*\)\<[iu]\>\([^@<]*\)\<\/[iu]\>\(.*@@N1\)/\1@@TT  - \2@@XX  - \3/
s/\(@@XX  - [^@<]*\)In:* \(.*@@N1\)/\1@@XX  - \2/

# Split at editor/edition
s/@@XX  - [^a-zA-Z0-9@]*[Ee]ds*[^a-zA-Z0-9@][^a-zA-Z0-9<@]*\(.*@@N1\)/@@XX  - \1/g
s/\([^a-zA-Z0-9@][Ee]ds*[^a-zA-Z0-9@][^a-zA-Z0-9<@]*\)\(.*@@N1\)/\1@@XX  - \2/g

# Rewrite dates
: date_loop
s/\([A-Z][a-z][a-z]\)[a-z]* \([0-9][-0-9]*\),* \([1-2][0-9][0-9][0-9]\)\(.*@@N1\)/\3-\1-\2@@XX  - \4/
s/\([0-9][-0-9]*\)[snrt]*[tdh]* \([A-DF-Z][a-z][a-z]\)[a-z]*,* \([1-2][0-9][0-9][0-9]\)\(.*@@N1\)/\3-\2-\1@@XX  - \4/
s/\([1-2][0-9][0-9][0-9]\)[^-a-zA-Z0-9@]*\([A-Z][a-z][a-z]\)[a-z]*[^-a-zA-Z0-9@]*\([0-9][-0-9]*\)\(.*@@N1\)/\1-\2-\3@@XX  - \4/
t date_loop
s/-Jan-/-01-/g
s/-Feb-/-02-/g
s/-Mar-/-03-/g
s/-Apr-/-04-/g
s/-May-/-05-/g
s/-Jun-/-06-/g
s/-Jul-/-07-/g
s/-Aug-/-08-/g
s/-Sep-/-09-/g
s/-Oct-/-10-/g
s/-Nov-/-11-/g
s/-Dec-/-12-/g
s/\([12][0-9][0-9][0-9]\)-\([0-1][0-9]\)-\([0-9][-0-9]*\)/@@DD  - \1\/\2\/\3\//g
s/\(@@DD  - [12][0-9][0-9][0-9]\/[0-1][0-9]\/\)\([0-9][-/]\)/\10\2/g
s/@@XX  - [^@]*[Aa]ccess[^@]* @@DD  - /@@DA  - /
s/@@XX  - [^@]*[Rr]etriev[^@]* @@DD  - /@@DA  - /
s/@@XX  - [^@]*[Cc]ite[^@]* @@DD  - /@@DA  - /

# Find years
s/\(@@XX  - [^@]*\)\\([1-2][0-9][0-9][0-9]\)\<\/b\>\(.*@@N1\)/\1@@Y1  - \2@@XX  - \3/
/@@Y1/!s/\(@@XX  - [^@]*\)[[(]\([1-2][0-9][0-9][0-9][^])0-9]*\)[])]\(.*@@N1\)/\1@@Y1  - \2@@XX  - \3/
/@@Y1/!s/\(@@XX  - [^@]*[^-0-9]\)\([1-2][0-9][0-9][0-9]\)\([^-0-9].*@@N1\)/\1@@Y1  - \2@@XX  - \3/
s/\(@@XX  - [^@]*\)n\.d\.\(.*@@N1\)/\1@@Y1  - n\.d\.@@XX  - \2/
s/\(@@XX  - [^@]*\)in press\(.*@@N1\)/\1@@Y1  - in press@@XX  - \2/
/@@Y1/!s/@@DD  - /@@Y1  - /
/@@DD/!s/\(@@TY  - CPAPER.*\)@@Y1/\1@@DA/

# Find unlabelled page numbers, volumes and issues
/@@SP/!s/\(.*[ .:p]\)\([0-9][0-9]*-[0-9][0-9]*\)\([^-0-9].*@N1\)/\1@@SP  - \2@@XX  - \3/
/@@IS/!s/\(.*[^/0-9]\)\([0-9][-0-9]*[A-Z]*\)\<\/[ibu]\>[^a-zA-Z0-9]*\([0-9][-0-9]*\)\([^a-zA-Z0-9]*@@SP\)/\1@@VL  - \2@@IS  - \3\4/
/@@IS/!s/\(.*[^/0-9]\)\([0-9][-0-9]*[A-Z]*\)@@XX  - [^a-zA-Z0-9]*\([0-9][-0-9]*\)\([^a-zA-Z0-9]*@@SP\)/\1@@VL  - \2@@IS  - \3\4/
/@@IS/!s/\(.*[^/0-9]\)\([0-9][-0-9]*[A-Z]*\)[^a-zA-Z0-9][^a-zA-Z0-9]*\([0-9][-0-9]*\)\([^a-zA-Z0-9]*@@SP\)/\1@@VL  - \2@@IS  - \3\4/
/@@VL/!s/\(.*[^/0-9]\)\([0-9][-0-9]*[A-Z]*\)\<\/[ibu]\>\([^a-zA-Z0-9]*@@SP\)/\1@@VL  - \2\3/
/@@VL/!s/\(.*[^/0-9]\)\([0-9][-0-9]*[A-Z]*\)@@XX  - \([^a-zA-Z0-9]*@@SP\)/\1@@VL  - \2\3/
/@@VL/!s/\(.*[^/0-9]\)\([0-9][-0-9]*[A-Z]*\)\([^a-zA-Z0-9]*@@SP\)/\1@@VL  - \2\3/
s/\(@@VL  - [^@]*\)@@XX  - \([^@]*@@SP  - \)/\1@@IS  - \2/
s/@@Y1  - @@VL  - [^a-zA-Z0-9@]*\([1-2][0-9][0-9][0-9]\)[^a-zA-Z0-9@]*@@IS  - /@@Y1  - \1@@VL  - /

# Split at end of titles
s/\. *\. *\./@@Ellipsis/
: split_loop
s/\(@@XX  - [^@]*[^A-Z]\)\. \(.*@@N1\)/\1@@XX  - \2/
t split_loop
s/@@Ellipsis/\.\.\./

# Strip italics, bold, underline
: html_loop
s/\<\/*[^>]\>\(.*@@N1\)/\1/
t html_loop

# Clean up empty fields
s/@@..  - [^a-zA-Z0-9]*@@/@@/g
s/@@..  - [^a-zA-Z0-9]*@@/@@/g

# Identify editions vs editors
s/@@XX  - \([^@]*[^a-zA-Z0-9][^a-zA-Z0-9]*\)[Ee]ditors*\(.*@@N1\)/@@A2  - \1\2/
s/@@XX  - [^a-zA-Z0-9]*\([0-9][^@]*\)[Ee]dition\(.*@@N1\)/@@ET  - \1\2/
s/@@XX  - [^a-zA-Z0-9]*\([0-9][^@]*\)[Ee]d[^a-zA-Z0-9@]*\(.*@@N1\)/@@ET  - \1\2/
s/@@XX  - [^a-zA-Z0-9]*\(Rev[^@]*\)[Ee]dition\(.*@@N1\)/@@ET  - \1\2/
s/@@XX  - [^a-zA-Z0-9]*\(Rev[^@]*\)[Ee]d[^a-zA-Z0-9@]*\(.*@@N1\)/@@ET  - \1\2/
s/@@XX  - \([^@]*[^a-zA-Z0-9][^a-zA-Z0-9]*\)Eds*\([^a-zA-Z0-9].*@@N1\)/@@A2  - \1@@XX  - \2/

# Identify City:Publishing Press (and vice versa)
s/@@XX  - \([^@]*\):\([^@]*Press[^@]*\)/@@CY  - \1@@PB  - \2/
s/@@XX  - \([^@]*\):\([^@]*Publi[sc][ha][^@]*\)/@@CY  - \1@@PB  - \2/
s/@@XX  - \([^@]*Press[^@]*\):\([^@]*\)/@@PB  - \1@@CY  - \2/
s/@@XX  - \([^@]*Publi[sc][ha][^@]*\):\([^@]*\)/@@PB  - \1@@CY  - \2/

# Identify City, State:Publisher (and vice versa)
/@@PB/!s/@@XX  - \([^@]*[A-Z][A-Z][^a-zA-Z0-9@]*\):\([^@]*\)/@@CY  - \1@@PB  - \2/
/@@PB/!s/@@XX  - \([^@]*\):\([^@]*[A-Z][A-Z][^a-zA-Z0-9@]*@@\)/@@PB  - \1@@CY  - \2/

# Identify author fields
s/@@XX  - \([^@]*et al[^@]*\)/@@AA  - \1/
s/@@XX  - \([^@]*, \)\.\.\.\([^@]*\)/@@AA  - \1 et al, \2/
s/@@XX  - \([^@]*&[^@]*\)/@@AA  - \1/
s/@@XX  - \([^@]* [JS]r[^@]*\)/@@AA  - \1/
s/@@XX  - \(['a-zA-Z][-' a-zA-Z]*[, ]*[A-Z][-. A-Z]*[,.;@]\)/@@AA  - \1/
s/@@XX  - \([A-Z][-. A-Z]* [a-zA-Z][-' a-zA-Z]*[,.;@]\)/@@AA  - \1/

# Identify more record types
/@@A2/s/@@TY  - [A-Z]*/@@TY  - CHAP/
/@@VL/s/@@TY  - GEN/@@TY  - JOUR/
/@@VL/s/@@TY  - ELEC/@@TY  - EJOUR/

# Guess at City:Publisher
/@@TY  - E*JOUR/!s/@@XX  - \([^@]*, [^@]*\):\([^@]*\)/@@CY  - \1@@PB  - \2/
/@@TY  - E*JOUR/!s/@@XX  - \([^@]*\):\([^@]*, [^@]*\)/@@PB  - \1@@CY  - \2/

# Identify miscellaneous fields
s/@@XX  - \([^@]*[Tt]hesis[^@]*\)/@@M3  - \1/g
s/@@XX  - \([^@]*[Dd]issertation[^@]*\)/@@M3  - \1/g
s/@@XX  - \([^@]*\) [Pp]atent [^@0-9]*\([0-9]*\)/@@CY  - \1@@SN  - \2/g

# Identify title fields
s/@@XX  - \([^@]* a [^@]*\)/@@TT  - \1/g
s/@@XX  - \([^@]* an [^@]*\)/@@TT  - \1/g
s/@@XX  - \([^@]* in [^@]*\)/@@TT  - \1/g
s/@@XX  - \([^@]* on [^@]*\)/@@TT  - \1/g
s/@@XX  - \([^@]* and [^@]*\)/@@TT  - \1/g
s/@@XX  - \([^@]* for [^@]*\)/@@TT  - \1/g
s/@@XX  - \([^@]*[Rr]eport[^@]*\)/@@TT  - \1/g

# Final guess at Publisher
/@@PB/!s/@@XX  - \([^@]*:[^@]*\)/@@PB  - \1/
/@@PB/s/@@TY  - GEN/@@TY  - BOOK/

# Assign authors
s/@@XX  - \([^@]*@@Y1\)/@@AA  - \1/
/@@A1/!s/@@AA/@@A1/
/@@A2/!s/@@AA/@@A2/
s/@@AA/@@A3/
s/@@AA/@@XX/g

# Split authors
s/\(@@A.  - \)\([^@]*\) et al */\1\2\1et al\1/
: au_loop
s/\(@@A.  - \)\([^@]*\); /\1\2\1/
s/\(@@A.  - \)\([^@]*\)& /\1\2\1/
s/\(@@A.  - \)\(['b-zA-Z][-' a-zA-Z]*\),* \([A-Z][- .A-Z]*\), /\1\2, \3\1/
s/\(@@A.  - \)\([A-Z][- .A-Z]* ['a-zA-Z][-' a-zA-Z]*\), /\1\2\1/
t au_loop
s/\(@@A.  - \)\(['b-zA-Z][-' a-zA-Z]*\),* \([A-Z][- .A-Z]*\)\([A-Z][a-z]\)/\1\2, \3@@TT  - \4/g
s/\(@@A.  -\)\([^@]*\)and /\1\2\1 /g
s/\(@@A.  - \)\([A-Z][- .A-Z]*\) \(['a-zA-Z][-' a-zA-Z]*\)/\1\3, \2/g

# Assign titles
/@@T1/!s/@@TT/@@T1/
/@@T1/!s/@@T2/@@T1/
/@@T2/!s/@@TT/@@T2/
/@@T3/!s/@@TT/@@T3/
s/@@TT/@@XX/

# Assign dates
/@@Y1/!s/@@DD/@@Y1/
/@@Y2/!s/@@DD/@@Y2/
/@@DA/!s/@@DD/@@DA/
s/@@DD/@@XX/g

# Clean punctuation from start and end of fields
s/\(@@..  - \)[^a-zA-Z0-9@<>]*/\1/g
s/[^a-zA-Z0-9<>]*\(@@..  - \)/\1/g

# Clean up empty fields
s/@@..  - [^a-zA-Z0-9]*@@/@@/g
s/@@..  - [^a-zA-Z0-9]*@@/@@/g

# Guess at, or collapse, unidentified fields
s/\(@@TY  - [A-Z]*\)@@XX  - \([^@]*\)\(@@..  - \)/\1\3\2\. /
/@@T1/!s/@@XX  - /@@T1  - /
/@@T2/!s/@@XX  - /@@T2  - /
/@@TY  - E*JOUR/s/@@T2/@@JF/
/@@T3/!s/@@XX  - /@@T3  - /
s/@@XX  - /. /g

# Standardise field names
s/@@A1/@@AU/g
s/@@T1/@@TI/
s/@@Y1/@@PY/

# Finally replace placeholder with linebreak.
s/@@/\
/g
```
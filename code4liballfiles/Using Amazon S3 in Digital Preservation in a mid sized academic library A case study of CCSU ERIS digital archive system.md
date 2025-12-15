---
title: "Using Amazon S3 in Digital Preservation in a mid sized academic library: A case study of CCSU ERIS digital archive system"
source: "https://journal.code4lib.org/articles/4468"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-12-21
created: 2025-01-10
description: "With the increasing numbers of born digital and digitized objects in academic libraries from sources such as digital collections and institutional repositories many academic libraries need to seriously consider implementing some form of digital preservation system. In 2009 the Central Connecticut State University Library decided to use Amazon S3 for digital preservation storage despite some [...]"
tags:
  - "clippings"
---
# Using Amazon S3 in Digital Preservation in a mid sized academic library: A case study of CCSU ERIS digital archive system
Edward Iglesias, Wittawat Meesangnil

With the increasing numbers of born digital and digitized objects in academic libraries from sources such as digital collections and institutional repositories many academic libraries need to seriously consider implementing some form of digital preservation system.

In 2009 the Central Connecticut State University Library decided to use Amazon S3 for digital preservation storage despite some drawbacks. The library has developed a system, ERIS Digital Archive, to manage all digital preservation processes and to make the system as compliant with the OAIS model and “Trustworthy Digital Repositories” as possible.

## Introduction

Burritt Library became involved with digital preservation out of necessity. Electronic resources were increasing and upon beginning a new digitization project we took the opportunity to create a concrete preservation plan. In early 2009 we realized the need for a digital preservation system after disc space on our network share ran out due to an abundance of uncompressed TIFF files. We temporarily used an external hard drive for backup and started looking for a system.

### Exploring the Digital Preservation Landscape

When Burritt Library started looking at digital preservation, we began with an environmental scan to become acquainted with the products and solutions available. An emphasis was placed on systems using PREMIS preservation metadata and the OAIS model.

The first system we looked into was OCLC’s Digital Archive ([http://www.oclc.org/digitalarchive/](http://www.oclc.org/digitalarchive/)) since it was designed mainly to work with CONTENTdm, the digital collection management system we already used. Although it had many of the features we wanted, Digital Archive did not suit us due to the high costs involved in storing terabytes of data. We were also concerned about preserving digital objects not contained in CONTENTdm.

The second solution we looked at was LOCKSS ([http://lockss.stanford.edu/lockss/Home](http://lockss.stanford.edu/lockss/Home)), a distributed digital preservation system. It was originally created to preserve electronic journals that the library purchased, with the permission of publisher. LOCKSS can also be used for preserving other kinds of digital objects on a smaller scale. Private LOCKSS Networks (PLNs) is a solution where six institutions can set up their own private LOCKSS network to preserve any digital object desired ([Private LOCKSS Networks, 2008](https://journal.code4lib.org/articles/#citation1)). This solution was desirable since it had little cost to start and maintain. It would also expand our staff’s skill greatly. Unfortunately, we were unable to persuade other institutions in our consortia to participate. The idea of implementing an open source distributed preservation system without any help from a vendor created a high entrance barrier for this solution.

At this point we realized the need to implement some sort of in-house solution. The first issue to address was storage. We were quite familiar with traditional archive storage for digital objects such as tape backup, preservation DVDs, and RAID hard drives but the problem remained that we needed to have two copies of our archival object in at least two different geographic locations. The first two solutions we looked at addressed this issue. OCLC digital archives would let us mail in DVDs, or hard drives that would then be processed in their data warehouse. Our solution would have to be similarly flexible in its input.

We started to look at cloud computing as an option after Peter Murray wrote an article that reviewed Amazon S3, one of the most popular cloud storage services, as a possible choice for digital preservation on his blog. ([Murray, 2008](https://journal.code4lib.org/articles/#citation2))

Using Amazon S3 as dark archive seemed to be a good idea, since the cost was much lower than OCLC Digital Archive and we would also have instant access to our content, unlike traditional off site storage services. We did an annual cost comparison between S3 and OCLC Digital Archive based on a ball park figure of 5TB of data storage.

| Cost for 5TB | OCLC | Amazon S3 | Notes |
| --- | --- | --- | --- |
| Set up | $3,000 | $0\* | \*Not including staff hours on design / setup |
| Ingest | $2,400 | $0 |  |
| Annual Storage Costs | $26,850 | $8,610 |  |
| Monthly Fee | $0 | $716 |  |
| Interface | Provided by OCLC | We would design |  |
| Hardware Costs | $0 | $1,350 | HP Windows Home server @ $600; 5 2TB drives = $750 ($150 \* 5) |
| Hardware Costs | None extra | $800 | Using current staff 4 days / year = $800 ($200 / day) |
| Total Costs | $32,250 | $9,362 |  |
|  |  |  |  |

**Table 1.** Cost comparison between OCLC Digital Archive and Amazon S3.

Although many people had proposed S3, at the time no one had yet implemented a version of it that we could learn from. We needed to develop a system based on what we had learned from the OAIS model. We also had a very modest budget and no extra personnel. We needed to look at the OAIS model and digital preservation best practices and implement the most important part of it if this project was going to be feasible. An ideal system would have the following characteristics:

- All of the technology would be open source and transparent
- It would follow the OAIS framework ([Lavoie, 2004](https://journal.code4lib.org/articles/#citation3))
- It would comply with trusted digital repository standards ([CRL, OCLC, 2007](https://journal.code4lib.org/articles/#citation4))
- It would need to be as automated as possible

Given those lofty aspirations, the main goals of our system was to keep the data safe while maintaining costs low. Maintenance was also an issue since this system would have to run on its own with no dedicated programmer or full time administrator. We identified, to focus on, these core functionalities:

- Data integrity and providing future accessibility through preservation metadata.
- Network file transfer verification by verifying data integrity through the transfer process to cloud storage.
- Management of the data so that it can be located at any point in the process.

## Design: core functionalities

### Data Integrity

We decided to address the problem of data integrity through the use of file format verification tools. In early 2009, there were a handful of tools available for file integrity checking, format verification, and creating preservation metadata. We chose Statistics New Zealand Prototype PREMIS Creation Tool, a tool set available from the PREMIS website ([Tools for preservation metadata implementation, 2009](https://journal.code4lib.org/articles/#citation5)).

It employs these three tools to extract technical metadata from digital objects.

- JHOVE – JSTOR/Harvard Object Validation Environment, provides functions to perform format-specific identification, validation, and characterization of digital objects. ([JHOVE, 2009](https://journal.code4lib.org/articles/#citation6))
- DROID Digital Record Object Identification developed by UK National Archives Based on PRONOM registry of file signatures specific to file types. ([DROID, 2006](https://journal.code4lib.org/articles/#citation7))
- New Zealand Metadata Extractor, developed by the National Library of New Zealand to programmatically extract preservation metadata from a range of file formats. Its output is used in providing creating software and executable environment information. ([National Library of New Zealand, n.d.](https://journal.code4lib.org/articles/#citation8))

All three tools above generate output in XML format. XSLT is then used with the included XSL style sheet to transform the three outputs into PREMIS preservation metadata ([PREMIS Editorial Committee, 2008](https://journal.code4lib.org/articles/#citation9)).

### Network File Transfer Verification

Since we decided to use cloud storage as archival storage, a major issue in our system was how to be certain that data transferred over the Internet to be archived is not lost or corrupted during transmission.

Amazon S3 provides a mechanism to detect data lost or corrupted by providing the ability to specify an MD5 checksum for the data being sent to S3. Amazon S3 will check the object against the provided MD5 value. If they do not match, Amazon S3 will return an error so the client can try retransmitting. ([Amazon Web Services, 2006](https://journal.code4lib.org/articles/#citation10)) Many backup software applications already utilized this function \[[1](https://journal.code4lib.org/articles/#note1)\]. In our system we use Couldberry Backup for Windows Home Server which allows us to schedule backups automatically with a nice GUI.([http://www.cloudberrylab.com/](http://www.cloudberrylab.com/))

We also provide another layer of verification by using BagIt, a network file transfer tool developed by the Library of Congress. It provides a way of packaging up arbitrary digital content, so that it can be reliably transported both via physical media as well as network transfers. ([Library of Congress – Transfer Tools, n.d.](https://journal.code4lib.org/articles/#citation11))

### Management

A MySQL database was developed to keep track of the archival object as it goes through the system. We provide a web interface for the depositor to enter their deposit information and also to search for items in the database:

[![Figure 1](https://journal.code4lib.org/media/issue12/iglesias//fig1_sm.png)](https://journal.code4lib.org/media/issue12/iglesias/fig1.png "Click to display full-size image")

**Figure 1.** ERISDA MySQL web interface

To perform the digital preservation ingestion process, we automated some of it with batch files and automated backup to Amazon S3.

## Design: System

### System architecture

The system was designed to have one server running locally. This server is responsible for processing files upon ingestion, storing processed archival objects in its RAID1 hard drive and then backing up archival objects to Amazon S3 at night as part of an automated process.

Despite a preference for open source systems we decided to use an off the shelf HP Mediasmart server running Windows Home Server as the operating system \[[2](https://journal.code4lib.org/articles/#note2)\]. The reasons for going this route had mostly to do with cost. We looked at pre-built Linux servers with RAID controllers and 4 TB of storage and the cost was significantly more than the HP home server. While reliability was undoubtedly an issue this was mitigated due to the cloud backup. Another factor that played into our decision was the practicality of the system. Although our IT department houses several Linux boxes they like them “over there” in the data center. This was not practical since one of our goals was to reduce network traffic. For what was essentially a NAS running in the library, Windows integrated nicely with the existing network. Users can access the server simply by typing \\\\SERVERNAME in their Windows Explorer address bar while staff can interact with the system via Windows remote desktop, which has clients available in multiple platforms.

### Preservation Process

The ERIS digital archive workflow can be separated into 3 steps:

- Deposit: Users deposit digital objects to be archived to the server
- Ingest: System administrator processes the deposited digital objects (creates preservation metadata, puts digital objects in BagIt format for network transfer) and updates the MYSQL database
- Archive: System administrator puts digital object along with preservation metadata into ERISDA server and makes a second backup copy to Amazon S3 cloud storage. Also manages long-term maintenance, such as file format refreshing, migration.

### Deposit

To deposit digital objects, users log on to a MySQL interface to enter information and receive a deposit ID. Users then package content (directory structure, file naming convention), according to documentation, into a deposit package. At that point the package is transferred to a “deposit” directory via network file transfer or an external hard drive (if data is too large for network transfer). Users can also check their past deposit status to find out what items they’ve already deposited via a MySQL interface.

[![Figure 2](https://journal.code4lib.org/media/issue12/iglesias//fig2_sm.png)](https://journal.code4lib.org/media/issue12/iglesias/fig2.png "Click to display full-size image")

**Figure 2.** ERISDA MySQL web interface: check deposit status

### Ingest

To perform data integrity checks and create preservation metadata we use the New Zealand Prototype PREMIS Creation Tool \[[3](https://journal.code4lib.org/articles/#note3)\]. This is used in combination with DOS batch files to automatically run the three extractor tools and use XSLT to transform outputs to preservation metadata. This batch file (below) can be created quite easily, or converted into a shell script for a Linux environment.

```
@echo off
rem !!—premisrunner.bat, will be called by premis.bat--!
rem !!-- param %1 pass from premis.bat is each sub directory --!

echo Running JHOVE
c:
cd c:\jhove\bin
echo JHOVE
java -jar jhoveapp.jar -c ..\conf\jhove.conf -k -o c:\temp\jhoveoutputfile.xml -h xml -krs %1
echo running escape characters filter
cscript escapefilter1.vbs
cd c:\temp
del jhoveoutputfile.xml
ren filteredjhoveoutputfile.xml JHOVE_out.xml

echo JHOVE Done

echo Running DROID
cd c:\droid
java -jar DROID.jar -l%1 -sDROID_SignatureFile_V29.xml
copy output.xml c:\temp\DROID_out.xml
echo DROID done

echo Running NLNZ Metadata Extraction tools
cd c:\metadata-extractor
extract.bat extract "NLNZ Data Dictionary" Default complex NLNZoutputfile 2010 recurse "%1
copy NLNZoutputfile.xml c:\temp\NLNZ_out.xml
echo NLNZ done

echo Running XSLT

rem !!—Just run XSLT on JHOVE output, the other two outputs are indentified in XSL--!
cd c:\premis
msxsl c:\temp\JHOVE_out.xml erisda_premis.xsl -o premis.xml
echo Transformed

md %1\"Preservation Metadata"
move premis.xml %1\"Preservation Metadata"\premis.xml"
```

To make this batch file more automated we created another batch file to call the main batch file recursively to extract data for each sub-directory.

```
echo This will create preservation metadata for each sub-directory of the directory you enter 
set /p input=[Enter full path of directory you want to extract]
rem cd %input%
for /d %%a IN (%input%\*.*) do call C:\premisrunner.bat "%%a"
```

After we validate every object and create preservation metadata, we need to prepare them for network transfer. BagIt is used to put the object entity into a BagIt bag. This process can also be automated with a batch file. We also run anti-virus on the Home Server and scan contents in this step.

BagIt then puts files into a directory and creates checksums “Payload-Oxum” for each bag, which enables us to verify data integrity if we need to retrieve content from the Amazon S3 cloud.

```
Content of bag-info.txt

Payload-Oxum: 20721997.49
Bagging-Date: 2010-02-24
Bag-Size: 19.8 MB
```

Batch file to create a BagIt bag.

```
@echo off
rem !!—bagitrunner.bat, will be called by bagit.bat--!
rem !!-- param %1 pass from bagit.bat is each sub directory --!

cd c:\bagit-3.6\bin
bag.bat baginplace %1
echo BagIt Done the bag is at %1\
pause
```

After the files are processed and put in a bag ready for transfer, we update the MySQL database to reflect data in the system. Currently we record information such as bag name, bag location, and bag checksum.

We again use multiple DOS batch files to get information about the bag name then read content of bag-info.txt to get the bag checksum and then insert the information into the MySQL database.

```
@echo off
rem !!—get input from user, get name of directory--!

set /p input=[Enter directory you want to update MySQL]
set drive=%drive:~0,2% 
set /p path=[Enter path this batch of bags reside on the server]
set /p depositid=[Enter Deposit ID]
set /p pubid=[Enter Publication ID, enter NULL if don't know]
%drive%
cd %input%
for /d %%a IN (*.*) do call C:\readfrmfilebat.bat "%%a" %path% %depositid% %drive% %pubid%
```
```
@echo off
rem !!—get Patload-Oxum from bag-info.txt--!
cd %1
for /f "tokens=2" %%a in (bag-info.txt) do (
cd..
rem echo %%a
call c:\mysqlrunner.bat %1 %2 %3 %%a %4 %5
exit /b
```
```
@echo off
rem !!—Insert info to MySQL--!
:: var passed from readfrmfile.bat is %1bagname %2serverpath %depositid %4payloadchksum %5drive letter %6 dir.size %7 pub id
SET name=%1
::remove quote
for /f "useback tokens=*" %%a in ('%name%') do set name=%%~a
c:
cd C:\Program Files\mysql\bin
mysql -h library.ccsu.edu -u USER -pPASSWORD -e "set @bagname:='%name%'; set @location:='%2'; set @depositid:='%3'; set @chksum:='%4'; set @size:='%6'; set @pubid:='%7'; source sqlrun.sql;" ERISDA 
%5
```

Once the ingestion process is finished the deposited data is packaged in a bag along with the preservation metadata.

### Archive

After ingestion, we copy processed data from the working directory to the archive directory. Windows Home Server uses drive extender technology to enable interaction with multiple hard drives as one. To backup data in RAID mode, we simply check “Duplication” for each directory in WHS consoles and data in that directory will be copied into two hard drives.

Data in the archive directory is backed up to Amazon S3 using software called “Cloudberry WHS edition” which is configured to automatically backup selected directories.

[![Figure 3](https://journal.code4lib.org/media/issue12/iglesias//fig3_sm.png)](https://journal.code4lib.org/media/issue12/iglesias/fig3.png "Click to display full-size image")

**Figure 3.** CloudBerry backup GUI

## Evaluation / lessons learned

### Usability / Ease of Use

#### Network Share

The system we developed has proven to be quite usable. Staff needed a minimum of training since they were used to storing items on a network share.

#### MySQL

The process for updating the internal database also works well. While at first we were using a php/HTML solution we found that MySQL clients worked better and were more secure for simply updating tables. We did keep one page up that simply displays the holdings so that staff may track their items without having to log on to MySQL.

#### Metadata Creation

The process for creating metadata using PREMIS and BagIT works well enough — although it is not as automatic as hoped. We are currently researching other solutions to see if these scripts might be improved.

#### Amazon S3

The decision to go with Amazon’s S3 storage has been a very good one. The cost is very low and we have had no downtime in a year of use.

#### Hardware

Our Windows home Server keeps chugging along. It has not suffered any hardware or software failures in a year of use.

#### Data Transportation

One area we did have a loss was in the portable hard drives we use for transporting large amounts of data. The first one we bought died unexpectedly taking quite a bit of work with it. There would not have been any lost data if the staff member using it had followed proper protocol, but at the time she was using the external drive as her only storage area. Lessons have been learned from this and we have made the policy of only using the external drive as a transport mechanism clearer.

#### Further Development

Our current research is focused on greater automation of processes. Additionally we are investigating ways of testing disaster recovery options. Because of the size of the records it is non-trivial to download more than a terabyte just to do a checksum.

We are also looking closely at the development of Archivematica ([http://archivematica.org](http://archivematica.org/)), an open source comprehensive digital preservation system developed by Artefactual Systems. Its alpha version was released in May 2010.

## Works Cited

Amazon Web Services. (2006). Amazon Simple Storage Service API Reference, API Version 2006-03-01. Retrieved October 1, 2010, from [http://awsdocs.s3.amazonaws.com/S3/20060301/s3-api-20060301.pdf](http://awsdocs.s3.amazonaws.com/S3/20060301/s3-api-20060301.pdf). ([Return to citation](https://journal.code4lib.org/articles/#cite10)).

CRL, OCLC. (2007, February). Trustworthy Repositories Audit & Certification (TRAC) : Criteria and Checklist. Retrieved October 1, 2010, from [http://www.crl.edu/sites/default/files/attachments/pages/trac\_0.pdf](http://www.crl.edu/sites/default/files/attachments/pages/trac_0.pdf). ([Return to citation](https://journal.code4lib.org/articles/#cite4)).

DROID. (2006). DROID: Project Web Hosting – Open Source Software. Retrieved October 1, 2010, from [http://droid.sourceforge.net/](http://droid.sourceforge.net/). ([Return to citation](https://journal.code4lib.org/articles/#cite7)).

JHOVE. (2009, February 25). Retrieved October 1, 2010, from JHOVE – JSTOR/Harvard Object Validation Environment: [http://hul.harvard.edu/jhove/](http://hul.harvard.edu/jhove/). ([Return to citation](https://journal.code4lib.org/articles/#cite6)).

Lavoie, B. F. (2004, January). The Open Archival Information System Reference Model: Introductory Guide. Retrieved October 1, 2010, from DPC Technology Watch Series Report 04-01: http://www.dpconline.org/docs/lavoie\_OAIS.pdf. ([Return to citation](https://journal.code4lib.org/articles/#cite3)).

Library of Congress – Transfer Tools. (n.d.). Retrieved from [http://sourceforge.net](http://sourceforge.net/): [http://sourceforge.net/projects/loc-xferutils/](http://sourceforge.net/projects/loc-xferutils/). ([Return to citation](https://journal.code4lib.org/articles/#cite11)).

Murray, P. (2008, May 16). Long-term Preservation Storage: OCLC Digital Archive versus Amazon S3. Retrieved October 1, 2010, from Disruptive Library Technology Jester: [http://dltj.org/article/oclc-digital-archive-vs-amazon-s3/](http://dltj.org/article/oclc-digital-archive-vs-amazon-s3/). ([Return to citation](https://journal.code4lib.org/articles/#cite2)).

National Library of New Zealand. (n.d.). Metadata Extraction Tool. Retrieved October 1, 2010, from [http://meta-extractor.sourceforge.net/](http://meta-extractor.sourceforge.net/). ([Return to citation](https://journal.code4lib.org/articles/#cite8)).

PREMIS Editorial Committee. (2008, March). PREMIS Data Dictionary for Preservation Metadata version 2.0. Retrieved October 1, 2010, from [http://www.loc.gov/standards/premis/v2/premis-2-0.pdf](http://www.loc.gov/standards/premis/v2/premis-2-0.pdf). ([Return to citation](https://journal.code4lib.org/articles/#cite9)).

Private LOCKSS Networks. (2008). Retrieved October 1, 2010, from LOCKSS: [http://lockss.stanford.edu/lockss/Private\_LOCKSS\_Networks](http://lockss.stanford.edu/lockss/Private_LOCKSS_Networks). ([Return to citation](https://journal.code4lib.org/articles/#cite1)).

Tools for preservation metadata implementation. (2009, July 22). Retrieved October 1, 2010, from PREMIS: Preservation Metadata Maintenance Activity (Library of Congress): [http://www.loc.gov/standards/premis/tools.html](http://www.loc.gov/standards/premis/tools.html). ([Return to citation](https://journal.code4lib.org/articles/#cite5)).

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] For Linux, see S3Sync: [http://www.s3sync.net/wiki](http://www.s3sync.net/wiki)

\[[2](https://journal.code4lib.org/articles/#ref2)\] [http://www.hp.com/united-states/campaigns/mediasmart-server/](http://www.hp.com/united-states/campaigns/mediasmart-server/)

\[[3](https://journal.code4lib.org/articles/#ref3)\] We’re planning to switch to the File Information Tool Set (FITS) ([http://code.google.com/p/fits/](http://code.google.com/p/fits/)), a more comprehensive tool set for file validation. XSL style sheets to transform FITS output to PREMIS are also available from its website.
---
title: "HathiTrust Ingest of Locally Managed Content: A Case Study from the University of Illinois at Urbana-Champaign"
source: "https://journal.code4lib.org/articles/9703"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-07-21
created: 2025-01-10
description: "In March 2013, the University of Illinois at Urbana-Champaign Library adopted a policy to more closely integrate the HathiTrust Digital Library into its own infrastructure for digital collections. Specifically, the Library decided that the HathiTrust Digital Library would serve as a trusted repository for many of the library’s digitized book collections, a strategy that favors [...]"
tags:
  - "clippings"
---
# HathiTrust Ingest of Locally Managed Content: A Case Study from the University of Illinois at Urbana-Champaign
Kyle R. Rimkus, Kirk M. Hess

In March 2013, the University of Illinois at Urbana-Champaign Library adopted a policy to more closely integrate the HathiTrust Digital Library into its own infrastructure for digital collections. Specifically, the Library decided that the HathiTrust Digital Library would serve as a trusted repository for many of the library’s digitized book collections, a strategy that favors relying on HathiTrust over locally managed access solutions whenever this is feasible. This article details the thinking behind this policy, as well as the challenges of its implementation, focusing primarily on technical solutions for “remediating” hundreds of thousands of image files to bring them in line with HathiTrust’s strict specifications for deposit. This involved implementing HTFeed, a Perl 5 application developed at the University of Michigan for packaging content for ingest into Hathi Trust, and its many helper applications (JHOVE to detect metadata problems, Exiftool to detect metadata issues and repair missing image metadata, and Kakadu to create JP2000 files), as well as a file format conversion process using ImageMagick. Today, Illinois has over 1600 locally managed volumes queued for ingest, and has submitted over 2300 publicly available titles to the HathiTrust Digital Library.

## Background

The University of Illinois at Urbana-Champaign (UIUC) Library has a rich history in digitizing print collections. In 2007, it formed a partnership with the Internet Archive to scan public domain volumes from its general collections on-site, an ongoing project which has resulted in open online access to over 50,000 items ([https://archive.org/details/university\_of\_illinois\_urbana-champaign](https://archive.org/details/university_of_illinois_urbana-champaign)). At the same time, it began participating in the Google Books ([http://books.google.com](http://books.google.com/)) project to digitize additional public domain holdings. In 2008, UIUC became a founding member of HathiTrust ([http://www.hathitrust.org/](http://www.hathitrust.org/)), a partner-driven organization established in part to allow libraries to more closely steward digital surrogates of print collections being produced by Google Books and other large-scale digitization projects.

To complement these efforts, the UIUC Library also manages its own internal digital production unit (founded as Digital Services and Development and later reconstituted in as Digital Content Creation) that works to digitize materials such as rare books, manuscripts, and special collections which, due to their format, rareness, or condition, do not pass through the Internet Archive or Google Books workflows. In addition, the Library’s Preservation unit has worked with trusted vendors since 2007 to digitally reformat embrittled materials from the circulating general collections.

Because this locally managed content did not initially have a home with Google Books, the Internet Archive, or the HathiTrust Digital Library, the UIUC Library developed and later revised its own digitization and file format specifications for monographs, and established a solution comprised of open source tools and in-house scripts to provide web access to them. The primary components of this local solution are a landing page with a persistent handle, downloadable PDF full-text, a page-turner view, and a plain text view of the monograph. This local solution has provided open access to works in the public domain, and restricted access to authenticated UIUC patrons for items digitized for preservation purposes but still protected by copyright restrictions.

[![RimkusHess1](https://journal.code4lib.org/wp-content/uploads/2014/07/RimkusHess1-300x193.jpg)](https://journal.code4lib.org/wp-content/uploads/2014/07/RimkusHess1.jpg)

**Figure 1:** A sample volume in the legacy delivery format ([http://brittlebooks.library.illinois.edu/brittlebooks\_open/Books2009-05/hach0001parhac/hach0001parhacv01900i00003](http://brittlebooks.library.illinois.edu/brittlebooks_open/Books2009-05/hach0001parhac/hach0001parhacv01900i00003)/).

Once HathiTrust made its “HTFeed” suite of Perl scripts ([http://www.hathitrust.org/ingest\_tools](http://www.hathitrust.org/ingest_tools)) available in 2012 to facilitate the ingest of content managed by partner institutions, however, the UIUC Library decided to reconsider its own reliance on the solution described above in favor of the HathiTrust Digital Library for certain materials. This policy review was catalyzed by HathiTrust’s successfully withstanding a Trusted Repository Audit Certification review ([http://www.hathitrust.org/trac](http://www.hathitrust.org/trac)) administered in 2011 by the Center for Research Libraries, further assuring partner institutions of HathiTrust’s ability to reliably steward their digital content in the long-term. With anecdotal evidence that scholars are beginning to strongly favor large-scale, readily accessible services such as the HathiTrust Digital Library over dispersed, difficult-to-locate “boutique” collections of digital materials, the UIUC Library decided to contribute as many of its locally digitized volumes to HathiTrust as possible.

## Implementation

What does it take to submit locally managed content to the HathiTrust Digital Library? The requirements are strict, and the process has multiple steps to trip one up along the way. They are best outlined on the links from the HathiTrust’s “Getting Content into HathiTrust” webpage ([http://www.hathitrust.org/ingest](http://www.hathitrust.org/ingest)). These steps will be further elaborated later in this paper. To simplify, however:

1. **Become a HathiTrust partner institution.** Access to the HathiTrust Digital Library is open to anyone. However, only [partner institutions](http://www.hathitrust.org/eligibility_agreements) may deposit items. These are generally large academic research libraries with significant print collections. Partners must be willing to pay yearly membership fees and provide metadata to HathiTrust on print holdings, among other [requirements](http://www.hathitrust.org/partnership_checklist).
2. **Do your paperwork and get it signed.** Partner institution fills out a “Digital Asset Submission Inventory” or “DASI” form ([https://docs.google.com/document/d/10Nt7hOpW5XVtvdU1tw4Yc9GSoswmwaE952TPDVB0KBU/edit?authkey=CPODvMgF](https://docs.google.com/document/d/10Nt7hOpW5XVtvdU1tw4Yc9GSoswmwaE952TPDVB0KBU/edit?authkey=CPODvMgF)) detailing how many items it wishes to submit, and what their rights status is. This form must be approved by someone with signatory authority at the partner institution prior to ingest.
3. **Modify your metadata as needed and send it to California**. Partner submits MARCXML records for all items to be ingested to the California Digital Library’s Zephir ([http://www.hathitrust.org/bib\_data\_submission](http://www.hathitrust.org/bib_data_submission)) service. Prior to submission, partner makes any changes necessary to XML records as required by HathiTrust’s Bibliographic Metadata Specifications ([http://www.hathitrust.org/bib\_specifications](http://www.hathitrust.org/bib_specifications)).
4. **Make sure your files are compliant and package them.** Partner submits file packages according to specifications in the “Cloud Packaging and Validation Service” overview document ([https://docs.google.com/document/d/1OQ0SKAiOH8Xi0HVVxg4TryBrPUPtdv4qA70d8ghRltU/](https://docs.google.com/document/d/1OQ0SKAiOH8Xi0HVVxg4TryBrPUPtdv4qA70d8ghRltU/)). All page-level files must be numbered with eight digits and padding zeros. File packages include:

                     a. image files in JPEG2000 or TIFF format

                     b. page-level OCR transcript files in UTF-8

                     c. if available, page-level word coordinate files

                     d. a checksum file listing every file in package and its corresponding md5 hash value

                     e. a valid meta.yaml file to provide additional administrative or technical metadata

The intricacies of these requirements are explained in the Cloud Packaging and Validation Service document cited above. Of all the requirements, however, the provision of valid image files has proven the most onerous to UIUC. HathiTrust enforces very strict technical metadata requirements on image files. The table below, for example, details UIUC’s local JPEG2000 image profile as modified to meet HathiTrust’s requirements for embedded technical metadata.

| Embedded Metadata Tag | Value |
| --- | --- |
| *JP2 Header Metadata* |  |
| 1\. CompressionScheme | JPEG-2000 |
| 2\. Format | JPEG-2000 |
| 3\. MIMETYPE | image/jp2 |
| 4\. Brand (or “MajorBrand”) | jp2 |
| 5\. MinorVersion | 0 |
| 6\. Compatibility (or “CompatibleBrands”) | jp2 |
| 7\. Xsize (or “ImageWidth”) | matches XMP Header Metadata/tiff:imageWidth (see #16 below) |
| 8\. Ysize (or “ImageHeight”) | matches XMP Header Metadata/tiff:imageHeight (see #17 below) |
| 9\. NumberOfLayers | mandatory, but no required value |
| 10\. NumberDecompositionLevels | mandatory, but no required value |
| 11\. BitsPerSample | 8 for Grayscale, (8,8,8  \[24-bit\]) for sRGB |
| 12\. XSamplingFrequency | generally between 300/1 and 600/1, matches XMP Header Metadata/tiff:Xresolution (see #23 below) |
| 13\. YSamplingFrequency | generally between 300/1 and 600/1, matches XMP Header Metadata/tiff:Yresolution (see #24 below) |
| 14\. SamplingFrequencyUnit | mandatory, matches XMP Header Metadata/SamplingFrequencyUnit (see #25 below) |
| *XMP Header Metadata* |  |
| 15\. xpacket field | W5M0MpCehiHzreSzNTczkc9d |
| 16\. tiff:imageWidth | matches JP2/Xsize (see #7 above) |
| 17\. tiff:imageHeight | matches JP2/Ysize (see #8 above) |
| 18\. tiff:BitsPerSample | 8 for Grayscale, (8,8,8 \[24-bit\]) for sRGB |
| 19\. tiff:Compression | 34712 (=JPEG2000) |
| 20\. tiff:PhotometricInterpretation | 2 for sRGG, 1 for Grayscale |
| 21\. tiff:Orientation | 1 (Horizontal/Normal) |
| 22\. tiff:SamplesPerPixel | 3 for sRGB, 1 for Grayscale |
| 23\. tiff:Xresolution | generally between 300/1 and 600/1, matches JP2/XSize (see #12 above) |
| 24\. tiff:Yresolution | generally between 300/1 and 600/1, matches JP2/YSize (see #13 above) |
| 25\. SamplingFrequencyUnit | mandatory, matches JP2SamplingFrequencyUnit (see #14 above) |
| 26\. tiff:ResolutionUnit | 2 (inches) |
| 27\. dc:source | object $id/$filename |
| 28\. tiff:DateTime | formatted YYYY:mm:ddTHH:MM:SS, for example 2010:05:24T13:45:30 |
| 29\. tiff:Artist | University of Illinois at Urbana-Champaign Library |
| 30\. tiff:Make | make of camera/scanner |
| 31\. tiff:Model | model of camera/scanner |

As sensible as these requirements are, the UIUC Library found that none of the files it intended to submit to HathiTrust met all of them, and that non-compliance differed from one batch of files to the next, depending on the imaging hardware and workflow that produced them. Bringing UIUC’s files into compliance required a level of advanced file surgery (often mistakenly referred to as “massage”) skills not necessarily in the toolkit of most librarians.

To aid partners in the pre-ingest process, HathiTrust provides a tool called HTFeed (download link available at [http://bit.ly/1fphFai](http://bit.ly/1fphFai)), a Perl 5 application developed at the University of Michigan for packaging content for submission. HTFeed splits file preparation into stages to isolate and remediate problems, and allows users to code custom stages to address problems unique to their own files. When the UIUC Library began working with the tool in 2013, its staff had limited knowledge of the Perl programming language, and it hired a student programmer to customize the application. HTFeed is configured to run in a Linux server environment, and requires a strong knowledge of Linux and Perl to effectively customize and support.

HTFeed relies on a number of helper applications, such as JHOVE ([http://sourceforge.net/projects/jhove/](http://sourceforge.net/projects/jhove/)) to identify embedded technical metadata problems, ExifTool ([http://www.sno.phy.queensu.ca/~phil/exiftool/](http://www.sno.phy.queensu.ca/~phil/exiftool/)) to repair missing technical metadata in image file headers, and Kakadu ([http://www.kakadusoftware.com/](http://www.kakadusoftware.com/)) to create JPEG2000 files within the HTFeed framework. In addition to customizations of the HTFeed tool, UIUC also developed a remediation process that uses ImageMagick to convert invalid JPEG2000 image files to Tagged Image File Format (TIFF) with an enumerated sRGB colorspace prior to conversion by Kakadu to a Hathi-compatible JPEG200.\[[1](https://journal.code4lib.org/articles/#note1)\] By December 2013, UIUC thought it had remediated and submitted 1400 locally digitized volumes for ingest, but they were rejected by HathiTrust for nonconformance to their requirements.

Troubleshooting these problems proved difficult at first, especially prior to the 2014 introduction of HathiTrust’s cloud validation tools for single images ([http://babel.hathitrust.org/feed/validate\_image.html](http://babel.hathitrust.org/feed/validate_image.html)) and complete object packages ([http://bit.ly/1jboMIC](http://bit.ly/1jboMIC)), both of which provide precise reports on exact problems with files prior to submission. With a better understanding of HathiTrust’s true ingest requirements afforded by these tools, the UIUC Library began to write its own tools in the .Net programming language in January 2014 to further remediate its 1400 volumes that had failed upon ingest. Image file metadata, it turned out, was not the only problem. UIUC also had many books without page-level OCR text files in UTF-8, and rectified this using the ABBY Fine Reader ([http://finereader.abbyy.com/](http://finereader.abbyy.com/)) software.

Why did this process prove so challenging? UIUC’s book digitization programs have gone through a variety of changes over the years in file format standards and the hardware and software used in production workflows, a problem when consistency of technical metadata is important. For example, UIUC’s Brittle Books program has employed at least two vendors in the seven years of its existence, each of whom used a variety of imaging equipment and produced master files in different formats (TIFF and JPEG-2000). In addition, UIUC’s Digital Content Creation unit and its precursor Digital Services and Development have utilized a variety of different workflows over the years tied to different types of imaging equipment (flatbed scanner, copystand, sheet-fed scanner). As representative cases, the three examples below furnish a detailed view of packages that were rejected by HathiTrust ingest tools and required a significant amount of invasive remediation.

#### [![RimkusHess2](https://journal.code4lib.org/wp-content/uploads/2014/07/RimkusHess2-150x150.jpg)](https://journal.code4lib.org/wp-content/uploads/2014/07/RimkusHess2.jpg)Example 1: Illinois Magazine and Yearbook Archive – *Illinois Chemist* ([http://catalog.hathitrust.org/Record/100072274](http://catalog.hathitrust.org/Record/100072274))

The Illinois Chemist was a quarterly journal published by the UIUC Chemistry Department 1915-1925. In 2008, the first 5 volumes were digitized using an i2s Digibook Suprascanner A0 at the OCLC Preservation Service Center for ingest into the now inactive Illinois Magazine and Yearbook Archive (IMAY), originally available in an access system called Olive Software Active Magazine.

| Legacy Package | HathiTrust Requirement | Solution |
| --- | --- | --- |
| Image files 300dpi grayscale TIFF | Continuous tone images must be in the JPEG 2000 format | Image files modified using [HathiTrust Remediate Perl scripts](https://www.google.com/url?q=https%3A%2F%2Fbitbucket.org%2Fkirkhess%2Fhathitrustremediate&sa=D&sntz=1&usg=AFQjCNED46DqvvgDxUs_6ml9ZRGyk5RTDw). |
| Image files numbered according to UIUC convention | image files numbered sequentially as eight-digit file names with padding zeros | Image files renumbered using custom VB.Net tool |
| OCR files in PrXML format | page-level OCR transcript files encoded in UTF-8 | New OCR files generated using Abbyy Fine Reader 11 |
| No MARCXML file | MARCXML file conformant to HathiTrust bibliographic specifications ([http://www.hathitrust.org/bib\_specifications](http://www.hathitrust.org/bib_specifications)) | MARCXML file generated using locally developed  z39.50 service and GetMarc |
| No checksum file | checksum file listing every file in package and its corresponding md5 hash value | Package checksummed and zipped using locally developed VB.Net utility, HathiZipAndSubmit. |

#### [![RimkusHess3](https://journal.code4lib.org/wp-content/uploads/2014/07/RimkusHess3-150x150.jpg)](https://journal.code4lib.org/wp-content/uploads/2014/07/RimkusHess3.jpg)Example 2: Project Unica – *Mensa regum, or, the table of kings* ([http://catalog.hathitrust.org/Record/100008881](http://catalog.hathitrust.org/Record/100008881))

“Project Unica is an initiative of The Rare Book & Manuscript Library of the University of Illinois at Urbana-Champaign to produce high quality digital facsimiles of printed books that exist in only one copy”\[[2](https://journal.code4lib.org/articles/#ref2)\]. Over the years, UIUC has used a variety of imaging hardware to serve the project, and named files using a locally developed convention to indicate scanning order, often with a letter to indicate non-textual material such as the spine or cover (e.g. 0000001000000b.jp2) and either a number for textual material or two letters (e.g. 0000430000ar.jp2). UIUC scanned most books in full color, using an embedded 48bit Adobe Photoshop RGB colorspace and a restricted embedded ICC Profile, frequently using a Nikon D200 camera. No XMP metadata was stored in the files, only JPEG2000 tags. These qualities made Project Unica files particularly difficult to remediate.

| **Legacy Package** | **HathiTrust Requirement** | **Solution** |
| --- | --- | --- |
| JPEG2000 image files with Adobe Photoshop RGB colorspace and a restricted embedded ICC Profile | sRGB color space, no embedded ICC profile | Files converted to intermediary TIFF using ImageMagick, color profiles stripped and replaced with an enumerated 24bit sRGB colorspace or 8bit Grayscale colorspace, and then converted back to JPEG-2000\[[3](https://journal.code4lib.org/articles/#ref3)\] using Kakadu kdu-compress using the recommended settings outlined in the HTFeed application |
| Image files numbered according to Project Unica convention | image files numbered sequentially as eight-digit file names with padding zeros | Image files renumbered using local scripts |
| No XMP metadata | XMP metadata must be present, and must meet HathiTrust requirements | Missing XMP metadata recreated and added into the intermediate images using HathiTrustRemediate. Some packages had the Artist and Camera Make & Model added to YAML file. |
| No OCR file | page-level OCR transcript files encoded in UTF-8 | New OCR files generated using Abbyy Fine Reader 11 |
| No MARCXML file | MARCXML file conformant to HathiTrust bibliographic specifications ([http://www.hathitrust.org/bib\_specifications](http://www.hathitrust.org/bib_specifications)) | MARCXML file generated with GetMarc z39.50 service. |
| No checksum file | checksum file listing every file in package and its corresponding md5 hash value | Package checksummed and zipped using HathiZipAndSubmit. |

#### [![RimkusHess4](https://journal.code4lib.org/wp-content/uploads/2014/07/RimkusHess4-150x150.jpg)](https://journal.code4lib.org/wp-content/uploads/2014/07/RimkusHess4.jpg)Example 3: Brittle Books – *De Isocratis paedogogia* ([http://catalog.hathitrust.org/Record/100008484)](http://catalog.hathitrust.org/Record/100008484)

The Brittle Books project, managed by UIUC library’s preservation unit, scans and reproduces physically damaged books to provide access to users. Legacy files were named with two portions, a display order in the first 6 characters and an alphanumeric code where alpha characters indicated not textual content. Files were OCR’d into a Latin-1 ISO-8859-1 plain text file, as well as an Adobe PDF and TEI.xml. Page Images were bitonal, identified as having a 1bit sRGB enumerated colorspace, and scanned by an external vendor at 600dpi. No camera make, model, artist or tiff metadata was embedded by the vendor.

| **Legacy Package** | **HathiTrust Requirement** | **Solution** |
| --- | --- | --- |
| JPEG2000 image files, 1bit sRGB enumerated colorspace, and scanned by an external vendor at 600dpi | must be 8-bit greyscale or 24-bit sRGB | JPEG2000 masters decompressed and converted to intermediate TIFF images using ImageMagick, converted to 8bit Grayscale, new JPEG2000 masters created using Kakadu kdu\_compress, using the recommended settings outlined in the HTFeed application |
| Image files numbered according to Brittle Books convention | image files numbered sequentially as eight-digit file names with padding zeros | Image files renumbered using local scripts |
| No XMP metadata | XMP metadata must be present, and must meet HathiTrust requirements | Missing XMP metadata recreated and added into the intermediate images using HathiTrustRemediate. Some packages had the Artist and Camera Make & Model added to YAML file. |
| OCR data embedded in PDF file | page-level OCR transcript files encoded in UTF-8 | OCR text was extracted from PDF file into a single file using pdftotext ([http://en.wikipedia.org/wiki/Pdftotext](http://en.wikipedia.org/wiki/Pdftotext)) and converted to UTF-8, and split into page files using a locally developed VB.net script to match the correct naming scheme for each page. |
| No checksum file | checksum file listing every file in package and its corresponding md5 hash value | Package checksummed and zipped using HathiZipAndSubmit. |

## Packaging Workflow Steps

\[[4](https://journal.code4lib.org/articles/#note4)\] As is evident from the examples above, package preparation workflows varied considerably based on the files in question. In general, however, workflow steps invariably include:

**1\. Prepare files**: The HathiTrust Cloud ingest method prefers a single folder per OBJID, named with the OBJID w/o the namespace. For example, if using an object’s barcode as its unique identifier with object id uiuc.30112108161222, create a folder called **30112108161222**

**2\. Copy and create files**: the new folder should contain either 600dpi TIFF files for bitonal images, or 300, 400, or 600dpi JP2 files for continuous tone images. The file name should be sequential numbers starting with 00000001.jp2 or 00000001.tif. A OBJID can have both TIF and JP2 files. Each image file should have a corresponding UTF-8 OCR text file with the same filename with the .txt extension.

**3\. Create metadata**: Two metadata files are required for the Cloud Ingest format, marc.xml and meta.yml. The MarcXML may come from a library catalog z39.50 server with a client such as the one included with MarcEdit \[[5](https://journal.code4lib.org/articles/#note5)\]. The marc.xml file must be valid XML with a datafield 955 added with at least one subfield $b for the OBJID value. Optionally, a $v subfield can be added for volume enumeration and chronological information about the item. Three common problems are missing or invalid OCLC# in 035, an invalid length string in 008, or missing dates in 008 which may cause  problems with rights determination.

```
<datafield ind1=" " ind2=" " tag="955">
   <subfield code="b">30112108161222</subfield>
   <subfield code="v">v.3: no.1 (1894)</subfield> 
</datafield>
```

Example 955$b and 955$v values

The meta.yml file requirements are detailed in HathiTrust’s sample file ([https://docs.google.com/document/d/1iAcgd1zgrVXw3E2enuH6nx\_H0qV9wE\_XOgQCDxJDuxc](https://docs.google.com/document/d/1iAcgd1zgrVXw3E2enuH6nx_H0qV9wE_XOgQCDxJDuxc/edit)). Note only the capture date and agent are required. An optional pagedata section can be created to detail information about each page such as a label or page number.

```
capture_date: 2008-03-06T11:50:12-06:00
capture_agent: IU
```

meta.yml with required values only

**4\. Validate files:**  For help in validating files, rely on the single-image validator (http://bit.ly/1gvD9q7), full-volume validator (http://bit.ly/1jboMIC), and HTFeed packaging tools, which includes an image validation utility validate\_images.pl (http://bit.ly/1fphFai). Additionally, you may be required to manually identify problems using your own tools. ExifTool is useful for pinpointing problems, and other tools such as JHOVE can also be used.

**5\. ImageMagick, Kakadu, and ExifTool Remediation Examples** Ideally, all of the files are valid and this step is not necessary. However, if it is, here are some examples of remediation using ImageMagick, Kakadu and ExifTool. \[[6](https://journal.code4lib.org/articles/#note6)\]              

**Example 1.** ImageMagick Perl (from remediate.pl), remediating colorspace and profile.

```
my $file; #file to test;
my $image = Image::Magick->new;
my $old = $image->Read($file );

# ColorSpace should be sRGB or Grayscale, and profile should be sRGB for color images.
$property = $image->GetAttribute("colorspace");
print("colorspace- $property\n");
if ( $property ne "Grayscale" ) {
  $image->Set(colorspace=>'sRGB');
  $image->Strip();
  $image->Profile( '$config_folder/sRGB.icm' );
  print "---Colorspace/ICMProfile changed---\n";
}
```

**Example 2.** ImageMagick commands to decompress a compressed file, add a sRGB enumerated profile, set the colorspace to sRGB, the depth to 8, resample to 300dpi with the units per inch.

```
convert $input +compress -profile ./sRGB.icm -colorspace sRGB -depth 8 -resample 300x300 -units PixelsPerInch $output
```

**Example 3.** HathiTrust recommended Kakadu commands for JP2 creation

```
kdu_compress -quiet -i 00000001.jp2 -o 30112108161222/00000001.jp2 Clevels=7 
Clayers=8 Corder=RLCP Cuse_sop=yes Cuse_eph=yes 
"Cmodes=RESET|RESTART|CAUSAL|ERTERM|SEGMARK" -no_weights -slope 42988
```

**Example 4.** Exiftool Perl example (from compress\_tif\_jp2.pl), updating tags

```
use Image::ExifTool;

sub update_tags {

    my $exifTool = shift;
    my $outfile = shift;
    my $infile = shift;

    my $res;

    if(defined $infile) {
        $res = $exifTool->WriteInfo($infile,$outfile)
    } else {
              $res = $exifTool->WriteInfo($outfile)
    }

    if ( !$res ) {
        print("OperationFailed");
    }
}

sub main{

    foreach my $infile ($ARGV[0]) {
       die("$infile does not exist") if !-e $infile;
       # reset remediator;
       my $exifTool = new Image::ExifTool;
       my $newFields = {};
       my $oldFields = {};
       my $outfile = $infile;

       update_tags($exifTool,"$outfile");
    }
}

main();
```

**Example 5.** Exiftool – set the XMP-dc:Source value for all jp2 files in the current folder

```
exiftool '-XMP-dc:Source<30112108161222/$FileName' *.jp2
```

**6\. Generate checksum:** a file named **checksum.md5.** This file can be generated with md5sum on Linux or md5 -r on Mac OS X. Windows does not come with a checkusum utility, one option recommended by HathiTrust is md5sum from CoreUtils for Windows: ([http://gnuwin32.sourceforge.net/packages/coreutils.htm](http://gnuwin32.sourceforge.net/packages/coreutils.htm)).

```
md5sum * > ~/checksum.md5
```

**7\. Zip Folder**

```
zip -r 1751155v3i1.zip 1751155v3i1
```

**HathiZipAndSubmit:** VB.net code snippets for steps 6 & 7 –

```
Sub ProcessFolder(folderName As String)

lblStatus.Text = String.Format("Processing Folder: {0}  Folders Processed: {1}", "..." & 
folderName.Substring(txtFolder.Text.Length), lblStatus.Tag)

If Form1.stopping = True Then Exit Sub

Dim fldrs = Directory.GetDirectories(folderName)

If fldrs.Length > 0 Then
          'there are sub folders to recurse into them
          txtStatus.WriteLine("FOLDER: " & folderName)
          For Each fldr In fldrs
              ProcessFolder(fldr)
          Next
     Else
          lblStatus.Tag = lblStatus.Tag + 1
          'no subfolders, so process this folder as if it contains a digitized volume
          If chkChecksum.Checked Then
          MakeChecksum(folderName)
          End If
          ZipFolder(folderName)
          If chkDeleteFolder.Checked Then
          Directory.Delete(folderName, True)
          txtStatus.WriteLine("Deleted " & folderName)
          End If
     End If
     lblStatus.Text = String.Format("Processing Folder: {0}  Folders Processed: {1}", "..." & 
folderName.Substring(txtFolder.Text.Length), lblStatus.Tag)
          txtStatus.WriteLine("")
     Application.DoEvents()
End Sub

Private Sub ZipFolder(folderName As String)
     Dim parent = Directory.GetParent(folderName).FullName
     Dim basename = Path.GetFileName(folderName) & ".zip"
     Dim newZipFile = Path.Combine(parent, basename)

     Using zstrm As New FileStream(newZipFile, FileMode.Create, FileAccess.Write)
           Using zarc As ZipArchive = New ZipArchive(zstrm, ZipArchiveMode.Create, False)
                AddFolderToZip(zarc, folderName)
           End Using
           zstrm.Close()
      End Using

txtStatus.WriteLine("Created: " & newZipFile)
End Sub

Private Sub AddFolderToZip(zarc As ZipArchive, fldrname As String)
     Dim startingFolderLen = fldrname.Length - Path.GetFileName(fldrname).Length

     For Each fl As String In Directory.GetFiles(fldrname)
           Dim zent = 
zarc.CreateEntry(fl.Substring(startingFolderLen).Replace(
Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar))
           Using fstrm As New FileStream(fl, FileMode.Open, FileAccess.Read)
           Using zstrm As Stream = zent.Open
                   fstrm.CopyTo(zstrm)
                   zstrm.Close()
           End Using
           fstrm.Close()
         End Using
     Next

     For Each fldr As String In Directory.GetDirectories(fldrname)
         AddFolderToZip(zarc, fldr)
     Next
End Sub

Private Sub MakeChecksum(newfolder As String)
     Dim setupStream As Boolean = False
     Dim outName As String
     Dim strmWtr As StreamWriter = Nothing

     'delete old checksum file
     If File.Exists(Path.Combine(newfolder, "checksum.md5")) Then
          File.Delete(Path.Combine(newfolder, "checksum.md5"))
     End If

    Dim files As FileInfo() = New DirectoryInfo(newfolder).GetFiles()
    Dim hashes = New Dictionary(Of String, String)

    For Each filez In files
        If Not setupStream Then
              Dim foldername As String = Path.GetDirectoryName(filez.FullName)
              outName = Path.Combine(foldername, "checksum.md5")
              strmWtr = New StreamWriter(outName)
              setupStream = True
         End If

        Dim ext As String = Path.GetExtension(filez.FullName).ToLower
        If ext.Length > 0 Then
              ComputeMD5(filez, hashes)
        End If
     Next

     Using strmWtr
             For Each h In hashes
                  strmWtr.WriteLine(String.Format("{0} *{1}", h.Value, Path.GetFileName(h.Key)))
             Next
             strmWtr.Flush()
     End Using
     txtStatus.WriteLine("CREATED: checksum.md5")
End Sub

Private Sub ComputeMD5(file As FileInfo, hashes As Dictionary(Of String, String))
     Using strm As Stream = file.Open(FileMode.Open)
             Using hsh As MD5 = MD5.Create()
                   Dim data() As Byte = hsh.ComputeHash(strm)
                   Dim sb As New StringBuilder
                   For i As Integer = 0 To data.Length - 1
                      sb.Append(data(i).ToString("x2"))
                   Next
                   hashes.Add(file.FullName, sb.ToString)
              End Using
              strm.Flush()
          End Using
      End Sub
```

**8\. Submit metadata to zephir:** [requirements](http://www.hathitrust.org/bib_specifications) and [Zephir instructions.](http://www.hathitrust.org/bib_data_submission)

**9\. Submit required paperwork to Hathi:** feedback@issues.hathitrust.org

**10\. Check Ingest logs:** [http://www.hathitrust.org/ingest\_logs](http://www.hathitrust.org/ingest_logs)

## Lessons Learned

UIUC came away from this project with several key lessons learned. Even the most difficult files can be remediated, but the need for a staff programmer with some knowledge of image formats and the Perl programming language will make this challenging for many institutions.

In addition, if partner institutions manage files in the JPEG2000 format, they will need to develop strong knowledge of its technical metadata elements. While this paper does not address the “Is JPEG2000 a reliable preservation format?” question, the authors’ experience with remediating JPEG2000 files for HathiTrust ingest continually underscored their own insufficient knowledge of the format’s idiosyncrasies. As a benefit, they and many of the staff at their institution, as well as partner vendors of digital imaging hardware, software, and services, have all come away from this project with a heightened understanding of the way technical metadata is managed in JPEG2000’s JP2 and XMP headers. HathiTrust has certainly simplified its process for partner-submitted content with the introduction of cloud validation tools earlier this year. However, many partner institutions will likely find that the process is still a daunting challenge. The authors of this article hope that sharing information about their experience ingesting locally digitized content into the HathiTrust Digital Library will help colleagues at other institutions who have as yet been unable to do so.

## References

#### Software Tools

AbbyFineReader: [http://finereader.abbyy.com/](http://finereader.abbyy.com/)

CoreUtils for Windows: [http://gnuwin32.sourceforge.net/packages/coreutils.htm](http://gnuwin32.sourceforge.net/packages/coreutils.htm)

ExifTool: [http://www.sno.phy.queensu.ca/~phil/exiftool/](http://www.sno.phy.queensu.ca/~phil/exiftool/)

HathiTrust Ingest Tools: [http://www.hathitrust.org/ingest\_tools](http://www.hathitrust.org/ingest_tools)

HTFeed image remediation tools: [http://bit.ly/1fphFai](http://bit.ly/1fphFai)

HTFeed modifications for UIUC remediation: [https://bitbucket.org/kirkhess/hathitrustremediate](https://bitbucket.org/kirkhess/hathitrustremediate)

JHOVE: [http://sourceforge.net/projects/jhove/](http://sourceforge.net/projects/jhove/)

Kakadu: [http://www.kakadusoftware.com/](http://www.kakadusoftware.com/)

MarcEdit: [http://marcedit.reeset.net/](http://marcedit.reeset.net/)

pdftotext: [http://en.wikipedia.org/wiki/Pdftotext](http://en.wikipedia.org/wiki/Pdftotext)

#### HathiTrust Documentation

Bibliographic Metadata Specifications: [http://www.hathitrust.org/bib\_specifications](http://www.hathitrust.org/bib_specifications)

Bibliographic Metadata Submission: [http://www.hathitrust.org/bib\_data\_submission](http://www.hathitrust.org/bib_data_submission)

Cloud Validation and Packaging Service: [https://docs.google.com/document/d/1OQ0SKAiOH8Xi0HVVxg4TryBrPUPtdv4qA70d8ghRltU/](https://docs.google.com/document/d/1OQ0SKAiOH8Xi0HVVxg4TryBrPUPtdv4qA70d8ghRltU/)

Digital Asset Submission Inventory (DASI): [https://docs.google.com/document/d/10Nt7hOpW5XVtvdU1tw4Yc9GSoswmwaE952TPDVB0KBU/edit?authkey=CPODvMgF](https://docs.google.com/document/d/10Nt7hOpW5XVtvdU1tw4Yc9GSoswmwaE952TPDVB0KBU/edit?authkey=CPODvMgF)

Ingest Overview: [http://www.hathitrust.org/ingest](http://www.hathitrust.org/ingest)

Partnership Checklist: [http://www.hathitrust.org/partnership\_checklist](http://www.hathitrust.org/partnership_checklist)

Partnership Eligibility: [http://www.hathitrust.org/eligibility\_agreements](http://www.hathitrust.org/eligibility_agreements)

Sample meta.yml File: [https://docs.google.com/document/d/1iAcgd1zgrVXw3E2enuH6nx\_H0qV9wE\_XOgQCDxJDuxc](https://docs.google.com/document/d/1iAcgd1zgrVXw3E2enuH6nx_H0qV9wE_XOgQCDxJDuxc)

Single Image Validator: [http://babel.hathitrust.org/feed/validate\_image.html](http://babel.hathitrust.org/feed/validate_image.html)

## Footnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\]. Source code: [https://bitbucket.org/kirkhess/hathitrustremediate](https://bitbucket.org/kirkhess/hathitrustremediate)

\[[2](https://journal.code4lib.org/articles/#ref2)\]. From project summary at [http://illinoisharvest.grainger.illinois.edu/results.asp?searchtype=collectioncontent&newsearch=1&collID=2797&collname=Project%20Unica](http://illinoisharvest.grainger.illinois.edu/results.asp?searchtype=collectioncontent&newsearch=1&collID=2797&collname=Project%20Unica)

\[[3](https://journal.code4lib.org/articles/#ref3)\]. While UIUC took pains to consolidate its workflows to the JPEG-2000 format, HathiTrust staff has since made it clear that they are often able to more flexibly handle the ingest of non-conformant TIFF files, which may have simplified the steps outlined above.

\[[4](https://journal.code4lib.org/articles/#ref4)\]. A summary of the [checklist](https://docs.google.com/document/d/1OQ0SKAiOH8Xi0HVVxg4TryBrPUPtdv4qA70d8ghRltU/edit) available at the HathiTrust site.

\[[5](https://journal.code4lib.org/articles/#ref5)\]. MarcEdit – [http://marcedit.reeset.net/](http://marcedit.reeset.net/)

\[[6](https://journal.code4lib.org/articles/#ref6)\]. It’s possible to batch remediate files with Photoshop, but through testing UIUC found the use of kdu\_compress consistently produced valid JP2 files which validate in the single image validator.

## About the Authors

**Kyle R. Rimkus**  
Kyle Rimkus is Preservation Librarian at the University of Illinois at Urbana-Champaign Library, where he is responsible for coordinating a comprehensive digital preservation program.  
[rimkus@illinois.edu](https://journal.code4lib.org/articles/)  
**Kirk M. Hess**  
Kirk Hess is Digital Humanities Specialist at the University of Illinois at Urbana-Champaign Library, and holds a MLIS from the University of Illinois at Urbana-Champaign.  
[kirkhess@illinois.edu](https://journal.code4lib.org/articles/)  
[http://www.library.illinois.edu/people/bios/kirkhess/](http://www.library.illinois.edu/people/bios/kirkhess/)
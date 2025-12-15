---
title: "Generating Standardized Audio Technical Metadata:  AES57"
source: "https://journal.code4lib.org/articles/10828"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-10-20
created: 2025-01-10
description: "Long-term access to digitized audio may be heavily dependent on the quality of technical metadata captured during digitization. The AES57-2011 standard offers a standardized method of documenting fairly comprehensive technical information, but its complexity may be confusing. In an effort to lower the barrier to use, we have developed software that generates valid AES57 files [...]"
tags:
  - "clippings"
---
# Generating Standardized Audio Technical Metadata:  AES57
Jody L. DeRidder

Long-term access to digitized audio may be heavily dependent on the quality of technical metadata captured during digitization. The AES57-2011 standard offers a standardized method of documenting fairly comprehensive technical information, but its complexity may be confusing. In an effort to lower the barrier to use, we have developed software that generates valid AES57 files for digitized audio, using output from FITS ([File Information Tool Set](http://projects.iq.harvard.edu/fits/home)) and a few fields of information from a tab-delimited spreadsheet. This article will describe the logic used, the fields required, the basic process, applications, and options for further development.

Long-term access to digitized audio may be heavily dependent on the quality of technical metadata captured during digitization.  In 2011, the Audio Engineering Society (AES) released a new standard for technical audio metadata:  the [AES57-2011](http://www.aes.org/publications/standards/search.cfm?docID=84) (Audio Engineering Society \[updated 2015\]), which covers audio object structures for preservation and restoration (both for analog and digital). Prior to 2011, the best standard available for audio technical metadata was [audioMD](http://www.loc.gov/standards/amdvmd/audiovideoMDschemas.html) (Library of Congress \[updated 2011\]), which is far less extensive. Also released in 2011 was the [AES60](http://www.aes.org/publications/standards/search.cfm?docID=85) (Audio Engineering Society \[updated 2015\]) for descriptive metadata, which extends the unqualified Dublin Core fields to add an additional 4 fields (Version, Publication History, Metadata Provider, and Entity Type) ([Audio Engineering Society 2011](http://www.aes.org/publications/standards/search.cfm?docID=85)).

An excellent review of the AES57 standard while in development was provided by [Jane Otto](http://dx.doi.org/doi:10.7282/T3WW7G11) \[Otto 2010\]. Broad categories of information covered by this standard include physical properties and dimensions of the analog object, signal characteristics (such as playback speed, sound field, and noise reduction), digital file characteristics (such as sample rate, bit depth, and byte order); and comments about the condition of the object. Each audio object is described by a separate AES57 document; thus a 2-reel performance (digitized into two separate audio files) would be described by two separate AES57 documents. This article will describe a method and accompanying perl script used to automatically generate the portions of AES57 technical metadata necessary for schema validation, as part of a digitization process.  The intent is to provide at least the minimal standard technical metadata necessary to ensure the ability to effectively manage digitized audio content long-term. By automating the generation of the AES57 documents, we increase the speed of metadata work while reducing the level of complexity for the digitizing staff.

Within the AES57, the audio object is described at multiple hierarchical levels: the audio object itself; the face levels within that object (such as the side of a vinyl record); the regions within the face; and the streams within each region.  Within the spreadsheet, a line is created for each audio file (audio object) and for each region (or segment) within that file which we are extracting as a separate track for online delivery.  If there are no segments, there is a single line in the spreadsheet for the file.   Since an intellectual item may span multiple files (such as a two-reel performance), our file naming system allows for sub-items (regions, or segments for web delivery) at two levels, and the level is indicated by the length of the file name, where the first segment of the file name (21 characters long) specifies the intellectual item, and the remainder indicates the sequence.  In a recording (of multiple musical segments) which spans two reels, for example, the intellectual item is identified by the first 21 characters, and the reel would be identified by the next 5 characters.  Since the reel would have multiple musical segments, it would have sub-items, each of which would be identified by more than 26 characters.  Had there been only one reel, the sub-items would be identified by the 5 characters following the first 21.

| 1  2  3  4  5  6  7  8  9  10  11  12 | `if` `(``length``(``$id``) > 26){`  `$itemID` `= ``substr``(``$id``, 0, 26);  `  `push` `(@{``$mykids``{``$itemID``}}, ``$id``);`  `}`  `elsif` `(``length``(``$id``) > 21){`  `$itemID` `= ``substr``(``$id``, 0, 21);  `  `push` `(@{``$mykids``{``$itemID``}}, ``$id``);`  `}`  `else``{ ``$itemID` `= ``$id``; }` |
| --- | --- |

Although the AES57 does not require information in the section of the schema designated for physical properties (physicalProperties), it does require a “type” attribute value (in formatList/formatRegion) that may be used to indicate information categorizing the original material with one of these values:

- analogDiscFormatRegionType   (such as a long-playing record)
- opticalDiscFormatRegionType  (Compact Disc or DVD)
- analogTapeFormatRegionType  (cassette tape or reel-to-reel)
- digitalTapeFormatRegionType  (digital tapes)
- cylinderFormatRegionType (cylinders)
- wireFormatRegionType  (wire)
- baseFormatRegionType
- formatRegionType

As this software [(fits2aes)](http://www.lib.ua.edu/wiki/digcoll/index.php/Fits2aes) was written for content undergoing digitization, it tries to identify the physical form by parsing text from the spreadsheet “format” field, entered in appropriate RDA cataloging form, such as: “1 sound tape reel: analog (10:56 min); 7 inches.” Values that must exist in the format field for correct assignment include “tape”, “cassette” or “reel” (with or without “digital”); “disc” (with either “digital” or “analog”); “roll,” or “wire.”   If the type of content cannot be determined, the “formatRegionType” value is substituted for this attribute.

| 1  2  3  4  5  6  7  8  9  10  11  12 | `undef` `$phys``;`  `if` `(``$physType` `=~ /tape/i \|\| ``$physType` `=~ /cassette/i \|\| ``$physType` `=~ /reel/i){`  `if` `(``$physType` `=~ /digital/i){ ``$phys` `= ``"digitalTapeFormatRegionType"``;}`  `else``{ ``$phys` `= ``"analogTapeFormatRegionType"``; }`  `}`  `elsif` `(``$physType` `=~ /disc/i){`  `if` `(``$physType` `=~ /analog/i){ ``$phys` `= ``"analogDiscFormatRegionType"``;}`  `elsif` `(``$physType` `=~ /digital/i){ ``$phys` `= ``"opticalDiscFormatRegionType"``;}`  `}`  `elsif` `(``$physType` `=~ /roll/i){ ``$phys` `= ``"cylinderFormatRegionType"``;}`  `elsif` `(``$physType` `=~ /wire/i){ ``$phys` `= ``"wireFormatRegionType"``; }`  `else``{ ``$phys` `= ``"formatRegionType"``;}    ` |
| --- | --- | --- | --- | --- | --- |

All regions must have their identifiers referenced in the formatList/formatRegion@ownerRef attribute. The AES57 offers many more fields for further description of the original object in the physicalProperties section, but as they are not required for validation, they have not yet been included.  Additional fields would need to be added to the spreadsheet, but this additional information would be useful from an archivist’s perspective, to provide provenance information about the original object.

Most of the information necessary to capture about the audio object itself can be extracted from the FITS ([File Information Tool Set](http://projects.iq.harvard.edu/fits/home) (Harvard 2015)) extract, though some requires reformatting.  The AES57 fields which we mapped to the FITS (version 0.8.4) fields are as follows:

| **AES57 field** | **FITS field** | **Reformatting required** |
| --- | --- | --- |
| audioObject @ID | filename |  |
| format | identity@format |  |
| audioObjectType/byteOrder | byteOrder | LITTLE\_ENDIAN = 0; BIG\_ENDIAN = 1 |
| audioObjectType/audioDataBlockSize | blockAlign |  |
| audioObjectType/audioDataEncoding | audioDataEncoding (JHOVE tool version) |  |
| audioObjectType/fileChecksum/checksumValue | md5checksum |  |
| audioObjectType/fileChecksum/checksumCreateDate | lastmodified | Transform to dateTime format |
| audioObjectType/firstSampleOffset | offset |  |
| audioObjectType/objectCreationDate | lastmodified | Transform into dateTime format\* |
| formatList@label | identity@mimetype | (optional) |
| formatList/formatRegion/wordSize | wordSize |  |
| formatList/formatRegion/soundField | channel | 4=surround; 2=stereo; 1=mono |
| formatList/formatRegion/bitDepth | bitDepth |  |
| startTime@editRate and duration@editRate | sampleRate |  |
| face/region/numChannels | channels |  |
| Duration | duration (Exiftool) | Transform into editUnit frames\* |

\* to be discussed in more detail shortly.

Templated values:

- Because the checksum type extracted from the FITS is the MD5 checksum, the script we developed will template “MD5” for the value of audioObjectType/fileChecksum/checksumKind.  Other options include SHA-1 and CRC.
- The audioObject/primaryIdentifyer@IdentifierType is templated as “FILE\_NAME” in our software. Other options would include SHELF\_NUMBER, UMID, or OTHER.
- Since this script was developed for digital files, we template the audioObject@analogDigitalFlag as FILE\_DIGITAL. Other options include ANALOG and PHYS\_DIGITAL (for digital content with a permanent physical structure).

After installing FITS (which requires Java), the form of the system call used to generate the FITS file on a Linux/Unix machine is:

```
     /path/to/fits.sh  -i   $audioFile   -o $fitsFile  >/dev/null 2>&1
```

For Windows:

```
     C:\\path\\to\\fits.bat –I $audioFile –o $fitsFile
```

In this line, “-i” precedes the full path and file name of the audio file, and “-o” precedes the full path and file name of the FITS file being generated.  The last portion of the line (after $fitsFile) simply prevents output of information to the command line during the process.

After generating the FITS file, fits2aes opens the file to check whether the WAV is well-formed and valid.  If it is not, the script will output errors identifying the FITS file name and the problem found. For example, using Perl:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `open` `(IN, ``$fits``) or ``die` `“can’t ``read` `in ``$fits``\n”;`  `while` `(``$line` `= <IN>){`  `chomp` `$line``;  `  `$line` `=~ s,\r,,;  `  `if` `(``$line` `=~ /<well\-formed.*?>true<\//){ ``$wf` `= 1;}`  `elsif` `(``$line` `=~ /<valid .*?>true<\//){ ``$valid` `= 1;}`  `}`  `close``(IN);`  `if` `(!``$valid` `&& ! ``$wf``){ ``print` `"$fits: NOT VALID and NOT WELL-FORMED\n"``;}`  `elsif` `(!``$valid``){ ``print` `"$fits: NOT VALID\n"``;}`  `elsif` `(!``$wf``){ ``print` `"$fits: NOT WELL-FORMED\n"``;}`  `}` |
| --- | --- |

If the file generated is not valid and well-formed, correction should take place before proceeding further.

The transformation of the FITS lastmodified value (in the form YYYY:MM:DD hh:mm:ss-hh:mm) to dateTime format (W3C 1997) (YYYY-MM-DDThh:mm:ss-hh:mm) is fairly straightforward:

| 1  2  3  4  5  6  7  8  9  10 | `elsif` `(``$line` `=~ /<lastmodified toolname=\"Exiftool\".*?>(.*?)<\//){`  `$adate` `= $1;`  `undef` `$ending``;`  `(``$ending` `= ``$adate``) =~ s,.*?(\-.*),\1,; `  `$adate` `=~ s,\-.*,,;  `  `$adate` `=~ s,([\d]{4})\:([\d]{2})\:([\d]{2}) ,$1\-$2\-$3 ,;  `  `$adate` `=~ s, ,T,;  `  `if` `(! ``$ending``){ ``$ending` `= ``"Z"``;}  `  `$dateC` `= ``$adate``.``$ending``; `  `}` |
| --- | --- |

The remainder of the information needed for a validating AES57 can be provided via a tab-delimited export from a spreadsheet.  As noted above, this script supports entries for singletons (one region to be used from an audio file) to file entries followed by multiple regions. Fields from the spreadsheet include file name, title, format, clip begin, clip end, region condition notes, condition notes for each of four possible streams, notes on prior or ending streams, direction, label, and speed correction. The AES57 can also accommodate security notes at the level of the region. We accommodate these by semicolon separation of the security note from any other region notes, and preceding the security note with “Security: “.  Also, as condition notes can optionally be targeted to specific clips of time within a region or stream, such clips of time can be included (in square brackets) prior to the appropriate note within the spreadsheet.  For example, to provide 3 comments (one about security) about portions of a specified region, the following formatting would be expected in the spreadsheet field for region condition notes, in the row dedicated to that region:

\[12:23-12:30\] crackly; Security: phone number; \[13:01-14:12\] background whine

Each condition note in the AES57 includes a creation date, which for our purposes is the same date as digitization.  Modification of this would require either additional spreadsheet fields or additional formatting within the notes field above.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41 | `sub` `printNotes{`  `my` `(``$noteField``,``$sampleRate``, ``$speedCorrection``, ``$dateC``, ``$cond``) = ``@_``;`  `undef` `@mynotes``;`  `if` `(``$cond` `=~ /;/){ `  `@mynotes` `= ``split``(``";"``, ``$cond``);`  `}`  `else``{ ``push` `(``@mynotes``, ``$cond``);}`  `foreach` `$note` `(``@mynotes``){`  `undef` `$myClipBegin``;`  `undef` `$myClipEnd``;`  `undef` `$mystart``;`  `undef` `$myduration``;`  `undef` `$sec``;  `  `if` `(``$note` `=~ /\[ *([\d\:]+) *\-([\d\:]+) *\] *(.*)/){`  `$myClipBegin` `= $1;`  `$myClipEnd` `= $2;`  `$note` `= $3;`  `$mystart` `= ``&calcFrames``(``$myClipBegin``, ``$sampleRate``, ``$speedCorrection``);`  `$myframes` `= ``&calcFrames``(``$myClipEnd``, ``$sampleRate``, ``$speedCorrection``);`  `$myduration` `= ``$myframes` `- ``$mystart``;`  `}`  `if` `(``$note` `=~ /(.*?)Security *\:(.*)/i){`  `$note` `= $1.$2;`  `$noteField` `= ``"securityNote"``;`  `print` `OUT ``"      <$noteField>"``.``$note``.``"</"``.``$noteField``.``">\n"``;`  `}`  `else` `{`  `$noteField` `= ``"conditionNote"``;`  `if` `(``$note``){ ``print` `OUT ``"      <$noteField>\n        <note>"``.``$note``.``"</note>\n"``;`  `if` `(``$myClipBegin``){`  `&printRange``(``"timeRange"``, ``$myClipBegin``, ``$myClipEnd``,``$sampleRate``,``$speedCorrection``);`  `}`  `print` `OUT ``"        <creationDate>$dateC</creationDate>\n"``;`  `print` `OUT ``"      </"``.``$noteField``.``">\n"``;`  `}`  `}`  `}`  `}` |
| --- | --- |

Time codes for clip begin and clip end fields are entered into the spreadsheet in hours:minutes:seconds format (used by other scripts to generate Audio Decision List files and to generate derivatives for web delivery).  These time codes are used with the sample rate and speed correction to determine the duration (and startTime, if not zero).  Fields in AES57 that can have a time range element include face, region, and condition notes. The time range type (timeRangeType) elements include required duration and startTime elements which are of type “editUnit” (frames).  Each of these requires an editRate and the optional fields factorNumerator and factorDenominator, all three of which are positive integers.   Clarification of these fields comes from the [EBUCore metadata set](http://citeseerx.ist.psu.edu/viewdoc/download;?doi=10.1.1.278.4772&rep=rep1&type=pdf) (EBU 2013) from which they are drawn (as subelements of the aspectRatioType).  The intent is to describe the aspect ratio of the resource compared to the original recording, in order to indicate the amount of speedup or slowdown used to generate the digitized product. Here the factorNumerator is the numerator of the ratio and the factorDenominator is the denominator, and the sample rate is used for the “editRate” value.  The sample rate is one of the fields extracted from the FITS file, and represents the rate at which the audio was sampled, expressed in Hertz, such as 22000, 44100, 48000, 96000, etc.  The formula (EBU 2013) used to determine the editUnit is:

editUnit = 1 / (editRate \* (factorNumerator / factorDenominator))

In the spreadsheet, the speed correction value is entered as whole numbers and decimals:  for example, 1.5 indicates the speed is one and a half times faster, whereas .5 means the speed is half as fast as the original.  This is translated into a numerator and denominator in the following way:

| 1  2  3  4 | `if` `(``$speedCorrection``){`  `$numerator` `= ``$speedCorrection` `* 100;`  `$denominator` `= 100;`  `}` |
| --- | --- |

So if the speed was doubled, the value “2” is entered in the spreadsheet, and the numerator becomes 200 while the denominator becomes 100, as 200/100 = 2.

Thus if the sample rate (editRate) is 44100 and no change has been made in the speed, then an editUnit value is:  1/(44100\*(1/1) = 0.00002267573696. However, if the speed correction value is 2, the editUnit becomes 1/(44100 \* (200/100)) = 0.0000113786848 indicating the speed was doubled during digitization, (2 \* 100 / 100).  The duration (a value measured in frames) multiplied against the editUnit should provide the amount of time in seconds; yet it is the seconds that we have captured in the spreadsheet.

duration \* editUnit = seconds

duration = seconds / editUnit

Since the editUnit is defined as:   1 / sampleRate \* speedCorrection, the previous statement is equivalent to:

duration =  seconds \* sampleRate \* speedCorrection

Therefore we obtain the duration value in frames by multiplying the number of seconds elapsed against the sample rate and speed correction, to provide the duration value in frames.  Should the start time of the clip be other than zero, then the value for startTime is generated the same way.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 | `sub` `calcFrames{`  `my` `(``$duration``, ``$sampleRate``, ``$speedCorrection``) = ``@_``;`  `if` `(``$duration` `=~ /.*?\:.*?\:.*?:/){  `  `(``$hours``, ``$min``, ``$sec``, ``$subsec``) = ``split``(``":"``,``$duration``);`  `$totalSec` `= (``$hours` `* 3600) + (``$min` `* 60) + ``$sec` `+ (``$subsec` `/ 60);`  `}`  `elsif` `(``$duration` `=~ /.*?\:.*?\:/){  `  `(``$hours``, ``$min``, ``$sec``) = ``split``(``":"``,``$duration``);`  `$totalSec` `= (``$hours` `* 3600) + (``$min` `* 60) + ``$sec``;`  `}`  `elsif` `( ``$duration` `=~ /\:/){  `  `(``$min``, ``$sec``) = ``split``(``":"``,``$duration``);`  `$totalSec` `= (``$min` `* 60) + ``$sec``;`  `}`  `else``{ ``$totalSec` `= ``$duration``;}   `  `if` `(! ``$speedCorrection``){ ``$speedCorrection` `= 1;}`  `$frames` `= ``$totalSec` `* ( ``$sampleRate` `* ``$speedCorrection``);`  `return` `$frames``;`  `}` |
| --- | --- |

As described before, each audio object consists of one or more “faces,” each of which contains one to many “regions,” each of which contains one to many “streams” (this software supports up to four streams per region). Examples of a “face” include a single side of a long-playing record; both tape tracks of a half-inch open reel tape containing stereo content; and a single portion of a quarter track four-track tape for which each flip of the tape contains a single stream that is monophonic.  Additionally, each variation in the direction or speed correction value would require a separate “face” section.  For example, a reel-to-reel tape on which multiple entries were captured at different speeds (or in different directions) would require a separate “face” entry in the AES57 for each segment. Directions supported include FRONT, BACK, FORWARD, REVERSE, A\_PASS, B\_PASS, C\_PASS, D\_PASS and NONE.  FRONT and BACK may be used for two-sided objects, such as a long-playing record.  FORWARD and REVERSE are most appropriate when audio is encoded along the length of the object, such as cassette or reel-to-reel tapes.  The A\_PASS, B\_PASS, etc. are more descriptive of the quarter track tape described above.  NONE would be used for born digital audio, which has no physical structure.  Changes in direction, speed correction, or file name pattern (or end of file) indicate an end to a “face,” in this software.  Thus, when the tab-delimited spreadsheet is first read in, preliminary parsing of the lines documents these changes, and notes “endFace” and “startFace” times for each audio file.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39 | `open` `(LOG, ``$log``) or ``die` `"can't read $log\n"``;`  `while` `(``$line` `= <LOG>){`  `chomp` `$line``; `  `$line` `=~ s,\r,,g;  `  `if` `(``$line` `=~ /^ *([a-z]{1}[\d]{4}\_[\d]{7}[^\t]*) *\t(.*)/){  `  `$id` `= $1;`  `$mystuff``{``$id``} = $2;  `  `$id` `=~ s, ,,g;  `  `(``$title``, ``$physType``, ``$clipBegin``, ``$clipEnd``, ``$regionCond``, ``$stream1``, ``$stream2``, ``$stream3``, ``$stream4``, ``$priorStream``, ``$endingStream``, ``$direction``, ``$label``, ``$speedCorrection``, ``@trash``) = ``split``(``"\t"``,``$mystuff``{``$id``});   `  `if` `(! ``$lastSpeed``){ ``$lastSpeed` `= ``$speedCorrection``;} `  `if` `(! ``$lastDirection``){ ``$lastDirection` `= ``$direction``;}  `  `if` `(``$first``){  `  `$lastSpeed` `= ``$speedCorrection``;`  `$lastDirection` `= ``$direction``;`  `undef` `$first``;`  `$face` `= 1;`  `$startFace``{``$itemID``}{``$face``} = 0;  `  `}`  `elsif` `(``$id` `!~ /``$lastID``/){ `  `$lastSpeed` `= ``$speedCorrection``;`  `$lastDirection` `= ``$direction``;`  `$face` `= 1;`  `$startFace``{``$itemID``}{``$face``} = 0;`  `}`  `elsif` `((``$lastSpeed` `!= ``$speedCorrection``) \|\| (``$lastDirection` `ne ``$direction``)){ `  `$endFace``{``$itemID``}{``$face``} = ``$clipBegin``;`  `$face` `++;  `  `$startFace``{``$itemID``}{``$face``} = ``$clipBegin``;   `  `}`  `$myFace``{``$id``} = ``$face``; `  `$lastFace``{``$itemID``} = ``$face``;  `  `$lastSpeed` `= ``$speedCorrection``;`  `$lastDirection` `= ``$direction``;`  `$lastID` `= ``$itemID``;`  `$lastKid` `= ``$id``;`  `}` |
| --- | --- | --- | --- |

The “startFace” time is expected to be zero for all audio files, however, the clips may not begin at zero.  For these, preliminary regions are generated with the label “Start of file” and any notes in the “priorStream” field of the spreadsheet for the first entry for a new file.

| 1  2  3  4  5  6  7  8  9 | `if` `(``$clipBegin` `&& ``$clipBegin` `=~ /[1-9]+/){   `  `$priorID` `= ``$id``.``".begin"``;`  `$ownerRef` `.= ``$priorID``.``" "``;`  `$startFrame` `= ``&doFace``(1, 0, ``$sampleRate``, ``$speedCorrection``, ``$direction``, ``$id``, ``$title``, ``$endFrame``, ``$endFrame``);`  `$priorFrames` `= ``&calcFrames``(``$clipBegin``, ``$sampleRate``, ``$speedCorrection``);`  `$myend` `= ``$priorFrames` `-1;`  `$lastEnd` `= ``&printRegion``(``$priorID``,``$faceID``,``"Start of file"``,``$sampleRate``,0,``$myend``,``$channels``,``$priorStream``,``$speedCorrection``,``$dateC``,``$iam``,);`  `$startTime` `= ``$lastEnd` `+ 1;`  `}` |
| --- | --- |

Below is an example of the beginning of a “face” in an AES57 file, in which a “begin” region has been added prior to the first clip (or region) identified in the spreadsheet for web delivery:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22 | `<``face` `ID``=``"Section_1"` `direction``=``"FORWARD"` `audioObjectRef``=``"u0008_2012038_0000007"` `label``=``"Alumni Banquet - Dr. Matthews and Student Speakers"``>`  `<``timeline``>`  `<``startTime` `editRate``=``"22500"``>0</``startTime``>`  `<``duration` `editRate``=``"22500"``>43312500</``duration``>`  `</``timeline``>`  `<``region` `ID``=``"u0008_2012038_0000007_0001.begin"` `formatRef``=``"Waveform_Audio"` `faceRef``=``"Section_1"` `label``=``"Start of file"``>`  `<``timeRange``>`  `<``startTime` `editRate``=``"22500"``>0</``startTime``>`  `<``duration` `editRate``=``"22500"``>269999</``duration``>`  `</``timeRange``>`  `<``numChannels``>2</``numChannels``>`  `<``conditionNote``>`  `<``note``>crowd noise</``note``>`  `<``creationDate``>2015-07-31T15:54:21-05:00</``creationDate``>`  `</``conditionNote``>`  `<``stream` `ID``=``"u0008_2012038_0000007_0001.begina"` `label``=``"1"` `faceRegionRef``=``"Section_1"``>`  `<``channelAssignment` `channelNum``=``"1"` `leftRightPosition``=``"0.0"` `/>`  `</``stream``>`  `<``stream` `ID``=``"u0008_2012038_0000007_0001.beginb"` `label``=``"2"` `faceRegionRef``=``"Section_1"``>`  `<``channelAssignment` `channelNum``=``"2"` `leftRightPosition``=``"0.0"` `/>`  `</``stream``>`  `</``region``>` |
| --- | --- |

Also, the “duration” value for the entire file is drawn from the FITS duration (Exiftool entry) and this may differ from the duration as specified within the spreadsheet.  If the difference is more than a second (determined by the sample rate), an error is generated.  Otherwise, if the difference is less than a second, the frame rate for the FITS duration is substituted for the one provided in the spreadsheet.

| 1  2  3  4  5  6  7  8  9  10  11  12 | `$endFrame` `= ``&calcFrames``(``$clipEnd``, ``$sampleRate``, ``$speedCorrection``);`  `if` `(``$duration``){`  `$endFile` `= ``&calcFrames``(``$duration``, ``$sampleRate``, ``$speedCorrection``);`  `if` `(``$endFile` `> ``$endFrame``){ ``$endFrame` `= ``$endFile``;}  `  `elsif` `(``$endFile` `< ``$endFrame``){             ``$diff` `= ``$endFrame` `- ``$endFile``;             ``if` `(``$diff` `> (``$sampleRate` `)){`  `print` `ERRORS ``"Duration of file ($clipEnd) differs ($diff) by more than a second from FITS duration of $duration\n"``;`  `}`  `else``{ ``$endFrame` `= ``$endFile``;}  `  `}`  `}`  `else``{ ``$endFile` `= ``$endFrame``;}` |
| --- | --- |

Regions within a face correspond to tracks or clips expected to be played separately.  Examples would be each song on one side of a long-playing record, each musical piece in a performance, or the recording of each speaker during a segmented presentation.  Compilation of all regions should account for the entire “face” of the object.  Thus, segments (regions) that are not selected for extraction for web delivery (as indicated in the spreadsheet) need to be accounted for as well.  Potential reasons for skipping segments might be:  extended silences; applause; security reasons or intellectual property rights; inadvertent capture of content unrelated to the intended material; or damaged or lost portions of the original.  To account for such segments, our spreadsheet includes fields for notes on prior or ending streams, and the time codes and duration for those are calculated from the time codes for the audio file and the entries for the regions (or segments) to be included in web delivery.  Notes indicating the reason for suppression of the segment skipped should only be added in the priorStream field (unless it is the ending stream) on the row of the succeeding region.

| 1  2  3  4  5  6  7 | `elsif` `(``$kidNum` `> 1 && (``$priorFrames` `!= (``$lastEnd` `-1)) && (``$priorFrames` `!= ``$lastEnd``) ){ `  `$priorID` `= ``$lastKid``.``".5"``;`  `$ownerRef` `.= ``$priorID``.``" "``;  `  `$startTime` `= ``$lastEnd` `+ 1;`  `$myend` `= ``$priorFrames` `-1;  `  `$lastEnd` `= ``&printRegion``(``$priorID``,``$faceID``,``"skipped portion"``,``$sampleRate``,``$startTime``,``$myend``,``$channels``,``$priorStream``,``$speedCorrection``,``$dateC``,``$iam``,);`  `}` |
| --- | --- |

Each region contains one to many streams, each of which represents an individual channel of audio information, and each of which is assigned a different non-negative integer.  This script supports up to 4 streams, labeling them alphabetically in order; each must reference the region and face of which it is a part. Face identifiers are generated by numbering faces sequentially, and preceding them with “Section\_”; singleton regions are identified by file identifier with “\_0000” attached, and multiple region files simply depend upon the region identifiers as entered in the spreadsheet. Regions added at the beginning of a file use the next identifier concatenated with “.begin”; those at the end use the last identifier concatenated with “.end”; and skipped regions added are identified in fits2aes by the last identifier concatenated with “.5”.   This allows the person digitizing to avoid entering lines in the spreadsheet for each segment of the audio file which is not being described and extracted for web delivery, and still generate valid AES57 files which define all segments, as required.

Additionally it is possible to assign “pan positions” within the audio sound stage that the stream should occupy during playback, on a left-right axis and/or a front-rear axis, however this optional encoding is not included yet in the software being described;  instead all are assumed to come from center stage (leftRightPosition=“0.0”).

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32 | `sub` `printStreams{`  `my` `(``$regionID``,``$id``, ``$faceID``,``$dateC``, ``$channels``, ``$sampleRate``, ``$speedCorrection``, ``@streams``) = ``@_``;`  `%numToAlpha` `= (`  `1` `=> ``"a"``,`  `2` `=> ``"b"``,`  `3` `=> ``"c"``,`  `4` `=> ``"d"`  `);`  `undef` `$numerator``;`  `undef` `$denominator``;`  `if` `(``$speedCorrection``){`  `$numerator` `= ``$speedCorrection` `* 100;`  `$denominator` `= 100;`  `}`  `for` `(``$i` `= 1; ``$i` `<= ``$channels``; ``$i` `++){  `  `undef` `@mynotes``;`  `$alpha` `= ``$numToAlpha``{``$i``}; `  `$id` `= ``$regionID``.``$alpha``;`  `$label` `= ``$i``;`  `$mychannel` `= ``$i``;`  `$cond` `= ``$streams``[``$i``-1];`  `print` `OUT ``"      <stream ID=\"$id\" label=\"$i\" faceRegionRef=\"$faceID\">\n"``;`  `print` `OUT ``"        <channelAssignment channelNum=\"$i\" leftRightPosition=\"0.0\" />\n"``;`  `$cond` `= ``$streams``[``$i``-1];`  `&printNotes``(``"noteTimeRange"``,``$sampleRate``, ``$speedCorrection``, ``$dateC``, ``$cond``);`  `print` `OUT ``"      </stream>\n"``;`  `}`  `print` `OUT ``"    </region>\n"``;`  `}` |
| --- | --- |

An example of a region generated at the end of a file for a segment (with the endingStream comment of “applause”) following the last region (clip) entered in the spreadsheet would thus look like this:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `<``region` `ID``=``"u0008_2012038_0000007_0007.end"` `formatRef``=``"Waveform_Audio"` `faceRef``=``"Section_1"` `label``=``"End of file"``>`  `<``timeRange``>`  `<``startTime` `editRate``=``"22500"``>43290001</``startTime``>`  `<``duration` `editRate``=``"22500"``>22499</``duration``>`  `</``timeRange``>`  `<``numChannels``>2</``numChannels``>`  `<``conditionNote``>`  `<``note``>applause</``note``>`  `<``creationDate``>2015-07-31T15:54:21-05:00</``creationDate``>`  `</``conditionNote``>`  `<``stream` `ID``=``"u0008_2012038_0000007_0007.enda"` `label``=``"1"` `faceRegionRef``=``"Section_1"``>`  `<``channelAssignment` `channelNum``=``"1"` `leftRightPosition``=``"0.0"` `/>`  `</``stream``>`  `<``stream` `ID``=``"u0008_2012038_0000007_0007.endb"` `label``=``"2"` `faceRegionRef``=``"Section_1"``>`  `<``channelAssignment` `channelNum``=``"2"` `leftRightPosition``=``"0.0"` `/>`  `</``stream``>`  `</``region``>` |
| --- | --- |

In summary, the AES57 is a fairly complicated schema for audio technical metadata, but it is attainable by generating FITS files for each audio file, and creating a tab-delimited export of a spreadsheet containing appropriate information gathered during digitization. By documenting information about each portion of the archival audio file, even those segments not provided as web-accessible derivatives, future web delivery can be consistent with current content selections and can be informed by previous decisions regarding access. Additionally, the generation of this type of technical metadata adds a layer of quality control to the digitization process, to ensure that the time entered for clips do not actually extend beyond the duration of the entire file, and also to verify that the original audio file is valid and well-formed prior to preservation. Example AES57 files, their corresponding FITS files, and an example tab-delimited spreadsheet are available with the script from [http://www.lib.ua.edu/wiki/digcoll/index.php/Fits2aes](http://www.lib.ua.edu/wiki/digcoll/index.php/Fits2aes).

## Bibliography

Audio Engineering Society \[Internet\]. \[updated 2015\]. AES57-2011: AES standard for audio metadata – Audio object structures for preservation and restoration.  \[cited 2015 July 25\]. Available from: [http://www.aes.org/publications/standards/search.cfm?docID=84](http://www.aes.org/publications/standards/search.cfm?docID=84)

Audio Engineering Society \[Internet\]. \[updated 2015\]. AES60-2011: AES standard for audio metadata – Core audio metadata.  \[cited 2015 July 25\]. Available from: [http://www.aes.org/publications/standards/search.cfm?docID=85](http://www.aes.org/publications/standards/search.cfm?docID=85)

Audio Engineering Society \[Internet\]. 2011. AES standard for audio metadata – Core audio metadata (preview). \[cited 2015 July 25\]. Available from: [http://www.aes.org/tmpFiles/aessc/20150725/aes60-2011-i.pdf](http://www.aes.org/publications/standards/search.cfm?docID=85)

Dublin Core Metadata Initiative \[Internet\]. \[updated 2015\]. Dublin Core Metadata Element Set, Version 1.1.  \[cited 2015 July 25\]. Available from: [http://dublincore.org/documents/dces/](http://dublincore.org/documents/dces/)

EBU Operating Eurovision and Euroradio. 2013. Tech 3293: EBU Core Metadata Set (EBUCore), Version 1.4, pp. 29 &77. \[cited 2015 July 29\]. Available from: [http://citeseerx.ist.psu.edu/viewdoc/download;?doi=10.1.1.278.4772&rep=rep1&type=pdf](http://citeseerx.ist.psu.edu/viewdoc/download;?doi=10.1.1.278.4772&rep=rep1&type=pdf)

Harvard Institute for Quantitative Social Science \[Internet\]. 2015. File information Tool Set (FITS). \[cited 2015 July 25\]. Available from: [http://projects.iq.harvard.edu/fits/home](http://projects.iq.harvard.edu/fits/home)

Library of Congress \[Internet\]. \[updated 2011 Oct 5\].  AudioMD and VideoMD – Technical Metadata for Audio and Video.  \[cited 2015 July 25\]. Available from: [http://www.loc.gov/standards/amdvmd/audiovideoMDschemas.html](http://www.loc.gov/standards/amdvmd/audiovideoMDschemas.html)

Otto, Jane Johnson. 2010. A Sound Strategy for Preservation: Adapting Audio Engineering Society Technical Metadata for Use in Multimedia Repositories.  Cataloging & Classification Quarterly (48:5) and Rutgers University Community Repository \[Internet\]. \[cited 2015 July 25\]. Available from: [http://dx.doi.org/doi:10.7282/T3WW7G11](http://dx.doi.org/doi:10.7282/T3WW7G11)

W3C \[Internet\]. \[updated 1997 Sep 15\]. Date and Time Formats. \[cited 2015 July 29\]. Available from: [http://www.w3.org/TR/NOTE-datetime](http://www.w3.org/TR/NOTE-datetime)

## About the Author

[Jody L. DeRidder](http://jodyderidder.com/) (jody@jodyderidder.com) is head of Metadata & Digital Services at the University of Alabama Libraries, where she manages digitization, metadata, software development, infrastructure, and preservation policies and procedures. Previously, she developed digital libraries at the University of Tennessee. She has an M.S. in both Information Science and Computer Science.
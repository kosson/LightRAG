---
title: "The Forgotten Disc: Synthesis and Recommendations for Viable VCD Preservation"
source: "https://journal.code4lib.org/articles/17406"
author:
  - "Andrew Weaver"
  - "Ashley Blewer"
published: 2023-08-29
created: 2025-01-10
description: "As optical media held by cultural heritage institutions has fully transitioned from use as a digital preservation ‘solution’ to a digital preservation risk, an increasing amount of effort has been focused on exploring tools and workflows to migrate the data off of these materials before it is permanently lost to physical degradation. One optical format, however, has been broadly ignored by the existing body of work: the humble Video CD. While never a dominant format in the Anglosphere, the Video CD, or VCD, held wide popularity from the 1990s through the 2000s in Asia and other regions. As such, a dedicated exploration of preservation solutions for VCD has utility both as a resource for institutions that collect heavily in Pacific Rim materials, as well as a means to, in a minor way, aid in the ongoing efforts to expand the Digital Preservation corpus beyond its traditional focus of issues prevalent in North America and Europe. This paper introduces an overview of VCD as a format and summarizes its unique characteristics that impact preservation decisions and presents the results of a survey of existing tools and methods for the migration of VCD contents. This paper conveys practical methods for migrating VCD material from the original carrier and into both digital preservation and access workflows."
tags:
  - "#preservation"
  - "#optical/media"
  - "#VSD"
  - "#digital/preservation"
  - "#Anglosphere"
  - "#ISO-9660"
  - "#Cdrdao"
  - "#workflow"
---
# The Forgotten Disc: Synthesis and Recommendations for Viable VCD Preservation
Andrew Weaver, Ashley Blewer

As optical media held by cultural heritage institutions has fully transitioned from use as a digital preservation ‘solution’ to a digital preservation risk, an increasing amount of effort has been focused on exploring tools and workflows to migrate the data off of these materials before it is permanently lost to physical degradation. One optical format, however, has been broadly ignored by the existing body of work: the humble Video CD. While never a dominant format in the Anglosphere, the Video CD, or VCD, held wide popularity from the 1990s through the 2000s in Asia and other regions. As such, a dedicated exploration of preservation solutions for VCD has utility both as a resource for institutions that collect heavily in Pacific Rim materials, as well as a means to, in a minor way, aid in the ongoing efforts to expand the Digital Preservation corpus beyond its traditional focus of issues prevalent in North America and Europe. This paper introduces an overview of VCD as a format and summarizes its unique characteristics that impact preservation decisions and presents the results of a survey of existing tools and methods for the migration of VCD contents. This paper conveys practical methods for migrating VCD material from the original carrier and into both digital preservation and access workflows.

## Introduction

Despite its widespread adoption, optical media is widely recognized as being a format with severe preservation risks due to its high potential for damage, degradation and technical obsolescence ([Schweikert, 2018](https://journal.code4lib.org/articles/#cited6)). This is particularly true in the case of recordable optical media, such as CD-Rs, where the inherent vices of unstable base materials and variable recording quality combine to create a high level of uncertainty for the lifespan of these discs. ([Schüller, 2008](https://journal.code4lib.org/articles/#cited5)).

Accordingly, an increasing amount of effort within the Preservation field has been focused on exploring tools and workflows to migrate the data off of these materials before it is permanently lost. Thanks to the generosity of practitioners, quite a lot of this work has been documented and made publicly available through resources such as George Blood LP’s 2014 report for the Library of Congress ([Morel et al., 2014](https://journal.code4lib.org/articles/#cited3)) and Alexander Duryee’s introduction to the topic in Code4Lib journal ([Duryee, 2014](https://journal.code4lib.org/articles/#cited2)). One optical format, however, has been broadly ignored by the existing body of work: the humble Video CD.

While never a dominant format in the Anglosphere, the Video CD, or VCD, held wide popularity from the 1990s through the 2000s in Asia and other regions. As such, a dedicated exploration of preservation solutions for VCD has utility both as a resource for institutions that collect heavily in Pacific Rim materials, as well as a means to, in a minor way, aid in the ongoing efforts to expand the Digital Preservation corpus beyond its traditional focus of issues prevalent in North America and Europe. This paper will present an overview of VCD as a format, its unique characteristics that impact preservation decisions and a survey of existing tools and methods for the migration of VCD contents off of the original carrier and into digital preservation and access workflows.

## Background & Context

VCD is a standard digital data format for storing video on a compact disc with the intended purpose of linear video playback. Essentially, VCD was an optical media disc (similar to a CD or DVD) that was used to store and play video. As a popular format in the 1990s and 2000s, VCD usage fits between LaserDisc and DVD, with an image quality comparable to VHS ([Davidson and Lediaev, 1993](https://journal.code4lib.org/articles/#cited1)).

VCD discs were the same dimensions and composition of CDs and DVDs: Discs were 120 mm (4.7 in.) in diameter and composed of a clear polycarbonate plastic substrate, a reflective metallic layer, and a clear plastic protective coating. Physical preservation efforts should adhere to the same practice as other optical media formats.

The authority for the VCD specification comes from the “White Book” standard released in 1993 by a group of video technology companies (JVC, Panasonic, Philips, and Sony). The title “White Book” is due to this specification being part of a series of standards that were developed for compact discs around this time period, creating what is known as the Rainbow Books. The Rainbow Books started with Red (CD-DA Digital Audio) in 1980 until the Purple Book (for DDCD Double Density). The White Book sits between the Beige Book (1992), which covers Photo CD technology and was written by Kodak, and the Blue Book (1995), which covers Enhanced CD technology and was written by Philips and Sony.

The VCD “White Book” standard was based off of previous work on the Karaoke-CD system. Thus, VCDs included and built upon similar technical features like using MPEG-1 video, closed captioning, and ability to select and start from defined sections ([Super Video Compact Disc, 2001](https://journal.code4lib.org/articles/#cited4)).

As a format, VCDs were especially popular in Southeast Asia and China. VCD premiered in these markets at the right time, as VHS had not yet saturated the market, as it had in other geographic regions. Optical media also has less risk of mold and mildew accumulation compared to magnetic tape, making them more suitable for very warm climates.

Like CDs and DVDs, VCDs were either commercially pressed or they were “burned” onto writable media. While writing this paper, the authors encountered great numbers of these “burned” VCDs, both in collections that had been created by community members as well as items that were commercial releases that had been purchased for circulation. These VCDs are subject to the same elevated risks noted for writable optical media formats.

## Brief overview of VCD technical characteristics

The defined length of a VCD was marketed as offering typically up to 74 or 80 minutes on one side, a bit less than a standard feature-length movie. This minute mark was just an estimate; size constraints were determined by the amount of video stored rather than video duration. Technically, VCD discs could store up to 800 MB of compressed video, with the most commonly produced sizes being 650 MB (74 minutes) or 700 MB (80 minutes) [^1]. So while VCDs were advertised as having a certain number of minutes of video, the true maximum duration is determined by the video content and compression.

VCDs use the MPEG-1 encoding standard for compressing and storing both video and audio. MPEG-1 is defined under ISO/IEC 11172 Specifications for MPEG-1. It may also be referred to as H.261 [^2]. The MPEG-1 format was released the same year as VCD and sought to create video files that were of reasonable size and of sufficient quality (for the era).

The structure of a typical VCD is broken up into one or more CD-ROM XA (“eXtended Architecture”) sectors:

- First track: Contains an ISO-9660 file system that stores 2048 bytes/sector. This track’s primary function is to hold metadata and pointers that point to specific content (e.g. a tracklist or chapter list). It can also hold still images or frames, mostly for use in menu screens. This track is small but crucial to the operation of a structured Video CD. It uses the CD-ROM XA formatting method “mode 2 form 1,” which takes up more space but allows for some error correction functionality.
- Subsequent tracks: The second and any other additional tracks contain raw MPEG tracks that store 2324 bytes/sector, with one MPEG data packet stored per sector. These tracks are not inherently part of the disc’s file system structure and thus cannot be mounted. Windows operating systems may assume the intended usage of these files, interpret the contents, and “mount” the files even though they are just raw data, similar to how some systems will virtualize the raw PCM tracks on audio CDs as WAV files. These tracks use CD-ROM XA formatting method “mode 2 form 2”; they do not support error correction but each sector has the capacity to store more data.

VCDs can also contain exceptions to this standard arrangement, for example, discs containing audio (CD-DA) tracks or only a single track without a file system.[^3]

### Migration considerations

When browsing the contents of a VCD via the directory viewer of an operating system, there will be a folder called ‘mpegav’ (See Figure 1) that contains one or more .DAT “files”. These .DAT files are filesystem representations of the MPEG sectors, not the MPEG sectors themselves. The other visible folders and files form the non-video elements of the disc’s structure, and include information such as playback sequence metadata [^4].

![](https://journal.code4lib.org/media/issue57/weaver/image2.png)
**Figure 1.** Directory Tree of Test VCD with a Relatively Simple Structure.

Any attempts to copy, open or access them on a Linux system will fail with an I/O error. As noted above, the Windows operating system, however, will virtualize and play this raw data. Legacy methods mention workarounds for Linux machines using the cdfs kernel driver, but unfortunately these are no longer viable due to cdfs being incompatible with the Linux kernel since at least 2013 [^5].

Although directly copying data on a Windows machine may be viable for accessing content on Video CDs, it is insufficient preservation practice to copy and paste the files from the disc onto a harddrive, and the bulk of the remainder of this paper will be focused around workflows designed for preservation minded applications where a complete and replicable raw image of the original disc is produced. Similar to DVDs, where information such as titles etc. may be lost if only the video information is extracted from the disc, the authors believe that the creation of an image, specifically a BIN/CUE pairing, is the most appropriate strategy when working with VCDs for preservation purposes.

The BIN/CUE formats work in combination to yield an exact replica of the disc. The .bin file holds the complete raw binary data of the disc contents and the .cue file stores metadata for associated track layouts.This method helps ensure preservation of the complete structure of the disc.

An image, however, is only useful if it can be reliably interacted with in the future – and it is here that VCDs are particularly unique when compared to other optical formats. With their combination of an ISO-9660 track followed by an MPEG stream track or tracks, their images can’t be opened or played back in the same fashion as DVDs or other common data disc formats, and some extra steps are necessary to interact with the contents of BIN/CUE pairs made from VCDs. Accordingly, we will compare a few possible methods of accessing VCD data both within preservation workflows as well as for simple access.

## Tools Tested for Creating Disc Images

With Video CDs being based on the CD-ROM XA architecture, in selecting tools for comparison we sought out tools that have been used in workflows with other types of CD-ROM XA-based items. Mixed mode audio CDs [^6], being composed of a single session with a first track containing a data followed by successive tracks of PCM audio, seemed the most similar format with extant documentation available, such as the workflows shared in by Johan van der Knijff ([van der Knijff, 2015](https://journal.code4lib.org/articles/#cited7)). Of the tools we selected, two of them (Isobuster and Cdrdao) are commonly used in Mixed mode audio CD preservation, and one (VCDImager) is a tool specific to VCDs.

![image shows a graph that outlines the workflow for transferring a Video CD](https://journal.code4lib.org/media/issue57/weaver/image3.png)
**Figure 2.** Graph Outlining the Workflow Process for Transferring a VCD.
(Key: Gray is for Windows tools, Blue is for Linux tools, Green are cross platform, black represents inputs/outputs of process. \* indicates that access to the .DAT files only possible in Windows file browser)

The sample commands in the following sections (with the exception of the description of Isobuster) were written assuming the Linux version of the tool is being used.

### Isobuster

Isobuster is a commercial data recovery application that is capable of creating raw disc images in the BIN/CUE format and is specific to the Windows operating system. Of the tools we surveyed, Isobuster is perhaps the most straightforward option for creating VCD images (See Figure 2). While Isobuster is commercial software that requires registration for full functionality, its licensing information notes that all VCD capabilities are within its free tier [^7].

#### Process to create bin/cue

Conveniently, Isobuster is able to create a BIN/CUE pair from a VCD in a single step – the user simply selects ‘Extract CD raw (\*.bin)’ from the drop down menu and Isobuster will output the pair in the chosen location.

### Cdrdao

Cdrdao is a general use utility for writing audio and data CD-Rs. Cdrdao [^8] (which stands for “CD-R disc at once”) is a free and open source command line utility for both Win32 and Linux that allows the reading and writing of CDs in ‘disc-at-once’ mode [^9]. This method extracts data in one pass, as opposed to the alternative methods that operate on a per-track or per-session basis. At the time of writing (July 2023) it is available in locations such as Ubuntu’s package manager and has had a release this year (2023), which suggests it is still a stable project. Cdrdao’s output when run on VCDs is a BIN/TOC pair, where the BIN file represents the raw data and the TOC (table of contents) functions in the same manner as a CUE sheet. Because Cdrdao does not generate a CUE sheet, workflows that use it must use the associated, and descriptively named toc2cue tool as an additional step (See Figure 2).

#### Process to create bin/cue

The command (which assumed the default optical device) used in our testing to generate the BIN/TOC pair was:

`cdrdao read-cd --device /dev/sr0 --paranoia-mode 2 --read-raw --driver generic-mmc-raw --datafile output.bin output.toc`

It is worth noting that Cdrdao includes the CD Paranoia library [^10], which is a library that aims to help achieve more accurate rips of audio CDs. According to its manual page, Cdrdao defaults to a setting of `--paranoia-mode 3`. In our testing we found that it was difficult to draw strong conclusions about the results of differing paranoia settings on damaged discs. There were a wide range of results across different discs and different drives with no setting consistently providing a clear advantage with regards to discernable A/V errors. The test command here includes the setting for level 2, but that is more to highlight the use of the flag than to endorse it – any workflow involving damaged discs would most likely benefit from some local experimentation to see how the different paranoia options interact with the drive or drives being used.

The second command used to generate the BIN/CUE pair is `toc2cue output.toc output.cue`. This uses the toc2cue tool (which is a part of the Cdrdao installation) and converts the .TOC file created by Cdrdao to a CUE sheet that can be used by other tools.

### VCDImager

VCDImager is a ‘full-featured mastering suite for authoring, disassembling and analyzing Video CDs’ [^11] that is maintained as a part of the GNU Project and has existed since the year 2000. As one of the few dedicated VCD projects that is still actively maintained it was of great interest to us as a tool. The suite includes a tool for ripping the contents out of VCDs, as well as a tool for generating BIN/CUE images that can be written to discs from extracted VCD information. As such, it is not directly creating a BIN/CUE pair in the manner of the other tools tested, but rather is creating a file dump with an XML file of technical metadata that can then be used to engineer a viable VCD image. Vcdxrip is also capable of extracting files from BIN/CUE images of VCDs.

#### Process to create BIN/CUE

The initial command to generate the BIN/CUE pair in our testing was `vcdxrip -v -C=/dev/sr0` which generates a full dump of all the VCD’s contents and automatically converts the .DAT files to .MPG for easy use. It also generates an XML file that contains technical information about the VCD which can be used both for analysis and to generate a BIN/CUE pair from the extracted VCD contents using the command `vcdxbuild -b output.bin -c output.cue input.xml`.

### Comparison of damage handling

VCDImager’s vcdxrip tool was noted in many legacy online sources as being unable to handle damaged discs, and testing confirms that its VCD extraction will abort when it hits the damaged portion of intentionally damaged test discs. Additionally, beyond this limitation on physical discs, vcdxrip failed in an identical way on extracting files from a BIN/CUE pair generated from the damaged disc with alternate tools.

![image shows error correction on a Video CD disk that was intentionally damaged](https://journal.code4lib.org/media/issue57/weaver/image4.png)
**Figure 3.** An Example of Error Correction from one of the Intentionally Damaged Test Discs. Note the visible block-like effect on the leg in the far right side of the screen caused by data from other adjacent frames being used to fill in the damaged portion of the image.

Cdrdao created a complete BIN/CUE pair from intentionally damaged test discs that was both able to be split into its component elements as well as mounted and played. As was noted in the above section, we found that using the flag `--paranoia-mode 2` could at times result in different results than the tool default of  `--paranoia-mode 3` depending on the nature of damage and the drive used. It is recommended that in any implementation some local experimentation be done to confirm if either setting results in more optimal results.

Isobuster also created a complete BIN/CUE pair from damaged test discs that was able to be manipulated and played back.

### Comparison of replicability

The following tables show both md5 hashes and file sizes for the BIN outputs of each tool. Note that Isobuster and Cdrdao both generated images that were identical while vcdxrip’s output (that was generated in its two step process) was different both in file size and file fingerprint.

**Table 1.** Disc 1 – Burned Version of VCDImager’s NTSC Sample Disc. [^12]

| Tool | md5 | Image size (bytes) |
| --- | --- | --- |
| Isobuster | 9aacc6b5cc28901b4a36282942750fc2 | 86123184 |
| cdrdao | 9aacc6b5cc28901b4a36282942750fc2 | 86123184 |
| vcdimager | e629f0bdddf37f81aaad74a78cb1a806 | 86475984 |

**Table 2.** Disc 2 – Pressed Commercial Release of Kikujiro no Natsu Disc 1 (See Figure 3) [^13].

| Tool | md5 | Image size (bytes) |
| --- | --- | --- |
| Isobuster | 73ed9542490afc1162b87773a3cb24a6 | 677284272 |
| cdrdao | 73ed9542490afc1162b87773a3cb24a6 | 677284272 |
| vcdimager | 6026fa6dfe985601a37ff0a3f9899d92 | 677418336 |

![Scanned image of a Video CD disk with color target card](https://journal.code4lib.org/media/issue57/weaver/image1.png)
**Figure 4.** Scanned Image of one of the Test Discs (Kikujiro no Natsu) and Color Target Card

## Tools for Manipulating and Accessing Disc Images

It is an oft repeated axiom that there is ‘no preservation without access’, and when it comes to VCDs there are a few extra considerations post creation of BIN/CUE pairs to make their content useful and accessible. Unlike disk images of DVD videos, which can be opened as-is via software like VLC and Handbrake, or the WAV/CUE pairs often used in audio CD workflows, the BIN/CUE pair created from a VCD is not immediately usable and requires extra mediation. The tools and methods in this section address how to extract data and video information from VCD images.

### Bchunk

Bchunk is a tool for converting BIN/CUE pairs into the ISO format, and can be used to split apart VCD images into their data and video components. The command for this is `bchunk -r input.bin input.cue output`, which will result in two or more files created with the root name selected for output and the .iso extension. The `-r` flag used in this command is a critical element that allows Bchunk to output the CD-ROM XA Mode 2 tracks that comprise VCDs in raw format [^14].

Of the .iso files that are produced by this command, the first will be the data track from the VCD and the following files will actually be the video contents of the image. They can have their extension changed from .iso to .mpg and be manipulated in the same manner as a normal .mpg file.

### Isobuster

Along with the creation of images, Isobuster is capable of extracting information from BIN/CUE pairs. Upon opening a BIN/CUE pair with Isobuster (via either the BIN or CUE file) Isobuster will display the available tracks. The first (data) track can have files directly extracted from it, while the successive video tracks will need to be extracted into either raw data, or via the likely most useful option, directly as MPG video files using the available extraction choice to ‘Treat as video ONLY.’

### Cdemu

Should it be desirable to mount the image either to play it in its native format or to extract files from it manually (for example in a situation where extraction was unusable) then VCD images can be mounted using the Cdemu tool on Linux and the WinCDemu tool on Windows (See Figure 2). (The following commands are shown for Cdemu) [^15][^16].

Mounting a VCD with cdemu requires first creating a virtual device with the command `cdemu add-device` which will create a virtual device numbered as 00 for the first device and incrementally for successive devices. Then a VCD image can be mounted using the BIN/CUE pair with `cdemu load 00 input.cue`. For successful use it is important to load the CUE file rather than the BIN. To easily ascertain where the virtual device has been mapped use the command `cdemu device-mapping`. A graphical version of cdemu called gCDEmu exists and can be used as well in the same manner.

Once a VCD has been mounted in this manner it can be manipulated as if the original disc had been inserted into the computer. This means both that it can be played back in its original manner through functions such as the ‘Open Disc’ functionality of the VLC player, and also that files can be copied out of the discs. The virtualized nature of the DAT files discussed earlier in this paper is still in effect even with a virtual device, and it is only possible to copy or open them on a Windows system, so Linux workflows will have to rely on Bchunk for the extraction of video content.

### FFmpeg

Many VCDs will have more than one MPG track (in the same way that DVD images have more than one VOB file). Should this be the case, and should it be desired to form a single MPG file for access, FFmpeg can be used to concatenate either the .DAT files (if on Windows) or the extracted MPG files with the following method adapted from ffmprovisr [^17].

`ffmpeg -i concat:input01.mpg\|input02.mpg\|input03.mpg -c copy output_file.mpg`

## Conclusion

Despite being based in North America where VCDs were never a dominant format, the authors have encountered VCDs in their institutional collections in contexts ranging from commercially purchased circulating releases to individually authored videos mixed within broader archival collections. The above tools and methods have been useful for integrating these items into our digital preservation workflows, and should serve as a good starting point for readers attempting to both preserve and maintain access to any VCDs held in their collections.

## References

[Davidson, Andrew and Lediaev, Lucy. 1993](https://journal.code4lib.org/articles/#cite1). Video CD: What is Video CD? Philips Interactive Media

[Duryee, Alexander. 2014](https://journal.code4lib.org/articles/#cite2). An introduction to optical media preservation. Code4Lib Journal 24. \[accessed 2023 July 7\]. Available from: [https://journal.code4lib.org/articles/9581](https://journal.code4lib.org/articles/9581)

[Morel M, Blood G, Foltz B, Gallo B, Fuhrig L, Finkel P, McGrath J, Warnock R, Priebe J, Coates B, Kelly H](https://journal.code4lib.org/articles/#cite3). Preserving Write-Once DVDs Producing Disc Images, Extracting Content, and Preserving Write-Once DVDs: Producing Disc Images, Extracting Content, and Addressing Flaws and Errors. 2014. \[accessed 2023 Jul 17\]. Available from: [https://www.digitizationguidelines.gov/audio-visual/documents/Preserve_DVDs_BloodReport_20140901.pdf](https://www.digitizationguidelines.gov/audio-visual/documents/Preserve_DVDs_BloodReport_20140901.pdf)

[Super Video Compact Disc A Technical Explanation. 2001](https://journal.code4lib.org/articles/#cite4). \[accessed 2023 Jul 05\]. Available from: [https://wayback.archive-it.org/all/20080528131354/http://www.ip.philips.com/view_attachment/2450/sl00812.pdf](https://wayback.archive-it.org/all/20080528131354/http://www.ip.philips.com/view_attachment/2450/sl00812.pdf)

[Schüller, Dietrich. 2008](https://journal.code4lib.org/articles/#cite5). Audio and video carriers: Recording principles, storage and handling, maintenance of equipment, format and equipment obsolescence. \[accessed 2023 Jul 05\]. Available from: [http://www.tape-online.net/docs/audio_and_video_carriers.pdf](http://www.tape-online.net/docs/audio_and_video_carriers.pdf)

[Schweikert, Annie. 2018](https://journal.code4lib.org/articles/#cite6). An Optical Media Preservation Strategyvfor New York University’s Fales Library & Special Collections. \[accessed 2023 Jul 05\]. Available from: [https://archive.nyu.edu/handle/2451/43877](https://archive.nyu.edu/handle/2451/43877)

[van der Knijff J. Preserving optical media from the command-line. 2015 Nov 13](https://journal.code4lib.org/articles/#cite7) \[accessed 2023 Jul 18\]. Available from: [https://www.bitsgalore.org/2015/11/13/preserving-optical-media-from-the-command-line](https://www.bitsgalore.org/2015/11/13/preserving-optical-media-from-the-command-line)

## Endnotes

[^1]: Information at [https://www.videohelp.com/vcd](https://www.videohelp.com/vcd)
[^2]: For more information see [https://www.loc.gov/preservation/digital/formats/fdd/fdd000035.shtml](https://www.loc.gov/preservation/digital/formats/fdd/fdd000035.shtml)
[^3]: [http://www.mplayerhq.hu/DOCS/HTML/en/vcd.html](http://www.mplayerhq.hu/DOCS/HTML/en/vcd.html)
[^4]: While now only available via the Wayback machine, the legacy VCDImager documentation was often referenced by other sources and is a particularly good explainer of VCD structure and properties. [https://web.archive.org/web/20050207052857/http://www.vcdimager.org/pub/vcdimager/manuals/0.7/vcdimager.html#SEC6](https://web.archive.org/web/20050207052857/http://www.vcdimager.org/pub/vcdimager/manuals/0.7/vcdimager.html#SEC6)
[^5]: Bug report and subsequent removal from Debian packages here: [https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=718966](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=718966)
[^6]: [https://en.wikipedia.org/wiki/Mixed_Mode_CD](https://en.wikipedia.org/wiki/Mixed_Mode_CD)
[^7]: [https://www.isobuster.com/license-models.php](https://www.isobuster.com/license-models.php)
[^8]: [https://cdrdao.sourceforge.net/index.html](https://cdrdao.sourceforge.net/index.html)
[^9]: [https://en.wikipedia.org/wiki/Optical_disc_recording_modes](https://en.wikipedia.org/wiki/Optical_disc_recording_modes)
[^10]: [https://www.xiph.org/paranoia/](https://www.xiph.org/paranoia/)
[^11]: [https://www.gnu.org/software/vcdimager/#devel](https://www.gnu.org/software/vcdimager/#devel)
[^12]: The NTSC sample disc used in our testing was made from the test image on the legacy VCDImager website, which is a good example of a complex VCD. [https://web.archive.org/web/20051229173932/http://www.vcdimager.org/pub/vcdimager/examples/demovcd/](https://web.archive.org/web/20051229173932/http://www.vcdimager.org/pub/vcdimager/examples/demovcd/)

[^13]: Note that this item has been treated as a DVD in its catalog record for the purpose of sorting: [https://orbiscascade-washington.primo.exlibrisgroup.com/permalink/01ALLIANCE_UW/1juclfo/alma99110527400001452](https://orbiscascade-washington.primo.exlibrisgroup.com/permalink/01ALLIANCE_UW/1juclfo/alma99110527400001452). This appears to be not uncommon, and represents a potential challenge for any surveys of VCDs contained within Library collections.

[^14]: [https://linux.die.net/man/1/bchunk](https://linux.die.net/man/1/bchunk)
[^15]: [https://cdemu.sourceforge.io/](https://cdemu.sourceforge.io/)
[^16]: [https://wincdemu.sysprogs.org/](https://wincdemu.sysprogs.org/)
[^17]: [https://amiaopensource.github.io/ffmprovisr/#dvd_to_file](https://amiaopensource.github.io/ffmprovisr/#dvd_to_file)

*Andrew Weaver* is the Media Preservation Librarian at the University of Washington Libraries
(ORCID: [https://orcid.org/0000-0002-9792-4036](https://orcid.org/0000-0002-9792-4036)).
*Ashley Blewer* is an owner of Archives of Tomorrow, an archives technology company. (ORCID: [https://orcid.org/0009-0001-0814-5226](https://orcid.org/0009-0001-0814-5226)).

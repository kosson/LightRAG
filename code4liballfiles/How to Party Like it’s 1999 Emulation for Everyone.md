---
title: "How to Party Like it’s 1999: Emulation for Everyone"
source: "https://journal.code4lib.org/articles/11386"
author:
  - "[[The Code4Lib Journal]]"
published: 2016-04-25
created: 2025-01-10
description: "Emulated access of complex media has long been discussed, but there are very few instances in which complex, interactive, born-digital emulations are available to researchers. New York Public Library has made 1980-90's era video games from 5.25\" floppy disks in the Timothy Leary Papers accessible via a DosBox emulator. These games appear in various stages [...]"
tags:
  - "clippings"
---
# How to Party Like it’s 1999: Emulation for Everyone
Dianne Dietrich, Julia Kim, Morgan McKeehan, Alison Rhonemus

Emulated access of complex media has long been discussed, but there are very few instances in which complex, interactive, born-digital emulations are available to researchers. New York Public Library has made 1980-90’s era video games from 5.25″ floppy disks in the Timothy Leary Papers accessible via a DosBox emulator. These games appear in various stages of development and display the work of at least four of Leary’s collaborators on the games. 56 disk images from the Leary Papers are currently emulated in the reading room. New York University has made late 1990s-mid 2000’s era Photoshop files from the Jeremy Blake Papers accessible to researchers. The Blake Papers include over 300 pieces of media. Cornell University Library was awarded a grant from the NEH to analyze approximately 100 born-digital artworks created for CD-ROM from the Rose Goldsen Archive of New Media Art to develop preservation workflows, access strategies, and metadata frameworks. Rhizome has undertaken a number of emulation projects as a major part of its preservation strategy for born-digital artworks. In cooperation with the University of Freiburg in Germany, Rhizome recently restored several digital artworks for public access using a cloud-based emulation framework. This framework (bwFLA) has been designed to facilitate the reenactments of software on a large scale, for internal use or public access. This paper will guide readers through how to implement emulation. Each of the institutions weigh in on oddities and idiosyncrasies they encountered throughout the process — from accession to access.

## Background

Imagine this: you’re at your desk, triumphant, because you’ve finally imaged a collection of obsolete media. Maybe you had a box filled with 3.5″ floppy disks that have been lingering around the office for at least a decade now, or maybe somebody pointed you towards a spindle of CD-ROMs that needed imaging. Whatever the case, the hard part’s over now, right? You found the right hardware and software to transfer bit-perfect copies of the original storage medium and now you’ve got everything on a modern hard drive, with a file naming convention that would make even a cataloger weep with joy.

But the hard part isn’t over, is it? These are really old files, and some of them are completely unintelligible on your modern operating system. You double-click, and you’re confronted with discouraging error messages about incompatibility or, even worse, your modern operating system literally has no idea what to do with a file extension you’ve handed it. What now? Maybe you’ve heard something about emulation, about how to run an older computer in a newer computer. How does that work? Can you make that kind of magic happen? Yes, it’s possible: you can, in fact, party like it’s 1999.

Emulation has long been discussed, but how does it happen? \[[1](https://journal.code4lib.org/articles/#note1)\] It may feel like many in the library and archives communities now support emulation, but that wasn’t always the case. In previous years, emulation and migration were pitted against one another as strategies (then largely hypothetical) for preserving and creating access to complex born-digital material. Enter “migration vs. emulation” and “digital preservation” in a search box today and you will still find traces of the false dichotomy from the early to mid 2000s.\[[2](https://journal.code4lib.org/articles/#note2)\]

Until Emory University’s successes with the Salmon Rushdie archives in the 2010s, there were no well known and publicized use cases of emulation.\[[3](https://journal.code4lib.org/articles/#note3)\] While it is now widely accepted as an access method, there are still few examples of its implementation. Perhaps as discouraging, in most known cases, skilled teams of archivists and technologists had to invest enormous amounts of time, effort, and resources to work with emulation.

The archival field has taken great strides to begin dealing with born-digital collections and, with the increase in born-digital content, there is a recognition for studying emulation for datasets, computer generated artworks, and video games; or “complex media.”\[[4](https://journal.code4lib.org/articles/#note4)\] The cases detailed below offer examples from four institutions with different project scopes and institutional levels of support.

In 2012, when Cornell University Library was writing a grant proposal, “Preservation and Access Framework for Digital Art Objects,” (PAFDAO) they noted that emulation wasn’t a viable strategy for preservation or access and planned to not investigate it as such.\[[5](https://journal.code4lib.org/articles/#note5)\]\[[6](https://journal.code4lib.org/articles/#note6)\] By 2013, however, this sentiment had already changed. One of our authors had just started a two-year fellowship to be Digital Forensic Analyst on the project, and was urged by the PAFDAO advisory board to consider emulation. This was during [Rhizome](http://rhizome.org/)‘s successes emulating mid-90s Macintosh systems. “Compile the emulator from source,” they advised her. She nodded and scribbled this down in the lab notebook. The journey had only begun.

The Timothy Leary papers, acquired by the New York Public Library in 2011, included over 350 removable media objects. Processing of removable media did not take place until 2012, when the project was coming close to completion. Upon imaging, it was discovered that over 50 floppy disks contained in-progress versions of computer games Leary had been involved in developing. Forensic tools were able to identify the games as DOS executables, but viewing the games was a different story. The Forensic ToolKit (FTK) file viewer displays text, images, and some video, but does not run executables. For some Amiga and Apple disk images, the forensic tools did not provide any more information than the dreaded “unrecognized filesystem.” Ultimately, appraising the computer games and prospective game artwork required the use of three emulators. Processing the born-digital content in the Leary papers included three staff members: the Project Archivist, the Digital Archivist and the Digital Archives Assistant. Using the three emulators was time consuming in terms of research and implementation, even before they were ready for appraisal. Setup and appraisal took approximately four months for one part-time staff member.

Similarly, as late as fall 2015, New York University’s National Digital Stewardship Fellow was tasked with exploring access methods for the 1990’s era Jeremy Blake “Papers.” The collection’s value was with in-progress artwork created in obsolete computing environments.\[[7](https://journal.code4lib.org/articles/#note7)\] The fellowship required researching and writing a report exploring emulation as a possible strategy, but the grant funded project did not specify implementation. Like others, the Fellow had read and reached out to individuals involved with the few known successful case studies at the time. Bolstered by these recent successes, and with encouragement from NYU Libraries, she decided to explore emulation as a means to authentic access to the complex artworks. She was also encouraged by the latitude afforded from scholarly work embracing a spectrum of authenticity within the inherently variable genre of computer art.\[[8](https://journal.code4lib.org/articles/#note8)\] Setting up and testing the emulation involved 2 staff members, the NDS Fellow and the Digital Archivist, working over the course of 1.5 months, using approximately 50% of the Fellow’s time and 10% of the Digital Archivist’s.

Also in 2015, building on their earlier successes with emulation, Rhizome launched a project that brought wide visibility to a new approach to software emulation accessed online. In collaboration with the German bwFLA project (Baden-Wurttemberg Functional Long-Term Archiving and Access), Rhizome presented a popular online exhibition of three videogames/artworks created by Theresa Duncan as CD-ROMs in the 1990s.\[[9](https://journal.code4lib.org/articles/#note9)\] The Theresa Duncan exhibition built on bwFLA’s work with providing access to artworks held in the Transmediale CD-ROM Art Archive, and extended bwFLA’s remotely-hosted Emulation as a Service framework to a cloud-based implementation.\[[10](https://journal.code4lib.org/articles/#note10)\] The ability to share the URL for a remote emulation session, and therefore to embed access to a specific emulation environment as an iframe on virtually any website, allowed widespread access to the games, and embedded instantiations of the emulation site proliferated across social media.\[[11](https://journal.code4lib.org/articles/#note11)\]

Running the EaaS framework via cloud hosting allows for flexibility of server capacity in response to user demand for the games, by increasing or decreasing the number of virtual machines active at any given time as necessary. During the initial launch of the Theresa Duncan games on Rhizome’s emulators site, Rhizome reserved 750 virtual CPUs to accommodate the spike in user demand prompted by social media announcements of access to the games.\[[12](https://journal.code4lib.org/articles/#note12)\] Following the initial peak demand period, Rhizome was able to reduce the virtual CPU allotment number to 16, and accommodate additional requests by queuing other users. For ongoing access to the games, 4 virtual CPUs are assigned to the project.\[[13](https://journal.code4lib.org/articles/#note13)\]

## How to Emulate

Now that you have a sense of the authors’ initial forays into emulation, you may be thinking about how you might use it to access some of the materials in your own collection. While the road ahead can be winding and complex, it is ultimately quite rewarding to revive complex digital materials that have long been dormant. Drawn from the authors’ own experiences, what follows is a step by step guide to getting started with emulation.

### Step 1. Figuring out what runs your stuff

It may feel overwhelming to try and determine how to breathe life into old files, but here are some starting points that might help you. Before you dive into emulators and virtual machines, it is good to get a handle on what type of environment would be compatible with the digital material in front of you. Here, it can be helpful to think of files not just as discrete entities, but as objects whose existence is contingent on a complex network of dependencies, both hardware and software. The more you can determine about that environment, the better you can figure out what emulation strategy will work best for your materials. This can be a complicated process, so we’ve organized the overall strategy into manageable steps.

#### Use Existing System Requirements

System requirements, if you can find them, can be tremendously helpful. At Cornell, the testbed collection for the PAFDAO project came from CD-ROMs in the Rose Goldsen Archive of New Media Art. Fortunately for the project team, (nearly) all of the items in the testbed had been individually cataloged, and this included transcriptions of all of the system requirements printed on the jewel boxes and CD cases. In a lot of cases, this information was thorough, and gave the team a clear view of both the hardware and software requirements needed to properly render the files.\[[14](https://journal.code4lib.org/articles/#note14)\]

What happens, however, when the system requirements are not so clear or you don’t have any such documentation? There are a few ways to proceed from here. Knowing the approximate age of the digital files can also help you narrow down a compatible software environment. Consider what operating systems were in current use \[[15](https://journal.code4lib.org/articles/#note15)\] at the time of the files’ creation.\[[16](https://journal.code4lib.org/articles/#note16)\]\[[17](https://journal.code4lib.org/articles/#note17)\] The PAFDAO team at Cornell found it helpful to create a reference table that provided a starting point for possible compatible environments given an approximate age of a CD-ROM.\[[18](https://journal.code4lib.org/articles/#note18)\]

#### Examine the Disk Image for File System Clues

Forensics tools can also provide clues in helping you piece together the puzzle, especially if there is uncertainty about compatible hardware. Knowing what file system is present on a disk image will often point you to the hardware environment that you will need to emulate. The linux utility `disktype` in the BitCurator environment will identify what file system(s) exist on a disk image file.\[[19](https://journal.code4lib.org/articles/#note19)\] For example, HFS and HFS+ are Apple’s proprietary file systems, while NTFS is Microsoft’s proprietary file system. If you have CD-ROMs, like the Cornell team, you might find that you can have more than one file system represented on a single disk image, indicating multiple compatible hardware environments. If you are comfortable on the command line, `disktype` is tremendously helpful, but there are also graphical forensics tools that you can use. FTK Imager and IsoBuster will both display the file system(s) present on a disk image.\[[20](https://journal.code4lib.org/articles/#note20)\]\[[21](https://journal.code4lib.org/articles/#note21)\] The following examples reveal how file system information from disk images was used to uncover context for digital material.

Through investigating the corpus of hard drive and optical disk images in the Jeremy Blake Papers (at NYU), it was easy to come up with an accurate timespan of his output (1998 and later) by using file system metadata that indicated he worked in HFS+ file systems.\[[22](https://journal.code4lib.org/articles/#note22)\] For the Leary floppy disks (at NYPL) it was the process of selecting the correct sector format to interpret the disk images using the Kryoflux that took the most trial and error.\[[23](https://journal.code4lib.org/articles/#note23)\]\[[24](https://journal.code4lib.org/articles/#note24)\] This often involved trying different formats until the Kryoflux GUI displayed green sectors to indicate a good result. The Kryoflux hardware consists of a control board that connects to a floppy disk drive and from the control board to a modern computer through USB. The Kryoflux software can output a reading of the magnetic flux transitions on a disk and interpret those flux transitions as a sector format that could be read by the correct operating system.\[[25](https://journal.code4lib.org/articles/#note25)\] Once this initial format information had been obtained, choosing an emulator was more straightforward. Disk images with an Amiga filesystem require an Amiga emulator like WinUAE. To use Apple formatted disk images, one combines SheepShaver and an OS the approximate age of the disk. Forensic tools were helpful in determining the date of the DOS executables and some Mac files.

![Viewing sector matches in the Kryoflux graphical user interface showing 160 good sectors and 8 unknown](https://journal.code4lib.org/media/issue32/emulation/emulation1.png)  
**Figure 1.** Kryoflux Graphical User Interface displaying a sector match for Apple DOS

#### Perform File Level Analysis

What happens, though, when you don’t have a disk image to work from? File type analysis works when you have individual files. One of the most common tools for determining a file type is the command-line utility `file`, which can be directed at much more than just traditional files.\[[26](https://journal.code4lib.org/articles/#note26)\]

![An example of output from running the file command on a directory, shows list of file descriptions including size, color type, and program used to open it](https://journal.code4lib.org/media/issue32/emulation/emulation2.png)  
**Figure 2.** Using the `file` command on a directory of files

One way to start is by looking at the program executables first to see if that points you in the right direction. Here are some examples to guide your thinking here. Let’s say `file` outputs the following for an executable file: “MS-DOS executable, NE for MS Windows 3.x.” This tells you that you’re likely looking at a file that will need a PC environment running an old version of Windows. If you don’t have an executable (or software) file to analyze, don’t fear: running `file` on even “ordinary” files may still give you valuable information. Consider the following output for a word processing document: “Rich Text Format data, version 1, Apple Macintosh.” This output indicates that a Macintosh environment may be needed here, which may be more than you knew before.\[[27](https://journal.code4lib.org/articles/#note27)\]

In the case of the Jeremy Blake Papers, it was difficult to narrow down the range of Adobe Photoshop software versions he had used; they were not identified with standard file identification tools. Instead, this required a deeper look at the hex behind each of the files. Hexadecimal is a “human-readable” translation and condensing of the underlying bitstream of any file and, when standard tools don’t help, can provide useful clues.\[[28](https://journal.code4lib.org/articles/#note28)\] Any number of freely available tools allow you to switch from examining the rendered file, or the jpeg and psd file as you were meant to experience it, to the underlying hex (FTK Imager, for example). In the case of identifying Adobe Photoshop software versions used to create different Adobe Photoshop files, looking at the hex and ASCII could be used to corroborate or complicate other file identification tools. The key was to locate the “magic numbers,” or the bit of hex that was constant across different files of the same file type.\[[29](https://journal.code4lib.org/articles/#note29)\] Magic numbers are used in many file-level tools out there. While contemporary Adobe Photoshop PSD files were all identified with 8BPS, files created in other versions needed to be identified with other “magic numbers.” Through comparing hex with Adobe Photoshop documentation online, it was possible to identify what software versions of Adobe Photoshop were needed for access. This was balanced with the limitations in the operating systems emulated by SheepShaver. Adobe Photoshop CS, for example, requires an Mac operating system 10, a system that SheepShaver did not itself support.

![Display of opening HEX and ASCII headers in a set of files. Includes blocks of 4 numbers at a time and RDF/XML resource description](https://journal.code4lib.org/media/issue32/emulation/emulation3.jpg)  
**Figure 3.** Hex and ASCII of files from the Jeremy Blake Papers

If you’re using a graphical hex editor program, obtaining the data you see here can be accomplished by loading the files in question into the editor. Hex editor tools will show the hex values in one column and the more human-readable strings in an adjacent column. Many support copying and pasting output as you see here.

In NYU’s case, the use of file and standard file identification tools was limited, with example output: “Adobe Photoshop Image, 2925 x 1650, RGB, 3x 8-bit channels.” Standard file identification tools like the National Archive’s DROID (The National Archives n.d.) which draws on the PRONOM file format registry (available as GUI, too) also outputted “Adobe Photoshop” without version specificity.\[[30](https://journal.code4lib.org/articles/#note30)\] The magic number database drives many of the file identification tools available. Limitations like these encouraged the use of multiple tools and resources to verify information against.

![A DROid display showing a list of files and their programs](https://journal.code4lib.org/media/issue32/emulation/emulation4.jpg)  
**Figure 4.** Software version identification with DROID

In the case of matching content to system environments in EaaS, the modular architecture allows a streamlined approach to decision-making, while also enabling further customization for specific use cases. The project’s goal in providing pre-configured emulation environments suitable for accessing legacy CD-ROMs is to take advantage of the original context for this medium; at the height of their popularity, CD-ROMs were for the most part created as mass-market objects, made for wide access across common computers of the time period.\[[31](https://journal.code4lib.org/articles/#note31)\] This aspect makes CD-ROMs a good match for bwFLA’s focus on developing EaaS as an adaptable architecture, accommodating broad commonalities across different kinds of works; by offering a range of emulation environments based on common computers during the time period in which the CD-ROMs were released, the framework can provide an access situation for the contemporary user which is comparable to the original situation at the time of a given CD-ROM’s creation.\[[32](https://journal.code4lib.org/articles/#note32)\] For the Theresa Duncan project, Rhizome’s conservator identified four different operating systems which could run the games, and noted Macintosh System 7.5 as the best option for quick startup time and system stability.\[[33](https://journal.code4lib.org/articles/#note33)\]

### Step 2. Get the emulator running, but which emulator? And how?

From these investigations, you will have a sense of the timespan of your files and, after a little digging with a variety of tools, you may also have good idea of the filesystem. Now it’s time to start thinking about emulators. There are many kinds of computer system emulators out there.\[[34](https://journal.code4lib.org/articles/#note34)\] Here is a list of the emulators each of the authors worked with over the course of their projects. In addition, the PAFDAO project made notes of additional emulators for future reference.\[[35](https://journal.code4lib.org/articles/#note35)\]

![A screenshot of a spreadsheet listing emulator names, URLs, download sources, OSes, and additional components. Linked in captions.](https://journal.code4lib.org/media/issue32/emulation/emulation5.jpg)  
**Figure 5.** Emulators Used ([see also this spreadsheet of emulators](https://docs.google.com/spreadsheets/d/17abf-1ufF9VQIkhcwehTgIvTPP3okPakP8t21z51Hf0/edit#gid=0))

After you have figured out which emulator you might need, the next step is to figure out how to get that emulator up and running. One should not downplay the significance of this part, as it can range from fairly easy to maddeningly frustrating.

The process for each of these emulators is slightly different. [DOSBox](http://www.dosbox.com/) and [QEMU](http://qemu.org/) may be the most straightforward to install, as they both can be downloaded from their respective project’s websites or, if you’re using Linux, easily installed through your distribution’s package manager. If you’re using DOSBox, once you’ve downloaded the installer, you’re almost done: the DOS environment is already set up and ready for you to work with. In this environment, standalone executables should be able to run. DOSBox provides a very simple configuration file to choose a default directory path and mount a directory as the C: drive. Additional DOS utilities can be added for a more versatile system. QEMU requires a little more cajoling to function as a proper virtual machine running an old version of Windows, but first, let’s talk about how to get the Macintosh emulators started.

While there are pre-compiled binaries for [Basilisk II](http://basilisk.cebix.net/) and [SheepShaver](http://sheepshaver.cebix.net/) that have been created by the community, the PAFDAO team and NYU found that compiling from source made them less prone to spontaneous and frequent crashing. This wasn’t straightforward, though, because, at the time (2013-2014) the codebase was fairly old. Compiling the source on [BitCurator](http://www.bitcurator.net/) (which was built on Ubuntu 12.04LTS, and, starting in May 2014, 14.04LTS) resulted in a non-functioning program. Through some determined sleuthing, the PAFDAO team at Cornell discovered that using an older version of the compiler (i.e., gcc 4.4) was the only way to stably run the emulator on their systems.\[[36](https://journal.code4lib.org/articles/#note36)\] The authors stress that this shouldn’t deter you — there is still an active community for both Basilisk II and SheepShaver and there are likely more functional pre-compiled binaries now than when we started.

At NYU, the Fellow initially tried pre-built emulators and also experimented with using a variety of host computers, from contemporary Windows and Mac environments, before ultimately turning to using older laptop computers installed with Ubuntu 10.0 operating system. In the initial attempts, accessing Photoshop PSD files in Adobe Photoshop 3 versus Adobe Photoshop 6 software versions resulted in very differently rendered images. Images were often glitchy and, from comparing across platforms and software systems, clearly not anywhere approaching what the artist intended. The bwfla-demo site was invaluable as an additional comparative emulator to test identical files against.

Where was the fault? Why did one version work, but not the other in the same environment? These errors initiated several weeks of investigation; they also made it clear how many different dependencies were in play. Even small changes to emulation settings factored into the stability of the system. While the bitstream of the original file might have been exactly preserved, the many supporting systems mimicked are inexact. Ultimately, the NDS Fellow was tipped to forgo using the optical media images she created in FTK Imager, and instead use the Linux utility `dd` to create an ISO file. Loading these new images via USB onto the emulator solved one of the problems. The host computer was an additional unexpected major variable. The Digital Archivist and Fellow tested a variety of operating systems on different host laptops. Each test configuration took approximately 6 hours set-up to test if the emulator loaded properly and rendered the Adobe Photoshop file in multiple software versions correctly. At some points, it seemed that a viable solution did not exist, but ultimately they were able to configure an older non-contemporary laptop installed with Ubuntu 10.0 to accept the Photoshop files.

![Glitches and blocks in color photos](https://journal.code4lib.org/media/issue32/emulation/emulation6.jpg)  
**Figure 6.** Glitchy rendering of emulated Adobe Photoshop files (Jeremy Blake Papers)

Once you have QEMU, Basilisk II, and/or SheepShaver started, you’ve made significant progress in your journey, but you’re not totally there yet. You’ll need two (or three) more ingredients to keep going. First, you will need an original installation disk from (or a disk image of) a compatible operating system. For example, if you wanted to use QEMU to emulate a Windows 2000 environment, you will need QEMU and a copy of the Windows 2000 installer. Similarly, if you wanted to use SheepShaver to emulate a Mac running OS 9, you will need a retail copy of OS 9.\[[37](https://journal.code4lib.org/articles/#note37)\]

Second, you will need to create a file that essentially represents the hard drive of the emulated system. The process by which you do this in QEMU, Basilisk II, and SheepShaver varies slightly. In QEMU, there is a command line utility to create the disk image file or you can use any of the graphical front ends to do this.\[[38](https://journal.code4lib.org/articles/#note38)\] \[[39](https://journal.code4lib.org/articles/#note39)\] For Basilisk II and SheepShaver, you use the SheepShaver graphical interface to do this. When considering what size to make this disk image file, remember that hard drive sizes have increased dramatically since the 1990s. That is to say, it’s unlikely that for most of the older operating systems, you’ll need anything more than a 2GB file.

If your target is a Macintosh or Amiga system, there are a few more steps you will need to take. In addition to the emulator and the operating system installer, you also need a read only memory (ROM) file, which is the firmware for the hardware required for these systems. In the Apple and Amiga communities, early users of emulation had to extract the firmware using actual hardware, but you can benefit from their hard work and download the files you need fairly easily online.\[[40](https://journal.code4lib.org/articles/#note40)\] \[[41](https://journal.code4lib.org/articles/#note41)\] In the Basilisk II, SheepShaver, and WinUAE interfaces, on the “Memory/Misc” tab there is a place to enter in the location of the ROM file so you can get things moving. The main difference in the preference interface of the Amiga emulator WinUAE is that the file name of the ROM is kickstart.ROM. In addition to a ROM file, it is useful to have unmodified WorkBench disk images. WorkBench is the desktop interface of the Amiga.

At NYPL the Leary papers did come with Workbench disks that were imaged, but since these disks had been written to, they were loaded as secondary disk images rather than as the boot disk image.

![A view of the Amiga desktop, light mauve color, 90s-style floppy disk icons with labels as disknames](https://journal.code4lib.org/media/issue32/emulation/emulation7.png)  
**Figure 7.** WorkBench: Amiga desktop WinUAE, Timothy Leary papers, Neuromancer, Development Disks, NYPL

![Artistic 90s rendering of singer Grace Jones in a black leather jacket with tall hair shaved on the sides](https://journal.code4lib.org/media/issue32/emulation/emulation8.png)  
**Figure 8.** Grace Jones as Molly, Timothy Leary papers, Neuromancer, Development Disks, NYPL

Although DOSBox was simple to install, and able to run the Leary game executables (at NYPL) fairly consistently, game play is not entirely smooth. Almost all of the disk images contain in-progress works. The games may end abruptly or crash, or there could be display issues that make some text illegible. The disk images also contain correspondence between Leary and the other collaborators working on the games alongside the executables. This text can be viewed in DOSBox but additional DOS utilities would make viewing the documents easier and could help with other display issues. Additional utilities were tested but were not installed in the reading room. The correspondence included with the executables is also available in more standard electronics records components of text documents, but it does take some digging to find which document belongs to which disk.

![An interactive moment in Neuromancer in which you may talk to the bartender.](https://journal.code4lib.org/media/issue32/emulation/emulation9.png)  
**Figure 9.** Neuromancer in DOSBox, Timothy Leary papers, Neuromancer, Development Disks, NYPL

You may be thinking about alternatives to all of this custom configuration and setup, and we think you have good reason. All of the above work is complex, and those of us who slogged our way through it did often dream of a more automated way to pull everything together. While we think there’s nothing quite like knowing it’s possible to have a handle on all of the knobs and levers to tweak every aspect of your emulated environment (perhaps to support access for a highly specialized collection), there are other options out there for you.

In October 2015, bwFLA developed a range of options that enable interested users to download, install, and run the Emulation as a Service platform via Docker containers, thereby making it quite straightforward to run a variety of preconfigured emulation environments locally.\[[42](https://journal.code4lib.org/articles/#note42)\] The contained version includes workflows for ingest, customization, and testing that mirror the functionality of the framework provided at the bwFLA demo site, which allows the user to select the emulator and operating system they would like to use from drop-down menus in a graphic user interface. Availability of the entire framework packaged within these containers greatly simplifies installation of the framework as a local implementation, allowing a wider range of users to try out EaaS. The contained implementation also allows for running the framework in a variety of ways, including as a self-contained system, or from a live USB system, which allows one to boot a computer directly into an emulation environment.\[[43](https://journal.code4lib.org/articles/#note43)\] It’s important to note that this range of options also allows users to experiment with creating their own customizations of the framework, saved on their local machine. Two posts on the bwFLA project blog detail the structure of the Docker setup, as well as system prerequisites, and instructions for installation and operation.\[[44](https://journal.code4lib.org/articles/#note44)\] These posts also provide links to the USB image for download, and to bwFLA’s Docker containers and scripts.

### Step 3. At long last, access

User interfaces have changed dramatically in the last twenty years. Once you’ve got your emulated system up and running — and we feel like a broken record for saying this, but it’s true — there may still be more hurdles for you to clear. Do you remember how to use DOS? One of our authors appreciates the OS 9 training she received as an undergrad employed by her university’s Helpdesk, which is the only reason she was able to quickly locate the system settings on that operating system. The question facing you once you’ve set everything up is, how do users and researchers react to emulated environments? \[[45](https://journal.code4lib.org/articles/#note45)\] What can you do to make the translation of old technology on newer machines as seamless as possible for your users?

Another concern in many institutions is how will archival staff use and support researchers coming to access emulated collections? At NYU, the Fellow met with reference archivists to plan for this step through walking through the basics of what to do to, for example, restart a crashed emulator. In meetings with archivists across the institution, the oft-cited example of, “If the collection is in another language, it’s the researchers’ responsibility to know that language (not the archivist),” did a lot to define how far staff could and should support patrons’ access to emulated collections.\[[46](https://journal.code4lib.org/articles/#note46)\]

It’s easy to forget that, for older digital material, ReadMe files and documentation may not be optional. To give one example, the PAFDAO team was working with a researcher who noticed that a certain artwork was too responsive to mouse input and was moving far too fast. At first, it was easy to dismiss this as a typical artifact of the emulation process — many have documented this exact behavior when using emulation — but after closer inspection, it actually wasn’t the case. The documentation from the artist indicated that the user should navigate the artwork using the keyboard and not the mouse. Once the user made that change, the artwork responded more in line with the user’s expectations than before. Heed our advice here: it may not be the emulator’s fault. It may be something much more subtle.

As part of assessing born-digital access, the NYU Fellow invited experienced archival researchers to explore emulated collections. In multiple tests, the searchers loaded the same image on older computers as well as on the emulator. It reassured and reminded both archivist and researcher of their own modern expectations. In the 1990s computers were so comparatively slow it was hard to comprehend that something was not broken.

The PAFDAO team at Cornell contended with the fact that they were working with artworks that, in the words of one of the curators, “invoked the need to authentically preserve their digital context” \[[47](https://journal.code4lib.org/articles/#note47)\] ; that is, the hardware and software environments required to run them. This sometimes meant the muted, reddish tones of a CRT monitor, and not the bright blue hues on a new widescreen LCD monitor. The team found some ways to mediate changes like this, such as making use of utilities that reduce the brightness of LCD screens to alleviate eye strain or manually setting the color balance on monitors. None of these strategies were perfect, however, and every adjustment was often at the expense of some other aspect of the experience.

At NYPL, guides to using the emulators are available in the reading room in versions for researchers and library staff. Researchers do need guides in order to be able to view this material. User interfaces have changed and those used to 21st Century computing may find older systems counter-intuitive and frustrating. While there are guides to using emulators, there are often no guides to playing the games. The development status of the material means the help sections of the programs are mostly useless. When game instructions do exist they may be located in an electronic record component or even in paper records.

Emulation for access would work best for researchers who are familiar with older computer systems, appreciate the context provided by an age appropriate computing environment and are ready for a challenge. This is a rare combination. The audience for the theory of Leary’s games is present but often researchers writing on Leary’s theory and intent for the games have little interest playing the games. A popular frame of reference for the games is that Leary saw them as the new psychedelics yet researchers comfortable writing about mind altering experiences were still not up to play the games.

The researchers that came to study Jeremy Blake’s Papers all appreciated the emulation, especially as they came to better understand the processes in place to create it. Surprisingly, they preferred to use contemporary computers to the emulator. Ultimately, stability, speed, and familiarity were much more important to researchers than authenticity and fidelity. If they were going to work more on the technical specifications or were writing a book-length work on his work processes, the researchers would explore the emulator more fully, but for ease of access contemporary researchers want contemporary machines.\[[48](https://journal.code4lib.org/articles/#note48)\]

Stability and speed were also primary criteria in evaluating the emulated performances of Theresa Duncan’s artworks in Rhizome’s exhibition. In the case of providing access to interactive works via emulators running remotely, reducing network latency is important for minimizing the potential for sluggish response to user input, which would obviously have a negative effect on the quality of a user’s experience. As described above, the interactive nature of CD-ROM artworks requires seamless delivery of multimedia content such as a responsive mouse pointer or constantly changing narrative and pictorial elements. For this reason, it’s necessary to evaluate and if possible reduce lag time between the remote emulation and the user’s computer to provide adequately quick response for the context of a particular game. In the case of the Theresa Duncan games, the user’s perusal of a detailed fictional landscape, and the voice-over narration of printed text on the screen encourages a relaxed pace. For this use case, streaming was able to deliver sufficient response time, but the streaming model could present problems for faster-paced skill-based interactive games requiring instantaneous reaction time.\[[49](https://journal.code4lib.org/articles/#note49)\]

Streaming also presents a significant challenge for providing continuity of audio content. Since the user’s interaction with the emulated software unfolds in real time, buffering content is not possible, but any gaps or stuttering in music or sounds meant to be continuous will be very distracting and disruptive of the overall rendering quality. Evaluating sound quality of performances of the same artwork via different access points, for example on the bwFLA project’s demo server located in Germany, at Rhizome’s cloud-hosted emulators site, which attempts to optimize network latency by allocating server resources close to the user’s location, and on a local installation demonstrates the importance of this criteria for remote emulation’s viability as an access strategy. To address these issues, in selecting an environment for presenting Duncan’s games, performance was evaluated for overall clarity of representation in graphic and sound elements, and the framework was configured accordingly; project documentation notes that for Rhizome’s emulators site, EaaS was configured to use lossless (compressed) graphics instead of video codecs to eliminate visual artifacts, and OGG/Vorbis audio compression to prioritize continuity of sound.\[[50](https://journal.code4lib.org/articles/#note50)\]

## Conclusions

The examples discussed in this paper, and the increasing body of supporting research cited here, demonstrate the viability of emulation as a method for accessing complex digital objects that would otherwise be lost to incompatibilities and technological obsolescence. For example, the model employed by EaaS provides significant reduction of many of the complexities experienced by projects described in this paper, by providing emulation environments constructed as modular components. Ongoing development of EaaS demonstrates further improvements in interoperability, such as more flexible support for multiple disk image formats across emulators.\[[51](https://journal.code4lib.org/articles/#note51)\]

Additionally, a number of unexpected observations within these projects indicate that as viability paves the way for an accumulation of usage instances, applying emulation as a strategy across a broader range of legacy materials may provide additional affordances, such as enabling detailed and accurate analysis of complex digital objects. For example, faced with an artwork containing files that seemed out of place on the particular file system (e.g., readme files for running a work in Windows on a Macintosh-formatted disk), PAFDAO team members discovered that emulation helped clarify what was happening and allowed for better user documentation. In the course of examining another set of interrelated digital material, the PAFDAO team also combined file-level analysis with emulation to clarify how close to the original an emulated version actually was, or had the potential to be.\[[52](https://journal.code4lib.org/articles/#note52)\]

In the NYU case, emulation exposed major errors in the imaging process of the Jeremy Blake files, as well as incompatibilities with the closed and proprietary software versions used. Given the value of the insights provided in this instance, it is particularly important to emphasize that this project found it necessary to rely on older host machines for running the emulators. This challenge, and the essential role played by emulation for accomplishing the broader project objectives, underlines the need for ongoing awareness and collaborative work, to update existing emulation software builds and to ensure sustained interoperability with contemporary host computers in the future.\[[53](https://journal.code4lib.org/articles/#note53)\] While archives are just beginning to address backlogs of born-digital content for preservation and access, as more archival collections continue to collect contemporary (born-digital) collections, understanding the problems learned from emulating yesterday’s obsolete collections now will lay the groundwork for the future.

## About the Authors

Dianne Dietrich is the Digital Projects Librarian at Cornell University Library. From 2013-2015, she was Digital Forensic Analyst and Digital Scholarship and Preservation Services Fellow working on the library’s NEH-funded project, Preservation and Access Frameworks for Digital Art Objects.  
dd388@cornell.edu [@smallandmath](http://twitter.com/smallandmath)

Julia Kim is the Digital Assets Manager at the American Folklife Center at the Library of Congress. She was previously a National Digital Stewardship Resident at New York University Libraries where she completed the work covered in this article.  
juliakim@loc.gov [@jy\_kim29](http://twitter.com/jy_kim29)

Morgan McKeehan is a National Digital Stewardship Resident in the 2015-16 NDSR-NYC cohort. Her NDSR host site is Rhizome, an internet-based contemporary art organization dedicated to promoting richer and more critical digital cultures. morgan.mckeehan@rhizome.org [@anyformation](http://twitter.com/anyformation)

Alison Rhonemus is the Digital Archives Assistant at the New York Public Library. She has been working on born-digital collection material there since a previous internship focused on digital forensics. alisonrhonemus@nypl.org

## Acknowledgements

The authors would like to thank Lisa Darms, Dragan Espenschied, Thomas Liebetraut, Susan Malsbury, Donald Mennerich, Klaus Rechert, Jennifer Ulrich and the bwFLA project. This work was done with the support of many organizations, including the NDSR in New York program, which is funded by IMLS, and implemented by the Metropolitan New York Library Council in partnership with Brooklyn Historical Society, and the NEH-funded Preservation and Access Framework for Digital Art Objects project at Cornell University Library. Finally thanks to the researchers that were willing to come in and give emulation a shot!

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Rothenburg, J. 1999. Avoiding Technological Quicksand: Finding a Viable Technical Foundation for Digital Preservation. Council on Library and Information Resources \[Internet\]. \[cited 2016 Feb 19\]; 77. Available from: [http://www.clir.org/pubs/reports/rothenberg/pub77.pdf](http://www.clir.org/pubs/reports/rothenberg/pub77.pdf)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Bearman, D. 1999. Realities and chimeras in digital preservation. D-lib magazine \[Internet\]. \[cited 2016 Feb 17\]; 5(4). Available from: [http://www.dlib.org/dlib/april99/bearman/04bearman.html](http://www.dlib.org/dlib/april99/bearman/04bearman.html)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Carrol L, Farr E, Hornsby P, Ranker B. 2011. A Comprehensive Approach to Born-Digital Archives. Archivaria \[Internet\] \[cited 2016 Feb 17\]; 72: 61-92. Available from: [http://pid.emory.edu/ark:/25593/cksgv/](http://pid.emory.edu/ark:/25593/cksgv/)

\[[4](https://journal.code4lib.org/articles/#ref4)\] For this paper, we are using “emulation” to mean any strategy where a hardware and software environment are rendered in a host machine, and “emulator” to mean any program that lets you do this.

\[[5](https://journal.code4lib.org/articles/#ref5)\] Preservation and Access Framework for Digital Art Objects was a two-year research and development grant at Cornell University Library funded by the National Endowment for the Humanities. For more information on the grant, see (Rieger et. al 2015) and the site’s wiki for more information about the project scope, activities, and advisory board: [https://confluence.cornell.edu/display/pafdao/](https://confluence.cornell.edu/display/pafdao/)

\[[6](https://journal.code4lib.org/articles/#ref6)\] Casad M, Rieger O. Y., Alexander D. 2015. Enduring Access to Rich Media Content: Understanding Use and Usability Requirements. D-Lib Magazine(21) 9. DOI: 10.1045/september2015-casad

\[[7](https://journal.code4lib.org/articles/#ref7)\] Kim J, Mennerich D. forthcoming. Jeremy Blake’s Time-Based Paintings: A Case Study. Electronic Media Group, volume 4.

\[[8](https://journal.code4lib.org/articles/#ref8)\] Espenschied, D. 2012. One Terabyte of Kilobyte Age: Digging Through the Geocities Torrent. \[cited 2015 Feb 17. Available from: [http://blog.geocities.institute/archives/3214/](http://blog.geocities.institute/archives/3214/)

\[[9](https://journal.code4lib.org/articles/#ref9)\] Rhizome to Restore and Present Theresa Duncan CD-ROMs \[Internet\].\[updated 2014 Nov 18\]. Rhizome; \[cited 2016 Feb 19\]. Available from: [http://rhizome.org/editorial/2014/nov/18/announcing-theresa-duncan/](http://rhizome.org/editorial/2014/nov/18/announcing-theresa-duncan/)

\[[10](https://journal.code4lib.org/articles/#ref10)\] Rhizome’s emulators are hosted on Google Compute.

\[[11](https://journal.code4lib.org/articles/#ref11)\] Robertson, A. 2015. The girl game archival project that’s rewriting geek history. The Verge \[Internet\]. \[cited on 2016 Feb 19\]. Available from: [http://www.theverge.com/2015/4/17/8436439/theresa-duncan-chop-suey-cd-rom-preservation/](http://www.theverge.com/2015/4/17/8436439/theresa-duncan-chop-suey-cd-rom-preservation/)

\[[12](https://journal.code4lib.org/articles/#ref12)\] D. Espenschied, personal communication, April 1, 2015

\[[13](https://journal.code4lib.org/articles/#ref13)\] Espenschied D, Valizada I, Stobbe O, Liebetraut T, Rechert K. 2015. (Re-)publication of Preserved, Interactive Content – Theresa Duncan CD-ROMs: Visionary Videogames for Girls. In iPRES 2015 annual meeting, 2015 Nov 2-6; Chapel Hill, NC

\[[14](https://journal.code4lib.org/articles/#ref14)\] For an example of System Requirements on an artwork, see: [https://newcatalog.library.cornell.edu/catalog/6099417/](https://newcatalog.library.cornell.edu/catalog/6099417/)

\[[15](https://journal.code4lib.org/articles/#ref15)\] See also [https://twitter.com/euanc/status/698265036997992448/](https://twitter.com/euanc/status/698265036997992448/) for an excellent graph of operating system usage over time.

\[[16](https://journal.code4lib.org/articles/#ref16)\] Timeline of Operating Systems \[internet\].\[updated 2016 Feb 18\]. Wikipedia; \[cite 2016 Feb 19\]. Available from: [https://en.wikipedia.org/wiki/Timeline\_of\_operating\_systems/](https://en.wikipedia.org/wiki/Timeline_of_operating_systems/)

\[[17](https://journal.code4lib.org/articles/#ref17)\] Timeline of Operating Systems \[internet\].\[updated 2016 Feb 18\]. Wikipedia; \[cite 2016 Feb 19\]. Available from: [https://en.wikipedia.org/wiki/Timeline\_of\_operating\_systems](https://en.wikipedia.org/wiki/Timeline_of_operating_systems)

\[[18](https://journal.code4lib.org/articles/#ref18)\] Dietrich D. and Adelstein F. 2015. Archival science, digital forensics, and new media art. Digital Investigation(14) Supplement 1. DOI: [http://dx.doi.org/10.1016/j.diin.2015.05.004](http://dx.doi.org/10.1016/j.diin.2015.05.004)

\[[19](https://journal.code4lib.org/articles/#ref19)\] BitCurator \[Internet\].\[updated 2016 Jan 18\]. Bitcurator.net; \[cited 2016 Feb 19\]. Available from: [http://www.bitcurator.net/](http://www.bitcurator.net/)

\[[20](https://journal.code4lib.org/articles/#ref20)\] FTK Imager \[Internet\].\[updated 2010 Dec 17\]. Forensics Wiki; \[cited 2016 Feb 19\]. Available from: [http://www.forensicswiki.org/wiki/FTK\_Imager/](http://www.forensicswiki.org/wiki/FTK_Imager/)

\[[21](https://journal.code4lib.org/articles/#ref21)\] IsoBuster \[Internet\].\[updated 2016\]. Smart Projects; \[cited 2016 Feb 19\]. Available from: [http://www.isobuster.com/](http://www.isobuster.com/)

\[[22](https://journal.code4lib.org/articles/#ref22)\] HFS+ was introduced in 1998 by Apple Computer.

\[[23](https://journal.code4lib.org/articles/#ref23)\] Beech, William A.. 2015. Floppy Disk Formats, Standards and Geometry \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://www.nj7p.org/Computers/Disk%20Subsystems/floppies.html](http://www.nj7p.org/Computers/Disk%20Subsystems/floppies.html)

\[[24](https://journal.code4lib.org/articles/#ref24)\] The Kryoflux is a hardware and software system used to create disk images of floppy disks. [http://www.kryoflux.com/](http://www.kryoflux.com/)

\[[25](https://journal.code4lib.org/articles/#ref25)\] Software Preservation Society, Glossary, retrieved from [http://www.softpres.org/glossary:encoding/](http://www.softpres.org/glossary:encoding/)

\[[26](https://journal.code4lib.org/articles/#ref26)\] See the Wikipedia entry for file for example usage: [https://en.wikipedia.org/wiki/File\_%28command%29#Examples](https://en.wikipedia.org/wiki/File_%28command%29#Examples)

\[[27](https://journal.code4lib.org/articles/#ref27)\] Even though it’s tempting, the “version 1” part doesn’t help you out that much: [https://en.wikipedia.org/wiki/Rich\_Text\_Format#History](https://en.wikipedia.org/wiki/Rich_Text_Format#History)

\[[28](https://journal.code4lib.org/articles/#ref28)\] if you’re feeling adventurous, you can also use the output of the command line utility strings to find more deeply hidden clues as to what to do next. See [http://www.thegeekstuff.com/2010/11/strings-command-examples/](http://www.thegeekstuff.com/2010/11/strings-command-examples/).

\[[29](https://journal.code4lib.org/articles/#ref29)\] Magic number (programming) \[Internet\].\[updated 2016 Jan 10\]. Wikipedia; \[cited 2016 Feb 19\]. Available from: [https://en.wikipedia.org/wiki/Magic\_number\_%28programming%29](https://en.wikipedia.org/wiki/Magic_number_%28programming%29)

\[[30](https://journal.code4lib.org/articles/#ref30)\] The National Archives. n.d. Download DROID: file format identification tool \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/](http://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/)

\[[31](https://journal.code4lib.org/articles/#ref31)\] This conceptual approach is similar to the commonalities noted in the reference table provided by the PAFDAO project’s documentation, mentioned above. The bwFLA project is also working to automate the process of determining suitable emulation environments for a given set of files (Rechert et al. 2015) iPres.

\[[32](https://journal.code4lib.org/articles/#ref32)\] Rechert K, Liebetraut T, Stobbe O, Valizada I, and Steinke T. 2015. Characterization of CD-ROMs for Emulation-based Access. In iPRES 2015.

\[[33](https://journal.code4lib.org/articles/#ref33)\] Espenschied D, Valizada I, Stobbe O, Liebetraut T, Rechert K. 2015. (Re-)publication of Preserved, Interactive Content – Theresa Duncan CD-ROMs: Visionary Videogames for Girls. In iPRES 2015 annual meeting, 2015 Nov 2-6; Chapel Hill, NC

\[[34](https://journal.code4lib.org/articles/#ref34)\] List of computer system emulators \[Internet\]. Wikipedia, The Free Encyclopedia; 2016 Jan 10 \[cited 2016 Feb 17\]. Available from: [https://en.wikipedia.org/wiki/List\_of\_computer\_system\_emulators/](https://en.wikipedia.org/wiki/List_of_computer_system_emulators/)

\[[35](https://journal.code4lib.org/articles/#ref35)\] Dietrich D. Emulation and Classification Documentation for PAFDAO Project. Available from: [http://hdl.handle.net/1813/41453](http://hdl.handle.net/1813/41453)

\[[36](https://journal.code4lib.org/articles/#ref36)\] Dietrich D. Emulation and Classification Documentation for PAFDAO Project. Available from: [http://hdl.handle.net/1813/41453](http://hdl.handle.net/1813/41453)

\[[37](https://journal.code4lib.org/articles/#ref37)\] Setting up SheepShaver for Mac OS X \[Internet\].\[updated 2014 Feb 2\]. Emaculation.com; \[cited 2016 Feb 19\]. Available from: [http://www.emaculation.com/doku.php/sheepshaver\_mac\_os\_x\_setup/](http://www.emaculation.com/doku.php/sheepshaver_mac_os_x_setup/)

\[[38](https://journal.code4lib.org/articles/#ref38)\] QEMU: Creating a hard disk image \[Internet\].\[updated 2016 Feb 15\]. \[cited 2016 Feb 19\]. Available from: [https://wiki.archlinux.org/index.php/QEMU#Creating\_a\_hard\_disk\_image](https://wiki.archlinux.org/index.php/QEMU#Creating_a_hard_disk_image)

\[[39](https://journal.code4lib.org/articles/#ref39)\] [http://wiki.qemu.org/Links#GUI\_Front\_Ends](http://wiki.qemu.org/Links#GUI_Front_Ends)

\[[40](https://journal.code4lib.org/articles/#ref40)\] Capturing a Mac ROM Image \[Internet\].\[updated 2010 Mar 20\]. Emaculation.com; \[cited 2016 Feb 19\]. Available from: [http://www.emaculation.com/doku.php/capturing\_rom/](http://www.emaculation.com/doku.php/capturing_rom/)

\[[41](https://journal.code4lib.org/articles/#ref41)\] See [http://www.redundantrobot.com/sheepshaver-tutorial/](http://www.redundantrobot.com/sheepshaver-tutorial/) and [https://archive.org/details/mac\_rom\_archive\_-\_as\_of\_8-19-2011/](https://archive.org/details/mac_rom_archive_-_as_of_8-19-2011/) for Macintosh ROM files that you can use and [http://fs-uae.net/kickstarts](http://fs-uae.net/kickstarts) for Amiga Kickstart ROMs.

\[[42](https://journal.code4lib.org/articles/#ref42)\] Rechert, K. 2015a. Emulation as a Service as a Docker (Beta) \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://bw-fla.uni-freiburg.de/wordpress/?p=817](http://bw-fla.uni-freiburg.de/wordpress/?p=817)

\[[43](https://journal.code4lib.org/articles/#ref43)\] Rechert, K. 2015b. Boot to Emulation — EaaS as a Local Option (Beta) \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://bw-fla.uni-freiburg.de/wordpress/?p=844](http://bw-fla.uni-freiburg.de/wordpress/?p=844)

\[[44](https://journal.code4lib.org/articles/#ref44)\] Rechert, K. 2015a. Emulation as a Service as a Docker (Beta) \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://bw-fla.uni-freiburg.de/wordpress/?p=817](http://bw-fla.uni-freiburg.de/wordpress/?p=817); and Rechert, K. 2015b. Boot to Emulation — EaaS as a Local Option (Beta) \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://bw-fla.uni-freiburg.de/wordpress/?p=844](http://bw-fla.uni-freiburg.de/wordpress/?p=844)

\[[45](https://journal.code4lib.org/articles/#ref45)\] Kim, Julia. “Researcher Interactions with Born-Digital: Out of the Frying Pan and INto the Reading Room.” SAA ERS blog. Society of American Archivists. Blog. \[cited 2016 March 23\]. Available from: [https://saaers.wordpress.com/](https://saaers.wordpress.com/)

\[[46](https://journal.code4lib.org/articles/#ref46)\] AIMS Work Group. 2012. AIMS Born-Digital Collections: An Inter-Institutional Model for Stewardship. \[cited 2016 Feb 17\], p.37. Available from: [http://www2.lib.virginia.edu/aims/whitepaper/AIMS\_final.pdf](http://www2.lib.virginia.edu/aims/whitepaper/AIMS_final.pdf)

\[[47](https://journal.code4lib.org/articles/#ref47)\] Personal correspondence with Madeleine Casad, 2015.

\[[48](https://journal.code4lib.org/articles/#ref48)\] Hedstrom M, Lee C, Olson J, Lampe C. 2006. “The Old Version Flickers More”: Digital Preservation from the User’s Perspective. The American Archivist \[Internet\]. \[cited 2016 Feb 19\]; 69(1):159-187. Available from: [http://www.ils.unc.edu/callee/dig-pres\_users-perspective.pdf](http://www.ils.unc.edu/callee/dig-pres_users-perspective.pdf)

\[[49](https://journal.code4lib.org/articles/#ref49)\] Espenschied D, Valizada I, Stobbe O, Liebetraut T, Rechert K. 2015. (Re-)publication of Preserved, Interactive Content – Theresa Duncan CD-ROMs: Visionary Videogames for Girls. In iPRES 2015 annual meeting, 2015 Nov 2-6; Chapel Hill, NC

\[[50](https://journal.code4lib.org/articles/#ref50)\] Espenschied D, Valizada I, Stobbe O, Liebetraut T, Rechert K. 2015. (Re-)publication of Preserved, Interactive Content – Theresa Duncan CD-ROMs: Visionary Videogames for Girls. In iPRES 2015 annual meeting, 2015 Nov 2-6; Chapel Hill, NC

\[[51](https://journal.code4lib.org/articles/#ref51)\] Liebtraut, T. Unifying Access to Virtual Disk Images – The EaaS Way\[Internet\]. \[cited 2016 March 23\]. Available from: [http://bw-fla.uni-freiburg.de/wordpress/?p=914](http://bw-fla.uni-freiburg.de/wordpress/?p=914)

\[[52](https://journal.code4lib.org/articles/#ref52)\] For more detail on how the PAFDAO team used emulation for analysis, see (Dietrich and Adelstein 2015).

\[[53](https://journal.code4lib.org/articles/#ref53)\] There are several recent reports highlighting other challenges to implementing emulation. See legal challenges: [http://blogs.loc.gov/digitalpreservation/2016/01/intellectual-property-rights-issues-for-software-emulation-an-interview-with-euan-cochrane-zach-vowell-and-jessica-meyerson/](http://blogs.loc.gov/digitalpreservation/2016/01/intellectual-property-rights-issues-for-software-emulation-an-interview-with-euan-cochrane-zach-vowell-and-jessica-meyerson/) and for an assessment of the current state here: [https://mellon.org/media/filer\_public/0c/3e/0c3eee7d-4166-4ba6-a767-6b42e6a1c2a7/rosenthal-emulation-2015.pdf](https://mellon.org/media/filer_public/0c/3e/0c3eee7d-4166-4ba6-a767-6b42e6a1c2a7/rosenthal-emulation-2015.pdf)

## Bibliography

AIMS Work Group. 2012. AIMS Born-Digital Collections: An Inter-Institutional Model for Stewardship. \[cited 2016 Feb 17\], p.37. Available from: [http://www2.lib.virginia.edu/aims/whitepaper/AIMS\_final.pdf](http://www2.lib.virginia.edu/aims/whitepaper/AIMS_final.pdf)

Bearman, D. 1999. Realities and chimeras in digital preservation. D-lib magazine \[Internet\]. \[cited 2016 Feb 17\]; 5(4). Available from: [http://www.dlib.org/dlib/april99/bearman/04bearman.html](http://www.dlib.org/dlib/april99/bearman/04bearman.html)

Beech, William A.. 2015. Floppy Disk Formats, Standards and Geometry \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://www.nj7p.org/Computers/Disk%20Subsystems/floppies.html](http://www.nj7p.org/Computers/Disk%20Subsystems/floppies.html)

BitCurator \[Internet\].\[updated 2016 Jan 18\]. Bitcurator.net; \[cited 2016 Feb 19\]. Available from: [http://www.bitcurator.net/](http://www.bitcurator.net/)

Carrol L, Farr E, Hornsby P, Ranker B. 2011. A Comprehensive Approach to Born-Digital Archives. Archivaria \[Internet\] \[cited 2016 Feb 17\]; 72: 61-92. Available from: [http://pid.emory.edu/ark:/25593/cksgv](http://pid.emory.edu/ark:/25593/cksgv)

Capturing a Mac ROM Image \[Internet\].\[updated 2010 Mar 20\]. Emaculation.com; \[cited 2016 Feb 19\]. Available from: [http://www.emaculation.com/doku.php/capturing\_rom](http://www.emaculation.com/doku.php/capturing_rom)

Casad M, Rieger O. Y., Alexander D. 2015. Enduring Access to Rich Media Content: Understanding Use and Usability Requirements. D-Lib Magazine(21) 9. DOI: 10.1045/september2015-casad

Dietrich D. Emulation and Classification Documentation for PAFDAO Project. Available from: [http://hdl.handle.net/1813/41453](http://hdl.handle.net/1813/41453)

Dietrich D. and Adelstein F. 2015. Archival science, digital forensics, and new media art. Digital Investigation(14) Supplement 1. DOI: [http://dx.doi.org/10.1016/j.diin.2015.05.004](http://dx.doi.org/10.1016/j.diin.2015.05.004)

Encoding \[Internet\].\[updated 2006 Mar 07\]. Software Preservation Society Glossary; \[cited 2016 Feb 19\]. Available from: [http://www.softpres.org/glossary:encoding](http://www.softpres.org/glossary:encoding)

FTK Imager \[Internet\].\[updated 2010 Dec 17\]. Forensics Wiki; \[cited 2016 Feb 19\]. Available from: [http://www.forensicswiki.org/wiki/FTK\_Imager](http://www.forensicswiki.org/wiki/FTK_Imager)

Guttenbrunner M, von Suchodoletz D, Rechert K. 2012. Towards Practical Emulation Tools and Strategies \[White Paper\]. In: iPRES 2012 annual meeting, 2012 Oct 1-4; Toronto. [https://emulationws2012.files.wordpress.com/2012/10/emu-ws-intro-paper.pdf](https://emulationws2012.files.wordpress.com/2012/10/emu-ws-intro-paper.pdf)

Hedstrom M, Lee C, Olson J, Lampe C. 2006. “The Old Version Flickers More”: Digital Preservation from the User’s Perspective. The American Archivist \[Internet\]. \[cited 2016 Feb 19\]; 69(1):159-187. Available from: [http://www.ils.unc.edu/callee/dig-pres\_users-perspective.pdf](http://www.ils.unc.edu/callee/dig-pres_users-perspective.pdf)

IsoBuster \[Internet\].\[updated 2016\]. Smart Projects; \[cited 2016 Feb 19\]. Available from: [http://www.isobuster.com/](http://www.isobuster.com/)

Jeremy Blake Papers; MSS 217; Fales Library and Special Collections, New York University Libraries

Kay R. 2009. Emulation or Virtualization? Computerworld. \[cited 2016 Feb 18\]. Available from: [http://www.computerworld.com/article/2551154/virtualization/emulation-or-virtualization-.html](http://www.computerworld.com/article/2551154/virtualization/emulation-or-virtualization-.html)

Kim, Julia. “Researcher Interactions with Born-Digital: Out of the Frying Pan and INto the Reading Room.” SAA ERS blog. Society of American Archivists. Blog. \[cited 2016 March 23\]. Available from: [https://saaers.wordpress.com/](https://saaers.wordpress.com/)

Kim J, Mennerich D. forthcoming. Jeremy Blake’s Time-Based Paintings: A Case Study. Electronic Media Group, volume 4.

Konstantelos [http://radar.gsa.ac.uk/2806/1/pocos\_vol\_2\_final\_release%5B1%5D.pdf](http://radar.gsa.ac.uk/2806/1/pocos_vol_2_final_release%5B1%5D.pdf)

List of computer system emulators \[Internet\]. Wikipedia, The Free Encyclopedia; 2016 Jan 10 \[cited 2016 Feb 17\]. Available from: [https://en.wikipedia.org/wiki/List\_of\_computer\_system\_emulators](https://en.wikipedia.org/wiki/List_of_computer_system_emulators)

Magic number (programming) \[Internet\].\[updated 2016 Jan 10\]. Wikipedia; \[cited 2016 Feb 19\]. Available from: [https://en.wikipedia.org/wiki/Magic\_number\_%28programming%29](https://en.wikipedia.org/wiki/Magic_number_%28programming%29)

McKeehan M. 2016. Intellectual Property Rights Issues for Software Emulation: An Interview with Euan Cochrane, Zach Vowell, and Jessica Meyerson. The Signal: Digital Preservation \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://blogs.loc.gov/digitalpreservation/2016/01/intellectual-property-rights-issues-for-software-emulation-an-interview-with-euan-cochrane-zach-vowell-and-jessica-meyerson/](http://blogs.loc.gov/digitalpreservation/2016/01/intellectual-property-rights-issues-for-software-emulation-an-interview-with-euan-cochrane-zach-vowell-and-jessica-meyerson/)

Mennerich D, Kim J. 2015. Preserving Jeremy Blake’s Digital Art and Archives. Imaging Science & Technology \[Internet\]. \[cited 2016 Feb 18\]; Vol 1: 49-50. Available from: [http://ist.publisher.ingentaconnect.com/content/ist/ac/2015/00002015/00000001](http://ist.publisher.ingentaconnect.com/content/ist/ac/2015/00002015/00000001)

The National Archives. n.d. Download DROID: file format identification tool \[Internet\]. \[cited 2016 Feb 19\]. Available from:

QEMU: Creating a hard disk image \[Internet\].\[updated 2016 Feb 15\]. \[cited 2016 Feb 19\]. Available from: [https://wiki.archlinux.org/index.php/QEMU#Creating\_a\_hard\_disk\_image](https://wiki.archlinux.org/index.php/QEMU#Creating_a_hard_disk_image)

Rieger O, Murray T, Casad M, Alexander D, Dietrich D, Kovari J, Muller L, Paolillo M, Mericle DK. 2015. Preserving and Emulating Digital Art Objects \[Internet\]. \[cited 2016 Mar 23\]. Available from: [http://hdl.handle.net/1813/41368](http://hdl.handle.net/1813/41368)

Rhizome to Restore and Present Theresa Duncan CD-ROMs \[Internet\].\[updated 2014 Nov 18\]. Rhizome; \[cited 2016 Feb 19\]. Available from: [http://rhizome.org/editorial/2014/nov/18/announcing-theresa-duncan/](http://rhizome.org/editorial/2014/nov/18/announcing-theresa-duncan/)

Rechert K, Liebetraut T, Stobbe O, Valizada I, and Steinke T. 2015. Characterization of CD-ROMs for Emulation-based Access. In iPRES 2015.

Rechert, K. 2015a. Emulation as a Service as a Docker (Beta) \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://bw-fla.uni-freiburg.de/wordpress/?p=817](http://bw-fla.uni-freiburg.de/wordpress/?p=817)

Rechert, K. 2015b. Boot to Emulation — EaaS as a Local Option (Beta) \[Internet\]. \[cited 2016 Feb 19\]. Available from: [http://bw-fla.uni-freiburg.de/wordpress/?p=844](http://bw-fla.uni-freiburg.de/wordpress/?p=844)

Rechert K, Valizada I, von Suchodoletz D, Latocha J, “bwFLA – A Functional Approach to Digital Preservation”, PIK, 35 (4), De Gruyter. S. 259-267. DOI: 10.1515/pik-2012-0044

Robertson, A. 2015. The girl game archival project that’s rewriting geek history. The Verge \[Internet\]. \[cited on 2016 Feb 19\]. Available from: [http://www.theverge.com/2015/4/17/8436439/theresa-duncan-chop-suey-cd-rom-preservation](http://www.theverge.com/2015/4/17/8436439/theresa-duncan-chop-suey-cd-rom-preservation)

Rothenburg, J. 1999. Avoiding Technological Quicksand: Finding a Viable Technical Foundation for Digital Preservation. Council on Library and Information Resources \[Internet\]. \[cited 2016 Feb 19\]; 77. Available from: [http://www.clir.org/pubs/reports/rothenberg/pub77.pdf](http://www.clir.org/pubs/reports/rothenberg/pub77.pdf)

Rosenthal D S.H. Emulation and Virtualization as Preservation Strategies \[Internet\]. \[cited 2016 Feb 19\]: Available from: [http://mellon.org/Rosenthal-Emulation-2015/](http://mellon.org/Rosenthal-Emulation-2015/)

Setting up SheepShaver for Mac OS X \[Internet\].\[updated 2014 Feb 2\]. Emaculation.com; \[cited 2016 Feb 19\]. Available from: [http://www.emaculation.com/doku.php/sheepshaver\_mac\_os\_x\_setup](http://www.emaculation.com/doku.php/sheepshaver_mac_os_x_setup)

Software Preservation Society, Glossary, retrieved from [http://www.softpres.org/glossary:encoding](http://www.softpres.org/glossary:encoding)

Timothy Leary papers, Manuscripts and Archives Division, The New York Public Library
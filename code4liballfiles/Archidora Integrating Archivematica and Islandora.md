---
title: "Archidora: Integrating Archivematica and Islandora"
source: "https://journal.code4lib.org/articles/13150"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-02-05
created: 2025-01-10
description: "“Archidora” is shorthand for the publicly available integration between the open source software packages Archivematica and Islandora. Sponsored by the University of Saskatchewan Library, this integration enables the automated ingest into Archivematica of objects created in Islandora. This will allow institutions that use Islandora as a digital asset management system, particularly for digitized material, to [...]"
tags:
  - "clippings"
---
# Archidora: Integrating Archivematica and Islandora
Tim Hutchinson

“Archidora” is shorthand for the publicly available integration between the open source software packages Archivematica and Islandora. Sponsored by the University of Saskatchewan Library, this integration enables the automated ingest into Archivematica of objects created in Islandora. This will allow institutions that use Islandora as a digital asset management system, particularly for digitized material, to take advantage of Archivematica’s standards-based digital preservation functionality, without requiring staff doing digitization to interact with Archivematica. This paper outlines the basic functionality and workflow of archidora; provides an overview of the development process including challenges and lessons learned; and discusses related initiatives and possible future directions for development.

## Project background and institutional context

The University of Saskatchewan Library has a long and productive history of digitization projects, with the first “virtual exhibit” launched in 1995, and over 50 thematic projects, both institutional and consortial, completed since then. Until 2013, the University of Saskatchewan Archives and the Special Collections unit of the University of Saskatchewan Library were organizationally separate, but collaborated on projects and both received systems/IT support from the library. Starting in 2005, the University Archives moved to a home-grown database for digital projects, allowing us to more systematically create metadata records and store high resolution images. In the meantime, Special Collections had started using contentDM for various collections.

The initiation of the Saskatchewan History Online (SHO) project in 2011 allowed the University Library to move towards a more programmatic approach to digital initiatives. SHO, originally dubbed the Saskatchewan Multitype Digitization Initiative, was a three-year provincial project funded by Saskatchewan’s Ministry of Education – the government home of both the Provincial Library and the Multitype Library Board. The University of Saskatchewan Library was contracted to coordinate the project, with a committee of the Multitype Library Board, the Saskatchewan Digital Alliance (SDA), serving as an advisory body to the project.

SDA planning as well as discussions within the University Library helped identify digital preservation as an important component of the SHO project. For too long, our projects had produced extensive and unique digital content, but without any preservation plan or infrastructure beyond basic backups. A consultation with Artefactual Systems (lead developers for Archivematica) in January 2012 set the wheels in motion towards our selection of Archivematica as a preservation system to ultimately manage digital content from various sources and systems. In addition to Islandora, which was selected as the digital asset management system for the SHO project (and as a replacement for contentDM), we were also using DSpace for an institutional repository of electronic theses and dissertations. Of course, we also had material from many different digital projects (managed in legacy systems or as flat files) – not to mention born digital records. We thought that addressing the preservation of digitized material would be a good way to establish an infrastructure for digital preservation that could later be used for other systems like DSpace, as well as the more complex area of born digital records.

## Development process

The main development work on the Archivematica/Islandora integration was completed between 2013 and 2014, with additional enhancements and bug fixes since then. Overall, the project has moved much more slowly than anyone had anticipated – during the design, development, and deployment stages.

Discussions with Artefactual Systems started later in 2012, with design requirements partly informed by an Islandora Camp session that summer. The first quote was received in October 2012. However, this focused on Archivematica to Islandora workflow. Further discussion about requirements – especially the requirement to have this process be automated, with staff doing digitization not needing to interact with Archivematica – led to a more detailed project outline, and the clarification that development of Islandora would also be required. Artefactual took the lead on the project, coordinating with Discovery Garden, which would ultimately be the subcontractor for the development on the Islandora side. The complexities of the technical interactions between the two systems, clarifications relating to University of Saskatchewan workflows, and time constraints for all parties meant that a substantially revised quote did not arrive until May 2013. A contract was approved for work to take place between October 2013 and January 2014. Ultimately this main phase of work was completed in September 2014.

Testing during the first phase of development revealed some limitations in the archidora module, i.e. desired functionality which had not been considered. In particular, we wanted to add a configuration option to suppress Archivematica ingests for a given collection; to add better handling for compound objects and books; and to add the ability to delete OBJ datastreams (i.e. the master objects) in bulk. We undertook a separate contract with Discovery Garden, during fall 2014, to address this.

Since then, progress on moving into production has been slow, and we are now targeting early 2018 for this milestone. However, I am risking becoming the boy who cried wolf: I have declared that deployment was close at least a few times over the last couple years. There have been a number of factors contributing to this.

- Both Archivematica and Islandora are under active development, and have many moving parts. On a few occasions, a change to another part of the code, or even configuration changes, have led to regressions or unexpected behaviour. In some cases it has been difficult to quickly assess whether the source of the problem is in Islandora or Archivematica. And resolving one issue has sometimes surfaced others.
- Our lead in-house Islandora developer made some changes to the archidora module in order to allow recursive use of the drush script. There was an understable learning curve involved, and the usual competing priorities for time.
- In tying up loose ends on the Archivematica side, we did not initially formalize or schedule the work required. This work got done through a combination of goodwill on the part of Artefactual (especially for a few items out of scope of the original contract), and the University Library’s support contract with Artefactual. As a result, timelines were a lot longer than would have been the case with a paid contract.

## Design and functionality

In general terms, objects are first ingested into Islandora. These are added to a deposit in the Archivematica storage service. After each deposit is finalized (reaching a certain size or time limit), they are sent to the Archivematica dashboard to be processed, with an Archival Information Package (AIP) as the final output.

This schematic from Artefactual outlines the detailed workflow as initially developed. It remains largely accurate.

[![Figure 1](https://journal.code4lib.org/media/issue39/hutchinson/01.png)](https://journal.code4lib.org/media/issue39/hutchinson/01.png)

**Figure 1.** Islandora/Archivematica integration workflow, as originally designed \[[1](https://journal.code4lib.org/articles/#1note)\].

The Islandora/Archivematica integration was achieved through the development of an Islandora module called archidora; and through code changes to both the Archivematica dashboard and storage service. On the Archivematica side, a key component, which will facilitate integrations with other systems, was the development of a Sword API, part of the storage service’s REST API. The Sword API “allows 3rd party applications to automate the process of creating Transfers” (Sword API \[updated 2017\]).

The following walks through the basic configuration, and the workflow for an object starting with its ingest into Islandora.

***Configuration – Islandora***

Configure the archidora module in Islandora, with basic settings like storage service URL, username and API key. You can also configure the maximum size of the transfer and the length of time (maximum age) before the transfer will be finalized (the settings are labelled AIP but it’s really the deposit/transfer). After a transfer is finalized, no more objects will be added to it, and the processes on the Archivematica side can begin. Settings for the size and maximum age will largely depend on institutional workflows as well as server capacity (e.g. size of transfers that Archivematica can handle). Maximum size is likely more important, but the maximum age ensures that a transfer will not get abandoned if enough objects are not added to it. The cron time setting helps account for the ingest of compound objects, so that the XML file documenting the relationships between objects is ingested along with the objects.

[![Figure 1](https://journal.code4lib.org/media/issue39/hutchinson/02_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/02.png)

**Figure 2.** Archivematica integration configuration in Islandora

***Configuration – Archivematica***

In the storage service, add a location …

[![Figure 3](https://journal.code4lib.org/media/issue39/hutchinson/03_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/03.png)

**Figure 3.** Configuration of location for Fedora deposits in Archivematica storage service

… and a corresponding space for Fedora deposits

[![Figure 4](https://journal.code4lib.org/media/issue39/hutchinson/04_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/04.png)

**Figure 4.** Configuration of space for Fedora deposits in Archivematica storage service

The pipeline also needs to be configured as for any Archivematica deployment, but to ensure that transfers are approved automatically, the API username and key need to be populated.

[![Figure 5](https://journal.code4lib.org/media/issue39/hutchinson/05_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/05.png)

**Figure 5.** Configuration of pipeline in Archivematica storage service

You can also configure a post-store callback, so that Archivematica will update Islandora with information about objects that have been ingested and therefore can be deleted from Islandora. This generates a list in Islandora’s “manage” tab for the relevant collection for manual processing, with an interface allowing either individual or bulk deleting (see figure 18). Institutions may want to use this functionality to avoid redundant storage of the master digital objects, if the master no longer needs to be accessible in Islandora.

[![Figure 6](https://journal.code4lib.org/media/issue39/hutchinson/06_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/06.png)

**Figure 6.** Configuration of post-store callback in Archivematica storage service.

In Archivematica, it is important to make sure that the processing configuration is set up not to require any user intervention.

[![Figure 7](https://journal.code4lib.org/media/issue39/hutchinson/08_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/08.png)

**Figure 7.** Archivematica processing configuration

If your digitization workflow ensures that you’re already reliably creating preservation quality files, you may also want to disable certain default normalization rules. For example, if a tiff file is identified in the Format Policy Registry as a preservation format, Archivematica will still normalize it if a normalization rule is enabled for that format (which is the default for tiff files). This will result in both the original file and the normalized file being saved in the AIP.

The ability to disable a rule was added as part of archidora development, but an arguably more intuitive enhancement would be to automatically skip the normalization task if an object is already in a preservation format.

[![Figure 8](https://journal.code4lib.org/media/issue39/hutchinson/07_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/07.png)

**Figure 8.** Archivematica preservation planning entry

*Islandora workflow*

Now we’re ready to bring some objects into Islandora. If you use the zip importer, then it’s best to configure it to use the filename as the datastream label (e.g. Filename.tif rather than OBJ). If you use a generic datastream label, Archivematica will still be able to ingest the objects, but there may be microservices that return errors due to the lack of a file extension. In particular, ffmpeg has known issues.

[![Figure 9](https://journal.code4lib.org/media/issue39/hutchinson/09_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/09.png)

**Figure 9.** Configuration of Islandora’s zip importer

You can use any method to ingest objects into Islandora. Archivematica interacts with the Fedora repository, not the drupal frontend. There is also a drush script available to do batch transfers of objects already in Islandora.

For this example, we have a small collection of three tiff files.  
[![Figure 10](https://journal.code4lib.org/media/issue39/hutchinson/10_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/10.png)

**Figure 10.** Objects ingested into Islandora.

*Archivematica workflow*

On the Archivematica side, the deposit initiated in Islandora is first sent to the storage service. Initially the Islandora METS files are saved, and Archivematica fetches the corresponding objects and MODS files.

[![Figure 11](https://journal.code4lib.org/media/issue39/hutchinson/11_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/11.png)

**Figure 11.** Downloaded Fedora deposit, showing submissionDocumentation folder.

The objects are saved in separate subdirectories. This covers situations where there may be duplicate filenames in the same transfer – especially the “OBJ” naming mentioned earlier.

[![Figure 12](https://journal.code4lib.org/media/issue39/hutchinson/12_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/12.png)

**Figure 12.** Downloaded Fedora deposit, showing top level.

[![Figure 13](https://journal.code4lib.org/media/issue39/hutchinson/13_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/13.png)

**Figure 13.** Downloaded Fedora deposit, showing one object subfolder.

Once the deposit is finalized (following one or more cron calls in Islandora), a transfer is initiated on the Archivematica dashboard. There is an automation tool available to automatically remove successfully completed transfers and ingests from the dashboard.  The transfer name is automatically generated from the MODS title (using the first record, if there are multiple objects in the deposit); where needed it will be sanitized to deal with spaces, diacritics, etc.

[![Figure 14](https://journal.code4lib.org/media/issue39/hutchinson/14_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/14.png)

**Figure 14.** Archivematica dashboard, showing transfers in progress.

Completed AIPs can be browsed and searched on the archival storage tab. In addition to the usual search functionality, you can search for an Islandora PID (e.g. islandora:1234) via the identifiers field. The full MODS is not indexed, since it’s assumed users will do any detailed searching in Islandora.

[![Figure 15](https://journal.code4lib.org/media/issue39/hutchinson/15_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/15.png)

**Figure 15.** Archivematica dashboard, archival storage tab

The AIP structure mirrors that of the deposit.

[![Figure 16](https://journal.code4lib.org/media/issue39/hutchinson/16_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/16.png)

**Figure 16.** Downloaded AIP, showing objects folder.

*Islandora troubleshooting and follow-up*

Back in Islandora, the Manage | Archivematica tab provides information about the status of individual objects. You can also use the “Send to Archivematica” button to initiate a new deposit. This is useful for testing, but would also be required in the case of a failed transfer or if an object in an existing record is replaced (Archivematica will only fetch new objects).

[![Figure 17](https://journal.code4lib.org/media/issue39/hutchinson/17_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/17.png)

**Figure 17.** Islandora administrator interface, showing manage | Archivematica tab

Log reports are also available under Reports | Recent log reports. These are primarily useful in the case of a failed deposit.

At the collection level (or compound object/book level), the Manage | Archivematica tab provides an interface for deleting objects that have been ingested by Archivematica, if the callback is configured.

[![Figure 18](https://journal.code4lib.org/media/issue39/hutchinson/18_small.png)](https://journal.code4lib.org/media/issue39/hutchinson/18.png)

**Figure 18.** Islandora administrator interface, showing manage | Archivematica tab at the collection level

## Challenges and Lessons Learned

### Planning

While code regressions and limitations on people’s time (as outlined above) are hard to avoid, a key lesson learned is that the design requirements should have been much clearer from the outset. Indeed, the initial requirements were developed by Artefactual and Discovery Garden following a series of e-mails and meetings; the University Library did not submit any formal documentation. This lack of concrete direction contributed to the false start we experienced, with a quote for an integration assuming workflow would start in Archivematica. Further, at the outset of the project, we had only recently adopted Islandora; and as project lead I had very little hands-on experience with Islandora before we started to do quality assurance, let alone during the development of requirements. For example, we missed some simple things, such as object naming conventions for the default batch import routine (resulting in duplicate filenames), or detailing how different object types (e.g. compound objects) should be handled. Since this development work was part of the SHO project, it was not actually managed within the library as a separate project, which might have helped mitigate some of these planning shortfalls.

### Sustainability

An ongoing challenge relates to ongoing maintenance and sustainability of the code. This initially resulted from a lack of understanding about the different development models for Archivematica (maintained by Artefactual Systems) and Islandora. Artefactual Systems is the “lead developer” of Archivematica. As such, any development work done for clients is pursued with open source release, and more general utility, in mind. As Artefactual describes on its website:

“… although we may develop new features for you, we will not be creating a custom application that will need to be maintained by your organization. Instead, we will incorporate the new customizations into later releases of the software and support them independently of your organization so that others can benefit from them” (Artefactual Systems – Services – Development). The development relating to the Archivematica/Islandora integration has been incorporated into the most recent public releases of Archivematica, and is stable as of Archivematica 1.6.1 and Storage Service 0.10.0.

My experience had been with AtoM, the other software package maintained by Artefactual Systems. So I had mistakenly assumed that the development model for Islandora, and the approach of Discovery Garden, would be similar. Indeed, we incorporated language in the development contract with Artefactual to allow both companies to publish the code under their respective open source licenses. (The university’s contract was with Artefactual, which subcontracted with Discovery Garden for the work on the Islandora module.)

Contrary to Archivematica, Islandora’s code is owned by the Islandora Foundation. During the process of arranging for the necessary approvals to transfer the archidora module to the Foundation, we discovered one stumbling block: the lack of a volunteer component manager to shepherd its incorporation into the Islandora code base \[[2](https://journal.code4lib.org/articles/#2note)\]. Since the development had been contracted out, we were not in a position to identify an in-house component manager. Islandora guru Mark Jordan (Simon Fraser University) kindly volunteered for that role. However, a more important barrier was that the development of the module had not been done with general release initially in mind. The Islandora Foundation has accepted the module, but it is currently being hosted at Islandora Labs, and will require further development and testing to be considered for the core release (Archidora module \[updated 2015\]). Until this module is deployed by a broader sector of the Islandora community and is ready for incorporation into the general release, it will essentially be a customization that the University of Saskatchewan needs to maintain.

## Future development opportunities

There are a number of possible improvements to the Archivematica/Islandora integration. I will discuss just a few here. Artefactual Systems’ lead Archivematica developer mentioned several other possibilities in his Open Repositories 2015 talk (Simpson, 2015).

### A two-way street

While this not a use case currently important for the University of Saskatchewan, there has been a lot of interest expressed in integration of Archivematica and Islandora in the opposite direction. That is, ingest of objects first into Archivematica, which would generate the packages required for either automated or manual upload to Islandora – similar to the integrations for AtoM and contentDM, described above. This is of interest especially for institutions that are using Islandora as the access system for both digitized and born-digital material. Mark Jordan’s presentation at Islandora Camp in 2012 described both use cases, and sketched out preliminary development strategies (Jordan, 2012).

A few institutions have reported on local customizations and experimentation. For example, Michigan State University (MSU) Libraries transformed the METS file from Archivematica into a version for ingest into Fedora (Collie and Mak, 2013). A poster presentation also by MSU (Collie, Higgins, Mak and Nicholson, 2014) further makes the case for Islandora/Archivematica integration, by highlighting elements of the NDSA Levels of Preservation (National Digital Stewardship Alliance, 2013) that each system addresses.

More recently, a couple threads in the Islandora Google Group have captured interest on working on the Archivematica to Islandora integration, and reported on on possible development approaches. As outlined by Mark Jordan, “Islandora is ready for this, via the Islandora REST module. The work required to have Archivematica produce DIPs for public access in Islandora needs to be done on the Archivematica side” \[[3](https://journal.code4lib.org/articles/#3note)\].

The Zuse Institute Berlin may have taken the Archivematica to Islandora integration the furthest, reporting at iPres 2015 on an implementation involving Archivematica, Fedora/Islandora, and iRODS (Klindt and Amrhein, 2015). This code does not appear to be publicly available at this time.

There is also potential for integration between Archivematica and Fedora, rather than Islandora per se. Indeed, the current integration is primarily between the Archivematica storage service and the Fedora repository, even though this is achieved through an Islandora module. Storage of AIPs in a Fedora repository is one area of interest; this has been achieved, for example, at the Universities of York and Hull as part of an ongoing research data project (Mitcham et al, 2016).

### Integration of Islandora metadata

The MODS files are saved in the AIP as part of submissionDocumentation; and at least for images, MODS and DC metadata become part of the Archivematica METS file via EXIF tool output. But this descriptive metadata is not fully searchable, and the dmdSec section of the Archivematica METS file is not populated, as it would be for imported metadata (Archivematica documentation: Import metadata). This kind of integration was not a priority for our initial development; we assume that most searching will take place in Islandora, with the Islandora PID sufficient to pull the master object from Archivematica. However, adding more integrated metadata would introduce possibilities for richer integration with other systems, for example for dissemination information packages (DIPs) generated for AtoM or other access systems.

There is also potential to take greater advantage of Islandora’s available digital preservation functionality. The Islandora PREMIS module provides the capability to generate XML and HTML representations of PREMIS data in Islandora, currently including fixity checks, agent information, and rights metadata from the descriptive record \[[4](https://journal.code4lib.org/articles/#4note)\]. This module was not on our radar during the initial development of archidora, and we have not currently implemented it. Clearly, however, there would be advantages to including Islandora’s PREMIS data in the packages generated by Archivematica. At least part of the PREMIS output from Islandora – fixity information – is currently included in the Fedora METS file. Development would likely be needed to configure how this data is included in the Archivematica METS file, or to pull in the full PREMIS XML file from Islandora.

### Re-ingesting objects/AIPS

Currently, the Archivematica process is only triggered for new – not updated – objects in Islandora. Arguably a new AIP should be created if digital objects are replaced; decisions about what extent of changes to metadata warrant a new AIP are more challenging \[[5](https://journal.code4lib.org/articles/#5note)\]. A manual process is available, through the “add to Archivematica” button, but this is obviously subject to user error. Another potential downside to this manual process is that this creates an AIP with just that object, rather than the larger AIPs generated as part of normal workflow; and this option is not available at the book or compound object level. For larger sets of objects needing re-ingest, the drush script would be another option, but this also currently needs to be run manually.

## Conclusion

The Archivematica/Islandora integration adds to a growing set of integrations between Archivematica and other digital preservation, access and repository software packages, including AtoM, contentDM, DSpace, ArchivesSpace (Eckard, Pillen and Shallcross, 2017), and LOCKSS. Responding to a suggestion that Archivematica and Islandora might be competing for the same users, then Artefactual President Peter van Garderen tweeted, “We don’t compete, we integrate” (van Garderen, 2012). An Artefactual analyst elabourated on this philosophy in her talk at Open Repositories 2015, focusing on endpoints and handoffs from source systems (Mumma, 2015). While Islandora has some digital preservation functionality, our preference is to use a system with digital preservation as a specialization, and take advantage of Islandora’s specialization as an access and digital asset management system. Since Islandora is actively used by multiple users, Archivematica also provides a better option for reliable preservation of the master objects. Ultimately, as described in the background section, other systems and sources will feed into Archivematica, so that we are not managing preservation in multiple systems.

We are always glad to hear about interest in adopting and developing archidora \[[6](https://journal.code4lib.org/articles/#6note)\]. Over time, we are hopeful that wider adoption will result in archidora (in both Archivematica and Islandora) achieving a status as community owned and maintained software, integrating Archivematica and Islandora with workflows in both directions.

## References

Archidora module, Islandora Labs \[Internet\]. \[Updated (last commit) 2015 March 2\]. GitHub \[Cited 2017 October 23\]. Available from: [https://github.com/Islandora-Labs/archidora](https://github.com/Islandora-Labs/archidora)

Archivematica documentation: Import metadata \[Internet\]. Artefactual Systems: Archivematica documentation, version 1.6 \[cited 2017 October 19\]. Available from: [https://www.archivematica.org/en/docs/archivematica-1.6/user-manual/transfer/import-metadata/](https://www.archivematica.org/en/docs/archivematica-1.6/user-manual/transfer/import-metadata/)

Artefactual Systems – Services – Development \[Internet\]. Artefactual Systems website \[Cited 2017 October 23\]. Available from: [https://www.artefactual.com/services/development/](https://www.artefactual.com/services/development/)

Collie A, Higgins D, Mak L, Nicholson S. 2014. Furthering the community: integrating Archivematica and Islandora \[Internet\]. Library Information and Technology Association (poster presentation), January 2014. \[Cited 2017 October 18\]. Available from: [https://figshare.com/articles/Furthering\_the\_community\_integrating\_Archivematica\_and\_Islandora/899883](https://figshare.com/articles/Furthering_the_community_integrating_Archivematica_and_Islandora/899883)

Collie A, Mak L. 2013. Incompatible or Interoperable? A METS bridge for a small gap between two digital preservation software packages \[Internet\]. ALCTS Metadata Interest Group, ALA Midwinter Meeting; Seattle, Washington: 2013 January 27. \[Cited 2017 October 18\]. Available from: [http://connect.ala.org/node/199172](http://connect.ala.org/node/199172)

Eckard M, Pillen D, Shallcross M. 2017. Bridging Technologies to Efficiently Arrange and Describe Digital Archives: the Bentley Historical Library’s ArchivesSpace-Archivematica-DSpace Workflow Integration Project. Code4Lib Journal \[Internet\]; Issue 35 (2017 January 30). \[Cited 2017 October 25\]. Available from: [http://journal.code4lib.org/articles/12105](https://journal.code4lib.org/articles/12105)

Jordan M. 2012. Integrating Islandora and Archivematica \[Internet\]. Charlottetown, Canada: Islandora Camp, 2012 August 2. \[Cited 2017 October 18\]. Available from: [http://summit.sfu.ca/item/10873](http://summit.sfu.ca/item/10873)

Klindt M, Amrhein K. 2015. One Core Preservation System for All Your Data – No Exceptions! Proceedings of the 12th International Conference on Digital Preservation, Chapel Hill, North Carolina, 2015 November 2-6 \[Internet\]. \[Cited 2017 October 25\]. Available from: [https://phaidra.univie.ac.at/detail\_object/o:429551](https://phaidra.univie.ac.at/detail_object/o:429551)

Mitcham J, Awre C, Allinson J, Green R, Wilson S. 2016. Filling the Digital Preservation Gap: A Jisc Research Data Spring project; Phase Three report \[Internet\], 2016 October. \[Cited 2017 October 25\]. Available from: [https://dx.doi.org/10.6084/m9.figshare.4040787](https://dx.doi.org/10.6084/m9.figshare.4040787)

Mumma C. 2015. Archivematica: Handshaking towards comprehensive digital preservation workflows. OR2015: 10th International Conference on Open Repositories, Indianapolis, Indiana, 2015 June 9 \[Internet\]; \[Cited 2017 October 25\]. Available from: [http://program.or2015.net/mumma-archivematica\_integration-174\_a.pdf](http://program.or2015.net/mumma-archivematica_integration-174_a.pdf)

National Digital Stewardship Alliance, NDSA Levels of Preservation, version 1 (2013?) \[Internet\]. \[Cited 2017 October 18\]. Available from: [http://www.digitalpreservation.gov:8081/ndsa/activities/levels.html](http://www.digitalpreservation.gov:8081/ndsa/activities/levels.html)

Simpson J. 2015. Archidora: Leveraging Archivematica preservation services with an Islandora front-end \[Internet\]. OR2015: 10th International Conference on Open Repositories, Indianapolis, Indiana, 2015 June 9. \[Cited 2017 October 23\]. Available from: [http://program.or2015.net/simpson-archidora-229.pdf](http://program.or2015.net/simpson-archidora-229.pdf)

Sword API \[Internet\]. \[Updated 2017 March 23\]. Artefactual Systems: Archivematica wiki \[Cited 2017 October 25\]. Available from: [https://wiki.archivematica.org/Sword\_API](https://wiki.archivematica.org/Sword_API)

van Garderen P. 2012 April 25 \[Internet\]. Twitter \[Cited 2017 October 25\]. Available from: [https://twitter.com/pjvangarderen/status/195206083806113792](https://twitter.com/pjvangarderen/status/195206083806113792)

## Notes

\[[1](https://journal.code4lib.org/articles/#1ref)\] From Improvements/Islandora \[Internet\]. \[Updated 2016 March 17\]. Artefactual Systems: Archivematica wiki \[Cited 2017 October 20\]. Available from: [https://wiki.archivematica.org/Improvements/Islandora](https://wiki.archivematica.org/Improvements/Islandora). Further technical documentation is also available on this page. A key difference between the schematic and the functionality as it now exists is that the post-store call back prompts Archivematica to list the object(s) in the AIP as ready to be deleted, but this is not done automatically; rather, the objects can be selected for individual or bulk deletion in the manage tab of the relevant collection/book/compound object.

\[[2](https://journal.code4lib.org/articles/#2ref)\] The Islandora Foundation Licensed Software Acceptance Procedure \[Cited 2017 October 23; available from: [http://islandora.ca/developers/lsap](http://islandora.ca/developers/lsap)) appears to have been fleshed out since our contribution of archidora. An archived version of the page dated March 2015 ([https://web.archive.org/web/20150316194238/http://islandora.ca/developers/lsap](https://web.archive.org/web/20150316194238/http://islandora.ca/developers/lsap)) does not include a reference to the component manager requirement. That element had been added by September 2015, with a more thorough revision as recently as March 2017.

\[[3](https://journal.code4lib.org/articles/#3ref)\] Islandora and Archivematica \[Internet\]. Islandora users group, 2017 August 16 \[Cited 2017 October 23\]. Available from: [https://groups.google.com/d/msg/islandora/5Qxsz3Vwbvw/OGNos7lkAgAJ](https://groups.google.com/d/msg/islandora/5Qxsz3Vwbvw/OGNos7lkAgAJ). See also AIP, DIP, SIP generation \[Internet\], Islandora users group, 2017 August 30 \[Cited 2017 October 23\]. Available from: https://groups.google.com/d/topic/islandora/W7Uee1Wb0v4/discussion

\[[4](https://journal.code4lib.org/articles/#4ref)\] Islandora PREMIS \[Internet\]. GitHub \[cited 2017 October 19\]. Available from: [https://github.com/Islandora/islandora\_premis](https://github.com/Islandora/islandora_premis). For more details and discussion of future directions, see Jordan M., McLellan E., PREMIS in Open-Source Software: Islandora and Archivematica. In: Dappert A., Guenther R., Peyrard S. (eds) Digital Preservation Metadata for Practitioners \[Internet\]. Springer, Cham, 2016 \[Cited: 2017 October 18\]. Available from: [https://doi.org/10.1007/978-3-319-43763-7\_16](https://doi.org/10.1007/978-3-319-43763-7_16)

\[[5](https://journal.code4lib.org/articles/#5ref)\] A presentation at Access 2017 outlined some of these issues, notably the fact that objects can be saved multiple times as part of a single ingest. See Weiwei Shi, Shane Murnaghan, and Matt Barnett, The way leads to PushMi-Pullyu, a lightweight approach to managing content flow for repository preservation at UofA Libraries \[Internet\], Saskatoon, Canada: Access 2017, 2017 September 28, \[cited 2017 October 19\]. Available from: [https://drive.google.com/file/d/0B8b5FXYBN\_3\_TWs0Um1NMlN1VU1iUzRVcUdUQTQxeUpYVHBR/view](https://drive.google.com/file/d/0B8b5FXYBN_3_TWs0Um1NMlN1VU1iUzRVcUdUQTQxeUpYVHBR/view)

\[[6](https://journal.code4lib.org/articles/#6ref)\] Beyond some informal inquiries, we are aware of archidora’s use in testing workflows for research data. See Research Data Canada, RDC Federated Pilot for Data Ingest and Preservation, 2015 January 9 \[Internet\]. \[Cited 2017 October 25\]. Available from: [https://www.rdc-drc.ca/the-rdc-federated-pilot-for-data-ingest-and-preservation/](https://www.rdc-drc.ca/the-rdc-federated-pilot-for-data-ingest-and-preservation/)

## About the author

Tim Hutchinson has been an archivist at the University of Saskatchewan since 1997. He was appointed as University Archivist in 2004, and as Head of University Archives & Special Collections in 2013 (he is currently on sabbatical); and has been active in a range of activities and developments in the areas of digital archives and preservation, digitization, archival descriptive standards, and technology for archives more generally.
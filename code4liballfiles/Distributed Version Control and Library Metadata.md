---
title: "Distributed Version Control and Library Metadata"
source: "https://journal.code4lib.org/articles/86"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-06-23
created: 2025-01-10
description: "Distributed version control systems (DVCSs) are effective tools for managing source code and other artifacts produced by software projects with multiple contributors. This article describes DVCSs and compares them with traditional centralized version control systems, then describes extending the DVCS model to improve the exchange of library metadata."
tags:
  - "clippings"
---
# Distributed Version Control and Library Metadata
Galen M. Charlton

Distributed version control systems (DVCSs) are effective tools for managing source code and other artifacts produced by software projects with multiple contributors. This article describes DVCSs and compares them with traditional centralized version control systems, then describes extending the DVCS model to improve the exchange of library metadata.

## Introduction

Libraries have a long history of sharing their metadata, from the distribution of catalog cards by the Library of Congress (LC) to the development of MARC to the sharing of records via bibliographic record services such as OCLC. However, the flow of bibliographic information is usually top-down. To give a U.S.-centric example, a book may be catalogued by LC or a BIBCO library \[[1](https://journal.code4lib.org/articles/#note1)\], contributed to OCLC, perhaps updated by a few catalogers in OCLC (but only if they have the privilege to do so), and then downloaded into an individual library’s ILS or integrated library *silo*. From there, the record may be sent out for authority control (drawing from a central headings database maintained by the vendor) and edited by a library cataloger. Next, the cataloger may improve the local copy of the record by adding a table of contents or better subject headings.

However, the improved record can then languish in an individual library’s ILS. It often takes a special effort to contribute a revised record back to a bibliographic utility’s database; contributing an entirely new record may be easy, but making a change to an existing record is often less so. If the library runs an open Z39.50 server, a few other libraries may download the record, but most libraries will not see the improvement. Even if the record is improved in OCLC’s database, that improvement may not make its way down to other local catalogs as individual libraries may not subscribe to OCLC’s change notification service or may not have the tools with which to load the improvement without losing their local changes.

Software development projects, particularly ones with a large number of contributors, have similar issues. A programmer will usually work on a local copy of a project’s source code. Once she has completed a new feature or bugfix, the change has to get back into the main project, and the programmer has to be able to retrieve the work that others did in the meantime. In a well-managed software project, this process is mediated by a version control system (or VCS). This article will describe a particular kind of VCS, namely a *distributed version control system* (or DVCS), give some examples of how a DVCS can be used in a software project, then propose how a DVCS can be used for the global, collective project of creating and maintaining library metadata.

## Version Control Systems

Broadly speaking, a version control system keeps track of a set of objects and the history of changes to these objects. In the case of a software project, the objects are typically files containing source code, testing scripts, documentation, external software libraries, and so on.

A traditional version control system such as CVS or its inheritor Subversion is based on a central repository. If you want to work on a project that uses CVS, you must gain access to the repository and identify the current version of the files maintained in that repository. You then check out the files of interest into a local working directory and start hacking away.

Once you’ve completed your changes, you must *commit* or check the revised files back into the CVS repository for the change to be recorded. CVS keeps a log of all of the history of changes and lets you generate *diffs* (comparisons of different versions of a file), retrieve older versions, or undo changes.

However, once you start adding more programmers, the workflow can get more complicated. If two programmers need to work on the same file, several things can happen. With some version control systems, a programmer can get an exclusive lock on a file, forcing other developers to wait for the first programmer to finish a change and unlock the file before they can commit their work. CVS supports file locks, but by default it will not use locks. Instead, if two developers try to commit a change to the same file, CVS will try to merge the second developer’s changes with the first changes. If the automatic merge fails, it will require the second developer to manually fix the conflicts.

But where two or more programmers gather, a quality control process necessarily arises. For a large project with multiple developers, having a central repository means that whatever gets committed in the main line really ought to work, or at least not break the build. In practice, for a large open source project, two classes of programmers emerge – *committers* who are considered trustworthy enough to be given rights to commit their changes directly to the repository and everybody else. A non-committer who wants to contribute typically submits *patches* or diffs representing their changes to the committers or project mailing list. If the change is good, a committer commits it. Send enough good patches, and a non-committer can be granted the keys to the kingdom and become a committer.

Thus, a traditional, centralized version control system by its very nature encourages certain restrictions on the *social* aspects of programming. While peer review of some kind is necessarily a part of quality software development process, forcing the existence of a class of committers can sometimes lead to problems. If a project has a small number of committers, there can be a bottleneck in pushing up work done by other contributors. Sometimes the wrong person is promoted to committer status; sometimes good programmers are passed over for bad reasons; occasionally disputes about commit access lead to the foundering or forking of an open source project.

The notion of commit access is similar to certain kinds of gatekeeping involving library metadata. For example, while any full OCLC member can always add a new record or add various fields to a master record if not already present \[[2](https://journal.code4lib.org/articles/#note2)\], fixing a mistake in a record originally contributed by LC is generally not possible; instead a library must submit a request to have a record corrected. To be able to directly correct various MARC fields in a master record in OCLC, a library must qualify for OCLC Enhance or CONSER status \[[3](https://journal.code4lib.org/articles/#note3)\]. To be able to contribute authority records directly to LC’s authority file, NACO or SACO status \[[4](https://journal.code4lib.org/articles/#note4)\] is required. An unprivileged cataloger will sometimes decide that it is quicker to create a new, duplicate record in the OCLC database than to edit an existing record. While this practice is not recommended, the relatively centralized and hierarchical approach to metadata quality control leads to this temptation.

## Distributed Version Control Systems

A distributed version control system, such as darcs, Git, Mercurial, or Bazaar \[[5](https://journal.code4lib.org/articles/#note5)\], does not depend on a central repository of changes. Instead, each contributor has her own repository, into which she will commit her changes. When she is ready to share her work, other contributors can *pull* changes from her repository or she can *push* changes to another’s repository or send patch files generated from her repository.

To give a concrete and somewhat simplified example of what the workflow might look like, consider the Koha ILS project, which uses Git for version control \[[6](https://journal.code4lib.org/articles/#note6)\]. To start contributing, a programmer (or web designer, or documenter, or user) would clone the Koha Git repository. Assuming that she is working from a Unix shell and has Git installed, this would be accomplished by:

`$ git clone git://git.koha.org/pub/scm/koha.git koha`

This will create a new, *local* Git repository in the koha subdirectory that contains a copy of the public Git repository for Koha (located at git://git.koha.org/pub/scm/koha.git). From there, she can change to the koha directory, run the Koha installation process if necessary, and start hacking away.

`$ cd koha   $ $INSERT_FAVORITE_EDITOR_HERE this_and_that   `

Once some work is ready to check in, she can commit it like this:

`$ git add a_new_file   # tell git about a new or updated file   $ git commit -a        # tell git to commit all updated files   `

Upon running git commit, the programmer will be prompted to enter a commit message describing the changes. The changes are saved in the programmer’s *local* Git repository; unless she chooses to share her repository with others, nobody else can see them yet.

For certain situations, that could be all there is to the workflow – a distributed version control system can be used to easily copy the revision history of a software project and then simply manage local changes. This would be analogous to the common copy cataloging practice of downloading bibliographic records from a provider and making changes in the local ILS without contributing the changes back to a central system.

However, to stay in sync with changes made by others, the programmer could periodically bring in changes that were added to the central repository from which she originally cloned from the project. In Git, this might be done like this:

`$ git pull`

or

`$ git fetch   $ git rebase origin`

Either command will query the source repository for changes made since the last clone or fetch and *merge* those changes with the local work done by the contributor.

A merge is a very important operation in a version control system and one that a DVCS in particular needs to do efficiently and intelligently as possible. For example, suppose the programmer commits a change to an (imaginary) file in the Koha project called `adams.pl`. When the programmer pulls the latest changes from the public repository, if one of those changes also involves adams.pl, Git will attempt to combine both the local changes and the remote changes. For source code files, this is normally done via a *three-way merge*.

A three-way merge works like this. Let’s call the version of adams.pl at the time that the programmer made her clone `adams.pl<sup>orig</sup>`. Let’s call the version after she commits her change `adams.pl<sup>A</sup>`, and the version committed by somebody else and pushed to the public repository `adams.pl<sup>B</sup>`.

| `adams.pl<sup>orig</sup>` | `adams.pl<sup>A</sup>` | `adams.pl<sup>B</sup>` |
| --- | --- | --- |
| `#!/usr/bin/perl -w`  `# Answer a question.   # What question?   # What else?`  `print "41\n";   ` | `#!/usr/bin/perl -w`  `# Answer a question.   # What question?   # What else?`  `print "42\n";   ` | `#!/usr/bin/perl -w`  `use strict;`  `# Answer a question.   # What question?   # What else?`  `print "41\n";` |

The merge process considers the differences between the original ancestor version and the two variations:

| `adams.pl<sup>orig</sup> to adams.pl<sup>A</sup>` | `adams.pl<sup>orig</sup> to adams.pl<sup>B</sup>` |
| --- | --- |
| `diff --git   a/adams.pl b/adams.pl   index   59446bb..0392661 100644   ---   a/adams.pl   +++   b/adams.pl   @@ -4,4   +4,4 @@    # What question?    # What else?`  `-print   "41\n";   +print   "42\n";   ` | `diff --git   a/adams.pl b/adams.pl   index   59446bb..6784430 100644   ---   a/adams.pl   +++   b/adams.pl   @@ -1,5   +1,7 @@   #!/usr/bin/perl -w`+use strict;   +  `   # Answer a question.    # What question?    # What else?    ` |

After applying the programmer's change (`adams.pl<sup>A</sup>`) and the remote change (`adams.pl<sup>B</sup>`), the end result will be a merged version, automatically made both strict and accurate:

`#!/usr/bin/perl -w`

`use strict;`

`# Answer a question.   # What question?   # What else?`

`print "42\n";`

Most DVCSs will try to resolve merges automatically, but in some cases, a merge conflict may arise which the programmer must then resolve manually. For example, if `adams.pl<sup>B</sup>` had also changed the answer to "43", a three-way merge would not be able to automatically determine if "42" or "43" was correct and would leave it to the programmer to tell Git what the correct result should be.

The programmer is not restricted to pulling changes from the repository she originally cloned from - she can pull from the repository of any other Koha developer who makes it publicly available. For example, if someone else is working on an automatic Library Police dispatch feature for Koha, the programmer could pull from that repository to get a sneak peek at the changes:

`$ git pull git://git.librarypolice.com/pub/scm/koha.git`

Conversely, others could pull changes from her repository. To go further and submit her changes to the public repository so that they are added to the public or consensus version of Koha, she could tell Git to prepare and e-mail patch files.

`$ git format-patch origin   $ git send-email *.patch`

These two commands generate a set of patch files, then email them to an address specified interactively - in this case, to the Koha patches list, or to another Koha developer for a review. If, after the Koha QA and release managers review and approve the patch, nobody in the Koha developer community objects, it will generally be pushed to the public repository and thus made available for others to download.

## Advantages of distributed version control systems

The fact that each DVCS repository can store the complete history of a project provides several advantages. These advantages include independence for local developers (while still maintaining a relationship with the larger project), a distributed backup of the central project, and de-centralized management of user permissions.

First, each developer can work independently without having to rely on constant network access to a central repository. If a programmer is working on a large feature, she can control how and when to merge changes made in the central repository in the meantime into her local repository. If the feature is speculative, she can make her local repository public and ask other contributors to look at her work. If the feature concerns a distinct module of the central project, she can readily use her local repository to create a subproject, pulling changes from the repositories of other developers working on the subproject. Once the subproject is in a completed state, she can then ask the maintainer of the central repository to pull in all of the changes related to the subproject.

Second, each programmer's repository is effectively part of a distributed backup network for the project as a whole. If the public repository is lost, all of the changes can be recovered from the local repositories of the active contributors.

Finally, decisions about who to give commit access to a single central repository can be mostly avoided. Of course, the decisions about which patches to accept into the public repository cannot be avoided, but this applies to any software project. Every contributor has commit access to her own local repository, and submits changes to the consensus repository or to the maintainer of one of the project's modules. The maintainers of the consensus version can focus on whether particular changes are generally useful instead of who qualifies for committer status. If the programmer's work is of only limited or local interest, she can still continue to maintain her local changes while tracking the public changes.

Distribution of version control does not necessarily mean fragmentation of a project. The Linux kernel project, for which Linus Torvalds originally wrote Git, consists of a wide-variety of subprojects (e.g., the networking subsystem), many of which are run semi-independently of one another. Whenever a subproject is ready, its manager will ask Linus to pull from their integration repository to his own repository, which is one of the primary repositories that is considered a canonical source of Linux. The distribution of the repositories mirrors the distribution of responsibility and trust - a driver patch by a new kernel hacker does not have to be personally vetted by Linus, but instead can be checked by the person or group maintaining the affected subsystem \[[7](https://journal.code4lib.org/articles/#note7)\].

## Distributed version control and library metadata

Use of a DVCS is a valuable tool for many software projects and could also be a valuable tool to support the exchange of library metadata. At the moment, library metadata practice is in a state of flux. In addition to the development of a new content standard for bibliographic metadata, several trends are encouraging the decentralization of metadata creation and maintenance.

For example, if the Library of Congress follows the recommendations of the Working Group on the Future of Bibliographic Control, it would seem to be on a course to reduce its role in the production of original cataloging for English language monographs and has already ceased creating new series authority records \[[8](https://journal.code4lib.org/articles/#note8)\]. That will leave a gap to be picked up by somebody, and in the absence of proven techniques for automatically creating bibliographic metadata or repurposing publisher metadata, it will put pressure on library cataloging departments to produce more original cataloging. Most ILSs currently maintain separate silos of bibliographic data, including original cataloging, but not all libraries participate in central bibliographic utilities.

On the other hand, some centralizing projects to eliminate ILS metadata silos are underway, including OCLC's development of WorldCat Local \[[9](https://journal.code4lib.org/articles/#note9)\] and the Internet Archive's Open Library \[[10](https://journal.code4lib.org/articles/#note10)\]. Both projects offer models for sharing metadata from big centralized databases, but it is an open question whether such projects can achieve complete coverage of all library materials and whether libraries can or should collectively tie their fortunes to a small number of central providers.

In a distributed model, libraries would continue to maintain separate repositories of their metadata. However, unlike most current ILSs, which may offer Z39.50 services but are not designed for the continual update of records and the transmission of improvements, each repository would be able to:

- Maintain a complete change history of each metadata record.
- Generate diffs and patches.
- Clone records from another repository.
- Pull changes from records in other selected repositories.
- Allow other repositories to pull changes.
- Perform the equivalent of three-way merges.

This approach assumes that there is a core set of records that multiple libraries are interested in and need to share changes. This approach also assumes that a record may change frequently. This is already the case under current MARC and AACR2-based practices. The first library to catalog an anthology may only create a minimal MARC record with basic descriptive cataloging. Another library may add a table of contents, another may add additional subject headings, and a third may fully analyze it. The introduction of ideas from FRBR will likely only increase the changes; if you are cataloging a new translation, you may not be able to identify the existing work that it is an expression of - it may take some time for the relationship to become apparent.

A workflow for copy-cataloging in a distributed environment might look like this:

- The cataloger selects and clones a record. If the item is an academic monograph, it might be cloned from the repository of the nearest university; if it is a DVD, it might be cloned from a public library.
- The cataloger makes a local change such as adding an acquisitions note.
- Periodically, the cataloger pulls changes from a table of contents provider.
- Periodically the library's local repository pulls changes from the original repository. For example, one day the record in question may get an additional subject heading contributed by another cataloger.
- The cataloger notices a typo and corrects it, then pushes the change back to the source repository.

A distributed model for maintaining version control of metadata and sharing changes would have several advantages:

- Economies of distribution could be better realized. Currently, a bibliographic record may initially lack a table of contents; before one is added to the version maintained by a bibliographic utility, a number of libraries may add one to their local copy without being able to readily contribute their improvement.
- A model that encourages periodically bringing in improvements while preserving local changes would improve the quality of metadata stored in each library's repository, and allow all libraries in the network to benefit from changes.
- Contributions from smaller cataloging departments could be more readily integrated into the bibliographic consensus.
- The DVCS platform could support the creation specialized repositories. For example, a consortium of libraries could set up a repository of records enriched by the addition of Spanish-language subject headings.
- Full change history for each bibliographic record would be available - a feature lacking from many ILSs.

There would also be some challenges:

- Issues surrounding the ownership of bibliographic records would need to be resolved. If we were to view library metadata as a shared, perhaps global, project the efficient exchange of records and patches would require that the exchange not be constrained by overly restrictive licensing terms. For example, if a library receives MARC 505 fields from a table of contents service, the terms of their agreement with the enhanced content provider may not allow them to redistribute the TOCs.
- Large central repositories would continue to serve a valuable function, acting as both primary loci for cloning records and as targets for large-scale data-mining and record improvement projects. However, those repositories would have to be supported, both with staff and technical resources.
- The user interface for processing large numbers of updates and merges would have to be very efficient and easy to use.

## Towards a library metadata DVCS

Many components required to build a DVCS for library metadata already exist: several DVCS platforms could be built upon for a prototype and most library metadata formats can be expressed as XML, for which toolkits for diffs and merges already exist. A cataloging editor that uses a DVCS repository would need to be able to query multiple target repositories, but existing search standards and metasearch tools could handle that.

There are some cases where a library DVCS should behave differently from a traditional DVCS. For example, it may be impractical for a library to clone the entire metadata history from a large repository, so it will be necessary to be able to clone on a record-by-record level. Bibliographic records typically contain both metadata of general instance and metadata that is useful only to one library, so a DVCS may need to be able to keep track of purely local changes. For example, it may not be useful to send MARC 856 fields containing URLs referencing a library's proxy server to other repositories.

In order to take advantage of DVCSs for library metadata, the process of pulling and pushing changes will need to be automated. Once tools for managing diffs and merges of library metadata records are created, automating a periodic update of changes from other repositories is in principle quite simple - for example, one might back up a Git repository by writing a script to periodically fetch changes into the backup repository. If this notion is applied to library metadata, automatic merges have implications for metadata quality control. No automatic merge algorithm is perfect, so catalogers would have to resolve merge conflicts. Even in the absence of merge conflicts, a cataloger may wish to monitor the changes to verify that they are correct, a task that could prove daunting if distributed version control becomes popular and the frequency of tweaks to records increases. Consequently, quality control may end up depending on the creation of better automatic tools for verifying the correct structure of metadata records, but it may also depend on catalogers distributing quality control. In other words, if a library pulls two hundred changes to its records a day, the cataloger may only be able to examine ten of those changes in great detail and must trust that the rest are either correct or will be corrected later. However, a DVCS enables each library to choose which repositories (or institutions, or even individual catalogers) will be used as a source for pulling record updates automatically. Utilizing these as trusted repositories could help facilitate  
the distribution of of quality control across institutions.

## Conclusion

Distributed version control for library metadata offers many advantages over the current approach where individual ILS silos at multiple institutions pull records from central bibliographic utilities, often manually adding local enhancements are never shared with others.

- Distributed version control tools promote the propagation of improvements to metadata records back to central repositories and among metadata users. Libraries of any size can take ownership of improving a portion of bibliographic metadata and sharing those improvements freely with others. Record enhancements can come from the bottom up, not just the top down.
- Each local metadata repository will have a complete history of changes to its records, which is a capability that not all bibliographic record editors and databases currently have.
- Each local metadata repository is automatically part of a distributed backup network for metadata records - LOCKSS \[[11](https://journal.code4lib.org/articles/#note11)\] can apply to metadata as well as electronic publications and scholarly data.
- While any sensible model for metadata creation has an important place for large central repositories, a distributed model is not completely dependent on any one entity. If a large contributor of metadata decreases its contributions, or if a central repository experiences difficulty, a distributed model allows work to be more easily shifted to other contributors and other core repositories.

With the many possible advantages of a DVCS model, it makes sense for institutions to begin experimenting with the creation of distributed repositories containing library metadata records. Repositories based on the DVCS model can promote metadata sharing beyond the level attained by current cooperative cataloging models, thereby improving the quality of metadata available to aid patrons and further distributing the cost of cataloging over many institutions.

## Resources

Open source library software projects using DVCS

- IndexData projects, including YAZ and Zebra (Git, [http://git.indexdata.com](http://git.indexdata.com/))
- Koha (Git, [http://git.koha.org](http://git.koha.org/))
- pymarc, a Python MARC library (Bazaar, [http://fruct.us/bzr/pymarc](http://fruct.us/bzr/pymarc))

## Notes

\[1\] BIBCO, the Monographic Bibliographic Record Program of the Program for Cooperative Cataloging (PCC) of the Library of Congress: [http://www.loc.gov/catdir/pcc/bibco/](http://www.loc.gov/catdir/pcc/bibco/).

\[2\] "Database enrichment" section of the "Quality assurance" section of OCLC's "Bibliographic formats and standards" guide. [http://www.oclc.org/bibformats/en/quality/default.shtm#databaseenrichment](http://www.oclc.org/bibformats/en/quality/default.shtm#databaseenrichment). Viewed 13 June 2008.

\[3\] "Enhance Training Outline." [http://www.oclc.org/support/training/worldcat/enhanceoutline/](http://www.oclc.org/support/training/worldcat/enhanceoutline/). Viewed 25 April 2008.

\[4\] NACO is the Name Authority Cooperative Program of the PCC ([http://www.loc.gov/catdir/pcc/naco/](http://www.loc.gov/catdir/pcc/naco/)) and SACO is the equivalent program for subject authority records ([http://www.loc.gov/catdir/pcc/saco/](http://www.loc.gov/catdir/pcc/saco/)).

\[5\] DVCS

- Bazaar: [http://bazaar-vcs.org](http://bazaar-vcs.org/)
- darcs: [http://darcs.net](http://darcs.net/)
- Git: [http://git.or.cz](http://git.or.cz/)/
- Mercurial: [http://www.selenic.com/mercurial/](http://www.selenic.com/mercurial/)

\[6\] "Version Control for Koha using Git." [http://wiki.koha.org/doku.php?id=en:development:git\_usage](http://wiki.koha.org/doku.php?id=en:development:git_usage). Viewed 25 April 2008.

\[7\] "Re: clarification on git, central repositories and commit access lists." Posting to kde-core-devel mailing list by Linus Torvalds. [http://lwn.net/Articles/246381/](http://lwn.net/Articles/246381/). Viewed 25 April 2008.

\[8\] "On the Record: Report of The Library of Congress Working Group on the Future of Bibliographic Control." [http://www.loc.gov/bibliographic-future/news/lcwg-ontherecord-jan08-final.pdf](http://www.loc.gov/bibliographic-future/news/lcwg-ontherecord-jan08-final.pdf). Viewed 15 June 2008.

\[9\] "Overview \[OCLC - WorldCat Local\]." [http://www.oclc.org/worldcatlocal/overview/](http://www.oclc.org/worldcatlocal/overview/). Viewed 17 June 2008.

\[10\] "About Us (Open Library)." [http://openlibrary.org/about](http://openlibrary.org/about). View 17 June 2008.

\[11\] "Lots of Copies Keep Stuff Safe". See [http://www.lockss.org](http://www.lockss.org/)

Galen Charlton is a developer at LibLime, working on the Koha open source ILS project.  
E-mail: [galen.charlton@liblime.com](https://journal.code4lib.org/articles/)  
URL: [http://www.galencharlton.com/blog/](http://www.galencharlton.com/blog/)
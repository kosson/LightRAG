---
title: "Lantern: A Pandoc Template for OER Publishing"
source: "https://journal.code4lib.org/articles/16329"
author:
  - "Chris Diaz"
published: 2022-05-10
created: 2025-01-10
description: "Lantern is a template and workflow for using Pandoc and GitHub to create and host multi-format open educational resources (OER) online. It applies minimal computing methods to OER publishing practices. The purpose is to minimize the technical footprint for digital publishing while maximizing control over the form, content, and distribution of OER texts. Lantern uses Markdown and YAML to capture an OER’s source content and metadata and Pandoc to transform it into HTML, PDF, EPUB, and DOCX formats. Pandoc’s options and arguments are pre-configured in a Bash script to simplify the process for users. Lantern is available as a template repository on GitHub. The template repository is set up to run Pandoc with GitHub Actions and serve output files on GitHub Pages for convenience; however, GitHub is not a required dependency. Lantern can be used on any modern computer to produce OER files that can be uploaded to any modern web server."
tags:
  - "#Pandoc"
  - "#template"
  - "#open/educational/resources"
---
# Lantern: A Pandoc Template for OER Publishing
Chris Diaz

Lantern is a template and workflow for using Pandoc and GitHub to create and host multi-format open educational resources (OER) online. It applies minimal computing methods to OER publishing practices. The purpose is to minimize the technical footprint for digital publishing while maximizing control over the form, content, and distribution of OER texts. Lantern uses Markdown and YAML to capture an OER’s source content and metadata and Pandoc to transform it into HTML, PDF, EPUB, and DOCX formats. Pandoc’s options and arguments are pre-configured in a Bash script to simplify the process for users. Lantern is available as a template repository on GitHub. The template repository is set up to run Pandoc with GitHub Actions and serve output files on GitHub Pages for convenience; however, GitHub is not a required dependency. Lantern can be used on any modern computer to produce OER files that can be uploaded to any modern web server.

## Motivations

Open educational resources (OER) are free teaching and learning materials that are available online for unlimited use, consultation, adaptation, and distribution. Typically, OER are distributed under a Creative Commons license \[[1](https://journal.code4lib.org/articles/#note1)\]. While they can be downloaded and used for free, maintaining an OER support infrastructure is an expensive endeavor. For example, academic libraries provide services to faculty focused on OER awareness, adoption, and creation. These services require staffing, training, coordination, technology, and marketing. Institutional OER grants and faculty stipends are a popular method for incentivizing and supporting the creation of new OER (Santiago & Ray 2020). However, in order for the public to reap the benefits, the OER needs to be published. Libraries also support the publication of OER by making the OER content discoverable, accessible, preservable, and reusable. The supporting infrastructure that libraries provide for OER raises questions about sustainability. Lantern was developed with these questions in mind.

The sustainability of an OER depends on the OER’s ongoing ability to meet its educational purpose. For OER initiatives in libraries, there are two primary sustainability concerns to keep in mind: (1) the production and access of OER and (2) the use and reuse of OER by the public (Wiley 2006). Both of these parts require people, workflows, and technologies. By minimizing the costs of digital infrastructure and maintenance, libraries can increase investments in people and workflows for OER production and access.

Lantern was designed to reduce the technical complexity of technology stacks necessary for the production, sharing, use, and re-use of OER by meeting these sustainability criteria, adapted from Wiley (2006):

- OER is created in a format that operates equally well across hardware and operating systems
- OER is available to the public in such a way that edits and adaptations can be made for teaching and learning in a variety of contexts

These criteria for the sustainability of OER can be aligned with the principles underlying minimal computing, a framework developed by digital humanists for designing systems that only use the hardware and software resources that are necessary for the task (Gil 2015). This thought exercise helped reduce the technology stack Lantern uses to create, host, and archive OER. Lantern’s stack is focused on structured plain text, static web technologies, version control, and open source software.

## Lantern

![](https://journal.code4lib.org/media/issue53/diaz/image1.png)  
**Figure 1.** Lantern Workflow Overview.

Lantern’s workflow begins with common word processing software and ends with a multiformat OER publication. Lantern provides a folder template and Bash script for using Pandoc to convert between manuscript (.docx or .odt), source (Markdown, YAML, BibTex), and publication formats (HTML, PDF, EPUB) \[[2](https://journal.code4lib.org/articles/#note2)\]. It is intended to make using Pandoc, a comprehensive document conversion tool, easier to use for OER creators and publishers who are generally new to command line programs. Lantern aims to teach fundamental digital skills in plain text editing, static web technologies, and open source software in order to encourage the use of minimal technology stacks in digital library projects. “Minimal technology stacks” refers to the intentional constraints around the technology components required for a computing process.

Pandoc is a command line tool that converts an input file of one file format into an output file of another file format. Both the input and output files need to be represented in a structured markup language. At the time of this writing, Pandoc (version 2.17.1) can read from 39 input file formats and write to 62 output formats, with varying levels of accuracy. Each conversion can take zero or dozens of options from 96 that are available.

The lantern.sh Bash script, files, and folders within the Lantern template repository simplify the level of customization available to Pandoc users for OER production use cases. For example, the Bash function responsible for generating the PDF looks like this:

| 1  2  3  4  5  6  7  8  9 | `pdf() {`  `pandoc text/*.md -o _temp``/chapters``.md`  `pandoc _temp``/chapters``.md \`  `--defaults settings``/pdf``.yml \`  `--output  $output_directory/$output_filename.pdf`  `echo` `"The PDF edition is now available."`  `}` |
| --- | --- |

The pdf function first calls pandoc to combine all of the markdown files within the /text/ subfolder to make up the body of the OER, ordering them by filename. The function then calls pandoc again to convert the concatenated Markdown file into a PDF using the settings specified in a Pandoc Defaults file \[[3](https://journal.code4lib.org/articles/#note3)\]. The Defaults file specifies a selection of Pandoc options, including the metadata, templates, and PDF settings we want to apply \[[4](https://journal.code4lib.org/articles/#note4)\]. Each output format has its own function within the script following the basic workflow but referencing different Defaults files and options. Ideally, the Lantern template repository serves as an approachable foundation from which users can build their own customizations and features for their projects.

## Structured Plain Text

Most people write and edit text using a rich text editor, like those found in Microsoft Word, Google Docs, WordPress, and email programs. Rich text editors display the style elements of the document, but obscure the semantic elements of the document’s underlying structure. This leads people to use alignment and bold fonts to signal that a specific text element is a heading, which sighted people may understand visually, but machines (like screen-readers) might miss. To avoid this pitfall, Lantern provides tips on tagging manuscript files in .docx format with proper headings and styles using word processing software, like Microsoft Word.

Document structure is essential for accessibility, formatting, and portability. Lantern uses Markdown and YAML as the structured plain text representations of an OER’s content and metadata. Plain text offers numerous advantages for library-based OER publishers, as Tenen and Wythoff (2014) explain:

> Plain text both ensures transparency and answers the standards of long-term preservation. MS Word may go the way of WordPerfect in the future, but plain text will always remain easy to read, catalog, mine, and transform. Furthermore, plain text enables easy and powerful versioning of the document, which is useful in collaboration and organizing drafts… Plain text is backwards compatible and future-proof.

Lantern also provides a file structure for an OER project. An example project folder contains a lantern.sh script file, a metadata.yml file, a subfolder (/text/) for Markdown files, and several other subfolders containing the templates, styles, and configurations. This structure enforces a separation between content and style; Lantern users only need to use the metadata.yml and /text/ subfolder.

Markdown provides many advantages for academic writing, OER production, and preservation. John Gruber, one of its inventors, explains the philosophy of Markdown this way (2004):

> Markdown is intended to be as easy-to-read and easy-to-write as is feasible. Readability, however, is emphasized above all else. A Markdown-formatted document should be publishable as-is, as plain text, without looking like it’s been marked up with tags or formatting instructions.

Here’s an example of Markdown syntax:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `# Chapter Title`  `Introductory paragraph text with **bold** and *italic* text.`  `## Section Heading`  `Introductory paragraph for the section. `  `### Subsection Heading`  `More content, but in list form:`  `- list item`  `- list item`  `- list item` |
| --- | --- |

Markdown is useful for digital publishers and preservationists because it is human-readable in its raw form and machine-readable for converting to HTML and dozens of other markup formats. Lantern mostly follows Pandoc’s Markdown syntax for textual elements, with additional support for numbered references (for equations, figures, and tables), callout boxes, and exercise questions. Lantern organizes the content of an OER project as one or more Markdown files in a \`/text/\` subfolder. Each file is named according to its numerical order within the larger project:

| 1  2  3 | `001-preface.md`  `010-introduction.md`  `020-theory.md` |
| --- | --- |

Lantern uses YAML as its primary metadata format. Like Markdown, YAML was selected for its readability and ability to be transformed into JSON and several other structured data formats. The metadata file contains bibliographic metadata fields represented in YAML syntax, for example:

| 1  2  3  4  5  6  7  8  9  10  11 | `title: Lantern`  `subtitle: An OER Publishing Toolkit`  `author:`  `- name: Chris Diaz`  `affiliation: Northwestern University`  `- name: Lauren McKeen McDonald`  `affiliation: Northwestern University`  `keywords:`  `- textbooks`  `- oer`  `- digital publishing` |
| --- | --- |

## GitHub for OER Publishing

Perhaps one of the most powerful advantages for using plain text to organize and produce OER is the ability to use the Git version control system and the GitHub ecosystem of collaboration and automation tools. The management, collaboration, and preservation benefits of Git and GitHub for library technology projects are well documented (Davis 2015, Giorgio et al. 2019; Becker et al. 2020). Lantern demonstrates the benefits of Git and GitHub for OER projects.

Lantern is a template repository on GitHub. It is intended to make it easy for anyone to generate their own OER projects using the same repository structure and files. In practice, a user would login to GitHub, visit the Lantern repository, and generate a new repository for their OER project. They would then add their own project’s content and metadata and use Lantern’s preconfigured settings to produce their multi-format OER for free. Lantern’s pre-configurations take advantage of GitHub Actions \[[5](https://journal.code4lib.org/articles/#note5)\] and GitHub Pages \[[6](https://journal.code4lib.org/articles/#note6)\]. GitHub Actions is a programmable workflow automation tool and GitHub Pages is a static website hosting service. These features are especially useful for OER publishing.

Lantern provides documentation to help users prepare manuscripts in common file formats (.docx) and GitHub Actions to convert them to Markdown using Pandoc. The basic workflow involves the following steps:

1. User generates a GitHub repository using Lantern as a template repository
2. User uploads .docx files to the /original/ subfolder
3. User makes a commit using the GitHub web interface: “Add files via upload”

This triggers a GitHub Actions workflow that performs the following tasks:

1. Provision a hosted virtual machine running Ubuntu 20.04+ LTS
2. Install Pandoc 2.17+
3. Checkout the main branch of the GitHub repository
4. Convert each .docx file to a Markdown file using Pandoc
5. Move the Markdown files to the /text/ subfolder
6. Commit this change back to the main branch of the GitHub repository

![](https://journal.code4lib.org/media/issue53/diaz/image2.png)  
**Figure 2.** Logs from Using GitHub Actions to Convert Manuscript Files with Pandoc.

After this process, the user is ready to check the Markdown files for any conversion errors and make necessary changes using GitHub’s web interface for editing and previewing Markdown.

![](https://journal.code4lib.org/media/issue53/diaz/image3.png)  
**Figure 3.** GitHub’s Web Interface for Code (i.e. Markdown) Editing.

![](https://journal.code4lib.org/media/issue53/diaz/image4.png)  
**Figure 4.** GitHub’s Web Interface for Previewing Markdown Rendered as HTML.

Lantern adopts a lightweight continuous integration / continuous deployment approach to OER publishing. Lantern is preconfigured to build and deploy the HTML version of an OER project by default. Other output formats, such as PDF and EPUB, are needed to be enabled by making a change in a configuration file. Each time the user makes a commit to either the metadata.yml file or any of the Markdown files in the /text/ subfolder, another GitHub Actions workflow will be triggered, executing the following tasks:

1. Provision a hosted virtual machine running Ubuntu 20.04+ LTS
2. Install Pandoc 2.17+ and other Lantern dependencies
3. Checkout the main branch of the GitHub repository
4. Run the lantern.sh script, which builds a static HTML website for the OER by default
5. Deploy the website files to the gh-pages branch

Once the user enables the GitHub Pages feature on their repository, the website files contained within the gh-pages branch of the repository will be made publicly available at a github.io URL. From then on, each new commit in a Lantern OER’s repository will trigger a rebuild and redeployment of the OER website and output formats. Users can disable the public accessibility of their in-development OER project by disabling GitHub Pages in their repository and re-enable it whenever they are ready to publish.

## Static Web Technologies

Lantern builds a static website for the OER’s metadata, full-text, and downloadable assets (e.g. PDF, EPUB, etc.). Static websites are faster, cheaper, simpler, and more secure than dynamically generated websites because they remove the authentication, database, and application layer typically used by content management systems (Newson 2017; Varner 2017; Diaz 2018). Static websites are read-only and require minimal maintenance in order for the public to visit and use the website. Their reduced complexity makes them an attractive option for OER publishers and digital archivists (Rumianek 2013).

Lantern transforms the metadata.yml and /text/ subfolder into a multi-page static website using Pandoc and Bash scripting (lantern.sh). If the user decides to produce PDF, EPUB, and DOCX versions of the OER project, each of those documents will be linked from the website available for download. Here is output directory for a real-world example of an OER website built with Lantern hosted on GitHub Pages \[[7](https://journal.code4lib.org/articles/#note7)\]:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21 | `css/`  `js/`  `.nojekyll`  `CNAME`  `index.html`  `010-intro.html`  `020-casual-inference.html`  `030-theory.html`  `040-data.html`  `050-hypothesis-testing.html`  `060-surveys.html`  `070-experiments.html`  `080-large-n.html`  `090-small-n.html`  `100-social-networks.html`  `110-machine-learning.html`  `120-conclusion.html`  `900-appendix-math.html`  `Clipperton_EMPS.docx`  `Clipperton_EMPS.epub`  `Clipperton_EMPS.pdf` |
| --- | --- |

Static websites are compelling options for well-scoped web publications, like OER, monographs, scholarship, digital collections, and exhibits, that libraries hope to maintain in perpetuity. Lib-static provides models, concepts, and community around leveraging minimal digital infrastructures and static web technologies for library projects \[[8](https://journal.code4lib.org/articles/#note8)\]. Websites that require content management systems and server-side application software in order to function can become costly and difficult to maintain. OER publications in particular may require years of stability, even if the content is no longer updated. Static websites provide that stability.

## Portability with Open Source Software

Library-based publishers, scholarly communications specialists, and open education advocates developed a keen interest in advancing an open infrastructure for scholarly publishing after the news that Bepress, a provider of proprietary institutional repository software, was acquired by Elsevier (Schonfeld 2017; Schonfeld 2019). This news generated new investments in open source software development for libraries and non-profits involved in digital publishing, among many other initiatives (Lewis 2017; Invest in Open Infrastructure). This momentum provided the motivation to prioritize the use of portable, cross-platform, open source software as the foundation from which Lantern was developed.

Lantern requires the following software programs:

- Pandoc: a command-line document converter
- PagedJS: a PDF generator for HTML styled with CSS
- Any unix shell interpreter with grep, awk, and sed utilities
- Any text editor

Git (a source code version management system), pandoc-crossref (a filter for handling cross-references to equations, figures, and tables), and LaTeX (a PDF typesetting system), are not required but can be useful for collaborative or mathematically-rich OER projects. All of these programs are open source and compatible on macOS, Windows, and Linux operating systems.

Open source software was a requirement for Lantern’s design because it is less likely to produce the problem of vendor lock-in, a phenomenon in which a customer becomes dependent upon a vendor’s products (Maxwell et al. 2019). Lantern teaches the fundamental skills of using Markdown, YAML, and command line programs necessary to use other software that performs similar functions if and when Lantern’s software dependencies become unusable for any reason. Markdown and YAML can be parsed and converted by hundreds of other software libraries in dozens of programming languages.

GitHub is provided as a convenience, but it is not required for use. Lantern users can download the template files from GitHub, run the software on their own files, and upload the output files to any web hosting service.

## Conclusions

Reducing unnecessary overhead for the setup and maintenance of systems will ultimately lower technology and labor costs. An OER support infrastructure within an academic library is composed of people, workflows, and technologies. If given a budget to design and implement an OER program, it would be reasonable to think that the administrative roles and editorial processes for OER creation (i.e. the people and workflows) should be the highest priority, with promotion and discovery for OER adoption (i.e. people and workflows) following closely behind. Lantern was designed to enable librarians to have a robust publishing workflow with the fewest technology maintenance expenses in order to devote more resources to the labor of OER creation and adoption. By adopting approaches like Lib-static and minimal computing, librarians can focus on developing transferable skills rather than learning specific platforms. It is not the goal for Lantern to become a “publishing platform” for OER. The goal is to demonstrate how fundamental digital skills with structured plain text, version control, and open source software can help librarians design and deploy sustainable web products for their communities.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\]: Overview of OER licensing here: [https://en.wikipedia.org/wiki/Open\_educational\_resource#Licensing\_and\_types](https://en.wikipedia.org/wiki/Open_educational_resource#Licensing_and_types)

\[[2](https://journal.code4lib.org/articles/#ref2)\]: Git repository of Lantern on GitHub: [https://github.com/nulib-oer/lantern](https://github.com/nulib-oer/lantern)

\[[3](https://journal.code4lib.org/articles/#ref3)\]: Pandoc documentation on using Defaults files for configuration management: [https://pandoc.org/MANUAL.html#defaults-files](https://pandoc.org/MANUAL.html#defaults-files)

\[[4](https://journal.code4lib.org/articles/#ref4)\]: Example of a Pandoc Default’s file used for managing PDF output settings: [https://github.com/nulib-oer/lantern/blob/main/settings/pdf.yml](https://github.com/nulib-oer/lantern/blob/main/settings/pdf.yml)

\[[5](https://journal.code4lib.org/articles/#ref5)\]: GitHub actions is a Continuous Integration and Continuous Deployment service: [https://github.com/features/actions](https://github.com/features/actions)

\[[6](https://journal.code4lib.org/articles/#ref6)\]: GitHub Pages is a static website hosting service: [https://pages.github.com/](https://pages.github.com/)

\[[7](https://journal.code4lib.org/articles/#ref7)\]: Example of the website files generated from Lantern ([https://github.com/nulib-oer/emps/tree/gh-pages](https://github.com/nulib-oer/emps/tree/gh-pages)) and the final website ([https://emps.northwestern.pub/](https://emps.northwestern.pub/)).

\[[8](https://journal.code4lib.org/articles/#ref8)\]: Lib-static community website: [https://lib-static.github.io/](https://lib-static.github.io/)

## Bibliography

Becker D, Williamson E, Wikle O. 2020. CollectionBuilder-CONTENTdm: Developing a Static Web ‘Skin’ for CONTENTdm-based Digital Collections. The Code4Lib Journal \[Internet\]. (49). \[Accessed 2022 Feb 23\]. Available from: [https://journal.code4lib.org/articles/15326](https://journal.code4lib.org/articles/15326).

Davis, R. 2015. Git and GitHub for Librarians. Behavioral & Social Sciences Librarian 34.3.  
159–164. Available from: [https://academicworks.cuny.edu/jj\_pubs/34/](https://academicworks.cuny.edu/jj_pubs/34/).

Diaz C. 2018. Using Static Site Generators for Scholarly Publications and Open Educational Resources. The Code4Lib Journal \[Internet\].(42). \[Accessed 2022 Feb 23\]. Available from: [https://journal.code4lib.org/articles/13861](https://journal.code4lib.org/articles/13861).

Giorgio S, et al. 2019. What is Git/GitHub? – LibraryCarpentry/lc-git: Library Carpentry: Introduction to Git. \[Internet\]. Available from: [http://doi.org/10.5281/zenodo.3265772](http://doi.org/10.5281/zenodo.3265772).

Gil A. 2015. The User, the Learner, and the Machines we Make. Minimal Computing: a working group of GO: DH \[Internet\]. \[Cited 2022 February 24\]. Available from: [https://go-dh.github.io/mincomp/thoughts/2015/05/21/user-vs-learner/](https://go-dh.github.io/mincomp/thoughts/2015/05/21/user-vs-learner/).

Gruber J. 2004. Markdown: Syntax. Daring Fireball \[Internet\]. Available from: [https://daringfireball.net/projects/markdown/syntax](https://daringfireball.net/projects/markdown/syntax).

Invest in Open Infrastructure (Page 1). Invest in Open Infrastructure. \[Accessed 2022 Feb 23\]. Available from: [https://investinopen.org/about/](https://investinopen.org/about/).

Lewis DW, Goetsch L, Graves D, Roy M. 2018. Funding community controlled open infrastructure for scholarly communication: The 2.5% commitment initiative | Lewis | College & Research Libraries News. doi: https://doi.org/10.5860/crln.79.3.133. \[Accessed 2022 Feb 9\]. Available from: [https://crln.acrl.org/index.php/crlnews/article/view/16902](https://crln.acrl.org/index.php/crlnews/article/view/16902).

Maxwell JW, Hanson E, Desai L, Tiampo C, O’Donnell K, Ketheeswaran A, Sun M, Walter E, Michelle E. 2019. Setting Context. In: Mind the Gap: A Landscape Analysis of Open Source Publishing Tools and Platforms. \[Accessed 2022 Feb 23\]. Available from: [https://mindthegap.pubpub.org/pub/gei072ab/release/2](https://mindthegap.pubpub.org/pub/gei072ab/release/2).

Newson K. 2017. Tools and Workflows for Collaborating on Static Website Projects. The Code4Lib Journal \[Internet\].(38). \[Accessed 2022 Feb 23\]. Available from: [https://journal.code4lib.org/articles/12779](https://journal.code4lib.org/articles/12779).

Rumianek, M. 2013. Archiving and recovering database-driven websites. D-Lib Magazine \[Internet\]. \[Cited 2022 February 23\]. Available from: [http://www.dlib.org/dlib/january13/rumianek/01rumianek.html](http://www.dlib.org/dlib/january13/rumianek/01rumianek.html).

Santiago A, Ray L. 2020. Navigating support models for OER publishing: case studies from the University of Houston and the University of Washington. Reference Services Review. 48(3):397–413. doi:10.1108/RSR-03-2020-0019.

Schonfeld RC. 2017. Elsevier acquires institutional repository provider bepress. The Scholarly Kitchen. \[Accessed 2022 Feb 23\]. Available from: [https://scholarlykitchen.sspnet.org/2017/08/02/elsevier-acquires-bepress/](https://scholarlykitchen.sspnet.org/2017/08/02/elsevier-acquires-bepress/).

Schonfeld RC. 2019. Invest in Open Infrastructure: An Interview with Dan Whaley. The Scholarly Kitchen. \[Accessed 2022 Feb 17\]. Available from: [https://scholarlykitchen.sspnet.org/2019/06/12/invest-open-infrastructure/](https://scholarlykitchen.sspnet.org/2019/06/12/invest-open-infrastructure/).

Tenen D & Wythoff G. 2014. Sustainable Authorship in Plain Text using Pandoc and Markdown. The Programming Historian \[Internet\]. Available from: [https://doi.org/10.46430/phen0041](https://doi.org/10.46430/phen0041).

Varner S. 2017. Minimal Computing in Libraries: Introduction. Minimal Computing \[Internet\]. \[Accessed 2022 Feb 23\]. Available from: [https://go-dh.github.io/mincomp/thoughts/2017/01/15/mincomp-libraries-intro/](https://go-dh.github.io/mincomp/thoughts/2017/01/15/mincomp-libraries-intro/).

Wiley D. 2006. On the Sustainability of Open Educational Resource Initiatives in Higher Education. OECD’s Centre for Educational Research and Innovation \[Internet\]. \[Cited 2022 February 24\]. Available from: [https://www.oecd.org/education/ceri/38645447.pdf](https://www.oecd.org/education/ceri/38645447.pdf).

[Chris Diaz](https://journal.code4lib.org/articles/) ([https://chrisdaaz.github.io](https://chrisdaaz.github.io/)) is the Digital Publishing Librarian at Northwestern University. He is an avid user of static site generators for library-based publishing projects, such as journals, monographs, exhibits, and open educational resources.

Lantern received financial support from the Association of Research Libraries’ Venture Fund program in 2020.
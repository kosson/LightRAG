---
title: "Python, Google Sheets, and the Thesaurus for Graphic Materials for Efficient Metadata Project Workflows"
source: "https://journal.code4lib.org/articles/12182"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-01-30
created: 2025-01-10
description: "In 2017, the University of Virginia (U.Va.) will launch a two year initiative to celebrate the bicentennial anniversary of the University’s founding in 1819. The U.Va. Library is participating in this event by digitizing some 20,000 photographs and negatives that document student life on the U.Va. grounds in the 1960s and 1970s. Metadata librarians and [...]"
tags:
  - "clippings"
---
# Python, Google Sheets, and the Thesaurus for Graphic Materials for Efficient Metadata Project Workflows
Jeremy Bartczak, Ivey Glendon

In 2017, the University of Virginia (U.Va.) will launch a two year initiative to celebrate the bicentennial anniversary of the University’s founding in 1819. The U.Va. Library is participating in this event by digitizing some 20,000 photographs and negatives that document student life on the U.Va. grounds in the 1960s and 1970s. Metadata librarians and archivists are well-versed in the challenges associated with generating digital content and accompanying description within the context of limited resources. This paper describes how technology and new approaches to metadata design have enabled the University of Virginia’s Metadata Analysis and Design Department to rapidly and successfully generate accurate description for these digital objects. Python’s pandas module improves efficiency by cleaning and repurposing data recorded at digitization, while the lxml module builds MODS XML programmatically from CSV tables. A simplified technique for subject heading selection and assignment in Google Sheets provides a collaborative environment for streamlined metadata creation and data quality control.

## Project Overview

In 2017, the University of Virginia (U.Va.) will launch a two year initiative to celebrate the bicentennial anniversary of the University’s founding in 1819. The U.Va. Library is participating in this event by digitizing some 20,000 photographs and negatives that document student life on the U.Va. grounds in the 1960s and 1970s. The collection shows sporting events, teaching and research, and the residential aspects of life at the university. We anticipate that this collection will be very popular with researchers, students, and alumni.

The idea for collection digitization began in Summer 2015 through a partnership between special collections curators and the Library’s Digital Production Group (DPG) as plans for University-wide recognition for the bicentennial anniversary came into focus. The project evaluation process involved the following stakeholder groups:

**Table 1.** Stakeholder Groups

| **Team** | **Role** |
| --- | --- |
| Special Collections curators | Photograph selection |
| Digital Production Group (DPG) | Digitization |
| Metadata Analysis and Design (MAD) | Metadata schema/content standard selection and evaluation and workflow management |
| Digital Content Management and Dissemination (DCMD) | Collection publication locally and to aggregators |

Through the fall of 2015 and winter of 2016, the curatorial staff worked with the digitization group to select photographs, test the conversion, and establish a digitization schedule to meet the desired volume within the given time period. In spring 2016, the DPG turned to the MAD team to evaluate metadata design and creation possibilities for this collection within the Library’s standard MODS schema for digital objects.

## Metadata Design: Approaches to Description

Various criteria impacted the MAD group’s decision making processes for metadata design, including limited staffing resources, metadata creation efforts on other digital conversion projects, and feedback from students, researchers, and colleagues. Given these circumstances, the MAD group aligned around three guiding principles for metadata design for this collection:

- A strong preference for manipulating existing metadata rather than creating original description
- Selection of a vocabulary for subject access that is easily understood and applied by student assistants but also meaningful to a wide variety of users
- Development of a metadata creation framework easily understood by undergraduate student assistants completing the metadata creation work

Past experience with a variety of digital conversion efforts has led MAD staff to favor metadata manipulation over fresh metadata creation whenever possible. In the past, confusion around content standards and supplying titles for unpublished material has incurred significant metadata rework costs and necessitated a burdensome quality review process. The photographs identified for the bicentennial celebration come with folder-level metadata that the DPG student assistants transcribe as part of the digitization process; the existence of this metadata, however scant, provides an anchoring point to create a metadata manipulation process rather than relying on new metadata creation. Consequently, the MAD team designed an approach to titling wherein digitized images are examined and given more specific titles based on actual subject matter and the data on the folder. For example, a folder labeled “Candid Shots Geology Department” would inform an item-level photograph caption: “Two students observing exhibit in Geology Department.”

The selection of a controlled vocabulary for subject access for this collection was also a significant decision point for the MAD team, and one that represents an evolution in approaches to subject access for locally unique collections. Anecdotal evidence from students, researchers, and library colleagues has led the MAD team to evaluate the merit of compound Library of Congress Subject Heading (LCSH) strings against simple headings from other sources, such as the Faceted Application of Subject Terminology (FAST) authority file. Students, researchers, and colleagues have found the complex LCSH headings “too specific to be useful,” “difficult to navigate,” and “impossible to use for finding like materials.” Reflecting on this feedback, the MAD team aligned around a simplified subject application approach for several reasons, some related to metadata philosophy and some for workflow expediency:

- Complex, compound LCSH headings describe single items well but to the detriment of an aggregation of objects
- Simplified headings map to permanent URIs where complex strings sometimes do not
- Simplified headings will be more accessible to students as users but also much more accessible to the students who will be doing the metadata creation work in a production environment

Agreed in this approach, the MAD team further considered the vocabulary possibilities to meet the desired specifications for creation by students and engagement by researchers. The Library of Congress Thesaurus for Graphic Materials (LCTGM) was identified as a desirable vocabulary for this collection, as it provides a list of targeted headings ideal for describing visual materials, a persistent URI for every term, and accessibility to students such that they can easily view an image and apply an appropriate heading. Since the scope of the collection is limited to a very predictive range of topics, an additional step was taken to simplify the workflow: a metadata librarian compiled and made available to students a list of around 40 pre-selected LCTGM terms that potentially apply to photograph subject matter across the collection for the project for selection during processing. Additionally, the MAD team limited assignment of subject terms to not more than three per photograph.

Deliberation on title and topical subject access for these materials represented the bulk of the metadata design effort in advance of moving into a production workflow for digitization and metadata manipulation and creation. Other metadata, including dates (captured at digitization), the corporate heading “University of Virginia,” and the geographic heading “Charlottesville, Va.,” are available for all objects. The creation of a five-part metadata design framework – title, date, topical subject, corporate heading, and geographic access point – represents a radically lighter metadata approach for this collection compared to past projects. By eschewing elaborate, narrative description, we have developed a process that is easily understood by undergraduate students doing the metadata creation work, and that reflects acceptance of a “good enough” standard to support rapid cataloging of objects.

## Metadata Creation: Workflows, Pandas, and Google Sheets

Implementation of these strategies begins upstream with the Library’s digitization workflow which is managed in an in-house system where images and metadata are staged for repository ingest. Two database fields (title and description) are available for DPG student workers to record information gathered from physical items at the point of digitization. For this particular project, DPG student workers proceed through the collection box-by-box in archival context. As the items are digitized, students manually record baseline descriptive metadata in the system, which is transcribed either from the physical item itself or from the original photographer’s folder that it is housed in.

Digitized master files from each box are grouped as “units” within the system, complete with this first-pass at descriptive metadata plus additional automatically generated administrative metadata. Some examples of data created or recorded at this stage includes fields like identifier, TIFF filename, repository PID, and the aforementioned photographer supplied job title. For this particular project, both date and folder data are collapsed into the Description field and pipe-delimited. The workflow system provides an interface to navigate this information within units, at the item-level, with both digital object and metadata displayed. Notably, the metadata initially associated with these objects is designed to accommodate digitization and ingest workflows. Descriptive MODS XML is uploaded at a later stage for final online display. Certain fields, such as photographer supplied title data, folder numbers, dates, and administrative identifiers, are fully incorporated or re-purposed into MODS fields downstream.

Based on this workflow, the MAD team had to implement an efficient strategy for creating MODS records. One option considered was to design a MODS template and have students manually combine data from the digitization workflow with assigned subject headings and reformatted titles (e.g., “Candid Shots Geology Department”–as noted earlier in this paper, the students replace the photographer supplied title with a more descriptive caption for the object) in an XML editor. A different option involved downloading digitization metadata to a CSV and munging that dataset. Cataloging work could take place within the CSV, with a student worker simply adding titles and assigning subject headings to each record in the table. MODS records could then be built by iterating over the table using lxml. The latter approach was selected because it avoided the additional steps of training students in XML and getting them oriented with the editor. It also was faster because administrative data was automatically added to each record as opposed to manual re-entry.

With the decision to work with CSV data in place, the next step was to clean the data up and get it into a presentable display for further enhancement. Metadata entry would happen in the MAD unit and be completed by a second group of student workers. A script was designed to clean up the data. This included standardizing date formatting and reducing extraneous columns to prevent a wide, scrolling display for a more straightforward data entry interface. Creating a script, similar to automating the MODS record build, would save significant time by preventing the need to document and implement steps for manual clean up.

Python’s pandas module proved to be an ideal tool for cleaning up the datasets per these requirements. Pandas is a python package developed for statistical analysis and data manipulation. The CSV is read in as a DataFrame—a tabular, two dimensional spreadsheet-like object with columns that can accommodate different datatypes (McKinney 2013). Columns and rows can be easily selected using various pandas methods (10 minutes to pandas 2016). There is also built in functionality for working with textual data and empty cells. The pandas DataFrame was inspired by the R programming language’s dataframe, thus providing similar baseline functionality with the R data analysis programming environment (Comparison with R/R libraries 2016).

An obvious alternative to this approach would have been to use OpenRefine, the popular data cleaning tool. The goal was to be able to save a series of scripted commands that could be run for a large set of similar spreadsheets in the workflow. This could easily be accomplished in Pandas or OpenRefine (or R for that matter). OpenRefine also provides a Jython language interface for those who prefer Python. This paper doesn’t advocate for one approach over the other. Pandas was a logical decision in this context for multiple reasons:

- The project provided an opportunity to apply a new skill-set gained by a team member who had recently taken related coursework with U.Va.’s Research Data Services and Sciences program. This was an opportunity to develop that skill-set and diversify expertise within the department.
- The learning curve was reasonable. Given prior experience, pandas was the best bet for quickly getting a script up and running to perform what was required.
- The department prides itself on curiosity and exploration. While pandas is immensely popular in the scientific data analysis community, there hasn’t been as much discussion in the library metadata literature. Here was an opportunity to test out the tool on a large metadata project and share the results.
- Even though OpenRefine offers a templated export option, the team was committed to using Python’s lxml module for building the MODS records in Python. It made sense to keep related code streamlined as data was pushed and pulled through the workflow.

The following code snippets demonstrate the data cleanup workflow and some very basic pandas functionality. The complete script is available at: [https://github.com/jtbmadva/bicentennial-project-scripts](https://github.com/jtbmadva/bicentennial-project-scripts)

Import the modules used in the script and read the CSV in as a DataFrame.

| 1  2  3  4  5 | `import` `pandas as pd`  `import` `re`  `from` `dateutil.parser ``import` `parse`  `df ``=` `pd.read_csv(``'sample_data.csv'``)` |
| --- | --- |

Columns that aren’t important for the eventual MODS output are removed using the drop function. Note that the axis has to be specified. The DataFrame is indexed as a two-dimensional array, with axis 1 corresponding to data along the columns. Here is one of several columns dropped from the downloaded CSV. To reiterate, this is data that helps with ingest workflows but is not required for final MODS output, so it is removed.

| 1 | `df ``=` `df.drop(``'Filesize'``, axis``=``1``)` |
| --- | --- |

A column with multiple values is split using pandas string functionality. Recall that at the point of digitization, students entered date and job number data into a single, generic “Description” column with that information pipe delimited. The values from the Description column are split at the delimiter into a list, then indexed. Values are then assigned to two new columns, appropriately labelled Date and Job in square brackets. This example shows how easy it is to process each value in the column through vectorized string methods.

| 1  2 | `df[``'Date'``] ``=` `df.Description.``str``.split(``'\|'``).``str``[``0``]`  `df[``'Job'``] ``=` `df.Description.``str``.split(``'\|'``).``str``[``1``]` |
| --- | --- | --- | --- |

An existing Title field is renamed ‘Info from Job’ to more accurately describe data there. DPG students used this column to transcribe notes directly from photographer job folders. This data informs actual title creation downstream in the workflow. The former column name is replaced using a dictionary in the columns parameter.

| 1 | `df ``=` `df.rename(columns``=``{``'Title'``: ``'Info From Job'``})` |
| --- | --- |

Columns are then added for the fields required for the next step in the description: a new Title field, and three Subject fields. Subject assignment is intentionally limited to three terms, hence three subject columns. To insert the columns to a specific location in the DataFrame, the insert function is used. Column location in the frame is specified by index and assigned a column header. The value parameter includes empty quotes to ensure that the cells are empty.

| 1  2  3  4 | `df.insert(``2``, ``'Title'``, value``=``'')`  `df.insert(``4``, ``'Subject 1'``, value``=``'')`  `df.insert(``5``, ``'Subject 2'``, value``=``'')`  `df.insert(``6``, ``'Subject 3'``, value``=``'')` |
| --- | --- |

A final step involves cleaning up inconsistent date data previously entered by students with a group of conditional statements. Here data from the Date column is thrown into a list and iterated over by conditional statements in order to catch and remediate some of the various ways this information was recorded by students. This block leverages both the regular expressions and dateutil Python modules which are imported at the top of the script. Fortunately the various conditions for entering date information for this project have been fairly consistent and alleviated as digitization work progressed. Some issues do slip through though (seasons of the year or multiple dates entered) and cause the code to fail, requiring a quick scan of the CSV and manual correction.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14 | `dates ``=` `df[``'Date'``].tolist()`  `for` `i ``in` `dates:`  `if` `len``(i) ``=``=` `4``:`  `i ``=`   `+` `parse(i).strftime('``%``Y``-``%``m')`  `DateCol.append(i)`  `elif` `list``(i).count(``'-'``) ``=``=` `1``:`  `i ``=`   `+` `parse(i).strftime('``%``Y``-``%``m``-``%``d')`  `DateCol.append(i)` |
| --- | --- |

After the above steps are implemented, the DataFrame is output to a newly titled “clean” CSV.

| 1 | `df.to_csv(``'clean_sample_data.csv'``, encoding``=``'utf-8'``)` |
| --- | --- |

The new CSV is now prepped and ready for data entry by student workers. The script described above outputs a much more streamlined view of the data originally downloaded, plus columns have been renamed or added to be as clear as possible about the data students are working with. To further facilitate our goals, the CSV is uploaded as a Google Sheet with settings adjusted to allow editing privileges for those who have access to the URL. The list of LCTGM terms mentioned earlier is manually added as a drop-down menu in the subject columns of the sheet using the Google Sheets data validation feature. In addition to the data validation term, the unique id.loc.gov URI suffix is included along with a pipe delimiter for any potential future linked open data initiatives. Students consult basic guidelines written in-house and modelled on the excellent indexing tutorials made available online by the Library of Congress Prints and Photographs Division (Cataloging & Digitizing Toolbox 2010).

The actual workflow takes place at the computer with a given Google sheet open and the corresponding digital images accessed via the Library’s digitization workflow system. Description happens by unit (recall that digital object units are organized to reflect the arrangement of the physical collection in boxes) with metadata assigned in the sheet based on matching TIF filenames. Students peer review each data set for basic errors by checking for typos and suggesting improved titles or alternative subject terms. This process helped significantly to standardize approaches within the project as they looked at each other’s work after it was completed and proceeded through the collection. A metadata librarian performed a final quality control check before outputting to MODS.

## Building the MODS Records with lxml

Once the CSV data is entered and reviewed, a Python script using the lxml module iterates over the data and builds MODS XML records. These final records are then validated and uploaded for object display in U.Va.’s digital library. Lxml is a Python module for working with XML data. A blog post highlighting the power of this module for remediating archival metadata features some excellent examples and use cases (Boyle 2015). Two detailed tutorials are also available that provide all of the necessary information to get up and running:

[http://infohost.nmt.edu/~shipman/soft/pylxml/web/index.html](http://infohost.nmt.edu/~shipman/soft/pylxml/web/index.html)  
[http://lxml.de/tutorial.html](http://lxml.de/tutorial.html)

This section will step through some of the methods used for this project to output metadata from a pandas DataFrame to a valid MODS record (the entire script is available in the Github link shown above). The XML processes described here use the lxml ElementTree api, datetime, and pandas modules. Datetime and ElementTree are imported as follows:

| 1  2 | `from` `lxml ``import` `etree`  `import` `datetime as dt` |
| --- | --- |

After reading the CSV in as a DataFrame, the first step is to iterate over the frame using the pandas iterrows() function.

| 1 | `for` `index, series ``in` `df[:].iterrows():` |
| --- | --- |

The function iterates over the frame in index (row) and series (columns) pairs, so variables are created for both “index” and “series”. Now data can be easily referenced by column name to output cell values from each line of the frame.

At the beginning of this process the root element for the MODS record must be created. Three things happen in this process:

- Attributes are included for both the MODS schemaLocation and version
- Namespaces are declared for both XSI and MODS
- Namespaces are mapped to namespace prefix strings for the final XML output to display correctly

The tricky part is that lxml doesn’t use namespace prefixes. Instead it uses Clark notation which places the entire namespace URI inside curly braces in front of the element name (Clark 1999). So, for example:

Maps to:

Variables are set up by convention for both namespace URI’s, the MODS schema location, and the namespace mapping. These variables can be referenced in the code to keep things cleaner and more readable.

The name of the mods root element is set up using Clark notation. Note the string formatting where curly braces are concatenated with the mods\_ns variable alongside the element name.

An attribute is created in a dictionary for xsi:schemaLocation, again using Clark notation, the same string formatting as above, plus the mods schema value assigned to mods\_schema\_location

| 1 | `attrib``=``{``'{'``+` `xsi_ns ``+``'}schemaLocation'` `: mods_schema_location}` |
| --- | --- |

Now the namespaces prefix strings must be mapped to their URIs via a dictionary and using the tree.Element() nsmap parameter and the ns\_map variable. The MODS namespace is mapped to None, since it’s already been declared as the root element’s default namespace.

The etree.Element class allows for an extra attribute to be added. Here a version attribute is added to document the MODS version number.

All of the sub-elements moving forward will now inherit the MODS namespace declared in the root element. The script can be designed to either read directly from the DataFrame or supply templated information as the MODS records are built. Building out the tree structure is simple: create a variable, use the etree.SubElement() builder, specify the parent element in the parent parameter, and add the element’s name and any attributes. Add text for elements using the .text method. Here’s how data for the compiler of the collection is added under mods:name:

| 1  2  3 | `name_a ``=` `etree.SubElement(mods, ``'name'``, ``type``=``'personal'``)`  `namePart_a ``=` `etree.SubElement(name_a, ``'namePart'``)`  `namePart_a.text ``=` `'Skinner, David M., 1921-2009'` |
| --- | --- |

Similar operations are performed to supply templated data for mods:typeOfResource, mods: physicalDescription, mods:note, mods:subject (geographic terms), mods:physicalLocation and mods:recordInfo.

Incorporating data from the DataFrame is just as easy. Again use the SubElement() builder and .text method as shown above, then reference the DataFrame column name with the series iteration variable.

| 1  2 | `identifier_d ``=` `etree.SubElement(mods, ``'identifier'``, ``type``=``'local'``, displayLabel``=``'File name'``)`  `identifier_d.text ``=` `series[``'Filename'``]` |
| --- | --- |

Pandas provides many different options for slicing and selecting data (Indexing and Selecting Data 2016). One basic approach for this is shown below. For dealing with subjects in the data set, a subset of three columns is sliced using the .loc method. The three values are then iterated through for insertion into the record. Cell values are selected using the series variable used throughout the script.

| 1  2 | `for` `i ``in` `df.loc[:, ``'Subject 1'``:``'Subject 3'``]:       `  `topical_term ``=` `series[i]` |
| --- | --- |

An if clause is set up to do nothing if the cell is blank. Otherwise subjects and identifiers are split at the pipe delimiter. Identifiers are concatenated with the appropriate URI prefix to create the valueURI value. Note that a special scenario (not shown here) had to be handled separately since one term from the pre-selected list of subject headings came from the FAST vocabulary instead of the LCTGM.

| 1  2  3  4  5  6  7  8  9  10 | `if` `topical_term ``=``=` `'nan'``:`  `topical_term ``=` `''`  `else``: `  `subject ``=` `etree.SubElement(mods, ``'subject'``, authority ``=` `'lctgm'``,         authorityURI``=``authority_URI)`  `subject_data ``=` `topical_term.split(``'\|'``)`  `subject_data ``=` `[i.strip(``' '``) ``for` `i ``in` `subject_data]`  `topic ``=` `etree.SubElement(subject, ``'topic'``, valueURI``=``authority_URI ``+` `subject_data[``1``])`  `topic.text ``=` `subject_data[``0``]` |
| --- | --- | --- |

The script imports Python’s datetime module to include today’s date in the mods:recordCreation subelement. The date.today() function returns today’s date, then it’s formatted as a string according to the extended date time format.

| 1  2 | `today ``=` `dt.datetime.today().strftime(``'%Y-%m-%d'``)    `  `recordCreationDate.text ``=` `today` |
| --- | --- |

Once the entire tree is built, the script creates a file object and writes the record out using the tostring() function.

| 1  2 | `with ``open``(filename ``+``'.xml'``, ``'wb'``) as f:`  `f.write(etree.tostring(mods, xml_declaration``=``True``, encoding``=``'utf-8'``, pretty_print``=``True``))` |
| --- | --- |

## Assessment and Conclusion

The project surpassed original expectations for fast and efficient cataloging of the photographs in the collection. At the project’s outset, 4000 objects were described by two non full-time metadata assistants in just over a month. It was difficult to keep up with quality control, and the students, who had been hired for an entire semester, had to be given additional tasks since they caught up with the digitization workflow.

At first pass, the LCTGM subset appears to facilitate this rapid description process while providing facets that are useful for winnowing down the collection into manageable groupings. The consistent themes shown throughout the collection (e.g. Sports, Classrooms, Students, etc.) certainly lend themselves to this approach. The MAD team plans to solicit testing and perspective from the Library’s UX team in this area to determine what users think of the indexing strategy in comparison to more precise compound headings. Future digital conversion indexing projects can be calibrated based on this feedback. In the thick of the actual work, it is worth noting how willing students are to access the LCTGM themselves and navigate its straightforward display to suggest additional categories to be incorporated into the sub-set. Students feel comfortable with the terminology and are engaged in the development of the mini-vocabulary.

Google Sheets was an excellent option for sharing and enhancing metadata sets. This was especially true in a university setting where collaborators were dispersed across physical space. Editable links could be sent by email and sheets were easily viewed and edited by users simultaneously. This was very helpful for the peer-review and QC processes. The workflow wasn’t perfect though. One significant pain point were the challenges recognized early on of pushing and pulling CSV data to the cloud and back. Google sheets and Excel try very hard to do users a favor by formatting and remediating values. Leading zeros in folder names or any kind of date data are prime examples. Readers might have noticed that single quotes are added to the front of date strings in Python to force these tools to leave this data as it is. Leading zeros in folder names proved even more challenging and required the addition of a textual string and further indexing when being read to XML. Future efforts will focus on the Google Sheets API to avoid such issues and eliminate the step of downloading data before it’s transformed.

Pandas can be used as an effective tool for baseline tabular library metadata clean-up. Many resources are available for support in the Stackoverflow community, the pandas module documentation, online tutorials, and published books. The first script covered here automates the consistent manipulation of like datasets including adding, removing, renaming and splitting columns, and remediating date information. This approach saved significant time compared to documenting and executing a series of steps for cleaning up this data manually. Pandas also paired up well with lxml in providing a straightforward way of reading data from a DataFrame. In comparison to pandas, OpenRefine stands out in terms of its cluster functionality for correcting typos and its straightforward RDF extension for reconciling terms with published LOD vocabularies (although Python has robust tools for working with both RDF and web data in general). A nice template is available for exporting data to MODS from OpenRefine (Allain 2014). Perhaps Python users will find the code shared in this article of similar value.

Lxml is a tool that metadata librarians and archivists should have on their radar screen. The power is in the ElementTree API’s almost too-easy syntax for building and transforming XML data. It would be interesting to read feedback about using a tool like this as a full blown replacement for XSLT for tasks such as legacy metadata remediation projects or other scenarios for transforming XML. If nothing else, the pros and cons of XSLT vs. a Pythonic (or any other high-level language) approach for standard library metadata-related XML tasks would be an interesting discussion.

Looking forward within U.Va.’s MAD team, the plan is to build on experiences from this project and push on. There is potential, for example, for using pandas to merge metadata sets for analysis and visualization along the lines demonstrated in a recent code4lib article (Harper 2016). For streamlined description, the use of FAST headings shows great potential similar to the workflow covered here as has been demonstrated in comments during a recent ALCTS webinar (Pastva and Odell 2016). While keeping an eye on such trends team members will focus on cross-departmental collaboration and look for creative opportunities to develop and apply technical skills where appropriate. Metadata project design and management will emphasize sustainable description strategies and the necessary tools and skills to meet or even outpace future library digitization workflows.

## References

10 minutes to pandas. Pandas 0.19.1 documentation \[Internet\]. \[Updated 2016 Nov 3\]. \[Cited 2016 Nov 29\]. Available from: [http://pandas.pydata.org/pandas-docs/stable/10min.html](http://pandas.pydata.org/pandas-docs/stable/10min.html)

Allain, S. 2014. Converting spreadsheets into MODSXML using Open Refine. UTSC Library Digital Scholarship Unit admin’s blog \[Internet\]. \[Cited 2016 Nov 29\]. Available from: [https://www.utsc.utoronto.ca/digitalscholarship/content/blogs/converting-spreadsheets-modsxml-using-open-refine](https://www.utsc.utoronto.ca/digitalscholarship/content/blogs/converting-spreadsheets-modsxml-using-open-refine)

Boyle, W. 2015. Tools for the programming archivist: EAD manipulation with Python and lxml \[Internet\]. \[Cited 2016 Dec 14\]. Available from: [http://archival-integration.blogspot.com/2015/10/tools-for-programming-archivist-ead.html](http://archival-integration.blogspot.com/2015/10/tools-for-programming-archivist-ead.html)

Cataloging & digitizing toolbox \[Internet\]. \[Updated 2010 Oct 22\]. \[Cited 2016 Nov 29\]. Available from: [http://www.loc.gov/rr/print/cataloging.html#tips](http://www.loc.gov/rr/print/cataloging.html#tips)

Clark, J. XML namespaces \[Internet\]. \[Updated 1999 Feb 4\]. \[Cited 2016 Nov 29\]. Available from: [http://www.jclark.com/xml/xmlns.htm](http://www.jclark.com/xml/xmlns.htm)

Comparison with R/R libraries. Pandas 0.19.1 documentation \[Internet\]. \[Updated 2016 Nov 3\]. \[Cited 2016 Nov 29\]. Available from: [http://pandas.pydata.org/pandas-docs/stable/comparison\_with\_r.html](http://pandas.pydata.org/pandas-docs/stable/comparison_with_r.html)

Harper, CA. 2016. Metadata analytics,visualization, and optimization: experiments in statistical analysis of the Digital Public Library of America (DPLA). Code4lib \[Internet\]. \[Cited 2016 Nov 29\]; Issue 33. Available from: [http://journal.code4lib.org/articles/11752](https://journal.code4lib.org/articles/11752)

Indexing and selecting data. Pandas 0.19.1 documentation \[Internet\]. \[Updated 2016 Nov 3\]. \[Cited 2016 Nov 29\]. Available from: [http://pandas.pydata.org/pandas-docs/stable/indexing.html](http://pandas.pydata.org/pandas-docs/stable/indexing.html)

McKinney, W. Python for Data Analysis \[Internet\]. Beijing: O’Reilly, 2013 \[cited 2016 Nov 29\]. Available from [http://proquest.safaribooksonline.com/book/programming/python/9781449323592/5dot-getting-started-with-pandas/id2828378](http://proquest.safaribooksonline.com/book/programming/python/9781449323592/5dot-getting-started-with-pandas/id2828378)

Pastva, J, O’Dell, AJ. 2016. Using FAST for faster workflows and discovery. Association for Library Collections & Technical Services Webinar. \[Cited 2016 Nov 29\]. Available from: [http://www.ala.org/alcts/confevents/upcoming/webinar/092816](http://www.ala.org/alcts/confevents/upcoming/webinar/092816)

## About the Authors

Jeremy Bartczak (jtb4t@virginia.edu) is a Metadata Librarian at the University of Virginia Library.

Ivey Glendon (img7u@virginia.edu) is the manager for the Metadata Analysis and Design team at the University of Virginia Library.
---
title: "Leveraging a Custom Python Script to Scrape Subject Headings for Journals"
source: "https://journal.code4lib.org/articles/16080"
author:
  - "Shelly R. McDavid"
  - "Eric McDavid"
  - "Neil E. Das"
published: 2021-09-22
created: 2025-01-10
description: "In our current library fiscal climate with yearly inflationary cost increases of 2-6+% for many journals and journal package subscriptions, it is imperative that libraries strive to make our budgets go further to expand our suite of resources. As a result, most academic libraries annually undertake some form of electronic journal review, employing factors such as cost per use to inform budgetary decisions. In this paper we detail some tech savvy processes we created to leverage a Python script to automate journal subject heading generation within the OCLC’s WorldCat catalog, the MOBIUS (A Missouri Library Consortium) Catalog, and the VuFind Library Catalog, a now retired catalog for the CARLI (Consortium for Academic and Research Libraries in Illinois). We also describe the rationale for the inception of this project, the methodology we utilized, the current limitations, and details of our future work in automating our annual analysis of journal subject headings by use of an OCLC API."
tags:
  - "#Python"
  - "#subject/headings"
  - "#scrapping"
  - "#academic/journals"
  - "#OCLC/API"
---
# Leveraging a Custom Python Script to Scrape Subject Headings for Journals
Shelly R. McDavid, Eric McDavid, Neil E. Das

In our current library fiscal climate with yearly inflationary cost increases of 2-6+% for many journals and journal package subscriptions, it is imperative that libraries strive to make our budgets go further to expand our suite of resources. As a result, most academic libraries annually undertake some form of electronic journal review, employing factors such as cost per use to inform budgetary decisions. In this paper we detail some tech savvy processes we created to leverage a Python script to automate journal subject heading generation within the OCLC’s WorldCat catalog, the MOBIUS (A Missouri Library Consortium) Catalog, and the VuFind Library Catalog, a now retired catalog for the CARLI (Consortium for Academic and Research Libraries in Illinois). We also describe the rationale for the inception of this project, the methodology we utilized, the current limitations, and details of our future work in automating our annual analysis of journal subject headings by use of an OCLC API.

## Introduction

In the past, renewal of journal and journal package subscriptions at Lovejoy Library at Southern Illinois University Edwardsville (SIUE) had been piecemeal, with each decision referencing metrics specific to that purchase alone in isolation from others. The two principal factors considered were percentage price increase over the previous year and cost per use. If the percentage price increase could be kept below roughly 4-5% and cost per use per journal article kept below the rate of ordering articles through delivery services such as ILLiad and Get It Now, then the journal or journal package was renewed. Regarding the process, the renewal price and statistical analysis were provided by the Electronic Resources Librarian to individual subject librarians who made the final decisions on renewals. In this system, cross-disciplinary analysis of journal subscriptions occurred only to ensure that a resource was not being paid for more than once. There was no more granular analysis, especially analysis based on the subject content of journals. Our project originated in the spring of 2019, with the goal of generating subject heading data for the journals we subscribed to at Lovejoy Library at SIUE. The desired outcome of the project was detailed analysis and education of library liaisons and campus faculty about the journal’s subscriptions in their disciplines, including usage data, cost per use, and potential alternate Open Educational Resources (OER) or Open Access (OA) resources or less costly comparable product replacements. Principal author Shelly McDavid had seen a similar model in action in her previous library and wanted to apply it to collection development and annual portfolio reviews of collections by LIS for campus disciplines at SIUE as well.

## Background

At LIS at SIUE, we had not been in the practice of identifying subject headings of electronic resources to which we subscribed, nor did we perform any type of discipline specific journal usage analysis. These were the goals of this project, with an eye to such analysis serving as the basis of annual portfolio reviews to present to campus faculty and administrators. In fall 2020, the LIS Lovejoy Library Collections Analysis & Strategy Committee was formed to work toward these goals.

## Subject Scraper Methodology

The principal problem addressed in this project was to collect specific metadata for a group of ISSN numbers in an efficient, systematic way across different library catalogs. The solution was to create a Python (v3.7.1) script which makes an HTTPS request to the catalog search engine for the ISSN number and parses the HTML search results to gather the relevant metadata for that ISSN. The script was designed to be used from the command prompt and allows for a single ISSN search or a batch search by passing in a CSV file. One of the required positional arguments is a catalog name: worldcat, carli\_i-share, or mobius.

![](https://journal.code4lib.org/media/issue52/mcdavid/Figure1.png)  
**Figure 1.** Output from running “python subjectscraper.py -h”.

## Catalog Parameters

One feature of the script was to allow for flexibility in choosing the catalog for which the search is to be conducted, as only one catalog can be searched at a time. Since each library web catalog is formatted in different ways with different HTML structures and CSS styles, a Python dictionary data structure was created so the script could operate in a systematic way regardless which catalog was chosen. This dictionary was defined for each catalog and included the following parameters:

- - - **base\_url** – The beginning part of the catalog search URL, starting from https:// and ending before the first / e.g., “https://www.worldcat.org”.
- **search\_url** – This is the rest of the catalog search URL without the base\_url, this is parameterized with a “{0}” for the ISSN to search for e.g., “/search?qt=worldcat\_org\_all&q={0}”.
- **search\_title** – CSS selector for the parent HTML element that contains the ISSN title on the search results page.
- **bib\_record** – CSS selector for the HTML element that contains the record metadata on the catalog item’s page.
- **bib\_title** – CSS selector for parent HTML anchor element containing the item title on the catalog item’s page.
- **bib\_subjects** – the HTML table element where the text begins with “Topics” or “Subject” in the catalog item’s page in context of bib\_record.

The script as written supported WorldCat, MOBIUS Library Catalog, and CARLI’s VUFind Library Catalog, but more catalogs could also be searched by defining the above parameters for a specific library catalog. The parameters do require extensive knowledge of how HTML elements and CSS styles work and function.

## Process

Regardless of whether the script is running in single or batch mode, the process of searching for an ISSN is the same and involves two URL requests for a single ISSN:

1. Search the catalog for the ISSN and get the URL for the catalog item.
2. If the catalog item URL is valid, search the catalog item’s page for relevant metadata.
3. Output or write to disk the metadata and search criteria.

The script does not work for every ISSN and will give informative errors for any failure involved in the above steps.

One complication when sending URL requests to web servers is that there must be a time delay between requests, otherwise the server will assume that it is being spammed and deny the request. So, every URL request is preceded by a time delay of half a second.

## Output

If the script is running in single ISSN mode, the output is sent to the screen. This output includes the ISSN that was searched for, the catalog item URL, the item title, and the list of subjects that are in the record for the item.

![](https://journal.code4lib.org/media/issue52/mcdavid/Figure2.png)  
**Figure 2.** Output from running subjectscraper in single mode.

In batch ISSN mode, a CSV output file is created in the current working directory with the chosen catalog name appended to the file name i.e., “batch\_output\_worldcat.csv”. This output file will contain the same output from above but for all ISSNs listed in the input file. Some ISSNs will produce errors when searching, and for those the URL, title, or subjects may be blank. The script will also show a progress bar when in batch mode to inform the user about the approximate time to completion.

## External Libraries

The script uses the following external Python libraries:

- - - urllib.request.urlopen – this is how the URL request is made.
- bs4.BeautifulSoup – this is an HTML parser that operates on the results from the URL request.
- tqdm.tqdm – this is the progress bar when running in batch mode.

## Source Code – subjectscraper.py

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99  100  101  102  103  104  105  106  107  108  109  110  111  112  113  114  115  116  117  118  119  120  121  122  123  124  125  126  127  128  129  130  131  132  133  134  135  136  137  138  139  140  141  142  143  144  145  146  147  148  149  150  151  152  153  154  155  156  157  158  159  160 | `from` `urllib.request ``import` `urlopen `  `from` `bs4 ``import` `BeautifulSoup `  `from` `tqdm ``import` `tqdm `  `import` `re, argparse, sys, csv, time `  `catalogs ``=` `{ `  `'worldcat'` `: { `  `'search_url'` `: ``"/search?qt=worldcat_org_all&q={0}"``, `  `'search_title'` `: ``".result.details .name"``, `  `'bib_record'` `: ``"div#bibdata"``, `  `'bib_title'` `: ``"div#bibdata h1.title"``, `  `'bib_subjects'` `: ``"th"`  `}, `  `'carli_i-share'` `:  { `  `'search_url'` `: ``"/all/vf-sie/Search/Home?lookfor={0}&type=isn&start_over=0&submit=Find&search=new"``, `  `'search_title'` `: ``".result .resultitem"``, `  `'bib_record'` `: ``".record table.citation"``, `  `'bib_title'` `: ``".record h1"``, `  `'bib_subjects'` `: ``"th"`  `}, `  `'mobius'` `: { `  `'search_url'` `: ``"/iii/encore/search/C__S{0}%20__Orightresult__U?lang=eng&suite=cobalt"``, `  `'search_title'` `: ``".dpBibTitle .title"``, `  `'bib_record'` `: ``"table#bibInfoDetails"``, `  `'bib_title'` `: ``"div#bibTitle"``, `  `'bib_subjects'` `: ``"td"`  `} `  `} `  `def` `get_catalog_params(catalog_key): `  `try``: `  `return` `catalogs[catalog_key] `  `except``: `  `print``(``'Error - unknown catalog %s'` `%` `catalog_key) `  `def` `search_catalog (issn, p ``=` `catalogs[``'carli_i-share'``]): `  `title_url ``=` `None`  `url ``=` `p[``'base_url'``] ``+` `p[``'search_url'``].``format``(issn) `  `u ``=` `urlopen (url) `  `try``: `  `html ``=` `u.read().decode(``'utf-8'``) `  `finally``: `  `u.close() `  `try``: `  `soup ``=` `BeautifulSoup (html, features``=``"html.parser"``) `  `title ``=` `soup.select(p[``'search_title'``])[``0``] `  `title_url ``=` `title.find(``"a"``)[``'href'``] `  `except``: `  `print``(``'Error - unable to search catalog by ISSN'``) `  `return` `title_url `  `return` `p[``'base_url'``] ``+` `title_url `  `def` `scrape_catalog_item(url, p ``=` `catalogs[``'carli_i-share'``]): `  `result ``=` `{``'title'``:``None``, ``'subjects'``:``None``} `  `u ``=` `urlopen (url) `  `try``: `  `html ``=` `u.read().decode(``'utf-8'``) `  `finally``: `  `u.close() `  `try``: `  `soup ``=` `BeautifulSoup (html, features``=``"html.parser"``) `  `try``: `  `title ``=` `soup.select_one(p[``'bib_title'``]).contents[``0``].strip() `  `result[``"title"``] ``=` `title `  `except``: `  `print``(``'Error - unable to scrape title from url'``) `  `try``: `  `record ``=` `soup.select_one(p[``'bib_record'``]) `  `subject ``=` `record.find_all(p[``'bib_subjects'``], string``=``re.``compile``(``"(Subjects*\|Topics*)"``))[``0``] `  `subject_header_row ``=` `subject.parent `  `subject_anchors ``=` `subject_header_row.find_all(``"a"``) `  `subjects ``=` `[] `  `for` `anchor ``in` `subject_anchors: `  `subjects.append(anchor.string.strip()) `  `result[``"subjects"``] ``=` `subjects `  `except``: `  `print``(``'Error - unable to scrape subjects from url'``) `  `except``: `  `print``(``'Error - unable to scrape url'``) `  `return` `result `  `def` `get_issn_data(issn, p ``=` `catalogs[``'carli_i-share'``]): `  `results ``=` `{``'issn'``:issn, ``'url'``:``None``, ``'title'``:``None``, ``'subjects'``:``None``} `  `time.sleep(time_delay) `  `url ``=` `search_catalog(issn, params) `  `results[``'url'``] ``=` `url `  `if` `url: `  `time.sleep(time_delay) `  `item_data ``=` `scrape_catalog_item(url, params) `  `results[``'title'``] ``=` `item_data[``'title'``] `  `if` `item_data[``'subjects'``] ``is` `not` `None``: `  `results[``'subjects'``] ``=` `','``.join(item_data[``'subjects'``]).replace(``', -'``, ``' - '``) `  `return` `results `  `time_delay ``=` `0.5`  `try``: `  `args ``=` `sys.argv[``1``:] `  `parser ``=` `argparse.ArgumentParser(description``=``'Scrape out metadata from online catalogs for an ISSN'``) `  `parser.add_argument(``'catalog'``, ``type``=``str``, choices``=``(``'worldcat'``, ``'carli_i-share'``, ``'mobius'``), ``help``=``'Catalog name'``) `  `parser.add_argument(``'-b'``, ``'--batch'``, nargs``=``1``, metavar``=``(``'Input CSV'``), ``help``=``'Run in batch mode - processing multiple ISSNs'``) `  `parser.add_argument(``'-s'``, ``'--single'``, nargs``=``1``, metavar``=``(``'ISSN'``), ``help``=``'Run for single ISSN'``) `  `args ``=` `parser.parse_args() `  `params ``=` `get_catalog_params(args.catalog) `  `if` `args.single ``is` `not` `None``:  `  `issn ``=` `args.single[``0``] `  `r ``=` `get_issn_data(issn, params) `  `print``(``'ISSN: {0}\r\nURL: {1}\r\nTitle: {2}\r\nSubjects: {3}'``.``format``(r[``'issn'``], r[``'url'``], r[``'title'``], r[``'subjects'``])) `  `elif` `args.batch ``is` `not` `None``:  `  `input_filename ``=` `args.batch[``0``] `  `output_filename ``=` `'batch_output_{0}.csv'``.``format``(args.catalog) `  `with ``open``(input_filename, mode``=``'r'``) as csv_input, ``open``(output_filename, mode``=``'w'``, newline``=``'``', encoding='``utf``-``8``') as csv_output: `  `read_in ``=` `csv.reader(csv_input, delimiter``=``','``) `  `write_out ``=` `csv.writer(csv_output, delimiter``=``','``, quotechar``=``'"'``, quoting``=``csv.QUOTE_MINIMAL) `  `write_out.writerow([``'ISSN'``, ``'URL'``, ``'Title'``, ``'Subjects'``]) `  `total_rows ``=` `sum``(``1` `for` `row ``in` `read_in) `  `csv_input.seek(``0``) `  `read_in ``=` `csv.reader(csv_input, delimiter``=``','``) `  `for` `row ``in` `tqdm(read_in, total``=``total_rows): `  `issn ``=` `row[``0``] `  `r ``=` `get_issn_data(issn, params) `  `write_out.writerow([r[``'issn'``], r[``'url'``], r[``'title'``], r[``'subjects'``]]) `  `except` `Exception as e: `  `print``(e) ` |
| --- | --- | --- |

## Limitations

While there are many limitations to this project, one glaring limitation is that typically subject headings are generated and assigned by a human, and this equates to the possibility of human error. We were hopeful to norm our subject heading data by generating and comparing data from three sources. However, the VuFind Catalog has been retired requiring us to update the subject scraper script for the new CARLI I-Share Catalog, something we have not done at this time.

Another factor impacting the task of scraping subject headings from library catalogs is that many servers, like the one for OCLC’s Worldcat, can only be pinged 999 times in a 24-hour period from the same IP address. This is a common practice for servers. Therefore, when needing to scrape over a few thousand subject headings this work must be parsed out over a series of days.

## Future Work

At the time we completed this project, LIS at SIUE did not have the structure in place to apply the goals of this project into real world action. However, in the summer of 2020, a new dean took over leadership at LIS and established the Collection Analysis and Strategy Committee that fall. A stated yearly goal of this committee is to create “a data driven approach to collection development with analysis of annual usage data, cost per use data, and, when applicable, journal impact factor data.” And additionally, “the library presents its objective view of potential cuts and engages the academic department faculty in a conversation about departmental needs, related to curriculum and research agendas.”\[[1](https://journal.code4lib.org/articles/#note1)\]

However, our future work of analyzing subject headings in journal collections will not rely on the custom developed Python Web Scraper code that we describe in this article. OCLC has since developed an experimental API (Application Programming Interface) called FAST API. “FAST is an acronym for Faceted Application of Subject Terminologies for subject headings data” (Fast API \[updated 2021\]).\[[2](https://journal.code4lib.org/articles/#note2)\] Now we will leverage this API to generate subject headings to aid in our electronic journal usage analysis by subject for collection development and to create annual portfolio reviews for campus departments.

One specific area of possible future work is the analysis of our large journal packages from major publishers. This aspirational goal is inspired by the ideas of Nabe and Fowler in “Leaving the ‘Big Deal’… Five Years Later” (Nabe and Fowler 2015).\[[3](https://journal.code4lib.org/articles/#note3)\] Understanding the subject compositions of these massive databases would be a key tool in assessing whether we might replace these costly subscriptions with more targeted options. This would certainly aid in achieving the goals of maximizing ROI on journal expenditures and creating departmental portfolio reviews

## Conclusions

This project was valuable in two major ways, both of which set the stage for the processes that will allow LIS at SIUE to get the most out of our journal and database subscriptions going forward. First, the idea to analyze journal collections by subject headings in addition to cost per use, itself, anticipated the work that has been taken up by the Collection Analysis and Strategy Committee. This will allow for far more granular analysis of our renewals and is a foundational concept in the creation of discipline-based portfolio reviews for university departments. Second, examining the architecture of the three library catalogs, writing the Python script, and testing and correcting errors provided an understanding of the quality and extent of the subject heading metadata of academic journals. This knowledge will be invaluable as we now employ and assess the usefulness of the API from OCLC in accomplishing the same tasks as our Python script. However, we are hopeful that the script and processes described in this article may provide a low-cost pathway for others to analyze their own journal collections, if only as an experiment or as a first step in the journey toward more robust journal usage and subject analysis.

Code Availability – GitHub [https://github.com/smcdavi/subjectscraper.py/blob/master/subjectscraper.py](https://github.com/smcdavi/subjectscraper.py/blob/master/subjectscraper.py)

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] McDavid, S. \[2020\]. Library and Information Services Collection Committee Proposal. Edwardsville (IL): Southern Illinois University Edwardsville; \[Cited 2021 July 31\].

\[[2](https://journal.code4lib.org/articles/#ref2)\] Fast API \[Internet\]. \[Updated 2021\]. Dublin (OH): OCLC. \[cited 2021 Jul 15\]. Available from https://platform.worldcat.org/api-explorer/apis/fastapi

\[[3](https://journal.code4lib.org/articles/#ref3)\] Nabe J, Fowler, D. \[2015\]. Leaving the “Big Deal” … Five Years Later. The Serials Librarian \[Internet\]. \[cited 2021 Jul 15\];69(1): 20-28. Available from https://www.tandfonline.com/doi/full/10.1080/0361526X.2015.1048037

*Shelly R. McDavid* has been STEM Librarian (since February 2019) and Area Coordinator for Access & Library Spaces (since January 2021) at Southern Illinois University Edwardsville in Edwardsville, Illinois. Her research interests include evidence-based and data-driven decision making for assessment of library collections, data, instruction, operations, resource sharing, services, and spaces in libraries, institutional repositories, scholarly communications, and open educational resources.

Author email: [smcdavi@siue.edu](https://journal.code4lib.org/articles/)

*Eric McDavid* is a Programmer/Analyst who works with the Center for Health Policy at the University of Missouri.

Author email: [mcdavide@missouri.edu](https://journal.code4lib.org/articles/)

*Neil E. Das* has been Electronic Resources Librarian at Southern Illinois University Edwardsville in Edwardsville, Illinois since January 2019. His research interests include student and faculty research behavior in the use of library discovery layers, library provided databases, and Google Scholar.

Author email: [nedas@siue.edu](https://journal.code4lib.org/articles/)
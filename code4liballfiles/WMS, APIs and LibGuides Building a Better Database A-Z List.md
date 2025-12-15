---
title: "WMS, APIs and LibGuides: Building a Better Database A-Z List"
source: "https://journal.code4lib.org/articles/13688"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-08-09
created: 2025-01-10
description: "At the American University of Sharjah, our Databases by title and by subject pages are the 3rd and 4th most visited pages on our website. When we changed our ILS from Millennium to OCLC’s WorldShare Management Services (WMS), our previous automations which kept our Databases A-Z pages up-to-date were no longer usable and needed to [...]"
tags:
  - "clippings"
---
# WMS, APIs and LibGuides: Building a Better Database A-Z List
Veronica Ramshaw, Véronique Lecat, Thomas Hodge

At the American University of Sharjah, our Databases by title and by subject pages are the 3rd and 4th most visited pages on our website. When we changed our ILS from Millennium to OCLC’s WorldShare Management Services (WMS), our previous automations which kept our Databases A-Z pages up-to-date were no longer usable and needed to be replaced. Using APIs, a Perl script, and LibGuides’ database management interface, we developed a workflow that pulls database metadata from WMS Collection Manager into a clean public-facing A-Z list. This article will discuss the details of how this process works, the advantages it provides, and the continuing issues we are facing.

The database A-Z list is a staple of many academic libraries’ online presences, allowing students and faculty to quickly see which familiar databases are available and to directly access specific resources. Traditionally, our own database A-Z list has existed as two pages fed by the same XML document: Databases by Title and Databases by Subject. According to our site’s Google Analytics, these database pages are very important to our users as they represent the third and fourth most visited pages on our website.

After the American University of Sharjah (AUS) Library migrated its Integrated Library System (ILS) and discovery interface to OCLC WorldShare Management System (WMS) in 2016, we needed to find a new way to synchronize database data. This article will outline how we automated this process using WMS APIs and LibGuides.

## Old procedure

Prior to 2016, the flow of information from our Millennium system to the two database pages was automated. Millennium Resource and License records contained the necessary metadata such as database name, description, URL, and subject keywords. The data was harvested from a list of all Resource and License record numbers via /xrecord, a facility of Millennium’s public access catalog that displayed the records in XML format. A script harvested these records into a Dublin Core XML serialized file. This was done whenever changes were made to the Resource or License records. The resulting file, titled databases.xml, was then placed on our website’s server where the two public database pages, Databases by Title and by Subject, would be dynamically generated from that data.

In this way, we were able to synchronize the database information stored in Millennium to the pubic database pages, ensuring information was kept up-to-date and consistent.

## After the WMS Migration

In 2015, the AUS Library began the process of migrating from Millennium to WMS and in 2016 had stopped using Millennium completely. These changes meant it was no longer possible to generate our public database pages using the old procedure. As a result, any changes to the details of a database, such as a new name, modified URL, or updated description, had to be changed manually in WMS Collection Manager, and in the databases.xml file. In addition to the amount of time this took, the duplication of work and dependence on manual changes created the potential for human error to introduce inconsistencies between the systems.

Our new discovery interface, WorldCat Discovery, does provide a list of active collections through the A-Z Titles interface, so we considered it as potential replacement for our Database A-Z. Unfortunately this tool has a number of problems. The largest problem is the sheer volume of duplication due to the fact that it lists every collection your library has activated in WMS Collection Manager. For example, we have almost 200 individual collections of Springer eBooks for each year and each subject we’ve purchased (Springer Behavioral Science and Psychology eBooks 2016, Springer Behavioral Science and Psychology eBooks 2017, Springer Economics and Finance eBooks 2017, and so on) which makes for a cumbersome list to browse through. Another problem is that we have a number of collections active in Collection Manager that we wouldn’t consider databases. For example, we have access to a handful of journals from the University of Chicago Press from individual subscriptions, but this is far to small to be considered a database. These problems made WorldCat Discovery’s Journal Finder interface too cluttered and unwieldy to a useful replacement for our Database A-Z list.

## Finding a New Way

Our goals for a new database A-Z list were that it should:

- **Be Automated:** To reduce the duplication of work and possibility of human error.
- **Be Clean:** Human readable with no duplicate content cluttering out the useful information.
- **Be Consistent:** Every platform (website, LibGuides, discovery interface) should have the same metadata. Users should see the same names for the same databases across every library platform to minimize confusion.
- **Maintain Continuity:** Similarities between the old A-Z database pages and the new one should help avoid user disorientation in the transition.

To begin we needed to get a thorough understanding of now WMS handles database data. It does this through two different modules: Collection Manager and License Manager. Collection Manager contains the metadata about the database (e.g. description, URL) as well as a list of every ejournal or ebook contained in the database and the date range covered. License Manager handles the renewal dates, prices, terms of use, and allows us to upload renewal documentation.

Next, we looked at using the LibGuides Database A-Z tool. For those unfamiliar with the product, LibGuides is used to make Subject and Course specific guides to library resources. Since our initial purchase of the LibGuides system, the vendor SpringShare added a public-facing Database A-Z, however we did not have any use for it up to this point because we were already generating our own Database A-Z from data harvested from Millennium. With this project, we decided to use the LibGuides Database A-Z page to replace our existing database lists. For the sake of clarity, in this article we will refer to it as the LibGuides Database A-Z.

## New procedure

The following is an outline of how our new procedure works. It is divided into three sections: (1) The preparation work that needs to be done in WMS and LibGuides before the script is run ; (2) Running the script which exports database metadata from WMS License Manager and Collection Manager ; and (3) Loading the resulting file to LibGuides.

1. Preparation
1. WMS License Manager
1. License statuses must be Current (as opposed to Expired or Pending)
2. Licenses must contain the correct linked collections \[see Figure 1\]
2. WMS Collection Manager
1. Select a representative collection for each database. For example, we have 3 separate collections for ProQuest Ebook Central: our main subscription, our DDA subscription, and our perpetually owned titles. We selected one of these, our main collection, as the representative collection. This prevents unnecessary duplication in the database list.
2. Ensure the collection title is appropriate. This can be locally customized by the library. For example, we renamed Ebook Central Academic Complete as ProQuest Ebook Central
3. Ensure the collection has description text
4. Verify the Collection URL is correct
5. Include the LibGuides content\_id in the staff note field
6. Include the subject heading(s) in the staff note field \[see Figure 2\]
3. LibGuides
1. Clean up the existing database list in LibGuides. In our case, we had a lot of links that were saved as databases in LibGuides that we either changed to link assets, or deleted completely.
2. Ensure each database is saved in LibGuides and is assigned a content\_id. The script only updates existing database assets, it does not create new ones.
3. Classify the Database Type as Abstract-only or Full-text, as needed.
2. Running the script \[see Figure 3\]
1. Using the OCLC License Manager API, the script runs through all our licenses. For every license, it gets the license status (Current, Expired, or Pending) and the list of linked collections.
2. Using the OCLC Collection Manager API, the script provides the details of the collections linked to the licenses, such as name, description, URL, proxy yes/no, content\_id, and subject headings.
3. The script searches for the linked collections via the Collection Manager API.
4. It creates a brief delimited record for each license or collection which should be included in the A-Z list.
5. It outputs a tab-delimited .txt file \[see Figure 4\]
3. Loading to LibGuides
1. Check the tab-delmited .txt file to ensure data integrity.
2. Go to LibGuides > Content > A-Z Database List
3. Click “Import / Update Databases” and upload the file.
4. All changes made in Collection Manager are now synced to the LibGuides Database A-Z \[see Figure 5\]

[![Figure 1. License of ProQuest Ebook Central contains three linked collection. The script will look at the collections linked in every current license.](https://journal.code4lib.org/media/issue41/ramshaw/image1-small.png)](https://journal.code4lib.org/media/issue41/ramshaw/image1.png)  
**Figure 1.**  
License of ProQuest Ebook Central contains three linked collection. The script will look at the collections linked in every current license.

[![Figure 2. Collection for ProQuest Ebook Central where we added a Description paragraph. In the Staff note field, we added a content_id that links it to it’s corresponding LibGuides database asset. We also added subject headings.](https://journal.code4lib.org/media/issue41/ramshaw/image2-small.png)](https://journal.code4lib.org/media/issue41/ramshaw/image2.png)  
**Figure 2.**  
Collection for ProQuest Ebook Central where we added a Description paragraph. In the Staff note field, we added a content\_id that links it to it’s corresponding LibGuides database asset. We also added subject headings.

[![Figure 3. The internal steps of the script which exports database metadata using the License Manager API and Collection Manager API, and outputs it as a tab-delimited file.](https://journal.code4lib.org/media/issue41/ramshaw/image3-small.png)](https://journal.code4lib.org/media/issue41/ramshaw/image3.png)  
**Figure 3.**  
The internal steps of the script which exports database metadata using the License Manager API and Collection Manager API, and outputs it as a tab-delimited file.

[![Figure 4. Script output (.txt file imported into Excel)](https://journal.code4lib.org/media/issue41/ramshaw/image4-small.png)](https://journal.code4lib.org/media/issue41/ramshaw/image4.png)  
**Figure 4.** Script output (.txt file imported into Excel)

[![Figure 5. Our new Database A-Z page. Users can filter by subject or database type (abstract-only or full-text).](https://journal.code4lib.org/media/issue41/ramshaw/image5-small.png)](https://journal.code4lib.org/media/issue41/ramshaw/image5.png)  
**Figure 5.** Our new Database A-Z page. Users can filter by subject or database type (abstract-only or full-text).

## Pseudo Script

This Perl code snippet represents the core function of the script. The full script is available at: [https://github.com/hodgenet/OCLC-LibGuides-Integration](https://github.com/hodgenet/OCLC-LibGuides-Integration)

Access to the Perl authenication modules is available by contacting the author at thom@hodgenet.com.

```perl
## set these to defaults, modify as needed from results: 
## when total results falls below itemsPerPage, we have everything
while ($startIndex < $totalResults) {
  ## get the parameters for License Manager API
  my %queryParams = (
    'itemsPerPage' => $itemsPerPage,
    'startIndex'   => $startIndex,
    'q'            => "licenseStatus:$licenseStatusFilter"
  );
  ## Call makeOCLCRequestURL function to make the URL correctly
  my $requestURL = make_hru(\$apiURL, \%queryParams);
 
  my $response = $ua->get(
    $requestURL, 'Authorization' => $atAuthHeader
  );
 
  ## get the first bit of the license listing
  my $apiRecord = $response->content;
  ## parseLicenses gets some metadata for the License
  ## and each of the collections linked to it
  ($totalResults) = parseLicenses(\$apiRecord);
  ...
  foreach my $collection ($entry->child('content')
                                ->child('license')
                                ->child('collections')
                                ->child('collection')) {
    my ($thisCollectionName, $thisCollectionProvider);
    my $thisCollectionID = $collection->child('id')->value;
 
    if (defined $collection->child('name')) {
      $thisCollectionName = $collection->child('name')->value;
    } else {
      $thisCollectionName = 'No Name';
    }
 
    if (defined $collection->child('provider')) {
      $thisCollectionProvider = $collection->child('provider')->value;
    }
 
    ## call getCollectionRecord
    my $thisXMLCollectionRecord = getCollectionRecord(
      \$thisCollectionID, \$thisCollectionName
    );
  }
  ## increment the start index for next batch of licenses
  $startIndex = $startIndex + $itemsPerPage;
}
```
## Ongoing Issues

A major limitation of the current iteration of the script is that it doesn’t alert us to the cause of errors. If the script encounters an error, we must hunt for the cause. The common problem we encounter if a collection was deleted in Collection Manager but was not also removed in License Manager, it will cause the current script to fail. Other errors arise from incorrect formatting of the content\_id or subject headings, invalid characters, or a license status is not set to “current” in License Manager. We plan to improve the script so it can return human-readable error reports.

One feature of the LibGuides database A-Z tool is the ability to label certain databases as “Popular.” We identified a few databases as popular after looking as usage numbers. Unfortunately the LibGuides import process overwrites whether a database is labelled “Popular” in LibGuides, meaning we have to re-label them manually every time we run an update.

## Conclusion

After a few months spent developing this procedure, writing the script, and preparing our data, we finally launched our new LibGuides Database A-Z in late May 2018. Based on our experiences so far, we plan to further refine the script and procedure to improve error reporting, troubleshooting and further reduce the amount of manual work involved (such as re-labelling databases as “Popular”).

This procedure and script were the products of necessity. After migrating to a new ILS, our old workflow was no longer viable. We were able to exploit the tools we had available — OCLC’s APIs (which are free of cost), and the LibGuides Database A-Z — to devise a new procedure. In doing so, we were able to achieve the goals we set forth at the start: an automated procedure that produces a clean output, creates consistency, and maintains continuity. Other libraries using WMS and LibGuides should consider using a similar procedure to produce easily automated Database A-Z pages that work well for their patrons.

## About the Authors

Veronica Ramshaw  
Web Services Librarian  
American University of Sharjah  
[vramshaw@aus.edu](https://journal.code4lib.org/articles/)  
[https://orcid.org/0000-0002-4086-9419](https://orcid.org/0000-0002-4086-9419)

Véronique Lecat  
Cataloging and Metadata Librarian  
American University of Sharjah.  
[vlecat@aus.edu](https://journal.code4lib.org/articles/)  
[https://orcid.org/0000-0002-1373-8384](https://orcid.org/0000-0002-1373-8384)

Thomas Hodge  
Associate University Librarian for Technology and Technical Services  
American University of Sharjah.  
[thodge@aus.edu](https://journal.code4lib.org/articles/)  
[https://orcid.org/0000-0002-0026-2532](https://orcid.org/0000-0002-0026-2532)
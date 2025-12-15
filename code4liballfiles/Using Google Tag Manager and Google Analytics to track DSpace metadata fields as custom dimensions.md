---
title: "Using Google Tag Manager and Google Analytics to track DSpace metadata fields as custom dimensions"
source: "https://journal.code4lib.org/articles/10311"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-01-21
created: 2025-01-10
description: "DSpace can be problematic for those interested in tracking download and pageview statistics granularly. Some libraries have implemented code to track events on websites and some have experimented with using Google Tag Manager to automate event tagging in DSpace. While these approaches make it possible to track download statistics, granular details such as authors, content [...]"
tags:
  - "clippings"
---
# Using Google Tag Manager and Google Analytics to track DSpace metadata fields as custom dimensions
Suzanna Conrad, Cal Poly Pomona

DSpace can be problematic for those interested in tracking download and pageview statistics granularly. Some libraries have implemented code to track events on websites and some have experimented with using Google Tag Manager to automate event tagging in DSpace. While these approaches make it possible to track download statistics, granular details such as authors, content types, titles, advisors, and other fields for which metadata exist are generally not tracked in DSpace or Google Analytics without coding. Moreover, it can be time consuming to track and assess pageview data and relate that data back to particular metadata fields. This article will detail the learning process of incorporating custom dimensions for tracking these detailed fields including trial and error attempts to use the data import function manually in Google Analytics, to automate the data import using Google APIs, and finally to automate the collection of dimension data in Google Tag Manager by mimicking SEO practices for capturing meta tags. This specific case study refers to using Google Tag Manager and Google Analytics with DSpace; however, this method may also be applied to other types of websites or systems.

## Introduction

Cal Poly Pomona launched an institutional repository, dubbed “Bronco Scholar,” in February 2014 to support various types of scholarship from the campus community. As one of twenty-three California State University (CSU) campuses, Cal Poly Pomona was able to use a multi-tenant, shared instance of the open-source repository software DSpace hosted by the CSU Chancellor’s Office. While we are provided with a number of helpful statistics about bitstream downloads, searches, and other statistics within this multi-tenant instance, accessing granular data about specific downloads is a very time-consuming and manual process. It was important to us to be able to track specific details about individual downloads and pageviews including author names, advisor names for student research projects, content types, and titles of items accessed. And, because our DSpace instance is part of a multi-tenant instance and we do not have full administrator privileges to edit code, we needed a solution that would not require much custom code.

This article will detail the learning process of incorporating custom dimensions for tracking these detailed fields including trial and error attempts to use the data import function manually in Google Analytics, our attempts to automate the data import using Google APIs, and finally how we successfully automated collection of dimension data in Google Tag Manager by mimicking SEO practices for capturing meta tags. This specific case study demonstrates using Google Tag Manager and Google Analytics with DSpace; however, this method may also be applied to other types of websites or systems.

## Google Analytics & events tracking

Google Analytics is often implemented by libraries of all types to track website usage. A simple snippet of JavaScript code on a website linked to a Google Analytics account enables Google to intercept page requests and capture standard data that is sent by a user agent along with the request — such as information about the requested page and the user agent that’s making the request. With vanilla Google Analytics, website owners can view a standard set of metrics (such as the number of pageviews or unique pageviews) grouped by a standard set of dimensions (such as page URL, page title, user location, etc.).

Using custom JavaScript, one can capture additional data about page activity by using event tracking. With event tracking, one can set up JavaScript event handlers to submit data to Google Analytics every time a particular event is triggered (such as when a page element is clicked or a key is pressed). For instance, if one specifically wanted to track downloads of PDFs on a website, one could set a particular Google Analytics event to be recorded each time a relevant download link is clicked. Other authors have discussed technical implementations and benefits of event tracking using JavaScript edits and custom variables.\[[1](https://journal.code4lib.org/articles/#note1)\] Once event tracking is implemented in Google Analytics, it is possible, for example, to track downloads by file types, file names, and other dimensions. Furthermore, it is possible to set up goals to better track conversions, such as tracking the percentage of users visiting the site who actually download repository content.

## Google Analytics custom dimensions & metrics

If website owners want to track certain metrics or group data based on dimensions that are not included in default Google Analytics, they can set up custom metrics or dimensions as discussed in the Google Analytics Platform Principles Course. \[[2](https://journal.code4lib.org/articles/#note2)\] Within the standard Google Analytics reporting tools it is possible to use custom dimensions as secondary dimensions when viewing reports. In our case, we were specifically interested in grouping data based on a key set of metadata tracked in DSpace: content type, author name, advisor name, and title. Adding these metadata fields as custom dimensions was a logical way to accomplish this goal. \[[3](https://journal.code4lib.org/articles/#note3)\]

## Google Tag Manager

Google Tag Manager is a product that provides a simplified means of updating website “tags.” By Google’s definition, “a tag is a snippet of JavaScript that sends information to a third party,” such as a piece of custom Google Analytics event tracking code. \[[4](https://journal.code4lib.org/articles/#note4)\] Coates and Durrant discussed the usage of Google Tag Manager to track events specifically within DSpace. \[[5](https://journal.code4lib.org/articles/#note5)\] However, these principles can apply to all types of websites that need to track events. As long as a code snippet for Google Tag Manager can be implemented on the website, it is possible to automate tag creation without editing the code on each and every page.

For example, many event tracking implementations include sample code such as:

| 1 | `<``a` `href``=``"/mydownload.pdf"` `onClick``=``"_gaq.push(['_trackEvent', 'Downloads', 'Download: PDF', 'mydownload']);"``>Download PDF</``a``>` |
| --- | --- |

In Google Tag Manager this function can be handled by a tag. The tag fires on a page according to the rules established for that tag.

In order for a Google Tag Manager tag to work, it relies on rules and macros. A tag in Google Tag Manager is implemented for whatever is being measured such as pageviews or downloads. A rule defines in what instance the tag should be fired. A macro, whether pre-defined or custom, is a name-value pair that the tag references to define values in the tag.

## Tracking events in Google Tag Manager

The first goal of our project was to track downloads of DSpace bitstreams within Google Analytics so that we could filter out administrator traffic and glean more information about the users of our repository. Specifically, we wanted to utilize built-in demographic data about our audiences and also track and analyze their behavior in a more granular fashion than is possible in DSpace. Normally we would not have the ability to maintain a set of custom events within the code of our consortial DSpace instance, but Google Tag Manager requires only the implementation of one code snippet and was easy for our administrator to implement across our entire DSpace instance. Referencing Coates and Durrant’s solution and Rachel Sweeney’s blog on setting up download tracking in Google Tag Manager, \[[6](https://journal.code4lib.org/articles/#note6)\] we set up three tags in Google Tag Manager: a link click listener to listen for clicks on bitstream files, a total downloads tag, and an outbound links tag to listen for clicks to external websites. Two rules supported these tags: a rule that fired the tag on all pages and a rule that fired the download tag when a bitstream was clicked on. Macros were also configured based on Sweeney’s recommendations to strip out any information other than the file type and to return the file format. Using these recommendations, our tags were configured as follows:

[![Figure 1](https://journal.code4lib.org/media/issue27/conrad/Figure1.png)](https://journal.code4lib.org/media/issue27/conrad/Figure1.png)**Figure 1:** Google Tag Manager configuration at CPP

## Troubleshooting custom dimensions in Google Analytics

We still had the larger problem of not being able to use specific metadata fields as dimensions in our analytics reports. We wanted to be able to provide authors with reports of their downloads or to group traffic by certain types of content such as student research. Custom dimensions were a good solution to track these additional metadata fields.

As outlined in a blog post by Justin Cutroni, it is possible to use the data import function to “widen dimensions” with a CSV file. \[[7](https://journal.code4lib.org/articles/#note7)\] Essentially, adding custom dimensions from an external file would allow one to map external data (not available in the standard Google dimensions) to existing Google Analytics data structures using a unique key. Since the Google Academy and bloggers have published a number of step-by-step guides for importing custom dimensions using the data import function, this was a starting point for attempting to implement custom dimensions. To test this data import function, we first set up four custom dimensions in Google Analytics using custom definitions in the Property Admin section:

[![Figure 2](https://journal.code4lib.org/media/issue27/conrad/Figure2.png)](https://journal.code4lib.org/media/issue27/conrad/Figure2.png)**Figure 2:** Custom dimensions admin setup in Google Analytics

Then we set up these dimensions in the data import section (also located under Property Admin in Google Analytics), which provided us with the keys to map each of the metadata fields to a dimension, e.g., ga:dimension3 maps to the “advisor” custom dimension.

[![Figure 3](https://journal.code4lib.org/media/issue27/conrad/Figure3.png)](https://journal.code4lib.org/media/issue27/conrad/Figure3.png)**Figure 3:** Mapped metadata fields in Google Analytics data import

DSpace does offer a metadata export function, which we used to get a metadata dump for the CSV file. This file was unfortunately very messy; often the metadata fields would span two columns so we had to combine those fields manually. Also quotations within titles were corrupted during the export and some fields had to be normalized before they could be imported successfully to Google Analytics. We were only interested in tracking four metadata fields in custom dimensions, so we also had to reduce the CSV to include only those four columns and the unique key that Google Analytics would reference to assign dimensions to pages. In our case, the unique key was the pagePath, which corresponded to the handle URL in DSpace. Our final CSV included columns for the pagePath and four columns for the custom dimensions as defined in Google Analytics.

[![Figure 4](https://journal.code4lib.org/media/issue27/conrad/Figure4.png)](https://journal.code4lib.org/media/issue27/conrad/Figure4.png)**Figure 4:** Sample CSV file for Google Analytics data import

Once we had cleaned up the CSV file and set the paths and dimensions to correspond to the custom dimensions in Google Analytics, we were able to upload the CSV under the “Data Import” section under Property Admin. This process was successful and we were able to see the custom dimensions in our reports.

[![Figure 5](https://journal.code4lib.org/media/issue27/conrad/Figure5.png)](https://journal.code4lib.org/media/issue27/conrad/Figure5.png)**Figure 5:** Custom dimensions displaying in Google Analytics (data import)

There were a number of disadvantages to this method. Dimension widening is not retroactive, so the dimensions applied only to downloads and pageviews occurring after the data import had happened. The manual process of cleaning the CSV was also extremely time-consuming, and a more automated process would ensure that all downloads and pageviews could be captured. Within the Platform Principles course, the Google Analytics Academy also mentions APIs for dimension widening, so we began to investigate how we could automate this process using the APIs instead.

We tested scraping the site and dumping the correct metadata fields into a CSV that could be pulled into Google Analytics using the APIs. We were able to get a cleaner data pull of the metadata fields than with the DSpace metadata export. However, two problems still existed. First, a process still had to run to pull the data into Google Analytics using the APIs, and second, the dimensions would only be recorded as of the time that process ran, which meant that usage statistics of new uploads would not be tracked immediately after upload.

Since Google Tag Manager was already firing on our DSpace instance pages, we began investigating the possibility of using existing tags to track metadata fields and include those fields as custom dimensions. One SEO blogger discussed the possibility of tracking meta tag values using Google Tag Manager to determine what optimized keywords were performing best on individual webpages. \[[8](https://journal.code4lib.org/articles/#note8)\] DSpace includes metadata fields as meta tags in the page source, so this solution offered automated tracking of DSpace item-level metadata using custom dimensions.

## Our solution using Google Tag Manager

First, as with our earlier “data widening” solution, in Google Analytics we added a new custom dimension each for content type, author, advisor, and title. \[[9](https://journal.code4lib.org/articles/#note9)\]

[![Figure 6](https://journal.code4lib.org/media/issue27/conrad/Figure6.png)](https://journal.code4lib.org/media/issue27/conrad/Figure6.png)**Figure 6:** Additional custom dimensions in Google Analytics

We set the scope to “hit.” Other options include user, session, and product. The first two scopes only record the first item that a user clicks on or downloads, and if the user subsequently downloads content while on the website, those downloads will inherit the first item’s metadata records. The scope “product” is an e-commerce specific scope that applies to a product for purchase. The index number was noted so that it could be mapped in Google Tag Manager.

In Google Tag Manager, we had already configured tags and rules to collect download statistics per examples above (see the section, Tracking events in Google Tag Manager). We set up two additional types of macros including a data layer macro to hold the information for that dimension and a macro for tracking the meta tag element we wanted to track. The second macro consisted of custom JavaScript that collected the information from the page. For example, this is the macro we set up to pull author information:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `function` `getData() {`  `var` `x = document.getElementsByTagName(``"META"``);`  `var` `txt = [];`  `for` `(``var` `i=0;i<x.length;i++)`  `{`  `if` `(x[i].getAttribute(``'name'``) == ``"DC.creator"``) {`  `var` `s = x[i].getAttribute(``'content'``) + ``" \| "``;`  `txt.push(s);`  `}`  `}`  `return` `txt;`  `}` |
| --- | --- | --- |

This cycles through the page when the tag is fired and looks for multiple DC.creator meta tag elements on the page (to account for multiple authors). All custom JavaScript in Google Tag Manager macros must include a return statement, so the return statement here returns the text of the meta tag elements.

Once the additional macros were enabled, it was simple to add the custom dimensions to the existing tags we had created in Google Tag Manager using the index number we set up in Google Analytics Custom Dimensions.

[![Figure 7](https://journal.code4lib.org/media/issue27/conrad/Figure7.png)](https://journal.code4lib.org/media/issue27/conrad/Figure7.png)**Figure 7:** Mapping custom dimensions in Google Tag Manager

After this was set up, we were able to add secondary dimensions to reports using the custom dimensions in Google Analytics.

[![Figure 8](https://journal.code4lib.org/media/issue27/conrad/Figure8.png)](https://journal.code4lib.org/media/issue27/conrad/Figure8.png)**Figure 8:** Custom dimensions as secondary dimensions in Google Analytics (Downloads)

In order to track conversions, we also added a pageview tag that referenced the same two macros. Again, we designated the custom dimensions with the correct index number from Google Analytics.

[![Figure 9](https://journal.code4lib.org/media/issue27/conrad/Figure9.png)](https://journal.code4lib.org/media/issue27/conrad/Figure9.png)**Figure 9:** Custom dimensions as secondary dimensions in Google Analytics (Downloads)

After this was implemented, we were also able to track dimensions for pageviews in Google Analytics.

[![Figure 10](https://journal.code4lib.org/media/issue27/conrad/Figure10.png)](https://journal.code4lib.org/media/issue27/conrad/Figure10.png)**Figure 10:** Custom dimensions as secondary dimensions in Google Analytics (Pageviews)

Our final implementation to track custom dimensions on downloads and pageviews included the following tags:

[![Figure 11](https://journal.code4lib.org/media/issue27/conrad/Figure11.png)](https://journal.code4lib.org/media/issue27/conrad/Figure11.png)**Figure 11:** Complete setup in Google Tag Manager

## Meta tag challenges with DSpace

While setting up the custom macro to find the meta tag elements, we noticed some inconsistencies in the way that DSpace produces meta tags. Specifically, many of the Qualified Dublin Core metadata fields we entered displayed as other meta tag fields. For instance, `dc.contributor.advisor` and any other `dc.contributor` fields besides `dc.contributor.author` would appear as `dc.contributor` metatags without the additional qualifier. The `dc.contributor.author` fields appeared as `dc.creator` meta tags. Figures 12 and 13 illustrate these discrepancies.

[![Figure 12](https://journal.code4lib.org/media/issue27/conrad/Figure12.png)](https://journal.code4lib.org/media/issue27/conrad/Figure12.png)**Figure 12:** Metadata fields in Qualified Dublin Core from DSpace full record view

[![Figure 13](https://journal.code4lib.org/media/issue27/conrad/Figure13.png)](https://journal.code4lib.org/media/issue27/conrad/Figure13.png)**Figure 13:** Meta tag fields in the DSpace page source view

While this was not ideal, especially in instances where we were using metadata fields such as `dc.contributor.department` and `dc.contributor.other`, we were still able to return the text of the fields we were interested in displaying in Google Analytics using the Google Tag Manager custom JavaScript macro. When multiple values are found for these metadata fields in our current configuration, all values found populate the Google Analytics reports with pipes (“|”) between the text from each meta tag. As a result, because multiple different meta tag fields might get collapsed into the same custom dimension, we have to make sure we account for these special cases (such as our `dc.contributor.department` fields appearing along with advisor names) when looking at reports.

## Tips for working with Google Analytics and Google Tag Manager

Setting up a “catch-all” profile view with no filters or restrictions in Google Analytics is important for making sure settings on subsequently created views are working properly. For instance, if one sets up a view with a filter to exclude traffic to subdirectories, having a catch-all view with no filters assigned will help one to troubleshoot any configuration issues with the new view. This is especially important when one is setting up filters, as these cannot be reversed. Also, setting up a test view is helpful for testing all conversions and customizations without excluding or filtering any administrator traffic.

Events appear to take some time to start showing up in Google Analytics; it can take up to twenty minutes to see if Google Tag Manager changes are reflected in Google Analytics.

Custom dimensions will take effect and be accessible across all views in a property, so one should choose wisely and carefully.

In Google Tag Manager, tags, rules, and macros are published in containers. These have to be re-published every time a change is made and each previously published version is archived under “Versions” in Google Tag Manager. We found that it was helpful to name the containers with whatever was changed. For instance, when adding a pageview tag to track custom dimensions in an existing container, we labeled the title of the container with this change. Then, if the individual tag was not functional, we could revert to a previous functional container.

Site performance is also something to consider in Google Tag Manager. Having too many tags on a site can degrade site performance, so we chose to be selective about how many tags we were firing on a page.

### A disappointing revelation about events tracking in Google Analytics

Unfortunately, because Google Analytics relies on JavaScript to track activity, hits on files such as PDF downloads cannot be tracked directly via any method in Google Analytics. In DSpace, bitstream statistics reports will still track the additional PDF downloads. If a “catch-all” view is in place in Google Analytics, statistics from that view can be compared to DSpace administrator statistics to determine what was not captured using the event tracking in Google Analytics and Google Tag Manager. Files retrieved directly from search engine results are the most affected by this issue; if someone searching in Google clicks directly on the PDF link in Google Search results, it will not be tracked. Results provided by Google Scholar, however, link to the repository item record page, allowing those downloads to be tracked.

## Conclusion

Google Tag Manager not only serves as a more automated solution to updating tracking code on websites, it also can be an effective way to automate the addition of custom dimensions to Google Analytics reports. Using a combination of methods presented by others at conferences, researched online, and a bit of simple JavaScript to create custom macros, we were able to begin tracking custom metadata fields from DSpace as secondary dimensions in Google Analytics. This has allowed us to provide granular reports on author, title, advisor, and content type statistics from our repository without requiring any data normalization.

## Acknowledgments

Thanks to Aaron Collier from the CSU Chancellor’s Office for brainstorming with us as we sorted through different options to track these statistics in Google Analytics. Thanks to CPP Library’s web developer Alfredo Lafarga for testing and trying various solutions. Thanks to Summer Durrant for her advice on getting download tags to work and for alerting us of Google Tag Manager through her 2013 LITA Forum presentation. Also, thanks to the STEP Program Grant at Cal Poly Pomona for funding the launch of the repository and the Office of Undergraduate Research for their efforts in its continued success.

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Wilson, J. (2014). Personalize Your Google Analytics Data with Custom Events and Variables. *Code4lib*. [http://code4lib.org/files/Wilson-c4l14.pdf](http://code4lib.org/files/Wilson-c4l14.pdf); Farney, T., & McHale, N. (2013). Event tracking: Getting all your data. Library Technology Reports, 49(4), 27.  
\[[2](https://journal.code4lib.org/articles/#ref2)\] Google Analytics Academy: Google Analytics Platform Principles. (n.d.) [https://analyticsacademy.withgoogle.com/course02](https://analyticsacademy.withgoogle.com/course02)  
\[[3](https://journal.code4lib.org/articles/#ref3)\] Note that you must use Universal Analytics in order to create custom dimensions and metrics. Classic Google Analytics uses custom variables, instead.  
\[[4](https://journal.code4lib.org/articles/#ref4)\] Tag Manager Help: About Google Tag Manager. (n.d.) [https://support.google.com/tagmanager/answer/2574305?hl=en](https://support.google.com/tagmanager/answer/2574305?hl=en)  
\[[5](https://journal.code4lib.org/articles/#ref5)\] Coates, H. & Durrant, S. (2013). Improving user engagement in a data repository with web analytics. *LITA Annual Forum.* [http://connect.ala.org/files/Durrant%26Coates\_2013\_LITAForum\_DataRepoWebAnalytics\_0.pdf](http://connect.ala.org/files/Durrant%26Coates_2013_LITAForum_DataRepoWebAnalytics_0.pdf)  
\[[6](https://journal.code4lib.org/articles/#ref6)\] Coates and Durrant, 2013; Sweeny, R. (2013). Google Tag Manager series 4: Tips and tricks when setting up a Google Analytics implementation in Google Tag Manager. [http://www.fourthsource.com/web-development/google-tag-manager-series-4-tips-tricks-setting-google-analytics-implementation-google-tag-manager-16156](http://www.fourthsource.com/web-development/google-tag-manager-series-4-tips-tricks-setting-google-analytics-implementation-google-tag-manager-16156)  
\[[7](https://journal.code4lib.org/articles/#ref7)\] Cutroni, J. (2013). Dimension Widening: Import data directly into Google Analytics. [http://cutroni.com/blog/2013/10/30/dimension-widening-import-data-directly-into-google-analytics](http://cutroni.com/blog/2013/10/30/dimension-widening-import-data-directly-into-google-analytics)  
\[[8](https://journal.code4lib.org/articles/#ref8)\] Moore, A. (2013). SEO reporting with Google Tag Manager. [http://www.lunametrics.com/blog/2013/12/30/seo-reporting-google-tag-manager/#sr=g&m=o&cp=or&ct=-tmc&st=%28opu%20qspwjefe%29&ts=1415479900](http://www.lunametrics.com/blog/2013/12/30/seo-reporting-google-tag-manager/#sr=g&m=o&cp=or&ct=-tmc&st=%28opu%20qspwjefe%29&ts=1415479900)  
\[[9](https://journal.code4lib.org/articles/#ref9)\] Note that up to 20 custom dimensions can be added with the free version of Google Analytics.

## About the author

Suzanna Conrad is Digital Initiatives Librarian and Head of the Digital Services & Technology Department at Cal Poly Pomona.
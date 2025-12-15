---
title: "mapFAST: A FAST Geographic Authorities Mashup with Google Maps"
source: "https://journal.code4lib.org/articles/5645"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-07-25
created: 2025-01-10
description: "When looking for information about a particular place, it is often useful to check surrounding locations as well. FAST geographic subjects provide clean access points to this material, and a Google Maps mashup allows users to see surrounding locations that are also FAST subjects. Moreover, the Web Service to the underlying data is also open [...]"
tags:
  - "clippings"
---
# mapFAST: A FAST Geographic Authorities Mashup with Google Maps
Rick Bennett, Edward T. O’Neill, Kerre Kammerer, JD Shipengrover

When looking for information about a particular place, it is often useful to check surrounding locations as well. FAST geographic subjects provide clean access points to this material, and a Google Maps mashup allows users to see surrounding locations that are also FAST subjects. Moreover, the Web Service to the underlying data is also open and available for use. The map interface allows for simple selection of a location, with links to enter it directly as a search into either WorldCat.org or Google Books.

## Background

Most search engines are keyword driven.  If you want to know something about a place, using the name of the place as a search term is usually sufficient.  However, not all place names appear in a controlled vocabulary such as the Library of Congress (LC) Subject Headings and Name Authorities \[[1](https://journal.code4lib.org/articles/#note1)\].  Even if the location you are interested in has a controlled subject heading, some material of interest may be cataloged using a nearby town or lake name.

The mapFAST prototype interface was developed to address this problem \[[2](https://journal.code4lib.org/articles/#note2)\].  mapFAST is a mashup that uses Google Maps to present FAST (Faceted Application of Subject Terminology) \[[3](https://journal.code4lib.org/articles/#note3)\] geographic authority records.  The prototype presents a different way to look at subject access to bibliographic records. The map interface allows for simple discovery of a geographic location, selection of a location via a map pin or a search result list, and display of location information including links that initiate either a WorldCat.org or Google Books search for the selected entry.

mapFAST uses records from the FAST database.  The FAST schema reworks Library of Congress Subject Headings (LCSH) rules so that they are easier to use, understand, and apply. FAST subject headings are facetted into their component parts such as topics, geographics, and events. The result is a more machine-friendly schema designed to handle a large volume of materials with less effort and cost.

## FAST Geographic Data

Currently the FAST authority file contains over 1.6 million authority records. The authority file is extensively indexed to support a variety of search options. Documentation on searching the FAST authority file is available on the FAST Web site \[[4](https://journal.code4lib.org/articles/#note4)\]. FAST is also available through the OCLC Terminologies Service prototype \[[5](https://journal.code4lib.org/articles/#note5)\]. The full FAST authority file can be licensed for non-commercial use.

There are about 160,000 geographic headings in FAST.  The geographic coordinates for these headings were extracted from the corresponding LC records.  The LC coordinate is stored in a free-text field, usually in one of a few fairly consistent patterns, so the coordinate could be read and put into a machine-consistent format in the FAST version.  When a coordinate was not available in the original LC record, the geonames \[[6](https://journal.code4lib.org/articles/#note6)\] database was used as an additional source of coordinates. Geonames is a geographical database combining several geographic databases. A matching algorithm was used to match FAST headings to the geoname headings, and the coordinates and place types were added from these records. In all, over 62.5% of FAST geographic headings have coordinates.

In addition to geographic headings, events often occur at specific places.  When a battle or other event could be placed in a particular location, that coordinate was also added to the FAST record.  This was done automatically by using the information in the records.  This is often approximate.  For example, the Battle of Gettysburg was assigned the coordinate for the nearby town of Gettysburg rather than the exact place of the battle.  It is hoped that manual review or the availability of other databases for matching will provide more accurate coordinate information in the future.

[![](https://journal.code4lib.org/media/issue14/bennet/mapFAST_code4Lib.Fig1.JPG "Figure 1")](https://journal.code4lib.org/media/issue14/bennet/mapFAST_code4Lib.Fig1.JPG)

Figure 1- mapFAST display of the Battle of Gettysburg

Corporate bodies are another facet of FAST headings that may have coordinates assigned. These are often buildings, parks, or other facilities that have a particular location.  As of this writing, coordinates have not been assigned for any corporate headings but it is being considered by the FAST team.

## mapFAST Interface

In late 2009, Google opened its map and data APIs to include attribute searching \[[7](https://journal.code4lib.org/articles/#note7)\].  The example in the Google Geo Developers blog post was a college-finder application where the result could be refined by type of college, size, and distance from a location.  With these new features, we used this example as a basis to develop an interface where the FAST geographic headings could be displayed, and allow them to be refined by the geographic type of the heading.

In a Google Maps mashup, the Google Maps API \[[8](https://journal.code4lib.org/articles/#note8)\] provides basic map functionality though JavaScript classes, and the developer implements a map interface using that functionality in combination with local data or some specialized functionality.  For mapFAST, we modified the layout, provided FAST data to be included as markers on the map, and customized some of the user-map interactions.

mapFAST has a simplified single-page user interface (Figure 2) designed with the end-user in mind.  The interface consists of five sections: Search Entry, Search Results Display, Map Display, Subject Heading Detailed Display, and Permalink Display.

Search Entry is the first section and its main component is a search entry box. This section also has two search limiters presented to users as standard drop-down select boxes. The limiters are: Radius (5, 10, 20, 50, 100 km) and Type (all; populated places; regions or government districts; lakes, rivers, streams; other; events; or undefined). Limiters can be placed on a search before or after the search has been executed.

The second section is the Search Results Display. This section is found below the Search Entry area. It is a simple list of FAST subject headings displayed in order of distance from the center of the map.  The result list displays up to 20 subject headings.  Each subject heading’s type is indicated via a simple icon to the left of the entry and each entry on the list is also a link that can be used to display the Subject Heading Detailed Display.

[![](https://journal.code4lib.org/media/issue14/bennet/mapFAST_code4Lib.Fig2.JPG "Figure 2")](https://journal.code4lib.org/media/issue14/bennet/mapFAST_code4Lib.Fig2.JPG).

mapFAST Interface Mechanics

Figure 2 – example of mapFAST User Interface

The entries on the Search Result list are displayed on the map in the third section, the Map Display area.  This area is to the right of the Search and Results sections.  It is the display area for the Google map and each entry on the Search Result list is displayed on the map as a Google Maps marker or pin. The Google map can be controlled using standard Google Maps controls.

Either the Search Results list entries or the Map Display pins can be selected to bring up the fourth user interface section, the Subject Heading Detailed Display.  This section is a Google Maps overlay bubble that displays further information about the selected subject heading.  Additional information includes: the full heading, the heading type, alternative subject headings (if available), and search links into WorldCat.org and Google Books.

The final user interface section is the Permalink Display. This is simply a unique link for a given location.  It allows anyone wanting to share or save a location to do so.  The permalink is presented in the “Share this Location” text box provided below the Search Results and Map Displays areas.

Search and display in the mapFAST interface is a multiple step process.  This process is outlined in Figure 3. First, the search terms are submitted to the Google map engine.  The first result from this search is examined, and a latitude/longitude coordinate pair is extracted.  For example, a search for Amsterdam, Netherlands returns the results in an array, and the first element contains:

Result\[0\]. formatted\_address =  Amsterdam, The Netherlands

Result\[0\].geometry.location.lat()  = 52.3730556 , and

Result\[0\].geometry.location.lng()  = 4.892222199999992

The geographic coordinates are then submitted along with the desired radius to the mapFAST Web Service described below. A jQuery.getJSON request is used to make this request.  This returns a list of FAST geographic headings and associated data.  This first-cut result is accurate, but it may not be pleasing.  The results may be too concentrated within the map display, or skewed to one side.  Therefore, the results are examined, and a new longitude/latitude box is defined that contains the initial set of results, but which is likely to change the center of the result.

This adjusted box is now submitted to the mapFAST Web Service to obtain the final result set.  The Google Maps display is also adjusted based on this box.  The FAST result list is processed to calculate markers to display on the map.

Map movements are handled in a similar fashion.   The Google Maps engine takes care of moving the map.  The new bounds of the Google map are used for a new longitude/latitude box search to the mapFAST Web Service, and the results are displayed.

[![](https://journal.code4lib.org/media/issue14/bennet/mapFAST_code4Lib.Fig3.JPG "Figure 3")](https://journal.code4lib.org/media/issue14/bennet/mapFAST_code4Lib.Fig3.JPG)

Figure 3 –  mapFAST Interface Flow

As is standard with the Google Maps display, map markers may be expanded to provide information about specific map locations. In the marker expansion bubble, URL links are provided to search WorldCat and Google books.  FAST is not implemented in WorldCat, but the keywords are typically found in WorldCat subjects anyway, so using the FAST heading as a keyword search to the subject index works well.  A NormalizedName parameter is provided by the mapFAST Web Service to avoid doing the complicated normalization in JavaScript.  An example WorldCat search for **Netherlands— Amsterdam** is:

[http://www.worldcat.org/search?q=su: netherlands%20amsterdam&qt=advanced](http://www.worldcat.org/search?q=su:%20netherlands%20amsterdam&qt=advanced)

Google Books collects bibliographic data for many of its entries too, so a subject search also works well there: [http://books.google.com/books?q=+subject:netherlands%20amsterdam&lr=&as\_drrb\_is=q&as\_minm\_is=0&as\_miny\_is=&as\_maxm\_is=0&as\_maxy\_is=&as\_brr=0&source=gbs\_metadata\_r&c](http://books.google.com/books?q=+subject:netherlands%20amsterdam&lr=&as_drrb_is=q&as_minm_is=0&as_miny_is=&as_maxm_is=0&as_maxy_is=&as_brr=0&source=gbs_metadata_r&c)

.

## mapFAST Web Service

### RESTful Query

The Web Service is a simple [RESTful](http://en.wikipedia.org/wiki/Representational_State_Transfer) \[[9](https://journal.code4lib.org/articles/#note9)\] service, returning JSON objects.  This means that a simple URL can access the information, and the lightweight JSON object returns all the data requested.  A sample URL is:

[http://experimental.worldcat.org/mapfast/services?geo=-33.863,151.208;crs=wgs84&mq=&sortby=distance&radius=30000&max-results=3&callback](http://experimental.worldcat.org/mapfast/services?geo=-33.863,151.208;crs=wgs84&mq=&sortby=distance&radius=30000&max-results=3&callback)\=?

The key parameters here are:

- Geo = the latitude & longitude
- Radius = search radius in km
- Max-results = maximum number of records requested

This query is processed by a Perl script and MySQL database as described below.

### Building the SQL Query

Library search engines tend to be keyword oriented.  Finding records with coordinates “near” an input coordinate is not a typical feature.  Therefore, the more general MySQL database was chosen for its ability to handle a complex SQL statement that could calculate the distance from a point and rank the result by that distance.

The critical database tables for this query are longitude and latitude.  In SQL, it is quite easy to select all the records from a box of a latitude range and a longitude range, and a Perl script is used to build and process the query. However, on a globe, that box is not square.  As the latitude increases, the width (longitude) of the box narrows, to zero at the poles.  To adjust for that, the longitude is increased by the dividing it by the cosine of the latitude.  At the equator, the divisor is one, so there is no adjustment.  At 60 degrees latitude, the longitude range is doubled.  Of course the box is not truly square at this point, but it is close enough for retrieval.  Google Maps doesn’t support locations above 85 degrees latitude, so dividing by zero is not an issue.

Now that a result set within a longitude/latitude box can be obtained, it is only necessary to rank the result by the distance from the center.  The center coordinate is, of course, the midpoint of the query range.  The quadratic equation is used to calculate the distance from the center coordinate for ranking.  The SQL query is then:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37 | `$query=``"SELECT [table list] FROM fast WHERE latitude  >='$latlow' AND latitude <='$lathi' AND longitude >'$lonlow'  AND longitude <'$lonhi' ORDER BY SQRT( POW((latitude-'$latcen'),2)+POW((longitude-'$loncen')/$longcorr,2)) LIMIT $maxresults"``;&#91;/sourcecode&#93;`  `Where`  `<ul>`  `<li>Latitude ``and` `longitude are tables ``in` `the MySQLdatabase</li>`  `<li>$lonlow, $lonhi, $latlow, $lathi are the longitude ``and` `latitude ranges.  The longitude has already been widened  corrected ``for` `latitude ``to` `approximate a square box.</li>`  `<li>$latcen= ($lathi+$latlow)/2;</li>`  `<li>$loncen= ($lonhi+$lonlow)/2;</li>`  `</ul>`  `$longcorr = 1/( cos 2*3.14*$latcen/360 );`  `$maxresults = maximum desired results ``to` `be returned.`  `When` `the URL request has ``only` `the center point ``and` `radius, the script constructs an approximate box around the requested circle, ``and` `treats it ``as` `a box type request.`  `<h3>JSON ``Return``</h3>`  `The following ``is` `an example search ``return` `in` `JSON format.  ``Only` `a single record ``is` `shown.`  `[sourcecode language=``'js'``]`  `{`  `"name"``: ``"FAST Authority Records"``,`  `"Status"``: { ``"code"``: 200,      ``"request"``: ``"geocode"`   `},`  `"Placemark"``: [`  `{`  `"id"``: ``"fst01320412"``,`  `"name"``: ``"New South Wales -- Sydney -- Australia Square"``,`  `"description"``: ``""``,`  `"ExtendedData"``: [`  `{  ``"name"``: ``"NormalizedName"``,  ``"value"``: ``"new south wales sydney australia square"` `},`  `{  ``"name"``: ``"Feature"``,           ``"value"``: ``"unknown"`        `},`  `{ ``"name"``: ``"FCode"``,          ``"value"``: ``"U"`        `}`  `],</li>`  `"point"``: { ``"coordinates"``: ``"-33.8650,151.2070"` `}`  `},`  `]`  `…Placemark entries repeat`  `}` |
| --- | --- |

Each Placemark parameter contains information from a single FAST record, and the parameters are described in the Web Service documentation \[[4](https://journal.code4lib.org/articles/#note4)\].  Since the return is in JSON, the JavaScript can use it directly without further processing.

When the URL parameter “callback=\[functionname\]?” is added, this makes the request JSONP, where a JavaScript function call is returned around the JSON data. The “?” is required, and a random function name is returned when no parameter is given to process anonymous callback function. Otherwise the functionname parameter is used as the callback function name.

## Summary

By combining the FAST geographic and event subject headings, the geographic coordinates associated with the subject headings, and Google Maps, a map mashup was developed. This map interface is a simple, easy to use way to access materials about an area that were difficult to get at by other means.

Users can search for a place, then use features of the mashup to identify, locate, and access resources related to that place, or nearby places or geographic features. Restricting the result to a feature type, such as events or lakes, rivers, and streams, allow the user to focus on the information they are most interested in.

From a library developer aspect, mapFAST shows how to develop a Google Maps mashup to make map based interfaces using local data. The RESTFul Web Service that underlies this interface provides a JSON list of FAST geographic headings that are near an input coordinate.  The Web Service results are compatible with both FAST and LC subject headings, and is available so that others may develop additional applications.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Library of Congress Authorities. Available from:  [http://authorities.loc.gov/](http://authorities.loc.gov/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] The mapFAST interface is at [http://experimental.worldcat.org/mapfast/](http://experimental.worldcat.org/mapfast/) . The project is described at [http://www.oclc.org/research/activities/mapfast/default.htm](http://www.oclc.org/research/activities/mapfast/default.htm). The Web Service is documented at [http://www.oclc.org/developer/services/MapFAST](http://www.oclc.org/developer/services/MapFAST).

\[[3](https://journal.code4lib.org/articles/#ref3)\] FAST: Faceted Application of Subject Terminology, by Lois Mai Chan and Edward T. O’Neill, 2010.  
[COinS](https://journal.code4lib.org/coins)  
OCLC Research Activities associated with FAST are summarized at:  [http://www.oclc.org/research/activities/fast/](http://www.oclc.org/research/activities/fast/default.htm)

\[[4](https://journal.code4lib.org/articles/#ref4)\] The FAST database is available at: [http://fast.oclc.org/](http://fast.oclc.org/)

\[[5](https://journal.code4lib.org/articles/#ref5)\] OCLC Research Terminology Service Pilot for FAS:T [http://tspilot.oclc.org/fast/?operation=explain&version=1.1](http://tspilot.oclc.org/fast/?operation=explain&version=1.1)

\[[6](https://journal.code4lib.org/articles/#ref6)\] The Geonames geographical database: [http://www.geonames.org/](http://www.geonames.org/).

\[[7](https://journal.code4lib.org/articles/#ref7)\] The Maps Data API: Bringing Geospatial Search to Google’s Cloud (Holden, 2009). Available from: [http://googlegeodevelopers.blogspot.com/2009/12/maps-data-api-bringing-geospatial.html](http://googlegeodevelopers.blogspot.com/2009/12/maps-data-api-bringing-geospatial.html)

\[[8](https://journal.code4lib.org/articles/#ref8)\] Google Map API: [http://code.google.com/apis/maps/documentation/javascript/](http://code.google.com/apis/maps/documentation/javascript/)

\[[9](https://journal.code4lib.org/articles/#ref9)\] RESTFul, Representational State Transfer. Available from:  [http://en.wikipedia.org/wiki/Representational\_State\_Transfer](http://en.wikipedia.org/wiki/Representational_State_Transfer)

## About the Authors

Rick Bennett ([Rick\_Bennett@oclc.org](https://journal.code4lib.org/articles/))  is a Consulting Software Engineer in OCLC Research, where he works on processing and manipulating bibliographic and authority data.  Currently he has been focusing on developing, maintaining, and displaying authority data for the FAST project. Rick was an undergraduate at Penn State and graduate at Georgia Tech, where he completed a program in Computer Engineering.

Edward T. O’Neill ([oneill@oclc.org](https://journal.code4lib.org/articles/)) is a Senior Research Scientist at OCLC Research and project manager for the FAST project. Ed did his undergraduate work at Albion College and his doctorial work at Purdue University in Industrial Engineering. His research interests include authority control, subject analysis, database quality, collection management, and bibliographic relationships. He is active in IFLA (International Federation of Library Associations and Institutions) and is a member of the IFLA Standing Committee of the Classification and Indexing Section.

Kerre Kammerer ([kammerer@oclc.org](https://journal.code4lib.org/articles/)) is a Consulting Software Engineer in OCLC Research.  Kerre’s research interests include database quality control and authority data.  Her current research activities involve the creation and maintenance of FAST authority records and the conversion of LC subject headings to FAST headings in bibliographic records.  Kerre holds a BA in Economics from DePauw University.

JD Shipengrover([shipengj@oclc.org](https://journal.code4lib.org/articles/)) is a Senior Web and User Interface Designer for OCLC Research.  She works to bring user-centered design principles to the Web applications created by OCLC Research.  Her research interests include Web Usability, Web Standards and Information Visualization.  She holds BAs in Journalism and the History of Art from The Ohio State University and has a MLIS from Kent State University.
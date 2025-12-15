---
title: "The Brooklyn Health Map: Reflections on a Health Data Dashboard for Brooklyn, NY"
source: "https://journal.code4lib.org/articles/17158"
author:
  - "Sheena Philogene"
published: 2023-04-21
created: 2025-01-10
description: "Recent years have put a spotlight on the importance of searchers of all kinds being able to quickly and easily find relevant, timely, and useful health information. This article provides a general overview of the process used when creating the Brooklyn Health Map, an interactive Brooklyn-based health data dashboard that visualizes community health information at the census tract, zip code, and neighborhood levels. Built using HTML, CSS, Bootstrap, and JavaScript, the Brooklyn Health Map presents information in the form of interactive web maps, customizable graphs, and local level data summaries. This article also highlights the tools used to simplify the creation of various dynamic features of the dashboard."
tags:
  - "#health"
  - "#health/data"
  - "#GeoJSON"
  - "#jQuery"
---
# The Brooklyn Health Map: Reflections on a Health Data Dashboard for Brooklyn, NY
Sheena Philogene

Recent years have put a spotlight on the importance of searchers of all kinds being able to quickly and easily find relevant, timely, and useful health information. This article provides a general overview of the process used when creating the Brooklyn Health Map, an interactive Brooklyn-based health data dashboard that visualizes community health information at the census tract, zip code, and neighborhood levels. Built using HTML, CSS, Bootstrap, and JavaScript, the Brooklyn Health Map presents information in the form of interactive web maps, customizable graphs, and local level data summaries. This article also highlights the tools used to simplify the creation of various dynamic features of the dashboard.

## Introduction

As a librarian at Brooklyn College, I have found that patrons often want to do local research focused on Brooklyn. However, it can be difficult for both students and faculty to find the right sources for the local level information they need quickly or easily. With that user need in mind, the idea of the Brooklyn Health Map (BHM) was born. This article provides an overview of the tools used when creating the Brooklyn Health Map, an interactive Brooklyn-based health data dashboard that visualizes community health information at the census tract, zip code, and neighborhood level, in the form of maps, graphs, and data summaries. 

## Background

Recent years have put a spotlight on the importance of searchers of all kinds to quickly and easily find relevant, timely, and useful health information. Although there are already many sources of high quality health data, reporting on the city, state, and national level, many of these sources can be hard to find and navigate. Because health information is often scattered across various specialized organizations, users may be required to visit multiple sites to collect all the information they want to find. In many cases, data will be initially reported on the federal level, and if users are interested in finding local data, they will be required to narrow down to their area of interest using filters or other built in tools. This can often be a difficult or confusing process for people with less experience or facility navigating these web applications, because certain features will only be available after using a filter or other tool. Recognizing these limitations, the Brooklyn Health Map (BHM) compiles data from several sources of health and population information (e.g., NYS Cancer Registry, US Census, and Centers for Disease Control and Prevention \[CDC\]), limits the coverage area to one relatively small geographic area, and provides simple navigation for users to quickly and easily collect the information they need. 

The BHM focuses on presenting data about the health characteristics of adults living in Brooklyn, New York. The dashboard is intended to simplify access to relevant and comprehensive health and demographic information about Brooklyn. This article seeks to provide an overview of the technical aspects involved in the development of the BHM. For information about the goals, development, and pedagogical applications, see Philogene (2022). 

As the BHM is a web based dashboard, the entirety of the page is built using HTML, CSS, Bootstrap, and JavaScript. The webpage is divided into three areas (Figure 1), which correspond to (1) an interactive web map, (2) zip code selector summary panel, and (3) interactive neighborhood level charts.

![](https://journal.code4lib.org/media/issue56/philogene/Figure%201.png)
**Figure 1.** The Brooklyn Health Map.

## The Necessary Data

The BHM includes health and population information from three sources:

- The PLACES: Local Data for Better Health project ([2020](https://www.cdc.gov/places/about/index.html))
- New York State Cancer Registry ([2020](https://www.health.ny.gov/statistics/cancer/registry/tract/kings.htm))
- U.S. Census Bureau ([2015](https://data.census.gov/cedsci/table?q=B16001&g=0500000US36061%241400000&tid=ACSDT5Y2015.B16001); [2019](https://data.census.gov/cedsci/table?q=dp05&g=0500000US36047%241400000&tid=ACSDP5Y2019.DP05)).

In addition to the population information, the dashboard also uses shapefiles of the census tracts, zip codes, and other areas of Brooklyn collected from the [New York City Open Data Portal](https://opendata.cityofnewyork.us/). 

The dashboard incorporates 20 types of health and population metrics, including languages spoken in the area and health characteristics such as high cholesterol and cancer screening rate on the census tract, zip code, and neighborhood level. 

The data were initially compiled into .csv files (one for each geographic level) and converted to GeoJSON files using ArcGIS. GeoJSON is a geographic file type based on the JavaScript Object Notation (JSON) file type, which stores both geographic feature information (i.e., coordinates) and non-geographic data. Using GeoJSON files makes web mapping easier, as this file type helps to consolidate several types of data into one file, making file management and coding easier.

## The Dashboard

### Panel 1. Web Mapping with Leaflet

The first section of the dashboard is an interactive web map, built using the leaflet. [Leaflet.js](https://leafletjs.com/) is an open source JavaScript library used to create interactive, mobile friendly web maps. Leaflet provides many short cut methods for adding dynamic functionality to web maps. The leaflet website provides full tutorials to get started with using the library. To prepare the page for a web map, a leaflet CSS and JavaScript file needs to be added to the HTML `<head>` element, and a `<div>` element needs to be added in the HTML where the map is intended to be placed. 

The CSS file added to the `<head>`:

```html
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/ keqq/sMZMZ19scR4PsZChSR7A=="crossorigin=""/>
```

The Leaflet JavaScript file (must be after the Leaflet CSS file):

```html
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
integrity="sha512-
XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3y nxwA=="crossorigin=""></script>
```

The `<div>` element added to the `<body>`:

```html
<div id="map" class="row" style="margin-right: 0px;margin-left: 0px;">
  ...
   <div id="mapid" style="width:100%; height:700px"></div>
   <script src="script.js"></script>
</div>
```

The JavaScript for the dashboard was written as a separate file (script.js), and also added into the same `<div>` element. 

jQuery was used to read the GeoJSON files that store the coordinate data and to populate the maps. As mentioned above, the dashboard includes 20 different types of health and population information that fall into four categories: Brooklyn Demographics, Unhealthy Behaviors, Health Outcomes, and Screening Rates. Separate GeoJSON files were created based on each data source. The majority of the data included on the map is at the census tract level, however, there are also outlines of zip codes, neighborhood tabulation areas (NTAs) and Public Use Microdata Areas (PUMAs) which users can overlay on any map layer. 

Here is a snippet using jQuery to read the GeoJSON file storing both language and population information: 

```javascript
$.getJSON("Brooklyn_Language.geojson", function(data) {
    languageLayer.addData(data);
   });
   languageGroup.addTo(mymap)
```

The jQuery .getJSON() function is used to read the GeoJSON file. From there, the data is added to the languageLayer object using .addData(data). The data file stored information for the most commonly spoken language, the percentage of people who speak a language other than English, and the distribution of speakers of over 15 languages per census tract. This data was then used to produce a collection of 20 distinct map layers: the initial “Brooklyn Languages” map shown when landing on the page and an additional 19 maps showing the distribution of specific languages spoken across Brooklyn. This added detail is accessed using a dropdown visible only on this map layer (Figure 2). The collection of maps is added to a featureGroup called languageGroup. By adding all the layers to a single featureGroup, all added functionality (e.g., dynamic pop up boxes) are added to all the layers included in the group. Finally, the .addTo(mymap) method is used to populate the map with the stored data and geometry. 

![](https://journal.code4lib.org/media/issue56/philogene/Figure%202.png)
**Figure 2.** The Brooklyn Languages layer showing default view
(right) and layer selected using drop down menu (left).

### Map Category Navigation

As the map included 20 different types of health and population information, it was necessary to divide the content into thematic categories to help with navigation. So similar types of information can be easily identified and explored, the data were placed into four groupings (i.e., “Brooklyn Demographics,” “Unhealthy Behaviors,” “Health Outcomes,” and “Screening Rates”). 

In order to create navigable categories, Bootstrap buttons were added above the *script.js* file included in the `<div>` above:

```html
<div class="col-sm-8">
  <div style="width: 100%; height:70%" >
   <div class="btn-group">
   <button type="button" class="btn w3-white"><b>Census Tract Level</b></button> 
   <button type="button" id="demographics" class="btn w3-cyan">Brooklyn       Demographics</button>
   <button type="button" id="unhealthy" class="btn w3-blue-grey">Unhealthy Behaviors</button>
   <button type="button" id="outcomes" class="btn w3-pale-red">Health Outcomes</ button>
   <button type="button" id="screening" class="btn w3-purple">Screening Rates</ button>
   </div>
  <div id="mapid" style="width:100%; height:700px"></div>
  <script src="script.js"></script>
  </div>
```

The resulting button controls:

![](https://journal.code4lib.org/media/issue56/philogene/Figure%203.png)
**Figure 3.** Category buttons linked to map layers.

The button ‘id’ for each category corresponds to a jQuery `.click()` method, which simultaneously removes the previous layer, legend, and any other available controls, then replaces them with a new group of layers that correspond to the button selected. This script shows what the “Unhealthy Behaviors” button does: 

```javascript
$("#unhealthy").click(function() {
    mymap.eachLayer(function (layer) {
    mymap.removeLayer(layer); // clear map on click
    });
    baseLayer.addTo(mymap); // re-add basemap
    currentLayer = uninsuredLayer;
    uninsuredLayer.addTo(mymap);
    mymap.removeControl(currentLayerControl); // remove old layer controls
    mymap.removeControl(languageDrill); // remove language layer dropdown
    mymap.removeControl(cancerDrill); // remove cancer layer dropdown
    currentLayerControl = behaviors; // add new layer controls
    behaviors.addTo(mymap); // add layer group to match category
    mymap.removeControl(currentLegend); // remove old legend
    currentLegend = uninsuredLegend; // update current legend
    uninsuredLegend.addTo(mymap);
   });
```

### Panel 2. Exploring Zip Codes

The second section of the dashboard, located on the right-hand panel, allows users to investigate data at the zip code level (Figure 4). This zip code level panel actually has two purposes: (1) to introduce users to the dashboard and provide information about navigating the page and (2) to summarize health and language information available across the 20 map layers. 

![](https://journal.code4lib.org/media/issue56/philogene/Figure%204.png)
**Figure 4.** Zip code panel, showing welcome message (right)
and zip code summary (left).

The zip code information is stored on a separate GeoJSON file, primarily because it uses a different geography than the mapped data. The same `.getJSON()` method is used to access the data, and a similar `<div>` element is used to control what information populates the panel. 

From the zip code selector panel, there are three possibilities of messages that can be returned: 

- Introductory welcome text (only visible when the page loads or refreshes)
- Summary for selected zip code (changes to reflect selected zip code)
- Text to suggest other options for exploring

jQuery is used to handle the call, when a zip code is selected from the drop down. The selected zip code is converted to a string, so it can be used as a selector in the function used in the .on(‘change’) method. The string is then used to check for the matching zip code ‘id’ in the GeoJSON file and return the summary data for the correct zip code. If a user selects the text “Select a new zip code” instead of an actual zip code, they will be given the third text option for other ways to explore. 

Handling changes in the zip code selector panel:

```javascript
// ON SELECTING ZIP CODE ON DROP DOWN 
$(document).ready(function(){
    $('#zipCodes').on('change',function(){
    zipSelected = $("#zipCodes option:selected").text();
 
 
// MATCH ZIP CODE FROM DROP DOWN AND TO DATA VARIABLE; RETURN APPROPRIATE TEXT
 
 
    for( var i = 0; i < 99; i++ ) {
    if( zipData[i][0] == zipSelected ) {
    document.getElementById("zipContainer1").innerHTML = zipData[i][1]; // get zip code highLight(zipSelected) // highlight selected zip code 
    break; 
    }
    else {
    document.getElementById("zipContainer1").innerHTML = '<br><br><h3 style="text-align:center">Select a new zip code</h3><br><h3 style= "text align:center"><i>or</i></h3><br><h5 style="text-align:center">Check out the charts below to see an overview of the health statistics on a neighborhood level.</h5><br><h4 style= "text-align:center"><i class="fa fa-arrow-down" aria-hidden="true"></i><h4><br><h5 style= "text-align:center"><i class="fa fa arrow-down" aria-hidden="true"></i></h5><br><br><h6 style= "text align:center"><i class="fa fa-arrow-down" aria-hidden="true"></i></h6>'; }
    }
   });
   });
```

In addition to updating the panel to display a summary of zip code level data corresponding to the selected zip code, there is also the highLight(zipSelected) function, which results in a yellow highlighted boundary of the selected zip code, which appears on the currently visible map layer (Figure 5). 

Function controlling zip code boundaries:

```javascript
function highLight(zipSelected) {
    mymap.removeLayer(zipOutlines);
    zipOutlines = L.geoJson(null, {
    pane: "pane660",
    style: styleZIP,
    interactive: false
    }).addTo(mymap);
```

Full view of the result of selecting a zip code:

![](https://journal.code4lib.org/media/issue56/philogene/Figure%205.png)
**Figure 5.** View of dashboard with zip code boundary highlighted
on map and summary of data for corresponding zip code.

### Panel 3: Looking at Neighborhoods

Figure 6 shows the final section of the dashboard, which provides a view of the health specific data, summarized at  the neighborhood level. These summaries exclude the first category seen on the map (i.e., language and population statistics), as these could not be consolidated onto the neighborhood level, while continuing to be meaningful. 

![](https://journal.code4lib.org/media/issue56/philogene/Figure%206.png)
**Figure 6.** Neighborhood summary charts.

The layout of the neighborhood summary section follows a similar Bootstrap button selection method, as described above, when selecting each information category. The bar charts are created using the [Highcharts.js](https://www.highcharts.com/) library. In addition to the JavaScript file, three additional modules were added to expand the end user options: the exporting.js and export-data.js modules, which provide options to export a snapshot of a chart or a table of the raw data as a .csv or .xls file; and the accessibility.js module, which makes the charts compatible with assistive technologies. 

The Highcharts JavaScript file must be added to the HTML `<head>` element:

```html
<script src="http://code.highcharts.com/highcharts.js"></script> 
<script src="https://code.highcharts.com/modules/exporting.js"></script> 
<script src="https://code.highcharts.com/modules/export-data.js"></script> 
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
```

In addition to simplifying the creation of interactive mobile friendly web charts, the other main benefit to using the Highcharts library is that it allows you to create fully dynamic charts that can be customized both when writing the code and when being used by the end user. Figure 7 shows an example of a chart with three health metrics excluded, and the export menu options displayed. This means each individual user can customize the data included in any of the tables to reflect their specific research interest, and export the relevant data as either a figure or raw data to use as they need. 

![](https://journal.code4lib.org/media/issue56/philogene/Figure%207.png) **Figure 7.** Example of customized map, with export options visible.

## Looking Ahead: Next Steps

The Brooklyn Health Map has been a tool in development since it was created. In the time that it has been available to the public, it has been very well received and has been shared as both a research and educational tool. Since sharing this tool with faculty, I have become a regular guest lecturer in a Community Health Program Planning course, where I have introduced students to the BHM as an example of a community needs-driven project. Considering that the course is targeted towards students studying Health and Nutrition Sciences, many have expressed excitement and interest in the possibility of developing similar tools that focus on their own communities using data they generate in their own practice-based research (e.g., community surveys). 

Currently, the immediate next steps for the dashboard involve updating it to reflect the new releases of data from the sources mentioned above. For the most part, new data is released yearly, so I am investigating how best to streamline updates. 

With this in mind, one consideration is the use of jQuery in the code. While Javascript coding conventions are moving away from the use of jQuery, my main purpose for using the library was to simplify the coding process and develop the Brooklyn Health Map more quickly, since jQuery is just a library of pre-built Javascript code. Additionally, jQuery helps to ensure compatibility across different (primarily older) web browsers. However, as browsers become generally more cross-compatible and jQuery less popular, I plan to restructure parts of the code without the use of libraries.

In the longer term, I plan to expand the BHM into a New York City (NYC) health map, which includes separate dashboards for each of the five boroughs and a citywide summary. Since much of the groundwork has already been done, with this work, the hope is that most of the labor involved will be in collecting and compiling the data for the rest of NYC. From there, the resulting GeoJSON files should make the rest of the process simple for the county-level additions. However, since the citywide summary will be a completely new addition, it will likely present new design opportunities and potential obstacles in the next steps.

## About the Author

Sheena Philogene is the Science Librarian at Brooklyn College (CUNY) and the Librarian at the Brooklyn College Cancer Center (BCCC-CURE).

## Bibliography

Philogene S. 2022. The Brooklyn health map: reflections on a health dashboard visualizing connections between social factors and health outcomes in Brooklyn, NY. Journal of Map & Geography Libraries \[Internet\]. \[cited 2023 Mar 6\];18(1-2):22-40. Available from: [https://doi.org/10.1080/15420353.2022.2155752](https://doi.org/10.1080/15420353.2022.2155752)

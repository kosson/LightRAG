---
title: "Making User Rights Clear: Adding e-resource License Information in Library Systems"
source: "https://journal.code4lib.org/articles/10724"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-07-15
created: 2025-01-10
description: "Libraries sign a wide variety of licensing agreements that specify terms of both access and use of a publisher’s electronic collections. Adding easily accessible licensing information to collections helps ensure that library users comply with these agreements. This article will describe the addition of licensing permissions to resource displays using Mondo [1] by Queen’s University [...]"
tags:
  - "clippings"
---
# Making User Rights Clear: Adding e-resource License Information in Library Systems
Jenny Jing, Qinqin Lin, Ahmedullah Sharifi, Mark Swartz

Libraries sign a wide variety of licensing agreements that specify terms of both access and use of a publisher’s electronic collections. Adding easily accessible licensing information to collections helps ensure that library users comply with these agreements. This article will describe the addition of licensing permissions to resource displays using Mondo \[[1](https://journal.code4lib.org/articles/#note1)\] by Queen’s University and Scholars Portal (a service of the Ontario Council of University Libraries) \[[2](https://journal.code4lib.org/articles/#note2)\] . We will give a brief introduction to Mondo and explain how we improved Mondo to add the license permissions to different library systems. The systems we used are an ILS (Voyager), an OpenURL Link Resolver (360 Link), and a Discovery System (Summon). However, libraries can use Mondo to add the license permissions to other library systems which allow user configurations.

## Introduction

Changes in Canadian copyright law and in the way that universities approach copyright compliance, combined with the growing complexity of working with digital materials, have made copyright a priority for Canadian higher education institutions. One factor that universities worldwide have to consider when establishing copyright compliance initiatives is the vast array of database licenses that libraries sign in order to access electronic resources (e-resources). These licenses specify terms that users must follow in order to legally use these materials. For example, some licenses may allow users to include materials on learning management system sites. Others may allow libraries to loan e-resources to other libraries. This information is frequently only included in licensing agreements that are not accessible to users, or on website “terms of use” that are often ignored.

Possible outcomes of not complying with these agreements include loss of access to databases and legal action. As a result of the inaccessible nature of these licenses, and the serious consequences of having users ignore these terms, it is essential to make this licensing information accessible to all users in a format that is understandable and clear. This is why many institutions have created databases that make license permissions available to all.

When I started working as the Information Systems Librarian at Queen’s University Library in 2013, my first project was to migrate the library’s OpenURL Link Resolver from SFX to 360 Link. A major task in this project involved linking the license permissions from the Mondo database to the e-resources in the user interface of 360 link. We finished the project in two months and here is a sample record of an e-resource in 360 Link and its license page. (Figure 1).

![](https://journal.code4lib.org/media/issue29/jing/figure1.png "Figure 1. The user interface of 360 Link and license page")  
**Figure 1.** The user interface of 360 Link and license page

### The license links: before and after the migration

Queen’s University Library uses Mondo, an open source application used to manage the copyright and license information for e-resources. Our Mondo is hosted by Scholars Portal, a service provider of Ontario Council of University Libraries (OCUL). (Figure 2). Because the license pages for our e-resources are created in Mondo, our task is to add the URLs of those license links to our library systems, for example, 360 Link.

![](https://journal.code4lib.org/media/issue29/jing/figure2.png "Figure 2. The relationship between Mondo and Queen’s e-resource Knowledgebase")  
**Figure 2.** The relationship between Mondo and Queen’s e-resource Knowledgebase

In SFX, this process is accomplished by inserting the license links into the “General note” field for an e-resource. Because of the migration away from SFX, we needed to build a new model for adding license links to our e-resources in 360 Link and other library systems. Michael Vandenburg, my supervisor, suggested using 360 Link Reset \[[3](https://journal.code4lib.org/articles/#note3)\] and Summon\_Click \[[4](https://journal.code4lib.org/articles/#note4)\] to add the links to the user interface of these two systems. After discussing the priorities with my supervisor, my first step was to familiarize myself with Mondo, the open source software we use to manage the license permissions for Queen’s, as described in the next section.

## Mondo License Grinder

Mondo is an open source application developed by the University of British Columbia Library in 2009 ([https://code.google.com/p/mondo-license-grinder/](https://code.google.com/p/mondo-license-grinder/) ). It displays license permissions for online resources. (Figure 3). A sample site is available at: [http://queens.scholarsportal.info/licenses/](http://queens.scholarsportal.info/licenses/)

![](https://journal.code4lib.org/media/issue29/jing/figure3.png "Figure 3. Customized Mondo by Scholars Portal – A to Z list and a license page")  
**Figure 3.** Customized Mondo by Scholars Portal – A to Z list and a license page

### The key functions and main workflow of Mondo

First, authorized library staff must create license records for each type of e-resources and parameters are set based on the copyright agreement between the library and the database provider. Second, library staff copy the URL of the license page of an e-resource in the Mondo system and paste it in a target record in the link resolver system. For example, in 360 Link the link can be added in the “Public All Titles Note” field for the database “ABI/INFORM Global” (Figure 4). Then the “License Terms of Use” link for that e-resource will display in 360 Link.

![](https://journal.code4lib.org/media/issue29/jing/figure4.png "Figure 4. Create License page in Mondo and paste the URL in a record in 360 Link")  
**Figure 4.** Create License page in Mondo and paste the URL in a record in 360 Link

### Issues to Overcome

First, there were about 2,000 e-resources in our Serials Solutions’ knowledgebase and we needed to finish the migration from SFX to 360 Link in several weeks. Because 360 Link is a hosted service provided by Serials Solutions, we couldn’t batch load the license links for those 2,000 records into the database tables. During the summer, there were no student or library staff who could help us enter the data manually. In addition, we needed to add the links to the license information to other library systems, such as Voyager and Summon. Adding them in different library systems by myself would be very time-consuming. In order to finish this task by our deadline, we needed to find a new model for providing this service.

Second, because the URLs of those license links are not in a predictable pattern (Sample records in table 1), we could not automatically generate the license links and add them in the target library systems.

**Table 1.** The e-resource names in Mondo and the License URLs of the e-resources

| Database Names in Mondo | License Link URLs |
| --- | --- |
| ABI Inform Global | http://queens.scholarsportal.info/licenses/ABI\_Inform |
| ACM Digital Library | http://queens.scholarsportal.info/licenses/ACM\_Digital\_Library |
| 19th Century UK Periodicals Online | http://queens.scholarsportal.info/licenses/seventeenth\_eighteenth\_Century\_Burney |

Finally, because we wanted to add the license links to our Discovery System (Summon) and there is no field that we could use to display that piece of data in Summon, we needed to work out a solution which could display the license links in different library systems using a predictable pattern rather than manually entering the links.

### The Solution: Enhancements to Mondo

After reviewing all of the aspects of this project, we identified the following key issues/requirements to improve the workflow:

- We need to use a predictable, predefined pattern for the license URLs created in Mondo (For example, a base URL, plus the database name in a standard format), so that we can generate the license links with the same pattern in the target library system’s user interface.
- We need to have access to the configuration files of the target library system’s user interface (for example, we can insert JavaScript codes into the Summon search result page).
- We need to be able to read the e-resource names from the target library system’s user interface in order to generate the URL (for example, in Figure 1, the e-resource name is “ABI/INFORM Global”).
- We need to create a “general license” page for the e-resources which do not have a license page in our Mondo database.

Based on the requirements we defined above, we made the following enhancements to Mondo:

First, we added a new function in Mondo to automatically generate the URLs for the license link pages in a predefined pattern “(rawurldecode($db\_name))”. This allows us to generate the same pattern of the URLs in different target library systems’ interfaces, so that we do not need to enter the license link URLs manually in Mondo.

### Add a JavaScript file called “licenselink.php” in the Mondo/Admin folder to generate the license page URL

licenselink.php:

```php
//in index.php, get database name from url parameter
$db_name = $_GET['name'];
 
//get license
$license= $db->get_license(rawurldecode($db_name));
 
//or redirect to an information page
If($license== null){
     $license= "generic_license";
}
//redirect to license view
('Location: '.BASE_URL.'index.php?license='.$license);
```

### Modify the “Add/Edit a License” page in Mondo

Second, in order to eliminate the need to manually enter the URLs of the license link in Mondo and save time, we modified Mondo/Admin/index.php and update.php to automatically generate the URLs and save them in Mondo. (Figure 5). This also prevents typos resulting in bad links. (For example, the URL for the license page of “Bibliographie der deutschen Sprach”, might be spelled wrong if the person who enters the URL of the license page does not understand the language). The detailed changes we made in Mondo are listed below:

In mondo-license/Admin/index.php, we added the following code:

```php
$vendor=select('vendor',$vendor,$db); //Mondo code
$consortium=select('consortium',$consortium,$db); // Mondo code
$databases=select('databases', $databases, $db); //we added this line
…
 
<form id="add-license" action="update.php" enctype="multipart/form-data" method="post"><!—This line is mondo code -->
<!-- we add -->
<fieldset><label class="desc" for="database">Databases</label>
     <span style="float: left; width: 100%;">
     $databases
          <label class="fullwidth sub" for="sel_databases">Databases</label>
            <input name="import" type="file" />
     </span>
</fieldset>
```

![](https://journal.code4lib.org/media/issue29/jing/figure5.png "Figure 5. Enter the database name and URL of the license page will be generated automatically")  
**Figure 5.** Enter the database name and URL of the license page will be generated automatically

### In admin/update.php, we added the following code to get uploaded/input databases:

```php
// "database name", which corresponds to this license and was uploaded by users, are saved in here
//open the file in read mode. Notice the 'import' is the name of input in admin/licenselink.php.
$fp=fopen($_FILES['import']['tmp_name'],'r');
//the upload file needs to be csv format.
//Read in line
while ( ($line = fgetcsv($fp)) !== false) {
     if($line[0] <> 'id'){ //skip title line
          //insert to 'license_db' table
          $db->insert_data_databases($line);
     }
}
```

### Two tables were added in the Mondo database:

databases: contains all databases.(columns could be db\_id, db\_name etc.).  
license\_db: license – databases map (id, db\_id, license\_id).

In db.inc.php, we added a function called insert\_data\_databases($line):

```php
public function insert_data_databases($line){
     //assume in csv, comma ',' is the delimiter
     $field = explode(",", $line);
     $sql="INSERT INTO `db_id`, `db_name` SET `db_id`=:db_id, `db_name`=:db_name";
     $stmt=$this->preparedStatement('dblicref', $sql);
 
     //To simplify the code, we don't add error check here.
     $stmt->execute(array('db_id'=>$field[0], 'db_name'=>$field[1]));
 
}
```

## Add the license links to different library systems

After changing Mondo functions and automatically generating the license links in a predefined pattern, we were ready to add the license links to different target systems. The examples in this article will be using 360 Link, Voyager OPAC, and Summon.

### OpenURL Link resolver: 360 Link

There are three parts in the 360 Link 1.0 search result page: Citation Display, Content Provider Links, and Custom Links. In the Content Provider Links section, under “Resource” column, all the links to the providers’ sites (providers can be databases, publishers or journals) are listed. The licenses and copyrights are assigned based on the agreement our library has with the providers, so we need to assign our “License Terms of Use” links to the provider information. (Figure 6).

![](https://journal.code4lib.org/media/issue29/jing/figure6.png "Figure 6. Sample License links in 360 Link 1.0 User Interface")  
**Figure 6.** Sample License links in 360 Link 1.0 User Interface

First, my supervisor suggested that we test 360 Link Reset \[[3](https://journal.code4lib.org/articles/#note3)\] as the starting point. After reading the documentation and consulting with Matthew Reidsma, the author of the program, we learned that we could modify the 360 Link 1.0’s user interface by inserting JavaScript in 360 Link 1.0 Admin > Advanced Options > Page head > Head HTML.

Second, we defined the pattern for the URLs of the license links to:“http://baseURL+e-resourceName”, in order for us to add those URLs to 360 Link user interface. The baseURL is the http address our Mondo service provider gave us. For example: “https://queens.scholarsportal.info/licenses/license/?name=”. The “e-resourceName” is the name of the e-resource.

We used a JavaScript file called “360\_get\_names.js” to add the URLs of the license links to 360 Link user interface and it follows a two-step process outlined here:

1. Find the e-resource names in the 360 Link page (The e-resource names are given as the elements of a CSS class called “SS\_DatabaseHyperLink”).
2. Add the license links to the e-resource using the same pattern we defined in Mondo. (http://baseURL+e-resourceName).

The JavaScript is listed at the following URL: [https://gist.github.com/happyrainb/81541e23049e30b281d2](https://gist.github.com/happyrainb/81541e23049e30b281d2)  
**360\_get\_names.js:**

```javascript
$(document).ready(function() {
     $(".SS_DatabaseHyperLink").each (
          function() {
               $('<a target="_blank" href="https://baseURL/licenselink.php?name='+(urlencode($(this).text()))+'">[License of Use]</a>').insertAfter($(this));
          $('<span>&nbsp;</span>').insertAfter($(this));
          }
      );
function urlencode(str) {
/ //discuss at: http://phpjs.org/functions/urlencode/
```

(**function urlencode**: this function was copied from phpjs.org and the last line of this function needs to be changed to “.replace(/\\+/g, ‘%20’);”. This function resolves the linguistic difference between PHP and Javascript’s URL encoding functions. Javascript uses the “%20” encoding to represent a spaces, while PHP uses “+.” The difference in URLs would lead users to the general message page instead of the specific database license. Replacing the “+” with “%20” while generating the URL results in consistent URLs.)

The code above simply goes through each link class (“.SS\_DatabaseHyperLink”) and appends a license link to it with the URL Pattern (http://baseURL+e-resourceName) as we defined in Mondo. The name parameter is also read from the same link.

#### The new version of 360 Link

In the spring of 2015, a new version of the 360 Link interface was released. Comparing with 360 Link 1.0, the new 360 Link makes it easier to reference an external JavaScript file, and offers more customization options with configurable custom links. (According to Eddie Neuwirth, the Product Manager Lead – Discovery Services at ProQuest, the new 360 Link interface is loosely based on some of the design concepts from Matthew Reidsma’s 360 Link Reset but available out-of-the-box). In order to test the License links, we made a sandbox on our server and added the links to the 360 Link (Figure 7) by making a new version of the get-license.js, which we called get-license-2.js.

![](https://journal.code4lib.org/media/issue29/jing/figure7.png "Figure 7. Sample License links in 360 Link new version User Interface")  
**Figure 7.** Sample License links in 360 Link new version User Interface

In the 360 Link new version user interface, the e-resources all have the same CSS class name: ‘.resource-name’. We just need to get each of them and generate the license link to the e-resource using the baseURL and the pattern we defined in Mondo. We list the code for the get-license-2.js below:  
**get-license-2.js:**

```javascript
jQuery(document).ready(function() {
    // get all the elements that have a class name '.resource-name'
    var links = jQuery(".resource-name");
 
    // go through the elements and add a link after each one based on the text each element contains
    for(var i =0; i<links.length; i++){
        // turn the current item into a jquery object
        var el = jQuery(links[i]);
 
        // create a new jquery object which is the new link
        var new_link = jQuery('<a target="_blank" href="https://baseURL/licenselink.php?name='+(urlencode($(this).text()))+'">[License of Use]</a>');
        new_link.insertAfter(el);
 
        var empty_span = jQuery('<span>&nbsp;</span>');
        empty_span.insertAfter(el);
    }
});
```
### Voyager 8 and 9

After we added the license permissions to 360 Link in the summer of 2013, we discussed this process with our partners at Western University. We learned that they were able to add the license links to the OPAC of their ILS and Discovery System (Taufique, 2015), then we tried to add the license links of the e-resource to our Voyager OPAC.

Having read the Voyager manual and consulted Voyager-L, we searched the web and found a presentation about editing the Voyager OPAC (Guy, 2010) and a website with documents for customizing the Voyager skin \[[5](https://journal.code4lib.org/articles/#note5)\]. They helped us identify the file we needed to modify in Voyager in order to add links to the skin (the display.xsl file in the contentLayout folder in WebVoyage). After testing the changes in our Voyager Sandbox, we managed to add the license links to Voyager OPAC using the same pattern that Scholars Portal defined in Mondo. (Figure 8)

![](https://journal.code4lib.org/media/issue29/jing/figure8.png "Figure 8. Sample license links in Voyager OPAC – Record page")  
**Figure 8.** Sample license links in Voyager OPAC – Record page

After we discussed this issue with our cataloger, we learned that we can insert the URL of the license links to holdings record tag 856 subfield z. Because we didn’t have library staff or student to help us add the license links manually in Voyager Catalogue Module, we tried to add the license links in Voyager in the OPAC configuration files. After testing in the Webvoyage sandbox, we found the block which is responsible for the holdings 856 subfield z is in the template ”BMD3000?. The display.xsl file is listed in the following URL: [https://gist.github.com/happyrainb/71da337b043d02757691](https://gist.github.com/happyrainb/71da337b043d02757691)  
**display.xsl:**

```xml
<xsl:variable name="providerData">
     <xsl:value-of select="slim:subfield[@code='z']" />
</xsl:variable>
<xsl:variable name="provider">
      <xsl:choose>
           <xsl:when test="contains($providerData, '- ')">
        <xsl:value-of select="substring-after($providerData, '- ')" />
       </xsl:when>
       <xsl:when test="contains($providerData, ',')">
         <xsl:value-of select="substring-before($providerData, ',')" />
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="$providerData" />
       </xsl:otherwise>
     </xsl:choose>
</xsl:variable>
 
<xsl:variable name="baseURL">https://baseURL/licenselink.php?name=
</xsl:variable>
 
<a href="{$baseURL}{fn:encode-for-uri($provider)}">[License Terms of Use] </a>
<br/>
```

The XML above simply defines a baseURL variable and uses it in the newly added XML for the links. The provider name is extracted from the data in the Voyager OPAC interface and the license links are inserted in the XML file under subfield “z”.

### Summon 1.0: Server-Side Data Endpoint API

After we discussed this process with our partners at the University of Toronto, we learned that their team added the license information in Summon 1.0 using Summon API (Taufique, 2015). After testing in December 2013, it seems that the only way we can add the license links to Summon 1.0 is to use 360 Link API, because we don’t subscribe to the Summon API service.

The license data that we want to show the user is generated by a PHP script which we refer to as the Server-Side Data Endpoint API. This is a Server-Side script that generates all the data we want to show the user when they “hover” over the license link for a specific search result. We can see an example of the popup in our testing site (Figure 9):

![](https://journal.code4lib.org/media/issue29/jing/figure9.png "Figure 9. Sample license links in Summon 1.0 – Record page")  
**Figure 9.** Sample license links in Summon 1.0 – Record page

The data in the popup is loaded via AJAX. The AJAX call for each popup is made when the page loads all the search results. The AJAX call makes a request to the Server-Side Data Endpoint API, using an HTTP Request, which then returns a response with the entire popup HTML populated with the relevant data. Therefore, the interface must simply show that HTML to the user once the AJAX call has completed successfully.

#### Add the popup to the Summon Interface

The search result list from Summon 1.0 needs to show the license information for each individual entry. Because the library decided to show the license links only for articles, we need to find the Journal Article entries in the Summon search result page first. The most easily deployable solution was to use client side functionality on the browser to dynamically add the links and respective popups for each search result. Since the search results are generated in a pattern it is easy to find that pattern and use it to make the modifications we need.

The following figure shows the HTML structure for the entries area we are interested in. (Figure 10)

![](https://journal.code4lib.org/media/issue29/jing/figure10.png "Figure 10. The HTML structure of Summon 1.0 user interface – record display")  
**Figure 10.** The HTML structure of Summon 1.0 user interface – record display

We can see that each search result is wrapped in a “div” element with the class “.document”. Inside each of these “div” elements we have the necessary information to make our AJAX Request and obtain the relevant popup data to show the user when prompted.

Given the structure and patterns we have found, we could now write code to enable the computer to generate the links to help the user quickly access license information for any viable search result journal. As suggested by my supervisor, we modified the Summon\_clicks.js. \[[4](https://journal.code4lib.org/articles/#note4)\] The complete JavaScript code (Summon1-use360API.js) is listed at the following github URL:  
[https://gist.github.com/happyrainb/946e708a60373305375a](https://gist.github.com/happyrainb/946e708a60373305375a)  
For the purposes of this section, the important part of this script starts at line 94 of the file from the github link above.

First, we must iterate over each search result (‘.document’) class element. For each search result we can read the metadata in order to make our AJAX calls to our Server-Side Endpoint API, explained in the previous section. Essentially, there are two tasks performed for each search result which are listed below in order:

1. **Extract ISSN and DOI from the body**  
After we read the 360 Link API documents and two articles (Durno, 2012 and Talsky, 2008) , we decided to use the DOI and ISSN as parameters to supply the AJAX call and make a request to the Server-Side Data Endpoint API. It is important for us to get the ISSN and DOI because we need to give these parameters to the Server-Side Endpoint API in order to receive the correct information for an article, such as the e-resource names, the dates available, etc. The code block below is responsible for this:Summon1-use360API.js:

```javascript
sections = $(this).find('div.previewDocumentContent').find(".section");
var issn = '';
var doi = '';
$(sections).each (
     function() {
          if ($(this).find('.title').text() == 'ISSN') {
               issn = $(this).contents().filter(function() {
                    return this.nodeType == 3;
               }).text();
          }
          if ($(this).find('.title').text() == 'DOI') {
               doi = $(this).find('.title').next().text();
          }
     }
);
```

After we get the ISSN and DOI data from the above code, we can send them to the php script to make the popup and display the article link, database link, holdings data, etc., in the mini-window shown in Figure 9.
2. **Make AJAX Call to Server-Side Endpoint API with the above parameters and add resulting popup code to the HTML DOM.**  
**Summon1-use360API.js**

```javascript
provider='';
$.post('Summon1-use360Api.php', { 'issn': issn, 'doi' : doi}, function(data) {
     $(publicationLocation).find(".summary").append('
     <div style="display: none;">'+data+'</div>
     ');
 
     $(publicationLocation).find(".summary").children('div').first().mouseover(function(){$(this).stop(true,true).show();}).mouseout(function(){$(this).stop(true,true).fadeOut();});
 
     $(publicationLocation).find(".summary").children('div').first().mouseover(function(){$(this).stop(true,true).show();}).mouseout(function(){$(this).stop(true,true).fadeOut();});
 
     $(publicationLocation).find(".summary").children('div').first().find('.theme-close').click(function(){$(this).parents('div.summary').children('div').first().hide();});
});
 
$(publicationLocation).find(".summary").children('a').first().mouseover(function(){$(this).next('div').stop(true,true).show();}).mouseout(function(){$(this).next('div').stop(true,true).fadeOut();});

```


When this code successfully executes, the user will be able to hover the license link and view the the license information for each of the e-resources within the popup.
3. **Use 360 Link API to get data and display them in the popup**  
In the above JavaScript file we get the ISSN and DOI of an article from Summon user interface and provide them to a PHP script (Summon1-use360Api.php) to make the elements in the popup. The PHP Script is listed at the following github URL: [https://gist.github.com/happyrainb/2608d28cfdcfdc54350a](https://gist.github.com/happyrainb/2608d28cfdcfdc54350a)  
**Summon1-use360Api.php:**

```javascript
$queensUrl= xxx; //You can find this in your 360 Link document provided by ProQuest
$baseUrl = yyy; //You can find this in your 360 Link document provided by ProQuest
$key=zzz; //You can find this in your 360 Link document provided by ProQuest
 
$mandatoryFields = array('version' => '1.0'); //this is required in 360 Link API document
$optionalFields = array('issn' => $issn, 'volumn' => $volumn,'doi' =>$doi); //make the query string
 
$fields = array_merge($mandatoryFields, $optionalFields);
$queryString = http_build_query($fields);
 
$url = $baseUrl.'?'.$queryString; //make the url of the query string combining the API key, baseURL, etc.
$xml = get_xml_result($url); //the data is displayed in XML format
 
$xmldomdoc = new DOMDocument();
$xmldomdoc->loadXML($xml);
….
….
foreach ($xmldomdoc->getElementsByTagName('linkGroup') as $dataGroup) //assign the value to each
{ //elements which will be displayed in the popup window
     $url_elements = $dataGroup->getElementsByTagName('url');
     $data=$dataGroup->getElementsByTagName('holdingData')->item(0);
     $urldata=$dataGroup->getElementsByTagName('url');
 
     $results[$counter]['databaseName'] = $data->getElementsByTagName('databaseName')->item(0)->nodeValue;
     $startDate = $data->getElementsByTagName('startDate')->item(0)->nodeValue;
     $endDate = ($data->getElementsByTagName('endDate')->item(0))?($data->getElementsByTagName('endDate')->item(0)->nodeValue):'';
     $results[$counter]['dateAvailable'] = ($startDate. '-' .$endDate);
     $results[$counter]['databaseId'] = $data->getElementsByTagName('databaseId')->item(0)->nodeValue;
```

We supply the DOI and ISSN parameters to the AJAX call which returns an XML result from which we can extract information about the article. We use fields such as “dateAvailable”, “databaseName”, and so on. It is important to note that we use the “databaseName” field as the key to retrieve relevant license information for a given article; this key will be used in the next step. For the purposes of this section, the important part of this script starts at line 212 of the file from the github link above.  
**Summon1-use360Api.php:**

```php
<tr>
 <td valign="middle" align="center" class="c1">
     <div class="cl" id="ArticleCL">
          <a target="_blank" href="http://<?php echo $key;?>.scholar.serialssolutions.com/log?L=<?php echo $key;?>&D=<?php echo $result['databaseId'];?>&P=Link&U=<?php echo $result['article_url']; ?>"><img src="http://library.queensu.ca/images/xxx/article-sm.png"></a>
    </div>
</td>
<td valign="middle" align="center" class="ResultsRow">
    <div class="cl" id="JournalCL">
         <a target="_blank" href="http://<?php echo $key;?>.scholar.serialssolutions.com/log?L=<?php echo $key;?>&D=<?php echo $result['databaseId'];?>&P=Link&U=<?php echo $result['journal_url'];?>"><img src="http://library.queensu.ca/images/xxxx/journal-sm.png"></a>
   </div>
</td>
<td valign="middle" class="c1" class="ResultsRow">
    <span><?php echo $result['dateAvailable'];?></span>
</td>
<td valign="middle" class="ResultsRow">
     <div class="cl" id="DatabaseCL"> <span>
         <a href="http://<?php echo $key;?>.scholar.serialssolutions.com/log?L=<?php echo $key;?>&D=<?php echo $result['databaseId'];?>&P=Link<?php echo $result['source'];?>"><?php echo $result['databaseName'];?></a>
    </div>
</td>
<td valign="middle" class="ResultsRow">
   <span><?php echo $result['License Information'];?></span>
   <span><a href="https://baseURL/licenselink.php?name=<?php echo rawurlencode($result['databaseName']);?>">License Information</a></span>
</td>
</tr>
```


The above code is responsible for displaying the elements in a table in the popup window. We make a mini-version of the 360 Link search result page using 360 Link API and assign the license links to each of the e-resources. This way we provide the complete information for permitted use of the e-resource and it’s easy for the users to understand because it’s similar to the 360 Link user interface.

### Summon 2.0: Available Methods to Modify Summon 2.0

Modifying Summon 2.0 to achieve similar functionality for license links was easier because we found a script called “dnl\_summon\_custom\_step3.js” \[[6](https://journal.code4lib.org/articles/#note6)\] from the articles “Hacking Summon 2.0 The Elegant Way” in the Code4Lib journal (Bailey, 2014) and “Exposing Library Services with AngularJS” (Voß, 2014). All of them helped us customize the Summon 2.0 user interface. Although all the techniques described in the Code4Lib article “Hacking Summon 2.0 The Elegant Way” are good and have their own merits, we decided to use “Technique 2: Direct DOM Manipulation” because it was closely related to the same methodology as the techniques we used to modify Summon 1.0.

The complete codes are listed at the following github URL:  
[https://gist.github.com/happyrainb/e0f546390436a1c26ac2](https://gist.github.com/happyrainb/e0f546390436a1c26ac2)

For the purposes of this section, the important part of this script starts at line 217 of the file from the github file listed above.

#### Add License Links to the Summon 2.0 user Interface

Our approach to modify Summon 2.0 was to identify the HTML Structure that was used to store the relevant source name data and then to create links that directly send the user to the license information.

Compared to Summon 1.0, Summon 2.0 was easy because it uses AngularJS, a standard MVC client-side framework that is documented and can easily be understood by a programmer. We decided to inject our code into a “watchCollection” observer, which is a facility provided by AngularJS to detect changes made to a collection of data such as our search results, because we wanted to generate the links every time the list of search results or “feeds” were changed.

The structure of the search results seemed more complex, but after hacking away on the JavaScript console, we were able to find the correct jQuery selectors to get the elements that we need from the main item which can be seen below (Figure 11):

![Figure 11. Main HTML element pattern which represents each search result](https://journal.code4lib.org/media/issue29/jing/figure11.png "Figure 11. Main HTML")  
**Figure 11.** Main HTML element pattern which represents each search result

The dynamically-generated links all have the same endpoint: a simple URL Pattern, shown in the pattern below:

http://baseURL/licenselink.php?name={{SOURCE NAME}}  
URL pattern: {{baseURL}} + {{Source Name}}

So for example if we wanted to get information regarding Source: “ACM Digital Library” we would enter the following URL into the browser: http://baseURL/licenselink.php?name=ACM Digital Library.  
**Summon2-license.js:**

```javascript
//watch feed change, add license links
function watchFeedChange( ) {
     myscope.$watchCollection('feed', function(){
          //delay 1 sec. to wait for DOM to actually finish loading
          setTimeout(function (){
 
          ... Link Generation Code ...
 
          },1000);
     });
} //watch feed change()
```

We can see the feed change event handler above; this handler basically waits for search or feed changes and runs our link generation code when such changes are detected.

After we learned about the Summon 2.0 user interface, we found that the e-resource is called “Source” in the detailed record popup on the right side of the screen. The next step for us was to get the data in this field and assign the license links for those e-resources. (Figure 12).

![](https://journal.code4lib.org/media/issue29/jing/figure12.png "Figure 12. Sample license links in Summon 2.0 preview server – Record page")  
**Figure 12.** Sample license links in Summon 2.0 preview server – Record page

The source names (“\[ABI/INFORM Global\]” and “\[Academic OneFile\]”in Figure 12) we need are visible in the popup on the right and it appears when we mouse over the record listed in the search result. If we observe the figure above, we can see that the popup has information regarding the first record in the search results, which is where the user has “mouse-over”.

#### Dynamic Link Generation

In this application we do not need to embed the links into the HTML. When the user clicks the “empty” license link, we dynamically build the appropriate URL for those links and redirect the user to it when the user clicks any of the generated links.

1. **The “Source: \[License Information\]” link**  
Upon the “watchCollection” event triggering due to the search results changing, the first thing the JavaScript code (Summon2-license.js) does is to add an “empty” link called “Source: \[License Information\]” at the bottom of each journal article. This will prompt the user to click if they require license information. The following code performs the task of adding these “empty” links:

```javascript
//for each content type display, do these
$(".contentType.ng-scope span[bo-bind='doc.content_type | translate']").each(function(){
 
     //if it's journal article AND hasn't been processed by our custom script
     if($(this).text().indexOf('Journal Article') != -1 && $(this).not('.processed').size() > 0 ) {
 
          //add a class called "processed" so we can keep track, then add a custom link
          $(this).addClass('processed').parent().append('
          Source: <a class="mycustomlink" href="#" target="_blank"> [License Information]</a>');
     }
});
```

First, we find all the `<li>` items shown in Figure 11 by using JQuery to select them; then we simply check if the text “Journal Article” is in the selected HTML, since we are only handling journal articles. If the item is an article, then we inject the “empty” “Source: \[License Information\]” links.
2. **Extract the Source name and define the pattern for the license link URL**  
After the user clicks the “Source: \[License Information\]” link, the license links of each e-resource for that journal article (For example, “\[ABI/INFORM Global\]” and “\[Academic OneFile\]” in Figure 12) are displayed. (If the user does not click the “\[License Information\]” link, the two license links won’t be displayed).In order to generate links to the relevant license information we need to extract the source data. An example of this data can be seen in Figure 12 on the right side. Because AngularJS always keeps its data inside the models of the application, we need to access the model data from the JavaScript object named “myscope.preview.doc” in the Summon 2.0 user interface.To extract the source data in the popup, we defined two JavaScript functions listed below:

```javascript
function getContainerValue(){
     if(myscope.preview.doc.databases.length > 0){
          return myscope.preview.doc.databases[0].name; //extract the Source name
     } else {
          return myscope.preview.doc.publisher;
     }
}
 
function buildUrl(source_name){ //define the pattern for the url
     return "http://baseURL/licenselink.php?provider="+(urlencode(source_name));
 
}
```


3. **Generate the URL based on the extracted data and redirect the user to it.**  
The source names are stored in the “myscope.preview.doc.databases” array. If any source names were found, we generate the relevant links for the user to click. If the source was not found for any reason then we redirect the user to a general license page (“[http://library.queensu.ca/360 Link/360sample.htm](http://library.queensu.ca/360%20Link/360sample.htm)“), which informs the user to contact the Copyright office for license information of that e-resource.

```javascript
$("a.mycustomlink").click(
     function(){
 
          if( $(this).parent().children('div.license_popup').length ){
               $(this).parent().children('div.license_popup').remove();
          } else {
               if(myscope.preview.doc.databases && myscope.preview.doc.databases.length > 0){
                    var new_node = '
                    <div class="license_popup">
                    ';
 
                    for (var i = 0; i < myscope.preview.doc.databases.length; i++) {
                         new_node += '<span class="icon sprite-s format-sprite format--generic_16px format-journal_article_16px"></span>';
                         new_node += '<a class="mycustomlink2" href="' + buildUrl(myscope.preview.doc.databases[i].name) + '" target="_blank"> ['+ myscope.preview.doc.databases[i].name +']</a>';
                         new_node += '<br />';
                    };
                    new_node += '</div>';
                    $(this).parent().append(new_node);
 
               } else {
                    window.location.href = "http://library.queensu.ca/360 Link/360sample.htm";
               }
          }
          return false;
     }
);
```

When the “empty” license link is clicked we check that source data is available by checking the “myscope.preview.doc.databases” array existence and length. If such array is available and has at least one source then we proceed to insert the HTML code to create the links for the user to click if needed.

## Lessons learned

### Hosted Service provided by vendors

360 Link is a hosted service provided by Serials Solutions. We could not load data into 360 Link’s database, which means we could only enter data manually from the vendor’s client site. This made it difficult for us to modify the records efficiently.

In addition, there is no testing environment in 360 Link and Summon. In Voyager, we have a sandbox folder in which we can test our code, but in 360 Link and Summon we need to set up those testing environments ourselves. We also need to wait at least 24 hours to see the changes we made in 360 Link and Summon, which means if we made a mistake in the configuration, the interface will be displayed with this mistake for 24 hours.

### Documentation and community support

The biggest challenge for adding the license links in the Voyager OPAC is that we didn’t find much documentation in the Voyager manual about customizing the OPAC skin. Through a Google search, we found a number of useful presentation and documents made by other Voyager users on how to do similar tasks, which helped us to understand and modify the configuration files in Voyager.

One key reason we were able to finish this project is the community support we got from the users groups. For example, the Summon-clicks.js for Summon 1.0 and dnl\_summon\_custom\_step3.js for Summon 2.0 and the articles from the Code4Lib Journal had already solved several issues we faced. We built our solutions using those scripts and they saved us a lot of time to finish the project on time.

### Consortia and partners

Because our service provider Scholars Portal hosted Mondo for us, we could not edit the license page URLs in the database table, or load all of the URLs into Mondo. We needed to work closely with Scholars Portal to modify the data in our Mondo. Fortunately, Scholars Portal helped us whenever we needed their support.

We also learned a lot from other libraries in the OCUL consortia, such as Western University and University of Toronto. They provided us with solutions for adding the license links in the systems that they use, and they shared their experiences with us. This is another key reason why we could successfully finish this project by the deadline.

## Summary

From the summer of 2013 to Spring 2014, we worked with Scholar Portals and added the license links to the 360 Link and Voyager in production, as well as the Summon 1.0 testing site. Because Summon 2.0 uses AngularJS, which was new to us, and we did not have a plan for migrating our discovery system from Summon 1.0 to Summon 2.0 by the Summer of 2015, we waited to add the license link to Summon 2.0 after reading articles posted on Code4Lib and consulting with Ahmedullah Sharifi, an expert in AngularJS.

Interpreting, managing and providing licence terms to library users is a complex task. Integrating the information in the Mondo database into tools like Summon and 360 Link allow users to access this information at their point of need, which helps libraries meet their legal requirements while making it easy for users to find this information. With access to this information, users may even discover that they can use items in ways that they didn’t realize were possible, for example, as a pdf upload on a learning management system course page or in a print course package of readings.

Throughout this project, we needed to work with different vendors, user communities and our partner Scholars Portal to find solutions for our needs. This is not a project accomplished by our group, but a project supported by the library community. We hope this article can help other libraries provide user right/license information to their e-resources and avoid the issues/problems we had during our implementation. All of the scripts/codes described in this article are avaliable at the following URL: [https://gist.github.com/happyrainb](https://gist.github.com/happyrainb).

Libraries have started using more vendor hosted services than before. These vendor-hosted services make customizing library systems more difficult, especially when the vendors release new versions of their systems and change the user interface, system configuration, etc. We have to deal with different types of issues and be creative in solving them. In addition, we need to work with peers in consortial universities, members in the same user group and vendor support teams to find the solutions to our unique needs.

## What’s Next?

Making license information accessible at points of need for users drives future integration possibilities for Mondo. For example, information from Mondo can be included in proprietary databases or in university libraries’ Digital Asset Management tool or Institutional Repositories.

By including the copyrights/access rights information like this in a Digital Asset Management System (in the Digital Preservation Process \[[7](https://journal.code4lib.org/articles/#note7)\]) or in an Institutional Repository (In the submission process), libraries can showcase the flexibility of these resources for users as most of this material is open access and can be used for all of the purposes generally included in Mondo. This can help encourage the open access movement, while also increasing the use of library provided tools.

## Acknowledgements

The following people helped us with this project. Without their support we wouldn’t have been able to add the license links to our systems. We gratefully acknowledge their assistance.

360 Link/Summon: Matthew Reidsma, Web Services Librarian, Grand Valley State University; Wittawat Meesangnil, Systems Librarian, DiMenna-Nyselius Library, Fairfield University

Mondo: Teresa Lee, E-Resource & Access Librarian, University of British Columbia

Our partners: Amaz Taufique, Assistant Director of Systems and Technical Operations; Marc Lalonde, Web Coordinator, Librarian, University of Toronto; Christina Zoricic, Acting Head, Metadata Access, Western University.

Our Project team: Michael Vandenburg, Associate University Librarian; Mark Swartz, Copyright Specialist; Anne Brule & Ellen Symons, E-Resource Librarian; Katie Legere, Web Coordinator; Andrew DaCosta, Web Development Technician; Alex Fletcher, Application Support Technician.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] [1\. https://code.google.com/p/mondo-license-grinder/](https://code.google.com/p/mondo-license-grinder/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Scholars Portal is a service provider of Ontario Council of University Libraries (OCUL). It hosts the e-resource license database using Mondo for Queen’s University Library, as well as the other OCUL members’ license databases.

\[[3](https://journal.code4lib.org/articles/#ref3)\] [https://github.com/gvsulib/360 Link-Reset](https://github.com/gvsulib/360%20Link-Reset)

\[[4](https://journal.code4lib.org/articles/#ref4)\] [https://github.com/gvsulib/Summon-Stats/blob/master/summon\_clicks.js](https://github.com/gvsulib/Summon-Stats/blob/master/summon_clicks.js)

\[[5](https://journal.code4lib.org/articles/#ref5)\] [http://systemsmgr.wikispaces.com/Voyager\_Customizations](http://systemsmgr.wikispaces.com/Voyager_Customizations)

\[[6](https://journal.code4lib.org/articles/#ref6)\] [http://mlib.fairfield.edu/summonjs/dnl\_summon\_custom\_step3.js](http://mlib.fairfield.edu/summonjs/dnl_summon_custom_step3.js)

\[[7](https://journal.code4lib.org/articles/#ref7)\] [http://public.ccsds.org/publications/archive/650x0m2.pdf](http://public.ccsds.org/publications/archive/650x0m2.pdf)

## Reference:

Bailey A and Back G. 2014. Hacking Summon 2.0 The Elegant Way. The Code4Lib Journal 26. \[cited 2015 April 16\]. Available from: [http://journal.code4lib.org/articles/10018](https://journal.code4lib.org/articles/10018)

Durno J. 2012. Hacking 360 Link: A hybrid approach. The Code4Lib Journal 18. \[cited 2015 April 16\]. Available from: [http://journal.code4lib.org/articles/7308](https://journal.code4lib.org/articles/7308)

Guy L. 2010. Voyager 7 Tomcat WebVoyage Interface for Dummies, or: What Will it Take to Customize Our New User Interface and Remain Sane? ELUNA 2010, 11-13 May 2010, Fort Worth, Texas. \[cited 2015 April 16\]. Available from: [http://documents.el-una.org/456/](http://documents.el-una.org/456/)

Voß J and Horn M. 2014. Exposing Library Services with AngularJS. The Code4Lib Journal 26. \[cited 2015 April 16\]. Available from: [http://journal.code4lib.org/articles/10023](https://journal.code4lib.org/articles/10023)

Talsky D. 2008. Auto-Populating an ILL form with the Serial Solutions Link Resolver API. The Code4Lib Journal 4. \[cited 2015 April 16\]. Available from: [http://journal.code4lib.org/articles/108](https://journal.code4lib.org/articles/108)

Taufique A, Zoricic C, Jing J and Lalonde M. 2015. Transparent Licenses: Making User Rights Clear. OLA Super Conference 2015, Toronto, ON. \[cited 2015 April 16\]. Available from: [http://www.slideshare.net/happyrainb/ola-2015-ourpresentation](http://www.slideshare.net/happyrainb/ola-2015-ourpresentation)

## About the Authors

Jenny Jing has more than ten years of experience working as the Systems Librarian in different organizations including: Queen’s University, Harvard Business School and Memorial Sloan Kettering Cancer Center. Her experience includes: migrating ILS systems, building library IR and digital repositories. If you have questions/comments about 360 Link, Summon 1.0 and Voyager solutions described in this article, please contact Jenny at: [jingjenny@hotmail.com](https://journal.code4lib.org/articles/)

Qinqin Lin is a graduate of the University of Toronto’s Computer Science program and has worked for University of Toronto since 2009 as a programmer. She works on a variety of Scholars Portal projects including enhancing Ontario Council of University Libraries (OCUL)’s new usage rights database, OUR and the Scholars Portal ebooks platform. If you have questions/comments about Mondo functions described in this article, please contact Qinqin at: [qinqin.lin@utoronto.ca](https://journal.code4lib.org/articles/)

Ahmedullah Sharifi is currently the Senior Software Engineer at Vegrif Group Inc. in Toronto, Ontario. Sharifi focuses on developing software technology to fully utilize computers and their endless potential in many areas of application. He has been published in the ICME 2006 for his work with fluid interfaces at the University Of Toronto. If you have questions or comments about AngularJS and Summon 2.0 functions described in this article, please contact Ahmedullah at: [ahmed@vegrif.com](https://journal.code4lib.org/articles/)

Mark Swartz is the Copyright Specialist at Queen’s University. In this position, he works with librarians, staff, faculty and instructors across all faculties and schools to develop web-based information and educational programs on copyright. Mark has held two other positions at Queen’s – as an education librarian and as the online course developer for the Continuing Teacher Education Department.
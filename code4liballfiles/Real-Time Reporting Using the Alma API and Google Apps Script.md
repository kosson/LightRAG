---
title: "Real-Time Reporting Using the Alma API and Google Apps Script"
source: "https://journal.code4lib.org/articles/17695"
author:
  - "David Fulmer"
published: 2023-12-04
created: 2025-01-10
description: "When the University of Michigan Library migrated from the Aleph Integrated Library System (ILS) to the Alma Library Services Platform (LSP), many challenges arose in migrating our workflows from a multi-tier client/server structured ILS with an in-house, locally hosted server which was accessed by staff through a dedicated client to a cloud-based LSP accessed by staff through a browser. Among those challenges were deficiencies in timely reporting functionality in the new LSP, and incompatibility with the locally popular macro software that was currently in use. While the Alma LSP includes a comprehensive business intelligence tool, Alma Analytics, which includes a wide variety of out-of-the-box reports and on-demand reporting, it suffers from one big limitation: the data on which the reports are based are a copy of the data from Alma extracted overnight. If you need a report of data from Alma that is timely, Analytics isn’t suitable. These issues necessitated the development of an application that brought together the utility of the Alma APIs and the convenience of the Google Apps Script platform. This article will discuss the resulting tool which provides a real-time report on invoice data stored in Alma using the Google Apps Script platform."
tags:
  - "#real-time/reporting"
  - "#Alma"
  - "#API"
  - "#Google/Apps"
  - "#Aleph"
  - "#migration"
---
# Real-Time Reporting Using the Alma API and Google Apps Script

David Fulmer

When the University of Michigan Library migrated from the Aleph Integrated Library System (ILS) to the Alma Library Services Platform (LSP), many challenges arose in migrating our workflows from a multi-tier client/server structured ILS with an in-house, locally hosted server which was accessed by staff through a dedicated client to a cloud-based LSP accessed by staff through a browser. Among those challenges were deficiencies in timely reporting functionality in the new LSP, and incompatibility with the locally popular macro software that was currently in use. While the Alma LSP includes a comprehensive business intelligence tool, Alma Analytics, which includes a wide variety of out-of-the-box reports and on-demand reporting, it suffers from one big limitation: the data on which the reports are based are a copy of the data from Alma extracted overnight. If you need a report of data from Alma that is timely, Analytics isn’t suitable. These issues necessitated the development of an application that brought together the utility of the Alma APIs and the convenience of the Google Apps Script platform. This article will discuss the resulting tool which provides a real-time report on invoice data stored in Alma using the Google Apps Script platform.

## Introduction

A long-standing and important workflow in the University of Michigan Library’s Acquisitions area involves exporting information about invoices from our Integrated Library System (ILS)/Library Services Platform (LSP) to the University of Michigan’s Central Financial System. Before the migration from Aleph to Alma by the University of Michigan Libraries in 2021, a well-established local workflow using a combination of Electronic Data Interchange (EDI), spreadsheets, macro software, and manual data entry prepared the invoice information in Aleph for its export, processing, and importing into the University’s Central Financial System. But this workflow was not compatible with the new LSP, Alma, and needed to be adapted on a tight deadline.

Alma has an integration to interface between Alma and financial systems called the Enterprise Resource Planning (ERP) integration . Included in this integration is an Alma job to ‘Export Invoices for Payment’. Invoices to be exported from Alma are designated by being given the invoice workflow status “Waiting to be Sent”. The integration job runs nightly and changes the invoice workflow status of exported invoices in Alma to “Closed” and creates an XML file of the exported invoices as output. This exported XML file is processed locally into a format that can be understood by the University’s Central Financial System and then transmitted to the University’s Central Financial System via email.

Two key components of this export process are the presence and correct formatting of an invoice reference number, or batch number, and a properly formatted invoice note in each invoice exported so that each exported invoice can be included in the appropriate batch and imported into the University’s Central Financial System successfully. If an invoice lacks a batch number, or if the invoice does not have a note that conforms to the proper formatting, the export of the invoice information from Alma and its import into the University’s Central Financial System will not be successful, requiring time-consuming manual intervention.

As may be seen, because each invoice is exported the night that it is processed, any quality check of the invoices must be performed before the export of the invoices that evening. Alma Analytics  is the reporting platform built into Alma and it provides extensive reporting capabilities in subject areas of Alma including Users, Loans, Fulfillment, Electronic Inventory, Physical Inventory, and Acquisitions. However, the reports produced by Alma Analytics are based on a copy of the data from Alma made daily for the purpose of querying, so a report that needs to have current data from Alma cannot be produced by Alma Analytics. The Alma Analytics reporting platform cannot be used to review invoices before export as the changes made to the invoices throughout the day will not be reportable in Alma Analytics until after the full database refresh or extract, transform, and load (ETL), as this happens nightly after the invoices have been processed. And double-checking invoices in the Alma UI would be a time-consuming manual process consisting of many clicks.

Before migrating to Alma, the library was able to use [MacroExpress](https://www.macros.com/), an application that could navigate around the Aleph client in imitation of user actions, clicking on areas of the client or designating fields, and aiding in the invoice processing workflow by helping to format invoice notes correctly. But as the migration to Alma approached, it was recognized that the browser based-UI of Alma was not compatible with the tools developed for Aleph.

Research into more modern information technology tools, particularly those that would be compatible with the Alma APIs, led to experiments with Google Apps Script integrated with a Google Sheet as a potential replacement and improvement on the obsolete workflows.

### Google Apps Script

Google Apps Script  is a cloud-based programming platform that is tightly integrated with the Google Workspace suite of applications like Google Sheets, Google Docs, and Google Drive. In a Google spreadsheet, Google Apps Script is just a menu click away and comes with its own integrated development environment for writing sharable scripts that interact with and modify the Google files. It can also incorporate other APIs, including the Alma APIs, to fetch data from outside sources and incorporate it into a Google spreadsheet. Google Apps Script uses a scripting language that is based on JavaScript with a few differences, mostly additional methods Google provides to make the platform even more useful. There is an included integrated development environment with a script editor that has a variety of sophisticated programming tools like autocomplete, logging, and debugging tools, making it an excellent choice for either the seasoned programmer or a novice. It has been around for over ten years (as of 2023), and in 2020 the integrated development environment was completely redesigned . Google Apps Script makes it possible to have a Google spreadsheet with a custom function that queries the Alma API to gather current data about invoices in Alma, formats that data, and then displays that data in the Google spreadsheet.

### Alma REST APIs

The Alma LSP comes with a suite of APIs  that allow direct, programmatic access to the data within Alma. Grouped into categories such as Acquisitions, Bibliographic Records and Inventory, and Users and Fulfillment, the APIs make it possible to “read” data from Alma at any given moment, along with updating many kinds of data in Alma, from bibliographic records to patron accounts.

To use the Alma API, you must create an Alma API key, and the permissions granted to any given key may be very granular. Options include Environment: Production or Sandbox, Permission: Read-only access to Alma, or Read/write access to Alma, and API keys may be restricted to particular functional areas like Acquisition, Bibs, or Users, among others. For our purposes, an API key with Acquisition, Production, and Read-only parameters was sufficient to get data out of Alma and report on it in a Google spreadsheet.

## The Report

In order to create a report that would include real-time data from Alma which could be used to double-check that all invoices due to be exported had a required batch number, and had a properly formatted note, it was necessary to create a Google spreadsheet with special formatting and a custom function. The custom function script was written and deployed in the Apps Script extension of the Google spreadsheet. Library staff are able to use the Google spreadsheet to call up a real-time report of invoice data from Alma. The custom function script communicates with the Alma API and returns information about invoices in the “Waiting to be Sent” invoice workflow status – those due to be exported that night – displaying information about each invoice in Alma due to be exported along with conditional formatting that highlights invoices that need to be edited in order to avoid problems with the export from Alma and import into the University’s Central Financial System. The report is designed to be used at the end of the day before the ‘Export Invoices for Payment’ job runs automatically to check if all the invoices that are “Waiting to be Sent” have a batch number (an Invoice reference #) and a properly formatted note. The enhanced Google spreadsheet can identify these two types of problems so that invoices that have them can be corrected or put back in review status so they won’t be exported that day.

### The script

The script used to create the report  queries the Alma API. Here is how it works.

To add a custom function to a Google spreadsheet, you simply click on *Extensions > Apps Script* at the top of the spreadsheet, which opens the Apps Script code editor. This code editor allows you to add programming to the Google spreadsheet to do a wide variety of things in a container-bound script attached to the spreadsheet.

This script begins by declaring the API key as a global variable:

```javascript
var apikey = ‘your_api_key’;
```

It will be used in the main function but could also be used in other functions were there to be more added later.

The custom function doing all of the work of getting the data out of Alma is called “GETNOTES”. ‘function’ is a keyword in JavaScript indicating where the function begins, “GETNOTES” is the name that is used for this custom function, ‘(input)’ is the input parameter for the function, and the first opening curly bracket shows where the function begins, and is matched by a closing curly bracket at the very end of the function:

```javascript
function GETNOTES(input) {
  if (input){
```

The content ‘=GETNOTES(B1)’ is placed in cell A8 of the Sheet called “Sheet1” so that when content is added or changed in cell B1, the function will execute. It may be helpful to think of the GETNOTES function analogously to a built-in function such as ‘SUM’. Were we to put ‘=SUM(2+B1)’ into cell A8, then A8 would display ‘2’ if B1 were empty, ‘3’ if B1 had the value ‘1’, and so on. Cell A8 would display the result of the SUM function adding 2 to the contents of cell B1. GETNOTES is a custom function which, like SUM, will return data, but in this case, it will return not the result of a math operation, but the result of a call to the Alma API to retrieve invoice information which is then formatted and displayed in cell A8 and other adjacent cells.

The next section of the script retrieves invoice information from Alma.

```javascript
var limit = 100;
var offset = 0;
var url = 'https://api-na.hosted.exlibrisgroup.com/almaws/v1/acq/invoices/?limit='+limit+'&offset='+offset+'&invoice_workflow_status=Waiting%20to%20be%20Sent&apikey='+apikey;
var xml = UrlFetchApp.fetch(url).getContentText();
var document = XmlService.parse(xml);
var totalRecordCount = document.getRootElement().getAttribute('total_record_count').getValue();
xml = xml.replace(/<\?xml version='\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"\?><invoices total_record_count=\"\d+\">/, "")';
xml = xml.replace(/<\/invoices>/, "");
var fullResponse = xml;
```

The first call to the API will retrieve information about the first 100 invoices that have the status “Waiting to be Sent”. The URL in this code will vary based on location in the world (North America, Europe, Asia Pacific, Canada, or China) and the call to an Alma API is directed to different URLs depending on the location of your library. The [Alma API Console documentation](https://developers.exlibrisgroup.com/console/?url=/wp-content/uploads/alma/openapi/acq.json#/Invoices/get%2Falmaws%2Fv1%2Facq%2Finvoices%2F) provides details about constructing API calls and in this case it is a “Get invoices” request utilizing the “invoice[^]:workflow[^]:status” parameter equal to “Waiting to be Sent”. The reply is in XML format and the script edits this reply a little in case there are more than 100 invoices with this invoice workflow status.

The next section of the script is a loop, only invoked when there are more than 100 invoices with the specified invoice workflow status.

```javascript
while (totalRecordCount > offset + limit) {
  offset += 100;
  var url = 'https://api-na.hosted.exlibrisgroup.com/almaws/v1/acq/invoices/?limit='+limit+'&offset='+offset+'&invoice_workflow_status=Waiting%20to%20be%20Sent&apikey='+apikey;
  var xml = UrlFetchApp.fetch(url).getContentText();
  xml = xml.replace(/<\?xml version='\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"\?><invoices total_record_count=\"\d+\">/, "")';
  xml = xml.replace(/<\/invoices>/, "");
  fullResponse = fullResponse.concat(xml);
}
```

This is not a common situation, but by changing the offset, it is possible to retrieve the information for more than 100 invoices, which is the default limit for the Get invoices API request.

Next, the script edits the reply, combining all requests into one XML document, parses that document, and sets up the ‘invoices’ variable with the invoice information that has been retrieved from Alma.

```javascript
fullResponse = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><invoices total_record_count="">' + fullResponse + '</invoices>';
var documentB = XmlService.parse(fullResponse);
var invoices = documentB.getRootElement().getChildren('invoice');
```

At this point, it might be useful to [review the sample of an XML-formatted Get invoices request from the Alma API](https://developers.exlibrisgroup.com/console/?url=/wp-content/uploads/alma/openapi/acq.json#/Invoices/get%2Falmaws%2Fv1%2Facq%2Finvoices%2F). The API Console inside the Developer Network is a development environment provided by Ex Libris that enables you to test out the Alma APIs on sample data or on your library’s data.

![Sample of part of an XML-formatted Get invoices request response from the Alma API](https://journal.code4lib.org/media/issue58/fulmer/figure01.jpg)  
**Figure 1.** Sample of part of an XML-formatted Get invoices request response from the Alma API. This screenshot shows the API Console inside the Developer Network.

Next, a few variables are established to store data throughout the script and to be presented in the spreadsheet at the end.

```javascript
var invoiceArray = [];
var space = [" "];
var invoiceArrayBad = ["These below are not okay"];
```

The ‘invoiceArray’ is used to gather information about all the invoices in the specified status, the ‘space’ variable is used for formatting, and the ‘invoiceArrayBad’ is just what it sounds like: this needs attention.

The script then begins a loop through all the invoices.

```javascript
for (var i = 0; i < invoices.length; i++) {
  var invoiceGoodorBad = 1;
  var invoiceNumber = invoices[i].getChild('number').getText();
  var vendorCode = invoices[i].getChild('vendor').getText();
  var referenceNumber = invoices[i].getChild('reference_number').getText();
```

Each invoice starts out with the ‘invoiceGoodorBad’ variable set to 1, which means it needs attention, but if it is found to be acceptable this variable will be changed. Then the invoice number, vendor code, and reference number or batch number are retrieved from the data sent by the Alma API.

Next, there is a check for the reference number, and if there is none, a message, ‘No batch number’, the invoice number, and the vendor code of the invoice are added to the invoiceArrayBad array.

```javascript
if (!referenceNumber) {
  invoiceArrayBad.push(["No batch number",invoiceNumber," ",vendorCode," "]);
  referenceNumber = 'none';
}
```

Then the script evaluates the invoice notes.

```javascript
var invoiceNotes = invoices[i].getChild('notes');
      if (invoiceNotes) {
        var invoiceNote = invoiceNotes.getChildren('note');
        for (var j = 0; j < invoiceNote.length; j++) {
          var noteContent = invoiceNote[j].getChild('content').getText();
          var patt = /^Act......,.............-...,.,\[p\]$/;
          var goodOrBad = patt.test(noteContent);
          if (goodOrBad) {
            var pattern = "Yes";
            invoiceGoodorBad = 2;
          } else {
            var pattern = "No";
          }
          invoiceArray.push([pattern,invoiceNumber,referenceNumber,vendorCode,noteContent]);
        }
        if (invoiceGoodorBad < 2){
          invoiceArrayBad.push(["No good note",invoiceNumber,referenceNumber,vendorCode," "]);
        }
      } else {
        invoiceArray.push(["No lines",invoiceNumber,referenceNumber,vendorCode,"No lines"]);
        invoiceArrayBad.push(["No lines",invoiceNumber,referenceNumber,vendorCode,"No lines"]);
      }
    }
```

The invoice notes are retrieved one by one and checked against the pattern required by the invoice processing system for successful exporting of the invoice to the University’s Central Financial System. If there is at least one note in the invoice that matches the pattern then the invoice is classified with the invoiceGoodorBad value set to ‘2’, if not, the invoice gets added to the invoiceArrayBad array as an invoice flagged for attention. An invoice may have more than one note, but each invoice needs to have one note which matches the pattern necessary for invoice processing.

The script finishes up by building up an object, ‘invoiceArrayE’, with all the output from the Alma API response having been processed by the script to return the data formatted in a way that makes it easy for library staff to review the invoices according to the needs of the invoice processing system. The ‘invoiceArrayE’ is a combination of the invoiceArrayBad information, followed by a space, followed by another row with “These below are all notes”, followed by all the ‘Waiting to be Sent’ invoices with their accompanying notes. Because “=GETNOTES(B1)” is placed in cell A8, all this information is displayed in cell A8, to the right of cell A8, and below cell A8.

```javascript
var okayMessage = ["These below are all notes"];
invoiceArrayE = invoiceArrayBad.concat(space).concat(okayMessage).concat(invoiceArray);
return invoiceArrayE;
```

### Conditional formatting

The final piece of the spreadsheet is the Conditional Formatting rules, which have been added to the Sheet to highlight certain rows and cells of the report. This screenshot shows the display of three invoices that are currently in the ‘Waiting to be Sent’ status in Alma with a variety of problems, and one invoice that passes all the quality check tests and is ready to be exported from Alma and imported into the University’s Central Financial System without any problems.

![The display of three invoices in the Note Check spreadsheet](https://journal.code4lib.org/media/issue58/fulmer/figure02.jpg)  
**Figure 2.** The display of three invoices in the Note Check spreadsheet.

Invoice number 4000 has a batch number (‘C1234’) and a properly formatted note (‘Act615590,VID0000652571-001,D,\[p\]’), so it does not appear on the first section of the report below the first green row, but it does appear below the second green row, which is a section of the report intended to show each invoice note.

Invoice number 4001 also has a batch number (‘Z123’) and a properly formatted note (‘Act615590,VID0000652571-001,D,\[p\]’), so it also does not appear on the top part of the report. However, the batch number does not start with the letter ‘C’. When it was recognized that this was a potential issue, a Conditional Formatting Rule *(“=not(REGEXMATCH(C9,”^C”))”)* was added to the Sheet to highlight batch numbers without the proper format in purple, which may be seen in row 15, column C.

![A conditional format rule in the spreadsheet](https://journal.code4lib.org/media/issue58/fulmer/figure03.jpg)  
**Figure 3.** A conditional format rule in the spreadsheet.

Invoice number 4002 does not have a batch number and it does not have a properly formatted note, so it appears twice on the report, in row 9 and row 10, to flag these two problems.

Finally, invoice number 4003 does have one note which is shown in row 16, it also has a batch number in the correct format so cell C16 is not highlighted, but the note that it has is not properly formatted so it is flagged in row 11 with the note in cell A11 “No good note”.

## Conclusion

Having this tool to help identify potential problems in the processing of invoices has helped immeasurably and has served the University of Michigan Library well for over two years. Mistakes with formatting and data entry are an unfortunate part of any procedure involving processing thousands of documents and transmitting their salient information between two systems – the library LSP and the University’s Central Financial System. This report with its custom function overcomes the limitation of day-old data in Alma’s integrated reporting tool, Alma Analytics, by utilizing the Alma API to retrieve real-time invoice data. Using the powerful, accessible tools of the Google Apps Script platform, this data can then be checked and formatted in a report that flags issues before they develop into problems with the export of financial information from Alma and into the University’s Central Financial System. It was also particularly helpful to library staff during the transition from the Aleph ILS to Alma when workflows were being adapted, new processes needed to be learned, and older tools were not compatible with the new system. A new LSP necessitated the development of new information technology tools simply to carry on with the work that needed to be done.

## Citations

[^1]: Alma – Financial Systems: [https://knowledge.exlibrisgroup.com/Alma/Product[^]:Documentation/010Alma[^]:Online[^]:Help[^]:(English)/090Integrations[^]:with[^]:External[^]:Systems/020Acquisitions/010Financial[^]:Systems](https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/010Alma_Online_Help_\(English\)/090Integrations_with_External_Systems/020Acquisitions/010Financial_Systems)

[^2]: Alma Analytics: [https://exlibrisgroup.com/products/alma-library-services-platform/alma-analytics/](https://exlibrisgroup.com/products/alma-library-services-platform/alma-analytics/)

[^3]: Google Apps Script: [https://developers.google.com/apps-script](https://developers.google.com/apps-script)

[^4]: Google Apps Script release notes for December 07, 2020: [https://developers.google.com/apps-script/docs/release-notes#December[^]:07[^]:2020](https://developers.google.com/apps-script/docs/release-notes#December_07_2020)

[^5]: Alma REST APIs: [https://developers.exlibrisgroup.com/alma/apis/](https://developers.exlibrisgroup.com/alma/apis/)

[^6]: Notes Check App: [https://github.com/dfulmer/notes-check](https://github.com/dfulmer/notes-check)

## About the Author

*David Fulmer* is an Applications Programmer/Analyst Intermediate at the University of Michigan Library.

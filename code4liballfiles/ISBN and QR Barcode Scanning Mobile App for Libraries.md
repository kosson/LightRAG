---
title: "ISBN and QR Barcode Scanning Mobile App for Libraries"
source: "https://journal.code4lib.org/articles/5014"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-04-11
created: 2025-01-10
description: "This article outlines the development of a mobile application for the Ryerson University Library. The application provides for ISBN barcode scanning that results in a lookup of library copies and services for the book scanned, as well as QR code scanning. Two versions of the application were developed, one for iOS and one for Android. [...]"
tags:
  - "clippings"
---
# ISBN and QR Barcode Scanning Mobile App for Libraries
Graham McCarthy, Sally Wilson

This article outlines the development of a mobile application for the Ryerson University Library. The application provides for ISBN barcode scanning that results in a lookup of library copies and services for the book scanned, as well as QR code scanning. Two versions of the application were developed, one for iOS and one for Android. The article includes some details on the free packages used for barcode scanning functionality. Source code for the Ryerson iOS and Android applications are freely available, and instructions are provided on customizing the Ryerson application for use in other library environments. Some statistics on the number of downloads of the Ryerson mobile app by users are included.

## Introduction

Ryerson University is a mid-sized urban campus, located in the multicultural heart of Toronto, Canada.  It is known for innovative programs built on the integration of theoretical and applied learning.  More than 28,000 undergraduate and 2,000 graduate students are enrolled in over 95  programs that are distinguished by a professionally focused curriculum and strong emphasis on excellence in teaching, research and creative activities. Ryerson is also a leader in adult learning, with the largest university-based continuing education school in Canada.

The Library & Archives has a staff of more than 85 including 25 librarians. The collection includes over 600,000 books, 1,700 hard copy serials and an impressive electronic resources collection of over 33,000 full text journals. The library has many innovative and supportive services, including a strong reference and instruction presence, which is increasingly mobile and virtual. A rapidly expanded research mandate complements the university’s traditional undergraduate focus with new frontiers for emerging digital library support.

## Objectives

The Ryerson University Mobile app was initially conceived to leverage the use of mobile phones to provide improved access to the library’s resources for patrons in any location. By taking advantage of the built-in camera, which is available in most modern mobile phones, we were able to provide an easy way for patrons to check library item availability by scanning the ISBN of a book (rather than laboriously keying a title or ISBN into the mobile version of our catalogue). To reach the widest possible audience, the app was enhanced with additional functionality to provide a convenient way for students to store their login credentials for quick access to the password-controlled portions of the popular Ryerson mobile website.

## QR Codes

The idea to incorporate a QR code scanner into the app arose from the library’s experimentation with QR codes as an alternative method of accessing Library resources.  The Library had used QR codes in a minor way to link users to a downloadable audio tour of the library and had experimented with using them on bookmarks and for contests.  In the fall of 2010 the Library added QR codes to its catalogue so that patrons could use their phones to capture title, call number and location information about the item being viewed.  This information could then be used later to locate the item in the library.  Prior to introducing QR codes in the catalogue the library students had been using a text messaging functionality as a method of transferring this same information to a patron’s phone.  This SMS service was well-received and was increasing in popularity, so the logical next step was to expand the service via QR codes.

### QR Codes in the Catalogue

QR codes are incorporated into the catalogue records on the fly using JavaScript, which extracts title, call number and location information from the bibliographic record and sends it to the Google Charts Tool API (see [http://code.google.com/apis/chart/docs/gallery/qr\_codes.html](http://code.google.com/apis/chart/docs/gallery/qr_codes.html)). A QR code is returned for insertion into the display of the bibliographic record. It was logical that since we had QR codes in the catalogue, we should also provide an app that could be used to interpret them.

## Technical Framework

### Library Record Finding Script

The barcode scanning application is a fairly simple concept. Using a mobile device’s camera feature, the application takes temporary snapshots and looks for numeric, alphanumeric, or two-dimensional barcode data. If a barcode is found, the application stops looking and interprets the symbol into its representative data.  If the data contains text, it will be displayed on screen; if the data contains a URL, the web page will be launched automatically by the application and if the data contains a 10, or 13 digit ISBN number, it will send that ISBN off to a PHP script running on a library server to process the request and find related items.  **Figure 1** shows an overview of the data processes.

![](https://journal.code4lib.org/media/issue13/mccarthy/figure1.png)

**Figure 1.** System interaction diagram

This script connects to the xISBN Web service provided for free non-commercial use by WorldCat (OCLC, [http://xisbn.worldcat.org](https://journal.code4lib.org/articles/,%20http://xisbn.worldcat.org)) and looks for related ISBNs.  The script then loops through all of the ISBNs it has tabulated and checks the library catalogue for item availability. Finally, the script does a Google Books search for the ISBN to retrieve the title, author, book jacket and Google Books full text and preview availability. The script then returns an XML document to the requesting mobile device with information about the resource (Title, Author, Book Jacket) and its item availability within the library.

**Returned XML**

**Figure 2.** Sample XML code returned for a resource . Response from [http://news.library.ryerson.ca/api/isbnsearch.php?isbn=9780321566157](http://news.library.ryerson.ca/api/isbnsearch.php?isbn=9780321566157) for “Programming in objective-C 2.0” by Stephen Kochan. 

| 1  2 | `<``results` `count``=``"0"` `libCount``=``"0"` `message``=``"Unrecognized ISBN"``>`  `</``results``>` |
| --- | --- |

**Figure 3.**Sample XML code of non ISBN item. Response from [http://news.library.ryerson.ca/api/isbnsearch.php?isbn=9780431566157](http://news.library.ryerson.ca/api/isbnsearch.php?isbn=9780431566157).

**Figure 4.** Sample XML code for valid ISBN, but not available at the library.

**Figure 2** shows an example of the data the mobile device would receive from the library record finding script if the library had a copy of the item.  In this example, there are two copies of the book, one due back on April 24th 2011 and one available online.  The current version of the application does not fully utilize the Google Books preview, info and full text code, but there are plans to include this functionality in a subsequent version.  **Figures 3** and **4** show what the XML would look like for ISBN searches that are invalid and return no results, respectively.  The ‘message’ attribute of the ‘results’ element provides the mobile application with information to display the user if no items are found in the library (i.e. if the ‘libCount’ attribute is 0).

### Record Finding Script Modification

To modify the isbnsearch.php script for your institution, you need to point the record look-up URL to your own catalogue in two specific locations.

Line 45 :

```
$html = file_get_contents("http://catalogue.library.ryerson.ca/search/i?SEARCH=".$similarISBN."&SUBMIT=Search");
```

Line 64 :

```
$html = file_get_contents("http://catalogue.library.ryerson.ca".$newURL);
```

Line 64 accounts for the potential case when two records are returned for one ISBN.

Lines 71 to 101 perform screen scraping to get the floor, call number and item availability from the catalogue.  This section of code will need to be customized for your specific institution if you are not an Innovative Interfaces catalogue user.

## Mobile Applications Overview

The following sections outline the two application frameworks and point out their key differences.  This article assumes a basic knowledge of both Objective-C and Java and will not go into much detail regarding basic app development, acquiring developer accounts, or application publishing.  The notes section of this article provides links to the resources that we used to accomplish these tasks.

We have developed this barcode scanning application for iOS and Android devices, with a BlackBerry version coming in the near future.  The iOS application has been written in Objective-C and the Android version in Java.  **Figure 5** shows three views from the application, two from the Android version and one from the iPhone version.  Aside from a few variations, both applications look and feel the same.  **Figure 5a** shows an example of what the application looks like once launched from the home screen.  The majority of the screen is a WebView (see **Figure 5b**) which calls an HTML5 mobile version of our library website (http://m.library.ryerson.ca).  The bar across the bottom of the application is the native component which contains two arrows for moving forward and backward within the application and the barcode scanner.   **Figure 5c** shows the results from scanning a library book barcode.

![](https://journal.code4lib.org/media/issue13/mccarthy/figure5a.png)

**Figure 5a.** Application Layout (Android)

![](https://journal.code4lib.org/media/issue13/mccarthy/figure5b.png)

**Figure 5b.** Layout with WebView (Android)

![](https://journal.code4lib.org/media/issue13/mccarthy/figure5c.png)

**Figure 5c.** ISBN Scanned Item found in library catalogue (iOS)

### Android Framework

The Google Android app uses the ZXing barcode scanning application to read the QR and ISBN codes.  ZXing was chosen because it is a free, open source, multi-format image processing library written in Java which made the integration into the Android application fairly easy to accomplish.

Our application calls a function from ZXing which opens the application, or if the user does not have the ZXing application, prompts the user to download the free application from the Android Market.  We chose to implement ZXing as a helper application to ours because it was intended to be used this way by the ZXing developers and includes an integration library specifically for this purpose.  Moving between applications on the Android does not really disrupt the user experience because of Android’s fast app switching support, where the user can move back and forth between applications seamlessly.

The following code is the one line that attempts to initiate the barcode scanning functionality. If the user does not have the barcode scanning application, it prompts the user to install it from the Android Market.

File: RMobile.java  
Line 211:

```
IntentIntegrator.initiateScan(RMobile.this, "Install Barcode Scanner?", "This application requires you to install 'Barcode Scanner'. Would you like to install it?", "Yes", "No");
```

Once an ISBN or QR code has been scanned, the ZXing application exits and a listener running within our application automatically takes over and returns the results to the screen.

The following code is the function that triggers off the listener and handles the incoming data from the barcode scan.  The **onActivityResult** method shows that the resulting data is identified based on its content (i.e. string content, a URL, or ISBN).  If it is a string of text, it displays the data on screen.  If it is a URL, it instructs the WebView to display the web page.  If it is numeric data, it sends the ISBN to the library’s record finding script which returns an XML feed containing the item availability within the library.

File: RMobile.java  
Line 347 – 387:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40 | `protected` `void` `onActivityResult(``int` `requestCode, ``int` `resultCode, Intent data) {`  `switch``(requestCode) {`  `case` `IntentIntegrator.REQUEST_CODE: {`  `if` `(resultCode != RESULT_CANCELED) {`  `IntentResult scanResult = IntentIntegrator.parseActivityResult(requestCode, resultCode, data);`  `String result =``""``;`  `if` `(scanResult != ``null``) {`  `result = scanResult.getContents();`  `}`  `else` `return``;`  `result = result.trim();`  `if``(result.trim().matches(``"^http.*://.*"``)) {`  `if``(isOnline()) mWebView.loadUrl(result.trim());`  `else` `mWebView.loadUrl(``"file:///android_asset/noConnection.html"``);`  `}`  `else` `if` `(result.trim().matches(``"[0-9]*"``)){`  `Intent intent = ``new` `Intent(RMobile.``this``,BarcodeResult.``class``);`  `Bundle bundle = ``new` `Bundle();`  `bundle.putString(``"ISBN"``,scanResult.getContents());`  `intent.putExtras(bundle);`  `startActivity(intent);`  `}`  `else``{`  `AlertBox.show(``"Found Message"``, result, ``this``);`  `}`  `}`  `}`  `break``;`  `}`  `}` |
| --- | --- |

**Android application customization**

To modify the Android application for your own institution update the following:

- Change the **MOBILEURL** string constant to point to your mobile website

File: RMobile.java  
Line 51 (objective-c):

```
final private String MOBILEURL = "http://m.library.ryerson.ca/";
```

- Change the **url** variable to point to the updated isbnSearch.php script that you have modified for your own catalogiue

File: XMLParser.java  
Line 38:

```
URL url = new URL("http://news.library.ryerson.ca/api/isbnsearch.php?isbn="+ISBN);
```

### iOS Framework

The iOS version operates in a similar manner to the Android version, except it does not rely on an external barcode scanning application to read the QR and ISBN barcodes.  The iOS version uses the ZBar barcode reader iOS library embedded within the iOS app. When users download this application they are not required to download a separate barcode reader application.  The iOS application uses the ZBar libraries instead of ZXing because there was already an open source library created in Objective-C for the iPhone released under a GNU LGPL 2.1 license for open source and commercial projects.  This gave us a good head start in the applications development.

The ZBar SDK integration tutorial (see notes section) describes step by step how to integrate the library into your iOS application.

The following code sample describes the actions associated with launching the barcode scanner from the application.  If the user’s device contains a camera, it creates a view controller called **reader**, configures the scanner to process the image for specific barcodes, and presents the reader to the user.

File: SpecialAppsViewController.m (Obj-c)  
Lines 90 – 120:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28 | `-(IBAction) barcodeScanner:(id)sender {`  `if` `( [self scanningAvailable] ) {`  `ZBarReaderViewController *reader = [ZBarReaderViewController ``new``];`  `reader.readerDelegate = self;`  `ZBarImageScanner *scanner = reader.scanner;`  `[scanner setSymbology: ZBAR_I25`  `config: ZBAR_CFG_ENABLE`  `to: ``0``];`  `AVCaptureVideoDataOutput *videoCapture = (AVCaptureVideoDataOutput *) reader.readerView.captureReader.captureOutput;`  `videoCapture.videoSettings = nil; `  `[self presentModalViewController: reader animated: YES];`  `[reader release];`  `} ``else` `{`  `UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@``"Scanner not supported"` `message:@``"Your mobile device does not support an auto focus camera and cannot use the barcode scanning application.  We are sorry for the inconvenience."` `delegate:self cancelButtonTitle:@``"Ok"` `otherButtonTitles:nil];`  `[myAlert show];`  `[myAlert release];`  `}`  `} ` |
| --- | --- |

When the barcode scanner has identified barcode data, it calls the **imagePickerController** method in **SpecialAppsViewController.m** (line 125).  The **imagePickerController** works along the same lines as the Android version.  It determines the type of data coming in and processes it accordingly.  One added feature to this application is that the scanned image is also shown to the end user for a more visually pleasing experience.  The actual code for this function is fairly involved and has been well documented to explain each action in-depth.

**iOS application customization**

To modify the iOS application for your own institution, update the following:

- Change the **urlAddress** variable to point to your mobile website

File: RyersonMobileViewController.m  
Line 113:

```
 NSString *urlAddress = @"http://m.library.ryerson.ca/";
```

- Change the **rulaISBNSearch** variable to point to the updated isbnSearch.php script that you have modified for your own catalogue.

File: SpecialAppsViewController.m  
Line 179:

```
NSString *rulaISBNSearch = [NSString stringWithFormat:@"http://news.library.ryerson.ca/api/isbnsearch.php?isbn=%@", dataFromSymbol];
```

- Change the **bookJacket\_url** to point to a default book jacket image of your choosing

File: SpecialAppsViewController.m  
Line 187:

```
NSString *bookjacket_url = @"http://news.library.ryerson.ca/api/noimage.png";
```

### Reflections on applications

Developing these applications for Android and iOS proved fairly straightforward to accomplish and we did not have many problems along the way.  The barcode scanning frameworks have example code for Android and iOS devices and lots of documentation and support forms.  Online tutorials and the API documentation proved very useful for solving integration and syntax issues.

One of the major drawbacks we have had to deal with is the regular firmware updates for iOS devices.  Our first issue was with the migration from iOS3.0 to iOS3.1. We unknowingly used a private library to read in image data from the camera. This was acceptable for iOS 3.0 but not iOS 3.1, and caused our application to be rejected from the app store. We experienced another issue when moving from iOS 3.1 to the iOS 4.0 firmware. Apple made significant changes to their SDK, requiring us to make a lot of small modifications to ensure the application works on most iOS device types.  This will be an unfortunate ongoing maintenance issue that we will continue to deal with.  That said, it will cause us to continue to develop and improve the applications.

## Integration with University-wide mobile platform

For the application to be adopted campus-wide, we needed to provide functionality that would benefit the students’ entire campus experience, not just their library access.  From surveys we conducted in ‘08 and ‘09, it was apparent that students did not just want access to library services and resources via their mobile devices. They wanted a holistic university experience because they view the university as one large institution.  Therefore, we provided the barcode scanning application as a feature of the university-wide mobile application which provides single-click authentication into their profile, access to their courses, booking of study rooms, departmental hours of operations, access to the campus directory, campus maps, and meal and photocopy plan transaction history and balances. The single-click authentication feature has been removed from the open source code to minimize the complexity.

## Usage Statistics

It has proven somewhat difficult to measure the success of the project as the statistics provided by the App Store and Android Market only indicate if an application was installed and uninstalled, but not usage.  To determine the usage, we need to consider the statistics for the mobile website.  However, this does not truly indicate whether users are using the native app or the web app.  The information below shows the statistics captured for the two native applications from their launch date to a similar end point and the web application from this past academic year.

### Android Market statistics (Aug 18th 2010 to Mar 16th 2011)

- 343 total downloads
- 202 active installs
- 12 reviews
- 4 comments

### Apple App Store statistics (Oct 4th 2010 to Mar 13th 2011)

- 4,180 application downloads
- 3,099 from Canadian iTunes accounts

### Mobile Web statistics (Sept 1st 2010 to Mar 16th 2011)

- 6,402 logged-in users
- 20,060 anonymous users
- 14 applications used 157,731 times by users.
- Device Usage
- 58% iOS
- 14% Blackberry
- 10% Android
- 18% desktop browsers and other mobile devices

## Conclusion

Since the launch of the applications, we have received expressions of interest and requests for information from other units within the university, external institutions, and public and academic libraries.  An adapted version of the application is now being used by the School of Continuing Education at Ryerson as part of their advertising campaign that features QR codes, and the Ryerson Math Centre is piloting a project that will use the barcode scanning application to scan student IDs to expedite signing them into workshops and exams.  In February 2011, the significance of this application to the Ontario library community was recognized when it won the Ontario Library and Information Technology Association’s Award for Technological Innovation.

The source code for this application can be downloaded from [http://www.ryerson.ca/library/mobile/RULA\_Barcode\_Scanner.zip](http://www.ryerson.ca/library/mobile/RULA_Barcode_Scanner.zip)

For more information please contact Graham McCarthy at gmccarthy@ryerson.ca.

## Links

- Android Developer’s Guide – [http://developer.android.com/guide/index.html](http://developer.android.com/guide/index.html)
- Apple iOS Dev Centre – [http://developer.apple.com/devcenter/ios/](http://developer.apple.com/devcenter/ios/)
- Google Charts Tool API – [http://code.google.com/apis/chart/](http://code.google.com/apis/chart/)
- GNU LGPL – [http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)
- QR Codes (Ryerson Library) – [http://www.ryerson.ca/library/qr/](http://www.ryerson.ca/library/qr/)
- Ryerson Library’s Mobile Survey Results:
- 2008 – [http://www.ryerson.ca/library/msurvey/index.html](http://www.ryerson.ca/library/msurvey/index.html)
- 2009 – [http://www.ryerson.ca/library/msurvey2009/index.html](http://www.ryerson.ca/library/msurvey2009/index.html)
- Ryerson mobile – [http://m.ryerson.ca](http://m.ryerson.ca/)
- Ryerson University Library & Archives mobile – [http://m.library.ryerson.ca](http://m.library.ryerson.ca/)
- xISBN Web Service – [http://xisbn.worldcat.org/](http://xisbn.worldcat.org/)
- ZBar – Barcode Scanning Library – [http://sourceforge.net/projects/zbar/](http://sourceforge.net/projects/zbar/)
- ZBar SDK integration – [http://zbar.sourceforge.net/iphone/sdkdoc/](http://zbar.sourceforge.net/iphone/sdkdoc/)
- ZXing – Barcode Scanning Application – [http://code.google.com/p/zxing/](http://code.google.com/p/zxing/)

## Acknowledgements

We would like to recognize Steven Marsden (steven.marsden@ryerson.ca) for his contribution to the barcode scanning application’s development.

## About the authors

Graham McCarthy (gmccarthy@ryerson.ca) is the Innovative Technologies Librarian at Ryerson University.

Sally Wilson (swilson@ryerson.ca) is the Web Services Librarian at Ryerson University.
---
title: "Communication Between Devices in the Viola Document Delivery System"
source: "https://journal.code4lib.org/articles/10293"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-01-21
created: 2025-01-10
description: "Viola is a newly developed document delivery system that handles incoming and outgoing requests for printed books, articles, sharing electronic resources, and other document delivery services on the local level in a library organisation. An important part of Viola is the stack fetching Android application that enables librarians to collect books in the open and [...]"
tags:
  - "clippings"
---
# Communication Between Devices in the Viola Document Delivery System
Theodor Tolstoy

Viola is a newly developed document delivery system that handles incoming and outgoing requests for printed books, articles, sharing electronic resources, and other document delivery services on the local level in a library organisation. An important part of Viola is the stack fetching Android application that enables librarians to collect books in the open and closed stacks in an efficient manner using a smartphone and a Bluetooth connected portable printer. The aim of this article is to show how information is transferred between systems and devices in Viola. The article presents code examples from Viola that use current .NET technologies. The examples span from the creation of high-level REST-based JSON APIs to byte array communication with a Bluetooth connected printer and the reading of RFID tags.

Please note that code examples in this article are for illustration purposes only. Null checking and other exception handling has been removed for clarity. Code that is separated in Viola for testability and other reasons has been brought together to make it more readable.

## Background Overview

During most of 2013, the development team at Stockholm University Library built an entirely new document delivery system to replace its outdated and discontinued predecessor. Viola is a Document Delivery system that handles incoming and outgoing requests for printed books, copies of articles, the sharing of electronic resources, and other document delivery services. An important part of Viola is the Stack Fetching Android application that enables the librarians to collect books in the open and closed stacks in an efficient manner.

Viola is built around two main workflows: One for books coming into the library and one for books going out. It interacts with many external systems such as the local ILS, the joint catalogue of the Swedish academic and research libraries (Libris) and the Swedish Interlibrary Loan service (Iller). This means that the users can stay in Viola to do their work and not have to perform tasks in other systems.

### Outgoing orders – incoming books

![](https://journal.code4lib.org/media/issue27/tolstoy/orders.png)  
**Figure 1:** The different kinds of outgoing orders for documents in Viola.

Viola handles both Interlibrary Loan requests from other libraries and requests for books to purchase from patrons. Viola has its own circulation and invoicing modules, so besides user authentication, no interaction takes place between Viola and the ILS when it comes to outgoing orders.

### Incoming orders – outgoing books

![](https://journal.code4lib.org/media/issue27/tolstoy/outgoing.png)  
**Figure 2:** Overview of the orders for books in the local stacks coming into Viola.

Viola handles four types of orders for outgoing books:

1. Interlibrary Loan requests from the national Ill system
2. Manual orders from libraries that are not part of the national system, like Special Libraries or libraries located outside Sweden
3. Orders for books that are to be sent to the researcher’s offices (Faculty Office Delivery)
4. Requests for books in the closed stacks

There is also a fifth type of order that handles books that are reported as missing and that are to be looked for once more.

Before these systems were in place, each order was printed out on paper (each type of order had its own designated printer) and then processed by different librarians. Sometimes up to three librarians could meet at the same shelf in the closed stacks, looking for different books. The task of sorting the hundreds of orders a day in a way that made the fetching efficient was also very time consuming. Needless to say, there was room to make theses workflows more efficient.

Today, all these orders are processed through Viola. The orders are grouped and sorted so that the fetcher will follow a predefined route around the library. The orders are then downloaded to a Smartphone for the librarian, who walks around the library and collects the books. When a book is found, the barcode is fed into the system either through scanning the RFID tag using the NFC reader or through reading the barcode using the camera. Then the librarian prints a slip, using a Bluetooth connected portable printer, and puts it in the book. Once the books are put on the hold shelf, the fetch is reported back to Viola and the external systems are automatically updated.

## Technical Overview

Viola is built on top of the newly open sourced \[[1](https://journal.code4lib.org/articles/#note1)\] .NET platform. It is currently run on local Windows servers.

Viola consists technically of three parts: a web site that provides a graphical user interface for the system and also works as a web service endpoint; an Android application that the librarians use when fetching books in the stacks; and a Windows service that runs different periodical tasks like watching for changes in external systems and fetching new requests. Behind the scenes, Viola uses SQL Server for the database with search support provided through Apache Solr.

The web site and the Windows service share most of the code through the Viola Core Library that handles most of the business logic and data access.

![](https://journal.code4lib.org/media/issue27/tolstoy/parts.png)  
**Figure 3:** The different parts of Viola and the main technologies they are built with.

The Android application is built as a native Android application, but written in C# using the Xamarin Platform \[[2](https://journal.code4lib.org/articles/#note2)\]. This enables the reuse of a lot of code from the Viola Core Library. However, the Viola Core library has not yet become a Portable Class Library \[[3](https://journal.code4lib.org/articles/#note3)\].

## Examples of communication between systems and devices in Viola

### Reading a barcode with a smartphone camera

Few external code libraries have been used in the building of the Android application since both Bluetooth communication and NFC/RFID tag reading are part of the Android SDK. The only significant external library used is the Zxing Component \[[4](https://journal.code4lib.org/articles/#note4)\]. ”Zxing (“zebra crossing”) is an open-source, multi- format 1D/2D barcode image processing library implemented in Java, with ports to other languages.” \[[5](https://journal.code4lib.org/articles/#note5)\] The example below shows a code snippet capturing a 1-dimensional barcode with the smartphone’s camera. This is a good example of a task that at first was considered large and complex but later turned out to be quite straightforward, all things considered.

| 1  2  3  4  5  6  7  8  9 | `var` `scanner = ``new` `ZXing.Mobile.MobileBarcodeScanner(``this``);`  `string` `barcode;`  `await` `scanner.Scan().ContinueWith(t =>`  `{`  `if` `(t.Result != ``null``)`  `barcode = t.Result.Text;`  `});`  `if` `(!``string``.IsNullOrWhiteSpace(barcode))`  `SetBarcode(barcode);` |
| --- | --- |

### RFID tag reading

The Viola Android application reads RFID tags using the NFC reader on the smartphone. The choice of mobile platform for Viola is the scope for another article, but it is worth noting that not every mobile platform with NFC capabilities has the right SDKs in place to read the ISO 15693 RFID tags. And if they do, the smartphone model of choice has to have the right chipset. The code sample below reads a RFID tag that is in the smartphone’s proximity, typically a couple of centimetres or closer. The code sends out a read command, receives the byte array response and sets the barcode property of the book order.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14 | `/// <summary>`  `/// This method is called when an NFC tag is discovered by the application.`  `/// </summary>`  `/// <param name="intent"></param>`  `protected` `override` `void` `OnTagPresent(Intent intent)`  `{`  `var` `readCommand = ``new``[] { (``byte``)0x00, (``byte``)0x23, (``byte``)0x00, (``byte``)0x28 };`  `var` `tag = intent.GetParcelableExtra(NfcAdapter.ExtraTag) ``as` `Tag;`  `var` `nfcVTag = NfcV.Get(tag);`  `nfcVTag.Connect();`  `var` `rawResponse = nfcVTag.Transceive(cmd);`  `var` `response = Encoding.ASCII.GetString(rawResponse); ``var` `barcode = response.Substring(4, 14);`  `SetBarcode(barcode); `  `}` |
| --- | --- |

### Printing with a portable printer

For printing slips to put in the fetched books Viola uses portable printers that the Android device talks to over a Bluetooth connection. The pairing with the printer is handled in the Android settings menu, just like pairing a Bluetooth headset and it is done before every fetch when the librarian chooses the printer to use during the fetch. When a book is found on the shelf and there is a barcode connected to the order, the librarian presses a button in the Android application that sends a print command to the printer. The command is written in the Zebra Programming Language \[[6](https://journal.code4lib.org/articles/#note6)\], ZPL, and converted to a byte array before being sent to the printer.

The sample below shows a method that prints the text “Hello, world” on a slip using a Zebra printer.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `///<summary>`  `/// Tells a Bluetooth connected Zebra printer to print "Hello, world" on a piece of paper`  `///</summary>`  `void` `PrintHelloWorld(BluetoothDevice device)`  `{`  `var` `printOneLineCommand = ``"^XA^LH30,30^F020,10^AD^FD{0}^FS^XZ"``;`  `var` `zplCommand = ``string``.Format(printOneLineCommand, ``"Hello, world"``);`  `byte``[] buffer = StringToAscii(zplCommand);`  `var` `uid = UUID.FromString(device.GetUuids()[0].ToString());`  `using` `(BluetoothSocket socket = device.CreateRfcommSocketToServiceRecord(uid))`  `{`  `socket.Connect();`  `await` `socket.OutputStream.WriteAsync(buffer, 0, buffer.Length);`  `socket.OutputStream.Close();`  `socket.Close();`  `}`  `}` |
| --- | --- |

### Fetching orders from external systems

Viola makes it possible for external systems to add orders through a pluggable architecture. Every system that wants to add an order for a book has its own Class that implements the `ICallSlipSource` interface, shown below.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `public` `interface` `ICallSlipSource`  `{`  `/// <summary>`  `/// Unique Id for the external system`  `/// </summary>`  `string` `SourceId { ``get``; }`  `/// <summary>`  `/// Collection of "new" Call Slips. Deduplication is not handled by`  `/// The Call Slip Source`  `/// </summary>`  `Task<IEnumerable<CallSlip>> GetNewCallSlips();`  `/// <summary>`  `/// Handles external changes in the system. /// </summary>`  `void` `HandleExternallyChangedCallSlips();`  `}` |
| --- | --- |

Through Reflection \[[7](https://journal.code4lib.org/articles/#note7)\] every `ICallSlipSource` implementing class in the Assembly is loaded, as can be seen in the example below. Since every external system is so different in its implementation, this solution works very well.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14 | `/// <summary>`  `/// Returns every class implementing the ICallSlipSource interface in the Assembly`  `/// </summary>`  `public` `static` `IEnumerable<ICallSlipSource> CallSlipSources`  `{`  `get`  `{`  `return` `Assembly.GetExecutingAssembly()`  `.GetTypes()`  `.Where(type => ``typeof``(ICallSlipSource).IsAssignableFrom(type) && type.IsClass)`  `.Select(type => NewMethod(type))`  `.Cast<ICallSlipSource>();`  `}`  `}` |
| --- | --- |

With every `ICallSlipSource` loaded, Viola then periodically checks for and saves new `CallSlip` objects to its database. To make the `ICallSlipSource` implementation easier, Viola handles deduplication so that no duplicate orders are saved. The following code sample shows the implementation of this method that is called from the Windows Service.

| 1  2  3  4  5  6  7  8  9  10  11  12  13 | `///<summary>`  `/// Fetches, deduplicates,and saves new Call Slips.`  `///</summary>`  `public` `void` `FetchNewCallSlips()`  `{`  `var` `newCallSlips = CallSlipSourceFactory.CallSlipSources`  `.SelectMany(callSlipSource => callSlipSource.NewCallSlips.Result);`  `if` `(newCallSlips.Any())`  `{`  `var` `deduplicatedCallSlips = newCallSlips.Where(cs => !CallSlipRepository.Exists(cs));`  `CallSlipFetcher.SaveNewCallSlips(deduplicatedCallSlips);`  `}`  `}` |
| --- | --- |

### Example of `ICallSlipSource` implementation

Every `ICallSlipSource` is implemented in a different way. The example below shows the `CallSlipSourceIller` that fetches ILL requests from Iller for the library’s different branches. Viola interacts with Iller through its REST based API. The API delivers various streams of orders like incoming, outgoing, and cancelled requests. Individual orders in the system can also be updated with new data. Iller has multiple data format options and implements JSON, XML, PDF, and YAML.

Since the emergence of the dynamic type \[[8](https://journal.code4lib.org/articles/#note8)\] and the `HttpClient` \[[9](https://journal.code4lib.org/articles/#note9)\] in the .NET Framework, the interaction with external web services with JSON data has been much more simplified.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45 | `/// <summary>`  `/// The Interface Method`  `/// </summary>`  `public` `async` `Task<IEnumerable<CallSlip>> GetNewCallSlips()`  `{`  `var` `dynamicRequests = ``return` `await` `IllerHelper.GetRequestsFromIller(IllerStreamTypes.Incoming);`  `return` `dynamicRequests.SelectMany(dynamicRequest => ToCallSlip(dynamicRequest));`  `}`  `/// <summary>`  `/// Bootstrapping for the fetching`  `/// </summary>`  `private` `static` `async` `Task<IEnumerable<dynamic>[]> GetRequestsFromIller(IllerStreamTypes illerStreamType)`  `{`  `var` `client = ``new` `HttpClient();`  `client.DefaultRequestHeaders.Add(``"api-key"``, ViolaResources.IllerAPIKey);`  `var` `branches = BranchRepository.Instance.ReadAll().Where(branch => !branch.Disabled);`  `var` `tasks = branches.Select(branch => GetRequestsFromBranch(client, illerStreamType, branch.LibraryCode));`  `return` `await` `Task.WhenAll(tasks).ConfigureAwait(``false``);`  `}`  `/// <summary>`  `/// Fetching new Ill requests for each of the branches`  `/// </summary>`  `private` `static` `async` `Task<IEnumerable<dynamic>>`  `GetRequestsFromBranch(HttpClient client, IllerStreamTypes illerStreamType,``string` `libraryCode)`  `{`  `var` `commandUrl = ViolaResources.URLToIllerAPI`  `+ ``string``.Format(illerStreamType.CommandSegment, libraryCode);`  `var` `getStringTask = client.GetStringAsync(commandUrl);`  `var` `jsonResponse = ``await` `getStringTask.ConfigureAwait(``false``);`  `var` `results = JsonConvert.DeserializeObject<dynamic>(jsonResponse);`  `return` `results.ill_requests;`  `}`  `/// <summary>`  `/// Converts dynamic objects to CallSlips`  `/// </summary>`  `private` `static` `CallSlip ToCallSlip(dynamic illRequest)`  `{`  `return` `new` `CallSlip`  `{`  `Title = illRequest.title,`  `PublicationYear = illRequest.year,`  `Pages = illRequest.pages;`  `};`  `}` |
| --- | --- |

The first method above shows how the interface method is implemented chaining the call to Iller and the parsing of the objects together. The returned `Task` that is wrapping the collection of `CallSlips` tells us that this code is using the recently added `async` and `await` libraries \[[10](https://journal.code4lib.org/articles/#note10)\]. This is a much more convenient way of writing asynchronous, multi-threaded, applications with the .NET framework than before, and since the async/await libraries also have benefits for web applications \[[11](https://journal.code4lib.org/articles/#note11)\], it is used in Viola quite thoroughly.

The `GetRequestsFromIller` method bootstraps an `HTTPClient` with the right headers and reads the library codes of the branches from the database. It then calls the `GetRequestsFromBranch` for each of the branches read from the database. `GetRequestsFromBranch` is responsible for doing the actual call to Iller and turning the returned JSON string into a dynamic object.

The last method in the code above shows how straightforward the process of converting the dynamic JSON object to a statically typed `CallSlip` object is. It is only to match the different properties and the type conversion is handled automatically. No casting or parsing is cluttering the code.

### Fetching orders from Viola Web Service to the Android application

One important part of MVC is the Web API type controllers \[[12](https://journal.code4lib.org/articles/#note12)\]. They make it easy to put forward REST-style APIs that can work for both single page application style web projects and for communication between systems. Web API comes with many features out-of-the-box, like Content negotiation, Routing, and Authorization. The sample code below shows the implementation of the web service that returns the orders that a librarian has chosen to fetch from the stacks, all sorted in the right order. To invoke the web service, the client has to point to the base URL of Viola followed with the name of the controller class. The API is then reachable through making an (authorized) HTTP Get request to https://URL\_TO\_VIOLA/api/PhoneCommunication?userId=USER\_ID

| 1  2  3  4  5  6  7  8  9  10  11 | `///<summary>`  `///Exposes the list of CallSlips (book orders) that a librarian has choosen to fetch as a`  `///Web Service.The list is read from database and then sorted`  `///</summary>`  `public` `IEnumerable<CallSlip> Get(``string` `userId)`  `{`  `return` `CallSlipRepository.Instance.Read(userId, CallSlipStatuses.FETCHING)`  `.OrderBy(callSlip => ``int``.Parse(callSlip.AreaDefaultSortOrder))`  `.ThenBy(callSlip => ``int``.Parse(callSlip.CallNumberDefaultSortOrder))`  `.ThenBy(callSlip => callSlip.CallNumber.Replace(``"."``,``string``.Empty), ``new` `NaturalComparer());`  `}` |
| --- | --- |

As the example above shows, no data transformation is taking place in code. That is all handled by the framework. From the programmer’s perspective, the native objects are exposed to the web as they are. JSON and XML data formats are implemented into Web API by default. The data format delivered to the caller depends on the calling application’s headers. In the Android application, the code calling the web service defined in this code sample is not that different from the `CallSlipSourceIller` example in the previous sample. The data received is not parsed in this method. It is just being downloaded as a string and saved to disc. The following code sample shows the invoking of the web service defined above.

| 1  2  3  4  5  6  7  8  9  10  11  12  13 | `/// <summary>`  `/// Fetches CallSlips (book orders) from Viola Web Service and`  `/// saves them on the phone`  `/// </summary>`  `async` `void` `FetchCallSlips(``string` `url, ``string` `userId, ``string` `password, ``string` `domain)`  `{`  `using` `(``var` `handler = ``new` `HttpClientHandler { Credentials = ``new` `NetworkCredential(userId, password, domain)})`  `using` `(``var` `client = ``new` `HttpClient(handler))`  `{`  `var` `result = ``await` `client.GetStringAsync(``string``.Format(url, userId));`  `File.WriteAllText(_filepath, result, Encoding.Default);`  `}`  `}` |
| --- | --- |

## Future work

### Implement a State Machine

“Every developer has implemented a finite state machine at least once in his or her career.” \[[13](https://journal.code4lib.org/articles/#note13)\] For the development team, Viola should have been that first time. The team did smell the need quite early on, but being burned a few times overworking and overthinking other parts of the system, they over-practised the YAGNI \[[14](https://journal.code4lib.org/articles/#note14)\] principle when it came to state transition and defining strict workflows.

The absence of a state machine is now very obvious, and for both maintainability and extensibility reasons this is a much needed refactoring.

### Switch from a relational database to a document database

When the choice to use an Object Relational Mapper (ORM) for Viola was made, the step from manual mapping between columns and object properties was considered a big leap forward. The team has since then acquired experience with a Document database and the opinion is now that this type of data store is better suited for Viola.

### Implement some kind of queue like `NServicebus` or `MassTransit`

The need for persistent messaging is not as important an issue as the State machine issues, but if Viola is to be scaled up or shared among other libraries, implementing a queue is something that should be done in order to make the system more trustworthy and robust.

### Sharing Viola

Putting all this effort into a system and not sharing it with others it makes no sense to most. The ambition is to release Viola as Open Source, but It has to be done the right way. For example, the code cannot be released before a proper State Machine is in place and before all hard coded localization has been removed.

### Sending Viola to the Cloud

Viola is currently being prepared to be used by other library organizations. The first step is to enable it to run on Windows Azure and make it generic enough so that all Swedish libraries using Ex Libris Voyager can use it. So far everything looks promising, and the first end users should be able to test it in early 2015.

### Splitting the workflows into two systems

Viola has been well received when being presented at conferences, and the main interest seems to lie in the stack fetching part. To be able to offer this part of the system in a convenient way, Viola has to become more modular and development must be pushed in a direction that makes it more of a framework.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Microsoft, Microsoft News Center \[Internet\] \[published 2014 Nov 12\] Microsoft takes .NET open source and cross-platform, adds new development capabilities with Visual Studio 2015, .NET 2015 and Visual Studio Online \[visited 2014 Dec 10\]. Available from: [http://news.microsoft.com/2014/11/12/microsoft-takes-net-open-source-and-cross- platform-adds-new-development-capabilities-with-visual-studio-2015-net-2015-and-visual- studio-online/](http://news.microsoft.com/2014/11/12/microsoft-takes-net-open-source-and-cross-%20platform-adds-new-development-capabilities-with-visual-studio-2015-net-2015-and-visual-%20studio-online/)  
\[[2](https://journal.code4lib.org/articles/#ref2)\] Xamarin Inc. \[Internet\] Xamarin Platform. \[visited 2014 Dec 10\] Available from:  
[http://xamarin.com/platform](http://xamarin.com/platform)  
\[[3](https://journal.code4lib.org/articles/#ref3)\] Microsoft, Microsoft Developer Network \[Internet\]Cross-Platform Development with the Portable Class Library \[visited 2014 Dec 10\] Available from: [http://msdn.microsoft.com/en- us/library/gg597391(v=vs.110).aspx](http://msdn.microsoft.com/en-%20us/library/gg597391\(v=vs.110\).aspx)  
\[[4](https://journal.code4lib.org/articles/#ref4)\] Dick, J. \[Internet\] ZXing.Net.Mobile \[visited 2014 Dec 10\] Available from:  
[https://components.xamarin.com/view/zxing.net.mobile](https://components.xamarin.com/view/zxing.net.mobile)  
\[[5](https://journal.code4lib.org/articles/#ref5)\] ZXing \[Internet\] XZing Readme file. \[visited 2014 Dec 10\] Available from:  
[https://github.com/zxing/zxing](https://github.com/zxing/zxing)  
\[[6](https://journal.code4lib.org/articles/#ref6)\] ZIH Corp, Zebra Technologies \[Internet\] Programming guide: for ZPL II, ZBI 2, Set-Get-Do, Mirror, WML \[visited 2014 Dec 10\] Available from: [http://www.zebra.com/content/dam/zebra/manuals/en-us/software/zpl-zbi2-pm-en.pdf](http://www.zebra.com/content/dam/zebra/manuals/en-us/software/zpl-zbi2-pm-en.pdf)  
\[[7](https://journal.code4lib.org/articles/#ref7)\] Microsoft, Microsoft Developer Network \[Internet\] Reflection in the .NET Framework \[visited 2014 Dec 10\] Available from: [http://msdn.microsoft.com/en- us/library/f7ykdhsy(v=vs.110).aspx](http://msdn.microsoft.com/en)  
\[[8](https://journal.code4lib.org/articles/#ref8)\] Microsoft, Microsoft Developer Network \[Internet\] Using Type dynamic (C# Programming Guide) \[visited 2014 Dec 10\] Available from: [http://msdn.microsoft.com/en- us/library/dd264736.aspx](http://msdn.microsoft.com/en-%20us/library/dd264736.aspx)  
\[[9](https://journal.code4lib.org/articles/#ref9)\] Nielsen, H. F. HttpClient is Here! MSDN Blogs \[Internet\] \[visited 2014 Dec 10\] Available from:  
[http://blogs.msdn.com/b/henrikn/archive/2012/02/11/httpclient-is-here.aspx](http://blogs.msdn.com/b/henrikn/archive/2012/02/11/httpclient-is-here.aspx%3Cbr%20/%3E%3Cbr%20/%3E%3Cbr%20/%3E)  
\[[10](https://journal.code4lib.org/articles/#ref10)\] \[Internet\] Asynchronous Programming with Async and Await (C# and Visual Basic) \[visited 2014 Dec 10\] Available from: [http://msdn.microsoft.com/en-us/library/hh191443.aspx](http://msdn.microsoft.com/en-us/library/hh191443.aspx)  
\[[11](https://journal.code4lib.org/articles/#ref11)\] Cleary S. 2014. Introduction to Async/Await on ASP.NET. MSDN Magazine \[Internet\] \[visited 2014 Dec 10\] Available from: [http://msdn.microsoft.com/en-us/magazine/dn802603.aspx](http://msdn.microsoft.com/en-us/magazine/dn802603.aspx)  
\[[12](https://journal.code4lib.org/articles/#ref12)\] Microsoft \[Internet\] Learn About ASP.NET Web API \[visited 2014 Dec 10\] Available from:  
[http://www.asp.net/web-api](http://www.asp.net/web-api)  
\[[13](https://journal.code4lib.org/articles/#ref13)\] Bajaj, S. 2001. Design Patterns: Solidify Your C# Application Architecture with Design Patterns. MSDN Magazine \[Internet\]. \[visited 2014 Dec 10\] Available from: [http://msdn.microsoft.com/en-us/magazine/cc301852.aspx](http://msdn.microsoft.com/en-us/magazine/cc301852.aspx)  
\[[14](https://journal.code4lib.org/articles/#ref14)\] Schach, S. 2007. Object-oriented & classical software engineering. p. 58

## About the Author

Theodor Tolstoy is the Head of Development at Stockholm University Library in Sweden. Blog: [http://bibliotekarien.se](http://bibliotekarien.se/) Twitter: @tedde
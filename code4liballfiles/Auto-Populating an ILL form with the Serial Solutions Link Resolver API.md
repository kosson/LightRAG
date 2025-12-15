---
title: "Auto-Populating an ILL form with the Serial Solutions Link Resolver API"
source: "https://journal.code4lib.org/articles/108"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-09-22
created: 2025-01-10
description: "In this article we'll take a tour of the OpenURL protocol; discover how to use it to get an XML API response from the Serial Solutions link resolver; and see how to receive and process that XML data using PHP to create an Interlibrary Loan webform. Finally, we'll see a few examples of how to [...]"
tags:
  - "clippings"
---
# Auto-Populating an ILL form with the Serial Solutions Link Resolver API
Daniel Talsky

In this article we’ll take a tour of the OpenURL protocol; discover how to use it to get an XML API response from the Serial Solutions link resolver; and see how to receive and process that XML data using PHP to create an Interlibrary Loan webform. Finally, we’ll see a few examples of how to handle form processing. This article will be of interest to beginner programmers interested in examples of programming with OpenURL and XML in PHP, and to more experienced programmers interested in taking a look at the Serial Solutions 360 Link API.

## Introduction

In this article we’ll take a tour of the OpenURL protocol; discover how to use it to get an XML API response from the Serial Solutions link resolver; and see how to receive and process that XML data using PHP to create an Interlibrary Loan webform. Finally, we’ll see a few examples of how to handle form processing.

This article will be of interest to beginner programmers interested in examples of programming with OpenURL and XML in PHP, and to more experienced programmers interested in taking a look at the Serial Solutions 360 Link API.

## What is an OpenURL Link Resolver?

An OpenURL is a formatted citation embedded in a URL.[\[1\]](https://journal.code4lib.org/articles/#note1 "reference1") Link resolver products receive OpenURL requests identifying a citation, and provide services to the user for the given citation. The service which generally motivates an institution to set up a link resolver is providing online full text links for a citation, generally based on a ‘knowledge base’ of licensed full text maintained in the link resolver product.

Most OpenURL link resolvers return results as an HTML page. This is great for a human, who can read the results and manually link to the full text. But sometimes a library might want to set up more advanced features than the link resolver product supports, still based on underlying link resolver functionality. Even significant customization of the HTML output may be limited by the interface of the link resolver. You may want to use or develop other tools which provide more functionality, while still using the full text resolution services of the link resolver.

An XML API allows you to receive results as a package of data, and use a program to pull the data you want and display or use it in any format. Want to populate a spreadsheet with link resolver data? A PDF file? Generate an RSS feed? Put the information in an email? All of these are possible using an XML API for link resolver data. Some OpenURL link resolvers provide XML APIs.

### What is an XML API?

An XML API is a web service where either the request or the response are in XML. In the case of the 360 Link XML API, the request is in the form of a URL, and the response is in XML. Read more about [web services at Wikipedia](http://en.wikipedia.org/wiki/Web_service).

### 360 Link vs. other OpenURL Link Resolvers

[360 Link](http://www.serialssolutions.com/ss_360_link.html) is a commercial link resolver product of Serials Solutions. There are other link resolver products available that accept OpenURL requests, some of which also provide XML APIs. I will use 360 Link as an example because I work for Serials Solutions (full disclosure).

Other OpenURL services include [Ex Libris SFX](http://www.exlibrisgroup.com/category/SFXOverview), and [EBSCO Link Source](http://www2.ebsco.com/en-us/ProductsServices/linksource/Pages/index.aspx).

The 360 Link XML API official documentation is not public, so this will be the first public look at how our API works. Serials Solutions includes the API with the purchase of 360 Link.

## An InterLibrary Loan Form as Practical Example

When a library doesn’t have a full text resource, it’s common to direct patrons to an ILL form, so that they can request the resource from another library. Then the user needs to manually enter the citation data into the form; this is an error-prone and time-consuming process.

Our example is of a hypothetical “citation finder” service, which will direct the user to a pre-populated ILL form only when the local library does not have a licensed electronic copy of the article citation requested. The patron could get to this ILL form from either of two starting points. Either the patron would fill out citation information in a search form on a library’s website, or the original data would come via an OpenURL string passed from another database’s search results. [\[2\]](https://journal.code4lib.org/articles/#note2 "reference2")

## The XML API Client in PHP

### Writing a client

Our client will be a computer program that sends an OpenURL request and receives the XML package. Then we can use the data in the XML package to construct our ILL form.

The specific tasks our client software will engage in are:

1. Collect the citation data based on a user search for an article
2. Assemble the data for an OpenURL Query
3. Generate a valid URL from the data
4. Send it across the web to the 360 Link API and recieve the XMLresponse
5. Read and extract variables from the XML
6. Display the variables as an HTML form

Many programming languages have all the tools you need to complete these tasks. I chose PHP, a scripting language designed for the Web, for a few reasons: it's widely available, can be easily deployed in a wide variety of environments, is considered very easy to work with even for beginners, and has very good documentation at [php.net](http://php.net/).

## The Request: An OpenURL Query

The first step in talking to the API is to generate an OpenURL request.

### Constructing the URL

Once we have a set of key-value pairs, we need to express them in the language of a URL.

### The BaseURL

First we need to point to a certain location on the internet. This is done with the BaseURL.

Each OpenURL provider has their own BaseURL. The BaseURL for Serial Solution 360 Link is:

```
 http://CLIENT IDENTIFIER.openurl.xml.serialssolutions.com/openurlxml
```

The **client identifier** refers to a code provided by Serials Solutions for your organization. If your client identifier is 000-00, then your URL would be:

```
 http://000-00.openurl.xml.serialssolutions.com/openurlxml
```

If this URL is opened in a browser, you will get an XML package back, but it will just be a diagnostic message in XML telling us that the server needs more information. Next we will explain how to provide that information.

### OpenURL Key-Value Pairs

If we send only the BaseURL, we’ll get a diagnostic message saying you’re missing a required field. First we’ll describe the information to provide, and then show how to encode this information in a URL.

OpenURL 1.0 has a certain minimum set of key-value pairs you need to send with each query, just to meet the OpenURL standard.

In addition, the Serials Solutions 360 Link XML API requires an additional **version** key-value pair that is not a part of the OpenURL standard. The version allows us to make changes to our API interface over time.

Add to these the fields for citation data, and we have a basic set of key-value pairs that allow us to interact with the server. If we miss one of these values, the server will return an error message in XML.

#### Required Values

| Friendly Name | Notes | Key | \= | Value Example | Value Range |
| --- | --- | --- | --- | --- | --- |
| 360 Link API Version | Included to allow for backward compatibility when newer versions of the API are released. This is not part of the OpenURL standard, but 360Link XML API queries won’t work without it. | version | \= | 1.0 | Currently the 1.0 version is the only 360 Link XML API Version |
| OpenURL Version | This refers to the [ANSI/NISO standard for OpenURL](http://www.niso.org/kst/reports/standards?step=2&gid=&project_key=d5320409c5160be4697dc046613f71b9a773cd9e) itself. | url\_ver | \= | Z39.88-2004 | Z39.88-2004 refers to the current standard (1.0), and the only currently supported by the 360 Link XML API. |
| Metadata Format | Specifies what resource we’re referring to. OpenURL offers several metadata formats for different types of items. For the the purposes of this article we will use the journal format which is for journal articles among other things. | rft\_val\_fmt | \= | info:ofi/fmt:kev:mtx:journal | Read the OpenURL specification for other kinds of queries. In general, use the example value for 360 Link XML API Requests. |

In addition to including these basic minimum values, you need values that refer to a specific resource.

The full OpenURL specification is fairly complex, and is the only place where all possible fields are documented. However, here is a list of the most common key-value pairs for citation data:

| Friendly Name | Key |
| --- | --- |
| Article Title | rft.atitle |
| Journal Title | rft.title |
| Genre | rft.genre |
| ISSN | rft.issn |
| Journal Volume | rft.volume |
| Journal Issue | rft.issue |
| Page Number or Range | rft.spage |
| Issue Date | rft.date |
| Author Last Name | rft.aulast |
| Author First Name | rft.aufirst |
| Author Full Name | rft.au |
| Author Corporation | rft.aucorp |

When you send this citation data for an article to the server, 360 Link attempts to figure out what journal resource you’re looking for, and return full text results if they are available.

To refer to a specific article, we can instead use a [DOI number](http://doi.org/) or [PubMed ID](http://www.ncbi.nlm.nih.gov/sites/entrez?db=PubMed) by using the rft\_id key with a special prefix for the value:

| Friendly Name | Key | \= | Value Prefix |
| --- | --- | --- | --- |
| DOI Number | rft\_id | \= | info:doi/\[doi number\] |
| PubMed Number | rft\_id | \= | info:pmid/\[PubMed ID\] |

#### What Data to Send

The API is expecting at least enough data to identify a journal, and will respond in one of three different ways:

1. Give an error message because of lack of data
2. Return only the most basic journal level information
3. Return full citation information for an article

Usually, the API will not return the article data (like the page number or article name) unless they’re passed in in the request. In many cases, however, a PubMed or DOI id will fetch full article citation data automatically by contacting either a PubMed or DOI service.

### Our first example: A DOI Number Query

The only real required value is the **version**, which refers to the version of the Serials Solutions XML API we’re using. At the time of this writing, the 360 Link API has only one version, **1.0**, so this is the value we’ll use.

Then we need some way of referring to an actual resource, and the simplest way is to refer to an article by a unique article-level link. As an example, let’s use the DOI number for the article **How the Mind Hurts and Heals the Body**. The DOI ID is **10.1037/0003-066X.59.1.29**.

Here’s the key-value pair for our DOI number:

| Friendly Name | Key | \= | Value |
| --- | --- | --- | --- |
| DOI Number | rft\_id | \= | info:doi/10.1037/0003-066X.59.1.29 |

Notice that a DOI Number is specified by adding **info:doi/** at the beginning of the **rft\_id** value to tell it what kind of ID we’re using.

#### Key-Value Pairs in a URL Query String

This is where we send the actual information. URL’s have a format for sending key-value pairs called the **query string**. The query string always starts with a **question mark (?)** that separates it from the BaseURL:

```
 http://000-00.openurl.xml.serialssolutions.com/openurlxml?
```

Then we add a key-value pair, separated by an **equals sign (=)**

```
 version=1.0
```

Then we add our required key-value pairs, separated by **ampersands (&)**

```
 version=1.0&url_ver=Z39.88-2004&rft_val_fmt=info:ofi/fmt:kev:mtx:journal
```

Then we add our DOI number so we can get some citation data:

```
 version=1.0&url_ver=Z39.88-2004&rft_val_fmt=info:ofi/fmt:kev:mtx:journal&rft_id=info:doi/10.1037/0003-066X.59.1.29
```

Now we add the query string to the BaseURL:

```
 http://000-00.openurl.xml.serialssolutions.com/openurlxml?version=1.0&url_ver=Z39.88-2004&rft_val_fmt=info:ofi/fmt:kev:mtx:journal&rft_id=info:doi/10.1037/0003-066X.59.1.29
```

This is close, but won’t quite work. URL’s have rules about what characters are allowed. For example, question marks (?), equals signs (=), and ampersands (&) all have special meanings in a URL, so if we need one of these characters in a URL key or value, we need a different way to represent it.

The only characters that are allowed in the key or value of a URL are:

- Upper case letters (A-Z)
- Lower case letters (a-z)
- A few symbols: the period (.), the dash (-), the underscore (\_) and the tilde (~)

**All** other characters, including the space character, need to be **percent encoded**.

#### Percent Encoding

URL encoding is sometimes called **percent encoding**, because URL codes start with the percent sign (%) and are followed by a 2-digit number. The percent code for a space is **%20**, but it can also be represented by a plus sign (+).

You can view a chart of the percent codes at the [Wikipedia page on percent encoding](http://en.wikipedia.org/wiki/Percent-encoding).

Keep in mind that you don’t encode every character in a URL, just the ones in the keys and values. When we convert these keys and values, we get the following URL:

```
 http://000-00.openurl.xml.serialssolutions.com/openurlxml?version=1.0&rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Ajournal&url_ver=Z39.88-2004&rft_id=info%3Adoi%2F10.1037%2F0003-066X.59.1.29
```

There’s no reason to do this process manually, because this is a great job for a computer.

#### Encoding the key-value pairs with PHP

So, the first part of writing our client is getting your program to encode the values for you, and making a URL the program can send. PHP has a function: **urlencode()** that takes an unencoded string, and returns a string that’s all ready for the key or value part of the URL.

Here is a sample piece of PHP code that goes through a list of URL keys and values like this:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `$required_url_elements` `= Array();`  `$required_url_elements``[``'version'``] = ``'1.0'``;`  `$required_url_elements``[``'rft_val_fmt'``] = ``'info:ofi/fmt:kev:mtx:journal'``;`  `$required_url_elements``[``'url_ver'``] = ``'Z39.88-2004'``;`  `$citation_url_elements` `= Array();`  `$citation_url_elements``[``'rft_id'``] = ``'info:doi/10.1037/0003-066X.59.1.29'``;    `  `$url_elements` `= ``array_merge``(``$required_url_elements``, ``$citation_url_elements``);` |
| --- | --- |

And encodes each key and value, assembling our completed URL:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23 | `$client_identifier` `= ``'000-00'``;`  `$base_url` `= ``'[http://](http://)'` `. ``$client_identifier` `. ``'.xml.search.serialssolutions.com/openurlxml'``;`  `$first_value` `= true;`  `$query_string` `= ``''``;`  `foreach` `(``$url_elements` `as` `$key` `=> ``$value``) {`  `$seperator` `= ``$first_value` `? ``"?"` `: ``"&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;"``;`  `$first_value` `= false; `  `$query_string` `.=`  `$seperator` `.`  `urlencode(``$key``) . ``"="` `. urlencode(``$value``);`  `}`  `$api_url` `= ``$base_url` `. ``$query_string``;` |
| --- | --- |

Once you have the query string, you can use PHP to send it to the Serials Solutions server.

Now we have a valid OpenURL request submittable to 360 Link’s XML API.

#### Trying it out in a browser

If you are not a 360 Link customer, with a valid client identifier and authorized IP address for that client identifier, you’re not going to be able to issue this request. If you can, go ahead and put that URL right in a browser and see what you get.

Get a login popup? Or a 501 error? Then you’re not authorized. Get a hunk of XML? Perfect!

## Sending the Query With cURL via PHP

We’ve constructed our URL, and we could easily print it out, and then cut and paste it into a browser. The whole point of using an XML API is being able to automate this kind of process, so that we can build our ILL form automatically based on any resource our user wants. So we need a way to be able to send our key-value pairs to the Serials Solutions server and get the XML in response. Next we will demonstrate sending a URL and getting a response in PHP using the cURL library[\[3\]](https://journal.code4lib.org/articles/#note3 "reference3").

### cURL in PHP

Since cURL is an external library, we need to make sure it’s enabled in PHP. PHP has a handy way to look at its settings. Just create a file that looks like this, and open in a web browser:

PHP will generate a page showing all of its settings, and external modules. If cURL is installed, you should see something like this included on the page:

![phpinfo() cURL settings](https://journal.code4lib.org/media/issue4/talsky/phpinfo_curl_settings.png)

If you don’t see that, then you may need to do some additional steps to [set up cURL on PHP](http://us2.php.net/manual/en/curl.setup.php) (or see [cURL PHP Docs](http://us3.php.net/curl)). Alternately, you could use fopen()[\[4\]](https://journal.code4lib.org/articles/#note4 "reference4").

Assuming you have PHP with cURL working, here is a simple function that uses cURL to send the URL and get the resulting XML:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50 | `function` `get_xml_result(``$url``) {`  `$ch` `= curl_init();`  `curl_setopt(``$ch``, CURLOPT_URL, ``$url``);`  `$user_agent` `= ``$_SERVER``[``'HTTP_USER_AGENT'``];`  `curl_setopt(``$ch``, CURLOPT_USERAGENT, ``$user_agent``);`  `curl_setopt(``$ch``, CURLOPT_HEADER, 0);`  `curl_setopt(``$ch``, CURLOPT_RETURNTRANSFER, 1);`  `curl_setopt(``$ch``, CURLOPT_FOLLOWLOCATION, 1);`  `curl_setopt(``$ch``, CURLOPT_CONNECTTIMEOUT, 30);`  `curl_setopt(``$ch``, CURLOPT_TIMEOUT, 120);`  `$result` `= curl_exec(``$ch``);   `  `$result` `= trim(``$result``);`  `if` `(curl_errno(``$ch``) != 0) {`  `$result` `= false;`  `$error_message` `= curl_error(``$ch``);`  `} `  `curl_close(``$ch``);    `  `return` `$result``;`  `}` |
| --- | --- |

And what is **$result**? Hopefully, it’s a piece of data from the Serials Solutions servers that we can read and parse. Here’s an example of using the function properly:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `if` `(``$api_url``) {`  `$xml` `= trim(get_xml_result(``$url``));`  `}   `  `if` `(``$xml` `!== false){`  `print``(``"<h2>We got a successful response:</h2>"``);`  `print``(htmlspecialchars(``$xml``));`  `} ``else` `{`  `print``(``"<h2>cURL error</h2>"``);`  `}` |
| --- | --- |

Let’s go over the basics of XML and what we need to know to parse our response.

## Understanding the 360 Link XML Response

### The Diagnostic Message

First of all, here’s the URL we’d use to get this diagnostic message. It’s just the raw BaseURL with no key-value pairs at all:

```
 http://000-00.openurl.xml.serialssolutions.com/openurlxml
```

And here’s the resulting XML we’d get:

Here is a visual diagram of the elements we’d see in a diagnostic message. Compare the elements in the XML to the diagram and it should give a pretty good idea of the shape of this data.

![Simple XML Container Diagram](https://journal.code4lib.org/media/issue4/talsky/diagram_diagnostic_xml.png)

Let’s go over a few of these containers and their meanings:

#### openURLResponse

This element will always be present, whether we get a successful response or an error message.

#### version

This is the API version being echoed back to us, a kind of sanity check, if you will. We can always expect this container.

#### echoedQuery

This is another sanity check, and should always be returned. It’s a copy of the URL query we sent so we can make sure the API server got the same information we sent.

#### diagnostics

The container for one or more **diagnostic** elements. In fact, there’s only going to be one diagnostic element at a time. If we’re missing multiple required parameters, for instance, the API will just pick the first one we’re missing and report on that.

#### diagnostic

This element is a container for the actual error. Theoretically there could be multiple **diagnostic** elements in the **diagnostics** element, but we will only ever get one from this version of the API.

#### uri

URI means Uniform Resource Indicator. A URL is one kind of URI. This refers to a code for the error message that was returned that refers to the 360 Link and OpenURL documentation.

#### message

This is the error type that the **uri** refers to. This can be only one of a few messages and won’t give a lot of detail about what the problem was.

#### details

This will be more specific text about what went wrong. Used in combination with the **message** you should be able to decipher what went wrong. Taking a look at our earlier message, and putting together the **message** and **details**, we should be able to figure out what went wrong.

Message: Mandatory parameter not supplied

Details: Version not specified

So, the message is not very specific. It just gives us the message that we missed a mandatory parameter. It is the details section which tells us which parameter was missing.

#### Other Diagnostic Messages

The full list of diagnostic information is detailed in the 360 Link XML API documentation, but some other kinds of diagnostic message types are:

- System Temporarily Unavailable
- Authentication error
- Unsupported version
- Identifier with no data
- Not enough metadata supplied

### A Successful Query

Now let’s look at an example of a successful query that returns results. Here’s the example for our earlier DOI example query:

```
 http://000-00.openurl.xml.serialssolutions.com/openurlxml?version=1.0&rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Ajournal&rfr_id=info%3Asid%2Fsersol%3ARefinerQuery&url_ver=Z39.88-2004&rft_id=info%3Adoi%2F10.1037%2F0003-066X.59.1.29
```

And the XML result:

Even though this example is a little more complicated, you should still be able to make out the structure of these responses.

And a diagram of the successful result:

![Simple XML Container Diagram](https://journal.code4lib.org/media/issue4/talsky/diagram_results_xml.png)

Now, let’s sort out the important information from things you can safely ignore.

#### Namespaces

Take a look at this piece of XML:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `<``ssopenurl:results` `dbDate``=``"2008-07-18"``>`  `<``ssopenurl:result` `format``=``"journal"``>`  `<``ssopenurl:citation``>`  `<``dc:title``>Some Article Not At The Library</``dc:title``>`  `<``dc:creator``>Some Guy</``dc:creator``>`  `<``dc:source``>Some Journal Not At The Library</``dc:source``>`  `<``ssopenurl:volume``>5</``ssopenurl:volume``>`  `<``ssopenurl:issue``>32</``ssopenurl:issue``>`  `<``ssopenurl:spage``>12</``ssopenurl:spage``>`  `</``ssopenurl:citation``>`  `</``ssopenurl:result``>`  `</``ssopenurl:results``>` |
| --- | --- |

The element names are prefixed by some characters seperated by a colon (:). These represent groups of elements. The **dc:** prefix, for instance, refers to meta-information specified by the [Dublin Core](http://dublincore.org/) standard for library information. For the purposes of interpreting our XML results, they can mostly be ignored, and you can use **only** the element name (the part after the colon) to refer to them.

You’ll notice that the first few lines of the XML mostly serve to set up these namespaces. These can be safely ignored as well.

It’s beyond the scope of this tutorial to explain every part of the XML response, since we’re mostly focusing on what we’d get in the **citationData** container, but let’s go over a few of the containers we’ll see:

#### results

If you got this container, you know some real data was retrieved, and not just a diagnostic message. A **results** element can contain one or more result elements and nothing else.

#### result

A **result** element represents a single journal-level resource. It’s possible to get more than one result, but that means that the 360 Link server wasn’t sure which resource you mean. When you get more that one result element, you usually need some kind of disambiguation to help the user decide what resource they meant.

#### linkGroups / linkGroup

This is usually what the 360 Link web-based tool and API are both primarily for: to indicate and link to full-text resources for the requested article. The details of a **linkGroup** element are beyond the scope of this article, since we want to fill out an ILL form only when the library does **not** have a full text resource available and it needs to be requested from another library.

#### citation

This is the focus of most of our attention. When we get back citation data, but no full text link, that means we can use the citation data to populate our ILL form.

Usually, we will get journal level citation data back from the server. We will not usually, however, get article level links, unless we passed them into the query. For example, if we pass in a page range in the URL, we will see that page range echoed here.

An exception is when we pass in a DOI or similar article level identifier. In this case, the API will sometimes fetch more complete data about the article from a similar service.

See the later code examples, and the sample ILL form for examples of the kind of citation data we’ll be looking for to populate our ILL form.

## Parse the XML Response with PHP

Now that we can send a query and get the results back as XML, we need to

**Parsing** a piece of XML means to use a program to break it apart into its component parts, so any piece can be accessed. There are many methods for parsing XML files, and I’m choosing the DOM method for this tutorial. There is [an overview on the PHP site](http://us2.php.net/manual/en/refs.xml.php) that shows all the different methods.

Parsing a piece of XML means to use a program to break it apart into its component parts, so any piece can be accessed. There are many methods in PHP for parsing XML files, and I’m choosing the PHP4 domxml method for this tutorial. There is [an overview on the PHP site](http://us2.php.net/manual/en/refs.xml.php) that shows all the different methods. PHP processing changed a bit in PHP5. I use a PHP4 example because PHP4 is still the most widely installed. If you read and understand these examples, it shouldn’t be too hard to read the [PHP5 DOM documentation](http://us.php.net/manual/en/book.dom.php) and adapt the code here for PHP5.

### Turn an XML String into a PHP Object

The first thing we need to do is take our XML string and turn it into something useful in PHP. The way to do this is to use the [domxml\_open\_mem()](http://us2.php.net/domxml_open_mem) method.

This method takes an XML string and attempts to turn it into something called a DomDocument object. This is a PHP object that acts like an XML container with containers inside it, but allows you to ask the container for information.

This is how you use it:

```
 if ($xmldomdoc = domxml_open_mem($xml)) {      } else {     

}
```

### Get the ILL Data Out of the PHP Object

Now that we have an object in PHP that represents our XML, the XML is in a much more useful form. Now we can use some PHP tools to look for specific containers and get their contents.

#### Looking for Elements With get\_elements\_by\_tagname()

Now that we have a PHP object, we have a handful of things we can do with it, but the most useful thing is to ask the object for its elements. That is done using the [get\_elements\_by\_tagname()](http://us2.php.net/manual/en/function.domdocument-get-elements-by-tagname.php) method.

[get\_elements\_by\_tagname()](http://us2.php.net/manual/en/function.domdocument-get-elements-by-tagname.php) takes a name of an element, and always returns an array whether it finds any elements by that name or not.

#### Getting the Contents of Elements with get\_content()

The next important method of the DomDocument object is the [get\_content()](http://us2.php.net/manual/en/function.domnode-get-content.php) method. If you’re in a container that has the actual data you need, you can call [get\_content()](http://us2.php.net/manual/en/function.domnode-get-content.php) to get the actual text inside.

These two methods are just about all we need to get the data for our ILL form.

Here’s some examples of how to use them:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 | `$array_of_containers` `= ``$xmldomdoc``->get_elements_by_tagname(``'version'``);`  `foreach` `(``$array_of_containers` `as` `$container``) {`  `$version_number` `= ``$container``->get_content();`  `}`  `$the_only_version_container` `=`  `array_pop``(``$xmldomdoc``->get_elements_by_tagname(``'version'``));`  `if` `(``is_callable``(``array``(``$the_only_version_container``,``'get_content'``))) {`  `$version_number` `= ``$the_only_version_container``->get_content();`  `}` |
| --- | --- |

#### Using array\_pop() and is\_callable() to confirm the presence of data

Some containers may or may not appear in the XML result. ISSN, for instance, we would want to display in our ILL form if available, but our XML might not have an ISSN container. If we call [get\_elements\_by\_tagname()](http://us2.php.net/manual/en/function.domdocument-get-elements-by-tagname.php) on the ISSN container, it will return an empty array.

We’re calling [array\_pop()](http://us3.php.net/manual/en/function.array-pop.php), which returns the first element in an array. If the array is empty, it returns NULL, meaning no value. If you try to call [get\_content()](http://us2.php.net/manual/en/function.domnode-get-content.php) on NULL, PHP will return a fatal error: **Call to a member function on a non-object**.

One way of avoiding this in PHP is to use [is\_callable()](http://us3.php.net/manual/en/function.is-callable.php) to make sure [get\_content()](http://us2.php.net/manual/en/function.domnode-get-content.php) is allowed for the object you’re about to call. You can see an example of use in the example above.

Now we have the tools we need to handle our ILL form.

## When to display the ILL form

We don’t automatically want to display an ILL form. The only case where we want to is when a user requests a valid resource we don’t have access to at the library.

Here’s a chart that shows the different cases and how to handle them:

| Situation | Meaning | How to handle it |
| --- | --- | --- |
| We get a diagnostic message | Somehow we didn’t construct a valid request. | Recover gracefully and display a useful error message to the user. Log the error and troubleshoot the problem. |
| We get multiple results. | There was more than one matching possibility for the information sent. | Display a disambiguation page to let the user choose which resource they meant. |
| We get a result with full text links | The resource is available to the organization or library. | Display links to the full text of the article. |
| We get a result with no full text links | The resource isn’t available. | Use the citation information to populate an ILL form. |

[Attached are some helper methods and code that will let you determine which of these decisions to make.](https://journal.code4lib.org/media/issue4/talsky/sourcecode/decision_helper.phps)

These methods work by looking for containers by a certain name, and then using the [count()](http://us.php.net/count) method to see how many containers were found. If there is no **diagnostics** container, then we didn’t get an error message. If there are more than one **result** container then that means we got more than one article result. If there is a **linkGroup** container, that means we got link resolver results.

Once we have these methods, we can use them to make a decision about what to display:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `$do_ill_form` `= false;`  `if` `(docxml_has_diagnostic(``$xmldomdoc``)) {`  `} ``elseif` `(docxml_has_multiple_article_results(``$xmldomdoc``)) {`  `} ``elseif` `(docxml_has_link_groups(``$xmldomdoc``)) {`  `} ``else` `{`  `$do_ill_form` `= true;`  `}` |
| --- | --- |

### Getting the variables we need

Let’s assume we know we want to display the ILL form now.

Here’s a query example of a fake article, where we pass in citation data we made up. Of course, the link resolver won’t find any full text results, and we will want to construct the ILL form.

```
 http://000-00.openurl.xml.serialssolutions.com/openurlxml?rft.title=Some+Journal+Not+At+The+Library&rft.atitle=Some+Article+Not+At+The+Library&rft.au=Some+Guy&rft.volume=5&rft.issue=32&rft.pages=12-14&version=1.0&rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Ajournal&rfr_id=info%3Asid%2Fsersol%3ARefinerQuery&url_ver=Z39.88-2004
```

[Attached is an example of an XML response we’d get, with the citation data included and no full text links.](https://journal.code4lib.org/media/issue4/talsky/sourcecode/response_no_fulltext.xml.txt)

Here’s the code we’d use to get the variables we need. Note that the XML element names are not always the same as the OpenURL variables!

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `$citation_container` `=`  `array_pop``(`  `$xmldomdoc``->get_elements_by_tagname(``'citation'``));`  `$creator_container` `=`  `array_pop``(`  `$citation_container``->get_elements_by_tagname(``'creator'``));`  `if` `(``is_callable``(``array``(``$creator_container``,``'get_content'``))) {`  `$au` `= ``$creator_container``->get_content();`  `}`  `# more` |
| --- | --- |

( [More complete example attached here.](https://journal.code4lib.org/media/issue4/talsky/sourcecode/get_metadata_from_response.phps) )

## Constructing the ILL form in HTML

Now that we have all the PHP variables we need, we need only the smallest effort to turn an HTML form into one that auto-populates with the citation data.

### Using an HTML form as an ILL form

#### ILL Form Example

We will start with an example of a simple static ILL form that will always have it's values start out blank, then we'll explain how to make one that's populated by our PHP script with the citation values returned in XML by 360 Link.

[Attached is some sample HTML for a simplified version of an ILL form.](https://journal.code4lib.org/media/issue4/talsky/sourcecode/ill_form.html.txt)

Include some CSS to make it pretty:

| 1  2  3  4  5  6  7  8  9  10  11  12  13 | `form .formField {`  `margin-bottom``: .``3em``;`  `clear``: ``left``;`  `}`  `form .formField label {`  `width``: ``12em``;`  `float``: ``left``;`  `}`  `form .formField input {`  `width``: ``20em``;`  `}` |
| --- | --- |

#### Adding PHP to Populate the Form

We take that static HTML from before, and embed it in a PHP file, adding code to populate the form the variables we've grabbed from the XML response.

Here’s one example:

| 1 | `<input type=``"text"` `id=``"au"` `name=``"au"` `value=``"<?php print($au); ?>"` `/>` |
| --- | --- |

[Attached here is the whole form retooled to show our variables.](https://journal.code4lib.org/media/issue4/talsky/sourcecode/ill_form.phps)

### What’s Missing

This form doesn’t have any code included to make it validate. That is to say, it doesn’t do anything to ensure that the values people enter are valid, or that they have filled out the required fields. But form validation using PHP or JavaScript is well documented on the web and beyond the scope of this article.

Here’s a few good articles on form validation:

- [Simon Willison’s Weblog: Easier form validation with PHP](http://simonwillison.net/2003/Jun/17/theHolyGrail/)
- [Form Validation Using PHP to highlight non valid fields](http://www.weberdev.com/get_example-4396.html)
- [Sensible Forms: A Form Usability Checklist](http://www.alistapart.com/articles/sensibleforms/)
- [A Guide to Unobtrusive Javascript Validation](http://particletree.com/features/a-guide-to-unobtrusive-javascript-validation/)

For the purposes of this article, we’re only populating the citation data, but if you have a logged in user, it’s possble to populate the name and email address of the requester as well.

## Handling the Submitted ILL Form

Let’s take a look at the **form** tag in the email form:

| 1 | `<``form` `action``=``"incoming_ill_form_handler.php"` `method``=``"post"``>` |
| --- | --- |

There’s two useful pieces of information here. One is the action and the other is the method. This sends the information in the form to a PHP script called incoming\_ill\_form\_handler.php via the HTTP POST method.

### Reading the Form Data

PHP fills an array called $\_POST with incoming form data. Here’s a simple way to debug and look at the information:

| 1  2  3 | `<span ``class``=``"html-tag"``>``print``</span>(<span ``class``=``"quoted-strings"``>``'<h2>POST VALUES</h2>'``</span>);`  `<span ``class``=``"html-tag"``>``print``</span>(<span ``class``=``"quoted-strings"``>``"<pre>"``</span>); var_dump(<span ``class``=``"php-variables"``>``$_POST``</span>); <span ``class``=``"html-tag"``>``print``</span>(<span ``class``=``"quoted-strings"``>``"</pre>"``</span>);` |
| --- | --- |

If we submitted the form as filled, we’d see this:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30 | `array``(14) {`  `[``"Name"``]=>`  `string(0) ``""`  `[``"Division_Dept"``]=>`  `string(0) ``""`  `[``"email"``]=>`  `string(0) ``""`  `[``"Priority_NeedBy"``]=>`  `string(0) ``""`  `[``"au"``]=>`  `string(8) ``"Some Guy"`  `[``"atitle"``]=>`  `string(31) ``"Some Article Not At The Library"`  `[``"title"``]=>`  `string(31) ``"Some Journal Not At The Library"`  `[``"date"``]=>`  `string(0) ``""`  `[``"volume"``]=>`  `string(1) ``"5"`  `[``"issue"``]=>`  `string(2) ``"32"`  `[``"pages"``]=>`  `string(2) ``"12"`  `[``"issn"``]=>`  `string(0) ``""`  `[``"pmid"``]=>`  `string(0) ``""`  `[``"s_request"``]=>`  `string(14) ``"Submit Request"`  `}` |
| --- | --- |

### Previewing the Data in a Web Page

The simplest use of the form data is to display it on a web page as a preview. [Attached is a quick code sample for doing this safely.](https://journal.code4lib.org/media/issue4/talsky/sourcecode/form_data_display.phps) See the security section for more details on why to use [htmlspecialchars()](http://us2.php.net/manual/en/function.htmlspecialchars.php).

### Sending an email With the ILL Form

Sending an email is similar. We just need to construct a string for the body of the email and use PHP’s [mail()](http://us2.php.net/function.mail) function. Here is a basic example:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31 | `$body` `= ``"ILL FORM DATA \n\n"``;`  `$body` `.= ``"Name: "` `. ``$_POST``[``'Name'``] . ``"\n"``;`  `$body` `.= ``"Division:"` `. ``$_POST``[``'Division_Dept'``] . ``"\n"``;`  `$body` `.= ``"email:"` `. ``$_POST``[``'email'``] . ``"\n"``;`  `$body` `.= ``"Need Date:"` `. ``$_POST``[``'Priority_NeedBy'``] . ``"\n"``;`  `$body` `.= ``"Author:"` `. ``$_POST``[``'au'``] . ``"\n"``;`  `$body` `.= ``"Article:"` `. ``$_POST``[``'atitle'``] . ``"\n"``;`  `$body` `.= ``"Journal:"` `. ``$_POST``[``'title'``] . ``"\n"``;`  `$body` `.= ``"Issue Date:"` `. ``$_POST``[``'date'``] . ``"\n"``;`  `$body` `.= ``"Pages:"` `. ``$_POST``[``'pages'``] . ``"\n"``;`  `$body` `.= ``"ISSN:"` `. ``$_POST``[``'issn'``] . ``"\n"``;`  `$body` `.= ``"PubMed ID:"` `. ``$_POST``[``'pmid'``] . ``"\n\n"``;`  `function` `has_no_newlines(``$text``)`  `{`  `return` `preg_match(``"/(%0A\|%0D\|\\n+\|\\r+)/i"``, ``$text``) == 0;`  `} `  `$sanitized_name` `= ``'Default Name'``;`  `if` `(has_no_newlines(``$_POST``[``'Name'``])) {`  `$sanitized_name` `= ``$_POST``[``'Name'``];`  `}`  `$subject` `= ``"An ILL Request form has been filled out by "` `. ``$sanitized_name``;`  `$to` `= ``'danieltalsky@gmail.com'``;`  `mail(``$to``, ``$subject``, ``$body``);` |
| --- | --- | --- | --- | --- |

### Storing the ILL Form in MySQL

Covering all aspects of storing data using PHP and MySQL is beyond the scope of this article, and is well covered in the excellent [MySQL Documentation](http://dev.mysql.com/doc/), [MySQL documentation about PHP](http://dev.mysql.com/usingmysql/php/) and [PHP documentation about MySQL](http://us3.php.net/manual/en/book.mysql.php). Still, a few useful examples are provided below.

First of all, here’s a simplified example of a table structure that would store our ILL form:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `CREATE` `TABLE` `` `ill_form` ( ``  `` `id` SERIAL, ``  `` ` ```name``` `  ```VARCHAR``(100) ``NOT` `NULL``,`  `` `division_dept`  ```VARCHAR``(50),`  `` `email`  ```VARCHAR``(255) ``NOT` `NULL``,`  `` `need_date`  ```VARCHAR``(50),`  `` `author`  ```VARCHAR``(100),`  `` `article`  ```VARCHAR``(255),`  `` `journal`  ```VARCHAR``(255),`  `` `issue_date`  ```VARCHAR``(50),`  `` `pages`  ```VARCHAR``(20),`  `` `issn`  ```VARCHAR``(10),`  `` `pmid`  ```VARCHAR``(20),`  `` `time_submitted`  ```TIMESTAMP` `NOT` `NULL` `DEFAULT` `NOW()`  `);` |
| --- | --- |

And here’s an example of PHP code that would construct a safe SQL query:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `$sql_insert` `= ``'INSERT INTO ill_form '``;`  `$sql_insert` `.= ``' (name, division_dept, email, need_date, author, '``;`  `$sql_insert` `.= ``' article, journal, issue_date, pages, issn, pmid) '``;`  `$sql_insert` `.= ``' VALUES '``;`  `$sql_insert` `.= ``' ('``;`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['Name``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['Division_Dept``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['email``']) . '``, ';`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['Priority_NeedBy``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['au``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['atitle``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['title``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['``date``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['pages``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['issn``']) . "'``,";`  `$sql_insert` `.= ``"'"` `. mysql_real_escape_string(``$_POST``['pmid``']) . "'``,";`  `$sql_insert` `.= ``' );'``;` |
| --- | --- |

Using [mysql\_real\_escape\_string()](http://us3.php.net/manual/en/function.mysql-real-escape-string.php) allows mysql to handle most tricks people would use to try to get MySQL to execute SQL code you didn’t intend.

Finally, a couple of samples of retrieving the data using raw SQL (MySQL Specific):

/\* Gets all entries \*/  
SELECT \* FROM ill\_form;

/\* Gets all entries in the last month \*/  
SELECT \* FROM ill\_form WHERE DATE\_SUB(CURDATE(),INTERVAL 1 MONTH) <= time\_submitted; \[/sourcecode\]

### Unpleasant but Necessary Security Addendum

Always remember, do not trust data supplied by a user-submitted form. People or automated bots can place code in webforms that’s meant to hack the browser through javascript, PHP, or SQL. These kinds of attacks are common and easy to do, so it’s vital to be responsible with your organization’s data.

Some security can be handled by good validation of the form when it’s submitted, but that is not a substitute for handling user-submitted data responsibly. It is easy for a hacker to send data to your processing page in a way that bypasses your form validaton.

It can seem like there’s so much you can’t know about security that it’s almost not worth bothering, but the following examples should provide coverage from the most obvious kinds of attacks.

#### For Display on an HTML Page

People can enter both HTML and javascript in form fields. If you’re displaying things people entered in a web form back to them, it’s vital that you use a function like PHP’s [htmlspecialchars()](http://us2.php.net/manual/en/function.htmlspecialchars.php). This converts any special characters to a safe character set for display and derails the potential for javascript execution.

Just imagine if someone entered the following into a form field and you just printed it right to an HTML page!

```
 <script type="text/javascript">alert('BAD SECURITY!');</script>
```

#### For emailing

The essential thing to remember is if you are inserting something from user input into the headers of an email (the **subject**, the **from**, **to** or **CC** lines), you need to make sure there aren’t any non-printing characters or linebreaks. Usually a regular expression that makes sure it’s a valid email address or at least doesn’t contain the linebreak in the **\\r\\n** format is sufficient to prevent email injection.

This is covered in detail in [this excellent tutorial on preventing PHP email injection](http://www.thesitewizard.com/php/protect-script-from-email-injection.shtml).

#### For Insertion into a Database

This is possibly the most dangerous and easily avoided problem. This kind of attack is called SQL injection, and is well detailed on the Wikipedia page on [SQL Injection](http://en.wikipedia.org/wiki/SQL_injection).

All SQL API’s will have an appropriate quoting mechanism or prepare statement. The important thing to remember is to never put raw data from a user into a SQL query like this:

```
 $sql = "SELECT * FROM USERS WHERE NAME = '" . $user_submitted_name . "';";
```

This sample doesn’t make sure special characters are escaped, and allows room for sql injection. See our MySQL example earlier for one example of doing it properly using mysql\_real\_escape\_string()

Anytime you use data from a user form, just think about how the data is being used, and consider the possibility of abuse.

## In Conclusion

There are many possible uses for the 360 Link XML API, and this article was meant to explain one of the simplest ones: using the returned citation data to construct an ILL form.

We covered the basics of querying the API server, interpreting the response, parsing the XML and displaying the citation data in an HTML form, then storing the results of that form in a MySQL database or sending them in an email. These skills, especially the security notes, are useful in almost any kind of web application.

If you’re considering using the XML API in any way, I’d love to hear about it. Please contact me at danieltalsky@serialssolutions.com and tell me what you’re working on. I’ll be able to answer a few simple questions and point you in the direction of further resources based on your goals.

## Notes

[\[1\]](https://journal.code4lib.org/articles/#reference1 "note1") *Note from the editors:* [NISO standard Z39.88](http://www.niso.org/kst/reports/standards?step=2&gid=&project_key=d5320409c5160be4697dc046613f71b9a773cd9e) formally defines OpenURL, but it can be a bit confusing for some. More information is also available at [http://openurl.code4lib.org](http://openurl.code4lib.org/) and from Jeff Young’s Q6 blog: [http://q6.oclc.org/](http://q6.oclc.org/).

[\[2\]](https://journal.code4lib.org/articles/#reference2 "note2") Many ILL forms are behind a login, but the New York Academy of Medicine has been kind enough to allow us to link to the [NYAM ILL Form](http://www.nyam.org/library/ill.php) as an example for this article, and use their form as an inspiration for the basic HTML example used in the article.

[\[3\]](https://journal.code4lib.org/articles/#reference3 "note3") cURL is a PHP library for accessing files over the internet. PHP has another way of accessing files over the internet: its native fopen() function. fopen() is a lot slower and in some ways is less reliable. cURL is more reliable, flexible, and over ten times faster.

[\[4\]](https://journal.code4lib.org/articles/#reference4 "note4") If there’s some problem with cURL on your server, it shouldn’t be too hard to use fopen(). Here’s the [PHP fopen() documentation](http://us3.php.net/fopen), and [information about using it to open files across the internet](http://us3.php.net/wrappers.php).

## Acknowledgements

**Kat Ortland** for copy editing, **Shawn Kilburn** for the article concept and consultation on 360 Link, **Brenna Flood** for extensive consultation on the 360 Link XML API, **Chris Phillipe**, for 360 Link consultation, **Ross Bleakney** for getting me into XML API documentation at Serials Solutions, **Mark Foong** & **Harry Kaplanian** for providing the time and operational support for me to write this article and **Lisa Genoese** & **Steve Chiaffoni** at the **New York Academy of Medicine** for supplying code and permission to use their ILL form as an example.

## About the Author

Daniel Talsky is a programmer and tech educator at Serials Solutions. He is beginning a tutorial and outreach program to educate librarians and web developers about Serials Solutions XML API’s. He can be contacted at daniel.talsky@serialssolutions.com .
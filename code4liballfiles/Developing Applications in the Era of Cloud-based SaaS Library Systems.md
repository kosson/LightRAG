---
title: "Developing Applications in the Era of Cloud-based SaaS Library Systems"
source: "https://journal.code4lib.org/articles/10029"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-10-21
created: 2025-01-10
description: "As the move to cloud-based SaaS library systems accelerates, we must consider what it means to develop applications when the core of the system isn't under the library's control. The entire application lifecycle is changing, from development to testing to production. Developing applications for cloud solutions raises new concerns, such as security, multi-tenancy, latency, and [...]"
tags:
  - "clippings"
---
# Developing Applications in the Era of Cloud-based SaaS Library Systems

Josh Weisman

As the move to cloud-based SaaS library systems accelerates, we must consider what it means to develop applications when the core of the system isn’t under the library’s control. The entire application lifecycle is changing, from development to testing to production. Developing applications for cloud solutions raises new concerns, such as security, multi-tenancy, latency, and analytics. In this article, we review the landscape and suggest a view of how to be successful for the benefit of library staff and end-users in this new reality. We discuss what kinds of APIs and protocols vendors should be supporting, and suggest how best to take advantage of the innovations being introduced.

## Introduction

No system lives in a vacuum, and no system provides 100% of features required by its users. This maxim is equally true of library systems, and many institutions invest in the development of applications that live along side the primary library management system. Additionally, code is often required to integrate the library management system within the larger institutional technology landscape. This integration code is equally critical for the smooth operations of the library.

In a local environment, the options for integrations are many- access to the server environment, direct SQL queries against the database, log file access, manipulation of configuration files. The institution has full control over the application and its infrastructure. As more organizations seek to enjoy the benefits of moving applications and infrastructure to the cloud, many are joining the wave of adoption of cloud-based library management systems. Software as a service (SaaS) offerings in this space are increasing in number and features. Developers face new challenges in designing, coding, and testing their applications against these SaaS systems.

This article discusses the considerations for vendors when designing their API and integration offerings for cloud-based systems, and for developers when integrating with those systems. It is based on the experience Ex Libris gained in building our Developer Network[<sup>1</sup>](https://journal.code4lib.org/articles/#sdfootnote1sym), a next-generation developer and API platform for our cloud-based library systems. Many of the examples and screen shots in this article are taken from our implementation.

## Development Lifecycle

There are many models for the software development lifecycle, but most of them can be summarized as design, develop, test, deploy.

![Figure 1](https://journal.code4lib.org/media/issue26/weisman/Figure1.png)

**Figure 1.** Development Lifecycle

When developing applications against locally-hosted systems, there are often a number of installed environments that support this lifecycle. When working against cloud-based systems, we need support for a similar tiered-development environment. We also need the supporting material and documentation to be thorough and accessible.

### Design: Documentation

Good documentation is important for all development projects. In the cloud, it is essential.

Developers must be provided with details of the available APIs to understand what functionality is possible. Details about the input and output parameters are necessary to follow the data flow between the custom application and the library management system. Workflow examples should be provided to help analysts orchestrate the APIs into full stories.

In the cloud, vendors have an opportunity to ease the design phase by making API documentation openly available and searchable by standard search engines. Removing barriers such as usernames and passwords allows developers and analysts to more easily discover the information they need and share it with others.

#### Automatic Generation of Documentation

Cloud systems operate on an accelerated release cycle. Keeping documentation up-to-date with changes in the product is even more challenging. Documentation which is out-of-date or incorrect erodes the confidence of developers and reduces their interest in using the product’s APIs.

Automating the creation of API documentation is one way to reduce friction. Automation means the documentation is always in synch with the API and is always accurate. Our process leverages-third party tools in addition to some homegrown code.

![Figure 2](https://journal.code4lib.org/media/issue26/weisman/Figure2.png)

**Figure 2.** Automatic Documentation Process

First, the API developers add documentation directly to the API code. This is done for both the web service description and for the data transfer objects which are passed as a payload in the body of the API request or response. For web service descriptions, we add attributes to the code based on the Apache CXF[<sup>2</sup>](https://journal.code4lib.org/articles/#sdfootnote2sym) library. The CXF library then creates a WADL[<sup>3</sup>](https://journal.code4lib.org/articles/#sdfootnote3sym) file based on the annotations.

An example of the documentation annotations follows:  
`    @GET   @Path("funds")   @Descriptions({   @Description(value = "This API returns a list of Funds.", title = "Retrieve funds", target = DocTarget.METHOD),   })   public Funds getFunds(   @Description("The code of the library that owns the PO line for which the relevant funds should be retrieved. Optional.") @QueryParam("library")   @DefaultValue("") String libraryCode)   {    `

**Figure 3.** Documentation Annotation

To produce documentation for the body objects, we use XSD schemas. The developers add documentation directly to the schema using the ` <xs:annotation>` tags.

| 1  2  3  4  5  6  7  8  9 | `<``xs:element` `name``=``"primary_id"` `type``=``"xs:string"` `minOccurs``=``"0"` `maxOccurs``=``"1"``>`  `<``xs:annotation``>`  `<``xs:appinfo``>`  `<``xs:tags``>api sis get post put</``xs:tags``>`  `</``xs:appinfo``>`  `<``xs:documentation``>The primary identifier of the user. Mandatory. Note that the primary_id is case insensitive.`  `</``xs:documentation``>`  `</``xs:annotation``>`  `</``xs:element``>` |
| --- | --- |

**Figure 4.** Sample XSD documentation

We further leverage the schema by placing tags on the elements which allow us to filter fields in our documentation based on parameters in the querystring. For example, we can provide an HTML page which displays fields that are relevant for POST requests only. The page filters the fields based on the tags taken from the XSD.

The final step in the automatic documentation process is to execute an XSL transform on the WADL and XSD files to produce HTML documentation[<sup>4</sup>](https://journal.code4lib.org/articles/#sdfootnote4sym). This assures that the documentation provided to developers is timely and accurate.

### Develop: Console

In traditional application environments, it can often take a long time for a developer to successfully make and request and get a response to an API call. Once the test environment is deployed, the developer still needs to read the documentation, understand how to format a request, create the test script or application, and provide the required server details and credentials.

In the world of cloud, we can significantly reduce this “time to first ‘Hello World’” (TTFHW[<sup>5</sup>](https://journal.code4lib.org/articles/#sdfootnote5sym)) by providing a way to call the APIs directly online, from a web browser, against a guest sandbox environment. An “API console” helps developers be productive quickly by removing barriers and allowing them to learn by experimentation.

An API console provides details of the selected API call, allows the developer to enter the parameters, executes the request directly from the browser to a test or demo environment, and provides the response from the server.

This instant feedback provides developers with quick successes, and allows experimentation with various parameters and formats. Once the developer gets the desired results, the console can also provide a code stub in various languages that can be used inside a real application. This shortcut can help decrease development time and allow programmers to concentrate on the business logic rather than the “plumbing” code.  
![Figure 5 - API Console](https://journal.code4lib.org/media/issue26/weisman/Figure5.png)

**Figure 5.** API Console

### Trial-and-Error Coding

Using an API console allows the developer to quickly explore the API and its parameters.

For example, we can execute a GET request in the console such as:

```
   GET /myapp/v1/users/test
   Accept: application/json
```

The console immediately returns as response:

```
  Date: Tue, 16 Sep 2014 19:07:59 GMT
  Response-Status: HTTP/1.1 400 Bad Request
  Content-Type: application/json;charset=UTF-8
  Content-Length: 187

  {
     "errorsExist": true,
     "errorList":
  {
       "error": [
        {
            "errorCode": "401861",
            "errorMessage": "User with identifier j was not found.\n(Tracking ID: E01-1609190759-CBB7C-AWAE151072507)"
        }
       ]
     },
  }
```

We’re on the right track, but we need a valid user. Once we modify the request slightly:

```
  GET /myapp/v1/users/josh
  Accept: application/json
```

We get a better response:

```
  Date: Tue, 16 Sep 2014 19:12:57 GMT
  Response-Status: HTTP/1.1 200 OK
  Content-Type: application/json;charset=UTF-8
  Content-Length: 1438

  {
     "primary_id": "josh",
     "first_name": "Josh",
  }
```

While this is a trivial example, these advances allow developers to explore the effects of parameters and the response objects provided by the server iteratively in a convenient environment. Once satisfied, the console can produce scaffolding JavaScript code which can be used inside a real application.

| 1  2  3  4  5  6  7  8  9  10 | `var` `xhr = ``new` `XMLHttpRequest();`  `var` `url = ``'/myapp/v1/users/{user_id}'``.replace(/{user_id}/g, encodeURIComponent(``'josh'``));`  `xhr.open(``'GET'``, url + queryParams);`  `xhr.setRequestHeader(``'Accept'``, ``'application/json'``);`  `xhr.onreadystatechange = ``function` `() {`  `if` `(``this``.readyState == 4) {`  `alert(``'Status: '``+``this``.status+``'\nHeaders: '``+JSON.stringify(``this``.getAllResponseHeaders())+``'\nBody: '``+``this``.responseText);`  `}`  `};`  `xhr.send(``''``);` |
| --- | --- |

This type of immediate feedback without the need to set up an entire development environment considerably reduces development time.

## Test: Sandbox

Once the application is developed, it must be tested. In local systems, this is usually done in a test or staging environment. Many cloud providers offer a sandbox environment to customers that may include either sample data or a version of the customer’s actual data.

Developers should have API access to the sandbox environment to test their applications.

## Deploy: Production

In a local environment, deploying an application in production often requires configuration changes to update server names, IP addresses, ports, credentials, etc. In the cloud world, we can offer a more seamless deployment process.

In the example below, we see a developer using a dashboard to change their application from sandbox mode to production mode. Without requiring any changes to their own application, it is now pointing to their production instance.

![Figure 6 - Deploying an application to production](https://journal.code4lib.org/media/issue26/weisman/Figure6.png)

**Figure 6.** Deploying an application to production

The following figure depicts the development lifecycle in the cloud:

![Figure 7 - Development Lifecycle in the Cloud](https://journal.code4lib.org/media/issue26/weisman/Figure7.png)

**Figure 7.** Development Lifecycle in the Cloud

## Modern Standards

The move to the cloud provides an opportunity to implement APIs according to modern standards. Any discussion of web API standards begins with the REST architectural style[<sup>6</sup>](https://journal.code4lib.org/articles/#sdfootnote6sym). But even for those whose APIs adhere to the REST style, there exists much room for interpretation. Vendors should invest effort in defining a style for their APIs and work to ensure consistency. Doing so reduces friction for developers. We recommend that the vendor’s API style guide be shared with the developer community[<sup>7</sup>](https://journal.code4lib.org/articles/#sdfootnote7sym).

### Hard Decisions

As part of the process of defining an API standard, providers are forced to make some hard decisions. While there are widely-agreed guidelines for building modern APIs (REST, JSON, etc.), there are other questions to which there is no clear answer. If the decision is well-reasoned and consistent, API consumers can accept and adapt to the decided-upon style.

### Response Codes for Invalid Objects

One example of this type of question is the proper response code for a request to a URI of an object which does not exist. A client might make a call to /cars/123 while there is no such car with that ID number. There are two possible approaches:

- Return a 400 Bad Request, which indicates that while the service is valid (/cars), the requested car does not exist. Provide additional details in the response body indicating why the request is bad.
- Return a 404 Not Found, which indicates that the requested resource does not exist. While this accurately describes the circumstances, a client might be confused between the case of a valid service with and invalid ID, or an invalid service (/carrs/123, for example)

We decided on the first option in our implementation.

### Non-CRUD Services

Another example of a hard decision is how to handle non-CRUD requests in REST APIs. The standard REST methodology provides for the following allocation of HTTP verbs to CRUD services:

| **CRUD Action** | **HTTP Verb** |
| --- | --- |
| **Create** | POST |
| **Read** | GET |
| **Update** | PUT |
| **Delete** | DELETE |

However, there is no natural mapping for non-CRUD services. For example, in the library world, we have a service such as “renew a loan” or “receive an item”. We want to avoid falling into the trap of defining SOAP/RPC-like endpoints, and it’s important to stick with the REST standard of nouns as URIs. So a service such as POST /items/1234/loans/renew or POST /items/1234/renewLoan is undesirable.

Given this, our decision was to POST to the object with the operation in the query string. A PUT request updates the object, while POST is reserved to other undefined actions. The renew loan service might look like POST /items/1234/loans/5678?operation=renew.

Again, API providers should make their decisions known in these cases so that API consumers can adapt accordingly.

### REST Error Handling

One of the benefits of using modern standards is that most development environments provide considerable infrastructure which makes coding against such APIs easier. Library vendors should provide standards-compliant APIs so that developers can take advantage of that infrastructure.

One important example is how errors are handled. Library system vendors who create APIs should leverage HTTP status codes to report errors back to client applications. Rather than returning 200 OK with a response that looks like this:

```
{
    “error”: “true”,
    “description”: “invalid input” 
}
```

the API should return an HTTP error. In general, an error code in the 400 range means that the client has provided invalid data and should not try the request again. An error in the 500 range means the server had an issue and the client is free to try the request again.

This methodology allows the client developer to assume the request is successful and rely on the framework to raise a language-appropriate exception if a non-success HTTP error code is received. This is illustrated with the pseudo-code below:

```
 try { 
    Make API call; 
    Handle successful response; 
 } catch { 
   Handle exception; 
}
```

## Security

One of the main concerns that organizations have in moving to cloud-based systems is that of security. This concern carries over into access to SaaS systems via APIs. APIs provide access to sensitive data and must be secured as much as, if not more than, access by a standard user account.

### HTTPS

API calls should be restricted to HTTPS only. Any attempt to access an API via non-secure HTTP should be rejected or redirected. An HTTPS only policy ensures the security of authentication credentials and sensitive data. The power of modern hardware reduces the performance impact HTTPS encryption requires.

### Authentication

In some instances, API calls may be intended to be openly available. In most cases, however, some sort of authentication is required. There are several strategies for authenticating API requests.

- *Basic authentication*: a style of HTTP authentication where a username and password are base-64 encoded and placed in an HTTP header
- *OAuth*[<sup>8</sup>](https://journal.code4lib.org/articles/#sdfootnote8sym): an authentication standard which is best for supplying delegated access from one application to another; for example, allowing a custom application to post to *Facebook* on a user’s behalf
- *API Keys*: a long random string which identifies the caller of an API request and can include authorization information

Cloud applications are multi-tenant, which means that several institutions occupy the same server resources and application instance. Therefore, authentication may also identify the institution to which the API request is intended.

We have adopted the use of API keys, as many experts[<sup>9</sup>](https://journal.code4lib.org/articles/#sdfootnote9sym) have recommended. This method allows API requests to the server to authenticate the request and route it to its intended institution. It is trivial for a developer to implement API keys for authentication, as they can be sent via an HTTP parameter or header. They are also sufficiently long and random as to not be vulnerable to a brute force attack. Finally, API keys can easily be revoked should the need arise.

### Third Party Access

Many libraries today no longer have the resources in-house to embark on large development projects. For those institutions, outsourcing development work is an increasingly attractive option. Using third parties to do development brings with it security challenges. Best practices for third party access to APIs include limited access to required APIs only, auditing API requests, the ability to control access to test and real data, and the ability to revoke access when needed. Cloud library management system vendors should take these requirements into consideration when designing API platform security.

The API key authentication methodology described above works well for third party access. API keys can be uniquely assigned to a particular application or contractor, can limit access to the desired APIs, and can be configured for access to the desired environment.

### Attack Mitigation

The move to the cloud allows vendors to deploy edge devices that enable mitigation against common web attacks. Such gateways protect customers’ data from intentional or accidental attacks via API calls. These gateways inspect each request and evaluate them against known attack patterns. Suspicious requests are rejected before they even reach the application servers and the customers’ data.

Some common web attacks that API gateway devices can protect against include:

- Cross Site Request Forgery (CSRF)
- XML body attacks, such as long text or attributes, long attribute names, and node nesting depth
- Code injections, including SQL Injection, Shell Injection, and XPath injection
- Validating payloads against JSON or XML schema
- Message size limit to prevent a Denial of Service attack
- Cross Site Scripting (XSS)

![Figure 8 - API Gateway](https://journal.code4lib.org/media/issue26/weisman/Figure8.png)

**Figure 8.** API Gateway

## Cloud Compatibility

The cloud brings with it challenges for a software vendor. Taking a system designed to be used locally and trying to adapt it for cloud deployment is a difficult undertaking. Similarly, taking APIs from a locally-installed system and making them available without modification in the cloud is not sufficient. There are API requirements unique to a cloud-based system that must be addressed.

### Multi-tenancy governance

At the heart of any SaaS application is multi-tenancy. In order to achieve economies of scale, vendors host many institutions on the same infrastructure and the same software instance. To ensure that a single institution does not negatively impact other institutions most cloud vendors implement a governance policy. Such policies limit the amount of transactions institutions can do in a defined time frame in accordance with the size of their licensing agreement.

For API platforms, these governance policies require the implementation of two types of limits: throttling and quotas.

*Throttling* ensures that no more than a specified number of API requests for a single institution are processed in a short period of time, per second or per minute. This prevents an institution from monopolizing server resources thereby preventing the requests of other institutions from being processed. Requests that exceed this limit can be queued and processed subsequently.

*Quotas* define the total number of requests that an institution can perform in a longer period of time, generally a day. This ensures that resources are being utilized efficiently and proportionally.

### Self-service

The cloud opens opportunities for efficiency in process too. A well-designed API platform enables institutions to manage their own environment. For example, cloud API systems can provide the ability for a library to perform functions such as creating its own API keys, managing access to its environments, and adding developers to their account. Self-service improves efficiency and reduces TCO of the solution for the library.  
![Figure 9 - Self Service Dashboard](https://journal.code4lib.org/media/issue26/weisman/Figure9.png)

**Figure 9.** Self Service Dashboard

### Latency

Cloud systems are hosted remotely from the library’s network. There will naturally be some additional latency for each API request. It’s important that developers take this into consideration when designing their applications by minimizing the number of calls and data requested from the server. In addition, vendors can help limit the affects of latency by supporting features in their REST API implementation that can help reduce the bandwidth required for larger requests. Such features include HTTP compression[<sup>10</sup>](https://journal.code4lib.org/articles/#sdfootnote10sym) and setting caching policies and headers[<sup>11</sup>](https://journal.code4lib.org/articles/#sdfootnote11sym) that allow clients to cache the retrieved data where appropriate.

## Community

The library technical community has always been strong. The move of library systems to the cloud opens up additional opportunities for that community to work together to share knowledge and leverage the work of others.

### Sharing Code

The explosion of open source projects in recent years provides a strong platform for the sharing of code in library management solutions. Sites such as Github and Sourceforge allow developers to make their code repositories public and to accept fixes and improvements from the community. These advances can shorten the time required to get a resolution for issues and allow interested developers to help move the projects forward with their contributions.

Cloud library system vendors need to leverage these advancements and encourage the use of *open source repositories* for applications and integrations that work against their systems. The opportunity also exists for vendors to make parts of their systems or integration bridges with other systems open source, thereby realizing those same benefits.

In the spirit of openness, vendors should avoid creating walled gardens of code contributions, documentation, forums, etc. Wherever possible these communities should be openly available avoid recreating the functionality of community-accepted repository solutions.

### Sharing Experiences

Developers today work with their code open in one window and Google in another. The Internet is filled with blogs, Q & A sites, and other resources that allow programmers to search for the advice of others who have had the same problem. As library system developers, we have a responsibility to contribute to that huge knowledge base to help others who will encounter the same issues we face.

Library platform vendors can provide a platform for the community to share success stories, integration recipes, tips and tricks, code samples, and other content that will benefit the community. A *blog* is one popular way this can be accommodated. Vendors can contribute blog entries themselves, but the blog should be open so that others can contribute as well. Contributions should be encouraged, curated, and openly discoverable by search engine queries.

### Sharing Solutions

When all else fails, developers need a way to ask questions. Popular question and answer sites such as Stackoverflow provide a great opportunity for programmers to get help when trouble strikes. Often sections of such sites are created organically for popular development languages, environments, and frameworks.

Library system vendors can also offer a *forum* for those who develop on their systems. Vendor staff should monitor the forum and answer questions where appropriate. Ideally community members will also participate in forum discussions and help colleagues with their challenges.

## Advanced Features

The move to the cloud provides an opportunity for vendors to add additional features for those who develop against their systems that local topologies made impractical or impossible.

### Analytics

One major feature the cloud enables is analytics. Since all API requests are routed through the cloud, vendors can offer developers reports that show the number of API requests, reported per application. That allows developers to monitor the usage of their applications against any quotas. Reports can also show latency data, which allows developers to understand how long each request takes and monitor their user experience.  
![Figure 10 - Analytics Report of API Requests](https://journal.code4lib.org/media/issue26/weisman/Figure10.png)

**Figure 10.** Analytics Report of API Requests

## Conclusion

The general IT trend of moving to the cloud brings with it new opportunities and challenges, and library systems are no different. In this article, we’ve discussed the benefits to developers that this new era brings, including improved developer experience, more transparency and analytics, lower maintenance cost for applications, and opportunities for social coding and sharing. For vendors, there are challenges, but those who position themselves well in this new world can leverage technology to offer a better experience to their developers.

[3](https://journal.code4lib.org/articles/#sdfootnote3anc)<sup></sup> Web Application Description Language, the WSDL of REST APIs.
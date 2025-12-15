---
title: "Opening the Door: A First Look at the OCLC WorldCat Metadata API"
source: "https://journal.code4lib.org/articles/9863"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-07-21
created: 2025-01-10
description: "Libraries have long relied on OCLC’s WorldCat database as a way to cooperatively share bibliographic data and declare library holdings to support interlibrary loan services. As curator, OCLC has traditionally mediated all interactions with the WorldCat database through their various cataloging clients to control access to the information. As more and more libraries look for [...]"
tags:
  - "clippings"
---
# Opening the Door: A First Look at the OCLC WorldCat Metadata API
Terry Reese

Libraries have long relied on OCLC’s WorldCat database as a way to cooperatively share bibliographic data and declare library holdings to support interlibrary loan services. As curator, OCLC has traditionally mediated all interactions with the WorldCat database through their various cataloging clients to control access to the information. As more and more libraries look for new ways to interact with their data and streamline metadata operations and workflows, these clients have become bottlenecks and an inhibitor of library innovation. To address some of these concerns, in early 2013 OCLC announced the release of a set of application programming interfaces (APIs) supporting read and write access to the WorldCat database. These APIs offer libraries their first opportunity to develop new services and workflows that directly interact with the WorldCat database, and provide opportunities for catalogers to begin redefining how they work with OCLC and their data.

## Introduction

The past decade has represented a kind of “gold rush” for libraries and library developers as the need for data interoperability and access has been pushed to the forefront. As libraries and librarians work with researchers interested in doing large scale data mining, or find themselves pursuing their own research agendas around comprehensive discovery or service integration, software and services providing robust mechanisms for accessing and interacting with data have very quickly become the norm. And it is out of this environment that libraries are finding vendors and developers seeking to become partners in creating the scaffolding necessary to support future innovation and research within libraries\[[1](https://journal.code4lib.org/articles/#note1)\]\[[2](https://journal.code4lib.org/articles/#note2)\], in addition to developing a number of conceptual services that begin to probe some of the ways in which library data can be remixed and repurposed for other uses. However, while many in libraries have benefited from the growing expectations around data access and availability, integrated library system (ILS) and MARC cataloging and metadata communities have largely been left out.

Unlike many other content services, the library metadata community largely relies on a single data service to provide cooperative bibliographic cataloging and cooperatively manage an organization’s holdings information to support global resource sharing – OCLC’s WorldCat. And while OCLC has developed a number of tools and services built around WorldCat\[[3](https://journal.code4lib.org/articles/#note3)\]\[[4](https://journal.code4lib.org/articles/#note4)\]\[[5](https://journal.code4lib.org/articles/#note5)\], the ability to create, read, and update bibliographic and holdings data within WorldCat has remained tightly controlled and coupled to the client software OCLC has provided to the cataloging community. The result has been a lack of innovation and integration of workflows, as the need to work with WorldCat hamstrung those efforts.

However, in early 2013, OCLC surprised the library community by releasing documentation to the WorldCat Metadata API\[[6](https://journal.code4lib.org/articles/#note6)\]. The API provided, for the first time, the ability to read, create, and update bibliographic and holdings data within the WorldCat database. For catalogers and the metadata community, it represented an opportunity to rethink how they interact with WorldCat and an opportunity to rethink aging workflows and processes. Working with members of the cataloging community, I released a number of libraries and components developed as a part of a joint research project investigating how MarcEdit could be used to provide direct integration with WorldCat to simplify holdings management workflows\[[7](https://journal.code4lib.org/articles/#note7)\] giving me an opportunity to closely examine where the strengths and weaknesses are of the current Metadata API service. This paper will look at the current WorldCat Metadata API; its capabilities, limitations, and many quirks.

## Getting Started

The WorldCat Metadata API is one part of a much larger portfolio of resources currently being made available as part of OCLC’s Developer Network\[[8](https://journal.code4lib.org/articles/#note8)\]. The Developer’s Network is OCLC’s portal for information and documentation about OCLC’s production and experimental development services. This includes access to information regarding APIs, as well as customized services like VIAF\[[9](https://journal.code4lib.org/articles/#note9)\], Classify\[[10](https://journal.code4lib.org/articles/#note10)\], and services specific to OCLC’s Worldshare Management Services. In addition to information about services and APIs provided by OCLC, the Developer’s Network portal also provides access to an API Explorer\[[11](https://journal.code4lib.org/articles/#note11)\], a web application that allows potential developers an opportunity to demo specific APIs as a way to supplement the available documentation.

Before getting started, a user interested in working with the Metadata API will need to request a Web Services Key. Keys are assigned to specific users, are associated with one or more specific API services, and are requested through the portal \[[https://platform.worldcat.org/wskey](https://platform.worldcat.org/wskey)\]. The Metadata API is somewhat unique, however, in that the service key only provides access to the API and authenticates the requests made against the server. To obtain access to the Metadata API, one needs to have two accounts; 1) a WorldCat.org account to request the key, and 2) a WorldShare user account with Cataloging/Metadata permissions which are generally managed at the local level. Without the correct cataloging permissions, users with valid service keys will be able to make requests against the server, but the requested actions will not be processed due to insufficient permissions to work with the WorldCat Database itself.

## Authentication

For long-time OCLC users who may have utilized previous API offerings, the Metadata API utilizes a very different authentication approach. OCLC’s previous API services, like the WorldCat Search API, used a key that was appended to the URL as part of the service request. For example, a request for *Hamlet* would look like:

http://www.worldcat.org/webservices/catalog/search/sru?query=srw.ti%3D%22hamlet%22&wskey=\[mykey\]

In the case of many of OCLC’s older services, the key was provided as part of the request. However, for the Metadata API, OCLC has introduced a new authentication strategy. Rather than providing the key as part of the request, the Metadata API requires authentication to utilize an HMAC signature embedded within the Authentication header of the request. HMAC, or hash-based message authentication code\[[12](https://journal.code4lib.org/articles/#note12)\], is an encrypted signature used as a mechanism to authenticate the data request made against the service. OCLC’s implementation, based on OAuth 1.0 specification\[[13](https://journal.code4lib.org/articles/#note13)\], requires a very specific set of arguments, generated in the correct order, hashed utilizing an SHA256 encryption algorithm and then encoded in base64 when embedded into the Authorization Request header.

To generate the HMAC signature, the following data must be present within the request:

1. The wskey
2. A Unix POSIX timestamp calculated at the time of the request
3. A nonce value, or a random set of numbers, unique for the specific request
4. The request entity-body hash. At this point, this is always a blank line.
5. The HTTP request method. This value must be in uppercase.
6. The string: www.oclc.org
7. The string: 443
8. The string: /wskey
9. The query component of the request URI.
10. An empty line

   
Every request made against the Metadata API service must generate a new HMAC signature for the specific request, otherwise the request will fail. Each request made against the Metadata API service must have a unique nonce value and a Unix POSIX timestamp that corresponds to one and only one request, or the request will fail. Finally, each line of the signature must include a new line (\\n) or the request will fail.

Once the signature is calculated, that is provided as one value of the authorization header. The full header includes the following hash:

1. Schema URL
2. clientId
3. timestamp
4. nonce
5. signature
6. principalID
7. principleIDNS

   
So, assuming the parameters:

1. wskey: \[your wskey\]
2. Timestamp: 1399498027
3. Nonce value: 898581797066788588888373908665858579788865896874726973898675
4. Method: GET
5. Query String: ?holdingCode=ORE&classificationScheme=LibraryOfCongress&holdingLibraryCode=MAIN
6. principleID: \[your id\]
7. principleIDNS: \[your value\]
8. Secret Key: \[your secret key\]

   
The process used to generate the request looks like the following:

##### Prehashed key:

1. \[your wskey\]
2. 1399498027
3. 898581797066788588888373908665858579788865896874726973898675
4. GET
5. www.oclc.org
6. 443
7. /wskey
8. holdingCode=ORE&classificationScheme=LibraryOfCongress&holdingLibraryCode=MAIN

   
This pre-hashed key would then be hashed via an SHA256 algorithm utilizing your secret key and the pre-hashed values as a string. This is the generated signature. The signature would then be embedded into the authorization header, which would look like the following:

http://www.worldcat.org/wskey/v2/hmac/v1 clientId=”\[your wskey\]”, timestamp=”1399498027″, nonce=”898581797066788588888373908665858579788865896874726973898675″, signature=”YUUBAg9gsjL3diZliom2G3M48sx3en5VbCZbxJRA+lQ=”, principalID=”\[your principleid\]”, principalIDNS=”\[your principleidns\]”

Fortunately, code exists to simplify OCLC’s HMAC authentication process. For use in MarcEdit, a public domain library, found at: [https://github.com/reeset/oclc\_api](https://github.com/reeset/oclc_api) provides a C# implementation of OCLC’s API services, encapsulating authentication. Likewise, OCLC has released a ruby gem at: [https://github.com/OCLC-Developer-Network/oclc-auth-ruby](https://github.com/OCLC-Developer-Network/oclc-auth-ruby) that provides a ruby wrapper around OCLC’s authentication and a code library available at: [https://github.com/reeset/wc\_metadata\_api](https://github.com/reeset/wc_metadata_api), provides a ruby wrapper around the various metadata API functions. While I will not provide code examples in languages other than ruby and C#, OCLC has also released authentication code libraries for PHP ([https://github.com/OCLC-Developer-Network/oclc-auth-php](https://github.com/OCLC-Developer-Network/oclc-auth-php)) and Python ([https://github.com/OCLC-Developer-Network/oclc-auth-python](https://github.com/OCLC-Developer-Network/oclc-auth-python)).

##### C#: Authenticating

| 1  2  3  4  5  6  7  8  9  10 | `string sRecord = ``""``;`  `string principleID = ``"[your id]"``;`  `string principlelDNS = ``"[your dns]"``;`  `string wskey = ``"[your key]"``;`  `string secret = ``"[your secret]"``;`  `string holdingsid = ``"OCPSB"``;`  `string instSymbol = ``"OCPSB"``;`  `string schema = ``"LibraryOfCongress"``;`  `oclc_api.oclc_api_metadata obj_om = ``new` `oclc_api.oclc_api_metadata(wskey, secret, principleID, principlelDNS);` |
| --- | --- |

##### Ruby: Authenticating

## WorldCat Metadata API Functionality

The WorldCat Metadata API provides the ability to create, edit, and sometimes delete very specific classes of data stored within the WorldCat database. The API makes logical use of the standard HTTP methods (PUT, GET, DELETE, and POST actions) to define specific actions performed by the API calls and utilize a specific base URI corresponding to each functional group. Additionally, the API utilizes HTTP Status Codes to indicate the outcome of each request call.

Functionality can be broken into four primary areas: actions against master bibliographic records, actions against local bibliographic data records, actions against institutional holdings, and organizational information. As noted earlier, the ability to perform each of these specific actions requires users not only to have the keys necessary to authenticate against the OCLC WorldCat Metadata API, but the username to which the API key is attached must also have the necessary cataloging permissions within the WorldCat database to make the requested changes. A description of each functionality group can be found below.

### Working with master bibliographic records

The Metadata API provides the ability to create, read, and update master bibliographic records in the WorldCat database. Missing from the feature set is the ability to delete bibliographic records– an option generally reserved for OCLC’s quality control staff. In looking at the API documentation, one of the most impressive parts is the wide range of request and response formats that the API supports\[[14](https://journal.code4lib.org/articles/#note14)\]. The API has the ability to provide various flavors of XML and JSON formatted results. Request formats are more controlled, with the API expecting data submitted into the API to be in either MARCXML or OCLC’s CDF (Common Data Format) serialization in either XML or JSON format.

#### Read Records:

BaseURL: [https://worldcat.org/bib/data](https://worldcat.org/bib/data)  
Request type: application/vnd.oclc.marc21+xml

##### C#: Read Record #823520553

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `string sRecord = ``""``;`  `string oclcnumber = ``"823520553"``;`  `string principleID = ``"[your id]"``;`  `string principlelDNS = ``"[your dns]"``;`  `string wskey = ``"[your key]"``;`  `string secret = ``"[your secret]"``;`  `string holdingsid = ``"OCPSB"``;`  `string instSymbol = ``"OCPSB"``;`  `string schema = ``"LibraryOfCongress"``;`  `oclc_api.oclc_api_metadata obj_om = ``new` `oclc_api.oclc_api_metadata(wskey, secret, principleID, principlelDNS);`  `obj_om.InstSymbol = instSymbol;`  `bool` `results = obj_om.WorldCatGetRecord(schema, holdingsid, instSymbol, oclcnumber, out sRecord);`  `System.Windows.Forms.MessageBox.Show(sRecord);` |
| --- | --- |

##### Ruby: Read Record #823520553

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `require ``'rubygems'`  `require ``'wc_metadata_api'`  `key = ``'[your key]'`  `secret = ``'[your secret]'`  `principalid = ``'[your principal_id]'`  `principaldns = ``'[your principal_idns]'`  `schema = ``'LibraryOfCongress'`  `holdingLibraryCode=``'[your holding code]'`  `instSymbol = ``'[your oclc symbol]'`  `client = ``WC_METADATA_API``::Client.``new``(``:wskey` `=&gt; key, ``:secret` `=&gt; secret, ``:principalID` `=&gt; principalid, ``:principalDNS` `=&gt; principaldns, ``:debug` `=&gt;``false``)`  `response = client.WorldCatGetBibRecord(``:oclcNumber` `=&gt; ``'823520553'``, ``:holdingLibraryCode` `=&gt; holdingLibraryCode, ``:schema` `=&gt; schema, ``:instSymbol` `=&gt; instSymbol)`  `puts response` |
| --- | --- |

##### MARCXML Response Format:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52 | `<?``xml` `version``=``"1.0"` `encoding``=``"UTF-8"``?>`  `<``content` `type``=``"application/xml"``>`  `<``leader``>00000cam a2200000Ia 4500</``leader``>`  `<``controlfield` `tag``=``"001"``>ocn823520553</``controlfield``>`  `<``controlfield` `tag``=``"003"``>OCoLC</``controlfield``>`  `<``controlfield` `tag``=``"005"``>20140207112204.5</``controlfield``>`  `<``controlfield` `tag``=``"008"``>120827s2012    nyua          000 0 eng d</``controlfield``>`  `<``datafield` `tag``=``"040"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>OCPSB</``subfield``>`  `<``subfield` `code``=``"c"``>OCPSB</``subfield``>`  `<``subfield` `code``=``"d"``>OCWMS</``subfield``>`  `<``subfield` `code``=``"d"``>OCPSB</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"035"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>(OCoLC)823520553</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"049"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>OCPSB</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"100"` `ind1``=``"0"` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>OCLC RecordBuilder</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"245"` `ind1``=``"0"` `ind2``=``"0"``>`  `<``subfield` `code``=``"a"``>Record Builder Added This Test Record On 03/04/13 08:36:54</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"500"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>Field Added by TR.</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"500"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>For Developers House</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"500"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>TEST RECORD -- DO NOT USE</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"500"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>Note field added by TR 10/18/2013</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"500"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>Second Note field added by TR 10/19/2013</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"500"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>Third Note Field added by TR 12/6/2013.</``subfield``>`  `</``datafield``>`  `</``record``>`  `</``response``>`  `</``content``>`  `</``entry``>` |
| --- | --- |

#### Create Record:

##### C#: Create New Master Record

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34 | `string principleID = ``"[your principleID]"``;`  `string principlelDNS = ``"[your principleDNS]"``;`  `string wskey = ``"[your key]"``;`  `string secret = ``"[your secret]"``;`  `string holdingsid = ``"MAIN"``; `  `string instSymbol = ``"OCPSB"``;`  `string schema = ``"LibraryOfCongress"``;`  `oclc_api.oclc_api_metadata obj_om = ``new` `oclc_api.oclc_api_metadata(wskey, secret, principleID, principlelDNS);`  `obj_om.InstSymbol = instSymbol;`  `string sRecord = ``"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"` `+`  `"<leader>00000nam a2200000Ia 4500</leader>\n"` `+`  `"<controlfield tag=\"008\">120827s2012    nyua          000 0 eng d</controlfield>\n"` `+`  `"<datafield tag=\"040\" ind1=\" \" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">OCPSB</subfield>\n"` `+`  `"<subfield code=\"c\">OCPSB</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"100\" ind1=\"0\" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">Reese, Terry</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"245\" ind1=\"0\" ind2=\"0\">\n"` `+`  `"<subfield code=\"a\">Record Builder Added This Test Record On 05/08/2014</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"500\" ind1=\" \" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">Original Record has one field.</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"</record>\n"``;`  `bool` `results = obj_om.WorldCatAddRecord(sRecord, instSymbol, holdingsid, schema, holdingsid);`  `System.Windows.Forms.MessageBox.Show(obj_om.LastResponseCode);` |
| --- | --- |

##### Ruby: Create New Master Record

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38 | `require ``'rubygems'`  `require ``'wc_metadata_api'`  `key = ``'[your key]'`  `secret = ``'[your secret]'`  `principalid = ``'[your principal_id]'`  `principaldns = ``'[your principal_idns]'`  `schema = ``'LibraryOfCongress'`  `holdingLibraryCode=``'[your holding code]'`  `instSymbol = ``'[your oclc symbol]'`  `rec =  ``"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"` `+`  `"<leader>00000nam a2200000Ia 4500</leader>\n"` `+`  `"<controlfield tag=\"008\">120827s2012    nyua          000 0 eng d</controlfield>\n"` `+`  `"<datafield tag=\"040\" ind1=\" \" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">OCPSB</subfield>\n"` `+`  `"<subfield code=\"c\">OCPSB</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"100\" ind1=\"0\" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">Reese, Terry</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"245\" ind1=\"0\" ind2=\"0\">\n"` `+`  `"<subfield code=\"a\">Record Builder Added This Test Record On 05/14/2014</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"500\" ind1=\" \" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">Original Record has one field.</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"</record>\n"`  `client = ``WC_METADATA_API``::Client.``new``(``:wskey` `=> key, ``:secret` `=> secret, ``:principalID` `=> principalid, ``:principalDNS` `=> principaldns, ``:debug` `=>``false``)`  `response = client.WorldCatAddBibRecord(``:holdingLibraryCode` `=> holdingLibraryCode, ``:schema` `=> schema, ``:instSymbol` `=> instSymbol, ``:xRecord` `=> rec)`  `puts client.LastResponseCode.body` |
| --- | --- |

##### Response Message:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38 | `<?``xml` `version``=``"1.0"` `encoding``=``"UTF-8"``?>`  `<``content` `type``=``"application/xml"``>`  `<``leader``>00000nam a2200000Ia 4500</``leader``>`  `<``controlfield` `tag``=``"001"``>ocn879376100</``controlfield``>`  `<``controlfield` `tag``=``"003"``>OCoLC</``controlfield``>`  `<``controlfield` `tag``=``"005"``>20140508111006.3</``controlfield``>`  `<``controlfield` `tag``=``"008"``>120827s2012    nyua          000 0 eng d</``controlfield``>`  `<``datafield` `tag``=``"040"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>OCPSB</``subfield``>`  `<``subfield` `code``=``"c"``>OCPSB</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"035"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>(OCoLC)879376100</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"049"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>MAIN</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"100"` `ind1``=``"0"` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>Reese, Terry</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"245"` `ind1``=``"0"` `ind2``=``"0"``>`  `<``subfield` `code``=``"a"``>Record Builder Added This Test Record On 05/08/2014 RecordBuilder Add Original Test: 2014-05-08 11:10:06.093</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"500"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>Original Record has one field.</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"994"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>10</``subfield``>`  `</``datafield``>`  `</``record``>`  `</``response``>`  `</``content``>`  `</``entry``>` |
| --- | --- |

   
When successful, the <id> and <link> will point to the new OCLC record that has been created. When an error occurs, those values will be replaced by: <oclc:error>; providing information regarding the specific errors encountered while performing the operation. For example:

| 1  2  3  4 | `<``oclc:error``>`  `<``oclc:code` `type``=``"application"``>CAT-OTHER</``oclc:code``>`  `<``oclc:message``>New record required</``oclc:message``>`  `</``oclc:error``>` |
| --- | --- |

#### Updating Records:

##### C#: Updating Master Bib Record #879376100

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48 | `string principleID = ``"[your principleID]"``;`  `string principlelDNS = ``"[your principleDNS]"``;`  `string wskey = ``"[your key]"``;`  `string secret = ``"[your secret]"``;`  `string instSymbol = ``"OCPSB"``;`  `string holdingsid = ``"MAIN"``;`  `string schema = ``"LibraryOfCongress"``;`  `oclc_api.oclc_api_metadata obj_om = ``new` `oclc_api.oclc_api_metadata(wskey, secret, principleID, principlelDNS);`  `obj_om.InstSymbol = instSymbol;`  `string sRecord = ``"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"` `+`  `"<leader>00551cam a2200169Ia 4500</leader>\n"` `+ `  `"<controlfield tag=\"001\">879376100</controlfield>\n"` `+ `  `"<controlfield tag=\"003\">OCoLC</controlfield>\n"` `+`  `"<controlfield tag=\"005\">20140508114136.1</controlfield>\n"` `+ `  `"<controlfield tag=\"008\">120827s2012    nyua          000 0 eng d</controlfield>\n"` `+ `  `"<datafield tag=\"040\" ind1=\" \" ind2=\" \">\n"` `+ `  `"<subfield code=\"a\">OCPSB</subfield>\n"` `+ `  `"<subfield code=\"c\">OCPSB</subfield>\n"` `+ `  `"</datafield>\n"` `+ `  `"<datafield tag=\"035\" ind1=\" \" ind2=\" \">\n"` `+ `  `"<subfield code=\"a\">(OCoLC)879376100</subfield>\n"` `+ `  `"</datafield>\n"` `+ `  `"<datafield tag=\"049\" ind1=\" \" ind2=\" \">\n"`  `+`  `"<subfield code=\"a\">MAIN</subfield>\n"` `+ `  `"</datafield>\n"` `+ `  `"<datafield tag=\"100\" ind1=\"0\" ind2=\" \">\n"` `+ `  `"<subfield code=\"a\">Reese, Terry</subfield>\n"` `+ `  `"</datafield>\n"` `+ `  `"<datafield tag=\"245\" ind1=\"0\" ind2=\"0\">\n"` `+ `  `"<subfield code=\"a\">Record Builder Added This Test Record On 05/08/2014 RecordBuilder Add Original Test: 2014-05-08 11:10:06.093</subfield>\n"` `+ `  `"</datafield>\n"` `+ `  `"<datafield tag=\"500\" ind1=\" \" ind2=\" \">\n"` `+ `  `"<subfield code=\"a\">Original Record has one field.</subfield>\n"` `+ `  `"</datafield>\n"` `+`  `"<datafield tag=\"500\" ind1=\" \" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">Updated on 5/8/2014 at 11:29 AM EST.  Field Added.</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"500\" ind1=\" \" ind2=\" \">\n"` `+ `  `"<subfield code=\"a\">Updated on 5/8/2014 @ 11:53 AM EST.</subfield>\n"` `+ `  `"</datafield>\n"` `+ `  `"</record>\n"``;`  `bool` `results = obj_om.WorldCatUpdateRecord(sRecord, instSymbol, schema, holdingsid);`  `System.Windows.Forms.MessageBox.Show(obj_om.LastResponseCode);` |
| --- | --- |

##### Ruby Example:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45 | `require ``'rubygems'`  `require ``'wc_metadata_api'`  `key = ``'[your key]'`  `secret = ``'[your secret]'`  `principalid = ``'[your principal_id]'`  `principaldns = ``'[your principal_idns]'`  `schema = ``'LibraryOfCongress'`  `holdingLibraryCode=``'[your holding code]'`  `instSymbol = ``'[your oclc symbol]'`  `rec =  ``"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"` `+`  `"<leader>00000nam a2200000Ia 4500</leader>\n"` `+`  `"<controlfield tag=\"001\">879649505</controlfield>\n"` `+`  `"<controlfield tag=\"003\">OCoLC</controlfield>\n"` `+`  `"<controlfield tag=\"005\">20140514152217.2</controlfield>\n"` `+`  `"<controlfield tag=\"008\">120827s2012    nyua          000 0 eng d</controlfield>\n"` `+`  `"<datafield tag=\"040\" ind1=\" \" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">OCPSB</subfield>\n"` `+`  `"<subfield code=\"c\">OCPSB</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"100\" ind1=\"0\" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">Reese, Terry</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"245\" ind1=\"0\" ind2=\"0\">\n"` `+`  `"<subfield code=\"a\">Record Builder Added This Test Record On 05/14/2014</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"500\" ind1=\" \" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">Original Record has one field.</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"<datafield tag=\"500\" ind1=\" \" ind2=\" \">\n"` `+`  `"<subfield code=\"a\">Second field added</subfield>\n"` `+`  `"</datafield>\n"` `+`  `"</record>\n"`  `client = ``WC_METADATA_API``::Client.``new``(``:wskey` `=> key, ``:secret` `=> secret, ``:principalID` `=> principalid, ``:principalDNS` `=> principaldns, ``:debug` `=>``false``)`  `response = client.WorldCatUpdateBibRecord(``:holdingLibraryCode` `=> holdingLibraryCode, ``:schema` `=> schema, ``:instSymbol` `=> instSymbol, ``:xRecord` `=> rec)`  `puts client.LastResponseCode.body` |
| --- | --- |

   
The response format when updating records is identical to the response format received when creating new records. The primary difference between the update record and new record functions is the requirements around certain data elements within the bibliographic record being submitted. For example, when updating records, the OCLC control number must be present, without prefixes, in the 001 field. Likewise, the last transaction date, found in the 005, must be identical to the data found in WorldCat. These two values are specific to record updating and must be present for any request to begin the update process.

It’s also worth noting that records submitted via the Metadata API are validated using OCLC’s Validation service. Unfortunately, this service is not provided as part of the Metadata API as published, so when utilizing the API, there is no method to determine, prior to submitting data to OCLC, if the provided metadata is valid. And in the case of the API, validation occurs both in respect to the format of the data being submitted (is it well-formed?), as well as in relationship to the record’s adherence to MARC21 rules.

## Working with local bibliographic data records

Local bibliographic data records provide a way for organizations that use WorldCat for cataloging to record locally-maintained information related to a master bibliographic record. Local bibliographic data records are only visible to the particular institution with which they are associated. Local bibliographic data records are somewhat different from master bibliographic records in that they have their own OCLC record numbers, but they are linked to a master bibliographic number via MARC field 004.

Local bibliographic data records are used for a number of purposes within the WorldCat database, though the most common use is by libraries utilizing OCLC’s WorldShare Platform. Local bibliographic data records are used to store local notes relating to access, processing, etc. as well as local access points, like organization-specific URLs for access. While OCLC has set forth a set of best practices around local bibliographic data record usage, practical use of these records has demonstrated that nearly any data, including local subjects, added main entries, notes, etc., can be stored within a local bibliographic record.

OCLC’s Metadata API provides the ability to interact with an institution’s local bibliographic data record. Like the functions that support the creation, reading, and editing of master bibliographic data, API users can create, read, and edit local bibliographic data records as well. The one distinct difference is that the API also provides users the ability to delete local bibliographic data records.

When working with local bibliographic data records via the API, the response and request formats are identical to the functions used when editing master bibliographic data. The real differences between the two functional groups are around the base URL of the service and the type of data being sent through the service. As noted above, local bibliographic data records have some distinct differences from master bibliographic records because these records are linked to an existing bibliographic record. Because of this, these records require three specific data fields:

1. 004 – which links to an existing master OCLC bibliographic record
2. 935 – a locally generated system number (can be a timestamp, but must be unique)
3. 940 – field that identifies the OCLC institution generating the record

For users generating new local bibliographic data records, the following template would always be used:

| 1  2  3  4  5  6  7  8  9  10  11 | `<?``xml` `version``=``"1.0"` `encoding``=``"UTF-8"` `?>`  `<``leader``>00000n   a2200000   4500</``leader``>`  `<``controlfield` `tag``=``"004"``>[master OCLC number]</``controlfield``>`  `<``datafield` `tag``=``"935"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>[your local generated identifier – can be a timestamp]</``subfield``>`  `</``datafield``>`  `<``datafield` `tag``=``"940"` `ind1``=``" "` `ind2``=``" "``>`  `<``subfield` `code``=``"a"``>[your OCLC symbol]</``subfield``>`  `</``datafield``>`  `</``record``>` |
| --- | --- |

Using this template, users can include a wide range of local information for submission back into the WorldCat database. And like the API functions that interact with the master bibliographic data record, a local bibliographic data record is passed between the client and OCLC utilizing either MARCXML or OCLC’s CDF in XML or JSON format. Likewise, when editing an existing local bibliographic data record, the same caveats relating to the 005, the inclusion of the 001, and data validation that applied when working with master bibliographic data records, apply to local bibliographic data records as well.

#### Local Bibliographic Data Function List:

C# Headers:

- Add a local bibliographic record:  
**bool** **WorldCatAddLocalBibRecord**(**string** *xRecord***, string** *inst***, string** *schema***, string** *holdingCode*)
- Delete a local bibliographic record:  
**bool** **WorldCatDeleteLocalBibRecord**(**string** *xRecord***, string** *schema***, string** *holdingCode***, string** *instSymbol*)
- Read a local bibliographic record:  
**bool** **WorldCatReadLocalBibRecord**(**string** *schema***, string** *holdingCode***, string** *oclcNumber***,** out **string** *sRecord*)
- Update a local bibliographic record:  
**bool** **WorldCatUpdateLocalBibRecord**(**string** *xRecord***, string** *inst***, string** *schema***, string** *holdingCode*)

Ruby Headers:

- WC\_METADATA\_API::CLIENT.WorldCatAddLocalBibRecord(:holdingLibraryCode, :schema, :instSymbol, :xRecord)
- WC\_METADATA\_API::CLIENT.WorldCatDeleteLocalBibRecord(:holdingLibraryCode, :schema, :instSymbol, :xRecord)
- WC\_METADATA\_API::CLIENT.WorldCatGetLocalBibRecord(:oclcNumber, :holdingLibraryCode, :schema, :instSymbol)
- WC\_METADATA\_API::CLIENT.WorldCatUpdateLocalBibRecord(:holdingLibraryCode, :schema, :instSymbol, :xRecord)

## Working with institutional holdings data

WorldCat’s central role in facilitating interlibrary loan between member libraries highlights the importance that accurate holdings information plays for libraries. The challenge for libraries has always been that library collections are not static entities. Libraries regularly need to add and withdraw large batches of items, and the processes necessary for maintaining accurate holdings information during these large processing events have never been well supported by the tools provided by OCLC. For many libraries, large withdrawal processes require significant effort to manually remove holdings from individual bibliographic records, and holdings for e-versions of content may never be attached within OCLC simply because the holdings for these materials are characteristically ephemeral. However, issues related to holdings management only multiply when dealing with non-monographic materials and the need to publish patterns and holdings information regarding specific issues and volumes, materials currently handled through the creation of local holdings records.

OCLC’s Metadata API provides limited support for holdings data manipulation, restricting holdings management to institutional holdings attached to a bibliographic record. At this time, the ability to manage local holding records (LHRs) is not supported as part of this service. And yet, even with its limited functionality, the Metadata API opens up the possibility of rethinking workflows around large weeding projects, as the API supports the ability to unset large numbers of institutional holdings attached to bibliographic records.

The Metadata API supports two actions: 1) add/set holdings on a bibliographic record and 2) delete/unset holdings on a bibliographic record. The ability to query a record for holdings status is not a part of the current API functionality.

#### Add/Set Holdings

##### C# Example on OCLC record #: 823520553

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `string oclcnumber = ``"823520553"``;`  `string principleID = ``"[your principleID]"``;`  `string principlelDNS = ``"[your princpleDNS]"``;`  `string wskey = ``"[your key]"``;`  `string secret = ``"[your secret]"``;`  `string instSymbol = ``"[your OCLC symbol]"``;`  `string holdingsid = ``"[your holdings code]"``;`  `string schema = ``"LibraryOfCongress"``;`  `oclc_api.oclc_api_metadata obj_om = ``new` `oclc_api.oclc_api_metadata(wskey, secret, principleID, principlelDNS);`  `obj_om.InstSymbol = instSymbol;`  `bool` `results = obj_om.WorldCatAddHolding(schema, holdingsid, oclcnumber);`  `System.Windows.Forms.MessageBox.Show(obj_om.Debug_Info);` |
| --- | --- |

##### Ruby Example on OCLC record #: 823520553

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `require ``'rubygems'`  `require ``'wc_metadata_api'`  `key = ``'[your key]'`  `secret = ``'[your secret]'`  `principalid = ``'[your principal_id]'`  `principaldns = ``'[your principal_idns]'`  `schema = ``'LibraryOfCongress'`  `holdingLibraryCode=``'[your holding code]'`  `instSymbol = ``'[your oclc symbol]'`  `client = ``WC_METADATA_API``::Client.``new``(``:wskey` `=> key, ``:secret` `=> secret, ``:principalID` `=> principalid, ``:principalDNS` `=> principaldns, ``:debug` `=>``false``)`  `response = client.WorldCatAddHoldings(``:instSymbol` `=> instSymbol, ``:holdingLibraryCode` `=> holdingLibraryCode, ``:schema` `=> schema, ``:oclcNumber` `=> ``'823520553'``)`  `puts client.LastResponseCode.body` |
| --- | --- |

#### Delete/Unset Holdings

##### C# Example on OCLC record #: 823520553

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `string oclcnumber = ``"823520553"``;`  `string principleID = ``"[your principleID]"``;`  `string principlelDNS = ``"[your princpleDNS]"``;`  `string wskey = ``"[your key]"``;`  `string secret = ``"[your secret]"``;`  `string instSymbol = ``"[your OCLC symbol]"``;`  `string holdingsid = ``"[your holdings code]"``;`  `string schema = ``"LibraryOfCongress"``;`  `oclc_api.oclc_api_metadata obj_om = ``new` `oclc_api.oclc_api_metadata(wskey, secret, principleID, principlelDNS);`  `obj_om.InstSymbol = instSymbol;`  `bool` `results = obj_om.WorldCatDeleteHolding(schema, holdingsid, oclcnumber);`  `System.Windows.Forms.MessageBox.Show(obj_om.Debug_Info);` |
| --- | --- |

##### Ruby Example on OCLC record #: 823520553

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 | `require ``'rubygems'`  `require ``'wc_metadata_api'`  `key = ``'[your key]'`  `secret = ``'[your secret]'`  `principalid = ``'[your principal_id]'`  `principaldns = ``'[your principal_idns]'`  `schema = ``'LibraryOfCongress'`  `holdingLibraryCode=``'[your holding code]'`  `instSymbol = ``'[your oclc symbol]'`  `client = ``WC_METADATA_API``::Client.``new``(``:wskey` `=> key, ``:secret` `=> secret, ``:principalID` `=> principalid, ``:principalDNS` `=> principaldns, ``:debug` `=>``false``)`  `response = client.WorldCatDeleteHoldings(``:instSymbol` `=> instSymbol, ``:holdingLibraryCode` `=> holdingLibraryCode, ``:schema` `=> schema, ``:oclcNumber` `=> ``'823520553'``)`  `puts client.LastResponseCode.body` |
| --- | --- |

   
When querying the holdings functions, the response format is represented through HTTP status codes. If the operation completes successfully, the operation will return an HTTP Status 200 with no additional information provided. However, if an error occurs, the HTTP Status code will be set to reflect the operation failure, and will be accompanied by an XML package embedding the response code from the server. For example, attempting to set holdings on a bibliographic record where the organization’s holdings are already present will result in a HTTP Status code of 409, and the accompanying error message will be returned in the response body:  
 

| 1  2  3  4  5 | `<?``xml` `version``=``"1.0"` `encoding``=``"UTF-8"` `standalone``=``"yes"``?>`  `<``code` `type``=``"application"``>WS-409</``code``>`  `<``message``>Trying to set hold while holding already exists</``message``>`  `</``error``>` |
| --- | --- |

   
The ability to retrieve an institution’s holdings codes appears to be the first of what I hope will be a wider selection of API functions provided to gather information about a specific user or the organization that a user happens to be attached to, enabling software to simplify many of the configuration challenges around using the API. The institutional holding code is one value that is a part of almost all the Metadata API calls. These are four- letter, alphanumeric codes that represent the physical locations with an organization. Within WorldCat, each code is typically used to identify a location, collection type, or category of materials. Within MARC, this data shows up in the 049, or Local Holdings field ([https://oclc.org/bibformats/en/0xx/049.html](https://oclc.org/bibformats/en/0xx/049.html)). This information is used within WorldCat and WorldCat Local to display where an item is physically stored at a particular institution. Since most catalogers and developers may not know all of an organization’s holding codes, the ability to retrieve these values for use when making other API calls is important. This API provides a single value that returns an XML response encapsulating all of the corresponding holding codes for the institution.

##### C# Example:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `string wskey = ``"[your wskey]"``;`  `string wskey_secret = ``"[your secret key]"``;`  `string principalID = ``"[your principalID]"``;`  `string principalIDNS = ``"[your principalDNS]"``;`  `string keyvalues = ``""``;`  `oclc_api.oclc_api_metadata obj_om = ``new` `oclc_api.oclc_api_metadata();`  `obj_om.WorldCat_Service_URI = oclc_api.oclc_api_metadata.HOLDINGS_CODES_DATA_URI; `  `obj_om.PrincipleID = principalID;`  `obj_om.PrincipleIDNS = principalIDNS;`  `obj_om.Wskey = wskey;`  `obj_om.Secret_Key = wskey_secret;`  `string[] m = obj_om.WorldCatRetrieveHoldingCodes(``"[your oclc symbol]"``);` |
| --- | --- |

##### Ruby Example:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `require ``'rubygems'`  `require ``'wc_metadata_api'`  `key = ``'[your key]'`  `secret = ``'[your secret]'`  `principalid = ``'[your principal_id]'`  `principaldns = ``'[your principal_idns]'`  `schema = ``'LibraryOfCongress'`  `holdingLibraryCode=``'[your holding code]'`  `instSymbol = ``'[your oclc symbol]'`  `client = ``WC_METADATA_API``::Client.``new``(``:wskey` `=> key, ``:secret` `=> secret, ``:principalID` `=> principalid, ``:principalDNS` `=> principaldns, ``:debug` `=>``false``)`  `response = client.WorldCatRetrieveHoldingCodes(``:instSymbol` `=> instSymbol)`  `puts response` |
| --- | --- |

## Gaps in the implementation

OCLC’s implementation of a Metadata API against the WorldCat database has the potential to unlock a wide range of innovations around technical services and metadata processing. At the same time, while the first release of the Metadata API includes a number of useful and interesting features, there are a number of gaps in the service that will limit some of that potential. In working with the Metadata API, I believe that the significant gaps affecting the service can be broken into four broad categories: 1) scalability of the service, 2) service level validation, 3) service testing and sandboxing, and 4) documentation.

### Scalability concerns

After working with Metadata API, it is readily apparent that the service was not developed with batch metadata editing in mind. The APIs interact on a record by record basis, meaning that requests against the API must be made at the individual record level. While developers can, and have, written batch processing applications utilizing these API, the current process requires a great deal of back and forth between OCLC and the client, with each individual record needing to be submitted, validated, and then a response providing information around the success or failure of a particular submission returned back to the client for parsing. In a batch processing environment, this type of interaction costs a great deal of time, and complicates the processing and reporting on the status of a batch upload as validation of records occurs within real time. This means that the client must make a decision either stop the processing of an entire batch on any error, removing any successfully processed items prior to restarting the update, or provide a report at the end that requires manual intervention to isolate just the data that needs further processing.

### Validation concerns

One of the most glaring omissions around the OCLC Metadata API services is around validation. Currently, record validation occurs when metadata is sent through the API to update or create a new record. In an environment where the API is used to edit one record at a time, this type of validation makes sense. However, within a production environment where multiple records may need to be passed through the API services, the inability to pre-validate records prior to submitting bibliographic data through the API artificially complicates the submission and pre-validation process.

Additionally, catalogers familiar with editing records via OCLC’s cataloging tools have the ability to “lock” bibliographic data for editing. Locking records freezes the bibliographic record within WorldCat, allowing the cataloger the ability to edit the record without worrying that the information may be changed by someone else. Users utilizing the Metadata API lack this ability to “lock” metadata records, meaning that run they risk of making substantial changes to sets of records, and then being unable to upload that data back to WorldCat because a record has been changed. These validation issues are significant problems that place huge limits on the usability of the API, as well as raising confidence barriers to users of the API that the changes made via the API will be processed.

Aside from data validation, there remain large gaps around user validation. Presently, OCLC offers no service to validate that a user has a specific set of permissions to perform specific actions within the WorldCat database. This raises interesting challenges, since a user may have all the permissions necessary to utilize the API, but none of the permissions necessary to perform the requested actions within the WorldCat database. Unfortunately, there is no way for a user or application to determine the permissions accessible to a user until the application attempts to perform a specified action and an error is generated.

### Service Testing and Sandboxing

One of the curious choices that OCLC has made in the development and implementation of their API is the lack of a true sandboxed environment for doing code development\[[15](https://journal.code4lib.org/articles/#note15)\]. When making changes or adding records via the Metadata API, these changes happen in real-time, within the production WorldCat database. The practical impact of this is that user testing and development must be done in a carefully controlled environment because depending on the user editing permissions that a particular WorldCat Service Key is attached to, the testing software could have the capacity to make substantial and harmful changes to master records or an institution’s holdings. In my own experience while developing integrations between MarcEdit and OCLC’s Metadata API, I found that the development process needed to be significantly restrained because each new test record that was added, each new local bibliographic record added or edited, would eventually need to be removed from the system. And in the case of new master bibliographic records, those new records could only be removed by OCLC. The practical outcome of this restrained development was that the integration between the two services was much less “baked” than I would have normally preferred, because the usual testing processing where millions of records are processed through new features simply couldn’t be accommodated.

### Documentation

Like many initial projects and services, the lack of documentation associated with the Metadata API raises the learning curve for using the service. While OCLC does provide some brief, high-level documentation around the service, a number of assumptions and required values simply aren’t documented. In many cases, I found it easier to send invalid requests to the services and parse the error messages to determine allowed values, simply because that information didn’t exist in the documentation. Fortunately, this is slowly changing as more time passes since the Metadata API release and as OCLC continues to add information based on feedback that they receive. Likewise, because the Metadata API assumes some level of knowledge about WorldCat’s cataloging rules and validation practices, non-catalogers will likely have a difficult time navigating the unwritten rules around necessary fields, placements, and simply the language necessary to ask the questions of why a seemingly valid request might be failing. Fortunately, OCLC has been endeavoring to reduce the difficulty in getting started. Some of these efforts have been around the release of code libraries on the OCLC Developer Network’s GitHub account\[[16](https://journal.code4lib.org/articles/#note16)\] to provide working code libraries around authentication. Others have been around the release of tools like the OCLC API Explorer which provides an opportunity to test drive specific functionality prior to working with it.

## Using MarcEdit as a Proof of Concept

One of the most exciting aspects of the release of the WorldCat Metadata API is the potential to integrate a wide range of local libraries’ services directly with OCLC’s WorldCat. For example, the release of the API provides a clear pathway for metadata creation into WorldCat from institutional or content repositories. Makers of repositories like DSpace, ContentDM, Islandora, or any number of Hydra-based platforms could utilize the Metadata API not only to simplify the flow of information into OCLC’s WorldCat, but also as a mechanism for utilizing WorldCat to populate metadata within the repositories themselves. Likewise, these APIs could be used by local technical services departments interested in created customized workflows around specific material processing, or for use by the libraries’ ILS community to provide deeper integration between the local library system community and WorldCat database.

In examining how the current WorldCat Metadata API’s could be exploited to help augment existing technical services workflow, I investigated how these services could be integrated into MarcEdit to facilitate a handful of batch processing tasks related to holdings management and record upload. Utilizing the C# library referenced earlier in this article, I created two new tools: 1) batch bibliographic records tool for creating, updating, or deleting both master and local bibliographic data and 2) batch holdings management tool, for adding or deleting organizational holdings on bibliographic records. These tools provide real-life examples of how existing metadata workflows can be modified or enhanced utilizing the WorldCat Metadata API to interact intimately between various systems.

### Creating/Editing bibliographic records

MarcEdit’s OCLC bibliographic records uploader has the ability to process both local and master bibliographic record sets. The functionality was implemented as a stand-alone tool ([Figure 1](https://journal.code4lib.org/articles/#fig1)) and as part of a set of integrated workflows within the MarcEditor for streamlining real-time data edits. The tool provides users with a simple-to-use mechanism for batch processing bibliographic records, utilizing the Metadata API as the mechanism to communicate between MarcEdit and WorldCat. Of course, there were some challenges in developing this service, the most notable being that the API services don’t work well within a batch records environment. In creating this service, MarcEdit must break down the batch of MARC records to their individual record components, convert the data into UTF8 (if necessary) and transform the data into a usable format for interacting with the API (in MarcEdit’s case, the format chosen was MARCXML). The application must then send each record one-by-one to OCLC, and await a response to determine the success or failure of the operation. Because this is a batch operation and there is a potential that a user may want to process tens of thousands of records, MarcEdit creates a thread queue, initiating multiple requests at a time, tracking and reordering responses so that a report can be generated and presented to the user on completion.

![](https://journal.code4lib.org/media/Issue25/reese/figure1.png)  
**Figure 1:** Master and local bibliographic records batch processing tool

### Batch Processing WorldCat Holdings Data

While bibliographic metadata present a number of challenges, the processing of holdings data is much more straightforward. However, again, the process is complicated by the API’s current single record design and the inability to determine current holding status of an item. The lack of these two options necessitated certain trade-offs, which are apparent on the tool’s binary user interface ([Figure 2](https://journal.code4lib.org/articles/#fig2)). The tool has no way besides attempting to set a local holdings and trap for an error to determine the holding status of a record. It would be more effective if it could modify an existing holdings record based on its present status to off or on, or allow for the creation of reports to query holdings status of specific records. Again, like the bibliographic updating tool, the batch holdings processing tool creates a multithreaded processing queue to initiate multiple requests against the OCLC system. However, because the API doesn’t provide the ability to determine holdings status, the current interaction of the tool provides a set of binary actions, where all items processed are processed as holdings additions or holdings deletions. The ability to query holdings status, rather than waiting for an error code, would enable the ability to provide conditional holdings processing.

![](https://journal.code4lib.org/media/Issue25/reese/figure2.png)  
**Figure 2:** Batch WorldCat holdings management

## Conclusion

OCLC’s WorldCat database has long been a database of contradictions. On the one hand, the WorldCat database has represented the deep collaborative nature of libraries and librarians. On the other hand, the WorldCat database has long been one of the most impenetrable datasets within the library community, with access to the resource carefully guarded by its OCLC gatekeepers. The development of the Metadata API, along with a handful of other services specifically targeted at making WorldCat data more accessible, represent a welcome shift in how libraries are able to interact with their data, and a set of opportunities to develop new collaborations and workflows around the library community’s metadata operations.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Fiander, David. 2013. Comparing the LibraryThing, OCLC, and Open Library ISBN APIs. [http://journal.code4lib.org/articles/8715](https://journal.code4lib.org/articles/8715)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Rochkind, Jonathan. 2013. A Comparison of Article Search APIs via Blinded Experiment and Developer Review. [http://journal.code4lib.org/articles/7738](https://journal.code4lib.org/articles/7738)

\[[3](https://journal.code4lib.org/articles/#ref3)\] OCLC Connexion Client: [http://www.oclc.org/connexion/interface/client.en.html](http://www.oclc.org/connexion/interface/client.en.html)

\[[4](https://journal.code4lib.org/articles/#ref4)\] OCLC Connexion Browser: [http://connexion.oclc.org/](http://connexion.oclc.org/)

\[[5](https://journal.code4lib.org/articles/#ref5)\] OCLC Z39.50 Cataloging Service: [http://www.oclc.org/z3950.en.html](http://www.oclc.org/z3950.en.html)

\[[6](https://journal.code4lib.org/articles/#ref6)\] OCLC Metadata API Documentation: [http://www.oclc.org/developer/develop/web-services/worldcat-metadata-api.en.html](http://www.oclc.org/developer/develop/web-services/worldcat-metadata-api.en.html)

\[[7](https://journal.code4lib.org/articles/#ref7)\] WorldCat Metadata API powers new enhancements in latest MarcEdit release. [http://www.oclc.org/en-US/news/announcements/2013/marcedit.html](http://www.oclc.org/en-US/news/announcements/2013/marcedit.html)

\[[8](https://journal.code4lib.org/articles/#ref8)\] OCLC Developer Network. [http://www.oclc.org/developer/home.en.html](http://www.oclc.org/developer/home.en.html)

\[[9](https://journal.code4lib.org/articles/#ref9)\] Virtual International Authority File. [http://www.oclc.org/content/developer/worldwide/en\_us/develop/web-services/virtual-international-authority-file-viaf.html](http://www.oclc.org/content/developer/worldwide/en_us/develop/web-services/virtual-international-authority-file-viaf.html)

\[[10](https://journal.code4lib.org/articles/#ref10)\] Classify. [http://www.oclc.org/content/developer/worldwide/en\_us/develop/web-services/classify.html](http://www.oclc.org/content/developer/worldwide/en_us/develop/web-services/classify.html)

\[[11](https://journal.code4lib.org/articles/#ref11)\] OCLC API Explorer. [https://platform.worldcat.org/api-explorer/](https://platform.worldcat.org/api-explorer/)

\[[12](https://journal.code4lib.org/articles/#ref12)\] hash-based authentication code. [http://en.wikipedia.org/wiki/HMAC](http://en.wikipedia.org/wiki/HMAC)

\[[13](https://journal.code4lib.org/articles/#ref13)\] OAuth 1.0 Specification. [http://tools.ietf.org/html/rfc5849](http://tools.ietf.org/html/rfc5849)

\[[14](https://journal.code4lib.org/articles/#ref14)\] OCLC Metadata API Bibliographic Resource Request/Response Types. [http://www.oclc.org/developer/develop/web-services/worldcat-metadata-api/bibliographic-resource.en.html](http://www.oclc.org/developer/develop/web-services/worldcat-metadata-api/bibliographic-resource.en.html)

\[[15](https://journal.code4lib.org/articles/#ref15)\] WorldCat Metadata API Sandbox Testing: [http://www.oclc.org/developer/develop/web-services/worldcat-metadata-api/sandbox-testing.en.html](http://www.oclc.org/developer/develop/web-services/worldcat-metadata-api/sandbox-testing.en.html)

\[[16](https://journal.code4lib.org/articles/#ref16)\] OCLC Developer Network GitHub: [https://github.com/OCLC-Developer-Network](https://github.com/OCLC-Developer-Network)

## About the Author:

Terry Reese works at The Ohio State University Libraries as the Head of Digital Initiatives. His primary research interests tend to focus around the development of services and infrastructure to support large scale data projects and preservation. He’s been a participant and author of a number of software applications, both within and outside of the library community; though is probably most well known as the author and creator of MarcEdit, a metadata processing suite geared towards librarians and technicians working with library metadata.
---
title: "Using Web Services for a Mobile OPAC"
source: "https://journal.code4lib.org/articles/4810"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-04-11
created: 2025-01-10
description: "The purpose of this paper is to discuss the creation and intended evolution of the Rice University mobile online public access catalog (OPAC). The focus of the article is on how SirsiDynix’s Symphony Web Services can be used to create a mobile OPAC."
tags:
  - "clippings"
---
# Using Web Services for a Mobile OPAC
Denis Galvin, Mang Sun

The purpose of this paper is to discuss the creation and intended evolution of the Rice University mobile online public access catalog (OPAC). The focus of the article is on how SirsiDynix’s Symphony Web Services can be used to create a mobile OPAC.

## Background

### Why Create a Mobile Website

The use of mobile technologies has exploded. In 2008 four in five people in the Americas used a cellular phone, an increase from one in three in 2003 (International Telecommunication Union (ITU), 2009). \[[1](https://journal.code4lib.org/articles/#note1)\] For an academic university the numbers are even more staggering. According to Rice University’s annual IT survey in 2010, 100% of undergraduates brought a cell phone and 72% of them have a phone with a data plan (New Undergraduates \[Updated 2010\]). \[[2](https://journal.code4lib.org/articles/#note2)\] Virtually all of our library customers are using cellular devices and most of them have data plans.

### Rice Library Mobile OPAC

In the summer of 2009 the library decided to create a mobile website. It was determined that the site would include some version of a library catalog search. Currently the library uses SirsiDynix’s iLink for its OPAC. For most mobile devices, this is not a satisfactory interface. The screen is too large, and the graphics are too cumbersome. The question became how we could get search results out of the catalog that would fit on a device with a smaller screen and more limited resources. It was determined that if we were able to use web services to search the catalog, we could reformat the interface into something more appropriate. At the time, SirsiDynix did not offer a web services product, so the first Rice Library mobile OPAC was completed based on a duplicate OPAC using hard-coded CSS files. When SirsiDynix published Symphony Web Services 2.0 in early 2010, we began looking at using web services to create a better, more flexible mobile OPAC.

## Using Web Services for the Mobile OPAC

### SirsiDynix’s implementation of Web Services

SirsiDynix published Symphony Web Services 2.0 in early 2010. Going through several minor revisions, they finally published version 3.0, a greatly improved version, in late 2010.

There are three application components to SirsiDynix Symphony Web Services (SymWS): the Web Services/Servlet Container, the Netserver server process, and Symphony ILS Server. These components can be installed on separate boxes to distribute the transaction load. Symphony Web Services interacts with Symphony ILS server via the Netserver process at configurable ports. In our implementation, we install Symphony Web Services on a server other than the ILS server.

The installation and set up of web services is fairly straightforward. There are only two requirements: the Java SE Development Kit (JDK) version 1.6.0 update 5 or higher and the Apache Tomcat server. The Tomcat server comes with the installation package so the only thing that needs to be done is to download and install the JDK. After this has been accomplished there is a script that must be run on the server which guides the user through the installation process.

Once installed, Symphony Web Services exposes three interfaces: Patron Services, Security Services, and the Standard Service. Currently there is no documentation published by SirsiDynix on their web services, but it can be explored through the Web Services Description Language (WSDL) along with the Simple Object Access Protocol (SOAP). SOAP is an HTTP protocol that is used for exchanging information through web services. WSDL provides an XML grammar for describing all the pertinent information about a web service, including its name, transport binding, and message format (Ma K 2005). \[[3](https://journal.code4lib.org/articles/#note3)\] SOAP does the exchanging of information and WSDL describes how it should be done. (For more information, see [http://en.wikipedia.org/wiki/SOAP](https://journal.code4lib.org/articles/Using%20Web%20Services%20for%20the%20Mobile%20OPAC%20%20SirsiDynix's%20implementation%20of%20Web%20Services%20SirsiDynix%20published%20Symphony%20Web%20Services%202.0%20in%20early%202010.%20Going%20through%20several%20minor%20revisions,%20they%20finally%20published%20version%203.0,%20a%20major%20improved%20version,%20in%20late%202010.%20%20There%20are%20three%20application%20components%20to%20SirsiDynix%20Symphony%20Web%20Services%20\(SymWS\):%20the%20Web%20Services/Servlet%20Container,%20the%20Netserver%20server%20process,%20and%20Symphony%20ILS%20Server.%20These%20components%20can%20be%20installed%20on%20separate%20boxes%20to%20distribute%20the%20transaction%20load.%20Symphony%20Web%20Services%20interacts%20with%20Symphony%20ILS%20server%20via%20the%20Netserver%20process%20at%20configurable%20ports.%20In%20our%20implementation,%20we%20install%20Symphony%20Web%20Services%20on%20a%20separate%20server%20than%20the%20ILS%20server.%20%20The%20installation%20and%20set%20up%20of%20web%20services%20is%20fairly%20straightforward.%20There%20are%20only%20two%20requirements:%20the%20Java%20SE%20Development%20Kit%20\(JDK\)%20version%201.6.0%20update%205%20or%20higher%20and%20the%20Apache%20Tomcat%20server.%20The%20Tomcat%20server%20comes%20with%20the%20installation%20package%20so%20the%20only%20thing%20needs%20to%20be%20done%20is%20to%20download%20and%20install%20the%20JDK.%20After%20this%20has%20been%20accomplished%20there%20is%20a%20script%20that%20must%20be%20run%20on%20the%20server%20which%20guides%20the%20user%20through%20the%20installation%20process.%20%20%20Once%20installed%20Symphony%20Web%20Services%20exposes%20three%20interfaces:%20Patron%20Services,%20Security%20Services,%20and%20the%20Standard%20Service.%20Currently%20there%20is%20no%20documentation%20published%20by%20SirsiDynix%20on%20their%20web%20services,%20but%20it%20can%20be%20explored%20through%20the%20Web%20Services%20Description%20Language%20\(WSDL\)%20along%20with%20the%20Simple%20Object%20Access%20Protocol%20\(SOAP\).%20%20SOAP%20is%20an%20HTTP%20protocol%20that%20is%20used%20for%20exchanging%20information%20through%20seb%20services.%20WSDL%20provides%20an%20XML%20grammar%20for%20describing%20all%20the%20pertinent%20information%20about%20a%20web%20service,%20including%20its%20name,%20transport%20binding,%20and%20message%20format%20\(Ma%20K%202005\).%20SOAP%20does%20the%20exchanging%20of%20information%20and%20WSDL%20describes%20how%20it%20should%20be%20done.%20\(For%20more%20information,%20see%20http://en.wikipedia.org/wiki/SOAP\)))

Symphony Web Services’ three WSDL interfaces can be found at the following three URLs:

1. http://host:port/WScontext/soap/security?wsdl
2. http://host:port/WScontext/soap/patron?wsdl
3. http://host:port/WScontext/soap/standard?wsdl

In this example “WScontext” is the name of the context path where Symphony Web Services was installed. By exploring the WSDL interfaces a complete list of the available web services and operations can be obtained. With the aid of an Integrated Development Environment (IDE), such as Oracle NetBeans, client code can be auto-generated based on the exposed WSDL interfaces.

Up through version 2 of SirsiDynix’s Symphony Web Services it is free to access Standard Services (i.e., searching catalog, looking up title information, etc.) and Security/Patron services (i.e., user authentication, login/logout, listing/renewing checkouts, etc.). However, starting with the current version (3.0), libraries must acquire an additional license to program against and access Patron Services while the Standard Services will remain free.

### Choosing a Web Services Toolkit

There are many existing toolkits available for developers of web service clients and servers. After a period of exploration we decided to adopt JAX-WS 2.x (Java API for XML web services) as our developmental toolkit for our web services client to communicate via XML-based SOAP messages. The reason JAX-WS was chosen is because it allows a programmer to avoid dealing directly with SOAP generation and parsing.

Developing a JAX-WS style web services client without the aid of IDE can be compared to driving a car to a restaurant for the first time in New York without a GPS device. Without a GPS device, you have to either remember names of major streets where turns will be made or look at a map from time to time. You will eventually make it to the restaurant, but the process may be slow and potentially fraught with error. An efficient and smart IDE takes the role of a GPS in software development. For this project, we are using Oracle NetBeans 6.8 as our IDE tool.

### Implementing the Mobile OPAC

The project can be divided into two independent tasks: developing the User Services interface and developing the Search Catalog & Place Hold interface.

User Services interface

Through this interface users are able to list their checkouts, holds, overdues and bills. They are also able to renew their checkouts and manage (view and remove) their current holds.

Search Catalog & Place Hold interface

Through this interface users are able to search our catalog via the quick search page or the advanced search page. Users can also list title holdings information and place holds on holdable items.

### Application design approach

The design approach is based on Model, View, Controller (MVC) (see [http://en.wikipedia.org/wiki/Model-View-Controller](http://en.wikipedia.org/wiki/Model-View-Controller) for a quick explanation) which is an architecture that logically separates the application into model layer, view layer and controller layer. The model layer implements the actual business logic. The view layer provides user interfaces to interact with the model layer, sending data (i.e., search terms) to the model layer to process and display data such as search hits returned from the model layer. The controller layer sits between the model layer and view layer and determines which model object a request should be directed to and which view object should be called to display a data output (i.e., a user’s checkout list object).

In order to implement the MVC architecture, we decided to use an existing web application framework. Frameworks are building blocks and services that a developer can use to solve problems in repeatable ways. We developed this application using the Apache Struts framework because it is mature, well documented, and relatively simple to learn and use. It is also supported by Oracle Net Beans. With Struts, we can define action objects to interact directly with the controller servlet component to achieve complex MVC flow control which is the advantage that Struts brings to this project. Other frameworks can also accomplish this; Struts was selected based on the developer’s personal preference and experience. This project is moderately complex, and most popular mainstream web frameworks can do the job.

### The application flow

The two separate interfaces, User Services and Catalog Search & Place Hold, have their own application flow but as a whole share commonalties in architecture and code. The following section introduces the Struts components shared by the entire application, and then outlines the general steps on how to call Symphony Web Services.

#### The Struts components

In Figure 1 and Figure 8, the ActionServlet class is the key component of the controller layer of the Struts Framework and is configured as a servlet in the web.xml file as shown in the following code:

| 1  2  3  4  5  6  7  8  9  10  11  12  13 | `<``servlet``>`  `<``servlet-name``>action</``servlet-name``>`  `<``servlet-class``><``strong``>org.apache.struts.action.ActionServlet</``strong``></``servlet-class``>`  `<``init-param``>`  `<``param-name``>config</``param-name``>`  `<``param-value``>/WEB-INF/<``strong``>struts-config.xml</``strong``></``param-value``>`  `</``init-param``>`  `<``servlet-mapping``>`  `...`  `<``servlet-name``>action</``servlet-name``>`  `<``url-pattern``><``strong``>*.do</``strong``></``url-pattern``>`  `</``servlet-mapping``>`  `...` |
| --- | --- |

In this application any request with the URL pattern of \*.do (e.g. login.do) will invoke the ActionServlet controller. The ActionServlet consults the struts configuration file named struts-config.xml (also defined in the web.xml file in the code above) to determine which action object should be called in response to the incoming request. The struts-config.xml file holds the request action mapping definitions. The following code snippet from struts-config.xml defines the action class (LoginAction) to call in response to a request submitted via login.do:

| 1  2  3  4  5  6  7  8  9  10  11 | `<``action-mappings``>`  `...`  `<``action` `name``=``"LoginForm"` `path``=``"/login"` `scope``=``"request"`  `type``=``"edu.rice.library.fondrenapps.struts.LoginAction"` `validate``=``"false"``>`  `<``forward` `name``=``"success"` `path``=``"/WEB-INF/userservices.jsp"``/>`  `<``forward` `name``=``"retry"` `path``=``"/login.jsp"``/>`  `<``forward` `name``=``"page4placehold"` `path``=``"/confighold.jsp"``/>`  `<``forward` `name``=``"failure"` `path``=``"/faileduserservice.jsp"``/>`  `</``action``>`  `...`  `</``action-mappings``>` |
| --- | --- |

LoginForm is a form bean (extends ActionForm class) representing the login form that is presented and submitted via login.jsp; it transports form property data (e.g. user name) back and forth between the view (login.jsp) and the action class (LoginAction). Also defined in this sample code are four named forward paths – success, retry, page4placehold and failure which point to four JSP pages respectively – success.jsp, login.jsp, confighold.jsp and faileduserservice.jsp. These forwards will be used by the action class (LoginAction) to determine which JSP page will be used based on the results from LoginAction. Take note that action classes according to the Struts Framework are not intended to hold actual business logic. Instead, action classes are designed to hold control logic (i.e. the LoginAction action class invokes the loginUser method exposed from the Security web services interface) to interact with actual business logic (in this example it checks whether library user credentials can be honored or denied) which resides in the model layer. Therefore the action class in this example does not belong to the model layer. Because Symphony Web Services encapsulate all library OPAC business logic and expose them through industry standard compliant web services interfaces, it is fine to view the web services as the model layer of our application. The ActionServlet servlet, web.xml file, struts-config.xml file, form beans and user defined action classes comprise the controller layer (areas circled by ellipse in Figure 1 and Figure 8) whereas all JSP pages form the view layer.

#### Call the Symphony Web Services

Before any call to the Symphony Web Services can be programmed, NetBeans is used to generate portable Java artifacts for the web services client by reading the WSDL of the Symphony Web Services. Behind the scenes, this step is actually accomplished by a WSDL to Java mapping tool (i.e., the JAX-WS wsimport utility) picked by NetBeans. Among the generated Java artifacts, the following major artifacts are listed below.

- Service Endpoint interface (SEI)
- Service
- JAXB generated class
- Exceptions Class

(For brief explanation to the above Java artifacts, please visit the link [http://publib.boulder.ibm.com/infocenter/wasinfo/v6r1/index.jsp?topic=/com.ibm.websphere.wsfep.multiplatform.doc/info/ae/ae/rwbs\_wsimport.html](http://publib.boulder.ibm.com/infocenter/wasinfo/v6r1/index.jsp?topic=/com.ibm.websphere.wsfep.multiplatform.doc/info/ae/ae/rwbs_wsimport.html))

With the Java artifacts being generated, we can program calls to the Symphony Web Services.

The code snippet in [Example 1](https://journal.code4lib.org/articles/#ex1) shows how to make use of the generated artifacts to call the loginUser method on the Symphony Security Service.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14 | `com.sirsidynix.symws.security.SecurityService service =`  `new` `com.sirsidynix.symws.security.SecurityService();`  `com.sirsidynix.symws.security.SecurityEndpoint port = service.getSecurityPort();`  `com.sirsidynix.xmlns.common.header.SdHeader header =`  `new` `com.sirsidynix.xmlns.common.header.SdHeader();`  `com.sirsidynix.schemas.symws.security.LoginUserRequest body =`  `new` `com.sirsidynix.schemas.symws.security.LoginUserRequest();`  `header.setClientID(``"xxxx"``);`  `body.setLogin(userid);`  `body.setPassword(userpass);`  `com.sirsidynix.schemas.symws.security.LoginUserResponse result =`  `port.loginUser(body, header);`  `session.setAttribute(``"session_no"``, result.getSessionToken());`  `session.setAttribute(``"authuserid"``, result.getUserID());` |
| --- | --- |

**Example 1**

The first two code lines, at run time, create a proxy instance named “port” that implements the Security endpoint interface (SEI).

Lines 4-5 create the header instance from the generated JAXB wrapper class SdHeader. The secret string required by the Symphony Web Services is assigned to the header instance on line 8. Lines 4-5 and line 8 are commonly required by all kinds of calls made to Symphony Web Services and remain almost identical across all Symphony Web Service calls.

Lines 6-7 create the body instance from the generated JAXB wrapper class LoginUserRequest which behaves as a wrapper to contain all request parameters specifically required for a web service call. Lines 9-10 assemble user ID and user password into the body request wrapper object.

Lines 11-12 pass the standard request header object and request body object as the required reference type parameters and invoke the loginUser method on the port proxy instance of Security SEI. If successful, the invocation returns a result object that is an instance of the JAXB generated LoginUserResponse wrapper class.

Lines 13-14 retrieve the sessionToken and userID property values from the result object and ingest them into the session scope of the HttpServletRequest object for sharing by other components of this application.

#### User Services

[![Figure 1: User Services flow chart](https://journal.code4lib.org/media/issue13/galvin/figure1.jpg "Figure 1: User Services flow chat")](https://journal.code4lib.org/media/issue13/galvin/figure1.jpg)

**Figure 1.** User Services flow chart

In User Services (Figure 1), users authenticate into their accounts through the page login.jsp (Figure 2). Behind the scenes, user credential data is carried by the LoginForm form bean. Then, the LoginAction action object is dispatched to call the authenticateUser and userLogin method of the Symphony Security Service.

[![Figure 2: User Services page](https://journal.code4lib.org/media/issue13/galvin/figure2.png "Figure 2: User Services page")](https://journal.code4lib.org/media/issue13/galvin/figure2.png)

**Figure 2.** User Services page

The code in [Example 2](https://journal.code4lib.org/articles/#ex2) is called in the LoginAction action object to test whether the supplied user id and user password are valid. If the Boolean type return value – authresult is false, the local forward path – retry will be selected and login.jsp will be redisplayed asking users to retype their credentials.

| 1  2  3  4  5 | `com.sirsidynix.schemas.symws.security.AuthenticateUserRequest authbody =`  `new` `com.sirsidynix.schemas.symws.security.AuthenticateUserRequest();`  `authbody.setLogin(userid);`  `authbody.setPassword(userpass);`  `boolean` `authresult = port.authenticateUser(authbody, header);` |
| --- | --- |

**Example 2**

Otherwise, if the value of the returned authresult variable is true, the call to userLogin method will be made (See the code in [Example 1](https://journal.code4lib.org/articles/#ex1) for detail). Upon successful invocation to the userLogin method, a session scoped bean – session\_no is generated. The session\_no bean contains the session value, assigned by Symphony Security Service, pointing to the currently valid authenticated user session.

Then, the successfully authenticated and logged in user is forwarded to the protected user services page which presents four task options: User Status Inquiry, View/Remove Holds, Renew My Materials and Logout (Figure 3).

[![Figure 3: User Services page](https://journal.code4lib.org/media/issue13/galvin/figure3.jpg "Figure 3: User Services page")](https://journal.code4lib.org/media/issue13/galvin/figure3.jpg)

**Figure 3.** User Services page

The User Status Inquiry (Figure 4) link calls the ListckoAction action object. The code snippet in [Example 3](https://journal.code4lib.org/articles/#ex3) shows the steps to call the lookupMyAccountInfo method on the Patron service.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19 | `header.setClientID(``"xxxx"``);`  `header.setSessionToken(session.getAttribute(``"session_no"``).toString());`  `com.sirsidynix.symws.patron.PatronService service =`  `new` `com.sirsidynix.symws.patron.PatronService();`  `com.sirsidynix.symws.patron.PatronEndpoint port = service.getPatronPort();`  `com.sirsidynix.schemas.symws.patron.LookupMyAccountInfoRequest body =`  `new` `com.sirsidynix.schemas.symws.patron.LookupMyAccountInfoRequest();`  `body.setIncludeFeeInfo(FeeInfoFilter.UNPAID_FEES);`  `body.setIncludePatronCheckoutInfo(CheckoutInfoFilter.ALL);`  `body.setIncludePatronStatusInfo(Boolean.TRUE);`  `body.setIncludePatronHoldInfo(HoldInfoFilter.ACTIVE);`  `com.sirsidynix.schemas.symws.patron.LookupMyAccountInfoResponse result =`  `port.lookupMyAccountInfo(body, header);`  `List ckolist = result.getPatronCheckoutInfo();`  `List feeinfo = result.getFeeInfo();`  `request.setAttribute(``"listcko"``, ckolist);`  `request.setAttribute(``"num_holds"``, result.getPatronHoldInfo().size());`  `request.setAttribute(``"patronstatus"``, result.getPatronStatusInfo());`  `request.setAttribute(``"feeinfo"``, feeinfo);` |
| --- | --- |

**Example 3**

[![Figure 4: List Checkouts page](https://journal.code4lib.org/media/issue13/galvin/figure4.png "Figure 4: List Checkouts page")](https://journal.code4lib.org/media/issue13/galvin/figure4.png)

**Figure 4.** List Checkouts page

Aside from the secret string required by the Symphony Web Services on line 2, the value of the current authenticated user session is also assembled into the request header object. Without this session value being assembled, the call to the lookupMyAccountInfo method will not be allowed and will throw an exception. Lines 8-11 prepare the request body object of the JAXB generated LookupMyAccountInfoRequest Class by setting values of the Include properties of the body object, indicating the response should contain fee (bill) , patron status, and active hold information. Lines 12-13 make the actual call to the lookupMyAccountInfo method of the Patron service. Lines 14-15 retrieve the patronCheckoutInfo and feeInfo information and save them into the ckolist and feeinfo array list respectively. Lines 16-19 place the acquired information into the request scoped beans which will be consumed by the list4cko.jsp page.

Renew My Materials (Figure 6) needs a little bit more work than User Status Inquiry. The Listcko4renewalAction action object is dispatched to get a list of checkouts for renewing and forwards the list to the renewcko.jsp page for display (Figure 5). The code in Listcko4renewalAction class is pretty much identical to the code shown in [Example 3](https://journal.code4lib.org/articles/#ex3), excluding the hold and patron status information. The reason we repeat the web services call performed by the ListckoAction action object is to guarantee the list of checkouts for renewal is updated rather than cached. When the form with selected checkouts to renew is submitted, the item IDs captured and carried by the RenewalForm form bean are sent to the RenewalAction action object.

[![Figure 5: View/Remove Current Holds page](https://journal.code4lib.org/media/issue13/galvin/figure5.png "Figure 5: View/Remove Current Holds page")](https://journal.code4lib.org/media/issue13/galvin/figure5.png)

**Figure 5.** View/Remove Current Holds page

[![Figure 6: View/Remove Current Holds page](https://journal.code4lib.org/media/issue13/galvin/figure6.png "Figure 6: Select Items to Renew page")](https://journal.code4lib.org/media/issue13/galvin/figure6.png)

**Figure 6.** Select Items to Remove page

The code snippet in [Example 4](https://journal.code4lib.org/articles/#ex4) shows the steps to call the renewCheckout method on the Patron service.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35 | `Map failedrenewals = ``new` `LinkedHashMap();`  `int` `failcnt=``1``;`  `com.sirsidynix.symws.patron.PatronService service =`  `new` `com.sirsidynix.symws.patron.PatronService();`  `com.sirsidynix.symws.patron.PatronEndpoint port = service.getPatronPort();`  `com.sirsidynix.schemas.symws.patron.RenewCheckoutRequest body =`  `new` `com.sirsidynix.schemas.symws.patron.RenewCheckoutRequest();`  `com.sirsidynix.xmlns.common.header.SdHeader header =`  `new` `com.sirsidynix.xmlns.common.header.SdHeader();`  `header.setClientID(``"xxxx"``);`  `header.setSessionToken(session.getAttribute(``"session_no"``).toString());`  `body.setUserID(session.getAttribute(``"authuserid"``).toString());`  `for` `(``int` `i=``0``; i &amp;amp;lt; renewalform.getSelectedCkos().length;i++)`  `{`  `body.setItemID(renewalform.getSelectedCkos()[i]);`  `try` `{`  `com.sirsidynix.schemas.symws.patron.RenewCheckoutResponse renewedresult =`  `port.renewCheckout(body, header);`  `renewedlist.add(renewedresult);`  `}`  `catch` `(Exception e1)`  `{`  `for` `(CheckoutInfo cko : ckolist)`  `{`  `if` `(cko.getItemID().equals(renewalformBean.getSelectedCkos()[i]))`  `{`  `failedrenewals.put(failcnt+``". "``+cko.getTitle(), e1.getMessage());`  `failcnt++;`  `}`  `}`  `}`  `}`  `...`  `request.setAttribute(``"renewedlist"``, renewedlist);`  `request.setAttribute(``"failedrenewals"``, failedrenewals);` |
| --- | --- |

**Example 4**

Line 12 assembles the current authenticated user ID into the body request wrapper instance of the JAXB generated RenewCheckoutRequest class. Line 13 starts a loop block to traverse the selected checkouts (item IDs) captured in the selectedCkos list properties of the RenewalForm bean. For each loop, line 15 assembles an item ID value to the request body object and then lines 17-18 make the actual call to the renewCheckout method of Patron service. Should no exception be found, the return object of the JAXB generated RenewCheckoutResponse will be pushed into the renewedlist array list; otherwise an exception object will be captured by the Catch block and the failing reason and title will be pushed into the failedrenewals LinkedHashMap object which is declared at line 1. Lines 34 and 35 place the renewedlist and failedrenewals object into two request scoped beans which will be consumed by the resultofrenewals.jsp to display the renewal results (Figure 7).

[![Figure 7: Items Renewed page page](https://journal.code4lib.org/media/issue13/galvin/figure7.png "Figure 7: Items Renewed page")](https://journal.code4lib.org/media/issue13/galvin/figure7.png)

**Figure 7.** Items Renewed page

View/Remove Holds link first calls the ListholdsAction action object to get a list of the currently authenticated user’s active holds (Figure 5). The code in [Example 5](https://journal.code4lib.org/articles/#ex5) shows the step to call the lookupMyAccountInfo method of the Patron service. It’s much like an abridged version of the code listed in Example 1.  | 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `com.sirsidynix.symws.patron.PatronService service =`  `new` `com.sirsidynix.symws.patron.PatronService();`  `com.sirsidynix.symws.patron.PatronEndpoint port = service.getPatronPort();`  `com.sirsidynix.schemas.symws.patron.LookupMyAccountInfoRequest body =`  `new` `com.sirsidynix.schemas.symws.patron.LookupMyAccountInfoRequest();`  `com.sirsidynix.xmlns.common.header.SdHeader header =`  `new` `com.sirsidynix.xmlns.common.header.SdHeader();`  `header.setClientID(``"xxxx"``);`  `header.setSessionToken(session.getAttribute(``"session_no"``).toString());`  `body.setIncludePatronCheckoutInfo(CheckoutInfoFilter.ALL);`  `body.setIncludePatronHoldInfo(HoldInfoFilter.ACTIVE);`  `com.sirsidynix.schemas.symws.patron.LookupMyAccountInfoResponse result =`  `port.lookupMyAccountInfo(body, header);`  `List holdlist=result.getPatronHoldInfo();`  `request.setAttribute(``"holdlist"``, holdlist);` |
| --- | --- |

**Example 5**

Line 15 places the retrieved holdlist list array, which contains wrapper objects of the JAXB generated PatronHoldInfo class, into a request scoped bean – holdlist, which will be consumed by the list4holds.jsp page to display the user’s current holds (Figure 5).

When the form with selected holds (hold keys) to remove is submitted, hold keys captured and carried by the List4HoldsForm form bean are sent to the RemoveholdsAction action object. The code snippet in [Example 6](https://journal.code4lib.org/articles/#ex6) shows the steps to call the cancelMyHold method on the Patron service.  | 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `List4HoldsForm listholdsBean=(List4HoldsForm)form;`  `com.sirsidynix.symws.patron.PatronService service =`  `new` `com.sirsidynix.symws.patron.PatronService();`  `com.sirsidynix.symws.patron.PatronEndpoint port = service.getPatronPort();`  `com.sirsidynix.schemas.symws.patron.CancelMyHoldRequest body =`  `new` `com.sirsidynix.schemas.symws.patron.CancelMyHoldRequest();`  `com.sirsidynix.xmlns.common.header.SdHeader header =`  `new` `com.sirsidynix.xmlns.common.header.SdHeader();`  `header.setClientID(``"xxxx"``);`  `header.setSessionToken(session.getAttribute(``"session_no"``).toString());`  `for` `(``int` `i=``0``; i &amp;amp;lt; listholdsBean.getSelectedHoldKeys().length;i++)`  `{`  `body.setHoldKey(listholdsBean.getSelectedHoldKeys()[i]);`  `boolean` `result = port.cancelMyHold(body, header);`  `}` |
| --- | --- |

**Example 6**

The loop block starting from line 11 traverses hold keys captured by the list4holdsBean instance of the List4HoldsForm form bean class. Line 13 assembles the selected hold key into the request body object of the JAXB generated CancelMyHoldRequest class. Line 14 makes the actual call to the cancelMyHold method of the Patron Service with each selected hold key. When the loop ends, the User Services page (Figure 3) will be brought back.

The Logout option ends the user’s current session by dispatching the LogoutAction action object to call the logoutUser method of the Security Service.

Failed user service operations due to runtime exceptions are handled by the faileduserservices.jsp page.

#### Search Catalog & Place Hold Interface

As shown in Figure 8, two search pages – the quick search page and the advanced search page are accessible for catalog search.

[![Figure 8: Search Catalog & Place Hold Flowchart](https://journal.code4lib.org/media/issue13/galvin/figure8.jpg "Figure 8: Search Catalog & Place Hold Flowchart")](https://journal.code4lib.org/media/issue13/galvin/figure8.jpg)

**Figure 8.** Search Catalog & Place Hold Flowchart

The quick search page — quicksearch.jsp (Figure 9) presents a single search term box along with six search index options (word anywhere, author, title, subject, series and periodical title) while advanced search (Figure 10) — advancedsearch.jsp allows users to build search terms from the three search term boxes in Boolean mode. Up to three different search indexes can be selected and searched concurrently in Boolean mode with the Advanced search page. The advanced search page also presents three search qualifier (filters) selectors – item type, location and publication year to help users refine their searches.

[![Figure 9: Quick Search page](https://journal.code4lib.org/media/issue13/galvin/figure9.png "Figure 9: Quick Search page")](https://journal.code4lib.org/media/issue13/galvin/figure9.png)

**Figure 9.** Quick Search page

[![Figure 10: Advanced Search page](https://journal.code4lib.org/media/issue13/galvin/figure10.png "Figure 10: Advanced Search page")](https://journal.code4lib.org/media/issue13/galvin/figure10.png)

**Figure 10.** Advanced Search

When the quick search or the advanced search page is submitted, search request data (search terms, search index type(s), Boolean operators and search (filters) qualifiers) captured and encapsulated by the SearchForm form bean is sent to the SearchAction action object. The code in [Example 7](https://journal.code4lib.org/articles/#ex7) shows the steps for how to assemble search request data from the advanced search page into a search request object and then call the searchCatalog method on the Standard Service.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53 | `SearchForm searchForm=(SearchForm)form;`  `...`  `com.sirsidynix.symws.standard.StandardService service =`  `new` `com.sirsidynix.symws.standard.StandardService();`  `com.sirsidynix.symws.standard.StandardEndpoint port = service.getStandardPort();`  `com.sirsidynix.schemas.symws.standard.SearchCatalogRequest searchrequestbody =`  `new` `com.sirsidynix.schemas.symws.standard.SearchCatalogRequest();`  `...`  `com.sirsidynix.schemas.symws.standard.SearchCatalogRequest.Query qterm1 =`  `new` `com.sirsidynix.schemas.symws.standard.SearchCatalogRequest.Query();`  `...`  `qterm1.setTerm(searchForm.getSrchdata1());`  `...`  `if` `(!searchForm.getSrchfield1().equals(``"GENERAL"``))`  `{ qterm1.setSearchType(searchForm.getSrchfield1());}`  `qterm1.setOperator(searchForm.getSrchop1());`  `searchrequestbody.getQuery().add(qterm1);`  `...`  `com.sirsidynix.schemas.symws.standard.SearchCatalogRequest.Query qterm2 =`  `new` `com.sirsidynix.schemas.symws.standard.SearchCatalogRequest.Query();`  `...`  `searchrequestbody.getQuery().add(qterm2);`  `...`  `com.sirsidynix.schemas.symws.standard.SearchCatalogRequest.Query qterm3 =`  `new` `com.sirsidynix.schemas.symws.standard.SearchCatalogRequest.Query();`  `...`  `searchrequestbody.getQuery().add(qterm3);`  `...`  `SearchCatalogFilters searchfilter = ``new` `SearchCatalogFilters();`  `...`  `searchfilter.setItemtypeFilter(searchForm.getSrchitype());`  `...`  `searchfilter.setHomelocationFilter(searchForm.getSrchloc());`  `...`  `searchfilter.setPubyearFilter(searchForm.getPubyear());`  `...`  `searchrequestbody.setFilters(searchfilter);`  `...`  `com.sirsidynix.schemas.symws.standard.SearchCatalogResult searchresult =`  `port.searchCatalog(searchrequestbody, header);`  `...`  `request.setAttribute(``"queryid"``, searchresult.getQueryID());`  `request.setAttribute(``"totalhits"``,searchresult.getTotalHits());`  `request.setAttribute(``"hitsperpage"``,hitsperpage);`  `if` `(searchresult.getTotalHits()&amp;amp;lt;= hitsperpage )`  `{`  `request.setAttribute(``"hitlist"``, searchresult.getHitlistTitleInfo());`  `...`  `return` `mapping.findForward(SUCCESS);`  `}`  `...`  `request.setAttribute(``"currentpageno"``,``"1"``);`  `return` `mapping.findForward(PAGINGREQUEST);` |
| --- | --- |

**Example 7**

Line 12 assigns the term from the first search box field of the advanced search page to the term property of the qterm1 wrapper object of the JAXB generated Query class. Lines 14 and 15 determine the search index value which is captured by srchfield1 of the SearchForm bean object. The search index value selected for the first search box on the advanced search page is assigned to the searchType property of the qterm1 object. searchType is called search index in our own application code. Because GENERAL is the default index, it doesn’t need to be assigned to the searchType property of the qterm1 object. This is done through the usage of the “if” conditional on line 14. Other values that can be assigned on the advanced search page that work with the searchType property of query wrapper object are, TITLE, AUTHOR, SUBJECT, SERIES, PERTITLE (periodical title).

Line 16 assigns the Boolean operator value that has been selected for the first search box to the operator property of the qterm1 object. Line 17 pushes the qterm1 object which has been populated with the search data from the first search box to the query property (Query typed Array List) of the searchrequestbody body request object of the JAXB generated SearchCatalogRequest class. Following the same logic, lines 19-27 collect and assemble search data from the second and third search boxes into the query property of the searchrequestbody request body object. Lines 29-35 assign the selected search qualifiers to the corresponding properties of the searchfilter object of the JAXB generated SearchCatalogFilter. Line 37 assigns this searchfilter object to the Filters property of the searchrequestbody request body object. Lines 39-40 make the final call to the searchCatalog method on the Standard Service. Lines 42-43 create two request scoped beans queryid and totalhits from the corresponding properties of the searchresult return object of the JAXB generated SearchCatalogResult class. The value of the queryid bean points to the current search result set. Line 44 assigns the value (10 in our application) of the hitsperpage variable into the request scoped hitsperpage bean. If the number of total search hits is not greater than the value (10) of the hitsperpage variable (Line 39). Line 49 forwards directly to the hitlistdisplay.jsp page (Figure 11) to display the title list which is contained in the request scoped hitlist bean created from the value of the hitlistTitleInfo property of the searchresult object on line 47. If the number of total search hits is greater than 10, line 53 will forward the processing to the searchpaging link where the SearchPagingAction action object can be called.

[![Figure 11: Hit List Page with hits less than or equal to 10](https://journal.code4lib.org/media/issue13/galvin/figure11.png "Figure 11: Hit List Page with hits less than or equal to 10")](https://journal.code4lib.org/media/issue13/galvin/figure11.png)

**Figure 11.** Hit List Page with hits less than or equal to 10

The code snippet in [Example 8](https://journal.code4lib.org/articles/#ex8) shows how to call the searchCatalogPaging method on the standard service.  | 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27 | `hitsperpage=Integer.parseInt(request.getAttribute(``"hitsperpage"``).toString());`  `queryid=request.getAttribute(``"queryid"``).toString();`  `hitsperpage=Integer.parseInt(request.getAttribute(``"hitsperpage"``).toString());`  `numOfPages=Long.parseLong(request.getAttribute(``"numofpages"``).toString(),``10``);`  `currentpageno=Long.parseLong(request.getAttribute(``"currentpageno"``).toString(),``10``);`  `...`  `com.sirsidynix.xmlns.common.header.SdHeader header =`  `new` `com.sirsidynix.xmlns.common.header.SdHeader();`  `com.sirsidynix.symws.standard.StandardService service =`  `new` `com.sirsidynix.symws.standard.StandardService();`  `com.sirsidynix.symws.standard.StandardEndpoint port = service.getStandardPort();`  `com.sirsidynix.schemas.symws.standard.SearchCatalogPagingRequest pagingrequestbody =`  `new` `com.sirsidynix.schemas.symws.standard.SearchCatalogPagingRequest();`  `header.setClientID(``"xxxx"``);`  `pagingrequestbody.setQueryID(queryid);`  `pagingrequestbody.setFirstHitToDisplay((currentpageno-``1``)*hitsperpage+``1``);`  `if` `(currentpageno*hitsperpage &amp;amp;lt;= totalhits)`  `pagingrequestbody.setLastHitToDisplay(currentpageno*hitsperpage);`  `else`  `pagingrequestbody.setLastHitToDisplay(totalhits);`  `pagingrequestbody.setIncludeAvailabilityInfo(``true``);`  `com.sirsidynix.schemas.symws.standard.SearchCatalogResult pageresult =`  `port.searchCatalogPaging(pagingrequestbody, header);`  `...`  `request.setAttribute(``"hitlist"``, pageresult.getHitlistTitleInfo());`  `...`  `return` `mapping.findForward(SUCCESS);` |
| --- | --- |

**Example 8**

Line 15 sets the queryid acquired from the SearchAction object to the queryID property of the pagingrequestbody request object of the JAXB generated SearchCatalogPagingRequest class. Lines 16-20 calculate the first and last hits to display for the current page and assemble them into the pagingrequestbody request body object.  
Line 21 includes title availability information (i.e. is a title holdable?) within the return object. Lines 22-23 finally make the call to the searchCatalogPaging method on the Standard service. Line 25 creates a request scoped bean (hitlist) from the value of the hitlistTitleInfo property of the pageresult return object of the JAXB generated SearchCatalogResult class. This request scoped hitlist bean contains a subset which corresponds to the currently selected page of the original search result set. Line 27 forwards back to the hitlistdisplay.jsp to display the current hitlist along with the updated page navigation buttons (Figure 12).

[![Figure 12: Hit List Page with hits greater than or equal to 10](https://journal.code4lib.org/media/issue13/galvin/figure12.png "Figure 12: Hit List Page with hits greater than or equal to 10")](https://journal.code4lib.org/media/issue13/galvin/figure12.png)

**Figure 12.** Hit List Page with hits greater than or equal to 10

When a title link on a hitlist page is clicked to show a title’s holding information, the CheckTitleInfoAction object behind the /checktitleinfo link is called along with several request parameters. The code snippet in [Example 9](https://journal.code4lib.org/articles/#ex9) shows how to call the lookupTitleInfo method of the Standard service.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `com.sirsidynix.xmlns.common.header.SdHeader header =`  `new` `com.sirsidynix.xmlns.common.header.SdHeader();`  `com.sirsidynix.symws.standard.StandardService service =`  `new` `com.sirsidynix.symws.standard.StandardService();`  `com.sirsidynix.symws.standard.StandardEndpoint port = service.getStandardPort();`  `request.setAttribute(``"titleinfo"``, result.getTitleInfo());`  `com.sirsidynix.schemas.symws.standard.LookupTitleInfoRequest body =`  `new` `com.sirsidynix.schemas.symws.standard.LookupTitleInfoRequest();`  `header.setClientID(``"xxxx"``);`  `body.getTitleID().add(titleid);`  `body.setIncludeAvailabilityInfo(``true``);`  `body.setIncludeItemInfo(``true``);`  `body.setIncludeCatalogingInfo(``true``);`  `body.setMarcEntryFilter(``"FULL"``);`  `com.sirsidynix.schemas.symws.standard.LookupTitleInfoResponse result =`  `port.lookupTitleInfo(body, header);`  `request.setAttribute(``"titleinfo"``, result.getTitleInfo());` |
| --- | --- |

**Example 9**

Line 10 adds the selected titleid to the titleID property of the body request object of the JAXB generated LookupTitleInfoRequest. Lines 11-14 include what kinds of title information (i.e., item information, Marc Information) should be included in the return object. Lines 15-16 make the actual call to the lookupTitleInfo method of the Standard service. Line 17 generates the titleinfo bean from the value of the titleInfo property of the result object of the JAXB generated LookupTitleInfoResponse before being forwarded to the displaytitleinfo.jsp page (Figure 13).

[![Figure 13: Title Holding Information page](https://journal.code4lib.org/media/issue13/galvin/figure13.png "Figure 13: Title Holding Information page")](https://journal.code4lib.org/media/issue13/galvin/figure13.png)

**Figure 13.** Title Holding Information page

The failedsearch.jsp page is used to handle failed searches and other exceptions.

If the currently displayed title has a holdable copy, a Place hold link will show (Figure 13) for this copy. Once the Place hold link is clicked, the ConfigHoldAction action object is called. This action object is also used to determine whether there is an authenticated user session. If no valid authenticated user session can be found, the login.jsp will be called to ask the user for their credentials. If authentication succeeds, or if there is a valid authenticated user session, the confighold.jsp will be called to let the user choose pickup library and hold expiration date (Figure 14).

[![Figure 14: Place Hold page](https://journal.code4lib.org/media/issue13/galvin/figure14.png "Figure 14: Place Hold page")](https://journal.code4lib.org/media/issue13/galvin/figure14.png)

**Figure 14.** Place Hold page

When the confighold.jsp page is submitted, data for placing a hold (i.e. title, itemID, expiration date) is sent to the PlaceholdAction action object. The code snippet in [Example 10](https://journal.code4lib.org/articles/#ex10) shows how to call the createMyHold method on the Standard service.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24 | `com.sirsidynix.symws.patron.PatronService service =`  `new` `com.sirsidynix.symws.patron.PatronService();`  `com.sirsidynix.symws.patron.PatronEndpoint port = service.getPatronPort();`  `com.sirsidynix.schemas.symws.patron.CreateMyHoldRequest body =`  `new` `com.sirsidynix.schemas.symws.patron.CreateMyHoldRequest();`  `com.sirsidynix.xmlns.common.header.SdHeader header =`  `new` `com.sirsidynix.xmlns.common.header.SdHeader();`  `header.setSessionToken(session.getAttribute(``"session_no"``).toString());`  `header.setClientID(``"xxxx"``);`  `...`  `SimpleDateFormat formatter=``new` `SimpleDateFormat(``"MM/dd/yyyy"``);`  `Date utildate=formatter.parse(expdate4hold);`  `GregorianCalendar gcdate = ``new` `GregorianCalendar();`  `gcdate.setTime(utildate);`  `javax.xml.datatype.XMLGregorianCalendar xmlgcdate =`  `new` `com.sun.org.apache.xerces.internal.jaxp.datatype.XMLGregorianCalendarImpl(gcdate);`  `NillableDate expireDate = ``new` `NillableDate();`  `expireDate.setValue(xmlgcdate);`  `body.setItemID(itemid4hold);`  `body.setPickupLibraryID(picklibrary4hold);`  `body.setExpiresDate(expireDate);`  `body.setHoldType(HoldType.SYSTEM);`  `body.setHoldRange(HoldRange.SYSTEM);`  `long` `result = port.createMyHold(body, header);` |
| --- | --- |

**Example 10**

Line 8 assembles the authenticated user session value into the header object.  
Lines 11-18 convert the text string of the hold expiration date (expdate4hold) into a NillableDate object. Lines 19-23 set property values of the request body object of the JAXB generated CreateMyHoldRequest class. Line 24 makes the call to the createMyHold method on the Standard Service. The successfully returned result is a long type value. The resultofplacehold.jsp then is called to show the hold has been successfully placed (Figure 15). Otherwise the failedplacehold.jsp will be called to show the failed hold and the reason why it did not succeed.

[![Figure 15: Result Page for Place Hold](https://journal.code4lib.org/media/issue13/galvin/figure15.png "Figure 15: Result Page for Place Hold")](https://journal.code4lib.org/media/issue13/galvin/figure15.png)

**Figure 15.** Result Page for Place Hold

### Problems

The mobile OPAC only consumes a small set of available methods exposed from SirsiDynix Symphony Web Services’ three interfaces: Security, Patron, and Standard Services. While including all functionality that was available in Rice University’s first mobile OPAC created using CSS stylesheets, it also overcomes problems with that type of mobile interface:

1. The CSS mobile OPAC was mainly targeted for iPhone/iPod Touch devices.
2. Fat footprint — only hiding screen elements not eliminating them.
3. Potential breakage caused by future OPAC upgrades or redesigns.

Initially when this application was developed we ran into a number of problems with Symphony Web Services 2.0. That version did not support system level holds and attempting to place a hold or to list holds caused an exception to be thrown. Blocked and barred patrons could not log into their accounts. Users who had an item recalled could not check their accounts without the system throwing an exception. As of version 3.0 all of these issues have been fixed.

### Conclusion

Web services have been in existence for more than a decade. They have been widely adopted and heavily utilized by numerous companies to streamline and strengthen their business workflow internally and externally. In recent years, web services have started to be adopted by library vendors (e.g. the xISBN interface by WorldCat). That ILS vendors have begun to expose OPAC interface functions through web services is another leap into the library world for this technology. This Mobile OPAC, consuming methods and data exposed via another library system’s web services interface, is an example of a project that can be built with little trouble even without technical documentation available from the vendor. By integrating web services into their products library vendors are using an industry standard. They present an opportunity for libraries to streamline work across many types of library systems – discovery tools, ERMs, e-reserves and courseware management, amongst others. Web services are a step in the right direction.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] International Telecommunication Union (2009), Information society statistical profiles 2009: Americas. \[Internet\]. \[cited 2010 Sept 8\] Available from: [www.itu.int/dms\_pub/itu-d/opb/ind/D-IND-RPM.AM-2009-E09-PDF-E.pdf](https://journal.code4lib.org/articles/www.itu.int/dms_pub/itu-d/opb/ind/D-IND-RPM.AM-2009-E09-PDF-E.pdf)

\[[2](https://journal.code4lib.org/articles/#ref2)\] New Undergraduates \[Internet\]. \[Updated 2010\] Rice University \[cited 2010 Nov 30\] Available from: [http://it.rice.edu/newStudent.aspx](http://it.rice.edu/newStudent.aspx)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Ma, K. (2005). Web services: what’s real and what’s not? IT Professional, 7(2), 14-21. doi:10.1109/MITP.2005.47. \[Internet\]. \[cited 2010 Nov 30\] Available from: [http://ieeexplore.ieee.org.ezproxy.rice.edu/stamp/stamp.jsp?tp=&arnumber=1425418](http://ieeexplore.ieee.org.ezproxy.rice.edu/stamp/stamp.jsp?tp=&arnumber=1425418)

## Additional Reading

Hansen, MD. SOA Using Java Web Services. Upper Saddle River, NJ: Prentice Hall, 2007. Print.\[cited 2010 Nov 30\]  
(COinS)

Schlimmer JC (2002), Web Services Description Requirements. \[Internet\]. \[cited 2010 Sept 16\] Available from [http://www.w3.org/TR/ws-desc-reqs](http://www.w3.org/TR/ws-desc-reqs)

Sanders DT, Hamilton JA Jr., MacDonald RA. 2008. Supporting a service-oriented architecture. In: Proceedings of the 2008 Spring simulation multiconference (SpringSim ’08). Society for Computer Simulation International, San Diego, CA, USA, 325-334. \[Internet\]. \[cited 2010 Nov 28\] Available from: [http://delivery.acm.org/10.1145/1410000/1400595/p325-sanders.pdf?key1=1400595&key2=5176311921&coll=DL&dl=ACM&CFID=116583772&CFTOKEN=82552286](http://delivery.acm.org/10.1145/1410000/1400595/p325-sanders.pdf?key1=1400595&key2=5176311921&coll=DL&dl=ACM&CFID=116583772&CFTOKEN=82552286)

Sprott, D., Wilkes, L., (2004) Understanding Service-Oriented Architecture CDBI forum .Net Architecgure Center. \[Internet\]. \[cited 2010 Sept 10\] Available from: [http://msdn.microsoft.com/en-us/library/aa480021.aspx](http://msdn.microsoft.com/en-us/library/aa480021.aspx)

Yu, Q., Liu, X., Bouguettaya, A., & Medjahed, B. (2008). Deploying and managing Web services: issues, solutions, and directions. The VLDB Journal, 17(3), 537-572. \[Internet\]. \[cited 2007 Sept 10\] Available from: [http://www.springerlink.com/content/c2k20771767l2502/fulltext.pdf](http://www.springerlink.com/content/c2k20771767l2502/fulltext.pdf)

**Denis Galvin** works for Fondren Library at Rice University where he is the ILS Supervisor. Prior to Rice he worked for the Library at Carnegie Mellon University doing similar work. He enjoys dabbling in anything open source and is always interested in topics on digital preservation.

**Mang Sun** works for Fondren library at Rice University where he is the systems librarian. His main job duties include administrating several library systems including the ILS system and developing in house applications and solutions when needed. Prior to Rice he worked for Saskatchewan Provincial Library in Canada as a systems librarian (information resources specialist). His research interests cover a wide spectrum of library and IT technologies. He got his MLIS degree from Dalhousie University in 2006.
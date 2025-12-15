---
title: "Easing Gently into OpenSRF, Part 1"
source: "https://journal.code4lib.org/articles/3284"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-06-22
created: 2025-01-10
description: "The Open Service Request Framework (or OpenSRF, pronounced \"open surf\") is an inter-application message passing architecture built on XMPP (aka \"jabber\"). The Evergreen open source library system is built on an OpenSRF architecture to support loosely coupled individual components communicating over an OpenSRF messaging bus. This article introduces OpenSRF, demonstrates how to build OpenSRF services [...]"
tags:
  - "clippings"
---
# Easing Gently into OpenSRF, Part 1
Dan Scott

The Open Service Request Framework (or OpenSRF, pronounced “open surf”) is an inter-application message passing architecture built on XMPP (aka “jabber”). The Evergreen open source library system is built on an OpenSRF architecture to support loosely coupled individual components communicating over an OpenSRF messaging bus. This article introduces OpenSRF, demonstrates how to build OpenSRF services through simple code examples, explains the technical foundations on which OpenSRF is built, and evaluates OpenSRF’s value in the context of Evergreen. Part 1 of a 2 part article in this issue.

*An article in two parts.*

## Introducing OpenSRF

OpenSRF is a message routing network that offers scalability and failover support for individual services and entire servers with minimal development and deployment overhead. You can use OpenSRF to build loosely-coupled applications that can be deployed on a single server or on clusters of geographically distributed servers using the same code and minimal configuration changes. Although copyright statements on some of the OpenSRF code date back to Mike Rylander’s original explorations in 2000, Evergreen was the first major application to be developed with, and to take full advantage of, the OpenSRF architecture starting in 2004. The first official release of OpenSRF was 0.1 in February 2005 ([http://evergreen-ils.org/blog/?p=21](http://evergreen-ils.org/blog/?p=21)), but OpenSRF’s development continues a steady pace of enhancement and refinement, with the release of 1.0.0 in October 2008 and the most recent release of 1.2.2 in February 2010.

OpenSRF is a distinct break from the architectural approach used by previous library systems and has more in common with modern Web applications. The traditional “scale-up” approach to serve more transactions is to purchase a server with more CPUs and more RAM, possibly splitting the load between a Web server, a database server, and a business logic server. Evergreen, however, is built on the Open Service Request Framework (OpenSRF) architecture, which firmly embraces the “scale-out” approach of spreading transaction load over cheap commodity servers. The [initial GPLS PINES hardware cluster](http://evergreen-ils.org/blog/?p=56), while certainly impressive, may have offered the misleading impression that Evergreen requires a lot of hardware to run. However, Evergreen and OpenSRF easily scale down to a single server; many Evergreen libraries run their entire library system on a single server, and most OpenSRF and Evergreen development occurs on a virtual machine running on a single laptop or desktop image.

Another common concern is that the flexibility of OpenSRF’s distributed architecture makes it complex to configure and to write new applications. This article demonstrates that OpenSRF itself is an extremely simple architecture on which one can easily build applications of many kinds – not just library applications – and that you can use a number of different languages to call and implement OpenSRF methods with a minimal learning curve. With an application built on OpenSRF, when you identify a bottleneck in your application’s business logic layer, you can adjust the number of the processes serving that particular bottleneck on each of your servers; or if the problem is that your service is resource-hungry, you could add an inexpensive server to your cluster and dedicate it to running that resource-hungry service.

## Programming language support

If you need to develop an entirely new OpenSRF service, you can choose from a number of different languages in which to implement that service. OpenSRF client language bindings have been written for C, Java, JavaScript, Perl, and Python, and service language bindings have been written for C, Perl, and Python. This article uses Perl examples as a lowest common denominator programming language. Writing an OpenSRF binding for another language is a relatively small task if that language offers libraries that support the core technologies on which OpenSRF depends:

- [Extensible Messaging and Presence Protocol](http://tools.ietf.org/html/rfc3920) (XMPP, sometimes referred to as Jabber) – provides the base messaging infrastructure between OpenSRF clients and services
- [JavaScript Object Notation](http://json.org/) (JSON) – serializes the content of each XMPP message in a standardized and concise format
- [memcached](http://memcached.org/) – provides the caching service
- [syslog](http://tools.ietf.org/html/rfc5424) – the standard UNIX logging service

Unfortunately, the [OpenSRF reference documentation](http://evergreen-ils.org/dokuwiki/doku.php?id=osrf-devel:primer), although augmented by the [OpenSRF glossary](http://evergreen-ils.org/dokuwiki/doku.php?id=osrf-devel:terms), blog posts like [the description of OpenSRF and Jabber](http://evergreen-ils.org/blog/?p=36), and even this article, is not a sufficient substitute for a complete specification on which one could implement a language binding. The recommended option for would-be developers of another language binding is to use the Python implementation as the cleanest basis for a port to another language.

## Enough jibber-jabber: writing an OpenSRF service

Imagine an application architecture in which 10 lines of Perl or Python, using the data types native to each language, are enough to implement a method that can then be deployed and invoked seamlessly across hundreds of servers. You have just imagined developing with OpenSRF – it is truly that simple. Under the covers, of course, the OpenSRF language bindings do an incredible amount of work on behalf of the developer. An OpenSRF application consists of one or more OpenSRF services that expose methods: for example, the opensrf.simple-text [demonstration service](http://svn.open-ils.org/trac/OpenSRF/browser/trunk/src/perl/lib/OpenSRF/Application/Demo/SimpleText.pm) exposes the opensrf.simple-text.split() and opensrf.simple-text.reverse() methods. Each method accepts zero or more arguments and returns zero or one results. The data types supported by OpenSRF arguments and results are typical core language data types: strings, numbers, booleans, arrays, and hashes.

To implement a new OpenSRF service, perform the following steps:

1. Include the base OpenSRF support libraries
2. Write the code for each of your OpenSRF methods as separate procedures
3. Register each method
4. Add the service definition to the OpenSRF configuration files

For example, the following code implements an OpenSRF service. The service includes one method named opensrf.simple-text.reverse() that accepts one string as input and returns the reversed version of that string:

```perl
#!/usr/bin/perl

package OpenSRF::Application::Demo::SimpleText;

use strict;

use OpenSRF::Application; use parent qw/OpenSRF::Application/;

sub text_reverse { my ($self , $conn, $text) = @_;

my $reversed_text = scalar reverse($text); return $reversed_text;

}

__PACKAGE__->register_method( method => 'text_reverse', api_name => 'opensrf.simple-text.reverse'

);
```

Ten lines of code, and we have a complete OpenSRF service that exposes a single method and could be deployed quickly on a cluster of servers to meet your application’s ravenous demand for reversed strings! If you’re unfamiliar with Perl, the  
use OpenSRF::Application; use parent qw/OpenSRF::Application/;  
lines tell this package to inherit methods and properties from the OpenSRF::Application module. For example, the call to \_\_PACKAGE\_\_->register\_method() is defined in OpenSRF::Application but due to inheritance is available in this package (named by the special Perl symbol \_\_PACKAGE\_\_ that contains the current package name). The register\_method() procedure is how we introduce a method to the rest of the OpenSRF world.

## Registering a service with the OpenSRF configuration files

Two files control most of the configuration for OpenSRF:

- opensrf.xml contains the configuration for the service itself, as well as a list of which application servers in your OpenSRF cluster should start the service.
- opensrf\_core.xml (often referred to as the “bootstrap configuration” file) contains the OpenSRF networking information, including the XMPP server connection credentials for the public and private routers. You only need to touch this for a new service if the new service needs to be accessible via the public router.

Begin by defining the service itself in opensrf.xml. To register the opensrf.simple-text service, add the following section to the `<apps>` element (corresponding to the XPath /opensrf/default/apps/):

```xml
<apps>
  <opensrf.simple-text>                                                      <!-- <1> -->
    <keepalive>3</keepalive>                                                 <!-- <2> -->
    <stateless>1</stateless>                                                 <!-- <3> -->
    <language>perl</language>                                                <!-- <4> -->
    <implementation>OpenSRF::Application::Demo::SimpleText</implementation>  <!-- <5> -->
    <max_requests>100</max_requests>                                         <!-- <6> -->
    <unix_config>
      <max_requests>1000</max_requests>                                      <!-- <7> -->
      <unix_log>opensrf.simple-text_unix.log</unix_log>                      <!-- <8> -->
      <unix_sock>opensrf.simple-text_unix.sock</unix_sock>                   <!-- <9> -->
      <unix_pid>opensrf.simple-text_unix.pid</unix_pid>                     <!-- <10> -->
      <min_children>5</min_children>                                        <!-- <11> -->
      <max_children>15</max_children>                                       <!-- <12> -->
      <min_spare_children>2</min_spare_children>                            <!-- <13> -->
      <max_spare_children>5</max_spare_children>                            <!-- <14> -->
    </unix_config>
  </opensrf.simple-text>
 
  <!-- other OpenSRF services registered here... -->
</apps>
```

1. The element name is the name that the OpenSRF control scripts use to refer to the service.
2. The `<keepalive>` element specifies the interval (in seconds) between checks to determine if the service is still running.
3. The `<stateless>` element specifies whether OpenSRF clients can call methods from this service without first having to create a connection to a specific service backend process for that service. If the value is 1, then the client can simply issue a request and the router will forward the request to an available service and the result will be returned directly to the client.
4. The `<language>` element specifies the programming language in which the service is implemented.
5. The `<implementation>` element specifies the name of the library or module in which the service is implemented.
6. (C implementations only): The `<max_requests>` element, as a direct child of the service element name, specifies the maximum number of requests a process serves before it is killed and replaced by a new process.
7. (Perl implementations only): The` <max_requests>` element, as a direct child of the `<unix_config>` element, specifies the maximum number of requests a process serves before it is killed and replaced by a new process.
8. The `<unix\_log>` element specifies the name of the log file for language-specific log messages such as syntax warnings.
9. The `<unix\_sock>` element specifies the name of the UNIX socket used for inter-process communications.
10. The `<unix\_pid>` element specifies the name of the PID file for the master process for the service.
11. The `<min\_children>` element specifies the minimum number of child processes that should be running at any given time.
12. The `<max\_children>` element specifies the maximum number of child processes that should be running at any given time.
13. The `<min\_spare\_children>` element specifies the minimum number of idle child processes that should be available to handle incoming requests. If there are fewer than this number of spare child processes, new processes will be spawned.
14. The\``<max\_spare\_children>`\` element specifies the maximum number of idle child processes that should be available to handle incoming requests. If there are more than this number of spare child processes, the extra processes will be killed.

To make the service accessible via the public router, you must also edit the opensrf\_core.xml configuration file to add the service to the list of publicly accessible services:

#### Making a service publicly accessible in opensrf\_core.xml

```xml
<router>                                                                     <!-- <1> -->
    <!-- This is the public router. On this router, we only register applications
     which should be accessible to everyone on the opensrf network -->
    <name>router</name>
    <domain>public.localhost</domain>                                        <!-- <2> -->
    <services>
        <service>opensrf.math</service>
        <service>opensrf.simple-text</service>                               <!-- <3> -->
    </services>
</router>
```

1. This section of the opensrf\_core.xml file is located at XPath /config/opensrf/routers/.
2. public.localhost is the canonical public router domain in the OpenSRF installation instructions.
3. Each `<service>` element contained in the `<services>` element offers their services via the public router as well as the private router.

Once you have defined the new service, you must restart the OpenSRF Router to retrieve the new configuration and start or restart the service itself.

Complete working examples of the [opensrf\_core.xml](https://journal.code4lib.org/articles/#opensrf-core-xml) and [opensrf.xml](https://journal.code4lib.org/articles/#opensrf-xml) configuration files are included with this article for your reference.

## Calling an OpenSRF method

OpenSRF clients in any supported language can invoke OpenSRF services in any supported language. So let’s see a few examples of how we can call our fancy new opensrf.simple-text.reverse() method:

#### Calling OpenSRF methods from the srfsh client

srfsh is a command-line tool installed with OpenSRF that you can use to call OpenSRF methods. To call an OpenSRF method, issue the request command and pass the OpenSRF service and method name as the first two arguments; then pass one or more JSON objects delimited by commas as the arguments to the method being invoked.

The following example calls the opensrf.simple-text.reverse method of the opensrf.simple-text OpenSRF service, passing the string "foobar" as the only method argument:

```
$ srfsh
srfsh # request opensrf.simple-text opensrf.simple-text.reverse "foobar"

Received Data: "raboof"

=------------------------------------
Request Completed Successfully
Request Time in seconds: 0.016718
=------------------------------------
```

#### Getting documentation for OpenSRF methods from the srfsh client

The srfsh client also gives you command-line access to retrieving metadata about OpenSRF services and methods. For a given OpenSRF method, for example, you can retrieve information such as the minimum number of required arguments, the data type and a description of each argument, the package or library in which the method is implemented, and a description of the method. To retrieve the documentation for an opensrf method from srfsh, issue the introspect command, followed by the name of the OpenSRF service and (optionally) the name of the OpenSRF method. If you do not pass a method name to the introspect command, srfsh lists all of the methods offered by the service. If you pass a partial method name, srfsh lists all of the methods that match that portion of the method name.

| Note | The quality and availability of the descriptive information for each method depends on the developer to register the method with complete and accurate information. The quality varies across the set of OpenSRF and Evergreen APIs, although some effort is being put towards improving the state of the internal documentation. |
| --- | --- |

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31 | `srfsh``# introspect opensrf.simple-text "opensrf.simple-text.reverse"`  `--> opensrf.simple-text`  `Received Data: {`  `"__c"``:``"opensrf.simple-text"``,`  `"__p"``:{`  `"api_level"``:1,`  `"stream"``:0,                                                      \` `# <1>`  `"object_hint"``:``"OpenSRF_Application_Demo_SimpleText"``,`  `"remote"``:0,`  `"package"``:``"OpenSRF::Application::Demo::SimpleText"``,              \` `# <2>`  `"api_name"``:``"opensrf.simple-text.reverse"``,                        \` `# <3>`  `"server_class"``:``"opensrf.simple-text"``,`  `"signature"``:{                                                    \` `# <4>`  `"params"``:[                                                     \` `# <5>`  `{`  `"desc"``:``"The string to reverse"``,`  `"name"``:``"text"``,`  `"type"``:``"string"`  `}`  `],`  `"desc"``:``"Returns the input string in reverse order\n"``,          \` `# <6>`  `"return"``:{                                                     \` `# <7>`  `"desc"``:``"Returns the input string in reverse order"``,`  `"type"``:``"string"`  `}`  `},`  `"method"``:``"text_reverse"``,                                         \` `# <8>`  `"argc"``:1                                                         \` `# <9>`  `}`  `}` |
| --- | --- |

1. stream denotes whether the method supports streaming responses or not.
2. package identifies which package or library implements the method.
3. api\_name identifies the name of the OpenSRF method.
4. signature is a hash that describes the parameters for the method.
5. params is an array of hashes describing each parameter in the method; each parameter has a description (desc), name (name), and type (type).
6. desc is a string that describes the method itself.
7. return is a hash that describes the return value for the method; it contains a description of the return value (desc) and the type of the returned value (type).
8. method identifies the name of the function or method in the source implementation.
9. argc is an integer describing the minimum number of arguments that must be passed to this method.

#### Calling OpenSRF methods from Perl applications

To call an OpenSRF method from Perl, you must connect to the OpenSRF service, issue the request to the method, and then retrieve the results.

```
#/usr/bin/perl
use strict;
use OpenSRF::AppSession;
use OpenSRF::System;

OpenSRF::System->bootstrap_client(config_file => '/openils/conf/opensrf_core.xml'); # <1>

my $session = OpenSRF::AppSession->create("opensrf.simple-text");                   # <2>

print "substring: Accepts a string and a number as input, returns a string\n";
my $result = $session->request("opensrf.simple-text.substring", "foobar", 3);       # <3>
my $request = $result->gather();                                                    # <4>
print "Substring: $request\n\n";

print "split: Accepts two strings as input, returns an array of strings\n";
$request = $session->request("opensrf.simple-text.split", "This is a test", " ");   # <5>
my $output = "Split: [";
my $element;
while ($element = $request->recv()) {                                               # <6>
    $output .= $element->content . ", ";                                            # <7>
}
$output =~ s/, $/]/;
print $output . "\n\n";

print "statistics: Accepts an array of strings as input, returns a hash\n";
my @many_strings = [
    "First I think I'll have breakfast",
    "Then I think that lunch would be nice",
    "And then seventy desserts to finish off the day"
];

$result = $session->request("opensrf.simple-text.statistics", @many_strings);       # <8>
$request = $result->gather();                                                       # <9>
print "Length: " . $result->{'length'} . "\n";
print "Word count: " . $result->{'word_count'} . "\n";

$session->disconnect();                                                             # <10>
```

1. The OpenSRF::System->bootstrap\_client() method reads the OpenSRF configuration information from the indicated file and creates an XMPP client connection based on that information.
2. The OpenSRF::AppSession->create() method accepts one argument – the name of the OpenSRF service to which you want to want to make one or more requests – and returns an object prepared to use the client connection to make those requests.
3. The OpenSRF::AppSession->request() method accepts a minimum of one argument – the name of the OpenSRF method to which you want to make a request – followed by zero or more arguments to pass to the OpenSRF method as input values. This example passes a string and an integer to the opensrf.simple-text.substring method defined by the opensrf.simple-text OpenSRF service.
4. The gather() method, called on the result object returned by the request() method, iterates over all of the possible results from the result object and returns a single variable.
5. This request() call passes two strings to the opensrf.simple-text.split method defined by the opensrf.simple-text OpenSRF service and returns (via gather()) a reference to an array of results.
6. The opensrf.simple-text.split() method is a streaming method that returns an array of results with one element per recv() call on the result object. We could use the gather() method to retrieve all of the results in a single array reference, but instead we simply iterate over the result variable until there are no more results to retrieve.
7. While the gather() convenience method returns only the content of the complete set of results for a given request, the recv() method returns an OpenSRF result object with status, statusCode, and content fields as we saw in [the HTTP results example](https://journal.code4lib.org/articles/#OpenSRFOverHTTP).
8. This request() call passes an array to the opensrf.simple-text.statistics method defined by the opensrf.simple-text OpenSRF service.
9. The result object returns a hash reference via gather(). The hash contains the length and word\_count keys we defined in the method.
10. The OpenSRF::AppSession->disconnect() method closes the XMPP client connection and cleans up resources associated with the session.

## Accepting and returning more interesting data types

Of course, the example of accepting a single string and returning a single string is not very interesting. In real life, our applications tend to pass around multiple arguments, including arrays and hashes. Fortunately, OpenSRF makes that easy to deal with; in Perl, for example, returning a reference to the data type does the right thing. In the following example of a method that returns a list, we accept two arguments of type string: the string to be split, and the delimiter that should be used to split the string.

#### Basic text splitting method

```
 sub text_split {
    my $self = shift;
    my $conn = shift;
    my $text = shift;
    my $delimiter = shift || ' ';

    my @split_text = split $delimiter, $text;
    return \@split_text;
}

__PACKAGE__->register_method(
    method    => 'text_split',
    api_name  => 'opensrf.simple-text.split'
);
```

We simply return a reference to the list, and OpenSRF does the rest of the work for us to convert the data into the language-independent format that is then returned to the caller. As a caller of a given method, you must rely on the documentation used to register to determine the data structures – if the developer has added the appropriate documentation.

## Accepting and returning Evergreen objects

OpenSRF is agnostic about objects; its role is to pass JSON back and forth between OpenSRF clients and services, and it allows the specific clients and services to define their own semantics for the JSON structures. On top of that infrastructure, Evergreen offers the fieldmapper: an object-relational mapper that provides a complete definition of all objects, their properties, their relationships to other objects, the permissions required to create, read, update, or delete objects of that type, and the database table or view on which they are based.

The Evergreen fieldmapper offers a great deal of convenience for working with complex system objects beyond the basic mapping of classes to database schemas. Although the result is passed over the wire as a JSON object containing the indicated fields, fieldmapper-aware clients then turn those JSON objects into native objects with setter / getter methods for each field.

All of this metadata about Evergreen objects is defined in the fieldmapper configuration file (/openils/conf/fm\_IDL.xml), and access to these classes is provided by the open-ils.cstore, open-ils.pcrud, and open-ils.reporter-store OpenSRF services which parse the fieldmapper configuration file and dynamically register OpenSRF methods for creating, reading, updating, and deleting all of the defined classes.

#### Example fieldmapper class definition for “Open User Summary”

```xml
<class id="mous" controller="open-ils.cstore open-ils.pcrud"
 oils_obj:fieldmapper="money::open_user_summary"
 oils_persist:tablename="money.open_usr_summary"
 reporter:label="Open User Summary">                                       <!-- <1> -->
    <fields oils_persist:primary="usr" oils_persist:sequence="">           <!-- <2> -->
        <field name="balance_owed" reporter:datatype="money" />            <!-- <3> -->
        <field name="total_owed" reporter:datatype="money" />
        <field name="total_paid" reporter:datatype="money" />
        <field name="usr" reporter:datatype="link"/>
    </fields>
    <links>
        <link field="usr" reltype="has_a" key="id" map="" class="au"/>     <!-- <4> -->
    </links>
    <permacrud xmlns="http://open-ils.org/spec/opensrf/IDL/permacrud/v1">  <!-- <5> -->
        <actions>
            <retrieve permission="VIEW_USER">                              <!-- <6> -->
                <context link="usr" field="home_ou"/>                      <!-- <7> -->
            </retrieve>
        </actions>
    </permacrud>
</class>
```

1. The `<class>` element defines the class:
- The id attribute defines the *class hint* that identifies the class both elsewhere in the fieldmapper configuration file, such as in the value of the field attribute of the `<link>` element, and in the JSON object itself when it is instantiated. For example, an “Open User Summary” JSON object would have the top level property of "\_\_c":"mous".
- The controller attribute identifies the services that have direct access to this class. If open-ils.pcrud is not listed, for example, then there is no means to directly access members of this class through a public service.
- The oils\_obj:fieldmapper attribute defines the name of the Perl fieldmapper class that will be dynamically generated to provide setter and getter methods for instances of the class.
- The oils\_persist:tablename attribute identifies the schema name and table name of the database table that stores the data that represents the instances of this class. In this case, the schema is money and the table is open\_usr\_summary.
- The reporter:label attribute defines a human-readable name for the class used in the reporting interface to identify the class. These names are defined in English in the fieldmapper configuration file; however, they are extracted so that they can be translated and served in the user’s language of choice.
2. The `<fields>` element lists all of the fields that belong to the object.
- The oils\_persist:primary attribute identifies the field that acts as the primary key for the object; in this case, the field with the name usr.
- The oils\_persist:sequence attribute identifies the sequence object (if any) in this database and provides values for new instances of this class. In this case, the primary key is defined by a field that is linked to a different table, so no sequence is used to populate these instances.
3. Each `<field>` element defines a single field with the following attributes:
- The name attribute identifies the column name of the field in the underlying database table as well as providing a name for the setter / getter method that can be invoked in the JSON or native version of the object.
- The reporter:datatype attribute defines how the reporter should treat the contents of the field for the purposes of querying and display.
- The reporter:label attribute can be used to provide a human-readable name for each field; without it, the reporter falls back to the value of the nameattribute.
4. The `<links>` element contains a set of zero or more `<link>` elements, each of which defines a relationship between the class being described and another class.
- The field attribute identifies the field named in this class that links to the external class.
- The reltype attribute identifies the kind of relationship between the classes; in the case of has\_a, each value in the usr field is guaranteed to have a corresponding value in the external class.
- The key attribute identifies the name of the field in the external class to which this field links.
- The rarely-used map attribute identifies a second class to which the external class links; it enables this field to define a direct relationship to an external class with one degree of separation, to avoid having to retrieve all of the linked members of an intermediate class just to retrieve the instances from the actual desired target class.
- The class attribute identifies the external class to which this field links.
5. The `<permacrud>` element defines the permissions that must have been granted to a user to operate on instances of this class.
6. The `<retrieve>` element is one of four possible children of the `<actions>` element that define the permissions required for each action: create, retrieve, update, and delete.
- The permission attribute identifies the name of the permission that must have been granted to the user to perform the action.
- The contextfield attribute, if it exists, defines the field in this class that identifies the library within the system for which the user must have prvileges to work. If a user has been granted a given permission, but has not been granted privileges to work at a given library, they can not perform the action at that library.
7. The rarely-used `<context>` element identifies a linked field (link attribute) in this class which links to an external class that holds the field (field attribute) that identifies the library within the system for which the user must have privileges to work.

When you retrieve an instance of a class, you can ask for the result to *flesh* some or all of the linked fields of that class, so that the linked instances are returned embedded directly in your requested instance. In that same request you can ask for the fleshed instances to in turn have their linked fields fleshed. By bundling all of this into a single request and result sequence, you can avoid the network overhead of requiring the client to request the base object, then request each linked object in turn.

You can also iterate over a collection of instances and set the automatically generated isdeleted, isupdated, or isnew properties to indicate that the given instance has been deleted, updated, or created respectively. Evergreen can then act in batch mode over the collection to perform the requested actions on any of the instances that have been flagged for action.

*Article continues, See part two at [http://journal.code4lib.org/articles/3365](https://journal.code4lib.org/articles/3365).*

Dan Scott is the Systems Librarian for Laurentian University and a  committer for the the Evergreen and OpenSRF projects. You can reach  him by email at dan@coffeecode.net or follow his occasional ramblings  at [http://coffeecode.net](http://coffeecode.net/).
---
title: "LibraryH3lp: A New Flexible Chat Reference System"
source: "https://journal.code4lib.org/articles/107"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-09-22
created: 2025-01-10
description: "LibraryH3lp is an integrated IM and web chat system designed specifically for Virtual Reference services in libraries. The software was designed for, and is currently used by, a night-time chat reference collaboraton between several large academic libraries. LibraryH3lp is designed for the workflow of chat reference, supporting multiple simultaneous operators and routing to queues of [...]"
tags:
  - "clippings"
---
# LibraryH3lp: A New Flexible Chat Reference System
Pam Sessoms, Eric Sessoms

LibraryH3lp is an integrated IM and web chat system designed specifically for Virtual Reference services in libraries. The software was designed for, and is currently used by, a night-time chat reference collaboraton between several large academic libraries. LibraryH3lp is designed for the workflow of chat reference, supporting multiple simultaneous operators and routing to queues of operators in a particular service area. It also supports web page embeddable chat ‘widgets’, as well as simultaneous gateways to multiple IM protocols. This article discusses the motivation for the development of the software, and provides an overview of LibraryH3lp’s features and technical architecture. Parts of LibraryH3lp are available as open source. The complete application is available as a low-cost hosted service, and will eventually be available to be licensed for local hosting.

## Introduction

LibraryH3lp is an integrated IM and web chat system designed specifically for Virtual Reference services in libraries.

LibraryH3lp’s evolution has largely been driven by the needs of a night time virtual reference (VR) collaboration between the libraries at Duke University, North Carolina State University, and the University of North Carolina at Chapel Hill. This “Night Owl” chat collaboration began in 2003 and allows the libraries to offer their virtual reference services later in the night by sharing the task of staffing it. During the day, each library staffs its service separately, only answering questions from its own patrons.

Originally, like many libraries around the world, all of the libraries involved in this collaboration offered web chat through a commercial virtual reference provider. Web chat services are offered to patrons visiting the library’s website and typically present the patron with a brief entry form containing fields such as name, e-mail address, and question before the chat begins. While some systems allow patrons to be completely anonymous, patrons are typically not able to bypass the entry form altogether. Commercial web chat systems typically provide features such as administrative reports, transfer of chats among operators, and multiple simultaneous operators to flexibly handle increases in chat volume. The core technical feature that allowed the Night Owl collaboration to succeed was support for multiple simultaneous operators and routing to specific “queues,” such as home institutions or departments.

## Enter IM

In the early-mid 2000’s, many libraries launched very successful IM (Instant Messaging) services for their patrons by registering identities on popular networks like AIM, Yahoo!, MSN and Google Talk. These IM services helped libraries better assist their patrons by integrating the library with the patron’s existing IM network. Rather than remembering to visit the library’s website in order to ask questions, patrons could IM the library directly using their buddy list, where the library could be available in addition to their other IM friends.

By the end of 2005, the libraries involved in the Night Owl collaboration had all developed popular IM services, but they were able to offer them to their patrons only during the daytime. IM software is designed for use by one individual, and it does not support the multiple simultaneous operator and routing to specific queues—features our commercial VR system did. There are a variety of problems associated with staffing a virtual reference service using an IM system for this reason. Busy services requiring more than one librarian at a time to answer questions, or staffing models that involve brief overlap of librarians at shift change, are very difficult to implement because the second login will disconnect the first, or at the very least generate a confusing error message. Staffing IM services during the day at each institution was challenging enough, and extending the IM service into the Night Owl collaboration seemed impossible given the single operator limitation.

During this time, librarians staffing their library’s VR service during the day had to monitor two separate pieces of software: an IM client and the software for the commercial VR system used for web chat. These separate systems had completely different interfaces and features, which made it a bit confusing for the librarians answering questions using both systems. While trying to concentrate on their online reference interview and answering the patron’s actual question, they were also juggling different software packages.

## Enter Meebo Me

Meebo Me widgets became extremely popular for web chat in 2006. Meebo.com is designed to consolidate various IM services as well as provide IM-style chat through a web page widget, Meebo Me, so the user does not need a separate IM client. On the librarian’s end, Meebo Me communications can be monitored using the Meebo.com website or a standard Jabber IM client. Rather than presenting the patron with an initial form (for e-mail address and question, for instance), Meebo Me widgets simply provide a place for the patron to ask their question anonymously ([see attached Figure 1](https://journal.code4lib.org/media/issue4/sessoms/figure01.jpg)). Many libraries saw a sharp increase in their web chats when Meebo Me widgets were put in place.

Meebo.com also provided convenience for librarians by allowing consolidation of standard IM and Meebo Me traffic in one interface. We found Gaim, an open source IM client that later changed its name to Pidgin, particularly useful, especially with a plug-in[\[1\]](https://journal.code4lib.org/articles/#footnote1) developed by one of this paper’s authors, Eric, to provide some changes to Gaim’s handling of Meebo Me specifically useful for VR. However, Meebo is still essentially an IM solution exhibiting the same problems of a one-to-one communications model, rather than supporting multiple operators and queues.

While librarians using Meebo Me widgets rather than a commercial web chat system now only had to monitor one piece of software to handle chat and IM services, those one-to-one limitations continued to make effective staffing a challenge, especially as the services grew and became more popular with patrons. Librarians with busy services tried to compensate in a number of ways. For instance, they might monitor separate protocols using separate accounts. In this way, they could have more than one librarian answering patrons at a time. However, this was only a partial solution because often more than one patron on a given popular protocol showed up simultaneously, and the librarian would have to juggle between them. If the library staffed the service in shifts—for example from staff offices—changing shifts was problematic. Librarians would have to communicate with each other at each shift change to be sure that the second librarian would not disconnect the first librarian from an ongoing chat. If the first librarian had another commitment, such as a meeting, at shift change, it was difficult or impossible for that librarian to extricate him or herself from the chat session so that the second librarian could take over.

Additionally, while very popular, Meebo Me widgets are not without some usability concerns. First, Meebo Me widgets are Flash, and the implementation is not accessible to screen readers used by visually impaired patrons. Second, links sent to the patron by the librarian are not clickable. While patrons can copy and paste these links, this often results in the patron accidentally navigating away from their chat when they paste the link to the same browser window they were using for their chat. However, the success of the core functionality offered by a Meebo Me widget, that of a fast, responsive one-on-one conversation without an entry form barrier, was undeniable.

## Meanwhile, Back at the Ranch…

The libraries in the Night Owl collaboration all had popular daytime-only IM services that could not realistically be offered through the collaboration because of the technical barriers described above. Even by day all of the libraries were struggling with their own in-house IM traffic; they had staff willing to answer the increasing volume of questions, but lacked the technology to do so efficiently. Additionally, use of the commercial web chat system had plateaued, and everyone involved wanted to switch to a widget-based format for web chat to see if usage would increase with the removal of the patrons’ entry form. It was clear that the needs of the service had outgrown the systems in use. Extensive research and testing showed that there were no good technical systems in place that addressed the problem, and it sounded like no one was very far along in building one; development of specialized software was needed. Eric wrote a very modest predecessor to LibraryH3lp that allowed the Night Owl collaboration to move forward.

With the start of the fall semester in 2007, the libraries went live with Pidgin4Lib, Eric’s peer-to-peer solution that first broke down the “one to many” problem plaguing growth of the service by providing support for multiple operators and a queue for each institution. For the first time, the Night Owl collaboration was able to include IM services. All of the institutions also switched to Meebo Me widgets rather than their commercial VR package for web chat. Multiple librarians could be signed in and receive IMs and Meebo Me chats from patrons, and librarians could come and go in shifts without disconnecting each other. Usage statistics increased dramatically. For example, UNC-Chapel Hill’s traffic for the time period covered by the Night Owl collaboration increased 300% over what it had been the previous semester.

However, Pidgin4Lib was constrained by its peer-to-peer architecture; upgrades had to be done on many, many computers across three major University libraries. There were also some bugs that would be difficult or impossible to address within its framework. Two things were clear: we were on the right track, and the system needed to be nearly completely re-written for better scalability.

This was the motivation for the development of LibraryH3lp, the system currently in use by the Night Owl collaboration as well as for regular VR services during the day at all three institutions.

## LibraryH3lp Service, Technical, and Design Goals

We set out to write a system capable of routing and dispatching both web-chat and instant messaging traffic. As a secondary goal, we wanted the system to be able to handle SMS, IRC, and whatever trendy new communication channels should come down the pipeline in the future. In software, it never pays to worry over much about the future—that is usually done at the expense of the present—but some choices are more flexible than others, so we wanted to be aware of the possibilities. These goals led us to seek out a standard platform with a well-defined interface to external systems.

As work on LibraryH3lp was not funded by any library or grant source, another goal was to do as little reinventing the wheel as possible. This led us to look for open-source software solutions that we could build on.

Together these objectives led us to the eXtensible Messaging and Presence Protocol (XMPP, known as “jabber”). XMPP is an open standard with a defined protocol for interfacing to legacy IM protocols such as AIM. There is a wealth of software supporting XMPP, including open-source servers and clients, as well as transports implementing the gateway protocol.

In truth, we never really considered any solution other than XMPP. It fit with our problem so well that even now it is hard to imagine that any other solution could have worked out.

Given our previous experience with Pidgin4Lib, we had a good idea of how LibraryH3lp needed to operate.

### Some of our overall system design goals were to:

1\. Move to a centralized architecture with a web administrative interface.

2\. Provide flexible routing of IMs and web chats to multiple librarian operators.

3\. Limit specialization of locally-installed Jabber clients such as Pidgin to plugins if possible (do not fork the main program).

4\. Eventually provide a centralized web client for more extensive Jabber client customization.

5\. Place the design and management of a VR service in the hands of the local administrators.

6\. Allow easy creation and deletion of queues with assignment of one or more operators to each queue. For example: Reference, Circulation, Youth Services, etc.

7\. Provide internal IM functionality for inter-librarian communication.

8\. Provide the ability to transfer any chat or IM to other librarians under the same “administrative domain” (such as a University or larger collative environment).

9\. Provide hierarchical permissions in the system to facilitate collaborative services that span multiple institutions, such as needed by the Night Owl collaboration.

### For our web chat widget, some of our goals were:

1\. Allow web page authors to easily either embed the web chat widget or have it pop-up from an image or link of their own design.

2\. Develop a Presence API so that web page authors can creatively assign dynamic behaviors based on whether a chat queue is online or offline.

3\. Have typing notification for web chats since it helps the conversation flow so nicely in IMs.

4\. Strive for accessibility for users of screen readers.

5\. Make links sent to the patron clickable for usability.

6\. Empower patrons as much as possible by providing convenient features such as pop out, send file, e-mail transcript, and alert noise.

## LibraryH3lp Overview

We are successfully meeting these goals by developing LibraryH3lp. LibraryH3lp has evolved into a large system, and it is continuing to improve, with frequent updates. This overview section will describe many of its features, and the next section will describe the underlying technology.

### Accounts, queues, and gateways

Librarians in charge of running VR services get started with LibraryH3lp by registering an admin account on the libraryh3lp.com website. This account is used to create additional user accounts ([see attached Figure 2](https://journal.code4lib.org/media/issue4/sessoms/figure02.jpg)) and queues. The main admin account and the user accounts are Jabber accounts that can be used to staff the service in addition to being used on the LibraryH3lp website for various purposes. Users can be assigned to zero or more queues to receive incoming chats from patrons. Users assigned to zero queues can still be buddied with other operators to facilitate back office communications, and they can receive transferred chats from other operators in the same administrative domain.

Queues (see Figure 3 and 4) are a central part of LibraryH3lp. They can be easily created and deleted, and they serve as a way to connect patrons to the most appropriate librarian for their question. A queue’s name is specified when creating a web chat widget, and patron traffic coming into a widget is thereby routed to the librarians assigned to the specified queue. Most libraries will have at least a general Ask-a-Librarian queue. Specialized queues can also be created for other departments, such as Circulation; services, such as assistance with tools such as EndNote or RefWorks; or areas of subject expertise, such as Literature or History. Queues are online if at least one operator assigned to the queue is available.

IM gateways are integrated at the queue level. The admin enters the IM identity’s credentials, which are stored in a database and passed off to the home service (such as AOL, Yahoo!, or Google) for login when a queue changes to online status (see Figure 5). In this way, the one-to-many problem with staffing an IM service is overcome. All of the librarians online for a queue will receive the IMs on its gateways; librarians will not disconnect each other at shift change.

Also at the queue level, administrators can opt into storing their transcripts on the LibraryH3lp server (see Figure 6). By default, transcript storage is turned off. The admin interface includes detailed call history management. This allows administrators to save call histories to a CSV file, to sort by a number of different criteria including queue, protocol, and operator, and to manage their transcripts. Administrators can quickly see chat duration, how long a patron waited before being answered, and chats that went unanswered. Transcripts can be deleted or downloaded in bulk; it is also possible to delete entire call histories, which deletes not just the transcript but the full record of the chat.

### Jabber client, incoming messages, and transfers

Now that we’ve seen a bit of the admin side and system setup, we will look at what librarians working with patrons see.

Librarians use a Jabber client such as Pidgin to monitor their services.[\[2\]](https://journal.code4lib.org/articles/#footnote2 "reference2") They can also use their client to IM other librarians on the LibraryH3lp system. Pidgin is a multi-protocol client which allows users to also simultaneously monitor their own personal IM accounts on other systems, such as AIM. We provide a custom LibraryH3lp plugin for Pidgin that enables additional functionality not available to other clients.[\[3\]](https://journal.code4lib.org/articles/#footnote3 "reference3") A full-featured web client is in the works.

When a patron sends a chat using a widget, or a patron sends an IM to an account registered with a gateway, the chat is received as an IM in the librarian’s Jabber client. If more than one librarian for a queue is online, they will all receive the incoming messages for that queue, but only the first to send a response to the patron will become connected to the patron. The others will be disconnected from that patron and will receive a message indicating which librarian took the chat.

Incoming messages are comprised of three lines of text (see Figure 8):

1\. The patron’s message.

2\. A note stating which queue the patron used to enter the system. This provides helpful contextual information for the librarian.

3\. A link to the LibraryH3lp website for managing that specific chat, for example, by transferring it to another operator or queue.

The system also sends a number of useful messages to librarians under various circumstances. First, when more than one librarian is online for a queue, the librarians who did not respond to the patron first, and thereby do not become connected to the patron, receive notification of which librarian DID successfully answer the chat. Next, when patrons using the LibraryH3lp web chat widget close their window or navigate away from a page containing an embedded widget, librarians are notified that the patron has “left the conversation.” Last, if a message fails to make its way to the patron, the librarian receives “message not received;” this usually happens when an IM patron has signed out of their account or the librarian tries to send a message to a patron that has already navigated away from their web chat.

Many chat and IM sessions can be handled entirely within the Jabber client, by sending messages and links back and forth. Sometimes the librarian may need to perform more advanced tasks, and the “chat management” link sent as the third line of the chat facilitates these tasks by taking the librarian to a web page providing several additional features (see Figure 9). Once signed into the website, the librarian can transfer the chat to another queue or individual in the same administrative domain, send a file to the patron, e-mail a transcript, or view any previous chats from this patron, assuming transcripts have been turned on for that queue. Repeat IM patrons receive a stable guest ID number, and it is possible to read transcripts from any stored earlier session with that patron. Patrons on web chats are identified by an anonymous guest ID number stored in a session cookie, so these returning patrons can only be identified for the duration of their browser session.

[![](https://journal.code4lib.org/media/issue4/sessoms/thumb/tfigure09.png)](https://journal.code4lib.org/media/issue4/sessoms/figure09.jpg)

[Figure 9: Chat management page with transfer, e-mail transcript, and send file options.](https://journal.code4lib.org/media/issue4/sessoms/figure09.jpg)

### The Widget, Presence API, and Web Pages

The patrons’ widget is simple to use, and it provides typing notification for both the patron and the librarian. Links sent to the patron are clickable and open in a new window or tab, depending on the patron’s web browser. It provides a number of advanced features as well. Currently, patron widget controls include:

1\. “Pop out” an embedded widget. Many embedded widgets tend to be very small because of limited real estate on web pages. It can be very difficult to follow a detailed chat conversation in a small widget because of the scrolling required. Once popped out, widgets can be easily resized by the patron, who can then toggle between their chat and the research they are conducting.

2\. Send a file to the librarian. This can be helpful when the patron needs to show the librarian a problem they are having with a bibliographic citation or with a bad PDF from a library database.

3\. Send an e-mail transcript of the chat. This saves the patron from needing to copy and paste the text of their chat into an e-mail or text file in order to refer to it later.

4\. Toggle an alert noise for new messages from the librarian. This helps the patron alternate between their chat and their research since they don’t have to keep checking back for new messages from the librarian.

The widget is highly customizable, and the LibraryH3lp administrative interface includes a tool called the Configurator that allows WYSIWYG editing of widgets. It is also possible to provide customized CSS to change a widget’s appearance. The graphical appearance can be stored on the server and referenced in web pages, and these skins can be shared with other LibraryH3lp users.

Internationalization and localization, to display text in the widget in the language indicated as preferred in the patron’s web browser, are also available (see Figure 10). Currently, translations are available for Czech, French, and Spanish, and we will install additional translations provided to us.[\[4\]](https://journal.code4lib.org/articles/#footnote4 "reference4")

[![](https://journal.code4lib.org/media/issue4/sessoms/thumb/tfigure10.png)](https://journal.code4lib.org/media/issue4/sessoms/figure10.jpg)

[Figure 10: Patrons’ widget illustrating Czech localization and patron control icons.](https://journal.code4lib.org/media/issue4/sessoms/figure10.jpg)

LibraryH3lp provides a presence API that allows a great deal of customization of a service. It is very easy to present a widget when a queue is online, and when it is offline, present something else entirely, such as an e-mail form or an entry point into a 24/7 backup service (see Figures 11a and 11b). The administrative interface includes a tool called the Servinator that assists with generation of HTML skeletons using the API. Using the Servinator, it is easy to create code for embedded widgets or pop-up widgets (see Figure 12), and it is easy to create HTML that produces tiered service levels. For instance, a tiered service level might show a subject expert queue’s widget if they are online, but if they are not, will show the general reference desk queue’s widget; if the general reference desk is offline as well, an offline option can be specified (see Figure 13). Because HTML is generated, it is very easy to modify the skeleton code provided in order to give the patron contextual information that will help set service expectations.

## Code: Getting Started

There are a number of free, open-source XMPP servers available.[\[5\]](https://journal.code4lib.org/articles/#footnote5 "reference5") Like many open-source efforts, XMPP server implementations are available in a variety of languages and vary in their degree of completeness, correctness, and dependability. The two most featureful servers available when we started this project were Ejabberd by Process One and Openfire by Jive Software.

Ejabberd and Openfire have more-or-less equivalent functionality, and both are open source. They differ primarily in that Openfire is written in Java and Ejabberd is written in Erlang (thus, the Erlang Jabber Daemon). The Erlang language is initially shocking to some programmers, as it lacks many basic things most programmers take for granted, such as loops, variables, and assignment. It also lacks static typing, type declarations, classes and objects, thread synchronization primitives, fancy graphical integrated development environments, and armies of overpriced consultants.

The two servers also differ in that Ejabberd is written in only about 40,000 lines of code where Openfire requires 200,000. Ejabberd is faster, supports more simultaneous users on the same hardware, and has built-in support for clustering which the open-source Openfire lacks. Clustering is important for scalability and reliability. Openfire is a bit easier to setup and install.

We owe most of our success to picking the Erlang option.

### Erlang

Erlang is a soft real-time programming language developed by Ericsson in the 80s for telecommunications applications. Ericsson developed the language because nothing else available at the time fit the needs of their applications. Erlang is named for the Danish mathematician A.K. Erlang, not the company Ericsson.[\[6\]](https://journal.code4lib.org/articles/#footnote6 "reference6") Erlang is known primarily for its performance, scalability, and famous “nine-9s” of uptime.[\[7\]](https://journal.code4lib.org/articles/#footnote7 "reference7")

Like many of the more successful programming languages, Erlang is built around a small set of core concepts. Erlang is designed for fault-tolerance and reliability, and most features of the language flow naturally out of this choice:

- *Hot code swapping*. Code can be added to, removed from, or replaced in an Erlang system at run-time, with no restart needed. Versioning of executable modules is built-in.
- *Distributed computing*. An immediate consequence of designing for fault-tolerance is the need to be able to distribute a program across multiple machines.
- *Networking*. High-performance networking primitives are built into the language as a consequence of the need to distribute computations.
- *Binaries*. To simplify the implementation of networking protocols, Erlang has a powerful built-in syntax for low-level manipulation of bits and bytes.
- *Message-passing concurrency*. Erlang systems support tens of thousands of lightweight threads, leading to a style that has come to be known as “concurrency-oriented programming.”
- *Dynamic typing*. Neither hot code swapping nor message passing concurrency can reach their full potential in a statically-typed system: too much has to be decided up front. An advantage of dynamic systems is that they can grow and change over time.
- *Pattern matching*. A syntactic feature borrowed from Prolog, pattern matching greatly simplifies many types of code.
- *Immutability*. Lacking data synchronization primitives, Erlang needs to avoid all the problems that can arise when multiple threads of execution modify the same data. It does this by keeping all data immutable, thus there is no assignment in the language.
- *Functional programming*. Having thrown out mutable data and assignment, many other language features cease to make sense, including primitive things like control structures (that is, loops: for, while, do/until). While functional programming is usually described in terms of negatives—what the language doesn’t have—in practice it has many advantages over procedural programming [\[7a\].](https://journal.code4lib.org/articles/#footnote7a "reference7a") A practical consequence in Erlang is that *code*, not merely data, can be sent around the network to run on different compute nodes. This opens up all kinds of exciting options, one of which is…
- *Distributed transactional database*. A program that doesn’t modify any data isn’t useful for much other than generating heat from the CPU. Erlang comes bundled with a distributed (non-relational) database system called Mnesia that allows for persistence. It has built-in support for replicated tables (for reliability and speed of reading) as well as fragmented tables (for speed of writing) to handle most of the database needs of any Erlang program.

All of these features are relevant and contribute quite directly to the implementation of an XMPP server. They go a long way to account for the success of Ejabberd, and provide a great foundation for the LibraryH3lp system.

We want to emphasize, however, that the reason we picked Erlang, and by extension Ejabberd, was its support for functional programming. All those other great features are just gravy.

### Functional Programming

It is a given that one should always program at the highest level of abstraction available. Greater abstraction leads to less code and better organization. Less, better organized code is easier to understand, maintain, test, and debug. Functional programming provides new tools for abstraction that are not available in procedural languages.

Antecdotally, functional programmers often report a factor of 10 improvement in speed of development and size of the developed system in comparison to procedural programmers. In a study conducted by Ericsson, Erlang was found to have a factor of 4 edge over other languages.[\[8\]](https://journal.code4lib.org/articles/#footnote8 "reference8")

In the case of Ejabberd, we can see that the resulting program is 1/5th the size of its nearest compettitor, but is faster, more scalable, and more reliable. (The speed comes not from the intrinsic speed of the Erlang byte-code intepreter, but from Erlang’s lightweight threads and high-performance networking.)

All of this means two things that very directly impacted the LibraryH3lp project:

1. We found Ejabberd to be a well-crafted, modular, easily extensible system. It was obviously written by experienced, capable software engineers who took advantage of the organizational possibilites offered by the language.
2. The productivity boost offered by the language meant that it was possible and realistic for one programmer to do interesting and useful work.

## LibraryH3lp Technical Architecture

We will begin by briefly recapping the features described above in the overview section in more technical terms. To staff the system and receive chats, librarians log into the Ejabberd server using their Jabber client. We provide a plugin[\[9\]](https://journal.code4lib.org/articles/#footnote9 "reference9") for the Pidgin multi-protocol client that enables additional functionality not available to other clients.

When it is necessary to access additional functionality beyond messaging, as when setting up the system or dealing with exceptional situations, librarians can log into the web site using any standards-compliant browser to review transcripts, transfer chats, and send files to patrons. Additionally, VR administrators can use the web site to generate reports, monitor their queues and librarians, and see chat traffic in real-time. The web site communicates with the jabber server both directly, using Erlang’s native remote procedure call mechanism, and indirectly through the shared Mnesia database.

Patrons can enter the system in two ways. IM patrons talk to gateways using their protocol of choice, and the gateways translate their traffic into XMPP packets and forward them on to the jabber server, where LibraryH3lp takes over. Web patrons start with a chat widget generated by the web server, which then proxies their communication with the jabber server. The widget natively speaks XMPP, and so does not go through any translation; the proxying is simply there to work around browser security policies preventing cross-site scripting (talking to two ports on the same server is, unfortunately, “cross-site” to most browsers).

Figure 14 provides an overview of the architecture of a single LibraryH3lp server.

![](https://journal.code4lib.org/media/issue4/sessoms/figure14.jpg)

Figure 14: Internals of a single LibraryH3lp server.

### Ejabberd and custom extension

The core of LibraryH3lp is a flexible and intelligent routing system written as an extension module to Ejabberd. By writing the routing piece at this level, we are guaranteed to handle not only web-chat traffic, but also instant messaging and whatever other communication mechanisms can be gatewayed into XMPP.

To interface with non-XMPP instant messaging systems, we originally used the py-transports family of gateways. We have since developed a libpurple-based multi-protocol gateway (libpurple is the gui-less core of Pidgin) that allows us to connect to and have a presence on any protocol supported by the Pidgin multi-protocol client.[\[10\]](https://journal.code4lib.org/articles/#footnote10 "reference10") This gives us greater reach and breadth than any other chat/IM system.

Certain other decisions followed easily on the decision to base our system on Erlang and Ejabberd.

### Erlyweb MVC framework

Erlyweb is an MVC (model-view-controller) web development framework for Erlang, in the style of Rails or Django. It provides generators for the database access code (model), templates for the view, and a flexible framework for URL routing (controller). We use this to provide libraries with a full-featured administrative interface. The goal of this interface is to allow libraries to have complete control over the services they offer, and to add and change services at any time, in the hope that they will find the best service and staffing model for themselves through experimentation. We do not dictate anything about how libraries use the service.

LibraryH3lp also uses the routing engine to provide RESTful resources in support of programmatic interaction with our server. By adhering to REST design principles, it was very easy to build an API on top of our existing web interface. The possibilities for using this API are open-ended, but one development we are already seeing is the use of scripts to automate common administrative tasks. For example, instead of a VR administrator logging into the web site daily to download transcripts and usage statistics, she can run a simple script that accesses the web site to download the same information and automatically import it into her local reference tracking tools. If the script is in cron, the whole process becomes automated. Erlyweb made it easy to provide this feature.

One of the nicer features of Erlyweb is support for component-oriented development, which aids in the factoring of the server-side code. In my experience with other web-development frameworks, only Rails comes close in terms of maintainability of the code, but Ruby has nothing on Erlang when it comes to performance.

### Yaws Web Server

Erlyweb depends on Yaws (Yet Another Web Server), so that decided our choice of server software. Yaws is an extremely high-performance server that supports many times more concurrent connections than Apache.[\[11\]](https://journal.code4lib.org/articles/#footnote11 "reference11") It is true that Apache and other, newer web servers (nginx) are doing a lot of work on performance, particularly handling massive numbers of simultaneous connections. Yaws was the existence proof that showed this level of performance was possible.

In order to provide real-time response to web users, we ported Erlycomet to Erlyweb (and, thus, Yaws).

Comet refers to a family of strategies for developing “live” web pages. Whereas ajax techniques can be used to make web pages highly responsive to user-interaction, ajax has limitations related to the display of real-time data from the web. The most common ajax technique for live web pages is polling, but this is both slow (because of the polling interval) and high-bandwidth (because you keep polling even though most of the time nothing ever happens). Comet is being developed to work around these limitations.

Comet is still immature, with many people trying many varied approaches, but the most mature take on comet (so far) is the so-called Bayeux protocol. Bayeux is supported by the jQuery and Dojo javascript libraries, and increasingly by server-side components.

Erlycomet is an implementation of the Bayeux protocol for comet. By adhering to a standard, we were able to avoid rolling our own comet implementation in the browser. This saved us a lot of work. Erlycomet allows us to provide a real-time monitoring feature in the admin interface, so that libraries can see and manage their chat traffic in real-time.

The Erlyweb system plays two roles in LibraryH3lp. On the one hand, it provides the administrative interface by which librarians setup and monitor their VR services. On the other, it produces code for the web-chat widget.

### Javacript Jabber Client (JsJaC)

The client-side of the web-chat widget is written in JsJaC (JavaScript Jabber Client), a library that communicates with the server using the XMPP BOSH (Bidirectional-streams Over Synchronous HTTP) protocol. BOSH is a comet-style protocol that allows us to avoid polling. BOSH keeps the web chat fast and responsive while at the same time reducing server load.

Glue code in the client is written in jQuery, a lightweight javascript library. We made every effort to comply with all applicable standards in the development of the widget: it’s XHTML with CSS and JavaScript only. This has resulted in an application that works with screen readers. It has also yielded what we like to call “the hackable widget”, as it is very easy for libraries to customize the chat however they desire. There is no LibraryH3lp branding in the widget, leaving libraries free to fully make their widgets their own.

We are working on a system to allow libraries to host the widget themselves, so they can do even more extensive customizations.

## Conclusion

As of this writing, approximately 30 libraries[\[12\]](https://journal.code4lib.org/articles/#footnote12 "reference12") are staffing over 60 queues, and there is an average of 150 chats per day on the system as a whole. However, we anticipate a large increase in traffic with the fall academic semester. To prepare for this load, we have already started migrating parts of the system to Amazon’s Elastic Compute Cloud (EC2) (see Figure 15).

Current projects include adding additional gateway protocols, creating features to support larger-scale collaborative services, creating a web client for librarians staffing the service, and improving the local administrator’s interface by providing additional tools for reporting, including basic automated anonymization of transcripts.

LibraryH3lp is built on a foundation of open source projects, and we have in turn released a number of components back to the open source community. So far, these include the full web chat widget, a port of ErlyComet to ErlyWeb, the plugin for Pidgin, and patches to Ejabberd, Yaws, and pyTransports.[\[13\]](https://journal.code4lib.org/articles/#footnote13 "reference13") We plan to release more components soon, including our libpurple multi-protocol gateway.

Those interested in testing LibraryH3lp can freely register for an admin account at [http://libraryh3lp.com/](http://libraryh3lp.com/). To help keep the system sustainable, Nub Games, Inc., the company funding LibraryH3lp’s development and providing LibraryH3lp’s professional web hosting, has always planned to begin implementing a modest annual hosting fee once a useful set of features was in place; this should happen this fall.[\[14\]](https://journal.code4lib.org/articles/#footnote14 "reference14") Libraries can freely experiment with the system for a trial period, with the hosting fee required if a library finds LibraryH3lp to be a suitable solution for production services.

Eventually, most of the system, with the exception of the routing component, will be open-sourced under the GNU Affero General Public License version 3 (AGPL3). It will be possible to license the routing component as a binary, and interested parties should contact Nub Games, Inc. Those interested in running a complete LibraryH3lp system on their own hardware will also be able to purchase licensing and support from Nub Games, Inc.

  
LibraryH3lp was written to address the needs of real, working librarians who were struggling with using the existing tools while striving to expand their growing services. We certainly did not originally set out to write a fully-featured VR system, but that is how the project has evolved. In sum, we hope we are producing a platform for freedom and creativity in the provision of virtual reference services. We strive to take the technical limitations out of the way so that librarians can concentrate on the best way to provide services to their patrons.

## More about LibraryH3lp

[http://libraryh3lp.com/](http://libraryh3lp.com/) Main site.

[http://groups.google.com/group/libraryh3lp](http://groups.google.com/group/libraryh3lp) Group

[http://libraryh3lp.blogspot.com/](http://libraryh3lp.blogspot.com/) Blog

[http://code.google.com/p/libraryh3lp/](http://code.google.com/p/libraryh3lp/) Documentation

![](https://journal.code4lib.org/media/issue4/sessoms/figure15.jpg)

Figure 15: Multi-server architecture for the cloud.

## Notes

[\[1\]](https://journal.code4lib.org/articles/#reference1 "footnote1") Plugin and source code available from [http://www.lib.unc.edu/reference/eref/pidgin/meebomewidget.html](http://www.lib.unc.edu/reference/eref/pidgin/meebomewidget.html)

[\[2\]](https://journal.code4lib.org/articles/#reference2 "footnote2") [http://code.google.com/p/libraryh3lp/wiki/SuitableJabberClients](http://code.google.com/p/libraryh3lp/wiki/SuitableJabberClients)

[\[3\]](https://journal.code4lib.org/articles/#reference3 "footnote3") [http://code.google.com/p/libraryh3lp/wiki/ClientSetupPidgin](http://code.google.com/p/libraryh3lp/wiki/ClientSetupPidgin)

[\[4\]](https://journal.code4lib.org/articles/#reference4 "footnote4") [http://code.google.com/p/libraryh3lp/wiki/Localization\_and\_Internationalization](http://code.google.com/p/libraryh3lp/wiki/Localization_and_Internationalization)

[\[5\]](https://journal.code4lib.org/articles/#reference5 "footnote5") [http://en.wikipedia.org/wiki/List\_of\_Jabber\_server\_software](http://en.wikipedia.org/wiki/List_of_Jabber_server_software)

[\[6\]](https://journal.code4lib.org/articles/#reference6 "footnote6") [http://www.erlang.org/course/history.html](http://www.erlang.org/course/history.html)

[\[7\]](https://journal.code4lib.org/articles/#reference7 "footnote7") [http://www.cincomsmalltalk.com/userblogs/ralph/blogView?entry=3364027251](http://www.cincomsmalltalk.com/userblogs/ralph/blogView?entry=3364027251)

[\[7a\]](https://journal.code4lib.org/articles/#reference7a "footnote7a") [http://www.cs.chalmers.se/~rjmh/Papers/whyfp.html](http://www.cs.chalmers.se/%7Erjmh/Papers/whyfp.html)

[\[8\]](https://journal.code4lib.org/articles/#reference8 "footnote8") [http://www.erlang.se/publications/Ulf\_Wiger.pdf](http://www.erlang.se/publications/Ulf_Wiger.pdf)

[\[9\]](https://journal.code4lib.org/articles/#reference9 "footnote9") [http://code.google.com/p/libraryh3lp/wiki/ClientSetupPidgin](http://code.google.com/p/libraryh3lp/wiki/ClientSetupPidgin)

[\[10\]](https://journal.code4lib.org/articles/#reference10 "footnote10") [http://pidgin.im/](http://pidgin.im/)

[\[11\]](https://journal.code4lib.org/articles/#reference11 "footnote11") [http://www.sics.se/~joe/apachevsyaws.html](http://www.sics.se/~joe/apachevsyaws.html)

[\[12\]](https://journal.code4lib.org/articles/#reference12 "footnote12") Some have listed themselves on the Library Success Wiki: [http://www.libsuccess.org/index.php?title=Online\_Reference#Libraries\_Using\_libraryh3lp\_for\_Embedded\_Chat](http://www.libsuccess.org/index.php?title=Online_Reference#Libraries_Using_libraryh3lp_for_Embedded_Chat)

[\[13\]](https://journal.code4lib.org/articles/#reference13 "footnote13") [http://code.google.com/p/libraryh3lp/wiki/OpenSourceContributions](http://code.google.com/p/libraryh3lp/wiki/OpenSourceContributions)

[\[14\]](https://journal.code4lib.org/articles/#reference14 "footnote14") [http://code.google.com/p/libraryh3lp/wiki/Free\_or\_Fee\_Full\_Disclosure](http://code.google.com/p/libraryh3lp/wiki/Free_or_Fee_Full_Disclosure)

## About the Authors

Pam Sessoms is Electronic Reference Services Librarian at UNC-Chapel Hill’s Davis Library. Her professional interests include virtual reference services, bibliographic management utilities, maintaining access to legacy research databases and software through the use of virtualization software, and providing library services to patrons with disabilities. Pam can be reached at psessoms at gmail dot com.

Eric Sessoms is president of Nub Games, Inc., and is currently Executive Consultant for End-to-End Data Operations for the US National Radio Astronomy Observatory, where he spends his time worrying about astronomical data archiving and virtual observatories. Formerly, he was Chief Software Architect for the NRAO and worked on the Green Bank Telescope, primarily in areas of usability and data reduction. In previous lives, he was Lead Programmer for Sinister Games, Technology Evangelist for Stingray Software, and worked on Microsoft Operations Manager. Eric can be reached at nubgames at gmail dot com.
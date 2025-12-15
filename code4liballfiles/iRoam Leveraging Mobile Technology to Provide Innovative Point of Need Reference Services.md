---
title: "iRoam: Leveraging Mobile Technology to Provide Innovative Point of Need Reference Services"
source: "https://journal.code4lib.org/articles/5038"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-04-11
created: 2025-01-10
description: "The University of Northern British Columbia’s Geoffrey R. Weller Library can boast of a healthy and stable reference service. While statistical analysis reveals that patron use of this service is on the decline, this is not unlike current trends experienced by many libraries today. The library averages a total of 6300 reference transactions per year, [...]"
tags:
  - "clippings"
---
# iRoam: Leveraging Mobile Technology to Provide Innovative Point of Need Reference Services
James R.W. MacDonald, Kealin McCabe

The University of Northern British Columbia’s Geoffrey R. Weller Library can boast of a healthy and stable reference service. While statistical analysis reveals that patron use of this service is on the decline, this is not unlike current trends experienced by many libraries today. The library averages a total of 6300 reference transactions per year, a significant number for a small, research-intensive university serving 3500 FTE. The unanswered question is why are the numbers dropping? One theory is that providing research and reference assistance in a traditional manner is affecting the number of transactions. Reference service is traditionally provided in a stationary manner, whereby patrons are required to visit the reference desk of their own volition. Recognizing that a stationary librarian cannot reach a stationary patron, UNBC library began an innovative roaming reference pilot project in September, 2010. Combining the power of wireless networks, tablet computing and chat services, 5 librarians provided point-of-need, face-to-face and virtual reference services during peak reference hours over the fall 2010 semester. This article outlines the project and technologies employed to make it happen (iPad, apps, instant messaging widgets and wireless networks).

## Introduction

Face-to-face reference transactions at the University of Northern British Columbia’s Geoffrey R. Weller Library have been declining at an average rate of 9.8% annually; conversely virtual reference (VR) transactions have grown an average of 500% per year. The overarching goal of iRoam Roaming Reference was to regain control of our declining reference statistics. Through the promotion and provision of iRoam Roaming Reference, we hoped to increase student awareness of reference services as a whole, while increasing the visibility of librarians and library services at the same time.

This article examines the authors’ technical decisions and chosen components in designing a roaming reference service, including: chat service software, the iPad, apps and wireless networking.

## Reference Services at the Geoffrey R. Weller Library – a Background

Prior to the launch of iRoam in September 2010, the library provided traditional reference services from Monday to Friday from 11am to 6pm and Sundays from 1pm to 5pm. Since 2008 the library has also provided its patrons with access to Virtual Reference (VR) via the provincial chat reference consortium AskAway. Students contact the AskAway service–which is powered by OCLC’s Question Point software–through an HTML-based widget or “qwidget” on the library’s homepage. Just as quickly as they have embraced new technologies, students have embraced VR, so much so that UNBC’s use of the service has increased by over 1000% since its implementation.

In an effort to gain some insight into why our reference desk statistics were on the decline while virtual reference statistics were skyrocketing, it was determined that we needed to take an in-depth look into where our patrons were when accessing the library’s services. Due to privacy restrictions put in place by our consortial chat service, we were unable to analyze patron IP addresses. This information would have provided us with a great deal of data about our patrons’ exact locations on campus, even possibly answer why they increasingly prefer virtual interactions with librarians over face to face. To circumvent this obstacle, a study of the library server logs was undertaken. This study allowed us to see that on average 61% of library page requests over a three year period were placed from somewhere on campus. Given these statistics we began to feel safe in the assumption that roaming reference services would help our stationary librarians reach our stationary patrons.

## What is iRoam?

Fall 2010 marked the launch of iRoam: Roaming Reference using iPads. The library purchased 5 iPads in the summer of 2010 to be used for the purpose of this project. Roaming reference services were offered during our peak reference hours in addition to our traditional reference services. Through the analysis of reference statistics and library server logs, we were able to determine the hours roaming reference should be provided: Monday-Wednesday between 1 and 4pm. During Roaming shifts, librarians would roam the floors of the library and various campus outlets with the goal of assisting students at their point of need.

Roaming the library looking for patrons presents another problem. While a stationary librarian may never reach a stationary student, those with the need for a librarian may have quite a difficult time locating a moving target. Therefore, instant chat services were explored as a means of “paging” the roaming librarian both by students and the library’s circulation and reference desk staff. By providing a chat widget on the library’s website, students could chat with the iPad-carrying librarian. If the student happened to be on campus they could give the librarian their location and the librarian would come to them. If the student was not on campus the librarian would conduct a chat session with the patron using the iPad. Using this model, the service was piloted from September to the end of November, 2010.

## Why the iPad?

Roaming reference service employing tablet computing is not new, as demonstrated in Holly Hibner’s 2005 article describing a roaming reference service using a tablet computer. Until recently tablet computers have been heavy, lacked sufficient battery life and had slow start up times. When Apple announced the launch of its iPad in January 2010 it seemed as though the aforementioned deficiencies would finally be resolved.

At 9.7 inches the screen is larger than most netbooks, but the iPad only weighs approximately 1.5 pounds. An impressive battery life of 10 hours means that forgetting to plug in the iPad after a roaming reference shift does not lead to a dead battery halfway through the next (Apple 2010). The iPad operates much like a smartphone, instantly going from a sleep state to useable at the push of a button, and by utilizing push notifications it can audibly and visually update the librarian of an incoming chat message much like text messaging on a smartphone. All things considered, the iPad appeared engineered to be the reference librarian’s best friend.

Roaming reference service could be delivered using any number of tablet computing devices. At the time of this pilot project the iPad answered concerns about weight, battery life, screen size and price. At just over 500 dollars the iPad will arguably be the least expensive tablet computer for some time (Chen 2011).

## Choosing a Chat Service

The number of chat service software applications available is nearly overwhelming. Among them are the obvious and inexpensive solutions, such as Meebo, Microsoft Messenger, AIM and Google Talk. These types of services are generally free and developed for personal use. As a result, they tend to lack the more robust features found in enterprise software such as chat queues, canned responses, multiple chat operators, chat transcripts and reports. Any chat software used in this project needed three main features: a chat widget from which library patrons could communicate with librarians; an iPad application capable of interfacing with the chat software; and the capacity to have multiple librarians simultaneously monitoring incoming chats requests.

Karen McCoy’s WebJunction online conference presentation, *Implementing Reliable Instant Messaging at Your Library* (2010), ranks chat services into three tiers: bronze, silver and gold. The chat reference software featured in McCoy’s gold level discussion is LibraryH3lp. LibraryH3lp is a chat service designed by and for librarians and offers many of the features found in enterprise level chat software solutions. LibraryH3lp’s greatest value, however, is its software architecture. LibraryH3lp was built on the XMPP or Jabber standard chat protocol which makes it possible to pick from a variety of chat aggregators using the same protocol. In other words, while LibraryH3lp does not have a purpose-built iPad application for sending and receiving chats, there are dozens of chat apps in Apple’s App Store capable of working with LibraryH3lp.

## Selecting the Right Apps

The two essential iPad apps required for this project were a chat application capable of receiving chats over the Jabber protocol and a web browser. The chat application ultimately selected for this project was BeeJive. BeeJive offers a clean and intuitive interface for handling multiple incoming chats, it easily receives messages from a variety of chat services and employs push notifications to inform the librarian of incoming messages. Push notifications appear anytime a patron sends a chat to the librarian when the BeeJive app is not open. As a result the roaming librarian can respond to queries whether they are in another iPad app or have the iPad in sleep mode.

Finding the perfect chat application for this project was difficult. Beejive met the essential requirements for the project but could be greatly improved upon. For example, using BeeJive the librarian cannot transfer patrons to other librarians at the end of a shift. It does not have the ability to capitalize on a canned response feature. Canned responses include simple messages that can be sent to a patron to answer frequently asked questions, such as: How do I login to my account? Or, when is the library open? The addition of these features would greatly improve the librarian’s chatting experience.

Apple’s App Store is a rapidly changing environment (148apps.biz 2011). By the time this article is published there will be thousands of new apps available and possibly improvements to the apps discussed here. At the time of this project there did not appear to be an app available that could take full advantage of all the features of robust chat service software such as Libraryh3lp. There are several enterprise chat software services that provide purpose-built iPad applications; both Liveperson and Bold Chat are good examples. Their suitability for supporting roaming reference services is worth investigating. The combination of BeeJive and LibraryH3lp provides the minimum feature set necessary to support roaming reference services. Finding the perfect combination of chat app and chat software service to support roaming reference clearly requires, short of developing the software in house, further investigation.

The second essential iPad app is the web browser. The librarian needs access to the library catalogue and other online resources. There are a variety of web browsers available for the iPad besides Apple’s Safari browser. At the time of this pilot project the iPad’s Safari browser did not render EBSCO-hosted databases very well. Alternative apps to Safari include: iCab mobile, Life browser, and Perfect Browser. Perfect Browser appears to live up to its name. This app offers tabbed browsing, easy access to bookmarked pages and appears to render library resources such as EBSCO databases very well. As an added bonus, Perfect Browser offers VGA-out support for displaying webpages through a projector, a necessity if librarians wish to use the iPad in classroom instruction. \[[1](https://journal.code4lib.org/articles/#note1)\]

## Connecting with Students Virtually and Face-to-Face

Being a member of the AskAway provincial virtual reference consortium presented a small problem for the roaming reference pilot project. How would patrons respond to an additional chat widget on the library’s homepage? Would there be a general confusion about which chat widget to use? Was there enough real estate on the library’s website to house two widgets? To address these concerns it was decided to present only one chat widget to the library patron at a time. Therefore, when roaming reference was available the consortium widget was removed from the library’s homepage and the roaming widget was added. As a result, all of the library’s chat reference was handled by local roaming reference librarians during roaming service hours: Mondays to Wednesdays from 1pm to 4pm.

Presenting website visitors with the right widget at the right time presented a small technical problem: how to remove and replace the opposing widgets three days a week? The solution was to create an alternate library homepage containing the roaming reference chat widget. The library’s Systems Analyst simply created a server cron job to replace the default library homepage containing the AskAway widget with a page containing the roaming reference widget during the hours the service was available. In this way the library website’s visitors were only ever presented with one chat option but always connected to the most appropriate service.

Since this roaming reference service was simply a pilot project, changing the library homepage worked very well. It did, however, make it necessary to make any updates to the library’s homepage in two places. This method would also be impractical for including the chat widget in more than one place, such as: research guides, databases or other online resources.

## The Wireless Network

While presenting the right widget at the right time is crucial, without a stable wireless network the librarian would never reach a virtual patron. At UNBC, like many other institutions, there are two options for connecting to a wireless network: through a secure virtual private network (VPN), or through a captive portal to an unencrypted open connection. Unfortunately, UNBC was not in a position to support a VPN connection from the iPad to its wireless infrastructure when this project began. Connecting through a captive portal was not a practical option either. Captive portals force a user to login through a web browser before gaining access to the Internet. Anyone with experience using captive portals at airports, hotels, and restaurants recognizes that this method is often unstable and impractical for anything beyond simple web browsing. However, by adding the devices’ MAC addresses to the wireless system’s gateway the iPads could instantly connect to the institution’s unencrypted network. Essentially the wireless router recognizes the device when it attempts to connect and automatically allows the device access. Since the iPad, like many modern WiFi-enabled devices, can remember wireless networks once this relationship is established, the librarian is not required to re-authenticate or take any other special steps to make subsequent connections to the wireless network.

While connecting to the network in this manner is extremely convenient it also comes with some security risk. Traffic being passed over this type of network is unencrypted if the site does not have a valid security certificate. The library, therefore, has taken steps to obtain security certificates for its catalogue and proxy services. UNBC is currently working on deploying an on-campus secure wireless network which bypasses the need for a VPN. Regardless of the state of an institution’s wireless infrastructure, communication between the library and those responsible for the network is essential to the success of a roaming librarian.

## Is the iPad the Reference Librarian’s “Best Friend?”

With all of the hardware and software in place the Geoffrey R. Weller library was prepared for a highly successful service. Unfortunately, the iPad came up lacking in a couple of key areas: multitasking and an app designed to deliver this type of service. When roaming, the iPad was an excellent tool for navigating the library’s catalogue and databases for quick information retrieval. However, extensive searching using a variety of research databases seemed cumbersome on the small touch screen. Roaming librarians reported that they oftentimes found themselves using the patron’s computer or the closest OPAC station if a question required in-depth searching. If the question happened to come through chat, the librarian would be faced with a similar conundrum. Unfortunately, using the closest computer would force the librarian to resort to typing links into the iPad or typing out detailed navigational directions, a time consuming and cumbersome process. Since the iPad did not offer multitasking or “fast app switching,” moving between the chat conversation and the web browser, notepad or other applications resulted in a slowed conversation and may have led to abandoned chats or frustrated librarians and patrons.

By late November, 2010 many of the shortcomings described here were addressed. Apple released an update to their iOS operating system which brought multitasking capacity and “fast app switching” to the iPad. The ability to quickly navigate between the chat application and other iPad apps should alleviate much of the cumbersome navigation experienced during the pilot. Ultimately, a custom-built iPad app supporting canned responses and chat question transfers would go much further in addressing these problems.

Not every librarian using the iPad took to the device equally. There were two unexpected surprises regarding the adoption level of the iPad. In the case of one librarian, considered to be an early technology adopter in most cases, the iPad proved to be the exception. For this librarian pen and paper is still superior to finger and screen. In the other instance a librarian generally reticent to technological change–she is still running Windows XP and Office 2003–appears to have fully adopted the iPad into her routine. Dropbox is a feature of her desktop, emails from her often include the signature “sent from my iPad,” and one can often find her annotating PDFs and creating or editing documents on the iPad.

## Future Directions

The iPad is an exciting new technology which has set an initial standard for tablet computing. This being said, there are a variety of tablet computers appearing on the market. The iPad’s light weight, long battery life and instant-on technology make it almost an ideal tool for roaming reference. However, as these technologies are incorporated into ever thinner and lighter laptop computers the laptop may become the device of choice for this type of service. Apple’s recent release of the Macbook Air is a worthy competitor to the iPad in weight, battery life and instant-on technology. A laptop brings the added advantage of a full keyboard and mouse, which may be more conducive to in-depth searching.

The least expensive option may be to simply use an iPod Touch or a smartphone. A smartphone would add the benefit of cellular data plans, thus bypassing the need for a wireless connection where the wireless infrastructure at an institution is not reliable. This option would work best where the library catalogue and its databases are configured for smartphones \[[2](https://journal.code4lib.org/articles/#note2)\]. As some of the librarians in this project found that they were gravitating toward the nearest OPAC station or the patron’s laptop to answer reference queries, an iPod touch or smartphone may be all that is needed.

## Conclusion

The technology used in this project proved to be an excellent addition to reference services at the Geoffrey R. Weller Library. Roaming reference questions accounted for 8% of all reference questions in the fall 2010 term. This is equivalent to all email and phone reference over the same period. The significance of 8% becomes clear when one realizes that the roaming reference service was only available 9 hours a week compared to 39 hours of regular reference. It has long been argued that a stationary librarian may be missing out on as many as two thirds of library patrons who will not approach the reference desk (Swope, 1972). The results of this roaming reference pilot project appear to substantiate that claim.

While the information landscape is rapidly changing, the traditional reference desk often appears to be an unmovable institution in many academic libraries. As the authors analyze patron feedback and reference statistics a new model of reference services seems to be emerging for the Geoffrey R. Weller Library. In 1984 an article appeared in Collegiate Microcomputer arguing that patrons should have the capacity to communicate with librarians through terminals placed throughout the library (Smith). Nearly 25 years later it appears that all the pieces of technology are finally available to provide such a service in a meaningful way. The authors have plans to continue this project into the winter term. It is hoped that what is learned from this project will help to remodel the way reference services are delivered at the Geoffrey R. Weller Library.

## Notes

[1](https://journal.code4lib.org/articles/#ref1) Requires an Apple 30pin to VGA or DVI connection cable or a 30 pin to HDMI connection cable.

[2](https://journal.code4lib.org/articles/#ref2) Higher end iPad models are also available with 3G cellular data plans.

## References

148Apps.biz \[Internet\]. \[2011\]. Count of active applications in the App Store; \[cited 2011 Mar 25\]. Available from: [http://148apps.biz/app-store-metrics/?mpage=appcount](http://148apps.biz/app-store-metrics/?mpage=appcount)

Apple \[Internet\]. \[2010\]. Markham (On): Apple (Canada) – iPad – Technical specifications and accessories for iPad \[Apple\]; \[cited 2011 Jan 7\]. Available from: [http://www.apple.com/ca/ipad/specs/](http://www.apple.com/ca/ipad/specs/)

Chen, Brian X. Why nobody can match the iPad’s price \[Internet\]. 2011. \[Place of publication unknown\]: Wired, Gadget Lab; \[updated 2011 Feb 18; cited 2011 Mar 25\]. Available from: [http://www.wired.com/gadgetlab/2011/02/ipad-price/](http://www.wired.com/gadgetlab/2011/02/ipad-price/)

Hibner Holly. 2005. The Wireless Librarian: using tablet PCs for ultimate reference and customer service: a case study. Library Hi Tech News. 22(5) 19-22.  
[(COinS)](https://journal.code4lib.org/coins)

McCoy, Karen. Technology Essentials 2010 Online Conference: Implementing reliable instant messaging at your library \[Internet\]. 2010. \[Place of publication unknown\]: WebJunction; \[Updated 2010 Feb 2; Accessed 2010 March 2\]. Available from: [http://www.webjunction.org/conference-tech-essentials-2010/-/articles/content/90952660](http://www.webjunction.org/conference-tech-essentials-2010/-/articles/content/90952660).

Smith, Dana E., Hutton, Steven M. 1984. Back at 8:00 AM – Microcomputer library reference support programs. CollMcmp. 2(4), 289-294.  
[(COinS)](https://journal.code4lib.org/coins)  

Stpeter. About: Jabber.org \[Internet\]. 2009. \[Place of publication unknown\]: Jabber.org; \[updated 2009 Apr 2; cited 2011 Jan 7\]. Available from: [http://www.jabber.org/about/](http://www.jabber.org/about/).

Swope, Mary Jane and Katzer, Jeffrey. 1972. Why don’t they ask questions? Ref Users Serv Q. 12 (2) 161-166.  
[(COinS)](https://journal.code4lib.org/coins)  

## About the Authors

James R.W. MacDonald is the Web Services Librarian at the Geoffrey R. Weller Library, University of Northern British Columbia. His research interests currently focus on usability and the user experience in digital environments.

Kealin McCabe is the Research and Learning Services Librarian at the Geoffrey R. Weller Library, University of Northern British Columbia. She is deeply involved in reference and instruction practices throughout the province and is the winner of the British Columbia Library Association (BCLA) 2011 Academic Librarians in Public Service Award for Outstanding Service.
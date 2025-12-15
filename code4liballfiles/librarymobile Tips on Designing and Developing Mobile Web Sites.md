---
title: "library/mobile: Tips on Designing and Developing Mobile Web Sites"
source: "https://journal.code4lib.org/articles/2055"
author:
  - "[[The Code4Lib Journal]]"
published: 2009-11-23
created: 2025-01-10
description: "Mobile applications can support learning by making library resources more ubiquitous, by bringing new users to the library through increased accessibility to the resources libraries offer, and by creating a new way to enhance connections between patrons and libraries. This increased use of mobile phones provides an untapped resource for delivering library resources to patrons. [...]"
tags:
  - "clippings"
---
# library/mobile: Tips on Designing and Developing Mobile Web Sites

Kim Griggs, Laurie M. Bridges, Hannah Gascho Rempel

Mobile applications can support learning by making library resources more ubiquitous, by bringing new users to the library through increased accessibility to the resources libraries offer, and by creating a new way to enhance connections between patrons and libraries. This increased use of mobile phones provides an untapped resource for delivering library resources to patrons. The mobile Web is the next step for libraries in providing universal access to resources and information. This article will share Oregon State University (OSU) Libraries’ experience creating a mobile Web presence and will provide key design and development strategies for building mobile Web sites.

## Mobile Explosion

Over the past several years at library conferences and in library blogs there has been considerable chatter about mobile technologies; more specifically about mobile phones. While there has been a lot of talk, little work has been done in libraries to make library Web sites easily accessible to the growing number of users who access online via their phones. According to Joan Lippincott, “as with most technology developments, this one is fast-moving. This is not a time to sit on the sidelines as other campus units are developing services for mobile users…” ([2008](https://journal.code4lib.org/articles/#lippincott)).

A Pew Studies Memo from 2008 notes, “58% of adult Americans have used a cell phone or personal digital assistant to do at least one of ten mobile non-voice data activities, such as texting, emailing, taking a picture, looking for maps or directions, or recording a video” ([Horrigan](https://journal.code4lib.org/articles/#horrigan2008)). A 2009 survey by the Pew Research Center’s Internet & American Life Project found “32% of all Americans have gotten online with a mobile device” and 25% of mobile users who are 18-29 years old are accessing the Internet on a typical day ([Horrigan, 2009a, p. 3](https://journal.code4lib.org/articles/#horrigan2009a)). In addition, the July 2008 edition of Library Technology Reports cited that young adults do the following with mobile phones and wireless devices: 74% send or receive text messages, 44% send or receive pictures, 24% send or receive emails, and 23% use instant messaging ([Kroski](https://journal.code4lib.org/articles/#kroski)).

The Pew Research Center’s Project found that 46% of cell phone and wireless laptop users think mobile access is very important for getting online information on the go ([Horrigan, 2009b](https://journal.code4lib.org/articles/#horrigan2009b)). \[Updated, see [correction note](https://journal.code4lib.org/articles/#correction1)\]. “Mobile access facilitates full participation in the flow of online information. For many Americans, always-on, always-available access is a basic part of their lifestyles. They don’t see home broadband access alone as sufficient for their digital needs,” says John B. Horrigan, Associate Director of the Pew Internet Project ([2009c](https://journal.code4lib.org/articles/#horrigan2009c)).

## The Mobile Experience

Sites designed specifically for mobile devices increase usability. Users performing typical tasks with their phones were successful 64% of the time on mobile sites compared to 53% success rates for desktop users on standard websites ([Nielsen, 2009](https://journal.code4lib.org/articles/#neilsen)).  Testers also gave higher subjective satisfaction ratings to mobile sites ([Nielsen, 2009](https://journal.code4lib.org/articles/#neilsen)). Nielsen, a leader in Human-Computer Interaction (HCI) advises that, “if mobile use is important to your Internet strategy, it’s smart to build a dedicated mobile site.”

Similarly, the World Wide Web Consortium (W3C) technical document, Mobile Web Best Practices 1.0 (MWBP), recommends that the mobile experience merits its own design. “Mobile users typically have different interests to users of fixed or desktop devices. They are likely to have more immediate and goal-directed intentions than desktop Web users. Their intentions are often to find out specific pieces of information that are relevant to their context.” ([2008](https://journal.code4lib.org/articles/#rabin)). A use-case scenario for mobile use within the library context is that of a patron who is in the stacks and would like to locate a book listed in the bibliography of a book they have in hand.

A rich mobile experience leverages the context of mobile visitors. There are three important considerations when developing a mobile application:

1. What is the context of the mobile visitor?
2. What are the goals of the mobile visitor?
3. What tasks are they likely and unlikely to do on a mobile device?

Even though mobile devices provide access to various applications, they have limitations such as small screen size, limited screen resolution, and awkward input mechanisms. However, some services and information are more suitable for mobile sites. For example, users are less likely to read lengthy documents or browse content on their mobile device, while location-based services primarily have a mobile appeal. As a result of the differences between desktop and mobile uses, mobile developers need to move beyond shrinking content to fit small screens, and instead use the mobile experience as a new way to connect with patrons.

The Library Technology Report summarizes the functionality of several major university libraries’ mobile Web sites ([Kroski, 2008](https://journal.code4lib.org/articles/#kroski)). According to the Report, the University of Richmond Library offers a catalog search, real-time laptop and PC availability information, and ask-a-librarian services by email, SMS, or IM. University of Virginia Libraries’ mobile Web site provides news and events, information about library exhibitions, directions, library hours, and a text-only version of their entire Web site. Boston University Center Medical Library made mobile versions of their subject guides, and made their e-books, e-journals, databases, and library site searchable. New York University Libraries, with the Arch mobile portal, allows searching of their electronic resources by title, subject, or format, and includes basic library information. Ball State University Libraries’ mobile site offers library patrons a catalog and journal search, videos about the libraries, information about collections, services such as interlibrary loan and course reserves, and quick links to mobile reference Web sites ([West, Hafner, and Faust, 2006](https://journal.code4lib.org/articles/#west)).

Both Innovatice Interfaces, Inc. (III) and Online Computer Library Center (OCLC) have implemented a mobile search application. AirPAC is a III module specially designed for wireless mobile devices. Users can browse the library catalog, check due dates, request materials, and view their patron records using their mobile devices. Examples of libraries that use the AirPAC mobile search include Nashville Public Library, Westerville Public, Cuyahoga Public, Multnomah County Library, Wayne State University, and Hennepin County Library. AirPAC also has an iPhone application. OCLC is currently offering a mobile search application pilot, WorldCat Mobile, ([http://www.worldcat.org/mobile/](http://www.worldcat.org/mobile/)) and an iPhone search app ([http://www.oclc.org/news/announcements/announcement353.htm](http://www.oclc.org/news/announcements/announcement353.htm)). \[Updated, see [correction note](https://journal.code4lib.org/articles/#correction2).\] The OCLC Web site states, “The WorldCat Mobile pilot allows users to search for and find books and other materials available in their local libraries through a Web application they can access from a PDA or a smartphone.”

OSU Libraries have also recently developed a mobile site ([http://mobile.library.oregonstate.edu/](http://mobile.library.oregonstate.edu/)), which includes basic information such as hours, ask-a-librarian, call numbers, floor maps, and FAQ, as well as a full catalog search, and computer availability map. Patrons can quickly search the Libraries’ catalog and get one click access to availability, call numbers and floor maps. The custom mobile catalog offers searching by keyword, title, subject, ISBN and course reserves by instructor or subject. The search can be filtered by location and results can be limited to 5, 10 or the top result. The item records include title, author and description, and a link to the shelf-view of the item. The computer availability map provides real-time information about the number and types of computers available in the Libraries’ Learning Commons. To take advantage of students’ high use of text messaging, patrons can email or text themselves the libraries’ contact information, directions, or call-numbers and floor locations as well as a list of course reserves. In addition, the mobile site makes use of a mobile device’s native capabilities, such as Google Maps, to provide location based directions to the library and phone numbers that can be auto-dialed with one click.

To provide a good mobile experience, offer services that support time critical and location sensitive activities, such as real time information about computer availability and map-based directions; and time saving applications, such as displaying the call number next to a link to the floor map in a catalog search; and use mobile device’s native capabilities, like auto-dialing phone numbers and texting a course reserve title.

## Content Adaptation Techniques

Developing mobile Web sites that provide an acceptable mobile experience for a wide range of devices can be difficult. In the same way that we work tirelessly to make full Web sites work on all browsers and operating systems, we should do the same for mobile sites. One common trend is to develop Web applications that are optimized for smart phones – which reads “fat chance it’s going to work on your standard Web-enabled cell phone.” While this an attractive solution due to these phones’ increased screen size, browser capabilities and standardization, this is leaving a large portion of mobile users out in the cold. AvianResearch, L.L.C, recently released a list of the 10 most popular handsets in the United States ([Beckman, 2009](https://journal.code4lib.org/articles/#beckman)). The BlackBerry Curve and iPhone are at the top of the list, but more importantly, more than half of the top 10 devices are not smart phones.

The implication of this list is that there are still quite a large number of people using small-screened devices for Web browsing. Therefore, if a library’s initiative is to provide a mobile version of their site they should develop applications that work on both smart phones and Web-enabled phones equally. However, if the initiative is to build innovative applications that use functionalities that are included on a family of devices, then developing an application that exploits the device’s capabilities to enhance a user’s experience is the better solution. As stated in the Mobile Web Best Practices (MWBP) Report, “It is likely that application designers and service providers will wish to provide the best possible experience in the context in which their service has the most appeal. However, while services may be most appropriately experienced in one context or another, it is considered best practice to provide as reasonable an experience as is possible given device limitations and not to exclude access from any particular class of device, except where this is necessary because of device limitations” ([2008](https://journal.code4lib.org/articles/#rabin)).

Adaptation is the practice of delivering content per each user device’s capabilities. The MWBP working group has defined the purpose of the Default Delivery Context (DDC), explaining “This allows providers to create appropriate experiences in the absence of adaptation and provides a baseline experience where adaptation is used” ([2008](https://journal.code4lib.org/articles/#rabin)). The DDC is defined as follows:

- Usable Screen Width
- 120 pixels, minimum.
- Markup Language Support
- XHTML Basic 1.1 [\[XHTML-Basic\]](http://www.w3.org/TR/mobile-bp/#XHTML-Basic) delivered with content type `application/xhtml+xml`.
- Character Encoding
- UTF-8 [\[UTF-8\]](http://www.w3.org/TR/mobile-bp/#UTF-8).
- Image Format Support
- JPEG.
- GIF 89a.
- Maximum Total Page Weight
- 20 kilobytes.
- Colors
- 256 Colors, minimum.
- Style Sheet Support
- CSS Level 1 [\[CSS\]](http://www.w3.org/TR/mobile-bp/#CSS). In addition, CSS Level 2 [\[CSS2\]](http://www.w3.org/TR/mobile-bp/#CSS2) `@media` rule together with the `handheld` and `all` media types (see [CSS 2 Media Types](http://www.w3.org/TR/REC-CSS2/media.html)).
- HTTP
- HTTP/1.0 [\[HTTP1.0\]](http://www.w3.org/TR/mobile-bp/#HTTP1.0) or more recent [\[HTTP1.1\]](http://www.w3.org/TR/mobile-bp/#HTTP1.1).
- Script
- No support for client side scripting.

There are three adaptation techniques that can enable your mobile site to offer an optimized experience for a wider range of devices based on the device’s capabilities. Each technique has its pros and cons and range from simple to advanced.

### 1\. Detect the device and link an appropriate CSS file.

Media types can be used to determine the device type and link to an appropriate CSS file. Media types have been around since the early Web and are used to render content differently for different screens. The most common use of media types is the print type, which is used to display different CSS styles for printing. The media types applicable for mobile devices are the handheld and screen types. W3C specifications for optimizing mobile sites recommend using the handheld media type to link to mobile stylesheets. The problem with this is that not all mobile browsers adhere to this recommendation. Handheld media are supported by Opera, OpenWave, and partially by Pocket Internet Explorer. Palm’s Blazer and IEMobile support both screen and handheld. Apple and Nokia do not support the handheld media type, rather they use Media Queries to render the screen type. Even though it sounds impossible, media types can still be used to link to CSS styles that target mobile devices. The following method works correctly on a large number of mobile devices and requires only two stylesheets, the reference design and the adapted smart phone design.

Some mobile browsers do not support media declaration, so the first step is to link to the reference design without a media type.

```
<link rel="stylesheet" type="text/css" href="mobile.css" />
```

Next, to catch devices that can render the handheld media type, link to the reference design with the handheld media type.

```
<link href="mobile.css" rel="stylesheet" type="text/css" media="handheld" />
```

To specifically target smart phones like iPhones, Android phones and others with browsers that can support media queries, link to the adapted stylesheet with the max-device width and only screen media type.

```
<link rel=”stylesheet” href=”iPhone.css” media=”only screen and (max-device width:480px)” />
```

Media types are an easy way to give users on both high and low-end mobile devices an optimal experience by linking to device appropriate stylesheets. You can take this idea a step further by detecting the device being used and redirecting to different version of a mobile site depending on device capabilities.

### 2\. Detect the device and redirect to multiple versions of pages

A detection algorithm can be used to detect whether a user is on a mobile device or not and then redirect users to specific versions of pages. Using a server-based scripting language (like PHP), it is easy to detect device types by reading the UserAgent string. Most device switching algorithms detect if a user is on a mobile device. The biggest problem with this approach is that UserAgent strings on mobile devices are inconsistent and maintaining a list of possible browsers and operating systems is a constantly moving target.

An alternative approach is to turn the problem upside down and detect if a user is not on a mobile device. This method is called the “not-detection” device method. The not-detection algorithm works due to the smaller number of desktop operating systems (OS), in addition desktop browsers are better at knowing which OS they are running.

In December 2008, OSU Libraries developed a mobile initiative, which required that we not make the user think when it came to finding the mobile site. We aliased our mobile site to the three common mobile urls: 1. ) m.your-domain, 2.) mobile.your-domain and 3.) your-domain/mobile. This allowed users of any type to access and bookmark the mobile site. The initiative also mandated we help mobile users who access the desktop site to find the mobile site. When a user on a mobile device goes to our main Web site, he or she will be redirected to our mobile site and given the option to opt-out and be returned to the full site. To achieve these goals, we used the not-device detection method on the home page of our full Web site to detect if a mobile user is accessing the site, and if so to redirect them to our mobile site. The algorithm works as follows:

It first checks if the noredirect cookie exists, which indicates the user has opted out of being redirected to the mobile site. It then checks for one of the known desktop OS: Windows, Macintosh/Mac OSX, Linux, FreeBSD, Solaris, and VMS, and that the User Agent does not contain one of the following strings: bot, slurp, spider, or crawl.

There are two “gotchas” in this group that need a little more detection. The iPhones and Mobile Windows devices’ OS’s will initially identify themselves as not mobile devices. Further processing the UserAgent for the strings, ‘iphone’ and ‘ipod’ will catch the iPhone family and checking for ‘mobile’ will catch all Mobile Window devices. At this point, you probably have a mobile device and can redirect them to a mobile site.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19 | `<?php`  `if``((``$_COOKIE``&#91;``"noredirect"``&#93; != true)){`  `$mobile_browser` `= 1;`  `$currUA` `= ``strtolower``(``$_SERVER``&#91;``'HTTP_USER_AGENT'``&#93;);`  `$agents` `= ``array``( ``'windows'` `,``'macintosh'``,``'mac'``,``'linux'``,``'freebsd'``,``'solaris'``,``'bot'``, ``'slurp'``, ``'spider'``, ``'crawl'``, ``'lynx'``, ``'vms'``,``'openvms'``);`  `foreach``(``$agents` `as` `$ua``){`  `if` `(``strpos``(``$currUA``, ``$ua``)>=0) {`  `$mobile_browser` `= 0;`  `break``;`  `}`  `}`  `if` `((``strpos``(``$currUA``, ``'iphone'``)>0)\|\|(``strpos``(``$currUA``,``'ipod'``)>0)\|\|(``strpos``(``$currUA``, ``'mobile'``)>0)) {`  `$mobile_browser` `= 1;`  `}`  `if``(``$mobile_browser` `== 1){`  `}`  `}`  `?>` |
| --- | --- | --- | --- | --- | --- |

Algorithm based on a PHP script written by Andy Moore \[[1](https://journal.code4lib.org/articles/#note1)\] and another by Mobify \[[2](https://journal.code4lib.org/articles/#note2)\]. This version of the algorithm is released under the terms of the GNU Library General Public License.

Detecting if the user is on a mobile device is only one part of the algorithm. The second part is detecting what class of mobile device the user has and providing an optimal experience for those users. Some services can do a better job of detecting devices and can give more granular details about their capabilities. Using one of the following tools in conjunction with a detection algorithm can enable data manipulation and other optimizations. Developed by DotMobi, DeviceAtlas is a mobile device database \[[3](https://journal.code4lib.org/articles/#note3)\]. DeviceAtlas provides up-to-the-minute device detection data, such as screen dimensions, javascript capabilities, touch screens, or full keyboard access. A similar, open-source tool is the Wireless Universal Resource File \[[4](https://journal.code4lib.org/articles/#note4)\]. WURFL is an XML configuration file that contains information about capabilities and features of many mobile devices. The information is kept up to date by a world-wide network of contributors.

Device detection often results in multiple copies of content formatted specifically for a range of devices, and therefore requires constant maintenance as devices come and go. And it’s worth noting; device detection is rarely 100% reliable. A feedback link on your mobile site can help patrons contact you if they experience a false redirection. OSU Libraries’ mobile developer has received feedback from patrons that prompted the addition of openvms and lynx to the list of desktop browsers. Rather than maintaining multiple copies of content, it is better to have content that can dynamically adapt for the type of device accessing it.

### 3\. Auto-generate device-specific versions of the same content

There are commercial and open-source tools that can auto-generate device-specific versions of your site. Instant Mobilizer from dotMobi is an automated tool that takes any existing content and transforms it into a mobile site \[[5](https://journal.code4lib.org/articles/#note5)\]. MyMobileWeb is a low-cost open-source tool that provides a content adaptation suite of tools for the development of mobile Web sites \[[6](https://journal.code4lib.org/articles/#note6)\]. HAWHAW is a toolkit that can “help make websites accessible by a wide range of mobile devices and standard browsers.” HAWHAW is free software; released under the terms of the GNU Library General Public License that uses a simple API to create the markup for a wide range of mobile devices \[[7](https://journal.code4lib.org/articles/#note7)\]. Similarly, The Wireless Abstraction Library (WALL) is a free, open source Java tag-library that provides a universal mark-up for wireless devices. WALL will generate optimized content for a variety of devices \[[8](https://journal.code4lib.org/articles/#note8)\]. With the rise of smart phones and the movement toward open OS devices, content adaptation will become obsolete. However, until we reach saturation, developers should continue designing functional, attractive mobile applications for all devices.

## Designing for the Small Screen

As described in the Mobile Web Best Practices Report (MWBP), “It is particularly important in the mobile context to help the user create a mental image of the site. This can be assisted by adopting a consistent style and can be considerably diminished by an uneven style” ([2008](https://journal.code4lib.org/articles/#rabin)).

Regardless of the device type your application is targeting, a consistent, well-designed layout can serve all of your users well. Before the OSU Libraries’ mobile team started development of the OSU Libraries Mobile site, we drew up a list of 10 design recommendations based on MWBP and the iPhone Human Interface Guidelines \[[9](https://journal.code4lib.org/articles/#note9)\].

1. Hierarchy  
a. Use a “drill down” method and headers to break information up into tasks.  
b. Put the most used content at the top and less frequented content below.  
c. Don’t make the user click more than 3 times to get to the content.
2. Links  
a. Assign and display each link in the navigation to a number on phone pad. Do not exceed that limit.  
b. Assign links that point out to non-mobile sites a descriptive icon.  
c. Make phone numbers into links that call automatically.
3. Navigation  
a. Minimize scrolling on navigation pages.  
b. Assign each navigation link an icon.Use icons that describe the content and provide a preview of the content.  
c. Put most-used navigation sections “above the fold.”  
d. Include basic navigation (home and back) at the top of every page. Keep this navigation on one line.  
e. Include secondary navigation (related links) at the bottom of the page.
4. Footer information  
a. Include link to full Website.  
b. Include link to an about and feedback page.
5. Page titles, navigation links, and URLs  
a. Keep page title and navigation links to 15 characters.  
b. Keep URLs short and easy to type.  
c. Minimize typing of non-alphanumeric characters (-, \_, &).
6. Page Content  
a. “Frontload” content of interest.  
b. Ensure subject matter of the page is near the top.  
c. Balance pagination and scrolling.
7. Page Layout  
a. Do not use frames or tables.  
b. Do not use pixel measures or absolute units.  
c. Do not rely on support of font-related styling.  
d. Do not rely on stylesheets for content organization.
8. Forms  
a. Use drop downs, radio buttons or checkboxes rather than text fields to minimize typing.  
b. Keep the number of key strokes to a minimum.  
c. Provide pre-selected default values where possible.  
d. Label all form controls appropriately and explicitly associate labels with form controls.
9. Images and Color  
a. Design a logo that can work on multiple screen sizes.  
b. Use a pared down version of your color scheme.  
c. Keep images to a minimum and compress to keep small.  
d. Do not use graphics for spacing.  
e. Content images should be no larger than 80% of the device’s screen width.
10. Screen Sizes  
a. Create 2 designs, one for Web-enabled phones and one for smart phones. One design should target 176X220 and gracefully degrade to fit on 128X160. The other design should target 320X480.

[![320X480 design](https://journal.code4lib.org/wp-content/uploads/2009/11/adapted_style.jpg "adapted_style")](https://journal.code4lib.org/wp-content/uploads/2009/11/adapted_style.jpg)

**Figure 1**: OSU Libraries Mobile Site. 320X480 design.

[![176X220 design](https://journal.code4lib.org/wp-content/uploads/2009/11/reference_style.jpg "reference_style")](https://journal.code4lib.org/wp-content/uploads/2009/11/reference_style.jpg)

**Figure 2**: OSU Libraries Mobile Site. 176X220 design.

We started simple and created a default layout that would work on all mobile devices. This layout serves as the reference design. The CSS Mobile Profile 2.0 is a valuable resource for creating the stylesheets \[[10](https://journal.code4lib.org/articles/#note10)\]. The reference design meets W3C’s Default Delivery Context requirements.

Next we made simple changes to the reference design that adapted the content to be more visually attractive and work better on smart phones with larger screens. The adapted design makes use of the ‘full Web’ browser and the CSS3 properties to emulate the iPhone user interface. We used the two standard iPhone design patterns, Rounded Rectangle and the Edge to Edge Design, which follow the iPhone Human Interface best practice recommendation and make full use of supported CSS3 properties that Safari and WebKit implement \[[11](https://journal.code4lib.org/articles/#note11)\].

Following iPhone design patterns is one way to optimize content for smart phones; the viewport is another important technique. The iPhone and other phones running Webkit browsers use a metadata tag, the viewport, to scale a site down to fit their smaller screens. When an iPhone loads a webpage, it sets the initial content area to fit the width of the iPhone screen by setting the viewport’s width property to 980 pixels, the width of most webpages. You can change these widths and other viewport properties using the viewport meta tag in the head of your desktop or mobile Web site. For an iPhone-specific Web application, you should set the width to the width of the device:

```
<meta name = "viewport" content = "width = device-width">
```

Even though devices like the iPhone can do a good job of rendering most sites, developers should be aware of their limitations and design accordingly.

- Maximum size for decoded GIF, PNG, and TIFF images is 2 megapixels.
- Individual resource files must be less than 10 MB.
- JavaScript execution time is limited to 10 seconds.
- Avoid using Flash and Java.
- iPhone blocks pop-up windows by default (user preference).

## Testing and Validating

For standard Web sites, coding a site that will work in all browsers is as easy as writing XHTML. Mobile sites on the other hand must work for thousands of devices and hundreds of browsers. This daunting challenge makes dealing with Internet Explorer seem like child’s play. The group working toward establishing standards and best practices is W3C’s Mobile Web Best Practices 1.0 (MWBP) working group. But there has been little movement from cell phone providers and browsers to agree to and adopt these standards.

The Mobile Web Best Practices 1.0 working group aims to improve the experience of mobile users who experience barriers due to the device used to access the Internet. “People with disabilities using computers have similar interaction limitations as people without disabilities who are using mobile devices. Both experience similar barriers when interacting with Web sites” ([Web Accessibility Initiative, 2009](https://journal.code4lib.org/articles/#yesilada)). An alternative to MWBP guidelines is the Global Authoring Practices for the Mobile Web \[[12](https://journal.code4lib.org/articles/#note12)\].

Just as W3C offers a validation certificate for Americans with Disabilities Act (ADA) compliant code, it also rewards developers of compliant mobile sites. The mobileOK Basic Tests are based on Mobile Web Best Practices’ 60 guidelines. Mobile sites that claim MobileOK conformance meet the Default Delivery Context. In addition to advertising conformance with the MobileOK icon, content providers can enhance discoverability of their mobile sites by using the Protocol for Web Description Resources \[POWDER\] to claim mobileOK conformance. Mobile search engines, like Google Mobile Search, rank mobile sites higher in the results and checks POWDER as an indicator.

To claim conformance, mobile sites must pass the MobileOK tests. The MobileOK checker is an online tool that automates the tests and provides detailed information about where and how a site fails \[[13](https://journal.code4lib.org/articles/#note13)\]. The checker tests for the “mobile-friendliness” of a mobile site. The tests consist of several atomic subtests. A subtest can pass, fail, or generate a warning. A warning indicates an area that may need work, while failing indicates that a guideline is being violated. When performing the tests, you can select to group failures by category or tests. Grouping by category is useful when beginning the testing process, while grouping tests is useful when working to get a particular area to validate. A page on your mobile site is scored on a scale of 0-100 for the “OK-ness.” This rating system lets you work towards meeting the guidelines and to prioritize the severity of the failures. In addition to testing your own site, the MobileOK checker provides W3C with data from all the sites put through the checker. The number one point of failure is code compliance to XHTML Basic.

In addition to the MobileOK checker tool, DOTMobi provides a tool, MobiReady, that “evaluates the mobile-readiness” of a mobile site \[[14](https://journal.code4lib.org/articles/#note14)\]. The tool is based on W3C best practices guidelines and others. Unlike the W3C tool, you can test your complete site at once. Pages are rated on a scale of 1-4 and detailed analysis of the site is provided in an easily digestible format. The report includes page load speed and weight, validation errors and warnings, and can tidy up the offending code. The tool also includes a handful of emulators and browsers for testing.

Validating your code should be done continuously as you develop your site. The level of conformance you choose to require should be part of your development plan. OSU Libraries’ mobile initiative requires that the reference version of the site pass the MobileOK checker. Adapted versions of the site have a sliding scale level of conformance depending on the guideline and if the violation enhances a user’s experience. This practice is supported in the MWBP Report, “It is recognized that content providers may need to violate specific Best Practices in order to support their intentions on devices that exhibit deficiencies in implementation” ([2008](https://journal.code4lib.org/articles/#rabin)).

Mobile application testing is often an issue in mobile application development. Developing a test plan is an important step to track and evaluate the readiness of your mobile site. Prepare to test by writing a script of tasks to follow, along with the desired outcomes. Perform the test with a design reference to compare to and a form to capture results. Track the devices you test on and cross-reference with known limitations. Knowing a device’s limitation will allow you to throw out faulty tests, as well as decide if you should work to support the device. For example, we were able to rule out a handful of phones due to their inability to render XHTML. The thousands of mobile devices make testing on every one out of reach for most developers. Attacking testing with a three-pronged approach can provide adequate testing coverage.

The first line of defense for testing mobile sites are desktop browsers. Test your mobile application on the desktop to ensure functionality. Mozilla’s Firefox has add-ons that you can use to manipulate the UserAgent, such as the User Agent Switcher, XHTML Mobile Profile and Modify Headers. Opera Mini and Mobile was shipped on 7.8 million phones last year, providing reason enough to test on Opera. And iPhone Safari is similar enough to Safari for first stage testing.

The next approach is testing on browser simulators and device emulators. There are Opera Mini simulators \[[15](https://journal.code4lib.org/articles/#note15)\] \[[16](https://journal.code4lib.org/articles/#note16)\], iPhone Safari simulators \[[17](https://journal.code4lib.org/articles/#note17)\] and downloadable iPhone emulators through the iPhone SDK \[[18](https://journal.code4lib.org/articles/#note18)\] and iPhoney \[[19](https://journal.code4lib.org/articles/#note19)\]. Nokia developer toolkit includes an emulator \[[20](https://journal.code4lib.org/articles/#note20)\], as does the Android SDK \[[21](https://journal.code4lib.org/articles/#note21)\], Openwave tool kit \[[22](https://journal.code4lib.org/articles/#note22)\], Blackberry developer tools \[[23](https://journal.code4lib.org/articles/#note23)\], mobile Windows \[[24](https://journal.code4lib.org/articles/#note24)\], and Palm developer SDK \[[25](https://journal.code4lib.org/articles/#note25)\]. And DotMobi offers a “universal” emulator \[[26](https://journal.code4lib.org/articles/#note26)\]. The simulators that come included with a developer tool kit are more true to the mobile device’s actual behavior. Some simulators do a poor job at rendering adaptation techniques. More importantly simulators cannot mimic the mobile context and limitations that mobile devices present in real life usage.

The final stage is testing on actual devices. Even though testing on all devices is out of the question, testing on a subset of phones that target a set of screen sizes and capabilities is achievable. By identifying device families between which the user experience is the same or similar, you can greatly reduce the numbers of devices on which to test. For example, all Palm OS devices are largely the same, and all Pocket PC devices are largely the same. You can also identify families of phones that have the same characteristics. Then out of those families of devices, test the slowest, smallest ones with the most limitations. When OSU Libraries’ mobile development was at this phase in testing, the team drew up a list of devices to test as well as our test script and drove to the nearest T-Mobile store. At the store we introduced ourselves to the store manager, and asked if we could test the site on the display phones. The manager agreed and even ended up helping us test. He proved invaluable, as he knew which phones came with what default setting and browsers. While we cannot recommend that everyone inundate their local cell phone store, the story illustrates how imagination can lead to testing opportunities. Another option is to rent mobile devices \[[27](https://journal.code4lib.org/articles/#note27)\] or pay for a service called DeviceAnywhere \[[28](https://journal.code4lib.org/articles/#note28)\], which enables you to test a mobile Web site across a wide range of mobile devices.

To develop an easy-to-use mobile site user interface, effective usability evaluations should be integrated into the development cycle. There are many graphic packages that make mocking up mobile sites easy. Paper prototyping a mobile site can address design issues before a line of code is written and can be very successful for testing functionality with users. Another usability method is to develop a usability metric and evaluate the mobile site based on the guidelines. Metrics should include standard heuristics, such as ease of navigation, consistency, useful feedback, and speaking the user’s language, as well as mobile specific requirements, such as page load times and image sizes.

Evaluations and user testing can be performed on simulators, but nothing beats testing on mobile devices in the real world. Hallway usability testing can easily be performed on mobile devices and provide the on-the-go context of mobile users. Go to anywhere that people are congregating, locate someone with a phone and ask them if they can participate in a user study. Usually offering an incentive is a motivator, but make sure you tell your volunteers that they may incur charges from their cellphone provider. Focus groups and online surveys are also ways to have users evaluate a mobile site and provide feedback even after the mobile site is released. Tracking use statistics on page views, as well as information regarding browser types is useful information when deciding on features to add.

OSU Libraries has been tracking our mobile site since we released the first stage of the project in April 2009. The first stage included information about the library, texting the Library contact information, and location-based direction. Over the first three months the site received an average of 80 unique user sessions per day. The top three viewed pages are the Library Hours, Text the Contact, and floormaps tied with call numbers. The top two browser/platform combination used to access the mobile site are; Safari / Mac and DoCoMo 2.0 / NTT DoCoMo / N905i. The Safari / Mac platform are obviously iPhone users, but DoCoMo is a Japanese mobile provider that comes on a variety of web-enabled phones. This indicates our patrons are accessing the site with non-smart phone devices and furthers our position for providing an optimal mobile experience for all. In September we released the catalog search and computer availability map and will continue to track usage and gather user feedback. Continued maintenance of the site has been minimal and is comparable to maintaining any Web site. To reduce content upkeep issues, we pull constantly changing content, such as the hours, from a database that feeds both the mobile and desktop Web sites.

OSU Libraries’ mobile Web site future development includes searching mobile versions of subject guides and course pages, library events that can be added to calendars, and a location-based digital collection application that integrates GPS and social media. Positive feedback, increasing use statistics and media attention are good indications that OSU Libraries mobile site is a much needed and appreciated service.

## Conclusion

“As libraries consider their re-tooling for mobile users and mobile devices, they should examine the consequences of mobility and the opportunities for innovation in the areas of content, systems and tools, services, and environments, both physical and virtual” ([Lippincott, 2008](https://journal.code4lib.org/articles/#lippincott)).

Evidence and trends point toward increased levels of user dependence on mobile devices now and in the foreseeable future; therefore, the technical challenges that crop up while creating and maintaining a mobile site are minor when compared with the potential benefits for and goodwill from our users when we create and provide user-centered services like mobile applications.

OSU Libraries’ mobile Web site proves attractive, feature-rich mobile sites can be built using standards and industry best practices. The techniques we used to provide an optimal experience for all mobile patrons are easy to implement as long as you follow six main guidelines: consider the mobile context, adapt the content per mobile device, design based on tried and true patterns, test on a subset of phones, validate conformance and evaluate with your patrons.

## Corrections

**Correction #1**: November 24th, 2009: We have removed a sentence in the original version of this paper which collapsed two Pew reports.

Previous version:  
“The Pew Internet Project’s typology of information and communication technology (ICT) surveyed 2054 mobile users about how they get information or communicate with others while away from home or work: 46% of cell phone and wireless laptop users said mobile access is very important for getting online information on the go (Horrigan, 2009b).”

The corrected version reads:  
“The Pew Research Center’s Project found that 46% of cell phone and wireless laptop users think mobile access is very important for getting online information on the go (Horrigan, 2009b).”

**Correction #2**: December 4, 2009: We fixed the link to the OCLC WorldCat Mobile site.

Previous version:  
“OCLC is currently offering a mobile search application pilot, WorldCat Mobile, (http://www.worldcat.org/mobile/) and an iPhone search app (http://mobileworldcat.org/).”

Corrected version:  
“OCLC is currently offering a mobile search application pilot, WorldCat Mobile, (http://www.worldcat.org/mobile/) and an iPhone search app (http://www.oclc.org/news/announcements/announcement353.htm).”

## Authors

Kimberly Griggs is Oregon State University Libraries’ programmer. She is the designer and developer for OSUL mobile project and can’t live without her iPhone.

Laurie M. Bridges is Oregon State University Libraries’ Business and Economics Librarian. She is OSUL mobile team project chair and is attached at the hip to her Blackberry.

Hannah Gascho Rempel is Oregon State University Libraries’ Biosciences Librarian and Graduate Student Services Coordinator. She is a member of OSUL mobile team and is zen-like in her refusal to own a cell phone.

## References

Beckman, K. (2009, January). By the Numbers: Top 10 most popular U.S. handsets in November. RSRWirless, Retrieved 09/21/09, from [http://www.rcrwireless.com/article/20090108/WIRELESS/901079989/1081/by-the-numbers-top-10-most-popular-us-handsets-in-november](http://www.rcrwireless.com/article/20090108/WIRELESS/901079989/1081/by-the-numbers-top-10-most-popular-us-handsets-in-november)

Horrigan, J. (2008, March). Mobile Access and Data Information. Pew Memo, Retrieved 09/21/09, from [http://www.pewinternet.org/Press-Releases/2008/Mobile-Access-to-Data-and-Information.aspx](http://www.pewinternet.org/Press-Releases/2008/Mobile-Access-to-Data-and-Information.aspx)

Horrigan, J. (2009a, July). Wireless Internet Use. Pew Report, Retrived 09/21/09, from [http://www.pewinternet.org/Reports/2009/12-Wireless-Internet-Use.aspx](http://www.pewinternet.org/Reports/2009/12-Wireless-Internet-Use.aspx)

Horrigan, J. (2009b, July). Mobile internet use increases sharply in 2009 as more than half of all American have gotten online by some wireless means. Pew Press Release, Retrieved 09/21/09, from [http://www.pewinternet.org/Press-Releases/2009/Mobile- internet-use.aspx](http://www.pewinternet.org/Press-Releases/2009/Mobile-internet-use.aspx)

Horrigan, J. (2009c, March). The Mobile Difference: Wireless connectivity draws many users more deeply into digital life, but most Americans still connect to the internet mainly on wireline and rarely use a mobile device to access digital resources. Pew Press Release, Retreived 09/21/09, from [http://www.pewinternet.org/Press-Releases/2009/The-Mobile-Difference.aspx](http://www.pewinternet.org/Press-Releases/2009/The-Mobile-Difference.aspx)

Yesilada, Y., Chuter, A., & Henry, S.L. (June, 2009). Shared Web Experiences: Barriers Common to Mobile Device Users and People with Disabilities. Web Accessibility Initiative, Retreived 09/21/09, from [http://www.w3.org/WAI/mobile/experiences](http://www.w3.org/WAI/mobile/experiences)

Kroski, E. (2008, July). On the Move with the Mobile Web: Libraries and Mobile Technologies. Library Technology Reports, Retrieved 02/10/09, from [http://eprints.rclis.org/15024/](http://eprints.rclis.org/15024/)

Lippincott, J.K. (2008, December). Mobile Technologies, Mobile Users: Implications for Academic Libraries. ARL: A Bi-Monthly Report, 261, Retrieved 02/02/09, from [http://www.arl.org/bm~doc/arl-br-261-mobile.pdf](http://www.arl.org/bm~doc/arl-br-261-mobile.pdf)

Nielsen, J. (2009, July). Mobile Usability. Jakob Nielsen’s Alertbox, Retreived 09/21/09 from [http://www.useit.com/alertbox/mobile-usability.html](http://www.useit.com/alertbox/mobile-usability.html)

Rabin, J., & McCathieNevile, C. (Eds.). (2008). W3C Mobile Web Best Practices 1.0, Retrived 09/21/09 from [http://www.w3.org/TR/mobile-bp/](http://www.w3.org/TR/mobile-bp/)

West, Mark Andrew, Arthur W. Hafner, And Bradley D. Faust. “Expanding Access to Library Collections and Services Using Small-Screen Devices”. Information Technology and Libraries, v. 25, n. 2, June 2006, pp. 103-107. [http://www.ala.org/ala/mgrps/divs/lita/ital/252006/2502jun/west.cfm](http://www.ala.org/ala/mgrps/divs/lita/ital/252006/2502jun/west.cfm)

## Resources

\[[1](https://journal.code4lib.org/articles/#note1text)\] [http://www.andymoore.info/download-manager.php?id=13](http://www.andymoore.info/download-manager.php?id=13)  
\[[2](https://journal.code4lib.org/articles/#note2text)\] [http://smartmobtoolkit.wordpress.com/2009/01/26/not-device-detection-  
javascript-perl-and-php-code/](http://smartmobtoolkit.wordpress.com/2009/01/26/not-device-detection-javascript-perl-and-php-code/)  
\[[3](https://journal.code4lib.org/articles/#note3text)\] [http://deviceatlas.com/](http://deviceatlas.com/)  
\[[4](https://journal.code4lib.org/articles/#note4text)\] [http://wurfl.sourceforge.net/index.php](http://wurfl.sourceforge.net/index.php)  
\[[5](https://journal.code4lib.org/articles/#note5text)\] [http://instantmobilizer.com/](http://instantmobilizer.com/)  
\[[6](https://journal.code4lib.org/articles/#note6text)\] [http://mymobileweb.morfeo-project.org/mymobileweb](http://mymobileweb.morfeo-project.org/mymobileweb)  
\[[7](https://journal.code4lib.org/articles/#note7text)\] [http://www.hawhaw.de/](http://www.hawhaw.de/)  
\[[8](https://journal.code4lib.org/articles/#note8text)\] [http://wurfl.sourceforge.net/java/index.php](http://wurfl.sourceforge.net/java/index.php)  
\[[9](https://journal.code4lib.org/articles/#note9text)\] [http://developer.apple.com/iphone/library/documentation/userexperience/conceptual/mobilehig/Introduction/Introduction.html](http://developer.apple.com/iphone/library/documentation/userexperience/conceptual/mobilehig/Introduction/Introduction.html)  
\[[10](https://journal.code4lib.org/articles/#note10text)\] [http://www.w3.org/TR/css-mobile](http://www.w3.org/TR/css-mobile)  
\[[11](https://journal.code4lib.org/articles/#note11text)\] [http://developer.apple.com/safari/library/documentation/AppleApplications/Reference/SafariCSSRef/Articles/StandardCSSProperties.html#//apple\_ref/doc/uid/TP3 0001266](http://developer.apple.com/safari/library/documentation/AppleApplications/Reference/SafariCSSRef/Articles/StandardCSSProperties.html#//apple_ref/doc/uid/TP3%200001266)  
\[[12](https://journal.code4lib.org/articles/#note12text)\] [http:// www.passani.it/gap](http://www.passani.it/gap)  
\[[13](https://journal.code4lib.org/articles/#note13text)\] [http://www.w3.org/TR/mobileOK/](http://www.w3.org/TR/mobileOK/)  
\[[14](https://journal.code4lib.org/articles/#note14text)\] [http://ready.mobi/launch.jsp?locale=en\_EN](http://ready.mobi/launch.jsp?locale=en_EN)  
\[[15](https://journal.code4lib.org/articles/#note15text)\] [http://www.opera.com/mini/demo/](http://www.opera.com/mini/demo/)  
\[[16](https://journal.code4lib.org/articles/#note16text)\] [http://informatico.altervista.org/netvibes/operamini.php](http://informatico.altervista.org/netvibes/operamini.php)  
\[[17](https://journal.code4lib.org/articles/#note17text)\] [http://www.testiPhone.com](http://www.testiphone.com/)  
\[[18](https://journal.code4lib.org/articles/#note18text)\] [http://developer.apple.com/iPhone/program](http://developer.apple.com/iPhone/program)  
\[[19](https://journal.code4lib.org/articles/#note19text)\] [http://www.marketcircle.com/iphoney/](http://www.marketcircle.com/iphoney/)  
\[[20](https://journal.code4lib.org/articles/#note20text)\] [http://www.forum.nokia.com/info/sw.nokia.com/id/db2c69a2-4066-46ff-81c4- caac8872a7c5/NMB40\_install.zip.html](http://www.forum.nokia.com/info/sw.nokia.com/id/db2c69a2-4066-46ff-81c4-caac8872a7c5/NMB40_install.zip.html)  
\[[21](https://journal.code4lib.org/articles/#note21text)\] [http://developer.android.com/guide/developing/tools/emulator.html](http://developer.android.com/guide/developing/tools/emulator.html)  
\[[22](https://journal.code4lib.org/articles/#note22text)\] [http://developer.openwave.com/dvl/member/downloadManager.htm?softwareId=23](http://developer.openwave.com/dvl/member/downloadManager.htm?softwareId=23)  
\[[23](https://journal.code4lib.org/articles/#note23text)\] [http://www.blackberry.com/developers/downloads/simulators/index.shtml](http://www.blackberry.com/developers/downloads/simulators/index.shtml)  
\[[24](https://journal.code4lib.org/articles/#note24text)\] [http://www.microsoft.com/downloads/details.aspx?familyid=A6F6ADAF-  
12E3-4B2F-A394-356E2C2FB114&displaylang=en](http://www.microsoft.com/downloads/details.aspx?familyid=A6F6ADAF-12E3-4B2F-A394-356E2C2FB114&displaylang=en)  
\[[25](https://journal.code4lib.org/articles/#note25text)\] [http://developer.palm.com/](http://developer.palm.com/)  
\[[26](https://journal.code4lib.org/articles/#note26text)\] [http://mtld.mobi/emulator.php](http://mtld.mobi/emulator.php)  
\[[27](https://journal.code4lib.org/articles/#note27text)\] [http://www.rentobile.com/](http://www.rentobile.com/)  
\[[28](https://journal.code4lib.org/articles/#note28text)\] [http://www.deviceanywhere.com/](http://www.deviceanywhere.com/)
---
title: "Creating Library Websites with Joomla: Not Too Big, Not Too Small, Just Right"
source: "https://journal.code4lib.org/articles/4226"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-12-21
created: 2025-01-10
description: "Many organizations, including libraries, are turning to content management systems to simplify the management of their websites. Alfred University‘s Herrick Memorial Library recently implemented a new website using Joomla, an open-source content management system. While Drupal has received significant attention in the library community, Joomla may be a more practical choice for some libraries. The [...]"
tags:
  - "clippings"
---
# Creating Library Websites with Joomla: Not Too Big, Not Too Small, Just Right
Ellen Bahr, Matt Speed

Many organizations, including libraries, are turning to content management systems to simplify the management of their websites. Alfred University‘s Herrick Memorial Library recently implemented a new website using Joomla, an open-source content management system. While Drupal has received significant attention in the library community, Joomla may be a more practical choice for some libraries. The purpose of this paper is to share our experience with Joomla so that other libraries can more easily evaluate its suitability to their environment.

## Introduction

Alfred University is a small comprehensive university in western New York with a student population of about 2,400. Herrick Memorial Library serves the College of Business, the College of Liberal Arts and Sciences, and the Graduate School. A second university library, the Samuel R. Scholes Library, serves the New York State College of Ceramics, a statutory unit of the university. Herrick has four librarians, including the library director, and seven support staff.

![Herrick's Joomla Website](https://journal.code4lib.org/media/issue12/bahr/figure1.png)  
**Figure 1.** Herrick’s Joomla Website

Recently, when faced with the task of redesigning our website, we chose to do it with Joomla, an open source content management system. Content management systems (CMSs, also referred to as web content management systems or WCMSs) are database-driven software systems for building and managing websites.

The open source content management systems most frequently discussed in libraries today are Drupal, WordPress, and Joomla. Drupal has a reputation for flexibility and extensibility but also for having a steep learning curve. WordPress, known for ease of use, began as a blogging platform and has evolved to incorporate more features of a CMS. Joomla, which emerged in 2005 as a fork in development of the Mambo CMS, has gotten relatively less attention in the library community but has a strong following in other sectors, both for-profit and not-for-profit.

## Joomla Framework

Like Drupal and WordPress, Joomla is written in PHP and stores data in a MySQL database. Unlike websites that rely on static HTML, sites built with content management systems like Joomla serve content dynamically. When a user requests a page on a Joomla site, the content is retrieved from the MySQL database, formatted according to the site’s template, and displayed in the user’s browser.

As depicted in Figure 2, Joomla is a “three-tiered system” \[[1](https://journal.code4lib.org/articles/#note1)\] consisting of an extension layer, an application layer, and a framework layer. The entire Joomla system interacts with the MySQL database, which stores information about the site.

- The extension layer consists of modules, components, and templates that extend the functionality of the Joomla system. Some extensions are included with the Joomla core installation and others can be added later.
- The application layer includes JInstallation for installing Joomla, JAdministrator which is responsible for the back-end administrative interface, JSite which is responsible for the front-end of the website, and an XML-RPC interface.
- The framework layer contains Joomla’s programming foundation, including libraries needed by the framework and plugins that extend the functionality of the framework.

![Joomla Software Framework](https://journal.code4lib.org/media/issue12/bahr/figure2.png)  
**Figure 2.** Joomla Software Framework

The core Joomla installation includes all of the features needed to create a functioning website, including systems for managing users, media, languages, banners, contacts, polls, searching, web links, content, newsfeeds, menus, and templates. These features can be expanded through add-ons. Help features, such as a glossary of Joomla terms, links to Joomla documentation, and a version checker are built into the web-based administrative interface. For a more complete description of the core Joomla features see the Joomla features overview \[[2](https://journal.code4lib.org/articles/#note2)\].

The Joomla extensions directory \[[3](https://journal.code4lib.org/articles/#note3)\] provides access to thousands of add-ons, the majority of which are free. These provide additional functionality not included in the core installation. Joomla’s extension manager (Figure 3) makes installing extensions easy. There are three options for installing extensions: upload a package file, install from a directory, or install from a URL. Uploading a package file is probably the most common method. The extension archive file is downloaded from the website of the extension provider and saved locally. Browse to where you saved the file and select Upload File and Install. At this point, Joomla completes the installation.

[![Joomla Software Framework](https://journal.code4lib.org/media/issue12/bahr/figure3.png)](https://journal.code4lib.org/media/issue12/bahr/figure3_wide.png)  
**Figure 3.** Joomla Extension Manager

In the Joomla extensions directory, extensions are classified as components (C), modules (M), plugins (P), languages (L), templates (T), or extension specific add-ons (S). Many installation packages include extensions of more than one type. For example, in the screenshot below, the Template Toolbar extension contains only a template, while the JForms extension contains a component and a plugin.

![Joomla Software Framework](https://journal.code4lib.org/media/issue12/bahr/figure4.png)  
**Figure 4.** Joomla Extensions Directory

Version 1.5 of Joomla includes five extension types:

**Plugins** are event handlers. “In the execution of any part of Joomla, be it the core, a module or a component, an event can be triggered. When an event is triggered, plugins that are registered with the application to handle that event execute” \[[4](https://journal.code4lib.org/articles/#note4)\]. Joomla’s WYSIWYG editor is an example of a plugin. Content is stored in Joomla’s MySQL database as HTML. The WYSIWYG editor plugin converts HTML to rich text for editing, and then back to HTML for storage. Joomla plugins are similar to hooks in Drupal \[[5](https://journal.code4lib.org/articles/#note5)\]. While Joomla’s documentation describes plugins as an extension type, Joomla’s software framework diagram (Figure 2) includes plugins in the framework layer. Plugins operate mostly behind the scenes, sometimes in combination with components or modules to provide a user interface.

**Modules** are used to display chunks of content on web pages; Joomla has a variety of module types to handle different kinds of content. Each template has defined module positions, and multiple modules can be displayed on a given page. Examples of modules include breadcrumbs, RSS feeds, banners, menus, footers, simple polls, and user logins. Joomla modules are similar to blocks in Drupal \[[5](https://journal.code4lib.org/articles/#note5)\].

**Components** are mini-applications. They have more complex administrative settings than modules, and only one component can appear on a given page. An example of a component is ChronoForms, which can be used to create interactive forms. Joomla components are similar to modules in Drupal \[[5](https://journal.code4lib.org/articles/#note5)\].

**Language** extensions are used to install additional languages. Once installed, they are managed in the Language Manager. Joom!Fish, which supports multi-lingual websites, is an example of a language extension.

**Templates** control the design of the website. They can be custom-built or selected from among the many Joomla templates available for purchase or for free. In Drupal, templates are called themes.

## Managing Users

Joomla provides for three user types: unregistered front-end users, registered front-end users, and registered back-end users. Unregistered (or public) front-end users are visitors to the site who have access to any content that doesn’t require a login. Registered front-end users can be given additional privileges, including the ability to view restricted content, and to author, edit, or publish articles. There are three levels of back-end users: managers, administrators, and super administrators, each with increasing privileges.

## Installation and Configuration

Joomla requires a server with Apache, MySQL and PHP. The XAMP installer is an easy way to install all components.

At our institution, the library wanted to get some experience with Joomla without having to install it locally. A relatively simple way to do this is to use a commercial hosting service. Many hosting services offer “one-click” installation for Joomla and Drupal, putting installation within reach of those with minimal technical skills. The Joomla resources directory \[[6](https://journal.code4lib.org/articles/#note6)\] includes a list of potential hosts. We installed Joomla and Drupal on a hosted server in order to compare them, and the experience contributed heavily to our decision to use Joomla. It was clear that Joomla would require less customization than Drupal, hopefully shortening our development timeline. Further, it seemed unlikely that we could take advantage of everything that Drupal had to offer, while Joomla’s features were sufficient for our relatively straightforward needs. After talking with another academic library that had recently built a site with Joomla, we decided to take the plunge.

While we were experimenting with Joomla on a hosted server, we were in touch with the university’s information technology services (ITS) department about eventually hosting the site locally. We continued to develop the site on the hosted server, with the understanding that we would contact ITS when we were ready to move our site to a local production environment. When we reached this point, the local installation and configuration of Joomla was handled by an ITS network services support specialist.

What follows is a brief description of the installation and configuration process at our institution. The specific steps will vary depending on a variety of factors in your local environment. Refer to the Joomla! 1.5 Installation Manual \[[7](https://journal.code4lib.org/articles/#note7)\] for complete information.

- We use a physical (as opposed to virtual) server that runs Oracle Unbreakable Enterprise Linux 64-bit 5.5 with PHP version 5 and MySQL 5. This OS is very similar to Red Hat Enterprise Linux 5.5. Sixty-four and 32 bit setups are identical. The server is a Dell PowerEdge 2950 with a Xeon E5405 2Ghz and 8GB of RAM.
- There are two ways to install Joomla – manually or via a web interface. We installed Joomla manually because of the additional options that it provides.
- The first step was to edit the configuration file. Copy the sample configuration file and enter your local settings such as the site URL and your database username and password.
- The next step was to create the MySQL database that will be used with the site. (Note: If you’re using the web-based interface, the database must be created prior to starting the setup.) To create the database in MySQL, we used SQLyog \[[8](https://journal.code4lib.org/articles/#note8)\] to execute the task. SQLyog is a simple MySQL management tool that allows for the creation and management of the database server.
- Once the database was created, we then opened the Apache configuration file and added the site information (because we host more than one site on a single IP address, we created a virtual host).
- DNS records then need to be created and configured by whoever manages your DNS. In our case, this was done internally.
- Once the Apache configuration reloads the site becomes available.
- At this point, we needed to verify the file permissions. This requires a SSH connection to be open. Once you have made a SSH connection to the server with an account that has the ability to change permissions, run the following commands from the Joomla root directory (note: these commands work only in a \*nix environment):

| 1  2 | `find . -type f -``exec` `chmod` `644 {} \; `  `find . -type d -``exec` `chmod` `755 {} \; ` |
| --- | --- |

These commands reset file and folder permissions for all files and folders in the Joomla root recursively.
- Finally, because our site was developed on a hosted server, we needed to move the MySQL database and customized template files to the local server. This was done by connecting to the hosted server with SQLyog and downloading the SQL database (SQL dump). Next, connect to the local server and replace the database. The customized template files were rsynced from the hosted site to the local site.

## Backup

A backup of the site consists of two parts: the Joomla site files and the database. At Alfred, we use an enterprise product called EMC Networker \[[9](https://journal.code4lib.org/articles/#note9)\] to back up the Joomla site files. If you don’t have an enterprise solution another option is to rsync, FTP, or SFTP the data to another server for backup. This can be done with a crontab or Windows scheduled task. Simply copying the files to an external drive is another option.

The second part of the backup involves the database. We use a cron job to do an SQL dump of the database, which is then saved by the EMC Networker backup system. A Joomla extension called Akeeba Backup can also be used for site backup \[[10](https://journal.code4lib.org/articles/#note10)\].

## Upgrades and Migrations

In Joomla, upgrading refers to the process of making updates within the same version of Joomla (for example, updating from version 1.5.18 to 1.5.19) and migrating refers to the process of moving from one version of Joomla to another (for example, migrating from version 1.0 to version 1.5). Joomla updates are released on a fairly regular basis (every couple of months or so) while migrations are a much rarer occurrence (version 1.5 was released in 2008 and version 1.6 is currently in beta testing).

The Joomla documentation provides complete instructions for site updates and migrations. In the case of upgrades, an extension called Update Manager for Joomla can be used to automate the process \[[11](https://journal.code4lib.org/articles/#note11)\].

A good way to stay up-to-date with new releases is to subscribe to the Announcements discussion in the Joomla forums \[[12](https://journal.code4lib.org/articles/#note12)\].

## Security

Joomla has some built-in security features that can be helpful to the person responsible for managing the server side of Joomla. For example, it will let you know if the Joomla configuration files or server configuration are incorrect or pose security risks. Joomla recommends staying up-to-date with the most recent stable release of Joomla and any additional extensions you’ve installed. As mentioned above, the Announcement discussion topic in the Joomla discussion forums provides a way to receive automatic notifications of new releases, as well as important security notifications. Joomla’s security checklist \[[13](https://journal.code4lib.org/articles/#note13)\] covers other important security topics.

At Alfred University we added an extra layer of security by putting a web application firewall (WAF) in front of the server. We use an Imperva x1000 WAF, which inspects all of the traffic going into our web servers. It looks for potential exploits such as cross-site scripting, SQL injection, and parameter violations. The firewall helps with blocking known problems and patching new problems as needed.

When implementing the WAF to the Joomla site, the WAF first needs to learn the site through web traffic. In our experience, this didn’t present any problems on the public website. The WAF did, however, generate errors in Joomla’s web-based administrative interface. Some site changes generated false positives based on the way Joomla handles its code through the /administrator/index.php and index2.php pages. Errors were reported to information technology services staff and corrected by making changes to the Imperva configuration.

## Joomla’s Administrative Interface

Once Joomla is installed, site administrators and developers access the site through a back-end, web-based administrative interface. Figure 5 shows the Control Panel which functions as the homepage of the administrative interface.

![Joomla Control Panel](https://journal.code4lib.org/media/issue12/bahr/figure5.png)  
**Figure 5.** Joomla Control Panel

In the Control Panel, a series of drop-down menus and shortcuts provide access to Joomla’s administrative options. Joomla’s official documentation \[[14](https://journal.code4lib.org/articles/#note14)\] and the “Learn to Use Joomla!” section of the Absolute Beginner’s Guide to Joomla! \[[15](https://journal.code4lib.org/articles/#note15)\] are good resources for getting started with using some of the back-end options. Some knowledge of HTML and CSS will be helpful if you want to edit template files. Experience with PHP and MySQL will open up additional opportunities for customizing the site.

## Designing and Building the Site

### Working with Templates

There are three basic approaches to designing a Joomla site:

- Find a template that you like and make only minor changes;
- Find a template that approximates what you want and modify it to suit your needs; or
- Design and build your own Joomla template.

While designing a template from scratch provides the most control, using an existing template will likely save time and reduce the need for in-house design and technical expertise. Keep in mind that most templates will need at least some modification, even if it’s only replacing the default logo with your own. In Herrick’s case, we found a template that had the right look and feel, and we modified it to suit our needs. We chose the “JA Rutile” template, which can be purchased from JoomlArt. Some sources for free and purchased templates are: Joomlashack \[[16](https://journal.code4lib.org/articles/#note16)\], JoomlArt \[[17](https://journal.code4lib.org/articles/#note17)\], and RocketTheme \[[18](https://journal.code4lib.org/articles/#note18)\]. Templates are installed and uninstalled through the web-based administrative interface.

One of the first steps in editing templates is becoming familiar with a given template’s defined module positions. For example, Figure 6 below shows the module positions of the default JA Rutile template and Figure 7 shows the module positions of our website. For any Joomla site, you can view the module positions by adding “?tp=1” to the site URL (http://herrick.alfred.edu/?tp=1 will display the module positions for our site).

![Module Positions for the JA Rutile Template](https://journal.code4lib.org/media/issue12/bahr/figure6.png)  
**Figure 6.** Module Positions for the JA Rutile Template

[![Module Positions for the Herrick Homepage](https://journal.code4lib.org/media/issue12/bahr/figure7.png)](https://journal.code4lib.org/media/issue12/bahr/figure7_wide.png)  
**Figure 7.** Module Positions for the [Herrick Homepage](http://herrick.alfred.edu/?tp=1)

With an understanding of a template’s module positions you can then use the Module Manager to make basic changes to the front page. The Module Manager is where modules are created, edited, enabled or disabled, and assigned to defined template positions. For more complex modifications, the website developer will want to explore three files that work together to control the template: index.php, template.css, and templateDetails.xml. The Joomla documentation is a good source of information on more advanced modifications, such as adding new module positions \[[19](https://journal.code4lib.org/articles/#note19)\]. The table below shows the module names, types, and positions for Herrick’s homepage. Note that “rotating” is a new module position that wasn’t included in the JA Rutile default template.

| Module Name | Module Type | Module Position |
| --- | --- | --- |
| Top Menu | mod\_mainmenu | user3 |
| Search | mod\_search | user4 |
| Library Hours | mod\_custom | left |
| Front Rotating Images | mod\_jw\_sir | rotating |
| Tabbed Search | mod\_custom | ja-news |
| News | mod\_slick\_rss | right |
| Find | mod\_mainmenu | user1 |
| About | mod\_mainmenu | user2 |
| Requests | mod\_mainmenu | user5 |
| Help | mod\_mainmenu | user6 |
| Herrick Footer | mod\_footer | footer |

### Content Organization

Before building the site, it’s important to plan for the organization of its content. Joomla uses a three-level hierarchical system, comprised of Sections, Categories, and Articles to organize content. Each Section can contain many Categories, and each Category can contain many Articles. A good resource for getting started with organizing content in Joomla is the “Learn Joomla 1.5 Fast!” Tutorial \[[20](https://journal.code4lib.org/articles/#note20)\]. It describes the steps involved in creating articles, organizing them with Sections and Categories, and using menus to display content in the site’s front end.

### Useful Extensions

One of Joomla’s strengths is the large number of free extensions developed by its user community. In comparison to Drupal, Joomla has fewer library-specific extensions. The Joomla extensions directory includes some extensions for managing personal book collections \[[21](https://journal.code4lib.org/articles/#note21)\] and J-CAR \[[22](https://journal.code4lib.org/articles/#note22)\], a Joomla extension for DSpace. There is no Joomla equivalent to SOPAC, a Drupal module for integrating the library catalog. While Joomla currently lacks library-specific extensions, it does have many useful extensions that can be used in developing a library website. Following are some of the extensions and modules used in Herrick’s Joomla implementation:

**Sourcerer** – Sourcerer \[[23](https://journal.code4lib.org/articles/#note23)\] builds a lot of flexibility into the Joomla site by allowing you to insert custom code (PHP or HTML including Javascript and CSS) into articles and some other types of content. To use it, you simply put the Sourcerer tags around the code in the WYSIWYG editor:

{source}your code{/source}

**Wrappers** – Joomla’s wrapper module \[[24](https://journal.code4lib.org/articles/#note24)\] can be used to display other web pages within the Joomla site. This can be useful for bringing third-party content into the library website (Serials Solutions Journal Locator for example). Scroll bars can be displayed if necessary.

**eXtplorer** – This component \[[25](https://journal.code4lib.org/articles/#note25)\] provides a web-based interface, accessed through Joomla’s Control Panel, for managing and editing files on the web server. Files can be edited in eXtplorer, or eXtplorer can be used to upload and download files.

**ChronoForms** – ChronoForms \[[26](https://journal.code4lib.org/articles/#note26)\] is one of many Joomla extensions for creating web forms.

**JCE** – The default Joomla WYSIWYG editor is the TinyMCE editor. The JCE editor \[[27](https://journal.code4lib.org/articles/#note27)\], a component with its own configuration settings, is a more sophisticated editor than TinyMCE.

**GoogleMaps** – This plugin \[[28](https://journal.code4lib.org/articles/#note28)\] can be used to easily add maps to Joomla sites.

**BIGSHOT Google Analytics** – This plugin \[[29](https://journal.code4lib.org/articles/#note29)\] adds the Google Analytics tracker code across the site.

### Solving Problems Big and Small

In the process of developing our library website with Joomla, we occasionally ran into problems. Fortunately, there are a variety of resources to turn to for help. The Joomla documentation is a good first place to look for information. The Joomla Forums are the place to go to find answers to common questions, or to pose questions of your own. In our experience, the Joomla user community is very supportive. The book, *Beginning Joomla!* \[[30](https://journal.code4lib.org/articles/#note30)\], is recommended as a thorough and organized introduction to Joomla. When it comes to editing templates, many template providers provide documentation and a forum where users can share information. There are a variety of ways to become further involved in the Joomla community such as participating in forums and listservs or attending events like Joomla! Days \[[31](https://journal.code4lib.org/articles/#note31)\]. The Joomla in Libraries \[[32](https://journal.code4lib.org/articles/#note32)\] group, while not as active as the core Joomla community, provides a place to share information about using Joomla in a library setting. Those who want a more systematic approach to learning Joomla might investigate formal training opportunities.

### What’s Not to Like?

While Joomla has mostly met our library’s needs, we did discover some downsides:

- In our experience, there isn’t an easy way to create production and testing environments. Our process will likely involve two Joomla installations, and a scripted or manual process for dumping the MySQL database from one site to the other.
- While Joomla provided enough flexibility for our site, developers with strong coding skills, more ambitious goals, or a desire to control all aspects of the site might be happier with Drupal, which provides a more open-ended framework.
- Despite the large number of Joomla templates available, in our experience it can still be difficult to find a really good template. Many Joomla templates have a similar look and feel about them. It would be great to have some Joomla templates designed specifically for libraries.

### Staffing and Project Timeline

Our project was carried out for the most part by three people: a systems librarian, a library assistant for web services and digitization initiatives, and a network services support specialist in the university’s information technology services department. Teamwork was important since this was our first experience with Joomla.

We began to think about redesigning our website during the 2008-2009 academic year when we conducted a survey to gather input from library users. In the fall of 2009, we inventoried the content of our existing website in preparation for a complete reorganization. Data from Google Analytics, which we had been collecting for about two years, were used to identify the most-used content.

Beginning in the fall of 2009, the library assistant for web services led the way in exploring Drupal and Joomla, while the systems librarian focused on navigation and content. Because our existing site was about ten years old, the content needed reorganizing, editing, and in some cases rewriting. Once we made a decision to use Joomla, we selected a template and started to develop the homepage, with the goal of finalizing the homepage design and navigation before building lower-level pages. Basic homepage mock-ups were used to gather feedback from faculty, students, and librarians.

Building the site was an iterative process, with frequent meetings and discussions between the systems librarian and the library assistant for web services. The rest of the library staff and the library director were informed and consulted at key points along the way. We completed the transition to our new site during the summer of 2010.

Because none of the staff worked on the website project exclusively, it’s difficult to estimate the total amount of time that the project required. During the 2009-2010 academic year, when the bulk of the work was completed, it’s estimated that the library assistant spent about 50% of his time on the project, the systems librarian spent about 20% of her time, and the network services support specialist spent about three days in total.

Depending on the library’s goals and staffing arrangement, a similar project could be completed in a shorter timeframe. For us, the most time-consuming parts of the project were investigating CMS options and deciding to use Joomla, learning how to use Joomla, preparing the content and developing the navigation, and customizing the template. Once these steps were completed, building the site went relatively quickly.

### Measuring our Success

When we set out to redesign our library’s website, we identified the following goals, which have been mostly met by the redesign:

- A more modern design
- The ability to easily change site navigation
- Better compliance with changing web standards
- Cross-browser compatibility
- Better separation of design and content so that future design changes can be more easily accommodated
- Secure forms
- The ability for non-technical staff to edit or contribute content

The project was also driven by an overarching need to “do more with less” and to design a site that would be easier to manage going forward. In redesigning the site, we eliminated two homegrown databases, one for displaying our research by subject guides and A-Z databases list (these now reside in LibGuides) and the other for searching and browsing the library’s movie collection (patrons are now directed to the library catalog and static URLs are used to display movie lists by genre).

Since moving to the new site, we have been watching our site analytics to see what impact the new site has had on use. A comparison of some site metrics for the period of September 1 through November 13, in 2009 and 2010, appears below.

| Metric | Sept. 1- Nov. 13, 2009 | Sept. 1 – Nov. 13, 2010 | Percent change |
| --- | --- | --- | --- |
| Visits | 76,916 | 65,654 | \-14.64% |
| Page Views | 179,963 | 165,359 | \-8.12% |
| Pages/Visit | 2.34 | 2.52 | 7.65% |
| Bounce Rate | 68.00% | 64.82% | \-4.68% |
| Average Time on Site | 00:02:10 | 00:03:01 | 39.26% |
| Percent New Visits | 30.74% | 32.31% | 5.12% |

Since there are some important differences between the old site and the new site (for example, the new site has fewer pages overall and a much flatter hierarchy) it’s somewhat difficult to make direct comparisons. And, without analytics from other libraries to compare to, the best we can do is to examine our own statistics over time. While it’s disappointing to see that overall visits and page views are down, it’s difficult to know the reason for the change; it could be that the library website is becoming less essential to research tasks than it used to be. On the other hand, it’s nice to see that other statistics have improved, including a slight reduction in the bounce rate, a significant increase in the amount of time spent on the site, and an overall increase in new visits. While we have not conducted any task-based user testing, anecdotal feedback from students about the new website has been positive.

## Is Joomla “Just Right” for Your Library?

The question of whether Joomla is right for any particular library depends to some extent on the library’s needs and the web developer’s skills and expectations. In our case, Joomla provided a good match for our relatively modest needs, our staffing levels, and the skills of our librarians and staff. While library staff had some experience with coding, we were also willing to give up some customization in order to reduce the amount of time required to build the site and to lessen the overall demands of site management going forward. We chose a content management system because we anticipated that once the site was built it would be easier to manage, giving the systems librarian and web development assistant an opportunity to focus on other important projects. Support from the university’s ITS department made it possible to host the site locally.

In our opinion, while many libraries are turning to Drupal, Joomla will be a better fit for many small- and medium-sized libraries. In any case, getting hands-on experience with a variety of open source CMS’s is highly recommended, as it will allow you to make an informed choice. As previously mentioned in this paper, commercial hosting services provide a low-investment way of trying open source content management systems. And, for those libraries that don’t want the responsibility of hosting the site locally, a hosted site can be a long-term option as well. LISHost \[[33](https://journal.code4lib.org/articles/#note33)\], for example, provides low-cost web hosting services specifically for libraries. In a recent email, they indicated that they currently host two Joomla sites, about 80 Drupal sites, and at least 100 WordPress sites (email from Blake Carver of LISHost to the author, 2010 Nov 11).

When we set out to redesign our site, it was difficult to find information about using Joomla in libraries. We hope, therefore, that the information presented in this paper will be helpful to other libraries considering Joomla.

## Bibliography

\[[1](https://journal.code4lib.org/articles/#ref1)\] Framework \[Internet\]. \[updated 2010 May 18\]. Joomla! Documentation: \[cited 2010 Nov 11\]. Available from: [http://docs.joomla.org/Framework](http://docs.joomla.org/Framework)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Joomla! Features Overview \[Internet\]. c2005-2010. Open Source Matters, Inc.: \[cited 2010 Nov 11\]. Available from: [http://www.joomla.org/core-features.html](http://www.joomla.org/core-features.html)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Joomla! Extensions \[Internet\]. c2005-2010. Open Source Matters, Inc.: \[cited 2010 Nov 11\]. Available from: http://extensions.joomla.org/

\[[4](https://journal.code4lib.org/articles/#ref4)\] Joomla! Extensions Defined \[Internet\]. \[updated 2010 May 9\]. Joomla Documentation: \[cited 2010 Nov 11\]. Available from: [http://docs.joomla.org/Joomla\_Extensions\_Defined](http://docs.joomla.org/Joomla_Extensions_Defined)

\[[5](https://journal.code4lib.org/articles/#ref5)\] Mort G. 2010. Joomla vs Drupal, a coder’s perspective \[Internet\]. NYPHP Joomla SIG: \[cited 2010 Dec 9\]. Available from: http://lists.nyphp.org/pipermail/joomla/2010-July/002895.html

\[[6](https://journal.code4lib.org/articles/#ref6)\] Joomla! Resources Directory \[Internet\]. c2005-2010. Open Source Matters, Inc.: \[cited 2010 Nov 11\]. Available from: [http://resources.joomla.org/directory/support-services/hosting.html](http://resources.joomla.org/directory/support-services/hosting.html)

\[[7](https://journal.code4lib.org/articles/#ref7)\] Wallace A. 2007. Joomla! 1.5 Installation Manual, Version 0.5 \[Internet\]. \[updated 2007 Oct 30\]. Joomla! User Documentation Team: \[cited 2010 Nov 11\]. Available from: [http://downloads.joomlacode.org/docmanfileversion/1/7/4/17471/1.5\_Installation\_Manual\_version\_0.5.pdf](http://downloads.joomlacode.org/docmanfileversion/1/7/4/17471/1.5_Installation_Manual_version_0.5.pdf)

\[[8](https://journal.code4lib.org/articles/#ref8)\] SQLyog \[Internet\]. c2010. Webyog: \[cited 2010 Nov 11\]. Available from: [http://www.webyog.com/en/](http://www.webyog.com/en/)

\[[9](https://journal.code4lib.org/articles/#ref9)\] EMC NetWorker Unified Backup and Recovery Software. \[Internet\]. c2010. EMC Corporation: \[cited 2010 Nov 11\]. Available from: [http://www.emc.com/domains/legato/index.htm](http://www.emc.com/domains/legato/index.htm)

\[[10](https://journal.code4lib.org/articles/#ref10)\] Akeeba Backup \[Internet\]. c2006-2010. Akeeba Developers: \[cited 2010 Nov 11\]. Available from: [http://www.akeebabackup.com/](http://www.akeebabackup.com/)

\[[11](https://journal.code4lib.org/articles/#ref11)\] Update Manager for Joomla! \[Internet\]. \[n.d.\] Sam Moffatt Consulting: \[cited 2010 Nov 11\]. Available from: [http://sammoffatt.com.au/os/joomla-15-products/3-jupdateman](http://sammoffatt.com.au/os/joomla-15-products/3-jupdateman)

\[[12](https://journal.code4lib.org/articles/#ref12)\] Joomla! Discussions Forums \[Internet\]. c2005-2010. Open Source Matters, Inc.: \[cited 2010 Nov 11\]. Available from: [http://forum.joomla.org/](http://extensions.joomla.org/)

\[[13](https://journal.code4lib.org/articles/#ref13)\] Joomla! Security Checklist \[Internet\]. \[updated 2010 Mar 10\]. Joomla! Documentation: \[cited 2010 Nov 11\]. Available from: [http://docs.joomla.org/Category:Security\_Checklist](http://docs.joomla.org/Category:Security_Checklist)

\[[14](https://journal.code4lib.org/articles/#ref14)\] Joomla! Official Documentation \[Internet\]. \[updated 2010 Oct 29\]. Joomla Documentation: \[cited 2010 Nov 11\]. Available from: [http://docs.joomla.org/](http://docs.joomla.org/)

\[[15](https://journal.code4lib.org/articles/#ref15)\] Absolute Beginner’s Guide to Joomla! \[Internet\]. \[updated 2010 May 10\]. Joomla! Documentation: \[cited 2010 Nov 11\]. Available from: [http://docs.joomla.org/Beginners](http://docs.joomla.org/Beginners)

\[[16](https://journal.code4lib.org/articles/#ref16)\] Joomlashack \[Internet\]. c2005-2010. Joomlashack: \[cited 2010 Nov 11\]. Available from: [http://www.joomlashack.com/](http://www.joomlashack.com/)

\[[17](https://journal.code4lib.org/articles/#ref17)\] JoomlArt \[Internet\]. c2005-2010. JoomlArt.com: \[cited 2010 Nov 11\]. Available from: [http://www.joomlart.com/](http://www.joomlart.com/)

\[[18](https://journal.code4lib.org/articles/#ref18)\] RocketTheme \[Internet\]. c2010. RocketTheme, LLC: \[cited 2010 Nov 11\]. Available from: [http://www.rockettheme.com/](http://www.rockettheme.com/)

\[[19](https://journal.code4lib.org/articles/#ref19)\] How do you add a new module position? \[Internet\]. \[updated 2010 Sept 29\]. Joomla! Documentation: \[cited 2010 Nov 11\]. Available from: [http://docs.joomla.org/How\_do\_you\_add\_a\_new\_template\_position%3F](http://docs.joomla.org/How_do_you_add_a_new_template_position%3F)

\[[20](https://journal.code4lib.org/articles/#ref20)\] Bhide SR. \[n.d.\]. Learn Joomla! 1.5 Fast! \[Internet\]. \[cited 2010 Nov 11\]. Available from: [http://help.joomla.org/files/VisualGuide15.pdf](http://help.joomla.org/files/VisualGuide15.pdf)

\[[21](https://journal.code4lib.org/articles/#ref21)\] Books and Libraries \[Internet\]. c2005-2010. Open Source Matters, Inc.: \[cited 2010 Nov 11\]. Available from: [http://extensions.joomla.org/extensions/living/education-a-culture/books-a-libraries](http://extensions.joomla.org/extensions/living/education-a-culture/books-a-libraries)

\[[22](https://journal.code4lib.org/articles/#ref22)\] J-CAR \[Internet\]. c2008-2010. Wijiti Pty Ltd.: \[cited 2010 Nov 11\]. Available from: [http://www.wijiti.com/projects/j-car](http://www.wijiti.com/projects/j-car)

\[[23](https://journal.code4lib.org/articles/#ref23)\] Sourcerer \[Internet\]. c2010. NoNumber!: \[cited 2010 Dec 9\]. Available from: [http://www.nonumber.nl/extensions/sourcerer](http://www.nonumber.nl/extensions/sourcerer)

\[[24](https://journal.code4lib.org/articles/#ref24)\] Help16: Extensions Module Manager Wrapper \[Internet\]. \[updated 2010 Jul 11\]. Joomla! Documentation: \[cited 2010 Dec 9\]. Available from: [http://docs.joomla.org/Help16:Extensions\_Module\_Manager\_Wrapper](http://docs.joomla.org/Help16:Extensions_Module_Manager_Wrapper)

\[[25](https://journal.code4lib.org/articles/#ref25)\] eXtplorer \[Internet\]. 2007 \[updated 2010 Jun 10\]. Soeren Eberhardt: \[cited 2010 Dec 10\]. Available from: [http://extplorer.sourceforge.net/](http://extplorer.sourceforge.net/)

\[[26](https://journal.code4lib.org/articles/#ref26)\] What is ChronoForms? \[Internet\]. \[n.d.\]. ChronoEngine: \[cited 2010 Dec 10\]. Available from: [http://www.chronoengine.com/component/content/article/1-latest/26-what-is-chronoforms.html](http://www.chronoengine.com/component/content/article/1-latest/26-what-is-chronoforms.html)

\[[27](https://journal.code4lib.org/articles/#ref27)\] JCE \[Internet\]. c2010. joomlacontenteditor.net: \[cited 2010 Dec 10\]. Available from: [http://www.joomlacontenteditor.net/](http://www.joomlacontenteditor.net/)

\[[28](https://journal.code4lib.org/articles/#ref28)\] Plugin Googlemap \[Internet\]. c2005-2008 \[updated 2010 Jul 17\]. Open Source Matters, Inc.: \[cited 2010 Dec 10\]. Available from: [http://joomlacode.org/gf/project/mambot\_google1/](https://joomlacode.org/gf/project/mambot_google1/)

\[[29](https://journal.code4lib.org/articles/#ref29)\] BIGSHOT Google Analytics \[Internet\]. \[n.d.\]. BIGSHOT: \[cited 2010 Dec 10\]. Available from: [http://www.thinkbigshot.com/kansas-city-marketing-services/205-free-joomla-extensions.html](http://www.thinkbigshot.com/kansas-city-marketing-services/205-free-joomla-extensions.html)

\[[30](https://journal.code4lib.org/articles/#ref30)\] Rahmel D. 2007. Beginning Joomla! From Novice to Professional. Berkeley (CA): Apress.

\[[31](https://journal.code4lib.org/articles/#ref31)\] Joomla! Days Worldwide \[Internet\]. c2005-2010. Open Source Matters, Inc.: \[cited 2010 Nov 11\]. Available from: [http://community.joomla.org/events/joomla-days.html](http://community.joomla.org/events/joomla-days.html)

\[[32](https://journal.code4lib.org/articles/#ref32)\] Joomla in Libraries \[Internet\]. \[n.d.\]. \[cited 2010 Nov 11\]. Available from: [http://www.joomlainlibrary.com/](http://www.joomlainlibrary.com/)

\[[33](https://journal.code4lib.org/articles/#ref33)\] LISHost \[Internet\]. \[n.d.\]. \[cited 2010 Nov 11\]. Available from: [http://lishost.org/](http://lishost.org/)

## Authors

Ellen Bahr is Information Systems Librarian for Herrick Memorial Library at Alfred University in Alfred, NY. Email: bahr@alfred.edu.

Matt Speed is Network Services Support Specialist for the Information Technology Service department at Alfred University in Alfred, NY. Email: speed@alfred.edu.

## Acknowledgements

Ellen Bahr would like to recognize Brett Arno’s contributions to the Herrick Library website and thank him for commenting on drafts of this paper. She would also like to thank Kathryn Frederick of the Lucy Scribner Library at Skidmore College for sharing her Joomla experience with us.
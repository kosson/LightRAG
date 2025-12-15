---
title: "Course Views: A Scalable Approach to Providing Course-Based Access to Library Resources"
source: "https://journal.code4lib.org/articles/1218"
author:
  - "[[The Code4Lib Journal]]"
published: 2009-03-31
created: 2025-01-10
description: "The NCSU Libraries’ Course Views project, along with a locally developed widget web service, improves course-based access to library collections and services by dynamically generating library course pages for all 6000+ courses at NCSU. By automatically generating custom content when possible and showcasing authored content when available, Course Views is able to achieve full course [...]"
tags:
  - "clippings"
---
# Course Views: A Scalable Approach to Providing Course-Based Access to Library Resources
Jason Casden, Kim Duckett, Tito Sierra and Joseph Ryan

In August 2008, the NCSU Libraries launched Course Views \[[1](https://journal.code4lib.org/articles/#note1)\], a new online service that provides a custom library web page for every course at North Carolina State University. This service, promoted to students under the “Library Tools” brand \[[2](https://journal.code4lib.org/articles/#note2)\], has helped achieve two major objectives: to provide course-centric access to library resources on an unprecedented scale, and to integrate library resource access points into campus learning management systems (LMSs) at an improved scale and level of customization.

Course Views has been in development for several years. A project team convened in 2005 to begin working on the problem of integrating library resources with LMSs. Although originally intended to focus on LMS work, the team realized that a more profitable approach was to take a broader look at making library resources more accessible and relevant to students. The team decided to bring together the most student-centric “stuff” the library has to offer, combining traditional research-oriented content like collection search tools with more task-oriented information about library services such as citation guides, group study rooms, and device lending.

The union of collection- and service-oriented resources created an interesting opportunity for the team to create a one-stop resource tailored to the needs of students. Additionally, research showed that in comparison to subject guides, “library resources organized or delivered at a course level are more in line with how undergraduate students approach library research” \[[3](https://journal.code4lib.org/articles/#note3)\]. This research led to the development of the primary goal of the Course Views project: to develop a system that would provide useful, targeted resources for every course at NCSU.

The Libraries’ earlier efforts in this area had been far more modest, focusing on the creation of hand-authored course guides. These web pages provided high quality information, closely tailored to each course. Unfortunately, the Libraries never had the resources to create and maintain custom course guides for more than 3% of the courses offered on campus. It was clear that achieving coverage for the remaining 97% of courses would require a new approach. To achieve this goal, we needed to find a way to customize content to the course that could scale across 6,000 courses in over 150 departments on campus.

Of course, a system that covers all courses must still provide relevant content for each course. The previous hand-authored course guide approach at NCSU provided unlimited content customization options. In practice, however, not all authored course guides produced by subject specialist librarians were completely unique. In the early stages of our project we performed a content analysis of existing course guides. This analysis revealed patterns of library content that appeared across course guides, especially for guides authored by the same librarian. For example, links to the library catalog, citation tools, general purpose article databases, and bibliographic instruction content were frequently included on course guides across disciplines. Interspersed with this generic content were links to resources that were often discipline-specific, such as links to chemistry databases for chemistry courses. And in some cases, librarians included content that was only relevant to the specific course, such as resources to support class assignments.

In planning for a new system, we sought to maintain at least the same level of content customization options that existed previously, while using a centralized data-driven system to manage the generic and discipline-specific content. Doing so would free up staff time to focus on producing content that was truly course specific.

The team considered two options for this project: customizing an existing open source tool, or developing a homegrown solution, similar to efforts at other universities \[[4](https://journal.code4lib.org/articles/#note4)\]. At the time of the investigation, we were unable to find any suitable vendor solutions to this problem. Initially, the team considered adapting an existing course page authoring tool, such as the CourseLib module of Minnesota’s LibData project \[[5](https://journal.code4lib.org/articles/#note5)\], or Rochester’s LibCB project \[[6](https://journal.code4lib.org/articles/#note6)\]. While these tools facilitate the creation of consistent and attractive course pages, we believed the authored course page approach would inhibit our ability to provide customized library content for all courses at our university. After some deliberation, the team decided to develop a homegrown solution.

The team realized that the best means of enabling integration with LMSs was to organize the system’s content around a shared campus data structure. Course Views uses the standard course identifiers (e.g., ENG 101) managed by the campus registration and records system. An unanticipated benefit of structuring the system in this way is that it opened the door to automated methods of customizing content within the application, because these course identifiers reveal attributes of the course, such as discipline focus, college affiliation, or graduate vs. undergraduate status.

Balancing the requirement of a view for every course with the goal of customizing content to the greatest extent possible required creative system design. To support Course Views content delivery, the team decided to develop a “widget” web service that would provide an infrastructure for producing customized content in a scalable way. Additionally, this Widget System allows these pieces of content to be easily reused, which enables external integration of widget content.

An individual Course View (figure 1) is essentially a collection of loosely coupled content modules. The Widget System delivers all of these modules, each representing some aspect of library services or content. As a result, a Course View is a course-centric portal to library resources that tailors content based on course identifiers rather than user accounts (figure 2).

The Course Views architecture consists of two components: the Course Views handler and an underlying Widget System, both written in object-oriented PHP. The system’s URIs use the REST architectural style \[[7](https://journal.code4lib.org/articles/#note7)\]. The URI pattern consists of a curriculum code, a course number, and, optionally, a course section. For example, the Course Views request URI for the course “Adult and Higher Education (EAC) 580” is http://www.lib.ncsu.edu/course/**eac**/**580**.

The process of producing an individual Course View is as follows (steps refer to labels in figure 3):

- The Course Views handler receives the request (via Apache mod\_rewrite) from the user.
- The Course Views handler validates the course identifier through an HTTP widget request (steps A through C).
- The Course Views processing code individually requests all appropriate widgets, passing the course identifier as parameters.
1. Upon receiving a widget request, the Widget System handler parses the parameters.
2. The Widget System instantiates the appropriate widget, passing any additional parameters.
3. The requested widget collects and formats data from a variety of sources, returning content wrapped in a consistent bit of XHTML.
- The Course Views processing code assembles the XHTML results and integrates CSS, jQuery and YUI elements.
- An individual Course View is returned to the user.

![A low-level diagram of Course Views request processing](https://journal.code4lib.org/media/issue6/casden/courseviews_request_process.png)

**Figure 3:** A low-level diagram of Course Views request processing

### Widget System

The Widget System is a RESTful web service designed to manage and simplify the development of independent PHP classes which deliver easily reusable content drawn from diverse sources. The system consists of a dynamic handler, one or more abstract classes for building widgets, and a structured directory, file, and class naming pattern. Creating Course Views that were both maintainable and appropriately specific relied heavily on the encapsulation of content provided by the Widget System. Apache’s mod\_rewrite routes HTTP requests to the Widget System handler, which then checks for the existence of the requested widget and passes the URI fields and query string on to the widget for processing. It is relatively easy for a developer to create new widgets in this environment by following a few simple conventions and creating a PHP class that inherits from a base Widget class. Once this class is created, it has access to URI parameters that are blindly passed by the Widget System handler and parsed by the base Widget class.

The following example shows a very simple widget that returns librarian recommended content for a particular course or curriculum:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52 | `<?php`  `require_once``(``"lib/courseviews_widget.php"``);`  `class` `recommended_widget ``extends` `CourseViewsWidget {`  `private` `$rec_file_root` `= ``'../recommended'``;`  `private` `$rec_files` `= ``array``(``'menu.html'``);`  `public` `function` `start(){`  `$ret_xhtml` `= ``""``;`  `foreach` `(``$this``->rec_files ``as` `$rf``){`  `$crawl_ret` `= ``$this``->print_file_crawl(``$this``->rec_file_root,``"$this->dept/$this->course_bare/$this->section/$rf"``);`  `$ret_xhtml` `.= ``$crawl_ret``[1];`  `}`  `libxml_use_internal_errors(true);`  `$valid_checker` `= simplexml_load_string(``$ret_xhtml``);`  `$udept` `= ``strtoupper``(``$this``->dept);`  `if``(``count``(``$crawl_ret``[0]) >= 3){`  `$wid_title` `= ``"Recommended for $udept $this->course_bare"``;`  `} ``elseif` `(``count``(``$crawl_ret``[0]) == 2) {`  `$wid_title` `= ``"Recommended for $udept courses"``;`  `} ``else` `{`  `$wid_title` `= ``"Recommended for all courses"``;`  `}`  `$this``->set_widget_title(``$wid_title``);`  `if` `(``$valid_checker``){`  `return` `$this``->wrap_widget_content(``$ret_xhtml``);`  `} ``else` `{`  `return` `$this``->wrap_widget_content(``'<p>Malformed Content</p>'``);`  `}`  `}`  `}` |
| --- | --- |

**Figure 4:** Source code for the Librarian Recommended Widget

Example output for request http://www.lib.ncsu.edu/widget/recommended/eac/580/001:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35 | `<``div` `id``=``"recommended"` `class``=``"widget"``>`  `<``div` `class``=``"widgetHeader"``>`  `<``h2` `class``=``"widgetTitle"``>Recommended for EAC courses</``h2``>`  `</``div``>`  `<``div` `class``=``"widgetContent"``>`  `<``div` `id``=``"librarianRecommendedCard"``>`  `<``div` `id``=``"contents"``>`  `<``p` `class``=``"contentItem"``>`  `<``a` `href``=``"/distance/delivery"` `class``=``"itemLink"``>Taking A Distance Education Course?</``a``><``br` `/>`  `Get books delivered to your home or office and articles sent to you on the Web.`  `</``p``>`  `<``p` `class``=``"contentItem"``>`  `<``a` `href``=``"/recommended/eac/databases.html"` `class``=``"itemLink"``>Recommended Databases</``a``><``br` `/>`  `A more expansive set of database recommendations for Adult and Higher Education, Human Resources, and Training.`  `</``p``>`  `<``p` `class``=``"contentItem"``>`  `<``a` `href``=``"/guides/statistics"` `class``=``"itemLink"``>Finding Education Statistics</``a``><``br` `/>`  `A set of websites for finding education statistics.`  `</``p``>`  `<``p` `class``=``"contentItem"``>`  `<``a` `href``=``"/guides/apaplag/"` `class``=``"itemLink"``>APA Citation Style and Plagiarism Guide</``a``><``br` `/>`  `Tips for using APA style, citing your sources, and avoiding plagiarism.`  `</``p``>`  `</``div``>`  `</``div``>`  `</``div``>`  `</``div``>` |
| --- | --- |

**Figure 5:** XHTML output for the Librarian Recommended Widget

The widget source code in figure 4 demonstrates how the object-oriented nature of the Widget System makes creating groups of similar widgets, such as Course Views widgets, much easier. The inheritance hierarchy for this and some of the other widgets is shown in figure 6. All widgets extend the Widget abstract class, which parses the fields passed to the widget and provides some helper functions, such as the one that wraps outgoing content in a consistent XHTML stub format (figure 5). For Course Views widgets, an additional abstract class (CourseViewsWidget) extends the base widget class to provide some additional functions common to most of the Course Views widgets, like parsing course curriculum codes and numbers. By taking advantage of inheritance when using the Widget System for bigger projects, the developer can write widgets for the project that contain very little redundant code.

![Widget System class hierarchy](https://journal.code4lib.org/media/issue6/casden/widget_system_class_hierarchy.png)

**Figure 6:** Widget System class hierarchy

## Customized Content

An essential concept in Course Views is the ability to produce content at different levels of specificity in order to balance scalability with the customization of library content to specific course needs (figure 7). The team noted that certain library resources, tools, and services are applicable across many different courses (e.g. Citation Tools, Catalog Search), while other content must be customized for the course or course section (e.g. Course Reserves, certain Librarian Recommended content). There are also certain kinds of content that are more discipline-specific and can, therefore, be described at the curriculum level (e.g. Article Databases, certain Librarian Recommended content). The end result is that each Course Views page is made up of a standard set of widgets, which might vary in terms of how tailored the content is to the specified course. Leveraging the mix of generic, course section, course, and curriculum level content is the key to balancing scalability while allowing for customization by librarians. Independent widgets designed to make smart decisions about which content to display make this balance possible.

| **Widget name** | **Most specific possible level of customization** |
| --- | --- |
| Librarian Contact | Course section |
| Librarian Recommended | Course section |
| Course Reserves | Couse section |
| Course Title | Course |
| Article Databases | Curriculum |
| Quick Article Search | Curriculum |
| Catalog Search | Site |
| Citation Tools | Site |
| Google Scholar | Site |
| Librarian Chat | Site |
| Project Tools | Site |
| Technology Lending | Site |

**Figure 7:** Table of maximum possible level of customization for current widgets

The team developed a number of widgets that utilize automatically-generated content, librarian-generated content, or a combination of both. An example of a widget that relies heavily on automatically generated content is the Course Reserves widget. This widget queries the NCSU Libraries’ ReservesDirect instance and displays a list of instructors whose sections have reserves listed for the relevant course, linked directly to the ReservesDirect page for each section. Less complex automatic widgets display categorized static XHTML content, including links to project tools, citation tools, technology lending, and IM reference services.

![Display of Librarian Recommended Widget](https://journal.code4lib.org/media/issue6/casden/recommended.png)

**Figure 8:** Display of the Librarian Recommended Widget in Course Views

The Librarian Recommended Content widget is the component of a Course View that most closely resembles a traditional library course page (figure 8), and is an example of a widget where librarian-generated content plays a major role. This widget enables librarians to create sections of annotated links to relevant resources. The Course Views system employs a unique cascading content authoring and display scheme, where a librarian could author a set of custom resources that is intended to be displayed for a specific section, a course, an entire curriculum (e.g. Adult and Higher Education), or for all courses. The system searches for the most customized content possible, and then falls back to increasingly general levels until it locates content for the Course View. This technique is the key to maximizing the benefits of limited staff time by allowing subject specialists to customize content to a course if desired or to present curriculum-level content if more specific content is not necessary. The use of default content, as well as the availability of curriculum level content for all curricula, enables Course Views to scale for all courses on campus.

The Article Search widget depends both on pre-existing data and data tailored by subject librarians for the widget. The entire widget is supported by a simple database of associations between subjects from our existing Browse Subjects tool \[[8](https://journal.code4lib.org/articles/#note8)\] and campus curriculum codes. Subject librarians manually assign these associations, and a query returns the appropriate subjects at runtime. These subjects are displayed in the Databases by Subject section and also power Course Views’ basic metasearch tool. An algorithm selects one of the fourteen default search categories based on these curriculum-to-subject associations. A search from the Quick Article Search box is redirected to a collection of databases from a single vendor (e.g. EBSCOHost, CSA). Subject specialists select the vendor and package of databases for each subject category. The database options are limited to vendors which support automatically generated search URIs.

## Interface Design

The project team was interested in a design that would identify Course Views as a resource created especially for students. Working with an undergraduate student in the NCSU College of Design, the team created a layout and visual identity that featured a task-oriented layout with a fresh look and feel. A key requirement for the interface was that the site display well in browsers in use by the majority of library users. The following list describes the web browsers used by approximately 95% of the visitors to our main library website as of August 2008:

| **Windows** | **Mac OS** |
| --- | --- |
| Internet Explorer 6 | Firefox 2.x |
| Internet Explorer 7 | Firefox 3.x |
| Firefox 2.x | Safari 3.x |
| Firefox 3.x |  |

The team chose YUI \[[9](https://journal.code4lib.org/articles/#note9)\] for page layout and jQuery \[[10](https://journal.code4lib.org/articles/#note10)\] for visual effects.

Course Views makes limited use of YUI. Primarily, the project uses YUI’s reset-fonts-grids CSS file for page layout and browser style resets. The team elected to use YUI’s page layout CSS because it provides several customizable fixed-width, multicolumn layouts that display properly across all supported browsers. The bundled reset CSS made it even easier to create a consistent user experience across browsers by forcing explicit CSS declarations for all page elements.

One particular challenge that the design needed to solve was the need to present a lot of information in a limited space. The team decided to combine the various search widgets into a single tabbed widget. After some experimentation with YUI’s tabs, the team chose jQuery UI’s tabs because of their semantic markup and ease of use. Course Views also uses jQuery functions for a host of small changes on the site, including creating a two-column list and moving elements around in the DOM. Thickbox \[[11](https://journal.code4lib.org/articles/#note11)\] displays the welcome overlay \[[2](https://journal.code4lib.org/articles/#note2)\], and Cycle \[[12](https://journal.code4lib.org/articles/#note12)\] powers the Technology Lending widget.

## Integration

### Learning Management Systems

Several different learning technology systems are in use at NCSU: WolfWare (a homegrown system), Blackboard Vista, and Moodle. Integration into these systems is a good strategy for reaching out to students because 89% of enrolled students have at least one course using an LMS.

WolfWare, which is not a full-featured LMS, now displays deep links to Course View pages in its global navigation. It provides at least one class page for 75% of students. Blackboard Vista, formerly WebCT Vista before the companies were merged, is the most popular LMS in use on campus, with 69% of students using it for at least one course each semester. The Moodle installation is a pilot project run by several colleges and units on campus, and provides access to at least one course for 11% of students. Moodle usage is expected to increase over the next few years.

It is fairly straightforward to integrate external data into Moodle courses by developing Moodle “blocks” in PHP. The Course Views block, which draws its content from a widget, links directly to the Course View for the given course. It is available to all instructors and classes and can be added with just a few clicks. The product team is working to have the Moodle block included in all new courses by default.

Automatic integration with Blackboard Vista has not been achieved due to a variety of technical and organizational constraints. The Blackboard Vista PowerLinks Kit \[[13](https://journal.code4lib.org/articles/#note13)\] enables developers to integrate content into Blackboard Vista courses. Unfortunately, developing PowerLinks requires access to a development instance of Blackboard Vista as well as access to course data for building the links, neither of which were available at the time of development. As a result, we are not currently automatically integrating Course Views content into Blackboard Vista. At this point, instructors can temporarily grant a librarian access to their course sections so that the librarian can add a link to Course Views. Between July 2008 and January 2009, instructors made 940 requests for Course Views links. Fall 2008 requests from instructors provided Course Views access for approximately 25% of the course sections in Vista.

### NCSU Libraries Website

We also provide deep integration of Course Views content into the library website. Beyond static links that appear on the library homepage and the Learning Commons site, the team took a look at existing information discovery systems to see if there were additional opportunities to promote the new tool. The first successful integration was with QuickSearch, the library website’s integrated search system. Searching for a curriculum code and course number (e.g. ENG 101 or ENG101) generates a page of matches, with links to the relevant Course View at the top of the page, marked as a “Best Bet.” We also embed course-specific Course Views links into our installation of ReservesDirect. This provides students who access the reserves system directly an opportunity to discover a broader collection of services and resources for their course.

## Collaboration

The Course Views project would not have been possible without a high level of collaboration among various groups. The project team worked closely with subject specialists, reserves librarians, and students to ensure that the final product would be a system that met everyone’s needs. Subject specialists, in particular, are critical partners for the development team. Their expertise in selecting resources for courses, as well as their interest in promoting the system to faculty and students, are crucial for the success of the Course Views project. Throughout every phase of the project, the development team consulted with subject specialists to assure that they understood and valued the project, and had ample opportunity to voice their opinions and concerns.

The development team also worked closely with campus colleagues who run learning management systems and train faculty in their use. The successful integration into WolfWare, Blackboard Vista, and Moodle would not have been possible without close collaboration with these partners. They also serve as important allies in marketing Course Views to faculty.

The project team involved students in pre-development focus groups centered on concept-testing and gathering feedback on which widgets would be most useful. Post-launch student focus groups have also provided invaluable feedback to shape the project’s next steps. Faculty have been involved in pilot projects with Course Views pages and working with subject specialist librarians to tailor content to their courses. Their interest in including library resources and e-reserves in their online course environments has also driven the project from its inception.

Course Views is built upon successful collaboration across organizational lines both within the library and across campus. This collaboration resulted in a final product that both met the needs of all stakeholders and generated a wide sense of ownership and involvement that is crucial to the promotion and adoption of Course Views.

## Usage

Initial usage data from the Fall 2008 semester indicates that Course Views has been a success in increasing student use of library resources, despite modest promotion. During this time period, Course Views rendered an average of 1,162 pages per semester week, generating an average 1,073 clicks (on links or buttons) each week. Controlling for some internally generated usage data and a normal end-of-semester drop, we have observed a mild downward trend of Course Views requests throughout the semester (figure 9). The team is investigating possible explanations for this trend, and using it as an opportunity to improve the project’s integration, customization, and promotion.

Course Views uses a custom logging system that anonymously tracks requests to individual Course Views as well as “clicks,” which are defined as link clicks or form submissions. By implementing a custom solution, we are able to track Course Views usage at a much finer level than what is possible by analyzing standard web server logs alone. As a result, we are able to discretely measure requests for courses, curricula, and the use of individual widgets.

![Fall Semester 2008 Course Views Requests and Clicks](https://journal.code4lib.org/media/issue6/casden/request_clicks_chart_fall08_small.png)

**Figure 9:** Fall semester 2008 Course Views requests and clicks

Using these logs, the team discovered an interesting anomaly that occurred in Week 14 of the semester. In typical usage, there is a roughly 1-to-1 correspondence between page requests and clicks, which is to say that the users typically perform one click transaction for each Course View request. In Week 14, however, the ratio was closer to 1.6-to-1. These clicks were the result of Course Views being used to display references for a research assignment in a specific course (Chemical Engineering 205). This anomaly suggests that deepening collaborative relationships with faculty has the potential to increase Course Views usage dramatically.

![Fall semester 2008 Course Views clicks by widget](https://journal.code4lib.org/media/issue6/casden/widget_clicks_chart_fall08_small.png)

**Figure 10:** Fall semester 2008 Course Views clicks by widget

The chart in figure 10 is clear evidence that widgets based on dynamic content (the “reserves,” “search,” and “recommended” widgets) account for dramatically higher use (92.2%) than the remaining widgets, which display static data for all courses (7.8%). In particular, the reserves widget has been extremely popular, receiving 48.2% of all clicks. This usage pattern suggests that future development efforts should focus on enriching Course Views with more dynamically generated content.

The usage observed so far suggests the project has been successful in expanding the reach of library content for courses. In the Fall semester of 2008, Course Views served pages for 1368 unique courses, a ten-fold increase over the coverage we previously were able to achieve with authored course guides.

## Future Directions

The results of our Fall 2008 student focus groups, combined with continuing collaboration with subject specialists and campus LMS stakeholders, will shape the next steps in the evolution of Course Views. The team is focusing on making it easier for librarians to author and maintain their content, as well as integrating design improvements. Subject specialists have been eager to contribute new ideas for widgets. New mappings between course data and library resources may also make it possible to display content tailored to distance education and graduate-level courses. Additionally, the system is being further enhanced to display some information discipline-wide and to associate curricula with a branch library.

The Course Views project has accomplished its goals of providing full course coverage that is customizable to the course. Our main focus at this point is to increase the actual usage of the service, through further technical developments, improved outreach, and more finely customized content. Whatever form Course Views takes in the future, it will evolve by the same means with which it developed: close collaboration with a broad range of stakeholders.

## Notes

[\[1\]](https://journal.code4lib.org/articles/#note1) NCSU Course Views project page [http://www.lib.ncsu.edu/dli/projects/courseviews/](http://www.lib.ncsu.edu/dli/projects/courseviews/)

[\[2\]](https://journal.code4lib.org/articles/#note2) NCSU Course Views frontpage [http://www.lib.ncsu.edu/course](http://www.lib.ncsu.edu/course)

[\[3\]](https://journal.code4lib.org/articles/#note3) Reeb, Brenda, and Gibbons, Susan. “Students, Librarians, and Subject Guides: Improving a Poor Rate of Return.” Libraries and the Academy 4.1 (2004): 123-130. [(COinS)](https://journal.code4lib.org/coins)[![](https://journal.code4lib.org/articles/skin/article_linker.gif)](http://sm2nn8xb3j.search.serialssolutions.com/?genre=article&genre=article&atitle=Students%2C%20Librarians%2C%20and%20Subject%20Guides%3A%20Improving%20a%20Poor%20Rate%20of%20Return&title=Libraries%20and%20the%20Academy&stitle=portal%20Libraries%20and%20the%20Academy&issn=1530-7131&eissn=1530-7131&date=2004&volume=4&issue=1&spage=123&epage=130&aulast=Reeb&aufirst=Brenda&au=Brenda%20Reeb&au=Gibbons%2C%20Susan&id=doi%3A10.1353%2Fpla.2004.0020&sid=libx "Search ArticleLinker: Find Full-Text for this item")

[\[4\]](https://journal.code4lib.org/articles/#note4) Corrado, Edward M., and Frederick, Kathryn A. “Free and Open Source Options for Creating Database-Driven Subject Guides.” Code4Lib Journal 2 (2008). Retrieved from <[http://journal.code4lib.org/articles/47](https://journal.code4lib.org/articles/47)\>.

[\[5\]](https://journal.code4lib.org/articles/#note5) LibData [http://libdata.sourceforge.net/](http://libdata.sourceforge.net/)

[\[6\]](https://journal.code4lib.org/articles/#note6) LibCB [http://sourceforge.net/projects/libcb/](http://sourceforge.net/projects/libcb/)

[\[7\]](https://journal.code4lib.org/articles/#note7) Richardson, Leonard, and Sam Ruby. RESTful Web Services. Sebastopol, CA: O’Reilly Media, Inc., 2007. [(COinS)](https://journal.code4lib.org/coins)[![](https://journal.code4lib.org/articles/skin/article_linker.gif)](http://sm2nn8xb3j.search.serialssolutions.com/?genre=book&genre=book&title=RESTful%20Web%20Services&title=RESTful%20Web%20Services&aulast=Richardson&aufirst=Leonard&au=Leonard%20Richardson&date=2007&pub=O%27Reilly%20Media&place=Sebastapol%2C%20CA&sid=libx "Search ArticleLinker: Find Full-Text for this item")

[\[8\]](https://journal.code4lib.org/articles/#note8) NCSU Browse Subjects [http://www.lib.ncsu.edu/subjects/](http://www.lib.ncsu.edu/subjects/)

[\[9\]](https://journal.code4lib.org/articles/#note9) The Yahoo! User Interface Library [http://developer.yahoo.com/yui/](http://developer.yahoo.com/yui/ "YUI")

[\[10\]](https://journal.code4lib.org/articles/#note10) jQuery [http://jquery.com/](http://jquery.com/)

[\[11\]](https://journal.code4lib.org/articles/#note11) ThickBox [http://jquery.com/demo/thickbox/](http://jquery.com/demo/thickbox/)

[\[12\]](https://journal.code4lib.org/articles/#note12) Cycle [http://malsup.com/jquery/cycle/](http://malsup.com/jquery/cycle/)

[\[13\]](https://journal.code4lib.org/articles/#note13) Blackboard PowerLinks [http://www.blackboard.com/Communities/Partners/PowerLinks/What-are-Powerlinks.aspx](http://www.blackboard.com/Communities/Partners/PowerLinks/What-are-Powerlinks.aspx)

## About the Authors

[Jason Casden](http://www.lib.ncsu.edu/staff/jmcasden/) is the Digital Technologies Development Librarian at NCSU Libraries, where he develops and implements scalable digital library applications.

[Kim Duckett](http://www.lib.ncsu.edu/staff/klducket/) is the Principal Librarian for Digital Technologies and Learning at NCSU Libraries, where she leads efforts to improve the library’s outreach in technology-enriched learning environments.

[Tito Sierra](http://www.lib.ncsu.edu/staff/tsierra/) is the Associate Head for Digital Library Development at NCSU Libraries, where he leads a team that develops new digital library applications and services.

[Joseph Ryan](http://www.lib.ncsu.edu/staff/jdryan/) is the Digital Projects Librarian at NCSU Libraries, where he works as a project manager for digital library projects and advocates for good user experience practices.
---
title: "The ICAP (Interactive Course Assignment Pages) Publishing System"
source: "https://journal.code4lib.org/articles/63"
author:
  - "[[The Code4Lib Journal]]"
published: 2008-03-24
created: 2025-01-10
description: "The ICAP publishing system is an open source custom content management system that enables librarians to easily and quickly create and manage library help pages for course assignments (ICAPs), without requiring knowledge of HTML or other web technologies. The system's unique features include an emphasis on collaboration and content reuse and an easy-to-use interface that [...]"
tags:
  - "#publishing/system"
  - "#ICAP"
  - "#system/architecture"
---
# The ICAP (Interactive Course Assignment Pages) Publishing System
Margaret Mellinger, Kim Griggs

The [ICAP publishing system](http://ica.library.oregonstate.edu/about/index.html) is an open source custom content management system that enables librarians to easily and quickly create and manage library help pages for course assignments (ICAPs), without requiring knowledge of HTML or other web technologies. The system’s unique features include an emphasis on collaboration and content reuse and an easy-to-use interface that includes in-line help, simple forms and drag and drop functionality. The system generates dynamic, attractive course assignment pages that blend Web 2.0 features with traditional library resources, and makes the pages easier to find by providing a central web page for the course assignment pages. As of December 2007, the code is available as free, open-source software under the GNU General Public License.

## ICAP Project<sup><a href="https://journal.code4lib.org/articles/#1" title="Note #1">[1]</a></sup> Background

This project originated in a 2005 needs assessment conducted by Oregon State University Libraries (OSUL) to determine the best approach for connecting students with the wealth of information available to them through the library. We were particularly interested in lowering the barriers to library use for undergraduates searching for topical information. Initially, we considered building undergraduate portals based on colleges or subjects, but as we gathered data, read about undergraduate research activities and habits, and listened to students, we changed the direction of our subsequent project.\[[2](https://journal.code4lib.org/articles/#2 "Note #2"), [3](https://journal.code4lib.org/articles/#3 "Note #3")\] Undergraduates, especially lower division students, identify more with courses they are currently taking than with a specific college or subject. They prefer clear starting points for library research, need to save time, and are very interested in resources that have been recommended by their instructors. Rather than developing generic subject or college portals, we focused on library help pages that are tightly aligned with courses and assignments, include some interactive or Web 2.0 features, and are also simple for subject librarians to create and maintain. The internal name we have been using for the project is “Interactive Course Assignment Pages,” or ICAPs.

We investigated a variety of ways to deliver the course-centric, interactive web pages: library portal software, campus portal software, course management software, content management systems, and web page templates. Because we wanted to lower barriers to participation, we were wary of implementing library portal software that would require students to log on and create profiles. We were interested in the possibility of developing a tool that integrated with campus portal software, but it was not an option, as our institution evaluated and declined to purchase a campus portal system. Because we wanted to integrate library resources with particular courses, we carefully considered the campus course management system, Blackboard, but there were several challenges with a potential Blackboard integration. Blackboard is not used universally across our institution, it is not as flexible and customizable as we envisioned our pages, and it was not apparent that the Blackboard team had the resources to work with us on developing a new service. OSUL has a long-term plan to move the library web pages into a content management system, but it was not in place when we started this project. We tested static HTML templates as an early prototype of the course assignment pages, but they did not allow librarians to easily publish or re-use content. When we reached this stage of the project, we realized we needed to hire a programmer, and before we did so, we wrote use case scenarios and distilled from those the baseline project requirements.

## Project Requirements

The project requirements fell into two large categories:

End User Requirements

- Library course pages that are easily found on the OSU Libraries home page
- Pages that are discoverable by course number
- Pages that have content recommended by instructors as well as librarians
- A quick search box (federated search tool)
- Modules that help students find books, articles, the best web sites, style guides, course reserves, news feeds
- Link to chat service for live librarian help.
- Modules to provide greater interactivity

Functional Requirements

- Generate course assignment pages with a consistent look and feel
- Enable librarians without technical knowledge to create pages
- Provide a web interface for content input
- Provide the ability to choose which modules appear in the web page
- Provide the ability to choose which databases to search in the federated search
- Provide the ability to view RSS feeds on the page
- Provide the ability to generate an RSS feed for the page
- Allow the addition of Learning Objects (small movies that instruct students on research concepts or library tools )
- Provide the ability for librarians to change the content and headers of the modules manually
- Manage the publishing of the web pages to the libraries’ web server
- Provide permissions and authorization control
- Support content re-use among course assignment pages
- Provide a framework to support further interactive features and content re-use

The programmer came on board in September 2006 and explored available proprietary and open source solutions that might meet the project requirements. The programmer reviewed the University of Minnesota’s *LibData and CourseLib* \[[4](https://journal.code4lib.org/articles/#4 "Note #4")\] but found that the complexity and comprehensiveness of the software was not a match for this project. *CourseLib* requires a significant amount of set up, and we wanted instead to allow librarians to contribute and manage the content, without heavy administrative overhead. Also, the interface seemed complicated and required users to have some HTML knowledge to format text. University of Rochester’s *Library Course Builder* \[[5](https://journal.code4lib.org/articles/#5 "Note #5")\] met the requirement of focusing on the course, but as the tool is built in ColdFusion, OSUL would have had to buy the software, set up a special server, and find ColdFusion programmers. This did not seem to be a good way to leverage server space and programmer capacity when the development environment at OSUL favors MySQL, PHP and Ruby on Rails. While Ithaca College’s *Subjects Plus* \[[6](https://journal.code4lib.org/articles/#6 "Note #6")\] uses PHP and MySQL and would have fit into OSUL’s current development infrastructure, it would have needed to be extended to meet our project requirements, as it focuses on the broader subject level and is set up to build lists of recommended resources from their library catalog and database lists. After getting a clear picture of the computing environment at our institution and inventorying the available open source and proprietary software, we chose to build a custom solution.

## About the ICAP Publishing System

The ICAP publishing system is a custom content management system that enables librarians to easily and quickly create and manage course assignment pages (ICAPs). ICAP is a dynamic system; rather than forcing users to write code, it takes care of those details and lets librarians focus on the actual content to be displayed. This makes it easy for librarians to quickly add or change content, without requiring knowledge of HTML or other web technologies. The system’s unique features include an emphasis on collaboration and content reuse and an easy-to-use interface that includes in-line help, simple forms and drag and drop functionality. The system generates dynamic, attractive course assignment pages that blend Web 2.0 features with traditional library resources, and makes the pages easier to find by providing a central web page for the course assignment pages.

The publishing system includes a user interface that allows librarians to create, edit, copy, share, and publish course assignment pages. The tool also automates the task of sending the URL of a page to the instructor. In the current workflow, an administrator registers a librarian and provides them with a temporary login / password. A librarian then logs in and can create new pages or edit their pages, modules, and account. Once a page is created, librarians can add content, in what we call modules, to the page. Currently, there are modules for a Librarian and Instructor profile, an assignment module, a RSS module, a federated search module, course reserves module, custom content module and a widget module. The Librarian profile can include an image and a chat box. Both the Librarian and Instructor module provide contact information and links to related websites. The assignment module includes links to the assignment, syllabus and custom content. The Librarian, Instructor, and Assignment modules are designed to communicate to the student that the pages are recommended by their instructor and to increase student awareness of the subject librarians. The custom content module includes a WYSIWYG (What You See Is What You Get) text editor. The WYSIWYG editor enables librarians to easily add links, images, lists and formatted text without using HTML or Wiki mark-up. The widget module includes a code editor that can be used to embed 3rd party widgets, like YouTube, Google Custom Search box, and LibraryThing. The module for OSUL’s federated search engine, LibraryFind \[[7](https://journal.code4lib.org/articles/#7 "Note #7")\], can be customized to search selected databases. The course reserves module automatically pulls information from our catalog and the RSS module aggregates and displays data from a RSS feed. Users can share their pages with other system users and publish their pages to the OSUL website through the interface.

**Librarian Interface:**

[![Librarian's Interface for adding Modules](https://journal.code4lib.org/wp-content/uploads/2008/03/addmodules.thumbnail.png)](https://journal.code4lib.org/wp-content/uploads/2008/03/addmodules.png "Librarian's Interface for adding Modules")

**Custom Content Interface:**

[![Custom Content Interface](https://journal.code4lib.org/wp-content/uploads/2008/03/createmoduleformsmall.thumbnail.png)](https://journal.code4lib.org/wp-content/uploads/2008/03/createmoduleformsmall.png "Custom Content Interface")

The course assignment pages the system creates are Netvibes-inspired, with modules that chunk the content under helpful headers. The pages maintain a consistent look and feel that harmonizes with the rest of the library web site and ensure web and accessibility standards through the use of CSS and templates. We wanted the pages to have a consistent look and feel, so the system controls the design of the pages, but lets librarians choose from a one or two column layout. Both content within the page and the layout of that content can be customized to a certain extent. The interfaces of both the ICAP system and course pages were carefully designed with all of our users in mind.

**Example of ICAP page:**

[![Example of ICAP page](https://journal.code4lib.org/wp-content/uploads/2008/03/icapexamplesmall.thumbnail.png)](https://journal.code4lib.org/wp-content/uploads/2008/03/icapexamplesmall.png "Example of ICAP page")

## Designing the ICAP system

The ICAP team was committed to employing user-centered design techniques while developing the project. User-centered design (UCD) is a process in which the user’s needs, wants, and limitations are considered at every stage of the development cycle. It was necessary to involve our three user groups, Librarians, Students and Faculty, to increase buy-in, facilitate using Web 2.0 applications, avoid feature creep, and most importantly, improve the user interface. Usability testing is an iterative process; it is important to conduct usability testing throughout the development cycle. By designing for our users and then testing with our users, we acquired built-in early adopters, quality assurance, and an invaluable knowledge base.

The first phase of the project was to develop a design and define the basic functionalities of the interfaces based on the use-case scenarios for each user group. The student interface (the course assignment pages) was designed with the guiding principles of saving students’ time and helping them discover quality resources for their course work. We developed an HTML template that was used with students for three terms beginning in Spring 2006. With the help of course instructors in five classes, we surveyed 130 students about their experience with the course assignment pages \[[8](https://journal.code4lib.org/articles/#8 "Note #8")\]. The results of this survey helped us identify what was working and what changes needed to be made to the pages. We found that some students were not using the pages because they did not know about them. We needed to make the pages more findable from the Library home page and embed links and information about the pages in the course web pages and syllabuses. We also found that students needed help navigating through the many resources libraries offer and to address that we created pages that better supported both browsing and searching. Students wanted to be able to connect to the reference librarian outside of the library, so we added more communication options to the pages. Most importantly, the majority of the students responded positively to the pages and indicated that after they learned about them they did use them. We have continued to solicit feedback from students in the form of online surveys, chats, and emails and will soon undertake a more in-depth assessment of the pages and their effectiveness for students.

Next, we developed the ICAP tool. Working with a graphic design student, we first developed a paper prototype of the ICAP tool’s interface. We started with a paper prototype because we did not want to commit to any one solution or development framework before we had a good idea of the librarians’ needs. The prototype demonstrated only the core functionalities, which allowed for more interaction with the system, such as interacting with error pages. We first tested the paper prototype with five librarians who had varied technical skills. We asked the librarians to perform five core tasks (create, edit, clone, share, email URL) with the prototype while thinking aloud \[[8](https://journal.code4lib.org/articles/#8 "Note #8")\]. We also evaluated the tool on librarians’ success rate based on the time it took to perform tasks and the number of errors made. At the end of each task the librarians rated levels of satisfaction and ease of use. After completing the test, participants rated their overall impression of the tool and offered suggestions and feedback.

The results from that initial study indicated that since OSUL librarians had been using Dreamweaver and Contribute, their mental models of the process of creating web pages did not match the tool’s interface. This resulted in confusion over terminology and workflow while editing and cloning (copying) a page. We changed the terms and workflow to align more closely with the familiar Microsoft model of file operations (open, copy and save as). Because the librarians could not find what they needed to complete some of the tasks, we reworked the interface to make navigation easier. One main goal of the tool was to alleviate technical gaps among the librarians. We hoped that we could use wiki-style editing to give the librarians control over the format of the custom content they create for the pages. But we found that the wiki-editing was too difficult for some and that the librarians preferred formatting text in the manner of Microsoft Word.

Using all these results, we built a prototype of the tool in Ruby on Rails and had three different librarians conduct the same test on the interactive interface, which uncovered more terminology confusion and additional workflow issues. After addressing these issues with iterative testing, we released the system in spring 2007. Knowing when to stop testing and release the project is never easy. We used our use-case, goals and deadlines to define the initial beta release, knowing we were going to continue to develop the tool. During the beta release, we set up a forum for librarians to provide feedback and to facilitate open communication between the users and the development team. From the forum feedback and other conversations, we improved the workflow to make the tool easier to use and added new functionalities based on the needs and requests from the librarians. We have rolled out new feature sets at the end of every term since the first release and periodically offer training.

A word of caution about following the “release early and often” mantra: when releasing beta projects it is important to manage the user group’s expectations and perceptions through clear communication. Releasing without the full feature set can turn potential users off and decrease faith in the project, unless users trust that the beta product will evolve to suit their needs. Even though we employed user-centered design techniques and iteratively conducted user testing, users still doubted that the tool would meet their expectations. We learned quickly that we needed to increase communication and user involvement. Feedback is solicited in a variety of ways, including user testing, user training, a discussion forum, surveys, email, meetings, and other forms of personal communication. Releasing new feature sets in response to user feedback restored faith in the project and created a sense of ownership in the product which built an unanticipated level of adoption.

## ICAP System Architecture

The ICAP system technology stack consists of Ruby on Rails, MySQL, Mongrel and Apache.

[![ICAP System Architecture](https://journal.code4lib.org/wp-content/uploads/2008/03/clientdiagramjpeg.thumbnail.jpg)](https://journal.code4lib.org/wp-content/uploads/2008/03/clientdiagramjpeg.jpg "ICAP System Architecture")

The ICAP system is implemented in Ruby on Rails (Rails), an open source web application development framework.\[[9](https://journal.code4lib.org/articles/#9 "Note #9")\] Rails provides all the components necessary to build complete database-backed web applications. Rails is an MVC (model, view, controller) framework. The model-view-controller (MVC) design pattern separates the data access (model) and business logic (controller) from the data presentation and user interaction (view). Rails provides ‘out of the box’ scaffolding which can construct most of the user interface needed for a basic website. Rails targets a fast development cycle with zero turnaround time, which enabled us to iteratively test and immediately refine our prototypes.

The ICAP system is mounted on an Apache web server in conjunction with Mongrel, an open-source *http* library and web server. The system uses MySQL as the database and is locally hosted on UNIX servers. The database consists of 20 relational tables and rich complex relationships. For example, the resource table is a polymorphic table that uses Rails *:through* clause for the associations of the different modules to the page they belong to. The use of a polymorphic table enables us to easily add new module types to the system without having to build multiple near-identical join tables and complex insertion methods to maintain the relationships. The following code snippet demonstrates the polymorphic relationships and the helper methods that ease the selection and insertion process of a page’s modules.

```
/**
 * Resource Table Migration
 * Builds a polymorphic table that associates the different module types
 * (librarian, instructor, course reserves) to the page that they belong to.
 * The table uses the page id and the
 * module id and the module type to make the associations.
 **/  

class CreateResources < ActiveRecord::Migration
   def self.up
     create_table "resources", :force => true do |t|
       t.column "page_id", :integer
       t.column "module_id", :integer
       t.column "module_type", :string
       ...
     end
   end  

/**
 * Resource Model
 * Tell the class it has a virtual association by setting polymorphic to true. This
 * creates an interface that the modules can then associate with. We must also tell the
 * resources that they belong to a page.
 *
 **/
 class Resource < ActiveRecord::Base
 belongs_to :page
 belongs_to :resource, :polymorphic =>true
 ...  

/**
 *Page Model
 *Tell the pages about its resources
 **/
 class Page < ActiveRecord::Base
 has_many :resources
 ...  

/**
 *  Assignment Module Model
 *  Associate the modules to resources as a resource so that it uses the Module ID
 *  instead of the Assignment ID in the polymorphic table.
 *  Tell the module it belongs to a page through resources
 **/
 class Assignment < ActiveRecord::Base
 has_many :resources, :as => :resource, :dependent => :destroy
 has_many :pages, :through => :resources
 ...  

/**
 * Page Model
 * Methods to add and get a page's modules
 **/
 // get the collection of associated modules. Each module is automatically cast to its model class
 def modules
     mods = resources.collect {|a| a.resource }
    return mods
 end  

//Create the resource and build the association of the page to a module through resources
   def link(mod)
       resource = Resource.create(:resource => mod)
       self.resources << resource
   end  

/**
 * What we can do now...
 **/  

//Get a page using Rails dynamic finder
 page = Page.find_by_title("English Comp") #->

//Create and add some modules to a page
 page.link(Assignment.create(:name => "Course Assignment"))
 page.link(Librarian.create(:name => "Course Librarian"))  

//Get the names of the modules on this page
 page.modules.each do |module|
      module.name
 end
 #-> "Course Assignment", "Course Librarian"
```

One requirement of the tool was to provide authorization and permission controls. There are currently two types of users in the system: authors and admins. Authors can create new pages and modules and edit only the pages and modules belonging to them. An admin user can register new users, create new pages and modules, edit all the pages and modules, and grant ownership of any page to any user within the system. To secure a user’s account, the password runs through a SHA1 encryption with a randomly generated salt value. Once a user is authorized in the system, the user ID is stored in a session variable. This session value is used in a Rails *before\_filter* that constrains the dynamic finder with the criteria that the owner of the page or module must match the current user. This prevents a user from editing pages and modules they do not own. Other precautions exist in the code to protect against security risks. One particular security challenge we faced was how to allow the addition of 3rd party widgets to the system. To allow widgets, we have to let users embed HTML tags that can expose the database to cross-site scripting. We are in the process of enhancing our widget module with a custom sanitization method that uses complex regexs to strip out and rebuild the code snippets from popular widget sources. Adding the sanitization process secures our database from malicious code while still allowing librarians to add some 3rd party widgets to their pages.

Another requirement of the tool was to provide interoperability with other applications. For example, we wanted the tool to be able to interact with our OSUL federated search engine, LibraryFind, and Oasis, the OSUL library catalog. To interact with LibraryFind, we use its API to target the selected databases chosen by the librarian and to send an http request to the web service. The search results are displayed in a new window. Pulling course reserves from Oasis was not as easy. Since we do not have access to the Oasis database and it does not provide an API, we could not simply query it for the data. Instead, we have implemented a screen scraper to accomplish the data transfer from Oasis to the ICAP database. Rails’ web scraping library, *net/http*, provided an excellent means for developing our screen scraping program. Because each ICAP page is required to have a subject and course number (the required attributes of an Oasis course reserve search) this made it easier to process the resulting display output from the catalog, extract the desired data, and pass it on to the ICAP system for use in a course assignment page.

Since Rails provides so much help with building the back end, we were able to place a high priority on the user interface for the ICAP system. AJAX and CSS are well integrated into the Rails framework, which made adding features like drag and drop, inline help, simple forms, and helpful feedback to the tool’s interface faster and easier. The first release of the ICAP publishing tool did not allow the librarians to arrange the modules on a page. We quickly found out that this was a flaw in the design and we needed to implement a way for them to do so. One option was to add a position field in the module database and have the user enter a number in a form to indicate the position on the page. This can be confusing, especially when working in a grid format, and did not test well. Based on feedback, we decided to add the ability to drag a module around on a page to arrange it. The first code snippet below is the portion of the view that lists a page’s modules. The second snippet is what we added to the code to provide the drag and drop functionality:

```php
/**
* Edit Modules View
* List of a Page's Modules in a two column layout
* Without Drag and Drop
**/  

<ul id = "right">
<%@mods_right.each do |mod| %>
<li class = "list-item">
<span class="list-title" ><%=truncate(h(mod.module_title) ,30) %></span>
</li>
<% end %>
</ul>
```
```
<ul id = "left">
<%@mods_left.each do |mod| %>
<li class = "list-item">
<span class="list-title" ><%=truncate(h(mod.module_title) ,30) %></span>
</li>
<% end %>
</ul>  

/**
* Edit Modules View
* List of a Page's Modules in a two column layout
* With Drag and Drop
**/
<ul id = "right">
  <%@mods_right.each do |mod| %>
   <li  id = "item_<%=mod.id%>" class = "list-item"> //add a unique id for each module
      <span class="list-title" ><%=truncate(h(mod.module_title) ,30) %></span>
            <span class = 'handle'> Drag & Drop </span>
   </li>
  <% end %>
</ul>  

<ul id = "left">
  <%@mods_left.each do |mod| %>
   <li  id = "item_<%=mod.id%>" class = "list-item"> //add a unique id for each module
      <span class="list-title" ><%=truncate(h(mod.module_title) ,30) %></span>
            <span class = 'handle'> Drag & Drop </span>
   </li>
  <% end %>
</ul>  

/**Create a sortable element out of each list. This makes each item in the list (through the unique IDs)
* draggable and each list area droppable.
* It also highlights an item when it is moved to provide feedback and calls a method
* that saves the new order of the module.
**/  

<%= sortable_element 'left',
          :url => {:action => "save_order" },
          :complete => visual_effect(:highlight, 'left'),
          :handle => 'handle',
          :containment => ['left', 'right'],
          :constraint => false %>
<%= sortable_element 'right',
          :url => { :action  => "save_order" }
          :complete => visual_effect(:highlight, 'right'),
          :handle => 'handle',
          :containment => ['left', 'right'],
          :constraint => false %>
```

**Example of Drag and Drop interface:**

[![Example of Drag and Drop Interface](https://journal.code4lib.org/wp-content/uploads/2008/03/dragdropinterface.thumbnail.png)](https://journal.code4lib.org/wp-content/uploads/2008/03/dragdropinterface.png "Example of Drag and Drop Interface")

In addition to reducing development time, effort, and lines of code, Rails also lends itself nicely to an agile development cycle. As expressed by the Agile Alliance \[[10](https://journal.code4lib.org/articles/#10 "Note #10")\], agile development emphasizes:

> “Individuals and interactions over processes and tools. Working software over comprehensive documentation. Customer collaboration over contract negotiation. Responding to change over following a plan.”

Agile development can work well in the library setting. Software companies have staff dedicated to specific software development roles, such as business analysts, designers, programmers, project managers, etc. But most libraries, OSUL included, have small technology departments where staff must fill more than one role in the software development process. Agile development methods lessen staff overhead needed for software development by reducing processes and documentation. The ICAP project team is small, consisting of two reference librarians and a programmer, and has fairly broad decision-making ability that helped streamline the development cycle. Although the team was small, agile development also allowed us to involve all stakeholders, and respond quickly to their feedback.

## Challenges

Early feedback exposed design flaws that could have kept the tool from being adopted by the librarians. Three refinements were particularly important: the ability to move modules around on the page, the ability to choose one or two column layouts, and the ability to forgo an added chat box or to replace a generic chat box with their own. After we changed the design, the tool has gained wide acceptance with the librarians, evidenced by the large number of pages created in the first term following the changes. As librarians used the creation tool more, minor bugs and workflow issues were found and addressed. Later feedback led to further refinements, such as the ability to add third-party widgets to the pages, and changes to functionalities of the WYSIWYG editor.

There were some critical junctures in the project. The first involved getting the right skills and personnel in place to get the project off the ground. The second was the push-back about how the tool would work, what features would be included, and how it would change librarians’ workflow and level of control over course assignment web pages after the initial release. The team learned firsthand that people need time to adopt new software, and that a high level of user involvement is crucial in building acceptance for a new tool. The third was when *LibGuides* \[[11](https://journal.code4lib.org/articles/#11 "Note #11")\] became available. OSUL took a careful look at whether or not to continue developing the ICAP Publishing System. We decided to go forward because we had a functioning tool in place, and also because we planned to share our open source code with the library community.

## Conclusion

In the coming months we will add features from our original use case, such as a Feedback/Comments module, and extend the tool’s functionality to include creating Subject Research Guides. We will also build in search-engine optimization features and supply a means to access web analytics from within the ICAP system. Some of these features will then be added to the open source code for this project. Additionally, we will begin a new round of usability testing with students and integrate the feedback into the ICAP system.

While we continue to evaluate this project and the tool, the ICAP Publishing System has met our initial project goals. The primary goal of this project is to better serve students, and the assessment data collected from students via surveys, email and use statistics suggests that we are on the right track. We will continue to gather evaluative feedback from student users, learning more about their searching preferences and research habits as we do. We also met our goal of providing librarians with an easy-to-use publishing system. Librarians have adopted the tool, enjoy using it, appreciate that it helps them incorporate Web 2.0 features, and find that it saves them time when creating course assignment pages. The ICAP Publishing system gives OSU Libraries an updated way to connect students with relevant, quality resources at their point of need. An additional benefit is that the new tool and the course pages it generates gives librarians something to showcase with faculty, who have responded positively, collaborating with librarians on pages, using the pages in class, and requesting more pages. The library as a whole built new capacities as a result, gaining experience with user-centered design, usability testing, software development cycles, and project management. The cumulative effects of the ICAP project go beyond the tool: OSUL’s future software development projects will benefit from these new capacities.

## Notes

\[1\] ICAP Publishing System: [http://ica.library.oregonstate.edu/about/index.html](http://ica.library.oregonstate.edu/about/index.html "ICAP Publishing System")

\[2\] Nichols, Jane and Margaret Mellinger. (2007) Portals for Undergraduate Subject Searching: Are They Worth It? *portal: Libraries and the Academy* 7(4) 481-490.

\[3\] Reeb, Brenda and Susan Gibbons. (2004). Students, Librarians, and Subject Guides: Improving a Poor Rate of Return *portal: Libraries and the Academy* 4(1):123-130

\[4\] LibData. [http://libdata.sourceforge.net/](http://libdata.sourceforge.net/ "LibData")

\[5\] Library Course Builder. LibCB [http://sourceforge.net/projects/libcb/](http://sourceforge.net/projects/libcb/ "Library Course Builder")

\[6\] SubjectsPlus. [http://www.ithacalibrary.com/subsplus/](http://www.ithacalibrary.com/subsplus/ "Ithaca Library - SubjectsPlus")

\[7\] LibraryFind: [http://libraryfind.org](http://libraryfind.org/ "LibraryFind")

\[8\] See: ICAP System Wiki. [http://wiki.library.oregonstate.edu/confluence/display/ICATeam/Usability](http://wiki.library.oregonstate.edu/confluence/display/ICATeam/Usability "ICAP Wiki") and [http://wiki.library.oregonstate.edu/confluence/display/ICATeam/Assessment](http://wiki.library.oregonstate.edu/confluence/display/ICATeam/Assessment "ICAP Wiki")

\[9\] Ruby on Rails. [http://www.rubyonrails.org/](http://www.rubyonrails.org/ "Ruby on Rails")

\[10\] Agile Alliance. [http://www.agilealliance.org/](http://www.agilealliance.org/ "Agile Alliance")

\[11\] LibGuides. [http://www.springshare.com/libguides/](http://www.springshare.com/libguides/ "LibGuides")

Margaret Mellinger is an Engineering Librarian at Oregon State University Libraries, and the lead of the ICAP team. (Margaret dot Mellinger at oregonstate dot edu)  
Kim Griggs is a Programmer/Analyst at Oregon State University Libraries, and the programmer of the ICAP publishing system. (Kim dot Griggs at oregonstate dot edu)
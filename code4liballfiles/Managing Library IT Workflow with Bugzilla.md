---
title: "Managing Library IT Workflow with Bugzilla"
source: "https://journal.code4lib.org/articles/3814"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-09-22
created: 2025-01-10
description: "Prior to September 2008, all technology issues at the University of Colorado Denver's Auraria Library were reported to a dedicated departmental phone line. A variety of staff changes necessitated a more formal means of tracking, delegating, and resolving reported issues, and the department turned to Bugzilla, an open source bug tracking application designed by Mozilla.org [...]"
tags:
  - "clippings"
---
# Managing Library IT Workflow with Bugzilla
Nina McHale

Prior to September 2008, all technology issues at the University of Colorado Denver’s Auraria Library were reported to a dedicated departmental phone line. A variety of staff changes necessitated a more formal means of tracking, delegating, and resolving reported issues, and the department turned to Bugzilla, an open source bug tracking application designed by Mozilla.org developers. While designed with software development bug tracking in mind, Bugzilla can be easily customized and modified to serve as an IT ticketing system. Twenty-three months and over 2300 trouble tickets later, Auraria’s IT department workflow is much smoother and more efficient. This article includes two Perl Template Toolkit code samples for customized Bugzilla screens for its use in a library environment; readers will be able to easily replicate the project in their own environments.

## Background & Introduction

The Auraria Library is the academic library for three institutions of higher learning: the University of Colorado Denver (UCD), Metropolitan State College of Denver, and the Community College of Denver. The combined student FTE is 28,000; however, part-time enrollment on campus is very high, which makes for a total student enrollment of nearly 50,000. The campus is also almost entirely a commuter campus, which puts a premium on Library space; there are no dorms to which students may retreat in between classes, and the Library is quite busy during most days of the academic year. The 169 public computers are always in high demand. Network support, including email and wireless networks available in the Library, is provided via the UCD Information Technology Services department, the UCD campus-level IT unit.

In 2008, the recommendations of an external consulting effort aimed at improving library workflows prompted a reorganization of the Auraria Library Systems Department, embedding a number of systems staff members into other departments and introducing the use of student assistants for the first time ever. In addition, two employees with over 50 combined years of institutional knowledge retired from the department in this year. These factors emphasized the need to coordinate technology issue reporting and resolution effectively across the Library as the greatest concentration of technology skills was no longer centralized in one department.

Prior to the reorganization, the six-person Systems department had managed desktop support in an ad hoc fashion. A dedicated phone line, checked frequently during the Library’s open hours, served as the primary means of reporting technology issues. In January of 2009, the Network Administrator and Desktop Support Technician positions were re-filled and four student workers were hired with the intent that this team would be able to provide most of the library-wide desktop support, freeing other Systems staff members from these operational duties. In particular, this would allow the IT Manager to pursue larger-scale projects that would benefit the library technology environment such as server virtualization and thin clients for public workstations. As the responsibilities of the Systems Department (re-titled the Division of Technology Strategy and Learning Spaces) were re-envisioned, its director sought ways to improve efficiency and communication both within the department and beyond to the entire Library. This necessitated a more formal means of tracking, delegating, and resolving reported issues. To accommodate these drastic personnel changes and achieve this improved efficiency, the Library’s IT staff recognized the need to modernize workflow management using a powerful communication and tracking tool.

## Finding the Right Tool

In order to find an appropriate tool, IT staff investigated half a dozen or so open source or low-cost options. The most desirable criteria included ease and speed of deployment, low cost—both in terms of money and staff resources, and suitability of the current server environments available to the Library IT staff. The primary tools evaluated included Bugzilla ([http://www.bugzilla.org](http://www.bugzilla.org/)), SugarCRM ([http://www.sugarcrm.com/crm/](http://www.sugarcrm.com/crm/)) Request Tracker (aka RT, [http://bestpractical.com/rt/](http://bestpractical.com/rt/)), h2desk ([http://www.h2desk.com/](http://www.h2desk.com/)), OTRS ([http://otrs.org/](http://otrs.org/)), and Eventum ([http://freshmeat.net/projects/eventum](http://freshmeat.net/projects/eventum)).

Bugzilla was the final choice because it was compatible with the local server environment, it was easy to install and customize, and its broad user base ensured future development. It allowed for quick, local customization and rapid launch without extensive programming or specialized knowledge of Perl, neither of which were available in the Library at the time. Extensive community support was also available via a newsgroup, a mailing list, and an IRC channel. Given the lack of Library resources available for managing this type of tool, this level of responsive external community support was crucial \[[1](https://journal.code4lib.org/articles/#note1)\]. Also tipping the balance in Bugzilla’s favor was the support of Eric Sisler, a systems librarian for Westminster Public Library, who provided the Auraria staff with support in launching Bugzilla.

## Bugzilla Configuration

First publicly released in 1998, Bugzilla is an open source bug tracking system created by the Mozilla.org developers. Bugzilla is used by many high-profile organizations, including NASA and Facebook, to track defects in the software development process \[[2](https://journal.code4lib.org/articles/#note2)\]. Bugzilla is, however, easily modified to accommodate tracking technology issues in a library environment; in fact, “IT support queue” is one of the suggested uses for the software \[[3](https://journal.code4lib.org/articles/#note3)\].

In the spring of 2008, Bugzilla was installed on the Library’s web server at http://bugzilla.auraria.edu utilizing a MySQL backend. The existing LAMP environment required a few additions to Perl modules, which were performed quickly and easily. (See current Bugzilla documentation for specifics on requirements for Perl and other software) \[[4](https://journal.code4lib.org/articles/#note4)\].

The next step was to create user accounts for all Library employees. While there is an LDAP authentication option within Bugzilla, there was no in-library support for using LDAP to connect to the library staff accounts in the UCD Active Directory. Since local Bugzilla users can reset their own passwords, it was believed that this would suffice for user access management. However, as will be discussed later, this was actually one of the major challenges in using Bugzilla library-wide. About 70 user accounts for all library faculty, staff, and student employees were added manually. When employees terminate employment, their accounts may be inactivated, but it is recommended that they not be deleted as their names are associated with existing tickets and deletions can cause database referential integrity issues. Since the Auraria installation was meant to be an internal reporting system, only administrators were allowed to create new accounts. However, there are options in Bugzilla to allow for completely open, user-driven account creation or even open account creation within a specific network.

After all users were created, staff began defining the structure of library technology within Bugzilla. Bugzilla refers to all items as “products,” which are further broken down into “components” (see Figure 1 for the list of technology products at Auraria Library). Products and their components are easily added and edited in the web-based administrative interface. Descriptions can be added to each product to help end users reporting problems choose the appropriate product and component when creating a ticket.  
[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-1.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-1.png)

**Figure 1.** Library Technology Products for Auraria Library \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-1.png)\]

The fact that these products and components are locally defined is in large part what allows for Bugzilla to be used as an IT troubleshooting queue. For example, one product in the Auraria Bugzilla customization is “Library Web Sites.” The components of “Library Web Sites” are “Archives web site,”  “Blogs,” “Contribute,” “Intranet,” “LibGuides,” “Other,” and “Public Web Site” (see Figure 2).  
[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-2.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-2.png)

**Figure 2.** Sample Components for “Library Web Sites” \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-2.png)\]

As shown in Figure 2, each component has a default assignee; this directs all newly created tickets to the staff member best equipped to resolve the issue. It is also possible to copy multiple people for each component; at least one cc recipient is recommended in case of absence of the primary recipient. Additionally, if a team of staff is responsible for certain products, an email alias can be used so that all team members are notified as soon as a new ticket is created for that component. For example, the e-resources team at Auraria is comprised of three librarians who address access problems with electronic resources. All three receive emails for tickets related to databases, ebooks, and off-campus access. Another Auraria workflow example relates to the “Computers” product. The Helpdesk Manager, who directly supervises the student employees, receives all tickets related to staff and public workstations. He then delegates these tickets to students based on their schedules, skills, and availability to ensure quick resolution of the ticket.

While care should be taken in the initial creation of products and components, products and components may be added or edited at any time post-launch. As with any tool, customer use of the product will inform tweaks and changes. It is also good practice to include an “Other” product and an “Other” component for each product so that a ticket may still be created if the person reporting the ticket is unsure as to what product or component to select. Additionally, misfiled tickets are easily reassigned to the proper product and/or component within Bugzilla.

The final step was to customize the default screens so that they were relevant to a library environment. Most of the work involved simplifying screens that library staff would use to report technology issues, primarily the bug/ticket creation form. Eric Sisler’s extensive customization instructions—even though they were written to version 2.18.3—proved  invaluable during this step \[[5](https://journal.code4lib.org/articles/#note5)\]. Sisler’s instructions identify all of the places in which software language and terminology is used, and he provides suggestions for a library-centric install. Bugzilla is written in Perl Template Toolkit, a language that is relatively easily modified by anyone with working knowledge of HTML \[[6](https://journal.code4lib.org/articles/#note6)\]. A complete list of screens customized for the Auraria instance is available in Figure 3.

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-3.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-3.png)

**Figure 3.** Ten Screens Customized for Auraria Library Bugzilla

The most dramatic changes were made to the index/main page (index.html.tmpl \[[7](https://journal.code4lib.org/articles/#note7)\]) and to the ticket creation page (/bug/create/create.html.tmpl \[[8](https://journal.code4lib.org/articles/#note8)\]). Within the Bugzilla installation, the screens are located in the /template/en/ directory. The default screens are located in /template/en/default/, but rather than editing the default files directly, administrators should copy the files they wish to customize into a /template/en/custom/ directory (as in Figure 3). Only the files that need to be modified need to be copied; the contents of the entire /default/ directory do not need to be recreated as Bugzilla detects and displays the customized screens automatically. Creating this separate /custom/ directory allows for quicker Bugzilla upgrades, as a clean installation of a newer version will not overwrite the contents of this directory. While the customized screens may require some tweaking after an upgrade, they will not need to be completely recreated. (Complete documentation for upgrading Bugzilla, including CVS methods, is available at [http://www.bugzilla.org/docs](http://www.bugzilla.org/docs).)

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-4.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-4.png)

**Figure 4.** Out-of-the-Box Bugzilla Index \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-4.png)\]

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-5.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-5.png)

**Figure 5.** Customized Index Page for Auraria Bugzilla Install \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-5.png)\]

## Bugzilla Workflow

For an end user, creating a ticket begins begins by clicking on the “Report a problem/create a ticket” link on the Bugzilla main page (see Figure 5). The user is taken to the product selection screen (see Figure 1), and s/he is then taken to the ticket creation screen (see Figure 6).

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-6.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-6.png)

**Figure 6.** Auraria Bugzilla Ticket Creation Form \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-6.png)\]

While this form has thirteen fields, only four are required: selecting the component and ticket type, adding a quick summary, and adding a description of the problem. Ticket types are fully customizable; Auraria uses “Please fix!,” “Request,” and “Information.” Not surprisingly, the most common types of issues reported are “Please fix!” “Request” is used when there is a need for non-urgent work, such as a new software installation, rather than an existing problem. “Information” is rarely used, but is a way to store research or helpful information in a common space.

Once the “Create Ticket” button is clicked, the information is entered into the MySQL database, and the ticket can be viewed at a unique URL. Bugzilla assigns the ticket automatically to the IT staff member responsible for the indicated component, and that person receives an email notification. The IT staff may accept or reassign the ticket, if appropriate, or even reclassify the product and/or component if another better fits the issue. Once work on the ticket begins, notes may be recorded about the steps taken to resolve the issue. Notes may be added by anyone, not just the assignee, and whenever a note is added, notification emails are sent to all users who are associated with the ticket, i.e., the reporter, the assignee, and the cc assignee. If the work being completed on a ticket is (or becomes) significant to other staff members, cc emails may be added. When work on the ticket is done, it is marked as “Fixed,” and it no longer displays in reports of open tickets (more on reporting below).

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-7.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-7.png)

**Figure 7.** Auraria Bugzilla Sample Ticket \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-7.png)\]

As Figure 7 shows, there are a number of additional features that have not been described here. These include estimates of work time, deadlines, and blocks. These features seemed useful at the time of setup; however, they were simply not used, even by members of the IT staff. The expectation of a 48-hour ticket turnaround time made these more or less obsolete.

An out-of-the-box Bugzilla installation also includes search plug-ins for IE7+ and Firefox 2+ as well as a customizable screen reserved for ticket writing guidelines. The search plug-ins were not widely discovered or used outside of the IT department. The ticket writing guidelines, which included suggestions and sample verbiage for successfully reporting IT issues, were demo’ed at training sessions, but it is not known how frequently they were consulted beyond that. (See [Appendix: Auraria Library Ticket Writing Guidelines](https://journal.code4lib.org/articles/#appendix)).

## Reporting, Delegating, and Managing

The most used and useful reporting feature in Bugzilla is the “My Tickets” saved search, which is generated simply by clicking on the “My Tickets” link that appears on the footer of all of the screens in Bugzilla. The “My Tickets” search displays at a glance all tickets assigned to the logged in user, which is helpful in prioritizing work. As Figure 8 demonstrates, an individual’s open tickets may be sorted by the ticket ID number (i.e., chronologically, as tickets are numbered sequentially beginning with 1), severity, priority, operating system, assignee, status, or summary. (No resolutions are shown in this report as these are open tickets.)

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-8.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-8.png)

**Figure 8.** Web Librarian’s Open “My Tickets” Report \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-8.png)\]

Bugzilla’s robust reporting features also allow IT managers to delegate incoming work to student assistants, monitoring ticket assignments by viewing all open issues for a given student’s user ID. Managers can also track individual employee performance by checking the number of tickets each employee has closed over a given period of time. Finally, to improve communication beyond the Technology Strategy and Learning Spaces Division, a link on the Library intranet allows any library staff member to view all open tickets. Open reporting makes the often invisible work performed by IT staff visible to all other library employees.

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-9.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-9.png)

**Figure 9.** Sample Report for an IT Student’s Open Tickets \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-9.png)\]

Bugzilla has also became a motivational tool, particularly for the IT students. The Helpdesk Manager has occasionally split the students into teams or challenged them individually in a friendly competition to close the most tickets in a given time period or to close a single challenging ticket. This boosted morale—the prize was often a free lunch for the winner—and increased productivity. At weekly IT staff meetings held to review all open tickets, being the owner of the oldest ticket means bearing the brunt of friendly jokes. While these weekly meetings are centered around open tickets, they are a helpful venue for discussing “stuck” projects and finding ways to “unstick” them collaboratively by coordinating work across departments.

## Launch and Library-Wide Use

The first Bugzilla ticket was created by the IT Manager from an email message received on September 17<sup>th</sup>, 2008. Bugzilla was soft-launched internally to the staff responsible for the major IT systems through the month of October, with technology staff creating tickets from emails and calls from the dedicated phone line. Half a dozen faculty and staff members were invited to begin using it to identify any major issues prior to library-wide release, and when no crucial issues were found, Bugzilla was officially launched. A brief training session was held for library staff in October, and the Helpdesk Manager created a short, light-hearted tutorial that demonstrated how to log in and how to create a ticket to report an issue. After a couple of weeks of use, the word “Bugzilla,” as in “I’ll Bugzilla it,” became a verb. Initially, staff seemed to think that Bugzilla was only for desktop support; the Web Librarian still received emails requesting changes or reporting problems with the Library’s web sites that could have easily been reported via the “Library Web Sites” product. To manage these frequent emails, the Web Librarian created a custom email signature in Outlook, requesting the reporter use Bugzilla to request or report the issue.

Staff reaction was mixed, as is often the case with the introduction of a new technology in any environment. Some jumped in immediately and began using it, while others have yet to log in and create a ticket. The departmental phone line was kept in place, but library staff using this mechanism to report problems were gently encouraged to report the issue in Bugzilla themselves. IT staff also reminded callers that their issue would be resolved more quickly if they entered the ticket themselves as it would be assigned as soon as it was submitted, as opposed to waiting for an IT staff member to listen to the phone message and create a ticket on the reporter’s behalf. The dedicated phone line still exists and is answered whenever possible by the IT student employees. Staff may also still use the phone line to report a problem with their own workstation or a large-scale emergency, such as an outage that renders most of the public area computers unusable or affects mission-critical products like the ILS.

## Lessons Learned

After nearly two years of use, the primary lessons learned about Bugzilla as an IT tracking system in a library environment center around ease of use for non-IT library staff. The first relates to authentication, or specifically, not enabling LDAP authentication so that all library employees could use network credentials. The second most commonly stated dissatisfaction was the look and feel and, to some extent, the branding of the Auraria Library Bugzilla installation.

As previously mentioned, the LDAP option in Bugzilla used to create accounts automatically and manage authentication was not implemented at Auraria Library as there was no LDAP expertise among the Library IT staff to establish a connection to UCD Active Directory accounts. While users are allowed to reset their own passwords, the password reset is not particularly user-friendly as it appears on the lower half of the login screen. Library staff would click the “Reset Password” link, and were frustrated when it appeared they were simply being taken back to the login screen. Having to use a non-network password was especially an issue for library employees who worked at public services desks. Often, with a line of patrons or a classroom of students waiting, staff could not remember and did not have time to reset a password in order to report an issue in a timely manner. A brief experiment with a generic account and password that could be used by all public services staff was attempted; however, if the tickets were not specific enough, it was impossible to trace the individual who reported the ticket for follow-up. This also made it impossible to report the outcome back to the ticket creator, as the email account assigned to the generic account was a dummy account. As a result, LDAP-enabled authentication became a requirement for all future web development projects. Maintaining a separate set of credentials was, according to anecdotal evidence, the biggest barrier to employee use of Bugzilla.

Another issue for library staff was the unappealing look, feel, and branding of Bugzilla. It was described as a “geeky” product and even the IT students, when asked what could be done to improve Bugzilla, suggested “make it prettier.” For the Auraria Library installation, the Web Librarian had opted not to modify the CSS files in the interest of releasing the system as quickly as possible. However, Bugzilla does support creation and use of custom skins, and a handful of skins created by developers may be found on the Internet \[[9](https://journal.code4lib.org/articles/#note9)\]. Also, later releases have simplified and improved the main page out-of-the-box with the addition of graphical elements and a more interesting color palette (see Figure 10). Even the name “Bugzilla” sounded ridiculous to some library employees. Armed with this feedback, the Web Librarian installed another instance of Bugzilla at http://helpdesk.auraria.edu and modified the out-of the box version 3.4.5 with graphics and fonts/colors that matched the public-facing web site (see Figure 11). With support from a technology consultant, LDAP was also enabled, and the ticket creation form was pared down to the four most basic fields, keeping all of the other form fields in the 3.0.4 version of the form available on an “Advanced Fields” screen (see Figure 12). However, this revamped instance was never launched due to a decision to upgrade to a more fully-featured IT management tool.

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-10.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-10.png)

**Figure 10.** Out-of-the-Box Improvements to Bugzilla Main Page, Version 3.4.5 \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-10.png)\]

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-11.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-11.png)

**Figure 11.** Auraria Library Redesigned Bugzilla Main Page \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-11.png)\]

[![](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-12.png)](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-12.png)

**Figure 12.** Auraria Library Redesigned Bugzilla Ticket Creation Form \[[View full-size image](https://journal.code4lib.org/media/issue11/mchale/mchale-figure-12.png)\]

## Conclusion

Over 2300 tickets and 23 months later, the numbers speak for themselves. Each month averaged 100 tickets, approximately 4-5 per business day. Bugzilla has proved itself a more than worthy tool for not only managing, but modernizing the Library’s IT workflow.  However, Bugzilla  has become a victim if its own success as the Technology Strategy and Learning Spaces Division decided in May 2010 to purchase Numara’s Track-It! (http://www.numarasoftware.com/Track-It/help\_desk\_software.aspx) for IT management. With the growing importance placed on technology in the Library’s strategic plan and the past success using Bugzilla to manage operational support issues, the IT Manager sought out a more fully-featured software package that included functions such as inventory, equipment checkout, and software license management, in addition to ticket management. Bugzilla does not have these features and is unlikely to develop them as they fall outside the original focus of the product.

Utilizing Bugzilla to help shift the focus of day-to-day support issues to student employees allowed the IT Manager to focus on larger-scale projects and improvements that were aligned with the Library’s strategic plan, including deploying thin clients and virtualizing network servers. This creates a better learning environment for Auraria’s 50,000 students and simplifies desktop support for the 169 public computers, as well as support of the ILS, the library’s web site, e-resources, and all other technology products. Additionally, Bugzilla’s reporting feature has created a historical knowledgebase that provides data to assist with personnel decisions about necessary levels of training and staffing, in addition to information about the quality of service provided by IT staff members. Multiple tickets about a specific product can be used to provide budget justification for replacing outdated equipment. Bugzilla has also created a work record to document what is often invisible to library administrators and those who work outside of IT. Finally, the installation and configuration of Bugzilla was a successful foray into open source development that opened the door to using MediaWiki for a staff intranet and to migrating the library’s public facing sites to Drupal. Bugzilla was an extended proof of concept that helped the technology staff begin a much-needed modernization of the IT department.

## Notes

\[[1](https://journal.code4lib.org/articles/#note1text)\] Bugzilla, “Support,” [http://www.bugzilla.org/support/](http://www.bugzilla.org/support/). Accessed 9/9/2010.  
\[[2](https://journal.code4lib.org/articles/#note2text)\] Bugzilla, “Installation List,” [http://www.bugzilla.org/installation-list/](http://www.bugzilla.org/installation-list/). Accessed 9/9/2010.  
\[[3](https://journal.code4lib.org/articles/#note3text)\] Bugzilla, “About,” [http://www.bugzilla.org/about/](http://www.bugzilla.org/about/). Accessed 9/9/2010.  
\[[4](https://journal.code4lib.org/articles/#note4text)\] Bugzilla, “The Bugzilla Guide, Chapter 2.1 Installation,” [http://www.bugzilla.org/docs/tip/en/html/installation.html](http://www.bugzilla.org/docs/tip/en/html/installation.html). Accessed 9/9/2010.  
\[[5](https://journal.code4lib.org/articles/#note5text)\] Sisler, Eric, “Bugzilla at the Westminster Public Library,” [http://westminster.lib.co.us/bugzilla-custom/](http://westminster.lib.co.us/bugzilla-custom/). Accessed 9/9/2010.  
\[[6](https://journal.code4lib.org/articles/#note6text)\] Chamberlain, Darren, David Cross, and Andy Wardley. Perl Template Toolkit. O’Reilly. Sebastopol CA. 2004. [(COinS)](https://journal.code4lib.org/coins)  
\[[7](https://journal.code4lib.org/articles/#note7text)\] Sample code for index.html.tmpl, [http://journal.code4lib.org/media/issue11/mchale/index.html.tmpl.txt](https://journal.code4lib.org/media/issue11/mchale/index.html.tmpl.txt). Local modifications for Auraria Library thanks to Bryan Mollenkopf.  
\[[8](https://journal.code4lib.org/articles/#note8text)\] Sample code for create.html.tmpl, [http://journal.code4lib.org/media/issue11/mchale/create.html.tmpl.txt](https://journal.code4lib.org/media/issue11/mchale/create.html.tmpl.txt). Local modifications for Auraria Library thanks to Bryan Mollenkopf.  
\[[9](https://journal.code4lib.org/articles/#note9text)\] Bugzilla, “The Bugzilla Guide, Chapter 6.2 Custom Skins,” [http://www.bugzilla.org/docs/tip/en/html/cust-skins.html](http://www.bugzilla.org/docs/tip/en/html/cust-skins.html). Accessed 9/9/2010.

Nina McHale ([nina.mchale@ucdenver.edu](https://journal.code4lib.org/articles/), [http://milehighbrarian.net](http://milehighbrarian.net/)) is Assistant Professor, Web Librarian, at the Auraria Library, which serves the University of Colorado Denver, Metropolitan State College of Denver, and the Community College of Denver.  

## Appendix: Auraria Library Ticket Writing Guidelines

**Why you should read this:**

Simply put, the more clearly you report your problem, work request, or question, the easier it will be for Help Desk Staff staff to understand, respond to, and resolve it.

**Before reporting an issue to the Help Desk:**

- If there seems to be a power problem with your equipment, check ALL cords and cables, including power strips.
- If the problem seems software-related, save your work, close the software, and reboot.

These are the first things that Help Desk staff would try, so you might save yourself some time by performing these simple checks.

**Creating a New Ticket in Five Minutes or Less:**

If you have searched existing tickets, and no one else appears to have reported your problem, then:

1. Under Step 3 on the Help Desk Home Page, click on “log in and create a new ticket.” Your Login ID is your full email address, i.e., firstname.lastname@ucdenver.edu. Your password is unique and set by you. Forgotten it? No problem! Click the link to reset it.
2. Once you’re logged in, select the appropriate product. If you can’t find a product that describes what you need help with, select “None of the Above.” And don’t worry about selecting the wrong product; Help Desk staff can always reassign a ticket and/or create a new product.
3. Fill out the four required fields on the form. These fields are:

- **Component:** This is simply a more specific part of a product. For example, the components of the product “Skyline” are “Cataloging,” “Circ functions,” “OPAC,” “Proxy/WAM,” and “Serials.” You can click the word “Component” to see a description of each component. When you select a component, the “Assign To” field is filled in automatically, so you don’t have to worry if you’re sending it to the right person or not
- **Ticket Type:** The three options are “Fix me!,” “Request,” and “Information.” Select “Fix me!” if you’re reporting a problem. Select “Request” if this is not a problem, but a new request for work, such as a software installation or upgrade. Select “Information” if you have a question or would like more information about a technology-related topic or product.
- **Summary:** In ten words or less, give your ticket a title. A good summary should **quickly and uniquely identify a ticket.** It should explain the problem, not your suggested diagnosis or solution.
- **Description:** Describe what is happening (or not happening!). Again, you don’t need to try to diagnose the problem; just report where you are, what you’re doing and what should be happening. Be as specific and precise as you can. Here are some examples
- Bad: “My email is down.”
- Good: “When I open Outlook, I can only see e-mail messages that are very old, from May 2008.”
- Bad: “There’s a broken link on the Hours page.”
- Good: “The link to the ADI on the Hours page is broken. It tries to go to http://library.cudenver.edu/findit/databasesindexes.php, and it should go to http://library.auraria.edu/apps/databasesindexes/dbaseindex.php”

5. Two optional, but potentially very helpful, features on the form are the URL field and the “Add an Attachment” button.

- **URL:** If there’s a specific URL relative to your problem, you can type or cut and paste it in this field. This is not always applicable, but could be very helpful, obviously, for a problem with the library web site or an electronic resource.
- **“Add an Attachment” button:** You can add an attachment of almost any file type. Attachments that would be helpful to Help Desk staff include screen captures of error messages or documentation related to the product that you would like help with.

7. Double-check your additions to the form for errors and omissions, then click the “Create Ticket” button. Voilà! Your ticket has been entered into the Auraria Library Help Desk database and assigned to the appropriate Help Desk staff member(s). You’ll get an email when any additional information is entered by Help Desk staff, or when the problem status is changed.
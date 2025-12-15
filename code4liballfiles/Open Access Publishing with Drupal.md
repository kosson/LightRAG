---
title: "Open Access Publishing with Drupal"
source: "https://journal.code4lib.org/articles/5913"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-10-31
created: 2025-01-10
description: "In January 2009, the Colorado Association of Libraries (CAL) suspended publication of its print quarterly journal, Colorado Libraries, as a cost-saving measure in a time of fiscal uncertainty. Printing and mailing the journal to its 1300 members cost CAL more than $26,000 per year. Publication of the journal was placed on an indefinite hiatus until [...]"
tags:
  - "clippings"
---
# Open Access Publishing with Drupal
Nina McHale

In January 2009, the Colorado Association of Libraries (CAL) suspended publication of its print quarterly journal, Colorado Libraries, as a cost-saving measure in a time of fiscal uncertainty. Printing and mailing the journal to its 1300 members cost CAL more than $26,000 per year. Publication of the journal was placed on an indefinite hiatus until the editorial staff proposed an online, open access format a year later. The benefits to migrating to open access included: significantly lower costs; a green platform; instant availability of content; a greater level of access to users with disabilities; and a higher level of visibility of the journal and the association. The editorial staff chose Drupal, including the E-journal module, and while Drupal is notorious for its steep learning curve—which exacerbated delays to content that had been created before the publishing hiatus—the fourth electronic issue was published recently at coloradolibrariesjournal.org. This article will discuss both the benefits and challenges of transitioning to an open access model and the choice Drupal as a platform over other more established journal software options.

## Background

Since 1975, the Colorado Association of Libraries (CAL) has published a quarterly journal, Colorado Libraries. The print journal was a benefit for members of the association. In recent years, issues have consisted of six to eight articles focused on a theme of current interest to librarians and library workers in Colorado and the Rocky Mountain region, as well as several regular columns. A content editor and a layout editor were in charge of the workflow process that culminated in the final physical product. The content editor worked with guest editors—each issue had a guest editor who developed the theme and recruited authors—and the layout editor prepared the copy for a commercial printer.

At its January 2009 meeting, the CAL Executive Board temporarily suspended publication of Colorado Libraries due to the high cost of printing and the fragile state of its budget. Content was complete for issues 35.1 and 35.2, and content had been planned and work begun on issues 35.3 and 35.4. Members of the Publications Committee, which oversaw publication of the journal, suggested at the time that an online, open access solution could allow continuation of the journal with much less stress on the budget. The Board was initially concerned that transitioning the journal to an open access format would result in a decrease in CAL membership, as it would be viewed as a loss of a membership benefit. A method for providing online access to members only was briefly considered, but the lack of a platform and the urgency of publishing the content finally made the case for open access successful. Ultimately, however, the Board requested that a final decision on the fate of the future of publishing Colorado Libraries be made after the association’s annual conference in October.

At the January 2010 Board meeting—the first following the annual conference—the Publications Committee presented a proposal to migrate Colorado Libraries into an online, open access format, supported by an open source software solution. The benefits that the committee presented to the board included: significantly reduced publication costs; a “greener,” more environmentally friendly format; and greater accessibility to users with disabilities. (Additional benefits realized after the fact included the ability to include color photos and graphics, which had been prohibitively expensive in print, and the ability to make corrections post publication.) The annual budget for the print journal had been $6,600 per issue, for a total annual cost of $26,400. In contrast, the cost of publishing online was that of hosting—the association did not have a suitable server space for a Drupal installation at the time—and registration of the domain coloradolibrariesjournal.org, which amounted to approximately $325, or slightly more than one percent of the annual print cost. The Board requested that the committee return to the March meeting with a plan for migrating, and in March, the motion to migrate to an online, open access format passed unanimously.

## Platform Options: OJS, WordPress, and the E-Journal Drupal Module

Even as recently as five years ago, migration of a print journal to an open source software solution would not have seemed as achievable as it is now, with the wealth of open source web software available today—not to mention the robust development communities behind them. The three platforms considered by the Publications Committee were Open Journal Systems (OJS), WordPress, and Drupal—more specifically, the Drupal E-Journal module. In the end, Drupal plus the E-Journal module was selected as the best fit for the journal’s needs.

Open Journal Systems, commonly known as OJS, was created by the Public Knowledge Project ([http://pkp.sfu.ca/?q=ojs](http://pkp.sfu.ca/?q=ojs)) with an aim to provide a robust, open-source solution for peer-reviewed publishing. With over 7500 journals (as of December 2010) using OJS, it was a well-established and well-supported option. However, only the Academic Corner section of Colorado Libraries is peer reviewed. The rest of the publication consists of shorter, trade-related articles about 2,000 words in length, with the columns in the second half of the journal about 750 words each. Also, the OJS platform contains ten roles to which editors, authors, managers, etc., may be added. These roles are not customizable, so combined with the rigorous workflow required by the peer review process, OJS ultimately seemed like overkill. (Note: Drupal’s E-Journal module contains seven similar roles; however, these can be overridden to some extent with Drupal’s flexible permissions system. More on this follows in the “Challenges Publishing with Drupal” section.) Finally, there was a desire to publish solely in HTML and not PDFs; OJS requires a non-web document submission process.

After OJS was ruled out, WordPress was considered briefly due to its widespread use and support in online publishing, particularly blogs. As previously mentioned, a hosted solution was required as there was no web environment available to support a robust CMS, and there were several “one click” installation and supported hosting options for WordPress. While Drupal is generally agreed to be more difficult to learn from scratch, the Content Editor had been learning it for her regular job. Ultimately, the existence of the E-Journal module, with its journal-specific functionality, combined with the Content Editor’s prior experience with Drupal, led to the final decision to use Drupal.

Drupal itself is much more customizable than OJS thanks to its highly flexible and extensible theming system as well as its modularity. When the Publications Committee was making its software selection, Drupal 6 was coming into its own, and there was a rapid expansion of the Drupal community among libraries. Support venues included the drupal4lib list ([http://listserv.uic.edu/archives/drupal4lib.html](http://listserv.uic.edu/archives/drupal4lib.html)) and the Drupal Interest Group in ALA’s Library and Information Technology Association (LITA) ([http://connect.ala.org/node/71787](http://connect.ala.org/node/71787)).

The Drupal E-Journal module was developed by Czech-born Roman Chyla, a librarian, developer, and CERN research fellow. Chyla released the contributed module to the Drupal community in early 2006 for version 5. Unlike OJS, which is a single-purpose software system developed specifically for online publishing, the E-Journal module adds online publishing functionality to Drupal’s multi-purpose web framework. However, Chyla actually had OJS in mind when he created E-Journal. In fact, he notes in the documentation for the module that he created it “to prove that it is possible to build a professional publishing system on the Drupal platform;” Chyla’s “proof of concept” “provides the basic functionality, organizes the published nodes around issues.”\[[1](https://journal.code4lib.org/articles/#note1)\] The module can support multiple journals with a single installation, supports online workflow, and records an eISSN, if desired.

## Benefits to Using Drupal/E-Journal

### Drupal’s Inherent Flexibility and Extensibility

Drupal has become such a popular CMS due to its flexibility and extensibility, both in terms of its content development/management features and design, or “theming,” in Drupal terms. Combined with the E-Journal module and the contributed Content Construction Kit module, the core Drupal taxonomy system makes creating and assembling journal issues a snap. A full list of the contributed modules and the functionality that they provide to the journal site is available in Table 1.

**Table 1.** Contributed Modules Used and Functionality Provided

| Module | Functionality Provided |
| --- | --- |
| E-Journal | Arranges Drupal content (“nodes”) into issues |
| Administrative Menu | Places most administrative tasks in a convenient dropdown menu available on all pages of the site, visible to site administrators only |
| CCK (Content Creation Kit) | Allows creation of custom content types, including articles, columns, blog posts, etc., and the online forms for content managers to add content |
| CK Editor | Adds a WYSIWYG toolbar for site content creators who do not know HTML |
| Contemplate | Allows for customization of templates for individual content types |
| FileField, ImageField | Used together, allow for upload of images into content types (Drupal 6) |
| Google Analytics | Tracks use of the journal worldwide with web analytics |
| Mollom | Security and spam prevention/reporting, including CAPTCHAs for forms and comments |
| Pathauto | Creates custom “blog-like” URLs for more user-friendly and SEO-friendly URLs |
| Security Review | Checks site setup for common security holes that could pose threats to the site |
| Upgrade Status | Provides a report of which modules are ready for the next version of Drupal |
| Views | Arranges content (“nodes”) into lists based on filters for custom displays |

After installing and enabling E-Journal—which gives editorial staff the ability to create journals, volumes and issues (see Figure 1)—volumes and issues may be created, and then a standard Drupal taxonomy must be created to provide the structure of individual issues. E-Journal administrative options are also added to the Administrative Menu, a contributed Drupal module that provides site administrators easy access to the parts of the site that need administrative attention. In the taxonomy, editors create all of the journal’s parts, i.e., editor’s introduction, guest editor’s introduction, articles, and columns. This must be done prior to creating those individual content types because the taxonomy must be in place prior to the creation of individual pieces of content so that those pieces may be assigned to the correct part of the journal. Figure 2 shows the full taxonomy of Colorado Libraries.

[  
![screenshot of Colorado Libraries showing menus and table of published volumes and issues](https://journal.code4lib.org/media/issue15/mchale/Figure1s.png)](https://journal.code4lib.org/media/issue15/mchale/Figure1.png)

**Figure 1:** E-Journal Functionality for Creating Volumes and Issues

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure2s.png)](https://journal.code4lib.org/media/issue15/mchale/Figure2.png)

**Figure 2:** Taxonomy of Journal Parts

Next, Content Construction Kit (CCK) is used to create “content types” (Drupal jargon) for each type of content in a journal. The 20 content types in Colorado Libraries are shown in Figure 3. Each content type developed has an associated web form that allows non-web experts to quickly create and add content to the site. The “Create Article” form is shown in Figure 4. (Incidentally, no changes were made to word counts for each type of content.) The CKEditor library and module add the WYSIWYG toolbar shown in Figure 4. Also note the “Available issues” and “Journal structure” dropdowns; the former assigns the content being created by this form to the appropriate journal issue, and the latter assigns the article being created to the appropriate part of the journal as defined by the taxonomy—“Articles,” in this case.

The beauty of this structure is that guest editors and authors may be provided access to the site, with permissions to create specific content types, and upload content themselves, creating the journal issues almost automatically. Colorado Libraries’ workflow has not reached this point yet, but the editors hope to advance it to author submissions in the coming months. Another benefit to allowing direct author submission in this way is that it allows authors to create and submit directly the type of publishing metadata that can slip through the cracks in the print workflow process, such as author biographical information, images and image captions.

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure3s.png)](https://journal.code4lib.org/media/issue15/mchale/Figure3.png)

**Figure 3:** All Colorado Libraries Content Types

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure4s.png)](https://journal.code4lib.org/media/issue15/mchale/Figure4.png)

**Figure 4:** Article Creation Form

Once all of the content for an issue has been created, the journal editor(s) can manage the content for that issue at the “Manage Articles” screen, which is shown in Figure 5. Here, editors can change articles from unpublished to published, reassign journal content to different issues, if necessary, and also reassign the content to a different section of a journal—again, if necessary. Most importantly, editors can use the dropdowns in the “weight” column to change the order of items in the issue. The end result from the reader’s point of view is shown in Figure 6; this is the table of contents for issue 35.1, the first issue of Colorado Libraries to be published online.

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure5s.png)](https://journal.code4lib.org/media/issue15/mchale/Figure5.png)

**Figure 5:** Manage Article Screen

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure6s.png)](https://journal.code4lib.org/media/issue15/mchale/Figure6.png)

**Figure 6:** Reader’s View of the Table of Contents for a Complete Issue

As shown above in Table 1, eight additional contributed modules have improved the out-of-the-box Drupal installation for the journal publication process; they are Contemplate, FileField/ImageField, Google Analytics, Mollom, Pathauto, Security Review, and Upgrade Status. Contemplate provides a means to customize individual content types if the default theme does not work as well as it could for those content types. Combined, FileField and ImageField allow upload of photos and images with content types via a widget (not unlike attaching a file to an email). Google Analytics provides the editorial staff with rich data about site usage worldwide, and Mollom provides CAPTCHAs on the site feedback form as well as the individual comments on articles. Pathauto automatically provides a blog-like URL, which makes an article or column more easily identifiable than Drupal’s standard node numbering system. For example, [http://coloradolibrariesjournal.org/?q=node/83](http://coloradolibrariesjournal.org/?q=node/83) is changed to  
[http://coloradolibrariesjournal.org/?q=content/beyond-echo-chamber-library-messaging-social-networks](http://coloradolibrariesjournal.org/?q=node/83). An added benefit to Pathauto is that it improves search engine optimization (SEO) for individual articles. Security Review conducts tests for loopholes that sometimes are left open in Drupal installations, and Upgrade Status notifies site administrators of the status of all modules currently used by a site. This is particularly helpful when the time comes for a major Drupal version upgrade.

In terms of site design and theming, the quick turnaround necessary to publish the journal content that had been on hold for over a year due to the mandated hiatus dictated that a well-supported contributed theme be selected for the first issues, as there was no time to develop a custom theme. The site uses the Giordani subtheme of the popular Marinelli theme ([http://drupal.org/project/marinelli](http://drupal.org/project/marinelli)). The only major design changes made to the subtheme were to replace the rotating stock banner photos of mountain ranges—which were not entirely inappropriate for the publication, save for the fact that they were mostly European ranges—with pictures of Colorado library facilities and events taking place at them. An email to the statewide library email list yielded several stunning photos that were quickly and easily resized and added to the theme folder. All other design elements—colors, fonts, and layout—use the default Giordani/Marinelli settings.

### Managing Additional Content in the CMS

Another benefit to using Drupal as a platform is that additional information about the journal workflow and processes can be included in the same “place” as the journal. For example, when the journal was published in print, there were a number of documents hosted on the CAL website, including author guidelines, guest editor guidelines, editor job descriptions, a schedule of upcoming issue themes, and more. This documentation was posted in Word and/or PDF documents on the CAL website, was difficult to find, and quickly became outdated. The Colorado Libraries editorial staff did not have access to the association web site and could not easily maintain this meta-content, which exacerbated the problem of it becoming outdated.

Now, in Drupal, all of this information—which has been expanded to include sample language for calls for contributors and sample letters to authors for guest editors, and an online style guide—is available in the online workspace shared by all contributors to the journal. The information that is presented to each user is dependent upon which of the five roles—author, column editor, editor, guest editor, and web admin—that the user plays in the journal’s management and production. For example, authors see links to “Author Guidelines,” whereas guest editors see both the author menu and the guest editor menu, which contains links to “Guest Editor Guidelines” (see Figure 7). The information that users are able to see and the actions that members of each role are allowed to perform are controlled in this way as well, thanks to Drupal’s highly granular permissions, menu and block systems. Since the information is written in HTML (in the basic Drupal “page” content type), it is much easier to edit and maintain collaboratively among the regular editorial staff.

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure7s.png)](https://journal.code4lib.org/media/issue15/mchale/Figure7.png)

**Figure 7:** Support Documentation for Guest Editors.

### Added Social Elements

Finally, the journal takes advantage of Drupal’s social aspects in the core comments and blog features to encourage communication with the Colorado Libraries readership. The blog entries—which are displayed on the Colorado Libraries home page—contain news and announcements, such as the release of new issues and calls for themes, editors, authors, and articles. Users can subscribe via an RSS to keep up-to-date with the journal. Enabling comments allows the readership to provide feedback on all parts of the journal website—articles, columns, and blog entries—and, as previously mentioned, is protected from comment spam by moderation as well as the Mollom module. To date, only three total comments have been received, but one column author was able to add more information to what she had originally written, noting the success of the program that she was describing in her column, and another comment was a suggestion from a reader about the possibility of including short videos and webinars providing updates from around the state. While there are no immediate plans to post video on the site, the online platform brings suggestions like this into the realm of possibility.

## Challenges to Using Drupal and E-Journal

In spite of these successes, the path from print to online was by no means strewn with rose petals. Three significant challenges faced by the editorial team included delays to publication due to Drupal’s learning curve; lack of community surrounding the E-Journal module; and the way the module determines managerial and editorial roles.

The most significant challenge faced during the transition from print to online was the publication delay due to Drupal’s steep learning curve. The publishing hiatus requested by CAL lasted fourteen months, and even after the editorial team got the go-ahead to publish online in March 2010, it was six months until content for 35.1 was published in September. In some cases, authors needed to revisit and update content that had been previously submitted and accepted.

Due to the technical editor’s inexperience with Drupal at the time, certain aspects of the site were not constructed properly—or could have been built better—and have required or will require revisiting. One example of this is the display of author and editor headshots. Shortly before the move online, the editorials staff had begun requesting and including author headshots on the title pages of articles. This practice continued in the online environment as well, improved, as noted above, by the ability to use color photos rather than black-and-white. Rather than placing the photos into a template for the articles—which would have inserted the author photos into the same node with the text content—individual “blocks” (Drupal term) were added for each author picture. Blocks can be thought of as smaller building blocks for a site’s page layout.

The Drupal block system is flexible, allowing one to place a block only on one page or on as many pages as the site admin or content creator desires. One positive aspect of adding author photos in this way is that they are reusable, which is handy because there are often repeat authors in Colorado Libraries. However, it has quickly become clear after three issues that this is unsustainable because it generates too many blocks—20 blocks after three issues—to manage, and these are mixed in with other, structurally more important blocks. Figure 8 shows the abuse of the block system.

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure8.png)](https://journal.code4lib.org/media/issue15/mchale/Figure8.png)

**Figure 8:** Misuse of Drupal’s Block System to Display Author Photos.

Additionally, from a workflow perspective, anyone wishing to submit an author photo in this way would need access to Drupal’s block system on the site, which is generally a level of permissions best kept to web administrators or at least more advanced content creators/developers. It is also much more labor and time-intensive to create the block, insert the content, position the block in the left sidebar, and configure the block to only show on that page, than to have it upload as part of an article, column, or editorial introduction.

Thankfully, E-Journal comes with a better way to promote authors who contribute to the journal. A sub-module called “E-journal Authors” allows journal administrators to create a taxonomy of author names in order to link content written by an author to their user profile—effectively, these would be individual “about the author” pages for all authors, that can then be maintained by the authors themselves. Currently, this is not possible with Colorado Libraries, as authors are not granted user accounts at this time. The plan to expand access to authors to improve online workflow will make this possible in future issues.

### Lack of “Module Community”

Another of Drupal’s greatest strengths is its developer community. The most popular contributed modules have dedicated maintainers who review and release code regularly. The most popular contributed module, Views, is in use on over 300,000 sites and is actively maintained. By comparison, the E-Journal module not as actively maintained, and as of this writing, it is in use on only 44 sites. The last stable release of the code is dated November 2009, and the latest development release is dated February 2011. Creator Chyla, who notes that he developed E-Journal as a proof of concept on his own time, is not sure if a Drupal 7 release is in the cards for the module (email communication, 2011 Aug 29). The documentation on the module is also, as Chyla openly admits, meager.\[[2](https://journal.code4lib.org/articles/#note2)\] Experienced Drupal users will be able to implement E-Journal relatively quickly and easily, but without previous experience with and knowledge of CCK and taxonomy, new users may find it difficult to implement, as this author did at the time.

### Duplicate E-Journal User Roles

One final issue that initially caused confusion in the Colorado Libraries project was an additional set of roles provided in the E-Journal module. Normally, Drupal developers take advantage of the system’s robust user, roles, and permissions to allow users access to the parts of the site that they require to do their work. Users can easily be assigned to roles, which determine a user’s permissions. In the case of E-Journal, permissions are used primarily to determine who can view content at the different stages of review and publication.

The roles created for Colorado Libraries, as previously mentioned, are web admin, editor, guest editor, and author. The preset E-Journal roles, which are a slightly more flexible approximation of the prescribed and inflexible roles in OJS, are administrator, chief editor, editor, reviewer, proofreader, staff, and others. Access rights for each of these roles is customizable on the “E-journal settings” page, as shown in Figure 9. This secondary set of roles and permissions can be overridden by matching the predefined site roles to the roles created locally by the site administrator in Drupal’s main permissions page, as shown in Figure 10. However, it requires some extra work. Further, if the site administrator is initially unaware of these roles, it can create headaches when content does not display as expected to users assuming locally created roles.

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure9s.png)](https://journal.code4lib.org/media/issue15/mchale/Figure9.png)

**Figure 9:** “E-journal settings” Administrative Page

[  
![](https://journal.code4lib.org/media/issue15/mchale/Figure10.png)](https://journal.code4lib.org/media/issue15/mchale/Figure10.png)

**Figure 10:** Overriding the Default E-Journal Roles with Locally Created Roles

The CAL Communications Committee—which has absorbed the Publications Committee—has big plans for future issues of Colorado Libraries, both in terms of content development and platform improvements. As for content, prior to 2006, book reviews had been published in the hard copy issues. In 2006, a decision to publish book reviews online on the CAL website was made in order to get the content to the readership sooner, without the requisite delays caused by the layout and printing process. Plans are underway to reintroduce book reviews in issue 36.1, now that physical layout and printing are no longer necessary. Other new types of content will be introduced as the desire or demand arises, supported by the flexibility of the Drupal/E-Journal platform.

As for the technology platform, one of the first improvements will be to provide readers with a means to download and/or print the articles as PDFs; this was a desire expressed via feedback about the online platform. Unrelated to the PDF issue, while the Giordani/Marinelli theme has served the journal as an attractive and accessible (Section 508/WCAG) theme, as more content is added, it will become desirable and perhaps necessary to develop a theme from scratch that matches CAL branding as well. As previously mentioned, a more complete online workflow that includes author submissions will streamline the production process even more. Drupal’s mobile modules continue to improve, so a mobile site might eventually make a debut as well. Finally, the editors wish to make more of the social aspects of Drupal; one recent idea in this vein was to present a list on the journal home page of the most-read content with a link labeled “What’s Popular?”

### Options for Discovery: Repositories and Databases

As of the time of writing, the Communications Committee is appealing a rejected request to have Colorado Libraries indexed in the Directory of Open Access Journals (DOAJ). Additionally, we are finishing requirements to be included in Google Scholar. The committee is also exploring other options for exporting data from Drupal into other formats for ingest into appropriate repositories. Colorado Libraries has been indexed in WilsonWeb’s Library Literature & Information Science Full Text back to its first issue, and full text is available from 1984-2008 and recently resumed with issue 35.3. The Communications Committee is working actively with EBSCO during its acquisition of WilsonWeb products to ensure inclusion in important scholarly resources for library literature.

## Conclusion

As of the time of writing, Colorado Libraries online has received 4,981 visits from 3,600 absolute unique visitors since issue 35.1 came online in September 2010. The visitors have come from 84 countries. Readership has expanded not only in number—the 3,600 absolute unique visitors are nearly triple the CAL membership—but in scope as well, from the state and the Rocky Mountain west to a global presence. Some referring sites include course management systems from library schools. This has elevated the status of both the publication and the Colorado Association of Libraries.

Despite the risk, using a Drupal module that had low use and maintenance has proved successful and paid off in the short term, satisfying the immediate need to publish the final content developed for print, and migrating to online. However, if the module is no longer maintained and a version for Drupal 7 is not forthcoming, an alternative will need to be found. When contacted about whether the E-Journal would see a Drupal 7 release creator Chyla noted via email message, “if there is substantial interest and I see many people calling for it, I can do it” (email communication, 2011 Aug 29). The Drupal E-Journal module, in spite of the shortcomings described above, has given the Colorado Association of Libraries the ability to continue publication of Colorado Libraries in a much less expensive and more environmentally friendly format. The journal will continue to showcase the great work of librarians and library workers around the state and region and has helped the Communications Committee adjust to a modern mode of publication to better serve as a voice of the association.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] e-journal : publishing system \[Internet\]. Roman Chyla. \[cited 2011 Aug 29\]. Available from: [http://drupal.org/node/187987](http://drupal.org/node/187987).  
\[[2](https://journal.code4lib.org/articles/#ref2)\] e-journal : publishing system \[Internet\]. Roman Chyla. \[cited 2011 Aug 29\]. Available from: [http://drupal.org/node/187987](http://drupal.org/node/187987)

## About the Author

Nina McHale is Assistant Systems Administrator at the Arapahoe Library District (Colorado). Her professional interests include the use of open source web content management systems in library environments, usability and user experience, and web accessibility. As a Colorado resident, she is required by law to love the outdoors, where she spends much time hiking, biking, and skiing with her three kids, two dogs, and one husband. See what she’s up to professionally at [milehighbrarian.net](http://milehighbrarian.net/).
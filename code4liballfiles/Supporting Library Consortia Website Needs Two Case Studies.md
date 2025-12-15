---
title: "Supporting Library Consortia Website Needs: Two Case Studies"
source: "https://journal.code4lib.org/articles/17452"
author:
  - "Elizabeth Joan Kelly"
published: 2023-08-29
created: 2025-01-10
description: "LOUIS: The Louisiana Library Network provides library technology infrastructure, electronic resources, affordable learning, and digital literacy support for its 47 academic library members. With this support comes a need to develop web solutions for members, a challenging task as the members have their own websites on a multitude of platforms, and a multitude of library faculty and staff with differing needs. This article details two case studies in developing consortia-specific web design projects. The first summarizes the LOUIS Tabbed Search Box Order Form, an opportunity for members to “order” a custom-made search box for the various services LOUIS supports that can then be embedded on their library’s website. The second involves the LOUIS Community Jobs Board, a member-driven job listing tool that exists on the LOUIS site, but that members can publish jobs to using a Google Form. Both the Search Box Order Form and the Jobs Board have resulted in increased engagement with and satisfaction from member libraries. This article will include best practices, practical solutions, and sample code for both projects."
tags:
  - "#case/study"
  - "#library/consortia"
  - "#Louisiana/Library/Network"
---
# Supporting Library Consortia Website Needs: Two Case Studies
Elizabeth Joan Kelly

LOUIS: The Louisiana Library Network provides library technology infrastructure, electronic resources, affordable learning, and digital literacy support for its 47 academic library members. With this support comes a need to develop web solutions for members, a challenging task as the members have their own websites on a multitude of platforms, and a multitude of library faculty and staff with differing needs. This article details two case studies in developing consortia-specific web design projects. The first summarizes the LOUIS Tabbed Search Box Order Form, an opportunity for members to “order” a custom-made search box for the various services LOUIS supports that can then be embedded on their library’s website. The second involves the LOUIS Community Jobs Board, a member-driven job listing tool that exists on the LOUIS site, but that members can publish jobs to using a Google Form. Both the Search Box Order Form and the Jobs Board have resulted in increased engagement with and satisfaction from member libraries. This article will include best practices, practical solutions, and sample code for both projects.

## Introduction

[LOUIS: The Louisiana Library Network](https://louislibraries.org/) plays a vital role in supporting the online needs of its 47 academic libraries. Through its affordable learning, digital literacy, resource, and technological initiatives, LOUIS ensures that members have the necessary collections, tools, and infrastructure to deliver quality services to their respective communities. Member library websites are a key component of making these resources and services available to users, and each member library operates its own website, utilizing different content management systems, design frameworks, and customization options.  However, many academic libraries lack the staff, expertise, and/or time to engage with their websites as fully as they would like. Supporting the website needs of consortia members provides unique challenges, since consortia staff don’t usually have editing privileges on member libraries’ websites but still need to provide solutions to ensure the library’s patrons can access the library’s search tools, electronic resources, and more.

This article examines two case studies that illustrate the successful implementation of consortia-specific web design projects within the LOUIS network. The first, the LOUIS Tabbed Search Box Order Form, provides an opportunity for members to “order” a custom-made search box for the various services LOUIS supports that can then be embedded on their library’s website, enhancing the user experience and facilitating access to LOUIS resources. The second, the LOUIS Community Jobs Board, is a member-driven job listing tool that exists on the LOUIS site but that members can publish to instantly and conveniently using a Google Form. Both the Search Box Order Form and the Jobs Board have resulted in increased engagement with and satisfaction from member libraries. This article will include best practices, practical solutions, and sample code for both projects. This will hopefully prove beneficial to other consortia and library networks in developing similar web solutions that cater to the unique needs of their respective members.

## Background

LOUIS was founded by the library deans and directors of Louisiana’s public and private college and university libraries in 1992 to ensure cost-effective attainment of library technology and resources. Member libraries range from research-intensive universities to rural community colleges, to small seminary libraries, and everything in between.

LOUIS’s main technology support comes in the form of the Library Services Platform (LSP), comprised of the SirsiDynix Symphony Integrated Library System, including Enterprise Discovery; EBSCO Suite’s Discovery Service (EDS) and Publication Finder; WorldCat Discovery Service; and Atlas Systems’ ILLiad Resource Sharing Management software. LOUIS also works with members to reduce the cost of instructional materials through the [Affordable Learning LOUISiana initiative](https://louislibraries.org/initiatives/affordable-learning); to address digital inclusion needs, especially digital literacy, via our [Digital Inclusion Pilot](https://louislibraries.org/initiatives/digital-inclusion); to provide professional development opportunities; and to build a community of practitioners across the state.

[LOUIS’s Bylaws](https://louislibraries.org/ld.php?content_id=62353177) outline criteria for membership. Accepted members pay annual fees and participate in consortial governance. Members may use some or all the previously mentioned services through their LOUIS membership. Because of the wide range of needs created by such a diverse set of institutions, student bodies, and faculty and staff, LOUIS’s core staff of 11 provides a wide and ever-evolving range of services to meet the needs of the membership.

## Tabbed Search Box Order Form

In 2021, LOUIS engaged in a self-assessment to identify the consortium’s functional needs from the LSP, survey satisfaction with the current LSP, and to determine if the consortium should move forward with a Request for Proposal (RFP) process or pursue a new contract with the existing LSP provider. Data used in the assessment includes the results of a member survey, usage data from the LSP, data from LOUIS’s support ticket system, and data from SirsiDynix’s training portal to assess on which products and features members desired training.

One outcome of the LSP assessment was that members were not satisfied with existing tools provided by the consortia’s discovery systems to create search boxes for their websites. While LOUIS staff sometimes assisted members in such projects, it was at the request of the members, and there had not been any concerted effort to more broadly offer this as a service to all members.

In addition, the LSP assessment usage data showed that libraries without a search box on their website, unsurprisingly, had fewer searches in EDS and Enterprise than libraries with a search box, even when accounting for size of the institution. Member websites were coded as to whether they had a search box with a primary tab for searching EDS, a search box with a primary tab for searching Enterprise, separate search boxes for EDS and Enterprise, no search box, or Summon (one library which subscribes to Summon outside of their LOUIS membership). The assessment showed that institutions with an EDS search box have greater EDS and Enterprise search statistics than the other options, and unsurprisingly these institutions have far more EDS searches than Enterprise searches. Institutions with both an EDS and an Enterprise search box also have more than double the amount of EDS searches than Enterprise searches on their site. Institutions with an Enterprise search box and institutions with no search box have greater Enterprise searches than EDS searches.  A related study found an inverse relationship between database usage and embedding a generic [NC Live](https://www.nclive.org/) (another statewide library consortia) search box on an academic library website; while there is not a definitive correlation between the two, the authors theorized that this (among other features) “point to a less customized library website, which could mean that these libraries are lacking staff time or technical expertise to help their users get directly to database content, perhaps resulting in overall lower use” (Morris and Guhde, 2014).

![Number of searches by LOUIS member libraries with different search box types on their website](https://journal.code4lib.org/media/issue57/Kelly/fig-1_discovery-searches.png)
**Figure 1.** Number of searches by LOUIS member libraries with different search box types on their website

In the report to the membership overviewing the results of the LSP assessment, LOUIS staff recommended that member institutions looking to increase discovery of their resources may wish to consider implementing an EDS search box on their website. As a recommendation for further action, LOUIS committed to providing training as well as templates for creating and customizing search boxes.

Initially, the hope was that LOUIS could create a tabbed search box builder, like the [EBSCO Search Box Builder](https://searchbox.ebsco.com/) [^1]. While both EDS and SirsiDynix make tools and code available to create basic search boxes for their products, it was clear from previous member requests that members were not always sure what configuration details they needed to include in their search boxes. And even once the generic search boxes were created, customizing them to visually fit and function correctly within the member’s library website proved challenging, especially for libraries with less staff. Thus, the decision was made to instead create a search box order form with guided options for members to fill out. LOUIS would then create a custom-made search box based on their specifications, test it for accessibility, and test it embedded within their website using browser developer tools.

The Tabbed Search Box Order Form walks members through a series of questions about what they would like included in their search box. Members are given the option to include two different colors in their search box, a primary color and a secondary color. These colors are checked using [WebAIM’s Contrast Checker](https://webaim.org/resources/contrastchecker/) [^2] for sufficient contrast against the library’s website homepage as well as for appropriate text color to use.

![LOUIS’s Tabbed Search Box Order Form](https://journal.code4lib.org/media/issue57/Kelly/fig-2_Tabbed-Search-Box-Order-Form_colors.png)
**Figure 2.** LOUIS’s Tabbed Search Box Order Form

Members can select to include tabs for EDS, Enterprise, EBSCO’s Publication Finder, an A-Z Databases list, or other services they would like featured in the search box (pending LOUIS’s ability to add and configure these). Depending on which tabs they select to include, they are asked further questions such as whether they want to use authentication for their searching; whether to include selectors, like Keyword, Subject, or ISBN; and whether to include limiters, such as Full text or Peer Reviewed. There is also space in the form to make notes about other features or concerns. After the member has submitted the form, LOUIS staff open a ticket with them in the ticket management system, clarify any questions, and send a first draft of their search box within a week. The draft includes a working prototype on the LOUIS website which they can use to test functionality and a screenshot of what the search box will look like once embedded in their website, using Chrome’s Developer Tools to visualize the change. The code for the search box is analyzed using both [AChecker’s Web Accessibility Checker](https://achecks.org/checker/index.php) [^3] (which can check against WCAG 2.0 (Level AAA) guidelines) and the [WAVE Web Accessibility Evaluation Tool](https://wave.webaim.org/) [^4] (which uses the WCAG 2 Checklist) to find and correct accessibility and Web Content Accessibility Guideline (WCAG) errors before sharing. The search box is also tested using multiple browsers and an [online responsive checker](https://www.websiteplanet.com/webtools/responsive-checker/) [^5] for multiple devices.

Because of the difficulty in anticipating what features or functionality a member website might or might not have and how these might interfere with the search box code, a general template is used to mitigate potential issues. The search box uses only Bootstrap, CSS, and HTML for the search box code.

![Example ticket to a member library with a screenshot of what their new search box will look like when embedded on their homepage](https://journal.code4lib.org/media/issue57/Kelly/fig-3_Tabbed-Search-Box-Order-Form_ticket.png)
**Figure 3.** Example ticket to a member library with a screenshot of what their new search box will look like when embedded on their homepage

For ease of modifying the template, [CSS variables](https://www.w3schools.com/css/css3_variables.asp) [^6] are employed to change out the member’s requested color scheme. For example:

```css
:root {
  --primaryBackgroundColor: #c4d8e2;
  --primaryTextColor: #00263e;
  --secondaryBackgroundColor: #FFD700;
  --secondaryTextColor: #00263e;
  --tabHoverBackgroundColor: #003743;
  --tabHoverTextColor: #FFFFFF;
}
```

The Tabbed Search Box Order Form was promoted in the [LOUIS Lately biweekly newsletter](https://louislibraries.org/about/news/louis-lately), in monthly Watercooler meetings for the entire membership, and at the biannual System Administrators meeting. Since its release in January 2022, ten members have requested search boxes, and eight of those are functioning as the primary search box on the member’s website (two members have not yet implemented theirs). Of the ten members who have requested search boxes, only one member did not previously have a search box on their website. Three had single use search boxes (either Enterprise or EDS), and the remainder already had a combination tabbed search box but were interested in redesigning it. There are still ten members in the consortia who do not have search boxes on their websites, so next steps will include direct outreach to system administrators at these libraries to see if they would like to request a search box.

## Community Jobs Board

Another recent project is the [LOUIS Community Jobs Board](https://louislibraries.org/member-resources/jobs-board) [^7]. In 2022, after many pandemic-related statewide restrictions on in-person meetings began to be lifted, LOUIS staff “hit the road” at the request of members and paid visits to member libraries around the state. A frequent topic of conversation at these visits was the difficulty members were having hiring open positions, of which there were many. Retirements, organizational restructuring, and the Great Resignation were all contributing to an abundance of available jobs at LOUIS member libraries. LOUIS has long advertised employment opportunities at member libraries in its biweekly newsletter, but the need for a quicker and more easily accessible means for libraries to advertise their positions to a wider audience became clear. The idea for a jobs board that would live on the LOUIS website but that would allow submissions from members evolved over the course of several team meetings and small group consultations.

In outlining requirements for the jobs board, the following were identified as priorities:

1. Either use LOUIS’s existing website infrastructure or integrate easily into it
2. Allow posting by members, ideally without having to create an account or login to a new system
3. Automatic takedown of old job postings after a set period of time

In addition, the option to subscribe to new job postings was identified as a “nice to have” but not an essential feature.

[LOUIS’s website](https://louislibraries.org/) [^8] uses Springshare’s [LibGuides CMS](https://springshare.com/libguides/cms.html) [^9] as its content management service. Ideally, the jobs board could live on the LOUIS website, and members could post new jobs without needing to ask LOUIS to add their account to LOUIS’ LibApps. While LibGuides’ native functionality didn’t seem to include a solution that exactly matched LOUIS’s requirements, the [LibGuides Discussion Board](https://ask.springshare.com/springboards/faq/1950) [^10] feature came close. The jobs board would be a public discussion board, and CSS could be used to modify its appearance to more closely match some aspirational job boards, such as the [Code4Lib jobs board](https://jobs.code4lib.org/) [^11]. While users need to have a LibGuides account on the hosting website’s LibApps platform, there is an option to allow self-registration and to limit to approved domain names. Using this tool, LOUIS staff could pre-populate the approved domain names with the domains for all of our member institutions. While members would need to create an account to post their job, their registration would be approved immediately so long as they used their institutional email. Anyone with either a LOUIS LibGuides account or a patron account could sign up to be notified of new posts. This would allow LOUIS staff to monitor any possible spam that might come through. It also meant that job hunters could receive notifications for new job postings, though they’d either need to already have an email address from an approved domain, or request for LOUIS staff to manually create a patron account for them. This would need to be a larger discussion, as allowing email registrations for non-LOUIS members would necessitate a change to existing policies.

![LOUIS Jobs Board draft using LibGuides’ Discussion Board](https://journal.code4lib.org/media/issue57/Kelly/fig-4_jobs-board_old.png)
**Figure 4.** LOUIS Jobs Board draft using LibGuides’ Discussion Board

The result met most of the functional requirements, and beta testers from member institutions said the registration process was easy and quick. But because the model was trying to retrofit a discussion board format into a job posting format, there were hard limits on how much customization could be made to the styling of the board, and as a result, some of the labeling and functionality were confusing to testers. There wasn’t a way to customize the submission form to require or even encourage the inclusion of certain fields, like salary, location, or contact information. Furthermore, most of the visual styling to do simple things like rename the “Add New Discussion” link to “Add New Job Posting” were achieved using CSS hacks which might affect the [accessibility](https://www.w3.org/TR/WCAG20-TECHS/F87.html) of the page for users with screen readers (F87: Failure of Success Criterion…, 2016).

```css
/* Change "Add New Discussion" to "Add New Job Posting" */
#s-lg-disc-add-button {
    visibility: hidden;
    position: relative;
}
 
#s-lg-disc-add-button:after {
    content:'  Add New Job Posting';
    visibility: visible;
    position: absolute;
    top: 0;
    left: 0;
    margin-left: 10px;
}
```

**Figure 5.** Sample code for modifying default Discussion Board labels with CSS

For a second attempt at a solution, LOUIS staff turned to integrating outside tools with the LibGuides CMS website. Instead of using the Discussion Board feature, members would fill out a Google Form for job submissions. These submissions would automatically publish to the website using the [Google Sheets API](https://developers.google.com/sheets/api/guides/concepts). While this version required quite a bit more setup and has multiple moving parts to make it work, it provided the desired customization flexibility and also removed the need for members to create an account to post.

The Google Form lives in the LOUIS Google account. It is customized to include all of the desired fields and to make some fields required. The link to the Google Form is included in the biweekly LOUIS Lately newsletter and is also linked from an instructional article in the LOUIS knowledge base, which LOUIS members can request access to if they don’t already have it. The results of the form are posted to a linked Google Sheets workbook. The first page of the workbook (titled “jobs”) displays the results of the Google Form responses exactly as they were submitted, in chronological order. These are copied over to a second sheet using the formula:

```txt
=sort(jobs!A:K,1,FALSE)
```

to sort the most recent job first. This sheet also includes an additional column, “Hyperlink,” with a formula to turn any URLs submitted in the “More Information” form field (column H) into a hyperlink:

```txt
=IF(H2<>"","<a href='"&H2&"'>More information</a>","")
```

There is a Google Apps script running on the spreadsheet that finds the current date and deletes any rows with a timestamp in Column A older than 60 days. Triggers deploy the script once a day at midnight.

```javascript
function dro() {
  var sh = SpreadsheetApp.openById("YOURid").getSheetByName("jobs");
  const sr = 2; //data starts here
  // assume first column is date
  const rg = sh.getRange(sr,1,sh.getLastRow()-sr+1, sh.getLastColumn());
  let v = rg.getValues();
  let d = 0;
  let dtv = new Date().valueOf();
  v.forEach((r,i) => {
    if((dtv-new Date(r[0]).valueOf())/3600000 > 1440) {
       sh.deleteRow(sr+i-d++);
    }
  });
}
```

**Figure 6:** Google Apps script code to delete entries older than 60 days

The Google Sheets table from the sorted sheet is brought into the LibGuides CMS using a slightly modified version of a [CodePen by duyentnguyen](https://codepen.io/duyentnguyen-the-lessful/pen/VwXmoEM) [^12] and [CSS from Jeff Vdovjak](https://stackoverflow.com/posts/69007434/revisions) [^13] on StackOverflow. Finally, a simple Javascript search box is also included to search the job postings. The scripts and styling are pasted into a [Media/Widget asset](https://ask.springshare.com/libguides/faq/939) [^14] in LibGuides.

Google Forms has an integrated feature that allows for the Google account holder to be notified every time the form has been filled out. That has allowed LOUIS staff to monitor submissions to the board and ensure that any spam submissions are taken down (though so far that has not been an issue). If members need to edit their job posting after submitting the form they can do so immediately if they have not yet closed the submission window; if they have, they can contact LOUIS staff, who can edit the Google Sheet with the responses on it.

![LOUIS Community Jobs Board](https://journal.code4lib.org/media/issue57/Kelly/fig-7_jobs-board_current.png)
**Figure 7.** LOUIS Community Jobs Board

This new and improved version of the Jobs Board has proven highly successful since its debut in September 2022. Since then, the form has been submitted sixty times, and the Jobs Board webpage was the 11th most viewed page (out of 1024 published pages) on the LOUIS website from October 2022-June 2023. In a separate project involving a redesign of the LOUIS website, members were surveyed for feedback about the current website as well as desired features on the new website, and asked to work in small groups to identify the pages on the website they used the most. In both activities, users mentioned the Jobs Board as being a welcome recent addition to the site.

The full code for the Media/Widget, as well as instructions, are in [GitHub](https://github.com/elizabethjoankelly/jobs-board) [^15].

## Conclusion

While supporting the web needs of a statewide academic library consortia poses unique challenges, the benefits to doing so make the effort worthwhile. The LOUIS Tabbed Search Box Order Form and Community Jobs Board both use streamlined processes and templates to make these projects manageable, adaptable, and reusable. Both projects have been embraced by the LOUIS membership and resulted in solutions to longstanding consortia needs. Next steps for the Search Box Order Form include continued outreach to members who do not yet have a search box on their website, and analysis of usage statistics for libraries with their first search box to see if usage increases as theorized. The Community Jobs Board will continually be evaluated for its utility and to ensure that it is updated to meet new accessibility requirements. As LOUIS engages in further web endeavors for the LOUIS membership, both projects can serve as a sustainable, responsive model for LOUIS as well as for peer consortia and library networks.

## Notes

[^1]: [https://searchbox.ebsco.com](https://searchbox.ebsco.com/)

[^2]: [https://webaim.org/resources/contrastchecker/](https://webaim.org/resources/contrastchecker/)

[^3]: [https://achecks.org/checker/index.php](https://achecks.org/checker/index.php)

[^4]: [https://wave.webaim.org](https://wave.webaim.org/)

[^5]: [https://www.websiteplanet.com/webtools/responsive-checker](https://www.websiteplanet.com/webtools/responsive-checker/)

[^6]: [https://www.w3schools.com/css/css3_variables.asp](https://www.w3schools.com/css/css3_variables.asp)

[^7]: [https://louislibraries.org/member-resources/jobs-board](https://urldefense.proofpoint.com/v2/url?u=https-3A__louislibraries.org_member-2Dresources_jobs-2Dboard&d=DwMGaQ&c=Oo8bPJf7k7r_cPTz1JF7vEiFxvFRfQtp-j14fFwh71U&r=7JtowK4ZxUjI2XkEAJj2yjhRdXL7Rd0frzRJSG2wJTU&m=hv7dmf03qBazHTpzUj_6jWEwX7AmP93rlbIzAbutGN5y_R1GzS5Z6aOZzgWIB5dq&s=pl1mRx_tU-hMyVHZJ6WC6etExQG2u0AniApwhDbGp8o&e=)

[^8]: [https://louislibraries.org](https://louislibraries.org/)

[^9]: [https://springshare.com/libguides/cms.html](https://springshare.com/libguides/cms.html)

[^10]: [https://ask.springshare.com/springboards/faq/1950](https://ask.springshare.com/springboards/faq/1950)

[^11]: [https://jobs.code4lib.org](https://jobs.code4lib.org/)

[^12]: [https://codepen.io/duyentnguyen-the-lessful/pen/VwXmoEM](https://codepen.io/duyentnguyen-the-lessful/pen/VwXmoEM)

[^13]: [https://stackoverflow.com/posts/69007434/revisions](https://stackoverflow.com/posts/69007434/revisions)

[^14]: [https://ask.springshare.com/libguides/faq/939](https://ask.springshare.com/libguides/faq/939)

[^15]: [https://github.com/elizabethjoankelly/jobs-board](https://github.com/elizabethjoankelly/jobs-board)

## Bibliography

F87: Failure of Success Criterion 1.3.1 due to inserting non-decorative content by using :before and :after pseudo-elements and the ‘content’ property in CSS \[Internet\]. 2016. W3C® (MIT, ERCIM, Keio, Beihang); \[cited 2023 June 22\]. Available from [https://www.w3.org/TR/WCAG20-TECHS/F87.html](https://www.w3.org/TR/WCAG20-TECHS/F87.html)

Morris, J, Guhde, E. 2014. Making Usage Data Meaningful. Serials Review \[Internet\]. \[cited 2023 June 22\]; 40:3, 161-174. Available from [https://www.tandfonline.com/doi/full/10.1080/00987913.2014.948146](https://www.tandfonline.com/doi/full/10.1080/00987913.2014.948146)

*[Elizabeth Joan Kelly](https://journal.code4lib.org/articles/)* is the Library Web and Applications Development Administrator at LOUIS: The Louisiana Library Network. Her primary responsibilities include managing the consortium’s web presence, customizing user interfaces and search tools, analyzing usage data, and creating data visualizations to communicate assessment results and inform evidence-based decision-making. Previously, she worked for over a decade managing the digital library, digital preservation, digital scholarship, and library web services at Loyola University New Orleans. Elizabeth is an active music composer and has won awards for her instrumental, vocal, and electronic music.

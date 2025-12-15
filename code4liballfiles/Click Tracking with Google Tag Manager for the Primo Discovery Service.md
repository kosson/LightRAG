---
title: "Click Tracking with Google Tag Manager for the Primo Discovery Service"
source: "https://journal.code4lib.org/articles/16890"
author:
  - "Hui Zhang"
published: 2023-01-20
created: 2025-01-10
description: "This article introduces practices at the library of Oregon State University aiming to track the usage of Unpaywall links with Google Tag Manager for the Primo discovery interface. Unpaywall is an open database of links to full-text scholarly articles from open access sources\[[1](https://journal.code4lib.org/articles/#note1)\]. The university library adds Unpaywall links to Primo that will provide free and legal full-text access to journal articles to the patrons to promote more usage of open-access content. However, the usage of the Unpaywall links is unavailable because Primo does not track the customized Unpaywall links. This article will detail how to set up Google Tag Manager for tracking the usage of Unpaywall links and creating reports in Google Analytics. It provides step-by-step instructions, screenshots, and code snippets so the readers can customize the solution for their integrated library systems."
tags:
  - "#click/tracking"
  - "#Google/Tag/Manager"
  - "#Primo/Discovery/Service"
---
# Click Tracking with Google Tag Manager for the Primo Discovery Service

This article introduces practices at the library of Oregon State University aiming to track the usage of Unpaywall links with Google Tag Manager for the Primo discovery interface. Unpaywall is an open database of links to full-text scholarly articles from open access sources\[[1](https://journal.code4lib.org/articles/#note1)\]. The university library adds Unpaywall links to Primo that will provide free and legal full-text access to journal articles to the patrons to promote more usage of open-access content. However, the usage of the Unpaywall links is unavailable because Primo does not track the customized Unpaywall links. This article will detail how to set up Google Tag Manager for tracking the usage of Unpaywall links and creating reports in Google Analytics. It provides step-by-step instructions, screenshots, and code snippets so the readers can customize the solution for their integrated library systems.

Hui Zhang

## Introduction

In 2020, staff at Oregon State University Library started a project to provide single-click links to open access content in 1Search\[[2](https://journal.code4lib.org/articles/#note2)\], the University’s library discovery interface built on the Primo service platform\[[3](https://journal.code4lib.org/articles/#note3)\]. The goal of the project is to provide free and legitimate access to full-text scholarly resources for the patrons. Although Primo already includes open access content in the search results, there are studies \[[1](https://journal.code4lib.org/articles/#bib1)\] that show the Primo solution has significant flaws in indexing and providing open access resources. Ultimately, we decide to use Unpaywall, an open database that harvests and indexes tens of millions of open access scholarly articles, as the source of open access content in addition to Primo. By customizing the User Interface (UI) of Primo, we added Unpaywall links of open access content to the search result and the individual item view. However, it has a problem in that we cannot get the link usage statistics from Primo’s analytics tool because Primo does not track the Unpaywall links.

This article will detail tracking customized links in Primo using Google Tag Manager \[[4](https://journal.code4lib.org/articles/#note4)\] including testing, troubleshooting, and creating usage reports with Google Analytics. Although the case study is specific to tracking Unpaywall links, the workflow and configuration of Google Tag Manager are general. Users may also adapt the included snippets and tags to tracking activities for websites beyond the types used in library systems.

## Adding Open Access Links with Primo Customization

### Finding Open Access Resources in Primo

Primo users can find open access content in two ways. The first way is to filter the search results by selecting “Open Access” in the Availability facet.

![Open Access Facet in Primo.](https://journal.code4lib.org/media/issue55/zhang/figure1.png)**Figure 1.** Open Access Facet in Primo.

The second way of finding open access content is to look for the open access icon that will appear for an item identified as open access both in the search results and in the full item view.

![Open Access Indicator in Primo](https://journal.code4lib.org/media/issue55/zhang/figure2.png)**Figure 2.** Open Access Indicator in Primo.

Primo provides open access content in many resource types, such as journal articles, books, and theses.

### Why Adding Unpaywall Links to Primo

The significant flaw in Primo’s solution of providing open access is the preference for subscribed content over open access. One study \[[1](https://journal.code4lib.org/articles/#bib1)\] finds search results in Primo will provide article links to subscribed journals even when the articles are open access, undermining the visibility of open access content to the readers. With the growing demand to make more open access content available to the patrons, developers at Primo added a feature to integrate the Unpaywall API so users can find open access articles that may not appear or be available to them initially \[[2](https://journal.code4lib.org/articles/#bib2)\]. However, librarians at Oregon State University (OSU) finally decided to provide Unpaywall links to Primo by adopting a solution called OaDOI Link \[[3](https://journal.code4lib.org/articles/#bib3)\] developed by the Primo Customization Standing Group. The standing group is formed by the Orbis Cascade Alliance, which Oregon State University is a member of. One advantage of OaDOI Link is that the OSU library has better access to technical support as it is locally developed. But more importantly, a recent study \[[4](https://journal.code4lib.org/articles/#bib4)\] found that OaDOI Links can provide an estimated 30% more open access articles compared to Primo’s Unpaywall feature. We extend the OaDOI Links in our solution \[[5](https://journal.code4lib.org/articles/#bib5)\] to provide Unpaywall links to open access items in the brief display view next to the availability status.

![Customized Unpaywall link shown in the brief display of an open access item.](https://journal.code4lib.org/media/issue55/zhang/figure3.png)**Figure 3.** Customized Unpaywall link shown in the brief display of an open access item.

Offering Unpaywall as single-click links is a significant improvement to usability as library patrons can access the full-text contents without authentication with their university credentials.

### The Challenge of Tracking Unpaywall Links Usage in Primo

Because the Unpaywall links are added to Primo by a UI customization, we cannot get usage statistics of these links from Primo because they are not tracked. It is a major problem as usage data is crucial evidence to assess the impact and success of the Unpaywall project. To overcome the problem, we investigated the possibility of using Google Tag Manager to track the customized Unpaywall links.

As Primo continues to provide new features including link tracking, it is worth updating the latest situation so that the readers will have a better understanding of the motivation and contribution of our approach. Ex Libris, the company that develops Primo, added the capacity to track and report the usage of Unpayall links in August 2021 \[[6](https://journal.code4lib.org/articles/#bib6)\]. However, that feature is only available to Primo VE \[[7](https://journal.code4lib.org/articles/#bib7)\], a newer and different cloud computing platform to Primo. The Ex Libris solution was unavailable when we investigated the potential of Google Tag Manager in 2020, and we then used Primo, not Primo VE, as the discovery interface. For full disclosure, Oregon State University library migrated its discovery interface to Primo VE in the summer of 2022. However, many libraries worldwide are still using Primo, and our work on Google Tag Manager will help them to track customized links like Unpaywall in their discovery interfaces.

## Tracking Unpaywall Links with Google Tag Manager

### How Google Tag Manager Works

Perhaps many readers, like us, are confused when they try to understand what Google Tag Manager is at the beginning. We will explain how Google Tag Manager works by answering two questions: what is a tag and what is the difference between Google Tag Manager and Google Analytics?

According to Google, a tag is a code snippet deployed to measure website user activity \[[8](https://journal.code4lib.org/articles/#bib8)\]. These tags, or tracking codes, were usually created and deployed by developers before tools like Google Tag Manager were available. However, with Google Tag Manager, people can create, test, and deploy a tag without programming skills. Creating triggers that will tell the Manager when, where, and how to operate the tag is required to set up a tag. Google Tag Manager provides two types of triggers: All Elements and Just links. The All Elements trigger can track clicks on any element on a page, e.g. links, images, and buttons. The Just links trigger can track clicks on HTML links that use the element.

Google Tag Manager and Google Analytics are two different tools, but you should always use them together. Google Tag Manager can add Google Analytics tracking code (i.e., tag) to the website but can not create reports. Instead, it will send activity data of the website to Google Analytics for analyzing and reporting.

### Adding Google Tag Manager to Primo

Your first step to adding Google Tag Manager to Primo will be creating an account. Go to the Google Tag Manager website to create an account or log in using your Google account. Then you need to create and name a container with “Web” as the target platform, and you will be given an id in the format of “GTM-xxxxxxx” after the container has been created. Take note of the container identifier because you will need it in the next step. We suggest creating a container for every website, then defining tags for activities you want to track in the newly created container.  
You will add a snippet to Primo to allow Google Tag Manager to track the web activity. The technical detail of managing and customizing the Primo UI package is beyond the scope of this article. However, the Primo administrators should have the knowledge and privilege to add the sample JavaScript snippet below to Primo. Make sure you use the correct container id in the snippet.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19 | `/* Google Tag Manager */`  `const gtmId = 'GTM-xxxxxxx'`  `function addGTM(doc) {`  `const newScript = doc.createElement('script')`  ``const scriptText = `(function(w,d,s,l,i){w[l]=w[l]\|\|[];w[l].push({'gtm.start':``  `new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],`  `j=d.createElement(s),dl=l!='dataLayer'?'&amp;l='+l:'';j.async=true;j.src=`  `'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);`  `` })(window,document,'script','dataLayer','${gtmId}');` ``  `newScript.innerHTML = scriptText`  `doc.head.append(newScript)`  `const noscript = doc.createElement('noscript')`  ``const noscriptText = `&lt;iframe src="//www.googletagmanager.com/ns.html?id=${gtmId}"``  `` height="0" width="0" style="display:none;visibility:hidden"&gt;&lt;/iframe&gt;` ``  `noscript.innerHTML = noscriptText`  `doc.body.insertBefore(noscript, doc.body.firstChild)`  `}`  `addGTM(document)` |
| --- | --- | --- | --- |

Then you need to save and deploy the change so it will take effect in Primo. Congratulations! You have done all the required configuration for Primo, and all the rest will happen in Google Tag Manager.

### Creating tag and trigger for Unpaywall link clicks

You will create a Google Tag Manager tag and trigger in the newly created container. For example, you can create and name a tag called “Unpaywall” with the type of Google Analytics and associate the tag with an existing Google Analytics account. In our case, we associate the tag with the Google Analytics account of Primo.

![Google Tag Manager Tag with the type of Google Analytics](https://journal.code4lib.org/media/issue55/zhang/figure4.png)**Figure 4.** Google Tag Manager Tag with the type of Google Analytics

Inside the new tag, you need to create a trigger that fires the tag when the Unpaywall link is clicked.

![ Google Tag Manager trigger for tracking Unpaywall link clicks](https://journal.code4lib.org/media/issue55/zhang/figure5.png)**Figure 5.** Google Tag Manager trigger for tracking Unpaywall link clicks

For our purpose of tracking the link click events, make sure you will select “All Elements” for the trigger type. The next step is to attach a condition or rule to the created trigger. In our example, we create a condition like this: the tag is activated when links with the text “Open Access(via Unpaywall)” are clicked. The link text used in the trigger is the label of the Unpaywall link we added to Primo UI by our customization code. If you want to customize the method, you can define a trigger with different conditions that are appropriate for your need.

### Trigger testing and troubleshooting

People can test newly created tags and triggers using the Preview feature in Google Tag Manager.

![Google Tag Manager Preview for testing tags and triggers.](https://journal.code4lib.org/media/issue55/zhang/figure6.png)

**Figure 6.** Google Tag Manager Preview for testing tags and triggers.

The preview feature is available at the container level. A pop-up window appears after clicking the “Preview” button, where you can enter the URL of the Primo instance for testing. After the connection is established, you can go to the Primo website, click the Unpaywall link, and check whether the tag is triggered as expected in Google Tag Manager. The browser’s developer console will be your best tool for troubleshooting. For example, we use Chrome’s console to confirm the label text for the Unpaywall link is the same as entered in the trigger condition. After finalizing the configuration with the preview, you must verify the changes by clicking the “Submit” button next to the right of the “Preview.” You will be asked to create a version of your container and finally publish it. The deployment is reasonably quick, and in our example, we can see click data shown in Google Analytics a few minutes after we published the change in Google Tag Manager.

### Generating usage report with Google Analytics

You can use the many report functions in Google Analytics to review and analyze the data collected by Google Tag Manager. In our example, we can find statistics of Unpaywall link usage in the Event under Behavior, then in the “Click” event category.

![Click event report in Google Analytics.](https://journal.code4lib.org/media/issue55/zhang/figure7.png)**Figure 7.** Click event report in Google Analytics.

The result is promising as it shows patrons are attracted to open access content, and there is a clear trend that more patrons are using the Unpaywall links. For instance, the total number of clicks for the Unpaywall link is 53,361 during the calendar year of 2021. That number jumped to 60,534 for the first six months of 2022 until OSU migrated its discovery interface to Primo VE.

## Conclusion

In this article, we describe the work of tracking customized Unpaywall links with Google Tag Manager in Primo. We outline the motivation of our project, introduce Google Tag Manager, and provide details on how to define tags for tracking Unpaywall link clicks. We have used data collected by Google Tag Manager for decision-making. For example, we have decided to continue to provide open access and Unpaywall links in Primo VE with the usage statistics of Unpaywall links collected in Primo. By integrating Google Tag Manager and Google Analytics, we can also get more insights into patrons’ activities, such as which open access databases are popular and which subjects patrons are most interested in. We hope the code and screenshots are helpful and the readers can refer to them in their works.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Unpaywall: [https://unpaywall.org/](https://unpaywall.org/)  
\[[2](https://journal.code4lib.org/articles/#ref2)\] 1Search: [https://search.library.oregonstate.edu/](https://search.library.oregonstate.edu/)  
\[[3](https://journal.code4lib.org/articles/#ref3)\] Primo service platform: [https://exlibrisgroup.com/products/primo-discovery-service/](https://exlibrisgroup.com/products/primo-discovery-service)  
\[[4](https://journal.code4lib.org/articles/#ref4)\] Google Tag Manager: [https://tagmanager.google.com/](https://tagmanager.google.com/)

## References

\[[1](https://journal.code4lib.org/articles/#refb1)\] Bulock, C. (2021). Finding Open Content in the Library Is Surprisingly Hard, Serials Review, 47:2, 68-70, DOI: 10.1080/00987913.2021.1936416  
\[[2](https://journal.code4lib.org/articles/#refb2)\] How to utilize the Unpaywall API for open access content and resources in discovery. (2021). Ex Libris Knowledge Center. [https://knowledge.exlibrisgroup.com/Alma/Knowledge\_Articles/How\_to\_Utilize\_the\_Unpaywall\_API\_for\_Open\_Access\_Content\_and\_Resources\_in\_Discovery](https://knowledge.exlibrisgroup.com/Alma/Knowledge_Articles/How_to_Utilize_the_Unpaywall_API_for_Open_Access_Content_and_Resources_in_Discovery)  
\[[3](https://journal.code4lib.org/articles/#refb3)\] OaDOI link. (2022). Orbis Cascade Alliance. [https://www.orbiscascade.org/programs/systems/pcsg/primo-ve-toolkit/oadoi-link/](https://www.orbiscascade.org/programs/systems/pcsg/primo-ve-toolkit/oadoi-link/)  
\[[4](https://journal.code4lib.org/articles/#refb4)\] Veldhuisen, K. (2020). Unpaywall in Alma, OADOI customization in Primo (and other open access). Retrieved from [https://docs.google.com/document/d/1RBz7l4\_KTrA7PsXFxATpyjEV-oG3siZW1QjRPxc5ebk/edit](https://docs.google.com/document/d/1RBz7l4_KTrA7PsXFxATpyjEV-oG3siZW1QjRPxc5ebk/edit)  
\[[5](https://journal.code4lib.org/articles/#refb5)\] Osulp/1search-ui-package. (2021). GitHub. [https://github.com/osulp/1search-ui-package](https://github.com/osulp/1search-ui-package)  
\[[6](https://journal.code4lib.org/articles/#refb6)\] Primo VE 2021 release notes. (2022, May 6). Ex Libris Knowledge Center. [https://knowledge.exlibrisgroup.com/Primo/Release\_Notes/002Primo\_VE/2021/010Primo\_VE\_2021\_Release\_Notes](https://knowledge.exlibrisgroup.com/Primo/Release_Notes/002Primo_VE/2021/010Primo_VE_2021_Release_Notes)  
\[[7](https://journal.code4lib.org/articles/#refb7)\] Primo VE overview. (2022, September 18). Ex Libris Knowledge Center. [https://knowledge.exlibrisgroup.com/Primo/Product\_Documentation/020Primo\_VE/Primo\_VE\_(English)/010Getting\_Started\_with\_Primo\_VE/005Primo\_VE\_Overview](https://knowledge.exlibrisgroup.com/Primo/Product_Documentation/020Primo_VE/Primo_VE_\(English\)/010Getting_Started_with_Primo_VE/005Primo_VE_Overview)  
\[[8](https://journal.code4lib.org/articles/#refb8)\] Overview. (2022). Google Developers. [https://developers.google.com/tag-platform/devguides](https://developers.google.com/tag-platform/devguides)

## About the Author

Hui Zhang (Hui.Zhang@oregonstate.edu) is the Digital Services Librarian at the Oregon State University.
---
title: "Trust, But Verify: Auditing Vendor-Supplied Accessibility Claims"
source: "https://journal.code4lib.org/articles/15122"
author:
  - "[[The Code4Lib Journal]]"
published: 2020-05-11
created: 2025-01-10
description: "Despite a long-overdue push to improve the accessibility of our libraries’ online presences, much of what we offer to our patrons comes from third party vendors: discovery layers, OPACs, subscription databases, and so on. We can’t directly affect the accessibility of the content on these platforms, but rely on vendors to design and test their [...]"
tags:
  - "clippings"
---
# Trust, But Verify: Auditing Vendor-Supplied Accessibility Claims
Melina Zavala, Matthew Reidsma

Despite a long-overdue push to improve the accessibility of our libraries’ online presences, much of what we offer to our patrons comes from third party vendors: discovery layers, OPACs, subscription databases, and so on. We can’t directly affect the accessibility of the content on these platforms, but rely on vendors to design and test their systems and report on their accessibility through Voluntary Product Accessibility Templates (VPATS). But VPATs are self-reported. What if we want to verify our vendors’ claims? We can’t thoroughly test the accessibility of hundreds of vendor systems, can we? In this paper, we propose a simple methodology for spot-checking VPATs. Since most websites struggle with the same accessibility issues, spot checking particular success criteria in a library vendor VPAT can tip us off to whether the VPAT as a whole can be trusted. Our methodology combines automated and manual checking, and can be done without any expensive software or complex training. What’s more, we are creating a repository to share VPAT audit results with others, so that we needn’t all audit the VPATs of all our systems.

Like many institutions, GVSU University Libraries has made web accessibility a priority, especially in recent years after a 2016 investigation by the U.S. Department of Education over web accessibility was resolved (Grand Valley State University 2017; United States Department of Education 2017). While we have worked to improve the accessibility of our own online interfaces, most of our software is licensed from third-parties: discovery layers, link resolvers, OPACs, and particularly our subscription databases.

Thankfully, vendors often self-report their own accessibility testing, since most of their customers are, like us, federally obligated to meet accessibility standards. The Voluntary Product Accessibility Template (VPAT) is a document created by the Information Technology Industry Council to show how software meets the Americans with Disabilities Act (ADA) Section 508 guidelines (Voluntary Product Accessibility Template \[updated 2018 April\]) . VPATs are a useful window into the accessibility of web software, but they rely on the software vendor to self-report whether or not their software meets these guidelines (Adams et al 2018). Because the documents are voluntary and self-reported, others in the library world have noted that “completed VPATs often lack detail and vendors can easily hide product deficiencies in this document” (Adams et al 2018). This was also a concern for us at GVSU, after finding problematic accessibility issues in many of our tools that were not reflected in the product’s VPAT.

More recently, with the increasing adoption of VPATs by vendors, several other publications have chronicled attempts to verify the vendor claims. In 2015, Laura DeLancy published a study where she aimed to do a near-comprehensive automated test of complete vendor VPATs, and found that the VPATs she tested were around 20% incorrect (DeLancy 2015). A 2016 study of course management software accessibility in higher education found that automated testing only gets us so far – the results must still be interpreted by someone trained in accessibility (Kumar and Owston 2016). Michael Fernandez also used automated tools to audit vendor databases for accessibility but did not bother reviewing VPATs, since “ there is no requirement for vendors to complete VPATs, there is often a significant lack of consistency among the VPATs that vendors do provide” (Fernandez 2018). The Tennessee Board of Regents, as part of their push to improve the accessibility of their resources, planned in 2018 to audit the VPATs of all commercially licensed databases (Adams et al 2018). More recently, Rysavy and Michalak (2020) published the results of an automated audit of their licensed databases for the Goldey-Beacom College Library, where they needed to support a blind student. They noted the limitations of automated tools, in that automated tools help you identify where problems exist, but most automated reports still require interpretation by a knowledgeable person (Rysavy and Michalak 2020).

Because of the labor involved with individual libraries conducting tests of every licensed resource, several groups got together to run audits together to share the labor. After all, licensed subscription databases are the same for all libraries at a given time. In 2015, a group of UK libraries banded together to audit eBook databases (The eBook accessibility audit \[2016\]). Their reports are available online, and often highlight accessibility issues that vendors had not mentioned in VPAT disclosures. Meanwhile in the United States, the Big Ten Alliance conducted similar third-party reviews of subscription databases (Library E-Resource Accessibility – Testing \[n.d\]), and these reports are available to all libraries online as well.

At GVSU, we wanted to make sure we were doing everything we could to improve the accessibility of our online offerings for our students. From reviewing all of these thorough reports published by other libraries and consortia, it was clear that library software vendors have made remarkable improvements over the past two decades. But from our own casual testing and user reports, we knew that there was still a lot to be done.

While it has been encouraging that vendors have made improvements over the past two decades, there is still work to do. Yet most libraries do not have the resources or expertise to do the kinds of full accessibility evaluations envisioned by DeLancey (2015) and Fernandez (2018) in their studies. The studies themselves have a short shelf life, as well, given the increasing emphasis on accessibility improvements and the wide adoption of agile development methods, with frequent and continuous software releases. It also strikes us as problematic that libraries are already paying licensing fees that outpace inflation by several orders of magnitude, and then vendors also benefit from our thorough accessibility testing of these products? That feels like an additional accessibility tax which we were not willing to pay.

In our case, we wanted a quick and dirty method for checking up on the accessibility claims of our vendors. If the introductory statements of our vendor VPATs are to be believed, they have already done this detailed accessibility testing. The primary reason we want to verify that our vendors’ VPATs are accurate is because accessibility is a priority at our institution. We strongly believe that all our users deserve equitable and seamless access to our resources. In addition, digital accessibility is the law. Subscribing libraries, not commercial vendors, are responsible if the systems we subscribe to do not meet federal accessibility requirements (Mulliken 2019). Because of this, it is important to take this extra step to verify that our software is accessible for all users.

We needed a way to identify the most common problems vendors face with accessibility, so that we could focus our spot checks on those items only. The in-depth published study of vendor VPATs by DeLancey (2015) was over five years old at this point, and the article itself did not detail the errors every vendor faced. We also did not have the resources or time to conduct even a handful of large-scale accessibility reviews to determine this criteria. Luckily, from 2015 through 2019 the Big 10 Academic Alliance began conducting in-depth accessibility reviews on subscription databases, and publishing the results online (Library E-Resource Accessibility – Testing \[n.d.\]). We began this project with the assumption that most vendors suffered from the same common accessibility errors, and so we used the 65 reports available in February 2020 from the Big Ten Alliance as a data set to look for the most common accessibility issues.

Reviewing all of the reports, we discovered that nearly every vendor product suffered from a combination of the same 5 or 6 accessibility issues. Those issues are:

1. **Improper heading use** (No headings, skipped heading levels)
2. **Lack of consistent image alt text** (Alt text missing, regardless of whether it is useful)
3. **Improper form structure** (Missing or incorrect use of labels, fieldsets, and legends.)
4. **Low color contrast**
5. **Keyboard navigation errors** (logical order, visible focus, keyboard traps)

These same issues were the most commonly reported accessibility issues in DeLancey’s 2015 study. So, while improvements have been made to increase the accessibility of library software, the major challenges are still in the same areas.

In addition, many vendors did not make alerts or other messages that are created asynchronously available to users of assistive devices. To ensure screen readers are aware of messages that appear without a page load, developers must make use of Accessible Rich Internet Application attributes (ARIA). ARIA has a significant learning curve compared to the 5 accessibility issues listed above. Developers have to understand how to incorporate ARIA attributes into their HTML to let assistive technologies know the semantic purpose of each section of the page, as well as integrate ARIA attributes into their scripts to ensure that dynamic content is properly recognized and announced to the reader. Since our goal with this project was to make spot-checking VPATs accessible to library staff without specialized training, we opted not to use it as a testing criteria. In every case from the Big 10 Alliance Accessibility Tests, vendors who failed to make messages and status updates accessible also failed the more basic criteria listed above.

We then developed a simple method for testing vendor tools for these three items. First, we look over the most recent vendor VPAT. Many vendors now list their VPATs on their support websites, although you may have to ask your sales representative for a copy \[[1](https://journal.code4lib.org/articles/#note1)\]. The WCAG 2.0 areas that relate to our five test areas of vendor VPATs are as follows:

- Improper Heading Use
- 1.3.1 [Information and Relationships](http://www.w3.org/TR/UNDERSTANDING-WCAG20/content-structure-separation-programmatic.html)
- 1.3.2 [Meaningful Sequence](http://www.w3.org/TR/UNDERSTANDING-WCAG20/content-structure-separation-sequence.html)
- 2.4.6 [Headings and Labels](http://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-descriptive.html)

- Lack of consistent image alt text
- 1.1.1 [Non-text content](https://www.w3.org/TR/UNDERSTANDING-WCAG20/text-equiv-all.html)
- 1.4.5 [Images of Text](http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-text-presentation.html) (Cannot be tested with automated tools)
- Improper form structure
- 1.3.1 [Information and Relationships](http://www.w3.org/TR/UNDERSTANDING-WCAG20/content-structure-separation-programmatic.html)
- 3.2.2 [On Input (Cannot be tested with automated tools)](http://www.w3.org/TR/UNDERSTANDING-WCAG20/consistent-behavior-unpredictable-change.html)
- 3.3.2 [Labels or Instructions](http://www.w3.org/TR/UNDERSTANDING-WCAG20/minimize-error-cues.html)
- Low color contrast
- 1.4.1 [Use of Color](http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-without-color.html) (Cannot be tested with automated tools)
- 1.4.3 [Contrast (Minimum)](http://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html)

- Keyboard navigation
- 2.1.1 [Keyboard](http://www.w3.org/TR/UNDERSTANDING-WCAG20/keyboard-operation-keyboard-operable.html)
- 2.1.2 [No Keyboard Trap](http://www.w3.org/TR/UNDERSTANDING-WCAG20/keyboard-operation-trapping.html)
- 2.4.1 [Bypass Blocks](http://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-skip.html)
- 2.4.3 [Focus Order](http://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-focus-order.html) (Cannot be tested with automated tools)
- 2.4.7 [Focus Visible](http://www.w3.org/TR/UNDERSTANDING-WCAG20/navigation-mechanisms-focus-visible.html) (Cannot be tested with automated tools)
- 3.2.1 [On Focus](http://www.w3.org/TR/UNDERSTANDING-WCAG20/consistent-behavior-receive-focus.html) (Cannot be tested with automated tools)

When looking at vendor VPATs, reports of “Partially supports” with details of what situations are not yet fully compliant with an accessibility guideline are encouraging. When vendors are doing a thorough accessibility test they will encounter errors that impede accessibility. If they are transparent enough to report that there are problems and that they are working on the issue, you can likely trust the results of the VPAT. On the other hand, if a vendor claims they support every accessibility guideline that applies to them, this is a red flag. We have yet to encounter any vendor site that meets all accessibility guidelines. Because larger vendors have more resources to support accessibility, they will likely have more accurate and detailed VPATs (Fernandez 2018).

To test the first four items, we installed the WAVE accessibility testing extension in our web browser of choice \[[2](https://journal.code4lib.org/articles/#note2)\]. We visited a page from the vendor, preferably in the way most of our users would encounter it, such as an article landing page linked from our discovery layer’s search results or the link resolver. We then clicked the WAVE extension to run the page through WAVE’s automated accessibility checker. While there are certainly drawbacks in using automated accessibility tests (Rysavy and Michalak 2020; DeLancey 2015; Kumar and Owston 2016), for the purposes of seeing how accurately vendors report the results of their own accessibility testing, automation is often enough.

![WAVE shows both accessibility features and errors on any webpage you test.](https://journal.code4lib.org/media/issue48/reidsma/Figure1.png)  
**Figure 1.** Screenshot of WAVE test results screen on Taylor and Francis database.

WAVE will show a list of errors and alerts. At this point, we read through the results to look for accessibility issues that fall into one of the first four categories above. If there are images without alt text, for instance, we look carefully at the image to see if the image is decorative (in which case there should be no alt text). If the image is supposed to convey meaning, then missing alt text means the content of that image is not available to low-vision or no-vision users. If the vendor skips heading levels, or has empty headings on the page, we note those, as well as any color contrast or form issues.

It is possible that WAVE will report accessibility errors that are not, in fact, errors. Alt text is a great example. WAVE cannot tell if an image is decorative or not, and so it flags every image without alt text as an error. As Rysavy and Michalak (2020) note, “Running your website through the WAVE tool does not result in a ‘pass’ or ‘fail,’ … \[because\] only humans can determine whether a web page is accessible.”

Finally, we test for the fifth area of concern: keyboard navigation. For this we use a simple manual test. We refresh the page (to remove the WAVE test results), and proceed to hit “Tab” to navigate through the page. Tab moves us forward, and Shift + Tab moves us back. The site should move us logically through every hyperlink on the page, from left to right and top to bottom. We should always be able to see where the focus is, often by the link being surrounded by a dotted line box. At no point should the focus visually disappear, and we should be able to tab through the whole page and then start over at the top again. We should never get trapped in a loop, or end up in a situation where keyboard users are “trapped” in a pop-up window or section of the site that we cannot escape. This manual test uncovers many issues. As Oswal (2014) noted, “If one were to try to use these databases solely with a keyboard without a mouse, one would quickly discover a number of accessibility failures on their front search pages.”

Running the WAVE test and the manual keyboard test takes between three and five minutes, in our experience. Because this test does not rely on an understanding of assistive technologies, or an understanding of writing accessible code, it can be done simply by nearly anyone in the organization. And because it is so quick, it can easily be updated as vendors release new updates that improve accessibility or add new features.

Although this is a quick method, we still looked for criteria to prioritize testing some vendor tools over others. In the end, we contacted our Collection Strategist Librarian and Acquisitions Librarian to ask for any databases that were up for renewal this year, as well as a list of the top vendors in terms of cost to the University Libraries. The list of vendors we tested on this first round was \[[3](https://journal.code4lib.org/articles/#note3)\]:

- EBSCOHost \[[4](https://journal.code4lib.org/articles/#note4)\]
- ProQuest \[[5](https://journal.code4lib.org/articles/#note5)\]
- Taylor & Francis \[[6](https://journal.code4lib.org/articles/#note6)\]
- Wiley \[[7](https://journal.code4lib.org/articles/#note7)\]
- Elseivier (Science Direct) \[[8](https://journal.code4lib.org/articles/#note8)\]
- Springer \[[9](https://journal.code4lib.org/articles/#note9)\]
- Oxford \[[10](https://journal.code4lib.org/articles/#note10)\]

All total, even counting the time we took to take detailed notes for this article, we spent just under 90 minutes running these tests.

After testing, there were clear discrepancies between what the vendor’s VPAT claimed and the results of our basic accessibility tests of each platform. The main issues seen across most of the platforms were low color contrast and issues with form labels. While not all vendors exhibited the same problems, every vendor we tested had accessibility issues that were not reflected in the VPAT. Most of the VPATs we reviewed contained sections that admitted that the software did not fully meet accessibility guidelines, detailing the issues that had been found, and at times, even offering a road map and estimated timeline for the issue to be resolved. For instance, ProQuest noted in their report of section 1.3.5, Identifying Input Purpose, that as of the first quarter of 2020, they should have addressed issues with the autocomplete connecting to the form field and label that it is associated with. In addition, Springer noted in several places that they “…are in the process of transferring all content from the older design to the newer design,” which would address certain problems with meeting accessibility guidelines. As we approach contract renegotiation, we will revisit those issues in order to see if they have been addressed.

On the other hand, some vendors were honest about their issues, but perhaps not clear about their plans to resolve them. Oxford noted in its VPAT for sections 1.1.1 and 2.1.1 that it had no support for these basic areas of non-text content and keyboard navigation. They noted that they had “unlabeled and ambiguous form fields”, “missing alternative text” for images, and “non-descriptive alt text” for many of the images that did have the attribute. In addition, for keyboard navigation in their VPAT, they admitted that some areas of their pages were inaccessible to keyboard users. In our test, we verified through a single page that there were orphaned form labels, redundant form labels and alt text (several images on the page had the same alt text), and that there were significant problems with keyboard navigation. Several links did not receive visual focus when navigating with the keyboard, and in fact many “links” had no visual indication that they were links at all. One highlight was that the “Skip to main content” link was hidden visually under normal circumstances, it immediately became visible and received focus when keyboard navigation began. While it is admirable that Oxford documented these issues with their online tool, this VPAT was finalized in 2017. We ran our test over 2 years later, and all of these issues remain. The VPAT should not work as merely a confessional. Vendors must work to improve the deficiencies in their accessibility as well. When we approach renegotiation with Oxford at the end of our current contract, we will share the results of our audit as part of our negotiation.

In another case, Wiley listed many accessibility issues, but upon testing, we found a completely different set of issues with their user interface. They admit in their VAT to missing alt text on images and struggling with keyboard navigation (Wiley 2018), and these were for the most part still problems. (Many of their images had alt text that said “image,” which is perhaps less useful than just leaving the alt text blank.) However, they reported that they handled visible focus well, and that they associated all input fields with the appropriate labels. In reality, though, we found that keyboard focus visually disappeared at times, and the results page we tested had several orphaned form labels, which will confuse assistive technologies.

The larger vendors, ProQuest and EBSCO, generally reported correctly the issues that they faced with accessibility. They both admitted to having limited issues with color contrast and alt text, as well as some issues where form labels were not associated with their input fields. Both vendors had recent VPATs (within the last six months), and at times suggested that they were working on a fix for specific issues listed in the VPATs. We did find a few issues that were in the article content, rather than in the user interface. Both vendors, as well as Science Direct, mentioned that they had limited ability to verify or improve the accessibility to content in their platforms. Nevertheless, the issue of inaccessible content will be something we address in our next renegotiation.

While most of the vendors at least admitted they had some issues, Taylor & Francis did not. Their VPAT claims its platform meets all of the accessibility guidelines with no issues., Unfortunately, their platform was the one that had the most problems come up. They were missing alt text on many images, they had several “empty” heading and buttons (which are not visible to sighted users, but will be announced with no content to users of assistive technologies), unlabeled form elements, and an all around sloppy use of headings, skipping heading levels seemingly at will.

These issues would make it hard for a screen reader to parse through and accurately tell the user what is on the page. For the non-automated part of the test, there were also a lot of issues; the skip link in the beginning of the page did not have a visible focus (it never appeared visually on the screen, so for a sighted user, it appeared that keyboard navigation was not possible). The search bar, perhaps the most useful element in the user interface, also did not have visible focus. When we finally made it to the content, the article itself was a PDF image, with alternative text that said “free first page,” but not the text of the article itself. (It is unclear whether we could get to an OCR version of the PDF by going deeper into the results.) This is a huge problem for the users who are not able to read the image itself and rely on screen readers to read it for them. What’s more, this result was shown to an authenticated user, not someone landing on the article page from the open web. The content should already be available to authorized users, right up front. To cap it off, Taylor & Francis traps keyboard users at the end of the page, looping between sharing and social media icons and the web browser’s user interface. Once a keyboard user makes it to the share icons, the rest of the page, including article content, becomes inaccessible. These issues, as well as the incorrect VPAT, will be passed along to our acquisitions and collections team to become part of our next licensing negotiation with Taylor and Francis.

While we hold no illusions that we have captured a detailed accounting of the accessibility of our licensed databases through this simple exercise, we felt that it was time well spent. In less than two hours, we walked away with detailed notes that will enable our licensing team to press the vendors for more thorough responses, more decisive action, more transparent timelines, and perhaps even a more fair license for our library. Since the process is relatively simple and quick, there is no need for a public repository of test results that will go out of date as soon as the vendor pushes the newest version live. Most libraries have the ability to conduct five minute verifications of their vendors’ VPATs. If we all approach the license negotiations with notes about inaccuracies in a vendor’s VPAT, perhaps then we will make even quicker progress in ensuring our licensed materials are accessible to all our users.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] You can also check Laura DeLancey’s VPAT website (DeLancey 2019), although many of these are 5 or more years old.

\[[2](https://journal.code4lib.org/articles/#ref2)\] You might need to test with multiple browsers to make sure that these basic accessibility guidelines are met, but we’ve never had a situation where a vendor was perfect with one browser and not others.

\[[3](https://journal.code4lib.org/articles/#ref3)\] SAGE was also on our list based on total cost per year, but we did not receive their VPAT information in time to add them to the testing protocol.

\[[4](https://journal.code4lib.org/articles/#ref4)\] EBSCO’s VPAT is available to subscribing libraries by emailing [support@ebsco.com](https://journal.code4lib.org/articles/)

\[[5](https://journal.code4lib.org/articles/#ref5)\] ProQuest VPATs are available from their Accessibility Directory at [https://support.proquest.com/articledetail?id=kA140000000GuogCAC](https://support.proquest.com/articledetail?id=kA140000000GuogCAC).

\[[6](https://journal.code4lib.org/articles/#ref6)\] Taylor and Francis’ VPAT is available from [https://help.taylorfrancis.com/students\_researchers/s/article/Voluntary-Product-Accessibility-Template-VPAT](https://support.proquest.com/articledetail?id=kA140000000GuogCAC).

\[[7](https://journal.code4lib.org/articles/#ref7)\] Wiley’s VPAT is available by contacting your account manager. See [https://onlinelibrary.wiley.com/accessibility](https://onlinelibrary.wiley.com/accessibility) for more details.

\[[8](https://journal.code4lib.org/articles/#ref8)\] Elsevier’s Science Direct VPAT is available at [https://www.elsevier.com/solutions/sciencedirect/support/web-accessibility](https://www.elsevier.com/solutions/sciencedirect/support/web-accessibility).

\[[9](https://journal.code4lib.org/articles/#ref9)\] Springer’s VPAT is available on Github at [https://github.com/springernature/vpat/blob/master/springerlink.md](https://github.com/springernature/vpat/blob/master/springerlink.md).

\[[10](https://journal.code4lib.org/articles/#ref10)\] Oxford University Press’ VPAT is available at [https://academic.oup.com/journals/pages/about\_us/legal/accessibility](https://academic.oup.com/journals/pages/about_us/legal/accessibility).

## References

Adams, SJ., Halaychik, C., and Mezick, J. 2018. Accessibility compliance: One state, two approaches. The Serials Librarian, 74(1-4): 163-169.

Byerley, SL., and Chambers, MB. 2003. Accessibility of Web-based library databases: the vendors’ perspectives. Library Hi Tech 21(3): 347-357.

Byerley, SL., Chambers, MB., and Thohira, M. 2007. Accessibility of web-based library databases: The vendors’ perspectives in 2007. Library Hi Tech, 25(4): 509-527.

DeLancy, L. 2015. Assessing the accuracy of vendor-supplied accessibility documentation. Library Hi Tech 33(1): 103-113.

DeLancey, L. 2019. VPAT repository. \[cited 2020 Mar 17\]. Available from https://vpats.wordpress.com/.

Dermody, K. and Majekodunmi, N. 2011. Online databases and the research experience for university students with print disabilities. Library Hi Tech 29(1): 149-160.

The eBook accessibility audit. \[Internet\]. \[updated 2016\]. Ebook audit 2016. \[cited 2020 Mar 17\]. Available from [https://sites.google.com/site/ebookaudit2016/home](https://sites.google.com/site/ebookaudit2016/home).

Grand Valley State University Resolution Agreement OCR Docket #15-16-2195. \[Internet\]. \[2017 March 13\]. Department of Education Office for Civil Rights. \[cited 2020 Mar 17\]. Available from [https://www2.ed.gov/about/offices/list/ocr/docs/investigations/more/15162195-b.pdf](https://www2.ed.gov/about/offices/list/ocr/docs/investigations/more/15162195-b.pdf).

Kumar, KL., and Owston, R. 2016. Evaluating e-learning accessibility by automated and student centered methods. Educational Technology Research and Development 64(2): 263-283.

Library E-Resource Accessibility – Testing \[Internet\]. \[n.d.\] Champaign (IL): Big 10 Academic Alliance. \[cited 2020 Feb 28\]. Available from [https://www.btaa.org/library/accessibility/library-e-resource-accessibility–testing](https://www.btaa.org/library/accessibility/library-e-resource-accessibility--testing)

Mulliken, A. 2019. Eighteen blind library users’ experiences with library websites and search tools in U.S. academic libraries: A qualitative study. College & Research Libraries 80(2): 152-168.

Oswal, SK. 2014. Access to digital library databases in higher education: Design problems and infrastructural gaps. Work. 48:307-317.  
Rysavy, MDT., Michalak, R. 2020. Assessing the Accessibility of Library Tools & Services When You Aren’t an Accessibility Expert: Part 1. Journal of Library Administration 60(1):71-79.  
Tatomir, J., and Durrance, JC. 2010. Overcoming the information gap: Measuring the accessibility of library databases to adaptive technology users. Library Hi Tech, 28(4): 577-594.

United States Department of Education, Office for Civil Rights Region XV. \[Internet\]. \[n.d.\]. Department of Education Office for Civil Rights. \[cited 2020 Mar 17\]. Available from [https://www2.ed.gov/about/offices/list/ocr/docs/investigations/more/15162195-a.pdf](https://www2.ed.gov/about/offices/list/ocr/docs/investigations/more/15162195-a.pdf).

Voluntary Product Accessibility Template (VPAT). \[Internet\]. \[updated April 2018\]. Washington, D.C. Section508.gov. \[cited 2020 Mar 17\]. Available from [https://www.section508.gov/sell/vpat](https://www.section508.gov/sell/vpat).

## About the Authors

Melina Zavala is an early career librarian that graduated from the University of Illinois at Urbana-Champaign in 2018. They are currently working at Grand Valley State University as a Digital Scholarship Librarian.

Matthew Reidsma is the Web Services Librarian at Grand Valley State University and the co-founder and former editor-in-chief of *Weave Journal of Library User Experience*.
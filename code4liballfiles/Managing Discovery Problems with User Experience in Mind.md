---
title: "Managing Discovery Problems with User Experience in Mind"
source: "https://journal.code4lib.org/articles/14481"
author:
  - "[[The Code4Lib Journal]]"
published: 2019-05-07
created: 2025-01-10
description: "Williams Libraries recently developed a system for users to report problems they included while using the library catalog/discovery layer (Primo). Building on a method created by the Orbis Cascade Alliance, we built a Google form that allows users to report problems connecting to full text (or any other issue) and automatically includes the permalink in [...]"
tags:
  - "clippings"
---
# Managing Discovery Problems with User Experience in Mind
Emery Shriver

Williams Libraries recently developed a system for users to report problems they included while using the library catalog/discovery layer (Primo). Building on a method created by the Orbis Cascade Alliance, we built a Google form that allows users to report problems connecting to full text (or any other issue) and automatically includes the permalink in their response. We soon realized that we could improve the user experience by automatically forwarding these reports into our Ask a Librarian email service (LibAnswers) so we could offer alternative solutions while we worked on fixing the initial issue. The article will include an explanation of the process, reactions from public service staff, methods for managing the problems once submitted, and code shared on GitHub for those interested in implementing the tool at their own library.

## Introduction

First, a fairy tale: once upon a time (July 2016), Williams Libraries launched a new ILS and discovery layer. The new system, simply called “the library catalog,” was our first web-scale discovery tool. Its debut heralded the beginning of a new era of streamlined discovery. Users would no longer have to endure the archaic “search here for articles and search here for books” searching method. They could harness the power of the “next-gen” discovery system to search for almost anything, and be seamlessly connected to that perfect, peer-reviewed article that they never knew they always wanted. When the system went live, complete with a “tell us what you think!” link, we expected the glowing reviews to pour in, and then we would all live happily ever after.

OK, that’s the fairy tale version. What actually happened is that feedback came trickling in, and most of the submissions were reports of problems connecting to full-text electronic resources. Although many users were experiencing streamlined discovery and seamless connection, some were instead getting dead links, paywalls, or error messages. As the newly-assigned person responsible for discovery, it was my job to troubleshoot the problems. Working in a library with a culture of timely, user-centered service, it was also my job to respond quickly to users with either a solution to the problem or an alternative method of access (such as interlibrary loan). I also needed a way to triage and distribute the problems reported between myself and staff in other departments, and I had other job responsibilities to juggle. After two years and a few iterations, we now have an efficient e-resources troubleshooting workflow that foregrounds the user experience.

## Version 1.0: Tell Us What You Think

Before the discovery layer, we used a third-party link resolver to connect citations from databases to our full-text holdings. When there were problems connecting to the full-text, library staff reported them to an email address, which was monitored by the systems librarian and the head of collections. The email address was not publicized to users, and only a few problems were reported each month.

After the launch of the new catalog, traffic coming through the “tell us what you think” feedback form, linked in the footer, continued at the same pace. In the first year, we received 70 entries, and 90% of them were from library staff. Anecdotally, however, I was hearing from my public service colleagues that users were having trouble connecting to full-text electronic resources, but they weren’t using the feedback form to report them.

![](https://journal.code4lib.org/media/issue44/Shriver/fig1.png)  
**Figure 1.** Screenshot of the “Tell us what you think” form link.

I did some impromptu usability testing with some of our student employees, and it was clear that they didn’t notice the feedback link, and they also didn’t realize it could be used to report a problem. Moreover, once they landed on the feedback form, there were too many questions, and they needed to go back to the catalog record to get the URL of the problematic item, which was cumbersome. It was likely that users who were using this form were already a bit frustrated, so we needed to make the problem reporting process quicker and easier.

## Version 2.0: Report a Problem

In August 2017, we moved to a new user interface (UI) offered by our discovery vendor. The out-of-the-box (OTB) version of this new UI did not include a footer by default, so we had to move our feedback form link elsewhere. This forced change was also an opportunity: I could use some of the data I had gathered from our student workers to improve the feedback experience on the user side. At the same time, we also needed to update other custom add-ons to be compatible with the new UI, which was built using the AngularJS framework.

While researching what other libraries who had already moved to the new UI had done, I discovered the online Primo Toolkit \[[1](https://journal.code4lib.org/articles/#note1)\] provided by the Orbis Cascade Alliance. In a post called “Add a ‘Report a Problem’ Link in Primo Actions Menu \[[2](https://journal.code4lib.org/articles/#note2)\],” I found my solution to the feedback form dilemma. The post, which was designed for the classic UI, explained how to prepopulate a form with the record’s permalink. Although the Orbis Cascade feedback form was Drupal-based, a quick search of Google’s documentation \[[3](https://journal.code4lib.org/articles/#note3)\] told me how to prefill fields in a Google Form.

### Changes made

Based on the feedback from our student workers, I knew version 2.0 needed to be shorter. In addition, my experience receiving the form responses had made it clear that a form combining access problems with general catalog feedback was confusing and difficult to manage. With some input from our web advisory group, I split the feedback gathering process into two forms: one to gather general feedback about the catalog, and another to report access problems with specific records. I used part of the original “tell us what you think” form for the general feedback form, which is linked from the catalog landing page, and I created a new “report a problem” form based on the Orbis Cascade post.

The new form had four questions:

1. Please tell us what’s happening so we can fix it:
2. Permalink (pre-filled from catalog record)
3. Your email
4. Are you library staff?

I included the last question so I knew the time expectations for getting back to the reporter. We typically try to respond to users from outside of the library within one day. Library staff know that someone is working on the problem, so they don’t expect an answer until it has been resolved. This new form was added to each catalog record, under what our catalog vendor calls the “actions menu.”

![](https://journal.code4lib.org/media/issue44/Shriver/fig2.png)  
**Figure 2.** Screenshot of “Report a Problem” form link.

I added two custom scripts to the Google Sheet that held the form submissions. One forwarded the reported problem to the abovementioned email list, a holdover from our old ILS, which was now monitored by the systems librarian, the head of collections, and the catalog librarian responsible for electronic resources. The second script constructed an email to the problem reporter to let them know when the problem was resolved. Both scripts were triggered manually as part of the triage process. In addition to these semi-automated emails, I was also emailing problem reporters outside of the library at other points: when the problem report was received, if what was reported was user error, and to send them suggestions of what to do to fill their initial need while we were troubleshooting the issue.

### Results

A soft rollout of this service resulted in a dramatic increase in use. In the first 30 days, we received 35 submissions. Over half of the submissions (17/35) were from users outside the library. This was a great problem to have (users were seeing the link and using it) but it was still a problem. The workload increased for those involved in troubleshooting. I felt like I needed to drop everything when a submission came in so I could get back to the problem reporter.

Most interestingly, users’ definition of a “problem” was much broader than before. Students used the form when they couldn’t find a book on the shelf. Faculty used the form to request changes to how their own books were represented in the catalog. I was happy that our users were using this form. After all, all feedback is useful feedback, right? On the other hand, in handling this variety of problems, I was doing a lot more “reference” work than troubleshooting work. I needed a way to make sure that users were being taken care of, but that also freed me up to actually fix the problems.

## Version 2.1: Forwarding to LibAnswers

I examined the new workflow and realized that there were parts of the process that I didn’t need to be involved in. For example, I didn’t need to communicate with the reporters outside the library, thanking them for their submission and offering alternative ways of access. Someone needed to be in contact with them, but that someone didn’t have to be me. Furthermore, we already had a system in place for communicating with users: our Ask a Librarian service, staffed whenever the research help desk is open. Better yet, this system, LibAnswers, had its own email address, and I had already written an email-building script. All I needed to do was make some slight modifications to automate it.

### Changes made

I copied and modified one of the manually triggered email scripts to forward problems to the Ask a Librarian service. Every 15 minutes the script checks to see if any reports have come in from users outside the library since the last time the script ran. If a report has come in, it builds an email and sends it to our LibAnswers queue. The subject of the email is “Catalog Problem Reported,” and the sender is the reporter who submitted the problem. The email includes a description of the issue and a permalink to the problem record. The reference librarian staffing the email queue when the report comes in does a little exploration, such as checking to see if they can recreate the problem, or finding a means of alternative access. They reply to the user with suggested next steps, and log the transaction in Reference Analytics.

### Results

Automating and delegating the user communication part of the triage process was a significant improvement. I spent much less time communicating directly with users, and could focus on fixing the problems. Users received help accomplishing what they set out to do before encountering the problem. The problems that are not related to full-text access could be easily forwarded to other library departments. Finally, because transcripts of the transactions are logged in Reference Analytics (which was shared with all reference librarians and student employees) everyone had a better idea of the types of problems we were encountering, and their possible workarounds.

Examining the daily digest of reference transactions led me to add two additional questions to the form to improve the user experience:

1. Are you on campus or off campus?
2. Have you requested this article through interlibrary loan?

The first question was added to help reference librarians in their initial troubleshooting, when trying to recreate the problem reported. The purpose of the second question was twofold: to remind the user that the interlibrary loan service exists and that they can use it to request articles that they are having problems accessing, and to prevent librarians from offering redundant advice if the user had already used the interlibrary loan service.Seeing the trends in librarian answers to reported problems gave me a different perspective than what I was seeing in the form submissions, enabling me to make these small, iterative changes.

There was, however, still a problem to tackle: the mountain of emails sent and received by me and my troubleshooting colleagues, known as the “e-problems group.” Every time I forwarded a problem from the spreadsheet to the e-problems email list, it went to three people. It wasn’t clear which of the three people were working on the problem, and many times more than one person would start troubleshooting the same issue at the same time. Because of the way I built the email script, every email had the same subject, so it was hard to know which problem was which, especially for those using Gmail conversation mode. It was also hard to share notes among the group about what we had already tried. What we really needed was a more formal ticketing system to assign problems, add notes, and track trends.

## Version 2.2: Further Forwarding to LibAnswers

So far, I had created a reporting system that was quick and easy for people to use, and provided a user experience that fit our prompt and personalized service model. It was time to focus on improving the experience of the staff troubleshooters (myself included) who were struggling to manage the mountain of emails generated by the problem reporting system. Once again, LibAnswers was the solution.

The same email queue system that reference librarians were using to answer email reference queries (and respond to problem reporters) could be used as a ticketing system to organize the problems reported. It would allow us to assign and transfer tickets to individuals based on expertise, make notes about the issue and what we’d already tried so far, and add tags and gather data for analysis of trends.

Implementing this solution was fairly simple on my end. As a Springshare administrator, I added another email queue (at a cost of $100). Each LibAnswers queue has its own email address, so I just needed to change the email address in the version 2.0 script. Since I was still triaging the problems, I didn’t need to set any triggers to automate this script. Staff in the e-problems list had not used the email ticketing system in LibAnswers before, so I met with them to set up the queue and train them on how to use it.

### Results

Moving the management of troubleshooting out of email and into LibAnswers has improved our efficiency. There was a small learning curve for staff not familiar with the system. After using it for a few weeks, we were able to settle on common practices that ensure we’re all using the system in the same way (e.g. when to “close” a ticket or when to leave it as “pending”). During that time, I also made some small adjustments to the email forwarding script so that it was easier to tell one problem from another in the queue. Since it is an internal workflow with only three people involved, we can continue to make small, iterative changes when necessary.

## Future Plans

After more than a year of using the “report a problem” feedback system, we’re generally happy with how the system works: we’re able to respond to users promptly, track problems efficiently, and we’re building a system that lets us keep track of problem trends and solutions. Yet, there’s always room for improvement. My colleagues in research services have suggested that we create some canned responses in LibAnswers so we can provide quick, consistent solutions to frequent problems. Syncing the Google Sheet with the e-problems queue could also be improved. Currently, I’m using the Google Sheet to track problems and generate statistics, since not all problems reported get forwarded to the e-problems group, but that’s not very efficient. Finally, it would be great to start being proactive in our troubleshooting, and set up a testing schedule, so we can try to identify and fix problems before our users encounter them.

## What We Learned

Users are not used to receiving prompt, personalized responses when they use an online form to report a problem. Many of our users are pleasantly surprised when they hear from us right away, and they thank us for the prompt reply. While this may be outside the norm for online support in general, it’s one of many ways we show our users that we appreciate them. When we rely on our users to help us identify problems in our catalog, we need to make it easy for them to do so. By putting them at the center of the troubleshooting process, we can continue to uphold our personalized service ethic, and ensure that users will continue to partner with us to make our catalog the best it can be.

*Emery Shriver* is the Reference and Web Development Librarian at Williams College in Williamstown, Massachusetts. His work resides at the intersection between critical librarianship and user-centered services. He received his MSI from the University of Michigan School of Information. The code can be found on Github at [https://github.com/emery-williams/reportproblem](https://github.com/emery-williams/reportproblem).

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Primo toolkit. 2016-2019. Eugene, OR: Orbis Cascade Alliance; \[accessed 2019 March 8\]. https://www.orbiscascade.org/blog/9/.

\[[2](https://journal.code4lib.org/articles/#ref2)\] Add a “report a problem” link in primo actions menu. 2016. Eugene, OR: Orbis Cascade Alliance; \[accessed 2019 March 8\]. https://www.orbiscascade.org/blog/9/?bid=119.

\[[3](https://journal.code4lib.org/articles/#ref3)\] Send your form to people. Google; \[accessed 2019 March 8\]. https://support.google.com/docs/answer/2839588?hl=en.  
Further Reading
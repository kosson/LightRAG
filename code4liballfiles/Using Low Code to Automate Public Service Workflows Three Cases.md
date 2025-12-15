---
title: "Using Low Code to Automate Public Service Workflows: Three Cases"
source: "https://journal.code4lib.org/articles/16096"
author:
  - "Dianna Morganti"
  - "Jess Williams"
published: 2021-09-22
created: 2025-01-10
description: "Public service librarians without coding experience or technical education may not always be aware of or consider automation to be an option to streamline their regular work tasks, but the new prevalence of enterprise-level low code solutions allows novices to take advantage of technology to make their work more efficient and effective. Low code applications apply a graphic user interface on top of a coding platform to make it easy for novices to leverage automation at work. This paper presents three cases of using low code solutions for automating public service problems using the prevalent Microsoft Power Automate application, available in many library workplaces that use the Microsoft Office ecosystem. From simplifying the communication and scheduling process for instruction classes to connecting our student workers’ hourly floor counts to our administrators’ dashboard of building occupancy, we’ve leveraged simple low code automation in a scalable and replicable manner. Pseudo-code examples provided."
tags:
  - "#workflows"
  - "#public/service"
  - "#cases"
  - "#automation"
---
# Using Low Code to Automate Public Service Workflows: Three Cases
Dianna Morganti, Jess Williams

Public service librarians without coding experience or technical education may not always be aware of or consider automation to be an option to streamline their regular work tasks, but the new prevalence of enterprise-level low code solutions allows novices to take advantage of technology to make their work more efficient and effective. Low code applications apply a graphic user interface on top of a coding platform to make it easy for novices to leverage automation at work. This paper presents three cases of using low code solutions for automating public service problems using the prevalent Microsoft Power Automate application, available in many library workplaces that use the Microsoft Office ecosystem. From simplifying the communication and scheduling process for instruction classes to connecting our student workers’ hourly floor counts to our administrators’ dashboard of building occupancy, we’ve leveraged simple low code automation in a scalable and replicable manner. Pseudo-code examples provided.

## Introduction

### What is low code?

IFTTT, short for “if this, then that”, launched in 2011, and became one of the first major forms of massively accessible low code or automation. They created and crowd-sourced “recipes” (now called “applets”) that allowed users to connect multiple interfaces to create a trigger and a result. For example, to get an email that tells you to bring your plants inside when it’s forecasted to freeze, you would just choose the icon for this applet, and sign into Weather Underground and tell it your location. The applets have matured now to performing multiple actions and integrating more deeply into apps, but ease of use has remained their priority.

Since 2011, a number of similar consumer-level low code apps have emerged, the most famous being Google Home, Apple Homekit, Zapier, and Microsoft’s Power Automate. These platforms have created replicable code with graphical user interfaces to make it easy to point, click, and leverage automation to make life or work easier. Programmers work behind the scenes creating these low code solutions for consumer use. Someone has already written an applet so that consumers can use their phone’s GPS to trigger their home’s porch lights and air conditioners to all turn on when they pull into their driveway–users just need to click a few buttons and give permission to get it working across all their devices.

Low code is the use of a graphical user interface to take pre-written code and make it easy to use for just about anyone to leverage automation. The smart home market isn’t the only place low code has transformed our lives; the business world may have seen even more benefits than the home market.

The low code solutions presented in the three cases below all leverage Microsoft Power Automate. Power Automate (formerly known as “Flow” and found at flow.microsoft.com) is a low code way to link Microsoft products and other products and apps. It is intended for business solutions such as sending customized emails to customers based on their responses to a survey, or going through an approval workflow when a new document is uploaded to a specific folder on SharePoint. The example cases given below demonstrate how the team’s knowledge of the platform grew and we iterated over time.

## Problem: Mask Mandate Enforcement

Although the Texas State University’s main library building never closed during the COVID-19 pandemic, the students had been sent home from their campus residences in Spring 2020 and all classes moved online, which meant that the library had a very low floor count for the remainder of that semester. The University allowed students to return to campus in Fall 2020, and the library anticipated a great increase in foot traffic as a result. We had state-wide, local, and campus mask mandates as well as occupancy requirements for social distancing, and as stewards of a public building we needed a way to enforce those for our seven-story heart of campus.

We explored some turn key solutions such as body heat occupancy monitors or all seats and spaces requiring student reservation, but ultimately the infrastructure (needed outlets and data drops for monitors or for reservation kiosks) didn’t exist yet and could not be implemented in a timely enough manner to make these a good solution. We also anticipated that mask compliance would be a greater issue than occupancy, and no turn key solution existed for that. Peers who had also remained open shared some good practices such as constantly surveilling for mask compliance on each floor, but this solution wouldn’t work for us. We needed another solution.

### Constraints

The top constraint surrounding a solution to this problem was time. We couldn’t take the time to find the best solution, because the students would be returning in fall. However, we began this work during the summer and so we had a little time to experiment.\`

We started with an assessment of the resources we had at hand. We had the Microsoft environment, student workers, and staff with safety at top of mind. We also had our own time (that is, the authors’) – we aren’t afraid to tinker with technology, but we also aren’t “coders”.

We knew we could start with student workers doing hourly floor counts and checks for mask compliance, but we didn’t want to put the onus of enforcement for either concern onto student workers. So we needed some mechanism to communicate their information to managers who would do that work. Student workers used a paper data collection form, a clipboard, and a handheld tally counter while walking the floors then transposed the data into a Microsoft Form when they returned to their work station.

Our first deployment of a low-code solution used Microsoft Power BI, which can automatically retrieve the information from the Excel spreadsheet generated by the Microsoft Form. This initial solution involved teaching all the managers how to sign in to Power BI, set up alerts for when they needed to respond, and teach them how to get those alerts on their mobile devices. There were many opportunities for user error in this system.

One of our administrators suggested creating a Team in Microsoft Teams for the enforcing staff to all receive the same alert from Power BI using a flow in Power Automate, and from there we began exploring Microsoft Power Automate. In this version 1.1 of our workflow, we only used Power Automate to take the alerts from Power BI and send them to the team. But in exploring the template Flows we were quickly able to envision a whole new automation that was much more efficient. The newly discovered template Flows in Power Automate allowed us to remove Power BI from the workflow, which was a positive thing as Power BI created a delay in response. We retained the Power BI Dashboard to view the data, but it was separate from the response automations so that they could be done swiftly. This brought us to the 2.0 version of our workflow which we present here.

### Solution (in workflow chronology)

While we worked to iteratively improve the process over time, we can present the final product here. We ceased use of this process in May 2021, when the mask mandates were lifted by our state governor. Find the workflow below listed roughly, with more detailed pseudocode demonstrating the low code process in Power Automate below.

1. A student worker conducts an hourly floor walk and gathers data on occupancy, mask noncompliance, and any additional notes.
1. A chart assists them with determining whether the floor is in “Red”, “Yellow”, or “Green” based on predetermined cautionary levels of both mask compliance and occupancy (a proxy for social distancing)
2. They update the Alkek Library’s entry-way Floor Status chart that assists customers in making a decision about the safest place to study
3. They enter the data into Microsoft Forms. \[Student worker is done\]
1. Power BI pulls the Microsoft Forms data to update a live dataset and dashboard of floor counts for library decision-makers to study trends and respond to concerns
1. Power BI also publishes to a web page summarizing the previous 7 days’ statuses to allow customers to make informed study space decisions
2. Microsoft Power Automate has a flow that detects every Form entry and compares against criteria for concern
1. If a floor meets a threshold for concern, an alert is sent to the “COVID-19 Response Team” in Microsoft Teams.
2. Response Team members communicate amongst each other in the discussion thread to determine who will respond.
1. If Response Team members expel a customer for mask noncompliance, they fill out another Microsoft Form.
1. The PowerBI dashboard that tracks data and trends also pulls data from this form to track expulsions.
2. LibStaffer (a scheduling tool from the Springshare company) creates a transparent schedule of who is responding to alerts from the Floor Counts.
1. LibStaffer updates a live schedule on an internal webpage so that student workers can see and contact responders about any concerns they observe
1. This webpage also has complementary information such as links to the counting form, suggested scripts for giving warnings (optional for student workers), phone numbers for supervisors, and more.
3. LibChat has an SMS text phone number for customer complaints about mask violation or other safety concerns, which come in almost daily. A few of us monitor this and alert enforcement staff via Teams to respond.

For the Microsoft Power Automate section of the workflow, we started with a blank flow and used the “Automated Cloud Flow” option. This means we wanted an automation triggered by an event (as opposed to an automation where we pushed a button to trigger it). For this automation the tasks are triggered by the submission of new form entries (the floor counts students entered). We used a template for sending a Teams message when a new Form response comes in, but made it so that it only takes action when certain conditions are met (that is, the occupancy or mask compliance are at cautionary levels).

1. “When a new response is submitted” is the template for triggering a flow from a Form entry. The creator will then choose the form from the drop-down list of all their Office 365 forms.
2. “Get Response Details” is a necessary template for gathering the data from the Form entry.
3. “Condition”:
1. If the “Floor” was “1st”, AND:
1. If the “Occupancy” was more than A
2. OR If the “Mask noncompliance” was more than B
2. OR If the “Floor was “2nd”, AND:
1. If the “Occupancy” was more than C
2. OR If the “Mask noncompliance” was more than D
3. OR If the “Floor was “3rd”, AND:
1. If the “Occupancy” was more than E
2. OR If the “Mask noncompliance” was more than F
4. OR If the “Floor was “4th”, AND:
1. If the “Occupancy” was more than G
2. OR If the “Mask noncompliance” was more than H
5. OR If the “Floor was “5th”, AND:
1. If the “Occupancy” was more than I
2. OR If the “Mask noncompliance” was more than J
6. OR If the “Floor was “6th”, AND:
1. If the “Occupancy” was more than K
2. OR If the “Mask noncompliance” was more than L
7. OR If the “Floor was “7th”, AND:
1. If the “Occupancy” was more than M
2. OR If the “Mask noncompliance” was more than N
8. If YES: “Post a message in Teams” is the template to do so, and since we got all the response details in Step 2, we can include all the Form data. The message template supports basic HTML so I was also able to add a link to report any expulsions to another form.
9. If NO: Do nothing.

## Problem: Instruction Scheduling, First Year Writing Classes

In pre-COVID times instruction for the university’s first year writing classes, particularly English 1320, was executed through a high number (around 125 ) of one-shot sessions. In academic year 2020-2021, the instructional content was moved to a self-paced tutorial accessible through the campus LMS, Canvas. However, many of the English instructors still requested synchronous library instruction though Zoom. Around the same time, the department primarily responsible for teaching these lower-division undergraduate courses lost team members and was left with one librarian and a handful of volunteer librarians from another department. To meet the instructional need, the library created a pseudo-flipped classroom model: instructors were given the option to schedule a question and answer session with a librarian on Zoom after their students had completed the online tutorial content.

For assessment purposes, we needed to know two sets of information: 1) which instructors were assigning the online tutorial only and 2) which instructors also wanted a live Q&A session. The latter set required more details for coordination and scheduling; we also wanted a system to help ensure that the students were completing the online tutorial before the live session. This automation was the solution to these needs.

### Constraints

The group of volunteer librarians came from three different departments in the library, though they were also all part of a functional library instruction team. This team had been working collaboratively using an existing Microsoft SharePoint site and Teams since spring 2020 and the start of the COVID-19 pandemic. Continuing use of Microsoft products made the most sense organizationally; it also limited some functionality, particularly with the MS Planner components. Further automation could have been added to overcome these limitations, however we also knew that this entire process itself was temporary and would be replaced by a new instruction model by the next semester.

While MS Forms, Power Automate, and Planner were used in this scenario, other options are also viable. Google Forms, Zapier, and Trello is another powerful combination, in particular because Trello now has utilizes built-in automation through Butler.

An additional constraint of this solution is that it existed outside of the library’s system for collecting instruction statistics, Springshare’s LibInsight, which is not interoperable with Microsoft. Logging the data was a manual process but also the inspiration for the following use case and iteration.

### Solution (in workflow chronology)

In fall 2021, the instruction model for first year writing classes will change and no longer require instructors to request or schedule a session. A more sophisticated iteration of this use case is presented below. The temporary nature of this workflow meant that we made the conscious decision not to tweak or improve certain aspects; suggestions for improvement are included at the end of this use case for the benefit of the reader. Many MS Planner features like Progress Status, Priority, and Labels were not used here but have the potential to greatly improve the user experience for the librarians.

#### Data Collection Using Branching in MS Forms

The foundation for this automation is a Microsoft Form that utilizes branching. Every instructor filled out sections 1 and 2 but only instructors requesting a live session were moved to section 3. Instructors were asked to fill out one form per class section.

***Section 1***  
Questions

1. Course Section Number (text)
2. Name (text)
3. Email (text)
4. Number of Students (number)
5. Due Date for Library Tutorial (date)
6. Do you need help embedding the Library Guide (with tutorial) into your Canvas Course? (Y/N)
7. Would you like to receive assessment results for your students? (Y/N)

***Section 2***  
Instruction Options (this was included as a text block before the next set of questions)  
The interactive tutorial provides students instruction on the following:

- How to use the Library website, Databases, Catalog, and Research Guides
- How to chat with a Librarian & schedule a Research Consultation
- An overview of the Research Process
- Choosing a topic, core concepts, and keywords
- Background research + Library vs. Google
- Search Strategies (creating queries, Boolean operators, troubleshooting)
- Source Types
- Interpreting search results page and refining the search query
- Citations
- Evaluating Sources

Questions

8. Would you like to schedule a Live Zoom Session for your class? (Y/N)

1. This session can be used to address student questions and research topics, with the librarian acting as a coach and guide; this time may also be used for the librarian to introduce content not covered in the tutorial. Please make sure your students come prepared to this session for best results.

Branching note: If NO, instructors were taken directly to Section 4. If YES, the instructor was taken to Section 3.

***Section 3***  
Schedule a Live Zoom Session

9. Class Time (text)
10. First Choice Date (date)
11. Second Choice Date (date)
12. How will your students prepare for the live session? (short answer)
1. Ex: by adding questions for the librarian on a Discussion Board beforehand
13. Additional Comments (long answer)
1. Include any special topics you’d like covered or assignment details that would help your librarian prepare.

***Section 4***  
Complete!

14. Any questions?

Submit

#### Using MS Power Automate to Create Cards on MS Planner Board

All librarians available to teach the live Zoom sessions were already members of the Library Instruction Group SharePoint site/Teams group. To integrate this workflow into the existing structure, we created a MS Planner board with the Teams app. The primary purpose of the Power Automate Flow was to create one card from each MS Form submission/class section and then to display the data from the Form in an easily available and readable format on that card.

Workflow Overview

MS Form: Submission  
?  
MS Planner: Create a Task  
?  
Delay (5 sec)  
?  
MS Planner: Update Task Details  
?  
Send Success Email ?? Send Failure Email

Workflow Details

1. Trigger: When a new response is submitted to MS Forms
2. Action: Create a task in MS Planner
1. Plan ID selected from Library Instruction Planner Board
2. Title generated from dynamic content from two submission fields:
1. \[section number\] \[name\]
2. Display example: 1320.255 Juan Doe
3. Five second delay
4. Action: Update Task Details in MS Planner
1. Pulling dynamic content from the Form submission into the description field on the card:

![](https://journal.code4lib.org/media/issue52/morganti/morganti_figure_1.png)  
**Figure 1.** Dynamic content from the Form submission added to the description field.

2. Action: Using Notification Operation, send email
1. Send Failure Email (ensures the user doesn’t miss a request if the automation fails for any reason)
2. Send Success Email with dynamic content from the newly created Planner task:

![](https://journal.code4lib.org/media/issue52/morganti/morganti_figure_2.png)  
**Figure 2.** Dynamic email in Planner.

#### Completing Workflow from MS Planner Board

Once cards were created in the Incoming Requests bucket, they moved from left to right across the board, creating a highly visual workflow. The buckets were:

**Table 1.** Incoming Requests bucket workflow.

| Incoming Requests | Scheduled & Assigned | Needs Assessment Results Sent | Needs Added to LibInsight | Closed |
| --- | --- | --- | --- | --- |

A few weeks into the semester, the group of librarians met to learn the workflow and divvy up class sessions. One librarian was assigned to each card representing a session, and then that card was moved to the *Schedules & Assigned* bucket. Due dates were set in order to trigger email reminders, which MS Planner does by default. A checklist was added to each card to include: 1) Email course instructor 2) Confirm live session & Zoom link 3) Do the class. This workflow transparency helped the home department librarian keep track of each session and to ensure that requests were met.

For courses not requesting a live session, those cards were moved directly to the *Needs Assessment Results Sent* bucket; live session course cards were also moved into this bucket by the assigned librarian at the conclusion of that session. Due dates were added to each card, and either the home department librarian or an admin assistant would download and email assessment results to the instructor. These same individuals would move the cards though the next bucket and to completion.

#### Suggestions for Improvement

Again, because of the temporary nature of this particular workflow, the author noted several areas for automation and improvement but opted to not to employ them for the sake of time. If using MS Planner again, the author recommends:

- Utilizing MS Planner features like Progress Status, Priority, and Labels. These have the potential to greatly improve the user experience for the librarians.
- Use MS Power Automate to populate a predetermined checklist, on the “Update Task Details” action since MS Planner does not have the option to copy and paste a checklist.
- Automate the process of statistics and record keeping (see below for how we did that in the second iteration of this workflow).

## Problem: Instruction Scheduling Scaling Up

We faced a problem many of you faced most likely in 2020: we continued losing staff at at least the normal pace (if not a higher pace due to stress/anxiety around the pandemic), but we were in a long-term hiring freeze that prevented us from replacing staff we lost. Specifically we lost all the staff who had provided the administrative and logistical support behind our instruction scheduling workflow.

In the past, when a course instructor wanted a librarian visit, they went to our website and filled out a LibInsight form. This form created an initial ‘shell’ record in LibInsight and emailed an alert to our admin staff. The admin staff compared it to the subject librarian list and sent it out to the right librarian. That librarian, after they taught the class, would complete that shell record in LibInsight with the statistics of duration, attendees, etc, and they would also send the faculty member a survey asking for feedback. We lost all the admin staff who had supported this process, and although other library staff could have stepped in to replace them, we were also doing that for many other jobs and responsibilities in the library. In order to show support for the staff workload and attempt to reduce some of the tasks that could contribute to the feeling of always needing to ‘do more with less’, we wanted to use some automation to reduce the administrative support necessary for this process.

The scheduling described in the previous case gave us the idea of how we could scale up, and our model of starting the initial shell of a statistical record at the point when a faculty member submitted a request was a great one. That model allowed for a little bit of accountability in ensuring all our classes were recorded and accounted for at the end of each semester. A bit of reading and tinkering in Power Automate showed us that we could use SharePoint lists to replicate that part of the process, and we could use a series of if/then conditions to help send requests to the right librarians.

We didn’t want to totally replicate the data collection form we had in the past – it was an onerous form that had been added onto over time to the point of being something everyone dreaded about teaching. So we started from scratch in determining what to ask faculty and what to ask librarians about the library instruction classes, tours, and workshops. We began by gathering every data point we needed to report out on to our various stakeholders and reporting agencies and classifying them according to whether they are necessary, are optional but useful, and which are optional and not used. With this study we were able to cut a significant amount of fields from the form, streamlining the process before automation.

**Table 2.** Fields Evaluated for Need.

| Necessary | Optional and Useful | Optional and Not Used |
| --- | --- | --- |
| Date and time | Room Number | Was Librarian embedded in LMS? |
| Number of students anticipated | Desc of Assignment | Month of Instruction |
| Time (for synchronous classes) | 2nd choice date | Department of class |
| Synchronous/Asynchronous delivery | Number of students anticipated | Librarian requested (not used since we send request to the assigned librarian no matter what they chose) |
| Number of students attended | Assessment score (compiled elsewhere) | Prep time |
| Course name and number |  | Course LibGuide |
| Campus |  | Course level (duplicated in course number) |

We went through two full testing environments consisting of a unique instructor form for requesting a class, a SharePoint site for managing/recording class information, and Flows to connect those and alert librarians. A small group of librarians helped test the automation over the course of about 6 months before we presented a fresh test environment to the entire group of 20+ librarians for full testing.

### Constraints

In the ENG 1320 example above, the librarians were a small controlled set of people. It is easier to train 5 people to use a new platform (like Teams and Planner, utilized in that system) than the 20+ we’d need to train for this scaled up approach, so we prioritized using tools that the staff already knew well (email and forms and to a lesser extent SharePoint). When I had to convert some tasks to SharePoint, I focused on ease of use, since we weren’t a heavy SharePoint-using group. I moved any fields they had to interact with in SharePoint to the center of the page to catch their eye, and I hid all the fields they didn’t need to interact with. I used the SharePoint PowerApps Forms service to simplify the form in case any librarians preferred entering their data later. Again, I hid the fields they didn’t need to input – for example, we ask faculty instructors to give us a 2nd choice date, but the librarians entering data later won’t even see that field.

Resources and time were a constraint in that we wanted to use only pre-approved software and environments for interacting with class information to limit the need for going to IT Security to approve any new tools. Using Google or Qualtrics, for example, would have given a lot more customization options for a Form, but they aren’t pre-approved for this type of use on our campus. While I’m familiar with the process of getting software approved, I also knew my timeline was a constraint as well. While time was a flexible constraint, since this was an improvement project where the existing solution worked just fine, I wanted to work on a deployment of a new solution by the next academic year. Going through IT security processes to approve new software is a seemingly unpredictable timeline, so I chose to be limited, then, to the options available in our pre-approved tools for this type of data on campus.

Lastly, we constrained the project to those apps for which Microsoft Power Automate has pre-built Flow templates (that is, it needed to be “low code”). While we may be confident enough to tinker around with simple code, this process needs to be sustainable. Building it entirely using pre-built templates in a low code environment means there are FAQs and tutorials online for how to use each component, and the entry level for the technology is lower.

### Solution (in workflow chronology)

The process starts with the template automation trigger for when a new response is made in a Microsoft Form. I then used the “Conditions” to compare form entry data about what class it is to the librarians’ responsibilities to figure out who it should go to. Then I used templates for “Send an email” and “Add to sharepoint list” to get the data to the right people and record that request in the statistical dataset.

The Microsoft Form that serves as the trigger uses branching to ask questions based on previous answers. The first relevant question for the logic is asking what campus, then college, the faculty requesting instruction is in. From there, if needed, it will ask the department. If the faculty is from the Round Rock Campus, though, the questions are moot since all those requests go to the same place; we don’t make the faculty fill out extraneous information. Similarly once we get to date/time/location, if they’ve chosen an asynchronous format, we only ask what date they’d like it available – not time and location.

When the triggering event occurs (someone fills out the form), the flow built in Microsoft Power Automate will:

1. Check if Subject equals A or B or C
1. If yes: then fill out the stats instance – add librarian ABC to field “Librarian”
1. And: Email librarian and faculty with details
2. And: Stop.
2. If no: Nothing. It will move to the next condition.
2. Checks if Subject equals X or Y or Z
1. Copy of above, with next subject librarian….
3. Copy as needed for each librarian (we have 16 conditions – 15 individuals and 1 campus that didn’t want their requests sent to individuals)
4. With the final librarian, it starts the same. Check if subject equals AA, BB, or CC
1. If yes: then fill out the stats instance – add librarian AABBCC to field “Librarian”
1. And: Email librarian and faculty with details
2. And: Stop.
2. If no: Still fill out the stats instance – leave librarian blank
1. And: Send an email to a manager that says “CLASS NOT ASSIGNED!!” (Human intervention required to get this to a librarian to teach it)
2. And: Stop.

We have thought of a few enhancements, and we’ll think of a few more, I’m sure. Two likely enhancements are:

- That the process launch a calendar invitation for the preferred class date, booking the librarian and the classroom
- To have Microsoft Power Automate send a follow-up satisfaction survey to the instructor after the class date. We will likely implement this before the first semester.

## Problem: Consultation request automation

Our final case is one that is not yet solved. We believe it is important and valuable to share the entire learning process, even those cases that are failures (or possibly just stuck in a failure stage on the way to success). While it was easy to envision a solution for faculty class instruction requests, it was harder to do so for consultation requests which can come from faculty, students, and even sometimes other staff. Students, in particular, usually don’t know the colleges and departments their classes belong to, and the automated assignment to the right librarian depends on faculty knowing that information for their classes. An envisioned solution that we haven’t yet implemented might be to assign based on course prefixes instead, but that becomes more difficult when one also wants to accommodate faculty, staff, public, and non-academic student requests for research consultations also with the same form.

## Conclusion

### Automation Inspiration

Knowing where to start is often the most difficult part of any endeavor, and the same can be true for workflow automation in service roles. Here are some questions to spark inspiration:

- Is there a repetitive task that you or your team dislikes doing? Explore if it can be automated.
- Do you have a workflow with a human bottleneck? Investigate how you can employ conditions or branching to improve efficiency.
- Do you have a process that consumes a lot of staff time? Find a tool that manages it and then use low code automation to connect it to your existing tools or structures. This could look like:
- Use a scheduling tool to automate research consultation booking and syncs with MS Outlook or Google Calendar.
- Automate checklists or daily tasks for student workers using a recurring duplication recipe.
- Refresh your knowledge of the current tools and products you use for ways to connect them. Browse your automation tool of choice for suggested workflows based on the tool.

### How do you know if your process can be automatable?

In each of the cases presented here, we are providing examples where information is moved from one place to another. In the case of the floor counts, student workers count the number of occupants and mask noncompliance on each floor hourly. For both of our class instruction requests, as well as the envisioned consultation requests, the information consists of customer data. In all of those cases, a judgment needs to be made as to where to send the data, but that judgment isn’t reliant on human intuition or creativity – it’s enough to check pieces of the data against some criteria to determine where to send it. So what we have are the input, the automation which may have some criteria and conditions, and an output.

Our primary constraint of sticking with the environment and technologies that were already approved to handle our data was what determined that we use the Microsoft ecosystem. If your ecosystem is Google or is more open for your use case, then there is a wide variety of tools out there you can explore. Any time you are plugging in a new app or tool, though, be sure to check that it meets your information security requirements for the type of data you’ll be using.

For even the use cases we’ve presented, we can envision other scenarios involving:

- Input Sources
- MS Forms
- Google Forms
- Qualtrics
- Survey Monkey
- MS Bookings
- Automation Tools
- MS Power Automate
- IFTTT
- Zapier
- Means of Output
- Email/Calendar event
- Row in Excel spreadsheet or MS List
- Power BI Dashboard or Data Visualization/Report

Low code automation is often overlooked in public services, but taking the time to set up a system once saves an exponential amount of time in the long-term. In times of staffing shortages, when remaining staff are at their wits’ end of ‘doing more with less’, some automation inserted into the workflows of everyday life can help them feel supported and relieved. The possibilities for automating tasks and procedures continues to increase as the interoperability of software and applications becomes more common; public services departments in academic libraries should continue to explore these solutions in order to free up more time for their employees to provide services and produce scholarship.

Dianna Morganti (she/her) is the interim head of Research, Instruction, and Outreach for the Texas State University Libraries. She enjoys tinkering with technology and finding solutions to make work easier for the team. She’s also a project manager, a STEM librarian, and a collector of hobbies.

Jess Williams (she/her/ella) is the Head of Information & Undergraduate Services at Texas State University Libraries. She has loved crafting efficient systems for her team ever since her teenage gig managing a snow cone stand. She is passionate about student success, organizational culture, and creating spaces that facilitate authenticity and self-expression.
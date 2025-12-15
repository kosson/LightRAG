---
title: "Using Zapier with Trello for Electronic Resources Troubleshooting Workflow"
source: "https://journal.code4lib.org/articles/10034"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-10-21
created: 2025-01-10
description: "Troubleshooting access problems is an important part of the electronic resources management workflow. This article discusses an opportunity to streamline and track troubleshooting using two web-based services: Trello and Zapier."
tags:
  - "clippings"
---
# Using Zapier with Trello for Electronic Resources Troubleshooting Workflow
Meghan Finch

Troubleshooting access problems is an important part of the electronic resources management workflow. This article discusses an opportunity to streamline and track troubleshooting using two web-based services: Trello and Zapier.

After being hired as the Digital Assets Librarian at Oakland University, one of the first tasks I accepted was to tame the troubleshooting of access errors for our electronic resources. During my first year I received comments from our users regarding our resources through a newly set up online form and mailing list. Data for an annual report was manually compiled from reviewing the emails stored in a labeled email folder, which indicated only the number of emails received each month and then the total for the year.

The troubleshooting tasks became overwhelming for one individual to manage and I began to look to other staff to help resolve problems and respond to patrons. I wanted to make training as easy as possible and have a simple way to provide help and feedback without hovering. Additionally, I was receiving a lot of information about the state of our electronic resources and where our problems might be, but I wasn’t easily able to sort and visualize any of this data.

I began to investigate opportunities to:

- Allow several team members from acquisitions, as well as myself, to coordinate efforts to resolve and respond to issues
- Track the types of problems encountered to help determine where it might be worth making efforts to improve the system or when certain vendors may be more problematic than others
- Visualize that information to see how much work was being done and in what areas

In considering options, I looked at both the existing bug tracking system at Oakland University, [BMC Footprints](http://www.bmc.com/it-solutions/brands/numara-software.html), as well as the potential for an electronic resource management system (ERM) to help manage these tasks.

BMC Footprints was first considered as an option for tracking reported e-resources issues. Footprints was already in place at the university and used primarily by central IT to track projects, routine tasks, and issue resolution. Footprints offered the ability to receive issues via email and an extensive hierarchy with which to assign responsibilities. However, the user interface for both the internal troubleshooters and patrons was too complex for the task. Rather than making training easier, this looked likely to cause more confusion.

Having eliminated the existing bug tracking system from consideration, the next option was an ERM. In winter of 2014 OU Libraries investigated ERMs from Ex Libris, Serial Solutions, and EBSCONet, but none had any features related to an error tracking workflow.

## Trying Out Trello

Following the previous failed investigations, I then considered Trello as an option for managing the workflow.

[Trello](https://www.trello.com/) is a workflow, task management, and project management tool. The service provides a web-based workspace for building bulletin boards for project task management. Users create cards, modeled on index cards, which are organized on lists typically titled with a relevant category. The default list types populated when a new board is created are “to do,” “doing,” and “done,” though the user can add, delete, and edit lists on each board. Trello provides a simple and flexible to do list or allows the user to design elaborate workflows with added features such as color-coded labels, comments, checklists, due dates, and attachments. These options are included in the freely-available version of Trello, with additional features, such as stickers, background customization, and csv exports available in their gold and business class paid versions.

Other academic libraries have begun to experiment with using Trello in their workflows. A 2013 presentation at the annual Electronic Resources and Libraries conference by [Nancy Beals and Jennifer Bazeley demonstrated Trello use in an electronic resources workflow](http://www.slideshare.net/libjennifer/e-resources-ereality-slidshare-18055793).

Trello was already being used by acquisitions and cataloging staff at OU Libraries as a way to track projects in each department before it was considered for e-resources management. All technical services staff had accounts with Trello and were familiar with the mechanics of card creation, notes, and moving notes to different lists. This familiarity with and acceptance of the tool made it an appealing option for working with electronic resource error resolution and tracking.

## Incorporating Zapier

The next step was to investigate what options were available for automatically generating Trello cards without the library patrons needing Trello accounts. The online form was already in place and working well, so effort focused on incorporating Trello into this reporting mechanism.

Oakland University uses Google as its institutional email provider. Both Google apps and Trello have documented APIs that would allow the two applications to work together, making communication from OU email and Trello an option.

New tools designed to enable users to communicate between web services without extensive technical knowledge have recently developed, including [IFTTT](https://ifttt.com/) (If This Then That) and [Zapier](https://zapier.com/). These web services allow users to use simple if-then statements to allow changes in one web application to result in actions taken in another web application. IFTTT refers to these statements as recipes, while Zapier calls them “zaps.”

Both IFTTT and Zapier have free-to-use versions and offer the ability to connect many popular online services. IFTTT was not considered for use with this project, however, because it does not support Trello integration. Zapier’s support for Trello and Google Docs integration led me to select it for use in this project.

## From Form to Trello card

The form available to patrons for reporting errors is available from the OU Libraries website in two locations. Buttons are available on the Serial Solutions 360 Link open URL linking service as well as each page of the Databases A-Z list. The majority of errors reported originate from the Serial Solutions 360 Link page. Patrons encounter this page during an error regardless of whether they are coming from our Summon discovery service or from any of our subscribed databases using 360 Link to connect users. The button takes the patron to a simple web form. The form has no required fields, and asks the patron to provide their email, the name of the resource, and a description of the problem. In the background, the form also gathers the URL where the “report an error” button was selected. This helps to provide additional information when a patron is vague or doesn’t provide enough information to get started on troubleshooting.

Once the form is submitted, it is sent to the email address of the e-resources mailing list.

### Email + Zapier + Trello

The Zapier zap was set up to look for any email sent to the Digital Assets Librarian from the address of the listserv. Once identified, the information in the email is sent to Trello creating a new card on the “To Do” list in the Electronic Resources Troubleshooting board.

### Google to Zapier Mapping

The Zapier zap is designed to take fields from a Google email and crosswalk that information to a field representing a feature in a Trello card, as shown in Table 1. For our troubleshooting emails, the subject and the email body are the only information items mapped to the Trello card.

| Google Mail Field | Trello Card |
| --- | --- |
| (Email) Subject | Name |
| Message (email body) | Description |

**Table 1:** Mapping fields to Zapier cards

Additionally, the following settings for a Trello card are set automatically by Zapier (Table 2):

| Trello card setting | Trello card value |
| --- | --- |
| List | To Do |
| Label | None |
| Member | (any member of the team, rotates weekly) |
| Due Date | Tomorrow at midnight |
| Checklist name | E-resources Troubleshooting Tier I |

**Table 2:** Fields automatically set in Trello cards

Beyond creating cards from email information, several other presets are available. A predefined checklist stored in Zapier is attached to each card to help troubleshooters get started reviewing a problem. This checklist includes questions such as:

- Are you able to view the resource on-campus?
- Do you receive a proxy error message page?

This checklist is created in Zapier and attached to each new card that is generated for the Trello board.

I update the Zapier zap each week with a different member of the team assigned to the Trello board. When a card is created, it is automatically assigned to that user for the week and that user is notified when a new Trello card is created via Trello’s notification system. Each user can select settings to be alerted by email or just by the Trello internal notification alerts.

## Keeping Everything in the Same Place

The Electronic resources troubleshooting Trello board was set up with seven lists:

1. To Do
2. Tier II
3. Waiting
4. Completed
5. Get Done
6. How To
7. Honey Badger Tips

### Workflow Lists: To Do, Tier II, Waiting, and Done

The primary workflow lists are the “To Do,” “Tier II,” “Waiting,” and “Done” lists. Cards typically move from “To Do” to “Done,” unless a problem requires more complex troubleshooting or a response from a third-party such as a vendor or service provider. Cards with more complex needs are moved to “Tier II” where they are addressed by the Digital Assets Librarian, while cards waiting on a third-party response are moved to “Waiting.” (See figure 1)

![](https://journal.code4lib.org/media/issue26/finch/finch--trello--figure1.png)

**Figure 1.** Troubleshooting workflow

### Information Lists: Get Done, How to, and Honey Badger Tips

Many different variables are considered when troubleshooting e-resources. A troubleshooter may need to check proxy settings internally, email the knowledge base provider, or contact the support staff of a content provider for a problem that is reported. It was important to provide access to as much of this information as possible from within the Trello board to minimize the need to hunt for outside information. The “Get Done” board helps to provide that information, listing important email addresses and technical support contact forms.

The “How To” board provides the instructions for using the e-resources troubleshooting Trello board. Keeping documentation within the board provides quick access available within the environment, allows for easy updates, and connects easily with Google docs for more complex documentation.

When first approached to take on the task of working with e-resources, I asked the acquisitions team if they wanted a mascot to represent the group. They already had a mascot selected: the internet famous honey badger. The board is sprinkled with images of honey badgers to keep spirits up, and the “Honey Badger Tips” board offers simple reminders on common customer service style responses and expectations. This includes example emails to help troubleshooters respond in a consistent way to patrons and reminders to stay away from internal jargon.

## Tracking Error Types

Beyond resolving access problems, I was also interested in spotting trends in errors. This is where Trello’s label system became useful.

Reviewing emails prior to Trello implementation, I identified major areas of error:

- User errors
- Errors originating with the discovery layer, knowledge base, or open URL linker (all Serial Solutions in our case)
- Errors originating with the resource provider (database or publisher)
- Proxy errors
- Problems associated with renewals (money not received in time, access removed even after paid in full, etc.)

Each of these error types was assigned to a Trello label. Once resolved, the troubleshooter adds the appropriate label to the card and then moves it to the “Done” board. Trello allows for multiple labels to be added to a single card, so we can add as many labels as necessary

## Tracking in Google Docs

Completed cards can be viewed in Trello even after they have been archived; however, it can be difficult to get a sense of the number of problems reported at different intervals and the types of problems being reported. To really understand this better, we needed to export the data from Trello.

Zapier was again used to send the data from Trello to a Google spreadsheet. Zapier was able to export:

- Card name
- Date of last activity
- Labels
- ID Members (who was assigned to the card)

Each element was entered into their assigned column in a new row of the spreadsheet. Once in a sortable Google spreadsheet, information became much easier to read and quantify.

## Visualizing Data in Google Spreadsheets

Once the data is out of Trello and into a spreadsheet, more can be done to sort and view it. Errors can be sorted by date and type of error, and values such as the number of errors each month, the type of each kind of error, and the average time it takes to resolve an error can be quantified and visualized to present to colleagues and stakeholders. This information can help better inform decision-making related to electronic resource acquisition, renewal, and management.

The example in figure 2 shows the type of graph that can be created from pivot tables of data exported from Trello. This shows the distribution by month of the 50 recorded e-resources errors reported since Trello’s implementation in March 2014. The colors are coded to correspond to the color of the labels in Trello and show the distribution of the types of errors reported.

![](https://journal.code4lib.org/media/issue26/finch/finch--trello--figure2.png)

**Figure 2.** Example graph of issue data

## Future Opportunities for OU Libraries and Trello

### Trello and Google API

Zapier zaps demonstrate that Google and Zapier work together to exchange data. Trello’s drawback, however, is a limited number of fields in which values from an outside source, such as Google, can be stored. A lot of information that could be more useful if sorted is lumped together in the “description” field of each Trello card. Working with the Google and Trello APIs directly rather than through the Zapier intermediary, it may be possible to parse information from this single field to be more useful in the final Google spreadsheet.

### Beyond the Troubleshooting Workflow

We are beginning to expand our use of Trello beyond just the troubleshooting workflow. OU Libraries have just created a board dedicated to short-term loan and purchases from our DDA program and are directing all email correspondence to this new Trello board. Trello gives us the ability to take a task that was previously only tracked via email to a dashboard that can be viewed by all team members and from which data can be gathered quickly. We will likely be exporting data from these boards as well, and the possibility of building an internal dashboard with this information is possible.

Some work performed by Zapier, including the export of data, can be handled by Trello with a Business Class subscription. While the free work-around is useful for OU Libraries currently, it may be worth the investment to move to a Business Class account to take advantage of easy data exports.

Meghan Finch is the Digital Assets Librarian at Oakland University in Rochester, MI. Her professional interests include electronic resource management strategies, digital libraries, institutional repositories, and digital preservation.
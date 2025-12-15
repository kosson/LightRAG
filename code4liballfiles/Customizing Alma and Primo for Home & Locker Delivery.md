---
title: "Customizing Alma and Primo for Home & Locker Delivery"
source: "https://journal.code4lib.org/articles/15521"
author:
  - "Christina L. Hennessey"
published: 2021-02-10
created: 2025-01-10
description: "Like many Ex Libris libraries in Fall 2020, our library at California State University, Northridge (CSUN) was not physically open to the public during the 2020-2021 academic year, but we wanted to continue to support the research and study needs of our over 38,000 university students and 4,000 faculty and staff. This article will explain our Alma and Primo implementation to allow for home mail delivery of physical items, including policy decisions, workflow changes, customization of request forms through labels and delivery skins, customization of Alma letters, a Python solution to add the “home” address type to patron addresses to make it all work, and will include relevant code samples in Python, XSL, CSS, XML, and JSON. In Spring 2021, we will add the on-site locker delivery option in addition to home delivery, and this article will include new system changes made for that option."
tags:
  - "#Alma"
  - "#covid/19"
  - "#home/delivery"
---
# Customizing Alma and Primo for Home & Locker Delivery
Christina L. Hennessey

Like many Ex Libris libraries in Fall 2020, our library at California State University, Northridge (CSUN) was not physically open to the public during the 2020-2021 academic year, but we wanted to continue to support the research and study needs of our over 38,000 university students and 4,000 faculty and staff. This article will explain our Alma and Primo implementation to allow for home mail delivery of physical items, including policy decisions, workflow changes, customization of request forms through labels and delivery skins, customization of Alma letters, a Python solution to add the “home” address type to patron addresses to make it all work, and will include relevant code samples in Python, XSL, CSS, XML, and JSON. In Spring 2021, we will add the on-site locker delivery option in addition to home delivery, and this article will include new system changes made for that option.

## Introduction

The California State University, Northridge (CSUN) Library serves a campus of 38,310 students and over 4,000 faculty and staff (Fall 2020) \[[1](https://journal.code4lib.org/articles/#note1)\]. A physical library that is normally open 7 days a week (an average of 90 hours a week with extended hours for finals), with over 1.3 million in-person visits per year and over 71,000 physical material circulations a year (2018-2019 statistics) \[[2](https://journal.code4lib.org/articles/#note2)\], was suddenly closed to the public in March 2020 due to COVID-19 concerns. A library and campus closure of what was predicted to be a few weeks, turned into a closure for for the rest of 2020 and then of an entire academic year, and we needed to find safe ways to continue to provide physical items for our patrons and their study and research needs. Using our Ex Libris Alma and Primo systems, we implemented home delivery of physical items in time for the Fall 2020 semester (August 24, 2020). In addition to the home delivery option, in Spring 2021, we will start delivering library materials to an outdoor locker where patrons can pick up their library items in a touchless and safe manner. Neither the home delivery nor the locker delivery were automatically available in the existing system without several configuration changes, which will be covered here.

CSUN is located in the county of Los Angeles in California, one of the strictest counties in the United States for COVID-19 closures and lockdowns. Our library opening decisions along the way had to accommodate the decisions of local and state governments, and at the California State University level and the campus level, in addition to our own library administration. Our decisions to implement home & locker delivery were also influenced by the fact that although our physical library was centrally-located on campus, there was no way to quickly drive up to the building or park your vehicle nearby, so curbside pickup of library items was not an option. Our faculty, staff, and students live an average of 11 miles from campus (2019) \[[3](https://journal.code4lib.org/articles/#note3)\] so home delivery times through mail could be reasonable, and a visit to a local library locker on campus would not be unreasonable.

Even though our physical library has been closed since mid-March 2020, the library and library staff continue to provide library services through LibChat, LibAnswers, text and phone, email, and Zoom appointments. The staff working these services needed to be familiar with the home and locker services we provided so that they can support the questions of our patrons.

CSUN migrated to the Alma and Primo systems in 2017, as part of a shared system between 23 California State University campuses and a central Chancellor’s Office. Decisions and systems changes made locally at CSUN needed to match up and complement the decisions made at the Chancellor’s level.

## Home Delivery Implementation

As it became clear in July 2020 that the library was not going to re-open physically for the first day of classes for Fall 2020 (August 24, 2020), we needed to determine how to implement home delivery in our Alma and Primo systems in a way that was public- and staff-friendly, and easy to use. Alma and Primo have a configurable “Resource Request” function \[[4](https://journal.code4lib.org/articles/#note4)\] with online forms that can be customized and can pass the bibliographic & user information directly to the Alma request queue for staff processing. An alternative option would be for patrons to just fill out a webform, or send an email requesting materials for mail delivery, but we wanted to make the process as easy as possible when the patron had already found the material in our library discovery system ([http://bit.ly/csunprimo](http://bit.ly/csunprimo)) and they had already logged in with their library user account. With students having to move back home or find other places to live in town due to not needing to come to campus this semester, we also wanted to give the option for requesters to input a different mailing address than the one the library already had in its database. In addition to our own local patrons requesting our local materials for home delivery, we wanted to allow our patrons to do their regular resource sharing requesting through this implementation as well.

With the charge of “make home delivery happen by Fall 2020,” there were many decisions to make and discuss, which was very difficult during a time when all our meetings had to be virtual and making sure that all those affected and had knowledge and opinions were included in the analysis. Discussions included:

1. What user groups can requestOriginally, we were going to allow home delivery requests for all of our 25 Alma user groups, the same user groups that could circulate physical materials when we were open. However, concerns about the possible popularity of the service led us to first review recent circulation statistics from each user group to determine what the impact would be for supporting all user groups, and what groups we could leave out of the service. In the end, we only allowed requests for students, faculty, and staff, and not other campus-affiliated user groups like community members, high school students, and alumni. There was the concern on messaging and the goodwill that might be lost with excluding some of these groups (e.g. local high school students that might end up attending CSUN because of their positive CSUN library experience) but this has turned out to not be a huge issue – it seems that these other groups respect that this is a temporary circulation restriction due to the pandemic, and they will be able to access and request our library materials soon again in the future.
2. What material types and locations can be requestableBeing a relatively new Alma & Primo implementation (only three years at the time of home delivery implementation), we had not done much with the resource request features in the past. For home delivery implementation, we needed to make decisions on each one of our 103 locations and 101 material types, and what could be requestable and what could not. Some of the decisions were easy (we were not going to circulate laptops as the entire inventory was already checked out when we abruptly closed in March 2020) and some were more difficult, such as some of our more unique materials from our National Center on Deafness (NCOD) collections. We also needed to revisit what locations and material types were requestable by patrons from other libraries for resource sharing, and if we wanted those to circulate to other libraries during this time. Even for some of our normally non-circulating collections, these were revisited as something marked as “non-circulating” may have just meant “this really is allowed to circulate but not automatically as we want to manually approve it.” For example, some of our NCOD collections were normally non-circulating to cut down on use of rare materials but could circulate with special permission granted at public services desks. With no staff to manually approve these requests in person, we needed to allow circulation and requesting on the item first through home delivery, and then the staff processing the request could make that decision instead to circulate the item or cancel the request with an explanation note.
3. Limits on how many items could be requested at a timeAs with the limits on non-circulating locations with manual override allowed, we did not previously have limits on the number of items that could be checked out at a time for some of our patron groups. Even though there were no limitations on the number of checkouts, a library staff member would notice if someone brought 200 books to the desk to check out, and could enforce a manual limit if necessary. However, with all the requests and checkouts being virtual, we needed to set limits on how many requests could be done at a time to lessen the impact on staff processing time and the home delivery costs. We decided that five items could be requested at once based on the average number of books checked out at a time when we were physically open, and concerns that one or two users might request a large number of books at a time and strain our mailing budget. Five requests at a time seems like a low number until you realize that as soon as a request was processed (as either a checkout or cancellation), then more requests could be made, so patrons could still have many books checked out at once for research or study. This limitation of five requests could also be overridden by a staff member from a phone call or email if necessary. We only experienced a few times in fall 2020 where a patron requested five items at a time, and no one ever called or emailed to request more, so this was not as big of an issue as we expected.
4. How often requests will be processedDue to CSUN limitations on the number of people that should be in an area or office on campus during this time, only one person in our Guest Services Department was assigned each weekday to come to campus to pick up and delivery the library’s mail from campus mail (which was no longer delivering to or picking up from the library during campus closure), pick up items from the 10 library bookdrops across campus, and then process the requests that came in since the last processing of the queue, including retrieving items from the stacks and cancelling requests for items that were not found. So if a patron made a request for home delivery on a Friday afternoon, the request might not be processed until Monday morning. We tried to communicate this possible delay to our patrons but in a time of “Amazon delivery time expectations,” there were still attempts at multiple duplicate requests for patrons that had assumed their request did not go through since there was no action for a few days.
5. Handling/quarantine of retrieved itemsThere was also much discussion on how the retrieval and processing of items from the stacks would work with scientific unknowns of how long the COVID-19 virus may live on materials. We kept a close eye on the testing and recommendations from the REALM project\[[5](https://journal.code4lib.org/articles/#note5)\]. With one person in the stacks each day, over 2 million items in the stacks across four floors, a map collection, and an automatic storage and retrieval system (AS/RS) in a separate part of the library building, the likelihood that a staff member would handle books in the same area often was low. We decided that the home delivery books would *not* be quarantined after retrieval from the stacks and would be immediately mailed. Any virus living on the items would be gone by the time the item arrived at the patron’s home address.

## Basics of System Setup and the Patron Experience

There are many ways that one can set up home delivery inside of Alma and Primo, but the following explanation is how CSUN chose to do it. We implemented our local home delivery requests through the hold request form in Primo, which is customizable for which fields you wish to share in your form.

When the patron is logged into their library account in Primo, and they are part of a user group that allows requesting on an item material type and location that allows requesting, the Request link will appear in the “Get it” display in Primo. You don’t have to name this link “Request”, you could have “Request for home delivery” or any text you want there, but “Request” is the text default.

![Request link in Primo.](https://journal.code4lib.org/media/issue50/hennessey/figure1-request%20link.png)  
**Figure 1.** Request link in Primo.

The “Request” link takes you to this next screen. Figure 2 is the look of the out-of-the-box request form, and Figure 3 is what the request form can look like after customization.

![Request form with no customization](https://journal.code4lib.org/media/issue50/hennessey/figure2-requestform-ootb.png)  
**Figure 2.** Request form with no customization.

![Request form with customization](https://journal.code4lib.org/media/issue50/hennessey/figure3-requestform-customized.png)  
**Figure 3.** Request form with customization.

Customizations of this form can be done through Alma’s Discovery Interface Logic Labels and the Hold Request Form Customization \[[6](https://journal.code4lib.org/articles/#note6)\], and through delivery skins in Alma and Primo Back Office. The labels can include HTML to include links and formatting. We changed the name of the default “Comment” field to “Mailing Address” so the patron could add their preferred mailing address, instead of us assuming they wanted the item mailed to the mailing address we have on file for them. This will pass the mailing address through to the request queue in the “note” field for each request. The Hold Request Form Customization will need to have the “Comment” field turned on to show Mailing Address, and the “generalUseLabel” field turned on for all the text that is below Mailing Address on this form example.

During our home delivery-only phase, we did not want to confuse the patron with a pickup location choice, since there was no choice to make, so we removed this selection and field from the form. To do this, we used delivery skins \[[7](https://journal.code4lib.org/articles/#note7)\] and updated the mashup\_new.css file with the text in figure 4 to remove that particular field. For institutions using Primo Back Office, you will also need to change some labels in the Mapping Tables – Delivery subsystem – Templates to point to the new delivery skin name, and then deploy the changes.

| 1  2  3  4  5  6  7  8 | `.holdRequest #pickupLocationH {`  `display``: ``none``;`  `}`  `.holdRequest #pickupLocationV {`  `display``: ``none``;`  `}` |
| --- | --- |

**Figure 4.** The pickup location is hidden on the hold request form.

Once the patron has completed their request, it will show up in the Alma request queue, which staff can find at the menu option *Monitor Requests & Item Queue* in Alma. All the items requested for home delivery will show up with Pickup Location = Home Delivery.

![Home delivery item in the request queue. ](https://journal.code4lib.org/media/issue50/hennessey/figure5-requestqueue-homedelivery.png)  
**Figure 5.** Home delivery item in the request queue.

Staff will take the list of requested items to the stacks to retrieve each one. For all items not found, the request is cancelled with a note to the patron that they can try requesting it through other CSU libraries or interlibrary loan. We chose to not automatically convert these requests to resource sharing requests as the patron might not want it if it is arriving in 3-4 weeks instead of 1-2 weeks and we did not want to involve the cost of interlibrary loan for an unwanted request.

For all items found, the items will be checked out to a local circulation desk. This will send an automatic email that the item is on the way. In Alma, this is the Loan Receipt Letter.

![Loan Receipt Letter in Alma.](https://journal.code4lib.org/media/issue50/hennessey/figure6-loanreceiptletter-homedelivery.png)  
**Figure 6.** Loan Receipt Letter in Alma.

Alma letters are very configurable using labels in each letter and through the XSL template for each letter. Depending on what library and department the item was from, we had conditional text in the letter so the contact information at the bottom of the letter is different, and so we don’t recommend that library technology equipment is returned to the bookdrops.

![XSL conditional text in Alma Loan Receipt Letter.](https://journal.code4lib.org/media/issue50/hennessey/figure7-loanreceiptletter-xsl.png)

**Figure 7.** XSL conditional text in Alma Loan Receipt Letter.

After all items are checked out to patrons, they are packed into envelopes pre-printed with the patron’s chosen mailing address and mailed that day from campus mail. Within a week, patrons will receive the items in the mail.

## Python Script Needed to Make Home Delivery Work

In addition to the system changes for hold request forms and letters, other changes must be made in Alma to support what Ex Libris calls “personal delivery,” \[[8](https://journal.code4lib.org/articles/#note8)\] which can be used to deliver to home or office addresses. The Request Terms of Use (TOU) for all requestable locations must have the following fields changed to support personal delivery:

- Is Requestable = Requestable (if it wasn’t already)
- Pickup Locations = Pick up only in owning library (only if you removed the pickup location from the form. If you kept it, use the setting “Anywhere”)
- On Shelf Request Policy = Allow for pickup anywhere regardless of availability
- Personal delivery = Home (or “Office”, or “All” for home and office)
- Personal delivery fee = None (you can set a fee for personal delivery costs, we did not)

The circulation desk configuration for each library in your Alma system that will be supporting home delivery will need to have the option checked to “support personal delivery”. If you would like to inform your patrons that the item is on the way via the Loan Receipt Letter email, you will need to turn on “send loan receipts” for that circulation desk.

One of the limitations of the Ex Libris personal delivery option is that the requesting patron must have an Alma user record with at least one mailing address type of “home” or “work” in order for the request option to appear in Primo \[[9](https://journal.code4lib.org/articles/#note9)\]. Options for mailing address types in Alma are: alternative, home, work (the “work” type also referred to as “office” in some of the documentation), and school. All of CSUN’s faculty & staff user records have a preferred mailing address type of “home,” but all our student records only had an address marked as “school” so they could not request home delivery unless all their records were updated. Through testing, we determined that an address can have multiple address types assigned to it, so if we just add “home” to any address that doesn’t already have that type, that will solve the development problem and home delivery will show up for these users.

Depending on where your user records originate from, who controls the configuration of that data and the transfer to the Alma database, and how often this update occurs, you may be able to solve this problem with a full update of all user records, adding the “home” address type to each address in each record. At CSUN, our user database is updated weekdays at 4am from our campus’ Student Information System (SIS) database, picking up any changes in enrollment, new users, and new addresses for users each day. We chose to not request an update to the centralized records but to control our updates locally in our Alma database. However, this decision would require us to check and update our user records daily for records missing the “home” address type.

The first problem is to determine which Alma user records are missing the “home” address in the user database. To save time, you can limit the set of user records you want to update to active, non-expired users, and if you have determined ahead of time what user groups will be able to do requesting, you only need to update records for those user groups instead of the whole database.

In July 2020, I determined that out of our 48,000 active, non-expired user records, only around 5,000 of them had a “home” address type. There was no way I could update these user records one-by-one in time for the fall 2020 semester, so I created a Python program that uses the Alma User REST API \[[10](https://journal.code4lib.org/articles/#note10)\] to GET an Alma user record, determine if the preferred address had a home address type, and if not, to PUT it back into the user record. Since only one address needs to have the home address type for personal delivery to work, I chose to only check and update the preferred address for a home type, instead of the unlimited number of addresses a user record can have. You can run the program on your entire database of primary IDs, or a quicker process is to just run it on the IDs that you have already determined are missing a home address type. The program works on both internal and external address records. The program is available at [GitHub](https://github.com/clhennessey/alma-add-home-address-type-to-preferred), as either a Windows executable or a Python program that can be modified for your own needs. The program requires the following modules: Tkinter, requests, and xmltodict.

Here is an example of an Alma user record that needs the update.

![A user record that has a preferred address with only the type 'work.'](https://journal.code4lib.org/media/issue50/hennessey/figure8-Almauserrecord-nohome.png)  
**Figure 8.** A user record that has a preferred address with only the type “work.”

The Python program accepts a filename as input:

![Python program asks for a filename that contains primary IDs.](https://journal.code4lib.org/media/issue50/hennessey/figure9-pythonprograminterface.png)  
**Figure 9.** Python program asks for a filename that contains primary IDs.

A file of primary IDs looks like this:

![input file of primary IDs.](https://journal.code4lib.org/media/issue50/hennessey/figure10-inputfileforpython.png)  
**Figure 10.** input file of primary IDs.

After the program runs, the updated address in Alma looks like this:

![User record that has a preferred address with both the type 'work' and 'home.'](https://journal.code4lib.org/media/issue50/hennessey/figure11-Almauserrecord-hashome.png)  
**Figure 11.** User record that has a preferred address with both the type “work” and “home.”

Here is the format of the address part of an Alma user record in XML. “Home” is added as an “address\_type” to the preferred address record by the program.

![Sample of XML format for an Alma user record, address section](https://journal.code4lib.org/media/issue50/hennessey/figure12-AlmauserrecordinXML.png)  
**Figure 12.** Sample of XML format for an Alma user record, address section.

Once I had updated the whole database of Alma with active, non-expired user records, the daily maintenance was as follows:

1. Checking the 4am weekday SIS Alma job update for the new and updated user IDs and run the program on a list of those IDs.
2. An Alma Analytics scheduled report \[[11](https://journal.code4lib.org/articles/#note11)\] emailed every day at 6am with records missing a preferred, home address. If there were any in this list, I would run the program on those IDs as well.

Both steps are necessary to keep all user records updated. Any records updated at 4am would suddenly leave those users unable to request home delivery until the re-update of their records. The Analytics query was necessary to catch any changes made by staff during the previous day where a new record without “home” was created, but Analytics was last updated at 4pm the previous day so the results were slightly out of date. The updates are not necessarily required each day – near the beginning of each semester when there were lots of user record updates due to new student registrations, we needed to run it every day, but at the end of each semester we only ran it every few days.

We have no plans to remove the “home” address type from Alma user records that already received this update, even if the home delivery implementation is eventually fixed by Ex Libris. Having multiple address types on Alma user records doesn’t seem to affect the record or degrade performance, and it may be difficult to retroactively determine which records had a real “home” address type and those that only had one to make home delivery work.

## Plans for Locker Delivery

Although the home delivery service worked well for fall 2020, the time, staff, and material costs for home delivery were expensive at a time budgets are tight, and the home mail delivery was slow due to the impact of COVID-19 on postal delivery times. The purchase of an outside library locker could be paid for with CARES Act funding. This limits the impact on the library’s budget and the patron could get the requested item faster instead of depending on postal mail.

After receiving quotes and demonstrations from different locker options, CSUN chose the vendor LuxerOne for an outdoor locker \[[12](https://journal.code4lib.org/articles/#note12)\]. The locker sizes and number of lockers is configurable, and CSUN ended up with 63 lockers of varying sizes in 3 units total. The locker is controlled by an iPad housed inside one of the locker units, which is connected to the internet and a power supply.

LuxerOne has been in the locker business since 2005, starting with delivery of laundry to lockers, and with apartment and business package delivery since 2014 \[[13](https://journal.code4lib.org/articles/#note13)\], but is relatively new to the library delivery space. In fall 2020, a team of California State University library staff and LuxerOne staff developed a webhook integration \[[14](https://journal.code4lib.org/articles/#note14)\] from the Alma user database to the LuxerOne locker user database. This webhook pulls appropriate user data from the Alma database and shares it with the LuxerOne database to make that same user information accessible at the locker. The webhook determines that a request has been made in the Alma system (there are many types of requests) and will move a small part of that user data into the LuxerOne database. This webhook to only load information about each requesting user is preferable to sharing or downloading the full active Alma user database of over 48,000 active user records.

Webhook configuration in Alma is through the integration profiles and looks like this, with a “secret key” to talk between Alma and LuxerOne:

![Sample of XML format for an Alma user record, address section](https://journal.code4lib.org/media/issue50/hennessey/figure13-webhookconfiguration.png)  
**Figure 13.** LuxerOne webhook configuration in integration profiles.

Here is part of the request information that is sent from Alma to LuxerOne through the webhook, in JSON format:

![Sample request information sent from Alma to LuxerOne in JSON format.](https://journal.code4lib.org/media/issue50/hennessey/figure14-webhookAlmatoLuxerOne.png)  
**Figure 14.** Sample request information sent from Alma to LuxerOne in JSON format.

In addition to the webhook implementation, in order to offer both locker and home delivery at the same time for patrons, a new library has to be created inside of Alma with a new circulation desk, as you cannot configure multiple pickup locations for a particular library. For our locker deliveries, we check the items out to the new “24/7 Lockers” library and circulation desk, instead of our regular main library circulation desk. This has the added advantage of allowing us to track our locker deliveries separately from our other circulations, and we can customize the Alma letters based on whether it is home or locker delivery. Another configuration change to make this work is that the “Relationships” table will need to be configured to allow circulation between the 24/7 Lockers circulation desk and the other circulation desks.

Changes also need to be made again to request TOUs to support multiple pickup locations (Pickup Locations = Anywhere), the changes in delivery skin mashnew.css need to be commented out so the pickup location shows on the form, the “generalUseLabel” on the form will need to be changed to reflect the locker pickup option and instructions.

Other configurations needed for the locker include the emails and texts that will remind the patron that there is an item to be picked up. These communications come from the LuxerOne system, not Alma, and need to be configured through LuxerOne staff instead of having direct access to configure the emails. We set CSUN’s email reminders at 2 days, 4 days, 5 days, and then on the 6th day, the item will be returned to the shelves for use by other patrons and to free up that locker.

The item can be picked up touchlessly if the patron has installed the LuxerOne app on their phone. When they are near the locker, they can press a button on the app that will open their particular locker so they can retrieve their items. There is also a touchscreen where they can input their access code or scan a QR code, opening the locker.  
The patron experience for locker delivery will involve choosing a pickup location at the request form (see figure 15).

![Pickup location 24/7 Lockers is chosen.](https://journal.code4lib.org/media/issue50/hennessey/figure15-requestformlocker.png)  
**Figure 15.** Pickup location 24/7 Lockers is chosen.

![Close-up of drop-down for pickup location](https://journal.code4lib.org/media/issue50/hennessey/figure16-pickuplocationdropdown.png)  
**Figure 16.** Close-up of drop-down for pickup location

Changes in staff workflow are that the items for locker delivery show up in the request queue with “Pickup Location = 24/7 Lockers”, instead of “Pickup Location = Home Delivery” (see figure 17), and that items are checked out at the “24/7 Lockers” circulation desk instead of the main circulation desks.

![A request for locker delivery.](https://journal.code4lib.org/media/issue50/hennessey/figure17-requestqueue-lockerdelivery.png)  
**Figure 17.** A request for locker delivery.

## Future Plans

As of this writing (January 2021), CSUN plans to be back on campus in fall 2021 and the library may physically open a few months before that. However, we still think there will be interest in the home delivery service, especially for our faculty & staff that are continuing to work remotely. Our lockers will exist permanently outside of our library and we predict the 24/7 availability of them will be popular with our patrons as they can pick up their items at times that the library is closed. We currently only plan to put our own library and interlibrary loan items in there for pickup, but we may eventually configure the locker to allow faculty, staff, or couriers to leave items for us to pick up from the lockers.

The script for updating addresses in Alma user records works well for a site that has someone assigned to update the records each day, but future plans would be to automate these updates each day, possibly through a webhook. Also, for libraries that don’t want to do anything with code, I want to explore making a Cloud App \[[15](https://journal.code4lib.org/articles/#note15)\] that other libraries can download into their Alma to do these same tasks. Ex Libris is aware of the limitations of home and locker delivery in their system and we hope to see updates to their software over the next year that address the limitations of requiring a “home” address and of requiring a new library for the locker checkouts.

## Bibliography

\[[1](https://journal.code4lib.org/articles/#ref1)\] About CSUN \[Internet\]. CSUN Office of Institutional Research; \[cited 15 December 2020\]. Available from: [https://www.csun.edu/about-csun](https://www.csun.edu/about-csun).  
\[[2](https://journal.code4lib.org/articles/#ref2)\] Library Statistics, 2018-2019 \[Internet\]. CSUN Oviatt Library; \[cited 14 December 2020\]. Available from: [https://library.csun.edu/About/LibraryStatistics](https://library.csun.edu/About/LibraryStatistics).  
\[[3](https://journal.code4lib.org/articles/#ref3)\] Commuting Behavior and Transportation Preferences of the CSUN Community \[Internet\]. \[March 27, 2019\]. \[cited 15 December 2020\]. Available from: [https://www.csun.edu/sites/default/files/CommutingReport\_2018\_Final\_0.pdf](https://www.csun.edu/sites/default/files/CommutingReport_2018_Final_0.pdf)  
\[[4](https://journal.code4lib.org/articles/#ref4)\] Requests in Alma \[Internet\]. Ex Libris; \[cited 14 December 2020\]. Available from: [https://knowledge.exlibrisgroup.com/Alma/Product\_Documentation/010Alma\_Online\_Help\_(English)/030Fulfillment/010Introduction\_to\_Fulfillment/Requests\_in\_Alma](https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/010Alma_Online_Help_\(English\)/030Fulfillment/010Introduction_to_Fulfillment/Requests_in_Alma)  
\[[5](https://journal.code4lib.org/articles/#ref5)\] REALM Project: Happening Now \[Internet\]. OCLC; \[cited 15 December 2020\]. Available from: [https://www.oclc.org/realm/happening-now.html](https://www.oclc.org/realm/happening-now.html)  
\[[6](https://journal.code4lib.org/articles/#ref6)\] Discovery Interface Display Logic \[Internet\]. Ex Libris; \[cited 15 December 2020\]. Available from: [https://knowledge.exlibrisgroup.com/Alma/Product\_Documentation/010Alma\_Online\_Help\_(English)/030Fulfillment/080Configuring\_Fulfillment/100Discovery\_Interface\_Display\_Logic](https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/010Alma_Online_Help_\(English\)/030Fulfillment/080Configuring_Fulfillment/100Discovery_Interface_Display_Logic)  
\[[7](https://journal.code4lib.org/articles/#ref7)\] Branding the Delivery Tabs \[Internet\]. Ex Libris; \[cited 15 December 2020\]. Available from: [https://knowledge.exlibrisgroup.com/Alma/Product\_Documentation/010Alma\_Online\_Help\_(English)/060Alma-Primo\_Integration/060Configuring\_Alma\_Delivery\_System/090Branding\_the\_Delivery\_Tabs](https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/010Alma_Online_Help_\(English\)/060Alma-Primo_Integration/060Configuring_Alma_Delivery_System/090Branding_the_Delivery_Tabs)  
\[[8](https://journal.code4lib.org/articles/#ref8)\] Supporting Personal Delivery for Requests \[Internet\]. Ex Libris; \[cited 15 December 2020\]. Available from: [https://knowledge.exlibrisgroup.com/Alma/Product\_Documentation/010Alma\_Online\_Help\_(English)/030Fulfillment/020Circulation\_Desk\_Operations/020Creating\_a\_Request\_from\_the\_Institution#Supporting\_Personal\_Delivery\_for\_Requests](https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/010Alma_Online_Help_\(English\)/030Fulfillment/020Circulation_Desk_Operations/020Creating_a_Request_from_the_Institution#Supporting_Personal_Delivery_for_Requests)  
\[[9](https://journal.code4lib.org/articles/#ref9)\] Home and Office Delivery \[Internet\]. \[updated 11 Feb 2014\] Ex Libris; \[cited 15 December 2020\]. Available from: [https://knowledge.exlibrisgroup.com/Alma/Training/03\_What%27s\_New\_Videos\_2014/11\_February\_2014\_Release/Home\_and\_Office\_Delivery](https://knowledge.exlibrisgroup.com/Alma/Training/03_What%27s_New_Videos_2014/11_February_2014_Release/Home_and_Office_Delivery)  
\[[10](https://journal.code4lib.org/articles/#ref10)\] Users and Fulfillment \[Internet\]. Ex Libris Developer Network; \[cited 16 December 2020\]. Available from: [https://developers.exlibrisgroup.com/alma/apis/users/](https://developers.exlibrisgroup.com/alma/apis/users/)  
\[[11](https://journal.code4lib.org/articles/#ref11)\] Scheduling and Subscribing to Alma Analytics Reports \[Internet\]. Ex Libris; \[cited 16 December 2020\]. Available from: [https://knowledge.exlibrisgroup.com/Alma/Product\_Documentation/010Alma\_Online\_Help\_(English)/080Analytics/040Scheduling](https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/010Alma_Online_Help_\(English\)/080Analytics/040Scheduling)  
\[[12](https://journal.code4lib.org/articles/#ref12)\] Luxer Lockers \[Internet\]. Luxer One; \[cited 15 December 2020\]. Available from: [https://www.luxerone.com/product/luxer-lockers/](https://www.luxerone.com/product/luxer-lockers/)  
\[[13](https://journal.code4lib.org/articles/#ref13)\] Interview with Arik Levy: The Entrepreneurial Journey to Luxer One \[Internet\]. \[updated 9 August 2018\]. Luxer One; \[cited 15 December 2020\]. Available from: [https://blog.luxerone.com/interview-with-arik-levy-the-entrepreneurial-journey-to-luxer-one](https://blog.luxerone.com/interview-with-arik-levy-the-entrepreneurial-journey-to-luxer-one)  
\[[14](https://journal.code4lib.org/articles/#ref14)\] Webhooks \[Internet\]. Ex Libris Developer Network; \[cited 15 December 2020\]. Available from: [https://developers.exlibrisgroup.com/alma/integrations/webhooks/](https://developers.exlibrisgroup.com/alma/integrations/webhooks/)  
\[[15](https://journal.code4lib.org/articles/#ref15)\] Ex Libris Cloud Apps \[Internet\]. Ex Libris Developer Network; \[cited 16 December 2020\]. Available from: [https://developers.exlibrisgroup.com/cloudapps/](https://developers.exlibrisgroup.com/cloudapps/).

*Christina L. Hennessey* has worked in libraries for twenty years in various capacities and has been the Systems Librarian at California State University, Northridge (CSUN) since 2018. Before becoming a librarian, she worked in the software industry for 10 years as a programmer, and is happy that she still gets to write code on a daily basis as a librarian to solve library systems problems.
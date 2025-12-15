---
title: "The Tools We Don’t Have: Future and Current Inventory Management in a Room Reservation System"
source: "https://journal.code4lib.org/articles/13718"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-08-09
created: 2025-01-10
description: "Fondren Library at Rice University has numerous study rooms which are very popular with students. Study rooms, and equipment, have future inventory needs which require a visual calendar for reservation. Traditionally libraries’ manage reservations through a booking module in an Integrated Library System (ILS), but most, if not all, booking modules lack a visual calendar [...]"
tags:
  - "clippings"
---
# The Tools We Don’t Have: Future and Current Inventory Management in a Room Reservation System
Denis Galvin, Mang Sun, and Hanjun Lee

Fondren Library at Rice University has numerous study rooms which are very popular with students. Study rooms, and equipment, have future inventory needs which require a visual calendar for reservation. Traditionally libraries’ manage reservations through a booking module in an Integrated Library System (ILS), but most, if not all, booking modules lack a visual calendar which allows patrons to pick out a place and time to create a reservation. The IT department at Fondren library was able to overcome this limitation by modifying the open source Booked Scheduling software so that it did all of the front end work for the ILS, while still allowing the ILS to manage the use of the rooms.

## Background

Fondren Library at Rice University, like many other academic libraries, has done extensive renovation of its library space. It has modernized and renovated its building, and it has become a very popular place with students. Part of the renovation has been to add more study rooms, and to equip them with attractive and functional furniture and state-of-the-art technology. As a result, the study rooms are some of the most in demand spaces in the library.

The library has historically let students make advanced reservations on study rooms. The initial scheduling system was a paper ledger which was maintained by the circulation department. Students made reservations by visiting the library and staff members would input them into the ledger. When the reservation time came, students would come to the circulation desk; staff would consult the ledger and checkout the key which corresponded to the room which had been reserved.

In 2010 the library purchased an online room reservation system from Evanced which was Software as a Service (SaaS). For the most part this system worked, but the keys which unlocked the rooms were still checked out through the ILS. The library discovered numerous downsides to having an online reservation system which is not connected to the ILS. When a student would show up to get the key for their room, circulation staff needed to check the reservation system to determine what room they had reserved. Alternatively, if a user walked in, staff would have to look through the reservation system to check what rooms were available. They would then move to the ILS and check the key to the room out for the length of the reservation. If a student did not show up for a reservation, the staff member would need to remove it from the online system or it would look like someone was in the room. Sometimes reserved rooms were checked out accidentally to a walk-in user when the room had an existing reservation which belonged to another patron. There was nothing built into the system to stop this from happening because the system used to book the room had no relationship to the system used to check the key for the room out to the user. It’s entirely up to staff to match the ILS with the online reservation system, they must maintain two systems.

## Policy

When we were evaluating systems, the important thing was for students to be able to make their own reservations online, but staff also had to be able to block rooms out for various reasons ranging from repairs to special programs. This meant having a system which allowed for mediated and unmediated reservations. The library wanted students to be able to make only one reservation per day, with reservations to be made no more than three days in advance. Rooms have always been checked out to students through the integrated library system. Rooms are represented by the key associated with them. When a student comes to the circulation desk, staff view their reservation and the key is checked out. Students can have rooms for up to four hours. They can only have one reservation per day, but once the reservation is complete they may make another one. They are only allowed to make reservations up to three days in advance. The library has maintained this policy through every iteration of reservation system; paper through electronic.

In an ideal world software used to manage library collections would have a reservation system that had a working booking module complete with an online calendar. It is necessary to have a visual representation of when materials are reserved, when they are in use and when they are available. If there are multiple materials, such as rooms, they need to be shown simultaneously so users can pick something that is available at the time they want it. There is no library software built at this time that does this. Many booking modules that come with the ILS do not have usable calendars. In SirsiDynix’s Symphony, the way the public books a resource does not show when that resource is in use. This means a patron selects a resource, chooses the date and time they want to use it, they click a button and the ILS determines availability. If the item is in use or reserved at the time selected, the system displays a message that the material is not available at that time. There is no way to tell before selecting the resource whether it is available or not. Essentially this means it is a guessing game. If a resource is highly used it might mean selecting dates and times over and over only to find out the item is not available. This is frustrating and unacceptable. The online “calendar” for bookings also doesn’t show related items at the same time; you need to view each item individually and attempt to create a booking. For most patrons this would not seem to be a workable system.

## Literature Review

When Ball State University decided they needed a study room reservation system, they built it from scratch as is covered by Faust, Hafner and Seaton.\[[1](https://journal.code4lib.org/articles/#note1)\] Prior to building their room reservation system it was difficult for students to book a room. Like a lot of libraries, they used many ways to book rooms prior to an online reservation system. They discuss pros and cons of buying versus building, and they come to the conclusion that nothing on the market would satisfy their needs. They walk the reader through the different iterations of the software and they discuss problems they encountered, such as long page loads when the schedule filled up. They choose to develop their software, OpenRoom, around a combination of PHP and MySQL with either IIS or Apache acceptable as a web server.

Doherty and White discuss the general issues that go into the selection of an online room reservation system.\[[2](https://journal.code4lib.org/articles/#note2)\] They chose the aforementioned open source system “OpenRoom” which was developed out of Ball State University. The article looks at the problems that create the need for a reservation system such as equitable use and policy decisions. Of the literature reviewed, this paper is the only one that looked at booking rooms through the ILS. They choose not to because of the cumbersome nature of booking in the system. This article offers a good look at standard policy decisions which are relevant to any room reservation system.

The University of Virginia first evaluated open source tools before deciding they would be better off going with a commercial solution. In the article “Selecting and implementing a patron-driven resource reservation system,” Sallans, et al. chose a system that was in use by a lot of other academic libraries.\[[3](https://journal.code4lib.org/articles/#note3)\] In their implementation, they found challenges which stemmed from the complexity of their organization, differing usage policies based on rooms/materials, and issues related to the local IT environment.

Williams and Hada discovered many of the same problems that other libraries have found when they started investigating room reservations systems for newly renovated spaces at Queens College Libraries.\[[4](https://journal.code4lib.org/articles/#note4)\] After evaluating numerous tools that would need to fit their specific environment they chose the open source system OpenRoom. The system was chosen because they were able to modify the underlying source code. They immediately ran into problems with deprecated code due to the fact that they were on a newer OS which had updated code libraries. This resulted in a consultation between the team at Queens College Library and Ball State University who had ceased active development of the code. It was agreed that Queens College would take over the project, which they did, and with some modifications they were able to launch a successful prototype. (Interestingly, at the time of this writing the OpenRoom system has not had its code updated so it is once again carrying deprecated code; If you tried install it on an up-to-date operating system the libraries the code depends on would not match.)

In the broadest context outside of a library, Hohpe and Woolf introduce and elaborate on enterprise integration patterns that can be adopted and used in projects.\[[5](https://journal.code4lib.org/articles/#note5)\] They are based on messaging technologies that have been widely used in joining and connecting applications and services. Unlike web services technology which relies on synchronous calls, messaging is a technology that drives asynchronous yet reliable interactions among programs by consuming data called message. In a typical messaging architecture, a program that sends message is called publisher while other programs that act on received messages are called consumers. As a practical example, the high volume messaging and streaming solution Apache Kafka is used at LinkedIn as a way to integrate different internal systems.\[[6](https://journal.code4lib.org/articles/#note6)\] Message-based application integration is the ideal tool to hook systems together.

## Architectural Considerations

Interesting applications rarely live in isolation.\[[7](https://journal.code4lib.org/articles/#note7)\] It was a longstanding goal of the library IT department to try to front the academic reservation system of the Symphony ILS with an open source calendaring reservation system. From the choices available, the most robust and familiar to the department was [Booked](https://www.bookedscheduler.com/) (formerly phpScheduleIt). The library had been using phpScheduleIt for a number of years as a standalone reservation system for the library’s computer equipment, and it was also in use by several campus units. It is one of the more popular choices as it has a large user community, is being actively developed, and is consistently publishing new versions. When choosing open source software it is wise to look for projects that are widely in use so that you don’t wind up an orphan on a piece of software with few users and no developers. Booked met that criteria so it seemed like a safe choice.

The major challenge of this project was the integration between the ILS and Booked. In order to accomplish this, the systems need to maintain two-way communications. Reservation related transactions originating from the web interface must be sent to Symphony and the ones performed in Symphony must be sent back to the web interface. The channels would be running at a standard http (80) or https port (443). The key component of this integration was data synchronization.

The first option we looked at was doing synchronization between Symphony’s Oracle database tables and Booked’s MySQL database. This idea was dropped because there were several potential complications. The first concern was that if for some reason the connection to Booked’s underlying MySQL database hung, the Symphony databases might also hang, and anything that had the potential to slow down or hang the ILS was not acceptable. The other concern was that this was probably against the terms of service in our contract with our ILS vendor.

The second thing we took some time looking at was messaging technologies to make data synchronization happen in real time. Messaging technology uses queues to accept, store and dispatch messages. For this project, messages could be used to carry reservation related transaction data from the Symphony ILS to the Booked system. The biggest challenge was how to capture in real time the reservation related transactions originating in the Symphony database. There were several options, one of which was buying and implementing Oracle Golden Gate, but the cost was too high, so it was quickly removed from consideration. Another choice was to write our own Oracle triggers to capture reservation transactions and send them into a messaging queue that would be deployed and running in parallel with Symphony on the same server. This option still required tampering with the underlying Oracle database which was also likely to violate our terms of service. Passing out data captured by triggers was also a complicated procedure which required installation of additional Oracle JAR libraries. We were not very confident that we could figure this out within the defined project deadline or that those JAR libraries would work reliably in the long run. The project team, somewhat reluctantly, agreed not to spend time on this solution, but it may be revisited in the future.

The third option was to use web APIs to do ILS-to-Booked data synchronization; we would implement this by developing web APIs to do two-way data synchronization. There was concern that transactions would be missed since it seemed like a lot of back and forth between servers. Everytime the ILS updated it would need to send the new information to the room reservation system, and everytime the room reservation system updated it would need to send that information back to the ILS, but that was the solution we went with. We customized the code on Booked to call web APIs that would be developed to wrap around Symphony APIs associated with the reservation module to sync the transaction data initiated from Booked. The challenging part is synchronizing the ILS transaction data, such as checked out room keys and booking information, to Booked because there is nothing native to the ILS which triggers external transactions. The workaround was somewhat primitive but works; set up a synchronization mechanism on Booked to call the web APIs driven by user need/events. Synchronization and reverse synchronization of transactions is triggered any time a user opens the Booked pages which display the reservation schedules of the study rooms.

## The Web APIs on ILS side

Based on our synchronization strategy, one of the first things we did was define and implement web programming interfaces (Web APIs) with the ILS. Ed-douibi defines Web APIs as “offering one or more publicly exposed endpoints to a defined request-response message system (typically expressed in JSON or XML) for either a Web server or a Web browser.”\[[8](https://journal.code4lib.org/articles/#note8)\] This is a simple and efficient definition of Web APIs, though it might be more appropriate to use the term web application over the term web server. In the diagram below, Booked is the web application consuming the room reservation web APIs we developed on the ILS side. The APIs provide the following five services, as determined by the value of query parameter “qt” or “op” in the returned JSON messages.

- qt=1: List reservations
- qt=2: Create a reservation
- qt=3: List a user’s reservations.
- qt=4: Remove a user’s reservations.
- qt=6: Modify a user’s reservation

[![Diagram of interaction between ILS, APIs and Booked](https://journal.code4lib.org/media/issue41/galvin/figure1x500.jpg)](https://journal.code4lib.org/media/issue41/galvin/figure1.jpg)  
**Figure 1.** Component diagram of Web Service APIs

In order to implement these five web APIs, we used the Perl programming language as it is already installed and in use on our ILS server. To design the APIs, we had two sides to handle. One is the web interface, Booked, which takes requests and sends back replies. The other is the interaction with our Symphony system. Our approach on the ILS side is to avoid intrusive operations that might go against the terms of service with our ILS vendor. In order to achieve this design goal, we didn’t use any Create, Update, Delete (CUD) SQL statements or its variant form like an Object Relational Mapping (ORM) tool in the API code to interact with the ILS’ underlying Oracle database. Symphony provides a rich set of API commands and has advanced transaction architecture. The transaction architecture specifically allows some interesting operations to be performed without the need for the graphical client – Symphony Workflows. Virtually any command that you can run through the ILS graphical interface can be formatted and run through the API server of Symphony. As a result, we didn’t need to tamper with the underlying Oracle database and could avoid running into customer support/warranty issues with the ILS vendor. In this application architecture, the ILS API acts as middleware to relay requests to the database, and this is acceptable use of the system in the eyes of the ILS vendor.

Within Symphony, we are able to view the logged transactions for the following operations: create reservation, delete reservation, and modify reservation. We captured those lines of code and fed them back to the Symphony API server. Those captured lines were analyzed, abstracted and turned into parameters to be used as templates in a custom Perl module we created, which we called Symdrive. The following code snippet shows the class method function for adding a booking record via the Symphony API server. This module is one of the key components of the Web APIs for moving reservation transaction data back and forth between Booked and the ILS. It can take dates, room IDs, reservations IDs, user IDs, and generate corresponding transaction lines which are fed into the Symphony API server in real time to create, delete or update reservations in the ILS. Based on the status of the code returned from the Symphony API server, the Web APIs set request status to 0 (success) or 1 (failure) in returned JSON messages. Although we don’t run any operations directly with the ILS’ underlying Oracle database, we do run read only SQLplus queries in order to achieve the quickest query result with the simplest coding logic. We are able to do this because read is not an intrusive operation.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24 | `sub symAddBk {`  `my ``$err_code``=0;#0- success, 1- failure.`  `my (``$self``,%val)=@_;`  `my ``$userid``=``$val``{``'USERID'``};`  `my ``$start_time``=``$val``{``'START_TIME'``};`  `my ``$end_time``=``$val``{``'END_TIME'``};`  `my ``$cat_key``=``$val``{``'CAT_KEY'``};#system number of a room key record`  `my ``$itemid``=``$val``{``'ITEMID'``};#barcode of a room key`  `my ``$resvdsk``=``$val``{``'RESVDSK'``};`  `#The following two lines are mystified to observe code IP of the ILS vendor`  `my ``$apiline1``=``'...$userid...$start_time...$end_time...$cat_key...$itemid...$resvdsk...'``;`  `my ``$apiline2``=``'...$userid...$cat_key...$itemid...$start_time...$end_time...$start_time...$end_time...$resvdsk...'``;`  `my ``$apistmt``=``'echo -e "'``.``$apiline1``.``' \n '``. ``$apiline2``.``'"\|...sent to Symphony API server'``;#the last part of the pipe is also mystified`  `open(API_RESULT,``"$apistmt 2&gt;&amp;1 1&gt;/dev/null \|"``) ``or` `die` `"Can't run '$apistmt'\n$!\n"``;#Only output standard error`  `while``()`  `{`  `chomp ``$_``;`  `if` `(``$_``=~ /\s+2\s+\$\(1463/)`  `{`  `$err_code``=1;`  `}`  `}`  `return` `$err_code``;`  `}` |
| --- | --- | --- | --- |

## The Web Application Interface – Booked

Fondren Library’s room reservation system is based on the open source Booked software. The original software’s code has been customized to allow for synchronization and integration with SirsiDynix’s Symphony ILS. The systems use two way communications to send reservation information that is made through the web interface to the ILS. Anytime a user creates, edits or deletes a reservation via the web interface, the custom code built into the system sends reservation information (reservation begin/end time, user ID, and study room number) to Symphony via a custom built reservation API. When this reservation is made, both Booked and Symphony validate the reservation request. All general validation processes such as maximum time duration, duplicated reservation, maximum quota per user, or room availability at requested time are performed upfront by the web system (Booked). Once the general validations are passed by Booked, the reservation request is sent to the Symphony system for further validation such as a user’s ability to create a booking based on a qualifying user profile or status, library open/close time, or a room’s availability. If all these condition are met, the ILS creates the reservation which includes a booking confirmation number. This booking confirmation number is valid in both Booked and the ILS and once it is created it will be passed back to the online reservation system.

## Data Synchronization Schema

There are two major synchronization processes as shown below. One is writing ILS data into the room reservation system (Booked) database, and another is vice versa writing reservation data into the ILS system.

### From ILS to Room Reservation System

The following data will be synced from ILS to Room Reservations:

- Reservations made directly via ILS system
- Edited/Deleted reservation directly via ILS system
- Room key checkout data
- Released room key data from checkout
- Released room key data from non-checkout after specified period of time

### From Room Reservation System to ILS

The f ollowing data will be synced from Room Reservations to ILS:

- Reservations made via Room Reservation System
- Edited/Deleted reservation via Room Reservation System

[![Diagram of Synchroization Process](https://journal.code4lib.org/media/issue41/galvin/figure2x500.jpg)](https://journal.code4lib.org/media/issue41/galvin/figure2.jpg)  
**Figure 2.** Flow Chart for Data Synchronization Overview.

## Data Synchronization and the Booking ID

The booking ID is a concept which exists in the Symphony ILS. For every reservation made, a unique booking ID is created. A synchronization script on the Booked server requests data from the ILS via the Restful API, and returns data from the ILS in the form of JSON metadata. The booking ID is the functional key between the two systems. If a reservation comes from the ILS to Booked with no booking ID the script recognizes the reservation as newly made and creates it. If a reservation has a booking ID that already exists in the database, the script compares the beginning and ending time of the reservation. If the beginning and ending times are different from the existing reservation, the script recognizes the reservations as an edit. If the booking ID only exists in the room reservation system database, but not in the ILS system, the script recognize this as a deleted reservation.

```
For (begin of metadata data from ILS) Until (end of metadata from ILS) {

     If (reservation in ILS does NOT exist in the room reservation system database){
          Insert the reservation into room reservation system
     }
     Else if (reservation in ILS exist in the room reservation system database) {

          If (begin & end time is different){
               Edit the reservation begin and end time in the system database
          }
     }
}
```

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86 | `foreach` `(``$booking` `as` `$key` `=&gt; ``$value``)`  `{`  `$key_id` `= ``$value``[``'keyid'``];`  `$bk_id` `= ``$value``[``'bkgid'``];`  `$date_start` `= ``date``(``'Y-m-d H:i:s'``,(``strtotime``(``$value``[``'begtime'``]) + ``$dst_adjust``));`  `$date_end` `= ``date``(``'Y-m-d H:i:s'``,(``strtotime``(``$value``[``'endtime'``]) + ``$dst_adjust``));`  `$query` `= "Select res.*, rev.*, inst.* From resources AS res , reservation_resources AS rev ,`  `reservation_instances AS inst Where res.resource_id = rev.resource_id AND inst.series_id =`  `rev.series_id AND inst.reference_number = ``'".$bk_id."'``";`  `$result` `= mysql_query(``$query``);`  `$row_length` `= mysql_num_rows(``$result``);`  `$sync_run` `= false;`  `if``(``$row` `= mysql_fetch_array(``$result``)){`  `$ref_query` `= "Select inst.*, series.* From reservation_instances AS inst,`  `reservation_series AS series Where inst.series_id = series.series_id AND`  `reference_number = ``'".$value['``bkgid``']."'``";`  `$ref_result` `= mysql_query(``$ref_query``);`  `if``(``$ref_row` `= mysql_fetch_array(``$ref_result``)){`  `$bgt_time` `= ``$row``[``'start_date'``];`  `$end_time` `= ``$row``[``'end_date'``];`  `$status_id` `= ``$ref_row``[``'status_id'``];`  `if``(``$date_start` `!= ``$bgt_time` `\|\| ``$date_end` `!= ``$end_time` `\|\| ``$status_id` `== 2){`  `$update_query` `= ``"UPDATE reservation_instances SET start_date = '"``.``$date_start``.``"', end_date = '"``.``$date_end``.``"' WHERE reference_number = '"``.``$value``['bkgid``']."'``";`  `if` `( ! @mysql_query (``$update_query``) ){`  `die` `( mysql_error() );`  `}`  `if``(``$status_id` `== 2){`  `$extra_update_query` `= ``"UPDATE reservation_series SET status_id = '1' Where series_id = "``.``$ref_row``[``'series_id'``];`  `if` `( ! @mysql_query (``$extra_update_query``) ){`  `die` `( mysql_error() );`  `}`  `}`  `}`  `}`  `else``{`  `$query_resource` `= ``"Select res.* From resources AS res Where res.room_id = "``.``$key_id``;`  `$resource_result` `= mysql_query(``$query_resource``);`  `if``(``$res_row` `= mysql_fetch_array(``$resource_result``)){`  `$username` `= ``strtolower``(``$value``[``'userid'``]);`  `$uid` `= 2;`  `$uid_query` `= ``"Select * From users where username = '"``.``$username``.``"'"``;`  `$uid_result` `= mysql_query(``$uid_query``);`  `if``(``$uid_row` `= mysql_fetch_array(``$uid_result``)){ `  `$uid` `= ``$uid_row``[``'user_id'``];`  `}`  `$create_series` `= ``"INSERT INTO reservation_series (date_created, title, description,type_id,status_id,owner_id,repeat_type,repeat_options) VALUES ('"``.``date``('Y-m-d H:i:s``',strtotime("+5 hours"))."'``,``'Reservation Desk'``,``'Reservation made by Reservation Desk'``, ``'1'``,``'1'``,'"`  `.``$uid``.``"','none','')"``;`  `mysql_query(``$create_series``);`  `$series_id` `= mysql_insert_id();`  `$res_rev_query` `= ``"INSERT INTO reservation_resources (series_id,resource_id,resource_level_id) VALUES ('"``.``$series_id``.``"','"``.``$res_row``['resource_id``']."'``,``'1'``)";`  `mysql_query(``$res_rev_query``) ``or` `die``(mysql_error());`  `$instance_query` `= "INSERT INTO reservation_instances`  `(start_date,end_date,reference_number,series_id,booking_id) VALUES`  `(``'".$date_start."'``,``'".$date_end."'``,``'".$value['``bkgid``']."'``,'" .`  `$series_id``.``"','"``.``$value``[``'bkgid'``].``"')"``;`  `mysql_query(``$instance_query``) ``or` `die``(mysql_error());`  `}`  `}` |
| --- | --- | --- | --- | --- | --- |

## Synchronizing the systems

A key checked out through the ILS is very similar to the process for reservation synchronization from the Booked system to the ILS. Comparing ILS data and room reservation system data is based on checkin and checkout time. The algorithm is as follows:

```
For (begin of metadata data from ILS) Until (end of metadata from ILS) {

     If (key checkout end time is past){
          Delete the reservation from database
     }
     Else {
          If (the room is not checked out record does not exist during the specified begin and end time){

               Insert the new checkout record in the system
          }
          elseif(the room is already checked out but with different begin and end
time)

          Edit the existing checkout record in the system
     }
}
```

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24 | `foreach` `(``$checkouts` `as` `$key` `=&gt; ``$value``){`  `$key_id` `= ``$value``[``'keyid'``];`  `$user_id` `= ``$value``[``'userid'``];`  `$checkout_id` `= ``$key_id``.``strtotime``(``$value``[``'timedue'``]).``$user_id``;`  `$date_end` `= ``date``(``'Y-m-d H:i:s'``,(``strtotime``(``$value``[``'timedue'``]) + ``$dst_adjust``));`  `$query_resource` `= ``"Select res.* From resources AS res Where res.room_id = "``.``$key_id``;`  `$resource_result` `= mysql_query(``$query_resource``);`  `if``(``strtotime``(``"Now"``) &lt; ``strtotime``(``$value``[``'timedue'``]) &amp;&amp; ``$row` `=     mysql_fetch_array(``$resource_result``)){ `  `$resource_id` `= ``$row``[``'resource_id'``]; ``$ex_query` `= ``"Select inst.*, series.*, res.* From blackout_instances AS inst , blackout_series AS series, blackout_series_resources AS res Where series.blackout_series_id = inst.blackout_series_id AND series.blackout_series_id = res.blackout_series_id AND res.resource_id = "``.``$resource_id``.``" AND inst.end_date = '"``.``$date_end``.``"'"``;     `  `$ex_result` `= mysql_query(``$ex_query``); `  `$ex_length` `= mysql_num_rows(``$ex_result``); `  `if``(``$ex_length` `== 0){ ``$create_series` `= ``"INSERT INTO blackout_series( date_created, title, description, owner_id) VALUE('"``.``date``('Y-m-dH:i:s``',strtotime("+".$conf['``settings``']['``time_delay``']." hours"))."'``,``'Checked Out'``,``'".$user_id."'``,``'2'``)"; `  `mysql_query(``$create_series``);      `  `$series_id` `= mysql_insert_id(); `  `$create_series` `= ``"INSERT INTO blackout_series_resources(blackout_series_id,resource_id) VALUES ('"``.``$series_id``.``"','"``.``$resource_id``.``"')"``; `  `mysql_query(``$create_series``); `  `$instance_query` `= ``"INSERT INTO blackout_instances(start_date,end_date,blackout_series_id) VALUES ('"``.``date``('Y-m-d H:i:s``',strtotime("+".$conf['``settings``']['``time_delay``']." hours"))."'``,``'".$date_end."'``,``'".$series_id."'``)"; `  `mysql_query(``$instance_query``) ``or` `die``(mysql_error()); `  `} `  `} `  `} ` |
| --- | --- |

## Synchronizing Reservations made in Booked to the ILS

The reverse data synchronization happens when user creates a reservation in Booked. The first validation happens in Booked and is to verify if the reservation request is valid based on library policy.

1. Reservation duration cannot exceed 4 hours
2. User can have one reservation per day
3. User can request a reservation 3 days in advance

If it passes validation, the reservation created in Booked is sent to the ILS for further validation.

1. If the user status is valid (fines, overdues, etc.)
2. If the reservation time is within the library open/close time
3. If the room is available during the requested reservation time

Once the ILS records the reservation, the API signals Booked to create it.

```
If (ILS is ready) {
     If ( the requested reservation time duration exceed 4 hr) {
          Throw Error and Stop process
     }
     Else if ( the user requesting reservation has another reservation on same day) {
          Throw Error and Stop process
     }
     Else if ( the requested reservation begin time is beyond 3 days ahead) {
          Throw Error and Stop process
     }
     If ( the reservation request is valid){
          variable if_valid = Return Send_to_ILS (reservation Record)
          If (if_valid is true){
               Proceed the room reservation process.
          }
     }
}
```

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31 | `$ILS_initiate` `= true;`  `if` `(``$startPeriod` `== null \|\| !``$startPeriod``-&gt;IsReservable() \|\|`  `!``$startPeriod``-&gt;BeginDate()-&gt;Equals(``$startDate``))`  `{`  `$errors``-&gt;AppendLine(Resources::GetInstance()-&gt;GetString(``'InvalidStartSlot'``));`  `$ILS_initiate` `= false;`  `}`  `if` `(``$begin_date` `&lt; ``$current``)`  `{`  `$errors``-&gt;AppendLine(Resources::GetInstance()-&gt;GetString(``'PastTime'``));`  `$ILS_initiate` `= false;`  `}`  `if` `(``strtotime``(``$begin_date``) &gt; ``strtotime``(``$three_day_ahead``))`  `{`  `$errors``-&gt;AppendLine(Resources::GetInstance()-&gt;GetString(``'ThreeDays'``));`  `$ILS_initiate` `= false;`  `}`  `if` `(``$endPeriod` `== null \|\| !``$endPeriod``-&gt;BeginDate()-&gt;Equals(``$endDate``))`  `{`  `$errors``-&gt;AppendLine(Resources::GetInstance()-&gt;GetString(``'InvalidEndSlot'``));`  `$ILS_initiate` `= false;`  `}`  `if` `(``$user_has_reserv``){`  `$errors``-&gt;AppendLine(Resources::GetInstance()-&gt;GetString(``'UserHasReservation'``));`  `$ILS_initiate` `= false;`  `}` |
| --- | --- | --- | --- | --- | --- | --- | --- |

## Blackouts and Checkouts

The initial concept of blackout times in the original Booked software has been modified so it also can represent when a key is checked out in the ILS system. The Booked systems queries the ILS for both reservations and checkouts. When a user makes a reservation, the system marks the cell as reserved. The reservation can still be modified or deleted by the reservation owner or an administrator. Once a user checks out the key, the system blocks the room for the duration of the reservation. At this point, the room is considered occupied and is blocked. From time to time rooms need to be made inaccessible for reservation for various reasons such as renovations, repairs or events. It is easier to block the rooms in Booked than it is in the ILS.

[![Screenshot of blackouts and reservations in Booked](https://journal.code4lib.org/media/issue41/galvin/figure3x500.png)](https://journal.code4lib.org/media/issue41/galvin/figure3.png)  
**Figure 3.** Sample Scheduling Interface; blackouts and checkouts.

## Automatically Delete Reservations

By policy, reservations are forfeit if they are not picked up within 30 minutes of the start of their reservation time, and this is where having integrated systems is a plus. The Booked system automatically deletes the reservation in both the ILS and the room reservation system if thirty minutes have passed and the key has not been checked out. This function is enacted through user-driven events. When a user opens the Booked schedule page, a script runs that deletes all reservations that are greater than 30 minutes if they have not been checked out. Once this is complete, the schedule is shown. This is far more efficient than having staff members remove reservations which have exceeded their pickup time.

## Conclusion

In an ideal world there would be no need to develop such a complex system to place reservations on materials which have future use needs. The tools libraries use to manage these collections should have graphical interfaces that allow patrons to easily determine future availability across all or selected resources (rooms) and dates. Unfortunately at this time no such tools exist. Libraries’ services have shifted over the past 20 years, but the tools that we use to manage them have not kept up. We have seen a decline in the checkout of physical materials like books, but that has been supplanted by a surge in the usage of our space and equipment. Many libraries seem to take a hands-off approach to how these materials are used, leaving rooms unlocked and offering a first come, first serve approach to equipment checkout, but that is probably because we don’t have tools that would help us manage these collections. There is a need for systems that have graphical interfaces which offer our customers detailed information about current and future availability of items/spaces and allow them to make reservations on those resources. It would be better and more efficient to have systems that were created specifically for this task rather than write complex code that has to be maintained and updated. That said, we have shown that it can be done. Over the course of four years we have had over 100,000 reservations made and fulfilled through these two systems. It is better to manage a reservation system through an online calendar which is backed by an ILS.

## Bibliography

\[[1](https://journal.code4lib.org/articles/#ref1)\] Faust, B. D., Hafner, A. W., & Seaton, R. L. (2010). OpenRoom: Making Room Reservation Easy for Students and Faculty. The Code4Lib Journal, (10). Retrieved from [http://journal.code4lib.org/articles/2941](https://journal.code4lib.org/articles/2941)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Doherty, M., & White, E. (2012). Room reservations at VCU Libraries: How we coped with rapid growth and overwhelming demand for student study space. College & Research Libraries News, 73(3), 142-146. Retrieved from [https://doi.org/10.5860/crln.73.3.8722](https://doi.org/10.5860/crln.73.3.8722)

\[[3](https://journal.code4lib.org/articles/#ref3)\] Sallans, A., Soule, K., & Gilbert, J. (2010). Selecting and implementing a patron-driven resource reservation system. Library Hi Tech News, 27(8), 5-6. [https://doi.org/10.1108/07419051011104222](https://doi.org/10.1108/07419051011104222)

\[[4](https://journal.code4lib.org/articles/#ref4)\] Williams, D. J., & Hada, K. (2017). The Best Tool for the Job: Revisiting an Open Source Library Project. D-Lib Magazine, 23(7/8). [https://doi.org/10.1045/july2017-williams](https://doi.org/10.1045/july2017-williams)

\[[5](https://journal.code4lib.org/articles/#ref5)\]\[[7](https://journal.code4lib.org/articles/#ref7)\] Hohpe, G., & Woolf, B. (2004). Enterprise integration patterns: Designing, building, and deploying messaging solutions. Boston: Addison-Wesley.

\[[6](https://journal.code4lib.org/articles/#ref6)\] Humphrey, P. (2017, April 26). Understanding When to use RabbitMQ or Apache Kafka. Retrieved from [https://content.pivotal.io/blog/understanding-when-to-use-rabbitmq-or-apache-kafka](https://content.pivotal.io/blog/understanding-when-to-use-rabbitmq-or-apache-kafka)

\[[8](https://journal.code4lib.org/articles/#ref8)\] Ed-douibi, H. (2016, January 2). Modeling Web APIs: your best choices. Retrieved from [https://modeling-languages.com/modeling-web-api-comparing/](https://modeling-languages.com/modeling-web-api-comparing/)

Denis Galvin ([dgalvin@rice.edu](https://journal.code4lib.org/articles/)) is Director of Library Technology for Rice University. He has worked with systems in academic libraries for 17 years. Prior to working at Rice he worked for Carnegie Mellon University.

Mang Sun ([ms20@rice.edu](https://journal.code4lib.org/articles/)) works for Fondren library at Rice University where he is the systems librarian. His main job duties include administering several library systems including the ILS system and developing in house applications and solutions when needed. Prior to Rice he worked for Saskatchewan Provincial Library in Canada as a systems librarian (information resources specialist). His research interests cover a wide spectrum of library and IT technologies. He got his MLIS degree from Dalhousie University in 2006.

Hanjun Lee ([hanjun.lee@rice.edu](https://journal.code4lib.org/articles/)) works for Fondren Library at Rice University where he is the Library Web Application Developer. He has developed many library related web applications using various open source software and has integrated web based software to the ILS and various commercial web platforms. Prior to Rice he worked for Online Dakota Information System as a web application developer. His current interests are mobile based application development and integration of various web platforms into unified library web & mobile applications.
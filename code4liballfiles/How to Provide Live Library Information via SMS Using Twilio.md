---
title: "How to Provide Live Library Information via SMS Using Twilio"
source: "https://journal.code4lib.org/articles/5542"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-07-25
created: 2025-01-10
description: "Paul Smith’s College provides library hours and workstation availability using SMS Text Messages. The service was implemented using an easy and affordable web-based API for SMS sending and receiving, from twilio.com. A new class of ‘cloud-based‘ SMS vendors make simple SMS-based services efficient and cost-effective to implement, and have many possible applications in the library [...]"
tags:
  - "clippings"
---
# How to Provide Live Library Information via SMS Using Twilio
Mike Beccaria

Paul Smith’s College provides library hours and workstation availability using SMS Text Messages. The service was implemented using an easy and affordable web-based API for SMS sending and receiving, from twilio.com. A new class of ‘cloud-based‘ SMS vendors make simple SMS-based services efficient and cost-effective to implement, and have many possible applications in the library environment. A simple PHP example is provided which supplies workstation availability over SMS based on a database of computer availability from a previous Code4Lib Journal Article.

## The Problem

Paul Smith’s College is a very small (~1,000 FTE) 4-year private college nestled in the Adirondack Park in northern New York. This past year we were fortunate to have record breaking enrollment numbers, but with the added number of students there was added demand. Subjectively, the library staff observed that computers were being used a lot more often and in greater numbers than previous years. Small surveys and feedback gave indications that students were having trouble finding computers at peak usage times and our usage data largely confirmed these findings.

To start to tackle this problem during this budget cycle, we developed a live computer availability map on our website using Kim Griggs’ Code4lib article “How to Build a Computer Availability Map” as a template ([Griggs, 2010](https://journal.code4lib.org/articles/#griggs2010)) with long term plans to add a few more computer terminals to the library, as well as an information kiosk with the computer availability map on it. We decided to supplement the computer availability map with a text messaging service that would allow students to receive computer availability information on their mobile devices.

## The Solution: SMS Cloud Services

SMS, or Simple Message Service, is the means by which common text messages are sent via mobile devices. For our text message solution, we decided to use a 3rd party provider that bridges the gap between web services and telecom. We had several choices. Twilio, Tropo, and SMSified, as well as others who provide cloud-based web service API’s that enable users to build applications to leverage voice and SMS communications. These companies specifically provide customers with a phone number and a web based API that allows developers to control telecommunication programmatically. For example, using these services makes it possible to create an automated text reply service so that if someone sends a text message or phone call to a phone number that I lease from Twilio (the provider we used), I can programmatically reply to the text with customized information.

Before cloud-based service providers like Twilio and Tropo arrived, developing applications that use SMS and voice communications were both cost and technologically prohibitive, requiring users to learn a telecom programming language or set up their own PBX service. In contrast, cloud-based vendors like Twilio and Tropo use common and easy to program web APIs.  Both services charge users a small monthly fee for a dedicated phone number and an affordable pay-per-use pricing model that most people could pay for using the money they spent on a coffee and bagel for breakfast. Twilio, for example, currently charges $1/month for a phone number and between 1 and 2 cents per text message or minute of phone voice time ([http://www.twilio.com/pricing/](http://www.twilio.com/pricing/)).

## What We Did

To complement our computer availability map and help students find available computers via text messaging, we created library SMS services using Twilio. When researching companies for a solution, we found that many of them were about the same price and offered similar functionality, and we ultimately chose to use Twilio because that was the company that we signed up for and tested first. Students are now able to send a text message to our dedicated SMS phone number that we lease from Twilio and receive a text message back with useful information (see Figure 1). We expanded our services beyond computer availability and provided the means to get other kinds of information. Students can send “PC” for computer availability, “laptop” for lending laptop availability and “hours” for the library hours. Modeled after Google’s SMS search application, if they send a blank message or a message that isn’t a command, they will receive a text message with instructions on how to use the service.

[![](https://journal.code4lib.org/wp-content/uploads/2011/07/figure_1_high_quality-190x300.jpg "figure_1_high_quality")](https://journal.code4lib.org/wp-content/uploads/2011/07/figure_1_high_quality.jpg)

**Figure 1:** Using text messaging to get computer availability in the Paul Smith’s College library.

## How to Make Your Own Computer Availability SMS Service

To create the service, we started with the database structure that we had in place for our computer availability map (see [Griggs, 2010](https://journal.code4lib.org/articles/#griggs2010)). Once we had the back-end architecture in place and a database that had live computer availability data, we were ready to create a PHP script to leverage Twilio services.

When our Twilio phone number receives a text message, Twilio sends an http requests with POST variables about the text message or call information (caller Id, geography, the body of the text message, etc.) to our server (see Twilio’s API documentation [http://www.twilio.com/docs/index](http://www.twilio.com/docs/index)). When our server receives the http request, we process the variables and, depending on the data found in them, send an XML response back to Twilio with our text message response data.

While Twilio also provides many other voice and text services including text-to-speech, voicemail transcriptions, automated calling, teleconferencing, and business platform phone services, we are only leveraging the SMS text services for our solution. Down the road we may wish to add functionality to our services, but for now we are keeping it simple.

Our solution is straightforward and easy. We placed a single PHP file on our server that is designed to process our text message requests from Twilio. When a request comes in, we determine what we want to send back to the patron. For example, if “hours” or “help” is texted to us, we simply output xml that Twilio can read to send a response back. Here is a slightly modified portion of our file that processes the “hours” text message:

| 1  2  3  4  5 | `<?php ``if` `(``strtolower``(``substr``(``$_REQUEST``&#91;``'Body'``&#93;,0,4)) == ``'hour'` `){ ?>`  `<Response>`  `<Sms><?php ``echo` `"PSC Library Hours:\r\nFall and Spring Semester:\r\nM-Th 7:30AM-10PM\r\nF 7:30AM-6PM\r\nSa 10AM-6PM\r\nSun 1PM-10PM\r\nSummer:\r\nM-Th 8AM-7PM\r\nF 8AM-4:30PM\r\nSa 10AM-3PM"``?>`  `</Sms>`  `</Response>` |
| --- | --- |

The if statement checks if the first four characters of the text body equals “hour” in upper or lower case. If that is true, it outputs an XML response that looks like this:

| 1  2  3  4  5 | `<``Response``>`  `<``Sms``>PSC Library Hours: Fall and Spring Semester: M-Th`  `7:30AM-10PM F 7:30AM-6PM Sa 10AM-6PM Sun 1PM-10PM Summer: M-Th`  `8AM-7PM F 8AM-4:30PM Sa 10AM-3PM</``Sms``>`  `</``Response``>` |
| --- | --- |

The XML used in this example is a standard developed by Twilio (what they call “Twiml”) and it tells Twilio to send back a text message response to the patron. The “<Response>” XML element is the root element for Twiml. Under the root “<Response>” element, Twilio then accepts “verb” and “noun” elements that allow the developer to let Twilio know what to do. As is the case in our example, the “<SMS>” verb element lets Twilio know to send an SMS response back to the phone that sent the message.

Other verbs (mostly used in voice based solutions) include “<Say>” which reads text to the caller, “<Play>” which plays an audio file, “<Record>” which records a call, “<Gather>” which is used to get the digits a caller presses, and “<Dial>” which calls a number for a conference call.

Notice that PHP was used to echo the response for the library hours. This was done so that carriage returns could be added to the text message (in the code as “\\r\\n” which stands for carriage return newline in PHP).

This example solution is very similar for our two other services (computer availability and laptop availability) except in those solutions we use PHP to gather computer and laptop availability data and send that information to patron. Pasted below is a modified version of our sms\_services.php script which determines what the body of the incoming text message from the patron says, and then sends back pc availability, hours, or help depending on the body of the text message sent by the patron. You will have to alter the code for your particular solution depending on how you store computer availability, but the key is to send out Twiml (Twilio XML) to let Twilio know what to send back to the patron.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47 | `<?php`  `header(``"content-type: text/xml"``);`  `echo` `"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"``;`  `#If the student texts ``"pc"``, get the pc availability of the library computers ``and` `respond back`  `if` `(``strtolower``(``substr``(``$_REQUEST``[``'Body'``],0,2)) == ``'pc'``){`  `#database user credentials`  `$user` `= ``""``;`  `$password` `= ``""``;`  `$database` `= ``""``;`  `$host` `= ``""``;`  `#connect to the database`  `$DB` `= mysql_connect(``$host``, ``$user``, ``$password``) ``or` `die``(``"Can't connect to database."``);`  `@mysql_select_db(``$database``) ``or` `die``(``"Unable to select database"``);`  `#create the queries to gather computer availability both upstairs ``and` `downstairs.`  `$total_pc_upstairs_results` `= mysql_query(``"SELECT * FROM compstatus WHERE (location_group = 'UPSTAIRS') AND (computer_type='PC') AND (status = '1' OR status = '0') "``);`  `$avail_pc_upstairs_results` `= mysql_query(``"SELECT * FROM compstatus WHERE status='0' AND computer_type='PC' AND location_group = 'UPSTAIRS'"``);`  `$total_pc_downstairs_results` `= mysql_query(``"SELECT * FROM compstatus WHERE (location_group = 'DOWNSTAIRS') AND (computer_type='PC') AND (status = '1' OR status = '0') "``);`  `$avail_pc_downstairs_results` `= mysql_query(``"SELECT * FROM compstatus WHERE status='0' AND computer_type='PC' AND location_group = 'DOWNSTAIRS'"``);`  `#Run the queries ``and` `create the output strings`  `$upstairs_pcs` `= mysql_num_rows(``$avail_pc_upstairs_results``) . ``' of '` `. mysql_num_rows(``$total_pc_upstairs_results``) . ``" pc's available upstairs."``;`  `$downstairs_pcs` `= mysql_num_rows(``$avail_pc_downstairs_results``) . ``' of '` `. mysql_num_rows(``$total_pc_downstairs_results``) . ``" pc's available downstairs."``;`  `mysql_close(``$DB``);`  `#send the response`  `?>`  `<Response>`  `<Sms><?php ``echo` `"PSC Library Computers\r\n"` `. ``$downstairs_pcs` `. ``" \r\n"` `. ``$upstairs_pcs``; ?></Sms>`  `</Response>`  `<?php`  `#``if` `the student texts ``"hour"` `send back library hours`  `} ``elseif` `(``strtolower``(``substr``(``$_REQUEST``&#91;``'Body'``&#93;,0,4)) == ``'hour'` `){`  `?>`  `<Response>`  `<Sms><?php ``echo` `"PSC Library Hours:\r\nFall and Spring Semester:\r\nM-Th 7:30AM-10PM\r\nF 7:30AM-6PM\r\nSa 10AM-6PM\r\nSun 1PM-10PM\r\nSummer:\r\nM-Th 8AM-7PM\r\nF 8AM-4:30PM\r\nSa 10AM-3PM"``?></Sms>`  `</Response>`  `<?php`  `} ``else` `{`  `#``if` `it doesn't recognize a message, send directions.`  `?>`  `<Response>`  `<Sms><?php ``echo` `"PSC text services:\r\ntext \"pc\" for library pc availability\r\n\"laptop\" for library laptop availability\r\n\"hours\" for our hours\r\n"``;?> </Sms>`  `</Response>`  `<?php }?>` |
| --- | --- |

## Early Findings

Overall we have been very happy with the use and acceptance of this service. After creating the service and doing some simple tests, we decided to give it a soft opening by posting the service to our library Facebook page (see [http://www.facebook.com/psclibrary](http://www.facebook.com/psclibrary)) and library news page. Once the bugs and tweaks were ironed out, we followed up with a campus wide email. Our soft opening on Facebook ran for about 25 days between March 3rd and March 27th. During that time we received 31 text requests. On March 28th I sent out a mass email to the campus (see Figure 2). From March 28th through the end of the semester, May 15th (48 days) we received 496 text requests, an average of 10 requests per day. For a college of our size (~1,000 FTE) we were very pleased with these numbers.

When we started the service, Twilio was charging a very affordable $0.02 per text message each way. Since the inception of the service in late February we spent a meager $25 this semester. In May they dropped their SMS service to $0.01 each so the service is now less expensive (see Twilio pricing at [http://www.twilio.com/pricing/](http://www.twilio.com/pricing/)).

[![](https://journal.code4lib.org/wp-content/uploads/2011/07/figure_2_high_quality-300x252.jpg "figure_2_high_quality")](https://journal.code4lib.org/wp-content/uploads/2011/07/figure_2_high_quality.jpg)

**Figure 2:** Email Message to Campus Community

## Future Possibilities

With the advent of telecommunication services like Twilio, there are many innovative service opportunities that libraries can create easily and inexpensively. I consider our solution to be a drop in the bucket compared to the possibilities that exist. Libraries can create customized reference chat services or create an SMS search application that searches the library catalog or voice/text applications that allow patrons to renew books or pay fines. At Paul Smith’s College, we will continue to monitor usage and demand to determine if future applications using mobile SMS and voice services will be beneficial to our patrons and whether or not we have the resources to create those applications.

## Conclusion

It has been said that “If we don’t care for our customers, someone else will.” Libraries need to continue to reach out to patrons in places where they gather, whether in be in physical or virtual spaces, or our patron’s attention and loyalty will diminish and the valuable resources we provide will be overshadowed by others who have taken to time to care for our customers better than us. Libraries have a history of changing with the technological tide to remain relevant to our patrons and using 3rd party telecommunications services like Twilio aren’t necessarily game changers in our collection of services, but they’re a piece in the puzzle towards showing our patrons that we care.

## References

Griggs, K. (2010 Dec 21). How to build a computer availability map. Code4lib Journal \[Internet\]. \[cited 2011 May 24\]; 12. Available from [http://journal.code4lib.org/articles/4067](https://journal.code4lib.org/articles/4067)

## Additional Links

- Google SMS Applications: [http://www.google.com/mobile/sms/](http://www.google.com/mobile/sms/)
- Mosio: [http://www.mosio.com](http://www.mosio.com/)
- Twilio: [http://www.twilio.com/](http://www.twilio.com/)
- Tropo: [http://www.tropo.com/](http://www.tropo.com/)
- Smsified: [http://www.smsified.com/](http://www.smsified.com/)

## About the Author

Mike Beccaria is the Systems Librarian and Head of Digital Initiatives at Paul Smith’s College, a small baccalaureate institution located in the Adirondack Park in Northern New York. He can be contacted at mbeccaria at paulsmiths edu.
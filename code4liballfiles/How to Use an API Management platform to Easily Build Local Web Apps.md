---
title: "How to Use an API Management platform to Easily Build Local Web Apps"
source: "https://journal.code4lib.org/articles/15190"
author:
  - "[[The Code4Lib Journal]]"
published: 2020-05-11
created: 2025-01-10
description: "Setting up an API management platform like DreamFactory can open up a lot of possibilities for potential projects within your library. With an automatically generated restful API, the University Libraries at Virginia Tech have been able to create applications for gathering walk-in data and reference questions, public polling apps, feedback systems for service points, data [...]"
tags:
  - "clippings"
---
# How to Use an API Management platform to Easily Build Local Web Apps
Jonathan Bradley

Setting up an API management platform like DreamFactory can open up a lot of possibilities for potential projects within your library. With an automatically generated restful API, the University Libraries at Virginia Tech have been able to create applications for gathering walk-in data and reference questions, public polling apps, feedback systems for service points, data dashboards and more. This article will describe what an API management platform is, why you might want one, and the types of potential projects that can quickly be put together by your local web developer.

## Introduction

One of the most time-consuming elements in creating a new web project can be coding the API for data interaction, especially if the overall goal is that the application will be able to interface with other web apps at your library or feed into a central data collection mechanism. Ensuring the API is secured for usage and has all the needed functionality and endpoints can   often be more work and maintenance than the app itself. This is where an API management platform can help save you some time and effort.

When I was originally hired at the University Libraries at Virginia Tech, I was hired as a Web Application Developer. My job has since changed to include overseeing many of the innovative technology spaces in the building, and as an extension of that job, I create web apps that help gather data about usage, patron engagement, patron feedback, and apps that display visualizations and analysis of the collected data. But since web development is no longer the primary function of my job, these apps have to be created quickly and be easily maintained, which is helped tremendously by an API management platform.

At its core, an API management platform is a piece of software, generally with a Graphical User Interface and hosted on a server, that allows for easy management of API endpoints. There are multiple API management platforms available, including [Apigee](https://cloud.google.com/apigee), [Mulesoft](https://www.mulesoft.com/platform/enterprise-integration), and those provided by many of the major cloud hosting services (AWS, Microsoft, etc.), but this article will primarily focus on [DreamFactory](https://www.dreamfactory.com/), which is what has been used for the projects discussed here. DreamFactory is open source, though that fact is not as heavily emphasized on their site as it used to be, and their code is available on [Github](https://github.com/dreamfactorysoftware/dreamfactory). They operate like many other open source projects on a software-as-a-service (SaaS) model, offering hosting solutions, some advanced functionality, and enterprise-grade support for those who do not wish to self-host the software. DreamFactory can be installed on a LAMP stack (Linux, Apace, MySQL, PHP), though the software can take advantage of other available tools, such as [Node.js](https://nodejs.org/en/), for tasks such as custom scripting for API responses if such tools are also available on the hosting server. The software comes with a [well-documented installation process](https://wiki.dreamfactory.com/DreamFactory/Installation) for manual installation, but also includes a [Bitnami installer](https://bitnami.com/stack/dreamfactory/installer#linux), [Docker image](https://github.com/dreamfactorysoftware/df-docker/), and guides for installing on cloud server providers such as AWS or Azure. Once installed either on on-premise hosting or in the cloud, you’ll have access to DreamFactory’s web interface, where you’ll be able to start controlling your APIs.

## DreamFactory Web Interface

Once you have logged into the web interface with the admin username and password you created during the installation process (or that was generated for you by Bitnami or similar methods), you’ll notice that there are a lot of tabs with a lot of options. Below is a description of the tabs by importance and a short description of what you’ll use each one for.

## Services

A service in DreamFactory is generally going to be data storage, file storage, or email services that you will tie to a specific API. When you create a service, you choose the type, and you can link to many different types of databases, including ones locally stored on the server in something like MySQL or Postgresql, or tie it to cloud services like AWS RDS. You can also do local file storage or external storage provided in the cloud and tie it to SMTP (Simple Mail Transfer Protocol) services either locally or from places like Railgun to automate outgoing emails from apps as well. In the interface, you name the service, tell DreamFactory where it is located and how to authorize use of the service if it is secured, and it will automatically generate an API on top of the service.

DreamFactory generates a full REST API with interactive ‘[Swagger](https://swagger.io/docs/)’ documentation to go along with it. In the case of data storage, you can create new tables and fields and define the schema within the DreamFactory web interface, or you can directly use the API to create and manage such structures, which can be very beneficial for creating development and production instances or creating new instances of similar web apps.

## Roles

After DreamFactory has generated your API, you’ll want to create a set of permissions on how it is accessed. Roles in DreamFactory are a set of permissions on one or more services. The options provided for this creation process are very nuanced, meaning you might grant wide ranging permission (full control of all databases and tables on the system) down to very narrow (read-only permission on a single table of a single database). The process of creation starts by   choosing which services the role will have access to, then which sub elements of the service the role can have permission on (so for a database, specific tables or access to control the schema of the database itself), and finally what level of control the role has over those elements, which is defined using the standard HTTP request verbs GET, POST, PUT/PATCH, and DELETE. For example, you might define a role that has GET and POST permission on a table in a database, and also grant it access on an email service to send emails when new records are created.

You can define as many of these roles as needed and activate and deactivate them as you see fit if you want to take certain apps offline for any reason. These roles are what you will assign to both users in the system, granting people the ability to login to the DreamFactory web interface and manage parts of the application themselves, and to applications, which will define what they have access to. As with all good security practice, it is a good idea to only give a user or application access to the bare minimum it needs to function, and luckily that is easy to do within DreamFactory.

## Apps

The Apps section in DreamFactory is where you will define a new app by naming it and assigning a role to it. Once created, DreamFactory will generate an API key for the app that you can use in your HTTP requests to gain access to the services you need for that app. It is best to think of an app as an entry point into your services, and you may actually end up having multiple “apps” in DreamFactory for one forward facing application, depending on who and how many users will interact with that interface. If a small set of users might access it one way and need more permissions, but a second set needs fewer permissions, you would likely want to create two roles with the varied permissions and two apps to provide that access for different audiences.

## Users

The Users tab allows you to add new users to your DreamFactory instance and assign them a set of permissions that they can use in the system. This section contains one of the biggest frustration points for DreamFactory in how it handles permissions differently. In the Roles section, you will define all the services and elements that one should have access to if they have the role. In the user creation section, you will define a role for that user, but you’ll define it for each service. There is a disconnect between the fact that you have assigned multiple sets of permissions under roles, but if you don’t assign the same role to each service, that may not carry over into the permissions a user has. It is a frustration point in that it often requires going back in and updating each set of permissions when you get a new user setup, and while the intended purpose seems to allow even greater nuance to access permissions, the process is not intuitive and usually requires a lot of back and forth to make sure an individual user gets the permissions you are trying to assign them.

## API Docs

The API Docs tab will lead you to the automatically generated documentation for the APIs you have created. Once you choose a service, you can see all the endpoints associated with that service, get full details on what the response will look like and what a request against the endpoint should include. You can also test out the API endpoint by defining queries, sorting, filtering, and other details and running the request to see what the response would be. When testing, the system provides a ‘curl’ command to allow you to copy and paste the request onto another system in case you need to test in a specific environment that may be behind a firewall or other network-limited context.

## Schema

This section of the DreamFactory web interface allows you to define the schema for a database, including creating new tables and defining fields. You have the option to create new tables and fields using a standard set of form questions, similar to many other GUI-based database management web apps, or simply upload a JSON data schema for the database. This latter option is particularly useful for creating pre-production and production copies of a database schema or copying a schema to a similar service, and with scripting you can automate the creation, management, or deletion of tables and fields within your web app or maintenance workflow. The Schema section of the DreamFactory web interface also allows you to view a JSON definition of the current database, providing more shortcuts toward automation.

## Data

The Data section, as the name suggests, allows a user to view, edit, and delete any records in a service that they have sufficient permissions to interact with. This is useful for quickly checking to see if records are being added as expected, but is also a good mechanism for allowing non-technically inclined colleagues access to data records that they can view and query in a web interface.

## Files

Like the Data section, the Files tab grants access to any file storage to a user who has sufficient permissions to access it. This can offer a quick way to sort through files that have been stored on the system to check to make sure everything in your app is functioning as expected.

## Scripts

The Scripts section is likely the most dense of the tabs in the DreamFactory web interface, and many users will not need to go here. This section allows for a programmer to augment an API endpoint, either before the request comes in or after it leaves to perform some additional or alternative function depending on the request. These scripts can be written in multiple languages, though some like Node.js and Python require that the requisite software be installed on the DreamFactory server and configured to be accessible from the DreamFactory runtime. There are multiple examples on the DreamFactory site of ways that this might be useful, but it might not end up being heavily utilized unless you need a lot of customization.

As an example of how it could be helpful, I used the scripts section to add an additional level of linked data to specific types of requests. DreamFactory already allows “relational queries” where related sets of data can pull their relations into their responses and nest them in the JSON response, but generally this only goes one nesting deep. For our Data Dashboard project, I needed an additional layer of depth, and was able to augment the response using Javascript code to include that data and filter out all of the unneeded data to keep the JSON response small in size.

## Config

This tab has multiple subsections, but the most important are Cache, CORS, and Email Templates. The Cache will let you clear the system’s cache, which I find I have to do often if I am dropping and recreating tables frequently using the API, as sometimes the system will register that the table still exists even though it no longer appears in the definitions. CORS is where you will change your CORS (Cross Origin Resource Sharing) settings unless you plan to run all your applications off the same server the DreamFactory is running off of, which would limit the flexibility provided by having an easily accessible, automatically generating API platform. Finally, the email templates will allow you to visually construct emails for any SMTP service you have setup, meaning you can call a template with an API request instead of providing the entire content of the email programmatically.

## Packages

This tab allows admins to back up the data contained in your services or the service definitions themselves. This is good for migrating an installation to another server and creating backups of the information in your DreamFactory instance.

## Limits

The final tab controls access limits in case you want to control an app’s access rate to prevent overburdening your server during peak usage. As a note, you need to have a paid instance of DreamFactory to use this service.

## Potential Use Cases

## 3D Printing Queue

One of the first projects making extensive use of our DreamFactory instance was the queueing app for our 3D Design Studio, where we offer free 3D printing services for the community. When the studio first opened, we had no queuing system other than writing down people’s information on paper, which quickly grew unwieldy and people’s work began to fall through the cracks. We also quickly realized that we weren’t gathering good metrics on usage; our machines provided some data, but the important things, such as which departments were our most heavy customers, what types of projects they were being used for, and how often people were returning were nowhere to be found. I created the 3D Design Studio Queue app to solve these problems.

The queue is an [Electron](https://www.electronjs.org/) application that is locally installed on the computer within the studio by the studio’s manager. Under the hood of the Electron app is a React application using Semantic-UI as a UI library and making HTTP web requests out to the DreamFactory server for data storage and management. The interface of the app is mostly just a data table with various tabs for different types of ‘queues,’ including queues for more complicated requests, and queues that leverage the higher end resin printers in the studio. The app also incorporates forms that the student workers send out, which write to the DreamFactory instance for new items in the queue, and using the built in querying functionality that comes with the automatically generated APIs within DreamFactory, we are able to keep the app responsive even when dealing with large numbers of records.

The app also incorporates an automated communication mechanism in the form of a SMTP service API in DreamFactory. Whenever a print in the system is marked as completed by the student worker, they receive a popup asking if an email should be sent to the person who the print is for, and DreamFactory handles the rest. This has helped us ensure that communication with our patrons is happening in a timely fashion.

![](https://journal.code4lib.org/media/issue48/bradley/fig1.png)  
**Figure 1.** The interface of the 3D printing queue for our 3D Design Studio.

## Outreach and Impact Metrics

The most complicated app using the DreamFactory instance as a backend is another Electron application we use to gather our impact metrics for how we interact with student and faculty members. This system links multiple data tables together, including ‘projects,’ ‘interactions,’ ‘external contacts,’ ‘library employees,’ ‘locations,’ ‘strategic priorities,’ and others, and allows us to quickly assess who we are interacting with the most, where we need to do more outreach, and what sorts of services seem to be the most popular with our patrons. This app acts as a central collection for our unit to gather statistics on things like consultations, workshops taught, embedded instruction, and ongoing research collaborations, and by keeping the data in a central location, we are able prevent duplication of effort when we collaborate with other unit members on a project.

This app relies heavily on DreamFactory’s relational data querying that is built into the generated APIs. Each tab in the app queries against one table but pulls related information from linked data in order to make finding a summary of how many interactions we’ve had with a specific college or department or how many workshops are part of a specific project a quick process.

![](https://journal.code4lib.org/media/issue48/bradley/fig2.png)  
**Figure 2.** The interactions tab in the Data Collection App.

## Student Worker Reference Questions

Many of our studios are staffed by students during the normal open hours, and in an attempt to ensure that we are properly collecting and reporting things like reference questions and walk-in patrons for the services, I created a small web application that contains a submission button for submitting this information quickly to DreamFactory. Unlike the previous apps, this is not an Electron app, but instead is just a local webpage running within the browser. Because it isn’t hosted on a server anywhere, it is only accessible via the controlled machines we have it frozen on. To create the app was just a matter of putting together a simple webpage that makes HTTP requests out to DreamFactory whenever the forms are submitted, meaning students can report reference questions easily and without logging into anything while at the desk during a shift.

This use case may seem like overkill; one could just set up a Google form or a form in a system like LibApps to achieve the same effect, but the importance of having all of this data in the same system and utilizing a full REST API become apparent as we get to some of the later examples.

![](https://journal.code4lib.org/media/issue48/bradley/fig3.png)  
**Figure 3.** The interface in which students do gate counts for our studios and report when they are asked reference questions.

## [Patron Feedback Kiosk](https://github.com/drjonathanbradley/studios-feedback)

Gathering feedback about our service points has been a difficult task. We’ve provided links to forms in outgoing emails, but we rarely get people to respond, and when they do, it is usually because they had a bad experience and want to complain, which over time can skew your impression of how well the service is operating and how you might improve. In a year of sending forms and asking for feedback, we only got enough responses to count on two hands, so to try to lower the bar to providing feedback, we took inspiration from other feedback mechanisms I’ve seen in public contexts.

I got some Windows tablets and put them up in our studios near exits with a simple feedback app. A single question, “How was your experience?” and a smiley face and a frowny face. After the patron chooses their initial feelings, the app presents them with 4 options, either in a positive vein or a negative vein, to give us more details about how we could improve. These options include things like “Staff was helpful” or “Staff was unhelpful” and “Technology worked well,” or “Technology did not function properly.” Even though this method has been online for a much shorter period of time, we’ve gathered over a thousand responses and have a much clearer picture of how our service points are doing.

This app, like the student worker reporting app, is a simple web page served from a kiosk browser on the tablet itself. It reports its results back out to DreamFactory for each interaction, and has a 15 second reset timer to prevent spamming a particular response. Because the app is a simple webpage, we’ve also been able to automate updates for it, having the device try to pull code from the master branch on Github each night at midnight, meaning I can update all of the devices across studios without accessing each device individually.

![](https://journal.code4lib.org/media/issue48/bradley/fig4.jpg)  
**Figure 4.** A patron feedback kiosk in the Virtual Environments Studio at Newman Library.

## [Live Polling App](https://github.com/drjonathanbradley/live-poll-app)

We have a Data Visualization Studio in Newman Library, and one of the things we wanted for the space was a large touch screen kiosk to set outside the space to display interactive visualizations created by faculty or students. However, these sorts of topics come and go, so in the spirit of digital signage, we wanted some ‘evergreen’ content. To accomplish this, I created a live polling app inspired by a public display I saw at a data visualization conference. The React app is locally served via a kiosk browser and rotates through a series of polling questions it pulls from DreamFactory. Individuals or groups of people can cast their votes, see their votes counted and added into the visualization in real-time, and wait until the timer runs out to get a new question. After each cycle, the total votes are updated in DreamFactory so that the polls are consistent if the app is taken down for a period or the building suffers a power outage.

The questions we generally add to the poll are usually humorous and are primarily used as a way to get people engaged with the space and thinking about how they could use it in their own projects, but we do occasionally use the app to gather internal information about what patrons might be interested in. For example, when we were considering adding musical instruments to our equipment lending service, we used the polling app to see which instruments (guitar, piano, bass, violin, banjo) people would be most interested in learning and used the results to make a purchasing decision.

![](https://journal.code4lib.org/media/issue48/bradley/fig5.jpg)  
**Figure 5.** Data visualization kiosk running a live patron polling app.

## Spreadsheet Processing

Despite my best efforts to pull together all our unit’s data collection into a single place, we still have some outlying systems that cause problems. Some of these are from vendors who do not have APIs, others are systems that have not yet been converted to work with DreamFactory, and some are legacy data that existed in old systems and we now have as part of an archive. However, we need this data to be available in a single, query-able place in order to use it, so I wrote a series of scripts using Node.js that take the spreadsheets generated by these systems, process them into clean, formatted data that matches other data schemas we use, and then uploads them all to DreamFactory.

By leveraging DreamFactory’s schema control, I’m able to click on a single Windows batch file and have the entire process run, including deleting and creating needed tables in the database and then uploading the processed data to be used alongside other collected data in analysis.

## Data Dashboard

The final and perhaps the most important of the use cases is the Data Dashboard utilized by our unit. The dashboard is a local web app, using React and the [Nivo](https://nivo.rocks/) visualization library to create a dynamic dashboard of information pulled from the many data sources held in DreamFactory. The dashboard makes multiple requests to DreamFactory services when it loads, processes the data through a series of short, simple functions that do things like filter, sort, and format, and then passes the prepared data to the appropriate visualization mechanism, whether it be a calendar, chart, text block, or number display.

This dashboard is organized by space or type of service that we offer, and each tab is able to pull from multiple tables, combining data that is appropriate to display alongside each other and see how their juxtaposition reveals insights. For example, we can see how the number of negative experiences reported by patrons correlates with the number of bookings per hour in our technology lending space and use those numbers to make decisions about staffing hours in order to have more people on hand. Or we can see how our attendance rates for workshops change over the course of the semester and make decisions about scheduling those events at the times in which patrons seem most likely to attend.

The dashboard has helped greatly with members who have to fill out Faculty Annual Reports on our activities and prevents the combing through of emails and calendars at the end of the year trying to remember everything that was done, and from an administrative standpoint, it makes compiling our section of the annual report as easy as opening the app and filtering out only the past fiscal year for a clear overview of our accomplishments.

![](https://journal.code4lib.org/media/issue48/bradley/fig6.png)  
**Figure 6.** The overview tab of the Data Dashboard.

## Summary of the Benefits

The primary benefit of DreamFactory is its automatically generated APIs. Being able to define a data schema and have all the needed endpoints with filtering, querying, relational pulls, and even data downloads made available without writing your own code makes creating an app extremely fast compared to having to write the API from scratch. It also helps deal with an ongoing concern of securing API endpoints. Vulnerabilities are constantly arising on the internet and maintaining the security of your own API often becomes a question of how much time you have for maintenance versus potentially leaving an insecure endpoint online. By outsourcing some of this maintenance to an open source community and company that has a stake in ensuring it remains secure can help ensure that not only are vulnerabilities known about, because far more eyes will be on them than would be solely on your app, but also that experts in online security have the freedom to weigh in on how they should be patched, which may be something your team does not have access to depending on its size.

But why choose DreamFactory over possible other options in this same vein? For the projects I was taking on, I wanted something open source that could be hosted as the library saw fit, which limited some options of software. It was also preferable to have a free option, which would likely also appeal to other libraries that may not be able to afford the more expensive plans offered by competitors. Finally, another reason was consolidation of data. For years now one of my goals within my unit has been to bring in as much data into the same place, so that we both have a record of it and it is not being lost as we have turnover of employees or files lost in old archives on someone’s surplused computers. Having all the data in the same place has also allowed standardizing the way we collect data, so that what we do actually speaks to each other to try to make a sense of the trends of how we work. By having the data all feed into this one system, it simplifies the process of collecting, standardizing, analyzing, and backing up numerous data sets concerning various topics, greatly simplifying the work that I do in trying to show our impact or figure out where our services need to go next.

*Dr. Jonathan Bradley* is the Head of Studios and Innovative Technologies for the University Libraries at Virginia Tech. His current research interests are virtual and augmented reality in immersive environments, IoT development for space assessment, and role-playing games as a learning tool. Among his responsibilities are the management and creation of software for data collection and analysis of studio-related projects.
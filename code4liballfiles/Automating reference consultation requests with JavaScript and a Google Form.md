---
title: "Automating reference consultation requests with JavaScript and a Google Form"
source: "https://journal.code4lib.org/articles/16414"
author:
  - "Stephen Zweibel"
published: 2022-05-10
created: 2025-01-10
description: "At the CUNY Graduate Center Library, reference consultation requests were previously sent to a central email address, then manually directed by our head of reference to the appropriate subject expert. This process was cumbersome and because the inbox was not checked every day, responses were delayed and messages were occasionally missed. In order to streamline this process, I created a form and wrote a script that uses the answers in the form to automatically forward any consultation requests to the correct subject specialist. This was done using JavaScript, Google Sheets, and the Google Apps Script backend. When a patron requesting a consultation fills out the form, they include their field of research. This field is associated in my script with a particular subject specialist librarian, who then receives an email with the pertinent information. Rather than requiring either that patrons themselves search for the right subject specialist, or that library faculty spend time distributing messages to the right liaison, this enables a smoother, more direct interaction. In this article, I will describe the steps I took to write this script, using only freely available online software."
tags:
  - "#reference/consultation"
  - "#JavaScript"
  - "#Google/Forms"
---
# Automating reference consultation requests with JavaScript and a Google Form
Stephen Zweibel

At the CUNY Graduate Center Library, reference consultation requests were previously sent to a central email address, then manually directed by our head of reference to the appropriate subject expert. This process was cumbersome and because the inbox was not checked every day, responses were delayed and messages were occasionally missed. In order to streamline this process, I created a form and wrote a script that uses the answers in the form to automatically forward any consultation requests to the correct subject specialist. This was done using JavaScript, Google Sheets, and the Google Apps Script backend. When a patron requesting a consultation fills out the form, they include their field of research. This field is associated in my script with a particular subject specialist librarian, who then receives an email with the pertinent information. Rather than requiring either that patrons themselves search for the right subject specialist, or that library faculty spend time distributing messages to the right liaison, this enables a smoother, more direct interaction. In this article, I will describe the steps I took to write this script, using only freely available online software.

## Context

Like many other academic libraries, we offer consultations with our subject specialist librarians. Due to the fact that we are a school for PhD and master’s students, most questions we receive are particular to the individual student’s field of research. For this reason, we have found that it saves time to have students directly request help from their liaison librarian, rather than meeting first with whomever happens to be at the reference desk. This offers the additional potential benefit of fostering personal relationships between librarians and students that can last through their doctoral programs.

## Problem

Our central problem was: how do we make it as easy as possible for students to reach us? We have decided to trust our students to know whether their question is worth asking a subject specialist directly, so how do we enact that in reality? When I came to the CUNY Graduate Center Library, the ad hoc solution was to have a Google Form with prompts about the student’s question, topic area, and other general queries. On submission, this form would be sent to our reference desk email address, monitored by several librarians but primarily our head of reference. Whichever librarian saw the consultation request email would read it, and depending on its contents, forward it to the relevant subject librarian. This of course did work, and had the advantage of a personal touch. The main disadvantage of this manual process was its potential for human error — sometimes emails would languish in the inbox for days -– and the added administrative burden it placed on librarians.

## Design

The solution as I saw it was to remove the librarian intermediary to allow students and faculty to get their consultation request directly to a subject specialist. One proposal was to do away with the request form and direct patrons to our list of liaison librarians, with instructions to reach out to the librarian for their program. Although this could work, it would add friction to the process for patrons, and thus could risk reducing the number of requests we would receive.

Instead, I wanted to make the request process as smooth as possible for both patrons and librarians. The required solution would need to make it possible for:

1. Patrons to be able to get their request to the correct subject specialist without knowing who that specialist was
2. Subject specialists to receive the correct requests without an intermediary librarian
3. Changes in subject specialist status (like sabbaticals or new responsibilities) to be easily reflected without large changes to the system

Therefore, the solution would have to be automated, and able to determine the correct subject specialist from the information provided by the patron in the form. For a while I entertained a kind of machine learning solution, where topic modeling would be trained on the long-form description the patron gave of their problem, and compared to a list of our experts. After consideration I determined this to be unreliable and much too complicated!

Fairly quickly I came to the solution of adding a single question to the form: “Which Academic Program do you belong to?” Because each academic program has an assigned librarian liaison, this provides a 1:1 determinant of who would be responsible for handling a consultation request. This piece of information, supported by the other results of the form, would enable us to match requests to the appropriate subject specialist. The challenge was to do that in real time, as requests came in, and to generate a message that would reach the desired librarian via a channel they were accustomed to checking regularly.

## Google Forms and Google Sheets

The choice I made was path dependent, in that we were already using Google Forms. A solution suggested itself: to use Google’s free tools to get an automatic email to send every time the form is submitted by a patron. Our form looks like this:

![](https://journal.code4lib.org/media/issue53/zweibel/zweibel-figure-1.png)  
**Figure I.** Form content example.

On the form management page, there is a little green icon that links to a spreadsheet of the responses.

![](https://journal.code4lib.org/media/issue53/zweibel/zweibel-figure-2.png)  
**Figure II.** Form management page.

On the spreadsheet page, there is a menu called ‘Extensions’.

![](https://journal.code4lib.org/media/issue53/zweibel/zweibel-figure-3.png)  
**Figure III.** Extensions menu.

Using ‘Apps Script’ link leads to Google’s Apps Script code platform, which uses a slightly modified/specialized form of JavaScript that allows us to interact with the form results. Essentially, we have written a JavaScript function that will run when a form is submitted, taking the form inputs as values to decide its behavior.

## Function Construction

We start by naming our function and making a ‘Librarian’ object:

| 1  2  3  4  5  6  7  8  9 | `function` `emailLibrarian(e){`  `var` `librarians = [];`  `function` `librarian(name, email, programs, available){`  `this``.name = name;`  `this``.email = email;`  `this``.programs = programs;`  `this``.available = available;`  `librarians.push(``this``); `  `}` |
| --- | --- |

Breaking this down somewhat, in the line:

| 1 | `function` `emailLibrarian(e){` |
| --- | --- |

The ‘e’ is the ‘event object’ passed to us by Google Forms (i.e., actually the content of the form submitted by a patron). We will use this a bit later in the script.

This line:

Adds each created librarian to the list of librarians for later.

| 1 | `function` `librarian(name, email, programs, available)` |
| --- | --- |

This Librarian object is used to represent each of our subject experts, like this:

| 1  2  3  4  5  6 | `var` `StephenZweibel = ``new` `librarian(``"Stephen Zweibel"``, ``"szweibel@gc.cuny.edu"``, [`  `"Comparative Literature"``, ``"Data Analysis and Visualisation"``, ``"Data Science"``,`  `"Data Visualization"``, ``"Demography"``, ``"Digital Humanities"``, ``"French"``,`  `"Geography/GIS"``, ``"Language and Literacy"``,`  `"Master of Arts in Liberal Studies (MALS)"``, ``"Music"``, `  `"Psychology of Political Behavior"``], ``true``);` |
| --- | --- |

Here we have in order:

- Subject expert name
- Email
- A list of fields this librarian is responsible for
- And ‘True’, which represents availability. This is set to ‘False’ if the librarian is on sabbatical, etc.

So a librarian object is created for each librarian, and that librarian is added to a list of librarians, i.e.:

| 1 | `var` `librarians = [StephenZweibel, …];` |
| --- | --- |

From here, it’s a matter of grabbing the relevant subject area of the form request and matching it to a librarian.

| 1 | `MALS: e.values[10],Status: e.values[5], Purpose: e.values[6], Availability: e.values[7], Topic: e.values[8], ``"Steps taken"``: e.values[9]}` |
| --- | --- |

This variable takes the responses from the form, ‘e’, and splits it out into attributes that I can read and do something with. ‘Program’ is important, as this is what we’ll match our liaison emails with:

| 1  2  3  4 | `var` `liaison = librarians.filter(``function``(liaison){`  `return` `liaison.programs.includes(program);`  `})[0];`  `var` `liaisonEmail = liaison.email;` |
| --- | --- |

This takes advantage of a list method that filters according to some rule, in this case whether or not the program (Anthropology, English, Comp Lit, etc.) chosen by the patron is included in the listed responsibilities of the librarian.

I have also added a couple of overrides, in cases where other answers in the form are more salient than the student’s academic program, for instance:

| 1  2  3 | `if` `(values.Purpose == ``"Data Management"``){`  `liaisonEmail = ``"szweibel@gc.cuny.edu"``;`  `}` |
| --- | --- |

This would choose me as the recipient based on a different criterion than the program.

Another important intervention:

| 1  2  3 | `if` `(liaison.available == ``false``){`  `liaisonEmail = ``"ref@gc.cuny.edu"``;`  `};` |
| --- | --- |

In this case we account for unavailable librarians, and send the email to our catchall email.  
And to construct and send the email:

| 1  2  3  4  5  6  7  8 | `var` `text = ``"Hello,\n\n"`  `text += values.Name + ``" has requested a research consultation.\n\n"`  `for` `(``var` `item ``in` `values) {`  `text += item+ ``": "``+values[item]+``"\n\n"``;`  `}`  `MailApp.sendEmail (liaisonEmail, subject, text, {cc: ``"ref@gc.cuny.edu"``});`  `};` |
| --- | --- |

This translates the values into text, and we take advantage of Google’s MailApp toolset to send an email with that text to the correct liaison librarian, cc’ing to the reference desk email.

An example email:

Hello,  
\*\*\*\* has requested a research consultation.  
Name: \*\*\*\*  
Patron Email: \*\*\*\*@gc.cuny.edu  
Phone: \*\*\*\*  
Program: Digital Humanities  
Status: Student  
Purpose: Dissertation, Thesis, or Capstone Project  
Availability: Mon, Oct 18th 2-6 pm; Wed, Oct 20th 2-6 pm; Thu, Oct 21st 2-6 pm  
Topic: I am working on my capstone project and I wanted to have a consultation on the best way to submit/preserve my digital project.  
Steps taken: I have talked with the Digital Fellows about audio techniques.

## Settings

There is one more important step. We need to set the function we have made to fire on a trigger; navigating to the ‘Triggers’ section:

![](https://journal.code4lib.org/media/issue53/zweibel/zweibel-figure-4.png)  
**Figure IV.** Selecting *Triggers* from settings.

Here are our settings:

![](https://journal.code4lib.org/media/issue53/zweibel/zweibel-figure-5.png)  
**Figure V.** Trigger settings.

Now the function will run every time the form is submitted by a user. Luckily this also will send us an alert if the function fails for whatever reason, usually a misspelling on my part of an academic program.

## Advantages/Disadvantages

For the most part, this script runs without any intervention, and has for several years. It does need to be updated periodically, to account for librarian availability and changes in responsibilities. Relying on free tools that are outside our control is the largest concern with this solution: once already, Google has made a big update to the way their tools work, which required some minor adaptations on our end.

Another potential disadvantage regards continuity: if I were to leave my position at the library, this process might not be transparent to a successor librarian. This paper will hopefully serve as documentation.

Since implementing this solution, our librarians have come to see the form emails as infrastructural and to take them for granted. We receive maybe ten emails a month, a good rate for our small patron base.

## Resources

Link to the reasearch appointment request form: [https://docs.google.com/forms/d/e/1FAIpQLSdnPu7VWGbEP9FRzgGtrqbDgeUGZ7qbqZwTnaeeX0RVEz8BhA/viewform](https://docs.google.com/forms/d/e/1FAIpQLSdnPu7VWGbEP9FRzgGtrqbDgeUGZ7qbqZwTnaeeX0RVEz8BhA/viewform)

[JavaScript code source](https://journal.code4lib.org/media/issue53/zweibel/code/LibrarianEmail.js)

Stephen Zweibel is Digital Scholarship Librarian at the CUNY Graduate Center, where he supports students and faculty in developing digital projects and working with data, individually and through workshops and classes on research skills and tools. Stephen built DH Box, which won a National Endowment for the Humanities Start-Up grant.
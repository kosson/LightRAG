---
title: "Choose Your Own Educational Resource: Developing an Interactive OER Using the Ink Scripting Language"
source: "https://journal.code4lib.org/articles/15721"
author:
  - "Stewart Baker"
published: 2021-06-15
created: 2025-01-10
description: "Learning games are games created with the purpose of educating, as well as entertaining, players. This article describes the potential of interactive fiction (IF), a type of text-based game, to serve as learning games. After summarizing the basic concepts of interactive fiction and learning games, the article describes common interactive fiction programming languages and tools, including Ink, a simple markup language that can be used to create choice based text games that play in a web browser. The final section of the article includes code putting the concepts of Ink, interactive fiction, and learning games into action using part of an interactive OER created by the author in December of 2020."
tags:
  - "#educational/resources"
  - "#scripting/language"
  - "#Ink"
---
# Choose Your Own Educational Resource: Developing an Interactive OER Using the Ink Scripting Language
Stewart Baker

Learning games are games created with the purpose of educating, as well as entertaining, players. This article describes the potential of interactive fiction (IF), a type of text-based game, to serve as learning games. After summarizing the basic concepts of interactive fiction and learning games, the article describes common interactive fiction programming languages and tools, including Ink, a simple markup language that can be used to create choice based text games that play in a web browser. The final section of the article includes code putting the concepts of Ink, interactive fiction, and learning games into action using part of an interactive OER created by the author in December of 2020. 

## Introduction

“You have died of dysentery.”

Anyone who attended a U.S. elementary school in the 1980s or 1990s will likely recognize this as a game over message from *The Oregon Trail*, a computer game intended to teach students about the emigration of settlers to Oregon in the 1850s. Although the game presents indigenous peoples largely as props or obstacles to overcome and implicitly accepts the idea of manifest destiny (Bigelow, 1997), it was hugely successful and remains iconic even today. Interestingly, the earliest version of *The Oregon Trail* was a text-only game released in 1971 (Bouchard, 2019), making it one of the earliest computer games designed for educational purposes and arguably a notable early example of interactive fiction (IF), computer games where text, rather than advanced graphics or skill with a controller, are the main game element.

This article will explain the basic concepts of interactive fiction and learning games and will show how to use interactive fiction scripting language Ink to create a learning game that can be easily distributed as an open educational resource (OER).

## What is Interactive Fiction?

Interactive fiction, commonly abbreviated as IF, is a type of video game “where the player’s interactions primarily involve text” (IFTF, n.d.). Although the idea of text-only video games seems quaint in the 2020s, IF was big business in the 1980s, when the processing power of personal computers was limited. Infocom’s 1979 fantasy exploration game Zork, one of the most successful IF games, sold over 150,000 copies in 1984 alone at roughly $50 a piece (Carless, 2008).

Today, there is a thriving hobbyist community of IF authors and players, with the Interactive Fiction Database ([https://ifdb.org/](https://ifdb.org/)) describing more than 11,000 published games, 468 in the year 2020 alone. Much IF today is created as part of “comps” (competitions) and “game jams” (friendly competitions based around a theme), although there are commercial publishers as well. The biggest competition is IFComp ([https://ifcomp.org/](https://ifcomp.org/)), which offers prizes and reviews to more than 100 entrants annually, while independent game publishing site itch.io ([https://itch.io/jams](https://itch.io/jams)) hosts hundreds of jams each year.

IF is typically split into two distinct types:

- Parser games are pieces of IF where the player must type commands into a ‘parser’ to complete tasks in the game world. Early IF games were usually parser games.
- Choice-based games are pieces of IF played in a web browser or browser-like environment. In choice-based games, players use web design elements such as links to navigate a set of pages with varying degrees of sophistication and complexity.

Some purists argue that parser games are the only kind of games that can properly be considered IF, with choice-based games instead being works of “hypertext” (Montfort, 2003). In practice, however, most IF designers and players today include both choice-based and parser games in definitions of IF. This paper will primarily discuss a specific choice-based IF scripting language, Inkle Studio’s Ink ([https://www.inklestudios.com/ink/](https://www.inklestudios.com/ink/)), but otherwise uses the term “IF” to refer to both choice-based and parser games.

### Writing Interactive Fiction

Driving the boom in contemporary IF is its strong sense of community. Outside of the competitions and game jams, there are any number of thriving forums and Discord servers dedicated to playing and writing IF. An additional outcome of this community focus is that there are a number of scripting languages developed specifically to create new works of IF, almost all of which have authoring tools that are freely available to writers. In fact, there are so many tools, as IF developer Emily Short points out, that the first step to starting a new IF project is to select which tool you will be using (Short, n.d.).

A few of the most popular languages and tools are listed below:

- Twine ([http://twinery.org/](http://twinery.org/)) is a choice-based authoring tool that creates IF games which run in a web browser. Twine is a good choice if you want to include JavaScript-based effects in your work. Twine’s authoring tool can run in the browser or a stand-alone client can be downloaded for Mac and Windows.
- Inform ([http://inform7.com/](http://inform7.com/)) is a parser game programming language first created in 1993. The latest version, Inform 7 uses natural language programming concepts. The authoring tool for Inform is a stand-alone client that runs on Mac, Windows, and Linux. Players must have access to an “interpreter” program to run Inform games, although authors can also host games in web-based interpreters on a web server.
- TADS ([http://www.tads.org/tads.htm](http://www.tads.org/tads.htm)) is a parser game programming language based on object oriented programming principles. The TADS authoring tool is a stand-alone client that runs on Mac, Windows, and Linux. Players typically need access to an interpreter program, but the latest version (TADS 3) also allows authors to export their games to web pages. TADS 3 is notable also for its ability to integrate graphics and other web objects with games.
- Ink ([https://www.inklestudios.com/ink/](https://www.inklestudios.com/ink/)) is a scripting language for creating choice-based games. Created by Inkle Studios to produce games, Ink is noteworthy for its ability to integrate with Unity to serve as the dialogue engine for more complex video games. It can also be used to produce choice-based IF that runs in a browser. Ink’s authoring tool is a stand-alone client that runs on Mac, Windows, and Linux. Inkle Studios also maintains a visual web-based tool for writing IF in ink called Inklewriter ([https://www.inklestudios.com/inklewriter/](https://www.inklestudios.com/inklewriter/)), created with the aim of enabling writers without a programming background to write interactive stories more easily.
- ChoiceScript ([https://www.choiceofgames.com/](https://www.choiceofgames.com/)) is the language used by commercial IF publisher Choice of Games. Choicescript is particularly useful for games where the player character’s “stats” or abilities affect the player’s choice. Unlike other languages, Choicescript’s license does have restrictions on creating and publishing games outside of Choice of Games’s official line of games; however, games written in Choicescript can be distributed non-commercially without issue (Fabulich, 2010).

## Interactive Fiction as Learning Game

Learning games (sometimes called “serious games,” a term this article will not use as it implies non-learning games are frivolous) are games designed to “help players develop new knowledge or skills or to reinforce existing knowledge or skills” (Boller and Kapp, 2017) rather than solely for entertainment purposes. Although results vary, learning games can be effective ways to teach. One meta-analysis found that 29 out of 40 reviewed studies showed that learning games had a positive effect on learning (Backlund and Hendrix, 2013). Likewise, studies have shown that roleplaying games and simulations can benefit students (Kim, 2018; Overland, 2017).

Studies of IF learning games are scarce outside of composition studies, where the focus is often on students creating their own IF rather than using it to learn about another topic. However, there is nothing that implies IF should be any less effective than more visually-focused games at providing education as well as entertainment. Indeed, IF’s relatively low barriers to creation could well make it an attractive option for librarians and teachers without the extensive skillset required to produce well-designed full-featured video games or the budget to support a team of developers. IF games also tend to be small in terms of file size and are more likely to be platform-agnostic, especially for choice-based games that typically run in a browser window. This means IF has the potential to be distributed easily in OERs, institutional repositories, and other web-based spaces teachers, librarians likely already use to provide instructional materials to students.

Of course, just because IF can be considered a “low-tech” approach (Harvey, 2018) doesn’t mean writing good IF is easy. The effectiveness of a learning game depends on part in whether its players enjoy its narrative quality and ease of use, among other things (Fokides, Atsikpasi, Kaimara and Deliyannis, 2019), and if there aren’t splashy graphics or other elements associated with “proper” video games involved, it’s even more important to pay attention to the details of the prose and make sure your code is bug-free.

Although the majority of IF produced today is written with entertainment, rather than education, in mind, examples of IF intended to educate and entertain at the same time do exist:

- Depression Quest ([https://depressionquest.com](https://depressionquest.com/)) – Written in 2013 by game developers Zoë Quinn, Patrick Lindsey, and Isaac Schankler, Depression Quest simulates the experience of clinical depression by showing players choices they can’t take due to depression. The game was critically successful, with reviewers stating that the game helped them to understand what it was like to suffer from depression but was still fun to play (Vasquez, 2014). Depression Quest is written in Twine.
- When Rivers Were Trails ([https://indianlandtenure.itch.io/when-rivers-were-trails](https://indianlandtenure.itch.io/when-rivers-were-trails)) – An *Oregon Trail* like game written in Unity which centers indigenous peoples, intended to teach players about the impacts of colonization on their communities (LaPensée and Emmons, 2019).
- A Bathroom Myth ([https://adeniro.itch.io/a-bathroom-myth](https://adeniro.itch.io/a-bathroom-myth)) – Although not a ‘learning game’ in the traditional sense, Anya Johanna DeNiro’s A Bathroom Myth is a game with a mission, using the trappings of a fantasy setting to build empathy and activism around anti-transgender bathroom laws. The game is written in Twine.
- Harmony Square ([https://harmonysquare.game/en](https://harmonysquare.game/en)) – Developed by psychologists Jon Roozenbeek and Sander van der Linden in conjunction with the U.S. Department of Homeland Security, Harmony Square teaches players about misinformation tactics by letting them roleplay as a “disinformation minister” hired to sow discord in the fictional community of Harmony Square. Although the game has graphics, they are of secondary importance and the core of its interaction is handled by reading and responding to text. A study by the developers showed that the game improved people’s ability to spot misinformation and reduced the likelihood that they would share it on social media when they found it (Roozenbeek and Van der Linden, 2020).

These games and others like them show the potential of text-based games to reach a large audience and to educate and entertain.

## Introduction to Ink

As noted above, there are many different authoring tools for creating IF. This section of the article will take a look at Inkle Studio’s Ink programming language, explaining its basic concepts and providing snippets of code.

To reiterate, the different IF languages and tools do very different things. Ink is a useful language to write learning games in for several reasons:

- It is designed around a simple markup language, lowering the need for programming knowledge
- Its games export to web pages, which can be hosted online and embedded in OERs and instruction guides
- Exported games can be styled using CSS without the need for additional coding knowledge
- Inky (Ink’s authoring tool) has good built-in error checking and outputs code as you write it
- Inkle’s web-based Inklewriter tool can be used to write games without code
- Players only need to be able to read text and interact with links, and don’t need to learn parser commands on top of the game’s subject matter
- Game content can easily be converted to a text-only, printable version

More advanced developers can also take advantage of Ink’s integration possibilities. The language has been used to create not just text-based games but critically acclaimed narrative games with heavy graphical components, including 80 Days ([https://www.inklestudios.com/80days/](https://www.inklestudios.com/80days/)), Where the Water Tastes Like Wine ([https://www.wherethewatertasteslikewine.com/](https://www.wherethewatertasteslikewine.com/)), and Heaven’s Vault ([https://www.inklestudios.com/heavensvault/](https://www.inklestudios.com/heavensvault/)). Like most IF languages, Ink has extensive online tutorials, including Inkle’s official documentation (Inkle, 2016a) and various community-authored guides (Secchi, n.d.).

### Ink Basics

Technically, you can write Ink files in any text editor, but use of Inky (Inkle’s standalone authoring tool for Ink) is highly recommended as it makes debugging and playtesting significantly easier. Inky *is* required to compile Ink games into playable standalone files.

To output text in Ink, all you need to do is write that text into Inky.

| 1 | `It was a dark and stormy night.` |
| --- | --- |

Ink will parse this as content, outputting it immediately. As seen below, the end of an Ink file will also produce an “End of Story” notice to let players know they’ve run out of content.

![Inklewriter screenshot](https://journal.code4lib.org/media/issue51/baker/1-Inky-content-only.png)

**Figure 1.** A line of text in Inklewriter. The left side of the screen shows code and the right side shows output.

The core of any choice-based game is its choices, and Ink is no exception. Choices players make drive the story of the game they are playing, affecting everything from what their character does to the information they are able to learn from non-player characters (NPCs).

In Ink, choices are represented by lines of code that start with an asterisk (\*).

| 1  2  3  4 | `It was a dark and stormy night.`  `*What kind of storm?`  `The rain fell in torrents.` |
| --- | --- |

From this example, Ink will output a line of content followed by a clickable hyperlink.

![Inklewriter screenshot](https://journal.code4lib.org/media/issue51/baker/2-Inky-content-and-choice.png)

**Figure 2.** A choice in Inklewriter. On the right side of the screen, the editor has rendered the choice into a clickable link.

When the player clicks the hyperlink, its text will turn into plain text and the remainder of the content will be displayed.

![Inklewriter screenshot](https://journal.code4lib.org/media/issue51/baker/3-Inky-clicked-choice.png)

**Figure 3.** Inklewriter’s output changes after the user clicks the link, turning the choice into plain text and outputting the remainder of the content.

Multiple choices can be displayed at once by including multiple lines that begin with asterisks and placing the relevant response after each. Ink ignores whitespace characters, so it can be a good idea to indent code to help you keep track of your game’s hierarchy.

| 1  2  3  4  5  6 | `It was a dark and stormy night.`  `*What kind of storm?`  `The rain fell in torrents.`  `*Where are we?`  `It is in London that our scene lies.` |
| --- | --- |

This code will produce the following output:

![Inklewriter screenshot](https://journal.code4lib.org/media/issue51/baker/4-Inky-two-choices.png)

**Figure 4.** Multiple choices are rendered into multiple links. Below each choice is the content Inklewriter will output if that choice is selected.

### Chapters (Knots), Scenes (Stitches), and Choices in Ink

Any game of more than a few lines will need to take advantage of knots and stitches, Ink’s two main “structural units” (Inkle, 2016a).

Knots are the largest unit and can be thought of as chapters in a novel. Stitches can be used to further subdivide knots, like scenes inside a chapter. Knots and stiches are important not just because they make it easier to remember where things are in the code of larger games, but because they break game content up into sections that can be accessed by Ink’s “divert” feature. Like a “GOTO” line in other programming languages, diverts redirect the player to different parts of the code.

Knots are represented by lines of code that start with two or more equal signs. Ink’s documentation uses three equal signs before and after knot names, but this is an aesthetic choice to make large games more legible and is not required. Stitches are lines of code that start with a single equal sign.

To add a divert, insert an arrow made up of a hyphen and less-than symbol (->) in front of the name of the stitch or knot you want Ink to go to next. Diverts can appear anywhere in a line. While they typically appear after choice text, they can be used to move players from the end of a knot or stitch, or any other arbitrary place, to elsewhere in the game.

| 1 | `*[What kind of storm?]->storm` |
| --- | --- |

If you want to direct the player to a stitch inside a knot other than the one where the divert is located, you must list both the knot name and the stitch name separated by a period.

| 1 | `*[What kind of storm?]->Story.storm` |
| --- | --- |

Knots, stitches, and diverts allow Ink to create sophisticated games where the choices the player makes move them through a narrative and affect its outcomes. Let’s take a look at a complete, albeit very short and uninteresting, game in Ink.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `It was a dark and stormy night.`  `*[What kind of storm?]->Story.storm`  `*Where are we?->Story.where`  `==Story`  `=storm`  `The rain fell in torrents.`  `->Conclusion`  `=where`  `It is in London that our scene lies.`  `->Conclusion`  `==Conclusion`  `At occasional intervals, the rain was checked by a violent gust of wind.`  `->END` |
| --- | --- |

This code will produce the following initial output:

![Inklewriter screenshot](https://journal.code4lib.org/media/issue51/baker/5-Inky-with-knots-and-diverts.png)  
**Figure 5.** The code view now shows knots and diverts. Since no choice has been selected, the output shows only the first sentence and the first two choices available to the user.

If the player selects “What kind of storm?” the output will append the content from the “storm” stitch in the “Story” knot before appending the content from the “Conclusion” knot along with the “End of story” notice.

![Inklewriter screenshot](https://journal.code4lib.org/media/issue51/baker/6-Inky-end-of-story.png)

**Figure 6.** After the user has selected “What kind of storm?” as a choice, Inklewriter outputs the content in the Story.storm stitch and then immediately outputs the content in the Conclusion knot, followed by the “end of story” notice.

Ink also gives game designers options for how to display choice text. By default, choice text becomes text content when the player selects it. You can manipulate what displays by the use of a pair of square brackets in choice text, as shown in the example code above. Choice text that comes before brackets will appear in both the choice text and as content after the player selects it, text inside brackets will only appear in the choice text, and text after the brackets will only appear as content after the choice has been selected by the player.

In this case, because the “What kind of storm?” choice is entirely enclosed in brackets, the choice text does not appear at all in the outputted story after that choice has been selected by the player.

One important thing to note is that knots and stitches must include a divert statement at the end of each choice they contain to avoid a “ran out of content error.” If no existing knot or stitch is appropriate, you can type ->DONE or ->END to indicate that Ink should go to the end of the current knot or stitch or the end of the program, respectively.

### Advanced Ink

It’s possible to write satisfying games in Ink using nothing but choices and stitches as described in this article. Ink can do much more than that, though. In addition to managing variables, functions, and logic, Ink supports choices that appear more than once, random selection of items in a list, and many other things. Ink’s official documentation contains a lot of detail, as well as numerous code snippets and examples (Inkle, 2016a).

If you’re the sort of person who learns by doing, you can copy a ready-to-play game from the official documentation and paste it into Inky to get a better understanding of how the language works before starting on your own project (Inkle, 2016a). Inkle also maintains a document on how to run Ink in the Unity development engine or any other C# environment (Inkle, 2106b), although this will only be useful to those with existing knowledge of how to create games in Unity.

Rather than duplicating Ink’s documentation on its advanced features, the remainder of this article will look at a finished Ink game created as part of an OER.

## ScholCom 202X: An Interactive OER

In late 2020, I learned about an open submission period for the Scholarly Communication Notebook  ([https://lisoer.wordpress.ncsu.edu/notebook/](https://lisoer.wordpress.ncsu.edu/notebook/)), a planned repository of OERs that “reflect and encourage diversity in scholarly communication.” The aim of the Scholarly Communication Notebook is to provide new and student librarians with education not just about scholarly communication concepts but about social justice concepts as they apply to a library setting.

These requirements made interactive fiction a good fit for several reasons. Since IF is presented as a story, rather than a non-fiction resource, it offered the potential to build in diversity with a wide cast of non-player characters. Likewise, IF’s status as a narrative work could be used to offer a simulation-like experience for the player, allowing them to put scholarly communication principles into action rather than just reading about them.

With this in mind, I proposed an interactive OER called “ScholCom 202X.” Rather than using the present-day, I decided to set the OER in a futuristic, “cyberpunk-lite” library, both because I thought a unique setting would make the experience more engaging and because it would let me draw on my decade of experience as an author of science fiction short stories. The main science fictional element is an “augment,” an imaginary mobile device the player can consult at key moments throughout the game and which provides them with an annotated bibliography and an overview of how busy they are.

After my proposal was accepted, I spent several months researching, drafting and coding the game, as well as producing a non-interactive PDF version for use with in-person roleplay exercises or if a user would rather read static text than play a game for whatever reason. The final draft of ScholCom 202X is an Ink file which presents the player with ten distinct scenarios a scholarly communication librarian might encounter, each with its own set of choices to make and resources to consult. As players move through ScholCom 202X, they make choices about how much time they want to spend helping the NPC in each scenario. This adds a time management aspect to the game, tracked using variables and a simple function. I also wrote a function to let the player choose whether they wanted to see all ten scenarios or play a shorter game that only presents a few at random. In total, these scenarios and functions made up 13,637 words of content, with each scene reproduced in equivalent PDF files. A presentation about the process, given at the Online Northwest conference in March of 2021, contains more information (Baker, 2021).

The remainder of this article will look at several pieces of code from ScholCom 202X to show how Ink and IF concepts can be used in practice to create an OER.

### Tracking the Player’s Choices with Variables and Functions

Each time a player makes a choice in ScholCom 202X, they receive reputation points based on how helpful that choice is. At the same time, though, high-reputation choices fill up more of the player’s work schedule. Both numbers are tracked using variables declared at the very beginning of the Ink file for the game, where they’re set to a default value of zero:

| 1  2 | `VAR schedule = 0`  `VAR rep = 0` |
| --- | --- |

Each time the player makes a choice at the end of a scenario, they receive between 0 and 2 points to both of these variables depending on how helpful they are being. For example, middling choices earn the player 1 reputation point and add one point to their schedule:

Although the reputation points are invisible to the player until the end of the game, players can check how busy they are towards the end of each scenario by selecting a choice marked “Check Your Calendar” before they decide how to respond to that scenario’s NPC. Although code for this could be reproduced in each section, it makes more sense to define a function that stores the code and call it in each relevant location.

This code calls the function defined below, which checks the value of the “schedule” variable and outputs text according to how much work the player has promised to do for people:

| 1  2  3  4  5  6  7  8  9  10  11  12  13 | `=== function CheckCalendar() ===`  `{`  `-schedule == 0:`  `It's completely blank. <em>Nice</em>!`  `-schedule > 0 && schedule <= 3:`  `There are a few things on there, but it's not too bad. Plenty of time to pursue your own research on top of work.`  `-schedule > 3 && schedule <= 7:`  `Hmm, it's starting to fill up a bit. You'd better not take on any more major projects, or you'll regret it.`  `-schedule > 7 && schedule <= 10:`  `<em>Man</em>, there's a lot on there. So much for your lunch break, you guess. `  `-schedule > 10:`  `It's a mistake. You close the calendar again quickly. Those blocks of time where you're double-booked were just an illusion, right? You hope you won't have to spend <em>too much</em> time working on the weekends and evenings to get everything done...`  `}` |
| --- | --- |

At the end of the game, two similar pieces of code give the player an idea of how helpful they’ve been and how busy their schedule is. Because these are only used once, a function was not used and the code was simply inserted into its own stitch for use with a direct, like any other content that comes after a choice.

### A ScholCom 202X Scenario

In one ScholCom 20X scenario, an NPC approaches the player to ask about OERs. The code reproduced below is split into sections for readability but is a single 215-line piece of code in the game itself.

The section begins with a stitch called OERStart (I didn’t use knots as the game was not long or complex enough to need them), then guides the player through a conversation with the NPC that ends in a set of choices.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33 | `=OERStart`  `//9: A faculty member wants to find OERs for use in a class`  `<h2>Scenario {days}: The Case of the Algebraic OER</h2>`  `It's around noon, and you're cleaning up your lunch things in the staff lounge after a hard morning's work and a satisfying meal of riced with steamed vegetables. Nobody's around — apparently you eat earlier than your new colleagues — and so when your augment buzzes, you go ahead and accept the call.`  `It's from an adjunct faculty member in the math department named Luis Nunes, and they don't list pronouns or much other information on their public feed. "Hi Luis," you say. "What can I help you with?"`  `* They speak, but no sound comes through.->OER2`  `=OER2`  `"Sorry," you interrupt, "I think your mic is set to mute."`  `They frown, concentrate for a minute, then try again. "How's that?"`  `"Much better."`  `"Great. I was told you could help me find free textbooks for an algebra class I'm teaching next term. Is that correct?"`  `"OERs, you mean?"`  `They shrug. "Are those textbooks?"`  `* "Sometimes!->OER3`  `=OER3 `  `The acronym stands for Open Educational Resources. Basically, you can think of them as any kind of resource that can be used in a classroom setting — that includes textbooks, but there are other options, too. Anything from short chapters to videos with attached quizzes to, well, even educational games."`  `Luis looks skeptical. "And they're free? The department's supposed to be looking into reducing student costs for our basic classes, since they're required by so many majors and minors on campus."`  `"That makes sense," you say, trying to get back into their good graces. "And yes, OERs are definitely free. They're released under a special kind of license which gives people permission to read them."`  `* That earns you a tight nod.->OER4`  `=OER4`  `"But are they good quality? What if I can't find one that works the way I want? What if something in it is <em>wrong</em>?"`  `You smile. "They're written by professors and other experts, just like textbooks are. And if the way one approaches a subject is at odds with what you do in your class, you can usually modify it under the terms of the license. It depends, but..." You shrug, not wanting to overwhelm them with too much information. "There are lots of options for stuff like that, basically."`  `Another nod. "Okay, sounds good. So what now?"`  `What indeed?`  `->OERChoicesStart`  `=OERChoicesStart`  `* [Check your Augment.]->OERSources`  `* [Check your Schedule.]->OERSchedule`  `* [Respond to their question.]->OERChoices` |
| --- | --- |

Note that each part of the conversation ends in a “choice” with only one option. This breaks the lengthy dialogue up into smaller, more digestible chunks. For added engagement, multiple dialogue options could be offered throughout the section to portray the back and forth of a conversation more realistically.

At the end of this piece of code, the player must make their first real choice of the section: deciding whether to answer right away, check how busy they already are (using the function explained earlier), or consult a brief annotated bibliography on the topic. Including the string “https://” in Ink code gave me problems, so I inserted correctly formatted URLs after the game was completed by directly modifying the JavaScript file Ink creates during the last step of the export process.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 | `=OERSources`  `Cox, G., & Trotter, H. (2017). An OER framework, heuristic and lens: Tools for understanding lecturers' adoption of OER. Open Praxis, 151-171. www.learntechlib.org/p/181421/ `  `Cox & Trotter discuss necessary factors for the adoption of OERs at any given institution, and by any given instructor. They suggest that approaching OER through a lens of institutional culture is the most effective way to encourage faculty to adopt OERs for their courses if the infrastructure in the region supports their adoption.`  `OER Commons. (n.d.). Open textbooks. OER Commons. Retrieved November 25, 2020, from www.oercommons.org/hubs/open-textbooks `  `Hundreds of textbooks released to the public under an open license. The larger OER commons site also has other types of resources.`  `OpenStax. (n.d.). OpenStax. Retrieved November 25, 2020, from openstax.org/ `  `OpenStax textbooks are free to use, and also include integrations with Blackboard, Canvas, and other popular learning management systems. OpenStax is run by Rice University, who also offers webinars on how to use their system.`  `University of Minnesota. (n.d.). Open textbook library. Retrieved November 25, 2020, from open.umn.edu/opentextbooks/ `  `University of Minnesota's Open Textbook Library contains more than 800 openly licensable textbooks.`  `->OERChoicesStart`  `=OERSchedule`  `You pull up your calendar on your augment. `  `{CheckCalendar()}`  `->OERChoicesStart` |
| --- | --- |

Note that both these stitches end in diverts back to the OERChoicesStart stitch which contains the three choices at the end of the preceding code snippet. This way, the player can explore all the sources and their calendar before deciding how to respond to the NPC’s question. Once they click the “Respond” choice, they are directed to a new set of choices.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28 | `=OERChoices`  `You take a deep breath. Time to decide.`  `* "Have you tried searching on G**gle for them yet?"[]<br /><br />->OERSlacker`  `* "Let me send you some links."[]<br /><br />->OERResponsive`  `* "Do you have some time now? I can show you where to look and what to look for."[]<br /><br />->OEROverAchiever`  `=OERSlacker`  `Luis signs off looking pretty offended, and you try not to laugh.`  `But, really, this stuff is <em>super</em> easy to find. Why shouldn't they do a little bit of legwork for their own classes?`  `You do feel a little guilty, though, so you quickly email them a few links that might be useful, with an apology if you were rude. Who knows if it'll make them less annoyed, but at least it should help out a bit.`  `->ScenarioEnd`  `=OERResponsive`  `Luis signs off with a brusque "thanks," and you try to avoid rolling your eyes.`  `All the same, whether or not someone is a bit rude doesn't mean you shouldn't help them. And so many students have to take the core math classes that the knock-on effects will be huge if the department adopts OERs instead of making everyone buy expensive textbooks.`  `You pull together a few links and some quick explanations and send them Luis's way, along with some suggestions on how they might modify any OERs they like, or integrate them into their classes. If they have further questions, they'll just have to get in touch again.`  `~rep++`  `~schedule++`  `->ScenarioEnd`  `=OEROverAchiever`  `"I do," Luis says.`  `They interrupt you every few minutes as you're searching for OERs and explaining them, to the point where what should have taken a few minutes lasts more than an hour. Fortunately, you didn't have anything else scheduled, and at the end of the call Luis seems pretty pleased with the OER you've helped them select.`  `"I can't wait to show the rest of the department this," they tell you. "It's even better than our current texts in some ways, and the fact that we can just update it ourselves is going to be a gamechanger!`  `Their enthusiasm is catching, and you find yourself energized as well once they sign off, ready to move on to your next task.`  `~rep+=2`  `~schedule+=2`  `->ScenarioEnd` |
| --- | --- |

After reaching the end of the scenario, the player is diverted to the “ScenarioEnd” stitch, which produces one of several messages suggesting the end of the workday and then moves them to another scenario at random, taking into account how long of a game they elected to play and which scenarios they have already completed. Once the player completes enough scenarios, the code in the “ScenarioEnd” stitch diverts them to the very end of the game where they are given a summary of their time as a scholarly communication librarian.

## Conclusion

Learning games can be effective ways to deliver educational information to students. Interactive text-based games, which require fewer technical skills to create and play and which can be directly hosted on websites and repositories for ease of distribution, may be particularly attractive for small teams of educator-developers or individual writers who lack advanced programming knowledge. This article has focused on the Ink scripting language, showing how it can be used to create an interactive narrative game where player choices affect the outcome. Although any IF language has its own pros and cons, Ink’s flexibility and relatively simple markup make it a good choice for anyone writing a text-based game for the first time.

How helpful ScholCom 202X will be to new and aspiring scholarly communication librarians is an open question, as is how effective text-based learning games are in general. I hope to explore these questions with future projects, although I think the research on graphic learning games also speaks to text-based games’ potential as educational entertainment. For now, anyone who wants to try out ScholCom 202X for themselves can play the final version of the game online via [the project’s GitHub repository](https://github.com/scbaker/ScholCom202X) or [the Scholarly Communication Notebook blog](https://lisoer.wordpress.ncsu.edu/2021/05/18/new-to-the-scn-scholcom-202x-an-interactive-fiction-game/).

## References

Baker S. Choose Your Own Education: Interactive Fiction and Online Instruction. Online Northwest. 2021. Available from https://pdxscholar.library.pdx.edu/onlinenorthwest/2021/schedule/5/

Backlund P and Hendrix M. Educational Games – Are They Worth the Effort? A Literature Survey of the Effectiveness of Serious Games. 5th International Conference on Games and Virtual Worlds for Serious Applications (VS-GAMES). IEEE; 2013. Available from https://curve.coventry.ac.uk/open/file/68df0eec-4e9b-4c70-8577-5cc2424b5856/1/Educational%20games.pdf

Bigelow B. On the Road to Cultural Bias: A Critique of the Oregon Trail CD-ROM. Language Arts. 1996; 74(2): 84-93. Available from https://www.jstor.org/stable/41482844

Boller S and Kapp KM. Play to Learn: Everything You Need to Know about Designing Effective Learning Games. Alexandria, VA: American Society for Training and Development; 2017.

Bouchard RP. A Brief History of the Oregon Trail Game. \[Internet.\] 2019. Available from http://www.died-of-dysentery.com/stories/brief-history.html

Carless S. 2008. Great Scott: Infocom’s All-Time Sales Numbers Revealed. \[Internet.\] 2008. Available from https://web.archive.org/web/20080924074642/http://www.gamesetwatch.com/2008/09/great\_scott\_infocoms\_alltime\_s.php

Fabulich D. Choicescript License V1.0. \[Internet.\] 2010. Available from https://github.com/dfabulich/choicescript/blob/master/LICENSE.txt

Fokides E, Atsikpasi P, Kaimara P, and Deliyannis I. Factors Influencing the Subjective Learning Effectiveness of Serious Games. Journal of Information Technology Education. 2019; 18. Available from http://jite.org/documents/Vol18/JITEv18ResearchP437-466Fokides5777.pdf

Harvey A. Games as Education in the United Kingdom. Journal of Learning and Teaching in Higher Education. 2018; 1(1). Available from https://journals.le.ac.uk/ojs1/index.php/jlthe/article/view/2539

Inkle. Writing with Ink. \[Internet.\] 2016. Available from https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md

Inkle. Running Your Ink. \[Internet.\] 2016. Available from https://github.com/inkle/ink/blob/master/Documentation/RunningYourInk.md

Interactive Fiction Technology Foundation (IFTF). n.d. Frequently Asked Questions about Interactive Fiction. Available from https://iftechfoundation.org/frequently-asked-questions/

Kim E. Effect of Simulation-based Emergency Cardiac Arrest Education on Nursing Student’s Self-Efficacy and Critical Thinking Skills: Roleplay Versus Lecture. Nurse Education Today. 2018; 61: 258-263. Available from https://doi.org/10.1016/j.nedt.2017.12.003

LaPensée E and Emmons N.  Indigenizing Education with the Game When Rivers Were Trails. Amerikastudien. 2019; 64(1): 75-93. Available from https://www.academia.edu/download/61875819/IndigenizingEducation\_WRWT20200123-72845-1yf0b9m.pdf

Montfort N. Twisty Little Passages. Cambridge, MA: MIT Press; 2003.

Overland C. Using Roleplaying Simulations and Alternate Reality Gaming to Develop Professional Behaviors in Pre-Service Music Teachers: A Qualitative Case Study. Contributions to Music Education. 2017; 42: 107-127. Available from https://eric.ed.gov/?id=EJ1141729

Roozenbeek J and Van der Linden S. Breaking Harmony Square: A Game that “Inoculates” against Political Misinformation. Harvard Misinformation Review. 2020. Available from https://misinforeview.hks.harvard.edu/article/breaking-harmony-square-a-game-that-inoculates-against-political-misinformation/

Vasquez J. Why Depression Quest Matters. Game Revolution. \[Internet.\] 2014. Available from https://web.archive.org/web/20140819144011/http://www.gamerevolution.com/manifesto/why-depression-quest-matters-27657

Secchi M. Ink. \[Internet.\] n.d. Available from https://marcosecchi.github.io/resources/pages/gamedev\_storytelling\_ink.html

Short E. Writing IF. \[Internet.\] n.d. Available from https://emshort.blog/how-to-play/writing-if

*Stewart Baker* is the systems & institutional repository librarian at Western Oregon University, as well as a science fiction and fantasy author and poet outside of work hours. He has been writing interactive fiction since 2015, and his interactive OER written in Ink, “ScholCom 202X,” is forthcoming in the Scholarly Communication Notebook.
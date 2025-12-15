---
title: "Developing an online platform for gamified library instruction"
source: "https://journal.code4lib.org/articles/12122"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-01-30
created: 2025-01-10
description: "Gamification is a concept that has been catching fire for a while now in education, particularly in libraries. This article describes a pilot effort to create an online gamified platform for use in the Woodbury University Library’s information literacy course. The objectives of this project were both to increase student engagement and learning, and to [...]"
tags:
  - "clippings"
---
# Developing an online platform for gamified library instruction
Jared Cowing

Gamification is a concept that has been catching fire for a while now in education, particularly in libraries. This article describes a pilot effort to create an online gamified platform for use in the Woodbury University Library’s information literacy course. The objectives of this project were both to increase student engagement and learning, and to serve as an opportunity for myself to further develop my web development skills. The platform was developed using the CodeIgniter web framework and consisted of several homework exercises ranging from a top-down two-dimensional library exploration game to a tutorial on cleaning up machine-generated APA citations. This article details the project’s planning and development process, the gamification concepts that helped guide the conceptualization of each exercise, reflections on the platform’s implementation in four course sections, and aspirations for the future of the project. It is hoped that this article will serve as an example of the opportunities–and challenges–that await both librarians and instructors who wish to add coding to their existing skill set.

## Introduction

Undergraduate students at Woodbury University are required to take a 1-unit information literacy class, *Information Theory and Practice,* which is taught by librarians. Each librarian is allowed flexibility in customizing their course sections to suit their teaching style and to try new ideas. A librarian wishing to make such customizations might find themselves frustrated with functional limitations presented by Moodle, Woodbury’s course management system. Those possible frustrations include the rigidity in how online activities may be structured: instructors can create a multiple-choice quiz or prompts for the student to write an answer to a question, but it is not possible to create deeper interaction through the recall and manipulation of previous answers or through more advanced logic to determine custom reactions to student responses. Another frustration might be the visual experience of using Moodle; assignment content competes with other visual information that lines all four sides of the browser window, increasing the [cognitive load](https://en.wikipedia.org/wiki/Cognitive_load) of users. This visual information ranges from layer-upon-layer of navigation bars to Moodle announcements to footer disclaimers. While Moodle provides us with deep functionality in many areas that is invaluable, the overall user experience of Moodle could be described by few as ‘fun’ or ‘inspiring curiosity.’ Upon encountering these frustrations, I began a project to develop a web platform that could host more customized and interactive class assignments.

## Initial Experiment and Obstacles

The goal of this project started out simple: To create an interface that could accommodate multiple-choice questions or written answers, and that allowed for more flexible responses to user input. Just as importantly, the interface needed to be as visually clean as possible, containing the absolute minimum of noise necessary. The hope with this visual approach was that it might reduce cognitive load and help users focus more on the single question being presented to them at any given time.

Such an interface was relatively simple to create with basic HTML/CSS, Javascript, and PHP. It was indeed a cleaner visual experience. However, it became quickly apparent that despite some visual benefits, the functionality was not unique enough to justify a departure from Moodle. Editing the questions required directly entering them in the PHP code, which was certainly no faster than editing questions through a graphic user interface in Moodle. Additionally, there was no authentication or database system in place to securely identify and store student answers. To justify any time spent pushing this idea further, I would need to stop and think more clearly about my goals and the technology needed to achieve them. As someone with novice coding skills, these initial efforts represented an effort to have some fun coding a basic interactive tool. To progress any further, the project’s more personal goals would need to take a back seat to the realistic needs of a web platform intended for a real classroom environment.

![](https://journal.code4lib.org/media/issue35/cowing/image1.jpg)  
**Figure 1.** This might look cleaner than Moodle, but is this quiz that much more engaging, or is it just reinventing the wheel?

## Getting Serious About Having Fun

Taking the time to stop and think about where this project was going revealed a clearer set of goals and requirements: A platform or framework was required that allowed for basic functions like user authentication and sessions, the storage/retrieval of information from a database, and usage of a templating system. This platform could not be so overly complex that I would need to spend my time learning how to do things ‘the Drupal way,’ for example, and in so doing lose some ability to be flexible and improvise. From a pedagogical standpoint, I required the ability to create assignments that were interactive, engaging, personalized, and that could vary widely in structure from week-to-week. The answer to these technological needs, CodeIgniter, came through the suggestion of a colleague. The answer to the pedagogical needs came through the concept of gamification.

### CodeIgniter

CodeIgniter is a PHP-based web framework that is lean, efficient, and highly extensible. It is built on [MVC architecture](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) (model-view-controller) and represented the ideal balance of functionality with the simplicity that allowed for rapid development. The documentation is up to date and extremely clear, and is written in a way that allows for the flexibility to either take advantage of CodeIgniter’s MVC structure or ignore it completely. For a beginner, it represents the ideal sandbox to work in with just the right amount of fool proofing to keep one out of trouble.

### Gamification

Gamification has only recently gotten a name but has been a trend in education for some time. At its core, it is “using game-based mechanics, aesthetics, and game thinking to engage people, motivate action, promote learning, and solve problems” (Kapp 2012). It does not need to be the literal use of games in the classroom; rather, it can be any effort that utilizes motivational mechanisms that also exist in games. Done well, it should not come off as a gimmick or as an excuse to play games. Rather, gamification in the classroom should be used with clear learning objectives in mind. To dig deeply into how or why it might work, it is necessary to delve into game theory and the psychology of motivation. Many such theories attempt to break down the individual mechanisms present in most games (Kapp 2012). Other theories detail the various personality types that gravitate to different game mechanisms (Bartle 1996). Still more theories attempt to define the very concept of “fun” or the conditions necessary for a person to experience motivation (Deci and Ryan 2000).

## Working Result

Utilizing CodeIgniter and the principles of gamification in a new round of development, the result was a platform containing five separate homework assignments. To access each assignment, the student would click on a link in Moodle that took them to a login screen specific to that assignment. Each student’s login credentials were set manually in code at the onset of the course. After logging in, the student would get an introductory screen letting them know what they could expect. After that point, the nature of each assignment diverged considerably.

The first two homework assignments were largely multiple choice and text-answer based, and utilized much of the pre-CodeIgniter code. Questions were mostly stored and supplied through a PHP script that existed outside of CodeIgniter’s MVC structure and were dynamically inserted into the page through jQuery animations.

![](https://journal.code4lib.org/media/issue35/cowing/image2.jpg)  
**Figure 2.** The beginning of Homework #2, which includes custom paths based on the student’s choice of major.

The third homework was the first one conceptualized after CodeIgniter and gamification became integrated into the project. The objective of this assignment was to prepare students for a physical library tour that would be taking place the following class. The intent was to have students start the tour already curious about various shelving locations and materials in the library. To achieve that end, the homework assignment became a top-down game in which students had to move around a representation of the library’s floor plan to discover all our shelf locations–along with several easter egg locations. At the end of the game, students receive a prompt to go to the library in person, find some of these shelf locations, and write some observations in a Moodle forum. The game was built mostly using Javascript and CSS, and consists of several HTML tables used to simulate the floor plan of each library space. When a player presses an arrow key to move, their current location and desired movement direction are checked against an array of 1’s and 0’s that dictate whether a player can or can’t move in that direction. This array also helps determine whether an event will be triggered upon entering the destination ‘tile.’ Curious readers can try the game [here](http://www.bibliotreka.com/lsci/index.php/Heroes/homework/hw3) using ‘code4lib’ as both the username and password.

The objective of the fourth assignment grew out of my own classroom metaphor that research is like assembling a team of superheroes, in that one must think about how each source complements the strengths and weaknesses of the others, and how each helps to accomplish the ‘mission’ at hand. This metaphor is to counter a common student temptation to find several similar sources that all provide the same information. To encourage students to practice this ‘team building’ mentality, the objective of this assignment was to have students assemble a team of ‘heroes’ (sources) to help answer a previously identified research question. The homework consists of a workspace in which they can fill in basic information on each hero to demonstrate what role it plays in their research. Students can also see how far along they are using a progress bar. When they select a type of source to categorize their hero under, a corresponding insignia is revealed to show that they have ‘recruited’ a new source to their team.

![](https://journal.code4lib.org/media/issue35/cowing/image3.jpg)  
**Figure 3.** The fourth homework assignment on this site, labeled here as #7 because assignments 4-6 were separate activities completed outside of this site.

Making this assignment work required much more constant communication with the MySQL database of student responses, and so the MVC architecture of CodeIgniter was leveraged much more in order to access its native database functions. While there are advantages to the visual continuity provided when using jQuery to dynamically insert new content on a page, properly taking advantage of CodeIgniter’s database driver tools required sending information to a controller PHP script and–in so doing–loading a new page using a coded URL. Receiving information from the PHP script and displaying it on the page also necessitated the reloading of pages. I took from this assignment a much better appreciation of the power available through more fully utilizing CodeIgniter’s core architecture.

The final homework assignment on this site involved citations and APA formatting. Few people would call this their favorite topic, and so the challenge in developing this assignment was to make it engaging and to prompt students to pay closer attention to how and why citations are used. The result was an assignment containing a mix of small exercises including a ‘seek the citation errors’ mini-game. It also would recall and display students’ answers from previous assignments to prompt them into thinking about what information they would need to look the source up again.

## Reception, Aspirations, and Advice

This platform was developed mostly through the winter of 2015/16 and has so far been used by myself while teaching four sections of *Information Theory and Practice*–one in Spring 2016, one in the summer, and two this fall. Some takeaways became clear early on, while others have taken some time to think over.

### Student reactions

The most positive reaction seemed to come from the top-down game. Students would begin the following physical library tour asking about parts of the library–such as our loft space–that they did not previously know existed. My speculation is that the positive reaction came in part because this assignment is the most game-like of them all. Additionally, the fact that the game’s setting was in our own library may have made the experience more personal and relatable.

The version of this platform that was used in the spring and summer did not contain the functionality to recall a student’s previous answers. If they restarted a homework assignment, any answers already submitted would not populate in text boxes (except for the “hero recruiting” assignment, which required the recall and display of stored answers to work properly). While this shortcoming was disclaimed in the assignment instructions, it understandably led several students to think that their assignments had been erased or never received for grading. This was a frustrating user experience resulting from my having omitted a critical feature. In the time between the summer and fall semesters, the functionality necessary to display and modify a student’s prior answers was added.

### Aspirations for the Project

While the result of this project–a gamification of my homework assignments–was worthwhile, the next goal is to think about ways that the platform could be extended to further infuse those concepts into class lectures and in-class activities. Those gamified in-class activities that have been used–such as an online drag and drop call number sorting exercise I developed–appear fairly successful in engaging students.

Another aspiration is to develop assessment measures to better gauge the platform’s effectiveness. It is difficult to gauge a student’s reactions while they complete a homework assignment beyond looking at their homework answers and their overall class performance. In addition, student responses in the standard University course evaluations were usually more general in nature and made few distinctions between the gamified class elements being tested and the core elements that were shared by all sections of *Information Theory and Practice*. To better measure the success of these efforts, a new assessment method will be needed that prompts more specific feedback from students.

Researching the theories behind gamification has provided new lenses through which to analyze each class assignment and look for ways to engage different types of learners. Delving deeper into the literature on gamification may reveal new ways that different personality types could be motivated when completing these assignments. These efforts will help to ensure that my own attempts at gamification are not limited by personal preferences for what features are the most engaging and instructive. One possible step might be to empower students who are more motivated by social or competitive game mechanisms; this could be done through features like allowing students in the top-down library exploration game to drop notes and items on the library floor for their other classmates to find.

In teaching a graded course, more control is offered in that students become partly responsible for observing the technological requirements of each assignment. This represents a departure from the realities experienced by professional web developers, who must be prepared to serve users of any device, operating system or internet browser. This platform made heavy use of CSS3 and jQuery animations that rendered older versions of Internet Explorer useless, and it came as a great surprise just how many students were still using these older browsers. Looking forward, one final goal is to explore making this web platform more accessible for users of different browsers and devices, and also for users with visual disabilities.

### Advice for Others

In addition to the other stated goals of this project, it also served as one possible example of how an instructor or librarian might–or might not–be able to use basic coding skills as a tool in their pedagogical toolkit. A project of this nature could be rewarding for both the instructor and students, but with major cautions. One caution is that for any experimental product created by a novice coder, students may find bugs or encounter the occasional user experience difficulty. Expect some inquiries on weekends and in the late of the night, and be prepared to offer quick responses to address any problems right away. Students may need to be offered the benefit of the doubt, and some flexibility, if they say that they ran into trouble. No student wants to be penalized for a technical issue.

Beginning coders should be encouraged to let their imaginations run wild and not be afraid to build things that are flawed in conception and wildly inefficient in execution. It is easy to allow the rigid and complex structures of professional coding practice to dim the light of inspiration that will drive a novice to learn. It is that messy sort of trial and error that can nurture a long-lasting love for coding, and it may produce the occasional innovation worth keeping. Nevertheless, if the intent is to finish with a polished product used by others, one must be prepared to scrap much of what has been done in order to build again with a clear strategy and outcomes in mind. For learning purposes, there should be no shame in having to do something twice if unique insight was gained each time–provided that no deadlines were missed along the way.

## Conclusion

I plan to continue using this platform for the near future, with a stronger focus on assessment and a willingness to continually make strategic improvements. I’m especially interested in getting feedback from more seasoned developers and instructors alike about what they think could be improved or done differently. While this project was far from groundbreaking in the technical or pedagogical sense, the hope is that it represents a realistic example of what can be produced by a librarian or instructor who is interested in trying their hand at coding.

## References

Bartle R. 1996. Hearts, clubs, diamonds, spades: Players who suit MUDs. Journal of MUD Research.

Deci EL, Ryan RM. 2000. Self-determination theory and the facilitation of intrinsic motivation, social development, and well-being. American Psychologist. 55(1).

Kapp KM. 2012. The gamification of learning and instruction: Game-based methods and strategies for training and education. San Francisco: Pfeiffer.

## Further Reading

de Jong T. 2010. Cognitive load theory, educational research, and instructional design: Some food for thought. Instructional science \[Internet\]. \[cited 2016 Nov 18\];38(2):105-134. Available from: http://link.springer.com/article/10.1007/s11251-009-9110-0

Ke F. 2009. A qualitative meta-analysis of computer games as learning tools. In: Ferdig RE, editor. Effective electronic gaming in education. Hershey (PA): Information Science Reference. p. 1-32.

Madigan J. 2016. Getting gamers: The psychology of video games and their impact on the people who play them. Lanham (MD): Rowman & Littlefield.

Sitzmann T. 2011. A meta-analytic examination of the instructional effectiveness of computer-based simulation games. Personnel Psychology. 64(2): 489-528.

[Jared Cowing](https://journal.code4lib.org/articles/) is the Systems Librarian and an Assistant Professor at Woodbury University in Burbank, CA. His professional interests include the gamification of libraries and the development of more interactive, intuitive library discovery interfaces using rich library metadata.
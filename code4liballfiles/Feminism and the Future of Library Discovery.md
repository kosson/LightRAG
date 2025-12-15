---
title: "Feminism and the Future of Library Discovery"
source: "https://journal.code4lib.org/articles/10425"
author:
  - "[[The Code4Lib Journal]]"
published: 2015-04-15
created: 2025-01-10
description: "This paper discusses the various ways in which the practices of libraries and librarians influence the diversity (or lack thereof) of scholarship and information access. We examine some of the cultural biases inherent in both library classification systems and newer forms of information access like Google search algorithms, and propose ways of recognizing bias and [...]"
tags:
  - "clippings"
---
# Feminism and the Future of Library Discovery
Bess Sadler, Chris Bourg

This paper discusses the various ways in which the practices of libraries and librarians influence the diversity (or lack thereof) of scholarship and information access. We examine some of the cultural biases inherent in both library classification systems and newer forms of information access like Google search algorithms, and propose ways of recognizing bias and applying feminist principles in the design of information services for scholars, particularly as libraries re-invent themselves to grapple with digital collections.

## Libraries are not Neutral

In spite of the pride many libraries take in their neutrality, libraries have never been neutral repositories of knowledge. Research libraries in particular have always reflected the inequalities, biases, ethnocentrism, and power imbalances that exist throughout the academic enterprise through collection policies and hiring practices that reflect the biases of those in power at a given institution. In addition, theoretically neutral library activities like cataloging have often re-created societal patterns of exclusion and inequality. For example, in *The Power to Name*, Hope Olson documents the ways the Dewey Decimal system has historically reflected patterns of knowledge organization that now seem archaic, such as classifying the subject of pregnancy under the heading of disease, and the subject of lynching under the heading of law enforcement (Olson 2002). While historic distance makes it easier to recognize these examples as obvious instances of societal power imbalance appearing in library practice, it might not be so easy to recognize current examples of supposedly neutral practice in libraries that are actually perpetuating similar power imbalances.

Those of us creating library software and building digital libraries must also address this issue. Just as the classification systems created by libraries carry the aura of “neutrality” and mask the bias reflected within them, the digital systems that libraries provide to our users are also assumed, by virtue of existing within a library, to be a “neutral” reflection of subject knowledge. However, just as with classification systems, this neutrality is an illusion. In this paper, we argue that without an explicit feminist agenda, the same processes of exclusion and marginalization that have always influenced libraries — and therefore scholarship — will continue to play out in our digital library and online discovery environments.

We define library discovery as the set of affordances through which users search, explore, find, and interact with the information resources they need, particularly collections held by a library. For the purposes of this paper, we will focus on digital systems for library discovery, such as search algorithms, library software, and online collections. For our analysis, we borrow from the field of Human Computer Interaction (HCI) and Shaowen Bardzell’s paper “Feminist HCI: Taking Stock and Outlining an Agenda for Design” (Bardzell 2010). Bardzell outlines some of the characteristics of feminist software interaction, which she defines as plurality, self-disclosure, participation, ecology, advocacy, and embodiment. We hope that by examining these qualities in the context of library discovery we can encourage the development of library discovery systems that resist patterns of erasure, exclusion, and marginalization.

## Pluralism and Self-Disclosure in Search

In “Feminist HCI,” Bardzell discusses how feminist theory can inform the field of human computer interaction. Certain constellations of qualities characterize feminist human computer interaction, she argues. So what would library discovery that possessed these qualities of feminist interaction look like? And how might we explicitly design for that?

We might, for example, invoke feminist rhetoric in our critique of search technologies and demand that the search solutions we employ value pluralism and self-disclosure. According to Bardzell, “the quality of pluralism refers to design artifacts that resist any single, totalizing, or universal point of view” (p. 1305) and the quality of self-disclosure refers to the extent to which the software renders visible the assumptions it is making about its users (p. 1307).

Search software, in order to provide feminist interaction, needs to be particularly concerned with pluralism and self-disclosure because it deals with questions of relevancy and significance. A single, totalizing, or universal point of view to the questions “What is relevant?” and “What is significant?” is likely to re-create existing societal patterns of exclusion and marginalization. Unfortunately, we have something very similar to a single point of view on the question of relevance and significance in the form of Google’s search algorithms. Although Google’s exact search algorithms are trade secrets and shift over time, we do know that they are based on a patented and published algorithm called PageRank, and that they work by defining relevance and significance by looking at what pages on the Internet are linked to most often on a given subject ([https://en.wikipedia.org/wiki/PageRank](https://en.wikipedia.org/wiki/PageRank)). This creates a majority-rules definition of relevance that masquerades as neutrality.

The concept of neutral relevance is an oxymoron, and yet neutrality is often what is sought in the design of search algorithms. In a recent antitrust lawsuit brought against Google, rival search engines demanded that Google use “neutral” search algorithms and display search results in a “neutral” manner. One need not invoke feminist theory to see how meaningless such a demand is; *Forbes*, hardly a bastion of feminist thought, called the concept of a neutral search engine “incoherent” (Ammori and Pelican, 2012).

In “Missed Connections: What Search Engines Say About Women,” Safiya Umoja Noble illustrates some of the problems with Google’s consensus-based relevancy. She describes an exercise in which she asks her university students to imagine themselves an African-American aunt, mother, mentor or friend who is trying to help young multicultural women learn to use the Internet. She asks what they would search for to find content young black girls might be interested in, and asks what search strategies they might employ to learn about black accomplishments, identities, and intellectual traditions:

> Someone inevitably volunteers to come forward and open a blank Google search page–a portal to the seemingly bottomless array of information online–intending to find accurate and timely information that can’t easily be found without a library card or a thoughtful and well informed teacher.
> 
> Last semester, SugaryBlackPussy.com was the top hit. No matter which year or class the students are in, they always look at me in disbelief when their search yields the result. They wonder if they did something wrong. They double-check. They try using quotation marks around the search terms. They make sure the computer isn’t logged into Gmail, as if past searchers for pornography might be affecting the results. They don’t understand.

Noble summarizes: “Try Google searches on every variation you can think of for women’s and girls’ identities and you will see many of the ways in which commercial interests have subverted a diverse (or realistic) range of representations” (Noble 2013).

Noble’s classroom exercise demonstrates how Google search algorithms fail both our criteria for pluralism — because they represent a single majority-rules point-of-view masquerading as neutrality — and our criteria for self-disclosure — because the system does not render visible the extent to which is has been designed for an “ideal user.”

Libraries would do well to keep these lessons in mind as we adopt new technologies like linked data, which holds much promise for breaking the stranglehold of rigid categorization systems, but makes many of the same assumptions that the Google algorithms make — namely that the most commonly asserted statements must be the most true. Libraries should also be asking these questions of our journal article search systems. Until we and our users are allowed to data mine and index scholarly journal content ourselves, we rely on commercial publishers to define significance and relevance for us.

## Participation and Ecology in the production of technology

Bardzell’s quality of ecology in feminist interaction design calls for an awareness of the broadest contexts of the effects and of the widest range of stakeholders in considering design (p. 1307). The quality of participation refers to valuing participatory processes in the creative endeavor (p. 1306). In the creation of digital library systems, one might ask about the people building these systems and the environments in which the software is produced, as part of the software’s ecology. Similarly, one might ask about the methods used in the software’s creation and how participatory or inclusive they were.

More bluntly, when software is created in environments hostile against women, people of color, and other underrepresented groups, many kinds of inequity result. Currently, the majority of digital library software is built with open source software tools; even commercial or hosted digital library systems are built with open source components, requiring anyone who wants to help build them to participate in the world of open source software. This has many positive implications for the production of software capable of feminist interaction, as the open source software movement is built around the idea that software code should be freely shared and that everyone has the right to understand how software works.

However, the open source software community is also a notoriously sexist space, as documented in the twitter feeds of many women software engineers and in academic papers such as “Free as in Sexist: Free Culture and the Gender Gap” by Joseph Reagle. Reagle analyzed six years of discourse about gender and sexism within free culture communities. In spite of many attempts by women in those communities to raise awareness of the misogyny they encountered, Reagle still found that many communities rationalized low female participation as a matter of women’s choice, in part the result of a pernicious narrative of “techno-eager men and techno-phobic women” well documented in books like *Making Technology Masculine* by Ruth Oldenziel. The perpetuation of this narrative makes women’s exclusion seem natural and expected, and therefore a problem unworthy of addressing (Oldenziel, 2004).

This climate is part of the reason that only about 2 percent of open source software developers are women (Nafus, Krieger and Leach, 2006) and is incompatible with the idea of a feminist future for library discovery software, since it either prevents women from taking software development jobs, or forces them into hostile work environments. Unlike other harassment battles, however, the Internet has no human resources department to intervene.

This is an ongoing ethical challenge to libraries. As we shift our practice to digital collections, more library jobs — and many of the highest paying library jobs — are in the area of library software, requiring engagement with open source communities. Some strategies to make these jobs more accessible include efforts to foster involvement from underrepresented groups, such as internships targeted at women and gender minorities. However, efforts that focus exclusively on recruiting underrepresented groups into technology work reinforce the narrative that they are not naturally interested in technology and must be persuaded to participate. Crucially, these efforts fail to address harassment, and talented community members who are driven out of technology work every year by hostile environments (Melymuka, 2008; Wu, 2014).

Some of the best ideas on challenging sexism in open source software communities come from the Ada Initiative, a feminist organization dedicated to supporting women in open technology and culture communities. One of the Initiative’s recommendations has been to encourage software communities and conferences to adopt Codes of Conduct (Ada Initiative, 2015). What was once a controversial effort has become a widely accepted best practice within the realm of open source software, and, increasingly, among library conferences. In 2013, Stanford University Library became the first employer to encourage staff to attend only conferences with a Code of Conduct, and to lobby conferences without a Code of Conduct to adopt one (Keller, 2013). The authors hope this will be an increasing trend, as libraries and other employers grapple with their responsibility to create a safe work environment for their staff, even when that work environment extends beyond the walls of the institution.

## Advocacy and Embodiment in library interactions

Bardzell’s quality of embodiment means focusing attention on the bodies, emotions, motivating drives, and primordial urges of users. The quality of advocacy asks how we can design systems that improve users’ lives without imposing the designer’s view of what might constitute an improvement.

Focusing attention on the bodies of our users might mean prioritizing accessibility in our software, and thinking about the many ways we can make library resources available to users with a wide variety of impairments. Conducting usability tests with patrons who use assistive technologies can be a particularly enlightening technique, and one that allows them to tell us what would constitute an improvement.

Embodiment might also mean valuing emotional responses to our collections. For example, historian Natalie Zemon Davis discusses the specific emotional connection she feels when touching physical artifacts, like books. Among other subjects, she studied the lives of 16th-century printers to see what she could glean about the everyday experience of people who are (typically) undocumented in archives. One of the ways she did that was to visit libraries that held the books these 16th-century subjects had made. She argues that actually holding the books connected her to the people she was studying in a meaningful way (CBC Radio, 2011).

In our rush to digitize the kinds of rare books Davis loves to touch, have we asked ourselves what might be lost? Will high-resolution scans produce the same feeling of emotional connection? If there is a specific emotional response achieved by touching something that the person you are studying also touched, is that a valid reason for allowing physical access to a collection? We know this emotional response exists because people like Davis tell us so all the time, but we often dismiss it as unimportant. Should we dismiss it because it is emotional in nature, or should we make some effort to understand it, in hopes of recapturing that feeling in the digital realm?

From listening to historians like Davis, and from our understanding of psychology, it is clear that design decisions which divorce scholarship from emotional response are not in the best interests of our users. We make choices with our emotional responses, and then we come up with justifications after the fact. We know this from studies of people who have been truly divorced of their emotions on a neurological level and then become unable to make even simple decisions (Damasio, 1994). We also know that emotional states affect problem solving, and are tied to many unconscious problem solving centers in the brain (Kahneman, 2013). The necessity of design that engages our emotions is well documented in the HCI literature, for example in Don Norman’s *Emotional Design* (Norman, 2005).

Insisting upon the principles of Feminist HCI, including valuing users’ emotional responses, as we envision the future of the archive and our digital transition, thus becomes an urgency, particularly for those who are often erased from official archives. So what would it take for us to seriously focus on it?

Archival theorists like Jack Halberstam, in The Queer Art of Failure, and Ann Cvetkovitch, in An Archive of Feelings, both discuss the unrepresentability of trauma and the nature of the archive of trauma. Both engage with erasure of homosexuality in the Third Reich, recent history, and our present, as a trauma that must be grappled with in the archive.

Meanwhile, we who build digital libraries (which we hope future researchers will utilize) are designing new trauma archives. The open source software we build enables discovery for the collections of the United States Holocaust Memorial Museum, and archival collections at Stanford like the records of the STOP AIDS Project. One should not attempt to engage with these collections without a sense of embodiment and advocacy. We need to push back against the notion of the dispassionate researcher, the dispassionate archivist.

## Libraries should not try to be neutral

The work of libraries and librarians can do more than just support feminist research and agendas. We can play a critical role in supporting the causes of inclusion, plurality, participation and transparency. Building collections and developing the tools to access them are inherently political acts; we are creating the future library, the tools and collections that will be used to create new knowledge. The means of production for the archives of humanity are up for grabs, and within our reach is the possibility of new production methods that resist the recreation of existing patterns of exclusion and marginalization. However, this will be possible only if we approach this work consciously and with an understanding of the impact of our decisions.

*Bess Sadler* has been building open source software for libraries for over a decade, and is a co-founder of several widely-used open source software projects including [Project Blacklight](http://projectblacklight.org/) and [Project Hydra](http://projecthydra.org/). She is currently employed as the Manager for Application Development in the Digital Library Systems and Services group at Stanford University Library. Her opinions are her own, and do not necessarily reflect the views of her employer or any software projects with which she is associated.

*Chris Bourg* is the Director of Libraries at Massachusetts Institute of Technology (MIT), where she also has oversight of the MIT Press. Prior to assuming her role at MIT, Chris was Associate University Librarian for Public Services at Stanford University. Chris has a PhD in Sociology from Stanford University, and spent 3 years on the faculty at the United States Military Academy at West Point. She is keenly interested in issues of diversity and inclusion in higher education; and in the role libraries play in advancing social justice and democracy.

## Works Cited

Anti-harassment work: Conference anti-harassment policy \[Internet\]. Ada Initiative. \[cited 2015 Feb 17\]. Available from: [https://adainitiative.org/what-we-do/conference-policies/](https://adainitiative.org/what-we-do/conference-policies/)

Ammori, M, and Pelican, L. 2012. Why Search Bias Claims Against Google Don’t Hold Up. Forbes. \[cited 2015 February 17\] Available from: [http://www.forbes.com/sites/ciocentral/2012/06/07/why-search-bias-claims-against-google-dont-hold-up/](http://www.forbes.com/sites/ciocentral/2012/06/07/why-search-bias-claims-against-google-dont-hold-up/)

Bardzell, Shaowen. 2010. Feminist HCI: Taking Stock and Outlining an Agenda for Design. In: CHI 2010: HCI For All. April 10–15, 2010, Atlanta, GA, USA

CBC Radio. The Best Of The Sunday Edition July 17, 2011. \[Internet\]. \[cited 2015 February 17\]. Available from: [http://castroller.com/podcasts/TheSundayEdition/2429203](http://castroller.com/podcasts/TheSundayEdition/2429203)

Cvetkovich, Ann. 2003. *An archive of feelings: trauma, sexuality, and lesbian public cultures*. Durham, NC: Duke University Press.

Damasio, Antonio. 1994. *Descartes’ error : emotion, reason, and the human brain*. New York: Putnam.

Halberstam, Judith. 2011. *The queer art of failure*. Durham, NC: Duke University Press.

Kahneman, Daniel. 2013. *Thinking, Fast and Slow*. New York: Farrar, Straus and Giroux.

Keller, Michael. 2013. SUL supports conference anti-harassment policies. \[Internet.\] \[cited 2015 Feb 17\]. Available from: [http://library.stanford.edu/news/2013/07/sul-supports-conference-anti-harassment-policies](http://library.stanford.edu/news/2013/07/sul-supports-conference-anti-harassment-policies)

Melymuka, Kathleen. 2008. Why Women Quit Technology. Computerworld. \[Internet\]. \[cited 2015 Feb 17\]. Available from: [http://www.computerworld.com/article/2551969/it-careers/why-women-quit-technology.html](http://www.computerworld.com/article/2551969/it-careers/why-women-quit-technology.html)

Nafus, Dawn; Kreiger, Bernhard; and Leach, James. 2006. Gender: Integrated Report of Findings. Free/Libre and Open Source Software: Policy Support. \[Internet\] \[cited 2015 Feb 17\] Available from: [http://www.flosspols.org/deliverables/FLOSSPOLS-D16-Gender\_Integrated\_Report\_of\_Findings.pdf](http://www.flosspols.org/deliverables/FLOSSPOLS-D16-Gender_Integrated_Report_of_Findings.pdf)

Noble, Safiya Umoja. 2012. Missed Connections: What Search Engines Say About Women. Bitch Magazine, 54. \[cited 2015 Feb 17\]. Available from: [https://safiyaunoble.files.wordpress.com/2012/03/54\_search\_engines.pdf](https://safiyaunoble.files.wordpress.com/2012/03/54_search_engines.pdf)

Norman, Donald. 2005. *Emotional Design*. New York: Basic Books.

Oldenziel, Ruth. 2004. *Making Technology Masculine: Men, Women, and Modern Machines in America, 1870-1945*. Amsterdam, Netherlands: Amsterdam University Press.

Olson, Hope. 2002. *The Power to Name: Locating the Limits of Subject Representation in Libraries*. Dordrecht, Netherlands: Kluwer Academic Publishers. [1](https://journal.code4lib.org/articles/#ref1)

Reagle, Joseph. 2013. “Free as in Sexist?” Free culture and the gender gap. First Monday \[Internet\]. \[cited 2015 Feb 17\] Available from: [http://firstmonday.org/ojs/index.php/fm/article/view/4291/3381](http://firstmonday.org/ojs/index.php/fm/article/view/4291/3381)

Wu, Brianna. 2014. No skin thick enough: The daily harassment of women in the game industry. Polygon. \[Internet\]. \[cited 2015 Feb 17\]. Available from: [http://www.polygon.com/2014/7/22/5926193/women-gaming-harassment](http://www.polygon.com/2014/7/22/5926193/women-gaming-harassment)
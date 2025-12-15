---
title: "Talking Portraits in the Library: Building Interactive Exhibits with an Augmented Reality App"
source: "https://journal.code4lib.org/articles/14838"
author:
  - "[[The Code4Lib Journal]]"
published: 2019-11-06
created: 2025-01-10
description: "With funding from multiple sources, an augmented-reality application was developed and tested by researchers to increase interactivity for an online exhibit. The study found that augmented reality integration into a library exhibit resulted in increased engagement and improved levels of self-reported enjoyment. The study details the process of the project including describing the methodology used, [...]"
tags:
  - "clippings"
---
# Talking Portraits in the Library: Building Interactive Exhibits with an Augmented Reality App
Brandon Patterson

With funding from multiple sources, an augmented-reality application was developed and tested by researchers to increase interactivity for an online exhibit. The study found that augmented reality integration into a library exhibit resulted in increased engagement and improved levels of self-reported enjoyment. The study details the process of the project including describing the methodology used, creating the application, user experience methods, and future considerations for development. The paper highlights software used to develop 3D objects, how to overlay them onto existing exhibit images and added interactivity through movement and audio/video syncing.

## Introduction

Augmented Reality (AR) and other display technologies are increasingly being utilized in educational settings to create immersive, interactive, and exciting learning environments\[[1](https://journal.code4lib.org/articles/#note1)\]\[[2](https://journal.code4lib.org/articles/#note2)\]\[[3](https://journal.code4lib.org/articles/#note3)\]. These technologies are found to promote participation and motivation while creating a novel learning environment that mixes the virtual with the real world\[[4](https://journal.code4lib.org/articles/#note4)\]. The transition in online learning from conventional multimedia platforms to a more creative and engaging augmented learning environment provides opportunities for educators to engage learners in exciting new ways. According to a study by Chang, et al.\[[5](https://journal.code4lib.org/articles/#note5)\], an AR guide to an in-person museum exhibit enhanced a visitor’s learning effectiveness, their engagement, and extended the amount of time the visitor focused on the paintings.

The goal of this project was to create a custom AR software to enhance the experience for viewers of an online exhibit in the same way that previous studies had shown it did with an in-person one. This project was funded in whole or in part with federal funds from the Department of Health and Human Services, National Institutes of Health, and National Library of Medicine, under cooperative agreement number UG4LM012344 with the University of Utah Spencer S. Eccles Health Sciences Library. With these funds, a small team built a prototype app allowing viewers to see characters from the National Library of Medicine’s (NLM) online exhibit, “Renaissance Science, Magic, and Medicine in Harry Potter’s World”. Using graphic software and local expertise in the library, the online activity, [“Lumos: Renaissance Thinkers Behind the Magic”](https://www.nlm.nih.gov/exhibition/harrypottersworld/education/onlineactivities00.html) was transformed to include a virtual environment using AR. The characters interact with viewers as talking portraits did in the Harry Potter book series\[[6](https://journal.code4lib.org/articles/#note6)\], providing enhanced engagement and time spent with the exhibit.

## Findings

This study found that when someone interacted with the augmented reality portion of the NLM exhibit, it resulted in increased time spent engaging with the material and improved levels of self-reported enjoyment with the experience. The retention of information conveyed by the exhibit was the same as that viewed on the website. This report details the process of the project including methodology used, prototype creation, user experience testing, and future considerations for development.

## Methodology

There were six phases of development for this project that included planning, configuration, migration, testing, documentation and operation.

### Phase 1: Planning

The planning phase consisted of the tasks necessary to successfully setup an augmented reality environment. It allowed us to better acquaint ourselves with the content and what the viewers expect when experiencing the online exhibit. We’ve outlined our roles as follows:

- A project manager led the week-to-week progress of the study, supported the staff, documented the process, and created the final report.
- The technical lead came from the IT department and built the models for the characters to interact with the viewer. He also led the app integration.

For hardware, we used existing PC computers and our personal mobile devices. Our software needs consisted of [Unity](https://unity.com/), [Mixamo](https://www.mixamo.com/), [Blender](https://www.blender.org/) and custom programs to create and animate 3D elements, described under “Configuring the Model” heading below.

In the planning phase, the first task consisted of creating a character persona for a key figure in the exhibit, Nicolas Flamel. Personas are based off factual information about them and include personal details that will be used to create elements of the characters including script, mannerisms, and animations. Experts in the field of augmented reality who work for the University’s Electronic Arts and Entertainment (EAE) program were consulted to give insight into the process and provide feedback about the project design. Scripts were written by the project manager to align with the character personas created, described under the “Persona and Script Development” heading below.

### Phase 2: Configuration

The configuration phase was the most time intensive and consisted of the character design and animations. Characters were created, wire-framed, animated, and rigged for movement via the Blender development platform, which is a free open-source 3D creation suite. The character was exported into Unity, a game developer engine, to coordinate when animations play and how it looks, including adding lighting and developing shading. We did a voice recording during this phase to create a working prototype which we tested with patrons of the library.

### Phase 3: Migration

This phase consisted of moving the animation to an app for deployment. Unity creates an app template for developers which we used to connect to the virtual environment app created. The app is currently in prototype form and is not publically available. The authors are working with the funders of the project to build out the prototype and will release the app through the National Library of Medicine. After the project has ended, the authors would be happy to share the code of the project with others per guidance of the funders. It is restricted to Android users at this time with future development to make it available on iPhone. Content was integrated and transformed to fit the specifications of the mobile devices. The project manager gathered users to test the app.

### Phase 4: Testing

This phase consisted of user testing which informed the outcomes of the study, which were:

1. Increased retention of information conveyed by the exhibit;
2. More time spent engaging with the material; and
3. Improved levels of self-reported enjoyment with the experience.

We conducted structured interviews before and after the AR-enhanced version of the exhibit. We selected 30 subjects from a pool of patrons from throughout the University, 10 who interacted with the NLM online activity in its existing form (control), another 10 who interacted solely with the AR component of the NLM exhibit and 10 who interacted with both components. Identical surveys were given to all groups. Some questions for the subjects included:

- Rank your enjoyment of the online activity (1 to 10).
- What do you enjoy about the online activity?
- What suggestions do you have to improve the experience?
- Content specific questions.

We then analyzed the data based on survey questions and short interviews with subjects.

### Phase 5: Documentation

Throughout the study, the project manager and technical lead documented their progress. A summary report was written and given to NLM to provide suggestions for feasibility and scalability of future virtual environment projects for NLM exhibits. The report included:

- Survey results and analyzed data
- Timeline and key milestones for project creation
- Documentation of project from lead and student developer
- Peer evaluation on technology
- Recommendation and suggestions for future projects
- Guide to support and produce similar content

### Phase 6: Operation

This prototype was meant to be a test case for the exhibit and additional funds are needed to roll it out into a fully operating application. With additional time and resources, the prototype can be a guide to develop more characters and interactions with guests of the online exhibit.

## Prototype Development

To create the prototype, we developed a persona and script and configured a model using software and hardware detailed below.

### Persona and Script Development

A learner persona was created to get a sense of the target audience for this application (Figure 1). We used this persona as a way to target the app toward a specific audience and got direct feedback from patrons of the library.

![figure 1](https://journal.code4lib.org/media/issue46/patterson/patterson_f1.JPG)**Figure 1:** Learner Persona to use as target audience for app.

A character persona and script was then written about Nicolas Flamel (Figure 2). Future characters developed for the app and their script would go through a similar process but experts in the field of Renaissance science and medicine would be consulted for accurate information.

![figure 2](https://journal.code4lib.org/media/issue46/patterson/patterson_f2.JPG)**Figure 2:** Nicolas Flamel persona and script for app.

### Configuring the Model

To configure the model for the app, free and for-cost software and assets were used to develop the character of Nicolas Flamel. Instead of hiring an artist, we opted to create our own character via Adobe Fuse, a character model generator. Although less in line with the art of the exhibit, it provided a good prototype for what the app could do. We then used Mixamo, Blender and [LipSync Pro](https://assetstore.unity.com/packages/tools/animation/lipsync-pro-32117) as a way to animate the character. To make it ADA compliant, we used Unity to add closed captioning to match the voice of the character and applied a custom shader to have the character match the style of the exhibit. Finally, Vuforia was used to create the AR component which took the image and replaced it with the animation on the phone.

#### Adobe Fuse

Adobe Fuse is a character model generator. Because the University of Utah has an agreement with Adobe, it is no cost to us. One can choose base meshes to work with and modify the model in various ways. For example, selecting the nose allows one to adjust the nose height, width, depth, etc. After the character looked as close to a reference photo as possible, the technical lead exported the model as a 3D model format (OBJ) with the accompanying material package (see Figure 3 & 4).

![figure 3](https://journal.code4lib.org/media/issue46/patterson/patterson_f3.jpg)![figure 4](https://journal.code4lib.org/media/issue46/patterson/patterson_f4.jpg)**Figures 3 & 4:** Nicolas Flamel character created in Adobe Fuse.

#### Mixamo

Mixamo is a web based character rigger and animator. Rigging a model consists of creating a “bone structure” under the model and assigning each vertex to one or more bones; a slow and tedious process to do by hand. Fortunately, Fuse exports their character models in a standard T-Pose position that allows Mixamo to rig the character with ease. The technical lead uploaded the object file (OBJ) generated by Fuse and selected the required joints (Figure 5).

![figure 5](https://journal.code4lib.org/media/issue46/patterson/patterson_f5.jpg)**Figure 5:** Rigging of Nicolas Flamel and selecting joints using software Mixamo.

After rigging was complete, the character was animated with the many animations available from Mixamo (Figure 6). The technical lead selected an animation called “sitting talking” and downloaded the pack as an FBX file. This is a file format that includes models, rigging, animations, and materials.

![figure 6](https://journal.code4lib.org/media/issue46/patterson/patterson_f6.jpg)**Figure 6:** Available preset animations for Nicolas Flamel on Mixamo.

#### Blender

The final task for getting the model ready for full animation was completed in Blender. The technical lead imported the file of the sitting-talking Nicholas. He replaced his small beard with one that he modeled to better match the reference photo. Then using the Shape Keys tab, he connected to the mouth of the model and created ten phonemes (the shapes that the mouth makes while making certain sounds while talking) that can be used to visualize English speech (Figure 7). He then exported the package as an FBX file.

![figure 7](https://journal.code4lib.org/media/issue46/patterson/patterson_f7.jpg)**Figure 7:** Facial phonemes created in Blender for Nicolas Flamel character.

#### Unity + LipSync Pro

Importing the FBX file and material packages into Unity was the next step. Once in Unity, the technical lead generated a standard shader material for each of the character objects. He linked all of the textures from the material package to the appropriate shaders. He then installed LipSync Pro to get started on animating the character’s face (Figure 8).

![figure 8](https://journal.code4lib.org/media/issue46/patterson/patterson_f8.jpg)**Figure 8:** LipSync Pro software interface.

This process was quite simple as the Blendshapes section in Lipsync allowed the technical lead to select the Shape Keys he created in Blender as a simple pulldown menu. Once the phonemes were all linked up, he needed to create an audio data file to keyframe the various phonemes with the audio track, a simple yet tedious process (Figure 9).

![figure 9](https://journal.code4lib.org/media/issue46/patterson/patterson_f9.jpg)**Figure 9:** Audio data file of recorded voice to match keyframes for animation.

#### Closed Caption

To address the idea of closed captioning, the technical lead created a simple on-screen text box in Unity where he manipulated the text during runtime. Single lines of dialogue were typed out and added to a text field along with a time value to sync with the moving lips of the character (Figure 10). Once populated, a button was added to the start of the app which allows the user to start the video with or without the captions.

![figure 10](https://journal.code4lib.org/media/issue46/patterson/patterson_f10.jpg)**Figure 10:** Unity function to add caption to application.

#### Custom Shader

The goal of this shader was to generate a “hand drawn” effect to the visuals to match the look of the exhibit. The technical lead wanted the model to look as though it was being drawn or sketched while the video was playing. We purchased a shader pack from the asset store called [Hand-Drawn Shader Pack](https://assetstore.unity.com/packages/vfx/shaders/hand-drawn-shader-pack-12465) which almost created the desired effect, but not quite. Fortunately, the author of the hand-drawn asset included access to the code for all of his shaders. The technical lead was able to walk through the code and understand the principle of how it works. Using this knowledge, a customized version of the shader was created (Figure 11).

The differences include:

- separating the shading texture “levels” into individual images. This gives a little more direct workflow in creating the sketch textures for each shading level.
- each shading level includes a cutoff threshold to give a hard edge between shading texture levels. This allows adjustment for each shading level individually.
- the base color for the material can include an alpha channel which will allow the underlying material to “peek” through which generates some interesting effects.

![figure 11](https://journal.code4lib.org/media/issue46/patterson/patterson_f11.JPG)**Figure 11:** Different shader shapes and subsequent effects.

This new shader offers much more flexibility to match the project’s needs.

#### Vuforia

The final step was to track the main image through a devices camera and display this model and animation within the image. To accomplish this, we made use of the Vuforia plugin for Unity. After installing the plugin and creating an account, the technical lead uploaded the image to the developers Vuforia website where the image was analyzed for trackability. Fortunately, our image of Nicholas received a 4-star rating, which makes for a good image to track (Figure 12)!

![figure 12](https://journal.code4lib.org/media/issue46/patterson/patterson_f12.jpg)**Figure 12:** Vuforia target manager for Nicolas Flamel project with four and five star images.

The technical lead downloaded the tracking package and activated it with the previously created Unity scene. This generates a sprite with the tracking image assigned. At runtime, the image is hidden from view while Vuforia searches for that image from the camera input. When found, the sprite within the scene is aligned with the world image and the tracking image on the sprite is then hidden. But, any object attached to the tracking sprite will then stay aligned with the world image (Figure 13).

![figure 13](https://journal.code4lib.org/media/issue46/patterson/patterson_f13.JPG)**Figure 13:** Nicolas Flamel sprite as found in NLM Exhibit attached to virtual environment.

So, with that in place, the technical lead built the background composition with respect to the tracking image, as if it were a window. Finally, he masked off the area around the tracking image with a camera mask. This will show whatever the camera is seeing (hiding the background models), and provides the “looking into a window” effect (Figure 14).

![figure 14](https://journal.code4lib.org/media/issue46/patterson/patterson_f14.jpg)**Figure 14:** Desired “looking into a window” effect for app.

With everything set to animate on start, the technical lead built the app to be used on an android device and tested the effect. Satisfied with the results, he added a simple user interface to delay animation until a button is pressed. This allows for the selection to have captions enabled or disabled.

## Results

Compiling the series of parts created from developer tools listed above made the desired application – which recognizes the given image of Nicolas Flamel and replaces that image with a 3D rendered scene – fully animated, with audio (Figure 15). This animation tracks the user’s movements and shows the scene in the appropriate orientation.

For more about the project, see the following:

- Video of application found at [https://youtu.be/YVjP2An0OGw](https://youtu.be/YVjP2An0OGw).

![figure 15](https://journal.code4lib.org/media/issue46/patterson/patterson_f15.jpg)**Figure 15:** Finished prototype app with original image and interactive virtual environment.

## Pricing and Costs

The following is a list of pricing for the development of the prototype and costs associated to continue the project.

- Unity Personal – Free to use if revenue or funding raised is less than $100k/year. If revenue exceeds $100K, [prices range from $25 – $125/month](https://store.unity.com/compare-plans)
- Vuforia – Free for development, after deployed on app store, [get access to classic ($499 one-time) or cloud-based ($99/month) subscription](https://developer.vuforia.com/vui/pricing)
- Lipsync Pro – Available on Asset Store: $35/ one time
- Fuse – Included in Adobe Creative Cloud: $52.99/ month
- Mixamo – Free to use
- Blender – Free to use

## User Testing

A weeklong usability study provided insight into the application and whether or not it met the goals of the study. A testing protocol was developed to remain consistent throughout the process. All users interacted with the same portion of the online exhibit, “Renaissance Science, Magic, and Medicine in Harry Potter’s World.” A pre-survey was given to all participants to get a sense of their familiarity with Renaissance science and medicine, Harry Potter, augmented reality and online learning. We also wanted to get information about their highest level of education and age. We split participants into three groups and timed them while they participated in one of three ways: Group A consisted of participants that would look at the online activity and the app. Group B would only look at the online activity on the website. Group C would only look at the app. We then asked them follow up questions regarding their enjoyment of the app, responses to why they did and did not enjoy it, and a few questions to understand their comprehension concerning Nicolas Flamel.

## Findings

The usability study showed that groups A and C, having interacted with the app, had greater enjoyment interacting with the exhibit and spent more time with the content. Interactions with the app (group A and C) were an average of 116.6 seconds and 62.6 seconds compared to no app (group B) at 36.6 seconds. Groups A and C rated their enjoyment levels at an average of 4.25 and 4.6 (out of a scale of 5) as compared to 3.05 for group B which didn’t have the augmented reality app. Many users commented on how they enjoyed the interactivity, the ability to view the character from multiple perspectives, and the novelty of the experience with added information coming from the application. Some pointed to the length of the experience, matched artistic styles and interactions beyond augmented reality as possible improvements to the experience. Retention of knowledge about Nicolas Flamel wasn’t any better than having read the website. Researchers in AR development have addressed users paying too much attention to the novelty of the new technology and ignoring the surrounding environment\[[7](https://journal.code4lib.org/articles/#note7)\]. In fact, one user admitted that they weren’t listening to the content and rather paying attention to the character because they thought it was so cool. In two questions referencing what Nicolas Flamel was rumored to have created and what the philosopher’s stone could do, those that viewed both the website and app scored similarly to those that had just viewed the website, while those with only the app didn’t do as well on the knowledge questions (see Table 1).

**Table 1:** Usability groups A, B, and C and results of follow-up questions.![table 1](https://journal.code4lib.org/media/issue46/patterson/patterson_t1.JPG)

Overall, the demographics of our study participants mirrored that of our learner persona. Most participants (63%) were between 19-29 years old and had finished high school (67%). Most were also familiar with Harry Potter and online learning, while mostly unfamiliar with Renaissance science and medicine and augmented reality (see Table 2).

**Table 2:** Pre-survey results on familiarity with different aspects of learning experience.![table 2](https://journal.code4lib.org/media/issue46/patterson/patterson_t2.png)

## Future Considerations

Based on the findings from our usability test, conversations with experts in the field, and our own experience, we recommended steps to expand the project. Firstly, we would like to create more animated characters and shorten the animations to 30 seconds to stimulate viewers. Secondly, adding a digital artist and professional voice actor, while costing additional funds, would raise the profile of the project and better immerse viewers.  Finally, we’d like to build features using machine learning software where we’d experiment with interactive features using voice recognition and guided conversation software.

## Conclusion

This project helped highlight custom-made AR technology to enhance an online exhibit. The tool helped increased enjoyment of the exhibit and invited viewers to interact with the exhibit for longer periods of time. Viewers retained the same amount of information as interacting with the website alone. If this tool were to be developed further, more studies would need to be done to understand how to increase viewers’ retention of information gathered from the interaction. Many of the tools used to develop the prototype were free or inexpensive, and library personnel and partnerships proved vital to the project.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Sylaiou, S., Mania, K., Karoulis, A., & White, M. (2010). Exploring the relationship between presence and enjoyment in a virtual museum. International journal of human-computer studies, 68(5), 243-253.

\[[2](https://journal.code4lib.org/articles/#ref2)\] Galani, A. (2003). Mixed Reality Museum Visits: Using new technologies to support co-visiting for local and remote visitors. Museological review, 10.

\[[3](https://journal.code4lib.org/articles/#ref3)\] Hall, T., Ciolfi, L., Bannon, L., Fraser, M., Benford, S., Bowers, J., … & Flintham, M. (2001, November). The visitor as virtual archaeologist: explorations in mixed reality technology to enhance educational and social interaction in the museum. In Proceedings of the 2001 conference on Virtual reality, archeology, and cultural heritage (pp. 91-96). ACM.

\[[4](https://journal.code4lib.org/articles/#ref4)\] Damala, A., Marchal, I., & Houlier, P. (2007). Merging augmented reality based features in mobile multimedia museum guides. In Proceedings of anticipating the future of the cultural past (pp. 1–6). Athens, Greece.

\[[5](https://journal.code4lib.org/articles/#ref5)\] Chang, K. E., Chang, C. T., Hou, H. T., Sung, Y. T., Chao, H. L., & Lee, C. M. (2014). Development and behavioral pattern analysis of a mobile guide system with augmented reality for painting appreciation instruction in an art museum. Computers & Education, 71, 185-197.

\[[6](https://journal.code4lib.org/articles/#ref6)\] Rowling, J. K. (1997). Harry Potter and the philosopher’s stone. London: Bloomsbury Pub.

\[[7](https://journal.code4lib.org/articles/#ref7)\] Wang, X., & Chen, R. (2009). An experimental study on collaborative effectiveness of augmented reality potentials in urban design. CoDesign, 5(4), 229–244.

Brandon Patterson is the Technology Engagement Librarian at the Eccles Health Sciences Library at the University of Utah. He connects students, staff, and faculty to digital tools and emerging technologies and creates meaningful experiences using prototyping tools, augmented and virtual reality, and online learning platforms. He is a health sciences education liaison and coordinates with faculty to incorporate information literacy instruction and technology into their classrooms. Email: [b.patterson@utah.edu](https://journal.code4lib.org/articles/)

## Contributors

Chris Allen, Entertainment Arts & Engineering, University of Utah  
Alex Johnstone, Entertainment Arts & Engineering, University of Utah
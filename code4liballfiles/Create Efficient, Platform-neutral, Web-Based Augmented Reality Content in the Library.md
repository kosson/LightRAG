---
title: "Create Efficient, Platform-neutral, Web-Based Augmented Reality Content in the Library"
source: "https://journal.code4lib.org/articles/14632"
author:
  - "[[The Code4Lib Journal]]"
published: 2019-08-09
created: 2025-01-10
description: "Augmented reality (AR) is an interactive experience of viewing computed-generated objects onto your view of the real world. Since the Pokemon Go craze in 2016, many libraries have tested the waters with AR programs. Some went on to the next step of developing their own AR content to enhance library services and marketing. While there [...]"
tags:
  - "clippings"
---
# Create Efficient, Platform-neutral, Web-Based Augmented Reality Content in the Library
Dan Lou

Augmented reality (AR) is an interactive experience of viewing computed-generated objects onto your view of the real world. Since the Pokemon Go craze in 2016, many libraries have tested the waters with AR programs. Some went on to the next step of developing their own AR content to enhance library services and marketing. While there are many AR applications that libraries can use for this purpose, it usually thwarts customers that they must install various AR mobile apps in order to enjoy these experiences on their own devices. This becomes the major hurdle of making AR more enjoyable and accessible at the library. What's more, libraries cannot share home-grown AR content across different platforms easily because of the technical barriers in various AR platforms. In this article, I would like to introduce a completely open source AR developing tool that allows library staff to create fast and efficient AR content with pure web solutions. It is standard and works on mobile devices with no installation required. I have created a basic AR experience with the tool for a regional Pacific Library Partnership conference and it proved to be a success in improving the accessibility and shareability of AR content.

## Introduction

Last fall, Palo Alto City Library was planning to host a regional conference[\[1\]](https://journal.code4lib.org/articles/#note1) with the goal of celebrating the achievements of the past Pacific Library Partnership (PLP) Innovation and Technology grant recipients. At the planning stage, we brainstormed on how to make the event more inspiring and mind-opening via integrating nascent technology elements into it and the idea of creating a badge with some AR magic emerged. None of the team members had any previous AR development experience, so someone had to figure out how feasible the project was. That was when and where we started the journey to explore various AR technologies and to identify the most affordable one for the project.

## A Comparison of Popular AR Tools

We began by researching major players in the AR tools space. Wikipedia has a pretty comprehensive page listing a wide range of augmented reality software.[\[2\]](https://journal.code4lib.org/articles/#note2) We also searched the web for “tools to create augmented reality content”. A few pages with titles like “top x augmented reality SDK for mobile Apps” caught my eye. Combining this information, the Library created a chart to compare AR tools.

**Table 1.** AR Tool Comparison Chart

| AR tool | Development Environments | Supported platforms | Open source? | Features | End product | Free? |
| --- | --- | --- | --- | --- | --- | --- |
| ARKit[\[3\]](https://journal.code4lib.org/articles/#note3) | iOS | Mainly selected Apple phones | No | – Persistent AR experiences   – Shared AR experiences   – Object detection and tracking | A mobile App | Pay to become a iOS developer |
| ARCore[\[4\]](https://journal.code4lib.org/articles/#note4) | Java, Unity, Unreal, iOS | Mainly selected Android phones | Yes | – Motion tracking   – Environmental understanding   – Light estimation | A mobile App | Yes |
| Vuforia[\[5\]](https://journal.code4lib.org/articles/#note5) | iOS, Android, Universal, Windows Platform, Unity | iOS, Android | No | – Supports a variety of 2D and 3D targets   – Localized Occlusion Detection   – Create and reconfigure target sets programmatically at runtime. | A mobile App | Free trial available |
| ARToolKit[\[6\]](https://journal.code4lib.org/articles/#note6) | Mac OS X, PC, Linux, Android, iOS | Mac OS X, PC, Linux, Android, iOS | Yes | – Motion tracking   – Camera calibration support   – Simultaneous tracking   – Full Unity3D and OpenSceneGraph Support | A desktop App or a mobile App | Yes |
| AR.js[\[7\]](https://journal.code4lib.org/articles/#note7) combined with A-Frame[\[8\]](https://journal.code4lib.org/articles/#note8) | Mac OS X, PC, Linux, Android, iOS | Mac OS X, PC, Linux, Android, iOS | Yes | – Motion tracking   – Camera calibration support   – Simultaneous tracking | A webpage | Yes |

The four questions we asked when evaluating these tools were:

1. Is it open-source?
2. Does it work across multiple platforms?
3. How easy is it to use for end users? Are users required to download an app?
4. How steep is the learning curve for an absolute beginner to develop a basic AR scene?

As you can see from the chart, the majority of the AR tools generate an end product in the form of a mobile app. The advantage of a mobile app is obvious. A developer can write more complicated code and add more sophisticated features in the mobile app development environment with the native access to smartphone hardware. Because of this, these tools tend to have a better support for various AR targets.

An AR target is an object used to anchor digital content in the real world. In order for AR to look realistic to the viewer, it is important that the positioning of the virtual object in the real world matches the viewer’s perspective. To accomplish this, a target is used to determine the perspective. The target is made known to the AR application during the development. When a camera spots the target, the AR application analyzes and recognizes the target’s position in the real world. It is then able to place the virtual content accordingly in the real world view.

In the early days of AR, long before Pokemon Go, black and white markers with irregular patterns were used as AR tracking targets. In contemporary applications, the targets can be many different things thanks to machine learning and artificial intelligence technologies. Images, text, shapes, 3D objects, spacial maps, geolocation can be all used as AR targets.[\[9\]](https://journal.code4lib.org/articles/ref9) Some of the advanced tracking technology seems to produce an AR experience without any AR trackers in the view at all. For example, Apple’s ARKit contains a component called “World Tracking” that allows you to put an AR object anywhere you would like in the camera view. This is made possible because ARKit can track the realtime motion sensing data returned by the iOS device to determine the real-time motion of the device in the real world, hence, the motion of an AR object in the real world. It also analyzes the video stream from the camera in real time to track and determine the position of the device and the objects in the real world, and consequently, the position of an AR object in the real world. Other advanced AR tools like ARCore and Vuforia all provide similar support for various AR targets.

Nevertheless, these advanced tools need a mobile app to accomplish the sophisticated computation. The AR experience based on a mobile app faces two challenges: accessibility and the ability to share across platforms. Generally speaking, if it is required to make a mobile app available on different platforms, it is necessary to develop different versions of the mobile app in different environments. For example, if an iOS app is developed using ARkit, its Android equivalent should be created with ARCore. Although there are platforms that support building a mobile AR app that can be cross-compiled for multiple environments[\[10\]](https://journal.code4lib.org/articles/#note10), this method is still cost prohibitive and time consuming in terms of development. The mobile app needs to be maintained and updated all the time. For the badge magic we were trying to pull off, it was overkill. Additionally, even if apps for both Android and iOS were developed, they would only cover the majority of smartphones and tablets but not computers and laptops.

That is why we chose AR.js and A-Frame, a technology that supports basic AR effects. In terms of AR targets, it only supports pattern markers and customized image markers, but it was sufficient for our project. We decided to trade off some fancy features and novelty targets for a more straightforward and accessible solution. AR.js and A-Frame is the only option on the above chart that does not result in a mobile app. It is also free, open source, and quick to develop. A-Frame is an open source web framework for building virtual reality experiences which work on Vive, Rift, desktop and mobile platforms. AR.js is a web-based AR solution that is standard and works with any device with webgl[\[11\]](https://journal.code4lib.org/articles/#note11), webrtc[\[12\]](https://journal.code4lib.org/articles/#note12), and a camera. That meant once we developed an AR experience, anyone could access and enjoy it from anywhere, regardless of the device type.

## Create Your Own AR Experience

Once the right tool was identified, the next step was to test creating customized AR content.

Through trial and error, we learned that it is more efficient to begin a design with a VR scene first by using A-Frame. While developing AR requires the consideration of associating the digital objects with the marker and the real world view, developing VR is a process that focuses on only the digital objects. Therefore, starting from VR can save on the development time. In A-Frame, it is pretty easy to develop a VR scene from a plain HTML file without any additional software. It is only necessary to provide a reference to the A-Frame JavaScript library from inside the head of the HTML file.

Adding the following code inside the body will generate a cube in the VR scene.

| 1  2  3  4 | `<``a-scene``>`  `<``a-box` `position``=``"0 0 -2"` `rotation``=``"0 45 45"` `scale``=``"1 1 1"` `color``=``"blue"``>`  `</``a-box``>`  `</``a-scene``>` |
| --- | --- |

You can preview VR scene by opening the HTML file in a browser , and using the mouse to drag the cube around. I started all the HTML coding in the online code editor CodePen and I could view the result right away.[\[13\]](https://journal.code4lib.org/articles/#note13)

Once a VR scene has been created, it is time to add the AR component. We experimented with the default AR tracker [\[14\]](https://journal.code4lib.org/articles/#note14) first. In the head of the HTML file, we created a reference to the AR.js JavaScript library.

It is then necessary to make changes inside the body to enable the web page to use a device’s camera and recognize the default AR tracker as a trigger for the VR object.

| 1  2  3  4  5  6  7 | `<``a-scene` `embedded arjs>       `  `<``a-marker` `preset``=``'hiro'``>`  `<``a-box` `position``=``"0 0 -2"` `rotation``=``"0 45 45"` `scale``=``"1 1 1"` `color``=``"blue"``>`  `</``a-box``>`  `</``a-marker``>   `  `<``a-entity` `camera></``a-entity``> `  `</``a-scene``>` |
| --- | --- |

If this modified web page is opened in a browser on a device and the camera is pointed at the default AR tracker, a virtual blue box will appear where the tracker is on the screen [\[13\]](https://journal.code4lib.org/articles/#note13).

After creating this simple proof of concept test, we moved on to design the real content for the conference badge.

The augmented reality display can handle several kinds of VR content. Among others, we tested 3D text, a 3D drone model and a 3D cube covered with images. In the two final versions of the app used for the conference, a 3D conference logo and an R2-D2 were displayed.

The beauty of A-Frame is that not only can 3D objects be prototyped quickly with a few lines of the markup language, but also pre-designed 3D models can be easily loaded into it. For the conference badge, we decided to design a conference logo using the 3D design software SketchUp.[\[15\]](https://journal.code4lib.org/articles/#note15) The logo was composed of the Palo Alto City 3D logo, shaped like an oak leaf, and name of the conference in 3D text. The model was saved as a glTF object, loaded into the A-Frame code and some animation effects were added. The default behavior for the logo was to rotate back and forth at a slow speed.

| 1  2  3  4  5  6  7 | `<``a-assets``>`  `<``a-asset-item` `id``=``"logo"` `src``=``"./leaf/leaf_plp.gltf"` `></``a-asset-item``> `  `</``a-assets``>`  `<``a-entity` `gltf-model``=``"#logo"` `scale``=``"3 3 3"` `position``=``"0 0 0"` `rotation``=``"0 0 0"``>`  `<``a-animation` `direction``=``"alternate"` `easing``=``"linear"` `attribute``=``"rotation"` `repeat``=``"indefinite"` `dur``=``"5000"` `from``=``"60 0 0"` `to``=``"-60 0 0"``></``a-animation``>         `  `</``a-entity``>` |
| --- | --- |

For the next step, we needed to consider the AR tracker to be used. To do that we needed to decide on what image or text to use as the tracker and the obvious choice for us was to use a symbol closely associated with our library. Our successful robot coding program, sponsored by PLP, was selected and recognized as a *California State Library LSTA* copycat grant program in 2018 [\[16\]](https://journal.code4lib.org/articles/#note16) and was going to be celebrated at the conference. That is why we decided to train the image of our robot as the custom tracker on the AR.js marker training webpage.[\[17\]](https://journal.code4lib.org/articles/#note17)

Within a week, this AR magic was live and working. We ended up not using the AR magic the way we originally proposed. In order to go green and save paper, the Library decided not to print out badges. Instead, we emailed the tracker image with the confirmation information to all attendees in advance. During the conference, we turned the AR magic into an activity. About twenty AR trackers were printed out and put on each table in the conference room. Our director, Monique le Conge Ziesenhenne, gave instructions to all attendees on how to play the AR magic. Adventurous librarians then took out their phones, pointed them at a nearby AR tracker and were pleasantly surprised.

![PLP AR image](https://journal.code4lib.org/media/issue45/lou/plp_ar.jpg)  
**Figure 1.** AR created for PLP conference. Tracker printed on paper and AR viewed from Chrome browser on an Android phone.

**Figure 2.** Animation of AR created for PLP conference.  
![PLP AR magic](https://journal.code4lib.org/media/issue45/lou/file.gif)

## The Future of Web-based AR in Libraries

Besides conference badges, web-based AR has a lot of potential in libraries. I would like to take the chance to share some of my ideas with you.

An AR tracker is an image that can be printed out on different materials physically or kept as a digital image opening on a device. For example, I quickly made a Code4Lib AR scene for my lightning talk at Code4Lib 2019.[\[18\]](https://journal.code4lib.org/articles/#note18) In the demonstration, the associated tracker, trained with the conference logo, was opened on a laptop. The designated AR web page was opened in the Chrome browser on a smartphone. The AR scene appeared when the associated tracker was detected by the smartphone. Supposing the tracker were instead printed on T-shirts that distributed to all attendees, this could turn into a fun conference activity where people would share the AR experience by scanning the trackers on each other’s T-shirts with their smartphones. Similarly, we can use web-based AR scenes to enhance promotion and marketing materials at the library. For big programs like the Summer Reading Program, libraries can turn the 2D flyers into mixed reality scenes by using this technology.

**Figure 3.** AR created for the lightning talk at Code4Lib 2019. Tracker open on a laptop, and AR viewed from Chrome browser on an Android phone.  
![code4lib](https://journal.code4lib.org/media/issue45/lou/code4lib_ar.jpg)

Another idea is to incorporate the AR technology into 3D design workshops and tutorials. Many libraries now offer 3D design help to the customers. Web-based AR can take customers’ 3D designs another step forward. We can help customers make their own customized AR business card for instance.

A third idea is to enhance the library’s collection. For example, libraries can attach interesting AR to specific children’s books or bookmarks. Parents can then enjoy a magic moment with their children.

## Combine AR and Distributed Web

One issue remains if a library wants to adopt any of the above ideas: how and where to store the AR content? A library might need to purchase local servers or a cloud server like Amazon Web Services(AWS) to keep the growing AR content persistent, but this comes along with an ongoing cost and maintenance effort that a library might find difficult to afford.

That is why we have also explored storing the AR content in the distributed web. I added part of the original AR project folders to the distributed web called Internet Planetary File System (IPFS).[\[19\]](https://journal.code4lib.org/articles/#note19) The folder, as well as each file and the 3D model inside it, now has a persistent and unique cryptographic hash in IPFS. They become part of the distributed web permanently. People can obtain or access the files via the peer-to-peer IPFS protocol or via the IPFS gateway, which is an old-fashioned HTTP web protocol. [\[20\]](https://journal.code4lib.org/articles/#note20)

This might be the solution for file storage and sharing in the future. As a matter of fact, our library just started to launch a new round of innovative programs by using both A-Frame and IPFS. We hosted a workshop called “Virtual Reality Hackfest” for absolute beginners on Jun 22, 2019. [\[21\]](https://journal.code4lib.org/articles/#note21) In the two-hour workshop, around twenty attendees learned how to create simple VR scenes using A-Frame code. These VR scenes then were published in IPFS. At the end of the workshop, every attendee walked away with a QR code that contained the IPFS hash to the VR scene he/she published. When the QR code is scanned by a smartphone, the associated VR scene is displayed.

## Source Code and Examples

All the scripts and examples are stored in a GitHub repository. [\[22\]](https://journal.code4lib.org/articles/#note22) Everyone is welcome to try out the examples. I hope more librarians will make creative use of the AR tool described in this article in library programs and activities.

Dan Lou is a senior librarian at Palo Alto City Library, where she works on web content management and develops pioneering projects on robotics, coding, AR and distributed web. Her particular interests include Python, machine learning and data analytics. Previously, she worked as a technical project manager at Wolfram Alpha, a knowlegebase queried by Apple Siri and Amazon Alexa. Before that, she was a systems librarian at Innovative Interfaces.

## References

[\[1\]](https://journal.code4lib.org/articles/#ref1) Positioning Libraries for the Virtual Future. 2018 Aug 31. \[accessed 2019 May 15\]. [http://plpinfo.org/event/positioning-libraries-for-the-virtual-future/](http://plpinfo.org/event/positioning-libraries-for-the-virtual-future/)

[\[2\]](https://journal.code4lib.org/articles/#ref2) List of augmented reality software. Wikipedia; [https://en.wikipedia.org/wiki/List\_of\_augmented\_reality\_software](https://en.wikipedia.org/wiki/List_of_augmented_reality_software)

[\[3\]](https://journal.code4lib.org/articles/#ref3) ARKit. Apple Inc; [https://developer.apple.com/arkit/](https://developer.apple.com/arkit/)

[\[4\]](https://journal.code4lib.org/articles/#ref4) ARCore. Google; [https://developers.google.com/ar/](https://developers.google.com/ar/)

[\[5\]](https://journal.code4lib.org/articles/#ref5) Vuforia. PTC; [https://www.ptc.com/en/products/augmented-reality](https://www.ptc.com/en/products/augmented-reality)

[\[6\]](https://journal.code4lib.org/articles/#ref6) ARToolkit. GitHub; [https://github.com/artoolkit](https://github.com/artoolkit)

[\[7\]](https://journal.code4lib.org/articles/#ref7) AR.js. GitHub; [https://github.com/jeromeetienne/AR.js](https://github.com/jeromeetienne/AR.js)

[\[8\]](https://journal.code4lib.org/articles/#ref8) A-Frame. [https://aframe.io/](https://aframe.io/)

[\[9\]](https://journal.code4lib.org/articles/#ref9) Kumaraswamy A. Types of Augmented Reality targets. 2018 Apr 8. Packt; [https://hub.packtpub.com/types-augmented-reality-targets/](https://hub.packtpub.com/types-augmented-reality-targets/)

[\[10\]](https://journal.code4lib.org/articles/#ref10) Aseem Wangoo. Flutter and AR. 2019 Apr 15. Flutter; [https://flatteredwithflutter.com/how-to-create-ar-in-flutter/](https://flatteredwithflutter.com/how-to-create-ar-in-flutter/)

[\[11\]](https://journal.code4lib.org/articles/#ref11) WebGL Overview. The Khronos Group; [https://www.khronos.org/webgl/](https://www.khronos.org/webgl/)

[\[12\]](https://journal.code4lib.org/articles/#ref12) WebRTC. [https://webrtc.org/](https://webrtc.org/)

[\[13\]](https://journal.code4lib.org/articles/#ref13) Lou D. A-Frame Blue Box. [https://codepen.io/loudan/pen/QRMOYX](https://codepen.io/loudan/pen/QRMOYX)

[\[14\]](https://journal.code4lib.org/articles/#ref14) AR.js hiro maker. GitHub; [https://jeromeetienne.github.io/AR.js/three.js/examples/marker-training/examples/generator.html](https://jeromeetienne.github.io/AR.js/three.js/examples/marker-training/examples/generator.html)

[\[15\]](https://journal.code4lib.org/articles/#ref15) SketchUp. [https://www.sketchup.com/](https://www.sketchup.com/)

[\[16\]](https://journal.code4lib.org/articles/#ref16) Copycat Grant Toolkits – Coding with the Robot – California State Library. 2019. Ca.gov; [https://www.library.ca.gov/services/to-libraries/copycat-grants/the-journey-begins/](https://www.library.ca.gov/services/to-libraries/copycat-grants/the-journey-begins/).

[\[17\]](https://journal.code4lib.org/articles/#ref17) AR.js Marker Training. GitHub; [https://jeromeetienne.github.io/AR.js/data/images/HIRO.jpg](https://jeromeetienne.github.io/AR.js/data/images/HIRO.jpg)

[\[18\]](https://journal.code4lib.org/articles/#ref18) Lou D. Web based AR. Beautiful.ai; [https://www.beautiful.ai/deck/-LZIr85yQSLXoHLUpw7s/ARCODE4LIB2019](https://www.beautiful.ai/deck/-LZIr85yQSLXoHLUpw7s/ARCODE4LIB2019)

[\[19\]](https://journal.code4lib.org/articles/#ref19) IPFS. [https://ipfs.io/](https://ipfs.io/)

[\[20\]](https://journal.code4lib.org/articles/#ref20) Lou D. AR / MR in the Web: Available now in the distributed web. GitHub; [https://github.com/fishbb/ar#available-now-in-the-distributed-web](https://github.com/fishbb/ar#available-now-in-the-distributed-web)

[\[21\]](https://journal.code4lib.org/articles/#ref21) VR Hackfest. 2019. Cityofpaloalto.org; [https://library.cityofpaloalto.org/news/vr-hackfest/](https://library.cityofpaloalto.org/news/vr-hackfest/).

[\[22\]](https://journal.code4lib.org/articles/#ref22) Lou D. AR / MR in the Web. GitHub; [https://github.com/fishbb/ar](https://github.com/fishbb/ar)
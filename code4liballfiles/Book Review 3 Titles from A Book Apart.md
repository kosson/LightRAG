---
title: "Book Review: 3 Titles from A Book Apart"
source: "https://journal.code4lib.org/articles/5552"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-07-25
created: 2025-01-10
description: "Three recently published books by A Book Apart, the book-publishing arm of the website A List Apart, offer concise, high-impact introductions to three tools that can be employed in facing this challenge: HTML5, CSS3, and content strategy. This article reviews the books \"HTML5 For Web Designers\" by Jeremy Keith; \"CSS3 for Web Designers\" by Dan [...]"
tags:
  - "clippings"
---
# Book Review: 3 Titles from A Book Apart
Nathan Mealey

Three recently published books by A Book Apart, the book-publishing arm of the website A List Apart, offer concise, high-impact introductions to three tools that can be employed in facing this challenge: HTML5, CSS3, and content strategy. This article reviews the books “HTML5 For Web Designers” by Jeremy Keith; “CSS3 for Web Designers” by Dan Cederholm; and “The Elements of Content Strategy” by Erin Kissane.

## Introduction

Faced with a diverse range of content and devices to model it for, and an array of users with unique information-seeking needs, web-developers face a significant challenge in creating highly usable, content-rich websites. Three recently published books by A Book Apart offer concise, high-impact introductions to three tools that can be employed in facing this challenge: HTML5, CSS3, and content strategy.

A Book Apart is the print-publishing venture from *A List Apart*, the web-design site that was founded in 1998. From the outset the site’s creators adopted unique approach and voice, developing a standards-based design for its site (remember that this was 1998) and writing articles that blended timely topics, advocating best practices, and voicing provocative opinions on the state of web design. Since then, *A List Apart* has published over 300 articles, and in the process has established itself as one of the most prominent voices in the web-design world.

In 2010 they launched A Book Apart with the goal of publishing “highly detailed and meticulously edited examinations of single topics…The goal of every title in our catalog is to shed clear light on a tricky subject, and do it fast, so you can get back to work.” \[[1](https://journal.code4lib.org/articles/#note1)\]  A Book Apart’s first title, *HTML5 For Web Designers*, came out last fall, and was quickly followed by *CSS3 For Web Designers*. The third title, *The Elements Of Content Strategy*, was published this past spring. Each book is written by an expert in the field who explores their subject through well-written text and step-by-step examples, and each provides a range of compelling reasons for why you should be designing your content and sites using these tools.

## *HTML For Web Designers* by Jeremy Keith

In this book, Jeremy Keith deftly turns a potentially dry subject into compelling reading. He kicks off the book by laying out the genesis of HTML5, a saga which makes an interesting story all on its own. The path leading to the creation of the HTML5 standard has been a circuitous one that reflected two different visions of web-development’s future: one based on defining a whole new, non-backwards-compatible, XML-based standard versus one based on proven practices in HTML/XHTML and the assurance of backwards-compatibility. In the end, HTML5 definitively embodied the latter, as the book sets out to demonstrate.

Keith begins by delving into the broad strokes of HTML5, first illustrating the design principles that it embodies: “do not reinvent the wheel” and “pave the cowpaths”. \[[2](https://journal.code4lib.org/articles/#note2)\] Ostensibly, with the design of HTML5, the goal was to take established ways of accomplishing development tasks and codify them in the HTML5 standard. At the same time, in order to support existing content a priority was placed on making HTML5 backwards-compatible. Keith states that, “On the one hand, the specification needs to be powerful enough to support the creation of web applications. On the other hand, HTML5 needs to support existing content…It’s a delicate balancing act that requires a pragmatic, level-headed approach.” \[[3](https://journal.code4lib.org/articles/#note3)\]  Ultimately, this is an approach that will depend on the efforts of browser makers implementing the standards, and designers using them.

With this in mind, Keith begins illustrating the key aspects of HTML5, starting with some of the basic elements that are new or changed, such as the simplified syntax of the HTML5 doctype declaration (<!DOCTYPE html>) or stylesheet call (<link rel=’stylesheet’ href=’file.css’>); elements that have been identified as obsolete in the new specification, including the frame, frameset, font, big, strike, bgcolor, cellspacing, valign, and others; \[[4](https://journal.code4lib.org/articles/#note4)\] and the new Javascript APIs that are built into the specification. The new Javascript APIs are a particularly exciting aspect of HTML5, as they should result in common Javascript tasks being both well documented and consistent from browser-to-browser.

Keith then goes on to tackle the HTML5’s support for “Rich Media”, specifically how audio and video content can be delivered using the HTML5 <canvas> element. He gives a number of examples for safely using this new element in current browsers, and really demonstrates the potential inherent in this powerful new element. His examples cover the ability to conditionally deliver content based on a device’s capabilities, to include native playback controls, and for styling embedded media. This should be particularly relevant for developers whose sites deliver a range of content that will be accessed on myriad devices (some of which will not support Flash).

Following this, Keith next looks at HTML5’s new features for web forms. HTML5 gives developers a range of exciting tools for improving forms, such as the ability to add placeholder text using the placeholder attribute for input tags, requiring validation via the required attribute, and the new datalist element that merges together the functions of an input element with a select element. He also touches on some of the new input types, including contact-related types (email, url, and tel), dates, times, sliders, color pickers and even regular-expression based patterns (using the pattern attribute). In each case, he provides clear, relevant examples that illustrate putting these new types into practice, and what to expect from different browsers.

Keith devotes a whole chapter to the role of semantics in HTML5. At first, this area of HTML5 may seem somewhat arcane, until you get to his discussion of using the new semantics for structuring your pages by using the <section>, <header>, <footer>, <aside>, and <nav> elements. While these are not required replacements for our typical use of divs to mark up content (e.g. <div id=”header”>), their benefit lies in the ability of a browser to recognize these tags and thus understand the page and its content semantically. As a result, browsers would be able to display a page to different interfaces (desktop, screen reader, mobile browser) more effectively by structuring the content appropriately for each type of device. Keith’s examples throughout this discussion do a great job of illustrating the impact that these new concepts could have.

Keith wraps up the book with a look at which HTML5 features are currently implemented in browsers. Since the book’s release in early fall 2010, all of the major browsers have released new versions that incorporate more HTML5 support than those versions available at the time the book was written (even Microsoft, with IE9, has arrived at the HTML5 standards table!). The wide support of HTML5 means that the code examples in the book enable a developer to hit the ground running. This ultimately is the greatest strength of Keith’s book: he weaves together new concepts with relevant examples that enable us – as web developers – to put HTML5 to work today.

## *CSS For Web Designers* by Dan Cederholm

The title of this book’s first chapter, “Using CSS3 Today” clearly indicates the author’s goal of explaining how developers can begin using CSS 3 today in a practical way.The book begins with a few pages discussing *when* to push the envelope with CSS3, but by page 6 he’s discussing a list of high-impact CSS3 properties that are already supported by browsers, and that the rest of the book will cover.  Each of the next four chapters is devoted to a practical demonstration of these properties. \[[5](https://journal.code4lib.org/articles/#note5)\]

Chapter 2 looks at CSS3 transitions, a feature that had been unevenly supported by browsers, therefore necessitating a range of Javascript solutions. With the growing adoption of CSS3 by browser makers, this feature is pretty commonly supported (even in IE’s latest version). With this chapter, Cederholm initiates the structure for the remaining chapters. Using his demo website (“Things We Left On The Moon” \[[6](https://journal.code4lib.org/articles/#note6)\]), he focuses on a specific set of CSS3 elements and incorporates them into the site’s design, including code examples all along the way. Being able to see the code on the page, and then in practice on the live site, goes a long way towards making these new CSS3 techniques readily graspable.

Chapter 3 and 4 follow this same approach while transitioning to hover-effects and image transformations.  He demonstrates how to make your text and image-based links behave dynamically through user interactions; how to transform images using native CSS3 properties for zooming, skewing; and changing the orientation of images. Again these are features that web-designers have historically needed to use various sleights of hand to accomplish, and for which CSS3 provides native properties. In both cases, the result is less code, and more browser compatibility than was previously possible.

Chapter 5 demonstrates how to use CSS3 layers to build rich backgrounds for your websites and, most importantly, how to gracefully fall-back to a simple background in the case of unsupported browsers. Lastly, Chapter 6 looks at forms properties that are new to CSS3. This chapter is particularly full of useful examples that illustrate such tricks as creating stylish submit buttons, adding styles to labels and text inputs, and using gradients for your background colors.

In contrast to *HTML5 For Web Designers*, *CSS3 For Web Designers* was more immediately satisfying. The code examples and best practices that this book contains will prove immediately useful in designing your websites. You’ll be able to readily replace Javascript snippets and hover-replaced images, and quickly put the form properties to use in your designs.

At the same time, the book is (by design) limited in its scope. While other new and powerful aspects of CSS3 were left out, including media queries \[[7](https://journal.code4lib.org/articles/#note7)\], multi-column layout \[[8](https://journal.code4lib.org/articles/#note8)\], and web fonts \[[9](https://journal.code4lib.org/articles/#note9)\], the book is very focused on experience-layer properties in CSS3 that you can use in designing sites right now. But then, what it does cover, it covers very well, and in a very practical, helpful manner.

## *The Elements of Content Strategy* by Erin Kissane

Where the previous two books looked at the tools and standards used for developing websites, Erin’s Kissane’s concise primer on content strategy illustrates the overarching framework within which this work takes place. The book covers the *what* and *how* , of content strategy, and serves as a great companion to the previous two books.

In the chapter on “Basic Principles”, Kissane sets the tone for the whole book. In this one, simple chapter, Kissane walks through the seven premises that lie at the core of her definition of content strategy \[[10](https://journal.code4lib.org/articles/#note10)\]:

1. Good content is appropriate: publish content that is right for the user and for the business
2. Good content is useful: define a clear, specific purpose for each piece of content; evaluate content against this purpose
3. Good content is user-centered: Adopt the cognitive frameworks of your users
4. Good content is clear: seek clarity in all things
5. Good content is consistent: mandate consistency, within reason
6. Good content is concise: omit needless content
7. Good content is supported: publish no content without a support plan

For each of the above, she provides a compelling explanation that illustrates a common way in which web content regularly fails its purpose. This section of the book is a must read for anyone who manages a website and its content, and is one that you will want to return to for a regular refresher.

Following these basic principles, Kissane dives into the heart of content strategy, going into great depth on the different approaches that the content strategist brings together, namely that of the editor, curator, marketer, and information scientist. For each of these approaches she provides a detailed explanation and relevant examples of putting the ideas and motivations inherent within each approach into practice. As a result, this section of the book has a lot of content to convey. All the same, Kissane does a good job of not overwhelming the reader while successfully illustrating the complexity and enormity of the task that faces anyone responsible for managing a website’s content. I suspect that each person who reads this will find a specific approach that they identify with more than the others. Yet, the opportunity to see that one approach in the context of the others that she illustrates will provide a valuable frame of reference.

Kissane’s discussion on the tools and techniques of content strategy draws on the approaches described in the above discussion. This includes tools such as project definitions aimed at convincingly answering the question of “what are we doing and why?”; research that uncovers who users are and what they want; and the development of guidelines for creating content, including plans for maintaining and nurturing content once it has been created. This is very much the nuts and bolts section of the book, and covers a wide range of methods that you can use when managing content. This is perhaps best summed up by her list of all various types of deliverables a content strategist might produce – a list of 34 different items, including accessibility guidelines, benchmarks, channel strategy, CMS requirements, communication plans, and many more. These tools and techniques she explicates are all ultimately embodied by one of the deliverables.

The chapter on basic principles alone makes the book valuable, but the remaining chapters provide significant ideas, methods, and tools that anyone engaging in a website or content development project should consider. The book’s content may not be quite as accessible as the ones on HTML5 and CSS3, owing in part to the lack of demonstrations and code examples that make the latter immediately gratifying while breaking up the text at the same time. But this difference is unavoidable, given the very different nature of the two topics – development standards and examples versus content strategy, planning, and guidelines. Yet, this difference results in *The Elements Of Content Strategy* proving to be very complementary to the previous two books.

## Why review all three of these books at once?

Each of these three books serves as an excellent primer on their subjects. They give you a number of tools that you can use right now, while also pointing towards additional topics and associated resources that you can turn to for more depth. While these are not definitive, one-stop guides to the full breadth of HTML5, CSS3, or content strategy, each makes for a perfect jumping off point for those new to the topics.

Both *HTML5 For Web Designers* and *CSS3 For Web Designers* blend theory, explanations, and examples to great effect, and in both cases you’ll regularly find yourself stopping your reading to test a new HTML or CSS tool. Each contains a range of ideas that you’ll be able to put into great effect today. The same can be said of *The Elements of Content Strategy*, which provides an great illustration of all that goes into the craft of content strategy, while also providing specific ideas and tools that you can turn to in developing content now.

Most importantly, the themes of these three books work well together, providing a complementary range of ideas and tools that developers and content creators can immediately benefit from.

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] A Book Apart, http://www.abookapart.com/pages/about \[accessed July 11, 2011\]

\[[2](https://journal.code4lib.org/articles/#ref2)\] Keith, Jeremy. 2010. HTML5 For Web Designers. New York (NY): A Book Apart, p. 6.  \[COinS\]

\[[3](https://journal.code4lib.org/articles/#ref3)\] Keith, Jeremy. 2010. HTML5 For Web Designers. New York (NY): A Book Apart, p. 11.  \[COinS\]

\[[4](https://journal.code4lib.org/articles/#ref4)\] For a complete list of obsolete elements, see [http://www.w3.org/TR/html5/obsolete.html](http://www.w3.org/TR/html5/obsolete.html) \[accessed July 11, 2011\]

\[[5](https://journal.code4lib.org/articles/#ref5)\] Cederholm, Dan. 2011. CSS3 for Web Designers. New York (NY): A Book Apart. \[COinS\]

\[[6](https://journal.code4lib.org/articles/#ref6)\] Things We Left on the Moon, [http://css3exp.com/moon](http://css3exp.com/moon) \[accessed July 11, 2011\]

\[[7](https://journal.code4lib.org/articles/#ref7)\] Media Queries, [http://www.w3.org/TR/css3-mediaqueries](http://www.w3.org/TR/css3-mediaqueries) \[accessed July 11, 2011\]

\[[8](https://journal.code4lib.org/articles/#ref8)\] CSS Multi-Column Layout Module, [http://www.w3.org/TR/css3-multicol/](http://www.w3.org/TR/css3-multicol/) \[accessed July 11, 2011\]

\[[9](https://journal.code4lib.org/articles/#ref9)\] CSS Fonts Module Level 3, [http://www.w3.org/TR/css3-fonts/](http://www.w3.org/TR/css3-fonts/) \[accessed July 11, 2011\]

\[[10](https://journal.code4lib.org/articles/#ref10)\] Kissane, Erin. 2011. The Elements of Content Strategy. New York (NY): A Book Apart, p. 7-12. \[COinS\]

Nathan Mealey ([nathan.mealey@pdx.edu](https://journal.code4lib.org/articles/)) is the Manager of Library Technologies at Portland State University in Oregon. Prior to this, he was the Information Technology & Systems Librarian at Simmons College in Boston, MA until October 2010.
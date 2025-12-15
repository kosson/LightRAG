---
title: "Book Review: HTML5: Up and Running"
source: "https://journal.code4lib.org/articles/4146"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-04-11
created: 2025-01-10
description: "Mark Pilgrim's HTML5: Up and Running was one of the first books published on the subject. If you’re looking for a really good, well-written, entertaining, concise overview of what’s going on right this very minute with HTML5 technologies and techniques, this is a good book to have."
tags:
  - "clippings"
---
# Book Review: HTML5: Up and Running
Mark Cyzyk

Mark Pilgrim’s HTML5: Up and Running was one of the first books published on the subject. If you’re looking for a really good, well-written, entertaining, concise overview of what’s going on right this very minute with HTML5 technologies and techniques, this is a good book to have.

Mark Pilgrim. HTML5: Up and Running. Sebastopol, CA: O’Reilly and Google Press, 2010. 205p. ISBN: 978-0-596-80602-6

Reading the first chapter of Mark Pilgrim’s HTML5: Up and Running, I kept thinking to myself, “What kind of geek would you have to be to find this the least bit interesting?” My kind of geek, I guess, because I found it riveting.

Chapter 1 of this slender volume traces, among other things, the genesis and evolution of the HTML <img> element, starting with an initial Usenet post by Marc Andreesen back in 1993. For those who don’t know, Marc Andreesen was the University of Illinois programmer who cowrote, with Eric Bina, the world’s first popular graphical Web browser, Mosaic. For a time, back in the early-mid nineties, he was the poster boy for all things Web. This first chapter traces his initial suggestion for an <img> element, its reception by the Usenet group, the group’s competing suggestions, its ultimate inclusion in Mosiac, and then a nice historical overview of the development of HTML and XHTML standards, all as context for the recent advent of HTML5 and a prelude to the rest of the book. As someone who appreciates that most things we take for granted in our workaday worlds – tools, technologies, techniques, policies – do not fall in final form out of the sky, but instead have idiosyncratic histories and individual evolutions, I found Pilgrim’s narrative of the evolution of a single HTML tag instructive, illuminating, even fascinating in its drama. Here is one small, microcosmic example of how all that we are familiar with in the Web world came into being. Interesting stuff.

Chapter by chapter, the author then takes us systematically through the new features of HTML5. Chapter 2 focuses on techniques for detecting browser support of particular HTML5 functions. The author usefully provides raw JavaScript snippets for doing this, but then introduces us to the even more useful “Modernizr” library for HTML5 feature detection \[[1](https://journal.code4lib.org/articles/#note1)\]. While browser compatibility for HTML5’s new features and functions is described throughout the book, Chapter 2 emphasized general coding techniques that help ensure detection and graceful degradation when HTML5 is not supported.

Chapter 3 starts digging into the new functionality of HTML5. After an illuminating discussion of the importance of proper <!doctype> declarations, it discusses and illustrates the new semantic tags in HTML5. Use cases and code illustrations for <section>, <header>, <footer>, <article>, <time> tags are provided.

Chapter 4 addresses the new <canvas> element, a tag that defines a region on the page for drawing and scripting 2D shapes and bitmap images. Drawing in 2D is useful and cool, and the book shows how to draw lines, circles, gradients, etc., but the HTML5 specs leave room for a <canvas> that supports 3D, and when that happens I think we are all going to witness great things. Back in the day, I was always intrigued by the Virtual Reality Modeling Language (VRML). I wonder how this new technology might compare? We’ll see.

Chapter 5, Video on the Web, I found to be really interesting. It not only emphasizes HTML5 support for the various video/audio containers and codecs, but it explains what those containers and codecs are, how they relate to one another, and how to plan for the graceful handling of idiosyncratic browsers by adhering to a recommended hierarchy of video/audio formats; page 90 lists a useful workflow for creating multiple versions of video clips and streams in differing formats so you squeeze the best performance possible out of every browser/codec format combination.

Chapter 6 addresses the HTML5 geolocation API which enables Web browsers and their users to share location information with trusted Websites, and Chapter 7 delves into the topic of local storage for Web application use, its history and evolution from the ubiquitous cookie to the new Web Storage feature allowing name/value pair storage of a default, relatively whopping, 5MB of data.

Chapter 8, “Let’s Take This Offline”, ponders the notion of an “offline Web application”. Browsers supporting this will look for a linked manifest file in a page’s <head> section. Any files linked from this manifest will then be downloaded and cached for offline use. A slew of potential problems surround this behavior which the author admirably dissects and debugs.

I’m betting the features discussed in Chapter 9, “A Form of Madness”, will be the most appreciated in the promising new HTML5 world. Here are enumerated the multiple new HTML form input types available to HTML5-compatible browsers. These include support for an autofocus formfield, placeholder text in a formfield, new input types for email addresses, URLs, numbers as spinboxes, a slider input type, and a nifty date picker input type. All of this simply makes programming those HTML forms easier for you, the programmer. No more JavaScript snippets required when these sorts of functionalities are built directly into the browser.

The final chapter, “‘Distributed,’ ‘Extensibility,’ and Other Fancy Words,” introduces the notion of “microdata”. Essentially, microdata is metadata about what’s on the page, integrated directly with data on the page; “microdata” refers to the use of custom vocabularies to semantically markup data on a page. An example in the book suggests a vocabulary for the concept of  
“person”, including such terms as “name”, “nickname”, “affiliation”,  
and “title”. This chapter shows how to create a namespace for the “person” vocabulary, then how to mark up data on the page accordingly. So here we find, on page 171, the following illustration, with semantic markup (“name”, “title”, “affiliation”) intermixed with structural/presentation markup (dd, dt):

```
  <dd itemprop="name">Mark Pilgrim</dd>
  ...
  <dt>Position</dt>
  <dd><span itemprop="title">Developer advocate</span> for
      <span itemprop="affiliation">Google, Inc.</span></dd>
```

Why is this important? This technique lends semantic meaning when being programmatically processed by, say, a search engine. A program looking at your page can tell, via microdata markup, that this-here-is-an-actual-name-of-a-person rather than merely being a string of characters on the page.

Pilgrim, in this chapter, then illustrates how this notion of “microdata” is supported by Google’s Rich Snippets technology \[[2](https://journal.code4lib.org/articles/#note2)\]. Basically, Google will crawl your page, determine that there is microdata present, index the values contained within this semantic markup, and usefully customize its presentation of search results accordingly. So searching for a properly-marked-up “person”, Google will return a search results screen in the usual format, but will also set aside screen real estate to highlight the fact that the string being searched is about an actual person, someone with a name, title, and position in an organization.

The book concludes with an Appendix recapping the new features and elements in the HTML5 specification. Just glancing through this list gives you a quick impression of the scope of changes in the new spec.

As always, O’Reilly books qua technical books set the standard for page layout, code quotation conventions, sidebar formatting, etc.; things you might not think about, but they add greatly to the readability and effectiveness of the book as a whole. I raise my glass to the book designers of O’Reilly.

My sense, heightened and honed by this book, is that all of this HTML5 business is rapidly morphing and evolving. Although tech books eventually go the way of the <blink> tag, I’m sensing that this one will go quicker than, say, your beloved and venerable O’Reilly Dynamic HTML: The Definitive Reference. Nevertheless, if you’re looking for a really good, well-written, entertaining, concise overview of what’s going on right this very minute with HTML5 technologies and techniques, this is a good book to have.

An evolving version of the book freely is available from the author at [http://diveintohtml5.org/](http://diveintohtml5.org/).

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Modernizr JavaScript Library. [http://www.modernizr.com/](http://www.modernizr.com/)  
\[[2](https://journal.code4lib.org/articles/#ref2)\] Rich snippets (microdata, microformats, and RDFa). Google Webmaster Central. [http://www.google.com/support/webmasters/bin/answer.py?answer=99170](http://www.google.com/support/webmasters/bin/answer.py?answer=99170)

Mark Cyzyk is the Scholarly Communication Architect in The Sheridan Libraries, Johns Hopkins University, Baltimore, Maryland, USA. In 1994 he installed Trumpet WinSock and an early version of the NCSA Mosaic Web browser on a computer at the reference desk of the Albert S. Cook Library, Towson State University, Towson, Maryland, at which point he gathered everyone around, hit the button, and lo and behold, a *pretty picture on the screen*!
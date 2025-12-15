---
title: "COLUMN: 700 Dollars and a Dream : Take a Chance on Koha, There’s Very Little to Lose"
source: "https://journal.code4lib.org/articles/28"
author:
  - "[[The Code4Lib Journal]]"
published: 2007-12-15
created: 2025-01-10
description: "I truly believe that the meekest amongst us has a special duty and a special circumstance that fosters innovation. Ours is not the culture of red tape entrenched tradition, but rather the atmosphere of the pioneer. No one will notice a failed experiment in the middle of nowhere, but they'll certainly notice a cataloguer someplace [...]"
tags:
  - "#Koha"
  - "#ILS"
---
I truly believe that the meekest amongst us has a special duty and a special circumstance that fosters innovation. Ours is not the culture of red tape entrenched tradition, but rather the atmosphere of the pioneer. No one will notice a failed experiment in the middle of nowhere, but they’ll certainly notice a cataloguer someplace in Edema making a dent in backwards standards.

# COLUMN: 700 Dollars and a Dream : Take a Chance on Koha, There’s Very Little to Lose
BWS Johnson

One of the sentiments that I try to infect the Library Science populace with is the notion that innovation can come from anywhere at all. This is especially true of rural libraries. I truly believe that the meekest amongst us has a special duty and a special circumstance that fosters innovation. Ours is not the culture of red tape entrenched tradition, but rather the atmosphere of the pioneer. No one will notice a failed experiment in the middle of nowhere, but they’ll certainly notice a cataloguer someplace in Edema making a dent in backwards standards. So much of this field is not about the money—technology is definitely in that basket, particularly with Open Source making a fierce showing of things.

This was the argument I took to my Board: let me take a small portion of our State Aid to Public Libraries money and try out this new fangled thing. The software’s free. Yes really, we don’t pay anything for it, I just go out and grab it. Nope, it won’t be more than $1,000 so we’ll still have emergency money. If it doesn’t work out, I can just reformat the drive, make it a regular old public access terminal, and we’re good to go. Nope, it’s not stealing. Everyone’s got something to give back to the community, and when I set things up and figure out what does what, I’ll write about it, and that’ll be our share. It’s like a barn raising.

We had nothing to lose—our Library wasn’t automated yet. Ours was the perfect test environment. My Board was receptive, my Patrons weren’t attached to any system whatsoever, and my Staff were behind the move. My loving husband was willing to install this for us, as well as physically assemble a custom server, although that’s not necessary—Koha will run on just about everything. As with any other product, the more you put into your hardware, the better the result until you top out at a certain point. On Koha, that point is frighteningly low, making my $700 box a Ferrari Testarossa. With the proliferation of Linux user groups out there, it oughtn’t be too hard for just about anyone to approach the geeks that be and walk away with a functional server in a matter of a few hours.

We’re mostly done with bibliographic input now—we’ve got just over 7,000 items catalogued of about 8,500. Our Patrons are in the database. We could circulate now if we wanted to. We’ve tested the basic features that we need and they work well enough for our purposes. When we started out, we were looking for the barest minimum of functionality. We got a whole lot more than we bargained for.

Koha is far more reliable than many commercial ILS options. This was certainly a factor with me. It seemed as though things would be down every other month for a few days of unscheduled time with a few of the commercial products I’ve had the displeasure of experiencing. Our server has been down twice in about 3 years of testing, with the box running 24/7. Once was when my roommate inadvertently unplugged the server to charge his mobile phone. The second time was a catastrophic hardware failure. The power supply essentially caught fire. I was terribly worried my data was toast. It wasn’t. I had backups, but I didn’t need to use them.

Koha is far better at keyword searching than anything I’ve ever seen. Something in the way it ranks search results really ends up giving you highly relevant items first. It also loots and pillages its way through a MARC record so that those notes fields everyone tires over are searched through, too.

The support is astounding. I have yet to pay money for support, yet I’ve had developers bend over backwards to program in a feature I’ve wanted, in a remarkably short span of time. A basic reports module came to me free of charge inside of a couple of days from across the ocean in France. An IRC channel dedicated to Koha tends to have someone on it most of the time. With heavily involved developers in the United States, France and New Zealand the project doesn’t sleep. I can’t imagine the results you would see if you had a few thousand dollars to give to a developer for your feature. At a recent demo, I was eating lunch and chatting with the other Librarians about which developer was responsible for what feature. One of the other Librarians stopped me and said of their product, “Wow, this is so great. You know the **names** of the developers. We’re lucky to even get through to support on the telephone!”

With Koha you get something you don’t get with any other product. You have compleat control over what your catalogue looks like, you don’t have to wrestle with a vendor to get your data to do what you want it to do, and if the product doesn’t have a feature you need, you can programme it or pay someone to add it.

The rate of development and improvement over the past few years has been nothing short of astounding. When I started using Koha, it was very wooden and very ugly. It’s come a long way since then. The current out of the box release is on par with at least a handful of commercial products. When the templates are customised for a given Library, the product can meld seamlessly and aesthetically with a Library’s website. The Horowhenua Library Trust catalogue can give you a taste of the aesthetics: ([http://www.library.org.nz/cgi-bin/koha/opac-main.pl](http://www.library.org.nz/cgi-bin/koha/opac-main.pl "Horowhenua Library Trust Catalogue")) The upcoming Version 3 looks quite like the Athens County catalogue: ([http://search.athenscounty.lib.oh.us/](http://search.athenscounty.lib.oh.us/ "Athens County catalogue"))

Since Koha was developed in New Zealand, connectivity issues caused the developers to make a product that would be very easy to access regardless of the speed of a person’s connection. I was able to access the catalogue which resided at home in Albany, New York from my Library in Western Massachusetts with no noticeable wait time for searching and data input over an incredibly crummy connection. (It was allegedly a 56k connection, but the plain old dial up telephone line connections routinely ran faster.)

It’s not for everyone, however.

Installation is still difficult. Unless you’ve someone in the area who is very comfortable with Linux administration, this project will be a difficult set up. On the other hand, one can pay for a preinstalled box.

Cataloguing for a large institution would be tough. Holdings information is a bit bodged at the moment. The cataloguing module is certainly clunky to use. The interface is tabbed with each MARC field getting its own text box. As a result, either a Librarian ends up sticking all of the fields in one tab for a really long screen of many, many boxes, or fields are missed by sloppy cataloguers that don’t switch tabs. It is possible to set up frameworks that anticipate necessary fields for a given material type, but this entails a good deal of planning during setup. The good news in this department is that thanks to Google summer of code, a powerful new tool is being worked on to make things much nicer for cataloguers everywhere, and functionality should be vastly improved with Version 3.

Reports are also getting a massive workover thanks to sponsorship from the British National Health Service. These can be tricky from a programmer’s perspective thanks to each client wanting a different data set. The new module will guide a user through the process of selecting which sets they’d like in order to produce the table or chart they’d like to pull from the raw data.

Because Koha came from the mind of a computer programmer, there are creature comforts that Librarians take for granted that could be absent or less fleshed out than one might like. Increasingly, this is less true as the developers address new feature requests and the project gathers fans, and thus steam, along the way. The positive side of this is that it rapidly assimilates neat new Web 2 innovations, for instance tag clouds are going to be featured in the new OPAC.

Like everything out there, there are bugs. Developers do work to keep this down to a minimum, but I don’t want anyone to think I promised perfection. Users are encouraged, and yea, even thanked when they submit problems to the project’s bug tracker, bugzilla ([http://bugs.koha.org/cgi-bin/bugzilla/index.cgi](http://bugs.koha.org/cgi-bin/bugzilla/index.cgi "Koha bug tracker site")).

It’s far from perfect, but I can’t name a commercial product that has it all.

Ask yourself—what does my Library have to lose? Why not run an open source catalogue redundantly to your current system to discover the differences for yourself? If you do like Koha, imagine how much you do have to lose in terms of that nasty annual license fee. You can choose to either have the product supported at an affordable rate or you can just set everything up yourself and never pay a thing except for the cost of the hardware.

The model that Koha is based on is very similar to National Public Radio or the Corporation for Public Broadcasting. Open source is out there waiting to be enjoyed by everyone, regardless of financial status. Just as local programming is developed in your backyard and contributed back to the National efforts, individual Libraries can customise their installation. When some flavours are contributed back, like the Nelsonville templates, they prove to be very popular and are widely accepted in turn, like Fresh Air or Nova. Not everyone supports their local affiliate in a fund drive, and not everyone can afford to financially support the Koha project. When Libraries choose to pay for support or new features, everyone benefits since good reliable features can be selected out and then rolled into the product. Even small contributions of time and labour end up making large differences in making the product better through collective effort.

There is further information and a demo on the Koha web site: [http://www.koha.org](http://www.koha.org/ "Koha web site")

and Nicole Engard has a blog entry about Koha: [http://www.web2learning.net/archives/1165](http://www.web2learning.net/archives/1165 "Nicole Engard Blog about Koha")

BWS Johnson is a graduate of the Graduate School of Library and Information Science at the University of Illinois Urbana – Champaign and was the Director of the Hinsdale Public Library in Hinsdale, MA. She was recently honoured to serve as President of the Western Massachusetts Regional Library System.
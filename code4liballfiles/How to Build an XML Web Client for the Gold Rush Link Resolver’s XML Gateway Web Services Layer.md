---
title: "How to Build an XML Web Client for the Gold Rush Link Resolver’s XML Gateway Web Services Layer"
source: "https://journal.code4lib.org/articles/1324"
author:
  - "[[The Code4Lib Journal]]"
published: 2009-03-31
created: 2025-01-10
description: "The Gold Rush link resolver (GRLR) is part of a suite of programs developed by the Colorado Alliance of Research Libraries (CARL) which help manage a library's electronic resources. It contains the essential features required to perform link resolution, and comes at a substantial discount compared to other commercial Link Resolvers. After a comprehensive review [...]"
tags:
  - "clippings"
---
# How to Build an XML Web Client for the Gold Rush Link Resolver’s XML Gateway Web Services Layer
Brian Kysela

The Gold Rush link resolver (GRLR) is part of a suite of programs developed by the Colorado Alliance of Research Libraries (CARL) which help manage a library’s electronic resources. It contains the essential features required to perform link resolution, and comes at a substantial discount compared to other commercial Link Resolvers. After a comprehensive review of the available options, the library at the University of Tennessee at Chattanooga (UTC) chose to implement Gold Rush over the summer of 2008. The UTC library also decided to take advantage of the release of the Gold Rush XML Gateway Web Services Layer by the Colorado Alliance in the spring of 2008. This article is a case study of how the UTC XML Web client was built and the steps necessary to successfully deploy such a client.

## 1\. Introduction

This article will focus on the actual steps, with code examples, taken to build the XML Web client, through which I hope to demonstrate a model of good project planning to create a serviceable application.  For a brief overview of an XML Gateway and link resolvers, see the recent Code4Lib Journal article “Auto-Populating an ILL form with the Serial Solutions Link Resolver API” by Daniel Talsky [\[1\]](https://journal.code4lib.org/articles/#note1).

## 2\. The Project Requirements

We began the project by drawing up a requirements document.  When we decided to implement the Gold Rush link resolver, we determined that, if possible, the new resolver should resemble the former vendor’s look and feel closely while allowing for the necessary transition by our users. We would introduce newer features and designs gradually. This is working well in practice.

Shortly after our selecting Gold Rush, CARL announced that their XML  Gateway Web Services Layer was ready for production use. This was excellent news for us, because we wanted a maximum of flexibility in designing the look of the new link resolver.  This would allow me to build an XML client and preserve what we needed of the previous vendor’s Web interface.

With this in mind, it was fairly simple to write up the project requirements. Without reproducing the full document, suffice it to say that the main   requirement of this project was to implement an XML Web client that would allow for a gradual transition of the Web interface while taking advantage of  the new XML gateway technology.

## 3.a The Project Specification

The next traditional step in programming is to develop a project specification that outlines exactly what the program will do. The project specification is especially relevant here, because it is a document for which the programmer takes responsibility. The most important part of the specification is determining the scope of the project. That is, just what will the program be doing?  Naturally, the specification draws on the project requirements.

Over several meetings, we determined how the new interface would appear to users. Some parts of the design were left to be worked out when the vendor’s XML gateway could be understood in greater detail. All in all, the project specification was fairly neatly bound by what our former link resolver was capable of doing. New features would be determined at a later date.

## 3.b The Vendor API

The Vendor API is fairly straightforward. Following are brief summaries of a couple of methods that have a different calling syntax from the typical Gold Rush API. Full details can be found in their XML Gateway documentation [\[2\]](https://journal.code4lib.org/articles/#note2). Only a few methods have a different calling syntax: browseJrnlSubjects and grlResolveArticle.

**browseJrnlSubjects**

As the name implies, this is a left-anchored search of journal subjects. This method only requires that a search string be sent with a query.

**grlResolveArticle**

This is the critical method for link resolution. It requires article metadata to be sent so that a proper look-up can be performed. This includes, at a minimum, the ISSN and journal title.

## 4\. The Minimal Prototype

Most anyone who enjoys programming enjoys seeing results, and those as  quickly as possible.  With XML gateways, a variety of methods are open to a programmer. I have a long history of working with Linux and have been using Perl for as many years.  Perl has an excellent library, or, more  properly called, perhaps, a module for dealing with XML called  Soap::Lite [\[3\]](https://journal.code4lib.org/articles/#note3).  Do not be mislead by the name–it is a heavy duty library that accomplishes much while providing the user of the library with a lightweight interface.

It can be a daunting task to have 70 or so pages of vendor documentation and only a few documents that will guide a project not yet begun. I like to start simply by having something that can immediately show several things: (1) that the XML gateway is up and running; (2) that the client code I am writing functions; and (3) that the client code returns appropriate results. To properly determine all this required only a few lines of code as follows:

```
#! /usr/bin/perl
use warnings;
use strict;
use SOAP::Lite;
use Data::Dumper;
$Data::Dumper::Indent = 1;
my $gw = "http://grx.coalliance.org/grx.php";
my $soap = SOAP::Lite->proxy($gw);
my $result = $soap->fullJTRec("001_AUR", 26707)->result;
print Dumper($result);
```

Only four lines of code are needed, after line 1 that lists the interpreter, and lines 3-7 that list the required Perl pragmas and modules to use in this program. Line 9 notes the HTTP address of the Gold Rush XML gateway. Line 10 sets up the SOAP::Lite script to be called with the Gold Rush gateway method ‘fullJTRec’ in line 11. The variables ‘001\_AUR’ and ‘26707’ are specific to the ‘fullJTRec’ method. The first is the Gold Rush assigned ID that will identify your particular data store with the vendor. The second variable, ‘26707’, is an id for a particular resource that I happen to know will work with the data source cited.

If you are not sure what would work when setting this up, a general purpose search would work as well. A generic method like the following could be substituted for line 11.

```
my $result = $soap->browseJrnlFT("001_AUR", "Library")->result;
```

This method, ‘browseJrnlFT’, does a browse of journals that have full text articles indexed. Line 11 is really the only line that runs. The others merely set up the environment.  The last line uses the Perl Data::Dumper module to print the results that are stored in the variable $result. Lines 6 and 7 bring in this convenient library and give it a nice level of indentation when   printing. Running this script will allow inspection of the results returned from the Gold Rush gateway.

Results from a search like this come back in a raw form. Here is a selection from the browseJrnlFT search noted above:

```
$VAR1 = bless( {
'grx_error' => bless( {}, 'grxError' ),
'brief_recs' => [
bless( {
'issn' => '0041-7912',
'jtitle' => 'LC classification, additions and changes',
'id' => '90134'
}, 'browseListItem' ),
bless( {
'issn' => '1756-1086',
'jtitle' => 'Library & Information Research : Research into Practice for Information & Library Services',
'id' => '312136'
}, 'browseListItem' ),
```

Doesn’t look like XML, does it? We let SOAP::Lite deal with that. The logic of what data goes where is more interesting. The data returned above has been stuffed into an easily parsed Perl hash. Now that we know the gateway server is up and running, we now have a client that not only works properly, but it also can return interesting results that relate to how it is called.

## 5\. The Maximum Prototype and a Variation

Once I understood how to get results out of the Gold Rush gateway, it was only a matter of determining what the patterns in the Gold Rush gateway methods were. With that information, I built a generalized prototype that could easily call any of the possible methods and display the results. Notice that this prototype works from the command line and will not be related directly to the finished client. This will be invaluable in saving time in troubleshooting the finished client.

In order to troubleshoot with any precision, it is necessary to know what is happening at as low a level as possible. The SOAP::Lite module has   additional means for giving low-level information, if need be. For example, it is possible to trace many of the events or parts of SOAP::Lite as it processes requests. At times this too proved useful in determining the causes of errors in data returned by the server. I generally used the prototype to view raw data since I was mainly interested in transforming that data.

The large prototype evolved in tandem with the development of the Web client. The finished prototype rendered a command line menu-driven interface to allow easy testing of all the gateway methods:

```
Enter a number for the corresponding action:
[0] quit
[1] browseJrnlFT
[2] browseJrnl
[3] browseJrnlSubjects
[4] browseDB
[5] browseDBCategory
[6] searchByISSN
[7] searchByDBTitle
[8] searchByJrnlTitle
[9] searchByKeyword
[10] searchBySubject
[11] journalListA2Z
[12] databaseListA2Z
[13] grlResolveArticle
[14] fullJTRec
[15] fullDBRec
[16] getDBTitlelist
Enter:
```

As you can see, the menu presents the user with a simple list that can be called by number. You may also note that not all gateway methods are implemented. The methods not implemented include those that return extremely large data dumps of the client datasource. Even if we had intended to use those methods, this prototype would not have been the place to run and test them.

One important variation on this prototype is a Web version that made the debugging of OpenURL links much easier. These OpenURL links would be sent via email, but different email clients would mangle them in different ways. It became quickly tedious to unravel these links and insert them into a proper form for loading into a browser and debugging. So, out of urgent need to retain sanity, I hacked together a URL demangler and debugger. It is not the most elegant of solutions, but it works well and allows much easier debugging.

## 6\. The Web Client

While having a working prototype is satisfying, the real project is the working Web client that patrons will eventually be using. To produce this required more than just an understanding of how the Gold Rush XML gateway server and a client can be built. It required thinking through how to bring what goes on in the engine, so to speak–the client/server interaction– together with the search and results screens for the users–what one might consider the controls.

Providing an interface that was consistent with the previous vendor’s controls was one of the most difficult parts of the project, since not all the methods of the new service mirrored exactly what we had had previously. With some ingenuity we were able to bring the functionality relatively close, but not in every case. A simple example is that a browse by title in the new interface would bring entries up that included titles indexed under an alternate title.  So if a user does a search beginning with the letter ‘B’, for example, the result set will begin with alternate titles that begin with an ‘A’. For the future, we have asked the vendor to index the results under the actual alternate title, so that these results will appear consistent.

Turning to the overall architecture of the Web client, the results were not what we initially had in mind, but are conceptually very similar. In considering how to design this project, I was guided by a thoroughly traditional idea of design: I wanted a very simple structure which would allow me to upgrade the project software easily, while retaining configuration directives across upgrades. The solution turned out to be a simple directory structure which would allow for a modular design approach. Clearly a configuration file would be needed, but it could not occupy a place where it might be overwritten during an upgrade.  Coming from a Linux background, this meant that the configuration file would be placed in ‘/etc’ on the Web server, a typical place for configuration files in the directory hierarchy of a Linux or Unix server.  This turned out to be the only file outside the project directory.

## 7\. The Project Directory

Below is a list of all the directories within the main ‘grx’ project  
directory:

```
-rw-rw---- 1 apache web  4217 2009-01-13 16:55 INSTALL
-rw-rw---- 1 apache web 20217 2008-07-16 12:01 LICENSE
-rw-rw---- 1 apache web  5004 2008-12-17 16:42 README
drwxrwx--- 2 apache web    96 2009-01-14 15:09 bin
drwxrwx--- 3 apache web  4096 2008-07-09 10:01 cache
drwxrwx--- 2 apache web    43 2008-07-24 11:59 conf
drwxrwx--- 3 apache web    29 2009-01-13 17:52 lib
drwxrwx--- 4 apache web    28 2008-04-28 09:46 tt
drwxrwx--- 6 apache web    61 2009-01-15 15:59 www
```

The ‘bin’ directory holds the standalone utility programs like the full prototype for debugging, and scripts for building the cache that will be discussed further below. The ‘cache’ directory holds cache files that are accessed by the Web client. Since the actual configuration file is not part of this project directory, the sample configuration file is included in the conf directory. The ‘lib’ directory contains two files that are the bulk of the project: ‘lib/GRX.pm’ and ‘lib/GRX/ResolveArticle.pm’.  These two files are the implementation of the list of methods seen above in the prototype menu.  The ‘tt’ directory represents the HTML template file directory. I labeled it ‘tt’ since I make use of the Template::Toolkit module for Perl. This is where the pages to be customized for the user screens are kept. All the HTML files are here rather than in the last directory, ‘www’, which contains the files that the Web server must have access to. Those files include the programs that make everything else work, as well as the CSS, JavaScript and image directories.

One of my goals while creating this project was to keep it as compact as possible. If we only consider the ‘lib’, ‘tt’ and ‘www’ directories (all that is truly needed to make everything go) the project is around 60KB in size.

## 8\. The Web Directory

Whenever I read about a new software project, I am always most interested in how it works: what makes the wheels turn? For my project, it is very simple. The Web server is set up to serve the ‘/grx/www/’ directory. On Linux, using Apache, I just place the project in ‘/var/www/’ and set up Apache to run what it finds in there by adding the following directives to the Apache httpd.conf file:

```
Alias /grx /var/www/grx/www/
<Directory /var/www/grx/www/>
AllowOverride None
DirectoryIndex index.cgi
Order allow,deny
Allow from all
Options +ExecCGI
AddHandler cgi-script .cgi
</Directory>
```

Setting it up like this will allow the Apache web server to serve both files that control what I call the ‘grx’ application:

```
/grx/www/index.cgi
/grx/www/grl/index.cgi
```

The first handles all the browsing and searching methods for journals. The second one deals with the link resolving method. This method, lightheartedly enough, is listed under ‘Miscellaneous Functions’ in the Gold Rush XML Gateway manual. This function was where I spent the bulk of my development time. If you would like to follow along at home,  I use the git version control system to manage the project and have a public git repository available with the latest development snapshot [\[4\]](https://journal.code4lib.org/articles/#note4).  The key to getting started is the installation of several Perl modules. This can be automated easily and is covered in the INSTALL file that you will find in the git repository.

Below is the first index.cgi file that drives the searching:

```
#!/usr/bin/perl
use warnings;
use strict;
use lib '../lib';
use GRX;
my $grx = GRX->new(
{   'browseJrnlFT'       => 1,
'browseJrnlSubjects' => 1,
'searchByISSN'       => 1,
'searchBySubject'    => 1,
'searchByKeyword'    => 1,
'fullJTRec'          => 1,
'grlResolveArticle'  => 1,
}
);
$grx->run();
```

As you can see, it is very brief. The real work is done in the GRX.pm library that is called on line 6. Lines 8-17 are merely for setting up what methods can be called on the new $grx object. I implemented most of the methods, although we did not actually use them in our final design. Line 19 is what makes everything go. The other CGI file, for article resolution, is even more brief:

```
#!/usr/bin/perl
use warnings;
use strict;
use lib '../../lib';
use GRX::ResolveArticle;
my $gRA = GRX::ResolveArticle->new();
$gRA->run();
```

Notice that the real work is done in the GRX::ResolveArticle library. When I first started building the application, I did not use an object oriented design, but quickly realized its benefits and switched over to that approach. It made the development infinitely easier.

## 9\. The Template Directory

The ‘tt’ directory contains two directories with only a few files in each:

```
tt:
total 0
drwxrwx--- 2 apache web 69 2008-12-10 09:59 lib
drwxrwx--- 2 apache web 40 2008-12-10 11:34 pages

tt/lib:
total 20
-rw-rw---- 1 apache web 1894 2008-07-24 11:43 foot.html
-rw-rw---- 1 apache web 4354 2008-09-22 10:37 full_JT_rec_display.html
-rw-rw---- 1 apache web 6290 2008-06-04 15:00 head.html

tt/pages:
total 16
-rw-r--r-- 1 brian  users 4657 2008-12-09 09:52 grl.html
-rw-rw---- 1 apache web   6971 2008-07-25 15:18 results.html
```

The library directory (tt/lib) has parts of pages, like the header and footer, and also has one piece that turned out to be used in two different parts of the HTML pages. I abstracted it and put it in the library rather than duplicating the code. The second directory contains the pages of the user interface which combine with the boilerplate found in the library directory.  The ‘results.html’ page contains the search and browse interface. I conveniently had the search interface also display the results when they became available.  This cuts down on the potential proliferation of pages. The ‘grl.html’ page serves as the result, or, locally termed, the ‘landing’ page for article resolution.

## 10\. The GRX Perl Modules

Without going into great detail about each of these libraries, I will sketch out the form each one took in order to communicate something of the overall design.

### 10.1 The GRX.pm Module

This library contains all the functions that control the searching. If you review the code for ‘/grx/www/index.cgi’ above, you will see that it creates a new object. This calls the following method in the GRX.pm module:

```
24 sub new {
25     my ($invocant, $arg_ref) = @_;
26     my $self = bless( {}, ref $invocant || $invocant );
27     $self->init($arg_ref);
28     return $self;
29 }
```

From here the methods are passed in and then sent along to the ‘init’ method:

```
31 sub init {
32     my ($self, $arg_ref) = @_;
33     $self->ok_methods($arg_ref);
34 }
```

The init method determines what methods can be called from how it was called in index.cgi. The next step, as per the CGI script in section 8 above, is to set everything moving with the ‘run’ method, which calls this function in GRX.pm:

```
71 sub run {
72     my $self = shift;
73     $self->get_vars();
74     $self->check_method();
75     $self->get_results();
76 }
```

This function or subroutine does an excellent job at summing up the rest of the program’s execution: (1) obtain any needed variables, whether from the configuration file or sent in by a form; (2) check to make certain we have a valid method request; (3) finally, go and make a request from the Gold Rush XML server gateway. The get\_results method calls the appropriate method. Since the methods for searching are generally the same, that is, send the Gold Rush datasource ID and the search string with the method, I created a default search routine for all but the two that have a different syntax in the Gold Rush XML gateway API: browseJrnlSubjects and grlResolveArticle. The default method requires the institution ID string be sent with the search string. The ‘browseJrnlSubjects’ method only requires a search string. The ‘grlResolveArticle’ method requires a set of article metadata be sent. This is the extent of the Gold Rush XML Gateway API.

The last thing that is done in GRX.pm is the get\_results subroutine, which calls the process\_template subroutine that generates the output for the Web server to display to the user:

```
304 sub process_template {
305     my $self = shift;
306     my $path = $self->grx_path();
307
308     print header(); # A CGI.pm method
309     $| = 1; # Turn buffering off
310
311     my $template = Template->new(
312         { INCLUDE_PATH => "$path/tt/lib:$path/tt/pages" } );
313     $template->process( $self->tt_file(), $self->tt_vars() ) || die $template->error();
314     return 1;
315 }
```

This subroutine is fairly short and straightforward. The important line is line 313, which calls the Template::Toolkit method ‘process’ that actually processes the template files in the tt/lib and tt/pages directory discussed above.

### 10.2 The ResolveArticle.pm Module

The ResolveArticle.pm module is strikingly similar to the previous module, having ‘new’, ‘run’, ‘get\_vars’ subroutines and, in this case, one method call: grlResolveArticle. Since there is some bit of overlap between the two modules, I will concentrate on explaining the grlResolveArticle method call which is unique to this module:

```
147 sub grlResolveArticle {
148     my $self = shift;
149
150     my @vars = ( $self->grx_id(), $self->grl_ref() );
151
152     eval {
153         $self->grx_result(
154             $self->soap_script()->grlResolveArticle(@vars)->result );
155     };
156     if ($@) {
157         $self->error_string($@);
158         $self->do_error();
159     }
160     elsif ( !defined $self->grx_result()->{'citation'} ) {
161         my $cite = get_citation($self);
162         $self->tt_vars( { 'result' => $cite } );
163         $self->tt_file('grl.html');
164
165         if ( $self->email_errors() ) {
166             my $subject = $self->subject_line() . " " . $self->remote_host();
167             my $message = $self->url(-full=>1, -query=>1) . "\n\n" . $self->referer();
168             $self->mail_it($subject, $message);
169         }
170         return 1;
171     }
172     else {
173         $self->tt_vars( { 'result' => $self->grx_result(), } );
174         $self->tt_file('grl.html');
175         return 1;
176     }
177 }
```

This is the same pattern as before: retrieve variables, the datasource id and the search parameter. This is done on line 150. Line 154 makes the request to the Gold Rush XML server. This is wrapped in a Perl eval to make sure it works; if not, it throws an error. Otherwise it continues, obtaining a citation if the XML gateway does not provide one on line 161. (This had shown up during development and was used to work around a problem that was later solved. I left it in just in case it should ever turn up again.) A configuration option allows  me to set whether it will throw an error and who will receive it if this does happen. Template variables are set up on lines 162-163.

After the grlResolveArticle method runs, the results are displayed by calling the process\_template subroutine contained in the GRX.pm module, since we use that module as a base to this one. This means we can call its methods from this Perl library, and conveniently, even override them as we like.

## 11\. Conclusion

With a minimum of code I was able to implement an XML Web client that provided the ability to customize the UTC link resolver interface as needed during the transition from the previous link resolver. All the program logic is found in two library files, while the appearance is updated by modifying the template files. This design provides a clean separation between program logic and presentation. The flexible design also allows for ease of maintenance and seamless upgrading of the code base.

In closing, I would like to emphasize that the project grew organically, but was structured according to the project requirements and specification. I placed special emphasis on having good debugging tools close at hand and creating a design that would allow me to not only share the code, but also to drastically change any one aspect without affecting any other part of the code base unnecessarily. Keeping the design simple, and the program short was also key.

## Licensing Information

With respect to the code, I offer it under the same terms as Perl itself.  There is a license file included with the distributed code for further reference.

Brian Kysela is the Web Technologies Librarian at the University of Tennessee at Chattanooga.

—-

Footnotes

\[1\] [http://journal.code4lib.org/articles/108](https://journal.code4lib.org/articles/108)  
\[2\] [http://grx.coalliance.org/grxtest/dsp/grx\_documentation.pdf](http://grx.coalliance.org/grxtest/dsp/grx_documentation.pdf)  
\[3\] [http://search.cpan.org/~byrne/SOAP-Lite/lib/SOAP/Lite.pm](http://search.cpan.org/~byrne/SOAP-Lite/lib/SOAP/Lite.pm)  
\[4\] [http://www5.lib.utc.edu/pub/scm/grx/core/git/bkysela/grx.git/](http://www5.lib.utc.edu/pub/scm/grx/core/git/bkysela/grx.git/)
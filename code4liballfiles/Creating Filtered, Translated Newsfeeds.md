---
title: "Creating Filtered, Translated Newsfeeds"
source: "https://journal.code4lib.org/articles/3232"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-06-22
created: 2025-01-10
description: "Google Translate's API creates the possibility to leverage machine translation to both filter global newsfeeds for content regarding a specific topic, and to aggregate filtered feed items as a newsfeed. Filtered items can be translated so that the resulting newsfeed can provide basic information about topic-specific news articles from around the globe in the desired [...]"
tags:
  - "clippings"
---
# Creating Filtered, Translated Newsfeeds

James E. Powell, Linn Marks Collins, Mark L. B. Martinez

Google Translate’s API creates the possibility to leverage machine translation to both filter global newsfeeds for content regarding a specific topic, and to aggregate filtered feed items as a newsfeed. Filtered items can be translated so that the resulting newsfeed can provide basic information about topic-specific news articles from around the globe in the desired language of the consumer. This article explores a possible solution for inputting alternate words and phrases in the user’s native language, aggregating and filtering newsfeeds progammatically, managing filter terms, and using Google Translate’s API.

The first decade of the 21st century presented many challenges, including the threat of a deadly global pandemic. In late 2003, SARS suddenly appeared in China and southeast Asia, later spreading as far as Canada, claiming over 800 lives, and significantly impacting the financial wellbeing of the region. Next, bird flu re-emerged, simmering in numerous hotspots around the globe, but as of yet, failing to erupt into a global killer. Just as health authorities around the globe had finished updating their pandemic flu plans to address a feared bird flu pandemic, yet another highly communicable and sometimes deadly respiratory virus emerged from Mexico. Initially dubbed swine flu, the disease eventually did make its way around the globe, but failed to fulfill the anticipated apocalyptic vision of a deadly killer on par with the Spanish flu of 1918. Nonetheless, many of our worst fears were confirmed regarding the rapidity with which a new pathogen can spread among geographically separated regions of the world. In the 21st century, the world is a much smaller place indeed, at least for an infectious human respiratory virus.

It was also a decade that saw many news organizations, both large and small, move more of their presence online. Today it is rare for any news outlet not to have a presence on the Web, via Twitter, Facebook or various other sites enabled by the increasing ubiquity of network technology. This information overload has fueled the popularity of content formats that encourage aggregation and rapid consumption, such as RSS (really simple syndication). RSS and its close cousin, Atom, are structured information syndication formats. They are often used to aggregate news stories from individual content providers such as magazines or newspapers. A newsfeed can be thought of as a temporal scrolling window that provides a view of a collection of news – older articles disappear from the window as newer headlines replace them. The feed includes both collection-level metadata (what publication is the source of the headlines), syndication information (frequency of update, a timestamp for this instance of the feed), and item-level information, including an article title, description and link. A newsreader application can be configured by a user to maintain a set of feeds of interest and refresh that list as needed based on user preferences and syndication information included within the feed. Feeds can also be embedded in portals and collaboration environments, to be shared by groups of users.

In summer, 2009, the Los Alamos National Laboratory Research Library undertook an effort to develop a prototype information aggregator for content related to the H1N1 flu \[[1](https://journal.code4lib.org/articles/#note1)\]. Various news sources were identified and integrated using the Drupal collaboration framework \[[2](https://journal.code4lib.org/articles/#note2)\]. In some cases, there was content that we wanted to integrate with the framework which was not available in a format which could be easily integrated with Drupal. Since our preferred mechanism for integrating content was to use Drupal’s news aggregation capabilities, we developed RSS wrappers for a couple of sources, including an internal source – our own bibliographic metadata catalog, Oppie, which houses over 95 million peer-reviewed science and technology articles, spanning over a century.

As one might expect, there are plenty of programming libraries for generating and working with news feed content. For Java developers, one of these tools is ROME. ROME is described by its developers as a “set of parsers and generators for the various flavors of syndication feeds, as well as converters to convert from one format to another.”\[[3](https://journal.code4lib.org/articles/#note3)\] It supports eight different variants of RSS, as well as two versions of the newer Atom format. ROME enables rapid development of Java applications that can work with, or produce newsfeeds.

The following use of ROME illustrates one of the libraries’ core capabilities – conversion between feed formats. The following code takes the URI of a newsfeed as input, and given a format parameter that indicates the output format, produces a comparable feed which uses a different structure. In this example, the input feed (stored in a file on the filesystem) is in RSS 2.0 format, and the output is in Atom 1.0 format:

```txt
String outputType = “atom_1.0”;
String feedFilename = “samplefeed.xml”;
File feedFromFile = new File(feedFilename);
SyndFeedInput input = new SyndFeedInput();
XmlReader feedReader = new XmlReader(feedFromFile);
SyndFeed feed = input.build(feedReader);
feed.setFeedType(outputType);
SyndFeedOutput newFeed = new SyndFeedOutput();
newFeed.output(feed,new PrintWriter(System.out));
```

Line 5 loads the feed contained in a file called samplefeed.xml, and line 6 builds a SyndFeed object from the contents of the file. The feed object is constructed from an XML representation of the retrieved feed. SyndFeed provides a Java Bean interface for exploring, manipulating, and generating a news feed independent of the output format. Once you’ve loaded a feed into a SyndFeed object, you can request access to specific feed-level metadata (such as the feed title, author, or description) or iterate through the entries in a feed, which are stored in a Java List object called entries, which means that a simple request such as feed.getTitle() is all that’s needed to retrieve a feed title once it has been loaded and parsed. The following code iterates through a set of feed entries and outputs a simple HTML table of the items:

```java
Iterator entryIterator = feed.getEntries().iterator();
while (entryIterator.hasNext()) {
String anEntry = ((SyndEntryImpl) entryIterator.next()).getTitle();
System.out.println(anEntry);
}
```

The utility of a development framework like this became more apparent when we were faced with the task of generating an RSS feed from search results. The Oppie system relies exclusively on the Apache Solr search engine \[[4](https://journal.code4lib.org/articles/#note4)\]. Bibliographic metadata is indexed using Solr and the underlying Lucene libraries, and user queries are handled by Solr as well. So it was a simple matter to convert a search result set to a newsfeed, since the two share common characteristics. We developed Java code to retrieve a results set, parse, and truncate it, then used ROME to generate a newsfeed version of the content. The following request returns 122 results, encoded in Solr’s XML result set format:

```txt
/solr/select/?rows=500&q=((neutrino%20detector)%20and%20(los%20alamos%20national%20laboratory))
```

An excerpt from the result set follows:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<response>
<lst>
<int>0</int>
<int>862</int>
<lst>
<str>((neutrino detector) and (los alamos national laboratory))</str>
<str>500</str>
</lst>
</lst>
<result numFound="122" start="0">
<doc>
<str>Zimmerman, E.D.</str>
<str>Nuclear Physics B, Proceedings Supplements (July 2003) vol.123, p.267-71</str>
<str>BooNE has begun</str>
<str>info:lanl-repo/inspec/7814871</str>
<date>2008-09-02T11:43:03.742Z</date>
</doc>
<doc>
<str>Dalton, C.</str>
<str>Report no. LA-8988-MS, 1981-09-01</str>
<str>Electronics for the LAMPF neutrino experiment`s veto counter system</str>
<str>info:lanl-repo/ecd/6001286</str>
<date>2008-09-11T00:42:58.843Z</date>
</doc>
...
</response>
```

The first `<str>` element, which occurs before the `<result>` element, and has an attribute name with the value q, provides the original query string used to generate this result set.

The next useful piece of information is the `numFound` attribute for the `<result>` element. In our test application, we set a threshold of 25 results, meaning that we only map the first 25 items in the result set to a newsfeed representation. This threshold value later became a user definable parameter for a servlet implementation of the newsfeed wrapper application.

Following that, we iterate through the child `<doc>` elements of the result element, to retrieve information for each entry in the generated newsfeed.

The application uses XPath statements to retrieve the value of various elements in the result set, which was retrieved using the Apache HttpClient library \[[5](https://journal.code4lib.org/articles/#note5)\]. These XPath statements incorporate a replaceable character string which serves as a stand-in for the specific element within the result set we were attempting to retrieve:

```xml
private String solrNumbResultsXpath = 
     "/response/result/@numFound";
private String titlesXpath = 
     "/response/result/doc[_q_]/str[@name='displayTitle']";
private String authorsXpath = 
     "/response/result/doc[_q_]/str[@name='displayName']";
private String descriptionsXpath = 
     "/response/result/doc[_q_]/str[@name='displaySource']";
private String idsXpath = 
     "/response/result/doc[_q_]/str[@name='recID']";
private String datesXpath = 
     "/response/result/doc[_q_]/date";
```

As the application processed the result set, the string “\_q\_” was replaced with an integer value from a counter as we worked our way through the doc element and child elements in the result set, until we hit our threshold value:

```java
for (int count=1; count<=25; count++) {
String xpathIndexPattern = "_q_";
Pattern titleRegExpPat = Pattern.compile(xpathIndexPattern);
Matcher titleMatcher = titleRegExpPat.matcher(titlesXpath);
String actualTitleXpath = titleMatcher.replaceAll(Integer.toString(count));
String title = domProcessing.executeXPath(solrResults, realTitleXpath);&#91;/sourcecode&#93;
The external class domProcessing has a method called executeXPath, which accepts two arguments – a string containing the Solr result set, and an XPath that points at the value of a specific element within that result set, returning the value of that element – in this case, the title of one of the items in the result set, as a string.
 
Finally, we build instances of the entry class and add them to a list of entries, which become part of the SyndFeed object. The last step is trivial and merely requests that the SyndFeed class output a serialization of its contents in one of the available newsfeed formats, e.g. RSS 2.0. The following code excerpts highlight the steps required to generate and output a newsfeed for the result set:
&#91;sourcecode language='java'&#93;
SyndFeedImpl solrResultsFeed = new SyndFeedImpl(); ...
List resultEntries = new ArrayList();
 
solrResultsFeed.setTitle(solrQueryString);
solrResultsFeed.setDescription(solrQueryDescr);
solrResultsFeed.setLink(solrResultsFeedLink);
 
SyndEntryImpl aResult = new SyndEntryImpl();
 
for (int count=1; count<=25; count++) {
...
aResult.setTitle(title);
 
resultEntries.add(aResult);
aResult = new SyndEntryImpl();
}
solrResultsFeed.setEntries(resultEntries);
solrResultsFeed.setFeedType("rss_2.0");
...
SyndFeedOutput solrResultsFeedOutput = new SyndFeedOutput();
solrResultsFeedOutput.output(solrResultsFeed,new
PrintWriter(System.out));&#91;/sourcecode&#93;
When all this code is merged and executed, the results are an RSS 2.0 newsfeed containing up to 25 entries from the original Solr result set. Once we tested the stand-alone tool for mapping Solr results to RSS, we converted it to a parameterized servlet which accepted a query string, threshold value, and a newsfeed format type string as input parameters, enabling any query to be retrieved, trimmed, and mapped to the specified newsfeed format via a URL request, e.g.,
<pre>
/rssWrapper/solr_res_cvt?q=((neutrino%20detector)%20
and%20(los%20alamos%20national%20laboratory))
&amp;numResults=15&amp;feedFormat=atom_0.3</pre>
 
<h2>Part 2: Using Google Translate to generate filtered, translated newsfeeds</h2>
While the H1N1 news aggregator and the Oppie newsfeed wrapper were under development, library staff were tasked with identifying other potential sources of information for the service. By that time, H1N1 had already made its presence felt on several continents, and news outlets in Europe and Asia included articles documenting the latest suspected cases of swine flu, as well as rumors about the progress towards developing a vaccine. Some staff were able to identify articles at non-English news sites which were related to the new flu strain. Once candidate articles were located, Google Translate [<a id="ref6" href="#note6">6</a>] could be used to translate the contents of the article. As suspected, these articles often provided local details about the spread of the disease in their respective source countries, and usually included details that were not reported in English language outlets in the United States. Foreign news sources represented a potentially rich source of additional information about the spread of H1N1, if users could read them. The utility of the Google Translate service led to an exploration of Google's translation API, to enable automatic translation of newsfeeds, and to the development of a tool for selective filtering of this content as well.
 
The ROME API makes it easy to import and transform an existing newsfeed, as illustrated in the previous section. It enables an application to iterate through the individual entries contained in a feed, and to locate the various components of each entry. In this case the entry titles were of particular interest, since we felt that if we could translate these and generate a feed in the preferred language of H1N1 news aggregator users, then it would enable us to identify sources that frequently reported important regional information about the spread of the swine flu. In fact, if our version of the wrapper application that used Google Translate service proved to be effective at handling newsfeed content, then the next step would be to filter the feeds so that only the entries of interest would be displayed to users. The resulting application did turn out to have some utility, but we discovered some unexpected challenges along the way.
 
Google Translate is based on a statistical machine translation model. Statistical machine translation relies upon the existence of a sort of Rosetta stone of matching corpora in different languages. Google relies upon a collection of United Nations documents, which have been meticulously translated into a number of the world's languages. Exact details are not published for Google Translate, but in general terms, statistical machine translation relies upon matching passages and co-occurrences of words between respective corpora. Despite the fact that such a method results in no real comprehension of the content by the translation software, both anecdotal reports from Google, and industry accepted measures for machine translation (e.g. IBM Bleu [<a id="ref7" href="#note7">7</a>]) have shown that statistical machine translations can yield excellent, readily comprehensible results for human users when translating between supported languages.
 
Indeed we often found that Google Translate, when used manually via the translate.google.com web page, provided an adequate translation of newsfeed titles. So this led us to explore Google's AJAX Language API, which includes a REST-based Web service that can be used to translate strings of text between languages [<a id="ref8" href="#note8">8</a>]. This toolkit uses the same machine translation service used by Google Translate. It is specifically designed to support Javascript-based machine translation of Web content, but it includes services which can be called by applications written in other languages, such as Java.
 
The prototype feed translation wrapper has much in common with the Oppie Solr feed utility. It uses the Apache HttpClient library to retrieve the contents of a specified news feed, accepts the URL of a feed as a parameter, and uses ROME to generate the output feed in a format specified using another request parameter. What sets it apart is that it makes external calls to the Google Language API to translate each feed entry title and description. We also decided to implement a simple string filter that would be used to determine whether a particular item ought to be included in the resulting feed, so that a custom feed containing only entries that match a particular word or phrase would be generated. So the translation wrapper first requests a translation of the filter term, and then requests translations of the entries, makes a comparison, and adds translated title and descriptions for matching entries to the entry List object which becomes part of the generated feed. The following is an example request to the feed translation service:
<pre>/rssWrapper/rssctr?feed=http://www.lemonde.fr/rss/sequence/
0,2-3244,1-0,0.xml&amp;amp;amp;amp;lang=fr&amp;amp;amp;amp;
q=flu&amp;amp;amp;amp;qtrans=y&amp;amp;amp;amp;format=rss_1.0</pre>
 
The feed parameter is the URL of the target input feed. The lang parameter is the identifier for the language of the input feed. The q parameter is the filter term that will be used to determine whether a particular entry should be included in the translated feed. The qtrans parameter was added after some initial experiments showed that the translation API did not always yield good results for filter term translation, at least in the case of queries associated with swine flu. The phrase “swine flu” or even the word “flu” is not always translated in such a way that it matches the actual word or phrase used by target news sources. For example, in Japanese, flu is translated to the Katakana-borrowed word “infurenza” by Google's software, and yet the abbreviated Katakana word “infuru” was almost exclusively used in the news sources we tested. In other cases, Google's translation for the filter term yielded decent results. So we modified our tool to optionally allow a knowledgeable user to include a translated filter term, and turn off filter term translation via the qtrans parameter flag, enabling optimal per-feed configurability. Finally, our tool also allows for the target feed to be of a different format than the source feed.
 
The following example illustrates how one entry in a French news feed was identified, matched against the filter term, and translated using the Google API:
 
Original feed entry title:
Vaccins anti-grippe A : l'Etat débourserait 48 millions d'euros
 
Original feed entry description:
Les négociations engagées par le gouvernement avec les trois laboratoires chargés initialement de fournir à la France 94 millions de doses de vaccin anti-grippe A sont en passe d'être conclues.clues.
 
Title translation request:
<pre>http://ajax.googleapis.com/ajax/services/language/translate?
v=1.0&amp;amp;amp;amp;langpair=fr%7Cen&amp;amp;amp;amp
;q=Vaccins+anti-grippe+A+%3A+l%27Etat+%C3%A9bourserait+48+millions+d%27euros</pre>
 
Translation response:
<pre>
{"responseData": 
{"translatedText":"A flu vaccine: the state would pay 48 million euros"}, 
"responseDetails": null, "responseStatus": 200}</pre>
 
Description translation request:
<pre>http://ajax.googleapis.com/ajax/services/language/translate?
v=1.0&amp;amp;amp;amp;amp;langpair=
fr%7Cen&amp;amp;amp;amp;amp;q=
Les+n%C3%A9gociations+engag%C3%A9es+par
+le+gouvernement+avec+les+trois+laboratoires
+charg%C3%A9s+initialement+de+fournir+%C3%A0
+la+France+94+millions+de+doses+de+vaccin+anti-grippe
+A+sont++passe+d%26%2339%3B%C3%AAtre+conclues.</pre>
 
Translation response:
<pre>
{&quot;responseData&quot;: 
{&quot;translatedText&quot;:&quot;Negotiations with the 
government by the three laboratories initially provide France 
with 94 million doses of flu vaccine are going to be concluded.&quot;},
&quot;responseDetails&quot;: null, &quot;responseStatus&quot;: 200}</pre>
 
As you can see, generating an appropriate request to the Google AJAX Language API is relatively straightforward. Full capabilities of the service are documented online [&lt;a id=&quot;ref8&quot; href=&quot;#note8&quot;&gt;8&lt;/a&gt;]. There are only three parameters for a basic translation request to their REST-based translate service: the version parameter (v), the language pair parameter (langpair) which uses two character language codes separated by a URL encoded vertical bar character (%7C), and a query parameter (q), which is assigned the URL encoded value of the string to be translated. Google Translate returns its response using the JSON format, which is widely used in Javascript applications, but trivial to parse using Java string manipulation methods or Java JSON parsing libraries. The only additional required code is that which determines whether or not an entry title or description matches the filter term, which we implemented using Java's indexOf method:
[sourcecode language="java"]
if ((origTitle.indexOf(translatedQueryTerm)>-1) ||
 (origDescription.indexOf(translatedQueryTerm)>-1)) {
```

The following channel content is an example of the type of news feed that would be generated by our translation service:

```xml
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns="http://purl.org/rss/1.0/"
xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" 
xmlns:dc="http://purl.org/dc/elements/1.1/">
<channel rdf:about="http%3A%2F%2Fwww.lemonde.fr%2Frss%2Fsequence%2F0%2C2-3244%2C1-0%2C0.xml">
<title>Planète - Le Monde.fr (Planet - The Monde.fr)</title>
<link><!&#91;CDATA&#91;http://www.lemonde.fr/rss/sequence/0,2-3244,1-0,0.xml&#93;&#93;></link>
<description><!&#91;CDATA&#91;translation of: "http://www.lemonde.fr/rss/sequence/0,2-3244,1-0,0.xml"&#93;&#93;></description>
<copyright>Research Library, Los Alamos National Laboratory</copyright>
<sy:updatePeriod>weekly</sy:updatePeriod>
<sy:updateFrequency>1</sy:updateFrequency>
<sy:updateBase>2010-04-23 13:22:40</sy:updateBase>
<items>
<rdf:Seq>
<rdf:li resource="http://www.lemonde.fr/planete/article/2010/03/23/vaccins-anti-grippe-a-l-etat-debourserait-48-millions-d-euros_1323036_3244.html#xtor=RSS-3244"/>
</rdf:Seq>
</items>
</channel>
<item rdf:about="http://www.lemonde.fr/planete/article/2010/03/23/vaccins-anti-grippe-a-l-etat-debourserait-48-millions-d-euros_1323036_3244.html#xtor=RSS-3244">
<title><!&#91;CDATA&#91;A flu vaccine: the state would pay 48 million euros (French)&#93;&#93;></title>
<link><!&#91;CDATA&#91;http://www.lemonde.fr/planete/article/2010/03/23/vaccins-anti-grippe-a-l-etat-debourserait-48-millions-d-euros_1323036_3244.html#xtor=RSS-3244&#93;&#93;></link>
<description><!&#91;CDATA&#91;Negotiations with the government by the three laboratories initially provide France with 94 million doses of flu vaccine are going to be concluded.&#93;&#93;></description>
<dc:date>2010-04-23 13:22:40</dc:date>
</item>
 
</rdf:RDF>
```

## Conclusion

In an increasingly multilingual world where comprehending information in a language you do not speak may be a matter of life or death, machine translation services can be an essential tool in maintaining comprehensive awareness of news provided by outlets around the world. Our prototype feed translation application enables us to generate custom filtered newsfeeds programmatically, with a modest amount of effort on the part of information professionals required to identify appropriate news sources and tune the service parameters to ensure that news entries are properly identified and mapped over to the generated feed. Machine translation services are just starting to mature and since we developed this tool, Google has incorporated their machine translation services into their Chrome browser \[[9](https://journal.code4lib.org/articles/#note9)\]. Users can now set a preferred language for browsing, and have content transparently and automatically translated as they surf the Web with Chrome. Our solution offers a similar level of automation and transparency to consumers of newsfeeds, and proved to be very straightforward to implement using the ROME java newsfeed API and Google’s AJAX language API. We believe that tools like this fill an essential role in support of critical information awareness.

## About the Authors

James Powell and Mark Martinez are members of the Knowledge Systems and Human Factors Team (http://www.lanl.gov/ks-hci/) at the Research Library at Los Alamos National Laboratory (LANL), Los Alamos, New Mexico, US. Linn Collins is the Team Leader. The team works with scientists and engineers at LANL to leverage advances in information science and technology in support of scientific research and global security.

## Notes

\[[1](https://journal.code4lib.org/articles/#ref1)\] Linn Collins, Mark Martinez, James Powell, Jorge Roman, and Michelle Garcia. Semantic Components of E:SOS: Emergency Situation Overview and Synthesis. Poster presented at Department of Homeland Security Science and Technology Summit, South Central Region, February 9, 2010.
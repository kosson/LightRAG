---
title: "Recount: Revisiting the 42nd Canadian Federal Election to Evaluate the Efficacy of Retroactive Tweet Collection"
source: "https://journal.code4lib.org/articles/12676"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-07-18
created: 2025-01-10
description: "In this paper, we report the development and testing of a methodology for collecting tweets from periods beyond the Twitter API’s seven-to-nine day limitation. To accomplish this, we used Twitter’s advanced search feature to search for tweets from past the seven to nine day limit, and then used JavaScript to automatically scan the resulting webpage [...]"
tags:
  - "clippings"
---
# Recount: Revisiting the 42nd Canadian Federal Election to Evaluate the Efficacy of Retroactive Tweet Collection
Anthony T. Pinter, Ben Goldman

In this paper, we report the development and testing of a methodology for collecting tweets from periods beyond the Twitter API’s seven-to-nine day limitation. To accomplish this, we used Twitter’s advanced search feature to search for tweets from past the seven to nine day limit, and then used JavaScript to automatically scan the resulting webpage for tweet IDs. These IDs were then rehydrated (tweet metadata retrieved) using twarc. To examine the efficacy of this method for retrospective collection, we revisited the case study of the 42nd Canadian Federal Election. Using comparisons between the two datasets, we found that our methodology does not produce as robust results as real-time streaming, but that it might be useful as a starting point for researchers or collectors. We close by discussing the implications of these findings.

## Introduction

Twitter is a social media platform launched in March 2006 that allows users to post messages in 140 characters or less, and share hyperlinks, images, and video. The potential historical value of content posted to Twitter was recognized in 2010 when the Library of Congress announced an agreement with Twitter to archive and make accessible every tweet. Since that time, however, the Library has been unable to meet its pledge of making all tweets available. In recent years, researchers and archivists have begun developing new strategies for curating topical datasets of tweets around culturally significant events as they happen. Using Twitter’s API, such researchers can harvest tweets going back seven to nine days.

Datasets of this variety are composed of thousands of ordinary users, offering researchers access to representative samples of public discourse by and between individuals during these significant events. However, the relative newness of tools like twarc and Social Feed Manager means that researchers and librarians have only been able to develop such collections in the past five years, leaving a gap between when Twitter was created (March 2006) and when collection tools became available.

This gap presents collectors with a two-fold problem – we know that people were tweeting about events (and frequently, tweeting a lot), but conventional methods use Twitter’s API for collecting, which limit collections to the past seven to nine days. If a collection is started while the event is not in this near past, or if the subject of interest lies outside of the near past, there is not a readily available, open-source method for accessing these tweets. As well, there can be data loss over time as Twitter users delete tweets, whole accounts, or alter the privacy settings on their accounts.

At Penn State University Libraries, these concerns were brought to the forefront when we considered the feasibility of retrospectively capturing tweets related to the Jerry Sandusky child abuse scandal which dominated the national U.S. news in late 2011. From the initial public revelation of the scandal in November 2011 to the death of Penn State’s football coach, Joe Paterno, in January 2012, the Twitter reaction was likely considerable, and we wondered how comprehensively we would be able to capture the dialogue found on this platform years after the tweets were first posted.

In this paper, we offer the results of an investigation to determine how much Twitter data can be retroactively captured using a potential workaround. By using Twitter’s advanced search feature and in-browser JavaScript, we found it was possible to collect large numbers of Tweets from beyond the seven-to-nine day limit imposed by Twitter’s API. We outline our methodology and then test its efficacy by collecting tweets from the 42<sup>nd</sup> Canadian Federal Election and comparing them to a dataset of tweets that was generated in real-time during that election. We close by discussing its limitations and the implications that these limitations have on our ability to collect from Twitter’s far past.

## Background

In early 2016, Nick Ruest and Ian Milligan published “An Open-Source Strategy for Documenting Events: The Case Study of the 42<sup>nd</sup> Canadian Federal Election on Twitter”, documenting a strategy for collecting tweets about a specific event via hashtag streams and searches. The researchers turned to open-source software, [twarc](https://github.com/edsu/twarc), developed by Ed Summers, to conduct their streams and searches. Over the course of 102 days, the researchers collected 3,918,932 tweets that used the hashtag, #elxn42. #elxn42 is a reference to the 42<sup>nd</sup> Canadian Federal Election, which occurred in late 2015 and resulted in Justin Trudeau being elected Prime Minister of Canada.

Using this generated dataset, Ruest and Milligan demonstrated various analytic tools that were included with twarc, supported by a separate tool called twarc-report, or that were available via command-line tools. This included outputs such as timelines, user-level analytics, hashtag-level analytics, and js visualizations of the data.

Ruest and Milligan’s published dataset offers a concrete benchmark against which we can test the effectiveness of a method for collecting tweets that are weeks, months, or even years old. Determining the efficacy of this methodology is important, because as Ruest and Milligan note, “Once an event has happened, if a small window of time has passed – 7 to 9 days – the tweets become largely inaccessible on a large scale without considerable monetary resources.” Offering a work-around to this time limitation will allow broad research efforts to be taken to examine Twitter during significant events that fall outside of the near (7 to 9 day) past.

## Methodology

Our methodology for collecting tweets beyond the seven to nine day range was built upon the methods employed by the Trump Twitter Archive, which aimed to collect, organize, and make accessible all of the tweets sent by Donald J. Trump from 2009 to present. The major change we made was to alter the amount of information collected, as we only needed the tweet IDs in order to hydrate using twarc. Following, we describe the process and highlight the changes we made to the original collection strategy.

The Trump Twitter Archive was built using Twitter’s Advanced Search feature to get the date codes in the URL, and then manually changing the dates searched in the URL. For example, (author emphasis on the relevant portions of the URL):

> https://twitter.com/search?q=%23**trump**%20since%3A**2016-12-19**%20until%3A**2016-12-21**&src=typd

The first highlighted portion is the search term. In our instance, we used the search term “#elxn42” to capture tweets containing that hashtag. The second and third highlighted portions set the beginning and end dates of the search, respectively.

Thus, our search URL for the hashtag #elxn42 from September 2015 to November 2015 becomes:

> https://twitter.com/search?q=%23**#elxn42**%20since%3A**2015-09-05**%20until%3A**2015-11-05**&src=typd

However, in our case, the size of the dataset prevents us from using just one URL that spans the entire date range. To get around this issue, we broke the original date range into 102 individual days, pulling one search from each day of the original timeline. Following the Trump Archive methodology, for each search we used the developer’s console feature to run an auto-scrolling JavaScript code, which went through all of the results of each hashtag search:

| 1 | `setInterval(``function``(){ scrollTo(0, document.body.scrollHeight) }, 2500)` |
| --- | --- |

The developer’s console feature can be found under the “Develop” tab on most browsers. This console allows you to enter JavaScript code to run on the webpage that is currently open. In our case, we used the code described above to autoscroll to the bottom of each page, and used the subsequently described code to collect the tweet IDs for all of the tweets on each page. In Figure 1, we show an example of the developer’s console.

![](https://journal.code4lib.org/media/issue37/pinter/Pinter-01.png)  
**Figure 1.** The Developer’s Console (in Safari)

As previously stated, our methodology differed from the Trump Archive’s process. The Trump Archive used JavaScript code that collected the date, ID, text, retweet status, favorite status, and URL of each tweet, and copied it to the computer’s clipboard. We quickly realized that much of this data was useless for our methodology, because we were going to rehydrate the tweets to collect the full json output associated with each tweet. Thus, we changed the code to only collect the IDs of the tweets, the piece of information needed for rehydration. The original JavaScript to accomplish this task was:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `var` `allTweets = [];`  `var` `tweetElements = document.querySelectorAll(``'li.stream-item'``);`  `for` `(``var` `i = 0; i < tweetElements.length; i++) {`  `var` `el = tweetElements[i];`  `var` `text = el.querySelector(``'.tweet-text'``).textContent;`  `allTweets.push({`  `id: el.getAttribute(``'data-item-id'``),`  `timestamp: el.querySelector(``'a.tweet-timestamp'``).getAttribute(``'data-original-title'``),`  `text: text,`  `link: ``'[https://twitter.com](https://twitter.com/)'` `+ el.querySelector(``'div.tweet'``).getAttribute(``'data-permalink-path'``),`  `is_retweet: el.querySelector(``'.js-retweet-text'``) ? ``true` `: ``false``,`  `retweets: el.querySelector(``'.js-actionRetweet .ProfileTweet-actionCountForPresentation'``).textContent,`  `favorites: el.querySelector(``'.js-actionFavorite .ProfileTweet-actionCountForPresentation'``).textContent,`  `replies: el.querySelector(``'.js-actionReply .ProfileTweet-actionCountForPresentation'``).textContent,`  `});`  `}`  `copy(allTweets);` |
| --- | --- |

While we used the following code:

| 1  2  3  4  5  6  7  8  9  10 | `var allTweets = [];`  `var tweetElements = document.querySelectorAll('li.stream-item');`  `for (var i = 0; i < tweetElements.length; i++) {`  `var el = tweetElements[i];`  `var text = el.querySelector('.tweet-text').textContent;`  `allTweets.push({`  `id: el.getAttribute('data-item-id')`  `});`  `}`  `copy(allTweets);` |
| --- | --- |

Similar to the autoscroll script, this code was entered in the developer’s pane of an Internet browser (described above). After running this code in the console, the tweet IDs are copied to our machine’s clipboard. We pasted this collected data into a text-file and rehydrated using twarc. Then, the files were concatenated, deduplicated, and unshortened, similar to Ruest and Milligan’s approach.

We would like to note that this is an implementation that anyone can operationalize, regardless of programming ability. To do large scale searches such as ours, it can quickly become tedious. There is a script that automates this process but requires some programming knowledge to properly implement. We chose to present the low barrier version of the methodology to appeal to wider audiences and mention this more efficient method for those possessing the technical skills to explore.

## Results & Discussion

In this section, we turn to the same analytical approach that Ruest and Milligan utilized to examine our dataset and compare it to the original dataset. This included comparing the results of user counts, hashtag counts, and URL counts between our “new” dataset and Ruest and Milligan’s original dataset. By utilizing the same analytical approach, we were able to determine the efficacy and usefulness of our retroactive collection methodology.

We excluded the other metrics originally used by Ruest and Milligan (namely retweets, geographic information, and images) because we felt they did not offer as great a means of comparison as username, hashtag, and URL. A larger dataset would by default include a larger number of retweets, so this number would be disproportionately skewed. The geographic information and images were excluded because not every tweet contains them, making it hard to compare between two datasets.

### Number of Tweets Collected

Using our methodology, we collected 250,781 tweets. This represented approximately 6.4% of the original dataset collected by Ruest and Milligan (3,918,932 tweets), who themselves acknowledged the inherent limitations of using Twitter’s API to collect data instead of commercial platforms. At face, this low rate of overlap indicates that this methodology is not robust enough to stand on its own, a conclusion that was reinforced when we attempted to rehydrate the #elxn42 dataset from the publicly accessible list of tweet ids, which resulted in a collection of 64.5% of the original tweets from Ruest and Milligan’s dataset. The loss of nearly 1.5 million tweets from the original data collected is likely due to tweets or accounts being deleted, or users changing their privacy settings. But the loss of an additional two million-plus tweets suggested that our methodology was missing tweets that remained accessible online.

### Users

A deeper examination of the data somewhat clarified the gaps in our methodology. The original researchers identified 318,176 unique users in their dataset, for an average of approximately twelve tweets per account. In comparison, we collected 28,157 unique users with an average of approximately nine tweets per user. This represented 8.8% of the users found in the original set. Surprisingly, the top tweeters from the two datasets widely differed, with only one account shared between the two lists. This account, DavidMorrison17, topped the list in the original set and was second on our list, indicating some overlap between the two datasets.

**Tables 1 and 2.** Original top ten users (left) versus new top ten users (right)

|  | Tweets | Username |
| --- | --- | --- |
| 1. | 21,423 | DavidMorrison17 |
| 2. | 15,527 | P\_Wog |
| 3. | 10,812 | chuddles11 |
| 4. | 10,051 | 444\_nal4b |
| 5. | 8,871 | JoanneCangal |
| 6. | 8,346 | littleshasta |
| 7. | 8,316 | MadeInCanada56 |
| 8. | 8,114 | LucMatte9 |
| 9. | 7,360 | Frazzling |
| 10. | 7,019 | StopHarperToday |

|  | Tweets | Username |
| --- | --- | --- |
| 1. | 2,448 | Bergg69 |
| 2. | 2,001 | DavidMorrison17 |
| 3. | 1,704 | MuskokaMoneybag |
| 4. | 1,490 | billhillier |
| 5. | 1,344 | rabbelca |
| 6. | 1,252 | deepgreendesign |
| 7. | 1,194 | WorldWideHerald |
| 8. | 1,036 | AlanaBowker |
| 9. | 1,028 | TomassoRico |
| 10. | 1,019 | cmusician |

It is promising to see a similar (12 vs. 9) tweet/user breakdown and a shared account finishing high on both lists (DavidMorrison17), but the lack of further overlap merits further investigation. It was notable that P\_Wog does not appear in our top 10, as that account remains public and active, reinforcing the idea that deletions and privacy settings alone would not account for the considerable differences in tweets collected.

### Hashtags

There was a large amount of overlap between the hashtags present in the two datasets, both in the number of unique hashtags found and the top ten hashtags in each data set. The original dataset contained 70,112 unique hashtags, while our dataset had 21,411 unique hashtags. This meant our set had 30.5% of the hashtags found in the original set, a percentage much higher than the percentage of overlap we found in our unique users. In terms of comparing the top ten hashtags from each set, aside from the top hashtag (#elxn42, as expected), there were six other shared hashtags, including #2 – #6.

The higher rate of comparative overlap between the number of unique hashtags and the top ten hashtags suggests this methodology could be useful in examining the hashtags that were being used, and using this information in tandem with other methodologies to paint a fuller picture of the social media activity at the time.

**Tables 3 and 4.** Original top ten hashtags (left) versus new top ten hashtags (right)

|  | Tweets | Hashtag |
| --- | --- | --- |
| 1. | 3,685,885 | #elxn42 |
| 2. | 1,390,783 | #cdnpoli |
| 3. | 164,339 | #ndp |
| 4. | 139,070 | #cpc |
| 5. | 129,082 | #lpc |
| 6. | 89,303 | #elxn2015 |
| 7. | 68,387 | #polcan |
| 8. | 64,718 | #realchange |
| 9. | 62,282 | #polqc |
| 10. | 61,700 | #globedebate |

|  | Tweets | Hashtag |
| --- | --- | --- |
| 1. | 250,781 | #elxn42 |
| 2. | 108,275 | #cdnpoli |
| 3. | 11,649 | #cpc |
| 4. | 11,044 | #ndp |
| 5. | 9,833 | #lpc |
| 6. | 7,255 | #elxn2015 |
| 7. | 4,277 | #harper |
| 8. | 3,547 | #onpoli |
| 9. | 3,535 | #canada |
| 10. | 3,446 | #realchange |

### URLs

In the original dataset, there were 1,988,693 URLs tweeted, representing 50.75% of the total collected tweets. In our dataset, we found 140,839 tweeted URLs, or 55.34% of the total tweets. Comparing unique URLs, the original dataset contained 334,841 unique URLS, while our set contained 100,789 unique URLs or 30.4% of the original set.  In Tables 5 & 6, we compare the top ten most-tweeted URLs from the original set versus our “new” set.

**Tables 5 and 6.** Original top ten URLs (top) versus new top ten URLs (bottom)

|  | Tweets | URL |
| --- | --- | --- |
| 1. | 11956 | http://www.cbc.ca/includes/federalelection/dashboard/index.html |
| 2. | 9712 | http://www.conservative.ca/ |
| 3. | 4562 | http://www.votetogether.ca/ |
| 4. | 3983 | http://www.cbc.ca/news/politics/macleans-debate-leaders-2015-1.3182000 |
| 5. | 3926 | http://www.elections.ca/Scripts/vis/FindED?L=e&QID=-1&PAGEID=20 |
| 6. | 3104 | http://www.elections.ca/home.aspx |
| 7. | 2812 | http://www.theglobeandmail.com/try-it-now/?articleId=26875323 |
| 8. | 2808 | https://www.facebook.com/abu.nawaf.581/posts/10206977713713332?pnref=stor |
| 9. | 2757 | http://dont-be-a-fucking-idiot.ca/ |
| 10. | 2707 | https://www.mypayingads.com/index.php?ref=51826 |

|  | Tweets | URL |
| --- | --- | --- |
| 1. | 365 | http://Looniepolitics.com |
| 2. | 311 | http://www.votetogether.ca |
| 3. | 213 | http://votecompass.cbc.ca |
| 4. | 185 | http://www.macleans.ca/news/canada/vanishing-canada-why-were-all-losers-in-ottawas-war-on-data/ |
| 5. | 175 | http://www.cpac.ca |
| 6. | 160 | http://dont-be-a-fucking-idiot.ca/ |
| 7. | 152 | http://looniepolitics.com/election\_2015/ |
| 8. | 149 | http://election.davidsuzuki.org |
| 9. | 119 | http://bit.ly/HealthyCandidates |
| 10. | 113 | http://www.votetogether.ca/ |

While there was a high percentage of shared URLs between the two datasets, there was little overlap between the two top ten lists. This discrepancy likely indicates that the URL metrics from datasets collected by our methodology should not be trusted on their own, but might be useful in conjunction with other sources.

The opaqueness of Twitter’s documentation on search and advanced search impacted our ability to fully understand the limitations of this methodology for retroactive collection, but it seems to suggest that Twitter selectively filters search results based on a number of factors, including the existence of “duplicate or near duplicate content,” hashtag spamming, automated replies and bot-generated tweets, and even the use of 3rd party applications. It is also worth noting over the course of our experimentation, Twitter’s advanced search was updated to remove options for filtering by factors such as positive and negative sentiment, and the inclusion of retweets. Finally, Twitter does acknowledge that search result algorithms display tweets in the advanced search feature in a specific manner, such as due to the popularity of the account or the number of views that specific tweet received, which would then skew datasets collected in this manner.

## Conclusion

In conclusion, we offer two principal takeaways from testing the efficacy of this work.

First, this methodology might be useful to researchers or curators looking to identify research questions or build collections from Twitter’s far past. While it is not nearly as powerful or comprehensive as collecting tweets in real-time or from the near past, it can still reveal trends in hashtag usage and link popularity, and it is a better alternative than not having access to data at all. Additionally, datasets built from this methodology might be augmented with additional collection tools that capture other period information from online sources (news crawls, the WayBack Machine, etc.). The process might also be augmented in future work to be applied to other social media formats, such as Facebook or Tumblr, to collect posts and comments that occurred in the far past. This, in turn, offers several avenues for future work exploring how we might retroactively collect from these other social media platforms to paint a better picture of the discourse surrounding significant events from the far past. We believe this retroactive collection methodology, although imperfect, might offer a good start point for collectors and researchers to delve into past events and how the Internet discussed them.

Second, the failings of this methodology highlight the importance of collecting in real-time around events. While we were able to build a sizeable collection of tweets from over 18 months ago, it is clear that we collected a drop in the bucket compared to what was collected in real-time during the event. Thus, the results of this work highlight the importance of active collecting around societal events, and suggest that a best practice for archivists and curators is to collect in real-time as much as possible. While this will generate large amounts of data, this is preferable to losing tweets, and the meaning they convey, to the far past limitations of Twitter’s API. In their original article, Ruest and Milligan concluded by stating:

“In an era where web archiving and Twitter collection can be seen as expensive luxuries, this article shows how, for a relatively small investment of computing power, bandwidth, and storage, people can create and analyze their own Twitter archives.”

While web archiving and Twitter collection might be seen as an expensive luxury, our explorations into retroactive collection show that the expense is well worth the result – preserving a better picture of our societal reactions to events.

## References

Binkley, Peter. twarc-report README.md. https://github.com/pbinkley/twarc-report/blob/master/README.md, last accessed 11 May 2017.

Brown, Brendan. Trump Twitter Archive. http://www.trumptwitterarchive.com/, last accessed 11 May 2017.

Brown, Brendan. twitter\_scraping. [https://github.com/bpb27/twitter\_scraping/blob/master/README.md](https://github.com/bpb27/twitter_scraping/blob/master/README.md), last accessed 11 May 2017.

Ruest, Nick, 2015, “#elxn42 tweets (42nd Canadian Federal Election)”, [hdl:10864/11270](http://hdl.handle.net/10864/11270), Scholars Portal Dataverse, V4

Ruest, N., & Milligan, I. (2016). An Open-Source Strategy for Documenting Events: The Case Study of the 42nd Canadian Federal Election on Twitter. The Code4Lib Journal, (32). http://journal.code4lib.org/articles/11358, last accessed 11 May 2017

The Search API – Twitter Developers. https://dev.twitter.com/rest/public/search, last accessed 11 May 2017

Summers, Ed. twarc README.md. https://github.com/DocNow/twarc/blob/master/README.md, last accessed 11 May 2017.

Twitter search rules and restrictions. [https://support.twitter.com/articles/42646](https://support.twitter.com/articles/42646), last accessed 11 May 2017

Zimmer, Michael. “The Twitter Archive at the Library of Congress: Challenges for information practice and information policy.” First Monday 20.7 (2015).

Anthony T. Pinter is a PhD candidate in Information Science at the University of Colorado Boulder, where he studies identity in online spaces. He previously completed his B.S. and M.S. in Information Sciences and Technology at the Pennsylvania State University.

Ben Goldman is the Kalin Librarian for Technological Innovations at Penn State University Libraries, where he oversees web archiving efforts.
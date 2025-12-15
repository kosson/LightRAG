---
title: "Automatic Aggregation of Faculty Publications from Personal Web Pages"
source: "https://journal.code4lib.org/articles/3765"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-09-22
created: 2025-01-10
description: "Many researchers make their publications available on personal web pages. In this paper, we propose a simple method for the automatic aggregation of these documents. We search faculty web pages for archived publications and present their full text links together with the author's name and short content excerpts on a comprehensive web page. The excerpts [...]"
tags:
  - "clippings"
---
# Automatic Aggregation of Faculty Publications from Personal Web Pages
Najko Jahn, Mathias Lösch, Wolfram Horstmann

Many researchers make their publications available on personal web pages. In this paper, we propose a simple method for the automatic aggregation of these documents. We search faculty web pages for archived publications and present their full text links together with the author’s name and short content excerpts on a comprehensive web page. The excerpts are generated simply by querying a standard web search engine.

## Introduction

In most academic fields, publication lists on personal web pages are a common practice to promote lasting research visibility. These lists not only function as individual bibliographies, but also as digital archives. Often researchers complement these bibliographic references with the corresponding pre- or postprints in order to allow peers easy access.

From a librarian perspective, such personal publication lists provide a rich source of bibliographic data and full texts which would be worthwhile to monitor and grab. In particular, these publication lists might be a good starting point for populating the local institutional repository. If the repository manager could track the deposited documents on the web pages, he could simply ask the researcher to upload these documents to the repository as well.

Given the large amount of highly distributed personal web pages usually hosted by an academic institution, the question arises of how to keep track of the research output available if no efficient central service is in use for publishing publication lists as part of the personal web page. In this paper, we propose a simple method for the automatic aggregation of the publications on personal web pages. We search faculty web pages for freely available publications and present their URLs together with the author’s name on a comprehensive list. Moreover, each list entry is being enhanced by a short document excerpt automatically generated using the Bing search engine. Based on a subsequent text classification, we furthermore distinguish between scholarly documents and other material such as CVs or courseware.

## Background

Before proposing the method, let us reconsider our motivation. In preparation of the development and implementation of a publication management system at Bielefeld University, a middle-sized and research-intensive university in the State of North Rhine-Westphalia (Germany), we wanted to provide evidence that scholars maintain personal publication lists on the web. Moreover, we were interested in whether the documents are actually downloadable from these web pages.

Our challenge is not a new one, but has been approached theoretically and practically by others before. Since the advent of the web, scholars from various fields have been discussing scholarly communication patterns on the web and developed methods of how to track and measure these.

PhilPapers.org, \[[1](https://journal.code4lib.org/articles/#note1)\] an online directory for philosophical publications, shows how fruitful automatic monitoring of personal web pages can actually be. Based on crawlers and metadata extraction utilities as part of the open source platform *Disciplinary Virtual Research Environment* (DIVRE) \[[2](https://journal.code4lib.org/articles/#note2)\], PhilPapers.org collects and indexes web content coming from the field of philosophy. One of the services PhilPapers.org provides, once a researcher is registered with the system, is automatically harvesting the researcher’s personal web site for new documents on a regular basis. After indexing the titles, authors, and abstracts of the new documents, the metadata are presented as part of the online bibliography PhilPapers.org provides.

## Getting Scholarly Publications in Three Steps

With this example in mind, we similarly look for a simple and easy method to automatically aggregate online publications of Bielefeld University faculty.

### **Collecting Document Links**

In the context of the above-mentioned project concerned with publication management, we needed to gain a closer insight into the habit of maintaining personal publication lists at Bielefeld University. However, the content of personal websites is not in central control at large universities \[[3](https://journal.code4lib.org/articles/#note3)\]. Therefore we asked two student assistants to manually collect information on the lists. On the basis of the official directory of staff and departments, they manually searched for the publication lists from the researchers. The search was limited to people holding at least a doctoral degree, and conducted using web search engines such as Google. During a period of two months, they identified publication lists from 750 out of 1214 researchers (see Figure 1), and compiled the information in a table associating the names and departments of the researchers with the URLs of their lists.

[![Figure 1: Detected Publication Lists at Bielefeld University](https://journal.code4lib.org/media/issue11/jahn/Figure_1.png "Figure 1: Detected Publication Lists at Bielefeld University")](https://journal.code4lib.org/media/issue11/jahn/Figure_1.png)

**Figure 1.** Detected Publication Lists at Bielefeld University

Apart from the rather theoretical interest in the data, we considered to re-use part of it for automatically collecting information on the publications available through those web pages.

To this end, we process the table using a Python script that downloads the HTML pages behind the URLs, and extracts all hyperlinks pointing to PDF documents, which we assume to be scholarly publications. This is achieved simply by using regular expressions.

In total, we extract 3365 PDF links that give us a first idea about the coverage of alleged scholarly publications on personal lists. However, two technical problems occur: One is that some researchers link to sub-pages containing additional information and the full text document. The other is that the extraction of document links coming from script-generated web pages often fails.

### **Searching Bing**

Next, we query a web search engine to generate a short document excerpt. For this task we could use virtually any search engine that provides an API. However, we pretested a small subset of ten randomly selected entries of our table to determine the best performing engine with regards to the number of found documents and the quality of the results (see below for encountered quality issues). We take into account Google, Yahoo!, and Bing. Since Bing performed best in this pretest, we also use it in the final program.

We query the Bing search engine directly from our program via its public web API \[[4](https://journal.code4lib.org/articles/#note4)\]. As query strings we simply use the document links. The Bing API returns a data structure containing the same information that would be presented on a regular result list. A result entry, apart from the hyperlink to the original document, consists of a *title* (usually the document title) and a *description* (a short excerpt of the indexed document). For each URL we save the title and the description of the top-ranked result entry, if Bing has indexed the PDF document behind the link. Finally, we combine our initial table with the Bing data, and display it all together on an HTML page that makes up our comprehensive publication list.

Figures 2 through 5 show excerpts of this list. Apart from the titles, the excerpts ideally provide additional information, such as the bibliographic reference, the document type and the beginning of the underlying paper (see Figure 2).

[![Figure 2: An almost ideal example of how the approach is supposed to work. The title has been correctly identified and the Bing excerpt provides useful additional information.](https://journal.code4lib.org/media/issue11/jahn/Figure_2.png "Figure 2")](https://journal.code4lib.org/media/issue11/jahn/Figure_2.png)

**Figure 2.** An almost ideal example of how the approach is supposed to work. The title has been correctly identified and the Bing excerpt provides useful additional information.

However, some problems occur. For example, the search engine apparently has not indexed all the documents, as for some entries there is no title or excerpt (Figure 3). Closer examination of these cases reveal that most of them come from script-generated web pages.

[![Figure 3: A list entry lacking title and excerpt. This may be because the document has not been indexed by Bing.](https://journal.code4lib.org/media/issue11/jahn/Figure_3.png "Figure 3")](https://journal.code4lib.org/media/issue11/jahn/Figure_3.png)

**Figure 3.** A list entry lacking title and excerpt. This may be because the document has not been indexed by Bing.

Another problem that we observe are meaningless excerpts consisting only of junk characters (Figure 4). Most probably, Bing could not read the underlying file and this prevented a proper indexing.

[![Figure 4: Character junk probably coming from a damaged PDF file.](https://journal.code4lib.org/media/issue11/jahn/Figure_4.png "Figure 4")](https://journal.code4lib.org/media/issue11/jahn/Figure_4.png)

**Figure 4.** Character junk probably coming from a damaged PDF file.

And finally, we see documents whose titles could not be recognized correctly. In those cases, the title mostly is part of or even identical to the document’s URL (see Figure 5).

[![Figure 5: Another bad example. Apparently the alleged title is part of the document's URL.](https://journal.code4lib.org/media/issue11/jahn/Figure_5.png "Figure 5")](https://journal.code4lib.org/media/issue11/jahn/Figure_5.png)

**Figure 5.** Another bad example. Apparently the alleged title is part of the document’s URL.

### **Text Classification**

Since the web pages containing the publication lists often include references to other material in PDF format, such as CVs, courseware, guidelines for students, etc., our comprehensive list features some irrelevant entries. To tackle this problem, we explore automatic text classification using a naïve Bayes’ classifier. This is a simple machine learning technique widely in use, for example in spam filters \[[5](https://journal.code4lib.org/articles/#note5)\]. The idea behind this step is to train a classifier that can distinguish a document representing a journal article or thesis from any non-publication material. This approach is also being used by PhilPapers.org, and is described by W. Schwartz in his article on “Metaparser” \[[6](https://journal.code4lib.org/articles/#note6)\].

We systematically download the PDF files and extract their raw texts using the pdftotext program \[[7](https://journal.code4lib.org/articles/#note7)\]. In total we obtain 1701 files. Note that we can only download less than half of the files initially identified. This is because many links point to documents hosted by commercial publishers. We then use langident \[[8](https://journal.code4lib.org/articles/#note8)\] to automatically sort the plain text files by language; we find 1287 English and 414 German documents. The files are then labeled by our student assistants as publication and non-publication documents. On this corpus of labeled documents, we train a naïve Bayes’ classifier using the words of every document as features. Note that we eliminate punctuation and function words, and limit the feature space to the remaining 1,000 most frequent words in the corpus to minimize computational complexity. For corpus management and classification we use the *Natural Language Toolkit* (NLTK) Python library \[[9](https://journal.code4lib.org/articles/#note9)\]. In sum, we identify 1493 relevant scholarly publications.

In order to evaluate the classifier, we use cross-validation against all documents in our corpus. This means that for each document, a classifier is trained on the whole corpus minus that particular document. The classifier is then evaluated by classifying the left out document. Therefore this method is also being referred to as *leave-one-out* evaluation. All evaluation measures are summed up and divided by the number of documents in the corpus.

By this means, we achieve a classification *accuracy* of 89% for the English documents. That means the classifier is able to predict the correct category (publication or not) for 89% of the documents. One could also say that for a randomly selected document, the probability for the classifier assigning it to the right category is 89%. For the German corpus the accuracy is 82%.

We also measure the effectiveness of the classifier in terms of *recall* and *precision* \[[10](https://journal.code4lib.org/articles/#note10)\] for the task of selecting the documents that are truly publications. Recall measures the ability of a classifier to select the correct documents from the data set, that is the completeness of the result set. Precision measures the ability of a classifier to reject incorrect documents. To compute the recall and precision values for our classifier, we must compare for each document the category assigned by the classifier with its true category, and assign it to one of the four sets *(a, b, c, d)* outlined in Table 1. Then the recall is computed by *r = a/(a + c)* and the precision by *p = a/(a + b).*

|  | Reference: publication | Reference: no publication |  |
| --- | --- | --- | --- |
| Classifier: publication | *a* | *b* | *a + b* |
| Classifier: no publication | *c* | *d* | *c + d* |
|  | *a + c* | *b + d* | *a + b + c + d* |

**Table 1.** Contingency table for computing recall and precision.

Our classifier achieves a recall value of 89% and a precision value of 98% for the English documents. The values for the German documents are a little lower with a recall value of 80% and a precision value of 95%. Since we have not yet conducted a qualitative in-depth analysis of these results, we can only suppose that the lower values for the German documents result from the smaller data set (414 documents) as opposed to the English data set (1287 documents).

## Limits and Future Steps to be Taken

Our approach shows that personal publication lists provide a significant amount of deposited scholarly documents and our search engine-driven excerpt extraction yields promising results in many cases.  The method, however, has its limits. Due to various reasons, some list entries are malformed. Our method relies on an already existing directory of personal web pages of our university.  Furthermore, since our directory is manually compiled, it is hard to keep track of lists that appear on the web after the compilation has been finished.  Yet not all libraries may have access to such a directory, if it exists at all. An alternative might be to start with the domain of the academic institution under examination and simply crawl all the documents within the subdomains and file directories. Since the number of received documents will then certainly be much higher, text classification will become even more important. In combination with the efficient crawling of websites, text classification and metadata extraction, such an approach would allow the creation of a much more detailed and robust list—certainly at the cost of development effort, since a focused web crawler is a way more complicated piece of software than our Python script.

Considering our text classification experiments, the resulting classifier performs well enough to encourage further investigation in this direction. The high precision values show that we can reliably filter irrelevant material from the publication list. However, the achieved recall values suggest that the classifier would also reject a significant portion of publication documents. Therefore we would not recommend using it in a production environment, yet.

Future work should aim at practical applications including the integration of library services already in use. We think of a web application that would allow repository managers to continuously monitor the faculty publication lists. Therefore, a mechanism to refresh the comprehensive list on a regular basis is needed. For convenience, new entries in the list should be highlighted, for example by putting them on top of the list or by making use of color. In the long run, we can even imagine deposit scenarios for the researchers.  For example, a service could be offered to faculty to have their documents, including the extracted metadata, transferred to the institutional repository. This would dramatically lower the barrier for open access self-archiving.

In the future, it would also be worth studying how to extract bibliographic metadata directly from the documents in order to overcome the limits of our current search engine-driven approach. G. Hatop \[[11](https://journal.code4lib.org/articles/#note11)\] has recently described a promising method for doing this.

The final consideration is of an organizational nature. Before presenting such a compiled lists on the web as a library service, methods for involving the researchers have to be developed. This includes workflows for researchers to verify their publications or to refuse to be part of the list. For instance, PhilPpapers.org only harvest publication lists deliberately registered by the authors themselves.

## Conclusion

We presented a method for automatically monitoring faculty publication lists and detecting deposited publications in them. Our main intention was to keep the implementation as simple as possible. We enhanced the publication list using a standard web search engine. Furthermore, we explored text classification to distinguish between scholarly publications and other material.

Despite the described drawbacks, we found 1493 relevant and even accessible scholarly publications. We therefore think that the automatic aggregation of faculty publications from personal webpages is a complementary approach to digital libraries in general and institutional repositories in particular. If this approach is combined with policies and workflows to form new deposit strategies, publication lists on personal websites could become a valuable source for populating digital libraries in the future.

## Acknowledgements

We are indebted to Saskia Scheibler and Agatha Walla for their valuable help with collecting data on the publication lists and labelling the corpus data. We also wish to thank Torsten Wilholt.

## References

[1](https://journal.code4lib.org/articles/#ref1). PhilPapers: Online Research in Philosophy. [http://philpapers.org/](http://philpapers.org/)

[2](https://journal.code4lib.org/articles/#ref2). DIVRE: The DIsciplinary Virtual Research Environment. [http://www.divre.org/](http://www.divre.org/)

[3](https://journal.code4lib.org/articles/#ref3). Aguillo, Isidro F. Measuring the Institution’s Footprint in the Web. Library Hi Tech 2009; 27(4): 540-556. Available from: Emerald; DOI 10.1108/073788309. Available from: [http://biecoll.ub.uni-bielefeld.de/volltexte/2010/5002](http://biecoll.ub.uni-bielefeld.de/volltexte/2010/5002)

[4](https://journal.code4lib.org/articles/#ref4). Bing Development Center. [http://www.bing.com/developers](http://www.bing.com/developers)

[5](https://journal.code4lib.org/articles/#ref5). Sahami, M., Dumais, S., Heckerman, D., Horvitz, E.: A bayesian approach to filtering junk e-mail. In: Learning for Text Categorization: Papers from the 1998 workshop, vol. 62, pp. 98–05. AAAI Technical Report WS-98-05, Madison, Wisconsin (1998)  
[(COinS)](https://journal.code4lib.org/coins)

[6](https://journal.code4lib.org/articles/#ref6). Schwartz, W.: Metaparser. [http://philpapers.org/metaparser.html](http://philpapers.org/metaparser.html)

[7](https://journal.code4lib.org/articles/#ref7). XPDF. [http://www.foolabs.com/xpdf/](http://www.foolabs.com/xpdf/)

[8](https://journal.code4lib.org/articles/#ref8). Simoes, A., Castro, J.: Lingua::Identify. [http://search.cpan.org/~ambs/Lingua-Identify-0.26/lib/Lingua/Identify.pm](http://search.cpan.org/~ambs/Lingua-Identify-0.26/lib/Lingua/Identify.pm)

[9](https://journal.code4lib.org/articles/#ref9). Bird, S., Loper, E., Klein, E.: Natural Language Processing with Python. O’Reilly (2009)  
[(COinS)](https://journal.code4lib.org/coins)

[10](https://journal.code4lib.org/articles/#ref10). Lewis, D.: Evaluating text categorization. In Proceedings of Speech and Natural Language Workshop, pp. 312–318 (1992); DOI: 10.3115/112405.112471

[11](https://journal.code4lib.org/articles/#ref11). Hatop, G.: Bibliographic metadata extraction from theses. Code4Lib (7) (2009) [http://journal.code4lib.org/articles/1686](https://journal.code4lib.org/articles/1686)

## Code

[Python Code](https://journal.code4lib.org/media/issue11/jahn/facpublister.py.bz2)

## About the authors

Najko Jahn (najko.jahn@uni-bielefeld.de) works at Bielefeld University Library. He is part of the project “PubLister – Personal Publication Lists as a University-wide Service” funded by the “German Research Foundation” (DFG).

Mathias Lösch (mathias.loesch@uni-bielefeld.de) works at Bielefeld University Library. He is part of the project “Automatic Enhancement of OAI Metadata” funded by the “German Research Foundation” (DFG).

Wolfram Horstmann (wolfram.horstmann@uni-bielefeld.de) is CIO of Scholarly Information at Bielefeld University.
---
title: "Bibliographic Metadata Extraction from Theses"
source: "https://journal.code4lib.org/articles/1686"
author:
  - "[[The Code4Lib Journal]]"
published: 2009-06-26
created: 2025-01-10
description: "This article presents the application of part-of-speech (POS) based statistical text analysis to the task of bibliographic metadata extraction from electronic dissertations. By using the approach described here it is possible to detect the title of a Ph.D. paper with an accuracy of about 80%. The accuracy measurements are done using a conceptually simple approach [...]"
tags:
  - "clippings"
---
# Bibliographic Metadata Extraction from Theses
Götz Hatop

This article presents the application of part-of-speech (POS) based statistical text analysis to the task of bibliographic metadata extraction from electronic dissertations. By using the approach described here it is possible to detect the title of a Ph.D. paper with an accuracy of about 80%. The accuracy measurements are done using a conceptually simple approach and implementation.

## Introduction

Electronic documents are an essential part of each modern library. Metadata about documents are usually created manually by the author himself or by a librarian before or after uploading a paper to an institutional repository. Bibliographic metadata extraction can help to improve user interfaces by presenting reasonable suggestions of metadata. It also reduces the need to type information about title, author and other metadata into a form manually.

The text in a document is written in a natural language and not understandable for a computing system. In general, even the task of extracting bibliographic metadata as simple as Dublin Core is extremely difficult. In recent years, much research has been done in statistical text analysis and, with respect to the complex task of identifying relevant information in a text, there has been considerable improvement.

The language a text is written in is an example of metadata that can be retrieved from a document using statistical methods with nearly perfect accuracy. Most algorithms for language detection are based on bigrams, which are groups of two written letters, two syllables, or two words. A good example of a program to determine the language of a text is the mguesser program \[[1](https://journal.code4lib.org/articles/#note1)\].

Also, the problem of automatically assigning a Library of Congress Classification (LCC) or a Dewey Decimal Classification (DDC) to a given work has been tackled by statistical learning methods with some success. These classifications can be used as the Dublin Core “subject” metadata to describe the topic of a resource. In statistical text classification, a number of already labeled documents is needed for each class. These so-called training documents have been labeled manually, but once a good training set is available, classification can be done by machines. Manning et. al. give an introduction to the text classification problem \[[2](https://journal.code4lib.org/articles/#note2)\].

This article describes a method to extract the title of a Ph.D. paper by bigram analysis of the grammatical structure of the sentences found on the title page of a document, using an approach derived from statistical learning methods.

## Metadata in an Institutional Repository

In an institutional repository, metadata play an important role. They are used to navigate between documents, are propagated via OAI interfaces and are traditionally the most important way to access a document in a library.

At the University Library of Marburg/Lahn in Germany/Europe over 2000 electronic dissertations were collected over the last 10 years. Most of the documents are in PDF format and stored within an institutional repository. After uploading documents to the repository, the user has to enter the bibliographic metadata into a web form.

A great subset of the documents can be transformed to Unicode text with publicly available text converters. For some documents, transformation fails because of the usage of special PDF characteristics, which make conversion difficult. Upcoming standards such as PDF/A will hopefully help to increase the machine readability of documents from the repository.

Nearly all documents contain a title page as their first page, since this is standard academic practice. Proper title pages that appear as the first page of a thesis can be separated from other text with publicly available programs. We have used the pdftotxt program \[[3](https://journal.code4lib.org/articles/#note3)\] and appropriate command line flags for this task. Only a few documents have an empty page or some other information like a short dedication as their first page.

The first page of the document (often called ‘title page’ or ‘front page’) itself contains much more information than just the title of the work and the name of the author. Frequently, the university institute where the dissertation has been done is mentioned. However, in principle a title page is not limited to a certain quantity of information. Also, the order of information is arbitrary and not the same on all title pages.

While a human being can decide within seconds which part is the title of the thesis and which is not, this information is hidden to a computing system. Until now no general algorithmic method of understanding for even such a limited amount of text was known.

## POS Tagging of Natural Language Sentences

POS is an acronym for part-of-speech and POS tagging is the task of setting tags to text entities, sometimes called word-category disambiguation. In this article, POS tagging stands for tagging words with their grammatical sense. An example is the sentence ‘This/DT is/VBZ an/DT example/NN’ which in this case is tagged with tags from the Penn tagset (where DT annotates a determiner, VBZ a verb, and NN a noun).

Modern POS taggers are able to tag words with an accuracy of about 97 percent and are almost always implemented using Hidden Markov Models (HMMs). Larsen et al. present a good introduction to HMMs and their applications \[[4](https://journal.code4lib.org/articles/#note4)\].

The sentences found on a typical title page of a Ph.D. thesis are different in many ways. For example, a statement like ‘From the Clinic of Ophthalmology of the University of Marburg’ can be found on thesis title pages. This sentence differs from a typical title sentence grammatically; it contains no verb at all and 5 nouns out of a total of 10 words.

The question we are trying to answer is, whether the sentences containing the title information can be identified only by analysis of the POS-sequence of each sentence. The short answer is: Yes, we can.

## Statistical Analysis of POS Data

From a set of 256 thesis papers we extract the title pages as explained above. In a first step, the different sentences from each title page are separated. In written text, sentences are usually separated by special symbols like a period or an exclamation mark, but this is typically not the case on a title page. While sentence boundary detection is worth its own research, it is not our main focus here. We therefore restrict our experiments to those thesis papers where sentence boundaries can be identified easily by two or more carriage return symbols.

We use the Stanford POS tagger \[[5](https://journal.code4lib.org/articles/#note5)\] to tag the words with their grammatical sense. The majority of the investigated title pages are written in German and so the tagger is configured to use a German tagger based on the Negra corpus. The tagset used for tagging is the so called Stuttgart/Tübinger Tagset (STTS) \[[6](https://journal.code4lib.org/articles/#note6)\].

From each tagged sentence we extract the POS-sequence. For example, the POS-sequence for the sentence ‘Aus der Klinik für Augenheilkunde’ (‘From the Clinic of Ophthalmology’) is ‘APPR ART NN ADJA NN’ (preposition, article, normal noun, attributive adjective, normal noun).

The documents from the test set are held in an institutional repository and metadata are known in advance. We label each POS-sequence of a title page with the line numbers referring to the original page. If a POS-sequence belongs to the title we are looking for, this information is written ahead of the sequence. With sentence detection and POS tagging it is possible to transform each title page to a form where statistics can be computed easily.

A transformed title page looks like the one shown below.

```
line 1-1: APPR ART NN NN ADJA NN
line 4-4: ADJA NN NN NN NE
line 7-8: NN NE NE NE NN NN NE
line 11-13: ART NN NN ART NE NE APPR NN APPR ART NN NE KON NE NE NN NE
title 17-18: NN APPR NN APPR NN ADV
line 23-27: NN APPRART NN ART NN ART ADJA NN ART NN ART NN ART NE NE VVPP APPR
author 30-31: NE NE NE APPR NE
line 35-35: NE CARD
```

**Figure 1:** A POS-transformed and labeled title page (POS-page)

The Java program used for this transformation merely consists of the embedding of the Stanford POS-tagger, some metadata lookup, and the usual input/output routines.

From a training set of 8 POS-pages we train a statistical model, where ‘model’ refers to a collection of bigram frequencies.

The computation of the bigram statistics is done with the jgram package, an open source java markov-chain n-gram library \[[7](https://journal.code4lib.org/articles/#note7)\]. The size of the training set as well as the pages we choose is completely arbitrary. While this setup is good enough to get an impression about POS based data detection, in a real world production system the training base should eventually be somewhat larger.

With L1 we denote the bigram statistics from title sentences, L2 denotes the bigram statistics of all other (non-title) sentences.

The first few lines of the computed bigram frequencies, the heart of the statistical model, are shown below.

```
%% cat title.stats | sort -t: -k 3 -r | head -5
ADJA:NN:0.11023622047244094
NN:APPR:0.10236220472440945
NN:ART:0.05511811023622047
FM:FM:0.05511811023622047
START:NN:0.047244094488188976

%% cat notitle.stats | sort -t: -k 3 -r | head -5
NE:NE:0.1444866920152091
NN:ART:0.07034220532319392
NN:NN:0.06653992395437262
NN:NE:0.06463878326996197
ART:NN:0.060836501901140684
```

The data can be interpreted such that in a typical title sentence from our training set a noun (NN) is preceded by an attributive adjective (ADJA) with a frequency of about 11 percent. Sentences not found on title pages contain bigrams of named entities (NE) with a frequency of 14 percent.

## Experimental Results in Title Detection

We are now in a position to evaluate whether the computed bigram statistic of POS-sequences is able to distinguish between title sequences and other sequence types. From a test set of 256 documents we extract each title page and transform it to a POS-page as done for model training. To calculate an acceptance value for each line, each bigram in the POS-sequence is weighted with the corresponding frequency found in the language statistic files. The pseudocode for this algorithm is shown below.

```
result := null;
maximumScore := 0.0;
for each line from input file do
begin
  head := line.substringBefore(":");
  pos-sequence := line.substringAfter(":");
  for each bigram b from pos-sequence do
      A1 := A1 + frequency of bigram b as noted in file L1
      A2 := A2 + frequency of bigram b as noted in file L2
  done;
  score := computeScore(A1, A2);
  if (score > maximumScore)
  begin
      maximumScore := score
      result := line
  end
end
if ( result.startsWith("title") )
      print success;
else print fail;
```

As it is not known in advance whether both of the language statistic files are really necessary, we check three different scoring models.

In a first run, we accept the sequence with a maximum A1 value as the title sequence. From all 256 papers, only 68 titles could be extracted correctly.

The second run uses the value A2 as the indicator for whether a POS-sequence belongs to a title sentence or not and retrieved only 83 titles.

In the third experiment, a combination of the two values is used. The scoring value is set to A1 + 1 – A2 which results in correct detection of 205 out of 256 title sentences.

To check whether a more complete statistical model can help to improve title detection rate, we changed the training set to include the whole set of 256 title pages. The computed bigram frequencies changed, the most popular POS bigram in all title sentences is an infinitive followed by a preposition. In non-title sentences a past participle followed by a named entity is the POS bigram with the highest frequency. However, running the experiments again shows a rather unspectacular improvement to 213 detected title sentences.

## Conclusion

One of the main intentions for doing the described experiments was to evaluate the idea of POS-based metadata detection and mining. The results of the experiments are positive. They show that the grammatical structure of a title sentence is different enough from other sentences that appear on a Ph.D. thesis title page that title extraction is possible in many cases.

Only POS-tagging and simple bigram statistics are used to get the result. We feel that special tagging of words frequently found in sentences which are not the title (like ‘dissertation’ or ‘institute’) is capable of improving results further. These lines are the ones which are often detected false positive, that is, they are detected as title sentence but are not. But, such special tagging goes beyond plain grammatical based data detection and makes implementation more complicated and less general.

It was relatively easy to derive a prototype of a title extraction program from the Java classes written to train and evaluate the model. This prototype together with all other programs written for this project is available from Bibtrack \[[8](https://journal.code4lib.org/articles/#note8)\].

## References

\[[1](https://journal.code4lib.org/articles/#ref1)\] Alexander Barkov, mguesser. Mguesser is a tool to guess a text’s character set and language. [http://www.mnogosearch.org/guesser](http://mnogosearch.org/guesser/)

\[[2](https://journal.code4lib.org/articles/#ref2)\] Christopher D. Manning, Prabhakar Raghavan and Hinrich Schütze. Introduction to Information Retrieval. Cambridge University Press, 2008. [http://www-csli.stanford.edu/~hinrich/information-retrieval-book.html](http://www-csli.stanford.edu/~hinrich/information-retrieval-book.html)

\[[3](https://journal.code4lib.org/articles/#ref3)\] pdftotext. The pdftotext program is part of a larger PDF related package called xpdf. [http://www.foolabs.com/xpdf](http://www.foolabs.com/xpdf/)

\[[4](https://journal.code4lib.org/articles/#ref4)\] Richard J. Larsen and Morris L. Marx. An introduction to mathematical statistics and its applications. 2006. ISBN 0-13-201813-6.

\[[5](https://journal.code4lib.org/articles/#ref5)\] Stanford Log-linear Part-Of-Speech Tagger: [http://nlp.stanford.edu/software/tagger.shtml](http://nlp.stanford.edu/software/tagger.shtml)

\[[6](https://journal.code4lib.org/articles/#ref6)\] STTS Tag Table: [http://www.ims.uni-stuttgart.de/projekte/corplex/TagSets/stts-table.html](http://www.ims.uni-stuttgart.de/projekte/corplex/TagSets/stts-table.html)

\[[7](https://journal.code4lib.org/articles/#ref7)\] JGRAM: A java markov-chain n-gram library. [https://jgram.dev.java.net](https://jgram.dev.java.net/)

\[[8](https://journal.code4lib.org/articles/#ref8)\] Bibtrack: A Java program for POS-based Title extraction from Theses. [ftp.ub.uni-marburg.de/pub/research/bibtrack.tar.gz](https://ftp.ub.uni-marburg.de/pub/research/bibtrack.tar.gz)

## About the Author

Götz Hatop is a developer at the IT Department of the University Library of Marburg/Lahn.
---
title: "Annif Analyzer Shootout:  Comparing text lemmatization methods for automated subject indexing"
source: "https://journal.code4lib.org/articles/16719"
author:
  - "Osma Suominen"
  - "Ilkka Koskenniemi"
published: 2022-08-29
created: 2025-01-10
description: "Automated text classification is an important function for many AI systems relevant to libraries, including automated subject indexing and classification. When implemented using the traditional natural language processing (NLP) paradigm, one key part of the process is the normalization of words using stemming or lemmatization, which reduces the amount of linguistic variation and often improves [...]"
tags:
  - "#Annif"
  - "#text/lemmatization/methods"
  - "#automated/subject/indexing"
---
# Annif Analyzer Shootout:  Comparing text lemmatization methods for automated subject indexing
Osma Suominen, Ilkka Koskenniemi

Automated text classification is an important function for many AI systems relevant to libraries, including automated subject indexing and classification. When implemented using the traditional natural language processing (NLP) paradigm, one key part of the process is the normalization of words using stemming or lemmatization, which reduces the amount of linguistic variation and often improves the quality of classification. In this paper, we compare the output of seven different text lemmatization algorithms as well as two baseline methods. We measure how the choice of method affects the quality of text classification using example corpora in three languages. The experiments have been performed using the open source Annif toolkit for automated subject indexing and classification, but should generalize also to other NLP toolkits and similar text classification tasks. The results show that lemmatization methods in most cases outperform baseline methods in text classification particularly for Finnish and Swedish text, but not English, where baseline methods are most effective. The differences between lemmatization methods are quite small. The systematic comparison will help optimize text classification pipelines and inform the further development of the Annif toolkit to incorporate a wider choice of normalization methods.

## Introduction

Libraries and other cultural heritage institutions are increasingly adopting natural language processing (NLP) and machine learning technologies to assist in the production of metadata. A common need in such settings is to automatically or semi-automatically classify text documents, for example performing subject indexing or to classify documents into mutually exclusive classes. One practical tool for these kinds of tasks is the automated subject indexing toolkit [Annif](https://annif.org/) (Suominen, Inkinen and Lehtinen 2022; Suominen 2019).

This study concentrates on a small but nevertheless important aspect of automated text classification systems, namely the use of different preprocessing and normalization methods such as stemming and lemmatization. These are particularly important in the traditional NLP setting, where text classification pipelines commonly include text preprocessing (e.g. tokenization and word normalization such as stemming or lemmatization), vectorization (turning words into numbers, often represented as vectors using a tf-idf transformation), model training and inference. The goal of word normalization in such a pipeline is to reduce the amount of unimportant linguistic variation by excluding aspects such as singular vs. plural and inflected word forms. For example, the words *eat*, *ate*, *eats*, *eating* and *eaten* all share the same base form *eat* and refer to the same activity, yet without normalization they would all be considered completely different words and a classification algorithm would need to learn their meanings separately. Normalizing them all into the same form with a stemming or lemmatization algorithm reduces the amount of noise in the data and will in many cases both reduce the required amount of training data and improve overall classification results.

Most of the algorithms implemented in Annif follow this traditional NLP paradigm, and in the modular architecture of Annif, the text preprocessing is performed by an *analyzer* module. This study explores the effect of different text normalization choices on the quality of the resulting automated subject indexing suggestions. The comparison includes both algorithms currently implemented as analyzer modules in Annif as well as several other lemmatization algorithms. We mainly selected open source lemmatization tools that were easy to use from Python code. As this study was performed in a collaborative project between the National Library of Finland and Lingsoft Inc., we also included the proprietary Lingsoft Language Management Central (LMC) [platform for language structure analysis](https://www.lingsoft.fi/en/technologies) in the comparison.

In order to compare the effect of different analyzer methods, we set up a series of experiments where the setting (corpora, algorithms, parameter settings, evaluation metrics) is static except for the text normalization method. We chose two subject prediction tasks, informed by the requirements of the [Finto AI](https://ai.finto.fi/) automated subject indexing service. The first task is an example of subject indexing with a thesaurus, where the goal is to assign a small number (typically 5–12) of relevant subjects to each document, which will improve the discoverability of the collection. The second task is an example of library classification, where the goal is to place each document in a single class or category – which, in a traditional library setting, would determine the location of a book on the shelf. We selected appropriate corpora, algorithms and other settings for each of the two tasks:

1. Automated subject indexing with the [General Finnish Ontology YSO](https://finto.fi/yso/) (including [YSO Places](https://finto.fi/yso-paikat/)). By now, this is a well established task which has been supported by the Finto AI service, and its experimental predecessor systems, for several years. This task is further divided by language: Finnish, Swedish and English.
2. Automated classification with the [Finnish Public Library Classification YKL](https://finto.fi/ykl/), which is closely related to the Dewey Decimal Classification used around the world. This is currently a more experimental task which, at the time of writing, has not yet been turned into a production service. However, we have collected suitable training and evaluation data and tested different algorithms on this task. We only perform this task in Finnish due to the lack of enough training data in other languages.

The goal of these experiments is to find out what kind of lemmatization methods (or other kinds of text normalization) give the best results when used in a typical NLP pipeline that performs text classification. The experiments are not intended to benchmark the classification algorithms themselves, as this has been done before (see, e.g., Suominen, Inkinen and Lehtinen 2022; Uhlmann and Grote 2021), but to highlight the effect of the lemmatization method on the downstream evaluation results. We hope that the experiment will help inform choices about which lemmatization method to select for a particular type of task and classification setting and to quantify how much that choice matters for the success of the classification task. Although the experimental setting is focused on the Annif tool, the results should generalize to other text classification settings that follow the traditional NLP paradigm, for example custom text classifiers implemented with the [scikit-learn](https://scikit-learn.org/) machine learning toolkit.

The experiment compares a wide range of lemmatization methods, ranging from very simplistic rule-based approaches to computationally intensive state-of-the-art neural network pipelines which perform many other functions than lemmatization, including part-of-speech (POS) tagging, dependency resolution, named entity recognition (NER) and named entity linking (NEL). For this experiment, only the result of the lemmatization matters, and it doesn’t even have to be linguistically correct, just consistent enough to adequately support the classification algorithms that make use of the lemmatized output. As an example, simple stemming algorithms convert words into stems (e.g. “qualities” becomes “qualiti” using Snowball stemming) that often aren’t valid word forms but can still be used to group together related words.

## Corpora for training and evaluation

We selected preexisting corpora that we had already been using to train and evaluate Annif models, in particular in the Finto AI service for automated subject indexing. The corpora consist of manually indexed raw text in the form of TXT and TSV files. Table 1 gives an overview of the corpora used in the experiments. The total amount of raw text included in all the corpora was approximately 1.1 GB.

<table><thead><tr><th>Task / language</th><th>Data set</th><th>Train set size</th><th>Used for training</th><th>Test set size</th><th>Raw text</th></tr></thead><tbody><tr><td rowspan="3">YSO Finnish</td><td>finna</td><td>7.0M records</td><td>Parabel, Bonsai</td><td>–</td><td>360 MB</td></tr><tr><td>jyu-theses</td><td>500 documents</td><td>MLLM</td><td>764 documents</td><td>270 MB</td></tr><tr><td>bookdesc</td><td>500 documents</td><td>MLLM</td><td>1311 documents</td><td>1.9 MB</td></tr><tr><td rowspan="3">YSO Swedish</td><td>finna</td><td>920k records</td><td>Parabel, Bonsai</td><td>–</td><td>50 MB</td></tr><tr><td>jyu-theses</td><td>103 documents</td><td>MLLM</td><td>32 documents</td><td>25 MB</td></tr><tr><td>bookdesc</td><td>744 documents</td><td>MLLM</td><td>560 documents</td><td>1.1 MB</td></tr><tr><td rowspan="3">YSO English</td><td>finna</td><td>2.0M records</td><td>Parabel, Bonsai</td><td>–</td><td>120 MB</td></tr><tr><td>jyu-theses</td><td>498 documents</td><td>MLLM</td><td>300 documents</td><td>190 MB</td></tr><tr><td>bookdesc</td><td>826 documents</td><td>MLLM</td><td>447 documents</td><td>1.3 MB</td></tr><tr><td>YKL Finnish</td><td>bookdesc</td><td>51187 documents</td><td>Parabel, Bonsai</td><td>4237 documents</td><td>46 MB</td></tr></tbody></table>

**Table 1.** Overview of document corpora used in the experiment.

To test subject indexing using concepts from the General Finnish Ontology YSO, we chose a snapshot of YSO and YSO Places dated 2021-09-23, training corpora based on metadata records collected from the [Finna.fi](https://finna.fi/) discovery system (*finna*), and two sets of manually indexed full text documents: Master’s and doctoral theses from the University of Jyväskylä (*jyu-theses*), as well as titles and short descriptions of non-fiction books collected from the database of Kirjavälitys Oy (*bookdesc*). These corpora include documents in three languages (Finnish, Swedish and English) and have been used to train and evaluate the models in the Annif-based automated subject indexing service Finto AI.

We also included a Finnish language corpus which is based on the same book descriptions as the *bookdesc* data set, but classified using the Finnish Public Library Classification YKL, in order to test the effect of text preprocessing strategies in an automated classification setting.

## Text preprocessing methods

We included nine text preprocessing methods in the comparison: the baseline methods **simple** and **snowball** as well as the more advanced lemmatization methods **voikko,** **spacy**, **simplemma**, **udpipe**, **stanza**, **lmc** and **tnpp**. Not all methods work on all three languages, as detailed below. The first four methods are implemented in Annif (version 0.57.0 was used for the experiments), so we relied on the built-in support. For the other methods, we performed the lemmatization of the data files outside the Annif tool, in most cases using Jupyter notebooks (Google Colaboratory in the case of TNPP and a custom Python script in the case of LMC), and stored the results in corpus files that were subsequently used instead of the original, unlemmatized files. We configured the corresponding Annif projects to use the **simple** analyzer, which converts the input text into lower case.

### Baseline methods

The **simple** analyzer, implemented in Annif, is a baseline, language-agnostic method that folds the input text into lower case but does not attempt to perform any stemming or lemmatization.

The **snowball** analyzer in Annif is another baseline method that converts words into lower case and additionally performs stemming using the Snowball algorithm, as implemented in the Python [Natural Language Toolkit](https://www.nltk.org/) (NLTK). The stemming rules are specific to each language and the implementation in NLTK supports at least 16 languages, including Finnish, Swedish and English.

### Lemmatization methods

The **voikko** analyzer in Annif is based on the [Voikko](https://voikko.puimula.org/) morphological analysis tool, which was originally developed as a Finnish language spell checker for the OpenOffice and LibreOffice applications. This analyzer also converts individual words into lower case. Voikko only supports the Finnish language.

The **spacy** analyzer in Annif performs lemmatization using [spaCy](https://spacy.io/) (version 3.2.4), which is a popular, multilingual NLP toolkit. Lemmatization requires installing a language-specific pretrained model, but among the languages used in this comparison, only English was supported (support for Finnish and Swedish was added in spaCy 3.3, which was released after the experiments had already been completed). We tested two variations of this method: with and without forced lowercasing of individual lemmas. The lowercased variant is called **spacy\_lower** in the remainder of this paper.

The **simplemma** method was implemented using the [simplemma](https://github.com/adbar/simplemma/) library (version 0.6.0), a simple multilingual lemmatizer for Python which does not need morphosyntactic information and works on the level of individual words, which makes it extremely fast. It has support for 38 languages, including the three languages used in this comparison. The following code demonstrates how Simplemma was initialized and used for lemmatization:

| 1  2  3  4  5  6  7  8 | `import` `simplemma`  `langdata ``=` `simplemma.load_data(``'en'``)`  `def` `lemmatize(text):`  `lemmas ``=` `simplemma.text_lemmatizer(text, langdata)`  `return` `" "``.join(lemmas)` |
| --- | --- |

The **udpipe** method was implemented using the [spaCy + UDPipe](https://github.com/TakeLab/spacy-udpipe) package (version 1.0.0) that wraps the [UDPipe NLP pipeline](https://ufal.mff.cuni.cz/udpipe) (version 1, originally implemented in C++ and accessible through Python bindings) so that it can be used via the spaCy API. It supports more than 100 languages or variants, including all three languages used in this comparison; the language-specific models need to be downloaded separately. The following code demonstrates how spaCy + UDPipe was initialized and used for lemmatization:

| 1  2  3  4  5  6  7  8  9  10  11 | `import` `spacy_udpipe`  `spacy_udpipe.download(``'en'``)`  `nlp ``=` `spacy_udpipe.load(``'en'``)`  `def` `lemmatize(text):`  `lemmas ``=` `[token.lemma_ ``for` `token ``in` `nlp(text)]`  `return` `" "``.join(lemmas)` |
| --- | --- |

The **stanza** method was implemented using the multilingual [Stanza](https://stanfordnlp.github.io/stanza/) NLP toolkit (version 1.3.0) to perform lemmatization. Stanza is based on a neural network architecture and like spaCy and UDPipe, it requires downloading language-specific pretrained models. It supports all three languages that were used in this comparison. The following code demonstrates how Stanza was initialized and used for lemmatization:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21 | `import` `stanza`  `stanza.download(``'en'``)`  `import` `os`  `os.environ[``"OMP_NUM_THREADS"``] ``=` `"1"`  `nlp ``=` `stanza.Pipeline(lang``=``'en'``,`  `processors``=``'tokenize,mwt,pos,lemma'``)`  `def` `lemmatize(text):`  `doc ``=` `nlp(text)`  `lemmas ``=` `(word.lemma`  `for` `sent ``in` `doc.sentences`  `for` `word ``in` `sent.words`  `if` `word.lemma)`  `return` `" "``.join(lemmas)` |
| --- | --- |

The **lmc** method refers to lemmatization using Lingsoft’s proprietary text analysis and proofing platform, the Language Management Central (LMC). It is a language technology platform through which various NLP tools are made available as cloud services, including lemmatization, POS tagging, syntactical disambiguation, NER and NEL, keywording and sentiment analysis. Supported languages include Finnish, Swedish, English, Norwegian, and Danish. Its lemmatization capabilities are based on Lingsoft’s FINTWOL, a rule-based morphological model of the Finnish language and FINCG, a constraint grammar disambiguator for Finnish. The TWOL and CG for the lemmatization are based on the two-level morphology (Koskenniemi, 1983) and constraint grammar (Karlsson, 1990) research by two of Lingsoft’s founders, professors Fred Karlsson and Kimmo Koskenniemi.

In **lmc\_yso**, a semantic layer extension is also used, which marks the token sequences in running text where it finds labels of terms in a given terminology/ontology like YSO. For example:

> “Negatiivinen paine ilmenee pimeässä energiassa, joka työntää galakseja kauemmas toisistaan.” (English translation: Negative pressure occurs in dark energy that pushes the galaxies further apart.)

would be tagged as

> “negatiivinen paine ilmetä pimeä energia \[pimeä\_energia\] , joka työntää galaksi kauemmas toinen .” (English translation: Negative pressure occurs in dark energy \[dark\_energy\] that pushes the galaxies further apart.)

It attempts to mark only the sequences where the term’s label appears in a syntactically valid manner (e.g. proper congruence between constituents of a noun phrase). The idea of using the YSO tagging in this test was to attempt to make it easier for the text classification algorithm to distinguish between cases where the different parts of a multi-word term label appear independently (e.g. “LED-valaisin valaisee *pimeässä energiaa* säästäen.”) in the text from cases where the term is actually being used.

The analysis run was done as a batch run on a desktop Linux computer at Lingsoft’s premises. The various source files were processed using a top-level shell script that sent them to a command-line wrapper tool (a Python script). This tool performed the actual calls to the **lmc** API. This run utilized a feature in **lmc** that processes the tab-separated values (TSV) format.

The **tnpp** method was implemented using the [Turku Neural Parser Pipeline](http://turkunlp.org/Turku-neural-parser-pipeline/) (TNPP), a NLP pipeline based on neural networks, to perform lemmatization. Pretrained models were available for Finnish and English, but we chose to test this method only for the YKL classification task because of its high resource requirements, including the need for GPU computing. We used Google Colaboratory to perform the lemmatization of train and test documents, adapting an example notebook (tnpp-diaparse.ipynb dated 2022-01-19) provided by the TNPP project. The notebook provides functionality to parse text and print the parsed structure in the CoNLLU output format. For lemmatization, we used the following function whose main purpose is to convert the CoNLLU format into a string of lemmas:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 | `from` `tnparser.pipeline ``import` `read_pipelines, Pipeline`  `available_pipelines ``=` `read_pipelines(`  `"models_fi_tdt_dia/pipelines.yaml"``)`  `p ``=` `Pipeline(available_pipelines[``"parse_plaintext"``])`  `def` `lemmatize(text):`  `parsed ``=` `p.parse(text) `  `lemmas ``=` `[]`  `for` `line ``in` `parsed.split(``"\n"``):`  `line ``=` `line.strip()`  `if` `not` `line ``or` `line.startswith(``"#"``):`  `continue`  `flds ``=` `line.split(``"\t"``)`  `lemmas.append(flds[``2``])`  `return` `' '``.join(lemmas)` |
| --- | --- |

### Example output of each method

In the following tables, we show the output of the different preprocessing methods when applied on example text. The example texts are titles of books selected from the book description data set. We picked examples that illustrate the differences between the methods; usually the differences in the output of the different methods are more subtle. Note that in these examples, we have retained the original case of words as returned by the normalization algorithms, even though text was subsequently folded to lower case in most of the Annif experiments.

| original | Hääd pulmapäeva ja yli 1000 muuta viron kielen riskisanaa |
| --- | --- |
| simple | hääd pulmapäeva ja yli 1000 muuta viron kielen riskisanaa |
| snowball | hääd pulmapäev ja yli 1000 muuta viro kiele riskisan |
| voikko | Hääd pulmapäeva ja yli 1000 muuttaa viro kieli riskisana |
| simplemma | Hääd pulmapäeva ja yli 1000 muu viro kieli riskisana |
| udpipe | Hääd pulmapäeva ja yli 1000 muu viro kieli riskisana |
| stanza | hääd pulma#päeva ja yli 1000 muu viro kieli riski#sana |
| lmc | hääd pulmapäeva ja yli 1000 muuttaa viro kieli riskisana |
| lmc\_yso | hääd pulmapäeva ja yli 1000 muuttaa viro kieli \[viro\_kieli\] riskisana |
| tnpp | hääd pulma#päeva ja yli 1000 muu virko kieli riski#sana |

**Table 2.** Original Finnish input text and the output of each preprocessing method.

The Finnish input text used as an example in Table 2 is a bit tricky to analyze, since the first two words are actually in Estonian language, which is closely related to Finnish; the book is a collection of Estonian words and phrases that resemble Finnish, but whose meaning is different from what a Finnish speaker would expect. The *stanza* and *tnpp* analyzers split compound words such as *pulmapäev* (Estonian for ‘wedding day’) and *riskisana* (‘risk word’, i.e., a word that is easily misinterpreted) into their constituent parts separated using a hash character. The *lmc\_yso* analyzer has noticed that the phrase *viron kielen* matches the YSO concept *viron kieli* (‘Estonian language’). Some words are wrongly lemmatized: *muuta* (‘other’) is lemmatized into *muuttaa* (‘to change’) by *voikko* and *lmc*, while *tnpp* lemmatizes *viron* (‘Estonian’) into *virko* which is a nonsensical word.

| original | Knut Pipping och etableringen av den moderna sociologin vid Åbo Akademi |
| --- | --- |
| simple | knut pipping och etableringen av den moderna sociologin vid åbo akademi |
| snowball | knut pipping och etablering av den mod sociologin vid åbo akademi |
| simplemma | Knut pipping och etablering av en modern sociologi vid åbo akademi |
| udpipe | Knut Pipping och etablering av en modern sociologi vid Åbo Akademi |
| stanza | Knut Pipping och etablering av en modern sociologi vid Åbo Akademi |
| lmc | knut pipping och etablering av den modern sociologi vid Åbo akademi |
| lmc\_yso | knut pipping och etablering av den modern \[den\_modern\] sociologi vid Åbo akademi |

**Table 3.** Original Swedish input text and the output of each preprocessing method.

The Swedish input text in Table 3 is the title of a book about the history of sociology. Again, *lmc\_yso* has noticed that the phrase *den moderna* matches the YSO concept *det moderna* (‘modern’, referring to the modern age). There are no obvious mistakes in the lemmatization, although *lmc* has chosen a different lemma for *den moderna* than other lemmatizing methods*; simplemma*, *udpipe* and *stanza* selected *en modern* (‘a modern’) instead of *den modern* (‘the modern’). There are also differences in the capitalization of the names Knut Pipping (a person) and Åbo Akademi (a university), although these are not relevant for this study due to the case folding performed later in the process.

| original | Health-Related Quality of Life and Functioning in Patients with Spinal Fusion |
| --- | --- |
| simple | health-related quality of life and functioning in patients with spinal fusion |
| snowball | health-rel qualiti of life and function in patient with spinal fusion |
| spacy | Health – relate Quality of Life and Functioning in patient with Spinal Fusion |
| simplemma | Health-relate quality of life and function in patient with spinal fusion |
| udpipe | health – related quality of Life and functioning in patients with spinal Fusion |
| stanza | health -related quality of life and function in patient with spinal Fusion |
| lmc | Health-Relate quality of life and function in patient with spinal fusion |
| lmc\_yso | Health-Relate quality of life \[quality\_of\_life\] and function in patient with spinal fusion |

**Table 4.** Original English input text and the output of each preprocessing method.

The English input text in Table 4 is the title of a doctoral dissertation in the field of medicine. There are differences in how the different methods handle the compound expression *Health-Related*, as well as in the capitalization; the original text was given in title case and many methods have preserved at least some of the uppercased words. Again, the *lmc\_yso* method has matched the expression *quality of life* to the YSO concept with the same label.

## Model training and evaluation

We used the [Data Version Control](https://dvc.org/) (DVC) tool to orchestrate the Annif experiments. All the corpus and vocabulary preparation, training and evaluation steps were specified in a single dvc.yaml configuration file that eventually grew to 979 lines. The dvc repro command was used to run the necessary Annif commands. Results of the evaluation runs were written by the Annif tool into JSON files. Finally, a Jupyter notebook was used to collect the results from the JSON files and, with the help of the [Pandas](https://pandas.pydata.org/) data analysis library, format them into tables that were then copied into the Results section of this paper. The DVC automation made it easy to ensure that all experiment runs were performed consistently and correctly. All experiments (both model training and evaluation) were repeated five times and the results of the evaluations averaged in order to minimize the effect of random fluctuations.

### Algorithms for text classification

We chose to include two algorithms supported by Annif in the comparison, in a total of three different configurations:

The **MLLM** algorithm (Maui-like Lexical Matching) originally implemented in Annif is a lexical automated subject indexing algorithm, inspired by the Maui tool (Medelyan 2009). It relies on matching terms (concept labels) in the indexing vocabulary to terms (words and combinations of words) in the document text, so it is important that the normalized terms from the vocabulary match the normalized terms from the text. Without text normalization, the algorithm doesn’t perform well, as it then cannot match e.g. singular terms that appear in document text to plural form terms in the vocabulary or vice versa.

[Omikuji](https://github.com/tomtung/omikuji) is a reimplementation of a family of efficient tree-based machine learning algorithms for multi-label classification, including **Parabel** (Prabhu et al. 2018) and **Bonsai** (Khandagale, Xiao, and Babbar 2020). When used with Annif, it can be configured with settings that constrain the size and shape of the decision tree in a way that emulates Parabel or Bonsai, with Parabel being the default configuration. Both the Parabel and Bonsai variations were used in these experiments, as they have slightly different strengths. These algorithms need to be trained on a large number of manually indexed samples and they learn to recognize correlations between words (or word n-grams, i.e. combinations of consecutive words) that appear in training documents and subjects or classes those documents have been manually assigned, without looking at the terms in the vocabulary at all.

| MLLM | Parabel | Bonsai |
| --- | --- | --- |
| backend=mllm | backend=omikuji   transform=limit(5000) | backend=omikuji   transform=limit(5000)   cluster\_balanced=false   cluster\_k=100   max\_depth=3   ngram=2   min\_df=2 |

**Table 5**. Configuration settings for the Parabel and Bonsai backends used for both YSO and YKL tasks. The settings *language*, *vocab* and *analyzer* have been omitted as they vary depending on the task setup.

The settings of the Annif projects used for the three types of algorithm are shown in Table 5. The MLLM configuration relies entirely on default values. The Parabel configuration is also very simple and mostly relies on default values, except for the *transform* setting which truncates long documents to the given length (5000 characters), which we have previously found to improve results. The Bonsai configuration is more advanced: in addition to the *transform* setting for truncating documents, the *cluster\_balanced*, *cluster\_k* and *max\_depth* settings constrain the shape of the decision tree to emulate Bonsai; the *ngram=2* setting causes bigrams (combinations of two consecutive words/tokens) to be used as features in addition to unigrams (single words); and the *min\_df=2* setting requires that n-grams (unigrams or bigrams) must appear in at least two training documents in order to be included as features, thus excluding very rare words and expressions that could add noise and make the model unnecessarily large. These settings represent a simplified version of the models that are either currently used in production in the Finto AI service (MLLM, Bonsai) or have been used in the past (Parabel).

### YSO subject indexing task

For the YSO subject indexing task in all three languages, we used the MLLM lexical algorithm as well as both the Parabel and Bonsai variations of the Omikuji algorithm, with the settings shown in Table 5. The MLLM models were trained on the training documents combined from both the *jyu-theses* and *bookdesc* corpora. The Parabel and Bonsai models were trained on the *finna* corpus. We did not use the *lmc\_yso* analyzer with MLLM, as the MLLM algorithm itself identifies YSO concepts within the document text and the additional matching performed by *lmc\_yso* most likely would have interfered with that mechanism.

All three types of YSO subject indexing models were evaluated using a combination of test set documents from both the *jyu-theses* and *bookdesc* corpora: 764+1311=2075 documents in Finnish, 32+560=592 documents in Swedish, and 300+447=747 documents in English. We chose two metrics for the evaluation: **F1@5** (F1 score – harmonic mean of precision and recall – calculated by comparing the top 5 suggestions of the algorithm to the manually assigned subjects) and **nDCG** (Normalized Discounted Cumulative Gain), a ranking measure where a higher score indicates that the manually assigned, “correct” subjects are closer to the top of the ranked list of suggestions given by the algorithm.

### YKL classification task

For the YKL classification task in Finnish, we used the Parabel and Bonsai variations of the Omikuji algorithm, with the settings shown in Table 5; MLLM was not used for this task, as it is not very well suitable for single-class classification. Both models were trained on the train set consisting of 51187 book descriptions manually classified using YKL. The models were evaluated on the test set of 4237 similarly classified book descriptions. We chose two metrics for the evaluation: **Accuracy**, which is the proportion of documents for which the top suggestion of the algorithm matches the manually assigned class (equivalent to Precision@1 in this setting where each document is assigned exactly one class), and the same **nDCG** ranking measure that was also used for the YSO subject indexing task.

## Results

### YSO subject indexing in Finnish

<table><thead><tr><th rowspan="2"></th><th colspan="2">MLLM algorithm</th><th colspan="2">Parabel algorithm</th><th colspan="2">Bonsai algorithm</th></tr><tr><th>F1@5</th><th>nDCG</th><th>F1@5</th><th>nDCG</th><th>F1@5</th><th>nDCG</th></tr></thead><tbody><tr><td>simple</td><td>0.221</td><td>0.290</td><td>0.415</td><td>0.563</td><td>0.454</td><td>0.615</td></tr><tr><td>snowball</td><td>0.269</td><td>0.364</td><td>0.424</td><td>0.575</td><td>0.471</td><td>0.636</td></tr><tr><td>voikko</td><td>0.305</td><td>0.413</td><td>0.423</td><td>0.577</td><td>0.472</td><td><strong>0.639</strong></td></tr><tr><td>simplemma</td><td>0.302</td><td>0.411</td><td>0.418</td><td>0.567</td><td>0.465</td><td>0.630</td></tr><tr><td>udpipe</td><td>0.287</td><td>0.389</td><td>0.407</td><td>0.555</td><td>0.450</td><td>0.609</td></tr><tr><td>stanza</td><td>0.301</td><td>0.412</td><td>0.397</td><td>0.542</td><td>0.466</td><td>0.631</td></tr><tr><td>lmc</td><td><strong>0.313</strong></td><td><strong>0.420</strong></td><td>0.426</td><td>0.579</td><td>0.470</td><td>0.636</td></tr><tr><td>lmc_yso</td><td>–</td><td>–</td><td><strong>0.427</strong></td><td><strong>0.582</strong></td><td><strong>0.473</strong></td><td>0.638</td></tr></tbody></table>

**Table 6.** Evaluation results for Finnish YSO subject indexing using different analyzers.

The results of the Finnish language YSO subject indexing task are shown in Table 6. The differences between analyzers are most apparent with the MLLM lexical algorithm, which performs very poorly with the baseline methods (*simple* and *snowball*). The *lmc* method achieved the highest scores with MLLM. For the Parabel and Bonsai algorithms, differences between analyzers were smaller; the *lmc\_yso, lmc* and *voikko* analyzers as well as the baseline *snowball* analyzer all achieved high scores. The results for *udpipe* and *stanza* were in many cases worse than those of the baseline methods.

### YSO subject indexing in Swedish

<table><thead><tr><th rowspan="2"></th><th colspan="2">MLLM algorithm</th><th colspan="2">Parabel algorithm</th><th colspan="2">Bonsai algorithm</th></tr><tr><th>F1@5</th><th>nDCG</th><th>F1@5</th><th>nDCG</th><th>F1@5</th><th>nDCG</th></tr></thead><tbody><tr><td>simple</td><td>0.171</td><td>0.242</td><td>0.409</td><td>0.564</td><td>0.454</td><td>0.623</td></tr><tr><td>snowball</td><td>0.208</td><td>0.300</td><td>0.425</td><td>0.583</td><td><strong>0.464</strong></td><td><strong>0.633</strong></td></tr><tr><td>simplemma</td><td>0.207</td><td>0.297</td><td>0.423</td><td>0.579</td><td>0.458</td><td>0.625</td></tr><tr><td>udpipe</td><td>0.204</td><td>0.292</td><td>0.408</td><td>0.565</td><td>0.438</td><td>0.601</td></tr><tr><td>stanza</td><td>0.211</td><td>0.307</td><td>0.420</td><td>0.577</td><td>0.454</td><td>0.620</td></tr><tr><td>lmc</td><td><strong>0.217</strong></td><td><strong>0.310</strong></td><td>0.425</td><td>0.585</td><td><strong>0.464</strong></td><td>0.629</td></tr><tr><td>lmc_yso</td><td>–</td><td>–</td><td><strong>0.428</strong></td><td><strong>0.591</strong></td><td>0.462</td><td>0.631</td></tr></tbody></table>

**Table 7.** Evaluation results for Swedish YSO subject indexing using different analyzers.

The results of the Swedish language YSO subject indexing task are shown in Table 7. As with Finnish, the lexical MLLM method appears to be most sensitive to the choice of analyzer, with the *simple* baseline method performing poorly. The *lmc* and *lmc\_yso* analyzers performed best, but also the *snowball* analyzer gave surprisingly good results.

### YSO subject indexing in English

<table><thead><tr><th rowspan="2"></th><th colspan="2">MLLM algorithm</th><th colspan="2">Parabel algorithm</th><th colspan="2">Bonsai algorithm</th></tr><tr><th>F1@5</th><th>nDCG</th><th>F1@5</th><th>nDCG</th><th>F1@5</th><th>nDCG</th></tr></thead><tbody><tr><td>simple</td><td>0.235</td><td>0.321</td><td><strong>0.417</strong></td><td>0.571</td><td><strong>0.500</strong></td><td><strong>0.678</strong></td></tr><tr><td>snowball</td><td><strong>0.249</strong></td><td><strong>0.343</strong></td><td>0.396</td><td>0.550</td><td>0.492</td><td>0.670</td></tr><tr><td>spacy</td><td>0.241</td><td>0.334</td><td>0.400</td><td>0.553</td><td>0.495</td><td>0.675</td></tr><tr><td>spacy_lower</td><td>0.242</td><td>0.337</td><td>0.405</td><td>0.555</td><td>0.496</td><td>0.675</td></tr><tr><td>simplemma</td><td>0.243</td><td>0.336</td><td>0.407</td><td>0.559</td><td>0.493</td><td>0.674</td></tr><tr><td>udpipe</td><td>0.235</td><td>0.325</td><td>0.397</td><td>0.546</td><td>0.476</td><td>0.656</td></tr><tr><td>stanza</td><td>0.244</td><td>0.337</td><td>0.398</td><td>0.550</td><td>0.485</td><td>0.665</td></tr><tr><td>lmc</td><td>0.247</td><td>0.340</td><td>0.401</td><td>0.556</td><td>0.486</td><td>0.667</td></tr><tr><td>lmc_yso</td><td>–</td><td>–</td><td>0.415</td><td><strong>0.574</strong></td><td>0.488</td><td>0.671</td></tr></tbody></table>

**Table 8.** Evaluation results for English YSO subject indexing using different analyzers.

The results of the English language YSO subject indexing task are shown in Table 8. Also in this case, the MLLM lexical algorithm doesn’t perform well with the *simple* analyzer, but works surprisingly well with the *snowball* analyzer. For the Parabel and Bonsai algorithms, the *simple* analyzer gives the best results. The *lmc* and *lmc\_yso* analyzers are not far behind. In general, it appears that for the English language subject indexing task, the more advanced analyzers for the most part do not produce results that would be better than those of one of the baseline methods.

### YKL automated classification in Finnish

<table><thead><tr><th rowspan="2"></th><th colspan="2">Parabel algorithm</th><th colspan="2">Bonsai algorithm</th></tr><tr><th>Accuracy</th><th>nDCG</th><th>Accuracy</th><th>nDCG</th></tr></thead><tbody><tr><td>simple</td><td>0.622</td><td>0.725</td><td>0.612</td><td>0.724</td></tr><tr><td>snowball</td><td>0.631</td><td>0.738</td><td>0.627</td><td>0.743</td></tr><tr><td>voikko</td><td>0.637</td><td>0.747</td><td>0.632</td><td>0.750</td></tr><tr><td>simplemma</td><td>0.638</td><td>0.748</td><td>0.632</td><td>0.750</td></tr><tr><td>udpipe</td><td>0.631</td><td>0.742</td><td>0.629</td><td>0.746</td></tr><tr><td>stanza</td><td>0.634</td><td><strong>0.752</strong></td><td><strong>0.639</strong></td><td><strong>0.763</strong></td></tr><tr><td>lmc</td><td>0.637</td><td>0.747</td><td>0.636</td><td>0.753</td></tr><tr><td>lmc_yso</td><td><strong>0.639</strong></td><td>0.748</td><td>0.636</td><td>0.753</td></tr><tr><td>tnpp</td><td>0.629</td><td>0.750</td><td><strong>0.639</strong></td><td><strong>0.763</strong></td></tr></tbody></table>

**Table 9.** Evaluation results for Finnish YKL classification using different analyzers.

The results of the Finnish language YKL classification task are shown in Table 9. The best results were obtained with the *lmc\_yso, tnpp* and *stanza* analyzers. As with the Finnish language subject indexing task, the baseline analyzers (*simple* and *snowball*) performed worst. The differences between different lemmatizer methods were quite small, with the possible exception of *udpipe*, which was not much better than the *snowball* analyzer.

### Computational cost

We did not specifically measure the performance of each method in terms of computing resources because the methods were run in different computing environments and we didn’t put much effort into optimizing them. However, it was apparent that some methods were much more resource-intensive than others. We can roughly divide the methods into three categories based on resource usage:

1. The lightweight methods include the baseline methods *simple* and *snowball* as well as the lemmatizers *voikko* and *simplemma*. The *lmc* analyzer (and its *lmc\_yso* variant) is also quite fast, with the full set of corpora lemmatized in approximately two hours on a desktop PC. With the lightweight preprocessing methods, we can expect the execution time of typical Annif training and evaluation runs to be dominated by other processing steps including text vectorization, model training and prediction.
2. The methods with moderate resource requirements include *spacy* (along with the *spacy\_lower* variant) and *udpipe*. The *spacy* analyzer is an order of magnitude more resource-intensive than the lightweight methods, adding several hours to the runtime of the English language training and evaluation runs where it was used. Likewise, *udpipe* was much slower than the lightweight methods, with a full lemmatization of the corpora taking more than an hour on a high-end server with 48 CPU cores used in parallel.
3. The most resource-intensive methods were *stanza* and *tnpp*. The Stanza lemmatization of the full set of corpora took several hours with 48 CPU cores used in parallel, while the TNPP analysis of just the small YKL corpus (46 MB of raw text) took six hours on the Google Colab platform using GPU computing. In practice, these two methods are unlikely to be suitable for real time usage due to their high computational cost.

## Conclusion

In this comparison of text normalization methods, we expected that more advanced lemmatization methods would result in better downstream quality for text classification tasks compared to simple baseline methods (only case folding and simple rule-based stemming). By and large, this was the result we got, with some notable exceptions: in particular, the baseline methods *simple* and *snowball* performed well for the English language subject indexing task whereas even the more advanced lemmatizers performed relatively poorly, rarely scoring above the baseline methods. This may be due to the more analytic nature of the English language, which implies that there are fewer inflected word forms than in a synthetic, heavily inflected language such as Finnish. The clearest benefit of lemmatization over baseline methods was seen for the Finnish language, with Swedish falling somewhere in between Finnish and English.

The lexical algorithm MLLM was clearly more sensitive to the choice of text normalization than the Omikuji variants, which was expected, because MLLM needs to be able to accurately match terms in the vocabulary to terms that appear in the text. The Omikuji algorithms, in contrast, are associative and only concerned with words in the text, so the particular text normalization method makes less of a difference.

The differences between lemmatization methods were relatively small, although *lmc* and *lmc\_yso* usually ranked at or near the top and *udpipe* did not perform as well as the other methods. Since the relative performance of different analyzers appears to be different for each task, algorithm and language, it is difficult to predict in advance which method will work best in a particular situation. The best method has to be chosen experimentally, by training and evaluating models using both baseline methods and more advanced lemmatization methods. When using the Annif toolkit, this can be performed by adjusting the analyzer setting of a project; in custom NLP pipelines, the normalization method can be changed by changing the code for text preprocessing.

The study was limited to two types of tasks, corpora from three source systems, nine text normalization methods, three text classification algorithms and three languages. It is by no means a comprehensive comparison of text normalization methods, although even with these options the number of individual evaluation runs was 87 due to combinatorial explosion. This figure was further multiplied by the five repetitions we performed for the purpose of smoothing out random variation, so the full runs took several days on a server with 48 CPU cores. A larger comparison would have required access to training and evaluation corpora in other languages, more normalization methods to test or other possible algorithmic variations. Among lemmatizers, we excluded the [UralicNLP](https://github.com/mikahama/uralicNLP) toolkit, which we didn’t have time to integrate and whose CC BY-NC-ND license could be problematic; [Lemmy](https://github.com/sorenlind/lemmy), which could have been used for Swedish but usage was not straightforward as all the working examples were for the Danish language; as well as some advanced NLP toolkits that would probably have been extremely resource-heavy, e.g. UDPipe version 2 and [SparkNLP](https://nlp.johnsnowlabs.com/).

A core reason for setting up this study was to determine the feasibility of adding additional analyzer modules to the Annif toolkit. Of the lemmatizer methods that were not yet implemented in Annif, we determined the *simplemma* method to be the most promising, as it is very simple and fast, it supports a large number of languages (currently 38), and the empirical results in this study were rather good even though it was never the top performer for any particular task. We have already implemented an analyzer module based on the Simplemma library and it was included in the Annif 0.58 release. Other analyzer integrations may follow later.

## References

Khandagale S, Xiao H, and Babbar R. 2020. Bonsai: Diverse and Shallow Trees for Extreme Multi-Label Classification. Machine Learning \[Internet\]. \[cited 2022 June 22\]. 109 (11): 2099–2119. Available from: [https://doi.org/10.1007/s10994-020-05888-2](https://doi.org/10.1007/s10994-020-05888-2).

Medelyan O. 2009. Human-Competitive Automatic Topic Indexing \[dissertation\], The University of Waikato. Available from: [https://researchcommons.waikato.ac.nz/handle/10289/3513](https://researchcommons.waikato.ac.nz/handle/10289/3513).

Prabhu, Y, Kag A, Harsola S, Agrawal R, and Varma M. 2018. Parabel: Partitioned Label Trees for Extreme Classification with Application to Dynamic Search Advertising. In Proceedings of the 2018 World Wide Web Conference, 993–1002. WWW ’18. Lyon, France. Available from: [https://doi.org/10.1145/3178876.3185998](https://doi.org/10.1145/3178876.3185998).

Suominen, O. 2019. Annif: DIY automated subject indexing using multiple algorithms. LIBER Quarterly: The Journal of the Association of European Research Libraries \[Internet\]. \[cited 2022 June 22\]. 29 (1), 1–25. Available from: [https://doi.org/10.18352/lq.10285](https://doi.org/10.18352/lq.10285)

Suominen O, Inkinen J, Lehtinen M. 2022. Annif and Finto AI: Developing and Implementing Automated Subject Indexing. JLIS.it \[Internet\]. \[cited 2022 June 22\]. 13 (1), 265–282. Available from: [https://doi.org/10.4403/jlis.it-12740](https://doi.org/10.4403/jlis.it-12740)

Uhlmann S, Grote C. 2021. Automatic subject indexing with Annif at the German National Library (DNB) \[presentation slides\]. \[cited 2022 June 22\]. SWIB21 online conference, December 2021. Available from: [https://swib.org/swib21/slides/03-02-uhlmann.pdf](https://swib.org/swib21/slides/03-02-uhlmann.pdf)

Koskenniemi K. 1983. Two-Level Morphology: A General Computational Model for Word-Form Recognition and Production \[dissertation\]. (Publications; No. 11). University of Helsinki. Department of General Linguistics. Available from: [http://hdl.handle.net/10138/305218](http://hdl.handle.net/10138/305218)

Karlsson F. 1990. Constraint grammar as a framework for parsing running text. In: Karlgren H, editor, Proceedings of the 13th International Conference on Computational Linguistics, volume 3, pp. 168-173, Helsinki, Finland. Available from: [https://doi.org/10.3115/991146.991176](https://doi.org/10.3115/991146.991176)

## About the Authors

**Osma Suominen** is working as an information systems specialist at the National Library of Finland. He is currently working on automated subject indexing, in particular the Annif tool and the Finto AI service, as well as the publishing of bibliographic data as Linked Data. He is also one of the creators of the Finto.fi thesaurus and ontology service and is leading development of the Skosmos vocabulary browser used in Finto. Osma Suominen earned his doctoral degree at Aalto University while doing research on semantic portals and quality of controlled vocabularies within the FinnONTO series of projects.

**Ilkka Koskenniemi** is working at Lingsoft as a technical architect and currently in charge of developing Lingsoft’s text analysis and proofing tools and their cloud-based interface LMC. He has a background in computer science at the University of Helsinki where he also worked briefly as a research assistant before starting full-time work at Lingsoft.

## Acknowledgements

We thank Filip Ginter and Jenna Kanerva for assisting with TNPP technical issues, Michael Stormbom and Sebastian Andersson for providing background information about LMC, and Juho Inkinen for constructive comments.
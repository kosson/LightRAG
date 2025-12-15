---
title: "Data Preparation for Fairseq and Machine-Learning using a Neural Network"
source: "https://journal.code4lib.org/articles/17038"
author:
  - "John Schriner"
published: 2023-01-20
created: 2025-01-10
description: "This article aims to demystify data preparation and machine-learning software for sequence-to-sequence models in the field of computational linguistics. The tools, however, may be used in many different applications. In this article we detail what sequence-to-sequence learning looks like using code and results from different projects: predicting pronunciation in Esperanto, predicting the placement of stress in Russian, and how open data like WikiPron (mined pronunciation data from Wiktionary) makes projects like these possible. With scraped data, projects can be started in automatic speech recognition, text-to-speech tasks, and computer-assisted language-learning for under-resourced and under-researched languages. We will explain why and how datasets are split into training, development, and test sets. The article will discuss how to add features (i.e. properties of the target word that may or may not help in prediction). By scaffolding the tasks and using code and results from these projects, it’s our hope that the article will demystify some of the technical jargon and methods."
tags:
  - "#natural/language/processing"
  - "#machine/learning"
  - "#neural/network"
  - "#Fairseq"
  - "#WikiPron/data"
---
# Data Preparation for Fairseq and Machine-Learning using a Neural Network
John Schriner

This article aims to demystify data preparation and machine-learning software for sequence-to-sequence models in the field of computational linguistics. The tools, however, may be used in many different applications. In this article we detail what sequence-to-sequence learning looks like using code and results from different projects: predicting pronunciation in Esperanto, predicting the placement of stress in Russian, and how open data like WikiPron (mined pronunciation data from Wiktionary) makes projects like these possible. With scraped data, projects can be started in automatic speech recognition, text-to-speech tasks, and computer-assisted language-learning for under-resourced and under-researched languages.

We will explain why and how datasets are split into training, development, and test sets. The article will discuss how to add features (i.e. properties of the target word that may or may not help in prediction). By scaffolding the tasks and using code and results from these projects, it’s our hope that the article will demystify some of the technical jargon and methods.

## Introduction

There are many tools in the field of natural language processing (NLP) and computational linguistics that: help us to understand language better; find patterns that we cannot perceive; find word collocation (i.e. when words are commonly near other words); improve text-to-speech; perform text summarization; perform information extraction; provide sentiment analysis; and perform machine-translation. Some of these tools are the user-friendly web-based Voyant Tools,\[[1](https://journal.code4lib.org/articles/#note1)\] the Python software platform Natural Language Toolkit (NLTK),\[[2](https://journal.code4lib.org/articles/#note2)\] and Praat\[[3](https://journal.code4lib.org/articles/#note3)\] phonetic software for examining sound. The NLP tool Linguistic Inquiry and Word Count (LIWC)\[[4](https://journal.code4lib.org/articles/#note4)\] is a psycholinguistic black-box\[[5](https://journal.code4lib.org/articles/#note5)\] tool that can provide sentiment analysis, language style matching, and many other metrics using over 100 dimensions of text. LIWC has been widely used for decades, is dictionary-based, and does not involve machine learning.

Although we may not see a lot of conspicuous use of machine-learning in libraries at present, any project in library and information science that uses an input sequence to map to an output sequence could be improved with this technology; indeed, our discovery services and search engines embrace techniques identified in 1995 that can “analyze user queries, identify users’ information needs, and suggest alternatives for search” (Chen, 1995, p. 1). Moving to the present day, in Zhu & Lei (2022) we see machine-learning being used in classification of research topics in COVID-19 research. They extract noun phrases from an experimental corpus of full text articles indexed in Web of Science. These noun phrases numbered 19,240 with a minimum frequency of 10 per million words. Zhu & Lei (2022) identify research topics whose subject matter was increasing; these are labeled hot topics and categorized into larger categories such as biochemical terms, public health measures, symptoms and diseases, etc. Their methods are robust and they work with six different classification models, finding that a Random Forest classifier\[[6](https://journal.code4lib.org/articles/#note6)\] yields the best results. In a similar vein and apropos to information literacy, Sanaullah et al. (2022) offers a systematic review of COVID-19 misinformation research involving machine-learning and deep learning. In their review they selected 43 research articles and categorized them into misinformation types: fake news, conspiracy theory, rumor, misleading information, and disinformation (deceptive information, as opposed to inaccurate in the case of misinformation) (Sanaullah et al., 2022). After a thorough discussion of methods, this survey finds that deep-learning methods are more efficacious than traditional machine-learning methods.

With known datasets, or datasets created from scraped web data, we can use modern machine-learning tools for any number of projects in different subfields of linguistics like phonology (the study of linguistic sound), morphology (the study of words and how they are formed and used together), and even historical linguistics (the study of languages over time, including language families).

This paper focuses on sequence-to-sequence models, the conversion of a sequence from one domain into a sequence of another domain. This could be, for example, Polish words converted to their pronunciation in the International Phonetic Alphabet (IPA) format: e.g. osłu ‘donkey’ converted to ɔswu. This model would effectively aid in text-to-speech systems. Another example of sequence-to-sequence modeling could be to predict the correct inflection and placement of a stress marker given a word and its part of speech: training a model that when given the Russian adjective эйфорически ‘euphorically,’ must successfully place the stress on the middle «и́» as in эйфори́чески.

The idea is that we will use 80% of the data to train on, 10% for development with which to choose the best parameters and model, and 10% for the test set. It’s easy to feel overwhelmed with these tools and their architectures. The aim of this paper is to help demystify this particular type of machine-learning with a well-prepared dataset and project goals.

## Importance of Open Data

Open data is essential for original research and replication studies.  SPARC states that “Despite its tremendous importance, today, research data remains largely fragmented—isolated across millions of individual computers, blocked by disparate technical, legal and financial restrictions” (“Open Data,” n.d.).  To combat this fragmentation, a call for open data would require that research data: “(1) Is freely available on the Internet, (2) Permits any user to download, copy, analyze, re-process, pass to software or use for any other purpose; and (3) Is without financial, legal, or technical barriers other than those inseparable from gaining access to the internet itself” (“Open Data,” n.d.).  Open Data can be found worldwide in GLAM labs such as the Data Foundry\[[7](https://journal.code4lib.org/articles/#note7)\] at the National Library of Scotland, and linguistics repositories such as the Tromsø Repository of Language and Linguistics (TROLLing).\[[8](https://journal.code4lib.org/articles/#note8)\]  The Registry of Research Data Repositories\[[9](https://journal.code4lib.org/articles/#note9)\] indexes nearly 3,000 research data repositories that provide databases, corpora, tools, statistical, and audiovisual data.  With open and well-described data alongside open access papers, our research lives on in repositories, waiting to be replicated, rebutted, added to, or improved.

Projects like the one we describe below rely on data scraped by the WikiPron project (Lee et al., 2020), providing phonological and morphological datasets coupled with frequency data, all regularly updated and open.  The WikiPron project contains 1.7 million pronunciations from 165 languages.  Better still, the project released its mining software so that anyone may mine the data themselves so that researchers “no longer depend on ossified snapshots of an ever-growing, ever-changing collaborative resource” (Lee et al., 2020, p 4223).

Under-researched languages like Adyghe or Urak Lawoi’, or an endangered/moribund language like Wiyot can benefit from projects that have access to open phonological data for language revitalization efforts or preservation.  The WikiPron project even has 452 words from Old French (842 CE – ca. 1400 CE) that could be used to track sound change to modern French.  Repositories and applications like WikiPron provide invaluable data that can be used in countless ways.

## Projects with Fairseq

Each project requires preparing the data in a way that can be used by the software.  In this paper we use Fairseq (Ott et al., 2019) which is a “Facebook AI Research Sequence-to-Sequence Toolkit written in Python.”\[[10](https://journal.code4lib.org/articles/#note10)\]  The toolkit requires that characters be separated with a space if that is what we’re trying to sequence.\[[11](https://journal.code4lib.org/articles/#note11)\]  A WikiPron dataset may be downloaded as a tab-separated values (TSV) file.

In this article we’ll look at two projects and how we’d manipulate the data for Fairseq.

### Esperanto

Esperanto is a constructed language (conlang) created to be a universal auxiliary/second language to aid in international communication.\[[12](https://journal.code4lib.org/articles/#note12)\]  From the WikiPron project we first download the TSV file for Esperanto.\[[13](https://journal.code4lib.org/articles/#note13)\]  In Esperanto, each letter has only one pronunciation, so it should be trivial to convert characters to the IPA pronunciation and our machine should be able to do this with great accuracy.  Stress is not marked in the dataset, but in Esperanto stress is always placed on the penultimate syllable.  The data is in two tab-separated columns with the *grapheme* (the written word) in the first column and the *phoneme* (the IPA representation for pronunciation) in the second column:

**Table 1.** Example data from the TSV file from WikiPron.

| aarono | a a r o n o |
| --- | --- |
| abadono | a b a d o n o |
| abateco | a b a t e t͡s o |
| abelmanĝulo | a b e l m a n d͡ʒ u l o |
| abortitaĵo | a b o r t i t a ʒ o |

The TSV is shuffled using *shuf* and then split into three TSV files: an 80% training set, a 10% development set, and a 10% test set using a Python script.\[[14](https://journal.code4lib.org/articles/#note14)\]

| 1  2  3  4  5  6 | `python3 split.py \`  `-``-``seed ``103` `\`  `-``-``input_path epo.tsv \`  `-``-``train_path epo_train.tsv \`  `-``-``dev_path epo_dev.tsv \`  `-``-``test_path epo_train.tsv` |
| --- | --- |

To prepare the data for Fairseq, the important part of the code to note is that each of the three TSV files are then split into .g (for grapheme) and .p (for phoneme) files for training, dev, and test:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40 | `import` `contextlib`  `import` `csv`  `TRAIN ``=` `"epo_train.tsv"`  `TRAIN_G ``=` `"train.epo.g"`  `TRAIN_P ``=` `"train.epo.p"`  `DEV ``=` `"epo_dev.tsv"`  `DEV_G ``=` `"dev.epo.g"`  `DEV_P ``=` `"dev.epo.p"`  `TEST ``=` `"epo_test.tsv"`  `TEST_G ``=` `"test.epo.g"`  `TEST_P ``=` `"test.epo.p"`  `with contextlib.ExitStack() as stack:`  `source ``=` `csv.reader(stack.enter_context(``open``(TRAIN, ``"r"``)), delimiter``=``"\t"``)`  `g ``=` `stack.enter_context(``open``(TRAIN_G, ``"w"``))`  `p ``=` `stack.enter_context(``open``(TRAIN_P, ``"w"``))`  `for` `graphemes, phones ``in` `source:`  `print``(``" "``.join(graphemes), ``file``=``g)`  `print``(phones, ``file``=``p)`  `with contextlib.ExitStack() as stack:`  `source ``=` `csv.reader(stack.enter_context(``open``(DEV, ``"r"``)), delimiter``=``"\t"``)`  `g ``=` `stack.enter_context(``open``(DEV_G, ``"w"``))`  `p ``=` `stack.enter_context(``open``(DEV_P, ``"w"``))`  `for` `graphemes, phones ``in` `source:`  `print``(``" "``.join(graphemes), ``file``=``g)`  `print``(phones, ``file``=``p)`  `with contextlib.ExitStack() as stack:`  `source ``=` `csv.reader(stack.enter_context(``open``(TEST, ``"r"``)), delimiter``=``"\t"``)`  `g ``=` `stack.enter_context(``open``(TEST_G, ``"w"``))`  `p ``=` `stack.enter_context(``open``(TEST_P, ``"w"``))`  `for` `graphemes, phones ``in` `source:`  `print``(``" "``.join(graphemes), ``file``=``g)`  `print``(phones, ``file``=``p)` |
| --- | --- |

As shown above in Table 1, the second column characters were already spaced correctly, so we needed to add spaces to only the first column. The result is two files for each set with spaced characters:

**Table 2.** Example of data ready for Fairseq.

| **train.epo.g** | **train.epo.p** |
| --- | --- |
| s t a c i o | s t a t͡s i o |
| o m a ĝ o | o m a d͡ʒ o |
| ĉ i r k a ŭ f l a t a d i | t͡ʃ i r k a w f l a t a d i |

The generated files are now ready for pre-processing in Fairseq:

| 1  2  3  4  5  6  7  8  9 | `fairseq``-``preprocess \`  `-``-``source``-``lang epo.g \`  `-``-``target``-``lang epo.p \`  `-``-``trainpref train \`  `-``-``validpref dev \`  `-``-``testpref test \`  `-``-``tokenizer space \`  `-``-``thresholdsrc ``2` `\`  `-``-``thresholdtgt ``2` |
| --- | --- |

This pre-processing creates a folder called *data-bin* with binaries and a log file that provides the number of tokens found.  We can now start the training:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21 | `fairseq``-``train \ `  `-``-``data``-``bin` `\`  `-``-``source``-``lang epo.g \`  `-``-``target``-``lang epo.p \`  `-``-``encoder``-``bidirectional \`  `-``-``seed {choose a random whole numeral} \`  `-``-``arch lstm \`  `-``-``dropout ``0.2` `\`  `-``-``lr .``001` `\`  `-``-``max``-``update ``800` `\`  `-``-``no``-``epoch``-``checkpoints \    `  `-``-``batch``-``size ``3000` `\`  `-``-``clip``-``norm ``1` `\`  `-``-``label``-``smoothing .``1` `\`  `-``-``optimizer adam \  `  `-``-``clip``-``norm ``1` `\`  `-``-``criterion label_smoothed_cross_entropy \  `  `-``-``encoder``-``embed``-``dim ``128` `\   `  `-``-``decoder``-``embed``-``dim ``128` `\   `  `-``-``encoder``-``layers ``1` `\`  `-``-``decoder``-``layers ``1` |
| --- | --- |

With these parameters it took my machine\[[15](https://journal.code4lib.org/articles/#note15)\] a half-hour to train.  Tweaking the max-updates, the number of encoding layers, the architecture, or the optimizer (e.g. transformer instead of adam) will provide different, and perhaps better results.  Doubling the encoder and decoder layers, or doubling the encoder and decoder dimensions to 256 slowed the processing time significantly, without improving the model in this case.  The training part of these experiments is meant to help us decide on which parameters we hope will yield the best results from *many* different options.\[[16](https://journal.code4lib.org/articles/#note16)\]  We’ll run this training several times with different parameters and choose three models.  The dev part (10%) of the experiment is meant to choose the model that performs the best on the dev set.  Lastly, confident on our model, we’ll use that model on the test set, as yet unseen data.

To determine how well each model is doing, we use fairseq-generate that provides us an error analysis that details where our model came up short.

| 1  2  3  4  5  6  7  8 | `fairseq``-``generate \`  `data``-``bin` `\`  `-``-``source``-``lang epo.g \`  `-``-``target``-``lang epo.p \`  `-``-``path checkpoints``/``checkpoint_best.pt \`  `-``-``gen``-``subset valid \`  `-``-``beam ``8` `\`  `predictions.txt` |
| --- | --- |

The generated error analysis in *predictions.txt* is quite readable and shows where the expected hypothesis may be different from its target sequence:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14 | `S``-``17`    `i k t i o s a ŭ r o`  `T``-``17`    `i k t i o s a w r o`  `H``-``17`    `-``0.14448021352291107`    `i k t i o s a w r o`  `D``-``17`    `-``0.14448021352291107`    `i k t i o s a w r o`  `S``-``824`    `e k s i ĝ o n t a j`  `T``-``824`    `e k s i d͡ʒ o n t a j`  `H``-``824`    `-``0.12416490912437439`    `e k s i d͡ʒ o n t a j`  `D``-``824`    `-``0.12416490912437439`    `e k s i d͡ʒ o n t a j`  `S``-``1085`    `k a p t o ŝ n u r o`  `T``-``1085`    `k a p t o ʃ n u r o`  `H``-``1085`    `-``0.15732990205287933`    `k a p t o ʃ n u r o`  `D``-``1085`    `-``0.15732990205287933`    `k a p t o ʃ n u r o` |
| --- | --- |

The rows in *predictions.txt* are **S**ource, **T**arget, **H**ypothesis (tokenized, meaning any punctuation symbols in a project with sentences would be space-separated), and **D**etokenized (not broken into separate linguistic units).  The number before the hypothesis is the log-probability of this hypothesis.  For our project, if the Target matches the Hypothesis, the model has predicted correctly.

We use a script written by Dr. Kyle Gorman to parse the output of fairseq-generate and provide a word error rate (WER).  Using this script, if any character is incorrect, the word error rate is raised.  As there should be no ambiguity in pronunciation and the conversion of a character to a sound, we expected that our model would perform near-perfectly.

Choosing the model that performed the best, we can now give the model the test data.  Predictably, on the test data, the word error rate was 0.00, a perfect score.

### Russian Stress

To explore how to add features to the model, we can look at experiments in Russian stress.  Features are properties of the target that may or may not help in prediction.  Features could include part of speech, frequency, animacy (whether a noun is sentient or not), or many other characteristics.

Similar to the Esperanto project above, we have columns with data in a TSV file.

**Table 3.** Example data from the TSV file from Schriner (2022).

| ямбам | я́мбам | 1 | ямб | N;Msc;Inan;Pl;Dat |
| --- | --- | --- | --- | --- |
| шихтовее | шихтове́е | 1 | шихтовой | A;Cmpar;Pred |
| щелкануть | щелкану́ть | 0 | щелкануть | V;Perf;Inf |
| иноки | и́ноки | 2 | инока | N;Fem;Anim;Pl;Nom |
| стёсанном | стёсанном | 2 | стесать | V;Perf;Der;Der/PstPss;A;Neu;AnIn;Sg;Loc |

The first column of data is the word with no stress markers.  The second column is the word with stress marked.  The third column is a stress code derived from the placement of the stress in the word: reversing the text in place and counting from 0 at the end of the word, each word was given a stress code; this data was added to the TSV as a column.  Only vowels in Russian may have stress, so deriving the stress code was simply a matter of counting vowels until a stress marker occurred.  «ё» is always stressed, so the script stops and assigns a code when an «ё» is discovered.  The fourth column is the word’s lemma (its root).  The fifth column contains the full morphology of the word including the word’s part of speech, the tense for those that are verbs, animacy, gender, grammatical number (whether a noun is singular or plural) and Russian case (e.g. nominative (Nom) case for the subject of the sentence, or dative (Dat) case for an indirect object of a sentence).  For the adjective (A) in Table 3, the word is comparative (Cmpar, as in *more*) and it functions as an adjective predicate (Pred), linked to the subject of the sentence.

In this paper we will not be processing this with Fairseq, but some promising results may be found in Schriner (2022).  This project is already significantly different from our Esperanto example in that stress in Russian has complicated patterns and ambiguous rules that will challenge a machine to place the stress correctly.  Incorrectly-stressed words may be unintelligible or prove more difficult to place correctly with the existence of stress homographs such as óрган ‘organ of the body’ and оргáн ‘organ’ (musical instrument) (Wade & Gillespie, 2011).

Similar to the Esperanto example, we have to format our text for Fairseq and sequence-to-sequence modeling.  To do this we’ll again have space-separated characters that we’ll convert to other space-separated characters.  From Table 3, the word иноки ‘others’ will be converted to и́ноки so our TSV file should have spaces: и н о к и will convert to и́ н о к и.  We want our machine to learn that given certain features we can expect a certain outcome in training.  The features in table 3 are: stress code, lemma (the root of the word), and the full morphology including part of speech.

We can create several experiments from this data including:

Given the word and its lemma, predict the stress code:

и н о к и **инока**  ← the feature added to the spaced-characters

2   ← the target will be the stress code, three vowels from the end starting at 0

Given the word and its part of speech, predict the stress code:

и н о к и **Noun**  ← the feature added to the spaced-characters

2   ← the target will be the stress code, three vowels from the end starting at 0

Given the word and all of its morphological properties, predict the stress code:

и н о к и **N;Fem;Anim;Pl;Nom**  ← the feature added to the spaced-characters

2   ← the target will be the stress code, three vowels from the end starting at 0

From the first experiment, the data in the TSV would be formatted like so, with the feature added to the end of the data in the first column, itself with no spaces:

**Table 4.** Formatting the TSV data.

| Source (Column 1) | Target (Column 2) |
| --- | --- |
| я м б а м ямб | 0 |
| ш и х т о в е е шихтовой | 1 |
| щ е л к а н у т ь щелкануть | 0 |
| и н о к и инока | 2 |
| с т ё с а н н о м стесать | 2 |

The same methods used in the Esperanto example could be used: we would train the model using Fairseq on 80% of the data so the model can learn that words like иноки with the root of инока would have a stress code of 2.  Once trained, we choose the model that performs best on the dev set (10%).  Then we use that model on completely unseen data in the test set (10%).  By examining and contrasting different experiments, we can see if knowing the word’s root helps in placement of the stress, or if adjectives tend to have stress in particular places, or possibly even that the ambiguity in stress-placement can not be aided with this type of machine-learning.  Experiments similar to these were conducted in Schriner (2022), showing that knowing the word’s root led to the best predictions and the lowest word error rate, while adding the part of speech feature led to the worst results and the highest word error rate.

## Conclusion

Preparing for experiments like those above require hypotheses, planning, and formatting the data for the software.  We used Fairseq and found that with our WikiPron data, the model we chose had no errors in predicting pronunciation in Esperanto, even with unseen data.  In the Russian stress experiment we looked at how to prepare data in the same way but added features to the model’s training.  The Fairseq framework makes it astonishingly easy to toggle and experiment with different parameters from the terminal and work on experiments like those described above.  With continued, collaborative, and open data, we can expect invaluable further research in this area.

*John Schriner* is the e-resources and digital initiatives librarian at NYU Law School. His research tends to coalesce at the intersection of linguistics, cybersecurity, and librarianship.

## References

Chen, H. (1995). Machine learning for information retrieval: Neural networks, symbolic learning, and genetic algorithms. *Journal of the American Society for Information Science*, *46*(3), 194–216. [https://doi.org/10.1002/(SICI)1097-4571(199504)46:3<194::AID-ASI4>3.0.CO;2-S](https://doi.org/10.1002/\(SICI\)1097-4571\(199504\)46:3%3C194::AID-ASI4%3E3.0.CO;2-S)

Lee, J.L., Ashby, L., Garza, E., Lee-Sikka, Y., Miller, S., Wong, A., McCarthy, A., and Gorman, K. (2020). Massively multilingual pronunciation mining with WikiPron. In *Proceedings of the 12th Language Resources and Evaluation Conference*, pages 4223-4228.

Open Data. (n.d.). SPARC. Retrieved November 29, 2022, from [https://sparcopen.org/open-data/](https://sparcopen.org/open-data/)

Ott, M., Edunov, S., Baevski, A., Fan, A., Gross, S., Ng, N,. Grangier, D., and Auli, M. (2019). fairseq: A fast, extensible toolkit for sequence modeling. In *Proceedings of the 2019 Conference of the North American Chapter of the Association for Computational Linguistics (Demonstrations)*, Minneapolis, Minnesota. Association for Computational Linguistics, (pp. 48-53).

Sanaullah, A. R., Das, A., Das, A., Kabir, M. A., & Shu, K. (2022). Applications of machine learning for COVID-19 misinformation: A systematic review. *Social Network Analysis and Mining*, *12*(1), 94. [https://doi.org/10.1007/s13278-022-00921-9](https://doi.org/10.1007/s13278-022-00921-9)

Schriner, J. (2022). Predicting stress in Russian using modern machine-learning tools. [https://academicworks.cuny.edu/gc\_etds/4974/](https://academicworks.cuny.edu/gc_etds/4974/)

Wade, T., & Gillespie, D. (2011). A comprehensive Russian grammar. Wiley-Blackwell.

Zhu, H., & Lei, L. (2022). A dependency-based machine learning approach to the identification of research topics: A case in COVID-19 studies. *Library Hi Tech*, *40*(2), 495–515. [https://doi.org/10.1108/LHT-01-2021-0051](https://doi.org/10.1108/LHT-01-2021-0051)

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] [https://voyant-tools.org/](https://voyant-tools.org/)  
\[[2](https://journal.code4lib.org/articles/#ref2)\] [https://www.nltk.org/](https://www.nltk.org/)  
\[[3](https://journal.code4lib.org/articles/#ref3)\] [https://www.fon.hum.uva.nl/praat/](https://www.fon.hum.uva.nl/praat/)  
\[[4](https://journal.code4lib.org/articles/#ref4)\] [https://www.liwc.app/](https://www.liwc.app/)  
\[[5](https://journal.code4lib.org/articles/#ref5)\] Meaning simply that the input and output are visible but the inner-workings and source code are closed  
\[[6](https://journal.code4lib.org/articles/#ref6)\] [https://towardsdatascience.com/understanding-random-forest-58381e0602d2](https://towardsdatascience.com/understanding-random-forest-58381e0602d2)  
\[[7](https://journal.code4lib.org/articles/#ref7)\] [https://data.nls.uk/](https://data.nls.uk/)  
\[[8](https://journal.code4lib.org/articles/#ref8)\] [https://dataverse.no/dataverse/trolling](https://dataverse.no/dataverse/trolling)  
\[[9](https://journal.code4lib.org/articles/#ref9)\] [https://www.re3data.org/](https://www.re3data.org/)  
\[[10](https://journal.code4lib.org/articles/#ref10)\] FairSeq can be installed via pip from [https://pypi.org/project/fairseq/](https://pypi.org/project/fairseq/)  
\[[11](https://journal.code4lib.org/articles/#ref11)\] This is specified in the preprocessing below  
\[[12](https://journal.code4lib.org/articles/#ref12)\] For a fascinating history of Esperanto from its beginnings through the early Soviet Union, please see Brigid O’Keeffe’s *Esperanto and Languages of Internationalism in Revolutionary Russia*, ‎2021, Bloomsbury Academic  
\[[13](https://journal.code4lib.org/articles/#ref13)\] [https://github.com/CUNY-CL/wikipron/blob/master/data/scrape/tsv/epo\_latn\_narrow.tsv](https://github.com/CUNY-CL/wikipron/blob/master/data/scrape/tsv/epo_latn_narrow.tsv)  
\[[14](https://journal.code4lib.org/articles/#ref14)\] This script is agnostic to the data-format and is written by Kyle Gorman and Jackson Lee.  The script can be found here: [https://github.com/CUNY-CL/wikipron-modeling/blob/master/scripts/split.py](https://github.com/CUNY-CL/wikipron-modeling/blob/master/scripts/split.py)  
\[[15](https://journal.code4lib.org/articles/#ref15)\] Intel Core i7-6700 CPU @ 3.40GHz × 8 with 32gb RAM  
\[[16](https://journal.code4lib.org/articles/#ref16)\] For all available parameters for training, please see: [https://fairseq.readthedocs.io/en/latest/command\_line\_tools.html#fairseq-train](https://fairseq.readthedocs.io/en/latest/command_line_tools.html#fairseq-train)
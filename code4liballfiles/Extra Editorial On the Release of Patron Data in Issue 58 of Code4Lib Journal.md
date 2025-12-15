---
title: "Extra Editorial: On the Release of Patron Data in Issue 58 of Code4Lib Journal"
source: "https://journal.code4lib.org/articles/18040"
author:
  - "editors"
published: 2024-02-05
created: 2025-01-10
description: "We, the editors of the Code4Lib Journal, sincerely apologize for the recent incident in which Personally Identifiable Information (PII) was released through the publication of an article in issue 58."
tags:
  - "#editorial"
---
# Extra Editorial: On the Release of Patron Data in Issue 58 of Code4Lib Journal
[Issue 58, 2023-12-04](https://journal.code4lib.org/issues/issues/issue58)

We, the editors of the Code4Lib Journal, sincerely apologize for the recent incident in which Personally Identifiable Information (PII) was released through the publication of an article in issue 58.

The article “[Bringing it All Together: Data from Everywhere to Build Dashboards](https://journal.code4lib.org/articles/17693)” linked to two Microsoft Power BI files containing circulation data.

## Timeline

This is a summary of events:

1. On Monday Dec 4, 2023, 11:28 PM EST, the article was published as part of issue 58 of the Code4Lib Journal.
2. On Tuesday Dec 5, 2023, 02:02 PM EST, a concerned reader emailed Code4Lib Journal to flag the inclusion of the files using the email address that appears on the journal’s website. Unfortunately, unknown to the current editors, that email account was not operational and, hence, no action was taken.
3. On Tuesday Dec 5, 2023, 02:40 PM EST, the author of the paper contacted its editor about the files; the editor removed the links to the files from the article at 02:49 PM EST.
4. On Tuesday Dec 5, 2023, 03:09 PM EST, the author of the paper asked its editor to remove the files from the server; the editor – who did not have email access at that time – removed them at 04:15 PM EST.
5. On Friday Dec 8, 2023, around 11:40 AM EST, another editor informed the editorial board about an [Open Letter](https://docs.google.com/document/d/1c-ADFaum9pB-W4AWQIxE6BPyVJs8goMlrVLoC00ucKc/preview) about the incident, which was announced on Mastodon. At the time of writing, the letter has 161 signatories.

## Statistics

During the time the files were online, they were accessed from 7 different IP addresses, with several accesses coming from the same IP addresses:

- Alma- Bibliographic Holdings Data.pbix
- 2023-12-04: 4 successful accesses (GETs with return code 200, and no failed access attempts)
- 2023-12-05: 6 successful accesses (GETs with return code 200), 3 failed attempts (GETs with return code 404)
- Alma- Circulation Statistics.pbix
- 2023-12-04: 5 successful accesses (GETs with return code 200, and no failed access attempts)
- 2023-12-05: 19 successful accesses (18 GETs, 1 HEAD, with return code 200), 3 failed attempts (2 HEADs, 1 GET, with return code 404)

The files were found not to have been cached by Google, Bing, Yandex, Yahoo, Ecosia, DuckDuckGo, and Internet Archive.

## Context

The released files were in a proprietary file format, Microsoft Power BI, with which none of the editors have experience. Since this article did not describe the actual content of the files, there was no immediate reason to believe they would contain PII. This was an erroneous assumption that the Code4Lib editors take full responsibility for.

The current editors were also unaware that the email account listed on the Code4Lib Journal website was not operational, slowing the notification of the editorial board, and causing the files to remain online for a longer period of time. This is another error that the editors take full responsibility for. The editorial board has since re-established access to this email address.

## Going Forward

We are determined to take greater measures to prevent similar incidents from occurring in future journal issues by improving the editorial process. Code4Lib operates without a budget, and with volunteer editors. This means that fully addressing the feedback we have received in a responsible and sustainable way will take time.

Effective immediately and until we can establish policies and procedures that better safeguard personal information, Code4lib Journal will not accept or publish papers that utilize individuals’ personal data. We will describe this change on the journal’s website and in the call for papers.

We invite colleagues who are knowledgeable in establishing relevant policies and procedures to support the Code4lib Journal by using their expertise to recommend sustainable guidelines that are informed by existing best practice, either independently or in the form of a journal article.

We are grateful to all of those who worked to raise this important issue and look forward to collaborating with the community on best practices going forward.

Monday February 5, 2024.

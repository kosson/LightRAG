---
title: "On Two Proposed Metrics of Electronic Resource Use"
source: "https://journal.code4lib.org/articles/16087"
author:
  - "William Denton"
published: 2021-09-22
created: 2025-01-10
description:
tags:
  - "#metrics"
---
# On Two Proposed Metrics of Electronic Resource Use

William Denton

\[The following is a slightly edited and revised version of the feedback given to the Code4Lib Journal Editorial team within a 24-hour timespan. The input was requested late Monday, with publication scheduled for the end of the workweek. Therefore, the feedback below is not comprehensive of the privacy, technical, data quality, assessment, and ethical concerns present in the article as it is published. This is primarily a public record of what the editorial committee had in hand when they decided to publish after their last-minute request for privacy feedback.\]

The feedback below is a combination of technical and data privacy factors that makes this proposed method of electronic resource use assessment of particular concern if published without additional context around risk and potential privacy harms to patrons (if published at all). Here’s a list of those factors in no particular order or rank of importance:

1\. Behavioral tracking – the article describes a process where several scripts clean up a daily log that (theoretically) is scrubbed daily and creates a CSV file that is kept for reporting purposes. The data in the CSV is not in the aggregate – the barcode or institutional user ID links a patron’s use of a platform. The article describes keeping these CSV files to create reports on the annual use of electronic resources, meaning that the library has a record of the daily behavior of identifiable patrons that otherwise would not exist.

2\. Lack of clear, explicit user consent and privacy policy issues – I have not had time to review York University Libraries’ privacy policy or the University privacy policy. However, if the policy allows for statistical analysis of aggregated user data, this particular use case would fail to meet that reserved right to use the data due to the identifiable data in the CSV. It could also be that patrons are not aware of behavioral tracking that is happening in this article. The article does not state if consent or notification was given to patrons.

3\. Unprotected identifiable data – this one is pretty self-explanatory. Storing CSVs that have identifiable information – barcode or institutional ID – tied to the use of library resources and materials is a privacy risk. One way of mitigating this risk is through pseudonymization of the patron PII to create a unique ID that breaks the direct link between behavior and identity; however, in this use case, I would argue that pseudonymization won’t do much in protecting patron privacy, leading to the next point…

4\. Re-identification risk due to assessment focus and characteristics of certain patron groups – we are looking at assessing the unique use of electronic resource platforms. Electronic resource platforms range from multidisciplinary (JSTOR) to niche, specialized areas of research. Even if you pseudonymize the barcode or institutional ID data, I can with some level of certainty identify individuals based on behavioral patterns based on the reports combined with a public school directory that contains major/minor concentrations or other public data sources available through the university or elsewhere. This assessment’s granularity and focus make it nearly impossible to use de-identification methods to mitigate privacy risks.

4.1 On a side note, transforming the barcode to the institutional ID makes this dataset even more identifiable and possible for misuse through secondary use of the dataset or improper access or combination of this dataset with another sensitive dataset on campus (and most likely without the student’s knowledge).

4.2 Side note #2 – The statement “It produces anonymized aggregate data with all personally identifiable information gone.” isn’t really true, even if you pseudonymized the barcode/institutional ID because the platform analysis is still granular enough that aggregation can’t protect the privacy of those using niche or specialized resources based on the number of patrons doing work in those areas.

4.3 Side note #3 – this is the obligatory reminder that proper anonymization is nearly impossible [https://georgetownlawtechreview.org/re-identification-of-anonymized-data/GLTR-04-2017/](https://georgetownlawtechreview.org/re-identification-of-anonymized-data/GLTR-04-2017/) is an excellent place to start. I can also get into the specifics of how l-diversity and k-anonymity can also point out the privacy risks with the dataset, but I’ll spare you the math!

5\. Report data lifecycle – according to the Privacy section of the article, “These reports can be kept and used after the source data has been wiped. Whether they are shared outside the library depends on institutional openness about collection usage statistics, but there are no user privacy reasons preventing it.” We still have the daily CSV reports hanging around. Where are they stored, who has access to them, and how long are they retained?

6\. Choice of assessment harmful to both desired assessment outcome and patron privacy – this is more of a concern in the area of “using data to address an issue that can be more effectively addressed with other methods that are less privacy-invasive.” Suppose we are interested in how patrons use specific resources or how different groups use these platforms. Why are we not talking to these patrons about their use of said resources? There are better ways to assess collection use than violating patron privacy through the process described in the article. In addition, other more qualitative research methods, such as interviews with students and faculty, can produce more meaningful data that can more accurately reflect the value of the databases in question since the value is not very easily derived through data alone without making dangerous and inaccurate assumptions about the use data itself. Flawed data leads to flawed assessment.
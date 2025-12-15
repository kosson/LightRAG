---
title: "Data reuse in linked data projects: a comparison of Alma and Share-VDE BIBFRAME networks"
source: "https://journal.code4lib.org/articles/15424"
author:
  - "Jim Hahn"
published: 2020-08-17
created: 2025-01-10
description: "This article presents an analysis of the enrichment, transformation, and clustering used by vendors Casalini Libri/@CULT and Ex Libris for their respective conversions of MARC data to BIBFRAME. The analysis considers the source MARC21 data used by Alma then the enrichment and transformation of MARC21 data from Share-VDE partner libraries. The clustering of linked data into a BIBFRAME network is a key outcome of data reuse in linked data projects and fundamental to the improvement of the discovery of library collections on the web and within search systems."
tags:
  - "#data/reuse"
  - "#Alma"
  - "#Share-VDE"
  - "#bibframe"
---
# Data reuse in linked data projects: a comparison of Alma and Share-VDE BIBFRAME networks
Jim Hahn

This article presents an analysis of the enrichment, transformation, and clustering used by vendors Casalini Libri/@CULT and Ex Libris for their respective conversions of MARC data to BIBFRAME. The analysis considers the source MARC21 data used by Alma then the enrichment and transformation of MARC21 data from Share-VDE partner libraries. The clustering of linked data into a BIBFRAME network is a key outcome of data reuse in linked data projects and fundamental to the improvement of the discovery of library collections on the web and within search systems.

## Introduction

Contemporary linked data implementation has been bolstered by several novel projects that use transformation and enrichment of MARC data to BIBFRAME graphs (Xu, Hess, & Akerman, 2018). The underlying catalyst in the contemporary wave of linked data implementations in libraries was BIBFRAME data model development and subsequent experimentation at the Library of Congress and the Program for Cooperative Cataloging (Naun, 2019). The spread and refinement of the BIBFRAME data model, which takes an inclusive approach to library description on the semantic web, has ushered in a new wave of modern experimentation and implementation for linked data enrichment of traditional cataloging records (Jin, Hahn, & Croll, 2016). Alternatively, non-BIBFRAME efforts at linked data implementation used Schema.org, a vocabulary first developed by major search engines for discovery of structured data on the web (Cole, Han, Weathers, & Joyner, 2013; Lampron, Mixter, & Han, 2016). An excellent Schema.org primer, “HTML5 Microdata and Schema.org,” appeared in the code4lib journal (Ronallo, 2012) along with several exemplar implementation cases (Clark & Young, 2015, 2017; Pekala, 2018; Wallis et al., 2017).

Projects such as the Share-VDE Linked Data Catalog (Samples & Bigelow, 2020) and linked data enrichment within the ExLibris Alma product are two examples of modern linked data implementation. These new implementations offer valuable insights into the road ahead for libraries transitioning to new linked data descriptions to provide enhanced discovery of collections. The purpose of this paper is first to analyze the source MARC data transformed and enriched within Alma using the University of Pennsylvania Alma and Alma Sandbox to present a case study for data analysis; and next, to evaluate the enrichment of source MARC data transformed to BIBFRAME graphs in the Share-VDE linked data catalog. The technical work in Share-VDE progresses from enrichment and transformation of MARC21 data from UPenn to clustering of linked data into a graph BIBFRAME network. The enriched, transformed, and clustered data from the Share-VDE catalog are then made available to UPenn Libraries in the MARC21 format and in BIBFRAME/RDF graphs. The linked data graphs are encoded with BIBFRAME RDF and also provide helpful provenance information using n-quads. Labeling an RDF subject, predicate, and object is a particular strength and use of the n-quad standard (W3C, 2014).

Share-VDE provides a linked data catalog to access the clustered Works, Agents, and Subjects. While Share-VDE comprises over 20 partner libraries, members can skin a linked data catalog. The skin provides a local look and feel to the catalog. And using additional APIs, the skin can interface with local requesting and catalog account features such as placing holds or accessing local e-resources. This localization does require additional configuration and depends on the APIs available in the implementing library’s Integrated Library System. A mockup of the University of Pennsylvania Share-VDE skin is shown in Image 1.

![Figure 1. Prototype screenshot for the bibliographic Work description sets by a given BIBFRAME Agent. Source: Filip Jakobsen](https://journal.code4lib.org/media/issue49/hahn/01.png "Figure 1. Prototype screenshot for the bibliographic Work description sets by a given BIBFRAME Agent. Source: Filip Jakobsen")

**Figure 1.** Prototype screenshot for the bibliographic Work description sets by a given BIBFRAME Agent. Source: Filip Jakobsen

## University of Pennsylvania Libraries: Alma BIBFRAME

Alma is the data source for metadata encoded in MARC in the University of Pennsylvania Libraries. Alma provides a BIBFRAME record consisting of Work and Instance data for each MARC metadata record in the system. A grid view of the XML analyzed through Oxygen XML Editor is shown in Image 2.

![Figure 2. Grid View of Alma BIBFRAME XML illustrating Work and Instance entities that are associated with an Alma MARC record.](https://journal.code4lib.org/media/issue49/hahn/02.png "Figure 2. Grid View of Alma BIBFRAME XML illustrating Work and Instance entities that are associated with an Alma MARC record.")

**Figure 2.** Grid View of Alma BIBFRAME XML illustrating Work and Instance entities that are associated with an Alma MARC record.

Alma enrichment and conversion for BIBFRAME relies on the Library of Congress MARC2BIBFRAME2 code (Library of Congress, 2020a). The BIBFRAME record is shown under a linked data tab for the bibliographic record, as seen in Image 3.

![Figure 3. A screenshot of the linked data tab entitled “BIBFRAME” in the University of Pennsylvania’s Alma Sandbox. Source: Alma](https://journal.code4lib.org/media/issue49/hahn/03.png "Figure 3. A screenshot of the linked data tab entitled “BIBFRAME” in the University of Pennsylvania’s Alma Sandbox. Source: Alma")

**Figure 3.** A screenshot of the linked data tab entitled “BIBFRAME” in the University of Pennsylvania’s Alma Sandbox. Source: Alma

The resulting transformation produces Instance level data about the bibliographic record, and within the same record tab, related Work data. Work descriptions, as presented in the Alma interface, are not associated with a Superwork bibliographic description such as a BIBFRAME Hub or in Share-VDE, an Opus. An example of the emerging LC Hub entity, a type of superwork, can be seen in image 4.

![Figure 4. A recent approach to modeling the Library of Congress Hub (or lc:hub), an example of a Superwork. In this case the Library of Congress Hub is a type of Work entity set.](https://journal.code4lib.org/media/issue49/hahn/04.png "Figure 4. A recent approach to modeling the Library of Congress Hub (or lc:hub), an example of a Superwork. In this case the Library of Congress Hub is a type of Work entity set.")

**Figure 4.** A recent approach to modeling the Library of Congress Hub (or lc:hub), an example of a Superwork. In this case the Library of Congress Hub is a type of Work entity set.

The superwork is defined differently in various vocabularies, in much the same way that no universal work bibliographic description exists. However, “a superwork may contain any number of works as subsets, the members of which while not sharing essentially the same information content are nevertheless similar by virtue of emanating from the same ur-work“ (Svenonius, 2000, p. 38). According to Alma documentation (ExLibris, 2020a) available on the web, “Alma groups several BIB record into a single Work based on the bibliographic information,” with features available on request for clustering MARC items descriptions under a shared bibliographic Work description; however, “the work grouping logic is not implemented by default. Institutions that are interested in this functionality should contact ExLibris and ask for it. For institutions that did not ask to implement it, each BIB record will be considered as having its own Work”(Ex Libris, 2020a).

BIBFRAME records in Alma contain URIs as linked data that are not present in the source MARC stored in Alma. The URIs in Alma BIBFRAME records include:

- [Library of Congress Authorities](http://id.loc.gov/authorities/subjects.html)
- [MeSH](https://www.ncbi.nlm.nih.gov/mesh/)
- [VIAF](http://viaf.org/)
- [Integrated Authority File, the German National Library’s Gemeinsame Normdatei (GND)](https://www.dnb.de/EN/Professionell/Standardisierung/GND/gnd_node.html)
- [GeoNames](https://www.geonames.org/)
- Local to Ex Libris URIs
- Ex Libris Work IDs
- Ex Libris Agent IDs

Alma’s FAQ on standards does indicate record support for BIBFRAME: “the ‘General publishing profile’ in Alma includes an option to publish in BIBFRAME format. Alma will support the importing of catalog records in BIBFRAME format, allowing BIBRAME formatted records to be easily and seamlessly made part of the Alma catalog, regardless of the cataloging format in which it is managed” (ExLibris, 2020b).

Linked data created externally to Alma can be imported into the system. The Sinopia linked data editor is the “cloud-based environment for original metadata creation,” the work product from the LD4P2 grant project (LD4P2, 2020). The Sinopia code base continues to evolve over several iterations and was initially built upon a hard fork of code that made up the Library of Congress BIBFRAME Editor or BFE, described as “a simple tool that enables input of any BIBFRAME vocabulary element,” (Library of Congress, 2020b). Catalogers can make native RDF BIBFRAME records from this system. The Sinopia editor is not integrated into Alma. But Sinopia BIBFRAME data can be exported as JSON-LD and includes URIs for Instance and Work record descriptions, among others, which can bring in the relevant data needed to undertake transformation from BIBFRAME into MARC. The process is illustrated in image 5.

![Figure 5. The data flows from Sinopia RDF through the BIBFRAME2MARC code and in the final stage imports MARC to Alma.](https://journal.code4lib.org/media/issue49/hahn/05.png "Figure 5. The data flows from Sinopia RDF through the BIBFRAME2MARC code and in the final stage imports MARC to Alma.")

**Figure 5.** The data flows from Sinopia RDF through the BIBFRAME2MARC code and in the final stage imports MARC to Alma.

The Library of Congress released [BIBFRAME2MARC code](https://github.com/lcnetdev/bibframe2marc) in May 2020 (Library of Congress, 2020c), making the transformation from a BIBFRAME record possible. However, to account for the Sinopia namespace, developers created the helpful processing code [RDF2MARC](https://github.com/sul-dlss-labs/rdf2marc) while working under the LD4P2/3 grants at Stanford. After conversion to MARC21 or MARCXML, the record can then be imported to Alma. A possible output of the newly launched LD4P3 grant project led by Stanford and Cornell with funding from Mellon may make it possible to connect directly to an ILS or export MARC from Sinopia, thus obviating the need for the transformation shown in image 5.

## Share-VDE BIBFRAME Graphs

The Share-VDE hosted Stardog database provides access to UPenn’s linked data. The implementation of Share-VDE graphs uses n-quads, which can be viewed record by record in a file archive provided to UPenn. The query shown in Image 6 for the record’s MMSID (unique identifier in Alma) will return all associated graph URIs for cluster analysis.

![Figure 6. Stardog Studio retrieval from Share-VDE n-quad query of all graphs related to a bibliographic identifier. Source: Stardog Studio](https://journal.code4lib.org/media/issue49/hahn/06.png "Figure 6. Stardog Studio retrieval from Share-VDE n-quad query of all graphs related to a bibliographic identifier. Source: Stardog Studio")

**Figure 6.** Stardog Studio retrieval from Share-VDE n-quad query of all graphs related to a bibliographic identifier. Source: Stardog Studio

The Stardog Studio offers a visual node explorer. The example graph exploration in Image 7 illustrates Work nodes related to a subject “School Sports – Fiction.” The center in this example graph is where we can see work relationships pointing to this identifier. Share-VDE clustering technologies aspire to model the deep interconnections among data in the records and among other related records in its database. Whether Alma clusters linked data among other libraries’ works is unclear and not yet observed from the Alma backend that an institution can access. Perhaps clusters do exist elsewhere in Ex Libris graph databases that power other parts of their infrastructure such as Summon or a larger index. The URIs in Share-VDE (last update Feb 2020):

- [ID.LOC.GOV/vocabulary/geographicAreas](https://id.loc.gov/)
- [ISNI](https://isni.org/)
- [VIAF](http://viaf.org/)
- [LCNAF](http://id.loc.gov/authorities/names)
- [Library of Congress Subject Headings](https://id.loc.gov/authorities/subjects.html)
- [FAST](https://www.oclc.org/research/areas/data-science/fast.html)
- [ORCID](https://orcid.org/)
- [Integrated Authority File, the German National Library’s Gemeinsame Normdatei (GND)](https://www.dnb.de/EN/Professionell/Standardisierung/GND/gnd_node.html)
- Local [Share-VDE](https://www.share-vde.org/) URIs;
- Share-VDE Author ID; Share-VDE Publisher Entity ID; Share-VDE Work ID

![Figure 7. Stardog visualization functionality. Source: Stardog Studio](https://journal.code4lib.org/media/issue49/hahn/07.png "Figure 7. Stardog visualization functionality. Source: Stardog Studio")

**Figure 7.** Stardog visualization functionality. Source: Stardog Studio

Sample Share-VDE Stardog Data as XML Graph

## Importing Share-VDE enriched MARC21 into the Penn Alma Sandbox

The URIs in Share-VDE above are also found in the Share-VDE of the Penn MARC21 enriched with URIs. A sample of the UPenn Share-VDE MARC21 enrichment was loaded into the Penn Alma Sandbox. This experiment aimed to understand what, if any, discovery gains may be achieved by reuse of the Share-VDE enriched MARC21. To view MARC, MarcEdit’s mnemonic format was used in displaying human readable MARC. For more background on the mnemonic format, see the helpful documentation at The MarcEdit Field Guide (Reese, 2020).

Share-VDE Enriched MARC21(w/URIS)

\=LDR 02458ngm a22004693i 4500  
\=001 9977142688903681  
\=005 20160817151618.0  
\=006 m|||||o||c||||||||  
\=007 cr\\|n||||||||a  
\=007 vz\\|za|z|  
\=008 160817s2007\\\\\\\\cau002\\e\\\\\\\\\\|o\\\\\\v|eng\\d  
\=035 \\\\$a(VaAlASP)AVONASP3241241/marc  
\=035 \\\\$a(OCoLC)AVON957520113  
\=040 \\\\$aVaAlASP$beng$erda$cVaAlASP  
\=245 00$aDocumentation.$pEssentials of Nursing Documentation.$pHealth Care Plan $h\[electronic resource\] /$c\[produced by MedCom, Inc.\].  
\=264 \\1$a\[Cypress, California\] :$bMedcom,$c\[2007\]$9http://share-vde.org/sharevde/rdfBibframe/Publisher/1144933  
\=300 \\\\$a1 online resource (2 minutes)  
\=306 \\\\$a000143  
\=336 \\\\$atwo-dimensional moving image$btdi$2rdacontent$0http://rdaregistry.info/termList/RDAContentType/1023  
\=337 \\\\$avideo$bv$2rdamedia$0http://rdaregistry.info/termList/RDAMediaType/1008  
\=337 \\\\$acomputer$bc$2rdamedia$0http://rdaregistry.info/termList/RDAMediaType/1002  
\=338 \\\\$aother$bvz$2rdacarrier  
\=338 \\\\$aonline resource$bcr$2rdacarrier$0http://rdaregistry.info/termList/RDACarrierType/1018  
\=347 \\\\$adata file$2rda  
\=500 \\\\$aTitle from resource description page (viewed August 19, 2016).  
\=506 \\\\$aRestricted for use by site license.  
\=520 \\\\$aThis instructional video, from the Documentation series produced by MedCom, Inc., is about the documentation of health care plans.  
\=546 \\\\$aIn English.  
\=650 \\0$aNursing records.$0http://id.loc.gov/authorities/subjects/sh85093417  
\=650 \\0$aNursing care plans.$0http://id.loc.gov/authorities/subjects/sh85093387  
\=650 \\0$aMedical records$xManagement.$0http://id.loc.gov/authorities/subjects/sh85083015  
\=650 \\0$aCommunication in nursing.$0http://id.loc.gov/authorities/subjects/sh85029081  
\=655 \\7$aInstructional films.$2lcgft  
\=655 \\7$aFilm excerpts.$2lcgft  
\=710 2\\$aAlexander Street Press.$1http://isni.org/isni/0000000122177075  
\=710 2\\$aMedcom, inc.,$eproduction company.$1http://viaf.org/viaf/146569313  
\=740 0\\$aAcademic Video Online.  
\=758 \\\\$4http://rdaregistry.info/Elements/m/P30004$1http://worldcat.org/oclc/957520113  
\=856 40$uhttp://hdl.library.upenn.edu/1017.12/1929840$zConnect to streaming video  
\=996 10$aDocumentation. Essentials of Nursing Documentation. Health Care Plan$9http://share-vde.org/sharevde/rdfBibframe/Work/11033735-1  
\=997 10$aUPENN  
\=999 8\\$bweb $h-

From the enriched MARC sample loaded into the Penn Alma Sandbox, it did not appear that Alma supported a 1-to-1 import of URIs in MARC. Specifically, for the sample of records the 996-field containing a Share-VDE work ID was not imported into the Alma system. Note that the 900s are not defined in the MARC21 standard, and vendors use them for local purposes. Several important URIs such as added entries do get added to the BIBFRAME linked data record in Alma. Associating multiple work identifiers in BIBFRAME is possible, but in the version of Alma “merge on match” the Share-VDE work IDs in 996 did not merge with the Linked Data/BIBFRAME Record within Alma.

Without a corresponding discovery load into Blacklight, evaluating improvements to discovery gains using Alma imports are not possible at UPenn. The Penn Libraries discovery layer to Alma does not use Primo, but rather Blacklight as its front-end to discovery. A separate test Blacklight instance that indexed MARC entity URIs as compared to non-URI enhanced MARC could provide a comparative analysis of discovery relative to enrichment. This experiment for indexing the Work entity ID associated with an MMSID in the UPenn Blacklight/Lucene is in the planning stages.

In the early 2000s a set of now classic MARC usage evaluations from Moen and others demonstrated the “ground truth” metrics (Tennant, 2016) of MARC utilization. The Blacklight testing of Work IDs takes an inclusive approach to linked data implementation by revisiting and extending MARC studies to inform a comparative Blacklight study, evaluating retrieval within a Blacklight index using “linky”-MARC and the same corpus of MARC records encoded with “non-linky” MARC. The premise of “linky-MARC” is the transitional notion of incorporating entity URIs into MARC records (Wallis, 2018).

Moen and Benardino (2003, p. 171) demonstrated that “…less than 5% of available content designation accounts for 80% of occurrences.” This finding underscores the need for intelligent and measured indexing and discovery of MARC; namely, that not all fields must be treated with equivalent indexing importance in the process of making descriptions of bibliographic works discoverable. The present study focused on work entity URIs containing Work IDs in “linky”-MARC and contrasted the retrieval to a non-enriched MARC index of the same corpus.

## Evaluation of Share-VDE enriched MARC for consistency with the PCC guidance for URIs in MARC

The use of subfields $0 and $1 in the enriched MARC from Share-VDE were evaluated for consistency, with recent PCC guidance from the September 12, 2019 report “PCC Task Group on Linked Data Best Practices Final Report” and the corresponding MARC Object Table (Library of Congress, 2019). A baseline report of the enriched Share-VDE MARC21, which was generated with MarcEdit and then plotted with Tableau, showed the nature of MARC fields, used $0 and $1, and is shown in Image 8 and Image 9.

![Figure 8. $1 URIs from Penn Share-VDE enriched MARC. Source: Author](https://journal.code4lib.org/media/issue49/hahn/08.png "Figure 8. $1 URIs from Penn Share-VDE enriched MARC. Source: Author")

**Figure 8.** $1 URIs from Penn Share-VDE enriched MARC. Source: Author

The set of records in Table 1 uses $1 URIs primarily within 100s (Main Entry) and the 758 (Resource Identifier) fields. Regarding the added entry fields: 700 (Added Entry-Personal Name), 710 (Added Entry-Corporate Name), and 758 (Resource Identifier). PCC Guidelines for $1 in these fields recommend that the identifier in $1 must always be a URI. The occurrences in the sample conform. For the 758 fields above, proper guidance for the use of $4 was also observed. The 758 field, according to the PCC guidance, can be used for work or resource identifiers (Library of Congress, 2019, p. 18).

![Figure 9. $0 URIs from Penn Share-VDE enriched MARC. Source: Author](https://journal.code4lib.org/media/issue49/hahn/09.png "Figure 9. $0 URIs from Penn Share-VDE enriched MARC. Source: Author")

**Figure 9.** $0 URIs from Penn Share-VDE enriched MARC. Source: Author

The 650 field contains the most usage of the enriched MARC $0 subfield. Guidelines from the PCC Marc Object Table for the 650 (Subject Added Entry – Topical Term) allow for the $0 to be used here, however, guidance suggests use of “$0 only if the entire heading is established. Do not provide $0 for parts of the heading.” A meta-analysis of 650 URIs in Image 7 found that this sample conforms with PCC best practice guidelines.

## Evaluation of Penn MARC Alma samples for consistency with the PCC guidance for URIs in MARC

A sample of 50,000 Alma MARC records available from the [Penn Open Data website](https://www.library.upenn.edu/collections/digital-projects/open-data-penn-libraries) was used for evaluating Alma data. Benchmarks were created to understand if and where the uses of $0 and $1 exist in Alma. In a sample of 50,000 records, no $1 subfields were in use by Penn MARC records included in this evaluation. The $0 subfields did have uses in the 600s (Subject Access fields) and 880s (Alternate Geographic Field) for a total of 693 uses in the sample of 50,000. Baseline metrics are delineated in Image 10. The preponderance of $0 can be found in 650 (Subject Added Entry – Topical Term) followed by 655 (Index Term – Genre/Form) and 651 (Subject Added Entry – Geographic Name) fields.

![Figure 10. $0 subfields in a selection of Alma MARC records at Penn.](https://journal.code4lib.org/media/issue49/hahn/10.png "Figure 10. $0 subfields in a selection of Alma MARC records at Penn.")

**Figure 10.** $0 subfields in a selection of Alma MARC records at Penn.

## Share-VDE Enrichment and Clustering Supporting Penn Discovery on the Web: Schema.org

Reusing linked data from Share-VDE enrichment and clustering processes, it is feasible to add linked data into the HTML elements of the Work page descriptions in Blacklight. This may result in additional discovery gains for records searched from Google and the World Wide Web. An example of a JSON-LD data implementation for HTML records follows. This example is not from an existing webpage, rather it is an implementation model verified as valid JSON-LD through [Google’s Structured Data Testing tool.](https://search.google.com/structured-data/testing-tool)

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23 | `<script type="application/ld+json">`  `{`  `"@graph": [{`  `"@type": "Book",`  `"name": "Hamlet : text of the play, the actors’ gallery, contexts, criticism, afterlives, resources",`  `"bookEdition": "Second Edition",`  `"numberOfPages": "338",`  `"author":{`  `"@type": "Person",`  `"name": ["William Shakespeare ; edited by Robert S. Miola"],`  `},`  `"publisher": {`  `"@type": "Organization",`  `"name": "W.W. Norton & Company",`  `},`  `}]`  `}`  `</script>` |
| --- | --- |

Book actions ([https://developers.google.com/search/docs/data-types/book](https://developers.google.com/search/docs/data-types/book)) are emergent Schema.org descriptions for search engines that may provide a more optimal experience for borrowing print and e-books on the web. The book actions will appear through existing knowledge panels on the web. Libraries can register their interest to pilot book actions from the data type link above.

## Streamlining Alma Reports

Large Alma publishing is resource and time intensive. It may be possible to replicate certain Alma reports that pose bottlenecks due to Alma cloud throttling of large reports. A UPenn PostgreSQL database hosted locally may be able to address these bottlenecks by setting up an indexing and query service. In such a circumstance delta imports must be made based on the progression of MMSID integers in the Alma system relative to the PostgreSQL enriched JSON database.

The enriched MARC21 from Share-VDE has been converted to JSON using MarcEdit. With some configuration to line-by-line JSON, it is possible to load the enriched data into PostgreSQL using the JSONb, the preferred, and more feature rich indexing data type for additional analysis and evaluation. The JSON output from MarcEdit was further transformed using the JQ software tool so that the JSON array would span one line. For more information on JQ see: [https://formulae.brew.sh/formula/jq](https://formulae.brew.sh/formula/jq)

Flattening a JSON record array into one line was accomplished with the following command:

| 1 | `jq -c '.[]' output-Upenn_Biblio_01.json \| awk '{print > "file_01.json"}'` |
| --- | --- | --- |

The JSON can be added to a PostgreSQL table using the JSONb data type, and a modification of the csv importing command to simulate row based importing that csv commands afford.

| 1 | `\copy {table-name} from 'file_01.json' csv quote e'\x01' delimiter e'\x02'` |
| --- | --- |

Example table load was found here: [http://adpgtech.blogspot.com/2014/09/importing-json-data.html](http://adpgtech.blogspot.com/2014/09/importing-json-data.html).

Following data load, a simple index on JSON fields in PostgreSQL can be processed over the enriched library data:

| 1 | `CREATE INDEX idxgintags ON allmarc3 USING GIN ((marc -> 'fields'));` |
| --- | --- |

Next, it is possible to query the Postgres Index on JSONb data using keyword search. The example query below is establishing a set of records that contain an 880 field.

| 1 | `select * from allmarc3 where marc->>'fields' like '%880%';` |
| --- | --- |

![Figure 11. Retrieval of JSONb enriched MARC records through a PostgreSQL keyword query. Source: pgAdmin 4](https://journal.code4lib.org/media/issue49/hahn/11.png "Figure 11. Retrieval of JSONb enriched MARC records through a PostgreSQL keyword query. Source: pgAdmin 4")

**Figure 11.** Retrieval of JSONb enriched MARC records through a PostgreSQL keyword query. Source: pgAdmin 4

This workflow can provide local data persistence with indexing and retrieval in both the enriched MARC, and if desired, the n-quads from Share-VDE; both can be loaded and indexed in a persistent database under local control. Indexing n-quads under a local triple store can better achieve the goals of linked data by maintaining the enriched BIBFRAME graph in a graph database such as Blazegraph, used by Wikibase.

## Locally hosted Wikibase of enriched n-quads from Share-VDE

Wikibase docker images ([https://github.com/wmde/wikibase-docker](https://github.com/wmde/wikibase-docker)) are a promising tool for hosting enriched linked data graphs locally, within the UPenn Library data infrastructure. OCLC used this infrastructure for Project Passage (Godby et al., 2019). The OCLC infrastructure for linked data will likely continue to use Wikibase for the Mellon Funded Entity Management Project. An opportunity exists to reuse the Wikidata properties for ongoing Linked Data Research at the Libraries, offering several advantages, including avoiding vendor lock-in and ensuring local control over Penn linked data.

The Wikibase infrastructure offers the possibility to retain Share-VDE records locally and to act as a backbone for continued experimentation. A local Wikibase instance of Share-VDE n-quads alleviates concerns of possible vendor lock-in of n-quads in the Stardog Database hosted by Share-VDE. Finally, there may be ways to reuse the n-quads from Share-VDE (e.g. Superwork to Work clustering) for informing clustering of catalog data outside of Share-VDE.

![Figure 12. Share-VDE Author ID property in Wikidata. Source: Wikidata](https://journal.code4lib.org/media/issue49/hahn/12.png "Figure 12. Share-VDE Author ID property in Wikidata. Source: Wikidata")

**Figure 12.** Share-VDE Author ID property in Wikidata. Source: Wikidata

Wikibase software can support the increased production of links among UPenn scholarship, collections, and the broader web of linked data. Recent studies have pointed to the importance of Wikimedia content to search engines/discovery on the web writ large (Vincent & Hecht, 2020). The use of Wikibase knowledge graphs in recommender systems development can serve to promote library content (Tsuji, 2019). Linked data offers some advantages over big data for providing personalization/recommender services (Campbell & Cowan, 2016); e.g. recommendations are based on structured knowledge not personal data mining. Reusing existing knowledge structures is preferable to creating personalized data stores from which to derive a recommendation system, especially in libraries.

## Discussion

This section ties together the preceding data reuse activities within a common, overarching long-term outcome: improving discovery of Penn library collections. Using a logic model framework, Table 1 offers a delineation of the above activities that coalesce around the long-term goals focused on increased discoverability. Logic models identify the anticipated outcomes based on resources, activities, and outputs of organizations (Schryvers, 2020). As a goal like improved discovery is a difficult long-term outcome to assess, it helps to create short-term (Julian, Jones, & Deyo 1995) and mid-term outcomes of discovery improvements in which the libraries can collect measurable metrics from activities and understand if the outputs from resources and outputs are serving the intended effects.

Table 1. Liked data logic model: Penn Libraries Linked Data Short-Term, Mid-Term, and Long-Term Outcomes

| Resources | Activities | Outputs | Short-term Outcomes | Mid-term Outcomes | Long-term Outcomes |
| --- | --- | --- | --- | --- | --- |
| 1\. Linked Data Team  2\. Sinopia / BIBFRAME Editor Group  3\. Discovery Team  4\. LD4 Affinity Group Participation  5\. Wikibase/OCLC Project Entity Management Group Participation | 1\. Share-VDE Catalog Development  2\. BIBFRAME Editor/ Sinopia Training, Original RDF Data Creation  3\. Blacklight tests of Work Entity IDs in Franklin  4\. BIBFRAME Editor + Data Flow Improvements (LD4P3 affinity groups)  5\. OCLC Entity Management API testing, Wikibase PCC Project Participation | 1\. Share-VDE Record Enrichment  1.a. Share-VDE Linked Data Penn Catalog  2\. Original RDF Linked Data from BIBFRAME Editor  3\. Work Entities in Franklin  4\. Improved BIBFRAME Editors and Data Flow  5\. OCLC Entities API Data  5.a. Wikidata PCC Project | 2: Professional staff familiarity with Sinopia, Linked Data, and BIBFRAME.  1, 2, 5: Local Penn Wikibase supporting RDF Data Persistence of Linked Data from Share-VDE enrichment, original RDF creation, OCLC Entities API Data | 2: Professional staff expertise with BIBFRAME Editors, Linked Data Models (LRM, RDA), and BIBFRAME.  2, 3, 4: Alma load of select MARC records transformed from BIBFRAME Editor.  1, 3, 5: Integrate Share-VDE Interface into Library Discovery; Bento Box of Share-VDE Catalog; Indexing in Blacklight to target Work Entity URIs from Share-VDE; OCLC; and/or BIBFRAME Editor Work Data. | 1, 2, 3, 4, 5: Enhance discovery of Penn Collections |

Teams involved in this work represent internal resources along with external Linked Data Projects. The internal Penn linked data team continues to evaluate the efficacy of the Share-VDE linked data catalog and shares membership with a Discovery Strategic Project team whose goals include integration of the Share-VDE linked data catalog into the Libraries’ [Bento Search Layout](https://franklin.library.upenn.edu/). Integration of the linked data catalog into library search results will affect the long-term outcome of linked data implementation.

The Penn Libraries is beginning a mixed methods evaluation incorporating log studies and remote user testing of interviews and observation to understand how semantic search fits into the search process. Log studies (Jansen, 2006; Peters, 1993) are quantitative measures that provide great insights and empirical evidence. Quantitative studies (Mischo et al., 2012; Lown et al., 2013; Dougan, 2018) can inform new hypothesis development that qualitative measures of interviews (McKay et al., 2019) and observation are better able to address.

The emerging research agenda at Penn on semantic interfaces aims to evaluate user tasks as articulated in IFLA’s Library Reference Model (LRM). The LRM harmonized several ontologies (e.g. FRBR, FRAD, FRSAD) with distinct perspectives and aims. An underappreciated section developed in the reference model is the detail devoted to supporting user tasks (Riva, Le Boeuf, & Žumer, 2017). User tasks are “…the ends of any bibliographic system” (Dousa, 2018). Žumer (2017, para 9) wrote that the “…LRM defines five user tasks : Find, Identify, Select, Obtain, Explore. The tasks are listed in an order that reflects typical user behavior, which does not mean that all tasks need to be performed and that they cannot be repeated. Particularly identify and obtain often occur in parallel and in interaction.” Previous user research into discovery findings and the LRM user tasks informed semantic search hypothesis development. The hypothesis generation process necessarily involves turning LRM tasks into research questions, and understanding open questions in discovery research—a selection of which is shown in Table 2.

Table 2. Selected IFLA LRM tasks (Riva, Le Boeuf, & Žumer, 2017)

| Selected LRM Exemplar Tasks | Find  “… all expressions of a work that are written in a given language” (p.97) | Identify  “… a personal name that corresponds to the person sought by the user, even though other people are identified by similar names” (p.98) | Explore  “… relationships in order to understand the structure of a subject domain and its terminology” (p.99) |
| --- | --- | --- | --- |
| Semantic Interface  Hypothesis | Expressions of a Work in each language can be easily ascertained in a semantic interface search result page. | Name disambiguation is supported in semantic search results. | Semantic interfaces  support relationship exploration in a subject domain (e.g. browsing). |

## Conclusion

Ongoing and sustained reuse of linked data are a fundamental component of improving library discovery operations. Outside of the University of Pennsylvania Libraries, collaborative approaches to developing Wikibase-focused, persistent structured data, and future tracking of the newly funded OCLC Project Entity Management work will extend Penn Resources and Penn Linked Data with web-based knowledge graphs. An integrated linked data strategy with discovery and web strategic projects will help to further Penn Libraries’ overall goals for increasing the visibility of Penn resources on the web and within library search systems.

## About the author

Jim Hahn ([https://orcid.org/0000-0001-7924-5294](https://orcid.org/0000-0001-7924-5294)) is the Head of Metadata Research at the University of Pennsylvania Libraries leading linked data and metadata projects and research for the Libraries. Working collaboratively across the Libraries, his work is developing a vision for the services, technologies and policies to enhance discovery of collections, following international standards and best practices for linked data and metadata.

## References

Campbell, D. G., & Cowan, S. R. (2016). The paradox of privacy: Revisiting a core library value in an age of big data and linked data. Library Trends, 64(3), 492–511. [https://doi.org/10.1353/lib.2016.0006](https://doi.org/10.1353/lib.2016.0006)

Clark, J. A., & Young, S. W. H. (2015). Building a better book in the browser (using semantic web technologies and HTML5). The Code4Lib Journal, 29. [https://journal.code4lib.org/articles/10668](https://journal.code4lib.org/articles/10668)

Clark, J. A., & Young, S. W. H. (2017). Linked data is people: Building a knowledge graph to reshape the library staff directory. The Code4Lib Journal, 36. [https://journal.code4lib.org/articles/12320](https://journal.code4lib.org/articles/12320)

Cole, T. W., Han, M. J., Weathers, W. F. & Joyner, E. (2013). Library MARC records into linked open data: Challenges and opportunities. Journal of Library Metadata, 13(2–3), 163–196. [https://doi.org/10.1080/19386389.2013.826074](https://doi.org/10.1080/19386389.2013.826074)

Dougan, K. (2018). The “black box”: How students use a single search box to search for music materials. Information Technology and Libraries, 37(4), 81–106. [https://doi.org/10.6017/ital.v37i4.10702](https://doi.org/10.6017/ital.v37i4.10702)

Dousa, T. (2018, December 5). The IFLA LRM model: A brief introduction \[Video\]. YouTube. [https://youtu.be/PMGP1KhRLKQ](https://youtu.be/PMGP1KhRLKQ)

ExLibris (2020a). BIBFRAME. Ex Libris Knowledge Center. [https://developers.exlibrisgroup.com/alma/integrations/linked\_data/bibframe/](https://developers.exlibrisgroup.com/alma/integrations/linked_data/bibframe/)

ExLibris (2020b). Standards. Ex Libris Knowledge Center. [https://knowledge.exlibrisgroup.com/Alma/Product\_Materials/050Alma\_FAQs/General/Standards](https://knowledge.exlibrisgroup.com/Alma/Product_Materials/050Alma_FAQs/General/Standards)

Godby, J., Smith-Yoshimura, K., Washburn, B., Davis, K., Detling, K., Fernsebner Eslao, K., Folsom, S., Li, X., McGee, M., Miller, K., Moody, H., Tomren, H., & Thomas, C. (2019). Creating library linked data with Wikibase: Lessons learned from project passage. Dublin, OH: OCLC Research. [https://doi.org/10.25333/faq3-ax08](https://doi.org/10.25333/faq3-ax08)

Jensen, B. J. (2006). Search log analysis: What it is, what’s been done, how to do it. Library & Information Science Research, 28(3), 407–432. [https://doi.org/10.1016/j.lisr.2006.06.005](https://doi.org/10.1016/j.lisr.2006.06.005)

Jin, Q., Hahn, J., & Croll, G. (2016). BIBFRAME transformation for enhanced discovery. Library Resources and Technical Services, 60(4), 223–235. [https://doi.org/10.5860/lrts.60n4.223](https://doi.org/10.5860/lrts.60n4.223)

Julian, D. A., Jones, A., & Deyo, D. (1995). Open systems evaluation and the logic model: Program planning and evaluation tools. Evaluation and Program Planning, 18(4), 333–341. [https://doi.org/10.1016/0149-7189(95)00034-8](https://doi.org/10.1016/0149-7189\(95\)00034-8)

Lampron, P., Mixter, J., & Han, M. J. (2016). Challenges of mapping digital collections metadata to Schema.org: Working with CONTENTdm. In E. Garoufallou, I. S. Coll, A. Stellato, & J. Greenberg (Eds.), Metadata and Semantics Research – 10th International Conference, MTSR 2016, Proceedings (pp. 181–186). Switzerland: Springer-Verlag. [https://doi.org/10.1007/978-3-319-49157-8\_15](https://doi.org/10.1007/978-3-319-49157-8_15)

LD4P2 (2020). Sinopia user group. Linked data for production: Pathway to implementation. [https://wiki.lyrasis.org/display/LD4P2/Sinopia+User+Group](https://wiki.lyrasis.org/display/LD4P2/Sinopia%2BUser%2BGroup)

Library of Congress (2019). PCC Task group on linked data best practices final report. Program for cooperative cataloging > Task groups. [https://www.loc.gov/aba/pcc/taskgroup/linked-data-best-practices-final-report.pdf](https://www.loc.gov/aba/pcc/taskgroup/linked-data-best-practices-final-report.pdf)

Library of Congress (2020a). marc2bibframe2. Network development and MARC standards office. [https://github.com/lcnetdev/marc2bibframe2](https://github.com/lcnetdev/marc2bibframe2)

Library of Congress (2020b). Using the BIBFRAME editor. BIBFRAME: Implementation, tools, and downloads. [https://www.loc.gov/bibframe/implementation/bfe-howtouse.html](https://www.loc.gov/bibframe/implementation/bfe-howtouse.html)

Library of Congress (2020c). bibframe2marc. Network development and MARC standards office. [https://github.com/lcnetdev/bibframe2marc](https://github.com/lcnetdev/bibframe2marc)

Lown, C., Sierra, T., & Boyer, J. (2013). How users search the library from a single search box. College & Research Libraries 74(3), 227-241. [https://doi.org/10.5860/crl-321](https://doi.org/10.5860/crl-321)

McKay, D., Chang, S., Smith, W., & Buchanan, G. (2019). The things we talk about when we talk about browsing: An empirical typology of library browsing behavior. Journal of the Association for Information Science & Technology, 70(12), 1383–1394. [https://doi.org/10.1002/asi.24200](https://doi.org/10.1002/asi.24200)

Mischo, W. H., Schlembach, M. C., Bishoff, J., & German, E. M. (2012). User search activities within an academic library gateway: Implications for web-scale discovery systems. In M. P. Popp & D. Dallis (Eds.), Planning and implementing resource discovery tools in academic libraries (pp. 153–173). Hershey, PA: IGI Global. [https://doi.org/10.4018/978-1-4666-1821-3.ch010](https://doi.org/10.4018/978-1-4666-1821-3.ch010)

Moen, W. E., & Benardino, P. (2003). Assessing metadata utilization: An analysis of MARC content designation use. DCMI International Conference on Dublin Core and Metadata Applications, 171–180. [https://dcpapers.dublincore.org/pubs/article/view/745](https://dcpapers.dublincore.org/pubs/article/view/745)

Naun, C. (2019). Expanding the use of linked data value vocabularies in PCC cataloging. Cataloging & Classification Quarterly, 1–9. [https://doi.org/10.1080/01639374.2019.1705953](https://doi.org/10.1080/01639374.2019.1705953)

Pekala, S. (2018). Microdata in the IR: A low-barrier approach to enhancing discovery of institutional repository materials in Google. The Code4Lib Journal, 39. [https://journal.code4lib.org/articles/13191](https://journal.code4lib.org/articles/13191)

Peters, T. A. (1993). The history and development of transaction log analysis. Library Hi Tech, 11(2), 41–66. [https://doi.org/10.1108/eb047884](https://doi.org/10.1108/eb047884)

Reese, T. (2020). The MarcEdit field guide. \[Chapter 4: Editing my first set of records\] [http://marcedit.reeset.net/learning\_marcedit/welcome-to-marcedit/chapter-3-editing-my-first-record/2/](http://marcedit.reeset.net/learning_marcedit/welcome-to-marcedit/chapter-3-editing-my-first-record/2/)

Riva, P., Le Boeuf, P., & Žumer, M. (2017). IFLA library reference model: A conceptual model for bibliographic information. [https://www.ifla.org/files/assets/cataloguing/frbr-lrm/ifla-lrm-august-2017\_rev201712.pdf](https://www.ifla.org/files/assets/cataloguing/frbr-lrm/ifla-lrm-august-2017_rev201712.pdf)

Ronallo, J. (2012). HTML5 Microdata and Schema.org. The Code4Lib Journal, 16. [https://journal.code4lib.org/articles/6400](https://journal.code4lib.org/articles/6400)

Samples, J., & Bigelow, I. (2020). MARC to BIBFRAME: Converting the PCC to linked data. Cataloging & Classification Quarterly, 1–15. [https://doi.org/10.1080/01639374.2020.1751764](https://doi.org/10.1080/01639374.2020.1751764)

Schryvers, P. (2020). Bad data: Why we measure the wrong things and often miss the metrics that matter. Guilford, CN: Prometheus Books.

Svenonius, E. (2000). The intellectual foundation of information organization. Cambridge, MA: MIT Press.

Tennant, R. (2016). “Ground truthing” MARC. Hanging Together.org. [https://hangingtogether.org/?p=5648](https://hangingtogether.org/?p%3D5648)

Tsuji, K. (2019). Book recommender system for Wikipedia article readers in a university library. 2019 8th International Congress on Advanced Applied Informatics (IIAI-AAI), 121–126. [https://doi.org/10.1109/IIAI-AAI.2019.00034](https://doi.org/10.1109/IIAI-AAI.2019.00034)

Vincent, N., & Hecht, B. (2020). A deeper investigation of the importance of Wikipedia links to the success of search engines. arXiv:2004.10265 [https://arxiv.org/abs/2004.10265](https://arxiv.org/abs/2004.10265)

W3C (2014). RDF 1.1 N-Quads: A line-based syntax for RDF datasets. W3C Recommendation. [https://www.w3.org/TR/n-quads/](https://www.w3.org/TR/n-quads/)

Wallis, R., Isaac, A., Charles, V., & Manguinhas, H. (2017). Recommendations for the application of Schema.org to aggregated cultural heritage metadata to increase relevance and visibility to search engines: The case of Europeana. The Code4Lib Journal, 36. [https://journal.code4lib.org/articles/12330](https://journal.code4lib.org/articles/12330)

Wallis, R. (2018). MARC and beyond: Our three linked data choices, Paper presented at: IFLA WLIC 2018 – Kuala Lumpur, Malaysia – Transform Libraries, Transform Societies in Session 113 – Information Technology, [http://library.ifla.org/id/eprint/2124](http://library.ifla.org/id/eprint/2124)

Xu, A., Hess, K. & Akerman, L. (2018). From MARC to BIBFRAME 2.0: Crosswalks. Cataloging & Classification Quarterly, 56(2–3), 224–250. [https://doi.org/10.1080/01639374.2017.1388326](https://doi.org/10.1080/01639374.2017.1388326)

Žumer, M. (2017). IFLA library reference model (LRM): Harmonisation of the FRBR family. ISKO Encyclopedia of Knowledge Organization. [http://www.isko.org/cyclo/lrm](http://www.isko.org/cyclo/lrm)
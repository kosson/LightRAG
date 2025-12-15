---
title: "Converting the Bliss Bibliographic Classification to SKOS RDF using Python RDFLib"
source: "https://journal.code4lib.org/articles/18073"
author:
  - "Harry Bartholomew"
published: 2024-10-08
created: 2025-01-10
description: "This article discusses the project undertaken by the library of Queens’ College, Cambridge, to migrate its classification system to RDF applying the SKOS data model using Python. Queens’ uses the Bliss Bibliographic Classification alongside 18 other UK libraries, most of which are small libraries of the colleges at the Universities of Oxford and Cambridge. Though a flexible and universal faceted classification system, Bliss faces challenges due to its unfinished state, leading to the evolution in many Bliss libraries of divergent, in-house adaptations of the system to fill in its gaps. For most of the official, published parts of Bliss, a uniquely formatted source code used to generate a typeset version is available online. This project focused on converting this source code into a SKOS RDF linked-data format using Python: first by parsing the source code, then using RDFLib to write the concepts, notation, relationships, and notes in RDF. This article suggests that the RDF version has the potential to prevent further divergence and unify the various Bliss adaptations and reflects on the limitations of SKOS when applied to complex, faceted systems."
tags:
  - "clippings"
---
# Converting the Bliss Bibliographic Classification to SKOS RDF using Python RDFLib

Harry Bartholomew

## Background of the Bliss Bibliographic Classification

The second edition of the Bliss Bibliographic Classification (BC2) is a universal, fully faceted, highly synthetic classification system used in 19 English libraries, the first schedules of which were published in 1977. Though microscopic when viewed on the scale of Dewey Decimal (DDC) and Library of Congress (LCC) classification systems in terms of the number of libraries using the scheme, 11 of the Bliss-classified libraries are found within the collegiate universities of Oxford and Cambridge, making BC2 a competitive alternative to DDC and LCC in these academic library communities. Often chosen to replace simple enumerative in-house classification systems at Oxbridge college libraries in the 1980s-90s, Bliss’s synthesisability and granularity responded to the obstacles to browsing these imposed in the pre-computerised and early computerised periods of library catalogues, and it served a double purpose as a source for subject terminology in bibliographic records ( [^1] Sargent 1990) ( [^2] Watson 1997).

Bliss allows for the synthesis of classmarks from multiple through a process it terms retroactive notation, explained thus on the official website:

> *The classifier must first analyse the subject of the work, then arrange the components, or facets, of the subject into the reverse order of the BC2 schedule, going from the most specific to the most general facet. The classmarks for each facet are then combined by dropping the repeated initial class letter from all but the first. This technique is called retroactive notation. As BC2’s citation order is inverted, the facet cited first actually comes last in the schedules*—( [^3] Bliss Classification Association : BC2 : Using the scheme)

For example, in the Philosophy & Logic schedule, **ACO B** is the class for subjectivism and **AHK** for ethics, so ethical subjectivism would have the synthesised classmark **AHK COB**. The idea here is that the schedule need not repeat itself by enumerating every possible classmark; instead, a more specific class can always be subdivided by the more general aspects preceding it, thus allowing an incomprehensibly vast number of potential notation and subject combinations from a reasonably sized list of concepts.

1977 saw the first volumes of BC2 published, however work on the system continues as many schedules are still only available as unfinished drafts. While efforts of the Bliss Classification Association (BCA)—the editorial body comprising Bliss users and supporters—focus on finalising the unpublished schedules, those finished decades ago have a growing need for maintenance. Its incompleteness and partial outdatedness have led to divergence in the application of the classification scheme between libraries, with significant in-house patches having been developed by individual libraries inconsistent with their fellow Bliss-users.

The first published Bliss schedules were manually typed and photographed for publication, though a machine-readable encoded form was later developed alongside software to generate a formatted schedule and index from the encoded data ( [^4] The way we were: Development of the printed schedules in BC2 2007). Figure 1 shows an extract from the final published version of the Class A – AL: Philosophy & Logic schedule and figure 2 shows the source code from which it was generated. The two digits preceding the node label indicate the indentation on the published page used to show the hierarchy of concepts. The indentation bullets in figure 1 do not equal the number in the source code; each column must have indentation relative within itself, and a header at the top of each column shows the current location in the concept hierarchy.

![Figure 1: section from published schedule Class A – AL: Philosophy & Logic](https://journal.code4lib.org/media/issue59/bartholomew/figure1.png)

**Figure 1.** section from published schedule Class A – AL: Philosophy & Logic

![Figure 2: extract of source file used to generate the formatted version shown in figure 1.](https://journal.code4lib.org/media/issue59/bartholomew/figure2.png)

**Figure 2.** extract of source file used to generate the formatted version shown in figure 1.

The BC2 source code adheres to an idiosyncratic schema which allows for the generation of properly typeset and indexed schedule to be used by classifiers. The structure of the source code can be summarised in the following way:

- The file must be written in the order of the notation.
- Each concept begins a new line with its notation as the first character, or with @ if there is no notation for the concept.
- The notation is followed by one or more spaces.
- The first 2 digits following the notation and spaces denote the length of the indentation on the page.
- The indentation numbers are followed by the labels used for the concept, each separated by a comma.
- The labels can be enclosed in a pair of matching brackets, indicating the node’s category:
- )inverted parentheses( show a “brought-down” class, meaning that the concept is first defined earlier in the schedule, but reappears at this point subsumed under a specific parent class.
- (normal parentheses) indicate that this node represents a facet
- ((double parentheses)) indicate a node introducing an array of classes
- The visibility of a concept in the schedule, thesaurus or index is controlled by a singular closing square bracket followed by the initial of the output in which the label is not to be visible.
- E.g. in the following snippet, the labels for the alphabetical ranges for classifying named but unlisted 17th-century British philosophers will not appear in the index or the thesaurus:

```txt
ADS             0917th century ]IT
ADSE            10)British philosophy(
ADSECY          11((Schools & doctrines))
ADSED           12Cambridge Platonists
@               11((Individual philosophers))
ADSEF           12A - Bac ]IT
ADSEG           12Bacon F
ADSEH           12Bac - Hob ]IT
ADSEJ           12Hobbes T
ADSEK           12Hob - Loc ]IT
ADSEL           12Locke J
ADSEM           12Loc - Z ]IT
```
- New lines beginning with spaces followed by an asterisk indicate a note; \*SN indicates a scope note; \*\* precedes comments.
- Labels and notes can continue multiple lines.

One can easily draw parallels between this source code format for classification data and MARC for cataloguing. Roy Tennant, in his influential and well-cited Library Journal denunciation, “MARC must die,” explains that “MARC and AACR2 are largely focused on capturing the paper catalogue card in computer form” and bases his critique on the format’s inconsistent granularity, limited applicability, and relative obsolescence in the face of XML ( [^5] Tennant 2002). In like fashion, the BC2 source code’s aim to digitally reproduce the printed schedule limits its extensibility, and its flat unitary structure impedes the systematic expression of relationships between concepts. The software developed and used by the BCA to parse the source code is not openly available, and so the hitherto focus on the end product (the published schedule as a physical volume or an inflexible PDF) has withheld useful editorial capabilities from the classifiers at Bliss-using libraries, who, anecdotally, often rely on handwritten annotations to the volumes to record their local applications of and updates to the system.

## Aim and objectives

The library of Queens’ College, Cambridge, needed a more robust system than handwritten annotations and printed addenda to manage its classification. Queens’ converted to Bliss in 1988, relying in large part on draft schedules to cover the unpublished subject areas ( [^6] Sargent 1990: 11). Subsequent librarians have updated and revised the system and logged these changes with varying diligence. Schedule annotations indicated, where Bliss offers alternatives in notation and structure, which variant is locally used. Annotations also revised offensive and prejudicial terminology and hierarchies ( [^7] Bartholomew 2023). Where sections of the system were deemed too granular for our purposes, ticks and crosses showed which classes were to be used. For subjects still without an official BC2 schedule, printed in-house classification systems were kept in ring binders, and these too were more often revised by hand rather than by editing and reprinting the documents. Schedule indexes were not consistently updated with revisions, leading classifiers looking up terms in the index to obsolete parts of the schedule. When changes were made to the system, reclassification projects were limited to the open-access collection only, meaning books in closed-access stores are arranged according to an older version of the system. As books are routinely relegated to storage, the closed-access shelves follow a disorganised shelving order according to multiple versions of the system. Further to this, Queens’ had no consistent system to record the components of its synthesised classes, having ceased to use Bliss class labels as subject vocabulary in bibliographic records, and so a revision to a class’s notation was difficult to implement as there was no complete index to show which books’ classmarks used the old notation in its synthesised form. Lastly, and importantly, Queens’ classifiers cannot be sure whether the classmark assigned at a fellow Bliss library for a particular book is valid for the same book in the local system, as system revisions in one or both libraries could have led to a divergence; therefore, copy-classifying is severely hindered.

The objectives of an encoded classification system for Queens’ College thus were:

- Replicate the structure of the source code, avoiding the loss of any information encoded in the original file.
- Allow for the generation of a formatted and indexed schedule, both in print and electronic form, from the encoded form.
- Use persistent identifiers for concepts in the scheme, so that links can be expressed between: (1) different classification systems and variants; (2) bibliographic metadata and the classification system; (3) a synthesised classmark and its components.
- Enable a form of version control logging changes to notations and labels so that the origin of a particular classmark can always be traced.

## SKOS-RDF structure

The Simple Knowledge Organisation System (SKOS) is a model for use in RDF that standardly encodes a traditional thesaurus, taxonomy, or classification hierarchical structure. A SKOS concept can have a preferred and alternative label, a notation, various types of notes, and expressions of broader, narrower and related concepts.

Development of SKOS began in 2006, and soon its potential use for Bliss was discussed in the Bliss Classification Bulletin. Alistair Miles ( [^8] 2006), whilst making the case for SKOS-encoding, pointed out that “currently there is no built-in support for the synthesis of conceptual units to represent compound meanings” (p.11). Leonard Will ( [^9] 2008) also observes the limitation of SKOS for encoding Bliss, whose schedules “show examples of pre-coordination” but “users are expected to create others as required. SKOS can not yet encode this type of structure”. This remains true of SKOS in 2024.

Despite this limitation, SKOS was still chosen as the data model for this project. An OWL ontology categorising concepts more granularly and defining more particular potential relationships between concepts could be developed for Bliss, which could then define the node categories indicated by the enclosing parentheses as well as encode visibility of labels in the index and thesauri. However, as the published version of Bliss still adheres to a traditional hierarchical classification structure, it is entirely possible to replicate the hierarchy in SKOS; further to this, polyhierarchical relationships are expressible in SKOS, and so a compound class could be a narrower concept of multiple concepts from different branches of the schedule.

SKOS, owing its eponymous simple nature, has a small vocabulary, and it was applied to Queens’ classification as follows:

| skos: ConceptScheme | Each Bliss schedule is considered a separate skos:ConceptScheme, owing to the fact that the principle of retroactive notation applies only within a schedule, and compounding between schedules is only sometimes permitted. Also, Queens’ in-house schedules adhere to separate compounding rules. |
| --- | --- |
| skos:Concept | Every node in a schedule is a skos:Concept, regardless of whether it has a notation; notationless nodes are necessary to describe the structure of the hierarchy and separate arrays for different facets. |
| skos:inScheme | Every concept is linked to its ConceptScheme. |
| skos:prefLabel | The first label in a list of comma-separated values for each node is treated as the preferred label. |
| skos:altLabel | All subsequent labels are included as alternative labels for the concept. |
| skos:broader | Every child concept has its parent concept as a broader term. |
| skos:topConceptOf | Concepts without a parent concept are linked to the concept scheme as a top concept. |
| skos:note | Basic notes following a label. |
| skos:editorialNote | Used for source code comments. |
| skos:scopeNote | Used for notes defined as scope notes in the source file. |

These do not represent the full range of the SKOS vocabulary; some classes and properties were deemed superfluous to requirements; others could not be encoded automatically based on the source file data.

### Implicit inversion

Pairs of SKOS URIs are inversions of one another, e.g. if A is broader than B, then it follows that B is narrower than A; if X is the top concept of the Y concept scheme, then Y has X as a top concept. To avoid redundancy and for consistency, the hierarchy is expressed in only one direction throughout, narrowest to broadest.

### Transitivity

The SKOS broader/narrower relationships are neither inherently transitive nor intransitive; they merely express immediate hierarchical relationships. While transitivity can be explicitly expressed with skos:broader/narrowerTransitive properties, the potential benefits of this are unclear and it could be that an explicit declaration of transitivity may turn out to be problematic in places.

### Collections

SKOS concepts can be collected into arrays using the skos:Collection and skos:OrderedCollection classes, in which the concepts would be members. In some ways, this would usefully reflect the nature of the array nodes enclosed in double parentheses in the source file. However, array nodes are treated similarly to ordinary classes in the source file structure, where they are the narrower term of the parent concept and the broader term of the array of child concepts. As skos:Collection is disjoint with skos:Concept, the children would need to be narrower terms of the concept above the array node, thus disrupting the established hierarchical structure indicated in the source file. Some array and facet nodes also have a notation and could therefore be used as a concept, or in a synthesised class. Therefore, collections were not used in this automatic conversion, but could be useful in future revisions if it is decided that the hierarchical structure ought to be altered.

### Notes

The source file distinguishes only three types of note which can be systematically converted, though other subproperties of skos:note would be useful. A `skos:historyNote` would serve when revising the system, and notes acting as definitions for the class ideally would be separated from notes advising on its usage within the system.

## Parsing the source file with Python and RDFLib

### Imports and constants

```python
from rdflib import Graph, RDF, Literal, Namespace
from rdflib.namespace import SKOS
 
ex = Namespace("http://example.org")
g = Graph()
```

The only imported library is RDFLib, from which five objects used:

- rdflib.Graph is the web of nodes and relationships which is eventually serialised into Turtle format in this project
- rdflib.RDF is the RDF vocabulary
- rdflib.Literal is the rdfs:literal property (i.e. strings and integers) for use when the datatype must be specified
- rdflib.Namespace allows for generation of URIs with a common prefix
- rdflib.namespace.SKOS is a readily available SKOS namespace

The Queens’ classification is not yet available on the web and so a placeholder namespace is used in this project temporarily. This still allows the resulting Turtle file to be visualised and aid local classification.

### Creating the concept scheme

```python
def parse_source_file(file_path):
    with open(file_path, ’r’) as file:
        g.add((ex[""], RDF.type, SKOS.ConceptScheme))
```

The first class added is the concept scheme, which currently creates a bare node to which top-level concepts can be linked:

```xml
<http://example.org> a skos:ConceptScheme .
```

This will need to be named and described before the classification is hosted online.

### Parsing the file

The source file is read line-by-line, however the challenge lay in the fact that node labels and notes can, and often do, span multiple lines.

```python
def identify_line(line): 
    if line[0] != " ":
        return "new node"
    if line.strip()[0] == "*":
        return "new note"
    else:
        return "continued"
```

If a new line begins with a non-space character (either the notation or an “@” to indicate no notation), it is a new node, and each note always begins with an “\*”. If neither of these conditions are true, it is assumed that the line continues its predecessor. A new node is assigned a URI suffix consisting of a 4 digit suffix to the namespace indicating its order in the source file. Unlike the Integrated Levels Classification (ILC) which was also migrated to SKOS ( [^10] Binding et al. 2021), Bliss notations are not unique identifiers: the same notation, or no notation at all, can apply to multiple classes, hence the need for arbitrary generation of identifiers.

### Structuring the hierarchy

Another way in which BC2 differs from ILC is Bliss’ dissonance between its hierarchy and its notation. Where in ILC, “crucially, the hierarchical structure of the classification was inferred from the letter sequence of the notational codes” ( [^11] Binding et al. 2021: 933), a Bliss child concept could have a briefer notation than its parent class, e.g. BGY is the notation for electricity & magnetism, yet BH is the notation for its child concept electromagnetism. The hierarchy of concepts must therefore be inferred from the numerical indentation indicator from the source file, and is tracked using a Python dictionary, starting as:

```python
hierarchy = {0: "root"}
```

Then, narrower concepts are added to this dictionary as the parsing progresses, with their indentation number as the key and their URI as the term.

```python
def create_hierarchy(hierarchy, uri, line):
    def extract_indentation(line):
        return int(line.split()[1][:2])</p>
 
    indentation = extract_indentation(line)
    hierarchy[indentation] = uri
    if indentation == 1:
        g.add((uri, SKOS.topConceptOf, ex[""]))
    else:
        broader_uri = hierarchy[indentation - 1]
    g.add((uri, SKOS.broader, broader_uri))
    return hierarchy
```

Anything with an indentation of 1 is a `skos:topConceptOf` the concept scheme, and those further down the hierarchy have their parent concept’s URI added with a skos:broader relationship.

### Adding rdfs:literal properties to nodes

3 types of literal properties can be added to each node: labels, notation, and notes. The notation is easily extracted, with “@” interpreted as an absence of notation.

The string of characters between the indentation indicator and the subsequent note or node is the label string, consisting of a list of comma-separated labels that can have enclosing brackets, denoting its “category”, or a final closing square bracket, providing instructions for the visualisation of the classification schedule and index or inform on the origin or type of the concept. The information these brackets convey are not encodable in SKOS alone, but the bracket type is kept in a skos:editorialNote so that any future interpreter can make use of it. The labels, extracted from any brackets are added to each node, with the first in the list being the preferred label, and following labels as alternative labels. Notes are then added with their preceding asterisks removed.

## Output

The output of this conversion process is a Turtle file. The output of the sections shown in figures 1-2 is:

```ttl
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
 
<http://example.org/0045> a skos:Concept ;
skos:broader <http://example.org/0022> ;
skos:editorialNote "("@en,
                   "Facet"@en ;
skos:inScheme <http://example.org> ;
skos:note "These are defined by period & place and are therefore
           only found within a particular broad tradition. See AD 
           Western philosophy & AI Oriental philosophy."@en ;
skos:prefLabel "Historical schools of philosophy"@en .
 
<http://example.org/0047> a skos:Concept ;
skos:broader <http://example.org/0046> ;
skos:inScheme <http://example.org> ;
skos:notation "AAFB" ;
skos:note "See explanatory notes & examples at AG."@en,
          "Very little, if anything, will locate here."@en ;
skos:prefLabel "Comprehensive works on branches of philosophy"@en .
 
<http://example.org/0048> a skos:Concept ;
skos:broader <http://example.org/0046> ;
skos:inScheme <http://example.org> ;
skos:notation "AAFD" ;
skos:note "General studies only; see notes at AAF."@en ;
skos:prefLabel "Metaphilosophy"@en .
 
<http://example.org/0049> a skos:Concept ;
skos:broader <http://example.org/0046> ;
skos:inScheme <http://example.org> ;
skos:notation "AAGG" ;
skos:prefLabel "Metaphysics"@en .
 
<http://example.org/0050> a skos:Concept ;
skos:broader <http://example.org/0049> ;
skos:inScheme <http://example.org> ;
skos:notation "AAGH" ;
skos:prefLabel "Ontology"@en .
 
<http://example.org/0051> a skos:Concept ;
skos:broader <http://example.org/0049> ;
skos:inScheme <http://example.org> ;
skos:notation "AAGM" ;
skos:prefLabel "Cosmology"@en .
 
<http://example.org/0052> a skos:Concept ;
skos:broader <http://example.org/0049> ;
skos:inScheme <http://example.org> ;
skos:notation "AAGQ" ;
skos:prefLabel "Special topics in metaphysics"@en .
 
<http://example.org/0053> a skos:Concept ;
skos:broader <http://example.org/0046> ;
skos:inScheme <http://example.org> ;
skos:notation "AAGR" ;
skos:prefLabel "Epistemology"@en .
 
<http://example.org/0054> a skos:Concept ;
skos:broader <http://example.org/0046> ;
skos:inScheme <http://example.org> ;
skos:notation "AAGW" ;
skos:prefLabel "Philosophy of language & logic"@en .
 
<http://example.org/0055> a skos:Concept ;
skos:broader <http://example.org/0046> ;
skos:inScheme <http://example.org> ;
skos:notation "AAHD" ;
skos:prefLabel "Philosophy of mind &amp; action"@en .
 
<http://example.org/0056> a skos:Concept ;
skos:broader <http://example.org/0046> ;
skos:inScheme <http://example.org> ;
skos:notation "AAHJ" ;
skos:prefLabel "Axiology"@en .
 
<http://example.org/0057> a skos:Concept ;
skos:broader <http://example.org/0056> ;
skos:inScheme <http://example.org> ;
skos:notation "AAHK" ;
skos:prefLabel "Ethics"@en .
 
<http://example.org/0058> a skos:Concept ;
skos:broader <http://example.org/0056> ;
skos:inScheme <http://example.org> ;
skos:notation "AAHP" ;
skos:prefLabel "Aesthetics"@en .
 
<http://example.org/0059> a skos:Concept ;
skos:broader <http://example.org/0046> ;
skos:inScheme <http://example.org> ;
skos:notation "AAHR" ;
skos:note "Alternative (not recommended) to locating with subject."@en,
          "Not restricted to one broad tradition. Even if this option is
           used most of the literature will go at AHR (where instructions 
           for use are given)."@en .
skos:prefLabel "Philosophy of particular subjects (general)"@en ;
```

## Achievements, limitations, and future directions

This project provides a method for converting Bliss source files into RDF using the SKOS data model. This has so far only been used internally at Queens’ College Library, and while other Bliss-using libraries are welcome to download the RDF version or even convert the files themselves using this code (or an adapted version of it), the full benefits of an RDF-encoded linked classification system can only be realised when the URIs become URLs, i.e. accessible via the Internet, and ideally with an API endpoint.

SKOS alone is arguably too simple for Bliss, and a more complex ontology is needed to extend the basic hierarchical classification structure. Many properties encoded as rdfs:literal in a skos:note inform the classifier of how the class can be used to build compound classmarks; defining Bliss-specific properties and relationships between concepts could make this standardised and machine-readable.

A further limitation is that the documentation for the Bliss source file format provides more flexibility in formatting than is outlined here. The Python code used for conversion assumes that a particular standard has been followed, though does not account for valid variants that may be used in other schedules’ source files. The code will need to be edited to accommodate conversions of such files.

Consistent with the source files, but a hindrance for linked data, is the lack of relationship between the nodes of “brought down” classes and their origin. Given the polyhierarchy permitted in SKOS, an altered structure could see the children of brought down classes as narrower concepts of both their parent class, but from earlier in the schedule, and their grandparent class. For example, in the source file snippet featuring 17th-century British philosophers above, ADSED: Cambridge Platonists could be restructured as a narrower term of both ADS: 17th century Western philosophy and ADQ E: British philosophy, though this might entail label changes (figure 3).

![Figure 3: current simple hierarchical structure compared with a proposed polyhierarchical structure](https://journal.code4lib.org/media/issue59/bartholomew/figure3.jpg)

**Figure 3.** current simple hierarchical structure compared with a proposed polyhierarchical structure

It is hoped that Queens’ RDF classification will eventually incorporate links to an official Bliss RDF version. Where there has been a schism from Bliss orthodoxy, the SKOS mapping properties can be used to show the matches and variations between the standard and local versions.

## Bibliography

[^7]: Bartholomew H. 2023. Obsolete orders: the need to reclassify Queens’ War Memorial Library. Queens’ College Old Library Blog. [https://queenslib.wordpress.com/2023/05/15/obsolete-orders-the-need-to-reclassify-queens-war-memorial-library/](https://queenslib.wordpress.com/2023/05/15/obsolete-orders-the-need-to-reclassify-queens-war-memorial-library/).

[^10]: [^11]: Binding C, Gnoli C, Tudhope D. 2021. Migrating a complex classification scheme to the semantic web: expressing the Integrative Levels Classification using SKOS RDF. JD. 77(4):926–945. doi:[10.1108/JD-10-2020-0167](https://doi.org/10.1108/JD-10-2020-0167).

[^3]: Bliss Classification Association : BC2 : Using the scheme. \[accessed 2024 May 17\]. [https://www.blissclassification.org.uk/bcclass.shtml](https://www.blissclassification.org.uk/bcclass.shtml).

[^8]: Miles A. 2006. Simple knowledge organisation and the semantic web. The Bliss Classification Bulletin.(48):10–13. [https://www.blissclassification.org.uk/B48.pdf#page=10](https://www.blissclassification.org.uk/B48.pdf#page=10)

[^1]: [^6]: Sargent C. 1990. Classifying the undergraduate collection at Queens’ College, Cambridge. The Bliss Classification Bulletin. (32):10–12. [https://blissclassification.org.uk/B32-1990.pdf#page=10](https://blissclassification.org.uk/B32-1990.pdf#page=10)

[^5]: Tennant R. 2002. MARC must die. Library Journal. 127(17):26–27. [https://www.libraryjournal.com/story/marc-must-die](https://www.libraryjournal.com/story/marc-must-die)

[^4]: The way we were: Development of the printed schedules in BC2. The Bliss Classification Bulletin. 2007. (49):17–22. [https://www.blissclassification.org.uk/B49.pdf#page=18](https://www.blissclassification.org.uk/B49.pdf#page=18)

[^2]: Watson R. 1997. Quincentenary Library, Jesus College, Cambridge. The Bliss Classification Bulletin.(39):14–16. [https://www.blissclassification.org.uk/B39.pdf#page=14](https://www.blissclassification.org.uk/B39.pdf#page=14)

[^9]: Will L. 2008. Bliss on the Web. \[accessed 2024 Feb 25\]. [https://www.blissclassification.org.uk/BlissOnTheWeb.pdf](https://www.blissclassification.org.uk/BlissOnTheWeb.pdf).

Harry Bartholomew ([harrybartholomew.github.io](https://harrybartholomew.github.io/)) is a Librarian with systems responsibilities at the Royal Institute of International Affairs, London, United Kingdom. Until June 2024 he was the Reader Services Librarian at Queens’ College, University of Cambridge.

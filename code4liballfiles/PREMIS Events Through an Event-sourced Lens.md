---
title: "PREMIS Events Through an Event-sourced Lens"
source: "https://journal.code4lib.org/articles/17264"
author:
  - "Spencer Ross"
published: 2023-04-21
created: 2025-01-10
description: "The PREMIS metadata standard is widely adopted in the digital preservation community. Repository software often include fully compliant implementations or assert some level of conformance. Within PREMIS we have four semantic units, but “Events”, the topic of this paper, are particularly interesting as they describe “actions performed within or outside the repository that affects its capability to preserve Objects over the long term.” Events can help us to observe interactions with digital objects and understand where and when something may have gone wrong with them. Events in PREMIS, however, are slightly different to events in software development paradigms, specifically event driven software development – though similar, the design of PREMIS event logs does not promote their “being complete” nor their consumption and reuse; and so, learning from logs in event driven software development, may help us to simplify the PREMIS data model; plug identified gaps in implementations; and improve the ability to migrate digital content in future repositories."
tags:
  - "#PREMIS"
  - "#semantic/unit"
  - "#repository"
  - "#digital/object"
  - "#events"
  - "#long-term/preservation"
  - "#digital/preservation/data"
  - "#dictionary"
  - "#schema"
  - "#METSFlask"
---
# PREMIS Events Through an Event-sourced Lens
Spencer Ross

The PREMIS metadata standard is widely adopted in the digital preservation community. Repository software often include fully compliant implementations or assert some level of conformance. Within PREMIS we have four semantic units, but “Events”, the topic of this paper, are particularly interesting as they describe “actions performed within or outside the repository that affects its capability to preserve Objects over the long term.” Events can help us to observe interactions with digital objects and understand where and when something may have gone wrong with them. Events in PREMIS, however, are slightly different to events in software development paradigms, specifically event driven software development – though similar, the design of PREMIS event logs does not promote their “being complete” nor their consumption and reuse; and so, learning from logs in event driven software development, may help us to simplify the PREMIS data model; plug identified gaps in implementations; and improve the ability to migrate digital content in future repositories.

## Abstract

The PREMIS metadata standard is widely adopted in the digital preservation community. Repository software such as Archivematica includes a full representation of PREMIS and other software like Preservica assert PREMIS conformance [^1][^2].

For the purpose of this paper, the implementation of PREMIS is focused on digital objects and the different events around them that impact long-term preservation [^3].

Event sourcing is a software development methodology that provides a mechanism of persisting data that focuses on recording what has happened rather than how things are; rather than storing current state, event sourcing maintains “state mutations” as separate records called “events” [^4].

Event-sourced events and PREMIS events sound similar to one another, but they look different and are implemented differently. In PREMIS, compliance is often achieved through strict structural properties of the model and recording information in XML. There is less rigidity around the technical implementation of PREMIS. As PREMIS is difficult to engage with, i.e. write and consume, with XML a defacto encoding, we often see ad-hoc decisions made about when information is recorded in a system because not all events fit neatly inside the published data dictionary and not all events look like preservation events – even though they may have an impact on the digital object in the future.

Event sourcing on the other hand requires that all events are recorded for all aggregates (objects) in that model. Event sourcing has a place in long-running processes, e.g. stock-processing, but this paper suggests it may also play a role in helping to record preservation metadata.

Linguistically we see a difference in how events are recorded in PREMIS (as nouns) versus in the event-sourced model (as action verbs). We assert in this paper that this also makes it difficult to engage with, and may hold back data modeling.

It is through an event-sourced lens that this author suggests that we may be able to advance PREMIS further: better align it with software development methodologies that could potentially implement the standard; simplify the data model; plug gaps identified in the current PREMIS 3.0 data dictionary; and improve the ability to migrate digital content in future repositories.

## Introduction

PREMIS is a digital preservation data dictionary and schema. It stands for “Preservation metadata implementation standard [^5].

The standard:

- Supports the viability, renderability, understandability, authenticity, and identity of digital objects in a preservation context;
- Represents the information most preservation repositories need to know to preserve digital materials over the long term;
- Emphasizes “implementable metadata”: rigorously defined, supported by guidelines for creation, management, and use, and oriented toward automated workflows; and,
- Embodies technical neutrality: no assumptions made about preservation technologies, strategies, metadata storage and management, etc.

There are four main elements of the data model described as semantic units: Objects, agents, rights, and events[^6].

- Objects – named and ordered sequence of bytes that is known to an operating system; units of information in digital form
- Rights – assertion of rights and permissions associated with a Premis Object.
- Agents – actors (human, machine, or software) associated with one or more event and/or rights statements associated with a digital object.
- Events – actions performed within or outside the repository that affects its capability to preserve Objects over the long term.

Events and how they interact with Objects are the primary focus of this paper.

Physical objects, as described in PREMIS 3.0, are outside of the scope of this work. Agents are important inasmuch as an event does not occur without an agent associated with it. Rights are only touched on incidentally in the remaining text [^7].

Event sourcing is a software development methodology that provides a mechanism of persisting data that focuses on recording what has happened rather than how things are; rather than storing current state, event sourcing maintains a “log” of “state mutations” as separate records called “events”.

Event sourcing is usually contrasted with a “CRUD” style of writing software that requires some form of long-term persistence. In some ways it is a parallel style of software development. CRUD stands for “Create”. “Read”, “Update” and “Delete” and those are usually implemented as functions on top of a database; functions to read, to delete, and so on. The database in this approach only records current “state”, i.e. records about how something is “at this moment.” Optionally, if such a capability has been implemented, an audit trail may be persisted in a CRUD database that may, conversely, describe snapshots of a previous state and potentially what was done to change the state at the time.

Event sourcing does not assert a single use in a specific domain, and so its few domain objects are “primitives” upon which we can build. Artifacts that we may be interested in are:

- Aggregate – an aggregate is a unique object, artifact, or item that exists.
- Event – is a record describing something that has happened to an aggregate; events tell us how we got to a current state.
- Projection – provides a “view” of an aggregate, e.g. a representation of its current state or states. A projection is built from the underlying event-source model.

An example of what an event log for a digital file may look like:

| Aggregate | IMG_001.jpg |
| --- | --- |
| Events | ``` {“event”: “checksum recorded”, “datetime”: “2022-01-01T00:01:00Z”,  “outcome”: ”ba5eba11”, “previous_id”: “e7e4de42”, “id”: ”8e66dad9”}, {“event”: “checksum recorded”, “datetime”: “2022-06-01T00:01:00Z”,  “outcome”: ”ba5eba11”, “previous_id”: “8e66dad9”, “id”: ”b5ef0830”}, {“event”: “checksum recorded”, “datetime”: “2022-12-01T00:01:00Z”,  “outcome”: ”badf00d”, “previous_id”: “b5ef0830”, “id”: ”db39686b”}, ``` |
| Projection | IMG_001.jpg → WARNING: the checksum has been modified, please investigate further |

**Figure 1.**

We may consider that aggregates in an event-sourced digital preservation model may be an intellectual entity in PREMIS terms, or digital file or files. We simply have to define what the aggregate looks like and what events are associated with it.

## PREMIS in more detail

PREMIS describes events that are performed inside or outside of a repository that affect the ability to preserve “objects” over time. There are 52 events listed on the Library of Congress website [^8], including:

- Accession, appraisal, compression, creation, encryption, ingestion start, ingestion end, message digest calculation, printing, rendering, replication, recovery, redaction, replication, unpacking, validation, virus check.

In PREMIS terms, an event theoretically affects the ability to preserve objects over time. In reality, this is not always the case. Printing is extremely unlikely to affect our ability to preserve an object and is in contrast with compression which rewrites an object’s entire byte stream.

Events, as mentioned, are associated with objects, and those include the following as described in the PREMIS 3.0 data dictionary:

- Intellectual entity – A set of content that is considered a single intellectual unit for purposes of management and description:
- Representation – A digital representation is the set of stored digital files and structural metadata needed to provide a complete and reasonable rendition of the Intellectual Entity.
- Bitstream – Contiguous or non-contiguous data within a file that has meaningful properties for preservation purposes.
- File – Named and ordered sequence of bytes that is known to an operating system.

An event may look as follows (this happens to be associated with a single file and is extracted from a sample ingest in the Archivematica system):

```xml
<premis:event xmlns:premis="http://www.loc.gov/premis/v3"
  xsi:schemaLocation="http://www.loc.gov/premis/v3 
    http://www.loc.gov/standards/premis/v3/premis.xsd" 
  version="3.0">
  <premis:eventIdentifier>
    <premis:eventIdentifierType>UUID</premis:eventIdentifierType>
    <premis:eventIdentifierValue>
      46efc236-fc87-46d8-8f79-99778496bc05
    </premis:eventIdentifierValue>
  </premis:eventIdentifier>
  <premis:eventType>virus check</premis:eventType>
  <premis:eventDateTime>2022-10-04T20:24:15+00:00</premis:eventDateTime>
  <premis:eventDetailInformation>
    <premis:eventDetail>
      program="ClamAV (clamd)"; 
      version="ClamAV 0.103.6"; 
      virusDefinitions="26679/Tue Oct  4 07:56:50 2022"
    </premis:eventDetail>
  </premis:eventDetailInformation>
  <premis:eventOutcomeInformation>
    <premis:eventOutcome>Pass</premis:eventOutcome>
    <premis:eventOutcomeDetail>
      <premis:eventOutcomeDetailNote></premis:eventOutcomeDetailNote>
    </premis:eventOutcomeDetail>
  </premis:eventOutcomeInformation>
  <premis:linkingAgentIdentifier>
    <premis:linkingAgentIdentifierType>
      preservation system
    </premis:linkingAgentIdentifierType>
    <premis:linkingAgentIdentifierValue>
      Archivematica-1.13.2
    </premis:linkingAgentIdentifierValue>
  </premis:linkingAgentIdentifier>
  <premis:linkingAgentIdentifier>
    <premis:linkingAgentIdentifierType>
      repository code
    </premis:linkingAgentIdentifierType>
    <premis:linkingAgentIdentifierValue>
      artefactual
    </premis:linkingAgentIdentifierValue>
  </premis:linkingAgentIdentifier>
  <premis:linkingAgentIdentifier>
    <premis:linkingAgentIdentifierType>
      Archivematica user pk
    </premis:linkingAgentIdentifierType>
    <premis:linkingAgentIdentifierValue>
      2
    </premis:linkingAgentIdentifierValue>
  </premis:linkingAgentIdentifier>
</premis:event>
```

## Event sourcing in more detail

A useful summary of what an event means is written by Jon Vines from AO.com [^9]. Beginning with the dictionary definition of an event: “An event is something that happens, especially when it is unusual or important.” They go further:

> When thinking about this in the context of our application estate, we can further define an event as something that has happened, that the organization cares about. Further, we should remember that an event reflects the past nature of the occurrence. Events are also immutable in their nature and are unable to be changed once they have occurred.
> 
> There are examples that we can draw on:
> 
> - An action that a user has taken e.g. An Order Complete event in a retail scenario
> - Originating from a machine e.g. A delivery van, tracking its location as it moves
> - A system event e.g. A logging event, showing duration of a transaction (think Observability)

Fowler [^10] describes a key principle of event sourcing;

> The core idea of event sourcing is that whenever we make a change to the state of a system, we record that state change as an event, and we can confidently rebuild the system state by reprocessing the events at any time in the future. The event store becomes the principal source of truth, and the system state is purely derived from it. For programmers, the best example of this is a version-control system. The log of all the commits is the event store and the working copy of the source tree is the system state.

“When we change the state of a system, we record that state change as an event”. If we think in terms of the objects in our system, and think about the events associated with those, we can see a parallel with PREMIS. Having previously introduced the concept of these objects as aggregates, we can take the sum-total of all events across all our aggregates to tell us something more about our “system” as a whole.

### Revisiting the checksum example in Figure 1

An event that is important in digital preservation is fixity checking. The name itself implies three things:

1. Fixity is calculated, e.g. using a SHA256 algorithm.
2. Fixity is compared with a previous value.
3. Fixity is determined to be good, i.e. unchanged; or bad, i.e. changed.

Fixity is an important “event” but if we inspect the process above, then only one event is described: “fixity is calculated.”

In this process, the previous state is read to check against the current value and a new state is potentially recorded.

Discovering something has changed may be “eventful”, but it is more likely to be the trigger for a set of corrective processes than an event that is recorded.

In Figure 1 we have an aggregate “IMG_001.jpg”, and for that aggregate we record the event: “checksum calculated” three times, in January, June, and December [^11].

Our events simply record state changes in our system. In a digital preservation system we can think about the changes to the metadata for the objects in our repository.

As humans we can see there is a problem in December when we observe a change to the outcome of recording fixity.

Our “projection,” one of many potential views of our data, discussed shortly, can be regenerated, and in this case, our view is specifically designed to trigger a warning that the checksum has changed. This warning can be forwarded to the repository manager and remedial actions can begin.

Remedial activities are likely to create new events:

| Aggregate | IMG_001.jpg |
| --- | --- |
| Events | ``` {“event”: “checksum recorded”, “date”: “2022-01-01T00:01:01Z”, “outcome”:  ”ba5eba11”, “previous_id”: “329623b1”, “id”: ”7f914e0e”}, {“event”: “checksum recorded”, “date”: “2022-06-01T00:01:01Z”, “outcome”:  ”ba5eba11”, “previous_id”: “7f914e0e”, “id”: ”0e9b3a89”}, {“event”: “checksum recorded”, “date”: “2022-12-01T00:01:01Z”, “outcome”:  ”badf00d”, “previous_id”: “0e9b3a89”, “id”: ”54089c0a”}, {“event”: “object recovered”, “date”: “2022-12-01T00:02:01Z”, “outcome”:  ”IMG_001.jpg retrieved from LOCKSS server 002_DE”, “previous_id”:  “54089c0a”, “id”: ”df63ed10”}, {“event”: “checksum recorded”, “date”: “2022-12-01T00:03:01Z”, “outcome”:  ”ba5eba11”, “previous_id”: “df63ed10”, “id”: ”a1c82d8a”}, ``` |
| Projection | IMG_001.jpg → INFO: *file integrity remains good.* |

**Figure 2.**

The projection created from the new event log in Figure 2 is a heuristic that compares recent checksum values with the first checksum of the aggregate as it was ingested. In this case the result for our aggregate is a positive one and recovery has been successful.

The projection may be created as soon as a “checksum recorded” event happens, but the projection here is produced by just one consumer of the event feed, the event source, and other consumers may have different desires for this information. Take, for example, a view of the file’s characteristics based on looking at the object’s characteristics:

### An example with metadata extraction

| Aggregate | IMG_001.jpg |
| --- | --- |
| Events | ``` {“event”: “format identified”, “agent”: “siegfried”, “date”: “2022-02-01T00:01:00Z”,  “outcome”: ”unknown”, “previous_id”: “005f52d2”, “id”: ”9eeda82f”}, {“event”: “metadata extracted”, “agent”: “mediainfo”, “date”: “2022-03-01T00:01:00Z”,  “outcome”: ”bit-depth: 24-bit”, “previous_id”: “9eeda82f”, “id”: ”70eaa5cc”}, {“event”: “format identified”, “agent”: “siegfried”, “date”: “2022-04-01T00:01:00Z”,  “outcome”: ”unknown”, “previous_id”: “70eaa5cc”, “id”: ”d7e644b4”}, {“event”: “metadata extracted”, “agent”: “GIMP”, “date”: “2022-05-01T00:01:00Z”,  “outcome”: “resolution: 1000x1000; layers: 1;”, “previous_id”: “d7e644b4”, “id”: ”56e8d2f3”}, {“event”: “metadata extracted”, “agent”: “ExifTool”, “date”: “2022-05-01T00:02:00Z”,  “outcome”: ”created-by: Windows Paint 128-bit”, “previous_id”: “56e8d2f3”, “id”: ”3bfbf661”}, {“event”: “format identified”, “agent”: “siegfried”, “date”: “2022-12-01T00:01:00Z”,  “outcome”: ”fmt/30001; JPEG-3000-Super-HD;”, “previous_id”: “3bfbf661”, “id”: ”488a41b9”}, ``` |
| Projection | ``` IMG_001.jpg → “Metadata”: {   “Projection date”: “2023-01-01”,   “Resolution”: “1000x1000”,   “Bit-depth”: “24-bit”,   “Layers”: 1,   “Created-by”: “Windows Paint 128-bit”,   “PUID”: “fmt/30001”,   “Format name”: “JPEG 3000 Super HD”, } ``` |

**Figure 3.**

In our second example, we see additional events for the same aggregate over the course of a year. The events tell a story:

1. A format could not initially be assigned to the file, and it took a few attempts, eventually resulting in the new format *“fmt/30001; JPEG 3000 Super HD”* by the end of 2022.
2. Different metadata extraction tools were used over the course of the year, “MediaInfo”; “GIMP”; and “ExifTool”, and at each separate attempt new information was extracted.

In the projection we simply return summary information about the file encoded as JSON. An alternative projection may encode this as XML. Another may take some of our other events associated with the aggregate and also display the checksum so that it can be downloaded safely by those accessing it.

Notably, the projection has a date as well – perhaps this was configured as an argument to the function creating it, and in another rendering of this information with the given date February 2022, we would only receive a block of JSON with “format name” and “PUID” as “unknown” – importantly: the information we had about the object at an earlier point of time in the system; a view of its “historic” state.

### Other important features of event sourcing

#### Append only

Event-sourced logs are “append only.” Data is added at the end of the log and earlier data should (may) never be deleted. Data can be write-once, read-many and over the long-term, the changes to the record are all accessible and auditable; this is in line with other modern approaches to recording strongly provenanced information in technologies such as Web 3.0, e.g. blockchains.

Append-only logs are less susceptible to inadvertent changes – while not beyond the capability of any developer, modifying data structures such as XML or JSON in memory is inherently risky, especially a structure such as XML that requires the document tree to be read into memory correctly, appended, and then written back to disk. Data for append-only logs need only be added at the end of a process.

Objects (aggregates) can be continuously monitored and updated with an event-sourced approach. If one decides to run a process such as a “reingest,” then the events occuring during the re-processing of an intellectual entity, or entire accession, are simply added to the end of a log, removing the need for reversioning, or modifying anything that already exists – the log tells the story.

#### Different consumers with different needs

Consumers of event sources have different needs. We have seen two examples in this text:

1. Creation of “object characteristics” like structures.
2. Checksum monitoring.

But other projections are needed:

1. Outputs in different metadata formats.
2. Access logs.
3. Derivation logs, i.e. listing derivatives of files and their locations.
4. System-wide: collection-wide views of digital objects.

Events are the simple but powerful building blocks that contribute to creating complex views of our digital preservation systems. We do not need to understand all the views we need today, we can simply delve into the event logs at a point in the future and pull out the information we need to understand past and present state.

#### No need for migrations, or, at least, migrations may not be such a burden

In a structural metadata model, usually stored on disk, or in a database, such as METS/XML with PREMIS, if the standard or representation changes in any way, then a migration (from one structure or schema to another) may be required to make the old version of the model compliant to the updated standard.

Using events, the generation of a new structural model using a different or newer standard, e.g. Portland Commons Data Model, or PREMIS 4.0, can be done by versioning and incrementing the code used to generate the previous model. The foundational events and data they contain does not change. Users and systems, then, have easy access to both versions, as they do multiple representations, using projections. Functions used to create projections today when a new projection is created.

While any structural model can then be maintained on disk, the creation of a projection is a more distributed [^12] approach to doing this, and can be performed at run-time, as opposed to complete versions of structural models being maintained alongside archival packages [^13].

## PREMIS changes

We cannot simply apply an event-sourced lens to PREMIS in its current form. If PREMIS were to become compatible at all with this approach some changes are required.

### Nouns become actions in the past-tense

PREMIS events are often nounified. In some cases the event verb is simply used as a noun through a “functional shift” and remains the same read both ways – as noun and a verb. As nouns, events lose their temporal energy and become static, instead of simply being “something that happened” they are the titles of big, capital “E” “Events,” choreographed into rigid digital preservation processes as opposed to something dynamic and changing, especially actions that may be unseen. It is this author’s assertion that titular PREMIS nouns become a barrier to engage with, use, and extend without committee.

If we maintain the focus that events describe something that has happened and hold onto the original verb, then it may become easier to work with.

Event sourcing uses action verbs, but also uses the past tense “something has happened,” and so mapping PREMIS 1:1 today into an event log is an unnatural fit. Instead we need to convert as follows:

| Noun | Verb | Action |
| --- | --- | --- |
| Accession | Accessioning | …was accessioned |
| Creation | Creating | …was created |
| Replication | Replication | …was replicated |
| Unpacking | Unpacking | …was unpacked |
| Validation | Validating | …was validated |

**Figure 4.**

### Less importance placed on the data dictionary

A data dictionary is a valuable contribution to digital preservation literature, however, rather than trying to capture all possible events, we can potentially find more flexibility in an event-sourced approach where any activity is captured, not just prescribed actions. Events that do not fit easily into a “nounified” category, e.g. “checking for zero byte files” can be logged as an event simply labeled with the activity itself: “checked for zero byte files”. This may be associated with an intellectual entity aggregate, or the file “checked size on disk is greater than zero;” the latter could also be rendered as a projection at the end of a process, where the projection performs some form of validation function.

### Closer to a technical implementation

The only conscious decision of an event-sourced approach to event logging is that all events are captured for an aggregate. A system capturing all events need only consider the design of the event log itself and ensure that it can capture enough information. More elaborate CRUD style data models are not needed, and can indeed become emergent as projections sitting on top of the logs being created. “Design”: schema, or monolithic system’s design, are not front-loaded, meaning that systems can be developed quicker, while the use of the data from these future systems can be designed simply knowing the data is coming in and that there will be access to an event log.

### Replace object characteristics and object-characteristic extensions with projections

Capturing an object’s characteristics is done in PREMIS using the object-characteristics section of the data model. Characteristics unique to a particular representation of a file can only be captured using an “extensibility mechanism” described as “ObjectCharacteristicsExtension”. This is itself somewhat of a data model within a data model, and, crucially, more difficult to work with in that there are no restrictions on the data captured here or the model used. If XML is captured from JHOVE and also TIKA, the XML can be stored here verbatim and requires further parsing to split up. With an event-based approach, there is potential to capture unique object characteristics through events and then render information about characteristics through a new projection, as illustrated in Figure 3.

### PREMIS conformance restrictions around internal schemas are made more flexible

A transformation on any set of data creates an abstraction. PREMIS itself is an abstraction of the data accumulated to build our digital preservation knowledge base. What event sourcing does differently is ask that we engage with a lower-level abstraction of some set of source data (our encoded events) to enable us to generate many more higher level abstractions. As we become more proficient with data-like events [^14], one thing we may take away from looking at PREMIS through an event sourced lens is that lower-level abstractions like events are not “less” than their higher level structural metadata counterparts, they’re just the building blocks.

As the PREMIS committee considers their next revision, then taking another look at what it means to be conformant, not from a data modeler’s perspective, but from a software development perspective, may be beneficial.

The PREMIS conformance statement suggests three levels of conformance while making clear that:

> Adherence to the conformance principles is not a formal requirement for implementing the PREMIS Data Dictionary (although the Editorial Committee does believe that following these principles would be good practice in nearly all implementation contexts).

The conformance statement goes on to describe the following:

> The levels are built around three ways of implementing PREMIS in any repository system:
> 
> 1. being able to map preservation metadata to PREMIS,
> 2. being able to export preservation metadata as PREMIS,
> 3. using PREMIS as an internal schema in a way that does not require any further mapping or conversion.

Two challenges to the levels of conformance are:

While described as levels, should they be viewed hierarchically?

- The first level of conformance clearly makes interpretation of an internal schema next to PREMIS more difficult, and vice versa. One may remove this level of conformance completely. Conceptually, however, two and three, have the same outcome, functionally, they take different paths toward getting there. Can one approach realistically be viewed as better than the other?
- Is level three reasonable in today’s software development world, is it reasonable in today’s environmental climate? Given any well-formed dataset we have the potential to convert it into numerous representations – abstractions at the front and center of PREMIS’ understanding of digital records. Despite the conformance statement’s secondary description of events “sufficient Event metadata to document actions the repository has taken to preserve the digital objects.” that seems to be at odds with its formal description, then PREMIS can be trivially demonstrated to record information that extends beyond that which is useful for preservation. It is useful for presentation, access, other maintenance activities, and so on. Is PREMIS reasonably expected to be the source dataset for new representations of this data, beyond those that support digital preservation? Is it anticipated that PREMIS becomes a companion dataset alongside another representation?Whatever the cost, storage costs “something”, fiscally, environmentally, and intellectually – data asks a lot of us and our resources. Environmentally we should be reducing our data footprint, we do have to ask if PREMIS is the most efficient format to be used as a sole representation of digital preservation metadata; and if the answer is no, level three conformance may be re-considered, or nuanced somewhat, as optional, but no more importance placed on it than being able to extract PREMIS as an abstraction of another format.

PREMIS conformance should be separate from representation. If we acknowledge PREMIS is at least one important representation of preservation metadata, i.e. for its ability to act as an interface to those looking to interpret preservation metadata, then whether it exists logically on disk, or is generated through an event sourced projection, is irrelevant. How a representation complies with the PREMIS data model remains of greater importance, but this is measured from the same eventual view, whatever intermediate abstraction it sits within.

## Analysis compared to PREMIS

### Potential improvements

There is an opportunity when looking at PREMIS though an event-sourced lens to simplify both processes outputting event information and the structural data model, even potentially alleviating the need for parts of PREMIS that do not sit easily in the implementation, such as unique object characteristics (ObjectCharacteristicExtension), because they can exist naturally in an event-sourced approach and used only as the consumer requires.

Event-sourced logs are simple, so they are potentially easier to write into any style of archival package. There is no encoding implied by event-logging, only that events need to be able to be read and processed and other encodings can be generated from event logs as projections, satisfying many of the different uses of the data in an archival environment.

Events are simple and complex database schema are not required for their logging. They can even be stored as plain-text, and/or distributed alongside archival packages.

An event-sourced approach leads with the premise that “not everything has to be known up-front,”, i.e. fit into a neat model. Some information is simply not available early on in a preservation workflow, e.g. for new file formats, other times information needs to fall out of other research processes and becomes available over time.

### Potential drawbacks

In a truly event-sourced system, logs can grow large because of the number of processes occuring or objects processed. There is always a potential they will grow large for the aggregates in an archival workflow as well, resulting in the need for greater computing resources and subsequent greater impact on the environment. Additionally, time is required to process lots of events, and so an event-sourced view of an archival package may mean slower access times.

Time can be saved by caching projections. The amount of data for aggregations of archival objects may grow quite large, but those for individual aggregates may be somewhat less. Thinking about events for individual objects is a different proposition than thinking about the logs of long-running systems and processes.

## Conclusion

PREMIS remains a hugely important tool in digital preservation. Its implementation has worked well for many institutions to this day.

The data model is, however, verbose, and for the number of elements required to encode data, there is not a lot of information encoded – its entropy is high and still requires a lot of processing to develop views on top of what is there. There is no easy way to read the data as a human without additional viewers such as METSFlask.

Projects have been undertaken to understand how to optimize PREMIS output, looking at reducing files with lines numbering in their millions into thousands because of how much space PREMIS requires [^15].

If one looks at the essence of PREMIS then arguably, its single greatest drawback is the verbosity of the structural data model, not the concept of events as “actions performed within or outside the repository that affects its capability to preserve Objects over the long term.” Indeed, others have looked at making the encoding of PREMIS more light-weight [^16].

Current PREMIS models also tend to show us just the current state of an object in time. We do not necessarily see how we got there. We know systems can generate new snapshots through processes such as “reingest”, modifying the existing output, or adding a new version of the metadata to a package, but these are only snapshots, not a complete story.

Perhaps, then, it doesn’t track, that this paper will shortly conclude by suggesting that using events differently, it may be possible to keep more data than PREMIS currently supports in its model, as well as keep metadata sizes low – but this is the prospect of an event-sourced lens on the topic. If one takes compression as their analogy, then an event-log is like a losslessly compressed package [^17]; concentrated information distilled down to its essence. We can store more and when we “uncompress” or expand this data we can generate a number of different representations of this data that satisfy many more of our needs – these are our projections.

Adopting a truly event-sourced approach for PREMIS creates an important separation between “data that is recorded” and “data that is used”. Event sourcing activates stored data by its very nature – the event-log requires projections to live beyond events – as data, triggers, or components of user interfaces, e.g. charts and graphs. As we become more proficient at processing event log data, we can find emergent representations we may not yet be considering.

Alexandra Chassanof asked back in 2020:

> What I’m really wondering is about whether institutions are using PREMIS elements to analyze & manage ingested preservation objects and whether this happens periodically or regularly – if at all. Probably a longer conversation would be helpful [^18].

Further back the PREMIS health-check (PHC) project in 2013 looked at aligning PREMIS with the SPOT threat model for actively monitoring digital preservation repositories [^19].

In an event-sourced PREMIS model, events record everything that can affect the numerous different states of the information around the digital objects (aggregates) in our repositories. The projections, of which, we require at least a minimum number, even to simply return sensible user-facing information about object metadata; these become the foundation for other projections that consume the events needed to actively manage objects in our repository,

From the PHC’s perspective, multiple consumers can be configured to generate different projections revealing different levels of threat. Additionally, event streams can be combined to create projections for any entity the project may have desired, e.g. digital object, collection, or repository. We can create as many dashboards as we desire with warnings galore informing us that our content is potentially at risk [^20].

If we have been writing projections for consumers to see object metadata, alone, then modifying these consumers of events becomes trivial to start exploring the other possibilities such as those in the PHC.

Readers may also see that PREMIS is evolving too – PREMIS RDF [^21] may achieve some of what is described here, the extensibility discussed, a slightly smaller footprint [^22] for example. A graph-based approach to recording metadata still has its drawbacks. To start, it still tries to (needs to) assert a structure through an ontology that codifies its purpose and use. This is how we have tended to approach our work in digital preservation; perhaps coming from fields so closely linked to knowledge organization, we strive for structure which may in turn come from the field’s home in archives and libraries. An event-based approach still complements this, but asks that structure to become emergent [^23]. A graph of digital preservation information (PREMIS/RDF) can be yet another output.

It is this paper’s assertion that we can store more, and “do more” by taking an event-sourced approach to storing events associated with the “objects” described in the PREMIS data dictionary. As of yet, this paper is just one projection. The next step is to develop some more models, describe some principles of event sourcing for digital preservation, and generate some real world data, and to try and prove it.

## About the author

Ross Spencer ([ORCID: 0000-0002-5144-9794](https://orcid.org/0000-0002-5144-9794)) is a digital preservation specialist for the international games and book publisher, Ravensburger AG in Germany. Ross has been part of the digital preservation community for over a decade and has formerly been a digital preservation analyst and programmer in the teams at The National Archives UK, Archives New Zealand, and Artefactual Systems Inc.

## Acknowledgements

This author would like to thank Peter Van Garderen for his review and support around the direction of this article. They would also like to thank Evelyn McLellan at Artefactual Systems for her generosity in sharing her knowledge around PREMIS while I had the opportunity to work alongside her.

## Endnotes

[^1]: Level B is cited in (O’Sullivan et al., 2019)

[^2]: PREMIS conformance statement and levels, (PREMIS Editorial Committee, 2015)

[^3]: The paper has yet to find a way to incorporate analog “versions” as introduced in PREMIS 3.0.

[^4]: (Zimarev, 2020)

[^5]: (PREMIS Editorial Committee, 2015)

[^6]: This information is most easily accessed through the PREMIS Owl Ontology, (*PREMIS 3 Ontology*, n.d.)

[^7]: While Rights are interesting, the scope of rights statements in PREMIS is limited to documenting whether a repository has the right to perform a certain action in an automated way, and documenting that assertion. We will assume this right for this discussion although it is also possible to envisage events not happening due to permissions being unavailable.

[^8]: (*Event Type*, n.d.)

[^9]: (Vines, 2020)

[^10]: (Fowler, 2017)

[^11]: In December the checksum has changed, which is problematic – but also, let us assume that we normally sample at greater frequencies than this in reality, and this is the first time the change has occurred.

[^12]: I.e. bringing data, from heterogeneous “distributed” sources, not just the local disk, to generate one concrete projection

[^13]: The University of North Texas (UNT) adopts a hybrid approach, using a distributed events model, i.e. PREMIS events are separated from their archival packages, but they are stored as a structural model and delivered wrapped in the Atom publishing format and protocol which provides additional contextual metadata. (Phillips et al., 2011)

[^14]: Or in general in our different information management disciplines.

[^15]: Evelyn McLellan investigated how bloat in Archivematica’s XML representation of PREMIS could be reduced, (McLellan, 2018)

[^16]: The Bodleian library, for example, began a METS/PREMIS analysis that sought to reduce the size of METS/PREMIS in Archivematica. One of the published artifacts around this work includes a survey seeking to understand the community’s appetite for RDF-Turtle as a way of improving throughput performance, (Bodleian Libraries, n.d.)

[^17]: Claude Shannon’s theories showed us that messages could be losslessly reduced, by removing redundancies, but then still reproduced, i.e. source coding. Similarly, data can be encoded like this from the outset, and still be used to construct familiar (and predictable) structures, (Aftab et al., 2001)

[^18]: (Chassanoff, 2020)

[^19]: (van der Werf, 2013)

[^20]: The corollary of which are the green lights giving us much comfort.

[^21]: PREMIS-RDF examples, (Caron et al., 2019)

[^22]: There are different tradeoffs with RDF representations. RDF/XML still contains a lot of excess characters, where Turtle (TTL) removes a lot of that but maintains a lot of whitespace. N-Tuples, are “maybe” the closest to an “event log”, however, “subject” uris are often repeated many times over, also taking space.

[^23]: Young (2014), on events, alludes to the question “do i store a structural model” or events from which a structural model can then be generated, i.e. “give you back” a structural model, (Young, 2021)

## References

Aftab, O., Cheung, P., Kim, A., Thakkar, S., & Yeddanapudi, N. (2001, December 16). *Information Theory INFORMATION THEORY AND THE DIGITAL AGE* \[6.933 Final Paper\]. Retrieved February 02, 2023, from [https://web.mit.edu/6.933/www/Fall2001/Shannon2.pdf](https://web.mit.edu/6.933/www/Fall2001/Shannon2.pdf)

Bodleian Libraries. (n.d.). *Archivematica metadata survey*. Webarchive.org. Retrieved 02, February, from [https://web.archive.org/web/20210201133052/https://docs.google.com/forms/d/e/1FAIpQLSeahxmTkyK7yz2Uzmd86z-aMs0CcoFMe6UZPU-07mqdNy1rlQ/viewform](https://web.archive.org/web/20210201133052/https://docs.google.com/forms/d/e/1FAIpQLSeahxmTkyK7yz2Uzmd86z-aMs0CcoFMe6UZPU-07mqdNy1rlQ/viewform)

Caron, B., McLellan, E., Duval, M., & Cowles, E. (2019, October 25). *PREMIS Ontology Examples*. GitHub. Retrieved February 17, 2023, from [https://github.com/PREMIS-OWL-Revision-Team/premis-owl/tree/master/examples](https://github.com/PREMIS-OWL-Revision-Team/premis-owl/tree/master/examples)

Chassanoff, A. (2020, February 19). Twitter. Retrieved February 17, 2023, from https://perma.cc/SH8B-ND5Q

Event Type. (n.d.). PREMIS 3 Ontology: Event Type. Retrieved February 16, 2023, from [https://id.loc.gov/vocabulary/preservation/eventType.html](https://id.loc.gov/vocabulary/preservation/eventType.html)

Fowler, M. (2017, February 7). *What do you mean by “Event-Driven”?* Martin Fowler. Retrieved February 16, 2023, from [https://martinfowler.com/articles/201701-event-driven.html](https://martinfowler.com/articles/201701-event-driven.html)

McLellan, E. (2018). *PREMIS/METS for scalability.* PREMIS/METS for scalability: wiki.archivematica.org. Retrieved February 02, 2023, from [https://wiki.archivematica.org/index.php?title=PREMIS/METS_for_scalability&direction=prev&oldid=13322](https://wiki.archivematica.org/index.php?title=PREMIS/METS_for_scalability&direction=prev&oldid=13322)

O’Sullivan, J., Smith, R., Gairey, A., & O’Farrelly, K. (2019). A PRAGMATIC APPLICATION OF PREMIS: Mapping the key concepts to a real-world system. *Proceedings: 16th International Conference on Digital Preservation*, 1-10. Retrieved February 16, 2023, from [https://ipres2019.org/static/pdf/iPres2019_paper_49.pdf](https://ipres2019.org/static/pdf/iPres2019_paper_49.pdf)

Phillips, M. E., Schultz, M., & Nordstrom, K. (2011). PREMIS Event Service. Retrieved February 02, 2023, from [https://digital.library.unt.edu/ark:/67531/metadc40413/m1/1/](https://digital.library.unt.edu/ark:/67531/metadc40413/m1/1/)

*PREMIS 3 Ontology*. (n.d.). PREMIS 3 Ontology. Retrieved February 16, 2023, from [https://id.loc.gov/ontologies/premis-3-0-0.html](https://id.loc.gov/ontologies/premis-3-0-0.html)

PREMIS Editorial Committee. (2015, April). *Conformant Implementation of the PREMIS Data Dictionary*. Retrieved February 17, 2023, from [https://www.loc.gov/standards/premis/premis-conformance-20150429.pdf](https://www.loc.gov/standards/premis/premis-conformance-20150429.pdf)

PREMIS Editorial Committee. (2015, June). *PREMIS Data Dictionary for Preservation Metadata* (3.0). PREMIS Data Dictionary for Preservation Metadata. Retrieved February 16, 2023, from [https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf](https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf)

van der Werf, T. (2013, September 5). *Preservation Health Check: work in progress*. Retrieved February 17, 2023, from [https://www.loc.gov/standards/premis/pif-presentations-2013/05PREMIS-VdW-PHC.pdf](https://www.loc.gov/standards/premis/pif-presentations-2013/05PREMIS-VdW-PHC.pdf)

Vines, J. (2020, July 2). *What is an event, anyway?. By Software Development Team Lead, Jon… | by AO.com | AO’s Engineering blog*. Medium. Retrieved February 16, 2023, from [https://medium.com/aos-engineering-blog/what-is-an-event-anyway-651122f4f3e6](https://medium.com/aos-engineering-blog/what-is-an-event-anyway-651122f4f3e6)

Young, G. (2021, March 22). *Transcript of Greg Young’s Talk at Code on the Beach 2014: CQRS and Event Sourcing*. Event Store. Retrieved February 17, 2023, from [https://www.eventstore.com/blog/transcript-of-greg-youngs-talk-at-code-on-the-beach-2014-cqrs-and-event-sourcing](https://www.eventstore.com/blog/transcript-of-greg-youngs-talk-at-code-on-the-beach-2014-cqrs-and-event-sourcing)

Zimarev, A. (2020, June 3). *What is Event Sourcing?* Event Store. Retrieved February 17, 2023, from [https://www.eventstore.com/blog/what-is-event-sourcing](https://www.eventstore.com/blog/what-is-event-sourcing)

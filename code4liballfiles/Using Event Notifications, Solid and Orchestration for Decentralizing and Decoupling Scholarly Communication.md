---
title: "Using Event Notifications, Solid and Orchestration for Decentralizing and Decoupling Scholarly Communication"
source: "https://journal.code4lib.org/articles/17823"
author:
  - "Patrick Hochstenbach"
  - "Ruben Verborgh"
  - "Herbert Van de Sompel"
published: 2023-12-04
created: 2025-01-10
description: "The paper presents the case for a decentralized and decoupled architecture for scholarly communication. An introduction to the Event Notifications protocol will be provided as being applied in projects such as the international COAR Notify Initiative and the NDE-Usable program by memory institutions in The Netherlands. This paper provides an implementation of Event Notifications using a Solid server. The processing of notifications can be automated using an orchestration service called Koreografeye. Koreografeye will be applied to a citation extraction and relay experiment to show all these tools fit together."
tags:
  - "#event/notification"
  - "#Solid"
  - "#scholarly/communication"
  - "#Koreografeye/architecture"
  - "#ActivityStreams2"
---
# Using Event Notifications, Solid and Orchestration for Decentralizing and Decoupling Scholarly Communication

Patrick Hochstenbach, Ruben Verborgh, Herbert Van de Sompel

The paper presents the case for a decentralized and decoupled architecture for scholarly communication. An introduction to the Event Notifications protocol will be provided as being applied in projects such as the international COAR Notify Initiative and the NDE-Usable program by memory institutions in The Netherlands. This paper provides an implementation of Event Notifications using a Solid server. The processing of notifications can be automated using an orchestration service called Koreografeye. Koreografeye will be applied to a citation extraction and relay experiment to show all these tools fit together.

## Introduction

Efforts to decentralize scholarly communication are motivated by concerns regarding the status quo of the Web and the Web-based research communication system. Both have become dominated by central hubs that provide millions of users access to information but simultaneously collect and leverage usage statistics about them (Pooley, 2022)(Siems, 2022). Many books, newspaper articles, and specialized reports investigate this questionable practice, which is known as surveillance capitalism (Zuboff, 2015)(Zuboff, 2019)(Aspesi, 2019).

Since the early 2000s, concerns regarding the centralization of scholarly infrastructure by an ever-smaller group of commercial publishers have led to calls for countermeasures such as open access, open repositories, and open science (Posada and Chen, 2018). Interoperability – protocols, not platforms – plays a fundamental role in these decentralization efforts. For example, the widely adopted OAI-PMH metadata harvesting protocol (Lagoze, 2002) enabled the emergence of web services such as COnnecting REpositories (CORE) [^1], Directory of Open Access Journals (DOAJ) [^2], OPEN Access Infrastructure for Research in Europe (OpenAIRE) [^3], and the Registry of Open Access Repositories (ROAR) [^4] that support the discovery of publications in thousands of repositories worldwide. A more recent interoperability effort, the Event Notifications in Value-Adding Networks (Event Notifications) protocol (Hochstenbach, 2022) (Hochstenbach, 2023), proposes a distributed ecosystem of Data Nodes and Service Nodes that exchange information about life-cycle events about scholarly, museum, and archival artifacts. The goal of the Event Notifications protocol is to assist new decentralization efforts by GLAM institutions with an interoperability layer for the exchange of push-based notification messages and to allow for the decoupling of services in decentralized networks. Decoupling means the implementation of services of scholarly communication (registration, certification, awareness, and archiving) (Roosendaal and Geurts, 1998) in separate service nodes instead of consolidation in a one-stop shop.

The COAR Notify Initiative [^5] employs the Event Notifications protocol, connecting institutional repositories (Data Nodes) with overlay journals [^6] and peer-review services (Service Nodes). The NDE-Usable program [^7] of the Dutch Digital Heritage Network aims to redesign how cultural heritage institutions and applications exchange data (Vander Sande, 2022). Event Notifications provides an interoperable communication layer between museum and archival objects and service nodes that provision indexation, annotation, and full-text analysis.

By far, the COAR Notify Initiative, generously funded by Arcadia [^8], has the most advanced implementation of Event Notifications involving project partners such as bioRxiv [^9], medRxiv [^10], Dataverse [^11], Zenodo [^12], PCI Peer Community In [^13] and Open Journal Systems [^14].

The COAR Notify use cases depend on human intellectual analysis and, thus, by definition, are dependent on manual steps to fulfill services requested through notifications. NDE-Usable use cases are more semi-automated and rely on asynchronous processing of data. In both use cases, orchestration can assist the actors in the network and provide the data nodes and service nodes with the correct information at the right time.

To illustrate the potential of the Event Notifications protocol, we provide in this paper a short introduction to the protocol and provide an implementation of Event Notifications using Solid [^15], the web decentralization project of Berners-Lee. The decentralization and decoupling of scholarly services require some form of orchestration to automate interactions between the actors and all other components in the Event Notifications network. We introduce an orchestrator as an automated agent to assist the network in these tasks. Koreografeye is a prototype orchestrator employed in a citation notification experiment about which we will report.

## Event Notifications in Value-Adding Networks

An Event Notifications network exposes life-cycle information (see below) about artifacts within its decentralized network. In a scholarly network, artifacts, in general, are web resources that include (but are not limited to) pre-prints, datasets, reviews, published versions, comments, and web archives. In a GLAM context, artifacts can include museum objects, archival collections, and other digitized materials. Life-cycle events that are of interest are those that demonstrate the (scholarly) *value* of artifacts. In this sense, value is not a monetary value but contextual information that allows one to assess the *trustworthiness* of an artifact. Artifacts with values have a higher chance of being recognized by the scholarly community, vetted for academic honesty, and become part of an official record of a researcher, university, archive, or museum. Examples of life-cycle information for artifacts are information about when and where they were made available online, registered in a repository, peer-reviewed, published in a journal, and indexed in a scholarly database. The associated values are claims of precedence of ideas, proof of being part of the institutional output and establishing the validity of a scholarly claim by peers and the wider academic audience.

To illustrate the connection between an artifact, life-cycle events, and values, we take the example of the researcher Alice, who publishes a preprint on her website.

The fact that Alice publishes this preprint is already an essential life-cycle event: Alice claims precedence of a scholarly finding. When Alice registers this preprint to a timestamp service, she can link her artifact to a trusted timestamp. The value of both events is a trusted claim of precedence for her ideas.

Next, Alice decides to register this preprint in the institutional repository of her university. The institutional repository creates a new record that links to her preprint. The lifecycle event is the registration of the preprint in the repository. This event’s value is establishing her preprint as part of the university output. An event notification could inform Alice of this fact.

Next, Alice requests a review of the preprint in a decentralized peer service such as PREreview [^16], which, after some weeks, results in a new life-cycle event: a review of her preprint is published. The linkage between her preprint and the review establishes the validity of her scholarly claim.

In the next stage, Alice’s preprint gets picked up by Bob, another researcher, who cites her artifact in his paper (another artifact). The lifecycle event, in this case, is the citation. Alice could be informed of this event through an event notification and create a bi-directional link to Bob’s artifact.

In the current scholarly system, discovering these scholarly added values requires a lot of heuristics, post-factum processing, mining massive datasets, and screen scraping websites (e.g., Cabernac et al. efforts to discover preprint/publication links (Cabanac, 2021)). The process of finding these life-cycle events and the communication about these events is the motivation for Event Notifications. To improve on the status quo, Event Notifications introduces a messaging protocol as a means to orchestrate life-cycle events or exchange information about them. Different actors in an Event Notifications network have roles depending on the information they make available and the services that they provide:

- *Data nodes* are network nodes that store research output defined as artifacts.
- *Service nodes* are network nodes that process or augment artifacts and add a (scholarly) value to them. The resulting resources of this process are called *service results.*

For instance, in the example of Alice, her website is the data node, and her preprint is an artifact. Service nodes are the timestamp service, institutional repository, and PREreview service. Service results are the trusted timestamp record, registration record in the institutional repository, and PREreview review.

Data nodes and service nodes in the Event Notifications network send and receive notifications orchestrating life-cycle events and exchanging information about them. For instance, when Alice announces the preprint on her website it triggers a notification. When she requests a timestamp, her data node sends a notification to a timestamp service node. When the institutional repository registers Alice’s preprint, it sends a notification to Alice’s data node. The data node can use these notifications to start scholarly workflows such as creating bidirectional links, triggering new publication workflows, and creating public shared event logs containing life-cycle information.

The Event Notifications specification [^17] describes many possible usage patterns for sending notifications:

- *One-way communication patterns* are a one-shot notification that expresses information such as “I did this activity on an artifact.”
- *Two-way communication patterns* describe a more elaborate communication style regarding providing a service for an artifact.

The communication style depends on the use case and the domain implementing the specification. For instance, COAR Notify [^18] uses two-way communication patterns to describe how institutional repositories, peer-review services, and overlay journals can communicate about requesting services and responding with value-added results. Harvard University Library uses one-way communication patterns to communicate about data-literature links between artifacts in a Dataverse data repository and their DSpace institutional repository.

The Event Notifications protocol of choice to exchange life-cycle information is Linked Data Notifications (LDN) with ActivityStreams2 (AS2) payloads, which will be introduced in the next section.

## ActivityStreams2 Notifications

In an Event Notifications network, data nodes and service nodes exchange information about life-cycle events in the form of JSON-LD notifications using a profile of the ActivityStreams2 (AS2) vocabulary (Snell and Prodromou, 2017). This format has recently gotten some attention due to the popularity of ActivityPub (Lemmer-Webber, 2018) implementations such as Mastodon [^19] (a decentralized version of X, formerly known as Twitter), Friendica [^20] (a decentralized version of Facebook) and PeerTube [^21] (a decentralized version of YouTube). ActivityPub is the decentralized network protocol for delivering notifications. AS2 is the data format for the payloads of such notifications. Whereas the focus of ActivityPub notifications is the actions of humans and information about humans, in an Event Notifications network the notifications are about artifacts or service results about artifacts. Event Notifications creates a profile of AS2 that communicates life-cycle events for artifacts:

- AS2 notifications sent by data nodes focus on requesting a value-adding service for an artifact.
- AS2 notifications sent by service nodes focus on announcing a value-adding service result about an artifact on a data node.

An important fact about the Event Notifications AS2 notifications is that they promote linking to information about artifacts and service results rather than providing inline information about them. As such, Event Notifications AS2 notifications are not a metadata transportation mechanism. Each AS2 notification contains enough information to route a life-cycle event to the correct destination, but not more. Other follow-your-nose discovery mechanisms, such as Signposting (Van de Sompel, 2023), can be used to learn more about artifacts and service results.

The example below shows a fragment of an Event Notifications AS2 notification in the JSON-LD format:

```json
{
  "@context": [
    "https://www.w3.org/ns/activitystreams",
    "https://purl.org/coar/notify"
  ],
  "id": "urn:uuid:6E5FAF88-A7F1-47A4-B087-77345EBFF495",
  "type": [ "Announce", "coar-notify:ReviewAction" ],
  "actor": {
    "id": "https://nortport.edu/profile/bob#me"
  },
  "origin": {
    "id": "https://nortport.edu/repository"
  },
  "context": "http://riverpool.edu/artifacts/modal-surfaces-in-rdf",
  "object": {
    "id": "http://nortport.edu/review/modal-surfaces-in-rdf",
    "type": "Document"   
  },
  "target": {
   "id": "https://riverpool.edu/profile/alice#me"
  }
}
```

Listing 1: A truncated example of an Event Notifications AS2 notification in JSON-LD expressing Bob’s Announcement of a new review artifact (ar nortport.edu) to Alice (at riverpool.edu)

The property `id` contains a unique identifier for a notification message. The property `type` specifies a life-cycle event (in this case, an announcement of an endorsement that Bob sends to Alice). The property `actor` describes the agent that sends the notification, in this case, Bob (we don’t show all the sub-properties for brevity). The property `target` describes the intended audience of the notification, in this case Alice. The property `origin` describes the software agent used to send notifications. The property `object` describes Bob’s artifact. The property `context` describes Alice’s artifact.

The next section introduces Linked Data Notifications (LDN) to exchange AS2 notifications between data and service nodes.

## Linked Data Notifications

In its simplest form, LDN is an HTTP protocol to send and receive RDF messages (such as the Event Notifications AS2 notifications) using a POST request to an *LDN Receiver* (the endpoint that implements LDN) (Capadisli and Guy, 2017). In Event Notifications, data and service nodes are LDN Receivers of AS2 notifications. The network endpoint that receives notifications is called the *LDN Inbox*.

Implementing an LDN Inbox with basic functionality (append-only, without authentication or authenticated read functionalities) is relatively straightforward. Any HTTP endpoint receiving a POST request with a JSON-LD body and returning an HTTP `201 Created` status code with the network location of the accepted notification is already an LDN Inbox.

An LDN Sender is an application that can send RDF messages to an LDN Inbox. In its most basic form, an LDN Sender should be able to issue an HTTP POST request to the location of an LDN Inbox. In the example below, we use a curl command to send the JSON-LD notification stored in the `example.jsonld` file to an LDN Inbox located at `https://riverpool.edu/inbox/`

```bash
curl -H "Content-Type: application/ld+json" \
     --data-binary @example.jsonld \
     https://riverpool.edu/inbox/
```

In this paper, we will create a more advanced implementation of the LDN Inbox and the LDN Sender to demonstrate the potential of the Event Notifications protocol. We will implement the LDN Inbox with append and read capabilities as defined by the Solid protocol. Using the Solid protocol, we can decouple the logic of scholarly web services from implementing the LDN Inbox with the help of automated agents.

## Solid

We explained Event Notifications AS2 notifications and the LDN protocol in the previous two sections. This section will introduce Solid to implement LDN Inboxes with append and read capabilities.

In a typical setup, creating an LDN Sender and LDN Receiver with basic HTTP POST functionality would be all that is required to implement the Event Notifications protocol. Internally, an implementation would require some logic to act on incoming AS2 notifications and send out new AS2 notifications. Projects such as COAR Notify provide guidelines for setting up such systems. Many pilot partners are already starting to experiment with LDN Inboxes in local instances of institutional and data repositories such as DSpace and Dataverse and services such as HAL [^22] (the French Research Archive), PREreview [^23], Peer Community In [^24], and many others [^25].

In the Andrew W. Mellon-funded ResearcherPod project [^26], we take a more extreme decentralization approach and investigate what would happen if every researcher employed their own data node instance (or where libraries would provide such services). In the vision of the ResearcherPod (Van de Sompel, 2018), every researcher has access to a Solid Pod (Capadisli, 2022) on which they store artifacts. The Solid project (“Solid”) was started in 2015 by Tim Berners-Lee as a vision of independent data storage and services. The name “Solid” can mean many things depending on the context. It is the name of the web decentralization movement, a set of protocols [^27], and a bunch of implementations [^28].

The protocols proposed by Solid are similar to the Fedora Commons project [^29] but are targeted to different use cases. The central use-case of Fedora Commons is providing a backend service on top of which institutions can build institutional repositories, data repositories, and digital archives. The Fedora Commons provides out-of-the-box support and much documentation about data models and protocols for GLAM use cases. Solid is targeted to personal storage use cases but with direct access to the web. Solid servers do not have out-of-the-box specialized workflows for data archiving purposes. But they do come with a global authentication system. Decentralized Solid clients, such as single-page applications, provide all interactions with the Solid server. Web Identities [^30] provide a global identity, SOLID-OIDC [^31] a global authentication mechanism, and Web Access Control [^32] a global access mechanism. Each Solid user can decide who has access to what data and can interact with Web Identity with Solid installations worldwide. The drawback of Solid is that this flexibility is not without complexity. Creating authenticated sessions with SOLID-OIDC requires specialized software libraries currently only available in JavaScript and Java. Also, Solid, like Fedora Commons, doesn’t come with a Web front-end, which needs to be created by the community. The advantage of Solid is that it can be easily installed and doesn’t require any external dependencies such as database systems or full-text indexes that need to be maintained.

In our experiments, we employ a Solid server to implement an LDN Inbox with the functionality to provide (authenticated) web agents append and read access to notifications in the inbox. A decoupled *Orchestrator* (see next section) implements the logic to process notifications in the LDN Inbox.

We use the Community Solid Server (CSS) [^33] implementation of Solid, which has the advantage that the installation doesn’t require any other dependencies than a relatively recent Node.JS version with the NPM package manager. We can install a CSS 6.1.0 version with the following command:

```bash
npm install -g @solid/community-server@6.1.0
```

Note: the command-line examples in this paper were created for a MacOS/Linux system. The syntax should be the same on modern Windows systems, starting with Windows 10 and Server 2019.

To start the CSS instance in a new `data_node` folder, execute the following commands:

```bash
mkdir data_node
cd data_node
community-solid-server -c @css:config/file-no-setup.json
```

The `file-no-setup` configuration should only be used for testing and demonstration as it exposes the root container for the world with read and write access rights. We refer to the CSS website for documentation about more secure setup choices [^34].

In the new `data_node` folder, we can create an LDN inbox with the following command:

The curl command of the previous section can now be used to send an Event Notifications notification to this LDN inbox with network location `http://localhost:3000/inbox/`.

Read the contents of the LDN inbox by issuing an HTTP GET request against the LDN inbox:

```bash
mkdir inbox
```

The response will be a Turtle document containing the LDN inbox. The Turtle document below shows a fragment of the response:

```turtle
<> a ldp:Container, ldp:BasicContainer, ldp:Resource .
<ec8267ac-e4af-4233-9786-9192801a4baf> a ldp:Resource .
```

This LDN Inbox contains one resource with the relative URL `ec8267ac-e4af-4233-9786-9192801a4baf`. LDP, Linked Data Platform [^35], is a specification for reading and writing RDF data using HTTP. LDN is a specialized subset of the LDP protocol. A `ldp:Resource` is a class to describe resources (similar to a file). A `ldp:Container` is a class to describe a collection of resources (similar to a folder).

Issuing an HTTP GET request on this URL, we can retrieve the Event Notifications AS2 notification:

```bash
curl http://localhost:3000/inbox/ec8267ac-e4af-4233-9786-9192801a4baf
```

To get programmatic access to Solid servers open source Javascript [^36] and Java [^37] Solid clients are available. At Ghent University, we require a lot of command-line processing of notifications and created the BashLib [^38] client to interact with Solid servers. Install BashLib with the command:

```bash
npm install -g solid-bashlib
```

With this command, a new `sld` executable is available that provides many bash command equivalents (such as `ls`, `cp`, `remove`, `tree`) to interact with an (authenticated) Solid server. To list the contents of our LDN Inbox issue:

```bash
sld ls http://localhost:3000/inbox/
```

To read the contents of a resource, execute the `sld cat` command:

```bash
sld cat http://localhost:3000/inbox/ec8267ac-e4af-4233-9786-9192801a4baf
```

## Orchestration

In a decentralized Event Notifications network, the data and services nodes do not resort to one place but are intentionally distributed. As a result, the actors in the network need to communicate with multiple service nodes to execute a desired scholarly workflow. Some of these workflows are near instantaneous, and some can take several days or months to finalize. An orchestrator component automates part of the required interactions to avoid excessive manual work by the data node and service node maintainers to keep up with the received and sent notifications. In many ways, orchestration resembles the function of a rule engine employed by email agents such as Outlook Rules or Mozilla Thunderbird Filters.

In the ResearchPod project, we decouple, using an orchestrator, the logic of processing notifications from the LDN Inbox implementation (the Solid Pod in our case). The Solid protocol provides read and write capabilities for LDN Inboxes on which an orchestrator can act. In this way, some valuable characteristics become available for the orchestrator as an automated agent:

- An orchestrator can communicate with one or more remote LDN Inboxes.
- An orchestrator is an LDN Receiver and an LDN Server of Event Notifications AS2 notifications.
- An orchestrator uses a collection of rules to define actions that trigger state changes in the network.

In the next section, we introduce a prototype orchestrator, Koreografeye, capable of providing the functionalities described in this section. This orchestrator will then be used in an experiment to automatically notify data nodes in an Event Notifications network about citations to their stored artifacts.

## Koreografeye
  
![Figure 1. The Koreografeye architecture](https://journal.code4lib.org/media/issue58/hochstenbach/01.png)

**Figure 1.** The Koreografeye architecture

Koreografeye is an orchestrator built for the ResearchPod project to provide a command-line solution for orchestration. We chose a collection of command-line tools to allow for integration with larger-scale projects we did in the past using Apache Nifi. Our solution, however, can run standalone. Figure 1 shows the architecture of Koreografeye.

The top left depicts an LDN Inbox that the orchestrator monitors. We use the BashLib command-line client and a cron job to watch the LDN Inbox and download notifications to a local input folder. In step (1), the `orch` component processes incoming AS2 notifications with a rule engine. Zero or more policy documents describe the actions to follow when receiving an AS2 notification. The output (2) of the rule execution is an augmented AS2 notification resource that contains enough technical metadata for a `pol` component to execute (3) the actions defined by policies. Policy actions include instructions such as “send an AS2 notification”, “send an email”, “create a Mastodon ’Toot’” or “update a resource on a Solid pod.”

### Notation3

Notation3 [^39] is our first attempt to create a policy language. Given the RDF nature of AS2 notifications and the declarative way of writing rules in the Notation3 language, this seems a reasonable choice. Notation3 rules are combinations of `IF`-`THEN` statements expressed using an extension of RDF Turtle. The example below shows a simple rule:

```txt
@prefix as: <https://www.w3.org/ns/activitystreams#> .
@prefix :   <urn:foo-bar:> .
 
{
  ?id a as:Announce .
}
=>
{
  ?id a :CoolNotification .
} .
```

The first curly brackets `{ }` describes the `IF`-part of the policy: “If the input RDF document has a subject `?id` of type `as:Announce`“. The second curly brackets after `=>` describes the `THEN` part of the policy: “Then, add to the subject `?id the (sub)type :CoolNotification`“. The `?id` binds the matching subject of the `IF` part.

In Koreografeye, each policy adds in the `THEN` part RDF triples that describe an action. For instance, the policy below requests that every AS2 notification of type `as:Announce` with subtype `ex:Citation` should result in an email:

```txt
@prefix as:  <https://www.w3.org/ns/activitystreams#> .
@prefix :    <urn:foo-bar:> .
@prefix ex:  <http://example.org/> .
@prefix pol: <https://www.example.org/ns/policy#> .
@prefix fno: <https://w3id.org/function/ontology#> .
 
{
  ?id a as:Announce, ex:Citation .
}
=>
{
  ex:MyEmailPolicy pol:policy [
    a fno:Execution ;
    fno:executes ex:sendEmail ;
    ex:to "patrick.hochstenbach@ugent.be" ;
    ex:subject "You got a citation!" ;
    ex:body "You got a new citation"
  ] .
}.
```

### Implementation

The implementation of Koreografeye was written in TypeScript (JavaScript) and runs on Node.js ([https://nodejs.org](https://nodejs.org/)). An installation of Node.js includes the `npm` and `npx` commands we will use in the rest of this paper. To run the Koreografeye examples a Node.js version v16.20.0 or more recent is advised.

To install Koreografeye, issue the following command:

```bash
npm install -g koreografeye
```

In our demonstration, we will use the AS2 notification example from the start of this paper as the `example.jsonld` file in an `input` folder. An `orch` run will apply the `mypolicy.n3` policy on the `example.jsonld` AS2 notification:

```bash
npx orch --info --keep --in input --out output mypolicy.n3
```

The `--info` option provides verbose information about the orchestration run, the `--keep` option tells the orchestrator not to delete the input file after processing, the `--in input` option is the input folder that contains the AS2 notifications, the `--out` option is the location of an output folder, and `mypolicy.n3` is the Notation3 policy that is applied to the incoming AS2 notification. A (truncated) example of the `mypolicy.n3` rule is given below [^40]:

```txt
{
  # We need an Announce
  ?id a as:Announce .
 
  # We need an object
  ?id as:object ?object .
}
=>
{
  # Send a notification to an indexing service
  ex:MySendNotificationDemo pol:policy [
    a fno:Execution ;
    fno:executes ex:sendNotification ;
    ex:to <http://indexing.for.us/inbox/> ;
    ex:notification [
      a as:Offer ;
      as:actor  <https://repository.edu/profile/card#me>  ;
      as:origin <https://repository.edu/orchestator/card#me> ;
      as:object ?object ;
      as:target <http://indexing.for.us/profile/card#me>
    ]
  ] .
} .
```

Listing 2: A truncated example of a policy in Notation3, expressing that AS2 Announce notifications should be forwarded to an indexation Service Node (indexing.for.us) using an AS2 Offer notification,

Listing2 describes a policy rule that instructs the `orch` that every incoming AS2 notification of type `Announce` with an `object` should be forwarded to a hypothetical indexation service [http://indexing.for.us](http://indexing.for.us/).

The output of the previous `orch` run is an augmented RDF resource in the `output` directory, which contains the original AS2 notification plus technical metadata to instruct the `pol` policy executor to send out a new AS2 notification to the indexation service node. In this case, the triples that describe the `ex:MySendNotificationDemo` is added to the AS2 notification. The output file `output/example.ttl` contains the original AS2 notification with the added triples from the orch process.

The `pol` policy script will execute the results of the previous step:

```bash
npx pol --info --keep --in output
```

When executed, the `pol` will result in an error because the [http://indexing.for.us/inbox/](http://indexing.for.us/inbox/) is a fake address. Had we used a real LDN Inbox address, an AS2 notification would have been delivered by the orchestrator.

Implementing in Koreografeye a new type of policy execution step, for instance, updating a local institutional repository would require writing a Koreografeye plugin [^41] in JavaScript or TypeScript. The plugin gets as input the AS2 notification plus the configured parameters from the Notation3 policy and can then execute any required call to the API-s for your repository.

## Citation Notification Experiment

In the remainder of this paper, we combine the above mentioned techniques into a citation notification experiment that Ghent University Library and IMEC IDLab conducted in the summer of 2023.

The experiment investigates how an orchestrator can notify data nodes in an Event Notifications network about new citations to their stored artifacts. We imagine a repository A that holds artifacts and is the source of citations and repositories B, C, D, etc., that hold artifacts that are the targets of the citations. Repository A would like to execute an automated workflow to notify repositories B, C, D, etc., about these citations. In this experiment, we don’t necessarily investigate the feasibility of citation extraction (a research topic on its own) but the potential of using a network of decentralized services and automated agents to inform data nodes about citations.
  
![Figure 2. The citation network experiment architecture](https://journal.code4lib.org/media/issue58/hochstenbach/02.png)

**Figure 2.** The citation network experiment architecture

### Experimental setup

Figure 2 displays the architecture of the citation notification experiment. On the left side, in blue, institutional repository A (Data Node) contains the source publication artifacts. We would like to send Event Notifications AS2 notifications to a (demonstration) network of external repositories B, C, D, etc. (Data Nodes) to inform them that an artifact in repository A has cited artifacts in their repository.

To implement this workflow, we introduce:

- A network of LDN Inboxes in the form of Solid CSS instances that operate on behalf of the repositories A, B, C, D, etc.
- Two service nodes:
- A Citation Extractor service node that, given an Event Notifications AS2 notification pointing to an artifact, will extract the citations from the artifact, publish the extracted citations as a service result document, and send an Event Notifications AS2 notification with the link to this service result back to the Data Node that requested the citation extraction.
- A Citation Relay service node that, given an Event Notifications AS2 notification pointing to a service result of extracted citations, tries to discover the LDN Inboxes of the cited artifacts and sends to each of them an Event Notifications AS2 notification about the discovered citations.
- An Orchestrator that:
- Contains an OAI-bridge that transforms the pull-based OAI-PMH protocol of repository A into the push-based LDN+AS2 protocol of the Event Notifications network. In this way, every newly added artifact in the institutional repository A will generate a new Event Notifications AS2 notification that triggers the orchestrator.
- Contains policies describing how to interact with the Citation Extractor and Citation Relay services to drive the experiment.

### Experimental implementation

To explain the experiment, we will provide some details below about the execution steps in Fig 2.

In step (1), the orchestrator uses an OAI-PMH bridge to inform itself about new artifacts in repository A. The OAI-PMH bridge is a component that pulls the OAI endpoint of repository A and generates push AS2 notifications to the orchestrator. For each AS notification, the orchestrator consults its policies. One of the policies describes a rule that demands that for every new artifact in repository A an Event Notifications AS2 `Offer` notification should be sent to the Citation Extractor service.

In step (2), the Citation Extractor receives the Event Notifications AS2 `Offer` and starts a citation extraction process for the offered artifact. We skip the exact details of this process but mention that we are experimenting with citation extraction tools such as Cermine [^42] and OpenCitations [^43]. After some processing time, this process results in an RDF Turtle document containing all the extracted citations. Every citation contains an HTTP link to the citing artifact and an HTTP link (such as a DOI) to the (remote) cited artifact.

In step (3), a link to the service result of step (2) is sent as an Event Notifications AS2 `Announce` notification to the LDN Inbox of repository A. The orchestrator is triggered again, consults its policies, and finds a policy that demands that citation service results should be forwarded as an `Announce` notification to a Citation Relay service.

In step (4), the Citation Relay receives the Event Notifications AS2 `Announce` notification and starts a process to discover the LDN Inbox for every citation link in the service result. The Citation Relay resolves ever HTTP link for each citation in search for HTTP Headers that describe the location of an LDN Inbox. In our scholarly networks, we can’t expect any implementations of LDN Inboxes to be available yet. When no external LDN Inbox is found, a local demonstration network of Solid CSS servers is used as an LDN Inbox.

In step (5), the Citation Relay service sends an Event Notifications AS2 `Announce` notification to the discovered LDN Inboxes, informing them about a relationship between an artifact in repository A and a citation of an artifact in their repository.

### First results

We conducted the citation notification experiment on samples of publications in the Biblio – Academic Bibliography institutional repository of Ghent University Library [^44], which acts as Repository A. For this repository, random samples of 1, 10, 32, and 100 artifacts were harvested that contain at least a DOI link as metadata (about 40% of recent Biblio records contain such DOI-s). These artifacts were presented to the orchestrator as AS2 notifications and offered to the network of service nodes as described above. For each sample, the total time was measured to trigger the orchestrator, searching citations in the Citation Extraction service using the OpenCitations API [^45], notifying the Biblio LDN Inbox about the results, forwarding the service results to the Citation Relay service, discovering remote LDN Inboxes and the delivery of Event Notifications AS2 notifications to the demonstration network of repository data nodes. The total execution time is shown in Fig 3, demonstrating a near-linear scalability of the solution. The total time is based on using a single thread of execution in all components.
  
![Figure 3. Total time in seconds of extracting citations (using the OpenCitations API), discovering LDN Inboxes for remote data nodes, and sending Event Notifications AS2 notifications to these inboxes for N=1,10,32 and 100 random sample artifacts with DOI-s.](https://journal.code4lib.org/media/issue58/hochstenbach/03.png)

**Figure 3.** Total time in seconds of extracting citations (using the OpenCitations API), discovering LDN Inboxes for remote data nodes, and sending Event Notifications AS2 notifications to these inboxes for N=1,10,32 and 100 random sample artifacts with DOI-s.

We tried different citation extraction strategies, such as using Cermine. However, our experiments demonstrated that 80% of the execution time is consumed by dereferencing DOI-s while trying to discover LDN Inboxes. This was a surprise because we assumed that most of the time would be spent extracting citation data from PDF files. Finding obstacles in DOI resolution is not new and was already reported by researchers from Los Alamos National Laboratories in 2020 (Klein and Balakireva, 2020).

We worked with a relatively small sample of artifacts, but for this small sample of 100 artifacts (using OpenCitations DOI resolution), we could find 1896 citations that were distributed over 163 data nodes.

In other experiments, we used the Cermine software to locally extract citation information with mixed results. In an ideal world, these citations shouldn’t have to be extracted from binary formats such as PDFs and directly made available in a machine-readable format (Martin and Henrich, 2022).

The software of this experiment is available in open source as OAI-Bridge [^46], CitationExtractionService [^47], and CitationRelayService [^48]. The resulting Event Notifications AS2 notifications can be downloaded from Zenodo at [https://zenodo.org/records/10017325](https://zenodo.org/records/10017325.).

## Conclusion and future work

We covered quite some ground to describe the raison d’être of Event Notifications and the notification protocols it employs for communication between decentralized nodes that each fulfill decoupled versions of scholarly functions. A possible decoupled implementation of an Event Notifications inbox was demonstrated using a Solid CSS service, which provides out-of-the-box web-ready authenticated LDN Inbox functionalities. The orchestrator was introduced as an active component that uses a rule-based policy system to automate scholarly value chains. The Citation Notification experiment is one example of how this setup can be used for real-world use cases.

The potential of Event Notifications doesn’t stop here. Communicating about value-adding events is one thing, but making value-adding events publicly available and discoverable provides new opportunities for future applications. If all Data Nodes and Service Nodes would make public event logs available that describe how scholarly artifacts got registered, certified, published, and archived, it would not only benefit the bibliometrics researcher who gets more transparency in the scholarly process but would also provide the public to better tools to differentiate facts from fiction. A web user who discovers any article online could be provided with an interface to discover the event logs of all value-adding services we collected and made available in the Event Notifications network and discover the academic values of the information at hand.

Thinking about scholarly communication nodes in a decentralized and decoupled fashion could create a new open ecosystem involving preprint servers, journals, independent content-vetting initiatives, and curation services that provide more multidimensional signals for papers and avoid the current conflation of trust, quality, and impact (Sever, 2023).

## Acknowledgments

This work is funded by the Andrew W. Mellon Foundation (grant number: 1903-06675) and supported by SolidLab Vlaanderen (Flemish Government, EWI, and RRF project VV023/10). The authors would like to thank the ErfgoedPod project (Miel Vander Sande) and IMEC (Ruben Dedecker, Wout Slabbinck, and Jos De Roo) for joint discussions on the requirements for decentralized orchestration in both of our projects. The authors would also like to thank the COAR Notify (Kathleen Shearer, Paul Walk, Martin Klein) for involving them from the outset, allowing them to provide input and gain valuable insights in the scholarly communication process.

## About the Authors

*Patrick Hochstenbach* (WebID:[https://patrickhochstenbach.net/profile/card#me](https://patrickhochstenbach.net/profile/card%23me)) is a digital architect in the library automation team of Ghent University Library, Belgium. In Ghent, he was involved in the OpenURL/SFX project and created the first version of the SFX linking server. At Los Alamos National Laboratory, he participated in research projects on federated digital repository architectures. At Lund University, Sweden, he created large-scale full-text indexation services. And again, at Ghent University, he is currently doing his Ph.D. research in computer science on applying decentralization techniques for scholarly communication.

*Ruben Verborgh* (WebID:[https://ruben.verborgh.org/profile/#me](https://ruben.verborgh.org/profile/%23me)) is a professor of Decentralized Web Technology at IDLab of Ghent University – IMEC and a Visiting Fellow at the Oxford Martin School within the University of Oxford. He is the Head of Data Interoperability at Inrupt and an advisor to other companies. From his hybrid academic and industrial perspective, his professional mission is to support Solid in inspiring, transforming, and reshaping our data-driven society.

*Herbert Van de Sompel* (WebID:[https://hvdsomp.info/#i](https://hvdsomp.info/%23i)) is a Research Fellow at Data Archiving and Networked Services (DANS) in The Netherlands and a Visiting Professor at the Internet Technology & Data Science Lab of Ghent University. He has played a major role in creating the Open Archives Initiative Protocol for Metadata Harvesting (OAI-PMH), the Open Archives Initiative Object Reuse & Exchange specifications (OAI-ORE), the OpenURL Framework for Context-Sensitive Services (ANSI/NISO Z39.88-2004), the SFX linking server, the bX scholarly recommender service, info URI (RFC 4452), Open Annotation (W3C Community Group specification), ResourceSync (ANSI/NISO Z39.99-2014), Memento “time travel for the Web” (RFC 7089), Robust Links, and Signposting the Scholarly Web.

## References

Aspesi, Claudio, and Allen, Nicole S., and Crow, Raym, and Daugherty, Shawn, and Joseph, Heather, and McArthur, Joseph T. W., and Shockey, Nick . “SPARC Landscape Analysis.” SPARC, 29 March 2019, [https://infrastructure.sparcopen.org/landscape-analysis](https://infrastructure.sparcopen.org/landscape-analysis.)

Cabanac, Guillaume, and Oikonomidi, Theodora, and Boutron, Isabelle. “Day-to-day discovery of preprint–publication links.” Scientometrics, vol. 126, 2021, pp. 5285–5304, [https://doi.org/10.1007/s11192-021-03900-7](https://doi.org/10.1007/s11192-021-03900-7)

Capadisli, Sarven, and Bernes-Lee, Tim, and Verborgh, Ruben, and Kjernsmo, Kjetil. “Solid Protocol.” Solid project, 2022, [https://solidproject.org/TR/protocol](https://solidproject.org/TR/protocol)

Capadisli, Sarven, and Amy Guy. “Linked Data Notifications.” W3C, 2 May 2017, [https://www.w3.org/TR/ldn/](https://www.w3.org/TR/ldn/)

Hochstenbach, Patrick, and Vander Sande, Miel, and Dedecker, Ruben, and Walk, Paul, and Klein, Martin, and Van de Sompel, Herbert. “Event Notifications in Value-Adding Networks.” Event Notifications in Value-Adding Networks, 6 September 2023, [https://www.eventnotifications.net](https://www.eventnotifications.net/)

Hochstenbach, Patrick, and Van de Sompel, Herbert, and Vander Sande, Miel, and Dedecker, Ruben, and Verborh, Ruben. “Event Notifications in Value-Adding Networks.” Linking Theory and Practice of Digital Libraries, vol. 13541, 2022, p. 133, [https://doi.org/10.1007/978-3-031-16802-4_11](https://doi.org/10.1007/978-3-031-16802-4_11)

Klein, Martin, and Lyudmila Balakireva. “On the Persistence of Persistent Identifiers of the Scholarly Web.” Digital Libraries for Open Knowledge. TPDL 2020., vol. 12246, 2020, [https://doi.org/10.1007/978-3-030-54956-5_8](https://doi.org/10.1007/978-3-030-54956-5_8)

Lagoze, Carl, and Van de Sompel, Herbert, and Nelson, Michael L., and Warner, Simeon. “Protocol for Metadata Harvesting – v.2.0.” Open Archives Initiative, 2002, [http://www.openarchives.org/OAI/openarchivesprotocol.html](http://www.openarchives.org/OAI/openarchivesprotocol.html)

Lemmer-Webber, Christine, and Tallon, Jessica, and Shepherd, Erin, and Guy, Amy, and Prodromou, Evan. “ActivityPub.” W3C, 23 January 2018, [https://www.w3.org/TR/activitypub/](https://www.w3.org/TR/activitypub/)

Martin, Leon, and Andreas Henrich. “RDFtex: Knowledge Exchange Between LaTeX-Based Research Publications and Scientific Knowledge Graphs.” Linking Theory and Practice of Digital Libraries. TPDL 2022., vol. 13541, [https://doi.org/10.1007/978-3-031-16802-4_3](https://doi.org/10.1007/978-3-031-16802-4_3)

Pooley, Jeff. “Surveillance Publishing.” The Journal of Electronic Publishing, vol. 25, no. 1, 2022, [https://journals.publishing.umich.edu/jep/article/id/1874/](https://journals.publishing.umich.edu/jep/article/id/1874/)

Posada, Alejandro, and George Chen. “Inequality in Knowledge Production: The Integration of Academic Infrastructure by Big Publishers.” ELPUB 2018, 2018, [https://hal.archives-ouvertes.fr/hal-01816707](https://hal.archives-ouvertes.fr/hal-01816707)

Roosendaal, Hans, and Peter Geurts. “Forces and functions in scientific communication: an analysis of their interplay.” CRIS97, 5 January 1998. [https://perma.cc/5HYM-BEKF](https://perma.cc/5HYM-BEKF)

Sever, Richard. “Biomedical publishing: Past historic, present continuous, future conditional.” PLOS, 3 October 2023, [https://doi.org/10.1371/journal.pbio.3002234](https://doi.org/10.1371/journal.pbio.3002234)

Siems, Renke. “Das Lesen der Anderen: Die Auswirkungen von User Tracking auf Bibliotheken.” o-bib. Das offene Bibliotheksjournal, vol. 9, no. 1, 2022, [https://www.o-bib.de/bib/article/view/5797](https://www.o-bib.de/bib/article/view/5797)

Snell, James M., and Evan Prodromou. “Activity Streams 2.0.” W3C, 23 May 2017, [https://www.w3.org/TR/activitystreams-core/](https://www.w3.org/TR/activitystreams-core/)

Vander Sande, Miel. “Use Cases & Business Processes.” 2022, [https://erfgoedpod.github.io/usecases/](https://erfgoedpod.github.io/usecases/)

Van de Sompel, Herbert. “Scholarly Communication: Deconstruct & Decentralize?” YouTube, CNI: Coalition for Networked Information, 2 January 2018, [https://www.youtube.com/watch?v=o4nUe-6Ln-8](https://www.youtube.com/watch?v%3Do4nUe-6Ln-8)

Van de Sompel, Herbert, and Klein, Martin, and Jones, Shawn, and Nelson, Michael L., and Warner, Simeon, and Devaraju, Anusuriya, and Huber, Robert, and Steinhoff, Wilko, and Tykhonov, Vyacheslav, and Boruta, Luc, and Meijers, Enno, and Soiland-Reyes, Stian, and Wilkinson, Mark. “FAIR Signposting Profile.” Signposting the Scholarly Web, 2023, [https://signposting.org/FAIR/](https://signposting.org/FAIR/)

Zuboff, Shoshana. The Age of Surveillance Capitalism: The Fight for a Human Future at the New Frontier of Power. Profile Books, 2019. [https://doi.org/10.1080/17530350.2019.1639068](https://doi.org/10.1080/17530350.2019.1639068)

Zuboff, Shoshana. “Big other: Surveillance Capitalism and the Prospects of an Information Civilization.” Journal of Information Technology, vol. 30, no. 1, 2015, [https://journals.sagepub.com/doi/10.1057/jit.2015.5](https://journals.sagepub.com/doi/10.1057/jit.2015.5)

## Endnotes

[^1]: [https://core.ac.uk/](https://core.ac.uk/)

[^2]: [https://www.doaj.org](https://www.doaj.org/)

[^3]: [https://www.openaire.eu/openaire-portal](https://www.openaire.eu/openaire-portal)

[^4]: [http://roar.eprints.org](http://roar.eprints.org/)

[^5]: [https://www.coar-repositories.org/notify/](https://www.coar-repositories.org/notify/)

[^6]: An online journal composed out of links to self-archived preprints of postprints. See also [https://en.wikipedia.org/wiki/Overlay_journal](https://en.wikipedia.org/wiki/Overlay_journal)

[^7]: [https://netwerkdigitaalerfgoed.nl/bruikbaar/](https://netwerkdigitaalerfgoed.nl/bruikbaar/)

[^8]: [https://www.arcadiafund.org.uk](https://www.arcadiafund.org.uk/)

[^9]: [https://www.biorxiv.org](https://www.biorxiv.org/)

[^10]: [https://www.medrxiv.org](https://www.medrxiv.org/)

[^11]: [https://dataverse.org](https://dataverse.org/)

[^12]: [https://zenodo.org](https://zenodo.org/)

[^13]: [https://peercommunityin.org](https://peercommunityin.org/)

[^14]: [https://pkp.sfu.ca/software/ojs/](https://pkp.sfu.ca/software/ojs/)

[^15]: [https://solidproject.org](https://solidproject.org/)

[^16]: [https://prereview.org](https://prereview.org/)

[^17]: [https://www.eventnotifications.net](https://www.eventnotifications.net/)

[^18]: [https://notify.coar-repositories.org](https://notify.coar-repositories.org/)

[^19]: [https://joinmastodon.org](https://joinmastodon.org/)

[^20]: [https://friendi.ca](https://friendi.ca/)

[^21]: [https://joinpeertube.org](https://joinpeertube.org/)

[^22]: [https://hal.science](https://hal.science/)

[^23]: [https://prereview.org](https://prereview.org/)

[^24]: [https://peercommunityin.org](https://peercommunityin.org/)

[^25]: See 1st Phase Partners at [https://www.coar-repositories.org/notify/](https://www.coar-repositories.org/notify/)

[^26]: [https://knows.idlab.ugent.be/projects/mellon/](https://knows.idlab.ugent.be/projects/mellon/)

[^27]: [https://solidproject.org/TR/](https://solidproject.org/TR/)

[^28]: [https://solidproject.org/developers/tutorials/getting-started](https://solidproject.org/developers/tutorials/getting-started)

[^29]: [https://fedora.lyrasis.org](https://fedora.lyrasis.org/)

[^30]: [https://www.w3.org/2005/Incubator/webid/spec/identity/](https://www.w3.org/2005/Incubator/webid/spec/identity/)

[^31]: [https://solidproject.org/TR/oidc](https://solidproject.org/TR/oidc)

[^32]: [https://solidproject.org/TR/wac](https://solidproject.org/TR/wac)

[^33]: [https://github.com/CommunitySolidServer/CommunitySolidServer](https://github.com/CommunitySolidServer/CommunitySolidServer) . In our experiment we use CSS version 6.1.0. This version requires NodeJS version 16.14.0 be installed or better. An easy way to install a NodeJS version is by using the Node Version Manager (NVM) script [https://github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm).

[^34]: See, e.g., the CSS configuration generator [https://communitysolidserver.github.io/configuration-generator/v6/](https://communitysolidserver.github.io/configuration-generator/v6/)

[^35]: [https://www.w3.org/TR/ldp/](https://www.w3.org/TR/ldp/)

[^36]: [https://docs.inrupt.com/developer-tools/javascript/client-libraries/authentication/](https://docs.inrupt.com/developer-tools/javascript/client-libraries/authentication/)

[^37]: [https://github.com/inrupt/solid-client-java](https://github.com/inrupt/solid-client-java)

[^38]: [https://github.com/SolidLabResearch/Bashlib](https://github.com/SolidLabResearch/Bashlib)

[^39]: [https://w3c.github.io/N3/spec/](https://w3c.github.io/N3/spec/)

[^40]: See [https://gist.github.com/phochste/08a3898bd59ce7c2c80bee1ae8a38aa0](https://gist.github.com/phochste/08a3898bd59ce7c2c80bee1ae8a38aa0) for the full example

[^41]: See: [https://github.com/eyereasoner/Koreografeye-Plugin](https://github.com/eyereasoner/Koreografeye-Plugin) for example plugins

[^42]: [http://cermine.ceon.pl/index.html](http://cermine.ceon.pl/index.html)

[^43]: [http://opencitations.net](http://opencitations.net/)

[^44]: [https://biblio.ugent.be/](https://biblio.ugent.be/)

[^45]: [http://opencitations.net/index/api/v1#/references/%7Bdoi%7D](http://opencitations.net/index/api/v1%23/references/%257Bdoi%257D)

[^46]: [https://github.com/MellonScholarlyCommunication/OAI-Bridge](https://github.com/MellonScholarlyCommunication/OAI-Bridge)

[^47]: [https://github.com/MellonScholarlyCommunication/CitationExtractorService](https://github.com/MellonScholarlyCommunication/CitationExtractorService)

[^48]: [https://github.com/MellonScholarlyCommunication/CitationRelayService](https://github.com/MellonScholarlyCommunication/CitationRelayService)

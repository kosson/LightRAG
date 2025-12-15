---
title: "Using Cloud Services for Library IT Infrastructure"
source: "https://journal.code4lib.org/articles/2510"
author:
  - "[[The Code4Lib Journal]]"
published: 2010-03-23
created: 2025-01-10
description: "Cloud computing comes in several different forms and this article documents how service, platform, and infrastructure forms of cloud computing have been used to serve library needs. Following an overview of these uses the article discusses the experience of one library in migrating IT infrastructure to a cloud environment and concludes with a model for [...]"
tags:
  - "clippings"
---
# Using Cloud Services for Library IT Infrastructure
Erik Mitchell

Cloud computing comes in several different forms and this article documents how service, platform, and infrastructure forms of cloud computing have been used to serve library needs. Following an overview of these uses the article discusses the experience of one library in migrating IT infrastructure to a cloud environment and concludes with a model for assessing cloud computing.

## Introduction

This article examines some of the key issues related to the use of different forms of cloud computing in libraries and discusses the experience of one library in moving to cloud-based infrastructure. Cloud computing refers to the abstraction of information technology (IT) software and services from the hardware they run on. The National Institute of Standards and Technology (NIST) expands this definition by examining specific characteristics (e.g. self-service, resource pooling, and elasticity), management models (e.g. service, platform, or infrastructure focus), and deployment models (e.g. public, private) (NIST, 2009).

Cloud platforms enable organizations to use external expertise and resources to deliver complex services, remove the need for organizations to invest in server infrastructure, and lower the cost for organizations seeking elastic computing resources. Libraries have been adopting cloud-based solutions for different services including electronic journal access management, statistics tracking, digital library hosting, and even integrated library system (ILS) hosting. This has allowed libraries to make strategic choices about the allocation of resources and to offer better service than would be possible if relying on in-house solutions.

While much of the focus on cloud computing in libraries has been on subscription service or platform (e.g. ILS hosting) there are cases where libraries need computing resources for requirements that are not provided by service or platform providers. This article looks specifically at the experience of one library in moving its IT infrastructure to cloud-based environments. The article seeks to address how well these systems fill library IT needs, asks what other elements define the success of the use of cloud-based infrastructure and concludes with a case study discussion of one experience.

## The State of Cloud Computing in Libraries

Cloud computing can be divided into three categories: Software-as-a-Service (SaaS), Platform-as-a-Service (PaaS), and Infrastructure-as-a-Service (IaaS). In a SaaS environment, organizations use an application via a hosted service. They do not have access to the underlying infrastructure (i.e. network or server elements) and are not responsible for managing the underlying software. A common library example is electronic journal subscription management systems. PaaS solutions focus on providing a hosted platform on which a specific application can be deployed. This platform is often some provisioned space and computing resources from a hosting company running a pre-configured set of tools. Organizations can deploy a locally developed or managed application on the platform but do not manage the underlying server infrastructure. Platform management is often done using an application such as cPanel or Plesk. IaaS environments allow users to provision servers, storage space, and networking components to meet their computing needs. In an IaaS environment, the organization is responsible for starting and sizing a server, managing its network access, and ensuring that the core server components (e.g. operating system, web server, firewall) are configured correctly.

Libraries have quietly been on the forefront of cloud computing technology for a number of years. The use of SaaS in libraries reaches back into early 2000 with the establishment of companies like SerialsSolutions ([http://serialssolutions.com](http://serialssolutions.com/)). Much of the work in migrating to electronic journals has focused on an SaaS platform and recent companies such as LibGuides ([http://www.libguides.com](http://www.libguides.com/)) have shown that libraries are willing to invest in SaaS solutions. In the IaaS arena, Amazon Elastic Computing Cloud (EC2) offers IT infrastructure for organizations to launch differently sized servers using a variety of operating systems, including several flavors of Linux and Windows. EC2 provides organizations with essentially unlimited storage using their S3 service, the ability to take snapshots of both data and servers, and the ability to include EC2 servers in an organization’s private network. A full catalog of EC2 features is available on the EC2 website ([http://aws.amazon.com/ec2/](http://aws.amazon.com/ec2/)).

Wheeler and Waggener (2009) use this classification (SaaS, PaaS, and IaaS) as a launching pad to discuss ways in which they can be used to enable collaboration or ‘sourcing’ between institutions and consortia. Marshall Breeding (2009) places these three types of services within the context of other infrastructure and hosting options such as co-location (the duplication of specific IT resources in multiple places), shared and dedicated hosting (licensing a shared or distinct portion of a server for use), and cloud computing (abstracting the hardware, software, and service layers to provide an extensible computing environment). Embedded within these classifications are needs and use arguments, organizational goals, and institutional priorities. For example, Wheeler and Waggener point out that organizations have different goals for adopting cloud computing and suggest that these goals are embedded in a complex web of cost, needs, priorities and organizational culture.

Libraries are in a unique position to experiment with cloud computing given their service-oriented mission and need to find appropriate solutions using limited resources. Fox observes that the goals of the organization have an impact on their use of cloud solutions (2009). For example, he observes that one of the key pressures that both pushes libraries to cloud solutions and proves to be an impediment to the migration is the availability of IT support services. Libraries are often supported by external or organization level IT services and do not have internal expertise on advanced IT management. Further, Fox observes that libraries may be governed by policies and regulations that dictate how they can use cloud-based solutions. Both of these factors make SaaS and PaaS approaches appealing, and make IaaS approaches difficult to consider. Despite this, many libraries have been active in investigating innovative uses of cloud computing (Kroski, 2009), including new ways of using infrastructure services. Kroski’s article mentions the use of Amazon EC2 services by both the DC Public Library system and OhioLink to provide library IT services using IaaS techniques.

Critics of cloud computing observe that the transition to remote and subscription based resources opens up organizations to new legal and operational challenges. Critics also ask whether or not the major cloud-computing platforms are open enough to trust (Truitt, 2009) and suggest that new government regulations and policies are required to ensure openness and sustainability (Nelson, 2009). In addition to these high-level concerns, a number of technical concerns exist such as how to include cloud-based applications within the organizational network, how to back up and archive information located in the cloud, and how to manage services in a decentralized environment.

Cloud-hosting organizations have taken steps to address some of these concerns. For example, Amazon has added features to their core Elastic Computing Cloud (EC2) service, including private connectivity between cloud-servers and an organization’s network (Virtual Private Cloud); Elastic Block Store (EBS) based storage which offers bit-level snapshots and persistence across server instances; and server-monitoring and management tools. Amazon also established service level agreements (SLA) that apply to all services running on their cloud platform ([http://aws.amazon.com/ec2-sla/](http://aws.amazon.com/ec2-sla/)). These SLAs define not only uptime but also address security and legal issues.

Regardless of the concerns or skepticism of the authors, the literature on cloud computing and the expanding use of cloud platforms indicates that cloud computing is still a growing field. Both the Gartner Hype report on cloud computing (2009) and the Educause Horizon report (2009) point to the expansion of cloud services in the coming years. Libraries and especially academic organizations have largely followed suit, having already migrated key services such as OpenURL providers, and federated and pre-indexed search engines. Fox (2009), for example, discusses the growing trend of hosted ILSes. Libraries who take this approach using a platform or infrastructure approach are doing so with some risk, however, as PaaS and IaaS solutions tend to offer less support for these types of applications.

## Case Study in Infrastructure Services in the Cloud

For the last two years, the Z. Smith Reynolds Library ([http://zsr.wfu.edu](http://zsr.wfu.edu/)) has been focusing on migrating key IT services to cloud-based or hosted environments. As part of this migration we have also focused on moving our key systems to open source options. We have found that these two goals are not always in sync with each other and have some applications which are decidedly not open source but work well in hosted environments and vice versa. The table below shows which applications have already been migrated or are in the process of being migrated to cloud environments. Over time, we expect to migrate PaaS based services to IaaS platforms. Services which are not yet in the cloud include our library website, digital library applications, and institutional repository.

| Platform | Applications |
| --- | --- |
| SaaS | OpenURL resolver, journal listing service, instructional guides, reserves statistics, IM/chat service |
| PaaS | ILS, archives management software, initial website applications |
| IaaS | Institutional repository discovery layer, ILS discovery layer |

**Table 1**: Inventory of Current Cloud-Based Solutions

As we continued to transition to cloud services our discussion centered on key IT issues:

- Service level agreements – What assurances do we have for uptime, legal protection, and security?
- Uptime and reliability – How does this provider compare to being able to locally host and manage our resources?
- Cost and affordability – What personnel and technology resources are involved with a hosted versus local solution?  How does this cost model look over time?
- Legal and organizational issues – What organizational and legal issues do we need to consider?  Are we dealing with patron data?  Are we sure that the platform and our connection to it are secure?
- Staff knowledge – How would migrating to this platform impact staff knowledge and competency?  Do we know everything that we need to know?

An initial needs analysis indicated that while we enjoyed good university-wide infrastructure, it was becoming increasingly difficult to launch and manage specific applications. For this reason we decided to examine cloud computing as a way of delivering our core library applications including our ILS, website, and digital library systems.

In late 2008 we licensed our first hosted server that was in essence a PaaS solution. We chose a virtual private server with a leading hosting company. The server was fairly small (20 GB of storage space, 512 MB of dedicated RAM) but offered us total flexibility over the system in addition to an easy to use control panel (Plesk). Over the course of the year we used the platform for experimenting with remote access and application management. In 2009 we implemented the Archivists’ Toolkit on the system as a test application and found that it served well although the archivists reported slower system response times than they would like. Further, the server had no easy way to expand drive space and we were looking to begin storing larger amounts of data.

In early 2009 we began investigating hosting options for our ILS. We examined several options but decided to use the ILS vendor given their familiarity with the system and SLA. We completed the migration to their environment in the summer of 2009 and began looking at where our other applications including the website, discovery services, and digital library services could live. After a survey of available providers we chose to focus on Amazon’s EC2 service. Our initial investigation proved interesting but not overwhelmingly positive. For example, although the infrastructure was robust, the command line tools required to manage the instances would not be easy for everyone to use and both the servers and the data stored on the primary partition disappeared when stopped. During the course of our investigation, however, these concerns were addressed with new developments and we decided to bring up our first server in the fall of 2009.

Amazon proved to be a good choice given their scalable server solutions and easy to use management consoles. For example, there were a number of base server images available to work with including open source and proprietary platforms. Further, the ability to easily mount large amounts of disk space via their EBS service gave us the ability to implement data-rich services. Finally, the Amazon Management Console allowed us to easily start, stop, and manage our servers. Recent developments in creating EBS based volumes provides users the ability to stop instances without losing them. In addition to this the EBS snapshot tools are available to create server images. This allowed us to simplify our images as we did not have to find a way to store server logs on a separate EBS volume in case the instance died unexpectedly. Amazon also had long-standing features such as the ability to set a firewall at the EC2 service layer and the ability to swap IP addresses on servers easily. These features simplified our implementation and made it easy to switch between development and production environments. In addition to these features Amazon offers a number of other options including automatic load balancing, connection with campus networks via virtual private cloud and auction-style access to server time.

## Evaluating Cloud Computing

In order to assess the success of our initial migration to Amazon EC2 services, we assessed three central areas; 1) quality and stability of service, 2) impact on our ability to provide library services, and 3) comparison of cost with local technology solutions.

### Quality of Service

Our initial experience with the quality of the EC2 service has been very positive. Amazon’s legal agreements and SLAs adequately addressed our concerns for data security and uptime. Like many libraries we have become comfortable using SaaS-style services for other solutions and are increasingly reliant on Internet connectivity, so moving our core application infrastructure outside the campus network proved to be a non-issue. Further, the quality of the company and community documentation ([http://aws.amazon.com/documentation/](http://aws.amazon.com/documentation/)) has made finding solutions to common problems such as server configuration, backups, and archives fairly easy.

### Impact on Library Services

One reason that SaaS and PaaS solutions are difficult to implement in libraries is that our core applications often require specialized software or configurations which are either localized or simply application specific. By using an infrastructure level service we were able to bring our library applications online without having to find a service that supported the correct versions of the underlying technology. Further, having the ability to mount new applications quickly without having to focus on identifying available server space has meant that we can offer technology-based library services much more quickly than when using locally-based hardware. This separation of machine images and data from the hardware they are currently running on provides us the ability to minimize downtime in the case of hardware failures.

Granted, moving our key application infrastructure outside of the campus network means that during Internet connectivity issues we will have none of our key services (e.g. website, ILS, discovery layer). While a full plan has not been put in place to handle this contingency, the library is currently configuring a local machine that will be capable of serving up a scaled-down version of the library website and a snapshot of the library catalog running on a locally installed version of our discovery layer (Vufind).

### Cost Comparison

Calculating the total cost of ownership (TCO) of technology can be difficult, and there seems to be more research which questions the validity of these measures than research comparing cloud and traditional solutions. For example, Golden (2009) found that when including electricity and administrative costs Amazon’s pricing was comparable with the cost of in-house managed servers. Other research, however, indicates that simply swapping in-house for virtual servers does not result in a lowering of TCO (Leong, 2009). Further, the impact of cost comparisons on cloud computing indicate that minimal cost savings may not be a sufficient inducement to change. A recent Gartner research article points to larger issues such as security and operational concerns as key factors (Harris & Smith, 2009).

Our own cost-benefit analysis indicated that EC2 had similar costs but provided operational benefits. We were facing the need to replace our two servers and large disk array, and in comparing the cost of the hardware projected over five years against the cost of EC2 and EBS data volumes for the same time period we found that the costs were comparable. The initial experience of running our discovery layer on a single small instance server showed actual costs of approximately $100 per month including CPU time, data storage, and I/O fees. After analyzing the actual used capacity of our servers, we found that most of our applications could run on two Amazon EC2 small servers (1 CPU, 1.7 GB Ram) ([http://aws.amazon.com/ec2/#instance](http://aws.amazon.com/ec2/#instance)). As we add our digital objects to the system we will see increased data storage and backup fees.

## Observations and Next Steps

While we can call our initial transition to cloud computing a success we have had to work through several challenges. First, we found that working with EC2 required some additional training for our staff. While there is good documentation offered by Amazon, understanding system architecture in a cloud environment and working out the security issues required careful attention. Second we found that while Amazon was the most mature of the services on the market when we started, the market is changing rapidly and we will need to remain tuned in to changes to ensure that we make use of new options. For example, the establishment of persistent images was a significant step forward in easing our transition to EC2. Finally, we found that while EC2 made it possible for us to mount and configure new servers quickly, it took coordination with campus IT services to bring these servers online in a way that was seamless for our patrons.

Placing our applications on IaaS platforms provided us with a flexibility which we had not previously enjoyed with local servers. As a result, the library has been positioned to be more responsive to new developments in the coming years. As the IaaS market matures we are looking for services to become more affordable and standardized. Further, as more libraries become comfortable with using applications on IaaS platforms it becomes possible to share and mount appliance-style servers that serve distinct purposes.

## About the Author

Erik Mitchell ([http://erikmitchell.info](http://erikmitchell.info/)) is the Assistant Director for Technology Services at the Z. Smith Reynolds Library in Winston Salem, NC.

## Works Cited

*2009 Horizon Report | EDUCAUSE*. (2009, January 20). Educause. Retrieved January 25, 2010, from [http://www.educause.edu/ELI/2009HorizonReport/163616](http://www.educause.edu/ELI/2009HorizonReport/163616).

Breeding, M. (2009). The Advance of Computing From the Ground to the Cloud. *Computers in Libraries*, 29(10), 22-25. [(COinS)](https://journal.code4lib.org/coins)

Fox, R. (2009). Library in the clouds. *OCLC Systems & Services*, 25(3), 156-161. doi: [10.1108/10650750910982539](http://dx.doi.org/10.1108/10650750910982539). [(COinS)](https://journal.code4lib.org/coins)

Golden, B. (2009, February 19). The Case Against Cloud Computing, Part Four – CIO.com – Business Technology Leadership. Cio.com. Retrieved January 25, 2010, from [http://www.cio.com/article/480595/The\_Case\_Against\_Cloud\_Computing\_Part\_Four](http://www.cio.com/article/480595/The_Case_Against_Cloud_Computing_Part_Four)

Harris, M., & Smith, D. M. (2009, September 8). Higher Education Q&A: Cloud Computing. Gartner Research. Retrieved January 25, 2010, from [http://my.gartner.com/portal/server.pt?open=512&objID=260&mode=2&PageID=3460702&resId=1169112&ref=QuickSearch&sthkw=cloud+computing+cost](http://my.gartner.com/portal/server.pt?open=512&objID=260&mode=2&PageID=3460702&resId=1169112&ref=QuickSearch&sthkw=cloud+computing+cost).

Hype Cycle for Cloud Computing, 2009. (2009, July 16). Gartner Research. Retrieved January 25, 2010, from [http://my.gartner.com/portal/server.pt?open=512&objID=260&mode=2&PageID=3460702&resId=1078112&ref=QuickSearch&sthkw=cloud+computing+cost](http://my.gartner.com/portal/server.pt?open=512&objID=260&mode=2&PageID=3460702&resId=1078112&ref=QuickSearch&sthkw=cloud+computing+cost).

Leong, L. (2009, June 16). Software on Amazon’s Elastic Compute Cloud: How to Tell Hype From Reality. Gartner Research. Retrieved January 25, 2010, from [http://my.gartner.com/portal/server.pt?open=512&objID=260&mode=2&PageID=3460702&resId=1022715&ref=QuickSearch&sthkw=cloud+computing+tco](http://my.gartner.com/portal/server.pt?open=512&objID=260&mode=2&PageID=3460702&resId=1022715&ref=QuickSearch&sthkw=cloud+computing+tco).

Nelson, M. R. (2009). The Cloud, the Crowd, and Public Policy. *Issues in Science & Technology*, 25(4), 71-76.  
[(COinS)](https://journal.code4lib.org/coins)

NIST. (2009). NIST.gov – Computer Security Division – Computer Security Resource Center. Retrieved February 12, 2010, from [http://csrc.nist.gov/groups/SNS/cloud-computing/index.html](http://csrc.nist.gov/groups/SNS/cloud-computing/index.html).

Truitt, M. (2009). Editorial: Computing in the “Cloud”. *Information Technology & Libraries*, 28(3), 107-108. [(COinS)](https://journal.code4lib.org/coins)

Wheeler, B., & Waggener, S. (2009). Above Campus Services: Shaping the Promise of Cloud Computing for Higher Education. *Educause Review*, 44(6), 52-66. [(COinS)](https://journal.code4lib.org/coins)
---
title: "Node-Based Configuration Management Architecture for Private LOCKSS Networks"
source: "https://journal.code4lib.org/articles/11909"
author:
  - "[[The Code4Lib Journal]]"
published: 2016-10-25
created: 2025-01-10
description: "Node-based configuration management describes a services architecture for Private LOCKSS Networks that transfers administrative services onto a peer preservation node in the network. The architecture also describes techniques for enabling full redundancy of data for configuration administration utilizing the preservation protocols in LOCKSS. The goal of node-based configuration management is a horizontal administrative model where [...]"
tags:
  - "clippings"
---
# Node-Based Configuration Management Architecture for Private LOCKSS Networks
Tobin M. Cataldo

Node-based configuration management describes a services architecture for Private LOCKSS Networks that transfers administrative services onto a peer preservation node in the network. The architecture also describes techniques for enabling full redundancy of data for configuration administration utilizing the preservation protocols in LOCKSS. The goal of node-based configuration management is a horizontal administrative model where any peer node can assume administrative services with complete redundancy of configuration data across all nodes.

## LOCKSS

LOCKSS (**L**ots **O**f **C**opies **K**eeps **S**tuff **S**afe)[<sup>[1]</sup>](https://journal.code4lib.org/articles/#_ftn1) is digital preservation software that creates a preservation model by emphasizing geographical distribution of identical replicas across multiple, potentially heterogeneous, storage devices or preservation nodes. The core concept is that systemic failure at any single location does not affect the validity and reliability of data preserved in the other nodes.

LOCKSS is a Java software suite that runs well on CentOS.[<sup>[2]</sup>](https://journal.code4lib.org/articles/#_ftn2) LOCKSS is typically installed via RPM.[<sup>[3]</sup>](https://journal.code4lib.org/articles/#_ftn3) In most cases, preservation storage is defined on disk partitions over RAID 5 or RAID 6. LOCKSS is open source and the code repositories are available.[<sup>[4]</sup>](https://journal.code4lib.org/articles/#_ftn4)

LOCKSS supports two generic use cases of the preservation software: post-cancellation access to electronic serials content, or Global LOCKSS Network (GLN), and closed networks of known peers for distribution and preservation of digital data, or Private LOCKSS Networks (PLN).[<sup>[5]</sup>](https://journal.code4lib.org/articles/#_ftn5) Both use models can operate under the same technical and administrative architecture. Membership in the LOCKSS Alliance is requisite for participation in the GLN as well as many extant PLNs.[<sup>[6]</sup>](https://journal.code4lib.org/articles/#_ftn6)

The Alabama Digital Preservation Network (ADPNet)[<sup>[7]</sup>](https://journal.code4lib.org/articles/#_ftn7) is a Private LOCKSS Network originally modeled under the technical and administrative architecture that characterizes the Global LOCKSS Network. In the original architecture, LOCKSS controls the single authoritative source for the distributed preservation network. While this model has worked well for many years, ADPNet, like any maturing network, experienced both a need for more internal control as well as a need to identify and reduce external vulnerabilities that potentially could affect continuous service. As a result, ADPNet researched and instituted preservation node-based configuration management. Node-based configuration management is an alternative management model that seeks to flatten a hierarchical administrative model by enabling the preservation node to serve as the network’s administrative source and create a more failsafe network with redundancy.[<sup>[8]</sup>](https://journal.code4lib.org/articles/#_ftn8) In node-based configuration management, a preservation node is promoted to the configuration services provider and exposes network configuration data through ancillary software. The goal of this model is to create an administrative system that can be transferred to any preservation node without significant impact on continuous preservation services.This administrative model has been in place at ADPNet since December 2015.

## The Node is the Master

Private LOCKSS Networks are closed networks with established perimeter controls that identify known preservation peers. Critical configuration data for the preservation software are referenced by URL, and in most instances name-based URL routing is utilized. A PLN takeover of configuration services could follow two routes: bring new software online on new hardware (not a known preservation peer); or promote a preservation peer to the configuration services provider and enable the other peers to ingest the data necessary for node promotion using the LOCKSS preservation software.

As a distributed network, discrete PLN infrastructure is typically under direct administration of the hosting institution, and a PLN may have little or no centralized administrative control at the firewall or the server. Changes in configuration services endpoints that result in IP changes could result in a bottleneck for continuous service while various security and access lists are updated. This is particularly true when configuration services are brought up on new hardware at a member institution. Should that hardware fail or network membership changes force a relocation of configuration services, new server infrastructure would need to be in introduced and each network member would need to add firewall and access controls.

The second method of modeling configuration services takeover is to utilize a preservation node and promote it to the configuration services provider. In order to minimize preservation network vulnerability and maximize redundancy, it is not enough to simply promote a node. Rather, the promoted node should expose the data necessary to promote a peer preservation node with little downtime and without loss of data. Typically, this can be accomplished by introducing ancillary software onto the preservation node to expose the configuration data as sources and defining the exposed sources as an archival unit in the title list. Preservation nodes must be known to the peers, and leveraging a known network host to provide non-intensive services is the most seamless way to achieve continuous service without additional investment in redundant hardware and infrastructure.

The services a promoted node should provide:

- Lockss.xml
- Title list
- Plugin repository
- Signing keystore
- Server configuration data exposed as an archival unit (AU)[<sup>[9]</sup>](https://journal.code4lib.org/articles/#_ftn9)

The resources needed to provide these services:

- Storage
- Web server
- Data store (database)
- Processing language

There are various methods of delivering the configuration data, and most of the data could be reduced to static files. The LOCKSS.xml file is relatively unchanging as are the plugins. In some scenarios, the title list could also be relatively unchanging. For unchanging data, simply exposing that data over HTTP would suffice. However, a moderate to heavily used PLN should incorporate architecture that enables reuse of title list components to enable additional administrative services, such as centralized AU status reporting, and more complex storage design, such as data partitioning.[<sup>[10]</sup>](https://journal.code4lib.org/articles/#_ftn10) Dynamically creating the title list also lends itself to limited recovery crawls via host specific title list parameters (i.e. crawl\_proxy).[<sup>[11]</sup>](https://journal.code4lib.org/articles/#_ftn11) Host specific title list parameters facilitate peer-to-peer recrawls without impacting network state. Moreover, there is less potential for error by maintaining a single definition set for multiple purposes rather than multiple definition sets for a single purpose. For these reasons, the configuration services model at ADPNet was based on relational database storage with dynamic assembly and delivery of XML streams over HTTP.

## Node-Based Configuration Services Software

The goal of node-based configuration is to create a network administrative model that can be transferred to any of the preservation nodes. Any software utilized should be stable, common, small, easily configured, and have potential for extensibility. Preservation nodes take a long view and stability is a must. By selecting common software, there is a greater likelihood of pre-existing institutional knowledge of software package administration. As configuration services provision is not the primary purpose of a preservation node, software should be small and utilize minimal resources. Software should also be easily configured so as to minimize the potential downtime during transference of configuration services. Software should also demonstrate capacity for extensibility so new changes can be incorporated without a full stack rework.

**Storage**

The preservation node storage array (in most cases spinning disks in a RAID 5 or RAID 6 configuration) provides sufficient storage space for the configuration services without negative effect. In practice, preservation nodes can economically extend to 72 TB or more of raw storage.

```
Command prompt

Example File system information
(using # to indicate command prompt)

# cat /proc/mdstat
…
md0 : active raid1 sda1[0] sdb1[1]
...
md1: active raid6 sdc1[0] sdd1[1] sde1[2] sdf1[3]
…

With file system mounts
# cat /etc/fstab
…
/dev/md0      /            ext3
/dev/md1      /cache0       ext3
```

The OS partition typically contains more than enough storage to house the OS, LOCKSS software, and the ancillary software for configuration services takeover. According to size as reported by *yum info*, the impact of the ancillary software on storage space in the OS partition amounts to less than 750 megabytes. The promoted node at ADPNet reports sufficient operational space.

```
Command prompt

# df -h /
Filesystem     Size Used Avail Use% Mounted on
/dev/md0       7.5G 3.2G 4.4G 42% /
```

The software used to provide configuration services was selected, in some part, by its ability to define data directories external to the default install paths. Software installed via yum or other package managers typically are installed in the OS drive. Any software with more than minimal data use should redirect data directories outside of the OS drive.

```
Command prompt

# df -h /cache0
Filesystem     Size Used Avail Use% Mounted on
/dev/md1       2.7T 2.0T 564G 79% /cache0
```

A common storage pattern in LOCKSS may appear like:

- /cache0/gamma

Configuration services software data directories could easily be inserted into the storage pattern:

- /cache0/configuration

**Data Store – MySQL**

MySQL is common, small, easily configured, and powerful. The configuration file (my.cnf) is transportable and the data directory locations are definable. MySQL can be installed and maintained from yum.[<sup>[12]</sup>](https://journal.code4lib.org/articles/#_ftn12) [<sup>[13]</sup>](https://journal.code4lib.org/articles/#_ftn13) Data in a MySQL database is easily transferrable as a static file over HTTP via mysqldump output.[<sup>[14]</sup>](https://journal.code4lib.org/articles/#_ftn14)

```
Command prompt

Get the Repo stub.

# wget http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
# yum localinstall mysql57-community-release-el7-7.noarch.rpm

Get MySQL Community Server from repo
# yum info mysql-community-server.x86_64
--> version 5.7.10 (current, at this time)
# yum install mysql-community-server.x86_64
```

Replication of data to peer nodes is also an option but would require MySQL to be running on each node. By utilizing static file transfer and staging the data as an AU, the LOCKSS software on the distributed peer nodes can crawl, ingest and preserve the configuration data following normal routines.

Changing the default MySQL data directory on SELinux enabled systems can pose an initial challenge.[<sup>[15]</sup>](https://journal.code4lib.org/articles/#_ftn15)

```
Command prompt

# yum install policycoreutils-python
# getenforce
--> Enforcing
# semanage fcontext -a -t mysql_db_t “/cache0/configuration/data(/.*)?”
# restorecon -Rv /cache0/configuration/data
```

In the ADPNet implementation, MySQL is not accepting TCP connections and the data directory is defined to reside in /cache0.

```
My.conf file

[mysqldump]
protocol = SOCKET
socket = /cache0/configuration/data/mysql/mysql.sock

[mysqld]
…
datadir=/cache0/configuration/data/mysql
socket=/cache0/configuration/data/mysql/mysql.sock
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
```

**Web Server – Apache**

Apache HTTP Server can be installed from yum, however the repository version is not the most current version. PLNs are closed networks and the needed ability to bring this software up easily weighed against software freshness. Current resource requirements of Apache HTTP Server are significantly less than previous generations. Apache supports name-based virtual hosting, proxy passthroughs, and mod\_wsgi. The Apache configuration files are easily transferrable.

```
Command prompt

Modify SELinux

Check the contexts with
# semanage fcontext -l | grep httpd_sys

# semanage fcontext -a -t httpd_sys_content_t “/cache0/configuration/data/web(/.*)?”
# restorecon -Rv /cache0/configuration/data/web

# setsebool -P httpd_can_network_connect = 1
```

The web server software can be made to expose the httpd and mysql configuration files for crawling over HTTP by creating symbolic linking to the files in a web accessible directory.

```
httpd.conf file

# (# indicates comments)

# Alias the /cache0/configuration directory
Alias /configuration /cache0/configuration/data/web/staging
```

By creating symbolic links to the production configuration files, changes to those files are immediately transparent to the distributed preservation nodes seeking to crawl that content.

```
Command prompt

# cd /cache0/configuration/data/web/staging/takeover/conf
apache
# ln -s /etc/httpd/conf/httpd.conf httpd.conf
# ln -s /etc/httpd/conf/httpd_peers.conf httpd_peers.conf
# ln -s /etc/httpd/conf/configuration.adpn.conf configuration.adpn.conf
# ln -s /etc/httpd/conf.d/autoindex.conf autoindex.conf
mysql
# ln -s /etc/my.cnf my.cnf
```

![](https://journal.code4lib.org/media/issue34/cataldo/figure1.png)  
**Figure 1.** Configuration files exposed.

With Apache HTTP Server, exposing sources of executable applications can be accomplished through aliases with alternative directives through each path. The result is local applications that can be executed and exposed as source files from the same file system directory.

```
httpd.conf file

# mod_wsgi installed with easy_install
LoadModule wsgi_module modules/mod_wsgi-py27.so

WSGIScriptAlias /titlelist 
/cache0/configuration/data/web/staging/takeover/titles/application.py

# location instead of directory, as alias to directory
# via configuration should include indexes

<Location /titlelist>
AllowOverride None
Options None
</Location>

Alias /configuration /cache0/configuration/data/web/staging

<Location /configuration>
AllowOverride None
Options +Indexes

#IndexIgnore . .. manifest.html Thumbs.db
IndexIgnore . .. Thumbs.db
IndexOptions IgnoreClient
IndexOptions XHTML

ServerSignature off
</Location>
```

![](https://journal.code4lib.org/media/issue34/cataldo/figure2.png)  
**Figure 2.** Title list sources exposed.

**Processing Language – Python**

Python is common, small, extensible and does not require a separate build environment. Moreover, Python 2.7 is already installed on the CentOS servers. Python works well with Apache HTTP Server when connected with mod\_wsgi. Python libraries are sufficiently available for extensibility. Werkzeug works well to handle common HTTP tasks, and suds can be added to support AU status lookups via SOAP requests.

**Connectors and Libraries**

- mod\_wsgi[<sup>[16]</sup>](https://journal.code4lib.org/articles/#_ftn16) via easy\_install (current)
- werkzeug[<sup>[17]</sup>](https://journal.code4lib.org/articles/#_ftn17) via easy\_install (current)
- suds[<sup>[18]</sup>](https://journal.code4lib.org/articles/#_ftn18) via yum (current)
- MySQL Connecter/Python[<sup>[19]</sup>](https://journal.code4lib.org/articles/#_ftn19) via yum (current)

```
Command line

Need extra libraries to build Apache modules
# yum install httpd-devel.x86_64
# yum install gcc
# yum install python-devel.x86_64

# easy_install --dry-run mod_wsgi
# easy_install mod_wsgi (version 4.4.21)
# cp /usr/lib/python2.7/site-packages/mod_wsgi-4.4.21-py2.7-linux-
   x86_64.egg/mod_wsgi/server/mod_wsgi-py2.7.so /etc/httpd/modules/

# easy_install --dry-run werkzeug
# easy_install werkzeug (version 0.11.2)

# yum install python-suds.noarch
# yum install mysql-connector-python.x86_64
```

## Configuration Data as an Archival Unit

A critical component of creating configuration services redundancy in the network is to define the exposed configuration services data as an archival unit. In LOCKSS, an archival unit (AU) is a set of URLs.[<sup>[20]</sup>](https://journal.code4lib.org/articles/#_ftn20) When the URLs of the configuration services data are defined as an AU, LOCKSS regularly crawls and preserves (caches) those data in the file system. The current LOCKSS version file system organization of the cached URL is dependent on the access URL.[<sup>[21]</sup>](https://journal.code4lib.org/articles/#_ftn21) Modifications of the access URL of an established AU can result in either a uncrawlable AU or a new cached URL set. By utilizing DNS to define a persistent name-based URL that can terminate at any of the preservation nodes, the AU definition and the preservation of the AU data are unaffected by configuration services transfer between nodes.

## Network Topography

Configuration data is exposed as an archival unit and cached in each preservation node. The result is each node has the core data requisite to serve as the configuration provider.

![](https://journal.code4lib.org/media/issue34/cataldo/figure4.jpg)  
**Figure 4.** DNS identifies current node acting as the configuration services provider.

In the event of a system failure, institutional withdrawal from the network, or other event that affects the ability to provide configuration services, a network peer can be promoted to the configuration server, load the current configuration data and begin offering configuration services quickly.

![](https://journal.code4lib.org/media/issue34/cataldo/figure5.jpg)  
**Figure 5.** Configuration services transferred to new node.

## URL Persistence with DNS

By abstracting references to name-based URL routing, a number of problems related to fixed IP references can be mitigated. LOCKSS preservation networks depend heavily on IP references for node communication. By utilizing name-based addressing for the configuration services provider the underlying IP for the name-based resolution is transferrable. DNS represents the easiest route to modular addressing by updating the answer record as needed. In terms of redundancy and failsafe operations, dependency on an external DNS server, potentially administered by a single network member, may introduce unacceptable vulnerability in the preservation network. An alternative is to modify */etc/hosts* on each node. By updating the IP for the fully qualified domain name on each node’s */etc/hosts*, the need for external DNS resolution is removed. While removing external dependencies is an important consideration, the PLN should also balance ease of use and maintainability. ADPNet utilizes an external DNS service under the administration of a network member.

## Storage Schema

The title list can be provided to network peers in various ways. ADPNet has implemented a database storage solution. The title list is normalized into a relational schema and reconstructed on XML streams over HTTP. The resultant title list could either be generic for all nodes, or node-specific by utilizing the *org.lockss.titleDbs* parameter in LOCKSS Expert Config.[<sup>[22]</sup>](https://journal.code4lib.org/articles/#_ftn22)

![](https://journal.code4lib.org/media/issue34/cataldo/figure6.png)  
**Figure 6.** Relational schema for title list and title status.

## Archival Unit Status Reporting

The LOCKSS UI reports on node-specific server and AU state. While this type of information is useful to system administrators maintaining the local preservation node, it does not communicate value to executive leadership. Pivoting from the node-oriented to the AU-oriented view of the data allows aggregation of AU state across all nodes. This helps answer some questions related to the overall health of an institution’s data in the preservation network. Pivoting to the AU perspective also allows the publisher to identify problems related to remote node access to the content staging area.

Reporting preservation network and AU status in a consolidated and informational way is something that needs more development. By utilizing a relational database for the title list, ADPNet has begun the process of developing collection mechanisms for the specifics of AU state as reported by the discrete hosts. LOCKSS user accounts[<sup>[23]</sup>](https://journal.code4lib.org/articles/#_ftn23) and web services[<sup>[24]</sup>](https://journal.code4lib.org/articles/#_ftn24) facilitate access and collection of the remote data. The suds Python library is a lightweight solution for pulling in data from web services.[<sup>[25]</sup>](https://journal.code4lib.org/articles/#_ftn25) In the extended entity relationship (EER) diagram, adpn\_au\_status table is the LOCKSS web service auStatus response data.[<sup>[26]</sup>](https://journal.code4lib.org/articles/#_ftn26) There is no time dimensionality to this data set. The most current state is the reported state.

AU status lookups across multiple nodes for thousands of archival units can take quite a long time. The response time delay and potential for failure are exacerbated when querying terabyte-sized AUs with upwards of 15,000 URLs.   Providing an out-of-process store, although no-longer real-time, provides adequately current information for reporting.

![](https://journal.code4lib.org/media/issue34/cataldo/figure7.jpg)  
**Figure 7.** Example report of publisher AUs (local and remote) consolidated.

## Title List Application

The title list could be provided to the preservation peers in various ways. The most common approach in LOCKSS networks is to make a static XML document available over HTTP. ADPNet developed a method of provisioning the title list utilizing a relational database backend that delivers node-specific XML streams over HTTP by examining query string parameters. Werkzeug is a small Python library capable of handling HTTP request parsing and response modification.[<sup>[27]</sup>](https://journal.code4lib.org/articles/#_ftn27) Mod\_wsgi provides a fast interface for Python applications in the Apache HTTP context.[<sup>[28]</sup>](https://journal.code4lib.org/articles/#_ftn28) As title lists of several thousand AUs can be large, string building optimization may be necessary. Without relying on additional Python libraries, Python lists function reasonably well enough for large string generation.[<sup>[29]</sup>](https://journal.code4lib.org/articles/#_ftn29)

## Protecting the Data

The preservation network should only allow traffic to and from known hosts. This is particularly true when configuration data is exposed over HTTP protocols.

Known hosts could include:

- Preservation network peers
- LOCKSS staff
- Local system administrators

CentOS 7 firewall configuration could be modified to be more restrictive.

```
Command prompt

# firewall-cmd --get-default-zone
# drop

# firewall-cmd --get-active-zones
# drop
…
# internal
…
# public
…

# firewall-cmd --zone=public --list-all
# …
# Sources [white-listed IPs]
# Ports [white-listed ports]
```

Provided that the appropriate ports are open, the benefit of using a known preservation host is that these access restrictions would require no change when configuration services are transferred to a different preservation network peer.

## Preparation of Peers

In order to minimize downtime and to assess the ability of any particular node to function as the configuration services provider, the ancillary configuration services software should be pre-installed. Additionally, the appropriate firewall settings should be in-place, particularly opening port 80 to the known preservation network peers. The ancillary configuration services software do not need to be running when the node has not been promoted.

## Next Steps

Node-based configuration management transfers the rigors of network administration to the preservation network. A PLN wishing to explore this approach should be well equipped to manage the preservation network.

The node-based configuration management model has proven to be useful to ADPNet. Following the introduction of the management model in December 2015, the network reduced delays for new AU releases and more than doubled the preserved AU count. The model has helped redefine a sense of ownership and control of the network by the participants, and the network has had the opportunity to develop talking points and demonstrate local expertise in digital preservation.

More work is needed in title list provisioning and administration, particularly in regards to development of a user-friendly administrative user interface. More work is also needed to develop concise and useful administrative and technical reports.

Finally, the code for administering and delivering the title list should be developed and ultimately released for public use.

## Notes

[<sup>[1]</sup>](https://journal.code4lib.org/articles/#_ftnref1) What is LOCKSS? Accessed at [https://www.lockss.org/about/what-is-lockss/](https://www.lockss.org/about/what-is-lockss/).

[<sup>[2]</sup>](https://journal.code4lib.org/articles/#_ftnref2) LOCKSS: Basic Concepts – LOCKSS Daemon. Accessed at [https://documents.clockss.org/index.php?title=LOCKSS:\_Basic\_Concepts#LOCKSS\_Daemon](https://documents.clockss.org/index.php?title=LOCKSS:_Basic_Concepts#LOCKSS_Daemon).

[<sup>[3]</sup>](https://journal.code4lib.org/articles/#_ftnref3) CLOCKSS: Box Operations – CentOS Installation and Configuration. Accessed at [https://documents.clockss.org/index.php?title=CLOCKSS:\_Box\_Operations#CentOS\_Installation\_and\_Configuration](https://documents.clockss.org/index.php?title=CLOCKSS:_Box_Operations#CentOS_Installation_and_Configuration)

[<sup>[4]</sup>](https://journal.code4lib.org/articles/#_ftnref4) LOCKSS-Daemon. Accessed at [https://github.com/lockss/lockss-daemon](https://github.com/lockss/lockss-daemon)

[<sup>[5]</sup>](https://journal.code4lib.org/articles/#_ftnref5) Global and Private LOCKSS Networks. Accessed at [https://www.lockss.org/community/networks/](https://www.lockss.org/community/networks/).

[<sup>[6]</sup>](https://journal.code4lib.org/articles/#_ftnref6) How to Join. Accessed at [https://www.lockss.org/join/](https://www.lockss.org/join/).

[<sup>[7]</sup>](https://journal.code4lib.org/articles/#_ftnref7) Alabama Digital Preservation Network. Accessed at [http://adpn.org/](http://adpn.org/).

[<sup>[8]</sup>](https://journal.code4lib.org/articles/#_ftnref8) Cataldo, Tobin M. “A New Approach to Configuration Management for Private LOCKSS Networks.” D-Lib Magazine. 22, no. 3 / 4, (March/April 2016). [http://doi.org/10.1045/march2016-cataldo](http://doi.org/10.1045/march2016-cataldo)

[<sup>[9]</sup>](https://journal.code4lib.org/articles/#_ftnref9) In LOCKSS, an archival unit (AU) is a set of URLs. AU definitions include a crawl start URL and define a boundary crawl specification.The resultant discovered URLs comprise the archival unit. More information is available at [https://plnwiki.lockss.org/index.php?title=LOCKSS\_Technical\_Manual#LOCKSS\_content\_crawlers](https://plnwiki.lockss.org/index.php?title=LOCKSS_Technical_Manual#LOCKSS_content_crawlers).

[<sup>[10]</sup>](https://journal.code4lib.org/articles/#_ftnref10) Cataldo, Tobin M. “Data Partitioning for Private LOCKSS Networks.” Presentation at the LOCKSS PLN Community Meeting, Montgomery, AL, October 24-25, 2013.

[<sup>[11]</sup>](https://journal.code4lib.org/articles/#_ftnref11) LOCKSS Technical Manual – Data Transfer Options. Accessed at [https://plnwiki.lockss.org/index.php?title=LOCKSS\_Technical\_Manual#Data\_transfer\_options](https://plnwiki.lockss.org/index.php?title=LOCKSS_Technical_Manual#Data_transfer_options).

[<sup>[12]</sup>](https://journal.code4lib.org/articles/#_ftnref12) Installing MySQL on Linux Using RPM Packages. Accessed at [http://dev.mysql.com/doc/refman/5.7/en/linux-installation-rpm.html](http://dev.mysql.com/doc/refman/5.7/en/linux-installation-rpm.html)

[<sup>[13]</sup>](https://journal.code4lib.org/articles/#_ftnref13) Installing MySQL on Linux Using the MySQL Yum Repository. Accessed at [https://dev.mysql.com/doc/mysql-repo-excerpt/5.7/en/linux-installation-yum-repo.html](https://dev.mysql.com/doc/mysql-repo-excerpt/5.7/en/linux-installation-yum-repo.html)

[<sup>[14]</sup>](https://journal.code4lib.org/articles/#_ftnref14) mysqldump – A Database Backup Program. Accessed at [http://dev.mysql.com/doc/refman/5.7/en/mysqldump.html](http://dev.mysql.com/doc/refman/5.7/en/mysqldump.html)

[<sup>[15]</sup>](https://journal.code4lib.org/articles/#_ftnref15) Change the Default MySQL Data Directory on Linux with SELinux Enabled. CrashMAG.net Accessed at [http://crashmag.net/change-the-default-mysql-data-directory-with-selinux-enabled](http://crashmag.net/change-the-default-mysql-data-directory-with-selinux-enabled).

[<sup>[16]</sup>](https://journal.code4lib.org/articles/#_ftnref16) Mod\_wsgi. Accessed at [https://modwsgi.readthedocs.io/en/develop/](https://modwsgi.readthedocs.io/en/develop/).

[<sup>[17]</sup>](https://journal.code4lib.org/articles/#_ftnref17) Werkzeug. Accessed at [http://werkzeug.pocoo.org/](http://werkzeug.pocoo.org/).

[<sup>[18]</sup>](https://journal.code4lib.org/articles/#_ftnref18) Suds. Accessed at [https://fedorahosted.org/suds/wiki/Documentation](https://fedorahosted.org/suds/wiki/Documentation)

[<sup>[19]</sup>](https://journal.code4lib.org/articles/#_ftnref19) MySQL Connector/Python. Accessed at [https://dev.mysql.com/doc/connector-python/en/](https://dev.mysql.com/doc/connector-python/en/).

[<sup>[20]</sup>](https://journal.code4lib.org/articles/#_ftnref20) LOCKSS Technical Manual – LOCKSS Content Crawlers. Accessed at [https://plnwiki.lockss.org/index.php?title=LOCKSS\_Technical\_Manual#LOCKSS\_content\_crawlers](https://plnwiki.lockss.org/index.php?title=LOCKSS_Technical_Manual#LOCKSS_content_crawlers).

[<sup>[21]</sup>](https://journal.code4lib.org/articles/#_ftnref21) LOCKSS Software – File System Deep Dive. Accessed at [http://www.adpn.org/wiki/LOCKSS\_Software#File\_System\_Deep\_Dive](http://www.adpn.org/wiki/LOCKSS_Software#File_System_Deep_Dive)

[<sup>[22]</sup>](https://journal.code4lib.org/articles/#_ftnref22) LOCKSS Configuration Parameters. Accessed at [https://www.lockss.org/lockssdoc/gamma/daemon/paramdoc.html](https://www.lockss.org/lockssdoc/gamma/daemon/paramdoc.html).

[<sup>[23]</sup>](https://journal.code4lib.org/articles/#_ftnref23) LOCKSS Software – User Configuration. Accessed at [http://www.adpn.org/wiki/LOCKSS\_Software#User\_Configuration](http://www.adpn.org/wiki/LOCKSS_Software#User_Configuration)

[<sup>[24]</sup>](https://journal.code4lib.org/articles/#_ftnref24) LOCKSS Technical Manual – Web Services. Accessed at [https://plnwiki.lockss.org/index.php?title=Web\_Services](https://plnwiki.lockss.org/index.php?title=Web_Services).

[<sup>[25]</sup>](https://journal.code4lib.org/articles/#_ftnref25) Suds. Accessed at [https://fedorahosted.org/suds/wiki/Documentation](https://fedorahosted.org/suds/wiki/Documentation)

[<sup>[26]</sup>](https://journal.code4lib.org/articles/#_ftnref26) AuStatus – Class Definition. Accessed at [https://lockss.org/lockssdoc/gamma/daemon/org/lockss/ws/entities/AuStatus.html](https://lockss.org/lockssdoc/gamma/daemon/org/lockss/ws/entities/AuStatus.html)

[<sup>[27]</sup>](https://journal.code4lib.org/articles/#_ftnref27) Werkzeug. Accessed at [http://werkzeug.pocoo.org/](http://werkzeug.pocoo.org/)

[<sup>[28]</sup>](https://journal.code4lib.org/articles/#_ftnref28) Mod\_wsgi. Accessed at [https://modwsgi.readthedocs.io/en/develop/](https://modwsgi.readthedocs.io/en/develop/).

[<sup>[29]</sup>](https://journal.code4lib.org/articles/#_ftnref29) Python – Data Structures. Accessed at [https://docs.python.org/2/tutorial/datastructures.html](https://docs.python.org/2/tutorial/datastructures.html)

## About the Author

Tobin M. Cataldo ([tcataldo@bham.lib.al.us](https://journal.code4lib.org/articles/)) is the Coordinator of Collection Management at Birmingham Public Library. He has been involved with the Alabama Digital Preservation Network since 2011.
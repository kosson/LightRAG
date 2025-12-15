---
title: "Docker: a Software as a Service, Operating System-Level Virtualization Framework"
source: "https://journal.code4lib.org/articles/9669"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-07-21
created: 2025-01-10
description: "Docker is a relatively new method of virtualization available natively for 64-bit Linux. Compared to more traditional virtualization techniques, Docker is lighter on system resources, offers a git-like system of commits and tags, and can be scaled from your laptop to the cloud."
tags:
  - "clippings"
---
# Docker: a Software as a Service, Operating System-Level Virtualization Framework
 John Fink

Docker is a relatively new method of virtualization available natively for 64-bit Linux. Compared to more traditional virtualization techniques, Docker is lighter on system resources, offers a git-like system of commits and tags, and can be scaled from your laptop to the cloud.

## Introduction

If you were working in library IT in the last millennium, you’ll likely remember what your server room used to look like. PC towers running Novell Netware attached to huge multi-disc CDROM arrays. Refrigerator-sized Sun boxes. Digital AlphaServers running your library catalogue. To run most of the serious business of libraries, you needed serious equipment, and, as a result, machine rooms were often jumbled messes of shelves, wires and air conditioning units. With the advent of Linux running on microcomputers, these rooms became slightly smaller and maybe slightly less complex, but it wasn’t until the early 2000s that the real sea change came for the server room — the rapid adoption of easily implementable virtualization \[[1](https://journal.code4lib.org/articles/#note1)\], which allowed running multiple discrete operating systems on a single machine.

Although virtualization in the modern sense actually happened as early as the 1960s with VMs for IBM System/360 machines \[[2](https://journal.code4lib.org/articles/#note2)\], and both the 286 and 386 chips contained some species of virtualization \[[3](https://journal.code4lib.org/articles/#note3)\], it wasn’t until 2001 when VMWare introduced its x86 virtualization products that Linux-based virtualization really took off. With technologies like KVM \[[4](https://journal.code4lib.org/articles/#note4)\] and Xen \[[5](https://journal.code4lib.org/articles/#note5)\] looming large for local deployment and products like Amazon Web Services \[[6](https://journal.code4lib.org/articles/#note6)\] and the OpenStack \[[7](https://journal.code4lib.org/articles/#note7)\] framework claiming the cloud, the jumbled, messy, white-box-PC-and-CDROM-tower-laden server room is more or less extinct; today, you can create multiple virtual machines out of minimal physical machines.

```
virsh # list
 Id Name                 State
----------------------------------
  1 trotsky              running
  2 eris                 running
  3 funhouse             running
  4 gorgar               running
  5 shoah                running
  6 balder2              running
  7 asgard               running
```

A listing of virtual machines on a single server at the author’s workplace.

## Virtualization in libraries

Modern virtualization needs for libraries vary greatly from institution to institution. A small to midrange IT shop that doesn’t do a whole lot of software development — as what you’d find traditionally in many libraries — might only require a handful of virtual machines. It may need one for the library’s web presence, one for the ILS, and one to control images for patron workstations, for example. As much as possible, these would be drop-in replacements for those old white boxes. Some instances, like for a given ILS, would be bound by convention or licensing to have as little deviation from a traditional install as possible. For others, the effort to customize an install to a virtualization framework might not be worth the payoff; gains in performance or convenience may very well be minimal.

Libraries with staff who develop software likely have more complex requirements. The modern development environment is one of constant iteration. Write code. Write tests. Code breaks. Write more code. Write more tests. Break more things. Imagine manually having to set up a new machine, even a virtual one, each time you wanted to test your code from scratch. Anything that makes this process more efficient lets developers spend more time doing the specific work that they’re good at. The popular Virtualbox \[[8](https://journal.code4lib.org/articles/#note8)\] software, for instance, is very heavily GUI-oriented \[[9](https://journal.code4lib.org/articles/#note9)\] and has therefore had an entire framework \[[10](https://journal.code4lib.org/articles/#note10)\] built around it designed to make the creating and destroying of Virtualbox VMs scriptable.

Typical library virtualization schemes mostly utilize *machine-level virtualization*. The systems already mentioned — KVM, VMware, Xen, Virtualbox, along with products like DOSBox \[[11](https://journal.code4lib.org/articles/#note11)\], a multiplatform emulator specifically written to run DOS games — are machine-level emulators. They attempt to emulate as much as possible about a computing environment in software, down to disk drives, RAM allocation, graphics, hard drive space, and even processor type. Some machine-level virtualization platforms, for instance, make it possible to emulate an ARM-based system like a Raspberry Pi \[[12](https://journal.code4lib.org/articles/#note12)\] on an Intel-based platform like a desktop PC. But this type of virtualization can be resource-intensive and inefficient. When running multiple virtual machines on a single computer, you might quickly run into the limits of the physical machine by allocating large disk drives or carving out multiple Gigabytes of dedicated RAM for each VM instance. Workarounds for some of these problems are relatively simple (like mounting external drives as network shares), but others are more difficult (such as dealing with limited RAM).

Enter operating system-level virtualization \[[13](https://journal.code4lib.org/articles/#note13)\], which tries to share resources amongst instances rather than emulate as much of an actual machine as possible. Typical operating system-level virtualization schemes will share RAM, disk space, and kernel with guest instances. Consequently, an arbitrary number of operating system-level virtualization instances will be less likely to run out of host system resources than an equivalent number of machine-level virtualization instances. But that flexibility comes at a cost. Because guest instances must share a kernel and therefore both a processor and operating system type \[[14](https://journal.code4lib.org/articles/#note14)\], you could not run that virtual Raspberry Pi on x86 or Windows under a Linux host. Despite these limitations, operating system level virtualization is emerging as a very attractive workflow option for development work due to its ease of deployment and lightweight nature.

## Virtualization with Docker

Docker \[[15](https://journal.code4lib.org/articles/#note15)\], an open-source implementation of operating system-level virtualization, is rapidly gaining mindshare amongst developers. Like most good open source projects, Docker incorporates a lot of existing Linux technologies along with new functionality; it uses already existing technologies like copy-on-write union filesystems (usually AUFS \[[16](https://journal.code4lib.org/articles/#note16)\]) and Linux Containers \[[17](https://journal.code4lib.org/articles/#note17)\], and it couples that with a number of features that make it developer-centric (and therefore distinct from traditional virtual machines that attempt to hew as much as possible to the metaphor of *machine*): like deployment portability, versioning, re-use, and repeatability \[[18](https://journal.code4lib.org/articles/#note18)\].

These features are worth considering. They transform the notion of virtual machine provisioning from a time-consuming, sysadmin-centric model to one focused more on a developer-oriented workflow, \[[19](https://journal.code4lib.org/articles/#note19)\] as evidenced in particular by the git \[[20](https://journal.code4lib.org/articles/#note20)\]-like nature of Docker’s versioning system (with its diffs and tags).

At its core, Docker is a virtualization framework focused around running applications and not around emulating hardware, which seems facile at first but underscores the critical difference between operating system-level virtualization software like Docker and machine-level virtualization. Machine-level VMs are about faithful recreation of hardware — right down to RAM allotment, how many CPUs to assign, emulating NICs, and so forth — and operating system level virtualization is about *applications*, not machines \[[21](https://journal.code4lib.org/articles/#note21)\]. Most of the time when we’re developing, testing, and releasing software we care about applications and not really the specific hardware environment — real or virtual — that we’re developing in, perhaps except with emulating historical hardware \[[22](https://journal.code4lib.org/articles/#note22)\] and other edge cases. When we write to mailing lists asking for help with Drupal, we don’t say “I have a Dell PowerEdge 5100 with 4 Intel Core2Duo processors and 16GB of 70ns RAM and two Atheros 100GB NIC cards and I can’t get this Drupal module to work correctly.” Unless we have a pretty strong indicator that our problem is hardware bound, we focus on software. As it happens, this is what Docker does also. There is usually no reason to try to define for Docker how much memory it should have, how large its hard drive should be, or how much CPU it should take up; you don’t generally do this for the code you write on your desktop either.

In practice, this means a computer running Docker can run many more simultaneous virtual instances than the same computer running typical virtual machines. To illustrate: while wrestling with machine-level virtualization on an anemic desktop dating from 2007, I had trouble running two Virtualbox instances concurrently. But, on the same host, I was able to run over 40 Docker containers without a noticeable drop in host system performance.

### Running Docker

What does it look like to run Docker? After the Docker software is installed \[[23](https://journal.code4lib.org/articles/#note23)\], you’re left with a primary binary (“docker”) with which you can start, stop, import, export, and do other \[[24](https://journal.code4lib.org/articles/#note24)\] operations.

Here’s an example of a Docker host running a few containers, which we can see by running docker ps on the comand line.

```
CONTAINER ID        IMAGE                     COMMAND             CREATED             STATUS              PORTS                                        NAMES
1bc191f4cdbb        bedework:latest           supervisord -n      11 days ago         Up 11 days          0.0.0.0:8080->8080/tcp                       sick_newton         
b58946da298c        papyrus-demo:port6000     /bin/bash           13 days ago         Up 13 days          3000/tcp, 6000/tcp, 0.0.0.0:6001->6001/tcp   drunk_bell          
c90c0a6be88f        saucy-csclub:latest       /bin/bash           13 days ago         Up 13 days          0.0.0.0:9999->9999/tcp                       angry_shockley      
e5a0f8a71f7e        papyrus-demo:in-process   /start.sh           2 weeks ago         Up 13 days          0.0.0.0:3000->3000/tcp                       mad_poincare        
f752161937c6        ldap_update_pw:latest     supervisord -n      5 weeks ago         Up 13 days          0.0.0.0:5000->5000/tcp                       distracted_nobel    
33cf9eb89073        catmandu:in-process       /bin/bash           6 weeks ago         Up 13 days                                                       cranky_mccarthy     
```

Individual docker instances are split up into *images* and *containers*. Containers run instances of images. You can have several containers that come from the same image or variants of that image. In the above list, we can see that container id b58946da298c and e5a0f8a71f7e are running versions of the image “papyrus-demo,” demonstrating that images can have tags that act similarly to git tags, representing different states of a common image. In the papyrus-demo’s image, there’s a tag “in-process” and a tag “port6000”; an image without a distinct tag is always “latest”.

### A simple example: Article-as-container

To demonstrate how Docker works, I’ve created a container that converts the Markdown that this article was originally written in into HTML via pandoc \[[25](https://journal.code4lib.org/articles/#note25)\] and serves it using the Python SimpleHTTPServer module. You can get the Docker container from the Github repository \[[26](https://journal.code4lib.org/articles/#note26)\] for this article.

It’s a very simple Docker container and is built with two components. The first of which, the `Dockerfile`, runs when the image is first built and the second, start.sh, runs at each instantiation of image into container. The article text is in `c4l-docker-article.md`, and it’s this file that gets converted by pandoc and served with SimpleHTTPServer in `start.sh`.

Let’s break down the components and how to run them.

#### Dockerfile

We’ll start by looking at the Dockerfile line by line.

```
FROM ubuntu:latest
```

This is the image to use as a base. In this case, it’s building from Docker’s stock Ubuntu image.

```
MAINTAINER John Fink <john.fink@gmail.com>
```

The maintainer of the created image.

```
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list
```

The `RUN` statement runs a command from within the image being built. In this case, it’s adding the Universe repository to Ubuntu’s source list, so later on we can install pandoc.

```
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python git pandoc
```

Two `RUN` statements, updating Ubuntu and installing the necessary packages.

```
ADD ./start.sh /start.sh
```

`ADD` inserts files from outside the building image. Here, start.sh is added to the image.

```
RUN mkdir /article/
ADD ./c4l-docker-article.md /article/c4l-docker-article.md
```

A `RUN` and an `ADD`  
together, making the directory and adding the article Markdown to it.

```
EXPOSE 8888
```

`EXPOSE` tells Docker that containers built from the image will have programs running that need access to port 8888; in this case, for Python’s SimpleHTTPServer.

```
CMD  ["/bin/bash", "/start.sh"]
```

The `CMD` statement defines a default program to run inside the container if no specific command is given; here, we want containers to run the start.sh file using /bin/bash.

#### start.sh

The extremely basic start.sh files looks like this:

```
cd /article/
pandoc c4l-docker-article.md -o index.html
python -m SimpleHTTPServer 8888
```

All it does is go to the article’s directory, convert the article from Markdown to html, and then spawn Python’s SimpleHTTPServer to serve the article.

#### Building the article container

Running the `docker build` command builds the container. The command parses each line of the Dockerfile, saving each step as a commit and layering the next commit on top. This makes it easy to roll back if errors are detected. As a performance bonus, subsequent invocations of `docker build` will use the prior layers as a cache, only building new layers when a line is changed. This usually makes building images from edits very fast.

```
docker build -t c4l-docker-wordpress git://github.com/jbfink/c4l-docker-article
```

And after the build, launch the container with:

```
docker run -Pd c4l-docker-article
```

Every time a new container is created from the c4l-docker-article image — as we do when we issue the `docker run` command — the `CMD` statement from the Dockerfile is executed; in this case, our `start.sh` file. This file converts the article markdown to HTML and runs SimpleHTTPServer to serve the file. The flag P tells Docker to expose a random port on the host to the container port 8888 so SimpleHTTPServer can be reached from outside the container, and flag d tells Docker to run the container detached in the background. Running `docker ps` should show a line with the new container and the random port assigned to it; going to the Docker host at that port with any web browser renders the article.

### A real-world example: WordPress

In the spring of 2013 I started building a Docker WordPress container with an eye towards using it in-house for development projects. Why WordPress? WordPress is the white lab rat of library software — it’s used everywhere, is well supported, is well understood, is generally easy to take care of, and has a huge host of ancillary software behind it. It’s a good real-world example for testing Docker’s capabilities. Initially I built the container manually — that is, by launching a single Docker container running a bash shell and basically performing the steps in the above Dockerfile by hand (doing the normal apt-gets and vim editing of config files). I put it up on docker index \[[27](https://journal.code4lib.org/articles/#note27)\] and was contacted by a few folks in email about how I built it. In August of 2013 I started work on docker-wordpress \[[28](https://journal.code4lib.org/articles/#note28)\], a structured way of building what I had done manually that people could play with and build on. The key problem with setting up WordPress in a normal fashion, freezing it in a Docker image, and then running that elsewhere is that the configuration would remain the same across containers — same MySQL passwords and WordPress salts and keys in PHP. Ideally every time docker-wordpress is run there should be different values for all the fiddly WordPress configuration options, so docker-wordpress contains start.sh \[[29](https://journal.code4lib.org/articles/#note29)\], which runs a series of commands at first inception to set values for things like salts in wp-config.php.

```
sed -e "s/database_name_here/$WORDPRESS_DB/
s/username_here/$WORDPRESS_DB/
s/password_here/$WORDPRESS_PASSWORD/
/'AUTH_KEY'/s/put your unique phrase here/\`pwgen -c -n -1 65\`/
/'SECURE_AUTH_KEY'/s/put your unique phrase here/\`pwgen -c -n -1 65\`/
/'LOGGED_IN_KEY'/s/put your unique phrase here/\`pwgen -c -n -1 65\`/
/'NONCE_KEY'/s/put your unique phrase here/\`pwgen -c -n -1 65\`/
/'AUTH_SALT'/s/put your unique phrase here/\`pwgen -c -n -1 65\`/
/'SECURE_AUTH_SALT'/s/put your unique phrase here/\`pwgen -c -n -1 65\`/
/'LOGGED_IN_SALT'/s/put your unique phrase here/\`pwgen -c -n -1 65\`/
/'NONCE_SALT'/s/put your unique phrase here/\`pwgen -c -n -1 65\`/" /var/www/wp-config-sample.php > /var/www/wp-config.php
```

This ensures that different values for important variables get loaded each time docker-wordpress is first run. Combining this with the output from the initial build \[[30](https://journal.code4lib.org/articles/#note30)\] from source means a fairly long startup time, but subsequent runs usually take less than 30 seconds, and rebuilds (which can be cached) really only need to happen when major updates to component software happen. Running the docker-wordpress image is a fairly simple affair, and new containers take about a second to spawn, after which they can be accessed via internal IPs or given outward-facing ports on the host machine.

Docker-wordpress has a great advantage in that it’s one image, can be run in one container, and is easy to understand. But it would be a mistake to consider it a good model for a production-type instance. In particular, its slapdash approach to logging (something Logstash \[[31](https://journal.code4lib.org/articles/#note31)\] could go a long way towards fixing) and inclusion of a local MySQL instance make it a difficult sell for a production environment as it is currently written. Consider running 20 docker-wordpresses, each with its own database; it would make much more sense to have a single MySQL server serving multiple WordPress instances.

## Conclusion

Docker has been under heavy development for over a year, and during that time its creators have more or less discouraged people from attempting to run Docker as a production-ready framework. However, on June 9th, Docker reached 1.0 \[[32](https://journal.code4lib.org/articles/#note32)\] status, and as such should be considered ready for production instances. Importantly, Docker 1.0 is compatible with all prior versions of Docker, so projects that started when Docker was a moving target can still be used going forward.

However, porting more esoteric applications to Docker is not yet an easy procedure. Docker wants to run things in foreground processes, making it necessary to convert common programs like MySQL and Apache from their usual background modes to foreground ones, and Docker’s focus on one application per container (achieved in docker-wordpress and many other Docker applications through judicious use of supervisord) makes running products with complicated install procedures somewhat less than optimal and perhaps more suited to traditional VM or bare iron deployments for now.

Despite the work yet to be done on Docker, it is rapidly approaching a stable state \[[32](https://journal.code4lib.org/articles/#note32)\] and shows definite promise for incorporating into libraries’ virtualization activities. For software development, when programmers check their code into git, a Dockerfile could be included in the source code, allowing for quick testing of code on remote servers or as a demonstration tool to let others quickly bring up their own versions of an application without having to worry about specific building instructions or dependency management. Docker could be used as a backup strategy — as part of a backup script for a library’s web site, a Docker image could be built for a rapid deployment in case of service outage. And for regular systems administration tasks, who wouldn’t be happy to see a huge installation procedure \[[33](https://journal.code4lib.org/articles/#note33)\] boiled down to a single command?

## Endnotes

\[[1](https://journal.code4lib.org/articles/#ref1)\] [http://en.wikipedia.org/wiki/Virtualization](http://en.wikipedia.org/wiki/Virtualization)  
\[[2](https://journal.code4lib.org/articles/#ref2)\] [http://www.theregister.co.uk/2011/07/14/brief\_history\_of\_virtualisation\_part\_2/](http://www.theregister.co.uk/2011/07/14/brief_history_of_virtualisation_part_2/)  
\[[3](https://journal.code4lib.org/articles/#ref3)\] [http://www.theregister.co.uk/2011/07/11/a\_brief\_history\_of\_virtualisation\_part\_one/](http://www.theregister.co.uk/2011/07/11/a_brief_history_of_virtualisation_part_one/)  
\[[4](https://journal.code4lib.org/articles/#ref4)\] [http://www.linux-kvm.org/](http://www.linux-kvm.org/)  
\[[5](https://journal.code4lib.org/articles/#ref5)\] [http://www.xenproject.org/](http://www.xenproject.org/)  
\[[6](https://journal.code4lib.org/articles/#ref6)\] [http://aws.amazon.com](http://aws.amazon.com/)  
\[[7](https://journal.code4lib.org/articles/#ref7)\] [http://www.openstack.org](http://www.openstack.org/)  
\[[8](https://journal.code4lib.org/articles/#ref8)\] [http://virtualbox.org](http://virtualbox.org/)  
\[[9](https://journal.code4lib.org/articles/#ref9)\] [https://www.virtualbox.org/attachment/wiki/Screenshots/gnome.png](https://www.virtualbox.org/attachment/wiki/Screenshots/gnome.png)  
\[[10](https://journal.code4lib.org/articles/#ref10)\] [http://vagrantup.com](http://vagrantup.com/)  
\[[11](https://journal.code4lib.org/articles/#ref11)\] [http://www.dosbox.com](http://www.dosbox.com/)  
\[[12](https://journal.code4lib.org/articles/#ref12)\] [http://cronicasredux.blogspot.ca/2011/09/installing-and-running-debian-armel-on.html](http://cronicasredux.blogspot.ca/2011/09/installing-and-running-debian-armel-on.html)  
\[[13](https://journal.code4lib.org/articles/#ref13)\] [http://en.wikipedia.org/wiki/Operating\_system-level\_virtualization](http://en.wikipedia.org/wiki/Operating_system-level_virtualization)  
\[[14](https://journal.code4lib.org/articles/#ref14)\] You can run different Linux *versions* even though you might commonly consider them different OSes; a Red Hat guest could run under an Ubuntu host, for instance.  
\[[15](https://journal.code4lib.org/articles/#ref15)\] [http://docker.io](http://docker.io/)  
\[[16](https://journal.code4lib.org/articles/#ref16)\] [http://www.thegeekstuff.com/2013/05/linux-aufs/](http://www.thegeekstuff.com/2013/05/linux-aufs/)  
\[[17](https://journal.code4lib.org/articles/#ref17)\] [http://linuxcontainers.org/](http://linuxcontainers.org/)  
\[[18](https://journal.code4lib.org/articles/#ref18)\] [http://stackoverflow.com/a/18208445/380282](http://stackoverflow.com/a/18208445/380282)  
\[[19](https://journal.code4lib.org/articles/#ref19)\] [http://radar.oreilly.com/2012/06/what-is-devops.html](http://radar.oreilly.com/2012/06/what-is-devops.html)  
\[[20](https://journal.code4lib.org/articles/#ref20)\] [http://git-scm.com/](http://git-scm.com/)  
\[[21](https://journal.code4lib.org/articles/#ref21)\] [https://stackoverflow.com/a/22370529](https://stackoverflow.com/a/22370529)  
\[[22](https://journal.code4lib.org/articles/#ref22)\] [http://simh.trailing-edge.com/](http://simh.trailing-edge.com/)  
\[[23](https://journal.code4lib.org/articles/#ref23)\] [https://www.docker.io/gettingstarted/#h\_installation](https://www.docker.io/gettingstarted/#h_installation)  
\[[24](https://journal.code4lib.org/articles/#ref24)\] [http://docs.docker.io/reference/commandline/cli/](http://docs.docker.io/reference/commandline/cli/)  
\[[25](https://journal.code4lib.org/articles/#ref25)\] [http://johnmacfarlane.net/pandoc/](http://johnmacfarlane.net/pandoc/)  
\[[26](https://journal.code4lib.org/articles/#ref26)\] [http://github.com/jbfink/c4l-docker-article](http://github.com/jbfink/c4l-docker-article)  
\[[27](https://journal.code4lib.org/articles/#ref27)\] [https://index.docker.io/u/jbfink/wordpress/](https://index.docker.io/u/jbfink/wordpress/)  
\[[28](https://journal.code4lib.org/articles/#ref28)\] [http://github.com/jbfink/docker-wordpress](http://github.com/jbfink/docker-wordpress)  
\[[29](https://journal.code4lib.org/articles/#ref29)\] [https://github.com/jbfink/docker-wordpress/blob/master/scripts/start.sh](https://github.com/jbfink/docker-wordpress/blob/master/scripts/start.sh)  
\[[30](https://journal.code4lib.org/articles/#ref30)\] [https://gist.github.com/jbfink/9054707](https://gist.github.com/jbfink/9054707)  
\[[31](https://journal.code4lib.org/articles/#ref31)\] [http://logstash.net/](http://logstash.net/)  
\[[32](https://journal.code4lib.org/articles/#ref32)\] [http://blog.docker.com/2014/06/its-here-docker-1-0/](http://blog.docker.com/2014/06/its-here-docker-1-0/)  
\[[33](https://journal.code4lib.org/articles/#ref33)\] [http://docs.evergreen-ils.org/2.5/\_installing\_the\_evergreen\_server.html](http://docs.evergreen-ils.org/2.5/_installing_the_evergreen_server.html)

## About the author

John Fink is the Digital Scholarship Librarian in the Sherman Centre for Digital Scholarship at McMaster University in Hamilton, Ontario. He has been working with open source and libraries since 1995.
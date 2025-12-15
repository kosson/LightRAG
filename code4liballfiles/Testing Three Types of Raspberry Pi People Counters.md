---
title: "Testing Three Types of Raspberry Pi People Counters"
source: "https://journal.code4lib.org/articles/12947"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-10-18
created: 2025-01-10
description: "The Hudson County Community College (HCCC) Library tested three different types of Raspberry Pi based people counters between 6/14/2017 and 7/9/2017. This article will describe how we created each type of counter, will compare the accuracy of each sensor, and will compare them to the college’s existing 3M 3501 gate counters. It will also describe [...]"
tags:
  - "clippings"
---
# Testing Three Types of Raspberry Pi People Counters
Johnathan Cintron, Devlyn Courtier, John DeLooper

The Hudson County Community College (HCCC) Library tested three different types of Raspberry Pi based people counters between 6/14/2017 and 7/9/2017. This article will describe how we created each type of counter, will compare the accuracy of each sensor, and will compare them to the college’s existing 3M 3501 gate counters. It will also describe why and how our team decided to make this project, discuss lessons learned, and provide instructions for how other libraries can create their own gate counters.

## Introduction

The initial idea for this project came from a talk delivered by Jason Griffey at the *Computers in Libraries* conference in 2013. Griffey’s presentation, entitled “Making Libraries: Getting into the Hardware Biz”, argued that libraries should use devices such as Arduinos and Raspberry Pis to make better, cheaper, and potentially more accurate solutions for library technologies like people counters and heat maps.

Based on the ideas from this talk, our library discussed the possibility of creating our own electronic people/gate counter. We were frustrated that our existing counters required staff to manually check the machine and write down a visitor number three times a day. In our existing system, written numbers are transcribed once a month to a Microsoft Access Database at one of our campuses, and to a Microsoft Word document at the other. In addition to errors caused by handwriting or data input mistakes, having staff remember to check the gate count was difficult to ensure, especially when the library was busy and staff were occupied responding to patrons and thus unable to leave the service desk. Aiming to make a more accurate solution that did not require human intervention, we hoped to use Griffey’s idea to test a fully automated system, using our North Hudson branch campus as a test location.

There were several challenges to setting up this project. Our group had to decide which technology to use to best and most easily store and make the statistics available. We discussed whether we should use Arduinos or Raspberry Pis, or a combination of both. As relatively new technologies, both were hard to acquire from the vendors that we usually use to purchase electronics, and thus there were several months of delays while we sought paperwork from new vendors who stocked these devices and made sure they were added to our purchasing systems.

Serendipitously, in 2014, we received eight Intel Galileos, which are Arduino-compatible devices with additional processing power, and Seed Studio brand sensor kits as part of a grant from Intel. This equipment was distributed as part of an Intel effort to promote the use of their devices in STEM curricula at educational institutions. As such, our initial efforts to create gate counters involved using the Intel Galileo. However, we did not have all the necessary sensors, and our group found that the Galileo’s interface for storing and recording data was too difficult. Therefore, we switched our efforts to Raspberry Pis, which, along with appropriate sensors, we were able to first acquire in 2016, thanks to a generous gift by then Dean of Libraries Carol Van Houten. Hoping to create a “set-it-and-forget-it” system, we also wanted to ensure each sensor’s accuracy. Therefore, after over a year of research and testing, we settled on three different types of hardware to use: passive infrared sensor (PIR), a laser and light dependent resistor (also called LDR or photo resistor,) and ultrasonic distance sensor.

## Methodology: Device Placement

One of the first steps in setting up the project was determining where to place the counters. Our initial testing and calibration was performed in a staff office. However, for the final deployment, we had to consider several factors including proximity to power and data (Ethernet) connections, patron safety, and potential to disrupt library services. With these factors in mind, we originally thought to place the counters near the inside of our main entrance door, as pictured below.

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_01.png)  
**Figure 1.** View of main entrance to library

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_02.png)  
**Figure 2.** Close-up of library entrance door

This door is the library’s primary point of entry, and would thus provide a good place to count patrons. Unfortunately, placing our devices near the door would require running a series of long extension cords. We feared that deploying extension cords of this this length would be both unsightly and in our estimation, likely to cause trip hazards. We also thought they would have a high risk of being accidentally unplugged. With this in mind, we also wanted to be sure that our spot was against a wall, which would make each sensor easier to mount. This was especially important for the laser sensor, as it required aligning a resistor within a few feet of it. If the sensor was not properly aligned, the laser would lose its connection. Space would also have to be sufficient so that the ultrasonic sensor was not recording a wall as a person either. In testing this issue, we found that the distance between walls in our entrance corridor was sufficient to avoid this type of input error.

Ultimately we chose to use a spot in our entrance hallway, next to our existing gate counter. This area had connections for both power and ethernet nearby, and we felt it would be minimally disruptive for our students as it was in an area with several other electronic devices including a photocopier, and the aforementioned 3M counter. This location was also an easier location for library students and staff, as it allowed the Pis to be mounted relatively unobtrusively and minimized trip hazards. We also felt that this spot would provide the most accurate point for comparison with our existing gate counter, as it was adjacent to this device, and thus would measure who entered the library at nearly the exact same location. As the existing 3M counter doubles as an electromagnetic theft detection system, we recognized that this proximity may have made the Raspberry Pis or their sensors subject to electromagnetic interference, potentially compromising our project’s effectiveness. While we did not notice any issues that were directly attributable to the electromagnetic interference, it is an issue that we will have to keep in mind, and continue to study.

The Raspberry Pis themselves were placed in cardboard boxes, along with the breadboards and attached sensors, and secured to walls with 3M command hooks. When we initially set up the devices, we used [command hooks](http://www.homedepot.com/p/Command-Medium-Clear-Wire-Toggle-Hook-6-Pack-17065CLR-VPES/205937597) that have a capacity of two pounds. However, the two pound rated hooks proved unable to support the weight of our systems, so we replaced the original mounting strips that were included with the hooks with [five pound capacity mounting strips](http://www.homedepot.com/p/Command-5-lb-Large-Refill-Strips-6-Strips-17023P/202575690). These higher capacity strips proved sufficient to keep the devices from falling during our testing period. Photographs of the setup are below:

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_03.png)  
**Figure 3.** A view of the entrance corridor

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_04.png)  
**Figure 4.** This image shows a step in the setup of our sensors relative to the existing gate counter. The sensors were placed together on the left hand side of the picture. On the right hand side, a white cardboard box contains the laser and Galileo.

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_05.png)  
**Figure 5.** Once mounted, the Pis were relatively unobtrusive when placed near the existing gate counter.

## Methodology: Hardware

The first and easiest hardware for our staff to construct was the passive infrared or PIR sensor, also known as a motion sensor. It required six Male-Female connector cables, a Raspberry Pi, a breadboard, and a PIR sensor. In the illustration below, the red and black cables are power and ground while the blue cable connects to General Purpose Input Output (GPIO) 7. The black cable on the breadboard next to the blue cable is what transmits the information from the sensor to the Pi. The other two cables in the sensor are the power and ground.

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_06.png)  
**Figure 6.** PIR Pi and breadboard setup with view of pin outs

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_07.png)  
**Figure 7.** View of the PIR Sensor

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_08.png)  
**Figure 8.** View of the PIR Sensor

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_09.png)  
**Figure 9.** View of the PIR Sensor

For the ultrasonic sensor, we used eight male-female cables and three 1K resistors, although other libraries could choose to use a 1K and 2K resistor instead. The Pi pinouts used are pin 5 (power), pin 6 (ground), pin 16 (GPIO23), and pin 18 (GPIO24). The first two connect the breadboard to the power and ground portion. Pin 16 connects to the breadboard and is adjacent to another cable, both blue in Figure 10, which connects directly to the sensor. This is how the sensor communicates with the Pi. The charge on the Pi needs to be reduced to receive accurate readings from the sensor, so the resistors are set up connecting the cable from the Pi (red) to the cable from the sensor (yellow). The remaining two pins on the sensor are power and ground, respectively.

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_10.png)  
**Figure 10.** Ultrasonic Pi and breadboard setup with view of pin outs

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_11.png)  
**Figure 11.** Close-up of Ultrasonic Sensor

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_12.png)  
**Figure 12.** Raspberry Pi 3 GPIO (Source: [element14.com/raspberrypi](http://element14.com/raspberrypi))

The last sensor, the laser sensor, utilizes a general purpose input output (GPIO) ribbon cable, a 40-pin Pi wedge, a light dependent resistor sensor, a laser diode, and an MCP 3008 chip, in addition to the other parts we have been using thus far — minus the resistors. Another notable difference is that we needed to use a large quantity of male-male cables in this project instead of male-female.

For this project, we needed to attach a wedge to the end of the breadboard so the pins are on the two sides of the breadboard. We used five of the pinouts on the wedge: the 3.3V, Serial Clock (SCK), Master Input Slave Output (MISO), Master Output Slave Input (MOSI), and Chip Enable (CE0). The 3.3V connects to the power line of the breadboard. The remaining four cables are connected to ports on the MCP3008 chip.

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_13.png)  
**Figure 13.** MCP 3008 Chip Port Display (Note the small indent on the chip should match the display between 1 and 16

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_14.png)  
**Figure 14.** Laser Pi and breadboard setup with view of pin outs

The SCK cable is connected to port 13, the MISO is connected to port 12, the MOSI is connected to port 11, and the CE0 is connected to port 10. Port 16 connects to power on the breadboard, and port 14 is connected to ground on the breadboard. Port 15 is connected directly behind the cable connecting to power on the chip. Port 1 is connected from the chip to a blank space on the breadboard that has two empty spaces around it in all directions. Directly next to that, one cable is connected to power and one to ground. (See below image) These cables are how the LDR sends data. To connect the LDR sensor to the board, three male-female cables are needed: one to connect the cable to the power source, one to connect the ground next to the cable for ground, and the last next to the remaining cable. Once these are all set up, the ribbons should be connected to the Pi on one end and to the wedge on the other. After this, the laser is connected to power, and you can use another Raspberry Pi to connect the LDR sensor to a ground and power port. This is because you will need a way for the laser to get power. In our setup, we originally used another Raspberry Pi, but swapped it for a Galileo, as the Galileo allowed us to pass through power directly without additional code or other steps required to make a Raspberry Pi operational, such as installing an operating system.

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_15.png)  
**Figure 15.** Close-up of laser breadboard

## Methodology: Software

Our software code was modeled off of the instructions on Electro18’s *Arduino-DIY Laser / IR Person Counter Instructable* ([http://instructables.com/id/IR-laser-person-counter/](http://instructables.com/id/IR-laser-person-counter/)) and adapted and rewritten in Python. We chose to use Python because it is a versatile scripting language that is easily installable on any Linux distribution.

As our main goal was to have to the Raspberry Pi write the statistics to a remote database, we used the MySQLdb Python library, and used the following SQL query:

| 1  2  3  4  5  6  7  8 | `db ``=` `MySQLdb.connect(``"HOSTNAME"``,``"USERNAME"``,``"PASSWORD"``,``"DATABASE"``)`  `cursor ``=` `db.cursor()`  `sql ``=` `"INSERT INTO LDRSTATS (date, time, gatecount) VALUES ('%s', '%s', '%d')"` `%` `(curr_date, curr_time, count)` |
| --- | --- |

This query inserted the date, time, and gate count statistics into each sensor variant’s own table in the database.

Each sensor type required its own customization. Full details can be seen in the Python scripts at [https://github.com/squash-/HCCC-Library-GateCounter-Scripts](https://github.com/squash-/HCCC-Library-GateCounter-Scripts).

## Troubleshooting

The project required a great deal of troubleshooting to work properly. As we were worried about potential trip hazards caused by connecting the Pis via ethernet, we initially connected the Pis to our campus wireless network. However, this required using one of our staff’s credentials for the WPA2 Enterprise setup, which made the project less maintainable. In addition, the Pis would disconnect from our institution’s wireless network every night, so we had to use ethernet for the testing. There were also issues with determining how sensitive the sensors should be. This necessitated some tweaking of read intervals before we arrived at the final numbers found in our Github code. Finally, users who stood in the door often threw off the numbers for each type of sensor, which was a problem even with our original 3M counter. When this happened, we had to manually reboot and reset the system back to zero, and start the count again. Finally, we had to abandon our original idea of entering a count of 1 to the database each time the Pi recorded motion. Doing this type of count, while potentially more accurate, was too difficult to program in the time we had available.

## Findings

We started recording data from the gate counters after they were set up on 6/14, and continued throughout the month of July. Each week, we checked the data to make sure our MySQL database was still receiving data from the Raspberry Pis. Unfortunately, we failed to properly back up our system, and when we did the final data export, we lost all the data from after July 9. With that in mind, we still did record some interesting data, and have noted the results below.

### 3M 3501 Gate Counter and Paper

The campus on which we tested this project has used a 3M 3501 electromagnetic detection system both for security and for gate counts since 2011. The gate counter counts each time a person passes through the gates, and library staff manually record total gate tallies three times a day. By subtracting the number from our final day with the day we started to record, we find that we had 5440 visits over the course of one month. The 3M counter increments up as people both enter and leave, and is vulnerable to errors caused when students, faculty, or staff stand in the path of the gate, thus creating potential over counts.

### PIR

The PIR recorded data until 6/16 and reset after 1721 visits. It recorded again until 6/19 and the machine rebooted and its numeric tally reset to zero after recording up to 428. After this, it continued recording until 7/3 and rebooted and reset at 1028. It recorded again until 7/9 and rebooted and reset at 1912. Thus, the PIR recorded a total of 5089 visitors, and required three resets. As with the 3M gate counter, it recorded motion in both directions, thus potentially over counting visitors.

### LDR

The LDR sensor rebooted and reset on its first day of recording at 28 visitors. It jumped from 176 to 321 on 6/15, and had similar jumping issues on 6/19 at 13,639 and 7/3 at 4310. The worst jump was on 6/19, when the device actually fell from its wall mount and laid on the ground, at 7:40 a.m. on 6/19. At this time, the machine began to malfunction and went from 716 visitors to 2100, and climbed to 13,639 visitors by the end of the day. The final tally on 7/9 was 414. Therefore, this machine recorded 18,391 total visits, or 5468 if the data from the day the device fell is removed, and we required three resets. As with the 3M and the PIR, it recorded motion in both directions, thus potentially over counting visitors.

### Ultrasonic

The ultrasonic sensor rebooted and reset its numeric count on 6/14 at 733 visitors and again the same day at 230. It reset again on 6/19 at 248, and on 6/20 at 587 and 7/3 at 337. The final tally on 7/9 was 461. Therefore, the ultrasonic sensor recorded a total of 2596 visitors, with 5 resets. This device also counted in both directions, and thus, as with our other sensors, probably over counted visitors.

### Analysis

As our project originally hoped to record the month of July, we were somewhat disappointed with the results. This was our own fault, as we did not make proper backups when we checked that the machine was functioning. For each device, other than the existing 3M device, we found resets were a problem, which we suspect was due to a memory leak in our programming. We were not able to verify this during the study. Due to the reboot and resets, it was also difficult to obtain truly cumulative data. All of our devices were also uni-directional, and thus counted both entrances and exits, meaning all gate counts were probably twice as high as total visitors. Based on the data, the laser/LDR appears more vulnerable to jumps from people standing in its path, and the ultrasonic appears to return the lowest total visitor count. Until this issue is studied for a longer period of time, it is difficult to say which option would be the most accurate. Future versions of this study could include some hour by hour sampling, or using hand counters to test the overall accuracy of all of the studied devices.

## Related Work

Libraries have long understood the importance of keeping statistics. Some of the earliest literature ignores patron count (Gerould, 1906) and suggests other metrics like finances and collection size to be most important for evaluating the delivery of library services. However, discussion of patron counting appears as early as Chen (1978), and devices for electronically counting people have been around since at least 1965, when Stephen Hornung received a patent for developing a device to count users of elevators (Hornung, 1965). Several other technologies were developed afterward, including Taylor et al. (1976), who used ultrasonic sensors to count bus passengers, and Tsubota and Satoru (1978), who used pressure sensitive mats to track movement.

The earliest literature we found about library adoption of electronic people counters came in 1999, when 3M began to promote its Model 3500 detection system, which upgraded their earlier security systems to include built-in people counters. The earliest instance we found discussing libraries using either Raspberry Pi or Arduino based counters came with Griffey (2013), but there are also several other examples of Raspberry Pi or Arduino based counters or motion detectors published in the same time period, including Nawrath (2012), One Million Monkeys (2012), and ModMyPi (2014). The Library Technology community has shown an interest in this topic as well on the *Lita-L listserv,* which included discussions about gate counters and the Raspberry Pi in August 2016, and in February and March of 2017 (see [http://lists.ala.org/sympa/arc/lita-l/2017-03/msg00089.html](http://lists.ala.org/sympa/arc/lita-l/2017-03/msg00089.html) ).

Finally, there are several commercial providers, including Sensource and 3M (now Bibliotheca), who provide their own systems for tracking patron use through people/gate/door counters. These are usually sold either from the vendor directly (Sensource, 2015), or from library specific vendors like Demco (2017) or The Library Store (TLS) (2017).

## Conclusion and Future research

While the data gathered was useful, we found that the overall reliability of our sensors was not high enough to deploy as a “set it and forget it” type solution. While this project taught us a lot about the possibilities for using Raspberry Pis to record statistics, we feel that the technology has not yet fully matured. We will continue to refine these systems, and we hope that individuals from other libraries will read this and other literature on the issue, and work to improve on our findings to make more accurate, yet affordable solutions to track library usage statistics.

### Acknowledgements:

The authors of this paper would like to thank Carol Van Houten, who purchased the original Raspberry Pis and sensors, and encouraged us to research this issue. We would also like to thank David Hardgrove for supporting our trial leading up to and during the month of July 2017, and Cynthia Coulter for her encouragement and for helping us find space to test our project at the North Hudson Library.

## Bibliography

3M. (2017). Electromagnetic Products. Retrieved August 7, 2017, from [http://solutions.3m.com/wps/portal/3M/en\_WW/Track\_Trace/home/Products/one/two/?PC\_Z7\_RJH9U52308DU80I4CCRM093II4000000\_assetType=MMM\_Article&PC\_Z7\_RJH9U52308DU80I4CCRM093II4000000\_assetId=1180619853892&PC\_Z7\_RJH9U52308DU80I4CCRM093II4000000\_univid=1180619853892#Z7\_RJH9U52308DU80I4CCRM093II4](http://solutions.3m.com/wps/portal/3M/en_WW/Track_Trace/home/Products/one/two/?PC_Z7_RJH9U52308DU80I4CCRM093II4000000_assetType=MMM_Article&PC_Z7_RJH9U52308DU80I4CCRM093II4000000_assetId=1180619853892&PC_Z7_RJH9U52308DU80I4CCRM093II4000000_univid=1180619853892#Z7_RJH9U52308DU80I4CCRM093II4)

3M introduces Digital Identification System, Model 3500 detection system; demonstrates PIKiosk. (1999). *Information Today*, *16*(8), 47.[(COinS)](https://journal.code4lib.org/coins)

Ching-Chih, C. (Ed.). (1978). *Quantitative Measurement and Dynamic Library Service*. Phoenix, AZ: Greenwood Press.[(COinS)](https://journal.code4lib.org/coins)

Electro18. (n.d.). Arduino-DIY Laser / IR Person Counter. Retrieved August 19, 2017, from [http://www.instructables.com/id/IR-laser-person-counter/](http://www.instructables.com/id/IR-laser-person-counter/)

Friedman, M. (2011, July 18). Jonesboro Library installs thermal people counter. *Arkansas Business*, p. 12.[(COinS)](https://journal.code4lib.org/coins)

Gaven MacDonald. (2013). *Ultrasonic Sensor with the Raspberry Pi*. Retrieved from [https://www.youtube.com/watch?v=xACy8l3LsXI](https://www.youtube.com/watch?v=xACy8l3LsXI)

Gerould, J. T. (1906). Plan for the compilation of comparative university and college library statistics. *The Library Journal*, *31*(11), 761–763.[(COinS)](https://journal.code4lib.org/coins)

Griffey, Jason. (2013, April). *Making Libraries: Getting into the Hardware Biz*. Presented at Computers in Libraries, Washington, D.C. Retrieved from [http://jasongriffey.net/wp/2013/04/08/make-the-tools-that-measure-the-future/](http://jasongriffey.net/wp/2013/04/08/make-the-tools-that-measure-the-future/)

HC-SR04 Ultrasonic Range Sensor on the Raspberry Pi. (n.d.). Retrieved August 21, 2017, from [https://www.modmypi.com/blog/hc-sr04-ultrasonic-range-sensor-on-the-raspberry-pi](https://www.modmypi.com/blog/hc-sr04-ultrasonic-range-sensor-on-the-raspberry-pi)

Inc, D. (2017). Demco.com – Patron Counters. Retrieved August 12, 2017, from [http://www.demco.com/Category/Security/Traffic-Control/Patron-Counters/\_/N-1a0](http://www.demco.com/Category/Security/Traffic-Control/Patron-Counters/_/N-1a0)

jedhodson. (n.d.). Arduino and Pi in Harmony – As a Sensor Web Server! Retrieved August 21, 2017, from [http://www.instructables.com/id/Arduino-and-Pi-in-harmony-As-a-sensor-web-server/](http://www.instructables.com/id/Arduino-and-Pi-in-harmony-As-a-sensor-web-server/)

Jones, J. L. (2011). Using library swipe-card data to inform decision making. *Georgia Library Quarterly*, *48*(2), 11–13.[(COinS)](https://journal.code4lib.org/coins)

Making a laser tripwire with a Raspberry Pi. (n.d.). Retrieved August 21, 2017, from [https://www.raspberrypi.org/learning/laser-tripwire/](https://www.raspberrypi.org/learning/laser-tripwire/)

Morton-Owens, E., & Hanson, K. L. (2012). Trends at a Glance: A Management Dashboard of Library Statistics. *Information Technology & Libraries*, *31*(3), 36–51.[(COinS)](https://journal.code4lib.org/coins)

MrHobbyelectronics. (2015). *Raspberry Pi – Distance Sensor*. Retrieved from [https://www.youtube.com/watch?v=iNXfADw0M9Y](https://www.youtube.com/watch?v=iNXfADw0M9Y)

Nawrath, M. (2012, January). Arduino Frequency Counter Library. Retrieved August 12, 2017, from [http://interface.khm.de/index.php/lab/interfaces-advanced/arduino-frequency-counter-library/](http://interface.khm.de/index.php/lab/interfaces-advanced/arduino-frequency-counter-library/)

Normington, J. (2014). What Are Those People Really Doing in Our Library? *InCite*, *35*(10), 15–15.[(COinS)](https://journal.code4lib.org/coins)

Patron Counters. (2017). Retrieved August 12, 2017, from [http://www.thelibrarystore.com/category/patron\_counters\_and\_door\_alarms](http://www.thelibrarystore.com/category/patron_counters_and_door_alarms)

Patron Counting Analytics for the Library Industry. (2015). Retrieved August 12, 2017, from [http://www.sensourceinc.com/industries/library.htm](http://www.sensourceinc.com/industries/library.htm)

Perone, C. S. (2012, August 19). Raspberry Pi & Arduino: a laser pointer communication and a LDR voltage sigmoid. Retrieved August 21, 2017, from [http://blog.christianperone.com/2012/08/raspberry-pi-arduino-a-laser-pointer-communication-and-a-ldr-voltage-sigmoid/](http://blog.christianperone.com/2012/08/raspberry-pi-arduino-a-laser-pointer-communication-and-a-ldr-voltage-sigmoid/)

Phillips, J. (2016). Determining Gate Count Reliability in a Library Setting. *Evidence Based Library and Information Practice*, *11*(3), 68–74.[(COinS)](https://journal.code4lib.org/coins)

Pi My Life Up. (2015). *Raspberry Pi Motion Sensor using a PIR Sensor*. Retrieved from [https://www.youtube.com/watch?v=mmS7EsI0Sao](https://www.youtube.com/watch?v=mmS7EsI0Sao)

Raspberry Pi GPIO Sensing: Motion Detection. (2014, February 19). Retrieved August 21, 2017, from [https://www.modmypi.com/blog/raspberry-pi-gpio-sensing-motion-detection](https://www.modmypi.com/blog/raspberry-pi-gpio-sensing-motion-detection)

Raspberry Pi Laser Tripwire. (2012, December 21). Retrieved August 21, 2017, from [https://1000000monkeys.wordpress.com/2012/12/20/raspberry-pi-laser-tripwire/](https://1000000monkeys.wordpress.com/2012/12/20/raspberry-pi-laser-tripwire/)

RaspberryPiIVBeginners. (2014). *Raspberry Pi – GPIO & Python (9/9) – Passive infrared sensor*. Retrieved from [https://www.youtube.com/watch?v=cpR4VxnGzew](https://www.youtube.com/watch?v=cpR4VxnGzew)

ScreechyNutz. (2014). *Motion Activated Surveillance System using a Raspberry Pi*. Retrieved from [https://www.youtube.com/watch?v=JHbGLlFTXi8](https://www.youtube.com/watch?v=JHbGLlFTXi8)

Security Tools. (1999). *Computers in Libraries*, *19*(8), 16.[(COinS)](https://journal.code4lib.org/coins)

Stephen, A. H. (1965, September 21). *3207266*. Louisville, KY.: United States Patent Office. Retrieved from [http://www.google.com/patents/US3207266](http://www.google.com/patents/US3207266)

Szczys, M. (2011, April 19). Laser trip wire – the bare essentials. Retrieved August 21, 2017, from [http://hackaday.com/2011/04/19/laser-trip-wire-the-bare-essentials/](http://hackaday.com/2011/04/19/laser-trip-wire-the-bare-essentials/)

Taylor, W. R., Linder, F. X., & Clark, R. V. (1976, December 14). *3997866*. Silver Spring, MD. Retrieved from [http://www.google.com/patents/US3997866](http://www.google.com/patents/US3997866)

Thompson, S. (2015). Using Mobile Technology to Observe Student Study Behaviors and Track Library Space Usage. *Journal of Access Services*, *12*, 1–13. [https://doi.org/10.1080/15367967.2015.972754](https://doi.org/10.1080/15367967.2015.972754)

Tsubota, N., & Satoru, S. (1978, October 24). *4122331*. Retrieved from [http://www.google.com/patents/US4122331](http://www.google.com/patents/US4122331)

We Count People. (n.d.). Retrieved August 12, 2017, from [https://wecountpeople.com/](https://wecountpeople.com/)

White, L. L. (1981, June 23). *US4275385 A*. Retrieved from [http://www.google.com/patents/US4275385](http://www.google.com/patents/US4275385)

Wright, A. (2006, February 15). NTLP – Not Typical Library Partners: Gate Counters. Retrieved August 12, 2017, from [http://ntrls.blogspot.com/2006/02/gate-counters.html](http://ntrls.blogspot.com/2006/02/gate-counters.html)

*Johnathan Cintron* is an IT Technical Support Specialist at Bergen Community College. He holds an A.S. in Computer Science from Hudson County Community College, where he was a Library Technology Associate from 2013 to 2017. He is an active participant in the Android firmware development community, and his projects can be seen at [http://pastebin.com/kFhycfd4](http://pastebin.com/kFhycfd4). His Github page is [https://github.com/squash-](https://github.com/squash-) . His email address is [johnathancintron@gmail.com](https://journal.code4lib.org/articles/).

*Devlyn Courtier* is a Library Technology Associate at Hudson County Community College, where he is also a student. He has written and presented about topics including using devices like Raspberry Pis to teach coding, hosting video game tournaments in academic libraries, and circulating electronics at academic libraries. His email address is [dcourtier@hccc.edu](https://journal.code4lib.org/articles/).

*John DeLooper* is Director of Library Technology at Hudson County Community College, where he has worked since 2011. He holds an MLIS from Rutgers University, a B.A. in History from the George Washington University, and recently completed an MS in Information Systems at Baruch College. His email address is [jdelooper@hccc.edu](https://journal.code4lib.org/articles/).

## Appendix A: Final Tallies

**Table 1.** Final Tallies

| **Ultrasonic** | **LDR** | **PIR** | **3M** | **LDR – Adjusted** |
| --- | --- | --- | --- | --- |
| 733 | 28 | 1721 |  |  |
| 230 | 13639 | 428 |  | 716 |
| 248 | 4310 | 1028 |  | 4310 |
| 587 | 414 | 1912 |  | 414 |
| 337 |  |  |  |  |
| 461 |  |  |  |  |
| 2596 | 18391 | 5089 | 7966 | 5440 |

Each time a sensor reset, its highest tally was recorded in the table above. More detailed tallies are available at [www.hccclibrary.net/pi/pi\_data.xlsx](http://www.hccclibrary.net/pi/pi_data.xlsx) .

## Appendix B: Pictures

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_apdx_b_01.png)  
**Picture 1.** View of Laser Pi and breadboard with LDR sensor

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_apdx_b_02.png)  
**Picture 2.** Close-up of LDR sensor

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_apdx_b_03.png)  
**Picture 3.** Close-up of laser breadboard

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_apdx_b_04.png)  
**Picture 4.** View of Ultrasonic Pi, senor, and breadboard

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_apdx_b_05.png)  
**Picture 5.** Alternative view of Ultrasonic Pi, senor, and breadboard

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_apdx_b_06.png)  
**Picture 6.** View of the PIR Sensor from various angles

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_apdx_b_07.png)  
**Picture 7.** View of all three mounted Pis

![](https://journal.code4lib.org/media/issue38/cintron/pi_gatecounter_apdx_b_08.png)  
**Picture 8.** Laser in box
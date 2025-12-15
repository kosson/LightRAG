---
title: "Countering Stryker’s Punch: Algorithmically Filling the Black Hole"
source: "https://journal.code4lib.org/articles/12542"
author:
  - "[[The Code4Lib Journal]]"
published: 2017-07-18
created: 2025-01-10
description: "Two current digital image editing programs are examined in the context of filling in missing visual image data from hole-punched United States Farm Security Administration (FSA) negatives. Specifically, Photoshop's Content-Aware Fill feature and GIMP's Resynthesizer plugin are evaluated and contrasted against comparable images. A possible automated workflow geared towards large scale editing of similarly hole-punched [...]"
tags:
  - "clippings"
---
# Countering Stryker’s Punch: Algorithmically Filling the Black Hole
Michael J. Bennett

Two current digital image editing programs are examined in the context of filling in missing visual image data from hole-punched United States Farm Security Administration (FSA) negatives. Specifically, Photoshop’s Content-Aware Fill feature and GIMP’s Resynthesizer plugin are evaluated and contrasted against comparable images. A possible automated workflow geared towards large scale editing of similarly hole-punched negatives is also explored. Finally, potential future research based upon this study’s results are proposed in the context of leveraging previously-enhanced, image-level metadata.

![Photograph of Roy E. Stryker](https://journal.code4lib.org/media/issue37/bennett/Figure1.jpg)  
**Figure 1.** Roy E. Stryker, Head of the Historical Section (Information Division) of the U.S. Farm Security Administration. Photograph by Russell Lee, August 1938 (Lee, 1938)

## I. Introduction

The visual record left behind by the United States Farm Security Administration (FSA) photographers has, according to New York Times critic Charles Hagen, come to “represent one of the most ambitious attempts ever made to depict a society in photographs (Hagen, 1985).” Leading the FSA’s Historical Section was Roy Stryker, a Columbia-trained economist. Though Stryker was not a photographer himself, he understood the power that images could have in economic argument and the general sway of ideas. In fact, New Deal propaganda on the plight and needed social assistance for the rural impoverished was one of the Historical Section’s main aims.

Early during his tenure, Stryker would hire a small but remarkable group of photographers who would go on to express new documentary styles of depicting rural America during the Great Depression. Walker Evans, Dorothea Lange, and Ben Shahn, among other notable artists, all served under Stryker, who in many ways was a pivotal support to them during times of acute economic hardship, and was a strong advocate towards their subsequent post-FSA careers.

As his staff would send back their negatives from the field, it was Stryker who would determine which images would be printed. Those that did not pass his visual inspection he would “kill” by punching a hole in the transparency with a hole punch. To this day, articles continue to lament this past practice, which has certainly affected Stryker’s legacy and the resulting historical visual record (Taylor, 2017)(Arbuckle, 2016)(Banks, 2010).

![Photo of a young black girl with a hole punched through the center of her stomach](https://journal.code4lib.org/media/issue37/bennett/Figure2.jpg)  
**Figure 2.** Untitled photo, possibly related to: Girl in Washington, D.C. slum area. Photograph by John Vachon, December 1937 (Vachon, 1937b).

However, with today’s advanced editing tools it is interesting to ask if these black holes might be revisited and perhaps algorithmically filled in just a few mouse clicks? And if such a workflow was consistently successful, could it be automated across a large quantity of hole-punched images?

## II. Gathering Test Images and Comparing Tools

To begin it was deemed best to start with a clearer sense of the total number of negatives that were killed yet were still archived. Luckily the Library of Congress’ Prints and Photographs Online Catalog (PPOC) hosts the Farm Security Administration/Office of War Information Black-and-White Negatives as a digital collection (“Farm Security Administration/Office of War Information Black-and-White Negatives – About this Collection – Prints & Photographs Online Catalog (Library of Congress),” n.d.). Within this collection, each punched negative has a note in its bibliographic record that states, “Negative has a hole punch made by FSA staff to indicate that the negative should not be printed.” The note entry is an indexed field of the descriptive record, so its contents are searchable. A quick look-up, then, for “hole punch” resulted in 2,472 total images. Examples with either complex detail surrounding the punch or in cases where the hole has completely removed significant image context were excluded from this initial study.

![Image of an older white man wearing a hat, with a hole punched through his face](https://journal.code4lib.org/media/issue37/bennett/Figure3.jpg)  
**Figure 3.** Killed Image with Significant Lost Detail. Untitled photo, possibly related to: Start of the three-legged race. Fair at Albany, Vermont. Photograph by Carl Mydans, September 1936 (Mydans, 1936a).

Two of the main criteria used in the author’s subsequent examination of photo editing tools included usability, and scalability. In turn, elaborate selecting, layering, masking, and individualized cloning techniques were not studied. Regardless of the proven power of these traditional but highly manual methods, the focus of this inquiry was to gauge how effective newer, more automated tools have become.

Content Aware-Fill first became available in Photoshop CS5 in 2010 (Goldman, Shechtman, Barnes, Belaunde, & Chien, n.d.). Foundational investigations that went into the tool’s development came from studies done on the completion of space-time holes in video sequences (Wexler, Shechtman, & Irani, 2007), and work towards a randomized algorithm for quickly finding approximate nearest neighbor matches between image patches (Barnes, Shechtman, Finkelstein, & Goldman, 2009). These efforts were conducted by researchers at the Weizmann Institute of Science, Princeton University, University of Washington, and Adobe’s Creative Technologies Lab. With new software releases over time, Adobe often makes iterative optimizations to their tools and the algorithms that these features depend upon. The workflow tests that follow were conducted by the author with Photoshop CC 2017.0.1 on an Apple Macbook Pro (OS X 10.11.6, 16GB RAM, 3.1 GHz Intel Core i7 processor, 1TB SSD).

Here is an example of how Content Aware-Fill was used on one of the FSA negatives:

![Photograph of a white man smoking a cigarette with a whole punched through his shirt. In the background are wooden walls, a hung sheet, and a phonograph.](https://journal.code4lib.org/media/issue37/bennett/Figure4.jpg)  
**Figure 4.** Untitled photo, possibly related to: Arkansas tenant farmer. Photograph by Ben Shahn, October 1935 (Shahn, 1935).

Using Photoshop’s elliptical marquee tool, a tight selection was made around the hole’s edge.

![Figure 4 photograph with a selection tool highlighting the hole in the man's shirt](https://journal.code4lib.org/media/issue37/bennett/Figure5.jpg)  
**Figure 5.**

From Photoshop’s Edit menu > Fill > Content-Aware > OK.

![A screenshot of the proper settings on the content aware menu](https://journal.code4lib.org/media/issue37/bennett/Figure6.jpg)  
**Figure 6.**

Deselect. Done…

![A comparison of Figure 4 and a second image in which the hole in his shirt appears mended](https://journal.code4lib.org/media/issue37/bennett/Figure7.jpg)  
**Figure 7.** Before and After Photoshop Content-Aware Fill

That the entire process takes four clicks and roughly 10 seconds was a promising revelation. Equally encouraging was the seamlessness of the resulting fill. Here is a 100% detail of the mend from the previous image:

![A zoomed in view which shows that the repaired hole in the shirt blends with neighboring texture](https://journal.code4lib.org/media/issue37/bennett/Figure8.jpg)  
**Figure 8.** Detail of Content-Aware fill

The following are examples of other images that were similarly filled using Photoshop:

![Photograph of black man and woman apparently standing on a ciy bridge. Hole punched in the background appears healed in the comparison on the right.](https://journal.code4lib.org/media/issue37/bennett/Figure9.jpg)  
**Figure 9.** Before and After Photoshop Content-Aware Fill. Untitled. Photograph attributed to Walker Evans (Evans, n.d.).

![Photograph of a black woman with a small child in front of a wooden wall. Hole punched in her chest has been repaired.](https://journal.code4lib.org/media/issue37/bennett/Figure10.jpg)  
**Figure 10.** Before and After Photoshop Content-Aware Fill. Untitled photo, possibly related to: Sharecropper and sharecropper’s dog. North Carolina. Photograph by John Vachon, April 1938 (Vachon, 1938a).

![Photograph of a small white child sitting in the dirt next to an adult's leg. A hole has been punched in his arm has been healed.](https://journal.code4lib.org/media/issue37/bennett/Figure11.jpg)  
**Figure 11.** Before and After Photoshop Content-Aware Fill. Floyd Burroughs, Jr., and Othel Lee Burroughs, called Squeakie. Son of an Alabama cotton sharecropper. Photograph by Walker Evans, Summer 1936 (Evans, 1936).

![A broad view of a county fair with a hole punched in the general background and then repaired.](https://journal.code4lib.org/media/issue37/bennett/Figure12.jpg)  
**Figure 12.** Before and After Photoshop Content-Aware Fill. Untitled photo, possibly related to: Spectators at county fair, central Ohio. Photograph by Ben Shahn, August 1938 (Shahn, 1938).

It is interesting to note that besides Photoshop’s Content-Aware fill, GIMP’s Resynthesizer plugin also offers similar functionality within a piece of image editing freeware (David, 2012). Though Photoshop’s tool gets much of the attention for being the Swiss-army knife of quick and effective image filling, Resynthesizer’s code actually pre-dates the release of Content-Aware fill (Harrison, 2005).

GIMP’s latest v.2.8.18 loaded with the Resynthesizer plugin was used by the author to test usability and effectiveness against Content-Aware fill on comparable images. One of the details that immediately became apparent when employing GIMP was how ingeniously designed the built-in fine selection guides were within the software’s ellipse select tool. As a result, very precise selections could be much more easily made than with Photoshop’s elliptical marquee tool:

![A close-up of a selection using GIMP's ellipse select tool](https://journal.code4lib.org/media/issue37/bennett/Figure13.jpg)  
**Figure 13.** Fine-tuning GIMP’s Ellipse Select Tool

After selecting the hole, the subsequent workflow steps, though nominally unique to GIMP, were in essence the same as Photoshop’s. In the GIMP, Filters > Enhance > Heal selection were chosen:

![A menu screen-shot of selecting the GIMP heal selection tool](https://journal.code4lib.org/media/issue37/bennett/Figure14.jpg)  
**Figure 14.** Using GIMP’s Heal Selection

This was then followed by a dialog box where the sampling radius around the selection could be tweaked. The radius setting affects the region of texture sampling that is used to inform the Resynthesizer plugin’s algorithm on how best to heal the selection:

![Screenshots of handling setting within GIMP. Radius to take texture from is 50.](https://journal.code4lib.org/media/issue37/bennett/Figure15a.jpg)  
![Screenshots of handling setting within GIMP. And resynthesize runs.](https://journal.code4lib.org/media/issue37/bennett/Figure15b.jpg)  
**Figure 15.** Setting Radius Parameter, then Running GIMP Resynthesizer Plugin on Selection

Once initiated, the plugin ran noticeably slower than Photoshop’s Content-Aware fill command. Based upon further sampling from four test images, each run in both programs, the following trend emerged. What required Photoshop on average 10 seconds to accomplish, from selection to fill, GIMP took 34 seconds to finish the same set of operations. And though the resulting visual analyses were subjective, the healed holes in GIMP were consistently more conspicuous and not blended as well as the ones that Photoshop filled. However, the differences between programs in this regard were subtle on average.

![Photograph of a white man smoking a pipe. A hole is punched in the blurry background, through the heads of a walking couple.](https://journal.code4lib.org/media/issue37/bennett/Figure16.jpg)  
**Figure 16.** Untitled photo, possibly related to: Man with homemade pipe, Washington, D.C. Photograph by John Vachon, April 1937 (Vachon, 1937a).

![A comparison of how well Photoshop and GIMP healed the hole in two shadowy heads in the background of Figure 16.](https://journal.code4lib.org/media/issue37/bennett/Figure17.jpg)  
**Figure 17.** Detail of Photoshop Content-Aware Fill Result vs. GIMP Resynthesizer Plugin Heal Result

## III. Testing Automated Selection and Filling

The last question examined by the author was whether such image processing could be automated, from selection to final image filling. Photoshop is a flexible piece of software that allows for several different approaches to similar editing issues. However, it is important to remember that one of the guiding principles of this investigation was to find simple strategies that were effective and repeatable.

The biggest challenge in attempting to remove all manual steps from the established Content-Aware Fill workflow was to automate the initial hole selection. For this, Photoshop’s Color Range selection option was tested. Color Range allows for a selection to be drawn around areas within an image that have a particular color. The color can be sampled from within a given image and be set with an eyedropper tool. As the FSA images are all grayscale, the color range setting for the selection tool was pegged at a black level found in one of the image’s holes and was then used thereafter across all the batch processed images. Once the Color Range selection tool settings were tweaked to satisfaction, the tool’s deployment along with the Content-Aware Fill steps were recorded into a Photoshop action, which was then run across a source folder of hole-punched images in an automated batch.

The initial action step then was Select > Color Range. This brought up a dialog box where the following choices were made and the black eyedropper was used to sample from the hole:

![An example of highlighting a color range](https://journal.code4lib.org/media/issue37/bennett/Figure18.jpg)  
**Figure 18.**

Select > Modify > Expand to give the Content-Aware fill tool some additional image data from around the hole to sample from:

![A photograph of a small, curled up dog in front of a wooden wall, next to an adult's feet and skirt with a hole punched on the edge of a skirt.](https://journal.code4lib.org/media/issue37/bennett/Figure19.jpg)  
**Figure 19.** Untitled photo, possibly related to: Sharecropper and sharecropper’s dog. North Carolina. Photograph by John Vachon, April 1938 (Vachon, 1938b).

Edit > Fill > Content-Aware

![Figure 19 on the left and a comparison in which not only has the punch hole on the edge of hte skirt been repaired but holes punched at the top and bottom of negative have been awkwardly refilled.](https://journal.code4lib.org/media/issue37/bennett/Figure20.jpg)  
**Figure 20.** Before and After Color Range Auto Selection and Content-Aware fill Using Photoshop Action

As the example shows, the auto selection process was not exact enough to limit the resulting fill to just the punched hole. Film edge perforations were also selected through the Color Range process and as a result underwent extraneous Content-Aware fill. Though somewhat promising, further automation trials also exposed additional problems with imprecise selection. Beyond edge perforations, other random areas of the image that have similar black values to the punched hole can also be included in the selection. These extraneous areas often gave Content-Aware fill confusing information to work with and led to mixed results.

![On the left, a photograph of a man standing in a field with a punch mark in the background. On the right, the same image with very imperfectly-refilled holes.](https://journal.code4lib.org/media/issue37/bennett/Figure21.jpg)  
**Figure 21.** Before and After Color Range Auto Selection and Content-Aware fill Using Photoshop Action. Untitled photo, possibly related to: Vermont farmer and sheep near North Troy. Photograph by Carl Mydans, August 1936 (Mydans, 1936b).

## IV. Summary

As the results of this study indicate, automated image filling currently has limitations of scale when faced with attempting to rebuild highly complex image detail or to fill in the loss of entire objects (e.g. faces). However, when used in conjunction with more manual methods, automation can potentially be employed in a hybrid manner to achieve enhanced post-processing throughput on large image aggregations.

An area of potential future research on the examples in this study includes the use of neighboring negatives. Though all the hole-punched negatives are technically untitled, the Library of Congress, through manual visual analysis, has enhanced the catalog records of these images to include information on other known, titled, and related un-killed images (note the phrase, *possibly related to*: in the killed images’ title fields). In the case of the 35mm images, the related killed and un-killed images most likely were shot on the same roll of film. A browse by call number link below a given killed negative’s thumbnails brings the user to a screen where related images can be viewed in a grid.

![A display of the website view with the browse link highlighted](https://journal.code4lib.org/media/issue37/bennett/Figure22.jpg)  
**Figure 22.** Browse Neighboring Items by Call Number Link.

In the example depicted in Figure 23, the two neighboring images were most likely shot in rapid succession on the same film roll.

![An example of the grid view with multiple photos from the same roll.](https://journal.code4lib.org/media/issue37/bennett/Figure23.jpg)  
**Figure 23.** Neighboring Items Grid View

Could such un-killed images be used in the future to check the accuracy of related filled images? Could these un-killed images be used in some way as source data by a fill tool to better inform the tool on how to more accurately perform its work? (Michel, 2017)

Finally, it is interesting to step back and consider the nature of the hole-punched FSA negatives from their original creation on mostly 1930s-era 35mm black and white film. If it were not for their recognized visual value, safe transfer to the Library of Congress in 1944 (as requested by Stryker), initial digitization in the 1990s, and subsequent re-digitization between 2010-2014, there would be limited image data to work with today (“Farm Security Administration/Office of War Information Black-and-White Negatives – Digitizing the Collection – Prints & Photographs Online Catalog (Library of Congress),” n.d.). That such image repurposing as described in this study is even possible is largely based upon a compelling confluence of transcendent photography, collection building foresight, careful digitization decisions and execution, open online access, and clever software algorithms that continue to be refined by intelligent minds.

Yet, what are we to make of these surrogate negatives? Though they are not based upon standard content replication like their hole-punched brethren, the software-filled versions still hold a certain spell and feel of visual symmetry. From an archival standpoint we may even regard them as born-digital objects in their own right. Perhaps in the end they may simply be best considered informed guesses on fragments of displaced history. As time goes on, and software tools are further enhanced, and perhaps someday the negatives are re-digitized once again to even higher standards, it will be fascinating to re-run similar fill routines on the images to determine if our best visual estimates inch any closer to a truth that we will never be able to fully perceive.

## About the Author

Michael J. Bennett is Head of Digital Imaging and Conservation at the University of Connecticut. There he oversees the digital capture and conservation operations for the University’s archives and special collections. Previously he has served as project manager of Digital Treasures, a digital repository of the cultural history of Central and Western Massachusetts and as executive committee member for Massachusetts’ Digital Commonwealth portal. His research interests include technologies and techniques that focus on digitization, post-processing, and 2D and 3D data formats. He holds a BA from Connecticut College and an MLIS from the University of Rhode Island.

## Bibliography

Arbuckle, A. (2016, March 26). Why some Great Depression photos were punched full of holes. Retrieved March 3, 2017, from [http://mashable.com/2016/03/26/great-depression-killed-photos/](http://mashable.com/2016/03/26/great-depression-killed-photos/)

Banks, Eric. (2010, October 4). William E. Jones: Punctured – The Paris Review. Retrieved May 4, 2017, from [https://www.theparisreview.org/blog/2010/10/04/william-e-jones-punctured/](https://www.theparisreview.org/blog/2010/10/04/william-e-jones-punctured/)

Barnes, C., Shechtman, E., Finkelstein, A., & Goldman, D. B. (2009). PatchMatch: A Randomized Correspondence Algorithm for Structural Image Editing. ACM Transactions on Graphics (Proc. SIGGRAPH), 28(3), 24.

David, P. (2012, August 27). Pat David: Getting Around in GIMP – Heal Selection (Resynthesizer). Retrieved April 6, 2017, from [https://patdavid.net/2012/08/getting-around-in-gimp-heal-selection.html](https://patdavid.net/2012/08/getting-around-in-gimp-heal-selection.html)

Evans, W. (1936). Floyd Burroughs, Jr., and Othel Lee Burroughs, called Squeakie. Son of an Alabama cotton sharecropper. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1998017017/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1998017017/PP/)

Evans, W. (n.d.). \[Untitled\]. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1998016897/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1998016897/PP/)

Farm Security Administration/Office of War Information Black-and-White Negatives – About this Collection – Prints & Photographs Online Catalog (Library of Congress). (n.d.). Retrieved March 20, 2017, from [http://www.loc.gov/pictures/collection/fsa/](http://www.loc.gov/pictures/collection/fsa/)

Farm Security Administration/Office of War Information Black-and-White Negatives – Digitizing the Collection – Prints & Photographs Online Catalog (Library of Congress). (n.d.). Retrieved April 12, 2017, from [http://www.loc.gov/pictures/collection/fsa/digitizing.html](http://www.loc.gov/pictures/collection/fsa/digitizing.html)

Goldman, D., Shechtman, E., Barnes, C., Belaunde, I., & Chien, J. (n.d.). Adobe Research?» Content-Aware Fill. Retrieved April 8, 2017, from [https://research.adobe.com/project/content-aware-fill/](https://research.adobe.com/project/content-aware-fill/)

Hagen, C. (1985). American photographers of the depression Farm Security Administration photographs: 1935-1942. New York: Pantheon Books.

Harrison, P. (2005). Image Texture Tools. Retrieved from [http://www.logarithmic.net/pfh-files/thesis/dissertation.pdf](http://www.logarithmic.net/pfh-files/thesis/dissertation.pdf)

Lee, R. (1938, August). Roy E. Stryker, photograph chief of the U.S. Farm Security Administration standing in street, probably in Washington, D.C. Retrieved March 13, 2017, from [https://www.loc.gov/pictures/item/fsa1997023350/PP/](https://www.loc.gov/pictures/item/fsa1997023350/PP/)

Michel, P. (2017, April 12). Digital Conversion Coordinator, Library of Congress, private communication.

Mydans, C. (1936a, September). \[Untitled photo, possibly related to: Start of the three-legged race. Fair at Albany, Vermont\]. Retrieved June 5, 2017 from [http://www.loc.gov/pictures/collection/fsa/item/fsa1997002469/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1997002469/PP/)

Mydans, C. (1936b, August). \[Untitled photo, possibly related to: Vermont farmer and sheep near North Troy\]. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1997002541/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1997002541/PP/)

Shahn, B. (1935, October). \[Untitled photo, possibly related to: Arkansas tenant farmer\]. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1997016285/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1997016285/PP/)

Shahn, B. (1938, August). \[Untitled photo, possibly related to: Spectators at county fair, central Ohio\]. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1997018930/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1997018930/PP/)

Taylor, A. (2017, February 28). Holes Punched Through History – The Atlantic. Retrieved March 3, 2017, from [https://www.theatlantic.com/photo/2017/02/holes-punched-through-history/518115/](https://www.theatlantic.com/photo/2017/02/holes-punched-through-history/518115/)

Vachon, J. (1937a, April). \[Untitled photo, possibly related to: Man with homemade pipe, Washington, D.C.\]. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1997003067/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1997003067/PP/)

Vachon, J. (1937b, December). \[Untitled photo, possibly related to: Girl in Washington, D.C. slum area\]. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1997002977/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1997002977/PP/)

Vachon, J. (1938a, April). \[Untitled photo, possibly related to: Sharecropper and sharecropper’s dog. North Carolina\]. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1997003141/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1997003141/PP/)

Vachon, J. (1938b, April). \[Untitled photo, possibly related to: Sharecropper and sharecropper’s dog. North Carolina\]. Retrieved March 13, 2017, from [http://www.loc.gov/pictures/collection/fsa/item/fsa1997003138/PP/](http://www.loc.gov/pictures/collection/fsa/item/fsa1997003138/PP/)

Wexler, Y., Shechtman, E., & Irani, M. (2007). Space-Time Completion of Video. IEEE Transactions on Pattern Analysis and Machine Intelligence, 29(3). Retrieved from [http://www.wisdom.weizmann.ac.il/~vision/VideoCompletion/SpaceTimeCompletion\_PAMI07.pdf](http://www.wisdom.weizmann.ac.il/~vision/VideoCompletion/SpaceTimeCompletion_PAMI07.pdf)
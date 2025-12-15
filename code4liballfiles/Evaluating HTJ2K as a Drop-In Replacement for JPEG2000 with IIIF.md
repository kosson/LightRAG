---
title: "Evaluating HTJ2K as a Drop-In Replacement for JPEG2000 with IIIF"
source: "https://journal.code4lib.org/articles/17596"
author:
  - "Glen Robson"
  - "Stefano Cossu"
  - "Ruven Pillay"
  - "Michael D. Smith"
published: 2023-08-29
created: 2025-01-10
description: "JPEG2000 is a widely adopted open standard for images in cultural heritage, both for delivering access and for creating preservation files that are losslessly compressed. Recently, a new extension to JPEG2000 has been developed by the JPEG Committee: “High Throughput JPEG2000,” better known as HTJ2K. HTJ2K promises faster encoding and decoding speeds compared to traditional JPEG2000 Part-1, while requiring little or no changes to existing code and infrastructure. The IIIF community has completed a project to evaluate HTJ2K as a drop-in replacement for encoding JPEG2000 and to validate the expected improvements regarding speed and efficiency. The group looked at a number of tools including Kakadu, OpenJPEG, and Grok that support HTJ2K and ran encoding tests comparing the encoding speeds and required disk space for these images. The group also set up decoding speed tests comparing HTJ2K with tiled pyramid TIFF and traditional JPEG2000 using one of the major open source IIIF Image servers, IIPImage. We found that HTJ2K is significantly faster than traditional JPEG2000, though the results are more nuanced when compared with TIFF."
tags:
  - "#HTJ2K"
  - "#JPEG2000"
  - "#IIIF"
  - "#lossy/image"
---
# Evaluating HTJ2K as a Drop-In Replacement for JPEG2000 with IIIF
Glen Robson, Stefano Cossu, Ruven Pillay, Michael D. Smith

JPEG2000 is a widely adopted open standard for images in cultural heritage, both for delivering access and for creating preservation files that are losslessly compressed. Recently, a new extension to JPEG2000 has been developed by the JPEG Committee: “High Throughput JPEG2000,” better known as HTJ2K. HTJ2K promises faster encoding and decoding speeds compared to traditional JPEG2000 Part-1, while requiring little or no changes to existing code and infrastructure. The IIIF community has completed a project to evaluate HTJ2K as a drop-in replacement for encoding JPEG2000 and to validate the expected improvements regarding speed and efficiency. The group looked at a number of tools including Kakadu, OpenJPEG, and Grok that support HTJ2K and ran encoding tests comparing the encoding speeds and required disk space for these images. The group also set up decoding speed tests comparing HTJ2K with tiled pyramid TIFF and traditional JPEG2000 using one of the major open source IIIF Image servers, IIPImage. We found that HTJ2K is significantly faster than traditional JPEG2000, though the results are more nuanced when compared with TIFF.

## Introduction

The [International Image Interoperability Framework (IIIF)](https://iiif.io/) has emerged as an open, standards-based solution for making high-quality images available on the web in a way that is efficient and interoperable. The first API to be released was the IIIF Image API which provides a way of constructing a URL that defines a particular region and size of an image. There are a wide number of Implementations of the Image API in the form of [IIIF Image Servers](https://github.com/IIIF/awesome-iiif#image-servers) but the IIIF standards deliberately avoid prescribing a single file format. Instead, they focus on the server-client interaction and the API. Many image servers work with a variety of image formats including JPEG, PNG, and TIFF but naturally some file formats are better suited to satisfying IIIF requests, particularly image formats that store the image data in multi-resolution forms such as [image pyramids](https://en.wikipedia.org/wiki/File:Image_pyramid.svg) (Figure 1) where different resolutions or sizes can be retrieved quickly.

![](https://journal.code4lib.org/media/issue57/robson/image2.png)
**Figure 1.** Multi-resolution tiled pyramid structure used in tiled pyramid TIFF

Another feature of the multi-resolution image pyramid above are the tiles that make up each of the different resolution levels. Similar to the way online mapping tools like Google Maps achieve efficient zooming into a map, this tiling allows an IIIF viewer to only request the regions of the image (or tile) that are currently being viewed. This means that the user can quickly dive into the detail of an image without downloading the full sized image.

In the IIIF community, the most [popular formats](https://youtu.be/Z-Wd8tcXYtA?t=6088) which provide these image pyramids are currently JPEG2000 (JP2) [^1][^2] or TIFF (tiled pyramid). High Throughput JPEG 2000 (HTJ2K) is a new addition to the JPEG2000 family of standards [^3][^4]. HTJ2K is a replacement for the slow block coder in JPEG 2000 Part-1 and the new standard is designed as a drop-in replacement to work with existing JPEG2000 encoding/decoding tools.

In addition to choosing the image format, users of JP2, HTJ2K, and TIFF images need to decide whether to compress the images using lossless or lossy compression. Lossless compression means that the original image bitmap can be re-created exactly and that none of the data is lost in the conversion. Lossy compression results in much smaller files that aim to be visually close to the original, but the conversion is not reversible. In the IIIF context, some institutions have separate preservation copies of images and so can choose to go for lossy compression for their images made available for access through IIIF.

There are both commercial and open source tools for encoding and decoding JP2 and HTJ2K images and this paper describes tests undertaken to determine their level of support for HTJ2K and how performant they are compared to each other. TIFF is an open format with a wide range of available tools. In particular, the widely-used libtiff library and image processing tools such as vips or imagemagick.

The tools used to encode HTJ2K image were:

- [Kakadu](https://kakadusoftware.com/), a commercial SDK and command-line toolkit used to encode and decode several still and moving image formats;
- [OpenJPEG](http://www.openjpeg.org/), a popular open source JPEG toolkit that includes support for JPEG2000 part 1 (traditional JP2) and part 15 (HTJ2K);
- [Grok](https://github.com/GrokImageCompression/grok), another open source toolkit with several optimizations for JP2 and HTJ2K.

Support for HTJ2K at the time of these tests was still emerging and a summary of this support for various libraries is shown below:

|  | **Kakadu** | **Grok** | **OpenJPEG** |
| --- | --- | --- | --- |
| **HTJ2K lossy encoding** | YES | PARTIAL\* | NO |
| **HTJ2K lossless encoding** | YES | YES | NO |
| **HTJ2K lossy decoding** | YES | YES | YES |
| **HTJ2K lossless decoding** | YES | YES | YES |

This table was correct at the time of testing in May 2022.

\* Grok [clarified](https://github.com/GrokImageCompression/grok/issues/312) that lossy encoding can be done but the bit rate or quality of the compression is currently not configurable \[[issue tracker](https://github.com/GrokImageCompression/grok/issues/317)\].

## Encoding tests and storage comparison

The first part of testing the suitability of HTJ2K for IIIF is to look at the encoding speed. For these tests we used a sample of 1,000 TIFF files from the Getty Museum and Getty Research Institute. The test set included a variety of sizes to reflect what can be found in typical institutional collections. Generally, for IIIF use, encoding is performed once whereas decoding is done for every IIIF request. The encoding often happens soon after an item is digitized and can be part of the digitization workflow or part of the ingestion process into a repository.

The following tests were run natively on bare metal using Linux (Ubuntu 20.04 LTS). The server used was a powerful 16-core Intel(R) Xeon(R) CPU combined with RAID 10 disk array storage.

At the time of testing, support for HTJ2K was emerging in the open source libraries OpenJPEG and Grok but was already established in the commercial Kakadu library. This led to some of the tests only being supported in some libraries. The encoding tests undertaken were:

- TIFF encoded using vips
- JPEG2000 Part 1 using OpenJPEG, Kakadu and Grok
- HTJ2K using Kakadu and Grok (lossless only for Grok / OpenJPEG unable to encode HTJ2K)

The sizes of the files generated are represented in the following graphs (Figure 2).

[![](https://journal.code4lib.org/media/issue57/robson/image1_624.png)](https://journal.code4lib.org/media/issue57/robson/image1.png)
**Figure 2.** Average compression ratios for each encoder and format for both lossy and lossless compression (lower is better). The vertical axis represents the ratio of the resulting image file size with respect to that of the original uncompressed file. A ratio of 1 would indicate that the compressed file is the same size as the original

The tests for each combination of format and codec were carried out 3 times for each of the 1000 images with the times averaged for reach encoder/format combination. The results show:

- JPEG2000 can achieve significantly better compression than TIFF for both lossy (JPEG) or lossless (Deflate)
- HTJ2K compressed files are slightly larger than for JPEG2000 Part 1
- Different JPEG2000 codecs produce almost identical output

Results when comparing the encoding time are represented in the following graphs (Figure 3):

[![](https://journal.code4lib.org/media/issue57/robson/image5_624.png)](https://journal.code4lib.org/media/issue57/robson/image5.png)
**Figure 3.** Average relative encoding time for each encoder and format combination (lower is better). The vertical axis represents relative encoding time with respect to the fastest encoding combination. The fastest (Kakadu/HTJ2K) is, therefore, equal to 1

The encoding times vary significantly between encoders with lossy TIFF encoded with VIPS taking roughly 7 times longer than with Kakadu encoded to HTJ2K. Encoding to HTJ2K is faster than to JP2 for both Kakadu and Grok.

The encoding speed also depends on the amount of data that needs to be encoded and, therefore, on the size of the source image. The relationship between image size and encoding time can be seen in the following graph (Figure 4):

[![](https://journal.code4lib.org/media/issue57/robson/image8_624.png)](https://journal.code4lib.org/media/issue57/robson/image8.png)
**Figure 4.** Average encoding time vs raw image size. The vertical axis represents the absolute time in milliseconds and the horizontal access, the raw image size in bytes.

The results show:

- There are large differences between codecs
- Kakadu is significantly faster for all types
- HTJ2K encoding is faster than JPEG2000 Part 1, especially for lossless encoding
- Lossless JPEG2000 encoding is faster than lossy encoding for all codecs and JPEG2000 types
- There  is a strong linear relationship between image size and encoding speed

### Summary on encoding

When evaluating the encoding, the resulting size on disk might be a more useful metric than encoding speed because encoding images for use with IIIF is only carried out once whereas decoding is done for every IIIF request. As seen in these results, JP2 and HTJ2K produce significantly smaller images with respect to TIFF for both lossy and lossless compression. HTJ2K images are marginally larger than JP2.

If encoding speed is important, then the commercial library Kakadu currently has a speed advantage over the open source libraries. With the lack of support for lossy HTJ2K encoding in the open-source libraries, it is difficult to say definitively that encoding to HTJ2K is faster than encoding to JP2 for all libraries, but it is clearly faster with Kakadu for both lossy and lossless and faster with Grok for lossless.

## Decoding tests

Testing decoding is important, as it occurs for every IIIF request made by a client. There are a number of different types of requests a client can make. Types of requests include:

### Info.json requests

The Image API provides an info.json response where a client can request a JSON file that contains essential metadata about the image, for example: full width and height, or tile information. During normal use, this file would be requested once per image and is usually cached by an image server, as it is often requested. The information in the info.json response is generated by the image server using information obtained from the metadata within the image file itself. Results for testing these types of requests have [not been included](https://github.com/IIIF/htj2k/tree/main/reports/glen/2023-05-30#infojsons) in this article but timings were similar for all types of JP2 and slower for TIFF. However, as these files are often cached by the image server the performance difference between formats is unlikely to be noticed by users.

### Tile requests

These are the most common requests made by IIIF viewers. Both JPEG2000 and TIFF define the size and number of tiles at different zoom levels which the client will then request. Some of these tiles may be cached but it depends if multiple users are looking at the same region of an image.

### Full region requests

These are requests for the full image at different sizes. Thumbnail-sized images are requested often by clients whereas full-sized images are very rarely requested by IIIF viewers but may be requested if users wish to download the image at a particular size.

### Custom region requests

In the IIIF Image API, it is possible to build a URL to request an arbitrary region of an image that can be larger than a single tile or not aligned with the boundaries of the existing tile structure. This URL can be generated, for example, using an [IIIF cropping tool](https://github.com/IIIF/awesome-iiif#image-tools). Generally, there won’t be many requests that fall into this group, but if the link is shared on social media or in a blog it has the potential to get many requests. If the same link is accessed multiple times, it will likely be cached. Results for this type of request have not been included in this report but can be found in the group’s [full results](https://github.com/IIIF/htj2k/tree/main/reports/glen/2023-05-30#random-non-tile-regions).

## Testing decoding libraries

The IIPImage server supports both the OpenJPEG and Kakadu codecs and can handle both JP2 and HTJ2K. It also provides precise (microsecond) timing information for each internal process, which allows the extraction of precise timing for the decoding part of the process. There are a number of IIIF Image Servers, but [IIPImage](https://iipimage.sourceforge.io/documentation/server) was chosen for these tests. For the decoding tests, the 50 largest images from the Getty test set were chosen and a set of random tile requests was generated. 100 random IIIF tile requests were made at different regions and sizes for each image, resulting in 5000 requests in total. Each request was made 3 times and the resulting times averaged. The same 5000 IIIF requests were used for all decoding tests. Grok is not supported by IIPImage, so only OpenJPEG and Kakadu were included in this round of testing for JPEG2000. Results can be seen in Figure 5.

[![](https://journal.code4lib.org/media/issue57/robson/image6_624.png)](https://journal.code4lib.org/media/issue57/robson/image6.png)
**Figure 5.** Average relative decoding times for each tile request for each combination of decoder and format (lower is better). The vertical axis is normalized such that the fastest encoder/format combination (lossy TIFF in this case) is defined as 1.

The results show:

- Tiled pyramid TIFF is by far the fastest format for random tile access on large images
- For JPEG2000, OpenJPEG remains significantly slower than Kakadu: 10x slower for lossy encoded images and up to 15x slower for lossless encoded images
- HTJ2K decoding is about 2x faster for lossy JPEG2000 and ~20% faster for lossless for both OpenJPEG and Kakadu
- Lossy encoded images are quicker to decode than lossless

The next set of tests used the same 50 largest images from the Getty test set but replicate a more typical image server setup with the timings being the full end to end timings that an IIIF viewer would receive including the HTTP request handling. The IIIF image server, again IIPImage, was set up using [Docker](https://github.com/IIIF/htj2k/tree/main/image_server) and was run on a 2020 MacBook Pro alongside the testing scripts. Only the Kakadu library was used to focus on the differences between JP2 and HTJ2K rather than the difference in library processing speeds. TIFF is included as a comparison.

The first set of tests looked at the full region of the image scaled to different sizes. A 50-pixel image would be a small thumbnail whereas a 3000-pixel image would be a large image that a user might want to download. Images that are requested often like thumbnails would usually be cached in the IIIF infrastructure.

[![](https://journal.code4lib.org/media/issue57/robson/image10_624.png)](https://journal.code4lib.org/media/issue57/robson/image10.png)
**Figure 6.** Average response time for a 50px width image request for TIFF, JP2 and HTJ2K for both lossy and lossless compression (lower is better).

The results are shown in Figure 6 and show:

- HTJ2K is slightly faster than JP2 and TIFF for very small images.
- At these very small sizes the difference between lossy and lossless is very small.

The next test looks at the other end of the scale where the image is requested with a width of 3000 pixels.

[![](https://journal.code4lib.org/media/issue57/robson/image7_624.png)](https://journal.code4lib.org/media/issue57/robson/image7.png)
**Figure 7.** Average response time for a 3000px width image request for TIFF, JP2 and HTJ2K for both lossy and lossless compression (lower is better).

The results are shown in Figure 7 and show:

- JP2s are considerably slower for larger images
- HTJ2K and TIFF are very similar for large images, though TIFF is slightly faster

These tests were repeated for five different widths: 50 pixels, 500 pixels, 1024 pixels, 3000 pixels and full sized images. The results for both lossy and lossless compression are shown below.

[![](https://journal.code4lib.org/media/issue57/robson/image4_624.png)](https://journal.code4lib.org/media/issue57/robson/image4.jpg)
**Figure 8.** Average response time vs requested image width for lossy TIFF, JP2 and HTJ2K

The results (Figure 8) show:

- TIFF and HTJ2K results are similar for most sizes
- JP2 (JPEG2000 Part 1) is significantly slower for 50, 500, 1024 and 3000 pixel images but is similar for full sized full region images.

[![](https://journal.code4lib.org/media/issue57/robson/image3_624.png)](https://journal.code4lib.org/media/issue57/robson/image3.jpg)
**Figure 9.** Average response time vs requested image width for lossless TIFF, JP2 and HTJ2K

The results for lossless (Figure 9) show the same trends but the difference between JP2 and the other two file formats is much more significant.

The next two results use URLs generated from opening up the images in two of the common viewers in the IIIF community: Universal Viewer (UV) and Mirador. This is intended to give a realistic set of results that could be expected from using one of these viewers. For both viewers, the URLs were generated by creating a manifest with all 50 images in and then navigating between all of the images and zooming around the first few images. The test URLs include both thumbnail and tile requests.

[![](https://journal.code4lib.org/media/issue57/robson/image11_624.png)](https://journal.code4lib.org/media/issue57/robson/image11.png)
[![](https://journal.code4lib.org/media/issue57/robson/image9_624.png)](https://journal.code4lib.org/media/issue57/robson/image9.png)
**Figure 10.** Average response time for Mirador (top row) and Universal Viewer (bottom row) for lossy and losslessly compressed TIFF, JP2 and HTJ2K

Both viewers produce very similar results (Figure 10) and from these results it can be said that TIFF is slightly faster than HTJ2K but both formats are considerably faster than JP2

### Decoding conclusions

Through the majority of tests it can be seen that tiled pyramid TIFF is the fastest format for IIIF requests both for tile requests and for most of the full region tests. HTJ2K has performed well and has proven faster than JP2 in all cases and is nearing TIFF performance particularly with full region requests.

## Recipes

As part of this work and after further investigation, the recommended parameters for creating optimal JPEG2000 files for both HTJ2K and JP2 with Kakadu are as follows:

HTJ2K lossy:

```bash
kdu_compress -i input.tif -o output.jph \
 Cmodes=HT \
 Creversible=no \
 Qfactor=90 \
 Cprecincts="{256,256}" \
 ORGgen_plt=yes \
 Cblk="{64,64}" \
 Clevels=8
``` 

HTJ2K lossless:

```bash
kdu_compress -i input.tif -o output.jph \
 Cmodes=HT \
 Creversible=yes \
 ORGgen_plt=yes \
 Cprecincts=”{256,256}” \
 Cblk="{64,64}" \
 Clevels=8
```

JP2 lossy:

```bash
kdu_compress -i input.tif -o output.jp2 \
 Creversible=no \
 Qfactor=90 \
 Corder=RPCL \
 Cprecincts="{256,256}" \
 ORGgen_plt=yes \
 Cblk="{64,64}" \
 Clevels=8
```

JP2 lossless:

```bash
kdu_compress -i input.tif -o output.jp2 \
 Creversible=yes \
 ORGgen_plt=yes \
 Corder=RPCL \
 Cprecincts="{256,256}" \
 Cblk="{64,64}" \
 Clevels=8
```

More details on the recommended recipes for HTJ2K and JP2 can be found on the [IIIF Guides site](https://youtu.be/I5k7nG5Gyx4?t=2085).

Full results, image server docker and encoding scripts can be found on the group’s Github repository:

[https://github.com/IIIF/htj2k](https://github.com/IIIF/htj2k)

## Conclusion

The testing clearly shows that tiled multi-resolution pyramid TIFF is the fastest format for IIIF, but it comes at a cost of significantly more storage space compared to both HTJ2K and JP2. So the question of which format to choose will depend on the size of the image collection that people are working with. For small collections with high visitor traffic, the storage costs for TIFF may potentially be outweighed by the increased performance. For those with larger collections which have many rarely accessed images, the scales might be balanced the other way and reducing storage costs may be more important than the slight performance increase with TIFF.

Generally, decoding lossy images is faster than decoding lossless images. One of the reasons for this is due to lossy files being smaller than the lossless files, and so there is less entropy decoding work to do since there is less entropy coded data to process.

For users already using JPEG2000, the results show a clear performance advantage to migrating from JP2 (JPEG2000 Part 1) to HTJ2K (JPEG2000 Part 15) for all IIIF requests tested. There is a slight increased storage cost for HTJ2K but the improvement in performance could outweigh the increase. Note when migrating to HTJ2K this requires transcoding to a different file format, which uses .jph as its file extension.

It would be useful to do further work on testing the decoding support from the open source JP2 libraries as their support for HTJ2K matures.

## Notes

[^1]: [https://www.itu.int/rec/T-REC-T.800/en](https://www.itu.int/rec/T-REC-T.800/en)

[^2]: [https://www.iso.org/standard/78321.html](https://www.iso.org/standard/78321.html)

[^3]: [https://www.itu.int/rec/T-REC-T.814/en](https://www.itu.int/rec/T-REC-T.814/en)

[^4]: [https://www.iso.org/standard/76621.html](https://www.iso.org/standard/76621.html)

[**Glen Robson**](https://journal.code4lib.org/articles/) (ORCID: [0000-0003-2008-5243](https://orcid.org/0000-0003-2008-5243)) works as the IIIF Technical Coordinator for the consortium of institutions that support IIIF. His main role is to help others implement IIIF through training and working with the community of volunteers to extend the specifications and increase the amount of software that supports IIIF.

[**Stefano Cossu**](https://journal.code4lib.org/articles/) (ORCID: [0000-0003-2474-1180](https://orcid.org/0000-0003-2474-1180)) is a Digital Repository Architect at Harvard University IT. Previously he worked at the Getty Trust on designing and building ETL pipelines and delivery services for IIIF images, and before then he led a team at the Art Institute of Chicago, which introduced IIIF-based services for public image and metadata delivery.

[**Ruven Pillay**](https://journal.code4lib.org/articles/) (ORCID: [0000-0001-5398-1365](https://orcid.org/0000-0001-5398-1365)) is a research scientist working on the application of advanced imaging and data analysis techniques to the study of art. He works at the C2RMF, the national research center for art housed within the Louvre in Paris and has over 25 years of experience working in major art galleries, having also worked at the National Gallery, London and the NationalMuseum, Stockholm. He is also a software developer and maintains [IIPImage](https://iipimage.sourceforge.io/), an open source image server, widely used within the IIIF and scientific imaging communities.

[**Michael D. Smith**](https://journal.code4lib.org/articles/) (ORCID: [0000-0001-6573-9883](https://orcid.org/0000-0001-6573-9883)) has worked as a digital imaging consultant for 20 years. He has worked on projects for many organizations including Kakadu R&D Pty Ltd., Warner Bros., Sony Pictures Entertainment, DCI, NOAA, Dolby, and DTS. He was co-editor of the High-Throughput JPEG 2000 image compression standard that was published in 2019. In 2018, he received a screen credit for his color science work on *Mary Poppins Returns*.  From 2013-2015, he was co-chair of Blu-ray Disc Association’s UHD-TF Video Subgroup which defined the video-related requirements for the Ultra HD Blu-ray disc format. In 2012, Mr. Smith’s work on Warner Bros. Digital End to End (DETE) system led to winning a Technical Emmy.  Mr. Smith was editor of the book “3D Cinema and Television Technology: The First 100 Years” published by SMPTE in 2011 and achieved SMPTE Fellow in 2019. He received the B.S. and M.S. degrees in Electrical Engineering from UCLA in 2001 and 2004 respectively.

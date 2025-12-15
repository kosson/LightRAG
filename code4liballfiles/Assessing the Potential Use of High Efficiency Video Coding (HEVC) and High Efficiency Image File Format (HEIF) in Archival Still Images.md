---
title: "Assessing the Potential Use of High Efficiency Video Coding (HEVC) and High Efficiency Image File Format (HEIF) in Archival Still Images"
source: "https://journal.code4lib.org/articles/13746"
author:
  - "[[The Code4Lib Journal]]"
published: 2018-08-09
created: 2025-01-10
description: "Both HEVC (ISO/IEC 23008–2) video compression and the HEIF (ISO/IEC 23008-12) wrapper format are relatively new and evolving standards. Though attention has been given to their recent adoption as a JPEG replacement for more efficient local still image use on consumer electronic devices, the standards are written to encompass far broader potential application. This study [...]"
tags:
  - "clippings"
---
# Assessing the Potential Use of High Efficiency Video Coding (HEVC) and High Efficiency Image File Format (HEIF) in Archival Still Images
Michael J. Bennett

Both HEVC (ISO/IEC 23008–2) video compression and the HEIF (ISO/IEC 23008-12) wrapper format are relatively new and evolving standards. Though attention has been given to their recent adoption as a JPEG replacement for more efficient local still image use on consumer electronic devices, the standards are written to encompass far broader potential application. This study examines current HEVC and HEIF tools, and the standards’ possible value in the context of digital still image archiving in cultural heritage repositories.

## Introduction

High Efficiency Video Coding (HEVC), also known as H.265, is a video compression standard that has recently received attention for its use with still image data. With Apple’s 2017 announcement of their planned deployment of HEVC-encoded High Efficiency Image File Format (HEIF) files throughout the company’s software and hardware ecosystems, came the news of a possible JPEG replacement that would provide more efficient image storage and transfer in consumer electronic devices such as smartphones and tablets (Concion, 2017; Shah & Thomson, 2017; “High Efficiency Video Coding,” 2018; “High Efficiency Image File Format,” 2018). In this context and in much of the literature that surrounds HEVC and HEIF’s potential as highly efficient still image data standards, the focus has mostly centered on mathematically lossy but visually lossless use (Lainema, Hannuksela, Vadakital, & Aksu, 2016; Nguyen & Marpe, 2015; Hannuksela, Lainema, & Vadakital, 2015; Hanhart, Rerabek, Korshunov, & Ebrahimi, 2013).

The aims of compression in archival still imaging within the cultural heritage domain, however, are more particular and tend to focus on retaining all rendered bits in a mathematically lossless manner. When lossy compression is considered, it is generally done on the more conservative end of the visually lossless acceptance scale (Rieger, 2016). In turn, this study evaluates HEVC’s attributes as both a mathematically lossless and as a visually lossless standard with these particular aims in mind and compares HEVC to the JPEG 2000 specification which has gained steady adoption among cultural heritage institutions over time. Basic techniques for successfully encapsulating HEVC bitstreams in the new HEIF wrapper format are also examined in detail.

## Methods and Results

[![](https://journal.code4lib.org/media/issue41/bennett/fig1x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig1.png)**Figure 1.** Reference 8-bit, sRGB, TIFF Images (left-right, top-bottom) “born\_digital,” “medium\_format\_color\_01,” “medium\_format\_color\_02,” “map,” “card” *(click image to see full detail version)*

### Test 1: Lossless HEVC/H.265 (bitstream) vs. Lossless JPEG 2000 (rendered 8 bit sRGB)

#### Step 1: Reference 8 bit, sRGB TIFF > Lossless HEVC bitstream

Reference TIFF files (Bennett, 2018) were converted through FFmpeg v3.4.1’s use of the open source x265 HEVC encoder (MulticoreWare Inc., 2018) to a mathematically lossless bitstream with the following command:

```
ffmpeg -i reference.tif -preset veryslow -c:v libx265 \
    -x265-params lossless=1 lossless_bitstream.265
```

The x265 encoder’s lossless option disables rate control along with all quality metrics and bypasses both discrete cosine transforms (DCT) and quantization (MulticoreWare Inc., 2014). Additionally, it employs HEVC’s RExt Main 4:4:4 profile, Level-8.5 (Main tier).

To determine whether the HEVC-encoded bitstreams were truly mathematically lossless and reversible, the bitstreams were first converted to uncompressed output TIFFs:

```
ffmpeg -i lossless_bitstream.265 -compression_algo 1 \
    -preset veryslow -pix_fmt rgb24 output.tif
```

These output TIFFs were then compared to the original reference TIFFs through peak signal-to-noise ratio (PSNR) analysis:

```
ffmpeg -i reference.tif -i output.tif \
    -filter_complex psnr output_psnr.tif
```

Subsequent PSNR results for all RGB channels confirmed successful mathematically lossless HEVC encoding (PSNR values of infinity indicate that there is no difference between two given input signals):

```
PSNR r:inf g:inf b:inf average:inf min:inf max:inf
```

#### Step 2: Reference 8 bit, sRGB TIFF > Lossless JPEG 2000

Reference TIFF files were converted to mathematically lossless JPEG 2000 files through the following OpenJPEG v2.3.0 command:

```
opj_compress -i input.tif -o output.jp2
```

Note: OpenJPEG uses the following default conversion settings when only the input and output files are specified in a given command:

- Lossless compression
- 1 layer of quality
- 1 tile
- Size of precinct 215 x 215 (means 1 precinct)
- Size of code-block 64 x 64
- Number of resolution (i.e. DWT decomposition level): 6
- No SOP marker in the codestream
- No EPH marker in the codestream
- No sub-sampling in x and y direction
- No mode switch activated
- Progression order: LRCP
- No index file
- No ROI upshifted
- No offset of the origin of the image
- No offset of the origin of the tiles
- Reversible DWT 5-3 (openjpeg, 2015/2018)

The resulting output JPEG 2000s were then similarly compared to the original reference TIFFs through PSNR analysis to confirm lossless encoding:

```
ffmpeg -i reference.tif -i output.jp2 \
    -filter_complex psnr output_psnr.tif
```

| Reference TIFF File | Width (px) | Height (px) | TIFF File Size (bytes) | Mathematically Lossless HEVC Bitstream File Size (bytes) | Mathematically Lossless JPEG 2000 File Size (bytes) | Percent Difference Filesizes: Lossless HEVC/HEIC vs Lossless JPEG 2000 |
| --- | --- | --- | --- | --- | --- | --- |
| born\_digital\_color.tif | 3,840 | 5,760 | 66,389,704 | 34,137,689 | 22,011,085 | 27 |
| medium\_format\_color\_01.tif | 6,090 | 7,920 | 144,724,980 | 50,610,168 | 43,842,691 | 9 |
| medium\_format\_color\_02.tif | 6,730 | 5,206 | 105,134,840 | 46,383,234 | 42,883,096 | 5 |
| map.tif | 14,540 | 3,104 | 135,450,536 | 79,008,269 | 54,362,217 | 23 |
| card.tif | 1,850 | 1,302 | 7,265,360 | 4,303,967 | 2,686,857 | 29 |

**Table 1.** Comparative File Sizes, Mathematically Lossless HEVC Bitstream vs. Mathematically Lossless JPEG 2000

[![](https://journal.code4lib.org/media/issue41/bennett/fig3x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig3.png)**Figure 2.** Graph of Mathematically Lossless Compression Comparison by Filesize *(click image to see full detail version)*

### Test 2: Visually Lossless HEIF (~42db ave RGB PSNR) vs. Visually Lossless JPEG 2000 (~42db ave RGB PSNR rendered 8 bit sRGB)

#### Step 1: Reference 8 bit, sRGB TIFF > HEVC YUV420p Bitstream

Reference TIFF files were converted to HEVC-encoded bitstreams through the following FFmpeg command:

```
ffmpeg -i reference.tif -preset veryslow -c:v libx265 -crf 17 \
    -pix_fmt yuv420p crf17_yuv420p_bitstream.265
```

Note: Given this FFmpeg command syntax, the x265 encoder employs HEVC’s Main 4:2:0 profile, Level-5 (Main tier). Also, Constant Rate Factor (CRF) settings were used in an iterative manner on an image-by-image basis to create HEVC-encoded bitstreams and subsequent RGB HEIF files with targeted PSNR values. The 42db PSNR figure represents averaged RGB and falls in the middle of the range of commonly understood PSNR values that suggest a visually lossless comparison between two color still image inputs (Lainema et al., 2016; Hannuksela et al., 2015; Comstock, 2011). In addition, the yuv420p pixel format (YUV planar color space with 4:2:0 chroma subsampling) was used in order to ensure subsequent best operation with the Nokia HEIF writer library and example application described below. At the time that these tests were commenced in December 2017, the HEIF writer v2.0 was unable to produce renderable files from anything other than YUV420p color or 8 bit source data, though the HEIF format specification itself outlines support for alternative color spaces and bit depths (Lainema et al., 2016; Hannuksela et al., 2015).

Next, the resulting bitstreams were converted to the HEIF wrapper file format through Nokia’s HEIF writer application v2.0 (Nokia Technologies, 2015/2017):

```
./Bins/writerapp ./config.json
```

Finally HEIF files were then converted in FFmpeg to uncompressed RGB TIFF derivatives for objective PSNR evaluation against original reference TIFFs and to iteratively fine-tune CRF settings in original HEVC bitstream creation:

```
ffmpeg -i reference.tif -i 42db_hevc_heif.tif \
    -filter_complex psnr output_psnr.tif
```

#### Step 2: Reference 8 bit, sRGB TIFF > Visually Lossless JPEG 2000 (~42db ave RGB PSNR rendered 8 bit sRGB):

OpenJPEG allows users to specify target PSNR values when encoding JPEG 2000 files through the program’s -q switch command line control. In practice, it was discovered that setting the -q switch to a value slightly above the targeted PSNR figure produced JPEG 2000 files that best matched the intended PSNR value. The -I command toggles Irreversible Color Transformation (ICT) in place of the Reversible Color Transformation (RCT), and the irreversible *discrete wavelet transform* (DWT) 9-7 filter in place of the 5-3 filter. For visually lossless situations, the 9-7 transform is more suited than the 5-3 transform in conditioning image data for superior compression results. This comes at the cost of being unable to recover the original data due to round-off errors in its calculations. Because of these round-off errors, the 9-7 transform is irreversible (Buckley & Tanner, 2009). In turn, reference TIFFs were converted to visually lossless JPEG 2000s using the following OpenJPEG command:

```
opj_compress -i reference.tif -I -q 43 -o lossy_q43_output.jp2
```

Resulting JPEG 2000 files had the following profile, as verified by Jpylyzer v1.18.0 (“jpylyzer,” 2017):

- Lossy compression
- 1 layer of quality
- 1 tile
- No precincts
- Size of code-block 64 x 64
- Number of resolution (i.e. DWT decomposition level): 5
- No SOP marker in the codestream
- No EPH marker in the codestream
- No sub-sampling in x and y direction
- No mode switch activated
- Progression order: LRCP
- No index file
- No ROI upshifted
- No offset of the origin of the image
- No offset of the origin of the tiles
- Irreversible DWT 9-7

| Reference TIFF File | Width (px) | Height (px) | TIFF File Size (bytes) | Visually Lossless HEVC/HEIC YUV420p CRF Value | Visually Lossless HEVC/HEIC File Size (bytes) | Visually Lossless JPEG 2000 -q 43 File Size (bytes) | Percent Difference Filesizes: Visually Lossless HEVC/HEIC vs Visually Lossless JPEG 2000 | Visually Lossless HEVC/HEIC PSNR (db) | Visually Lossless JPEG 2000 -q 43 PSNR (db) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| born\_digital\_color.tif | 3,840 | 5,760 | 66,389,704 | 11 | 4,246,957 | 3,876,338 | 6 | 41.721753 | 42.388142 |
| medium\_format\_color\_01.tif | 6,090 | 7,920 | 144,724,980 | 17 | 1,228,082 | 699,375 | 34 | 42.475259 | 42.303822 |
| medium\_format\_color\_02.tif | 6,730 | 5,206 | 105,134,840 | 7 | 7,949,377 | 4,319,621 | 36 | 42.369392 | 42.619542 |
| map.tif | 14,540 | 3,104 | 135,450,536 | 3 | 20,062,510 | 11,500,289 | 33 | 41.730134 | 42.182009 |
| card.tif | 1,850 | 1,302 | 7,265,360 | 7 | 776,759 | 684,338 | 8 | 41.777099 | 42.399001 |

**Table 2.** Comparative Metrics, Visually Lossless HEVC-encoded HEIC vs. Visually Lossless JPEG 2000

[![](https://journal.code4lib.org/media/issue41/bennett/fig5x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig5.png)**Figure 3.** Graph of Visually Lossless Compression Comparison by Filesize *(click image to see full detail version)*

## Discussion

In examining the results of mathematically lossless compression (Table 1 and Figure 2) it is interesting to consider that across the five test images JPEG 2000 encoding provided an average of 19% file size reduction compared to HEVC. This may be due in part to the limitations of HEVC’s Main profile lossless options. It should be noted that this preliminary study’s scope did not venture beyond the testing of HEVC’s Main profile and JPEG 2000, Part 1. HEVC is an intricate specification, and its growing ecosystem of format range extensions to the Main profile are designed to support 16 bit data and YUV444 chroma sampling among other features (“HEVC Screen Content Coding Extension (SCC) | JCT-VC,” 2016; “HEVC Format Range Extension (RExt) | JCT-VC,” 2014). However the specification’s mathematically lossless still image encoding option, which may leverage various features of the range extensions, remains mostly absent from the literature and was conspicuously missing from the 2016 ICIP compression challenge (Alexiou et al., 2016). In turn, future testing and investigation is warranted in this regard as the extensions and the tools that support their implementation further develop.

Visually lossless testing attempted to closely follow elements of real world application of compression on source RGB still image files. As a result, the Nokia HEIF writer application, though limited in the type of data that it can currently address, was an important tool. Essentially it imports an HEVC-compressed still image codestream and wraps it in a file format that allows the image data to be decoded as an RGB image. These HEIF images can then be opened and comparatively analyzed in common viewers and editing tools that the reference TIFF and compressed JPEG 2000 files share. For this study, visual comparisons were subsequently made on an Apple Macbook Pro (OS X 10.13.3, 16GB RAM, 3.1 GHz Intel Core i7 processor, 1TB SSD) with 13 inch 2,560 x 1,600 pixels color-calibrated display.

With its October 2017 release of Adobe Creative Cloud 2018 (19.0.0), Photoshop first acquired the ability to view (but not save out) HEIF files. In turn, the resulting ~42db PSNR HEIF files (with .heic extensions) could be subjectively assessed against their original reference TIFF files and similarly derived JPEG 2000s through comparative side-by-side zooming, panning, and pixel-level difference visualizations in Photoshop. HEIF files created by the Nokia application render as 8 bit, sRGB files when natively opened in Photoshop (i.e. no default Photoshop color profile adjustments applied).

Visually lossless JPEG 2000 compression provided an average of 23% file size reduction compared to visually lossless HEVC across the five test images (Table 2 and Figure 3). However, results varied among images based most likely upon content and overall size. This variance was most pronounced in the “medium\_format\_color\_02” image which JPEG 2000 was able to deliver a 36% file size reduction compared to HEVC/HEIF. The smallest percent file size savings that JPEG 2000 afforded was 6% and 8% in the “born\_digital\_color” and “card” files respectively.

A closer examination of the “map” image illustrates the different techniques that HEVC and JPEG 2000 encoding take towards image data. Utilizing the image’s HEVC/HEIF and JPEG 2000 versions as individual layers over the reference TIFF background layer allowed for the use of Photoshop’s Difference blending mode and the addition of a Threshold adjustment layer to visualize pixels changed due to each compression method. Through this visualization technique, pixels that changed from the background reference image layer to the compressed upper layer appeared white. Those unaltered appeared black. Each compressed layer’s visibility could easily be toggled on or off for individual comparison against the reference TIFF.

[![](https://journal.code4lib.org/media/issue41/bennett/fig6x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig6.png)**Figure 4.** Photoshop Difference Blending Mode and Threshold Adjustment Layers

[![](https://journal.code4lib.org/media/issue41/bennett/fig7x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig7.png)**Figure 5.** “map.tif” Reference Image *(click image to see full detail version)*

[![](https://journal.code4lib.org/media/issue41/bennett/fig8x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig8.png)**Figure 6.** “map.tif” Reference Image with Visually Lossless (42db PSNR) HEVC/HEIF Difference Blending Mode Layer. Changed Pixels Appear White. *(click image to see full detail version)*

[![](https://journal.code4lib.org/media/issue41/bennett/fig9x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig9.png)**Figure 7.** “map.tif” Reference Image with Visually Lossless (42db PSNR) JPEG 2000 Difference Blending Mode Layer. Changed Pixels Appear White. *(click image to see full detail version)*

As can be seen in Figures 6 and 7, HEVC and JPEG 2000 work in somewhat different ways. Both, however, leverage traits of the human visual system model (HVS) in order to perform adaptive encoding based upon image content. Though the normative portion of JPEG 2000 Part 1 does not explicitly mention the HVS, it nonetheless uses wavelet transform filters that assign various transform levels to high and low frequency image areas selectively through sub-band coding. Various quantizer step sizes for different sub-bands can also be adaptively employed based upon the dynamic range of the sub-band (Schelkens, Skodras, & Ebrahimi, 2009; Allen & Triantaphillidou, 2011). This results in subtle shifts in compression levels throughout an image based upon such variances (Figure 7).

One similar technique through which HEVC performs its own adaptive encoding is through smart quantization which increases compression levels in areas of an image where the HVS is less perceptive to compression artifacts, such as high frequency image content. Additionally, the standard employs an in-loop deblocking filter to high contrast edges. Blocking artifacts are visible discontinuities that occur at coded block boundaries and are particularly symptomatic of JPEG and MPEG-based *discrete cosine transform* (DCT) coders like HEVC. The HEVC deblocking filter performs detection of such artifacts and attenuates them by applying a selected filter. Through this process, block boundary transitions can be smoothed which can result in better qualitative visual results. In addition, HEVC also supports a second in-loop filter termed, Sample Adaptive Offset (SAO). SAO is a local filter that is adaptively applied to the output of the initial deblocking filter and can further improve subjective image quality (Concion, 2017; Sze & Budagavi, 2014; Norkin et al., 2012).

NOTE: Due to its *discrete wavelet transform* (DWT) architecture, JPEG 2000 normally avoids classic DCT blocking artifacts, unless tiling is heavily used (Schelkens et al., 2009).

Zooming into a particular area of adjacent high and low frequency content in the “map” image starkly reveals these HEVC coding features selectively at work and allows for comparison to the more uniform compression of JPEG 2000.

[![](https://journal.code4lib.org/media/issue41/bennett/fig10x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig10.png)**Figure 8.** “map.tif” Reference Image 100% Zoom. *(click image to see full detail version)*

[![](https://journal.code4lib.org/media/issue41/bennett/fig11x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig11.png)**Figure 9.** “map.tif” Reference Image with Visually Lossless (42db PSNR) HEVC/HEIF Difference Blending Mode Layer 100% Zoom. Changed Pixels Appear White. *(click image to see full detail version)*

[![](https://journal.code4lib.org/media/issue41/bennett/fig12x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig12.png)**Figure 10.** “map.tif” Reference Image with Visually Lossless (42db PSNR) JPEG 2000 Difference Blending Mode Layer 100% Zoom. Changed Pixels Appear White. *(click image to see full detail version)*

It bears noting that subjective visual assessment of all individual versions of the “map” image without difference blending applied revealed no perceptible difference among versions at 100% – 200% zoom. So, despite HEVC’s adaptive encoding techniques, JPEG 2000 still produced a 33% smaller file in this example. Future testing of HEVC’s Screen Content Coding Extension, which is specifically optimized for similarly mixed text and graphics content as maps, is warranted for this format type (“HEVC Screen Content Coding Extension (SCC) | JCT-VC,” 2016).

An examination of the “medium\_format\_color\_01” image using difference blending produced similar visualization results as the “map” image. Once again, high frequency image areas received a noticeably higher proportion of overall HEVC compression relative to areas with less detail. JPEG 2000, on the other hand, again applied its compression more evenly across the entire image.

[![](https://journal.code4lib.org/media/issue41/bennett/fig13x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig13.png)**Figure 11.** “medium\_format\_color.tif” Reference Image. *(click image to see full detail version)*

[![](https://journal.code4lib.org/media/issue41/bennett/fig14x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig14.png)**Figure 12.** “medium\_format\_color\_01.tif” Reference Image with Visually Lossless (42db PSNR) HEVC/HEIF Difference Blending Mode Layer. Changed Pixels Appear White. *(click image to see full detail version)*

[![](https://journal.code4lib.org/media/issue41/bennett/fig15x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig15.png)**Figure 13.** “medium\_format\_color\_01.tif” Reference Image with Visually Lossless (42db PSNR) JPEG 2000 Difference Blending Mode Layer. Changed Pixels Appear White. *(click image to see full detail version)*

Though 34% larger in resulting file size vs. JPEG 2000, here HEVC’s adaptive encoding appeared to have paid discernable dividends. Based upon subjective visual inspection, general skin texture and the repeating patterns of the shortest boy’s shirt and suspenders are more clearly rendered in the HEVC/HEIC file than in the JPEG 2000 file where the patterns’ contrast borders appear somewhat blurred at 200% zoom (Figure 14). Blurring is a known JPEG 2000 compression artifact that appears at higher levels of compression (Schelkens et al., 2009; Jakulin, 2002; Allen & Triantaphillidou, 2011).

[![](https://journal.code4lib.org/media/issue41/bennett/fig16x500.png)](https://journal.code4lib.org/media/issue41/bennett/fig16.png)**Figure 14.** Reference TIFF, Visually Lossless (42db PSNR) HEVC/HEIF, and Visually Lossless (42db PSNR) JPEG 2000 Versions of “medium\_format\_color\_01” Image, 200% Zoom. *(click image to see full detail version)*

It should be stressed that these local artifacts were very slight and only began to be noticeable at 200% zoom. However, their presence corroborates Buckley’s observation on the shortcomings of using PSNR as a quality metric for compressed images…

> This behavior \[visible local artifacts\] also highlights the limitations of a global metric such as PSNR-a single number to describe the effect of compression over the entire image, although compression does not affect all parts of an image equally. Larger distortions and very visible compression artifacts in some parts of the image can be offset by smaller distortions in the rest of the image to give an average distortion for the entire image that would be acceptable if it occurred uniformly over the image (Buckley, 2013).

## Conclusion

This study represents an introductory evaluation of HEVC/HEIF in the context of potential real-world application within cultural heritage imaging using currently available HEVC encoding and HEIF rendering tools. To date, HEVC/HEIF support remains either in its infancy or is non-existent among most still image editing software packages.

With this in mind, it bears noting that comparative file size results between HEVC/HEIF and JPEG 2000 were mostly dissimilar to those found in the existing literature (Alexiou et al., 2016; Lainema et al., 2016; Hannuksela et al., 2015). This may be explained in part due to the fact that research to date has focused more strictly on HEVC and JPEG 2000 encoder comparisons using Y luminance channel PSNR analysis of YUV bitstreams, which primarily gauges spatial image quality, not color quality. Current real-world archival adoption of file formats such as TIFF and JPEG 2000, however, centers on RGB color. Therefore, this investigation has made end-to-end comparisons *not* of HEVC and JPEG 2000 encoders exclusively, but of fully rendered RGB formats based upon these encodings instead. As a result, YUV to RGB color conversion steps, often excluded from pure codestream comparisons, were necessarily introduced as part of the final comparative renderings (and averaged RGB PSNR tests). Such transforms can lead to varying degrees of fidelity loss depending upon the conversion software used.

In the case of HEIF, it should also be noted that the Nokia freeware writer is sparsely documented, proprietary, and does not purport to be a reference implementation of HEIF. It is instead offered as a demonstration tool for early testing of HEVC/HEIF 8 bit sRGB renderings, which was how it was utilized in this inquiry. In addition, its constraints to YUV420p source data cited herein may be more a result of the limits of current HEIF viewers rather than the writer itself. Nonetheless, at present there is no other comparable HEIF tool available that can similarly encapsulate high-quality HEVC encodings into visually lossless HEIF files. It is hoped that Adobe, for one, will someday add flexible quality-controlled Photoshop HEVC/HEIF export support to its current read-only capabilities.

Despite these restrictions, HEVC/HEIF vs. JPEG 2000 comparisons remain visually intriguing, for they offer glimpses into the unique underlying compression techniques that each specification employs. HEVC as a next generation DCT-based technology, for example, uses sophisticated filtering to address compression artifacts that have traditionally manifested themselves in previous block-based specifications like JPEG and MPEG. JPEG 2000, on the other hand, employs discrete wavelet transforms that mostly avoid such blocking but can create other visual artifacts at higher compression ratios.

In summary, this initial study’s findings are inconclusive with respect to the HEVC/HEIC’s tangible advantages as an archival still image format. Additionally, HEVC’s evolving patent landscape (Ozer, 2018) which was outside the scope of this examination, continues to cloud the specification’s prospects within the cultural heritage domain which closely considers how patents can infringe on digital formats’ long-term sustainability (U.S. Library of Congress, 2017). However, with its asserted file size savings and extensible architecture that is designed for future computational photography data management, the specification bears continued assessment as the software that supports it broadens and matures.

Michael J. Bennett is Head of Digital Imaging and Conservation at the University of Connecticut. There he oversees the digital capture and conservation operations for the University’s archives and special collections. His research interests include technologies and techniques that focus on digitization, post-processing, and 2D and 3D data formats. He holds a BA from Connecticut College and an MLIS from the University of Rhode Island.

## Bibliography

Alexiou, E., Viola, I., Krasula, L., Richter, T., Bruylants, T., Pinheiro, A., … Ebrahimi, T. (2016, September). *Overview and benchmarking summary for the ICIP 2016 compression challenge*. Presented at the 23rd International Conference on Image Processing, Phoenix, AZ. Retrieved from [https://jpeg.org/downloads/aic/wg1n73041\_icip\_2016\_grand\_challenge.pdf](https://jpeg.org/downloads/aic/wg1n73041_icip_2016_grand_challenge.pdf)

Allen, E., & Triantaphillidou, S. (2011). *The manual of photography* (10th ed.). Oxford; Burlington, MA: Elsevier/Focal Press. Retrieved from [http://uconn.worldcat.org/title/manual-of-photography/oclc/280389938?referer=di&ht=edition](http://uconn.worldcat.org/title/manual-of-photography/oclc/280389938?referer=di&ht=edition)

Bennett, M. J. (2018). Dataset to Assessing the Potential Use of High Efficiency Video Coding (HEVC) and High Efficiency Image File Format (HEIF) in Archival Still Images. Retrieved from [https://opencommons.uconn.edu/libr\_pubs/62](https://opencommons.uconn.edu/libr_pubs/62)

Buckley, R. (2013). *Using Lossy JPEG 2000 Compression For Archival Master Files*. Retrieved from [http://www.digitizationguidelines.gov/still-image/documents/JP2LossyCompression.pdf](http://www.digitizationguidelines.gov/still-image/documents/JP2LossyCompression.pdf)

Buckley, R., & Tanner, S. (2009). JPEG 2000 as a Preservation and Access Format for the Wellcome Trust Digital Library, 17. Retrieved from [https://wellcomelibrary.org/content/documents/22082/JPEG2000-preservation-format.pdf](https://wellcomelibrary.org/content/documents/22082/JPEG2000-preservation-format.pdf)

Comstock, W. (2011, May). *Using PSNR thresholds to modulate the degree of lossy compression in JPEG2000 files*. Presented at the JPEG 2000 Summit Workshop, Library of Congress. Retrieved from [http://www.digitizationguidelines.gov/still-image/documents/Comstock.pdf](http://www.digitizationguidelines.gov/still-image/documents/Comstock.pdf)

Concion, D. (2017). High Efficiency Image File Format – WWDC 2017 – Videos – Apple Developer. Retrieved December 3, 2017, from [https://developer.apple.com/videos/play/wwdc2017/513/](https://developer.apple.com/videos/play/wwdc2017/513/)

Hanhart, P., Rerabek, M., Korshunov, P., & Ebrahimi, T. (2013). Subjective evaluation of HEVC intra coding for still image compression. Presented at the Seventh International Workshop on Video Processing and Quality Metrics for Consumer Electronics – VPQM 2013, Scottsdale, AZ. Retrieved from [https://infoscience.epfl.ch/record/182874/files/VPQM2013.pdf](https://infoscience.epfl.ch/record/182874/files/VPQM2013.pdf)

Hannuksela, M. M., Lainema, J., & Vadakital, V. K. M. (2015). The High Efficiency Image File Format Standard \[Standards in a Nutshell\]. *IEEE Signal Processing Magazine*, *32*(3), 150-156. [https://doi.org/10.1109/MSP.2015.2419292](https://doi.org/10.1109/MSP.2015.2419292)

HEVC Format Range Extension (RExt) | JCT-VC. (2014). Retrieved March 10, 2018, from [https://hevc.hhi.fraunhofer.de/rext](https://hevc.hhi.fraunhofer.de/rext)

HEVC Screen Content Coding Extension (SCC) | JCT-VC. (2016). Retrieved March 10, 2018, [from https://hevc.hhi.fraunhofer.de/scc](https://hevc.hhi.fraunhofer.de/rext)

High Efficiency Image File Format. (2018, January 6). In *Wikipedia*. Retrieved from [https://en.wikipedia.org/w/index.php?title=High\_Efficiency\_Image\_File\_Format&oldid=819009945](https://en.wikipedia.org/w/index.php?title=High_Efficiency_Image_File_Format&oldid=819009945)

High Efficiency Video Coding. (2018, January 4). In *Wikipedia*. Retrieved from [https://en.wikipedia.org/w/index.php?title=High\_Efficiency\_Video\_Coding&oldid=818680480](https://en.wikipedia.org/w/index.php?title=High_Efficiency_Video_Coding&oldid=818680480)

Jakulin, A. (2002, 2004). Baseline JPEG and JPEG2000 Artifacts Illustrated. Retrieved March 24, 2018, from [http://www.stat.columbia.edu/~jakulin/jpeg/artifacts.htm](http://www.stat.columbia.edu/~jakulin/jpeg/artifacts.htm)

jpylyzer. (2017). Retrieved March 27, 2018, from [http://jpylyzer.openpreservation.org/](http://jpylyzer.openpreservation.org/)

Lainema, J., Hannuksela, M. M., Vadakital, V. K. M., & Aksu, E. B. (2016). HEVC still image coding and high efficiency image file format. In *2016 IEEE International Conference on Image Processing (ICIP)* (pp. 71-75). Phoenix, AZ. [https://doi.org/10.1109/ICIP.2016.7532321](https://doi.org/10.1109/ICIP.2016.7532321)

MulticoreWare Inc. (2014). Lossless – x265 documentation. Retrieved February 9, 2018, from [http://x265.readthedocs.io/en/default/lossless.html](http://x265.readthedocs.io/en/default/lossless.html)

MulticoreWare Inc. (2018). x265 HEVC Encoder / H.265 Video Codec. Retrieved March 29, 2018, from [http://x265.org/](http://x265.org/)

Nguyen, T., & Marpe, D. (2015). Objective Performance Evaluation of the HEVC Main Still Picture Profile. *IEEE Transactions on Circuits and Systems for Video Technology*, *25*(5), 790-797.

Nokia Technologies. (2017). *heif: High Efficiency Image File Format*. C++. Retrieved from [https://github.com/nokiatech/heif](https://github.com/nokiatech/heif) (Original work published 2015)

Norkin, A., Bjontegaard, G., Fuldseth, A., Narroschke, M., Ikeda, M., Andersson, K., … Van der Auwera, G. (2012). HEVC Deblocking Filter. *IEEE Transactions on Circuits and Systems for Video Technology*, *22*(12), 1746-1754. [https://doi.org/10.1109/TCSVT.2012.2223053](https://doi.org/10.1109/TCSVT.2012.2223053)

*openjpeg: Official repository of the OpenJPEG project*. (2018). C, Université catholique de Louvain. Retrieved from [https://github.com/uclouvain/openjpeg](https://github.com/uclouvain/openjpeg) (Original work published 2015)

Ozer, J. (2018, March 13). HEVC Advance Cuts Content Fees on Streaming – Streaming Media Magazine. Retrieved April 28, 2018, from [http://www.streamingmedia.com/Articles/News/Online-Video-News/HEVC-Advance-Cuts-Content-Fees-on-Streaming-123828.aspx](http://www.streamingmedia.com/Articles/News/Online-Video-News/HEVC-Advance-Cuts-Content-Fees-on-Streaming-123828.aspx)

Rieger, T. (2016, September). FADGI Technical Guidelines for Digitizing Cultural Heritage Materials, September 2016. Retrieved from [http://www.digitizationguidelines.gov/guidelines/FADGI%20Federal%20%20Agencies%20Digital%20Guidelines%20Initiative-2016%20Final\_rev1.pdf](http://www.digitizationguidelines.gov/guidelines/FADGI%20Federal%20%20Agencies%20Digital%20Guidelines%20Initiative-2016%20Final_rev1.pdf)

Schelkens, P., Skodras, A., & Ebrahimi, T. (2009). *The JPEG 2000 Suite*. Hoboken, NJ: Wiley.

Shah, A., & Thomson, G. (2017). Introducing HEIF and HEVC – WWDC 2017 – Videos – Apple Developer. Retrieved December 3, 2017, from [https://developer.apple.com/videos/play/wwdc2017/503/](https://developer.apple.com/videos/play/wwdc2017/503/)

Sze, V., & Budagavi, M. (2014). *Design and Implementation of Next Generation Video Coding Systems (H.265/HEVC Tutorial)*. Presented at the IEEE ISCAS 2014, Research Laboratory of Electronics at MIT. Retrieved from [http://www.rle.mit.edu/eems/wp-content/uploads/2014/06/H.265-HEVC-Tutorial-2014-ISCAS.pdf](http://www.rle.mit.edu/eems/wp-content/uploads/2014/06/H.265-HEVC-Tutorial-2014-ISCAS.pdf)

U.S. Library of Congress. (2017, March 9). Sustainability Factors. Retrieved April 28, 2018, from [https://www.loc.gov/preservation/digital/formats/sustain/sustain.shtml](https://www.loc.gov/preservation/digital/formats/sustain/sustain.shtml)
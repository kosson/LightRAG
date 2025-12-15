---
title: "Using ImageMagick to Automatically Increase Legibility of Scanned Text Documents"
source: "https://journal.code4lib.org/articles/5385"
author:
  - "[[The Code4Lib Journal]]"
published: 2011-07-25
created: 2025-01-10
description: "The Law Library Digitization Project of the Rutgers University School of Law in Camden, New Jersey, developed a Perl script to use the open-source module PerlMagick to automatically adjust the brightness levels of digitized images from scanned microfiche. This script can be adapted by novice Perl programmers to manipulate large numbers of text and image [...]"
tags:
  - "clippings"
---
# Using ImageMagick to Automatically Increase Legibility of Scanned Text Documents
Doreva Belfiore

The Law Library Digitization Project of the Rutgers University School of Law in Camden, New Jersey, developed a Perl script to use the open-source module PerlMagick to automatically adjust the brightness levels of digitized images from scanned microfiche. This script can be adapted by novice Perl programmers to manipulate large numbers of text and image files using commands available in PerlMagick and ImageMagick.

## Project Background

Since 1997, the Law Library of the Rutgers University Camden Campus has engaged in a project to provide open access to digital legal materials from the State of New Jersey, other U.S. states, and the United States federal government. Some of the documents are harvested from publically-accessible open data websites, and some of the documents come from the digitization of paper and microfiche volumes.

## Problem

For the digitization of state session laws and state constitutional documents, the library uses a Mekel M565-200 microfiche scanner to scan individual images from microfiche frames and generate JPEG image files of each document page. The Mekel filmSCAN scanning software allows for the manipulation of image density and brightness on the fiche level, but not on the frame level for individual page images. This creates a problem of potentially wide variations in brightness among images scanned from the same fiche.

The library holds a collection of state constitutional law documents on microfiche which were produced by the Greenwood Press. Greenwood Press selectively inserted watermarks on random images, presumably by super-imposing a plastic or glass film sheet over the printed page prior to filming. These large watermarks (see Figure 1) often render the resulting microfiche image dark and, frequently, illegible. In digitizing the microfiche images, there is no way to control for the brightness of the darkened watermarked files while maintaining the brightness and legibility of the non-watermarked ones.

Due to the scale of the State Constitutions Digitization Project (estimated 350,000 image files), there would be no cost-effective way to individually brighten each watermarked file by hand using photo manipulation software such as Photoshop or GIMP. Instead, we needed to find a way to automatically brighten and correct image density for large numbers of scanned text images.

[![](https://journal.code4lib.org/media/issue14/belfiore/belfiore_fig1.png)](https://journal.code4lib.org/media/issue14/belfiore/f1_gpwatermark.jpg)  
**Figure 1** – Example of a Greenwood Press watermark.

## Solution

ImageMagick is a free image manipulation program that can be run on various platforms (Windows, Macintosh, UNIX) and includes a Perl module, PerlMagick, for use in scripting. These features make it an excellent choice for high volume image editing. ImageMagick, from the command line, can generate a large amount of image metadata, from EXIF values to size, filetype, brightness levels, histograms and more. It can also be scripted to perform a wide variety of image manipulations automatically.

Testing ImageMagick alone on the command line, we found that the MODULATE command could increase the brightness of files. Once we determined that ImageMagick could manipulate individual files successfully to increase legibility, we created a script that would work efficiently on a large number of files at the same time.

After the microfiche are scanned, the resulting JPG files are stored in one master folder and retained in their original format until all processing and quality control is complete and the images are uploaded to the Rutgers Camden Law Library website for public access. Copies of each fiche set are made specifically for manipulation via Perl scripts that assign pagination, embed descriptive Dublin Core and EXIF metadata into each image, and take preservation checksums of each image file. Before pagination and metadata assignment, this copy set is used for any manual or automatic image correction procedures.

For this image brightening project, we started with a clean reference file that we chose on the basis of legibility, and used the brightness level of that file as the example from which to evaluate other files in the directory. Because Greenwood Press microfiche do not have a standardized image grid, the person scanning the microfiche has to use his or her best judgment in centering the fiche for the camera. As the camera scans each frame of the fiche sequentially, occasionally black edges occur around the document pages when the frames shift during the scan process. In order to prevent the black edges from skewing the brightness values of our reference image or the other images, we decided to select a sample block for testing from the center of the image. Each original image (frame) on the microfiche is scanned at 400 DPI and is approximately 3804 pixels wide by 3193 pixels long, although the specific dimensions may vary among fiche sets. Through trial and error, we found that the ImageMagick SHAVE command could crop a specific number of pixels from all edges of the image (500 pixels from each side formed an ideal ‘slice’), leaving us with a rectangular block in the center from which to evaluate each file. The “slice” or “snapshot” is loaded temporarily into memory for evaluation, leaving the original file unchanged.

In addition to testing the center portion of each image, we also set the image to monochrome in order to increase text contrast and limit the mathematical comparisons to a smaller number of values (0 to 256). This was a useful choice for our state constitution text files, but might not be appropriate for photographic or other image files.

Using Perl and PerlMagick, we gather and count the number of files in a directory specified by the user, to STDIN. We then open the selected reference file clean.jpg and take the value of the mean of image levels (see SHAVE script below). As this file is monochrome, color values run from 0 to 256. For the purposes of our project, a precision level of 2 decimal points was sufficient to demonstrate the brightening effects that we sought. The script can be adjusted to use a different reference file for each fiche set, allowing the user to customize the baseline standard to the needs of each particular set of images.

**IM\_autocompare.pl script – SHAVE function**

```
#Instantiates an image object in ImageMagick.

 $clean = new Image::Magick();
 $rg = $clean->Read('clean.jpg');
 die "$rg" if $rg;
 die "$rg" if $rg;
 $rg=~ /(\d+)/;
    print $1;               # print the error number
    print LOGFILE $1;	  # log the error number

#Changes grayscale to monochrome to limit to shades of black
 $rg = $clean->Set(Monochrome=>'True');

#This command shaves 500 pixels off the top and sides so that it evaluates the middle
#of the image and not the edges to get an accurate brightness level.
 $rg = $clean->Shave(geometry=>'500x500');
 $rg = $clean->Set(page=>'0x0+0+0');
 die "$rg" if $rg;
 $rg=~ /(\d+)/;
    print $1;               # print the error number
    print LOGFILE $1;	  # log the error number

#Gathers statistics about the clean file

 @rstats = $clean->Statistics();

        $rmean = $rstats[3];
        print "The mean of the good file is: $rmean \n";
        print LOGFILE "Mean of clean file is : $rmean \n";
```

We then open the images to be processed using PerlMagick and read each into memory. The SHAVE command crops out a “snapshot” of each image. The STATISTICS command then reads the snapshot and calculates its mean color levels, which are stored in a variable. Finally, the script compares the mean value of the image file against the mean value of the “clean.jpg” reference file.

Using a graduated percentage scale, if the current file is brighter than the reference file or within 25 points of the reference file value (i.e., a difference in means of less than 25), the script reports that the file is acceptable and takes no action. If the current file is darker than the reference file by a difference of 25 to 49 points, the script issues a MODULATE command of 250, or approximately 25% brightening (see Modulate command below). If the file is darker by a difference of 50 to 74 points, the script issues a stronger MODULATE command of 500, or approximately 50% brightening. If the difference between the reference file and the clean file is 75 to 90 points, the subsequent MODULATE command is issued for 750 or approximately 75% brightening. For any difference greater than 91 points, the maximum MODULATE level of 999 is issued. This split scale of brightness can be adjusted for the needs of the specific files to be corrected. In all cases the script reports to the user what action is being taken and this report can be logged for troubleshooting and documentation.

**IM\_autocompare.pl script – Modulate command**

```
#5 Adjust files for brightness if needed      

# Performing level adjustments based on scale of difference
# between the mean level of the current file and the mean level of the
# difference file.
# Modulate command adjusts brightness from 1 - 999 (highest).

 if (($diff > 25) && ($diff < 49))  {

          print "Adjusting brightness by 25% of file $document now ....\n";
          print LOGFILE "Adjusting brightness by 25% of file $document now ....\n";

        #Instantiates new ImageMagick object.
         $fixer = new Image::Magick();
         $ff = $fixer->Read("$input/$document");
         die "$ff" if $ff;
         $ff=~ /(\d+)/;
         print $1;               # print the error number
         print LOGFILE $1;   # log the error number        

       #Adjusts brightness by 25% and writes over the file.
         $ff = $fixer->Modulate(brightness=>'250');
         $ff = $fixer->Write("$input/$document");
              }
```

As all manipulations take place on the fly in system memory, the brightening process is efficient and takes approximately 1-2 seconds per brightened file. At the end of the brightening step, the original scanned file is overwritten with the corrected image. We maintain our original scans on a separate server as a backup in case of problems or errors. This overwrite step is completely optional, and can be changed by adjusting the PerlMagick Write command to write to a temporary file that can be reviewed, edited or replaced at a later time, as in:

`$x = $y->Write(“$tempfile”);`

In addition, for error handling, the program is set to quit, print, and log any error messages generated by PerlMagick.

Below are before and after examples to demonstrate the results of this script:

[![](https://journal.code4lib.org/media/issue14/belfiore/belfiore_fig2.png)](https://journal.code4lib.org/media/issue14/belfiore/f2_reference.jpg)  
**Figure 2** – “Clean” reference file

The “clean” reference value or mean brightness of the center of this “clean.jpg” is 222.43.

Example #1:

[![](https://journal.code4lib.org/media/issue14/belfiore/belfiore_fig3a.png)](https://journal.code4lib.org/media/issue14/belfiore/f3a_1875_before.jpg)  
**Figure 3a** – Original example file

The mean of the brightness value of the center of this image = 147.017 (Difference = 75.413)

[![](https://journal.code4lib.org/media/issue14/belfiore/belfiore_fig3b.png)](https://journal.code4lib.org/media/issue14/belfiore/f3b_1875_after.jpg)  
**Figure 3b** – Example file brightened by 75 percent

Example #2:

[![](https://journal.code4lib.org/media/issue14/belfiore/belfiore_fig4a.png)](https://journal.code4lib.org/media/issue14/belfiore/f4a_1901_before.jpg)  
**Figure 4a** – Original example file

The mean of the brightness value of the center of this image = 170.566 (Difference = 51.864)

[![](https://journal.code4lib.org/media/issue14/belfiore/belfiore_fig4b.png)](https://journal.code4lib.org/media/issue14/belfiore/f4b_1901_after.jpg)  
**Figure 4b** – Example file brightened by 50 percent

Examples of documents that have been improved by this script can be seen in the Rutgers Law Library’s Nebraska Constitutional Documents Online collection: [http://lawlibrary.rutgers.edu/stateconst/neconst/index.shtml](http://lawlibrary.rutgers.edu/stateconst/neconst/index.shtml)

## Known issues and limitations

At the present time, this script has problems evaluating an image that is composed of only one side of a double-page spread. Taking a center “snapshot” by using the SHAVE command will necessarily include a partially black side and will skew the mean value of the image. For this reason, we did not choose to loop this script to automatically repeat the correction process. Looping would brighten the printed page side to the point of washed-out illegibility. Instead, we run the script sequentially, printing results and errors to a logfile and evaluating the output file for legibility after each pass.

As a future enhancement to this script, we plan to edit the main script to recognize a highly skewed value and fire off a subroutine that will test the image a second time. By taking two vertical slices as “snapshots”, one on each side of the horizontal page, the script will be able to detect an empty page, which shows as a pure black frame. Once detected, a flag can be set for the file to be marked as a single page and exempt it from further brightness evaluation.

Another limitation of the script as currently written is that the gradients for image brightening are deliberately broad. We sought to simplify the brightening process into 4 “strengths” at 25%, 50%, 75%, and 99%, respectively. The script could be improved to utilize better mathematical algorithms to measure the image brightness more tightly, and run multiple passes and checks on the images as they reach a desired brightness level. In a related project using ImageMagick, we are testing the combination of Perl scripts running PerlMagick with CGI scripts presenting images to a non-expert user for evaluation. A negative user response to a prompted question sends the presented image file into a subroutine for further testing and checking, while a positive user response proceeds to the next image. In the future, combining these types of testing methods with an enhanced version of this image brightening script from PerlMagick will allow for faster turnaround time in quality control for the State Constitutions Digitization Project.

## Future projects and other ideas

As the primary goal of the Rutgers Camden Law Library Digitization Project is to digitize and make available as many public domain legal documents as possible, our overriding interest is the provision of public access. In order to achieve the scale of production needed to meet our goals, an automated processing method was absolutely necessary. For our purposes, the percentage scale of image brightening using our method was found to be sufficient to produce legible text from scanned Greenwood Press microfiche when viewed via a standard web browser. This script can be enhanced to increase brightness, sharpness, contrast, or other image levels on a more fine-grained scale, depending upon the needs and goals of the user and programmer. This script could also be extended to take advantage of other file manipulation commands offered by PerlMagick.

This use case is an example of how free and openly available tools can be used to enable the creation of large scale digital library collections at an affordable cost per image that is accessible to libraries and archives with very modest digitization budgets. At the same time, the code involved in this script can be understood and maintained by someone with a fairly modest level of technical programming knowledge, which also makes it an accessible tool for institutions that do not have dedicated programming staff. We have found it to be highly useful, and look forward to improving it over time and applying it to more digitization projects.

## References

ImageMagick Studio LLC. \[Internet\]. \[updated 2011\]. ImageMagick: convert, edit and compose images; \[cited 2011 April 20\]. Available from: [http://www.imagemagick.org/script/index.php](http://www.imagemagick.org/script/index.php).

ImageMagick Studio LLC. \[Internet\]. \[updated 2011\]. PerlMagick API; \[cited 2011 April 20\]. Available from: [http://www.imagemagick.org/script/Perl-magick.php](http://www.imagemagick.org/script/Perl-magick.php).

Joergensen, J.P. 2002. The New Jersey courts publishing project of the Rutgers–Camden Law Library. Law Library Journal 94(4):673-689.

Thyssen, A. \[Internet\]. \[updated 2011 March 15\]. Examples of ImageMagick usage; \[cited 2011 April 20\]. Available from: [http://www.imagemagick.org/Usage/](http://www.imagemagick.org/Usage/).

## Acknowledgements

The author wishes to thank John Joergensen of the Rutgers University Camden School of Law for his mentoring and guidance.

## About the Author

Doreva Belfiore ([dorevabelfiore@gmail.com](https://journal.code4lib.org/articles/)) received her Masters of Library and Information Science in 2011 from the Drexel University iSchool in Philadelphia, PA. She works as a Digital Library and Circulation intern at the Law Library of the Rutgers University School of Law in Camden, New Jersey.

## Appendix

```
Script:  IM_autocompare.pl

#!/usr/bin/perl
#
#
# IMautocompare.pl
#
#
# Comparing brightness of a clean reference file
# to then adjust levels of all files in a given directory
# using PerlMagick.
# 

# Doreva Belfiore
# Rutgers University School of Law - Camden, NJ
# Law Library

#1 Use ImageMagick perl module
 use Image::Magick;

#2 Set variables here

 my($document, $clean);
 my($rg, $average);
 my($rf, $fixer, $ff);

 open (LOGFILE, ">>IM_autocompare.log");

#3 Load the information about what a "clean", "good" or at least
#"repaired" file looks like.

#Here we are using clean.jpg , a very clean document file as a reference image.

 $gdir = ("./reference");
 chdir ("$gdir");

 print "Loading reference information now. Please wait... \n";

#Instantiates an image object in ImageMagick.

 $clean = new Image::Magick();
 $rg = $clean->Read('clean.jpg');
 die "$rg" if $rg;
 die "$rg" if $rg;
 $rg=~ /(\d+)/;
    print $1;               # print the error number
    print LOGFILE $1;	  # log the error number

#Changes grayscale to monochrome to limit to shades of black
 $rg = $clean->Set(Monochrome=>'True');

#This command shaves 500 pixels off the top and sides so that it evaluates the
#middle of the image and not the edges to get an accurate brightness level.
 $rg = $clean->Shave(geometry=>'500x500');
 $rg = $clean->Set(page=>'0x0+0+0');
 die "$rg" if $rg;
 $rg=~ /(\d+)/;
    print $1;               # print the error number
    print LOGFILE $1;	  # log the error number

#Gathers statistics about the clean file

 @rstats = $clean->Statistics();

        $rmean = $rstats[3];
        print "The mean of the good file is: $rmean \n";
        print LOGFILE "Mean of clean file is : $rmean \n";                                                                                  

#4 Open the user-specified folder and get information about the files

 $input = $ARGV[0];
 chomp ($input);

 #$rdir = ("../scratch/alconst");
 $rdir = ("../test");
 chdir ("$rdir");

 print "Processing folder $rdir \n";
          opendir(DIR, "$input");
         @files = grep /\.jpg/i, readdir DIR;
          closedir DIR;
         @files = sort @files;
          $number = @files;

        #Checks files found in the directory
          print "Found $number files in the directory $rdir \n";

 foreach $document (@files)	{ 

#Instantiates an image object with ImageMagick.
    print "Reading $document...\n";
    $average = new Image::Magick();
    $rf = $average->Read("$input/$document");
    die "$rf" if $rf;
    $rf=~ /(\d+)/;
      print $1;               # print the error number
      print LOGFILE $1;	  # log the error number

  print "Transforming image...\n";

#This command shaves 500 pixels off the top and sides so that it evaluates
#the middle of the image and not the edges to get an accurate brightness level.
 $rf = $average->Shave(geometry=>'500x500');
 $rf = $average->Set(page=>'0x0+0+0');
 die "$rf" if $rf;
 $rf=~ /(\d+)/;
    print $1;               # print the error number
    print LOGFILE  $1;  # log the error number

#Changes greyscale to monochrome to limit to shades of black
 $rf = $average->Set(Monochrome=>'True');

#Gathers statistics about the current file
 @avstats = $average->Statistics();

    $amean = $avstats[3];
    $diff = ($rmean - $amean);
    print "The difference between $document and the reference file is $diff \n";
    print LOGFILE "The difference between $document and the reference file is $diff \n";

#5 Adjust files for brightness if needed      

# Performing level adjustments based on scale of difference
# between the mean level of the current file and the mean level of the
# difference file.
# Modulate command adjusts brightness from 1 - 999 (highest).

 if (($diff > 25) && ($diff < 49))  {

    print "Adjusting brightness by 25% of file $document now ....\n";
    print LOGFILE "Adjusting brightness by 25% of file $document now ....\n";

    #Instantiates new ImageMagick object.
      $fixer = new Image::Magick();
      $ff = $fixer->Read("$input/$document");
      die "$ff" if $ff;
      $ff=~ /(\d+)/;
      print $1;               # print the error number
      print LOGFILE $1;   # log the error number        

    #Adjusts brightness by 25% and writes over the file.
      $ff = $fixer->Modulate(brightness=>'250');
      $ff = $fixer->Write("$input/$document");
          }
        die "$ff" if $ff;
        $ff=~ /(\d+)/;
        print $1;               # print the error number
        print LOGFILE $1;  # log the error number      

 elsif (($diff <= 74 ) && ($diff >= 49)) {

      print "Adjusting brightness by 50% of file $document now .... \n";
      print LOGFILE "Adjusting brightness by 50% of file $document now ....\n";

      $fixer = new Image::Magick();
      $ff = $fixer->Read("$input/$document");
      die "$ff" if $ff;
      $ff=~ /(\d+)/;
      print $1;               # print the error number
      print LOGFILE $1;  # log the error number        

    #Adjusts brightness by 50% and writes over the file.
      $ff = $fixer->Modulate(brightness=>'500');
      $ff = $fixer->Write("$input/$document");
           }
      $ff=~ /(\d+)/;
      print $1;               # print the error number
      print LOGFILE $1;	  # log the error number

 elsif (($diff <= 90) && ($diff >= 74)) {

      print "Adjusting brightness by 75% of file $document now .... \n";
      print LOGFILE "Adjusting brightness by 75% of file $document now ....\n";

      $fixer = new Image::Magick();
      $ff = $fixer->Read("$input/$document");
      die "$ff" if $ff;
      $ff=~ /(\d+)/;
      print $1;               # print the error number
      print LOGFILE $1;   # log the error number        

     #Adjusts brightness by 75% and writes over the file.
      $ff = $fixer->Modulate(brightness=>'750');
      $ff = $fixer->Write("$input/$document");
           }
      $ff=~ /(\d+)/;
      print $1;               # print the error number
      print LOGFILE $1;   # log the error number        

 elsif ($diff > 91) {

      print "Adjusting brightness by 99% of file $document now .... \n";
      print LOGFILE "Adjusting brightness by 99% of file $document now ....\n";

      $fixer = new Image::Magick();
      $ff = $fixer->Read("$input/$document");
      die "$ff" if $ff;
      $ff=~ /(\d+)/;
      print $1;               # print the error number
      print LOGFILE $1;   # log the error number        

    #Adjusts brightness by 99% and writes over the file.
      $ff = $fixer->Modulate(brightness=>'999');
      $ff = $fixer->Write("$input/$document");
           }
      $ff=~ /(\d+)/;
      print $1;               # print the error number
      print LOGFILE $1;  #logs the error number  

 else {

      print "Image fine. Skipping to next file... \n";
      print LOGFILE "Image fine. Skipping to next file... \n";

       }              

#6 Undefine variables
 undef $average;
 undef $rf;
 undef $rg;
 undef $fixer;
 undef $ff;
 undef $document;
 undef $clean;

 } #end foreach loop

 close LOGFILE;
```
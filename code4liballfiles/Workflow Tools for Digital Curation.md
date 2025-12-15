---
title: "Workflow Tools for Digital Curation"
source: "https://journal.code4lib.org/articles/8419"
author:
  - "[[The Code4Lib Journal]]"
published: 2013-04-17
created: 2025-01-10
description: "Maintaining usable and sustainable digital collections requires a complex set of actions that address the many challenges at various stages of the digital object lifecycle. Digital curation activities enhance access and retrieval, maintain quality, add value, and facilitate use and re-use over time. Digital resource lifecycle management is becoming an increasingly important topic as digital [...]"
tags:
  - "clippings"
---
# Workflow Tools for Digital Curation
Andrew James Weidner, Daniel Gelaw Alemneh

Maintaining usable and sustainable digital collections requires a complex set of actions that address the many challenges at various stages of the digital object lifecycle. Digital curation activities enhance access and retrieval, maintain quality, add value, and facilitate use and re-use over time. Digital resource lifecycle management is becoming an increasingly important topic as digital curators actively explore software tools that perform metadata curation and file management tasks. Accordingly, the University of North Texas (UNT) Libraries develop tools and workflows that streamline production and quality assurance activities. This article demonstrates two open source software tools, AutoHotkey and Selenium IDE, which the UNT Digital Libraries Division has adopted for use during the pre-ingest and post-ingest stages of the digital resource lifecycle.

## Introduction

Digital curation is the continuous activity of managing and enhancing the use of digital resources over their life-cycle and over time. Digital curation starts when an item is created (born-digital) or selected for digitization (analog) and continues through image processing, metadata capture, derivative creation, and preservation for long-term access (Alemneh 2010).  High quality metadata is necessary for implementing reliable, usable, and sustainable digital collections (Sumner & Custard, 2005).  Recognizing the important role of standardized metadata in digital repositories, the University of North Texas (UNT) Libraries actively promote metadata-based digital resource lifecycle management.

The UNT Digital Libraries Division manages content for The Portal to Texas History and the UNT Digital Library.  The Portal to Texas History provides access to cultural heritage materials related to the history of Texas.  The UNT Digital Library showcases the scholarly and creative output of the university and highlights some of the Libraries’ research holdings.  In managing these repositories, the Digital Libraries Division utilizes various tools and mechanisms to enhance metadata consistency and precision across all digital resources.  Before ingesting digital objects, Web-based metadata creation templates draw terms from locally controlled vocabularies to ensure standardized data entry values.  After objects have been published online, the metadata records are analyzed with Python scripts and command line tools for quality review (Phillips, 2013).

This article describes specialized tools and workflows developed by the UNT Digital Libraries Division that use AutoHotkey and Selenium IDE open source software to manage files and create and edit metadata.  AutoHotkey is especially useful for pre-ingest activities such as file management, data entry, and digital object quality control.  Post-ingest metadata enhancements automated with Selenium IDE facilitate the use, reuse, and preservation of digital objects.  AutoHotkey and Selenium IDE provide quick and accurate digital resource management capabilities with minimal human intervention.

## Automated File Management:  AutoHotkey

AutoHotkey is free, open source software for the Windows operating system which allows users to create automation scripts.  Users write scripts that send multiple keystrokes to the operating system with a single key combination, or hotkey.  The AutoHotkey scripting language supports programming constructs (e.g., variables, loops, conditionals), dynamic GUIs, and direct interaction with the Windows API.  While AutoHotkey provides a convenient platform for quickly developing tools to assist with digital curation tasks, the portability of tools created with AutoHotkey may vary; scripts often require modifications to work properly on multiple machines.  If implemented in a production environment with multiple computers, workstation settings and software should be standardized as much as possible to minimize differences between systems.

AutoHotkey is easier to learn and implement than most scripting languages.  It is an ideal automation solution for digital curators who work primarily in the Windows GUI and have limited experience with computer programming.  Simple AutoHotkey scripts are useful for large, one-off projects that require repetitive file management actions.  For example, a digital curator may write a script that creates a new folder, enters a portion of the folder name, and readies the cursor for further data entry (Figure 1).  A handful of such hotkeys, each designed for one part of the workflow, can speed up large projects and improve metadata accuracy by automating all or a portion of the file management and data entry tasks.  Hotkeys should be selected with care to avoid conflicts with key commands reserved for the operating system and other applications.

```
; define the hotkey: Win + n
#n::

; create a new folder via the File menu
	Send, {AltDown}f{AltUp}
	Sleep, 200
	Send, w
	Sleep, 200
	Send, f
	Sleep, 400

; enter the custom folder name text
; for example, the year of a YYYYMMDD date
	Send, 2013
```

**Figure 1:** AutoHotkey script to create a new folder

More complex scripts improve efficiency for those who are unfamiliar with command line equivalents.  With AutoHotkey, digital curators can perform batch file management tasks within the operating system’s GUI.  For example, a digital curator may develop a suite of custom looping scripts to use when renaming all of the folders in a directory (Figure 2).

```
Pause::Pause
; the Pause key pauses and restarts the loop
; hotkey: Ctrl + r
^r::

; loop renames folders from MM-DD-YYYY to YYYYMMDD format
Loop {

; activate rename for selected folder
	Send, {F2}
	Sleep, 200

; move cursor to start of string
	Send, {Home}
	Sleep, 200

; delete the hyphens
	Send, {Right 2}{Delete}
	Send, {Right 2}{Delete}
	Sleep, 50

; cut the YYYY value
	Send, {ShiftDown}{End}{ShiftUp}
	Send, {CtrlDown}x{CtrlUp}
	Sleep, 50

; move cursor to start of string
	Send, {Home}
	Sleep, 50

; paste the YYYY value
	Send, {CtrlDown}v{CtrlUp}
	Sleep, 50
	Send, {Enter}
	Sleep, 50

; move to the next folder
	Send, {Down}
	Sleep, 500
}
```

**Figure 2:** AutoHotkey loop to rename all folders in a directory

AutoHotkey can also automate actions for multiple applications in one script.  Such scripts minimize mouse usage and allow digital curators to focus on content.  For example, the script in Figure 3 opens a folder selected in Windows Explorer, opens the first file with Notepad++, and locates the first <mods:number> tag in the file.

```
; hotkey: Alt + o
!o::

; open the selected folder
	Send, {Enter}
	Sleep 200

; select the first file
	Send, {Down}
	Send, {Up}
	Sleep, 50

; open the file with Notepad++
	Send, {AppsKey}
	Sleep, 100
	Send, n
	Sleep, 100
	Send, {Enter}

; wait for the file to load
	SetTitleMatchMode 2
	WinWaitActive, Notepad++
	Sleep, 200

; activate the Find window
	Send {CtrlDown}f{CtrlUp}

; wait for the Find window to appear
	WinWaitActive, Find
	Sleep, 100

; locate the first  tag
	SendInput, 
	Sleep, 100
	Send, {Enter}
```

**Figure 3:** Automate actions in more than one application.

### AutoHotkey applications for metadata creation

AutoHotkey provides a convenient platform for developing digital curation micro-applications that bundle frequently used scripts in a GUI.  The standard AutoHotkey installation includes a compiler for creating executable files that run on any Windows computer, even if AutoHotkey is not installed.  The Digital Newspaper Unit (DNU), a sub-group of the UNT Digital Libraries Division, has constructed a set of tools that assist with the creation of digital objects and their associated metadata.  For example, NewspaperNotes.exe (Figure 4) automatically types commonly used metadata notes according to a local data entry standard (Figure 5).  The application reduces typographical errors and increases productivity for the DNU’s student employees.

![](https://journal.code4lib.org/media/issue20/Weidner/workflowfigure4.png)

**Figure 4:**  The NewspaperNotes.exe GUI.

![](https://journal.code4lib.org/media/issue20/Weidner/workflowfigure5.png)

**Figure 5:** NewspaperNotes.exe controlled vocabulary values.

The NewspaperNotes.exe GUI displays keystroke counters for visual interest and short references to the standard hotkey values.  The application also includes three user-defined hotkeys for non-standard notes that may occur on a regular basis in a particular set of newspapers.  Users define the wildcard hotkeys via the Edit menu (Figure 6) and can display the values at any time with the File menu (Figure 7).

![](https://journal.code4lib.org/media/issue20/Weidner/workflowfigure6.png)

**Figure 6:** NewspaperNotes.exe Edit menu and input box.

![](https://journal.code4lib.org/media/issue20/Weidner/workflowfigure7.png)

**Figure 7:** NewspaperNotes.exe File menu and user-defined values display.

In addition to sending keystrokes to the operating system, AutoHotkey has the ability to interact directly with the Windows API.  NewspaperNotes.exe uses this feature to create and open text files that contain newspaper metadata and easily save and close them after data entry.  Figure 8 shows the code that creates a three line text file called  metadata.txt  with the  FileAppend  command and opens it for edting with the  Run  command.  Prior to executing these commands, the script copies the directory path from the Windows Explorer address bar to the clipboard with F4, Ctrl + a, and Ctrl + c.

```
FileAppend, volume:\`nissue:\`nnote:, %clipboard%\metadata.txt
Sleep, 2000	; wait two seconds for the file to be created
Run, metadata.txt, %clipboard%
```

**Figure 8:** Create and open a text file with the  FileAppend  and  Run  commands.

After entering the volume number, issue number, and any notes in the  metadata.txt  file, NewspaperNotes.exe users can quickly save the file with another hotkey.  Figure 9 illustrates the code that accesses Notepad’s File menu with the  WinMenuSelectItem  command to save and close the file while ignoring any documents open in Notepad++.

```
WinMenuSelectItem, Notepad,, File, Save,,,,,, Notepad++,
WinMenuSelectItem, Notepad,, File, Exit,,,,,, Notepad++,
```

**Figure 9:** Select options from Notepad’s File menu with the  WinMenuSelectItem  command.

### AutoHotkey applications for metadata editing

AutoHotkey applications are also useful for editing existing metadata published in an online repository.  The UNT Digital Libraries Division has developed an application, DashboardTools.exe, that bundles search scripts for its online editing platform and public repository interface.  The application also contains hotkeys that quickly switch between the public and administrative views for individual metadata records.  With this tool, digital curators for the Portal to Texas History and the UNT Digital Library can search for and edit published records more efficiently.  For example, the script in Figure 10 searches the title field in the Portal to Texas History public interface, no matter what the currently active application happens to be.

```
; hotkey: Alt + 3
!3::
  InputBox, searchstring, Portal TITLE,,, 250, 100,,,,,	; create a 250x100 pixel input box
    if ErrorLevel	; Cancel button exits the script
      Return
    else		; OK button runs the custom URL in Firefox
      Run, "%firefoxpath%\firefox.exe" "http://texashistory.unt.edu/search/?q=%searchstring%&t=dc_title"
Return
```

**Figure 10:** Portal to Texas History title search script.

When the user triggers the script, an input box appears that accepts a value for the  searchstring  variable.  After the user clicks the OK button, the script loads the desired search results page in Firefox as long as the  firefoxpath  variable is set to the correct directory.  If the user wishes to edit a particular record, the script in Figure 11 quickly opens the Dashboard editing interface by inserting  edit.  at the beginning of the record’s URL in the Firefox address bar.  A similar script removes  edit.  to return to the public display after the user has made and published changes to the metadata.

```
; hotkey: Alt + z
!z::

; focus on the address bar
	Send, {CtrlDown}l{CtrlUp}
	Sleep, 50

; move cursor to start of URL
	Send, {Home}
	Sleep, 50

; add "edit." to URL
	Send, edit.
	Sleep, 50

; load record in Dashboard editing interface
	Send, {Enter}

Return ; exit script
```

**Figure 11:** AutoHotkey script to activate the Portal to Texas History Dashboard editing interface.

## Automated Metadata Enhancement:  Selenium IDE

Selenium IDE is a free and open source add-on for the Firefox Web browser.  It is primarily used by the Web development community to perform automated testing of Web applications.  Selenium IDE provides an integrated development environment in which to create, debug and run custom scripts that automate actions in the browser window.  Users write or record scripts in the Selenium IDE window and use standard play controls to run single scripts, called test cases, or groups of scripts, called test suites.  The Selenese syntax, encoded as an HTML table, sends commands to the browser that act on specified Web page elements in sequence.  See Table 1 for a list of common Selenium IDE commands.

**Table 1:** Common Selenium IDE Commands.

| Command | Function | Usage |
| --- | --- | --- |
| assertValue | Tests an element’s value. | Verify that a page element has a specific value. Accepts regular expressions. |
| click | Performs a mouse click. | Click links, buttons, and check boxes. |
| clickAndWait | Performs a mouse click and waits for the page to load. | Execute the next command in the script after the new page loads. |
| close | Closes the current tab or browser window. | Place at the end of a script to enable automated batch editing with a test suite. |
| keyPress | Sends a key press. | Delete or add characters in a text input element.Use with setCursorPosition. |
| select | Selects a value. | Select a choice from a drop-down menu. |
| setCursorPosition | Places cursor at a specific location in a text input field. | 0 = beginning of text string-1 = end of text string |
| store | Assigns a value to a variable. | Use the variable with the type command to paste the assigned value in a text input field. |
| storeValue | Stores existing text in a variable. | Use the variable with the type command to paste the stored value in a text input field. |
| type | Enters specified text. | Populate a text input field.  Overwrites existing text. |

### Workflow for post-ingest automated metadata normalization

Selenium IDE is an important part of the digital curation toolkit for the UNT Digital Libraries Division.  It has proven to be essential in the ongoing processes of improving and maintaining metadata quality for large collections of digital objects.  Naturally, as careful repository stewards, we attempt to publish accurate and complete metadata when we upload items to our repository.  We have a number of tools at our disposal that facilitate normalized metadata creation and eliminate mistakes before items are uploaded.

Sometimes, for a variety of reasons that are usually out of our control, we end up with incorrect or sub-standard metadata for published digital objects.  After objects have been published, our content management system only provides one method for editing metadata:  the object record.  Someone must open an object record in a Web browser and manually change the information with the editing interface.  When large sets of records contain metadata that must be normalized in order to improve retrieval or meet our repository’s data standards, the single object method is undesirable.

The single object paradigm means that editing large sets of records requires shifting staff time away from more important production activities.  However, if the metadata that must be changed is standard across the entire set, we use Selenium IDE to automate the editing process.  In the best case scenario, a Selenium IDE operator creates a test suite that automates the editing process for multiple object records.  If a test suite is not feasible, an operator implements a test case that streamlines the editing process for individual object records.

A typical metadata editing workflow begins by identifying a set of objects that require normalization.  If the set is large and the required changes are the same for all records, an operator creates a Selenium IDE script that performs the changes, publishes the new metadata, and closes the browser tab.  After testing and debugging to ensure that the script performs correctly, the operator creates a test suite.  Using the content management system’s search interface, the operator opens multiple object records as Web browser tabs.  Finally, the operator runs the test suite.  Each script in the test suite works on a tab in the browser window until there are either no more scripts in the suite or no more tabs in the browser.  The operator repeats the process until the entire record set is normalized.

### Selenium IDE use case:  Newspaper titles on the Portal to Texas History

The UNT Libraries (UNTL) metadata guidelines specify that the Main Title of an object is the title as it is printed on the front page.  We use a template tool to create standard metadata for large groups of similar objects, such as newspaper issues, during ingest.  In some cases it is difficult to notice minor changes in a newspaper title during the quality control process.  After the objects have been uploaded to the Portal to Texas History, however, we can easily view changes in a newspaper title by browsing through the thumbnail images created during the ingest process.

If we identify any title changes that are not reflected in the template-produced metadata, we use Selenium IDE to quickly bring our metadata in line with the UNTL standard.  What follows is a step-by-step HTML code breakdown of a newspaper title script which adds the word “The” to the beginning of a newspaper title:

1. Test that the original title is what we expect it to be with the  assertValue  command.  Adding tests to our scripts ensures that we avoid making inadvertent changes to the metadata; the script will stop if the value does not match.  The field contains information that is unique to each record, such as volume and issue numbers, so we use a regular expression to check the existing value from the beginning of the string.

<tr>

    <td>assertValue</td>

    <td>//div\[@id=’main’\]/div/div\[2\]/div/input</td>

    <td>regexp:^North Texas Daily</td>

</tr>
2. Because the original title contains unique information that we wish to retain, we use two variables to combine the existing text with the new text.  Create the first variable called  NewText  with the  store  command.

<tr>

    <td>store</td>

    <td>The</td>

    <td>NewText</td>

</tr>
3. Create the second variable called  OriginalTitle  for the existing text with the  storeValue  command.

<tr>

   <td>storeValue</td>

   <td>//div\[@id=’main’\]/div/div\[2\]/div/input</td>

   <td>OriginalTitle</td>

</tr>
4. Paste the stored text from both variables, with a single space between them, into the input field with the  type  command.

<tr>

   <td>type</td>

   <td>//div\[@id=’main’\]/div/div\[2\]/div/input</td>

   <td>${NewText} ${OriginalTitle}</td>

</tr>
5. Save the new metadata by clicking the Publish button with the  clickAndWait  command, which waits for the new page to load before executing the next command.

<tr>

   <td>clickAndWait</td>

   <td>name=publish</td>

   <td></td>

</tr>
6. Close the tab with the  close  command to allow the next script in the automation suite to work on the next tab in the browser window.

<tr>

   <td>close</td>

   <td></td>

   <td></td>

</tr>

![](https://journal.code4lib.org/media/issue20/Weidner/workflowfigure12.png)

**Figure 12:**  Newspaper Title Script Test Suite.

Multiple instances of a newspaper title script combined in a test suite (Figure 12) automatically add the word “The” to the beginning of the Main Title field for the corresponding number of digital object records loaded in browser tabs.  In this manner we can quickly edit large sets of records and avoid the inevitable errors introduced during manual data entry.

### The DSpace demo repository and Flickr

The DSpace demo repository ([http://demo.dspace.org/xmlui/](http://demo.dspace.org/xmlui/)) provides a good sandbox for exploring the possibilities of automated metadata editing with Selenium IDE.  Log in as an administrator and use Selenium IDE’s record feature to create scripts.  For example, the script in Figure 13 adds two subject keywords to any item record.

![](https://journal.code4lib.org/media/issue20/Weidner/workflowfigure13.png)

**Figure 13:**  DSpace demo repository script to add subject keywords.

Flickr is another resource for experimenting with Selenium IDE.  The script in Figure 14 copies the existing text in the Title field, pastes it in the Description field, and adds a new Title.  This script is useful for quickly adding descriptive titles to photographs uploaded with a non-descriptive, camera-assigned title (e.g., Photo-0123.jpg).  As long as the Description field is empty, the script will add a new title and retain the original title without deleting any information.  The script can easily be modified to stop if it encounters existing text in the Description field.  Simply add an  assertValue  command with a blank value targeted at the Description field (//div\[@id=’meta’\]/div/textarea) before the  type  commands.

![](https://journal.code4lib.org/media/issue20/Weidner/workflowfigure14.png)

**Figure 14:**  Flickr Title Script in Selenium IDE’s table view.

## Considerations for Automated Digital Curation

AutoHotkey and Selenium IDE are powerful tools for working with digital files and descriptive metadata.  These and other automation tools assist digital curators with their daily workflows so that they can produce better digital collections.  When considering whether or not to implement automation tools, it is important to be mindful of the role of metadata and the importance of digital objects for the scholarly and cultural heritage communities.  High quality descriptive metadata fosters trust among a digital repository’s users, and digital collections often serve as preservation repositories for unique artifacts.  Accordingly, there are a number of pitfalls to recognize and avoid while working with automation tools for digital curation.

Producing and editing large amounts of descriptive metadata is a time-consuming task that requires careful attention to detail.  Technologies such as AutoHotkey and Selenium IDE can facilitate metadata capture and editing activities by automating repetitive workflows.  However, they should be used as complements to, rather than substitutes for, careful evaluation of information resources and the metadata that represents them by skilled employees.  Furthermore, if used improperly, automation tools can introduce metadata errors just as quickly as they can correct them and also have the potential to produce unexpected results while working with files.  When making the decision to implement automation tools, digital curators should proceed with caution, maintain backups of important files, and test tools thoroughly before using them in production.

## Conclusion

Large digital collections present challenges when producing and maintaining descriptive metadata and managing files for digital objects.  Successful digital curation strategies involve mechanisms for both pre- and post-ingest metadata normalization and digital object quality control. Automated workflows with AutoHotkey and Selenium IDE improve efficiency and accuracy during the time- and labor-intensive data entry and file management processes.

With AutoHotkey, digital curators can create custom tools suited to their unique needs.  Simple AutoHotkey scripts make large, one-off projects much easier, and complex scripts provide an alternative to the command line for batch operations.  AutoHotkey micro-applications bundle scripts for frequently-performed file management and data entry tasks in order to streamline digital curation workflows.  The AutoHotkey scripting language is relatively easy to learn, and it provides advanced options for experienced programmers.

From institutional repository platforms such as DSpace to commercial content hosting sites such as Flickr, Selenium IDE can be used to enhance metadata in any content management system with a Web-based editor.  Selenium IDE scripts provide intuitive batch metadata editing capabilities with significant run time oversight because each object record must be loaded as a tab in a Web browser.  Selenium IDE is a highly recommended addition to the digital curation toolkit for any institution that serves and maintains a large amount of metadata content.

## References

- Alemneh, D. (2010). Metadata Quality Assessment: A Phased Approach to Ensuring Long-term Access to Digital Resource. Proceedings of the American Society for Information Science and Technology 46(1). Retrieved from [http://onlinelibrary.wiley.com/doi/10.1002/meet.2009.1450460380/pdf](http://onlinelibrary.wiley.com/doi/10.1002/meet.2009.1450460380/pdf)
- *AutoHotkey Documentation*. (2012). Retrieved from [http://www.autohotkey.com/docs/](http://www.autohotkey.com/docs/)
- Phillips, M. (2013). Metadata Analysis at the Command Line. *Code4Lib Journal (19)*. Retrieved from [http://journal.code4lib.org/articles/7818](https://journal.code4lib.org/articles/7818)
- *Selenium IDE Documentation*. (2012). Retrieved from [http://docs.seleniumhq.org/docs/02\_selenium\_ide.jsp](http://docs.seleniumhq.org/docs/02_selenium_ide.jsp)
- Sumner, T & Custard, M. (2005). Using Machine Learning to Support Quality Judgments. *D-Lib Magazine 11*(10). Retrieved from [http://www.dlib.org/dlib/october05/custard/10custard.html](http://www.dlib.org/dlib/october05/custard/10custard.html)
- *The Portal to Texas History* (2013)*.* Retrieved from [http://texashistory.unt.edu/](http://texashistory.unt.edu/)
- *UNT Digital Library* (2013). Retrieved from [http://digital.library.unt.edu/](http://digital.library.unt.edu/)
- *UNT Libraries’ Input Guidelines for Descriptive Metadata* (2013). Retrieved from [http://www.library.unt.edu/digital-projects-unit/input-guidelines-descriptive-metadata](http://www.library.unt.edu/digital-projects-unit/input-guidelines-descriptive-metadata)
- Weidner, A. (2013). *DashboardTools.ahk*. Retrieved from [https://github.com/drewhop/AutoHotkey/blob/master/DashboardTools.ahk](https://github.com/drewhop/AutoHotkey/blob/master/DashboardTools.ahk)
- Weidner, A. (2013). *NewspaperNotes.ahk*. Retrieved from [https://github.com/drewhop/AutoHotkey/blob/master/NewspaperNotes.ahk](https://github.com/drewhop/AutoHotkey/blob/master/NewspaperNotes.ahk)

Andrew James Weidner ([Andrew.Weidner@unt.edu](https://journal.code4lib.org/articles/)) is the Project Coordinator for New Mexico Historical Newspapers at the University of North Texas Libraries, where he manages digitization activities for the University of New Mexico’s National Digital Newspaper Program grant.

Daniel Gelaw Alemneh ([Daniel.Alemneh@unt.edu](https://journal.code4lib.org/articles/)) is the Digital Curation Coordinator for Digital Libraries at the University of North Texas Libraries and an Adjunct Faculty at UNT’s College of Information where he teaches indexing, abstracting, and information retrieval.
---
title: "Ead McTaggart: Using VBA to Automate EAD Container List Tagging"
source: "https://journal.code4lib.org/articles/2025"
author:
  - "[[The Code4Lib Journal]]"
published: 2009-11-23
created: 2025-01-10
description: "Faced with the prospect of converting 200-page container lists to Encoded Archival Description (EAD), the author programmed a Microsoft Access® database using Visual Basic for Applications (VBA) to automatically insert the necessary EAD tags and their attributes. Some work is still required to ensure that the container list is properly formatted before importing into the [...]"
tags:
  - "clippings"
---
# Ead McTaggart: Using VBA to Automate EAD Container List Tagging
Randall Miles

Faced with the prospect of converting 200-page container lists to Encoded Archival Description (EAD), the author programmed a Microsoft Access® database using Visual Basic for Applications (VBA) to automatically insert the necessary EAD tags and their attributes. Some work is still required to ensure that the container list is properly formatted before importing into the database. Once formatted, the database, named Ead McTaggart, will convert a 7,000 line Microsoft Excel® container list, where each line represents a series, sub-series, or folder title, into a properly tagged EAD container list in about five minutes. As written, Ead McTaggart will handle up to six component levels, but can be modified to handle more. Although many institutions use Archivists’ Toolkit or Archon for this functionality, many libraries and archives who have not implemented those tools will find that EAD McTaggert minimizes the work of converting existing container lists to EAD finding aids with a low time investment for implementation.

## Introduction

When I began in my current position in November 2007, only about one-quarter of the collections had EAD finding aids and not all of those finding aids were complete. Many lacked container lists. Generating EAD for the information other than the container list is not an issue as we create MARC records for any collection which would require an EAD guide. I simply use Terry Reese’s MarcEdit, with a style sheet modified to conform to local standards, to convert the MARC record to EAD. MarcEdit does not help with the container list because those lists are not included in the MARC record. Container lists for the collections existed in the Kheel Labor-Management Documentation Center and Archives at Cornell University in various forms: Microsoft Excel<sup>®</sup>, Microsoft Word<sup>®</sup>, and paper only. The data from these finding aids can be converted to Comma Separated Value (.csv) files and imported into either Archivists Toolbox or Archon, then exported as fully tagged EAD. However the Kheel Center was not using either of these tools and any implementation of either was several years in the future. Something needed to be done in the interim.

The prospect of hand tagging container lists, some over one hundred pages long, and at least one over one thousand pages long, was not pleasant. Importing the data into an Excel spreadsheet and using the fill-down function to fill in repeated tags is a common solution, but keeping track of the closing tags, normalizing dates, and pulling out series headings which link back to the list would still be daunting for any list more than a few pages long. This chore seemed a good candidate for automation. My preferred application for this sort of project is Microsoft Access<sup>®</sup>, which led to the creation of an EAD tagging database I call Ead McTaggart. The first attempt at automating tagging was with an SQL select query involving numerous immediate if (IIF, an SQL function that processes the if-then-else logic in the select clause of an SQL query) statements in the select clause. The query worked well for most of the tagging, but could not place the component level closing tags correctly since they depend on the next line, or record, in the table. At the end of a <c01> line, if the next line was another <c01> a closing tag, </c01> was needed, but it was not needed if the next line was a <c02> line. I needed something that could look into the future to see what was coming up next.

Using Visual Basic for Applications (VBA) in an Access database I was able to have the program evaluate the next line before finishing the current line. This was done by moving the cursor forward in a record set containing all the lines for the container list. With careful use of if-then-else statements, unneeded tags can be automatically left out, or the tag’s attributes can be automatically adjusted to match the tag’s value; i.e., the “normal” attribute for a single date versus a date range in the <unitdate> tag. By using the Unicode designations for line breaks and tabs in the VBA code, the output can be formatted with the proper indentation for ease of use in an EAD editor.

This article will not provide step-by-step instructions for writing the VBA programming needed to convert a container list to EAD. In addition to knowledge of EAD, I will assume a certain level of VBA programming ability and simply cover the more important points in four basic areas: data preparation, special characters, an overview of the database design, and code examples.

## Data Preparation

One key to getting good results with this database system for generating EAD tagged container lists is formatting the data before importing it into the database. As stated above, the Kheel Center’s container lists are mainly in one of three formats: Word, Excel, or print. I prepare the data in Excel, so that the formatting matches the format of the table in Ead McTaggart. The basic spreadsheet has columns for box number, folder number, title, date, and scope content note. I also include columns for box text and folder text, which allow such notations as “Box 1a: Folder 1-12,” while still maintaining proper sort order, without having to left-pad with zeros. The data for these columns comes from the existing folder lists, or, if there is no folder list, the list is created in the spreadsheet. Two other important columns are the “c0” column where the EAD component level is recorded as an integer and the “Index” column which serves to keep the entries in the proper order.

Formatting the data in the Excel spreadsheet is quite simple. Unless the data needs to be cleaned up it also goes quite quickly. Folder lists in Excel usually require little reformatting. Print folder lists require the most reformatting. Scanning, running through OCR, and proof-reading the results before importing into the spreadsheet can take quite a bit of time. Given the error rate for OCR I often just have a student re-key the data into the spreadsheet. Folder lists in Word take a little more reformatting than those in Excel, but not as much as a print list. As an example, if I have a Word document with box numbers, folder numbers, folder titles, and dates, I copy and paste the data into a spreadsheet. Usually, tabs separate most of the elements in the Word document and I only have to separate out the dates from the titles. At this point if the collection will have series and sub-series, I replace all null values in the “c0” column with 3 so that the folder titles will end up at the <c03> component level. If the folder list already has series and sub-series titles, the value in the “c0” column is then changed to 1 for rows with series titles and 2 for rows sub-series titles. If there are not already series and sub-series titles, insert new rows where series titles are needed. Series titles can then be entered and the null values in “c0” replaced with 1. Then insert new rows where sub-series titles are needed, enter the titles and replace the null values in “c0” with 2. At this point the Index field is numbered to maintain proper order. Note that the series and sub-series rows will have null values for “Box” and “Folder,” but are included in the index numbering. The data are now ready for Ead McTaggart. See Table 1.

**Table 1: Sample of container list data formatted in Excel for Ead McTaggart**

| Index | c0 | Box | Box Text | Folder | Folder Text | Title | Date | ScopeContent |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 1 |  |  |  |  | I: General Board | 1970-1979 |  |
| 2 | 2 |  |  |  |  | A: Correspondence | 1970-1975 |  |
| 3 | 3 | 1 |  | 1 |  | General | 1970 |  |
| 4 | 3 | 1 |  | 2 |  | General | 1971 |  |
| 5 | 3 | 1 |  | 3 |  | General | 1972 |  |
| 6 | 3 | 1 |  | 4 |  | General | 1973 |  |
| 7 | 3 | 1 |  | 5 |  | General | 1974 |  |
| 8 | 3 | 1 |  | 6 |  | General | 1975 | January – June |
| 9 | 3 | 1 |  | 6 | a | General | 1975 | July – December |
| 10 | 3 | 1 |  | 7 |  | Personal | 1970-1971 |  |
| 11 | 3 | 1 |  | 8 |  | Personal | 1972-1973 |  |
| 12 | 3 | 1 |  | 9 |  | Personal | 1974-1975 |  |
| 13 | 2 |  |  |  |  | B: Meeting Minutes | 1970-1979 |  |
| 14 | 3 | 2 |  | 1 |  | Official Minutes | 1970-1971 | Bound |
| 15 | 3 | 2 |  | 2 |  | Official Minutes | 1972-1974 | Bound |
| 16 | 3 | 2 |  | 3 |  | Official Minutes | 1975-1978 | Bound |
| 17 | 3 | 2 | a | 1 |  | Personal Copies | 1970-1971 | Annotated, loose |
| 18 | 3 | 2 | a | 2 |  | Personal Copies | 1972-1973 | Annotated, loose |
| 19 | 3 | 2 | a | 3 |  | Personal Copies | 1974-1975 | Annotated, loose |
| 20 | 3 | 2 |  | 4 |  | Personal Copies | 1976-1977 | Annotated, loose |
| 21 | 3 | 2 | a | 5 |  | Personal Copies | 1978-1979 | Annotated, loose |

## Special Characters

Special characters can be either problems or solutions. Problems include characters, or words, which prevent SQL statements or VBA code from running. Solutions include characters which make the output more human readable.

Two of the problem special characters I had to cope with were the single quote and the ampersand. The single quote, or apostrophe, will sometimes cause the SQL or VBA to stop running, while the ampersand will cause an error in the style sheet when the EAD is converted to HTML for viewing in a browser. Apostrophes had to be escaped in order for the program to ignore them, while ampersands had to be replaced with something more html-friendly.

To escape an apostrophe, put a single quote in front of it. Essentially, it is necessary to replace single quotes with two single quotes, but not a double quote. Unfortunately, you cannot simply run an SQL statement to change the single quote to two single quotes:

```
UPDATE tablename SET Title = Replace([Title], " ' " ," ' ' ");
```

When the VBA code is compiled the first single quote is read as a comment indicator and everything after it is treated as a comment, leaving you with an incomplete SQL statement. The solution is to declare two variables, one for the single quote and one for the two single quotes and then assign the problem characters as the values:

```
Dim strChr1 as String
Dim strChr2 as String
strChr1 = " " " ' " " "
strChr2 = " " " ' ' " " "
```

All those double quotes identify the single quotes as strings. These variables are then used in the update SQL:

```
UPDATE collection table SET Title = Replace([Title], " & strChr1 & ",
    " & strChr2 & ");
```

Which runs as:

```
UPDATE collection table SET Title = Replace([Title], " ' " ," ' ' ");
```

without a compiling error.

Replacing the single quotes with two single quotes allows the program to run and drop the extra single quote, so that the output will have only the one single quote you started with.

Ampersands in the data strings do not cause SQL or VBA problems, but do prevent the guide from being displayed when the XML file is converted to HTML for delivery to the internet. Replacing the ampersand is similar to replacing the single quote. When used outside of a variable assignment statement the compiler sees the ampersand as a reserved character, resulting in a compiling error. To get around this problem, declare two variables and give them values:

```
Dim strChr3 as String
Dim strChr4 as String
strChr3 = " " " & " " "
strChr4 = " " " &amp; " " "
```

Then use the variables in the update statement:

```
UPDATE collection table SET Title = Replace([Title], " & strChr3 & ",
    " & strChr4 & ");
```

Both of these SQL updates also need to be run on the ScopeContent field.

There is also a word commonly used in EAD container lists that is reserved in MS Access, “level,” which needs to be dealt with, or the code will not run. This reserved word occurs as an attribute in the component level opening tags, e.g. <c03 level=”file”>. To keep from having the code choke on the reserved word enclose it in square brackets in the VBA code: <c03 \[level\]=”file”>. You can later remove the brackets in a text editor. I included an SQL update line to remove them before exporting the data:

```
UPDATE tblEAD SET Tags = Replace([Tags], '[level]', 'level');
```

There are a few other useful characters to be mentioned at this point. VBA uses double quotes to tell the processor what in an output string is text and what is a variable. Anything enclosed in double quotes is text and is be printed as is, while anything outside the double quotes is a variable and is to be replaced with the variable’s value. When you need double quotes in the text portion of your VBA code, you need to use the ASCII value in the Chr function, Chr(34). I also use the Chr function and ASCII values to format the output with the tags on different lines and indented, so that it is easily read in a text editor. This is done by putting Chr(13) in the code where I want a line break, and Chr(9) where a tab is needed.

## Design of Ead McTaggart

The database has very few components. There are only two permanent tables, though at times there may be several temporary tables, one form, one query, and one report. The real workhorse of Ead McTaggart is the VBA coding behind the form.

The form, which I call frmExtractEAD, has one text field, where the collection identifier is entered, a button to import the data, and a second button to export the EAD container list. The workflow is simple: enter the collection identifier in the text box and click the import button. The first thing I have the VBA code do is create a new table using the structure of one of the existing tables, tblPattern, and name it with the collection identifier. The imported data will be put into this new table and the new table will eventually be dropped when the EAD has been exported. You could import the data directly into tblPattern and just empty the tblPattern when the EAD has been exported, but I wanted the option of importing several container lists before exporting anything, so I generate a new table for each collection. The import function lets you navigate to the spreadsheet and drop the data into the appropriate table.

To export the EAD container list, make sure the collection identifier is in the text box and click the export button. This is where Ead McTaggart does his VBA magic. As the data are tagged, they are placed in the four fields in the tblEAD table. The first field, Tags, holds the opening component level tag and all other data except the scope/content note and the closing tags. The second field, Scope, holds the scope/content note. The third, Close, holds the closing tags. The fourth, an Index value. Note that Ead McTaggart uses two indexes. Both are consecutive numbers used to keep the data in the proper order. One is the Index value from the original data, the Table Index. This index is the one created in the Excel spreadsheet and maintains order while the data is imported into Ead McTaggart and when the record sets are pulled to process the list. The other index is a new one generated by the VBA code, the VBA Index, and is used to maintain order in tblEAD and the exported text file. For container lists without series the Table Index would work for both. However, using the Table Index for lists with series will not work. Since series and sub-series headers appear twice in the EAD guide, once as a series list showing the arrangement, and again in the container list, VBA Index is needed to give each instance of the repeated headers a unique index value in tblEAD.

The first thing the VBA code does is run the SQL updates to deal with the special characters. Then the VBA pulls a record set of the Index, Title, Date, and c0 fields for all the series and sub-series data in the collection table, sorted on the original Index field. These are the rows in the table where the Box value is null and the c0 value is “1” or “2.” For our sample in Table 1, this record set would contain the data from only rows 1, 2, and 13. It would look like Table 2.

**Table 2: First record set, used for the series list**

| Index | Title | Date | c0 |
| --- | --- | --- | --- |
| 1 | I: General Board | 1970-1979 | 1 |
| 2 | A: Correspondence | 1970-1975 | 2 |
| 13 | B: Meeting Minutes | 1970-1979 | 2 |

This record set is used to create a series/sub-series list in an <arrangement> tag, using <ref> tags with the Index value as the “target” attribute’s value to provide a link to the container list. At this point the VBA code generates the new, sequential, VBA Index number for each line added to tblEAD. After all records in this record set have been processed the record set is closed and a second record set opened. See flowchart in Figure 1.

The data in tblEAD at this point looks like Table 3.

**Table 3: The series list in tblEAD**

| Tags | Scope | Close | Index |
| --- | --- | --- | --- |
| <arrangement><head>SERIES LIST</head>   <list><defitem><label><ref linktype=”simple” target=”link1″ show=”new” actuate=”onrequest”>Series I: General Board, 1970-1979</ref></label>   <item><list> |  |  | 1 |
| <defitem><label><ref linktype=”simple” target=”link2″ show=”replace” actuate=”onrequest”>Sub-Series A: Correspondence, 1970-1975</ref></label><item> |  | <lb/></item></defitem> | 2 |
| <defitem><label><ref linktype=”simple” target=”link13″ show=”replace” actuate=”onrequest”>Sub-Series B: Meeting Minutes, 1970-1979</ref></label><item> |  | <lb/></item></defitem></list><lb/></item>   </defitem></list></arrangement>   <dsc>   <head>CONTAINER LIST</head> | 3 |

Depending on the style sheet used to convert the EAD file to HTML the series list in the user’s web browser the series list could look like this:

```
Series List

Series I: General Board, 1970-1979
     Sub-Series A: Correspondence, 1970-1975
     Sub-Series B: Meeting Minutes, 1970-1979
```

The EAD tagging for the series list looks like this:

```
<arrangement>
  <head>SERIES LIST</head>
  <list type="deflist">
    <defitem>
      <label><ref linktype="simple" target="link1" show="new" actuate="onrequest">Series I: General Board, 1970-1979</ref></label>
      <item>
        <list type="deflist">
          <defitem>
            <label><ref linktype="simple" target="link2" show="replace" actuate="onrequest">Sub-Series A: Correspondence, 1970-1975</ref></label>
            <item><lb/></item>
          </defitem>
          <defitem>
            <label><ref linktype="simple" target="link13" show="replace" actuate="onrequest">Sub-Series B: Meeting Minutes, 1970-1979</ref></label>
            <item><lb/></item>
          </defitem>
        </list>
      <lb/></item>
    </defitem>
  </list>
</arrangement>
```

[![Figure 1: Flowchart for series list tagging](https://journal.code4lib.org/media/issue8/miles/Flowchart1-500.jpg)](https://journal.code4lib.org/media/issue8/miles/Flowchart1.jpg)  
**Figure 1: Flowchart for series list tagging**

The second record set contains all the data from the collection table, sorted on the Table Index field. The VBA code then looks at the first record. If there is a scope content note, the note is wrapped in scope content tags, <scopecontent></scopecontent>. Next the c0 field is evaluated. If the value is null, Ead McTaggart assigns it a value of 1. Any record with a c0 value of 1 and the Box value Null gets tagged <c01 level=”series”>; any other c0 value with a Null Box value gets tagged as level=”sub-series”; any record where the Box value is not Null gets tagged with level=”file.” See flowchart in Figure 2. The VBA then moves to the next record and looks at the c0 value. If the c0 value of the new record is greater than the c0 value of the old record, no closing tag is entered. If the new value is less than or equal to the old value, closing tags are added for all component levels from the level equal to the old value, up to and including the level equal to the new value. See flowchart in Figure 3.

The data for the first record, (strTags, strScope, strClose, and intIndex), are then inserted into tblEAD and the second record is processed. This continues until the end of the record set is reached. When all records have been processed, the SQL update to remove the square brackets from the reserved word “level” is run and the data in tblEAD are exported by exporting the report, rptExtract, as a text document. The report, rptExtract has only one field, Tags, populated by using the query, qryTags, which concatenates tlbEAD.Tags & tblEAD.Scope & tblEAD.Close, sorted on Index. This report is automatically exported as a text file. The beginning of the container list EAD tagging looks like the following.

```
<dsc type="in-depth">
    <head>CONTAINER LIST</head>
        <c01 level="series">
            <did>
            <unittitle>Series I: General Board, 1970-1979</unittitle>
            </did>
                <c02 level="subseries">
                <did>
                <unittitle>Sub-Series A: Correspondence, 1970-1975</unittitle>
                </did>
                    <c03 level="file">
                        <did>
                            <container>1</container>
                            <container>1</container>
                            <unittitle>General</unittitle>
                            <unitdate normal="1970">1970</unitdate>
                        </did>
                    </c03>
                    <c03 level="file">
                        <did>
                            <container>1</container>
                            <container>2</container>
                            <unittitle>General</unittitle>
                            <unitdate normal="1971">1971</unitdate>
                        </did>
                    </c03>
```

After the report has been exported as a text file, the collection table is dropped from Ead McTaggart and tblEAD is emptied. When the text file is opened in a text editor, there are a number of blank rows inserted by Access when the report was formatted. These can be removed. The EAD tagged container list should now be ready for the front matter of your EAD finding aid.

[![Figure 2: Flowchart for container tagging](https://journal.code4lib.org/media/issue8/miles/Flowchart2-500.jpg)](https://journal.code4lib.org/media/issue8/miles/Flowchart2.jpg)  
**Figure 2: Flowchart for container tagging**

[![Figure 3: Flowchart for closing tags](https://journal.code4lib.org/media/issue8/miles/Flowchart3-500.jpg)](https://journal.code4lib.org/media/issue8/miles/Flowchart3.jpg)  
**Figure 2: Flowchart for container tagging**  
**Figure 3: Flowchart for closing tags**

## Code Examples

Here are a few examples of code I used in Ead McTaggart, with brief explanations. For clarity the line breaks and tabs which format the output, Chr(13) and Chr(9), have been left out. Also, some of the examples are just the beginning of longer if-then-else statements. The remainder of the statement is represented by “. . . \[additional code\].” The intent here is not to provide the complete code, but to illustrate how some of the issues with automating EAD tagging were addressed.

First the data need to be brought into Ead McTaggart. Clicking the “Import” button on the form runs code which creates the collection table and opens the standard Access dialog box for importing an Excel spreadsheet.

```
strSQL = "SELECT tblPattern.Index, tblPattern.Accession, tblPattern.Box, "
strSQL = strSQL & "tblPattern.BoxModifier, tblPattern.Folder, "
strSQL = strSQL & "tblPattern.FolderT, tblPattern.Title, "
strSQL = strSQL & "tblPattern.Date, tblPattern.ScopeContent, tblPattern.C0 "
strSQL = strSQL & "INTO " & strColl & " FROM tblPattern;"
DoCmd.RunSQL strSQL
DoCmd.RunCommand acCmdImportAttachExcel
```

The variable “strColl” is the collection identifier entered into the text box on the form. If there is no collection identifier in the text box, an if-then-else test captures the error and displays a message box requesting that a collection identifier be entered.

Once the data are in Ead McTaggart, in order to transform the data into EAD the VBA code needs to determine if the record being processed is a series, sub-series, or file. If the “Box” field contains a box number, i.e., is not null, then it is a file and the “level” attribute in the component level tag is set to “file.” If the “Box” field is null, it is a series if the value in “c0,” otherwise known as variable “intC0,” is 1 and a sub-series if it is greater than 1. VBA will not handle a null value so I use the Nz() function to replace any null values in the “Box” field with the word “Blank.”

```
If strBox Like "Blank" Then
     If intC0 = 1 Then
          strLevel = "series"
     Else:
          strLevel = "subseries"
     End If

. . . [additional code]
```

The component level tag in the VBA code looks like this.

```
"<c0" & intC0 & Chr(34) & "[level]=" & Chr(34) & strLevel & Chr(34) & ">"
```

For intC0 = 1, with no box number, this will be output as <c01 level=”series”>.

If there are series in the collection, the series titles are pulled out to be displayed at the top of the container list. To do this, the code pulls a record set of only lines with no box numbers and component level c01 or c02 from the table, and processes them as follows.

First the link is formed in a variable called strTags2. This defines all the link parameters in the <ref> tag, including the target, which is simply the Index number from the collection table, saved in the variable intRecIndex. It also concatenates the title and date, if there is one, into the label.

```
If strDate Like 0 Then
     strTags2 = "<defitem>"
     strTags2 = strTags2 & "<label><ref linktype="
     strTags2 = strTags2 & "simple" & Chr(34) & " target="
     strTags2 = strTags2 & "link: & intRecIndex & Chr(34) & " show="
     strTags2 = strTags2 & "new"  & Chr(34) &  " actuate="
     strTags2 = strTags2 & Chr(34) & "onrequest" & Chr(34) & ">"
     strTags2 = strTags2 & strLevel2 & " " & strTitle & "</ref></label>"
     strTags2 = strTags2 & "<item>"
     strTags2 = strTags2 & "<list>"
Else:
     strTags2 = strDblTab & strTab & "<defitem>"
     strTags2 = strTags2 & "<label><ref linktype="
     strTags2 = strTags2 & Chr(34) & "simple" & Chr(34) & " target="
     strTags2 = strTags2 & Chr(34) & "link" & intRecIndex & Chr(34) & " show="
     strTags2 = strTags2 & Chr(34) & "new" & Chr(34) & " actuate="
     strTags2 = strTags2 & Chr(34) & "onrequest" & Chr(34) & ">"
     strTags2 = strTags2 & strLevel2 & " " & strTitle & ", " & strDate & _
          "</ref></label>"
     strTags2 = strTags2 & "<item>"
     strTags2 = strTags2 & Chr"<list>"
End If
```

Once the link and label are formed they are wrapped in the appropriate opening and closing tags. If the current record is the beginning of the file, BOF, the arrangement and series list header tags are added. For subsequent records these tags are left off. At this point if the next record’s component level is c01, the closing tag </list> is added; otherwise this tag is left off. To do this the component level of the current record is saved as intCurrent and the cursor is moved to the next record in the record set. The component level for this record then becomes the value in the variable intC0.

```
If intIndex = 1 Then
     If intC0 = 1 Then
          strTags = "<arrangement>"
          strTags = strTags & "<head>SERIES LIST</head>"
          strTags = strTags & "<list type="
          strTags = strTags & Chr(34) & "deflist" & Chr(34)  & ">" & strTags2
          strClose = "<defitem><label></label><item></item></defitem></list>"
          strClose = strClose & "<lb/></item>"
          strClose = strClose & "</defitem>"
     Else:
          strTags = "<arrangement>"
          strTags = strTags & "<head>SERIES LIST</head>" & Chr(13)
          strTags = strTags & ""<list type="
          strTags = strTags & Chr(34) & "deflist" & Chr(34)  & ">" & strTags2
          strClose = ""
     End If

. . . [additional code]
```

When the last record in the record set is reached, that is the end of file, EOF, everything, including the arrangement tag, is closed and the description of subordinate components tag, <dsc>, is opened and given a “Container List” header.

```
ElseIf rst2.EOF = True Then
            If intC0 = 1 Then
                strTags = strTags2
                strClose = "<defitem><label></label><item></item></defitem></list>"
                strClose = strClose & "<lb/></item>"
                strClose = strClose & "</defitem>"
                strClose = strClose & "</list>"
                strClose = strClose & "</arrangement>"
                strClose = strClose & "<dsc type =" & Chr(34) & "in-depth" & Chr(34) & ">"
                strClose = strClose & "<head>CONTAINER LIST</head>"
            ElseIf intC0 = 2 Then
                strTags = strTags2
                strClose = "<lb/></item>"
                strClose = strClose & "</defitem>"
                strClose = strClose & "</list>"
                strClose = strClose & "<lb/></item>"
                strClose = strClose & "</defitem>"
                strClose = strClose & "</list>"
                strClose = strClose & "</arrangement>"
                strClose = strClose & "<dsc type =" & Chr(34) & "in-depth" & ">"
                strClose = strClose & "<head>CONTAINER LIST</head>"
            End If

. . . [additional code]
```

When all records in the record set have been dealt with, the record set is closed and a new record set, pulling all records, not just series and sub-series headings, is created. This record set will be used to generate the actual container list. As with the first record set, closing tags are determined by moving the cursor to the next record and looking at the component level. If the component level of the next record is lower, no closing tags are indicated. If the same, only the closing tag for that level is indicated. If higher, all tags up to that level are indicated.

```
If intCurrent = 1 Then
     'Variable intCurrent is the component level of the current record.
     If intC0 = 1 Then
          'Variable intC0 is the component level of the next record.
          strTags = strTags2
          'Variable  strTags2 contains the title and date for the current record.
          strClose = "</c01>"
     Else:
          strTags = strTags2
          strClose = ""
     End If
     ElseIf intCurrent = 2 Then
          If intC0 = 1 Then
               strTags = strTags2
               strClose = "</c02>"
               strClose = "</c01>"
          ElseIf intC0 = 2 Then
               strTags = strTags2
               strClose = "</c02>"
          Else:
               strTags = strTags2
               strClose = ""
          End If

. . . [additional code]
```

Another issue involves tagging the date field. Not all series, sub-series, and folders have dates, in which case I do not want the date tags included. When dates are included, I want them normalized as either single or inclusive. This was done using if-then-else statements. It should be noted at this point that I allow only years in the date field, either a single four-digit year or a range of two four-digit years separated by a hyphen. Any more specific dates or outlying years are noted in the scope content note.

```
If Mid(strDate, 5, 1) = "-" Then
     strTags2 = "<unittitle>" & strTitle & "</unittitle>"
     strTags2 = strTags2 & "<unitdate type =" & Chr(34)
     strTags2 = strTags2 & "inclusive" & Chr(34)
     strTags2 = strTags2 & " normal=" & Chr(34) & Left(strDate, 4)
     strTags2 = strTags2 & "/" & Right(strDate, 4) & Chr(34) & ">"
     strTags2 = strTags2 & strDate & "</unitdate></did>"
ElseIf strDate Like 0 Then
     strTags2 =  "<unittitle>" & strTitle & "</unittitle></did>"
Else:
     strTags2 = "<unittitle>" & strTitle & "</unittitle>"
     strTags2 = strTags2 & "<unitdate normal=" & Chr(34)
     strTags2 = strTags2 & strDate & Chr(34) & ">"
     strTags2 = strTags2 & strDate & "</unitdate></did>"
End If
```

When the end of file is reached, all open component level tags are closed and the </dsc> closing tag is added. The </archdesc>, and </ead> closing tags were already supplied by the style sheet in MarcEdit. However, if they were not they too can be added at this point. This is how strClose would look if the last record is at component level <c06>.

```
ElseIf intC0 = 6 Then
     strTags = strTags2
     strClose = "</c06>"
     strClose = strClose & "</c05>"
     strClose = strClose & "</c04>"
     strClose = strClose & "</c03>"
     strClose = strClose & "</c02>"
     strClose = strClose & "</c01>"
     strClose = strClose & "</dsc>"
End If
```

## Conclusion

Ead McTaggart quickly and accurately generates an EAD tagged container list from an easily formatted Excel spreadsheet. Series headings, and also sub-series headings if you like, are listed first and linked to the main body of the list so that a user can click on a heading and be taken to that section of the container list. Dates are normalized to facilitate searching by date, and the tags are all properly closed. The text file exported by Ead McTaggart is ready to be dropped into the EAD guide right before the </archdesc> tag.

While this can certainly be done using Archivists Toolkit or Archon, not everyone who wants to create EAD guides is using those tools. For those people, Ead McTaggart can do most, if not all, of the heavy lifting in creating EAD compliant container lists.

## Complete Code

The complete Ead McTaggart VBA code is available at [http://journal.code4lib.org/media/issue8/miles/EadMcTaggartVBA.html](https://journal.code4lib.org/media/issue8/miles/EadMcTaggartVBA.html).

## About the Author

Randall Miles is the Technical Services Archivist at the Kheel Labor-Management Documentation Center and Archives, in Catherwood Library, at Cornell University. He can be contacted at rm527 at cornell dot edu.
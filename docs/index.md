<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='600' />
# AuditEngine

AuditEngine is an election auditing platform which performs "Ballot Image Auditing". Relatively high-resolution ballot images are now captured by voting machine scanners that are now used in the polling places or central count operations. AuditEngine processes these ballot images to create an independent tabulation, and then it compares with the official cast-vote record files and can provide detailed reports which detail any disagreement in how any voters mark should be interpreted.

## Latest News

### AuditEngine Case Study Report

AuditEngine was used to audit three counties in Florida: Collier, Volusia, and St. Lucie Counties. Learn about audit engine and its unbelievable accuracy, which is better
than the official voting systems by 93% on contests where we have located a disagreement (excluding corrupted ballot images). Also exposed in this report is the fact that the Election Systems & Software (ES&S) Election Management System (EMS) uses two internal tabulations that do not agree! This seems like it could be a security risk.
(Read the report and watch four videos on this page.)

**(START HERE IF YOU ARE NEW TO AUDIT ENGINE)**

   * [(M1970) 2021-05-29 AuditEngine Case Study Report & Videos](https://copswiki.org/Common/M1970)


**JUMP DIRECTLY TO THE FIRST VIDEO regarding the Case Study, which is a great introduction:**

- Part 1: Introduction and Theory of Operation: https://youtu.be/dDEFGsqdCsg

<iframe width="560" height="315" src="https://www.youtube.com/embed/dDEFGsqdCsg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><BR>

### AuditEngine Frequently Asked Questions
We have started to compile the questions that tend to asked on this page: [Audit Engine FAQs](https://copswiki.org/Common/AuditEngineFAQs)

### AuditEngine Press and Announcements

   * [Press Release AuditEngine Available for 2020 General Election -- 2020-10-04](https://copswiki.org/w/pub/Common/AuditEngine/Press Release AuditEngine Available for 2020 General Election -- 2020-10-02.pdf)<br>
<iframe width="560" height="315" src="https://www.youtube.com/embed/54z2t_wANzA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><BR>

   * Jennifer Cohn interview on AuditEngine:
<iframe width="560" height="315" src="https://www.youtube.com/embed/oM0elo5Ad2U" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><BR>

   * AuditEngine was first announced and demonstrated at the National Election Integrity Conference in Berkeley, CA on Oct 6, 2019, which was sponsored by the [[https://nvrtf.org/][National Voter Rights Task Force]]. Read press release here: [Press Release](https://copswiki.org/Common/M1928).

<iframe width="560" height="315" src="https://www.youtube.com/embed/RHaDzomo0kI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><BR>

## Simplified Block Diagram
The following block diagram should help your understanding of how AuditEngine works. 

The upper block shows the operation of the voting system, which scans hand-marked paper ballots and creates ballot images, which are then analyzed to extract the vote and create cast-vote records. Those can be totalled up to create the election results.

The lower block shows how AuditEngine accepts ballot images, and then performs style analysis, to provide a map of the contests and options to where the bubbles are. The ballots are then fully processed to extract the vote and then these cast vote records are compared with the official records. Discrepancies can then be reviewed using our Adjudicator App if the election is close enough to require that.

<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngine High level flow chart.png" alt="AuditEngine High level flow chart.png" width='800'/>

## How you can help
We need help to apply AuditEngine so as to help improve our confidence in our elections. Can you help? Please complete the form at this link: [SignUp](https://copswiki.org/Common/SignUp)

### Public Advocate
- **Actions**    
  Contact public officials and insist that election officials should PRESERVE ballot images, and make them available for public review on a routine basis.  
- **Background**    
  None, but may need attorneys to assist when officials claim that ballot images and cast-vote record files are not public records or cannot be made available for review.

### Requestor 
- **Actions**    
Contact election officials and request that they post ballot image archives and cast-vote record files (See details below for format and various options)
- **Background**    
Limited technical expertise, but requires knowledge of public records requests and the desired file types, flash drives, and zip files. Assistance from attorneys may be required if officials resist.
    
### Uploader
- **Actions**    
After receiving ballot image archives and cast-vote records, create an "Election" and upload these files to Audit Engine
- **Background**    
Limited technical expertise, no legal background required.

### Observer
- **Actions**    
Stakeholders and those with specific expertise can participate on the observers panel.
- **Background**    
No special requirements.

### Auditor
- **Actions**    
Once the files have been uploaded, any additional files may need to be created, and settings established for successful style analysis and vote extraction.
- **Background**  
Moderate technical expertise, knowledge of ballot formats and program settings.
### Mapper
- **Actions**    
One phase of the audit process involves a manual process we call "Target Mapping" and it uses a browser-based tool called the TargetMapper. Once the styles are understood, there is an opportunity to reduce the number of styles if some are equivalent. Mapping each style means locating the "targets", i.e. the ovals that are marked by voters, and pairing them up with the contest and option of that target.
- **Background**  
Detailed oriented and able to use a mouse.
### Reviewer
- **Actions**    
As audit files are created, members of the public should review redline proofs to insure that the style analysis was completed correctly, and review the results of the comparison
- **Background**    
Must be detail-oriented.
### Adjudicator
- **Actions**    
If there are discrepancies, an adjudication team will review them and enter voter intent or indicated votes as appropriate for the state of interst.
- **Background**     
Common sense and knowledge of voter intent acceptance standards for the state.
### Subscriber
- **Actions**    
Any member of the public can watch public audits as subscribers, and review the data files produced, redline proofs, discrepancies, adjudications, and results.
- **Background**  
None required.

## How It Works
### Getting the data together
First, the data must be assembled for use by AuditEngine. Most of this is already produced and available by Election Officials.

- **Ballot Image Creation:** 
    - Modern voting equipment used in most districts in the U.S. create ballot images as they process the ballots. 
    - It is essential that this equipment be set so the ballot images are not deleted after they are used to extract the vote. 
    - These images are then transferred to the Election Management System (EMS)
    - The EMS can export the ballot images for use by AuditEngine. These should be placed into ZIP archives with about 30,000 to 50,000 ballots per archive.

- **Election Information File (EIF):** 
    - Our system requires additional information regarding the information actually printed on the ballots.
    - The EIF lists
        - all contest names, as used in the CVR, as printed on hand-marked paper ballots, and as printed on BMD ballots
        - the options in each contests, the full-text descriptions of yes/no contests.
        - the number of write-ins, and the vote-for number. 
    - This information is available from sample ballots and can be assembled prior to the election.
    - This is a spreadsheet file in .xlsx or .csv format. 
    - The exact format of this file is provided below.
    - In rare case, we also need the Ballot Options File (BOF) which lists the actual text of each option if they differ from the official CVR text.
        
- **Cast Vote Record (CVR):**
    - Officials can produce cast-vote-record files (CVR) which lists the results of their interpretation of the ballots. 
    - AuditEngine currently supports the ES&S format and the Dominion format.
    - If any ballots are suppressed for privacy reasons, the total number of ballots suppressed and their vote totals should be provided.
    - AuditEngine can also be run without the CVR but some additional information is required:
       - **Results Summary:** The official (or unofficial) results that _should_ match the totals from the cast-vote-records file, but may not if any ballots have been suppressed for privacy concerns.  For some systems, we can scrape the data from the official election website report.
       - **Style to Contests File:** This is a spreadsheet which can be generated later in the process that lists the contests included in each style. This can be generated by inspecting the ballots or it can be provided by elections officials.

### EXPORTING: Step-by-step instructions
To view googledoc for comments, please [click here](https://docs.google.com/document/d/1qeuAtmNBhLL2KLUUtJPgtq5rzyjq1QTzBuaO4HlJwDY/edit?usp=sharing")<br>
<iframe src="https://docs.google.com/document/d/e/2PACX-1vSkX8tdGY-h-ShL601a7l7Q6s4p2OKlqyjXBatKI7nOMW1Ku3Pbj53SG0B76mKdvscHHuuBIw3HPSkx/pub?embedded=true" width=800 height=700></iframe>

### UPLOADING: Step-by-step instructions
To view googledoc for comments, [click here](https://docs.google.com/document/d/1GyB5-NH3-44pJN4GUH7hjU3MrK36ObearYQjZGW-fJU/edit?usp=sharing)<br>
<iframe src="https://docs.google.com/document/d/e/2PACX-1vTNtC2H7kQ5BFai90vLGFCPXiVt-0wG2DcgqyniALuvXoH1qMKtkhuausdzboB9c--zH9HSzH5rJ79m/pub?embedded=true" width=800 height=700></iframe>

### Creating an Account
- **Registration:** You must register on the <https://AuditEngine.org> website to create a user identity
- **Payment Method:** You must create a payment method that we can use to access funds for the cost of the runs. We accept credit cards or we can invoice you after credit approval.

### Creating a Job
- **Name the Job:** Create a job with a name for future reference. You must include the district, election date, and election type to distinguish it from other jobs you (and others) might submit.
- **Image Files:**
    - *Direct Uploading:* We recommend that you upload your archives directly to our site using our browser interface, which has no limit to the size of each file uploaded.
    - *Posting Service Uploading:* In the future, we plan to provide transfers from your file posting service, such as Dropbox, Sharefile, Drive, etc. 
        
- **Cast Vote Records File(s) (CVR Files):** 
    - A cast-vote record file (CVR) provides the result of the election as determined by the voting system. 
        - A CVR can be broken down to the individual ballot (which is preferred) or it can provide results based on higher level groups, such as precincts or batches.
        - AuditEngine does not require the CVR file, and it does not rely on the CVR file in its own processing of the ballot images.
        - However, AuditEngine will make use of the CVR to a limited extent, if it is available, as follows:
            - To redunce the processing required in the initial pre-scan of the ballots. 
               - If no CVR is provided, all ballot images are prescanned to extract style information from barcodes on hand-marked paper ballots, i.e. which contests are included on each ballot style.
               - If the CVR is provided with style for each ballot, then a full prescan of the ballots is not required. Use of this style information, if incorrect, will be discovered in the style templating and mapping process. Reliance on the style from the CVR does not change the vote extraction process (which is performed without reference to the CVR).
            - To locate discrepancies between the voting-system tabulation and the audit system.
               - Only after AuditEngine has fully extracted the vote, the voting system CVR is compared with that result to provide the discrepancy report. 

    - AuditEngine supports voting-system cast-vote-record (CVR) files in vendor-defined formats and in the new "Common Data Format" as defined by NIST or variants.
        - ES&S Legacy Format: 
            - This is a table-oriented format which results in a reasonable size and number of files.
            - Use CSV (character separated data) or .xlsx format. 
            - Please limit the size of any single .xlsx file to no more than 99,999 records (100,000) lines by splitting into several files if needed. 
            - Please compress each file using ZIP.
        - Dominion Legacy Format:
            - This is a CSV "tidy" format which has only a few columns and many records. 
            - Each record contains fields that identify the data value, and one data value.
            - Please compress each file using ZIP.
            - This format has been generally used for batch or precinct level reports and not broken down by ballot.
        - Dominion JSON CVR format:
            - This format is similar to the NIST standard but is not an exact implementation.
            - It results in typically one JSON file per batch on a given tabulator.
            - For example, in the 2020 Primary in San Francisco, more than 13,000 files resulted.
            - All the files should be combined into a single ZIP file.
        - Other formats:
            - We can add other formats as needed.
              
- **Election Information File (EIF):** AuditEngine generally also requires an Election Information File which provides the contest names, options, and the full-text descriptions found in each language as an .xlsx or CSV file. The format of this file is found below. 
- **Ballot Options File (BOF):** This is actually logically part of the EIF dataset but is only rarely needed when the text for ballot options differs from the official option. This might occur in gubinatorial or presidential contests when the option includes two names, one for governor and leiutenant governor, for example. But it may not be required even if that is the case so you may want to try it first without.
        
- **Results Summary:** The system requires the official or unofficial results eiher in CSV, .xlsx format, or as a link to a web-page report, if we support that format. Even if the full CVR is provided, AuditEngine will compare with the final totals in the contests.
       
- **Adjudications File:** After you have completed your first run, you may want to also submit and adjudications files, which essentially amends the AuditEngine result to reflect the review of voter intent from the ballot images on any ballots that are a concern.
     
- **Job Controls:** You can limit the review to given ranges of ballot image numbers or only to certain precincts.

### Election Information File
This file deals with the inconsistencies between various presentations of the same contests and options that are on the ballot. This file is not a standard file from election systems today, but it can be constructed from other data sources, such as the sample ballot, CVR File, Summary report, etc. NOTE: Since we are now using TargetMapper to perform computer-aided (rather than fully automated) mapping, many of the fields mentioned below are not required, and are noted in the comments as TM-NR, as not required when using TargetMapper.

Some elements of this data file are specifically to allow AuditEngine to process legacy CVR files.
- In legacy ES&S CVR files:
    - the header may include non-unique names, and are processed based only on their order.
    - in this case, the original_cvr_header is provided as a starting point, and then the official_contest_name is derived typically by an analyst.

| **Column Name**                | **Data<br>type**  |  **Description**  |
|--------------------------------|-------------------|-------------------|
|official_contest_name           |   str            |(Required) A brief yet correct and distinctive contest name. These must be an exact replacement for the Cast Vote Record file header. These can contain spaces and punctuation, but it is smart to limit it. Avoid newlines. | 
|original_cvr_header             |   str            |(Optional column) This column provides the exact header from the CVR files for reference. This column can be created by copying the header line and pasting it into the spreadsheet using "paste-special" and "transpose". This column will also include the first identifying columns, such as "Cast Vote Record", "Precinct", and "Ballot Style". If the initial columns differ from those, they should be set in the JOB settings file using the 'initial_cvr_cols' directive. (This column is not needed for non-ES&S systems.)  | 
|contest_id                      |   int            |(Optional) The numeric id of this contest  |
|ballot_styles                   |   csv            |(Optional, TM-NR) comma separated values of ballot style_num values, for those styles where this contest is found. Leave blank if the contest is on all styles. Alternatively, the manual_styles_to_contests_table format can be used to map contests to styles.  |
|sheet                           |   int            |(Optional) The sheet number where this contest is found, if a multi-sheet ballot is used. Here, sheet numbers start at 1.  |
|ballot_contest_name             |   str            |(Required, TM-NR) The contest title as actually found on the ballot including all embellishments that are actually written, such as "(Vote for 1)". If it is exactly the same as the Official_Contest_Name, then it need not be listed. In the case of bilingual ballots, it may work best to include only the English, but it must be the first portion of the text.  |
|contest_name_num                |   int            |(Optional, TM-NR) The number of lines of text used by the contest name.  If not provided, the lines are counted in the 'ballot_contest_name' field. Used in cases when the ballot_contest_name has more lines than are used for comparison, such as in multi-lingual ballots. It is recommended that this fields be used. This is a critical value.  |
|bmd_contest_name                |   str            |(Optional) If BMDs are used, the this column should provide the exact string used in by the BMD for this contest in the vote summary  |
|vote_for                        |   int            |(Required) The maximum number of votes in this contest. 1 is assumed if not provided.  |
|writein_num                     |   int            |(Required, TM-NR) The number of "Write-in:" options provided on the ballot for this contest. If left blank, 1 is assumed. 0 means no write-in lines are provided.  |
|official_options                |   str            |(Required) List of official option names, separated by commas. The order of the options provided here is not required to match the order on the ballot. If these option names differ from what is actually printed on the ballot, then use a BOF file to define the exact text for each option (See details below).    |
|description                     |   str            |(TM-NR) This is the exact description of referendum or question-type (Yes/No) contests as found on the ballot. These can be entered with embedded newlines to reflect how it appears on the ballot.  |
|descr_num                       |   str            |(optional, TM-NR) The number of lines of text used by the description. If not provided, the lines are counted in the 'description' field. Used in cases when the description has more lines than are used for comparison, such as in multi-lingual ballots. The use of this field has been deprecated because it is better to use the 'auto_detect_descr_lines_reserve' directive, which will simply include all lines except for those reserved at the end in the OCR lines used in the comparison.  |
|qualified_writeins              |   str            |(Optional) List of official option names of qualified writeins. These are provided to BMDs to allow voters to vote for the official writeins and avoid random writeins that are not qualified.  |

Additional columns can be used as desired by the analyst and are ignored if not supported.
Here is a blank spreadsheet with the columns initialized: [Blank EIF Google Spreadsheet](https://docs.google.com/spreadsheets/d/1RvGoQMPXTgBvY4zwOnF9anDiw8OSScFOArqCgOPLQ8k/edit?usp=sharing) If a detailed CVR is provided, then most of the above fields are automatically generated when the starter EIF is generated.

#### Additional Notes about the EIF
FOR FULLY AUTOMATED MAPPING, the following applies. This method is now no longer being used and computer-aided mapping is used instead. However, these statements still do apply when processing BMD ballots as the exact strings of the contest names and option names must be provided.<p>

The data in the EIF is extremely critical to get exactly right so that Audit Engine will be able to successfully map the contests to the OCR'd strings from the ballot. If the information is not exactly correctly, it can be found out and corrected during the mapping process, but it will take a lot more time and effort to do it then. Here are some areas which should be carefully checked.

1. *official_contest_name* is the internal name for that contest. It is best if these are short to conserve space and yet easy for humans to distinguish from each other.<br><br>
2. *ballot_contest_name* and *contest_name_num* are critical to get correct. This is because Audit Engine uses these values to match the contest and then look for the options in "fully_joined" layout, i.e. where the contest title is in the same box on the ballot as the options. The actual ballot image should be reviewed to determine the number of lines used by the contest header. When counting lines, do not count blank lines. <br><br>In the case of yes/no contests that have a description, it may be somewhat arbitrary where to split the contest name from the rest of the description. For example, if there is a title and a subtitle, it may be best to include both of these in the ballot_contest_name, particularly if the contest names are otherwise somewhat similar. "Constitutional Amendment I" does not differ much from "Constitutional Amendement II" and thus adding the subtitle can be a smart move. Another way to deal with this is to set 'question_contests_have_no_contest_name' to TRUE and then just put all the text in the descr.<br><br>
3. *descr* is the other component of the issue described above, and must not include additional lines that are also in the *ballot_contest_name*. *descr_num* has been deprecated, and instead you should use 'auto_detect_descr_lines_reserve' to set how many lines should be set aside at the bottom of the region for Yes and No options, usually 2. If you include the 'auto_detect_descr_lines_reserve' directive, then all the lines in the ocr'd text are matched with the descr except for those reserved at the end for the Yes/No options. It is not necessary to include all the lines of the description in the descr field, just enough to thoroughly distringuish it from all other descr fields, and the fuzzy matching algorithm attempts to match left-justified.

### Ballot Options File (BOF)
A BOF is required only if the options as printed on the ballot differ substantially from the official_options as provided in the EIF, and now only for BMD ballots. This file includes (at least) three columns, as follows. This file need only provide records for those options that need to be substituted.

|  **Column Name**                 |  **Data<br>type**  |  **Description**  |
|----------------------------------|--------------------|-------------------|
|official_contest_name             |   Str              |The same contest name as provided in the CVR as official_contest_name.  |
|official_option                   |   Str              |A ballot option as listed in official_options in the EIF  |
|ballot_option                     |   Str              |(These now only needed for BMD options. The option as listed on the ballot, exactly as provided, including newlines. The ballot options are sometimes very different, particularly if they list a candidate pair, such as for Governor and Lieutenant Governor, or President and Vice President, listed on separate lines. If the ballot has separate lines, then they must be entered as separate lines in the BOF spreadsheet. This can usually be done by using CONTROL-ENTER. Please note: Audit Engine cannot support options with differing number of option lines for the same contest. If the line on the ballot has the party designation, it is good practice to include that in the BOF to enhance success of matching options. For example "Joe Blow (DEM)" can be entered as the ballot option while "Joe Blow" might be the official option.  |
|ballot_option_num                 |   int              |(optional TM-NR) The number of lines of text used by the ballot_option. If not provided, the lines are counted in the 'ballot_option' field. Used in cases when the ballot_option has more lines than are used for comparison, such as in multi-lingual ballots.  For a single contest, all ballot options must have the same number of lines. |

Additional columns can be used as desired by the analyst and are ignored if not supported.t
Here is a blank spreadsheet with the columns initialized: [Blank BOF Google Spreadsheet](https://docs.google.com/spreadsheets/d/1HxTlx_i11zGrrYUViJOPZZMIg-iYh4_Y5BjjKY4SIzk/edit?usp=sharing)


### Processing an Election on AuditEngine
* Register with the site and create a user name.
* Once your job has been defined, the job can be launched. There are several phases:
* Phase 1 -- Uploading files:
   * The first phase of the process includes uploading ballot images, CVR files and EIF files.
   * The system will inspect the job specification and the input files for format and consistency.
   * Precheck: Consistency checks include comparing the number of ballot images with the number of cast-vote records in the CVR files and that the contests as provided in the EIF can be found in the CVR.
* Phase 2 -- Generate Style Templates:
   * After the files have been uploaded as provided in Phase 1, Style Templates can be generated.
   * AuditEngine will visually inspect the ballots and learn the format of ballots that have the same style. Each style has either all or a subset of the contests in the election, and in each style, the location of targets for a given contest option will be in the same location.
* Phase 3 -- Target Mapping
   * We now use the helper browser app called TargetMapper. The user will select each style and using a mouse, locate the target for that option.
   * Similar styles can be copied and pasted, and the system will drop any contests not in the new style, and then the user can add any new contests.
   * Multiple users will be able to help perform the mapping by splitting up the range of styles.
   * At the end, the result is exported from TargetMapper. 
   * The map is imported into AuditEngine, and it performs an additional consistency check.
   * Redline proofs are created in a styles report. These proofs must be inspected manually to insure accuracy.
* Phase 4 -- Vote Extraction and reporting:
   * After generation of Style Templates and approval of the contest mapping, you can launch the extraction phase.
   * Audit Engine will detect marks on the ballots and create an comprehensive database containing information for each style and each ballot.
   * During this phase, the work will be split up among many separate virtual machines in the cloud-based computing services, which can provision 10s of thousands of virtual machines that run in parallel in massive data centers. This will allow us to finish your job in minutes instead of many hours or days if run on a single machine.
* Phase 5 -- Comparison and Discrepancy Report
   * If a detailed CVR is available detailed to the individual ballot, then the compare-cvr (CMPCVR) process is started to compare all the records and generate a discrepancy report.
* Phase 6 -- Reporting and Adjudication:
   * After the processing is complete, Audit Engine provides a comprehensive report, and allows interactive inspection of individual ballots and contest to resolve voter-intent in difficult cases.
   * The Adjudications File can then be prepared for future runs.  

### Additional Notes 
- We are working to establish a full-ballot image securty standard which is based on the concept of "Trusted Systems" to ensure that we can trust that the ballot images are an accurate representation of the paper ballots.
- In addition, 
    - **Digital Poll Tape Report:** AuditEngine can perform a digital poll tape audit, which compares the "poll tape" from each of the polling place machines (in digital form) with the official report of election day and early voting use of those machines. 
    - The "Poll List" which provides the totals of all the voters who voted so we can check that all the ballots are represented in the ballot images set. This is an area that needs further standardization.
    - **Hash Codes File:** This file provides the SHA256 or similar hash for each file uploaded to the posting service. When the files are uploaded to our cloud-based provider (AWS) they use a slightly different method and it is important to generate the hash values the same way. They generate the hash value by taking the MD5 hash value of smaller chunks, of say 8MB each, and then hashing that list.
   - **Computer Code Verification File:** This is at present a proposal to make sure we can trust the scanner hardware. See [[M1936][Securing Digital Ballot Images to Enable Auditing]]

Copyright (c) Citizens Oversight, Inc.
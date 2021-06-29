<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='600' />
# AuditEngine

AuditEngine is an election auditing platform which performs "Ballot Image Auditing". Relatively high-resolution ballot images are now captured by voting machine scanners that are now used in the polling places or central count operations. AuditEngine processes these ballot images to create an independent tabulation, and then it compares with the official cast-vote record files and can provide detailed reports which detail any disagreement in how any voters mark should be interpreted.

## Primary Links
- [Active AuditEngine site: (click to Enter)](https://engine.auditengine.org)
- [AuditEngineFAQs: Frequently Asked Questions](https://copswiki.org/Common/AuditEngineFAQs)

## Latest News

### AuditEngine Case Study Report

AuditEngine was used to audit three counties in Florida: Collier, Volusia, and St. Lucie Counties. Learn about audit engine and its unbelievable accuracy, which is better
than the official voting systems by 93% on contests where we have located a disagreement (excluding corrupted ballot images). Also exposed in this report is the fact that the Election Systems & Software (ES&S) Election Management System (EMS) uses two internal tabulations that do not agree! This seems like it could be a security risk.
(Read the report and watch four videos on this page.)

**(START HERE IF YOU ARE NEW TO AUDIT ENGINE)**

- [(M1970) 2021-05-29 AuditEngine Case Study Report & Videos](https://copswiki.org/Common/M1970)


**JUMP DIRECTLY TO THE FIRST VIDEO regarding the Case Study, which is a great introduction:**

- Part 1: Introduction and Theory of Operation: https://youtu.be/dDEFGsqdCsg

<iframe width="560" height="315" src="https://www.youtube.com/embed/dDEFGsqdCsg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><BR>

### AuditEngine Frequently Asked Questions
We have started to compile the questions that tend to asked on this page: [Audit Engine FAQs](https://copswiki.org/Common/AuditEngineFAQs)

### AuditEngine Press and Announcements

- [Press Release AuditEngine Available for 2020 General Election -- 2020-10-04](https://copswiki.org/w/pub/Common/AuditEngine/Press Release AuditEngine Available for 2020 General Election -- 2020-10-02.pdf)<br>
<iframe width="560" height="315" src="https://www.youtube.com/embed/54z2t_wANzA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><BR>

- Jennifer Cohn interview on AuditEngine:
<iframe width="560" height="315" src="https://www.youtube.com/embed/oM0elo5Ad2U" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><BR>

- AuditEngine was first announced and demonstrated at the National Election Integrity Conference in Berkeley, CA on Oct 6, 2019, which was sponsored by the [[https://nvrtf.org/][National Voter Rights Task Force]]. Read press release here: [Press Release](https://copswiki.org/Common/M1928).

<iframe width="560" height="315" src="https://www.youtube.com/embed/RHaDzomo0kI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><BR>

## Simplified Block Diagram
The following block diagram should help your understanding of how AuditEngine works. 

The upper block shows the operation of the voting system, which scans hand-marked paper ballots and creates ballot images, which are then analyzed to extract the vote and create cast-vote records. Those can be totalled up to create the election results.

The lower block shows how AuditEngine accepts ballot images, and then performs style analysis, to provide a map of the contests and options to where the bubbles are. The ballots are then fully processed to extract the vote and then these cast vote records are compared with the official records. Discrepancies can then be reviewed using our Adjudicator App if the election is close enough to require that.

<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngine High level flow chart.png" alt="AuditEngine High level flow chart.png" width='800'/>

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

### Guides:
- [Exporting Guide](exporting_guide.md) -- Guide for election staff to export ballot images and cast-vote records from ES&S or Dominion systems.
- [Uploading Guide](uploading_guide.md) -- Guide for election staff or affiliates to upload ballot images and cast-vote records to AuditEngine.

### Creating an Account
- **Registration:** You must register on the <https://AuditEngine.org> website to create a user identity


### Creating a Job
- **Name the Job:** Create a job with a name for future reference. You must include the district, election date, and election type to distinguish it from other jobs you (and others) might submit.
- **Image Files:**
    - **Direct Uploading:** We recommend that you upload your archives directly to our site using our browser interface, which has no limit to the size of each file uploaded.
    - **Send Files on USB drive or thumbdrive:** It is common that files are very large, and then it may be more convenient to send us the data. However, please use direct uploading if possible.

        
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


### Processing an Election on AuditEngine
- Register with the site and create a user name.
- Define a Job. You will need to ask an administrator to define a new job and provide access to your account.
   - Once your job has been defined, the job can be launched. There are several phases:
- Phase 1 -- Uploading files:
    - The first phase of the process includes uploading ballot images, CVR files and EIF files.
    - The system will inspect the job specification and the input files for format and consistency.
    - Precheck: Consistency checks include comparing the number of ballot images with the number of cast-vote records in the CVR files and that the contests as provided in the EIF can be found in the CVR.
- Phase 2 -- Generate Style Templates:
    - After the files have been uploaded as provided in Phase 1, Style Templates can be generated.
    - AuditEngine will visually inspect the ballots and learn the format of ballots that have the same style. Each style has either all or a subset of the contests in the election, and in each style, the location of targets for a given contest option will be in the same location.
- Phase 3 -- Target Mapping
    - We now use the helper browser app called TargetMapper. The user will select each style and using a mouse, locate the target for that option.
    - Similar styles can be copied and pasted, and the system will drop any contests not in the new style, and then the user can add any new contests.
    - Multiple users will be able to help perform the mapping by splitting up the range of styles.
    - At the end, the result is exported from TargetMapper. 
    - The map is imported into AuditEngine, and it performs an additional consistency check.
    - Redline proofs are created in a styles report. These proofs must be inspected manually to insure accuracy.
- Phase 4 -- Vote Extraction and reporting:
    - After generation of Style Templates and approval of the contest mapping, you can launch the extraction phase.
    - Audit Engine will detect marks on the ballots and create an comprehensive database containing information for each style and each ballot.
    - During this phase, the work will be split up among many separate virtual machines in the cloud-based computing services, which can provision 10s of thousands of virtual machines that run in parallel in massive data centers. This will allow us to finish your job in minutes instead of many hours or days if run on a single machine.
- Phase 5 -- Comparison and Discrepancy Report
    - If a detailed CVR is available detailed to the individual ballot, then the compare-cvr (CMPCVR) process is started to compare all the records and generate a discrepancy report.
- Phase 6 -- Reporting and Adjudication:
    - After the processing is complete, Audit Engine provides a comprehensive report, and allows interactive inspection of individual ballots and contest to resolve voter-intent in difficult cases.
    - The Adjudications File can then be prepared for future runs.  

### Additional Notes 
- We are working to establish a full-ballot image securty standard which is based on the concept of "Trusted Systems" to ensure that we can trust that the ballot images are an accurate representation of the paper ballots.
- In addition, 
    - **Digital Poll Tape Report:** AuditEngine can perform a digital poll tape audit, which compares the "poll tape" from each of the polling place machines (in digital form) with the official report of election day and early voting use of those machines. 
    - The "Poll List" which provides the totals of all the voters who voted so we can check that all the ballots are represented in the ballot images set. This is an area that needs further standardization.
    - **Hash Codes File:** This file provides the SHA256 or similar hash for each file uploaded to the posting service. When the files are uploaded to our cloud-based provider (AWS) they use a slightly different method and it is important to generate the hash values the same way. They generate the hash value by taking the MD5 hash value of smaller chunks, of say 8MB each, and then hashing that list.
   - **Computer Code Verification File:** This is at present a proposal to make sure we can trust the scanner hardware. See [[M1936][Securing Digital Ballot Images to Enable Auditing]]

Copyright (c) Citizens Oversight, Inc.

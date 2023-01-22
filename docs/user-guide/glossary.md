<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />

# Glossary

**Adjudicated** -- For some voting systems, such as Dominion, the CVR may provide not only the original evaluation of the ballot sheet, but also a 'modified' record which includes all contests on the ballot. The 'modified' record may modify zero or many contests after human-eye review by election staff. If the modified record does not show a change in a given contest, it is not possible to know from that record if the contest was inspected and confirmed or not.

**Adjudication --** This is the process of human review of ballots or ballot images and providing an interpretation of the vote on that ballot. Dominion Voting Systems has an adjudication module that facilitate adjudication by election staff. AuditEngine also has an AdjudicatorApp that can help fine tune the results obtained by AuditEngine.

**Adjudicator App** -- This component of AuditEngine is a browser-based app that provides a user interface to check flagged comparison results. It presents the evaluation by AuditEngine and the evaluation by the voting system and that portion of the ballot showing the users marks or BMD card. The AdjudicatorApp can also be used without any voting system results to fine-tune the results by AuditEngine by reviewing any records that have been flagged for further review.

**Archive / Zip Archive** -- A single file which can contain many smaller files and also may compress them. This makes it easier to handle a lot of separate small files and also usually saves a lot of space on the disk because files consume at least one block, and the last block in a file is partially empty. Archives pack all the files together into one file without any empty space. 

Most importantly for this application is that archives make it easier to handle many thousands of individual files by grouping them together into a small number of archives. We require that you use the open source standardized "ZIP" archives, because the files can be individually extracted from the archive without extracting them all. The free application "7-zip" from [7-zip.org](https://7-zip.org) is a very good tool, but <u>use the conventional zip format and not the proprietary 7z format</u>. We recommend that up to about 50,000 ballot images are placed into the same archive, and they should be between about 5GB and 10GB in size for easy handling.

**Audit Job** -- For a given election in a given district, there can be one or more Audit Jobs. An audit job tracks the specific *stages* completed in the processing *pipeline.* Each Audit Job for a given election will have a unique *job_name*. 

**Audit Phase** -- A logical major step in the pipeline, which consists of a number of *stages*, and and where those stages can be grouped into a logical concept. To conduct Ballot Image Audits (BIAs), Audit Engine uses at least 4 phases, and sometimes 5 phases. A given workflow may actually use more than one audit for a given election, starting with an audit of the Logic and Accuracy Test (LAT) data and using that to set up AuditEngine to be ready for the live election data.

**Ballot --** Generally a presentation of contests and options for each contest that can be selected by a voter, and the recording of those selections. The word "ballot" originally meant "little ball" and these were placed into a box to represent the votes of each person. In practice, a complete ballot may be a number of sheets, each with a front and back side, also called pages. However, in many instances, the term "ballot" may also be used to refer to a single sheet. Thus, "Ballot Images" should technically be "Ballot Sheet Images" because when there are multiple sheets, they are each only of one sheet of the combined ballot. 

**ballot_id** -- This is a unique designator used by the voting system to refer to a specific ballot. This can be a number or a compound value with parts. ES&S uses integers from 1 on up. Dominion uses a three-part number separated with underscores, like 02438_00043_293456, where the first part is the tabulator number, the second part is the batch processed by that tabulator (starts at 1) and then the final number is the RecordId, which sometimes starts at 1 and increments and other times is pseudo-random.

**Ballot Image --** Election systems today create digital pictures of both sides of each ballot sheet. These images can be exported by the election management system (EMS) in standard formats, such as PDF (generally with both the front and back in the same file), multipage TIFF (Dominion uses these, with three pages in one file, the front, back and "audit mark" graphical image of the voting system evaluation), or PNG (Dominion uses this, with all three pages combined into a single tall image.) 

Please note that the term "Ballot Image" has a deprecated meaning. It used to mean digital inputs by the user at a Direct-Recording Electronic (DRE) machine or another touch-screen machine. The term "image" is used in computer science to sometimes mean an exact copy of digital data. This prior use is now deprecated and the term is now widely understood to mean the actual digital pictures of the document rather than just a copy of digital data that does not represent a picture.

**Ballot Image Audit (BIA) --** A review of digital images of ballots in a jurisdiction of an election and comparison with the official outcome for each ballot, group of ballots (precincts or batches), or the entire jurisdiction. AuditEngine is a platform that can provide the compute services for such an audit.

**Ballot Marking Device (BMD) voting machines** -- Typically a touch-screen interface with a printer which allows the voter to select the desired option for each contest, and then print out a ballot summary card with those options printed on it, typically also with barcodes or QR Codes that provide the votes of the voter. This print-out is later scanned to produce Some BMDs print a ballot in the same format as a hand-marked paper ballot and cannot be easily distinguished from it. Election officials may choose to use BMDs to reduce ambiguity of what is voted, including write-ins, because those are keyed in. However, they provide lower verifiability since voters tend not to check the printed summary portion, and the QR Code could potentially be different from what is printed. Also, there is also no way to know if all the contests and options were presented to the voter in their private voting session. However, since the BMD device does not have any internal memory and a durable paper record is produced, this has improved our voting system over DRE devices.

For ES&S and Dominion, they use barcodes or QR Codes, which unfortunately cannot be verified by the voter. Therefore, AuditEngine does not use the barcodes or QR Codes and instead uses OCR to read the selections from the human-readable summary, and this will detect the possibility that the barcode or QR code does not express the selections of the voter.

**Ballot Style --** A designation that represents the set of contests on the ballot, the language and in the case of a hand-marked paper ballot, the location of voting targets. There may be 100s or 1000s of styles in any given election in a single jurisdiction. See *card_code.*

**Ballot Style Masters --** PDF files in "searchable" format that are normally sent to the ballot printing contractor for printing of ballots in their final useable form. These files are used by the *TargetMapper App* component of AuditEngine to simplify the process of "Mapping" the ballot styles. Mapping provides the location of each active target oval or rectangle which is darkened by the voter to express their voting intent and associates it with the contest and option as specified in the *cast vote record* (CVR). Preferably, these masters should also include the timing marks and any barcodes to allow the extraction of the encoded style information. However, TargetMapper can operate without these if there is a legible style indication on the ballot that is unique for each style.

**Ballot Variant** -- A term used in the comparison process. If a complete sheet is blank or if the image was detected as corrupted, then this is classified as a ballot-variant. See also *Contest Variant* and *cmpcvr*.

**Ballots Cast (Number of)** -- Determining the number of ballots cast by looking at the ballot images can be difficult if there are multiple sheets. Very commonly, voters do not return all sheets. So normally, the count is by the first sheet only, but if anyone does not return the first sheet and returns the second sheet, then it may be impossible to correctly calculate based on the ballot images provided. It is important to compare the official count of Ballots Cast to the list of voters who cast ballots, combined with the count of protected voters that are not on that list.

**card_code** -- this is the integer or binary code actually encoded on a ballot sheet, sometimes on each side of the sheet, using barcodes or other encoding. The *card_code* might be directly used as the *style_num*, or there may be a conversion utilized. The *style_num* is generally an integer. There is also a *pstyle_num*, which is the printed style designation, which may be different, but usually there is a 1:1 correspondence with the style_num. The card_code is generally not exposed to election staff that use the EMS to design the election, and is assigned to ballots by the EMS usually without the knowledge of the EMS user. These numbers are specific to a given county and different counties may use the same card_codes to mean different styles.

**Cast Vote Record (CVR) --** A data file or set of files that provides the outcome of an election, typically broken down to the individual ballot. For ES&S ballots, the CVR is typically a set of Excel spreadsheet files (.xlsx), where each record is an individual ballot sheet or one BMD ballot. For the more recent Dominion voting systems, the CVR uses a variant of the NIST CVR "Common Data Format" and is a set of JSON files or sometimes CSV (comma separated values) files. ES&S also uses this term for the pdf files where each is a written summary of the voting system evaluation of the vote on that ballot, and so we call these "CVR PDF files" while the spreadsheets are "CVR Spreadsheets." Dominion uses a similar record called the "AuditMark(R)" which is combined with the ballot images as the third page of the TIFF image file.

**cmpcvr** -- is the name used by AuditEngine for the stage of an audit where the CVR is compared sheet-by-sheet with the tabulation created by AuditEngine. This stage creates a number of comparison records, where there is one record per ballot sheet, and one record per ballot-contest that is classified as a variant. Ballot-contests that are not considered variants do not have their own record but are combined in either a "fully agreed" or "partially agreed" record for that sheet. These comparison records are then used to create the Discrepancy Report, which is the primary output of AuditEngine.

**Cooperative Workflow** -- When working with election districts under contract, we can use a cooperative workflow to reduce overhead and reduce turnaround delays. The main feature of this workflow is that a) data is available BEFORE the election is certified, and b) some data (which does not include any live ballots) is provided to AuditEngine prior to election day. This preliminary data is used to get a jump on the configuration required so no configuration changes are needed to process the live election data.

The components of the Cooperative Workflow include the following:

- We request that election districts take care with Ballot layouts. They: 
  - should include a county name and election name in a <u>standard location</u> to allow ballot images from other counties or from other elections to be detected.
  - should NOT use colors that will drop out in the scans.
- Ballot Image Files should be exported without "COPY" or other watermarks.
- Each county will prepare a *hash manifest* with hash values of each file. We suggest the use of QuickHash windows app.
- All data must be directly uploaded to AuditEngine from each county. We can provide an upload link specific to each county which will remain constant from election to election.
- Ballot Style Masters (BSM) are uploaded as soon as they become available. This should be very early in the cycle.
- Data from the Logic and Accuracy Test (LAT) in the form of ballot image archives (BIA) and CVR plus are uploaded to AuditEngine as soon as these become available. 

Then, AuditEngine can be configured, including the completion of the Target Map prior to the election using the LAT data. As soon as ballot images and the CVR are completed in the real election, these files are uploaded. The mapping phase is skipped in the real election audit and the Target Map is imported from the LAT audit. This results in quick-turnaround of the audit results.

This is in contrast with the "Public Oversight Workflow" which occurs after certification with no additional work by election districts other than providing data, and therefore is not turnaround-time optimized.

See also "*Workflow*"

**Contest or Ballot-Contest** -- This is a term used in the comparison process. On each ballot cast, there are a number of contests. A single contest on a single cast ballot is a "ballot-contest" and sometimes just "contest" in the context of the comparison report. This is not the entire contest with all votes from all ballots summed, but simply the evaluation of that single contest on that sheet (for that single voter). Frequently, these can be called "votes", except that sometimes a single contest will allow multiple votes.

**Contest Variant** -- A contest variant is a *ballot-contest* which has write-ins, overvotes, is gray-flagged, or is 'disagreed', i.e. if there is any disagreement between the evaluation of the vote by AuditEngine and the official result. (Undervotes are not included in the set unless they are disagreed.) Contest Variants can normally be summed by contest. Each contest variant has a separate comparison record for each ballot-contest instance.

**Direct Recording Electronic (DRE) voting machines** -- After the Help America Vote Act (HAVA) was passed in response to the year 2000 election debacle, districts began to adopt fully electronic voting systems which record the vote to attached memory. Because these systems had no paper trail, the vote could be altered or lost and there was no way to check it. In response to this problem, these machines were retrofitted with a Voter-Verifiable Paper Audit Trail (VVPAT) device, which recorded the votes onto a paper tape that the voter could review. This type of record is sequential and can be easily linked to the voter, is relatively difficult to audit, and frequently, the cheap printers would fail or overprint. These voting systems are now being retired for hand-marked or BMD voting systems.

**Disagreed** -- as used in the comparison process, a contest is considered "disagreed" unless the voting system and AuditEngine fully agree on the outcome, including whether it was overvoted, undervoted, or had write-ins. Since write-ins and overvotes are frequently reviewed and adjudicated by election staff, disagreed write-ins and overvotes are treated separately by the AuditEngine analysis. "*Normal Disagreed*" are the rest of the disagreed contests, which do not include write-ins or overvotes, but instead provide the actual difference in the vote cast.

**Dominion Voting Systems (Dominion) -- **A major voting system vendor with approximately 37% of the market.

**Election Management System (EMS) --** This is the general term for the suite of software applications that provide all the functions needed to assist election officials to perform elections. Functions include the definition of ballots, configuring voting machines that are used in polling locations, central tabulation, and reporting.

**Election Systems & Software (ES&S) --** A major voting system vendor with approximately 47% of the market.

**ETag** -- Short for "Entity Tag", this is a string of hexidecimal digits (usually MD5 format) and possibly a hypen followed by decimal digits. These are used by cloud storage to allow detection of changes in the files uploaded. AuditEngine can calculate the ETags of local files to know if uploading or downloading is necessary. These are used by the AuditEngine *Pipeline* to know if a stage needs to be re-run, if the dependencies have changed. See also *MD5*, *Pipeline, SHA1 / SHA256 / SHA512*, *Stage*

An example ETag as used by AWS S3: **6cf81d4ec591b351adbfb33ed5861b6f-228** It includes a first part, which is the MD5 checksum over a list of MD5 checksums of smaller chunks of data. In this case, there are 228 chunks. As a user of these values, the only thing you can determine is whether they differ.

**extractvote** -- This is the primary stage in the audit process where all ballot sheets are individually processed to recognize either the marks made by the voter, if it is a hand-marked paper ballot format, or to perform OCR on the text summary on the ballot summary cards produced by BMDs. The extractvote processing is delegated to a fleet of individual compute instances in our datacenter and we are authorized to run up to 10,000 compute instances.

**Flagged** -- A contest is flagged by AuditEngine if they include write-ins, are "Gray" (ambiguous) or if AuditEngine used heuristics to guess on the correct resolution of hesitation marks and cross-outs, in the case of overvotes, or if the ballot images were unprocessable due to damage to the image.

**Fleet** -- The term "fleet" is used to refer to the set of computers that are used by AuditEngine in certain stages that can be expedited by using parallel processing. AuditEngine currently uses AWS Lambda compute instances and we are authorized to used up to 10,000 at a time, but usually we can get by with using only 2,500 instances for a given stage. Because we are limited to the overall number of instances used at any time, we use a reservation system during critical post-election times when many election districts are conducting audits simultaneously. Each delegation to the fleet typically takes less than 15 minutes, unless we are processing a very large number of sheets. Once one user has released their reservation then another delegation to the fleet can occur.

**Fully Agreed Sheets** -- In the comparison process, a ballot sheet is classified as *Fully Agreed* if it has no write-ins, overvotes, and gray-flags, and every contest fully agrees between the evaluation of the voting system and AuditEngine. Such sheets are maintained as a single record. See *Partially Agreed Sheets.*

**gentemplates** -- This is an important stage in the AuditEngine processing pipeline where individual ballot images of each style are combined to create a standard style template of each style. Each sheet has its own style. See also *BallotStyle*, and *card_code*.

**Hand-Marked Paper Ballot --** This type of ballot provides all the contests and options that can be voted by specific voter on a set of ballot sheets, with targets that can be marked by the voter using a conventional pen. This type of voting is not usable by voters who are blind or cannot operate a pen. Federal law currently mandates that each polling place have machines that are compatible with the needs of voters with disabilities.

**Hart Intercivic --** A voting system vendor with a relatively small footprint nationally.

**Hash Value / Hash Manifest File** -- A hash value is a fixed-length "fingerprint" of each file which is a) relatively easy to calculate, b) will change substantially if even one bit is changed, and c) is infeasible to predict. Therefore it is infeasible to alter a given file to produce another valid file and also produce the same hash. The receiver of any file can calculate the hash values and compare it with the hash value in the hash manifest to verify that the files are unchanged. 

A single "Hash Manifest File" can be prepared that includes the file name and a hash value for each file provided in the export of the official results. There are free applications that will prepare a file of the hash values of any given folder.

**Images Missing** -- This is a discrepancy attribute. Sometimes we can't access all the images and so these are accounted for as images missing. AuditEngine does not attempt to sum the contests in terms of the number of contests that are missing on ballot images that are missing.

**job_name** -- This is the name of the job to differentiate it from other jobs, and determines where the files are stored. The format of the job_name as been standardized as ST_County_YYYYMMDD, where ST is the two-character state abbreviation, County is the County Name without spaces, and YYYYMMDD is the the data of the election when the polls closed. Thus, **GA_Bartow_20201103** is the job for the 2020 General Election in Bartow County, GA. It is okay to add additional tags to the end, like **_LAT** if it is the job to process the Logic and Accuracy Test ballot images in that same election, or for other purposes. NOTE: The job_name can't be changed very easily once it is set. It cannot have spaces or special characters other than underscore. See also *Audit Job*.

**Lambda** -- AuditEngine is current deployed to Amazon Web Services (AWS) cloud, then our parallel processing fleet uses their Lambda service. See *Fleet*. 

**Logic and Accuracy Test (LAT)**  -- Voting systems typically are required to complete a "Logic and Accuracy Test" (LAT) where the voting system is configured and it processes test ballots that check the mapping of *Targets* on Hand-Marked Paper Ballots are correctly linked to the cast vote records (CVR). Essentially, the LAT answers the question: *Does the voting system (hardware and software) read and tabulate the marks on a ballot or touches on the screen with 100% accuracy?* 

The test ballots are usually marked uniformly and not with light marks, circles, checkmarks next to the oval, etc. The test ballots created to fully test the software — NOT to simulate an election. The LAT should also include BMD ballots to test the audit system but AuditEngine does not benefit by processing these in a Cooperative Workflow, but the BMD ballots can be inspected to set up the strings used on these ballots.

AuditEngine can audit these test ballots by processing them as if they are an election, and comparing with the known good CVR results. This will actually also test the accuracy of AuditEngine, and will assist with the configuration of AuditEngine.

AuditEngine can use the LAT to create the Target Map so the actual election data can be processed with faster turnaround. In this mode, it is best if the LAT CVR includes the "Ballot Style" field (ES&S) and for Dominion, the JSON CVR export should be used. 

​	- See [Guidelines for Creating a Deck of Test Ballots (John Washburn)](https://copswiki.org/w/bin/view/Common/M1993) 

**Mapping --** One key step in the process of performing a ballot image audit is the mapping of the contests and options to specific target locations on a paper ballot of a specified style. (See also "*TargetMapper App*")

**MD5** -- This is a popular hash algorithm checksum used to detect changes in files due to uploading or downloading errors. It is not strong enough to be used for critical cryptographic purposes, but it continues to be used for checksums of files by cloud storage services and is generally regarded as "good enough" for those purposes due to the restrictions on file structure. Other stronger algorithms are recommended for critical cryptographic purposes, such as SHA1, SHA256 and SHA512. We generally recommend using SHA512 for the Hash Manifest because it is available and is extremely strong, but cloud storage services continue to use MD5.

An example of an MD5 checksum: **f664b587aacae05c8aa5c591b8659ec4**

**Modified Record** -- See 'Adjudicated'.

**Overvoted --** If a voter marks more than the number of options allowed in the contest, it is considered "overvoted" and no vote is awarded to any option. For example, if the "vote-for" number is 1 and the voter votes for three options, it is considered one overvote. 

Overvotes do not occur on BMD ballots. 

Very frequently, overvotes are misinterpreted by the voting system and should be fully reviewed in close contests. If a contest has an overvote, it will be first classified as an overvote, even when the write-in target is selected. Some election departments will mark overvotes as an undervote when they are confirmed as an overvote. AuditEngine understands this form of adjudication and does not regard it as a disagreement.

**Page** -- one side of a sheet, if sheets are printed on both sides. If a ballot has 2 sheets, then the pages are numbered 1, 2, 3, 4, for the front of sheet 1, back of sheet 1, front of sheet 2, back of sheet 2. Sometimes pages and sheets are numbered starting at 0, so be careful. If we know the page or sheet will start at 0, we will call it page0 or sheet0. 

**Partially Agreed Sheets** -- In the comparison process, if a ballot sheet has at least one *contest-variant* detected, then that contest variant is logically pulled from the partially agreed sheet comparison record, and what remains are the rest of the non-variant contests. Note that if all contests are considered contest-variants, then the partially agreed sheet will persist as an empty shell with no contests left in it, and all contest variants will be moved to the contest-variants set.

**Phase** -- See *Audit Phase*

**Pipeline --** The operation of AuditEngine is broken into a series of stages, where each stage has defined inputs (dependencies) and outputs. The set of the stages together is called the pipeline. Each stage cannot be executed unless its dependencies are available from prior stages.

**Poll Tapes / Digital Poll Tapes --** Voting machines that are used in polling places typically have a poll-tape report which is printed out by poll workers during an election, and frequently posted at the site and turned into the election office. Digital Poll Tapes can be produced by ES&S systems which are an exact copy of the report produced by the voting system scanner but provided as a PDF file and can be processed by AuditEngine to provide another check of the results of the election.

**Public Oversight Workflow** -- AuditEngine has been designed to accommodate a "Public Oversight" workflow where members of the public, candidates, or campaigns can request ballot image and CVR data and conduct audits using AuditEngine independently from the election office. This will likely happen in a slower timeframe, because these data are available and the audits are commonly only activated after the election is completed and when there is some question of the outcome. This is in contrast to the "Cooperative Workflow" where the election districts are providing data prior to the election to expedite audit turnaround. See *Workflow*.

**Risk-Limiting Audit --** A method of checking that the outcome of an election is accurate by random selecting ballots or batches of ballots, and continuing to select samples so that the risk that the outcome (as determined by a full-hand count) could be statistically different, is less than a given risk limit. There are four types based on how the samples are taken (by ballot or by batch) and how those samples are compared (by margin or by sample), resulting in ballot-comparison, ballot-polling, batch-comparison, and batch-polling. RLA audits are difficult to apply to many small contests and when margins get tight, and will miss issues that involve just a few ballots. In contrast BIAs (Ballot Image Audits) such as those conducted using AuditEngine can detect issues down to the specific ballot.

**S3** -- This stands for Amazon "Simple Storage Service" but it is normally only called just AWS S3 or just S3. This is the secure storage service used by AuditEngine. This service does not allow alteration of files after they are written, and the timestamps cannot be altered. Also, our fleets of compute instances must have the data in S3 in the same datacenter, and produce their results also to S3. AuditEngine, for security, does not use a database service in the processing of election data, although they are used for the purposes of controlling the front end and helping AuditEngine Apps maintain state.

**SHA1 / SHA256 / SHA512** -- These are stronger hash algorithms that result in longer hash values, and are approved for cryptographic purposes. If available, we recommend the use of SHA512 in *hash manifest* files. See also *MD5* and *ETag*, *Hash Manifest* 

**Sheet** -- Each ballot image is of a single paper sheet, including both sides. This is the case even if multiple sheets are included in the logical ballot. 

In the comparison process, the number of sheets shown in tables is not necessarily a direct sum because a single sheet may include multiple contest variants. Also, depending on the number of sheets included in a single logical ballot, the number of ballots cast may be less than the total number of sheets, and it may be hard to predict because subsequent sheets are commonly not included in the logical ballot cast. Counting the first sheet will usually produce a pretty accurate number, but even then, some voters do not include the first sheet either.

**Stage --** One set of operations that are logically separated in AuditEngine, with specified input files (dependencies) and output files that result. Each stage commonly also produces reports of the results of those operations. The stages are organized into a pipeline, and are executed sequentially until the pipeline is completed. Sets of stages are also combined logically into phases, for the purposes of explaining their functionality.

**Targets --** The ovals or graphic elements that are completed by the voter to indicate a vote.

**Target Map** -- a configuration file which is the result of the *TargetMapper App* which associates the location of targets on hand-marked paper ballots with the contest and option as defined by the voting system and exists in the *CVR*.

**TargetMapper App --** A browser-based application that assists with the mapping of the contests and options as defined by the CVR and the targets on hand-marked paper ballots.

**Undervote --** Occurs when a voter does not vote for as many options as is possible in a contest. The number of undervotes is the number that is not voted. So if a voter can vote for up to 3 in a contest, and only one option is selected, then the number of undervotes in that contest is 2. nAuditEngine will correctly interpret many marks that would be considered undervotes by voting systems, such as when ovals are circled or if a checkmark does not actually get inside the oval.

**Unprocessed** -- Unprocessed sheets are those that were NOT successfully processed by AuditEngine, generally due to images that are damaged due to scanner jitter when the sheet is not evenly fed through the scanner, barcodes that were corrupted and unreliable, or BMD ballots that were not perfectly read using OCR. Cleaning the scanner rollers can help to avoid corrupted images. AuditEngine does not track the number of contests on unprocessed sheets. If a large number of ballots are unprocessed from a specific voting machine scanner, then additional maintenance or retiring that scanner may be called for. Ballots that were Unprocessed were not necessarily improperly evaluated by the voting system.

**Verification Images, Verification Phase**  -- AuditEngine has an optional capability to process ballot images that are made using non-voting system scanners. We call these "Verification Images", and the workflow component is the "Verification Phase". 

Verification images should be of precincts (or batches) that corresponds to an aggregated group in the CVR. These are not run as a separate audit, but as an additional phase in the pipeline of the subject audit.

The number of batches processed in this way can be minimized, because the primary hazard being tested is the remote chance that the ballot images were manipulated prior to being secured by the system after scanning. Therefore, the number of batches can be reduced to a fixed value.

Typically, this can be added if there is any concern by the public of specific contests that are close. It is mainly important that the public knows this option is available because any temptation to attempt to hack the election in this manner will be reduced.

The physical ballots utilized by this phase should not be touched by election staff after the precincts (or batches) of ballots are chosen, and the seals should be intact when they are ultimately rescanned. Thus, the precincts (or batches) should be kept isolated and easily accessible. The exact strategy to be used in this phase will depend on the voting system and how ballots are already being stored, and must be discussed with our election experts.

**Voting System** -- A general term to refer to the system used by the district to conduct the election, including the EMS and voting machines, etc. These systems are Election Systems & Software (ES&S), Dominion Voting Systems (Dominion), Hart Intercivic (Hart), or any others. AuditEngine strives to be compatible with any voting system that can provide adequate data files in the form of ballot images, CVRs, Ballot Style Masters and other related data. See also *Election management system (EMS)*

**Workflow** -- The workflow describes how the work will be done, particularly when working in concert with state and county operations. The following grades are defined:

- **Public Oversight Workflow**  -- This workflow does not require any special actions by election staff other than publishing data files. This is the default mode of operation when AuditEngine is run by civic groups, candidates or campaigns without much interaction with election staff. This workflow is run after certification and is dependent on the availability of ballot images and CVR files, which may be delayed until after certification. Because they are run after certification, audits using this workflow may still impact elections if there are significant findings in local contests but there is typically not a direct route to changing the outcome.

  This workflow also requires the least amount of data as they don't actually need the Logic and Accuracy Test (LAT) ballot images nor the LAT CVR files, because the turnaround time is not optimized.

- **Cooperative Workflow** -- When audits are run in cooperation with election districts, turnaround time can be optimized by running AuditEngine prior to certification and using the LAT ballots and CVR, plus the Ballot Style Masters (BSMs) to fully configure AuditEngine prior to the election to be ready to run when live election data is available.

- **Jurisdiction-Run Workflow** -- To further optimize the workflow and reduce the reliance on personnel outside the control of election districts, the configuration of AuditEngine for audits in each election district can be easily delegated to workers in those districts. Thus, this is the same as Cooperative Workflow but the work is being all done by at least one worker in each district. It is also essential that there be at least one project manager independent from the election districts assigned to each state to provide independent oversight. The workers in each district will:

  - Cooperate in the design of ballots so a common configuration can be used by AuditEngine to recognize the County and Election on each ballot.
  - Create the Election and two audits for that district. One audit uses LAT data and the other is uses live data.
  - For the LAT audit:
    - The BSMs and LAT ballot image and LAT CVR files are uploaded.
    - Run Phases 1 and 2 with the LAT images to create data for the map.
    - Create the Target Map using the TargetMapper App, import the map and check the redline proofs for accuracy
    - Optionally and preferably run Phases 3 and 4 using the LAT data as an audit to check that mapping. This incurs an incremental cost.
  - Then when live data is available:
    - Upload the ballot images and CVRs to AuditEngine.
    - Run Phase 1 (Metadata Analysis), but <u>skip Phase 2 (Mapping)</u> and move directly to Phase 3 (Vote Extraction) and 4 (Comparison and reporting). Assuming there are no issues, these phases can be run within a day.
  - If a **Verification Phase** is to be used by the jurisdiction, the precincts (or batches) are selected using rolls of ten-sided dice from a list of precincts (or batches). Then the precincts (or batches) are pulled, and without breaking seals from storage, are scanned using non-voting system scanners. The stages of the Verification Phase includes extracting the metadata from the scanned images, and performing extraction, and then comparing the result on an aggregated basis.

  Note: AuditEngine uses a fleet of up to 10,000 computers that operate in parallel. When running for one job, they can't be used at the same time for another job. But each use of the fleet takes generally less than 15 minutes. So although the work to do the mapping (Phase 2) is distributed to the various jurisdictions, the other stages (such as 3 and 4) that delegate to the fleet must operate on a reservation basis. Depending on the extent that AuditEngine is being used at critical moments after an election, there may be a delay in processing due to the need to reserve the fleet.

**Write-in** -- If the write-in oval is marked or if the write-in area is filled in, then it is considered that the voter intent is to write-in the name for some other candidate. How this is handled is specific to different states, but most often, the written-in name must also be from a list of qualified write-in candidates. 

Write-ins on BMD ballots do not need human-eye adjudication because the names are keyed in.

The name written-in should be examined in close contests even if there were no candidates that were qualified as write-ins for this contest, because the name written-in may be of a listed candidate, and if so, then the vote is accepted for that listed candidate.

Write-ins normally account for about 80% of Contest Variants. 
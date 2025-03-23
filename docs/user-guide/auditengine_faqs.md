---
title: AuditEngine FAQs -- Frequently Asked Questions
summary: List of questions people frequently ask about AuditEngine
authors:
    - Ray Lutz
date: 2021-06-11
remote_url: https://copswiki.org/Common/AuditEngineFAQs
---

<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />



# Frequently Asked Questions (FAQs) about AuditEngine

## Q: How does AuditEngine work?
Simply stated, AuditEngine uses the ballot images of each ballot that are now produced by voting system when the ballot is first scanned, and we provide a detailed independent tabulation of the results. AuditEngine compares this independent tabulation ballot-by-ballot with the results of the voting system to find those exact ballots where we differ. Our system works best if we audit all contests because it gives us the most information about the marking habits of each voter so we can tell the difference between a true mark versus a "hesitation mark" or crease in the ballot.

AuditEngine runs in the cloud, where we can harness the power of large data centers. We are currently authorized to run up to 10,000 computers in parallel to complete the analysis of the images in a very short period of time, typically less than 15 minutes per run of each stage.

## Q: What are "phases", stages", and the "processing pipeline"?

AuditEngine uses a "processing pipeline" which consists of individual "stages". Each stage takes inputs and produces outputs, and once the data is created by that stage, it is not altered later. A later stage can run as soon as data produced by an earlier stage is created. This structure is best for an auditing platform because we can check and "prove" the validity of each stage output based on the set of inputs. Each set of data is tracked using cryptographic hash values to detect if the data has been changed from when it was originally built.

The stages involved in any given audit will vary depending on the data provided, the type of audit, the workflow methodology, voting system vendor, reports required, and other considerations. There are also a number of tools available that operate outside the scope of the pipeline and use human perception to assist with certain stages that are easy for humans to perform, but very difficult for computer algorithms. There is an opportunity for others to contribute plugins to perform additional processing and reports either in or outside the pipeline.

These stages can conceptually be combined into "phases" which are related also to what must be done to conduct the audit. 

## Q: What is the "workflow methodology"

There are several different ways we can coordinate with election districts:

### Public Oversight Workflow

When using public oversight workflow, we have no coordination with the election district, the results are probably fully certified, all the data, such as images and CVR are available at the same time. In this workflow, there are no critical time constraints, and the data may not be as clean as would be the case if we had cooperation with the district. AuditEngine was originally designed with this workflow in mind, and with incomplete data, such as no CVR and no ballot style masters. We can conceptualize the following phases:

- **Phase 1:** Organize and reconcile the metadata from all sources including information about all the images and the CVR. The contests and option names can be derived from the CVR since we have it. This phase also includes a full examination of all images to read the style from each one so we can understand the style methodology being used. Produces reports to evaluate the consistency of the data and provide assistance with understanding the style
- **Phase 2:** Perform mapping, either by parsing ballot style masters or deriving the map from the images alone. This requires some human-perception assistance.
- **Phase 3:** Extract the vote from all the images and create the independent result. This phase does not use the CVR at all even though we may have it.
- **Phase 4:** Compare and Report. This phase may also include adjudication to refine the accuracy of the result.

### Cooperative Workflow

If we have coordination with the election district, then it is also likely that we want the audit results very quickly, prior to certification, perhaps within 24 hours of receiving ballot images. For that performance, the "mapping" of the location of each markable oval on the ballot to what it means must be accomplished prior to receiving the ballot images. Also, it is required in this workflow, that the evalulation of the results by AuditEngine must be completed prior to receiving the CVR. Thus, there are three phase to this workflow:

- **Phase 1:** We require a source of data that will provide the contests and options exactly as used in the CVR. This can be from the Logic and Accuracy Test ("LAT") files. AuditEngine can perform automated mapping using the Ballot Style Masters and limited human-perception assistance by editing a spreadsheet. This produces redline proofs and option proof reports that can be reviewed to confirm the accuracy of the map.
- **Phase 2:** Just after the election, we receive the images. First, we must organize and checking them for repeated images and whether the number of images reconciles with the total number of ballots cast. The images are fully examined to extract the styles, which should match the styles mapped in Phase 1. There is another human-perception task to match the names used on BMD ballots to what is actually printed on those ballots. Next, the vote is fully extracted from the images to create the independent evaluation by AuditEngine, and provide that to the election staff.
- **Phase 3:** Receive the CVR and compare with the result of AuditEngine. Adjudicate as needed to finalize the result. This can be in concert with the election district where they may provide an initial CVR and then later, one that is adjusted to be more accurate.

## Q: What are the "AuditEngine Apps"?

AuditEngine has a number of browser-based apps that assist the user to conduct the audits. These apps include:

- **AuditEngine frontend** -- this browser app provides for:

  - creating districts
  - creating elections within those districts
  - uploading files related to each audit, including:
    - ballot images in ZIP archives (BIAs), 
    - cast vote records (CVRs) (possibly in zip archives)
    - ballot style masters (BSMs), 
    - official aggregated results
  - creating audits for those elections
  - establishing the setting for audit executions
  - running each stage of those audits
  - viewing reports and intermediate results
  - locking and unlocking audits

- **TargetMapper** -- This browser-based app assists with the mapping of contests and options, as they are named in the CVR, to the targets as they are shown on hand-marked paper ballots, for each style. This app has copy and paste operations that can expedite the mapping. Sometimes there are 100s or 1000s of styles.

  This app can run in a number of modes:

  - **Ballot Images Only** -- If the CVR is not available, then the mapping can still occur, and the user will essentially build the list of contests on each style by choosing them from all contests for that style. This takes additional checking because of the lack of information from the CVR regarding the contests on each style.
  - **Ballot Images and CVR** -- In this mode, the CVR is available, and thus the contests that are on each ballot style are known (as the contests in each style are derived from the CVR), and this can reduce error in mapping the styles. Since many styles are similar on a given side of a sheet, it has "Paste-Similar" which can find the similar styles on that side and paste the contests. This must be checked later but it usually is accurate. Worst case, there must be a mapping operation for each style.
  - **Ballot Images, CVR, and Ballot Style Masters** -- In this mode, the full ballot styles masters are available, and they provide the location of each contest "rendition" on the ballot. Once a ballot rendition is found and mapped, it can be checked that it matches the rendition on other styles, and it can be quickly mapped. Worst case, there must be a mapping operation for each contest rendition.
    - This mode can also be used if the ballot style masters do not have timing marks or style encoding, as long as there is a legible style indication on each style that can be extracted by OCR or read by human eye. However, it is much better if the ballot style masters are complete, with timing marks and the barcoded information that represents the style.

- **AdjudiTally App** -- This browser app provides several modes:

  - **Adjudicator** -- It presents the evaluation by AuditEngine and the evaluation by the voting system and that portion of the ballot showing the users marks or BMD card. The AdjudicatorApp can also be used without any voting system results to fine-tune the results by AuditEngine by reviewing any records that have been flagged for further review.
  - **TallyApp** -- Within AdjudiTally, we also provide a mode usable by individuals or teams that want to work to evaluate the vote by human-eye. It does not do any comparison, and all or a subset of contests can be entered, and they can be random sampled to conduct a statistical check of the results based on the ballot images. 
  - **BallotViewer App** -- In this mode, ballots are simply viewed within any selected contest or other filter.


## Q: What reports does AuditEngine generate?

There are only two or three reports that will be of interest to the general public or candidates and campaigns:

- **Audit Results Report** -- This report simply provides the grand total for every option in every contest without any comparison. This is also called the "Source Totals Report", because it relates to the 'source' data.
- **Audit Variants Report** -- Describes any "variant" contests in terms of overvotes, write-ins, and gray-flags (ambiguous marks) as determined by AuditEngine. This is just like the Discrepancy Report, but it does not compare with the official results from the voting system, the CVR. (This report is only provided in Cooperative Workflow.)
- **Discrepancy Report** -- Provides everything in the Audit Variants Report plus compares the Audit Results with the official CVR.
- **All other reports** -- AuditEngine provides dozens of other reports that are used when there are problems with the data provided, to allow the audit itself to be reviewed by experts to validate each and every stage of processing, and to allow analysts to more fully understand the nuances of the data provided. For most people, these reports will not be of interest for purposes of understanding the outcome of the election.

### Discrepancy Report (and Audit Variants Report)

The most important report to understand is the "Discrepancy Report". The Audit Variants Report is identical but omits the comparison with the CVR, and does not provide disagreements.

The discrepancy report provides the result of comparing the votes extracted by audit engine with those extracted by the voting system. It includes the following:

- **Introduction** to make sure the reader understand our terminology.
- **Metadata Summary**: This metadata summary includes comparison counts between the CVR, Images and Cast.
- **Summary of Discrepancy Records**:
  - **High-Level Reconciliation:** by sheets and by contests, including pie charts.
  - **Audit-Engine Flagged Report**, by sheet and by contests, including pie charts.
  - **Contest Variants Breakdown**, by sheet and by contests, including pie charts.
  - **Normal Disagreed** (No write-ins or overvotes) by sheet and by contests, including pie charts. This is not available in the Audit Variants report.
  - **Non-additive Groups** - including Contest Variants, Disagreed, Ballot Variants, uncategorized (should be 0) and Blank sheets.
  - **Ballot Variants** -- these are ballots that were distorted, blank or had other global problems, like from the wrong district or election.
- **Contest Discrepancy Table**. Each contest is summarized as one line in a table, with the following fields:
  - **Total:** Total ballots cast which included this contest with images that were processed by AuditEngine.
  - **Non-Variant:** Ballots with this contest where the official outcome and the evaluation by AuditEngine agreed, and did not include write-ins, overvotes, and were not flagged as 'gray'.
  - **Agreed Overvotes:** Ballots where both AuditEngine and the voting system detected an overvote.
  - **Agreed Write-ins:** Ballots which included write-ins in terms of a marked target, but where the name written-in may not be a qualified write-in candidate, and the write-in may be correctly attributed as a vote for a listed candidate.
  - **Agreed Undervotes:** Undervotes are very numerous and we do not break those down here, and are not included in the discrepancy report unless they are disagreed or gray flagged.
  - **Disagreed:** These are ballot-contests which were not initially evaluated as overvotes or write-ins, and where the evaluation by AuditEngine disagrees with the voting system.
  - **Gray Only:** Ballot-contests where AuditEngine detected an ambiguous mark on this contest or used heuristics to decide voter-intent. This column omits any ballots which are in the columns for write-ins, overvotes, or disagreed ballots, even if AuditEngine internally flags them as gray.
  - **All Variants:** Ballots with Agreed Overvotes, Agreed Write-ins, Disagreed, or Gray Flagged. The number of ballots cast should equal the sum of "Plain Agreed", and "All Variants". The components of this column are highlighted.
  - **Disagreed% of Margin** This provides a good measure of whether the variants may have any impact on the outcome, and the highest five values are highlighted. Further analysis is still required to see if the disagreements will reduce the current margin of victory.
  - **Variant% of Margin** This provides a maximum measure of whether the variants may have any impact on the outcome, and the highest five values are highlighted. Typically, the vast majority (perhaps 90%) of All Variants are Agreed Write-ins and Agreed Overvotes which may only rarely result in any changes in the outcome.
  - **Vote Margin:** This is the margin of victory, i.e. gap between votes for runner-up and winner (lowest winner if contest has multiple winners) among the ballots processed, and may be a subset of the total margin for the entire district if AuditEngine did not receive or process all ballot images.
- **Contest Details**: Each contest is then reviewed in detail. To limit the size of the report, contests are only detailed if they are one of the first 10 contests, the closest 5 contests, the most variant 5 contests, or any contests with Disagreed Variants more than 10% of the margin of victory. Also, any contest of interest can be reviewed in detail.
  - CVR results for this contest.
  - Summary of the comparison results for this contest (same as the line in the Contest Discrepancy Report)
  - Disagreed ballots by group, detailed by record types. These are summary tables for each record type. Click on group designation and it will go to the individual records.
    - Normal Disagreed
    - Write-ins
    - Overvotes
    - Gray-Flagged
  - Individual records for each discrepancy. This is a lengthy section which shows the discrepancy record followed by the image of the ballot, front and back. Click on the thumbnail and the full size image is displayed in another window.
- **Precinct Report Summary Table** -- Each precinct is summarized as a single line in a table. Columns in this table are similar to the contests table. Although this is typically required by districts we work with, we find this information to generally not too informative, but it may be the case that a specific precinct was "hacked" or modified and therefore needs to be further reviewed.
- **Precinct Details** -- Precincts are detailed if they have the highest Disagreed% of Total or highest Variant% of Total.  For each precinct, they are first broken down by group, then detailed to the ballot. Ballots are shown as thumbnails and can be viewed in full resolution by clicking.

### Other Reports

Without going through them all, we can list the reports here.

- **Precheck Report** -- This report simply lists all input files specified and provides their hash values.
- **Ballot Image Archive Metadata Report** -- Provides Ballot Image Archives Summary, which are cumulative values across all archives and describes any repeated ballot images, if the names are repeated. This report is only available after the images are available. 
- **Image Match Report** -- The report of any repeated ballot images that are detected by image content.
- **Election Information File (EIF) Parsing Report** -- This report provides for each contest, the name of the contest, the bmd_contest_name which is found on BMD ballots, The ballot summary text for each contest name.
- **Style Masters Parsing Report** -- This report simply describes the contests in each style and whether all the styles have been fully auto-mapped. (Only available if Style Masters are available.)
- **Style Redline Proof Report and Option Proofs Report** -- These provide the configuration of AuditEngine regarding how it will extract the results from each style, in terms of what each target oval represents.
- **Ballot Information File (BIF) Report (Metadata Report)** -- Provides the metadata drawn from both the archives and the CVR and reconciles them. This report provides a means for analysts to understand the style methodology.
- **Templates Report** -- Shows the ballot_ids for the ballots used to create the templates, and each template, when the mapping is generated from the images along, and when no style masters are available.
- **BMD Map Report** -- This report provide a mechanism for providing corrections to the strings actually used on BMD ballots, which can be checked once the images are available.
- **CVR Parse Report** -- Provides details about parsing of the CVR.
- **Final Report**-- The final report provides top level metadata and links to other reports.
- **Pipeline Report** -- The pipeline Report provides the details about each stage in the pipeline, including hash values for each file used, and the status for each.
- **Logs** -- Logs are created with progress statements for each stage and for each ballot during extraction. There are two types of logs. The first are normal logs, and the second are exception reports. Exception reports are created when a ballot or condition is found to require additional special reporting, and frequently ballot images are saved in conjuction with these reports. For example, if a ballot could not be aligned, the this would prompt an exception report.
- **Ballot Research Report** -- Any individual ballot can be researched to provide the details from each of the stages about that ballot. Depending on the settings, this can also generate intermediate image processing data about each ballot as it is processed.

## Q: What data is needed to run audits?

AuditEngine requires only a few data items to be exported by the election system, and we do this to minimize our reliance on the voting system. This makes our auditing solution more independent from other options that may require more data. But if we are using the "Cooperative Workflow" we can provide faster turnaround if we have a bit more from the election system so we can configure our system prior to the time when the real data becomes available.

- **For Ballot Image Audits** -- The normal data we need is, at a minimum, the following:
  - **Ballot image archives (BIAs)**, combined into ZIP archives, up to about 50K ballots per archive.
  - **Cast Vote Records Files (CVRs)** -- in xlsx format (ES&S) or JSON format (Dominion)
  - Preferably, **Ballot Style Masters (BSM)** as PDFs in searchable format
    - preferably, with all timing marks and barcodes.
    - or without timing marks or barcodes but with style designation shown on each style.
- **To improve turnaround** -- particularly if we are working with jurisdictions that want quick turnaround:
  - **Logic and Accuracy Test (LAT)** ballot images archives (LAT-BIAs) and the corresponding LAT CVRs, 
  - **BMD Strings**: A list of the contest names and options as shown on BMD ballot summary cards, if different from the official names. This we can generate using the BMD Map Report.
- **To Run Verification Images** -- independently scanned ballots aggregated to the same groups are are reported in the CVR.
- **Digital Poll Tapes Audit** -- For ES&S systems, we can run also a "Digital Poll Tapes Audit" which parses the digital poll tapes which can be exported from the ES&S EMS for each machine used in early voting or on election day, and comparing these with the aggregated totals.

### **Instructions: for Exporting data from the EMS**

- [Sending Election Data to AuditEngine](sending_data.md) -- Includes:

  - Archiving the Data
  - Creating a Hash Manifest File
  - Providing the data:
    - Posting the data - Election officials are now opting to post the data once for all requesters.
    - Uploading - We can provide a county-specific upload link so they files can be easily uploaded.
    - Using USB Thumbdrives
    - Using a "Jump Drive"

## Q: Does AuditEngine have a good track record?

AuditEngine is relatively new, largely because the ballot images it uses in its review are only recently available on a widespread basis. However, we have recently completed a very thorough case study of the platform on three counties in Florida: Collier, Volusia, and St. Lucie. This case study provides evidence of the very high accuracy of AuditEngine, where it agrees with the voting system more than 99.7% of the ballots, and when we disagree with the voting system, AuditEngine interpreted voter intent 93% of the time correctly. In other words, we have proven that AuditEngine is more accurate in terms of automatically correctly interpreting voter intent than the voting systems. 

In the case study of Volusia County, FL in the 2020 General election, we identified a number of discrepancies in how results were uploaded to the Election Management System (EMS). As a result, we now know that there are two internal tabulations in ES&S Equipment, and these two tabulation may grow to differ due to several error modes.

We identified 4,904 ballot images that were duplicated, due to a failure of the thumbdrive in an early voting precinct and then "clearing" the election and starting over. But the images were not properly deleted and neither were the CVR records of those initial ballots. One voting machine that was never correctly uploaded using the thumbdrive, resulting in 537 fewer ballot images than should have been provided. Despite these operational errors, the tabulation from the county appeared correct, because it was based on the aggregated totals rather than the CVR and ballot images, which differed, but were internally consistent. 

These issues were detected not when the ballots were evaluated by AuditEngine, but rather during the metadata analysis phase.

We have also recently audited Bartow County, GA, which uses Dominion Voting Systems equipment and software. Also, during the development of the platform, we performed audits of elections in Dane County, WI, Wakulla County, FL, Leon County FL and San Francisco, CA.

You can read the case study report of three counties in FL and associated explanation videos on this page: https://copswiki.org/Common/M1970. Audits of two counties in GA and Dane County, WI are also available for 

With that said, we must admit that AuditEngine is relatively new technology and the election field is highly non-standardized with proprietary voting systems and a vast number of different ballot layouts and conventions. Therefore, we do occassionally encounter a new sitation that requires additional software development or configuration changes.

## Q: How can we trust the result of the audit by AuditEngine?
A: The premise of AuditEngine is complete transparency. We turn a black box into a transparent box. 

The AuditEngine auditing system is simple in concept. We read the vote off each and every ballot image, and create an independent tabulation. Our system provides complete transparency, so you can take any ballot and follow it through the system. The system will find "disagreements", where the audit system interpreted the marks on the ballot differently from the voting system used by the jurisdiction. We will be able to manually inspect those ballot images and confirm how those ballots should be interpreted, and if we want, dig into the paper ballots and find those exact ballots. 

When we disagree with the voting system, AuditEngine correctly interprets the marks about 93% of the time, according to our recent case study in Florida, whereas the voting system interprets the same marks only 7% of the time. Typically, the disagreements are fewer than 0.25%, a quarter of one percent, depending on whether the voting system results were heavily manually adjudicated. Audit Engine tends to find incorrectly interpreted undervotes, where the voter made a mark that was intended for the candidate but was not sufficiently in the bubble. AuditEngine uses an "adaptive threshold" method which evaluates the marks based on other marks on the same ballot and the relative darkness or lightness of the ballot itself.

## Q: How do we know the ballot images have not been altered?

   1. The proper ballot images from the election department, as exported by the "Election Management System" or EMS must be uploaded to the secure cloud data center used by AuditEngine. After being uploaded, the hash values are easily read in the listing of each file without any further processing. These hash values can be compared with the values produces with similar calculations by election officials to confirm that the image files are the same. The use of these secure hashes is commonplace and a well respected methodology. <p>The following references provide an overview of hash functions and their use in the Federal Rules of Evidence:
      * "Why Hash Values Are Crucial in Evidence Collection & Digital Forensics" -- https://blog.pagefreezer.com/importance-hash-values-evidence-collection-digital-forensics
      * Federal Rules of Evidence FRE 902(13) and (14) -- https://www.foley.com/en/insights/publications/2017/12/new-federal-rules-of-evidence-90213-and-90214 <BR><BR>
   2. The second level of this question has to do with whether a hacker has modified the images before they were captured by the election department, perhaps using a virus inside the voting machine itself. This may indeed be a hazard in the future when ballot image audits become commonplace. But in recent elections, no one expected a ballot image audit to be performed, and so if you assume a hacker or compromised insider wanted to modify the election, they would likely just modify the numbers in the election result (in the EMS database) rather than go to all the trouble of modifying the images, which is indeed a lot of work and may be obvious when the images are inspected. So for now, we can largely ignore the possibility that anyone would go to this expense.
      * If the ballot image audit finds no inconsistencies, one option is to perform an independent rescan of the ballots using high-speed scanners that are not used in the election process, process those images using AuditEngine, and then compare the result of the tabulation on those batches. This process would detect any image manipulation that would alter the result of any contest.
      * Furthermore, we at CitizensOversight are working to include cybersecurity measures to allow us to detect any modification of ballot images once they are produced. At this time, these measures have not been adopted in the standards nor incorporated by voting machines. We view such hacks at the time the image is created to be very unlikely, particularly if the image is scanned using commercial off-the-shelf (COTS) scanners that are not purpose-designed as a voting system.<BR><BR>
   3. Even while knowing that modification of the images is very unlikely, we do advise that some paper ballots also be inspected and compared with the images to provide further confidence. Today, most districts perform a limited audit of the paper ballots. That audit also verifies the ballot images, because the images are used by the tabulators to determine the vote on each ballot. We also suggest that if AuditEngine finds batches that have disagreements in terms of voter intent, the paper ballots can be checked by locating the paper ballot and inspecing and compariing it with the ballot image. Doing this a few times provides a good sense that the ballots are indeed well organized and there is a correspondence with the ballot images.
   4. If a thorough hand count is performed, checking the result of that hand count on a batch-by-batch basis can help to eliminate the possibility that: 1) the hand count was incorrectly performed, 2) the hand count results were modified, and 3) the ballot images were modified (of course to the extent any hand count reviewed those ballots.) Thus if a hand count covered only one or two contests, then those contests can be compared with the results of the ballot image audit (which covers all contests.)  In theory, image manipulation could occur in just those contests not hand counted, but modification of down ballot contests by modifying the images is even less likely.<BR>
   5. What we tend to find quite often is that there are inconsistencies in the ballot images in terms of the raw counts of images, if 1) some ballot images were copied twice into the set, 2) some ballots are rescanned to produce duplicate ballot images, or 3) some ballot images are missing when they are not uploaded to the EMS. (We found these exact problems in the Volusia 2020 General election, covered in detail by our case study results, read more here: https://copswiki.org/Common/M1970).<BR><BR>

## Q: Are there aspects of the election that AuditEngine does not include?
**A: Yes.** AuditEngine provides a consistency check between the ballot images, which are made very early in the tabulation process, and the official results, which are at the very end. Thus, it can detect most issued such as errors or malicious changes between these two checkpoints. It does not include many aspects of the election that do deserve scrutiny, such as voter registration, voter eligibility, paper ballot alteration, ballot harvesting, signature validation, campaign finance, inappropriate advertising, etc. The consistency check from ballot images to final result eliminate some of the most obvious security hazards. As we continue to develop AuditEngine, we will also be adding additional components where the horsepower of the cloud is beneficial.

## Q: Does AuditEngine ever fail to process ballot images?
**A: Yes.** We find that some ballot images are distorted and poorly created by the voting system.  This is particularly true with some older ES&S equipment. In those cases, the images can be reviewed by human eye to determine the vote if they are legible.

## Q: Do you need ballot masters for each style prior to running AuditEngine for a given election?
A: No, AuditEngine can operate without ballot style masters. However, we can generate the target maps much more easily if we have them, and with fewer human error mistakes. 

AuditEngine derives style masters from the images themselves, so it is not necessary to have all the ballot masters for each style. The helper app "TargetMapper" is then used to map the targets on the ballot to each style, contest and ballot option. If we can get the Ballot Style Masters, which are PDF files in "searchable" format, we can more easily extract the exact locations of each one of the target ovals and the associated text on the ballot. There is still an abbreviated manual process using the TargetMapper app to pair up the text used on the ballots and the text used in the cast vote records.

## Q: How much time do you need in advance of the election to set up AuditEngine?
A: For audits conducted by the public using publicly available information, AuditEngine is typically deployed after the election when the results and ballot images have been finalized, or at least semi-final results have been published. However, it is helpful to have some experience with a given area and the specific methods used in any given jurisdiction by prior audits. By getting the Ballot Style Masters in advance, the Target Mapping phase can be accomplished prior to the election and be able to quickly process the ballot images.

When we are working with election districts and quick-turnaround is important, it is best if we are provided with ballot images and CVR from the Logic and Accuracy Test (LAT) with the Ballot Style Masters and create the mapping prior the the election. Then, when the election results are finalized, the system will be fully configured to accept the live data and produce the results.

## Q: Does AuditEngine also audit "Ballot Marking Device" (BMD) ballot summary sheets?
**A: Yes. Audit Engine "reads" the printed text rather than the barcodes.** BMD ballots are those printed by systems that incorporate touch screens to allow the voter to make selections, followed by printing a voted selection summary card. This card, or sheet, includes linear or 2-D barcodes that provide a machine-readable representation of the selections by the voter. These barcodes typically are difficult if not impossible for voters to verify, and instead voters can only verify their selections in printed text. Thus, the part verified by the voter is not read by voting systems. AuditEngine stands alone in the field of ballot image auditing offerings because we perform OCR on the printed selections to determine the vote on the ballot rather than relying on the barcodes. Because we compare that result with the official result in the Cast Vote Record, this essentially puts a check on the possibility that the barcodes might say one thing while the text says something else.

## Q: What voting systems do you support?
Currently, we support the two leading voting system vendors, Election Systems & Software (ES&S) and Dominion Voting Systems, and we are working to also support Hart Intercivic. We prefer to the latest generations of these systems which provide a ballot-by-ballot cast-vote-record (CVR) report of the voting system results so we can compare with the voting sytem down to the ballot. The older Dominion and ES&S systems do not provide that level of reporting even if they provide ballot images, and although we can process the images to product an overall tabulation, we can't compare on a ballot-by-ballot basis.

## Q: How many people are involved in doing an audit?
We need at least one auditor to be in charge of each audit, plus a number of workers who can help with the mapping and adjudication process, to the extent those are required, and any number of observers. The amount of work required is highly dependent on the sheer number of ballots and the smallest margin of victory. If the margin of victory is fairly large, and if we find a relatively small number of disagreements, we may not need to review them all to conclude that the result is consistent. On the other hand, with a very close margin, every disagreement will need to be reviewed. If there are also a large number of write-ins, this can also increase the amount of work involved. At this stage, we are still evaluating how many people are needed in general.

With that said, we encourage the process of each stage of the audit to be witnessed by a set of interested parties in an observers panel, so they can have all their questions answered and the process can also be livestreamed to the public.

## Q: Is AuditEngine "open source"?
Although AuditEngine uses a lot of open source software and we endorse standardization, at this time AuditEngine is not fully open source software. We are reviewing our options but at present we believe the most important aspect is providing "open data" transparency, so that anyone can check the data at each stage of the process. Open Source software works best when the users of those software modules are programmers who can then actively work to improve them. The users of AuditEngine are not programmers, and so providing open source software would not help verify the accuracy of the audit result. Plus, since the software runs in the cloud, it is very hard to prove that it is not changed from the open source that may have been inspected. Our philosophy is that it is more important for the data to be is open, and can be checked at intermediate locations along the way. 

AuditEngine is designed to operate in a number of discrete stages. Each stage processes some input data and creates output data. Any ballot can be checked in any stage, and any ballot can be checked with a detailed single-ballot report.

AuditEngine has been run now on many millions of ballots, and any edge cases are quickly exposed in the operation of the software itself.

There is another aspect of open source which is perceived as a benefit in most situations: code sharing. Thus, in the open source world, if something has been developed it is commonly reused for many other purposes. Much of the code that comprises AuditEngine is single-purpose software. If it is reused, it will be reused for the same purpose by another entity. 

We believe it is more beneficial that this software is not shared and instead, any another entity should develop their own auditing software which will have different characteristics. Using both auditing systems on the same elections provides the opportunity to compare the results of the two (or more) independently designed systems. This is a beneficial competitive process while sharing the underlying code does not provide this cross checking.

## Q: How is AuditEngine funded?
We are pursuing a grass-roots funding model, where we can do fundraising for each audit from the general public, rather than relying on contracts with the same government entities we are auditing. We believe such contracts, unless carefully constructed, will result in the auditors preferably providing high scores to their clients. We believe that the cost of operating AuditEngine is low enough so that the public can fund each audit due to the interest in having an independent review. Please donate today!

# Frequently Asked Questions (FAQs) about Election Records in General

## Q: Can there be more records in the CVR than in the official results?

Yes, they SHOULD line up, except that sometimes the CVR is slightly reduced IF they decide to withhold records. This can happen for specific people, like judges or other elected officials that may subject to persecution or doxing.

However, there is another more likely scenario.

Sometimes, there is a two-sheet ballot for mail-ballots, and then for those mail ballots, they actually get two line items in the CVR. If they denote mail ballots, compare non-mail ballots with mail ballots line items. You might see

```
    xxxxxxxxxxxxxxxx---------------xxxxxxxxxxxxxx     non mail ballot
    xxxxxxxxxxxxxxxx-----------------------------   \ mail ballot  pair.
    -------------------------------xxxxxxxxxxxxxx   /
```

`x`'s if the contest appeared on the ballot and the CVR will show a vote (1 or 0 or a name) and dash `-` where the contest did not appear on the ballot. Hand-marked ballots can contain only so many contests, and then they use another sheet. The example above is pretty typical, where there are a set of contests at the top of the ballot (perhaps with some gaps), followed by a large gap (local contests) and then at the end, statewide propositions and ballot questions.

You can also research this by finding the number of non-mail ballots, subtracting from the total and then comparing the balance (divided by 2 probably) to see if it matches. That works ONLY if all mail ballots had the same number of sheets.

The first gotcha here is that not everyone sends in both sheets, and so this number can be a little bit off. Sometimes the election office will force all ballots to have two sheets, adding an additional blank sheet for the missing one. Then also, sometimes family members will mix up the sheets. Sheet 1's in the same envelope and sheet 2's in the other one. This is why it is really good to try to keep the sheets down to just one. And there is another wrinkle is when only some precincts have 2 sheets while others have only one (or three or more!)

There is another way they sometimes fiddle with this IF you have very few BMD or DRE (machine tabulator) ballots. I've seen them "cut up" the non-mail ballot CVR record so it looks like a mail ballot pair. This was encountered in Collier County, FL, where they had 78 BMD ballots (very few) and the total number of CVR records was off by 39. Middle of the night we realized that 39 is 78/2. They had repeated the BMD records in the CVR in the same form as the nonBMD records. Then they were right on the dot.

This is why election analysts need to be careful because there ARE legitimate reasons for discontinuities. And thank you for  asking. It gets harder when the number of sheets grows.

And be aware, `sheet` and `page` are different. A `page` is one side of a `sheet`. That is how we number pages in a book. But commonly we interchange page to mean sheet in colloquial usage. Avoid that.

You may appreciate this glossary of terms: https://auditengine.org/docs/user-guide/glossary/




<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />

# Glossary


In the definitions below, lower-case terms are specific to AuditEngine and are not defined elsewhere, whereas Capitalized terms are used by the election integrity field, except for proper names of AuditEngine applications and components. Terms provided here have special or important meaning for AuditEngine. 

A general set of election terminology can be found at this URL: [https://www.eac.gov/sites/default/files/glossary_files/Glossary_of_Election_Terms_EAC.pdf](https://www.eac.gov/sites/default/files/glossary_files/Glossary_of_Election_Terms_EAC.pdf) 

<h3 id="adaptive-thresholding">Adaptive Thresholding</h3>


AuditEngine uses a methodology called "adaptive thresholding" which can adjust the mark recognition thresholds based on the habits of the voter and the darkness of the scanned image. This methodology is used when marks are recognized from the ballot, and determines whether there is a mark at the target location. But it does not work if there are very few targets on the ballot, or if there are very few marks by the voter, and in those cases it is not used. See also _[Evaluation Heuristics](#evaluation-heuristics)_ which are used to evaluate whether the marks resolve into votes whether the contest is _[Overvoted](#overvote)_ or _[Undervoted](#undervote)_. AuditEngine uses sets of larger and smaller evaluation areas to catch most circles and checks that are outside the _[Target](#targets)_ symbol but are obvious voter intent.

<h3 id="adjudicated-modified-record">Adjudicated / Modified Record</h3>


For some [voting systems](#voting-system), such as _[Dominion](#dominion-voting-systems-dominion)_ when the JSON style CVR is used, the _[CVR](#cast-vote-record-cvr)_ may provide not only the original evaluation of the [ballot](#ballot) [sheet](#sheet), but also a 'modified' record which includes all the contests on that sheet, and may be modified. The 'modified' record may modify zero or many contests on that ballot sheet after human-eye review by election staff. If the modified record does not show a change in a given contest, it is not possible to know from that record if the contest was inspected and confirmed or not.

<h3 id="adjudication">Adjudication</h3>


This is the process of human review of ballots or ballot images and providing an interpretation of the vote on that ballot. _[Dominion](#dominion-voting-systems-dominion)_ has an adjudication module that facilitates adjudication by election staff. AuditEngine also has an _[AdjudiTally App](#adjuditally-app)_ that can help fine tune the results obtained by AuditEngine.

<h3 id="adjuditally-app">AdjudiTally App</h3>


This component of AuditEngine is a browser-based application that provides a user interface to check any ballot, particularly flagged contests or comparison results that are disagreed. The AdjudiTally App has a number of modes that operate from the same interface. It can be used to: 



* select between the evaluation by AuditEngine or the evaluation by the voting system (per the CVR) by selecting the evaluation which is correct or entering it from scratch.
* fine-tune the results by AuditEngine without any voting system results by reviewing any records that have been [flagged](#flagged) for further review.
* review ballot images without any results by AuditEngine or the voting system.
* view ballot images and tally the results either by a single person or by a crowd-sourced team.

<h3 id="amazon-web-service-aws">Amazon Web Service (AWS)</h3>


This is a cloud-based service provider that provides a range of services for storage of digital data ([S3](#s3)) and compute services ([Lambda](#lambda)), among others that are used by AuditEngine. In particular, AuditEngine uses up to 10,000 Lambda compute instances in parallel to quickly process 100,000s or millions of ballot images.

<h3 id="archive-zip-archive">Archive / Zip Archive</h3>


A single file which can contain many smaller files and also may compress them. This makes it easier to handle a lot of separate small files and also usually saves a lot of space on the disk because files consume at least one block, and the last block in a file is partially empty. Archives pack all the files together into one file without any empty space.

Most importantly for this application is that archives make it easier to handle many thousands of individual files by grouping them together into a small number of archives. We require that you use the open source standardized "ZIP" archives, because the files can be individually extracted from the archive without extracting them all. The free application "7-zip" from[ 7-zip.org](https://7-zip.org/) is a very good tool, but <span style="text-decoration:underline;">use the conventional zip format and not the proprietary 7z format</span>. We recommend that up to about 50,000 ballot images are placed into the same archive, and they should be between about 5GB and 10GB in size for easy handling.

<h3 id="auditengine-app">AuditEngine App</h3>


AuditEngine provides a user-friendly application that runs in the user's browser that assists with the aspects of running a job. To use the App, you must have an account and be authorized for the given activities. There are a number of menus that can be summarized as follows:



* **Districts** -- A district is normally either a County or it may be an organization that wishes to use AuditEngine to process their organizational election. Each district has contacts and a location. Each district can have a common uploading area and a fixed link used for uploading. 

* **Elections** -- Within a district, elections can be defined. An election has a name and a date, and a related District. An election also has a number of files that must be uploaded from or by the District, including Ballot Image Archives, CVRs, Ballot Style Masters (BMS), etc. The uploading from a given district first goes to an upload folder before it is "adopted" and combined with a given election. AuditEngine has a convenient uploading function which allows the user to request the uploading of any number of files and then come back later, as long as the browser window remains active. 

* [Audit Jobs](#audit-job) -- For a given District and Election, there can be one or more Audit Jobs, and these will use the data uploaded to the Election. A given Audit Job will have a [job_name](#job_name) and consists of a number of [Phases](#phase) and [Stages](#stage) in a [Pipeline](#pipeline). The Audit Job will also have a [Job Settings File](#job-settings-file) to configure the job. 

* Users -- There is also the concept of Users, who can be related to a given district or Election, and each has permissions that can be adjusted to allow users to observe or assist in the audit.

<h3 id="audit-job">Audit Job</h3>


For a given election in a given district, there can be one or more Audit Jobs. An audit job tracks the specific _[stages](#stage)_ completed in the processing _[pipeline](#pipeline)._ Each Audit Job for a given election will have a unique _[job_name](#job_name)_.

<h3 id="audit-phase">Audit Phase</h3>


A logical major step in the pipeline, which consists of a number of _stages_, and where those stages can be grouped into a logical concept. To conduct [Ballot Image Audits (BIAs)](#ballot-image-audit-bia), Audit Engine uses at least 4 and sometimes 8 phases. A given workflow may use more than one audit for a given election, starting with an audit of the [Logic and Accuracy Test (LAT)](#logic-and-accuracy-test-lat) data and using that to set up AuditEngine to be ready for the live election data when using a [Cooperative Workflow](#cooperative-workflow).

The basic phases are:



1. Setup and Upload Live Election Data, Perform Consistency Checks
2. Create Style Templates and Map the Styles using live election data.
3. Vote Extraction -- recognize the votes on all ballots, including BMD ballots primarily with the stage [extractvote](#extractvote)
4. Comparison and Reporting -- See [cmpcvr](#cmpcvr)
5. (optional) Scan Verification Batches and perform extraction and comparison.

If _[Cooperative Workflow](#cooperative-workflow)_ is used, then there are 2 to 4 preliminary phases using [Logic and Accuracy Test (LAT)](#logic-and-accuracy-test-lat) data.



1. Setup and Upload LAT Election Data, Perform Consistency Checks
2. Create Style Templates and Map the Styles using LAT data.
3. (optional) LAT Vote Extraction -- recognize the votes on all ballots, including BMD ballots.
4. (optional) LAT Comparison and Reporting
1. Setup and Upload Live Election Data, Perform Consistency Checks
2. (not used -- already done) Create Style Templates and Map the Styles using Live Data.
3. Vote Extraction -- recognize the votes on all ballots, including BMD ballots.
4. Comparison and Reporting
5. (optional) Scan Verification Batches and perform extraction and comparison.

<h3 id="ballot">Ballot</h3>


Generally a presentation of contests and options for each contest that can be selected by a voter, and the recording of those selections. The word "ballot" originally meant "little ball" and these were placed into a box to represent the votes of each person. In practice, a complete ballot may be a number of [sheets](#sheet), each with a front and back side, also called _[pages](#page)_. However, in many instances, the term "ballot" may also be used to refer to a single sheet. Thus, "Ballot Images" should technically be "Ballot Sheet Images" because when there are multiple sheets, each image is only one sheet of the combined ballot. Sometimes, a ballot image is only of one side of one sheet (one page).

See _[Ballot Image](#ballot-image)._

<h3 id="ballot_id">ballot_id</h3>


A unique designator used by the voting system to refer to a specific ballot. It is either an integer or a compound value with parts. [ES&S](#election-systems-&-software-es&s) uses integers from 1 on up. [Dominion](#dominion-voting-systems-dominion) uses a three-part number separated with underscores, like 02438_00043_293456, where the first part is the tabulator number, the second part is the batch processed by that tabulator (starts at 1) and then the final number is the RecordId, which sometimes starts at 1 and increments and other times is pseudo-random. This term is defined by AuditEngine. There may be gaps in these numbers and they are likely also defined randomly, esp. when ballots are cast in-person. 

<h3 id="ballot-anonymity">Ballot Anonymity</h3>


Privacy of the vote is an important goal of democratic election systems. This can best be defined as ballot anonymity, such that any ballot cannot be paired with the voter. Court cases that have examined this issue have concluded that it may be impossible to obtain absolute anonymity of all votes if they are cross-referenced with other data in a handful of other cases. For example, if only one voter votes in a specific precinct, using other data regarding who voted in that precinct can reveal who that voter is. But using only the ballot image data and the cast vote records, on their own, cannot be connected to any voter. Even if the voter writes their name on the ballot, we don't know if they wrote their name or someone else wrote their name on a different ballot. 

Because there are these edge cases where the linkage between the voter and their ballot could be established if additional information were available, AuditEngine specifically does not process the _[List of Registered Voters](#list-of-registered-voters)_ nor the _[List of Voters Who Voted](#list-of-voters-who-voted)_, within the operation of a ballot image audit, except to compare the aggregate numbers. The total number of voters that voted should be less than or equal to the number of registered voters and should be equal to the number of [ballot image](#ballot-image)s and the number of [Cast Vote Records](#cast-vote-record-cvr).

<h3 id="ballot-image">Ballot Image</h3>


Election systems today create digital pictures of both sides of each ballot sheet. These images can be exported by the [Election Management System (EMS)](#election-management-system-ems) in standard formats, such as PDF (Adobe Portable Document Format, used by [ES&S](#election-systems-&-software-es&s) generally with both the front and back in the same file), multipage TIFF (Tagged Image File Format; [Dominion](#dominion-voting-systems-dominion) uses these, with three pages in one file, the front, back and AuditMark(tm) graphical image of the voting system evaluation), or PNG (Portable Network Graphics; [Dominion](#dominion-voting-systems-dominion) uses this format, typically with all three pages combined into a single tall image.)

Please note that the term "Ballot Image" has a deprecated meaning. Previously, it was used to mean digital inputs by the user at a _[Direct-Recording Electronic (DRE)](#direct-recording-electronic-dre-voting-machines)_ machine or another touch-screen machine. The term "image" is used in computer science to sometimes mean an exact copy of digital data. This prior use is now deprecated and the term is now widely understood to mean the actual digital pictures of the document rather than just a copy of digital data that does not represent a picture.

<h3 id="ballot-image-audit-bia">Ballot Image Audit (BIA)</h3>


A review of digital images of ballots in a jurisdiction of an election and comparison with the official outcome for each ballot, group of ballots (precincts or batches), or the entire jurisdiction. AuditEngine is a platform that can provide the computerized and human-interface processing for such an audit.

<h3 id="ballot-marking-device-bmd">Ballot Marking Device (BMD)</h3>


Typically a touch-screen interface with a printer which allows the voter to select the desired option for each contest, and then print out a _[ballot summary card](#ballot-summary-card)_ with those options printed on it, typically also with _[barcodes](#barcode)_ or _[QR Codes](#qr-code)_ that provide the votes of the voter. This print-out is later scanned to produce the _[cast vote record](#cast-vote-record-cvr) _for that ballot. Some BMDs print a ballot layout in the same format as a hand-marked paper ballot and cannot be easily distinguished from it rather than a ballot summary card.

Election officials may choose to use BMDs to reduce ambiguity of what is voted, including write-ins, because those are keyed in. However, BMDs provide lower verifiability. Voters tend not to check the printed ballot summary card for accuracy and the QR Code could potentially be different from what is printed. Also, there is also no way to verify that all the contests and options were presented to the voter in their private voting session by looking at the ballot itself. In contrast, a [hand-marked paper ballot](#hand-marked-paper-ballot) provides all contests and options in printed form and can be verified. Since the BMD device does not have any internal memory and produces a durable paper record, they are an improvement over _[Direct Recording Electronic (DRE)](#direct-recording-electronic-dre-voting-machines)_ devices.

For [ES&S](#election-systems-&-software-es&s) and [Dominion](#dominion-voting-systems-dominion), they use _[barcodes](#barcode)_ or _[QR Codes](#qr-code)_, respectively, which unfortunately cannot be easily verified by the voter. Therefore, AuditEngine does not use the barcodes or QR Codes and instead uses _[OCR (optical character recognition)](#optical-character-recognition-ocr)_ to read the selections from the human-readable summary, and this will detect the possibility that the barcode or QR code does not express the selections of the voter.

<h3 id="ballot-style">Ballot Style</h3>


A designation that represents the set of contests on the ballot, the language and in the case of a hand-marked paper ballot, the order voting targets. The contests on the ballot are determined by the voter's address and party affiliation, in the case of partisan elections where ballots differ by party. There may be 100s or 1000s of styles in any given election in a single jurisdiction. The method for designating style is one of the most complex aspects of a ballot image audit, because there are many variations that are up to election districts, while, which we call the is 

To deal with these many variations, AuditEngine has a number of additional terms:

**_[card_code](#card_code)_**  - the actual encoding on the ballot determined by the [Election Management System (EMS)](#election-management-system-ems) and usually unknown to election workers.

**_style_num_** - an integer that represents a given style, and may be either exactly the _card_code _or a deterministic conversion of that code. 

**_[hexstyle](#hexstyle)_** - a useful representation that avoids arbitrary numerical assignments of the _style_num_, and represents only the set of contests used on the ballot.


**_pstyle_num _** - a printed style designation, usually a more human-friendly representation than _style_num_ but with (usually) a 1:1 correspondence with the _style_num_. The _pstyle_num_ can be extracted from the ballot using Optical Character Recognition (OCR) or from a [barcode](#barcode) printed on the ballot. OCR is not perfect and errors may cause critical errors if misread. 

<h3 id="ballot-style-masters-bsms">Ballot Style Masters (BSMs)</h3>

PDF files in "searchable" format that are normally sent to the ballot printing contractor for printing of ballots in their final usable form. These files are used by the _[TargetMapper App](#targetmapper-app)_ component of AuditEngine to simplify the process of _[Mapping](#mapping)_ the ballot styles. Mapping provides the location of each active target oval or rectangle which is darkened by the voter to express their voting intent and associates it with the contest and option as specified in the _[cast vote record (CVR)](#cast-vote-record-cvr)_. Preferably, these masters should also include the timing marks and any barcodes to allow the extraction of the encoded style information. However, TargetMapper can operate without these if there is a legible style indication on the ballot that is unique for each style.

<h3 id="ballot-summary-card">Ballot Summary Card</h3>

BMDs use a touch-screen interface and usually produce a Ballot Summary Card which includes [barcodes](#barcode) or [QR Codes](#qr-code) that encode the vote so it can be quickly read by the [EMS](#election-management-system-ems) after scanning. Ballot Summary Cards also provide human-readable text under the barcodes so the voter can verify their vote. But most do not provide an easy mechanism for voters to verify that the barcodes correctly encode the vote.

<h3 id="ballot-variant">Ballot Variant</h3>

A term used in the comparison process. If a complete sheet is blank or if the image was detected as corrupted, then this is classified as a ballot-variant. See also _[Contest Variant](#contest-variant)_ and _[cmpcvr](#cmpcvr)_.

<h3 id="ballots-cast-number-of">Ballots Cast (Number of)</h3>

A ballot is "cast" when the ballot is inserted into the scanner or ballot box when voting in person, and when it is received and accepted as valid for absentee or mail voting.

Determining the number of ballots cast by looking at the ballot images can be difficult if there are multiple sheets. At times, voters do not return all sheets. A close count can be by the first sheet only. However, if anyone does not return the first sheet and returns only the second sheet, then it may be impossible to correctly calculate the number of ballots cast based on the ballot images provided. It is important to compare the official count of Ballots Cast to the _[List of Voters who Voted](#list-of-voters-who-voted)_, combined with the count of _[protected voters](#protected-voters)_ that are not on that list.

<h3 id="ballot-indexing-file-bif">Ballot Indexing File (BIF)</h3>

This term is used only in AuditEngine to refer to indexing and [metadata](#metadata) files that are generated to fully index the ballot images, cast vote records, and metadata derived from those sources as well as a preliminary examination of ballot image to extract data in barcodes and in specific areas as metadata. Such an index can be compared to the index card system used in libraries to locate a given printed resource, and also provide some _[metadata](#metadata)_ about the resource, such as in a library whether it is a book or video, number of pages, author, etc.

There are the following forms:


* **bia_bif: **ballot image archive ballot indexing file - this includes the ballot_id, where the ballot image can be found for each sheet (which archive and the path name) and any other metadata that can be derived by reviewing the list of ballots in ballot image [archive](#archive-zip-archive) ZIP files. This includes whether the ballot image was found to be repeated. 

* **cvr_bif: **location of [CVR](#cast-vote-record-cvr) record within CVR files, and metadata available from the CVR record for each ballot sheet. 

* **biacvr_bif: **These are joined into a single set of indexing records organized by the same order as the ballot image archives. 

* **blt_bif: **These records are of the data derived by examining the ballot images but not extracting the votes. It includes _[card_code](#card_code),_ *pcounty* (printed county name, if available), and possibly *pstyle* printed style designation,  *pprecinct* - printed precinct designation. This set of records is not always separately saved, but is simply combined with the biacvr_bif to create the full_bif. 

* **full_bif: **This is the full set of indexing records, which may be the same as the *biacvr_bif*, if the data from the *blt_bif* is not included, or it may include the data from the full preliminary ballot image examination (*blt_bif*). From this set of records, the stage *create_bif_report* can be run so as to provide a full report of the metadata derived across the data available.

<h3 id="barcode">Barcode</h3>


A machine-readable graphical artifact, typically linear in form, commonly printed on [BMD](#ballot-marking-device-bmd) ballots. _[ES&S](#election-systems-&-software-es&s)_ uses "Code-128" barcodes which can represent all 128 ASCII code characters (numbers, upper case/lower case letters, symbols and control codes). Code-128 is a linear barcode with vertical bars where the width of the bars and spaces determines what the bars encode. Three bars and three spaces encode each character. There is also a check digit that can detect if the barcode is corrupted.

AuditEngine does not rely on the barcodes to determine the votes on a [BMD](#ballot-marking-device-bmd) [ballot summary card](#ballot-summary-card), but rather reads the printed strings using _[Optical Character Recognition (OCR)](#optical-character-recognition-ocr)_. Sometimes, the term *barcode* is used as a generic term to mean any type of linear or 2-d (2-dimensional) code, such as a *[QR Code](#qr-code)*, or a _Datamatrix_ code which is similar to a QR Code. 2-d codes have superior error detection and correction.

Both [ES&S](#election-systems-&-software-es&s) and [Dominion](#dominion-voting-systems-dominion) use proprietary barcodes to encode the style on [hand-marked paper ballots](#hand-marked-paper-ballot). See _[card_code](#card_code)._

<h3 id="card_code">card_code</h3>


This term is defined by AuditEngine to refer to an integer or binary code encoded on a ballot sheet, sometimes on each side of the sheet, using barcodes or other encoding, which can be used to determine the *[Ballot Style](#ballot-style)*. The _card_code_ might be directly used as the *style_num*, or there may be a conversion utilized. The _card_code_ is generally not exposed to election staff that use the [EMS](#election-management-system-ems) to design the election, and is assigned to ballots by the EMS usually without the knowledge of the EMS user. These numbers are specific to a given county and different counties may use (unfortunately) the same *card_code*s to mean different styles. 

<h3 id="cast-vote-record-cvr">Cast Vote Record (CVR)</h3>


A data file or set of files that provides the outcome of an election, typically broken down to the individual ballot. For [ES&S](#election-systems-&-software-es&s), the CVR is typically a set of Excel spreadsheet files (.xlsx), where each record is an individual ballot [sheet](#sheet) or one [BMD](#ballot-marking-device-bmd) ballot. [Dominion](#dominion-voting-systems-dominion) in their more recent systems uses a variant of the NIST CVR "Common Data Format" and is a set of JSON files or sometimes CSV (comma separated values) files. 

ES&S also uses this term for PDF files that may be provided where each is a written summary of the voting system evaluation of the vote on that ballot, and so we call these "CVR PDF files" while the spreadsheets are "CVR Spreadsheets". Dominion uses a similar record called the "AuditMark(tm)" which is combined with the ballot images as the third page of the TIFF image file.

<h3 id="certification-election">Certification (Election)</h3>


Refers to the official declaration by election officials that the election results are final and accurate. In some states, election audits are conducted prior to certification to allow any errors to be corrected. In other states, audits occur after certification, and there may or may not be any official mechanism to change the outcome. When using [Cooperative Workflow](#cooperative-workflow), AuditEngine can most effectively conduct audits prior to the certification deadline because delays can be minimized. Once certified, candidates or campaigns typically have a short window to request a recount or file a judicial contest. The exact timelines vary by state.

<h3 id="cmpcvr">cmpcvr</h3>


The name used by AuditEngine for the _[stage](#stage)_ of a _[ballot image audit](#ballot-image-audit-bia)_ where the [CVR](#cast-vote-record-cvr) is compared sheet-by-sheet and contest-by-contest with the tabulation created by AuditEngine. This stage creates a number of comparison records, where there is one record per ballot sheet (either _[Fully Agreed](#fully-agreed-sheets) _or _[Partially Agreed](#partially-agreed-sheets)_), and one record per ballot-contest that is classified as a _[contest variant](#contest-variant)_. Ballot-contests that are not considered variants do not have their own record but are included in their parent sheet record. The comparison records are then used to create the _[Discrepancy Report](#discrepancy-report)_, which is the primary output of AuditEngine.

<h3 id="cooperative-workflow">Cooperative Workflow</h3>


When working with election districts under contract, turnaround delay can be minimized using a cooperative workflow. The main feature of this workflow is that 

a) data is available BEFORE election [certification](#certification-election), and 

b) preliminary election design data (which does not include any live ballots) is provided to AuditEngine prior to election day. 

This preliminary data is used to get a jump on the configuration required so no configuration changes are needed to process the live election data.

The components of the Cooperative Workflow include the following:

* We request that election districts take care with Ballot layouts. They should:
    * use the same [Contest Names](#contest-name) and Option Names for contests that are common to multiple counties and different contest names for contests that are unique to any given county.
    * include the county and election name in a <span style="text-decoration:underline;">standard location</span> to allow ballot images from other counties or from other elections to be detected.
    * NOT use colors that will drop out in the scans.
* Ballot Image Files should be exported without "COPY" or other watermarks. See the Exporting Guide for instructions on how to export each file.
* Each county will prepare a _[Hash Manifest File](#hash-value-hash-manifest-file)_ with hash values of each file. We suggest the use of the _QuickHash_ Windows app.
* All data must be directly uploaded to AuditEngine from each county. We can provide an upload link specific to each county which will remain constant from election to election.
* _[Ballot Style Masters (BSMs)](#ballot-style-masters-bsms)_ are uploaded as soon as they become available. This should be very early in the cycle.
* Data from the _[Logic and Accuracy Test (LAT)](#logic-and-accuracy-test-lat) _in the form of ballot image archives (BIA) and LAT CVR plus are uploaded to AuditEngine as soon as these become available, and before election day to allow for configuration of AuditEngine for each county.

AuditEngine can then be configured, including the completion of the [Target Map](#target-map) prior to the election using the LAT data. As soon as ballot images and the CVR are completed in the real election, these files are uploaded. The mapping phase is skipped in the real election audit and the Target Map is imported from the LAT audit. This results in a quick-turnaround of the audit results.

This is in contrast with the _[Public Oversight Workflow](#public-oversight-workflow)_ which occurs after [Certification](#certification-election) with no additional work by election districts other than providing data, and therefore is not turnaround-time optimized.

See also "_[Workflow](#workflow)_"

<h3 id="contest-or-ballot-contest">Contest or Ballot-Contest</h3>


This is a term used in the comparison process. On each ballot cast, there are a number of contests. A single contest on a single cast ballot is a "ballot-contest" and sometimes just "contest" in the context of the comparison report. This is not the entire contest with all votes from all ballots summed, but simply the evaluation of that single contest on that sheet (for that single voter). Frequently, these can be called "votes".

<h3 id="contest-name">Contest Name</h3>


AuditEngine uses the names of contests as defined by the [Cast Vote Record (CVR)](#cast-vote-record-cvr) file when one is available. The [Election Information File (EIF)](#election-information-file-eif) provides these names as used by the CVR and we stick with those when the CVR is available. 

When AuditEngine is used in a state-wide application, counties should cooperate by using the same contest names for statewide or districts that span county boundaries and avoid using the same names when they are specific to one county.

Contest names should differ within the first 50 characters, and we prefer to have contest names differ in more than one character. For example: "Amendment I" and "Amendment II" are hard to tell apart, compared with "Amendment 1" and "Amendment 2" but it would be better to use something like "Amendment 1: Tax Increase" and "Amendment 2: Term Limits" so they differ by more than one character. Avoid long names like: _U.S. Representative in 117th Congress From the 11th Congressional District of Georgia (Vote for One) (NP)_ and consider using a shorter representation like: _U.S. House GA CD-11._

Also please avoid generic names that depend on the ballot style to have meaning. Instead of "Mayor" always add the town, like "Mayor, Town of Albion". True also for positions like Treasurer, Supervisor, Clerk, etc.

<h3 id="contest-options">Contest Options</h3>


The list of voting opportunities in a contest are called _Contest Options_. The options can either be candidate names or Yes/No options for ballot measure type contests or approval contests (such as for judges). The options may include [Write-Ins](#write-in). The _Contest Options_ are defined by the _[Election Information File (EIF)](#election-information-file-eif)_ and are preferably the same as the strings used in the _[CVR](#cast-vote-record-cvr)_. Each option on a _[Hand-Marked Paper Ballot](#hand-marked-paper-ballot)_ will have a _[Target](#targets)_, such as an oval, which can be darkened using a pen by the voter. 

Some states require that the order of the Contest Options will rotate to avoid bias. The Yes/No options are always in the same order.

<h3 id="contest-rendition">Contest Rendition</h3>


A given graphical expression of a contest on a [Hand-Marked Paper Ballot](#hand-marked-paper-ballot) is called a _Contest Rendition_. Normally, contests are designed as a block with the [Contest Name](#contest-name) at the top, a possible description, followed by the _[Contest Options](#contest-options)_. Normally, such a contest rendition will be the same no matter where it is shown on the ballot, unless a different language or option rotation is used. The TargetMapper App will allow the user to link a given Contest Rendition to a Contest Name and Contest Options as defined by the CVR, and when linked, it will be found no matter where it is located on the ballot.

<h3 id="contest-variant">Contest Variant</h3>


A contest variant is a _[ballot-contest](#contest-or-ballot-contest)_ which has [write-ins](#write-in), [overvotes](#overvote), is [flagged](#flagged), or is _[disagreed](#disagreed-contest)_, i.e. if there is any disagreement between the evaluation of the vote by AuditEngine and the official result. ([Undervotes](#undervote) are not included in the set unless they are disagreed.) Contest Variants can normally be summed by contest. Each contest variant has a separate comparison record for each ballot-contest instance.

<h3 id="csv-file">CSV File</h3>


A CSV (Character Separated Values) file is the most widely used format to express tabular data, and is frequently used by AuditEngine as the result and inputs to various Stages in the processing Pipeline. AuditEngine uses the most standard format, which uses a comma between data fields and may include double quotes in the field if there are embedded commas. These files can be read by most spreadsheet programs. A CSV file may also include JSON embedded in a given field if the field contains either a list or dictionary.

All metadata files and votes from AuditEngine are resolved and flattened to CSV File formats.

<h3 id="discrepancy-report">Discrepancy Report</h3>


This is the most important report from AuditEngine, which is the result of comparing the votes extracted by AuditEngine with those extracted by the voting system in the form of the [CVR](#cast-vote-record-cvr). This is a lengthy automatically generated report and includes the following:

* **Introduction** to make sure the reader understands our terminology.
* **[Metadata](#metadata) Summary**: This metadata summary includes comparison counts between the CVR, Images and Cast.
* **Summary of Discrepancy Records**:
    * High-Level Reconciliation by sheets and by contests, including pie charts.
    * Audit-Engine [Flagged](#flagged) Report, by sheet and by contests, including pie charts.
    * [Contest Variant](#contest-variant)s Breakdown, by sheet and by contests, including pie charts.
    * Normal [Disagreed](#disagreed-contest) (No write-ins or overvotes) by sheet and by contests, including pie charts.
    * Non-additive Groups - including Contest Variants, Disagreed, Ballot Variants, uncategorized (should be 0) and Blank sheets.
    * [Ballot Variants](#ballot-variant)
* **Detailed groups**
    * [Write-ins](#write-in) Detailed, by sheet and by contests, including pie charts. Includes both agreed and disagreed writeins. Please note that AuditEngine does not review detailed write-in information as this is normally done extensively by the election office using human eye.
    * [Overvotes](#overvote) detailed, by sheet and by contests, including pie Charts, agreed and disagreed.
    * Gray [Flagged](#flagged) agreed votes.
    * Relevant Settings.
* **Contest Discrepancy Table**. Each contest is summarized as one line in a table, with the following fields:
    * **Total:** Total ballots cast which included this contest with images that were processed by AuditEngine.
    * **Non-Variant:** Ballots with this contest where the official outcome and the evaluation by AuditEngine agreed, and did not include write-ins, overvotes, and were not flagged as 'gray'.
    * **Agreed Overvotes:** Ballots where both AuditEngine and the voting system detected an overvote.
    * **Agreed Write-ins:** Ballots which included write-ins in terms of a marked target, but where the name written-in may not be a qualified write-in candidate, and the write-in may be correctly attributed as a vote for a listed candidate.
    * **Agreed Undervotes:** Undervotes are very numerous and we do not break those down here, and are not included in the discrepancy report unless they are disagreed or gray flagged.
    * **Disagreed:** These are ballot-contests which were not initially evaluated as overvotes or write-ins, and where the evaluation by AuditEngine disagrees with the voting system.
    * **Gray Only:** Ballot-contests where AuditEngine detected an ambiguous mark on this contest or used heuristics to decide voter-intent. This column omits any ballots which are in the columns for write-ins, overvotes, or disagreed ballots, even if AuditEngine internally flags them as gray.
    * **All Variants:** Ballots with Agreed Overvotes, Agreed Write-ins, Disagreed, or Gray Flagged. The number of ballots cast should equal the sum of "Plain Agreed", and "All Variants". The components of this column are highlighted.
    * **Disagreed% of Margin** This provides a good measure of whether the variants may have any impact on the outcome, and the highest five values are highlighted. Further analysis is still required to see if the disagreements will reduce the current margin of victory.
    * **Variant% of Margin** This provides a maximum measure of whether the variants may have any impact on the outcome, and the highest five values are highlighted. Typically, the vast majority (perhaps 90%) of All Variants are Agreed Write-ins and Agreed Overvotes which may only rarely result in any changes in the outcome.
    * **Vote Margin:** This is the margin of victory, i.e. gap between votes for runner-up and winner (lowest winner if contest has multiple winners) among the ballots processed, and may be a subset of the total margin for the entire district if AuditEngine did not receive or process all ballot images.
* **Contest Details**: Each contest is then reviewed in detail. To limit the size of the report, contests are only detailed if they are one of the first 10 contests, the closest 5 contests, or the top 5 contests with the most variants. Also, any contest of interest can be reviewed in detail.
    * CVR results for this contest.
    * Summary of the comparison results for this contest (same as the line in the Contest Discrepancy Report)
    * Disagreed ballots by group, detailed by record types. These are summary tables for each record type. Click on group designation and it will go to the individual records.
        * Normal Disagreed
        * Write-ins
        * Overvotes
        * Gray-Flagged
    * Individual records for each discrepancy. This is a lengthy section which shows the discrepancy record followed by the image of the ballot, front and back. Click on the thumbnail and the full size image is displayed in another window.
* **Precinct Report Summary Table** -- Each precinct is summarized as a single line in a table. Columns in this table are similar to the contests table.
* **Precinct Details** -- Precincts are detailed if they have the highest Disagreed% of Total or highest Variant% of Total.  For each precinct, they are first broken down by group, then detailed to the ballot. Ballots are shown as thumbnails and can be viewed in full resolution by clicking.

<h3 id="direct-recording-electronic-dre-voting-machines">Direct Recording Electronic (DRE) voting machines</h3>


After the Help America Vote Act (HAVA) was passed in response to the year 2000 election debacle, districts began to adopt fully _Direct Recording Electronic_ voting machines which recorded the vote to internal memory only. Because these systems had no paper trail, the vote could be altered or lost and there was no way to check it. In response to this problem, these machines were retrofitted with a _[Voter-Verifiable Paper Audit Trail (VVPAT)](#voter-verifiable-paper-audit-trail-vvpat)_ device, which recorded the votes onto a paper tape that the voter could review. These voting systems are now being retired for [hand-marked](#hand-marked-paper-ballot) or [BMD ](#ballot-marking-device-bmd)voting systems.

<h3 id="disagreed-contest">Disagreed Contest</h3>


As used in the comparison process, a [contest](#contest-or-ballot-contest) is considered "disagreed" unless the voting system (from the [CVR](#cast-vote-record-cvr)) and AuditEngine fully agree on the outcome, including whether it was overvoted, undervoted, or had write-ins. Since write-ins and overvotes are frequently reviewed and adjudicated by election staff, disagreed write-ins and overvotes are treated separately by the AuditEngine analysis. "_Normal Disagreed_" are the rest of the disagreed contests, which do not include write-ins or overvotes, but instead provide the actual difference in the evaluation of the vote cast by AuditEngine vs. the voting system.

<h3 id="dominion-voting-systems-dominion">Dominion Voting Systems (Dominion)</h3>


A major voting system vendor with approximately 37% of the market.

<h3 id="duplicated-remade-rescanned-ballot">Duplicated / Remade / Rescanned Ballot</h3>


Multiple ballot images that are identical to the human eye or are equivalent representations but are digitally different, and will likely have different _ballot_id_s as well. These occur when:

* The original ballot is damaged and will not scan properly
* The original ballot is in a format or language which is not directly supported by the configuration of the voting system.
* Ballots are rescanned, either intentionally or unintentionally, and combined with other images in the set for those same ballots.

For the first two causes, election districts may enter ballots into BMD to create a [Ballot Summary Card](#ballot-summary-card), or carefully transpose the marks to a new [Hand-Marked Paper Ballot](#hand-marked-paper-ballot).

<h3 id="election-information-file-eif">Election Information File (EIF)</h3>


This is a required file that defines many aspects of a specific election in a specific district, including the contests, contest options, write-ins, etc. A draft EIF file is generated from the CVR if it exists. It includes the following fields for each contest in the election. 

* **official_contest_name** - should match the string used in the CVR if it is available. See _[Contest Name](#contest-name)_
* **vote_for** - the maximum number of votes in this contest, default: 1. See [Overvote](#overvote) and [Undervote](#undervote)
* **writein_num** - the number of [write-in](#write-in) options provided.
* **official_options** - list of candidates or yes/no options, not necessarily in the order on the ballot. These strings should match those used in the CVR exactly.
* **bmd_contest_name** - contest names as found on BMD ballots. This may be the same as the official_contest_name but we must have the exact string to ensure accurate [Optical Character Recognition (OCR)](#optical-character-recognition-ocr) of BMD ballot selections.
* **qualified_writeins** - list of qualified write-ins for this contest

This file should be reviewed by the auditing team, particularly to adjust the 'bmd_contest_name's and 'writein_num' to verify that these accurately match the layouts. Note: Other fields exist but are not normally used because most of the definition is not required since we use the [TargetMapper App](#targetmapper-app) to generate the map instead of doing image analysis.

<h3 id="election-management-system-ems">Election Management System (EMS)</h3>


This is the general term for the suite of software applications that provide all the functions needed to assist election officials to perform elections. Functions include the definition of ballots, configuring voting machines that are used in polling locations, central tabulation, and reporting.

<h3 id="election-systems-&-software-es&s">Election Systems & Software (ES&S)</h3>


A major voting system vendor with approximately 47% of the market.

<h3 id="etag">ETag</h3>


Short for "Entity Tag", this is a string of hexadecimal digits (usually _[MD5](#md5)_ format) and possibly a hyphen followed by decimal digits. These are used by cloud storage to allow detection of changes in the files uploaded. AuditEngine can calculate the ETags of local files to know if uploading or downloading is necessary. These are used by the AuditEngine _[Pipeline](#pipeline)_ to know whether a stage needs to be re-run, because the dependencies have changed. See also _[MD5](#md5)_, _[Pipeline](#pipeline), [SHA1 / SHA256 / SHA512](#sha1-sha256-sha512)_, _[Stage](#stage)_

An example ETag as used by AWS S3: **6cf81d4ec591b351adbfb33ed5861b6f-228** It includes a first part, which is the MD5 checksum over a list of MD5 checksums of smaller chunks of data. In this case, there are 228 chunks. As a user of these values, the only thing you can determine is whether they differ.

<h3 id="evaluation-heuristics">Evaluation Heuristics</h3>


AuditEngine first recognizes the marks using the *[Adaptive Thresholding](#adaptive-thresholding)* methodology which employs a number of algorithms to determine the optimal thresholds that are used for each ballot. Once the marks are determined, then there is a stage of evaluating the marks to determine the votes in the contest. If the correct number of marks are detected for the contest, then the marks are directly converted to votes. If there are too many marks, then the contest may be evaluated as an _[overvote](#overvote)_ and if there are too few, it may be considered an _[undervote](#undervote)_. A set of evaluation heuristics are used to attempt to resolve an overvote by one vote and a single undervote. If the overvote is only by one vote, then the marks are evaluated to see if there is a darker scratch-out by the voter, or a lighter hesitation mark. If it is a single undervote, then the algorithm looks for possible light votes. If any attempts are made to resolve these by AuditEngine, the contest is _[Flagged](#flagged)_.

When compared with voting systems without adjudication, AuditEngine resolves 75% to 95% of Normal _[Disagreed Contests](#disagreed-contest)_ when the image has no corruption, and there are no write-ins.

<h3 id="extractvote">extractvote</h3>


This is the primary stage in the audit process where all ballot sheets are individually processed to recognize either the marks made by the voter, if it is a hand-marked paper ballot format, or to perform _[Optical Character Recognition (OCR)](#optical-character-recognition-ocr)_ on the text summary on the [ballot summary cards](#ballot-summary-card) produced by [BMD](#ballot-marking-device-bmd)s. The extractvote processing is delegated to a [fleet](#fleet) of individual compute instances in our datacenter and we are authorized to run up to 10,000 compute instances. See also _[Fleet](#fleet)_, _[Lambda](#lambda)_.

<h3 id="flagged">Flagged</h3>


A contest is _flagged_ by AuditEngine if they include [write-ins](#write-in), are "[Flagged](#flagged)" as ambiguous, that is, if AuditEngine used heuristics to guess on the correct resolution of hesitation marks and cross-outs, in the case of overvotes, or if the ballot images were *[unprocessable](#unprocessed-sheets)* due to damage to the image. AuditEngine can be used to produce its own canvass of the election, and the Flagged contests can be reviewed using the AuditEngine [AdjudiTallyApp](#adjuditally-app) when the margin of victory is close to resolve the flagged contests using human eye evaluation of the images.

<h3 id="fleet">Fleet</h3>


The term "fleet" is used to refer to the set of _compute instances_ (AKA computers) that are used by AuditEngine in certain [stages](#stage) that can be expedited by using parallel processing. AuditEngine currently uses AWS[ Lambda](#lambda) compute instances and we are authorized to use up to 10,000 at a time, but may use only 2,500 instances in parallel and then in rounds, for a given stage. 

Because we are limited to the overall number of instances used at any time, we use a reservation system during critical post-election times when many election districts are conducting audits simultaneously. Each delegation to the fleet typically takes less than 15 minutes, unless we are processing a very large number of sheets. Once one user has released their reservation then another delegation to the fleet can occur.

<h3 id="full-hand-count-audit-fhca">Full Hand Count Audit (FHCA)</h3>


This auditing method simply hand-counts all ballots and creates a total of all ballots cast. It differs from a traditional recount and is considered an "audit" if there are additional controls to limit errors and incremental comparisons on batch or precinct basis, to locate any machine errors. FHCAs are easier to conduct than [RLA audits](#risk-limiting-audit-rla) because there are no statistics required and auditors can make corrections to the results as they go. In contrast, audits that rely on samples (and not all ballots), must not correct the samples as they go, and this is nearly impossible for workers to resist. However, RLA audits, if conducted well, may be able to process a very small sample of ballots if the margins are over 2% to 5%.

<h3 id="fully-agreed-sheets">Fully Agreed Sheets</h3>


In the comparison process, a ballot sheet is classified as _Fully Agreed_ if it has no write-ins, overvotes, or gray-[flags](#flagged), and every contest fully agrees between the evaluation of the voting system and AuditEngine. Such sheets are maintained as a single record. See _[Partially Agreed Sheets](#partially-agreed-sheets)._

<h3 id="gentemplates">gentemplates</h3>


This is an important stage in the AuditEngine processing [pipeline](#pipeline) where individual ballot images of each sheet and each style are combined to create a standard style template of each style. Each sheet has its own style. See also _[Ballot Style](#ballot-style)_, and _[card_code](#card_code)_.

<h3 id="hand-marked-paper-ballot">Hand-Marked Paper Ballot</h3>


A ballot format that provides all the contests and options available for voting by a specific voter on a set of ballot [sheet](#sheet)s, with [targets](#targets) that can be marked by the voter using a conventional pen. This type of voting is not directly usable by voters who are blind or cannot operate a pen. Federal law currently mandates that each polling place have machines that are compatible with the needs of voters with disabilities. Some [BMD](#ballot-marking-device-bmd) devices produce a ballot format identical hand-marked paper ballot even though they are machine marked. These then can be completed by some voters with disabilities using the BMD interface or _assistive devices_. Also known as _nonBMD ballots_.

<h3 id="hart-intercivic-hart">Hart Intercivic (Hart)</h3>


A voting system vendor with a relatively small footprint nationally and produces ballot images. The Hart [BMD](#ballot-marking-device-bmd) format is the same as a hand-marked paper ballot format, so it is not easy to tell that a BMD device was used, they are completely verifiable, and they can be processed without using _[Optical Character Recognition (OCR)](#optical-character-recognition-ocr)_.

<h3 id="hash-value-hash-manifest-file">Hash Value / Hash Manifest File</h3>


A hash value is a fixed-length "fingerprint" of a block of data which is 

1. relatively easy to calculate, 

2. will change substantially if even one bit is changed, and 

3. is infeasible to predict. 


These are typically calculated over a given file. It is infeasible to alter a given file to produce another valid file and also produce the same hash. The receiver of any file can calculate the hash values and compare it with the hash value in the Hash Manifest File to verify that the files are unchanged.

A single "_Hash Manifest File_" can be prepared that includes the file name and a hash value for each file provided in the export of the official results. There are free applications that will prepare a Hash_ Manifest File_ of any given folder.

We recommend the free Windows Application _QuickHash_ to prepare a Hash Manifest File for all the files produced as the result of an election.

<h3 id="hexstyle">hexstyle</h3>


This is a style indicator, originally defined by AuditEngine, to represent the contests included on a ballot. It is represented as a hexadecimal number written with the characters 0-9 and a-f, where each character represents a 4-bit sequence, in the same order as defined in the EIF. Each bit in the sequence is 1 if the contest exists on the ballot of that style, and 0 if it does not. The sequence is left justified, and padded with 0's on the right. So the hexsyle value **0xc003** indicates that the first two contests and the last two contests are on the ballot, and the middle 12 contests are not. The entire binary sequence in this example is **1100 0000 0000 0011**.The characters "**0x**" indicate that it is a hexadecimal number, and "**c**" indicates the bit sequence **1100**, while **3** indicates 0011. 

The hexstyle is a shorthand way to represent the contests on the ballot, which is a primary determinant of style. It does not handle differences in style due to language, or option rotation. There should be only one hexstyle per style_num, but more than one style_num may have the same hexstyle.

The following table provides the hexadecimal characters for each bit sequence.


<table>
  <tr>
   <td>0 - 0000
   </td>
   <td>1 - 0001
   </td>
   <td>2 - 0010
   </td>
   <td>3 - 0011
   </td>
  </tr>
  <tr>
   <td>4 - 0100
   </td>
   <td>5 - 0101
   </td>
   <td>6 - 0110
   </td>
   <td>7 - 0111
   </td>
  </tr>
  <tr>
   <td>8 - 1000
   </td>
   <td>9 - 1001
   </td>
   <td>a - 1010
   </td>
   <td>b - 1011
   </td>
  </tr>
  <tr>
   <td>c - 1100
   </td>
   <td>d - 1101
   </td>
   <td>e - 1110
   </td>
   <td>f - 1111
   </td>
  </tr>
</table>


<h3 id="images-missing">Images Missing</h3>


This is a discrepancy attribute. Sometimes not all the images are provided and so these are accounted for as the number of Images Missing. AuditEngine does not attempt to sum the number of contests nor the votes on ballot images that are missing. If there are a vast number of images missing, this can make an accurate audit difficult.

<h3 id="job_name">job_name</h3>

This is the name of the AuditEngine job to differentiate it from other jobs, and determines where the files are stored. The format of the _job_name_ has been standardized internal to AuditEngine as **ST_County_YYYYMMDD**, where **ST** is the two-character state abbreviation, **County** is the County Name without spaces or special characters, and YYYYMMDD is the the data of the election when the polls closed. It may also have the two-digit country code as a preface, such as "US\_" 

Thus, **GA_Bartow_20201103** is the job for the 2020 General Election in Bartow County, GA. It is okay to add additional tags to the end, like **\_LAT** if it is the job to process the [Logic and Accuracy Test](#logic-and-accuracy-test-lat) ballot images in that same election, or for other purposes. NOTE: The job_name can't be changed very easily once it is set. It cannot have spaces or special characters other than underscore. See also _[Audit Job](#audit-job)_.

<h3 id="job-settings-file">Job Settings File</h3>


For each [Audit Job](#audit-job), there is a related _Job Settings File_. It has the name which is the _[job_name](#job_name) prefixed with the string "JOB\_". It is a csv (comma separated values, i.e. spreadsheet) file and can be edited with any spreadsheet program, but is normally edited through the *[AuditEngine App](#auditengine-app)*. There are a vast number of possible settings that can control AuditEngine when it processes an election. Most of these are to allow AuditEngine to handle ballots from various vendors, and variations we find due to differences in how the [Voting Systems](#voting-system) are programmed. We can summarize these settings into a number of categories:

* **Source Files** -- The locations and names of Ballot Image [Archives](#archive-zip-archive), Verification Archives, [CVR](#cast-vote-record-cvr) files, [BSM](#ballot-style-masters-bsms) Files, and other exports from the [EMS](#election-management-system-ems). These parameters are provided by the _AuditEngine App_ derived from the files that are uploaded. 
* **Election Info** -- Information about the election district used for reporting, such as the official ballots cast, population, registered voters, registration partisan bias, etc. 

* **Layout Info** -- Regions or adjustments to regions where information can be found on the ballot layout, particularly for Hand-Marked Paper Ballot layouts, such as to read the [Ballot Style](#ballot-style), pstyle, pcounty, [Write-in Area](#write-in-area) adjustments, etc. 

* **File details** -- Information to allow metadata to be extracted from the Archives and CVR files. 

* **Execution and Reporting Controls** -- Controls used to select specific precincts, styles, groups, contests, etc. to limit execution and reporting. 


<h3 id="json">JSON</h3>


JSON is an acronym that stands for "Javascript Object Notation". Although this was originally defined for use in the programming language Javascript, it is now the most widely used export format that can express relatively complex and nested data structures, and has supplanted XML in popularity. AuditEngine can import the *[JSON CVR Export](#json-cvr-export)* and it also produces files in this format as the result of various [stages](#stage).

<h3 id="json-cvr-export">JSON CVR Export</h3>


We use this term to refer currently only to the [Dominion](#dominion-voting-systems-dominion) [CVR](#cast-vote-record-cvr) Export that provides records in [JSON](#json) format, roughly following the _NIST Common Data Format CVR standard_.

<h3 id="lambda">Lambda</h3>


AuditEngine is currently deployed to Amazon Web Services (AWS) cloud, and therefore our parallel processing Fleet uses their Lambda service. One Lambda is one _compute instance_ in the Fleet. See _[Fleet](#fleet)_.

<h3 id="list-of-registered-voters">List of Registered Voters</h3>


The published list of voters who are registered as eligible to vote in the election, including persons who are on the "list of inactive voters" is the _List of Registered Voters._ This list as published should not include any _[personal identifying information](#personal-identifying-information-pii) _and may be limited to no more than the voter's name, year of birth, and street address in each record, even though the official record for each voter may include additional information. This list does not include *[protected voters](#protected-voters)*, but the <span style="text-decoration:underline;">number</span> of protected voters that are registered should be provided without listing them. This list should be published to include all voters that were registered as of election day, and include those who registered on election day, and not be further updated (with later registrations) so as to allow for accurate comparisons.

<h3 id="list-of-voters-who-voted">List of Voters Who Voted</h3>


This list provides the list of voters that either: 

* returned an absentee or mail ballot which was accepted for tabulation, or
* checked in at a polling place, even if they left without casting their ballot.

This list as published should not include any [personal identifying information](#personal-identifying-information-pii) and may be limited to no more than the voter's name, year of birth, street address in each record, even though the official record for each voter may include additional information. This list does not include [protected voters](#protected-voters), but the <span style="text-decoration:underline;">number</span> of protected voters who voted should be provided without listing them. For this list to be useful, it must be fully updated, including all voters who voted. It is unfortunately a common practice to not fully update this list as it is commonly used by campaigns in get-out-the-vote (GOTV) efforts and some jurisdictions may typically only update it to include those voters who voted very early but not include the last day or two. 

<h3 id="logic-and-accuracy-test-lat">Logic and Accuracy Test (LAT)</h3>


Voting systems typically are required to complete a "Logic and Accuracy Test" (LAT) by state law, where the voting system is configured and it processes test ballots to check that the mapping of _[Targets](#targets)_ on[ Hand-Marked Paper Ballots](#hand-marked-paper-ballot) and [BMD](#ballot-marking-device-bmd) [ballot summary cards](#ballot-summary-card) are correctly linked to the contest and options as reported in [cast vote records (CVR)](#cast-vote-record-cvr). Essentially, the LAT answers the question: 

Does the voting system (hardware and software) read and tabulate the marks on a ballot or touches on the screen with 100% accuracy?

The test ballots are usually marked uniformly and not with light marks, circles, checkmarks next to the oval, etc. and to fully test the software — NOT to simulate an election. The LAT should also include BMD ballots.

AuditEngine can audit the LAT ballot images by processing them as if they were from an election, and then comparing the ballots with the known good CVR results. This can test the configuration of AuditEngine, and as a side benefit, evaluating the coverage of the LAT test ballots.

AuditEngine can use the LAT ballot images and LAT CVR to create the [Target Map](#target-map) so the actual election data can be processed with faster turnaround. In this mode, it is best if the LAT CVR includes the "[Ballot Style](#ballot-style)" field ([ES&S](#election-systems-&-software-es&s)) and for [Dominion](#dominion-voting-systems-dominion), the JSON CVR export should be used.

Note: For a general treatment of the subject of the LAT test ballots, see[ Guidelines for Creating a Deck of Test Ballots (John Washburn)](https://copswiki.org/w/bin/view/Common/M1993)

<h3 id="mapping">Mapping</h3>

One key _[Phase](#phase)_ in the process of performing a [ballot image audit](#ballot-image-audit-bia) is the mapping of the contests and options to specific [target](#targets) locations on a paper ballot of a specified style, resulting in the _[Target Map](#target-map)_. This _Phase_ includes a number of stages for setting up, processing, and then importing the results from the [TargetMapper App](#targetmapper-app).

<h3 id="md5">MD5</h3>


A popular [hash](#hash-value-hash-manifest-file) algorithm used to detect changes in files due to uploading or downloading errors. It is not strong enough to be used for critical cryptographic purposes, but it continues to be used by cloud storage services in [ETags](#etag) and is generally regarded as "good enough" for those purposes due to the restrictions on file structure. Other stronger algorithms are recommended for critical cryptographic purposes, such as [SHA1 / SHA256 / SHA512](#sha1-sha256-sha512). We suggest using SHA512 for the *[Hash Manifest](#hash-value-hash-manifest-file)* because it is available and is extremely strong, but cloud storage services continue to use MD5.

An example of an MD5 checksum: **f664b587aacae05c8aa5c591b8659ec4**

<h3 id="metadata">Metadata</h3>


Essentially "data about other data", and used to refer to attributes of [ballot images](#ballot-image) and [cast vote records](#cast-vote-record-cvr) that are not votes, such as _[ballot_id](#ballot_id)_, _precinct_, _batch_, _group_ (election day, early, mail, etc), _[sheet](#sheet)_, _[style](#ballot-style)_, file size, _[Archive / Zip Archive](#archive-zip-archive)_ location, etc. Many consistency checks are available by reconciling the metadata from the various sources. See also "_[BIF](#ballot-indexing-file-bif)_".

<h3 id="modified-record">Modified Record</h3>


See '_[Adjudicated](#adjudicated-modified-record)_'.

<h3 id="optical-character-recognition-ocr">Optical Character Recognition (OCR)</h3>


This is the process used by computer software to convert printed text that is scanned as an image into character codes for each character. AuditEngine uses this process to convert the text printed on [BMD](#ballot-marking-device-bmd) _[ballot summary cards](#ballot-summary-card)_ into text to avoid relying on [barcodes](#barcode).

<h3 id="overvote">Overvote</h3>


If a voter marks more than the number of options allowed in the contest, it is considered "overvoted" and no vote is awarded to any option. For example, if the "vote-for" number is 1 and the voter votes for three options, it is considered one overvote.

Overvotes do not occur on BMD ballots.

Very frequently, overvotes are misinterpreted by the voting system and should be fully reviewed in close contests. If a contest has an overvote, it will be first classified as an overvote, even when the write-in target is selected. Some election departments will mark overvotes as an undervote when [adjudicated](#adjudicated-modified-record) if they are confirmed as an overvote. AuditEngine understands this form of adjudication and does not regard it as a disagreement.

<h3 id="page">Page</h3>


One side of a [sheet](#sheet), if sheets are printed on both sides. If a ballot provided to a single voter has 2 sheets, then the pages are numbered 1, 2, 3, 4, for the front of sheet 1, back of sheet 1, front of sheet 2, back of sheet 2. Sometimes pages and sheets are numbered starting at 0, so we have to be careful. If we know the page or sheet will start at 0, we will call it page0 or sheet0.

<h3 id="partially-agreed-sheets">Partially Agreed Sheets</h3>


In the _[cmpcvr](#cmpcvr)_ comparison process, if a ballot sheet has at least one _[contest-variant](#contest-variant)_, then that contest-variant is logically pulled from the _[partially agreed sheet](#partially-agreed-sheets)_ comparison record, and what remains in the _partially agreed sheet_ record are the rest of the non-variant contests. Note that if all contests are considered contest-variants, then the partially agreed sheet will persist as an empty shell with no contests left in it, and all contest variants will be moved to the contest-variants set.

<h3 id="personal-identifying-information-pii">Personal Identifying Information (PII)</h3>


Information normally regarded as personal and private. For elections, it typically includes a person's month and day of birth, driver license number, non-operating license number, social security number or portion of that number, Indian census number, father's name, mother's maiden name, and state and country of birth, email address, or the record(s) of that person's signatures.

Please note that extraneous marks on a ballot are generally not regarded as PII, even if the voter includes their initials or signature on the ballot, because the ballot is [anonymous](#ballot-anonymity) and cannot be linked to any specific voter.

<h3 id="phase">Phase</h3>


See _[Audit Phase](#audit-phase)_

<h3 id="pipeline">Pipeline</h3>


The operation of AuditEngine is divided into a series of [stages](#stage), where each stage has defined inputs (dependencies) and a number of output files. The set of the stages together is called the _pipeline_. Each stage cannot be executed unless its dependencies are available from prior stages.

<h3 id="poll-tapes-digital-poll-tapes-poll-tapes-audit">Poll Tapes / Digital Poll Tapes / Poll Tapes Audit</h3>


Voting machines that are used in polling places typically have a _poll-tape report_ which is printed out by poll workers during an election, and frequently is posted at the polling site with a signed copy turned into the election office. _Digital Poll Tapes_ can be produced by [ES&S](#election-systems-&-software-es&s) voting systems. These are an exact copy of the report produced by the voting system scanner but they are provided as a PDF, LST or TXT files. These files can be processed by AuditEngine to provide another check of the results of the election by comparing the aggregated results for each precinct with the final aggregated report. This audit is not available for [Dominion](#dominion-voting-systems-dominion) systems.

<h3 id="protected-voters">Protected Voters</h3>


These are voters that are not included in the published _[List of Registered Voters](#list-of-registered-voters)_ or in the published _[List of Voters who Voted](#list-of-voters-who-voted)_ because they are protected by statute or enrolled in an address confidentiality program, typically because the person reasonably believes that their life or safety of that or another person is in danger and restricting access will serve to reduce that danger. Although these voters are removed from the other lists, it is helpful to know both the number and precinct number of protected voters who are registered and the number of protected voters who voted without having the exact list, to facilitate comparing the _List of Voters who Voted_ with the _Number of [Ballots Cast](#ballots-cast-number-of)_.

<h3 id="public-oversight-workflow">Public Oversight Workflow</h3>


AuditEngine has been designed to accommodate a "Public Oversight" workflow, where members of the public, candidates, or campaigns can request ballot image and CVR data and conduct audits using AuditEngine independently from the election office. This will likely happen in a slower time frame, because these data are available and the audits are commonly only activated after the election is completed and when there is some question of the outcome. This is in contrast to the "_[Cooperative Workflow](#cooperative-workflow)_", where the election districts are providing data prior to the election to expedite audit turnaround. See _[Workflow](#workflow)_.

<h3 id="qr-code">QR Code</h3>


A 2-dimensional machine-readable graphical artifact consisting of black squares arranged in a square grid on a white background, including some fiducial markers, which can be read by an imaging device such as a camera. They can, in general, be of various sizes and most smartphones have reading ability built into the camera. 

QR Codes are used on BMD [ballot summary cards](#ballot-summary-card) produced by [Dominion](#dominion-voting-systems-dominion) and by the VSAP (Voting System for All People) developed by Los Angeles County, CA. The QR Codes used in the VSAP system can be easily read by a smartphone and the codes compared with annotations on the ballot. The QR Codes used by Dominion are, however, binary in nature and are not readable by a smartphone camera, and are thus not verifiable in the same way that the VSAP codes are.

AuditEngine does not use QR Codes to determine the votes on a BMD ballot summary card, but rather reads the printed strings using _[Optical Character Recognition (OCR)](#optical-character-recognition-ocr)_. Sometimes, the term *[barcode](#barcode)* is used as a generic term to mean any type of linear or 2-d code, such as a QR Code.

<h3 id="redline-proofs">Redline Proofs</h3>


A critical step in the operation of AuditEngine is the creation of the [Target Map](#target-map) using our [TargetMapper App](#targetmapper-app). To check the consistency of this map, we have a consistency check when the Target Map is imported, and AuditEngine creates a full set of "Redline Proofs" which are ballot styles with red outlines and printing on them that shows the location of each [Target](#targets) and the associated CVR [Contest Name](#contest-name). These proofs can be reviewed by human-eye to find inconsistencies. Also shown are Write-in Areas.

<h3 id="repeated-ballot-images">Repeated Ballot Images</h3>


AuditEngine can handle _repeated_ ballot images in Ballot Image [Archive](#archive-zip-archive) / Zip Files. Repeated ballot images can occur if the same ballots are included in two different Ballot Image [Archive](#archive-zip-archive) / Zip Files or if they are included in the same Archive but using different path names. These are detected and moved to a list of "skipped" repeated ballots, while the other ones are marked as just "repeated". These are detected only if the images have the same _[ballot_id](#ballot_id)_, but they may have a different full path name within the archive.

We must distinguish these from _Duplicated / Remade Ballots_, which may result in multiple ballot images that are identical to the human eye but are digitally different, and will likely have different _ballot_id_s as well. Commonly, election districts may enter ballots into BMD to create a [Ballot Summary Card](#ballot-summary-card), or carefully transpose the marks to a new [Hand-Marked Paper Ballot](#hand-marked-paper-ballot).

<h3 id="risk-limiting-audit-rla">Risk-Limiting Audit (RLA)</h3>


A method of checking that the outcome of an election is accurate by randomly selecting ballots or batches of ballots, and continuing to select samples so that the risk that the outcome (as determined by a full-hand count) could be statistically different, is less than a given risk limit. There are four types based on how the samples are taken (by ballot or by batch) and how those samples are compared (by margin or by sample), resulting in ballot-comparison, ballot-polling, batch-comparison, and batch-polling. RLA audits are difficult to apply when there are many small contests and when margins get tight, and will miss issues that involve just a few ballots. Most RLA audits attempt to audit only one or a few contests. In contrast [BIAs (Ballot Image Audits)](#ballot-image-audit-bia) such as those conducted using AuditEngine can audit all contests and can detect issues down to the specific ballot, are not limited by hand-counting error rates, can be conducted more independently, and are not haunted by election workers fixing up the samples for a clean audit.

Proponents of RLAs point out that BIAs are not looking directly at paper ballots and there is a small chance that the ballot images might be hacked or incorrectly generated. AuditEngine offers the _[Verification Phase](#verification-images-verification-phase)_ where batches of paper ballots can be scanned using a scanner that is independent from the voting system to detect image manipulation. BIAs can be easily used in conjunction with RLA or _full-hand count audits_.

<h3 id="s3">S3</h3>


This stands for[ Amazon](#amazon-web-service-aws) "Simple Storage Service" but it is normally only called just AWS S3 or just S3. This is the secure storage service used by AuditEngine. This service does not allow alteration of files after they are written, and the timestamps cannot be altered. Also, our fleets of compute instances must have the data in S3 in the same datacenter, and produce their results also to S3. AuditEngine, for security, does not use a database service in the processing of election data, although database servers are used for the purposes of controlling the _[AuditEngine App](#auditengine-app)_ and helper Apps maintain state.

<h3 id="sha1-sha256-sha512">SHA1 / SHA256 / SHA512</h3>


Stronger hash algorithms that result in longer hash values, and are approved for cryptographic purposes. If available, we recommend the use of SHA512 in _[Hash Manifest](#hash-value-hash-manifest-file)_ files. See also _[MD5](#md5)_ and _[ETag](#etag)._

<h3 id="sheet">Sheet</h3>


Each ballot image is of a single paper sheet, including both sides. This is the case even if multiple sheets are included in the logical ballot.

In the comparison process, the number of sheets shown in tables is not necessarily a direct sum because a single sheet may include multiple contest variants. Also, depending on the number of sheets included in a single logical ballot, the number of ballots cast may be less than the total number of sheets. This discrepancy may be hard to predict because subsequent sheets are commonly not included in the logical ballot cast. Counting the first sheet will usually produce a pretty accurate number, but even then, some voters do not include the first sheet.

To complicate matters further, BMD ballots may combine multiple sheets onto one ballot summary card, and thus may result in only one ballot image file even when there are multiple sheets involved in [Hand-Marked Paper Ballots](#hand-marked-paper-ballot).

<h3 id="stage">Stage</h3>


One set of operations that are logically separated in AuditEngine, with specified input files (dependencies) and output files that result. Each stage commonly also produces reports of the results of those operations. The stages are organized into a pipeline and are executed sequentially until the pipeline is completed or a stage does not have all the inputs available. Sets of stages are also combined logically into [phases](#phase), for the purposes of explaining their functionality.

<h3 id="targets">Targets</h3>


The ovals or graphic elements that are completed by the voter using a pen or other writing utensil to indicate a vote.

<h3 id="target-map">Target Map</h3>


A configuration file which is the result of the _[TargetMapper App](#targetmapper-app)_ which associates the location of targets on hand-marked paper ballots with the contest and option as defined by the voting system and exists in the _[CVR](#cast-vote-record-cvr)_.

<h3 id="targetmapper-app">TargetMapper App</h3>


A browser-based application that assists with the mapping of the contests and options as defined by the [CVR](#cast-vote-record-cvr) and the targets on hand-marked paper ballots. The result of the TargetMapper App is the _[Target Map](#target-map)_.

<h3 id="undervote">Undervote</h3>


An Undervote occurs when a voter does not vote for as many options as is possible in a contest. The number of undervotes is the number that is not voted. So if a voter can vote for up to 3 in a contest, and only one option is selected, then the number of undervotes in that contest is 2. AuditEngine will correctly interpret many marks that would be considered undervotes by voting systems, such as when ovals are circled or if a checkmark does not actually get inside the oval, or very light marks.

<h3 id="unprocessed-sheets">Unprocessed Sheets</h3>


Sheets that were NOT successfully processed by AuditEngine, generally due to images that are damaged due to scanner jitter when the sheet is not evenly fed through the scanner, barcodes that were corrupted and unreliable, or BMD ballots that were not perfectly read by AuditEngine using [OCR (optical character recognition)](#optical-character-recognition-ocr). Cleaning the scanner rollers can help to avoid corrupted images. AuditEngine does not track the number of contests on unprocessed sheets. If a large number of ballots are unprocessed from a specific voting machine scanner, then additional maintenance or retiring that scanner may be called for. Ballots that were Unprocessed were not necessarily improperly evaluated by the voting system.

<h3 id="verification-images-verification-phase">Verification Images, Verification Phase</h3>


AuditEngine has an optional capability to process ballot images that are made using non-voting system scanners. We call these "Verification Images", and the workflow phase is the "Verification Phase".

Verification images should be of precincts (or batches) that correspond to an aggregated group in the CVR. These are not run as a separate audit, but as an additional 5th phase in the pipeline of the subject audit.

The number of batches processed in this way can be minimized, because the primary hazard being tested is the remote chance that the ballot images were manipulated prior to being secured by the system after scanning. Therefore, the number of batches can be reduced to a fixed value.

Typically, this phase can be added if there is any concern by the public of specific contests that are close. It is mainly important that the public knows this option is available because any temptation to attempt to hack the election in this manner will be reduced.

The physical ballots utilized by this phase should not be touched by election staff after the precincts (or batches) of ballots are chosen, and the seals should be intact when they are ultimately rescanned. Thus, the precincts (or batches) should be kept isolated and easily accessible in storage. The exact strategy to be used in this phase will depend on the voting system and how ballots are already being stored, and must be discussed with our election experts.

<h3 id="voter-verifiable-paper-audit-trail-vvpat">Voter-Verifiable Paper Audit Trail (VVPAT)</h3>


A small printer that can be added to a [DRE](#direct-recording-electronic-dre-voting-machines) device to provide a paper record of each vote on a paper tape. The paper tape is enclosed behind a window so the voter can verify that their vote as printed correctly reflects their vote. Unfortunately, this only can verify that the vote is correctly printed, and does not necessarily reflect what is recorded in memory. This type of record is sequential and can be easily linked to the voter, is relatively difficult to audit, and frequently, the cheap printers would fail or overprint.  AuditEngine cannot audit these records.

<h3 id="voting-system">Voting System</h3>


A general term to refer to the system used by the district to conduct the election, including the EMS and voting machines, etc. These systems are [Election Systems & Software (ES&S)](#election-systems-&-software-es&s), [Dominion Voting Systems (Dominion)](#dominion-voting-systems-dominion), [Hart Intercivic (Hart)](#hart-intercivic-hart), or any others. AuditEngine strives to be compatible with any voting system that can provide adequate data files in the form of ballot images, [CVR](#cast-vote-record-cvr)s,[ Ballot Style Masters](#ballot-style-masters-bsms) and other related data. See also _[Election management system (EMS)](#election-management-system-ems)._

<h3 id="voting-system-for-all-people-vsap">Voting System for All People (VSAP)</h3>


A voting system custom designed for Los Angeles County and to date, is only used by that county. It uses a touch-screen interface and produces [Ballot Summary Cards](#ballot-summary-card) with [QR Codes](#qr-code) that encode the vote of the voter. In this case, the QR Codes can be read by any smartphone and the output compared with notations on the printed ballot summary card.

<h3 id="workflow">Workflow</h3>


How the work will be done in an audit, particularly when working in concert with state and county operations. The following grades are defined:

* **Public Oversight Workflow**
This workflow does not require any special actions by election staff other than publishing data files. This is the default mode of operation when AuditEngine is run by civic groups, candidates or campaigns without much interaction with election staff. This workflow is typically run after [Certification](#certification-election) and is dependent on the availability of ballot images and CVR files, which may be delayed until after certification. Because they are run after certification, audits using this workflow may still impact elections if there are significant findings in local contests but there is typically not a direct route to changing the outcome. But more importantly, they allow the campaigns to have all their questions answered and accept the outcome. This is particularly important for those candidates and their supporters who did not win. This workflow also requires the least amount of data as they don't actually need the [Logic and Accuracy Test (LAT)](#logic-and-accuracy-test-lat) ballot images nor the LAT CVR files, because the turnaround time is not optimized. However, there are two variants based on whether state law allows full public release of the data, as follows: 

    * **Public Oversight with Full Data Release** 
Ballot images and CVR files are all available and the election district provides these. We don't believe that any redaction of additional marks is required on these ballots, because largely, we will only need to view a subset of the ballots in our reports, and it is generally not possible to link the voter to their ballot. 

    * **Public Oversight Workflow with Limited NDA** 
If state law does not embrace full release of ballot images, then we can accept those under a Limited Non-Disclosure Agreement (Limited NDA). The idea is that we would keep the source data on a secure server and when reports are produced, only provide those ballot images that are at issue. 

* **Cooperative Workflow**
When audits are run in cooperation with election districts, turnaround time of results prior to [Certification](#certification-election) can be reduced by configuring AuditEngine prior to the start of the election using:

    * the [Logic and Accuracy Test (LAT) ](#logic-and-accuracy-test-lat)ballot images, 
    * the "known good" [CVR](#cast-vote-record-cvr) of those LAT ballots, and
    * the [Ballot Style Masters (BSMs)](#ballot-style-masters-bsms) PDF files

    This will allow AuditEngine to be fully configured prior to the election and ready to run when live election data is available without any further time consuming configuration.

* **Jurisdiction-Run Workflow**
  To further optimize the workflow and reduce the reliance on personnel outside the control of election districts, the configuration of AuditEngine for audits in each election district can be easily delegated to staff in those districts. This is quite similar to [Cooperative Workflow](#cooperative-workflow) except that the work is being done by staff in each election district rather than by an outside team associated with AuditEngine. In this workflow there must be at least one project manager who is independent from the election districts assigned to each state to provide independent oversight. 

    In this workflow, staff in each district will:

    * Cooperate with workers of all the other districts in the state in the design of ballots.  In this way, a common configuration can be used by AuditEngine to recognize the County and Election on each ballot.

    * Within the AuditEngine frontend app, Create the Election and create two audits for that district. 
        * One audit uses [LAT](#logic-and-accuracy-test-lat) data (the "LAT Audit"), which will allow the full configuration and testing of AuditEngine, for this election, and
        * the other is for the "live" election data.

    * For the "LAT Audit":
        * The [Ballot Style Masters (BSMs)](#ballot-style-masters-bsms) and [LAT](#logic-and-accuracy-test-lat) ballot images and LAT [CVR](#cast-vote-record-cvr) files are uploaded.
        * Run [Phases](#audit-phase) 1 and 2 with the LAT images to create data for the map.
        * Create the [Target Map](#target-map) using the [TargetMapper App](#targetmapper-app), import the map and check the redline proofs for accuracy
        * Optionally and preferably run Phases 3 and 4 using the LAT data as an audit to check that mapping. This incurs a nominal cost.

    * Then when live data is available:
        * Upload the ballot images and CVRs to AuditEngine.
        * Run Phase 1 (Metadata Analysis), but <span style="text-decoration:underline;">skip Phase 2 (Mapping)</span> and move directly to Phase 3 (Vote Extraction) and 4 (Comparison and reporting). Assuming there are no issues, these phases can be run within a day.

    * If a **Verification Phase** is to be used by the jurisdiction, the precincts (or batches) are selected using rolls of ten-sided dice from a list of precincts (or batches). Then the precincts (or batches) are pulled, and without breaking seals from storage, are brought to a secure location where the boxes are opened and the ballots scanned using non-voting system scanners and with public observation. The stages of the Verification Phase include extracting the metadata from the scanned images, and performing extraction, and then comparing the result on an aggregated basis.

<h3 id="write-in">Write-in</h3>


If the write-in [target](#targets) is marked or if the [Write-in Area](#write-in-area) is filled in, then it is considered that the voter intended to write-in the name for a write-in candidate. How this is handled is specific to different states, but most often, the written-in name must also be from a list of qualified write-in candidates.

Write-ins on [BMD ballots](#ballot-marking-device-bmd) do not need human-eye adjudication because the names are keyed in.

The name written-in should be examined in close contests even if there were no candidates that were qualified as write-ins for this contest, because the name written-in may be of a listed candidate, and if so, then the vote is accepted for that listed candidate. In cases when an overvote is initially detected and the written-in name is one of the listed candidates, it should be a single vote for that candidate. How this is handled is very state-specific.

Write-ins normally account for about 80% of [Contest Variants](#contest-variant). Since write-ins are very commonly misunderstood by voters, their use should be minimized.

<h3 id="write-in-area">Write-in Area</h3>


The write-in area is the area set aside for manual entry on[ Hand-Marked Paper Ballots](#hand-marked-paper-ballot). We suggest that there is a square box provided for user entry that does not have any other marks and will be blank if the user does not write anything in the box.

AuditEngine checks to see if there is anything written into the write-in area and if there is, attempts to convert it using [Optical Character Recognition (OCR)](#optical-character-recognition-ocr). The Write-in Area can be adjusted to match the area on the ballot relative to the [Target](#targets).

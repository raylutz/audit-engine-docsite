# How AuditEngine Works

Raymond Lutz, Citizens' Oversight Projects.
Adapted from "Auditing Elections Using Ballot Images and AuditEngine: General Background", version 2, 2022-10-04.

!!! tip "PDF"
    [Download this page as a PDF](https://auditengine.org/docs/pdf/auditengine-background-doc.pdf), to read offline or to attach to an email.

## What AuditEngine does

AuditEngine audits the tabulation of an election using ballot images.
It reads every ballot image and determines the votes on it.
It does not use any software or hardware of the voting system to do this.
It then compares its result with the official result.
When the data allows, it makes that comparison ballot by ballot.

Citizens' Oversight Projects develops AuditEngine.
It is a nonpartisan 501(c)(3) nonprofit organization.

AuditEngine runs in the cloud.
It processes the ballot images on many computers at once, so a full election takes minutes.

This page describes the general method.
Reports on specific audits refer to it for background and terms.

## Why audit ballot images

### Voting systems and ballot images

A voting system includes the scanners and ballot marking devices at polling places.
It also includes central scanners and the Election Management System (EMS).
The EMS lays out the ballots and tabulates the results.

Some polling places have a scanner that checks each ballot as the voter casts it.
It warns the voter of an overvote or a blank ballot.
Other polling places send all ballots to a central office for scanning.
Mail ballots are usually scanned centrally on high-speed scanners.

Modern scanners are full-page document scanners.
They make a digital image of both sides of each ballot sheet, typically at 200 pixels per inch.
The scanner then reads the votes from this image.
So the image is a critical record of the election.
It should be preserved, and it is usually a public record.

We reviewed the ten battleground states of the 2020 general election.
We looked at the most populous jurisdictions, which hold 80% of the voters in each state.
Of those jurisdictions, 93% used equipment that creates ballot images.

### What a ballot image audit checks

The images are created early in the process.
So an audit of the images can detect a later change to the tabulation.
It can also measure how well the voting system judged voter intent.

Other audits check the tabulation too.
A full hand count counts every ballot by hand.
A risk-limiting audit counts a random sample of ballots or batches.
Both methods handle paper and rely on people to count, which costs time and adds error.
A ballot image audit can compare every ballot in every contest with the official result.
That works no matter how close a contest is.

These methods can work together.
The images are a check on the paper ballots, and the paper ballots are a check on the images.
A complete audit program reviews both.

### What a tabulation audit does not cover

A ballot image audit covers the tabulation, from the scanned ballot to the final result.
It does not cover what happens before a ballot is cast.
It does not check voter eligibility or signatures.
It does not show that the set of ballots is complete.
Audits of the chain of custody, of eligibility and of procedures address those questions.

AuditEngine can compare the number of ballots with the number of voters recorded as voting.

AuditEngine never receives the identity of any voter.
This was a design decision.
It means AuditEngine has no way to link a vote to a voter.

### Remaining risk in the images

An audit of images assumes the images match the paper ballots.
In theory, a skilled attacker could alter images as they are made.[^unclear]
Security controls in the scanners reduce this risk.
Comparing a sample of images with their paper ballots reduces it further.

We have proposed that each scanner compute a secure hash of each image as it creates the image.
The scanner would sign the hash with a private key built into it.
Any later change to an image would then be detectable.
The hashes could be published before the images are released.[^scitt]
Voting system vendors have not adopted this yet.

## Ballots and vendors

Most U.S. jurisdictions use equipment from three vendors.
They are Election Systems & Software (ES&S), Dominion Voting Systems and Hart InterCivic.
AuditEngine reads the data from ES&S and Dominion systems.
Support for Hart is in progress.

Two kinds of ballots matter for the audit.

A hand-marked paper ballot has ovals or rectangles, called targets.
The voter darkens a target with a pen to choose an option.
The voter sees each choice while marking it.

A ballot marking device (BMD) is a touch screen that prints a ballot summary card.
The card lists the voter's choices as text.
It also encodes them in a barcode or QR code.
Voting systems usually read only the barcode, which voters cannot read.

Voters rarely check the printed card.
In a University of Michigan study, voters missed over 93% of errors on BMD printouts.[^umich]
J. Alex Halderman, a computer science professor there, showed another risk.
Malicious software on a BMD could change the votes in the QR code and leave the printed text alone.[^ajc]

AuditEngine reads the printed text on BMD cards with optical character recognition (OCR).
It does not read the barcodes.
So it would catch a change to the barcode, as long as the text shows what the voter chose.
If the text itself were altered, only the voter could detect it.
A BMD could guide each voter to check the printed card, which would reduce that risk.[^directed]

In the audit of Bartow County, Georgia, AuditEngine read the text on 39,967 BMD ballots.
It failed to read one.

## The data

### Ballot images

The ballot image is the first digital record of a ballot.
It holds the most information.
It shows whether a voter filled a target, checked it or circled it.
Once the vote is extracted, that detail is gone.

So equipment should be set to keep the images.
Election offices should preserve and publish them for every election.
Some ES&S equipment can be set to delete images.
A later election can also overwrite the images from an earlier one.

Federal law requires election records to be kept for 22 months after a federal election.[^law]
The U.S. Department of Justice has said this includes records in digital form.
Ballot images are such records.

The EMS exports the images.
They should go into ZIP archives of about 10,000 to 50,000 ballots each.
AuditEngine accepts the image formats the vendors produce, including PDF, TIFF, PNG, PBM and JPG.
Current Dominion systems use TIFF, and current ES&S systems use PDF.
One ballot sheet, front and back, takes about 200 KB to 600 KB.
Ballots printed without a gray background are easier to read and make smaller files.

The [exporting guides](exporting_guide.md) explain how to export the data from each vendor's system.
[Sending Election Data to AuditEngine](sending_data.md) explains how to send it.

### Privacy

Ballot images are anonymous.[^serial]
Nothing in an image proves who cast it.
A name written on a ballot does not prove who voted it.

Rare ballot styles are a risk to privacy.
If only a few voters receive a style, other data might reveal how they voted.
We recommend that jurisdictions keep rare styles to a minimum.
Ballots in rare styles can be left out of the image set without harming the audit.
We also recommend that it be a crime to match a vote to a voter and then use or publish it.

Some agencies add statistical noise to published data to protect privacy.[^nc]
Election results should not be changed this way.
Adding ballots to the set is one more chance for manipulation.
The exact results must be published.

AuditEngine checks each audit for rare styles.
So far, cases where a voter could be matched to a ballot have been rare.

AuditEngine does not need people to look at most ballots.
People review a ballot only where AuditEngine and the voting system disagree.
That is usually fewer than 1% of the ballots.

Every ballot can be researched in full in AuditEngine, so others can check its results.
As in science, trust comes from others repeating the analysis.

### Cast vote records

A cast vote record (CVR) is the voting system's reading of one ballot sheet.
The CVR files hold the CVRs for all the sheets.
The vote totals in the CVR files should match the official totals, or come very close.

With CVR files, AuditEngine compares its reading with the official reading for each ballot.
Without them, it can compare totals only by contest or by precinct.
That still checks the outcome.
But it gives little help in finding the ballots that caused a difference.[^ballotlevel]

CVR files must be machine readable.
ES&S provides spreadsheets, with one row per ballot sheet.
Dominion provides JSON files.
Dominion's files include the original reading of each ballot and any change made in adjudication.
NIST has published a Common Data Format for CVRs.[^nist]
Vendors do not fully follow it yet, so AuditEngine reads each vendor's own format.

The term "cast vote record" has a second use.
ES&S can export a PDF for each ballot that shows how it was read.
Dominion prints a similar summary, called the AuditMark, as the third page of each image file.
AuditEngine does not rely on these summaries of single ballots.
A consolidated file is more secure, because it is harder to change a few ballots in it without notice.
This documentation uses "CVR files" to mean the consolidated files.

The CVR files should include these fields for each sheet:

- the ballot ID, which identifies the sheet,
- the ballot style, which sets the contests, the language and the order of options,
- the precinct,
- the batch, which helps staff find the paper ballot.

Some scanners print the ballot ID on the paper as they scan it.
The ID then appears in the image too, which links the image to its paper ballot.
The ballot style in the CVR should match the style code printed on the ballot.
Dominion includes the batch in its CVR files, and ES&S often does not.

### Configuration files

AuditEngine also needs a few configuration files.

The Election Information File (EIF) lists each contest and its options.
It gives each name as it appears in the CVR, in other reports and on the ballots.
It gives the number of votes allowed in each contest and the number of write-in lines.
It also gives the text printed on BMD cards.
AuditEngine can generate most of the EIF from the CVR files.

The target map gives the location of each target on each ballot style.
Vendors do not provide target maps in any standard form.
So AuditEngine builds the map with an app called TargetMapper.
TargetMapper can start from the ballot style masters.
These are the searchable PDF files sent to the printer.
With the masters, the work grows with the number of contests.
Without them, TargetMapper works from the ballot images.
The work then grows with the number of styles times the number of contests.

The job settings file holds the settings for one audit.
It names the image archives and the CVR files.
It also records facts about the district for the reports.

## The audit process

An audit runs as a series of stages.
The stages fall into four phases.

### Set up and check the data

The election is created in AuditEngine.
A jurisdiction can have one upload link that stays the same from one election to the next.
The ballot images, CVR files and ballot style masters are uploaded through it.

An audit job is then created for the election, with its job settings.
The first stage lists every input file with its hash value.
The jurisdiction can compare each hash with its own, to show the files are identical.

The next stages collect metadata for each ballot.
The metadata comes from the image archives, the CVR files and the images themselves.
AuditEngine reads the style code from the barcode printed on each ballot.
It prefers this to the style listed in the CVR, which may be wrong.
BMD ballots are the exception, because their style is in the QR code.
A metadata report then shows any missing, repeated or extra images and CVR records.

### Map the styles

AuditEngine creates a template for each ballot style from the images.
An operator maps the targets on each style with TargetMapper.
AuditEngine then produces redline proofs, which show each target outlined and labeled.
The proofs let the map be reviewed.
A mapping error can change the result, but it usually shows up later in the audit.

### Extract the votes

AuditEngine reads every ballot image.
It aligns the image, measures the darkness of each target and decides the vote.
Its threshold adapts to each voter's marks and to the density of the image.
It reads BMD cards by OCR.
Reports then show the marks found and the totals for each contest.

### Compare and report

With CVR files, AuditEngine compares its reading with the official reading of every ballot.
The result is the Reconciliation Report.
Earlier audit reports call it the discrepancy report.
It lists each disagreement and links to the ballot images involved.
Without CVR files, the report lists the ballots with ambiguous marks, which can guide further review.

The Reconciliation Report can run to thousands of pages, so it is meant to be read on screen.
It gives details on selected contests.
By default these are the first ten contests, the five closest contests and the five with the most disagreements.

Reviewers can then look at the ballots that need it in the AdjudiTally app.
They can review overvotes, write-ins, undervotes and ambiguous marks.

A final report lists all the reports.
Each audit also has a narrative report that describes its findings.

## About the author

Raymond Lutz founded Citizens' Oversight Projects and is its executive director.
The organization has provided oversight of elections for over 15 years.
Lutz has a master's degree in electronics and software engineering.
He has worked in the document management, office imaging and medical device industries.
He is the lead developer of AuditEngine.

[^unclear]: Matthew Bernhard, Kartikeya Kandula, Jeremy Wink and J. Alex Halderman, ["UnclearBallot: Automated Ballot Image Manipulation"](https://mbernhard.com/papers/unclearballot.pdf), University of Michigan. Our response is at [copswiki.org/Common/M1976](https://copswiki.org/Common/M1976).

[^scitt]: The Internet Engineering Task Force has a working group on Supply Chain Integrity, Transparency and Trust (SCITT). Its work would let data such as ballot images be registered so that any change can be detected. We follow and contribute to it.

[^umich]: ["New study finds voters not detecting ballot errors, potential hacks"](https://news.engin.umich.edu/2020/01/new-study-finds-voters-not-detecting-ballot-errors-potential-hacks/), University of Michigan, January 2020. Matt Bernhard and J. Alex Halderman found that voters missed over 93% of errors on printed ballots they filled out on BMDs.

[^ajc]: ["Secret report finds flaw in Georgia voting system, but state in the dark"](https://www.ajc.com/politics/secret-report-on-georgia-voting-system-finds-flaws-but-state-shows-no-interest/YKFEET2WE5BBPJ7TYVOYMBTIKQ/), Atlanta Journal-Constitution.

[^directed]: In a directed review, the touch screen asks the voter to compare the printed card with the choices made on screen. It would slow voting.

[^law]: 52 U.S.C. 20701 requires election officers to keep all records relating to an election for 22 months. The U.S. Department of Justice wrote that "jurisdictions must therefore also retain and preserve records created in digital or electronic form," in ["Federal Law Constraints on Post-Election Audits"](https://www.justice.gov/opa/press-release/file/1417796/download), 2021-07-28.

[^serial]: Some states still print a unique serial number on ballots. The stated purpose is to pull the ballot of a voter who dies after voting early. The practice should stop, because it lets an official find the votes of any voter.

[^nc]: The North Carolina State Board of Elections adds statistical noise to its precinct-sorted data files. It says the files should not be used to report official results. See its [historical election results data](https://www.ncsbe.gov/results-data/election-results/historical-election-results-data).

[^ballotlevel]: Some systems, such as Clear Ballot, rescan the paper ballots. That avoids relying on the voting system's scans. But the new scans cannot be matched to the official reading of each ballot. They can only be compared in totals, by batch or by precinct, which makes a difference hard to trace.

[^nist]: NIST, ["Cast Vote Records Common Data Format Specification, Version 1.0"](https://www.nist.gov/publications/cast-vote-records-common-data-format-specification-version-10).

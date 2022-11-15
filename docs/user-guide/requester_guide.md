<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">

# Requester Guide

This Requester Guide provides guidance for candidates, campaigns or other interested parties that are working to acquire data so AuditEngine can audit an election in one or more districts.

## Strategize: Minimize Setup Costs

Given that any interested party may be interested in a specific contest or set of contests, it may not be necessary to audit all the districts (such as counties) involved in those contests. Of course, if it is constrained to one county, no strategy is necessary. If it is a congressional district, those counties that are wholly or partially included in the congressional district should be included. For the presidential contest, each entire state is of concern, but even then, a subset of the counties will comprise a vast majority of the votes. It is not quite as lopsided as the Pareto Principle (80/20) rule, but almost.

For example, in California, there are 58 counties. The top 5 counties (8.6% of counties) include more than 50% of the electorate; the top 14 counties (24% of the counties) comprise 80%, and the top 24 counties (41% of counties) comprise 92% of the vote. 

Setup costs are roughly fixed on a per-county basis, so leaving out the remaining 34 counties in CA is a prudent approach to audit almost all, (92%) of the vote, but avoid 60% of the setup costs if you were to just do "all counties" without adopting a strategy.

## Availability of Ballot Images

### Do the voting systems produce the images?

Most districts today produce ballot images (about 93% of the top 500 counties), but some are still using the older DRE-type systems that have no ballot images. Those will not be processable by AuditEngine, but it still may be true that the absentee or vote-by-mail ballots will be hand-marked and may still be available.

This can be determined by looking that the voting systems used by the districts. You can use the [Verified Voting Verifier](https://verifiedvoting.org/verifier/) tool to look at the equipment used in your district. The equipment listed as "Optical Scan Voting Systems" may provide ballot images, but not all.

|                                          | Ballot Image Producing                                       | Not Ballot Image Producing                           |
| ---------------------------------------- | ------------------------------------------------------------ | ---------------------------------------------------- |
| **Election Systems & Software (ES&S)**   | DS200, DS450, DS850, DS950<br />ExpressVote XL or ExpressVote used with the scanners above.<br />Note: ES&S scanners allow ballot images to be deleted if not set to "Save All" | ExpressTouch, iVotronic, Model 100, Model 150, 550   |
| **Dominion Voting Systems**              | ImageCast Central, ImageCast Precinct<br />ImageCase X BMD when used with the above scanners | ImageCast X DRE                                      |
| **Sequoia Voting Systems**               |                                                              | AVC Advantage, AVC Edge                              |
| **Premier Election Solutions (Diebold)** |                                                              | AccuVote OS Central, Accuvote OS, and Accuvote OSX   |
| **SmartMatic**                           | Voting Solutions for All People (VSAP) Used in Los Angeles only. |                                                      |
| **Hart Intercivic**                      | eScan, Verity Scan, Ballot Now, Verity Central               | Hart InterCivic eSlate, Hart InterCivic Verity Touch |
| **MicroVote**                            |                                                              | Infinity, MV-464                                     |

### Ballot Image Availability by State Law or Procedure	

The other factor is whether the ballot images are available by state law or restricted by procedure. This is a very dynamic area as there are some court cases in process to provide ballot images. Jurisdictions sometimes play it safe and claim that ballot images are the same as paper ballots. Counties may charge for the data, and may use this as a mechanism to block access.

| States will full availability | States with mixed availability                 | States with no availability |
| ----------------------------- | ---------------------------------------------- | --------------------------- |
| GA, WI, NJ                    | CA (only SF), FL (some counties delete images) | AZ, WA, NC                  |

## Getting the Data

Some counties may post their data for everyone. This is the case, for example, in San Francisco. We hope that more counties will adopt this methodology to reduce their cost and ours. However, if they do not, you can submit a <u>Public Record Request</u> to the county. Here is a example of a public record request:

| To: email@county.gov <br />Subject: Public Records Request for Election Data |
| ------------------------------------------------------------ |
| Dear County Representative:<br /><br />Please provide the following data per this PUBLIC RECORDS REQUEST for the MM/DD/YYYY election in your county:<br /> -- All Ballot Images<br /> -- Cast Vote Records CVRs<br /> -- Ballot Style Masters<br /><br />Please see the following guides for your system:<br />   Dominion: https://AuditEngine.org/user-guide/dom_exporting_guide/<br />   ES&S: https://AuditEngine.org/user-guide/ess_exporting_guide/<br />   Hart: https://AuditEngine.org/user-guide/hart_exporting_guide/<br />Also, sending the data to us is covered by this guide:<br />    https://AuditEngine.org/user-guide/sending_data/<br /><br />If you have any questions, please contact me at (your telephone number)<br />Sincerely, XXXXXX<br /> |

### Exporting Guides

We have the following guides to help them export and provide the data to AuditEngine.

- [Dominion Exporting Guide](user-guide/dom_exporting_guide.md)

- [ES&S Exporting Guide](user-guide/ess_exporting_guide.md)

- [Hart Exporting Guide](user-guide/hart_exporting_guide.md)

### Sending the data to AuditEngine

- [Sending Election Data to AuditEngine](sending_data.md) -- Includes:

  - Archiving the Data
  - Creating a Hash Manifest File
  - Providing the data:
    - Posting the data - Election officials are now opting to post the data once for all requesters.
    - Uploading - We can provide a county-specific upload link so they files can be easily uploaded.
    - Using USB Thumbdrives
    - Using a "Jump Drive"

## Create an Election on AuditEngine

It is necessary to create an "Election" on AuditEngine so that these files can be associated with that election, and so that audits can be performed. Once the files are uploaded, then they are "adopted" to the appropriate election, and the type of each file is tagged to the file. This way, the uploading can proceed without any concern for the election or what type of files are uploaded, and then it is resolved later.

## Create the Audit and process it!

The next steps are covered in other guides. But briefly, once the data is uploaded and associated with an election by adopting the data, then an Audit is created. After creating the audit settings for the election, the various stages of the audit pipeline can be run.
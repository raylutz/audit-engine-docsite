<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />

# Glossary

**Adjudication --** This is the process of human review of ballots or ballot images and providing an interpretation of the vote on that ballot. Dominion Voting Systems has an adjudication module that facilitate adjudication by election staff. AuditEngine also has an Adjudication App that can help fine tune the results obtained by AuditEngine.

**Archive --** A single file which can contain many smaller files and also may compress them. This saves a lot of space on the disk because the disk requires that files consume at least one block, and the last block in a file is partially empty. Archives pack all the files together into one file without any empty space. This also makes it easier to handle many thousands of individual files by grouping them together into archives. We recommend that you use the open source standardized "ZIP" archives, because the files can be individually extracted from the archive without extracting them all. The free application "7-zip" from [7-zip.org](https://7-zip.org) is a very good tool, but <u>use the conventional zip format and not the proprietary 7z format</u>. We recommend that up to about 50,000 ballot images are placed into the same archive, and they should be between about 5GB and 10GB in size for easy handling.

**Ballot --** Generally a presentation of contests and options for each contest that can be selected by a voter, and the recording of those selections. The word "ballot" originally meant "little ball" and these were placed into a box to represent the votes of each person. In practice, a complete ballot may be a number of sheets, each with a front and back side, also called pages.

**Ballot Image --** Election systems today create digital pictures of both size of each ballot sheet. These images can be exported by the election management system (EMS) in standard formats, such as PDF (generally with both the front and back in the same file), multipage TIFF (Dominion uses these, with three pages in one file, the front, back and "audit mark" graphical image of the voting system evaluation), or PNG (Dominion uses this, with all three pages combined into a single tall image.) 

Please note that sometimes the term "Ballot Image" will be used to mean digital inputs by the user at a Direct-Recording Electronic (DRE) machine or other touch-screen machine. The term "image" is used in computer science to sometimes mean an exact copy of digital data. This term is now widely understood to mean the actual digital pictures of the document rather than just a copy of digital data that does not represent a picture.

**Ballot Image Audit --** A review of digital images of ballots in a jurisdiction of an election and comparison with the official outcome for each ballot, group of ballots (precincts or batches), or the entire jurisdiction. AuditEngine is a platform that can provide the compute services for such an audit.

**Ballot Style --** A designation that represents the set of contests on the ballot, the language and in the case of a hand-marked paper ballot, the location of voting targets.

**Ballot Style Masters --** PDF files in "searchable" format that are normally sent to the ballot printer company for printing of ballots in their final useable form. These files are used by AuditEngine to simplify the process of "Mapping" the ballot styles to provide the location of each active target oval or rectangle which is darkened by the voter to express their voting intent.

**Cast Vote Record (CVR) --** A data file or set of files that provides the outcome of an election, typically broken down to the individual ballot. For ES&S ballots, the CVR is typically a set of Excel spreadsheet files, where each record is an individual ballots. For the more recent Dominion voting systems, the CVR uses a variant of the NIST CVR "Common Data Format" and is a set of JSON files or sometimes CSV (comma separated values) files. ES&S also uses this term for the pdf file that are the summary of the voting system evaluation of the vote on that ballot, and so we call these "CVR PDF files" while the spreadsheets are "CVR Spreadsheets."

**Dominion Voting Systems (Dominion) -- **A major voting system vendor with approximately 37% of the market.

**Election Management System (EMS) --** This is the general term for the suite of software applications that provide all the functions needed to assist election officials to perform elections. Functions include the definition of ballots, configuring voting machines that are used in polling locations, central tabulation, and reporting.

**Election Systems & Software (ES&S) --** A major voting system vendor with approximately 47% of the market.

**Hand-Marked Paper Ballot --** This type of ballot provides all the contests and options that can be voted by specific voter on a set of ballot sheets, with targets that can be marked by the voter using a conventional pen.

**Hart Intercivic --** A voting system vendor with a relatively small footprint nationally.

**Mapping --** One key step in the process of performing a ballot image audit is the mapping of the contests and options to specific target locations on a paper ballot of a specified style.

**Overvoted --** If a voter marks more than the number of options allowed in the contest, it is considered "overvoted" and no vote is awarded to any option. For example, if the "vote-for" number is 1 and the voter votes for three options, it is considered one overvote.

**Pipeline --** The operation of AuditEngine is broken into a series of stages, where each stage has defined inputs (dependencies) and outputs. The set of the stages together is called the pipeline. Each stage cannot be executed unless its dependencies are available from prior stages.

**Poll Tapes / Digital Poll Tapes --** Voting machines that are used in polling places typically have a poll-tape report which is printed out by poll workers during an election, and frequently posted at the site and turned into the election office. Digital Poll Tapes can be produced by ES&S systems which are an exact copy of the report produced by the voting system scanner but provided as a PDF file and can be processed by AuditEngine to provide another check of the results of the election.

**Risk-Limiting Audit --** A method of checking that the outcome of an election is accurate by random selecting ballots or batches of ballots, and continuing to select samples so that the risk that the outcome as determined by a full-hand count could be statistically different, is less than a given risk limit. There are four types based on how the samples are taken (by ballot or by batch) and how those samples are compared (by margin or by sample), resulting in ballot-comparison, ballot-polling, batch-comparison, and batch-polling. RLA audits are difficult to apply to many small contests and when margins get tight.

**Stage --** One set of operations that are logically separated in AuditEngine, with specified input files (dependencies) and output files that result. Each stage commonly also produces reports of the results of those operations. The stages are organized into a pipeline, and are executed sequentially until the pipeline is completed.

**Targets --** The ovals or graphic elements that are completed by the voter to indicate a vote.

**Undervote --** Occurs when a voter does not vote for as many options as is possible in a contest. The number of undervotes is the number that is not voted. So if a voter can vote for up to 3 in a contest, and only one option is selected, then the number of undervotes in that contest is 2.
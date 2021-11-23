<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />

# Glossary

**Adjudication --** This is the process of human review of ballots or ballot images and providing an interpretation of the vote on that ballot.

**Ballot --** Generally a presentation of contests and options for each contest that can be selected by a voter, and the recording of those selections.

**Ballot Image Audit --** A review of digital images of ballots in a jurisdiction of an election and comparison with the official outcome for each ballot, group of ballots (precincts or batches), or the entire jurisdiction. AuditEngine is a platform that can provide the compute services for such an audit.

**Ballot Style --** A designation that represents the set of contests on the ballot, the language and in the case of a hand-marked paper ballot, the location of voting targets.

**Cast Vote Record (CVR) --** A data file or set of files that provides the outcome of an election, typically broken down to the individual ballot. For ES&S ballots, the CVR is typically a set of Excel spreadsheet files, where each record is an individual ballots. For the more recent Dominion voting systems, the CVR uses a variant of the NIST CVR "Common Data Format" and is a set of JSON files. ES&S also uses this term for the pdf file that are the summary of the voting system evaluation of the vote on that ballot, and so we call these "CVR PDF files" while the spreadsheets are "CVR Spreadsheets."

**Dominion Voting Systems (Dominion) -- **A major voting system vendor with approximately 37% of the market.

**Election Systems & Software (ES&S) --** A major voting system vendor with approximately 47% of the market.

**Hand-Marked Paper Ballot --** This type of ballot provides all the contests and options that can be voted by specific voter on a set of ballot sheets, with targets that can be marked by the voter using a conventional pen.

**Hart Intercivic --** A voting system vendor with a small footprint nationally.

**Mapping --** One key step in the process of performing a ballot image audit is the mapping of the contests and options to specific target locations on a paper ballot of a specified style.

**Overvoted --** If a voter marks more than the number of options allowed in the contest, it is considered "overvoted" and no vote is awarded to any option. For example, if the "vote-for" number is 1 and the voter votes for three options, it is considered one overvote.

**Poll Tapes / Digital Poll Tapes --** Voting machines that are used in polling places typically have a poll-tape report which is printed out by poll workers during an election, and frequently posted at the site and turned into the election office. Digital Poll Tapes can be produced by ES&S systems which are an exact copy of the report produced by the voting system scanner but provided as a PDF file and can be processed by AuditEngine to provide another check of the results of the election.

**Risk-Limiting Audit --** A method of checking that the outcome of an election is accurate by random selecting ballots or batches of ballots, and continuing to select samples so that the risk that the outcome as determined by a full-hand count could be statistically different, is less than a given risk limit. There are four types based on how the samples are taken (by ballot or by batch) and how those samples are compared (by margin or by sample), resulting in ballot-comparison, ballot-polling, batch-comparison, and batch-polling. RLA audits are difficult to apply to many small contests and when margins get tight.

**Targets --** The ovals or graphic elements that are completed by the voter to indicate a vote.

**Undervote --** Occurs when a voter does not vote for as many options as is possible in a contest. The number of undervotes is the number that is not voted. So if a voter can vote for up to 3 in a contest, and only one option is selected, then the number of undervotes in that contest is 2.
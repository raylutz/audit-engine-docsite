# Profiles

Some audits process only part of an election.
A large election can have over a million sheets, and processing every one takes time and cost.
A profile limits the audit to the sheets it needs, such as the sheets that carry the contest being audited.

## An example: Long Beach Measure A

A profile helps whenever the interest is one contest in a large election.
An example is a close local measure decided within a large county.

In the March 3, 2020 primary, Long Beach voted on Measure A, which extended a 1% sales tax indefinitely.
It passed by 16 votes, 49,676 to 49,660.
A citizens' group, the Long Beach Reform Coalition, asked for a recount.

Los Angeles County had moved to vote centers, where a voter can cast a ballot anywhere in the county.
So the Long Beach ballots were mixed with over 2 million others.
The county's published table put a hand recount at $15,000 to $24,000.
Its estimate to find the Long Beach ballots alone was over $187,000, and the total came to nearly $240,000.
The recount stopped, and a court later upheld the charges.
([Long Beach Post](https://lbpost.com/news/costs-of-recounts-fate-of-measure-a-could-hinge-on-challenge-to-countys-new-recount-rules))

With the county's ballot images and CVR, AuditEngine could audit that one contest without finding or sorting any paper.
A profile selects the sheet styles that carry Measure A, and only those sheets.
AuditEngine then audits every sheet of the contest, and no others.

## What a profile is

A profile is a set of constraints.
Each constraint is a filter on the [metadata](glossary.md#metadata) of each sheet.
Applying the profile to every sheet in the election gives the profiled set.
That is the set of sheets the audit processes, with the image files of each sheet.
The profile is the constraints. The profiled set is what they select.

## Constraints on sheet styles

Most constraints select [sheet styles](glossary.md#sheet-style). They can take several forms:

- A list of sheet styles. This is the most exact form.
- A contest. The profile takes every sheet style that carries the contest, and only those styles.
  This is the usual form, because most audits look at one contest.
- A [sheet position](glossary.md#sheet-position), such as the first sheet of every ballot. This form is broad.
  Sheet position 2 of one ballot style can carry different contests from sheet position 2 of another.
- A party, in a primary election. Each party has styles of its own.

A profile by contest covers every sheet of the contest being audited, and no other sheets.
A profile of sheet position 1 can take in first sheets that do not carry that contest.

## Other constraints

Some constraints are not part of any style:

- A voting group, such as mail, early voting, in-person election day or provisional.
  Sheets of the same style are cast in every group.
- An [archive](glossary.md#archive-zip-archive).
- [BMD sheets](glossary.md#bmd-sheet) or [hand-marked](glossary.md#hand-marked-paper-ballot) sheets.

## BMD sheets

A BMD sheet is one physical sheet, but it can stand for several [cards](glossary.md#card).
Each card is a logical sheet.
A constraint on sheet position applies to the physical sheet.
So a profile of sheet position 1 takes in every BMD sheet, with the contests of all its cards.

## Where the metadata comes from

The metadata comes from the [CVR](glossary.md#cast-vote-record-cvr) and from the image files.
The votes are never used.

CVRs differ in how much metadata they carry.
Some give each sheet's style, sheet position, group and BMD status.
Others give no style or card code at all.
Then the [card_code](glossary.md#card_code) is read from the image of each sheet.
A card code says nothing about contests or sheet position until its style is [mapped](glossary.md#mapping).
So a profile that avoids mapping the whole election needs a CVR that carries the styles.

## Job settings

A profile is set in the [job settings](glossary.md#job-settings). Each form of constraint has its own setting.

| Constraint | Setting |
| :--------- | :------ |
| Use a profile at all | use_profiled_bif |
| Contests | include_styles_with_contest |
| Sheet styles to keep or drop | include_style_num, exclude_style_num |
| Sheet positions | profiled_bif_include_sheets |
| Parties | profiled_bif_include_parties |
| Voting groups | profiled_bif_include_groups |
| Archives | profiled_bif_include_archives |
| BMD or hand-marked sheets | include_bmd_ballot_type, include_nonbmd_ballot_type |

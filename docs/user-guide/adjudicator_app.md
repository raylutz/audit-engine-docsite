# AdjudiTally App

## Purpose

The AdjudiTally App provides a browser-based user interface to review ballot images and either compare with CVR, independently tally, or adjudicate audit results.

## Basic Concepts

Please review the following concepts in the Glossary:

- [Ballot Image](glossary.md#ballot-image)
- [Ballot Variant](glossary.md#ballot-variant)
- [Cast Vote Record (CVR)](glossary.md#cast-vote-record-cvr)
- [Contest Variant](glossary.md#contest-variant)
- [Nonvariant Ballot](glossary.md#nonvariant-ballot)
- [Voter Intent](glossary.md#voter-intent)

## Major Modes

This same app is used in several major modes of operation:

- **[Adjudicator](#adjudicator-mode)** - In this mode, records that are either ballot variants or contest variants are provided for review, and the user can enter the interpretation of voter intent. Please note that nonvariant ballots are not reviewed in this process.
- **[Tally](#tally-mode) -** This application can be used to independently tally from a set of ballot images. In this mode, there is no reference to any voting-system cast vote record.
- **[Ballot Viewer](#ballot-viewer-mode) -** This mode is used to compare ballot images with a voting system CVR without reference to the AuditEngine interpretation for that ballot. 

## Adjudicator Mode

In this mode, records that are either ballot variants or contest variants are provided for review, and the user can enter the interpretation of voter intent. Please note that nonvariant ballots are not reviewed in this process. After all desired records are reviewed, then the human-eye interpretation can be provided to AuditEngine where any changes will be included as an additional column for comparison.

### Adjudicator Layout

<img src="https://s3.amazonaws.com/auditengine.org/docs/images/adjudicator_layout.png" alt="Adjudicator Layout">

Please notice the following major panes:

1. **Job selection, Filters, and Search** -- in this block the audit project can be selected and records filtered and searched.
2. **Ballot/Contest List** -- in this list, the ballot and contest is listed which is considered a variant for review.
3. **Interpretation** -- In this pane, the interpretation by the Voting System and by AuditEngine is shown, and the actual interpretation can be entered by the user.
4. **Ballot Image Pane** -- In this pane the image of the ballot will be shown. If contest variants are being reviewed, it will normally be zoomed and positioned to show that contest of concern. Otherwise, there are page buttons at the top, to select the page, and the image can be zoomed and panned using the mouse.

### Adjudication Process

The process of adjudication can be summarized as follows:

1. **Job Selection:** The top selector box selects the job to be processed, typically in STATE_County_YYYYMMDD format.

2. **Data Source:** There are two sources:

   1. **audit_variants:** Choose this option when running in cooperative workflow, and the results have not been compared with the CVR. In this mode, there are no "disagreed" records, but there are still gray-flags, overvotes and write-ins. These can be reviewed to generate the best possible independent tabulation prior to receiving the CVR.
   2. **cmpcvr:** Choose this option when running in public oversight workflow, or after the CVR has been received in cooperative workflow. This will allow comparision with the Voting System results.

3. **Record Type:** There are three possible variant types:

   1. contest_variants
   2. ballot_variants
   3. nonvariants

4. **Filters**: Filters can be established to focus variant types, contests, or precincts.

   1. Contest - Can choose one or many contests, or all (no filters)
   2. Precinct - Can choose one or many precincts, or all (no filters)
   3. Adjudicated - Can choose those already or not yet adjudicated.
   4. Tag - Can choose from any records arbitrarily tagged.
   5. Variant Group - Can choose from records based on their attributes (See table below)
   6. Choose "Apply"

5. **Select Ballot:** Click on the ballot number to select a ballot for review.

6. **Find Contest on Ballot:** Notice in the contest box in the middle pane, and then pan and zoom to see the contest on the ballot image.

7. **Choose correct evaluation:** 

   In the center pane, choose either:

   1. **VotingSystem**, if the vote checked in that column is correct.
   2. **AuditEngine**, if the vote checked in that columns is correct and the Voting System is not correct.
   3. **Direct**, if neither the Voting System or AuditEngine are correct. Then, check mark the correct vote in that column.

8. **Click "Checked"** -- This can be done right away if there is only one worker. Alternatively, a second worker can check the work of the first worker and checkmark "Checked".

9. **Continue until all Variants of concern are adjudicated.** Continue in this manner from step 5 until all ballots selected for adjudication have been evaluated. If desired, go back and change the filters to select other ballots for review.

10. **Save the File** -- Click "File" -- "Save File" as much as desired to save the file.

11. **Import into AuditEngine** -- When adjudication is complete, the adjudication can be imported into AE to create comparison reports which include an additional column for the adjudication.

| Variant Group        | Meaning                                                      |
| -------------------- | ------------------------------------------------------------ |
| **AUDIT EVALUATION** | _This section of attibutes are established by the auditing system_ |
| audit_overvotes      | Audit system detected overvotes in this contest.             |
| audit_undervotes     | Audit system detected undervotes in this contest             |
| audit_writeins       | Audit system detected write-ins in this contest with a basic evaluation (oval marked or text detected but not evaluated regaring whether it is a legitimate write-in.) |
| audit_tot_votes      | Audit system detected at least one vote in this contest      |
| audit_gray_eval      | Audit system evaluted this contest as being "ambiguous"      |
| blank                | Audit system detected an entirely blank ballot (Ballot Variant) |
| corrupted            | Audit system detected a corrupted ballot (Ballot Variant)    |
| is_bmd               | Audit system detected this as a BMD ballot type.             |
| no_cvr               | Audit system reports that there is no CVR associated with this ballot. (Ballot Variant) |
| **ORIGINAL CVR**     | _These attibutes are established by the original (not adjudicated) CVR from the voting system._ |
| cvr_orig_overvotes   | Original CVR detected overvotes in this contest.             |
| cvr_orig_undervotes  | Original CVR detected undervotes in this contest. Sometimes overvotes that are reviewed are classified as undervotes. |
| cvr_orig_writeins    | Original CVR detected write-ins in this contest with a basic evaluation (oval marked or text detected but not evaluated regaring whether it is a legitimate write-in.) And in some cases, the writeins may be fully evaluated by election staff. |
| cvr_orig_tot_votes   | Original CVR detected at least one vote in this contest      |
| audit==cvr_orig      | The evaulation by the Audit system is equal to that in the original CVR, including if there are writeins, overvotes and undervotes. |
| **MODIFIED CVR**     | _These attibutes are established by the modified (adjudicated) CVR from the voting system._ |
| has_cvr_modi         | The CVR has an adjudication record for this ballot. Note that this is currently only available from Dominion with JSON CVR. If a modified record exists, it normally means that one or more contests have been modified. Just because a modified record exists does not mean that all contests were reviewed. |
| cvr_modi_overvotes   | The Adjudicated CVR detected overvotes in this contest.      |
| cvr_modi_undervotes  | The Adjudicated CVR detected undervotes in this contest.     |
| cvr_modi_writeins    | The Adjudicated CVR detected write-ins in this contest.      |
| cvr_modi_tot_votes   | The Adjudicated CVR detected at least one vote in this contest |
| audit==cvr_modi      | The Audit System evaluation matches the adjudicated evaluation. |
| cvr_orig==cvr_modi   | No change was made in this contest between the original and "modified" CVR. Note that this does not mean that the contest was reviewed by human eye and confirmed, but it might have been. |
| accepted_cvr_modi    | (deprecated, will be removed)                                |
| precinct             | (deprecated, will be removed)                                |
| sheet_agreed         | (deprecated, will be removed)                                |

### Common Variant Filters:

#### **Disagreed Hand-marked ballots (if there was no Voting System adjudication)**

| Attribute       | Setting       |
| --------------- | ------------- |
| Require All     | Selected      |
| audit==cvr_orig | Enable, False |
| is_bmd          | Enable, False |

#### **Disagreed ballots confirmed by Voting System adjudication**

Here, the original voting system evaluation did not agree with the Audit Engine evaluation but after review by the election staff, they adjudicated the CVR record and changed the evaluation to match that by AuditEngine. This is when AuditEngine did a better job than the voting system without needing any adjudication.

| Attribute       | Setting       |
| --------------- | ------------- |
| Require All     | Selected      |
| audit==cvr_orig | Enable, False |
| has_cvr_modi    | Enable, True  |
| audit==cvr_modi | Enable, True  |

#### **Agreed Overvotes**

Reviewing disagreed records will include all disagreed overvotes. But it may also be important to review overvotes in general. Since there is no mechanism in the modified record to show that the contest has been reviewed and confirmed, some election offices are routinely marking reviewed overvotes as undervotes. This may alter the statistics for overvotes improperly but is certainly a convenience to know if all overvotes have been reviewed.

| Attribute       | Setting       |
| --------------- | ------------- |
| Require All     | Selected      |
| is_bmd          | Enable, False |
| audit_overvotes | Enable, True  |
| audit==cvr_orig | Enable, True  |

#### **Agreed Writeins**

Reviewing disagreed records will include all disagreed write-ins. But it may also be important to review write-ins in general, as very commonly voters will write-in the name of a listed candidate, and then it is a vote for that candidate in voter-intent states.

| Attribute      | Setting      |
| -------------- | ------------ |
| Require All    | Selected     |
| audit_writeins | Enable, True |

## Tally Mode

This mode of operation provides a method for independently manually tallying ballot images. It is assumed that no reference to any CVR is allowed, and therefore, the style and precinct of the ballots is unknown.

### Tally Layout

The layout for Tally mode is very similar but has a different center pane.

<img src="https://s3.amazonaws.com/auditengine.org/docs/images/tally_layout.png" alt="Tally Mode Layout">

### Tally Procedure

1. Select the Job.
2. Data Source: All Ballots.
3. Click a ballot in left bar. This will open the ballot image and contests to tally in the middle.
4. Go through all contests that exist on the ballot. If the contest does not exist, then "On Ballot" should be deselected (default).
5. Click "Verified" after a second verification. This can be by the same worker or a different worker in a second pass.
6. Continue from 2 until ballots are processed.
7. Click Save

In this mode, a means to produce a report is necessary.

## Ballot Viewer Mode

In ballot viewer mode, any ballot can be viewed and compared with the CVR. There is no audit results to compare in this mode.

Note: The current implementation of this mode is incorrect. The goal will be to make this run the same way as the Adjudicator Mode, but without any AuditEngine column.

### Ballot Viewer Verification Procedure

One use of the ballot viewer is to hand-verify the cast vote record is correct when compared with the ballot images. This requires the CVR but does not require that AuditEngine is run, and there is no AuditEngine evaluation. The following procedure can be used.

1. Choose Job
2. Choose all ballots
3. Filter to specific contest(s) or precincts(s) based on CVR data.
4. Choose random sample and % or number to include in the sample.
5. Click a ballot to show the ballot image. The center pane will show all contests on this ballot instead of just one, and it will not show a AuditEngine evaluation.
6. User will click that Voting System is correct, if it is, and then check the "Checked" checkbox, either by the same worker or a secondary checker.
7. If the ballot is incorrect, then use Direct to select the exact marking on the ballot.
8. Move to the next contest included in the verification project and shown in the center pane.
9. When all contests have been verified, then move to the next ballot (left column).
10. When all ballots are completed, use File-Save and show a report.
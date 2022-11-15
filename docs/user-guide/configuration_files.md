<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />

# Configuration Files

## Job Settings File
The Job Settings File is a .csv file that is easy to edit, to provide the various settings of AuditEngine. To generate this file, go to **Audits** -- **Job Files** --  and click **[ + Create New Job File]**.
You will be asked to specify the vendor, and then you will be asked for a number of values that will mainly be used for generating the report, and are not available from the data itself.

The settings that typically can be set at this time are as follows:
 - **vendor** -- either "ES&S" or "Dominion"
 - **district_bias_desc** -- This is a string description of the district bias, based on the turnout, such as "Dark Red", "Dark Blue", "Leans Red", etc.
- **district_population** -- The total population of the district in a recent report.
- **district_population_year** -- The year of the district_population value
- **election_name** -- This is the longer name of the 
- **election_name** -- Human readable string that describes the election, like "San Francisco CA Consolidated Presidential Primary, 2020"
- **district_name** -- Human readable string that describes the district, like "San Francisco CA"
- election_year_and_type -- Human readable string that describes the election year and type, like: "Consolidated Presidential Primary, 2020"
- **voter_intent_statement** -- Statement of whether voter intent is used and the appropriate law, like "Georgia is a voter-intent state (O.C.G.A. 21-2-438 (c))."
- **results_website** -- URL to the website which provides the official results for this county.

## Election Information File
This file deals with the inconsistencies between various presentations of the same contests and options that are on the ballot. This file is not a standard file from election systems today, but it can be constructed from other data sources, such as the sample ballot, CVR File, Summary report, etc. 

NOTE: Since we are now using TargetMapper to perform computer-aided (rather than fully automated) mapping, many of the fields mentioned below are not required, and are *italicized and noted in the comments as TM-NR*, as not required when using TargetMapper.

Some elements of this data file are specifically to allow AuditEngine to process legacy CVR files.
- In legacy ES&S CVR files:
    - the header may include non-unique names, and are processed based only on their order.
    - in this case, the original_cvr_header is provided as a starting point, and then the official_contest_name is derived typically by an analyst.

| **Column Name**                | **Data<br>type**  |  **Description**  |
|--------------------------------|-------------------|-------------------|
|official_contest_name           |   str            |(Required) A brief yet correct and distinctive contest name. These must be an exact replacement for the Cast Vote Record file header. These can contain spaces and punctuation, but it is smart to limit it. Avoid newlines. |
|original_cvr_header             |   str            |(Optional column --  This column is not needed for non-ES&S systems.) This column provides the exact header from the CVR files for reference. This column can be created by copying the header line and pasting it into the spreadsheet using "paste-special" and "transpose". This column will also include the first identifying columns, such as "Cast Vote Record", "Precinct", and "Ballot Style". If the initial columns differ from those, they should be set in the JOB settings file using the 'initial_cvr_cols' directive.  |
|contest_id                      |   int            |(Optional) The numeric id of this contest  |
|bmd_contest_name                |   str            |(Optional) If BMDs are used, the this column should provide the exact string used in by the BMD for this contest in the vote summary  |
|vote_for                        |   int            |(Required) The maximum number of votes in this contest. 1 is assumed if not provided.  |
|writein_num                     |   int            |(Required) The number of "Write-in:" options provided on the ballot for this contest. If left blank, 1 is assumed. 0 means no write-in lines are provided.  |
|official_options                |   str            |(Required) List of official option names, separated by commas. The order of the options provided here is not required to match the order on the ballot. If these option names differ from what is actually printed on the ballot, then use a BOF file to define the exact text for each option (See details below).    |
|qualified_writeins | str |(Optional) List of official option names of qualified writeins. These are provided to BMDs to allow voters to vote for the official writeins and avoid random writeins that are not qualified. |
|*description*                     |   *str*          |*(TM-NR) This is the exact description of referendum or question-type (Yes/No) contests as found on the ballot. These can be entered with embedded newlines to reflect how it appears on the ballot.*  |
|*descr_num*                       |   *str*          |*(optional, TM-NR) The number of lines of text used by the description. If not provided, the lines are counted in the 'description' field. Used in cases when the description has more lines than are used for comparison, such as in multi-lingual ballots. The use of this field has been deprecated because it is better to use the 'auto_detect_descr_lines_reserve' directive, which will simply include all lines except for those reserved at the end in the OCR lines used in the comparison.*  |
| *ballot_contest_name* | *str*            | *(Required, TM-NR) The contest title as actually found on the ballot including all embellishments that are actually written, such as "(Vote for 1)". If it is exactly the same as the Official_Contest_Name, then it need not be listed. In the case of bilingual ballots, it may work best to include only the English, but it must be the first portion of the text.* |
| *contest_name_num*    | *int*            | *(Optional, TM-NR) The number of lines of text used by the contest name.  If not provided, the lines are counted in the 'ballot_contest_name' field. Used in cases when the ballot_contest_name has more lines than are used for comparison, such as in multi-lingual ballots. It is recommended that this fields be used. This is a critical value.* |
| *ballot_styles*       | *csv*            | *(Optional, TM-NR) comma separated values of ballot style_num values, for those styles where this contest is found. Leave blank if the contest is on all styles. Alternatively, the manual_styles_to_contests_table format can be used to map contests to styles.* |
| *sheet*               | *int*            | *(TM-NR)  (Optional) The sheet number where this contest is found, if a multi-sheet ballot is used. Here, sheet numbers start at 1.* |

Additional columns can be used as desired by the analyst and are ignored if not supported.
Here is a blank spreadsheet with the columns initialized: [Blank EIF Google Spreadsheet](https://docs.google.com/spreadsheets/d/1RvGoQMPXTgBvY4zwOnF9anDiw8OSScFOArqCgOPLQ8k/edit?usp=sharing) If a detailed CVR is provided, then most of the above fields are automatically generated when the starter EIF is generated.

**Additional Notes about the EIF**

FOR processing BMD ballots: we need the exact strings of the contest names and option names used in the summary. They usually differ substantially from those in the CVR. But with now our computer-aided mapping, we do not need the exact strings for names on hand-marked paper ballots.


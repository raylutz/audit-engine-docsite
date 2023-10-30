<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />

# Configuration Files

## Job Settings File
The Job Settings File is a .csv file that is easy to edit, to provide the various settings of AuditEngine. To generate this file, go to **Audits** -- **Job Files** --  and click **[ + Create New Job File]**.
You will be asked to specify the vendor, and then you will be asked for a number of values that will mainly be used for generating the report, and are not available from the data itself.

The settings that typically can be set at this time are as follows:
-  **vendor** -- either "ES&S" or "Dominion"
-  **district_bias_desc** -- This is a string description of the district bias, based on the turnout, such as "Dark Red", "Dark Blue", "Leans Red", etc.
- **district_population** -- The total population of the district in a recent report.
- **district_population_year** -- The year of the district_population value
- **election_name** -- This is the longer name of the 
- **election_name** -- Human readable string that describes the election, like "San Francisco CA Consolidated Presidential Primary, 2020"
- **district_name** -- Human readable string that describes the district, like "San Francisco CA"
- **election_year_and_type** -- Human readable string that describes the election year and type, like: "Consolidated Presidential Primary, 2020"
- **voter_intent_statement** -- Statement of whether voter intent is used and the appropriate law, like "Georgia is a voter-intent state (O.C.G.A. 21-2-438 (c))."
- **results_website** -- URL to the website which provides the official results for this county.

## Election Information File
This file deals with the inconsistencies between various presentations of the same contests and options that are on the ballot. This file is not a standard file from election systems today, but it can be constructed from other data sources, such as the sample ballot, CVR File, Summary report, etc. 

We have two primary methods for performing target mapping, and the information required differs for each.

Using TargetMapper to perform computer-aided (rather than fully automated) mapping, many of the fields mentioned below are not required, and are *marked with "required for automapping"* in the comments.

Automapping is feasible when we have ballot style masters, and if the ballot_contest names and ballot_options can be either derived from the official_contest_names and official_options, or specified using the ballot options file (BOF).

### Generating the EIF

There are three options for generating the EIF:

1. **If the CVR is available:** In the case of public oversight workflow, the CVR may be available early in the process. If this is the case, then:
   - Use stage '**cvr_to_eif**' to generate the `DRAFT_EIF_(job_name).csv` file in the params folder. 
   - Reviewed and edit this file as needed to create the `EIF_(job_name).csv` file
   - Run stage '**parse_eif**' to parse the EIF file to create the parse report and create "`cache/contests_dod.json`".
2. **If the CVR is not available, but LAT data is:** This is the case for cooperative workflow. It is essential that all contests and options are available in the official order, and the expected LAT results are normally provided in an `xlsx` file. Parsing this file will provide the EIF, as follows:
   - Use state '**noncvr_to_eif**' to generate the  `DRAFT_EIF_(job_name).csv` file in the params folder.
   - Continue with the steps outlined above
3. **If the CVR is not available and LAT data is not available:** The EIF will have to be hand-generated. Start with the file EIF_Blank.csv and hand-edit the entries. These can be found typically by referring to the official results. If the CVR is never expected to be available, then it is not necessary to make sure the names are the same. Then use **parse_eif**.

| **Column Name**                | **Data<br>type**  |  **Description**  |
|--------------------------------|-------------------|-------------------|
|official_contest_name           |   str            |(Required) A brief yet correct and distinctive contest name. These must be an exact replacement for the Cast Vote Record file header. These can contain spaces and punctuation, but it is smart to limit it. Avoid newlines. |
|original_cvr_header             |   str            |(Optional column --  This column is not needed for non-ES&S systems.) This column provides the exact header from the CVR files for reference. This column can be created by copying the header line and pasting it into the spreadsheet using "paste-special" and "transpose". This column will also include the first identifying columns, such as "Cast Vote Record", "Precinct", and "Ballot Style". If the initial columns differ from those, they should be set in the JOB settings file using the 'initial_cvr_cols' directive.  |
|contest_id                      |   int            |(Optional) The numeric id of this contest  |
|bmd_contest_name                |   str            |(Optional) If BMDs are used, the this column should provide the exact string used in by the BMD for this contest in the vote summary  |
|vote_for                        |   int            |(Required) The maximum number of votes in this contest. 1 is assumed if not provided.  |
|writein_num                     |   int            |(Required) The number of "Write-in:" options provided on the ballot for this contest. If left blank, 1 is assumed. 0 means no write-in lines are provided.  |
|official_options                |   str            |(Required) List of official option names, separated by commas. The order of the options provided here is not required to match the order on the ballot. These option names should be exactly what is used in the CVR. <br /><br />Sometimes, this list will provide both the listed options and the qualified writeins, with the official options having an UPPER CASE last name. Use the setting 'treat_nonupper_options_as_writeins_for_mapping_contests_dod' to True and these will be split into the ballot_options and the qualified_writeins.<br /><br />Notes on list formatting: This string should be a comma-separated list of values. If there are commas in the name, surround the option with double quotes. If there are embedded quotes, escape them with a backslash '\\'.<br />Thus, for **Michael "The Fonz" Johnson, Jr** you'll need to enter: **"Michael \\"The Fonz\\" Johnson, Jr"**    |
|ballot_options | str |This should be a comma-separated list of the options as exactly shown on the ballot, and should be in the same order and same number as the official_options that are not treated as qualified_writeins. This is required for both manual mapping using TargetMapper and for automapping. The Notes on list formatting apply. |
|qualified_writeins | str |(Optional) List of official option names of qualified writeins. These are provided to BMDs to allow voters to vote for the official writeins and avoid random writeins that are not qualified. The Notes on list formatting apply. |
| *ballot_contest_name* | *str*            | *(automapping) The contest title as actually found on the ballot including all embellishments that are actually written, such as "(Vote for 1)". If it is exactly the same as the Official_Contest_Name, then it need not be listed. In the case of bilingual ballots, it may work best to include only the English, but it must be the first portion of the text.* |

Additional columns can be used as desired by the analyst and are ignored if not supported.
Here is a blank spreadsheet with the columns initialized: [Blank EIF Google Spreadsheet](https://docs.google.com/spreadsheets/d/1RvGoQMPXTgBvY4zwOnF9anDiw8OSScFOArqCgOPLQ8k/edit?usp=sharing) If a detailed CVR is provided, then most of the above fields are automatically generated when the starter EIF is generated.

**Additional Notes about the EIF**

**For processing BMD ballots:** we need the exact strings of the contest names and option names used in the summary. They may differ substantially from those in the CVR. This is now handled with the additional file `BMDIF_(jobname).csv`, which can be edited much later in the process, particularly with cooperative workflow, since we need the ballot images to check these and update the information. It is best not to go back and modify the EIF because it then will require rebuilding the intervening stages.

**For Automapping from Ballot Style Masters:** When we have the ballot style masters, automapping can proceed without using the TargetMapper app, and with much less room for human error in the process. If automapping does not initially complete, it will generate a `DRAFT_BOF_(job_name).csv` file in the params folder. This spread sheet can be edited to select the strings as found on the ballot and associate them with the official option names. This will occur later in the pipeline.

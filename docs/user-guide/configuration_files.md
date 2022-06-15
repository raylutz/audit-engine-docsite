## Configuration Files

### Job Settings File
The Job Settings File is a .csv file that is easy to edit, to provide the various settings of AuditEngine.

### Election Information File
This file deals with the inconsistencies between various presentations of the same contests and options that are on the ballot. This file is not a standard file from election systems today, but it can be constructed from other data sources, such as the sample ballot, CVR File, Summary report, etc. NOTE: Since we are now using TargetMapper to perform computer-aided (rather than fully automated) mapping, many of the fields mentioned below are not required, and are noted in the comments as TM-NR, as not required when using TargetMapper.

Some elements of this data file are specifically to allow AuditEngine to process legacy CVR files.
- In legacy ES&S CVR files:
    - the header may include non-unique names, and are processed based only on their order.
    - in this case, the original_cvr_header is provided as a starting point, and then the official_contest_name is derived typically by an analyst.

| **Column Name**                | **Data<br>type**  |  **Description**  |
|--------------------------------|-------------------|-------------------|
|official_contest_name           |   str            |(Required) A brief yet correct and distinctive contest name. These must be an exact replacement for the Cast Vote Record file header. These can contain spaces and punctuation, but it is smart to limit it. Avoid newlines. | 
|original_cvr_header             |   str            |(Optional column) This column provides the exact header from the CVR files for reference. This column can be created by copying the header line and pasting it into the spreadsheet using "paste-special" and "transpose". This column will also include the first identifying columns, such as "Cast Vote Record", "Precinct", and "Ballot Style". If the initial columns differ from those, they should be set in the JOB settings file using the 'initial_cvr_cols' directive. (This column is not needed for non-ES&S systems.)  | 
|contest_id                      |   int            |(Optional) The numeric id of this contest  |
|ballot_styles                   |   csv            |(Optional, TM-NR) comma separated values of ballot style_num values, for those styles where this contest is found. Leave blank if the contest is on all styles. Alternatively, the manual_styles_to_contests_table format can be used to map contests to styles.  |
|sheet                           |   int            |(Optional) The sheet number where this contest is found, if a multi-sheet ballot is used. Here, sheet numbers start at 1.  |
|ballot_contest_name             |   str            |(Required, TM-NR) The contest title as actually found on the ballot including all embellishments that are actually written, such as "(Vote for 1)". If it is exactly the same as the Official_Contest_Name, then it need not be listed. In the case of bilingual ballots, it may work best to include only the English, but it must be the first portion of the text.  |
|contest_name_num                |   int            |(Optional, TM-NR) The number of lines of text used by the contest name.  If not provided, the lines are counted in the 'ballot_contest_name' field. Used in cases when the ballot_contest_name has more lines than are used for comparison, such as in multi-lingual ballots. It is recommended that this fields be used. This is a critical value.  |
|bmd_contest_name                |   str            |(Optional) If BMDs are used, the this column should provide the exact string used in by the BMD for this contest in the vote summary  |
|vote_for                        |   int            |(Required) The maximum number of votes in this contest. 1 is assumed if not provided.  |
|writein_num                     |   int            |(Required, TM-NR) The number of "Write-in:" options provided on the ballot for this contest. If left blank, 1 is assumed. 0 means no write-in lines are provided.  |
|official_options                |   str            |(Required) List of official option names, separated by commas. The order of the options provided here is not required to match the order on the ballot. If these option names differ from what is actually printed on the ballot, then use a BOF file to define the exact text for each option (See details below).    |
|description                     |   str            |(TM-NR) This is the exact description of referendum or question-type (Yes/No) contests as found on the ballot. These can be entered with embedded newlines to reflect how it appears on the ballot.  |
|descr_num                       |   str            |(optional, TM-NR) The number of lines of text used by the description. If not provided, the lines are counted in the 'description' field. Used in cases when the description has more lines than are used for comparison, such as in multi-lingual ballots. The use of this field has been deprecated because it is better to use the 'auto_detect_descr_lines_reserve' directive, which will simply include all lines except for those reserved at the end in the OCR lines used in the comparison.  |
|qualified_writeins              |   str            |(Optional) List of official option names of qualified writeins. These are provided to BMDs to allow voters to vote for the official writeins and avoid random writeins that are not qualified.  |

Additional columns can be used as desired by the analyst and are ignored if not supported.
Here is a blank spreadsheet with the columns initialized: [Blank EIF Google Spreadsheet](https://docs.google.com/spreadsheets/d/1RvGoQMPXTgBvY4zwOnF9anDiw8OSScFOArqCgOPLQ8k/edit?usp=sharing) If a detailed CVR is provided, then most of the above fields are automatically generated when the starter EIF is generated.

#### Additional Notes about the EIF
FOR FULLY AUTOMATED MAPPING, the following applies. This method is now no longer being used and computer-aided mapping is used instead. However, these statements still do apply when processing BMD ballots as the exact strings of the contest names and option names must be provided.<p>

The data in the EIF is extremely critical to get exactly right so that Audit Engine will be able to successfully map the contests to the OCR'd strings from the ballot. If the information is not exactly correctly, it can be found out and corrected during the mapping process, but it will take a lot more time and effort to do it then. Here are some areas which should be carefully checked.

1. *official_contest_name* is the internal name for that contest. It is best if these are short to conserve space and yet easy for humans to distinguish from each other.<br><br>
2. *ballot_contest_name* and *contest_name_num* are critical to get correct. This is because Audit Engine uses these values to match the contest and then look for the options in "fully_joined" layout, i.e. where the contest title is in the same box on the ballot as the options. The actual ballot image should be reviewed to determine the number of lines used by the contest header. When counting lines, do not count blank lines. <br><br>In the case of yes/no contests that have a description, it may be somewhat arbitrary where to split the contest name from the rest of the description. For example, if there is a title and a subtitle, it may be best to include both of these in the ballot_contest_name, particularly if the contest names are otherwise somewhat similar. "Constitutional Amendment I" does not differ much from "Constitutional Amendement II" and thus adding the subtitle can be a smart move. Another way to deal with this is to set 'question_contests_have_no_contest_name' to TRUE and then just put all the text in the descr.<br><br>
3. *descr* is the other component of the issue described above, and must not include additional lines that are also in the *ballot_contest_name*. *descr_num* has been deprecated, and instead you should use 'auto_detect_descr_lines_reserve' to set how many lines should be set aside at the bottom of the region for Yes and No options, usually 2. If you include the 'auto_detect_descr_lines_reserve' directive, then all the lines in the ocr'd text are matched with the descr except for those reserved at the end for the Yes/No options. It is not necessary to include all the lines of the description in the descr field, just enough to thoroughly distringuish it from all other descr fields, and the fuzzy matching algorithm attempts to match left-justified.

### Ballot Options File (BOF)
A BOF is required only if the options as printed on the ballot differ substantially from the official_options as provided in the EIF, and now only for BMD ballots. This file includes (at least) three columns, as follows. This file need only provide records for those options that need to be substituted.

|  **Column Name**                 |  **Data<br>type**  |  **Description**  |
|----------------------------------|--------------------|-------------------|
|official_contest_name             |   Str              |The same contest name as provided in the CVR as official_contest_name.  |
|official_option                   |   Str              |A ballot option as listed in official_options in the EIF  |
|ballot_option                     |   Str              |(These now only needed for BMD options. The option as listed on the ballot, exactly as provided, including newlines. The ballot options are sometimes very different, particularly if they list a candidate pair, such as for Governor and Lieutenant Governor, or President and Vice President, listed on separate lines. If the ballot has separate lines, then they must be entered as separate lines in the BOF spreadsheet. This can usually be done by using CONTROL-ENTER. Please note: Audit Engine cannot support options with differing number of option lines for the same contest. If the line on the ballot has the party designation, it is good practice to include that in the BOF to enhance success of matching options. For example "Joe Blow (DEM)" can be entered as the ballot option while "Joe Blow" might be the official option.  |
|ballot_option_num                 |   int              |(optional TM-NR) The number of lines of text used by the ballot_option. If not provided, the lines are counted in the 'ballot_option' field. Used in cases when the ballot_option has more lines than are used for comparison, such as in multi-lingual ballots.  For a single contest, all ballot options must have the same number of lines. |

Additional columns can be used as desired by the analyst and are ignored if not supported.t
Here is a blank spreadsheet with the columns initialized: [Blank BOF Google Spreadsheet](https://docs.google.com/spreadsheets/d/1HxTlx_i11zGrrYUViJOPZZMIg-iYh4_Y5BjjKY4SIzk/edit?usp=sharing)


**1. Setup and Upload Data, Perform Consistency Checks:** Create the Election and an Audit Job on our website and upload ballot images, cast vote records, and PDF ballot style masters, and any aggregated reports that are available. Create a *Election Information File (EIF)* which provides the official names of the contests and options. This is normally determined by the CVR and then edited by hand for the exact strings used on BMD ballots. The components of this phase became more involved than we expected due to variations of the data provided, particularly when there are repeated ballot images, differences between the CVR and ballot images, and the like. The result of this phase can be an invaluable check that the data matches other aspects of the election, such as the official number of ballots cast.

Stages in this Phase:

- **precheck** - simply list all the input files associated with the audit.
- **gen_biabif** - review all the images files and extract metadata, including filenames, sizes, and any election metadata such as precinct, groups, etc. that may be encoded in the pathnames. The "BIF" is the ballot information established as a set of CSV (character separated values) tables. Any records where duplicate ballot_ids are located are segregated out in another residue table.
- **cvr_to_eif** - if the CVR is available, then the EIF (Election Information File) can be generated directly from the CVR data. This produces the DRAFT_EIF. This may need to be amended by hand to include the exact strings used on BMD ballots or the number of write-ins if that is not directly provided.
- **parse_eif** - After any changes have been made, then it is parsed and incorparated as the constests_dod.json file.
- **preparse_cvr** - for ES&S, the CVR is provided in .xlsx format with some issues regarding column names and embedded images. These are preparsed to create simpler and easier to handle CSV format files. For Dominion, this stage is not needed.
- **gen_cvrbif** - Create the cvr_bif, which is the metadata from the CVR, for each record in the CVR. Please note, the cvr_bif records are in a different order from the bia_bif. Again, these tables are in CSV format.
- **combine_bifs** - This stage essentially performs a full outer join of the biabif and cvrbif to create the biacvr_bif. This contains all the records that are in the BIAs amended with metadata from the cvrbif.
- **gen_fullbif** - This stage is not always required and cost saving can result if we have full style information for each record in the CVR. If not, this stage essentially generates that style information. If we are unsure the how the style information in the CVR relates to the style information from the ballot images, it is necessary. It involves a fairly expensive ballot image evaluation of all hand-marked (nonBMD) ballot images to extracts only the style indication. This stage does not process BMD ballots. As a result, the full_bif is created, which now includes the metadata extracted from the images for nonBMD ballots. This stage is parallel processed in the cloud with up to 10,000 computers and usually 100 images processed each.
- **create_bif_report** - At this point, the BIF report is generated which provides a summary of all the metadata and provides a chance to check the consistency of the data between the CVR, BIA listing and ballot images, and to help determine how ballot style information will be handled.

**2. Create Style Templates** **and Map the Styles**: Ballot image data is processed to create style templates based on the style strategy determined by reviewing the bif_report. Style templates are generated from the ballot image data itself, by combining up to 50 base images to clarify and improve the fidelity of the templates. 

Note: To be able to expedite turn-around during elections when AuditEngine is used in cooperation with election districts, this phase is completed in an audit using the Logic and Accuracy Test (LAT) data, and then in the real election, AuditEngine can be configured to only use *import_targetmap* from the LAT audit job, and the subsequent stage will be *extractvote*. This eliminate the time consuming stage involving human-eye assistance to map the data.

Stages in this phase:

- **build_template_tasklists** -- by reviewing the full_bif with style information determined, these are grouped to provide a list of 60 ballots which are candidates to combine, if at least 60 ballots are available. Otherwise, it lists as many as are available.
- **gentemplates** -- This stage combines the best up to 50 candidate ballots to form clarified and improved template images for each style. This is run in parallel, with one computer allocated to each style.
- **gen_templates_report** -- This stage creates a report of the operation of the gentemplates stage.
- **gen_target_mapper_package** -- After reviewing the quality of the templates, then the data is packaged up for use by the TargetMapper App.
- **Run TargetMapper** -- This is an AuditEngine app which provides a user-friendly and powerful interface to generate the target map. This can be a time consuming step, depending on the number of styles and the complexity of the election. For average elections, this can take about half a day, including checking the redline_proofs.
- **import_targetmap** -- the file 'targetmap.json' is imported and checked for consistency. If there are any mapping issues, then this will generate an error message to help the user locate the mis-mapping. If an error occurs, then the user Runs TargetMapper again, unlocks it to allow changes, and makes the corrections, then relocks it, and then this stage is run again until no errors remain.
- **gen_all_redlined_proofs** -- These images are derived from the templates and then red annotation is added to allow them to be checked. This stage simply creates the images.
- **gen_styles_report** -- This report provides a list of all the styles and provides the redline proof of that style to allow for quality assurance checks of the mapping.

**3. Vote Extraction**: Process all images again, but this time including BMD ballots, and create an independent tabulation. The CVR is not used at all during this phase.

Stages used in this phase:

- **extractvote** -- This stage uses the map which was imported in the prior phase and fully checked for consistency. It pulls the ballot images directly from the ZIP archives and extracts the votes from each ballot, including BMD and nonBMD ballots, and creates the 'marks' data file which provides the evaluation of every target or BMD ballot selection. AuditEngine does this step using parallel processing in chunks of usually 100 ballots per chunk in one computer, using up to 10,000 computers in parallel. It uses adaptive thresholding to convert the marks into votes, and uses a set of heuristics to make good guesses when there are hesitation marks or cross-outs. Performs OCR on all BMD ballots to "read" the text so the QR codes are not relied upon.
- **gen_extractvote_delegation_report** -- This report details the status of all delegations and CPU time used for each one.

**4. Comparison and reporting:** The tabulation created by AuditEngine is then compared ballot-by-ballot with the official results and any variants and disagreements are categorized into more than 40 categories, followed by automated report generation.

Stages used in this phase:

- **cmpcvr** -- short for "compare CVR". This processes the result of the extractvote stage by comparing the evaluation of each ballot with the official result. For Dominion, it also compares with the pre-adjudicated and post-adjudicated snapshots in the CVR.
- **gen_cmpcvr_report** -- the produces the full discrepancy reports, including pie charts and reports by precinct and by contest. Details the first (usually) 50 variants from the first 10 contests, the closest 10 contests, and the 10 most variant contests, as well as the 10 most variant precincts. This is a lengthy report that is best viewed on the web to be able to look at the details of each variant ballot.
- **gen_source_audit report** -- this compares the aggregated totals from the 'source' archives with the official results. The 'source' archives are the main ballot image archives.
- **gen_final_report** -- This generates a short report which provides links to the other reports.
- **hard_lock_job** -- This stage simply locks the job so it cannot be altered in the future. This is a sematic lock.

**Other Optional Stages:**

There are a number of optional stages that are sometimes used:

- **gen_verify_bia_bif** -- this stage processes verification images which are scanned using scanners that are not part of the voting system, to provide a check on the images to detect possible image manipulation.
- **extract_verify** -- this stage is like extractvote but it uses the verification image archives. The verification images use the same map which was generated for the 'source' (main) images.
- **gen_verify_audit_report** -- this compares the verification samples with the official results on an aggregated basis.
# ScanEngine App

State regulations frequently call for scanning some or all ballots using a scanner(s) independent from the primary voting system, and then evaluating these images using a Ballot Image Auditing (BIA) platform or a secondary voting system. AuditEngine has a companion application called ***ScanEngine*** to manage this process so it can be handled in an error free manner.

Batches of ballots scanned by a scanner that is independent from the voting system can create "Verification Images" which can be processed to mitigate the hazard that hacks were implemented in the voting system to alter the images. 

A separate *ScanEngine* application runs on a computer associated with each COTS (Commercial off the shelf) high-speed scanner within the secure air-gapped environment of the election office. This application maintains a rigorous chain of custody to track batches scanned and any issues (jams, etc) during scanning a batch without repeating or missing images in the process.

Separator sheets can be used with barcodes provide file name prefixes and group ballot images into batches, to provide additional information about ballots that are imaged which are not included in the ballot style designations, and provide information to create file names and batches.

*ScanEngine* places all images for the current batch into a temporary holding area until all ballots are correctly scanned. If the batch must be re-scanned, then the ballots in the holding area are erased and replaced with new scans. For each batch successfully scanned, the images in the holding area can be transferred to the main area and placed in a sub-folder with the same batch designation.

Separator sheets can be kept with the physical ballots to document that batch. When each batch is completed, it recommended that the separator sheet be placed on top of the batch of ballots and all ballots enclosed in a zip-lock plastic bag, and then returned to the ballot carrier box.

*ScanEngine* maintains a log which describes the time that each ballot is scanned, whether it was successful, and whether the batch is accepted, if any rescanning of batches occurs, and details about any error (jams, etc) that occur.

*ScanEngine* may check the fidelity of the ballot scanned but it does not perform ballot interpretation. It creates high-fidelity scans only.

The images are written directly to USB media, hand-carried out of the air-gapped environment, and uploaded to the AuditEngine.org website for further processing. A Hardware Security Module (HSM) can be used to sign the resulting files using a private key. For example, the Yubico HSM https://www.yubico.com/product/yubihsm-2-series/yubihsm-2-fips/.

## Use Cases

For each of these use cases, we recommend very strongly that a full ballot image audit is performed to cover all ballots and all contests in addition to any further processing of scanned paper ballots. When the original images are utilized, they are indexed to the Cast Vote Records, and therefore we can get much higher diagnostic power in the comparison process rather than rescanned ballots because they tend to be not correlated to the CVR. One additional benefit of using AuditEngine is that there is no dependency on the voting system determination of the margin of victory, which is used to determine the samples required.

- **Scan-centric workflow:** When state law requires that an automated audit rescans physical ballots, either on a sampling basis (such as 20% of the precincts) or exhaustively (all ballots), *ScanEngine* can support the scanning required. The scanned images must be grouped identically as the groups used in the voting system to be able to compare if not all the ballots are included in the scanning operation. 

- **Verification scans:** For election districts that use a voting system that produce ballot images which are already being fully audited by *AuditEngine*, *ScanEngine* can be used to scan batches as a check that the images were not altered. The scanned images must be grouped identically as the groups used in the voting system to be able to compare, and run by *AuditEngine* as "Verification Images".

- **Creating Auditable Images from Legacy Voting Systems:** For any election districts that do not use voting machines that produce ballot images, *ScanEngine* can provide images to perform a ballot image audit of the results. Cover sheets can be produced based on the precinct or batch as they are stored, and thereby provide that additional metadata about the ballots scanned in the images. The ballot images can be scanned with complete chain of custody tracking.

- **Ballot-Image Driven RLAs:** When performing Risk-Limiting Audits (RLAs) that utilize examination of paper ballots, these can be done by utilizing *ScanEngine* to reduce the cost of performing the audit and improve transparency. <BR><BR>It is unfortunately the case that these audits are difficult to observe and provide public oversight, since it is necessary to sit right there and watch as the votes are being entered into a DRE-like interface. Instead, once the samples are pulled, we use *ScanEngine* to scan those paper ballots, and then use *AuditEngine* to extract the votes and compare with the official results. The tool *AdjudiTally* can be used by auditors or the public to review the ballot images involved in the audit and verify the automated evaluation.
  - **Ballot Polling Audit:** In a ballot polling audit, random ballots are pulled from all ballots and they do not need to be indexed or grouped in any way. The ballots are typically required to be pulled from a specific location such as pallet, box, batch, and offset within the batch. We recommend that a cover sheet is printed for every ballot to be fetched. Then, when the ballot is scanned using *ScanEngine*, the cover sheet is also scanned to identify from where it was drawn, and also to allow returning that ballot to that location. Once the ballots are scanned, then are evaluated by AuditEngine without comparing each ballot to the original CVR (which may not exist), and an independent margin is evaluated for the sampled set. If the margin is within the calculated boundaries, then the risk limit is satisfied.
  - **Batch Polling Audit:** This method is not discussed much by RLA supporters, but it is a viable method for performing RLAs, particularly when *ScanEngine* is utilized. The number of ballots is not reduced from the number required in the ballot polling audit, but the sampling process is much easier, as entire batches are selected randomly. They are scanned using *ScanEngine*, the vote is extracted using *AuditEngine*, and the resulting margin for contests is compared with the official margin, and if within the calculated boundaries, then the risk limit is satisfied. As with the Ballot Polling Audit, this does not require any comparison on a ballot-by-ballot or batch-by-batch basis. It also does not break up batches and it does not require returning individual ballots to their original location within batches. This also has fewer hazards for malicious acts during the audit because batches remain sealed until rescanned.
  - **Batch Comparison Audit:** This method is the same as the batch polling audit, but it requires that the batches are identified in the CVR (or by *AuditEngine*), so they can be compared with physical batch. Unfortunately, not all voting systems identify batches. Dominion does, for example, but ES&amp;S does not. When not identified, then RLA comparison audits are not feasible.<BR><BR>
    In this method, batches are randomly selected, cover sheets printed, and are fetched from physical storage, and then scanned using the cover sheet identifying the batch. Once scanned, the batches can be processed by AuditEngine to evaluate the vote and compare with the batches in the CVR to determine the number of overstatements and understatements in each batch, and then evaluating the risk.

  - **Ballot Comparison Audit:** If there is a way to identify individual ballots in storage and index them to the CVR, we can conduct a ballot comparison audit using *ScanEngine* and *AuditEngine.* For each ballot randomly selected, a cover sheet is prepared which is used as the fetch request, as well as to inform *ScanEngine* how to label the images when scanned. Preferably, each will use the official ballot_id for that ballot. For example, let's say there are 200 ballots required in the Ballot Comparison RLA. 200 cover sheets are prepared, and the ballots are accessed from physical storage. The stack of documents to be scanned include the cover sheet for each ballot, and then one ballot, alternating, resulting in 400 total sheets to scan. Once scanned, the vote on each ballot can be evaluated by *AuditEngine*, the ballots directly compared with CVR records that already exist, and then calculate the risk.

  All of these audits should include a phase where the sample is further sampled, for 1:1 comparison of the images to the physical ballots.

## Example Workflow

1. **Create Batches:** The user separates ballots into batches of a convenient size, of about 200 ballots, for example. This can be commonly done using a counting scale. Each batch should have fewer than half the ballots in the automatic document feeder (ADF), and those typically can handle 500 sheets. If batches are already determined when originally scanned, these can be used as-is. Random selection of batches may be appropriate for verification scan creation.
2. **Name Batches:** Using *ScanEngine*, the user enters the GROUP and BATCH, like EV_1000. EV is the Group, Early Voting EV. This can be any string. This will be the prefix of the filename.
3. The workflow can be run with separator sheets or manually.
   - **Separator Sheets:** 
      1. The prefix is expressed on a separator page with a code-39 barcode. This separator page is printed using a co-located laser printer.
      2. The separator page is placed on top of the batch 
      3. The batch is loaded into the ADF feeder (Automatic Document Feeder) of a high-speed scanner, such as the Ricoh fi7090 or Canon DR-G2140, for example.
      4. As the scanning of the batch proceeds, the *ScanEngine* software detects the separator sheet and begins a new batch.
         In normal (non-error) flow, the code from the separator sheet is used to determine the file names in the batch. 
      5. The user can concurrently prepare the next batch and load it into the ADF when convenient. If another separator page is encountered, that will signal the end of the batch. The ability to load the ADF while scanning is not feasible with all scanners.
      6. If there is no error, the scanner would continue onto the next batch without stopping, and start the new batch based on the separator page.
   -  **Manually:**
      1. The user enters the prefix for the batch manually into the ScanEngine App.
      2. The user places the batch without a separator page into the ADF.
      3. The user waits for the timeout to occur before loading the next batch.
4. **Image Staging Area:** The images in the batch are copied to a staging directory, as they are scanned. 
5. **Fully Logged:** A log is produced showing the progress of each ballot in the batch.
6. **Image Final Area:** If the batch is completed without error, then the images in the batch are copied to the final area. Signed hashes are provided for each image scanned. These images can be written directly to USB drive so there is no connection to the voting system environment, and there is no connection to the Internet.
7. **Return Batch:** The operator removes the scanned batch from the output tray of the scanner and the separator page is kept on the top of the batch for identification purposes. We recommend that the operator would seal the batch into packaging, such as a tamper-evident zip-lock bag, which can show the cover sheet while also maintaining integrity of the batch, and place it in the box holding the ballots. In this way, the batch can be identified later. If any ballots had to be remade, then the batch may need to be put aside so the ballot can be returned to the batch before storage.
8. **Error Flow:** In the case of an error, the images captured in that batch would be deleted in the staging area, and the user alerted to the failure. Sometimes, it is possible to remove the offending ballot, if it is not scannable due to being damaged, and then run the batch without that ballot. Instructions are provided to the user for error recovery.
9. **Remaking ballots:** Any ballots that are damaged and cannot be scanned can be combined into another batch, or they can be scanned on a co-located flatbed scanner and kept with the batch.
10. **USB Drive:** After all scanning is completed, the USB drive is removed and then hand-carried out of the secure air-gapped environment, and then uploaded to the AuditEngine datacenter for processing.
11. **Random spot checks:** As the scanning progresses, the user is able to review the fidelity of the images and compare with the paper on a random inspection basis, either as they are being scanned or later, because the batches are identified in storage and in the archives.
12. **Public Oversight:** A livestream camera should be positioned to record the activity in the scanning process, and simultaneously show the log as it being generated. If used, random number generation should use ten-sided dice in a public meeting to create the seed of a random number generator or to directly select the batches to be included.

## Batch Scan Dialog

*ScanEngine* uses a "Batch Scan" dialog similar to the dialog box shown here to manage the scans. Users can enter the filename prefix manually, or use the prefix from the code-39 barcode on separator sheets to derive the filename.

![img](https://lh7-us.googleusercontent.com/YXvokW-U5L7NarnCaZQtFUIiYpW001es5jCXKvTcDRTp89vJ72eJmAi2ODGEDLq5o7vbX0Fl-M-qJt-k3tsA2fEXi3JoDmwRJB6VuoBVeyRrpM23LDENSYtrsab0CJppzyioF90puEWnemjzFL_THV0)

## Recommended COTS Scanners

It is recommended that the ScanEngine app be paired with a commercial off-the-shelf high-speed scanner that will image both sides of each ballot (duplexing) using an automatic document feeder (ADF). The following scanners are available for this purpose.

### Canon DR-G2140

Canon has several similar products in this category, differing by scanning speed. The top speed is obtained by feeding letter sheets in landscape orientation and is not achievable for ballot scanning, as these ballots tend to be larger than letter size,  8.5" wide by 14", 17", 19", or 21" in length. so they must be scanned with short-edge first. The scanning speed may also be limited by the USB port, and such limits can be avoided by selecting B&W and 200 dpi, which is a common resolution and color for ballots. List price in 2023: $7,970.00. Replacement rollers are easy to obtain from $29.95 for "compatible" vendor to $90 for Canon official rollers. The claimed duty cycle for the rollers is 450K pages. This scanner and other similar products in the same family is our top recommendation due to the easy availability of the rollers and high recommendations by users.

https://www.usa.canon.com/shop/p/imageformula-dr-g2140-production-document-scanner

![img](https://lh7-us.googleusercontent.com/ZMhsA22gbDgyQoSa0o9-m7W2UOlsy_0flcqff8qR_tmdd_959Pykox3tD9Tf3ZYcm5qspamfO6A82w4TADyDXa1kmVj6dM0SrwGDQuPohvouZFPjN8ROhnLGlMj6T9mmVSi88o2V3fDVOnXJLv8Klaw)

### Ricoh fi7090 or fi7800

Ricoh Corporation recently purchased Fujitsu, including their line of high-volume and high-speed production grade scanners, which they have rebranded as Ricoh products but they are keeping the same model names. The fi7090 is a good example of a scanner suitable for scanning verification ballots. However, it appears their current product is the fi7800 series, which is a little slower, at only 110 ppm. List price in 2023, fi7800: $10,425; fi-7900: $15,159. Pickup roller set $45, Brake Rollers $65 from Ricoh website only. ($110 total) Roller duty cycle: 600K. 

https://www.pfu-us.ricoh.com/scanners/fi/fi-7800



![img](https://lh7-us.googleusercontent.com/ohuL1xyRAl5KxnGQrWO66_A3QOjQOKc68_hm-W1EXPaGRKobj-y4RY90PvDJanib45lGeKUPuOqGuhQsTgW5bMnMTOk7TtQziYZvERNNmO_jmVvf59AHoxvutF20rs6Dr2Ohe1QXa-5kd3J6NqjaIQM)



The rated scanning speed of the fi7090 is 140 ppm (sheets per minute) and 280 ipm (duplex) can be achieved only if letter-size pages are fed in landscape orientation (long-edge first), and thus it is limited to letter (11" / A4) sheets. When fed in portrait orientation (short edge first), the rated speed is 105 sheets per minute and 210 ipm (images per minute, i.e sides). Longer sheets will be a bit slower.

### Xerox W110 Scanner

Scan speeds up to 120 ppm / 240 ipm; 100,000 pages daily duty cycle; 500-page adjustable input tray*. List price in 2023: $5,995. This scanner is a competitive price, and can be purchased for $4K on Dell.com. A maintenance kit, however, is $249 and hard to find. Stated duty cycle on rollers is 550K. However, reviewers say that the rollers need to be changed frequently, probably once every 100K pages. So although it looks attractive at first, this scanner may be more expensive when the cost for replacement rollers and possible delays in purchasing them are factored in.

Also, Xerox W130, scan speeds up to 135ppm / 270 ipm, with USB or Gigabit Ethernet to PC with Imprinter ($8,995)

https://www.xeroxscanners.com/en/us/products/item.asp?PN=W110

![image-20231106171247122](https://www.xeroxscanners.com/images/products/W110/W110_img1.jpg)

## File Naming is Critical

It is important to use file names that can be re-sorted to the right order if they should become shuffled. This is particularly important if a separate image file is used for each side of a ballot, which is common because PNG format only has one side per file. The underlying problem is that the names can be added to the ZIP archives according to how they are listed rather than the order they were created. When looking at the zip file, we can't get them back in order without a lot of work. We need to be able to sort them to return them in the original order. It is particularly important that we can get the front and back back together.

**Please adhere to the following rules:**

- Keep file names relatively short and meaningful. 
- Any number fields should be fixed-length and long enough to avoid overflow and create a number with more characters. For example, you should not ever see a number roll from 999 to 1000. But 0999 to 1000 is okay.
- If there is more than one number field, the first number field must not be reused even if the second number field has different range numbers.
- Non-number fields should be simple and just a few characters. Do not use any special characters. Do not include any spaces. The file name should be usable without the file extension as the ballot_id. Non-numbers can be used to indicate the GROUP of the ballots, such as EV, ED, MIB, PROV, etc. This can be first. Then there can be a batch number and sequence number.
- Use underscore "_" to separate groups of characters or numbers.
- If two images are created for each page, they should be numbered so the order can be restored when resorted using a lexical (default) sort. Try to keep the images in front-back order. This should be normal for any duplexing scanner. 
- Make sure that all ballots are imaged with the same number of pages. If both sides are included, they must be included for all  ballots in the set. If only the front is included, a random back should not also be included.
- It is okay to have prefixes indicating the archive, like D001, D002, the precinct, group, etc. Always use fixed-length fields if numbering is used. Make sure it will be easy to parse the name to extract any meaningful data.
- Try to keep the top of the images all inserted the same way.

**Examples:**

- GOOD: 

  - EV1_00004_000001.png, 
  - EV1_00004_000002.png,
  - ...
  - EV1_00004_009678.png, 
  - EV1_00005_000001.png,
  - etc.

- BAD: 

  - "scans from john's laptop - precincts 1 - 14 - 001_002"
  - ... 
  - "scans from john's laptop - precincts 1-14 - 2000_002"
  - and
  - "scans from johns laptop pcts 1-14 - 001_4653"

  Notice special characters, spaces, different lengths, varying spaces, reused ranges.

**How to recover from bad naming procedures:**

1. Analyze ranges of names that exist in the set of images and plan a simple file naming scheme.
2. Use existing numbers when possible and make sure you record how you renamed the original names to the new names.
3. Unzip the zip files into separate folders so they can be renamed. Make sure names are unique among all folders.
4. Use existing tools like Bulk Rename Utility (BRU) "https://www.bulkrenameutility.co.uk/" to quickly rename them.
5. re-ZIP the files using a tool like 7zip.org, but please use conventional ZIP format not 7z format. 

## Conclusion

The ScanEngine App is specifically suited to scanning ballots using a COTS high-speed duplexing scanner to produce images that can be incorporated in various auditing workflows. ScanEngine provides the chain of custody tracking of each ballot scanned, as well as each batch scanned, and can use separator sheets with barcodes to help to organize the images and physical ballots.

# ScanEngine App

State regulations frequently call for scanning some or all ballots using a scanner(s) independent from the primary voting system, and then evaluating these images using a Ballot Image Auditing (BIA) platform or a secondary voting system. AuditEngine has a companion application called ***ScanEngine*** to manage this process so it can be handled in an error free manner.

Batches of ballots scanned by a scanner that is independent from the voting system can create "Verification Images" which can be processed to mitigate the hazard that hacks were implemented in the voting system to alter the images. 

A separate *ScanEngine* application runs on a computer associated with each COTS (Commercial off the shelf) high-speed scanner within the secure air-gapped environment of the election office. This application maintains a rigorous chain of custody to track batches scanned and any issues (jams, etc) during scanning a batch without repeating or missing images in the process.

Separator sheets can be used with barcodes provide file name prefixes and group ballot images into batches, to provide additional information about ballots that are imaged which are not included in the ballot style designations, and provide information to create file names and batches.

*ScanEngine* places all images for the current batch into a temporary holding area until all ballots are correctly scanned. If the batch must be re-scanned, then the ballots in the holding area are erased and replaced with new scans. For each batch successfully scanned, the images in the holding area can be transferred to the main area and placed in a sub-folder with the same batch designation.

Separator sheets can be kept with the physical ballots to document that batch. When each batch is completed, it recommended that the separator sheet be placed on top of the batch of ballots and all ballots enclosed in a zip-lock plastic bag, and then returned to the ballot carrier box.

*ScanEngine* maintains a log which describes the time that each ballot is scanned, whether it was successful, and whether the batch is accepted, if any rescanning of batches occurs, and details about any error (jams, etc) that occur.

*ScanEngine* may check the fidelity of the ballot scanned but it does not perform any ballot interpretation.

The images can be written directly to USB media, hand-carried out of the air-gapped environment, and uploaded to the AuditEngine.org website for further processing. A Hardware Security Module (HSM) can be used to sign the resulting files using a private key. For example, the Yubico HSM https://www.yubico.com/product/yubihsm-2-series/yubihsm-2-fips/.

## Use Cases

- **Primitive Voting Systems:** For any election districts that do not use voting machines that produce ballot images, *ScanEngine* can provide images to perform a ballot image audit of the results. Cover sheets can be produced based on the precinct or batch as they are stored, and thereby provide that additional metadata about the ballots scanned in the images. The ballot images can be scanned with complete chain of custody tracking.

- **Verification scans:** For election districts that use a voting system that produce ballot images, *ScanEngine* can be used to scan batches as a check that the images were not altered. The scanned images must be grouped identically as the groups used in the voting system to be able to compare, and run by AuditEngine as "Verification Images".

- **Scan-centric workflow:** When state law requires that an automated audit rescans physical ballots, either on a sampling basis (such as 20% of the precincts) or exhaustively (all ballots), *ScanEngine* can support the scanning required. The scanned images must be grouped identically as the groups used in the voting system to be able to compare.

## Example Workflow

1. The user separates ballots into batches of a convenient size, of about 200 ballots, for example. This can be commonly done using a counting scale.
2. Using *ScanEngine*, the user enters the GROUP and BATCH, like EV_1000. EV is the Group, Early Voting EV. This can be any string.
3. Those are combined to create a separator page with a code-39 barcode. This separator page is printed using a co-located laser printer.
4. The user places the separator page on top of the batch, and then places it into the ADF feeder (Automatic Document Feeder) of a high-speed scanner, such as the Ricoh fi7090 or Canon DR-G2140, for example.
5. As the scanning of the batch proceeds, the *ScanEngine* software detects the separator sheet and begins a new batch.
   In normal (non-error) flow, the code from the separator sheet is used to determine the file names in the batch. 
6. The images in the batch are copied to a staging area directory, as they are scanned.
7. A log is produced showing the progress of each ballot in the batch.
8. If another separator page is encountered, that will signal the end of the batch. Alternatively, a timeout or operator input can be used to complete a batch if it does not have another batch after it.
9. If the batch is completed without error, then the images in the batch are copied to the final area. Normally, images are copied to a sub-folder of the main destination folder. These images can be written directly to USB drive so there is no connection to the voting system environment.
10. If there is no error, the scanner would continue onto the next batch without stopping.
11. The operator removes the scanned batch from the output tray of the scanner and the separator page is kept on the top of the batch for identification purposes. We recommend that the operator would seal the batch into a zip-lock bag, and place it in the box holding the ballots. In this way, the batch can be identified later.
12. ERROR FLOW. In the case of an error, the images captured in that batch would be deleted in the staging area, and the user alerted to the failure. Sometimes, it is possible to remove the offending ballot, if it is not scannable due to being damaged, and then run the batch without that ballot. This fact would need to be entered by the user.
13. Any ballots that are damaged and cannot be scanned can be combined into another batch, where each of the ballots are "remade" by copying the votes from one to the other.
14. The USB drive is removed and then hand-carried out of the secure air-gapped environment, and then uploaded to the AuditEngine datacenter for processing.

## Batch Scan Dialog

*ScanEngine* uses a "Batch Scan" dialog similar to the dialog box shown here to manage the scans. Users can enter the filename prefix manually, or use the prefix from the code-39 barcode on separator sheets to derive the filename.

![img](https://lh7-us.googleusercontent.com/YXvokW-U5L7NarnCaZQtFUIiYpW001es5jCXKvTcDRTp89vJ72eJmAi2ODGEDLq5o7vbX0Fl-M-qJt-k3tsA2fEXi3JoDmwRJB6VuoBVeyRrpM23LDENSYtrsab0CJppzyioF90puEWnemjzFL_THV0)

## Recommended Scanners

It is recommended that the ScanEngine app be paired with a high-speed scanner that will image both sides of each ballot using an automatic document feeder (ADF). We recommend the following scanners.

### Canon DR-G2140

Canon has several similar products in this category, differing by scanning speed. The top speed is obtained by feeding letter sheets in landscape orientation and is not achievable for ballot scanning, as these ballots tend to be larger than letter size, at least 8.5 x 14. Also, the scanning speed can be increased by selecting B&W and 200 dpi to avoid limiting factors caused by the USB interface. List price in 2023: $7970.00

https://www.usa.canon.com/shop/p/imageformula-dr-g2140-production-document-scanner

![img](https://lh7-us.googleusercontent.com/ZMhsA22gbDgyQoSa0o9-m7W2UOlsy_0flcqff8qR_tmdd_959Pykox3tD9Tf3ZYcm5qspamfO6A82w4TADyDXa1kmVj6dM0SrwGDQuPohvouZFPjN8ROhnLGlMj6T9mmVSi88o2V3fDVOnXJLv8Klaw)

### Ricoh fi7090 or fi7800

Ricoh Corporation recently purchased Fujitsu, including their line of high-volume and high-speed production grade scanners, which they have rebranded as Ricoh products but they are keeping the same model names. The fi7090 is a good example of a scanner suitable for scanning verification ballots. However, it appears their current product is the fi7800 series, which is a little slower, at only 110 ppm. List price in 2023, fi7800: $10,425; fi-7900: $15,159

https://www.pfu-us.ricoh.com/scanners/fi/fi-7800



![img](https://lh7-us.googleusercontent.com/ohuL1xyRAl5KxnGQrWO66_A3QOjQOKc68_hm-W1EXPaGRKobj-y4RY90PvDJanib45lGeKUPuOqGuhQsTgW5bMnMTOk7TtQziYZvERNNmO_jmVvf59AHoxvutF20rs6Dr2Ohe1QXa-5kd3J6NqjaIQM)



The rated scanning speed of the fi7090 is 140 ppm (sheets per minute) and 280 ipm (duplex) can be achieved only if letter-size pages are fed in landscape orientation (long-edge first), and thus it islimited to letter (11" / A4) sheets. Ballots, however, tend to be 8.5" wide by 14, 17, 19, or 21" in length. When fed in portrait orientation (short edge first), the rated speed is 105 sheets per minute and 210 ipm (images per minute, i.e sides). Longer sheets will be a bit slower.

### Xerox W110 Scanner

Scan speeds up to 120 ppm / 240 ipm; 100,000 pages daily duty cycle; 500-page adjustable input tray*. List price in 2023: $5995.

![image-20231106171247122](C:\Users\raylu\AppData\Roaming\Typora\typora-user-images\image-20231106171247122.png)

### Datawin HEMERA

Datawin has several scanners in this product line. The HEMERA S scans up to 360 ppm (A4) at 200 DPI, which is a customary resolution for ballot imaging applications.  The HEMERA C scans at 200 ppm. This is a familiar site as this scanner is used by ES&S ES-850 series ballot scanners.

https://www.datawin.de/high-volume-document-scanner/?lang=en

![image-20231106165935856](C:\Users\raylu\AppData\Roaming\Typora\typora-user-images\image-20231106165935856.png)
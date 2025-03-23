# AuditEngine Special Procedures 

## Adjusting target thresholds

1. Measure size of oval using Paint program in pixels.
   1. example: ES&S in Dane County, WI, 2024, Oval is 24 x 17
   2. Approximate full density is 0.6 * 24 * 17 = 244
   3. Min Threshold for First Big Gap algorithm = 0.5 * full_density = 122.
   4. vendor.get_layout_params()['marginal_thres'] for modern ES&S 150
      1. Currently set to 215. Modern ES&S default is 150, which would be okay.
      2. args.argsdict['marginal_thres'] may also set it. Check settings file.
      3. Yes, set in JOB file, change setting to 122. Old setting was for older layout.
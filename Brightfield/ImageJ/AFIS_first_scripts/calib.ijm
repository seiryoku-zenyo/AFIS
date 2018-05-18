saveAs("Tiff", "E:\\AFIS_rats_TH-immunos\\temp\\CPa.tif");
run("Close");
saveAs("Tiff", "E:\\AFIS_rats_TH-immunos\\temp\\CPb.tif");
run("Close");
open("E:\\AFIS_rats_TH-immunos\\temp\\CPa.tif");
open("E:\\AFIS_rats_TH-immunos\\temp\\CPb.tif");
run("Properties...", "channels=1 slices=1 frames=1 unit=um pixel_width=0.666666 pixel_height=0.666666 voxel_depth=1.0000000 global");
run("Images to Stack", "name=GP_Stack title=[] use");

//FOR THREE IMAGES:
//run("Make Montage...", "columns=3 rows=1 scale=1 first=1 last=3 increment=1 border=0 font=12");
//FOR TWO IMAGES:
run("Make Montage...", "columns=2 rows=1 scale=1 first=1 last=2 increment=1 border=0 font=12");

saveAs("Tiff", "C:\\Program Files (x86)\\ImageJ\\temp\\GP.tif");
run("Properties...", "channels=1 slices=1 frames=1 unit=µm pixel_width=0.16667 pixel_height=0.16667 voxel_depth=1.0000 global");
selectWindow("GP_Stack");
close();
selectWindow("GP.tif");
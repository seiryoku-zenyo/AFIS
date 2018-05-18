//BATCH code
input = getDirectory("Select the folder containing the images for analysis");
output = getDirectory("Select the destination folder for the TSVs and processed images");

list = getFileList(input);
setBatchMode("hide");
for (i=0; i<list.length; i++) {
 showProgress(i+1, list.length);
 open(input+list[i]);


nome=getInfo("image.filename");
nome_tsv=substring(nome,0,7);

//PROCESSING ANALYSIS
rename("SN.tif");
run("Duplicate...", "title=SN-1.tif");
selectWindow("SN.tif");
run("Duplicate...", "title=SN-2.tif");
run("Select All");
run("Threshold...");
setThreshold(0, 254);
setOption("BlackBackground", false);
run("Convert to Mask");
selectWindow("SN-1.tif");
run("Select All");
run("Threshold...");
setThreshold(0, 1);
run("Convert to Mask");
run("Invert");
imageCalculator("AND create", "SN-1.tif","SN-2.tif");
selectWindow("Result of SN-1.tif");
run("Create Selection");
roiManager("Add");
selectWindow("SN.tif");
roiManager("Select", 0);
run("Set Measurements...", "mean modal min integrated median area_fraction redirect=None decimal=3");
run("Measure");
saveAs("Results", "S:\\sport-AFIS\\2015\\TH_ImageJ_results\\dendrites\\_SN_new\\"+nome_tsv+".tsv");
selectWindow("SN.tif");
//saveAs("SN_.tif");
run("Clear Results");
roiManager("Reset");
selectWindow("SN-1.tif");
run("Close");
selectWindow("SN-2.tif");
run("Close");
selectWindow("SN.tif");
saveAs("Tiff", "S:\\sport-AFIS\\2015\\TH_ImageJ_results\\dendrites\\_SN_new\\"+nome);
run("Close");
selectWindow("Result of SN-1.tif");
run("Close");
}
print("FINISHED!");

//closing out images
macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 


//BATCH code
input = getDirectory("Select the folder containing the images for analysis");
//output = getDirectory("Select the destination folder for the TSVs and processed images");

list = getFileList(input);
setBatchMode("show");
for (j=0; j<list.length; j++) {
 showProgress(j+1, list.length);
 setBatchMode("show");

filename = input + list[j];
 if (matches(filename, ".*SN.*")) {
 open(filename);}
 else {continue;}
 

nome=getInfo("image.filename");
nome_tsv=substring(nome,4,7)+"_"+substring(nome,0,3);



//CALIBRATION
saveAs("Tiff", "C:\\Program Files (x86)\\ImageJ\\temp\\SN.tif");
run("Properties...", "channels=1 slices=1 frames=1 unit=um pixel_width=0.666666 pixel_height=0.666666 voxel_depth=1.0000000 global");

//FREEHAND DRAWING

setTool("freehand");
waitForUser("Make a nice drawing for me, please :)");
setBatchMode("hide");


//PROCESSING ANALYSIS

//measure somata number & area	
run("Crop");
setBackgroundColor(255, 255, 255);
run("Clear Outside");
run("Duplicate...", "title=Drawing");
selectWindow("SN.tif");
run("8-bit");
run("Duplicate...", "title=SN_light.tif");
run("Duplicate...", "title=Dendrite");

//darker somata
selectWindow("SN.tif");
// Input a tissue threshold percentage 0-100 
tissueThreshPrec = 1; 

//histogram params
nBins = 256; 
getHistogram(values, count, nBins); 

// total area of the pixels
area = getWidth()*getHeight(); 

//calculate how much the 3% is from the whole volume
tissueValue = area * ( tissueThreshPrec/100 ); 
//print(tissueValue); 

// cumulative histogram = tissue area when th is selected
cumSumValues = count; 
for (i = 1; i<count.length; i++) cumSumValues[i] += cumSumValues[i-1]; 

// find the threshold that gives the wanted area and save it to th
th = 0;
for (i = 1; i<cumSumValues.length; i++) { 
	if (cumSumValues[i-1] <= tissueValue && tissueValue <= cumSumValues[i]) {
		//The th value is found by finding the bin index (threshold) where the tissue area is closes to the required
		th = i;
	}
} 

//print(th);

setThreshold(th, 255);
run("Convert to Mask");
run ("Invert");

//lighter somata
selectWindow("SN_light.tif");
// Input a tissue threshold percentage 0-100 
tissueThreshPrec = 4; 

//histogram params
nBins = 256; 
getHistogram(values, count, nBins); 

// total area of the pixels
area = getWidth()*getHeight(); 

//calculate how much the 3% is from the whole volume
tissueValue = area * ( tissueThreshPrec/100 ); 
//print(tissueValue); 

// cumulative histogram = tissue area when th is selected
cumSumValues = count; 
for (i = 1; i<count.length; i++) cumSumValues[i] += cumSumValues[i-1]; 

// find the threshold that gives the wanted area and save it to th
th = 0;
for (i = 1; i<cumSumValues.length; i++) { 
	if (cumSumValues[i-1] <= tissueValue && tissueValue <= cumSumValues[i]) {
		//The th value is found by finding the bin index (threshold) where the tissue area is closes to the required
		th = i;
	}
} 

//print(th);

setThreshold(th, 255);
run("Convert to Mask");
run ("Invert");

//preparing final data image with lighter and darker bodies
selectWindow("SN_light.tif");
run("Watershed");
run("Duplicate...", " ");
run("Remove Outliers...", "radius=40 threshold=50 which=Dark");
imageCalculator("Subtract create", "SN_light.tif","SN_light-1.tif");
selectWindow("Result of SN_light.tif");
imageCalculator("Add create", "Result of SN_light.tif","SN.tif");
selectWindow("Result of Result of SN_light.tif");
run("Remove Outliers...", "radius=5 threshold=50 which=Dark");
selectWindow("Result of SN_light.tif");
close();
selectWindow("SN_light.tif");
close();
selectWindow("SN_light-1.tif");
close();
selectWindow("SN.tif");
//close();

//measure somata area & density

run("Set Measurements...", "area redirect=None decimal=3");
selectWindow("Result of Result of SN_light.tif");
run("Restore Selection");
run("Analyze Particles...", "  circularity=0.00-1.00 show=Outlines display clear");
saveAs("Results", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\somata\\"+nome_tsv+".tsv");
rename("Drawing of SN somata.tif");
run("Images to Stack", "name=Stack_somata title=[Drawing]");
run("Z Project...", "projection=[Standard Deviation]");
rename("Drawing of SN somata.tif");
saveAs("Tiff", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\somata\\"+nome_tsv+".tif");
selectWindow("Stack_somata");
close();
run("Clear Results");



	//measure dendrite density & intensity

selectWindow("Result of Result of SN_light.tif");
run("Create Selection");
setOption("BlackBackground", false);
run("Dilate");
run("Dilate");
run("Dilate");
selectWindow("Dendrite");
run("Invert");
imageCalculator("Subtract create", "Dendrite","Result of Result of SN_light.tif");
selectWindow("Result of Dendrite");
run("Restore Selection");
run("Set Measurements...", "area mean modal min integrated median area_fraction redirect=None decimal=3");

selectWindow("Result of Result of SN_light.tif");
run("Make Inverse");
roiManager("Add");
selectWindow("Result of Dendrite");
roiManager("Add");
roiManager("Select", 0);
roiManager("Select", newArray(0,1));
roiManager("AND");
run("Measure");
saveAs("Results", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\dendrites\\"+nome_tsv+".tsv");
run("Clear Results");
roiManager("Reset");
selectWindow("Result of Dendrite");
saveAs("Tiff", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\dendrites\\"+nome_tsv+".tif");
run("Close");


print("FINISHED -->"+nome+"!");
setBatchMode("exit and display");	
}

//closing out images
selectWindow("Results"); 
   run("Close");
macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close();
		  	
      }  
	  
		 
	  

setBatchMode("show");		  
		 open("C:\\Program Files (x86)\\ImageJ\\plugins\\ActionBar\\icons\\one_does_not_simply.jpg"); 
		 }
		 }
		  
		
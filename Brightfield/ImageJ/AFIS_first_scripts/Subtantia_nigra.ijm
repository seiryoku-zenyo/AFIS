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
print(tissueValue); 

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
print(tissueValue); 

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
close();

//measure somata area & density

run("Set Measurements...", "area redirect=None decimal=3");
selectWindow("Result of Result of SN_light.tif");
run("Restore Selection");
run("Analyze Particles...", "  circularity=0.00-1.00 show=Outlines display clear");
saveAs("Results");
rename("Drawing of SN somata.tif");
run("Images to Stack", "name=Stack_somata title=[Drawing]");
run("Z Project...", "projection=[Standard Deviation]");
rename("Drawing of SN somata.tif");
saveAs("Drawing of SN somata.tif");
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
run("Set Measurements...", "mean modal min integrated median area_fraction redirect=None decimal=3");

selectWindow("Result of Result of SN_light.tif");
run("Make Inverse");
roiManager("Add");
selectWindow("Result of Dendrite");
roiManager("Add");
roiManager("Select", 0);
roiManager("Select", newArray(0,1));
roiManager("AND");

run("Measure");
saveAs("Results");
selectWindow("Result of Dendrite");
saveAs("Result of Dendrite.tif");
run("Clear Results");

//closing out images
macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  } 




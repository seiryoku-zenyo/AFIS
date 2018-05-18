	//measure somata number & area
	
run("Crop");
setBackgroundColor(255, 255, 255);
run("Clear Outside");
run("Duplicate...", "title=Drawing");
selectWindow("VTA.tif");
run("8-bit");
run("Duplicate...", "title=VTA_light.tif");
run("Duplicate...", "title=Dendrite");

//darker somata
selectWindow("VTA.tif");
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

print(th);

setThreshold(th, 255);
run("Convert to Mask");
run ("Invert");

//lighter somata
selectWindow("VTA_light.tif");
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

print(th);

setThreshold(th, 255);
run("Convert to Mask");
run ("Invert");

//preparing final data image with lighter and darker bodies
selectWindow("VTA_light.tif");
run("Watershed");
run("Duplicate...", " ");
run("Remove Outliers...", "radius=40 threshold=50 which=Dark");
imageCalculator("Subtract create", "VTA_light.tif","VTA_light-1.tif");
selectWindow("Result of VTA_light.tif");
imageCalculator("Add create", "Result of VTA_light.tif","VTA.tif");
selectWindow("Result of Result of VTA_light.tif");
run("Remove Outliers...", "radius=5 threshold=50 which=Dark");
selectWindow("Result of VTA_light.tif");
close();
selectWindow("VTA_light.tif");
close();
selectWindow("VTA_light-1.tif");
close();
selectWindow("VTA.tif");
close();

//measure somata area & density

run("Set Measurements...", "area redirect=None decimal=3");
selectWindow("Result of Result of VTA_light.tif");
run("Restore Selection");
run("Analyze Particles...", "  size=0-1000 show=Outlines display clear");
saveAs("Results");
rename("Drawing of VTA somata.tif");
run("Images to Stack", "name=Stack_somata title=[Drawing]");
run("Z Project...", "projection=[Standard Deviation]");
rename("Drawing of VTA somata.tif");
saveAs("Drawing of VTA somata.tif");
selectWindow("Stack_somata");
close();
run("Clear Results");



	//measure dendrite density & intensity

selectWindow("Result of Result of VTA_light.tif");
doWand(1290, 154);
setOption("BlackBackground", false);
run("Dilate");
run("Dilate");
run("Dilate");
selectWindow("Dendrite");
run("Invert");
imageCalculator("Subtract create", "Dendrite","Result of Result of VTA_light.tif");
selectWindow("Result of Dendrite");
run("Restore Selection");
run("Set Measurements...", "area mean modal min integrated median area_fraction redirect=None decimal=3");
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




run("8-bit");
run("Duplicate...", "title=dendrites.tif");
run("Gaussian Blur...", "sigma=5");
run("Enhance Contrast...", "saturated=0.4");
// Input a tissue threshold percentae 0-100 
tissueThreshPrec = 3; 

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
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Remove Outliers...", "radius=2 threshold=50 which=Bright");
run("Erode");
run("Erode");
run("Erode");
run ("Invert");
imageCalculator("Add create", "dendrites.tif", "Montage.tif");
run("Window/Level...");
setMinAndMax(42, 212);
run("Apply LUT");
run ("Invert");
run("Set Measurements...", "mean modal min integrated median redirect=None decimal=3");
selectWindow("dendrites.tif");
run("Create Selection");
run("Make Inverse");
selectWindow("Result of dendrites.tif");
run("Restore Selection");
run("Measure");
saveAs("Results");
selectWindow("Result of dendrites.tif");
saveAs("Result of dendrites.tif");

selectWindow("Results"); 
   run("Close"); 
selectWindow("Log"); 
run("Close"); 
selectWindow("W&L"); 
run("Close"); 

macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  } 
  
  


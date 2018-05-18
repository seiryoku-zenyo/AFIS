run("8-bit");
run("Duplicate...", "title=capillaries40x.tif");



//segment capillaries
// Input a tissue threshold percentage 0-100 
tissueThreshPrec = 0.3; 

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
run("Remove Outliers...", "radius=10 threshold=50 which=Dark");
run("Remove Outliers...", "radius=10 threshold=50 which=Dark");


//measure capillaries
run ("Invert");
run("Set Measurements...", "area integrated redirect=None decimal=3");
selectWindow("capillaries40x.tif");
run("Analyze Particles...", "size=2-3000 circularity=0.00-1.00 show=Outlines display");
saveAs("Results");
selectWindow("Drawing of capillaries40x.tif");
saveAs("Drawing of capillaries40x.tif");

//measure dendrites
selectWindow("capillaries40x.tif");
setOption("BlackBackground", false);
run("Dilate");
run("Dilate");
run("Create Selection");
selectWindow("GP.tif");
run("Restore Selection");
run("Make Inverse");
run("Set Measurements...", "area mean modal min integrated median area_fraction redirect=None decimal=3");
run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file copy_row save_row");
run("Clear Results");
run("Measure");
saveAs("Results");
selectWindow("GP.tif");
saveAs("GP.tif");
run("Clear Results");


//closing out images
macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  } 

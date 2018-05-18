run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file copy_row save_row");
run("8-bit");
run("Duplicate...", "title=dentrites.tif");
run("Duplicate...", "title=white_bodies.tif");

//segment white bodies
selectWindow("white_bodies.tif");
run("Gaussian Blur...", "sigma=3");
setMinAndMax(60, 195);
run("Apply LUT");

// Input a tissue threshold percentage 0-100 
tissueThreshPrec = 87; 

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
run ("Invert")

//creating mask with white_bodies
selectWindow("white_bodies.tif");
run("Create Selection");

//measure dendrites intensity without white_bodies
run("Set Measurements...", "mean modal min integrated median area_fraction redirect=None decimal=3");
selectWindow("dentrites.tif");
run("Restore Selection");
run("Clear Results");
run("Measure");
saveAs("Results");
selectWindow("dentrites.tif");
saveAs("dentrites.tif");

//measuring "white bodies" in all image
selectWindow("Montage");
close();
run("Clear Results");
selectWindow("CPb.tif");
run("Specify...", "width=2000 height=1400 x=250 y=266");
run("Crop");
run("8-bit");
run("Duplicate...", "title=x_b");
selectWindow("CPb.tif");
run("Gaussian Blur...", "sigma=3");
run("Duplicate...", "title=mask");
run("Gaussian Blur...", "sigma=80");
run("Invert");
imageCalculator("Average create", "CPb.tif","mask");

// Input a tissue threshold percentae 0-100 
tissueThreshPrec = 80; 

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

run("Remove Outliers...", "radius=50 threshold=30 which=Dark");
run("Fill Holes");

selectWindow("CPa.tif");
run("Specify...", "width=2000 height=1400 x=250 y=266");
run("Crop");
run("8-bit");
run("Duplicate...", "title=x_a");
selectWindow("CPa.tif");
run("Gaussian Blur...", "sigma=3");
run("Duplicate...", "title=mask");
run("Gaussian Blur...", "sigma=80");
run("Invert");
imageCalculator("Average create", "CPa.tif","mask");

// Input a tissue threshold percentae 0-100 
tissueThreshPrec = 80; 

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

run("Remove Outliers...", "radius=50 threshold=30 which=Dark");
run("Fill Holes");

run("Images to Stack", "name=stack title=[Result of CP] use");
run("Make Montage...", "columns=2 rows=1 scale=1 first=1 last=2 increment=1 border=0 font=12");

selectWindow("stack");
close();

run("Clear Results");
selectWindow("Montage");
run("Set Measurements...", "area integrated redirect=None decimal=3");
run("Analyze Particles...", "size=250-140000 circularity=0.20-1.00 show=Outlines display");
selectWindow("Montage");
close();
selectWindow("Drawing of Montage");
run("Duplicate...", "title=white_bodies_.tif");
selectWindow("Drawing of Montage");
close();
saveAs("Results");

run("Images to Stack", "method=[Copy (center)] name=xStack title=x_");
run("Make Montage...", "columns=2 rows=1 scale=1 first=1 last=2 increment=1 border=0 font=12");
rename("white_bodies__.tif");
run("Images to Stack", "method=[Copy (center)] name=white_stack title=white_bodies_");
run("Make Montage...", "columns=1 rows=2 scale=1 first=1 last=2 increment=1 border=0 font=12 label");
rename("whites");

selectWindow("whites");
saveAs("whites.tif");

run("Clear Results");

//closing out images
macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  } 

//closing out images
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
	  
	  
//BATCH code
input = getDirectory("Select the folder containing the images for analysis");
//output = getDirectory("Select the destination folder for the TSVs and processed images");

list = getFileList(input);

for (ii=1; ii<=list.length; ii++) {


setBatchMode("show");
for (j=0; j<list.length; j++) {
 showProgress(j+1, list.length);

 
filename = input + list[j];
subject=substring(filename,49,52);

 if (endsWith (filename, "Cpu"+ii+"a_10x.tif")) {
open(filename);
//Identifying subject and section
nome=getInfo("image.filename");
nome_tsv=substring(nome,4,8)+"_"+substring(nome,0,3);
saveAs("Tiff", "C:\\Program Files (x86)\\ImageJ\\temp\\CPa.tif");}

 if (endsWith (filename, "Cpu"+ii+"b_10x.tif")) {
 open(filename);
 saveAs("Tiff", "C:\\Program Files (x86)\\ImageJ\\temp\\CPb.tif");}
 }
 if (nImages==0&&ii<=5) {
	print ("just to remind you: Subject "+subject+" is missing slice "+ii+". Make sure you don't have it in your pocket ;)");}

while (nImages==2) {



//CALIBRATION
run("Properties...", "channels=1 slices=1 frames=1 unit=um pixel_width=0.666666 pixel_height=0.666666 voxel_depth=1.0000000 global");


//FREEHAND DRAWING

for (jj=0; jj<4; jj++) {
selectWindow("CPa.tif");
run("Specify...", "width=250 height=250 x=429.33 y=322 scaled");
waitForUser("HEY :D  Take your 4 samples ("+jj+" taken) from "+subject+"_Cpu"+ii+"a");
run("Duplicate...", "title=CPx.tif");
run("Out [-]");
run("Out [-]");
run("Out [-]");
setLocation(1200, 150);
}

selectWindow("CPb.tif");
for (jj=0; jj<4; jj++) {
selectWindow("CPb.tif");
run("Specify...", "width=250 height=250 x=429.33 y=322 scaled");
waitForUser("HEY :D  Take your 4 samples ("+jj+" taken) from "+subject+"_Cpu"+ii+"b");
run("Duplicate...", "title=CPx.tif");
run("Out [-]");
run("Out [-]");
run("Out [-]");
setLocation(1200, 150);
}

setBatchMode("hide");


//PROCESSING ANALYSIS

//Montage
run("Images to Stack", "method=[Copy (center)] name=Stack title=CPx use");
run("Make Montage...", "columns=4 rows=2 scale=1 first=1 last=8 increment=1 border=0 font=12");
selectWindow("Stack");
close();
selectWindow("Montage");

//Processing
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

//creating mask with white_bodies

selectWindow("white_bodies.tif");
run("Create Selection");

//measure dendrites intensity without capillaries and white_bodies
run("Set Measurements...", "mean modal min integrated median area_fraction redirect=None decimal=3");
selectWindow("dentrites.tif");
run("Restore Selection");
run("Clear Results");
run("Measure");
saveAs("Results", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\dendrites\\"+nome_tsv+".tsv");
selectWindow("Montage");
close();
selectWindow("dentrites.tif");
saveAs("Tiff", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\dendrites\\"+nome_tsv+".tif");


//measuring "white bodies" in all image
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
saveAs("Results", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\white_bodies\\"+nome_tsv+".tsv");

run("Images to Stack", "method=[Copy (center)] name=xStack title=x_");
run("Make Montage...", "columns=2 rows=1 scale=1 first=1 last=2 increment=1 border=0 font=12");
rename("white_bodies__.tif");
run("Images to Stack", "method=[Copy (center)] name=white_stack title=white_bodies_");
run("Make Montage...", "columns=1 rows=2 scale=1 first=1 last=2 increment=1 border=0 font=12 label");
rename("whites");

//Closing images
selectWindow("xStack");
close();
selectWindow("white_stack");
close();
selectWindow("white_bodies.tif");
close();
selectWindow("mask");
close();
selectWindow("mask");
close();
selectWindow("CPa.tif");
close();
selectWindow("CPb.tif");
close();

selectWindow("whites");
saveAs("Tiff", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\white_bodies\\"+nome_tsv+".tif");
close();
run("Clear Results");
close();

  
	  
	  print("FINISHED -->"+nome_tsv+"!");

}

setBatchMode("exit and display");
}
	 
setBatchMode("show");		  
		 open("C:\\Program Files (x86)\\ImageJ\\plugins\\ActionBar\\icons\\one_does_not_simply.jpg");
		   
	  
 
		 
		 
		  
		
start = getTime(); 

//Cleaning all
 if (isOpen("Results")) { 
       selectWindow("Results"); 
       run("Close"); 
   } 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//BATCH code for SUBSTANTIA NIGRA
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
print("Opening data file...");
input = getDirectory("Select the folder containing the images for analysis");
output = input+"processed_data\\SN\\";

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_SN1_D1488_D2555_Darpp405_20x.*")) {
brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title

//Displaying progress for monitoring
subject_number= nome_tsv;
print("\nProcessing...  " + brain_part +" of "+subject_number+"\n");


//Open images and retrieve metadata for later controls (laser power, Gain, Offset etc)
run("Bio-Formats Importer", "open=filename display_metadata view=[Metadata only] stack_order=Default");
//animal_code=substring(imageTitle, 0, 6);
selectWindow("Original Metadata - "+nome);  
saveAs("Text", output+nome_tsv+"_metadata");
run("Close");

selectWindow(imageTitle);
getDimensions(width, height, channels, slices, frames);
run("Split Channels"); 

//renaming channel windows with antigen names 
selectWindow("C1-"+imageTitle);
rename("Darpp");
run("Grays");
run("Despeckle", "stack");
run("Gaussian Blur...", "sigma=2 stack");
run("Size...", "width=1024 height=1024 constrain average interpolation=Bilinear");
selectWindow("C2-"+imageTitle);
rename("D1");
run("Grays");
run("Despeckle", "stack");
run("Gaussian Blur...", "sigma=2 stack");
run("Size...", "width=1024 height=1024 constrain average interpolation=Bilinear");
selectWindow("C3-"+imageTitle);
rename("D2");
run("Grays");
run("Despeckle", "stack");
run("Gaussian Blur...", "sigma=2 stack");
run("Size...", "width=1024 height=1024 constrain average interpolation=Bilinear");


if (slices>17){ //if the image has 17 or less slices, then these is no substacking, otherwise we build substacks!
	 
//get substacks
//Darpp
selectWindow("Darpp");
lastBottomSlice= (slices-6);
firstBottomSlice=(slices);
run("Make Substack...", "  slices=1-8");
rename("Darpp_A");
selectWindow("Darpp");
run("Make Substack...", "  slices="+lastBottomSlice +"-" +firstBottomSlice);
rename("Darpp_B");
getDimensions(width, height, channels, slices, frames);
selectWindow("Darpp");
close();
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "  title=[Darpp] keep image1=Darpp_A image2=gap_slices_8b image3=Darpp_B image4=[-- None --]");


//D1
selectWindow("D1");
getDimensions(width, height, channels, slices, frames);
lastBottomSlice= (slices-6);
firstBottomSlice=(slices);
run("Make Substack...", "  slices=1-8");
rename("D1_A");
run("Duplicate...", "title=D1_A_dendInt duplicate");
selectWindow("D1");
run("Make Substack...", "  slices="+lastBottomSlice +"-" +firstBottomSlice);
rename("D1_B");
run("Duplicate...", "title=D1_B_dendInt duplicate");
selectWindow("D1");
close();

//presetting 3D objects.
selectWindow("D1_A");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Duplicate...", "title=D1_A_original duplicate");
selectWindow("D1_A");
run("Gaussian Blur...", "sigma=1 stack");
run("Subtract Background...", "rolling=50 stack");
setAutoThreshold("Default dark");
setThreshold(50, 255);
run("Convert to Mask", "  black");
run("Invert", "stack");
run("Watershed", "stack");
run("Invert", "stack");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("3D Watershed Split", "binary=D1_A seeds=D1_A radius=2");
close();
selectWindow("EDT");
rename("EDT1");

selectWindow("D1_B");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Duplicate...", "title=D1_B_original duplicate");
selectWindow("D1_B");
run("Gaussian Blur...", "sigma=1 stack");
run("Subtract Background...", "rolling=50 stack");
setAutoThreshold("Default dark");
setThreshold(50, 255);
run("Convert to Mask", "  black");
run("Invert", "stack");
run("Watershed", "stack");
run("Invert", "stack");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("3D Watershed Split", "binary=D1_B seeds=D1_B radius=2");
close();
selectWindow("EDT");
rename("EDT2");

//Combining and saving stacks D1_A + D1_B for analyses
getDimensions(width, height, channels, slices, frames);
newImage("gap_slices_16b", "16-bit black", width, height, 2);//nota pro futuro, concatenacao de slices tem de ser de bits identicos (8, 16, etc)! Caso contrário não funciona nem avisa!!
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "  title=[Concatenated Stacks] keep image1=EDT1 image2=gap_slices_16b image3=EDT2 image4=[-- None --]");
rename("D1_EDT");
getDimensions(width, height, channels, slices, frames);
run("Concatenate...", "title=[Concatenated Stacks] image1=D1_A_dendInt image2=gap_slices_8b image3=D1_B_dendInt"); //dendrites
rename("D1_dendInt");
run("Duplicate...", "title=D1_dendInt_NO_somata duplicate"); 
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "title=[Concatenated Stacks] image1=D1_A_original image2=gap_slices_8b image3=D1_B_original"); //dendrites
rename("D1_somata");



//Closing left-over images
selectWindow("EDT1");
close();
//Closing left-over images
selectWindow("EDT2");
close();


//D2
selectWindow("D2");
getDimensions(width, height, channels, slices, frames);
lastBottomSlice= (slices-6);
firstBottomSlice=(slices);
run("Make Substack...", "  slices=1-8");
rename("D2_A");
run("Duplicate...", "title=D2_A_dendInt duplicate");
selectWindow("D2");
run("Make Substack...", "  slices="+lastBottomSlice +"-" +firstBottomSlice);
rename("D2_B");
run("Duplicate...", "title=D2_B_dendInt duplicate");
selectWindow("D2");
close();

selectWindow("D2_A");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Duplicate...", "title=D2_A_original duplicate");
selectWindow("D2_A");
run("Gaussian Blur...", "sigma=1 stack");
run("Subtract Background...", "rolling=50 stack");
setAutoThreshold("Default dark");
setThreshold(50, 255);
run("Convert to Mask", "  black");
run("Invert", "stack");
run("Watershed", "stack");
run("Invert", "stack");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("3D Watershed Split", "binary=D2_A seeds=D2_A radius=2");
close();
selectWindow("EDT");
rename("EDT1");

selectWindow("D2_B");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Duplicate...", "title=D2_B_original duplicate");
selectWindow("D2_B");
run("Gaussian Blur...", "sigma=1 stack");
run("Subtract Background...", "rolling=50 stack");
setAutoThreshold("Default dark");
setThreshold(50, 255);
run("Convert to Mask", "  black");
run("Invert", "stack");
run("Watershed", "stack");
run("Invert", "stack");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("3D Watershed Split", "binary=D2_B seeds=D2_B radius=2");
close();
selectWindow("EDT");
rename("EDT2");

//Combining and saving stacks D2_A + D2_B for analyses
getDimensions(width, height, channels, slices, frames);
newImage("gap_slices_16b", "16-bit black", width, height, 2);
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "title=[combined_EDT] image1=EDT1 image2=gap_slices_16b image3=EDT2"); //somata
rename("D2_EDT");
getDimensions(width, height, channels, slices, frames);
run("Concatenate...", "title=[Concatenated Stacks] image1=D2_A_dendInt image2=gap_slices_8b image3=D2_B_dendInt"); //dendrites
rename("D2_dendInt");
run("Duplicate...", "title=D2_dendInt_NO_somata duplicate");
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "title=[Concatenated Stacks] image1=D2_A_original image2=gap_slices_8b image3=D2_B_original"); //dendrites
rename("D2_somata");



}else{// in the case the images have 17 or less slices...
	
	//Darpp
	selectWindow("Darpp");	
	getDimensions(width, height, channels, slices, frames);
	setSlice(slices);
	run("Add Slice");
	run("Add Slice");
	
  	//D1
	selectWindow("D1");
	getDimensions(width, height, channels, slices, frames);
	setSlice(slices);
	run("Add Slice");
	run("Add Slice");
	run("Duplicate...", "title=D1_dendInt duplicate");
	run("Duplicate...", "title=D1_dendInt_NO_somata duplicate");
	selectWindow("D1");
	run("Duplicate...", "title=D1_somata duplicate");
	run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
	selectWindow("D1");
	//presetting 3D objects.
	run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
	run("Duplicate...", "title=D1_original duplicate");
	run("Gaussian Blur...", "sigma=1 stack");
	run("Subtract Background...", "rolling=50 stack");
	setAutoThreshold("Default dark");
	setThreshold(50, 255);
	run("Convert to Mask", "  black");
	run("Invert", "stack");
	run("Watershed", "stack");
	run("Invert", "stack");
	run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
	run("3D Watershed Split", "binary=D1_original seeds=D1 radius=2");
	close();
	selectWindow("EDT");
	rename("D1_EDT");

  	//D2
	selectWindow("D2");
	getDimensions(width, height, channels, slices, frames);
	setSlice(slices);
	run("Add Slice");
	run("Add Slice");
	run("Duplicate...", "title=D2_dendInt duplicate");
	run("Duplicate...", "title=D2_dendInt_NO_somata duplicate");
	selectWindow("D2");
	run("Duplicate...", "title=D2_somata duplicate");
	run("Enhance Contrast", "saturated=0.4 normalize normalize_all");	
	selectWindow("D2");
	//presetting 3D objects.
	run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
	run("Duplicate...", "title=D2_original duplicate");
	run("Gaussian Blur...", "sigma=1 stack");
	run("Subtract Background...", "rolling=50 stack");
	setAutoThreshold("Default dark");
	setThreshold(50, 255);
	run("Convert to Mask", "  black");
	run("Invert", "stack");
	run("Watershed", "stack");
	run("Invert", "stack");
	run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
	run("3D Watershed Split", "binary=D2_original seeds=D2 radius=2");
	close();
	selectWindow("EDT");
	rename("D2_EDT");
	}


//STARTING 3D MEASUREMENTS
//Count & measure 3D somata
//D1
//Segmenting and measuring somata
selectWindow("D1_EDT");
run("3D Simple Segmentation", "low_threshold=2750 min_size=750 max_size=-1");
run("3D Manager Options", "volume surface compactness fit_ellipse integrated_density mean_grey_value mode_grey_value minimum_grey_value maximum_grey_value exclude_objects_on_edges_xy sync distance_between_centers=10 distance_max_contact=1.80");
selectWindow("Seg");
run("3D Manager");
Ext.Manager3D_AddImage();
Ext.Manager3D_SelectAll();
//Ext.Manager3D_Save(output+nome_tsv+"_D1_segmented_objects_previous");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_D1_somata.tsv");
Ext.Manager3D_CloseResult("M");

/////////////////////////
/////////////////////////
//THIS MACRO FILTERS OUT NON-SOMA LIKE OBJECTS
"\t"
print("Trying to figure out which of those objects are somata and capillaries");
"\t"
print(output);
print(nome_tsv);
file=File.openAsString(output+"M_"+nome_tsv+"_D1_somata.tsv"); 
rows=split(file, "\n"); 
Obj=newArray(rows.length); 
Label=newArray(rows.length);
Vol=newArray(rows.length);
Spher=newArray(rows.length);
Elong=newArray(rows.length);
Compac=newArray(rows.length);


for( i=rows.length-1 ; i > 0; i--){
columns=split(rows[i],"\t"); 
Obj[i]=parseFloat(columns[1])-1; 
Label[i]=columns[2]; 
Vol[i]=parseFloat(columns[3]); 
Spher[i]=parseFloat(columns[13]); 
Elong[i]=parseFloat(columns[16]); 
Compac[i]=parseFloat(columns[12]); 


//test subject
//j=64

print("Object => "+Obj[i]);
print("Label => "+Label[i]);
//print("Compac =>"+Compac[i]);
//print("Spher =>"+Spher[i]);
//print("Elong =>"+Elong[i]);
"\t";

//Aproximate Compac max(0.25)- min(0.02) which from 0.07 is the recommended minimum value for a cell, i.e.:
recom_CompacIndex=1-(0.25-0.07)/(0.25-0.020);
curr_CompacIndex=1-(0.25-Compac[i])/(0.25-0.020);
print("Recomended CompacIndex => "+recom_CompacIndex);
print("Current CompacIndex => "+curr_CompacIndex);
pointsCompac=(curr_CompacIndex*50)/recom_CompacIndex;
points=toString(pointsCompac, 1);
print("Score => "+points+" points!");
print("--------------------------------");

//Aproximate Spher max(0.6)- min(0.27) which from 0.47 is the recommended minimum value for a cell, i.e.: 
recom_SpherIndex=1-(0.6-0.47)/(0.6-0.27);
curr_SpherIndex=1-(0.6-Spher[i])/(0.6-0.27);
print("Recomended SpherIndex => "+recom_SpherIndex);
print("Current SpherIndex => "+curr_SpherIndex);
pointsSpher=(curr_SpherIndex*50)/recom_SpherIndex;
points=toString(pointsSpher, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");

//Aproximate Elong max(6)- min(1.05) which from 2.2 is the recommended maximum value for a cell, i.e.: 
recom_ElongIndex=1-(1.05-2.2)/(1.05-6.0);
curr_ElongIndex=1-(1.05-Elong[i])/(1.05-6.0);
print("Recomended ElongIndex => "+recom_ElongIndex);
print("Current ElongIndex => "+curr_ElongIndex);
pointsElong=(curr_ElongIndex*50)/recom_ElongIndex;
points=toString(pointsElong, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");




Object_index=(curr_CompacIndex+curr_SpherIndex+2*curr_ElongIndex)/3;
print("current object_index=>"+Object_index);
Cellity_index =(recom_CompacIndex+recom_SpherIndex+2*recom_ElongIndex)/3;
print("Cellity_index=>"+Cellity_index);
pointsCellity=(Object_index*50)/Cellity_index;
points=toString(pointsCellity, 1);
print("Total Score => "+points+" points!");
print("------------------------------------------------");
print("------------------------------------------------");
if (Object_index >= Cellity_index) { 
	print("Congratz dude, it's a CELL!!!! :D");
} else {
	print("WTF!? IT'S A FREAKING CAPILLARY!!!");
	k=Obj[i];
	Ext.Manager3D_Select(k);
	Ext.Manager3D_Delete();
		}
print("------------------------------------------------");
print("------------------------------------------------");
}

Ext.Manager3D_SelectAll();
Ext.Manager3D_Save(output+nome_tsv+"_D1_segmented_objects");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_D1_somata.tsv");
Ext.Manager3D_CloseResult("M");

//Creating a mask of the real from the segmented somata
selectWindow("Seg");
getDimensions(width, height, channels, slices, frames);
newImage("Seg_mask", "8-bit white", width, height, slices);
Ext.Manager3D_SelectAll();
Ext.Manager3D_FillStack(0, 0, 0);
Ext.Manager3D_Close();
selectWindow("Seg_mask");
run("Invert", "stack");

for (j=1; j<=slices; j++) {
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    run("Make Inverse");
    selectWindow("D1_somata");
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    selectWindow("D1_dendInt_NO_somata");   	
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    }
selectWindow("D1_somata");
//saveAs(output+nome_tsv+"_D1_somata.tif");

//Saving 3D graphs
//run("3D Viewer");
//call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
//call("ij3d.ImageJ3DViewer.add", "D1_A_original", "Green", "D1_A_original", "0", "true", "true", "true", "2", "0");
Ext.Manager3D_Close();

//and from this point you have to filter objects with combined minum: Spareness=>0.850; Compactness=>0.08; Sphericity=> 0.4
print("\nD1 somata measurements completed");

//closing leftover images
selectWindow("D1_EDT");
close();
selectWindow("Seg");
close();
selectWindow("Seg_mask");
close();
selectWindow("Bin");
close();

  
//D2
//Segmenting and measuring somata
selectWindow("D2_EDT");
run("3D Simple Segmentation", "low_threshold=2750 min_size=750 max_size=-1");
run("3D Manager Options", "volume surface compactness fit_ellipse integrated_density mean_grey_value mode_grey_value minimum_grey_value maximum_grey_value exclude_objects_on_edges_xy sync distance_between_centers=10 distance_max_contact=1.80");
selectWindow("Seg");
run("3D Manager");
Ext.Manager3D_AddImage();
Ext.Manager3D_SelectAll();
//Ext.Manager3D_Save(output+nome_tsv+"_D2_segmented_objects_previous");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_D2_somata.tsv");
Ext.Manager3D_CloseResult("M");

/////////////////////////
/////////////////////////
//THIS MACRO FILTERS OUT NON-SOMA LIKE OBJECTS
"\t"
print("Trying to figure out which of those objects are somata and capillaries");
"\t"
file=File.openAsString(output+"M_"+nome_tsv+"_D2_somata.tsv"); 
rows=split(file, "\n"); 
Obj=newArray(rows.length); 
Label=newArray(rows.length);
Vol=newArray(rows.length);
Spher=newArray(rows.length);
Elong=newArray(rows.length);
Compac=newArray(rows.length);

i=0;
for( i=rows.length-1 ; i > 0; i--){
columns=split(rows[i],"\t"); 
Obj[i]=parseFloat(columns[1])-1; 
Label[i]=columns[2]; 
Vol[i]=parseFloat(columns[3]); 
Spher[i]=parseFloat(columns[13]); 
Elong[i]=parseFloat(columns[16]); 
Compac[i]=parseFloat(columns[12]); 


//test subject
//j=64

print("Object => "+Obj[i]);
print("Label => "+Label[i]);
//print("Compac =>"+Compac[i]);
//print("Spher =>"+Spher[i]);
//print("Elong =>"+Elong[i]);
"\t";

//Aproximate Compac max(0.25)- min(0.02) which from 0.07 is the recommended minimum value for a cell, i.e.:
recom_CompacIndex=1-(0.25-0.07)/(0.25-0.020);
curr_CompacIndex=1-(0.25-Compac[i])/(0.25-0.020);
print("Recomended CompacIndex => "+recom_CompacIndex);
print("Current CompacIndex => "+curr_CompacIndex);
pointsCompac=(curr_CompacIndex*50)/recom_CompacIndex;
points=toString(pointsCompac, 1);
print("Score => "+points+" points!");
print("--------------------------------");

//Aproximate Spher max(0.6)- min(0.27) which from 0.47 is the recommended minimum value for a cell, i.e.: 
recom_SpherIndex=1-(0.6-0.47)/(0.6-0.27);
curr_SpherIndex=1-(0.6-Spher[i])/(0.6-0.27);
print("Recomended SpherIndex => "+recom_SpherIndex);
print("Current SpherIndex => "+curr_SpherIndex);
pointsSpher=(curr_SpherIndex*50)/recom_SpherIndex;
points=toString(pointsSpher, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");

//Aproximate Elong max(6)- min(1.05) which from 2.2 is the recommended maximum value for a cell, i.e.: 
recom_ElongIndex=1-(1.05-2.2)/(1.05-6.0);
curr_ElongIndex=1-(1.05-Elong[i])/(1.05-6.0);
print("Recomended ElongIndex => "+recom_ElongIndex);
print("Current ElongIndex => "+curr_ElongIndex);
pointsElong=(curr_ElongIndex*50)/recom_ElongIndex;
points=toString(pointsElong, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");




Object_index=(curr_CompacIndex+curr_SpherIndex+2*curr_ElongIndex)/3;
print("current object_index=>"+Object_index);
Cellity_index =(recom_CompacIndex+recom_SpherIndex+2*recom_ElongIndex)/3;
print("Cellity_index=>"+Cellity_index);
pointsCellity=(Object_index*50)/Cellity_index;
points=toString(pointsCellity, 1);
print("Total Score => "+points+" points!");
print("------------------------------------------------");
print("------------------------------------------------");
	if (Object_index >= Cellity_index) { 
	print("Congratz dude, it's a CELL!!!! :D");
	}	else {
	print("WTF!? IT'S A FREAKING CAPILLARY!!!");
	k=Obj[i];
	Ext.Manager3D_Select(k);
	Ext.Manager3D_Delete();
		}
print("------------------------------------------------");
print("------------------------------------------------");
}

Ext.Manager3D_SelectAll();
Ext.Manager3D_Save(output+nome_tsv+"_D2_segmented_objects");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_D2_somata.tsv");
Ext.Manager3D_CloseResult("M");


//Creating a mask of the real from the segmented somata
selectWindow("Seg");
getDimensions(width, height, channels, slices, frames);
newImage("Seg_mask", "8-bit white", width, height, slices);
Ext.Manager3D_SelectAll();
Ext.Manager3D_FillStack(0, 0, 0);
Ext.Manager3D_Close();
selectWindow("Seg_mask");
run("Invert", "stack");

for (j=1; j<=slices; j++) {
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    run("Make Inverse");
    selectWindow("D2_somata");
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    selectWindow("D2_dendInt_NO_somata");   	
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    }
selectWindow("D2_somata");
//saveAs(output+nome_tsv+"_D2_somata.tif");

//Saving 3D graphs
//run("3D Viewer");
//call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
//call("ij3d.ImageJ3DViewer.add", "D1_A_original", "Green", "D1_A_original", "0", "true", "true", "true", "2", "0");

//closing leftover images
selectWindow("D2_EDT");
close();
selectWindow("Seg");
close();
selectWindow("Seg_mask");
close();
selectWindow("Bin");
close();
print("D2 somata measurements completed");


//Measure 3D dendrite density
//D1 densities
selectWindow("D1_dendInt");//measurements with somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 0, "D1 with somata"); 
setResult("mean_gray_in_stack", 0, stackMean);
setResult("median", 0, stackMedian);
setResult("Integrated_density", 0, stackIntegrated);
setResult("voxel_count", 0, voxelCount);
selectWindow("D1_dendInt_NO_somata");//measurements withouth somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 1, "D1 without somata"); 
setResult("mean_gray_in_stack", 1, stackMean);
setResult("median", 1, stackMedian);
setResult("Integrated_density", 1, stackIntegrated);
setResult("voxel_count", 1, voxelCount);
selectWindow("D1_dendInt_NO_somata");
run("Select All");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
print("D1 axon density measurements completed");


//D2 densities
selectWindow("D2_dendInt");//measurements with somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 2, "D2 with somata"); 
setResult("mean_gray_in_stack", 2, stackMean);
setResult("median", 2, stackMedian);
setResult("Integrated_density", 2, stackIntegrated);
setResult("voxel_count", 2, voxelCount);
selectWindow("D2_dendInt_NO_somata");//measurements withouth somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 3, "D2 without somata"); 
setResult("mean_gray_in_stack", 3, stackMean);
setResult("median", 3, stackMedian);
setResult("Integrated_density", 3, stackIntegrated);
setResult("voxel_count", 3, voxelCount);

selectWindow("D2_dendInt_NO_somata");
run("Select All");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
print("D2 axon density measurements completed");


//Darpp
//measuring stacks Darpp
selectWindow("Darpp");
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 4, "Darpp"); 
setResult("mean_gray_in_stack", 4, stackMean);
setResult("median", 4, stackMedian);
setResult("Integrated_density", 4, stackIntegrated);
setResult("voxel_count", 4, voxelCount);

run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file copy_row save_column save_row");
saveAs("Results", output+nome_tsv+"_axon_densities.tsv");
run("Clear Results"); 

run("Enhance Contrast...", "saturated=0.4 normalize process_all"); //note that enhancement happens only after density measurements
//saveAs(output+nome_tsv+"_Darpp_axon_density.tif");
print("Darpp axon density measurements completed\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");


//Making image with D1&D2 axons (red&green) with somata (magenta&cyan) + one image including Darpp (blue)
run("Merge Channels...", "c1=D2_dendInt_NO_somata c2=D1_dendInt_NO_somata c5=D1_somata c6=D2_somata keep");
saveAs(output+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Merge Channels...", "c1=D2_dendInt_NO_somata c2=D1_dendInt_NO_somata c3=Darpp c5=D1_somata c6=D2_somata keep");
saveAs(output+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Merge Channels...", "c1=D2_dendInt_NO_somata c2=D1_dendInt_NO_somata c3=Darpp keep");
saveAs(output+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif");

//3D COLOCALIZATION ANALYSIS

run("3D Manager");
Ext.Manager3D_Load(output+nome_tsv+"_D1_segmented_objects");
Ext.Manager3D_Load(output+nome_tsv+"_D2_segmented_objects");
Ext.Manager3D_Coloc();
Ext.Manager3D_SaveResult("C", output+nome_tsv+"_D1_D2coloc.tsv");
Ext.Manager3D_CloseResult("C");
Ext.Manager3D_Close();
run("Merge Channels...", "c1=D2_somata c2=D1_somata c3=Darpp");
saveAs(output+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif");
print("D1&D2 colocalization analysis completed");


while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 


  }
} 

//Cleaning all
 if (isOpen("Results")) { 
       selectWindow("Results"); 
       run("Close"); 
   } 
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//BATCH code for CAUDATE PUTAMEN
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

print("Opening data file...");
//input = getDirectory("Select the folder containing the images for analysis");
output = input+"processed_data\\CP\\";

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_CPU1_D1488_D2555_Darpp405_20x.*")) {
brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title

//Displaying progress for monitoring
subject_number= nome_tsv;
print("\nProcessing...  " + brain_part +" of "+subject_number+"\n");


//Open images and retrieve metadata for later controls (laser power, Gain, Offset etc)
run("Bio-Formats Importer", "open=filename display_metadata view=[Metadata only] stack_order=Default");
//animal_code=substring(imageTitle, 0, 6);
selectWindow("Original Metadata - "+nome);  
saveAs("Text", output+nome_tsv+"_metadata");
run("Close");

selectWindow(imageTitle);
getDimensions(width, height, channels, slices, frames);
run("Split Channels"); 

//For Darpp
//renaming channel windows with antigen names 
selectWindow("C1-"+imageTitle);
rename("Darpp");
run("Grays");
run("Despeckle", "stack");
//run("Gaussian Blur...", "sigma=2 stack");
run("Size...", "width=1024 height=1024 constrain average interpolation=Bilinear");
selectWindow("C2-"+imageTitle);
rename("D1");
run("Grays");
run("Despeckle", "stack");
run("Gaussian Blur...", "sigma=2 stack");
run("Size...", "width=1024 height=1024 constrain average interpolation=Bilinear");
selectWindow("C3-"+imageTitle);
rename("D2");
run("Grays");
run("Despeckle", "stack");
run("Gaussian Blur...", "sigma=2 stack");
run("Size...", "width=1024 height=1024 constrain average interpolation=Bilinear");

if (slices>17){ //if the image has 17 or less slices, then these is no substacking, otherwise we build substacks!
	 
//get substacks
//Darpp
selectWindow("Darpp");
getDimensions(width, height, channels, slices, frames);
lastBottomSlice= (slices-6);
firstBottomSlice=(slices);
run("Make Substack...", "  slices=1-8");
rename("Darpp_A");
selectWindow("Darpp");
run("Make Substack...", "  slices="+lastBottomSlice +"-" +firstBottomSlice);
rename("Darpp_B");
selectWindow("Darpp");
close();
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "  title=[Darpp] keep image1=Darpp_A image2=gap_slices_8b image3=Darpp_B image4=[-- None --]");


//D1
selectWindow("D1");
getDimensions(width, height, channels, slices, frames);
lastBottomSlice= (slices-6);
firstBottomSlice=(slices);
run("Make Substack...", "  slices=1-8");
rename("D1_A");
run("Duplicate...", "title=D1_A_dendInt duplicate");
selectWindow("D1");
run("Make Substack...", "  slices="+lastBottomSlice +"-" +firstBottomSlice);
rename("D1_B");
run("Duplicate...", "title=D1_B_dendInt duplicate");
selectWindow("D1");
close();

//presetting 3D objects.
selectWindow("D1_A");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Duplicate...", "title=D1_A_original duplicate");
selectWindow("D1_A");
run("Gaussian Blur...", "sigma=1 stack");
run("Subtract Background...", "rolling=50 stack");
setAutoThreshold("Default dark");
setThreshold(50, 255);
run("Convert to Mask", "  black");
run("Invert", "stack");
run("Watershed", "stack");
run("Invert", "stack");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("3D Watershed Split", "binary=D1_A seeds=D1_A radius=2");
close();
selectWindow("EDT");
rename("EDT1");

selectWindow("D1_B");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Duplicate...", "title=D1_B_original duplicate");
selectWindow("D1_B");
run("Gaussian Blur...", "sigma=1 stack");
run("Subtract Background...", "rolling=50 stack");
setAutoThreshold("Default dark");
setThreshold(50, 255);
run("Convert to Mask", "  black");
run("Invert", "stack");
run("Watershed", "stack");
run("Invert", "stack");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("3D Watershed Split", "binary=D1_B seeds=D1_B radius=2");
close();
selectWindow("EDT");
rename("EDT2");

//Combining and saving stacks D1_A + D1_B for analyses
getDimensions(width, height, channels, slices, frames);
newImage("gap_slices_16b", "16-bit black", width, height, 2);//nota pro futuro, concatenacao de slices tem de ser de bits identicos (8, 16, etc)! Caso contrário não funciona nem avisa!!
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "  title=[Concatenated Stacks] keep image1=EDT1 image2=gap_slices_16b image3=EDT2 image4=[-- None --]");
rename("D1_EDT");
run("Concatenate...", "title=[Concatenated Stacks] image1=D1_A_dendInt image2=gap_slices_8b image3=D1_B_dendInt"); //dendrites
rename("D1_dendInt");
run("Duplicate...", "title=D1_dendInt_NO_somata duplicate"); 
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "title=[Concatenated Stacks] image1=D1_A_original image2=gap_slices_8b image3=D1_B_original"); //dendrites
rename("D1_somata");


//D2
selectWindow("D2");
getDimensions(width, height, channels, slices, frames);
lastBottomSlice= (slices-6);
firstBottomSlice=(slices);
run("Make Substack...", "  slices=1-8");
rename("D2_A");
run("Duplicate...", "title=D2_A_dendInt duplicate");
selectWindow("D2");
run("Make Substack...", "  slices="+lastBottomSlice +"-" +firstBottomSlice);
rename("D2_B");
run("Duplicate...", "title=D2_B_dendInt duplicate");
selectWindow("D2");
close();

selectWindow("D2_A");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Duplicate...", "title=D2_A_original duplicate");
selectWindow("D2_A");
run("Gaussian Blur...", "sigma=1 stack");
run("Subtract Background...", "rolling=50 stack");
setAutoThreshold("Default dark");
setThreshold(50, 255);
run("Convert to Mask", "  black");
run("Invert", "stack");
run("Watershed", "stack");
run("Invert", "stack");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("3D Watershed Split", "binary=D2_A seeds=D2_A radius=2");
close();
selectWindow("EDT");
rename("EDT1");

selectWindow("D2_B");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Duplicate...", "title=D2_B_original duplicate");
selectWindow("D2_B");
run("Gaussian Blur...", "sigma=1 stack");
run("Subtract Background...", "rolling=50 stack");
setAutoThreshold("Default dark");
setThreshold(50, 255);
run("Convert to Mask", "  black");
run("Invert", "stack");
run("Watershed", "stack");
run("Invert", "stack");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("3D Watershed Split", "binary=D2_B seeds=D2_B radius=2");
close();
selectWindow("EDT");
rename("EDT2");

//Combining and saving stacks D2_A + D2_B for analyses
getDimensions(width, height, channels, slices, frames);
newImage("gap_slices_16b", "16-bit black", width, height, 2);
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "title=[combined_EDT] image1=EDT1 image2=gap_slices_16b image3=EDT2"); //somata
rename("D2_EDT");
getDimensions(width, height, channels, slices, frames);
run("Concatenate...", "title=[Concatenated Stacks] image1=D2_A_dendInt image2=gap_slices_8b image3=D2_B_dendInt"); //dendrites
rename("D2_dendInt");
run("Duplicate...", "title=D2_dendInt_NO_somata duplicate");
newImage("gap_slices_8b", "8-bit black", width, height, 2);
run("Concatenate...", "title=[Concatenated Stacks] image1=D2_A_original image2=gap_slices_8b image3=D2_B_original"); //dendrites
rename("D2_somata");





}else{// in the case the images have 17 or less slices...
	//Darpp
	selectWindow("Darpp");	
	getDimensions(width, height, channels, slices, frames);
	setSlice(slices);
	run("Add Slice");
	run("Add Slice");
	
  	//D1
	selectWindow("D1");
	getDimensions(width, height, channels, slices, frames);
	setSlice(slices);
	run("Add Slice");
	run("Add Slice");
	run("Duplicate...", "title=D1_dendInt duplicate");
	run("Duplicate...", "title=D1_dendInt_NO_somata duplicate");
	selectWindow("D1");
	run("Duplicate...", "title=D1_somata duplicate");
	run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
	selectWindow("D1");
	//presetting 3D objects.
	run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
	//run("Duplicate...", "title=D1_original duplicate");
	run("Gaussian Blur...", "sigma=1 stack");
	run("Subtract Background...", "rolling=50 stack");
	setAutoThreshold("Default dark");
	setThreshold(50, 255);
	run("Convert to Mask", "  black");
	run("Invert", "stack");
	run("Watershed", "stack");
	run("Invert", "stack");
	run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
	run("3D Watershed Split", "binary=D1 seeds=D1 radius=2");
	close();
	selectWindow("EDT");
	rename("D1_EDT");

  	//D2
	selectWindow("D2");
	getDimensions(width, height, channels, slices, frames);
	setSlice(slices);
	run("Add Slice");
	run("Add Slice");
	run("Duplicate...", "title=D2_dendInt duplicate");
	run("Duplicate...", "title=D2_dendInt_NO_somata duplicate");
	selectWindow("D2");
	run("Duplicate...", "title=D2_somata duplicate");
	run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
	selectWindow("D2");
	//presetting 3D objects.
	run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
	//run("Duplicate...", "title=D2_original duplicate");
	run("Gaussian Blur...", "sigma=1 stack");
	run("Subtract Background...", "rolling=50 stack");
	setAutoThreshold("Default dark");
	setThreshold(50, 255);
	run("Convert to Mask", "  black");
	run("Invert", "stack");
	run("Watershed", "stack");
	run("Invert", "stack");
	run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
	run("3D Watershed Split", "binary=D2 seeds=D2 radius=2");
	close();
	selectWindow("EDT");
	rename("D2_EDT");
	}


//STARTING 3D MEASUREMENTS
//Count & measure 3D somata

//Darpp
//presetting 3D objects.
selectWindow("Darpp");
run("Duplicate...", "title=Darpp_original duplicate");
run("Duplicate...", "title=Darpp_original_NO_somata duplicate");
run("Duplicate...", "title=Darpp_somata duplicate");
selectWindow("Darpp_somata");

//Image for darpp somata representation
run("Duplicate...", "duplicate");
rename("Darpp_somata_figure");
run("Enhance Contrast...", "saturated=0.4 normalize process_all"); 
//Image for darpp somata segmentation
selectWindow("Darpp_somata");
run("Gaussian Blur...", "sigma=2 stack");
run("Enhance Contrast...", "saturated=0.4 normalize process_all");
run("Subtract Background...", "rolling=50 stack");
run("Remove Outliers...", "radius=5 threshold=1 which=Bright stack");
run("Duplicate...", "duplicate");
run("Gaussian Blur...", "sigma=50 stack");
setMinAndMax(30, 155);
run("Apply LUT", "stack");
imageCalculator("Subtract create stack", "Darpp_somata","Darpp_somata-1");
selectWindow("Result of Darpp_somata");
setAutoThreshold("Moments");
setOption("BlackBackground", false);
run("Convert to Mask", "method=Moments background=Light calculate");
run("Remove Outliers...", "radius=10 threshold=1 which=Bright stack");
run("Invert", "stack");
run("Fill Holes", "stack");
run("Watershed", "stack");

//Segmenting and measuring somata
run("3D Watershed Split", "binary=Result of Darpp_somata seeds=Darpp_original radius=2");
selectWindow("EDT");
run("3D Simple Segmentation", "low_threshold=7500 min_size=1000 max_size=-1");
run("3D Manager Options", "volume surface compactness fit_ellipse integrated_density mean_grey_value mode_grey_value minimum_grey_value maximum_grey_value exclude_objects_on_edges_xy sync distance_between_centers=10 distance_max_contact=1.80");
selectWindow("Seg");
run("3D Manager");
Ext.Manager3D_AddImage();
Ext.Manager3D_SelectAll();
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_Darpp_somata.tsv");
Ext.Manager3D_CloseResult("M");


/////////////////////////
/////////////////////////
//THIS MACRO FILTERS OUT NON-SOMA LIKE OBJECTS
"\t"
print("Trying to figure out which of those objects are somata and capillaries");
"\t"
file=File.openAsString(output+"M_"+nome_tsv+"_Darpp_somata.tsv"); 
rows=split(file, "\n"); 
Obj=newArray(rows.length); 
Label=newArray(rows.length);
Vol=newArray(rows.length);
Spher=newArray(rows.length);
Elong=newArray(rows.length);
Ell_Elong=newArray(rows.length);
Compac=newArray(rows.length);
Ratio_El_Vol=newArray(rows.length);


for( i=rows.length-1 ; i > 0; i--){
columns=split(rows[i],"\t"); 
Obj[i]=parseFloat(columns[1])-1; 
Label[i]=columns[2]; 
Vol[i]=parseFloat(columns[3]); 
Spher[i]=parseFloat(columns[13]); 
Elong[i]=parseFloat(columns[16]); 
Compac[i]=parseFloat(columns[12]); 


//test subject
//j=64

print("Object => "+Obj[i]);
print("Label => "+Label[i]);
//print("Compac =>"+Compac[i]);
//print("Spher =>"+Spher[i]);
//print("Elong =>"+Elong[i]);
"\t";

//Aproximate Compac max(0.25)- min(0.02) which from 0.17 is the recommended minimum value for a cell, i.e.:
recom_CompacIndex=1-(0.25-0.17)/(0.25-0.020);
curr_CompacIndex=1-(0.25-Compac[i])/(0.25-0.020);
print("Recomended CompacIndex => "+recom_CompacIndex);
print("Current CompacIndex => "+curr_CompacIndex);
pointsCompac=(curr_CompacIndex*50)/recom_CompacIndex;
points=toString(pointsCompac, 1);
print("Score => "+points+" points!");
print("--------------------------------");

//Aproximate Spher max(0.6)- min(0.27) which from 0.35 is the recommended minimum value for a cell, i.e.: 
recom_SpherIndex=1-(0.6-0.35)/(0.6-0.27);
curr_SpherIndex=1-(0.6-Spher[i])/(0.6-0.27);
print("Recomended SpherIndex => "+recom_SpherIndex);
print("Current SpherIndex => "+curr_SpherIndex);
pointsSpher=(curr_SpherIndex*50)/recom_SpherIndex;
points=toString(pointsSpher, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");

//Aproximate Elong max(6)- min(1.05) which from 2.2 is the recommended maximum value for a cell, i.e.: 
recom_ElongIndex=1-(1.05-2.2)/(1.05-6.0);
curr_ElongIndex=1-(1.05-Elong[i])/(1.05-6.0);
print("Recomended ElongIndex => "+recom_ElongIndex);
print("Current ElongIndex => "+curr_ElongIndex);
pointsElong=(curr_ElongIndex*50)/recom_ElongIndex;
points=toString(pointsElong, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");




Object_index=(curr_CompacIndex+curr_SpherIndex+curr_ElongIndex)/3;
print("current object_index=>"+Object_index);
Cellity_index =(recom_CompacIndex+recom_SpherIndex+recom_ElongIndex)/3;
print("Cellity_index=>"+Cellity_index);
pointsCellity=(Object_index*50)/Cellity_index;
points=toString(pointsCellity, 1);
print("Total Score => "+points+" points!");
print("------------------------------------------------");
print("------------------------------------------------");
if (Object_index >= Cellity_index) { 
	print("Congratz dude, it's a CELL!!!! :D");
} else {
	print("WTF!? IT'S A FREAKING CAPILLARY!!!");
	k=Obj[i];
	Ext.Manager3D_Select(k);
	Ext.Manager3D_Delete();
		}
print("------------------------------------------------");
print("------------------------------------------------");
}

Ext.Manager3D_SelectAll();
Ext.Manager3D_Save(output+nome_tsv+"_Darpp_segmented_objects");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_Darpp_somata.tsv");
Ext.Manager3D_CloseResult("M");


//Creating a mask of the real from the segmented somata
getDimensions(width, height, channels, slices, frames);
newImage("Seg_mask", "8-bit white", width, height, slices);
Ext.Manager3D_SelectAll();
Ext.Manager3D_FillStack(0, 0, 0);
Ext.Manager3D_Close();
selectWindow("Seg_mask");
run("Invert", "stack");

for (j=1; j<=slices; j++) {
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    run("Make Inverse");
    selectWindow("Darpp_somata_figure");
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    selectWindow("Darpp_original_NO_somata");   	
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    }
selectWindow("Darpp_somata_figure");
//saveAs(output+nome_tsv+"_Darpp_somata.tif");

//Closing left-over images
selectWindow("EDT");
close();
selectWindow("Seg");
close();
selectWindow("Seg_mask");
close();
selectWindow("Bin");
close();



//D1
//Segmenting and measuring somata
selectWindow("D1_EDT");
run("3D Simple Segmentation", "low_threshold=2750 min_size=750 max_size=-1");
run("3D Manager Options", "volume surface compactness fit_ellipse integrated_density mean_grey_value mode_grey_value minimum_grey_value maximum_grey_value exclude_objects_on_edges_xy sync distance_between_centers=10 distance_max_contact=1.80");
selectWindow("Seg");
run("3D Manager");
Ext.Manager3D_AddImage();
Ext.Manager3D_SelectAll();
//Ext.Manager3D_Save(output+nome_tsv+"_D1_segmented_objects_previous");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_D1_somata.tsv");
Ext.Manager3D_CloseResult("M");

/////////////////////////
/////////////////////////
//THIS MACRO FILTERS OUT NON-SOMA LIKE OBJECTS
"\t"
print("Trying to figure out which of those objects are somata and capillaries");
"\t"
file=File.openAsString(output+"M_"+nome_tsv+"_D1_somata.tsv"); 
rows=split(file, "\n"); 
Obj=newArray(rows.length); 
Label=newArray(rows.length);
Vol=newArray(rows.length);
Spher=newArray(rows.length);
Elong=newArray(rows.length);
Compac=newArray(rows.length);


for( i=rows.length-1 ; i > 0; i--){
columns=split(rows[i],"\t"); 
Obj[i]=parseFloat(columns[1])-1; 
Label[i]=columns[2]; 
Vol[i]=parseFloat(columns[3]); 
Spher[i]=parseFloat(columns[13]); 
Elong[i]=parseFloat(columns[16]); 
Compac[i]=parseFloat(columns[12]); 


//test subject
//j=64

print("Object => "+Obj[i]);
print("Label => "+Label[i]);
//print("Compac =>"+Compac[i]);
//print("Spher =>"+Spher[i]);
//print("Elong =>"+Elong[i]);
"\t";

//Aproximate Compac max(0.25)- min(0.02) which from 0.07 is the recommended minimum value for a cell, i.e.:
recom_CompacIndex=1-(0.25-0.07)/(0.25-0.020);
curr_CompacIndex=1-(0.25-Compac[i])/(0.25-0.020);
print("Recomended CompacIndex => "+recom_CompacIndex);
print("Current CompacIndex => "+curr_CompacIndex);
pointsCompac=(curr_CompacIndex*50)/recom_CompacIndex;
points=toString(pointsCompac, 1);
print("Score => "+points+" points!");
print("--------------------------------");

//Aproximate Spher max(0.6)- min(0.27) which from 0.47 is the recommended minimum value for a cell, i.e.: 
recom_SpherIndex=1-(0.6-0.47)/(0.6-0.27);
curr_SpherIndex=1-(0.6-Spher[i])/(0.6-0.27);
print("Recomended SpherIndex => "+recom_SpherIndex);
print("Current SpherIndex => "+curr_SpherIndex);
pointsSpher=(curr_SpherIndex*50)/recom_SpherIndex;
points=toString(pointsSpher, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");

//Aproximate Elong max(6)- min(1.05) which from 2.2 is the recommended maximum value for a cell, i.e.: 
recom_ElongIndex=1-(1.05-2.2)/(1.05-6.0);
curr_ElongIndex=1-(1.05-Elong[i])/(1.05-6.0);
print("Recomended ElongIndex => "+recom_ElongIndex);
print("Current ElongIndex => "+curr_ElongIndex);
pointsElong=(curr_ElongIndex*50)/recom_ElongIndex;
points=toString(pointsElong, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");




Object_index=(curr_CompacIndex+curr_SpherIndex+curr_ElongIndex)/3;
print("current object_index=>"+Object_index);
Cellity_index =(recom_CompacIndex+recom_SpherIndex+recom_ElongIndex)/3;
print("Cellity_index=>"+Cellity_index);
pointsCellity=(Object_index*50)/Cellity_index;
points=toString(pointsCellity, 1);
print("Total Score => "+points+" points!");
print("------------------------------------------------");
print("------------------------------------------------");
if (Object_index >= Cellity_index) { 
	print("Congratz dude, it's a CELL!!!! :D");
} else {
	print("WTF!? IT'S A FREAKING CAPILLARY!!!");
	k=Obj[i];
	Ext.Manager3D_Select(k);
	Ext.Manager3D_Delete();
		}
print("------------------------------------------------");
print("------------------------------------------------");
}

Ext.Manager3D_SelectAll();
Ext.Manager3D_Save(output+nome_tsv+"_D1_segmented_objects");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_D1_somata.tsv");
Ext.Manager3D_CloseResult("M");



//Creating a mask of the real from the segmented somata
selectWindow("Seg");
getDimensions(width, height, channels, slices, frames);
newImage("Seg_mask", "8-bit white", width, height, slices);
Ext.Manager3D_SelectAll();
Ext.Manager3D_FillStack(0, 0, 0);
Ext.Manager3D_Close();
selectWindow("Seg_mask");
run("Invert", "stack");

for (j=1; j<=slices; j++) {
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    run("Make Inverse");
    selectWindow("D1_somata");
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    selectWindow("D1_dendInt_NO_somata");   	
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    }
selectWindow("D1_somata");
//saveAs(output+nome_tsv+"_D1_somata.tif");

//Saving 3D graphs
//run("3D Viewer");
//call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
//call("ij3d.ImageJ3DViewer.add", "D1_A_original", "Green", "D1_A_original", "0", "true", "true", "true", "2", "0");
Ext.Manager3D_Close();

//and from this point you have to filter objects with combined minum: Spareness=>0.850; Compactness=>0.08; Sphericity=> 0.4

print("\nD1 somata measurements completed");


//closing leftover images
selectWindow("D1_EDT");
close();
selectWindow("Seg_mask");
close();
selectWindow("Bin");
close();
selectWindow("Seg");
close();

  
//D2
//Segmenting and measuring somata
selectWindow("D2_EDT");
run("3D Simple Segmentation", "low_threshold=2750 min_size=750 max_size=-1");
run("3D Manager Options", "volume surface compactness fit_ellipse integrated_density mean_grey_value mode_grey_value minimum_grey_value maximum_grey_value exclude_objects_on_edges_xy sync distance_between_centers=10 distance_max_contact=1.80");
selectWindow("Seg");
run("3D Manager");
Ext.Manager3D_AddImage();
Ext.Manager3D_SelectAll();
//Ext.Manager3D_Save(output+nome_tsv+"_D2_segmented_objects_previous");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_D2_somata.tsv");
Ext.Manager3D_CloseResult("M");

/////////////////////////
/////////////////////////
//THIS MACRO FILTERS OUT NON-SOMA LIKE OBJECTS
"\t"
print("Trying to figure out which of those objects are somata and capillaries");
"\t"
file=File.openAsString(output+"M_"+nome_tsv+"_D2_somata.tsv"); 
rows=split(file, "\n"); 
Obj=newArray(rows.length); 
Label=newArray(rows.length);
Vol=newArray(rows.length);
Spher=newArray(rows.length);
Elong=newArray(rows.length);
Compac=newArray(rows.length);

i=0;
for( i=rows.length-1 ; i > 0; i--){
columns=split(rows[i],"\t"); 
Obj[i]=parseFloat(columns[1])-1; 
Label[i]=columns[2]; 
Vol[i]=parseFloat(columns[3]); 
Spher[i]=parseFloat(columns[13]); 
Elong[i]=parseFloat(columns[16]); 
Compac[i]=parseFloat(columns[12]); 


//test subject
//j=64

print("Object => "+Obj[i]);
print("Label => "+Label[i]);
//print("Compac =>"+Compac[i]);
//print("Spher =>"+Spher[i]);
//print("Elong =>"+Elong[i]);
"\t";

//Aproximate Compac max(0.25)- min(0.02) which from 0.07 is the recommended minimum value for a cell, i.e.:
recom_CompacIndex=1-(0.25-0.07)/(0.25-0.020);
curr_CompacIndex=1-(0.25-Compac[i])/(0.25-0.020);
print("Recomended CompacIndex => "+recom_CompacIndex);
print("Current CompacIndex => "+curr_CompacIndex);
pointsCompac=(curr_CompacIndex*50)/recom_CompacIndex;
points=toString(pointsCompac, 1);
print("Score => "+points+" points!");
print("--------------------------------");

//Aproximate Spher max(0.6)- min(0.27) which from 0.47 is the recommended minimum value for a cell, i.e.: 
recom_SpherIndex=1-(0.6-0.47)/(0.6-0.27);
curr_SpherIndex=1-(0.6-Spher[i])/(0.6-0.27);
print("Recomended SpherIndex => "+recom_SpherIndex);
print("Current SpherIndex => "+curr_SpherIndex);
pointsSpher=(curr_SpherIndex*50)/recom_SpherIndex;
points=toString(pointsSpher, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");

//Aproximate Elong max(6)- min(1.05) which from 2.2 is the recommended maximum value for a cell, i.e.: 
recom_ElongIndex=1-(1.05-2.2)/(1.05-6.0);
curr_ElongIndex=1-(1.05-Elong[i])/(1.05-6.0);
print("Recomended ElongIndex => "+recom_ElongIndex);
print("Current ElongIndex => "+curr_ElongIndex);
pointsElong=(curr_ElongIndex*50)/recom_ElongIndex;
points=toString(pointsElong, 1);
print("Score => "+points+" points!");
print("------------------------------------------------");




Object_index=(curr_CompacIndex+curr_SpherIndex+curr_ElongIndex)/3;
print("current object_index=>"+Object_index);
Cellity_index =(recom_CompacIndex+recom_SpherIndex+recom_ElongIndex)/3;
print("Cellity_index=>"+Cellity_index);
pointsCellity=(Object_index*50)/Cellity_index;
points=toString(pointsCellity, 1);
print("Total Score => "+points+" points!");
print("------------------------------------------------");
print("------------------------------------------------");
	if (Object_index >= Cellity_index) { 
	print("Congratz dude, it's a CELL!!!! :D");
	}	else {
	print("WTF!? IT'S A FREAKING CAPILLARY!!!");
	k=Obj[i];
	Ext.Manager3D_Select(k);
	Ext.Manager3D_Delete();
		}
print("------------------------------------------------");
print("------------------------------------------------");
}

Ext.Manager3D_SelectAll();
Ext.Manager3D_Save(output+nome_tsv+"_D2_segmented_objects");
Ext.Manager3D_Measure();
Ext.Manager3D_SaveMeasure(output+nome_tsv+"_D2_somata.tsv");
Ext.Manager3D_CloseResult("M");


//Creating a mask of the real from the segmented somata
selectWindow("Seg");
getDimensions(width, height, channels, slices, frames);
newImage("Seg_mask", "8-bit white", width, height, slices);
Ext.Manager3D_SelectAll();
Ext.Manager3D_FillStack(0, 0, 0);
Ext.Manager3D_Close();
selectWindow("Seg_mask");
run("Invert", "stack");

for (j=1; j<=slices; j++) {
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    run("Make Inverse");
    selectWindow("D2_somata");
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    selectWindow("Seg_mask");    
    setSlice(j);
    run("Create Selection");
    selectWindow("D2_dendInt_NO_somata");   	
    setSlice(j);
    run("Restore Selection");
    setBackgroundColor(0, 0, 0);
	setForegroundColor(0, 0, 0);
    run("Clear Outside", "slice");
    }
selectWindow("D2_somata");
//saveAs(output+nome_tsv+"_D2_somata.tif");

//Saving 3D graphs
//run("3D Viewer");
//call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
//call("ij3d.ImageJ3DViewer.add", "D1_A_original", "Green", "D1_A_original", "0", "true", "true", "true", "2", "0");

print("D2 somata measurements completed");



//Measure 3D dendrite density
//D1 densities
selectWindow("D1_dendInt");//measurements with somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 0, "D1 with somata"); 
setResult("mean_gray_in_stack", 0, stackMean);
setResult("median", 0, stackMedian);
setResult("Integrated_density", 0, stackIntegrated);
setResult("voxel_count", 0, voxelCount);
selectWindow("D1_dendInt_NO_somata");//measurements withouth somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 1, "D1 without somata"); 
setResult("mean_gray_in_stack", 1, stackMean);
setResult("median", 1, stackMedian);
setResult("Integrated_density", 1, stackIntegrated);
setResult("voxel_count", 1, voxelCount);

selectWindow("D1_dendInt_NO_somata");
run("Select All");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file copy_row save_column save_row");
print("D1 axon density measurements completed");


//D2 densities
selectWindow("D2_dendInt");//measurements with somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 2, "D2 with somata"); 
setResult("mean_gray_in_stack", 2, stackMean);
setResult("median", 2, stackMedian);
setResult("Integrated_density", 2, stackIntegrated);
setResult("voxel_count", 2, voxelCount);
selectWindow("D2_dendInt_NO_somata");//measurements withouth somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 3, "D2 without somata"); 
setResult("mean_gray_in_stack", 3, stackMean);
setResult("median", 3, stackMedian);
setResult("Integrated_density", 3, stackIntegrated);
setResult("voxel_count", 3, voxelCount);

selectWindow("D2_dendInt_NO_somata");
run("Select All");
run("Enhance Contrast", "saturated=0.4 normalize normalize_all");
print("D2 axon density measurements completed");



//Darpp densities

selectWindow("Darpp_original");//measurements with somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 4, "Darpp with somata"); 
setResult("mean_gray_in_stack", 4, stackMean);
setResult("median", 4, stackMedian);
setResult("Integrated_density", 4, stackIntegrated);
setResult("voxel_count", 4, voxelCount);
selectWindow("Darpp_original_NO_somata");//measurements without somata
Stack.getStatistics(voxelCount, stackMean, stackMedian, stackIntegrated);
setResult("Label", 5, "Darpp without somata"); 
setResult("mean_gray_in_stack", 5, stackMean);
setResult("median", 5, stackMedian);
setResult("Integrated_density", 5, stackIntegrated);
setResult("voxel_count", 5, voxelCount);

run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file copy_row save_column save_row");
saveAs("Results", output+nome_tsv+"_axon_densities.tsv");
run("Clear Results"); 


run("Enhance Contrast...", "saturated=0.4 normalize process_all"); //note that enhancement happens only after density measurements
rename("Darpp_axon_blue");
print("Darpp axon density measurements completed\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");


//Making image with D1&D2 axons (red&green) with somata (magenta&cyan) 
run("Merge Channels...", "c1=D2_dendInt_NO_somata c2=D1_dendInt_NO_somata c5=D1_somata c6=D2_somata keep");
saveAs(output+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
close();
//+ one image including Darpp axons (blue)
run("Merge Channels...", "c1=D2_dendInt_NO_somata c2=D1_dendInt_NO_somata c3=Darpp_axon_blue c5=D1_somata c6=D2_somata keep");
saveAs(output+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
close();
//+ one image including Darpp positice cells (blue)
run("Merge Channels...", "c1=D2_dendInt_NO_somata c2=D1_dendInt_NO_somata c3=Darpp_somata_figure c5=D1_somata c6=D2_somata keep");
saveAs(output+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
close();
//+ one image with only axons
run("Merge Channels...", "c1=D2_dendInt_NO_somata c2=D1_dendInt_NO_somata c3=Darpp_axon_blue keep");
saveAs(output+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif");
close();
//+ one image including 3 positive cells (D1_green+D2_red+Darpp_blue)
run("Merge Channels...", "c1=D2_somata c2=D1_somata c3=Darpp_somata_figure keep");
saveAs(output+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif");
close();

//3D COLOCALIZATION ANALYSIS

//D1 & D2
run("3D Manager");
Ext.Manager3D_Load(output+nome_tsv+"_D1_segmented_objects");
Ext.Manager3D_Load(output+nome_tsv+"_D2_segmented_objects");
Ext.Manager3D_Coloc();
Ext.Manager3D_SaveResult("C", output+nome_tsv+"_D1_D2coloc.tsv");
Ext.Manager3D_CloseResult("C");
Ext.Manager3D_Close();
print("D1&D2 colocalization analysis completed");

//D1 & Darpp
run("3D Manager");
Ext.Manager3D_Load(output+nome_tsv+"_D1_segmented_objects");
Ext.Manager3D_Load(output+nome_tsv+"_Darpp_segmented_objects");
Ext.Manager3D_Coloc();
Ext.Manager3D_SaveResult("C", output+nome_tsv+"_D1_Darppcoloc.tsv");
Ext.Manager3D_CloseResult("C");
Ext.Manager3D_Close();
print("D1&Darpp colocalization analysis completed");

//D2 & Darpp
run("3D Manager");
Ext.Manager3D_Load(output+nome_tsv+"_D2_segmented_objects");
Ext.Manager3D_Load(output+nome_tsv+"_Darpp_segmented_objects");
Ext.Manager3D_Coloc();
Ext.Manager3D_SaveResult("C", output+nome_tsv+"_D2_Darppcoloc.tsv");
Ext.Manager3D_CloseResult("C");
Ext.Manager3D_Close();

print("D1&Darpp colocalization analysis completed");


while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }
       
       
 
 }
}

//Cleaning all
 if (isOpen("Results")) { 
       selectWindow("Results"); 
       run("Close"); 
   } 
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }  

x=100; y=200; 
  call("ij.gui.WaitForUserDialog.setNextLocation",x,y); 
  waitForUser("DONE!!!!!!! It took "+(getTime()-start)/1000/60+" MINUTES or "+(getTime()-start)/1000/60/60+" HOURS... This means you need to upgrade this machine ;)"); 

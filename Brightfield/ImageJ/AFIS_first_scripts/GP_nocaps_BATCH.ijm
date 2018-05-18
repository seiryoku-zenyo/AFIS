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
setBatchMode("hide");
for (i=0; i<list.length; i++) {
 showProgress(i+1, list.length);

filename = input + list[i];
 if (matches(filename, ".*GP.*")) {
 open(filename);


nome=getInfo("image.filename");
nome_tsv=substring(nome,4,6)+"_"+substring(nome,0,3);
}
}


//CALIBRATION
run("Images to Stack", "name=GP_Stack title=[] use");


//for 3 images:
if (nSlices==3) {
run("Make Montage...", "columns=3 rows=1 scale=1 first=1 last=3 increment=1 border=0 font=12"); }

//for 2 images:
if (nSlices==2) {
run("Make Montage...", "columns=2 rows=1 scale=1 first=1 last=2 increment=1 border=0 font=12"); }

saveAs("Tiff", "C:\\Program Files (x86)\\ImageJ\\temp\\GP.tif");
run("Properties...", "channels=1 slices=1 frames=1 unit=µm pixel_width=0.16667 pixel_height=0.16667 voxel_depth=1.0000 global");
selectWindow("GP_Stack");
close();
selectWindow("GP.tif");


//MEASURE DENDRITES
run("8-bit");
//measure dendrites
selectWindow("GP.tif");
run("Set Measurements...", "area mean modal min integrated median area_fraction redirect=None decimal=3");
run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file copy_row save_row");
run("Measure");
saveAs("Results", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\dendrites\\"+nome_tsv+".tsv");
selectWindow("GP.tif");
saveAs("Tiff", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\dendrites\\"+nome_tsv+".tif");
run("Clear Results");


print("FINISHED -->"+nome_tsv+"!");


//closing out images
selectWindow("Results"); 
   run("Close");
macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
	  setBatchMode("exit and display");
setBatchMode("show");		  
		 open("C:\\Program Files (x86)\\ImageJ\\plugins\\ActionBar\\icons\\one_does_not_simply.jpg");
  } 
}
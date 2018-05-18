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
for (i=0; i<list.length; i++) {
 showProgress(i+1, list.length);

filename = input + list[i];
 if (matches(filename, ".*hab.*")) {
 open(filename);


nome=getInfo("image.filename");
nome_tsv=substring(nome,4,12)+"_"+substring(nome,0,3);



//CALIBRATION
saveAs("Tiff", "C:\\Program Files (x86)\\ImageJ\\temp\\Hab.tif");
run("Properties...", "channels=1 slices=1 frames=1 unit=um pixel_width=0.666666 pixel_height=0.666666 voxel_depth=1.0000000 global");

//FREEHAND DRAWING

setTool("freehand");
waitForUser("Make a nice drawing for me, please :)");
setBatchMode("hide");

//PROCESSING ANALYSIS
run("Crop");
run("8-bit");
setBackgroundColor(255, 255, 255);
run("Clear Outside");
run("Set Measurements...", "area mean modal min integrated median area_fraction redirect=None decimal=3");
run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file copy_row save_row");
run("Clear Results");
run("Measure");
saveAs("Results", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\dendrites\\"+nome_tsv+".tsv");
selectWindow("Hab.tif");
saveAs("Tiff", "S:\\sport-AFIS\\2015\\TH_ImageJ_OLD_RATS_results\\dendrites\\"+nome_tsv+".tif");

run("Clear Results");

print("FINISHED -->"+nome+"!");
}
  }

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
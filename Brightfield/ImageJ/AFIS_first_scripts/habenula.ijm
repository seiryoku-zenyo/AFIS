run("Crop");
run("8-bit");
setBackgroundColor(255, 255, 255);
run("Clear Outside");
run("Set Measurements...", "area mean modal min integrated median area_fraction redirect=None decimal=3");
run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file copy_row save_row");
run("Clear Results");
run("Measure");
saveAs("Results");
selectWindow("Hab.tif");
saveAs("Hab.tif");

run("Clear Results");


//closing out images
macro "Close All Windows" { 
      while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 
  } 


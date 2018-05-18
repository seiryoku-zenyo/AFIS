run("8-bit");
//measure dendrites
selectWindow("GP.tif");
run("Set Measurements...", "area mean modal min integrated median area_fraction redirect=None decimal=3");
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

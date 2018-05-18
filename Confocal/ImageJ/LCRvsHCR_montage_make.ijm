start = getTime(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }
/////////////////////////////////////////////////////
//D1 and D2 SOMATA + DARPP
/////////////////////////////////////////////////////
print("Opening data file...");
input_orig = getDirectory("Select the folder containing the images for analysis");
input = input_orig+"\SN\\";
print (input);
output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
print(filename);
 if (matches(filename, ".*_merge_D1somata_D2somata_Darpp.*")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) { 
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (blue)");
run("Z Project...", "projection=[Average Intensity]");

setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (green)] c3=[AVG_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (blue)] use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
  
 }if (matches(filename, ".*_merge_D1somata_D2somata_Darpp.*")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (blue)");
run("Z Project...", "projection=[Average Intensity]");

setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (green)] c3=[AVG_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (blue)] use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");

 }if (matches(filename, ".*_merge_D1somata_D2somata_Darpp.*")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {
brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (blue)");
run("Z Project...", "projection=[Average Intensity]");

setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (green)] c3=[AVG_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (blue)] use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1somata_D2somata_Darpp.*")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {
	brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}



corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (blue)");
run("Z Project...", "projection=[Average Intensity]");

setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (green)] c3=[AVG_"+nome_tsv+"_merge_D1somata_D2somata_Darpp.tif (blue)] use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}

setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");


//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2somata_D1somata_Darpp.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2somata_D1somata_Darpp.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2somata_D1somata_Darpp.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2somata_D1somata_Darpp.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2somata_D1somata_Darpp.tif");
close(); 


while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }

/////////////////////////////////////////////////////
//D1&D2 AXONS + SOMATA
/////////////////////////////////////////////////////
print("Opening data file...");
//input = getDirectory("Select the folder containing the images for analysis");
//output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata.tif")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");

selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c5=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c6=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
 
}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata.tif")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c5=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c6=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");
	
}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata.tif")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {

brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c5=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c6=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata.tif")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {

brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c5=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c6=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}

setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");


//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2axons_D1axons_D2somata_D1somata.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2axons_D1axons_D2somata_D1somata.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2axons_D1axons_D2somata_D1somata.tif");
close(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }




/////////////////////////////////////////////////////
//D1&D2 AXONS + SOMATA + DARPP
/////////////////////////////////////////////////////
print("Opening data file...");
//input = getDirectory("Select the folder containing the images for analysis");
//output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darpp.*")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) { 
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");

selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c3=AVG_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
  
 }if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darpp.*")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c3=AVG_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");

 }if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darpp.*")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {
brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c3=AVG_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darpp.*")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {
	brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}



corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c3=AVG_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darpp.tif use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}
setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");

//setBatchMode("exit and display");

//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2axons_D1axons_D2somata_D1somata_Darpp.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata_Darpp.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2axons_D1axons_D2somata_D1somata_Darpp.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
//drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata_Darpp.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2axons_D1axons_D2somata_D1somata_Darpp.tif");
close(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }

				  

/////////////////////////////////////////////////////
//D1&D2 AXONS + DARPP
/////////////////////////////////////////////////////
print("Opening data file...");
//input = getDirectory("Select the folder containing the images for analysis");
//output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_merge_D1axons_D2axons_Darpp.tif.*")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (blue)");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (green)] c3=[AVG_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (blue)] use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
 
}if (matches(filename, ".*_merge_D1axons_D2axons_Darpp.tif.*")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (blue)");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (green)] c3=[AVG_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (blue)] use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");
	
}if (matches(filename, ".*_merge_D1axons_D2axons_Darpp.tif.*")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {

brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (blue)");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (green)] c3=[AVG_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (blue)] use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1axons_D2axons_Darpp.tif.*")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {

brain_part= 'Substantia Nigra'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (blue)");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (green)] c3=[AVG_"+nome_tsv+"_merge_D1axons_D2axons_Darpp.tif (blue)] use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}
setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");


//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2axons_D1axons_Darpp.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
////drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2axons_D1axons_Darpp.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2axons_D1axons_Darpp.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2axons_D1axons_Darpp.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2axons_D1axons_Darpp.tif");
close(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }

				  
				  
				  
				  
				  //////////////////////////////////////CAUDATE PUAMEN//////////////////////////////////////////////
				  
				  
			

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }
				  
/////////////////////////////////////////////////////
//D1&D2 SOMATA + DARPP SOMATA
/////////////////////////////////////////////////////
print("Opening data file...");
input = input_orig+"\\CP\\";
output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_merge_D1somata_D2somata_Darpp.*")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (blue)");
run("Z Project...", "projection=[Max Intensity]");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (green)] c3=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (blue)] use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
 
}if (matches(filename, ".*_merge_D1somata_D2somata_Darpp.*")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (blue)");
run("Z Project...", "projection=[Max Intensity]");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (green)] c3=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (blue)] use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");
	
}if (matches(filename, ".*_merge_D1somata_D2somata_Darpp.*")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (blue)");
run("Z Project...", "projection=[Max Intensity]");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (green)] c3=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (blue)] use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1somata_D2somata_Darpp.*")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (blue)");
run("Z Project...", "projection=[Max Intensity]");

selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
selectWindow(nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (green)] c3=[MAX_"+nome_tsv+"_merge_D1somata_D2somata_Darppsomata.tif (blue)] use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}
setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");


//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2somata_D1somata_Darpp.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
////drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2somata_D1somata_Darpp.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2somata_D1somata_Darpp.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2somata_D1somata_Darpp.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2somata_D1somata_Darpp.tif");
close(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }



/////////////////////////////////////////////////////
//D1&D2 AXONS + SOMATA
/////////////////////////////////////////////////////
print("Opening data file...");
//input = getDirectory("Select the folder containing the images for analysis");
//output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata.tif")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");

selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c5=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c6=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
 
}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata.tif")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c5=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c6=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");
	
}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata.tif")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c5=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c6=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata.tif")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c5=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif c6=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata.tif use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}
setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");


//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2axons_D1axons_D2somata_D1somata.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
////drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2axons_D1axons_D2somata_D1somata.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2axons_D1axons_D2somata_D1somata.tif");
close(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }





/////////////////////////////////////////////////////
//D1&D2 AXONS + SOMATA + DARPP AXONS
/////////////////////////////////////////////////////
print("Opening data file...");
//input = getDirectory("Select the folder containing the images for analysis");
//output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.*")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");

selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c3=AVG_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
 
}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.*")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c3=AVG_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");
	
}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.*")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c3=AVG_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.*")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Average Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c3=AVG_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppaxons.tif use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}
setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");


//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2axons_D1axons_D2somata_D1somata_Darppaxons.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
////drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata_Darppaxons.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2axons_D1axons_D2somata_D1somata_Darppaxons.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata_Darppaxons.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2axons_D1axons_D2somata_D1somata_Darppaxons.tif");
close(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }




/////////////////////////////////////////////////////
//D1&D2 AXONS + SOMATA + DARPP SOMATA
/////////////////////////////////////////////////////
print("Opening data file...");
//input = getDirectory("Select the folder containing the images for analysis");
//output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.*")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");

selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c3=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
 
}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.*")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c3=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");
	
}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.*")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c3=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.*")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow("C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow("C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

selectWindow("C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif");
run("Z Project...", "projection=[Max Intensity]");

run("Merge Channels...", "c1=MAX_C1-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c2=MAX_C2-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c3=MAX_C3-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c5=MAX_C4-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif c6=MAX_C5-"+nome_tsv+"_merge_D1axons_D2axons_D1somata_D2somata_Darppsomata.tif use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}
setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");


//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2axons_D1axons_D2somata_D1somata_Darppsomata.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
////drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata_Darppsomata.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2axons_D1axons_D2somata_D1somata_Darppsomata.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2axons_D1axons_D2somata_D1somata_Darppsomata.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2axons_D1axons_D2somata_D1somata_Darppsomata.tif");
close(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }


/////////////////////////////////////////////////////
//D1&D2 AXONS + DARPP axons
/////////////////////////////////////////////////////
print("Opening data file...");
//input = getDirectory("Select the folder containing the images for analysis");
//output = input;

list = getFileList(input);
setBatchMode("hide");
for (l=0; l<list.length; l++) {
 showProgress(l+1, list.length);

filename = input + list[l];
 if (matches(filename, ".*_merge_D1axons_D2axons_Darppaxons.tif")&&matches(filename, ".*100.*")||matches(filename, ".*103.*")||matches(filename, ".*104.*")||matches(filename, ".*106.*")||matches(filename, ".*107.*")||matches(filename, ".*110.*")||matches(filename, ".*111.*")||matches(filename, ".*113.*")||matches(filename, ".*117.*")||matches(filename, ".*119.*")||matches(filename, ".*120.*")||matches(filename, ".*124.*")||matches(filename, ".*126.*")||matches(filename, ".*128.*")||matches(filename, ".*129.*")||matches(filename, ".*130.*")||matches(filename, ".*133.*")||matches(filename, ".*136.*")||matches(filename, ".*138.*")||matches(filename, ".*139.*")||matches(filename, ".*141.*")||matches(filename, ".*142.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}  

corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (blue)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (green)] c3=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (blue)] use");
rename("yLCR_stack"+nome_tsv);
close("Rat*");
 
}if (matches(filename, ".*_merge_D1axons_D2axons_Darppaxons.tif")&&matches(filename, ".*101.*")||matches(filename, ".*102.*")||matches(filename, ".*105.*")||matches(filename, ".*108.*")||matches(filename, ".*109.*")||matches(filename, ".*112.*")||matches(filename, ".*114.*")||matches(filename, ".*115.*")||matches(filename, ".*116.*")||matches(filename, ".*118.*")||matches(filename, ".*121.*")||matches(filename, ".*122.*")||matches(filename, ".*123.*")||matches(filename, ".*125.*")||matches(filename, ".*127.*")||matches(filename, ".*131.*")||matches(filename, ".*132.*")||matches(filename, ".*134.*")||matches(filename, ".*135.*")||matches(filename, ".*137.*")||matches(filename, ".*140.*")||matches(filename, ".*143.*")||matches(filename, ".*144.*")) {
brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (blue)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (green)] c3=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (blue)] use");
rename("yHCR_stack"+nome_tsv);
close("Rat*");
	
}if (matches(filename, ".*_merge_D1axons_D2axons_Darppaxons.tif")&&matches(filename, ".*202.*")||matches(filename, ".*203.*")||matches(filename, ".*207.*")||matches(filename, ".*208.*")||matches(filename, ".*209.*")||matches(filename, ".*211.*")||matches(filename, ".*213.*")||matches(filename, ".*215.*")||matches(filename, ".*217.*")||matches(filename, ".*219.*")||matches(filename, ".*220.*")||matches(filename, ".*222.*")||matches(filename, ".*224.*")||matches(filename, ".*226.*")||matches(filename, ".*228.*")||matches(filename, ".*230.*")||matches(filename, ".*232.*")||matches(filename, ".*234.*")||matches(filename, ".*236.*")||matches(filename, ".*238.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (blue)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (green)] c3=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (blue)] use");
rename("oHCR_stack"+nome_tsv);
close("Rat*");

}if (matches(filename, ".*_merge_D1axons_D2axons_Darppaxons.tif")&&matches(filename, ".*200.*")||matches(filename, ".*201.*")||matches(filename, ".*204.*")||matches(filename, ".*205.*")||matches(filename, ".*206.*")||matches(filename, ".*210.*")||matches(filename, ".*212.*")||matches(filename, ".*214.*")||matches(filename, ".*216.*")||matches(filename, ".*218.*")||matches(filename, ".*221.*")||matches(filename, ".*223.*")||matches(filename, ".*225.*")||matches(filename, ".*227.*")||matches(filename, ".*229.*")||matches(filename, ".*231.*")||matches(filename, ".*233.*")||matches(filename, ".*235.*")||matches(filename, ".*237.*")) {

brain_part= 'Caudate Putamen'; 
open(filename);

nome=getInfo("image.filename");
nome_tsv=substring(nome,0,6);
imageTitle=getTitle();//returns a string with the image title
print(nome_tsv);

//get normalizing data values from metadata file in order to correct for the intensities
metadata_file=File.openAsString(input+nome_tsv+"_metadata.txt");
rows=split(metadata_file, "\n"); 
for (i=0; i < rows.length; i++) {
    if (startsWith(rows[i], "IlluminationChannel Power #1")) {
        laser_power = split(rows[i], "\t");
        laser_value_405 = parseFloat(laser_power[1]);
    print("405 laser: "+laser_value_405);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #2")) {
        laser_power = split(rows[i], "\t");
        laser_value_488 = parseFloat(laser_power[1]);
    print("488 laser: "+laser_value_488);
    }
    if (startsWith(rows[i], "IlluminationChannel Power #3")) {
        laser_power = split(rows[i], "\t");
        laser_value_555 = parseFloat(laser_power[1]);
    print("555 laser: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #1")) {
        laser_power = split(rows[i], "\t");
        gain_value_405 = parseFloat(laser_power[1]);
    //print("405 gain: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #2")) {
        laser_power = split(rows[i], "\t");
        gain_value_488 = parseFloat(laser_power[1]);
    //print("488 gain: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Detector Gain #3")) {
        laser_power = split(rows[i], "\t");
        gain_value_555 = parseFloat(laser_power[1]);
    //print("555 gain: "+laser_value_555);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #1")) {
        laser_power = split(rows[i], "\t");
        offset_value_405 = parseFloat(laser_power[1]);
    //print("405 offset: "+laser_value_405);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #2")) {
        laser_power = split(rows[i], "\t");
        offset_value_488 = parseFloat(laser_power[1]);
    //print("488 offset: "+laser_value_488);
    }
    if (startsWith(rows[i], "DetectionChannel Amplifier Offset #3")) {
        laser_power = split(rows[i], "\t");
        offset_value_555 = parseFloat(laser_power[1]);
    //print("555 offset: "+laser_value_555);
    }
}


corr_fact_B=(((laser_value_405*2)+(gain_value_405/100)+((offset_value_405+10)/10))/3)/6;//correcting factor for blue
corr_fact_G=(((laser_value_488*2)+(gain_value_488/100)+((offset_value_488+10)/10))/3)/6;//correcting factor for green
corr_fact_R=(((laser_value_555*2)+(gain_value_555/100)+((offset_value_555+10)/10))/3)/6;//correcting factor for red

run("Size...", "width=256 height=256 depth=17 constrain average interpolation=Bilinear");

run("Split Channels");
selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (blue)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_B*20), 255-(corr_fact_B*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (green)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_G*20), 255-(corr_fact_G*20)); //apply laser power correction
run("Apply LUT");

selectWindow(nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (red)");
run("Z Project...", "projection=[Max Intensity]");
setMinAndMax(0+(corr_fact_R*20), 255-(corr_fact_R*20)); //apply laser power correction
run("Apply LUT");

run("Merge Channels...", "c1=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (red)] c2=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (green)] c3=[MAX_"+nome_tsv+"_merge_D1axons_D2axons_Darppaxons.tif (blue)] use");
rename("oLCR_stack"+nome_tsv);
close("Rat*");
}

}
setForegroundColor(255, 255, 255);
run("Images to Stack", "name=yHCR_stacked title=yHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yHCR range=1-1");
close("yHCR_stack*");

run("Images to Stack", "name=yLCR_stacked title=yLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("yLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=yLCR range=1-1");
close("yLCR_stack*");

run("Images to Stack", "name=oHCR_stacked title=oHCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oHCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oHCR range=1-1");
close("oHCR_stack*");

run("Images to Stack", "name=oLCR_stacked title=oLCR_stack");
run("Make Montage...", "columns=3 rows=4 scale=1 border=1");
rename("oLCR_mntg");
run("Label...", "format=Text starting=0 interval=1 x=600 y=900 font=40 text=oLCR range=1-1");
close("oLCR_stack*");


//young rats
run("Images to Stack", "name=yLCR_vs_yHCR title=y keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / yLCR", 1320, 860);
saveAs(output+"yLCR_vs_yHCR_D2axons_D1axons_Darppaxons.tif");
close(); 

//old rats
run("Images to Stack", "name=oLCR_vs_oHcr title=o keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
setFont("Serif", 44, "antialiased");
////drawString("oHCR / oLCR", 1320, 860);
saveAs(output+"oLCR_vs_oHCR_D2axons_D1axons_Darppaxons.tif");
close(); 

//LCR rats
run("Images to Stack", "name=yLCR_vs_oLCR title=LCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yLCR / oLCR", 1320, 860);
saveAs(output+"yLCR_vs_oLCR_D2axons_D1axons_Darppaxons.tif.tif");
//close(); 

//HCR rats
run("Images to Stack", "name=yHCR_vs_oLCR title=HCR keep");
run("Make Montage...", "columns=2 rows=1 scale=1 border=10");
run("Scale Bar...", "width=100 height=15 font=0 color=White background=None location=[Lower Right] hide");//100 micrometers scale
//setFont("Serif", 44, "antialiased");
////drawString("yHCR / oHCR", 1320, 860);
saveAs(output+"yHCR_vs_oHCR_D2axons_D1axons_Darppaxons.tif");
//close(); 

//4 groups montage
run("Images to Stack", "name=Stack_4g title=Montage");
run("Make Montage...", "columns=1 rows=2 scale=0.5 border=5");
saveAs(output+"All_groups_D2axons_D1axons_Darppaxons.tif");
close(); 

while (nImages>0) { 
         selectImage(nImages); 
         close(); 
   				  }
				  
				  
				  				  
				  


x=100; y=200; 
  call("ij.gui.WaitForUserDialog.setNextLocation",x,y); 
  waitForUser("DONE!!!!!!! It took "+(getTime()-start)/1000/60+" MINUTES or "+(getTime()-start)/1000/60/60+" HOURS... This means you need to upgrade this machine ;)"); 
   				  
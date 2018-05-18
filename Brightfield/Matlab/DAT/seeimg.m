%Display images in order to quick inspect

function [] = seeimg(var,source)

SOURCE=source

if SOURCE == 'original'
    %read folders of all rats
    folders = dir('S:\sport-AFIS\2015\lab_work\AFIS_TH\rat*')
    %ID the rats per group
    for i = [1 2 6 9 11 12 13 15 18 19 25 26 28 29 31 35 36]
    HCR_file_ID{i,1} = folders(i,1).name
    end;
    
    for i = [3 4 5 7 8 10 14 16 17 20 21 22 23 24 27 30 32 33 34]
    LCR_file_ID{i,1} = folders(i,1).name
    end;
    
    files_LCR =
    for i=1:36
    
    figure('name','dendinha')
    
  
    imshow(dendrites,'InitialMagnification', 12.5,'Border','tight');
else
    figure('name','dendona')
    dendrites = imread(['S:\sport-AFIS\2015\TH_ImageJ_results\dendrites\*' var '*.tif']);
    imshow(dendrites,'InitialMagnification', 12.5,'Border','tight');
 
 
end
    
end


%filelist = dir(fullfile(['S:\sport-AFIS\2015\lab_work\AFIS_TH\rat115\', '*' var '*.tif']));
%{Files for processed images
%for i= 1:5
%Cpu_WB_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_results\white_bodies\Cpu_*.tif')
%GP_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_results\dendrites\GP_*.tif')
%Hab_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_results\dendrites\hab*.tif')
%SN_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_results\dendrites\SN3*.tif')
%VTA_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_results\VTA\*VTA1_somata.tif')
%filelist = dir(fullfile(S:\sport-AFIS\2015\lab_work\AFIS_TH, '*.tif'));
%}
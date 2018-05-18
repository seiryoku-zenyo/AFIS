%IDENTIFYING VARIABLES TO BE ANALYZED:

%SN_D1_soma_#
%SN_D1_soma_size
%SN_D1_axon_signal_mean_norm1
%SN_D1_axon_signal_mean_no_somata_norm1
%SN_D1_axon_signal_mean_norm2
%SN_D1_axon_signal_mean_no_somata_norm2
%SN_D1_axon_signal_mean_norm3
%SN_D1_axon_signal_mean_no_somata_norm3
%SN_D1_axon_voxels

%SN_D2_soma_#
%SN_D2_soma_size
%SN_D2_axon_signal_mean_norm1
%SN_D2_axon_signal_mean_no_somata_norm1
%SN_D2_axon_signal_mean_norm2
%SN_D2_axon_signal_mean_no_somata_norm2
%SN_D2_axon_signal_mean_norm3
%SN_D2_axon_signal_mean_no_somata_norm3
%SN_D2_axon_voxels

%SN_D1D2_coloc

%SN_Darpp_axon_signal_mean_norm1
%SN_Darpp_axon_signal_mean_no_somata_norm1
%SN_Darpp_axon_signal_mean_norm2
%SN_Darpp_axon_signal_mean_no_somata_norm2
%SN_Darpp_axon_signal_mean_norm3
%SN_Darpp_axon_signal_mean_no_somata_norm3
%SN_Darpp_axon_voxels



%CP_D1_soma_#
%CP_D1_soma_size
%CP_D1_axon_signal_mean_norm1
%CP_D1_axon_signal_mean_no_somata_norm1
%CP_D1_axon_signal_mean_norm2
%CP_D1_axon_signal_mean_no_somata_norm2
%CP_D1_axon_signal_mean_norm3
%CP_D1_axon_signal_mean_no_somata_norm3
%CP_D1_axon_voxels

%CP_D2_soma_#
%CP_D2_soma_size
%CP_D2_axon_signal_mean_norm1
%CP_D2_axon_signal_mean_no_somata_norm1
%CP_D2_axon_signal_mean_norm2
%CP_D2_axon_signal_mean_no_somata_norm2
%CP_D2_axon_signal_mean_norm3
%CP_D2_axon_signal_mean_no_somata_norm3
%CP_D2_axon_voxels

%CP_D1D2_coloc
%CP_D1D2Darpp_coloc

%CP_Darpp_soma_#
%CP_Darpp_soma_size
%CP_Darpp_axon_signal_mean_norm1
%CP_Darpp_axon_signal_mean_no_somata_norm1
%CP_Darpp_axon_signal_mean_norm2
%CP_Darpp_axon_signal_mean_no_somata_norm2
%CP_Darpp_axon_signal_mean_norm3
%CP_Darpp_axon_signal_mean_no_somata_norm3
%CP_Darpp_axon_voxels






%OBTAINING THESE VARIABLES:

%Identifying subject files for counting purposes
subject_CP_files=dir ('S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\*D1_D2coloc.tsv')
subject_SN_files=dir ('S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\*D1_D2coloc.tsv')

% %Count the number of subjects
subject_n_CP=numel(subject_CP_files)
subject_n_SN=numel (subject_SN_files)

%Give IDs to the respective subjects
for j=1:subject_n_CP
    subject_id_CP{j}=subject_CP_files(j).name (3:8);
end;

for j=1:subject_n_SN
    subject_id_SN{j}=subject_SN_files(j).name (3:8);  
end;



%Atribute different subjects their respective files for each anatomical part 
for i=1:subject_n_CP
    CP_D1_somata {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_D1_somata*']);
    CP_D2_somata {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_D2_somata*']);
    CP_Darpp_somata {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_Darpp_somata*']);
    CP_axon_densities {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities*']);
    CP_D1D2_coloc {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\C_' subject_id_CP{i} '_D1_D2coloc*']);
    CP_D1Darpp_coloc {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\C_' subject_id_CP{i} '_D1_Darppcoloc*']);
    CP_D2_Darpp_coloc {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_D2_Darppcoloc*']);
end

for i=1:subject_n_SN
    SN_D1_somata {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\M_' subject_id_SN{i} '_D1_somata*']);
    SN_D2_somata {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\M_' subject_id_SN{i} '_D2_somata*']);
    SN_axon_densities {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities*']);
    SN_D1D2_coloc {i} = dir(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\C_' subject_id_SN{i} '_D1_D2coloc*']);
end



%Read data from inside the files and start feeding it into the variables

%CP...
for i= 1:subject_n_CP
   %D1
   CP_D1_somata{i}.subject_ID_code = subject_id_CP{i}(4:6);
   CP_D1_somata{i}.number = numel(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_D1_somata.tsv'], '', 'D2..D:'));
   CP_D1_somata{i}.volume = mean(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_D1_somata.tsv'], '', 'D2..D:'));
   CP_D1_somata{i}.voxelcount = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H2..H2');
   CP_D1_somata{i}.number_Corrected_for_voxels = (CP_D1_somata{i}.number/CP_D1_somata{i}.voxelcount)*17825792; %which is the number of voxels in standard stacks of 17 slices
   
   CP_D1_axon_signal{i}.subject_ID_code = subject_id_CP{i}(4:6);
   CP_D1_axon_signal{i}.mean_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'E2..E2');
   CP_D1_axon_signal{i}.intden_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'G2..G2');
   CP_D1_axon_signal{i}.voxelcount_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H2..H2');
   CP_D1_axon_signal{i}.mean_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'E3..E3');
   CP_D1_axon_signal{i}.intden_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'G3..G3');
   CP_D1_axon_signal{i}.MEAN_Corrected_for_voxels_somata = (CP_D1_axon_signal{i}.mean_with_somata/CP_D1_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices
   CP_D1_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata = (CP_D1_axon_signal{i}.mean_without_somata/CP_D1_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices   
   %CP_D1_axon_signal{i}.voxelcount_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H3..H3');   
   CP_D1_axon_signal{i}.laserPower = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'], '','D177..D177');
   CP_D1_axon_signal{i}.detectorGain = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'],'','E122..E122'); 
   CP_D1_axon_signal{i}.Offset = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'], '','E110..E110');
   CP_D1_axon_signal{i}.correction_factor_3_set =(((CP_D1_axon_signal{i}.laserPower*2)+(CP_D1_axon_signal{i}.detectorGain/100)+((CP_D1_axon_signal{i}.Offset+100)/10))/3)/6;
   CP_D1_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_somata = CP_D1_axon_signal{i}.MEAN_Corrected_for_voxels_somata/CP_D1_axon_signal{i}.correction_factor_3_set;
   CP_D1_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_NO_somata = CP_D1_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata/CP_D1_axon_signal{i}.correction_factor_3_set;

   
   %D2
   CP_D2_somata{i}.subject_ID_code = subject_id_CP{i}(4:6);
   CP_D2_somata{i}.number = numel(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_D2_somata.tsv'], '', 'D2..D:'));
   CP_D2_somata{i}.volume = mean(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_D2_somata.tsv'], '', 'D2..D:'));
   CP_D2_somata{i}.voxelcount = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H4..H4');
   CP_D2_somata{i}.number_Corrected_for_voxels = (CP_D2_somata{i}.number/CP_D2_somata{i}.voxelcount)*17825792; %which is the number of voxels in standard stacks of 17 slices
   
   CP_D2_axon_signal{i}.subject_ID_code = subject_id_CP{i}(4:6);
   CP_D2_axon_signal{i}.mean_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'E4..E4');
   CP_D2_axon_signal{i}.intden_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'G4..G4');
   CP_D2_axon_signal{i}.voxelcount_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H4..H4');
   CP_D2_axon_signal{i}.mean_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'E5..E5');
   CP_D2_axon_signal{i}.intden_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'G5..G5');
   CP_D2_axon_signal{i}.MEAN_Corrected_for_voxels_somata = (CP_D2_axon_signal{i}.mean_with_somata/CP_D2_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices
   CP_D2_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata = (CP_D2_axon_signal{i}.mean_without_somata/CP_D2_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices   
   %CP_D2_axon_signal{i}.voxelcount_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H5..H5');   
   CP_D2_axon_signal{i}.laserPower = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'], '','D178..D178');
   CP_D2_axon_signal{i}.detectorGain = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'],'','E123..E123'); 
   CP_D2_axon_signal{i}.Offset = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'], '','E111..E111');
   CP_D2_axon_signal{i}.correction_factor_3_set =(((CP_D2_axon_signal{i}.laserPower*2)+(CP_D2_axon_signal{i}.detectorGain/100)+((CP_D2_axon_signal{i}.Offset+100)/10))/3)/6;
   CP_D2_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_somata = CP_D2_axon_signal{i}.MEAN_Corrected_for_voxels_somata/CP_D2_axon_signal{i}.correction_factor_3_set;
   CP_D2_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_NO_somata = CP_D2_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata/CP_D2_axon_signal{i}.correction_factor_3_set;

   
   %Darpp
   CP_Darpp_somata{i}.subject_ID_code = subject_id_CP{i}(4:6);
   CP_Darpp_somata{i}.number = numel(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_Darpp_somata.tsv'], '', 'D2..D:'));
   CP_Darpp_somata{i}.volume = mean(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\M_' subject_id_CP{i} '_Darpp_somata.tsv'], '', 'D2..D:'));
   CP_Darpp_somata{i}.voxelcount = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H6..H6');
   CP_Darpp_somata{i}.number_Corrected_for_voxels = (CP_Darpp_somata{i}.number/CP_Darpp_somata{i}.voxelcount)*17825792; %which is the number of voxels in standard stacks of 17 slices
   
   CP_Darpp_axon_signal{i}.subject_ID_code = subject_id_CP{i}(4:6);
   CP_Darpp_axon_signal{i}.mean_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'E6..E6');
   CP_Darpp_axon_signal{i}.intden_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'G6..G6');
   CP_Darpp_axon_signal{i}.voxelcount_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H6..H6');
   CP_Darpp_axon_signal{i}.mean_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'E7..E7');
   CP_Darpp_axon_signal{i}.intden_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'G7..G7');
   CP_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels_somata = (CP_Darpp_axon_signal{i}.mean_with_somata/CP_Darpp_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices
   CP_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata = (CP_Darpp_axon_signal{i}.mean_without_somata/CP_Darpp_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices
   %CP_Darpp_axon_signal{i}.voxelcount_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_axon_densities.tsv'], '', 'H7..H7');   
   CP_Darpp_axon_signal{i}.laserPower = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'], '','D176..D176');
   CP_Darpp_axon_signal{i}.detectorGain = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'],'','E121..E121'); 
   CP_Darpp_axon_signal{i}.Offset = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\' subject_id_CP{i} '_metadata.txt'], '','E109..E109');
   CP_Darpp_axon_signal{i}.correction_factor_3_set=(((CP_Darpp_axon_signal{i}.laserPower*2)+(CP_Darpp_axon_signal{i}.detectorGain/100)+((CP_Darpp_axon_signal{i}.Offset+100)/10))/3)/6;
   CP_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_somata = CP_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels_somata/CP_Darpp_axon_signal{i}.correction_factor_3_set;
   CP_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_NO_somata = CP_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata/CP_Darpp_axon_signal{i}.correction_factor_3_set;

   
   %Colocalizations
   
      %//////////////////////////////////////
      %D1 AND D2
      %//////////////////////////////////////
      %Read the data from file(s)
    A=fopen(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\C_' subject_id_CP{i} '_D1_D2coloc.tsv']);
    filedata{i}=textscan(A,'%s %s %s %s %s %s %s %s %s');
    D1D2_coloc_labels{i}=filedata{i}{1,4}(2:length(filedata{i}{1,4}));%object ID
    

      
   CP_D1D2_coloc{i}= dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\C_' subject_id_CP{i} '_D1_D2coloc.tsv'], '', 'G2..G:');%object value
 
   %finding colocalized D1 bodies and their average colocalized portion
l=1;
CP_D1_coloc{i}.subject_ID_code = subject_id_CP{i}(4:6);
for j=1:2:length(CP_D1D2_coloc{i});
     if CP_D1D2_coloc{i}(j,1) > 0         
CP_D1_coloc{i}.D1D2_soma_portion_value(l,1)= [CP_D1D2_coloc{i}(j,1)];%object Value
CP_D1_coloc{i}.D1D2_soma_portion_ID(l,1)= [D1D2_coloc_labels{i}(j,1)];%object ID
l=l+1;    
     end
end
%calculating the total percentage of D2 bodies that do colocalize with D1
CP_D1_coloc{i}.D1D2_tot_percent = (length(CP_D1_coloc{i}.D1D2_soma_portion_value)/CP_D1_somata{i}.number)*100;
CP_D1_coloc{i}.D1D2_soma_portion_value_mean= mean(CP_D1_coloc{i}.D1D2_soma_portion_value);%object mean Value

%finding colocalized D2 bodies and their average colocalized portion
l=1;
CP_D2_coloc{i}.subject_ID_code = subject_id_CP{i}(4:6);
for j=2:2:length(CP_D1D2_coloc{i});
     if CP_D1D2_coloc{i}(j,1) > 0          
CP_D2_coloc{i}.D2D1_soma_portion_value(l,1)= [CP_D1D2_coloc{i}(j,1)];%object Value
CP_D2_coloc{i}.D2D1_soma_portion_ID(l,1)= [D1D2_coloc_labels{i}(j,1)];%object ID
l=l+1;    
     end
end
%calculating the total percentage of D2 bodies that do colocalize with D1
CP_D2_coloc{i}.D2D1_tot_percent = (length(CP_D2_coloc{i}.D2D1_soma_portion_value)/CP_D2_somata{i}.number)*100;
CP_D2_coloc{i}.D2D1_soma_portion_value_mean= mean(CP_D2_coloc{i}.D2D1_soma_portion_value);%object mean Value   




      %//////////////////////////////////////
      %D1 AND Darpp
      %//////////////////////////////////////
      %Read the data from file(s)
    A=fopen(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\C_' subject_id_CP{i} '_D1_Darppcoloc.tsv']);
    filedata{i}=textscan(A,'%s %s %s %s %s %s %s %s %s');
    D1Darpp_coloc_labels{i}=filedata{i}{1,4}(2:length(filedata{i}{1,4}));%object ID

      
   CP_D1Darpp_coloc{i}= dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\C_' subject_id_CP{i} '_D1_Darppcoloc.tsv'], '', 'G2..G:');%object value
 
   %finding colocalized D1 bodies and their average colocalized portion
l=1;
CP_D1_coloc{i}.subject_ID_code = subject_id_CP{i}(4:6);         
for j=1:2:length(CP_D1Darpp_coloc{i});
     if CP_D1Darpp_coloc{i}(j,1) > 0
CP_D1_coloc{i}.D1Darpp_soma_portion_value(l,1)= [CP_D1Darpp_coloc{i}(j,1)];%object Value
CP_D1_coloc{i}.D1Darpp_soma_portion_ID(l,1)= [D1Darpp_coloc_labels{i}(j,1)];%object ID
l=l+1;    
     end
end
%calculating the total percentage of D1 bodies that do colocalize with Darpp
CP_D1_coloc{i}.D1Darpp_tot_percent = (length(CP_D1_coloc{i}.D1Darpp_soma_portion_value)/CP_D1_somata{i}.number)*100;
CP_D1_coloc{i}.D1Darpp_soma_portion_value_mean= mean(CP_D1_coloc{i}.D1Darpp_soma_portion_value);%object mean Value

%finding colocalized Darpp bodies and their average colocalized portion
l=1;
CP_Darpp_coloc{i}.subject_ID_code = subject_id_CP{i}(4:6); 
for j=2:2:length(CP_D1Darpp_coloc{i});
     if CP_D1Darpp_coloc{i}(j,1) > 0           
CP_Darpp_coloc{i}.DarppD1_soma_portion_value(l,1)= [CP_D1Darpp_coloc{i}(j,1)];%object Value
CP_Darpp_coloc{i}.DarppD1_soma_portion_ID(l,1)= [D1Darpp_coloc_labels{i}(j,1)];%object ID
l=l+1;    
     end
end
%calculating the total percentage of Darpp bodies that do colocalize with D1
CP_Darpp_coloc{i}.DarppD1_tot_percent = (length(CP_Darpp_coloc{i}.DarppD1_soma_portion_value)/CP_Darpp_somata{i}.number)*100;
CP_Darpp_coloc{i}.DarppD1_soma_portion_value_mean= mean(CP_Darpp_coloc{i}.DarppD1_soma_portion_value);%object mean Value



%//////////////////////////////////////
      %D2 AND Darpp
      %//////////////////////////////////////
      %Read the data from file(s)
    A=fopen(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\C_' subject_id_CP{i} '_D2_Darppcoloc.tsv']);
    filedata{i}=textscan(A,'%s %s %s %s %s %s %s %s %s');
    D2Darpp_coloc_labels{i}=filedata{i}{1,4}(2:length(filedata{i}{1,4}));%object ID

      
   CP_D2Darpp_coloc{i}= dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\CP\C_' subject_id_CP{i} '_D2_Darppcoloc.tsv'], '', 'G2..G:');%object value
 
   CP_D2_coloc{i}.subject_ID_code = subject_id_CP{i}(4:6);
   %finding colocalized D2 bodies and their average colocalized portion
l=1;
for j=1:2:length(CP_D2Darpp_coloc{i});
     if CP_D2Darpp_coloc{i}(j,1) > 0         
CP_D2_coloc{i}.D2Darpp_soma_portion_value(l,1)= [CP_D2Darpp_coloc{i}(j,1)];%object Value
CP_D2_coloc{i}.D2Darpp_soma_portion_ID(l,1)= [D2Darpp_coloc_labels{i}(j,1)];%object ID
l=l+1;    
     end
end
%calculating the total percentage of D2 bodies that do colocalize with Darpp
CP_D2_coloc{i}.D2Darpp_tot_percent = (length(CP_D2_coloc{i}.D2Darpp_soma_portion_value)/CP_D2_somata{i}.number)*100;
CP_D2_coloc{i}.D2Darpp_soma_portion_value_mean= mean(CP_D2_coloc{i}.D2Darpp_soma_portion_value);%object mean Value


%finding colocalized Darpp bodies and their average colocalized portion
l=1;
CP_Darpp_coloc{i}.subject_ID_code = subject_id_CP{i}(4:6);
for j=2:2:length(CP_D2Darpp_coloc{i});
     if CP_D2Darpp_coloc{i}(j,1) > 0    
CP_Darpp_coloc{i}.DarppD2_soma_portion_value(l,1)= [CP_D2Darpp_coloc{i}(j,1)];%object Value
CP_Darpp_coloc{i}.DarppD2_soma_portion_ID(l,1)= [D2Darpp_coloc_labels{i}(j,1)];%object ID
l=l+1;    
     end
end
%calculating the total percentage of Darpp bodies that do colocalize with
%D2
CP_Darpp_coloc{i}.DarppD2_tot_percent = (length(CP_Darpp_coloc{i}.DarppD2_soma_portion_value)/CP_Darpp_somata{i}.number)*100;
CP_Darpp_coloc{i}.DarppD2_soma_portion_value_mean= mean(CP_Darpp_coloc{i}.DarppD2_soma_portion_value);%object mean Value
   


%Check when each marker (D1, D2 and Darpp) does colocalize with the other 2
%at the same time in the same soma.

 CP_3_coloc{i}.subject_ID_code = subject_id_CP{i}(4:6);
 %D1
 CP_3_coloc{i}.D1_DOUBLE_COLOC_ID = mintersect(CP_D1_coloc{i}.D1D2_soma_portion_ID, CP_D1_coloc{i}.D1Darpp_soma_portion_ID);
 CP_3_coloc{i}.D1_DOUBLE_COLOC_percentage = length(CP_3_coloc{i}.D1_DOUBLE_COLOC_ID)/CP_D1_somata{i}.number*100; 
 %D2
 CP_3_coloc{i}.D2_DOUBLE_COLOC_ID = mintersect(CP_D2_coloc{i}.D2D1_soma_portion_ID, CP_D2_coloc{i}.D2Darpp_soma_portion_ID);
 CP_3_coloc{i}.D2_DOUBLE_COLOC_percentage = length(CP_3_coloc{i}.D2_DOUBLE_COLOC_ID)/CP_D2_somata{i}.number*100; 
 %Darpp 
 CP_3_coloc{i}.Darpp_DOUBLE_COLOC_ID = mintersect(CP_Darpp_coloc{i}.DarppD2_soma_portion_ID, CP_Darpp_coloc{i}.DarppD1_soma_portion_ID);
 CP_3_coloc{i}.Darpp_DOUBLE_COLOC_percentage = length(CP_3_coloc{i}.Darpp_DOUBLE_COLOC_ID)/CP_Darpp_somata{i}.number*100; 
 
end






%SN...
for i= 1:subject_n_SN
   %D1
   SN_D1_somata{i}.subject_ID_code = subject_id_SN{i}(4:6);
   SN_D1_somata{i}.number = numel(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\M_' subject_id_SN{i} '_D1_somata.tsv'], '', 'D2..D:'));
   SN_D1_somata{i}.volume = mean(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\M_' subject_id_SN{i} '_D1_somata.tsv'], '', 'D2..D:'));
   SN_D1_somata{i}.voxelcount = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'H2..H2');
   SN_D1_somata{i}.number_Corrected_for_voxels = (SN_D1_somata{i}.number/SN_D1_somata{i}.voxelcount)*17825792; %which is the number of voxels in standard stacks of 17 slices
   
   
   SN_D1_axon_signal{i}.subject_ID_code = subject_id_SN{i}(4:6);
   SN_D1_axon_signal{i}.mean_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'E2..E2');
   SN_D1_axon_signal{i}.intden_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'G2..G2');
   SN_D1_axon_signal{i}.voxelcount_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'H2..H2');
   SN_D1_axon_signal{i}.mean_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'E3..E3');
   SN_D1_axon_signal{i}.intden_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'G3..G3');
   SN_D1_axon_signal{i}.MEAN_Corrected_for_voxels_somata = (SN_D1_axon_signal{i}.mean_with_somata/SN_D1_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices
   SN_D1_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata = (SN_D1_axon_signal{i}.mean_without_somata/SN_D1_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices
   %SN_D1_axon_signal{i}.voxelcount_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'H3..H3');   
   SN_D1_axon_signal{i}.laserPower = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'], '','D177..D177');
   SN_D1_axon_signal{i}.detectorGain = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'],'','E122..E122'); 
   SN_D1_axon_signal{i}.Offset = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'], '','E110..E110');
   SN_D1_axon_signal{i}.correction_factor_3_set =(((SN_D1_axon_signal{i}.laserPower*2)+(SN_D1_axon_signal{i}.detectorGain/100)+((SN_D1_axon_signal{i}.Offset+100)/10))/3)/6;
   SN_D1_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_somata = SN_D1_axon_signal{i}.MEAN_Corrected_for_voxels_somata/SN_D1_axon_signal{i}.correction_factor_3_set;
   SN_D1_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_NO_somata = SN_D1_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata/SN_D1_axon_signal{i}.correction_factor_3_set;

   
   %D2
   SN_D2_somata{i}.subject_ID_code = subject_id_SN{i}(4:6);
   SN_D2_somata{i}.number = numel(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\M_' subject_id_SN{i} '_D2_somata.tsv'], '', 'D2..D:'));
   SN_D2_somata{i}.volume = mean(dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\M_' subject_id_SN{i} '_D2_somata.tsv'], '', 'D2..D:'));
   SN_D2_somata{i}.voxelcount = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'H4..H4');
   SN_D2_somata{i}.number_Corrected_for_voxels = (SN_D2_somata{i}.number/SN_D2_somata{i}.voxelcount)*17825792; %which is the number of voxels in standard stacks of 17 slices
   
   
   SN_D2_axon_signal{i}.subject_ID_code = subject_id_SN{i}(4:6);
   SN_D2_axon_signal{i}.mean_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'E4..E4');
   SN_D2_axon_signal{i}.intden_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'G4..G4');
   SN_D2_axon_signal{i}.voxelcount_with_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'H4..H4');
   SN_D2_axon_signal{i}.mean_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'E5..E5');
   SN_D2_axon_signal{i}.intden_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'G5..G5');
   SN_D2_axon_signal{i}.MEAN_Corrected_for_voxels_somata = (SN_D2_axon_signal{i}.mean_with_somata/SN_D2_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices
   SN_D2_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata = (SN_D2_axon_signal{i}.mean_without_somata/SN_D2_axon_signal{i}.voxelcount_with_somata)*17825792; %which is the number of voxels in standard stacks of 17 slices
   %SN_D2_axon_signal{i}.voxelcount_without_somata = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'H5..H5');   
   SN_D2_axon_signal{i}.laserPower = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'], '','D178..D178');
   SN_D2_axon_signal{i}.detectorGain = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'],'','E123..E123'); 
   SN_D2_axon_signal{i}.Offset = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'], '','E111..E111');
   SN_D2_axon_signal{i}.correction_factor_3_set =(((SN_D2_axon_signal{i}.laserPower*2)+(SN_D2_axon_signal{i}.detectorGain/100)+((SN_D2_axon_signal{i}.Offset+100)/10))/3)/6;
   SN_D2_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_somata = SN_D2_axon_signal{i}.MEAN_Corrected_for_voxels_somata/SN_D2_axon_signal{i}.correction_factor_3_set;
   SN_D2_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor_NO_somata = SN_D2_axon_signal{i}.MEAN_Corrected_for_voxels_NO_somata/SN_D2_axon_signal{i}.correction_factor_3_set;

   
   %Darpp
   SN_Darpp_axon_signal{i}.subject_ID_code = subject_id_SN{i}(4:6);
   SN_Darpp_axon_signal{i}.mean = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'C6..C6');
   SN_Darpp_axon_signal{i}.intden = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'E6..E6');
   SN_Darpp_axon_signal{i}.voxelcount = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_axon_densities.tsv'], '', 'F6..F6');
   SN_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels = (SN_Darpp_axon_signal{i}.mean/SN_Darpp_axon_signal{i}.voxelcount)*17825792; %which is the number of voxels in standard stacks of 17 slices
   SN_Darpp_axon_signal{i}.laserPower = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'], '','D176..D176');
   SN_Darpp_axon_signal{i}.detectorGain = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'],'','E121..E121'); 
   SN_Darpp_axon_signal{i}.Offset = dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\' subject_id_SN{i} '_metadata.txt'], '','E109..E109');
   SN_Darpp_axon_signal{i}.correction_factor_3_set=(((SN_Darpp_axon_signal{i}.laserPower*2)+(SN_Darpp_axon_signal{i}.detectorGain/100)+((SN_Darpp_axon_signal{i}.Offset+100)/10))/3)/6;
   SN_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels_and_correction_factor = SN_Darpp_axon_signal{i}.MEAN_Corrected_for_voxels/SN_Darpp_axon_signal{i}.correction_factor_3_set;

   
      %Colocalizations
   
      %//////////////////////////////////////
      %D1 AND D2
      %//////////////////////////////////////
      %Read the data from file(s)
    A=fopen(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\C_' subject_id_SN{i} '_D1_D2coloc.tsv']);
    filedata{i}=textscan(A,'%s %s %s %s %s %s %s %s %s');
    D1D2_coloc_labels{i}=filedata{i}{1,4}(2:length(filedata{i}{1,4}));%object ID
    

      
   SN_D1D2_coloc{i}= dlmread(['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\SN\C_' subject_id_SN{i} '_D1_D2coloc.tsv'], '', 'G2..G:');%object value
 
   %finding colocalized D1 bodies and their average colocalized portion
l=1;
SN_D1_coloc{i}.subject_ID_code = subject_id_SN{i}(4:6);
for j=1:2:length(SN_D1D2_coloc{i});
     if SN_D1D2_coloc{i}(j,1) > 0         
SN_D1_coloc{i}.D1D2_soma_portion_value(l,1)= [SN_D1D2_coloc{i}(j,1)];%object Value
SN_D1_coloc{i}.D1D2_soma_portion_ID(l,1)= [D1D2_coloc_labels{i}(j,1)];%object ID
l=l+1;    
     end
end
%calculating the total percentage of D1 bodies that do colocalize with D2
SN_D1_coloc{i}.D1D2_tot_percent = (length(SN_D1_coloc{i}.D1D2_soma_portion_value)/SN_D1_somata{i}.number)*100;
SN_D1_coloc{i}.D1D2_soma_portion_value_mean= mean(SN_D1_coloc{i}.D1D2_soma_portion_value);%object mean Value

%finding colocalized D2 bodies and their average colocalized portion
l=1;
SN_D2_coloc{i}.subject_ID_code = subject_id_SN{i}(4:6);
for j=2:2:length(SN_D1D2_coloc{i});
     if SN_D1D2_coloc{i}(j,1) > 0          
SN_D2_coloc{i}.D2D1_soma_portion_value(l,1)= [SN_D1D2_coloc{i}(j,1)];%object Value
SN_D2_coloc{i}.D2D1_soma_portion_ID(l,1)= [D1D2_coloc_labels{i}(j,1)];%object ID
l=l+1;    
     end
end
%calculating the total percentage of D2 bodies that do colocalize with D1
SN_D2_coloc{i}.D2D1_tot_percent = (length(SN_D2_coloc{i}.D2D1_soma_portion_value)/SN_D2_somata{i}.number)*100;
SN_D2_coloc{i}.D2D1_soma_portion_value_mean= mean(SN_D2_coloc{i}.D2D1_soma_portion_value);%object mean Value
end



%Arranging and creating groups for later statistical analysis
%Group subjects into respective rat lines
yhcr = [{[101   102   105   108   109   112   114   115   116   118   121   122   123 125   127   131   132   134   135   137   140   143   144]}]
ylcr = [{[100   103   104   106   107   110   111   113   117   119   120   124   126 128   129   130   133   136   138   139   141   142]}]
ohcr = [{[202   203   207   208   209   211   213   215   217   219   220   222   224 226   228   230   232   234   236   238]}]
olcr = [{[200   201   204   205   206   210   212   214   216   218   221   223   225 227   229   231   233   235   237]}]



%TOTALS PER SUBJECT


%WRITING FINAL TABLE

all_subjects = union (subject_id_CP, subject_id_SN);
i = 1;
ii = 1;

for x = 1:length(all_subjects)
   %Write a line to a table with the data of this subject
    if strcmp (all_subjects(x), subject_id_CP(i)) && strcmp (all_subjects(x), subject_id_SN(ii))
        tabela (x,:) = [all_subjects(x), CP_D1_somata{1,i}.number_Corrected_for_voxels, CP_D1_somata{1,i}.volume, CP_D1_axon_signal{1,i}.MEAN_Corrected_for_voxels_somata, CP_D1_axon_signal{1,i}.MEAN_Corrected_for_voxels_NO_somata, CP_D2_somata{1,i}.number_Corrected_for_voxels, CP_D2_somata{1,i}.volume, CP_D2_axon_signal{1,i}.MEAN_Corrected_for_voxels_somata, CP_D2_axon_signal{1,i}.MEAN_Corrected_for_voxels_NO_somata, CP_Darpp_somata{1,i}.number_Corrected_for_voxels, CP_Darpp_somata{1,i}.volume, CP_Darpp_axon_signal{1,i}.MEAN_Corrected_for_voxels_somata, CP_Darpp_axon_signal{1,i}.MEAN_Corrected_for_voxels_NO_somata, CP_D1_coloc{1,i}.D1D2_soma_portion_value_mean, CP_D1_coloc{1,i}.D1D2_tot_percent, CP_D1_coloc{1,i}.D1Darpp_soma_portion_value_mean, CP_D1_coloc{1,i}.D1Darpp_tot_percent, CP_Darpp_coloc{1,i}.DarppD2_soma_portion_value_mean, CP_Darpp_coloc{1,i}.DarppD2_tot_percent, CP_Darpp_coloc{1,i}.DarppD1_soma_portion_value_mean, CP_Darpp_coloc{1,i}.DarppD1_tot_percent, CP_D2_coloc{1,i}.D2Darpp_soma_portion_value_mean, CP_D2_coloc{1,i}.D2Darpp_tot_percent, CP_D2_coloc{1,i}.D2D1_soma_portion_value_mean, CP_D2_coloc{1,i}.D2D1_tot_percent, SN_D1_somata{1,ii}.number_Corrected_for_voxels, SN_D1_somata{1,ii}.volume, SN_D1_axon_signal{1,ii}.MEAN_Corrected_for_voxels_somata, SN_D1_axon_signal{1,ii}.MEAN_Corrected_for_voxels_NO_somata, SN_D2_somata{1,ii}.number_Corrected_for_voxels, SN_D2_somata{1,ii}.volume, SN_D2_axon_signal{1,ii}.MEAN_Corrected_for_voxels_somata, SN_D2_axon_signal{1,ii}.MEAN_Corrected_for_voxels_NO_somata, SN_Darpp_axon_signal{1,ii}.MEAN_Corrected_for_voxels_and_correction_factor, SN_D1_coloc{1,ii}.D1D2_soma_portion_value_mean, SN_D1_coloc{1,ii}.D1D2_tot_percent, SN_D2_coloc{1,ii}.D2D1_soma_portion_value_mean, SN_D2_coloc{1,ii}.D2D1_tot_percent]
        i = i+1;
        ii = ii+1;
    elseif strcmp (all_subjects(x), subject_id_CP(i))
        tabela (x,:) = [all_subjects(x), CP_D1_somata{1,i}.number_Corrected_for_voxels, CP_D1_somata{1,i}.volume, CP_D1_axon_signal{1,i}.MEAN_Corrected_for_voxels_somata, CP_D1_axon_signal{1,i}.MEAN_Corrected_for_voxels_NO_somata, CP_D2_somata{1,i}.number_Corrected_for_voxels, CP_D2_somata{1,i}.volume, CP_D2_axon_signal{1,i}.MEAN_Corrected_for_voxels_somata, CP_D2_axon_signal{1,i}.MEAN_Corrected_for_voxels_NO_somata, CP_Darpp_somata{1,i}.number_Corrected_for_voxels, CP_Darpp_somata{1,i}.volume, CP_Darpp_axon_signal{1,i}.MEAN_Corrected_for_voxels_somata, CP_Darpp_axon_signal{1,i}.MEAN_Corrected_for_voxels_NO_somata, CP_D1_coloc{1,i}.D1D2_soma_portion_value_mean, CP_D1_coloc{1,i}.D1D2_tot_percent, CP_D1_coloc{1,i}.D1Darpp_soma_portion_value_mean, CP_D1_coloc{1,i}.D1Darpp_tot_percent, CP_Darpp_coloc{1,i}.DarppD2_soma_portion_value_mean, CP_Darpp_coloc{1,i}.DarppD2_tot_percent, CP_Darpp_coloc{1,i}.DarppD1_soma_portion_value_mean, CP_Darpp_coloc{1,i}.DarppD1_tot_percent, CP_D2_coloc{1,i}.D2Darpp_soma_portion_value_mean, CP_D2_coloc{1,i}.D2Darpp_tot_percent, CP_D2_coloc{1,i}.D2D1_soma_portion_value_mean, CP_D2_coloc{1,i}.D2D1_tot_percent, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN]
        i = i+1;
    elseif strcmp (all_subjects(x), subject_id_SN(ii))
        tabela (x,:) = [all_subjects(x), NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, SN_D1_somata{1,ii}.number_Corrected_for_voxels, SN_D1_somata{1,ii}.volume, SN_D1_axon_signal{1,ii}.MEAN_Corrected_for_voxels_somata, SN_D1_axon_signal{1,ii}.MEAN_Corrected_for_voxels_NO_somata, SN_D2_somata{1,ii}.number_Corrected_for_voxels, SN_D2_somata{1,ii}.volume, SN_D2_axon_signal{1,ii}.MEAN_Corrected_for_voxels_somata, SN_D2_axon_signal{1,ii}.MEAN_Corrected_for_voxels_NO_somata, SN_Darpp_axon_signal{1,ii}.MEAN_Corrected_for_voxels_and_correction_factor, SN_D1_coloc{1,ii}.D1D2_soma_portion_value_mean, SN_D1_coloc{1,ii}.D1D2_tot_percent, SN_D2_coloc{1,ii}.D2D1_soma_portion_value_mean, SN_D2_coloc{1,ii}.D2D1_tot_percent]
        ii = ii+1;
    end;  
end;

header = {'ID' 'CP_D1_#' 'CP_D1_vol' 'CP_D1_signal' 'CP_D1_signal_w/o_soma' 'CP_D2_#' 'CP_D2_vol' 'CP_D2_signal' 'CP_D2_signal_w/o_soma' 'CP_Darpp_#' 'CP_Darpp_vol' 'CP_Darpp_signal' 'CP_Darpp_signal_w/o_soma' 'CP_D1-D2' 'CP_D1-D2%' 'CP_D1-Darpp' 'CP_D1-Darpp%' 'CP_Darpp-D2' 'CP_Darpp-D2%' 'CP_Darpp-D1' 'CP_Darpp-D1%' 'CP_D2-Darpp' 'CP_D2-Darpp%' 'CP_D2-D1' 'CP_D2-D1%' 'SN_D1_#' 'SN_D1_vol' 'SN_D1_signal' 'SN_D1_signal_w/o_soma' 'SN_D2_#' 'SN_D2_vol' 'SN_D2_signal' 'SN_D2_signal_w/o_soma' 'SN_Darpp_signal' 'SN_D1-D2' 'SN_D1-D2%' 'SN_D2-D1' 'SN_D2-D1%'};
final = [header; tabela]

   
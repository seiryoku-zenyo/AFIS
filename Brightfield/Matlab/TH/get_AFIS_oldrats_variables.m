clear



%Identifying subject files for counting purposes
subject_Cpu_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\white_bodies\Cpu1_*.tsv')
subject_GP_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\GP_*.tsv')
subject_Hab_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\hab*.tsv')
subject_SN_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\SN3*.tsv')
subject_VTA_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\VTA*.tsv')

%Count the number of subjects
subject_n=numel(subject_Cpu_files)
subject_n_GP=numel(subject_GP_files)
subject_n_Hab=numel (subject_Hab_files)
subject_n_SN=numel (subject_SN_files)
subject_n_VTA=numel (subject_VTA_files)

%Give IDs to the respective subjects
for j=1:subject_n
    subject_id{j}=subject_Cpu_files(j).name (6:8);
end;

for jj=1:subject_n_GP
    subject_id_GP{jj}=subject_GP_files(jj).name (4:6);
end;

for jjj=1:subject_n_Hab
    subject_id_Hab{jjj}=subject_Hab_files(jjj).name (10:12);
end;

for jjjj=1:subject_n_SN
    subject_id_SN{jjjj}=subject_SN_files(jjjj).name (5:7);  
end;

for jjjjj=1:subject_n_VTA
   subject_id_VTA{jjjjj}=subject_VTA_files(jjjjj).name (5:7);  
end;


%Atribute different subjects their respective files for each anatomical part 
for i=1:subject_n
    wb_Cpu_{i} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\white_bodies\Cpu*' subject_id{i} '.tsv']);
    dend_Cpu {i} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\Cpu*' subject_id{i} '.tsv']);
    %caps_Cpu {i} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\Cpu*' subject_id{i} '.tsv']);
end

for jj=1:subject_n_GP
    dend_GP {jj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\GP_*' subject_id_GP{jj} '.tsv']);
    %caps_GP {jj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\GP_*' subject_id_GP{jj} '.tsv']);
end;

for jjj=1:subject_n_Hab
    dend_Hab {jjj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\hab*' subject_id_Hab{jjj} '.tsv']);
end;

for jjjj=1:subject_n_SN
    dend_SN {jjjj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\SN*' subject_id_SN{jjjj} '.tsv']);
    soma_SN {jjjj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\somata\SN*' subject_id_SN{jjjj} '.tsv']);
end;

for jjjjj=1:subject_n_VTA
    dend_VTA {jjjjj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\' 'VTA_' subject_id_VTA{jjjjj} '.tsv']);
    soma_VTA {jjjjj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\somata\' 'VTA_' subject_id_VTA{jjjjj} '.tsv']);
end;



%Read data from inside the files

%White bodies...
for i= 1:subject_n
    n_sections = numel(wb_Cpu_{i});
for j = 1:n_sections
   white_bodies_Cpu{i}(j).number = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\white_bodies\' wb_Cpu_{i}(j).name], '', 'A1..A:');
   white_bodies_Cpu{i}(j).area = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\white_bodies\' wb_Cpu_{i}(j).name], '', 'B1..B:');
   white_bodies_Cpu{i}(j).intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\white_bodies\' wb_Cpu_{i}(j).name], '', 'C1..C:');
   
   %Dendrites...
   % in caudate putamen
   %'abs(x-255)' inverts dendrite gray values for easier interpretation and comparison with already
   %inverted VTA and SN
   dendrites_Cpu{i}(j).mean = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Cpu{i}(j).name], '', 'B1..B:')-255);
   dendrites_Cpu{i}(j).mode = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Cpu{i}(j).name], '', 'C1..C:')-255);
   dendrites_Cpu{i}(j).intdens = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Cpu{i}(j).name], '', 'F1..F:')-255);
   dendrites_Cpu{i}(j).median = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Cpu{i}(j).name], '', 'G1..G:')-255);
   dendrites_Cpu{i}(j).area_fract = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Cpu{i}(j).name], '', 'H1..H:');
   dendrites_Cpu{i}(j).RAW_intdens = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Cpu{i}(j).name], '', 'I1..I:')-255);
   
   

   %Capillaries...
   % in caudate putamen
   %capillaries_Cpu{i}(j).number = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\' caps_Cpu{i}(j).name], '', 'A1..A:');
   %capillaries_Cpu{i}(j).area = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\' caps_Cpu{i}(j).name], '', 'B1..B:');
   %capillaries_Cpu{i}(j).intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\' caps_Cpu{i}(j).name], '', 'C1..C:');
   %capillaries_Cpu{i}(j).RAW_intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\' caps_Cpu{i}(j).name], '', 'D1..D:');
end;
end
%Invert gray values for easier interpretation and comparison with already
%inverted VTA and SN
dendrites_Cpu{i}(j)


   %Dendrites...
   % in globus pallidus
   %'abs(x-255)' inverts dendrite gray values for easier interpretation and comparison with already
   %inverted VTA and SN
   for jj=1:subject_n_GP
   dendrites_GP{jj}.mean = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_GP{jj}.name], '', 'C1..C:')-255);
   dendrites_GP{jj}.mode = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_GP{jj}.name], '', 'D1..D:')-255);
   dendrites_GP{jj}.intdens = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_GP{jj}.name], '', 'G1..G:')-255);
   dendrites_GP{jj}.median = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_GP{jj}.name], '', 'H1..H:')-255);
   dendrites_GP{jj}.area_fract = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_GP{jj}.name], '', 'I1..I:');
   dendrites_GP{jj}.RAW_intdens = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_GP{jj}.name], '', 'J1..J:')-255);
   end;
  
   % in habenula
   %'abs(x-255)' inverts dendrite gray values for easier interpretation and comparison with already
   %inverted VTA and SN
   for jjj=1:subject_n_Hab
   dendrites_Hab{jjj}.mean = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Hab{jjj}.name], '', 'C1..C:')-255);
   dendrites_Hab{jjj}.mode = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Hab{jjj}.name], '', 'D1..D:')-255);
   dendrites_Hab{jjj}.intdens = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Hab{jjj}.name], '', 'G1..G:')-255);
   dendrites_Hab{jjj}.median = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Hab{jjj}.name], '', 'H1..H:')-255);
   dendrites_Hab{jjj}.area_fract = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Hab{jjj}.name], '', 'I1..I:');
   dendrites_Hab{jjj}.RAW_intdens = abs(dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_Hab{jjj}.name], '', 'J1..J:')-255);
   end;
   
   %in VTA
for jjjjj= 1:subject_n_VTA
    n_sections_VTA = numel(dend_VTA{jjjjj});
for l = 1:n_sections_VTA
   dendrites_VTA{jjjjj}(l).mean = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\' dend_VTA{jjjjj}(l).name], '', 'C1..C:');
   dendrites_VTA{jjjjj}(l).mode = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\' dend_VTA{jjjjj}(l).name], '', 'D1..D:');
   dendrites_VTA{jjjjj}(l).intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\' dend_VTA{jjjjj}(l).name], '', 'G1..G:');
   dendrites_VTA{jjjjj}(l).median = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\' dend_VTA{jjjjj}(l).name], '', 'H1..H:');
   dendrites_VTA{jjjjj}(l).area_fract = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\' dend_VTA{jjjjj}(l).name], '', 'I1..I:');
   dendrites_VTA{jjjjj}(l).RAW_intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\' dend_VTA{jjjjj}(l).name], '', 'J1..J:');
   
   %Somata in VTA
   somata_VTA{jjjjj}(l).number = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\somata\' soma_VTA{jjjjj}(l).name], '', 'A1..A:');
   somata_VTA{jjjjj}(l).area = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\somata\' soma_VTA{jjjjj}(l).name], '', 'B1..B:');   
end;
end;
   
   % in subtantia nigra
for jjjj= 1:subject_n_SN
    n_sections_SN = numel(dend_SN{jjjj});
for k = 1:n_sections_SN
   dendrites_SN{jjjj}(k).mean = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_SN{jjjj}(k).name], '', 'C1..C:');
   dendrites_SN{jjjj}(k).mode = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_SN{jjjj}(k).name], '', 'D1..D:');
   dendrites_SN{jjjj}(k).intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_SN{jjjj}(k).name], '', 'G1..G:');
   dendrites_SN{jjjj}(k).median = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_SN{jjjj}(k).name], '', 'H1..H:');
   dendrites_SN{jjjj}(k).area_fract = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_SN{jjjj}(k).name], '', 'I1..I:');
   dendrites_SN{jjjj}(k).RAW_intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\dendrites\' dend_SN{jjjj}(k).name], '', 'J1..J:');
   
   %Somata in subtantia nigra
   somata_SN{jjjj}(k).number = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\somata\' soma_SN{jjjj}(k).name], '', 'A1..A:');
   somata_SN{jjjj}(k).area = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\somata\' soma_SN{jjjj}(k).name], '', 'B1..B:');   
end;
end;


%Capillaries in globus pallidus
%for jj=1:subject_n_GP
%   capillaries_GP{jj}.number = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\' caps_GP{jj}.name], '', 'A1..A:');
%   capillaries_GP{jj}.area = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\' caps_GP{jj}.name], '', 'B1..B:');
%   capillaries_GP{jj}.intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\' caps_GP{jj}.name], '', 'C1..C:');
%   capillaries_GP{jj}.RAW_intdens = dlmread(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\capillaries\' caps_GP{jj}.name], '', 'D1..D:');
%end;

%Ligning up diferent section columns per subject lines (caudate putamen)
for i= 1:subject_n
    n_sections = numel(wb_Cpu_{i});
for j = 1:n_sections
   wb_numbers{i,j} = numel(white_bodies_Cpu{i}(j).number)
   wb_areas{i,j} = mean(white_bodies_Cpu{i}(j).area)
   wb_intdens{i,j} = mean(white_bodies_Cpu{i}(j).intdens)
   
   dend_means{i,j} = mean(dendrites_Cpu{i}(j).mean)
   dend_modes{i,j} = mean(dendrites_Cpu{i}(j).mode)
   dend_ints{i,j} = mean(dendrites_Cpu{i}(j).intdens)
   dend_medians{i,j} = mean(dendrites_Cpu{i}(j).median)
   dend_areafracs{i,j} = mean(dendrites_Cpu{i}(j).area_fract)
   dend_RAWints{i,j} = mean(dendrites_Cpu{i}(j).RAW_intdens)
   
   %cap_numbers{i,j} = numel(capillaries_Cpu{i}(j).number)
   %cap_areas{i,j} = mean(capillaries_Cpu{i}(j).area)
   %cap_intdens{i,j} = mean(capillaries_Cpu{i}(j).intdens)
   %cap_RAWints{i,j} = mean(capillaries_Cpu{i}(j).RAW_intdens)

end;
end;

%Ligning up diferent section columns per subject lines (subtantia nigra)
for i= 1:subject_n_SN
    n_sections_SN = numel(dend_SN{i});
for j = 1:n_sections_SN
   sn_soma_numbers{i,j} = numel(somata_SN{i}(j).number)
   sn_soma_areas{i,j} = mean(somata_SN{i}(j).area)
   
   sn_dend_means{i,j} = mean(dendrites_SN{i}(j).mean)
   sn_dend_modes{i,j} = mean(dendrites_SN{i}(j).mode)
   sn_dend_ints{i,j} = mean(dendrites_SN{i}(j).intdens)
   sn_dend_medians{i,j} = mean(dendrites_SN{i}(j).median)
   sn_dend_areafracs{i,j} = mean(dendrites_SN{i}(j).area_fract)
   sn_dend_RAWints{i,j} = mean(dendrites_SN{i}(j).RAW_intdens)
end;
end;

%Ligning up diferent section columns per subject lines (VTA)
for i= 1:subject_n_VTA
    n_sections_VTA = numel(dend_VTA{i});
for j = 1:n_sections_VTA
   vta_soma_numbers{i,j} = numel(somata_VTA{i}(j).number)
   vta_soma_areas{i,j} = mean(somata_VTA{i}(j).area)
   
   vta_dend_means{i,j} = mean(dendrites_VTA{i}(j).mean)
   vta_dend_modes{i,j} = mean(dendrites_VTA{i}(j).mode)
   vta_dend_ints{i,j} = mean(dendrites_VTA{i}(j).intdens)
   vta_dend_medians{i,j} = mean(dendrites_VTA{i}(j).median)
   vta_dend_areafracs{i,j} = mean(dendrites_VTA{i}(j).area_fract)
   vta_dend_RAWints{i,j} = mean(dendrites_VTA{i}(j).RAW_intdens)
end;
end;

%Ligning up diferent section columns per subject lines (globus pallidus)
for i= 1:subject_n_GP
    n_sections_GP = 1;
for j = 1:n_sections_GP
   A_GP_dend_means{i,j} = mean(dendrites_GP{i}(j).mean)
   A_GP_dend_modes{i,j} = mean(dendrites_GP{i}(j).mode)
   A_GP_dend_ints{i,j} = mean(dendrites_GP{i}(j).intdens)
   A_GP_dend_medians{i,j} = mean(dendrites_GP{i}(j).median)
   A_GP_dend_areafracs{i,j} = mean(dendrites_GP{i}(j).area_fract)
   A_GP_dend_RAWints{i,j} = mean(dendrites_GP{i}(j).RAW_intdens)
   
   %A_GP_cap_numbers{i,j} = numel(capillaries_GP{i}(j).number)
   %A_GP_cap_areas{i,j} = mean(capillaries_GP{i}(j).area)
   %A_GP_cap_intdens{i,j} = mean(capillaries_GP{i}(j).intdens)
   %A_GP_cap_RAWints{i,j} = mean(capillaries_GP{i}(j).RAW_intdens)
end;
end;

%Ligning up diferent section columns per subject lines (habenula)
for i= 1:subject_n_Hab
    n_sections_Hab = 1;
for j = 1:n_sections_Hab
   A_Hab_dend_mean{i,j} = mean(dendrites_Hab{i}(j).mean)
   A_Hab_dend_mode{i,j} = mean(dendrites_Hab{i}(j).mode)
   A_Hab_dend_int{i,j} = mean(dendrites_Hab{i}(j).intdens)
   A_Hab_dend_median{i,j} = mean(dendrites_Hab{i}(j).median)
   A_Hab_dend_areafrac{i,j} = mean(dendrites_Hab{i}(j).area_fract)
   A_Hab_dend_RAWint{i,j} = mean(dendrites_Hab{i}(j).RAW_intdens)
end;
end;


   

%TOTALS PER SUBJECT (all sections merged)

%Subjects ID codes in a column
ID=subject_id'

%in caudate putamen
for i= 1:subject_n
    %Total number of white bodies per subject (all sections merged)
    A_CPu_WB_number{i,:}=nanmean(cellfun(@nanmean,wb_numbers(i,:)))
    %Average area of wb per subject (all sections merged)
    A_CPu_WB_mean_area{i,:} = nanmean(cellfun(@nanmean,wb_areas(i,:)))
    %Average Integrated Density of wb per subject (all sections merged)
    A_CPu_WB_mean_IntDens{i,:} = nanmean(cellfun(@nanmean,wb_intdens(i,:)))
    
    %Average means of dendrite gray values per subject (all sections merged)
    A_CPu_dend_mean_value{i,:} = nanmean(cellfun(@nanmean,dend_means(i,:)))
    %Average modes of dendrite gray values per subject (all sections merged)
    A_CPu_dend_mode_value{i,:} = nanmean(cellfun(@nanmean,dend_modes(i,:)))
    %Average intdens of dendrite gray values per subject (all sections merged)
    A_CPu_dend_intdens_value{i,:} = nanmean(cellfun(@nanmean,dend_ints(i,:)))
    %Average medians of dendrite gray values per subject (all sections merged)
    A_CPu_dend_median_value{i,:} = nanmean(cellfun(@nanmean,dend_medians(i,:)))
    %Average area fractions of dendrite gray values per subject (all sections merged)
    A_CPu_dend_area_fract_value{i,:} = nanmean(cellfun(@nanmean,dend_areafracs(i,:)))
    %Average RAW int dens of dendrite gray values per subject (all sections merged)
    A_CPu_dend_RAW_intdens_value{i,:} = nanmean(cellfun(@nanmean,dend_RAWints(i,:)))
    
    %Total number of capillaries per subject (all sections merged)
    %A_CPu_cap_number{i,:}=nanmean(cellfun(@nanmean,cap_numbers(i,:)))
    %Average area of capillaries per subject (all sections merged)
    %A_CPu_cap_mean_area{i,:} = nanmean(cellfun(@nanmean,cap_areas(i,:)))
    %Average Integrated Density of capillaries per subject (all sections merged)
    %A_CPu_cap_mean_IntDens{i,:} = nanmean(cellfun(@nanmean,cap_intdens(i,:)))
    %Average RAW Integrated Density of capillaries per subject (all sections merged)
    %A_CPu_cap_RAW_intdens_value{i,:} = nanmean(cellfun(@nanmean,cap_RAWints(i,:)))
end;
 
%in subtantia nigra
for i= 1:subject_n_SN
    %Total number of somata per subject (all sections merged)
    A_SN_somata_number{i,:}=nanmean(cellfun(@nanmean,sn_soma_numbers(i,:)))
    %Average area of wb per subject (all sections merged)
    A_SN_somata_mean_area{i,:} = nanmean(cellfun(@nanmean,sn_soma_areas(i,:)))
    
    %Average means of dendrite gray values per subject (all sections merged)
    A_SN_dend_mean_value{i,:} = nanmean(cellfun(@nanmean,sn_dend_means(i,:)))
    %Average modes of dendrite gray values per subject (all sections merged)
    A_SN_dend_mode_value{i,:} = nanmean(cellfun(@nanmean,sn_dend_modes(i,:)))
    %Average intdens of dendrite gray values per subject (all sections merged)
    A_SN_dend_intdens_value{i,:} = nanmean(cellfun(@nanmean,sn_dend_ints(i,:)))
    %Average medians of dendrite gray values per subject (all sections merged)
    A_SN_dend_median_value{i,:} = nanmean(cellfun(@nanmean,sn_dend_medians(i,:)))
    %Average area fractions of dendrite gray values per subject (all sections merged)
    A_SN_dend_area_fract_value{i,:} = nanmean(cellfun(@nanmean,sn_dend_areafracs(i,:)))
    %Average RAW int dens of dendrite gray values per subject (all sections merged)
    A_SN_dend_RAW_intdens_value{i,:} = nanmean(cellfun(@nanmean,sn_dend_RAWints(i,:)))
end;

%in VTA
for i= 1:subject_n_VTA
    %Total number of somata per subject (all sections merged)
    A_VTA_somata_number{i,:}=nanmean(cellfun(@nanmean,vta_soma_numbers(i,:)))
    %Average area of wb per subject (all sections merged)
    A_VTA_somata_mean_area{i,:} = nanmean(cellfun(@nanmean,vta_soma_areas(i,:)))
    
    %Average means of dendrite gray values per subject (all sections merged)
    A_VTA_dend_mean_value{i,:} = nanmean(cellfun(@nanmean,vta_dend_means(i,:)))
    %Average modes of dendrite gray values per subject (all sections merged)
    A_VTA_dend_mode_value{i,:} = nanmean(cellfun(@nanmean,vta_dend_modes(i,:)))
    %Average intdens of dendrite gray values per subject (all sections merged)
    A_VTA_dend_intdens_value{i,:} = nanmean(cellfun(@nanmean,vta_dend_ints(i,:)))
    %Average medians of dendrite gray values per subject (all sections merged)
    A_VTA_dend_median_value{i,:} = nanmean(cellfun(@nanmean,vta_dend_medians(i,:)))
    %Average area fractions of dendrite gray values per subject (all sections merged)
    A_VTA_dend_area_fract_value{i,:} = nanmean(cellfun(@nanmean,vta_dend_areafracs(i,:)))
    %Average RAW int dens of dendrite gray values per subject (all sections merged)
    A_VTA_dend_RAW_intdens_value{i,:} = nanmean(cellfun(@nanmean,vta_dend_RAWints(i,:)))
end;


%WRITING FINAL TABLE
nn = numel(ID);
for x= 1:nn
   %Write a line to a table with the data of this subject
tabela (x,:)= [ID(x), A_CPu_WB_number(x), A_CPu_WB_mean_area(x), A_CPu_WB_mean_IntDens(x), A_CPu_dend_mean_value(x), A_CPu_dend_mode_value(x), A_CPu_dend_intdens_value(x), A_CPu_dend_RAW_intdens_value(x), A_CPu_dend_median_value(x), A_CPu_dend_area_fract_value(x), A_GP_dend_means(x), A_GP_dend_modes(x), A_GP_dend_ints(x), A_GP_dend_RAWints(x), A_GP_dend_medians(x), A_GP_dend_areafracs(x), A_SN_somata_number(x), A_SN_somata_mean_area(x), A_SN_dend_mean_value(x), A_SN_dend_mode_value(x), A_SN_dend_intdens_value(x), A_SN_dend_RAW_intdens_value(x), A_SN_dend_median_value(x), A_SN_dend_area_fract_value(x)]
end;

%because hab has less subjects...
y=0
for zi=1:28    
        if zi==19
            tb(zi,:)=[{nan},{nan},{nan},{nan},{nan},{nan}]
        else
    y=y+1    
    tb(zi,:)= [A_Hab_dend_mean(y),A_Hab_dend_mode(y),A_Hab_dend_int(y),A_Hab_dend_RAWint(y),A_Hab_dend_median(y),A_Hab_dend_areafrac(y)]    
        end 
end
%rearranging Habenula variables, in order to be usable by stats.m
   A_Hab_dend_mean = tb(:,1)
   A_Hab_dend_mode = tb(:,2)
   A_Hab_dend_int = tb(:,3)
   A_Hab_dend_median = tb(:,5)
   A_Hab_dend_areafrac = tb(:,6)
   A_Hab_dend_RAWint = tb(:,4)

 

%Create header for table
raw = {'ID' 'CP_WB_#' 'CP_WB_mean_area' 'CP_WB_mean_IntDens' 'CP_DEND_mean' 'CP_DEND_mode' 'CP_DEND_mean_IntDens' 'CP_DEND_RAWIntDens' 'CP_DEND_median' 'CP_DEND_area_fraction' 'GP_DEND_mean' 'GP_DEND_mode' 'GP_DEND_mean_IntDens' 'GP_DEND_RAWIntDens' 'GP_DEND_median' 'GP_DEND_area_fraction' 'SN_somata_#' 'SN_somata_area' 'SN_DEND_mean' 'SN_DEND_mode' 'SN_DEND_mean_IntDens' 'SN_DEND_RAWIntDens' 'SN_DEND_median' 'SN_DEND_area_fraction' 'Hab_DEND_mean' 'Hab_DEND_mode' 'Hab_DEND_mean_IntDens' 'Hab_DEND_RAWIntDens' 'Hab_DEND_median' 'Hab_DEND_area_fraction'};
header = tabela %num2cell(1:numel(raw)) 
final = [raw; header,tb]


%Run function that will create a .csv file in order to be imported into
%SPSS, Excell etc.
%addpath('\\fileservices.ad.jyu.fi\homes\varufach\Desktop\tsv_files\')
%cell2csv('AFIS_final_table.csv', final,';', '', ',')


%Arranging and creating groups for later statistical analysis
%Group subjects into respective rat lines
hcr = [{[1 5 6 8 10 12 14 15 17 19 21 23 25 26 28]}]
lcr = [{[2 3 4 7 9 11 13 16 18 20 22 24 27]}]
both = [{[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28]}]

%Habenula
hcr_Hab = [{[1 5 6 8 10 12 14 15 17 21 23 25 26 28]}]
lcr_Hab = [{[2 3 4 7 9 11 13 16 18 20 22 24 27]}]
both_Hab = [{[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 20 21 22 23 24 25 26 27 28]}]


%save variables into .mat file
save('afis_oldrats_vars')




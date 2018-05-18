subject_VTA_files=dir ('S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\VTA*.tsv')


subject_n_VTA=numel (subject_VTA_files)


for jjjjj=1:subject_n_VTA
   subject_id_VTA{jjjjj}=subject_VTA_files(jjjjj).name (5:7);  
end;


for jjjjj=1:subject_n_VTA
    dend_VTA {jjjjj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\dendrites\' 'VTA_' subject_id_VTA{jjjjj} '.tsv']);
    soma_VTA {jjjjj} = dir(['S:\sport-AFIS\2015\TH_ImageJ_OLD_RATS_results\VTA\somata\' 'VTA_' subject_id_VTA{jjjjj} '.tsv']);
end;


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

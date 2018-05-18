clear



%Identifying subject files for counting purposes
subject_Cpu_files=dir ('S:\sport-AFIS\2015\ImageJ_DAT_results\dendrites\*Cpu1_*.tsv')

%Count the number of subjects
subject_n=numel(subject_Cpu_files)


%Give IDs to the respective subjects
for j=1:subject_n
    subject_id{j}=subject_Cpu_files(j).name (1:3);
end;

%Atribute different subjects their respective files for each anatomical part 
for j=1:subject_n
    wb_Cpu_{j} = dir(['S:\sport-AFIS\2015\ImageJ_DAT_results\whitebodies\' subject_id{j} '*Cpu*.tsv']);
    dend_Cpu {j} = dir(['S:\sport-AFIS\2015\ImageJ_DAT_results\dendrites\' subject_id{j} '*Cpu*.tsv']);
end


%Read data from inside the files

%White bodies...
for i= 1:subject_n
    n_sections = numel(wb_Cpu_{i});
for j = 1:n_sections
   white_bodies_Cpu{i}(j).number = dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\whitebodies\' wb_Cpu_{i}(j).name], '', 'A1..A:')
   white_bodies_Cpu{i}(j).area = dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\whitebodies\' wb_Cpu_{i}(j).name], '', 'B1..B:')
   white_bodies_Cpu{i}(j).intdens = dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\whitebodies\' wb_Cpu_{i}(j).name], '', 'C1..C:')
   
   %Dendrites...
   % in caudate putamen
   %'abs(x-255)' inverts dendrite gray values for easier interpretation and comparison with already
   %inverted VTA and SN
   dendrites_Cpu{i}(j).mean = abs(dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\dendrites\' dend_Cpu{i}(j).name], '', 'B1..B:')-255);
   dendrites_Cpu{i}(j).mode = abs(dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\dendrites\' dend_Cpu{i}(j).name], '', 'C1..C:')-255);
   dendrites_Cpu{i}(j).intdens = abs(dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\dendrites\' dend_Cpu{i}(j).name], '', 'F1..F:')-255);
   dendrites_Cpu{i}(j).median = abs(dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\dendrites\' dend_Cpu{i}(j).name], '', 'G1..G:')-255);
   dendrites_Cpu{i}(j).area_fract = dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\dendrites\' dend_Cpu{i}(j).name], '', 'H1..H:');
   dendrites_Cpu{i}(j).RAW_intdens = abs(dlmread(['S:\sport-AFIS\2015\ImageJ_DAT_results\dendrites\' dend_Cpu{i}(j).name], '', 'I1..I:')-255);
end;
end


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
end
end

   

%TOTALS PER SUBJECT (all sections merged)

%Subjects ID codes in a column
ID=subject_id';

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
end;
 

%WRITING FINAL TABLE

nn = numel(ID);
for x= 1:nn
   %Write a line to a table with the data of this subject
tabela (x,:)= [ID(x), A_CPu_WB_number(x), A_CPu_WB_mean_area(x), A_CPu_WB_mean_IntDens(x), A_CPu_dend_mean_value(x), A_CPu_dend_mode_value(x), A_CPu_dend_intdens_value(x), A_CPu_dend_RAW_intdens_value(x), A_CPu_dend_median_value(x), A_CPu_dend_area_fract_value(x)] 
end;

%because hab has less subjects...

%UNDER CONSTRUCTION... 

    %for z=1:34
        %tb(z,:)= [A_Hab_dend_mean(z),A_Hab_dend_mode(z),A_Hab_dend_int(z),A_Hab_dend_RAWint(z),A_Hab_dend_median(z),A_Hab_dend_areafrac(z)]
    %end
 


%for zi= [27 31]
       % tb(zi,:)=[{nan},{nan},{nan},{nan},{nan},{nan}]
%end

%for z = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 28 29 30 32 33 34 35 36]
    %tb(z,:)= [A_Hab_dend_mean(z),A_Hab_dend_mode(z),A_Hab_dend_int(z),A_Hab_dend_RAWint(z),A_Hab_dend_median(z),A_Hab_dend_areafrac(z)]
%end
        
      


    %for zi=1:36
     %   if zi==13 || zi==16
      %      tb(zi,:)=[{nan},{nan},{nan},{nan},{nan},{nan},{nan},{nan},{nan},{nan}]
       % else
        %    tb(zi,:)= [ID(zi), A_CPu_WB_number(zi), A_CPu_WB_mean_area(zi), A_CPu_WB_mean_IntDens(zi), A_CPu_dend_mean_value(zi), A_CPu_dend_mode_value(zi), A_CPu_dend_intdens_value(zi), A_CPu_dend_RAW_intdens_value(zi), A_CPu_dend_median_value(zi), A_CPu_dend_area_fract_value(zi)] 
        %end;
   % end
   

%Create header for table
raw = {'ID' 'CP_WB_#' 'CP_WB_mean_area' 'CP_WB_mean_IntDens' 'CP_DEND_mean' 'CP_DEND_mode' 'CP_DEND_mean_IntDens' 'CP_DEND_RAWIntDens' 'CP_DEND_median' 'CP_DEND_area_fraction'};
header = tabela %num2cell(1:numel(raw)) 
final = [raw; header]


%Run function that will create a .csv file in order to be imported into
%SPSS, Excell etc.
%addpath('\\fileservices.ad.jyu.fi\homes\varufach\Desktop\tsv_files\')
%cell2csv('AFIS_final_table.csv', final,';', '', ',')


%Arranging and creating groups for later statistical analysis
%Group subjects into respective rat lines
hcr = [{[1 2 6 9 11 12 15 18 19 25 26 28 29 31 35 36]}]
lcr = [{[3 4 5 7 8 10 14 17 20 21 22 23 24 27 30 32 33 34]}]
both = [{[1 2 3 4 5 6 7 8 9 10 11 12 14 15 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36]}]

%save variables into .mat file
save('afis_vars')




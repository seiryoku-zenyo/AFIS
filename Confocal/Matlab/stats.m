%function [np,bp,F,h,p] = stats(study, var)
function [np,bp,F,h,p,v]= stats(anatom, mark, vari, groups, subvari, test)

%specific variable (subvari) defines the fourth part of the variable (var)
%string. Either within the fors and ifs starting around line 60, or in case of triple colocalization variables (3_coloc) within the following block 
switch subvari
    case{'D1_DOUBLE_COLOC_percentage','D2_DOUBLE_COLOC_percentage','Darpp_DOUBLE_COLOC_percentage'}
        varble='CP_3_coloc';
    otherwise

%brain part (anatom) defines the first part of the variable (var) string
switch anatom
    case {'CP'}
        varble= 'CP';
    otherwise
        varble= 'SN';
end

%marker (mark) defines the second part of the variable (var) string
switch mark
    case{'D1'};
        varble=strcat(varble,'_D1');
    case{'D2'};
        varble=strcat(varble,'_D2');
    case{'DARPP'};
        varble=strcat(varble,'_Darpp');
end

%variable group (vari) defines the third part of the variable (var) string
switch vari
    case{'somata'}
        varble=strcat(varble,'_somata');
        vari='somata';
    case{'axon_sgn'}
        varble=strcat(varble,'_axon_signal');
        vari='axons';
    case{'coloc'}
        varble=strcat(varble,'_coloc');
        vari='somata';
end
end%from subvari
img_lgnd=varble;%for making appropriate legend to later figure

 set(0,'Units', 'pixels');
%calling variable and group codes from workspace            
if evalin( 'base', 'exist(''v'',''var'') == 0' )&& evalin( 'base', 'exist(''CP_3_coloc'',''var'') == 0' )
        h = waitbar(0,'Loading variables...')
        waitbar(1/2)
        mb=msgbox('Please wait a couple of minutes, just for this first time. It´s always harder for the first time they say.. You might think that the green bar is not moving, but you know, it doesn´t really matter... In fact, the bar is not moving because I didn´t have patience to make it move. Anyways, the point is to keep you entertained while the variables are being loaded. I hope this message had the same effect as the green bar, I hope you are entertained.');        
        v=load('variables.mat');
        assignin('base', 'v', v);
        close(h);
            %Confirm that variable exists, if not, produce message box informing such
                x=evalin('base', 'v')
                if strcmp('SN_Darpp_somata', varble)|| strcmp('SN_Darpp_coloc', varble)
                    msgbox(['The variable ' varble ' does not exist. Apparently, unlike in Caudate Putamen, Darpp does not stain somata in Substantia Nigra. Please select a variable that exists. In the future, if you wish, we can try to genetically modify these rats to express Darpp positive somata...']);
                elseif isfield (x.(varble){1}, (subvari))==0
                    msgbox(['The specific variable ´' subvari '´ does not exist within the variable type ´' varble '´. Use the color map to match valid specific variables with their variable type. If you are color blind, sorry about that, it could be worse, you could be a subject for this study. In case you have the correct color combination, the issue is most likely related to the fact of Substantia Nigra not having Darpp positive cells, if your "Darpp axon signal mean" has the "somata" word in it, you will see this message. Conversely if you are in Caudate Putamen, your "Drapp axon signal" should be checked with "somata information" (with or without).']);
                end
                  
   varble=evalin('base', ['v.' (varble)]);
   ylcr=evalin('base', 'v.ylcr');
   yhcr=evalin('base', 'v.yhcr');
   olcr=evalin('base', 'v.olcr');
   ohcr=evalin('base', 'v.ohcr');
            
          
elseif evalin( 'base', 'exist(''v'',''var'') == 1' )
                %Confirm that variable exists, if not, produce message box informing such
                x=evalin('base', 'v')
                if strcmp('SN_Darpp_somata', varble)|| strcmp('SN_Darpp_coloc', varble)
                    msgbox(['The variable ' varble ' does not exist. Apparently, unlike in Caudate Putamen, Darpp does not stain somata in Substantia Nigra. Please select a variable that exists. In the future, if you wish, we can try to genetically modify these rats to express Darpp positive somata...']);
                elseif isfield (x.(varble){1}, (subvari))==0
                    msgbox(['The specific variable ´' subvari '´ does not exist within the variable type ´' varble '´. Use the color map to match valid specific variables with their variable type. If you are color blind, sorry about that, it could be worse, you could be a subject for this study.']);
                end
        varble=evalin('base', ['v.' varble]);
        ylcr=evalin('base', 'v.ylcr');
        yhcr=evalin('base', 'v.yhcr');
        olcr=evalin('base', 'v.olcr');
        ohcr=evalin('base', 'v.ohcr');
                
else
                %Confirm that variable exists, if not, produce message box informing such
                x=evalin('base', 'v')
                if strcmp('SN_Darpp_somata', varble)|| strcmp('SN_Darpp_coloc', varble)
                    msgbox(['The variable ' varble ' does not exist. Apparently, unlike in Caudate Putamen, Darpp does not stain somata in Substantia Nigra. Please select a variable that exists. In the future, if you wish, we can try to genetically modify these rats to express Darpp positive somata...']);
                elseif isfield (x.(varble){1}, (subvari))==0
                    msgbox(['The specific variable ´' subvari '´ does not exist within the variable type ´' varble '´. Use the color map to match valid specific variables with their variable type. If you are color blind, sorry about that, it could be worse, you could be a subject for this study.']);
                end
        varble=evalin('base', varble);
        ylcr=evalin('base', 'ylcr');
        yhcr=evalin('base', 'yhcr');
        olcr=evalin('base', 'olcr');
        ohcr=evalin('base', 'ohcr');
end


%Placing subject in respective groups and activating just group(s) selected
%in previous function
k=1;
if any(strcmp(groups,'YLCR'))
j=1;
  for ii=1:length(ylcr{1,1})    
    for i=1:length(varble)
        if     ylcr{1,1}(ii) == str2num(varble{1,i}.subject_ID_code)
       yLCR(1,j) = varble{1,i}.(subvari);
       j=j+1;
        end
    end
  end
  GRP{k,2}=yLCR;
  GRP{k,1}='yLCR';
  k=k+1;
end
if any(strcmp(groups,'YHCR'))
j=1;
  for ii=1:length(yhcr{1,1})    
    for i=1:length(varble)
        if     yhcr{1,1}(ii) == str2num(varble{1,i}.subject_ID_code)
       yHCR(1,j) = varble{1,i}.(subvari);
       j=j+1;
        end
    end
  end
  GRP{k,2}=yHCR;
  GRP{k,1}='yHCR';
  k=k+1;  
end
if any(strcmp(groups,'OLCR'))
j=1;
  for ii=1:length(olcr{1,1})    
    for i=1:length(varble)
        if     olcr{1,1}(ii) == str2num(varble{1,i}.subject_ID_code)
       oLCR(1,j) = varble{1,i}.(subvari);
       j=j+1;
        end
    end
  end
  GRP{k,2}=oLCR;
  GRP{k,1}='oLCR';
  k=k+1;  
end
if any(strcmp(groups,'OHCR'))
j=1;
  for ii=1:length(ohcr{1,1})    
    for i=1:length(varble)
        if     ohcr{1,1}(ii) == str2num(varble{1,i}.subject_ID_code)
       oHCR(1,j) = varble{1,i}.(subvari);
       j=j+1;
        end
    end
  end
  GRP{k,2}=oHCR;
  GRP{k,1}='oHCR';
  k=k+1;
end
j=1;

switch test
    case {'distrib'}
        data=horzcat(GRP{:,2})
        %Show distribution and normality graphs and statistical test results
set(0, 'DefaultFigurePosition', [500         200         280         210])
figure('NumberTitle', 'off','name','Histogram (red is your data, green is gaussian)');
hold on;
hist=histfit(data,length(data),'kernel'); set(hist(1)','facecolor','b')
set(0, 'DefaultFigurePosition', [500         200         280         210])
hold on
hist1=histfit(data,length(data),'normal')
delete(hist1(1)); set(hist1(2),'color','g'); set(hist(2),'color','r');
hold off
h_leg=legend ([hist1(2) hist(2)],'gaussian', 'your data','FontSize',5,'Location','best');
h_leg=legend ('boxoff');
set(h_leg,'FontSize',7);

%F = findobj(3,'type','line');
%copyobj(F,findobj(4,'type','axes'));
%hold off
%close all
set(0, 'DefaultFigurePosition', [150         200         280         210])
figure('NumberTitle', 'off','name','Normality plot');
hold on;
normplot(data)
%hold off;
set(0, 'DefaultFigurePosition', [850         200         280         210])
figure('NumberTitle', 'off','name','Box plot');
%hold on;
boxplot(data)
%hold off;

    [h,p] = lillietest (data)
    s=num2str(p);
%Give distribution statistic results for normality assessment. Choose how to proceed.
if p>0.05
    msgbox(['Distribution can be considered NORMAL. Lilliefors test returned p=' s '. Vasco recommends continuing the analysis using PARAMETRIC tests.']);
elseif p<=0.05 && p>=0.01
    msgbox(['Lilliefors test returned a P-Value of ' s '. This means you should consider carefully not using PARAMETRIC tests, you should probably use NON-PARAMETRIC. Check your graphs before making a decison.']);              
elseif p<0.01
    msgbox(['Your P-Value is waaaaay low(p=' s '). This is NOT a normal distribution. You should definitely go for NON-PARAMETRIC tests!']);                        
else
    questdlg('How would you like to proceed?','proceeding with statistics','Choose test','Transform data','Select group data','Select group data');
end;


    case {'2ttest'}
        [h,p] = ttest2(GRP{1,2},GRP{2,2})
    ttest_mannW_graph (GRP, img_lgnd, vari, mark);
    
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'normal';

        
    if p<0.005 
        msgbox({['WOW! P-Value of ' num2str(p) '!   VERY SIGNIFICANT! Nobel prize?'];'';''; ['\bf' GRP{1,1} '\rm' '  \itmean=' num2str(mean(GRP{1,2})) '; SD=' num2str(std(GRP{1,2})) '\rm'] ; ['\bf' GRP{2,1} '\rm' '  \itmean=' num2str(mean(GRP{2,2})) '; SD=' num2str(std(GRP{2,2})) '\rm']}, test, 'none', Opt);                             
    elseif p<0.05
        msgbox({['P-Value of ' num2str(p) '!   Probably SIGNIFICANT!'];'';''; ['\bf' GRP{1,1} '\rm' '  \itmean=' num2str(mean(GRP{1,2})) '; SD=' num2str(std(GRP{1,2})) '\rm'] ; ['\bf' GRP{2,1} '\rm' '  \itmean=' num2str(mean(GRP{2,2})) '; SD=' num2str(std(GRP{2,2})) '\rm']}, test, 'none', Opt);
    else
        msgbox({['P-Value of ' num2str(p) '!   Looks like no differences :('];'';''; ['\bf' GRP{1,1} '\rm' '  \itmean=' num2str(mean(GRP{1,2})) '; SD=' num2str(std(GRP{1,2})) '\rm'] ; ['\bf' GRP{2,1} '\rm' '  \itmean=' num2str(mean(GRP{2,2})) '; SD=' num2str(std(GRP{2,2})) '\rm']}, test, 'none', Opt);          
    end;
    
    %Showing variable mean values in message box:
    
    
    case {'mannu'}
        %Mann-Whitney
    [p,h] = ranksum(GRP{1,2},GRP{2,2})
    ttest_mannW_graph (GRP,img_lgnd, vari, mark);
    
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'normal';

        
    if p<0.005 
        msgbox({['WOW! P-Value of ' num2str(p) '!   VERY SIGNIFICANT! Nobel prize?'];'';''; ['\bf' GRP{1,1} '\rm' '  \itmean=' num2str(mean(GRP{1,2})) '; SD=' num2str(std(GRP{1,2})) '\rm'] ; ['\bf' GRP{2,1} '\rm' '  \itmean=' num2str(mean(GRP{2,2})) '; SD=' num2str(std(GRP{2,2})) '\rm']}, test, 'none', Opt);                             
    elseif p<0.05
        msgbox({['P-Value of ' num2str(p) '!   Probably SIGNIFICANT!'];'';''; ['\bf' GRP{1,1} '\rm' '  \itmean=' num2str(mean(GRP{1,2})) '; SD=' num2str(std(GRP{1,2})) '\rm'] ; ['\bf' GRP{2,1} '\rm' '  \itmean=' num2str(mean(GRP{2,2})) '; SD=' num2str(std(GRP{2,2})) '\rm']}, test, 'none', Opt);
    else
        msgbox({['P-Value of ' num2str(p) '!   Looks like no differences :('];'';''; ['\bf' GRP{1,1} '\rm' '  \itmean=' num2str(mean(GRP{1,2})) '; SD=' num2str(std(GRP{1,2})) '\rm'] ; ['\bf' GRP{2,1} '\rm' '  \itmean=' num2str(mean(GRP{2,2})) '; SD=' num2str(std(GRP{2,2})) '\rm']}, test, 'none', Opt);          
    end;


    case {'1anova'}
        %One-Way ANOVA
        ANOVA.data=horzcat(GRP{:,2});
j=0;
for i=1:length(GRP); 
    for ii=1:length(GRP{i,2});
        ii=ii+j;
        ANOVA.label{1,ii}=GRP{i,1};
    end
    j=ii;
end
set (0, 'DefaultUIControlFontSize', 9, 'DefaultFigurePosition', [700         400        400         210]);
[p,tbl,stats] =anova1(ANOVA.data,ANOVA.label);   
    
    % Create button to open image.
                  set (0, 'DefaultUIControlFontSize', 9);
img_button = uicontrol('Style','pushbutton',...
                  'String','Image',...
                  'Units', 'normalized',...
                  'FontSize', 8, 'FontAngle', 'italic',...
                  'Position',[.8 .93 .15 .075],...
                  'Tag', 'Image',...
                  'BackgroundColor',[.85 .85 .85],...
                  'HandleVisibility','off',...
                  'Callback', @open_image);
                  
    if p<0.005
        msgbox(['WOW! P-Value of ' num2str(p) '! VERY SIGNIFICANT! Nobel prize?']);                                 
    elseif p<0.05
        msgbox(['P-Value of ' num2str(p) '! Probably SIGNIFICANT!']);                                
    else
        msgbox(['P-Value of ' num2str(p) '! Looks like no differences :(']);                           
    end;    
   
    
    
    
    

case {'kruskal'}
        %Kruskal-Wallis test
        KRUSKAL.data=horzcat(GRP{:,2});
j=0;
for i=1:length(GRP);
    for ii=1:length(GRP{i,2});
        ii=ii+j;
        KRUSKAL.label{1,ii}=GRP{i,1};
    end
    j=ii;
end
set (0, 'DefaultUIControlFontSize', 9, 'DefaultFigurePosition', [700         400        400         210]);
[p,tbl,stats] = kruskalwallis(KRUSKAL.data,KRUSKAL.label);

    % Create button to open image.
                  set (0, 'DefaultUIControlFontSize', 9);
img_button = uicontrol('Style','pushbutton',...
                  'String','Image',...
                  'Units', 'normalized',...
                  'FontSize', 8, 'FontAngle', 'italic',...
                  'Position',[.8 .93 .15 .075],...
                  'Tag', 'Image',...
                  'BackgroundColor',[.85 .85 .85],...
                  'HandleVisibility','off',...
                  'Callback', @open_image);

    if p<0.005
        msgbox(['WOW! P-Value of ' num2str(p) '! VERY SIGNIFICANT! Nobel prize?']);                                 
    elseif p<0.05
        msgbox(['P-Value of ' num2str(p) '! Probably SIGNIFICANT!']);                                
    else
        msgbox(['P-Value of ' num2str(p) '! Looks like no differences :(']);                           
    end; 
end



function open_image (varargin) 
folder= (['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\' (img_lgnd(1:2)) '\']);


switch vari
        case {'somata'};
            A=dir([(folder) 'All_groups_D2somata_D1somata_Darpp.tif']);
        case {'axons'};
            A=dir([(folder) 'All_groups_D2axons_D1axons_Darpp*']);
    otherwise
            A=dir([(folder) 'All_groups_D2somata_D1somata_Darpp.tif']);
end


A_img=imread ([folder (A.name)]);%Read identified image file

%Split RGB accordingly to marker/channel
red = A_img(:,:,1); % Red channel
green = A_img(:,:,2); % Green channel
blue = A_img(:,:,3); % Blue channel
z = zeros(size(A_img, 1), size(A_img, 2));
D2 = cat(3, red, z, z);
D1 = cat(3, z, green, z);
Darpp = cat(3, z, z, blue);

switch img_lgnd(4:5)
    case {'D1'};
        img=D1;
    case {'D2'};
        img=D2;
    case {'Da'};
        img=Darpp;
    otherwise
        img=A_img;
end

set(0, 'DefaultFigurePosition', [1200         290        280         210]);
img_fig= figure('NumberTitle', 'off','name', ['All Groups     -    '  (mark) ' positive ' (vari) ' in ' (img_lgnd(1:2))]);
iHand = axes('parent', img_fig);
imshow (img, [0 250]);
set(gca, 'Position', [0 0 0.8 1])
%axis equal;
set(iHand,'Visible','off');



%%%%
% Create button to open image.
                  set (0, 'DefaultUIControlFontSize', 9);
img_button = uicontrol(img_fig,'Style','pushbutton',...
                  'String','RGB',...
                  'Units', 'normalized',...
                  'FontSize', 16, 'FontAngle', 'italic',...
                  'Position',[.8 .9 .15 .1],...
                  'Tag', 'Image',...
                  'BackgroundColor',[.85 .85 .85],...
                  'HandleVisibility','off',...
                  'Callback', @open_RGB);
    
    function open_RGB (varargin)
    set(0, 'DefaultFigurePosition', [1150         290        280         210]);
img_fig_rgb= figure('NumberTitle', 'off', 'name', ['All Groups ' '            RGB - ' (A.name(14:length(A.name)-4)) ' in ' (img_lgnd(1:2))]);
iHand = axes('parent', img_fig_rgb); 
imshow (A_img);
set(gca, 'Position', [0 0 0.8 1])
%axis image;
set(iHand,'Visible','off');
    end

end
end




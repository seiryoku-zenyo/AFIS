function [np,bp,F,h,p] = stats(study, var)

X = load([study '_vars.mat']);

%Data of the two groups for later comparisons
HCR = [var{(X.hcr{1,1}(1,:)),1}];
LCR = [var{(X.lcr{1,1}(1,:)),1}];

answer='Begining'
%%Ask data to work with for normality assessment

while strcmp('Begining',answer) 
        HCR = [var{(X.hcr{1,1}(1,:)),1}];
        LCR = [var{(X.lcr{1,1}(1,:)),1}];
        questdlg(['From which group would you like to assess normality?'],'Distribuition of data','HCR','LCR','Both', 'Both');
        answer=ans;
if strcmp('HCR',answer);
    data=[var{(X.hcr{1,1}(1,:)),1}];
elseif strcmp('LCR',answer);
    data=[var{(X.lcr{1,1}(1,:)),1}];
else strcmp('Both',answer);
    data=[var{(X.both{1,1}(1,:)),1}];
end;

%Show distribution and normality graphs and statistical test results
close all
set(0, 'DefaultFigurePosition', [1947         556         560         420])
figure('name','Normality plot');
hold on;
normplot(data)
set(0, 'DefaultFigurePosition', [2534         556         560         420])
figure('name','Box plot');
hold on;
boxplot(data)
figure;
hold on;
hist=histfit(data,10,'kernel')
set(0, 'DefaultFigurePosition', [3138         556         560         420])
figure('name','Histogram with normal (green) & data (red) curves');
hold on
hist1=histfit(data,10,'normal')
set(hist1(1),'facecolor','b'); set(hist1(2),'color','g')
F = findobj(3,'type','line');
copyobj(F,findobj(4,'type','axes'));

close figure 3
answer='Back';
while strcmp('Back',answer) || strcmp('Try other Transformations',answer);
    [h,p] = lillietest (data)
    s=num2str(p);
%Give distribution statistic results for normality assessment. Choose how to proceed.
if p>0.05
    questdlg(['Distribution can be considered NORMAL. Lilliefors test returned p=' s '. Vasco recommends continuing the analysis using PARAMETRIC tests.          How would you like to proceed?'],'proceeding with statistics','Choose test','Transform data','Select group data','Select group data');  
elseif p<=0.05 && p>=0.01
    questdlg(['Lilliefors test returned a P-Value of ' s '. This means you should consider carefully not using PARAMETRIC tests, you should probably use NON-PARAMETRIC. Check your graphs before making a decison.              How would you like to proceed?'],'proceeding with statistics','Choose test','Transform data','Select group data','Select group data');
elseif p<0.01
    questdlg(['Your P-Value is waaaaay low(p=' s '). This is NOT a normal distribution. You should definitely go for NON-PARAMETRIC tests!                        How would you like to proceed?'],'proceeding with statistics','Choose test','Transform data','Select group data','Select group data');
else
    questdlg('How would you like to proceed?','proceeding with statistics','Choose test','Transform data','Select group data','Select group data');
end;
answer=ans
transloop=0;

%Second dialog box. Choose further statistical tests or how to transform data
while strcmp(answer,'Choose test') || strcmp(answer,'Transform data') || strcmp(answer,'Select group data');
if strcmp('Choose test',answer);
    questdlg('Which test would you like to use?','proceeding with statistics','2way t-student','Mann-Whitney test','Back','Back');
    answer=ans;
elseif strcmp(answer,'Transform data');
    questdlg('Which transformation would you like to try?','proceeding with statistics','log1','log2','square root','log1');
    answer=ans
else
    'Begining';
    answer=ans
end;

end; %end of 'Choose test' and 'Transform data' while


%%%Executing requests.
%%Transformations
%Log1
if strcmp('log1',answer);
    close all
set(0, 'DefaultFigurePosition', [1947         556         560         420])
figure('name','Normality plot');
hold on;
normplot(log(data))
set(0, 'DefaultFigurePosition', [2534         556         560         420])
figure('name','Box plot');
hold on;
boxplot(log(data))
figure;
hold on;
hist=histfit(log(data),10,'kernel')
set(0, 'DefaultFigurePosition', [3138         556         560         420])
figure('name','Histogram with normal (green) & data (red) curves');
hold on;
hist1=histfit(log(data),10,'normal')
set(hist1(1),'facecolor','b'); set(hist1(2),'color','g')
F = findobj(3,'type','line');
copyobj(F,findobj(4,'type','axes'));
close figure 3
[h,p] = lillietest (log(data))
s1=num2str(p);
questdlg(['Lilliefors test now returns P= ' s1 ' in comparison with P= ' s ' before transformation. Would you like to proceed with the analysis or try different transformations?'],'log1 transformation','Proceed with log(data) Analysis','Try other Transformations','Try other Transformations');    
answer=ans;
transloop=1
%Log10 
elseif strcmp('log2',answer);
    close all
set(0, 'DefaultFigurePosition', [1947         556         560         420])
figure('name','Normality plot');
hold on;
normplot(log2(data))
set(0, 'DefaultFigurePosition', [2534         556         560         420])
figure('name','Box plot');
hold on;
boxplot(log2(data))
figure;
hold on;
hist=histfit(log2(data),10,'kernel')
set(0, 'DefaultFigurePosition', [3138         556         560         420])
figure('name','Histogram with normal (green) & data (red) curves');
hold on;
hist1=histfit(log2(data),10,'normal')
set(hist1(1),'facecolor','b'); set(hist1(2),'color','g')
F = findobj(3,'type','line');
copyobj(F,findobj(4,'type','axes'));
close figure 3
[h,p] = lillietest (log2(data))
s1=num2str(p);
questdlg(['Lilliefors test now returns P= ' s1 ' in comparison with P= ' s ' before transformation. Would you like to proceed with the analysis or try different transformations?'],'log10 transformation','Proceed with log10(data) Analysis','Try other Transformations','Try other Transformations');    
answer=ans;
transloop=1
%Square root
elseif strcmp('square root',answer);
    close all
set(0, 'DefaultFigurePosition', [1947         556         560         420])
figure('name','Normality plot');
hold on;
normplot(sqrt(data))
set(0, 'DefaultFigurePosition', [2534         556         560         420])
figure('name','Box plot');
hold on;
boxplot(sqrt(data))
figure;
hold on;
hist=histfit(sqrt(data),10,'kernel')
set(0, 'DefaultFigurePosition', [3138         556         560         420])
figure('name','Histogram with normal (green) & data (red) curves');
hold on;
hist1=histfit(sqrt(data),10,'normal')
set(hist1(1),'facecolor','b'); set(hist1(2),'color','g')
F = findobj(3,'type','line');
copyobj(F,findobj(4,'type','axes'));
close figure 3
[h,p] = lillietest (sqrt(data))
s1=num2str(p);
questdlg(['Lilliefors test now returns P= ' s1 ' in comparison with P= ' s ' before transformation. Would you like to proceed with the analysis or try different transformations?'],'square root transformation','Proceed with sqrt(data) Analysis','Try other Transformations','Try other Transformations');    
answer=ans;
transloop=1
end;

while transloop==1
    if strcmp('Proceed with log(data) Analysis',answer);
        HCR = log(HCR);
        LCR = log(LCR);
        questdlg('Which test would you like to use?','WARNING: log1 transformed data','2way t-student','Mann-Whitney test','Back','Back');
        answer=ans;
    elseif strcmp('Proceed with log2(data) Analysis',answer);
        HCR = log2(HCR);
        LCR = log2(LCR);
        questdlg('Which test would you like to use?','WARNING: log2 transformed data','2way t-student','Mann-Whitney test','Back','Back');
        answer=ans;
    elseif strcmp('Proceed with sqrt(data) Analysis',answer);
        HCR = sqrt(HCR);
        LCR = sqrt(LCR);
        questdlg('Which test would you like to use?','WARNING: square root transformed data','2way t-student','Mann-Whitney test','Back','Back');
        answer=ans;  
    elseif strcmp('Try other Transformations',answer);
        HCR = [var{(X.hcr{1,1}(1,:)),1}];
        LCR = [var{(X.lcr{1,1}(1,:)),1}];
        'Try other Transformations';
        answer=ans
    end;
    transloop=0
end;   %end of 'Proceed with log data' while 

%%Statistical tests
%2way t-student
if strcmp('2way t-student',answer);
    [h,p] = ttest2(HCR,LCR)
    binary_auto_bar_graph (HCR, LCR);
    if p<0.005 
        questdlg(['WOW! P-Value of ' num2str(p) '!   VERY SIGNIFICANT!                               Would you like to try different tests?'],'Satisfied?','Yep','Nop, I´m done','Yep');
    elseif p<0.05
        questdlg(['P-Value of ' num2str(p) '!   Probably SIGNIFICANT!                                Would you like to try different tests?'],'Satisfied?','Yep','Nop, I´m done','Yep');
    else
        questdlg(['P-Value of ' num2str(p) '!   Looks like no differences :(                         Would you like to try different tests?'],'Satisfied?','Yep','Nop, I´m done','Yep');
    end;
         
%Mann-Whitney
elseif strcmp('Mann-Whitney test',answer);
    [p,h] = ranksum(HCR,LCR)
    binary_auto_bar_graph (HCR, LCR);
    if p<0.005
        questdlg(['WOW! P-Value of ' num2str(p) '! VERY SIGNIFICANT!                                 Would you like to try different tests?'],'Satisfied?','Yep','Nop, I´m done','Yep'); 
    elseif p<0.05
        questdlg(['P-Value of ' num2str(p) '! Probably SIGNIFICANT!                                  Would you like to try different tests?'],'Satisfied?','Yep','Nop, I´m done','Yep'); 
    else
        questdlg(['P-Value of ' num2str(p) '! Looks like no differences :(                           Would you like to try different tests?'],'Satisfied?','Yep','Nop, I´m done','Yep'); 
    end;    
elseif strcmp ('Back',ans)
    HCR = [var{(X.hcr{1,1}(1,:)),1}];
    LCR = [var{(X.lcr{1,1}(1,:)),1}];
    'Back';
    answer=ans;
elseif strcmp('Begining', answer)
    'Begining'
    answer=ans
else
    'Try other Transformations'
    answer=ans
end

if strcmp('Yep',ans)
    'Choose test'
    answer=ans
elseif strcmp ('Nop, I´m done',ans)
    HCR = [var{(X.hcr{1,1}(1,:)),1}];
    LCR = [var{(X.lcr{1,1}(1,:)),1}];
    error('Done!');
end
if strcmp(answer, 'Begining');
   'Begining';
    answer=ans;
elseif strcmp(answer, 'Try other Transformations');
    'Try other Transformations'
    answer=ans;
else   
'Back';
answer=ans;
end
if strcmp ('Try other Transformations', answer)
'Try other Transformations'
    answer=ans;
else
end
if strcmp(answer,'Try other Transformations')
    'Try other Transformations'
    answer=ans;
else
'Begining'
answer=ans 
end
end %end of 'Begining' while
end

%end of 'Back' while

%end of Function





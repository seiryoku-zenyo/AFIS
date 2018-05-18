function [] = binary_auto_bar_graph (HCR, LCR)
Y = [mean(HCR) mean(LCR)];
X = Y;

h = bar(Y);

stddev=[std(HCR),std(LCR)];
error_matrix = vec2mat(stddev,2);
%Prepare variables for setting upper and lower limits on y-axis for better
%observation of differences
r = 4;
t = sum(Y);
d = abs(Y(1)-Y(2));
Hi = (max(Y) + (max(stddev)));
Lo = (Hi - (r*d));

%Build normal data graph
set(0, 'DefaultFigurePosition', [1947         556        560         420]);
fHand = figure('name','Group comparison');
aHand = axes('parent', fHand);
hold(aHand, 'on');
colors = hsv(numel(Y));
for i = 1:numel(Y)
    bar(i, Y(i), 'parent', aHand, 'facecolor', colors(i,:));
end;
set(gca, 'XTick', 1:numel(Y), 'XTickLabel', {'HCR', 'LCR'})
errorbar(Y,error_matrix,'.black');
close Figure 1

%Build the zoom graph
if Lo <= (min(Y)-stddev);
    set(0, 'DefaultFigurePosition', [2534         556         560         420]);
    zoom=figure('name','Group comparison (zoomed)');
    aHand = axes('parent', zoom);
    hold(aHand, 'on');
    colors = hsv(numel(Y));
for i = 1:numel(Y);
    bar(i, Y(i), 'parent', aHand, 'facecolor', colors(i,:));
end
ylim([Lo Hi]);
    set(gca, 'XTick', 1:numel(Y), 'XTickLabel', {'HCR', 'LCR'});
    errorbar(Y,error_matrix,'.black');
    hold on
 
else
    set(0, 'DefaultFigurePosition', [2534         556         560         420]);
    zoom=figure('name','Group comparison (zoomed)');
    aHand = axes('parent', zoom);
    hold(aHand, 'on');
    colors = hsv(numel(Y));
for i = 1:numel(Y);
    bar(i, Y(i), 'parent', aHand, 'facecolor', colors(i,:));
end
    set(gca, 'XTick', 1:numel(Y), 'XTickLabel', {'HCR', 'LCR'});
    errorbar(Y,error_matrix,'.black');
    ylim([(min(Y)-max(stddev)-1) (max(Y)+max(stddev))]);
    hold on;



%%%%%Trying to display density curves as well....for later
%figure;
%hold on;
%hist=histfit(HCR,10,'kernel')
%set(0, 'DefaultFigurePosition', [3138         556         560         420])
%figure('name','Histogram with HCR (red) & LCR (cyan) density curves');
%hold on;
%hist1=histfit(LCR,10,'kernel')
%set(hist1(1),'facecolor','red'); set(hist1(2),'color','cyan')
%F = findobj(3,'type','line');
%copyobj(F,findobj(4,'type','axes'));

end;
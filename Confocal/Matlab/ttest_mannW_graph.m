function [GRP, img_lgnd] = ttest_mannW_graph (GRP, img_lgnd, vari, mark)
Y = [mean(GRP{1,2}) mean(GRP{2,2})];
X = Y;

h = bar(Y);

stddev=[std(GRP{1,2}),std(GRP{2,2})];
error_matrix = vec2mat(stddev,2);
%Prepare variables for setting upper and lower limits on y-axis for better
%observation of differences
r = 4;
t = sum(Y);
d = abs(Y(1)-Y(2));
Hi = (max(Y) + (max(stddev)));
Lo = (Hi - (r*d));

%Build normal data graph
set(0, 'DefaultFigurePosition', [400         200        280         210]);
fHand = figure('NumberTitle', 'off','name','Group comparison');
aHand = axes('parent', fHand);
hold(aHand, 'on');
colors = hsv(numel(Y));
for i = 1:numel(Y)
    bar(i, Y(i), 'parent', aHand, 'facecolor', colors(i,:));
end;
set(gca, 'XTick', 1:numel(Y), 'XTickLabel', {(GRP{1,1}), (GRP{2,1})})
errorbar(Y,error_matrix,'.black');

%%%%
% Create button to open image.
                  set (0, 'DefaultUIControlFontSize', 9);
img_button = uicontrol(fHand,'Style','pushbutton',...
                  'String','Image',...
                  'Units', 'normalized',...
                  'FontSize', 8, 'FontAngle', 'italic',...
                  'Position',[.8 .93 .15 .075],...
                  'Tag', 'Image',...
                  'BackgroundColor',[.85 .85 .85],...
                  'HandleVisibility','off',...
                  'Callback', @open_image);
            
function open_image (varargin) 

    %Trying to identify the file
    folder= (['S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data\' (img_lgnd(1:2)) '\']);
if isempty (dir([(folder) '*' GRP{2,1} '*' GRP{1,1} '*' vari '*'])) && isempty (dir([(folder) '*' GRP{1,1} '*' GRP{2,1} '*' vari '*']));
    msgbox('Images with that group combination haven´t been prepared. Are you sure it´s relevant comparing those two groups? You can explore all images and build your own in "S:\sport-AFIS\2015\lab_work\Immunofluorescence\D1,D2 ja Darpp HCR LCR\processed_data"');
elseif isempty (dir([(folder) '*' GRP{2,1} '*' GRP{1,1} '*']));
    switch vari
        case {'somata'};
            A=dir([(folder) GRP{1,1} '_vs_' (GRP{2,1}) '_D2somata_D1somata_Darpp.tif']);
        case {'axons'};
            A=dir([(folder) GRP{1,1} '_vs_' (GRP{2,1}) '_D2axons_D1axons_Darpp*']);
    end
elseif isempty (dir([(folder) '*' GRP{1,1} '*' GRP{2,1} '*']));
    switch vari
        case {'somata'};
            A=dir([(folder) GRP{2,1} '_vs_' (GRP{1,1}) '_D2somata_D1somata_Darpp.tif']);
        case {'axons'};
            A=dir([(folder) GRP{2,1} '_vs_' (GRP{1,1}) '_D2axons_D1axons_Darpp*'])
        otherwise
            A=dir([(folder) 'All_groups_D2somata_D1somata_Darpp.tif']);
    end
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
img_fig= figure('NumberTitle', 'off','name', [(GRP{2,1}) '  vs.  ' (GRP{1,1}) '   -   ' (mark) ' positive ' (vari) ' in ' (img_lgnd(1:2))]);
iHand = axes('parent', img_fig);
imshow (img, [0 250]);
set(gca, 'Position', [0 0 0.8 1])
%axis image;
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
    set(0, 'DefaultFigurePosition', [1200         200        280         210]);
img_fig_rgb= figure('NumberTitle', 'off','name', [(GRP{2,1}) '  vs.  ' (GRP{1,1}) '            RGB - ' (A.name(14:length(A.name)-4)) ' in ' (img_lgnd(1:2))]);
iHand = axes('parent', img_fig_rgb);
imshow (A_img)
set(gca, 'Position', [0 0 0.8 1])
set(iHand,'Visible','off');    
    end

end
              
              
zoom_button = uicontrol('Parent',fHand,'Style','pushbutton',...
                  'String','zoom',...
                  'Units', 'normalized',...
                  'FontSize', 8, 'FontAngle', 'italic',...
                  'Position',[.15 .93 .15 .075],...
                  'Tag', 'zoom',...
                  'BackgroundColor',[.85 .85 .85],...
                  'HandleVisibility','off',...
                  'Callback', @zoom_graph);


  
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create button to open zoom graph.
%                  set (0, 'DefaultUIControlFontSize', 12);
%img_button = uicontrol(marker,'Style','pushbutton',...
 %                 'String','Image',...
  %                'Position',[10 130 1000 30],...
   %               'Tag', 'Image',...
    %              'BackgroundColor',[.85 .85 .85],...
     %             'HandleVisibility','off'),...
      %            'Callback', {@open_image, GRP{1,1}, (GRP{2,1});




    function zoom_graph (varargin)
%Build the zoom graph
if Lo <= (min(Y)-stddev);
    set(0, 'DefaultFigurePosition', [850         200         280         210]);
    zoom=figure('NumberTitle', 'off','name','Group comparison (zoomed)');
    aHand = axes('parent', zoom);
    hold(aHand, 'on');
    colors = hsv(numel(Y));
for i = 1:numel(Y);
    bar(i, Y(i), 'parent', aHand, 'facecolor', colors(i,:));
end
ylim([0 Hi]);
    set(gca, 'XTick', 1:numel(Y), 'XTickLabel', {(GRP{1,1}), (GRP{2,1})});
    errorbar(Y,error_matrix,'.black');
    hold on
 
else
    set(0, 'DefaultFigurePosition', [1000         200         280         210]);
    zoom=figure('NumberTitle', 'off','name','Group comparison (zoomed)');
    aHand = axes('parent', zoom);
    hold(aHand, 'on');
    colors = hsv(numel(Y));
for i = 1:numel(Y);
    bar(i, Y(i), 'parent', aHand, 'facecolor', colors(i,:));
end
    set(gca, 'XTick', 1:numel(Y), 'XTickLabel', {(GRP{1,1}), (GRP{2,1})});
    errorbar(Y,error_matrix,'.black');
    ylim([(min(Y)-max(stddev)-1) (max(Y)+max(stddev))]);
    hold on;
end

    end

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



    
end
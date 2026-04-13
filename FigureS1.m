
clear
load ..\cmip\his_ssp_mat_data_land\FigureS1.mat
%



fig = figure;
width = 8.8;
height = 4.5;
set(gcf,'position',[10 10 width*100 height*100]);

h1 = axes('Position', [0.0, 0.1, 1, 0.8]); 

title('Dry-season T/ET for observation and Models (his)', 'FontSize', 12, 'FontWeight', 'bold');


data_map = nan(180, 360); 
load kland_1d.mat
k1 = find(isnan(tet_his_mean)); 
tet_his_mean(k1) = 0;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = tet_his_mean(i);  
    end
end


gd = 1;
a = -180 + gd/2 :gd : 180 - gd/2;  
b = -90 + gd/2 :gd : 90 - gd/2;    
[lon, lat] = meshgrid(a, b);


m_proj('robinson','lat',[-60 90],'long',[-180 180]);

hold on;

A = nan(180,360); 
A(kland_1d) = 1; 
A(:,1) = A(:,end);

m_pcolor(lon, lat, A);
shading flat;
colormap(gca,[209/255 209/255 209/255]); 
freezeColors;  

m_pcolor(lon, lat, data_map);
shading flat;


h = m_coast('line'); 
h.Color = [0.3 0.3 0.3];
h.LineWidth = 0.5;

s = m_scatter(site_loc(:,1), site_loc(:,2), 30, tet_driest_mean, 'filled', ...
    'MarkerEdgeColor', 'k', 'LineWidth', 0.1);

s.MarkerFaceAlpha = 0.8;  
s.MarkerEdgeAlpha = 0.9;  

J = colormap(slanCM('RdBu'));

colormap(h1, [[1 1 1]*0.8; J]);  
caxis([0 1]);


set(h1, 'Color', 'none');
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h1, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


c4 = colorbar('southoutside', 'Position', [0.35, 0.05, 0.3, 0.03]);
c4.Ticks = [0, 0.25, 0.5, 0.75, 1];
c4.FontSize = 10;

c4.LineWidth = 0.5;



%
filename='FigureS1.png'
exportgraphics(fig, filename, 'Resolution', 300);















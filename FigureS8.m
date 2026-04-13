
clear

load ..\cmip\his_ssp_mat_data_land\FigureS8.mat


fig = figure
width=8.8
height=10
set(gcf,'position',[10 10 width*100 height*100])

%
h1 = axes('Position', [0.45,0.56,0.4,0.3]); 


title('(b) T_a SSP5-8.5', 'FontSize',12, 'FontWeight','bold');


data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_tas_585_his(i);  
        sig_map(row, col) = sig_tas_585_his(i);        
    end
end
full_cmap = slanCM(97);


J = flip(full_cmap);

gd = 1;
a = -180 + gd/2 :gd : 180 - gd/2;  
b = -90 + gd/2 :gd : 90 - gd/2;    
[lon,lat] = meshgrid(a, b);

load dry_knans.mat



m_proj('robinson','lat',[-60 90],'long',[-180 180]);

A = nan(180,360); 
A(kland_1d) = 1; 


A(:,1) = A(:,end); 


hold on
m_pcolor(lon, lat, A); 
colormap(gca,[209/255 209/255 209/255]); 
freezeColors;

m_pcolor(lon, lat, data_map);
caxis([-30 30]);
colormap(h1,  [[1 1 1]*0.8; J]);

[sig_row, sig_col] = find(sig_map == 1);
if ~isempty(sig_row)
    step = 3;  
    use_points = false(length(sig_row), 1);
    for i = 1:length(sig_row)
        if mod(sig_row(i), step) == 0 && mod(sig_col(i), step) == 0
            use_points(i) = true;
        end
    end
    idx = find(use_points);
    sig_lon = lon(sub2ind(size(lon), sig_row(idx), sig_col(idx)));
    sig_lat = lat(sub2ind(size(lat), sig_row(idx), sig_col(idx)));
    m_plot(sig_lon, sig_lat, '.k', 'MarkerSize', 2, 'MarkerFaceColor', 'k');
    
end

h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;

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



hold on


% 
h2 = axes('Position', [0.1,0.56,0.4,0.3]); 

title('(a) T_a SSP2-4.5', 'FontSize',12, 'FontWeight','bold');

cur_h2 =h2;

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_tas_245_his <= -30); mean_tas_245_his(k) = -29;
k1 = find(isnan(mean_tas_245_his)); mean_tas_245_his(k1) = -30;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_tas_245_his(i);  
        sig_map(row, col) = sig_tas_245_his(i);        
    end
end


gd = 1;
a = -180 + gd/2 :gd : 180 - gd/2;  
b = -90 + gd/2 :gd : 90 - gd/2;    
[lon,lat] = meshgrid(a, b);



m_proj('robinson','lat',[-60 90],'long',[-180 180]);


A = nan(180,360); 
A(kland_1d) = 1; 
A(:,1) = A(:,end); 

hold on
m_pcolor(lon, lat, A); 
shading flat;
colormap(gca,[209/255 209/255 209/255]); 
freezeColors;

m_pcolor(lon, lat, data_map);
caxis([-30 30]);
colormap(h2,  [[1 1 1]*0.8; J]);


[sig_row, sig_col] = find(sig_map == 1);
if ~isempty(sig_row)
    step = 3; 
    use_points = false(length(sig_row), 1);
    for i = 1:length(sig_row)
        if mod(sig_row(i), step) == 0 && mod(sig_col(i), step) == 0
            use_points(i) = true;
        end
    end
    idx = find(use_points);
    sig_lon = lon(sub2ind(size(lon), sig_row(idx), sig_col(idx)));
    sig_lat = lat(sub2ind(size(lat), sig_row(idx), sig_col(idx)));
    m_plot(sig_lon, sig_lat, '.k', 'MarkerSize', 2, 'MarkerFaceColor', 'k');
    
end


h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;

set(h2, 'Color', 'none'); 
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h2, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


c2 = colorbar('southoutside');
delete(c2);


hold on



c1 = colorbar('Position', [0.35 0.61 0.3 0.015], 'Orientation', 'horizontal');

set(c1, 'LineWidth', 0.2, 'FontSize', 10);
caxis([-30 30]);
set(c1, 'XTick', [-30 -15 0 15 30]);


colormap(c1, J);  
xlabel(c1, '°C', 'FontSize', 10);
%
h3 = axes('Position', [0.45,0.31,0.4,0.3]); 
title('(d) ΔT_a SSP5-8.5', 'FontSize',12, 'FontWeight','bold');


data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_tas_585_his <= -10); mean_dif_tas_585_his(k) = -9;
k1 = find(isnan(mean_dif_tas_585_his)); mean_dif_tas_585_his(k1) = -10;
for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_tas_585_his(i);  
        sig_map(row, col) = sig_dif_tas_585_his(i);        
    end
end


gd = 1;
a = -180 + gd/2 :gd : 180 - gd/2;  
b = -90 + gd/2 :gd : 90 - gd/2;    
[lon,lat] = meshgrid(a, b);

load dry_knans.mat


J1 = flip(full_cmap);

m_proj('robinson','lat',[-60 90],'long',[-180 180]);


A = nan(180,360); 
A(kland_1d) = 1; 


A(:,1) = A(:,end); 

hold on

m_pcolor(lon, lat, A); 
shading flat;
colormap(gca,[209/255 209/255 209/255]); 
freezeColors;
m_pcolor(lon, lat, data_map);
caxis([-10 10]);
colormap(h3,  [[1 1 1]*0.8; J1]);




[sig_row, sig_col] = find(sig_map == 1);
if ~isempty(sig_row)
    step = 3;  
    use_points = false(length(sig_row), 1);
    for i = 1:length(sig_row)
        if mod(sig_row(i), step) == 0 && mod(sig_col(i), step) == 0
            use_points(i) = true;
        end
    end
    idx = find(use_points);
    sig_lon = lon(sub2ind(size(lon), sig_row(idx), sig_col(idx)));
    sig_lat = lat(sub2ind(size(lat), sig_row(idx), sig_col(idx)));
    m_plot(sig_lon, sig_lat, '.k', 'MarkerSize', 2, 'MarkerFaceColor', 'k');
  
end


h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;

set(h3, 'Color', 'none'); 
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h3, "XColor", 'none', 'YColor', 'none', 'Color', 'none');




c6 = colorbar('southoutside');
delete(c6);
set(gca,'LineWidth',0.2);

hold on



%
h4 = axes('Position', [0.1,0.31,0.4,0.3]); 

cur_h4 =h4;
title('(c) ΔT_a SSP2-4.5', 'FontSize',12, 'FontWeight','bold');


data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_tas_245_his <= -10); mean_dif_tas_245_his(k) = -9;
k1 = find(isnan(mean_dif_tas_245_his)); mean_dif_tas_245_his(k1) = -10;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_tas_245_his(i);  
        sig_map(row, col) = sig_dif_tas_245_his(i);        
    end
end


gd = 1;
a = -180 + gd/2 :gd : 180 - gd/2;  
b = -90 + gd/2 :gd : 90 - gd/2;    
[lon,lat] = meshgrid(a, b);



m_proj('robinson','lat',[-60 90],'long',[-180 180]);


A = nan(180,360); 
A(kland_1d) = 1; 
A(:,1) = A(:,end);

hold on
m_pcolor(lon, lat, A); 
shading flat;
colormap(gca,[209/255 209/255 209/255]); 
freezeColors;

m_pcolor(lon, lat, data_map);
caxis([-10 10]);
colormap(h4,  [[1 1 1]*0.8; J1]);


[sig_row, sig_col] = find(sig_map == 1);
if ~isempty(sig_row)
    step = 3;  
    use_points = false(length(sig_row), 1);
    for i = 1:length(sig_row)
        if mod(sig_row(i), step) == 0 && mod(sig_col(i), step) == 0
            use_points(i) = true;
        end
    end
    idx = find(use_points);
    sig_lon = lon(sub2ind(size(lon), sig_row(idx), sig_col(idx)));
    sig_lat = lat(sub2ind(size(lat), sig_row(idx), sig_col(idx)));
    m_plot(sig_lon, sig_lat, '.k', 'MarkerSize', 2, 'MarkerFaceColor', 'k');
    
end


h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;

set(h4, 'Color', 'none'); 
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         
set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h4, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


c4 = colorbar('southoutside');
delete(c4);
set(gca,'LineWidth',0.5);


hold on



%
c1 = colorbar('Position', [0.35 0.36 0.3 0.015], 'Orientation', 'horizontal');


set(c1, 'LineWidth', 0.2, 'FontSize', 10);
caxis([-10 10]);
set(c1, 'XTick', [-10 -5 0 5 10]);


colormap(c1, J1);  
xlabel(c1, '°C', 'FontSize', 10);




filename='FigureS8.png'


exportgraphics(fig, filename, 'Resolution', 300);







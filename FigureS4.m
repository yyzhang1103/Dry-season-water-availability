
clear
load E..\cmip\his_ssp_mat_data_land\FigureS4.mat




figure
width=8.8
height=5.5
set(gcf,'position',[10 10 width*100 height*100])
h1 = subplot('Position', [0.0,0.5,0.45,0.55]); 
title('(a) Δ Wa (SSP2-4.5)', 'FontSize',12, FontWeight='bold');
cur_h1 =h1;

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_245_his <= -15); mean_dif_245_his(k) = -14;
k1 = find(isnan(mean_dif_245_his)); mean_dif_245_his(k1) = -15;


for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_245_his(i);  
        sig_map(row, col) = sig_dif_245_his(i);        
    end
end

full_cmap = slanCM(97);


idx = [1:2:32, ...           
       33:3:64, ...          
       65:8:96, ...         
       97:12:128, ...        
       129:12:160, ...        
       161:8:192, ...       
       193:3:224, ...        
       225:2:256];          

idx = round(idx);
idx = unique(idx(idx >=1 & idx <=256));  



J = interp1(1:length(idx), full_cmap(idx,:), linspace(1,length(idx),127), 'linear');


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
caxis([-15 15]);
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

grid on; box on
h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;

m_grid('xaxis','off','yaxis','off', ...
     'box', 'off', ...
     'xtick',[], ...
     'ytick',[], ...
     'xticklabels',{}, ...
     'yticklabels',{},...
     'linestyle','none');        


c1 = colorbar('southoutside');
delete(c1);

set(gca,'LineWidth',0.5);

hold on





h2 = axes('Position', [0.43,0.615,0.05,0.32]); 


plot(mean_valid, lat_valid, 'Color', [228/266, 126/255, 100/255], 'LineWidth', 0.4);
hold on;


line([0, 0], ylim, 'Color', [0.5,0.5,0.5], 'LineStyle', '--', 'LineWidth', 0.05);
line([nanmean(mean_valid), nanmean(mean_valid)], ylim, 'Color', [228/266, 126/255, 100/255], 'LineStyle', '--', 'LineWidth', 0.05);


x_fill = [mean_valid - std_valid; flipud(mean_valid + std_valid)];
y_fill = [lat_valid'; flipud(lat_valid')];


fill(x_fill, y_fill, [228/266, 126/255, 100/255], 'FaceAlpha', 0.1, 'EdgeColor', 'none');

xlim([-15, 15]);  
ylim([-60, 90]);  
xlabel('ΔWa (mm/month)', 'FontSize',7)

grid off;

set(gca, 'Box', 'off');  
set(gca, 'YTickLabel', {});  
set(gca, 'XTick', [-10, 0, 10]);  
set(gca, 'XColor', 'k', 'YColor', 'none');  
line(xlim, [-60, -60], 'Color', 'k', 'LineWidth', 0.15);

box off;  
hold on;







 

h3 = axes('Position', [0.5,0.5,0.45,0.55]); 
title('(b) Δ annual Wa (SSP5-8.5)', 'FontSize',12, FontWeight='bold');

colormap(h3, J);

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_585_his <= -15); mean_dif_585_his(k) = -14;
k1 = find(isnan(mean_dif_585_his)); mean_dif_585_his(k1) = -15;


for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_585_his(i);  
        sig_map(row, col) = sig_dif_585_his(i);        
    end
end


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

hold on
m_pcolor(lon, lat, A); 
shading flat;
colormap(gca,[209/255 209/255 209/255]); 
freezeColors;

m_pcolor(lon, lat, data_map);
caxis([-15 15]);
colormap(h3,  [[1 1 1]*0.8; J]);

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


grid on; box on
h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;


m_grid('xaxis','off','yaxis','off', ...
     'box', 'off', ...
     'xtick',[], ...
     'ytick',[], ...
     'xticklabels',{}, ...
     'yticklabels',{},...
     'linestyle','none');         
c3 = colorbar('southoutside');
delete(c3);
set(gca,'LineWidth',0.2);

hold on



wa_585_his_area_mean = nanmean(dif_585_his_area,2);
for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    data_map(row, col) = wa_585_his_area_mean(i); 
end

mean_per_lat = mean(data_map, 2, 'omitnan');  
std_per_lat = std(data_map, 0, 2, 'omitnan');  
latitudes = linspace(-89.75, 89.75, 180);


valid_indices = ~isnan(mean_per_lat) & ~isnan(std_per_lat);
mean_valid = mean_per_lat(valid_indices);
std_valid = std_per_lat(valid_indices);
lat_valid = latitudes(valid_indices);


h4 = axes('Position', [0.93,0.615,0.05,0.32]); 
plot(mean_valid, lat_valid, 'Color', [228/266, 126/255, 100/255], 'LineWidth', 0.4);
hold on;


line([0, 0], ylim, 'Color', [0.5,0.5,0.5], 'LineStyle', '--', 'LineWidth', 0.05);
line([nanmean(mean_valid), nanmean(mean_valid)], ylim, 'Color', [228/266, 126/255, 100/255], 'LineStyle', '--', 'LineWidth', 0.05);


x_fill = [mean_valid - std_valid; flipud(mean_valid + std_valid)];
y_fill = [lat_valid'; flipud(lat_valid')];


fill(x_fill, y_fill, [228/266, 126/255, 100/255], 'FaceAlpha', 0.1, 'EdgeColor', 'none');


xlim([-15, 15]);  
ylim([-60, 90]);  
xlabel('ΔWa (mm/month)', 'FontSize',7)

grid off;

set(gca, 'Box', 'off');  
set(gca, 'YTickLabel', {});  
set(gca, 'XTick', [-10, 0, 10]);  
set(gca, 'XColor', 'k', 'YColor', 'none');  


line(xlim, [-60, -60], 'Color', 'k', 'LineWidth', 0.15);

box off;  
hold on;


h5 = axes('Position', [0.0,0.05,0.45,0.55]); 
title('(c) Δ annual Wa (SSP5-8.5 - SSP2-4.5)', 'FontSize',12, FontWeight='bold');

colormap(h5, J);

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_wa_585_245 <= -15); mean_dif_wa_585_245(k) = -14;
k1 = find(isnan(mean_dif_wa_585_245)); mean_dif_wa_585_245(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_wa_585_245(i);  
        sig_map(row, col) = sig_dif_wa_585_245(i);        
    end
end


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
shading flat;
colormap(gca,[209/255 209/255 209/255]); 
freezeColors;
m_pcolor(lon, lat, data_map);
caxis([-15 15]);
colormap(h5,  [[1 1 1]*0.8; J]);

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



grid on; box on
h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;


m_grid('xaxis','off','yaxis','off', ...
     'box', 'off', ...
     'xtick',[], ...
     'ytick',[], ...
     'xticklabels',{}, ...
     'yticklabels',{},...
     'linestyle','none');         



c3 = colorbar('southoutside');
delete(c3);
set(gca,'LineWidth',0.2);

hold on

 
wa_585_245_area_mean = nanmean(dif_585_245_area,2);


for i = 1:length(kland_1d)
    index = kland_1d(i);
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);      
    data_map(row, col) = wa_585_245_area_mean(i); 
end


mean_per_lat = mean(data_map, 2, 'omitnan');  
std_per_lat = std(data_map, 0, 2, 'omitnan');  


latitudes = linspace(-89.75, 89.75, 180);

valid_indices = ~isnan(mean_per_lat) & ~isnan(std_per_lat);
mean_valid = mean_per_lat(valid_indices);
std_valid = std_per_lat(valid_indices);
lat_valid = latitudes(valid_indices);


h6 = axes('Position', [0.43,0.165,0.05,0.32]); 

plot(mean_valid, lat_valid, 'Color', [228/266, 126/255, 100/255], 'LineWidth', 0.4);
hold on;


line([0, 0], ylim, 'Color', [0.5,0.5,0.5], 'LineStyle', '--', 'LineWidth', 0.05);
line([nanmean(mean_valid), nanmean(mean_valid)], ylim, 'Color', [228/266, 126/255, 100/255], 'LineStyle', '--', 'LineWidth', 0.05);


x_fill = [mean_valid - std_valid; flipud(mean_valid + std_valid)];
y_fill = [lat_valid'; flipud(lat_valid')];


fill(x_fill, y_fill, [228/266, 126/255, 100/255], 'FaceAlpha', 0.1, 'EdgeColor', 'none');


xlim([-15, 15]);  
ylim([-60, 90]);  
xlabel('ΔWa (mm/month)', 'FontSize',7)

grid off;


set(gca, 'Box', 'off');  
set(gca, 'YTickLabel', {});  
set(gca, 'XTick', [-10,  0, 10]);  
set(gca, 'XColor', 'k', 'YColor', 'none');  


line(xlim, [-60, -60], 'Color', 'k', 'LineWidth', 0.15);

box off;  
hold on;









h7 = subplot('Position', [0.55, 0.16, 0.35, 0.32]);


b = bar(all_data, 'grouped', 'BarWidth', 0.8);

b(1).FaceColor = [238/255, 165/255, 153/255];    
b(2).FaceColor = [171/255, 211/255, 225/255];    
b(3).FaceColor = [146/255, 180/255, 200/255]; 


for i = 1:3
    b(i).FaceAlpha = 0.6;
    b(i).LineWidth = 0.02;
end

set(gca, 'FontSize', 8);


ylim([-2, 8]);

set(gca, 'YTick', -2:2:8);

set(gca, 'YAxisLocation', 'right');
set(gca, 'YTickLabel', {'-2','0', '2','4', '6', '8'});  



set(gca, 'XTick', 1:10, 'XTickLabel', {'Mean', 'BCC', 'CAS', 'CMCC', 'EC-Earth', 'FIO', 'GFDL', 'IPSL', 'MIROC6', 'MRI'});
xtickangle(25);

title('(d) Δ annual Wa for each model', 'FontSize', 12, FontWeight='bold');


annotation('rectangle', [0.56, 0.45, 0.02, 0.01], 'FaceColor', [238/255, 165/255, 153/255], 'FaceAlpha', 0.8, 'LineWidth', 0.02);
annotation('rectangle', [0.56, 0.43, 0.02, 0.01], 'FaceColor', [171/255, 211/255, 225/255], 'FaceAlpha', 0.8, 'LineWidth', 0.02);
annotation('rectangle', [0.56, 0.41, 0.02, 0.01], 'FaceColor', [146/255, 180/255, 200/255], 'FaceAlpha', 0.8, 'LineWidth', 0.02);

annotation('textbox', [0.58, 0.45, 0.15, 0.02], 'String', 'ΔWa (SSP5-8.5 - SSP2-4.5)', 'FontSize', 7, 'EdgeColor', 'none');
annotation('textbox', [0.58, 0.43, 0.1, 0.02], 'String', 'ΔWa (SSP2-4.5)', 'FontSize', 7, 'EdgeColor', 'none');
annotation('textbox', [0.58, 0.41, 0.1, 0.02], 'String', 'ΔWa (SSP5-8.5)', 'FontSize', 7, 'EdgeColor', 'none');


drawnow;
hold on








c1 = colorbar('Position', [0.35 0.07 0.3 0.03], 'Orientation', 'horizontal');


set(c1, 'LineWidth', 0.2, 'FontSize', 10);
caxis([-15 15]);
set(c1, 'XTick', [-15 -10 -5 0 5 10 15]);


colormap(c1, J); 
xlabel(c1, 'mm month^{-1}', 'FontSize', 8);



filename='FigureS4'
print(filename,'-dpng','-r300')









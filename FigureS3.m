


%
clear
load ..\cmip\his_ssp_mat_data_land\FigureS3.mat

%

figure
width=8.8
height=5.5
set(gcf,'position',[10 10 width*100 height*100])
min(mean_wa_his_mean)


h1 = subplot('Position', [0.0,0.5,0.45,0.55]); 
title('(a) W_d (historical)', 'FontSize',12, 'FontWeight','bold');
cur_h1 =h1;

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat

k = find(mean_wa_his_mean <= -99); mean_wa_his_mean(k) = -98;
k1 = find(isnan(mean_wa_his_mean)); mean_wa_his_mean(k1) = -100;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_wa_his_mean(i);  
        sig_map(row, col) = sig_wa_his_mean(i);        
    end
end

J = cbrewer2('div','BrBG',1000,'linear');

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
%

m_pcolor(lon, lat, data_map);
caxis([-100 100]);

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
set(gca,'LineWidth',0.5);


hold on




load kland_1d.mat
data_map = nan(180, 360); 
wa_his_area_mean = nanmean(wa_his_mean,2);


for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);      
    data_map(row, col) = wa_his_area_mean(i); 
end

mean_per_lat = mean(data_map, 2, 'omitnan');  
std_per_lat = std(data_map, 0, 2, 'omitnan'); 
latitudes = linspace(-89.75, 89.75, 180);

valid_indices = ~isnan(mean_per_lat) & ~isnan(std_per_lat);
mean_valid = mean_per_lat(valid_indices);
std_valid = std_per_lat(valid_indices);
lat_valid = latitudes(valid_indices);

h2 = axes('Position', [0.43,0.615,0.05,0.32]); 


plot(mean_valid, lat_valid, 'Color', [151/266, 93/255, 21/255], 'LineWidth', 0.4);
hold on;

line([0, 0], ylim, 'Color', [0.5,0.5,0.5], 'LineStyle', '--', 'LineWidth', 0.05);
line([nanmean(mean_valid), nanmean(mean_valid)], ylim, 'Color', [151/266, 93/255, 21/255], 'LineStyle', '--', 'LineWidth', 0.05);

x_fill = [mean_valid - std_valid; flipud(mean_valid + std_valid)];
y_fill = [lat_valid'; flipud(lat_valid')];

fill(x_fill, y_fill, [151/266, 93/255, 21/255], 'FaceAlpha', 0.1, 'EdgeColor', 'none');

xlim([-100, 50]);  
ylim([-60, 90]);  
xlabel('ΔW_d (mm month^{-1})', 'FontSize',7)

grid off;

set(gca, 'Box', 'off'); 
set(gca, 'YTickLabel', {});  
set(gca, 'YTick', [-60, -30, 0, 30, 60, 90]);  
set(gca, 'XColor', 'k', 'YColor', 'none'); 
line(xlim, [-60, -60], 'Color', 'k', 'LineWidth', 0.15);

box off;  
hold on;




h3 = axes('Position', [0.5,0.5,0.45,0.55]); 
title('(b) W_d (SSP2-4.5)', 'FontSize',12, 'FontWeight','bold');

colormap(h3, J);

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat

k = find(mean_wa_245_mean <= -99); mean_wa_245_mean(k) = -98;
k1 = find(isnan(mean_wa_245_mean)); mean_wa_245_mean(k1) = -100;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_wa_245_mean(i);  
        sig_map(row, col) = sig_wa_245_mean(i);        
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
caxis([-100 100]);
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


set(gca,'LineWidth',0.5);


hold on



data_map = nan(180, 360); 
wa_245_area_mean = nanmean(wa_245_mean,2);

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1;
    col = ceil(index / 180);       
    data_map(row, col) = wa_245_area_mean(i); 
end
mean_per_lat = mean(data_map, 2, 'omitnan');  
std_per_lat = std(data_map, 0, 2, 'omitnan');  
latitudes = linspace(-89.75, 89.75, 180);

valid_indices = ~isnan(mean_per_lat) & ~isnan(std_per_lat);
mean_valid = mean_per_lat(valid_indices);
std_valid = std_per_lat(valid_indices);
lat_valid = latitudes(valid_indices);

h4 = axes('Position', [0.93,0.615,0.05,0.32]); 

plot(mean_valid, lat_valid, 'Color', [151/266, 93/255, 21/255], 'LineWidth', 0.4);
hold on;
line([0, 0], ylim, 'Color', [0.5,0.5,0.5], 'LineStyle', '--', 'LineWidth', 0.05);
line([nanmean(mean_valid), nanmean(mean_valid)], ylim, 'Color', [151/266, 93/255, 21/255], 'LineStyle', '--', 'LineWidth', 0.05);
x_fill = [mean_valid - std_valid; flipud(mean_valid + std_valid)];
y_fill = [lat_valid'; flipud(lat_valid')];


fill(x_fill, y_fill, [151/266, 93/255, 21/255], 'FaceAlpha', 0.1, 'EdgeColor', 'none');

xlim([-100, 50]);  
ylim([-60, 90]);  
xlabel('W_d (mm month^{-1})', 'FontSize',7)

grid off;


set(gca, 'Box', 'off');  
set(gca, 'YTickLabel', {});  
set(gca, 'YTick', [-60, -30, 0, 30, 60, 90]);  
set(gca, 'XColor', 'k', 'YColor', 'none');  
line(xlim, [-60, -60], 'Color', 'k', 'LineWidth', 0.15);

box off;  
hold on;


h5 = axes('Position', [0.0,0.05,0.45,0.55]);  
title('(c) W_d (SSP5-8.5)', 'FontSize',12,'FontWeight','bold');

colormap(h5, J);

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat

k = find(mean_wa_585_mean <= -99);mean_wa_585_mean(k) = -98;
k1 = find(isnan(mean_wa_585_mean)); mean_wa_585_mean(k1) = -100;
for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_wa_585_mean(i);  
        sig_map(row, col) = sig_wa_585_mean(i);        
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
caxis([-100 100]);

colormap(h5,   [[1 1 1]*0.8; J]);


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
set(h5, 'Color', 'none'); 
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');        

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h5, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


set(gca,'LineWidth',0.5);

hold on


load kland_1d.mat
data_map = nan(180, 360); 
wa_585_area_mean = nanmean(wa_585_mean,2);


for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    data_map(row, col) = wa_585_area_mean(i); 
end


mean_per_lat = mean(data_map, 2, 'omitnan');  
std_per_lat = std(data_map, 0, 2, 'omitnan');  
latitudes = linspace(-89.75, 89.75, 180);


valid_indices = ~isnan(mean_per_lat) & ~isnan(std_per_lat);
mean_valid = mean_per_lat(valid_indices);
std_valid = std_per_lat(valid_indices);
lat_valid = latitudes(valid_indices);

h6 = axes('Position', [0.43,0.165,0.05,0.32]); 

plot(mean_valid, lat_valid, 'Color', [151/266, 93/255, 21/255], 'LineWidth', 0.4);
hold on;


line([0, 0], ylim, 'Color', [0.5,0.5,0.5], 'LineStyle', '--', 'LineWidth', 0.05);
line([nanmean(mean_valid), nanmean(mean_valid)], ylim, 'Color', [151/266, 93/255, 21/255], 'LineStyle', '--', 'LineWidth', 0.05);

x_fill = [mean_valid - std_valid; flipud(mean_valid + std_valid)];
y_fill = [lat_valid'; flipud(lat_valid')];
fill(x_fill, y_fill, [151/266, 93/255, 21/255], 'FaceAlpha', 0.1, 'EdgeColor', 'none');
xlim([-100, 50]);  
ylim([-60, 90]);  
xlabel('W_d (mm month^{-1})', 'FontSize',7)

grid off;


set(gca, 'Box', 'off');  
set(gca, 'YTickLabel', {}); 
set(gca, 'YTick', [-60, -30, 0, 30, 60, 90]);  
set(gca, 'XColor', 'k', 'YColor', 'none');  
line(xlim, [-60, -60], 'Color', 'k', 'LineWidth', 0.15);
box off; 
hold on;




load model_tran_use.mat


res = 1;  
gd = 1;   
a = -180 + gd/2 : gd : 180 - gd/2;  
b = -90 + gd/2 : gd : 90 - gd/2;    
[lon, lat] = meshgrid(a, b);


Wei = abs(sin((lat + 0.5 * res) * pi / 180) - sin((lat - 0.5 * res) * pi / 180)) ./ ...
      (sin((0.5 * res) * pi / 180) - sin(-(0.5 * res) * pi / 180));


load kland_1d.mat
Wei_1_all = nan(length(kland_1d), 1);

for j = 1:length(kland_1d)
    index = kland_1d(j); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    Wei_1_all(j, :) = Wei(row, col, :);
end

Wei_1_all_fac = repmat(Wei_1_all, 1, 9);  
eachmodel_wa_his_area_mean = squeeze(sum(wa_his_area, 1,'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'));
eachmodel_wa_245_area_mean = squeeze(sum(wa_245_area, 1,'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'));
eachmodel_wa_585_area_mean = squeeze(sum(wa_585_area, 1,'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'));

modelmean_his = mean(eachmodel_wa_his_area_mean);
modelmean_245 = mean(eachmodel_wa_245_area_mean);
modelmean_585 = mean(eachmodel_wa_585_area_mean);


model_names = {'BCC-CSM2-MR', 'CAS-ESM2-0','CMCC-ESM2', 'CanESM5', 'EC-Earth3-CC', 'FIO-ESM-2-0', 'GFDL-ESM4', 'IPSL-CM6A-LR','FGOALS-g3'};

model_means = [modelmean_his, modelmean_245, modelmean_585];


model_data = zeros(9, 3); 
model_data(:, 1) = eachmodel_wa_his_area_mean; 
model_data(:, 2) = eachmodel_wa_245_area_mean;  
model_data(:, 3) = eachmodel_wa_585_area_mean;  


all_data = [model_means; model_data];


h7 = axes('Position', [0.55, 0.16, 0.35, 0.32]);

b = bar(all_data, 'grouped', 'BarWidth', 0.8);


b(1).FaceColor = [238/255, 165/255, 153/255];    
b(2).FaceColor = [171/255, 211/255, 225/255];    
b(3).FaceColor = [146/255, 180/255, 200/255]; 
for i = 1:3
    b(i).FaceAlpha = 0.6;
    b(i).LineWidth = 0.02;
end

set(gca, 'FontSize', 8);


ylim([-55, 0]);
ylabel ('W_d (mm month^{-1})')

set(gca, 'YTick', -50:20:0);

set(gca, 'YAxisLocation', 'right');
set(gca, 'YTickLabel', {'-50','-30', '-10','0'});  
set(gca, 'XTick', 1:10, 'XTickLabel', {'Mean', 'BCC', 'CAS',  'CMCC',  'CanESM5', 'EC-Earth', 'FIO', 'GFDL', 'IPSL', 'FGOALS'});
xtickangle(25);

title('(d) W_d for each model', 'FontSize', 12, 'FontWeight','bold');


annotation('rectangle', [0.59, 0.24, 0.02, 0.01], 'FaceColor', [238/255, 165/255, 153/255], 'FaceAlpha', 0.8, 'LineWidth', 0.02);
annotation('rectangle', [0.59, 0.22, 0.02, 0.01], 'FaceColor', [171/255, 211/255, 225/255], 'FaceAlpha', 0.8, 'LineWidth', 0.02);
annotation('rectangle', [0.59, 0.20, 0.02, 0.01], 'FaceColor', [146/255, 180/255, 200/255], 'FaceAlpha', 0.8, 'LineWidth', 0.02);

annotation('textbox', [0.61, 0.24, 0.1, 0.02], 'String', 'Wa_{his}', 'FontSize', 7, 'EdgeColor', 'none');
annotation('textbox', [0.61, 0.22, 0.1, 0.02], 'String', 'Wa_{SSP2.45}', 'FontSize', 7, 'EdgeColor', 'none');
annotation('textbox', [0.61, 0.20, 0.1, 0.02], 'String', 'Wa_{SSP5.85}', 'FontSize', 7, 'EdgeColor', 'none');


drawnow;
hold on







c1 = colorbar('Position', [0.35 0.07 0.3 0.03], 'Orientation', 'horizontal');


set(c1, 'LineWidth', 0.2, 'FontSize', 8);
caxis([-100 100]);
set(c1, 'XTick', [-100 -50 0 50 100]);



colormap(c1, J);  
xlabel(c1, 'mm month^{-1}', 'FontSize', 8);


filename='FigureS3'
print(filename,'-dpng','-r300')













%% Figure 1

clear


load Figure1.mat




years = 2015:2100;


figure
width=8.8;
height=12;
set(gcf,'position',[10 10 width*100 height*100])
%  (a)                                                                               
h1 = axes('Position', [0.08,0.83,0.4,0.14]); 

% annual
green_color = [39/255, 119/255, 199/255];
h_annual_range = fill([years, fliplr(years)], ...
     [annual_245_mean+annual_245_std; flipud(annual_245_mean-annual_245_std)]', ...
     [39/255, 119/255, 199/255], 'FaceAlpha', 0.2, 'EdgeColor', 'none');
hold on;


% dry-season
red_color = [176/255, 104/255, 108/255];
h_driest_range = fill([years, fliplr(years)], ...
     [driest_245_mean + driest_245_std; flipud(driest_245_mean -driest_245_std)]', ...
     [176/255, 104/255, 108/255], 'FaceAlpha', 0.4, 'EdgeColor', 'none');

h_annual_line = plot(years, annual_245_mean, 'Color', green_color, 'LineWidth', 1.5);
h_driest_line = plot(years, driest_245_mean, 'Color', red_color, 'LineWidth', 1.5);

% 
title('(a)  ΔW_d during under SSP2-4.5', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');
xlabel('Year');
ylabel('ΔW_d (mm month^{-1})');
ylim([-8, 4]); 

grid off;
set(gca, 'GridLineStyle', '--','LineWidth', 1);
set(gca, 'GridAlpha', 0.2);

%
ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;
ax.XAxis.TickDirection = 'out';
ax.YAxis.TickDirection = 'out';
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';
ax.Box = 'off';

h_legend = legend([h_annual_line,  h_driest_line], ...
       {'annual',  'dry-season-1 month'}, ...
       'Location', 'southwest', 'FontSize', 12, 'NumColumns', 1);
h_legend.Box = 'off';
xlim([2015, 2100]);

set(h1, 'YTick', [-8, -4, 0, 4],  'XTick', [2015, 2040, 2060, 2080, 2100], 'FontSize', 12, 'FontName', 'Arial');


%                                                                       
h2 = subplot('Position', [0.56,0.83,0.4,0.14]); 

% annual
green_color = [39/255, 119/255, 199/255];
h_annual_range = fill([years, fliplr(years)], ...
     [annual_585_mean+annual_585_std; flipud(annual_585_mean-annual_585_std)]', ...
     [39/255, 119/255, 199/255], 'FaceAlpha', 0.2, 'EdgeColor', 'none');
hold on


% dry-season
red_color = [176/255, 104/255, 108/255];
h_driest_range = fill([years, fliplr(years)], ...
     [driest_585_mean + driest_585_std; flipud(driest_585_mean -driest_585_std)]', ...
     [176/255, 104/255, 108/255], 'FaceAlpha', 0.4, 'EdgeColor', 'none');

h_annual_line = plot(years, annual_585_mean, 'Color', green_color, 'LineWidth', 1.5);
h_driest_line = plot(years, driest_585_mean, 'Color', red_color, 'LineWidth', 1.5);

%
title('(b)  ΔW_d under SSP5-8.5', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');
xlabel('Year');
ylabel('ΔW_d (mm month^{-1})');
ylim([-8, 4]); 

grid off;
set(gca, 'GridLineStyle', '--','LineWidth', 1);
set(gca, 'GridAlpha', 0.2);

%
ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;
ax.XAxis.TickDirection = 'out';
ax.YAxis.TickDirection = 'out';
ax.XAxisLocation = 'bottom';
ax.YAxisLocation = 'left';
ax.Box = 'off';

xlim([2015, 2100]);
set(h2, 'YTick', [-8, -4, 0, 4],  'XTick', [2015, 2040, 2060, 2080, 2100], 'FontSize', 12, 'FontName', 'Arial');


% 

%load ..\E\cmip\his_ssp_mat_data_land\model_his_future_driest.mat

%
% dif_wa_245_his = wa_245_mean -wa_his_mean;
% [mean_dif_245_his_1, p_dif_245_his, sig_dif_245_his] = cal_sig(dif_wa_245_his);
% 
% dif_wa_585_his = wa_585_mean - wa_his_mean;
% [mean_dif_585_his_1, p_dif_585_his, sig_dif_585_his] = cal_sig(dif_wa_585_his);
% 
%  (c) 245                                                                                              
h3 = axes('Position', [-0.02,0.43,1,0.34]);   
title('(c) ΔW_d under SSP2-4.5', 'FontSize',13, 'FontWeight','bold');

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_245_his_1 <= -15); mean_dif_245_his_1(k) = -14;
k1 = find(isnan(mean_dif_245_his_1)); mean_dif_245_his_1(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_245_his_1(i);  
        sig_map(row, col) = sig_dif_245_his(i);        
    end
end

full_cmap = flip(slanCM(102));
% 
num = [1:2:32, 33:3:64,  65:8:96,  97:12:128,  129:12:160,  161:8:192, 193:3:224,  225:2:256];           
num = round(num);
num = unique(num(num >=1 & num <=256));  

J = interp1(1:length(num), full_cmap(num,:), linspace(1,length(num),127), 'linear');

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
colormap(h3,  [[1 1 1]*0.8; J]);
% 
[sig_row, sig_col] = find(sig_map == 1);
if ~isempty(sig_row)
    step = 3;  
    use_points = false(length(sig_row), 1);
    for i = 1:length(sig_row)
        if mod(sig_row(i), step) == 0 && mod(sig_col(i), step) == 0
            use_points(i) = true;
        end
    end
    num = find(use_points);
    sig_lon = lon(sub2ind(size(lon), sig_row(num), sig_col(num)));
    sig_lat = lat(sub2ind(size(lat), sig_row(num), sig_col(num)));
    m_plot(sig_lon, sig_lat, '.k', 'MarkerSize', 2, 'MarkerFaceColor', 'k');
end

grid on; box on
h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;


lat_na = [140, 155];   lon_na = [55, 90];    
lat_caf = [91, 110];   lon_caf = [175, 230]; 
lat_saf = [51, 76];      lon_saf = [195, 220];  
lat_boreal = [145, 155]; lon_boreal = [250, 300]; 
lat_ind = [80, 100];  lon_ind = [275, 310];    
lat_aus = [65, 77];   lon_aus = [292, 315];    
lat_amz = [75, 95];   lon_amz = [100, 125];   


regions = {
    struct('name', 'NA', 'lat', lat_na, 'lon', lon_na, 'color', [0.6 0.6 0.6]);
    struct('name', 'AMZ', 'lat', lat_amz, 'lon', lon_amz, 'color', [0.6 0.6 0.6]);
    struct('name', 'C-AF', 'lat', lat_caf, 'lon', lon_caf, 'color', [0.6 0.6 0.6]);
    struct('name', 'S-AF', 'lat', lat_saf, 'lon', lon_saf, 'color', [0.6 0.6 0.6]);
    struct('name', 'Boreal', 'lat', lat_boreal, 'lon', lon_boreal, 'color', [0.6 0.6 0.6]);
    struct('name', 'IND', 'lat', lat_ind, 'lon', lon_ind, 'color', [0.3 0.3 0.3]);
    struct('name', 'AUS', 'lat', lat_aus, 'lon', lon_aus, 'color', [0.6 0.6 0.6]);
};

for i = 1:length(regions)
    reg = regions{i};
    
    lat_deg = [-90 + reg.lat(1) - 0.5, -90 + reg.lat(2) + 0.5];
    lon_deg = [-180 + reg.lon(1) - 0.5, -180 + reg.lon(2) + 0.5];
    m_plot([lon_deg(1), lon_deg(2), lon_deg(2), lon_deg(1), lon_deg(1)], ...
           [lat_deg(1), lat_deg(1), lat_deg(2), lat_deg(2), lat_deg(1)], ...
           '-', 'Color', reg.color, 'LineWidth', 0.8);
end

m_grid('xaxis','off','yaxis','off',  'box', 'off', 'xtick',[],  'ytick',[],  'xticklabels',{},  'yticklabels',{}, 'linestyle','none');   
set(h3, 'Color', 'none');     
set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h3, "XColor", 'none', 'YColor', 'none', 'Color', 'none');
set(gca,'LineWidth',0.2);
hold on

%                                                                            

h4 = subplot('Position', [-0.02,0.05,1,0.34]); 
title('(d)  ΔW_d under SSP5-8.5', 'FontSize',13, 'FontWeight','bold');

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_585_his_1 <= -15); mean_dif_585_his_1(k) = -14;
k1 = find(isnan(mean_dif_585_his_1)); mean_dif_585_his_1(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_585_his_1(i);  
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

m_pcolor(lon, lat, A); 
shading flat;
colormap(gca,[209/255 209/255 209/255]); 
freezeColors;

m_pcolor(lon, lat, data_map);
caxis([-15 15]);
colormap(h4,  [[1 1 1]*0.8; J]);

[sig_row, sig_col] = find(sig_map == 1);
if ~isempty(sig_row)
    step = 3;  
    use_points = false(length(sig_row), 1);
    for i = 1:length(sig_row)
        if mod(sig_row(i), step) == 0 && mod(sig_col(i), step) == 0
            use_points(i) = true;
        end
    end
    num = find(use_points);
    sig_lon = lon(sub2ind(size(lon), sig_row(num), sig_col(num)));
    sig_lat = lat(sub2ind(size(lat), sig_row(num), sig_col(num)));
    m_plot(sig_lon, sig_lat, '.k', 'MarkerSize', 2, 'MarkerFaceColor', 'k');
end


grid on; box on
h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;


lat_na = [140, 155];  lon_na = [55, 90];    
lat_caf = [91, 110];  lon_caf = [175, 230]; 
lat_saf = [51, 76];   lon_saf = [195, 220];  
lat_boreal = [145, 155]; lon_boreal = [250, 300]; 
lat_ind = [80, 100];     lon_ind = [275, 310];    
lat_aus = [65, 77];     lon_aus = [292, 315];   
lat_amz = [75, 95];   lon_amz = [100, 125];   

regions = {
    struct('name', 'NA', 'lat', lat_na, 'lon', lon_na, 'color', [0.6 0.6 0.6]);
    struct('name', 'AMZ', 'lat', lat_amz, 'lon', lon_amz, 'color', [0.6 0.6 0.6]);
    struct('name', 'C-AF', 'lat', lat_caf, 'lon', lon_caf, 'color', [0.6 0.6 0.6]);
    struct('name', 'S-AF', 'lat', lat_saf, 'lon', lon_saf, 'color', [0.6 0.6 0.6]);
    struct('name', 'Boreal', 'lat', lat_boreal, 'lon', lon_boreal, 'color', [0.6 0.6 0.6]); 
    struct('name', 'IND', 'lat', lat_ind, 'lon', lon_ind, 'color', [0.3 0.3 0.3]);
    struct('name', 'AUS', 'lat', lat_aus, 'lon', lon_aus, 'color',[0.6 0.6 0.6]);
};

for i = 1:length(regions)
    reg = regions{i};
    lat_deg = [-90 + reg.lat(1) - 0.5, -90 + reg.lat(2) + 0.5];
    lon_deg = [-180 + reg.lon(1) - 0.5, -180 + reg.lon(2) + 0.5];
    m_plot([lon_deg(1), lon_deg(2), lon_deg(2), lon_deg(1), lon_deg(1)], ...
           [lat_deg(1), lat_deg(1), lat_deg(2), lat_deg(2), lat_deg(1)], ...
           '-', 'Color', reg.color, 'LineWidth', 0.8);
end

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


set(gca,'LineWidth',0.2);
hold on

c3 = colorbar('Position', [0.38 0.035 0.3 0.015], 'Orientation', 'horizontal');
set(c3, 'LineWidth', 0.2, 'FontSize', 9);
caxis([-15 15]);
set(c3, 'XTick', [-15 -10 -5 0 5 10 15]);
colormap(c3, J);  
xlabel(c3, 'mm month^{-1}', 'FontSize', 9);





%                                          

varNames = {'\DeltaW_d', '\DeltaP', '\DeltaT', '\DeltaE_s', '\DeltaE_i'};
scenarioLabels = {'Wa', 'P', 'T', 'E_{soi}', 'E_{veg}'};
barColors = {[138, 119, 185]/255}; % 红色(245), 蓝色(585)

% 设置透明度参数
barAlpha = 0.6;       % 柱状图透明度 (0-1，1为不透明)
scatterAlpha = 0.6;   % 散点图透明度 (0-1，1为不透明)
scatterSize = 40;     % 散点大小


h5 = axes('Position', [0.03,0.69,0.11,0.08]);

barHandle = bar(means_na_245', 'BarWidth', 0.6); 
hold on;

barHandle.FaceColor = barColors{1}; 
barHandle.FaceAlpha = barAlpha;  
xPositions = barHandle.XEndPoints;
for i = 1:5  
    errorbar(xPositions(i), means_na_245(1,i), stds_na_245(1,i), '.k', 'LineWidth', 1);
end
set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]);  

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);

set(gca, 'Color', 'none');  
set(gcf, 'Color', 'none');  

set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);       

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

ax.Box = 'off';
title('Northern North America','FontSize', 6,  'FontWeight', 'bold');
   


                                       
%


%
h6 = axes('Position', [0.03,0.31,0.11,0.08]);

barHandle = bar(means_na_585', 'BarWidth', 0.6); 
hold on;

barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha;  

xPositions = barHandle.XEndPoints;

for i = 1:5  
    errorbar(xPositions(i), means_na_585(1,i), stds_na_585(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]);  

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);

set(gca, 'Color', 'none');  
set(gcf, 'Color', 'none');  

set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);       

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'out'; 
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       


ax.Box = 'off';
title('Northern North America','FontSize', 6,  'FontWeight', 'bold');


%

%
h7 = axes('Position', [0.32,0.6,0.11,0.08]);

barHandle = bar(means_caf_245', 'BarWidth', 0.6); 
hold on;

barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha;  
xPositions = barHandle.XEndPoints;
for i = 1:5  
    errorbar(xPositions(i), means_caf_245(1,i), stds_caf_245(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]);  

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);


set(gca, 'Color', 'none');  
set(gcf, 'Color', 'none'); 
set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);       

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

ax.Box = 'off';
title('Central eastern Africa','FontSize', 6,  'FontWeight', 'bold');



                                       
%
h8 = axes('Position', [0.33,0.22,0.11,0.08]);
barHandle = bar(means_caf_585', 'BarWidth', 0.6); 
hold on;

barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha;  
xPositions = barHandle.XEndPoints;
for i = 1:5  
    errorbar(xPositions(i), means_caf_585(1,i), stds_caf_585(1,i), '.k', 'LineWidth', 1);
end
set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]);  
ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);

set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  

set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);       
ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

ax.Box = 'off';
title('Central eastern Africa','FontSize', 6,  'FontWeight', 'bold');





%
h9 = axes('Position', [0.39,0.45,0.11,0.08]);


barHandle = bar(means_saf_245', 'BarWidth', 0.6); 
hold on;


barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha;  

xPositions = barHandle.XEndPoints;

for i = 1:5  
    errorbar(xPositions(i), means_saf_245(1,i), stds_saf_245(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]);  

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10); 
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);



set(gca, 'Color', 'none');  
set(gcf, 'Color', 'none');  

set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);       

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

ax.Box = 'off';
title('Southern Africa','FontSize', 6,  'FontWeight', 'bold');




 
                                       
%
h10 = axes('Position', [0.39,0.07,0.11,0.08]);

barHandle = bar(means_saf_585', 'BarWidth', 0.6); 
hold on;

barHandle.FaceColor = barColors{1}; 
barHandle.FaceAlpha = barAlpha;  
xPositions = barHandle.XEndPoints;

for i = 1:5  
    errorbar(xPositions(i), means_saf_585(1,i), stds_saf_585(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]);  

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10); 

zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);


set(gca, 'Color', 'none');  
set(gcf, 'Color', 'none');  
set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);       

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

ax.XAxis.TickDirection = 'out'; 
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

ax.Box = 'off';
title('Southern Africa','FontSize', 6,  'FontWeight', 'bold');

                                       




%
h11 = axes('Position', [0.65,0.45,0.11,0.08]);
barHandle = bar(means_aus_245', 'BarWidth', 0.6); 
hold on;

barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha; 
xPositions = barHandle.XEndPoints;
for i = 1:5  
    errorbar(xPositions(i), means_aus_245(1,i), stds_aus_245(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]); 

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);


set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  
set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);      

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       



ax.Box = 'off';
title('Northern Australia','FontSize', 6,  'FontWeight', 'bold');


                                      
%

%
h12 = axes('Position', [0.65,0.07,0.1,0.08]);


barHandle = bar(means_aus_585', 'BarWidth', 0.6); 
hold on;
barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha; 
xPositions = barHandle.XEndPoints;
for i = 1:5     
    errorbar(xPositions(i), means_aus_585(1,i), stds_aus_585(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]); 


ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  

zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);

set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  



set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);      

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       



ax.Box = 'off';
title('Northern Australia','FontSize', 6,  'FontWeight', 'bold');






h13 = axes('Position', [0.88,0.58,0.11,0.08]);

barHandle = bar(means_ind_585', 'BarWidth', 0.6); 
hold on;
barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha; 
xPositions = barHandle.XEndPoints;
for i = 1:5     
    errorbar(xPositions(i), means_ind_245(1,i), stds_ind_245(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]); 

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);
set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  
set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);      

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

ax.Box = 'off';
title('Southeastern Asia','FontSize', 6,  'FontWeight', 'bold');



%


h14 = axes('Position', [0.88,0.2,0.11,0.08]);
barHandle = bar(means_ind_585', 'BarWidth', 0.6); 
hold on;
barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha; 
xPositions = barHandle.XEndPoints;
for i = 1:5    
    errorbar(xPositions(i), means_ind_585(1,i), stds_ind_585(1,i), '.k', 'LineWidth', 1);
end


set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]); 


ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  

zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);

set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  

set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);      

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

ax.Box = 'off';
title('Southeastern Asia','FontSize', 6,  'FontWeight', 'bold');                                  



h15 = axes('Position', [0.88,0.69,0.11,0.08]);
barHandle = bar(means_nb_245', 'BarWidth', 0.6); 
hold on;

barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha; 
xPositions = barHandle.XEndPoints;
for i = 1:5  
    errorbar(xPositions(i), means_nb_245(1,i), stds_nb_245(1,i), '.k', 'LineWidth', 1);
end
set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]); 

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  

zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);
set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  
set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);      

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

ax.Box = 'off';
title('Northern boreal','FontSize', 6,  'FontWeight', 'bold');

                                       


%
h16 = axes('Position', [0.88,0.31,0.11,0.08]);

barHandle = bar(means_nb_585', 'BarWidth', 0.6); 
hold on;

barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha; 
xPositions = barHandle.XEndPoints;
for i = 1:5    
    errorbar(xPositions(i), means_nb_585(1,i), stds_nb_585(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]); 

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);

set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  

set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);      

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       



ax.Box = 'off';
title('Northern boreal','FontSize', 6,  'FontWeight', 'bold');




                                        



h17 = axes('Position', [0.15,0.46,0.1,0.08]);
barHandle = bar(means_amz_245', 'BarWidth', 0.6); 
hold on;
barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha; 
xPositions = barHandle.XEndPoints;
for i = 1:5   
    errorbar(xPositions(i), means_amz_245(1,i), stds_amz_245(1,i), '.k', 'LineWidth', 1);
end

set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]); 

ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  

zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);


set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  


set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);      

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       



ax.Box = 'off';
title('Amzonia','FontSize', 6,  'FontWeight', 'bold');

                                       


h18 = axes('Position', [0.15,0.08,0.1,0.08]);

barHandle = bar(means_amz_585', 'BarWidth', 0.6); 
hold on;


barHandle.FaceColor = barColors{1};  
barHandle.FaceAlpha = barAlpha; 


xPositions = barHandle.XEndPoints;

for i = 1:5    
    errorbar(xPositions(i), means_amz_585(1,i), stds_amz_585(1,i), '.k', 'LineWidth', 1);
end



set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);
xlim([0.5, 5.5]); 


ylabel('Δ mm/month ');
ylim([-12 10]);
yticks(-10:5:10);  

zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);



set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none');  


set(gca, 'FontSize', 6 , 'Box', 'on');
grid off;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);      

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'out';  
ax.YAxis.TickDirection = 'out';  
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       


ax.Box = 'off';
title('Amzonia','FontSize', 6,  'FontWeight', 'bold');





%

filename='Figure1';
print(filename,'-dpng','-r300');






































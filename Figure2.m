
clear

load ..\cmip\his_ssp_mat_data_land\Figure2.mat

fig = figure
width=8.8
height=10
set(gcf,'position',[10 10 width*100 height*100])
h1 = axes('Position', [0.01,0.71,0.5,0.3]);
title('(a) ΔE SSP2-4.5', 'FontSize',12, 'FontWeight','bold');
data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_eva_245_his <= -15); mean_dif_eva_245_his(k) = -14;
k1 = find(isnan(mean_dif_eva_245_his)); mean_dif_eva_245_his(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_eva_245_his(i);  
        sig_map(row, col) = sig_dif_eva_245_his(i);        
    end
end

full_cmap = slanCM(97);

idx = [1:10:32, 33:10:64, 65:20:96, 97:30:128, 129:30:160, 161:20:192, 193:10:224, 225:10:256];         
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
    m_plot(sig_lon, sig_lat, '.k', 'MarkerSize', 1.5, 'MarkerFaceColor', 'k');
end

h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;
set(h1, 'Color', 'none'); 
m_grid('xaxis','off','yaxis','off',  'box', 'off',  'xtick',[],   'ytick',[], 'xticklabels',{}, 'yticklabels',{},'linestyle','none');    

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h1, "XColor", 'none', 'YColor', 'none', 'Color', 'none');



hold on




h2 = axes('Position', [0.51,0.71,0.5,0.3]); 
title('(b) ΔE SSP5-8.5', 'FontSize',12, 'FontWeight','bold');
data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_eva_585_his <= -15); mean_dif_eva_585_his(k) = -14;
k1 = find(isnan(mean_dif_eva_585_his)); mean_dif_eva_585_his(k1) = -15;

%
for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_eva_585_his(i);  
        sig_map(row, col) = sig_dif_eva_585_his(i);        
    end
end
full_cmap = slanCM(97);


idx = [1:2:32,  33:3:64,  65:8:96,  97:12:128,  129:12:160,  161:8:192, 193:3:224, 225:2:256];          


idx = round(idx);
idx = unique(idx(idx >=1 & idx <=256)); 

J = interp1(1:length(idx), full_cmap(idx,:), linspace(1,length(idx),127), 'linear');


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

grid on; box on
h = m_coast('line'); 
h.Color = [1 1 1]*0; 
h.LineWidth = 0.2;
set(h2, 'Color', 'none'); 
m_grid('xaxis','off','yaxis','off', 'box', 'off',  'xtick',[], 'ytick',[], 'xticklabels',{},  'yticklabels',{},'linestyle','none');        

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h2, "XColor", 'none', 'YColor', 'none', 'Color', 'none');

set(gca,'LineWidth',0.2);
hold on

c1 = colorbar('Position', [0.35 0.745 0.3 0.015], 'Orientation', 'horizontal');
set(c1, 'LineWidth', 0.2, 'FontSize', 10);
caxis([-15 15]);
set(c1, 'XTick', [-15 -10 -5 0 5 10 15]);

colormap(c1, J);  
xlabel(c1, 'mm month^{-1}', 'FontSize', 10);












%

h3 = subplot('Position', [0.08,0.385,0.4,0.3]); 

hold on;

title(h1, '(c) Land fractions for ΔE > ΔT(ΔP) under SSP2-4.5', 'FontSize',11, 'FontWeight','bold', 'FontName','Arial');

color_EandP = [138, 119, 185]/255;  
color_EandT = [219, 127, 142]/255;  
hold on;


y_range = [0.5, length(years)+0.5];

h22 = fill([a_245, b_245, b_245, a_245], ...
     [y_range(1), y_range(1), y_range(2), y_range(2)], ...
     color_EandT, 'FaceAlpha', 0.15, 'EdgeColor', 'none');

fill([c_245, d_245, d_245, c_245], ...
     [y_range(1), y_range(1), y_range(2), y_range(2)], ...
     color_EandP, 'FaceAlpha', 0.15, 'EdgeColor', 'none');

h11= plot([ET_245, ET_245], y_range, ...
     'Color', color_EandT, 'LineWidth', 2, 'LineStyle', '--');


plot([EP_245, EP_245], y_range, ...
     'Color', color_EandP, 'LineWidth', 2, 'LineStyle', '--');



for i = 1:length(years)
    x_line = linspace(ET245(i), EP245(i), 100);  
    y_line = repmat(i, 1, 100);
    colors = zeros(100, 3);
    for j = 1:100
        t = (j-1) / 99; 
        colors(j, :) = (1-t) * color_EandP + t * color_EandT;
    end
    patch(x_line, y_line, 'r', 'EdgeColor', 'interp', ...
          'LineWidth', 2, 'FaceVertexCData', colors, 'EdgeAlpha', 1);
    if i == 1
        h3 = scatter(EP245(i), i, 120, color_EandP, 'filled', ...
                    'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    else
        scatter(EP245(i), i, 120, color_EandP, 'filled', ...
                'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    end
    text(EP245(i)-0.3, i, sprintf('%.1f', EP245(i)), ...
         'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', ...
         'FontSize', 10, 'Color', color_EandP, 'FontWeight', 'bold');
end

for i = 1:length(years)
    if i == 1
        h2 = scatter(ET245(i), i, 120, color_EandT, 'filled', ...
                    'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    else
        scatter(ET245(i), i, 120, color_EandT, 'filled', ...
                'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    end
    text(ET245(i)+0.3, i, sprintf('%.1f', ET245(i)), ...
         'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', ...
         'FontSize', 10, 'Color', color_EandT, 'FontWeight', 'bold');
end

set(gca, 'YDir', 'reverse');  
 yticks(1:length(years));

yticklabels({'2020', '', '2040', '', '2060', '', '2080', '', '2100'});
ylim(y_range);
xlim([48, 56.5]);  
xlabel('Fraction (%) ', 'FontSize', 11, 'FontWeight', 'norm');
ylabel('Year', 'FontSize', 11, 'FontWeight', 'norm');

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

grid on;
set(gca, 'GridLineStyle', '--');     
set(gca, 'GridLineWidth', 1);         
set(gca, 'GridAlpha', 0.3);           
set(gca, 'GridColor', [0.5 0.5 0.5]); 

box on;
set(gca, 'FontSize', 11);
hold off;



h4 = subplot('Position', [0.57,0.385,0.4,0.3]); 

hold on;

title(h4, '(d) Land fractions for ΔE > ΔT(ΔP) under SSP5-8.5', 'FontSize',11, 'FontWeight','bold', 'FontName','Arial');
color_EandT = [138, 119, 185]/255;  
color_EandP = [219, 127, 142]/255;  
hold on;

y_range = [0.5, length(years)+0.5];

h22 = fill([a_585, b_585, b_585, a_585], ...
     [y_range(1), y_range(1), y_range(2), y_range(2)], ...
     color_EandT, 'FaceAlpha', 0.15, 'EdgeColor', 'none');

fill([c_585, d_585, d_585, c_585], ...
     [y_range(1), y_range(1), y_range(2), y_range(2)], ...
     color_EandP, 'FaceAlpha', 0.15, 'EdgeColor', 'none');

h11= plot([ET_585, ET_585], y_range, ...
     'Color', color_EandT, 'LineWidth', 2, 'LineStyle', '--');


plot([EP_585, EP_585], y_range, ...
     'Color', color_EandP, 'LineWidth', 2, 'LineStyle', '--');



for i = 1:length(years)
    x_line = linspace(ET585(i), EP585(i), 100);  
    y_line = repmat(i, 1, 100);
    colors = zeros(100, 3);
    for j = 1:100
        t = (j-1) / 99; 
        colors(j, :) = (1-t) * color_EandP + t * color_EandT;
    end
    patch(x_line, y_line, 'r', 'EdgeColor', 'interp', ...
          'LineWidth', 2, 'FaceVertexCData', colors, 'EdgeAlpha', 1);
    if i == 1
        h3 = scatter(EP585(i), i, 120, color_EandP, 'filled', ...
                    'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    else
        scatter(EP585(i), i, 120, color_EandP, 'filled', ...
                'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    end
    text(EP585(i)-0.3, i, sprintf('%.1f', EP585(i)), ...
         'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', ...
         'FontSize', 10, 'Color', color_EandP, 'FontWeight', 'bold');
end

for i = 1:length(years)
    if i == 1
        h2 = scatter(ET585(i), i, 120, color_EandT, 'filled', ...
                    'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    else
        scatter(ET585(i), i, 120, color_EandT, 'filled', ...
                'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    end
    text(ET585(i)+0.3, i, sprintf('%.1f', ET585(i)), ...
         'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', ...
         'FontSize', 10, 'Color', color_EandT, 'FontWeight', 'bold');
end

set(gca, 'YDir', 'reverse');  
 yticks(1:length(years));

yticklabels({'2020', '', '2040', '', '2060', '', '2080', '', '2100'});
ylim(y_range);
xlim([48, 56.5]);  
xlabel('Fraction (%) ', 'FontSize', 11, 'FontWeight', 'norm');
ylabel('Year', 'FontSize', 11, 'FontWeight', 'norm');

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

grid on;
set(gca, 'GridLineStyle', '--');     
set(gca, 'GridLineWidth', 1);         
set(gca, 'GridAlpha', 0.3);           
set(gca, 'GridColor', [0.5 0.5 0.5]); 

box on;
set(gca, 'FontSize', 11);
hold off;






h5 = subplot('Position', [0.08,0.06,0.4,0.25]); 
title('(e) Ta ~ ∆T(∆E) for northern boreal region', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');


tcolor =  [110/255, 158/255, 149/255];
ecolor = [219, 127, 142]/255;  
hold on;

h_t245 = scatter(tas245_boreal_gridmean, tran245_boreal_gridmean, 18, tcolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_e245 = scatter(tas245_boreal_gridmean, e245_boreal_gridmean, 18, ecolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);

h_t585 = scatter(tas585_boreal_gridmean, tran585_boreal_gridmean, 18, tcolor, ...
                 'MarkerEdgeColor', tcolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);
h_e585 = scatter(tas585_boreal_gridmean, e585_boreal_gridmean, 18, ecolor, ...
                 'MarkerEdgeColor', ecolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);

hold on

x_fit_245 = linspace(6.5, 9.5, 100);
x_fit_585 = linspace(6.5, 11.1, 100);

p_t245 = polyfit(tas245_boreal_gridmean, tran245_boreal_gridmean, 2);
y_t245 = polyval(p_t245, x_fit_245);

R_t245 = corrcoef(tas245_boreal_gridmean, tran245_boreal_gridmean);
R2_t245 = R_t245(1,2)^2;

h_fit_t245 = plot(x_fit_245, y_t245, '-', 'Color', tcolor, 'LineWidth', 2.5);


p_t585 = polyfit(tas585_boreal_gridmean, tran585_boreal_gridmean, 2);
y_t585 = polyval(p_t585, x_fit_585);
R_t585 = corrcoef(tas585_boreal_gridmean, tran585_boreal_gridmean);
R2_t585 = R_t585(1,2)^2;
h_fit_t585 = plot(x_fit_585, y_t585, '--', 'Color', tcolor, 'LineWidth', 2.5);


p_e245 = polyfit(tas245_boreal_gridmean, e245_boreal_gridmean, 2);
y_e245 = polyval(p_e245, x_fit_245);


R_e245 = corrcoef(tas245_boreal_gridmean, e245_boreal_gridmean);
R2_e245 = R_e245(1,2)^2;
h_fit_e245 = plot(x_fit_245, y_e245, '-', 'Color', ecolor, 'LineWidth', 2.5);

p_e585 = polyfit(tas585_boreal_gridmean, e585_boreal_gridmean, 2);
y_e585 = polyval(p_e585, x_fit_585);

R_e585 = corrcoef(tas585_boreal_gridmean, e585_boreal_gridmean);
R2_e585 = R_e585(1,2)^2;
h_fit_e585 = plot(x_fit_585, y_e585, '--', 'Color', ecolor, 'LineWidth', 2.5);

text(8, 5, sprintf('R^2=%.2f', R2_t245), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');
text(10.8, 6.3, sprintf('R^2=%.2f', R2_t585), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', tcolor);

text(8, -1.2, sprintf('R^2=%.2f', R2_e245), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');
text(11, 2.5, sprintf('R^2=%.2f', R2_e585), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', ecolor);

ylim([-2, 7]);
yticks(-2:2:7);
ylabel(' ∆T(∆E) (mm/month)');

xlabel('Ta (°C)');
xlim([6 12]);
xticks(6:1:12);

legend([h_t245, h_t585, h_e245, h_e585], ...
       {'T (SSP2-4.5)', 'T (SSP5-8.5)', 'E (SSP2-4.5)', 'E (SSP5-8.5)'}, ...
       'Location', 'southeast', 'FontSize', 8, 'NumColumns', 1);
legend('box', 'off');

grid on;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.2);
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1);

hold off;




h6 = axes('Position', [0.57,0.06,0.4,0.25]); 

title('(f) Ta ~ ∆T(∆E) for central-east Africa region', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');

tcolor =  [110/255, 158/255, 149/255];
ecolor = [219, 127, 142]/255;  % 粉红色

hold on
h_t245 = scatter(tas245_caf_gridmean, tran245_caf_gridmean, 18, tcolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_e245 = scatter(tas245_caf_gridmean, e245_caf_gridmean, 18, ecolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_t585 = scatter(tas585_caf_gridmean, tran585_caf_gridmean, 18, tcolor, ...
                 'MarkerEdgeColor', tcolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);
h_e585 = scatter(tas585_caf_gridmean, e585_caf_gridmean, 18, ecolor, ...
                 'MarkerEdgeColor', ecolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);
hold on;

x_fit_245 = linspace(25.8, 28, 100);
x_fit_585 = linspace(25.8, 30.5, 100);
p_t245 = polyfit(tas245_caf_gridmean, tran245_caf_gridmean, 1);
y_t245 = polyval(p_t245, x_fit_245);
R_t245 = corrcoef(tas245_caf_gridmean, tran245_caf_gridmean);
R2_t245 = R_t245(1,2)^2;
h_fit_t245 = plot(x_fit_245, y_t245, '-', 'Color', tcolor, 'LineWidth', 2.5);
p_t585 = polyfit(tas585_caf_gridmean, tran585_caf_gridmean, 2);
y_t585 = polyval(p_t585, x_fit_585);
R_t585 = corrcoef(tas585_caf_gridmean, tran585_caf_gridmean);
R2_t585 = R_t585(1,2)^2;
h_fit_t585 = plot(x_fit_585, y_t585, '--', 'Color', tcolor, 'LineWidth', 2.5);

p_e245 = polyfit(tas245_caf_gridmean, e245_caf_gridmean, 1);
y_e245 = polyval(p_e245, x_fit_245);

R_e245 = corrcoef(tas245_caf_gridmean, e245_caf_gridmean);
R2_e245 = R_e245(1,2)^2;

h_fit_e245 = plot(x_fit_245, y_e245, '-', 'Color', ecolor, 'LineWidth', 2.5);
p_e585 = polyfit(tas585_caf_gridmean, e585_caf_gridmean, 1);
y_e585 = polyval(p_e585, x_fit_585);
R_e585 = corrcoef(tas585_caf_gridmean, e585_caf_gridmean);
R2_e585 = R_e585(1,2)^2;
h_fit_e585 = plot(x_fit_585, y_e585, '--', 'Color', ecolor, 'LineWidth', 2.5);

text(26.5, -4, sprintf('R^2=%.2f', R2_t245), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');
text(29, -7, sprintf('R^2=%.2f', R2_t585), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', tcolor);
text(26, 7, sprintf('R^2=%.2f', R2_e245), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');
text(30, 2, sprintf('R^2=%.2f', R2_e585), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', ecolor);


ylim([-11, 11]);
yticks(-8:4:8);

xlabel('Ta (°C)');
xlim([25.5 31]);
xticks(26:1:31);

grid on;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.2);
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1);

hold off;



filename='Figure2';
print(filename,'-dpng','-r300');





































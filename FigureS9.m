
clear
load ..\cmip\his_ssp_mat_data_land\FigureS9.mat


fig = figure
width=8.8
height=6
set(gcf,'position',[10 10 width*100 height*100])



%
h1 = subplot('Position', [0.01,0.48,0.5,0.6]); 
set(gcf, 'Color', 'white');  

site_loc = [coor_z(:,2) coor_z(:,1)];

title('(a) R for sites in all months', 'FontSize', 12, 'FontWeight', 'bold');

gd = 1;
a = -180 + gd/2 :gd : 180 - gd/2;  
b = -90 + gd/2 :gd : 90 - gd/2;    
[lon, lat] = meshgrid(a, b);


m_proj('robinson','lat',[-60 90],'long',[-180 180]);


hold on;
h = m_coast('line'); 
h.Color = [0.6 0.6 0.6];  
h.LineWidth = 0.5;


s = m_scatter(site_loc(:,1), site_loc(:,2), 30, R_site, 'filled', ...
    'MarkerEdgeColor', 'k', 'LineWidth', 0.1);
s.MarkerFaceAlpha = 0.8;  


J = cbrewer2('div','RdBu',200,'linear');
colormap(h1, J);  
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
set(h1, "XColor", 'none', 'YColor', 'none');



                                                           
%
h2 = axes('Position', [0.5,0.48,0.5,0.6]);
set(gcf, 'Color', 'white');  

site_loc = [coor_z(:,2) coor_z(:,1)];


valid_idx = ~isnan(R_site); 
site_loc_valid = site_loc(valid_idx, :); 
R_site_valid = R_site(valid_idx);  


gd = 1;
a = -180 + gd/2 :gd : 180 - gd/2;  
b = -90 + gd/2 :gd : 90 - gd/2;    
[lon, lat] = meshgrid(a, b);


m_proj('robinson','lat',[-60 90],'long',[-180 180]);


hold on;
title('(b) R for sites during dry season', 'FontSize', 12, 'FontWeight', 'bold');


h = m_coast('line'); 
h.Color = [0.6 0.6 0.6];  
h.LineWidth = 0.5;

s = m_scatter(site_loc_valid(:,1), site_loc_valid(:,2), 30, R_site_valid, 'filled', ... 
    'MarkerEdgeColor', 'k', 'LineWidth', 0.1);
s.MarkerFaceAlpha = 0.8;  

 
J = cbrewer2('div','RdBu',200,'linear');
colormap(h2, J);  
caxis([0 1]);

set(h2, 'Color', 'none');  
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h2, "XColor", 'none', 'YColor', 'none');


c4 = colorbar('southoutside', 'Position', [0.4, 0.57, 0.3, 0.03]);
c4.Ticks = [0, 0.25, 0.5, 0.75, 1];
c4.FontSize = 10;
c4.LineWidth = 0.5;
c4.Label.String = 'R';           
c4.Label.FontSize = 8;



%
h3 = axes('Position', [0.06,0.1,0.26,0.35]);

max_rmse = max([max(RMSE_valid), max(RMSE_sum_valid)]);
edges_RMSE = linspace(0, max_rmse, 11);


[counts_all_rmse, ~] = histcounts(RMSE_valid, edges_RMSE, 'Normalization', 'percentage');
[counts_sum_rmse, ~] = histcounts(RMSE_sum_valid, edges_RMSE, 'Normalization', 'percentage');

[f_all_rmse, xi_all_rmse] = ksdensity(RMSE_valid, 'NumPoints', 200);
[f_sum_rmse, xi_sum_rmse] = ksdensity(RMSE_sum_valid, 'NumPoints', 200);

bin_width_rmse = edges_RMSE(2) - edges_RMSE(1);
scale_all_rmse = sum(counts_all_rmse) * bin_width_rmse / trapz(xi_all_rmse, f_all_rmse);
scale_sum_rmse = sum(counts_sum_rmse) * bin_width_rmse / trapz(xi_sum_rmse, f_sum_rmse);

f_all_rmse_scaled = f_all_rmse * scale_all_rmse;
f_sum_rmse_scaled = f_sum_rmse * scale_sum_rmse;



fill([xi_all_rmse, fliplr(xi_all_rmse)], [f_all_rmse_scaled, zeros(size(f_all_rmse_scaled))], ...
    color_all, ...
    'FaceAlpha', 0.5, ...      
    'EdgeColor', color_all, ...
    'EdgeAlpha', 0.99, ...      
    'LineWidth', 1.5);
hold on;

fill([xi_sum_rmse, fliplr(xi_sum_rmse)], [f_sum_rmse_scaled, zeros(size(f_sum_rmse_scaled))], ...
    color_sum, ...
    'FaceAlpha', 0.5, ...      
    'EdgeColor', color_sum, ...
    'EdgeAlpha', 0.99, ...      
    'LineWidth', 1.5);

hold off;

xlabel('RMSE', 'FontSize', 12);
ylabel('Frequency (%)', 'FontSize', 12);
title('(c) Distribution of RMSE', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
box on;
xlim([0 8]);
ylim([0 40]);


legend({'All months', 'Dry season'}, ...
    'Location', 'northeast', 'FontSize', 10);


%
h4 = subplot('Position', [0.39,0.1,0.26,0.35]); 



s = scatter(x, y, 30, [146 165 209]/255, 'filled');
s.MarkerFaceAlpha = 0.5;        
s.MarkerEdgeColor = 'k';       
s.MarkerEdgeAlpha = 0.8;       
s.LineWidth = 0.2;              

grid on;
box on;
xlabel('E_{obs} (mm/month)', FontSize = 12);
ylabel('E_{fit} (mm/month)', FontSize=12);
xlim([-2 40]);
ylim([-2 40]);
title('(d) E for all month', 'FontSize', 12, 'FontWeight', 'bold');


hold on;
xy_min = min([x; y]);
xy_max = max([x; y]);
plot([xy_min, xy_max], [xy_min, xy_max], '--', 'Color', [146 165 209]/255, 'LineWidth', 1.2);
legend('Data','1:1 line','Location','southeast');

txtStr = sprintf('RMSE = %.2f\nR = %.2f\n%s', RMSE, R, pStr);
text(xy_min + 0.05*(xy_max - xy_min), ...
     xy_max - 0.05*(xy_max - xy_min), ...
     txtStr, ...
     'FontSize', 10, ...
     'BackgroundColor', 'none', ...
     'EdgeColor', 'none', ...
     'Interpreter', 'none');

hold off;



%
h5 = subplot('Position', [0.72,0.1,0.26,0.35]); 
s = scatter(x, y, 36, [217 185 212] / 255, 'filled');


s.MarkerFaceAlpha = 0.5;        
s.MarkerEdgeColor = 'k';        
s.MarkerEdgeAlpha = 0.8;       
s.LineWidth = 0.2;              



grid on;
box on;
xlabel('E_{obs} (mm/month)', FontSize= 12);
ylabel('E_{fit} (mm/month)', FontSize=12);
xlim([-2 30]);
ylim([-2 30]);
title('(e) E during dry season', 'FontSize', 12, 'FontWeight', 'bold');


hold on;
xy_min = min([x; y]);
xy_max = max([x; y]);
plot([xy_min, xy_max], [xy_min, xy_max], '--', 'Color', [217 185 212]/255, 'LineWidth', 1.2);
legend('Data','1:1 line','Location','southeast');


txtStr = sprintf('RMSE = %.2f\nR = %.2f\n%s', RMSE, R, pStr);
text(xy_min + 0.05*(xy_max - xy_min), ...
     xy_max - 0.03*(xy_max - xy_min), ...
     txtStr, ...
     'FontSize', 10, ...
     'BackgroundColor', 'none', ...
     'EdgeColor', 'none', ...
     'Interpreter', 'none');

hold off;




filename='FigureS9'

print(filename,'-dpng','-r300')





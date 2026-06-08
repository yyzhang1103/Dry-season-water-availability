
clear

load ..\E\cmip\his_ssp_mat_data_land\figure3.mat


% 
figure
width=8.8
height=6
set(gcf,'position',[10 10 width*100 height*100])


%

h1 = axes('Position', [0.025,0.48,0.45,0.6]); 

title('(a) Δln(f_{245})', 'FontSize', 12, 'FontWeight', 'bold');


axes(h1); 
data_map1 = nan(180, 360); 
sig_map1 = nan(180, 360);  
load kland_1d.mat

k = find(dif_ln_f_245_his <= 0); dif_ln_f_245_his(k) = 0.1;
k1 = find(isnan(dif_ln_f_245_his)); dif_ln_f_245_his(k1) = 0;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map1(row, col) = dif_ln_f_245_his(i);  
        sig_map1(row, col) = sig_f245_fhis_max(i);        
    end
end



full_cmap = flip(slanCM(98)); %


ava_colormap = full_cmap;


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
set(gca, 'colormap',[1 1 1]*.75); 
freezeColors;


m_pcolor(lon, lat, data_map1);
caxis([0 0.5]);
colormap(h1,  [[1 1 1]*0.8; ava_colormap]);

[sig_row, sig_col] = find(sig_map1 == 1);
if ~isempty(sig_row)
    
    step = 4;  
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



h_coast = m_coast('line'); 
h_coast.Color = [0 0 0]; 
h_coast.LineWidth = 0.2;


m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'gridcolor',[0.8 0.8 0.8], ... 
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         
lat_na = [140, 155];   
lon_na = [55, 90];     
lat_caf = [91, 110];   
lon_caf = [175, 230];  
lat_saf = [51, 76];    
lon_saf = [195, 220];  
lat_boreal = [145, 155]; 
lon_boreal = [250, 300]; 
lat_ind = [80, 100];     
lon_ind = [275, 310];    
lat_aus = [65, 77];     
lon_aus = [292, 315];    
lat_amz = [75, 95];    
lon_amz = [100, 125];   
regions = {
    struct('name', 'NA', 'lat', lat_na, 'lon', lon_na, 'color', [0.5 0.5 0.5]);
    struct('name', 'AMZ', 'lat', lat_amz, 'lon', lon_amz, 'color', [0.5 0.5 0.5]);
    struct('name', 'C-AF', 'lat', lat_caf, 'lon', lon_caf, 'color', [0.5 0.5 0.5]);
    struct('name', 'S-AF', 'lat', lat_saf, 'lon', lon_saf, 'color', [0.5 0.5 0.5]);
    struct('name', 'Boreal', 'lat', lat_boreal, 'lon', lon_boreal, 'color', [0.5 0.5 0.5]);
    struct('name', 'IND', 'lat', lat_ind, 'lon', lon_ind, 'color', [0.55 0.55 0.55]);
    struct('name', 'AUS', 'lat', lat_aus, 'lon', lon_aus, 'color', [0.5 0.5 0.5]);
};





set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h1, "XColor", 'none', 'YColor', 'none', 'Color', 'none');

c1 = colorbar('southoutside');
delete (c1)
hold on;



%% 
h2 = axes('Position', [0.525,0.48,0.45,0.6]);
title('(b) Δln(f_{585})', 'FontSize', 12, 'FontWeight', 'bold');


axes(h2); 
data_map3 = nan(180, 360); 
sig_map3 = nan(180, 360);  


k = find(dif_ln_f_585_his <= 0); dif_ln_f_585_his(k) = 0.1;
k = find(isnan(dif_ln_f_585_his)); dif_ln_f_585_his(k) = 0;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map3(row, col) = dif_ln_f_585_his(i);  
        sig_map3(row, col) = sig_f585_fhis_max(i);        
    end
end


m_proj('robinson','lat',[-60 90],'long',[-180 180]);


A = nan(180,360); 
A(kland_1d) = 1; 
A(:,1) = A(:,end);


hold on
m_pcolor(lon, lat, A);
shading flat;
set(gca, 'colormap',[1 1 1]*.75); 
freezeColors;


m_pcolor(lon, lat, data_map3);
caxis([0 0.5]);
colormap(h2,  [[1 1 1]*0.8; ava_colormap]);



[sig_row, sig_col] = find(sig_map3 == 1);  
if ~isempty(sig_row)
    
    step = 4; 
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


h_coast = m_coast('line'); 
h_coast.Color = [0 0 0]; 
h_coast.LineWidth = 0.2;


m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'gridcolor',[0.8 0.8 0.8], ... 
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');        
lat_na = [140, 155];  
lon_na = [55, 90];     
lat_caf = [91, 110];   
lon_caf = [175, 230];  
lat_saf = [51, 76];    
lon_saf = [195, 220];  
lat_boreal = [145, 155]; 
lon_boreal = [250, 300]; 
lat_ind = [80, 100];     
lon_ind = [275, 310];   
lat_aus = [65, 77];      
lon_aus = [292, 315];    
lat_amz = [75, 95];    
lon_amz = [100, 125];   
regions = {
    struct('name', 'NA', 'lat', lat_na, 'lon', lon_na, 'color', [0.5 0.5 0.5]);
    struct('name', 'AMZ', 'lat', lat_amz, 'lon', lon_amz, 'color', [0.5 0.5 0.5]);
    struct('name', 'C-AF', 'lat', lat_caf, 'lon', lon_caf, 'color', [0.5 0.5 0.5]);
    struct('name', 'S-AF', 'lat', lat_saf, 'lon', lon_saf, 'color', [0.5 0.5 0.5]);
    struct('name', 'Boreal', 'lat', lat_boreal, 'lon', lon_boreal, 'color', [0.5 0.5 0.5]);
    struct('name', 'IND', 'lat', lat_ind, 'lon', lon_ind, 'color', [0.55 0.55 0.55]);
    struct('name', 'AUS', 'lat', lat_aus, 'lon', lon_aus, 'color', [0.5 0.5 0.5]);
};






set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h2, "XColor", 'none', 'YColor', 'none', 'Color', 'none');

c11 = colorbar('southoutside');
delete (c11)
set(gca,'LineWidth',0.5);
hold on;


c1 = colorbar('Position', [0.38 0.6 0.3 0.03], 'Orientation', 'horizontal');

set(c1, 'LineWidth', 0.2, 'FontSize', 9);
caxis([0 0.5]);
set(c1, 'XTick', [0 0.25 0.5]);


colormap(c1, ava_colormap);  




%%                                                    
h3 = axes('Position', [0.056,0.175,0.43,0.3]);
barHandle = bar(means', 'grouped');
hold on;

for i = 1:2
    barHandle(i).FaceColor = barColors{i};
    barHandle(i).FaceAlpha = barAlpha;  
end


barHandle(1).FaceColor = barColors{1};
barHandle(2).FaceColor = barColors{2};


xPositions = zeros(4, 2); 
for i = 1:2
    xPositions(:,i) = barHandle(i).XEndPoints;
end

for i = 1:4 
    for j = 1:2  
        errorbar(xPositions(i,j), means(j,i), stds(j,i), '.k', 'LineWidth', 1);
       
    end
end



set(gca, 'XTick', 1:length(varNames), 'XTickLabel', varNames);


ylabel('Contribution ');
ylim([-0.5 0.3]);
yticks(-0.3:0.3:0.3);  
zeroLine = line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 0.5);


lgd = legend(scenarioLabels, 'Orientation', 'vertical', 'location', 'southwest', 'box', 'off');


set(gca, 'FontSize', 10 , 'Box', 'on');
set(lgd, 'Box', 'off');  
grid on;
set(gca, 'GridLineStyle', '--');  
set(gca, 'GridAlpha', 0.5);       
box on;

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;


ax.XAxis.TickDirection = 'in';  
ax.YAxis.TickDirection = 'in'; 
ax.XAxisLocation = 'bottom';     
ax.YAxisLocation = 'left';       

title('(c) Contributions on ΔE','FontSize', 10,  'FontWeight', 'bold');


                                                
%  
h4 =axes('Position', [0.49,0.6,0.45,0.12]);
start_year = 2015;
end_year = 2100;
years_actual = start_year:(end_year-start_year)/(length(f245_data)-1):end_year;



custom_color = [138, 119, 185]/255;


yyaxis left
hold on;
scatter(years_actual, f245_data, 20, custom_color, 'filled', 'MarkerFaceAlpha', 0.5); 
ylabel('{\it f}');


ylim([0.98 1.1]);
yticks([0.98:0.02:1.1]); 
ax = gca;
ax.YAxis(1).Color = 'k'; 
yyaxis right
hold on;

scatter(years_actual, tas_vector_245, 20, 'MarkerEdgeColor', custom_color, 'LineWidth', 1); 
ylabel('Ta (°C)');
ax = gca;
ax.YAxis(2).Color = 'k'; 
ylim([13.5 17]);
yticks([14:1:17]);
xlim([2010, 2105]);
xticks([2020, 2040, 2060, 2080, 2100]); 
set(gca, 'XTickMode', 'manual');
set(gca, 'LineWidth', 1);

box on;


set(gca, 'GridLineStyle', '-');  
set(gca, 'GridAlpha', 0.2);     
set(gca, 'FontSize', 8);      
title('(d) Annual {\it f}_{245} / {\it f}_{his} and Ta', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('Year');


h5 = axes('Position', [0.49,0.44,0.45,0.12]);
start_year = 2015;
end_year = 2100;
years_actual = start_year:(end_year-start_year)/(length(f585_data)-1):end_year;


custom_color =  [219, 127, 142]/255;


yyaxis left
hold on;
h6 = scatter(years_actual, f585_data, 20, custom_color, 'filled', 'MarkerFaceAlpha', 0.5);
ylabel('{\it f}');
ylim([1.05 1.4]);  
yticks([1.05:0.05:1.4]);  
ax = gca;
ax.YAxis(1).Color = 'k'; 

yyaxis right
hold on;
h7 = scatter(years_actual, tas_vector_585, 20, 'MarkerEdgeColor', custom_color, 'LineWidth', 1);
ylabel('Ta (°C)');
ax = gca;
ax.YAxis(2).Color = 'k'; 
ylim([13 19.2]);
yticks([13, 14, 15, 16, 17,18,19]);
set(gca, 'YTickMode', 'manual');

xlim([2010, 2105]);
xticks([2020, 2040, 2060, 2080, 2100]); 
set(gca, 'XTickMode', 'manual');
set(gca, 'LineWidth', 1);
box on;

lgd = legend([h6, h7], ...
    {'{\it f}_{585} / {\it f}_{his}', 'Ta_{585}'}, ...
    'Location', 'northwest');
legend('box', 'off');

set(gca, 'GridLineStyle', '-');  
set(gca, 'GridAlpha', 0.2);      
set(gca, 'FontSize', 8);      


title('(e) Annual {\it f}_{585} / {\it f}_{his} and Ta', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('Year');


%%


filename='Figure3'
print(filename,'-dpng','-r300')








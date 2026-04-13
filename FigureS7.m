
clear


load ..\cmip\his_ssp_mat_data_land\FigureS7.mat

%
fig =figure
width=8.8
height=10
set(gcf,'position',[10 10 width*100 height*100])


%                                  
h1 = axes('Position', [0.45,0.56, 0.4, 0.3]);

load kland_1d_0805.mat
title('(b)\Deltaln({\it\alpha}A_{585})', 'FontSize', 9, 'FontWeight', 'bold');


axes(h1); 
data_map3 = nan(180, 360); 
sig_map3 = nan(180, 360);  
k = find(dif_ln_A_585_his <= -0.5); dif_ln_A_585_his(k) = -0.4;
k = find(isnan(dif_ln_A_585_his)); dif_ln_A_585_his(k) = -0.5;
% 
for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map3(row, col) = dif_ln_A_585_his(i);  
        sig_map3(row, col) = sig_dif_A_585_his(i);        
    end
end


gd = 1;
a = -180 + gd/2 :gd : 180 - gd/2;  
b = -90 + gd/2 :gd : 90 - gd/2;    
[lon,lat] = meshgrid(a, b);

full_cmap = slanCM(98);


ava_colormap = full_cmap;


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
caxis([-0.5 0.5]);
colormap(h1,  [[1 1 1]*0.8; ava_colormap]);

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
    'gridcolor',[0.5 0.5 0.5], ... 
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h1, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


hold on;

%
h2 = axes('Position', [0.45,0.38,0.4,0.3]);
title('(d)\Deltaln({\itS}_{585})', 'FontSize', 9, 'FontWeight', 'bold');


axes(h2); 
data_map3 = nan(180, 360); 
sig_map3 = nan(180, 360);  
k = find(dif_ln_sm_585_his <= -0.5); dif_ln_sm_585_his(k) = -0.4;
k = find(isnan(dif_ln_sm_585_his)); dif_ln_sm_585_his(k) = -0.5;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map3(row, col) =dif_ln_sm_585_his(i);  
        sig_map3(row, col) = sig_dif_sm_585_his(i);        
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
caxis([-0.5 0.5]);
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
    'gridcolor',[0.5 0.5 0.5], ... 
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h2, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


set(gca,'LineWidth',0.5);
hold on;



%                                     
h3 = axes('Position', [0.45,0.2,0.4,0.3]); 
title('(f)  Δ-{\itk}LAI_{585}', 'FontSize', 9, 'FontWeight', 'bold');

axes(h3); 
data_map7 = nan(180, 360); 
sig_map7 = nan(180, 360);  

k = find(dif_ln_lai_585_his <= -0.5); dif_ln_lai_585_his(k) = -0.4;
k1 = find(isnan(dif_ln_lai_585_his)); dif_ln_lai_585_his(k1) = -0.5;


for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map7(row, col) = dif_ln_lai_585_his(i);  
        sig_map7(row, col) = sig_dif_lai_585_his(i);    
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


m_pcolor(lon, lat, data_map7);
caxis([-0.5 0.5]);
colormap(h3,  [[1 1 1]*0.8; ava_colormap]);


[sig_row, sig_col] = find(sig_map7 == 1);  
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
h_coast.LineWidth = 0.1;


m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'gridcolor',[0.5 0.5 0.5], ... 
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h3, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


set(gca,'LineWidth',0.5);
hold on;
%

h4 = axes('Position', [0.1,0.56,0.4,0.3]); 
title('(a)\Deltaln({\it\alpha}A_{245})', 'FontSize', 9, 'FontWeight', 'bold');


axes(h4); 


data_map1 = nan(180, 360); 
sig_map1 = nan(180, 360);  
load kland_1d.mat

k = find(dif_ln_A_245_his <= -0.5); dif_ln_A_245_his(k) = -0.4;
k1 = find(isnan(dif_ln_A_245_his)); dif_ln_A_245_his(k1) = -0.5;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map1(row, col) = dif_ln_A_245_his(i);  
        sig_map1(row, col) = sig_dif_A_245_his(i);        
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


m_pcolor(lon, lat, data_map1);
caxis([-0.5 0.5]);
colormap(h4,  [[1 1 1]*0.8; ava_colormap]);


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
    'gridcolor',[0.5 0.5 0.5], ... 
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');        

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h4, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


hold on;

%
h5 = axes('Position', [0.1,0.38,0.4,0.3]);

title('(c)\Deltaln({\itS}_{245})', 'FontSize', 9, 'FontWeight', 'bold');

axes(h5); 
data_map3 = nan(180, 360); 
sig_map3 = nan(180, 360);  
k = find(dif_ln_sm_245_his <= -0.5); dif_ln_sm_245_his(k) = -0.4;
k = find(isnan(dif_ln_sm_245_his)); dif_ln_sm_245_his(k) = -0.5;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map3(row, col) =dif_ln_sm_245_his(i);  
        sig_map3(row, col) = sig_dif_sm_245_his(i);        
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
caxis([-0.5 0.5]);
colormap(h5,  [[1 1 1]*0.8; ava_colormap]);

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
    'gridcolor',[0.5 0.5 0.5], ... 
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');        

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h5, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


set(gca,'LineWidth',0.5);
hold on;



% 
h6 = axes('Position', [0.1,0.2,0.4,0.3]);


title('(e)  Δ-{\itk}LAI_{245}', 'FontSize', 9, 'FontWeight', 'bold');

axes(h6); 
data_map5 = nan(180, 360); 
sig_map5 = nan(180, 360);  
k = find(dif_ln_lai_245_his <= -0.5); dif_ln_lai_245_his(k) = -0.4;
k1 = find(isnan(dif_ln_lai_245_his)); dif_ln_lai_245_his(k1) = -0.5;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map5(row, col) = dif_ln_lai_245_his(i);  
        sig_map5(row, col) = sig_dif_lai_245_his(i);        
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

m_pcolor(lon, lat, data_map5);
caxis([-0.5 0.5]);
colormap(h6,  [[1 1 1]*0.8; ava_colormap]);

[sig_row, sig_col] = find(sig_map5 == 1);  
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
h_coast.LineWidth = 0.1;


m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'gridcolor',[0.5 0.5 0.5], ... 
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');        

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h6, "XColor", 'none', 'YColor', 'none', 'Color', 'none');

set(gca,'LineWidth',0.5);
hold on;


%  
c1 = colorbar('Position', [0.35 0.25 0.3 0.015], 'Orientation', 'horizontal');
set(c1, 'LineWidth', 0.2, 'FontSize', 9);
caxis([-0.5 0.5]);
set(c1, 'XTick', [-0.5 -0.25 0 0.25 0.5]);
colormap(c1, ava_colormap);  
% 
filename='FigureS7.png'
exportgraphics(fig, filename, 'Resolution', 300);






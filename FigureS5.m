

clear

load ..\cmip\his_ssp_mat_data_land\FigureS5.mat



fig = figure
width=8.8
height=10
set(gcf,'position',[10 10 width*100 height*100])


% 
h1 = axes('Position', [0.45,0.02,0.4,0.3]); 

title('(h) ΔE_s SSP5-8.5', 'FontSize',12, 'FontWeight','bold');



data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_Esoil_585_his <= -14); mean_dif_Esoil_585_his(k) = -14;
k1 = find(isnan(mean_dif_Esoil_585_his)); mean_dif_Esoil_585_his(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_Esoil_585_his(i);  
        sig_map(row, col) = sig_dif_Esoil_585_his(i);        
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



set(gca,'LineWidth',0.2);

hold on





%
h2 = axes('Position', [0.45,0.2,0.4,0.3]);
title('(f) ΔE_i SSP5-8.5', 'FontSize',12, 'FontWeight','bold');


data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_Eveg_585_his <= -14); mean_dif_Eveg_585_his(k) = -14;
k1 = find(isnan(mean_dif_Eveg_585_his)); mean_dif_Eveg_585_his(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_Eveg_585_his(i);  
        sig_map(row, col) = sig_dif_Eveg_585_his(i);        
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



hold on
%

h3 = axes('Position', [0.45,0.38,0.4,0.3]); 
title('(d) ΔT SSP5-8.5', 'FontSize',12, 'FontWeight','bold');


data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_tran_585_his <= -14); mean_dif_tran_585_his(k) = -14;
k1 = find(isnan(mean_dif_tran_585_his)); mean_dif_tran_585_his(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_tran_585_his(i);  
        sig_map(row, col) = sig_dif_tran_585_his(i);        
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



set(gca,'LineWidth',0.2);

hold on





% 

h4 = axes('Position', [0.45,0.56,0.4,0.3]); 
title('(b) ΔP SSP5-8.5', 'FontSize',12, 'FontWeight','bold');

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_pr_585_his <= -14); mean_dif_pr_585_his(k) = -14;
k = find(isnan(mean_dif_pr_585_his)); mean_dif_pr_585_his(k) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_pr_585_his(i);  
        sig_map(row, col) = sig_dif_pr_585_his(i);        
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

hold on



















%


h5 = axes('Position', [0.1,0.02,0.4,0.3]); 
title('(g) ΔE_s SSP2-4.5', 'FontSize',12, 'FontWeight','bold');

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_Esoil_245_his <= -14); mean_dif_Esoil_245_his(k) = -14;
k1 = find(isnan(mean_dif_Esoil_245_his)); mean_dif_Esoil_245_his(k1) = -15;


for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_Esoil_245_his(i);  
        sig_map(row, col) = sig_dif_Esoil_245_his(i);        
    end
end



full_cmap = slanCM(97);


idx = [1:10:32, ...           
       33:10:64, ...        
       65:20:96, ...         
       97:30:128, ...         
       129:30:160, ...       
       161:20:192, ...        
       193:10:224, ...       
       225:10:256];          

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

    
    m_plot(sig_lon, sig_lat, '.k', 'MarkerSize', 1.5, 'MarkerFaceColor', 'k');
    
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



hold on
% 


%

h6 = axes('Position', [0.1,0.2,0.4,0.3]);

title('(e) ΔE_i SSP2-4.5', 'FontSize',12, 'FontWeight','bold');

data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_Eveg_245_his <= -14); mean_dif_Eveg_245_his(k) = -14;
k1 = find(isnan(mean_dif_Eveg_245_his)); mean_dif_Eveg_245_his(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_Eveg_245_his(i);  
        sig_map(row, col) = sig_dif_Eveg_245_his(i);        
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
caxis([-15 15]);
colormap(h6,  [[1 1 1]*0.8; J]);


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

set(h6, 'Color', 'none'); 
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h6, "XColor", 'none', 'YColor', 'none', 'Color', 'none');


set(gca,'LineWidth',0.5);

hold on

%


h7 = axes('Position', [0.1,0.38,0.4,0.3]); 
title('(c) ΔT SSP2-4.5', 'FontSize',12, 'FontWeight','bold');


data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_tran_245_his <= -14); mean_dif_tran_245_his(k) = -14;
k1 = find(isnan(mean_dif_tran_245_his)); mean_dif_tran_245_his(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_tran_245_his(i);  
        sig_map(row, col) = sig_dif_tran_245_his(i);        
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
caxis([-15 15]);
colormap(h7,  [[1 1 1]*0.8; J]);

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

set(h7, 'Color', 'none');
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h7, "XColor", 'none', 'YColor', 'none', 'Color', 'none');



set(gca,'LineWidth',0.5);


hold on


%

h8 = axes('Position', [0.1,0.56,0.4,0.3]); 

title('(a) ΔP SSP2-4.5', 'FontSize',12, 'FontWeight','bold');


data_map = nan(180, 360); 
sig_map = nan(180, 360);  
load kland_1d.mat
k = find(mean_dif_pr_245_his <= -14); mean_dif_pr_245_his(k) = -14;
k1 = find(isnan(mean_dif_pr_245_his)); mean_dif_pr_245_his(k1) = -15;

for i = 1:length(kland_1d)
    index = kland_1d(i); 
    row = mod(index - 1, 180) + 1; 
    col = ceil(index / 180);       
    if row <= 180 && col <= 360
        data_map(row, col) = mean_dif_pr_245_his(i);  
        sig_map(row, col) = sig_dif_pr_245_his(i);        
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
caxis([-15 15]);
colormap(h8,  [[1 1 1]*0.8; J]);


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

set(h8, 'Color', 'none'); 
m_grid('xaxis','off','yaxis','off', ...
    'box', 'off', ...
    'xtick',[], ...
    'ytick',[], ...
    'xticklabels',{}, ...
    'yticklabels',{},...
    'linestyle','none');         

set(gca,'XTick',[], 'YTick',[], 'Box', 'off');
set(h8, "XColor", 'none', 'YColor', 'none', 'Color', 'none');



hold on

 










%

c1 = colorbar('Position', [0.35 0.07 0.3 0.015], 'Orientation', 'horizontal');


set(c1, 'LineWidth', 0.2, 'FontSize', 10);
caxis([-15 15]);
set(c1, 'XTick', [-15 -10 -5 0 5 10 15]);


colormap(c1, J);  
xlabel(c1, 'mm month^{-1}', 'FontSize', 10);


%


filename='FigureS5.png'


exportgraphics(fig, filename, 'Resolution', 300);




















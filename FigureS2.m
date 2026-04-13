

clear

load ..\cmip\his_ssp_mat_data_land\FigureS2.mat

%

figure
width=8.8;
height=3.5;
set(gcf,'position',[10 10 width*100 height*100])

h1 = subplot('Position', [0.06,0.2,0.4,0.7]);
hold(h1, 'on'); 


data_vars = {
   mean_dif_wa_245_his, mean_dif_wa_585_his;
   mean_dif_pr_245_his, mean_dif_pr_585_his;
   mean_dif_tran_245_his, mean_dif_tran_585_his;
   mean_dif_eva_245_his, mean_dif_eva_585_his
};
var_names = {'Wa','P','T','E'};

base_colors1 = [
    176 104 108;    
    92 134 183;  
    175 214 145;  
    234 156 159  
] / 255;

% 
c245 = base_colors1;         
c585 = base_colors1;         

x_min = -7; x_max = 12;
x_grid = linspace(x_min, x_max, 600);

nVars = size(data_vars,1);
y_spacing = 1;                     
base_positions = (nVars:-1:1) * y_spacing;

sep = 0.18 * y_spacing;  

for v = 1:nVars
    data1 = data_vars{v,1}; data1 = data1(isfinite(data1));
    data2 = data_vars{v,2}; data2 = data2(isfinite(data2));
    yoffset = base_positions(v);
    if ~isempty(data1)
        [f1, xi1] = ksdensity(data1, x_grid);
        if any(f1>0)
            f1 = f1 / max(f1) * 0.85 * (y_spacing/1.1);
            Y1 = f1 + (yoffset + sep);     
            fill(h1, [xi1 fliplr(xi1)], [Y1 fliplr(repmat(yoffset+sep,size(Y1)))], c245(v,:), 'FaceAlpha',0.6, 'EdgeColor','none');
            plot(h1, xi1, Y1, 'Color', darken(c245(v,:),0.25), 'LineWidth',0.6);
            q50_1 = median(data1); mval1 = mean(data1);
            y_q50_1 = safe_interp(xi1, Y1, q50_1, yoffset+sep);
            y_mean_1 = safe_interp(xi1, Y1, mval1, yoffset+sep);
            plot(h1, [q50_1 q50_1], [yoffset+sep, y_q50_1], 'w-', 'LineWidth', 1);
            plot(h1, [mval1 mval1], [yoffset+sep, y_mean_1], 'w--', 'LineWidth', 1);
        end
    end
    
    if ~isempty(data2)
        [f2, xi2] = ksdensity(data2, x_grid);
        if any(f2>0)
            f2 = f2 / max(f2) * 0.85 * (y_spacing/1.1);
            Y2 = f2 + (yoffset - sep);    
            fill(h1, [xi2 fliplr(xi2)], [Y2 fliplr(repmat(yoffset-sep,size(Y2)))], c585(v,:),  'FaceAlpha',0.4, 'EdgeColor','none');
            add_hatch_pattern(h1, xi2, Y2, yoffset-sep, c585(v,:), 0.3);
            plot(h1, xi2, Y2, 'Color', darken(c585(v,:),0.25), 'LineWidth',0.6);
            q50_2 = median(data2); mval2 = mean(data2);
            y_q50_2 = safe_interp(xi2, Y2, q50_2, yoffset-sep);
            y_mean_2 = safe_interp(xi2, Y2, mval2, yoffset-sep);
            plot(h1, [q50_2 q50_2], [yoffset-sep, y_q50_2], 'w-', 'LineWidth', 1);
            plot(h1, [mval2 mval2], [yoffset-sep, y_mean_2], 'w--', 'LineWidth', 1);
        end
    end
    text(h1, x_min - 1.5, yoffset, var_names{v}, ...
        'FontSize',12, ...
        'FontName','Arial', ...
        'FontWeight','normal', ...
        'HorizontalAlignment','left', ...
        'VerticalAlignment','middle');
end
xlim(h1, [x_min, x_max]);
ylim(h1, [0.5, max(base_positions) + 1.2]);
xlabel(h1, 'Δ (mm month^{-1})', 'FontSize',12, 'FontName','Arial');
title(h1, '(a) Changes in the annual mean water balance', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');
set(h1, 'YTick', [],  'XTick', [ -5, 0, 5, 10], 'FontSize', 12, 'FontName', 'Arial');
yl = ylim(h1);
plot(h1, [0 0], yl, 'k--', 'LineWidth',1, 'HandleVisibility','off');
h1.XGrid = 'on';
h1.GridLineStyle = '--';
h1.GridColor = [0.85 0.85 0.85];
h1.GridAlpha = 0.35;
h1.Box = 'off';
set(h1, 'LineWidth', 1);
lx = -6.5;          
lw = 1;             
lh = 0.3;           
ly = [4.7, 4.25];     
rectangle(h1, 'Position', [lx, ly(1), lw, lh], 'FaceColor', c245(1,:), ...
    'EdgeColor', darken(c245(1,:), 0.25), 'LineWidth', 0.6);
text(h1, lx+lw+0.2, ly(1)+lh/2, 'SSP2-4.5', ...
    'FontSize', 12, 'FontName', 'Arial', 'VerticalAlignment', 'middle');
rectangle(h1, 'Position', [lx, ly(2), lw, lh], 'FaceColor', c585(1,:), ...
    'EdgeColor', darken(c585(1,:), 0.25), 'LineWidth', 0.6);
n_hatch = 6;  
for i = 1:n_hatch
    x_start = lx + (i-1) * lw / (n_hatch-1);
    y_start = ly(2);
    if x_start + lh <= lx + lw
        x_end = x_start + lh;
        y_end = ly(2) + lh;
    else
        x_end = lx + lw;
        y_end = ly(2) + (lx + lw - x_start);
    end
    plot(h1, [x_start, x_end], [y_start, y_end], '-', ...
        'Color', darken(c585(1,:), 0.4), 'LineWidth', 0.6);
end

text(h1, lx+lw+0.2, ly(2)+lh/2, 'SSP5-8.5', ...
    'FontSize', 12, 'FontName', 'Arial', 'VerticalAlignment', 'middle');
set(gcf,'Color','w');


%
h2 = subplot('Position', [0.56,0.2,0.4,0.7]);
hold(h2, 'on');
data_vars = {
   mean_dif_wa_245_his, mean_dif_wa_585_his;
   mean_dif_pr_245_his, mean_dif_pr_585_his;
   mean_dif_tran_245_his, mean_dif_tran_585_his;
   mean_dif_eva_245_his, mean_dif_eva_585_his
};
var_names = {'Wa','P','T','E'};

base_colors1 = [
    176 104 108;    
    92 134 183;   
    175 214 145;  
    234 156 159    
] / 255;

c245 = base_colors1;          
c585 = base_colors1;          
x_min = -15; x_max = 12;
x_grid = linspace(x_min, x_max, 600);

nVars = size(data_vars,1);
y_spacing = 1;                     
base_positions = (nVars:-1:1) * y_spacing;
sep = 0.18 * y_spacing; 
for v = 1:nVars
    data1 = data_vars{v,1}; data1 = data1(isfinite(data1));
    data2 = data_vars{v,2}; data2 = data2(isfinite(data2));
    yoffset = base_positions(v);
    if ~isempty(data1)
        [f1, xi1] = ksdensity(data1, x_grid);
        if any(f1>0)
            f1 = f1 / max(f1) * 0.85 * (y_spacing/1.1);
            Y1 = f1 + (yoffset + sep);     
            fill(h2, [xi1 fliplr(xi1)], [Y1 fliplr(repmat(yoffset+sep,size(Y1)))], c245(v,:),  'FaceAlpha',0.6, 'EdgeColor','none');
            plot(h2, xi1, Y1, 'Color', darken(c245(v,:),0.25), 'LineWidth',0.6);
            q50_1 = median(data1); mval1 = mean(data1);
            y_q50_1 = safe_interp(xi1, Y1, q50_1, yoffset+sep);
            y_mean_1 = safe_interp(xi1, Y1, mval1, yoffset+sep);
            plot(h2, [q50_1 q50_1], [yoffset+sep, y_q50_1], 'w-', 'LineWidth', 1);
            plot(h2, [mval1 mval1], [yoffset+sep, y_mean_1], 'w--', 'LineWidth', 1);
        end
    end
    
    if ~isempty(data2)
        [f2, xi2] = ksdensity(data2, x_grid);
        if any(f2>0)
            f2 = f2 / max(f2) * 0.85 * (y_spacing/1.1);
            Y2 = f2 + (yoffset - sep);     
            fill(h2, [xi2 fliplr(xi2)], [Y2 fliplr(repmat(yoffset-sep,size(Y2)))], c585(v,:), 'FaceAlpha',0.4, 'EdgeColor','none');
            add_hatch_pattern(h2, xi2, Y2, yoffset-sep, c585(v,:), 0.5);
            plot(h2, xi2, Y2, 'Color', darken(c585(v,:),0.25), 'LineWidth',0.6);
            
            q50_2 = median(data2); mval2 = mean(data2);
            y_q50_2 = safe_interp(xi2, Y2, q50_2, yoffset-sep);
            y_mean_2 = safe_interp(xi2, Y2, mval2, yoffset-sep);
            plot(h2, [q50_2 q50_2], [yoffset-sep, y_q50_2], 'w-', 'LineWidth', 1);
            plot(h2, [mval2 mval2], [yoffset-sep, y_mean_2], 'w--', 'LineWidth', 1);
        end
    end
    text(h2, x_min - 2, yoffset, var_names{v}, ...
        'FontSize',12, ...
        'FontName','Arial', ...
        'FontWeight','normal', ...
        'HorizontalAlignment','left', ...
        'VerticalAlignment','middle');
end

xlim(h2, [x_min, x_max]);
ylim(h2, [0.5, max(base_positions) + 1.2]);
set(h2, 'YTick', [], 'XTick', [-15, -10, -5, 0, 5, 10], 'FontSize', 12, 'FontName', 'Arial');
xlabel(h2, 'Δ (mm month^{-1})', 'FontSize',12, 'FontName','Arial');
title(h2, '(b) Changes in the dry-season water balance', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');
yl = ylim(h2);
plot(h2, [0 0], yl, 'k--', 'LineWidth',1, 'HandleVisibility','off');
h2.XGrid = 'on';
h2.GridLineStyle = '--';
h2.GridColor = [0.85 0.85 0.85];
set(h2, 'LineWidth', 1);
h2.GridAlpha = 0.35;
h2.Box = 'off';

set(gcf,'Color','w');






filename='FigureS2'
print(filename,'-dpng','-r300')







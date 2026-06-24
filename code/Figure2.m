
clear


load Figure2.mat

fig = figure
width=8.8
height=7.5

set(gcf,'position',[10 10 width*100 height*100])



%

h1 = subplot('Position', [0.08,0.51,0.4,0.42]); 

hold on;


title(h1, '(a) Land fractions for \DeltaE > \DeltaT(\DeltaP) under SSP2-4.5', ...
    'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'Arial');

color_et = [219, 127, 142] / 255;  % ΔE > ΔT
color_ep = [138, 119, 185] / 255;  % ΔE > ΔP

y_range = [0.5, length(years)+0.5];

h22 = fill([overall_ci_lower_et_245, overall_ci_upper_et_245, ...
            overall_ci_upper_et_245, overall_ci_lower_et_245], ...
           [y_range(1), y_range(1), y_range(2), y_range(2)], ...
           color_et, 'FaceAlpha', 0.15, 'EdgeColor', 'none');

fill([overall_ci_lower_ep_245, overall_ci_upper_ep_245, ...
      overall_ci_upper_ep_245, overall_ci_lower_ep_245], ...
     [y_range(1), y_range(1), y_range(2), y_range(2)], ...
     color_ep, 'FaceAlpha', 0.15, 'EdgeColor', 'none');

h11 = plot([overall_mean_et_245, overall_mean_et_245], y_range, ...
    'Color', color_et, 'LineWidth', 2, 'LineStyle', '--');

plot([overall_mean_ep_245, overall_mean_ep_245], y_range, ...
    'Color', color_ep, 'LineWidth', 2, 'LineStyle', '--');

for i = 1:length(years)
    x_line = linspace(means_et_245(i), means_ep_245(i), 100);
    y_line = repmat(i, 1, 100);

    colors = zeros(100, 3);
    for j = 1:100
        t = (j-1) / 99;
        colors(j, :) = (1-t) * color_et + t * color_ep;
    end

    patch(x_line, y_line, 'r', 'EdgeColor', 'interp', ...
        'LineWidth', 2, 'FaceVertexCData', colors, 'EdgeAlpha', 1);

    if i == 1
        h1 = scatter(means_et_245(i), i, 120, color_et, 'filled', ...
            'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    else
        scatter(means_et_245(i), i, 120, color_et, 'filled', ...
            'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    end

    text(means_et_245(i)-0.3, i, sprintf('%.1f', means_et_245(i)), ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', ...
        'FontSize', 10, 'Color', color_et, 'FontWeight', 'bold');
end

for i = 1:length(years)
    if i == 1
        h2 = scatter(means_ep_245(i), i, 120, color_ep, 'filled', ...
            'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    else
        scatter(means_ep_245(i), i, 120, color_ep, 'filled', ...
            'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    end

    text(means_ep_245(i)+0.3, i, sprintf('%.1f', means_ep_245(i)), ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', ...
        'FontSize', 10, 'Color', color_ep, 'FontWeight', 'bold');
end

set(gca, 'YDir', 'reverse');
yticks(1:length(years));
yticklabels({'2020', '', '2040', '', '2060', '', '2080', '', '2100'});
ylim(y_range);
xlim([48, 56.5]);

xlabel('Fraction (%) ', 'FontSize', 10, 'FontWeight', 'norm');
ylabel('Year', 'FontSize', 10, 'FontWeight', 'norm');

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

grid off;
box on;
set(gca, 'FontSize', 10);
hold off;











h2 = subplot('Position', [0.57,0.51,0.4,0.42]); 

hold on;

title(h2, '(b) Land fractions for \DeltaE > \DeltaT(\DeltaP) under SSP5-8.5', ...
    'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'Arial');

color_et = [219, 127, 142] / 255;  % ΔE > ΔT
color_ep = [138, 119, 185] / 255;  % ΔE > ΔP

y_range = [0.5, length(years)+0.5];

% ΔE > ΔT 置信区间
h22 = fill([overall_ci_lower_et_585, overall_ci_upper_et_585, ...
            overall_ci_upper_et_585, overall_ci_lower_et_585], ...
           [y_range(1), y_range(1), y_range(2), y_range(2)], ...
           color_et, 'FaceAlpha', 0.15, 'EdgeColor', 'none');

% ΔE > ΔP 置信区间
fill([overall_ci_lower_ep_585, overall_ci_upper_ep_585, ...
      overall_ci_upper_ep_585, overall_ci_lower_ep_585], ...
     [y_range(1), y_range(1), y_range(2), y_range(2)], ...
     color_ep, 'FaceAlpha', 0.15, 'EdgeColor', 'none');

% ΔE > ΔT 总体均值线
h11 = plot([overall_mean_et_585, overall_mean_et_585], y_range, ...
    'Color', color_et, 'LineWidth', 2, 'LineStyle', '--');

% ΔE > ΔP 总体均值线
plot([overall_mean_ep_585, overall_mean_ep_585], y_range, ...
    'Color', color_ep, 'LineWidth', 2, 'LineStyle', '--');

% 每年的数据点和连接线
for i = 1:length(years)

    x_line = linspace(means_et_585(i), means_ep_585(i), 100);
    y_line = repmat(i, 1, 100);

    colors = zeros(100, 3);
    for j = 1:100
        t = (j-1) / 99;
        colors(j, :) = (1-t) * color_et + t * color_ep;
    end

    patch(x_line, y_line, 'r', 'EdgeColor', 'interp', ...
        'LineWidth', 2, 'FaceVertexCData', colors, 'EdgeAlpha', 1);

    if i == 1
        h1 = scatter(means_et_585(i), i, 120, color_et, 'filled', ...
            'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    else
        scatter(means_et_585(i), i, 120, color_et, 'filled', ...
            'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    end

    text(means_et_585(i)-0.3, i, sprintf('%.1f', means_et_585(i)), ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', ...
        'FontSize', 10, 'Color', color_et, 'FontWeight', 'bold');
end

for i = 1:length(years)

    if i == 1
        h2 = scatter(means_ep_585(i), i, 120, color_ep, 'filled', ...
            'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    else
        scatter(means_ep_585(i), i, 120, color_ep, 'filled', ...
            'MarkerEdgeColor', [0.3, 0.3, 0.3], 'LineWidth', 1.5);
    end

    text(means_ep_585(i)+0.3, i, sprintf('%.1f', means_ep_585(i)), ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', ...
        'FontSize', 10, 'Color', color_ep, 'FontWeight', 'bold');
end

set(gca, 'YDir', 'reverse');
yticks(1:length(years));
yticklabels({'2020', '', '2040', '', '2060', '', '2080', '', '2100'});
ylim(y_range);
xlim([47, 63.5]);

xlabel('Fraction (%) ', 'FontSize', 10, 'FontWeight', 'norm');

legend([h1, h2, h11, h22], {'∆E > ∆T', '∆E > ∆P', 'mean', 'Stdev'}, ...
       'Location', 'northeast', 'FontSize', 10, 'Box', 'off');

ax = gca;
ax.XAxis.LineWidth = 1;
ax.YAxis.LineWidth = 1;

grid off;
box on;
set(gca, 'FontSize', 10);
hold off;





h3 = subplot('Position', [0.08,0.06,0.4,0.35]); 
title('(c) Ta ~ ∆T(∆E) for northern boreal region', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');

ecolor_245 = [219, 127, 142]/255;  
ecolor_585 = [110/255, 158/255, 149/255];  



hold on

h_e245 = scatter(tas245_caf_gridmean, e245_caf_gridmean, 40, ecolor_245, 'filled', ...
                 'MarkerFaceAlpha', 0.45, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.7, 'LineWidth', 0.5);

h_e585 = scatter(tas585_caf_gridmean, e585_caf_gridmean, 40, ecolor_585, 'filled', ...
                 'MarkerFaceAlpha', 0.45, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.7, 'LineWidth', 0.5);


hold on;


x_fit_245 = linspace(25.8, 28, 100);

x_fit_585 = linspace(25.8, 30.5, 100);

p_t245 = polyfit(tas245_caf_gridmean, tran245_caf_gridmean, 1);
y_t245 = polyval(p_t245, x_fit_245);


p_e245 = polyfit(tas245_caf_gridmean, e245_caf_gridmean, 1);
y_e245 = polyval(p_e245, x_fit_245);

R_e245 = corrcoef(tas245_caf_gridmean, e245_caf_gridmean);
R2_e245 = R_e245(1,2)^2;

h_fit_e245 = plot(x_fit_245, y_e245, '-', 'Color', ecolor_245, 'LineWidth', 2.5);


p_e585 = polyfit(tas585_caf_gridmean, e585_caf_gridmean, 1);
y_e585 = polyval(p_e585, x_fit_585);

R_e585 = corrcoef(tas585_caf_gridmean, e585_caf_gridmean);
R2_e585 = R_e585(1,2)^2;

h_fit_e585 = plot(x_fit_585, y_e585, '-', 'Color', ecolor_585, 'LineWidth', 2.5);


ylim([-4, 10]);
yticks(-4:2:10);
ylabel('∆E (mm month^{-1})');

xlabel('Ta (°C)');
xlim([25.5 31]);
xticks(26:1:31);

legend([h_e245, h_e585], ...
       {'∆E (SSP2-4.5)', '∆E (SSP5-8.5)'}, ...
       'Location', 'southeast', 'FontSize', 8, 'NumColumns', 1);
legend('box', 'off');


grid off

hold off;



 
h4 = subplot('Position', [0.57,0.06,0.4,0.35]); 
title('(d) Ta ~ ∆T for central-eastern Africa region', 'FontSize',10, 'FontWeight','bold', 'FontName','Arial');



tcolor_245 = [219, 127, 142]/255;  
tcolor_585 = [110/255, 158/255, 149/255]; 



hold on

h_t245 = scatter(tas245_caf_gridmean, tran245_caf_gridmean, 40, tcolor_245, 'filled', ...
                 'MarkerFaceAlpha', 0.45, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.7, 'LineWidth', 0.5);

h_t585 = scatter(tas585_caf_gridmean, tran585_caf_gridmean, 40, tcolor_585, 'filled',...
                 'MarkerFaceAlpha', 0.45, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.7, 'LineWidth', 0.5);

hold on;


x_fit_245 = linspace(25.8, 28, 100);

x_fit_585 = linspace(25.8, 30.5, 100);

p_t245 = polyfit(tas245_caf_gridmean, tran245_caf_gridmean, 1);
y_t245 = polyval(p_t245, x_fit_245);

h_fit_t245 = plot(x_fit_245, y_t245, '-', 'Color', tcolor_245, 'LineWidth', 2.5);

p_t585 = polyfit(tas585_caf_gridmean, tran585_caf_gridmean, 2);
y_t585 = polyval(p_t585, x_fit_585);

R_t585 = corrcoef(tas585_caf_gridmean, tran585_caf_gridmean);
R2_t585 = R_t585(1,2)^2;

h_fit_t585 = plot(x_fit_585, y_t585, '-', 'Color', tcolor_585, 'LineWidth', 2.5);



ylim([-6, 2]);
yticks(-6:2:2);

ylabel('∆T (mm month^{-1})');
xlabel('Ta (°C)');
xlim([25.5 31]);
xticks(26:1:31);

legend([h_t245, h_t585], ...
       {'∆T (SSP2-4.5)', '∆T (SSP5-8.5)'}, ...
       'Location', 'southwest', 'FontSize', 8, 'NumColumns', 1);
legend('box', 'off');


grid off

hold off;



filename='Figure2';
print(filename,'-dpng','-r300');





































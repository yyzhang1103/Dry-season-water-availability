%% 
clear
load ..\cmip\his_ssp_mat_data_land\FigureS6.mat

%

width=8.8;
height=10;
set(gcf,'position',[10 10 width*100 height*100])
%



h1 = subplot('Position', [0.08,0.71,0.4,0.25]); 

title('(a) Ta ~ ∆T(∆E) for Amazonia region', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');


tcolor =  [110/255, 158/255, 149/255];
ecolor = [219, 127, 142]/255;  

hold on;

h_t245 = scatter(tas245_amz_gridmean, tran245_amz_gridmean, 18, tcolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_e245 = scatter(tas245_amz_gridmean, e245_amz_gridmean, 18, ecolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_t585 = scatter(tas585_amz_gridmean, tran585_amz_gridmean, 18, tcolor, ...
                 'MarkerEdgeColor', tcolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);
h_e585 = scatter(tas585_amz_gridmean, e585_amz_gridmean, 18, ecolor, ...
                 'MarkerEdgeColor', ecolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);

hold on

x_fit_245 = linspace(24, 27, 100);
x_fit_585 = linspace(24, 30.3, 100);
p_t245 = polyfit(tas245_amz_gridmean, tran245_amz_gridmean, 2);
y_t245 = polyval(p_t245, x_fit_245);
R_t245 = corrcoef(tas245_amz_gridmean, tran245_amz_gridmean);
R2_t245 = R_t245(1,2)^2;

h_fit_t245 = plot(x_fit_245, y_t245, '-', 'Color', tcolor, 'LineWidth', 2.5);
p_t585 = polyfit(tas585_amz_gridmean, tran585_amz_gridmean, 2);
y_t585 = polyval(p_t585, x_fit_585);
R_t585 = corrcoef(tas585_amz_gridmean, tran585_amz_gridmean);
R2_t585 = R_t585(1,2)^2;
h_fit_t585 = plot(x_fit_585, y_t585, '--', 'Color', tcolor, 'LineWidth', 2.5);

p_e245 = polyfit(tas245_amz_gridmean, e245_amz_gridmean, 1);
y_e245 = polyval(p_e245, x_fit_245);

R_e245 = corrcoef(tas245_amz_gridmean, e245_amz_gridmean);
R2_e245 = R_e245(1,2)^2;
h_fit_e245 = plot(x_fit_245, y_e245, '-', 'Color', ecolor, 'LineWidth', 2.5);

p_e585 = polyfit(tas585_amz_gridmean, e585_amz_gridmean, 1);
y_e585 = polyval(p_e585, x_fit_585);

R_e585 = corrcoef(tas585_amz_gridmean, e585_amz_gridmean);
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

ylim([-10, 5]);
yticks(-10:5:5);
ylabel(' ∆T(∆E) (mm/month)');

xlabel('Ta (°C)');
xlim([23.5 31]);
xticks(24:1:31);

legend([h_t245, h_t585, h_e245, h_e585], ...
       {'T (SSP2-4.5)', 'T (SSP5-8.5)', 'E (SSP2-4.5)', 'E (SSP5-8.5)'}, ...
       'Location', 'southwest', 'FontSize', 8, 'NumColumns', 1);
legend('box', 'off');



grid on;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.2);
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1);

hold off;






h2 = subplot('Position', [0.57,0.71,0.4,0.25]); 

title('(b) Ta ~ ∆T(∆E) for southern Africa region', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');

tcolor =  [110/255, 158/255, 149/255];
ecolor = [219, 127, 142]/255;  

hold on

h_t245 = scatter(tas245_saf_gridmean, tran245_saf_gridmean, 18, tcolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_e245 = scatter(tas245_saf_gridmean, e245_saf_gridmean, 18, ecolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);


h_t585 = scatter(tas585_saf_gridmean, tran585_saf_gridmean, 18, tcolor, ...
                 'MarkerEdgeColor', tcolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);
h_e585 = scatter(tas585_saf_gridmean, e585_saf_gridmean, 18, ecolor, ...
                 'MarkerEdgeColor', ecolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);


hold on;


x_fit_245 = linspace(19.8, 22.8, 100);

x_fit_585 = linspace(20, 25.2, 100);

p_t245 = polyfit(tas245_saf_gridmean, tran245_saf_gridmean, 1);
y_t245 = polyval(p_t245, x_fit_245);

R_t245 = corrcoef(tas245_saf_gridmean, tran245_saf_gridmean);
R2_t245 = R_t245(1,2)^2;

h_fit_t245 = plot(x_fit_245, y_t245, '-', 'Color', tcolor, 'LineWidth', 2.5);


p_t585 = polyfit(tas585_saf_gridmean, tran585_saf_gridmean, 2);
y_t585 = polyval(p_t585, x_fit_585);
R_t585 = corrcoef(tas585_saf_gridmean, tran585_saf_gridmean);
R2_t585 = R_t585(1,2)^2;

h_fit_t585 = plot(x_fit_585, y_t585, '--', 'Color', tcolor, 'LineWidth', 2.5);


p_e245 = polyfit(tas245_saf_gridmean, e245_saf_gridmean, 1);
y_e245 = polyval(p_e245, x_fit_245);

R_e245 = corrcoef(tas245_saf_gridmean, e245_saf_gridmean);
R2_e245 = R_e245(1,2)^2;

h_fit_e245 = plot(x_fit_245, y_e245, '-', 'Color', ecolor, 'LineWidth', 2.5);


p_e585 = polyfit(tas585_saf_gridmean, e585_saf_gridmean, 1);
y_e585 = polyval(p_e585, x_fit_585);

R_e585 = corrcoef(tas585_saf_gridmean, e585_saf_gridmean);
R2_e585 = R_e585(1,2)^2;

h_fit_e585 = plot(x_fit_585, y_e585, '--', 'Color', ecolor, 'LineWidth', 2.5);


text(20, 6, sprintf('R^2=%.2f', R2_t245), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');
text(24, 6, sprintf('R^2=%.2f', R2_t585), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', tcolor);

text(21, -3.8, sprintf('R^2=%.2f', R2_e245), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');
text(24, -4, sprintf('R^2=%.2f', R2_e585), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', ecolor);

ylim([-6, 9]);
yticks(-6:3:9);

xlabel('Ta (°C)');
xlim([19 26]);
xticks(19:1:26);

grid on;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.2);
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1);

hold off;






h3 = subplot('Position', [0.08,0.375,0.4,0.25]); 

title('(c) Ta ~ ∆T(∆E) for northern North America region', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');

tcolor =  [110/255, 158/255, 149/255];
ecolor = [219, 127, 142]/255;  

hold on

h_t245 = scatter(tas245_na_gridmean, tran245_na_gridmean, 18, tcolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_e245 = scatter(tas245_na_gridmean, e245_na_gridmean, 18, ecolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);

h_t585 = scatter(tas585_na_gridmean, tran585_na_gridmean, 18, tcolor, ...
                 'MarkerEdgeColor', tcolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);
h_e585 = scatter(tas585_na_gridmean, e585_na_gridmean, 18, ecolor, ...
                 'MarkerEdgeColor', ecolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);


hold on;

x_fit_245 = linspace(7.8, 10, 100);
x_fit_585 = linspace(7.8, 12.8, 100);
p_t245 = polyfit(tas245_na_gridmean, tran245_na_gridmean, 1);
y_t245 = polyval(p_t245, x_fit_245);

R_t245 = corrcoef(tas245_na_gridmean, tran245_na_gridmean);
R2_t245 = R_t245(1,2)^2;
h_fit_t245 = plot(x_fit_245, y_t245, '-', 'Color', tcolor, 'LineWidth', 2.5);


p_t585 = polyfit(tas585_na_gridmean, tran585_na_gridmean, 2);
y_t585 = polyval(p_t585, x_fit_585);
R_t585 = corrcoef(tas585_na_gridmean, tran585_na_gridmean);
R2_t585 = R_t585(1,2)^2;

h_fit_t585 = plot(x_fit_585, y_t585, '--', 'Color', tcolor, 'LineWidth', 2.5);


p_e245 = polyfit(tas245_na_gridmean, e245_na_gridmean, 1);
y_e245 = polyval(p_e245, x_fit_245);

R_e245 = corrcoef(tas245_na_gridmean, e245_na_gridmean);
R2_e245 = R_e245(1,2)^2;

h_fit_e245 = plot(x_fit_245, y_e245, '-', 'Color', ecolor, 'LineWidth', 2.5);


p_e585 = polyfit(tas585_na_gridmean, e585_na_gridmean, 1);
y_e585 = polyval(p_e585, x_fit_585);
R_e585 = corrcoef(tas585_na_gridmean, e585_na_gridmean);
R2_e585 = R_e585(1,2)^2;

h_fit_e585 = plot(x_fit_585, y_e585, '--', 'Color', ecolor, 'LineWidth', 2.5);


text(8, 3, sprintf('R^2=%.2f', R2_t245), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');

text(11, 4, sprintf('R^2=%.2f', R2_t585), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', tcolor);

text(10, 0, sprintf('R^2=%.2f', R2_e245), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');

text(12, 0.5, sprintf('R^2=%.2f', R2_e585), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', ecolor);

ylim([-2, 6]);
yticks(-2:2:6);
ylabel('ΔT(ΔE) (mm/month)');

xlabel('Ta (°C)');
xlim([7 13]);
xticks(7:1:13);

grid on;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.2);
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1);

hold off;





h4 = subplot('Position', [0.57,0.375,0.4,0.25]); 

title('(d) Ta ~ ∆T(∆E) for Indonesia region', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');


tcolor =  [110/255, 158/255, 149/255];
ecolor = [219, 127, 142]/255;  

hold on;


h_t245 = scatter(tas245_ind_gridmean, tran245_ind_gridmean, 18, tcolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_e245 = scatter(tas245_ind_gridmean, e245_ind_gridmean, 18, ecolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);

h_t585 = scatter(tas585_ind_gridmean, tran585_ind_gridmean, 18, tcolor, ...
                 'MarkerEdgeColor', tcolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);
h_e585 = scatter(tas585_ind_gridmean, e585_ind_gridmean, 18, ecolor, ...
                 'MarkerEdgeColor', ecolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);

hold on

x_fit_245 = linspace(26.5, 28, 100);

x_fit_585 = linspace(26.5, 30.3, 100);

p_t245 = polyfit(tas245_ind_gridmean, tran245_ind_gridmean, 2);
y_t245 = polyval(p_t245, x_fit_245);

R_t245 = corrcoef(tas245_ind_gridmean, tran245_ind_gridmean);
R2_t245 = R_t245(1,2)^2;

h_fit_t245 = plot(x_fit_245, y_t245, '-', 'Color', tcolor, 'LineWidth', 2.5);


p_t585 = polyfit(tas585_ind_gridmean, tran585_ind_gridmean, 2);
y_t585 = polyval(p_t585, x_fit_585);

R_t585 = corrcoef(tas585_ind_gridmean, tran585_ind_gridmean);
R2_t585 = R_t585(1,2)^2;
h_fit_t585 = plot(x_fit_585, y_t585, '--', 'Color', tcolor, 'LineWidth', 2.5);


p_e245 = polyfit(tas245_ind_gridmean, e245_ind_gridmean, 1);
y_e245 = polyval(p_e245, x_fit_245);

R_e245 = corrcoef(tas245_ind_gridmean, e245_ind_gridmean);
R2_e245 = R_e245(1,2)^2;

h_fit_e245 = plot(x_fit_245, y_e245, '-', 'Color', ecolor, 'LineWidth', 2.5);


p_e585 = polyfit(tas585_ind_gridmean, e585_ind_gridmean, 1);
y_e585 = polyval(p_e585, x_fit_585);

R_e585 = corrcoef(tas585_ind_gridmean, e585_ind_gridmean);
R2_e585 = R_e585(1,2)^2;

h_fit_e585 = plot(x_fit_585, y_e585, '--', 'Color', ecolor, 'LineWidth', 2.5);



text(27, -7, sprintf('R^2=%.2f', R2_t245), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');


text(29.5, -6, sprintf('R^2=%.2f', R2_t585), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', tcolor);

text(26.5, 6, sprintf('R^2=%.2f', R2_e245), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');

text(29.5, 3, sprintf('R^2=%.2f', R2_e585), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', ecolor);

ylim([-9, 7]);
yticks(-9:3:6);
ylabel(' ∆T(∆E) (mm/month)');

xlabel('Ta (°C)');
xlim([26 30.5]);
xticks(26:1:30);


grid on;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.2);
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1);

hold off;




h5 = subplot('Position', [0.08,0.05,0.4,0.25]); 

title('(e) Ta ~ ∆T(∆E) for northern Australia region', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');


tcolor =  [110/255, 158/255, 149/255];
ecolor = [219, 127, 142]/255; 

hold on

h_t245 = scatter(tas245_aus_gridmean, tran245_aus_gridmean, 18, tcolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);
h_e245 = scatter(tas245_aus_gridmean, e245_aus_gridmean, 18, ecolor, 'filled', ...
                 'MarkerFaceAlpha', 0.6, 'MarkerEdgeColor', 'k', 'MarkerEdgeAlpha', 0.8, 'LineWidth', 0.5);


h_t585 = scatter(tas585_aus_gridmean, tran585_aus_gridmean, 18, tcolor, ...
                 'MarkerEdgeColor', tcolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);
h_e585 = scatter(tas585_aus_gridmean, e585_aus_gridmean, 18, ecolor, ...
                 'MarkerEdgeColor', ecolor, 'MarkerEdgeAlpha', 0.8, 'LineWidth', 1);


hold on;


x_fit_245 = linspace(21, 25, 100);

x_fit_585 = linspace(22, 30, 100);

p_t245 = polyfit(tas245_aus_gridmean, tran245_aus_gridmean, 1);
y_t245 = polyval(p_t245, x_fit_245);

R_t245 = corrcoef(tas245_aus_gridmean, tran245_aus_gridmean);
R2_t245 = R_t245(1,2)^2;
h_fit_t245 = plot(x_fit_245, y_t245, '-', 'Color', tcolor, 'LineWidth', 2.5);


p_t585 = polyfit(tas585_aus_gridmean, tran585_aus_gridmean, 2);
y_t585 = polyval(p_t585, x_fit_585);
R_t585 = corrcoef(tas585_aus_gridmean, tran585_aus_gridmean);
R2_t585 = R_t585(1,2)^2;

h_fit_t585 = plot(x_fit_585, y_t585, '--', 'Color', tcolor, 'LineWidth', 2.5);


p_e245 = polyfit(tas245_aus_gridmean, e245_aus_gridmean, 1);
y_e245 = polyval(p_e245, x_fit_245);

R_e245 = corrcoef(tas245_aus_gridmean, e245_aus_gridmean);
R2_e245 = R_e245(1,2)^2;

h_fit_e245 = plot(x_fit_245, y_e245, '-', 'Color', ecolor, 'LineWidth', 2.5);


p_e585 = polyfit(tas585_aus_gridmean, e585_aus_gridmean, 1);
y_e585 = polyval(p_e585, x_fit_585);
R_e585 = corrcoef(tas585_aus_gridmean, e585_aus_gridmean);
R2_e585 = R_e585(1,2)^2;
h_fit_e585 = plot(x_fit_585, y_e585, '--', 'Color', ecolor, 'LineWidth', 2.5);


text(24, -5, sprintf('R^2=%.2f', R2_t245), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');

text(27, -4.8, sprintf('R^2=%.2f', R2_t585), ...
     'Color', tcolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', tcolor);


text(23, 10, sprintf('R^2=%.2f', R2_e245), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none');


text(27, 11, sprintf('R^2=%.2f', R2_e585), ...
     'Color', ecolor, 'FontSize', 8, 'FontWeight', 'bold', 'BackgroundColor', 'none', 'EdgeColor', ecolor);



ylim([-6.5, 15]);
yticks(-5:5:15);


xlabel('Ta (°C)');
xlim([21 30]);
xticks(21:2:30);

grid on;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.2);
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1);

hold off;




%%   

filename='FigureS6';
print(filename,'-dpng','-r300');

















































%% (7)计算E>T E>P的概率
                                                        
% % E大于T的地方
% 
% % 找出有效数据点（排除 NaN）
% valid_idx = ~isnan(contri_E_245) & ~isnan(contri_P_245);
% 
% % 统计有效数据中 E > T 的点数
% P_greater_equal =  sum(contri_P_245(valid_idx) > contri_E_245(valid_idx));
% E_greater = sum(valid_idx) - P_greater_equal;  % T >= E 的点数
% 
% % 计算比例
% total_valid = sum(valid_idx);
% percent_E = (E_greater / total_valid) * 100;
% percent_P = (P_greater_equal / total_valid) * 100;
% 
% % 输出统计结果
% fprintf('总有效点数: %d\n', total_valid);
% fprintf('E > T 的点数: %d (%.2f%%)\n', E_greater, percent_E);
% fprintf('T >= E 的点数: %d (%.2f%%)\n', P_greater_equal, percent_P);

% E大于T的地方

% 找出有效数据点（排除 NaN）
valid_idx = ~isnan(mean_dif_eva_245_his) & ~isnan(mean_dif_tran_245_his);

% 统计有效数据中 E > T 的点数
P_greater_equal =  sum(mean_dif_tran_245_his(valid_idx) > mean_dif_eva_245_his(valid_idx));
E_greater = sum(valid_idx) - P_greater_equal;  % T >= E 的点数

% 计算比例
total_valid = sum(valid_idx);
percent_E = (E_greater / total_valid) * 100;
percent_P = (P_greater_equal / total_valid) * 100;

% 输出统计结果
fprintf('总有效点数: %d\n', total_valid);
fprintf('E > T 的点数: %d (%.2f%%)\n', E_greater, percent_E);
fprintf('T >= E 的点数: %d (%.2f%%)\n', P_greater_equal, percent_P);

% 绘制饼状图
figure('Position', [100, 100, 600, 500]);
data = [E_greater, P_greater_equal];
labels = {sprintf('E ≥ T\n%.1f%%', percent_E), ...
          sprintf('T > E\n%.1f%%', percent_T)};

% 创建饼图
pie(data, labels);

% 设置颜色
colormap([0.2 0.6 0.8; 0.8 0.4 0.2]);  % 蓝色和橙色

% 设置标题和字体
title('Comparison of ΔE and ΔT Contributions (SSP2-4.5)', ...
    'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

% 设置图例
legend({'ΔE ≥ ΔT', 'ΔT > ΔE'}, ...
    'Location', 'best', ...
    'FontSize', 11, ...
    'FontName', 'Times New Roman');

% 调整字体
set(gca, 'FontName', 'Times New Roman', 'FontSize', 11);

% 保存图形（可选）
% saveas(gcf, 'pie_chart_E_vs_T.png');
% print(gcf, 'pie_chart_E_vs_T.pdf', '-dpdf', '-r300');


%% (7.1.1) E大于T的地方 245
% 找出有效数据点（排除 NaN）
%valid_idx = ~isnan(contri_E_585) & ~isnan(contri_tran_585);

% 找出有效数据点（排除 NaN）
valid_idx = ~isnan(mean_dif_eva_585_his) & ~isnan(mean_dif_tran_585_his);

% 统计有效数据中 E > T 的点数
P_greater_equal =  sum(mean_dif_tran_585_his(valid_idx) > mean_dif_eva_585_his(valid_idx));
E_greater = sum(valid_idx) - P_greater_equal;  % T >= E 的点数

% % 统计有效数据中 E > T 的点数
% P_greater_equal =  sum(contri_P_585(valid_idx) > contri_E_585(valid_idx));
% E_greater = sum(valid_idx) - P_greater_equal;  % T >= E 的点数

% 计算比例
total_valid = sum(valid_idx);
percent_E = (E_greater / total_valid) * 100;
percent_P = (P_greater_equal / total_valid) * 100;

% 输出统计结果
fprintf('总有效点数: %d\n', total_valid);
fprintf('E > T 的点数: %d (%.2f%%)\n', E_greater, percent_E);
fprintf('T >= E 的点数: %d (%.2f%%)\n', P_greater_equal, percent_P);

% 绘制饼状图
figure('Position', [100, 100, 600, 500]);
data = [E_greater, T_greater_equal];
labels = {sprintf('E ≥ T\n%.1f%%', percent_E), ...
          sprintf('T > E\n%.1f%%', percent_P)};

% 创建饼图
pie(data, labels);

% 设置颜色
colormap([0.2 0.6 0.8; 0.8 0.4 0.2]);  % 蓝色和橙色

% 设置标题和字体
title('Comparison of ΔE and ΔT Contributions (SSP5-8.5)', ...
    'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

% 设置图例
legend({'ΔE ≥ ΔT', 'ΔT > ΔE'}, ...
    'Location', 'best', ...
    'FontSize', 11, ...
    'FontName', 'Times New Roman');

% 调整字体
set(gca, 'FontName', 'Times New Roman', 'FontSize', 11);


%% 绘图 7.1.2
pct_E_gt_T = 0.62;   % E > T
pct_E_gt_P = 0.48;   % E > P

% Convert to angle ranges
theta_ET = [0 pct_E_gt_T 1] * 2*pi;
theta_EP = [0 pct_E_gt_P 1] * 2*pi;

figure('Color','w'); hold on;

% -----------------------------
% Outer ring: E vs P
% -----------------------------
r_outer = 1.0;
w_outer = 0.25;

draw_ring(theta_EP(1:2), r_outer, w_outer, [229 178 186]/255);   % E > P (金色)
draw_ring(theta_EP(2:3), r_outer, w_outer, [197 228 246]/255);       % P > E (蓝色)

% -----------------------------
% Inner ring: E vs T
% -----------------------------
r_inner = 0.65;
w_inner = 0.25;

draw_ring(theta_ET(1:2), r_inner, w_inner, [229 178 186]/255);   % E > T (金色)
draw_ring(theta_ET(2:3), r_inner, w_inner, [236 229 187]/255);       % T > E (粉色)

% Center text
text(0,0,{'E dominance','fractions'}, ...
    'HorizontalAlignment','center', 'FontSize',12)

axis equal off
xlim([-1.2 1.2]); ylim([-1.2 1.2]);

% % Manual legend (clean)
% h1 = plot(NaN,NaN,'s','MarkerFaceColor',[218 205 124]/255,'MarkerEdgeColor','none');
% h2 = plot(NaN,NaN,'s','MarkerFaceColor',[0.2 0.4 0.7],'MarkerEdgeColor','none');
% h3 = plot(NaN,NaN,'s','MarkerFaceColor',[1.0 0.7 0.8],'MarkerEdgeColor','none');
% % legend([h1 h2 h3], {'E > P/T','P > E (outer)','T > E (inner)'}, ...
%        'Location','southoutside','Orientation','horizontal');

% % =============================
% % Helper function (MUST be at end of the same file)
% % =============================
% function draw_ring(theta, r, w, color)
% Draw a ring sector from theta(1) to theta(2)
% n = 200;
% t = linspace(theta(1), theta(2), n);
% 
% x_outer = r * cos(t);
% y_outer = r * sin(t);
% 
% x_inner = (r - w) * cos(fliplr(t));
% y_inner = (r - w) * sin(fliplr(t));
% 
% patch([x_outer x_inner], [y_outer y_inner], color, 'EdgeColor','none');
% end
%% (8) 绘制全球的统计图

%% (8.1）变化量统计 annual 和dryseason分开                                       step-8
%clear

%load model_his_future_wa_typicalyears_withoutLAI_95_14_0826.mat

load model_his_future_wa_annual_typicalyears_withoutLAI_95_14_0826.mat

%% (8.1.1)计算delta wa
res = 1;  % 修改为1度分辨率
gd = 1;   % 修改为1度间隔
a = -180 + gd/2 : gd : 180 - gd/2;  % 经度从-179.5到179.5，间隔1度
b = -90 + gd/2 : gd : 90 - gd/2;    % 纬度从-89.5到89.5，间隔1度
[lon, lat] = meshgrid(a, b);

% 计算权重 Wei
Wei = abs(sin((lat + 0.5 * res) * pi / 180) - sin((lat - 0.5 * res) * pi / 180)) ./ ...
      (sin((0.5 * res) * pi / 180) - sin(-(0.5 * res) * pi / 180));
load kland_1d.mat
Wei_1_all = nan(length(kland_1d), 1);

for j = 1:length(kland_1d)
    index = kland_1d(j); % 当前编号
    % 计算对应的行和列（针对1度分辨率的180×360网格）
    row = mod(index - 1, 180) + 1; % 行从 1 到 180
    col = ceil(index / 180);       % 列从 1 到 360，ceil是向上取最接近的整数
    
    % 提取对应的值
    Wei_1_all(j, :) = Wei(row, col, :);
end

Wei_1_all_fac = repmat(Wei_1_all, 1, 9);  % 修改变量名以反映1度分辨率


wa_his = wa_his_mean .* Wei_1_all_fac;
wa_245 = wa_245_mean .* Wei_1_all_fac;
wa_585 = wa_585_mean .* Wei_1_all_fac;

pr_his = pr_his_mean .* Wei_1_all_fac;
pr_245 = pr_245_mean .* Wei_1_all_fac;
pr_585 = pr_585_mean .* Wei_1_all_fac;

tran_his = tran_his_mean .* Wei_1_all_fac;
tran_245 = tran_245_mean .* Wei_1_all_fac;
tran_585 = tran_585_mean .* Wei_1_all_fac;

eva_his = eva_his_mean .* Wei_1_all_fac;
eva_245 = eva_245_mean .* Wei_1_all_fac;
eva_585 = eva_585_mean .* Wei_1_all_fac;

%%
dif_wa_245_his = wa_245 -wa_his;
dif_wa_585_his = wa_585 - wa_his;

mean_dif_wa_245_his = squeeze(sum(dif_wa_245_his, 1,'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'))';
mean_dif_wa_585_his = squeeze(sum(dif_wa_585_his, 1, 'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'))';

% pr
dif_pr_245_his = pr_245 -pr_his;
dif_pr_585_his = pr_585 - pr_his;
mean_dif_pr_245_his = squeeze(sum(dif_pr_245_his, 1,'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'))';
mean_dif_pr_585_his = squeeze(sum(dif_pr_585_his, 1, 'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'))';

% tran
dif_tran_245_his = tran_245 -tran_his;
dif_tran_585_his = tran_585 - tran_his;
mean_dif_tran_245_his = squeeze(sum(dif_tran_245_his, 1,'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'))';
mean_dif_tran_585_his = squeeze(sum(dif_tran_585_his, 1, 'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'))';

% eva
dif_eva_245_his = eva_245 -eva_his;
dif_eva_585_his = eva_585 - eva_his;
mean_dif_eva_245_his = squeeze(sum(dif_eva_245_his, 1,'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'))';
mean_dif_eva_585_his = squeeze(sum(dif_eva_585_his, 1, 'omitnan') ./ sum(Wei_1_all_fac, 1, 'omitnan'))';


%% (8.1.2)计算wa P E T的变化量

%wa
modelmean_dif_wa_245_his = nanmean(mean_dif_wa_245_his);
std_mean_dif_wa_245_his = std(mean_dif_wa_245_his);

modelmean_dif_wa_585_his = nanmean(mean_dif_wa_585_his);
std_mean_dif_wa_585_his = std(mean_dif_wa_585_his);


% pr
modelmean_dif_pr_245_his = nanmean(mean_dif_pr_245_his);
std_mean_dif_pr_245_his = std(mean_dif_pr_245_his);

modelmean_dif_pr_585_his = nanmean(mean_dif_pr_585_his);
std_mean_dif_pr_585_his = std(mean_dif_pr_585_his);


% tran
modelmean_dif_tran_245_his = nanmean(mean_dif_tran_245_his);
std_mean_dif_tran_245_his = std(mean_dif_tran_245_his);

modelmean_dif_tran_585_his =  nanmean(mean_dif_tran_585_his);
std_mean_dif_tran_585_his = std(mean_dif_tran_585_his);

% eva

modelmean_dif_eva_245_his =  nanmean(mean_dif_eva_245_his);
std_mean_dif_eva_245_his = std(mean_dif_eva_245_his);

modelmean_dif_eva_585_his =  nanmean(mean_dif_eva_585_his);
std_mean_dif_eva_585_his = std(mean_dif_eva_585_his);


%% (8.1.3)计算所有模型的频率的均值和标准差

% 整理数据用于绘图
% modelmean_difs = [
%     % 顺序: p, tran, eva 对应每个情景
%     modelmean_dif_wa_245_his,  modelmean_dif_pr_245_his, modelmean_dif_tran_245_his, modelmean_dif_eva_245_his;   % 245-his情景
%     modelmean_dif_wa_585_his, modelmean_dif_pr_585_his, modelmean_dif_tran_585_his, modelmean_dif_eva_585_his;    % 585-his情景
% ];
% 
% std_mean_difs = [
%     std_mean_dif_wa_245_his, std_mean_dif_pr_245_his, std_mean_dif_tran_245_his, std_mean_dif_eva_245_his;      % 245-his情景
%     std_mean_dif_wa_585_his, std_mean_dif_pr_585_his, std_mean_dif_tran_585_his, std_mean_dif_eva_585_his;       % 585-his情景
% ];



% 整理数据用于绘图
modelmean_difs = [
    % 顺序: p, tran, eva 对应每个情景
    modelmean_dif_wa_245_his,  modelmean_dif_pr_245_his, modelmean_dif_tran_245_his, modelmean_dif_eva_245_his;   % 245-his情景
];

std_mean_difs = [
    std_mean_dif_wa_245_his, std_mean_dif_pr_245_his, std_mean_dif_tran_245_his, std_mean_dif_eva_245_his;      % 245-his情景
];



%% 8.1.4  山脊图 dry season  245                               step-1224


h4 = subplot('Position', [0.58,0.615,0.28,0.175]);
hold(h4, 'on');  % 添加hold

% -------------------------------
% 依赖变量（请保证已经在 workspace 中）
data_vars = {
   mean_dif_wa_245_his;
   mean_dif_pr_245_his;
   mean_dif_tran_245_his;
   mean_dif_eva_245_his
};
var_names = {'W_d','P','T','E'};

base_colors1 = [
    176 104 108;    % Wa
    197 228 246;   % P
    160 175 160; %236 229 187;  % T 57 151 45
    229 178 186    % E 218 141 133
] / 255;


c245 = base_colors1;          % 245情景

% 横轴范围 - 扩展左边界为文本留空间
x_min = -7; x_max = 12;
x_grid = linspace(x_min, x_max, 600);

nVars = size(data_vars,1);
y_spacing = 1;                     % 每条ridge之间的垂直间隔
base_positions = (nVars:-1:1) * y_spacing;

% 垂直分离量（让两个情景在同一变量行内可见）
sep = 0.18 * y_spacing;  % 245 向上偏移，585 向下偏移

for v = 1:nVars
    % 两个情景的数据
    data1 = data_vars{v,1}; data1 = data1(isfinite(data1));
    %data2 = data_vars{v,2}; data2 = data2(isfinite(data2));
    
    yoffset = base_positions(v);
    
    % 若数据存在则绘制密度
    if ~isempty(data1)
        [f1, xi1] = ksdensity(data1, x_grid);
        if any(f1>0)
            f1 = f1 / max(f1) * 0.85 * (y_spacing/1.1);
            Y1 = f1 + (yoffset + sep);     % 245 向上偏移
            % 填充 245（深色，较高不透明度）
            fill(h4, [xi1 fliplr(xi1)], [Y1 fliplr(repmat(yoffset+sep,size(Y1)))], c245(v,:), ...
                'FaceAlpha',0.99, 'EdgeColor','none');
            %plot(h4, xi1, Y1, 'Color', darken(c245(v,:),0.25), 'LineWidth',0.6);
            plot(h4, xi1, Y1, 'Color', [0 0 0]/255, 'LineWidth',0.6);
            % 中位数和均值标注
            q50_1 = median(data1); mval1 = mean(data1);
            y_q50_1 = safe_interp(xi1, Y1, q50_1, yoffset+sep);
            y_mean_1 = safe_interp(xi1, Y1, mval1, yoffset+sep);
            

            % 中位数用深灰色实线垂直线段表示
            plot(h4, [q50_1 q50_1], [yoffset+sep, y_q50_1], '-', 'Color', [0.5 0.5 0.5], 'LineWidth', 1);

            % 均值用深灰色虚线垂直线段表示
            plot(h4, [mval1 mval1], [yoffset+sep, y_mean_1], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
            % % 中位数用白色实线垂直线段表示
            % plot(h4, [q50_1 q50_1], [yoffset+sep, y_q50_1], 'w-', 'LineWidth', 1);
            % 
            % % 均值用白色虚线垂直线段表示
            % plot(h4, [mval1 mval1], [yoffset+sep, y_mean_1], 'w--', 'LineWidth', 1);
        end
    end
    
    % 添加变量名在左侧 - 在xlim范围内 2可以改为1.5
    text(h4, x_min - 2.5, yoffset, var_names{v}, ...
        'FontSize',12, ...
        'FontName','Arial', ...
        'FontWeight','normal', ...
        'HorizontalAlignment','left', ...
        'VerticalAlignment','middle');
end

% 轴和网格美化
xlim(h4, [x_min, x_max]);
ylim(h4, [0.5, max(base_positions) + 1.2]);
%set(h4, 'YTick', [], 'FontSize',12, 'FontName','Arial');

% xlabel(h4, 'Δ (mm month^{-1})', 'FontSize',12, 'FontName','Arial');

set(h4, 'YTick', [],  'XTick', [ -5, 0, 5, 10], 'FontSize', 12, 'FontName', 'Arial');

% y=0 参考线
yl = ylim(h4);
plot(h4, [0 0], yl, 'k--', 'LineWidth',1, 'HandleVisibility','off');

% 网格（横向）
h4.XGrid = 'on';
h4.GridLineStyle = '--';
h4.GridColor = [0.5 0.5 0.5];
h4.GridAlpha = 0.35;
h4.Box = 'off';
set(h4, 'LineWidth', 1);

%%===== 手动图例 - 使用rectangle确保大小一致 =====
lx = -6.5;          % 图例起始x坐标
lw = 1;             % 图例框宽度
lh = 0.3;           % 图例框高度
ly = [4.7, 4.25];     % 两个图例的y坐标

title(h4, '(c) Changes of ΔW_d under SSP2-4.5', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');
% 最终调整与导出
set(gcf,'Color','w');


%% (9) 585

%% (8.1.3)计算所有模型的频率的均值和标准差

%整理数据用于绘图
modelmean_difs = [
    % 顺序: p, tran, eva 对应每个情景
       modelmean_dif_wa_585_his, modelmean_dif_pr_585_his, modelmean_dif_tran_585_his, modelmean_dif_eva_585_his;    % 585-his情景
];

std_mean_difs = [
        std_mean_dif_wa_585_his, std_mean_dif_pr_585_his, std_mean_dif_tran_585_his, std_mean_dif_eva_585_his;       % 585-his情景
];





%% 8.1.4  山脊图 dry season  245                               step-1224


h4 = subplot('Position', [0.58,0.37,0.28,0.175]);
hold(h4, 'on');  % 添加hold

% -------------------------------
% 依赖变量（请保证已经在 workspace 中）
data_vars = {
   mean_dif_wa_585_his;
   mean_dif_pr_585_his;
   mean_dif_tran_585_his;
   mean_dif_eva_585_his
};
var_names = {'W_d','P','T','E'};

base_colors1 = [
    176 104 108;    % Wa
    197 228 246;   % P
    160 175 160; %236 229 187;  % T 57 151 45
    229 178 186    % E 218 141 133
] / 255;


c245 = base_colors1;          % 245情景

% 横轴范围 - 扩展左边界为文本留空间
x_min = -7; x_max = 12;
x_grid = linspace(x_min, x_max, 600);

nVars = size(data_vars,1);
y_spacing = 1;                     % 每条ridge之间的垂直间隔
base_positions = (nVars:-1:1) * y_spacing;

% 垂直分离量（让两个情景在同一变量行内可见）
sep = 0.18 * y_spacing;  % 245 向上偏移，585 向下偏移

for v = 1:nVars
    % 两个情景的数据
    data1 = data_vars{v,1}; data1 = data1(isfinite(data1));
    %data2 = data_vars{v,2}; data2 = data2(isfinite(data2));
    
    yoffset = base_positions(v);
    
    % 若数据存在则绘制密度
    if ~isempty(data1)
        [f1, xi1] = ksdensity(data1, x_grid);
        if any(f1>0)
            f1 = f1 / max(f1) * 0.85 * (y_spacing/1.1);
            Y1 = f1 + (yoffset + sep);     % 245 向上偏移
            % 填充 245（深色，较高不透明度）
            fill(h4, [xi1 fliplr(xi1)], [Y1 fliplr(repmat(yoffset+sep,size(Y1)))], c245(v,:), ...
                'FaceAlpha',0.99, 'EdgeColor','none');
            %plot(h4, xi1, Y1, 'Color', darken(c245(v,:),0.25), 'LineWidth',0.6);
            plot(h4, xi1, Y1, 'Color', [0 0 0]/255, 'LineWidth',0.6);
            % 中位数和均值标注
            q50_1 = median(data1); mval1 = mean(data1);
            y_q50_1 = safe_interp(xi1, Y1, q50_1, yoffset+sep);
            y_mean_1 = safe_interp(xi1, Y1, mval1, yoffset+sep);
            

            % 中位数用深灰色实线垂直线段表示
            plot(h4, [q50_1 q50_1], [yoffset+sep, y_q50_1], '-', 'Color', [0.5 0.5 0.5], 'LineWidth', 1);

            % 均值用深灰色虚线垂直线段表示
            plot(h4, [mval1 mval1], [yoffset+sep, y_mean_1], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
            % % 中位数用白色实线垂直线段表示
            % plot(h4, [q50_1 q50_1], [yoffset+sep, y_q50_1], 'w-', 'LineWidth', 1);
            % 
            % % 均值用白色虚线垂直线段表示
            % plot(h4, [mval1 mval1], [yoffset+sep, y_mean_1], 'w--', 'LineWidth', 1);
        end
    end
    
    % 添加变量名在左侧 - 在xlim范围内 2可以改为1.5
    text(h4, x_min - 2.5, yoffset, var_names{v}, ...
        'FontSize',12, ...
        'FontName','Arial', ...
        'FontWeight','normal', ...
        'HorizontalAlignment','left', ...
        'VerticalAlignment','middle');
end

% 轴和网格美化
xlim(h4, [x_min, x_max]);
ylim(h4, [0.5, max(base_positions) + 1.2]);
%set(h4, 'YTick', [], 'FontSize',12, 'FontName','Arial');

xlabel(h4, 'Δ (mm month^{-1})', 'FontSize',12, 'FontName','Arial');

set(h4, 'YTick', [],  'XTick', [ -5, 0, 5, 10], 'FontSize', 12, 'FontName', 'Arial');

% y=0 参考线
yl = ylim(h4);
plot(h4, [0 0], yl, 'k--', 'LineWidth',1, 'HandleVisibility','off');

% 网格（横向）
h4.XGrid = 'on';
h4.GridLineStyle = '--';
h4.GridColor = [0.5 0.5 0.5];
h4.GridAlpha = 0.35;
h4.Box = 'off';
set(h4, 'LineWidth', 1);

%%===== 手动图例 - 使用rectangle确保大小一致 =====
lx = -6.5;          % 图例起始x坐标
lw = 1;             % 图例框宽度
lh = 0.3;           % 图例框高度
ly = [4.7, 4.25];     % 两个图例的y坐标

title(h4, '(d) Changes of ΔW_d under SSP5-8.5', 'FontSize',12, 'FontWeight','bold', 'FontName','Arial');
% 最终调整与导出
set(gcf,'Color','w');














%% 出图
filename='Figure2_260203'
print(filename,'-dpng','-r300')
% print(filename,'-depsc','-r300')
































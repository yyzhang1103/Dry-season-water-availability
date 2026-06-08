

%%

clear; clc;

load ..\cmip\SSP245_scenario.mat


time_range = 1:121;
total_models = 9;
[n_space, ~, ~] = size(A_245_all);

model = @(p, x)(p(1).*x(:,3)) .* exp(-p(2).*x(:,1)) .* (p(3).*x(:,2) + p(4));

lb = [0, 0, -Inf, -Inf];
ub = [Inf, Inf, Inf, Inf];
p0 = [0.6, 0.2, 1, 1];

opts = optimoptions('lsqcurvefit', ...
    'Display', 'off', ...
    'FiniteDifferenceType', 'central');

for model_idx = 1:total_models

    para_values = nan(n_space, 4);
    ci_low_values = nan(n_space, 4);
    ci_high_values = nan(n_space, 4);
    rmse_values = nan(n_space, 1);
    resnorm_values = nan(n_space, 1);
    exitflag_values = nan(n_space, 1);
    valid_data_counts = zeros(n_space, 1);

    for i = 1:n_space

        if mod(i, 1000) == 0
            fprintf('model %d: %d/%d\n', model_idx, i, n_space);
        end

        A   = squeeze(A_245_all(i, time_range, model_idx));      A = A(:);
        es  = squeeze(es_245_all(i, time_range, model_idx));    es = es(:);
        sm  = squeeze(mrsos_245_all(i, time_range, model_idx));  sm = sm(:);
        lai = squeeze(lai_245_all(i, time_range, model_idx));    lai = lai(:);

        mask = isfinite(A) & isfinite(es) & isfinite(sm) & isfinite(lai) & abs(A) > 1e-12;
        valid_data_counts(i) = sum(mask);

        if sum(mask) > 4
            try
                xdata = [lai(mask), sm(mask), A(mask)];
                ydata = es(mask);

                [p_est, resnorm, residual, exitflag, ~, ~, J] = ...
                    lsqcurvefit(model, p0, xdata, ydata, lb, ub, opts);

                if exitflag > 0 && all(isfinite(p_est))
                    es_fit = model(p_est, xdata);
                    ci = nlparci(p_est, residual, 'jacobian', J);

                    para_values(i, :) = p_est;
                    ci_low_values(i, :) = ci(:, 1)';
                    ci_high_values(i, :) = ci(:, 2)';
                    rmse_values(i) = sqrt(mean((es_fit - ydata).^2));
                    resnorm_values(i) = resnorm;
                    exitflag_values(i) = exitflag;
                end

            catch
            end
        end
    end

    alpha_values = para_values(:, 1);
    k_values     = para_values(:, 2);
    a_values     = para_values(:, 3);
    b_values     = para_values(:, 4);

    alpha_ci_low = ci_low_values(:, 1);
    k_ci_low     = ci_low_values(:, 2);
    a_ci_low     = ci_low_values(:, 3);
    b_ci_low     = ci_low_values(:, 4);

    alpha_ci_high = ci_high_values(:, 1);
    k_ci_high     = ci_high_values(:, 2);
    a_ci_high     = ci_high_values(:, 3);
    b_ci_high     = ci_high_values(:, 4);

end










%%

clear; clc;

load ..\cmip\SSP585_scenario.mat

time_range = 1:121;
total_models = 9;
[n_space, ~, ~] = size(A_585_all);

model = @(p, x)(p(1).*x(:,3)) .* exp(-p(2).*x(:,1)) .* (p(3).*x(:,2) + p(4));

lb = [0, 0, -Inf, -Inf];
ub = [Inf, Inf, Inf, Inf];
p0 = [0.6, 0.2, 1, 1];

opts = optimoptions('lsqcurvefit', ...
    'Display', 'off', ...
    'FiniteDifferenceType', 'central');

for model_idx = 1:total_models

    para_values = nan(n_space, 4);
    ci_low_values = nan(n_space, 4);
    ci_high_values = nan(n_space, 4);
    rmse_values = nan(n_space, 1);
    resnorm_values = nan(n_space, 1);
    exitflag_values = nan(n_space, 1);
    valid_data_counts = zeros(n_space, 1);

    for i = 1:n_space

        if mod(i, 1000) == 0
            fprintf('model %d: %d/%d\n', model_idx, i, n_space);
        end

        A   = squeeze(A_585_all(i, time_range, model_idx));      A = A(:);
        es  = squeeze(es_585_all(i, time_range, model_idx));    es = es(:);
        sm  = squeeze(mrsos_585_all(i, time_range, model_idx));  sm = sm(:);
        lai = squeeze(lai_585_all(i, time_range, model_idx));    lai = lai(:);

        mask = isfinite(A) & isfinite(es) & isfinite(sm) & isfinite(lai) & abs(A) > 1e-12;
        valid_data_counts(i) = sum(mask);

        if sum(mask) > 4
            try
                xdata = [lai(mask), sm(mask), A(mask)];
                ydata = es(mask);

                [p_est, resnorm, residual, exitflag, ~, ~, J] = ...
                    lsqcurvefit(model, p0, xdata, ydata, lb, ub, opts);

                if exitflag > 0 && all(isfinite(p_est))
                    es_fit = model(p_est, xdata);
                    ci = nlparci(p_est, residual, 'jacobian', J);

                    para_values(i, :) = p_est;
                    ci_low_values(i, :) = ci(:, 1)';
                    ci_high_values(i, :) = ci(:, 2)';
                    rmse_values(i) = sqrt(mean((es_fit - ydata).^2));
                    resnorm_values(i) = resnorm;
                    exitflag_values(i) = exitflag;
                end

            catch
            end
        end
    end

    alpha_values = para_values(:, 1);
    k_values     = para_values(:, 2);
    a_values     = para_values(:, 3);
    b_values     = para_values(:, 4);

    alpha_ci_low = ci_low_values(:, 1);
    k_ci_low     = ci_low_values(:, 2);
    a_ci_low     = ci_low_values(:, 3);
    b_ci_low     = ci_low_values(:, 4);

    alpha_ci_high = ci_high_values(:, 1);
    k_ci_high     = ci_high_values(:, 2);
    a_ci_high     = ci_high_values(:, 3);
    b_ci_high     = ci_high_values(:, 4);

end

















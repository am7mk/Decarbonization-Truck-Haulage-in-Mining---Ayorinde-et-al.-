%% Experiment 2: Effect of Carbon Tax (G) at t=0
clear; clc;

% Fixed parameters
C0 = [3, 6, 9]; % Diesel, BEV, H2FC
C1_init = [0.1, 0.2, 0.3]; 
e = [0.95, 0.15, 0.05];
G_vals = [0, 19, 35];
alpha = 0.7; beta = 0.3; A = 1; q = 1500;

results = zeros(length(G_vals), 3);
for i = 1:length(G_vals)
    G = G_vals(i);
    Mstar = solve_Mstar(C0, C1_init, e, G, alpha, beta, A, q);
    results(i, :) = (Mstar / sum(Mstar)) * 100; % Convert to percentage
end

% Plotting
figure('Color', 'w');
b = bar(G_vals, results, 'stacked', 'FaceColor', 'flat');

% Updated Color Scheme: Diesel (Gray), BEV (Blue), H2FC (Green)
b(1).CData = [0.5 0.5 0.5]; % Diesel
b(2).CData = [0.2 0.6 1.0]; % BEV (Blue)
b(3).CData = [0.4 0.8 0.4]; % H2FC (Green)

ylim([0 100]);
set(gca, 'YTick', 0:20:100);

% Add Percentage Labels
for i = 1:size(results, 1)
    cumulative_height = 0;
    for j = 1:size(results, 2)
        val = results(i, j);
        if val > 2 
            text(G_vals(i), cumulative_height + val/2, sprintf('%.1f%%', val), ...
                'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 9, 'FontWeight', 'bold');
        end
        cumulative_height = cumulative_height + val;
    end
end

xlabel('Carbon Price G ($/ton)');
ylabel('Fleet Composition (%)');
title('Fleet Mix vs. Carbon Price (at t=0)');
legend({'Diesel', 'BEV', 'H2FCV'}, 'Location', 'northeastoutside');
grid on;
set(gca, 'XTick', G_vals);

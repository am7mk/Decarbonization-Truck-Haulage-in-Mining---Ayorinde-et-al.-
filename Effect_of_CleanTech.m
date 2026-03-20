%% Experiment 3: Effect of Clean Tech Cost (C0) at t=0
clear; clc;

% Fixed parameters
G = 19;
C1_init = [0.1, 0.2, 0.3];
e = [0.95, 0.15, 0.05];
alpha = 0.7; beta = 0.3; A = 1; q = 1500;

% Scenarios: [Diesel, BEV, H2FC]
C0_scenarios = [3, 9, 12; 3, 6, 9; 3, 4, 7];
labels = {'High Cost', 'Moderate', 'Low Cost'};

results = zeros(3, 3);
for i = 1:3
    C0 = C0_scenarios(i, :);
    Mstar = solve_Mstar(C0, C1_init, e, G, alpha, beta, A, q);
    results(i, :) = (Mstar / sum(Mstar)) * 100;
end

% Plotting
figure('Color', 'w');
categorical_labels = categorical(labels, labels);
b = bar(categorical_labels, results, 'stacked');

% Updated Color Scheme: Diesel (Gray), BEV (Blue), H2FC (Green)
b(1).FaceColor = [0.5 0.5 0.5]; % Diesel
b(2).FaceColor = [0.2 0.6 1.0]; % BEV (Blue)
b(3).FaceColor = [0.4 0.8 0.4]; % H2FC (Green)

ylim([0 100]);
set(gca, 'YTick', 0:20:100);

% Add Percentage Labels
for i = 1:size(results, 1)
    cumulative_height = 0;
    for j = 1:size(results, 2)
        val = results(i, j);
        if val > 2
            text(i, cumulative_height + val/2, sprintf('%.1f%%', val), ...
                'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 9, 'FontWeight', 'bold');
        end
        cumulative_height = cumulative_height + val;
    end
end

ylabel('Fleet Composition (%)');
title('Fleet Mix vs. Technology Cost Maturity (at t=0)');
legend({'Diesel', 'BEV', 'H2FC'}, 'Location', 'northeastoutside');
grid on;
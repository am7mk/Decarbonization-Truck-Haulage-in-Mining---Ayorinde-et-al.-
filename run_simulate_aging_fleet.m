%% Clear screen and variables
clear;
clc;


%% Initialize input
C1_base = [0.1 0.2 0.3];
t_step  = 0.1;
t_end   = 10;
aging_rates = [0.0075 0.0005 0.0005];
C0 = [3.0, 6.0, 9.0];
e = [0.95, 0.15, 0.05];
G = 19;
alpha = 0.7;  
beta = 0.3;
A = 1; 
q = 1500;% SENSITIVE SCALE Supposed to be 150e3

%% Define Scenarios for Aging Rates
% Each row: [Diesel Rate, BEV Rate, Hydrogen Rate]
% Scenario 1: [0.0075 0.0005 0.0005] (Base Case)
% Scenario 2: [0.0150 0.0005 0.0005] (Rapid Diesel Degradation)
% Scenario 3: [0.0050 0.0005 0.0005] (Slow/Improved Diesel Maintenance)

aging_scenarios = [0.0075, 0.0005, 0.0005; 
                   0.0150, 0.0005, 0.0005; 
                   0.0050, 0.0005, 0.0005];

aging_titles = {'Base Aging Rates', 'High Diesel Aging (Rapid)', 'Low Diesel Aging (Resilient)'};

%% Run Loop
for i = 1:3
    % Select current aging rates scenario
    current_aging = aging_scenarios(i, :); 
    current_title = aging_titles{i};
    
    % Call the simulation function
    simulate_aging_fleet(C1_base, t_step, t_end, current_aging, C0, e, G, alpha, beta, A, q, current_title);
end

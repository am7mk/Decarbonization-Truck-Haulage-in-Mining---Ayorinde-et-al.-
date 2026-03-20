function simulate_aging_fleet(C1_base, t_step,t_end, aging_rates, C0, e, G, alpha, beta, A, q, current_title)
% Temporal optimization of heterogeneous mine haulage fleets
% % This function implements the economic framework from Akinrinlola et al. (2026) % to determine cost-minimizing mileage allocation across Diesel, BEV, and % Hydrogen technologies. it models the transition to clean energy by % evaluating the trade-off between rising maintenance costs (aging) and % environmental penalties (carbon tax G).
% % % Solves a cost-minimization problem under a Cobb–Douglas production constraint by updating aging costs over time, calling solve_Mstar to compute optimal technology mileages, and generating fleet-share transition plots showing when clean technologies overtake diesel.

%% Initialize input

if nargin < 5
    C0 = [3.0, 6.0, 9.0];
    e = [0.95, 0.15, 0.05];
    G = 0;
    alpha = 0.7;  
    beta = 0.3;
    A = 1;
    q = 1500;%SENSITIVE SCALE Supposed to be 150e3
elseif nargin < 6
    e = [0.95, 0.15, 0.05];
    G = 0;
    alpha = 0.7;  
    beta = 0.3;
    A = 1;
    q = 1500; %SENSITIVE SCALE Supposed to be 150e3
elseif nargin < 7
    G = 19;
    alpha = 0.7;  
    beta = 0.3;
    A = 1;
    q = 1500;%SENSITIVE SCALE Supposed to be 150e3
elseif nargin < 8
    alpha = 0.7;  
    beta = 0.3;
    A = 1;
    q = 1500;%SENSITIVE SCALE Supposed to be 150e3
elseif nargin < 9
    beta = 0.3;
    A = 1;
    q = 1500;%SENSITIVE SCALE Supposed to be 150e3
elseif nargin < 10 
    A = 1;
    q = 1500;%SENSITIVE SCALE Supposed to be 150e3
elseif nargin < 11 
    q = 1500;%SENSITIVE SCALE Supposed to be 150e3
end

%% Initialize other variables
C1 = C1_base;
age_steps = 0:t_step:t_end;
ratios  = zeros(3,length(age_steps));

%% Estimate ratios
for t = 1:length(age_steps)
    C1 = C1 + aging_rates*age_steps(t);
    
    Mstar  = solve_Mstar(C0, C1, e, G, alpha, beta, A, q);
    ratios(:,t) = Mstar/sum(Mstar);

    
end

%% Plotting
figure;
p = plot(age_steps, ratios, 'LineWidth', 2.5); 
xlabel('Fleet age (yrs)')
ylabel('Fleet share')
legend('Diesel','BEV','Hydrogen')
title(current_title); 
grid on
p(1).Color = [0.4 0.4 0.4]; p(1).Marker = 'o'; p(1).MarkerSize = 4; p(1).MarkerIndices = 1:10:length(age_steps);
p(2).Color = [0.1 0.7 0.3]; p(2).Marker = 's'; p(2).MarkerSize = 4; p(2).MarkerIndices = 1:10:length(age_steps);
p(3).Color = [0.1 0.4 0.9]; p(3).Marker = '^'; p(3).MarkerSize = 4; p(3).MarkerIndices = 1:10:length(age_steps);

    

end
function Mstar = solve_Mstar(C0, C1, e, G, alpha, beta, A, q)
%SOLVE_MSTAR Solves for the optimal mileage based on Akinrinlola et al (2026)
% This function retuns the mileage for 3 technology mixes (e.g., diesel,
% battery electric vehicles, and hydrogen fuel cells) Mstar given 
%   C0 = vector of unit operating costs
%   C1 = vector of unit operating costs due to aging
%   e  = vector of emission rates
%   G  = cost of carbon
%   alpha = output elasticity for mileage
%   beta  = output elasticity for numeraire input 
%   A  = Mine production efficiency
%   q  = production%

Mstar = zeros(1,3);
k = (C0 + G*e);




const = alpha * q^(1/beta) / (beta * A^(1/beta));  % common factor

obj = @(Mt) Mt - ( sum( const ./ (Mt.^(1 + alpha/beta) .* C1) - k ./ C1 ) );

% Optional: guard against Mt <= 0 to avoid complex values
obj_safe = @(Mt) (Mt<=0) * 1e6 + (Mt>0) .* obj(Mt);

opts = optimset('Display','off','TolX',1e-10,'TolFun',1e-10,'MaxIter',1e4,'MaxFunEvals',1e5);
M_total = fsolve(obj_safe, 100, opts);


% Optimal shares
for i = 1:3
    Mstar(i) = alpha*(q^(1/beta))/(beta*(M_total^(1+alpha/beta))*(A^(1/beta))*C1(i)) - k(i)/C1(i);
end


end
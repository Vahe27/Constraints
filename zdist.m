function y = zdist(mu,sigma,n,DIST);

% Created 11.04.2017
% Last Update ----

% Creates the managerial talent grid. If DIST=1 the distribution assumed is
% Pareto, mu is the scale parameter and sigma - the shape parameter. 


zstep   = 1/n;
Fz      = linspace(zstep,1,n)'-zstep/2; 

% DIST  = 1 Pareto, DIST = 2 Log-Normal 
if DIST == 1
z(:,2)  = mu * (1 - Fz).^(-1/sigma); % Each value of z has ztep weight
z(:,1)  = zstep;
end

y = [zstep*ones(n,1) z(:,2)];

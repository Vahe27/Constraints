function y = kapdist(mu,sigma,n,dist);

% Created 11.04.2017
% Last Update ---

% Creates a grid for the distribution of kappa, disutility from work, if
% dist = 1, then the disutility is Pareto distributed with scale mu and
% shape sigma

kapstep = 1/n;
Fkap    = linspace(kapstep,1,n)' - kapstep/2; 

if dist == 1

kap(:,2)  = mu * (1 - Fkap).^(-1/sigma); % Each value of z has ztep weight
kap(:,1)  = kapstep;

end

y = [kapstep*ones(n,1) kap(:,2)];

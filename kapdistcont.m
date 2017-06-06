function y = kapdistcont(mu,sigma,NN,TT,KAPdist);


% Created 03.06.2017
% Last Update ---

% Creates values for kappa in the stationary distribution, if
% dist = 1, then the disutility is Pareto distributed with scale mu and
% shape sigma. The distribution will be continuous

box = rand(NN,1);


y  = mu * (1 - box).^(-1/sigma);



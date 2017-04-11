function y = prodshock(mu, sigma,n,indicator)

% Created 11.04.2017
% Last update  ----

% Generates the vector of transitory shocks epsilon and probabilities P
% Indicator equals 1 if the shock distribution is assumed to be normal with
% mean mu and variance sigma^2 n is the number of grid points

if n == 1
    yy = [mu sigma];
elseif indicator == 1
    shockstep = 1/n;
    yy(:,1) = linspace(shockstep,1,n) - shockstep/2;
    yy(:,2) = norminv(yy(:,1),mu,sigma);
    yy(:,1) = shockstep;

end
 
y = yy;

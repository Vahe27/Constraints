function y = prodshock(mu, sigma,n,indicator)

% Created: 09.08.2017
% Last Update: ---

% This formula takes mean and variance values of a distribution of the
% probability to default for individuals if they choose to become
% self-employed. indicator = 1 means that the shock probabilities are
% Pareto distributed, while indicator = 2 is Normal distribution. n is the
% number of grid points

% The strategy is as follows: I create a equally spaced grid of n points,
% and divide a [0,1] interval into n equal intervals, each interval has the
% same weight, then I take the midpoints of the intervals, find the values 
% that are generated from the assumed distribution, then the midpoint 
% values will realize with the same probability, I then normalize and
% invert them so that higher probability of default occurs with lower
% likelihood

step = 1/n;
Fstep = linspace(step,1,n)' - step/2;

if indicator == 1
    
    temp = (1 - Fstep).^(-1/sigma);
    prob = 1 - 1./temp;
    
elseif indicator == 2
    temp = logninv(Fstep,mu,sigma);
    temp = temp./temp(1);
    prob = 1-1./temp;
end

 y = prob;
 
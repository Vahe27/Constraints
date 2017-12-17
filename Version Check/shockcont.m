function y = shockcont(mu,sigma,N,indicator,upp);

% Created: 09.08.2017
% Last Update: ---

% This function creates a vector of continuous probabilities of default for
% the stationary distribution

box = rand(N,1);

if indicator == 1
    temp = mu*(1-box).^(-1/sigma);
    prob = 1 - 1./temp;
elseif indicator == 2
    temp = logninv(box,mu,sigma,N);
    temp = temp./min(temp);
    prob = 1-1./temp;
elseif indicator == 3
box = upp*box;
temp = mu*(1-box).^(-1/sigma);
    prob = 1 - 1./temp;
end

y = prob;


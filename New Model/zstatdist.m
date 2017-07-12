function y = zstatdist(z, nz,psi,NN,TT)

% Created: 19.04.2017
% Last Update: ---

% Creates the stationary unconditional distribution of talents, NN-the
% number of simulated agents, TT number of periods, psi - the probability
% of changing talent, the output y (NN x TT)

rng(1)

y = [ones(NN,1) rand(NN,TT-1)];
y(y>1-psi) = 1;
y(y<1)     = 0;

y(:,1) = randsample(z,NN,1);

for ii = 2:TT
    TEMP1 = y(:,ii-1);
    TEMP2 = y(:,ii);
    
    TEMP2(TEMP2==1) = randsample(z,sum(TEMP2),1);
    TEMP2(TEMP2==0) = TEMP1(TEMP2==0);
    
    y(:,ii) = TEMP2;
    
end
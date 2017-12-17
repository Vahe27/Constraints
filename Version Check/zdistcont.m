function y = zdistcont(mu, etta,PSI,NN,TT,ZDist,upperzprob)

% Created: 01.06.2017
% Last Update: 16.11.2017 I add quadratures, which means I have ZDist=2
% option

% Creates the stationary unconditional distribution of talents, NN-the
% number of simulated agents, TT number of periods, psi - the probability
% of changing talent, the output y (NN x TT)
% in comparison to zstatdist, this one draws from the continuous
% distribution of z s


rng(1)

if (ZDist ~= 1 && ZDist ~= 2)
    warning('check the talent distributions')
else
    box            = rand(NN,TT);
    chnge          = rand(NN,TT);
chnge(chnge>1-PSI) = 1;
chnge(chnge<1)     = 0;

for ii = 2:TT
    TEMP1 = box(:,ii-1);
    TEMP2 = box(:,ii);
    
    TEMP2(chnge(:,ii)==1) = rand(sum(chnge(:,ii)==1),1);
    TEMP2(chnge(:,ii)==0) = TEMP1(chnge(:,ii)==0);
    
    box(:,ii) = TEMP2;
    
end
    
end    
box(box>upperzprob) = upperzprob-1e-15;
y  = mu * (1 - box).^(-1/etta);

end
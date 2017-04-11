function y = kapdist(mu,sigma,n,dist);

kapstep = 1/n;
Fkap    = linspace(kapstep,1,n)' - kapstep/2; 

if dist == 1

kap(:,2)  = mu * (1 - Fkap).^(-1/sigma); % Each value of z has ztep weight
kap(:,1)  = kapstep;

end

y = [kapstep*ones(n,1) kap(:,2)];

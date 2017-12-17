function y = zdist(mu,sigma,n,DIST,prmax)


% Created 11.04.2017
% Last Update 19.05.2017 Add Quadrature option

% Creates the managerial talent grid. If DIST=1 the distribution assumed is
% Pareto, mu is the scale parameter and sigma - the shape parameter. 

% Gauss-Legendre quadrature weights and values x in [-1;1] data taken from
% https://pomax.github.io/bezierinfo/legendre-gauss.html#n20
% Precision only 15 original data - 16 xN = [weught xi]

% Quadrature method-GaussLegendre, borrowed from Tim and Judd (1998)
zstep   = 1/n;
Fz      = linspace(zstep,1,n)'-zstep/2; 

% DIST  = 1 Pareto, DIST = 2 Log-Normal 
if DIST == 1
z(:,2)  = mu * (1 - Fz).^(-1/sigma); % Each value of z has ztep weight
z(:,1)  = zstep;

y = [zstep*ones(n,1) z(:,2)];

elseif DIST == 2 % Quadrature Option
    minz = 1*mu;
    maxz = mu*( 1 - prmax)^(-1/sigma);
        
    GaussLegendre;
    wghtmtx = eval(['x' num2str(n)]);
    clear x10 x15 x20 x25 x30 x35 x40 x45 x5 x50 x7
    zval = ((wghtmtx(:,2)+1)/2*(maxz-minz)+minz);
    Prz  = wghtmtx(:,1).* (maxz-minz)/2;
    probz = (sigma/mu)*(zval./mu).^(-sigma-1);
    Prz  = probz.*Prz./prmax;
    [zval ii] = sort(zval);
    Prz = Prz(ii);
    zval(1) = minz;
    zval(end) = maxz;
%zval = (wghtmtx(:,2)+1)*(maxz-minz)/2 + minz;
%fz   = sigma*(zval./mu).^(-sigma-1)./(prmax);
    
y = [Prz zval];
end


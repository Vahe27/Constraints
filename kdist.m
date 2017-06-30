function y = kdist(nk,sigz,etta,r,w,gridtype);

global alfa deltta nu gama

% Created: 26.06.2017
% Last Update: ----

% This function creates a grid for capital from which the entrepreneurs can
% choose their investment levels. nk is the number of grid points, kmethod
% tells how the grid points are distributed, either it is equal size
% distribution, or log, or some other type

rmax = max(max(r));
rmin = min(min(r));

PRz  = 0.995;
maxz = sigz*(1 - PRz)^(-1/etta);



kmin = 0;
kmax = maxz .^ (1/(1 - nu)) * (alfa/(deltta + rmin))...
   ^((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));


% If gridtype is 0, then we use the simple linear grid, if it is 1, then  
% the log grid, in other cases it will be adjusted 

if gridtype == 0 
    y = linspace(kmin,kmax,nk);
elseif gridtype == 1
    y = logspace(log(kmin+.01)/log(10),log(kmax)/log(10),nk-1);
    y = [0 y];
end;
    
function y = kdist(nk,sigz,etta,r,w,gridtype);

global alfa deltta nu gama varphi

% Created: 26.06.2017
% Last Update: ----

% This function creates a grid for capital from which the entrepreneurs can
% choose their investment levels. nk is the number of grid points, kmethod
% tells how the grid points are distributed, either it is equal size
% distribution, or log, or some other type

rmax = max(r,[],2);
rmin = min(r,[],2);

PRz  = 0.995;
maxz = sigz*(1 - PRz)^(-1/etta);



kmin = 0;

kmax(1) = (maxz*varphi) .^ (1/(1 - nu)) .* (alfa/(deltta + rmin(1)))...
   ^((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu)); 

kmax(2) = maxz .^ (1/(1 - nu)) .* (alfa/(deltta + rmin(2)))...
   ^((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));


% If gridtype is 0, then we use the simple linear grid, if it is 1, then  
% the log grid, in other cases it will be adjusted 

if gridtype == 0 
    y(1,:) = linspace(kmin,kmax(1),nk);
    y(2,:) = linspace(kmin,kmax(2),nk);
elseif gridtype == 1
    y(1,:) = logspace(log(kmin+.01)/log(10),log(kmax(1))/log(10),nk-1);
    y(2,:) = logspace(log(kmin+.01)/log(10),log(kmax(2))/log(10),nk-1);
    y = [[0;0] y];
else
    y(1,:) = linspace(0.01^(1/gridtype),kmax(1)^(1/gridtype),nk-1);
    y(2,:) = linspace(0.01^(1/gridtype),kmax(2)^(1/gridtype),nk-1);
    y = y.^gridtype;
    y = [[0;0] y];
end;
    
function y = disU(U,nz,na,nk,kappa)

% Created: 18.04.2017
% Last Update: --

% This function has U(x,na,na) as its imput, the utility of an individual
% of talent x, asset endowment na and asset choice na. It gives out a
% function U(x,na,na,nkap) where on the 4th dimension we have the input
% utilities but with different values of the disutility from work

if size(U,1) == 1
    nx = nz;
elseif size(U,1) == nz
    nx = 1;
else 
    error('check the dimensions of the utility functions')
end

y = repmat(U,nx,1,1,nk) - repmat(reshape(kappa,1,1,1,nk),nz,na,na,1);
function y = occs(W,N,S,na,nz,nkap)

% Created: 11.05.2017
% Last Update: ----


% Create occupational indexes, given the value functions. I assume all the
% value function are of the same dimensions that's why I only check for the
% dimensions of one. If index is 1, the guy with the given z,kappa and
% assets chooses to become a non-employed, if it is 2, then he works and if
% 3, he becomes self-employed.

y = zeros(nz*nkap,na,2);

n = size(W);

%{
if n(1) == na 
    if n(2) == nz
        W = reshape(permute(W,[2 3 1]),nz*nkap,na);
        S = reshape(permute(S,[2 3 1]),nz*nkap,na);
        N = reshape(permute(N,[2 3 1]),nz*nkap,na);
    else
        W = reshape(permute(W,[3 2 1]),nz*nkap,na);
        S = reshape(permute(S,[3 2 1]),nz*nkap,na);
        N = reshape(permute(N,[3 2 1]),nz*nkap,na);
    end
elseif n(1) == nz
    if n(2) == na
        W = reshape(permute(W,[1 3 2]),nz*nkap,na);
        S = reshape(permute(S,[1 3 2]),nz*nkap,na);
        N = reshape(permute(N,[1 3 2]),nz*nkap,na);
    else
        W = reshape(W,nz*nkap,na);
        S = reshape(S,nz*nkap,na);
        N = reshape(N,nz*nkap,na);
    end
else
    if n(2) == nz
        W = reshape(permute(W,[2 1 3]),nz*nkap,na);
        S = reshape(permute(S,[2 1 3]),nz*nkap,na);
        N = reshape(permute(N,[2 1 3]),nz*nkap,na);
    else
        W = reshape(permute(W,[3 1 2]),nz*nkap,na);
        S = reshape(permute(S,[3 1 2]),nz*nkap,na);
        N = reshape(permute(N,[3 1 2]),nz*nkap,na);
    end
end
%}

if length(n)>2 | n(1)~=nz*nkap
    error('check the dimensions of inputs')
end

IW = W>max(N,S);
IN = N>max(W,S);
IS = S>max(W,N);
INS = S>N;

y(:,:,1) = IN + IW*2 + IS*3;
y(:,:,2) = 1 + INS*2;
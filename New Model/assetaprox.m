function y  = assetaprox(Y,agrid,bnr,bneps,nz,na,nr,neps)

% Created: 21.04.2017
% Last Update: ---

%{
 bnr and bneps are the borrowing rate and shock indexes taken as the
 benchmark. I calculate the value function for those facing these shock
 and borrowing rate and get the policy functions, then for other people
 with the same z but different borrowing rate and shock (e.g. z,a1,r1,eps1)
 I apporximate their behavior to that of those who have different assets 
 and face benchmark borrowing rate and shock such that
 pi(z,a1,r1,eps1) = pi(z,a2,r2,eps2)
%}

%{ 
 Y_(nz x na x nr x neps)(i,j,k,l) is the income of the individual with
 talent zi, asset aj, facing borrowing rate rk and production shock epsl

 bench(nz x na)(i,j) is the benchmark income of those with talent zi, asset
 aj facing borrowing rate rbnr and production shock epsbneps
%}


bench = Y(:,:,bnr,bneps);
Y = reshape(Y,nz,na*nr*neps);

for ii = 1:nz
    
[Temp ITemp] = unique(bench(ii,:));

ITemp(1) = ITemp(2)-1;

Atilde(ii,:) = interp1(Temp,agrid(ITemp),Y(ii,:),[],'extrap');

end

y  = reshape(Atilde,nz,na,nr,neps);
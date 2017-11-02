function y  = assetaprox(Y,agrid,b,bneps,nz,na,neps,nshck)

global r_bar
% Created: 21.04.2017
% Last Update: 11.08.2017 Added a new state variable that defines how
% likely an individual is to face a production shock, and got rid of the
% signals
% Last Updte: 18.08.2017 Add the asset approximation for the unemployed, in
% particular, the question is how much assets does the self-employed with a
% given talent and shock probability have to have in order to generate
% b+agrid*(1+r_bar) cash at hand. for the business owners I don't need that
% part that's why if b is empty, I don't calculate the approximation for
% the unemployed

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


bench  = permute(Y(:,:,bneps,:),[1 4 2 3]);
Y      = permute(Y,[1 4 2 3]); % nz nshck na neps


Y      = reshape(Y,nz*nshck,na*neps);
bench  = reshape(bench, nz*nshck,na);

if isempty(b);
    
Atilde = zeros(nz*nshck,na*neps);
    
for ii = 1:nz*nshck
    
[Temp ITemp] = unique(bench(ii,:));

 ITemp = ITemp(~isnan(Temp));
 Temp = Temp(~isnan(Temp));

ITemp(1) = ITemp(2)-1;

Atilde(ii,:) = interp1(Temp,agrid(ITemp),Y(ii,:),[],'extrap');

end

y  = reshape(Atilde,nz,nshck,na,neps);

else

    Atilde = zeros(nz*nshck,na*(neps+1));

    
    for ii = 1:nz*nshck
    
[Temp ITemp] = unique(bench(ii,:));

ITemp(1) = ITemp(2)-1;
ITemp(ITemp==0) = 1;
Atilde(ii,:) = interp1(Temp,agrid(ITemp),[Y(ii,:) agrid*(1+r_bar)+b]...
    ,[],'extrap');

end

y  = reshape(Atilde,nz,nshck,na,neps+1);

end


y  = permute(y,[1 3 4 2]);
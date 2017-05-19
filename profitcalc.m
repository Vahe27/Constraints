function y = profitcalc(z,a,r,w,Capflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A NOTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If making a change in this function don't forget to adjust also the
% function which calcualtes labor, because they are almost the same for the
% part of employers laborcalcMCMC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Created 12.04.2017
% Last Update 20.04.2017 Make r multidimensional (signals)
% Last Update 24.04.2017 In line 124 replaced Kempmina with TKempmina

% Calculates the profits of each pair (z,a) for given borrowing interest
% rate and wage. The imputs are z(nz x 1), a(1 x na) r(nrx1) w(1x1). Output
% is 

global r_bar deltta alfa nu gama Gama

% Invested capital of own account workers (with no employee) under borrowing
% rate r_bar (1) and borrowing rate r (2). Three types, k(rbar)<a save
% (a-k), k(r)>a borrow (k-a) and k(rbar)>=a but k(bar)<=a invest a and
% borrow 0

na = length(a);
nz = length(z);
nr = length(r);
profit_own = zeros(nz,na,nr);
profit_emp = zeros(nz,na,nr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FOR CAPITAL MARKET %%%%%%%%%%%%%%%%%%%%%%%%%%
if Capflag ~= 0
    Borrowedown = nan(nz,na,nr);
    Borrowedemp = nan(nz,na,nr);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Eq 2 in notes
kownacc(:,:,1) = (alfa/(r_bar + deltta))^(1/(1-alfa)) * Gama^(1/(1-alfa))...
    * repmat(z .^ (1/(1-alfa)),1,na);

for ii = 1:nr
kownacc(:,:,1+ii) = (alfa/(r(ii) + deltta))^(1/(1-alfa)) ...
    * Gama^(1/(1-alfa)) * repmat(z .^ (1/(1-alfa)),1,na);
end

Kown     = zeros(nz,na,nr+1); % (x+a)
Kownmina = zeros(nz,na,nr+1); % x = K - a to calculate the incomes

% Those who save
Temp  = kownacc(:,:,1);
Temp2 = repmat(a,nz,1) - kownacc(:,:,1);
TKown = Kown(:,:,1);
TKownmina = Kownmina(:,:,1);

TKown(Temp2>=0) = Temp(Temp2>=0);
TKownmina(Temp2>0) = Temp2(Temp2>0) .* (1 + r_bar); 

Kown(:,:,1)     = TKown;
Kownmina(:,:,1) = TKownmina;
% Those who borrow

for ii = 1:nr
Temp = kownacc(:,:,ii+1);
Temp2 = repmat(a,nz,1) - kownacc(:,:,ii+1); 
TKown = Kown(:,:,ii+1);
TKownmina = Kownmina(:,:,ii+1);

TKown(Temp2<0)     = Temp(Temp2<0);
TKownmina(Temp2<0) =  Temp2(Temp2<0) .* (1+r(ii));

% Those who invest all
Temp = repmat(a,nz,1);

TKown(kownacc(:,:,ii+1)<=Temp & kownacc(:,:,1)>=Temp) = ...
    Temp(kownacc(:,:,ii+1)<=Temp & kownacc(:,:,1)>=Temp);

Kown(:,:,ii+1)     = TKown;
Kownmina(:,:,ii+1) = TKownmina;


% The Profit given in (6)
clear TKown TKownmina

if sum(sum(Kown(:,:,ii+1)>0))~=sum(sum(Kown(:,:,1)==0))
    error('check the profit code')
end

TKown = Kown(:,:,1) + Kown(:,:,ii+1);
TKownmina = Kownmina(:,:,1) + Kownmina(:,:,ii+1);

profit_own(:,:,ii) = repmat(Gama * z,1,na) .* (TKown .^ alfa) + ...
    (1 - deltta) * TKown + TKownmina;

if Capflag ~= 0
Borrowedown(:,:,ii) = TKownmina;
end
end    

clear Temp Temp2 TKown TKownmina
%--------------------------------------------------------------------------
% Employers
% Invested capital by employers under borrowing rate r_bar (1) and r (2).
% Again, three types, k(rbar)<a save (a-k) *(1+rbar), k(r)>a borrow (k-a) *
% (1+r) and k(rbar)>=a but k(r)<a invest a and save 0

kemp(:,:,1) = repmat(z .^ (1/(1 - nu)),1,na) * (alfa/(deltta + r_bar))^...
    ((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

for ii = 1:nr
kemp(:,:,ii+1) = repmat(z .^ (1/(1 - nu)),1,na) * (alfa/(deltta + r(ii)))...
   ^((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));
end

Kemp        = zeros(nz,na,nr+1);
Kempmina    = zeros(nz,na,nr+1);

% Those who save
Temp      = kemp(:,:,1);
Temp2     = repmat(a,nz,1) - kemp(:,:,1);
TKemp     = Kemp(:,:,1);
TKempmina = Kempmina(:,:,1);


TKemp(Temp2>=0) = Temp(Temp2>=0);
TKempmina(Temp2>=0) = Temp2(Temp2>=0) * (1+r_bar);

Kemp(:,:,1) = TKemp;
Kempmina(:,:,1) = TKempmina;

clear Temp Temp2
% Those who borrow
for ii = 1:nr

Temp  = kemp(:,:,ii+1);
Temp2 = repmat(a,nz,1) - kemp(:,:,ii+1);
TKemp = Kemp(:,:,ii+1);
TKempmina = Kempmina(:,:,ii+1); 

TKemp(Temp2<0) = Temp(Temp2<0);
TKempmina(Temp2<0) = Temp2(Temp2<0) * (1 + r(ii));

clear Temp Temp2

% Those who invest all
Temp = repmat(a,nz,1);

TKemp(kemp(:,:,1)>= Temp & kemp(:,:,ii+1)<=Temp) =...
    Temp(kemp(:,:,1)>= Temp & kemp(:,:,ii+1)<=Temp);

Kemp(:,:,ii+1)     = TKemp;
Kempmina(:,:,ii+1) = TKempmina;

clear TKemp TKempmina
% The profit given in (7)

if sum(sum(Kemp(:,:,ii+1)>0))~=sum(sum(Kemp(:,:,1)==0))
    error('check the profit code')
end

TKemp = Kemp(:,:,1) + Kemp(:,:,ii+1);
TKempmina = Kempmina(:,:,1) + Kempmina(:,:,ii+1);


% Labor imput 7(b)
L = (gama/w)^(1/(1-gama)) * repmat(z.^(1/(1-gama)),1,na) .* (TKemp.^...
    (alfa/(1-gama))); 

profit_emp(:,:,ii) = repmat(z,1,na) .* TKemp.^(alfa).* L.^(gama) - w*L...
    + TKempmina + (1 - deltta) * TKemp;

if Capflag~=0
Borrowedemp(:,:,ii) = TKempmina;
end

end
%--------------------------------------------------------------------------

% First matrix gives the profits, second matrix gives the decisions to hire
% or not
if Capflag == 0
y(:,:,:,1) = max(profit_emp,profit_own);
y(:,:,:,2) = (profit_emp>profit_own);
else
occindex = profit_emp>profit_own; %occindex 1 if hires
Borrowedtot = Borrowedemp.*occindex + Borrowedown.*abs(occindex-1);
Borrowedtot(Borrowedtot>0) = 0;
y = Borrowedtot;
end


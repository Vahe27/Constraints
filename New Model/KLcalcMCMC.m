function y = KLcalcMCMC(z,a,r,w,KLflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A NOTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If making a change in this function don't forget to adjust also the
% function which calcualtes profit, because they are almost the same for the
% part of employers laborcalcMCMC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Created 05.06.2017
% Last Update --

% Calculates the capital and labor demands from the MCMC outcome. It uses
% the same technique as in profit calculation. First I calculate profit for
% all individuals that chose entrepreneurship pi(z,a) for the case if
% hiring and not, then I compare the profits, if pi_own(z,a)>pi_emp(z,a)
% then l demand is 0, so I need to know this

global r_bar deltta alfa nu gama Gama

% Invested capital of own account workers (with no employee) under borrowing
% rate r_bar (1) and borrowing rate r (2). Three types, k(rbar)<a save
% (a-k), k(r)>a borrow (k-a) and k(rbar)>=a but k(bar)<=a invest a and
% borrow 0
na = length(a);
nz = length(z);
nr = length(r);
profit_own = zeros(nz,nr);
profit_emp = zeros(nz,nr);
LD = nan(nz,nr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FOR CAPITAL MARKET %%%%%%%%%%%%%%%%%%%%%%%%%%

% Eq 2 in notes
kownacc(:,1) = (alfa/(r_bar + deltta))^(1/(1-alfa)) * Gama^(1/(1-alfa))...
    * z.^ (1/(1-alfa));

for ii = 1:nr
kownacc(:,1+ii) = (alfa/(r(ii) + deltta))^(1/(1-alfa)) ...
    * Gama^(1/(1-alfa)) * z .^ (1/(1-alfa));
end

Kown     = zeros(nz,nr+1); % (x+a)
Kownmina = zeros(nz,nr+1); % x = K - a to calculate the incomes

% Those who save
Temp  = kownacc(:,1);
Temp2 = a - kownacc(:,1);
TKown = Kown(:,1);
TKownmina = Kownmina(:,1);

TKown(Temp2>=0) = Temp(Temp2>=0);
TKownmina(Temp2>0) = Temp2(Temp2>0) .* (1 + r_bar); 

Kown(:,1)     = TKown;
Kownmina(:,1) = TKownmina;
% Those who borrow

for ii = 1:nr
Temp = kownacc(:,ii+1);
Temp2 = a - kownacc(:,ii+1); 
TKown = Kown(:,ii+1);
TKownmina = Kownmina(:,ii+1);

TKown(Temp2<0)     = Temp(Temp2<0);
TKownmina(Temp2<0) =  Temp2(Temp2<0) .* (1+r(ii));

% Those who invest all
Temp = a;

TKown(kownacc(:,ii+1)<=Temp & kownacc(:,1)>=Temp) = ...
    Temp(kownacc(:,ii+1)<=Temp & kownacc(:,1)>=Temp);


Kown(:,ii+1)     = TKown;
Kownmina(:,ii+1) = TKownmina;


% The Profit given in (6)
clear TKown TKownmina

if sum(sum(Kown(:,ii+1)>0))~=sum(sum(Kown(:,1)==0))
    error('check the profit code')
end

TKown = Kown(:,1) + Kown(:,ii+1);
TKownmina = Kownmina(:,1) + Kownmina(:,ii+1);

profit_own(:,ii) = Gama * z .* (TKown .^ alfa) + ...
    (1 - deltta) * TKown + TKownmina;

end    

clear Temp Temp2 TKown TKownmina
%--------------------------------------------------------------------------
% Employers
% Invested capital by employers under borrowing rate r_bar (1) and r (2).
% Again, three types, k(rbar)<a save (a-k) *(1+rbar), k(r)>a borrow (k-a) *
% (1+r) and k(rbar)>=a but k(r)<a invest a and save 0

kemp(:,1) = z .^ (1/(1 - nu)) * (alfa/(deltta + r_bar))^...
    ((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

for ii = 1:nr
kemp(:,ii+1) = z .^ (1/(1 - nu)) * (alfa/(deltta + r(ii)))...
   ^((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));
end

Kemp        = zeros(nz,nr+1);
Kempmina    = zeros(nz,nr+1);

% Those who save
Temp      = kemp(:,1);
Temp2     = a - kemp(:,1);
TKemp     = Kemp(:,1);
TKempmina = Kempmina(:,1);


TKemp(Temp2>=0) = Temp(Temp2>=0);
TKempmina(Temp2>=0) = Temp2(Temp2>=0) * (1+r_bar);

Kemp(:,1) = TKemp;
Kempmina(:,1) = TKempmina;

clear Temp Temp2
% Those who borrow
for ii = 1:nr

Temp  = kemp(:,ii+1);
Temp2 = a - kemp(:,ii+1);
TKemp = Kemp(:,ii+1);
TKempmina = Kempmina(:,ii+1); 

TKemp(Temp2<0) = Temp(Temp2<0);
TKempmina(Temp2<0) = Temp2(Temp2<0) * (1 + r(ii));

clear Temp Temp2

% Those who invest all
Temp = a;

TKemp(kemp(:,1)>= Temp & kemp(:,ii+1)<=Temp) =...
    Temp(kemp(:,1)>= Temp & kemp(:,ii+1)<=Temp);

Kemp(:,ii+1)     = TKemp;
Kempmina(:,ii+1) = TKempmina;

clear TKemp TKempmina
% The profit given in (7)

if sum(sum(Kemp(:,ii+1)>0))~=sum(sum(Kemp(:,1)==0))
    error('check the profit code')
end

TKemp = Kemp(:,1) + Kemp(:,ii+1);
TKempmina = Kempmina(:,1) + Kempmina(:,ii+1);


% Labor imput 7(b)
L = (gama/w)^(1/(1-gama)) * z.^(1/(1-gama)) .* (TKemp.^...
    (alfa/(1-gama))); 

profit_emp(:,ii) = z .* TKemp.^(alfa).* L.^(gama) - w*L...
    + TKempmina + (1 - deltta) * TKemp;

LD(:,ii) = L;



end
%--------------------------------------------------------------------------
occindex = profit_emp>profit_own; %occindex 1 if hires

LD = LD.*occindex;
KD = Kempmina(:,2:end).*occindex + Kownmina(:,2:end).*abs(occindex-1);


y(:,:,1) = LD;
y(:,:,2) = occindex;
y(:,:,3) = KD./repmat(1+r,nz,1);
y(:,:,4) = profit_emp.*(occindex) + profit_own.*(1-occindex);

end

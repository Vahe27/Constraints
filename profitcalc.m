function y = profitcalc(z,a,r,w);

global r_bar deltta alfa nu gama Gama

% Invested capital of own account workers (with no employee) under borrowing
% rate r_bar (1) and borrowing rate r (2). Three types, k(rbar)<a save
% (a-k), k(r)>a borrow (k-a) and k(rbar)>=a but k(bar)<=a invest a and
% borrow 0

na = length(a);
nz = length(z);

% Eq 2 in notes
kownacc(:,:,1) = (alfa/(r_bar + deltta))^(1/(1-alfa)) * Gama^(1/(1-alfa))...
    * repmat(z .^ (1/(1-alfa)),1,na);

kownacc(:,:,2) = (alfa/(r + deltta))^(1/(1-alfa)) * Gama^(1/(1-alfa))...
    * repmat(z .^ (1/(1-alfa)),1,na);

Kown     = zeros(nz,na); % (x+a)
Kownmina = zeros(nz,na); % x = K - a to calculate the incomes

% Those who save
Temp = kownacc(:,:,1);
Temp2 = repmat(a,nz,1) - kownacc(:,:,1); 

Kown(Temp2>=0) = Temp(Temp2>=0);
Kownmina(Temp2>0) = Temp2(Temp2>0) .* (1 + r_bar); 

% Those who borrow
Temp = kownacc(:,:,2);
Temp2 = repmat(a,nz,1) - kownacc(:,:,2); 

Kown(Temp2<0) = Temp(Temp2<0);
Kownmina(Temp2<0) =  Temp2(Temp2<0) .* (1+r);

% Those who invest all
Temp = repmat(a,nz,1);

Kown(kownacc(:,:,2)<=Temp & kownacc(:,:,1)>=Temp) = Temp(kownacc(:,:,2)<=Temp...
    & kownacc(:,:,1)>=Temp);


% The Profit given in (6)
profit_own = repmat( Gama * z,1,na) .* (Kown .^ alfa) + (1 - deltta) *...
    Kown + Kownmina;
    
clear Temp Temp2
%--------------------------------------------------------------------------
% Employers

% Invested capital by employers under borrowing rate r_bar (1) and r (2).
% Again, three types, k(rbar)<a save (a-k) *(1+rbar), k(r)>a borrow (k-a) *
% (1+r) and k(rbar)>=a but k(r)<a invest a and save 0

kemp(:,:,1) = repmat(z .^ (1/(1 - nu)),1,na) * (alfa/(deltta + r_bar))^...
    ((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

kemp(:,:,2) = repmat(z .^ (1/(1 - nu)),1,na) * (alfa/(deltta + r))^...
    ((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

Kemp        = zeros(nz,na);
Kempmina    = zeros(nz,na);

% Those who save
Temp  = kemp(:,:,1);
Temp2 = repmat(a,nz,1) - kemp(:,:,1);

Kemp(Temp2>=0) = Temp(Temp2>=0);
Kempmina(Temp2>=0) = Temp2(Temp2>=0) * (1+r_bar);

% Those who borrow
Temp  = kemp(:,:,2);
Temp2 = repmat(a,nz,1) - kemp(:,:,2);

Kemp(Temp2<0) = Temp(Temp2<0);
Kempmina(Temp2<0) = Temp2(Temp2<0) * (1 + r);


% Those who invest all
Temp = repmat(a,nz,1);

Kemp(kemp(:,:,1)>= Temp & kemp(:,:,2)<=Temp) = Temp(kemp(:,:,1)>= Temp & ...
    kemp(:,:,2)<=Temp);

% The profit given in (7)

% Labor imput 7(b)
L = (gama/w)^(1/(1-gama)) * repmat(z.^(1/(1-gama)),1,na) .* (Kemp.^...
    (alfa/(1-gama))); 

profit_emp = repmat(z,1,na) .* Kemp.^(alfa).* L.^(gama) - w*L + Kempmina...
    + (1 - deltta) * Kemp;
%--------------------------------------------------------------------------

% First matrix gives the profits, second matrix gives the decisions to hire
% or not

y(:,:,1) = max(profit_emp,profit_own);
y(:,:,2) = (profit_emp>profit_own);





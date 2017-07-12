function y = profitcalc2(z,a,k,r,w);

global Gama alfa gama deltta r_bar nu

% Created: 26.06.2017
% Last Update: 06.07.2017 

%{ 
In this new update of 06.07.2017 I assume k is the amount to be paid after
production process, which means that if the borrowing rate is given by r
then the individual can borrow only k/(1+r) and needs to repay k next
period
%}


% Calculates the profits of each pair (z,a) for given borrowing interest
% rate and wage. The imputs are z(nz x 1), a(1 x na) r(nrxnk) w(1x1). The
% individual needs to choose one of the capital amount he can borrow for a
% given interest rate

nk = length(k);
na = length(a);
nz = length(z);
nr = size(r,1);
pioptown = zeros(nz,na);
pioptemp = zeros(nz,na);
borrowedkown = zeros(nz,na);
borrowedkemp = zeros(nz,na);

% For the own account entrepreneurs

kownacc = (alfa/(r_bar + deltta))^(1/(1-alfa)) * Gama^(1/(1-alfa))...
    * repmat(z .^ (1/(1-alfa)),1,na);

IndexBorrow = kownacc>repmat(a,nz,1);
Savings     = repmat(a,nz,1) - kownacc;

zmatrix = repmat(z,1,na);
amatrix = repmat(a,nz,1);

nborrow = sum(sum(IndexBorrow == 1));

borrowera = repmat(amatrix(IndexBorrow),1,nk);
borrowerz = repmat(zmatrix(IndexBorrow),1,nk);

for ii = 1:nr
    
invest    = borrowera + repmat(k./(1+r(ii,:)),nborrow,1);
    
paymentk  = k;
paymentk  = repmat(paymentk,nborrow,1);



pimatrixown = Gama*borrowerz.* invest.^alfa + (1-deltta) * invest ...
    - paymentk;

[pioptown(IndexBorrow) Ikown] = max(pimatrixown,[],2);

pioptown(IndexBorrow==0) = Gama*zmatrix(IndexBorrow==0) .* ...
    kownacc(IndexBorrow==0).^alfa + (1-deltta)*kownacc(IndexBorrow==0)...
    + Savings(IndexBorrow==0).*(1+r_bar);


piown(:,:,ii) = pioptown;

bork = zeros(nz,na);
bork(IndexBorrow) = k(Ikown);

borrowedkown(:,:,ii) = bork;
end

% For the employer entrepreneurs

kemp = repmat(z .^ (1/(1 - nu)),1,na) * (alfa/(deltta + r_bar))^...
    ((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

IndexBorrow = kemp>repmat(a,nz,1);
Savings     = repmat(a,nz,1) - kemp;

nborrow = sum(sum(IndexBorrow == 1));

borrowera = repmat(amatrix(IndexBorrow),1,nk);
borrowerz = repmat(zmatrix(IndexBorrow),1,nk);

for ii = 1:nr
invest    = borrowera + repmat(k./(1+r(ii,:)),nborrow,1);

    
paymentk = k;
paymentk = repmat(paymentk,nborrow,1);

L = (gama/w)^(1/(1-gama)) * borrowerz.^(1/(1-gama)) .* (invest.^...
    (alfa/(1-gama))); 

pimatrixemp = borrowerz.*(invest).^alfa .* L.^gama + (1-deltta).*invest...
    - paymentk - w*L;

[pioptemp(IndexBorrow) Iemp] = max(pimatrixemp,[],2);

Lsave = (gama/w)^(1/(1-gama)) * zmatrix.^(1/(1-gama)) .* (kemp.^...
    (alfa/(1-gama))); 

pioptemp(IndexBorrow==0) = zmatrix(IndexBorrow==0).*kemp(IndexBorrow==0)...
    .^alfa .* Lsave(IndexBorrow==0) .^ gama + (1-deltta).* ...
    kemp(IndexBorrow==0) - w .*Lsave(IndexBorrow==0)...
    + Savings(IndexBorrow==0).*(1+r_bar);

piemp(:,:,ii) = pioptemp;

bork = zeros(nz,na);
bork(IndexBorrow) = k(Iemp);

borrowedkemp(:,:,ii) = bork;

end

Ihire = piemp>piown;
income = Ihire.*piemp + (1-Ihire).*piown;

y(:,:,:,1) = income;
y(:,:,:,2) = Ihire;



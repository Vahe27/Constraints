function y = KLMCMC(z,a,k,r,w,KLflag);

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
nr = size(r,1);
nk = length(k);

piown = zeros(nz,nr);
piemp = zeros(nz,nr);
borrowedkown = zeros(nz,nr);
borrowedkemp = zeros(nz,nr);
Bkindown     = zeros(nz,nr);
Bkindemp     = zeros(nz,nr);
LabD = nan(nz,nr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FOR CAPITAL MARKET %%%%%%%%%%%%%%%%%%%%%%%%%%

% Eq 2 in notes
kownacc = (alfa/(r_bar + deltta))^(1/(1-alfa)) * Gama^(1/(1-alfa))...
    * z.^ (1/(1-alfa));

IndBown = kownacc>a;
Sown     = a - kownacc;

%zmatrix = repmat(z,1,na);
%amatrix = repmat(a,nz,1);

nborrow = sum(IndBown == 1);

borrowera = repmat(a(IndBown),1,nk);
borrowerz = repmat(z(IndBown),1,nk);
invest    = borrowera + repmat(k,nborrow,1);

for ii = 1:nr
    
paymentk  = k.*(1+r(ii,:));
paymentk  = repmat(paymentk,nborrow,1);



pimatrixown = Gama*borrowerz.* invest.^alfa + (1-deltta) * invest ...
    - paymentk;

[pioptown(IndBown) Ikown] = max(pimatrixown,[],2);

pioptown(IndBown==0) = Gama*z(IndBown==0) .* ...
    kownacc(IndBown==0).^alfa + (1-deltta)*kownacc(IndBown==0)...
    + Sown(IndBown==0).*(1+r_bar);


piown(:,ii) = pioptown;

bork = zeros(nz,1);
bork(IndBown) = k(Ikown);

borrowedkown(:,ii) = bork;
Bkindown(IndBown,ii)     = Ikown;

end

%--------------------------------------------------------------------------
% Employers
% Invested capital by employers under borrowing rate r_bar (1) and r (2).
% Again, three types, k(rbar)<a save (a-k) *(1+rbar), k(r)>a borrow (k-a) *
% (1+r) and k(rbar)>=a but k(r)<a invest a and save 0

% Here I will group all entrepreneurs who demand capital higher than the
% upper bar k into the highest capital bin

kemp = z .^ (1/(1 - nu)) * (alfa/(deltta + r_bar))^...
    ((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

IndBemp = kemp>a;
Semp    = a - kemp;

nborrow = sum(IndBemp);

borrowera = repmat(a(IndBemp),1,nk);
borrowerz = repmat(z(IndBemp),1,nk);
invest    = borrowera + repmat(k,nborrow,1);

for ii = 1:nr

paymentk = k.*(1+r(ii,:));
paymentk = repmat(paymentk,nborrow,1);

L = (gama/w)^(1/(1-gama)) * borrowerz.^(1/(1-gama)) .* (invest.^...
    (alfa/(1-gama))); 

pimatrixemp = borrowerz.*(invest).^alfa .* L.^gama + (1-deltta).*invest...
    - paymentk - w*L;

[pioptemp(IndBemp) Ikemp] = max(pimatrixemp,[],2);

LabD(IndBemp,ii) = L([1:nborrow]'+(Ikemp - 1)*nborrow);

%% Check from here once again! tomorrow

khigh = borrowerz(Ikemp==nk) .^ (1/(1 - nu)) * (alfa/(deltta...
    + r(ii,end)))^((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

atemp = borrowera(:,1);
ztemp = borrowerz(:,1);

Lhigh = gama/alfa * khigh * (r(ii,end)+deltta)/w; % equivalent to the other calculation!

pihigh = ztemp(Ikemp==nk).*khigh.^alfa.*Lhigh.^gama + (1-deltta).*khigh ...
    - w*Lhigh - (1+r(ii,end)).*(khigh - atemp(Ikemp==nk));

X1 = pioptemp(IndBemp);
X2 = LabD(IndBemp,ii);

X1(Ikemp==nk) = pihigh;
X2(Ikemp==nk) = Lhigh;

pioptemp(IndBemp) = X1;
LabD(IndBemp,ii)  = X2;


Lsave = (gama/w)^(1/(1-gama)) * z.^(1/(1-gama)) .* (kemp.^...
    (alfa/(1-gama))); 

pioptemp(IndBemp==0) = z(IndBemp==0).*kemp(IndBemp==0)...
    .^alfa .* Lsave(IndBemp==0) .^ gama + (1-deltta).* ...
    kemp(IndBemp==0) - w .*Lsave(IndBemp==0)...
    + Semp(IndBemp==0).*(1+r_bar);

piemp(:,ii)   = pioptemp;

bork          = zeros(nz,1);
bork(IndBemp) = k(Ikemp);
X3            = bork(IndBemp);
X3(Ikemp==nk) = khigh;
bork(IndBemp) = X3;

borrowedkemp(:,ii)   = bork;
Bkindemp(IndBemp,ii) = Ikemp;

LabD(IndBemp==0,ii)  = Lsave(IndBemp==0);

end
%--------------------------------------------------------------------------
occindex = piemp>piown; %occindex 1 if hires

LabD = LabD.*occindex;
KD = Bkindemp.*occindex + Bkindown.*(1-occindex);
BorrowedK = borrowedkemp.*occindex + borrowedkown.*(1-occindex);

y(:,:,1) = LabD;
y(:,:,2) = occindex;
y(:,:,3) = KD;
y(:,:,4) = piemp.*(occindex) + piown.*(1-occindex);
y(:,:,5) = BorrowedK;
end

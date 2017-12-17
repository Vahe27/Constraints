function y = KLMCMCINT2(z,a,k,r,w,Falfa,Fgama,Zgama)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A NOTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If making a change in this function don't forget to adjust also the
% function which calcualtes profit, because they are almost the same for the
% part of employers laborcalcMCMC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Created 05.06.2017
% Last Update: 04.10.2017 Interpolate the powers instead of directly
% calculating them
% Last Update: 17.11.2017 Updated version of KLMCMC, here I calculate
% z^1/(1-gama) directly, instead of interpolation

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
na      = length(a);
nz      = length(z);
nr      = size(r,1);
nk      = length(k);
flagown = 0;
flagemp = 0;

piown = zeros(nz,nr);
piemp = zeros(nz,nr);
borrowedkown = zeros(nz,nr);
borrowedkemp = zeros(nz,nr);
Bkindown     = zeros(nz,nr);
Bkindemp     = zeros(nz,nr);
LabD = nan(nz,nr);
%%%%%%%%%%%%%%%%%%%%%%%% TEMP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pioptown = zeros(nz,1);
pioptemp = zeros(nz,1);
y        = zeros(nz,5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FOR CAPITAL MARKET %%%%%%%%%%%%%%%%%%%%%%%%%%

% Eq 2 in notes

% kownacc = (alfa/(r_bar + deltta))^(1/(1-alfa)) * Gama^(1/(1-alfa))...
%    * z.^ (1/(1-alfa));
kownacc = (alfa/(r_bar + deltta)* Gama* z).^ (1/(1-alfa));


IndBown = kownacc>a;
Sown     = a - kownacc;

%zmatrix = repmat(z,1,na);
%amatrix = repmat(a,nz,1);

nborrow = sum(IndBown == 1);

borrowera = repmat(a(IndBown),1,nk);
borrowerz = repmat(z(IndBown),1,nk);

if size(borrowera,1) == 0
    flagown = 1;
end

if flagown == 0

invest    = borrowera + repmat(k./(1+r(1,:)),nborrow,1);
    
    
paymentk  = k;
paymentk  = repmat(paymentk,nborrow,1);

invalfa = reshape(Falfa(invest(:)),nborrow,nk);

pimatrixown = Gama*borrowerz.* invalfa + (1-deltta) * invest ...
    - paymentk;

[pioptown(IndBown) Ikown] = max(pimatrixown,[],2);

else

Ikown = [];

end

pioptown(IndBown==0) = Gama*z(IndBown==0) .* ...
    kownacc(IndBown==0).^alfa + (1-deltta)*kownacc(IndBown==0)...
    + Sown(IndBown==0).*(1+r_bar);


piown(:,1) = pioptown;

bork = zeros(nz,1);
bork(IndBown) = k(Ikown);

borrowedkown(:,1) = bork;
Bkindown(IndBown,1)     = Ikown;



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
borrowerz = z(IndBemp);

if size(borrowera,1) == 0
    flagemp = 1;
end

if flagemp == 0
invest    = borrowera + repmat(k./(1+r(1,:)),nborrow,1);
    

paymentk = k;
paymentk = repmat(paymentk,nborrow,1);
invgama = reshape(Fgama(invest(:)),nborrow,nk);
zgama   = repmat(Zgama(IndBemp),1,nk);

pimatrixemp = zgama.*invgama*...
    ((gama/w)^(gama/(1-gama)) - w*(gama/w)^(1/(1-gama))) + (1-deltta)...
    *invest - paymentk;

% L = (gama/w)^(1/(1-gama)) * borrowerz.^(1/(1-gama)) .* (invest.^...
%    (alfa/(1-gama))); 

% pimatrixemp = borrowerz.*(invest).^alfa .* L.^gama + (1-deltta).*invest...
%    - paymentk - w*L;
% LabD(IndBemp,1) = L([1:nborrow]'+(Ikemp - 1)*nborrow);

[pioptemp(IndBemp) Ikemp] = max(pimatrixemp,[],2);

LabD(IndBemp,1) = (gama/w * z(IndBemp)).^(1/(1-gama)) .*...
    (invest([1:nborrow]'+(Ikemp - 1)*nborrow).^(alfa/(1-gama)));
%% Check from here once again! tomorrow

% Here I don't change the notations like I did in the previous cases, where
% the individual was chooseing qk and paying k later, here the agent
% chooses k and pays (1+r)k where the r is the borrowing rate for the
% highest capital. It can be shown that q = 1/(1+r) so it is between (0,1)

khigh = borrowerz(Ikemp==nk) .^ (1/(1 - nu)) * (alfa/(deltta...
    + r(1,end)))^((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

atemp = borrowera(:,1);
ztemp = borrowerz(:,1);

Lhigh = gama/alfa * khigh * (r(1,end)+deltta)/w; % equivalent to the other calculation!

pihigh = ztemp(Ikemp==nk).*khigh.^alfa.*Lhigh.^gama + (1-deltta).*khigh ...
    - w*Lhigh - (1+r(1,end)).*(khigh - atemp(Ikemp==nk));

X1 = pioptemp(IndBemp);
X2 = LabD(IndBemp,1);

X1(Ikemp==nk) = pihigh;
X2(Ikemp==nk) = Lhigh;

pioptemp(IndBemp) = X1;
LabD(IndBemp,1)  = X2;

else
    Ikemp = [];
    khigh = [];
end

Lsave = (gama/w * z).^(1/(1-gama)) .* (kemp.^...
    (alfa/(1-gama))); 

pioptemp(IndBemp==0) = z(IndBemp==0).*kemp(IndBemp==0)...
    .^alfa .* Lsave(IndBemp==0) .^ gama + (1-deltta).* ...
    kemp(IndBemp==0) - w .*Lsave(IndBemp==0)...
    + Semp(IndBemp==0).*(1+r_bar);

piemp(:,1)   = pioptemp;

bork          = zeros(nz,1);
bork(IndBemp) = k(Ikemp);
X3            = bork(IndBemp);
X3(Ikemp==nk) = khigh.*(1+r(1,end));
bork(IndBemp) = X3;

borrowedkemp(:,1)   = bork;
Bkindemp(IndBemp,1) = Ikemp;

LabD(IndBemp==0,1)  = Lsave(IndBemp==0);


%--------------------------------------------------------------------------
occindex = piemp>piown; %occindex 1 if hires

invK = (1-occindex).*kownacc.*(1-IndBown)...
    +occindex.*kemp.*(1-IndBemp);

LabD = LabD.*occindex;
KD = Bkindemp.*occindex + Bkindown.*(1-occindex);
BorrowedK = borrowedkemp.*occindex + borrowedkown.*(1-occindex);

y(:,1) = LabD;
y(:,2) = invK;
y(:,3) = KD;
y(:,4) = piemp.*(occindex) + piown.*(1-occindex);
y(:,5) = BorrowedK;
end

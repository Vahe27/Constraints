% This version has two sectors, the first sector firms have low
% productivity and they have to pay a fixed cost to transfer to the second
% sector where they will have a higher productivity. The intermediary can
% see which sector a given firm belongs to and how much capital it asks
%% I ASSUME YOU CAN DEFAULT ON TAXES AS WELL. HERE IT IS LUMP-SUM

clear all
Vflag = 0; % 2 loads the Vfuns from other simulations as starting values, 
% 1 doesn't make sense in here at the code will give an error, 0 uses zeros
% as initial values for the Vfun iteration.
CONTSTATDIST = 1; % Use continuous values in stationary distribution calc-
% culation insead of grid points if CONSTATDIST = 1.
tic
rng(1)
%% Parameters

global r_bar deltta alfa nu gama Gama varphi zetta THETA xi

% Environment and Preference Parameters Parameters
r_bar    = 0.04;
betta    = 0.94;
sigma    = 2; % Risk aversion coefficient, log utility if 1

% Job destruction and job NOT finding parameters
lambda = 0.3; % avg emp duration 2.5y Shimer (2005)
mu     = 0.01; % avg unemp duration 6.5/12 year (OECD 2015-16)

% Production Parameters
deltta   = 0.06;
alfa     = 0.3;
nu       = 0.8;
gama     = nu - alfa;
varphi   = 0.8;

% Distribution Parameters
ZDist    = 1; % Pareto, if 1. Normal if 2
etta     = 7;
sigz     = 1/varphi;

PSI      = 0.1; % The probability of changing the talent, then will be randomly drawn from z

% Two parameters that will be useful for the disutility from work
ettakap  = 0.4;
sigkap   = 8;

% Fixed Cost to increase business size;
THETA = 15;

% The Default Parameters
mueps    = 1;
sigeps   = 7;
zetta    = [0.5 0.5]; % The likelihood that conditional on shock realizing, it will be low
epsilon  = [0 2 10]; 

EPSdist  = 1; % 1 if normal distributed
KAPdist  = 1;
kmethod  = 1.5; % Method with how to create the capital grid, 0 linear, 1 exponential
xi       = 0.17; % Exemption level, share of wage

% Grid Parameters
amin    = 0.001;
amax    = 350;
Kmax    = 2e3;
na      = 120;
nap     = 300;
nz      = 20;
nkap    = 5;
ne      = 3; % The number of occupations
nprob   = 5;
neps    = 3;
nr      = 2; % Number of interest rates a self-emp can face
nk      = 200; % The number of capital grid
upperz  = 0.9998;



% The Grids
Amethod  = 1; % 1 if linear, 2 if logarithmic
agrid    = adist(amin,amax,na,Amethod);
apgrid   = adist(amin,amax,nap,Amethod);

X        = prodshock(mueps,sigeps,nprob,EPSdist); % P and epsilon can also be vectors with size neps
P        = X(:,1);
clear X

X        = zdist(sigz,etta,nz,ZDist);
Pz       = X(1,1);
zgrid    = X(:,2);
clear X

X        = kapdist(ettakap,sigkap,nkap,KAPdist);
Pkap     = X(:,1); 
kapgrid  = X(:,2);
clear X

% Initial Values of the variables
w0       = [1.15];
r0       = ones(nr,nk)*r_bar; % Now For each signal and amount there is a borrowing rate
b0       = 0.27;
tau      =  [0.07];
tauinit  = tau;
r0init   = r0;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% The Stationary Distribution Parameters
NN = 2e5;
TT = 270;

nA   = 500;
nZ   = 200;
nKAP = 200;

Agrid   = adist(amin,amax,nA,Amethod);
Zgrid   = zdist(sigz,etta,nZ,ZDist);
Zgrid   = Zgrid(:,2);
KAPgrid = kapdist(ettakap,sigkap,nKAP,KAPdist);
KAPgrid = KAPgrid(:,2);
%--------------------------------------------------------------------------

% Auxilliary Parameters

Gama = (gama^gama)/((1+gama)^(1+gama));

% As a benchmark for approximation, I choose highest shock, eps=eps_max and
% low borrowing rate r_min>r_bar

bnr   = 1;
bneps = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nnn           = na*neps*nprob;
nstate        = nz*na*nprob*nkap;
kap_array     = repmat(reshape(kapgrid,1,1,1,nkap),nz,na,nprob,1);
a_array       = repmat(agrid,nz,1,nprob,nkap);
z_array       = repmat(zgrid,1,na,nprob,nkap);
prob_array    = repmat(reshape(P,1,1,nprob),nz,na,1,nkap);

zarrayintS    = repmat(zgrid,1,na*(neps),nprob,nkap);
probarrayintS = repmat(reshape(P,1,1,nprob),nz,na*(neps),1,nkap);
kaparrayintS  = repmat(reshape(kapgrid,1,1,1,nkap),nz,na*(neps),nprob,1);
TS            = zeros(nz,nnn,nkap);

zarrayintB    = repmat(zgrid,1,na*(neps),nprob,nkap);
probarrayintB = repmat(reshape(P,1,1,nprob),nz,na*(neps),1,nkap);
kaparrayintB  = repmat(reshape(kapgrid,1,1,1,nkap),nz,na*(neps),nprob,1);
TB            = zeros(nz,nnn,nkap);

znarray       = repmat(zgrid,1,nap,nprob,nkap);
kapnarray     = repmat(reshape(kapgrid,1,1,1,nkap),nz,nap,nprob,1);
anarray       = repmat(apgrid,nz,1,nprob,nkap);
probnarray    = repmat(reshape(P,1,1,nprob),nz,nap,1,nkap);

probmtx       = [1-P zeros(nprob,neps-1)];

for jj = 2:neps
    probmtx(:,jj) = zetta(jj-1)*P;
end

X = repmat(reshape(probmtx',1,1,1,neps,nprob),nz,na,nkap);
probmtx = permute(X,[1 2 4 5 3]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For the stat dist: 4 occupations, augment the grid matrices to another
% dimension which has 4 values, one for each occupation

Zarray = repmat(z_array,1,1,1,1,4);
Aarray = repmat(a_array,1,1,1,1,4);
Parray = repmat(prob_array,1,1,1,1,4);
Karray = repmat(kap_array,1,1,1,1,4);
Oarray = repmat(reshape([3 4 6 8],1,1,1,1,4),nz,na,nprob,nkap,1);



%--------------------------------------------------------------------------
% The Stationary Distribution of Talents

StatesforStatDist;

%--------------------------------------------------------------------------
LFLAG    = 0;

%% Capital and Government Tax Loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kgrid = kdist(nk,sigz,etta,r0,w0,kmethod);
Nint = 2e6;
NZint = 2e6;
Iint  = invint(kgrid,Nint);
Zint  = zint(varphi,upperz,NZint,etta);

%% The Labor Loop starts here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Labor Market Loop Matrices ----------------------------------------------

distL    = 100;
tolL     = 0.0055;
maxiterL = 25;
iterL    = 1;
stugL    = zeros(maxiterL,4);
wmax     = 1.25;
mflagL    = 1;
wtol      = 100;
wtolmax   = 1e-7;
tolaux   = 1e-5;
wold     = wmax;
% Capflag = 0 means that profits will be calcualted in profitcalc and not
% the capital demand
Capflag = 0;
%--------------------------------------------------------------------------
clear funcdistL
FLAGUNCLEARL = 0;
%--------------------------------------------------------------------------
% The Capital grid: New Addition, each firm chooses the amount that
% maximizes its profit, but the capital choice is not continuous.

%--------------------------------------------------------------------------

while distL>tolL && iterL<maxiterL && wtol > wtolmax
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    if iterL>2 
     
     if fa~=fc && fb~=fc
        
        s = a*fb*fc/((fa-fb)*(fa-fc)) + b*fa*fc/((fb-fa)*(fb-fc))...
            +c*fa*fb/((fc-fa)*(fc-fb));
    else
        s = b - fb*(b-a)/(fb-fa);
    end;
    
    if (s>max((3*a+b)/4,b) || s<min((3*a+b)/4,b)) || ...
   (mflagL==1 && abs(s-b)>=abs(b-c)/2) || (mflagL==0 && abs(s-b)>=abs(c-d)/2)...
   || (mflagL==1 && abs(b-c)<tolaux) || (mflagL==0 && abs(c-d)<tolaux)
        
        s = (a+b)/2;
        mflagL=1;
    else
        mflagL=0;
    end;
    w0 = s;
 end;
 %-------------------------------------------------------------------------
%{%}
qupdate  = 0.01;
rupdate  = 0.01;
iterR    = 1;
tolR     = 5e-3;
tolq     = 5e-3;
distR    = 150;
maxiterR = 150;
tolupr   = 0.015;
lastresortflag = 0;

% if iterL>1
%     if abs(w0 - wold)*2/(w0+wold)>tolupr
% r0       = 0.04*ones(2,nk);
%     end
% end

 r0 = 0.04*ones(2,nk);
 %r0(1,1:end) = 0.05;
 %r0(1,1:150) = 0.1;
 %r0(1,151:200) = 0.07;
while distR>tolR && iterR<maxiterR

%%%%%%%%%%%%%%%%%%%%%%%%%FIX THE SEED$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    
rng(2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kapgrid(1)=0;

%% The Consumption matrices
%--------------------------------------------------------------------------

% Here businc are as in the notes, they include both business profits and
% income from depositing left-over assets, doesn't include taxes 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

SEMP     = profitcalc2(zgrid*varphi,agrid,kgrid(1,:),r0(1,:),w0);
%incsown  = SEMP(:,:,:,1);
%incsemp  = SEMP(:,:,:,2); % Index indicating whether the individual hires or not
%ysown    = SEMP(:,:,:,3);
%ysemp    = SEMP(:,:,:,4);
%clear SEMP

BUS      = profitcalc2(zgrid,agrid,kgrid(2,:),r0(2,:),w0);
%incbown  = BUS(:,:,:,1);
%incbemp  = BUS(:,:,:,2);
%ybown    = BUS(:,:,:,3);
%ybemp    = BUS(:,:,:,4);
%clear BUS

BUSN     = profitcalc2_entry(zgrid,agrid,kgrid(2,:),r0(2,:),w0); 

% aftershockinc

X = aftershockinc(SEMP,w0,epsilon, P,neps,0); % X(nz x na x nr x neps) 
sempincP = X; 
clear X


X = expinc(sempincP,P,epsilon);
sempinc = X(:,:,:,:,2);
IhireS   = X(:,:,:,:,1);
clear X sempincP


X = aftershockinc(BUS,w0,epsilon, P,neps,0); % X(nz x na x nr x neps) 
busincP = X; 
clear X

X = expinc(busincP,P,epsilon);
businc = X(:,:,:,:,2);
IhireB   = X(:,:,:,:,1);
clear X busincP

X = aftershockinc(BUSN,w0,epsilon,P,neps,0);
busincNP = X;
clear X

X = expinc(busincNP,P,epsilon);
busincN = X(:,:,:,:,2);
IhireNB = X(:,:,:,:,1);
clear X
busincN(busincN<amin) = nan;

clear BUS SEMP BUSN busincP sempincP bsuincNP

consw  = zeros(nz,na,nap);

consw = w0 + (1 + r_bar) * repmat(agrid,1,1,nap) - repmat(reshape(apgrid...
    ,1,1,nap),1,na,1) - tau;

consu = b0*w0 + (1+r_bar)*repmat(agrid,1,1,nap) - repmat(reshape(apgrid...
    ,1,1,nap),1,na,1)-tau;

% Need to choose a benchmark for the value function iteration. The strategy
% is to calculate the optimal cons and saving for a given asset level and
% given shock and borrowing rate, conditional on managerial talent, and
% then interpolate the "Cash-on-hand" after the shock and get saving and
% consumption choice for other shock and borrowing rate combinations.

% The argument is: given z, having asset a1, and facing eps1 r1 is
% equivalent to having asset a2 and facing eps2, r2 as long as
% pi(z,a1,eps1,r1) = pi(z,a2,eps2,r2) in terms of consumption and
% investment choice.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tsempinc = sempinc(:,:,bneps,:);
Tsempinc(Tsempinc<=apgrid(1)+tau) = tau+2*0.02;
Tbusinc  = busincN(:,:,bneps,:);
Tbusinc(Tbusinc<=apgrid(1)+tau) = tau+2*0.02;

sempinc(:,:,bneps,:) = Tsempinc;
busincN(:,:,bneps,:) = Tbusinc;

clear Tsempinc Tbusinc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

conssB  = repmat(reshape(sempinc(:,:,bneps,:),nz,na,nprob),1,1,1,nap)...
    - repmat(reshape(apgrid,1,1,1,nap),nz,na,nprob,1) - tau;

consbNB = repmat(reshape(busincN(:,:,bneps,:),nz,na,nprob),1,1,1,nap) - ...
    repmat(reshape(apgrid,1,1,1,nap),nz,na,nprob,1)  - tau;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AtildeS  = assetaprox(sempinc,agrid,[],bneps,nz,na,neps,nprob);

AtildeBN  = assetaprox(busincN,agrid,[],bneps,nz,na,neps,nprob);

AtildeBB = assetaproxB(busincN(:,:,bneps,:),businc,agrid,nz,na,nprob,neps);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Uw   = ucalc(consw, sigma);
Uu   = ucalc(consu, sigma);
UsB  = ucalc(conssB, sigma);
UbNB = ucalc(consbNB, sigma);
%--------------------------------------------------------------------------
% Temporary Adjustment: If the assets for interpolation are too low, what
% will happen is that during the interpolation the value assigned will be
% nan, which means the value function will NOT converge. Solution, replace
% the low values of assets with the closest value from agrid (AtildeBB)
 tempx = UbNB(1,:,1,1);
 tempx = min(find(agrid>THETA));
 AtildeBB(AtildeBB<agrid(tempx)) = agrid(tempx);


%--------------------------------------------------------------------------


% UbNB(isnan(UbNB)) = -100;
clear consw consu conssB consbB consbNB

% Adding the kappa dimension

Uwk = disU(Uw,nz,na,nkap,kapgrid);

Uuk = repmat(Uu,nz,1,1,nkap);
UsBk = repmat(UsB,1,1,1,1,nkap);

UbNBk = repmat(UbNB,1,1,1,1,nkap); % for the new entrants

clear Uw Uu UsB UbB UbNB

% Auxilliary Parameters II
ATILDES       = repmat(reshape(AtildeS,nz,na*(neps),nprob),1,1,1,nkap);
ATILDEBN      = repmat(reshape(AtildeBN,nz,na*neps,nprob),1,1,1,nkap);
ATILDEBB      = repmat(reshape(AtildeBB,nz,na*neps,nprob),1,1,1,nkap);
clear AtildeS AtildeBB AtildeBN
%% Value Function Iteration
% --------------------Value Funcion Interation-----------------------------
%if (wold-w0)*2/(wold+w0)>0.05
%Vflag = 0;
%end
% Vflag = 0;
if Vflag == 0
VuN  = zeros(nz,na,nprob,nkap);
VwN  = VuN+0.25;
VuB  = zeros(nz,na,nprob,nkap);
VwB  = VuB+0.25;

W    = repmat((w0 + agrid*(1+r_bar)).^(1-sigma)/(1-sigma)/(1-betta),nz,1,nprob,nkap);
N    = repmat((b0*w0 + agrid*(1+r_bar)).^(1-sigma)/(1-sigma)/(1-betta),nz,1,nprob,nkap);
S    = repmat(reshape(sempinc(:,:,1,:),nz,na,nprob),1,1,1,nkap)...
       .^(1-sigma)/(1-sigma)/(1-betta);
BN   = repmat(reshape(busincN(:,:,1,:),nz,na,nprob),1,1,1,nkap)...
       .^(1-sigma)/(1-sigma)/(1-betta);
BB   = repmat(reshape(businc(:,:,1,:),nz,na,nprob),1,1,1,nkap)...
       .^(1-sigma)/(1-sigma)/(1-betta); 
EBN  = BN;
EBB  = BB;
ES   = S;

VuN0 = zeros(nz,na,nprob,nkap);
VwN0 = VuN0 + 0.25;
VuB0 = zeros(nz,na,nprob,nkap);
VwB0 = VuB0 + 0.25;

W0   = VwN0 + 0.25;
N0   = W0 + 0.25;
S0   = N0 + 0.25;
B0   = S0 + 0.25;
ES0  = S0;
EBN0 = B0;
EBB0 = B0;

elseif Vflag == 1
    
VwN0 = VwNold;
VuN0 = VuNold;
VwB0 = VwBold;
VuB0 = VuBold;
W0  = Wold;
N0  = Nold;
S0  = Sold;
ES0 = ESold;
EBN0 = EBNold;
EBB0 = EBBold;

elseif Vflag == 2
    
load('ValFun')

end

%%%%%%%%%%NEED TO CONTINUE HERE IF FAIL WITH THE OTHER OPTION%%%%%%%%%%%%%%

maxiter_v = 1000;
iter_v  = 1;
tol_v   = 1e-6;
dist_v  = 500;

Uwk   = repmat(reshape(Uwk,nz,na,1,nap,nkap),1,1,nprob,1,1);
Uuk   = repmat(reshape(Uuk,nz,na,1,nap,nkap),1,1,nprob,1,1);

Uwk   = reshape(permute(Uwk,[4 2 1 3 5]),nap,nz*na*nprob*nkap);
Uuk   = reshape(permute(Uuk,[4 2 1 3 5]),nap,nz*na*nprob*nkap);
UsBk  = reshape(permute(UsBk,[4 2 1 3 5]),nap,nz*na*nprob*nkap);
%UbBk  = reshape(permute(UbBk,[4 2 1 3 5]),nap,nz*na*nprob*nkap);
UbNBk = reshape(permute(UbNBk,[4 2 1 3 5]),nap,nz*na*nprob*nkap);


% DIMENSIONS NZ x NA x NPROB x NKAP
% CHOICE NZ x NA x NAP x NPROB x NKAP
while iter_v<maxiter_v && dist_v>tol_v

MAXESN = max(ES,N);    
    
VwN = max(max(W,EBN),MAXESN);
VuN = max(EBN,MAXESN);
VwB = max(max(W,EBB),MAXESN);
VuB = max(EBB,MAXESN);

% Can't multiply 3d matrices that's why I first reshape Vw(nz,na,nkap) to
% Vw(nz,na*nkap) then calculate the expected values wrt z, then reshape
% back to EVw(1,na,nkap) and then repmat to EVw(nz,na,nkap) 


EVwN = (1-PSI) * VwN + PSI * repmat(reshape(ones(1,nz)*reshape(VwN,nz,na...
    *nkap*nprob)/nz,1,na,nprob,nkap),nz,1,1,1);
EVuN = (1-PSI) * VuN + PSI * repmat(reshape(ones(1,nz)*reshape(VuN,nz,na...
    *nkap*nprob)/nz,1,na,nprob,nkap),nz,1,1,1);
EVwB = (1-PSI) * VwB + PSI * repmat(reshape(ones(1,nz)*reshape(VwB,nz,na...
    *nkap*nprob)/nz,1,na,nprob,nkap),nz,1,1,1);
EVuB = (1-PSI) * VuB + PSI * repmat(reshape(ones(1,nz)*reshape(VuB,nz,na...
    *nkap*nprob)/nz,1,na,nprob,nkap),nz,1,1,1);



if nap~=na
FEVwN = griddedInterpolant(z_array,a_array,prob_array,kap_array,EVwN);
FEVuN = griddedInterpolant(z_array,a_array,prob_array,kap_array,EVuN);
FEVwB = griddedInterpolant(z_array,a_array,prob_array,kap_array,EVwB);
FEVuB = griddedInterpolant(z_array,a_array,prob_array,kap_array,EVuB);



EVwN = FEVwN(znarray,anarray,probnarray,kapnarray);
EVuN = FEVuN(znarray,anarray,probnarray,kapnarray);
EVwB = FEVwB(znarray,anarray,probnarray,kapnarray);
EVuB = FEVuB(znarray,anarray,probnarray,kapnarray);

end


iminW = ones(nstate,1);
imaxW = ones(nstate,1)*nap;
ilowW = ones(nstate,1)*floor(nap/2);
iupW  = ilowW+1;

iminN = ones(nstate,1);
imaxN = ones(nstate,1)*nap;
ilowN = ones(nstate,1)*floor(nap/2);
iupN  = ilowN+1;

iminS = ones(nstate,1);
imaxS = ones(nstate,1)*nap;
ilowS = ones(nstate,1)*floor(nap/2);
iupS  = ilowS+1;

iminB = ones(nstate,1);
imaxB = ones(nstate,1)*nap;
ilowB = ones(nstate,1)*floor(nap/2);
iupB  = ilowB+1;


VWTN = permute(betta*((1 - lambda) * EVwN + lambda *EVuN),[2 1 3 4]);
VNTN = permute(betta*((1 - mu) * EVwN + mu *EVuN),[2 1 3 4]);
VWTB = permute(betta*((1 - lambda) * EVwB + lambda *EVuB),[2 1 3 4]);
VNTB = permute(betta*((1 - mu) * EVwB + mu *EVuB),[2 1 3 4]);



indU = ([1:nstate]'-1)*nap;
indV = repmat(([1:nz*nprob*nkap]-1)*nap,na,1);
indV = indV(:);

while max(imaxW-iminW)>1
% Workers
ilowW = ones(nstate,1).*floor((iminW+imaxW)/2);
iupW  = ilowW+1;
iupW(iupW>nap)=nap;

Wlow = Uwk(indU+ilowW) + VWTN(indV+ilowW);
Wup  = Uwk(indU+iupW) + VWTN(indV+iupW);

iminW(Wlow<=Wup & Wlow>-70) = iupW(Wlow<=Wup & Wlow>-70);
imaxW(Wlow>Wup) = ilowW(Wlow>Wup);

imaxW(Wlow<-70) = max(floor(ilowW(Wlow<-70)),1);

% Unemployed
ilowN = ones(nstate,1).*floor((iminN+imaxN)/2);
iupN  = ilowN+1;
iupN(iupN>nap)=nap;

Nlow = Uuk(indU+ilowN) + VNTN(indV+ilowN);
Nup  = Uuk(indU+iupN) + VNTN(indV+iupN);

iminN(Nlow<=Nup & Nlow>-70) = iupN(Nlow<=Nup & Nlow>-70);
imaxN(Nlow>Nup) = ilowN(Nlow>Nup);

imaxN(Nlow<-70) = max(floor(ilowN(Nlow<-70)),1);

% Self-Employed
ilowS = ones(nstate,1).*floor((iminS+imaxS)/2);
iupS  = ilowS+1;
iupS(iupS>nap)=nap;

Slow = UsBk(indU+ilowS) + VNTN(indV+ilowS);
Sup  = UsBk(indU+iupS) + VNTN(indV+iupS);

iminS(Slow<=Sup & Slow>-70) = iupS(Slow<=Sup & Slow>-70);
imaxS(Slow>Sup) = ilowS(Slow>Sup);

imaxS(Slow<-70) = max(floor(ilowS(Slow<-70)),1);

% Businessman

ilowB = ones(nstate,1).*floor((iminB+imaxB)/2);
iupB  = ilowB+1;
iupB(iupB>nap)=nap;

Blow = UbNBk(indU+ilowB) + VNTB(indV+ilowB);
Bup  = UbNBk(indU+iupB) + VNTB(indV+iupB);

iminB(Blow<=Bup & Blow>-70) = iupB(Blow<=Bup & Blow>-70);
imaxB(Blow>Bup) = ilowB(Blow>Bup);

imaxB(Blow<-70) = max(floor(ilowB(Blow<-70)),1);

end


Wmin = Uwk(indU+iminW) + VWTN(indV+iminW);
Wmax = Uwk(indU+imaxW) + VWTN(indV+imaxW);
Smin = UsBk(indU+iminS) + VNTN(indV+iminS);
Smax = UsBk(indU+imaxS) + VNTN(indV+imaxS);
Bmin = UbNBk(indU+iminB) + VNTB(indV+iminB);
Bmax = UbNBk(indU+imaxB) + VNTB(indV+imaxB);
Nmin = Uuk(indU+iminN) + VNTN(indV+iminN);
Nmax = Uuk(indU+imaxN) + VNTN(indV+imaxN);

W = reshape(max(Wmin,Wmax),na,nz,nprob,nkap);
S = reshape(max(Smin,Smax),na,nz,nprob,nkap);
B = reshape(max(Bmin,Bmax),na,nz,nprob,nkap);
N = reshape(max(Nmin,Nmax),na,nz,nprob,nkap);

W = permute(W,[2 1 3 4]);
S = permute(S,[2 1 3 4]);
B = permute(B,[2 1 3 4]);
N = permute(N,[2 1 3 4]);

FS     = griddedInterpolant(z_array,a_array,prob_array,kap_array,S,'linear');
FB     = griddedInterpolant(z_array,a_array,prob_array,kap_array,B,'linear');

% For the self-employed, approximate the value functions for other shocks,
% the same for the value function of the non-employed

TTotS  = reshape(FS(zarrayintS,ATILDES,probarrayintS,kaparrayintS)...
    ,nz,na,neps,nprob,nkap);

%N      = reshape(TTotS(:,:,end,:,:),nz,na,nprob,nkap);
TS     = TTotS(:,:,1:end,:,:);

ES     = reshape(sum(TS .* probmtx,3),nz,na,nprob,nkap);

% Now move to doing the same exercise for the businessmen

TBN    = reshape(FB(zarrayintB,ATILDEBN,probarrayintB,kaparrayintB)...
    ,nz,na,neps,nprob,nkap);

EBN    = reshape(sum(TBN .* probmtx,3),nz,na,nprob,nkap);


TBB    = reshape(FB(zarrayintB,ATILDEBB,probarrayintB,kaparrayintB)...
    ,nz,na,neps,nprob,nkap);

EBB    = reshape(sum(TBB .* probmtx,3),nz,na,nprob,nkap);



distVW = max(max(max(max(abs(W0 - W)./((abs(W0)+abs(W))/2)))));
distVN = max(max(max(max(abs(N0 - N)./((abs(N0)+abs(N))/2)))));
distVS = max(max(max(max(abs(ES0 - ES)./((abs(ES0)+abs(ES))/2)))));
distVB = max(max(max(max(abs(EBN0 - EBN)./((abs(EBN0)+abs(EBN))/2)))));

dist_v = max(max(distVW,distVB),max(distVN,distVS));

W0     = W;
N0     = N;
S0     = S;
ES0    = ES;
EBN0   = EBN;
EBB0   = EBB;

iter_v = iter_v + 1;

end;

if Vflag == 2
    save('ValFun','S','B','W','VwN','VuN','VwB','VuB','EBB','EBN''ES');
end;

Vflag  = 1;
VwNold = VwN0;
VuNold = VuN0;
VwBold = VwB0;
VuBold = VuB0;
Wold   = W0;
Nold   = N0;
Sold   = S0;
ESold  = ES0;
EBNold  = EBN0;
EBBold  = EBB0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IW    = imaxW.*(Wmax>=Wmin) + iminW.*(Wmax<Wmin);
IW    = permute(reshape(IW,na,nz,nprob,nkap),[2 1 3 4]);

IS    = imaxS.*(Smax>=Smin) + iminS.*(Smax<Smin);
IS    = permute(reshape(IS,na,nz,nprob,nkap),[2 1 3 4]);

IB    = imaxB.*(Bmax>=Bmin) + iminB.*(Bmax<Bmin);
IB    = permute(reshape(IB,na,nz,nprob,nkap),[2 1 3 4]);

IN    = imaxN.*(Nmax>=Nmin) + iminN.*(Nmax<Nmin);
IN    = permute(reshape(IN,na,nz,nprob,nkap),[2 1 3 4]);

clear iminW imaxW iminS imaxS iminB imaxB ilowW iupW ilowS iupS ilowB...
    iupB Smin Smax Wmin Wmax Bmin Bmax

%% Stationary Distribution
%--------------------------------------------------------------------------
StatDist;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save the current capital price

qold = 1./(r0+1);
rold = r0;
%{%}
lastresortflag = 0;
ll=1;
BIGPROB      = [1-bigp repmat(bigp,1,neps-1).*repmat(zetta,...
               length(bigp),1)];
% Iint = [valuessmall valueslarge alfasmall alfalarge gamasmall gamalarge]
Falfa1 = griddedInterpolant(Iint(:,1),Iint(:,3));
Falfa2 = griddedInterpolant(Iint(:,2),Iint(:,4));
Fgama1 = griddedInterpolant(Iint(:,1),Iint(:,5));
Fgama2 = griddedInterpolant(Iint(:,2),Iint(:,6));
Fzgam  = griddedInterpolant(Zint(:,1),Zint(:,2));

while ll<1000
% Initialize the new capital price for calculating the equilibrium price at
% the given stationary distribution

X = KLMCMCINT(BIGZ(OCC==3)*varphi,BIGA(OCC==3),kgrid(1,:),r0(1,:),w0...
    ,Falfa1,Fgama1,Fzgam);
LDS       = X(:,1);
savinvS = X(:,2); % occindex=1 if chooses to hire
KDindexS  = X(:,3);
incomeS   = X(:,4);
KDS       = X(:,5);

X = KLMCMCINT(BIGZ(OCC==4),BIGA(OCC==4),kgrid(2,:),r0(2,:),w0...
    ,Falfa2,Fgama2,Fzgam);
LDB       = X(:,1);
savinvB = X(:,2); % occindex=1 if chooses to hire
KDindexB  = X(:,3);
incomeB   = X(:,4);
KDB       = X(:,5);



clear X

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LabMarket;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

KMarket;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{%}
distq = max(max(abs(diffK)));
checkQ(:,:,ll) = q0;


if distq>tolq
q0   = (1-qupdate).*q0 + qupdate.*(qnew);
end

r0 = 1./q0 -1;

%distR           = distq;
checkR(:,ll) = distq;

if distq<tolq
    break
end


if ll>=999 && lastresortflag == 0
    lastresortD = checkR(:,1:ll);
    lastresortI = find(lastresortD == min(lastresortD));
    q0          = checkQ(:,:,lastresortI);
    r0          = 1./q0 - 1;
    lastresortflag = 1;
    ll=ll-1;
end

ll = ll+1;
end

iterR         = iterR + 1


distR =max(max(abs(r0 - rold)*2./(rold+r0)));
%{
if iterR>=maxiterR-1 && lastresortflag == 0
    lastresortD = max(max(checkR(:,:,1:iterR-1)));
    lastresortI = find(lastresortD == min(lastresortD));
    q0          = checkQ(:,:,lastresortI)';
    r0          = 1./q0' - 1;
    iterR       = maxiterR - 1;
    lastresortflag = 1;
end
%}
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
funcdistL(iterL,:) = [(LS-LD)/((LD+LS)/2) w0];

if iterL==2 && sign(funcdistL(iterL,1)) == sign(funcdistL(iterL-1,1))
    if  sign(funcdistL(iterL,1))== -1;
        wmax  = wmax*1.05;
        iterL = iterL - 1;
    elseif sign(funcdistL(iterL,1))== 1;
        wmax  = w0*0.95;
        iterL = iterL - 1;
    end
end
      

if iterL>2
    fs     = funcdistL(iterL,1);
    distL = abs(fs);
    d = c;
    c = b;
    fc = fb;
    if fa*fs<0
        fb = fs;
        b = s;
    else
        fa = fs;
        a = s;
    end;
    
    if abs(fa)<abs(fb)
        cc  = a;
        fcc = fa;
        a = b;
        fa = fb;
        b = cc;
        fb = fcc;
    clear cc fcc
    end;

elseif iterL ==2
    fa = funcdistL(iterL-1,1);
    fb = funcdistL(iterL,1);
     a = funcdistL(iterL-1,2);
     b = funcdistL(iterL,2);
     if abs(fa)<abs(fb)
         temp  =   a;
         ftemp = fa;
         a     = b;
         fa    = fb;
         b     = temp;
         fb    = ftemp;
     end;
     fc = fa;
     c  = a;
end;

stugL(iterL,:) = [iterL LS LD w0];

iterL = iterL + 1;
Lerflag = 0;

wold = w0;

if iterL == 2;
     w0 = wmax;
     if LFLAG == 1;
         if funcdistL(1,1)<0;
         w0 = wold*1.025;
         else 
         w0 = wold*0.975;
         end
     end
end;

if iterL>2
wtol = 100;%abs(funcdistL(iterL-1,2)-funcdistL(iterL-2,2))/funcdistL(iterL-2,2);
end;

disp('Iter, Labor Distance, wage rate')
checkq=toc;
disp([iterL [] distL [] w0 ])
disp('Time')
disp([checkq])

avgr = sum(KBOR(:,1)./sum(KBOR(:,1)).*r0(1,:)');

% Subsistence entrepreneurship share
equsubshare;

disp(['unemp' '....' 'emp' '....''subsemp''....' 'semp' '....' 'wage''...''borrowing R'])
disp([ unemp LS sharesubsemp semp w0 avgr]) 

end;

avgr = sum(KBOR(:,1)./sum(KBOR(:,1)).*r0(1,:)');

% Subsistence entrepreneurship share
equsubshare;

clear a_array z_array kap_array prob_array zarrayintintS probarrayintS...
    kaparrayintS zarrayintB kaparrayintB znarray anarray kapnarray...
    probnarray Zarray Oarray Parray Aarray Karray TS TBN TBB EVwN EVuN...
    EVwB EVuB ATILDES ATILDEBN ATILDEBB W N S BN BB ES EBN EBB VwN0 VwB0...
    VuN0 VuB0 W0 N0 ES0 S0 EBN0 BN0 EBB0 BB0 VWTN VWTB VNTN VNTB ilowW ...
    iupW ilowS iupS ilowB iupB iminW imaxW iminS imaxS iminB imaxB ...
    businc busincN busincNP EABB EABN EBBold EBNold IB IBnew IhireB ...
    IhireNB IhireS MAXESN OCCEMPB OCCEMPNB OCCNEMB OCCNEMNB probmtx ...
    seminc TTotS UbNBk VALMAT VuB VuBold VuN VuNold VwB VwBold VwN VwNold...
    TEMPIND TEMPN TEMPNB tempprob TEMPS TEMPW6 TEMPW8 TINDEX TOTOCC UsBk...
    Uwk Wlow Wup XOCC Wold TB Sup Slow Sold sempinc probdefaultS ...
    probdefaultB probarrayintB POSB OCCS occindexS occindexB Nold MAXNES...
    IS IW INESWB indV indU INDEX ESold EAS dummy Bup Blow bigeprobs...
    B B0 AN zarrayintS occ FABB FABN FAPN FAPS FAPW FB FBB FBN FEVuB...
    FEVuN FEVwB FEVwN FFIN FN FS FW biga bige bigz Iint Zint...
    Falfa1 Falfa2 Fgama1 Fgama2 Fzgam BBBUS BNBUS bigp BIGPROB...
    ilowN imaxN iminN iupN IN NBUS Nlow Nmax Nmin Nup NNON WBUS WNON

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Concentrate only on r0 as it is clearing the market and not rnew!

% FLAGUNCLEARL is a flag that if equal to 1 indicates that the labor market
% hasn't cleared, so then I find the wage that created lowest dist(LD,LS)
% and run the model under that wage

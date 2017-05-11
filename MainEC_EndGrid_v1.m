clear all
Vflag = 0; % 2 loads the Vfuns from other simulations as starting values, 
% 1 doesn't make sense in here at the code will give an error, 0 uses zeros
% as initial values for the Vfun iteration.
tic
rng(1)
%% Parameters

global r_bar deltta alfa nu gama Gama xi

% Environment and Preference Parameters Parameters
r_bar    = 0.04;
betta    = 0.95;
sigma    = 2; % Risk aversion coefficient, log utility if 1

% Unemployment tax and benefit
tau        = 0.05;

% Job destruction and job finding parameters
lambda = 0.2;
mu     = 0.2;

% Production Parameters
deltta   = 0.06;
alfa     = 0.28;
nu       = 0.85;
gama     = nu - alfa;

% Distribution Parameters
ZDist    = 1; % Pareto, if 1. Normal if 2
etta     = 6.7;
sigz     = 1;

PSI      = 0.15; % The probability of changing the talent, then will be randomly drawn from z

ettakap  = 0.05; % Two parameters that will be useful for the disutility from work
sigkap   = 5;

% The Default Parameters
mueps    = [0.8 0.1 0.1]; % if neps =1 mueps - probability, sigeps - value in function
sigeps   = [0 0.1 5];

EPSdist  = 1; % 1 if normal distributed
KAPdist  = 1;

xi       = 0.2; % Exemption level

% Grid Parameters
apmin    = 0.1;
apmax    = 100;
na      = 120;
nz      = 15;
nkap    = 7;
ne      = 3; % The number of occupations
neps    = 3;
nr      = 3; % Number of interest rates a self-emp can face

% The Grids
Amethod   = 1; % 1 if linear, 2 if logarithmic
apgrid    = adist(apmin,apmax,na,Amethod);

X        = prodshock(mueps,sigeps,neps,EPSdist); % P and epsilon can also be vectors with size neps
P        = X(:,1);
epsilon  = X(:,2);
clear X

X        = zdist(sigz,etta,nz,ZDist);
Pz       = X(:,1);
zgrid    = X(:,2);
clear X

X        = kapdist(ettakap,sigkap,nkap,KAPdist);
Pkap     = X(:,1); 
kapgrid  = X(:,2);
clear X

% Stationary Distribution Parameters
N  = 30000;
T  = 500;

% Initial Values of the variables
w0       = 0.9;

% Probabilities of facing a given borrowing rate
Pr = rand(nr,nz);
Pr = Pr./repmat(sum(Pr,1),nr,1);


r0       = [0.04 0.05 0.09];
b0       = 0.2;

%--------------------------------------------------------------------------
% The Stationary Distribution Parameters
NN = 3e4;
TT = 250;

nA = 400;

Apgrid = adist(apmin,apmax,nA,Amethod);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters Fixed for the CHECKS
kapgrid(1) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
% Auxilliary Parameters

Gama = (gama^gama)/((1+gama)^(1+gama));

estatdum = [(rand(NN,1)>0.2) rand(NN,T-1)];

APgrid = repmat(apgrid',1,nz,nkap);
Zgrid  = repmat(zgrid',na,1,nkap);
KAPgrid = repmat(reshape(kapgrid,1,1,nkap),na,nz,1);

dta = 0.0001; % for derivatives
PR = repmat(Pr,1,1,neps,na,nkap);
P  = P./sum(P);
PP = repmat(reshape(P,1,1,neps),1,nz,1,na,nkap);
PZ = repmat(Pz',na,1,nkap);

%--------------------------------------------------------------------------
% The Stationary Distribution of Talents

bigz   = zstatdist(zgrid, nz,PSI,NN,TT); 
bigkap = randsample([1:nkap]',NN,1,Pkap);

bige   = rand(NN,TT);
bige(bige(:,1)>0.5,1) = 1;
bige(bige(:,1)<=0.5,1) = 0;
bige = bige+1;


for ii = 2:TT
    TEMP1 = bige(:,ii-1);
    TEMP2 = bige(:,ii);
    TEMP2(TEMP1==1 & TEMP2<(1-lambda)) = 1;
    TEMP2(TEMP1==0 & TEMP2<(1-mu))     = 1;
    TEMP2(TEMP2<1) = 0;
    bige(:,ii) = TEMP2;
end

biga = [randsample(apgrid,NN,1)',zeros(NN,TT-1)];

occ  = zeros(NN,TT);

%% The Income matrices
%--------------------------------------------------------------------------
winc = w0 + (1+r_bar)*apgrid' - tau;
uinc = b0 + (1+r_bar)*apgrid';

% Here businc are as in the notes, they include both business profits and
% income from depositing left-over assets, doesn't include taxes 

X = profitcalc(zgrid,apgrid,r0,w0);
businc = X(:,:,:,1);
indhire = X(:,:,:,2); % Index indicating whether the individual hires or not
clear X

% The Shock and after-shock businc - busincP. I here allow for
% heterogeneity in shocks, meaning that neps>1 is possible

X = aftershockinc(businc, epsilon, neps); % X(nz x na x nr x neps) 
busincP = X; 
clear X
busincP = permute(busincP,[2 1 3 4]); % na x nz x nr x neps

if Vflag == 0
EV1 = repmat(ucalc(winc,sigma),1,nz,nkap);
EV2 = repmat(ucalc(busincP(:,:,1,1),sigma),1,1,nkap);
elseif Vflag == 1
EV1 = EV1old;
EV2 = EV2old;
elseif Vflag == 2
    load('VFUNC')
end;    

 busincP = reshape(permute(busincP,[1 3 4 2]),na*nr*neps,nz); % (na*nr*neps x nz)
 busincP = repmat(busincP,1,nkap);

V1up = zeros(na,nz*nkap);
V2up = zeros(na,nz*nkap);
V3up = zeros(na*nr*neps,nz*nkap);
%%%
distv = 10;
tolv  = 1e-4;
iterv = 1;
maxiterv = 2.5e3;

%% Endogenous Grid Value Function Iteration

while distv>tolv && iterv<maxiterv

F1    = griddedInterpolant(APgrid,Zgrid,KAPgrid,EV1);
F2    = griddedInterpolant(APgrid,Zgrid,KAPgrid,EV2);

EV1p = (F1(APgrid+dta,Zgrid,KAPgrid) - F1(APgrid-dta,Zgrid,KAPgrid))/(2*dta);
EV2p = (F2(APgrid+dta,Zgrid,KAPgrid) - F2(APgrid-dta,Zgrid,KAPgrid))/(2*dta);

c1 = (betta*EV1p).^(-1/sigma);
c2 = (betta*EV2p).^(-1/sigma);

m1 = reshape(c1 + APgrid,na,nz*nkap);
m2 = reshape(c2 + APgrid,na,nz*nkap);


V1new = reshape(ucalc(c1,sigma) - KAPgrid  + betta * EV1,na,nz*nkap);
V2new = reshape(ucalc(c2,sigma) + betta * EV2,na,nz*nkap);

nzkap = nz*nkap;

for ii = 1:nzkap
F3 = griddedInterpolant(m1(:,ii),V1new(:,ii));
F4 = griddedInterpolant(m2(:,ii),V2new(:,ii));

V1up(:,ii) = F3(winc);
V2up(:,ii) = F4(uinc);
V3up(:,ii) = F4(busincP(:,ii));
end

EVold = [EV1 EV2];

V3up = permute(reshape(V3up,na,nr,neps,nz,nkap),[2 4 3 1 5]);
EV3up = sum(V3up.* PR,1);
EV3up = sum(EV3up.*PP,3);
EV3up = permute(EV3up,[4 2 5 1 3]);

V1up = reshape(V1up,na,nz,nkap);
V2up = reshape(V2up,na,nz,nkap);


VW = max(V1up,max(V2up,EV3up));
VU = max(V2up,EV3up);

EVW = (1-PSI)*VW + repmat(PSI*sum(VW.*PZ,2),1,nz,1);
EVU = (1-PSI)*VU + repmat(PSI*sum(VU.*PZ,2),1,nz,1);

EV1 = (1-lambda)*EVW + lambda*EVU;
EV2 = (1-mu)*EVW + mu*EVU;

distvOLD= distv;

distv = max(max(max(abs((EVold-[EV1 EV2])./[EV1 EV2]))));

iterv = iterv + 1;
if distv<tolv | iterv>maxiterv
    W = V1up;
    N = V2up;
    S = EV3up;
end

if distv>distvOLD
    W = V1up;
    N = V2up;
    S = EV3up;
    break;
end

V1up = nan(na,nz*nkap);
V2up = nan(na,nz*nkap);
V3up = nan(na*nr*neps,nz*nkap);
end
toc
%--------------------------------------------------------------------------
if Vflag == 2
    save('VFUNC','EV1','EV2');
end;

Vflag = 1;
EV1old = EV1;
EV2old = EV2;

%% The Occupations and the Thresholds
%{
% Make them na x nkap, nz

W = reshape(permute(W,[1 3 2]),nkap*na,nz);
S = reshape(permute(S,[1 3 2]),nkap*na,nz);
N = reshape(permute(N,[1 3 2]),nkap*na,nz);

%{
WS = W - S;

[temp IWS(:,2)]= min((WS>0),[],2);
clear temp
IWS(:,1) = IWS(:,2)-1;
IWSt = na*nkap*(IWS-1)+repmat([1:na*nkap]',1,2);



% threshold managerial talent that makes individuals of type (a,kap) be
% indifferent between working and self-employment

zwthresh = zeros(na*nkap,1);
zwthresh(IWS(:,1)==0) = zgrid(1);
zwthresh(IWS(:,2)==0) = nan;

wghtw = abs(WS(IWSt(IWS(:,1)>0,2)))./(WS(IWSt(IWS(:,1)>0,1)) - ...
    WS(IWSt(IWS(:,1)>0,2)));

% wghtw = abs(WS(IWSt(IWS(:,1)>0,2)))./(abs(WS(IWSt(IWS(:,1)>0,1))) +...
%     abs(WS(IWSt(IWS(:,1)>0,2))));
% 
% zwthresh(IWS(:,1)>0) = zgrid(IWS(IWS(:,1)>0,1)) + wghtw.*...
%     (zgrid(IWS(IWS(:,1)>0,2)) - zgrid(IWS(IWS(:,1)>0,1)));

zwthresh(IWS(:,1)>0) = zgrid(IWS(IWS(:,1)>0,2)) - wghtw.*...
    (zgrid(IWS(IWS(:,1)>0,2)) - zgrid(IWS(IWS(:,1)>0,1)));

znthresh = zeros(nkap*na,1);

NS = N-S;

[temp INS(:,2)] = min(NS>0,[],2);
clear temp
INS(:,1) = INS(:,2) - 1;
INSt = na*nkap*(INS-1)+repmat([1:na*nkap]',1,2);

znthresh = zeros(na*nkap,1);
znthresh(INS(:,1)==0) = zgrid(1);
znthresh(INS(:,2)==0) = nan;

wghtn = abs(NS(INSt(INS(:,1)>0,2)))./(abs(NS(INSt(INS(:,1)>0,1))) +...
    abs(NS(INSt(INS(:,1)>0,2))));

znthresh(INS(:,1)>0) = zgrid(INS(INS(:,1)>0,2)) - wghtn.* ...
    (zgrid(INS(INS(:,1)>0,2)) - zgrid(INS(INS(:,1)>0,1)));

clear wghtw wghtn
% the value of kappa that makes an individual indifferent between working
% and not working, and between working and becoming self-employed for
% different combinations of talent and asset endowment

% kapwthresh = zeros(na,nz);
% WS = reshape(permute(reshape(WS,na,nkap,nz),[1 3 2]),na*nz,nkap);
%  
% [temp IWSkap(:,2)] = min(WS>0,[],2);
% clear temp
% IWSkap(:,1) = IWSkap(:,2)-1;

WN = W - N;

[temp IWN(:,2)] = min(WN>0,[],2);
IWN(:,1) = IWN(:,2) - 1;
IWNt = na*nkap*(IWN-1)+repmat([1:na*nkap]',1,2);

zwnthresh = zeros(na*nkap,1);
zwnthresh(IWN(:,1)==0) = zgrid(1);
zwnthresh(IWN(:,2)==0) = nan;
zwnthresh(temp==1)     = zgrid(end);


wghtwn = abs(WN(IWNt(IWN(:,1)>0,2)))./(abs(WN(IWNt(IWN(:,1)>0,1))) +...
    abs(WN(IWNt(IWN(:,1)>0,2))));

zwnthresh(IWN(:,1)>0) = zgrid(IWN(IWN(:,1)>0,2)) - wghtwn.* ...
    (zgrid(IWN(IWN(:,1)>0,2)) - zgrid(IWN(IWN(:,1)>0,1)));

%}


%{
WN = W - N;
WN = reshape(permute(reshape(WN,na,nkap,nz),[1 3 2]),na*nz,nkap);
kapthresh = nan(na*nz,1);

[temp IWN(:,2)] = min((WN>0),[],2);

IWN(temp==1,2)=nan;
IWN(:,1) = IWN(:,2)-1;
IWNt = na*nz*(IWN-1) + repmat([1:na*nz]',1,2);
wght = abs(WN(IWNt(~isnan(IWN(:,1)),2)));

tempind = (~isnan(IWN(:,1)) & IWN(:,1)>0);

kapthresh(tempind) = kapgrid(IWN(tempind,2)) -wght.*...
    (kapgrid(IWN(tempind,2)) - kapgrid(IWN(tempind,1)));
%}


zwbar = WSzbar(W,S,zgrid,na,nkap);
znbar = NSzbar(N,S,zgrid,na,nkap);
zwnbar = WNzbar(W,N,zgrid,na,nkap);

zorder = zeros(na,nkap);
zorder(zwnbar>znbar)  = 2;
zorder(zwnbar<=znbar) = 1; 
%}
W = reshape(permute(W,[2 3 1]),nz*nkap,na);
S = reshape(permute(S,[2 3 1]),nz*nkap,na);
N = reshape(permute(N,[2 3 1]),nz*nkap,na);

occindex = occs(W,N,S,na,nz,nkap);

TEMP1 = occindex(:,1:end-1,1)==occindex(:,2:end,1);

TEMP2    = sum(TEMP1==0,2);
INDTEMP1 = find(TEMP2<=1);
INDTEMP2 = find(TEMP2==2);
INDTEMP3 = find(TEMP2==3);
INDTEMP4 = find(TEMP2==4);
INDTEMP5 = find(TEMP2>4);

check = nan(nz*nkap,4);





%% The Stationary Distribution

% The order of threshold zs

% bige=2 then work option, if bige=1 no work option, similar to the
% occindex




% tt = 1:TT




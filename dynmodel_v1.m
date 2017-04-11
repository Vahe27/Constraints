clear all
tic

% Auxilliary Parameters
Vflag  = 0;
upparam = 0.7;

r_bar  = 0.04;
betta  = 0.96;

lambda = 0.3; % The prob of losing the job
mu     = 0.34; % The prob of NOT finding a job

psi    = 0.8; % Probability of keeping talent, kappa is permanent
b      = 0.3;
alfa   = 0.28;
nu     = 0.85;
gama   = nu-alfa;
etta   = 7;
ettak  = 3;
P      = 0.2;
epsilon = 2;
xi     = 0.2;

nz     = 1000;
nk     = 1000;

zstep  = linspace(0,1,nz+1)-0.5/nz;
zstep  = zstep(2:end);

z      = (1-zstep').^(-1/etta);

kstep  = linspace(0,1,nk+1)-0.5/nk;
kstep  = kstep(2:end);

kappa  = (1-kstep).^((-1)/ettak);
kcoef  = 0.3;
kappa  = kappa * kcoef;

%% The Loop goes with w and r

w0 = [1.00823959708213];
r0 = [0.0651116346804909];% 0.06;

NN = 5e4;
T  = 5e2;

estatdum = [(rand(NN,1)>0.1) rand(NN,T-1)];
occ   = zeros(NN,T);

bigz   = zeros(NN,T);
bigz(:,2:end) = rand(NN,T-1);
bigz(bigz<psi) = 0;
bigz(bigz>=psi) = 1;
bigz(:,1) = randsample([1:nz]',NN,1);

for t = 2:T
    Temp1 = bigz(:,t);
    Temp2 = bigz(:,t-1);
    Temp3 = randsample([1:nz]',sum(Temp1),1);
    Temp1(bigz(:,t)==0) = Temp2(bigz(:,t)==0);
    Temp1(bigz(:,t)==1) = Temp3;
    bigz(:,t) = Temp1;
       
end;

clear Temp1 Temp2 Temp3 
%--------------------------------------------------------------------------
%% Capital Market Clearing

distR    = 100;
distRtol = 1e-3;
iterR    = 1;
maxiterR = 100;

while distR>distRtol && iterR<maxiterR

%% Labor Market, iteration on w, simple bisection

wmin     = 0.6;
wmax     = 1.25;
iterL    = 1;
maxiterL = 100;
distL    = 100;
distLtol = 5e-4;

while distL>distLtol && iterL<maxiterL
% Fix the seed
rng(1) 
%
if Vflag == 0
N0       = zeros(nz,nk);
W0       = zeros(nz,nk);
S0       = zeros(nz,nk);
Vw       = zeros(nz,nk);
Vn       = zeros(nz,nk);
else
N0       = Nold;
W0       = Wold;
S0       = Sold;
Vw       = Vwold;
Vn       = Vnold;
end

iterV    = 1;
maxiterV = 500;
distV    = 100;
distVtol = 1e-5;

while distV>distVtol && iterV<maxiterV

Gpi = (1-nu) * ((1+r0)/alfa)^(nu/(nu-1)) * (alfa*w0/(gama*(1+r0)))^(gama/(nu-1));
Gl  = ((1+r0)/alfa)^(1/(nu-1)) * (alfa*w0/gama*(1+r0))^((1-alfa)/(nu-1)); 
Gk  = ((1 + r0)/alfa)^(1/(nu - 1)) * (alfa*w0/(gama * (1 + r0)))^(gama/(nu - 1));
Gy  = (r0/alfa)^(alfa/(nu-1)) * (gama/w0)^(gama/(1-nu));

profit = z.^(1/(1-nu))*Gpi;
Eprofit = (1-P)*profit + P*max(profit-epsilon,xi);



Vw = max(W0,max(S0,N0));

Vn = max(N0,S0);

EVn = psi*Vn + repmat((1-psi)*ones(1,nz)*Vn/nz,nz,1);
EVw = psi*Vw + repmat((1-psi)*ones(1,nz)*Vw/nz,nz,1);


W = w0 - repmat(kappa,nz,1) + betta * (lambda * EVn + (1-lambda)* EVw);
S = repmat(Eprofit,1,nk) + betta * EVn;
N = b + betta * (mu*EVn + (1-mu) * EVw);


distN = max(max(abs(N0-N)));
distW = max(max(abs(W0-W)));
distS = max(max(abs(S0-S)));

N0 = N;
S0 = S;
W0 = W;

distV = max(distN,max(distW,distS));

iterV = iterV+1;

end;

Vflag = 1;
Nold  = N0;
Sold  = S0;
Wold  = W0;
Vnold = Vn;
Vwold = Vw;

% switch for a worker to Work, or Semp, or Nonwork
swW = W0>max(S0,N0);
swS = S0>max(W0,N0);
swN = N0>max(S0,W0);
% switch for nonworker (doesn't have job) to Semp
snS = S0>N0;

kapbar = w0 - b; % The value of kappa that makes an agent indifferent

% Here I do a small trick. Given kappa is permanent and not correlated with
% talent z, there will be two groups of people not interacting with each
% other. First group, those with kappa>kapbar who either choose S or N, and
% those with kappa<kapbar that work as well.
zb = ((xi + epsilon)/(Gpi))^(1-nu);
zn = ((b - P*xi)/((1-P)*Gpi))^(1-nu);

Sabovek = (1/kcoef*kapbar)^(-ettak) * zn^(-etta);

Ikapbar = max(find(kappa<=kapbar));
bigk = repmat(randsample([1:Ikapbar],NN,1)',1,nk);

% Work status estat 1 if can work, 0 if not allowed to work


estat = estatdum;

for tt=1:T;

ITemp1 = find(estat(:,tt)==1);

% Temp2=10 if workers and 5 if semp

Temp1 = (swW(bigz(ITemp1,tt)+(bigk(ITemp1,tt)-1)*nz)+1)*5;

ITemp2 = find(estat(:,tt) == 0);

Temp2 = snS(bigz(ITemp2,tt) + (bigk(ITemp2,tt)-1)*nz)*5;

occ(ITemp1,tt) = Temp1;
occ(ITemp2,tt) = Temp2;

clear Temp1 Temp2 ITemp1 ITemp2

if tt<T

    Temp4 = estat(:,tt);
    Temp5 = estat(:,tt+1);
    Temp5(Temp4==1 & Temp5<lambda) = 0;
    Temp5(Temp4==1 & Temp5>=lambda) = 1;
    Temp5(Temp4==0 & Temp5<mu) = 0;
    Temp5(Temp4==0 & Temp5>=mu) = 1;
    
    Temp5(occ(:,tt)==5) = 0;
    estat(:,tt+1) = Temp5;
end
end;

sharesemp = [sum(occ(:,end)==5)/NN sum(occ(:,T-0.1*T)==5)/NN sum(occ(:,T-0.2*T)==5)/NN...
 sum(occ(:,T-0.3*T)==5)/NN sum(occ(:,T-0.4*T)==5)/NN sum(occ(:,T-0.5*T)==5)/NN sum(occ(:,T-0.6*T)==5)/NN];

sharenon = [sum(occ(:,end)==0)/NN sum(occ(:,T-0.1*T)==0)/NN sum(occ(:,T-0.2*T)==0)/NN...
 sum(occ(:,T-0.3*T)==0)/NN sum(occ(:,T-0.4*T)==0)/NN sum(occ(:,T-0.5*T)==0)/NN sum(occ(:,T-0.7*T)==0)/NN];

sharework = [sum(occ(:,end)==10)/NN sum(occ(:,T-0.1*T)==10)/NN sum(occ(:,T-0.2*T)==10)/NN...
 sum(occ(:,T-0.3*T)==10)/NN sum(occ(:,T-0.4*T)==10)/NN sum(occ(:,T-0.5*T)==10)/NN sum(occ(:,T-0.6*T)==10)/NN];

% disp('share semp')
% sharesemp
% disp('share nonemp')
% sharenon
% disp('share workers')
% sharework

%% The Labor Demand and Supply

% First, the calculations above are done only for those with k<\bar{k} so
% measure adjustments need to be done

POPabovek = (1/kcoef*kapbar)^(-ettak);

LS = sum(occ(:,end)==10)/NN*(1-POPabovek);

Szdist = z(bigz(occ(:,end)==5,end));

% LDnon the labor demand of the self employed that have kappa above
% \bar{kappa}. I calculate this under the assumption of Pareto Distributed
% entrepreneurial talents. kappa is also calculated under assumption of
% Pareto distributed costs (disutilities)

LDnon = etta/(etta - 1/(1-nu)) * Gl * zn^(1/(1-nu) - etta) * POPabovek;

LD = sum(Szdist.^(1/(1-nu))*Gl)/NN*(1-POPabovek) + LDnon;

    
distL = abs(LD - LS)/((LD+LS)*0.5);


if LS>LD
    
    wmax = w0;
else
    wmin = w0;

end;

w0old = w0;
w0 = (wmin + wmax)/2;

iterL = iterL+1
distL
end;

%% The Capital Demand, Supply and the Borrowing Interest Rate

KDnon = etta/(etta - 1/(1 - nu)) * Gk * zn^(1/(1-nu) - etta) * POPabovek;

KD    = sum(Szdist.^(1/(1 - nu))*Gk)/NN * (1 - POPabovek) + KDnon;


% Calculate the capital on which individuals will default. It includes
% those with kappa<\bar{k} and talent bw zn and zb and those working with
% zb and below


Knondefault = Gk * etta/(1/(1-nu) - etta) * (zb^(1/(1-nu) - etta) - ...
    zn^(1/(1-nu) - etta)) * P * POPabovek;

Kdefault = sum(Szdist(Szdist<zb).^(1/(1 - nu)))*Gk/NN * P * (1-POPabovek) +...
    Knondefault;


r = KD/ (KD - Kdefault) * (1 + r_bar) - 1;

distR = abs(r - r0)/((r+r0)/2);

r0 = upparam * r + (1 - upparam) * r0;

iterR = iterR+1;

end;    

toc

























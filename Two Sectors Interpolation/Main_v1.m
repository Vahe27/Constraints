clear all
Vflag = 0; % 2 loads the Vfuns from other simulations as starting values, 
% 1 doesn't make sense in here at the code will give an error, 0 uses zeros
% as initial values for the Vfun iteration.
CONTSTATDIST = 1; % Use continuous values in stationary distribution calc-
% culation insead of grid points if CONSTATDIST = 1.
tic
rng(1)
%% Parameters

global r_bar deltta alfa nu gama Gama xi

% Environment and Preference Parameters Parameters
r_bar    = 0.04;
betta    = 0.945;
sigma    = 2; % Risk aversion coefficient, log utility if 1

% Job destruction and job NOT finding parameters
lambda = 0.2;
mu     = 0.1;

% Production Parameters
deltta   = 0.06;
alfa     = 0.28;
nu       = 0.85;
gama     = nu - alfa;

% Distribution Parameters
ZDist    = 1; % Pareto, if 1. Normal if 2
etta     = 6.8;
sigz     = 1;

PSI      = 0.10; % The probability of changing the talent, then will be randomly drawn from z

ettakap  = 0.05; % Two parameters that will be useful for the disutility from work
sigkap   = 5;

% The Default Parameters
mueps    = [0.7 0.2 0.1]; % if neps =1 mueps - probability, sigeps - value in function
sigeps   = [0 2 5];

EPSdist  = 1; % 1 if normal distributed
KAPdist  = 1;

xi       = 0.3; % Exemption level

% Grid Parameters
amin    = 0.1;
amax    = 350;
na      = 200;
nz      = 50;
nkap    = 7;
ne      = 3; % The number of occupations
neps    = 3;
nr      = 3; % Number of interest rates a self-emp can face

% The Grids
Amethod   = 1; % 1 if linear, 2 if logarithmic
agrid    = adist(amin,amax,na,Amethod);

X        = prodshock(mueps,sigeps,neps,EPSdist); % P and epsilon can also be vectors with size neps
P        = X(:,1);
epsilon  = X(:,2);
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
w0       = [1.22322136311183];
r0       = [0.04 0.05 0.06];
b0       = 0.1;
% Unemployment tax and benefit
tau        = [0.0198];

% Probabilities of facing a given borrowing rate
Pr(1,:) = linspace(0.1,0.9,nz);
Pr(2,:) = linspace(0.4,0.05,nz);
Pr(3,:) = linspace(0.5,0.05,nz);

%Pr = rand(nr,nz);
Pr = Pr./repmat(sum(Pr,1),nr,1);

%--------------------------------------------------------------------------
% The Stationary Distribution Parameters
NN = 7e4;
TT = 350;

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

%Pr   = [0.2;0.6;0.2];
Gama = (gama^gama)/((1+gama)^(1+gama));

% As a benchmark for approximation, I choose highest shock, eps=eps_max and
% low borrowing rate r_min>r_bar

bnr   = 1;
bneps = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nnn          = na*nr*neps;
kap_array    = repmat(reshape(kapgrid,1,1,nkap),nz,na,1);
a_array      = repmat(agrid,nz,1,nkap);
z_array      = repmat(zgrid,1,na,nkap);
z_arrayint   = repmat(zgrid,1,nnn,nkap);
kap_arrayint = repmat(reshape(kapgrid,1,1,nkap),nz,nnn,1);
TS           = zeros(nz,nnn,nkap);

%Pr_int       = repmat(reshape(Pr,1,1,nr,1,1),nz,na,1,1,nkap);
Pr_int       = repmat(reshape(Pr',nz,1,nr),1,na,1,1,nkap);
Peps_int     = repmat(reshape(P,1,1,1,neps,1),nz,na,nr,1,nkap);
%--------------------------------------------------------------------------
% The Stationary Distribution of Talents

StatesforStatDist;
%{
 %-------------------------------------------------------------------------
%% Government Budget Loop starts here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 disttau = 100;
 toltau  = 5e-3;
 itertau = 1;
 maxitertau = 20;
 tautol     = 100;
 tautolmax  = 1e-7;
 tauupdate  = 0.4;
 
 while disttau > toltau && itertau<maxitertau
 %}
%--------------------------------------------------------------------------
%% The Labor Loop starts here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Labor Market Loop Matrices ----------------------------------------------
distL    = 100;
tolL     = 0.004;
maxiterL = 20;
iterL    = 1;
stugL    = zeros(maxiterL,3);
wmax     = 1.5;
wmin     = 0.6;
mflagL    = 1;
wtol      = 100;
wtolmax   = 1e-7;
tolaux   = 1e-5;
% Capflag = 0 means that profits will be calcualted in profitcalc and not
% the capital demand
Capflag = 0;
%--------------------------------------------------------------------------
clear funcdistL
while distL>tolL && iterL<maxiterL && wtol > wtolmax
    
%%%%%%%%%%%%%%%%%%%%%%%%%FIX THE SEED$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    
rng(2)
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
 
%% Capital Loop starts here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
distR    = 100;
tolR     = 5e-3;
iterR    = 1;
maxiterR = 30;
rtol     = 100;
rtolmax  = 1e-7;
rupdate  = 0.15;

while distR>tolR && iterR<maxiterR 
%}

%--------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kapgrid(1)=0;

%% The Consumption matrices
%--------------------------------------------------------------------------

% Here businc are as in the notes, they include both business profits and
% income from depositing left-over assets, doesn't include taxes 
Capflag = 0;
X = profitcalc(zgrid,agrid,r0,w0,Capflag);
businc   = X(:,:,:,1);
indhire  = X(:,:,:,2); % Index indicating whether the individual hires or not
clear X

% The Shock and after-shock businc - busincP. I here allow for
% heterogeneity in shocks, meaning that neps>1 is possible

X = aftershockinc(businc, epsilon, P,neps,Capflag); % X(nz x na x nr x neps) 
busincP = X; 
clear X

consw = zeros(nz,na,na);
consu = zeros(nz,na,na);
conss = zeros(nz,na,na);

consw = w0 + (1 + r_bar) * repmat(agrid,1,1,na) - repmat(reshape(agrid,1 ...
,1,na),1,na,1) - tau;

consu = b0 + (1 + r_bar) * repmat(agrid,1,1,na) - repmat(reshape(agrid,1 ...
,1,na),1,na,1);

% Need to choose a benchmark for the value function iteration. The strategy
% is to calculate the optimal cons and saving for a given asset level and
% given shock and borrowing rate, conditional on managerial talent, and
% then interpolate the "Cash-on-hand" after the shock and get saving and
% consumption choice for other shock and borrowing rate combinations.

% The argument is: given z, having asset a1, and facing eps1 r1 is
% equivalent to having asset a2 and facing eps2, r2 as long as
% pi(z,a1,eps1,r1) = pi(z,a2,eps2,r2) in terms of consumption and
% investment choice.

conssB = repmat(busincP(:,:,bnr,bneps),1,1,na) - ...
    repmat(reshape(agrid,1,1,na),nz,na,1)  - tau;

Atilde  = assetaprox(busincP,agrid,bnr,bneps,nz,na,nr,neps);
bench   = busincP(:,:,bnr,bneps);

Uw  = ucalc(consw, sigma);
Uu  = ucalc(consu, sigma);
UsB = ucalc(conssB, sigma);


% Adding the kappa dimension

Uwk = disU(Uw,nz,na,nkap,kapgrid);

Uuk = repmat(Uu,nz,1,1,nkap);

UsBk = repmat(UsB,1,1,1,nkap);

clear consw consu conssB Uu Uw UsB

%--------------------------------------------------------------------------

% Auxilliary Parameters II
ATILDE       = repmat(reshape(Atilde,nz,nnn),1,1,nkap);
%% Value Function Iteration
% --------------------Value Funcion Interation-----------------------------

if Vflag == 0
Vu = zeros(nz,na,nkap);
Vw = Vu+0.25;
W  = log((1-betta)*w0)/((1-betta)*(1-lambda))*ones(nz,na,nkap);
N  = log((1-betta)*b0)/((1-betta)*(1-mu))*ones(nz,na,nkap);
S  = log((1-betta)*w0)/((1-betta)*(1-mu))*ones(nz,na,nkap);
ES = S;

Vu0 = zeros(nz,na,nkap);
Vw0 = Vu0 + 0.25;
W0  = Vw0 + 0.25;
N0  = W0 + 0.25;
S0  = N0 + 0.25;
ES0 = S0;

elseif Vflag == 1
    
Vw0 = Vwold;
Vu0 = Vuold;
W0  = Wold;
N0  = Nold;
S0  = Sold;
ES0 = ESold;
elseif Vflag == 2
    
load('ValFun')

W0 = W;
N0 = N;
S0 = S;
ES0 = ES;
end

%%%%%%%%%%NEED TO CONTINUE HERE IF FAIL WITH THE OTHER OPTION%%%%%%%%%%%%%%

maxiter_v = 1000;
iter_v  = 1;
tol_v   = 1e-4;
dist_v  = 500;

while iter_v<maxiter_v && dist_v>tol_v

Vw = max(W0,max(ES0,N0));
Vu = max(ES0,N0);

% Can't multiply 3d matrices that's why I first reshape Vw(nz,na,nkap) to
% Vw(nz,na*nkap) then calculate the expected values wrt z, then reshape
% back to EVw(1,na,nkap) and then repmat to EVw(nz,na,nkap) 


EVw = (1-PSI) * Vw + PSI * repmat(reshape(ones(1,nz)*reshape(Vw,nz,na...
    *nkap)/nz,1,na,nkap),nz,1,1);
EVu = (1-PSI) * Vu + PSI * repmat(reshape(ones(1,nz)*reshape(Vu,nz,na...
    *nkap)/nz,1,na,nkap),nz,1,1);


[W IW] = max(Uwk + repmat(reshape(betta * ((1 - lambda) * EVw + lambda *...
    EVu),nz,1,na,nkap),1,na,1,1),[],3);
W      = reshape(W,nz,na,nkap);

[N IN] = max(Uuk + repmat(reshape(betta * ((1 - mu) * EVw + mu * ...
    EVu),nz,1,na,nkap),1,na,1,1),[],3);
N      = reshape(N,nz,na,nkap);

[S IS] = max(UsBk + repmat(reshape(betta * ((1 - mu) * EVw + mu * ...
    EVu),nz,1,na,nkap),1,na,1,1),[],3);
S      = reshape(S,nz,na,nkap);

F      = griddedInterpolant(z_array,a_array,kap_array,S,'linear');

TS     = reshape(F(z_arrayint,ATILDE,kap_arrayint),nz,na,nr,neps,nkap);

ES     = reshape(sum(sum(TS .* Peps_int,4).* Pr_int,3),nz,na,nkap);



distVW = max(max(max(abs(W0 - W)./((abs(W0)+abs(W))/2))));
distVN = max(max(max(abs(N0 - N)./((abs(N0)+abs(N))/2))));
distVS = max(max(max(abs(ES0 - ES)./((abs(ES0)+abs(ES))/2))));

dist_v = max(distVW,max(distVN,distVS));

W0  = W;
N0  = N;
S0  = S;
ES0 = ES;
iter_v = iter_v + 1;


end;


clear Vb0 Vs0 Vw0 Vtemp EVtemp Vbtemp EVbtemp Temp1 Temp2 EV EVb

if Vflag == 2
    save('ValFun','S','N','W','Vw','Vu','ES');
end;

Vflag = 1;
Nold  = N;
Sold  = S;
Wold  = W;
Vuold = Vu;
Vwold = Vw;
ESold = ES;

IW    = reshape(IW,nz,na,nkap);
IN    = reshape(IN,nz,na,nkap);


%--------------------------------------------------------------------------
if CONTSTATDIST == 0 
StatdistVFI;
else
StatdistVFIcont;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
KLflag = 1;
rng(5);
Pr =rand(length(BIGA(OCC==3)),nr);
Pr = Pr./repmat(sum(Pr,2),1,nr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = KLcalcMCMC(BIGZ(OCC==3),BIGA(OCC==3),r0,w0,KLflag);
LD       = X(:,:,1);
occindex = X(:,:,2);
KD       = X(:,:,3);


LabMarket;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
CapMarket;

diffK = (Klent-Kreceived)*2./(Klent+Kreceived);

rnew = Klent./(Kreceived./(1+r0)) -1;

r0 = (1-rupdate)*r0 + rupdate*rnew;

iterR = iterR+1
distR = max(abs(diffK))

end
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
funcdistL(iterL,:) = [(LS-LD)/((LD+LS)/2) w0];

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

stugL(iterL,:) = [iterL distL w0];

iterL = iterL + 1;
Lerflag = 0;

if iterL == 2;
     w0 = wmax;
end;

if iterL>2
wtol = abs(funcdistL(iterL-1,2)-funcdistL(iterL-2,2))/funcdistL(iterL-2,2);
end;

disp('Iter, Labor Distance, wage rate')
xx=toc;
disp([iterL [] distL [] w0 ])
disp('Time')
disp([xx])
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
nempshare = sum(OCC==1)/NN;

taunew = b0*nempshare/(1-nempshare);

disttau = abs(tau-taunew)*2/(tau+taunew)

if taunew>tau
tau = (1-tauupdate)*tau + tauupdate*taunew;
else
tau = taunew;
end
itertau = itertau+1

end;
%}



%% IMPORTANT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{ 
In this version I update the model to incorporate for the fact that the
banks gain information about the riskiness of the entrepreneurs by the
amount they borrow. One additional thing is that the banks cannot produce
infinite contracts so they will bunch entrepreneurs with similar default
risks into one group, there will be a finite number of groups, thus pooling
%}

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
betta    = 0.94;
sigma    = 2; % Risk aversion coefficient, log utility if 1

% Job destruction and job NOT finding parameters
lambda = 0.2;
mu     = 0.3;

% Production Parameters
deltta   = 0.06;
alfa     = 0.3;
nu       = 0.84;
gama     = nu - alfa;

% Distribution Parameters
ZDist    = 1; % Pareto, if 1. Normal if 2
etta     = 7.3;
sigz     = 1;

PSI      = 0.10; % The probability of changing the talent, then will be randomly drawn from z

ettakap  = 0.1; % Two parameters that will be useful for the disutility from work
sigkap   = 2;

% The Default Parameters
mueps    = [0.8 0.15 0.05]; % if neps =1 mueps - probability, sigeps - value in function
sigeps   = [0 0.9 8];

EPSdist  = 1; % 1 if normal distributed
KAPdist  = 1;
kmethod  = 1.5; % Method with how to create the capital grid, 0 linear, 1 exponential
xi       = 0.35; % Exemption level

% Grid Parameters
amin    = 0.1;
amax    = 350;
na      = 130;
nap     = 400;
nz      = 50;
nkap    = 7;
ne      = 3; % The number of occupations
neps    = 3;
nr      = 1; % Number of interest rates a self-emp can face
nk      = 400; % The number of capital grid



% The Grids
Amethod   = 1; % 1 if linear, 2 if logarithmic
agrid    = adist(amin,amax,na,Amethod);
apgrid   = adist(amin,amax,nap,Amethod);

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
w0       = 1.2157;
r0       = ones(nr,nk).*r_bar; % Now For each signal and amount there is a borrowing rate
b0       = 0.15;
tau      =  [0.001];
tauinit  = tau;
r0init   = r0;
%--------------------------------------------------------------------------
% Probabilities of facing a given borrowing rate

if nr == 1 
    Pr =1;
else

Pr(1,:) = linspace(0.1,0.9,nz);
Pr(2,:) = linspace(0.4,0.05,nz);
Pr(3,:) = linspace(0.5,0.05,nz);

Pr./repmat(sum(Pr,1),nr,1);
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% The Stationary Distribution Parameters
NN = 1e5;
TT = 300;

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
nnn          = na*nr*neps;
nstate       = nz*na*nkap;
kap_array    = repmat(reshape(kapgrid,1,1,nkap),nz,na,1);
a_array      = repmat(agrid,nz,1,nkap);
z_array      = repmat(zgrid,1,na,nkap);
z_arrayint   = repmat(zgrid,1,nnn,nkap);
kap_arrayint = repmat(reshape(kapgrid,1,1,nkap),nz,nnn,1);
TS           = zeros(nz,nnn,nkap);

znarray      = repmat(zgrid,1,nap,nkap);
kapnarray    = repmat(reshape(kapgrid,1,1,nkap),nz,nap,1);
anarray      = repmat(apgrid,nz,1,nkap);

if nr == 1
    Pr_int = 1;
else
Pr_int       = repmat(reshape(Pr',nz,1,nr),1,na,1,1,nkap);
end;
Peps_int     = repmat(reshape(P,1,1,1,neps,1),nz,na,nr,1,nkap);
%--------------------------------------------------------------------------
% The Stationary Distribution of Talents

StatesforStatDist;

%--------------------------------------------------------------------------
LFLAG    = 0;

%% Capital and Government Tax Loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% The Labor Loop starts here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Labor Market Loop Matrices ----------------------------------------------

distL    = 100;
tolL     = 0.0055;
maxiterL = 25;
iterL    = 1;
stugL    = zeros(maxiterL,4);
wmax     = 1.3;
mflagL    = 1;
wtol      = 100;
wtolmax   = 1e-7;
tolaux   = 1e-5;
% Capflag = 0 means that profits will be calcualted in profitcalc and not
% the capital demand
Capflag = 0;
%--------------------------------------------------------------------------
clear funcdistL
FLAGUNCLEARL = 0;
%--------------------------------------------------------------------------
% The Capital grid: New Addition, each firm chooses the amount that
% maximizes its profit, but the capital choice is not continuous.

kgrid = kdist(nk,sigz,etta,r0,w0,kmethod);

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
qupdate  = 0.025;
rupdate  = 0.025;
iterR    = 1;
tolR     = 2.5e-2;
tolq     = 2.5e-2;
distR    = 150;
maxiterR = 200;
tolupr   = 0.015;
lastresortflag = 0;

if iterL>1
    if abs(w0 - wold)*2/(w0+wold)>tolupr
r0       = 0.04*ones(1,nk);
    end
end

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

X     = profitcalc2(zgrid,agrid,kgrid,r0,w0);
%--------------------------------------------------------------------------
businc   = X(:,:,:,1);
indhire  = X(:,:,:,2); % Index indicating whether the individual hires or not
clear X

% The Shock and after-shock businc - busincP. I here allow for
% heterogeneity in shocks, meaning that neps>1 is possible

X = aftershockinc(businc, epsilon, P,neps,Capflag); % X(nz x na x nr x neps) 
busincP = X; 
clear X

consw = zeros(nz,na,nap);
consu = zeros(nz,na,nap);
conss = zeros(nz,na,nap);

consw = w0 + (1 + r_bar) * repmat(agrid,1,1,nap) - repmat(reshape(apgrid,1 ...
,1,nap),1,na,1) - tau;

consu = b0 + (1 + r_bar) * repmat(agrid,1,1,nap) - repmat(reshape(apgrid,1 ...
,1,nap),1,na,1);

% Need to choose a benchmark for the value function iteration. The strategy
% is to calculate the optimal cons and saving for a given asset level and
% given shock and borrowing rate, conditional on managerial talent, and
% then interpolate the "Cash-on-hand" after the shock and get saving and
% consumption choice for other shock and borrowing rate combinations.

% The argument is: given z, having asset a1, and facing eps1 r1 is
% equivalent to having asset a2 and facing eps2, r2 as long as
% pi(z,a1,eps1,r1) = pi(z,a2,eps2,r2) in terms of consumption and
% investment choice.

conssB = repmat(busincP(:,:,bnr,bneps),1,1,nap) - ...
    repmat(reshape(apgrid,1,1,nap),nz,na,1)  - tau;

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
W  = repmat((w0 + agrid*(1+r_bar)).^(1-sigma)/(1-sigma)/(1-betta),nz,1,nkap);
N  = repmat((b0 + agrid*(1+r_bar)).^(1-sigma)/(1-sigma)/(1-betta),nz,1,nkap);
S  = repmat(businc(:,:,1),1,1,nkap).^(1-sigma)/(1-sigma)/(1-betta);
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

Uwk = reshape(permute(Uwk,[2 1 4 3]),nz*na*nkap,nap)';
Uuk = reshape(permute(Uuk,[2 1 4 3]),nz*na*nkap,nap)';
UsBk =reshape(permute(UsBk,[2 1 4 3]),nz*na*nkap,nap)';

while iter_v<maxiter_v && dist_v>tol_v

Vw = max(W,max(ES,N));
Vu = max(ES,N);

% Can't multiply 3d matrices that's why I first reshape Vw(nz,na,nkap) to
% Vw(nz,na*nkap) then calculate the expected values wrt z, then reshape
% back to EVw(1,na,nkap) and then repmat to EVw(nz,na,nkap) 


EVw = (1-PSI) * Vw + PSI * repmat(reshape(ones(1,nz)*reshape(Vw,nz,na...
    *nkap)/nz,1,na,nkap),nz,1,1);
EVu = (1-PSI) * Vu + PSI * repmat(reshape(ones(1,nz)*reshape(Vu,nz,na...
    *nkap)/nz,1,na,nkap),nz,1,1);

if nap~=na
FEVw = griddedInterpolant(z_array,a_array,kap_array,EVw);
FEVu = griddedInterpolant(z_array,a_array,kap_array,EVu);

EVw = FEVw(znarray,anarray,kapnarray);
EVu = FEVu(znarray,anarray,kapnarray);
end


iminW = ones(nstate,1);
imaxW = ones(nstate,1)*nap;
ilowW = ones(nstate,1)*floor(nap/2);
iupW  = ilowW+1;

iminS = ones(nstate,1);
imaxS = ones(nstate,1)*nap;
ilowS = ones(nstate,1)*floor(nap/2);
iupS  = ilowS+1;

iminN = ones(nstate,1);
imaxN = ones(nstate,1)*nap;
ilowN = ones(nstate,1)*floor(nap/2);
iupN  = ilowN+1;


VWT = permute(betta*((1 - lambda) * EVw + lambda *EVu),[2 1 3]);
VNT = permute(betta*((1 - mu) * EVw + mu *EVu),[2 1 3]);

indU = ([1:nstate]'-1)*nap;
indV = repmat(([1:nz*nkap]-1)*nap,na,1);
indV = indV(:);

while max(imaxW-iminW)>1
ilowW = ones(nstate,1).*floor((iminW+imaxW)/2);
iupW  = ilowW+1;
iupW(iupW>nap)=nap;

Wlow = Uwk(indU+ilowW) + VWT(indV+ilowW);
Wup  = Uwk(indU+iupW) + VWT(indV+iupW);

iminW(Wlow<=Wup & Wlow>-70) = iupW(Wlow<=Wup & Wlow>-70);
imaxW(Wlow>Wup) = ilowW(Wlow>Wup);

imaxW(Wlow<-70) = max(floor(ilowW(Wlow<-70)),1);

ilowN = ones(nstate,1).*floor((iminN+imaxN)/2);
iupN  = ilowN+1;
iupN(iupN>nap)=nap;

Nlow = Uuk(indU+ilowN) + VNT(indV+ilowN);
Nup  = Uuk(indU+iupN) + VNT(indV+iupN);

iminN(Nlow<=Nup & Nlow>-70) = iupN(Nlow<=Nup & Nlow>-70);
imaxN(Nlow>Nup) = ilowN(Nlow>Nup);

imaxN(Nlow<-70) = max(floor(ilowN(Nlow<-70)),1);


ilowS = ones(nstate,1).*floor((iminS+imaxS)/2);
iupS  = ilowS+1;
iupS(iupS>nap)=nap;

Slow = UsBk(indU+ilowS) + VNT(indV+ilowS);
Sup  = UsBk(indU+iupS) + VNT(indV+iupS);

iminS(Slow<=Sup & Slow>-70) = iupS(Slow<=Sup & Slow>-70);
imaxS(Slow>Sup) = ilowS(Slow>Sup);

imaxS(Slow<-70) = max(floor(ilowS(Slow<-70)),1);

end


Wmin = Uwk(indU+iminW) + VWT(indV+iminW);
Wmax = Uwk(indU+imaxW) + VWT(indV+imaxW);
Nmin = Uuk(indU+iminN) + VNT(indV+iminN);
Nmax = Uuk(indU+imaxN) + VNT(indV+imaxN);
Smin = UsBk(indU+iminS) + VNT(indV+iminS);
Smax = UsBk(indU+imaxS) + VNT(indV+imaxS);

W = reshape(max(Wmin,Wmax),na,nz,nkap);
N = reshape(max(Nmin,Nmax),na,nz,nkap);
S = reshape(max(Smin,Smax),na,nz,nkap);



W = permute(W,[2 1 3]);
N = permute(N,[2 1 3]);
S = permute(S,[2 1 3]);


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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IW    = imaxW.*(Wmax>=Wmin) + iminW.*(Wmax<Wmin);
IW    = permute(reshape(IW,na,nz,nkap),[2 1 3]);

IN    = imaxN.*(Nmax>=Nmin) + iminN.*(Nmax<Nmin);
IN    = permute(reshape(IN,na,nz,nkap),[2 1 3]);

IS    = imaxS.*(Smax>=Smin) + iminS.*(Smax<Smin);
IS    = permute(reshape(IS,na,nz,nkap),[2 1 3]);

%% Stationary Distribution
%--------------------------------------------------------------------------
if CONTSTATDIST == 0 
StatdistVFI;
else
StatdistVFIapcont;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save the current capital price

qold = 1./(r0+1);
%{%}
% Initialize the new capital price for calculating the equilibrium price at
% the given stationary distribution
X = KLMCMC(BIGZ(OCC==3),BIGA(OCC==3),kgrid,r0,w0,1);

LD       = X(:,:,1);
occindex = X(:,:,2); % occindex=1 if chooses to hire
KDindex  = X(:,:,3);
income   = X(:,:,4);
KD       = X(:,:,5);

clear X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LabMarket;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

KMarket;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distq = max(max(abs(diffK)));

if distq>tolq
q0   = (1-qupdate).*q0 + qupdate.*(qnew);
end
r0 = 1./q0 -1;


 


distR           = distq;
checkR(:,iterR) = diffK; 
checkQ(:,iterR) = qold;


iterR         = iterR + 1
distR

if iterR>=maxiterR-1 && lastresortflag == 0
    lastresortD = max(checkR(:,1:iterR-1));
    lastresortI = find(lastresortD == min(lastresortD));
    q0          = checkQ(:,lastresortI);
    r0          = 1./q0' - 1;
    iterR       = maxiterR - 1;
    lastresortflag = 1;
end

%{
% r0 = 0.04*ones(1,nk);
checkq = zeros(20,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ll = 1:20
    
X = KLMCMC(BIGZ(OCC==3),BIGA(OCC==3),kgrid,r0,w0,1);

LD       = X(:,:,1);
occindex = X(:,:,2); % occindex=1 if chooses to hire
KDindex  = X(:,:,3);
income   = X(:,:,4);
KD       = X(:,:,5);

clear X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LabMarket;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

KMarket;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

q0   = (1-qupdate).*q0 + qupdate.*(qnew);


r0 = 1./q0 -1;
%{
distq = max(max(abs(diffK)));

 checkq(ll) = distq;

if distq < tolq;

    break;
    
elseif ll>500 && distq<min(checkq(checkq>0))*1.1
    
    break;
        
end
%}
end

% distTEMP      = abs(q0-qold)*2./(q0+qold);

%distR         = max(distTEMP);

distR           = max(max(abs(diffK)));
checkR(:,iterR) = distR; 

% q0            = rupdate*q0 + (1-rupdate)*qold;
% r0            = 1./q0 - 1;

iterR         = iterR + 1
distR       
%}
end;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
funcdistL(iterL,:) = [(LS-LD)/((LD+LS)/2) w0];

if iterL==2 && sign(funcdistL(iterL,1)) == sign(funcdistL(iterL-1,1))
    if  sign(funcdistL(iterL,1))== -1;
        wmax  = wmax*1.05;
        iterL = iterL - 1;
    elseif sign(funcdistL(iterL,1))== 1;
        wmax  = wmax*0.95;
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


end;

clear Atilde ATILDE anarray a_array biga bige bigeprobs bigz conss ...
    EAS ES ES0 ESold EVu EVw FAPN FAPS FAPW FEMP FEVu FEVw FN FNEMP FW ...
    ilowN ilowS ilowW lmaxN imaxS imaxW iminN iminS iminW IN INDEX ...
    indU indV IS iupN iupS iupW IW kap_array kap_arrayint kapnarray N ...
    N0 Nlow Nmax Nmin Nold Nup occ OCCINDEMP occindex OCCINDNEMP Peps_int ...
    S S0 Slow Smax Smin Sold Sup TEMPN TEMPOCC TEMPS TEMPW TW UsBk Uuk ...
    Uwk VNT Vu Vu0 Vuold VWT W W0 Wlow Wmax Wmin Wold WORKINDEX Wup X ...
    z_array z_arrayint znarray

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Concentrate only on r0 as it is clearing the market and not rnew!

% FLAGUNCLEARL is a flag that if equal to 1 indicates that the labor market
% hasn't cleared, so then I find the wage that created lowest dist(LD,LS)
% and run the model under that wage

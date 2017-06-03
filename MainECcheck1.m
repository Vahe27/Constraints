clear all
Vflag = 2; % 2 loads the Vfuns from other simulations as starting values, 
% 1 doesn't make sense in here at the code will give an error, 0 uses zeros
% as initial values for the Vfun iteration.
tic
rng(1)
%% Parameters

global alfa Gama xi epsilon P neps na nz nkap r_bar nr kapgrid nnn betta lambda 
global nu mu b0 PSI Peps_int Pr_int NN TT deltta gama sigma nA Pr


% Environment and Preference Parameters Parameters
r_bar    = 0.04;
betta    = 0.95;
sigma    = 2; % Risk aversion coefficient, log utility if 1

% Unemployment tax and benefit
tau        = 0.05;

% Job destruction and job NOT finding parameters
lambda = 0.05;
mu     = 0.1;

% Production Parameters
deltta   = 0.06;
alfa     = 0.28;
nu       = 0.85;
gama     = nu - alfa;

% Distribution Parameters
ZDist    = 1; % Pareto, if 1. Normal if 2
etta     = 6.7;
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
amax    = 200;
na      = 120;
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
w0       = 0.56;
r0       = [0.04 0.05 0.055];
b0       = 0.1;

% Probabilities of facing a given borrowing rate
Pr = rand(nr,nz);
Pr = Pr./repmat(sum(Pr,1),nr,1);

%--------------------------------------------------------------------------
% The Stationary Distribution Parameters
NN = 7e4;
TT = 500;

nA = 500;

Agrid = adist(amin,amax,nA,Amethod);
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

bigz   = zstatdist([1:nz]', nz,PSI,NN,TT); 
bigkap = randsample([1:nkap]',NN,1,Pkap);

bigeprobs   = rand(NN,TT);
bigeprobs(bigeprobs(:,1)>0.5,1) = 1;
bigeprobs(bigeprobs(:,1)<=0.5,1) = 0;

bigeprobs(:,1) = bigeprobs(:,1)+1;

biga = [randsample([1:nA/2],NN,1)',zeros(NN,TT-1)];

occ  = zeros(NN,TT);
%--------------------------------------------------------------------------
%% The Labor Loop starts here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Labor Market Loop Matrices ----------------------------------------------
distL    = 100;
tolL     = 1e-3+1e-16;
maxiterL = 20;
iterL    = 1;
stugL    = zeros(maxiterL,3);
wmax     = 1.4;
wmin     = 0.5;
mflagL    = 1;
wtol      = 100;
wtolmax   = 1e-7;
tolaux   = 1e-5;
% Capflag = 0 means that profits will be calcualted in profitcalc and not
% the capital demand
Capflag = 0;
%--------------------------------------------------------------------------
%{
while distL>tolL && iterL<maxiterL && wtol > wtolmax
    
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
%}
%--------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
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

disp('Iter, Labor Distance, wage rate, time ')
xx=toc;
disp([iterL [] distL [] w0 [] xx])
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CapMarket;

nempshare = sum(OCC==1)/NN;
%}
f = @(w0) chechfun(w0,r0,zgrid,agrid,Agrid,Capflag,bnr, bneps, tau,...
    z_array,a_array,kap_array,z_arrayint,kap_arrayint,Vflag,bigeprobs,...
    bigkap,bigz,biga);
options = optimoptions('fsolve','Display','iter',...
    'MaxFunctionEvaluations',100);

fsolve(f,0.7,options)
toc



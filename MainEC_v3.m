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
sigma    = 1; % Risk aversion coefficient, log utility if 1

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

psi      = 0.15; % The probability of changing the talent, then will be randomly drawn from z

ettakap  = 0.05; % Two parameters that will be useful for the disutility from work
sigkap   = 5;

% The Default Parameters
mueps    = [0.8 0.1 0.1]; % if neps =1 mueps - probability, sigeps - value in function
sigeps   = [0 5 10];

EPSdist  = 1; % 1 if normal distributed
KAPdist  = 1;

xi       = 0.2; % Exemption level

% Grid Parameters
amin    = 0.1;
amax    = 100;
na      = 70;
nz      = 100;
nkap    = 10;
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
Pkap     = X(1,1); 
kapgrid  = X(:,2);
clear X

% Stationary Distribution Parameters
N  = 30000;
T  = 500;

% Initial Values of the variables
w0       = 0.9;
r0       = [0.04 0.05 0.06];
b0       = 0.3;

%--------------------------------------------------------------------------
% The Stationary Distribution Parameters
NN = 3e4;
TT = 250;

nA = 400;

Agrid = adist(amin,amax,nA,Amethod);
%--------------------------------------------------------------------------

% Auxilliary Parameters

Gama = (gama^gama)/((1+gama)^(1+gama));

estatdum = [(rand(NN,1)>0.2) rand(NN,T-1)];

% As a benchmark for approximation, I choose highest shock, eps=eps_max and
% low borrowing rate r_min>r_bar

bnr   = 1;
bneps = 3;
%--------------------------------------------------------------------------
% The Stationary Distribution of Talents

bigz = zstatdist(zgrid, nz,psi,NN,TT); 

%% The Consumption matrices
%--------------------------------------------------------------------------

% Here businc are as in the notes, they include both business profits and
% income from depositing left-over assets, doesn't include taxes 

X = profitcalc(zgrid,agrid,r0,w0);
businc = X(:,:,:,1);
indhire = X(:,:,:,2); % Index indicating whether the individual hires or not
clear X

% The Shock and after-shock businc - busincP. I here allow for
% heterogeneity in shocks, meaning that neps>1 is possible

X = aftershockinc(businc, epsilon, neps); % X(nz x na x nr x neps) 
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
%% Value Function Iteration
% --------------------Value Funcion Interation-----------------------------

if Vflag == 0
Vu = zeros(nz,na,nkap);
Vw = Vu+0.25;
W  = log((1-betta)*w0)/((1-betta)*(1-lambda))*ones(nz,na,nkap);
N  = log((1-betta)*b0)/((1-betta)*(1-mu))*ones(nz,na,nkap);
S  = log((1-betta)*w0)/((1-betta)*(1-mu))*ones(nz,na,nkap);

Vu0 = zeros(nz,na,nkap);
Vw0 = Vu0 + 0.25;
W0  = Vw0 + 0.25;
N0  = W0 + 0.25;
S0  = N0 + 0.25;

elseif Vflag == 1
    
Vw0 = Vwold;
Vu0 = Vuold;
W0  = Wold;
N0  = Nold;
S0  = Sold;

elseif Vflag == 2
    
load('ValFun')

W0 = W;
N0 = N;
S0 = S;

end

%%%%%%%%%%NEED TO CONTINUE HERE IF FAIL WITH THE OTHER OPTION%%%%%%%%%%%%%%

maxiter_v = 200;
iter_v  = 1;
tol_v   = 1e-6;
dist_v  = 500;
tic
while iter_v<maxiter_v && dist_v>tol_v

Vw = max(W0,max(S0,N0));
Vu = max(S0,N0);

% Can't multiply 3d matrices that's why I first reshape Vw(nz,na,nkap) to
% Vw(nz,na*nkap) then calculate the expected values wrt z, then reshape
% back to EVw(1,na,nkap) and then repmat to EVw(nz,na,nkap) 


EVw = (1-psi) * Vw + psi * repmat(reshape(ones(1,nz)*reshape(Vw,nz,na...
    *nkap)/nz,1,na,nkap),nz,1,1);
EVu = (1-psi) * Vu + psi * repmat(reshape(ones(1,nz)*reshape(Vu,nz,na...
    *nkap)/nz,1,na,nkap),nz,1,1);


[W IW] = max(Uwk + repmat(reshape(betta * ((1 - lambda) * EVw + lambda *...
    EVu),nz,1,na,nkap),1,na,1,1),[],3);
W = reshape(W,nz,na,nkap);

[N IN] = max(Uuk + repmat(reshape(betta * ((1 - mu) * EVw + mu * ...
    EVu),nz,1,na,nkap),1,na,1,1),[],3);
N = reshape(N,nz,na,nkap);

[S IS] = max(UsBk + repmat(reshape(betta * ((1 - mu) * EVw + mu * ...
    EVu),nz,1,na,nkap),1,na,1,1),[],3);
S = reshape(S,nz,na,nkap);




%{   
 for ii = 1:nkap
 [S(:,:,ii) IS(:,:,ii)] = max(Usk(:,:,:,ii) + repmat(reshape(betta * ((1 - mu) * EVw(:,:,ii) + mu * ...
     EVu(:,:,ii)),nz,1,na),1,na,1),[],3);

[W(:,:,ii) IW(:,:,ii)] = max(Uwk(:,:,:,ii) + repmat(reshape(betta * ((1 - lambda) * EVw(:,:,ii) + lambda * ...
     EVu(:,:,ii)),nz,1,na),1,na,1),[],3);

[N(:,:,ii) IN(:,:,ii)] = max(Uuk(:,:,:,ii) + repmat(reshape(betta * ((1 - mu) * EVw(:,:,ii) + mu * ...
     EVu(:,:,ii)),nz,1,na),1,na,1),[],3);
 end

 
W = reshape(W,nz,na,nkap);
N = reshape(N,nz,na,nkap);
S = reshape(S,nz,na,nkap);
%}

distVW = max(max(max(abs(W0 - W))));
distVN = max(max(max(abs(N0 - N))));
distVS = max(max(max(abs(S0 - S))));

dist_v = max(distVW,max(distVN,distVS));

W0 = W;
N0 = N;
S0 = S;

iter_v = iter_v + 1;

end;
toc

clear Vb0 Vs0 Vw0 Vtemp EVtemp Vbtemp EVbtemp Temp1 Temp2 EV EVb

if Vflag == 2
    save('ValFun','S','N','W','Vw','Vu');
end;

Vflag = 1;
Nold  = N;
Sold  = S;
Wold  = W;
Vuold = Vu;
Vwold = Vw;

work  = W >= max(S,N);
semp  = S > max(W,N);
unemp = N > max(W,S);


%%---------------------------Stationary Distribution-----------------------







% The occupational choice is static, so in any period those with given
% (z,a) will choose either to work, or to start a self-employment or become
% an employer.

semp = swch_ws - swch_wb - swch_sb;
semp(semp<1) = 0;
bemp = swch_wb + swch_sb;
bemp(bemp>1) = 1;
work = ones(n_z,n_a) - semp - bemp;
% Those who switch back from an employer to self employed or employee
bback = abs(swch_bb-1);


% Simulate N people over T periods and look at the last period distribution



bigz   = zeros(N,T);
bigz(:,2:end) = rand(N,T-1);
bigz(bigz<1-psi) = 0;
bigz(bigz>=1-psi) = 1;
bigz(:,1) = randsample([1:n_z]',N,1);

biga      = zeros(N,T);
biga(:,1) = agrid(1); %randsample(agrid,N,1);

bige      = zeros(N,T);


for t = 2:T
    Temp1 = bigz(:,t);
    Temp2 = bigz(:,t-1);
    Temp3 = randsample([1:n_z]',sum(Temp1),1);
    Temp1(bigz(:,t)==0) = Temp2(bigz(:,t)==0);
    Temp1(bigz(:,t)==1) = Temp3;
    bigz(:,t) = Temp1;
end;

clear Temp1 Temp2 Temp3

%---------------------------For the Stat Distribution----------------------
% Some auxilliary matrices needed for later calculations
iz = [1:n_z]';
ie = 5*[1:n_e];


gsemp = gsemp(:,:,1) .* (1 - swch_sb) + gsemp(:,:,2) .* swch_sb;
gbemp = gbemp(:,:,1) .* (1 - swch_bb) + gbemp(:,:,2) .* swch_bb;
gwork = gwork(:,:,1) .* (1 - swch_wb) + gwork(:,:,2) .* swch_wb;

indv  = cat(3,gwork,gsemp,gbemp);
iV    = agrid(indv);
%--------------------------------------------------------------------------

%% The Loop

for t = 1:T

[CC pos(:,1)] = min(abs(repmat(biga(:,t),1,n_a)-repmat(agrid,N,1)),[],2);

pos(agrid(pos)' - biga(:,t)<0) = pos(agrid(pos)' - biga(:,t)<0) + 1; 
pos(pos==1)   = 2;
pos(:,2)      = pos;
pos(:,1)      = pos(:,2)-1;

% I want to interpolate the occupations in the following way: If an
% individual's asset lies between (0,0) or (1,1) meaning no occupational or
% definite change, move on, if (0,1) or (1,0) check to which value it is
% closer, if closer to the lower value (e.g. pos_wght<0.5) then choose 0
% (or 1 in the latter case) and if closer to the higher value, choose 1 (or
% 0 in the lower case)

pos_wght  = (biga(:,t) - agrid(pos(:,1))')./(agrid(pos(:,2))' - agrid(pos(:,1))');

temp_work = work(n_z*(pos(:,1)-1)+bigz(:,t)) + work(n_z*(pos(:,2)-1)+bigz(:,t));
temp_semp = semp(n_z*(pos(:,1)-1)+bigz(:,t)) + semp(n_z*(pos(:,2)-1)+bigz(:,t));
temp_bemp = bemp(n_z*(pos(:,1)-1)+bigz(:,t)) + bemp(n_z*(pos(:,2)-1)+bigz(:,t));

Temp1 = zeros(N,1);

Temp1(temp_work==2 | (work(n_z*(pos(:,2)-1)+bigz(:,t))==1 & pos_wght>=0.5)...
   | (work(n_z*(pos(:,1)-1)+bigz(:,t))==1 & pos_wght<0.5)) = 5;
Temp1(temp_semp==2 | (semp(n_z*(pos(:,2)-1)+bigz(:,t))==1 & pos_wght>=0.5)...
   | (semp(n_z*(pos(:,1)-1)+bigz(:,t))==1 & pos_wght<0.5)) = 10;
Temp1(temp_bemp==2 | (bemp(n_z*(pos(:,2)-1)+bigz(:,t))==1 & pos_wght>=0.5)...
   | (bemp(n_z*(pos(:,1)-1)+bigz(:,t))==1 & pos_wght<0.5)) = 15;

bige(:,t) = Temp1;
clear Temp1 

if t>1
    
    % Here I check whether the individual is an employer or not, if yes, he
    % doesn't have to pay kappa, so his occupational choice changes
    % relative to the previous calculation, and depends on the previous
    % state of e
    
Temp1     = bige(:,t);
temp_keep =  swch_bb(n_z*(pos(:,1)-1)+bigz(:,t)) + swch_bb(n_z*(pos(:,1)-1)+bigz(:,t));

Temp1(bige(:,t-1)==15 & (temp_keep==2 | (swch_bb(n_z*(pos(:,2)-1)...
    + bigz(:,t))==1 & pos_wght>=0.5) | (swch_bb(n_z*(pos(:,1)-1)+bigz(:,t))...
    ==1 & pos_wght<0.5))) = 15;

bige(bige(:,t-1)==15,t) = Temp1(bige(:,t-1)==15);

end




biga(:,t+1) = interpn(iz,agrid,ie,iV,bigz(:,t),biga(:,t),bige(:,t));
clear pos
end
toc



%---------------------------Labor Demand-----------------------------------

employer = (bige(:,end)==15);
zemp     = employer.*z(bigz(:,end));

lemp = zemp.^(1/(1-nu)) * ((1+r_bar)/alfa)^(alfa/(nu-1)) * (w/betta)^((1-alfa)/(nu-1));
LD = sum(lemp)/N;



disp('share employer')
sum(bige(:,end)==15)/N


disp('share self employed')
sum(bige(:,end)==10)/N

disp('Labor Demand')
LD

histogram(bige(:,end))

% bige = bige(:,end);
% biga = biga(:,end);

toc































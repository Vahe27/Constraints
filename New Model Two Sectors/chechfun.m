function y = chechfun(w0,r0,zgrid,agrid,Agrid,Capflag,bnr, bneps, tau,...
    z_array,a_array,kap_array,z_arrayint,kap_arrayint,Vflag,bigeprobs,...
    bigkap,bigz,biga)

global epsilon P neps na nz nA nkap r_bar nr kapgrid nnn betta lambda mu b0 PSI 
global Peps_int Pr_int NN TT deltta alfa nu gama sigma Pr

kapgrid(1)=0;

%% The Consumption matrices
%--------------------------------------------------------------------------

% Here businc are as in the notes, they include both business profits and
% income from depositing left-over assets, doesn't include taxes 
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

%--------------------------------------------------------------------------

StatdistVFI;

LabMarket;
LD 
LS
y = 2*(LD-LS)/(LD+LS);
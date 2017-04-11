clear all
tic
rng(1)
%% Parameters

% Environment and Preference Parameters Parameters
r_bar    = 0.04;
betta    = 0.94;
sigma    = 1; % Risk aversion coefficient, log utility if 1

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
ettakap  = 0.01; % Two parameters that will be useful for the disutility from work
sigkap   = 5;

% The Default Parameters
mueps    = 0; % if neps =1 mueps - probability, sigeps - value in function
sigeps   = 1;
neps     = 100;
EPSdist  = 1; % 1 if normal distributed
KAPdist  = 1;
xi       = 0.2; % Exemption level


% Grid Parameters
amin     = 0.1;
amax     = 100;
na      = 250;
nz      = 250;
nkap    = 100;
ne      = 3; % The number of occupations

% The Grids
Amethod   = 1; % 1 if linear, 2 if logarithmic

agrid    = adist(amin,amax,na,Amethod);

X        = prodshock(mueps,sigeps,neps,EPSdist); % P and epsilon can also be vectors with size neps
P        = X(1,1);
epsilon  = X(:,2);
clear X

X        = zdist(etta,sigz,nz,ZDist);
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
w        = 0.9;
r        = 0.04;
b        = 0.4;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------

% First calculate the optimal capital for each talent z, given interest
% rate r_bar, next, those with optimal capital more than their assets, will
% borrow, find them and find how much they will borrow and calcualte profit
capital = (gama^gama/((1+gama)^(1+gama)))^(1/(1-alfa))*((r_bar+deltta)/alfa)...
    ^(1/(alfa-1)).*z.^(1/(1-alfa));

capital = repmat(capital,1,n_a);

invest_semp(:,:,1) = ((deltta+r)/alfa)^(1/(alfa-1)) * (((1+gama)^(1+gama))/...
  (gama^gama))^(1/(alfa-1))*repmat(z.^(1/(1-alfa)),1,n_a);
invest_semp(:,:,2) = (repmat(agrid,n_z,1)>=capital).*capital; 

% There are three types of agents: first are those who have enough capital
% under rbar, so they will never borrow even if r=rbar, second are those
% who'd borrow under rbar but won't under r, then they will operate firms
% with no borrowing x=0, lastly, those who'd borrow under r (x>0). The
% borrowing choices of the first 2 types are given in invest_semp(:,:,2)
% and the borrowing choices of the 3rd group are given in
% invest_semp(:,:,1). The idea is that for the second group MPK(x+a)>rbar
% but MPK(x+a)<r

invest_semp(:,:,1) = (repmat(agrid,n_z,1)<invest_semp(:,:,1)).*invest_semp(:,:,1);
invest_semp(:,:,2) = invest_semp(:,:,2) + (invest_semp(:,:,1)==0).*...
    (invest_semp(:,:,2)==0).*repmat(agrid,n_z,1);

profit_semp(:,:,1) = gama^gama/((1+gama)^(1+gama)).*repmat(z,1,n_a).*...
    invest_semp(:,:,1).^alfa - (r+deltta).*(invest_semp(:,:,1)-repmat(agrid,n_z,1))...
    + repmat(agrid*(1-deltta),n_z,1);

profit_semp(:,:,1) = profit_semp(:,:,1).*(invest_semp(:,:,1)>0);

profit_semp(:,:,2) = gama^gama/((1+gama)^(1+gama)).*repmat(z,1,n_a).*...
    invest_semp(:,:,2).^alfa + (1-deltta)*invest_semp(:,:,2) - (1+r_bar)...
    *(invest_semp(:,:,2) - repmat(agrid,n_z,1)); 

profit_semp(:,:,2) = profit_semp(:,:,2).*(invest_semp(:,:,2)>0);

inc_semp = profit_semp(:,:,1) + profit_semp(:,:,2);


profit_bus = z.^(1/(1-nu)) * (1-nu) * ((deltta+r_bar)/alfa)^((nu)/(nu-1)) * ...
    (alfa*w/(gama*(deltta+r_bar)))^(gama/(nu-1));

inc_bus = repmat(profit_bus,1,n_a) + repmat(agrid*(1+r_bar),n_z,1);



cons_w =(repmat(agrid*(1+r_bar),n_z,1,n_a)+ w - repmat(reshape(agrid,1,1,n_a),n_z,n_a,1));
Uw     = log(cons_w);
Uwp    = log(cons_w-kappa);
Uw(cons_w<0)        = -100;
Uwp(cons_w-kappa<0) = -100;
%clear cons_w
cons_s = repmat(inc_semp,1,1,n_a) - repmat(reshape(agrid,1,1,n_a),n_z,n_a,1);
Us     = log(cons_s);
Usp    = log(cons_s-kappa);
Usp(cons_s-kappa<0) = -100;
Us(cons_s<0)        = -100;
%clear cons_s
cons_b = repmat(inc_bus,1,1,n_a) - repmat(reshape(agrid,1,1,n_a),n_z,n_a,1);
Ub     = log(cons_b);
Ub(cons_b<0) = -100;
%clear cons_b
% --------------------Value Funcion Interation-----------------------------

V = zeros(n_z,n_a);
Vw = V+0.25;
Vs = Vw+0.25;
Vb = Vs+0.25;
V0 = zeros(n_z,n_a);
Vw0 = V0+0.25;
Vs0 = Vw0+0.25;
Vb0 = Vs0+0.25;

maxiter_v = 1000;
iter_v  = 1;
tol_v   = 1e-5;
dist_v  = 500;

while iter_v<maxiter_v && dist_v>tol_v

V0 = max(Vw0,Vs0);
swch_ws = Vw0<=Vs0;
% The expected values of the value function for the employer (b) and for
% the non-employer (*) I calculate the simple means because each value of z
% has the same probability to realize (as Tim suggested, equal weights)
EVb     = (ones(1,n_z) *Vb0 ./n_z);
EV      = ones(1,n_z) * V0 ./n_z;

Vtemp   = repmat(reshape(V0,n_z,1,n_a),1,n_a,1);
EVtemp  = repmat(reshape(EV,1,1,n_a),n_z,n_a,1);
Vbtemp  = repmat(reshape(Vb0,n_z,1,n_a),1,n_a,1);
EVbtemp = repmat(reshape(EVb,1,1,n_a),n_z,n_a,1);

[Temp1(:,:,1),gsemp(:,:,1)] = max(Us + betta*( (1-psi)*Vtemp + psi*EVtemp),[],3);
[Temp1(:,:,2),gsemp(:,:,2)] = max(Usp + betta*((1-psi)*Vbtemp + psi*EVbtemp),[],3);
Vs = max(Temp1(:,:,1),Temp1(:,:,2));
swch_sb = Temp1(:,:,1)<=Temp1(:,:,2);

[Temp1(:,:,1),gbemp(:,:,1)] = max(Ub + betta* ((1-psi)*Vtemp + psi*EVtemp),[],3);
[Temp1(:,:,2),gbemp(:,:,2)] = max(Ub + betta* ((1-psi)*Vbtemp + psi*EVbtemp),[],3);
Vb = max(Temp1(:,:,1),Temp1(:,:,2));
swch_bb = Temp1(:,:,1)<=Temp1(:,:,2);

[Temp1(:,:,1),gwork(:,:,1)] = max(Uw + betta* ((1-psi)*Vtemp + psi*EVtemp),[],3);
[Temp1(:,:,2),gwork(:,:,2)] = max(Uwp + betta* ((1-psi)*Vbtemp + psi*EVbtemp),[],3);

Vw = max(Temp1(:,:,1),Temp1(:,:,2));
swch_wb = Temp1(:,:,1)<=Temp1(:,:,2);

dist_vs = max(max(abs(Vs - Vs0)));
dist_vb = max(max(abs(Vb - Vb0)));
dist_vw = max(max(abs(Vw - Vw0)));

dist_v = max(dist_vs,max(dist_vb,dist_vw));

Vs0 = Vs;
Vb0 = Vb;
Vw0 = Vw;

iter_v = iter_v + 1;

end;
clear Vb0 Vs0 Vw0 Vtemp EVtemp Vbtemp EVbtemp Temp1 Temp2 EV EVb

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































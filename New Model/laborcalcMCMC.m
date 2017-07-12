function y = laborcalcMCMC(z,a,zg,Ag,ag,r,w,Pr,indhire,N)
global r_bar deltta alfa nu gama Gama

% Created: 15.05.2017
% Last Update: --- 

% This function uses the output from MCMC simulation as the method to
% calculate the stationary distribution

% Calcuates the Labor demand in the economy for given vector r(nr x 1) and
% wage rate w. z and a are the managerial talents and asset endowment of
% all the individuals in the simulation who choose to become self-employed,
% zg, Ag and ag are the talent, augmented asset and asset grids and indhire
% indicates whether under given z a r combination an individual chooses to
% hire or not, so if indhire(z1,a1,r1)=1 then the guy who has talent z1,
% assets a1 and faces borrowing rate r1 chooses to hire. This function
% calculates the labor demand for each individual and sums them up.

n = size(z,1);
na = size(ag,2);
nz = size(zg,1);
nr = size(r,2);
nA = size(Ag,2);
ZG = repmat(zg,1,na,nr);
AG = repmat(ag,nz,1,nr);
RR = repmat(reshape(r,1,1,nr),nz,na,1);
F = griddedInterpolant(ZG,AG,RR,indhire);

ZG = repmat(zg,1,nA,nr);
AG = repmat(Ag,nz,1,nr);
RR = repmat(reshape(r,1,1,nr),nz,nA,1);



indhire = reshape(F(ZG(:),AG(:),RR(:)),nz,nA,nr);
indhire = round(indhire);

clear ZG AG RR

% In case if for different signals the individual changes his decision
% whether to hire or not depending on the borrowing rate s/he faces, we
% then know that the share Pr(r) will face the borrwoing rate r (for the
% given z) that makes them not hire, and thus that share won't hire, so if
% initially the weight of a guy is 1, then in this case his/her weight will
% be 1-Pr(r)

% Employers
% Invested capital by employers under borrowing rate r_bar (1) and r (2).
% Again, three types, k(rbar)<a save (a-k) *(1+rbar), k(r)>a borrow (k-a) *
% (1+r) and k(rbar)>=a but k(r)<a invest a and save 0

indhire = indhire.* repmat(reshape(Pr',nz,1,nr),1,nA,1);
LD      = 0;

kemp(:,:,1) = repmat(zg .^ (1/(1 - nu)),1,nA) * (alfa/(deltta + r_bar))^...
    ((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));

for ii = 1:nr
kemp(:,:,ii+1) = repmat(zg .^ (1/(1 - nu)),1,nA) * (alfa/(deltta + r(ii)))...
   ^((1 - gama)/(1 - nu)) * (gama/w) ^ (gama/(1-nu));
end

Kemp        = zeros(nz,nA,nr+1);
Kempmina    = zeros(nz,nA,nr+1);

% Those who save
Temp      = kemp(:,:,1);
Temp2     = repmat(Ag,nz,1) - kemp(:,:,1);
TKemp     = Kemp(:,:,1);
TKempmina = Kempmina(:,:,1);


TKemp(Temp2>=0) = Temp(Temp2>=0);
TKempmina(Temp2>=0) = Temp2(Temp2>=0) * (1+r_bar);

Kemp(:,:,1) = TKemp;
Kempmina(:,:,1) = TKempmina;

clear Temp Temp2
% Those who borrow
for ii = 1:nr

Temp  = kemp(:,:,ii+1);
Temp2 = repmat(Ag,nz,1) - kemp(:,:,ii+1);
TKemp = Kemp(:,:,ii+1);
TKempmina = Kempmina(:,:,ii+1); 

TKemp(Temp2<0) = Temp(Temp2<0);
TKempmina(Temp2<0) = Temp2(Temp2<0) * (1 + r(ii));

clear Temp Temp2

% Those who invest all
Temp = repmat(Ag,nz,1);

TKemp(kemp(:,:,1)>= Temp & kemp(:,:,ii+1)<=Temp) =...
    Temp(kemp(:,:,1)>= Temp & kemp(:,:,ii+1)<=Temp);

Kemp(:,:,ii+1)     = TKemp;
Kempmina(:,:,ii+1) = TKempmina;

clear TKemp TKempmina
% The profit given in (7)

if sum(sum(Kemp(:,:,ii+1)>0))~=sum(sum(Kemp(:,:,1)==0))
    error('check the profit code')
end

TKemp = Kemp(:,:,1) + Kemp(:,:,ii+1);
TKempmina = Kempmina(:,:,1) + Kempmina(:,:,ii+1);


% Labor imput 7(b)
L(:,:,ii) = (gama/w)^(1/(1-gama)) * repmat(zg.^(1/(1-gama)),1,nA) .* (TKemp.^...
    (alfa/(1-gama))); 

%profit_emp(:,:,ii) = repmat(zg,1,nA) .* TKemp.^(alfa).* L.^(gama) - w*L...
%    + TKempmina + (1 - deltta) * TKemp;

LD = LD + L(:,:,ii).*indhire(:,:,ii);

end

X =LD(nz*(z-1)+a);
LabD = sum(X)/N;
semp = [length(X),sum(X==0)]./N;

y = {LabD semp};



function y = expinc(Y,P,epsilon)

% Created: 11.08.2017
% Last Update: ----

% This function calculates the expected income in case if the individual
% chooses to be own-account or hire employees. This choice is made
% depending on your expectations about the shock realizations and
% after-shock income at hand. I calculate the incomes for both cases in
% case if the individual decides to default on debt or to pay back in
% another function


global zetta


[nz na ~] = size(Y);
neps      = length(epsilon);
nshck     = length(P);
y         = zeros(nz,na,neps,nshck,2);

piown = Y(:,:,:,1);
piemp = Y(:,:,:,2);



piown = reshape(piown,nz,na*neps);
piown = repmat(piown,1,1,nshck);

piemp = reshape(piemp,nz,na*neps);
piemp = repmat(piemp,1,1,nshck);


shckmatrix = zeros(nz,na*neps,nshck);

shckmatrix(:,1:na,:) = repmat(reshape(1-P,1,1,nshck),nz,na); 

for ii = 1:neps-1

shckmatrix(:,na*ii+1:na*(ii+1),:) = repmat(reshape(zetta(ii).*P,1,1,...
    nshck),nz,na);

end

Epiown = piown.*shckmatrix;
Epiemp = piemp.*shckmatrix;

Epiown = reshape(Epiown,nz,na,neps,nshck);
Epiown = sum(Epiown,3);
Epiown = reshape(Epiown,nz,na,nshck);

Epiemp = reshape(Epiemp,nz,na,neps,nshck);
Epiemp = sum(Epiemp,3);
Epiemp = reshape(Epiemp,nz,na,nshck);


Ihire  = Epiemp>Epiown;
Ihire  = reshape(Ihire,nz,na,1,nshck);
Ihire  = repmat(Ihire,1,1,neps,1);

piown = repmat(Y(:,:,:,1),1,1,1,nshck);
piemp = repmat(Y(:,:,:,2),1,1,1,nshck);


income = piown.*(1-Ihire) + piemp.*Ihire;
y(:,:,:,:,1) = Ihire;
y(:,:,:,:,2) = income;

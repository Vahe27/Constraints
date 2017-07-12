function y = aftershockinc(Y, ee,preps,n,Capflag);

% Created 13.04.2017
% Last Update 20.04.2017 Make Y 3D to accomodate for signals
% Last Update 20.05.2017 Add possibility to create defaults index

% This function calculates after shock income and the choice to default as
% a function of assets and talents. P (1 x 1), ee (n x 1), Y(nz x na x nr).
% Output y is (nz x na x nr x n) dimensional, 

% Capflag = 0 no index of defaults created, only the matrix of aftershock
% incomes, Capflag = 1, also an index created that specifies under which
% conditions self-employed default. 


global xi


if Capflag == 0
    
    [nz na nr] = size(Y);
    y = zeros(nz,na,nr,n);

for ii = 1:n
    y(:,:,:,ii) = max(Y - ee(ii),xi);
end
    
else
[nz,nA,nr,~] = size(Y);
    borrow  = Y(:,:,:,1);
    income = Y(:,:,:,2);
    
    for ii = 1:n
    indexD(:,:,:,ii) = income - ee(ii)<=xi;
    end
    CapD = indexD.*repmat(borrow,1,1,1,n); % nz,nA,nr,neps
    DefK = CapD.*repmat(reshape(preps,1,1,1,n),nz,nA,nr,1);
    DefK = sum(DefK,4); % nz,nA,nr
    
    y = abs(DefK);
    
end
% Calculate the capital demand using the output from profitcalc. adjust it
% in a way that it accepts also a flag that if equal to 0 does only
% calculation of profits, if equal to 1, only calculates the capital
% demand

Capflag = 1;
X = profitcalc(zgrid,Agrid,r0,w0,Capflag);
BorrowK = X(:,:,:,1);
businc  = X(:,:,:,2);

DefaultMatrix = aftershockinc(X,epsilon,P,neps,Capflag);

clear X

% I get the default matrix which gives the capital that a given type (z,a)
% defaults on when facing interest rate r on average (taken into account
% the probabilities of facing shocks). Now, from these guys, some share
% will face borrowing rate r1, others r2 and so on, given by Pr, so now I
% weight the default matrix by the share of the guys facing borrowing rate
% r1 given their talent z

wghtDMat = DefaultMatrix.* repmat(reshape(Pr',nz,1,nr),1,nA,1);
index    = (Biga(OCC==3)-1)*nz + Bigz(OCC==3);

BorrowK = BorrowK .*repmat(reshape(Pr',nz,1,nr),1,nA,1);


for ii = 1:nr
    TEMP = wghtDMat(:,:,ii);
    TEMP2 = BorrowK(:,:,ii);
    
    KDEF(ii) = sum(TEMP(index))/NN;
    KD(ii) = sum(TEMP2(index))/NN;
end

% Here KD and KDEF are calculated gross, meaning that borrowing rates are
% also multiplied to them

KDEF = KDEF./(1+r0);
KD   = KD./(1+r0);

Klent     = KD*(1+r_bar);
Kreceived = (KD-KDEF).*(1+r0); 


% You can get a multidimensional brent by having a loop for each value of r
% and inside the loop you have adjustments done by single dimensional brent

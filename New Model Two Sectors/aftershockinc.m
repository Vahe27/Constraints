function y = aftershockinc(Y,ee,preps,n,Capflag);

% Created 13.04.2017
% Last Update 20.04.2017 Make Y 3D to accomodate for signals
% Last Update 20.05.2017 Add possibility to create defaults index
% Last Update 10.08.2017 Input variable has been changed, now a person
% takes into consideration future shock realizations and possible defaults
% before making a decision whether to hire an employee or not, so he looks
% at the expected realizations

% Y = INCOME is 3 dimensional, nz,na and the third dimension is: profit_own
% profit_emp, income_own, income_emp where income is profit plus capital
% payment

% The output is 4D, nz,na,neps and the 4th dimension is whether the
% entrepreneur has hired an employee or not

piown = Y(:,:,:,1);
piemp = Y(:,:,:,2);
yown  = Y(:,:,:,3);
yemp  = Y(:,:,:,4);



global xi


if Capflag == 0
    
    [nz na ~] = size(Y);
    y1 = zeros(nz,na,n);
    y2 = zeros(nz,na,n);

for ii = 1:n
    
    y1(:,:,ii) = max(piown - ee(ii),min(xi,yown));
    y2(:,:,ii) = max(piemp - ee(ii),min(xi,yemp));
    
end

end

y(:,:,:,1) = y1;
y(:,:,:,2) = y2;
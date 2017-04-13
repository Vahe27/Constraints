function y = aftershockinc(Y, ee, n, nz, na);

% Created 13.04.2017
% Last Update -----

% This function calculates after shock income and the choice to default as
% a function of assets and talents. P (1 x 1), ee (n x 1), Y(nz x na).
% Output y is (nz x na x n) dimensional, 

global xi

y = zeros(nz,na,n);

for ii = 1:n
    y(:,:,ii) = max(Y - ee(ii),xi);
end
    



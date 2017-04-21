function y = aftershockinc(Y, ee, n);

% Created 13.04.2017
% Last Update 20.04.2017 Make Y 3D to accomodate for signals

% This function calculates after shock income and the choice to default as
% a function of assets and talents. P (1 x 1), ee (n x 1), Y(nz x na x nr).
% Output y is (nz x na x nr x n) dimensional, 

[nz na nr] = size(Y);

global xi

y = zeros(nz,na,nr,n);

for ii = 1:n
    y(:,:,:,ii) = max(Y - ee(ii),xi);
end
    



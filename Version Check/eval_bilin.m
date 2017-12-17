function out = eval_bilin(coeff, x, y, inp)

% [x(:) y(:)]
%inp

ix = inp(1);
iy = inp(2);

lx = length(x);
ly = length(y);

% nx = sum(ix>=x(1:(end-1)));
% ny = sum(iy>=y(1:(end-1)));


nx = 0;
ny = 0;

%% Find area on x axis

for i = 1:(lx-2)
    
    if ix >= x(i) && ix < x(i+1)
        nx = i;
        break
    end
    
end

if ix >= x(lx-1)
    nx = lx-1;
end


%% Find area on y axis

for i = 1:(ly-2)
    
    if iy >= y(i) && iy < y(i+1)
        ny = i;
        break
    end
    
end

if iy >= y(ly-1)
    ny = ly-1;
end
   
%beta = coeff(nx,ny,:);

% beta = zeros(1,4);
% beta(1) = coeff(nx,ny,1);
% beta(2) = coeff(nx,ny,2);
% beta(3) = coeff(nx,ny,3);
% beta(4) = coeff(nx,ny,4);
% 
% xxx = [1; ix; iy; ix*iy];
% 
% out = beta*xxx;


out = coeff(nx,ny,1) + coeff(nx,ny,2)*ix + coeff(nx,ny,3)*iy + coeff(nx,ny,4)*ix*iy;
function yv = interp2dim(x,z,xv,dzdx)

% The only thing you need to make sure for this interpolation is that x is
% increasing, or non-decreasing
nx = length(x);
nxv = length(xv);

yv     = zeros(nxv,1);
tempn  = 1;
indmax = nx;
indmin = 1;
%dzdx = zeros(nx,1);
%dzdx(2:end) = x(2:end) - x(1:end-1);

 while indmax>indmin+1

tempn = floor((indmax+indmin)/2);

if xv(1)>x(tempn)
    indmin = tempn;
else
    indmax = tempn;
end
 end
 
yv(1) = z(indmin) + dzdx(indmax)*(xv(1)-x(indmin));


for jj = 2:nxv
 
 if xv(jj)>xv(jj-1)
     indmax = nx;
     indmin = tempn;

 else
     indmax = tempn;
     indmin = 1;
 end
 while indmax>indmin+1

tempn = floor((indmax+indmin)/2);

if xv(jj)>x(tempn)
    indmin = tempn;
else
    indmax = tempn;
end
 end
 
yv(jj) = z(indmin) + dzdx(indmax)*(xv(jj)-x(indmin));
end

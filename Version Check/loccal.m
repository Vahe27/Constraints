function yv = loccal(x,xv)

% Calculates the locations of continuous variables on a given grid, for
% interpolation

nx = length(x);
nxv = length(xv);

yv     = zeros(nxv,2);
yd     = zeros(nxv,1);
tempn  = 1;
indmax = nx;
indmin = 1;

 while indmax>indmin+1

tempn = floor((indmax+indmin)/2);

if xv(1)>x(tempn)
    indmin = tempn;
else
    indmax = tempn;
end
 end
 
 yv(1,:) = [indmin indmax];
 yd(1)   = (xv(1) - x(indmin))/(x(indmax)-x(indmin));



for jj = 2:nxv
 
 if xv(jj)>xv(jj-1)
     indmax = nx;
     %indmin = indmin;

 else
     %indmax = indmax;
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
 
 yv(jj,:) = [indmin indmax];
 yd(jj)   = (xv(jj) - x(indmin))/(x(indmax)-x(indmin));
end

yv = [yv yd];

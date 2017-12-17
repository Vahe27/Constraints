function yv = interp1dim(x,z,xv)

% The only thing you need to make sure for this interpolation is that x is
% increasing, or non-decreasing
nx = length(x);
nxv = length(xv);

indmax = ones(nxv,1)*nx;
indmin = ones(nxv,1);
niter  = floor(log(nx)/log(2))+1;

for ii=1:niter

tempn = floor((indmax+indmin)/2);
indt = xv<=x(tempn);

indmax(indt) = tempn(indt);
indmin(~indt) = tempn(~indt); 
end

yv = z(indmin) + (z(indmax)-z(indmin)).*(xv-x(indmin))./(x(indmax)-x(indmin));
function y = adist(amin,amax,n,method)

% Created 11.04.2017 

% Creates the asset grid, method defines the spacing of the grid points, if
% 1 the points are equally spaced, if 2 they are logarithmically spaced

if method == 1

y = linspace(amin,amax,n);

elseif method == 2

y = logspace(log(amin)/log(10),log(amax)/log(10),n);

end
end

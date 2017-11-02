function y = invint(k,ni)

% Created: 05.10.2017
% Last Update: ---

%{
 This function creates a matrix of values for which the power has been
 calculated, to be used in interpolations in the function KLMCMC
%}

global alfa gama

kmin = min(k,[],2);
kmax = max(k,[],2);

invmin = 2*kmin;
invmax = 2*kmax;

V(1,:) = linspace(invmin(1),invmax(1),ni);
V(2,:) = linspace(invmin(2),invmax(2),ni);

alfaV = V.^alfa;
gamaV = V.^(alfa/(1-gama));

y = [V;alfaV; gamaV]';
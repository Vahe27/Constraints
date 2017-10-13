function y = zborrow(z,a,r,w)

global gama alfa nu r_bar deltta Gama

% Created 12.04.2017
% Last Update ---

% This function calculates the threshold managerial talents for
% self-employed and employers as functions of asset level, that are
% indifferent between renting additional capital x with borrowing rate r or
% not

% a(1 x na) z(nz x 1) r(1x1) w(1x1)

% Eq 4 in notes
y(:,1) = (r + deltta)/(alfa * Gama) * a.^(1-alfa);

% Eq 5 in notes
y(:,2) = (r + deltta)/nu * (alfa/(r+deltta))^gama * (w/gama)^gama * a.^(1-nu);
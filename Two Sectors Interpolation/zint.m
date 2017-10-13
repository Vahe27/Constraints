function y = zint(minz,upperz,ni,etta)

% Created: 05.10.2017
% Last Update: --- 

%{
This function creates a matrix where the first column vector is the values
of a grid of all managerial talents, and the sectond vector is their power
to 1/(1-gama). This matrix is used in KLMCMCINT to interpolate for the
powers
%}

global gama

maxz = (1 - upperz).^(-1/etta);

ZG     = linspace(minz,maxz,ni);
ZGgama = ZG.^(1/(1-gama));  

y = [ZG; ZGgama]';
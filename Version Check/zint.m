function y = zint(BIGZ)

% Created: 05.10.2017
% Last Update: --- 

%{
This function creates a matrix where the first column vector is the values
of a grid of all managerial talents, and the sectond vector is their power
to 1/(1-gama). This matrix is used in KLMCMCINT to interpolate for the
powers
%}

global gama varphi

ZGgama(:,1) = (varphi*BIGZ).^(1/(1-gama));
ZGgama(:,2) =   BIGZ.^(1/(1-gama));
ZGgama(:,3) = (BIGZ*varphi).^(-1/gama);
ZGgama(:,4) = (BIGZ).^(-1/gama);

y = [ZGgama];
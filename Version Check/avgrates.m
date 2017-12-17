function y = avgrates(r,w,K,kgrid)

% Created 29.11.2017
% Last Update: --- 

% Calculates the average borrowing rate for the amount below 1 mln $ and
% above
milthresh = w*20;
K=K';
bloc(1) = find(abs(kgrid(1,:)-milthresh)==min(abs(kgrid(1,:)-milthresh)));
bloc(2) = find(abs(kgrid(2,:)-milthresh)==min(abs(kgrid(2,:)-milthresh)));

NOM = sum(K(1,1:bloc(1)).*r(1,1:bloc(1))) + sum(K(2,1:bloc(2))...
    .*r(2,1:bloc(2)));

DENOM = sum(K(1,1:bloc(1))) + sum(K(2,1:bloc(2)));

rlow = NOM/DENOM;

NOM = sum(K(1,bloc(1)+1:end).*r(1,bloc(1)+1:end)) +  ...
    sum(K(2,bloc(2)+1:end).*r(2,bloc(2)+1:end));

DENOM = sum(K(1,bloc(1)+1:end)) + sum(K(2,bloc(2)+1:end));

rup  = NOM/DENOM;

y = [rlow rup];

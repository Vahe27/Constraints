function y = NSzbar(N,S,zgrid,na,nkap)

% Created: 10.05.2017
% Last Update:

% This function creates the threshold managerial talents for those who
% choose between not-working and self-employment. znthresh gives z(a,kap) which
% tells us for an individual with asset a and disutility from work kappa,
% what is the threshold managerial talent that makes him indifferent
% between not working and self-employment.

znthresh = zeros(nkap*na,1);

NS = N-S;

[temp INS(:,2)] = min(NS>0,[],2);
clear temp
INS(:,1) = INS(:,2) - 1;
INSt = na*nkap*(INS-1)+repmat([1:na*nkap]',1,2);

znthresh = zeros(na*nkap,1);
znthresh(INS(:,1)==0) = zgrid(1);
znthresh(INS(:,2)==0) = nan;

wghtn = abs(NS(INSt(INS(:,1)>0,2)))./(abs(NS(INSt(INS(:,1)>0,1))) +...
    abs(NS(INSt(INS(:,1)>0,2))));

znthresh(INS(:,1)>0) = zgrid(INS(INS(:,1)>0,2)) - wghtn.* ...
    (zgrid(INS(INS(:,1)>0,2)) - zgrid(INS(INS(:,1)>0,1)));

y = reshape(znthresh,na,nkap);
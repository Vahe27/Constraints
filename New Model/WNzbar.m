function y = WNzbar(W,N,zgrid,na,nkap);

% Created: 10.05.2017
% Last Update:

% This function creates the threshold managerial talents for those who
% choose between not-working and self-employment. znthresh gives z(a,kap) which
% tells us for an individual with asset a and disutility from work kappa,
% what is the threshold managerial talent that makes him indifferent
% between not working and self-employment.

WN = W - N;

[temp IWN(:,2)] = min(WN>0,[],2);
IWN(:,1) = IWN(:,2) - 1;
IWNt = na*nkap*(IWN-1)+repmat([1:na*nkap]',1,2);

zwnthresh = zeros(na*nkap,1);
zwnthresh(IWN(:,1)==0) = zgrid(1);
zwnthresh(IWN(:,2)==0) = nan;
zwnthresh(temp==1)     = zgrid(end);


wghtwn = abs(WN(IWNt(IWN(:,1)>0,2)))./(abs(WN(IWNt(IWN(:,1)>0,1))) +...
    abs(WN(IWNt(IWN(:,1)>0,2))));

zwnthresh(IWN(:,1)>0) = zgrid(IWN(IWN(:,1)>0,2)) - wghtwn.* ...
    (zgrid(IWN(IWN(:,1)>0,2)) - zgrid(IWN(IWN(:,1)>0,1)));

y = reshape(zwnthresh,na,nkap);

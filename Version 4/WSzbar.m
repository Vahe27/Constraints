function y = WSzbar(W,S,zgrid,na,nkap)

% Created: 10.05.2017
% Last Update:

% This function creates the threshold managerial talents for those who
% choose between working and self-employment. zwthresh gives z(a,kap) which
% tells us for an individual with asset a and disutility from work kappa,
% what is the threshold managerial talent that makes him indifferent
% between working and self-employment.

WS = W - S;

[temp IWS(:,2)]= min((WS>0),[],2);
clear temp
IWS(:,1) = IWS(:,2)-1;
IWSt = na*nkap*(IWS-1)+repmat([1:na*nkap]',1,2);



% threshold managerial talent that makes individuals of type (a,kap) be
% indifferent between working and self-employment

zwthresh = zeros(na*nkap,1);
zwthresh(IWS(:,1)==0) = zgrid(1);
zwthresh(IWS(:,2)==0) = nan;

wghtw = abs(WS(IWSt(IWS(:,1)>0,2)))./(WS(IWSt(IWS(:,1)>0,1)) - ...
    WS(IWSt(IWS(:,1)>0,2)));

% wghtw = abs(WS(IWSt(IWS(:,1)>0,2)))./(abs(WS(IWSt(IWS(:,1)>0,1))) +...
%     abs(WS(IWSt(IWS(:,1)>0,2))));
% 
% zwthresh(IWS(:,1)>0) = zgrid(IWS(IWS(:,1)>0,1)) + wghtw.*...
%     (zgrid(IWS(IWS(:,1)>0,2)) - zgrid(IWS(IWS(:,1)>0,1)));

zwthresh(IWS(:,1)>0) = zgrid(IWS(IWS(:,1)>0,2)) - wghtw.*...
    (zgrid(IWS(IWS(:,1)>0,2)) - zgrid(IWS(IWS(:,1)>0,1)));

y = reshape(zwthresh,na,nkap);
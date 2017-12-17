function y = assetaproxB(YN,Y,a,nz,na,nprob,neps)

% Created: 21.08.2017
% Last Update: 21.08.2017 Change ASSETS = a - THETA to ASSETS  = a

% This function does a similar approximation as the assetaprox. I take the
% benchmark case, where the individual just chose to improve his business
% so he paid THETA, and he's going to face epsilon(bneps) which means we
% know exactly his cash at hand in the end of the period before making the
% consumption-saving decision. What we do next, is use the one's
% assets-cash at hand relation who has already paid THETA in the previous
% periods and faces a wide variety of shocks epsilon. Here y is the assets
% he should have (in case he has to pay THETA and face epsilon) in order to 
% generate exactly the cash at hand he generates now with asset agrid

global THETA

YN = reshape(YN,nz,na,nprob);
YN = permute(YN,[1 3 2]);
YN = reshape(YN,nz*nprob,na);

% ASSETS = a - THETA;
ASSETS = a;


Y  = reshape(permute(Y,[1 4 2 3]),nz*nprob,na*neps);

newa = zeros(nz*nprob,neps*na);

for ii = 1:nz*nprob
    YNU  = YN(ii,:);
    [TEMP ITEMP] = unique(YNU);
    ITEMP = ITEMP(~isnan(TEMP));
    TEMP = TEMP(~isnan(TEMP));
    ITEMP(1) = ITEMP(2)-1;

    
    newa(ii,:) = interp1(TEMP,ASSETS(ITEMP),Y(ii,:),[],'extrap');

end

y = permute(reshape(newa,nz,nprob,na,neps),[1 3 4 2]);

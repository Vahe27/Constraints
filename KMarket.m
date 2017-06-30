%% This version is updated to the case where the intermediary doesn't only 
% observe the signal of the entrepreneur, but also the amount he has
% borrowed

% Calculate the capital demand using the output from profitcalc. adjust it
% in a way that it accepts also a flag that if equal to 0 does only
% calculation of profits, if equal to 1, only calculates the capital
% demand



edges = [1:nk+1]-1/2;

for ii = 1:nr
    
    Kbins(:,ii) = histcounts(KDindex(:,ii),edges);

end



KDEF = KDefault(BIGZ(OCC==3),BIGA(OCC==3),KD,KDindex,r0,w0,...
    income, epsilon,P,nk);

KPAY = KD - KDEF;

for ii = 1:nk

    KGOT(:,ii) = sum(Pr.*KPAY.*(KDindex==ii));
    KLENT(:,ii) = sum(Pr.*KD.*(KDindex==ii));
    
end

KGOT  = KGOT./NN;
KLENT = KLENT./NN;

rnew = KLENT.*(1+r_bar)./KGOT - 1;

diffK = (KLENT.*(1+r_bar) - KGOT.*(1+r0)).*2./...
    (KLENT.*(1+r_bar) + KGOT.*(1+r0));

rnew(isnan(rnew) & KLENT==0) = r0(isnan(rnew) & KLENT==0);
diffK(KLENT==0) = 0;

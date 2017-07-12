%% This version is updated to the case where the intermediary doesn't only 
% observe the signal of the entrepreneur, but also the amount he has
% borrowed

% Calculate the capital demand using the output from profitcalc. adjust it
% in a way that it accepts also a flag that if equal to 0 does only
% calculation of profits, if equal to 1, only calculates the capital
% demand

q0          = 1./(1+r0);
IndBorrow   = (KD~=0);
probdefault = zeros(size(KD));

% Calculate the probability of default for each of the borrowers

for ii = 1:neps
 probdefault = (income<epsilon(ii)).*IndBorrow.*P(ii) + probdefault;
end

meanprobdefault = zeros(nk,nr);
KBOR   = zeros(nk,nr);

% Here I calculate for each borrowed amount what's the average probability
% of default (suppose

for jj = 1:nr
    for ii=1:nk
   meanprobdefault(ii,jj) = sum(probdefault(KDindex(:,jj)==ii,jj))/sum(KDindex(:,jj)==ii);
   KBOR(ii,jj)   = sum(KD(KDindex(:,jj)==ii,jj));
    end
    meanprobdefault(isnan(meanprobdefault(:,jj)),jj) = 0;
    %[x loc(:,jj)] = sortrows(meanprobdefault(:,jj));
end

KNDEF = KBOR.*(1-meanprobdefault);

diffK = q0'.*(KBOR).*(1+r_bar) - KNDEF;
diffK = diffK*2./(q0'.*(KBOR).*(1+r_bar) + KNDEF);

qnew = KNDEF./(KBOR.*(1+r_bar));
qnew = qnew';
qnew(1) = 1/(r_bar+1);

qnan    = isnan(qnew);
nanflag = 0;

for jj = 2:nk
    if qnan(jj) == 1 & qnan(jj-1)==0
        qlow    = qnew(jj-1);
        jjlow   = jj;    
    end
    
    if qnan(jj) == 0 & qnan(jj-1) == 1
        nanflag = 1;
        qhigh   = qnew(jj);
        jjhigh  = jj-1;    
    end
   
    if nanflag  == 1
        qnew(jjlow:jjhigh) = qhigh;%(qlow+qhigh)/2;
    end   
    
end
        


%{
for ii = 2:nk
    if isnan(qnew(ii))
    qnew(ii) =min(qnew(ii-1)*1.001,1/(r_bar+1));
    end
end
%}

%{
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

rnew(isnan(rnew) & KLENT==0) = max(r_bar,(1-rupdate).*r0(isnan(rnew) & KLENT==0));
diffK(KLENT==0) = 0;
%}
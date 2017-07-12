%% This version is updated to the case where the intermediary doesn't only 
% observe the signal of the entrepreneur, but also the amount he has
% borrowed

%{
Here I use another technique for the problem of the intermediary. In this
case the intermediary also observes the capital demand but it cannot set a
borrowing rate for each capital, as the number of contracts it can offer is
limited due to fixed costs of issuing a contract. Here the intermediary
will group entrepreneurs by their liklihood of default, given the
information of their borrowed amount, and for each risk group it will set a
separate borrowing rate.
%}

contractchi = 1000;

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


[PRDEF IPRDEF] = sortrows([meanprobdefault -[1:nk]']);
PRDEF          = PRDEF(:,1);
KBOR           = KBOR(IPRDEF);
KGRID          = kgrid(IPRDEF);
KDEF           = KBOR.*PRDEF;
KNDEF          = KBOR.*(1-PRDEF);
%%%%%%%%%%%% NOTE KBOR - THE AMOUNT YOU NEED TO GIVE BACK, YOU BORROW%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Q0*KBOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The approach is as follows: First calculate the q0 for each capital bin,
% then given the capital bin (the probability to default bin) calculate
% what revenue the bank will get if everybody above faces the same
% borrowing rate and doesn't adjust the demand. Next, look at those who
% never default, put them in one group and calculate the borrowing rate
% they need to face in order to generate revenue equal to the money needed
% to create the contract. Next bunch the non-defaulters in a group where
% they will face the lower borrowing rate

% Calculate the borrowing rate the non-defaulters need to face for the bank
% to generate revenue equal to the cost of creating the contract

numC    = 1; % Number of total contracts offered
verj    = 0;
I       = 0;

QNONDEF = 1/(1+r_bar) - contractchi/(sum(KBOR(PRDEF==0).*(1+r_bar)));

qtemp   = (KBOR - KDEF)./(KBOR*(1+r_bar));
qnew    = zeros(1,nk);

for ii = 1:nk
REVENUE(ii) = sum(KNDEF(1:ii)) - (1+r_bar)*qtemp(ii)*sum(KBOR(1:ii));
end
REVENUE(isnan(REVENUE))= 0;


TEMP = abs(REVENUE - contractchi);
TEMP(REVENUE==0)=1e6;
[~,I(1)] = min(TEMP);
clear TEMP

if qtemp(I(1))>QNONDEF
qnew(1:I(1)) = qtemp(I(1));
else
qnew(PRDEF==0) = QNONDEF;
I(1) = max(find(PRDEF==0));
end



REVENUE(1:I(1))        = 0;

while max(REVENUE(REVENUE<1e6))>contractchi

    tx = I(end);
    
for ii = tx:nk
REVENUE(ii) = sum(KNDEF(tx:ii)) - (1+r_bar)*qtemp(ii)*sum(KBOR(tx:ii));
end

numC    = numC + 1;
    
[mnac, I(numC)] = min(abs(REVENUE - contractchi));

if REVENUE(I(numC)) - contractchi < -contractchi*0.85;
    if I(numC) == nk
        verj = 1;
    else
    I(numC) = I(numC)+1;
    end
end

%if verj == 1
%    break;
%end

qnew(I(numC-1):I(numC)) = qtemp(I(numC));

REVENUE = REVENUE - REVENUE(I(numC));
    REVENUE(1:I(end)) = 1e6;

end

numcont = sum(unique(qnew(qnew~=0))>0)-1;

diffK = zeros(numcont,1);
KNDEF = KBOR - KDEF;


diffK(1) = sum(q0(1:I(1))'.*KBOR(1:I(1))*(1+r_bar) - KNDEF(1:I(1)))...
    + contractchi;
diffK(1) = diffK(1)*2./(sum(q0(1:I(1))'.*KBOR(1:I(1))*(1+r_bar) ...
    + KNDEF(1:I(1))) - contractchi);

for ii=2:numcont
    diffK(ii) = sum(q0(I(ii)+1:I(ii+1))'.*KBOR(I(ii)+1:I(ii+1))*(1+r_bar)...
        - KNDEF(I(ii)+1:I(ii+1))) + contractchi;
diffK(ii) = diffK(ii)*2./(sum(q0(I(ii)+1:I(ii+1))'.*KBOR(I(ii)+1:I(ii+1))...
    *(1+r_bar) + KNDEF(I(ii)+1:I(ii+1))) - contractchi);
end


    
    
    
    
%{    
diffK            = (q0'.*KBOR * (1+r_bar) - (KBOR - KDEF) - contractchi*length(I));
diffK            = 2*diffK./(q0'.*KBOR * (1+r_bar) + (KBOR - KDEF));
%}
[KGRID, INDBACK] = sort(KGRID,'ascend');
qnew             = qnew(INDBACK);
KBOR             = KBOR(INDBACK);
KDEF             = KDEF(INDBACK);




%{
qnew(qnew == 0) = 0.5;
q0 = reshape(qnew',20,5);
q0 = mean(q0);
q0 = repmat(q0,20,1);
q0 = q0(:)';
%}

%{
q0                = 1./(1+r0);

qnew              = KBOR.*(1-PRDEF)./(KBOR.*(1+r_bar));



qnew(isnan(qnew)) = q0(isnan(qnew))*1.01;
qnew              = min(qnew,1/(1+r_bar));
qnew              = qnew';  

INDEX = KBOR==0;


for jj = 2:nk-1
    flagind = 0;
    if INDEX(jj) ==1 && INDEX(jj-1)==0
        minind = jj;
    end
        if INDEX(jj) == 1 && INDEX(jj+1) == 0
            maxind = jj;
            flagind = 1;
        end
        if flagind == 1;
            qnew(minind:maxind) = (qnew(minind-1)+qnew(maxind+1))/2;
        end
end

        
        


KNDEF = KBOR.*(1-meanprobdefault);


%{
rnew = (KBOR.*(1+r_bar)./(KBOR - KDEF) - 1)';
rnew(isnan(rnew)) = r_bar;
%}
diffK = q0'.*KBOR.*(1+r_bar) - KNDEF;
diffK = 2*diffK./(q0'.*KBOR.*(1+r_bar) + KNDEF);

diffK(KNDEF==KBOR) = 0;


% diffK = 2*(rnew - r0)./(rnew+r0);
% 
% diffK(KBOR==0) = 0;


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
%}
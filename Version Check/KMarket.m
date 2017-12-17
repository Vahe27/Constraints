%% UPDATE
%{
In this version there are no signals, there are two types of businesses,
upgraded and not. Done to take into account the development process of
businesses. The intermediary doesn't observe the assets and type of the
businessman, but observes whether the firm is modern and how much it
demands, also the distribution of firms in the equilibrium
%}

% Calculate the capital demand using the output from profitcalc. adjust it
% in a way that it accepts also a flag that if equal to 0 does only
% calculation of profits, if equal to 1, only calculates the capital
% demand

q0           = 1./(1+r0);
IndBorrowS   = (KDS~=0);
IndBorrowB   = (KDB~=0);
probdefaultS = zeros(size(KDS));
probdefaultB = zeros(size(KDB));


           
% Calculate the probability of default for each of the borrowers


tempprob = BIGPROB(OCCS==3,:);
for ii = 1:neps
 probdefaultS = ((incomeS-epsilon(ii))<xi*w0).*IndBorrowS.*tempprob(:,ii)...
     + probdefaultS;
end

tempprob = BIGPROB(OCCS==4,:);
for ii = 1:neps
 probdefaultB = ((incomeB-epsilon(ii))<xi*w0).*IndBorrowB.*tempprob(:,ii)...
     + probdefaultB;
end


meanprobdefault = zeros(nk,nr);
KBOR   = zeros(nk,nr);

% Here I calculate for each borrowed amount what's the average probability
% of default

%for jj = 1:nr
    
for ii=1:nk
   
    meanprobdefault(ii,1) = sum(probdefaultS(KDindexS==ii))/sum(KDindexS==ii);
    KBOR(ii,1)   = sum(KDS(KDindexS==ii));
    meanprobdefault(ii,2) = sum(probdefaultB(KDindexB==ii))/sum(KDindexB==ii);
    KBOR(ii,2)   = sum(KDB(KDindexB==ii));
   
end
    
    meanprobdefault(isnan(meanprobdefault)) = 0;

%end

KNDEF = KBOR.*(1-meanprobdefault);
KDEF  = KBOR - KNDEF;

diffK = q0'.*(KBOR).*(1+r_bar) - KNDEF;
diffK = diffK*2./(q0'.*(KBOR).*(1+r_bar) + KNDEF);

qnew = KNDEF./(KBOR.*(1+r_bar));
qnew = qnew';
qnew(:,1) = 1/(r_bar+1);

qnan    = isnan(qnew);
nanflag = [0 0];

% Here in all cases where there is no demand for a given amount of capital,
% there will be no way to calculate the price, this is why following the
% methodology of Athreya, Tam and Young (2012)

for jj = 2:nk
    if qnan(1,jj) == 1 & qnan(1,jj-1)==0
        qlow(1)    = qnew(1,jj-1);
        jjlow(1)   = jj;    
    end
    
    if qnan(2,jj) == 1 & qnan(2,jj-1)==0
        qlow(2)    = qnew(2,jj-1);
        jjlow(2)   = jj;    
    
    else
        nanflag(1) = 0;
    end
    
    if qnan(1,jj) == 0 & qnan(1,jj-1) == 1
        nanflag(1) = 1;
        qhigh(1)   = qnew(1,jj);
        jjhigh(1)  = jj-1;    
    end
    
    if qnan(2,jj) == 0 & qnan(2,jj-1) == 1
        nanflag(2) = 1;
        qhigh(2)   = qnew(2,jj);
        jjhigh(2)  = jj-1;    
    else
        nanflag(2) = 0;
    end
   
    if nanflag(1)  == 1
        qnew(1,jjlow(1):jjhigh(1)) = qhigh(1);          %(qlow+qhigh)/2;
    end   
    
    if nanflag(2)  == 1
        qnew(2,jjlow(2):jjhigh(2)) = qhigh(2);          %(qlow+qhigh)/2;
    end
end
 
qnew(isnan(qnew)) = 1/(1+r_bar);


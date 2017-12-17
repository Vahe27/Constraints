%{
    The Same as the statiter, but with value function interpolation and not
    the occupational interpolation
%}

% Each value indicates whether the individual has access to employment and
% /or business or no i.e.
%{
1x3 = 3 no access to employment, no access to business (has to pay THETA)
1x4 = 4 no access to employment, access to business (businessman in t-1)
2x3 = 6 access to employment, no access to business
2x4 = 8 access to employment, access to business
%}

CUROCC = zeros(NN,TT,'int8');
EBN(isnan(EBN)) = -1e6;

if compile_flag == 1


        cfg = coder.config('mex');
        cfg.GenerateReport = true;
        cfg.IntegrityChecks = false;
        cfg.ResponsivenessChecks = false;
        cfg.GlobalDataSyncMethod = 'NoSync'; 

codegen -config cfg aprimecalc -args {zgrid,agrid,zloc(:,:,1),ploc(:,1:2),kaploc(:,1:2),N,ES,EBN,W,EBB,bigz(:,1),biga(:,1),ploc(:,3),kaploc(:,3),bige(:,1),POSB,AW,AN,EAS,EABN,EABB,amin,Kmax}

end


for tt = 1:TT

X = aprimecalc_mex(zgrid,agrid,zloc(:,:,tt),ploc(:,1:2),kaploc(:,1:2)...
    ,N,ES,EBN,W,EBB,bigz(:,tt),biga(:,tt),ploc(:,3),kaploc(:,3),...
    bige(:,tt),POSB,AW,AN,EAS,EABN,EABB,amin,Kmax);

biga(:,tt+1) = X(:,end);

BIGE = zeros(NN,1);
OCC  = X(:,6);

BIGE(OCC==2 & bige(:,tt+1)>lambda) = 2;
BIGE(OCC==2 & bige(:,tt+1)<lambda) = 1;
BIGE(OCC~=2 & bige(:,tt+1)>mu) = 2;
BIGE(OCC~=2 & bige(:,tt+1)<mu) = 1;

bige(:,tt+1) = BIGE;

POSB = (OCC==4)+3;

%TOTOCC(:,tt+1) = POSB.*BIGE;
CUROCC(:,tt) = OCC;
end

clear X

X = zeros(NN,6);
% Tenure extract
tenext = reshape(CUROCC(1:25:NN,151:200),NN,2);
X(:,1) = bigz(:,TT);
X(:,2) = biga(:,TT);
X(:,3) = bige(:,TT);
X(:,4) = OCC;
X(:,5:6) = tenext;

compile_flag = 0;
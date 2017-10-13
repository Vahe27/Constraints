% Suppose in the beginning of period t agent has a,z,kappa and chooses to
% become self-employed, then shares Pr_int face interest rates r0, shares
% Peps_int face shocks eps and have accordingly cash-at hand given in
% Atilde, then the same proportions of the guys will choose corresponding
% a' so their choices need to be summed with weights Peps_int and Pr_int to
% get how much an ex-ante representative entrepreneur saves.

% So EAS gives the choice of assets on average given z,a,kappa for the
% average self-employed

FS      = griddedInterpolant(z_array,a_array,prob_array,kap_array,...
         reshape(apgrid(IS),nz,na,nprob,nkap),'linear');

TS      = reshape(FS(zarrayintS,ATILDES,probarrayintS,kaparrayintS),...
         nz,na,neps+1,nprob,nkap);

EAS     = reshape(sum(TS(:,:,1:neps,:,:) .* probmtx,3),nz,na,nprob,nkap);

AN      = reshape(TS(:,:,end,:,:),nz,na,nprob,nkap);


IBnew           = IB;
IBnew(IBnew==0) = 1;

FB      = griddedInterpolant(z_array,a_array,prob_array,kap_array,...
         reshape(apgrid(IBnew),nz,na,nprob,nkap),'linear');

TBN     = reshape(FB(zarrayintB,ATILDEBN,probarrayintB,kaparrayintB),...
         nz,na,neps,nprob,nkap);

EABN    = reshape(sum(TBN .* probmtx,3),nz,na,nprob,nkap);


TBB     = reshape(FB(zarrayintB,ATILDEBB,probarrayintB,kaparrayintB),...
         nz,na,neps,nprob,nkap);
     
EABB    = reshape(sum(TBB .* probmtx,3),nz,na,nprob,nkap);

clear TS TBN TBB


% W ES N

% 1 if non-employed, 2 if employed, 3 if self-employed, 4 if businessman

MAXNES = max(ES,N);

OCCEMPNB                       = ones(nz,na,nprob,nkap);
OCCEMPNB(W>max(MAXNES,EBN))    = 2;
OCCEMPNB(EBN>max(W,MAXNES))    = 4;
OCCEMPNB(ES>max(W,max(N,EBN))) = 3;

OCCEMPB                        = ones(nz,na,nprob,nkap);
OCCEMPB(W>max(MAXNES,EBB))     = 2;
OCCEMPB(EBB>max(W,MAXNES))     = 4;
OCCEMPB(ES>max(W,max(N,EBB)))  = 3;

OCCNEMNB                       = ones(nz,na,nprob,nkap);
OCCNEMNB(EBN>MAXNES)           = 4;
OCCNEMNB(ES>max(N,EBN))        = 3;

OCCNEMB                        = ones(nz,na,nprob,nkap);
OCCNEMB(EBB>MAXNES)            = 4;
OCCNEMB(ES>max(N,EBB))         = 3;


bige  = [bigeprobs zeros(NN,1)];


FW    = griddedInterpolant(z_array,a_array,prob_array,kap_array,W);
FN    = griddedInterpolant(z_array,a_array,prob_array,kap_array,N);
FS    = griddedInterpolant(z_array,a_array,prob_array,kap_array,ES);
FBN   = griddedInterpolant(z_array,a_array,prob_array,kap_array,EBN);
FBB   = griddedInterpolant(z_array,a_array,prob_array,kap_array,EBB);
FAPW  = griddedInterpolant(z_array,a_array,prob_array,kap_array,apgrid(IW));
FAPN  = griddedInterpolant(z_array,a_array,prob_array,kap_array,AN);
FAPS  = griddedInterpolant(z_array,a_array,prob_array,kap_array,EAS);
FABN  = griddedInterpolant(z_array,a_array,prob_array,kap_array,EABN);
FABB  = griddedInterpolant(z_array,a_array,prob_array,kap_array,EABB);


VALMAT = reshape([OCCNEMNB OCCNEMB OCCEMPNB OCCEMPB],nz,na,4,nprob,nkap);
VALMAT = permute(VALMAT,[1 2 4 5 3]);

FFIN  = griddedInterpolant(Zarray,Aarray,Parray,Karray,Oarray,VALMAT);
% Each value indicates whether the individual has access to employment and
% /or business or no i.e.
%{
1x3 = 3 no access to employment, no access to business (has to pay THETA)
1x4 = 4 no access to employment, access to business (businessman in t-1)
2x3 = 6 access to employment, no access to business
2x4 = 8 access to employment, access to business
%}

TOTOCC = [POSB.*bige(:,1) zeros(NN,TT-1)];
CUROCC = zeros(NN,TT);

for tt = 1:TT

BIGZ = bigz(:,tt);
BIGA = biga(:,tt);
BIGE = bige(:,tt);

OCC  = ones(NN,1);

OCC  = FFIN(BIGZ,BIGA,bigprob,bigkap,TOTOCC(:,tt));

% Locations where occupational choice unsure, between either 1,2 or 2,3 or
% 1,3. Hard to distinguish, so work with value functions
INDEX  = find(floor(OCC) ~= OCC);
TINDEX = TOTOCC(INDEX,tt);
NIND   = size(INDEX,1);
dummy  = ones(NIND,1)*-100;

TEMPN  = FN(BIGZ(INDEX),BIGA(INDEX),bigprob(INDEX),bigkap(INDEX));
TEMPS  = FS(BIGZ(INDEX),BIGA(INDEX),bigprob(INDEX),bigkap(INDEX));
TEMPNB = FBN(BIGZ(INDEX),BIGA(INDEX),bigprob(INDEX),bigkap(INDEX));

TEMPBB4 = FBB(BIGZ(TINDEX==4),BIGA(TINDEX==4),bigprob(TINDEX==4),...
    bigkap(TINDEX==4));

TEMPBB8 = FBB(BIGZ(TINDEX==8),BIGA(TINDEX==8),bigprob(TINDEX==8),...
    bigkap(TINDEX==8));

TEMPW6  = FW(BIGZ(TINDEX==6),BIGA(TINDEX==6),bigprob(TINDEX==6),...
    bigkap(TINDEX==6));

TEMPW8  = FW(BIGZ(TINDEX==8),BIGA(TINDEX==8),bigprob(TINDEX==8),...
    bigkap(TINDEX==8));


INESWB = zeros(NIND,1);


[~, INESWB(TINDEX==3)] = max([TEMPN(TINDEX==3) dummy(TINDEX==3)...
    TEMPS(TINDEX==3) TEMPNB(TINDEX==3)],[],2);

[~, INESWB(TINDEX==4)] = max([TEMPN(TINDEX==4) dummy(TINDEX==4)...
  TEMPS(TINDEX==4) TEMPBB4],[],2);

[~, INESWB(TINDEX==6)] = max([TEMPN(TINDEX==6) TEMPW6 TEMPS(TINDEX==6)...
    TEMPNB(TINDEX==6)],[],2);

[~, INESWB(TINDEX==8)] = max([TEMPN(TINDEX==8) TEMPW8 TEMPS(TINDEX==8)...
     TEMPBB8],[],2);


OCC(INDEX) = INESWB;

BIGAP      = zeros(NN,1);

BIGAP(OCC==1) = FAPN(BIGZ(OCC==1),BIGA(OCC==1),bigprob(OCC==1),...
    bigkap(OCC==1));
BIGAP(OCC==2) = FAPW(BIGZ(OCC==2),BIGA(OCC==2),bigprob(OCC==2),...
    bigkap(OCC==2));
BIGAP(OCC==3) = FAPS(BIGZ(OCC==3),BIGA(OCC==3),bigprob(OCC==3),...
    bigkap(OCC==3));

% TEMPIND = 1 if I am a businessman but just transferred from W,S or N, =2
% if I was a businessman previous period, so I didn't pay THETA
XOCC          = OCC==4;
TEMPIND       = XOCC.*(XOCC + (TOTOCC(:,tt)==8 | TOTOCC(:,tt)==4));

BIGAP(TEMPIND==1) = FABN(BIGZ(TEMPIND==1),BIGA(TEMPIND==1),...
    bigprob(TEMPIND==1),bigkap(TEMPIND==1));
BIGAP(TEMPIND==2) = FABB(BIGZ(TEMPIND==2),BIGA(TEMPIND==2),...
    bigprob(TEMPIND==2),bigkap(TEMPIND==2));


BIGAP(BIGAP<amin) = amin;
BIGAP(BIGAP>2e3)  = 2e3;

biga(:,tt+1) = BIGAP;

BIGE = zeros(NN,1);

BIGE(OCC==2 & bige(:,tt+1)>lambda) = 2;
BIGE(OCC==2 & bige(:,tt+1)<lambda) = 1;
BIGE(OCC~=2 & bige(:,tt+1)>mu) = 2;
BIGE(OCC~=2 & bige(:,tt+1)<mu) = 1;

bige(:,tt+1) = BIGE;

BIND = (OCC==4)+3;

TOTOCC(:,tt+1) = BIND.*BIGE;
CUROCC(:,tt) = OCC;
end

BIGZ = bigz(:,TT);
BIGA = biga(:,TT);
BIGE = bige(:,TT);
OCCS = OCC(OCC==4 | OCC==3);
bigp = bigprob(OCC==4 | OCC==3);





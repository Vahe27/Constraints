function y = statiter(z_array,a_array,prob_array,kap_array,W,N,ES,EBN,...
    EBB,apgridIW,AN,EAS,EABN,EABB,OCCNEMNB,OCCNEMB,OCCEMPNB,OCCEMPB,...
    nz,na,nprob,nkap,Zarray,Aarray,Parray,Karray,Oarray,POSB,NN,TT,...
    bigz,biga,bige,bigprob,bigkap,amin,lambda,mu);

FW    = griddedInterpolant(z_array,a_array,prob_array,kap_array,W);
FN    = griddedInterpolant(z_array,a_array,prob_array,kap_array,N);
FS    = griddedInterpolant(z_array,a_array,prob_array,kap_array,ES);
FBN   = griddedInterpolant(z_array,a_array,prob_array,kap_array,EBN);
FBB   = griddedInterpolant(z_array,a_array,prob_array,kap_array,EBB);
FAPW  = griddedInterpolant(z_array,a_array,prob_array,kap_array,apgridIW);
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

y(:,1) = bigz(:,TT);
y(:,2) = biga(:,TT);
y(:,3) = bige(:,TT);
y(:,4) = OCC;
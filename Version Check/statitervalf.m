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

TOTOCC = [POSB.*bige(:,1) zeros(NN,TT-1)];
CUROCC = zeros(NN,TT);
y      = zeros(NN,5);

for tt = 1:TT

BIGZ = bigz(:,tt);
BIGA = biga(:,tt);
BIGE = bige(:,tt);
BE   = find(BIGE==2);
BB   = find(POSB==4);
INDW = zeros(length(BE),1);
INDB = zeros(length(BB),1);


OCC = ones(NN,1);

VN  = FN(BIGZ,BIGA,bigprob,bigkap);
VS  = FS(BIGZ,BIGA,bigprob,bigkap);
VBN = FBN(BIGZ,BIGA,bigprob,bigkap);
VW  = FW(BIGZ(BE),BIGA(BE),bigprob(BE),bigkap(BE));

VBB = FBB(BIGZ(BB),BIGA(BB),bigprob(BB),bigkap(BB));

[MAXOCC1 OCC] = max([VN VS VBN],[],2);
OCC(OCC>1) = OCC(OCC>1)+1;

[MAXOCC1(BE) INDW] = max([VW MAXOCC1(BE)],[],2);
OCC(BE(INDW==1)) = 2;

[MAXOCC1(BB) INDB] = max([VBB MAXOCC1(BB)],[],2);
OCC(BB(INDB==1)) = 4;

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
BIGAP(BIGAP>Kmax)  = Kmax;

biga(:,tt+1) = BIGAP;

BIGE = zeros(NN,1);

BIGE(OCC==2 & bige(:,tt+1)>lambda) = 2;
BIGE(OCC==2 & bige(:,tt+1)<lambda) = 1;
BIGE(OCC~=2 & bige(:,tt+1)>mu) = 2;
BIGE(OCC~=2 & bige(:,tt+1)<mu) = 1;

bige(:,tt+1) = BIGE;

POSB = (OCC==4)+3;

TOTOCC(:,tt+1) = POSB.*BIGE;
CUROCC(:,tt) = OCC;
end
% Tenure extract
tenext = reshape(CUROCC(1:25:NN,151:200),NN,2);

X(:,1) = bigz(:,TT);
X(:,2) = biga(:,TT);
X(:,3) = bige(:,TT);
X(:,4) = OCC;
X(:,5:6) = tenext;

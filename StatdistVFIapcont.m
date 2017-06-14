% Suppose in the beginning of period t agent has a,z,kappa and chooses to
% become self-employed, then shares Pr_int face interest rates r0, shares
% Peps_int face shocks eps and have accordingly cash-at hand given in
% Atilde, then the same proportions of the guys will choose corresponding
% a' so their choices need to be summed with weights Peps_int and Pr_int to
% get how much an ex-ante representative entrepreneur saves.

% So EAS gives the choice of assets on average given z,a,kappa for the
% average self-employed

F      = griddedInterpolant(z_array,a_array,kap_array,reshape(apgrid(IS),nz,na,...
    nkap),'linear');

TS     = reshape(F(z_arrayint,ATILDE,kap_arrayint),nz,na,nr,neps,nkap);

EAS     = reshape(sum(sum(TS .* Peps_int,4).* Pr_int,3),nz,na,nkap);

% W ES N
OCCINDEMP              = ones(nz,na,nkap);
OCCINDEMP(W>max(N,ES)) = 2;
OCCINDEMP(ES>max(W,N)) = 3;
OCCINDNEMP             = ones(nz,na,nkap);
OCCINDNEMP(ES>N)       = 3;


bige  = [bigeprobs zeros(NN,1)];


FW    = griddedInterpolant(z_array,a_array,kap_array,W);
FN    = griddedInterpolant(z_array,a_array,kap_array,N);
FS    = griddedInterpolant(z_array,a_array,kap_array,ES);
FEMP  = griddedInterpolant(z_array,a_array,kap_array,OCCINDEMP);
FNEMP = griddedInterpolant(z_array,a_array,kap_array,OCCINDNEMP);
FAPW  = griddedInterpolant(z_array,a_array,kap_array,apgrid(IW));
FAPN  = griddedInterpolant(z_array,a_array,kap_array,apgrid(IN));
FAPS  = griddedInterpolant(z_array,a_array,kap_array,EAS);


for tt = 1:TT

BIGZ = bigz(:,tt);
BIGA = biga(:,tt);
BIGE = bige(:,tt);

OCC  = ones(NN,1);

OCC(BIGE==2) = FEMP(BIGZ(BIGE==2),BIGA(BIGE==2),bigkap(BIGE==2));
OCC(BIGE==1) = FNEMP(BIGZ(BIGE==1),BIGA(BIGE==1),bigkap(BIGE==1));


% Locations where occupational choice unsure, between either 1,2 or 2,3 or
% 1,3. Hard to distinguish, so work with value functions
INDEX = find(floor(OCC) ~= OCC);
% Some won't have an opportunity to work, first find them and for them
% compare only N and S
EINDEX = BIGE(INDEX);

WORKINDEX = INDEX(EINDEX == 2);



TEMPW = FW(BIGZ(WORKINDEX),BIGA(WORKINDEX),bigkap(WORKINDEX));
TEMPN = FN(BIGZ(INDEX),BIGA(INDEX),bigkap(INDEX));
TEMPS = FS(BIGZ(INDEX),BIGA(INDEX),bigkap(INDEX));

TEMPOCC = ones(length(INDEX),1);
TEMPOCC(TEMPW>max(TEMPN(EINDEX==2),TEMPS(EINDEX==2))) = 2;
TEMPOCC(TEMPS>TEMPN & TEMPOCC~=2) = 3;

OCC(INDEX) = TEMPOCC;

BIGAP = zeros(NN,1);

BIGAP(OCC==1) = FAPN(BIGZ(OCC==1),BIGA(OCC==1),bigkap(OCC==1));
BIGAP(OCC==2) = FAPW(BIGZ(OCC==2),BIGA(OCC==2),bigkap(OCC==2));
BIGAP(OCC==3) = FAPS(BIGZ(OCC==3),BIGA(OCC==3),bigkap(OCC==3));

BIGAP(BIGAP<amin) = amin;
BIGAP(BIGAP>2e3)  = 2e3;

biga(:,tt+1) = BIGAP;


BIGE = zeros(NN,1);

BIGE(OCC==2 & bige(:,tt+1)>lambda) = 2;
BIGE(OCC==2 & bige(:,tt+1)<lambda) = 1;
BIGE(OCC~=2 & bige(:,tt+1)>mu) = 2;
BIGE(OCC~=2 & bige(:,tt+1)<mu) = 1;

bige(:,tt+1) = BIGE;

end

BIGZ = bigz(:,TT);
BIGA = biga(:,TT);
BIGE = bige(:,TT);





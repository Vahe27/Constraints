% Subsistence entrepreneurs' share in the economy

% For the subsistence versus opportunity entrepreneurs.

FW    = griddedInterpolant(z_array,a_array,prob_array,kap_array,W);
FN    = griddedInterpolant(z_array,a_array,prob_array,kap_array,N);
FS    = griddedInterpolant(z_array,a_array,prob_array,kap_array,ES);
FBN   = griddedInterpolant(z_array,a_array,prob_array,kap_array,EBN);
FBB   = griddedInterpolant(z_array,a_array,prob_array,kap_array,EBB);

WSEMP = FW(BIGZ(OCC==3),BIGA(OCC==3), bigprob(OCC==3),bigkap(OCC==3));
NSEMP = FN(BIGZ(OCC==3),BIGA(OCC==3), bigprob(OCC==3),bigkap(OCC==3));
SSEMP = FS(BIGZ(OCC==3),BIGA(OCC==3), bigprob(OCC==3),bigkap(OCC==3));

% All those who would like to work but don't have the opportunity
% WSEMP>SSEMP or are entrepreneurs but would prefer not to work instead of
% working SSEMP>NSEMP>WSEMP are subsistence entrepreneurs

subsempind = (((WSEMP>SSEMP) & (BIGE(OCC==3)==1))| NSEMP>WSEMP);
sharesubs  = sum(subsempind)/length(subsempind);
clear WSEMP NSEMP SSEMP

WBUS = FW(BIGZ(OCC==4),BIGA(OCC==4), bigprob(OCC==4),bigkap(OCC==4));
NBUS = FN(BIGZ(OCC==4),BIGA(OCC==4), bigprob(OCC==4),bigkap(OCC==4));
BNBUS = FBN(BIGZ(OCC==4),BIGA(OCC==4), bigprob(OCC==4),bigkap(OCC==4));
BBBUS = FBB(BIGZ(OCC==4),BIGA(OCC==4), bigprob(OCC==4),bigkap(OCC==4));

subbusind = ((WBUS>BBBUS & BIGE(OCC==4)==1)| NBUS>WBUS);
sharesubb = sum(subbusind)/length(subbusind);

sharesubsemp = (sum(subbusind) + sum(subsempind))/sum(OCC==3 |OCC==4);
sharesubtot  = (sum(subbusind) + sum(subsempind))/NN;

% Unemployed are those who would like to work but don't have the
% opportunity

WNON = FW(BIGZ(OCC==1),BIGA(OCC==1),bigprob(OCC==1),bigkap(OCC==1));
NNON = FN(BIGZ(OCC==1),BIGA(OCC==1),bigprob(OCC==1),bigkap(OCC==1));

unemp = sum(WNON>NNON & BIGE(OCC==1)==1)/NN;

semp  = sum(OCC==3 | OCC==4)/NN;

% Output and per capita output

ZS = BIGZ(OCC==3);
AS = BIGA(OCC==3);
ZB = BIGZ(OCC==4);
AB = BIGA(OCC==4);


YSN = (LDS==0).* ZS*varphi.*Gama.*((KDS==0).*savinvS + (KDS>0).*...
    (AS+KDS)).^alfa;
YSE = (LDS>0).*ZS*varphi.*((KDS==0).*savinvS + (KDS>0).*(AS+KDS)).^alfa...
    .*(LDS).^gama;

YBN = (LDB==0).* ZB.*Gama.*((KDB==0).*savinvB + (KDB>0).*...
    (AB+KDB)).^alfa;
YBE = (LDB>0).*ZB.*((KDB==0).*savinvB + (KDB>0).*(AB+KDB)).^alfa...
    .*(LDB).^gama;

percapout = (sum(YSN) + sum(YSE) + sum(YBN) + sum(YBE))/(NN*(LS+semp));

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

subsempind = (((WSEMP>SSEMP) & (BIGE(OCC==3)==1)));
sharesubs  = sum(subsempind)/length(subsempind);
clear WSEMP NSEMP SSEMP

WBUS = FW(BIGZ(OCC==4),BIGA(OCC==4), bigprob(OCC==4),bigkap(OCC==4));
NBUS = FN(BIGZ(OCC==4),BIGA(OCC==4), bigprob(OCC==4),bigkap(OCC==4));
BNBUS = FBN(BIGZ(OCC==4),BIGA(OCC==4), bigprob(OCC==4),bigkap(OCC==4));
BBBUS = FBB(BIGZ(OCC==4),BIGA(OCC==4), bigprob(OCC==4),bigkap(OCC==4));

subbusind = ((WBUS>BBBUS & BIGE(OCC==4)==1));
sharesubb = sum(subbusind)/length(subbusind);

sharesubsemp = (sum(subbusind) + sum(subsempind))/sum(OCC==3 |OCC==4);
sharesubtot  = (sum(subbusind) + sum(subsempind))/NN;

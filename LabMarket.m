X = laborcalcMCMC((Bigz(OCC==3)),Biga(OCC==3),zgrid,Agrid,agrid,r0,w0,...
    Pr,indhire,NN);

LD = X{1};
sempshare = X{2};
clear X

LS = sum(OCC==2)/NN;

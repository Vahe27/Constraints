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
         nz,na,neps,nprob,nkap);

EAS     = reshape(sum(TS(:,:,1:neps,:,:) .* probmtx,3),nz,na,nprob,nkap);

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

clear TS TBN TBB ATILDES ATILDEBN ATILDEBB 


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
biga  = [biga(:,1) zeros(NN,TT)];
POSB  = POSBSTAT;
AW    = apgrid(IW);
AN    = apgrid(IN);
%tic
%statitervalfown;
%toc
FW    = griddedInterpolant(z_array,a_array,prob_array,kap_array,W,'linear','none');
FN    = griddedInterpolant(z_array,a_array,prob_array,kap_array,N,'linear','none');
FS    = griddedInterpolant(z_array,a_array,prob_array,kap_array,ES,'linear','none');
FBN   = griddedInterpolant(z_array,a_array,prob_array,kap_array,EBN,'linear','none');
FBB   = griddedInterpolant(z_array,a_array,prob_array,kap_array,EBB,'linear','none');
FAPW  = griddedInterpolant(z_array,a_array,prob_array,kap_array,apgrid(IW),'linear','none');
FAPN  = griddedInterpolant(z_array,a_array,prob_array,kap_array,apgrid(IN),'linear','none');
FAPS  = griddedInterpolant(z_array,a_array,prob_array,kap_array,EAS,'linear','none');
FABN  = griddedInterpolant(z_array,a_array,prob_array,kap_array,EABN,'linear','none');
FABB  = griddedInterpolant(z_array,a_array,prob_array,kap_array,EABB,'linear','none');

statitervalf;

biga = biga(:,1);
clear bige   
BIGZ   = X(:,1);
BIGA   = X(:,2);
BIGE   = X(:,3);
OCC    = X(:,4);
TENOCC = reshape(X(:,5:6),NN/25,50);
OCCS = OCC(OCC==4 | OCC==3);
bigp = bigprob(OCC==4 | OCC==3);

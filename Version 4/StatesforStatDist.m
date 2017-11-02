% Case 1: The standard matrices for StatdistVFI

if CONTSTATDIST==0
bigz   = zstatdist([1:nz]', nz,PSI,NN,TT); 
bigkap = randsample([1:nkap]',NN,1,Pkap);

bigeprobs   = rand(NN,TT);
bigeprobs(bigeprobs(:,1)>0.5,1) = 1;
bigeprobs(bigeprobs(:,1)<=0.5,1) = 0;

bigeprobs(:,1) = bigeprobs(:,1)+1;

%biga = [randsample([1:nA/2],NN,1)',zeros(NN,TT-1)];
biga = [agrid(3)*ones(NN,1),zeros(NN,TT-1)];

occ  = zeros(NN,TT);
else
% Case 2: Try to make the Stationary Distribution calculation continuous

bigz = zdistcont(sigz, etta,PSI,NN,TT,ZDist,upperz);
bigkap = kapdistcont(ettakap,sigkap,NN,TT,KAPdist);

bigeprobs   = rand(NN,TT);
%bigeprobs(bigeprobs(:,1)>0.5,1) = 1;
%bigeprobs(bigeprobs(:,1)<=0.5,1) = 0;
%bigeprobs(:,1) = bigeprobs(:,1)+1;
bigeprobs(:,1) = randsample([1 2],NN,1,[0.15 0.85]);

%biga = [randsample(agrid(1:end),NN,1)',zeros(NN,TT-1)];
biga = [agrid(3)*ones(NN,1),zeros(NN,TT-1)];

occ = zeros(NN,TT);

bigprob = shockcont(mueps, sigeps, NN,EPSdist);


POSB = rand(NN,1);
POSB(POSB>0.95) = 4;
POSB(POSB<=0.95) = 3; % 4 if has access to business, 3 if no access


end
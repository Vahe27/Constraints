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

biga = [agrid(3)*ones(NN,1)];

occ = zeros(NN,TT);

bigprob = shockcont(mueps, sigeps, NN,EPSdist,upperp);


POSBSTAT = rand(NN,1);
POSBSTAT(POSBSTAT>0.999) = 4;
POSBSTAT(POSBSTAT<=0.999) = 3; % 4 if has access to business, 3 if no access
end

if compile_flag == 1


        cfg = coder.config('mex');
        cfg.GenerateReport = true;
        cfg.IntegrityChecks = false;
        cfg.ResponsivenessChecks = false;
        cfg.GlobalDataSyncMethod = 'NoSync'; 

codegen -config cfg loccalz -args {zgrid,bigz(:)}

end

zloc = reshape(int8(loccalz_mex(zgrid,bigz(:))),NN,TT,2);
zloc = permute(zloc,[1 3 2]);
ploc = loccal(P,bigprob);
kaploc = loccal(kapgrid,bigkap);


% Suppose in the beginning of period t agent has a,z,kappa and chooses to
% become self-employed, then shares Pr_int face interest rates r0, shares
% Peps_int face shocks eps and have accordingly cash-at hand given in
% Atilde, then the same proportions of the guys will choose corresponding
% a' so their choices need to be summed with weights Peps_int and Pr_int to
% get how much an ex-ante representative entrepreneur saves.

% So EAS gives the choice of assets on average given z,a,kappa for the
% average self-employed

F      = griddedInterpolant(z_array,a_array,kap_array,reshape(agrid(IS),nz,na,...
    nkap),'linear');

TS     = reshape(F(z_arrayint,ATILDE,kap_arrayint),nz,na,nr,neps,nkap);

EAS     = reshape(sum(sum(TS .* Peps_int,4).* Pr_int,3),nz,na,nkap);


temp      = [2 1 3];
W         = permute(W,temp);
N         = permute(N,temp);
S         = permute(ES,temp);
IW        = permute(reshape(IW,nz,na,nkap),temp);
IN        = permute(reshape(IN,nz,na,nkap),temp);  
AS        = permute(reshape(EAS,nz,na,nkap),temp); 
Aarray   = permute(a_array,temp);
Zarray   = permute(z_array,temp);
KAParray = permute(kap_array,temp);


F = griddedInterpolant(Aarray,Zarray,KAParray,W);
G = griddedInterpolant(Aarray,Zarray,KAParray,N);
H = griddedInterpolant(Aarray,Zarray,KAParray,S);

zarray = repmat(zgrid',nA,1);
zarray = repmat(zarray(:),nkap,1);
kaparray = repmat(kapgrid',nA*nz,1);
kaparray = kaparray(:);


WINT = reshape(F(repmat(Agrid',nz*nkap,1),zarray,kaparray(:)),nA,nz,nkap);
NINT = reshape(G(repmat(Agrid',nz*nkap,1),zarray,kaparray(:)),nA,nz,nkap);
SINT = reshape(H(repmat(Agrid',nz*nkap,1),zarray,kaparray(:)),nA,nz,nkap);

% The occupational choices depending on interpolated value functions. IF 1,
% then non-employed, if 2 then employed if 3 then self-employed
OCCW = WINT>max(NINT,SINT);
OCCS = SINT>max(WINT,NINT);
OCCN = NINT>max(WINT,SINT);
OCCTOTW = OCCN + OCCW*2 + OCCS*3;
OCCTOTN = (SINT>NINT)*2+1;
clear OCCW OCCS OCCN


F = griddedInterpolant(Aarray,Zarray,KAParray,agrid(IW));
AWINT = reshape(F(repmat(Agrid',nz*nkap,1),zarray,kaparray(:)),nA,nz,nkap);

F = griddedInterpolant(Aarray,Zarray,KAParray,agrid(IN));
ANINT = reshape(F(repmat(Agrid',nz*nkap,1),zarray,kaparray(:)),nA,nz,nkap);

F = griddedInterpolant(Aarray,Zarray,KAParray,AS);
ASINT = reshape(F(repmat(Agrid',nz*nkap,1),zarray,kaparray(:)),nA,nz,nkap);

ATEMP = repmat(Agrid,nA*nz,1);

IWINT = nan(nA*nz,nkap);
ININT = nan(nA*nz,nkap);
ISINT = nan(nA*nz,nkap);

for ii = 1:nkap
    X = AWINT(:,:,ii);
   [~,IWINT(:,ii)] = min(abs(repmat(X(:),1,nA) - ATEMP),[],2);
    X = ANINT(:,:,ii);
   [~,ININT(:,ii)] = min(abs(repmat(X(:),1,nA) - ATEMP),[],2);
   X = ASINT(:,:,ii);
   [~,ISINT(:,ii)] = min(abs(repmat(X(:),1,nA) - ATEMP),[],2);
end;
clear X

% The policy functions interpolated for a larger grid

IWINT = reshape(IWINT,nA,nz,nkap);
ININT = reshape(ININT,nA,nz,nkap);
ISINT = reshape(ISINT,nA,nz,nkap);

for ii =1:TT-1;

% bige=1 unemployed, bige=2 - employed

OCCIDX = nA*(bigkap-1)*nz + (bigz(:,ii)-1)*nA + biga(:,ii);
occ(bige(:,ii)==2,ii) = OCCTOTW(OCCIDX(bige(:,ii)==2));
occ(bige(:,ii)==1,ii) = OCCTOTN(OCCIDX(bige(:,ii)==1));

% Index for future assets is the same as the occupational one

% For the non-employed
biga(occ(:,ii)==1,ii+1) = ININT(OCCIDX(occ(:,ii)==1));
% For the workers
biga(occ(:,ii)==2,ii+1) = IWINT(OCCIDX(occ(:,ii)==2));
% For the semp
biga(occ(:,ii)==3,ii+1) = ISINT(OCCIDX(occ(:,ii)==3));

% with prob 1-mu I am offered a job next period, with prob mu, not
% with prob 1-lambda I stay at the job next period, with prob lambda, not

TEMP = bige(occ(:,ii)~=2,ii+1);
TEMP(TEMP>=mu) = 2;
TEMP(TEMP<mu)  = 1;
bige(occ(:,ii)~=2,ii+1) = TEMP;

TEMP = bige(occ(:,ii)==2,ii+1);
TEMP(TEMP>lambda) = 2;
TEMP(TEMP<lambda)  = 1;
bige(occ(:,ii)==2,ii+1) = TEMP;

clear TEMP

end;
toc

Biga = biga(:,end-1);
Bige = bige(:,end-1);
Bigz = bigz(:,end);
Bigkap = bigkap(:,end);
OCC  = occ(:,end-1);
















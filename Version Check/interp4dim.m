function yf = interp4dim(z,a,zind,probind,kapind,V,X,Y,zv,av,probd,kapd)
%{
 z-zgrid
a-agrid
zind-zloc
probind-probloc
kapind-kaploc
V-Valfunc
zv-BIGZ
av-BIGA
probd-(bigprob-P(imin))/(P(imax)-P(imin))
kapd-(bigkap-kapgrid(imin))/(kapgrid(imax)-kapgrid(imin))
%}

% I assume I know already the brackets for z, p shock and kappa, which
% means I only need to find the brackets for a, given BIGA.


% (1) Calculate the locations of a

na  = length(a);  % num of grid points
nav = length(av); % num of interpolation points
amax = na;
amin = 1;
avloc = zeros(nav,2);
zd    = zeros(nav,1);
ad    = zd;
y     = zeros(nav,1);
yy=y;
yyy =y;
%{
while amax>amin+1

tempn = floor((amax+amin)/2);

if av(1)>a(tempn)
    amin = tempn;
else
    amax = tempn;
end
 end
 
 avloc(1,:) = [amin amax];
 zd(1)      = (zv(1) - z(zind(1,1)))/(z(zind(1,2)) - z(zind(1,1)));
 ad(1)      = (av(1) - a(amin(1)))/(a(amax(1)) - a(amin(1)));

 
%yv(1) = z(indmin) + dzdx(indmax)*(xv(1)-x(indmin));
%}

for jj = 1:nav

if jj>1
 if av(jj)>av(jj-1)
     amax = na;
     %amin = tempn;

 else
     %amax = tempn;
     amin = 1;
 end
 end
 
 while amax>amin+1

tempn = floor((amax+amin)/2);

if av(jj)>a(tempn)
    amin = tempn;
else
    amax = tempn;
end
 end
 
 avloc(jj,:) = [amin amax];
 zd(jj)      = (zv(jj) - z(zind(jj,1)))/(z(zind(jj,2)) - z(zind(jj,1)));
 ad(jj)      = (av(jj) - a(amin))/(a(amax) - a(amin));
 izd = 1-zd(jj);


% (2) convex for z
C000 = izd*V(zind(jj,1),avloc(jj,1),probind(jj,1),kapind(jj,1)) + ...
    zd(jj)*V(zind(jj,2),avloc(jj,1),probind(jj,1),kapind(jj,1));

C100 = izd*V(zind(jj,1),avloc(jj,2),probind(jj,1),kapind(jj,1)) + ...
    zd(jj)*V(zind(jj,2),avloc(jj,2),probind(jj,1),kapind(jj,1));

C010 = izd*V(zind(jj,1),avloc(jj,1),probind(jj,2),kapind(jj,1)) + ...
    zd(jj)*V(zind(jj,2),avloc(jj,1),probind(jj,2),kapind(jj,1));

C001 = izd*V(zind(jj,1),avloc(jj,1),probind(jj,1),kapind(jj,2)) + ...
    zd(jj)*V(zind(jj,2),avloc(jj,1),probind(jj,1),kapind(jj,2));

C110 = izd*V(zind(jj,1),avloc(jj,2),probind(jj,2),kapind(jj,1)) + ...
    zd(jj)*V(zind(jj,2),avloc(jj,2),probind(jj,2),kapind(jj,1));

C101 = izd*V(zind(jj,1),avloc(jj,2),probind(jj,1),kapind(jj,2)) + ...
    zd(jj)*V(zind(jj,2),avloc(jj,2),probind(jj,1),kapind(jj,2));

C011 = izd*V(zind(jj,1),avloc(jj,1),probind(jj,2),kapind(jj,2)) + ...
    zd(jj)*V(zind(jj,2),avloc(jj,1),probind(jj,2),kapind(jj,2));

C111 = izd*V(zind(jj,1),avloc(jj,2),probind(jj,2),kapind(jj,2)) + ...
    zd(jj)*V(zind(jj,2),avloc(jj,2),probind(jj,2),kapind(jj,2));

% (3) Next convex for a
iad = 1-ad(jj);

C00 = iad*C000 + ad(jj)*C100;
C01 = iad*C001 + ad(jj)*C101;

C10 = iad*C010 + ad(jj)*C110;
C11 = iad*C011 + ad(jj)*C111;

% (4) Next convex for prob
iprobd = 1-probd(jj);

C0 = iprobd*C00 + probd(jj)*C10;
C1 = iprobd*C01 + probd(jj)*C11;

% (5) Final convex for kappa
y(jj) = (1-kapd(jj))*C0 + kapd(jj)*C1;

% FOR X
% (2) convex for z
C000 = izd*X(zind(jj,1),avloc(jj,1),probind(jj,1),kapind(jj,1)) + ...
    zd(jj)*X(zind(jj,2),avloc(jj,1),probind(jj,1),kapind(jj,1));

C100 = izd*X(zind(jj,1),avloc(jj,2),probind(jj,1),kapind(jj,1)) + ...
    zd(jj)*X(zind(jj,2),avloc(jj,2),probind(jj,1),kapind(jj,1));

C010 = izd*X(zind(jj,1),avloc(jj,1),probind(jj,2),kapind(jj,1)) + ...
    zd(jj)*X(zind(jj,2),avloc(jj,1),probind(jj,2),kapind(jj,1));

C001 = izd*X(zind(jj,1),avloc(jj,1),probind(jj,1),kapind(jj,2)) + ...
    zd(jj)*X(zind(jj,2),avloc(jj,1),probind(jj,1),kapind(jj,2));

C110 = izd*X(zind(jj,1),avloc(jj,2),probind(jj,2),kapind(jj,1)) + ...
    zd(jj)*X(zind(jj,2),avloc(jj,2),probind(jj,2),kapind(jj,1));

C101 = izd*X(zind(jj,1),avloc(jj,2),probind(jj,1),kapind(jj,2)) + ...
    zd(jj)*X(zind(jj,2),avloc(jj,2),probind(jj,1),kapind(jj,2));

C011 = izd*X(zind(jj,1),avloc(jj,1),probind(jj,2),kapind(jj,2)) + ...
    zd(jj)*X(zind(jj,2),avloc(jj,1),probind(jj,2),kapind(jj,2));

C111 = izd*X(zind(jj,1),avloc(jj,2),probind(jj,2),kapind(jj,2)) + ...
    zd(jj)*X(zind(jj,2),avloc(jj,2),probind(jj,2),kapind(jj,2));

% (3) Next convex for a
%iad = 1-ad(jj);

C00 = iad*C000 + ad(jj)*C100;
C01 = iad*C001 + ad(jj)*C101;

C10 = iad*C010 + ad(jj)*C110;
C11 = iad*C011 + ad(jj)*C111;

% (4) Next convex for prob
%iprobd = 1-probd(jj);

C0 = iprobd*C00 + probd(jj)*C10;
C1 = iprobd*C01 + probd(jj)*C11;

% (5) Final convex for kappa
yy(jj) = (1-kapd(jj))*C0 + kapd(jj)*C1;

% FOR Y
% (2) convex for z
C000 = izd*Y(zind(jj,1),avloc(jj,1),probind(jj,1),kapind(jj,1)) + ...
    zd(jj)*Y(zind(jj,2),avloc(jj,1),probind(jj,1),kapind(jj,1));

C100 = izd*Y(zind(jj,1),avloc(jj,2),probind(jj,1),kapind(jj,1)) + ...
    zd(jj)*Y(zind(jj,2),avloc(jj,2),probind(jj,1),kapind(jj,1));

C010 = izd*Y(zind(jj,1),avloc(jj,1),probind(jj,2),kapind(jj,1)) + ...
    zd(jj)*Y(zind(jj,2),avloc(jj,1),probind(jj,2),kapind(jj,1));

C001 = izd*Y(zind(jj,1),avloc(jj,1),probind(jj,1),kapind(jj,2)) + ...
    zd(jj)*Y(zind(jj,2),avloc(jj,1),probind(jj,1),kapind(jj,2));

C110 = izd*Y(zind(jj,1),avloc(jj,2),probind(jj,2),kapind(jj,1)) + ...
    zd(jj)*Y(zind(jj,2),avloc(jj,2),probind(jj,2),kapind(jj,1));

C101 = izd*Y(zind(jj,1),avloc(jj,2),probind(jj,1),kapind(jj,2)) + ...
    zd(jj)*Y(zind(jj,2),avloc(jj,2),probind(jj,1),kapind(jj,2));

C011 = izd*Y(zind(jj,1),avloc(jj,1),probind(jj,2),kapind(jj,2)) + ...
    zd(jj)*Y(zind(jj,2),avloc(jj,1),probind(jj,2),kapind(jj,2));

C111 = izd*Y(zind(jj,1),avloc(jj,2),probind(jj,2),kapind(jj,2)) + ...
    zd(jj)*Y(zind(jj,2),avloc(jj,2),probind(jj,2),kapind(jj,2));

% (3) Next convex for a
%iad = 1-ad(jj);

C00 = iad*C000 + ad(jj)*C100;
C01 = iad*C001 + ad(jj)*C101;

C10 = iad*C010 + ad(jj)*C110;
C11 = iad*C011 + ad(jj)*C111;

% (4) Next convex for prob
%iprobd = 1-probd(jj);

C0 = iprobd*C00 + probd(jj)*C10;
C1 = iprobd*C01 + probd(jj)*C11;

% (5) Final convex for kappa
yyy(jj) = (1-kapd(jj))*C0 + kapd(jj)*C1;

end

yf = [y yy yyy];



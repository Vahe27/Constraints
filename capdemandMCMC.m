function y = capdemandMCMC(z,a,zg,Ag,BorK,N);

% Created: 20.05.2017
% Last Update: ----

% Using the outcome from the MCMC simulation, use the z and a, which are
% vectors of the managerial talents and assets of those who become
% self-employed, to calculate the capital demand in the market for a given
% vector r0. Here zg and Ag are the zgrid and Agrid (for MCMC) and BorK is
% the matrix of amount borrowed for a given set (z,a)

n = size(z,1);
nz = size(zg,1);
nA = size(Ag,2);

index = (a-1)*nz + z;

KD = sum(BorK(index))/N;


y = abs(KD);


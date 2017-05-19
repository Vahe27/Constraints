% Calculate the capital demand using the output from profitcalc. adjust it
% in a way that it accepts also a flag that if equal to 0 does only
% calculation of profits, if equal to 1, only calculates the capital
% demand

Capflag = 1;
BorrowK = profitcalc(zgrid,Agrid,r0,w0,Capflag);

BorrowK = sum(permute(BorrowK,[1 3 2]).*repmat(Pr',1,1,nA),2);
% Calculate the average tenure at work, for that you need a sample from
% CUROCC, which is x in this calculation, you need to drop 0s and calculate
% the means

% The time period I take from a single agent is 50, so given that in total
% I extract two columns of NNx1 size data, I have data for NN*2/50
% individuals, or NN/25
TENOCC(TENOCC~=2) = 0;
meks    = ones(NN/25,1);
xx      = zeros(NN/25,270);
xx(:,1) = TENOCC(:,1)==2;

for ii = 2:50
    AA = TENOCC(:,ii);
    BB = TENOCC(:,ii-1);
    temp = (AA==2 & BB==2) | (AA==2 & BB==0);
    meks(~temp) = meks(~temp)+1;
    temp2 = xx([1:NN/25]'+(meks-1)*NN/25);
    temp2(temp) = temp2(temp)+1;
    xx([1:NN/25]'+(meks-1)*NN/25) =temp2;
  
end

avgworktenure = mean(xx(xx>0));


clear xx TENOCC temp temp2 AA BB meks
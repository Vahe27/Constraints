function y = profitcalc(z,a,r,w)

global r_bar deltta alfa nu gama

X(:,:,1) = 


% First calculate the optimal capital for each talent z, given interest
% rate r_bar, next, those with optimal capital more than their assets, will
% borrow, find them and find how much they will borrow and calcualte profit
capital = (gama^gama/((1+gama)^(1+gama)))^(1/(1-alfa))*((r_bar+deltta)/alfa)...
    ^(1/(alfa-1)).*z.^(1/(1-alfa));

capital = repmat(capital,1,n_a);

invest_semp(:,:,1) = ((deltta+r)/alfa)^(1/(alfa-1)) * (((1+gama)^(1+gama))/...
  (gama^gama))^(1/(alfa-1))*repmat(z.^(1/(1-alfa)),1,n_a);
invest_semp(:,:,2) = (repmat(agrid,n_z,1)>=capital).*capital; 

% There are three types of agents: first are those who have enough capital
% under rbar, so they will never borrow even if r=rbar, second are those
% who'd borrow under rbar but won't under r, then they will operate firms
% with no borrowing x=0, lastly, those who'd borrow under r (x>0). The
% borrowing choices of the first 2 types are given in invest_semp(:,:,2)
% and the borrowing choices of the 3rd group are given in
% invest_semp(:,:,1). The idea is that for the second group MPK(x+a)>rbar
% but MPK(x+a)<r

invest_semp(:,:,1) = (repmat(agrid,n_z,1)<invest_semp(:,:,1)).*invest_semp(:,:,1);
invest_semp(:,:,2) = invest_semp(:,:,2) + (invest_semp(:,:,1)==0).*...
    (invest_semp(:,:,2)==0).*repmat(agrid,n_z,1);

profit_semp(:,:,1) = gama^gama/((1+gama)^(1+gama)).*repmat(z,1,n_a).*...
    invest_semp(:,:,1).^alfa - (r+deltta).*(invest_semp(:,:,1)-repmat(agrid,n_z,1))...
    + repmat(agrid*(1-deltta),n_z,1);

profit_semp(:,:,1) = profit_semp(:,:,1).*(invest_semp(:,:,1)>0);

profit_semp(:,:,2) = gama^gama/((1+gama)^(1+gama)).*repmat(z,1,n_a).*...
    invest_semp(:,:,2).^alfa + (1-deltta)*invest_semp(:,:,2) - (1+r_bar)...
    *(invest_semp(:,:,2) - repmat(agrid,n_z,1)); 

profit_semp(:,:,2) = profit_semp(:,:,2).*(invest_semp(:,:,2)>0);

inc_semp = profit_semp(:,:,1) + profit_semp(:,:,2);
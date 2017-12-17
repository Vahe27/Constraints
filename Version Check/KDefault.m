function y = KDefault(z,a,K,Kindex,r,w,Y,epsilon,P,nk)

global xi

% Created: 30.06.2017
% Last Update: ---

% This function calculates for each individual how much of the borrowed
% ammount he defaults on, given the probability of the shock and its value
% and given what level of capital the individual has borrowed (Update of
% the model, where the intermediary doesn't only see the signal, but also
% the amount borrowed)
nn   = length(z);
ne   = length(epsilon);
nr   = size(r,1);
KLENT = zeros(nr,nk);
KDEF = zeros(nr,nk);

income = repmat(Y,1,1,ne);

incS = income - repmat(reshape(epsilon,1,1,ne),nn,nr,1);
DEFINDEX = incS<xi;


DEFCAP = sum((DEFINDEX.*repmat(K,1,1,ne)).* repmat(reshape(P,1,1,ne),nn,nr,1),3);

y = DEFCAP;
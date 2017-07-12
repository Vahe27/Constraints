function y = CapDefault(z,a,K,INDEX,r,w,Y,epsilon,P);

global Gama alfa gama deltta xi

% Created: 12.06.2017
% Last Update: ---

% This function calculates for each individual how much of the borrowed
% ammount he defaults on, given the probability of the shock and its value
nn = length(z);
ne = length(epsilon);
nr = length(r);
income = zeros(nn,nr,ne);

%{
income = zeros(nn,3);
L      = zeros(nn,3);


A = repmat(a,1,3);
Z = repmat(z,1,3);
R = repmat(1+r,nn,1);


invest = A+abs(K);



% The profit if choose not to hire
income(INDEX==0) = Gama * Z(INDEX==0) .* (invest(INDEX==0).^ alfa) + ...
    (1 - deltta) * invest(INDEX==0) + K(INDEX==0).*R(INDEX==0);


L(INDEX==1) = (gama/w)^(1/(1-gama)) * Z(INDEX==1).^(1/(1-gama)) .* ...
    (invest(INDEX==1).^(alfa/(1-gama)));


income(INDEX==1) = Z(INDEX==1) .* invest(INDEX==1).^(alfa) .*...
    L(INDEX==1).^(gama) - w*L(INDEX==1) + K(INDEX==1).*R(INDEX==1) + ...
    (1-deltta)*invest(INDEX==1);
    
income = repmat(income,1,1,ne);
incomeS = income - repmat(reshape(epsilon,1,1,ne),nn,nr,1);

DEFINDEX = incomeS < xi;

DEFCAP = sum((DEFINDEX.*repmat(K,1,1,ne)).* repmat(reshape(P,1,1,ne),nn,nr,1),3);
y = DEFCAP;
%}
income = repmat(Y,1,1,ne);

incS = income - repmat(reshape(epsilon,1,1,ne),nn,nr,1);
DEFINDEX = incS<xi;


DEFCAP = sum((DEFINDEX.*repmat(K,1,1,ne)).* repmat(reshape(P,1,1,ne),nn,nr,1),3);
y = DEFCAP;

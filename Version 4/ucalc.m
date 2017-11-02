function y = ucalc(cons, sigma)

% Created 13.04.2017
% Last Update ----

% The function calculates utility based on the level of consuption

if sigma == 1
    
    y = log(cons);
    y(cons<=0) = -500;
    
   
else
    y = cons.^(1-sigma)/(1-sigma);
    y(cons<=0) = -500;
    
    end
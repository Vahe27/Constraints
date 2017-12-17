function y = mcalc(x,z,r,w,gama,alfa,deltta)

nu = gama+alfa;


y = -(1-x(1))*z*x(2)^alfa*(x(1)+x(3))^gama + w*x(3) + (r+deltta)*x(2);

function y = PIown(z,inv,payk,alfa,deltta,Gama,n)


y = zeros(n*200,1);

y = Gama*z.* inv.^alfa + (1-deltta) * inv - payk;

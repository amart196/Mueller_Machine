function alpha=alphafixed(p,Lam)
lam2 = Lam.^2;
alpha = Lam.^3*(p(1))./(lam2 - 155^2).^2;
end
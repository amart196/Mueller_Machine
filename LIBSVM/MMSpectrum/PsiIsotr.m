function [Psi,K] = PsiIsotr(layer,AOI,Lam)

n = MaterialLib_iso(layer{1},Lam);
d = layer{2};
eul = layer{3}*pi/180;

for m = 1:length(Lam);
    for phi = 1:length(AOI)
        Psi(:,:,m) = [cos(AOI(phi)),0,-cos(AOI(phi)),0;n(m),0,n(m),0;0,1,0,1;0,n(m)*cos(AOI(phi)),0,-n(m)*cos(AOI(phi))];
        q = exp(sqrt(n(m)^2 - (sin(AOI(phi)))^2)*2*pi*d*1i/Lam(m));
        K(:,m) = [q,q,1/q,1/q];

end
end
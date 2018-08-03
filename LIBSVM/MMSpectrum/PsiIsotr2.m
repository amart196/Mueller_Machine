function [Psi,K] = PsiIsotr2(layer,AOI,Lam,azimuth)

n = MaterialLib_iso(layer{1},Lam);
d = layer{2};

for lam = 1:length(Lam);
    for phi = 1:length(AOI)
        Psitemp = [cos(AOI(phi)),0,-cos(AOI(phi)),0;n(lam),0,n(lam),0;0,1,0,1;0,n(lam)*cos(AOI(phi)),0,-n(lam)*cos(AOI(phi))];
        q = exp(sqrt(n(lam)^2 - (sin(AOI(phi)))^2)*2*pi*d*1i/Lam(lam));
        Ktemp = [q,q,1/q,1/q];
        for theta = 1:length(azimuth)
            Psi(:,:,lam,phi,theta) = Psitemp;
            K(:,lam,phi,theta) = Ktemp;
        end
    end
end
end
function layerMatrix = layerCoher_iso(layer,AOI,Lam)

epsilon = MaterialLib_iso(layer{1},Lam).^2;
d = layer{2};
layerMatrix = zeros(4,4,length(Lam));
for m = 1:length(Lam);
q = sqrt(epsilon(m)-sin(AOI)^2);
arg = q*2*pi*d/Lam(m);
C = cos(arg);
S = 1i*sin(arg);
qS = q*S;
Sq = S/q;
layerMatrix(:,:,m) = [C,qS/epsilon(m),0,0 ; epsilon(m)*Sq,C,0,0 ; 0,0,C,Sq ; 0,0,qS,C];

end
end

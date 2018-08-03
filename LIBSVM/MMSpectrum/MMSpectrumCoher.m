function MM = MMSpectrumCoher(layerArray,Lam,AOI,bool_reflect,bool_normalize,pHandles)

AOI = AOI*pi/180;
A = [1,0,0,1;1,0,0,-1;0,1,1,0;0,1i,-1i,0];
Ainv = [0.5,0.5,0,0;0,0,0.5,-0.5*1i;0,0,0.5,0.5*1i;0.5,-0.5,0,0];
Nlayers = size(layerArray,2);
Nlam = length(Lam);
layerMat = zeros(4,4,Nlam,Nlayers-2);

if layerArray{1}{5} == 0;
    [Psi_i,~] = PsiAniso(layerArray{1},AOI,Lam);
else
    [Psi_i,~] = PsiIsotr(layerArray{1},AOI,Lam);
end

if layerArray{Nlayers}{5} == 0;
    [Psi_e,~] = PsiAniso(layerArray{Nlayers},AOI,Lam);
else
    [Psi_e,~] = PsiIsotr(layerArray{Nlayers},AOI,Lam);
end

for m = 1:Nlayers-2
    if layerArray{m+1}{5} == 0;
        layerMat(:,:,:,m) = layerCoher(layerArray{m+1},AOI,Lam);
    else
        layerMat(:,:,:,m) = layerCoher_iso(layerArray{m+1},AOI,Lam);
    end
end

MM = zeros(4,4,Nlam);

for m = 1:Nlam
    P = eye(4);
    for k = 1:(Nlayers-2)
        P = squeeze(layerMat(:,:,m,Nlayers-1-k))*P;
    end
    P = inv(Psi_i(:,:,m))*P*Psi_e(:,:,m);
        if bool_reflect == true
            J =  P([3 4],[1 2])/(P([1 2],[1 2]));
        else
            J = inv(P([1 2],[1 2]));
        end
    MM(:,:,m) =  real(A*kron(J,conj(J))*Ainv);
end
if bool_normalize == true
    for n = 1:Nlam
    MM(:,:,n) = MM(:,:,n)/squeeze(MM(1,1,n));
    end
end
    for n=1:16
    pHandles(n)=subplot(4,4,n);
    hold on
    end
for j = 1:4
    for k = 1:4
        plot(pHandles(k+4*(j-1)),Lam,squeeze(MM(j,k,:)))
        axis(pHandles(k+4*(j-1)),'tight')
    end
end
end
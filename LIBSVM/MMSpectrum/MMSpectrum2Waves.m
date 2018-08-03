function MM = MMSpectrum2Waves(layerArray,Lam,AOI,bool_reflect,delta_lam,color)

AOI = AOI*pi/180;
Nlayers = size(layerArray,2);
Nlam = length(Lam);
thin = zeros(Nlayers,1);
for k=1:Nlayers
thin(k) = layerArray{k}{4};
end
g = find(thin == 0);

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

if g > 2                             %if there are thin layers before thick one, compute layer matrices 
    layerMat_i = zeros(4,4,Nlam,g-2);
    for m = 1:g-2
        layerArray{m+1}{2} = -layerArray{m+1}{2};       %change sign of d to invert layer matrix
        if layerArray{m+1}{5} == 0;                     %check if layer is anisotropic
            layerMat_i(:,:,:,m) = layerCoher(layerArray{m+1},AOI,Lam);  %anisotropic 
        else
            layerMat_i(:,:,:,m) = layerCoher_iso(layerArray{m+1},AOI,Lam); %isotropic
        end
    end
    Psi0 = zeros(4,4,Nlam);
    for m = 1:Nlam
        P = eye(4);
        for k = 1:g-2
            P = squeeze(layerMat_i(:,:,m,k))*P;
        end
        Psi0(:,:,m) = P*Psi_i(:,:,m);
    end
else
        Psi0 = Psi_i;
end

if Nlayers - g > 1                             %if there are thin layers after thick one, compute layer matrices 
    layerMat_e = zeros(4,4,Nlam,Nlayers - g - 1);
    for m = 1:Nlayers - g - 1
        if layerArray{Nlayers-m}{5} == 0;                     %check if layer is anisotropic
            layerMat_e(:,:,:,m) = layerCoher(layerArray{Nlayers-m},AOI,Lam);  %anisotropic calculation
        else
            layerMat_e(:,:,:,m) = layerCoher_iso(layerArray{Nlayers-m},AOI,Lam); %isotropic calculation
        end
    end
    Psi2 = zeros(4,4,Nlam);
    for m = 1:Nlam
        P = eye(4);
        for k = 1:Nlayers - g - 1
            P = squeeze(layerMat_e(:,:,m,k))*P;
        end
        Psi2(:,:,m) = P*Psi_e(:,:,m);
    end
else
        Psi2 = Psi_e;
end

MM = FiveWaves(Psi0,Psi2,layerArray{g},Lam,AOI,bool_reflect,delta_lam);

for n = 1:Nlam
MM(:,:,n) = MM(:,:,n)/squeeze(MM(1,1,n));
end

%color = rand(1,3);
for j = 1:4
    for k = 1:4
        hold on
        subplot(4,4,k+4*(j-1))
        plot(1239.8./Lam,squeeze(MM(j,k,:)),'Color',color)
        axis tight
    end
end
end
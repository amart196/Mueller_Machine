function MM = MMSpectrumPW2(layerArray,Lam,AOI,bool_reflect)

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

MM = PartialWave(Psi0,Psi2,layerArray{g},Lam,AOI,bool_reflect);

for j = 1:4
    for k = 1:4
        subplot(4,4,k+4*(j-1))
        plot(Lam,squeeze(MM(j,k,:)))
    end
end


function layerMatrix = layerCoher(layer,AOI,Lam)

%   epsilon and alpha: 3x3 constitutive tensors in the standard setting. 
%   eul: array of ZXZ passive euler angles to rotate the tensors, in radians.
%   AOI: incident angle, in radians

[epsilon,alpha,mu] = MaterialLib(layer{1},Lam);
d = layer{2};
eul = layer{3}*pi/180;
layerMatrix = zeros(4,4,k);

if alpha == 0
    alpha = zeros(3,3,k);
else
    alpha = 1i*alpha;
end

[Psi,K] = berr(epsilon,alpha,mu,eul,AOI);
for n = 1:Nlam
layerMatrix(:,:,n) = Psi(:,:,n)*diag(exp(K(:,n))*2*pi*d*1i/Lam(n))/Psi(:,:,n);
end
end

function layerMatrix = layerCoher_iso(layer,AOI,Lam)

n = MaterialLib_iso(layer{1},Lam);
d = layer{2};

for m = 1:Nlam;
Psi = [cos(AOI),0,-cos(AOI),0;n(m),0,n(m),0;0,1,0,1;0,n(m)*cos(AOI),0,-n(m)*cos(AOI)];
q = exp(sqrt(n(m)^2 - (sin(AOI))^2)*2*pi*d*1i/Lam(m));
K = [q,q,1/q,1/q];
layerMatrix(:,:,m) = inv(Psi)*diag(exp(diag(K)*2*pi*d*1i/Lam(n)))*Psi;

end
end

function [Psi,K] = berr(epsilon,alpha,mu,eul,AOI)
for n = 1:Nlam
A = [cos(eul(3)),sin(eul(3)),0;-sin(eul(3)),cos(eul(3)),0;0,0,1]...
    *[1,0,0;0,cos(eul(2)),sin(eul(2));0,-sin(eul(2)),cos(eul(2))]...
    *[cos(eul(1)),sin(eul(1)),0;-sin(eul(1)),cos(eul(1)),0;0,0,1];
A = transpose(A);
R = [A,zeros(3,3);zeros(3,3),A];
kx = sin(AOI);
M = R*[diag(epsilon(:,n)),-alpha(:,:,n);transpose(alpha(:,:,n)),...
    diag(mu(:,n))]*transpose(R);
A1 = [M(3,1),M(3,5)+kx;M(6,1),M(6,5)];
A2 = [M(3,2),-M(3,4);M(6,2)-kx,M(6,4)];
B1 = [M(5,3)+kx,M(5,6);M(1,3),M(1,6)];
B2 = [M(4,3),M(4,6);-M(2,3),-M(2,6)+kx];
C1 = inv(M([3 6],[3 6]));
D1 = M([5 1],[1 5]);
D2 = [M(5,2),-M(5,4);M(1,2),-M(1,4)];
D3 = [M(4,1),M(4,5);-M(2,1),-M(2,5)];
D4 = [M(4,2),-M(4,4);-M(2,2),M(2,4)];
delta = [-B1*C1*A1+D1,-B1*C1*A2+D2;B2*C1*A1-D3,B2*C1*A2-D4];
[Psi(:,:,n),K] = eig(delta);
K(:,n) = diag(K);
end
end

function [Psi_out,Kdiag_out] = PsiAniso(layer,AOI,Lam)

%   epsilon and alpha: 3x3 constitutive tensors in the standard setting. 
%   eul: array of ZXZ passive euler angles to rotate the tensors, in radians.
%   AOI: incident angle, in radians

[epsilon,alpha,mu] = MaterialLib(layer{1},Lam);
d = layer{2};
eul = layer{3}*pi/180;

if alpha == 0
    alpha = zeros(3,3,length(Lam));
else
    alpha = 1i*alpha;
end

[Psi,K] = berr(epsilon,alpha,mu,eul,AOI);
for n = 1:Nlam
list1 = find(K(:,n) > 0);
list2 = find(K(:,n) < 0);
if K(list1(1),n) < K(list1(2),n)
    list1 = fliplr(list1);
end
if K(list2(1),n) > K(list2(2),n)
    list2 = fliplr(list2);
end
Kdiag_out(:,n) = exp([K(list1(1),n),K(list1(2),n),K(list2(1),n),K(list2(2),n)]...
    *2*pi*d*1i/Lam(n));
Psi_out(:,:,n) = [Psi(:,list1(1),n),Psi(:,list1(2),n),Psi(:,list2(1),n),Psi(:,list2(2),n)];
end
end

function [Psi,K] = PsiIsotr(layer,AOI,Lam)

n = MaterialLib_iso(layer{1},Lam);
d = layer{2};
eul = layer{3}*pi/180;
for m = 1:Nlam
Psi(:,:,m) = [cos(AOI),0,-cos(AOI),0;n(m),0,n(m),0;0,1,0,1;0,n(m)*cos(AOI),0,-n(m)*cos(AOI)];
q = exp(sqrt(n(m)^2 - (sin(AOI))^2)*2*pi*d*1i/Lam(m));
K(:,m) = [q,q,1/q,1/q];
end
end

function MM = PartialWave(Psi0,Psi2,layer,Lam,AOI,bool_reflect)
Ainv = [0.5,0.5,0,0;0,0,0.5,-0.5*1i;0,0,0.5,0.5*1i;0.5,-0.5,0,0];
A = [1,0,0,1;1,0,0,-1;0,1,1,0;0,1i,-1i,0];
MM = zeros(4,4,Nlam);
[Psi1,K] = PsiAniso(layer,AOI,Lam);
for m = 1:Nlam
    
P1 = diag([1/K(1,n),1/K(2,n)]);
P2 = K([3,n],[3,n]);
invPsi1 = inv(Psi1(:,:,n));
Int01 = inv(Psi0(:,:,n))*Psi1(:,:,n);
Int12 = invPsi1(:,:,n)*Psi2(:,:,n);
Int10 = invPsi1(:,:,n)*Psi0(:,:,n);
T01 = inv(Int01([1,2],[1,2]));
R01 = Int01([3,4],[1,2])*T01;
T12 = inv(Int12([1,2],[1,2]));
R12 = Int12([3,4],[1,2])*T12;
T10 = inv(Int10([3,4],[3,4]));
R10 = Int10([1,2],[3,4])*T10;
P1 = kron(P1,conj(P1));
P2 = kron(P2,conj(P2));
T01 = kron(T01,conj(T01));
R01 = kron(R01,conj(R01));
T12 = kron(T12,conj(T12));
R12 = kron(R12,conj(R12));
T10 = kron(T10,conj(T10));
R10 = kron(R10,conj(R10));
if bool_reflect == true
    MM(:,:,n) = real(A*(R01+T10*P2*R12*P1*inv(eye(4) - R10*P2*R12*P1)*T01)*Ainv);
else
    MM(:,:,n) = real(A*T12*P1*inv(eye(4) - R10*P2*R12*P1)*T01*inv(A));
end
end
end

end
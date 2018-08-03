function [Psi_out,Kdiag_out] = PsiAniso2(layer,AOI,Lam,azimuth)

%   epsilon and alpha: 3x3 constitutive tensors in the standard setting. 
%   eul: array of ZXZ passive euler angles to rotate the tensors, in radians.
%   AOI: incident angle, in radians

[epsilon,alpha,mu] = MaterialLib(layer{1},Lam);
d = layer{2};

for theta=1:length(azimuth)
    eul = layer{3}*pi/180;
    eul(1) = eul(1) + azimuth(theta);
    Eul = [cos(eul(3)),sin(eul(3)),0;-sin(eul(3)),cos(eul(3)),0;0,0,1]...
        *[1,0,0;0,cos(eul(2)),sin(eul(2));0,-sin(eul(2)),cos(eul(2))]...
        *[cos(eul(1)),sin(eul(1)),0;-sin(eul(1)),cos(eul(1)),0;0,0,1];
    Eul = transpose(Eul);
    R(:,:,theta) = [Eul,zeros(3,3);zeros(3,3),Eul];
end

if alpha == 0
    alpha = zeros(3,3,Nlam);
else
    alpha = 1i*alpha;
end
for lam = 1:Nlam
    for phi = 1:length(AOI)
        kx = sin(AOI(phi));
        for theta = 1:length(azimuth)
            M = R(:,:,theta)*[diag(epsilon(:,lam)),-alpha(:,:,lam);transpose(alpha(:,:,lam)),...
                diag(mu(:,lam))]*transpose(R(:,:,theta));
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
            [Psi,K] = eig(delta);
            Kdiag = diag(K);
            list1 = find(Kdiag > 0);
            list2 = find(Kdiag < 0);
            if Kdiag(list1(1)) < Kdiag(list1(2))
                list1 = fliplr(list1);
            end
            if Kdiag(list2(1)) > Kdiag(list2(2))
                list2 = fliplr(list2);
            end
            Kdiag_out(:,lam,phi,theta) = exp([Kdiag(list1(1)),Kdiag(list1(2)),Kdiag(list2(1)),Kdiag(list2(2))]...
                *2*pi*d*1i/Lam(lam));
            Psi_out(:,:,lam,phi,theta) = [Psi(:,list1(1)),Psi(:,list1(2)),Psi(:,list2(1)),Psi(:,list2(2))];
        end
    end
end
end

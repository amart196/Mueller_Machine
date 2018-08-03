function MM = PWDC346(Lam,AOI,azi,e1,e3,a1,a3,bool_reflect,d)

eul = [azi 0 0].*pi/180;
AOI = AOI*pi/180;

epsilon = zeros(3,length(Lam));
alpha = zeros(3,3,length(Lam));
lam2 = (Lam/1000).^2;
epsilon(1,:) = e1;
epsilon(2,:) = e1;
epsilon(3,:) = e3;
lam2 = Lam.^2;
alpha(1,1,:) = a1;
alpha(2,2,:) = a1;
alpha(3,3,:) = a3;
alpha = 1i*alpha;


Ainv = [0.5,0.5,0,0;0,0,0.5,-0.5*1i;0,0,0.5,0.5*1i;0.5,-0.5,0,0];
A = [1,0,0,1;1,0,0,-1;0,1,1,0;0,1i,-1i,0];
Nlam = length(Lam);
MM = zeros(4,4,Nlam);
Eul = [cos(eul(3)),sin(eul(3)),0;-sin(eul(3)),cos(eul(3)),0;0,0,1]...
    *[1,0,0;0,cos(eul(2)),sin(eul(2));0,-sin(eul(2)),cos(eul(2))]...
    *[cos(eul(1)),sin(eul(1)),0;-sin(eul(1)),cos(eul(1)),0;0,0,1];
Eul = transpose(Eul);
R = [Eul,zeros(3,3);zeros(3,3),Eul];

for phi = 1:length(AOI)
        kx = sin(AOI(phi));
        PsiAir = [cos(AOI(phi)),0,-cos(AOI(phi)),0;1,0,1,0;0,1,0,1;0,cos(AOI(phi)),0,-cos(AOI(phi))];
        invPsiAir = inv(PsiAir);
        for n = 1:Nlam
            M = R*[diag(epsilon(:,n)),-alpha(:,:,n);transpose(alpha(:,:,n)),...
                eye(3)]*transpose(R);
%         M = [diag(epsilon(:,n)),-alpha(:,:,n);transpose(alpha(:,:,n)),...
%             eye(3)];
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
            [Psi1,K] = eig(delta);
            Kdiag = diag(K);
            list1 = find(Kdiag > 0);
            list2 = find(Kdiag < 0);
            if Kdiag(list1(1)) < Kdiag(list1(2))
                list1 = fliplr(list1);
            end
            if Kdiag(list2(1)) > Kdiag(list2(2))
                list2 = fliplr(list2);
            end
            K = diag(exp([Kdiag(list1(1)),Kdiag(list1(2)),Kdiag(list2(1)),Kdiag(list2(2))]...
                *2*pi*d*1i/Lam(n)));
            Psi1 = [Psi1(:,list1(1)),Psi1(:,list1(2)),Psi1(:,list2(1)),Psi1(:,list2(2))];
        
            P1 = diag([1/K(1,1),1/K(2,2)]);
            P2 = K([3,4],[3,4]);
            Int01 = invPsiAir*Psi1;
            Int12 = inv(Psi1)*PsiAir;
            Int10 = Int12;
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
                Coh = R01+T10*P2*R12*P1*inv(eye(4) - R10*P2*R12*P1)*T01;
                temp = real(A*Coh*Ainv);
                temp = temp./temp(1,1);
              MM(:,:,n,phi) =temp;
            else
                Coh = T12*P1*inv(eye(4) - R10*P2*R12*P1)*T01;
                temp = real(A*Coh*Ainv);
                temp = temp./temp(1,1);
                MM(:,:,n,phi)=temp;
%                 MM(:,:,n,phi) = MMrotate(temp,azi);
%                 MM(1,2,n,phi) = 10*MM(1,2,n,phi);
%                 MM(2,1,n,phi) = 10*MM(2,1,n,phi);
            end
        end
    end
end
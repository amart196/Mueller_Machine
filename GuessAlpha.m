function [a1, a3] = GuessAlpha(Lam,Sim1,Sim2,eps1,eps3,d);
% Data=zeros(15,1);
% Data(1:3)=Sim1(1,2:4);
% Data(4:7)=Sim1(2,1:4);
% Data(8:11)=Sim1(3,1:4);
% Data(12:15)=Sim1(4,1:4);
% Data=Data';
Opti = MtoN(Sim1);
Data=Opti(5)*100;


%Solve E33
% x=100;
% p2(4,:)=linspace(2,3,x);
% r=800;
% n=0;
% for d = 1:x;
%         MM2(:,:,d)=PW2e11(Lam,0,0,eps1,p2(4,d),th);
%         n=n+1;
%         Value2(n,:)=MM2(4,4,d);
%         Train2(n)=p2(4,d);
% end
% EPSthr800 = svmtrain(Train2',Value2, '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
% [eps3,acc,decV]= svmpredict(rand(1), Data,EPSthr800, ['libsvm_options']);

%solve for a11
x=20;
n=0;
w=linspace(-10^(-4),10^(-4),x);
for a = 1:x
    MM3(:,:,a)=PW2alpha(d,Lam,0,0,eps1,eps3,w(a),0,0);
    n=n+1;
    Value3(n,1:3)=MM3(1,2:4,a);
    Value3(n,4:7)=MM3(2,1:4,a);
    Value3(n,8:11)=MM3(3,1:4,a);
    Train3(n)=w(a)*10000;
end
Aone800 = svmtrain(Train3',Value3, '-s 3 -c 10 -t 2 -g 1 -r 1 -d 3');
Data2=zeros(11,1);
Data2(1:3)=Sim2(1,2:4);
Data2(4:7)=Sim2(2,1:4);
Data2(8:11)=Sim2(3,1:4);
Data2=Data2';
[a1,acc,decV]= svmpredict(rand(1),Data2,Aone800, ['libsvm_options']);
a1=a1/10000;

%solve for a33
x=100;
n=0;
q=linspace(-10^(-4),10^(-4),x);
for a = 1:x;
    MM4(:,:,a)=PW2alpha(d,Lam,0,0,eps1,eps3,a1,q(a),30);
    n=n+1;
    Opt=MtoN(MM4(:,:,a));
    Value4(n)=Opt(5)*100;
%     Value4(n,1:3)=MM4(1,2:4,a);
%     Value4(n,4:7)=MM4(2,1:4,a);
%     Value4(n,8:11)=MM4(3,1:4,a);
%     Value4(n,12:15)=MM4(4,1:4,a);
    Train4(n)=q(a)*10000;
end
Athr800 = svmtrain(Train4',Value4', '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
[a3,acc,decV]= svmpredict(rand(1),Data,Athr800, ['libsvm_options']);
a3=a3/10000;

% %Refine e33
% x=2;
% p5(4,:)=linspace(eps3*0.9,eps3*1.1,x);
% n=0;
% for e = 1:x;
%         MM5(:,:,e)=PW2e11(Lam,0,0,eps1,p5(4,e),th);
%         n=n+1;
%         Value5(n,1:3)=MM5(1,2:4,e);
%         Value5(n,4:7)=MM5(2,1:4,e);
%         Value5(n,8:11)=MM5(3,1:4,e);
%         Value5(n,12:15)=MM5(4,1:4,e);
%         Train5(n)=p5(4,e);
% end
% EPSthr800 = svmtrain(Train5',Value5, '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
% [eps3,acc,decV]= svmpredict(rand(1), Data,EPSthr800, ['libsvm_options']);



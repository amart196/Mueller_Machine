%Build all the training Data using the 23 chosen parameters
clear all

tic
w=6;
% Lam = 400:800;
% e1 = linspace(2,3,4);
% e3 = linspace(1.8,3,4);
% a = linspace(0,0.001,4);
% d = 1000000;
Lam = linspace(400,800,100);
e1 = linspace(2.05,3.15,w);
e3 = linspace(2.0,3.0,w);
a1 = linspace(-0.0001,0.0001,w);
a3 = 0;
d = 500000;
n=0;
% Ydata = zeros(length(e1)*length(e3)*length(a1)*length(a3),length(Lam),22);
for x = 1:length(e1)
    for y = 1:length(e3)
        for z = 1:length(a1)
                n=n+1;
                e1Train(n)=e1(x);
                e3Train(n)=e3(y);
                a1Train(n)=a1(z);
                a3Train(n)=0;
                MM1=PWDC346(Lam,56.3,0,e1(x),e3(y),a1(z),0,1,d);
                MM2=PWDC346(Lam,36,0,e1(x),e3(y),a1(z),0,1,d);
                MM3=PWDC346(Lam,30,0,e1(x),e3(y),a1(z),0,0,d);
                MM4=PWDC346(Lam,0,0,e1(x),e3(y),a1(z),0,0,d);
                close all
                Ydata1(n,:,:)=CalculateDC346Parameters(Lam,d,MM1,MM2,MM3,MM4);
        end
    end
end
% Ydatacon=Ydata1(1,1,:);

b=0;
m=length(e1Train);
for x = 1:50;
    B(m*b+1:m*(b+1),:) = squeeze(Ydata1(:,x,:));
    e1Train2((m*b)+1:m*(b+1))=e1Train(1:length(e1Train));
    e3Train2((m*b)+1:m*(b+1))=e3Train(1:length(e3Train));
    a1Train2((m*b)+1:m*(b+1))=a1Train(1:length(a1Train));
    a3Train2((m*b)+1:m*(b+1))=a3Train(1:length(a3Train));
    b=b+1;
end
a1Train2=a1Train2*10000;
a3Train2=a3Train2*10000;

    
DC346e1=svmtrain(e1Train2',B,'-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
DC346e3=svmtrain(e3Train2',B,'-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
toc
DC346a1=svmtrain(a1Train2',B,'-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
DC346a3=svmtrain(a1Train2',B,'-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');


c=length(e1Train2)
for x = 1:length(e1Train2)
%     [eps(1,x),acc,decV] = svmpredict(.2,B(x,:),DC346e1, ['libsvm_options']);
    MSEeps1(x) = (eps(1,x)-e1Train2(x));
%     [eps(2,x),acc,decV] = svmpredict(.2,B(x,:),DC346e3, ['libsvm_options']);
    MSEeps2(x) = (eps(2,x)-e3Train2(x));
%     [alp(1,x),acc,decV] = svmpredict(.2,B(x,:),DC346a1, ['libsvm_options']);
    MSEalp1(x) = (alp(1,x)-a1Train2(x));
%     [alp(2,x),acc,decV] = svmpredict(.2,B(x,:),DC346a3, ['libsvm_options']);
    MSEalp2(x) = (alp(2,x)-a3Train2(x));
end
MSEe1 = (1/c)*sum(MSEeps1.^2);
MSEe3 = (1/c)*sum(MSEeps2.^2);
MSEa1 = (1/c)*sum(MSEalp1.^2)/10000;
MSEa3 = (1/c)*sum(MSEalp2.^2)/10000;


alp=alp/1000;


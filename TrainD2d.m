%Build all the training Data using the 22 chosen parameters
clear all

% Lam = 400:800;
% e1 = linspace(2,3,4);
% e3 = linspace(1.8,3,4);
% a = linspace(0,0.001,4);
% d = 1000000;
tic
Lam = linspace(400,800,201);
e1 = linspace(2,4,2);
e3 = linspace(1.8,3.8,2);
a = linspace(0,0.001,2);
d = 500000;
n=0;
Ydata = zeros(length(e1)*length(e3)*length(a),length(Lam),22);
for x = 1:length(e1)
    for y = 1:length(e3)
        for z = 1:length(a)
             n=n+1;
             e1Train(n)=e1(x);
             e3Train(n)=e3(y);
             aTrain(n)=a(z);
             MM1=PWD2D(Lam,56.3,0,e1(x),e3(y),a(z),1,d);
             MM2=PWD2D(Lam,36,0,e1(x),e3(y),a(z),1,d);
             MM3=PWD2D(Lam,30,45,e1(x),e3(y),a(z),0,d);
             close all
             Ydata(n,:,:)=CalculateD2dParameters(Lam,d,MM1,MM2,MM3);
        end
    end
end
toc

b=0;
m=length(e1Train);
for x = 1:length(Lam);
    B(m*b+1:m*(b+1),:) = squeeze(Ydata(:,x,:));
    e1Train2((m*b)+1:m*(b+1))=e1Train(1:length(e1Train));
    e3Train2((m*b)+1:m*(b+1))=e3Train(1:length(e3Train));
    aTrain2((m*b)+1:m*(b+1))=aTrain(1:length(aTrain));
    b=b+1;
end
aTrain2=aTrain2*10000;
    
D2de1500=svmtrain(e1Train2',B,'-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
D2de3500=svmtrain(e3Train2',B,'-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
% D2da=svmtrain(aTrain2',B,'-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');

% c=10000
% for x = 1:c
%     [eps(1,x),acc,decV] = svmpredict(.2,B(x,:),D2de1, ['libsvm_options']);
%     MSEeps1(x) = (eps(1,x)-e1Train2(x));
%     [eps(2,x),acc,decV] = svmpredict(.2,B(x,:),D2de3, ['libsvm_options']);
%     MSEeps2(x) = (eps(2,x)-e3Train2(x));
%     [alp(x),acc,decV] = svmpredict(.2,B(x,:),D2da, ['libsvm_options']);
%     MSEa(x) = (alp(1,x)-aTrain2(x));
% end
% MSEe1 = (1/c)*sum(MSEeps1.^2);
% MSEe3 = (1/c)*sum(MSEeps2.^2);
% MSEa = (1/c)*sum(MSEa.^2)/10000;
% 
% alp=alp/10000;


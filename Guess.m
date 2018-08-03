function [eps1, eps3, a1, a3] = GuessE11(Lam,Sim1,Sim2,EPSone800,th);
%Solve Epsilon 11 and Epsilon 33
Data=zeros(15,1);
Data(1:3)=Sim1(1,2:4);
Data(4:7)=Sim1(2,1:4);
Data(8:11)=Sim1(3,1:4);
Data(12:15)=Sim1(4,1:4);

Data=Data';
eps1=zeros(length(Lam),1);
eps3=zeros(length(Lam),1);
[eps1,acc,decV] = svmpredict(rand(1), Data, EPSone800, ['libsvm_options']);
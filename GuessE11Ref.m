function [eps1] = GuessE11Ref(Lam,Sim1,Sim2,Sim3,M44U,M44L,M34U,M34L,M44U2,M44L2,M34U2,M34L2,M44U3,M44L3,M34U3,M34L3, EPSoneRef,th);
%Solve Epsilon 11 and Epsilon 33
Data=zeros(16,1);
Data(1)=Sim1(1,2);
Data(2)=Sim2(1,2);
Data(3)=Lam/1000;
Data(4)=M44U*10;
Data(5)=M44L*10;
Data(6)=M34U*10;
Data(7)=M34L*10;
Data(8)=M44U2*10;
Data(9)=M44L2*10;
Data(10)=M34U2*10;
Data(11)=M34L2*10;
Data(12)=M44U3*10;
Data(13)=M44L3*10;
Data(14)=M34U3*10;
Data(15)=M34L3*10;
Data(16)=Sim3(1,2);

Data=Data';
eps1=zeros(length(Lam),1);
[eps1,acc,decV] = svmpredict(rand(1), Data, EPSoneRef, ['libsvm_options']);
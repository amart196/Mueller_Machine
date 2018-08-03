close all
clear all

tic
x=5;
y=400;
p(3,:)=linspace(2,3.5,x);
% p(3,:)=(4-1.5).*rand(x,1)+2.5;
% p(4,:)=(4-1.5).*rand(x,1)+2.5;
p(4,:)=linspace(2.05,3.55,x);
pa(5,:)=linspace(400,800,y);
n=0;
s=0;
t=1;
MM=zeros(4,4,x,x,y);

for d = 1:x;
    for c = 1:x;
        for e = 1:y;
            MM(:,:,c,d,e)=PW2e11(pa(5,e),0,56.3,p(3,c),p(4,d),400000);
            MM2(:,:,c,d,e)=PW2e11(pa(5,e),0,36,p(3,c),p(4,d),400000);
            MM3(:,:,c,d,e)=PW2e11(pa(5,e),0,70,p(3,c),p(4,d),400000);
            n=n+1;
            Value(n,1)=MM(1,2,c,d,e);
            Value(n,2)=MM2(1,2,c,d,e);
            Value(n,16)=MM3(1,2,c,d,e);
            Value(n,3)=pa(5,e)/1000;
            Train(n)=p(3,c);
            Train1(n)=p(4,d);
        end
        [EnvU(:,d,c),EnvL(:,d,c)]= CalcM34Envelope(pa(5,:),MM(4,4,c,d,:));
        Value(n+1-y:n,4)=EnvU(:,d,c)*10;
        Value(n+1-y:n,5)=EnvL(:,d,c)*10;
        [EnvU(:,d,c),EnvL(:,d,c)]= CalcM34Envelope(pa(5,:),MM(3,4,c,d,:));
        Value(n+1-y:n,6)=EnvU(:,d,c)*10;
        Value(n+1-y:n,7)=EnvL(:,d,c)*10;
        [EnvU2(:,d,c),EnvL2(:,d,c)]= CalcM34Envelope(pa(5,:),MM2(4,4,c,d,:));
        Value(n+1-y:n,8)=EnvU2(:,d,c)*10;
        Value(n+1-y:n,9)=EnvL2(:,d,c)*10;
        [EnvU2(:,d,c),EnvL2(:,d,c)]= CalcM34Envelope(pa(5,:),MM2(3,4,c,d,:));
        Value(n+1-y:n,10)=EnvU2(:,d,c)*10;
        Value(n+1-y:n,11)=EnvL2(:,d,c)*10;
        [EnvU3(:,d,c),EnvL3(:,d,c)]= CalcM34Envelope(pa(5,:),MM3(4,4,c,d,:));
        Value(n+1-y:n,12)=EnvU3(:,d,c)*10;
        Value(n+1-y:n,13)=EnvL3(:,d,c)*10;
        [EnvU3(:,d,c),EnvL3(:,d,c)]= CalcM34Envelope(pa(5,:),MM3(3,4,c,d,:));
        Value(n+1-y:n,14)=EnvU3(:,d,c)*10;
        Value(n+1-y:n,15)=EnvL3(:,d,c)*10;
    end
end

training_instance_matrix=Value;
EPSoneRef = svmtrain(Train',Value, '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
%EPSthrRef = svmtrain(Train1',Value, '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
toc
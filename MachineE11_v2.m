close all
clear all

tic
x=5;

p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=linspace(400,800,x);
r=1500;
n=0;

for d = 1:x;
    for c = 1:x;
        for e = 1:x;
            MM(:,:,c,d,e)=PW2e11(p(5,e),0,0,p(3,c),p(4,d),r);
            n=n+1;
            Value(n,1:3)=MM(1,2:4,c,d,e);
            Value(n,4:7)=MM(2,1:4,c,d,e);
            Value(n,8:11)=MM(3,1:4,c,d,e);
            Value(n,12:15)=MM(4,1:4,c,d,e);
            Train(n)=p(3,c);
            Train1(n)=p(4,d);
        end
    end
end

training_instance_matrix=Value;
EPSoneRef = svmtrain(Train',Value, '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
EPSthrRef = svmtrain(Train1',Value, '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
toc
% [Eps33,acc,decV]= svmpredict(Train',Value,EPSone800, ['libsvm_options']);

p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;
n=0;
r=850;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end

training_instance_matrix=Value;
T850 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');

p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;
n=0;
r=900;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end

training_instance_matrix=Value;
T900 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');


p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;n=0;
r=950;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end
training_instance_matrix=Value;
T950 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');


p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;n=0;
r=1000;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end

training_instance_matrix=Value;
T1000 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');


p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;n=0;
r=1050;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end

training_instance_matrix=Value;
T1050 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');


p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;n=0;
r=1100;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end

training_instance_matrix=Value;
T1100 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');


p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;n=0;
r=1150;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end

training_instance_matrix=Value;
T1150 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');


p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;n=0;
r=1200;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end

training_instance_matrix=Value;
T1200 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');


p(2,:)=(10+10).*rand(x,1)-10;
p(4,:)=linspace(2,3,x);
p(3,:)=(3-2).*rand(x,1)+2;
p(5,:)=(600-400).*rand(x,1)+400;n=0;
r=1250;
for d = 1:x;
    for b = 1:x;
        for c = 1:x;
            for e = 1:x;
                MM(:,:,b,c,d,e)=PW2e11(r,p(5,e),0,p(2,b),p(3,c),p(4,d));
                n=n+1;
                Value(n,1:3)=MM(1,2:4,b,c,d,e);
                Value(n,4:7)=MM(2,1:4,b,c,d,e);
                Value(n,8:11)=MM(3,1:4,b,c,d,e);
                Value(n,12:15)=MM(4,1:4,b,c,d,e);
                Train(n)=p(2,b);
            end
        end
    end
end
% y = (n)/(x);
% training_label_vector=zeros(x^4,1);
% training_label_vector(1:y)=p(4,1);
% training_label_vector((y+1):(2*y))=p(4,2);
% training_label_vector((2*y+1):(3*y))=p(4,3);
% training_label_vector((3*y+1):(4*y))=p(4,4);
% training_label_vector((4*y+1):(5*y))=p(4,5);
% training_label_vector((5*y+1):(6*y))=p(4,6);
% training_label_vector((6*y+1):(7*y))=p(4,7);
% training_label_vector((7*y+1):(8*y))=p(4,8);
% training_label_vector((8*y+1):(9*y))=p(4,9);
% training_label_vector((9*y+1):(10*y))=p(4,10);
% training_label_vector((10*y+1):(11*y))=p(4,11);
% training_label_vector((11*y+1):(12*y))=p(4,12);
% training_label_vector((12*y+1):(13*y))=p(4,13);
% training_label_vector((13*y+1):(14*y))=p(4,14);
% training_label_vector((14*y+1):(15*y))=p(4,15);
% training_label_vector((15*y+1):(16*y))=p(4,16);
% training_label_vector((16*y+1):(17*y))=p(4,17);
% training_label_vector((17*y+1):(18*y))=p(4,18);
% training_label_vector((18*y+1):(19*y))=p(4,19);
% training_label_vector((19*y+1):(20*y))=p(4,20);
% training_label_vector((20*y+1):(21*y))=p(3,21);
% training_label_vector((21*y+1):(22*y))=p(3,22);
% training_label_vector((22*y+1):(23*y))=p(3,23);
% training_label_vector((23*y+1):(24*y))=p(3,24);
% training_label_vector((24*y+1):(25*y))=p(3,25);
training_instance_matrix=Value;
T1250 = svmtrain(Train', training_instance_matrix(:,:), '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');

toc


% testing_label_vector=rand(n,1);
% testing_instance_matrix=[Value(:,:)];
% [predicted_label, accuracy, decision_valuesprob_estimates] = svmpredict(testing_label_vector, testing_instance_matrix, e11800, ['libsvm_options']);
% 
% % plot(training_label_vector,predicted_label,'red');
% 
% Ave(1)=mean(predicted_label(1:y));
% S(1) = std(predicted_label(1:y));
% Ave(2)=mean(predicted_label((y+1):(2*y)));
% S(2) = std(predicted_label((y+1):(2*y)));
% Ave(3)=mean(predicted_label((2*y+1):(3*y)));
% S(3) = std(predicted_label((2*y+1):(3*y)));
% Ave(4)=mean(predicted_label((3*y+1):(4*y)));
% S(4) = std(predicted_label((3*y+1):(4*y)));
% Ave(5)=mean(predicted_label((4*y+1):(5*y)));
% S(5) = std(predicted_label((4*y+1):(5*y)));
% % Ave(6)=mean(predicted_label((5*y+1):(6*y)));
% % S(6) = std(predicted_label((5*y+1):(6*y)));
% % Ave(7)=mean(predicted_label((6*y+1):(7*y)));
% % S(7) = std(predicted_label((6*y+1):(7*y)));
% % Ave(8)=mean(predicted_label((7*y+1):(8*y)));
% % S(8) = std(predicted_label((7*y+1):(8*y)));
% % Ave(9)=mean(predicted_label((8*y+1):(9*y)));
% % S(9) = std(predicted_label((8*y+1):(9*y)));
% % Ave(10)=mean(predicted_label((9*y+1):(10*y)));
% % S(10) = std(predicted_label((9*y+1):(10*y)));
% % Ave(11)=mean(predicted_label((10*y+1):(11*y)));
% % S(11) = std(predicted_label((10*y+1):(11*y)));
% % Ave(12)=mean(predicted_label((11*y+1):(12*y)));
% % S(12) = std(predicted_label((11*y+1):(12*y)));
% % % Ave(13)=mean(predicted_label((12*y+1):(13*y)));
% % S(13) = std(predicted_label((12*y+1):(13*y)));
% % Ave(14)=mean(predicted_label((13*y+1):(14*y)));
% % S(14) = std(predicted_label((13*y+1):(14*y)));
% % Ave(15)=mean(predicted_label((14*y+1):(15*y)));
% % S(15) = std(predicted_label((14*y+1):(15*y)));
% % Ave(16)=mean(predicted_label((15*y+1):(16*y)));
% % S(16) = std(predicted_label((15*y+1):(16*y)));
% 
% figure
% errorbar(p(3,:),Ave',S')
% hold on
% t=linspace(2,3,100);
% r = t;
% plot(r,t,'red');
% toc
% 
% 
% 

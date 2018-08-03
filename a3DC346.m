function DC346a3 = a3DC346(Lam,epsilon,a1,d);

w=10;
a3 = linspace(-0.0001,0.0001,w);
n = 0;
for y = 1:length(a3)
    n = n+1;
    a3Train(n)=a3(y);
    MM1=PWDC346(Lam,56.3,0,epsilon(1,:),epsilon(2,:),a1,a3(y),1,d);
    MM2=PWDC346(Lam,36,0,epsilon(1,:),epsilon(2,:),a1,a3(y),1,d);
    MM3=PWDC346(Lam,30,0,epsilon(1,:),epsilon(2,:),a1,a3(y),0,d);
    MM4=PWDC346(Lam,0,0,epsilon(1,:),epsilon(2,:),a1,a3(y),0,d);
    close all
    Ydata1(n,:,:)=CalculateDC346Parameters(Lam,d,MM1,MM2,MM3,MM4);
end

b=0;
m=length(a3Train);
for x = 1:length(Lam);
    B(m*b+1:m*(b+1),1:2) = squeeze(Ydata1(:,x,1:2));
    a3Train2((m*b)+1:m*(b+1))=a3Train(1:length(a3Train));
    b=b+1;
end
a3Train2=a3Train2*10000;
DC346a3=svmtrain(a3Train2',B,'-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
end




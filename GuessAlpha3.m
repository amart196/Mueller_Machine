function a3 = GuessAlpha3(Lam,Env,eps1,eps3,a1,d)

% Sim1=MM1(2,3,:);
% [peaks,locs]=findpeaks(squeeze(MM1(2,3,:)));
% options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
% p0=[1 155];
% LB=[0 0];
% UB=[1000 300];
% p=p0;
% Lams=Lam(locs);
% [p_out]=lsqcurvefit(@(p,Lams)alpha(p,Lams),p0,Lams',peaks,LB,UB,options);
% lam2 = Lam.^2;
% envelope = Lam.^3*(p_out(1))./(lam2 - p_out(2)^2).^2;
% plot(Lam,squeeze(Sim1),'red',Lam,envelope,'blue');
% eps1=epsilon1;
% eps3=epsilon3;
options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
x=3;
lam2 = Lam.^2;
n=0;
q=linspace(-.15,15,x);
for a = 1:x;
    n=n+1;
    for b = 1:length(Lam)
    MM4(:,:,a,b)=PW2alpha3mag(d,Lam(b),0,0,eps1(b),eps3(b),a1(b),q(a),30);
%     Opt=MtoN(MM4(:,:,a));
%     Value4(n)=Opt(5)*100;
%     Value4(n,:)=MM4(2,3,a,:);
%     Value4(n,4:7)=MM4(2,1:4,a);
%     Value4(n,8:11)=MM4(3,1:4,a);
%     Value4(n,12:15)=MM4(4,1:4,a);
    end
    test = MM4(2,3,a,:);
    Train4(n)=q(a);
    [peaks2,locs2]=findpeaks(squeeze(test));
    p0=[1 100];
    LB=[0 100];
    UB=[1000 100];
    p=p0;
    Lams=Lam(locs2);
    [p_out]=lsqcurvefit(@(p,Lams)alpha(p,Lams),p0,Lams,peaks2',LB,UB,options);
    envelope(n,:) = (Lam.^3*(p_out(1))./(lam2 - p_out(2)^2).^2);
end

% plot(Lam,squeeze(Sim1),'red',Lam,envelope,'blue');

Athr800 = svmtrain(Train4',envelope(:,1)*100, '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
[a3,acc,decV]= svmpredict(rand(1),Env(1)*100,Athr800, ['libsvm_options']);
a3=a3;
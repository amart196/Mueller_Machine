%Machine Learning with Data Transmission

%Choose a transparent z-cut unixial crytal
%Align sample normal to light
%Set AOI to 30 degrees, and adjust azimuth so that LB'=0.
%z-cut Quartz%Measure MM spectra at AOI = 0 deg and AOI = 30 deg
Lam=linspace(300,750,451);
d=500000;
th=d;
%Z-cut Quartz
[MM1,MMer,Lam]=read4PEM('atm-2-60-1_030.000.dat',1);
[MM2,MMer,Lam]=read4PEM('atm-2-60-1_000.000.dat',1);

plotMMData4x4(Lam,0,MM2,23,'blue');
plotMMData4x4(Lam,0,MM1,23,'blue');

% layerArray{1}={'air',0,[0,0,0],1,1};
% layerArray{2}={'+quartzf2guessed',d,[0,0,0],0,0};
% layerArray{3}={'air',0,[0,0,0],1,1};
% [MM1,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,5,-8,'red');
% [MM2,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,0,3,'red');
% close all
% plotStuff_1 = {'ev',false,'LimY',0.1,...
%     'plotNV',{'linewidth',3},...
%     'fontsize',13,...
%     'axNV',{'Xlim',[400,800],'fontname','arial'}};
% 
% handles = MMplot(Lam,MM1,'red',plotStuff_1{:});
% hold on
% MMplot(Lam,MM2,'blue','handles',handles,plotStuff_1{:});
close all

tic
for a = 1:length(Lam)
    [eps1(a)] = GuessE11(Lam(a),MM1(:,:,a),MM2(:,:,a),EPSone800,d);
end
LBave=GuessLB(Lam,MM1(4,4,:),d,mean(eps1));
options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
p0=[1.07 0.01 1.1 100 1.78];
p=p0;
LB=0.5*p0;
UB=1.5*p0;
[p_out1]=lsqcurvefit(@(p,Lam)e1(p,Lam),p0,Lam,eps1',LB,UB,options);
lam2 = (Lam/1000).^2;
epsilon1=p_out1(1)*lam2./(lam2 - p_out1(2))...
              +p_out1(3)*lam2./(lam2 - p_out1(4)) + p_out1(5);
epsilon3 = epsilon1-LBave;

for a = 1:length(Lam)
    [a1(a), ~] = GuessAlpha(Lam(a),MM1(:,:,a),MM2(:,:,a),epsilon1(a),epsilon3(a),d);
end

p0=[0.02 93];
p=p0;
LB=-0.5*p0;
UB=3*p0;
[p_out2]=lsqcurvefit(@(p,Lam)alpha(p,Lam),p0,Lam,a1',LB,UB,options);
lam2 = Lam.^2;
alpha1 = Lam.^3*(p_out2(1))./(lam2 - p_out2(2)^2).^2;

Env = CalcM23Envelope(Lam,MM1(2,3,:),d);
% plot(Lam,squeeze(Sim1),'red',Lam,envelope,'blue');

a3 = GuessAlpha3(Lam,Env,epsilon1,epsilon3,alpha1,d);

% p0=[-0.03 87];
% p=p0;
% LB=[-.1 70];
% UB=[.1 120];
% [p_out]=lsqcurvefit(@(p,Lam)alpha(p,Lam),p0,Lam,a3,LB,UB,options);
% lam2 = Lam.^2;
alpha3 = Lam.^3*(a3)./(lam2 - 100^2).^2;
% plot(Lam,alpha3,'blue',Lam,a3,'red');

toc
%plot them
alphar = zeros(3,length(Lam));
lam2 = (Lam/1000).^2;
       epsilon(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
                     +1.10202242*lam2./(lam2 - 100) + 1.78604141;
       epsilon(2,:) = epsilon(1,:);
       epsilon(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
                     +1.15662475*lam2./(lam2 - 100) + 1.28851804;
lam2 = Lam.^2;
alphar(1,:) = Lam.^3*(0.0198)./(lam2 - 93^2).^2;
alphar(3,:) = Lam.^3*(-0.0408)./(lam2 - 87^2).^2;

figure
plot(Lam,epsilon1,'red',Lam,epsilon3,'blue',Lam,epsilon(1,:),'black',Lam,epsilon(3,:),'black');
figure
plot(Lam,alpha1,'red',Lam,alpha3,'blue',Lam,alphar(1,:),'black',Lam,alphar(3,:),'black');
lam2 = (Lam/1000).^2;
       epsilon(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
                     +1.10202242*lam2./(lam2 - 100) + 0.78604141;
       epsilon(2,:) = epsilon(1,:);
       epsilon(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
                     +1.15662475*lam2./(lam2 - 100) + 1.28851804;
% figure
% plot(Lam,epsilon1,'green',Lam,epsilon3,'blue',Lam,epsilon(1,:),'black',Lam,epsilon(3,:),'black');


%Z-cut TeO2
Lam=linspace(330,750,421);
d=1000000;
th=d;
[MM1,MMer,Lam]=read4PEM('atm-2-190-2_030.000.dat',1);
[MM2,MMer,Lam]=read4PEM('atm-2-190-2_000.000.dat',1);

% plotMMData4x4(Lam,0,MM2,23,'blue');
% layerArray{1}={'air',0,[0,0,0],1,1};
% layerArray{2}={'+quartzf2guessed',d,[0,0,0],0,0};
% layerArray{3}={'air',0,[0,0,0],1,1};
% [MM1,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,5,-8,'red');
% [MM2,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,0,3,'red');
% close all
% plotStuff_1 = {'ev',false,'LimY',0.1,...
%     'plotNV',{'linewidth',3},...
%     'fontsize',13,...
%     'axNV',{'Xlim',[400,800],'fontname','arial'}};
% 
% handles = MMplot(Lam,MM1,'red',plotStuff_1{:});
% hold on
% MMplot(Lam,MM2,'blue','handles',handles,plotStuff_1{:});
close all

tic
for a = 1:length(Lam)
    [eps1(a)] = GuessE11(Lam(a),MM1(:,:,a),MM2(:,:,a),EPSone800,d);
end
LBave=GuessLB(Lam,MM1(4,4,:),d,mean(eps1));
options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
p0=[1.07 0.01 1.1 100 1.78];
p=p0;
LB=0.5*p0;
UB=1.5*p0;
[p_out1]=lsqcurvefit(@(p,Lam)e1(p,Lam),p0,Lam,eps1',LB,UB,options);
lam2 = (Lam/1000).^2;
epsilon1=p_out1(1)*lam2./(lam2 - p_out1(2))...
              +p_out1(3)*lam2./(lam2 - p_out1(4)) + p_out1(5);
epsilon3 = epsilon1-LBave;

for a = 1:length(Lam)
    [a1(a), ~] = GuessAlpha(Lam(a),MM1(:,:,a),MM2(:,:,a),epsilon1(a),epsilon3(a),d);
end

p0=[0.02 93];
p=p0;
LB=-0.5*p0;
UB=3*p0;
[p_out2]=lsqcurvefit(@(p,Lam)alpha(p,Lam),p0,Lam,a1',LB,UB,options);
lam2 = Lam.^2;
alpha1 = Lam.^3*(p_out2(1))./(lam2 - p_out2(2)^2).^2;

Env = CalcM23Envelope(Lam,MM1(2,3,:),d);
% plot(Lam,squeeze(Sim1),'red',Lam,envelope,'blue');

a3 = GuessAlpha3(Lam,Env,epsilon1,epsilon3,alpha1,d);

% p0=[-0.03 87];
% p=p0;
% LB=[-.1 70];
% UB=[.1 120];
% [p_out]=lsqcurvefit(@(p,Lam)alpha(p,Lam),p0,Lam,a3,LB,UB,options);
% lam2 = Lam.^2;
alpha3 = Lam.^3*(a3)./(lam2 - 100^2).^2;
% plot(Lam,alpha3,'blue',Lam,a3,'red');

toc
%plot them
alphar = zeros(3,length(Lam));
lam2 = (Lam/1000).^2;
       epsilon(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
                     +1.10202242*lam2./(lam2 - 100) + 1.78604141;
       epsilon(2,:) = epsilon(1,:);
       epsilon(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
                     +1.15662475*lam2./(lam2 - 100) + 1.28851804;
lam2 = Lam.^2;
alphar(1,:) = Lam.^3*(0.0198)./(lam2 - 93^2).^2;
alphar(3,:) = Lam.^3*(-0.0408)./(lam2 - 87^2).^2;

figure
plot(Lam,epsilon1,'red',Lam,epsilon3,'blue',Lam,epsilon(1,:),'black',Lam,epsilon(3,:),'black');
figure
plot(Lam,alpha1,'red',Lam,alpha3,'blue',Lam,alphar(1,:),'black',Lam,alphar(3,:),'black');
lam2 = (Lam/1000).^2;
       epsilon(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
                     +1.10202242*lam2./(lam2 - 100) + 0.78604141;
       epsilon(2,:) = epsilon(1,:);
       epsilon(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
                     +1.15662475*lam2./(lam2 - 100) + 1.28851804;
                
%Z-cut LiIO3
d=200000;
th=d;
[MM1,MMer,Lam]=read4PEM('atm-2-202-1_030.000.dat',1);
[MM2,MMer,Lam]=read4PEM('atm-2-202-1_000.000.dat',1);

% plotMMData4x4(Lam,0,MM2,23,'blue');
% layerArray{1}={'air',0,[0,0,0],1,1};
% layerArray{2}={'+quartzf2guessed',d,[0,0,0],0,0};
% layerArray{3}={'air',0,[0,0,0],1,1};
% [MM1,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,5,-8,'red');
% [MM2,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,0,3,'red');
% close all
% plotStuff_1 = {'ev',false,'LimY',0.1,...
%     'plotNV',{'linewidth',3},...
%     'fontsize',13,...
%     'axNV',{'Xlim',[400,800],'fontname','arial'}};
% 
% handles = MMplot(Lam,MM1,'red',plotStuff_1{:});
% hold on
% MMplot(Lam,MM2,'blue','handles',handles,plotStuff_1{:});
close all

tic
for a = 1:length(Lam)
    [eps1(a)] = GuessE11(Lam(a),MM1(:,:,a),MM2(:,:,a),EPSone800,d);
end
LBave=GuessLB(Lam,MM1(4,4,:),d,mean(eps1));
options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
p0=[1.07 0.01 1.1 100 1.78];
p=p0;
LB=0.5*p0;
UB=1.5*p0;
[p_out1]=lsqcurvefit(@(p,Lam)e1(p,Lam),p0,Lam,eps1',LB,UB,options);
lam2 = (Lam/1000).^2;
epsilon1=p_out1(1)*lam2./(lam2 - p_out1(2))...
              +p_out1(3)*lam2./(lam2 - p_out1(4)) + p_out1(5);
epsilon3 = epsilon1-LBave;

for a = 1:length(Lam)
    [a1(a), ~] = GuessAlpha(Lam(a),MM1(:,:,a),MM2(:,:,a),epsilon1(a),epsilon3(a),d);
end

p0=[0.07 183];
p=p0;
LB=-0.5*p0;
UB=3*p0;
[p_out2]=lsqcurvefit(@(p,Lam)alpha(p,Lam),p0,Lam,a1',LB,UB,options);
lam2 = Lam.^2;
alpha1 = Lam.^3*(p_out2(1))./(lam2 - p_out2(2)^2).^2;

Env = CalcM23Envelope(Lam,MM1(2,3,:),d);
% plot(Lam,squeeze(Sim1),'red',Lam,envelope,'blue');

a3 = GuessAlpha3(Lam,Env,epsilon1,epsilon3,alpha1,d);

% p0=[-0.03 87];
% p=p0;
% LB=[-.1 70];
% UB=[.1 120];
% [p_out]=lsqcurvefit(@(p,Lam)alpha(p,Lam),p0,Lam,a3,LB,UB,options);
% lam2 = Lam.^2;
alpha3 = Lam.^3*(a3)./(lam2 - 216.294^2).^2;
% plot(Lam,alpha3,'blue',Lam,a3,'red');

toc
%plot them
alphar = zeros(3,length(Lam));
lam2 = (Lam/1000).^2;
epsilonr(1,:) = (1.50675*lam2./(lam2 - 0.025))+(1.28*lam2./(lam2 - 169))+1.829;
epsilonr(3,:) = (1.19793*lam2./(lam2 - 0.0219346))+(0.25*lam2./(lam2 - 158.76))+1.65382;
lam2 = Lam.^2;
alphar(1,:) = Lam.^3*(0.0695675)./(lam2 - 183.523^2).^2;
alphar(3,:) = Lam.^3*(-0.2069395)./(lam2 - 216.294^2).^2;

figure
plot(Lam,epsilon1,'red',Lam,epsilon3,'blue',Lam,epsilonr(1,:),'black',Lam,epsilonr(3,:),'black');
figure
plot(Lam,alpha1,'red',Lam,alpha3,'blue',Lam,alphar(1,:),'black',Lam,alphar(3,:),'black');
lam2 = (Lam/1000).^2;
       epsilon(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
                     +1.10202242*lam2./(lam2 - 100) + 0.78604141;
       epsilon(2,:) = epsilon(1,:);
       epsilon(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
                     +1.15662475*lam2./(lam2 - 100) + 1.28851804;
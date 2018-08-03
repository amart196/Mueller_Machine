%Choose a transparent z-cut unixial crytal
%Align sample normal to light
%Set AOI to 30 degrees, and adjust azimuth so that LB'=0.
%Measure MM spectra at AOI = 0 deg and AOI = 30 deg
d=505000;
th=d;
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'+quartz',d,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};
% [MM1,MMer,Lam]=read4PEM('atm-2-60-2_56_060.000.dat',1);
% plotMMData4x4(Lam,0,MM1,23,'blue');
% [MM2,MMer,Lam]=read4PEM('atm-2-60-2_36_000.000.dat',1);
[MM4,MMer,Lam]=read4PEM('atm-2-60-1_030.000.dat',1);
[MM5,MMer,Lam]=read4PEM('atm-2-60-1_000.000.dat',1);
% plotMMData4x4(Lam,0,MM4,23,'blue');
% plotMMData4x4(Lam,0,MM5,23,'blue');
% plotMMData4x4(Lam,0,MM2,23,'blue');
[MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'blue');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
[MM3,C]=MMSpectrumPW2(layerArray,Lam,70,0,1,1,15,3,'blue');
% [MM4,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,15,3,'red');
% [MM5,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'red');  
% M34env=CalcM34Envelope(Lam,MM1(3,4,:));
% plot(Lam,M34env,'red')
[M44U,M44L]=CalcM34Envelope(Lam,MM1(4,4,:));
plot(Lam,M44U,'red',Lam,M44L,'blue')
[M34U,M34L]=CalcM34Envelope(Lam,MM1(3,4,:));
[M44U2,M44L2]=CalcM34Envelope(Lam,MM2(4,4,:));
plot(Lam,M44U2,'red',Lam,M44L2,'blue')
[M34U2,M34L2]=CalcM34Envelope(Lam,MM2(3,4,:));
[M44U3,M44L3]=CalcM34Envelope(Lam,MM3(4,4,:));
plot(Lam,M44U3,'red',Lam,M44L3,'blue')
[M34U3,M34L3]=CalcM34Envelope(Lam,MM3(3,4,:));
%AmpM44 = max(MM1(g,4,:))-min(MM1(4,4,:));
%[MM2,C]=MMSpectrumPW2(layerArray,Lam,0,0,1,1,0,3,'red');
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

lam2 = (Lam/1000).^2;
       epsilon(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
                     +1.10202242*lam2./(lam2 - 100) + 1.187604141;
tic
for a = 1:length(Lam)
    [eps1(a)] = GuessE11Ref(Lam(a),MM1(:,:,a),MM2(:,:,a),MM3(:,:,a),M44U(a),M44L(a),M34U(a),M34L(a),M44U2(a),M44L2(a),M34U2(a),M34L2(a),M44U3(a),M44L3(a),M34U3(a),M34L3(a), EPSoneRef, d);
end
toc
plot(Lam,eps1,'red',Lam,epsilon(1,:),'blue');
hold on
% for a = 1:length(Lam)
%     [eps3(a)] = GuessE11Ref(Lam(a),MM1(:,:,a),MM2(:,:,a),MM3(:,:,a),M44U(a),M44L(a),M34U(a),M34L(a),M44U2(a),M44L2(a),M34U2(a),M34L2(a),M44U3(a),M44L3(a),M34U3(a),M34L3(a),EPSthrRef,d);
% end
% plot(Lam,eps3,'blue');


LBave=GuessLB(Lam,MM1(4,4,:),d,mean(eps1));
options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
p0=[1.07 0.01 1.1 100 1.78];
p=p0;
LB=0.5*p0;
UB=1.5*p0;
[p_out1]=lsqcurvefit(@(p,Lam)e1(p,Lam),p0,Lam,eps1,LB,UB,options);
lam2 = (Lam/1000).^2;
epsilon1=p_out1(1)*lam2./(lam2 - p_out1(2))...
              +p_out1(3)*lam2./(lam2 - p_out1(4)) + p_out1(5);
epsilon3 = epsilon1-LBave;

for a = 1:length(Lam)
    [a1(a), ~] = GuessAlpha(Lam(a),MM4(:,:,a),MM5(:,:,a),epsilon1(a),epsilon3(a),d);
end

p0=[0.02 93];
p=p0;
LB=-0.5*p0;
UB=3*p0;
[p_out2]=lsqcurvefit(@(p,Lam)alpha(p,Lam),p0,Lam,a1,LB,UB,options);
lam2 = Lam.^2;
alpha1 = Lam.^3*(p_out2(1))./(lam2 - p_out2(2)^2).^2;

Env = CalcM23Envelope(Lam,MM4(2,3,:),d);
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
                     +1.10202242*lam2./(lam2 - 100) + 1.087604141;
       epsilon(2,:) = epsilon(1,:);
       epsilon(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
                     +1.15662475*lam2./(lam2 - 100) + 1.88851804;
lam2 = Lam.^2;
alphar(1,:) = Lam.^3*(-0.0198)./(lam2 - 93^2).^2;
alphar(3,:) = Lam.^3*(0.04)./(lam2 - 100^2).^2;

figure
plot(Lam,epsilon1,'red',Lam,epsilon3,'blue',Lam,epsilon(1,:),'black',Lam,epsilon(3,:),'black');
figure
plot(Lam,a1,'red',Lam,alpha3,'blue',Lam,alphar(1,:),'black',Lam,alphar(3,:),'black');
% lam2 = (Lam/1000).^2;
%        epsilon(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
%                      +1.10202242*lam2./(lam2 - 100) + 1.187604141;
%        epsilon(2,:) = epsilon(1,:);
%        epsilon(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
%                      +1.15662475*lam2./(lam2 - 100) + 1.68851804;
% figure
% plot(Lam,epsilon1,'green',Lam,epsilon3,'blue',Lam,epsilon(1,:),'black',Lam,epsilon(3,:),'black');








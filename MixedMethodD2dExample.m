%Dual Tranmission/Reflection and SVM/Procedural Method
%Choose a transpranet z-cut uniaixial D2d crystal
%Align sample normal to light
%Measure sample thickness
%Set AOI to 30 deg, and adjust azimuth so that LB' = 0
close all
clear all
Lam=linspace(400,800,400);
d=500000;
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'KDPfalse',d,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};
[MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
[MM3,C]=MMSpectrumPW2(layerArray,Lam,30,45,0,1,15,3,'green');
Ydata = CalculateD2dParameters(Lam,d,MM1,MM2,MM3);
tic
[epsilonG1,alphaG1] = MixedMethodD2d(Lam,d,Ydata,D2de1500,D2de3500);
toc
close all
lam2 = (Lam/1000).^2;
epsilon1 = (13.00522*lam2./(lam2 - 400))+(0.01008956./(lam2 - 0.0129426))+2.259276;
epsilon3 = (3.2279924*lam2./(lam2 - 400))+(0.008637494./(lam2 - 0.0122810))+2.62668;
plot(Lam,epsilonG1(1,:),'red',Lam,epsilon1,'black',Lam,epsilonG1(2,:),'blue',Lam,epsilon3,'black');
hold on

Lam=linspace(400,800,400);
d=600000;
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'KDPfalse3',d,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};
[MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
[MM3,C]=MMSpectrumPW2(layerArray,Lam,30,45,0,1,15,3,'green');
Ydata = CalculateD2dParameters(Lam,d,MM1,MM2,MM3);
tic
[epsilonG2,alphaG2] = MixedMethodD2d(Lam,d,Ydata,D2de1500,D2de3500);
toc
lam2 = (Lam/1000).^2;
epsilon1 = (13.00522*lam2./(lam2 - 400))+(0.01008956./(lam2 - 0.0129))+2.559276;
epsilon3 = (3.2279924*lam2./(lam2 - 5))+(0.008637494./(lam2 - 0.15))+1.632668+0.5*lam2;
plot(Lam,epsilonG2(1,:),'red',Lam,epsilon1,'black',Lam,epsilonG2(2,:),'blue',Lam,epsilon3,'black');

Lam=linspace(400,800,400);
d=500000;
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'KDPfalse4',d,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};
[MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
[MM3,C]=MMSpectrumPW2(layerArray,Lam,30,45,0,1,15,3,'green');
Ydata = CalculateD2dParameters(Lam,d,MM1,MM2,MM3);
tic
[epsilonG3,alphaG3] = MixedMethodD2d(Lam,d,Ydata,D2de1500,D2de3500);
toc
lam2 = (Lam/1000).^2;
epsilon1 = (13.00522*lam2./(lam2 - 400))+(0.01008956./(lam2 - 0.0129))+2.059276-.0001*Lam;
epsilon3 = (3.2279924*lam2./(lam2 - 5))+(0.008637494./(lam2 - 0.15))+1.932668+.0001*Lam;
plot(Lam,epsilonG3(1,:),'red',Lam,epsilon1,'black',Lam,epsilonG3(2,:),'blue',Lam,epsilon3,'black');



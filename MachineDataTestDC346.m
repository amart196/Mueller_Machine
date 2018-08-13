%221.496 um sample of TeO2
close all
clear all


[MM1,MMer,Lam]=read4PEM('atm-2-204-5.dat',1);
plotMMData4x4(Lam,0,MM1,23,'blue');
[MM2,MMer,Lam]=read4PEM('atm-2-204-4.dat',1);
plotMMData4x4(Lam,0,MM2,23,'blue');
[MM3,MMer,Lam]=read4PEM('atm-2-204-1_030.000.dat',1);
plotMMData4x4(Lam,0,MM3,23,'blue');
[MM4,MMer,Lam]=read4PEM('atm-2-204-1_000.000.dat',1);
plotMMData4x4(Lam,0,MM4,23,'blue');
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'TeO2_6',221459,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};%This set works well with the workspace V3(okay) for many thicknesses
[MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'black');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'black');
[MM3,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,15,3,'black');
[MM4,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'black');

tic
Ydata = CalculateDC346Parameters(Lam,221495,MM1,MM2,MM3,MM4);
[epsilonG1,alphaG1,alphaG3] = MixedMethodDC346(Lam,221495,Ydata,DC346e1Mixedv2,DC346e3Mixedv2,DC346a1Mixedv2,MM3);
epsilonG1n(:,:) = epsilonG1;
alphaG1n(:) = alphaG1;
lam2 = Lam.^2;
a3(:) = Lam.^3*(alphaG3)./(lam2 - 100^2).^2;
toc

lam2 = (Lam/1000).^2;
epsilon1 = 2.73406*lam2./(lam2 - 0.00800854) + 1.55*lam2./(lam2 - 0.0677717) + 0.371529;
epsilon3 = 3.23941*lam2./(lam2 - 0.0110181)+ 1.75363*lam2./(lam2 - 0.0702751) + 0.269395;
plot(Lam,epsilon1,'black',Lam,epsilon3,'black');
hold on
plot(Lam,squeeze(epsilonG1n(1,:)),'cyan',Lam,squeeze(epsilonG1n(2,:)),'red');
lam2 = Lam.^2;
alpha = Lam.^3*(-0.070739821065762)./(lam2 - 2.401813395633397e+02^2).^2;
plot(Lam,alpha,'black');
hold on
plot(Lam,alphaG1n(:),'g')
alpha3 = Lam.^3*(-0.044805638612383)./(lam2 - 2.799999750746757e+02^2).^2;
plot(Lam,alpha3,'black')
plot(Lam,a3(:),'red')

%Plot stuff for thesis
plotStuff_1 = {'ev',false,'LimY',0.1,...
    'plotNV',{'linewidth',3},...
    'fontsize',19,...
    'axNV',{'Xlim',[350,750],'fontname','arial'}};

handles = MMplot(Lam,MM1,'red',plotStuff_1{:});
hold on
MMplot(Lam,MM2,'cyan','handles',handles,plotStuff_1{:});
plotStuff_1 = {'ev',false,'LimY',0.1,...
    'plotNV',{'linewidth',2},...
    'fontsize',19,...
    'axNV',{'Xlim',[350,750],'fontname','arial'}};
MMplot(Lam,MM3,'blue','handles',handles,plotStuff_1{:});
MMplot(Lam,MM4,'green','handles',handles,plotStuff_1{:});




%Dual Tranmission/Reflection and SVM/Procedural Method
%Choose a transpranet z-cut uniaixial D2d crystal
%Align sample normal to light
%Measure sample thickness
%Set AOI to 30 deg, and adjust azimuth so that LB' = 0
close all
clear all
tic
Lam=linspace(400,800,400);
h=linspace(200000,500000,30);
for x = 1:length(h)
    layerArray{1}={'air',0,[0,0,0],1,1};
    layerArray{2}={'+quartzf5',h(x),[0,0,0],0,0};
    layerArray{3}={'air',0,[0,0,0],1,1};%This set works well with the workspace V3(okay) for many thicknesses
    [MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
    [MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
    [MM3,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,15,3,'green');
    [MM4,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'cyan');
    Ydata = CalculateDC346Parameters(Lam,h(x),MM1,MM2,MM3,MM4);
    [epsilonG1,alphaG1,alphaG3] = MixedMethodDC346(Lam,h(x),Ydata,DC346e1Mixed,DC346e3Mixed,DC346a1Mixed,MM3);
    epsilonG1n(x,:,:) = epsilonG1;
    alphaG1n(x,:) = alphaG1;
    lam2 = Lam.^2;
    a3(x,:) = Lam.^3*(alphaG3)./(lam2 - 100^2).^2;
end
toc
close all
lam2 = (Lam/1000).^2;
epsilon1 = 2.5+0*Lam;
epsilon3 = 2.7-(Lam-400)/1000;
plot(Lam,epsilon1,'black',Lam,epsilon3,'black');
hold on
for x = 1:length(h)
    plot(Lam,squeeze(epsilonG1n(x,1,:)),'m',Lam,squeeze(epsilonG1n(x,2,:)),'cyan');
    hold on
end
lam2 = Lam.^2;
alpha = Lam.^3*(0.0198)./(lam2 - 93^2).^2;
plot(Lam,alpha,'black');
hold on
for x = 1:length(h)
    plot(Lam,alphaG1n(x,:),'g')
    hold on
end
alpha3 = Lam.^3*(-.06)./(lam2 - 87^2).^2;
plot(Lam,alpha3,'black')
for x = 1:length(h)
    plot(Lam,a3(x,:),'red')
    hold on
end

%Second Example
h=linspace(200000,500000,50);
Lam=linspace(400,800,400);
for x = 1:length(h)
    layerArray{1}={'air',0,[0,0,0],1,1};
    layerArray{2}={'+quartzf4',h(x),[0,0,0],0,0};
    layerArray{3}={'air',0,[0,0,0],1,1};
    [MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
    [MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
    [MM3,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,15,3,'green');
    [MM4,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'green');
    Ydata = CalculateDC346Parameters(Lam,d,MM1,MM2,MM3,MM4);
    [epsilonG1,alphaG1] = MixedMethodDC346(Lam,d,Ydata,DC346e1,DC346e3,DC346a1);
    epsilonG1n(x,:,:) = epsilonG1;
    alphaG1n(x,:) = alphaG1;
end
close all
lam2 = (Lam/1000).^2;
epsilon3 = 2.55-(Lam-400)/3000;
% epsilon3 = 2.9+0.*Lam;
epsilon1 = 2.3+0.*Lam;
plot(Lam,epsilon1,'black',Lam,epsilon3,'black');
hold on
for x = 1:length(h)
    plot(Lam,squeeze(epsilonG1n(x,1,:)),'m',Lam,squeeze(epsilonG1n(x,2,:)),'c');
    hold on
end


%Third Example
h=linspace(200000,500000,50);
Lam=linspace(400,800,400);
for x = 1:length(h)
    layerArray{1}={'air',0,[0,0,0],1,1};
    layerArray{2}={'+quartzf5',h(x),[0,0,0],0,0};
    layerArray{3}={'air',0,[0,0,0],1,1};
    [MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
    [MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
    [MM3,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,15,3,'green');
    [MM4,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'green');
    Ydata = CalculateDC346Parameters(Lam,d,MM1,MM2,MM3,MM4);
    [epsilonG1,alphaG1] = MixedMethodDC346(Lam,d,Ydata,DC346e1,DC346e3,DC346a1);
    epsilonG1n(x,:,:) = epsilonG1;
    alphaG1n(x,:) = alphaG1;
end
close all
lam2 = (Lam/1000).^2;
epsilon3 = 2.7-(Lam-400)/1000;
% epsilon3 = 2.9+0.*Lam;
epsilon1 = 2.5+0.*Lam;
plot(Lam,epsilon1,'black',Lam,epsilon3,'black');
hold on
for x = 1:length(h)
    plot(Lam,squeeze(epsilonG1n(x,1,:)),'m',Lam,squeeze(epsilonG1n(x,2,:)),'c');
    hold on
end


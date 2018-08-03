%Choose a transparent z-cut uniaxial D2d crystal
%Align sample normal to light
%Measure the sample thickness
%Set AOI to 30 deg, and adjust azimuth so that LB' = 0
%Measure MM spectra at the following angles:
close all
clear all

% Lam=linspace(400,800,400);
% d=500000;
% layerArray{1}={'air',0,[0,0,0],1,1};
% layerArray{2}={'+quartz',d,[0,0,0],0,0};
% layerArray{3}={'air',0,[0,0,0],1,1};
% [MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
% [MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
% [MM3,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,15,3,'green');
% [MM4,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'green');

Lam=linspace(400,800,400);
d=500000;
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'+quartzf1',d,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};
[MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
[MM3,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,15,3,'green');
[MM4,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'green');
Ydata = CalculateDC346Parameters(Lam,d,MM1,MM2,MM3,MM4);
tic
[epsilonG1,alphaG1] = LearnDC346(Lam,d,Ydata,DC346e1,DC346e3,DC346a1,DC346a3);
toc
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'+quartzf2',d,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};
[MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
[MM3,C]=MMSpectrumPW2(layerArray,Lam,30,45,0,1,15,3,'green');
[MM4,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'green');
Ydata = CalculateDC346Parameters(Lam,d,MM1,MM2,MM3,MM4);
tic
[epsilonG2,alphaG2] = LearnDC346(Lam,d,Ydata,DC346e1,DC346e3,DC346a1,DC346a3);
toc
% layerArray{1}={'air',0,[0,0,0],1,1};
% layerArray{2}={'+quartzf3',d,[0,0,0],0,0};
% layerArray{3}={'air',0,[0,0,0],1,1};
% [MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
% [MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
% [MM3,C]=MMSpectrumPW2(layerArray,Lam,30,45,0,1,15,3,'green');
% Ydata = CalculateDC346Parameters(Lam,d,MM1,MM2,MM3,MM4);
% [epsilonG3,alphaG3] = LearnD2d(Lam,d,Ydata,D2de1,D2de3,D2da);
close all

k = length(Lam);
epsilon1 = ones(3,k);
epsilon2 = ones(3,k);
epsilon3 = ones(3,k);
lam2 = (Lam/1000).^2;
epsilon1(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
                     +1.10202242*lam2./(lam2 - 100) + 1.687604141;
epsilon1(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
                     +1.15662475*lam2./(lam2 - 100) + 1.18851804;
epsilon2(1,:) = 1.07044083*lam2./(lam2 - 0.0100585997)...
                     +1.10202242*lam2./(lam2 - 100) + 1.08604141+lam2;
epsilon2(3,:) = 1.09509924*lam2./(lam2 - 0.0102101864)...
                     +1.15662475*lam2./(lam2 - 100) + 1.48851804+lam2;
plot(Lam,epsilonG1(1,:),'green',Lam,epsilonG1(2,:),'red',Lam,epsilon1(1,:),'black',Lam,epsilon1(3,:),'black');
hold on
plot(Lam,epsilonG2(1,:),'yellow',Lam,epsilonG2(2,:),'cyan',Lam,epsilon2(1,:),'black',Lam,epsilon2(3,:),'black');
% hold on
% plot(Lam,epsilonG3(1,:),'red',Lam,epsilonG3(2,:),'green',Lam,epsilon3(1,:),'black',Lam,epsilon3(3,:),'black');
for a = 1:length(Lam)
    b=(epsilonG1(1,a)+epsilonG1(2,a)+epsilonG2(1,a)+epsilonG1(2,a))/4;
    SSres(a)=sum((epsilonG1(1,a)-epsilon1(1,a)).^2)+sum((epsilonG1(2,a)-epsilon1(3,a)).^2)+sum((epsilonG2(2,a)-epsilon2(3,a)).^2)+sum((epsilonG2(1,a)-epsilon2(1,a)).^2);
    SStot(a)=sum((epsilonG1(1,a)-b).^2)+sum((epsilonG1(2,a)-b).^2)+sum((epsilonG2(2,a)-b).^2)+sum((epsilonG2(1,a)-b).^2);
    R2(a)=1-SSres(a)/SStot(a);
end
R2= mean(R2);

lam2 = Lam.^2;
alpha = zeros(3,3,k);
alpha1 = Lam.^3*(-0.0198)./(lam2 - 93^2).^2;;
alpha2 =  Lam.^3*(0.0198)./(lam2 - 93^2).^2;
plot(Lam,alpha1,'black',Lam,alphaG1(1,:),'red',Lam,alpha2,'black',Lam,alphaG2(1,:),'blue');
hold on
plot(Lam,alpha1,'black',Lam,alpha2,'black');

for a = 1:length(Lam)
    b=(alphaG1(1,a)+alphaG2(1,a))/2;
    SSres(a)=sum((alphaG1(1,a)-alpha1(a)).^2)+sum((alphaG2(1,a)-alpha2(a)).^2);
    SStot(a)=sum((alphaG1(1,a)-b).^2)+sum((alphaG2(1,a)-b).^2);
    R2(a)=1-SSres(a)/SStot(a);
end
R2= mean(R2);
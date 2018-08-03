%Machine Learning Plotting
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

plotStuff_1 = {'ev',false,'LimY',0.1,...
    'plotNV',{'linewidth',3},...
    'fontsize',19,...
    'axNV',{'Xlim',[400,800],'fontname','arial'}};
handles = MMplot(Lam,MM1,'red',plotStuff_1{:});
hold on
MMplot(Lam,MM2,'blue','handles',handles,plotStuff_1{:});
MMplot(Lam,MM3,'green','handles',handles,plotStuff_1{:});


%Mixed Method Transmission
Lam=linspace(400,800,50);
d=300000;
th=d;
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'+quartzf1',d,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};
[MM1,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,5,3,'red');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,0,3,'red');
plotStuff_1 = {'ev',false,'LimY',0.1,...
    'plotNV',{'linewidth',3},...
    'fontsize',13,...
    'axNV',{'Xlim',[400,800],'fontname','arial'}};

handles = MMplot(Lam,MM1,'red',plotStuff_1{:});
hold on
MMplot(Lam,MM2,'blue','handles',handles,plotStuff_1{:});

%Mixed Method Transmission and Reflection
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'+quartzf5',200000,[0,0,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};%This set works well with the workspace V3(okay) for many thicknesses
[MM1,C]=MMSpectrumPW2(layerArray,Lam,56.3,0,1,1,15,3,'red');
[MM2,C]=MMSpectrumPW2(layerArray,Lam,36,0,1,1,15,3,'blue');
[MM3,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,15,3,'green');
[MM4,C]=MMSpectrumPW2(layerArray,Lam,0,0,0,1,15,3,'cyan');
plotStuff_1 = {'ev',false,'LimY',0.1,...
    'plotNV',{'linewidth',3},...
    'fontsize',13,...
    'axNV',{'Xlim',[400,800],'fontname','arial'}};

handles = MMplot(Lam,MM1,'red',plotStuff_1{:});
hold on
MMplot(Lam,MM2,'blue','handles',handles,plotStuff_1{:});
MMplot(Lam,MM3,'green','handles',handles,plotStuff_1{:});
MMplot(Lam,MM4,'cyan','handles',handles,plotStuff_1{:});




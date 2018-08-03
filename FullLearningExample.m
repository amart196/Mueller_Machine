%Choose a transparent z-cut unixial crytal with ~10 deg miscut
%Align sample normal to light
%Set AOI to 30 degrees, and adjust azimuth so that LB'=0.
%Measure MM spectra at AOI = 20 deg and AOI = 30 deg

Lam=linspace(400,600,1000);
th=500000;
layerArray{1}={'air',0,[0,0,0],1,1};
layerArray{2}={'+quartzf2',th,[0,-6,0],0,0};
layerArray{3}={'air',0,[0,0,0],1,1};
[Sim1,C]=MMSpectrumPW2(layerArray,Lam,30,0,0,1,0,3,'red');
close all

%Solve Epsilon 11

Data=zeros(15,length(Lam));
for s = 1:length(Lam)
    Data(1:3,s)=Sim1(1,2:4,s);
    Data(4:7,s)=Sim1(2,1:4,s);
    Data(8:11,s)=Sim1(3,1:4,s);
    Data(12:15,s)=Sim1(4,1:4,s);
end
Data=Data'
ratio=th./Lam;
eps1=zeros(length(Lam),1);

tic
for b = 1:length(Lam);
    if (1275 >= ratio(b)) && (ratio(b) >= 1225)
         [eps1(b),acc,decV] = svmpredict(2.5, Data(b,:), e111250, ['libsvm_options']);
    elseif (1225 >= ratio(b)) && (ratio(b) >= 1175)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e111200, ['libsvm_options']); 
    elseif (1175 >= ratio(b)) && (ratio(b) >= 1125)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e111150, ['libsvm_options']); 
    elseif (1125 >= ratio(b)) && (ratio(b) >= 1075)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e111100, ['libsvm_options']); 
    elseif (1075 >= ratio(b)) && (ratio(b) >= 1025)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e111050, ['libsvm_options']); 
    elseif (1025 >= ratio(b)) && (ratio(b) >= 975)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']);       
    elseif (975 >= ratio(b)) && (ratio(b) >= 925)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']);      
    elseif (925 >= ratio(b)) && (ratio(b) >= 875)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']); 
    elseif (875 >= ratio(b)) && (ratio(b) >= 825)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']); 
    elseif (825 >= ratio(b)) && (ratio(b) >= 775) 
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']);
    else 
  
       eps1(b)=0;
    end
end

plot(Lam,eps1,'red')
hold on

%Solve E33
for b = 1:length(Lam);
    if (1275 >= ratio(b)) && (ratio(b) >= 1225)
         [eps1(b),acc,decV] = svmpredict(2.5, Data(b,:), e111250, ['libsvm_options']);
    elseif (1225 >= ratio(b)) && (ratio(b) >= 1175)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e111200, ['libsvm_options']); 
    elseif (1175 >= ratio(b)) && (ratio(b) >= 1125)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e111150, ['libsvm_options']); 
    elseif (1125 >= ratio(b)) && (ratio(b) >= 1075)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e111100, ['libsvm_options']); 
    elseif (1075 >= ratio(b)) && (ratio(b) >= 1025)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e111050, ['libsvm_options']); 
    elseif (1025 >= ratio(b)) && (ratio(b) >= 975)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']);       
    elseif (975 >= ratio(b)) && (ratio(b) >= 925)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']);      
    elseif (925 >= ratio(b)) && (ratio(b) >= 875)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']); 
    elseif (875 >= ratio(b)) && (ratio(b) >= 825)
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']); 
    elseif (825 >= ratio(b)) && (ratio(b) >= 775) 
         [eps1(b),acc,decV] = svmpredict(rand(1), Data(b,:), e11800, ['libsvm_options']);
    else 
  
       eps1(b)=0;
    end
end

plot(Lam,eps1,'red')
hold on

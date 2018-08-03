function [epsilon,alpha]=LearnD2d(Lam,d,Ydata,D2de1,D2de3,D2da);

for x = 1:length(Lam)
    [epsilon(1,x),acc,decV] = svmpredict(.2,Ydata(x,:),D2de1, ['libsvm_options']);
    [epsilon(2,x),acc,decV] = svmpredict(.2,Ydata(x,:),D2de3, ['libsvm_options']);
    [alpha(x),acc,decV] = svmpredict(.2,Ydata(x,:),D2da, ['libsvm_options']);
end
alpha=alpha/10000;
end